From: Russell Morris <openvpn@...1315...>
Date: Wed, 29 Feb 2012 17:04:26 -0600
Message-id: <1330556666604858500@...1315...>
In-reply-to: <1717163.B6krV9DGdl@...1524...>
References: <4F4CE4FE.3010009@...515...> <5666502.2X59yaTkiW@...1526...>
	<1330536406040521500@...1315...> <1717163.B6krV9DGdl@...1524...>
MIME-version: 1.0
Content-type: multipart/alternative;
	boundary="===axigen=4947873206877385063765360179602529417305=axigen==="
Subject: Re: [Openvpn-devel] OpenVPN 2.3-alpha1 / GUI
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a MIME message. You may need a MIME compliant mail user agent.
--===axigen=4947873206877385063765360179602529417305=axigen===
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Heiko,

Some thoughts on this - by all means let me know your opinion though!
1) Makes sense - and that's what I'm doing currently, querying for proxy in=
formation (in Windows, including PAC files as well).
2) Unfortunately it's in Visual Basic - only because that takes care of all=
 the GUI / Windows crud, so it makes that part pretty transparent. As for f=
eatures, some thoughts ...
- automatic proxy detection (and applying that information)
- NTLM login to proxy server (using login information)
- automatic reconnect (when network connections change), or no reconnect if=
 on the same subnet as the server
- recurring ping ... to provide RTT information (plot and histogram)
- traffic plots (UL / DL traffic) ... and traffic indicators in the System =
Tray (state and traffic would be nice)

Just a few ideas ... :-).

Thanks!

... Russell


On Wed, 02/29/2012 12:57 PM, Heiko Hund <heiko.hund@...1489...> wrote:
> Russell
>=20
> On Wednesday 29 February 2012 17:26:46 Russell Morris wrote:
> > 1) I know that someone (Heiko?) was looking at auto-proxy a while back.=
 Is
> > this now working? Is there a way to test it (if it's now working), to s=
ee
> > what it determines for a proxy?
>=20
> During discussion of the Windows --auto-proxy patches at FOSDEM we've dec=
ided=20
> that the auto-proxy detection shouldn't take place within openvpn as it i=
s=20
> very platform specific and there's no apparent need to do it there. We re=
moved=20
> the --auto-proxy option from openvpn all together, it wasn't working much=
=20
> anyway and was only supporting Windows. In a future alpha/beta 2.3 releas=
e a=20
> GUI will be packaged that reacts to openvpn querying for proxy info via=20
> management interface. Currently I can't offer much to test, though. Sorry.
>=20
> > 2) I have a Windows GUI of my own (and I don't mean this as a "competit=
ion"
> > to the default OpenVPN GUI, not at all!!!). It's just tweaked for my
> > personal situation, on and off LAN and wireless, proxy, no proxy, etc. =
It
> > uses the management interface completely. In any case, it has some feat=
ures
> > that I like, more than anything wondering if there are thoughts of exte=
nding
> > the current GUI to include items like this (as I'd rather use the offic=
ial
> > GUI, I'm no SW expert - not even close). In any case, I have attached a=
 few
> > pictures, in case someone has any ideas about new features for the offi=
cial
> > GUI.
>=20
> Could you elaborate on the features you want to see included, please.=20
> Obviously you have some nice charts in your GUI. What language did you co=
de=20
> this in? I suppose it's not C with plain WIN32 API?
>=20
> Regards
> Heiko
> --
> Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
> Astaro a Sophos Company | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Ge=
rmany
> Commercial Register: Mannheim HRA 702710 | Headquarter Location: Karlsruhe
>=20=20
> Represented by the General Partner Astaro Verwaltungs GmbH
> Amalienbadstra=C3=9Fe 41 Bau 52 | 76227 Karlsruhe | Germany=20
> Commercial Register: Mannheim HRB 708248 | Executive Board: Gert Hansen,
> Markus Hennig, Jan Hichert, G=C3=BCnter Junk, Dr. Frank Nellissen
>=20
>=20
>=20
>=20=

--===axigen=4947873206877385063765360179602529417305=axigen===
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html><head><style id=3D"axi-htmleditor-style" type=3D"text/css">p { margin=
: 0px; }</style></head><body style=3D"font-size: 10pt; font-family: Arial; =
background-image: none; background-repeat: repeat; background-attachment: f=
ixed;">Hi Heiko,<br><br>Some thoughts on this - by all means let me know yo=
ur opinion though!<br>1) Makes sense - and that's what I'm doing currently,=
 querying for proxy information (in Windows, including PAC files as well).<=
