# pl-checker
> 2017F Programming Language Homework Checker

# HOW TO USE
이 깃 리포지토리 안에서 숙제를 할 수 있는 환경을 의도하고 있습니다. 소스코드를 작성하다가 업데이트를 해도 소스코드가 덮어씌워지지 않습니다.
I intend to make an environment where homework can be done in this repository. The source code is not overwritten when you update the repository.
```bash
git clone https://github.com/Jhuni0123/pl-checker.git
cd pl-checker
```
## HW1, HW2
```bash
cd hw1
# write ex1.ml, ex2.ml, ... ex4.ml
make test 1 # check exercise 1
make        # check every exercise
```
예를 들어 hw2의 exercise 3을 테스트하고 싶으면 해당 소스를 `hw2/ex3.ml`에 작성해야합니다.
you should write `hw<hwnum>/ex<exnum>.ml` for test \<hwnum>-\<exnum>
- `make test <exnum>` (= `./check.sh <exnum>`): complile exercise \<exnum> and run test, and show results of every testcase
- `make` (= `./check.sh`): compile every exercise in current hw folder (hw\<hwnum>), run test, and show summary

# HOW TO UPDATE
**테스트케이스가 종종 업데이트 됩니다. 주기적으로 업데이트 해주세요!**
**This repository is often updated. Please Update periodically!!**
```bash
make update # git pull --rebase origin master
```

# Status
- HW 3~ : TBD

# Screenshot
### 2-5: Zip-Zip Tree
![2-5](img/PL_2-5.png)

---
[MIT License](LICENSE)
