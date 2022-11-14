var sportsPerformanceMy = (squeMaxIam:50, chinMaxIam:10, squatMaxIam:100)

print(sportsPerformanceMy)
print(sportsPerformanceMy.0, sportsPerformanceMy.1, sportsPerformanceMy.2)
print(sportsPerformanceMy.squeMaxIam, sportsPerformanceMy.chinMaxIam, sportsPerformanceMy.squatMaxIam)

var sportsPerformanceMyWife = (squeMaxWife:7, chinMaxWife:1, squatMaxWife:50)

(sportsPerformanceMy.squeMaxIam, sportsPerformanceMyWife.squeMaxWife) = (sportsPerformanceMyWife.squeMaxWife, sportsPerformanceMy.squeMaxIam)

(sportsPerformanceMy.chinMaxIam, sportsPerformanceMyWife.chinMaxWife) = (sportsPerformanceMyWife.chinMaxWife, sportsPerformanceMy.chinMaxIam)

(sportsPerformanceMy.squatMaxIam, sportsPerformanceMyWife.squatMaxWife) = (sportsPerformanceMyWife.squatMaxWife, sportsPerformanceMy.squatMaxIam)

print(sportsPerformanceMy.squeMaxIam, sportsPerformanceMy.chinMaxIam, sportsPerformanceMy.squatMaxIam)

print(sportsPerformanceMyWife.squeMaxWife, sportsPerformanceMyWife.chinMaxWife, sportsPerformanceMyWife.squatMaxWife)

let resultSportsPerformanceSque = sportsPerformanceMy.squeMaxIam - sportsPerformanceMyWife.squeMaxWife

let resultSportsPerformanceChin = sportsPerformanceMy.chinMaxIam - sportsPerformanceMyWife.chinMaxWife

let resultSportsPerformanceSquat = sportsPerformanceMy.squatMaxIam - sportsPerformanceMyWife.squatMaxWife

print(resultSportsPerformanceSque, resultSportsPerformanceChin, resultSportsPerformanceSquat)
