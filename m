From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <ca74abaa-6dd7-a535-ff6d-ba4f6155bb08@...515...>
Message-ID: <a47f2d07-ecce-0362-311b-4ebb222f7698@...515...>
Date: Wed, 30 Nov 2016 23:09:45 +0200
MIME-Version: 1.0
In-Reply-To: <ca74abaa-6dd7-a535-ff6d-ba4f6155bb08@...515...>
Content-Type: multipart/mixed; boundary="------------0105907014902F51E58DD19A"
Subject: [Openvpn-devel] Summary of the today's (Wednesday,
	30th Nov 2016) community meeting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------0105907014902F51E58DD19A
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of today's IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 30th November 2016
Time: 20:00 CET (19:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2016-11-30>

The next meeting has been scheduled to a week from now (Wed 7th=20
December), at the same time as today.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron, dazo, mattock, selvanair and syzzer participated in this meeting.

---

Discussed the OpenVPN 2.4_rc1 release:

<https://community.openvpn.net/openvpn/wiki/StatusOfOpenvpn24>

Reprioritized and updated the tickets in Trac. The release schedule for=20
2.4_rc1 will be the following:

- Tarballs with correct version will be created by Thursday afternoon
- Smoketests will happen on Friday morning
- Git tagging and release will happen on Friday afternoon

--

Discussed the OpenVPN 2.3.14 release. Remaining patches will go in by=20
upcoming Tuesday, and the release will be made on the following Wednesday.

--

Organized a GPG key-signing party using video chat to improve the=20
trustworthiness of our signatures.

--

Full chatlog has been attached to this email.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------0105907014902F51E58DD19A
Content-Type: text/plain; charset=UTF-8;
	name="openvpn_irc_meeting_chatlog_2016-11-30.txt"
Content-Disposition: attachment;
	filename="openvpn_irc_meeting_chatlog_2016-11-30.txt"
Content-Transfer-Encoding: quoted-printable

(21:02:10) mattock: meeting time I believe
(21:02:23) cron2: righto
(21:02:39) dazo: I've unlocked https://appear.in/openvpn ... for the key-=
signing
(21:03:05) cron2: shall we do that first or at the end?
(21:03:49) ***syzzer votes end
(21:04:12) cron2: that's what I thought as well (which is why it ended up=
 at the end of the meeting agenda)
(21:04:12) syzzer: I'm trying to redo my gpg keys 'properly'
(21:04:13) dazo: I have no preferences
(21:04:31) cron2: so... anyone still interested in 2.4?  I feel a bit exh=
austed already :-)
(21:04:43) dazo: hehe :)
(21:05:02) dazo: I think 2.4_rc1 begins to be in a really good shape
(21:05:10) cron2: let me take a look at the bug list
(21:06:12) dazo: $ git shortlog v2.4_beta2..master
(21:06:12) dazo: Christian Hesse (1):
(21:06:12) dazo:       update year in copyright message
(21:06:12) dazo: Gert Doering (1):
(21:06:13) dazo:       Fix windows path in Changes.rst
(21:06:14) dazo: Selva Nair (3):
(21:06:15) dazo:       Map restart signals from event loop to SIGTERM dur=
ing exit-notification wait
(21:06:17) dazo:       When parsing '--setenv opt xx ..' make sure a thir=
d parameter is present
(21:06:19) dazo:       Force 'def1' method when --redirect-gateway is don=
e through service
(21:06:21) dazo: Steffan Karger (4):
(21:06:23) dazo:       tls_process: don't set variable that's never read
(21:06:25) dazo:       Unconditionally enable TLS_AGGREGATE_ACK
(21:06:29) dazo:       Clean up format_hex_ex()
(21:06:31) dazo:       Introduce and use secure_memzero() to erase secret=
s
(21:06:38) cron2: some people have been extremely busy last week
(21:06:56) selvanair: :)
(21:07:20) mattock: ok, finally: https://community.openvpn.net/openvpn/wi=
ki/Topics-2016-11-30
(21:07:21) dazo: :)
(21:07:22) vpnHelper: Title: Topics-2016-11-30 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:07:56) mattock: signing party appeared out of thin air :)
(21:08:31) mattock: any good links on how to sign somebody else's key?
(21:08:33) cron2: dazo and I chatted about that a few days ago
(21:08:47) cron2: let's do that when we reach 3.
(21:09:11) mattock: yeah
(21:09:21) cron2: trac #741 looks like it is done?
(21:09:24) cron2: (mattock)
(21:10:55) mattock: lets see
(21:11:06) mattock: indeed, I'll close it
(21:11:24) dazo: #751 can be closed, right syzzer ?
(21:11:43) mattock: done
(21:12:11) syzzer: dazo: yes
(21:12:14) syzzer: I'll close it
(21:12:18) ***dazo updates #751 with commit details
(21:12:22) cron2: I'm closing #615... that was a volunteer task "hey, ple=
ase go test this!" - which it wasn't, but with 2.4 release coming up, and=
 IPv6 being more of a reality nowadays, this WILL be tested :)
