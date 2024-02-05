% Пример простого персептрона с 1 слоем

% Вектор весов для 2 входов
w = [1; 10];

% Смещение-это параметры, которые определяют, как веса входных признаков влияют на выход персептрона
b = 3;

%Матрица входных данных, где каждая строка представляет собой вектор входа. 
X = [-3 1; 2 -1; 2 2; 3 -1];

% Целевые выходы
target_outputs = [1; 1; 0; 0];

% Количество эпох обучения
epochs = 10000;

% Скорость обучения
learning_rate = 0.1;

% Максимальная допустимая ошибка
max_error = 0.01;

% Цикл обучения
for epoch = 1:epochs
    total_error = 0;
    
    % Обработка каждого входа
    for i = 1:size(X, 1)
        % Пороговая функция активации
        activation_function = @(x) double(x >= 0);
        output = activation_function(X(i, :) * w + b);

        % Рассчет ошибки
        error = target_outputs(i) - output;
        total_error = total_error + abs(error);

        % Обновление весов и смещения исп градиентный спуск
        w = w + learning_rate * error * X(i, :)';
        b = b + learning_rate * error;
    end

    % Рассчет средней ошибки
    average_error = total_error / size(X, 1);
    
    % Вывод информации об эпохе
    disp(['Эпоха ' num2str(epoch) ', Средняя ошибка: ' num2str(average_error)]);

    % Проверка завершения обучения
    if average_error < max_error
        disp(['Обучение завершено на эпохе ' num2str(epoch)]);
        break;
    end
end

% Вывод окончательных весов и смещения
disp('Окончательные веса:');
disp(w);
disp('Окончательно смещение:');
disp(b);
