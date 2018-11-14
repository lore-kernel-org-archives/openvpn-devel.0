From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <847x1g.pi5fr1.rtgvih-qmf@...2474...>
 <saqoa4.pi5fx8.rtgvih-qmf@...2475...>
 <e757d415-c9e3-feed-34a9-9f97699222ae@...515...>
Message-ID: <a45e856e-64ff-daa6-c39f-dcf1face03d9@...515...>
Date: Wed, 14 Nov 2018 15:25:48 +0200
MIME-Version: 1.0
In-Reply-To: <e757d415-c9e3-feed-34a9-9f97699222ae@...515...>
Content-Type: multipart/mixed; boundary="------------C40525978E08900B5F7CD6FC"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (Wed,
 14th Nov 2018)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------C40525978E08900B5F7CD6FC
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 14th November 2018
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2018-11-14>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, mattock, ordex, plaisthos, rozmansi and syzzer participated
in this meeting.

--

Discussed tls-crypt-v2 patches. Noted that two of the are not merged yet:

<https://patchwork.openvpn.net/patch/582/>
<https://patchwork.openvpn.net/patch/583/>

--

Discussed networking API patches. The same fucntionality is implemented
in openvpn3-linux codebase and that has been working very well. One IPv6
related bug has been fixed and a patch is about to be sent for OpenVPN 2.

--

Discussed rozmansi's MSI patches. Noted that Jon has given ACKs with
different wording ("Looks good to me") to many of them so they can be
merged. There is also an openvpn-build PR pending which mattock is
having a look:

https://github.com/OpenVPN/openvpn-build/pull/141

--

Talked about tap-windows6 HLK testing. Sgstair has made good progress on
that front and has fixed a number of issues. So besides getting WHQL
certification we also get a better driver and OpenVPN in the process.

--

Discussed the HackerOne report about OpenVPN on Windows having (generic)
DLL hijacking vulnerabilities. Agreed to migrated the report from
HackerOne to Trac:

https://community.openvpn.net/openvpn/ticket/1141

Also agreed that fixing this in a meaningful way would be very tricky.

--

Briefly discussed the integration of openvpn-build and rozmansi's
WiX-based MSI packaging. Agreed that mounting the openvpn-build
directory (of the Linux builder) as a Samba share on the WiX builder
(Windows host) is adequate.

--

Full chatlog attached.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock





--------------C40525978E08900B5F7CD6FC
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2018-11-14.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2018-11-14.txt"