(21:13:21) cron2: "worksforme" is definitely the right category htere
(21:13:51) cron2: syzzer: #554 goes to 2.5?
(21:14:06) syzzer: cron2: yes
(21:14:36) syzzer: we might backport that to 2.4 at some point, but I don=
't have time to finish that one
(21:14:48) syzzer: not before 2.4 at least
(21:15:14) syzzer: The Great Reformatting will probably consume quite som=
e time...
(21:15:18) dazo: cron2: #755 ... that should be trivial?  strncmp(var, "2=
55.", 4) =3D=3D 0  -> msg(M_WARN, ...)  ... or did you have anything else=
 in mind?
(21:15:26) cron2: mattock: what is #153 about?  One of the 3 "alpha 2.4" =
tickets
(21:15:56) cron2: dazo: well... 255. is a legitimate part of an IP addres=
s
(21:15:58) mattock: #610 (https://community.openvpn.net/openvpn/ticket/61=
0) is "almost there" with just the documentation fixes missing
(21:16:00) vpnHelper: Title: #610 (document restrictions for 2.4 on windo=
ws) =E2=80=93 OpenVPN Community (at community.openvpn.net)
(21:16:02) cron2: 195.30.255.1
(21:16:09) cron2: oh
(21:16:18) cron2: 255. at front, yes, that is a giveaway
(21:16:46) dazo: I believe I can quickly prepare a patch for that
(21:17:04) cron2: dazo: yes, that would work.  It's fairly trivial, I was=
 just too tired to actually go coding last week
(21:17:12) mattock: cron2: regarding #153: I don't think that's important=
 enough to be "must have" for 2.4
(21:17:35) mattock: I would just move it to 2.5 - nobody has complained a=
bout it in the ticket, and it probably originates from one complaint way =
back when
(21:17:40) mattock: it's a "nice to have"
(21:18:16) cron2: mattock: so the benefit would be that you could run a n=
ormal cmd.exe, and when running tapinstall.exe you'd get an UAC prompt, a=
nd then it would work?
(21:19:02) cron2: what needs to be done to make it work?
(21:20:39) mattock: cron2: yes
(21:21:21) mattock: well, I think editing tapinstall.exe with some resour=
ce editor and adding a manifest file should do the trick
(21:21:36) selvanair: Add an external manifest if it doesnt have one
(21:21:54) cron2: that is a binary coming from microsoft, am I rememberin=
g right?
(21:22:14) mattock: yes, the code itself, but James somehow managed to bu=
ild it in the past
(21:22:29) mattock: devcon.exe originally, renamed to tapinstall.exe
(21:22:36) selvanair: I think its recompiled when tap driver is built as =
the microsoft devcon sources is patched by James -- recall reading somewh=
ere
(21:22:52) mattock: yes, something like that
(21:23:17) mattock: as the ticket said, I tried compiling it in various w=
ays, but did not have much luck
(21:23:42) mattock: anyways, the use-case for the manifests is basically =
people installing tap-windows6 drivers separately
(21:24:24) mattock: the installer probably fails in some mysterous way if=
 the user clicks it without using "Run as administrator"
(21:24:33) selvanair: Also for running addtap without remembering to open=
 a pivileged cmd shell
