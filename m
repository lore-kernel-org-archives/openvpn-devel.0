Date: Mon, 28 Dec 2015 23:33:49 +0200
From: Samuli =?ISO-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Message-Id: <20151228233349.7038d74f697871f66de61144@...515...>
In-Reply-To: <20151228100404.176a540305d85a7d3e2a2107@...515...>
References: <20151228100404.176a540305d85a7d3e2a2107@...515...>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Mon__28_Dec_2015_23_33_49_+0200_WMw=VYIFlGOcnwGr"
Subject: [Openvpn-devel] Summary of today's (28th Dec 2015) IRC meeting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?ISO-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--Multipart=_Mon__28_Dec_2015_23_33_49_+0200_WMw=VYIFlGOcnwGr
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

Here's the summary of today's IRC meeting.

- ---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Monday 28th Dec 2015
Time: 20:00 CET (19:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2015-12-28>

The next meeting (patch review sprint) has been scheduled to two weeks from=
 now.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, gava100, Guest37887, jamesyonan, mattock, plaisthos, syzzer and vald=
ikss participated in this meeting.

- ---

Discussed the open pull requests in the OpenVPN-GUI subproject:

<https://github.com/OpenVPN/openvpn-gui/pulls>

Both will be handled / are being handled by mattock.

- --

Discussed "AEAD (GCM) mode" and how to move forward with it. The AEAD part =
can probably be merged after some more tests, but the negotiation part requ=
ires more work to ensure correctness.

- --

Discussed tap-windows6 driver and Windows 10. It was noted that new driver =
signing requirements require us to obtain an EV code signing certificate, a=
s well as to use "Windows Hardware Developer Center Dashboard" to sign the =
drivers. Mattock is moving this forward at the company side.

- --

Discussed the OpenVPN 2.3.10 release. IPv6 support for Windows XP is broken=
 right now, and we want to implement a fix which lev is working on. It was =
agreed to release 2.3.10 on 4th or 5th Jan 2016. A separate release meeting=
 will not be arranged unless deemed necessary.

- --

Discussed open tickets related to the Windows Installer:

<https://community.openvpn.net/openvpn/ticket/638>
<https://community.openvpn.net/openvpn/ticket/632>

Mattock will handle the first two in one go to save some context switches. =
Customizing openvpn.nsi in openvpn-build for Windows XP will be avoided at =
all cost.

- --

Discussed a rather nasty tap-windows6 + Windows 10 issue:

<https://community.openvpn.net/openvpn/ticket/592>

This ticket is blocked by lack the capability to (re)build tap-windows6 for=
 Windows 10(see above).

- --

Discussed our patch review rate. It was agreed that we can't review patches=
 as fast as they come. Large patchsets in particular tend to get bogged dow=
n. We'll try having patch review sprints in addition to regular meetings to=
 speed things up. These sprints would include only patch review and nothing=
 else. Larger patchsets could have dedicated sprints.

The first sprint will be arranged on Monday two weeks from now, unless some=
thing requires a change in this plan.

- ---

Full chatlog has been attached to this email.

- --=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlaBqr0ACgkQwp2X7RmNIqOxqACgs+lBmKwfgu0TrxgOv58Bhpn+
ZwYAoIO8xhNtKmbNXX3b0jwwOeF6QcBH
=3DHYyY
-----END PGP SIGNATURE-----

--Multipart=_Mon__28_Dec_2015_23_33_49_+0200_WMw=VYIFlGOcnwGr
Content-Type: text/plain;
 name="openvpn_irc_meeting_chatlog_2015-12-28.txt"
Content-Disposition: attachment;
	filename="openvpn_irc_meeting_chatlog_2015-12-28.txt"
Content-Transfer-Encoding: quoted-printable

(21:04:35) samuli: hi!
(21:04:44) samuli: topic list: https://community.openvpn.net/openvpn/wiki/T=
opics-2015-12-28
(21:04:46) vpnHelper: Title: Topics-2015-12-28 =E2=80=93 OpenVPN Community =
(at community.openvpn.net)
(21:05:50) samuli: cron2 said he'll be a bit late
(21:06:25) samuli: we can skip the openvpn-gui pull request for now: https:=
//github.com/OpenVPN/openvpn-gui/pull/8
(21:06:27) vpnHelper: Title: cppcheck cleanup: by chipitsine =C2=B7 Pull Re=
quest #8 =C2=B7 OpenVPN/openvpn-gui =C2=B7 GitHub (at github.com)
(21:06:36) samuli: once I get the tarball, I can do a test build and merge
(21:07:28) syzzer: hi :)
(21:07:34) samuli: hi!
(21:07:46) syzzer: forgot to check this channel :')
(21:08:33) syzzer: anyone else here but mattock_ and me?
(21:08:51) samuli: jamesyonan should be here
(21:08:59) samuli: as in "not just idling"
(21:09:13) syzzer: ah, good
(21:09:14) samuli: any idea what tickets topic #3 refers to?
(21:09:40) jamesyonan: hi guys
(21:09:43) samuli: "Windows Installer - open trac tickets"
(21:09:43) syzzer: the 'run as admin' stuff perhaps? (or did you already fi=
x that?)_
(21:09:47) samuli: hi jamesyonan!
(21:09:54) syzzer: hi james
(21:09:58) samuli: syzzer: no, didn't have time yet
(21:10:15) samuli: maybe we should start with #4: AEAD (GCM) mode - the way=
 forward=20
