# Ubuntu 20.04 + Symfony 5 + PHP 7.4 + PHPUnit 9

簡單開發環境的建置

## Getting Started

使用 VirtualBox + Vagrant 建立開發環境

### 啟動

```
vagrant up
```

### 單元測試

安裝 PHPUnit 9 - 適用 PHP 7.4

```
composer require --dev phpunit/phpunit ^9
```

執行測試

```
./vendor/bin/phpunit tests
```

## Built With

* [Symfony](https://symfony.com/) - Symfony, High Performance PHP Framework for Web Development
* [PHPUnit](https://phpunit.de/getting-started/phpunit-9.html) - Getting Started with PHPUnit 9


## Authors

* **許文奕** - [GitHub](https://github.com/dkben)

## License

This project is licensed under the MIT License