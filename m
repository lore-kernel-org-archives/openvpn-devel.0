Message-ID: <5614D886.4070701@...515...>
Date: Wed, 07 Oct 2015 11:32:06 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <56125675.3060109@...515...>
In-Reply-To: <56125675.3060109@...515...>
Content-Type: multipart/mixed; boundary="------------030300090004000303030906"
Subject: Re: [Openvpn-devel] Topics for today's (Monday,
 5th Oct 2015) community meeting (note: 30 mins early)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------030300090004000303030906
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of today's IRC meeting. Better late than never.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Monday 5th Oct 2015
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2015-10-05>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, ecrist, krzee, lev, mattock, syzzer, TimSmall and ValdikSS=20
participated in this meeting.

---

Discussed CloudFlare HTTPS caching, which was recently enabled on=20
community.openvpn.net due to a DoS attack. As CloudFlare had the private=20
key even before this incident, disabling caching again does not make=20
much sense from security perspective.

---

Discussed the arrival schedules and made plans for the Delft hackathon.=20
All important details are on the Trac DelftHackathon2015 page:

<https://community.openvpn.net/openvpn/wiki/DelftHackathon2015>

---

Discussed Windows building. Cron2 gave lev's MSVC patches and ACK and=20
will merge them.

---

Discussed the option of bundling some other OpenVPN Windows GUI with=20
OpenVPN Windows installers. The problem with current one (OpenVPN-GUI)=20
is that it has not been maintained actively in two years. According to=20
ValdikSS there are several actively maintained, featureful and stable=20
GUIs for Windows. Mattock will ask ValdikSS to compile a list of options.

---

Discussed the Windows 10 DNS leak issue:

<https://community.openvpn.net/openvpn/ticket/605>

It was agreed that integrating the code into win32.c is reasonable. It=20
was also agreed to get some feedback from James during the hackathon=20
before moving forward with this.

---

Discussed the "Expired server cert not shown as error message" issue:

<https://community.openvpn.net/openvpn/ticket/601>

It was agreed that warning about certificate expiration makes perfect=20
sense on the client side.

---

Discussed the "Privileges not being dropped if the first connection is=20
not successful" patch:

<http://article.gmane.org/gmane.network.openvpn.devel/10079>

The latest incarnation of the patch got an ACK from cron2 and syzzer,=20
but the patch was mangled and did not merge. Syzzer promised to ask for=20
a properly formatted version.

---

Discussed the "RFC changes to the auth-pam plugin" patch:

<http://thread.gmane.org/gmane.network.openvpn.devel/9892>

Dazo had promised to review the patch in hackthon the upcoming Friday.=20
TimSmall will try to be mostly available that day for discussion.

---

Full chatlog has been attached to this email.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------030300090004000303030906
Content-Type: text/plain; charset=UTF-8;
	name="openvpn_irc_meeting_chatlog_2015-10-05.txt"
Content-Disposition: attachment;
	filename="openvpn_irc_meeting_chatlog_2015-10-05.txt"
Content-Transfer-Encoding: quoted-printable

