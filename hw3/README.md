# HW3: K- interpreter
## How to use
### 3-1
1. 구현한 `k.ml`을 복사하거나 뼈대코드`k.ml.orig`을 `k.ml`로 바꾼 후 구현합니다.
2. `./check` 명령어를 통해 테스트케이스를 실행합니다.

- `examples/test<num>.k-` : 테스트케이스
- `examples/test<num>.ans` : 정답
- `examples/test<num>.out` : 출력

### 3-2, 3-3
1. `exercises/` 폴더에 `ex2.txt`, `ex3.txt` 또는 `ex2.k-`, `ex3.k-` 파일을 작성합니다.
2. `./check` 명령어를 통해 테스트케이스를 실행합니다.

제출스펙과 마찬가지로 소스코드 마지막을
3-2는
```
...
in
let input := 0 in
read input;
write (numch(input))
```
3-3은
```
...
in
2017
```
로 끝내주시기 바랍니다.

- `exercises/test<ex>-<num>.k-` : 테스트케이스
- `exercises/test<ex>-<num>.ans` : 정답
- `exercises/test<ex>-<num>.out` : 출력

---

> 아래는 뼈대코드 README 입니다.

## 문법
제공되는 파서가 정의하고 있는 문법은 조교가 제공한 문서에
있는 `expression`과 `statement`가 합쳐있는 언어입니다.


## 우선 순위
사용되는 기호들의 우선순위는 아래와 같습니다.

위에 있는 기호가 우선 순위가 가장 높고,
아래로 갈수록 우선 순위가 낮아집니다.
```
   .      (오른쪽)
   not    (오른쪽)
   *, /   (왼쪽)
   +, -   (왼쪽)
   =, <   (왼쪽)
   write  (오른쪽)
   :=     (오른쪽)
   else
   then
   do
   ;      (왼쪽)
   in
```
우선순위를 고려해야 되는 몇가지 일반적인 경우를 보여드리면
다음과 같습니다.
```
  x := e1 ; e2        =>    (x := e1) ; e2   ( := 이 ; 보다 우선 순위가 높기때문 )
  while e do e1;e2    =>    (while e do e1);e2
  if e1 then e2 else e3;e4    =>    (if e1 then e2 else e3); e4
  let x := e1 in e2 ; e3      =>    let x :=e in (e2;e3)
```
즉 `:=`, `while`, `for`, `if` 의 바디로 `sequence`를 쓰고 싶으면 `sequence`를
다음과 같이 괄호로 묶어 줘야 합니다.
  `while e do (e1;e2)`

마찬가지로 `let in` 의 바디에서는 scope를 제한시키려면 괄호를 쳐줘야 하게 됩니다.
  `(let x := e1 in e2); e3`

방향성은 우선순위가 같은 경우에 적용이 됩니다.
예를 들어 방향성이 오른쪽인 `:=` 은

  `x := y := 1    =>   x := (y := 1)`

이 되게 됩니다.

우선순위를 잘 모르겠을시에는 괄호를 쳐주는 것이 한가지 방편이 될 수 있습니다.


## 컴파일 및 실행 방법
제공되는 `k.ml` 파일에는 숙제 구현 부분은 비워져 있습니다.  이 파일을 수정해서
interpreter를 완성하고 다음과 같이 컴파일 및 실행을 하면 됩니다.

```
make
./run examples/test1.k-
```

## 숙제 제출 방법
숙제 제출은 `k.ml` 파일만 해주세요.

즉, 조교가 여기서 제공되고 있는 파일 중 `k.ml`만 각자가 제출한 것으로
바꿔서 컴파일 및 실행이 되도록 해서 제출해 주시기 바랍니다.


## pretty-printer
입력 프로그램을 간단히 화면에 출력시켜주는 pretty-printer가
제공된 `pp.ml` 파일에 포함되어 있습니다.

사용법은 `run -pp test1.k-`를 실행하면 `main.ml`에서 `run` 함수를 불러서
`intepreter`를 돌리는 것이 아니라 `test1.k-`를 파싱 해서 입력된 프로그램을
화면에 출력해주고 마치게 됩니다.

이를 통해 파싱이 의도한 대로 되고 있는지 확인해 보실 수 있을 겁니다.


## 주석
K- 프로그램 안에서 `(*  *)` 로 주석을 사용할 수 있습니다.




--
03 최웅식 <wschoi@ropas.kaist.ac.kr>
04 신재호 <netj@ropas.snu.ac.kr>
05 김덕환 <dk@ropas.snu.ac.kr>
05 오학주 <pronto@ropas.snu.ac.kr>
06 이희종 <ihji@ropas.snu.ac.kr>
07 오학주 <pronto@ropas.snu.ac.kr>
08 최원태 <wtchoi@ropas.snu.ac.kr>
09 허기홍 <khheo@ropas.snu.ac.kr>
09 김희정 <hjkim@ropas.snu.ac.kr>
10 조성근 <skcho@ropas.snu.ac.kr>
10 장수원 <swjang@ropas.snu.ac.kr>
11 윤용호 <yhyoon@ropas.snu.ac.kr>
11 김진영 <jykim@ropas.snu.ac.kr>
13 최준원 <jwchoi@ropas.snu.ac.kr>
13 강동옥 <dokang@ropas.snu.ac.kr>
15 최재승 <jschoi@ropas.snu.ac.kr>
17 이동권 <dklee@ropas.snu.ac.kr>
