//
//  StoryDetailViewController.m
//  bokku
//
//  Created by Ted Cheng on 10/10/13.
//  Copyright (c) 2013 Ted Cheng. All rights reserved.
//

#import "StoryDetailViewController.h"
#import "NSString+FontAwesome.h"
#import "ChoiceCell.h"

#define StoryDescriptionFontSize 18.0

@interface StoryDetailViewController()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *specialZone;

@property (nonatomic, strong) UITableViewCell *thumbnailCell;
@property (nonatomic, strong) UITableViewCell *storyDescriptionCell;
@property (nonatomic, strong) UITableViewCell *questionCell;
@property (nonatomic, strong) ChoiceCell *choiceACell;
@property (nonatomic, strong) ChoiceCell *choiceBCell;
@property (nonatomic, strong) ChoiceCell *choiceCCell;
@property (nonatomic, strong) ChoiceCell *choiceDCell;

@property (nonatomic, strong) NSArray *cells;
@property (nonatomic, assign) NSUInteger currentStoryPartIndex;

@end

@implementation StoryDetailViewController

- (id)initWithStory:(Story *)story
{
    self = [self init];
    if (self) {
        self.story = story;
        self.currentStoryPartIndex = self.story.maxPage;
        [self setTitle:self.story.title];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tableView = [[UITableView alloc] init];
        [self.tableView setDataSource:self];
        [self.tableView setDelegate:self];
        self.tableView.tableFooterView = [[UIView alloc] init];
        self.specialZone = [[UIView alloc] init];
        [self.specialZone setBackgroundColor:[UIColor greenColor]];
    }
    return self;
}

