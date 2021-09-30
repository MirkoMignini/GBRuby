OPCODES = {
  0x00 => {
    method: :nop,
    cycles: [4]
  },
  0x01 => {
    method: :ld_bc_d16,
    cycles: [12]
  },
  0x02 => {
    method: :ld_a_bc_a,
    cycles: [8]
  },
  0x03 => {
    method: :inc_bc,
    cycles: [8]
  },
  0x04 => {
    method: :inc_b,
    cycles: [4]
  },
  0x05 => {
    method: :dec_b,
    cycles: [4]
  },
  0x06 => {
    method: :ld_b_d8,
    cycles: [8]
  },
  0x07 => {
    method: :rlca,
    cycles: [4]
  },
  0x08 => {
    method: :ld_a_a16_sp,
    cycles: [20]
  },
  0x09 => {
    method: :add_hl_bc,
    cycles: [8]
  },
  0x0a => {
    method: :ld_a_a_bc,
    cycles: [8]
  },
  0x0b => {
    method: :dec_bc,
    cycles: [8]
  },
  0x0c => {
    method: :inc_c,
    cycles: [4]
  },
  0x0d => {
    method: :dec_c,
    cycles: [4]
  },
  0x0e => {
    method: :ld_c_d8,
    cycles: [8]
  },
  0x0f => {
    method: :rrca,
    cycles: [4]
  },
  0x10 => {
    method: :stop_0,
    cycles: [4]
  },
  0x11 => {
    method: :ld_de_d16,
    cycles: [12]
  },
  0x12 => {
    method: :ld_a_de_a,
    cycles: [8]
  },
  0x13 => {
    method: :inc_de,
    cycles: [8]
  },
  0x14 => {
    method: :inc_d,
    cycles: [4]
  },
  0x15 => {
    method: :dec_d,
    cycles: [4]
  },
  0x16 => {
    method: :ld_d_d8,
    cycles: [8]
  },
  0x17 => {
    method: :rla,
    cycles: [4]
  },
  0x18 => {
    method: :jr_r8,
    cycles: [12]
  },
  0x19 => {
    method: :add_hl_de,
    cycles: [8]
  },
  0x1a => {
    method: :ld_a_a_de,
    cycles: [8]
  },
  0x1b => {
    method: :dec_de,
    cycles: [8]
  },
  0x1c => {
    method: :inc_e,
    cycles: [4]
  },
  0x1d => {
    method: :dec_e,
    cycles: [4]
  },
  0x1e => {
    method: :ld_e_d8,
    cycles: [8]
  },
  0x1f => {
    method: :rra,
    cycles: [4]
  },
  0x20 => {
    method: :jr_nz_r8,
    cycles: [12, 8]
  },
  0x21 => {
    method: :ld_hl_d16,
    cycles: [12]
  },
  0x22 => {
    method: :ldi_a_hl_a,
    cycles: [8]
  },
  0x23 => {
    method: :inc_hl,
    cycles: [8]
  },
  0x24 => {
    method: :inc_h,
    cycles: [4]
  },
  0x25 => {
    method: :dec_h,
    cycles: [4]
  },
  0x26 => {
    method: :ld_h_d8,
    cycles: [8]
  },
  0x27 => {
    method: :daa,
    cycles: [4]
  },
  0x28 => {
    method: :jr_z_r8,
    cycles: [12, 8]
  },
  0x29 => {
    method: :add_hl_hl,
    cycles: [8]
  },
  0x2a => {
    method: :ldi_a_a_hl,
    cycles: [8]
  },
  0x2b => {
    method: :dec_hl,
    cycles: [8]
  },
  0x2c => {
    method: :inc_l,
    cycles: [4]
  },
  0x2d => {
    method: :dec_l,
    cycles: [4]
  },
  0x2e => {
    method: :ld_l_d8,
    cycles: [8]
  },
  0x2f => {
    method: :cpl,
    cycles: [4]
  },
  0x30 => {
    method: :jr_nc_r8,
    cycles: [12, 8]
  },
  0x31 => {
    method: :ld_sp_d16,
    cycles: [12]
  },
  0x32 => {
    method: :ldd_a_hl_a,
    cycles: [8]
  },
  0x33 => {
    method: :inc_sp,
    cycles: [8]
  },
  0x34 => {
    method: :inc_a_hl,
    cycles: [12]
  },
  0x35 => {
    method: :dec_a_hl,
    cycles: [12]
  },
  0x36 => {
    method: :ld_a_hl_d8,
    cycles: [12]
  },
  0x37 => {
    method: :scf,
    cycles: [4]
  },
  0x38 => {
    method: :jr_c_r8,
    cycles: [12, 8]
  },
  0x39 => {
    method: :add_hl_sp,
    cycles: [8]
  },
  0x3a => {
    method: :ldd_a_a_hl,
    cycles: [8]
  },
  0x3b => {
    method: :dec_sp,
    cycles: [8]
  },
  0x3c => {
    method: :inc_a,
    cycles: [4]
  },
  0x3d => {
    method: :dec_a,
    cycles: [4]
  },
  0x3e => {
    method: :ld_a_d8,
    cycles: [8]
  },
  0x3f => {
    method: :ccf,
    cycles: [4]
  },
  0x40 => {
    method: :ld_b_b,
    cycles: [4]
  },
  0x41 => {
    method: :ld_b_c,
    cycles: [4]
  },
  0x42 => {
    method: :ld_b_d,
    cycles: [4]
  },
  0x43 => {
    method: :ld_b_e,
    cycles: [4]
  },
  0x44 => {
    method: :ld_b_h,
    cycles: [4]
  },
  0x45 => {
    method: :ld_b_l,
    cycles: [4]
  },
  0x46 => {
    method: :ld_b_a_hl,
    cycles: [8]
  },
  0x47 => {
    method: :ld_b_a,
    cycles: [4]
  },
  0x48 => {
    method: :ld_c_b,
    cycles: [4]
  },
  0x49 => {
    method: :ld_c_c,
    cycles: [4]
  },
  0x4a => {
    method: :ld_c_d,
    cycles: [4]
  },
  0x4b => {
    method: :ld_c_e,
    cycles: [4]
  },
  0x4c => {
    method: :ld_c_h,
    cycles: [4]
  },
  0x4d => {
    method: :ld_c_l,
    cycles: [4]
  },
  0x4e => {
    method: :ld_c_a_hl,
    cycles: [8]
  },
  0x4f => {
    method: :ld_c_a,
    cycles: [4]
  },
  0x50 => {
    method: :ld_d_b,
    cycles: [4]
  },
  0x51 => {
    method: :ld_d_c,
    cycles: [4]
  },
  0x52 => {
    method: :ld_d_d,
    cycles: [4]
  },
  0x53 => {
    method: :ld_d_e,
    cycles: [4]
  },
  0x54 => {
    method: :ld_d_h,
    cycles: [4]
  },
  0x55 => {
    method: :ld_d_l,
    cycles: [4]
  },
  0x56 => {
    method: :ld_d_a_hl,
    cycles: [8]
  },
  0x57 => {
    method: :ld_d_a,
    cycles: [4]
  },
  0x58 => {
    method: :ld_e_b,
    cycles: [4]
  },
  0x59 => {
    method: :ld_e_c,
    cycles: [4]
  },
  0x5a => {
    method: :ld_e_d,
    cycles: [4]
  },
  0x5b => {
    method: :ld_e_e,
    cycles: [4]
  },
  0x5c => {
    method: :ld_e_h,
    cycles: [4]
  },
  0x5d => {
    method: :ld_e_l,
    cycles: [4]
  },
  0x5e => {
    method: :ld_e_a_hl,
    cycles: [8]
  },
  0x5f => {
    method: :ld_e_a,
    cycles: [4]
  },
  0x60 => {
    method: :ld_h_b,
    cycles: [4]
  },
  0x61 => {
    method: :ld_h_c,
    cycles: [4]
  },
  0x62 => {
    method: :ld_h_d,
    cycles: [4]
  },
  0x63 => {
    method: :ld_h_e,
    cycles: [4]
  },
  0x64 => {
    method: :ld_h_h,
    cycles: [4]
  },
  0x65 => {
    method: :ld_h_l,
    cycles: [4]
  },
  0x66 => {
    method: :ld_h_a_hl,
    cycles: [8]
  },
  0x67 => {
    method: :ld_h_a,
    cycles: [4]
  },
  0x68 => {
    method: :ld_l_b,
    cycles: [4]
  },
  0x69 => {
    method: :ld_l_c,
    cycles: [4]
  },
  0x6a => {
    method: :ld_l_d,
    cycles: [4]
  },
  0x6b => {
    method: :ld_l_e,
    cycles: [4]
  },
  0x6c => {
    method: :ld_l_h,
    cycles: [4]
  },
  0x6d => {
    method: :ld_l_l,
    cycles: [4]
  },
  0x6e => {
    method: :ld_l_a_hl,
    cycles: [8]
  },
  0x6f => {
    method: :ld_l_a,
    cycles: [4]
  },
  0x70 => {
    method: :ld_a_hl_b,
    cycles: [8]
  },
  0x71 => {
    method: :ld_a_hl_c,
    cycles: [8]
  },
  0x72 => {
    method: :ld_a_hl_d,
    cycles: [8]
  },
  0x73 => {
    method: :ld_a_hl_e,
    cycles: [8]
  },
  0x74 => {
    method: :ld_a_hl_h,
    cycles: [8]
  },
  0x75 => {
    method: :ld_a_hl_l,
    cycles: [8]
  },
  0x76 => {
    method: :halt,
    cycles: [4]
  },
  0x77 => {
    method: :ld_a_hl_a,
    cycles: [8]
  },
  0x78 => {
    method: :ld_a_b,
    cycles: [4]
  },
  0x79 => {
    method: :ld_a_c,
    cycles: [4]
  },
  0x7a => {
    method: :ld_a_d,
    cycles: [4]
  },
  0x7b => {
    method: :ld_a_e,
    cycles: [4]
  },
  0x7c => {
    method: :ld_a_h,
    cycles: [4]
  },
  0x7d => {
    method: :ld_a_l,
    cycles: [4]
  },
  0x7e => {
    method: :ld_a_a_hl,
    cycles: [8]
  },
  0x7f => {
    method: :ld_a_a,
    cycles: [4]
  },
  0x80 => {
    method: :add_a_b,
    cycles: [4]
  },
  0x81 => {
    method: :add_a_c,
    cycles: [4]
  },
  0x82 => {
    method: :add_a_d,
    cycles: [4]
  },
  0x83 => {
    method: :add_a_e,
    cycles: [4]
  },
  0x84 => {
    method: :add_a_h,
    cycles: [4]
  },
  0x85 => {
    method: :add_a_l,
    cycles: [4]
  },
  0x86 => {
    method: :add_a_a_hl,
    cycles: [8]
  },
  0x87 => {
    method: :add_a_a,
    cycles: [4]
  },
  0x88 => {
    method: :adc_a_b,
    cycles: [4]
  },
  0x89 => {
    method: :adc_a_c,
    cycles: [4]
  },
  0x8a => {
    method: :adc_a_d,
    cycles: [4]
  },
  0x8b => {
    method: :adc_a_e,
    cycles: [4]
  },
  0x8c => {
    method: :adc_a_h,
    cycles: [4]
  },
  0x8d => {
    method: :adc_a_l,
    cycles: [4]
  },
  0x8e => {
    method: :adc_a_a_hl,
    cycles: [8]
  },
  0x8f => {
    method: :adc_a_a,
    cycles: [4]
  },
  0x90 => {
    method: :sub_b,
    cycles: [4]
  },
  0x91 => {
    method: :sub_c,
    cycles: [4]
  },
  0x92 => {
    method: :sub_d,
    cycles: [4]
  },
  0x93 => {
    method: :sub_e,
    cycles: [4]
  },
  0x94 => {
    method: :sub_h,
    cycles: [4]
  },
  0x95 => {
    method: :sub_l,
    cycles: [4]
  },
  0x96 => {
    method: :sub_a_hl,
    cycles: [8]
  },
  0x97 => {
    method: :sub_a,
    cycles: [4]
  },
  0x98 => {
    method: :sbc_a_b,
    cycles: [4]
  },
  0x99 => {
    method: :sbc_a_c,
    cycles: [4]
  },
  0x9a => {
    method: :sbc_a_d,
    cycles: [4]
  },
  0x9b => {
    method: :sbc_a_e,
    cycles: [4]
  },
  0x9c => {
    method: :sbc_a_h,
    cycles: [4]
  },
  0x9d => {
    method: :sbc_a_l,
    cycles: [4]
  },
  0x9e => {
    method: :sbc_a_a_hl,
    cycles: [8]
  },
  0x9f => {
    method: :sbc_a_a,
    cycles: [4]
  },
  0xa0 => {
    method: :and_b,
    cycles: [4]
  },
  0xa1 => {
    method: :and_c,
    cycles: [4]
  },
  0xa2 => {
    method: :and_d,
    cycles: [4]
  },
  0xa3 => {
    method: :and_e,
    cycles: [4]
  },
  0xa4 => {
    method: :and_h,
    cycles: [4]
  },
  0xa5 => {
    method: :and_l,
    cycles: [4]
  },
  0xa6 => {
    method: :and_a_hl,
    cycles: [8]
  },
  0xa7 => {
    method: :and_a,
    cycles: [4]
  },
  0xa8 => {
    method: :xor_b,
    cycles: [4]
  },
  0xa9 => {
    method: :xor_c,
    cycles: [4]
  },
  0xaa => {
    method: :xor_d,
    cycles: [4]
  },
  0xab => {
    method: :xor_e,
    cycles: [4]
  },
  0xac => {
    method: :xor_h,
    cycles: [4]
  },
  0xad => {
    method: :xor_l,
    cycles: [4]
  },
  0xae => {
    method: :xor_a_hl,
    cycles: [8]
  },
  0xaf => {
    method: :xor_a,
    cycles: [4]
  },
  0xb0 => {
    method: :or_b,
    cycles: [4]
  },
  0xb1 => {
    method: :or_c,
    cycles: [4]
  },
  0xb2 => {
    method: :or_d,
    cycles: [4]
  },
  0xb3 => {
    method: :or_e,
    cycles: [4]
  },
  0xb4 => {
    method: :or_h,
    cycles: [4]
  },
  0xb5 => {
    method: :or_l,
    cycles: [4]
  },
  0xb6 => {
    method: :or_a_hl,
    cycles: [8]
  },
  0xb7 => {
    method: :or_a,
    cycles: [4]
  },
  0xb8 => {
    method: :cp_b,
    cycles: [4]
  },
  0xb9 => {
    method: :cp_c,
    cycles: [4]
  },
  0xba => {
    method: :cp_d,
    cycles: [4]
  },
  0xbb => {
    method: :cp_e,
    cycles: [4]
  },
  0xbc => {
    method: :cp_h,
    cycles: [4]
  },
  0xbd => {
    method: :cp_l,
    cycles: [4]
  },
  0xbe => {
    method: :cp_a_hl,
    cycles: [8]
  },
  0xbf => {
    method: :cp_a,
    cycles: [4]
  },
  0xc0 => {
    method: :ret_nz,
    cycles: [20, 8]
  },
  0xc1 => {
    method: :pop_bc,
    cycles: [12]
  },
  0xc2 => {
    method: :jp_nz_a16,
    cycles: [16, 12]
  },
  0xc3 => {
    method: :jp_a16,
    cycles: [16]
  },
  0xc4 => {
    method: :call_nz_a16,
    cycles: [24, 12]
  },
  0xc5 => {
    method: :push_bc,
    cycles: [16]
  },
  0xc6 => {
    method: :add_a_d8,
    cycles: [8]
  },
  0xc7 => {
    method: :rst_00h,
    cycles: [16]
  },
  0xc8 => {
    method: :ret_z,
    cycles: [20, 8]
  },
  0xc9 => {
    method: :ret,
    cycles: [16]
  },
  0xca => {
    method: :jp_z_a16,
    cycles: [16, 12]
  },
  0xcb => {
    method: :prefix,
    cycles: [4]
  },
  0xcc => {
    method: :call_z_a16,
    cycles: [24, 12]
  },
  0xcd => {
    method: :call_a16,
    cycles: [24]
  },
  0xce => {
    method: :adc_a_d8,
    cycles: [8]
  },
  0xcf => {
    method: :rst_08h,
    cycles: [16]
  },
  0xd0 => {
    method: :ret_nc,
    cycles: [20, 8]
  },
  0xd1 => {
    method: :pop_de,
    cycles: [12]
  },
  0xd2 => {
    method: :jp_nc_a16,
    cycles: [16, 12]
  },
  0xd4 => {
    method: :call_nc_a16,
    cycles: [24, 12]
  },
  0xd5 => {
    method: :push_de,
    cycles: [16]
  },
  0xd6 => {
    method: :sub_d8,
    cycles: [8]
  },
  0xd7 => {
    method: :rst_10h,
    cycles: [16]
  },
  0xd8 => {
    method: :ret_c,
    cycles: [20, 8]
  },
  0xd9 => {
    method: :reti,
    cycles: [16]
  },
  0xda => {
    method: :jp_c_a16,
    cycles: [16, 12]
  },
  0xdc => {
    method: :call_c_a16,
    cycles: [24, 12]
  },
  0xde => {
    method: :sbc_a_d8,
    cycles: [8]
  },
  0xdf => {
    method: :rst_18h,
    cycles: [16]
  },
  0xe0 => {
    method: :ldh_a_a8_a,
    cycles: [12]
  },
  0xe1 => {
    method: :pop_hl,
    cycles: [12]
  },
  0xe2 => {
    method: :ld_a_c_a,
    cycles: [8]
  },
  0xe5 => {
    method: :push_hl,
    cycles: [16]
  },
  0xe6 => {
    method: :and_d8,
    cycles: [8]
  },
  0xe7 => {
    method: :rst_20h,
    cycles: [16]
  },
  0xe8 => {
    method: :add_sp_r8,
    cycles: [16]
  },
  0xe9 => {
    method: :jp_a_hl,
    cycles: [4]
  },
  0xea => {
    method: :ld_a_a16_a,
    cycles: [16]
  },
  0xee => {
    method: :xor_d8,
    cycles: [8]
  },
  0xef => {
    method: :rst_28h,
    cycles: [16]
  },
  0xf0 => {
    method: :ldh_a_a_a8,
    cycles: [12]
  },
  0xf1 => {
    method: :pop_af,
    cycles: [12]
  },
  0xf2 => {
    method: :ld_a_a_c,
    cycles: [8]
  },
  0xf3 => {
    method: :di,
    cycles: [4]
  },
  0xf5 => {
    method: :push_af,
    cycles: [16]
  },
  0xf6 => {
    method: :or_d8,
    cycles: [8]
  },
  0xf7 => {
    method: :rst_30h,
    cycles: [16]
  },
  0xf8 => {
    method: :ld_hl_sp_r8,
    cycles: [12]
  },
  0xf9 => {
    method: :ld_sp_hl,
    cycles: [8]
  },
  0xfa => {
    method: :ld_a_a_a16,
    cycles: [16]
  },
  0xfb => {
    method: :ei,
    cycles: [4]
  },
  0xfe => {
    method: :cp_d8,
    cycles: [8]
  },
  0xff => {
    method: :rst_38h,
    cycles: [16]
  },
}

