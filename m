From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <48241a88-28ce-5a08-6dc8-34423634f092@...515...>
Message-ID: <406a2fec-806e-ae19-f3eb-d9918e5787ab@...515...>
Date: Wed, 30 Jun 2021 16:39:22 +0300
MIME-Version: 1.0
In-Reply-To: <48241a88-28ce-5a08-6dc8-34423634f092@...515...>
Content-Type: multipart/mixed; boundary="------------3E15530298E6C38C6D0C9A13"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (30th June 2021)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------3E15530298E6C38C6D0C9A13
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on libera.chat
Date: Wed 30rd June 2021
Time: 14:00 CET (12:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2021-06-30>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, d12fk, lev, mattock, MaxF, novaflash, ordex and plaisthos 
participated in this meeting.

---

Finished the CVE text for OpenVPN 2.5.3:

"OpenVPN before version 2.5.3 on Windows allows local users to load 
arbitrary dynamic loadable libraries via an OpenSSL configuration file 
if present, which allows the user to run code with the same privilege 
level as the main OpenVPN process (openvpn.exe)."

---

Noted that rob0 from IRC was hired as support person for OpenVPN Inc. 
He'll be working mostly on the commercial support side.

There are other open positions as well, so OpenVPN Inc encourages 
interested people to send in applications, or to notify people who might 
be interested:

<https://careers.openvpn.net>

---

Noted that the console fixes for Windows are now merged. They work on 
the most recent Windows Insider build (tested on ARM64).

---

Lev is working on AS support for openvpn-gui and will send first PR 
soonish. There will be "Import from Access Server..." menu item, which 
opens host/user/pwd dialog, which then imports profile from AS.

Talked about the option for making this work on non-AS profile download 
portals as well. The "application/x-openvpn-profile" MIME type used by 
AS could be converted into a de facto standard.

---

Talked about OpenVPN 2.6. Noted that ordex and cron2 need to busy 
themselves with "what we have on the list" to free space for the new 
patch wave. Agreed to work on this the upcoming Friday.

---

Agreed to have the OpenVPN 2021 hackathon on 5.-7.11.2021. That way 
everyone except ordex will be able to join. Also, ordex might be able to 
join as well, if he's lucky.

Talked about the meeting space options (Regus, ImpactHub, etc). Dazo 
made an inquiry to Regus, cron2 will look around a bit more.

Novaflash will ask the OpenVPN Inc. accountant how to handle the 
finances part of booking the meeting space.

-- 

Full chatlog attached

--------------3E15530298E6C38C6D0C9A13
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2021-06-30.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2021-06-30.txt"

(15:00:48) mattock_: howdy
(15:00:52) plaisthos: moin moin
(15:01:07) MaxF: hi
(15:01:07) novaflash: hallo daar generaal kenobi
(15:01:39) d12fk: no funny speak novaflash =3D)
(15:01:49) novaflash: okay, humor removed
(15:02:21) d12fk: was targeting dutch rather ;-)
(15:02:31) novaflash: i know ;-) =20
(15:02:44) novaflash: so topic still points to last week's agenda
(15:02:49) ordex: hi
(15:03:01) lev___: hello
(15:03:05) dazo: hey!
(15:03:07) plaisthos: that is an improvement, last week the topic was 3 w=
eeks old
(15:03:13) novaflash: so we're catching up
(15:03:51) dazo: we probably need vpnHelper here to get the right privs
(15:04:29) cron2: howdy
(15:04:42) plaisthos: are we doing text or video based meeting this week?=