br>2) Unfortunately it's in Visual Basic - only because that takes care of =
all the GUI / Windows crud, so it makes that part pretty transparent. As fo=
r features, some thoughts ...<br>- automatic proxy detection (and applying =
that information)<br>- NTLM login to proxy server (using login information)=
<br>- automatic reconnect (when network connections change), or no reconnec=
t if on the same subnet as the server<br>- recurring ping ... to provide RT=
T information (plot and histogram)<br>- traffic plots (UL / DL traffic) ...=
 and traffic indicators in the System Tray (state and traffic would be nice=
)<br><br>Just a few ideas ... :-).<br><br>Thanks!<br><br>... Russell<br><br=
><br>On Wed, 02/29/2012 12:57 PM, Heiko&nbsp;Hund&nbsp;&lt;heiko.hund@...1687...=
89...&gt; wrote:<br><blockquote style=3D"border-left: 2px solid rgb(00, 00,=
 204); padding-left: 4px; margin-left: 16px;"><div style=3D"font-family: Ar=
ial; font-size: 10pt;">Russell<br><br>On Wednesday 29 February 2012 17:26:4=
6 Russell Morris wrote:<br>&gt; 1) I know that someone (Heiko?) was looking=
 at auto-proxy a while back. Is<br>&gt; this now working? Is there a way to=
 test it (if it's now working), to see<br>&gt; what it determines for a pro=
xy?<br><br>During discussion of the Windows --auto-proxy patches at FOSDEM =
we've decided <br>that the auto-proxy detection shouldn't take place within=
 openvpn as it is <br>very platform specific and there's no apparent need t=
o do it there. We removed <br>the --auto-proxy option from openvpn all toge=
ther, it wasn't working much <br>anyway and was only supporting Windows. In=
 a future alpha/beta 2.3 release a <br>GUI will be packaged that reacts to =
openvpn querying for proxy info via <br>management interface. Currently I c=
an't offer much to test, though. Sorry.<br><br>&gt; 2) I have a Windows GUI=
 of my own (and I don't mean this as a "competition"<br>&gt; to the default=
 OpenVPN GUI, not at all!!!). It's just tweaked for my<br>&gt; personal sit=
uation, on and off LAN and wireless, proxy, no proxy, etc. It<br>&gt; uses =
the management interface completely. In any case, it has some features<br>&=
gt; that I like, more than anything wondering if there are thoughts of exte=
nding<br>&gt; the current GUI to include items like this (as I'd rather use=
 the official<br>&gt; GUI, I'm no SW expert - not even close). In any case,=
 I have attached a few<br>&gt; pictures, in case someone has any ideas abou=
t new features for the official<br>&gt; GUI.<br><br>Could you elaborate on =
the features you want to see included, please. <br>Obviously you have some =
nice charts in your GUI. What language did you code <br>this in? I suppose =
it's not C with plain WIN32 API?<br><br>Regards<br>Heiko<br><font color=3D"=
#999999">--<br>Heiko Hund | Software Engineer | Phone +49-721-25516-237 | F=
ax -200<br>Astaro a Sophos Company | Amalienbadstr. 41 Bau 52 | 76227 Karls=
ruhe | Germany<br>Commercial Register: Mannheim HRA 702710 | Headquarter Lo=
cation: Karlsruhe<br> <br>Represented by the General Partner Astaro Verwalt=
ungs GmbH<br>Amalienbadstra=C3=9Fe 41 Bau 52 | 76227 Karlsruhe | Germany <b=
r>Commercial Register: Mannheim HRB 708248 | Executive Board: Gert Hansen,<=
br>Markus Hennig, Jan Hichert, G=C3=BCnter Junk, Dr. Frank Nellissen<br><br=
><br><br></font></div></blockquote></body></html>=

--===axigen=4947873206877385063765360179602529417305=axigen===--


