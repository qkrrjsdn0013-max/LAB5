# STM32_1 FPGA 추가실습: traffic

설계 코드와 자기검사형 테스트벤치는 ece2_474 v1.1.0의 `docs/FPGA_additional.md`에 제공된 코드를 실습 파일로 나눈 것이다. 테스트벤치에는 VCD 파형 생성을 위한 `$dumpfile`·`$dumpvars`만 추가했다. XDC의 물리 핀은 Combo II-DLD Xilinx S7 Pin Map과 기존 LAB1~LAB4 제약 파일을 대조해 작성했다.

## 파일과 최상위 모듈

- 보드 설계 최상위: `traffic`
- 시뮬레이션 최상위: `tb`
- 설계 모듈: traffic, second_tick, traffic_lights, traffic_sequence
- 테스트벤치: `sim/tb_traffic.sv`
- 핀 제약: `constraints/traffic.xdc`

## VS Code에서 실행

이 폴더의 `FPGA.code-workspace`를 VS Code로 연다. `터미널 → 작업 실행`에서 `01 Check tools`, `02 Simulate`, `03 Open waveform`을 순서대로 사용할 수 있다. `02 Simulate`가 `simulation.json`의 파일을 컴파일하고 `build/sim`에 로그와 `wave.vcd`를 생성한다. 이 작업은 아직 실행하지 않았다.

## 보드 연결

출력 비트 [3:0]는 남·서·동·북 방향에 대응한다. KEY02를 HIGH 활성 점멸 모드 입력으로 사용한다. 설계의 출력 1은 논리적인 켜짐이므로 실제 신호등 장치의 극성을 확인한다.

Vivado에서는 `src`의 Verilog를 Design Sources, `sim`의 TB를 Simulation Sources, XDC를 Constraints에 추가한다. 설계 최상위는 `traffic`으로 선택한다. 합성·구현·보드 다운로드와 실제 동작은 아직 확인하지 않았다.
