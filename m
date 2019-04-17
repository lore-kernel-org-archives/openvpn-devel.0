References: <d1f51e3f-4fea-373d-f5e7-5acaedafbb8d@...515...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <cfe58b38-8701-c0b5-5c4b-307de29c1001@...515...>
Date: Wed, 17 Apr 2019 14:07:21 +0300
MIME-Version: 1.0
In-Reply-To: <d1f51e3f-4fea-373d-f5e7-5acaedafbb8d@...515...>
Content-Type: multipart/mixed; boundary="------------1C93314F947D7858782036B0"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (17th Apr 2019)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------1C93314F947D7858782036B0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 17th April 2019
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-04-17>

The next meeting is scheduled to Thursday 25th April 20:00 CEST.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, mattock, ordex, plaisthos and syzzer participated in this
meeting.

--

Planned the tap-windows6 release. Mattock provided tap-windows6 (9.23.1)
test installers a while back. During the somewhat limited testing they
behaved as intended (Windows 7, Server 2012r2, Windows 10). The
installers included all the important, open PRs from  Jon and Selva plus
the security fix. Those have now been merged with tap-windows6.

Mattock has improved the tap-window6 build process with further
automation and documentation and will provide tap-windows6 installers
for Windows 7/8/8.1/Server 2012r2 and Windows 10 (including arm64) later
today (unless blocked). On Friday he'll release updated OpenVPN 2.4
installers with the new tap-windows6 driver. Windows Server 2016/HLK
work will commence for real next week.

--

Agreed that the Powershell scripts used to sign tap-windows6 drivers and
installer packages could be merged into the main tap-windows6
repository. The scripts are here:

https://github.com/mattock/sign-tap6

Mattock will open a PR.

--

Talked about the OpenVPN "mini-hackathons". Agreed that the first
hackathon should be on May 3rd and last the "whole day". Also agreed
that these hackathons should be on a regular schedule, e.g. biweekly,
and pre-announced along with the monthly meeting invitations.

--

Talked about the ARM64 Windows 10 device offer Jon had for us. Agreed
that at least mattock and rozmansi need those devices. Cron2 would
benefit as well. Mattock contacted Jon already, asking for a device.
Mattock's test device won't probably arrive for time for the next
tap-windows6 release which is due this Friday, but given that existing
(x86/x64) users are not affected that is not a big deal.

--

Did some preliminary patch review which will continue later today.

--

Full chatlog attached.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------1C93314F947D7858782036B0
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-04-17.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-04-17.txt"

