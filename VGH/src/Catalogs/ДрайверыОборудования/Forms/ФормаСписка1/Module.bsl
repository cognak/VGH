#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Список.ТекстЗапроса = СтрЗаменить(Список.ТекстЗапроса, "%Предопределенный%", НСтр("ru = 'Поставляемый в составе конфигурации'"));
	Список.ТекстЗапроса = СтрЗаменить(Список.ТекстЗапроса, "%Подключаемый%", НСтр("ru = 'Подключаемый по стандарту """"1С:Совместимо""""'"));
	
	ВозможностьДобавленияНовыхДрайверов = НЕ вгхОбщегоНазначенияКлиентСервер.ЭтоМобильныйКлиент() И МенеджерОборудованияВызовСервераПереопределяемый.ВозможностьДобавленияНовыхДрайверов(); 
	ПравоДоступаДобавление = ПравоДоступа("Добавление", Метаданные.Справочники.ДрайверыОборудования);
	
	Если Элементы.Найти("СписокСоздать") <> Неопределено Тогда 
		Элементы.СписокСоздать.Видимость = ПравоДоступаДобавление И ВозможностьДобавленияНовыхДрайверов;
	КонецЕсли;
	
	Если Элементы.Найти("СписокКонтекстноеМенюСоздать") <> Неопределено Тогда 
		Элементы.СписокКонтекстноеМенюСоздать.Видимость = ПравоДоступаДобавление И ВозможностьДобавленияНовыхДрайверов;
	КонецЕсли;
	
	Элементы.ДобавитьНовыйДрайверИзФайла.Видимость = ПравоДоступаДобавление И ВозможностьДобавленияНовыхДрайверов;
	
	ЭлементГруппировки = Список.Группировка.Элементы.Добавить(Тип("ПолеГруппировкиКомпоновкиДанных"));
	ЭлементГруппировки.Поле = Новый ПолеКомпоновкиДанных("ТипДрайвера");
	ЭлементГруппировки.Использование = Истина;
	
	ЭлементГруппировки = Список.Группировка.Элементы.Добавить(Тип("ПолеГруппировкиКомпоновкиДанных"));
	ЭлементГруппировки.Поле = Новый ПолеКомпоновкиДанных("ТипОборудования");
	ЭлементГруппировки.Использование = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	#Если МобильныйКлиент Тогда
		Элементы.Список.КоманднаяПанель.Видимость = Ложь;
	#КонецЕсли

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВыборФайлаДрайвераЗавершение(ПолноеИмяФайла, Параметры) Экспорт
	
	Если Не ПустаяСтрока(ПолноеИмяФайла) Тогда
		ПараметрыФормы = Новый Структура("ПолноеИмяФайла", ПолноеИмяФайла);
		ОткрытьФорму("Справочник.ДрайверыОборудования.ФормаОбъекта", ПараметрыФормы);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьНовыйДрайверИзФайла(Команда)
	
	#Если ВебКлиент Тогда
		ПоказатьПредупреждение(, НСтр("ru='Данный функционал доступен только в режиме тонкого и толстого клиента.'"));
		Возврат;
	#КонецЕсли
	
	Оповещение = Новый ОписаниеОповещения("ВыборФайлаДрайвераЗавершение", ЭтотОбъект);
	МенеджерОборудованияКлиент.НачатьВыборФайлаДрайвера(Оповещение);
	
КонецПроцедуры

&НаКлиенте
Процедура Команда1(Команда)
	МенеджерОборудованияВызовСервераПереопределяемый.ОбновитьПоставляемыеДрайвера(); 
КонецПроцедуры

#КонецОбласти
