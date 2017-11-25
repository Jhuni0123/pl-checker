# HW6
## How to use
### 6-1 : Rozetta (`ex1/`)
1. 구현한 `rozetta.ml`을 복사하거나 뼈대코드 `rozetta.ml.orig`을 `rozetta.ml`로 바꾼 후 구현합니다.
2. `./check` 명령어를 통해 테스트케이스를 실행합니다.

- `examples/test<num>.sm5` : 테스트케이스
- `examples/test<num>.k--` : 테스트케이스 (k-- 버전)
- `examples/test<num>.in`  : (입력이 필요한 경우만) 입력
- `examples/test<num>.ans` : 정답
- `examples/test<num>.out` : 출력

**hard testcase**

k--를 번역하지 않고 직접 임의로 작성한 sm5 코드입니다. 점수에 영향이 없을지도 모릅니다.
- `examples/test_hard<num>.*`

### 6-2 : CPS (`ex2/`)
1. 구현한 `cps.ml`을 복사하거나 뼈대코드 `cps.ml.orig`을 `cps.ml`로 바꾼 후 구현합니다.
2. `./check` 명령어를 통해 테스트케이스를 실행합니다.

- `examples/test<num>.m` : 테스트케이스

**사용에 주의가 필요합니다.**

1. cps변환된 식에 대해서 evaluate 된 결과 값도 비교 하고 올바른 cps변환인지도 검사합니다.
2. cps변환은 제가 생각한 정답에 대해서는 통과하도록 구현했지만 정확하지 않으므로 **맞는 구현에 틀렸다고 나오거나 틀린 구현에 맞았다고 나올 수 있습니다.**

### 6-3 : M Interpreter (`ex3/`)
1. 구현한 `m.ml`을 복사하거나 뼈대코드 `m.ml.orig`을 `m.ml`로 바꾼 후 구현합니다.
2. `./check` 명령어를 통해 테스트케이스를 실행합니다.

- `examples/test<num>.m`   : 테스트케이스
- `examples/test<num>.in`  : (입력이 필요한 경우만) 입력
- `examples/test<num>.ans` : 정답
- `examples/test<num>.out` : 출력
