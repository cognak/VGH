// Функция заполняет наименование рабочего места клиента по имени пользователя.
//
Процедура ЗаполнитьНаименованиеРабочегоМеста(Объект, ИмяПользователя) Экспорт
	
	ИмяПустойПользователь = НСтр("ru='<Пользователь>';uk='<Користувач>'");
	
	Если ПустаяСтрока(Объект.Наименование) Тогда
		
		Если ПустаяСтрока(ИмяПользователя) Тогда
			Объект.Наименование = "<" + ИмяПустойПользователь + ">";
		Иначе
			Объект.Наименование = Строка(ИмяПользователя);
		КонецЕсли;
		
		Если ПустаяСтрока(Объект.ИмяКомпьютера) Тогда
			Объект.Наименование = Объект.Наименование + "(" + Объект.Код           + ")";
		Иначе
			Объект.Наименование = Объект.Наименование + "(" + Объект.ИмяКомпьютера + ")";
		КонецЕсли;
		
	ИначеЕсли Не ПустаяСтрока(Строка(ИмяПользователя))
	          И Найти(Объект.Наименование, ИмяПустойПользователь) > 0 Тогда
	
		Объект.Наименование = СтрЗаменить(Объект.Наименование, ИмяПустойПользователь, Строка(ИмяПользователя));
	
	КонецЕсли;

КонецПроцедуры