(20:30:49) mattock: howdy
(20:31:09) lev__: good evening!
(20:31:17) mattock: good evening lev!
(20:32:08) lev__: it is -0.4=C2=B0C outside here
(20:32:39) mattock: oh, that cold already, here it is 5 degrees
(20:33:18) lev__: mattock1: you live way too south=20
(20:33:31) mattock: yes :)
(20:33:40) mattock: james just informed me that he'll be on plane today, =
so he won't make it
(20:33:47) mattock: I assume he's flying to Europe already
(20:33:58) syzzer: ah, probably yes
(20:34:06) syzzer: makes sense for such a long flight
(20:34:30) mattock: yep, and he likes to travel, so he probably wants a f=
ew days off the hackthon
(20:34:32) mattock: ok, let's see
(20:34:38) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
5-10-05
(20:34:40) vpnHelper: Title: Topics-2015-10-05 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(20:34:49) cron2: howdy!
(20:34:56) mattock: hi cron2!
(20:35:11) mattock: I have about 40 minutes of effective meeting time
(20:35:15) ***ecrist is here.
(20:35:18) mattock: hi ecrist!
(20:35:19) cron2: ok, so get your T-Shirts organized!
(20:35:31) mattock: no way, too late already :P
(20:35:31) syzzer: :')
(20:36:04) ***cron2 thinks mattock1 will need to sponsor one of the eveni=
ng's drinks then...!
(20:36:22) mattock: what if we cover "my topics" first? topic #5 for exam=
ple, and topic #1
(20:36:25) ecrist: I'll only be here another 15 minutes or so.
(20:36:26) cron2: anyway - mattock1: since you're time-constrained,=20
(20:36:28) mattock: cron2: we'll see
(20:36:33) cron2: yah, that's what I wanted to suggest :)
(20:36:35) cron2: go for it
(20:36:46) cron2: ok, wht about #1?
(20:36:57) mattock: let's do #5 first, it's small
(20:37:02) mattock: cloudflare on community.openvpn.net
(20:37:22) mattock: so raidz turned cloudflare on there, because there wa=
s a DoS there a few days back
(20:37:37) ecrist: yes.
(20:37:38) mattock: how opposed to CloudFlare + SSL are we?
(20:37:47) mattock: shall I ask him to turn cloudflare caching off?
(20:37:49) cron2: how easy is it to turn it on and off?
(20:37:56) mattock: not sure, but it's probably quite doable
(20:38:04) syzzer: I guess they have the pubkey now anyway?
(20:38:10) syzzer: uh, private key ofc
(20:38:16) ecrist: private key, yeah, I'm sure.
(20:38:31) mattock: yes, and I believe they've had the key from other ser=
vers
(20:38:49) mattock: because we've used CloudFlare + SSL elsewhere, and th=
e cert is *.openvpn.net
(20:38:50) syzzer: then I don't see much reason to turn it off
(20:39:11) mattock: ok
(20:39:15) ecrist: I think we should leave it on.
(20:39:22) ***cron2 has no strong issues with that - as far as I know the=
 SSL is "just because it is good style" not because there is anything par=
ticularily secret
(20:39:26) mattock: good, makes things simpler then, and even may protect=
 us
(20:39:27) ecrist: mattock1: you and I will need to figure out the SSH th=
ing so we can still manage it OK
(20:39:37) syzzer: (but I'm the crypto guy, who considers everything as l=
ost when your key is no longer secret ;) )
(20:39:40) cron2: it seems to make IPv6 more robust than on EC2
(20:39:42) mattock: ecrist: can you access community via IPv6?
(20:40:04) mattock: syzzer: that game over for sure :P
(20:40:06) ecrist: you mean http or ssh?
(20:40:08) mattock: ssh
(20:40:16) mattock: I mean ssh via ipv6 is doable
(20:40:18) mattock: I tested it
(20:40:24) cron2: oh, v6 goes totally elsewhere
(20:40:35) ecrist: oh, I'm fine with that
(20:40:53) mattock: ecirst: I'll turn it on in sshd_config then
(20:41:08) mattock: topic #1?
(20:41:17) mattock: "Plan Delft hackathon"
(20:41:27) cron2: specifics?
(20:41:43) ***cron2 and simone will be there!  (some time friday-after-no=
onish)
(20:42:06) syzzer: yes.  so for the bikes you'll have to decide if you wa=
nt to travel from the station to the hotel by bike, or prefer bus/taxi at=
 than point
