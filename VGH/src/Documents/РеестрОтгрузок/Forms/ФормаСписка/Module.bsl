&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	ТекущееРабочееМесто = ПараметрыСеанса.РабочееМестоКлиента;
	ТекущееУстройство=ПараметрыСеанса.ТекущееУстройство ;
	
КонецПроцедуры

&НаКлиенте
Процедура НапечататьРеестр(Команда)
	
	Если ТекущийЭлемент.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	НомерРеестра = ТекущийЭлемент.ТекущиеДанные.Номер;
	
	#Если ВебКлиент Тогда
		
	#Иначе
		
		ИмяКоманды=Команда.Имя;
		
		// Проверка принтеров
		ПараметрыПечати=ПолучитьПараметрыПечатиНаСервере(ТекущееРабочееМесто);

		СтруктураОтвет = Новый Структура("ДанныеОтвета,Отработало,ТекстОшибки,КодОтвета","",Истина,"",200);	

		ПараметрыЗапроса = Новый Структура("order,type,key,number","999999999-999","reestr","",НомерРеестра);
				
		вхПараметры = Новый Структура("ИмяМетода,ПараметрыЗапроса", "print", ПараметрыЗапроса);
				
		Результат = Неопределено;

		// запрос на сайте ссылки на документа для печати
		вгхОбщийПроцедурыФункцииСервер.ПолучитьРезультатНаСервере("POST",вхПараметры ,СтруктураОтвет);
			
		Если СтруктураОтвет.Отработало Тогда
			
			Результат=СтруктураОтвет.ДанныеОтвета;
			Если Результат.Свойство("error") тогда
				ТекстОшибки = Результат.error[0].info.message;
				ПоказатьПредупреждение(,"Ответ сайта: "+ТекстОшибки,);
				Возврат;
			КонецЕсли;
			
			Если Результат.Свойство("success") тогда

				Если Результат.success[0].status="OK" Тогда
					СсылкаНаДокументПечати=СтруктураОтвет.ДанныеОтвета.success[0].doc;
					ОтметитьНапечатаность(ТекущийЭлемент.ТекущиеДанные.Ссылка);
					Элементы.Список.Обновить(); 
					ПечатьДокументаПоСсылкеЗавершение(Новый Структура("Значение",КодВозвратаДиалога.Да),Новый Структура("ИмяКоманды,СсылкаНаДокумент,MP,НомерДокумента",ИмяКоманды,СсылкаНаДокументПечати,Ложь,"999999999-999"));
				Иначе 
					текстОшибки=СтруктураОтвет.ДанныеОтвета.info.message;
					А = Новый Массив();
					А.Добавить("Ошибка: ");
					А.Добавить(Новый ФорматированнаяСтрока(
					текстОшибки,
					Новый Шрифт(,,Истина)));
					Стр = Новый ФорматированнаяСтрока(А);
					ПоказатьПредупреждение(,стр,);
					хх=1;
				КонецЕсли;
			Иначе
				
			КонецЕсли;
		Иначе 
			А = Новый Массив();
			А.Добавить("Ошибка: ");
			А.Добавить(Новый ФорматированнаяСтрока(
			СтруктураОтвет.ТекстОшибки,
			Новый Шрифт(,,Истина)));
			Стр = Новый ФорматированнаяСтрока(А);
			ПоказатьПредупреждение(,стр,);
			Возврат;
			хх=1;
		КонецЕсли;
		
	#КонецЕсли
КонецПроцедуры

