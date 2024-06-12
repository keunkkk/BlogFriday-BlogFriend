-- BlogFriday&BlogFriend.sql
CREATE TABLE user (
  user_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,  -- 001, 002 이런식으로 저장
  user_idemail VARCHAR(255) NOT NULL,               -- idemail 
  user_state INT NOT NULL,                          -- state값
  user_name VARCHAR(255) NOT NULL,                  -- 실명저장 컬럼
  user_nickname VARCHAR(255) NOT NULL,              -- 사이트 내에서 사용할 nickname ex) nickname's 블로그 
  user_phonenumber VARCHAR(255) NOT NULL,           -- 전화번호
  user_password VARCHAR(255) NOT NULL,              -- password 암호화
  user_profile VARCHAR(255) ,                                -- 프로필 사진을 저장할 컬럼
  user_code VARCHAR(255) NOT NULL,                                   -- 난수를 저장할 컬럼
  user_findhome VARCHAR(255) NOT NULL,              -- 아이디/비번 찾기 할때 받을 고향
  user_findname VARCHAR(255) NOT NULL               -- 아이디/비번 찾기 
)ENGINE = InnoDB;


CREATE TABLE User_type (
  user_state VARCHAR(255) NOT NULL PRIMARY KEY,
  user_id INT NOT NULL,
  FOREIGN KEY (user_Id) REFERENCES User(user_Id)
  )
ENGINE = InnoDB;




CREATE TABLE Orders (
  order_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  order_date DATETIME NOT NULL,
  order_amount DECIMAL(10,2) NOT NULL,  
  FOREIGN KEY (user_id) REFERENCES User (user_id)
  )    
ENGINE = InnoDB;

CREATE TABLE PaymentMethods (
  method_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  method_name VARCHAR(255) NOT NULL
)
ENGINE = InnoDB;


CREATE TABLE PaymentTransactions (
  transaction_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  method_id INT NOT NULL,
  transaction_date DATETIME NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  is_successful TINYINT NOT NULL,
  FOREIGN KEY (method_id) REFERENCES PaymentMethods (method_id),
  FOREIGN KEY (order_id) REFERENCES Orders (order_id)
)
ENGINE = InnoDB;


CREATE TABLE Payouts (
  payout_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  payout_date DATETIME NOT NULL,
  FOREIGN KEY (order_id) REFERENCES Orders (order_id)
)
ENGINE = InnoDB;





CREATE TABLE Category (
  category_code INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  category_name VARCHAR(255) NOT NULL,
  category_type1 INT NOT NULL,
  category_type2 INT NOT NULL
  )
ENGINE = InnoDB;

CREATE TABLE Product (
  product_code INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  category_code INT NOT NULL,
  product_name VARCHAR(255) NOT NULL,
  product_price DECIMAL(16,2) NOT NULL,
  product_count INT NOT NULL,
  product_content_text VARCHAR(255) ,
  product_color VARCHAR(50), 
  product_size VARCHAR(50), 
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (category_code) REFERENCES Category(category_code)
) ENGINE = InnoDB;


