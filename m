References: <67cb5e5c-cc62-b1ad-69e0-be5aaa6a03aa@...515...>
 <a9874dc2-975c-96e8-69a8-5d7cd59eb64b@...515...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <b1b3b311-a893-9426-acc1-213dc08d9ba1@...515...>
Date: Wed, 4 Jul 2018 14:33:07 +0300
MIME-Version: 1.0
In-Reply-To: <a9874dc2-975c-96e8-69a8-5d7cd59eb64b@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nuaJT2tnkgnodCIzcTwNpyEerAl2ejc49"
Subject: Re: [Openvpn-devel] Summary of the community meeting (Wed,
 4th July 2018)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nuaJT2tnkgnodCIzcTwNpyEerAl2ejc49
Content-Type: multipart/mixed; boundary="vgAa5QyUyyqdNyBMtRpF8lD8TouCYd2LZ";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <b1b3b311-a893-9426-acc1-213dc08d9ba1@...515...>
Subject: Re: Summary of the community meeting (Wed, 4th July 2018)
References: <67cb5e5c-cc62-b1ad-69e0-be5aaa6a03aa@...515...>
 <a9874dc2-975c-96e8-69a8-5d7cd59eb64b@...515...>
In-Reply-To: <a9874dc2-975c-96e8-69a8-5d7cd59eb64b@...515...>

--vgAa5QyUyyqdNyBMtRpF8lD8TouCYd2LZ
Content-Type: multipart/mixed;
 boundary="------------F78C77482690849A9348DDD8"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------F78C77482690849A9348DDD8
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Forgot the chatlog, so here it comes.

Samuli

Il 04/07/2018 14:05, Samuli Sepp=E4nen ha scritto:
> Hi,
>=20
> Here's the summary of the IRC meeting.
>=20
> ---
>=20
> COMMUNITY MEETING
>=20
> Place: #openvpn-meeting on irc.freenode.net
> Date: Wednesday 4th July 2018
> Time: 11:30 CET (9:30 UTC)
>=20
> Planned meeting topics for this meeting were here:
>=20
> <https://community.openvpn.net/openvpn/wiki/Topics-2018-07-04>
>=20
> The next meeting has not been scheduled yet.
>=20
> Your local meeting time is easy to check from services such as
>=20
> <http://www.timeanddate.com/worldclock>
>=20
> SUMMARY
>=20
> cron2, dazo, mattock, plaisthos and syzzer participated in this meeting.
>=20
> --
>=20
> Discussed tap-windows6 release and HLK testing. Jkunkee is fixing the
> issues identified in the HLK tests. Once that's done mattock will test
> the updated driver in our HLK testing environment an submit the results
> to Microsoft. If we're lucky MS will provide us with a signature. That
> said, MS documentation seems to indicate that we'd need to run the tests
> on a physical Windows Server 2016 instance. But the only way to be sure
> is to try.
>=20
> If MS disapproves our HLK submission mattock will either outsource the
> testing to the company he's been in talks with. Or else build the
> necessary infrastructure into the OpenVPN intranet and run test
> pre-submission tests himself.
>=20
> --
>=20
> Discussed Reed's proposal to arrange a demo of Hackerone. Cron2, syzzer
> and syzzer expressed interest in it. Mattock setup a Doodle poll for this:
>=20
> https://doodle.com/poll/445bphsd9a4q9shs
>=20
> --
>=20
> Discussed Microsoft's OpenVPN fork on GitHub:
>=20
> <https://github.com/microsoft/openvpn>
>=20
> Agreed that some parts of it (dialer in particular) are interesting to
> us. The author of the fork (Kevin) is now on openvpn-devel mailing list,
> so we will follow up there.
>=20
> --
>=20
> Full chatlog attached.
>=20


--------------F78C77482690849A9348DDD8
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2018-07-04.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2018-07-04.txt"

