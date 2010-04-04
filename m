Message-ID: <4BB83EC2.9040208@...515...>
Date: Sun, 04 Apr 2010 10:24:50 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080105090101020205040701"
Subject: [Openvpn-devel] Summary of the IRC meeting (1st Apr 2010)
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
--------------080105090101020205040701
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 1st March 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<http://www.secure-computing.net/wiki/index.php/OpenVPN/IRC_meetings/Topics=
-2010-04-01>

Next meeting next week, same place, same time. Your local meeting time
is easy to check from services such as

<http://www.timeanddate.com/worldclock>


SUMMARY

NOTE: the #openvpn-devel channel will be used instead of
#openvpn-discussion from now on.

Discussed possible ways deprecate warnings, especially those which can
be considered "educational", such as "you're using this option the wrong
way, please read the man-page". Currently these just cause unnecessary
clutter in logs for many users.

Discussed the possibility of adding a message ID to each log message and
using a clever message parser to allow muting of log messages
selectively using a command-line option. Another option would be to
create a special error class in errlevel.h that pertains to "educational
warnings" and then add a flag that turns them off.

Discussed internationalization / localization issues briefly and how to
do them properly.

Discussed the roadmap of OpenVPN 3.0 and 2.x series. Currently the goal
for 3.0 is to make OpenVPN a modular, general purpose user-space network
stack where VPN functionality is just one potential application. This
will involve at least the following:

 (a) rework the i/o layer into a real asynchronous, reactor-based,
     event-driven model
 (b) make fully protocol agnostic at both tunnel and transport level
 (c) capable of using different SSL implementations other than OpenSSL
 (d) do a better job of fully implementing IP functionality such as in
     the multicast realm.

This will require invasive changes to the current codebase, e.g. to
introduce real multithreading.

Agreed that the gap between 2.x series and 3.0 should be minimized by
implementing as much 3.0 functionality in 2.x series as possible.
Decided that this approach should be used when writing the new logger
implementation discussed above.

Decided to accept this patch into "testing":

* "Add compile time settings from ./configure information to --version"
* <http://thread.gmane.org/gmane.network.openvpn.devel/3410>

---

Full chatlog as an attachment


--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------080105090101020205040701
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-04-01.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-04-01.txt"

(20:56:04) jamesyonan [~jamesyona@...1320...] =EF=BF=BD=EF=BF=BD entrato ne=
l canale.
(21:00:12) mattock: cron2: "date -u" is your friend :)=20
(21:01:10) mattock: ok guys, are we ready already?
(21:01:19) jamesyonan: hi
(21:01:24) ***cron2 is here!  since ages!  :-)  Hello everybody!
(21:01:26) mattock: hi jamesyonan!
(21:01:31) mattock: hello cron2!
(21:01:46) mattock: topic list is available here: http://www.secure-computi=
ng.net/wiki/index.php/OpenVPN/IRC_meetings/Topics-2010-04-01
(21:01:47) vpnHelper: Title: OpenVPN/IRC meetings/Topics-2010-04-01 - Secur=
e Computing Wiki (at www.secure-computing.net)
(21:02:17) dazo_ [~dazo@...1339...] =EF=BF=BD=EF=BF=BD entrato nel canale.
(21:02:17) mattock: agi, are you there?
(21:02:17) modalit=EF=BF=BD=EF=BF=BD (+o dazo_) da ChanServ
(21:02:26) mattock: hi dazo!
(21:02:54) dazo_: Hi!
(21:03:16) dazo_: (Connection is fragile, but seems to be mostly okay)
(21:03:35) mattock: shall we start with the "community comments" section?
(21:03:45) cron2: ecrist: IPv6 to www.secure-computing.net is broken :(
(21:03:53) ecrist: my apologies
(21:03:55) mattock: I assume that originates from dazo
(21:04:07) ecrist: it's a firewall issue, and I'm locked out of the firewal=
l currently
(21:04:09) ecrist: (too lazy to go down the stairs)
(21:04:16) ***dazo_ finds the agenda
(21:04:22) mattock: http://www.secure-computing.net/wiki/index.php/OpenVPN/=
IRC_meetings/Topics-2010-04-01
(21:04:23) vpnHelper: Title: OpenVPN/IRC meetings/Topics-2010-04-01 - Secur=
e Computing Wiki (at www.secure-computing.net)
(21:04:26) cron2: ecrist: ouch, stupid firewall.  (It just means I have to =
wait for the socket timeout before I get the web page via v4 :) )
(21:05:05) dazo_: Yeah ... the intention here is to be able to "kill" annoy=
ing log messages which you are aware off
(21:05:17) mattock: dazo, we (or rather, James) touched that issue briefly =
last week
(21:05:43) dazo_: the issue is that f.ex. if you have --reneg-sec set to 1 =
hour, you often get the same warning in the logs every hour .... which is r=
ather annoying
(21:06:16) dazo_: mattock:  then I apologise for not having noticed that wh=
en I read the chat log last time
(21:06:33) ecrist: perhaps give the warning a msg id number
(21:06:54) ecrist: and in the config, you can have a -wmute id,id,id,id,id.=
..
(21:07:02) mattock: I assume this one is related to that: "(20:16:54) james=
yonan: re: warnings -- these are mostly to help people out.  For example in=
 pre-2.1 releases, we didn't have script-security.  Since the addition of s=