(21:24:46) mattock: good point
(21:24:49) mattock: although
(21:24:59) mattock: ignore me, you're correct
(21:25:13) mattock: then an external manifest would actually be an option
(21:25:30) mattock: the tap-windows _installer_ probably elevates privile=
ges correctly, but the tapinstall.exe contained within it does not
(21:25:47) selvanair: That sound steh easiest although if there is an int=
ernal manifest the external one may get ignored --- based on some setting=
s, I forget..
(21:25:47) mattock: modifying openvpn.nsi to include a .manifest file sho=
uld fix this
(21:25:59) mattock: oh
(21:26:23) mattock: we could try it, though
(21:26:27) selvanair: Worth trying..
(21:26:32) selvanair: yes
(21:26:47) mattock: still, I don't think this is a blocker for any 2.4.x =
release
(21:26:57) selvanair: This is for tapinstall.exe, right? not the nsis ins=
taller for TAP
(21:26:58) mattock: zero "I want this fixed" comments in the ticket
(21:27:15) mattock: yes, I believe this is for tapinstall.exe (a.k.a. dev=
con.exe)
(21:28:29) mattock: so which milestone for this one?
(21:29:23) cron2: 2.4.1 or 2.5...
(21:29:30) mattock: sounds good
(21:29:46) mattock: shall we move on?
(21:30:43) cron2: there's quite a few tickets left for "release 2.4", but=
 I'm not sure there is anything that would be a show-stopper (=3D MUST be=
 fixed before 2.4_rc1, aka "tomorrow")
(21:31:02) cron2: there is one thing that needs a decision today, and tha=
t is #775
(21:31:32) cron2: the actual code change is trivial and would nicely make=
 the release, just the "do we want to do what James does in 3 already?" n=
eeds a decision
(21:31:36) dazo: I agree with James here ... remove net stop/start dnscac=
he
(21:31:49) mattock: cron2: I suggest moving https://community.openvpn.net=
/openvpn/ticket/610 to milestone 2.4.0 (only documentation fixes left)
(21:31:51) vpnHelper: Title: #610 (document restrictions for 2.4 on windo=
ws) =E2=80=93 OpenVPN Community (at community.openvpn.net)
(21:32:08) cron2: ok
(21:32:47) cron2: (why does the reporter of this look familiar?)
(21:33:42) cron2: and yeah, most of what I was complaining about has been=
 solved in a really nice way with the new installers
(21:37:19) selvanair: Me too for  removing net stop/start dnscache . Its =
also teh easiest to implement -- just delete a couple of lines here and t=
here.=20
(21:38:01) mattock: better do this now than in 2.4.0
(21:38:09) mattock: in case there is some corner-case that breaks
(21:38:32) selvanair: mattock: posted a manifest to Trac: #153 -- unteste=
d
(21:38:45) mattock: selvanair: oh, that was quick
(21:39:05) selvanair: copy-paste, so please check :)
(21:39:22) mattock: I can probably multi-task and test it right away
(21:39:46) cron2: selvanair: do you want to bump your commit ratio furthe=
r?  (you're leading in 2.4_beta2 -> rc1 anyway)
(21:39:51) mattock: so dnscache goes out, but by whom?
(21:40:42) dazo: 2.4_rc1 is in my opinion that last chance to remove the =
net stop/start dnscache ... as it needs some testing before hitting final=
 release
(21:40:55) dazo: from rc to final release we *only* fix our important bug=
s
(21:40:58) cron2: it needs to go today :) - we were just waiting for the =
meeting to get a bit more feedback
(21:41:14) selvanair:=20
(21:41:23) dazo: So I have one patch which will be ready tonight ... and =
then this dnscache stuff
(21:42:04) dazo: and I'll have the 2.4_rc1 release tarballs ready by tomo=
rrow afternoon or so
(21:43:08) mattock: dazo: I can make the release on Friday (not sure abou=
t tomorrow)
(21:43:36) mattock: what if we do as we did earlier, and you provide me w=
ith the tarballs after you've edited version.m4
(21:43:45) dazo: mattock: great, that gives a bit more headroom ... we wa=
nt the git tree tagged and tarballs ready by tomorrow evening latest
(21:43:59) mattock: then I will smoketest the thing on Windows, and if ev=
erything works ok, then you can tag the release and push your version.m4 =
change
(21:44:00) dazo: works for me!
(21:44:08) mattock: smoketesting would happen on Fri
(21:44:22) cron2: +1
(21:44:48) cron2: (I won't have time or brains tomorrow or Fri anyway, so=
 I'll do the patches tonight or early morning tomorrow, and then dazo tak=
es over - worked well for beta2)
(21:45:10) syzzer: would be great if ordex' CRL patch would make it too
(21:45:25) syzzer: but we'll have to see if he's quick enough
(21:45:32) cron2: ordex =3D Antonio Quartul?
(21:45:32) dazo: cron2++
(21:45:37) dazo: yes
(21:46:33) cron2: so, anything else on 2.4?
(21:47:24) dazo: not from me
(21:48:13) syzzer: we should decide how to move forward with the indentin=
g stuff
(21:48:29) mattock: what about https://community.openvpn.net/openvpn/tick=
et/771
(21:48:30) vpnHelper: Title: #771 (Adding IPv6 routes may fail on Windows=
 if openvpn.exe has not been shut down gracefully) =E2=80=93 OpenVPN Comm=