(20:42:09) cron2: KL1794 arrive 13:20 in AMS
(20:42:28) cron2: oh, directions :)
(20:43:02) mattock: oh yes, my fiancee will also be there, at least for e=
vening dinner(s) and such
(20:43:23) cron2: as far as I understand, dazo's wife is also coming
(20:43:30) mattock: so many wives
(20:43:39) mattock: we may need a for-loop
(20:43:40) ecrist: if I was going, I'd probably bring mine
(20:43:41) cron2: syzzer: could you put instructions "how to get there?" =
on the wiki page?
(20:43:47) mattock: +1
(20:43:49) syzzer: bike routes (~10 min): NL40 INGB 0662 6024 20
(20:43:59) cron2: what is that?
(20:44:01) syzzer: aargh, so that is the account number of the notary :')
(20:44:05) cron2: haha :)
(20:44:08) mattock: good to know
(20:44:08) syzzer: https://www.google.nl/maps/dir/Delft,+Van+Leeuwenhoeks=
ingel+42A,+2611+AC+Delft/WestCord+Hotel+Delft,+Olof+Palmestraat,+Delft/@5=
2.010419,4.3585806,15z/data=3D!3m2!4b1!5s0x47c5b5c0c25b354b:0x93ba42de4fd=
604fc!4m14!4m13!1m5!1m1!1s0x47c5b5c0c28ca02f:0xc098eaf8cccc90d7!2m2!1d4.3=
565297!2d52.007545!1m5!1m1!1s0x47c5b5f13b7c9c69:0x1d6d450585fd0a7c!2m2!1d=
4.3809835!2d52.010918!3e1
(20:44:11) syzzer: there we go
(20:44:17) krzee: lol @ forloop for wives
(20:44:38) krzee: </lurk>
(20:44:43) cron2: that is delft centraal?
(20:44:53) syzzer: yes
(20:45:12) mattock: 2.7km is a walking distance for me :)
(20:45:20) syzzer: that's fine too ofc.
(20:45:37) cron2: cycling sounds like more fun
(20:45:42) mattock: so how will the bike thing work?
(20:45:46) mattock: where do we get them etc?
(20:45:54) syzzer: by foot you should definitely take the north route sug=
gestion from google
(20:46:24) syzzer: well, I have a few spare bikes which I can place at ar=
bitrary locations beforehand
(20:46:41) syzzer: and we'll get some cheap rental bikes at the train sta=
tion
(20:46:52) syzzer: so who gets which bike depends on what you prefer :)
(20:47:07) lev__: syzzer: how difficult is to rent a bike there?
(20:47:32) syzzer: for me easy, for non-dutchies quite difficult...
(20:47:38) lev__: :(
(20:47:43) ***cron2 needs clear instructions :)
(20:47:57) cron2: lev__: I think syzzer intends to organize the bike-thin=
gie
(20:48:06) syzzer: yes, I'll make sure everythings clear before you arriv=
e :)
(20:48:10) mattock: yeah, that would much appreciated
(20:48:16) cron2: +1
(20:48:29) mattock: btw. are there many hoops we have to jump through to =
get to the Fox-IT office?
(20:48:30) lev__: I'll be at Delft on Thu evening
(20:48:33) mattock: like full-body search etc?
(20:48:36) syzzer: just make sure to let me know at what time you'll be a=
t Delft Central
(20:48:47) krzee: body cavity search
(20:48:49) syzzer: just bring your passport
(20:48:52) cron2: syzzer: Fri ~14:00 I'd say (13:20 landing, from AMS)
(20:48:53) krzee: cough twice please
(20:49:11) cron2: reminder to self: need to find my train card...
(20:49:27) mattock: I will probably arrive around the same time as cron2
(20:49:53) syzzer: mattock1: that would be great, because then we can arr=
ange your bikes together
(20:50:03) cron2: mattock1: which flight, to where?  I halfway know my wa=
y around AMS and the (new) railway ticket system
(20:50:12) cron2: so we could pick you up there
(20:50:41) syzzer: ^^ and that is very useful (don't worry, I'll send ins=
tructions for others too)
(20:50:44) mattock: I'll actually arrive to Amsterdam rather late on Thu,=
 so I (=3Dwe) decided to stay there for the first night, then head to Del=