- (BOOL)hidesBottomBarWhenPushed
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.specialZone];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadCurrentStoryPart];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGFloat specialZoneHeight = 50;
    [self.tableView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - specialZoneHeight)];
    [self.specialZone setFrame:CGRectMake(0, self.view.frame.size.height - specialZoneHeight, self.view.frame.size.width, specialZoneHeight)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadCurrentStoryPart
{
//    __block NSUInteger loadingIndex = self.currentStoryPartIndex;
    [self.story loadStoryPartWithIndex:self.currentStoryPartIndex withCompletion:^(NSArray *relatedParts, StoryPart *storyPart) {
        [self loadStoryPart:storyPart];
    }];
}

- (void)loadStoryPart:(StoryPart *)storyPart
{
//    [self.storyDescriptionCell.textLabel setText:@"「你在哪？」穿著白色連身長裙的少女惶惑地叫喊著。孤單的身影漫無目的地在漆黑中，像在逃避似地奔跑。「噠！噠！噠！噠……」帶著水點的腳踏聲追隨著她纖細的雙腿，長至肩膀的黑髮亦隨著步伐左右搖曳。\n\n踏步的聲音漸漸緩下來，由小跑步變成踱步。少女一邊走，一邊左右掃視著，她下意識地撅著嘴，苦笑著向著空氣發嘮叨：「每次也是這樣！你不會悶啊！」沒有東西回應她。\n\n她眉頭一鎖，把原本可愛的面容都收起了：「出來吧！不要再玩了！」徬徨的叫聲在這個鬼地方回響著，似在嘲笑她一樣。「你在哪？」穿著白色連身長裙的少女惶惑地叫喊著。孤單的身影漫無目的地在漆黑中，像在逃避似地奔跑。「噠！噠！噠！噠……」帶著水點的腳踏聲追隨著她纖細的雙腿，長至肩膀的黑髮亦隨著步伐左右搖曳。\n\n踏步的聲音漸漸緩下來，由小跑步變成踱步。少女一邊走，一邊左右掃視著，她下意識地撅著嘴，苦笑著向著空氣發嘮叨：「每次也是這樣！你不會悶啊！」沒有東西回應她。\n\n她眉頭一鎖，把原本可愛的面容都收起了：「出來吧！不要再玩了！」徬徨的叫聲在這個鬼地方回響著，似在嘲笑她一樣。「你在哪？」穿著白色連身長裙的少女惶惑地叫喊著。孤單的身影漫無目的地在漆黑中，像在逃避似地奔跑。「噠！噠！噠！噠……」帶著水點的腳踏聲追隨著她纖細的雙腿，長至肩膀的黑髮亦隨著步伐左右搖曳。\n\n踏步的聲音漸漸緩下來，由小跑步變成踱步。少女一邊走，一邊左右掃視著，她下意識地撅著嘴，苦笑著向著空氣發嘮叨：「每次也是這樣！你不會悶啊！」沒有東西回應她。\n\n她眉頭一鎖，把原本可愛的面容都收起了：「出來吧！不要再玩了！」徬徨的叫聲在這個鬼地方回響著，似在嘲笑她一樣。 "];
    
//    [self.storyDescriptionCell.textLabel setText:@"The End 隆隆隆…… 隆隆隆…… 強光，鐵門，隧道。 隆隆隆隆……隆隆隆隆…… 頭好痛。 隆隆隆隆隆隆……隆隆隆隆隆隆…… 像是在給什麼撞擊，真的，好痛。 ＊＊＊＊＊ 隱約，我感到頭頂是陣輕微的搖晃。我的髮根正抵著某道光滑的硬物，不停震盪著。我輕皺眉頭，把雙眼勉強睜開。 ｢呼啊……！｣ 我張開口，猛然吸進一口氣。 強光遽然從四面八方湧進眼簾，瞳孔因瞬間的強烈對比而無法適應，看到盡是朦矓一片的光影。漸漸，我感到震盪——不只是頭部的震盪，而是整個身體都在震。我正坐在某道軟軟的｢東西｣上，這｢東西｣依據住某個頻率在輕微的搖擺著。 ｢喂，搞咩啊。｣ 某道聲音在我耳邊響起。 嗄？ ｢拿，同你講，咪諗住玩野啊！｣ 我揉了下眼皮，嘗試把眼前的事物看清。一點又一點的橘紅色燈光，瞬間掠過，是街燈。我看著玻璃窗外的街景，那快速後退的景色，早已關門下閘的商店，了無人煙的人行道，頭頂上籠罩的天橋底。我認得，我認得這裡…… 旺角道。 這裡是旺角道，就在西洋菜街轉角處，海皇粥店對出的那段，旺角道。 轉頭往前看，我看到一個又一個的人頭，有男有女，有長髮有短髮，全都背向著我。我發覺自己正坐在一張柔軟的椅子中，就在這群男女的正後方。我看著身旁玻璃窗外快速掠過的旺角道街景，嘗試了解這是什麼一回事。慢著，這裡是…… 小巴？ 紅van車廂裡？最後一排？ 「喂，我旺角道起飛，旺角道起飛……」 車頭某處傳來一陣粗獷的聲音，大聲吼叫。聽到如此一句，我竟感到一陣似曾相識，卻又非常陌生的感覺。思緒混淆期間，我平放在椅子上的雙手，下意識的抓緊了下，摸到小巴椅子那粗糙又破爛的塑膠表層。 那是一種非常真實感覺。非常非常的真。 就像你走在銅鑼灣祟光門外，準備看燈過馬路時的那種焦急感，你不會懷疑自己是在做夢。對，我不是在做夢。眼前的一切一切，都是真的。 什麼回事？ ｢喂！喂！同你講緊野啊。｣ 身旁的聲音又在響起。十分接近，就在耳邊。 我還沒了解這到底是啥回事，即反射動作的轉過頭來，看往身邊講話的人。一個穿著純白色襯衫，鼻上擱著一副黑色粗框眼鏡的瘦削男子，突如其來的進入我視線範圍。 我認得他，眼前的這個男人…… 阿……信…… ——不！慢著！ 他不是阿信！ 眼前這個瘦削男子，穿著阿信的襯衫，頭戴粗框眼鏡，的確與阿信有幾分像。可他決不是阿信！ 我不認識他！ ｢喂，無野啊，係咪飲多左啊。｣男子伸手輕拍我的肩膀，一臉懊惱，｢無理由啊！我地都無叫酒。喂，你唔係連飲汽水都會醉啊嘛！｣ 男子突如其來的一拍，我卻感到無比的驚懼感，慌張側過身來，把他的手甩開。 ｢唔好掂我！｣我狂呼怒叫，瞪著眼前的陌生男子，嘗試動身站起來，｢你係邊個！｣ 男子看著我的行逕，完全傻了眼：｢咩啊！｣ 說罷他即伸出雙手，嘗試把我按下。我沒有讓他有觸碰我的機會，挪動身子，從座椅上站起。 ｢咩事！到底發生咩事！｣我激動大叫，抓著身前的灰色椅背，吼叫道，｢做咩事？答我，宜家究竟發生緊咩事！｣ 我看著腳底下微微抖動的紅van地板，看著車窗外掠動的旺角街頭……What the fucking fuck is going on!! 我為什麼會在紅van車上，我是怎麼來到這裡？ 這荒謬的一刻，我雖然不能確定到底發生了什麼回事，腦內卻有種意識告訴自己，一切都毫不連貫，不合情理。對，這一切都連不起來——慢著，我出現在這台紅van車廂之前，到底在幹嘛？ ｢仆街……｣我低吟一下，用力拍了下額頭，嘗試記起之前的事。 卡噠卡噠、轟隆轟隆、車底下嚴重冒煙的引擎、吐露港、夜夜痴纏、我將孤單，你將消失，像這一晚、白粉友、被撞飛的畫面、破窗而出的白粉友、四周一片黑暗、唯一的亮光、隧道、拋錨、獅子山、防毒面具人、手術刀、被擋住，前無去路的隧道…… 中年男子……Yuki…… 我。 猶如早上起來嘗試記下剛發過的夢，當下我只想到一些凌碎畫面，模糊之餘更是完全連不起來。我用力想著，卻抓了個空，更感到這些畫面正慢慢消逝，往我腦海深處沉殿去。不成，完全想不起。 我唯一知道的是，眼前所在的這台小巴，這個場景，既熟悉，又陌生——我不屬於這裡。我別過頭來，伸手揪著｢阿信｣的衣領，憤然問：｢點解我會係度！點解我會係度架！｣ ｢阿信｣完全沒預期我會這樣做，整個人愣住了，某道黑色物件從他手上溜走，｢啪｣的一聲，跌落在地板上。我側頭察看，發現是一枝紅色的雙頭筆。 ？ 我疑惑，順著阿信攤開的手掌方向，往前方座椅的棕色椅背看去。 就在那早已給割至破破爛爛，充滿原子筆和塗改液語句的塑膠椅背上，我看到一列貌似是給新畫上去，還閃著濕潤的墨水反光，非常潦草的塗鴉圖案。 我非常肯定這是｢阿信｣剛剛畫上去的一列塗鴉，因為整塊椅背上，就只有這列塗鴉圖案是紅色——十七個紅色火柴人圖案。 十七個都平排著，十七個都手牽著手… ！ 看到｢火柴人圖案｣的剎那間，心底猝然翻出一陣似曾相識的感覺，像是在某處見過同樣的東西……大帽山、大雨、紅van、林村、倒影、椅背、火柴人、撞擊、撞擊、撞擊、白色面具…… 跳剪畫面過後，一組奇怪的字眼浮現於腦間——｢火柴人預言｣。 它們頭上，該是寫著一個個數字，預言著我們的死亡時間！ 還有還有！火柴人圖案的右上角，該是畫著一個戴著面具的｢防毒面具火柴人｣，遠遠的看著他們……兩大，一小。 想罷，我即低頭向椅背的火柴人圖案看去，嘗試察看預言數字的蹤影——卻看不到。給剛剛劃上去，還閃墨水反光的紅色火柴人公仔，它們頭上除了其他沒關係的原子筆塗鴉外，根本沒有數字，右上角也沒啥｢防毒面具火柴人｣。 就這樣的，只有十七個火柴人圖案，手牽著手｢站｣在那邊。 不對啊，沒有｢數字｣，沒有｢面具｣，難道這裡不是我記憶中的｢那識。 小巴上乘客的穿衣打扮得很像｢那些人｣，卻都不是｢那些人｣——對我來說，他們完全全任是群素未謀面的人。而我就這樣站在那邊，跟他們尷尬對望著。 此時紅van已駛離了旺角道，轉進何文田與九龍塘交界，準備於窩打老道上飛馳。 ｢啪噠、啪噠、啪噠、啪噠……｣ 那裡突然傳來一陣強勁的電子節拍，我皺眉，循著聲音抬頭看去，發覺是車頂揚聲器所傳出的音樂。如無意外，小巴司機正在聽收音機。 ｢繁星已睡　騎警已睡　狂風再共　街燈暢聚 黃燈有罪　紅燈有罪　聯黨結隊　表演壯舉｣ 聽到車頂傳來｢健神｣的聲音，我完全愣住了——在重複！一切都在重複！ 腦海間遽然出一個模糊卻真實的畫面：就在某個凌晨夜色裡，我坐上了一台從旺角開往大埔的紅van。當紅van開始轉上窩打老道時，當時的我，也一樣是在聽《極速》！鄭伊健｢健神｣的《極速》！就在我電話裡的“Midnight Express” Playlist！ 一定是！不會有錯！ ——慢著，那天晚上我到底為啥會出現在旺角？我閉合雙眼，嘗試倒帶，記起那夜凌晨的｢實際情況｣……我溘然記起陳奕迅《無人之境》的歌詞。 對！那天晚上我們在唱K！我約了幾個舊同學在旺角新之城｢唱Ｋ｣！我轉頭看著坐在位子上的｢阿信｣，雙眼猛睜，一臉詫異：｢你……我地頭先……｣ ｢阿信｣被我看得混身不自在，茫然說出一句：｢頭先？點啊，你係咪唱Ｋ唱到傻左啊。｣ ｢唱Ｋ｣！真的是｢唱Ｋ｣！這完全跟腦海裡｢那夜凌晨｣的一切都微妙地重複著！ 可到底發生了什麼事！為啥我會在這裡，為啥我會完全失去記憶！這群小巴乘客究竟是什麼一回事！他們是誰？ ｢The legend is back, I shoot suckers like crack, and attack with my tire track, as big as pay back……｣ 車頂揚聲器開始傳來《極速》中段的英語間奏，我看著車窗外快速後退的九龍塘景色，清楚紅van快要跑完這段窩打老道，開始上橋往獅子山隧道駛去。不成，雖則說不出是幹嘛，心底卻有股強力的預感，告知我非常不好的悲劇即將發生，並叫我趕快需要下車，就現在！ 我轉過頭來，望向前方，準備向車頭開車的｢小巴司機｣大嚷叫：｢停——｣ 可話說到一半，卻被另一把男聲給掩蓋住。 ｢阿池！｣ 聲音竟在喊我的名字。 我立即轉身，循著聲音源頭看去。就在小巴的車頭位置，靠近窗邊的座位旁，站著兩個身影，一男一女。 我不｢認識｣他們，卻｢認得｣他們。 一如車廂內其餘乘客，此時此刻，他們已全然換上一副我不認識的臉孔，以及一把我不認識的聲線。可從｢他們｣的身高、體格、以至肢體語言來判斷，我還是第一眼就能把他們辨識出來。 ｢中年男子｣，｢Yuki｣。 剎那間，猶如電影中那些沒人說話，彼此只道看著對方的奇怪場面，在這搖晃不定的紅van車廂裡，我們三人就這樣的對望了兩秒，面面相覷。我甚至確定不了，此刻站在眼前的二人，到底是誰？ ｢卟嗒。｣ 一記清脆的輪胎響，腳底下傳來微蕩，紅van已跑完了窩打老道，開始上斜。我扶著椅背，勉強穩住身子，皺眉向眼前的二人投以疑問目光：｢你地……｣ 首先點頭的是｢中年男子｣，他依舊一臉驚訝的看著我，口角顫抖道：｢阿池？係咪你？你……都黎左？｣ ？！ 聽到｢中年男子｣的｢係咪你｣疑問，一個荒謬又恐怖的可能性在我腦裡閃過——我會不會已經跟其他人一樣，臉上的容貌已經改變？ 剎那間我是很想拿出手機，或是擠身到玻璃窗前，看看自己的反光倒影。可隨著紅van上斜拐右，駛過了映月臺，我就知道距離紅van駛進獅子山隧道的時間已無多，心內的不安感覺愈滾愈大，不應再浪費時間。 ｢阿池，係咪你?｣｢中年男子｣又問：｢你都黎左？｣ 我把視線放回在｢中年男子｣和｢Yuki｣身上，這素未謀面卻又無比熟悉的兩人。久久未語的Yuki面如鐵青，似乎未能接受這是一件真實發生的事。 ｢究竟發生咩事?｣｢中年男子｣繼續說，口沬橫飛：｢頭先一有知覺，起身已經坐左係架小巴度……呢度究竟係邊度？發生咩事！｣ 聽到｢中年男子｣的同樣疑問，我再次拍了拍額頭，嘗試在記憶中鉤起點線索……隧道……鐵門……白光……頭疼……三個人…… 中年男子，Yuki，我…… ｢我地應該係係條隧道入面！｣我閉著雙眼，痛苦地回想：｢我地三個！其他人死哂喇！得返我地三個！｣ 久久未語的｢Yuki｣，此時也頻頻點頭，終於發聲：｢我……我都記得！獅子山隧道！我地入左獅子山隧道！｣ ｢Yuki｣話音甫落，車頭已傳來｢小巴司機｣的吼叫，他沒回頭，只靠著擋風玻璃前的倒後鏡來看我們：｢喂！講撚夠未啊？你地幾條友企哂起身想點啊！｣ 我依舊皺著眉頭，看著眼前擋風玻璃，疑惑著。 ｢屌你就快入隧道喇，你地班友坐低好唔好啊！｣小巴司機繼續罵道：｢拿講明先啊！我唔撚理，總之一陣如果有差佬停架車，問你地幾條友做乜企係係度。話撚知佢係咩，我一定話唔關我事，係你地自己企乍——大家明啦？｣ 聽著｢小巴司機｣的咒罵，一段似曾相識的畫面，霍地於我腦間快速跳播…… ｢拿講明先下！我唔撚理，總之一陣上到去，如果有咩唔衣郁唔岩既，話撚知佢係咩，我一定第一個走先——大家明啦？｣ 小巴司機攤開雙手，側頭無奈道。 ！ 猶如給一記強勁閃電撃中，我瞬間愣住了。 剛剛那是什麼？剛剛想起的那句，小巴司機站在寶鄉道上，無奈看著眾人說話的這個畫面，到底是啥回事？ 未待我有多餘時間深思，紅van車頭的擋風玻璃已溘然暗淡起來，卻又瞬間給一盞一盞的蒼白燈光照亮。車外的風聲，車聲，輪胎聲，頓時變得狹隘起來。 紅van已駛進了隧道，獅子山隧道。 不成，不成，頭愈來心愈痛，顱骨下的痛楚愈滾愈大——實在有點不對勁。 ｢做咩事？｣｢中年男子｣抱頭叫道，愈說愈激動：｢點解我地會係架小巴上面？呢度係邊度黎？我唔明，我完全唔明白！｣ 我心內的疑惑跟｢中年男子｣有過之而無不及，實在回答不了他的提問。可就在同一秒鐘，我卻聽到身旁的｢Yuki｣，口中正喃喃道著什麼，聲音比蚊子拍翼更小。 ｢唔得，唔可以入隧道……｣ 嗄？她說什麼？ ｢會消失……所有人都會，消失。｣ 車外的隧道白光，湊巧打在了Yuki臉上，映出她那神情呆滯，嘴角顫抖的驚惶模樣。 剎那間，宛如一連串快速接剪的電影畫面，腦內給某種龐大的力量不斷抽搐，衝擊著。我閉合雙眼，緊皺眉頭，無可避免地感受著那些畫面…… 獅子山。廣福道。太和邨。腳踏車。美孚新邨。 摩斯密碼。湯姆少校。日語男子。胎記同學。 舊墟公園。潮童姦屍。大帽山。防毒面具人。 數位系統署。兵臨城下。那打素醫院。核爆。 倒數。獅子山隧道。 阿怡。 那夜凌晨，一台小巴，十七個乘客。 隧道前後，竟經歷了生死難忘的，三個晝夜。 然後，我想起來了。 一切，我都想起來了。 那夜凌晨， 我坐上了旺角開往大埔的紅van。 ｢呼啊……！｣ 我喘過一口氣，睜大雙眼，轉身看著車廂內的所有乘客，他們此際都是如此不解，熟悉又陌生的他們，莫名奇妙跟我對望著——可是，我想起來了。 我全都想起來了。 我連忙轉過頭來，向擋風玻璃外看去。紅van此時已跑完了大半條隧道，前方還有大概五百米的距離，純白色的拱形隧道向右拐去，穿進一片黑漆之中。亳無疑問，那就是獅子山隧道的沙田出口。 也就是一切恐怖事端的開始。 這一次，我再也不能讓它發生！ 我連忙推開｢中年男子｣和｢Yuki｣，往前踏出幾步，向｢小巴司機｣叫嚷：｢司機！停車啊！快啲停車啊！唔好出隧道，千其唔好出隧道啊！｣ ｢小巴司機｣聽到我如此叫囂，再也忍不住，終於回頭看了我一眼，詫異道：｢屌，又點啊！｣ 我沒有放棄，伸手指著前方，指著那逐接迫近的隧道出口，激動道：｢唔係，你一定要聽我講！千其唔好出去！千其唔好出隧道！會消失架——佢地全部人都會消失架！｣ ｢屌香港地真係好撚多痴線佬！｣小巴司機想也不想，轉頭看回前方，繼續開車：｢頂你個肺，咁撚鐘意搞事——我出到收費亭就放低你，你條痴線佬食自己啦，仆街！｣ 聽到如此一句，我不禁急了起來。 ｢唔係啊！我求下你，你要信我！宜家就停車！｣我雙眼睜得猛大，嘗試叫｢小巴司機｣相信我的話：｢你一出隧道就會開始，成個世界就會消失架喇！全部人，全部車，通通都唔見哂，剩返我地十七個！你要宜家就停車！我求下你！｣ ｢戇鳩鳩……｣小巴司機失笑一聲，緩緩搖頭。 與此同時，身後也傳來一陣訕笑聲，回頭看去，車廂內所有乘客均也顯出一種冷漠的嘴臉，沒人願意相信我講的話。 ｢我一早講撚左，係要搭van仔入大埔架啦！你睇，有戇鳩仔睇喎！｣我看到一個應該是｢睇波男｣的人，向身旁的｢睇波女｣道。 ｢屌，前面班阿叔係度He-he-hur-hur，咩事啊。｣兩個年紀比較小，打扮旺角的｢MK潮童｣在竊竊私語。 ｢喂，個靚仔頭先講咩話？咩消失啊？｣後方一個短髮女子｢Jasmine｣，向身旁的｢眼鏡青年｣道。 ｢唔知啊，我都唔明。｣聰明盡頂的｢眼鏡青年｣，此時卻一臉糊塗應道。 ｢喂！阿池！｣車廂末端，帶著黑框眼鏡的｢阿信｣正極力向我揮手：｢阿池……喂！你搞乜啊！痴左線咩！快啲番埋黎坐啦！｣ 無論如何，整台紅van就是沒人願意相信我的話。 我再次轉身，看著擋風玻璃外的火速靠距的隧道出口——剩下兩百米。 ｢我揸咁撚耐小巴，咩都見過哂，仆街，就係無見過痴線佬喎！｣｢小巴司機｣繼續笑著，並指著紅van外面的隧道情況，道：｢屌你老母，你自己睇下，仲有人過我地頭添啊，點消失啊！消失，我宜家就要你係我面前消失啊仆街！｣ 猶如電影中的慢動作鏡頭，我看著隧道隔壁線，兩台快速超過我們的私家車，一藍一紅——這感覺似曾相識。 沒錯，就在我們出事的｢那夜凌晨｣，這兩台私家車，也曾經在這超過我們。我也想起，當晚出隧道前，除了兩台超過我們的私家車外，紅van後方更有一台通宵巴士，就在我們後面。 想罷，我立即轉身往紅van後方的玻璃窗外看。果然，看到一台編號是｢N｣字起首的通宵巴士在後方狂追不捨。我看著通宵巴士兩盞耀眼的車頭燈，嘆了口氣。 沒有例外，一切都在重複。 回頭再望前方擋風玻璃，只剩下一百米。 只剩下一百米的距離，悲劇就會再度重演。 就在這時候，不斷在嘲笑我的｢小巴司機｣，臉上神色忽地一轉。與此同時，我感到腳底下震盪了下，傳來｢卡噠卡噠｣的聲響。 紅van慢了起來。 它慢起來了！ ｢屌！乜撚野事啊又！｣｢小巴司機｣邊握著方向盤，邊察看座椅下的腳踏油門，｢唔撚係啊，隧道先黎壞車？｣ ！ 天！這可是真的？ 我側頭看著窗外飄然而過的景物，發覺它們向後消失的速度的確是減慢了——紅van的確慢了起來！它慢起來了！ 分不清這到底是命運安排，還只是單純的機緣巧合，紅van竟會在如此關鍵時刻才壞掉。我不禁轉悲為喜，同時咬緊牙關，緊張的看著前方的僅餘一百米，期望紅van能夠在隧道出口前安然停下。 ｢個引擎壞左？停唔停到！｣我心情複雜的看著｢小巴司機｣，緊張問道：｢係隧道口前停唔停到！｣ ｢小巴司機｣卻激動握著方向盤，雙眼睜得大大的，吼叫道：｢我頂你個肺！唔剩係個引擎壞撚左，係成架車都壞撚哂啊！｣ 嗄？我蹲在車頭位置，聽不懂｢小巴司機｣剛剛說的話。 "];
    [self.storyDescriptionCell.textLabel setText:storyPart.title];

    NSLog(@"text = %d", storyPart.title.length);
    [self.questionCell.textLabel setText:@"究竟嘲笑她的，是甚麼呢？"];
    [self.choiceACell.textLabel setText:@"1. 你好"];
    [self.choiceBCell.textLabel setText:@"2. Omg! 佢係我上司個朋友個朋友個朋友個朋友個朋友個朋友個朋友個朋友個朋友"];
    [self.choiceCCell.textLabel setText:@"3. 你好"];
    [self.choiceDCell.textLabel setText:@"4. 你好"];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3 + 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = self.cells[indexPath.row];
//    cell.textLabel setf
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) return 150;
    
    UITableViewCell *cell = self.cells[indexPath.row];
    CGSize size = [self labelSizeOfLabel:cell.textLabel WithMargin:0];
    return size.height + [self verticalMarginOfCell:cell];
}