unity (at community.openvpn.net)
(21:48:31) selvanair: mattock: the manifest doesn't work -- I'll investig=
ate tonight.
(21:48:36) mattock: selvanair: ok
(21:48:41) syzzer: it's going to take some time to get it all done, so I =
think we should start soon
(21:48:48) cron2: mattock: I was ignoring you
(21:48:54) cron2: :)
(21:49:01) mattock: yes, because it's roughly your territory :)
(21:49:13) selvanair: cron2: ok, I can do the honors of gutting 'net stop=
 dnscache'
(21:49:27) dazo: syzzer: We have schedules the re-indent for the rc2 rele=
ase ... and I'm willing to help out here
(21:49:29) cron2: (I saw the ticket but decided that I do not want to thi=
nk about it right now - it is robust enough if you use the iservice, or d=
o not force-kill programs)
(21:49:40) mattock: could somebody forward me the meeting invitation (my =
thunderbird crashed when I sent it)
(21:49:44) cron2: dazo, syzzer: count me in.  We have two weeks, this sho=
uld be doable.
(21:49:52) mattock: I'd like to respond to it with the correct message ID=
 (for the summary)
(21:49:54) dazo: oh, I'm wrong ... we planned it for rc1
(21:50:05) cron2: mattock: I'm not sure if I received one
(21:50:09) dazo: (or *I* planned it) ... but now I think it makes sense t=
o have it in rc2
(21:50:11) syzzer: dazo: "between rc1 and rc2"
(21:50:18) mattock: cron2: I think you said you received it
(21:50:21) mattock: or somebody else did
(21:50:25) cron2: dazo: I read the "happens here" as "... after rc1"
(21:50:27) mattock: or else nobody knows about the meeting :D
(21:50:50) dazo: cron2: I accept that interpretation :)
(21:50:57) cron2: mattock: not today, but I assumed we stick to the sched=
ule
(21:51:08) cron2: selvanair: thanks :-)
(21:51:44) selvanair: mattock: I too got no email abt today's meeting ?
(21:51:45) cron2: (oh, syzzer is leading commit count since 2.4_beta2 now=
, but selva will draw even with another commit...)
(21:52:04) selvanair: cron2: then I'll pss :)
(21:52:08) selvanair: pass
(21:52:26) cron2: huh, why? ;-)
(21:52:31) mattock: selvanair: I think the email went nowhere, as it's no=
t in the archives
(21:52:39) mattock: will have to do without
(21:53:12) dazo: mattock: I've not seen any invitation=20
(21:53:51) dazo: but it was mentioned last meeting we would have a meetin=
g today ... and it shouldn't come as a surprise we have frequent meetings=
 in this release phase
(21:53:59) mattock: yep
(21:56:32) mattock: so https://community.openvpn.net/openvpn/ticket/771 i=
s marked with "RC 2.4"
(21:56:34) vpnHelper: Title: #771 (Adding IPv6 routes may fail on Windows=
 if openvpn.exe has not been shut down gracefully) =E2=80=93 OpenVPN Comm=
