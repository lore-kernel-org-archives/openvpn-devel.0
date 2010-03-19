Message-ID: <4BA34355.5020300@...515...>
Date: Fri, 19 Mar 2010 11:26:45 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000302080905030703030500"
Subject: [Openvpn-devel] Summary of the IRC meeting (18th Mar 2010)
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
--------------000302080905030703030500
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-discussion on irc.freenode.net
Date: Thursday, 18th March 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<http://www.secure-computing.net/wiki/index.php/OpenVPN/IRC_meetings/Topics=
-2010-03-18>

Next meeting next week, same place, same time. Your local meeting time
is easy to check from services such as

<http://www.timeanddate.com/worldclock>


SUMMARY

Discussed an issue that came up earlier in the mailinglists:

 <http://thread.gmane.org/gmane.network.openvpn.user/29304>

Agreed that allowing two clients to connect with the same certificate
without "duplicate-cn" being set (as in "first one to connect wins")
would be harmful and hence unimplementable.

Discussed a potential bug with global config file defaults (e.g. nobind)
not propagating to <connection> blocks. Agreed that this bug is almost
certainly invalid and was triggered by misconfiguration. However, Jan
will check if the OpenVPN man-page requires clarifications in this area.

Discussed Linux TUN/TAP performance and Jan's EPOLL modification
designed to improve it:

 <http://thread.gmane.org/gmane.network.openvpn.devel/3261/>

Agreed that switching from POLL to EPOLL does not improve overall
performance enough to justify the change. Also agreed that no action
should be taken for now, as the TUN/TAP performance is good enough.

Discussed this SF.net bug report which was found to be fixed in SVN r3128:

<http://sourceforge.net/tracker/?func=3Ddetail&atid=3D454719&aid=3D2015672&=
group_id=3D48978>

Discussed potential problems with disfunctional proxy servers:

<http://sourceforge.net/tracker/?func=3Ddetail&atid=3D454722&aid=3D1840041&=
group_id=3D48978>

RFC2817 clearly states that proxies need to use this syntax:

 CONNECT host:port/

However, according to the bug report some proxy servers require invalid
syntax:

 CONNECT http://host:port/

Samuli will try to contact the original bug reporter and will do some
additional research. If no widely used proxy servers require this
invalid syntax, this bug report will be closed as wontfix.

Discussed a potential bug where CN gets mixed up with certificate name
occasionally after disconnecting. This messes up iptables rulesets and
status files:

http://article.gmane.org/gmane.network.openvpn.user/29181

Agreed that this may indeed be a bug. Decided to do more research:

- check what happens if disconnect happens before connection has reached
  ACTIVE state
- check if this occurs when session is renegotiated (each hour)

Jan volunteered to do the testing.

---

Full chatlog as an attachment


--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------000302080905030703030500
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-03-18.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-03-18.txt"

(20:00:00) janjust: evening all...
(20:00:04) reiffert: hi
(20:00:51) mattock: hi all
(20:00:54) janjust: right room this time ;-) ?
(20:00:59) mattock: yep ;)
(20:01:14) mattock: ok, so how many devs we have here today? cron2, jamesyo=
nan, who else?
(20:01:29) jamesyonan: hi everyone
(20:01:58) cron2: hi
(20:02:07) cron2: and janjust
(20:02:41) janjust: hehe yep, don't know what I am...developer, user, troub=
lemaker ...
(20:03:16) mattock: that remains to be seen :)
(20:04:00) janjust: I just grabbed the agenda ... is there a particular ord=
er ?
(20:04:25) mattock: given that dazo is not here to ACK things, I suggest we=
 cover the "possible bugs/issues" first (in http://www.secure-computing.net=
/wiki/index.php/OpenVPN/IRC_meetings/Topics-2010-03-18)
(20:04:26) vpnHelper: Title: OpenVPN/IRC meetings/Topics-2010-03-18 - Secur=
e Computing Wiki (at www.secure-computing.net)
(20:04:33) mattock: janjust's stuff :)
(20:05:09) mattock: what do you think?
(20:05:24) cron2: go ahead :)
(20:05:33) mattock: great!
(20:05:40) janjust: sounds fine to me - I actually have a minor addition ...
(20:05:57) mattock: shoot
(20:06:04) janjust: I mean, a feature request that came up on the users lis=
t a few days ago
(20:06:27) mattock: do you have link to the thread?
(20:06:28) janjust: when 2 persons have the same cert (either by accident o=
r by design) and the second person connects the first one is kicked out=20
(20:06:51) mattock: oh, that one
(20:06:53) janjust: where's the openvpn-users archive?
(20:07:32) janjust: but the question is: how can one avoid this? when you u=
se --server you automatically get --float , there's no way to do --nofloat
(20:07:46) janjust: and it seems to me that --float is causing the kick-beh=
aviour
(20:07:59) jamesyonan: janjust: you can use --duplicate-cn to allow multipl=
e users with the same cert to connect
(20:08:17) cron2: .oO(that was the option I was trying to remember :) )
(20:08:21) mattock: http://dir.gmane.org/gmane.network.openvpn.user
(20:08:23) vpnHelper: Title: Gmane -- Mail To News And Back Again (at dir.g=
mane.org)
(20:08:44) janjust: yep I know jamesyonan , but this person did not want th=
at ... I already told him that he should not give the same cert to multiple=
 people unless he was using duplicate-cn
