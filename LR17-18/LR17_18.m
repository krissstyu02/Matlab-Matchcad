% Генерация обучающих данных
x1 = linspace(-1, 1, 100);
x2 = linspace(-1, 1, 100);
[X1, X2] = meshgrid(x1, x2);
d = (1 - 2*X1.^2) + (3 - X2).^2;
data = [X1(:), X2(:), d(:)];

% Сохранение обучающих данных в файл
save('data.dat', 'data', '-ascii');

% Загрузка обучающих данных
data = load('data.dat');

% Варианты типов функций принадлежности
membership_functions = ["gaussmf", "trimf", "trapmf"];

% Инициализация ячеек для хранения результатов
output_cell = cell(length(membership_functions), 1);
error_cell = cell(length(membership_functions), 1);

% Обучение и оценка адекватности для каждого типа функции принадлежности

% Цикл по всем типам функций принадлежности
for i = 1:length(membership_functions)
    
    % Задание опций для обучения ANFIS
    options = anfisOptions('Epoch', 100);
    
    % Задание числа функций принадлежности для каждого входа
    opt.NumMembershipFunctions = [3 5 5];
    
    % Задание типа функций принадлежности для каждого входа
    opt.InputMembershipFunctionType = repmat(membership_functions(i), 1, 3);
    
    % Обучение ANFIS на предоставленных данных
    fis_optimized = anfis(data, options, opt);

    % Оценка адекватности модели на новых данных
    output = evalfis([X1(:), X2(:)], fis_optimized);
    
    % Вычисление ошибки между предсказанными и фактическими значениями
    error = d(:) - output;

    % Сохранение результатов в ячейки для каждого типа функции принадлежности
    output_cell{i} = output;
    error_cell{i} = error.^2;
    
end


% Создание таблицы с результатами
results_table = table(repelem(X1(:), length(membership_functions)), ...
                      repelem(X2(:), length(membership_functions)), ...
                      repmat(d(:), length(membership_functions), 1), ...
                      cell2mat(output_cell), cell2mat(error_cell), ...
                      repelem(membership_functions', length(X1(:)), 1), ...
                      'VariableNames', {'x1', 'x2', 'd_target', 'output', 'error', 'membership_function'});

% Вывод таблицы
disp(results_table);
writetable(results_table, 'results_table.csv');
