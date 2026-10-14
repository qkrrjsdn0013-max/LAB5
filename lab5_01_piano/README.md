# STM32_1 FPGA 추가실습: piano

설계 코드와 자기검사형 테스트벤치는 ece2_474 v1.1.0의 `docs/FPGA_additional.md`에 제공된 코드를 실습 파일로 나눈 것이다. 테스트벤치에는 VCD 파형 생성을 위한 `$dumpfile`·`$dumpvars`만 추가했다. XDC의 물리 핀은 Combo II-DLD Xilinx S7 Pin Map과 기존 LAB1~LAB4 제약 파일을 대조해 작성했다.

## 파일과 최상위 모듈

- 보드 설계 최상위: `piano`
- 시뮬레이션 최상위: `tb`
- 설계 모듈: piano, note_select, square_tone
- 테스트벤치: `sim/tb_piano.sv`
- 핀 제약: `constraints/piano.xdc`

## VS Code에서 실행

이 폴더의 `FPGA.code-workspace`를 VS Code로 연다. `터미널 → 작업 실행`에서 `01 Check tools`, `02 Simulate`, `03 Open waveform`을 순서대로 사용할 수 있다. `02 Simulate`가 `simulation.json`의 파일을 컴파일하고 `build/sim`에 로그와 `wave.vcd`를 생성한다. 이 작업은 아직 실행하지 않았다.

## 보드 연결

KEY05~KEY12를 key[7:0]에 연결했다. HIGH인 키 하나가 음계를 선택하며, 입력이 없거나 여러 키가 눌리면 무음이다. 매뉴얼은 안정된 입력을 가정하므로 실제 버튼의 접점 튐은 보드에서 확인한다.

Vivado에서는 `src`의 Verilog를 Design Sources, `sim`의 TB를 Simulation Sources, XDC를 Constraints에 추가한다. 설계 최상위는 `piano`으로 선택한다. 합성·구현·보드 다운로드와 실제 동작은 아직 확인하지 않았다.