(12:23:19) plaisthos: hey
(12:23:44) plaisthos: I won't have much time today and will probably leav=
e in a half hour :(
(12:24:04) mattock2: Hi all
(12:24:43) plaisthos: As for the client-connect patches. ordex pointed ou=
t that I should rerun uncrustify to fix code style issues=20
(12:25:30) ***ordex ducks
(12:25:35) plaisthos: I did that and running it on the first patch only c=
hanged minor things I got rebase conflict on all other patches, so I will=
 resend the patches shortly
(12:27:02) cron2: hey
(12:27:13) dazo: hey
(12:32:30) cron2: plaisthos: makes sense, thanks
(12:32:52) mattock2: First topic? I'm my phone for a while
(12:33:10) ***cron2 feels smarter than his phone today
(12:33:31) syzzer: hi=20
(12:33:44) rozmansi: hi
(12:33:44) cron2: here's topic #1 :)
(12:34:08) ***ordex is here
(12:34:43) ordex: so we still have GA on the agenda?
(12:34:50) ordex: ahj no, wrong link :D
(12:35:20) ordex: well #1: I think the status is "merged", so syzzer ? :)=

(12:35:37) cron2: I've seen discussions about bugs and crashes with tinca=
ntech.  Are these all fixed?
(12:35:47) cron2: (last two weeks were more crazy than usual)
(12:36:06) ordex: at least the patch was sent to the ml
(12:36:09) ordex: let me chekc if it was also merged
(12:36:23) ordex: it seems the patch wasn't merged yet
(12:36:34) syzzer: I think there's one patch waiting for review
(12:36:46) ordex: https://patchwork.openvpn.net/patch/583/
(12:36:47) vpnHelper: Title: [Openvpn-devel] tls-crypt-v2: fix client rec=
onnect bug - Patchwork (at patchwork.openvpn.net)
(12:37:09) ordex: tincantech tested it and it was all fine
(12:37:23) ordex: do you need additional review? maybe I should do that i=
f needed
(12:37:24) ordex: (?)
(12:37:49) cron2: since you broke it :-) that would be the easiest, I thi=
nk
(12:38:33) dazo: tls-crypt-v2 should be merged
(12:38:47) ordex: ok, will review it. it should be fairly easy for me
(12:38:50) ordex: good morning dazo !
(12:38:50) cron2: ("broke" in the sense of "introduced per-instance keys =
and reloading" which conflicted here)
(12:38:55) ordex: yap
(12:39:04) ordex: I can get the blame ! no worries :D
(12:40:06) ordex: I have delegated it to me on pw
(12:40:15) syzzer: thanks :)
(12:40:25) dazo: patch looks trivial though
(12:40:30) ordex: there is a patch about the manpage too
(12:40:44) ordex: yeah, it's a little change, that becomes obvious when y=
ou read the context around
(12:40:48) ordex: we also have: https://patchwork.openvpn.net/patch/582/
(12:40:49) vpnHelper: Title: [Openvpn-devel] tls-crypt-v2: clarify --tls-=
crypt-v2-genkey man page section - Patchwork (at patchwork.openvpn.net)
(12:40:49) syzzer: although I am to blame too, since I only half-fixed th=
e merge conflict with the per-connection tls-auth patch...
(12:41:15) ordex: syzzer: I wouldn't be surprised if that chunk actually =
did not raise any real conflict
(12:41:37) cron2: syzzer: you already got to write the patch
(12:44:03) syzzer: but I think that's all for tls-crypt-v2
(12:44:48) cron2: that was easy :) - networking API is "sitnl"?
(12:45:35) dazo: I would say so, yes
(12:46:21) ordex: yap
(12:46:41) ordex: we have been using it in openvpn3 in our tests for now =
and it all looks good
(12:46:43) dazo: we're implementing basically the same code in openvpn3-l=
inux .... and that is working very well; ordex can fill out the details t=
hough.  One IPv6 related bug has been fixed, not sure if ordex submitted =
updated openvpn2 patch for that
(12:47:01) cron2: nice
(12:47:07) plaisthos: I am going to review that (at least the non netlink=
) this week or early next week
(12:47:20) ordex: we have some minor fixes to add compared to the version=
 we have on the mailing list, but nothing major. in a bit I will send ano=
ther set
(12:47:36) ordex: yeah, plaisthos can still review, because my fixes are =
really minor netlink bits
(12:48:15) cron2: o
(12:48:17) cron2: ok even
(12:50:18) mattock2: do all msi patches have acks a.k.a. "lgtm samuli"?
(12:50:45) rozmansi: nope, the initial msi patch has not been reviewed by=
 anyone yet.