(20:09:30) cron2: so what does he want, then?
(20:09:53) cron2: "I want to be able to connect multiple users with the sam=
e cert, but I do not want to tell the server that this is OK"?
(20:10:44) janjust: what he wanted was a way to give a certificate to 2 per=
sons but the first one who connects "wins"
(20:11:32) mattock: it's this one I guess: http://thread.gmane.org/gmane.ne=
twork.openvpn.user/29304
(20:11:33) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(20:12:08) janjust: yep I was still trying to find it : that's the one
(20:12:55) janjust: but my general thought on this one was: should --no-flo=
at be a valid option?
(20:12:55) jamesyonan: OpenVPN doesn't support "first one wins" behavior ri=
ght now -- that could be problematic because it could interfere with UDP re=
connects
(20:13:07) janjust: true=20
(20:13:26) jamesyonan: In many cases during a UDP reconnect, the server doe=
sn't really know that the previous session was disconnected yet
(20:13:54) cron2: ... and unless keepalive is used, it might never notice
(20:14:25) janjust: yeah , that's another thing I was thinking of today: a =
client never sends a 'signoff' or 'disconnect' message, does it?
(20:15:18) cron2: no
(20:15:25) d12fk [~quassel@...1333...] =EF=BF=BD=EF=BF=BD entrato nel canal=
e.
(20:15:27) jamesyonan: there's an "explicit-exit-notify" directive that doe=
s that
(20:15:36) d12fk: re
(20:15:45) janjust: great - thx jamesyonan , I already learned something fr=
om this meeting ;-)
(20:16:12) cron2: so did I - I have read the manpage, completely, and multi=
ple times, but missed this option :)
(20:16:27) janjust: alright, let's forget the --no-float for a second, I do=
n't think we'll come up with a solution
(20:16:43) janjust: the rest of the agenda: mattock asked me to go through =
the bugtracker
(20:16:47) mattock: yep
(20:17:08) janjust: which I did: I closed quite a few old bugs but actually=
 found a few interesting ones that are still around
(20:17:11) mattock: one more thing, so the previous "feature" can't be impl=
emented, right?
(20:17:14) mattock: in a clean way
(20:17:40) mattock: if so, I'll notify the author, pointing him to today's =
chatlog
(20:17:54) janjust: adding a --no-float option is a no-brainer but I would =
doubt that it solves the problem properly: he'd get all kinds of udp reconn=
ect problems
(20:18:08) mattock: ok, I'll let him know that
(20:18:35) mattock: can we proceed to the <connection> block problem?
(20:18:39) janjust: sure
(20:19:01) mattock: janjust, could you briefly describe the problem?
(20:19:06) janjust: yep
(20:19:35) janjust: when people use <connection> blocks they HAVE TO put th=
ings like nobind inside the block, otherwise they cannot have multiple open=
vpn instances running
(20:19:53) janjust: the reason is that each <connection> block is treated i=
n the code as a "connection entry"=20
(20:20:15) janjust: each connection entry has a few properties, including b=
ind/nobind, proxy, timeout and a few others
(20:20:48) janjust: if this is the designed behaviour then we need to docum=
ent in the manpage what can and/or needs to go into a <connection> block
(20:20:58) cron2: mmmh, defaults not propagating
(20:21:07) cron2: (defaults and "global" settings)
(20:21:07) janjust: defintely not cron2=20
(20:21:29) mattock: you mean defaults are not "inherited" (in object orient=
ed programming parlance)
(20:21:33) janjust: so the questions are: should there be "global" settings=
 which get propagated