(21:10:28) syzzer: yes, that makes sense
(21:11:16) syzzer: so I have fiddled a bit more with my AEAD implementation=
, and have been looking into cipher negotiation
(21:12:20) syzzer: I have a trivial server-side implementation that just pu=
shes the server cipher when a client announces 'IV_NCP' capabilties
(21:14:49) syzzer: real negotiation is more tricky.  I got the negotiation =
itself going, but still need to figure out how to figure out the correct fr=
ame sizes etc (in a nice way)
(21:15:26) syzzer: the current code assumes to know a lot of that stuff bef=
orehand
(21:15:54) jamesyonan: as I recall, when implementing this in ovpn 3, it wa=
s tricky to dynamically change the cipher/mac based on a push from server
(21:16:12) syzzer: jamesyonan: yes, this is quite tricky in 2 too
(21:16:24) plaisthos [~arne@...1423.../community/developer/plaisthos] =C3=A8 e=
ntrato nella stanza.
(21:16:34) plaisthos: hi
(21:16:39) plaisthos: no sports between years :0
(21:16:52) syzzer: jamesyonan: are there any ovpn3 clients available that i=
mplement NCP?
(21:16:59) syzzer: hi plaisthos :)
(21:17:22) jamesyonan: yes, the latest ovpn3 clients support NCP
(21:17:23) syzzer: jamesyonan: I would like to test them against my 'trival=
 negotiation server'
(21:18:00) syzzer: ah, cool, will try that
(21:18:38) syzzer: when all that succeeds, I would like to suggest merging =
the AEAD-part while I continue on the negotiation
(21:18:53) syzzer: after the usual review etc, ofc
(21:19:29) syzzer: but I guess we need Gert when discussing that...
(21:20:03) samuli: let's see what else we have
(21:20:14) syzzer: jamesyonan: in the mean while, any news on a tap-windows=
6 fix?
(21:20:27) samuli: oh yes that one, good catch
(21:20:40) ***cron2 is here now (sorry)
(21:20:45) samuli: hi cron2!
(21:21:25) jamesyonan: you mean tap-windows6 buffer overflow?
(21:21:29) syzzer: yes
(21:22:47) jamesyonan: it should be fairly easy to fix, but there's a probl=
em in that Windows 10 won't accept new TAP driver builds unless we go throu=
gh a new process with Microsoft
(21:23:11) syzzer: yeah, the extended validation certificates, right?
(21:23:56) samuli: yes
(21:24:07) jamesyonan: yeah, I haven't really looked at it yet, but from wh=
at I understand, only driver builds signed before the Windows 10 release wi=
ll function without it
(21:24:09) samuli: plus I believe they require submitting the driver to som=
e portal for signing
(21:24:38) syzzer: yes, the "Windows Hardware Developer Center Dashboard"
(21:24:52) syzzer: I also still have to figure out how to do that (and what=
 it will cost us...)