(15:05:56) cron2: do we have a security topic?  Otherwise I'd stick to te=
xt
(15:06:49) dazo: +1
(15:07:06) novaflash: good. i hadn't put on my makeup or my wig yet
(15:07:18) dazo: I don't think we have any security topics .... maybe we =
can quickly just have a look at the CVE description of the last release w=
e did
(15:07:33) mattock_: text is good
(15:07:46) dazo: OpenVPN before version 2.5.3 on Windows allows local use=
rs to load arbitrary dynamic loadable libraries via an OpenSSL configurat=
ion file if present, which allows the user to run code with a different p=
rivilege level.
(15:08:42) novaflash: seems okay to me. the description, not the bug.
(15:08:52) cron2: maybe not, as openvpn runs with the privileges of the u=
ser normally
(15:08:53) dazo: I know lev___ had some thoughts around specifying "diffe=
rent privilege levels" ... But we don't need to be too specific in these =
notes
(15:10:14) cron2: ... which in certain deployment scenarios might allow r=
unning code with different privileges
(15:10:32) dazo: yeah, that's what I'm accounting for
(15:10:52) cron2: you either need to run openvpn gui as admin (in which c=
ase you have root already) or have different users on the same machine, a=
nd drop a .cnf for the *other* user to find
(15:11:06) dazo: yupp
(15:11:14) lev___: I was wondering if we need to state that it is not run=
ning as, say, SYSTEM
(15:11:45) cron2: if someone runs openvpn from regular service, and a .cn=
f can be dropped, that would give you admin
(15:12:47) lev___: well yeah, but that's not how ppl usually run openvpn =
I guess
(15:13:10) cron2: some do, so "there is an attack angle", but it needs sp=
ecific setups
(15:13:12) dazo: lev___: we generally don't really need to specific what =
is not possible, the text should focus on the possibilities ... running a=
 code "unexpectedly" with a different privilege level is the issue which =
can be abused
(15:14:10) cron2: I find it relevant on whether this is possible on "norm=
al installs" or whether you need to do "something" first (like: have admi=
n privs to set up the service)
(15:14:22) dazo: that's a good point
(15:14:57) d12fk: but that is not for the CVE text, but rather the explai=
ner page on openvpn.net
(15:14:58) dazo: lev___: I'm not sure it makes things clearer if we say "=
[...]  run code with a different privilege level except SYSTEM" ...
(15:15:20) dazo: d12fk: true
(15:15:22) novaflash: "which allows to run code under a different user co=
ntext" - ?
(15:16:05) ordex: how about "a different privilege level" --> "the same p=
rivilege level as the OpenVPN process" ? so we remove every ambiguity...t=
he longer description can explain what happens by default and what not
(15:16:50) lev___: as "openvpn.exe" process
(15:17:12) dazo: yeah, that sounds clearer
(15:17:16) novaflash: yeah makes sense ordex and lev
(15:17:43) ordex: yeah, with openvpn.exe it is even better
(15:18:33) cron2: +1
(15:18:35) dazo: "OpenVPN before version 2.5.3 on Windows allows local us=
ers to load arbitrary dynamic loadable libraries via an OpenSSL configura=
tion file if present, which allows the user to run code with the same pri=
vilege level as the main OpenVPN process (openvpn.exe)."
(15:19:05) novaflash: works for me
(15:19:35) cron2: +1
(15:20:03) dazo: thx!  Then I'll submit that to MITRE later today
(15:20:11) ordex: +1
(15:20:23) lev___: 1+
(15:20:30) ordex: 1++
(15:20:32) cron2 ha scelto come argomento: https://community.openvpn.net/=
openvpn/wiki/Topics-2021-06-30
(15:20:36) ordex: o.o
(15:20:45) dazo: cron2 is privileged!
(15:21:09) ordex: can we stick a dll up cron2's client and run with the s=
ame user privilege?
(15:21:19) modalit=C3=A0 (+oo mattock_ dazo) da cron2
(15:21:21) novaflash: not since the update
(15:21:43) dazo: :D
(15:23:07) cron2: not sure I want to know how many interesting angles of =
attack irssi has
(15:23:55) ordex: as long as you run it as root, you should be safe[tm]
(15:24:42) cron2: what do you mean with "run *it* as root"?
(15:24:51) cron2: are there other options?
(15:25:16) novaflash: insert meme of stephen king's IT and something abou=
t root
(15:25:29) dazo: that's why we need znc and bouncers, right!?
(15:25:32) novaflash: i have some interesting news perhaps
(15:25:39) ***ordex hides
(15:25:40) novaflash: we hired a guy from community
(15:26:05) novaflash: and he'll be doing mostly commercial product suppor=
t but also has deep understanding of openvpn and routing and such
(15:26:16) novaflash: and will be on community forums too, mostly in the =
commercial products section tho
(15:26:27) novaflash: his name is rob0
(15:27:11) cron2: that is good news
(15:27:26) novaflash: yep
(15:27:39) novaflash: okay newsflash over, please resume normal programmi=
ng
(15:28:42) cron2: 2.5 update -> console fixes for windows merged, works o=
n arm64 "most recent insider build" now.  Maybe not enough for a 2.5.4 re=
lease yet :-)
(15:28:58) cron2: 2.6 update -> have merged some of plaisthos' already-AC=
Ked patches, need to resume on 6/9
(15:29:52) cron2: ordex: are you already back, or just visiting today?
(15:30:22) dazo: that said, we do have open positions ... so we encourage=
 interested people to send in applications, or people you know who could =
