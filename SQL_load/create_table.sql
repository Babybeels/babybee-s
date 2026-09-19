CREATE TABLE used_cars (
    id int PRIMARY KEY,
    brand varchar(100),
    model varchar(100),
    model_year int,
    mileage int,
    fuel_type varchar(100),
    engine text,
    transmission varchar(100),
    ext_col varchar(100),
    int_col varchar(100),
    accident varchar(100),
    clean_title boolean,
    price int
);

ALTER TABLE public.used_cars OWNER TO postgres;

create index idx_used_cars on public.used_cars (id);
