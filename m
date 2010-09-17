Message-ID: <4C93255E.5080004@...515...>
Date: Fri, 17 Sep 2010 11:22:54 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020501010904090406080005"
Subject: [Openvpn-devel] Summary of the IRC meeting (16th Sep 2010)
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
--------------020501010904090406080005
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 16th Sep 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2010-09-16>

Next meeting next week, same place, same time. Your local meeting time
is easy to check from services such as

<http://www.timeanddate.com/worldclock>

or with

$ date -u


SUMMARY


Discussed the "Windows route + hibernate/suspend issue":

<https://community.openvpn.net/openvpn/ticket/56>

D303k and jamesyonan debugged this issue during the meeting and got
mixed results on Windows 7 VM running on VMWare ESX: sometimes OpenVPN
recovered properly, sometimes not. Mattock promised to ask the original
bug reported for log files with "verb 7" log level. D303k promised to
try reproducing this problem on real, hardware Win7 laptop.

This issue seems to be Windows-related, as similar problems have not
been reported for *NIX platforms. Also, mattock and frk are constantly
using OpenVPN with hibernation on Ubuntu 9.10 / 10.04 / 10.10 without
any issues.

--

Discussed the use of a relatively powerful Xen DomU (VM) which was
offered to the project. Potential uses for this server were discussed in
this meeting two weeks ago.

Decided to use VM as the public test server (for "make test") and as a
buildslave. FreeBSD was chosen as the OS, other alternatives being
Debian, Ubuntu, CentOS and Win2008k. The reason was that we already have
buildslaves for the other OSes (except Win2008k) and in test server use
the OS does not really matter.

--

Mattock gave an update on recently released 2.2-beta3. Looking at the
webserver logs 2.2-beta3 there have been total of 6842 downloads from
unique IPs. Out of these 6593 were windows installers. As 2.2-beta3 has
without a doubt been downloaded from computers behind NAT firewalls, the
real download figure is probably between 7000 and 10000.

--

Mattock gave an update on Buildbot and Debian packages. Yesterday he got
four buildslaves (debian-5-i386/amd64 and ubuntu-10.04-i386/amd64)
connected to the buildmaster server through the community VPN. These
buildslaves will then build packages for their respective
OS/architecture. Building the Debian packages under buildbot has been
tested already, but the debian control files need some work, as does
buildmaster configuration.

If all goes well, first Debian packages based on "allmerged" branch
should be available in the evening of 17th September.

--

Discussed the possibility of hosting future OpenVPN (open source) file
releases on SF.net instead of openvpn.net servers. The main download
page with download links, release notes etc. would still be at openvpn.net:

<http://openvpn.net/index.php/open-source/downloads.html>

This would give a few benefits:

* More visibility for the OpenVPN project through higher ratings at SF.net
* Free mirroring and bandwidth
* Very detailed download statistics

The only downside is the potential reduction of traffic going through
openvpn.net.

An alternate approach would be to host releases primarily on openvpn.net
servers, but offer them through SF.net also as a secondary option.

Mattock promised to look into this issue.

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------020501010904090406080005
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-09-16.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-09-16.txt"

