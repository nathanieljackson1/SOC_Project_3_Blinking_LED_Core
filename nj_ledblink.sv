`timescale 1ns / 1ps

module nj_ledblink
   #(parameter W = 8)  // width of output port
   (
    input  logic clk,
    input  logic reset,
    // slot interface
    input  logic cs,
    input  logic read,
    input  logic write,
    input  logic [4:0] addr,
    input  logic [31:0] wr_data,
    output logic [31:0] rd_data,
    // external port    
    output logic [W-1:0] dout
   ); 
   
   // declaration
   logic [15:0] interval0;
   logic [15:0] interval1;
   logic [15:0] interval2;
   logic [15:0] interval3;
   logic wr_en0, wr_en1, wr_en2, wr_en3;

   // body 
   // interval registers 
   always_ff @(posedge clk, posedge reset)
      if (reset) begin
         interval0 <= 0;
         interval1 <= 0;
         interval2 <= 0;
         interval3 <= 0;
      end
      else begin  
         if (wr_en0) begin
            interval0 <= wr_data[15:0];
         end
         else if (wr_en1) begin
            interval1 <= wr_data[15:0];
         end
         else if (wr_en2) begin
            interval2 <= wr_data[15:0];
         end
         else if (wr_en3) begin
            interval3 <= wr_data[15:0];
         end         
      end
   // decoding logic 
   assign wr_en0 = cs && write && (addr==5'b00000);
   assign wr_en1 = cs && write && (addr==5'b00001);
   assign wr_en2 = cs && write && (addr==5'b00010);
   assign wr_en3 = cs && write && (addr==5'b00011);   
   // slot read interface
   assign rd_data =  0;
   // external output  
   assign dout[W-1:4] = 0;
   
   led_blink myled_blink0(
    .clk(clk),
    .rst(reset),
    .interval(interval0),
    .led(dout[0])
    );
    
   led_blink myled_blink1(
    .clk(clk),
    .rst(reset),
    .interval(interval1),
    .led(dout[1])
    );    
    
   led_blink myled_blink2(
    .clk(clk),
    .rst(reset),
    .interval(interval2),
    .led(dout[2])
    );
    
   led_blink myled_blink3(
    .clk(clk),
    .rst(reset),
    .interval(interval3),
    .led(dout[3])
    );
   
endmodule