ft the next morning
(20:51:30) cron2: syzzer: I was in AMS in spring, and found they had chan=
ged all of the system compared to my last visit ~3 years ago :-) - but th=
e new system is quite nice
(20:51:31) lev__: I'll be at 17.45 at AMS (with mattock1 I presume) then =
going to Delft
(20:51:48) mattock: lev__: yeah, we have the same flight
(20:52:26) cron2: mattock1: are you staying in central AMS, or close to t=
he airport?  (Which is not *that* interesting)
(20:52:37) mattock: Central Amsterdam
(20:52:50) mattock: definitely more fun there
(20:53:06) cron2: well... in that case, we can just aim for synchronized =
arrival in Delft, but no good meeting at AMS airport
(20:53:07) syzzer: lev__: ok, I'll be at the train station to get you a b=
ike.  Or do you prefer taking the bus/taxi?
(20:53:18) mattock: cron2: sounds good
(20:53:26) TimSmall [~tim@...2071...] =C3=A8 entrato nella stanza=
.
(20:53:41) lev__: syzzer: bike would be great
(20:54:53) syzzer: lev__: ok, just give me a heads-up on mail/whatsapp/te=
legram/textsecure when you have an ETA for the train.  The airport and al=
l trains should have free wifi.
(20:55:13) lev__: syzzer: ack
(20:55:19) mattock: syzzer: ok
(20:56:09) mattock: what else there is to plan...
(20:56:12) mattock: bikes, check
(20:56:17) mattock: arrivals, check
(20:56:27) cron2: ok, mattock+cron2+2 =3D 4 @ fri 14:00
(20:56:28) syzzer: so, apart from transportation, we have now two volunte=
ers for talks: me+joachim (colleague) on post-quantum crypto and cron2+pl=
ai on funky roaming stuff (iirc)
(20:57:15) mattock: cron2: might be mattock+cron2+1 if my fiancee gets to=
o excited about AMS :)
(20:57:28) mattock: syzzer: sounds nice!
(20:57:35) mattock: especially the "funky roaming stuff" :D
(20:57:39) cron2: tell her Delft is also very nice and "more wifes will b=
e stranded there"
(20:57:51) cron2: check: OV-chipkaart found!
(20:58:00) mattock: cron2: I've told that to her, explaining that a city =
does not have to be large to be interesting
(20:58:06) syzzer: and cron2 volunteered to sponsor dinner on Sat. No vol=
unteers for Fri yet.
(20:58:06) mattock: :P
(20:58:23) mattock: we can probably squeeze that out of OpenVPN Tech, but=
 no promises yet
(20:58:34) mattock: Friday I mean
(20:58:38) syzzer: ok :)
(20:59:06) syzzer: I'll take care of reservations already, we'll need to =
eat anyway :)
(20:59:13) cron2: +1
(20:59:39) syzzer: so, any other loose ends?
(21:00:27) cron2: you've put "put map and instructions in the wiki" on yo=
ur TODO list? ;-)
(21:00:34) syzzer: yes
(21:00:55) cron2: then I think we're covered... any particular code words=
 to mutter to the reception desk at FoxIT?
(21:01:14) syzzer: "need coffee"
(21:01:23) syzzer: any my name helps
(21:01:25) syzzer: *and
(21:01:53) cron2: "can't remember why I'm here, but maybe you have some c=
offee?"
(21:01:53) krzee: front desk is going to crack up when the 5th person get=
s there and says "need coffee"
(21:02:27) syzzer: krzee: yes, that will be fun :p
(21:03:22) mattock: syzzer: how do we pronounce your name correctly, so t=
hat the clerks at the front desk understand what we're trying to say? :P
(21:04:06) syzzer: I should send you a recording to practice :')
(21:04:09) mattock: no strange sounds we need to know about in "Karger"?
(21:04:11) mattock: :P
(21:04:39) mattock: anyways, maybe the next topic then? I have to go to p=
owersave mode soon
(21:04:50) mattock: I'll try to keep track of the meeting, but don't expe=
ct timely responses
(21:04:52) syzzer: it's a German name, so actually many of you will prono=
unce it better than my colleagues do...
(21:04:53) krzee: they'll probably know based on your wanting coffee
(21:05:16) mattock: krzee: yep
(21:05:24) syzzer: but yes, next topic :)
(21:05:36) mattock: I suggest #4 "Windows environment" now that lev is he=
re
(21:06:36) lev__: yeah I updated VS project files (added comp/compstub) a=
nd added workaround for __attribute__
(21:06:56) lev__: cron2: haven't tried yet your patch
(21:08:00) cron2: lev__: so what does "version 12" do?
(21:08:02) mattock_ [~mattock@...1423.../corp/admin/mattock] =C3=A8 entrato =
nella stanza.
(21:08:02) modalit=C3=A0 (+o mattock_) da ChanServ
(21:08:07) lev__: "tools version changed to 12" - otherwise VS complains =
about wrong tools version
(21:08:20) lev__: command line builder
(21:08:53) ***cron2 assumes lev__ knows what he's talking about :-)
(21:08:55) lev__: when you open project in IDE it offers to update projec=
t files automatically
(21:09:10) cron2: but having feedback about 10085 on MSVC would definitel=
y be a good thing
(21:10:09) lev__: with that patch and some changes to openvpn-build it co=
mpiles nicely in VS2013
(21:10:50) lev__: I'll send pull request later to openvpn-build, now it i=
s kinda perl hack
(21:12:17) lev__: if someone has Win box with VS one could try that patch=
 and I can provide another patch to openvpn-build