&НаКлиенте
Процедура ПечатьДокументаПоСсылкеЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	//ОписаниеКоманды = ДополнительныеПараметры.ОписаниеКоманды;
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли; 

	СсылкаНаДокумент= ДополнительныеПараметры.СсылкаНаДокумент;

	Если Результат.Значение <> КодВозвратаДиалога.Да Тогда
		Возврат;
	КонецЕсли;
	// получить документ по ссылке
	MP = Ложь;
	ДополнительныеПараметры.Свойство("MP",MP);
	НомерДокумента = "";
	ДополнительныеПараметры.Свойство("НомерДокумента", НомерДокумента);
	
	//+Криворучко
	//врФайлПечатнойФормы=ПолучитьФайлССервера(СсылкаНаДокумент,MP);
	//
	УникальныйИдентификатор1 = ЭтаФорма.УникальныйИдентификатор;
	Адрес = вгхОбщийПроцедурыФункцииСервер.ПолучитьФайлССервера(СсылкаНаДокумент,MP,УникальныйИдентификатор1,,НомерДокумента);
	#Если ВебКлиент Тогда //***д***//
		Каталог = КаталогВременныхФайлов();
		ИмяФайла = Строка(Новый УникальныйИдентификатор) + ".pdf";
		врФайлПечатнойФормы = Каталог + ИмяФайла;
	#Иначе
		ВремКаталог = "";
		Выполнить("ВремКаталог = ПолучитьИмяВременногоФайла()");
		СоздатьКаталог(ВремКаталог);
		врФайлПечатнойФормы = ВремКаталог + "\temp.pdf";
	#КонецЕсли   //***д***//

	Описание=Новый ОписаниеПередаваемогоФайла(врФайлПечатнойФормы,Адрес);
	МассивОписаний=Новый Массив;
	МассивОписаний.Добавить(Описание);
	ПолучитьФайлы(МассивОписаний,,,Ложь);
	//ПолучитьФайл(Адрес,врФайлПечатнойФормы,Ложь);
	//-

	мфайл = Новый Файл(врФайлПечатнойФормы);
	
	ПараметрыПечати=ПолучитьПараметрыПечатиНаСервере(ТекущееРабочееМесто);
	ИмяПринтера=ПараметрыПечати.ИмяПринтераДокументов;
	// проверить существует ли принтер на компе с таким именем
	//МассивПринтеров=ПолучитьМассивПринтеров();
	//Если МассивПринтеров.Найти(ИмяПринтера)=Неопределено Тогда
	//
	//	А = Новый Массив();
	//	А.Добавить(Новый ФорматированнаяСтрока("Имя принтера """+ИмяПринтера+""" не найдено.",Новый Шрифт(,12,Истина)));
	//	А.Добавить(Новый ФорматированнаяСтрока(Символы.ПС+" Печать не возможна.",Новый Шрифт(,14,Истина)));
	//	
	//	Стр = Новый ФорматированнаяСтрока(А);
	//	ПоказатьПредупреждение(,стр);
	//	возврат;
	//КонецЕсли; 
	ПоказатьОповещениеПользователя(НСтр("ru='Документ отправлен на печать';uk='Документ відправлен на друк'"),	, ,	БиблиотекаКартинок.Информация32);
	
	//ИмяПринтера = "Microsoft Print to PDF";
	WshShell = новый COMОбъект("WScript.Shell");
	//ReturnCode=WshShell.Run("""C:\Program Files (x86)\Foxit Software\Foxit Reader\FoxitReader.exe"" /t "+мфайл.ПолноеИмя+" "+ИмяПринтера, 1, True);
	ReturnCode=WshShell.Run("""C:\Program Files (x86)\Foxit Software\Foxit Reader\FoxitReader.exe"" /t "+""""+врФайлПечатнойФормы+""""+" "+ИмяПринтера, 1, True);

КонецПроцедуры

&НаСервере
Процедура ОтметитьНапечатаность(СсылкаНаДокумент)
	
	ОбъектДокумент = СсылкаНаДокумент.ПолучитьОбъект();
	ОбъектДокумент.Напечатан = Истина;
	ОбъектДокумент.Записать();
	
КонецПроцедуры
&НаСервере
Функция ПолучитьПараметрыПечатиНаСервере(ТекущееРабочееМесто)
	
	Возврат Новый Структура("ИмяПринтераДокументов,ИмяПритераЭтикеток",ТекущееРабочееМесто.ИмяПринтераДокументов,ТекущееРабочееМесто.ИмяПринтераЭтикеток);	
	
КонецФункции // ПолучитьИмяПринтераНаСервере()

&НаКлиенте
Функция ПолучитьМассивПринтеров() Экспорт
	
	WScriptNetwork = Новый COMОбъект("WScript.Network");
	МассивПринтеров = Новый Массив;
	Printers = WScriptNetwork.EnumPrinterConnections ();
	КоличествоПринтеров = Printers.length - 1;
		
	Для Номер = 0 По КоличествоПринтеров Цикл
		
		ТекСтруктура = Новый Структура("Порт, Имя");
		ТекСтруктура.Порт = Printers.Item(Номер);
		Номер = Номер + 1;
		ТекСтруктура.Имя = Printers.Item(Номер);
		МассивПринтеров.Добавить(Printers.Item(Номер));
		//МассивПринтеров.Добавить(ТекСтруктура);
		
	КонецЦикла;
	
	Возврат МассивПринтеров;
	
КонецФункции 
