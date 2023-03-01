
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	УстановитьУсловноеОформление();
	
	МодельСервиса = ОбщегоНазначения.РазделениеВключено()
		И ОбщегоНазначения.ДоступноИспользованиеРазделенныхДанных();
	
	ОтборЖурналаРегистрации = Новый Структура;
	ОтборЖурналаРегистрацииПоУмолчанию = Новый Структура;
	ЗначенияОтбора = ПолучитьЗначенияОтбораЖурналаРегистрации("Событие").Событие;
	
	Если Не ПустаяСтрока(Параметры.Пользователь) Тогда
		Если ТипЗнч(Параметры.Пользователь) = Тип("СписокЗначений") Тогда
			ОтборПоПользователю = Параметры.Пользователь;
		Иначе
			ИмяПользователя = Параметры.Пользователь;
			ОтборПоПользователю = Новый СписокЗначений;
			ОтборПоПользователю.Добавить(ИмяПользователя, ИмяПользователя);
		КонецЕсли;
		ОтборЖурналаРегистрации.Вставить("Пользователь", ОтборПоПользователю);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Параметры.СобытиеЖурналаРегистрации) Тогда
		ОтборПоСобытию = Новый СписокЗначений;
		Если ТипЗнч(Параметры.СобытиеЖурналаРегистрации) = Тип("Массив") Тогда
			Для Каждого Событие Из Параметры.СобытиеЖурналаРегистрации Цикл
				ПредставлениеСобытия = ЗначенияОтбора[Событие];
				ОтборПоСобытию.Добавить(Событие, ПредставлениеСобытия);
			КонецЦикла;
		Иначе
			ОтборПоСобытию.Добавить(Параметры.СобытиеЖурналаРегистрации, Параметры.СобытиеЖурналаРегистрации);
		КонецЕсли;
		ОтборЖурналаРегистрации.Вставить("Событие", ОтборПоСобытию);
	КонецЕсли;
	
	Если МодельСервиса Тогда
		ОтборЖурналаРегистрации.Вставить("ДатаНачала", НачалоДня(ТекущаяДатаСеанса()));
		ОтборЖурналаРегистрации.Вставить("ДатаОкончания", КонецДня(ТекущаяДатаСеанса()));
	Иначе
		Если ЗначениеЗаполнено(Параметры.ДатаНачала) Тогда
			ОтборЖурналаРегистрации.Вставить("ДатаНачала", Параметры.ДатаНачала);
		Иначе
			ОтборЖурналаРегистрации.Вставить("ДатаНачала", НачалоДня(ТекущаяДатаСеанса()));
		КонецЕсли;
		
		Если ЗначениеЗаполнено(Параметры.ДатаОкончания) Тогда
			ОтборЖурналаРегистрации.Вставить("ДатаОкончания", Параметры.ДатаОкончания + 1);
		Иначе
			ОтборЖурналаРегистрации.Вставить("ДатаОкончания", КонецДня(ТекущаяДатаСеанса()));
		КонецЕсли;
	КонецЕсли;
	
	Если Параметры.Данные <> Неопределено Тогда
		ОтборЖурналаРегистрации.Вставить("Данные", Параметры.Данные);
	КонецЕсли;
	
	Если Параметры.Сеанс <> Неопределено Тогда
		ОтборЖурналаРегистрации.Вставить("Сеанс", Параметры.Сеанс);
	КонецЕсли;
	
	// Уровень - список значений.
	Если Параметры.Уровень <> Неопределено Тогда
		ОтборПоУровню = Новый СписокЗначений;
		Если ТипЗнч(Параметры.Уровень) = Тип("Массив") Тогда
			Для Каждого ПредставлениеУровня Из Параметры.Уровень Цикл
				ОтборПоУровню.Добавить(ПредставлениеУровня, ПредставлениеУровня);
			КонецЦикла;
		ИначеЕсли ТипЗнч(Параметры.Уровень) = Тип("Строка") Тогда
			ОтборПоУровню.Добавить(Параметры.Уровень, Параметры.Уровень);
		Иначе
			ОтборПоУровню = Параметры.Уровень;
		КонецЕсли;
		ОтборЖурналаРегистрации.Вставить("Уровень", ОтборПоУровню);
	КонецЕсли;
	
	// ИмяПриложения - список значений.
	Если Параметры.ИмяПриложения <> Неопределено Тогда
		СписокПриложений = Новый СписокЗначений;
		Для Каждого Приложение Из Параметры.ИмяПриложения Цикл
			СписокПриложений.Добавить(Приложение, ПредставлениеПриложения(Приложение));
		КонецЦикла;
		ОтборЖурналаРегистрации.Вставить("ИмяПриложения", СписокПриложений);
	КонецЕсли;
	
	КоличествоПоказываемыхСобытий = 200;
	
	ОтборПоУмолчанию = ОтборПоУмолчанию(ЗначенияОтбора);
	Если Не ОтборЖурналаРегистрации.Свойство("Событие") Тогда
		ОтборЖурналаРегистрации.Вставить("Событие", ОтборПоУмолчанию);
	КонецЕсли;
	ОтборЖурналаРегистрацииПоУмолчанию.Вставить("Событие", ОтборПоУмолчанию);
	Элементы.ПредставлениеРазделенияДанныхСеанса.Видимость = Не ОбщегоНазначения.ДоступноИспользованиеРазделенныхДанных();
	
	Критичность = "Все события"; // идентификатор.
	
	// Взводится в значение Истина, если нужно, чтобы формирование журнала регистрации проходило не в фоне.
	ЗапускатьНеВФоне = Параметры.ЗапускатьНеВФоне;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	УсловноеОформление.Элементы.Очистить();
	
	//
	Элемент = УсловноеОформление.Элементы.Добавить();
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.Данные.Имя);
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Журнал.Данные");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.НеЗаполнено;
	Элемент.Оформление.УстановитьЗначениеПараметра("Видимость", Ложь);
	
	//
	Элемент = УсловноеОформление.Элементы.Добавить();
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ПредставлениеМетаданных.Имя);
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Журнал.ПредставлениеМетаданных");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.НеЗаполнено;
	Элемент.Оформление.УстановитьЗначениеПараметра("Видимость", Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ПодключитьОбработчикОжидания("ОбновитьТекущийСписок", 0.1, Истина);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура КоличествоПоказываемыхСобытийПриИзменении(Элемент)
	
#Если ВебКлиент Тогда
	КоличествоПоказываемыхСобытий = ?(КоличествоПоказываемыхСобытий > 1000, 1000, КоличествоПоказываемыхСобытий);
#КонецЕсли
	
	ОбновитьТекущийСписок();
	
КонецПроцедуры

&НаКлиенте
Процедура КритичностьПриИзменении(Элемент)
	
	Если Критичность = "Ошибка" Тогда
		ОтборПоУровню = Новый СписокЗначений;
		ОтборПоУровню.Добавить("Ошибка", "Ошибка");
		ОтборЖурналаРегистрации.Удалить("Уровень");
		ОтборЖурналаРегистрации.Вставить("Уровень", ОтборПоУровню);
		ОбновитьТекущийСписок();
	ИначеЕсли Критичность = "Предупреждение" Тогда
		ОтборПоУровню = Новый СписокЗначений;
		ОтборПоУровню.Добавить("Предупреждение", "Предупреждение");
		ОтборЖурналаРегистрации.Удалить("Уровень");
		ОтборЖурналаРегистрации.Вставить("Уровень", ОтборПоУровню);
		ОбновитьТекущийСписок();
	Иначе
		ОтборЖурналаРегистрации.Удалить("Уровень");
		ОбновитьТекущийСписок();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыЖурнал

&НаКлиенте
Процедура ЖурналВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ЖурналРегистрацииКлиент.СобытияВыбор(
		Элементы.Журнал.ТекущиеДанные, 
		Поле, 
		ИнтервалДат, 
		ОтборЖурналаРегистрации);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	
	Если ТипЗнч(ВыбранноеЗначение) = Тип("Структура") И ВыбранноеЗначение.Свойство("Событие") Тогда
		
		Если ВыбранноеЗначение.Событие = "УстановленОтборЖурналаРегистрации" Тогда
			
			ОтборЖурналаРегистрации.Очистить();
			Для Каждого ЭлементСписка Из ВыбранноеЗначение.Отбор Цикл
				ОтборЖурналаРегистрации.Вставить(ЭлементСписка.Представление, ЭлементСписка.Значение);
			КонецЦикла;
			
			Если ОтборЖурналаРегистрации.Свойство("Уровень") Тогда
				Если ОтборЖурналаРегистрации.Уровень.Количество() > 0 Тогда
					Критичность = Строка(ОтборЖурналаРегистрации.Уровень);
				КонецЕсли;
			КонецЕсли;
			
			ОбновитьТекущийСписок();
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОбновитьТекущийСписок()
	
	Элементы.Страницы.ТекущаяСтраница = Элементы.ИндикаторДлительныхОпераций;
	ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.ПолеИндикаторДлительныхОпераций, "ФормированиеОтчета");
	
	РезультатВыполнения = ПрочитатьЖурнал();
	
	ПараметрыОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(ЭтотОбъект);
	ПараметрыОжидания.ВыводитьОкноОжидания = Ложь;
	ОповещениеОЗавершении = Новый ОписаниеОповещения("ОбновитьТекущийСписокЗавершение", ЭтотОбъект);
	
	ДлительныеОперацииКлиент.ОжидатьЗавершение(РезультатВыполнения, ОповещениеОЗавершении, ПараметрыОжидания);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьТекущийСписокЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Результат.Статус = "Выполнено" Тогда
		ЗагрузитьПодготовленныеДанные();
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.ПолеИндикаторДлительныхОпераций, "НеИспользовать");
		Элементы.Страницы.ТекущаяСтраница = Элементы.ЖурналРегистрации;
		ПозиционированиеВКонецСписка();
	ИначеЕсли Результат.Статус = "Ошибка" Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.ПолеИндикаторДлительныхОпераций, "НеИспользовать");
		Элементы.Страницы.ТекущаяСтраница = Элементы.ЖурналРегистрации;
		ПозиционированиеВКонецСписка();
		ВызватьИсключение Результат.КраткоеПредставлениеОшибки;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОтключитьОтбор()
	
	ОтборЖурналаРегистрации = ОтборЖурналаРегистрацииПоУмолчанию;
	Критичность = "Все события"; // идентификатор.
	ОбновитьТекущийСписок();
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьДанныеДляПросмотра()
	
	ЖурналРегистрацииКлиент.ОткрытьДанныеДляПросмотра(Элементы.Журнал.ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ПросмотрТекущегоСобытияВОтдельномОкне()
	
	ЖурналРегистрацииКлиент.ПросмотрТекущегоСобытияВОтдельномОкне(Элементы.Журнал.ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьИнтервалДатДляПросмотра()
	
	Оповещение = Новый ОписаниеОповещения("УстановитьИнтервалДатДляПросмотраЗавершение", ЭтотОбъект);
	ЖурналРегистрацииКлиент.УстановитьИнтервалДатДляПросмотра(ИнтервалДат, ОтборЖурналаРегистрации, Оповещение)
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьОтбор()
	
	УстановитьОтборНаКлиенте();
	
КонецПроцедуры

&НаКлиенте
Процедура ПредставлениеОтбораНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	УстановитьОтборНаКлиенте();
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьОтборПоЗначениюВТекущейКолонке()
	
	КолонкиИсключения = Новый Массив;
	КолонкиИсключения.Добавить("Дата");
	
	Если ЖурналРегистрацииКлиент.УстановитьОтборПоЗначениюВТекущейКолонке(
			Элементы.Журнал.ТекущиеДанные,
			Элементы.Журнал.ТекущийЭлемент,
			ОтборЖурналаРегистрации,
			КолонкиИсключения) Тогда
		
		ОбновитьТекущийСписок();
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыгрузитьЖурналДляПередачиВТехподдержку(Команда)
	ОписаниеОповещения = Новый ОписаниеОповещения("ВыгрузитьЖурналПродолжение", ЭтотОбъект);
	НачатьПодключениеРасширенияРаботыСФайлами(ОписаниеОповещения);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура УстановитьИнтервалДатДляПросмотраЗавершение(ИнтервалУстановлен, ДополнительныеПараметры) Экспорт
	
	Если ИнтервалУстановлен Тогда
		ОбновитьТекущийСписок();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ОтборПоУмолчанию(СписокСобытий)
	
	ОтборПоУмолчанию = Новый СписокЗначений;
	
	Для Каждого СобытиеЖурнала Из СписокСобытий Цикл
		
		Если СобытиеЖурнала.Ключ = "_$Transaction$_.Commit"
			Или СобытиеЖурнала.Ключ = "_$Transaction$_.Begin"
			Или СобытиеЖурнала.Ключ = "_$Transaction$_.Rollback" Тогда
			Продолжить;
		КонецЕсли;
		
		ОтборПоУмолчанию.Добавить(СобытиеЖурнала.Ключ, СобытиеЖурнала.Значение);
		
	КонецЦикла;
	
	Возврат ОтборПоУмолчанию;
КонецФункции

&НаСервере
Функция ПрочитатьЖурнал()
	
	Если РезультатВыполнения <> Неопределено
		И РезультатВыполнения.ИдентификаторЗадания <> Новый УникальныйИдентификатор("00000000-0000-0000-0000-000000000000") Тогда
		ДлительныеОперации.ОтменитьВыполнениеЗадания(РезультатВыполнения.ИдентификаторЗадания);
	КонецЕсли;
	
	ПараметрыОтчета = ПараметрыОтчета();
	
	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияВФоне(УникальныйИдентификатор);
	ПараметрыВыполнения.ОжидатьЗавершение = 0; // запускать сразу
	ПараметрыВыполнения.НаименованиеФоновогоЗадания = НСтр("ru = 'Обновление журнала регистрации'");
	ПараметрыВыполнения.ЗапуститьНеВФоне = ЗапускатьНеВФоне;
	
	РезультатВыполнения = ДлительныеОперации.ВыполнитьВФоне("ЖурналРегистрации.ПрочитатьСобытияЖурналаРегистрации",
		ПараметрыОтчета, ПараметрыВыполнения);
	
	Если РезультатВыполнения.Статус = "Ошибка" Тогда
		Элементы.Страницы.ТекущаяСтраница = Элементы.ЖурналРегистрации;
		ВызватьИсключение РезультатВыполнения.КраткоеПредставлениеОшибки;
	КонецЕсли;
	
	ЖурналРегистрации.СформироватьПредставлениеОтбора(ПредставлениеОтбора, ОтборЖурналаРегистрации, ОтборЖурналаРегистрацииПоУмолчанию);
	
	Возврат РезультатВыполнения;
	
КонецФункции

&НаСервере
Функция ПараметрыОтчета()
	ПараметрыОтчета = Новый Структура;
	ПараметрыОтчета.Вставить("ОтборЖурналаРегистрации", ОтборЖурналаРегистрации);
	ПараметрыОтчета.Вставить("КоличествоПоказываемыхСобытий", КоличествоПоказываемыхСобытий);
	ПараметрыОтчета.Вставить("УникальныйИдентификатор", УникальныйИдентификатор);
	ПараметрыОтчета.Вставить("МенеджерВладельца", Обработки.ЖурналРегистрации);
	ПараметрыОтчета.Вставить("ДобавлятьДополнительныеКолонки", Ложь);
	ПараметрыОтчета.Вставить("Журнал", РеквизитФормыВЗначение("Журнал"));

	Возврат ПараметрыОтчета;
КонецФункции

&НаСервере
Процедура ЗагрузитьПодготовленныеДанные()
	Результат = ПолучитьИзВременногоХранилища(РезультатВыполнения.АдресРезультата);
	СобытияЖурнала      = Результат.СобытияЖурнала;
	
	ЖурналРегистрации.ПоместитьДанныеВоВременноеХранилище(СобытияЖурнала, УникальныйИдентификатор);
	
	ЗначениеВДанныеФормы(СобытияЖурнала, Журнал);
КонецПроцедуры

&НаКлиенте
Процедура ПозиционированиеВКонецСписка()
	Если Журнал.Количество() > 0 Тогда
		Элементы.Журнал.ТекущаяСтрока = Журнал[Журнал.Количество() - 1].ПолучитьИдентификатор();
	КонецЕсли;
КонецПроцедуры 

&НаКлиенте
Процедура УстановитьОтборНаКлиенте()
	
	ОтборФормы = Новый СписокЗначений;
	Для Каждого КлючИЗначение Из ОтборЖурналаРегистрации Цикл
		ОтборФормы.Добавить(КлючИЗначение.Значение, КлючИЗначение.Ключ);
	КонецЦикла;
	
	ОткрытьФорму(
		"Обработка.ЖурналРегистрации.Форма.ОтборЖурналаРегистрации", 
		Новый Структура("Отбор, СобытияПоУмолчанию", ОтборФормы, ОтборЖурналаРегистрацииПоУмолчанию.Событие), 
		ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура КритичностьОчистка(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
КонецПроцедуры

&НаКлиенте
Процедура ВыгрузитьЖурналПродолжение(Подключено, ДополнительныеПараметры) Экспорт
	
	Если Подключено Тогда
		Режим = РежимДиалогаВыбораФайла.Сохранение;
		ДиалогСохранения = Новый ДиалогВыбораФайла(Режим);
		ДиалогСохранения.МножественныйВыбор = Ложь;
		ДиалогСохранения.Фильтр = НСтр("ru = 'Данные журнала регистрации'") + "(*.xml)|*.xml";
		ДиалогСохранения.ПолноеИмяФайла = "EventLog";
		ОписаниеОповещения = Новый ОписаниеОповещения("ВыгрузитьЖурналЗавершение", ЭтотОбъект);
		ДиалогСохранения.Показать(ОписаниеОповещения);
	Иначе
		ПолучитьФайл(ВыгрузкаЖурналаРегистрации(), "EventLog.xml", Истина);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыгрузитьЖурналЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ДанныеЖурнала = ВыгрузкаЖурналаРегистрации();
	
	ПолноеИмяФайла = Результат[0];
	ПолучаемыеФайлы = Новый Массив;
	ПолучаемыеФайлы.Добавить(Новый ОписаниеПередаваемогоФайла(ПолноеИмяФайла, ДанныеЖурнала));
	
	Обработчик = Новый ОписаниеОповещения();
	НачатьПолучениеФайлов(Обработчик, ПолучаемыеФайлы, ПолноеИмяФайла, Ложь);
	
КонецПроцедуры

&НаСервере
Функция ВыгрузкаЖурналаРегистрации()
	Возврат ЖурналРегистрации.ЖурналДляТехподдержки(ОтборЖурналаРегистрации, КоличествоПоказываемыхСобытий);
КонецФункции

#КонецОбласти