unity (at community.openvpn.net)
(21:56:45) mattock: (hopefullly I'm not repeating myself too much :) )
(21:57:09) cron2: mattock: bump to 2.4.1?
(21:57:54) mattock: I could probably commit to debugging this for 2.4_rc2
(21:58:00) mattock: then the fix could go into 2.4.0
(21:58:13) mattock: basically just get the netsh command-line that fails,=
 and see if that can be worked around
(21:58:23) mattock: then the code changes should  be trivial
(21:58:25) cron2: you could start posting a log file where it went wrong =
:-) - I don't do tracs without logs
(21:58:35) dazo: is this a regression from 2.3?
(21:58:43) mattock: dazo: not afaik
(21:58:45) dazo: mattock: ^^^ (ticket #771)
(21:58:46) cron2: but if it's really a *different* network that you try t=
o install, I wonder why it should care
(21:58:54) dazo: then we will let it pass to 2.4.1 or 2.5
(21:59:13) cron2: dazo: no, that code never changed - if you whack openvp=
n.exe hard enough so it cannot cleanup, things get funny
(21:59:38) mattock: dazo: I would be fine with that, as the bug requires =
quite special preparations to materialize
(21:59:41) dazo: good ... then it is definitely not rc2 material
(21:59:50) mattock: in normal circumstances it will be difficult to repro=
duce I believe
(21:59:54) ***cron2 points at 20:57 < cron2> mattock: bump to 2.4.1?" :)
(22:00:02) dazo: cron2++
(22:00:03) mattock: fine by me
(22:00:29) dazo: I'm going to be really nasty about what we will put into=
 rc2 ;-)
(22:01:12) mattock: done
(22:01:32) mattock: so anything left to talk about regarding 2.4_rc1?
(22:01:50) dazo: don't think so
(22:02:20) mattock: good :)
(22:03:14) ***dazo brb
(22:03:20) mattock: so patches ready tomorrow afternoon, smoketests (with=
out tagging) on Friday morning (CET/EEST), release on Fri afternoon
(22:03:43) selvanair: mattock: waht abt the installer -- is the active se=
tup thing going to get in 2.4_rc1?
(22:03:59) mattock: selvanair: did you notice my comment in GitHub?
(22:04:12) selvanair: I replied about bitness
(22:04:18) mattock: let's see
(22:04:39) selvanair: mattock: actually a couple of replies
(22:06:32) mattock: ah, I see
(22:06:36) mattock: that would explain it
(22:07:05) mattock: anyways, that needs to be fixed
(22:07:25) ***dazo back
(22:07:58) mattock: dazo: any opinions on whether https://github.com/Open=
VPN/openvpn-build/pull/55 could go to 2.4_rc2 installers?
(22:08:00) vpnHelper: Title: Use active-setup registry entry to add GUI t=
o startup menu of users by selvanair =C2=B7 Pull Request #55 =C2=B7 OpenV=
PN/openvpn-build =C2=B7 GitHub (at github.com)
(22:08:13) selvanair: already done -- patch to be pushed to the PR (its j=
ust If Running64 instead of if ARCH=3Dx86_64)
(22:08:59) dazo: I have no strong opinions on the Windows side at all ...=
 I'm no active Windows user, and these days I don't even need to support =
any Windows users with OpenVPN even
(22:09:37) dazo: In my opinion, selvanair is a far better resource to ask=
 :)
(22:09:54) mattock: well, my viewpoint was that of software project manag=
ement
(22:10:01) dazo: :)
(22:10:14) mattock: do we consider _any_ change to openvpn-gui or the ins=
taller to be "safe" for stable point releases?
(22:10:19) mattock: or is there a line somewhere?
(22:10:39) dazo: All I care about on Windows is the overall user experien=
ce ... which should be smooth and easy without much unneeded questions an=
d options
(22:10:42) cron2: if it removes windows and reinstalls linux, it should b=
etter be Debian, not RHEL!
(22:10:48) mattock: :D
(22:10:55) dazo: lol
(22:11:03) selvanair: Anything Windows is never stable -- so subtle lines=
 can be drawn :)