(21:01:41) jamesyonan [~jamesyona@...1320...] =EF=BF=BD=EF=BF=BD entrato ne=
l canale.
(21:01:55) mattock: hi james!
(21:02:20) modalit=EF=BF=BD=EF=BF=BD (+o jamesyonan) da ChanServ
(21:02:20) jamesyonan: Hi
(21:02:20) fkr: hey james.
(21:02:34) fkr: <- the guy who maintains openvpn on openbsd (among other th=
ings)
(21:02:49) mattock: dazo: did you find any stuff worth discussing?
(21:03:08) mattock: perhaps the thread Alon started...
(21:04:28) dazo: mattock: No, I haven't managed all I wanted ... but it's b=
een a lot of interesting discussions on the ML lately
(21:04:32) ecrist: raidz: I'm thinking that the best thing to do would be t=
o put up a webser that can respond with something as simple as 'Service Una=
vailable'
(21:04:42) ecrist: not worth the effort to replicate the db
(21:04:53) ecrist: if it's going to be long-term, we can restore the db fro=
m backups
(21:05:14) mattock: ok, time to start meeting...
(21:05:17) ecrist: if the forum gets 'really' active, we can even start doi=
ng backups more frequently than once a day.
(21:05:19) raidz: ecrist: no problem, that works
(21:05:24) ***ecrist shuts up
(21:05:46) mattock: ok, so topic list is short and here: https://community.=
openvpn.net/openvpn/wiki/Topics-2010-09-16
(21:05:48) vpnHelper: Title: Topics-2010-09-16 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN Community (at community.openvpn.net)
(21:06:21) mattock: I dug into the Windows route + hibernate/suspend issue =
today: https://community.openvpn.net/openvpn/ticket/56
(21:06:24) vpnHelper: Title: #56 (WinXP: route setup broken after standby) =
=EF=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN Community (at community.openvpn.net)
(21:06:31) d303k [~heiko@...1404...] =EF=BF=BD=EF=BF=BD entrato nel canale.
(21:06:33) mattock: seems like similar issues have been around since 2004
(21:06:38) mattock: hi d303k!
(21:06:43) d303k: hello
(21:07:11) mattock: jamesyonan: what's you're take on the Windows suspend/h=
ibernate issue? Is that a known problem and something we could fix?
(21:08:09) d303k: mattock: what are the symptoms?
(21:08:28) ***dazo understands it as VPN routes are missing
(21:08:29) mattock: d303k: check this bug report: https://community.openvpn=
.net/openvpn/ticket/56
(21:08:30) vpnHelper: Title: #56 (WinXP: route setup broken after standby) =
=EF=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN Community (at community.openvpn.net)
(21:08:45) mattock: there are several similar reports from 2004, 2006 and 2=
010
(21:09:12) mattock: I'm wondering if this is an issue with Windows suspend/=
resume cycle or OpenVPN
(21:09:13) jamesyonan: why not just re-add the routes after awakening from =
standy?
(21:09:44) dazo: Without knowing how this stuff really works on Windows, I =
think it is related to that the routes are taken down automatically when th=
e device is suspended=20
(21:09:45) jamesyonan: does it occur when "persist-tun" is used?
(21:09:50) d303k: openvpn-gui does tear down openvpn when windows is suspen=
ded, however the bugreport doesn't mantion the gui
(21:10:13) mattock: I'll check the latest ml thread again...
(21:10:33) mattock: it's here: https://sourceforge.net/mailarchive/message.=
php?msg_name=3DL8D646C6A35154b2399CD5E4EB944E66D.1284482670.email.pmi.phoen=
ixmi.com%40MHS
(21:10:34) vpnHelper: Title: SourceForge.net: OpenVPN: (at sourceforge.net)
(21:10:46) bGatti [~ben@...1405...] =EF=BF=BD=EF=BF=BD entrato nel canale.
(21:10:56) mattock: btw, better replace https with http
(21:11:03) mattock: hi bGatti!
(21:11:12) mattock: topic list is here: https://community.openvpn.net/openv=
pn/wiki/Topics-2010-09-16
(21:11:14) vpnHelper: Title: Topics-2010-09-16 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN Community (at community.openvpn.net)
(21:12:04) jamesyonan: hi ben
(21:12:09) bGatti: Hi.
(21:12:10) mattock: jamesyonan: it seems using "persist-tun" makes no diffe=
rence=20
(21:12:54) jamesyonan: it's completely normal for the openvpn client to los=
e the connection with the server after awake from standby
(21:13:06) jamesyonan: but it should reestablish it on wakeup
(21:13:33) mattock: the issue seems to be that openvpn client does not reco=
nnect properly after waking up
(21:13:34) dazo: agreed ... but could it be that routes are processed in th=
is case?
(21:13:55) dazo: good point, mattock ... I took that for granted
(21:14:15) mattock: on Windows 7 at least, although one guy reported that r=
outes _are_ re-established after wakeup on WinXP
(21:14:26) jamesyonan: is the issue a failure to reconnect, or does the rec=
onnect occur but routes are not added?
(21:15:17) dazo: we should probably request log files from the clients, wit=
h --verb set to minimum 5 ...
(21:15:48) mattock: so we may be looking at two different issues: the old o=
ne (from 2004-2006) and the new one
(21:15:51) dazo: unless anyone else got access to a Win7 box and can manage=
 to reproduce this issue