(21:12:49) syzzer: I know plai used to have one
(21:12:50) cron2: the patch so far looks pretty harmless, I was just conf=
used about the tool version change
(21:13:01) syzzer: I have never tried getting MSVC to work
(21:13:35) cron2: my first patch set was built with msys/mingw on winxp, =
but cross-building is so much more convenient for a unix person like me
(21:15:20) lev__: VC also generates PDB which makes analyzing crash dumps=
 easier
(21:15:58) lev__: not that it crashes often, thought
(21:16:18) cron2: he, I was about to say that :-) "we don't do crashes, w=
e do surprising error messages!"
(21:16:35) syzzer: but I have to admit, that can be very useful
(21:16:46) cron2: anyway, I'll ACK+merge that (since it won't affect othe=
r environments anyway, this is a fairly safe bet)
(21:17:16) cron2: shall we return to the top, #2?
(21:17:35) syzzer: lev__: since you've now automatically become the VS gu=
ru here, do you know if MSVC does C99 by now?
(21:18:04) ***syzzer would like to drop some of the fugly constructions w=
e have to maintain because of MSVC
(21:18:05) lev__: syzzer: don't know
(21:18:24) syzzer: ah, too bad
(21:18:49) cron2: James might know
(21:19:08) cron2: though I wonder how he's building these days... as he's=
 using a Macbook :)
(21:19:14) syzzer: we'll see coming weekend :)
(21:19:26) lev__: fugly constructions - do you mean defining variables at=
 the top of function
(21:20:00) syzzer: for example
(21:20:26) syzzer: but I recently ran into more, but I can't recall now w=
hat it was...
(21:20:45) cron2: just look through our commit logs :)
(21:21:36) syzzer: is there more windows stuff to discuss?
(21:21:43) cron2: iservice...
(21:21:50) cron2: and trac#605
(21:21:53) cron2: and gui
(21:21:59) syzzer: ah, plenty!
(21:22:44) syzzer: I think mattock1 has the gui think covered
(21:23:12) cron2: nah, the question was "which gui do we want to ship in =
the future?"
(21:23:41) cron2: valdikss brought up the point that there is a number of=
 different GUIs for windows, open source, and more actively maintained, a=
nd supposedly "more featureful and stable"
(21:24:19) krzee: would it be possible to let the user select at install =
time or do things need to be compiled together??
(21:24:45) cron2: krzee: there is madness
(21:25:23) cron2: it's enough work to do the release building and testing=
 for *one* combination of openvpn+gui and 143 different windows versions
(21:25:26) syzzer: people will bug us about what we bundle, so I think we=
 should pick one
(21:26:12) cron2: yes :)
(21:26:35) cron2: we use the one we use because d12fk was/is maintaining =
it, so communication was quick and direct
(21:27:00) cron2: but not much has happened on the GUI side in 2 years, a=
nd if the others have really made such big improvements...
(21:27:28) syzzer: still, probably none of them do iserver-like stuff?
(21:27:28) cron2: (it's a bit of a pity that valdikss is not here, he wan=
ted to come - and he can point us at stuff to test)
(21:27:52) cron2: syzzer: I'd expect none of them to require manual activ=
ation of "run this as administrator"...
(21:27:53) syzzer: maybe we can get valdikss to make some kind of shortli=
st, so we can take a stab at them
(21:28:19) cron2: +1
(21:28:20) cron2: next :)
(21:28:23) krzee: do we have it so those with other guis can easily bundl=
e in our latest official release with our signed tap drivers?
(21:28:43) krzee: if so we can probably just link to their projects for t=
hose who want other guis
(21:28:58) cron2: krzee: sure they can, the tap driver is available for d=
ownload - but we don't really care about "what other people do".  We need=
 to decide what *we* do :-)