CB_OPCODES = {
  0x00 => {
    method: :rlc_b,
    cycles: [8]
  },
  0x01 => {
    method: :rlc_c,
    cycles: [8]
  },
  0x02 => {
    method: :rlc_d,
    cycles: [8]
  },
  0x03 => {
    method: :rlc_e,
    cycles: [8]
  },
  0x04 => {
    method: :rlc_h,
    cycles: [8]
  },
  0x05 => {
    method: :rlc_l,
    cycles: [8]
  },
  0x06 => {
    method: :rlc_a_hl,
    cycles: [16]
  },
  0x07 => {
    method: :rlc_a,
    cycles: [8]
  },
  0x08 => {
    method: :rrc_b,
    cycles: [8]
  },
  0x09 => {
    method: :rrc_c,
    cycles: [8]
  },
  0x0a => {
    method: :rrc_d,
    cycles: [8]
  },
  0x0b => {
    method: :rrc_e,
    cycles: [8]
  },
  0x0c => {
    method: :rrc_h,
    cycles: [8]
  },
  0x0d => {
    method: :rrc_l,
    cycles: [8]
  },
  0x0e => {
    method: :rrc_a_hl,
    cycles: [16]
  },
  0x0f => {
    method: :rrc_a,
    cycles: [8]
  },
  0x10 => {
    method: :rl_b,
    cycles: [8]
  },
  0x11 => {
    method: :rl_c,
    cycles: [8]
  },
  0x12 => {
    method: :rl_d,
    cycles: [8]
  },
  0x13 => {
    method: :rl_e,
    cycles: [8]
  },
  0x14 => {
    method: :rl_h,
    cycles: [8]
  },
  0x15 => {
    method: :rl_l,
    cycles: [8]
  },
  0x16 => {
    method: :rl_a_hl,
    cycles: [16]
  },
  0x17 => {
    method: :rl_a,
    cycles: [8]
  },
  0x18 => {
    method: :rr_b,
    cycles: [8]
  },
  0x19 => {
    method: :rr_c,
    cycles: [8]
  },
  0x1a => {
    method: :rr_d,
    cycles: [8]
  },
  0x1b => {
    method: :rr_e,
    cycles: [8]
  },
  0x1c => {
    method: :rr_h,
    cycles: [8]
  },
  0x1d => {
    method: :rr_l,
    cycles: [8]
  },
  0x1e => {
    method: :rr_a_hl,
    cycles: [16]
  },
  0x1f => {
    method: :rr_a,
    cycles: [8]
  },
  0x20 => {
    method: :sla_b,
    cycles: [8]
  },
  0x21 => {
    method: :sla_c,
    cycles: [8]
  },
  0x22 => {
    method: :sla_d,
    cycles: [8]
  },
  0x23 => {
    method: :sla_e,
    cycles: [8]
  },
  0x24 => {
    method: :sla_h,
    cycles: [8]
  },
  0x25 => {
    method: :sla_l,
    cycles: [8]
  },
  0x26 => {
    method: :sla_a_hl,
    cycles: [16]
  },
  0x27 => {
    method: :sla_a,
    cycles: [8]
  },
  0x28 => {
    method: :sra_b,
    cycles: [8]
  },
  0x29 => {
    method: :sra_c,
    cycles: [8]
  },
  0x2a => {
    method: :sra_d,
    cycles: [8]
  },
  0x2b => {
    method: :sra_e,
    cycles: [8]
  },
  0x2c => {
    method: :sra_h,
    cycles: [8]
  },
  0x2d => {
    method: :sra_l,
    cycles: [8]
  },
  0x2e => {
    method: :sra_a_hl,
    cycles: [16]
  },
  0x2f => {
    method: :sra_a,
    cycles: [8]
  },
  0x30 => {
    method: :swap_b,
    cycles: [8]
  },
  0x31 => {
    method: :swap_c,
    cycles: [8]
  },
  0x32 => {
    method: :swap_d,
    cycles: [8]
  },
  0x33 => {
    method: :swap_e,
    cycles: [8]
  },
  0x34 => {
    method: :swap_h,
    cycles: [8]
  },
  0x35 => {
    method: :swap_l,
    cycles: [8]
  },
  0x36 => {
    method: :swap_a_hl,
    cycles: [16]
  },
  0x37 => {
    method: :swap_a,
    cycles: [8]
  },
  0x38 => {
    method: :srl_b,
    cycles: [8]
  },
  0x39 => {
    method: :srl_c,
    cycles: [8]
  },
  0x3a => {
    method: :srl_d,
    cycles: [8]
  },
  0x3b => {
    method: :srl_e,
    cycles: [8]
  },
  0x3c => {
    method: :srl_h,
    cycles: [8]
  },
  0x3d => {
    method: :srl_l,
    cycles: [8]
  },
  0x3e => {
    method: :srl_a_hl,
    cycles: [16]
  },
  0x3f => {
    method: :srl_a,
    cycles: [8]
  },
  0x40 => {
    method: :bit_0_b,
    cycles: [8]
  },
  0x41 => {
    method: :bit_0_c,
    cycles: [8]
  },
  0x42 => {
    method: :bit_0_d,
    cycles: [8]
  },
  0x43 => {
    method: :bit_0_e,
    cycles: [8]
  },
  0x44 => {
    method: :bit_0_h,
    cycles: [8]
  },
  0x45 => {
    method: :bit_0_l,
    cycles: [8]
  },
  0x46 => {
    method: :bit_0_a_hl,
    cycles: [16]
  },
  0x47 => {
    method: :bit_0_a,
    cycles: [8]
  },
  0x48 => {
    method: :bit_1_b,
    cycles: [8]
  },
  0x49 => {
    method: :bit_1_c,
    cycles: [8]
  },
  0x4a => {
    method: :bit_1_d,
    cycles: [8]
  },
  0x4b => {
    method: :bit_1_e,
    cycles: [8]
  },
  0x4c => {
    method: :bit_1_h,
    cycles: [8]
  },
  0x4d => {
    method: :bit_1_l,
    cycles: [8]
  },
  0x4e => {
    method: :bit_1_a_hl,
    cycles: [16]
  },
  0x4f => {
    method: :bit_1_a,
    cycles: [8]
  },
  0x50 => {
    method: :bit_2_b,
    cycles: [8]
  },
  0x51 => {
    method: :bit_2_c,
    cycles: [8]
  },
  0x52 => {
    method: :bit_2_d,
    cycles: [8]
  },
  0x53 => {
    method: :bit_2_e,
    cycles: [8]
  },
  0x54 => {
    method: :bit_2_h,
    cycles: [8]
  },
  0x55 => {
    method: :bit_2_l,
    cycles: [8]
  },
  0x56 => {
    method: :bit_2_a_hl,
    cycles: [16]
  },
  0x57 => {
    method: :bit_2_a,
    cycles: [8]
  },
  0x58 => {
    method: :bit_3_b,
    cycles: [8]
  },
  0x59 => {
    method: :bit_3_c,
    cycles: [8]
  },
  0x5a => {
    method: :bit_3_d,
    cycles: [8]
  },
  0x5b => {
    method: :bit_3_e,
    cycles: [8]
  },
  0x5c => {
    method: :bit_3_h,
    cycles: [8]
  },
  0x5d => {
    method: :bit_3_l,
    cycles: [8]
  },
  0x5e => {
    method: :bit_3_a_hl,
    cycles: [16]
  },
  0x5f => {
    method: :bit_3_a,
    cycles: [8]
  },
  0x60 => {
    method: :bit_4_b,
    cycles: [8]
  },
  0x61 => {
    method: :bit_4_c,
    cycles: [8]
  },
  0x62 => {
    method: :bit_4_d,
    cycles: [8]
  },
  0x63 => {
    method: :bit_4_e,
    cycles: [8]
  },
  0x64 => {
    method: :bit_4_h,
    cycles: [8]
  },
  0x65 => {
    method: :bit_4_l,
    cycles: [8]
  },
  0x66 => {
    method: :bit_4_a_hl,
    cycles: [16]
  },
  0x67 => {
    method: :bit_4_a,
    cycles: [8]
  },
  0x68 => {
    method: :bit_5_b,
    cycles: [8]
  },
  0x69 => {
    method: :bit_5_c,
    cycles: [8]
  },
  0x6a => {
    method: :bit_5_d,
    cycles: [8]
  },
  0x6b => {
    method: :bit_5_e,
    cycles: [8]
  },
  0x6c => {
    method: :bit_5_h,
    cycles: [8]
  },
  0x6d => {
    method: :bit_5_l,
    cycles: [8]
  },
  0x6e => {
    method: :bit_5_a_hl,
    cycles: [16]
  },
  0x6f => {
    method: :bit_5_a,
    cycles: [8]
  },
  0x70 => {
    method: :bit_6_b,
    cycles: [8]
  },
  0x71 => {
    method: :bit_6_c,
    cycles: [8]
  },
  0x72 => {
    method: :bit_6_d,
    cycles: [8]
  },
  0x73 => {
    method: :bit_6_e,
    cycles: [8]
  },
  0x74 => {
    method: :bit_6_h,
    cycles: [8]
  },
  0x75 => {
    method: :bit_6_l,
    cycles: [8]
  },
  0x76 => {
    method: :bit_6_a_hl,
    cycles: [16]
  },
  0x77 => {
    method: :bit_6_a,
    cycles: [8]
  },
  0x78 => {
    method: :bit_7_b,
    cycles: [8]
  },
  0x79 => {
    method: :bit_7_c,
    cycles: [8]
  },
  0x7a => {
    method: :bit_7_d,
    cycles: [8]
  },
  0x7b => {
    method: :bit_7_e,
    cycles: [8]
  },
  0x7c => {
    method: :bit_7_h,
    cycles: [8]
  },
  0x7d => {
    method: :bit_7_l,
    cycles: [8]
  },
  0x7e => {
    method: :bit_7_a_hl,
    cycles: [16]
  },
  0x7f => {
    method: :bit_7_a,
    cycles: [8]
  },
  0x80 => {
    method: :res_0_b,
    cycles: [8]
  },
  0x81 => {
    method: :res_0_c,
    cycles: [8]
  },
  0x82 => {
    method: :res_0_d,
    cycles: [8]
  },
  0x83 => {
    method: :res_0_e,
    cycles: [8]
  },
  0x84 => {
    method: :res_0_h,
    cycles: [8]
  },
  0x85 => {
    method: :res_0_l,
    cycles: [8]
  },
  0x86 => {
    method: :res_0_a_hl,
    cycles: [16]
  },
  0x87 => {
    method: :res_0_a,
    cycles: [8]
  },
  0x88 => {
    method: :res_1_b,
    cycles: [8]
  },
  0x89 => {
    method: :res_1_c,
    cycles: [8]
  },
  0x8a => {
    method: :res_1_d,
    cycles: [8]
  },
  0x8b => {
    method: :res_1_e,
    cycles: [8]
  },
  0x8c => {
    method: :res_1_h,
    cycles: [8]
  },
  0x8d => {
    method: :res_1_l,
    cycles: [8]
  },
  0x8e => {
    method: :res_1_a_hl,
    cycles: [16]
  },
  0x8f => {
    method: :res_1_a,
    cycles: [8]
  },
  0x90 => {
    method: :res_2_b,
    cycles: [8]
  },
  0x91 => {
    method: :res_2_c,
    cycles: [8]
  },
  0x92 => {
    method: :res_2_d,
    cycles: [8]
  },
  0x93 => {
    method: :res_2_e,
    cycles: [8]
  },
  0x94 => {
    method: :res_2_h,
    cycles: [8]
  },
  0x95 => {
    method: :res_2_l,
    cycles: [8]
  },
  0x96 => {
    method: :res_2_a_hl,
    cycles: [16]
  },
  0x97 => {
    method: :res_2_a,
    cycles: [8]
  },
  0x98 => {
    method: :res_3_b,
    cycles: [8]
  },
  0x99 => {
    method: :res_3_c,
    cycles: [8]
  },
  0x9a => {
    method: :res_3_d,
    cycles: [8]
  },
  0x9b => {
    method: :res_3_e,
    cycles: [8]
  },
  0x9c => {
    method: :res_3_h,
    cycles: [8]
  },
  0x9d => {
    method: :res_3_l,
    cycles: [8]
  },
  0x9e => {
    method: :res_3_a_hl,
    cycles: [16]
  },
  0x9f => {
    method: :res_3_a,
    cycles: [8]
  },
  0xa0 => {
    method: :res_4_b,
    cycles: [8]
  },
  0xa1 => {
    method: :res_4_c,
    cycles: [8]
  },
  0xa2 => {
    method: :res_4_d,
    cycles: [8]
  },
  0xa3 => {
    method: :res_4_e,
    cycles: [8]
  },
  0xa4 => {
    method: :res_4_h,
    cycles: [8]
  },
  0xa5 => {
    method: :res_4_l,
    cycles: [8]
  },
  0xa6 => {
    method: :res_4_a_hl,
    cycles: [16]
  },
  0xa7 => {
    method: :res_4_a,
    cycles: [8]
  },
  0xa8 => {
    method: :res_5_b,
    cycles: [8]
  },
  0xa9 => {
    method: :res_5_c,
    cycles: [8]
  },
  0xaa => {
    method: :res_5_d,
    cycles: [8]
  },
  0xab => {
    method: :res_5_e,
    cycles: [8]
  },
  0xac => {
    method: :res_5_h,
    cycles: [8]
  },
  0xad => {
    method: :res_5_l,
    cycles: [8]
  },
  0xae => {
    method: :res_5_a_hl,
    cycles: [16]
  },
  0xaf => {
    method: :res_5_a,
    cycles: [8]
  },
  0xb0 => {
    method: :res_6_b,
    cycles: [8]
  },
  0xb1 => {
    method: :res_6_c,
    cycles: [8]
  },
  0xb2 => {
    method: :res_6_d,
    cycles: [8]
  },
  0xb3 => {
    method: :res_6_e,
    cycles: [8]
  },
  0xb4 => {
    method: :res_6_h,
    cycles: [8]
  },
  0xb5 => {
    method: :res_6_l,
    cycles: [8]
  },
  0xb6 => {
    method: :res_6_a_hl,
    cycles: [16]
  },
  0xb7 => {
    method: :res_6_a,
    cycles: [8]
  },
  0xb8 => {
    method: :res_7_b,
    cycles: [8]
  },
  0xb9 => {
    method: :res_7_c,
    cycles: [8]
  },
  0xba => {
    method: :res_7_d,
    cycles: [8]
  },
  0xbb => {
    method: :res_7_e,
    cycles: [8]
  },
  0xbc => {
    method: :res_7_h,
    cycles: [8]
  },
  0xbd => {
    method: :res_7_l,
    cycles: [8]
  },
  0xbe => {
    method: :res_7_a_hl,
    cycles: [16]
  },
  0xbf => {
    method: :res_7_a,
    cycles: [8]
  },
  0xc0 => {
    method: :set_0_b,
    cycles: [8]
  },
  0xc1 => {
    method: :set_0_c,
    cycles: [8]
  },
  0xc2 => {
    method: :set_0_d,
    cycles: [8]
  },
  0xc3 => {
    method: :set_0_e,
    cycles: [8]
  },
  0xc4 => {
    method: :set_0_h,
    cycles: [8]
  },
  0xc5 => {
    method: :set_0_l,
    cycles: [8]
  },
  0xc6 => {
    method: :set_0_a_hl,
    cycles: [16]
  },
  0xc7 => {
    method: :set_0_a,
    cycles: [8]
  },
  0xc8 => {
    method: :set_1_b,
    cycles: [8]
  },
  0xc9 => {
    method: :set_1_c,
    cycles: [8]
  },
  0xca => {
    method: :set_1_d,
    cycles: [8]
  },
  0xcb => {
    method: :set_1_e,
    cycles: [8]
  },
  0xcc => {
    method: :set_1_h,
    cycles: [8]
  },
  0xcd => {
    method: :set_1_l,
    cycles: [8]
  },
  0xce => {
    method: :set_1_a_hl,
    cycles: [16]
  },
  0xcf => {
    method: :set_1_a,
    cycles: [8]
  },
  0xd0 => {
    method: :set_2_b,
    cycles: [8]
  },
  0xd1 => {
    method: :set_2_c,
    cycles: [8]
  },
  0xd2 => {
    method: :set_2_d,
    cycles: [8]
  },
  0xd3 => {
    method: :set_2_e,
    cycles: [8]
  },
  0xd4 => {
    method: :set_2_h,
    cycles: [8]
  },
  0xd5 => {
    method: :set_2_l,
    cycles: [8]
  },
  0xd6 => {
    method: :set_2_a_hl,
    cycles: [16]
  },
  0xd7 => {
    method: :set_2_a,
    cycles: [8]
  },
  0xd8 => {
    method: :set_3_b,
    cycles: [8]
  },
  0xd9 => {
    method: :set_3_c,
    cycles: [8]
  },
  0xda => {
    method: :set_3_d,
    cycles: [8]
  },
  0xdb => {
    method: :set_3_e,
    cycles: [8]
  },
  0xdc => {
    method: :set_3_h,
    cycles: [8]
  },
  0xdd => {
    method: :set_3_l,
    cycles: [8]
  },
  0xde => {
    method: :set_3_a_hl,
    cycles: [16]
  },
  0xdf => {
    method: :set_3_a,
    cycles: [8]
  },
  0xe0 => {
    method: :set_4_b,
    cycles: [8]
  },
  0xe1 => {
    method: :set_4_c,
    cycles: [8]
  },
  0xe2 => {
    method: :set_4_d,
    cycles: [8]
  },
  0xe3 => {
    method: :set_4_e,
    cycles: [8]
  },
  0xe4 => {
    method: :set_4_h,
    cycles: [8]
  },
  0xe5 => {
    method: :set_4_l,
    cycles: [8]
  },
  0xe6 => {
    method: :set_4_a_hl,
    cycles: [16]
  },
  0xe7 => {
    method: :set_4_a,
    cycles: [8]
  },
  0xe8 => {
    method: :set_5_b,
    cycles: [8]
  },
  0xe9 => {
    method: :set_5_c,
    cycles: [8]
  },
  0xea => {
    method: :set_5_d,
    cycles: [8]
  },
  0xeb => {
    method: :set_5_e,
    cycles: [8]
  },
  0xec => {
    method: :set_5_h,
    cycles: [8]
  },
  0xed => {
    method: :set_5_l,
    cycles: [8]
  },
  0xee => {
    method: :set_5_a_hl,
    cycles: [16]
  },
  0xef => {
    method: :set_5_a,
    cycles: [8]
  },
  0xf0 => {
    method: :set_6_b,
    cycles: [8]
  },
  0xf1 => {
    method: :set_6_c,
    cycles: [8]
  },
  0xf2 => {
    method: :set_6_d,
    cycles: [8]
  },
  0xf3 => {
    method: :set_6_e,
    cycles: [8]
  },
  0xf4 => {
    method: :set_6_h,
    cycles: [8]
  },
  0xf5 => {
    method: :set_6_l,
    cycles: [8]
  },
  0xf6 => {
    method: :set_6_a_hl,
    cycles: [16]
  },
  0xf7 => {
    method: :set_6_a,
    cycles: [8]
  },
  0xf8 => {
    method: :set_7_b,
    cycles: [8]
  },
  0xf9 => {
    method: :set_7_c,
    cycles: [8]
  },
  0xfa => {
    method: :set_7_d,
    cycles: [8]
  },
  0xfb => {
    method: :set_7_e,
    cycles: [8]
  },
  0xfc => {
    method: :set_7_h,
    cycles: [8]
  },
  0xfd => {
    method: :set_7_l,
    cycles: [8]
  },
  0xfe => {
    method: :set_7_a_hl,
    cycles: [16]
  },
  0xff => {
    method: :set_7_a,
    cycles: [8]
  },
}
