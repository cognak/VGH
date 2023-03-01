//Заполняем структуру ответа
Процедура ЗаполнитьСтруктуруОтвета(СтруктураОтвет,КодОтвета,ТекстОшибки,Отработало,ДанныеОтвета) Экспорт
	СтруктураОтвет.КодОтвета 	= КодОтвета;
	СтруктураОтвет.ТекстОшибки	= ТекстОшибки;
	СтруктураОтвет.Отработало	= Отработало;
	СтруктураОтвет.ДанныеОтвета = ДанныеОтвета;	
КонецПроцедуры

#Область СерилизацияДесирилизация
Функция ЗаписатьДанныеВJSON(ВхПараметры,РезультатОтвет) Экспорт
	ПараметрыJSON	= Новый ПараметрыЗаписиJSON();
	ЗаписьJSON		= Новый ЗаписьJSON;
	ЗаписьJSON.ПроверятьСтруктуру = Истина;
	ЗаписьJSON.УстановитьСтроку(ПараметрыJSON);
	Попытка
		ЗаписатьJSON(ЗаписьJSON, РезультатОтвет);
		Результат = ЗаписьJSON.Закрыть();
	Исключение
		Результат = "";	
	КонецПопытки;
	
	Возврат Результат;
	
КонецФункции	

Функция СтандартныеПараметрыJSON() Экспорт
	ПараметрыJSON	= Новый Структура;	
	ПараметрыJSON.Вставить("ПереносСтрок",ПереносСтрокJSON.Нет);
	ПараметрыJSON.Вставить("СимволОтступа"," ");
	ПараметрыJSON.Вставить("ИспользоватьДвойныеКавычки",Истина);
	ПараметрыJSON.Вставить("ЭкранированиеСимволов",ЭкранированиеСимволовJSON.Нет);
	ПараметрыJSON.Вставить("ЭкранироватьУгловыеСкобки",Ложь);
	ПараметрыJSON.Вставить("ЭкранироватьАмперсанд",Ложь);
	ПараметрыJSON.Вставить("ЭкранироватьОдинарныеКавычки",Ложь);
	ПараметрыJSON.Вставить("ЭкранироватьРазделителиСтрок",Ложь);
	ПараметрыJSON.Вставить("ЭкранироватьСлешь",Ложь);

	Возврат ПараметрыJSON;	
	
КонецФункции
#КонецОбласти