be interested ..... https://careers.openvpn.net/
(15:30:45) ordex: cron2: back back
(15:30:49) ordex: and catching up
(15:30:59) cron2: $ host -t aaaa careers.openvpn.net        =20
(15:30:59) cron2: careers.openvpn.net has no AAAA record
(15:31:06) dazo: :D
(15:31:08) ***cron2 wouldn't want to work in a last-century corp
(15:31:13) dazo: "it's a trap!"
(15:31:30) novaflash: we've moved on to ipv17 invented by james
(15:31:57) cron2: novaflash: you haven't, because nobody has managed to u=
nderstand which combination of 2^17 options you need to make it work
(15:32:21) novaflash: it hurts
(15:32:27) cron2: (this is a reasonably safe claim for new openvpn featur=
es... :-) )
(15:33:59) ordex: :D
(15:34:04) ordex: enable 'em all !
(15:34:28) dazo: :D
(15:36:29) ordex: what's next on the list?
(15:36:45) cron2: more updates on 2.5/2.6?  like, 2.6 release schedule?
(15:37:27) lev___: I am working on AS support for openvpn-gui, will send =
first PR soonish
(15:37:36) cron2: wat?
(15:37:49) novaflash: heh
(15:37:53) novaflash: he means importing
(15:38:00) mattock_: openvpn-gui shall be better and smaller than OpenVPN=
 Connect thanks to Lev
(15:38:05) novaflash: importing .ovpn files from access server directly
(15:38:08) mattock_: 190MB thinner
(15:38:23) lev___: there will be "Import from Access Server..." menu item=
, which opens host/user/pwd dialog, which then imports profile from AS
(15:38:58) cron2: is that how openvpn connect does it?
(15:39:17) lev___: yeah, somewhat
(15:39:30) novaflash: REST API in AS - same import process as in connect =
v3
(15:39:40) cron2: I wonder if we could do it web style - use a normal web=
 browser, server sends proper MIME-type, windows will know that "this goe=
s to openvpn gui"
(15:40:05) ordex: application/openvpn
(15:40:11) cron2: (so this would be usable for non-AS download portals as=
 well)
