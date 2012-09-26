References: <1348477246.32678.YahooMailNeo@...1765...>
	<20120924091835.GX742@...1296...>
	<1348557760.30714.YahooMailNeo@...1772...>
	<20120925075728.GD742@...1296...>
Message-ID: <1348637046.97129.YahooMailNeo@...1772...>
Date: Tue, 25 Sep 2012 22:24:06 -0700 (PDT)
From: ehsan enayati <ehsan_en85@...109...>
In-Reply-To: <20120925075728.GD742@...1296...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="-83809723-1282801678-1348637046=:97129"
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

---83809723-1282801678-1348637046=:97129
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Ok now I understand what is happening, thanks for your answers guys.


=A0


________________________________
 From: Gert Doering <gert@...1296...>
To: ehsan enayati <ehsan_en85@...109...>=20
Cc: Gert Doering <gert@...1296...>; "openvpn-devel@lists.sourceforge.net" <=
openvpn-devel@lists.sourceforge.net>=20
Sent: Tuesday, September 25, 2012 11:27 AM
Subject: Re: [Openvpn-devel] multi threading support
=20
Hi,

On Tue, Sep 25, 2012 at 12:22:40AM -0700, ehsan enayati wrote:
> I saw in the linux source code that it uses fork and pthread, i think tha=
t's the way it handles multiple requests

Neither.

Fork() is used to, uh, fork other processes (for example to start scripts).

pthread is not used at all - there was some experimental code that used
multithreading to get crypto into its own thread, but that has been=20
removed for 2.3 because it wasn't complete and didn't work.

Multiple requests are just queued in a, uh, "work queue" - which is
basically a glorified array of things-to-do - and then processed one
after another.

gert
--=20
USENET is *not* the non-clickable part of WWW!
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0  //www.muc.de/~gert/
Gert Doering - Munich, Germany=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 gert@...1296...
fax: +49-89-35655025=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gert@...1186...=
.1297...=

---83809723-1282801678-1348637046=:97129
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ar=
ial, helvetica, sans-serif;font-size:14pt">Ok now I understand what is happ=
ening, thanks for your answers guys.<br><div><span><br></span></div><div>&n=
bsp;</div><br><div style=3D"font-family: arial, helvetica, sans-serif; font=
-size: 14pt;"> <div style=3D"font-family: times new roman, new york, times,=
 serif; font-size: 12pt;"> <div dir=3D"ltr"> <font face=3D"Arial" size=3D"2=
"> <hr size=3D"1">  <b><span style=3D"font-weight:bold;">From:</span></b> G=
ert Doering &lt;gert@...1296...&gt;<br> <b><span style=3D"font-weight: bold=
;">To:</span></b> ehsan enayati &lt;ehsan_en85@...109...&gt; <br><b><span s=
tyle=3D"font-weight: bold;">Cc:</span></b> Gert Doering &lt;gert@...1296...=
&gt;; "openvpn-devel@lists.sourceforge.net" &lt;openvpn-devel@...1535...=
orge.net&gt; <br> <b><span style=3D"font-weight: bold;">Sent:</span></b> Tu=
esday, September 25, 2012 11:27 AM<br> <b><span style=3D"font-weight:
 bold;">Subject:</span></b> Re: [Openvpn-devel] multi threading support<br>=
 </font> </div> <br>
Hi,<br><br>On Tue, Sep 25, 2012 at 12:22:40AM -0700, ehsan enayati wrote:<b=
r>&gt; I saw in the linux source code that it uses fork and pthread, i thin=
k that's the way it handles multiple requests<br><br>Neither.<br><br>Fork()=
 is used to, uh, fork other processes (for example to start scripts).<br><b=
r>pthread is not used at all - there was some experimental code that used<b=
r>multithreading to get crypto into its own thread, but that has been <br>r=
emoved for 2.3 because it wasn't complete and didn't work.<br><br>Multiple =
requests are just queued in a, uh, "work queue" - which is<br>basically a g=
lorified array of things-to-do - and then processed one<br>after another.<b=
r><br>gert<br>-- <br>USENET is *not* the non-clickable part of WWW!<br>&nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=20
 //www.muc.de/~gert/<br>Gert Doering - Munich, Germany&nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;  <a ymailto=3D"mailto:gert@...1296..." href=3D"mailto:gert@...1296...">ge=
rt@...1296...</a><br>fax: +49-89-35655025&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <a ymailto=3D"mailto:gert=
@...1297..." href=3D"mailto:gert@...1297...">gert@...1297...</a><br><br><br=
> </div> </div>  </div></body></html>=

---83809723-1282801678-1348637046=:97129--

