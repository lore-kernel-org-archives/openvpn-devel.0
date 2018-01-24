References: <57da8cf7-0162-7798-7ae5-5851e36cca4a@...515...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <184564da-92d3-7bb5-21f1-8b7c7ddb201f@...515...>
Date: Wed, 24 Jan 2018 16:50:37 +0200
MIME-Version: 1.0
In-Reply-To: <57da8cf7-0162-7798-7ae5-5851e36cca4a@...515...>
Content-Type: multipart/mixed; boundary="------------B66FFC7212A0354FEB998B2D"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (Wed,
 24th Jan 2018)
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
--------------B66FFC7212A0354FEB998B2D
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.
---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 24th Jan 2018
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2018-01-24>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

chipitsine, cron2, mattock and syzzer participated in this meeting.

--

Discussed the OpenVPN 2.4.5 release. The release was postponed to next
Wednesday (31st Jan) to get some fixes and enhancements in.

# openvpn

Ensure strings read from registry are null-terminated:

<https://patchwork.openvpn.net/project/openvpn2/list/?series=3D59>

Plug memory leak if push is interrupted:

<https://patchwork.openvpn.net/patch/195>

TLS v1.2 support for cryptoapicert -- RSA only:

<https://patchwork.openvpn.net/patch/202/>

# openvpn-gui

Update openvpn-gui-res-dk.rc:

<https://github.com/OpenVPN/openvpn-gui/pull/190>

Update Ukrainian localization:

<https://github.com/OpenVPN/openvpn-gui/pull/167>

# openvpn-build

Ensure that NSIS installer/uninstaller correctly manages new OpenSSL
(1.1.0) libraries (names have changed since 1.0.x).

---

Full chatlog attached.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



--------------B66FFC7212A0354FEB998B2D
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2018-01-24.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2018-01-24.txt"

(12:28:49) cron2: meow
(12:31:42) mattock: howdy
(12:31:47) syzzer: hi!
(12:32:42) mattock: shall we begin?
(12:33:56) syzzer: yup
(12:34:28) chipitsine: as for windows installer 2.4.5 + openssl-1,1,0
(12:34:31) chipitsine: [ilia@...23... bin]$ ls
(12:34:33) chipitsine: c_rehash  libcrypto-1_1-x64.dll  liblzo2-2.dll  li=
bpkcs11-helper-1.dll  libssl-1_1-x64.dll  openssl.exe  openvpn.exe  openv=
pn-gui.exe  openvpnserv.exe
(12:34:37) chipitsine: [ilia@...23... bin]$=20
(12:34:39) chipitsine: openssl libs changed their names
(12:34:50) chipitsine: I'm still working on openvpn.nsi
(12:35:25) chipitsine: not sure if I can finish it today
(12:36:42) cron2: I would also propose to postpone by one week
(12:36:52) cron2: there's patches we want in, and I've been distracted by=
 icky hardware
