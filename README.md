# jfold - 句点や括弧のぶら下げや追い出しの禁則処理に対応したfold

句点や括弧のぶら下げや追い出しの禁則処理に対応したfoldです。指定文字数（デフォルト20）毎に改行を入れます。

- [Documentation(npmjs)](https://www.npmjs.com/jfold)
- [Bug Report(GitHub)](https://github.com/kssfilo/jfold)
- [Home Page](https://kanasys.com/tech/)

## 例

    $ cat test.txt
    いろはにほへとちりぬるをわがよたれそつね」ならんういのおくけまけふこえてあさきゆめみしえひもせすん

    $ cat test.test | jfold > result.txt
    $ cat result.txt
    いろはにほへとちりぬるをわがよたれそつね」
    ならんういのおくけまけふこえてあさきゆめ
    みしえひもせすん
    いろはにほへとちりぬるをわがよたれそつ
    「ねならんういのおくけまけふこえてあさき
    ゆめみしえひもせすん

## インストール

    npm install -g jfold

@PARTPIPE@|dist/cli.js -h

You can see detail usage on npmjs.com

- [Documentation(npmjs)](https://www.npmjs.com/package/norl)

@PARTPIPE@

## Change Log

- 1.0.x: first release