(21:15:53) mattock: dazo: agreed
(21:16:13) d303k: i have a virtual win7  at work#
(21:16:20) mattock: I can ask for log files from the reporter=20
(21:16:29) mape2k [~mape2k@...1306...:6f8:133b:0:21f:3bff:fe27:21a9] =EF=BF=
=BD=EF=BF=BD entrato nel canale.
(21:16:33) mattock: d303k: could you try to reproduce this issue?
(21:16:52) dazo: I would say we should have a close look at this new Trac t=
icket first.  A 6 year old report won't give too much right now
(21:16:56) mattock: on Ubuntu 9.10 I've had zero problems with OpenVPN reco=
vering from hibernation
(21:16:57) d303k: i'll try
(21:17:07) dazo: d303k: cool! thx!
(21:17:39) fkr: mattock: can second that on 10.04 and 10.10 (which is beta)
(21:17:46) mattock: fkr: ok
(21:17:58) mattock: so most likely only related to Windows
(21:18:25) mattock: ok, so I'll request log files from the reporter and d30=
3k will try to reproduce this on Win7
(21:18:29) mattock: next topic?
(21:18:45) mattock: hmm, perhaps output of "route" command would be nice, t=
oo
(21:18:55) fkr: ack
(21:18:56) mattock: what else?
(21:18:58) dazo: I think it is isolated to Windows ... and I got a vague fe=
eling it might be connected to the Windows TAP driver not being ready yet w=
hen openvpn.exe starts reconnecting
(21:19:06) mattock: perhaps "ipconfig" output?
(21:19:44) dazo: mattock: nah ... logs with --verb 5 or higher should be su=
fficient right now ... that will tell if routes are tried to be set or not,=
 and if that fails or not
(21:19:49) mattock: ok
(21:20:06) dazo: ipconfig output of the tap device might be interesting tho=
ugh
(21:20:08) d303k: so the guy had the service start the connection
(21:21:01) mattock: d303k: I think so, he didn't mention anything about a G=
UI
(21:21:08) dazo: mattock: make it --verb 7 ... I think that can be good now
(21:21:14) mattock: dazo: ack
(21:21:27) mattock: next topic: Wayne's VPS server offer
(21:21:45) mattock: wayne =3D praetorian
(21:21:54) Praetorian|Mobil: thats me :P
(21:22:02) dazo: Cool!
(21:22:48) mattock: praetorian: you mentioned the VPS was dual core... do y=
ou mean the VPS has two dedicated CPUs or that the host has two CPUs?
(21:22:57) dazo: I would say that having a build slave and a public test se=
rver, where people (everyone who are interested) can try to connect against=
 the server ... it should not forward anything, but could run a iperf server
(21:23:28) Praetorian|Mobil: the server is a 16 core box.=20
(21:23:29) dazo: the build slave would be, secondary in my eyes
(21:23:42) mattock: praetorian: ok, that's plenty :)
(21:23:54) mattock: so I think we should use it for something that benefits=
 from those 2 cores
(21:23:54) Praetorian|Mobil: I bascially got in on an intro offer for 3 vps=
 for a flat yearly fee that was too good to pass up for two vps let alone t=
hree
(21:24:40) Praetorian|Mobil: we have used them for almost tow years now and=
 the uptime is pretty damn good for vps providers
