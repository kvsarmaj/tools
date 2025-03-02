//******************************************************************************
//
// File: fifo.sv
// Author: K V Sarma Jonnavithula
// Description: A simple synchronous FIFO with
//               - parameterized data type
//                  - when overriden at instantiation time, width is ignored
//               - parameterized depth
//               - count output
//               - full and empty flags
//               - Assuming asynchronous reset
//
//******************************************************************************

module fifo
    #(
      parameter      WIDTH = 32,
      parameter      DEPTH = 16,
      parameter type DATA_TYPE_t = logic [WIDTH-1:0],
      localparam     ADDR_WIDTH = $clog2(DEPTH),
      )
    (
     input logic                    i_clock,
     input logic                    i_reset_n,

     input logic                    i_fifo_push,
     input DATA_TYPE_t              i_fifo_data_in,

     input logic                    i_fifo_pop,
     output DATA_TYPE_t             o_fifo_data_out,

     output logic [ADDR_WIDTH-1:0]  o_fifo_count,
     output logic                   o_fifo_empty,
     output logic                   o_fifo_full

     );

    localparam ADDR_WIDTH = COUNT_WIDTH;

    logic [ADDR_WIDTH-1:0] fifo_wr_ptr;
    logic [ADDR_WIDTH-1:0] fifo_rd_ptr;
    DATA_TYPE_t            fifo_mem [DEPTH-1:0];


    // Memory Core
    always_ff@(posedge i_clock or negedge i_reset_n)
    begin: r_fifo_mem
        if(~i_reset_n)
        begin
            for(int i=0;i<DEPTH;i=i+1)
            begin: l_fifo_mem_reset
                fifo_mem[i] <= '{default: '0};
            end
        end // if (~i_reset_n)
        else if(i_fifo_push)
            fifo_mem[wr_ptr] <= i_fifo_data_in;
    end // block: r_fifo_mem

    // Write pointer
    always_ff@(posedge i_clock or negedge i_reset_n)
    begin: r_fifo_wr_ptr
        if(~i_reset_n)
            fifo_wr_ptr <= {ADDR_WIDTH{1'b0}};
        else
        begin
            if(i_fifo_push)
            begin
                if(fifo_wr_ptr == DEPTH-1)
                    fifo_wr_ptr <= {ADDR_WIDTH{1'b0}};
                else
                    fifo_wr_ptr <= fifo_wr_ptr + 1'b1;
            end // if (i_fifo_push)
        end // else: !if(~i_reset_n)
    end // block: r_fifo_wr_ptr

    // Read pointer
    always_ff@(posedge i_clock or negedge i_reset_n)
    begin: r_fifo_rd_ptr
        if(~i_reset_n)
            fifo_rd_ptr <= {ADDR_WIDTH{1'b0}};
        else
        begin
            if(i_fifo_pop)
            begin
                if(fifo_rd_ptr == DEPTH-1)
                    fifo_rd_ptr <= {ADDR_WIDTH{1'b0}};
                else
                    fifo_rd_ptr <= fifo_rd_ptr + 1'b1;
            end // if (i_fifo_push)
        end // else: !if(~i_reset_n)
    end // block: r_fifo_wr_ptr


    // Count
    always_ff@(posedge i_clock or negedge i_reset_n)
    begin: r_fifo_rd_ptr
        if(~i_reset_n)
            o_fifo_count <= {ADDR_WIDTH{1'b0}};
        else
        begin
            if(i_fifo_push & ~i_fifo_pop)
                o_fifo_count <= o_fifo_count + 1'b1;
            else if(~i_fifo_push & i_fifo_pop)
                o_fifo_count <= o_fifo_count - 1'b1;
        end // else: !if(~i_reset_n)
    end // block: r_fifo_rd_ptr

    // Flags
    assign o_fifo_empty    = (fifo_count == {ADDR_WIDTH{1'b0}});
    assign o_fifo_full     = (fifo_count == DEPTH-1);


    // Pop data
    assign o_fifo_data_out = fifo_mem[rd_ptr];

endmodule // fifo
