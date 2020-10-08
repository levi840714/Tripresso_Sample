# Tripresso Interview Test

## Docker快速佈署API環境

```
docker-compose up -d
```

## API

### 取得旅遊行程

```
// sortScore(評分排序): 0 => 低到高, 1 => 高到低
GET localhost:8765/api/get_trips/{sortScore}
```

# schema

**trip (主行程)**

    - id: 主鍵，唯一流水號
    - code: 行程號
    - title: 行程名稱
    - region: 旅遊地區
    - score: 行程評分
    - tags: 標籤列
    - people: 總團位數
    - days: 旅遊天數
    - status: 行程狀態
    - created_at: 建造日期
    - updated_at: 更新日期
    
**tag (標籤)**

    - id: 主鍵，唯一流水號
    - name: 標籤名
    - detail: 標籤詳細資訊
    - hasDetail: 是否有詳細資訊
    - created_at: 建造日期
    - updated_at: 更新日期

**trip_group (行程團位)**

    - id: 主鍵，唯一流水號
    - trip_id: 所屬行程ID
    - start_date: 旅遊日期
    - amount: 團金額
    - reward: 回饋咖幣
    - last_people: 剩餘團位人數
    - created_at: 建造日期
    - updated_at: 更新日期

# 規劃脈絡

**trip**: 存放行程主要的基本資訊

**tag**: 存放標籤資訊，用hasDetail欄位判斷是否要讓標籤顯示詳細資訊

**trip_group**: 存放行程有哪些日期的團位，並存放這些團位各自的金額與回饋咖幣還有團位剩餘人數

## 排序方式
**評分**: 直接用sortBy的method把所有行程內的評分依照選擇的排序高低方式做排序

**價格**: 這個要看選擇的實作方式，可以在行程內直接存入各行程的基本金額，直接使用這個金額去做排序，或著是先去找尋行程內各團體的最高或最低金額，再開一個key去存放這個金額用他去排序

# 回傳資料範例

**tags**: 資料量較少的抽出來放一層，或著是前端再call一個request要

**trips**: 先抓出trip表內行程主要資料，因為同行程不同團的主要資訊都是一樣的，所以再用trip的id去撈出trip_group表內此行程的所有團體，並把他存放入trips的group key內，這樣每個同行程的團體就不需要回傳許多重複的行程資訊

```
"tags": [
    {
        "id": 1,
        "name": "國內旅遊",
        "detail": null,
        "hasDetail": "0"
    },
    {
        "id": 2,
        "name": "自理三餐",
        "detail": "行程中由旅客自行安排的餐食，能自由體驗在地美食。(不提供餐費)",
        "hasDetail": "1"
    },
    {
        "id": 3,
        "name": "振興三倍券",
        "detail": null,
        "hasDetail": "0"
    }
],
"trips": [
    {
        "id": 2,
        "code": "19TMTCHWGZ",
        "title": "【天天出發】Together一起旅行．台北武陵農場榮民、長者、學生接駁優惠",
        "region": "台中",
        "score": 8,
        "tags": [
            "1",
            "3"
        ],
        "people": 5,
        "days": 1,
        "status": "1",
        "group": [
            {
                "id": 5,
                "trip_id": 2,
                "start_date": "2020-10-15",
                "amount": 400,
                "reward": 20,
                "last_people": 4
            },
            {
                "id": 6,
                "trip_id": 2,
                "start_date": "2020-10-17",
                "amount": 500,
                "reward": 25,
                "last_people": 5
            }
        ]
    },
    {
        "id": 1,
        "code": "17OBURG1",
        "title": "『太平洋環島』宜蘭葛瑪蘭的故鄉．高雄浪漫港都愛河．台東太平洋海岸巡奇．花東縱谷太魯閣五日",
        "region": "台灣",
        "score": 10,
        "tags": [
            "1",
            "2",
            "3"
        ],
        "people": 10,
        "days": 5,
        "status": "1",
        "group": [
            {
                "id": 1,
                "trip_id": 1,
                "start_date": "2020-10-17",
                "amount": 20200,
                "reward": 1010,
                "last_people": 7
            },
            {
                "id": 2,
                "trip_id": 1,
                "start_date": "2020-10-18",
                "amount": 20500,
                "reward": 1025,
                "last_people": 8
            },
            {
                "id": 3,
                "trip_id": 1,
                "start_date": "2020-10-19",
                "amount": 20500,
                "reward": 1025,
                "last_people": 9
            },
            {
                "id": 4,
                "trip_id": 1,
                "start_date": "2020-10-20",
                "amount": 20500,
                "reward": 1025,
                "last_people": 10
            }
        ]
    }
]
```