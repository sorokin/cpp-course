## Intrusive контейнеры (1 пара)
1. Понятие intrusive контейнеров, примеры
2. Сравнение с обычными контейнерами
    * Потребление памяти
    * Эффективность операций
    * Бонусы `intrusive_list`'а по сравнению с обычным
    * Безопасность исключений
    * Вопрос владения
3. Multi-index контейнеры
4. `linked_ptr`
5. `intrusive_ptr`

## Rvalue-references (2 пары)
1. Передача структур в функцию по значению
2. Различия при передаче lvalue и rvalue
4. Возврат структур из функции
5. Return value optimization (RVO)
6. Named return value optimization (NRVO)
7. Обсуждение когда передавать параметры функции по ссылке, а когда по значению
8. Проблема хранения в контейнерах non-copyable объектов и объектов с дорогим копированием
9. Понятие move-операции
10. Rvalue-references
    * overloading
11. Соглашения по использованию rvalue-references, move-семантика
12. `std::move`
    * новое поведение `std::swap`
    * тонкость с реализацией move-присваивание через swap, поскольку swap реализован через move
    * требования на move-присваивание от `*this`
13. Defining move special member functions
14. Понятие xvalue
    * xvalue/prvalue, продление времени жизни при бинде к rvalue-ссылке
    * copy elision
15. rvalue references for `*this`
16. сравнение с destructive move

## Умные указатели (1 пара)
1. `unique_ptr`
2. `shared_ptr`
    * custom deleter
    * aliasing-конструктор
    * внутреннее устройство `shared_ptr`
    * `std::make_shared`
    * `weak_ptr`
    * замечание о том, что `weak_ptr::expired` racy и надо использовать `weak_ptr::lock`
    * pitfall: private inheritance from `std::enable_shared_for_this`
    * *_pointer_cast
3. pimpl используя `unique_ptr` и `shared_ptr`

## Perfect-forwarding (2 пары)
1. Проблема perfect-fowarding
2. Вывод параметров шаблона при использовании rvalue-ссылок
3. Reference-collapsing rule
4. `std::forward`
5. Variadic templates
    * expand сразу двух pack'ов
    * для template template параметров http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2008/n2555.pdf
6. Примеры использования perfect forwarding: `emplace`, `emplace_{front,back}`, `make_{unique,shared,tuple}`
7. Возврат результата в при perfect-fowarding
8. decltype
    * http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2011/n3276.pdf
9. `std::declval`
10. Правила поиска имен, trailing return type
11. `nullptr`

## Вывод типов и анонимные функции (2 пары)
1. Статический vs динамический полиморфизм
2. Анонимные функции
    * Local and unnamed types as template arguments
3. Capture список в анонимных функциях
    * Generalized lambda capture C++14
    * проблема захвата this, в конструкторе, если параметр и
      член-данных называются одинаково
4. Свойства анонимных функций
    * копируемость
    * присваиваемость
    * move-амость
    * конверсия в указатель на функцию
5. Вывод типа возвращаемого значения в лямбдах и в обычных функциях C++14
    * в темплейтных функциях
    * упомянуть про SFINAE
6. auto
    * вывод типа в случае наличия нескольких деклараторов
    * вывод при наличии ptr/ref деклараторов
    * вывод с rvalue-ссылками
    * различия вывода auto и параметра шаблона
    * `decltype(auto)` (C++14)
    * auto в return-типах функции

## Паттерн type-erasure, runtime и compile-time полиморфизм (1 пара)
1. `std::function`
2. `any_iterator`
4. `any_range`
3. `std::any` (C++17)
5. Boost.TypeErasure
5. `std::mem_fn`
    * http://cplusplus.github.io/LWG/lwg-defects.html#2048
6. `std::bind`
    * полезность при необходимости скопировать захватываемые данные
7. `reference_wrapper`
    * defaulted and deleted members
8. Ещё раз поговорить про статический vs динамический полиморфизм

## Сигналы (1 пара)
1. Зачем нужны
2. Почему наивная реализация не работает
3. Почему копирующая реализация не работает
4. Привести пример работающей реализации
5. Понятие reentrancy

## Misc vocabulary types (1 пара)
1. `std::optional` (С++17)
    * включить сюда рассуждения про важность сохранения инварианта класса
      и как хорошо, когда часть инварианта можно закодировать в типе
2. Unrestricted unions
3. `std::aligned_storage`
4. Управление выравниванием (alignof, alignas)
5. `std::variant` (C++17)
6. `std::tuple`
    * сравнение tuple со структурами
    * structured binding (C++17)
    * изменение value-category при return переменных при structured binding'е