(21:24:54) gava100 [~gava100@...2109...] =C3=A8 entrato ne=
lla stanza.
(21:25:07) samuli: the EV certs are fortunately not horribly expensive
(21:25:19) samuli: something like $400/year or so
(21:25:59) cron2: is that just for drivers, or any windows binary?
(21:26:22) syzzer: just kernel drivers
(21:28:04) samuli: yeah
(21:29:50) syzzer: "Additionally, as an extra measure of security, all subm=
itted files must be signed using the same codesigning certificate."   grmbl=
, I want to use separate keys for our products as threat mitigation :/
(21:30:27) cron2: so submit separate bundles?
(21:30:28) syzzer: meh, we'll see
(21:32:11) syzzer: for ovpn corp this probably isn't an issue
(21:33:02) samuli: yeah, not likely
(21:33:16) syzzer: but, now that we have cron2 here, let's see if we can wr=
ap up 4. then
(21:33:52) cron2: I've read the backlog - "sounds good, go for it" :-)
(21:33:53) syzzer: I will test my implementation against ovpn 3, and sugges=
t to start the review-and-merge process for AEAD modes if that succeeds
(21:34:20) syzzer: ok, one item down!
(21:34:21) cron2: jamesyonan: is the AEAD stuff in the released iOS client,=
 or just Android?
(21:34:34) jamesyonan: just android right now
(21:35:14) cron2: (side note:  my nexus 7 decided to die on me, and google =
is not making new n7 anymore... just n6 phones or n9 tables... *grumble*)
(21:35:24) plaisthos: :(
(21:35:41) plaisthos: yeah, I have no good idea what new tablet to get
(21:35:53) cron2: it works while connected to USB power, and resets upon un=
plugging... something with power is fishy (and has been for a while, but it=
 got worse)
(21:36:08) cron2: anyway.  Will test on Simone's phone then :)
(21:37:15) cron2: mattock_: regarding (1) - is this just a single open pull=
 request, or is stuff piling up?
(21:37:21) samuli: just one
(21:37:43) samuli: Selva's PR is there also, but that will need test instal=
lers
(21:37:49) samuli: which I will create soonish
(21:37:51) cron2: yeah...
(21:38:23) cron2: but complaining so much about a single pull request... he=
 should look into our trac... :-) - but that's good, (1) done
(21:39:38) samuli: #2 next?
(21:39:41) samuli: 2.3.10
(21:39:45) cron2: right
(21:40:15) cron2: I'm sort of hoping to hear from valdikss, selva or lev on=
 this...=20
(21:40:46) cron2: "our" main intention was polarssl 1.3 support - and that =
is in, including cert expiry warning, so I'm good :-) - but I want IPv6 to =
work on XP as well...
(21:41:18) samuli: I wonder when the "pain to support Windows XP" rises abo=
ve the vaguely determined threshold :D
(21:41:29) cron2: not yet
(21:42:25) syzzer: this was actually *broken* by a commit a while ago
(21:42:44) syzzer: so should be doable to fix again, right?
(21:42:50) cron2: indeed, and the fix is actually not that complicated - I =
just decided that I want to do other things that need to be done first
(21:43:25) cron2: syzzer: yes, proposed way to tackle this already sent to =
lev and valdikss (and continued on the list, my mail is fully quoted on lev=
's)
(21:44:09) cron2: I would prefer not to have to do another if() in there, b=
ut it's not an #ifdef at least :-) - and it's 2.3 only
(21:44:26) samuli: breaking things on XP doubles as a way to check if anyon=
e is using XP
(21:44:30) samuli: if yes -> complaints
(21:44:37) samuli: and we did get complaints
(21:44:45) cron2: valdikss has users on xp, and he got complaints :)
(21:45:18) cron2: ok, setting that aside - what do you think wrt 2.3.10 rel=
ease?  ASAP, delay (and tell users to just use 2.3.8 instead, which is good=
 enough for the time being)?