(21:25:11) mattock: dazo: I was thinking along the same lines
(21:25:14) Praetorian|Mobil: but I only have uses for two now.. so instead =
of just letting it sit there and be wasted I would like to let the openvpn =
community use it
(21:25:32) dazo: That's really awesome!
(21:26:01) mattock: praetorian: what were the OS choices again? centos, deb=
ian, freebsd, ubuntu... what else?
(21:26:19) Praetorian|Mobil: win2008 ent I think was hte other one
(21:26:23) mattock: oh yes...
(21:26:33) mattock: would we have any use for a Win2008 server?
(21:27:18) mattock: if not, I think a combined buildslave + test server wou=
ld be best option
(21:28:28) dazo: hmm ... I think it will be better use of it as test server=
 + build slave .... but we need to think about how we do test the windows p=
latform
(21:29:45) Praetorian|Mobil: the only request I have to make it not possibl=
e to be used as a spam tunnel.=20=20=20
(21:29:57) dazo: Praetorian|Mobil: agreed!
(21:29:58) mattock: praetorian: I'll make sure it won't be misused
(21:30:17) Praetorian|Mobil: :)
(21:31:11) dazo: I'd say that's to restrict the firewall on that VM to only=
 allow traffic via the tunnel to specific IPs ... like a iperf server or si=
milar stuff
(21:31:21) mattock: what if we use it as a buildslave and a test server, th=
en? what OS to use? Debian/Ubuntu are already covered
(21:31:25) dazo: Praetorian|Mobil: are there any bandwidth restrictions on =
this VM?
(21:31:41) Praetorian|Mobil: 5.6tb both ways a month
(21:32:04) mattock: what happens if that limit is reached?
(21:32:18) mattock: are the connections refused or do you get a really big =
bill? :)
(21:32:21) Praetorian|Mobil: hmm,  good question.. let me look and see
(21:32:32) dazo: Praetorian|Mobil: I'd consider that "unlimited" for our us=
e case ;-)
(21:33:31) dazo: mattock: If installing Linux, we can setup some iptables r=
ules which can block traffic when it hits a certain threshold
(21:33:41) Praetorian|Mobil: they dont actually sy on their site..  so not =
sure,  one thing,  its capped at 20mbit rate..
(21:34:55) dazo: Praetorian|Mobil: if we're going for an OpenVPN test serve=
r, open for "everyone" to run tests against ... would that make you nervous?
(21:35:53) Praetorian|Mobil: nope,  they have it QOS'd so if they go over t=
hat it will get throttled.
(21:36:12) dazo: :) sounds good!
(21:37:35) mattock: ugh... just got phone call...
(21:38:51) mattock: I suggest using FreeBSD for the OS... all other OS'es a=
re/can be covered easily with buildslaves
(21:39:02) mattock: and for the "make test" server OS does not really matte=
r I guess
(21:39:09) mattock: and Windows is not an option :)
(21:39:16) dazo: true enough!
(21:39:42) mattock: I wouldn't want to contaminate forums.openvpn.net (free=
bsd VM) with buildslaves, either
(21:40:08) mattock: praetorian: can we select the DNS name for the VPS?
(21:40:33) Praetorian|Mobil: sure,  that should be possible.
(21:40:48) Praetorian|Mobil: you are speaking of reverse dns and host anme =
right
(21:41:13) mattock: yep
(21:41:25) Praetorian|Mobil: should not be a problem.=20=20
(21:41:32) Praetorian|Mobil: just let me know what you want
(21:41:35) mattock: ok
(21:41:55) mattock: I guess that topic is covered, then :)
(21:42:02) mattock: praetorian: thanks a lot for the VPS!
(21:42:09) mattock: much appreciated!
(21:43:05) mattock: jamesyonan, raidz: I'm interested in download statistic=
s from 2.2-beta3 and 2.1.3... are any available?
(21:43:20) mattock: s/from/for/1
(21:44:06) mattock: so far I've heard no complaints about 2.2-beta3
(21:44:06) Praetorian|Mobil: can I inquire about the updated debian builds?=
  with gerts ipv6 payload in them?
