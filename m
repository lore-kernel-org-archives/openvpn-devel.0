References: <1348477246.32678.YahooMailNeo@...1765...>
	<20120924091835.GX742@...1296...>
Message-ID: <1348480610.66753.YahooMailNeo@...1767...>
Date: Mon, 24 Sep 2012 02:56:50 -0700 (PDT)
From: ehsan enayati <ehsan_en85@...109...>
In-Reply-To: <20120924091835.GX742@...1296...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="-613093590-257434458-1348480610=:66753"
Subject: Re: [Openvpn-devel] multi threading support
Reply-To: ehsan enayati <ehsan_en85@...109...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

---613093590-257434458-1348480610=:66753
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

thanks for your quick reply, I know that openvpn is single threaded but it =
supports multiple user connection simultaneously, I wanted to know how this=
 is done although it just have one thread.
thanks

=A0
-



________________________________
 From: Gert Doering <gert@...1296...>
To: ehsan enayati <ehsan_en85@...109...>=20
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@...290...=
net>=20
Sent: Monday, September 24, 2012 12:48 PM
Subject: Re: [Openvpn-devel] multi threading support
=20
Hi,

On Mon, Sep 24, 2012 at 02:00:46AM -0700, ehsan enayati wrote:
> Hi, i wanna know how does openvpn server handles multiple requests?
> for example if there is an active connection with a client on 1194
> port and another requests from some other client comes in what will
> happen? Is this task managed in operating system or by openvpn
> itself?

OpenVPN itself (single-threaded with smart work queues).

Multi-Threading might happen in OpenVPN 3.0.

gert

--=20
USENET is *not* the non-clickable part of WWW!
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0  //www.muc.de/~gert/
Gert Doering - Munich, Germany=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 gert@...1296...
fax: +49-89-35655025=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gert@...1186...=
.1297...=

---613093590-257434458-1348480610=:66753
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ar=
ial, helvetica, sans-serif;font-size:14pt"><div><span>thanks for your quick=
 reply, I know that openvpn is single threaded but it supports multiple use=
r connection simultaneously, I wanted to know how this is done although it =
just have one thread.</span></div><div style=3D"color: rgb(0, 0, 0); font-s=
ize: 18.6667px; font-family: arial,helvetica,sans-serif; background-color: =
transparent; font-style: normal;"><span>thanks<br></span></div><div>&nbsp;<=
/div><div><font size=3D"2"><span style=3D"FONT-FAMILY:tahoma, new york, tim=
es, serif;">-</span></font></div><br><div><br></div>  <div style=3D"font-fa=
mily: arial, helvetica, sans-serif; font-size: 14pt;"> <div style=3D"font-f=
amily: times new roman, new york, times, serif; font-size: 12pt;"> <div dir=
=3D"ltr"> <font face=3D"Arial" size=3D"2"> <hr size=3D"1">  <b><span style=
=3D"font-weight:bold;">From:</span></b> Gert Doering &lt;gert@...1296...&gt=
;<br>
 <b><span style=3D"font-weight: bold;">To:</span></b> ehsan enayati &lt;ehs=
an_en85@...109...&gt; <br><b><span style=3D"font-weight: bold;">Cc:</span><=
/b> "openvpn-devel@lists.sourceforge.net" &lt;openvpn-devel@...1768...=
ge.net&gt; <br> <b><span style=3D"font-weight: bold;">Sent:</span></b> Mond=
ay, September 24, 2012 12:48 PM<br> <b><span style=3D"font-weight: bold;">S=
ubject:</span></b> Re: [Openvpn-devel] multi threading support<br> </font> =
</div> <br>
Hi,<br><br>On Mon, Sep 24, 2012 at 02:00:46AM -0700, ehsan enayati wrote:<b=
r>&gt; Hi, i wanna know how does openvpn server handles multiple requests?<=
br>&gt; for example if there is an active connection with a client on 1194<=
br>&gt; port and another requests from some other client comes in what will=
<br>&gt; happen? Is this task managed in operating system or by openvpn<br>=
&gt; itself?<br><br>OpenVPN itself (single-threaded with smart work queues)=
.<br><br>Multi-Threading might happen in OpenVPN 3.0.<br><br>gert<br><br>--=
 <br>USENET is *not* the non-clickable part of WWW!<br>&nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp;  //www.muc.de/~gert/<br>Gert Doering - Mun=
ich, Germany&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <a
 ymailto=3D"mailto:gert@...1296..." href=3D"mailto:gert@...1296...">gert@...1186...=
.1296...</a><br>fax: +49-89-35655025&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <a ymailto=3D"mailto:gert@...1386...=
297..." href=3D"mailto:gert@...1297...">gert@...1297...</a><br><br><br> </d=
iv> </div>  </div></body></html>=

---613093590-257434458-1348480610=:66753--