(21:45:26) samuli: yeah, and ltfish also wanted to keep XP support actively
(21:45:47) cron2: mattock_: how's your scheduling?
(21:45:58) samuli: I'd say "first week of 2016"
(21:46:20) samuli: like 4th or 5th
(21:46:50) samuli: mon/tue
(21:46:57) samuli: does that sound reasonable?
(21:46:58) cron2: works for me.  syzzer?
(21:47:04) syzzer: yeah, fine with me
(21:47:36) cron2: ok, let's do that, and I'll try to poke valdikss/lev to g=
et the fix in :-)
(21:48:19) syzzer: wow, patch review already!
(21:49:06) cron2: did you cover (3) already?
(21:49:26) gava100 ha abbandonato la stanza (quit: Ping timeout: 276 second=
s).
(21:49:37) samuli: cron2: not really, because we did not know what that ref=
erred to exactly
(21:50:25) cron2: there's a number of open trac tickets and I wondered how =
we can help you with them, if at all
(21:52:12) samuli: this should be a fairly complete list of Windows issues:
(21:52:12) samuli: https://community.openvpn.net/openvpn/query?status=3Dacc=
epted&status=3Dassigned&status=3Dnew&status=3Dreopened&component=3DWindows+=
GUI&or&component=3D&or&component=3DInstallation&col=3Did&col=3Dsummary&col=
=3Dstatus&col=3Dtype&col=3Dpriority&col=3Dmilestone&col=3Dcomponent&order=
=3Dpriority
(21:52:15) vpnHelper: Title: Custom Query =E2=80=93 OpenVPN Community (at c=
ommunity.openvpn.net)
(21:52:21) cron2: #638, #632, #592
(21:53:27) cron2: actually I wasn't thinking about *Gui* tickets :)
(21:54:03) samuli: https://community.openvpn.net/openvpn/ticket/638
(21:54:03) samuli: https://community.openvpn.net/openvpn/ticket/632
(21:54:03) samuli: https://community.openvpn.net/openvpn/ticket/592
(21:54:04) vpnHelper: Title: #638 (64 bit installer will not uninstall 32bi=
t previous version) =E2=80=93 OpenVPN Community (at community.openvpn.net)
(21:54:05) vpnHelper: Title: #632 (I60x installers should warn (or refuse c=
ooperation) on XP) =E2=80=93 OpenVPN Community (at community.openvpn.net)
(21:54:06) samuli: for convenience
(21:54:07) vpnHelper: Title: #592 (Tap-Windows Adapter not work Windows 10)=
 =E2=80=93 OpenVPN Community (at community.openvpn.net)
(21:55:18) samuli: regarding "64 bit installer will not uninstall 32bit pre=
vious version"... 64-bit Windows has two registries (32-bit and 64-bit)
(21:56:12) samuli: is there a valid use-case for having a 32-bit openvpn in=
stalled alongside a 64-bit version?
(21:56:43) samuli: as long as the two versions are installed in two differe=
nt directories they should not overlap at all
(21:57:19) samuli: except that Windows program associations and such would =
be pointed to the latest installed version
(21:57:42) cron2: well... there is that, and there is a GUI which all of a =
sudden will no longer find existing profiles...
(21:57:53) samuli: ah yes, that is an issue
(21:58:12) cron2: it does not *break* the existing 32 bit installation, but=
 the result is highly confusing - "been there done that" :)
(21:58:13) samuli: the easiest fix would be to warn the user about the situ=
ation
(21:58:22) samuli: or stop the installation
(21:58:40) samuli: full cleanup of 32-bit and 64-bit installations is a bit=
 more involved