(12:50:48) plaisthos: look good to me
(12:51:09) plaisthos: Need to hit the the road, talk to you later
(12:51:13) cron2: *wave*
(12:51:18) mattock2: maybe we need to point jon at it then
(12:51:22) ordex: plaisthos: bye
(12:51:29) rozmansi: plaisthos: bye
(12:51:40) mattock2: bye plaisthos!
(12:52:25) rozmansi: The https://patchwork.openvpn.net/patch/555/ is stan=
d-alone (only indirectly related to MSI packages), and it has Jon's "LGTM=
".
(12:52:26) vpnHelper: Title: [Openvpn-devel,5/5] Detect TAP interfaces wi=
th root-enumerated hardware ID - Patchwork (at patchwork.openvpn.net)
(12:53:34) cron2: LGTM from Jon sounds very ACKish to me :-)  (and I'm no=
t sure we have anyone else qualified to have a closer look, except maybe =
mattock)
(12:54:37) cron2: ordex: thanks for the ACKs.  I can merge tonight
(12:54:46) ordex: cool
(12:57:26) cron2: so, HLK testing
(12:57:56) cron2: mattock: do you want to report more verbosely?
(12:58:36) mattock2: summary: stephen is fixing things and future ia look=
ing bright
(12:58:44) cron2: *g*
(12:59:12) rozmansi: excellent
(12:59:13) cron2: yes, and we fixes his client-to-client interconneciton =
issues just an hour ago (by adding --client-to-client to the tap server ;=
-) ) so "even brighter"
(12:59:22) mattock2: the call to drop radixweb was clearly the right one
(12:59:39) mattock2: oh nice!
(12:59:47) ordex: :D
(12:59:51) cron2: in more details, stephen is fixing all those nasty thin=
gs that led to test client misbehaviour (like, "running out of memory due=
 to lack of flow control in the driver")
(13:00:16) cron2: some required calls were not there (easily fixed)
(13:00:39) cron2: the test rig wants to send "raw ethernet stuff" (as far=
 as we understand), so we changed from --dev tun to --dev tap, and that n=
ow looks all nice
(13:02:56) ordex: oh ok
(13:04:38) mattock: so this clearly improves tap-windows6 instead of just=
 getting us the WHQL certificate
(13:04:57) ordex: yeah, hopefully less bugs later :p
(13:05:08) mattock: anyways, so that's probably it about tap-windows6
(13:05:22) mattock: DLL hijacking thingy real quick?
(13:05:38) mattock: basically: we have a hackerone report about this (gen=
eric) DLL loading problem
(13:05:52) mattock: as it is generic and not openvpn-related, should we c=
reate a Trac ticket about it
(13:05:55) mattock: ?
(13:06:18) mattock: as in: "we should fix that eventually"
(13:08:12) mattock: i'd put that into the same category as "generic NSIS =
security issues which have nothing to do with OpenVPN in particular"=20
(13:08:17) cron2: yep
(13:08:34) mattock: I can do that right now
(13:08:42) mattock: OpenVPN 2.5 status?
(13:08:52) syzzer: it's less problematic that the NSIS installers, becaus=
e users are not expected to run openvpn from their downloads dir
(13:09:20) cron2: yep, you need some other sort of privilege escalation f=
irst
(13:09:33) syzzer: but it sounds like "hygiene on broken platforms" we sh=
ould probably do
(13:10:11) cron2: I wonder how we build on linux... do we use -Wl,rpath=3D=
 or do we just trust the dynamic linker?
(13:10:41) syzzer: I think we just trust the dynamic linker
(13:10:44) cron2: or do we just not formally care since we need root anyw=
ay...
(13:11:14) mattock: do you mind if I just copy-and-paste what is in the H=
ackerOne report?
(13:11:28) cron2: wfm
(13:11:32) syzzer: to trac?  I'd be fine with that
(13:11:42) mattock: yes to trac
(13:14:52) mattock: anything about 2.5 we should discuss and have not alr=
eady?
(13:15:34) cron2: the status update for the client-connect patches came f=
rom plaisthos at the beginning - "patch set sent, ordex complained about =
style, new patch set coming"
(13:15:39) syzzer: we should probably update https://community.openvpn.ne=
t/openvpn/wiki/StatusOfOpenvpn25
(13:15:40) vpnHelper: Title: StatusOfOpenvpn25 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(13:15:41) cron2: (which I should put on a keyboard hotkey)
(13:15:48) ordex: yup
(13:16:08) cron2: ordex: yup to "hotkey for 'patch set sent, ordex compla=
ined...'"? ;-)
(13:16:19) ordex: yes right
(13:16:24) ordex: waiting for the next set
(13:16:32) cron2: :)
(13:16:42) cron2: and yup to "update the wiki page", since tls-crypt-v2 i=
s done for good now
(13:21:13) rozmansi: mattock: I have a question about Windows  packaging =
and my PR to openvpn-build.git from yesterday...
(13:21:43) rozmansi: What's the usual workflow when you package NSIS inst=
allers?
(13:22:47) rozmansi: openvpn-build/generic on Linux, then sign binaries o=
n code-signing comp, then transfer the signed binaries .tar.gz back to op=
envpn-build/windows-nsis on Linux, right?
(13:23:28) mattock: rozmansi: I use windows-nsis/build-complete
(13:23:32) mattock: it calls generic/build
(13:23:50) rozmansi: Can't do that with MSI packaging, as it runs on Wind=
ows. :(
(13:23:55) mattock: the build artefacts are available under windows-nsis/=
tmp/build I believe
(13:24:11) mattock: so you could get the artefacts and do the MSI magic o=
n those
(13:24:33) rozmansi: exactly. what is your preferred way to transfer bina=
ries to Windows?
(13:24:38) mattock: essentially build-complete creates a staging director=
y and NSIS pulls the files from there
(13:24:58) rozmansi: (for developement purposes, I mounted openvpn-build =
as a Samba share)
(13:25:15) mattock: our internal Windows servers have SSH, but a Samba sh=
are might be ok as well
(13:25:25) mattock: I don't have any preferences tbh
(13:26:08) mattock: https://community.openvpn.net/openvpn/ticket/1141
(13:26:10) vpnHelper: Title: #1141 (Harden OpenVPN on Windows against gen=
eric DLL hijacking vulnerabilities) =E2=80=93 OpenVPN Community (at commu=
nity.openvpn.net)
(13:26:17) rozmansi: The Win32 tar.exe is not happy with those .tar.gz fi=
les as they contain symlinks.
(13:27:49) syzzer: what a mess...
(13:27:51) mattock: ah did not realize that
(13:28:02) syzzer: I'm still trying to figure out how to do the same for =
openvpn-nl
(13:28:13) mattock: syzzer: MSI or hardening?
(13:28:16) syzzer: both
(13:28:29) mattock: join forces?
(13:28:30) mattock: :P
(13:28:51) syzzer: but mostly "a good way to build decent-and-signed inst=
allers"
(13:28:52) mattock2 ha abbandonato la stanza (quit: Quit: IRC for Sailfis=
h 0.9).
(13:30:16) syzzer: the thing for me is that I want to build all the binar=
ies (not installers), then go through QA and evaluation, then sign/build-=
installer/sign
(13:30:21) rozmansi: Anyway, as the PR for MSI packaging is done now, it =
expects to find OpenVPN binaries in ../generic/image-win(32|64)/... So, i=
f you just mount the openvpn-build directory where you built those binari=
es as a Samba share to make it available to a Windows box, you can packag=
e MSI inside openvpn-build/windows-msi folder.
(13:30:49) mattock: rozmansi: I will check your PR
(13:31:05) syzzer: that sounds reasonable, that way I should be able to j=
ust have a "signing VM"
(13:31:22) rozmansi: Great. Feel fre, to let me know, how can I make it a=
s easy to use for you as possible.
(13:32:14) mattock: rozmansi: ok so the PR is big - I won't do the review=
 in the meeting then :P