(21:44:15) mattock: praetorian: sure
(21:44:52) mattock: in fact, today I finally got my four buildslaves (debia=
n-5-i386/amd64 and ubuntu-10.04-i386/amd64) connected to the buildmaster se=
rver=20
(21:44:54) raidz: I can parse our logs
(21:45:01) mattock: raidz: thanks!
(21:45:20) mattock: so, these buildslaves will build packages for their OS+=
architecture
(21:45:46) mattock: I've already tested building debian packages using a bu=
ildslave and it seemed to work ok
(21:46:08) mattock: the debian control files need some work, as does buildm=
aster configuration, but otherwise things are looking bright
(21:46:33) mattock: I intend to continue working on these buildslaves tomor=
row
(21:47:02) mattock: If I'm don't run into big issues we'll have some debian=
/ubuntu packages based on "allmerged" branch available tomorrow evening
(21:47:24) mattock: and "allmerged" has ipv6 support
(21:47:33) Praetorian|Mobil: mattock: cool,  I have a setup that I would li=
ke to test with the new packages when they are ready.
(21:47:51) Praetorian|Mobil: 1 server with 6 clients all using ip6=20
(21:48:13) Praetorian|Mobil: inside the tunnel
(21:48:22) mattock: great, IPv6 _and_ my debian packages are begging for te=
sting :)
(21:48:29) dazo: ipv6 in the tunnel ... that will make cron2 happy!
(21:50:20) dazo: Praetorian|Mobil: your setup is using tun or tap devices?
(21:50:54) dazo: if using tun ... that will be the new big thing for ipv6 s=
upport
(21:51:26) Praetorian|Mobil: heh,  i think its tun..  its been working so w=
ell I have not had to ess with it
(21:51:46) mattock: I'll check download statistics for 2.2-beta3 now
(21:51:58) dazo: Praetorian|Mobil: now IPv6 is supported in TAP mode only, =
with manually configuring IPv6 addresses
(21:52:28) Praetorian|Mobil: dazo: correct,  I setup both ends with address=
es.
(21:53:12) dazo: Praetorian|Mobil: yeah, that explains ... if it is possibl=
e to trick you into running 'allmerged' with tun mode ... that would be ver=
y much interesting :)
(21:54:10) Praetorian|Mobil: Ill give it a shot..=20=20=20
(21:55:07) Praetorian|Mobil: build me a package (I'm not very good at build=
ing packages.) more of a generic network admin that does way to many things.
(21:56:29) dazo: Praetorian|Mobil: cool! :)
(21:58:26) d303k: ok, i could reproduce the thing on win7
(21:58:50) dazo: d303k: lovely!  could you parse something sensible out of =
the log files?
(21:59:01) d303k: after coming back from hibernation two services use up 10=
0% cpu
(21:59:04) mattock: ok, so unless my command-line was screwed up, 2.2-beta3=
 has been downloaded 27515 times
(21:59:12) mattock: I'll see how many of those are windows installers
(21:59:19) dazo: mattock: that's a lot!
(21:59:23) mattock: yep
(21:59:33) mattock: in 6 days
(22:00:02) d303k: when i killed the openvpn.exe child of openvpnserv.exe th=
e load got less but was not at 100% idle, yet
(22:00:03) mattock: and no complaints so far... 2.2-beta3 is probably prett=
y stable
(22:00:20) d303k: stopping the service brought back 100% idle again
(22:00:20) dazo: mattock: over 4500 downloads per day, that sounds too good=
 to  be true ... for a beta release ...
(22:00:31) mattock: 22638 of those downloads are windows installers
(22:00:57) mattock: dazo: we should not forget that 2.2-beta3 is the _first=
_ release on the page, and people never pay attention to what they're doing=
 :P
