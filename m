From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <d54b01ca-1001-ccfc-cb97-1e1a826a5f94@...515...>
Message-ID: <38e86c05-75fe-3526-6481-952df0cdd7db@...515...>
Date: Thu, 4 Apr 2019 19:11:50 +0300
MIME-Version: 1.0
In-Reply-To: <d54b01ca-1001-ccfc-cb97-1e1a826a5f94@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="m7QJQxLDU3xZnXU34FTFRDVKikF7atTCv"
Subject: [Openvpn-devel] Summary of the community meeting (3rd Apr 2019)
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
--m7QJQxLDU3xZnXU34FTFRDVKikF7atTCv
Content-Type: multipart/mixed; boundary="V9Iggur15pdqSEEZDLFbYcH1iWjbAaRo8";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <38e86c05-75fe-3526-6481-952df0cdd7db@...515...>
Subject: Summary of the community meeting (3rd Apr 2019)
References: <d54b01ca-1001-ccfc-cb97-1e1a826a5f94@...515...>
In-Reply-To: <d54b01ca-1001-ccfc-cb97-1e1a826a5f94@...515...>

--V9Iggur15pdqSEEZDLFbYcH1iWjbAaRo8
Content-Type: multipart/mixed;
 boundary="------------A2CF75488936EF1C33907C3B"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------A2CF75488936EF1C33907C3B
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Resending as the original one probably got blocked.

--

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 3rd April 2019
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-04-03>

The next meeting is scheduled to Thursday 11th April 20:00 CEST.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, mattock, rozmansi and syzzer participated in this meeting.

--

Planned the tap-windows6 release. Mattock will produce a test
tap-windows6 driver which includes the following PRs from Jon and Selva:

https://github.com/OpenVPN/tap-windows6/pull/48
https://github.com/OpenVPN/tap-windows6/pull/55
https://github.com/OpenVPN/tap-windows6/pull/56
https://github.com/OpenVPN/tap-windows6/pull/65

In addition a fix to a security vulnerabily will be included. If/when
the tap-windows6 driver passes basic testing those PRs will be merged
and signed driver and installers (9.23.1) will be produced for the
following platforms:

- Windows 7/8/8.1/Server 2012r2
- Windows 10 (including arm64)

Windows Server 2016 will follow after that one. Mattock does have a
physical Windows Server 2016 box he can use as a HLK test client. But it
will take a few weeks before Stephen's patches can be reviewed, tested
and merged, and before a WHQL-certified tap-windows6 driver can be
released for that platform.

As Windows Server 2016 users will have to use to the old (9.22.1)
tap-windows6 driver a bit longer we will simply advise them to avoid
using it on machines with untrusted people.

--

Full chatlog attached.



--------------A2CF75488936EF1C33907C3B
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-04-03.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-04-03.txt"

(12:32:02) cron2: moin
(12:34:59) cron2: theory says we have a meeting today, for the last time =
(and then, thursday evening next week)
(12:35:24) mattock: hello!
(12:35:41) mattock: not only theory, but also the invitation
(12:35:58) mattock: now, who do we have here besides me and cron2?
(12:36:10) mattock2 ha abbandonato la stanza (quit: Quit: IRC for Sailfis=
h 0.9).
(12:38:13) ***cron2 looks frustrated, but this reflects accurately on the=
 general process