(12:35:44) mattock: ok let's start
(12:36:22) mattock: topic list is pretty spartan: https://community.openv=
pn.net/openvpn/wiki/Topics-2019-04-17
(12:36:24) vpnHelper: Title: Topics-2019-04-17 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:36:42) mattock: let's cover tap-windows6 quickly
(12:37:14) mattock: I provided test installer a while ago
(12:38:03) mattock: apparently they worked fine, but the platform coverag=
e was not perfect  - if I recall correctly tests were run on Windows 7, S=
erver 2012r2 and 10
(12:38:15) ordex: hay hay
(12:38:31) mattock: now all the important tap-windows6 PRs have been merg=
ed and I've produced the Windows 7 installer already
(12:38:42) mattock: documenting and automating while I do it
(12:38:51) mattock: Windows 10 is next in line after this meeting
(12:38:54) ***cron2 likes that
(12:39:29) mattock: then, probably next week I will move on to Windows Se=
rver 2016 + HLK
(12:39:48) mattock: I've had a physical (hosted) Windows Server 2016 inst=
ance that I can use as a HLK client
(12:40:11) mattock: I hope the HLK tests don't beat that instance to deat=
h, because that seemed to happen with some of the EC2-based HLK clients
(12:40:16) ***dazo is here too :)
(12:40:19) mattock: hi dazo!
(12:40:25) cron2: nice.  HLK will still fail, but we can at least see tha=
t we can get Stephen's patches merged, tested, and see what breaks and ho=
w to fudge it
(12:40:31) mattock: yep
(12:41:09) mattock: I have one question though: anyone opposed in merging=
 the powershell signing scripts (https://github.com/mattock/sign-tap6) wi=
th tap-windows6 repo?
(12:41:10) vpnHelper: Title: GitHub - mattock/sign-tap6: A Powershell scr=
ipt for signing or adding signatures to tap-windows6 drivers (at github.c=
om)
(12:41:27) mattock: I mean, you really need those scripts nowadays to pro=
duce anything beyond a test installer
(12:41:29) cron2: so what's the plan for "release all platforms but serve=
r 2016"?  Do you plan to put out a test installer, and then a regular ope=
nvpn-I60x installer?  or "both, right away"?
(12:41:38) mattock: well
(12:41:48) plaisthos: mattock1: sure merge them
(12:42:01) mattock: if we release just the tap-windows6 installers only a=
 few will ever test them
(12:42:10) cron2: mattock1: this is new scripts that really should go int=
o tap-windows6, right?
(12:42:17) mattock: yeah, I think so
(12:42:24) mattock: they _can_ be separate, but it is an extra step
(12:42:35) mattock: in the build/signing process
(12:42:37) cron2: then, please open a PR against tap-windows6 so I can cl=
ick the green button :-)
(12:42:39) mattock: ok
(12:42:44) ordex: mattock1: if they make your life easier and you use the=
m anyway, then I think we can/should merge
(12:42:54) mattock: sounds good
(12:43:14) cron2: (actually, the github PR / merge workflow *is* nice, if=
 this is the sole place where your repo lives and you don't mind merge co=
mmits)
(12:43:30) ordex: yap
(12:43:34) mattock: you can actually get rid of the merge commits
(12:43:36) mattock: nowadays
(12:43:51) ordex: well, you only have to rebase for that ;p
(12:43:51) mattock: we don't have merge commits in openvpn-gui
(12:44:00) ordex: but GH probably does it for you
(12:44:02) mattock: there's the merge strategy or something you can choos=
e
(12:44:13) ordex: yap
(12:44:24) cron2: mattock1: I tried in tap-windows6, and some commits nic=
ely worked with rebase/commit, while the other PR totally exploded, but "=
merge" worked fine
(12:44:37) mattock: yeah that is my experience as well with command-line =
git commands
(12:44:52) mattock: rebase is not as smart as merge for some reason
(12:45:13) ordex: I dare to say that it depends on whether you know what =
you are doing :-P
(12:45:23) ordex: hehe but we can talk about git another time
(12:45:50) mattock: anyways, I will be in a car most of tomorrow, so I su=
ggest we release the official tap-windows6 installers today and new openv=
pn installers on Friday
(12:45:57) cron2: my wife managed to totally hose up a CVS commit yesterd=
ay... and I so wished for a simple rebase... :-)
(12:46:14) cron2: mattock1: sounds good
(12:46:32) mattock: that might give Jon some time to test the ARM64 versi=
on as well
(12:46:35) dazo: cron2: you need to educate your wife to use git :-P
(12:46:55) cron2: we do have (at least one) an open ticket about tap6 sig=
natures... so these people might be actually willing to test...
(12:47:07) mattock: anyone have a link?
(12:47:10) cron2: dazo: that's what she said "with git, this would not ha=
ve happened!"
(12:47:26) dazo: \o/
(12:47:27) cron2: #592
(12:47:27) mattock: using CVS is probably not usually a personal choice :=
D
(12:47:57) mattock: will add that ticket link to my release ticket
(12:47:59) dazo: mattock1: there's a git interface for using CVS backends=
, iirc :-P
(12:48:05) cron2: dazo: the problem is "this is an existing project, and =
she was tasked with 'please add this new side functionality' not 'clean u=
p the whole mess of a 22-year-old HTML/CGI thingie, living in CVS'
(12:48:21) dazo: yikes
(12:48:26) ordex: lol
(12:48:32) mattock: done
(12:48:46) cron2: but after I cleaned up the CVS mishap, I seriously cons=
idered to invest half a day to move over to a 2019-style git workflow :)
(12:49:29) mattock: did we cover CVS adequately already :D?
(12:49:34) cron2: "this software is older than our trainees"...  (it's th=
e leased line documentation tool... basically, dirt simple SQL tables + s=
earch/add/update frontend, but it grew lots of nice tricks...)
(12:49:39) cron2: mattock1: yes :)
(12:49:49) mattock: \o/
(12:50:02) mattock: mini-hackathons? not in the topic list but still
(12:50:14) mattock: did you/we decide on when?
(12:50:25) dazo: yeah, lets try to schedule this properly
(12:50:47) cron2: May 3 rd?
(12:51:00) cron2: next week is holiday and kids and grandma birthday and =
chas
(12:51:02) cron2: chaos
(12:51:20) mattock: I suppose this week is chaos as well due to Easter?
(12:51:44) cron2: 9 full-time employees normally in the network group.  2=
 have quit, 1 is long-time ill, 3 are on vacation.