(22:01:16) dazo: mattock: true :)
(22:02:20) d303k: the verb 3 log didn't show anything after init seq comple=
ted
(22:02:20) mattock: I'll check how many unique IPs have downloaded 2.2-beta3
(22:02:33) d303k: openvpn*.exe did not use any cpu
(22:02:51) d303k: the two services were started by svchost
(22:03:12) dazo: jamesyonan: ^^^ do you pay attention to d303k findings?
(22:03:39) mattock: ok, now we should get more realistic download statistics
(22:03:44) mattock: filtered by source IP
(22:03:58) jamesyonan: d303k: which process was using 100% cpu?  openvpn.ex=
e or openvpnserv.exe ?
(22:04:01) d303k: C:\Windows\System32\svchost.exe -k LocalServiceNetworkRes=
tricted was the one taking less cpu
(22:04:02) mattock: although if there are several clients behind the same N=
AT, then that does not work
(22:04:41) mattock: ok, windows installer of 2.2-beta3 has been downloaded =
from 6593 unique IPs=20
(22:04:51) d303k: C:\Windows\system32\svchost.exe -k LocalServiceNoNetwork =
was the other one
(22:05:24) dazo: mattock: what about to put future community releases on sf=
.net? ... they got mirroring and download statistics ... and it we might ge=
t some advertisements via sf.net announcements if it scores high up on the =
lists ...
(22:05:28) d303k: jamesyonan: none of the openvpn processes used a recogniz=
able amount of cpu
(22:06:38) mattock: dazo: I think we could put the releases to SF.net and F=
reshmeat as well as openvpn.net
(22:06:44) jamesyonan: d303k: which process was using most of the CPU then,=
 when usage was spiking to 100%?
(22:07:03) d303k: the two service processes mentioned above
(22:07:17) d303k: the latter one was the greater hog, though
(22:07:26) dazo: mattock: agreed ... if I understand you right, having down=
loads only from sf.net, but pointers from openvpn.net and freshmeat.net to =
the sf.net download page ...
(22:07:29) jamesyonan: svchost.exe?
(22:07:41) d303k: nd they calmed down only after stopping openvpnserv.exe
(22:08:12) d303k: well, svchost ist just the starter pay attention to the -=
k parameters
(22:08:33) d303k: i don't know what they are for yet
(22:08:59) d303k: but it might indeed have to do with tap behaving badly on=
 resume