(12:32:44) cron2: o/
(12:32:44) syzzer: *crickets*
(12:32:59) cron2: good morning, sir :)
(12:33:11) syzzer: well, good morning to you too, sir :)
(12:33:23) plaisthos: good morning
(12:33:29) mattock: hi
(12:33:35) mattock: shall we?
(12:33:36) cron2: syzzer: welcome back :)
(12:33:40) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
8-07-04
(12:33:42) vpnHelper: Title: Topics-2018-07-04 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:35:28) mattock: #1 Tap-windows6 / HLK test updates=20
(12:35:35) mattock: so the situation right now is this
(12:35:51) mattock: Jon from Microsoft has setup his own HLK testing envi=
ronment where he can do kernel debugging
(12:36:01) mattock: according to him the issues seem fairly trivial to fi=
x
(12:36:35) mattock: he also has access to our HLK test environment, but k=
ernel debugging in EC2 is more challenging (if not  impossible?)
(12:36:56) cron2: cool
(12:37:07) mattock: anyways, once Jon gets the problems fixed, we can sta=
rt thinking about running the pre-submission tests=20
(12:37:34) mattock: that is not as simplistic as it sounds, as it seems w=
e need to test on a physical Windows Server 2016 instance with 4 cores
(12:38:00) mattock: as we (OpenVPN Inc) don't want to start accumulating =
Windows Server boxes at the office (2016 now, 2019 soon)
(12:38:05) mattock: I looked into outsourcing options
(12:38:25) mattock: and I've made contact with a company that could do th=
e testing
(12:38:41) mattock: I'm waiting for a quota before presenting the plan to=
 the management at openvpn inc
(12:38:47) mattock: that's all basically
(12:39:02) cron2: do you have confirmation that you need a physical serve=
r?
(12:39:30) cron2: (more curiosity, this is all a bit vague and undocument=
ed...)
(12:39:55) cron2: and... so we formally postpone release planning to July=
 18?
(12:40:05) cron2: s/release planning/planned release date/
(12:41:08) mattock: yes, 18th sounds reasonable
(12:41:33) mattock: what we _can_ do is run the HLK tests virtualized
(12:41:41) mattock: and just submit the test results to MS and see if thi=
ngs blow up
(12:41:55) mattock: I don't think there's any other way to be 100% sure
(12:42:18) cron2: mmmhok.  Let's see what Jon comes up with, and then see=
 what MS says to our test results :)
(12:43:46) mattock: +1
(12:44:09) mattock: so regarding the hackone demo
(12:44:16) mattock: Reed offered to organize one
(12:44:26) mattock: Skype or Zoom
(12:44:41) cron2: zoom is some sort of video chat thingsie?
(12:45:02) mattock: yes, one of the million others
(12:45:07) mattock: I've used it, it comes with a linux client
(12:45:22) mattock: so, any takers?
(12:45:29) mattock: I'm in
(12:45:41) cron2: looking at it enables "more educated discussions", so, =
yes :)
(12:45:49) mattock: ok great!
(12:46:14) cron2: finding a good time will be challenging, but that's wha=
t doodle is there for
(12:46:36) mattock: how about some time next week?
(12:47:23) cron2: where is Reed? us?
(12:47:30) mattock: yeah
(12:47:40) mattock: not sure where exactly, could be west coast
(12:48:06) cron2: so this would be "european late evening, honkong very e=
arly morning"-ish
(12:48:24) mattock: yes, assuming ordex is going to join
(12:49:08) mattock: I'll setup a doodle
(12:49:18) mattock: all days except Friday next week should work for me
(12:49:52) syzzer: I'll see if I can join too :)
(12:49:56) mattock: \o/
(12:50:01) cron2: doodle +1
(12:51:04) mattock: next topic then?
(12:51:16) cron2: yep
(12:51:46) cron2: MS OpenVPN fork, PQ, dialer
(12:52:17) syzzer: the pqcrypto part is "just"  link to OpenPQSafe, which=
 is an OpenSSL fork that includes all sorts of experimental academic post=
-quantum crypto code
(12:52:20) cron2: I'm not exactly sure if I'm excited or annoyed
(12:52:44) syzzer: cool, of course, but not something to integrate into a=
 stable product
(12:52:50) plaisthos: yeah
(12:53:03) plaisthos: seem at the moment more like academic experimental =
work
(12:53:21) syzzer: there is some really good code in there, but also some=
 really bad...
