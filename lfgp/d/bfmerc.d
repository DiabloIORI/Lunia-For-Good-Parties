/* mercy whitedove offers bounties to players who have the sigil of tyr */
BEGIN bfmerc

/* lacks sigil of tyr */
CHAIN IF ~!PartyHasItem("ohdsigil")~ THEN bfmerc bfs.nomercy
~我只为提尔的信徒发布赏金任务。没有他的圣徽，这份重担便轮不到你来承担。~ [bfblank] EXIT 

/* player has the sigil of tyr */
CHAIN IF ~PartyHasItem("ohdsigil") Global("bfsmercyspokento","LOCALS",0)~ THEN bfmerc bfs.killthemwithkindness
~你佩戴着提尔的圣徽。有此印记，我便可将一些次要的赏金任务托付于你。若你愿意接取，委任状已经备好。~ [bfblank]
DO ~SetGlobal("bfsmercyspokento","LOCALS",1)~
END
+ ~Global("bfmercyhistory","LOCALS",0)~ + ~你也是提尔的信徒吗？~ DO ~SetGlobal("bfmercyhistory","LOCALS",1)~ EXTERN bfmerc bfs.mercyhistorylesson
++ ~说说这个赏金任务吧。目标是谁？他们犯下了什么罪行？~ EXTERN bfmerc bfs.fallenfromgrace
++ ~我没兴趣追捕逃犯。~ EXTERN bfmerc bfs.justiceneversleeps

CHAIN bfmerc bfs.justiceneversleeps
~随你便。愿你寻得正义……或是报应，看你自己的造化了。~ [bfmer4] EXIT 

CHAIN bfmerc bfs.mercyhistorylesson
~不。我便是秉持公正与悲悯的白鸠，霍尔的末日使者。你可以称我为默西。~ [bfmer1]
== BFMERC ~即便在天界国度，不公也在滋生蔓延。我行走于复仇之道，在霍尔认为必要之处降下制裁。~
END
++ ~说说这个赏金任务吧。目标是谁？他们犯下了什么罪行？~ EXTERN bfmerc bfs.fallenfromgrace
++ ~我没兴趣追捕逃犯。~ EXTERN bfmerc bfs.justiceneversleeps

CHAIN bfmerc bfs.fallenfromgrace
~有一群天界生物曾是提尔与上层位面的仆从，如今却已堕落失格。他们的腐化在天堂山蔓延，玷污了天界的殿堂，也将祈并者引入歧途。~
== BFMERC ~奉提尔之命，必须将他们彻底清除，好让信徒们能在不受恶意沾染的环境中寻求指引。~ 
END
++ ~我接下这个赏金任务。~ EXTERN bfmerc bfs.fallencelestials
++ ~我对提尔事业的贡献就到此为止了。~ EXTERN bfmerc bfs.justiceneversleeps

CHAIN bfmerc bfs.fallencelestials
~以暴制暴，以恶惩恶，以善报善。~ [bfmer3]
== BFMERC ~我会将你传送至那些天界生物最后出没的林间空地。我相信你自有办法返回。~
== BFMERC ~让正义——或是复仇之心，指引你的出手。~ 
DO ~SetGlobal("bfmercycelestial","GLOBAL",1) ClearAllActions() StartCutSceneMode() StartCutScene("BFCEMT")~ EXIT

/* heard about second chances? yeah, mercy doesn't offer those */
CHAIN IF ~Global("bfsmercyspokento","LOCALS",1) !GlobalGT("bfmercycelestial","GLOBAL",0)~ THEN bfmerc bfs.mercycatchall
~我没时间和胆小鬼浪费口舌。~ [bfblank] EXIT

/* main hub & completed bounty rewards */
CHAIN IF ~Global("bfsmercyspokento","LOCALS",1) OR(2) GlobalGT("bfmercycelestial","GLOBAL",0) GlobalGT("bfmercyfiends","GLOBAL",0)~ THEN bfmerc bfs.mercymainhub
~你回来了。有什么要汇报的吗？~
END
+ ~PartyHasItem("bfpepr")~ + ~我已经解决了那些堕落的天界生物。他们再也不会骚扰卢尼亚的祈并者了。~ EXTERN bfmerc bfs.quest2completion
++ ~目前没什么事。~ EXIT

CHAIN bfmerc bfs.quest2completion
~赏罚分明、报应不爽，是文明社会的根基。~ [bfmerc2] DO ~TakePartyItem("BFPEPR") DestroyItem("BFPEPR") GiveGoldForce(10000) AddExperienceParty(210000) AddJournalEntry(@100010, QUEST_DONE)~
== BFMERC ~眼下我没有更多的赏金任务可以交给你了。~ EXIT