(22:09:20) mattock: dazo: I was thinking about keeping openvpn.net the prim=
ary download page, but augmenting it with sf.net and freshmeat to increase =
visiblity further. And we could have links to alternate downloads pages (=
=3Dsf.net and freshmeat)
(22:09:42) mattock: personally I would not mind having the downloads in SF.=
net only, but that's also a political decisions
(22:09:57) d303k: jamesyonan: any specific thing i should pay attention on =
the upcoming next try
(22:10:59) dazo: mattock: I understand the concept for the closed source re=
lease ... but for the open source/community edition, I think it would be be=
tter to move it ... also as they have pretty good download statistics, and =
the new beta interface is very much interesting in that regards .... plus g=
ood mirroring=20
(22:11:52) mattock: dazo: I can suggest that... I agree that SF.net's downl=
oad statistics are pretty good
(22:11:57) mattock: and fun to watch :)
(22:12:44) dazo: yeah :)  And if we're able to get it up on the "top 20 dow=
nloads" list ... openvpn gets even more attention through their community m=
ails as well
(22:12:50) mattock: plus with this many downloads we would be one of the mo=
st active projects
(22:13:24) jamesyonan: d303k: not sure -- svchost.exe is a windows app
(22:13:52) dazo: mattock: yup!
(22:14:20) jamesyonan: openvpnserv.exe defines two dependencies -- the TAP =
driver and the DHCP client.  svchost is supposed to make sure these depende=
nt services are started before starting openvpnserv.exe
(22:14:31) ecrist: mattock: did you have source download numbers?
(22:14:36) jamesyonan: that's the main interaction
(22:15:29) d303k: jamesyonan: svchost.exe is used to start "normal" program=
s as services iirc
(22:15:31) mattock: ecrist: so total of 6842 downloads from unique IPs... o=
ut of these 6593 were windows installers.
(22:15:44) mattock: so ~300 source downloads
(22:15:46) dazo: that sounds more likely
(22:16:08) d303k: i found instructions on how to find out which functions a=
re called when it eats up cpu
(22:16:10) mattock: although I'm pretty sure many of those connections are =
coming from behind corporate NAT firewalls
(22:16:41) d303k: i'l try to find out tomorrow at work
(22:16:53) d303k: http://www.msfn.org/board/topic/140264-how-to-get-the-cau=
se-of-high-cpu-usage-caused-by-apps/
(22:16:54) vpnHelper: Title: How to get the cause of high CPU usage caused =
by apps? - MSFN Forums (at www.msfn.org)
(22:17:20) jamesyonan: d303k: are you saying that you're running openvpn.ex=
e as a service, but not using the windows service control manager to do so?
(22:17:50) mattock: James' signatures have been downloaded from 216 unique =
IPs...=20
(22:18:59) dazo: mattock: agreed, some of the downloads have come through s=
ome NAT's ... but probably not over 16000 ;-)
(22:19:15) d303k: jamesyonan: no i'm saying svchost is not the scm process
(22:19:35) mattock: I'd say more than 7000 but less than 10000 downloads
(22:19:46) dazo: mattock: agreed
(22:19:52) d303k: the scm process is called services.exe
(22:20:07) d303k: and openvpnserv.exe is a child of it
(22:20:26) ecrist: mattock/raidz: any word on getting a section onto the fo=
rums for access server?
(22:20:29) d303k: and so are the two offending svchost.exe processes
(22:20:34) ecrist: https://forums.openvpn.net/viewtopic.php?f=3D6&t=3D7104
(22:20:35) vpnHelper: Title: OpenVPN Support Forum View topic - No Access S=
erver (at forums.openvpn.net)
(22:22:08) mattock: ecrist: raidz is probably the best person to answer that
(22:22:32) raidz: I will work on that today, we can plan on launching it Mo=
nday.
(22:23:04) mattock: I think the official part of the meeting is over by now=
...
(22:26:00) dazo: :)
(22:26:27) d303k: jamesyonan: just tried hibernation without openvpn runnin=
f and the "svchost.exe -k LocalServiceNetworkRestricted" process used up so=
me cpu for a while
(22:26:52) ***dazo need to head for bed ... still feeling the jetlag a litt=
le bit :)
(22:27:10) mattock: dazo: good night!
(22:27:22) d303k: dazo: night
(22:27:34) dazo: c'ya!
(22:27:54) dazo: d303k: thx a lot for looking into the suspend stuff!  Grea=
t work there!
(22:27:55) d303k: jamesyonan: trying again with ovpn and will be more patie=
nt
(22:28:37) d303k: dazo: nah
(22:29:29) dazo =EF=BF=BD=EF=BF=BD ora conosciuto come dazo_afk
(22:32:51) mattock: I'll write the summary tomorrow
(22:34:55) d303k: jamesyonan: hm, this time coming back from hibernation wo=
rked, the routes are there and the LocalServiceNoNetwork service doesn't go=
 nuts
(22:35:47) d303k: and cpu is idle now after a while of setteling down
(22:38:05) jamesyonan: maybe the issue is triggered by the order in which s=
ervices come out of hibernation
(22:38:55) d303k: jamesyonan: i'm trying again
(22:39:04) Praetorian|Mobil ha abbandonato il canale (quit: ).
(22:40:20) d303k: worked again
(22:58:12) d303k: jamesyonan: ok i can reproduce the issue again, but i'm n=
ot sure if it's really the one the user has
(23:03:41) d303k: the win7 runs in a VM on a ESX server. when i try to slee=
p (which does not work - win7 comes back instantly) before hibernating the =
LocalServiceNoNetwork service loops
(23:03:53) d303k: trying without openvpn again now
(23:25:19) cron2: re
(23:26:20) d303k: final words for today: LocalServiceNoNetwork uses 100% cp=
u after a couple of the non-working sleeps on the VM as well as after hiber=
nate after sleeping. that's when the route are not set
(23:27:27) d303k: however, i don't trust the ESX, i'll try to steal a lapto=
p with win7 on it from a coworker tomorrow and verify my findings
(23:27:40) d303k: cron2:  hi and good night to all
(23:27:54) cron2: d303k: hi and good night :-)
(23:28:47) d303k: oh and as soon as i kill openvpn.exe cpu goes down to idl=
e again
(23:30:17) d303k: ok that's it then for tonight

--------------020501010904090406080005--

