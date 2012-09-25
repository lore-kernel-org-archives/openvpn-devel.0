References: <1348477246.32678.YahooMailNeo@...1765...>
	<20120924091835.GX742@...1296...>
Message-ID: <1348557760.30714.YahooMailNeo@...1772...>
Date: Tue, 25 Sep 2012 00:22:40 -0700 (PDT)
From: ehsan enayati <ehsan_en85@...109...>
In-Reply-To: <20120924091835.GX742@...1296...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="-83809723-1554305443-1348557760=:30714"
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

---83809723-1554305443-1348557760=:30714
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I saw in the linux source code that it uses fork and pthread, i think that'=
s the way it handles multiple requests



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

---83809723-1554305443-1348557760=:30714
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ar=
ial, helvetica, sans-serif;font-size:14pt">I saw in the linux source code t=
hat it uses fork and pthread, i think that's the way it handles multiple re=
quests<br><br><div style=3D"font-family: arial, helvetica, sans-serif; font=
-size: 14pt;"> <div style=3D"font-family: times new roman, new york, times,=
 serif; font-size: 12pt;"> <div dir=3D"ltr"> <font face=3D"Arial" size=3D"2=
"> <hr size=3D"1">  <b><span style=3D"font-weight:bold;">From:</span></b> G=
ert Doering &lt;gert@...1296...&gt;<br> <b><span style=3D"font-weight: bold=
;">To:</span></b> ehsan enayati &lt;ehsan_en85@...109...&gt; <br><b><span s=
tyle=3D"font-weight: bold;">Cc:</span></b> "openvpn-devel@...282...=
.net" &lt;openvpn-devel@lists.sourceforge.net&gt; <br> <b><span style=3D"fo=
nt-weight: bold;">Sent:</span></b> Monday, September 24, 2012 12:48 PM<br> =
<b><span style=3D"font-weight: bold;">Subject:</span></b> Re: [Openvpn-deve=
l] multi
 threading support<br> </font> </div> <br>
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

---83809723-1554305443-1348557760=:30714--