(21:59:35) cron2: if that is complicated, just having a "there is a <wrongb=
itorder> openvpn version already installed which cannot be uninstalled auto=
matically.  you have been warned!  <abort> <ignore and go on>" would be fine
(21:59:53) cron2: or just "<ok, close>"
(21:59:58) samuli: that would definitely be easiest
(22:00:19) samuli: and probably a warning would have to be printed anyways,=
 before wiping the 32-bit installation
(22:00:43) cron2: well, there is an uninstaller, so just pointing users the=
re should be fine
(22:00:47) samuli: yeah
(22:00:57) samuli: let's do a warning
(22:02:42) cron2: everyone else already asleep... :-) - so, #632?
(22:03:29) samuli: uh
(22:04:34) samuli: so now the I60x installers _do_ work on XP, except that =
tap-windows6 does not
(22:04:58) cron2: right, that assumption was overtaken by reality
(22:05:27) samuli: fixing any of these is not that big a deal, but it's nic=
er to group stuff and do them on one go
(22:06:08) cron2: openvpn.exe is good, tap-windows6 just failed (... for th=
e colleague who tried it, didn't see this myself)
(22:06:23) samuli: I'll check if I can detect the tap-windows driver versio=
n from within the installer
(22:06:30) samuli: if I can, then fixing this is a few lines of code
(22:07:07) cron2: so you keep a common NSIS script for all installers - cer=
tainly easier to maintain, right
(22:07:48) samuli: yeah, I don't want to support many openvpn.nsi scripts i=
f that can be avoided
(22:08:14) cron2: ok, next.  The big and hairy one, #592
(22:09:57) samuli: I need to dig into #632 later
(22:12:01) samuli: for #592 we probably need the EV certs and the portal ac=
count
(22:12:21) samuli: in case we need to fix something in tap-windows6
(22:12:39) cron2: well, we actually *do* need to fix something there :-( - =
so right...
(22:12:48) samuli: I will poke our internal mailing list a bit more
(22:12:56) samuli: I've slowly built up pressure there :P
(22:13:02) cron2: hehe :)
(22:13:42) cron2: but it seems some other folks are building products on ta=
p-windows6 (based on the comments) so maybe one of them might be willing to=
 help more, or shell out money to get external consultancy involved...
(22:16:32) samuli: I haven't had a look at the latest comments, just a sec
(22:16:46) syzzer: wow, lots of text there...
(22:19:11) samuli: I'll ask the Private Tunnel guys if they've had this iss=
ue
(22:19:42) cron2: that would certainly add some understanding on the scope.=
..
(22:19:49) cron2: what is PT using to install the driver?
(22:20:46) samuli: the same thing as we are afaik
(22:21:17) samuli: but I think they do a deinstall -> install using devcon.=
exe instead of "update" like we do
(22:21:23) samuli: not sure if that is related in any way
(22:24:58) cron2: so... postpone until you have feedback from PT, and we pr=
oceed to (5)?
(22:25:06) samuli: yeah
(22:25:18) samuli: I'm talking about that right now with them
(22:25:24) cron2: ah :)
(22:25:26) samuli: so patch review
(22:25:37) cron2: plaisthos: still around?
(22:38:58) samuli: apparently no?
(22:39:13) samuli: syzzer and jamesyonan are probably still here
(22:39:30) syzzer: yes, I am
(22:39:41) jamesyonan: I have to run in a few minutes
(22:39:49) ***cron2 has dazo's patches high on his to-be-reviewed list... b=
ut family got in the way
(22:39:49) samuli: anything quick we could cover?
(22:39:53) syzzer: trying to figure out how I get as much logging as possib=
le from the openvpn client :p
(22:40:00) cron2: syzzer: --verb 99 ?
(22:40:14) syzzer: the android one/
(22:40:36) syzzer: it says 'ignored options: --verb' (or something like tha=
t)
(22:40:54) cron2: jamesyonan: any advice? :)
(22:42:07) jamesyonan: the android client dumps more logging to the android=
 syslog
