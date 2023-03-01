#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПриКопировании(ОбъектКопирования)

	ТекущийПользователь = ПользователиИнформационнойБазы.ТекущийПользователь();
	Наименование = ?(ПустаяСтрока(Строка(Код)), НСтр("ru = 'Рабочее место'"), Строка(Код))
	             + ?(ПустаяСтрока(Строка(Код)), ": ", "/")
	             + ?(ПустаяСтрока(Строка(ТекущийПользователь)), НСтр("ru = 'Пользователь'"), Строка(ТекущийПользователь));
		 
	// Добавить проверку наличия элемента с таким наименованием.
	Запрос = Новый Запрос("
	|ВЫБРАТЬ
	|    КОЛИЧЕСТВО(*) КАК Количество
	|ИЗ
	|    Справочник.РабочиеМеста КАК РабочиеМеста
	|ГДЕ
	|    РабочиеМеста.Наименование ПОДОБНО &Наименование
	|    И РабочиеМеста.Ссылка <> &Ссылка
	|");

	Запрос.УстановитьПараметр("Наименование", "%" + Наименование + "%");
	Запрос.УстановитьПараметр("Ссылка"      , Ссылка);

	Количество = Запрос.Выполнить().Выгрузить()[0].Количество;
	Если Количество > 0 Тогда
		Наименование = Наименование + " (" + Строка(Количество + 1) + ")";
	КонецЕсли;

КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	Если ПометкаУдаления Тогда
		Если МенеджерОборудованияВызовСервера.ПолучитьРабочееМестоКлиента() = Ссылка Тогда
			МенеджерОборудованияВызовСервера.УстановитьРабочееМестоКлиента(Справочники.РабочиеМеста.ПустаяСсылка());
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#КонецЕсли