(12:51:48) cron2: you do the counting :)
(12:51:59) mattock: for me it is mostly "eat, clean up, wait 1 hour, star=
t preparing meal, eat, clean up, wait 1 hours, etc"
(12:52:06) dazo: yeah, at least on my side, this week is tricky .... Next=
 Wed I'm also travelling back home
(12:52:25) mattock: May 3rd starts sounding reasonable
(12:52:31) mattock: and from there on on a weekly basis?
(12:53:02) cron2: I cannot promise weekly, but you do not need me at all =
times anyway
(12:53:17) mattock: yeah
(12:53:21) mattock: time?
(12:53:32) cron2: "all day"
(12:53:35) mattock: ah ok
(12:53:43) cron2: I'll show up around 8, when kids are in school
(12:53:49) mattock: in understand the reluctance to commit to a weekly se=
ssion now :D
(12:54:08) mattock: I hope _I_ am not needed every time :P
(12:54:21) mattock: at least as an active participant
(12:54:29) cron2: I think first thing we need to do is collect money to g=
et you an IRC bouncer :)
(12:54:37) mattock: I hope money could solve that problem
(12:54:47) mattock: well maybe it would work now if I retried
(12:54:51) syzzer: I can't make May 3rd (and can't really promise anythin=
g during workdays)
(12:55:01) mattock: ZNC+Pidgin+Freenode's new authentication was a really=
 tricky combo
(12:55:03) syzzer: but I'll try to schedule any openvpn work to Fridays
(12:55:04) dazo: mattock1: I'm sure Andrew can grant you a DO box which c=
an run a bouncer for you ;-)
(12:55:25) mattock: well I have a bouncer, but the problem is configuring=
 it with the combo of software listed above
(12:55:34) cron2: syzzer: good enough.  What we'll try to do is to speed =
up the "patch, review, v2, review" cycles
(12:55:40) cron2: so not everybody needs to be here
(12:56:01) dazo: mattock1: we can have a look at ZNC later on ... I'm usi=
ng ZNC+hexchat ... but with auth properly working
(12:56:12) mattock: shall we aim for a every other week cycle?
(12:56:30) mattock: dazo: you could do a PoC for me using ZNC+Pidgin :)
(12:56:32) dazo: that's a good starter ... and if it's a fixed weekday, i=
t's easier to plan
(12:56:50) mattock: yeah, and I can add the mini-hackathons to the monthl=
y meeting invitation email
(12:57:00) mattock: less chance of us "forgetting" about the hackathons
(12:57:04) dazo: yeah
(12:57:13) mattock: make it official
(12:57:27) plaisthos: mattock1: didn't Microsoft offer us an ARM based wi=
ndows tablet to test the windows drivers? And are we following up on that=
 offer?
(12:57:46) mattock: plaisthos: they did offer that, yes, but we have not =
(yet) followed up
(12:57:55) mattock: but I'm not overly concerned about arm64 now - nobody=
 expects it
(12:58:07) plaisthos: okay
(12:58:14) mattock: so I would consider it beta anyways
(12:58:17) mattock: until proven otherwise
(12:58:27) mattock: but yeah, we should get hardware for testing that
(12:59:25) mattock: rozmansi and I should have arm64 windows devices
(12:59:29) mattock: eventually
(12:59:34) cron2: I'd take up microsoft on that offer, yes
(12:59:36) mattock: yep
(12:59:44) mattock: I can't recall if the devices were loaners or not
(13:00:03) cron2: microsoft wants arm, and if we can do a bit of nice PR =
with it "look, openvpn is the first VPN solution on ARM64!", why not :-)
(13:00:18) mattock: yeah
(13:00:28) cron2: mattock1: no details were mentioned (loan/donation, wha=
t sort of hardware exactly, ...)
(13:00:34) mattock: ok
(13:00:34) plaisthos: mattock1: does not really matter if they are loaner=
s or not, right?
(13:00:51) mattock: plaisthos: optimally we'd like to test every release,=
 not just the initial arm64 releases
