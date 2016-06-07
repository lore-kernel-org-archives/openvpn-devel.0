MIME-Version: 1.0
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 7 Jun 2016 18:04:54 +0500
Message-ID: <CAFHpkQF9s4JnDKHsomjo0ud72nwOXF7g_hLEiNreZ1ozTn4QLA@...278...>
Content-Type: multipart/alternative; boundary=047d7bb04ae8de9be70534afd547
Subject: [Openvpn-devel] potential segfault on strlen(NULL)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--047d7bb04ae8de9be70534afd547
Content-Type: text/plain; charset=UTF-8

Hello,

I'm investigating some cppcheck findings, for example:

[src/openvpn/buffer.c:442] -> [src/openvpn/buffer.c:447]: (warning) Either
the condition 'if(separator&&i&&!(i%(space_break_flags&255)))' is redundant
or there is possible null pointer dereference: separator.
[src/openvpn/buffer.c:443] -> [src/openvpn/buffer.c:447]: (warning) Either
the condition 'if(separator&&i&&!(i%(space_break_flags&255)))' is redundant
or there is possible null pointer dereference: separator.


as I see, there's call to format_hex_ex with separator=NULL here:


https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/ssl_openssl.c#L152

which in turn should be segfault in strlen:

https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/buffer.c#L442

(if maxoutput is not zero)

should we add some check here ?


Cheers,
Ilya Shipitsin

--047d7bb04ae8de9be70534afd547
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hello,<br><br></div>I&#39;m investigating some c=
ppcheck findings, for example:<br><br>[src/openvpn/buffer.c:442] -&gt; [src=
/openvpn/buffer.c:447]: (warning) Either the condition &#39;if(separator&am=
p;&amp;i&amp;&amp;!(i%(space_break_flags&amp;255)))&#39; is redundant or th=
ere is possible null pointer dereference: separator.<br>[src/openvpn/buffer=
.c:443] -&gt; [src/openvpn/buffer.c:447]: (warning) Either the condition &#=
39;if(separator&amp;&amp;i&amp;&amp;!(i%(space_break_flags&amp;255)))&#39; =
is redundant or there is possible null pointer dereference: separator.<br><=
br><br></div>as I see, there&#39;s call to format_hex_ex with separator=3DN=
ULL here:<br><div><br><br><a href=3D"https://github.com/OpenVPN/openvpn/blo=
b/master/src/openvpn/ssl_openssl.c#L152">https://github.com/OpenVPN/openvpn=
/blob/master/src/openvpn/ssl_openssl.c#L152</a><br><br></div><div>which in =
turn should be segfault in strlen:<br><br><a href=3D"https://github.com/Ope=
nVPN/openvpn/blob/master/src/openvpn/buffer.c#L442">https://github.com/Open=
VPN/openvpn/blob/master/src/openvpn/buffer.c#L442</a><br><br></div><div>(if=
 maxoutput is not zero)<br><br></div><div>should we add some check here ?<b=
r><br><br></div><div>Cheers,<br></div><div>Ilya Shipitsin<br></div></div>

--047d7bb04ae8de9be70534afd547--

