Date: Thu, 14 Oct 2010 23:05:00 +0200
Message-Id: <LAAT8C$AF2127EA27C5D0C15118FCEFC2FE06E1@...1417...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="_=__=_XaM3_.1287090300.2A.459592.42.8408.52.42.007.1903485047"
From: "openvpn" <openvpn@...1416...>
Subject: [Openvpn-devel] openvpn, NTLM and McAfee Web Gateway
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--_=__=_XaM3_.1287090300.2A.459592.42.8408.52.42.007.1903485047
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

dear all,a few days ago I deployed an ovpn solution in a medium=20
sized company. One of the two ends of the vpn network is passing through
 a proxy with NTLM authentication. ovpn has problems to recognize the=20
authentication because immediately after sending the message type 1, the
 proxy sends no response, so I had to modify the source code by=20
replacing the current message with a similar but different one.in particula=
r this one:TlRMTVNTUAABAAAAAgIAAA=3D=3Dbecome:TlRMTVNTUAABAAAAB4IIogAAAAAAA=
AAAAAAAAAAAAAAFASgKAAAADw=3D=3DA detail of the work is available at:http://=
www.morzello.com/?p=3D350 (in Italian).I was wondering if you could have a =
function that supports this type of proxy (such as McAfee Web Gateway).than=
k you very much.

--_=__=_XaM3_.1287090300.2A.459592.42.8408.52.42.007.1903485047
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


<div class=3D"xam_msg_class">
<div style=3D"font: normal 13px Arial; color:rgb(0, 0, 0);">dear all,<br><b=
r>a few days ago I deployed an ovpn solution in a medium=20
sized company. One of the two ends of the vpn network is passing through
 a proxy with NTLM authentication. ovpn has problems to recognize the=20
authentication because immediately after sending the message type 1, the
 proxy sends no response, so I had to modify the source code by=20
replacing the current message with a similar but different one.<br><br>in p=
articular this one:<br><br><div style=3D"font-weight: bold;" class=3D"codew=
rapper"><div class=3D"codecontent">TlRMTVNTUAABAAAAAgIAAA=3D=3D</div></div>=
<br><br>become:<br><br><div style=3D"font-weight: bold;" class=3D"codewrapp=
er"><div class=3D"codecontent">TlRMTVNTUAABAAAAB4IIogAAAAAAAAAAAAAAAAAAAAAF=
ASgKAAAADw=3D=3D</div></div><br><br>A detail of the work is available at:<b=
r><br><a href=3D"http://www.morzello.com/?p=3D350" class=3D"postlink">http:=
//www.morzello.com/?p=3D350</a> (in Italian).<br><br>I was wondering if you=
 could have a function that supports this type of proxy (such as McAfee Web=
 Gateway).<br><br>thank you very much.</div>
</div>


--_=__=_XaM3_.1287090300.2A.459592.42.8408.52.42.007.1903485047--