- (CGFloat)verticalMarginOfCell:(UITableViewCell *)cell
{
    if (cell == self.questionCell) return 40;
    if (cell == self.storyDescriptionCell) return 10;
    return 25;
}

#pragma mark - target

- (void)forwardButtonDidClick:(UIButton *)button
{
    NSLog(@"button = %@", button);
    if (self.currentStoryPartIndex >= self.story.maxPage) return;
    self.currentStoryPartIndex += 1;
    [self loadCurrentStoryPart];
}

- (void)reverseButtonDidClick:(UIButton *)button
{
    NSLog(@"button = %@", button);
    if (self.currentStoryPartIndex <= 0) return;
    self.currentStoryPartIndex -= 1;
    [self loadCurrentStoryPart];
}

- (void)favButtonDidClick:(UIButton *)button
{
    NSLog(@"button = %@", button);
}

- (void)listButtonDidClick:(UIButton *)button
{
    NSLog(@"button = %@", button);
}

#pragma mark - lazy loading

- (NSArray *)cells
{
    if (!_cells) {
        _cells = @[self.thumbnailCell, self.storyDescriptionCell, self.questionCell, self.choiceACell, self.choiceBCell, self.choiceCCell, self.choiceDCell];
    }
    return _cells;
}

- (ChoiceCell *)newChoiceThumbnailCell
{
    ChoiceCell *cell = [[ChoiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChoiceCell"];
    [cell.textLabel setNumberOfLines: 0];
    
    return cell;
}

- (UITableViewCell *)thumbnailCell
{
    if (!_thumbnailCell) {
        _thumbnailCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThumbnailCell"];
        [_thumbnailCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [_thumbnailCell setFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
        
        UIImageView *thumbnailView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.75, self.view.frame.size.width * 0.75 * (9.0 /16.0))];
        [thumbnailView setCenter:CGPointMake(CGRectGetMidX(_thumbnailCell.bounds), CGRectGetMidY(_thumbnailCell.bounds))];
        [thumbnailView setImage:[UIImage imageNamed:@"demoThumbnail.jpg"]];
        [thumbnailView setBackgroundColor:[UIColor blackColor]];
        [_thumbnailCell.contentView addSubview:thumbnailView];
        
        UIButton *reverseButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 25, 35, 50)];
        [reverseButton setTitle:[NSString fontAwesomeIconStringForEnum:FAIconBackward] forState:UIControlStateNormal];
        [reverseButton addTarget:self action:@selector(reverseButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *favButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 75, 35, 50)];
        [favButton setTitle:[NSString fontAwesomeIconStringForEnum:FAIconBookmark] forState:UIControlStateNormal];
        [favButton addTarget:self action:@selector(favButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *forwardButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 35, 25, 35, 50)];
        [forwardButton setTitle:[NSString fontAwesomeIconStringForEnum:FAIconForward] forState:UIControlStateNormal];
        [forwardButton addTarget:self action:@selector(forwardButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *listButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 35, 75, 35, 50)];
        [listButton setTitle:[NSString fontAwesomeIconStringForEnum:FAIconList] forState:UIControlStateNormal];
        [listButton addTarget:self action:@selector(listButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [@[reverseButton, favButton, forwardButton, listButton] enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
            [button.titleLabel setFont:[UIFont fontWithName:kFontAwesomeFamilyName size:12]];
            [button setTitleColor:[UIColor colorWithHex:@"#95a5a6" alpha:1] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor colorWithHex:@"#ecf0f1" alpha:1] forState:UIControlStateNormal];
            [_thumbnailCell.contentView addSubview:button];
        }];
        
    }
    return _thumbnailCell;
}