cript-security was not backwards compatible, the warning tells people immed=
iately why their old config doesn't work. "
(21:07:17) dazo_: ecrist:  yeah, something like that=20
(21:07:55) dazo_: mattock:  agreed ... I don't want to totally kill them of=
f by default, but you kill those messages you are aware of and don't need t=
o see anymore
(21:08:25) mattock: sound good, if the logger can easily support that
(21:09:03) dazo_: but you have f.ex. the warning on --tls-remote (iirc) ...=
. which tells you to read the man page so that you understand the concept .=
.. and it comes every hour ....
(21:09:43) dazo_: the whole logging infrastructure needs to be reworked som=
ewhat, to add a msg id number, as ecrist suggest ...
(21:10:24) ecrist: likely the changes would make for easier translations to=
 other laguages, as well
(21:10:27) dazo_: and then option.c needs to get a "clever" --mute-msg pars=
er ... so you can do, fex  --mute-msg 1-39,46,50-53
(21:10:44) jamesyonan: I agree that message IDs would probably be better th=
an the current message level system.
(21:10:46) dazo_: or something along that road
(21:11:44) mattock: are the error/warning messages hardcoded?
(21:11:57) dazo_: the advantage of today's solution though, is that you can=
 give more descriptive information to help narrowing down the issue ... so =
I'd probably think something which takes both "worlds"
(21:12:02) mattock: or do they refer to a variable, which is given a value =
somewhere else?
(21:12:18) dazo_: Some of them can be variable,  I believe
(21:12:59) mattock: if we want to translate error messages, it's best to ha=
ve all of them in separate file / files and in code refer to these variable=
s=20
(21:13:03) cron2: mattock: the messages can be combined-on-the-fly to print=
 complex messages
(21:13:22) cron2: like "insert actual client name in the middle of the mess=
age" and such
(21:13:47) mattock: cron2: yeah, that's common and works well in english
(21:14:47) mattock: however, building sentences from separate parts may cau=
se problems when translating
(21:15:00) mattock: due to different sentence structure of different langua=
ges
(21:15:05) cron2: yes.  for the "what is going on"-messages, this is quite =
common
(21:15:19) mattock: however, simple variables (like $host, $server) are not=
 that bad
(21:15:21) ecrist: I think prepending any message with the client name woul=
d be easy enough
(21:15:28) cron2: for the "this is a notice to help users understand things=
"-messages, these are mostly static
(21:15:31) ecrist: ID - CLIENT - MESSAGE
(21:16:07) cron2: ecrist: sure
(21:16:46) mattock: in general, it's best not to try to reuse too many of t=
he existing messages, e.g. by trying to combine separate translatable strin=
gs into one big string on the fly
(21:17:07) dazo_ ha abbandonato il canale (quit: Ping timeout: 258 seconds).
(21:17:22) mattock: anyways, I can help out with making the strings easily =
translatable
(21:18:01) ecrist: would be sensical, perhaps, to create a language file wi=
th an array of messages
(21:18:16) mattock: ecrist: agreed, and preferably in widely-used format
(21:18:39) mattock: something which the various advanced OSS translation to=
ols (e.g. OmegaT, KBabel) have built-in support
(21:18:51) ecrist: id =3D> [en] =3D> "message", [fr] =3D> "une message", [p=
k] =3D> "gibberish"; id2...
(21:19:27) mattock: I suggest a master file (english) and separate files fo=
r each language
(21:19:49) mattock: e.g. translations_en.txt, translations_fi.txt
(21:19:58) mattock: and autodetect the correct file to use on startup
(21:20:42) mattock: putting everything into one file creates big problems w=
hen translating with a proper tool, even if it works fine with a text editor
(21:21:10) mattock: maintenance of translations is pain without a proper to=
ol with a translation database (e.g. TMX)
(21:21:40) mattock: btw. how is internationalization handled in OpenVPN / O=
penVPN GUI currently?=20
(21:21:58) ecrist: just guessing, I don't think it is
(21:22:20) cron2: mattock: in OpenVPN: "not".  In the Gui: no idea.
(21:22:25) mattock: this is clearly something we could improve
(21:22:47) mattock: is there really a need to translate the non-GUI parts t=
o other languages?
(21:22:59) jamesyonan: I believe OpenVPN GUI supports some level of interna=
tionalization
(21:23:31) mattock: I think end-user facing parts should be localizable
(21:23:38) cron2: mattock: well, debug messages can be english just fine.  =
user informational messages could benefit from internationalizations, but t=
hat is LOTS of work
(21:23:46) waldner [~waldner@...1336.../waldner] =EF=BF=BD=EF=BF=BD entrato=
 nel canale.
