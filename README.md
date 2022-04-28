# Проект 1
Опишите здесь поэтапно ход решения задачи. Вы можете ориентироваться на тот план выполнения проекта, который мы предлагаем в инструкции на платформе.

ход решения задачи
# 1. Постройте витрину для RFM-анализа
## 1.1. Выясните требования к целевой витрине
- Витрина должна располагаться в той же базе в схеме analysis
- Витрина должна состоять из таких полей:  
    user_id  
    recency (число от 1 до 5)  
    frequency (число от 1 до 5)  
    monetary_value (число от 1 до 5)  
- В витрине нужны данные с начала 2021 года.
- Назовите витрину dm_rfm_segments
- Обновления не нужны.
- Успешно выполненный заказ - заказ со статусом Closed.
## 1.2. Изучите структуру исходных данных
### 1.2.1 Подключитесь к базе данных и изучите структуру таблиц.
Изучено
### 1.2.2 Создайте текстовой документ, в котором будете описывать решение. В этом же документе зафиксируйте, какие поля вы будете использовать для расчёта витрины.
- users: id
- orders: order_ts, payment, status
- orderstatuses: id, key
## 1.3. Проанализируйте качество данных
### 1.3.1 Изучите качество входных данных.
Изучено
### 1.3.2 В итоговом документе опишите, насколько качественные данные хранятся в источнике.
#### 1.3.2.1 Дубли в данных
Во всех 6 таблицах дубли отсутствуют. Проверочный скрипт:  
'''
with cte1 as(
  select count(*) as count_all, count (distinct id) as count_distinct from production.users u 
  union
  select count(*), count (distinct order_id) from production.orders o4 
  union
  select count(*), count (distinct id) from production.products p 
  union
  select count(*), count (distinct id) from production.orderstatuses o 
  union
  select count(*), count (distinct id) from production.orderstatuslog o2 
  union
  select count(*), count (distinct id) from production.orderitems o3 )
select *, count_all = count_distinct as flg from cte1
where (count_all = count_distinct) != true 
'''
#### 1.3.2.2 Пропущенные значения в важных полях
пропуски отсутствуют.  
Проверочный скрипт для каждой таблицы:
'''
select * from production.[таблица] 
where (column1 is null) or ... or (columnN is null) 
'''


### 1.3.3 Укажите, какие инструменты для обеспечения качества данных использованы в таблицах в схеме production.

## 1.4. Подготовьте витрину данных
### 1.4.1 Сделайте представление для таблиц из базы production.
### 1.4.2 Напишите DDL-запрос для создания витрины
### 1.4.3 Напишите SQL-запрос для заполнения витрины

# 2. Доработка представлений