(22:42:24) jamesyonan: but there isn't anything like --verb at the moment
(22:42:46) syzzer: ah, ok
(22:42:51) plaisthos: cron2: yes
(22:43:00) syzzer: time to pull out adb again - has been a while
(22:43:29) cron2: plaisthos: two things - --push-remove and compress v2 - t=
he latter has seen review from syzzer...
(22:43:39) plaisthos: jamesyonan: doesn't the ovpn3 implementation have als=
o a minimal cli client?
(22:43:59) plaisthos: cron2: ACK, if you document it probably
(22:44:34) plaisthos: on compresss v2 I seem to have forgotten to send the =
v2 v2 patch
(22:44:36) cron2: plaisthos: v2 has documentation plus the gc_arena fix
(22:44:37) jamesyonan: yes, it does
(22:47:09) gava100 [~gava100@...2110...] =C3=A8 entrato nella stanza.
(22:48:28) cron2: mattock_: the most recent versions of dazo's patches are =
from August 11, right?
(22:48:58) gava100: Hello guys, I just missed the beginning of the meeting.=
 So about the NAT patch, any update?
(22:53:25) samuli: jamesyonan: have you had time to review gava100's patch?
(22:53:41) samuli: I emailed about that earlier
(22:53:48) samuli: cron2: I have absolutely no clue, could be
(22:54:07) cron2: I'll go and review *that*, then :-)
(22:54:53) gava100: ahahaha...
(22:55:15) gava100: please, just review this patch: this http://article.gma=
ne.org/gmane.network.openvpn.devel/10420
(22:55:16) vpnHelper: Title: Gmane -- PATCH Added client ip option to NAT (=
at article.gmane.org)
(22:55:27) cron2: gava100: we have not been very good in reviews - read: no=
t much has happened since two weeks ago
(22:55:58) cron2: the question about the patch version was regarding dazo's=
 to-be-reviewed set (which is "under discussion" since 1.5 years now :( )
(22:56:39) gava100: No problem, I understand.
(22:57:45) samuli:  gava100: so "Added two feature to Network Address Trans=
lator" no longer requires review as a whole?
(22:57:58) samuli: just the client-ip option
(22:57:59) samuli: ?
(22:58:50) samuli: I'm wondering if we should occasionally have patch revie=
w sprints with a predefined set of patches to review
(22:59:18) samuli: basically a meeting, but with no other topics but patch =
review
(22:59:26) samuli: and no requirements to get this and that done before the=
 sprint
(23:00:31) gava100: I think so. The NAT FTP is a complex changes and demand=
s buffer resize and it's mainly useful for windows. So, I was wondering if =
you guys can consider just the client-ip feature.
(23:00:52) samuli: I believe that part was agreed to make sense
(23:01:00) samuli: in an earlier meeting
(23:01:06) samuli: so we'd just need to review the patch
(23:01:29) cron2: mattock_: it might work, or not.  patch review is funny. =
 Sometimes we see a flurry of activity "out of the blue" on the list or her=
e, and sometimes we just can't find enough brains
(23:02:20) cron2: and sometimes we do get review, and the original proposer=
 went fishing in the meantime and we never get a followup patch... (NTLM AU=
TH, some of the stuff andj sent recently...)
(23:02:43) samuli: yep
(23:02:48) cron2: but we could try that
(23:02:56) samuli: it just seems that we never ever get as far as Trac tick=
ets
(23:02:56) cron2: worked well for the fish patches
(23:03:16) gava100: I like the idea of having a meeting just for patch revi=
ew.
(23:03:26) samuli: and large patchsets tend to get bogged down for extended=
 periods
(23:03:31) samuli: they'd need dedicated meetings I think
(23:03:42) samuli: unless we find time to review the patches on ml
(23:04:19) cron2: and of course there's endless trac tickets that need work=
...
(23:04:26) samuli: yeah, exactly
(23:04:34) ***cron2 is very tired today :)
(23:04:51) samuli: so much work, so little time and people
(23:05:07) samuli: I guess we just have to choose which balls to drop and w=
hen :P
(23:05:11) gava100: how we can help? :-)
(23:05:24) samuli: maybe help with patch review?
(23:05:37) samuli: except your own patchset, those somebody else has to rev=
iew :P
(23:06:48) cron2: gava100: patch review has two aspects to it, "feature ACK=
" and "technical ACK" - feature ACK is sometimes complicated (we need agree=
ment whether the balance of new code to maintain vs. usefulness of the new =
feature is positive)
(23:07:17) samuli: and oftentimes the feature-ACK can be given by a non-dev=
eloper
(23:07:19) cron2: but technical ACK is actually something that helping with=
 is easier - review the code