(21:24:11) mattock: cron2: you mean like "you're using this option the wron=
g way, please rean the man-page"?
(21:24:16) mattock: "read"
(21:24:19) cron2: hat sort of stuff, yes
(21:25:03) mattock: I think the problem is that most of the instructions (e=
.g. man-pages, wiki pages etc.) are in english anyways
(21:25:37) mattock: so translating some messages could potentially confuse =
the users even more
(21:25:45) mattock: but that's just my opinion ;)
(21:25:58) cron2: well, you'd need to translate the man page and the wiki a=
s well...
(21:26:16) mattock: yep
(21:26:39) dazo_ [~dazo@...1340...] =EF=BF=BD=EF=BF=BD entrato nel canale.
(21:26:39) modalit=EF=BF=BD=EF=BF=BD (+o dazo_) da ChanServ
(21:26:46) mattock: I think having the most essential  documentation availa=
ble in non-english languages would make sense
(21:26:58) mattock: e.g. the man-page, quickstart etc.
(21:27:22) dazo_: (sorry ... crappy connection and then a phone and compute=
r which got confused and bluetooth stopped working ...)
(21:27:31) ***dazo_ will read transcript
(21:28:27) mattock: ... that would help people who's english is not especia=
lly good to get the basic idea
(21:29:11) mattock: anyways, I think we sidetracked a bit...
(21:30:31) mattock: so is the ability to mute warnings worth the effort?
(21:31:28) dazo_: I would say so ... one of my setups triggers logwatch war=
nings everyday, with "non-sense" from OpenVPN
(21:32:09) mattock: so how should it be implemented? I think that's where w=
e sidetracked
(21:32:51) jamesyonan: what if we create a special error class in errlevel.=
h that pertains to "educational warnings" and then add a flag that turns th=
em off?
(21:33:04) dazo_: I would recommend to go through all of the messages (whic=
h is quite a few) ... group them according to their "message" ... and see w=
hat can be generalised and not
(21:33:36) dazo_: what jamesyonan suggests, is in the same way of thinking =
... but probably quicker to implement
(21:34:19) mattock: if these educational warnings are the problem then jame=
syonan's suggestion makes sense to me
(21:34:36) mattock: if there's a need to mute other warnings then some othe=
r approach might be better
(21:35:41) dazo_: it depends on the perspective .... if we dare to think lo=
nger than just this release, like "next generation openvpn" ... then it cou=
ld make be good to solve this in a better and more general way for all mess=
ages
(21:36:04) dazo_: jamesyonan:  what is the roadmap for the next major relea=
se of openvpn?
(21:36:19) ***dazo_ knows it's been talked about better modularity, but tha=
t's basically all he knows
(21:36:27) jamesyonan: dazo: that's a fairly deep question
(21:37:02) mattock: and the community is the worst enemy of any roadmaps :)=
,,, people have tendency to fix issues before they even reach the roadmap
(21:37:13) jamesyonan: I would like to see a modular approach that turns Op=
enVPN into more or less a general purpose user-space network stack
(21:37:26) jamesyonan: where VPN functionality is just one potential applic=
ation
(21:37:27) dazo_: yeah, but ... it is relevant to if we should do the "quic=
k'n'dirty" now, or to write some code which is beneficial for the next-gen =
openvpn
(21:38:08) dazo_: jamesyonan:  sounds like you want to build a software rou=
ter in user-space :)
(21:39:01) dazo_: mattock:  yeah, fair comment ... but without a clear dire=
ction of where OpenVPN is headed, we're just wading the mud without getting=
 anywhere