(22:11:16) dazo: hehe
(22:11:17) selvanair: so->no yuck..
(22:11:44) mattock: ok, so the consensus seems to be that we don't need t=
o force https://github.com/OpenVPN/openvpn-build/pull/55/commits into ope=
nvpn 2.4_rc1
(22:11:45) vpnHelper: Title: Use active-setup registry entry to add GUI t=
o startup menu of users by selvanair =C2=B7 Pull Request #55 =C2=B7 OpenV=
PN/openvpn-build =C2=B7 GitHub (at github.com)
(22:12:10) mattock: rc2 would work as well
(22:12:41) mattock: that said, we should get as many openvpn-gui PRs into=
 2.4_rc1 as possible
(22:12:47) mattock: selvanair: anything left to lazy-ACK?
(22:12:50) dazo: if it doesn't hurt runtime stability, no issues at all
(22:12:56) selvanair: mattock: I agree -- we may have to double up effort=
s on internal testing to be on teh safe side..
(22:13:33) selvanair: mattock: dynamic-cr + pkcs11=20
(22:13:38) mattock: https://github.com/OpenVPN/openvpn-gui/pull/91
(22:13:40) vpnHelper: Title: pkcs11 pin prompt by selvanair =C2=B7 Pull R=
equest #91 =C2=B7 OpenVPN/openvpn-gui =C2=B7 GitHub (at github.com)
(22:13:48) mattock: whick contains both, right?
(22:14:47) dazo: selvanair: when the dust begins to settle on 2.4.0 ... I=
'd like to dig more into PKCS#11 stuff as well ... I have a few different=
 tokens these days, so I'd like to ensure openvpn works well here (at lea=
st from a Linux perspective)
(22:14:54) selvanair: mattock: valdikss's import pathc may have to wait (=
may be with 2.4.1?) -- I think I fixed most bugs and critical issues, but=
 he's too busy to test it. May be I'll take over it from him, but too bus=
y now..=20
(22:15:10) mattock: selvanair: yeah, let's not rush that one
(22:15:20) mattock: I say we lazy-ACK PR#91, though
(22:15:30) mattock: what remains to be fixed (https://community.openvpn.n=
et/openvpn/ticket/740#comment:15) cannot be fixed in openvpn-gui
(22:15:32) vpnHelper: Title: #740 (No PIN prompt with PKCS11 in Windows G=
UI mode) =E2=80=93 OpenVPN Community (at community.openvpn.net)
(22:16:29) selvanair: dazo: good. I only have software tokens to test thi=
s, so removing token is hard to simulate. Have some hardward tokens at wo=
rk, but not supposed to tinker it by adding keys/certs etc..
(22:17:30) selvanair: mattock: PR91 is good to merge from my end..
(22:17:42) dazo: selvanair: and I'd like to follow-up on David Woodhouse'=
s suggestion ... to kick-out pkcs11-helper in favour of p11kit (which is =
saner in the implementation)
(22:18:15) dazo: (I just need to figure out how to use those bloody token=
s on my Linux box first :-P)
(22:18:29) syzzer: yeah, I would like that too, but p11kit seems to lean =
very strongly towards openssl
(22:18:33) selvanair: dazo: and probably there is some decent docs on it =
-- I cant find any docs on pkcs11-helper.
(22:18:41) mattock: PR#91 merged
(22:19:09) selvanair: mattock: yeah... hope it doesn;t break anything ;)
(22:19:16) dazo: syzzer: alright, perhaps I'll see if I can get acceptanc=
e to work on mbedtls support on p11kit too, if needed
(22:19:29) mattock: selvanair: fingers crossed :)
(22:19:46) selvanair: mattock: same here :)
(22:19:47) mattock: unfortunately the code-review side in openvpn-gui is =
lacking (as are Windows developers)
(22:20:30) mattock: then again, nobody expects dynamic cr / pkcs11 pin pr=
ompts to work on openvpn-gui, so at least we're not (hopefully) creating =
regressions
(22:20:34) selvanair: we need some windows coders who can make things use=
r-friendly -- not my forte.. I'm the most unfriendly person around..
(22:20:39) dazo: syzzer: I need to use an argument in regards to OpenVPN =
3 though for this to fully work out ... I'm working on getting OpenVPN 3 =
building on Linux, and it seems most reasonable to start with using mbedt=
ls-2.3 there  (most of the port from polarssl-1.3 is already done)
(22:21:12) syzzer: yeah, don't bother with polar 1.x
(22:22:58) dazo: selvanair: I can try to get access to a windows computer=
 and test the UX ... and give you a boatload of how I would prefer things=
 to be on the UX side ... if that can work for you
