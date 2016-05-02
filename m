MIME-Version: 1.0
Date: Mon, 2 May 2016 11:12:13 +0500
Message-ID: <CAFHpkQENgyAaaWCsWOS1vj+9YR=Cc65muXmsYfmcKc8n09BkPQ@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Content-Type: multipart/alternative; boundary=001a114cd77aa8000a0531d5df7f
Subject: [Openvpn-devel] CI for openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114cd77aa8000a0531d5df7f
Content-Type: text/plain; charset=UTF-8

Hello,

I just run cppcheck and ...

[src/openvpnserv/interactive.c:601]: (error) Memory pointed to by
'addr_row' is freed twice.
[src/openvpnserv/interactive.c:700]: (error) Memory pointed to by 'fwd_row'
is freed twice.
[src/openvpnserv/interactive.c:1329]: (error) Common realloc mistake:
'handles' nulled but not freed upon failure

I suggest to either

1) add travis-ci support (there are few tests in "t" and we can run
cppcheck)
2) add cppcheck to buildbot (however it is not transparent, I've no idea
where can I have a look at buildbot logs, for example)

Cheers,
Ilya Shipitsin

--001a114cd77aa8000a0531d5df7f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div>Hello,<br><br></div>I just r=
un cppcheck and ...<br><br>[src/openvpnserv/interactive.c:601]: (error) Mem=
ory pointed to by &#39;addr_row&#39; is freed twice.<br>[src/openvpnserv/in=
teractive.c:700]: (error) Memory pointed to by &#39;fwd_row&#39; is freed t=
wice.<br>[src/openvpnserv/interactive.c:1329]: (error) Common realloc mista=
ke: &#39;handles&#39; nulled but not freed upon failure<br><br></div>I sugg=
est to either<br><br></div>1) add travis-ci support (there are few tests in=
 &quot;t&quot; and we can run cppcheck)<br></div>2) add cppcheck to buildbo=
t (however it is not transparent, I&#39;ve no idea where can I have a look =
at buildbot logs, for example)<br><br></div>Cheers,<br></div>Ilya Shipitsin=
<br></div>

--001a114cd77aa8000a0531d5df7f--