(12:39:30) mattock: yeah unfortunately
(12:39:40) cron2: so, as I have a lunch appointment at 12:15, maybe we sh=
ould quickly cover the news?
(12:39:45) mattock: yep
(12:40:08) mattock: I now have a physical Windows Server 2016 box which c=
an operate as a HLK test client
(12:40:16) cron2: cool :)
(12:40:37) mattock: that one has two VMs that can serve as the HLK openvp=
n server and as the "support machine"
(12:40:52) mattock: if that approach does not work, those two VMs can be =
moved over to EC2
(12:41:09) syzzer: oops, almost forgot the meeting
(12:41:10) cron2: I was about to wonder if that will work or fail in spec=
tacular ways
(12:41:13) mattock: I'm told that we do have an EV dongle we can use for =
EV-signing tap-windows6
(12:41:13) syzzer: present now :)
(12:41:27) cron2: mattock1: cool.  syzzer: hello again ;-)
(12:41:29) mattock: yeah it could fail, but that would not be a catastrop=
he
(12:41:32) mattock: hi syzzer!
(12:41:39) mattock: now we have genuine meeting :)
(12:42:17) mattock: also, I am supposed to be on vacation next week (unfo=
rtunate timing this tap-windows6 issue)
(12:43:21) mattock: so it would probably make most sense to release for W=
indows 7/8/8.1 and Windows 10 first, followed by Windows Server 2016
(12:43:26) mattock: thoughts?
(12:43:37) mattock: the first part would almost certainly be doable this =
week
(12:44:51) ***rozmansi here now
(12:45:29) mattock: hi rozmansi!
(12:45:40) cron2: I still think that we should do this - release a fixed+=
signed Win10-compatible driver, if we can do that, and document the short=
comings of the current driver (=3D do not use on machines with untrusted =
people on it)
(12:45:56) cron2: I'm sitting on the patch and could push it out any day =
:))
(12:46:15) mattock: now, should we release it as 9.21.2 + security fix fo=
r now?
(12:46:23) cron2: yes
(12:46:24) mattock: instead of trying to merge Stephen's work first
(12:46:35) mattock: so 9.21.3 it would be
(12:46:50) syzzer: +1 on not waiting anymore
(12:46:54) cron2: Stephen's work will definitely take a few weeks - I hav=
e seen some of the patches, all the code looks good, but to truly underst=
and what is changed takes time
(12:47:12) cron2: mattock1: haven't we upped the version to 9.22.x alread=
y?
(12:47:26) mattock: yes that was the broken driver (9.22.1)
(12:47:35) cron2: so we do 9.22.2 then, not 9.21.3
(12:47:46) mattock: yeah you're correct
(12:48:26) cron2: or maybe 9.23.1 to really communicate "this is new!"
(12:48:30) rozmansi: will the 9.22.2 include ARM64 version too?
(12:48:45) mattock: rozmansi: hmm, good question
(12:49:00) mattock: we did receive tons of patches from Jon that enabled =
arm64 building
(12:49:09) cron2: we should be able to...
(12:49:14) mattock: yeah
(12:49:18) rozmansi: but we haven't tested any ourself. :(
(12:49:33) mattock: that is correct :)
(12:49:43) cron2: rozmansi: no, but if you want an ARM laptop to test, ju=
st holler :-)
(12:49:43) mattock: we can probably outsource the arm64 testing to Jon
(12:49:44) mattock: for now
(12:49:48) cron2: as well
(12:50:14) rozmansi: mattock1: Can you compile ARM64 and sign it. I'd nee=
d it at least to start adding ARM64 support  to MSI.
(12:50:15) mattock: so, 9.23.1, with jon's arm64 patches, i386/amd64/arm6=
4, no stephen stuff yet
(12:50:24) cron2: yes
(12:50:25) mattock: rozmansi: I shall
(12:50:38) mattock: and this would an interim release
(12:50:42) rozmansi: We don't need to advertise tap-windows6 ARM64 instal=
ler out loud yet.
(12:50:44) cron2: yes
(12:50:49) cron2: (and yes)
(12:50:54) mattock: we'd make another release when Stephen's stuff is mer=
ged and HLK tests pass
(12:51:30) mattock: hmm, I wonder how is NSIS ARM64 support...
(12:51:33) cron2: yes, which would then be 9.24.1 ("this is really lots o=
f changes"), so we *could* go back and do a 9.23.2 if we discover some mi=
nor bug and 9.24.x isn't working good enough yet
(12:52:01) mattock: worst case with arm64 - we can just provide the drive=
r files in a zip with instructions on how to install them
(12:52:09) mattock: though
(12:52:18) mattock: arm64 windows has i386 emulation layer...
(12:52:28) mattock: anyways, let's see how it goes
(12:52:32) cron2: yes, the userland should just work "if we can get it is=
ntalled"
(12:52:34) rozmansi: NSIS installer must be i386 in the end.
(12:53:00) mattock: ok so this release will be my main priority for this =
week
(12:53:02) rozmansi: Jon added PR for NSIS installer too.
(12:53:21) mattock: have a link?
(12:53:31) cron2: mattock1: so I push the bugfix, and we go public?  or s=
hall I wait until tomorrow-ish, etc?  Who bumps the version number?
(12:53:49) mattock: let's wait until I'm 100% sure I have everything I ne=
ed to sign the builds
(12:53:52) rozmansi: mattock1: https://github.com/OpenVPN/tap-windows6/pu=
ll/57
(12:53:54) mattock: =3Dtomorrow
(12:53:54) vpnHelper: Title: Add ARM64 files to installer by jkunkee =C2=B7=
 Pull Request #57 =C2=B7 OpenVPN/tap-windows6 =C2=B7 GitHub (at github.co=
m)
(12:54:00) cron2: mattock1: ok
(12:54:27) cron2: just let me know.  tomorrow during daytime I have to be=
 at a customer site (and won't check IRC), but tomorrow evening/friday is=
 good
(12:54:49) mattock: oh, we still have Jon's PRs open
(12:54:53) rozmansi: mattock1: I'm fine even if you don't provide the NSI=
S installer, as long as I get signed INF+SYS+CAB files. :)
(12:55:00) cron2: mattock1: we do?
(12:55:02) mattock: rozmansi: noted
(12:55:07) mattock: https://github.com/OpenVPN/tap-windows6/pulls
(12:55:08) vpnHelper: Title: Pull Requests =C2=B7 OpenVPN/tap-windows6 =C2=
=B7 GitHub (at github.com)
(12:55:23) mattock: also one easy one from selva
(12:55:37) mattock: 48, 55, 56, 57
(12:55:45) mattock: 65
(12:55:58) cron2: yep, looking at that right now.  Haven't we ACKed all o=
f them?
(12:56:08) mattock: not sure, let's check
(12:56:12) cron2: selva's definitely needs to go in to avoid confusions
(12:56:31) mattock: yeah
(12:56:42) mattock: it seems I promised to test it but got blocked/distra=
cted
(12:57:12) mattock: do we trust selva's code or should I still test it?
(12:57:24) cron2: we do trust Selva's code, but you should still test it
(12:57:49) mattock: maybe I'll merge all of that stuff into my own clone =
and test them as a whole
(12:58:23) cron2: I think that was the original plan, last year, and then=
 you got distracted.  I think it might have been "family stuff" - that te=