(12:53:21) cron2: well, they are duplicating effort that FoxIT has done y=
ears ago... so "talk to us, then run off and do work" might have been mor=
e productive
(12:53:53) cron2: this is the bit I find annoying :)
(12:53:58) syzzer: we went into a different direction (and to be fair, I'=
m taking *way* to long to get it out...)
(12:54:21) cron2: the part that is exciting is the dialer stuff - if I re=
ad this correctly, this is "VPN on demand" for windows, which would be re=
ally nice to have
(12:54:23) syzzer: but yeah, "talk to us first" would have been nice
(12:54:27) ***dazo is here
(12:54:32) plaisthos: if https://github.com/Microsoft/openvpn/commit/96c2=
8afe044ec5a27907ee289f8f767e83ef4f69 is all they done as changes to OpenV=
PN, it is kind of no issue
(12:54:34) vpnHelper: Title: PQCrypto-VPN 1.0 Release =C2=B7 Microsoft/op=
envpn@...2435... =C2=B7 GitHub (at github.com)
(12:54:49) mattock: hi dazo!
(12:55:31) cron2: that commit is indeed a bit weird, because the actual d=
ialer is missing
(12:57:18) mattock_ [~mattock@...1423.../corp/admin/mattock] =C3=A8 entrato =
nella stanza.
(12:57:39) cron2: syzzer: if it's indeed only "enable these extra cipher =
suites, link to a different OpenSSL branch, ship as 'look, PQ crypto!'", =
there is some room for improvement :)
(12:57:52) cron2: you say there is good code - where is that?  which bran=
ch, which commit?
(12:57:58) dazo: -FRODO-RECOMMENDED-PICNIC-
(12:58:34) plaisthos: cron2: +static const TCHAR DialerDllName[] =3D TEXT=
("libopenvpndialer-0.dll");
(12:58:42) cron2: FRODO-RECOMMENDED-ECDHE-PICNIC
(12:59:08) plaisthos: that name will probably be changed :)
(12:59:08) cron2: plaisthos: yep.  This dialer dll is what I want to see =
(and if it's cool, to have :) )
(12:59:34) plaisthos: we also not using RIJAENDAEL-256-KEKAC at the momen=
t ;)
(12:59:43) plaisthos: (KEKAC would be SHA3)
(13:00:23) plaisthos: (Keccak spellt correctly)
(13:02:16) syzzer: cron2: I mean some of the crypto algorithms in OpenPQS=
afe are high quality, others less so.
(13:02:25) cron2: ah
(13:03:49) mattock: so what should we do about this? ask Kane if he could=
 split out the parts the upstream project (=3Dus) is interested in?
(13:04:08) mattock: try to get him involved
(13:04:15) plaisthos: the current changes are not really much
(13:04:16) syzzer: probably.  which is probably the dialer part.
(13:04:29) cron2: mattock: yep.  I'm primarily interested in the dialer s=
tuff - what is this doing?  what can we do with it?  is it open, closed, =
=2E..?
(13:05:07) mattock: there's a discussion open on openvpn-devel with Kane
(13:05:20) cron2: the PQ bits are not overly exciting from OpenVPN code/p=
rotocol p.o.v. yet (AFAICS) - here syzzer needs to decide how FoxIT wants=
 to play the ball, I think
(13:05:21) mattock: let's use that
(13:05:38) cron2: yes
(13:06:11) mattock: I will pass that ball to you guys then :)
(13:06:14) plaisthos: dialer seem like a alternative to our interactive s=
ervice on a very superficial reading of the code?
(13:06:36) cron2: plaisthos: where did you find that?
(13:07:11) cron2: the service is primarily registering "an extra DLL", bu=
t what that one *does* is not clear from the commit
(13:07:28) cron2: my take is that it might be used for VPN-on-demand ("di=
alup internet/dialup VPN")
(13:07:42) cron2: or a replacement for the GUI to manage VPN configs from=
 the Windows VPN dialup pane
(13:08:17) plaisthos: yeah you are right
(13:08:21) plaisthos: no idea what it does
(13:08:23) cron2: https://docs.microsoft.com/en-us/windows/desktop/rras/c=
ustom-dialers
(13:08:24) vpnHelper: Title: Custom Dialers | Microsoft Docs (at docs.mic=
rosoft.com)
(13:10:46) cron2: so, whatever it is, I want to see what they are doing :=
-)
(13:11:27) dazo: Just saw that Kevin K signed up at the openvpn-devel ml =
=2E.. so we now have means to reach out and ask around
(13:11:43) cron2: yep, he mailed this morning already
(13:11:57) cron2: (which is good and welcome :) )
(13:12:10) dazo: +1
(13:12:50) dazo: We probably just need to educate these newcomers how to =
have smaller commits with better commit messages to help review processes=
 and further discussions
