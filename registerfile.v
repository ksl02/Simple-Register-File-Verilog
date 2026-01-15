//register file:
//input regs Ra,Rb, and Rw.
//example: add Rw, Ra, Rb

module RegisterFile (
    input wire clk,
    input wire rst,
    input wire [4:0] Ra,
    input wire [4:0] Rb,
    input wire [4:0] Rw,
    input wire [15:0] busW,
    input wire WrEn,
    
    output wire [15:0] busA,
    output wire [15:0] busB
);

    reg [15:0] registers [31:0];
    integer i;
    
    assign busA = WrEn ? (Rw == Ra ? busW : registers[Ra]) : registers[Ra];
    assign busB = WrEn ? (Rw == Rb ? busW : registers[Rb]) : registers[Rb];

    always @(posedge clk or posedge rst) begin
        if(rst) begin
           for(i = 0; i < 32; i = i + 1) begin : reset
                registers[i] <= 0;
            end
        end
        else begin
            if(WrEn) begin
                registers[Rw] <= busW;
            end
        end
    end

endmodule