(21:39:22) mattock: dazo: agreed, and I think the community should be invol=
ved in the roadmap design
(21:39:37) mattock: to avoid the problem I mentioned (as well as host of ot=
hers)
(21:39:38) dazo_: hence my question :)
(21:40:44) mattock: jamesyonan: what do you think about planning the roadma=
p for next releases with the community, e.g. in these meetings=20=20
(21:40:45) mattock: ?
(21:40:52) dazo_: jamesyonan:  do you have any roadmap ideas .... realistic=
 or unrealistic, brainstorm thoughts, whatever .... in a written form which=
 could be shared?
(21:40:58) jamesyonan: going more into the details: (a) rework the i/o laye=
r into a real asynchronous, reactor-based, event-driven model, (b) make ful=
ly protocol agnostic at both tunnel and transport level, (c) capable of usi=
ng different SSL implementations other than OpenSSL, (d) do a better job of=
 fully implementing IP functionality such as in the multicast realm.
(21:41:35) dazo_: mm
(21:42:00) mattock: jamesyonan: are those achievable without scrapping too =
much of the existing code?
(21:42:24) mattock: I mean doable in incremental fashion
(21:42:42) mattock: =3Dincrementally ;)
(21:43:05) jamesyonan: mattock: this would be OpenVPN 3.0 -- it would be a =
rewrite, however a lot of the existing code would be reworked into the new =
model
(21:43:46) dazo_: +1 ... that sounds sensible
(21:45:52) mattock: now, regarding the educational error messages... I don'=
t think those affect OpenVPN 3.0, but is there a benefit in doing something=
 fancier than what James suggested (EDUCATIONAL error message class)
(21:45:57) mattock: ?
(21:46:17) jamesyonan: I think it would make sense to document the roadmap =
for 3.0, however in the near future I think most of the emphasis is going t=
o be on incremental improvements to the 2.x base
(21:46:47) mattock: agreed
(21:46:53) dazo_: I would say that if we write a new logger module for the =
current openvpn, and put the modularity into consideration that code would =
be mostly usable in OpenVPN 3.0
(21:47:04) mattock: dazo: sounds good
(21:47:08) jamesyonan: agreed
(21:47:28) mattock: btw. are there not tens of logger modules for C? I mean=
 there are quite a few for Java (log4j, commons-logging etc.)
(21:47:40) mattock: does every C program have a custom logger?
(21:48:00) mattock: as you can see, my C-fu is very low :D
(21:48:28) dazo_: it's a fairly simple job to write a logger, and as it's n=
ot object oriented, you won't find too many of those projects=20
(21:48:41) mattock: dazo: ok
(21:49:10) dazo_: most implement something which suits their need ... it's =
usually code less than 2-300 lines of code, if it is an advanced one
(21:49:29) mattock: so can we agree that "we'd like to have one modular log=
ger, please"?
(21:49:32) jamesyonan: logging does tend to be reinvented for each C app --=
 the part that is more standardized is the low level stuff where the log in=
