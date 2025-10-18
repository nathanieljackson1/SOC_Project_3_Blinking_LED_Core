module nj_ledblink_tb;
   parameter W = 16;
   logic clk;
   logic reset;
   // slot interface
   logic cs;
   logic read;
   logic write;
   logic [4:0] addr;
   logic [31:0] wr_data;
   logic [31:0] rd_data;
    // external port    
   logic [W-1:0] dout; 

nj_ledblink #(.W(W)) dut (
    .clk(clk),
    .reset(reset),
    // slot interface
    .cs(cs),
    .read(read),
    .write(write),
    .addr(addr),
    .wr_data(wr_data),
    .rd_data(rd_data),
    // external port    
    .dout(dout)
    ); 
    
    defparam dut.myled_blink0.myms_counter.MAXCOUNT = 99;
    defparam dut.myled_blink1.myms_counter.MAXCOUNT = 99;
    defparam dut.myled_blink2.myms_counter.MAXCOUNT = 99;
    defparam dut.myled_blink3.myms_counter.MAXCOUNT = 99;
    
    task automatic mmio_write(input [4:0] waddr, input [31:0] data);
      begin
        @(negedge clk);
        cs      = 1'b1;
        write   = 1'b1;
        read    = 1'b0;
        addr    = waddr;
        wr_data = data;
        @(negedge clk);
        cs      = 1'b0;
        write   = 1'b0;
        wr_data = '0;
      end
    endtask
    
    initial begin // sets up input clock signal
        clk = 0;
        forever
            #5 clk=~clk;
    end

    initial begin
        cs = 0; 
        read = 0; 
        write = 0; 
        addr = 0; 
        wr_data = 0;
        
        reset = 1'b1;
        repeat (5) @(negedge clk);
        reset = 1'b0;
        repeat (5) @(negedge clk);
        
        mmio_write(5'd0, 32'd50);    // IV0
        mmio_write(5'd1, 32'd80);    // IV1
        mmio_write(5'd2, 32'd120);   // IV2
        mmio_write(5'd3, 32'd200);   // IV3
        
        #(2_500_000);
        
        mmio_write(5'd0, 32'd200);
        mmio_write(5'd1, 32'd120);
        mmio_write(5'd2, 32'd80);
        mmio_write(5'd3, 32'd50);
        
        #(2_500_000);        
        
        mmio_write(5'd1, 32'd0);
        mmio_write(5'd3, 32'd0);

        #(2_000_000);
        $finish;
    end

endmodule