nds to cause such effects
(12:58:28) rozmansi: actually, #48 from selva is mandatory - INF version =
and SYS (resource) versions must match.
(12:58:38) rozmansi: there's a test in HKL that verifies this.
(12:58:40) mattock: family, work, holidays, etc.
(12:59:15) rozmansi: Thou, Windows will hapilly accept driver even on INF=
 vs. SYS version mismatches
(12:59:17) ***cron2 needs to talk to people at OpenVPN inc regarding the =
"holiday" time-waster...
(12:59:23) mattock: lol
(12:59:44) mattock: so I will produce a test installer with all those PRs=

(13:00:03) cron2: +1  (my patch should be in your mailbox, but I can just=
 mail it again)
(13:00:17) mattock: please mail it again - it is probably hidden somewher=
e
(13:00:32) cron2: sent
(13:00:34) mattock: ok, anything else on tap-windows6?
(13:00:36) mattock: thanks!
(13:00:55) ***cron2 <- happy with the path forward
(13:01:59) mattock: and I'm looking forward to fighting with Authenticode=
 signatures again :)
(13:02:13) mattock: anyways, other topics? we have a couple of mins
(13:02:37) cron2: syzzer: if you can find a bit of time, a review of my r=
ate-limiting patches would be nice
(13:02:59) syzzer: cron2: yeah, they're on my list, haven't forgotten abo=
ut them
(13:03:34) syzzer: but remembering me does increase the likelyhood of me =
picking it up :p
(13:03:39) cron2: thanks :) - so, how many hundred other things are furth=
er up on that list? ;-)
(13:04:10) cron2: (insert rant about "2 colleagues at $work quit, 3rd col=
league is sick since 2.5 months now, and we get lots of EXTRA work to com=
pensate...")
(13:05:08) cron2: so... my next appointment just called in a bit early...=
 and I'm off *now* :-) - *wave*, will read up what you come up with
(13:05:09) syzzer: well, dayjob is kinda hectic, which mostly costs energ=
y (rather than time), and $gf is complaining I should spend more time on =
arranging a wedding :p
(13:05:46) syzzer: ok, ttyl!
(13:06:33) mattock: ok let's conclude the meeting unless somebody else co=
mes up with something
(13:07:13) rozmansi: Excellent
(13:07:13) ***rozmansi back to work now...
(13:07:17) syzzer: I don't have any other topics to discuss now - jjk sta=
rted an off-list discussion with me and dazo about the keygen options, bu=
t we'll get some consensus between us before we bring it back to the meet=
ing and claim everyones time
(13:09:17) mattock: ok sounds good
(13:09:27) mattock: good meeting, and a short one!
(13:09:47) syzzer: great, I'm off to lunch then :)
(13:09:50) syzzer: thanks all :)


--------------A2CF75488936EF1C33907C3B--

--V9Iggur15pdqSEEZDLFbYcH1iWjbAaRo8--

--m7QJQxLDU3xZnXU34FTFRDVKikF7atTCv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlymLMYACgkQKVhNn0CG
RXi4rAf+OjiIeD8ewlywg62FaZPuTT4nuMKG3Zw0uct8A899gfakMxA2qUzN7/9o
TNQot8wH+wtth7DxhWONvESxgnJLLBfcrlP1ApTZwG1Z5FpvuA8/64bGsBGs6mM4
W/j+fBuG5uxso53/ZlZK/TtUKjCgqNBp1Z2iPZVy5zmTGDYSdKLU/+IaYKguCWws
a23N1G0Jwe4GNmQ19IcrzXr+Q2mtmkMQ2HuHwRaXNHTCo/0yfvPvKwbpEnH3nzcC
58vyHZzI8KncLQYLzYQQoNg+4ZTHsLExvPsNVWnVGiqnX4aN37P9cqBvQLCaJEBg
/97vAjZxhO3AG+23bN5Lk52GWvHuMg==
=+nJO
-----END PGP SIGNATURE-----

--m7QJQxLDU3xZnXU34FTFRDVKikF7atTCv--

