
Функция ШаблонWeightsПолучитьРазмеры(Запрос)
	
	Ответ = Новый HTTPСервисОтвет(200);	
	
	command = Запрос.ПараметрыURL["command"];
	
	СтрокаJSON = WeightsWeb.ПолучитьРазмер(command);
	
	Ответ.УстановитьТелоИзСтроки(СтрокаJSON,КодировкаТекста.ANSI);
	
	Возврат Ответ;
	
КонецФункции
