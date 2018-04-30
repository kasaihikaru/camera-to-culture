# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Language.create([
	{ ja: '日本語', ja_s: '日', en: 'Japanese', en_s: 'JP', zh: '日语', zh_s: '日', tw: '日語', tw_s: '日'},
	{ ja: '英語', ja_s: '英', en: 'English', en_s: 'EN', zh: '英语', zh_s: '英', tw: '英語', tw_s: '英'},
	{ ja: '中国語', ja_s: '中', en: 'Chinese', en_s: 'CN', zh: '中文', zh_s: '中', tw: '中文', tw_s: '中'}
	])

Country.create([
	{ ja: '日本', en: 'Japan', zh: '日本', tw: '日本'}
	])

Prefecture.create([
	{area: '北海道', ja: '北海道', en: 'Hokkaido', zh: '北海道', tw: '北海道'},
	{ area: '東北', ja: '青森県', en: 'Aomori', zh: '青森县肯', tw: '青森縣肯'},
	{ area: '東北', ja: '岩手県', en: 'Iwate', zh: '岩手县', tw: '岩手縣'},
	{ area: '東北', ja: '秋田県', en: 'Akita', zh: '秋田县', tw: '秋田縣'},
	{ area: '東北', ja: '宮城県', en: 'Miyagi', zh: '宫城县', tw: '宮城縣'},
	{ area: '東北', ja: '山形県', en: 'Yamagata', zh: '山形县', tw: '山形縣'},
	{ area: '東北', ja: '福島県', en: 'Fukushima', zh: '福岛县', tw: '福島縣'},
	{ area: '関東', ja: '東京都', en: 'Tokyo', zh: '东京', tw: '東京'},
	{ area: '関東', ja: '神奈川県', en: 'Kanagawa', zh: '神奈川县', tw: '神奈川縣'},
	{ area: '関東', ja: '埼玉県', en: 'Saitama', zh: '埼玉县', tw: '埼玉縣'},
	{ area: '関東', ja: '千葉県', en: 'Chiba ken', zh: '千叶县', tw: '千葉縣'},
	{ area: '関東', ja: '茨城県', en: 'Ibaraki', zh: '茨城县', tw: '茨城縣'},
	{ area: '関東', ja: '栃木県', en: 'Tochigi', zh: '栃木县', tw: '栃木縣'},
	{ area: '関東', ja: '群馬県', en: 'Gunma', zh: '群马县', tw: '群馬縣'},
	{ area: '関東', ja: '山梨県', en: 'Yamanashi', zh: '山梨县', tw: '山梨縣'},
	{ area: '北信越', ja: '新潟県', en: 'Niigata', zh: '新泻县', tw: '新潟縣'},
	{ area: '北信越', ja: '長野県', en: 'Nagano', zh: '长野县', tw: '長野縣'},
	{ area: '北信越', ja: '富山県', en: 'Toyama', zh: '富山县', tw: '富山縣'},
	{ area: '北信越', ja: '石川県', en: 'Ishikawa', zh: '石川县', tw: '石川縣'},
	{ area: '北信越', ja: '福井県', en: 'Fukui', zh: '福井县', tw: '福井縣'},
	{ area: '東海', ja: '愛知県', en: 'Aichi', zh: '爱知县', tw: '愛知縣'},
	{ area: '東海', ja: '岐阜県', en: 'Gifu', zh: '岐阜县', tw: '岐阜縣'},
	{ area: '東海', ja: '静岡県', en: 'Shizuoka', zh: '静冈县', tw: '靜岡縣'},
	{ area: '東海', ja: '三重県', en: 'Mie', zh: '三重县', tw: '三重縣'},
	{ area: '近畿', ja: '大阪府', en: 'Osaka', zh: '大阪府', tw: '大阪府'},
	{ area: '近畿', ja: '兵庫県', en: 'Hyōgo', zh: '兵库县', tw: '兵庫縣'},
	{ area: '近畿', ja: '京都府', en: 'Kyoto', zh: '京都府', tw: '京都府'},
	{ area: '近畿', ja: '滋賀県', en: 'Shiga', zh: '滋贺县', tw: '滋賀縣'},
	{ area: '近畿', ja: '奈良県', en: 'Nara', zh: '奈良县', tw: '奈良縣'},
	{ area: '近畿', ja: '和歌山県', en: 'Wakayama', zh: '和歌山县', tw: '和歌山縣'},
	{ area: '中国', ja: '鳥取県', en: 'Tottori', zh: '鸟取县', tw: '鳥取縣'},
	{ area: '中国', ja: '島根県', en: 'Shimane', zh: '岛根县', tw: '島根縣'},
	{ area: '中国', ja: '岡山県', en: 'Okayama', zh: '冈山县', tw: '岡山縣'},
	{ area: '中国', ja: '広島県', en: 'Hiroshima', zh: '广岛县', tw: '廣島縣'},
	{ area: '中国', ja: '山口県', en: 'Yamaguchi', zh: '山口县', tw: '山口縣'},
	{ area: '四国', ja: '徳島県', en: 'Tokushima', zh: '德岛县', tw: '德島縣'},
	{ area: '四国', ja: '香川県', en: 'Kagawa', zh: '香川县', tw: '香川縣'},
	{ area: '四国', ja: '愛媛県', en: 'Ehime', zh: '爱媛县', tw: '愛媛縣'},
	{ area: '四国', ja: '高知県', en: 'Kochi', zh: '高知县', tw: '高知縣'},
	{ area: '九州', ja: '福岡県', en: 'Fukuoka', zh: '福冈县', tw: '福岡縣'},
	{ area: '九州', ja: '佐賀県', en: 'Saga', zh: '佐贺县', tw: '佐賀縣'},
	{ area: '九州', ja: '長崎県', en: 'Nagasaki', zh: '长崎县', tw: '長崎縣'},
	{ area: '九州', ja: '熊本県', en: 'Kumamoto', zh: '熊本县', tw: '熊本縣'},
	{ area: '九州', ja: '大分県', en: 'Oita', zh: '大分县', tw: '大分縣'},
	{ area: '九州', ja: '宮崎県', en: 'Miyazaki', zh: '宫崎县', tw: '宮崎縣'},
	{ area: '九州', ja: '鹿児島県', en: 'Kagoshima', zh: '鹿儿岛县', tw: '鹿兒島縣'},
	{ area: '九州', ja: '沖縄県', en: 'Okinawa', zh: '冲绳县', tw: '沖繩縣'}
	])