(20:21:36) cron2: mattock: yes
(20:21:37) mattock: ok
(20:22:05) janjust: and the second question: is this the designed behaviour=
 of the connection blocks? then the man pages should be updated to reflect =
this
(20:24:00) mattock: is there any way to show which options are used for eac=
h connection profile?
(20:24:04) ***cron2 points to jamesyonan "he's da man who knows answers"
(20:24:05) mattock: and which are global defaults?
(20:24:32) janjust: the global defaults are the one which are set outside o=
f the <conn> blocks
(20:24:57) mattock: yep, but I assume OpenVPN has hardcoded defaults, too
(20:25:22) mattock: which can be overridden in global defaults or in connec=
tion blocks
(20:25:44) janjust: the hardcoded stuff is overridden properly (as far as I=
 know the code)
(20:25:55) janjust: it's the stuff outside of the <conn> blocks that is "fo=
rgotten"
(20:26:09) cron2: the manpage I have is fairly clear that this is not what =
was intended
(20:26:13) cron2: quote:
(20:26:23) cron2:  defaulting mechanism exists for specifying options to ap=
ply to
(20:26:28) cron2: all  <connection>  profiles.   If any of the above option=
s (with
(20:26:32) cron2: the exception of remote  )  appear  outside  of  a  <conn=
ection>
(20:26:38) cron2: block,  but  in a configuration file which has one or mor=
e <con-
(20:26:42) cron2: nection> blocks, the option setting will be used  as  a  =
default
(20:26:47) cron2: for  <connection>  blocks  which  follow it in the config=
uration
(20:26:52) cron2: file.
(20:27:01) cron2: -- end quote
(20:27:20) cron2: (after the example in the <connection> block of the man p=
age)
(20:27:26) janjust: ok so that makes it both a bug and a manpage issue ;-)
(20:27:53) cron2: For example, suppose the nobind option were placed in the=
 sample
(20:27:57) mattock: ok, so is this limited to nobind?
(20:27:57) cron2: configuration  file  above, near the top of the file, bef=
ore the
(20:28:02) cron2: first <connection> block.  The effect would be as if nobi=
nd were
(20:28:06) cron2: declared in all <connection> blocks below it.
(20:28:10) cron2: (quoting again)
(20:28:47) janjust: ah interesting detail: I don't remember if the person w=
ho asked the question had the nobind before or after the <conn> block
(20:29:08) mattock: ok, so it might just be in the wrong place...
(20:29:35) fjutscha ha abbandonato il canale (quit: Quit: Leaving).
(20:29:55) janjust: yeah I just read his original posting: it was BELOW the=
 conn block
(20:30:07) janjust: we'd have to test it with the statements in the right o=
rder
(20:30:08) mattock: problem solved? :)
(20:30:21) janjust: nope - the manpage might still need some updating
(20:30:35) cron2: janjust: does it?  I find it very clear
(20:30:57) janjust: cron2: I think I have to read *your* manpage more caref=
ully ....
(20:31:30) cron2: it's not my manpage, I just typed in "man openvpn" :-) - =
I didn't quote all of it, though, it has more details on what's allowed ins=
ide <connection> etc
(20:31:45) janjust: grin
(20:32:11) janjust: I'll read the 2.1 manpage more carefully and see if we =
need to add something regarding the <connection> blocks
(20:32:23) mattock: sounds good
(20:32:42) mattock: janjust, if there is something to be fixed, could you c=
reate a patch?
(20:33:26) janjust: yep will do
(20:33:29) mattock: great!
(20:33:34) mattock: on to the next one, shall we?
(20:33:38) cron2: ye
(20:33:42) mattock: which would be: http://thread.gmane.org/gmane.network.o=
penvpn.devel/3261/
(20:33:44) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(20:34:02) janjust: oh that one ;-)
(20:34:06) mattock: any progress on this one?
(20:34:19) janjust: not from my side - I asked if somebody had more tests t=
o try
(20:34:42) mattock: any ideas how to proceed with this, anyone?
(20:34:51) janjust: the thing that bugs me is that the performance is actua=
lly *better* when using POLL and when using EPOLL on a gigabit lan
(20:35:20) janjust: and the other thing which bugs me , of course, is that =
vtun is getting better performance than openvpn (both without encryption or=
 compression)
