# STM32_1 FPGA 추가실습: ADC

v1.1.0 제공 코드를 바탕으로 구성했으며, 2026-10-19에 실제 AD7908 직렬 타이밍에 맞게 수정했다. 현재 파일은 매뉴얼 원문 그대로가 아니다.

## 수정 사항과 근거

AD7908 데이터시트 Rev. E의 Table 4, Control Register, Serial Interface 및 Figure 27을 기준으로 점검했다.
출처: https://www.analog.com/media/en/technical-documentation/data-sheets/ad7908_7918_7928.pdf

- 기존 serial_frame16은 SCLK를 내리는 순간 DIN도 변경했다. ADC는 하강 에지에서 DIN을 읽으므로 setup/hold 시간을 보장하지 못했다. 수정본은 상승 에지에서 다음 DIN 비트를 준비한다.
- ADC는 CS가 내려가면 선행 0을 출력하고 첫 SCLK 하강 이후 채널 비트로 진행한다. 기존 HIGH 대기/상승 에지 수신은 선행 비트를 놓칠 수 있다. 수정본은 각 하강 에지 이전의 HIGH 구간 중간에서 DOUT을 읽는다.
- 기존 연속 프레임 사이 CS HIGH 시간은 50 MHz 기준 40 ns로, 요구되는 최소 50 ns보다 짧았다. 수정본은 별도 대기 상태를 두었다.
- 재시작 시 DIN=FFFF인 더미 프레임 두 개와 설정 프레임을 보낸 뒤 결과를 공개한다.
- 기존 TB는 ADC의 DIN 수신을 상승 에지로 모델링했다. 실제 하강 에지 수신, DOUT 지연, 채널 전환의 한 프레임 지연, 초기화, setup/hold/quiet 시간을 검사하도록 교체했다.
- XDC 물리 핀은 S7 핀 맵과 일치했다. DIP 1/3번 비트 순서는 제공된 원본 adc.zip과 같도록 수정했다.

## 현재 DIP 연결

DIP1(Y1)=add_sel[2], DIP2(W3)=add_sel[1], DIP3(U2)=add_sel[0]. DIP4~8은 사용하지 않는다.
따라서 전기적으로 ON=1인 경우, DIP1/2/3=OFF/OFF/ON이면 채널 1이다.
보드의 ADC IN1 조절기와 CDS 센서가 어느 VIN에 연결되는지는 이 XDC만으로 확정할 수 없다.

## 실행과 검증

보드 top은 adc, 시뮬레이션 top은 tb다. VS Code의 02 Simulate 작업으로 새 테스트벤치를 실행할 수 있다.
명령 비트 배치와 출력 선택 led_out=sample[11:4]는 유지했다. AD7908의 유효 8비트 값에 해당한다.
FPGA 입력은 B6이며 50 MHz를 전제로 HALF_CYCLES=25에서 SCLK=1 MHz를 만든다.

수정 검증 로그와 새 VCD는 evidence/adc_fix/에 있다. evidence/vscode/의 기존 캡처는 수정 전 결과이므로 새 설계의 증거로 사용하지 않는다.
Vivado 재생성은 tools/rebuild_adc.tcl로 수행한다. 결과 파일은 vivado/lab5_03_adc.runs/impl_1/adc.bit이다.
새 비트스트림의 보드 동작은 다시 다운로드한 후 확인해야 한다. 시뮬레이션은 실제 아날로그 전압 또는 보드 배선을 검증하지 않는다.