(12:36:55) mattock: postponing is good
(12:37:10) syzzer: I have no opinion
(12:37:11) mattock: I failed to build with openssl 1.1.0
(12:37:23) chipitsine: or we can release windows installer with openssl-1=
=2E0.2
(12:37:29) mattock: we could yes
(12:37:30) cron2: tincantech posted build errors with 1.1.0 that showed "=
built wrong branch"
(12:37:42) mattock: cron2: ok
(12:37:42) cron2: 2.4.4 will *not* build with 1.1, release/2.4 *should* b=
uild
(12:37:47) mattock: ah, ok
(12:37:58) mattock: I didn't have time to test release/2.4 yet
(12:37:59) cron2: (you need the cryptoapi patch from Selva, which has bee=
n merged, but came after 2.4.4 release)
(12:38:16) mattock: but NSIS needs to be modified if openssl filenames ch=
anged
(12:38:41) mattock: are there any openvpn patches that are still missing =
from 2.4.5?
(12:38:43) chipitsine: 1-2 days for NSIS
(12:39:04) cron2: there's the ccd cipher one
(12:39:05) mattock: chipitsine: sounds good
(12:39:49) chipitsine: it would be nice to merge https://patchwork.openvp=
n.net/project/openvpn2/list/?series=3D59 before 2.4.5
(12:39:50) vpnHelper: Title: OpenVPN 2 - Patchwork (at patchwork.openvpn.=
net)
(12:40:07) chipitsine: it improves UX on windows a bit
(12:40:26) cron2: indeed.  I'll see that I can review this on thursday
(12:42:01) mattock: new release date?
(12:42:13) mattock: I could do wed next week, but not thu or fri
(12:42:14) cron2: oh, and we have more ACKs that I failed to merge (TLSv1=
=2E2 for cryptoapicert)
(12:42:29) cron2: lets go for wed then
(12:42:40) mattock: ok
(12:43:02) mattock: let's compile a list of missing things
(12:43:08) syzzer: I'll be snowboard by then, but will read up in the eve=
nings :)
(12:43:11) mattock: https://patchwork.openvpn.net/project/openvpn2/list/?=
series=3D59
(12:43:12) vpnHelper: Title: OpenVPN 2 - Patchwork (at patchwork.openvpn.=
net)
(12:43:13) syzzer: *snowboarding
(12:43:18) mattock: the ccd cipher one
(12:43:29) mattock: NSIS fixes for openssl libraries
(12:43:36) cron2: TLSv1.2 for cryptoapicert
(12:43:55) mattock: anything else?
(12:44:34) syzzer: maybe this: https://patchwork.openvpn.net/patch/195/
(12:44:36) vpnHelper: Title: [Openvpn-devel] Plug memory leak if push is =
interrupted - Patchwork (at patchwork.openvpn.net)
(12:44:51) mattock: there are some openvpn-gui translation updates that w=
ould be good to have, but not blockers (danish and ukrainian)
(12:44:52) syzzer: but quite a corner case, so not critical
(12:44:55) cron2: sounds bugfixy, soyes
(12:45:21) mattock: syzzer: looks fairly trivial to review
(12:47:26) mattock: so this is the TLSv2 cryptoapicert thing right:https:=
//patchwork.openvpn.net/patch/202/
(12:47:28) vpnHelper: Title: [Openvpn-devel,v2,2/2] TLS v1.2 support for =
cryptoapicert -- RSA only - Patchwork (at patchwork.openvpn.net)
(12:47:31) cron2: yep
(12:47:33) syzzer: mattock: change looks simple, but testing it is annoyi=
ng because the issue usually doesn't occur
(12:47:58) mattock: you've tested it, right?
(12:48:05) syzzer: yeah, I did
(12:48:20) mattock: do we need independent tests or just code review, in =
your opinion?
(12:48:21) syzzer: but a second pair of eyes is good
(12:48:54) syzzer: depends on the change, but I try to test every patch I=
 ACK.  If I don't I state so in the ack mail.
(12:49:25) mattock: that's a good policy
(12:49:35) cron2: indeed :)
(12:49:45) mattock: maybe you could share your testing instructions?
(12:49:49) mattock: and/or scripts
(12:52:13) syzzer: mattock: I have a test suite @ work for mbedtls-relate=
d stuff, but other that that it is usually just "make check" (including t=
_client if I think that's useful) + manual testing of the code that chang=
ed
(12:52:22) syzzer: so not much to share unfortunately
(12:53:36) mattock: ok
(12:53:55) mattock: are we done with 2.4.5 planning?
(12:55:06) cron2: I'm done
(12:55:44) mattock: any other topics worthy of discussion?
(12:56:11) ***cron2 has none
(12:56:17) cron2: except "$wife is hungry" :)
(12:56:27) syzzer: me neither
(12:56:27) cron2: and "I want to go snowboarding as well!!"
(12:56:27) mattock: $me is hungry :P
(12:56:33) mattock: let's conclude this meeting then
(12:56:39) mattock: 26 minutes is a good achievement :)
(12:56:43) cron2: yep :-)
(12:56:55) mattock: ok bye guys! I will write the summary later today
(12:57:02) cron2: thanks
(12:57:20) syzzer: great!
(12:57:24) syzzer: enjoy lunch :)

--------------B66FFC7212A0354FEB998B2D--