(22:23:40) dazo: I have no real idea how to really do the windows UI stuf=
f ... but I have opinions at least ;-)
(22:23:52) mattock: "I don't like it this way, fix it"
(22:23:58) mattock: :P
(22:24:04) dazo: lol ... I can do better than that ;-)
(22:24:15) mattock: so 2.4 done?
(22:24:20) dazo: yes
(22:24:26) mattock: we discussed 2.3.14 a few days back
(22:24:36) mattock: that I could release the upcoming week
(22:24:43) cron2: right
(22:24:53) cron2: which day should I plan for?
(22:25:01) mattock: I don't particularly care
(22:25:17) cron2: (there is good stuff in already, and maybe a few more b=
ugfixes coming up)
(22:25:17) selvanair: dazo: that wont work: (1) I am bad with customer se=
rvice and (2) my brain is not wired for making good UI :)
(22:25:25) mattock: cron2: let's wait for those bugfixes then
(22:25:50) cron2: mattock: just tell me which day you want to do the rele=
ase and "what needs to be in will be in by then"
(22:26:01) mattock: wednesday?
(22:26:08) cron2: noted!
(22:26:09) dazo: selvanair: I can describe and provide mock-up images of =
how I'd recommend it ... but I'm not capable of making that in a windows =
program
(22:26:42) mattock: I could actually review dazo's suggestion from usabil=
ity perspective
(22:26:49) mattock: I've done some usability testing
(22:26:54) cron2: mattock: looking at my schedule, it looks like "tagging=
 and pushing" will happen tuesday, as wednesday is full of chaos already
(22:26:54) dazo: even better :)
(22:27:11) mattock: although for starters, openvpn-gui should not be a tr=
ay application, nor should it start hidden (which Windows usually does :)=
 )