(13:01:03) cron2: if they feel they need more testing, they can send me o=
ne as well ;-) - but mattock and rozmansi are the crucial builders
(13:01:12) mattock: _but_ maybe openvpn inc would be interested for havin=
g their own arm64 windows device that other teams could test on as well
(13:01:25) mattock: assuming getting remote access to one is possible
(13:01:46) plaisthos: remote testing with network and VPN does not work w=
ell :)
(13:01:54) plaisthos: unless you connect a KVM to it
(13:02:31) cron2: rdesktop via VPN on a different device, NATting to fe80=
::%lan addresses *duck*
(13:02:32) mattock: yeah something like that probably
(13:03:01) mattock: if the devices are affordable enough then having mult=
iple is not a big deal
(13:03:17) mattock: I can actually check the pricing and ask the bossman
(13:03:31) plaisthos: then again at https://geizhals.de/?cat=3Dnbtabl&xf=3D=
2174_Qualcomm~2187_Windows~3325_2018
(13:03:34) vpnHelper: Title: Tablets mit CPU-Hersteller: Qualcomm, Betrie=
bssystem: Windows, Gelistet seit: ab 2018 Preisvergleich Geizhals Deutsch=
land (at geizhals.de)
(13:03:41) plaisthos: so 700 EUR
(13:03:44) plaisthos: and there is only one
(13:04:24) mattock: let me open the discussion with Jon about this again =
- I'm sure he has ideas about which device to use
(13:04:25) cron2: I think there's a Surface one as well
(13:04:30) mattock: use/get
(13:04:30) cron2: yep
(13:04:36) plaisthos: cron2: nope
(13:04:42) cron2: nope?
(13:04:44) cron2: okay
(13:04:48) plaisthos: I have the Surface Go, which you probably think, th=
at is Intel based
(13:05:04) mattock: I hope we are not targeting just one device with ARM6=
4 lol :D
(13:05:19) plaisthos: there are the old Windows RT Surfaces that were ARM=
 based
(13:05:56) mattock: let us consult Jon
(13:06:09) mattock: he must have used _something_ while writing his code
(13:06:23) mattock: enough of tap-windows6/arm64?
(13:06:26) cron2: ARM64 emulator running on a $1M supercomputer :)
(13:06:34) mattock: :)
(13:06:57) cron2: enough, yes :)
(13:07:08) mattock: openvpn 2.5?
(13:07:22) mattock: or just "need to work on stuff to eventually get it o=
ut"?
(13:07:30) cron2: need to work on stuff to eventually get it out!
(13:07:34) mattock: good summary
(13:07:41) mattock: next topic
(13:07:41) mattock: ?
(13:07:47) cron2: (with the may3 date, we might actually make progress he=
re)
(13:07:53) mattock: agreed
(13:08:37) mattock: anything else for today?
(13:09:58) cron2: anyone up for a quick round of patch review assignment?=

(13:10:21) cron2: if I say "volunteers!" now, I can see you all declare "=
lunch time, sorry, have to go!" :)
(13:10:41) syzzer: I already had lunch :)
(13:10:46) cron2: plaisthos, dazo: could you fight the --genkey thing out=
 and come to a decision? ;-)
(13:11:07) ***dazo is ready for a fight! :)
(13:11:08) syzzer: looking into ilya's reported "base64 missing ignored" =
thingy
(13:11:13) cron2: syzzer: could you ave a quick view on https://patchwork=
=2Eopenvpn.net/patch/713/
(13:11:14) vpnHelper: Title: [Openvpn-devel,PATCHv2] openssl: Fix compila=
tion without deprecated OpenSSL 1.1 APIs - Patchwork (at patchwork.openvp=
n.net)
(13:11:44) cron2: oh yes, the base64 thing (plus "mbedtls") - if we fail,=
 we should fail, not declare success :-)