fo is pushed to syslog, a file, log rotation, etc.
(21:50:03) dazo_: mattock:  +1
(21:50:03) dazo_: exactly
(21:50:07) jamesyonan: the part of logging that pertains to message filteri=
ng and muting is not very standardized in C
(21:50:15) jamesyonan: +1
(21:50:30) mattock: is that something for the next release?
(21:50:32) dazo_: mattock:  I wouldn't mind poking into writing such a logg=
er .... my fear is my available time for it ...=20
(21:51:24) mattock: perhaps we should put this on the "Open tasks" list... =
and link it to the 2.x roadmap when it's available somewhere
(21:51:33) dazo_: +1
(21:51:54) jamesyonan: for log implementation, remember that speed is criti=
cal
(21:52:40) jamesyonan: you don't want to spend more than a few machine cycl=
es to check whether or not a log message should be written
(21:52:43) dazo_: jamesyonan:  yes ... what about to use some queueing to m=
emory, and have an own log-writer-thread?
(21:54:12) dazo_: jamesyonan:  and to have a deterministic speed, using as =
much of static messages as possible also tend to help
(21:54:46) dazo_: (at least within the queuing mechanism)
(21:55:17) jamesyonan: Once you know that a log message is to be written, y=
ou can spend many microseconds on it -- here efficiency is not so much a bi=
g deal.  But we don't want log messages that are not written to impact the =
performance of the code because many log emit calls are buried deep within =
tight loops.
(21:56:15) jamesyonan: another way of saying that is that running openvpn a=
t --verb 0 should be almost as fast as if all the logging calls were #ifdef=
ed out
(21:57:18) dazo_: ahh ... I see your point ... even though, would it be a w=
rong approach to try to put the log writing into a separate thread?  Just t=
o reduce the logging impact for the "core part" of OpenVPN  even more when =
it does happen?
(21:57:34) jamesyonan: right
(21:57:52) ecrist: that would be one step toward a multi-threaded openvpn. =
;)
(21:58:34) jamesyonan: so I don't think a logging thread is necessary yet -=
- but would be more appropriate once the rest of OpenVPN is multi-threaded
(21:58:37) dazo_: ecrist:  openvpn already got the possibility to do some S=
SL stuff in it's own thread as well  ;-)  but it must be enabled compile-ti=
me
(21:58:52) mattock: oh, no multithreading... I didn't know that
(21:59:12) jamesyonan: dazo: that capability doesn't exist in 2.x branch (b=
ut it did in 1.x)
(21:59:21) dazo_: mattock:  no, that's why openvpn don't scale well on SMP'=
s ... OpenVPN only runs on one CPU core
(21:59:39) mattock: that's pretty nasty limitation
(21:59:45) dazo_: jamesyonan:  what does the --enable-pthread do then?
(21:59:58) jamesyonan: usually people run multiple openvpn processes to sca=
le up on SMP
(22:00:26) mattock: what kind of changes are we talking about with real mul=
tithreading?
(22:00:44) dazo_: mattock:  big ones, that's a nasty big change
(22:00:46) jamesyonan: --enable-pthread is essentially a no-op in 2.x
(22:01:07) mattock: dazo: "scrap everything and rewrite"?
(22:01:14) dazo_: ahh ... I have been misinformed then ... thanks for strai=
ghten me up
(22:01:27) dazo_: mattock:  not that bad ... but close enough
(22:01:41) mattock: ok
(22:01:52) dazo_: mattock:  big parts of the whole events system needs to b=
e changed, which handles each connection
(22:02:31) jamesyonan: agreed that the event system ties in very closely wi=
th current limitations such as lack of multi-threading
(22:02:41) mattock: yeah, obviously that... if one thread is allocated to e=
ach connection
(22:03:18) jamesyonan: one thread per connection would not scale very well
(22:03:32) jamesyonan: it would be better to have n connections per thread
(22:03:32) mattock: jamesyonan: do you think real multithreading would be d=
oable in 2.x?
(22:04:44) cron2: this very much depends on the value of "real"
(22:04:47) ecrist: I think a change that big is appropriate for a full vers=
ion bump.
(22:05:07) jamesyonan: one possibility would be to redo the event system to=
 an asychronous, reactor-driven model -- this could potentially be done inc=
rementally for 2.x and would then open up multi-threading possibilities
(22:05:29) ecrist: maybe something such as pinning clients to specific core=
s could be done within ssl libs in 2.x, though?
(22:05:51) ***cron2 has toyed with the idea of offloading the "have packet,=
 encrypt, stuff to to-client socket" part in a separate thread
(22:06:12) cron2: that should gain quite some scalability without adding to=
o much complexity
(22:06:13) dazo_: I believe jamesyonan is the safest approach, and it will =
lead more up to the 3.0, where the code will then be tested well through 2.=
x releases
(22:07:08) mattock: I'd like to see as much of 3.0 as possible being in lat=
er 2.x releases... to have new code tested
(22:08:05) mattock: I mean tested like in real-life installations
(22:08:38) jamesyonan: would someone like to volunteer to evaluate C-based =
event-driven asynchronous i/o libraries?=20
(22:08:44) ***dazo_ has been toying with similar ideas ... one thread which=
 does all the read/writing the tun/tap device, and using similar ideas simi=