(20:35:44) janjust: and when -> than when
(20:36:14) mattock: and both use the tun module in kernel?
(20:36:19) cron2: how big is the difference between poll and epoll?
(20:36:22) mattock: the same interface I mean?
(20:36:25) mattock: vtun and openvpn
(20:36:28) janjust: yep, that's why I choose vtun
(20:36:30) ***cron2 could imagine that for "just 2 file descriptors", poll =
has less overhead
(20:36:40) janjust: both were using tun0 on both ends
(20:37:18) janjust: I agree cron2  ... but the 'perf report' showed that my=
 laptop was spending quite some time in read_hpet with poll; that time was =
gone when using epoll
(20:37:51) d12fk: epoll is the fastest on linux
(20:38:36) janjust: and the perf diff was ~ 32 MB/s using POLL vs ~24 MB/s =
using EPOLL
(20:38:48) janjust: (and vtun was getting ~ 41 MB/s ...)
(20:39:23) d12fk: poll faster than epoll?
(20:39:33) janjust: yep d12fk , for my tests it was
(20:39:44) cron2: ok, let me guess.  I'd assume that the CPU was not satura=
ted on either end
(20:40:01) janjust: no encryption, no compression on 8 core machines ....
(20:40:01) cron2: i that case, TCP performance is usually dominated by late=
ncy
(20:40:45) cron2: so I'd suspect "number of system calls involved =3D laten=
cy"
(20:41:13) jamesyonan: it wouldn't surprise me if epoll has more initial se=
tup inefficiency than poll
(20:41:22) janjust: BTW: the 2 centos5 hosts on the gigabit lan are connect=
ed to the same switch
(20:41:40) janjust: jamesyonan: true but I was transferring 512 MB files=20
(20:42:21) mattock: has anybody tested this on latest kernel?
(20:42:34) janjust: or actually I was using 'dd if 512MB | nc -l 21000' on =
one end and 'nc host 21000 > /dev/null' at the other end
(20:44:18) janjust: my laptop tests (100Mbps lan, no gigabit on board) were=
 with fc12 2.6.32
(20:44:34) janjust: I can't upgrade the centos5 boxes that easily to that k=
ernel :-(
(20:44:48) mattock: janjust, true :)
(20:45:20) mattock: do you think this a kernel issue, or is something at op=
envpn also contributing to the problem?
(20:45:37) janjust: it's an interaction issue, I'm afraid...=20
(20:45:57) mattock: can we fix this at the openvpn end?
(20:46:06) mattock: or are we screwed? ;)
(20:46:15) janjust: there is definitely some kernel overhead (a "direct" tr=
ansfer gives a consistent 60 MB/s)
(20:46:20) jamesyonan: Re: openvpn vs. vtun performance differences, does v=
tun compute HMAC hash of each packet?=20
(20:46:37) janjust: I had --auth none --cipher none for my test, jamesyonan=
=20
(20:47:59) d12fk: janjust: what do you mean by "direct"? without openvpn?
(20:48:06) janjust: yes d12fk=20
(20:48:37) janjust: using socat I was even able to max out the gigabit lan =
using udp :)
(20:48:49) d12fk: this is becaue there's no tun involved then
(20:49:45) janjust: what can we do on the openvpn end? at best we can achie=
ve the same speeds as vtun
(20:49:59) janjust: but we'll always be faced with the overhead of the tun =
adapter
(20:50:14) janjust: however, getting 40 MB/s is still pretty good :) - we a=
re talking luxury problem, I'd say
(20:50:31) cron2: the tun will always add latency and extra syscalls, but o=
penvpn should be as good as vtun here, yes :-)
(20:50:42) d12fk: implement SSL in the kernel, but that would void the gene=
ral idea of a userspace solution
(20:50:53) mattock: janjust, is it possible to ha --tls-auth enabled with -=
-auth none and --cipher none?
(20:51:31) jamesyonan: janjust: did you use --fast-io on test (if UDP)
(20:52:02) janjust: yes jamesyonan , see my last posting on openvpn-devel o=
n this
(20:52:44) janjust: unpatched version: ~31 MB/s
(20:52:44) janjust: patched version : ~25 MB/s
(20:52:44) janjust: (BTW: with --fast-io: ~31 MB/s)=20
(20:53:11) janjust: so fast-io is about as fast as POLL, or so it seems
(20:53:48) janjust: if someone wants me to run more/other tests just let me=
 know ...=20
