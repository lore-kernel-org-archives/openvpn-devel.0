Message-ID: <552C1B93.3040005@...515...>
Date: Mon, 13 Apr 2015 22:40:03 +0300
From: =?windows-1252?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <552B52D5.1040200@...515...>
In-Reply-To: <552B52D5.1040200@...515...>
Content-Type: multipart/alternative;
	boundary="------------020108030309040801010207"
Subject: Re: [Openvpn-devel] Topics for today's (Monday,
 13th Apr 2015) community meeting
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
--------------020108030309040801010207
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the *summary* of the previous IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Monday 13th Apr 2015
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2015-04-13>

The next meeting has been scheduled to two weeks from now:

<https://community.openvpn.net/openvpn/wiki/Topics-2015-04-27>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

*SUMMARY*

cron2, jamesyonan, mattock and syzzer participated in this meeting

---

Discussed the "Interactive service" patchset:

<https://sourceforge.net/p/openvpn-gui/openvpn/ci/interactive_service/tree/>

Cron2 will take care of the remaining modifications and merge the=20
patchset into Git "master". After that mattock will create Windows test=20
installers.

---

Discussed the AEAD patchset:

<https://github.com/syzzer/openvpn/tree/aead-cipher-modes8>

Jamesyonan and syzzer will first do compatibility tests between OpenVPN=20
2.x/3.x and then move on to patch review.

---

Discussed the "Openvpn with crytpodev on FreeBSD does not work" bug:

<https://community.openvpn.net/openvpn/ticket/480>

Changing the init order as in the original patch to #480 would break=20
config files which have relative paths in them, but which don't use the=20
"--cd" option. As that kind of configs seem to be very common, the=20
original patch was ruled out. This problem could also be fixed at the=20
FreeBSD end, but that might take a long time.

Syzzer will provide a patch that will change the init order from=20
"openssl init, then daemon(with chdir)" to "daemon(without chdir),=20
openssl init, chdir()". This should fix the issue in a clean way without=20
nasty side-effects.

--

Full chatlog is attached.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------020108030309040801010207
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    Hi,<br>
    <br>
    Here's the <b style=3D"color:black;background-color:#ffff66">summary</b>
    of the previous IRC meeting.<br>
    <br>
    ---<br>
    <br>
    COMMUNITY MEETING<br>
    <br>
    Place: #openvpn-devel on irc.freenode.net<br>
    Date: Monday 13th Apr 2015<br>
    Time: 20:00 CEST (18:00 UTC)<br>
    <br>
    Planned meeting topics for this meeting were on this page:
    <br>
    <br>
    <a class=3D"moz-txt-link-rfc2396E" href=3D"https://community.openvpn.ne=
t/openvpn/wiki/Topics-2015-04-13">&lt;https://community.openvpn.net/openvpn=
/wiki/Topics-2015-04-13&gt;</a><br>
    <br>
    The next meeting has been scheduled to two weeks from now:<br>
    <br>
    <a class=3D"moz-txt-link-rfc2396E" href=3D"https://community.openvpn.ne=
t/openvpn/wiki/Topics-2015-04-27">&lt;https://community.openvpn.net/openvpn=
/wiki/Topics-2015-04-27&gt;</a><br>
    <br>
    Your local meeting time is easy to check from services such as<br>
    <br>
    <a class=3D"moz-txt-link-rfc2396E" href=3D"http://www.timeanddate.com/w=
orldclock">&lt;http://www.timeanddate.com/worldclock&gt;</a><br>
    <br>
    <b style=3D"color:black;background-color:#ffff66">SUMMARY</b><br>
    <br>
    cron2, jamesyonan, mattock and syzzer participated in this meeting<br>
    <br>
    ---<br>
    <br>
    Discussed the "Interactive service" patchset:<br>
    <br>
<a class=3D"moz-txt-link-rfc2396E" href=3D"https://sourceforge.net/p/openvp=
n-gui/openvpn/ci/interactive_service/tree/">&lt;https://sourceforge.net/p/o=
penvpn-gui/openvpn/ci/interactive_service/tree/&gt;</a><br>
    <br>
    Cron2 will take care of the remaining modifications and merge the
    patchset into Git "master". After that mattock will create Windows
    test installers.<br>
    <br>
    ---<br>
    <br>
    Discussed the AEAD patchset:<br>
    <br>
    <a class=3D"moz-txt-link-rfc2396E" href=3D"https://github.com/syzzer/op=
envpn/tree/aead-cipher-modes8">&lt;https://github.com/syzzer/openvpn/tree/a=
ead-cipher-modes8&gt;</a><br>
    <br>
    Jamesyonan and syzzer will first do compatibility tests between
    OpenVPN 2.x/3.x and then move on to patch review.<br>
    <br>
    ---<br>
    <br>
    Discussed the "Openvpn with crytpodev on FreeBSD does not work" bug:<br>
    <br>
    <a class=3D"moz-txt-link-rfc2396E" href=3D"https://community.openvpn.ne=
t/openvpn/ticket/480">&lt;https://community.openvpn.net/openvpn/ticket/480&=
gt;</a><br>
    <br>
    Changing the init order as in the original patch to #480 would break
    config files which have relative paths in them, but which don't use
    the "--cd" option. As that kind of configs seem to be very common,
    the original patch was ruled out. This problem could also be fixed
    at the FreeBSD end, but that might take a long time.<br>
    <br>
    Syzzer will provide a patch that will change the init order from
    "openssl init, then daemon(with chdir)" to "daemon(without chdir),
    openssl init, chdir()". This should fix the issue in a clean way
    without nasty side-effects.<br>
    <br>
    --<br>
    <br>
    Full chatlog is attached.<br>
    <br>
    <pre class=3D"moz-signature" cols=3D"72">--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock</pre>
  </body>
</html>

--------------020108030309040801010207--