(21:29:51) mattock_ ha abbandonato la stanza (quit: Ping timeout: 252 sec=
onds).
(21:30:25) krzee: sounds like leaving it alone and linking to projects wi=
th better guis is an option then
(21:30:33) cron2: sure
(21:30:37) cron2: as is "do not ship any gui"
(21:30:41) cron2: as is "ship something else"
(21:30:47) cron2: as is "do not provide windows installers at all"
(21:30:50) cron2: lots of options
(21:31:15) cron2: this is not really the question, whether we have option=
s :-)
(21:31:33) mattock_ [~mattock@...1423.../corp/admin/mattock] =C3=A8 entrato =
nella stanza.
(21:31:33) modalit=C3=A0 (+o mattock_) da ChanServ
(21:31:53) syzzer: whee, back at 3 mattocks :)
(21:32:01) cron2: but actually I think these topics need mattock's attent=
ion... "he's the one to take the blame, and do the work" :)
(21:32:25) syzzer: anyway, I can't say anything without getting some poin=
ters first
(21:32:43) syzzer: so, postpone for now, see if mattock can get a shortli=
st?
(21:32:51) cron2: yeah, this is why "20:28 <@cron2> next :)"
(21:33:07) krzee: +1
(21:33:29) syzzer: good. iservice?
(21:33:35) cron2: syzzer: any news on that?
(21:33:41) syzzer: I did not get around to testing further yet
(21:34:01) mattock_: Sure, I can do a GUI review
(21:34:37) syzzer: ah, nice
(21:34:50) mattock_: d12fk has been quite absent lately, so a more active=
ly maintained gui wiuld be nice
(21:34:51) cron2: mattock_: get valdikss to do the shortlist for you - he=
 brought up the topic, and since he's running a VPN service, he knows wha=
t the users are using
(21:35:10) mattock_: cron2: sounds good
(21:35:26) cron2: trac#605 - mattock_: any news from the OpenVPN tech sid=
e on WIn10 and DNS?
(21:36:13) mattock_: and 2.4 "change and break everything" is the right p=
lace for the new gui
(21:36:19) mattock_: no news
(21:38:34) cron2: have you seen what valdikss did there?  He found the "w=
indows userspace firewall framework" and built a plugin for openvpn that =
will just kill DNS on all non-tap interfaces... I think it's twistedly ge=
nious, but I'm not sure we really want to integrate that, or hope for MS =
to fix their insanities
(21:40:20) syzzer: oh, wow, I hadn't seen that yet. as long as it's a plu=
gin, we might even want to ship it until MS fixes the real problem
(21:42:30) cron2: yeah, but I can see he does not want to have it as a pl=
ugin, as you can't enabled that in "here's your config, it will work on e=
very platform!" service contexts
(21:42:41) cron2: (and --plugin is not pushable, for funny reasons)
(21:43:05) syzzer: hmm, valid point
(21:44:17) syzzer: it's not even that much code
(21:45:00) syzzer: somehow I don't really expect MS to fix the problem
(21:48:29) cron2: as the code is isolated, I can see us shoving it into w=
in32.c and just have "the enable flag option" and the function call in "t=
he rest of the code"
(21:49:26) syzzer: yes, I think I could live with that
(21:50:55) cron2: let's bounce it off James on the weekend (maybe he has =
other insights), and then give it a try... I have a working cross-build e=
nvironment \o/ so I can test... don't have Win10, but maybe my Win7 VM au=
to-updates itself
(21:51:35) syzzer: I do have a 8.1 VM, but I don't have the guts to upgra=
de to 10 yet
(21:51:59) cron2: I'd just clone the VM, and let one of the clones update=
 itself...