- (CGSize)labelSizeOfLabel:(UILabel *)label WithMargin:(CGFloat) margin
{
    CGRect labelSize = [label.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 30 - margin * 2, CGFLOAT_MAX)
                                                options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                             attributes:@{NSFontAttributeName:label.font,
                                                          NSParagraphStyleAttributeName : [NSParagraphStyle defaultParagraphStyle]}
                                                context:nil];

    return labelSize.size;
}

#pragma mark - lazy loading of tableviewcell

- (UITableViewCell *)storyDescriptionCell
{
    if (!_storyDescriptionCell) {
        _storyDescriptionCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DescriptionCell"];
        [_storyDescriptionCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [_storyDescriptionCell.textLabel setNumberOfLines:0];
        [_storyDescriptionCell.textLabel setFont:[UIFont systemFontOfSize:16]];
    }
    return _storyDescriptionCell;
}

- (UITableViewCell *)questionCell
{
    if (!_questionCell) {
        _questionCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QuestionCell"];
        [_questionCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [_questionCell.textLabel setNumberOfLines:0];
    }
    
    return _questionCell;
}

- (ChoiceCell *)choiceACell
{
    if (!_choiceACell) {
        _choiceACell = [self newChoiceThumbnailCell];
        [_choiceACell setBasicColorHex:@"#e74c3c"];
    }
    return _choiceACell;
}

- (ChoiceCell *)choiceBCell
{
    if (!_choiceBCell) {
        _choiceBCell = [self newChoiceThumbnailCell];
        [_choiceBCell setBasicColorHex:@"#f1c40f"];
    }
    return _choiceBCell;
}

- (ChoiceCell *)choiceCCell
{
    if (!_choiceCCell) {
        _choiceCCell = [self newChoiceThumbnailCell];
        [_choiceCCell setBasicColorHex:@"#3498db"];
    }
    return _choiceCCell;
}

- (ChoiceCell *)choiceDCell
{
    if (!_choiceDCell) {
        _choiceDCell = [self newChoiceThumbnailCell];
        [_choiceDCell setBasicColorHex:@"#2ecc71"];
    }
    return _choiceDCell;
}
@end
