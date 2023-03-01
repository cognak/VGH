Функция ПолучитьПараметрыАктивногоСайта()  Экспорт
Параметры=Новый Структура("Наименование,HTTPСервер,ИмяПользователя,Пароль,GUID,Порт");
Запрос = Новый Запрос;
Запрос.Текст = 
"ВЫБРАТЬ
|	ОбменсСайтом.Ссылка КАК Ссылка,
|	ОбменсСайтом.Наименование КАК Наименование,
|	ОбменсСайтом.АдресСайта КАК HTTPСервер,
|	ОбменсСайтом.ИмяПользователя КАК ИмяПользователя,
|	ОбменсСайтом.Пароль КАК Пароль,
|	ОбменсСайтом.Токен КАК GUID,
|	ОбменсСайтом.СайтПодключен КАК СайтПодключен,
|	0 КАК Порт
|ИЗ
|	ПланОбмена.ОбменсСайтом КАК ОбменсСайтом
|ГДЕ
|	ОбменсСайтом.СайтПодключен
|	И НЕ ОбменсСайтом.ПометкаУдаления";

РезультатЗапроса = Запрос.Выполнить();
Если РезультатЗапроса.Пустой() Тогда
	Возврат Параметры;
КонецЕсли; 
Выборка = РезультатЗапроса.Выбрать();
Пока Выборка.Следующий() Цикл
	ЗаполнитьЗначенияСвойств(Параметры,Выборка);
	Параметры.Вставить("Пароль",ОбщегоНазначения.ПрочитатьДанныеИзБезопасногоХранилища(Выборка.Ссылка, "Пароль"));
	Прервать;
КонецЦикла;
Возврат Параметры;	

	
КонецФункции