#Область ФорматыОтвета
#КонецОбласти
//Процедура ПолучитьРезультатНаСервере(МетодСервиса,вхПараметры,Результат)  Экспорт
//	Сайт_ПараметрыПодключения=ПолучитьПараметрыподключениякСайту("Mangento");
//	Если Сайт_ПараметрыПодключения=Неопределено Тогда
//		Возврат;
//	КонецЕсли; 
//	вхПараметры.Вставить("key",Сайт_ПараметрыПодключения.GUID);
//	СтруктураАдресСервера =ОбщегоНазначенияКлиентСервер.СтруктураURI(Сайт_ПараметрыПодключения.HTTPСервер);
//	перСервер = СтруктураАдресСервера.Хост;
//	перПорт   = Сайт_ПараметрыПодключения.Порт; 
//	перПорт1  = СтруктураАдресСервера.Порт; 
//	перПользователь =Сайт_ПараметрыПодключения.ИмяПользователя;
//	перПароль =Сайт_ПараметрыПодключения.Пароль;
//	Если ВРег(СтруктураАдресСервера.Схема)="HTTPS" Тогда
//		ssl = Новый ЗащищенноеСоединениеOpenSSL(
//		Новый СертификатКлиентаWindows(),
//		Новый СертификатыУдостоверяющихЦентровWindows());
//	Иначе	
//		ssl = Неопределено;
//	КонецЕсли;
//	Попытка		
//		Если перПорт <= 0 Тогда 
//			HTTPСоединение = Новый HTTPСоединение(перСервер,,перПользователь,перПароль,,,ssl,Ложь);
//		Иначе 
//			HTTPСоединение = Новый HTTPСоединение(перСервер,,перПользователь,перПароль,,,ssl,Ложь);
//		КонецЕсли;	
//	Исключение
//		Сообщить("Подключение не прошло по причине "+ОписаниеОшибки());
//		//Подчищаем соединение
//		HTTPСоединение = Неопределено;
//		Возврат;
//	КонецПопытки;
//	Если МетодСервиса = "GET"  Тогда
//		//ОбязательныеПараметры=Новый  Структура("ИмяМетода,Order");
//		//ПроверитьЗаполнениеПараметров()
//		//Создаем параметры запроса
//		//https://dev.ants.co.ua/api/rest/parcel?key=9a23a849787bb1388b8b8fa23f3aa789&order=100925836
//		ИмяМетода="";
//		Если вхПараметры.Свойство("ИмяМетода",ИмяМетода) Тогда
//			перСтруктураЗапроса = "";
//			Если ЗначениеЗаполнено(Сайт_ПараметрыПодключения.GUID) Тогда 
//				перСтруктураЗапроса = "?key=" + Сайт_ПараметрыПодключения.GUID ;	
//			КонецЕсли;                     
//			Если ЗначениеЗаполнено(вхПараметры.Order) Тогда
//				перСтруктураЗапроса = ?(ПустаяСтрока(перСтруктураЗапроса),
//												"?order="+вхПараметры.Order,
//												перСтруктураЗапроса+"&order="+вхПараметры.Order);		
//			КонецЕсли;
//			
//			перРесурсНаСервере=СтруктураАдресСервера.ПутьНаСервере+"parcel"+перСтруктураЗапроса;		
//			перРесурсНаСервере=СтруктураАдресСервера.ПутьНаСервере+ИмяМетода+перСтруктураЗапроса;		
//			Заголовки = Новый Соответствие();
//			Заголовки.Вставить("Content-Type", "application/json");
//			HTTPЗапрос = Новый HTTPЗапрос(перРесурсНаСервере,Заголовки);
//			
//			HTTPОтвет = HTTPСоединение.ВызватьHTTPМетод("GET",HTTPЗапрос);
//			
//			//Получаем ответный текст или текст ошибки
//			ТелоОтвета = HTTPОтвет.ПолучитьТелоКакСтроку(КодировкаТекста.UTF8);
//			ЧтениеJSON=Новый ЧтениеJSON; 
//			ЧтениеJSON.УстановитьСтроку(ТелоОтвета);
//			Результат=ПрочитатьJSON(ЧтениеJSON,,);
//			ЧтениеJSON.Закрыть();
//		иначе
//			//не задан имчМетода
//		КонецЕсли; // имяМетода
//	КонецЕсли;                              
//	Если МетодСервиса = "POST" Тогда
//		телоЗапроса=Новый Структура("key,order,data");
//		
//		ЗаполнитьЗначенияСвойств(телоЗапроса,вхПараметры);
//		телоЗапроса.Вставить("data",вхПараметры.Тело.data);
//		массивТела=Новый Массив;
//		массивТела.Добавить(телоЗапроса);
//		ТелоЗапросаJSON=вгхОбщиеПроцедурыИФункции.ЗаписатьДанныеВJSON(Неопределено,массивТела);
//		перРесурсНаСервере=СтруктураАдресСервера.ПутьНаСервере+вхПараметры.ИмяМетода;
//		Заголовки = Новый Соответствие();
//		Заголовки.Вставить("Content-Type", "application/json");
//		HTTPЗапрос = Новый HTTPЗапрос(перРесурсНаСервере,Заголовки);
//		HTTPЗапрос.УстановитьТелоИзСтроки( ТелоЗапросаJSON );
//		HTTPОтвет = HTTPСоединение.ВызватьHTTPМетод("POST",HTTPЗапрос);
//		ТелоОтвета = HTTPОтвет.ПолучитьТелоКакСтроку(КодировкаТекста.UTF8);
//		хх=1;
//	
//	КонецЕсли;
//	//Подчищаем соединение
//	HTTPСоединение = Неопределено;
//КонецПроцедуры
Функция ПолучитьПараметрыподключениякСайту(ИмяСайта) Экспорт 
Запрос = Новый Запрос;
Запрос.Текст = "ВЫБРАТЬ
               |	стСайты.GUID КАК GUID,
               |	стСайты.HTTPСервер КАК HTTPСервер,
               |	стСайты.Порт КАК Порт,
               |	стСайты.ИмяПользователя КАК ИмяПользователя,
               |	стСайты.Пароль КАК Пароль
               |ИЗ
               |	Справочник.стСайты КАК стСайты
               |ГДЕ
               |	стСайты.ИспользоватьПоУмолчанию";

Запрос.УстановитьПараметр("Имя",ИмяСайта);        
Результат = Запрос.Выполнить();
Если Результат.Пустой() Тогда
	Возврат Неопределено;
Иначе
	Возврат вгОбщегоНазначения.РезультатЗапросаВСтруктуру(Результат);
КонецЕсли;
КонецФункции // ()

Функция ПолучитьДокументОтгрузка(order) Экспорт
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	Отгрузка.order КАК order,
	               |	Отгрузка.Ссылка КАК Ссылка
	               |ИЗ
	               |	Документ.ОтгрузкаПоЗаказу КАК Отгрузка
	               |ГДЕ
	               |	Отгрузка.order = &order";
	
	Запрос.УстановитьПараметр("order", order);
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		// нет такого
		Возврат Документы.ОтгрузкаПоЗаказу.ПустаяСсылка();
	Иначе
		//Есть такой
		Выборка=Результат.Выбрать();
		Выборка.Следующий();
		Возврат Выборка.Ссылка;
	КонецЕсли;
КонецФункции
