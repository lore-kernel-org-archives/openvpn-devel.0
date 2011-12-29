From: Tiran Kaskas <Tiran.Kaskas@...1530...>
Date: Thu, 29 Dec 2011 19:21:41 +0000
Message-ID: <A273A2F6519C0D42BFF02CA9C6A825112D011FFF@...1534...>
References: <A273A2F6519C0D42BFF02CA9C6A825112D003F02@...1531...>
	<A273A2F6519C0D42BFF02CA9C6A825112D003F72@...1531...>
	<20111213092241.GO18948@...1296...>
	<1CED409804E2164C8104F9E623B08B90128ACE5B0A@...1436...>
	<A273A2F6519C0D42BFF02CA9C6A825112D005928@...1531...>
	<4EE863A2.5010302@...1114...>
	<A273A2F6519C0D42BFF02CA9C6A825112D005B6D@...1531...>
	<0E891FB5E6304C73BB4338093E409304@...139...>
	<A273A2F6519C0D42BFF02CA9C6A825112D005C00@...1531...>
	<A273A2F6519C0D42BFF02CA9C6A825112D00A3D3@...1534...>
	<20111229142454.GV5060@...1296...>,<1325176729.8034.0@...1207...>
In-Reply-To: <1325176729.8034.0@...1207...>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_A273A2F6519C0D42BFF02CA9C6A825112D011FFFsrviltxch01tmtt_"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Problem with alloc_buf_gc function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "kop@...1206..." <kop@...1206...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--_000_A273A2F6519C0D42BFF02CA9C6A825112D011FFFsrviltxch01tmtt_
Content-Type: text/plain; charset="iso-8859-8-i"
Content-Transfer-Encoding: quoted-printable

Well, the vpn server runs on windows.
You mean that every packet received from the outside should be forwarded to=
 the tun?
The problem is that i do not see this reply from the outside coming into th=
e vpn server(listenning on the physical link using wireshark).

Sent from my Android phone using TouchDown (www.nitrodesk.com)

-----Original Message-----
From: Karl O. Pinc [kop@...1206...]
Received: =E9=E5=ED =E7=EE=E9=F9=E9, 29 =E3=F6=EE 2011, 18:38
To: Tiran Kaskas [Tiran.Kaskas@...1530...]
CC: openvpn-devel@lists.sourceforge.net [openvpn-devel@...475...=
t]
Subject: Re: [Openvpn-devel] Problem with alloc_buf_gc function

On 12/29/2011 08:24:54 AM, Gert Doering wrote:

> Linux needs to know that it is to be a router:
>
>  # echo 1 >/proc/sys/net/ipv4/ip_forward

See /etc/sysctl.conf (man sysctl.conf) to set
forwarding at boot.


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


--_000_A273A2F6519C0D42BFF02CA9C6A825112D011FFFsrviltxch01tmtt_
Content-Type: text/html; charset="iso-8859-8-i"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
8-i">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:11p=
t; color:black">
<span style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:11=
pt; color:black">Well, the vpn server runs on windows.<br>
You mean that every packet received from the outside should be forwarded to=
 the tun?<br>
The problem is that i do not see this reply from the outside coming into th=
e vpn server(listenning on the physical link using wireshark).<br>
<br>
Sent from my Android phone using TouchDown (www.nitrodesk.com)<br>
<br>
<span style=3D"color:black">-----Original Message----- <br>
<b>From:</b> Karl O. Pinc [kop@...1206...]<br>
<b>Received:</b> =E9=E5=ED =E7=EE=E9=F9=E9, 29 =E3=F6=EE 2011, 18:38<br>
<b>To:</b> Tiran Kaskas [Tiran.Kaskas@...1530...]<br>
<b>CC:</b> openvpn-devel@lists.sourceforge.net [openvpn-devel@...1535...=
orge.net]<br>
<b>Subject:</b> Re: [Openvpn-devel] Problem with alloc_buf_gc function<br>
<br>
</span></span></div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On 12/29/2011 08:24:54 AM, Gert Doering wrote:<br>
<br>
&gt; Linux needs to know that it is to be a router:<br>
&gt; <br>
&gt;&nbsp; # echo 1 &gt;/proc/sys/net/ipv4/ip_forward<br>
<br>
See /etc/sysctl.conf (man sysctl.conf) to set<br>
forwarding at boot.<br>
<br>
<br>
Karl &lt;kop@...1206...&gt;<br>
Free Software:&nbsp; &quot;You don't pay back, you pay forward.&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; -- Robert A. Heinlein<br>
<br>
</div>
</span></font>
</body>
</html>

--_000_A273A2F6519C0D42BFF02CA9C6A825112D011FFFsrviltxch01tmtt_--

