Запуск NGINX на не стандартном порту (4881) тремя способами:
переключатели setsebool;
добавление нестандартного порта в имеющийся тип;
формирование и установка модуля SELinux.
Для выполнения задания запустим виртуалку vagrant up
ВМ запустится и пройдет первичная настройка (раздел box.vm.provision "shell", inline: <<-SHELL в файле),
после чего будет запущен скрипт, реализующий все три способа поочередно с генерацией файла отчета progress.txt.
В отчете кратко описаны этапы.
У ключевых команд в самом скрипте добавлены описания команд