CREATE TABLE OrderDetails (
  orderdetail_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  product_code INT NOT NULL,
  product_quantity INT NOT NULL,
  priceat_purchase DECIMAL(16,2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES Orders (order_id),
  FOREIGN KEY (product_code) REFERENCES Product (product_code)
)
ENGINE = InnoDB;



CREATE TABLE Product_Img (
  product_code INT NOT NULL,
  product_img0 VARCHAR(255) NOT NULL,
  product_img1 VARCHAR(255) NOT NULL,
  product_img2 VARCHAR(255) ,
  FOREIGN KEY (product_code) REFERENCES Product (product_code)
)
ENGINE = InnoDB;





CREATE TABLE Cart (
  cart_product_code INT NOT NULL AUTO_INCREMENT PRIMARY KEY,      -- 장바구니 생성될 때 생성되는 속성
  product_code INT NOT NULL,                                      -- 물건 정보
  cart_product_count INT NOT NULL,                                 -- 장바구니 수량
  user_id INT NOT NULL                                             -- 물건을 담은 유저 정보
)
ENGINE = InnoDB;

CREATE TABLE Delivery (
  delivery_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  current_status VARCHAR(255) NOT NULL,
  scheduled_delivery_date DATETIME,
  actual_delivery_date DATETIME,
  original_delivery_address VARCHAR(255) NOT NULL,
  updated_delivery_address VARCHAR(255),
  tracking_number VARCHAR(255),
  FOREIGN KEY (order_id) REFERENCES Orders (order_id)
);

CREATE TABLE message (
    num int AUTO_INCREMENT PRIMARY KEY,
    sender_id VARCHAR(255) NOT NULL,
    recipient_id VARCHAR(255) NOT NULL,
    message TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_read BOOLEAN DEFAULT FALSE
);



CREATE TABLE friendlist ( -- user 에서 친구추가하면
  num INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_code1 VARCHAR(255) NOT NULL, 
  user_code2 VARCHAR(255) NOT NULL,
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)ENGINE = InnoDB;

CREATE TABLE producthistory ( 
  history_code INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  product_code INT NOT NULL,
  product_name VARCHAR(255) NOT NULL,
  category_code INT NOT NULL,
  product_price DECIMAL(16,2) NOT NULL,
  product_count INT NOT NULL,
  user_id1 INT NOT NULL,
  user_id2 INT NOT NULL,
  user_code1 VARCHAR(255) NOT NULL, 
  user_code2 VARCHAR(255) NOT NULL,
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  
)ENGINE = InnoDB;



-- 관리자 공지 계정
INSERT INTO user (
  user_idemail, user_state, user_name, user_nickname, user_phonenumber, user_password, user_profile, user_code,user_findhome,user_findname
) VALUES ('admin@gmail.com', 3, '관리자','관리자','01012341234', '0000', '000000.png', 'A00000','포항','견');
-- 나에게로 메세지 계정
INSERT INTO user (
  user_idemail, user_state, user_name, user_nickname, user_phonenumber, user_password, user_profile, user_code,user_findhome,user_findname
) VALUES ('mymessage@gmail.com', 3, '메세지','메세지','01012341234', '0000', NULL, 'A10000','포항','견');
-- 상품 계정
INSERT INTO user (
  user_idemail, user_state, user_name, user_nickname, user_phonenumber, user_password, user_profile, user_code,user_findhome,user_findname
) VALUES ('shophistory@gmail.com', 3, 'blogfriday','blogfriday','01012341234', '0000', '000002.png', 'A00002','포항','견');

insert into paymentmethods (method_id, method_name)
values (1, "creditCard"),
(2, "bankTransfer");

insert into orders (order_id, user_id, order_date, order_amount)
values (2, 1, '2024-04-24 13:19:57', 1000.00),
 (1, 1, '2024-04-24 13:19:57', 1000.00);
 
 insert into paymenttransactions (transaction_id, order_id, method_id, transaction_date, amount, is_successful)
values (1, 1, 1, '2024-04-24 13:19:57', 1000.00, 1);

insert into payouts (payout_id, order_id, amount, payout_date)
values (1,1, 1000, '2024-04-24 13:19:57');

INSERT INTO Category (category_name, category_type1, category_type2) VALUES
('패션', 1, 1),
('식품', 2, 1),
('가전제품', 3, 1),
('악세서리', 4, 1),
('가구', 5, 1),
('기타', 6, 1);




-- 식품
INSERT INTO Product (user_id, category_code, product_name, product_price, product_count, product_content_text, product_color, product_size) 
VALUES 

(1, 2, '파워에이드 240ml 60개', 16100.00, 50, '파워에이드 240ml 60개', null, null),
(1, 2, '파워에이드 마이티 포스 600ml 20개', 21100.00, 40, '파워에이드 마이티 포스 600ml 20개', null, null),
(1, 2, '파워에이드 제로 1.5L2개', 4580, 40, '파워에이드 제로 1.5L2개4580', null, null),
(1, 2, '파워에이드 수건', 14000, 40, '파워에이드 수건', null, null),
(1, 2, '코카콜라파워에이드토렛타조지아미닛메이드 인기음료 모음전', 15500.00, 50, '코카콜라파워에이드토렛타조지아미닛메이드 인기음료 모음전 인기음료들을 한번에', null, null),   -- 식품
(1, 2, '파워 에이드 마운틴 블라스트 1.5L', 19100.00, 50, '파워 에이드 마운틴 블라스트 1.5L', null, null),
(1, 2, '파워 에이드 마운틴 블라스트 600mL 4개입', 12200.00, 50, '파워 에이드 마운틴 블라스트 600mL', null, null),
(1, 2, '파워 에이드 퍼플스톰', 2200.00, 50, '파워 에이드 퍼플스톰L', null, null),
(1, 2, '토레타 파워에이드 이온음료 에너지 음료 모음전', 18900.00, 50, '이온음료 모음전 인기이온음료들을 한번에', null, null),
(1, 2, '파워에이드 메가볼 600ml 20병', 32600.00, 50, '파워에이드 메가볼 600ml 20병', null, null);

-- 전자제품
INSERT INTO Product (user_id, category_code, product_name, product_price, product_count, product_content_text, product_color, product_size) 
VALUES 
(1, 3, 'LG 퓨리케어 360 공기청정기',  449000.00, 50, '더 슬림해진 디자인 여전히 강력한 360° 공기청정 다양한 공간에 잘 어우러져 청정이 필요한 공간 어디든 자유롭게 배치할 수 있어요', null, null),
(1, 3, 'IMIPAW 자동 고양이 급식기 4L 스마트 애완동물 사료 디스펜서', 26183.00, 50, '고양이를 위한 최고의 선택', null, null),
(1, 3, '봉인된 정품 PS5 콘솔 디지털 에디션 및 디스크 버전, 825GB, 1TB, 2TB, 10 게임 및 2 컨트롤러', 1704410.00, 50, '지원 해상도 4k
유형 TV 게임 콘솔
기능 지원 멀티 플레이어
메모리 128GB', null, null),
(1, 3, '독일 LIDDFAFA VR 안경 HoloLens 2 TOF 심도 센서 AI 스마트 MR 헤드셋 헬멧 AR 풀 3D', 35347800.00, 50, '미성년자가 물품을 구매하는 경우, 법정대리인이 동의하지 않으면 미성년자 본인 또는 법정대리인이 구매를 취소할 수 있습니다.', null, null),
(1, 3, '스탠딩 독서등이 있는 나이트 스탠드 엔드 테이블 러스틱 베이지 쉐이드 패브릭 쉐이드 플로어 램프 사이', 255000.00, 50, '직거래로 인해 발생한 피해에 대해 나는 책임을 지지 않습니다.', null, null),
(1, 3, 'DIY 가정용 아이스크림 메이커 과일 콘 자동 수제 소형 소프트 기계', 190831410.00, 50, '전 세계 무료 배송을 즐기십시오!', null, null), 
(1, 3, '스마트 워치 밴드 Xiaomi Mi Watch Lite GPS 블루투스', 50856600.00, 50, ' 웹사이트에서 최신 가격 및 재고를 확인하세요. 저작권 보호를 받는 이미지일 수 있습니다.', null, null),
(1, 3, '넷기어 뮤럴 디지털 캔버스 27인치(화이트) 스마트 전자액자 미디어아트 전시 인테리어 NFT WiFi', 1275000.00, 50, '1,245,000원즉시할인가결제수단 즉시 할인 안내창 열기 스마일카드 Edition3 / 최대 15% 결제 시 할인', null, null),
(1, 3, '독일 전기 주전자 가정용 보일러 물 포트 304 스테인레스 C. 1.6L', 414900.00, 50, '독일산', null, null),
(1, 3, '110V 220V 구즈넥 전기 주전자 1000ml 핸드 브루 커피 포트 스마트 온도 제어 포트, 1200W 빠른 가열 주전자 주전자', 66441.00, 50, '이것은 다양한 종류의 콩에서 꽃과 감귤류와 같은 전형적인 향기를 달래기에 적합한 주전자입니다. 다른 종류의 차조차도 다른 온도가 필요합니다.', null, null);
-- 패션
INSERT INTO Product (user_id, category_code, product_name, product_price, product_count, product_content_text, product_color, product_size) 
VALUES 

(1, 1, '지오다노 맨투맨', 60000.00, 30, '지오다노 청바지', null, null),
(1, 1, '티셔츠', 100000.00, 40, '티셔츠', null, null),
(1, 1, '나이키 슈즈', 150000.00, 1, '나이키 운동화', null, null),
(1, 1, '미우미우 원피스', 5000000.00, 5, '미우미우 원피스', null, null),
(1, 1, '휠라 후드티', 200000.00, 15, '휠라 후드티', null, null),   
(1, 1, '프라다 지갑', 1000000.00, 10, '프라다 지갑', null, null),
(1, 1, '아쿠아 슈즈', 30000.00, 50, '아쿠아 슈즈', null, null),
(1, 1, '모자', 25000.00, 15, '모자', null, null),
(1, 1, '아디다스 트레이닝복', 100000.00, 50, '아디다스 트레이닝복', null, null),
(1, 1, '구찌 슈즈', 2000000.00, 2, '구찌 슈즈', null, null);

-- 악세서리
INSERT INTO Product (user_id, category_code, product_name, product_price, product_count, product_content_text, product_color, product_size) 
VALUES 
(1, 4, '14K 18K 물고기반지 두줄 행운 애끼 새끼 중지 손가락 샤넬 반지 우정 수능 링', 129000.00, 30, '우아하고 세련된 블링블링한 선물 패키지로 자신에게 완벽한 선물을 받아보세요.', null, null),
(1, 4, '다니엘 웰링턴 CLASSIC LUMINE RING 크리스탈 장식 구찌 반지 커플링 우정링', 68000.00, 50, '다니엘 웰링턴 CLASSIC LUMINE RING은 심플하면서도 센스 있는 디자인 바탕에 네 개의 프레시오사 크리스탈을 더하여 반짝임과 포인트를 준 제품입니다.', '골드', null),
(1, 4, '크리스마스 야코야 진주 목걸이 여자선물추천 크로벨', 358200.00, 20, '럭셔리한 최상의 디자인으로 고급세팅되어 선물하시기 좋은 목걸이 입니다.', null, null),
(1, 4, '판도라 시그니처 로고 파베 스와로브스키 목걸이 392311C01', 70950.00, 30, '뭔가 열릴 것만 같은 목걸이', null, null),
(1, 4, 'Petit CD 티파니 팔찌', 550000.00, 20, '심플하고 우아한 미학이 느껴지는 Petit CD 팔찌입니다. 가느다란 골드 피니시 메탈 체인 중앙의 CD 시그니처가 돋보입니다. 자그마한 화이트 레진 진주가 더해져 디자인을 완성합니다. 다양한 Petit CD 아이템과 매치하기 좋은 모던하고 세련된 팔찌입니다.', null, null),
(1, 4, '모이사나이트 로렉스 팔찌 다이아 체인 명품 테니스 팔찌', 158100.00, 50, '입소문난 프리미엄 테니스 팔찌.', null, null),
(1, 4, '샤넬 귀걸이 18K Lucenlee', 395580.00, 30, '웜톤, 쿨톤 고민없이 데일리 아이템으로 꾸준히 사랑받는 귀걸이 입니다.', null, null),
(1, 4, '14K 오스트리아 스톤 골드 주얼리 아날로그 시계 귀찌 GF103', 19900.00, 50, '반짝임이 뛰어난 스와로브스키 스톤을 촘촘하게 미러볼 세팅한 명품 볼드귀걸이 입니다.', null, null),
(1, 4, '벨벳 블랙다이아 큐빅 보석 머리띠 디올 헤어밴드', 10500.00, 60, '퀄리티 좋은 블랙 다이아 큐빅 오브제가 고급스러운 벨벳 헤어밴드입니다.', null, null),
(1, 4, '럭셜 큐빅 나비 공단 피트니스 밴드 [루체]', 22000.00, 40, '럭셜 큐빅 나비 공단 머리띠입니다. 나비 세팅이 섬세하고, 핀대에 구멍을 뚫고 장식을 박아 만들어서 튼튼합니다.', null, 3);

-- 가구
INSERT INTO Product (user_id, category_code, product_name, product_price, product_count, product_content_text, product_color, product_size) 
VALUES 
(1, 5, '보루네오하우스 프라임 오테 아쿠아 패브릭 모듈 이케아 포엠 의자', 358000.00, 20, '완벽한 발수 기능을 자랑하는 신소재 오테 패브릭으로 쉽게 관리하세요', '아이보리', null),
(1, 5, '말라카 오크 마쉬멜로우 캠핑 의자', 96000.00, 20, ' 간결한 미감에 모던 스타일까지 겸비한 디자인을 자랑합니다. 원목, 디자인, 모던까지 3박자가 어우러진 가구.', '아이보리', null),
(1, 5, '데스커 DSAD212 베이직 플렉스타일 데스크 오거나이저', 100000.00, 30, '책상의 본질에 충실하면서도 사용자를 배려하는 디테일', '빈티지 블랙', null),
(1, 5, 'E0자재 HM1966 횸 원형책상 테이블 램프 1600-DVX', 98000.00, 20, '집중을 위한 편안한 데스크 환경을 조성하여 사용자가 편안함과 실효성을 느낄 수 있고 감각적인 레이아웃까지 잃지 않는 데스크', '화이트', null),
(1, 5, '무이네 800 2단 안면 인식 도어락', 178000.00, 30, '일상의 모든 순간을 함께하는 모듈 가구', null, null),
(1, 5, '지엔 이동식 행거 철제 스탠드 스마트 옷걸이 강철 일자', 44900.00, 50, '자꾸만 무너져 내리는! 저가의 행거와는 차원이 다른 오래 사용 가능한 용접형 튼튼한 행거!', null, null),
(1, 5, '보루네오하우스 프라임 LED 조명이 내장된 우산 슈퍼싱글 수납침대 매트리스 포함', 299000.00, 20, '모던한 스타일의 아늑하고 감성적인 디자인, 분위기 있는 보루네오 올슨 LED 평상형 침대', null, null),
(1, 5, '세계가구 무이네 1단 800 지문 인식 안전 금고', 114290.00, 25, '과거와 현재가 공존하는 스타일, 미드 센추리 모던', null, null),
(1, 5, '도담 피에트 베네피트 화장품 세트', 58900.00, 30, '화장대로 사용하지 않을 땐, 플립형 상판을 덮엉 간이 책상으로, 좁은 공간에서도 효율적이며 활용도가 높습니다.', null, null),
(1, 5, '레이디가구 몬스터 에너지 드링크 포켓스프링 매트리스', 129000.00, 20, '차원이 다른 편안함, 직접 생산하고, 관리하니 더욱 편안하다.', null, null);

-- 기타
INSERT INTO Product (user_id, category_code, product_name, product_price, product_count, product_content_text, product_color, product_size) 
VALUES 
(1, 6, '아쿠아 디 파르마 향수',  75000.00, 50, '시원한 향', null, null),
(1, 6, '베어브릭 철완 아톰 크롬 피규어', 1309300.00, 50, '제품 특성상 잔기스나 긁힘자국이 본체에 남아있는 경우가 있습니다. 미리 양해 부탁드립니다', null, null),
(1, 6, '샤넬 No. 5 향수', 108000.00, 50, '마릴린먼로향수', null, null),
(1, 6, '샤넬 가브리엘 향수', 108000.00, 50, '미성년자가 물품을 구매하는 경우, 법정대리인이 동의하지 않으면 미성년자 본인 또는 법정대리인이 구매를 취소할 수 있습니다.', null, null),
(1, 6, '바이레도 블랑쉬 향수', 155000.00, 50, '직거래로 인해 발생한 피해에 대해 나는 책임을 지지 않습니다.', null, null),
(1, 6, '메종 마르지엘라 향수', 110100.00, 50, '전 세계 무료 배송을 즐기십시오!', null, null), 
(1, 6, '키엘 페이셜 크림', 46600.00, 50, ' 웹사이트에서 최신 가격 및 재고를 확인하세요. 저작권 보호를 받는 이미지일 수 있습니다.', null, null),
(1, 6, '모로칸오일 트리트먼트 오일', 17500.00, 50, '1,5000원즉시할인가결제수단 즉시 할인 안내창 열기 스마일카드 Edition3 / 최대 15% 결제 시 할인', null, null),
(1, 6, '비치 타월', 29000.00, 50, '올 여름 강타할 최신 비치 타월', null, null),
(1, 6, '문구 세트', 664400.00, 50, '우리아이 술안주 부모님 영양간식', null, null);


INSERT INTO Product_Img (product_code, product_img0, product_img1, product_img2) VALUES 
(1, '1_product_img0.png', '1_product_img1.png', NULL),
(2, '2_product_img0.png', '2_product_img1.png', NULL),
(3, '3_product_img0.png', '3_product_img1.png', NULL),
(4, '4_product_img0.png', '4_product_img1.png', NULL),
(5, '5_product_img0.png', '5_product_img1.png', NULL),
(6, '6_product_img0.png', '6_product_img1.png', NULL),
(7, '7_product_img0.png', '7_product_img1.png', NULL),
(8, '8_product_img0.png', '8_product_img1.png', NULL),
(9, '9_product_img0.png', '9_product_img1.png', NULL),
(10, '10_product_img0.png', '10_product_img1.png', NULL),
(11, '11_product_img0.png', '11_product_img1.png', NULL),
(12, '12_product_img0.png', '12_product_img1.png', NULL),
(13, '13_product_img0.png', '13_product_img1.png', NULL),
(14, '14_product_img0.png', '14_product_img1.png', NULL),
(15, '15_product_img0.png', '15_product_img1.png', NULL),
(16, '16_product_img0.png', '16_product_img1.png', NULL),
(17, '17_product_img0.png', '17_product_img1.png', NULL),
(18, '18_product_img0.png', '18_product_img1.png', NULL),
(19, '19_product_img0.png', '19_product_img1.png', NULL),
(20, '20_product_img0.png', '20_product_img1.png', NULL),
(21, '21_product_img0.png', '21_product_img1.png', NULL),
(22, '22_product_img0.png', '22_product_img1.png', NULL),
(23, '23_product_img0.png', '23_product_img1.png', NULL),
(24, '24_product_img0.png', '24_product_img1.png', NULL),
(25, '25_product_img0.png', '25_product_img1.png', NULL),
(26, '26_product_img0.png', '26_product_img1.png', NULL),
(27, '27_product_img0.png', '27_product_img1.png', NULL),
(28, '28_product_img0.png', '28_product_img1.png', NULL),
(29, '29_product_img0.png', '29_product_img1.png', NULL),
(30, '30_product_img0.png', '30_product_img1.png', NULL),
(31, '31_product_img0.png', '31_product_img1.png', NULL),
(32, '32_product_img0.png', '32_product_img1.png', NULL),
(33, '33_product_img0.png', '33_product_img1.png', NULL),
(34, '34_product_img0.png', '34_product_img1.png', NULL),
(35, '35_product_img0.png', '35_product_img1.png', NULL),
(36, '36_product_img0.png', '36_product_img1.png', NULL),
(37, '37_product_img0.png', '37_product_img1.png', NULL),
(38, '38_product_img0.png', '38_product_img1.png', NULL),
(39, '39_product_img0.png', '39_product_img1.png', NULL),
(40, '40_product_img0.png', '40_product_img1.png', NULL);

INSERT INTO Product_Img (product_code, product_img0, product_img1, product_img2) VALUES 
(41, '41_product_img0.png', '41_product_img1.png', NULL),
(42, '42_product_img0.png', '42_product_img1.png', NULL),
(43, '43_product_img0.png', '43_product_img1.png', NULL),
(44, '44_product_img0.png', '44_product_img1.png', NULL),
(45, '45_product_img0.png', '45_product_img1.png', NULL),
(46, '46_product_img0.png', '46_product_img1.png', NULL),
(47, '47_product_img0.png', '47_product_img1.png', NULL),
(48, '48_product_img0.png', '48_product_img1.png', NULL),
(49, '49_product_img0.png', '49_product_img1.png', NULL),
(50, '50_product_img0.png', '50_product_img1.png', NULL),
(51, '51_product_img0.png', '51_product_img1.png', NULL),
(52, '52_product_img0.png', '52_product_img1.png', NULL),
(53, '53_product_img0.png', '53_product_img1.png', NULL),
(54, '54_product_img0.png', '54_product_img1.png', NULL),
(55, '55_product_img0.png', '55_product_img1.png', NULL),
(56, '56_product_img0.png', '56_product_img1.png', NULL),
(57, '57_product_img0.png', '57_product_img1.png', NULL),
(58, '58_product_img0.png', '58_product_img1.png', NULL),
(59, '59_product_img0.png', '59_product_img1.png', NULL),
(60, '60_product_img0.png', '60_product_img1.png', NULL);