(21:52:44) cron2: (as a side track: regarding #601 - checking one's own c=
ert for expiry and warning would even be totally useful on the client - I=
 forgot about all these user calls "my VPN is not working" that are due t=
o "well, yes, your cert has expired...")
(21:53:10) syzzer: yes, totally agree
(21:54:03) syzzer: but I noticed there's too much stuff in the queue alre=
ady, so I'm dropping new requests ;)
(21:54:50) krzee: +1 for a message in the client when expired
(21:54:57) syzzer: so I'm looking at the init patch now:
(21:54:58) syzzer: http://thread.gmane.org/gmane.network.openvpn.devel/10=
061
(21:55:00) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:55:22) krzee: i ran an expired one 2 days ago and in verb 5 all i saw=
 was the wrwrwrwrwr changed to wwwww
(21:55:41) krzee: i looked over certinfo and it was obvious to me, but on=
ly after i looked
(21:56:16) krzee: (i didnt control the server)
(21:58:08) syzzer: yes, I can see how that is not user-friendly at all
(22:06:34) mattock_ ha abbandonato la stanza (quit: Ping timeout: 260 sec=
onds).
(22:07:07) mattock_ [~mattock@...1423.../corp/admin/mattock] =C3=A8 entrato =
nella stanza.
(22:07:07) modalit=C3=A0 (+o mattock_) da ChanServ
(22:13:09) ValdikSS [~valdikss@...2072...] =C3=A8 entrato nella stanz=
a.
(22:14:26) syzzer: cron2: still around?
(22:15:08) cron2: yep
(22:15:47) syzzer: as far as I can tell the init patch looks fine
(22:15:58) syzzer: also passes basic manual tests
(22:16:09) cron2: good :)
(22:16:42) syzzer: through you'll probably need to get a bit creative wit=
h merging commit msgs, etc
(22:17:44) cron2: which version did you test?
(22:18:34) syzzer: oh wait - there's even more in this thread
(22:18:39) syzzer: v2, I think
(22:18:55) syzzer: this one: http://article.gmane.org/gmane.network.openv=
pn.devel/10063
(22:18:56) vpnHelper: Title: Gmane -- Re: PATCH Privileges not being drop=
ped if the first connection is not successful (at article.gmane.org)
(22:20:53) syzzer: v3 looks good too
(22:21:37) syzzer: can you try if the patches apply for you? I need to do=
 quite some manual mangling...
(22:22:02) cron2: if we agree on which one to ACK, I'd ask Lukas to rebas=
e and git-send-email...
(22:22:05) syzzer: but since I had exactly the same thing with jjk's patc=
h, I'm now thinking it might be my porblem
(22:22:16) syzzer: I prefer the last one
(22:22:40) cron2: well, the last patch I reviewed from jjk was totally ma=
ngled, so that wasn't just you :-)
(22:22:44) cron2: lemme see
(22:23:16) cron2: v3 is http://article.gmane.org/gmane.network.openvpn.de=
vel/10079 right?
(22:23:18) vpnHelper: Title: Gmane -- Re: PATCH Privileges not being drop=
ped if the first connection is not successful (at article.gmane.org)
(22:23:30) syzzer: yes
(22:23:53) cron2: Applying: Privileges not being dropped if the first con=
nection is not successful
(22:23:56) cron2: fatal: corrupt patch at line 11
(22:24:39) syzzer: ah, 'good'.
(22:25:15) cron2: nah
(22:25:30) cron2: even saving the "inner" e-mail and then doing "git appl=
y" will make it bomb, in different ways
(22:25:58) syzzer: yes, the line wrapping is totally screwed up
(22:26:08) cron2: git send-email for the win
(22:26:11) syzzer: probably copy-pasted the patch in an email
(22:26:46) ValdikSS: Hi guys. Sorry I'm a bit sick and will go sleep now,=
 but I'll be here and will read the history as soon as I wake up.
