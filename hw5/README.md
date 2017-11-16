# HW5: SM5 (Stack Machine 5)
## How to use
1. 구현한 `translate.ml`을 복사하거나 뼈대코드 `translate.ml.orig`을 `translate.ml`로 바꾼 후 구현합니다.
2. 구현한 `sm5.ml`을 복사하거나 뼈대코드 `sm5.ml.orig`을 `sm5.ml`로 바꾼 후 구현합니다.
3. `./check` 명령어를 통해 테스트케이스를 실행합니다.

### 5-1
- `examples/test<num>.k--` : 테스트케이스
- `examples/test<num>.ans` : 정답
- `examples/test<num>.out` : 출력

### 5-2
- `examples/testgc<num>.k--` : 테스트케이스
- `examples/testgc<num>.ans` : 정답
- `examples/testgc<num>.out` : 출력

---

>SNU 4190.310 Programming Languages

#SM5

## 컴파일 및 실행 방법
`sm5.ml`에는 sm5 모듈이 정의되어 있고, `k.ml`에는 K-- 인터프리터가 구현되어 있습니다.
아래와 같이 실행하면, 주어진 k-- 프로그램을 여러분이 작성하신 번역기에 따라 번역하고 SM5 기계로 실행합니다.
```
  $ make
  $ ./run examples/test1.k--
```

실행시, 파일명을 명시하지 않을 경우, 표준입력으로부터 실행코드를 읽어들입니다.
표준 입력으로 프로그램을 입력하신 후, 첫 번째 칸(column)에서 Ctrl-D를 누르시면 프로그램이 실행됩니다.


## K-- 파스 트리 출력하기

 주어진 K-- 프로그램의 파스 트리를 화면에 출력해주는 모듈이 `pp.ml` 파일에 포함되어 있습니다.
 이를 통해 파싱이 의도한 대로 되고 있는지 확인해 보실 수 있습니다.
```
 $ ./run -pk examples/test1.k--
```

## K-- 실행기로 실행하기

 주어진 K-- 프로그램을 K-- 실행기로 실행한 결과를 다음과 같이 확인할 수 있습니다.
 번역이 제대로 되었다면, SM5 기계로 실행한 결과와 K-- 실행기로 실행한 결과가 같아야 합니다.
```
 $ ./run -k examples/test1.k--
```

## 번역된 SM5 프로그램 출력하기

 주어진 K-- 프로그램을 SM5로 번역한 결과를 `-psm5` 옵션을 통해 출력할 수 있습니다.
```
 $ ./run -psm5 examples/test1.k--
```

## SM5 기계 위에서 디버그 모드로 실행하기

 주어진 K-- 프로그램을 SM5로 번역한 다음, 디버그 모드에서 실행합니다.
 디버그 모드는 SM5의 매 스텝마다 기계 상태를 출력합니다. 출력되는 문자열의 양이 많으므로 주의하세요.
```
 $ ./run -debug examples/test1.k--
```

## 숙제 제출 관련
 "SM5" 문제 : `translate.ml` 파일에 있는 `trans` 함수를 완성하시고 `translate.ml` 파일만 제출해 주세요.
 "SM5 + 메모리 재활용" 문제 : `sm5.ml` 파일에 있는 `malloc_with_gc` 함수를 완성하시고 `sm5.ml` 파일만 제출해 주세요.

---
최웅식 <wschoi@ropas.kaist.ac.kr>
신재호 <netj@ropas.snu.ac.kr>
김덕환 <dk@ropas.snu.ac.kr>
오학주 <pronto@ropas.snu.ac.kr>
박대준 <pudrife@ropas.snu.ac.kr>
이희종 <ihji@ropas.snu.ac.kr>
정영범 <dreameye@ropas.snu.ac.kr>
오학주 <pronto@ropas.snu.ac.kr>
허기홍 <khheo@ropas.snu.ac.kr>
조성근 <skcho@ropas.snu.ac.kr>
최준원 <jwchoi@ropas.snu.ac.kr>
강동옥 <dokang@ropas.snu.ac.kr>
15 최재승 <jschoi@ropas.snu.ac.kr>
17 이동권 <dklee@ropas.snu.ac.kr>