(13:13:04) syzzer: I'll repond to him wrt the PQ bits
(13:13:06) cron2: dazo: oh, the commit is small enough :)
(13:13:17) cron2: it's just missing all the interesting parts
(13:13:43) mattock: next topic would be everyone's favorite
(13:13:48) mattock: "review patches on patchwork"
(13:13:54) dazo: well, it seems (commit 96c28afe044e) to mix a few things=
 into a single commit :)
(13:13:58) mattock: are we ready to move on or skip it :P
(13:14:07) ***cron2 pokes syzzer
(13:14:14) dazo: move on
(13:15:00) mattock: https://patchwork.openvpn.net/project/openvpn2/list/
(13:15:02) vpnHelper: Title: OpenVPN 2 - Patchwork (at patchwork.openvpn.=
net)
(13:15:33) cron2: the ipv6-only things are in my queue (and I'm fine with=
 that)
(13:15:38) cron2: maybe I should tag it aas such...
(13:16:41) cron2: syzzer: so, how's your available time?  the tls-auth/tl=
s-crypt key reloading stuff from ordex sounds like "yours"
(13:17:32) cron2: any taker on /390?  "remove deprecated plugin functions=
 from code samples"?
(13:18:03) cron2:  /329 is syzzer's ballpark...
(13:18:25) ***dazo pokes at 390
(13:21:13) syzzer: cron2: available time should get better
(13:21:25) cron2: great news :)
(13:21:32) dazo: Generally, I'm fine with 390, so feature-ack.  Needs a d=
eeper review to ensure the code is 100% correct.  But this is a low prior=
ity change, even more so auth-pam and down-root changes
(13:21:46) syzzer: first days after holiday were of course fully booked b=
y all kinds of meetings with people and processing backlog :p
(13:21:53) dazo: Even though the _v1 API is considered deprecated, we're =
not going to remove it any time soon
(13:22:07) syzzer: I'll pick op the tls-crypt/auth key reloading, yes.
(13:22:08) dazo: (open_v1 and func_v1)
(13:22:30) plaisthos: I will take ordex's netlink patches
(13:22:47) dazo: but I agree that at least sample code should definitely =
use at minimum v2, preferably v3
(13:23:00) cron2: dazo: sounds reasonable
(13:23:34) cron2: plaisthos: cool :-)  (ordex might have to respin parts =
of them, since he wrecked tun.c in the meantime)
(13:32:24) syzzer: so, time to wrap up?
(13:32:28) ***syzzer gets hungry :p
(13:33:13) dazo: :)
(13:33:22) dazo: Yeah
(13:33:24) cron2: yep, next meeting waiting
(13:33:31) cron2: one of these days...
(13:33:41) mattock: yes
(13:33:42) cron2: 10:30-11:30, 11:30-12:30, 12:30-13:30, 14:00-15:30
(13:33:57) mattock: sounds like a really productive day
(13:33:59) mattock: lots of coffee
(13:34:11) syzzer: yeah, *lots* of coffee
(13:34:17) syzzer: enjoy ;-)
(13:35:07) mattock: summary and doodle coming up soon
(13:35:27) cron2: *wave*

--------------F78C77482690849A9348DDD8--

--vgAa5QyUyyqdNyBMtRpF8lD8TouCYd2LZ--

--nuaJT2tnkgnodCIzcTwNpyEerAl2ejc49
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAls8sHQACgkQKVhNn0CG
RXgiUgf/RPOw5oBT34x+PMbGKr0y1dWrjlbxxYzliRHktcWPAI/8WRrMUj0tP3yI
RouxwF8JJ7gJuj1EONEmaeXzf9DZxYUrRXH2AUiKYRcNG11okA4757vhi/O6BI8T
5+GHynZZ/awIrAbgVE9XfV+cjTCZNDnaLr0Wkg5L2ttngCuOqcnoZtWQhiaH4i1N
ByjnERe6cj3kk2sOAKJIPfvnXfdYy+qGjMisyZx0bnNq/KjKlDYtvxpLJ2zpREyx
J+aA/88TY/FVxDAoNQG9w2aJzgYTG4jASeP62dgQB3DJ+8P84GqZwrvpd0naqQ0F
PlPPD/FH49cNGwVxiaE/v4GiXiKWtg==
=TeRt
-----END PGP SIGNATURE-----

--nuaJT2tnkgnodCIzcTwNpyEerAl2ejc49--