(15:40:17) novaflash: a thought had occurred about URI like ovpn://
(15:40:33) plaisthos:                 i.setType("application/x-openvpn-pr=
ofile");
(15:40:33) plaisthos:                 supportedMimeTypes.add("application=
/x-openvpn-profile");
(15:40:36) plaisthos:                 supportedMimeTypes.add("application=
/openvpn-profile");
(15:40:37) ordex: the URI needs to be supported by the browsers though
(15:40:38) plaisthos:                 supportedMimeTypes.add("application=
/ovpn");
(15:40:40) plaisthos: these are the ones I seen in my app
(15:40:57) plaisthos: not sure which one is the correct one they all seem=
 to be floaing around
(15:41:17) ordex: :D
(15:41:21) cron2: we might just decide on an official type...
(15:41:34) plaisthos: AS itself uses application/x-openvpn-profile
(15:41:45) cron2: that sounds very official to me
(15:41:58) d12fk: x- prefix is not official i think
(15:42:09) plaisthos: yeah
(15:42:09) cron2: and I think I copied that to one of my web servers - "j=
ust ship all .ovpn files with that mime type", and voila, import to iOS c=
lient works
(15:42:24) plaisthos: but we have not registred it offically as RFC or wh=
ereever you register
(15:42:34) cron2: x- means "it is not registered with the authorities", b=
ut of course we can declare "this is what our suite of things supports"
(15:43:28) d12fk: respect our authoritah
(15:43:53) ordex: resteppa
(15:43:55) cron2: AddType application/x-openvpn-profile ovpn
(15:43:58) cron2: yeah
(15:44:54) plaisthos: iirc application/ovpn is from some somewhat broken =
software that that just takes the file extension and throws that into app=
lication/%s
(15:49:03) cron2: so, back to 2.6 release - where are we, regarding feasi=
bility of this?  Has all code been written for linux-dco and dco-win?
(15:49:26) ordex: well, we still need to go through the next wave of patc=
hes from plaisthos=20
(15:49:43) ordex: I think that means another 15/20 patches, plaisthos ?
(15:49:55) plaisthos: linux dco needs testing and statistics implemented =

(15:49:58) ordex: which requires quite some beautification though (as far=
 as I recall)
(15:50:25) ordex: I guess we will get testing started once we finally get=
 to review the final patches on the ml
(15:50:41) ordex: that way we know we have all the bits merged, and only =
the rea dco change is missing
(15:50:47) ordex: *real
(15:50:57) cron2: so we (=3Dordex and I) need to busy ourselves with "wha=
t we have on the list", it seems, to free space for the new wave
(15:51:07) ordex: yap
(15:51:10) cron2: yap
(15:51:26) ordex: my status is: review the remaining patches in plaisthos=
' last patchset
(15:51:30) ordex: I think 3 were missing before I left
(15:51:35) plaisthos: there is also the patch to avoid amplification=20
(15:53:07) ordex: yeah
(15:53:36) cron2: yeah.  I've seen that but had no time to think through =
it.  It seemed complicated, but that reflects on me not understanding the=
 details.  Friday?
(15:54:10) plaisthos: friday works for me
(15:54:45) cron2: blocking my calendar...
(15:55:38) dazo: Speaking of calendar ..... Hackathon dates
(15:56:19) dazo: I've had a chat with James, and he is able to add Nov 19=
-21 if that opens possibilities for more to join
(15:57:01) dazo: I will not be able to join physically, but can probably =
be available online for certain timeslots ... I have no issues with such =
a solution
(15:57:26) ordex: wasn't there another weekend which would work for you a=
nd james too ?
(15:58:03) mattock_: https://doodle.com/poll/ac9dbsqwd8ftkqup
(15:58:10) dazo: the two first ones of November .... but I value your pre=
sence and contributions higher than mine :-P
(15:58:33) ordex: well, to be honest, my likelihood of joining is very lo=
w at the moment
(15:58:38) plaisthos: yeah I am not sure that trading ordex only availabl=
e online but only maybe with dazo and ordex only available is a good trad=
e %)
(15:58:45) ordex: because I have no clue how the first month will go
(15:58:51) ordex: therefore I'd assume I won't join on any date
(15:59:19) ordex: then, if I can, I will just book and join, otherwise I'=
ll be online
(15:59:56) mattock_: in that case the first two weekends would be best
(16:00:09) mattock_: well, the first one
(16:00:10) plaisthos: I am blocked on the second weekend
(16:00:28) mattock_: shall we go with the first one?
(16:00:50) novaflash: added my own availability too in case it matters
(16:01:24) plaisthos: yeah. Sounds good. And we need then to decide if we=
 internally want extra days before or after that weekend for our internal=
 meeting
(16:01:26) cron2: ordex: you'll be looking for any opportunity to escape =
to freedom & sleep
(16:01:32) cron2: :)
(16:01:34) mattock_: :)
(16:01:36) mattock_: agreed
(16:01:52) dazo: +1
(16:02:07) plaisthos: the question is if his girlfirend/wife lets him esa=
cpe
(16:02:22) ordex: :D
(16:02:31) mattock_: indeed
(16:02:31) cron2: no more friend if wife...
(16:02:37) ordex: well or whether she requires help of any sort
(16:02:51) dazo: plaisthos: that's just a matter of how well of an actor =
ordex is ...... :-P
(16:02:57) mattock_: "sorry honey, I'm gonna go hacking and drinking with=
 the guys" would not work?
(16:02:59) ordex: hehe
(16:03:04) cron2: that's more the point.  Very likely she'll be very than=
kful for any help and support
(16:03:12) ordex: anyway, still quite "unknown" so I'd not consider me fo=
r planning
(16:03:40) mattock_: anyhow, first weekend it shall be
(16:03:51) cron2: which one is this?
(16:04:01) dazo: Nov 5-7
(16:04:03) mattock_: yep
(16:04:15) mattock_: everyone except order will make it then
(16:04:19) mattock_: ordex lol
(16:04:26) mattock_: we'll see about order when we're there
(16:04:27) novaflash: law and ordex
(16:04:29) mattock_: +1
(16:04:35) ordex: :D
(16:04:50) d12fk: is munich set already?
(16:04:50) novaflash: well at least we won't get some bioweapon thrown at=
 us like last time in italy
(16:05:00) novaflash: i recall people being quite sick
(16:05:10) mattock_: I was affected by a bioweapon (stomach flu)
(16:05:15) mattock_: but not the bigger bio-weapon
(16:05:34) mattock_: I don't think we've agreed on munich quite yet
(16:05:47) mattock_: cron2 was supposed to check for a space we could ren=
t
(16:06:00) cron2: haven't found anything reasonable yet (but have not loo=
ked hard)
(16:06:25) ***cron2 packs this on the friday agenda
(16:06:52) d12fk: are we aiming at hotel conference rooms or something mo=
re initimate?
(16:07:01) novaflash: uhhh
(16:07:11) novaflash: i have a girlfriend :-P =20
(16:07:33) cron2: novaflash: now that can be fixed
(16:07:46) plaisthos: so not a strip club?
(16:08:30) novaflash: that doesn't work out so well as a meeting place
(16:08:38) mattock_: makes focusing harder
(16:08:39) mattock_: for many
(16:09:04) mattock_: hotel conference room could work if there's nothing =
else
(16:09:07) d12fk: yeah the loud music...
(16:09:17) mattock_: exactly, you nailed it d12fk :)
(16:09:26) cron2: https://techmeetups.com/8-best-coworking-spaces-in-muni=
ch/
(16:09:43) plaisthos: cron2: no strong preference. But when I checked 2 y=
ears ago, hotel conference rooms are extremely expensive for no appearent=
 reason but some hotels give you discounts down to almost 0 if you also b=