(13:32:19) mattock: will have a look after
(13:32:32) rozmansi: :) sure
(13:32:41) mattock: immediately so that I do not forget
(13:32:57) mattock: regarding DLL hijacking thing
(13:33:02) rozmansi: (perhaps I am only too nervous - putting my newborn =
child into evaluation)
(13:33:16) mattock: do we actually have to stop giving people the option =
to install OpenVPN in directory <n> to fix the problem?
(13:33:53) mattock: pardon my ignorance: evaluation?
(13:35:59) syzzer: mattock1: don't worry, that's my problem for -nl ;)
(13:36:33) rozmansi: You can't hardcode "C:\WINDOWS\system32\fwpuclnt.dll=
" into your binaries, as the recommended fix says.
(13:36:55) rozmansi: What if somebody has Windows installed on D:\Windows=
?
(13:37:22) mattock: yeah
(13:37:43) mattock: anyways, it is a mess
(13:37:54) mattock: thanks Microsoft
(13:38:05) mattock: but we can look at it later
(13:38:15) mattock: I will review rozmansi's mega-PR
(13:38:15) syzzer: for now I'll just keep following the discussions and l=
eave you to it
(13:38:23) syzzer: is there something we need to discuss now?
(13:38:30) ***syzzer is getting hungry ;-)
(13:38:45) mattock: we also need to get rozmansi's patches to openvpn in =
before merging the openvpn-build PR (https://github.com/OpenVPN/openvpn-b=
uild/pull/141/files)
(13:38:47) vpnHelper: Title: Windows MSI Packaging by rozmansi =C2=B7 Pul=
l Request #141 =C2=B7 OpenVPN/openvpn-build =C2=B7 GitHub (at github.com)=

(13:38:52) mattock: I'm good for today
(13:38:55) rozmansi: My personal oppinion: if an attacker already has adm=
in privileges, he could just as well replace the openvpn.exe with his own=
 version. So hardcoding DLL paths is pointless.
(13:39:57) mattock: maybe this had to do with fooling some antivirus prog=
rams, but even in that case the benefits of "fixing" this are not big
(13:40:05) mattock: plus it ends up being a management mess probably
(13:41:47) mattock: actually, the use of DLLs was to work around the sign=
ature in openvpn.exe
(13:42:08) mattock: so when launching openvpn.exe the signature would sti=
ll be valid ("all is good")
(13:42:17) mattock: anyways, adding this to the trac ticket
(13:42:24) mattock: let's call this a day unless somebody has something
(13:42:30) ordex: not me
(13:42:38) ordex: just...ipv6!
(13:43:15) cron2: ipv6!
(13:43:52) syzzer: ?
(13:44:01) cron2: no idea what he's talking about it
(13:44:28) mattock: end of meeting then
(13:44:29) mattock: :P
(13:45:31) syzzer: hehe, thanks. ttyl :)
(13:45:46) cron2: *wave*
(13:46:39) rozmansi: bye
(13:46:47) rozmansi ha abbandonato la stanza.

--------------C40525978E08900B5F7CD6FC--

