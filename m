MIME-Version: 1.0
Date: Thu, 23 Oct 2014 13:24:45 -0600
Message-ID: <CAAA5faEk-YSopL-9L=cWzpcfwk96r+utbWEWuO_=L0=jjvYzRg@...278...>
From: Reinoud Koornstra <reinoudkoornstra@...277...>
Content-Type: multipart/alternative; boundary=e89a8f503aac5588fa05061c0475
Subject: [Openvpn-devel] man page and options.c contradict
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--e89a8f503aac5588fa05061c0475
Content-Type: text/plain; charset=UTF-8

Hello Everyone,

I read the manpage here: doc/openvpn.8

<connection>
remote 198.19.34.56 443 tcp
</connection>

However, when you configure this in your configuration file, you cannot do
this:

in src/openvpn/options.c:

  /*
   * If "proto tcp" is specified, make sure we know whether it is
   * tcp-client or tcp-server.
   */
  if (ce->proto == PROTO_TCPv4)
    msg (M_USAGE, "--proto tcp is ambiguous in this context.  Please
specify --proto tcp-server or --proto tcp-client");
  if (ce->proto == PROTO_TCPv6)
    msg (M_USAGE, "--proto tcp6 is ambiguous in this context.  Please
specify --proto tcp6-server or --proto tcp6-client");


So the man page isn't correct?
The only thing I can reliably use in p2p mode is remote host 1194 udp
If I fill out a different port.
The idea in my case is to have a point-to-point connection where both hosts
listen on port 443 tcp instead of port 1194 udp to setup the point-to-point
connection.
Thanks,

Reinoud.

--e89a8f503aac5588fa05061c0475
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Everyone,<div><br></div><div>I read the manpage here=
: doc/openvpn.8</div><div><br></div><div><div>&lt;connection&gt;</div><div>=
remote 198.19.34.56 443 tcp</div><div>&lt;/connection&gt;</div></div><div><=
br></div><div><span style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;=
font-size:medium">However, when you configure this=C2=A0</span><span style=
=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-size:medium">in your=
 configuration file, you cannot do this:</span></div><div><font color=3D"#0=
00000" face=3D"arial, sans-serif" size=3D"3"><br></font></div><div><font co=
lor=3D"#000000" face=3D"arial, sans-serif" size=3D"3">in src/openvpn/option=
s.c:</font></div><div><font color=3D"#000000" face=3D"arial, sans-serif" si=
ze=3D"3"><br></font></div><div><font color=3D"#000000" face=3D"arial, sans-=
serif" size=3D"3"><div>=C2=A0 /*</div><div>=C2=A0 =C2=A0* If &quot;proto tc=
p&quot; is specified, make sure we know whether it is</div><div>=C2=A0 =C2=
=A0* tcp-client or tcp-server.</div><div>=C2=A0 =C2=A0*/</div><div>=C2=A0 i=
f (ce-&gt;proto =3D=3D PROTO_TCPv4)</div><div>=C2=A0 =C2=A0 msg (M_USAGE, &=
quot;--proto tcp is ambiguous in this context.=C2=A0 Please specify --proto=
 tcp-server or --proto tcp-client&quot;);</div><div>=C2=A0 if (ce-&gt;proto=
 =3D=3D PROTO_TCPv6)</div><div>=C2=A0 =C2=A0 msg (M_USAGE, &quot;--proto tc=
p6 is ambiguous in this context.=C2=A0 Please specify --proto tcp6-server o=
r --proto tcp6-client&quot;);</div><div><br></div><div><br></div><div>So th=
e man page isn&#39;t correct?</div><div>The only thing I can reliably use i=
n p2p mode is remote host 1194 udp</div><div>If I fill out a different port=
.</div><div>The idea in my case is to have a point-to-point connection wher=
e both hosts listen on port 443 tcp instead of port 1194 udp to setup the p=
oint-to-point connection.</div><div>Thanks,</div><div><br></div><div>Reinou=
d.</div></font></div></div>

--e89a8f503aac5588fa05061c0475--