(20:54:49) mattock: can we agree that this is not critical issue?
(20:55:05) mattock: or even serious?
(20:55:12) janjust: fine with me , as long as we patch the poll vs epoll is=
sue
(20:55:41) janjust: new topic: regarding http://sourceforge.net/tracker/?fu=
nc=3Ddetail&atid=3D454719&aid=3D2015672&group_id=3D48978
(20:55:42) vpnHelper: Title: SourceForge.net: OpenVPN: Detail: 2015672 - bu=
ffer.{h,c} isn't defensively programmed (SECURITY?) (at sourceforge.net)
(20:56:06) jamesyonan: janjust: but isn't your test inconclusive about whet=
her the epoll patch really helps in all cases?
(20:56:25) mattock: btw. where's the epoll patch?
(20:56:33) janjust: jamesyonan: true=20
(20:56:46) janjust: mattock: there is no such thing yet, I simply removed a=
 bunch of lines from event.c :)
(20:56:51) mattock: oh :)
(20:57:01) janjust: but epoll should definitely help when many clients are =
connecting
(20:57:25) jamesyonan: yes, but the current unpatched code does use epoll
(20:57:55) mattock: janjust: you could create a patch so that it can be rev=
iewed by others
(20:57:57) janjust: does it? when why do I see all kinds of syscalls to pol=
l in my original prof-callgraph?
(20:57:57) jamesyonan: your fix only forces epoll for all uses, even when O=
penVPN would prefer to use poll (when small numbers of sockets are involved)
(20:58:35) janjust: ah so openvpn decides when to use poll vs epoll? what i=
s that decision based on (I'm learning here again ;-) )
(20:59:08) jamesyonan: yes, that's what the  EVENT_METHOD_FAST flag is about
(20:59:14) mattock: what kind of benefit are we talking about when POLL is =
used (for small number of sockets)?
(20:59:46) mattock: janjust's EPOLL modification apparently does provide si=
gnificant performance improvement (25MB vs. 31MB)
(20:59:49) janjust: mattock: on gigabit lans performance seems to be roughl=
y 20% better=20
(21:00:09) mattock: you mean with EPOLL, not POLL?
(21:00:14) janjust: nope that's the other way round: on gigabit lans POLL w=
orks 20% better then EPOLL
(21:00:18) mattock: ok
(21:00:20) mattock: :)
(21:00:41) janjust: jamesyonan: when is this EVENT_METHOD_FLAG set?
(21:00:42) jamesyonan: basically when OpenVPN want to poll on a small, fixe=
d number of sockets, it uses EVENT_METHOD_FAST.  When it is polling a poten=
tially a large number of sockets, it doesn't set the flag.
(21:00:47) d12fk: shatters my liitel epoll bubble i used to live in
(21:00:57) janjust: sorry d12fk  :)
(21:01:11) janjust: it could be my way of testing, of course ;-)
(21:02:10) mattock: ok, do we agree that current behavior is ok?
(21:02:16) mattock: after all :)
(21:02:23) janjust: let's leave the current behaviour as is for now
(21:02:42) janjust: the original question was from jamesyonan regarding the=
 sys time when running 'time openvpn'
(21:02:47) janjust: I think we covered that by now ...
(21:02:52) mattock: yep
(21:03:47) mattock: a brief update at this point...
(21:03:53) janjust: now regarding http://sourceforge.net/tracker/?func=3Dde=
tail&atid=3D454719&aid=3D2015672&group_id=3D48978: I left a note for jamesy=
onan  to ask if buffer.{c,h} are now properly defensively programmed
(21:03:54) vpnHelper: Title: SourceForge.net: OpenVPN: Detail: 2015672 - bu=
ffer.{h,c} isn't defensively programmed (SECURITY?) (at sourceforge.net)
(21:04:02) mattock: oh yes, that one
(21:04:47) jamesyonan: buffer.{h,c} isn't defensively programmed: that was =
fixed a long time ago in r3129
(21:05:18) janjust: good, then that issue is closed (the sf robot had alrea=
dy closed it)
(21:05:19) jamesyonan: r3128 actually
(21:05:48) janjust: it was just an issue on the list that I wasn't sure eno=
ugh about to simply close it
(21:06:20) janjust: next : http://sourceforge.net/tracker/?func=3Ddetail&at=
id=3D454722&aid=3D1840041&group_id=3D48978
(21:06:22) vpnHelper: Title: SourceForge.net: Detail: 1840041 - OpenVPN wil=
l not connect through certain HTTP proxies (at sourceforge.net)
(21:06:46) janjust: some proxies seem to need a 'CONNECT HTTP://host:port/'=
 instead of 'CONNECT host:port'