ook enough hotel rooms and it is all very messy to find out ...
(16:09:44) cron2: there's an impact hub :-)
(16:10:11) ordex: oh :)
(16:10:53) plaisthos: if booking a meeting room in a coworking space for =
almost a week is possible that is also a good option
(16:11:13) cron2: someone could mail me (off-list) the expected number of=
 corp people attending, how many days, and what budget we're talking abou=
t
(16:11:44) plaisthos: cron2: I don't really think anyone apart from those=
 in the doodle will attend
(16:12:07) novaflash: budget is 50 bucks and a macdonalds discount coupon=

(16:12:21) novaflash: no just kidding, we can get those details to you
(16:12:56) cron2: thanks :)
(16:13:23) novaflash: mattock_ is this something you want to pick up as c=
ommunity liaison or do i need to get involved in getting these details?
(16:13:47) mattock_: you're closer to the money
(16:14:06) mattock_: "how many days" depends on the core team
(16:14:30) mattock_: I'm not sure who has handled budgeting these things =
in the past
(16:14:53) mattock_: but we can discuss this internally as well
(16:15:11) plaisthos: usually someone payed the shared cost and just invo=
iced it back to the company
(16:15:35) ordex: yeah, what plaisthos says
(16:15:55) ordex: each of us would then book and pay his own room. unless=
 we wanna do a group thing to get some discount
