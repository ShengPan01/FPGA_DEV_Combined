
#include "reg_acc.h"

//0x8000_0040 ~ 0x8003_FFFF 8-bit external registers access address
//0x8004_0000 ~ 0x8104_0000 32-bit external registers access address


/********************************************************************/
// Base address of DP PHY registers         0x8000_0100
// Base address of video BIST registers     0x8000_0200
// Base address of DP130 registers          0x8000_0800

//Base address of DP TX CO3 registers
// i2c slave address 0x72:              0x8000_0100
// i2c slave address 0x70:              0x8000_0200
// i2c slave address 0x7A:              0x8000_0300


//Base address of LMK04906 registers    0x8000_0040
//#define LMK04906_REG_BASE (0x80000000 + AL32(0x10))
//#define LMK04906_CTRL     LMK04906_REG_BASE+AL32(0) //0x8000_0040
//#define LMK04906_WR_DATA0 LMK04906_REG_BASE+AL32(1) //0x8000_0044
//#define LMK04906_WR_DATA1 LMK04906_REG_BASE+AL32(2) //0x8000_0048
//#define LMK04906_WR_DATA2 LMK04906_REG_BASE+AL32(3) //0x8000_004C
//#define LMK04906_WR_DATA3 LMK04906_REG_BASE+AL32(4) //0x8000_0050
//#define LMK04906_RD_DATA0 LMK04906_REG_BASE+AL32(5) //0x8000_0054
//#define LMK04906_RD_DATA1 LMK04906_REG_BASE+AL32(6) //0x8000_0058
//#define LMK04906_RD_DATA2 LMK04906_REG_BASE+AL32(7) //0x8000_005C
//#define LMK04906_RD_DATA3 LMK04906_REG_BASE+AL32(8) //0x8000_0060


//Base address of Clock Measure registers    0x8000_0280
//#define CLK_MEA_REG_BASE (0x80000000 + AL32(0xa0))
//#define CLK_FREQ_GATE0_ADDR     CLK_MEA_REG_BASE + AL32(0x0) //0x8000_0280
//#define CLK_FREQ_GATE1_ADDR     CLK_MEA_REG_BASE + AL32(0x1) //0x8000_0284
//#define CLK0_FREQ0_ADDR         CLK_MEA_REG_BASE + AL32(0x2) //0x8000_0288
//#define CLK0_FREQ1_ADDR         CLK_MEA_REG_BASE + AL32(0x3) //0x8000_028C
//#define CLK1_FREQ0_ADDR         CLK_MEA_REG_BASE + AL32(0x4) //0x8000_0290
//#define CLK1_FREQ1_ADDR         CLK_MEA_REG_BASE + AL32(0x5) //0x8000_0294
//#define CLK2_FREQ0_ADDR         CLK_MEA_REG_BASE + AL32(0x6) //0x8000_0298
//#define CLK2_FREQ1_ADDR         CLK_MEA_REG_BASE + AL32(0x7) //0x8000_029C
//#define CLK3_FREQ0_ADDR         CLK_MEA_REG_BASE + AL32(0x8) //0x8000_02A0
//#define CLK3_FREQ1_ADDR         CLK_MEA_REG_BASE + AL32(0x9) //0x8000_02A4

/********************************************************************/


//axi bridge address : 0x8000_0010 ~ 0x8000_001F
//img gen address : 0x8000_0020 ~ 0x8000_002F
//video crop address : 0x8000_0030 ~ 0x8000_003F
//clock measure address : 0x8000_0040 ~ 0x8000_004F
//spi address : 0x8000_0050 ~ 0x8000_005F
//video expand address : 0x8000_0060 ~ 0x8000_006F
//imu i2c address : 0x8000_0070 ~ 0x8000_007F

//vbist address : 0x8000_8000 ~ 0x8000_9FFF
//vid merge address : 0x8000_A000 ~ 0x8000_BFFF
//dp phy address : 0x8000_8000 ~ 0x8000_BFFF
//dptx0 address : 0x8000_0200 ~ 0x8000_02FF
//dptx1 address : 0x8000_0300 ~ 0x8000_03FF
//dptx2 address : 0x8000_0400 ~ 0x8000_04FF
//spi buf address : 0x8000_0800 ~ 0x8000_0FFF
//vr proc address : 0x8000_1000 ~ 0x8000_1FFF


//    casez (bk3_mcum_addr)
//    16'h001?: begin bk3_mcum_rdata_1 = axi_brdg_mcus_rdata; axi_brdg_mcus_sel = 1'b1; end
//    16'h002?: begin bk3_mcum_rdata_1 = img_gen_mcus_rdata; img_gen_mcus_sel = 1'b1; end
//    16'h003?: begin bk3_mcum_rdata_1 = video_crop_mcus_rdata; video_crop_mcus_sel = 1'b1; end
//    16'h004?: begin bk3_mcum_rdata_1 = clk_measure_mcus_rdata; clk_measure_mcus_sel = 1'b1; end
//    16'h005?: begin bk3_mcum_rdata_1 = spi_mcus_rdata; spi_mcus_sel = 1'b1; end
//    16'h006?: begin bk3_mcum_rdata_1 = video_expnd_mcus_rdata; video_expnd_mcus_sel = 1'b1; end
//    16'h007?: begin bk3_mcum_rdata_1 = imu_i2c_mcus_rdata; imu_i2c_mcus_sel = 1'b1; end
//    16'b100?_????: begin bk3_mcum_rdata_1 = vbist_mcus_rdata; vbist_mcus_sel = 1'b1; end
//    16'b101?_????: begin bk3_mcum_rdata_1 = vid_merge_mcus_rdata; vid_merge_mcus_sel = 1'b1; end
//    16'b1_0???_????: begin bk3_mcum_rdata_1 = dp_phy_mcus_rdata; dp_phy_mcus_sel = 1'b1; end
//    16'h02??: begin bk3_mcum_rdata_1 = dptx0_mcus_rdata; dptx0_mcus_sel = 1'b1; end
//    16'h03??: begin bk3_mcum_rdata_1 = dptx1_mcus_rdata; dptx1_mcus_sel = 1'b1; end
//    16'h04??: begin bk3_mcum_rdata_1 = dptx2_mcus_rdata; dptx2_mcus_sel = 1'b1; end
//    16'b0000_1???_????_????: begin bk3_mcum_rdata_1 = spi_buf_mcus_rdata; spi_buf_mcus_sel = 1'b1; end
//    16'h1???: begin bk3_mcum_rdata_1 = vr_proc_mcus_rdata; vr_proc_mcus_sel = 1'b1; end
//    default: bk3_mcum_rdata_1 = 8'h0;
