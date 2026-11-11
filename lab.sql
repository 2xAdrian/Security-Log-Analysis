-- Synthetic training data manually entered during a guided DuckDB lab.
-- Reconstructed from the verified six-row screenshot, not an exported database.
-- Run in a fresh database. Timestamps have no specified timezone.
create table logs(t timestamp, usr varchar, ip varchar, result varchar);
insert into logs values
('2026-11-11 09:00:00','alex','192.0.2.10','failure'),
('2026-11-11 09:01:00','alex','192.0.2.10','failure'),
('2026-11-11 09:02:00','alex','192.0.2.10','failure'),
('2026-11-11 09:02:00','sam','192.0.2.20','failure'),
('2026-11-11 09:03:00','alex','192.0.2.10','success'),
('2026-11-11 10:00:00','alex','192.0.2.10','failure');

create view repeated_login_failures as
select usr, count(*) as failures
from logs
where result = 'failure'
  and t >= '2026-11-11 09:00:00'
  and t < '2026-11-11 09:05:00'
group by usr
having count(*) >= 3;

select * from logs order by t, usr;
select * from repeated_login_failures;