(16:16:07) ordex: but we are not that many, imho, to get a discount
(16:16:10) plaisthos: even with group booking you can still pay individua=
lly
(16:16:15) mattock_: I think the meeting room cost is the only "but" here=

(16:16:44) novaflash: i'll throw a line at our accountant and see what he=
 thinks on best approach to this
(16:16:47) ordex: novaflash could provide a budget proposal to corp and g=
et an "ok"
(16:16:55) mattock_: sounds good
(16:17:00) cron2: I have no idea what that stuff cost, but a co-working-s=
pace is likely "somewhat reasonable" - and nicer than hotel with crappy h=
otel wifi and expensive coffee
(16:17:05) ordex: then whoever pays can invoice the company and get it re=
funded
(16:17:29) cron2: I know one of those ("shared office space with crappy w=
ifi and expensive coffee") but this is no fun
(16:17:38) ordex: :D
(16:17:44) dazo: cron2: I can check what kind of discounts I can get on R=
egus, I presume they have locations in Munich
(16:18:13) plaisthos: cron2: I have seen for meeting rooms everything fro=
m 100-150 EUR/day to 200 EUR/h=20
(16:18:21) cron2: they do, but do "we" like that style?  From what I know=
, Regus is that style...
(16:18:28) cron2: plaisthos: yeah
(16:19:10) cron2: my last ties to the local university literally died two=
 years ago... :(
(16:21:18) dazo: not sure what you mean with "that style" .... but it's g=
enerally reasonably meeting rooms with reasonable wifi and often wired ne=
tworks too.  But pricing varies a lot.
(16:21:37) cron2: https://munich.impacthub.net/raum-buchen/#1557314620754=
-1c66391b-98d5
(16:21:45) cron2: now *that* is what I call a proper location :-)
(16:22:18) plaisthos: workshoproom would be probably the right size for u=
s
(16:22:20) cron2: dazo: well, that shared office location I know (which i=
s not Regus, but similar) has crappy network, and expensive pay-per-cup c=
offee... so that I wouldn't recommend
(16:22:37) cron2: but the COUBERTIN-SPRINTCENTER is much nicer :-)
(16:22:55) dazo: ahh, no, no ... Regus is usually far more reasonable ...=
=2E at least in Oslo, Prague and Brno (I've used them all)
(16:24:48) novaflash: gotta jump out, have incredibly interesting documen=
tation to update
(16:25:02) ***cron2 has a commercial meeting in 6 minutes...
(16:25:15) novaflash ha abbandonato la stanza (quit: Quit: balls).
(16:29:47) cron2: inquiry to impact hub sent out for tuesday-sunday / nov=
 2 - 7
(16:30:34) dazo: I'll send a similar request via Regus
(16:30:49) dazo: (as I have some kind of discount there already)
(16:31:16) plaisthos: cron2: thanks!
(16:32:20) mattock_: almost done with the summary

--------------3E15530298E6C38C6D0C9A13--