7. `string_view`
   * конструирование от temporary string
   * view на смуванную small-строку
   * забавный курьез: из перегрузок `foo(bool)` и `foo(string_view)` при вызове `foo("aba")` выберется первая, решение -- `foo("aba"sv)`

## Многопоточность (2 пары)
1. понятние многопоточности
2. std::thread
3. понятие race condition
4. std::mutex
5. закон Амдала
6. понятние deadlock
7. std::condition_variable
    * пример concurrent_queue
8. Упомянуть про TLS

## Оптимизация многопоточных программ (1 пара)
1. Общие ресурсы
    * sharing
2. std::atomic
    * false sharing
    * relaxed atomics
3. Многопоточность в аллокаторах памяти

## Ещё многопоточность (2 пары)
1. Рассуждение про thread-safe signal
    * вывод, что mutex'ы плохо инкапсулируются и если мы хотим избежать deadlock'ов, нам нужно смотреть на программу в целом, а не на каждую её часть по отдельности
2. Cancellation
    * взаимодействие с блокирующими операциями
    * std::jthread
3. Поток как RAII'шный ресурс
4. Понятие асинхронных операций
5. Потоки+блокирующие операции vs. асинхронные операции
6. poll
7. Понятие message-loop'а

## Введение в Qt (1 пара)
1. Message loop
    * модальные диалоги, вложенные message loop'ы
2. Владение
3. Сигналы
    * Межпотоковое взаимодействие
4. Qt Designer
5. UIC
6. MOC

## Динамическая загрузка (1 пара)
1. Кодирование инструкций, position (in-)dependent инструкции
2. Динамические библиотеки
3. Релокации
4. Загрузка на Windows
    * Понятие base address
5. Загрузка на Linux
    * Линковка разных модулей
    * GOT
    * Ленивая линковка
    * PLT

## fibers/stackful coroutines (2 пары)
1. Исполнение потоков, регистры, контекст исполения, предсказание теоретической возможности реализации
2. Пример
3. Обзор библиотечных функций

## Трамполины, динамическая генерация кода (1 пара)
1. Предсказание теоретической возможности реализации
2. Пример
3. Локальные функции

## Ranges (2 пары)
## stackless coroutines (1 пары)
## Модули (2 пары)
## Concepts (2 пары)

## Всякие полезности при написании классов (1 пара)
1. Explicit override control, final classes
    * указать, что это context-sensitive keyword
2. Delegating constructors
    * уточнение когда вызывается деструктор
3. Inheriting constructors
    * разные правила для C++11 и C++17
4. Explicit conversion operators
5. Extended friend declarations
6. Non-static data member initializers
7. Strongly-typed enums
8. Forward declarations for enums
9. Inline namespaces
10. Nested namespace definition

## Uniform initialization (1 пара)
* Решаемые задачи
    * инициализация контейнеров так же кратно как встроенных массивов -- initializer lists
    * инициализация POD-структур как в С -- aggregate initialization
    * designated initializers (C++2a)
    * неоднозначность грамматики: function declaration / direct initialization
* Инициализация контейнеров
    * разный результат для `vector(1, 2)` и `vector{1, 2}`
* Инициализация POD-структур
    * не работает с forwarding-функциями (emplace, make, ...)
* Использование {} для инициализации
    * `vector<string> ss {{"aba", "caba"}}`
    * Нетривиальное взаимодействие с `auto`

## Metaprogramming (2 пары)
1. Template type aliases
2. Template variables
3. Самый эффективный в смысле compilation time способ отсечься по SFINAE -- default template arguments, теперь и для function templates
4. Static assertions
5. Expression SFINAE
6. Std type traits
7. Constexpr functions
   * Разница с точки зрения компилятора между вычислением constexpr functions и variables -- значения последних кэшируются
8. Пример использования -- вычисление аргумента `noexcept`
9. Бонусы
   * `std::void_t`
   * `if constexpr`
   * fold expressions
10. Явное инстанцирование темплейтов и подавление инстанцирования

## Расширения стандартной библиотеки (2 пары)
* emplace и move semantics везде, даже в std::pair
* transparent comparator и heterogeneous lookup
* std::filesystem -- вот есть такой, очень кратко
* std::chrono -- вот есть такой, очень кратко + UDL (стандартные и как писать свои)
* unordered containers и специализация `std::hash` для своей структуры
   * согласованность с `operator ==`
   * пессимизация из-за забытого `noexcept`
* Внешнии функции в интерфейсе контейнера
    * `std::begin`
    * `std::end`
    * `std::size`
* Range-based for loop
    * `auto &&`
    * проблема итерации по контейнеру без &
* реализуем vector::emplace_back
* реализуем vector::insert(range)
* реализуем range adaptor правильно (как в range-v3, а не как в boost.range)
