References: <1336639383.83791.YahooMailNeo@...1721...>
	<4FAB80BA.9070500@...1147...>
Message-ID: <1336641729.38936.YahooMailNeo@...1723...>
Date: Thu, 10 May 2012 02:22:09 -0700 (PDT)
From: Raj Kumar <raj_kumar_sh@...109...>
In-Reply-To: <4FAB80BA.9070500@...1147...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="-876459695-1998136064-1336641729=:38936"
Subject: Re: [Openvpn-devel] openvpn question
Reply-To: Raj Kumar <raj_kumar_sh@...109...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

---876459695-1998136064-1336641729=:38936
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi JJK,

Thanks a lot for quick responds.=A0 your answer really helped me.




Regards
Raj=20



________________________________
 From: Jan Just Keijser <janjust@...1147...>
To: Raj Kumar <raj_kumar_sh@...109...>=20
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@...290...=
net>=20
Sent: Thursday, May 10, 2012 2:17 PM
Subject: Re: [Openvpn-devel] openvpn question
=20
Hi Raj,

Raj Kumar wrote:
>=20
> Hi all,
>=20
> I am new to openvpn. I am using openvpn on my=A0 linux machine.
>=20
> I have a basic question about openvpn.=20
> How openvpn process the incoming packets ?
>=20
> Is it processing incoming packets one by one, means receive one packet fr=
om the kernel, decrypt it and send it back to the kernel then next packet ?
> or
> whenever a packet comes, openvpn receives=A0 and queues it while doing de=
cryption of already received packet ?
>=20
>=A0=20
openvpn processes the incoming packets one by one , both from the VPN side =
(the encrypted packets) , and the packets coming in via the tun/tap interfa=
ce. This is one of the main reasons why openvpn speeds top off at around ~ =
300 Mbps.

HTH,

JJK=

---876459695-1998136064-1336641729=:38936
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ve=
rdana, helvetica, sans-serif;font-size:10pt"><div><span>Hi JJK,</span></div>
<div><span><br>
  </span></div>
<div><span>Thanks a lot for quick responds.&nbsp; your answer really helped=
 me.<br></span></div><div><br></div><div><br></div><div><br></div><div><spa=
n>Regards</span></div><div><span>Raj <br></span></div><div><br></div>  <div=
 style=3D"font-family: verdana, helvetica, sans-serif; font-size: 10pt;"> <=
div style=3D"font-family: times new roman, new york, times, serif; font-siz=
e: 12pt;"> <div dir=3D"ltr"> <font face=3D"Arial" size=3D"2"> <hr size=3D"1=
">  <b><span style=3D"font-weight:bold;">From:</span></b> Jan Just Keijser =
&lt;janjust@...1147...&gt;<br> <b><span style=3D"font-weight: bold;">To:</s=
pan></b> Raj Kumar &lt;raj_kumar_sh@...109...&gt; <br><b><span style=3D"fon=
t-weight: bold;">Cc:</span></b> "openvpn-devel@lists.sourceforge.net" &lt;o=
penvpn-devel@lists.sourceforge.net&gt; <br> <b><span style=3D"font-weight: =
bold;">Sent:</span></b> Thursday, May 10, 2012 2:17 PM<br> <b><span style=
=3D"font-weight: bold;">Subject:</span></b> Re: [Openvpn-devel] openvpn que=
stion<br> </font>
 </div> <br>
Hi Raj,<br><br>Raj Kumar wrote:<br>&gt; <br>&gt; Hi all,<br>&gt; <br>&gt; I=
 am new to openvpn. I am using openvpn on my&nbsp; linux machine.<br>&gt; <=
br>&gt; I have a basic question about openvpn. <br>&gt; How openvpn process=
 the incoming packets ?<br>&gt; <br>&gt; Is it processing incoming packets =
one by one, means receive one packet from the kernel, decrypt it and send i=
t back to the kernel then next packet ?<br>&gt; or<br>&gt; whenever a packe=
t comes, openvpn receives&nbsp; and queues it while doing decryption of alr=
eady received packet ?<br>&gt; <br>&gt;&nbsp; <br>openvpn processes the inc=
oming packets one by one , both from the VPN side (the encrypted packets) ,=
 and the packets coming in via the tun/tap interface. This is one of the ma=
in reasons why openvpn speeds top off at around ~ 300 Mbps.<br><br>HTH,<br>=
<br>JJK<br><br><br><br> </div> </div>  </div></body></html>=

---876459695-1998136064-1336641729=:38936--