lar the linux kernel does with work queues in the network stack ... each wo=
rk queue is its own thread
(22:09:01) dazo_: jamesyonan:  you mean libraries like libevent?
(22:09:02) mattock: so we'd basically need to lay out the roadmap for 3.0, =
then check which parts of it can be implemented on 2.x - and implement them
(22:09:17) dazo_: mattock:  +1
(22:09:22) cron2: mattock: +1
(22:09:24) mattock: so that the gap between 2.x and 3.0 is not _that_ big
(22:09:58) ***dazo_ is arriving Prague soon ... need to go offline within 1=
0-15 min max
(22:10:23) jamesyonan: I don't know very much about libevent.  I've used Tw=
isted (in Python) and I find it to be an awesome framework, but I'm not sur=
e if anyone has done something similar in C.
(22:10:42) mattock: dazo: could you select the next issue? I think we can c=
ontinue the 2.x / 3.x discussion next week
(22:10:57) mattock: if you have something urgent in mind
(22:11:37) mattock: perhaps the ACK/NACK you spoke about?
(22:12:18) mattock: (in case dazo went offline involuntarily, this is what =
I mean)
(22:12:22) mattock: http://thread.gmane.org/gmane.network.openvpn.devel/3410
(22:12:22) dazo_: jamesyonan:  iirc, libevent is used by pgBouncer (a Postg=
reSQL "proxy") ... and does an amazing job there=20
(22:12:23) ***dazo_ would very much like to poke into this stuff ... but is=
 afraid of over-committing himself
(22:12:24) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(22:12:39) jamesyonan: dazo: are you in transit?
(22:12:51) dazo_: jamesyonan:  I'm on a train :)
(22:13:00) jamesyonan: cool
(22:13:03) cron2: there's the big patck from Fabian Knittel.  I have not ha=
d any time to look at it, but "will do real soon"
(22:13:07) cron2: patch
(22:13:19) ***dazo_ is going to have a look at that VLAN patch as well
(22:13:20) mattock: yep, Fabian's patchset is interesting
(22:13:48) mattock: what do you think about dazo's patch (above)? is is ACK?
(22:13:48) cron2: ... and I think it needs close review to make sure it doe=
sn't break anything
(22:13:52) dazo_: my patch is basically what was discussed some weeks ago, =
adding more "debug" info to the openvpn --version "screen" ...=20
(22:14:04) dazo_: cron2:  +1
(22:14:22) cron2: dazo_: I have seen that mail, but not actually read it ye=
t.  "soon"
(22:15:31) dazo_: cron2:  sounds good! :)
(22:16:10) mattock: should we end todays meeting now?
(22:16:15) mattock: before dazo drops out :)
(22:16:29) mattock: I think we discussed quite a few important issues alrea=
dy
(22:16:35) dazo_: please continue, if you want to :)  I'll read the transcr=
ipt anyway :)
(22:16:37) cron2: mattock: the debian ipv6 thing - I think we need agi for =
that, and he's not there, so "skip".  And the next one is "jjk not here, sk=
ip" :-)
(22:17:01) jamesyonan: configure patch looks fine
(22:17:08) cron2: mattock: can you put "provide windows installation packag=
e for openvpn-testing" on next week's agenda?
(22:17:18) mattock: cron2: do you have link to it?
(22:17:28) cron2: mattock: to what?
(22:17:37) mattock: to an email or something :)
(22:18:01) ***dazo_ needs to logout!
(22:18:06) mattock: bye dazo!
(22:18:10) cron2: mattock: no mail, just a suggestion from my side that we =
should discuss - "I think it would be useful to have windows binaries, and =
I can't provide them, but you could" :-)
(22:18:11) dazo_: Thanks alot for your patience with me today :)
(22:18:14) cron2: bye dazo
(22:18:17) dazo_: good job!
(22:18:18) mattock: cron2: ok, I will
(22:18:50) mattock: jamesyonan: have you already taken a look at Fabian's p=
atches?
(22:19:00) cron2: (my wife is calling me to dinner - 21:18 here - so I don'=
t want to discuss that today.  But next week I have more time :) )
(22:19:02) mattock: http://search.gmane.org/?query=3DVLAN+tagging&author=3D=
fabian.knittel%40avona.com&group=3Dgmane.network.openvpn.devel&sort=3Drelev=
ance&DEFAULTOP=3Dand&xP=3Dvlan%09Ztag&xFILTERS=3DGnetwork.openvpn.devel---A
(22:19:25) jamesyonan: mattock: only briefly
(22:19:36) mattock: I agree we should not discuss the VLAN patchset today, =
it's getting late (22:19) here
(22:19:47) mattock: ok
(22:20:15) cron2: ok, bye folks, see you on the list...
(22:20:20) mattock: bye cron2!
(22:20:24) jamesyonan: bye all
(22:20:36) mattock: bye! see you again!
(22:21:01) mattock: I'll probably write the summary late next evening (my t=
ime)
(22:21:10) mattock: or early saturday morning
(22:21:47) mattock: bye all

--------------080105090101020205040701--