Category.create([
	{ ja_group: 'あなた', ja: 'プロフィール', en_group: 'Yourself', en: 'Profile', zh_group: '你', zh: '头像照片', tw_group: '你／妳', tw: '個人照片'},
	{ ja_group: 'あなた', ja: '証明写真', en_group: 'Yourself', en: 'ID photo', zh_group: '你', zh: '证件照', tw_group: '你／妳', tw: '證件照'},
	{ ja_group: '思い出', ja: 'ウェディング', en_group: 'Memory', en: 'Wedding', zh_group: '重要时刻', zh: '婚纱照', tw_group: '重要時刻', tw: '婚紗照'},
	{ ja_group: '思い出', ja: '旅行', en_group: 'Memory', en: 'Traveling', zh_group: '重要时刻', zh: '旅行', tw_group: '重要時刻', tw: '旅遊'},
	{ ja_group: '思い出', ja: '日常', en_group: 'Memory', en: 'Dairy life', zh_group: '重要时刻', zh: '日常', tw_group: '重要時刻', tw: '日常'},
	{ ja_group: '子供', ja: '七五三', en_group: 'Child', en: 'seven-five-three', zh_group: '儿童', zh: '七五三', tw_group: '兒童', tw: '七五三'},
	{ ja_group: '子供', ja: '成人式', en_group: 'Child', en: 'Coming of age', zh_group: '儿童', zh: '成人式', tw_group: '兒童', tw: '成人式'},
	{ ja_group: '子供', ja: 'マタニティ', en_group: 'Child', en: 'Maternity', zh_group: '儿童', zh: '孕妇照', tw_group: '兒童', tw: '孕婦寫真'},
	{ ja_group: '子供', ja: 'ニューボーン', en_group: 'Child', en: 'New born', zh_group: '儿童', zh: '新生儿照', tw_group: '兒童', tw: '新生兒寫真'},
	{ ja_group: 'その他', ja: '商品', en_group: 'The others', en: 'Commodities', zh_group: '其他', zh: '商品', tw_group: '其他', tw: '商品'},
	{ ja_group: 'その他', ja: 'イベント', en_group: 'The others', en: 'Event', zh_group: '其他', zh: '活动', tw_group: '其他', tw: '活動'},
	{ ja_group: 'その他', ja: 'ペット', en_group: 'The others', en: 'Pet', zh_group: '其他', zh: '宠物', tw_group: '其他', tw: '寵物'}
])