(21:07:03) d12fk: actually i've never seen anything else
(21:07:11) cron2: *dig up RFC*
(21:07:18) jamesyonan: that makes sense
(21:07:19) janjust: well openvpn does 'CONNECT host:port' IIRC
(21:07:40) cron2: I have only ever seen "CONNECT host:port", this is why I'=
m searching for the RFC
(21:08:11) janjust: should we make this user-configurable?
(21:08:38) mattock: that'd probably be a good idea
(21:08:43) jamesyonan: interesting -- RFC uses host:port
(21:08:56) jamesyonan: not http://...
(21:09:18) cron2: jamesyonan: which RFC are you looking at?  I'm looking at=
 RFC2616, but that's very vague
(21:09:23) janjust: makes more sense to me jamesyonan : you don't have to C=
ONNECT to a http:// url per se, most likely it will be something else (http=
s, ftp, whatever)
(21:09:38) jamesyonan: RFC2817
(21:09:59) cron2: ah, indeed, thanks.  Missed the "updated by..." bit
(21:10:29) jamesyonan: it's fairly explicit -- and it makes sense because h=
ost:port in most cases will NOT refer to an http server
(21:10:43) janjust: if the RFC states that one should use CONNECT host:port=
 then I think we can close this bug with an 'won't fix'
(21:11:02) cron2: janjust: it does
(21:11:06) cron2: section 5.2
(21:11:15) mattock: or should we cater for disfunctional proxies?
(21:11:21) mattock: with a user-configurable parameter?
(21:11:48) janjust: hehe mattock: --use-disfunctional-broken-proxy-and-send=
-http-url=20
(21:11:55) mattock: yep, something like that :)
(21:12:08) jamesyonan: any info on which proxies require the non-compliant =
form?
(21:12:16) janjust: not in the bugtracker ...=20
(21:12:16) cron2: nothing in the bug
(21:12:41) mattock: I think we have to assume users can't fix the proxy, so=
 if openvpn does not work with it, it's a showstopper
(21:13:01) mattock: e.g. if it's proprietary or out of user's control
(21:13:07) mattock: right?
(21:13:16) janjust: true, but I've never seen complaints about it on the op=
envpn-users list, just on this sf bugtracker
(21:13:26) cron2: empirical: CONNECT http:// is NOT going to work for at le=
ast squid
(21:13:33) cron2: CONNECT http://boyle.space.net:443 HTTP/1.0
(21:13:36) cron2: HTTP/1.0 404 Not Found
(21:13:40) cron2: X-Squid-Error: ERR_DNS_FAIL 0
(21:14:02) cron2: Unable to determine IP address from host name for <I>http=
</I>
(21:14:02) mattock: janjust: so all we have is this bug report...
(21:14:04) janjust: mattock: we cannot fix/work around every broken piece o=
f software that's around
(21:14:09) mattock: true
(21:14:16) jamesyonan: I agree that we might want a flag for this, if there=
 are closed source proxies out there in widespread use that require it
(21:14:37) janjust: ok, action item: let's try and find out if there are wi=
despread used proxies around that require this
(21:14:37) mattock: if the problem is not widespread, I think we should not=
 try to work around it
(21:14:48) mattock: janjust: good idea
(21:14:58) janjust: if we cannot find it using an hour of google then the i=
ssue is moot, I'd say
(21:15:00) mattock: I can try my luck and mail the original bug author
(21:15:25) cron2: Apache mod_proxy also fails with "CONNECT http://..."
(21:15:36) cron2: HTTP/1.1 400 Bad Request
(21:15:39) janjust: hehe cron2, alright, alright, you've made your point ;-)
(21:16:10) cron2: janjust: no, this more along the lines of "so, will it be=
 harmful to change it?" - and the answer is, yes :-)