(13:11:53) plaisthos: I can also take that one
(13:11:57) cron2: or maybe skip the test if base64 is not available
(13:12:15) cron2: plaisthos: yours :)
(13:12:43) cron2: I think that one supersedes 705, but I'm not sure
(13:12:47) cron2: https://patchwork.openvpn.net/patch/705/
(13:12:49) vpnHelper: Title: [Openvpn-devel] openssl: Replace not[Before/=
After] functions with get0 variants - Patchwork (at patchwork.openvpn.net=
)
(13:13:35) syzzer: cron2: currently just making it fail if base64 is miss=
ing
(13:13:49) cron2: good first step
(13:15:29) syzzer: the fix might be specific to the various shell impleme=
ntations
(13:15:45) plaisthos: cron2: I agree with syzzer reasoning and also thing=
 that changing --genkey secret from generating a file called secret to ou=
tputting a secret key on stdout is not a good idea
(13:15:49) syzzer: so the patch would need testing on multiple platforms
(13:16:03) cron2: syzzer: can you push to mattock's repo?
(13:16:32) cron2: (buildbot is nowadays feeding from a non-public repo th=
at at least ordex is regularily pushing to... so you get at least buildbo=
t coverage)
(13:16:35) syzzer: cron2: if I can, probably not from the work office
(13:16:50) cron2: mattock1: can syzzer push to your repo?
(13:19:05) cron2: dazo: #577 sits on your lap (since a few months...)
(13:19:15) cron2: https://patchwork.openvpn.net/patch/577/
(13:19:17) vpnHelper: Title: [Openvpn-devel,v2] cmocka: use relative path=
s - Patchwork (at patchwork.openvpn.net)
(13:19:55) dazo: huh!?  whoops
(13:20:35) dazo: Hmm ... I recall this vaguely, I'll pull it up later tod=
ay
(13:21:32) cron2: there's enough in patchwork that smells like "cron2" (p=
lus those that have been actually delegated already)...
(13:21:49) cron2: trying to cover the windows stuff, pushing crypto and b=
uild stuff to you folks
(13:24:43) mattock: I finally found the email about ARM64 devices
(13:25:00) mattock: so Jon just asked to send GPG-encrypted email to him =
with the shipping address
(13:25:18) mattock: from openvpn.net address, but I guess that is negotia=
tible
(13:25:49) mattock: I just sent the request for hardware to Jon
(13:27:57) dazo: syzzer, plaisthos: should we agree on the --genkey stuff=
 a bit later today?
(13:28:23) ***dazo has lunch arriving and a tiny "daughter is upset" chal=
lenge
(13:28:41) plaisthos: yeah
(13:28:42) syzzer: dazo: yeah, let's try that
(13:28:53) plaisthos: go tame your little dragon
(13:28:55) dazo: 1.5 hour or so?
(13:29:04) dazo: 14:00
(13:29:23) ***dazo likes round numbers :-P
(13:31:18) cron2: nice.  Go feed your dragons, and I await your mails :-)=

(13:42:34) syzzer: cron2: base64 behaves differently on various platforms=
, should I just hardcode a (long) string instead and avoid the dependency=
?
(13:42:48) syzzer: feels ugly, but it is robust...
(13:44:11) cron2: syzzer: on openssl builds, one could do "openssl base64=
"... is there an mbedtls equivalent?
(13:44:49) syzzer: cron2: not sure, but that also assumes mbedtls is inst=
alled (not just libmbedtls)
(13:45:09) syzzer: but I think we assume having openssl anyway
(13:45:15) syzzer: so that might be a good way out
(13:46:03) syzzer: hm, we don't
(13:46:57) ordex: can we assume we have python ? that may have some easy-=
to-use base64 functionality
(13:47:40) syzzer: ordex: we don't use python anywhere in the test framew=
ork yet
(13:48:17) ordex: grumble grumble ok
(13:48:46) cron2: we cannot truly assume anything but C and "a SSL librar=
y"
(13:49:35) syzzer: okay, I'll just bardcode the string
(13:49:46) ordex: yeah
(13:49:48) cron2: good enough for a test module :)
(13:50:06) cron2: whatever bardcoding is, it looks very melodic
(13:50:08) ordex: the hardcoded string will work also if the library brea=
ks :p

--------------1C93314F947D7858782036B0--