(23:07:41) samuli: feature-ACK ~ "does the feature make sense to have"
(23:07:47) cron2: see that it doesn't lose memory, matches the overall styl=
e, etc.
(23:08:12) cron2: mattock_: sometimes also taking "... or is it too expensi=
ve to implement and maintain" into account
(23:08:27) samuli: yeah
(23:08:40) cron2: technical ACK is easier
(23:08:57) cron2: like "there's an unused gc_arena here" :-) (*selfslap*)
(23:09:46) gava100: Ok, understood. Well, I can try. I don't know the whole=
 code but it's a good opportunity to start.
(23:10:45) samuli: gava100: great!
(23:11:04) samuli: we have some documentation on Trac: https://community.op=
envpn.net
(23:11:05) vpnHelper: Title: OpenVPN Community (at community.openvpn.net)
(23:11:36) samuli: https://community.openvpn.net/openvpn/wiki/DeveloperDocu=
mentation
(23:11:38) vpnHelper: Title: DeveloperDocumentation =E2=80=93 OpenVPN Commu=
nity (at community.openvpn.net)
(23:11:55) cron2: gava100: well, I think there is nobody who really knows *=
all* of the code today - it's quite a bit of different specialities (platfo=
rm support, crypto, networking)
(23:12:14) syzzer: wha, victory! ovpn3 talks to my server (worked all along=
, I just needed to push routes for it to work... :/ )
(23:12:29) cron2: syzzer: with AEAD and COMP_V2?
(23:12:34) syzzer: yes
(23:12:41) cron2: wheee! \o/
(23:12:51) syzzer: and 'trivial server side negotiation'
(23:12:53) samuli: gava100: the DeveloperDocumentation article seems fairly=
 up-to-date
(23:12:58) cron2: the part about "just neede to push routes" is a bit of *l=
ol* :-)
(23:13:11) Guest37887: We are the users of Gava's NAT patch. If we can help=
 provide insight into the feature use, we're available (lurking as guest).
(23:13:21) syzzer: yeah, 'ip r' on my device said routes were just fine
(23:13:38) plaisthos: syzzer: so you reviewed comp_v2 because you needed it=
? :)
(23:13:40) syzzer: but until I added a 'redirect-gateway' simply no packets=
 arrived on my server...
(23:13:46) cron2: android client?  they do VPN by policy routing...
(23:13:50) samuli: Guest37997: ok, sounds good
(23:14:05) syzzer: plaisthos: well, it worked for my purposes, but ovpn3 su=
pport needs it :)
(23:14:06) samuli: I hope we get the client-ip part reviewed Real Soon(tm)
(23:14:13) plaisthos: hehe
(23:14:34) syzzer: cron2: yes, android client
(23:14:39) syzzer: 5.1 or so
(23:14:53) cron2: policy routing, so "ip r" will just not tell you where yo=
ur packets go
(23:14:54) gava100: mattock_: Ok, I'll read the documentation. Just another=
 question. Do you guys keep all the patches to review on trac? How do you m=