(21:16:30) mattock: so let's do a little research later on (e.g. tomorrow) =
and see if this is a real problem
(21:16:43) jamesyonan: The question in my mind is if MS proxies might requi=
re it
(21:16:43) mattock: I can mail the original bug author and ask what proxy d=
id he use
(21:16:47) janjust: mattock, I agree
(21:17:04) janjust: that would classify as 'wide spread' , jamesyonan  :)
(21:17:47) mattock: wouldn't be the first time Microsoft "adjusts" RFC's sl=
ightly
(21:18:06) mattock: janjust: any other bug reports we need to handle?
(21:19:05) mattock: from your part
(21:20:12) janjust: one more=20
(21:20:15) HotaruT: mattock: also ask which other client software would sen=
d connect-http:// at all
(21:20:33) janjust: JJK has identified possible missing code in multi_clien=
t_disconnect_setenv() [multi.c:447] setting the common_name environment var=
iable=20
(21:21:05) mattock: hotarut: I'll do some digging tomorrow and also ask our=
 users at -users ml
(21:22:19) janjust: the original report is http://article.gmane.org/gmane.n=
etwork.openvpn.user/29181
(21:22:20) vpnHelper: Title: Gmane -- Mail To News And Back Again (at artic=
le.gmane.org)
(21:23:15) cron2: I have to leave now - $wife said something about food and=
 being angry with me if I don't come NOW.  See ya :-)
(21:23:30) janjust: hehe cron2, I'm signing off after this one as well
(21:23:38) janjust: enjoy your meal
(21:24:03) mattock: cron2: bye!
(21:24:09) jamesyonan: bye
(21:24:17) d12fk: cron2: n'guten
(21:24:26) mattock: I think we should all sign off after this one, btw... 1=
:24 and going strong
(21:26:36) jamesyonan: multi_client_disconnect_setenv is just going to recy=
cle the CN that was set when the connection was established
(21:27:15) janjust: the -users report mentioned that it wasn't set at disco=
nnect ...=20
(21:27:31) janjust: hmmm perhaps I should not believe the user report and t=
est it myself ...
(21:28:08) mattock: janjust: if that's not too much trouble please go ahead=
 :)
(21:28:24) mattock: it'd help in clarifying the problem
(21:28:27) janjust: ghe ghe somebody else could volunteer as well, of cours=
e ;-)
(21:28:29) mattock: if there is one
(21:28:54) jamesyonan: I could believe that the CN might not be set on disc=
onnect if the user session never progressed to the ACTIVE state
(21:29:53) jamesyonan: but certainly the CN, if defined on connection setup=
, should not change during the course of the connection
(21:30:51) janjust: ah you mean that once it is set during _connect that th=
e env var is not touched...
(21:31:08) janjust: OK,action item for me : I'll try to reproduce this tomo=
rrow
(21:31:21) mattock: janjust: much appreciated!
(21:31:28) jamesyonan: yes -- that is how it SHOULD work
(21:32:07) mattock: seems like pretty nasty little problem, hard to spot=20
(21:32:18) mattock: or rather, to weed out by testing
(21:32:22) jamesyonan: one data point to consider is whether the alleged bu=
g occurs after a session renegotiation (at the one hour mark)
(21:32:41) janjust: the original posting mentioned a reconnect....
(21:33:30) janjust: but I'll test it tomorrow, including a reconnect/timeout
(21:33:39) jamesyonan: sounds good
(21:33:45) mattock: agreed
(21:33:53) mattock: I think we've covered enough for today
(21:33:58) janjust: yes
(21:34:14) mattock: I'll write summary tomorrow and see what we ended up wi=
th :)
(21:34:28) jamesyonan: great, thanks all
(21:34:44) mattock: great meeting, once again!
(21:34:58) mattock: let's continue the discussion on the mailinglists
(21:35:00) janjust: this was fruitful for me as well  - I learned quite a f=
ew things about openvpn :)
(21:35:23) mattock: you're never really ready :)
(21:35:41) mattock: anyways, good night, afternoon or whatever to everyone!=
 ;)
(21:35:51) mattock: bye
(21:35:54) janjust: hehe bye everyone
(21:35:56) janjust ha abbandonato il canale (quit: Quit: Leaving).
(21:36:00) d12fk: see you next week
(21:36:12) mattock: you too

--------------000302080905030703030500--