(22:28:07) syzzer: good night and get well :)
(22:28:11) cron2: ValdikSS: get well.  We decided that we don't decide an=
ything today, but would ask you to send a "shortlist" of interesting alte=
rnative GUIs so we can take a better look
(22:38:43) syzzer: so, should I ask to git-send-email, or will you?
(22:39:40) cron2: you :)
(22:39:45) cron2: (since you reviewed)
(22:44:07) syzzer: so, what's next? or do we call it a day?
(22:46:13) cron2: nah :)
(22:46:36) cron2: let's run quickly from the top
(22:47:06) cron2: 1. is covered, 2. won't be solved in time :( , 3. Rafae=
l Gava -> waiting for v2 patch, Tim Small -> waiting for Dazo (sorry, but=
 let's hope for the weekend)
(22:47:07) syzzer: you're suggesting t-shirts again? :p
(22:47:35) syzzer: ok, next are your patches
(22:48:03) cron2: on my two open patches, I want to suggest applying late=
-ack rules, given that the patch set has been tested with both cross-buil=
d systems *and* is windows-only *and* needs exposure to users...
(22:48:03) syzzer: I did not look into get_default_gateway_ipv6() or the =
follow-up
(22:48:08) TimSmall: If the review is planned during your conference, any=
 particular time I should be available for feedback?
(22:48:29) cron2: the followup is "make configure.ac work for newer mingw=
", it is not pretty but works
(22:48:53) cron2: TimSmall: Dazo said he'd work on it "Friday Morning" - =
dunno which particular time "Morning" is, but I'd assume "10am-ish"
(22:49:16) syzzer: TimSmall: no, not really. We'll be having the meeting =
in UTC+2, probably about 9:30-18:00. other than that, I wouldn't nkow
(22:49:26) syzzer: ah, cron2 knows more
(22:49:29) cron2: syzzer: take a quick look, the code is actually quite t=
rivial - no crypto, no buffers
(22:49:45) cron2: syzzer: dazo said something along that lines while you =
were on vacation ("and then disappeared")
(22:52:24) TimSmall: I think it could stand some review tho' - the curren=
t code is a bit tortuous (hopefully my changes are a move in the right di=
rection), so there maybe bugs lurking.  Breaking password auth would obvi=
ously be bad (especially for some failure modes!).
(22:53:05) TimSmall: Fri 9th Oct?
(22:54:16) syzzer: TimSmall: yes
(22:55:39) syzzer: cron2: those commented-out #ifdefs won't break stuff?
(22:56:21) TimSmall: OK, I'll try and be mostly available.  Here and/or o=
n email I assume?  Can do WebRTC / Google Plus / mumble or whatever too i=
f that's useful...
(22:58:07) cron2: syzzer: this is what I hoped lev__ would test
(22:58:07) syzzer: TimSmall: here and email is fine :)
(22:58:29) syzzer: cron2: ah, ok. other than that the patch 'looks good'.=
 just staring at code though.
(22:58:30) cron2: it's broken in mingw header files (this typedef is refe=
renced but not declared anywhere) and it isn't harming cygwin either
(22:58:35) syzzer: I think lazy-ACK applies
(22:58:41) TimSmall: syzzer: OK, thanks.
(22:59:11) cron2: changing the WINNT level to VISTA blew things up in int=
eresting ways...
(22:59:40) cron2: good :-) - next: redirect-gateway ipv6: patch is not th=
ere yet, nothing to review (had do do tax paperwork instead today)
(23:00:00) cron2: next: this Karger guy was planning some AEAD work... ha=
s anyone seen him recently? ;-)
(23:00:28) syzzer: hehe, I haven't seen the guy working on AEAD :p
(23:00:59) syzzer: I dug up and rebased the code recently, but did not fi=
nd a few consecutive hours to dive in again yet
(23:01:26) syzzer: my polarssl error log improvement patches are still on=
 the list waiting for review though
(23:01:32) cron2: argh
(23:04:34) cron2: but with that, I think, we have done all we are going t=
o achieve today...  I'll get busy a few hours tomorrow
(23:06:32) syzzer: yes, my brains are getting toasted anyway
(23:06:50) syzzer: not a bad score :)
(23:07:05) syzzer: good night!
(23:07:22) cron2: good night!

--------------030300090004000303030906--