(22:27:24) mattock: cron2: fine by me
(22:27:33) cron2: (tuesday evening-ish, that is)
(22:27:35) selvanair: And I oudl review code if someone writes it (and tr=
y fix bugs)
(22:27:37) mattock: good
(22:28:14) mattock: oh, the key signing thing is still ahead
(22:28:17) mattock: so how do we do it?
(22:28:17) cron2: tray app isn't bad - if you had it explained to you onc=
e
(22:28:28) cron2: ok, here's my plan.
(22:29:03) cron2: - who is interested meets in video chat (this only work=
s for people that have met in person before, but everyone is welcome to j=
oin and have a look, of course)
(22:29:18) cron2: - who wants his key signed pastes the fingerprint to th=
is IRC channel
(22:29:33) dazo: (the video chat takes max 8 people simultaneously)
(22:30:00) cron2: - who wants to sign gets the key from the keyserver ("g=
pg --recv-key $id") and gets ready to sign ("gpg --sign-key $id") BUT DOE=
S NOT SIGN YET
(22:30:32) cron2: the signee reads the fingerprint out on video chat, you=
 compare that visually to what was pasted on IRC and to what GPG says you=
 want to sign
(22:30:39) cron2: if it matches, you sign
(22:31:18) cron2: (this is slightly easier than "just read it aloud" for =
non-native speakers, as you have the IRC as tertiary channel for valdiati=
on - plus, it ties "IRC username" to "person")
(22:31:28) cron2: syzzer: is this sane?
(22:31:37) ***dazo have prepared a printout with QR code of the finger pr=
int ... for those who got a QR reader app handy
(22:32:05) cron2: mmmh, that is nice, will do so as well
(22:32:13) cron2: any particular format?  or just the string?
(22:32:39) dazo: I added URL to keybase.io e-mail-addr: fingerprint
(22:32:45) cron2: (actually, we could just print it in BIG LETTERS and po=
int the camera at it)
(22:32:48) syzzer: sounds good to me :)
(22:32:57) dazo: yeah the big letter printout works too
(22:33:20) syzzer: some voice confirmation would be good
(22:33:27) dazo: ack!
(22:36:46) syzzer: heh, this will mean peeling of the webcam sticker :p
(22:37:09) cron2: haha, I'll use a tablet
(22:37:13) dazo: heh ... you don't have such a fancy Fox-IT shield?
(22:37:26) syzzer: this sticker is pre-shield :p
(22:37:30) selvanair: I've never met anyone and dont have a webcam here a=
t work, so I'll sign off now. Enjoy the party..
(22:37:41) dazo: enhoy
(22:37:48) mattock: selvanair: bye!
(22:38:06) cron2: selvanair: bye.  But we hope you join next years's hack=
athon :)
(22:38:25) dazo: +1
(22:38:26) syzzer: yeah, would be cool!
(22:38:28) selvanair: cron2: will try..
(22:39:20) mattock: I'm looking into how this "sign other people key" thi=
ng is supposed to work, so feel free to count me out right now :D
(22:39:30) cron2: youre gone again
(22:39:56) dazo: seems there's some connectivity issues, cron2  .... stef=
fan and I are here
(22:40:01) dazo: mattock: you're joining?
(22:40:36) cron2: funky
(22:41:38) mattock: dazo: let's see what I can do...
(22:41:40) mattock: just a sec
(22:42:03) mattock: dazo: so this is your standard appear.in channel?
(22:42:04) dazo: pub   4096R/0x755A3AB945307622 2016-03-28 [expires: 2036=
-03-23]
(22:42:04) dazo: uid                            David Sommerseth <david@...2198...=
ommerseth.email>
(22:42:04) dazo: uid                            David Sommerseth <dazo@...2199...=
rephia.org>
(22:42:04) dazo: pub   4096R/0x57DB9DAB613B8DA1 2016-08-23 [expires: 2026=
-08-21]
(22:42:05) dazo: uid                            David Sommerseth (OpenVPN=
 Technologies, Inc) <davids@...515...>
(22:42:06) dazo: uid                            David Sommerseth (OpenVPN=
 mailing list ID) <openvpn@...2080...>
(22:42:10) dazo: mattock: ues
(22:44:35) dazo: mattock: appear.in/openvpn
(22:44:54) cron2: 3072R/CA562812 2016-11-10 Key fingerprint =3D B62E 6A2B=
 4E56 570B 7BDC 6BE0 1D82 9EFE CA56 2812
(22:51:10) cron2: mattock: waiting for you!
(22:51:28) cron2: scared him away :)
(22:53:31) cron2: (28)    Samuli Sepp?nen <samuli@...515...>
(22:53:32) cron2:         Samuli Sepp?nen <samuli.seppanen@...277...>
(22:53:32) cron2:           1024 bit DSA key 198D22A3, created: 2009-11-2=
1
(22:54:10) cron2: mattock: can I have the fingerprint again?
(22:54:24) cron2: could someone tell mattock I need to see the fingerprin=
t?
(22:55:44) cron2: uid                  Samuli Sepp?nen <samuli.seppanen@...2200...=
mail.com>
(22:55:46) cron2: sig 3        C0517EBA 2010-03-26  David Sommerseth <daz=
o@...2108...>
(22:56:31) syzzer: pub   2048R/007ED288 2013-03-19
(22:56:31) syzzer:       Key fingerprint =3D 0FD1 29CC 65BD 59E1 3C21  F7=
7C 9802 CA3D 007E D288
(22:56:31) syzzer: uid                  Steffan Karger (syzzer) <steffan@=
karger.me>
(23:02:53) cron2: ok, good :-)
(23:03:15) ***cron2 has pushed the key to the hkp keyservers already (key=
s.gnupg.net)
(23:03:21) cron2: and now - good night *wave*
(23:03:44) mattock: ok, so the signing party thing concluded today's meet=
ing
(23:04:39) syzzer: yes, me too :)
(23:04:45) mattock: good night guys!
(23:04:48) syzzer: good night!
(23:05:45) mattock: next meeting Wed 7th Dec

--------------0105907014902F51E58DD19A--