anage them?
(23:15:08) samuli: gava100: no, we don't have them on Trac
(23:15:18) samuli: currently we use the openvpn-devel mailing list exclusiv=
ely
(23:15:32) samuli: except that unreviewed patches tend to end up into meeti=
ng agendas
(23:15:40) samuli: and kept there, until they've been reviewed
(23:15:43) cron2: all patches go to the list, and we do have a list of "ope=
n patches on the list" in trac, which is sometimes well-maintained and some=
times not
(23:16:09) cron2: http://community.openvpn.net/openvpn/wiki/Patches
(23:16:10) vpnHelper: Title: Patches =E2=80=93 OpenVPN Community (at commun=
ity.openvpn.net)
(23:16:34) samuli: openvpn-build and openvpn-gui subprojects also allow pul=
l requests
(23:17:01) samuli: tap-windows6 patches - which are extremely rare - typica=
lly have to go through openvpn-devel ml
(23:17:41) samuli: shall we call this a day?
(23:17:45) samuli: it's getting late
(23:17:54) cron2: yes
(23:18:08) samuli: what about the first patch review sprint?
(23:18:10) syzzer: yep
(23:18:17) plaisthos: syzzer, cron2: ip r is not enough
(23:18:18) samuli: when and what and how long?
(23:18:28) plaisthos: you have to look also in the not standard tables etc.
(23:18:41) syzzer: in two weeks?
(23:18:58) samuli: yeah, actually we probably need a generic meeting next m=
onday for 2.3.10
(23:19:19) samuli: opinions?
(23:19:55) syzzer: plaisthos: ip r said '10.8.0.2/24 via tun0', so I assume=
d 'ping 10.8.0.1' should work.  stupid me :p
(23:20:16) syzzer: what's to discuss about 2.3.10 ?
(23:20:38) samuli: I don't know
(23:20:46) samuli: hopefully nothing :P
(23:20:57) samuli: just push it out after the last few things have been mer=
ged
(23:21:00) cron2: mattock_: what syzzer said :-) - let's wait for the windo=
ws team to show up or not, and then we just decide to tag+push and release =
during next monday daytime
(23:21:00) syzzer: I think it's just getting the xp fix and then pushing it=
 out, right/
(23:21:08) cron2: yes
(23:21:14) plaisthos: syzzer: on Android 5.x or 6.x the subnet of the vpn i=
s not included automatically anymore
(23:21:18) samuli: what did we require the windows team for?
(23:21:24) cron2: the xp fix
(23:21:29) samuli: ah yes
(23:21:32) plaisthos: My client adds an explicit route to the VPN network
(23:21:33) samuli: and was lev on this?
(23:21:42) plaisthos: don't know if James client does this too
(23:21:44) plaisthos: I doubt it
(23:21:45) cron2: lev broke it and I hope he'll find time to send a fix
(23:21:50) samuli: ok, sounds good
(23:22:04) syzzer: plaisthos: apparently not :p
(23:22:09) ValdikSS: Oh my, I overslept everything
(23:22:20) cron2: oh hi valdikss :)
(23:22:23) ValdikSS: Sorry guys
(23:22:30) gava100: about the patches, let me see how things go and for the=
 next meeting we discuss more about that.
(23:22:39) samuli: so first sprint in two weeks unless something happens
(23:22:49) cron2: mattock_: let's aim for +2 weeks, as usual, and do 2.3.10=
 in between without a meeting
(23:23:00) cron2: (unless something unexpected pops up)
(23:23:00) ValdikSS: So about XP fix, is there any real reason to use index=
es instead of interface names? Maybe we should just revert index patch?
(23:23:40) ValdikSS: It should be trivial to use interface names on XP and =
indexes on Vista+, but is there any real reason of this?
(23:23:42) cron2: ValdikSS: people tell us that interface names do not work=
 right if you have two tap adapters (not at all), and sometimes fail for no=
 obvious reason with a single tap adapter - remove, reinstall fixes stuff m=
agically
(23:24:03) ValdikSS: Hrmm, I see
(23:24:38) cron2: I'm actually in favour of numbers there as it avoids comp=
lications with non-ascii adapter names (people have funny ideas...) right a=
way
(23:24:49) cron2: and string length, and all that
(23:25:15) cron2: but if it fails XP... *sigh*
(23:29:11) samuli: I'll cut the meeting chatlog at this point
(23:29:18) samuli: summary is ready, sending it nowish

--Multipart=_Mon__28_Dec_2015_23_33_49_+0200_WMw=VYIFlGOcnwGr--

