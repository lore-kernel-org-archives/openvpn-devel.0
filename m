From: Russell Morris <openvpn@...1315...>
Date: Thu, 01 Mar 2012 19:54:29 -0600
Message-id: <1330653269656954500@...1315...>
In-reply-to: <1520356.eXbvvCDeOI@...1526...>
References: <4F4CE4FE.3010009@...515...> <1717163.B6krV9DGdl@...1524...>
	<1330556666604858500@...1315...> <1520356.eXbvvCDeOI@...1526...>
MIME-version: 1.0
Content-type: multipart/alternative;
	boundary="===axigen=4731447901168492319758770652387001962518=axigen==="
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
--===axigen=4731447901168492319758770652387001962518=axigen===
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Heiko,

Some thoughts, below.

Thanks!

... Russell


On Thu, 03/01/2012 03:11 AM, Heiko Hund <heiko.hund@...1489...> wrote:
> On Wednesday 29 February 2012 23:04:26 Russell Morris wrote:
> > 1) Makes sense - and that's what I'm doing currently, querying for proxy
> > information (in Windows, including PAC files as well).
>=20
> The functionality in the GUI will be the same as in the patches posted ea=
rlier=20
> using WPAD, PAC and the IE settings to get proxy info out of Windows.
> > Russell: Sounds good!
>=20
>=20
> > - NTLM login to proxy server (using login information)
>=20
> Isn't NTLM auth supported by openvpn already? I guess that'll be an easy=
=20
> improvement, just a checkbox to activate the option. Is there anything el=
se?
> > Russell: Yes - don't require storing the login information in a file, b=
ut rather apply the current user's login info. Make sense?
>=20
>=20
> > - automatic reconnect (when network connections change), or no reconnec=
t if
> > on the same subnet as the server
>=20
> Isn't that handled within openvpn good enough or does --keepalive not rea=
ct=20
> fast enough for your needs?
> > Russell: I can try this. My issue is that the reconnect needs to rechec=
k proxy information, and basically re-initiate the connection. It should al=
so reconnect after resume (standby / resume).
>=20
>=20
> > - recurring ping ... to provide RTT information (plot and histogram)=20
> > - traffic plots (UL / DL traffic) ... and traffic indicators in the Sys=
tem
> > Tray (state and traffic would be nice)
>=20
> Things like these are interesting for tech people, I don't think that the=
=20
> average user will get much out of it. UL/DL stats added to the tool tip o=
f the=20
> tray icon however is easy to implement and interesting enough to anyone t=
hat I=20
> like it immediately.
> > Russell: Sounds good to me - thanks!
>=20
>=20
>=20
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
>=20=

--===axigen=4731447901168492319758770652387001962518=axigen===
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html><head><style id=3D"axi-htmleditor-style" type=3D"text/css">p { margin=
: 0px; }</style></head><body style=3D"font-size: 10pt; font-family: Arial; =
background-image: none; background-repeat: repeat; background-attachment: f=
ixed;">Hi Heiko,<br><br>Some thoughts, below.<br><br>Thanks!<br><br>... Rus=
sell<br><br><br>On Thu, 03/01/2012 03:11 AM, Heiko&nbsp;Hund&nbsp;&lt;heiko=
.hund@...1489...&gt; wrote:<br><blockquote style=3D"border-left: 2px solid =
rgb(00, 00, 204); padding-left: 4px; margin-left: 16px;"><div style=3D"font=
-family: Arial; font-size: 10pt;">On Wednesday 29 February 2012 23:04:26 Ru=
ssell Morris wrote:<br>&gt; 1) Makes sense - and that's what I'm doing curr=
ently, querying for proxy<br>&gt; information (in Windows, including PAC fi=
les as well).<br><br>The functionality in the GUI will be the same as in th=
e patches posted earlier <br>using WPAD, PAC and the IE settings to get pro=
xy info out of Windows.<br>&gt; Russell: Sounds good!<br><br><br>&gt; - NTL=
M login to proxy server (using login information)<br><br>Isn't NTLM auth su=
pported by openvpn already? I guess that'll be an easy <br>improvement, jus=
t a checkbox to activate the option. Is there anything else?<br>&gt; Russel=
l: Yes - don't require storing the login information in a file, but rather =
apply the current user's login info. Make sense?<br><br><br>&gt; - automati=
c reconnect (when network connections change), or no reconnect if<br>&gt; o=
n the same subnet as the server<br><br>Isn't that handled within openvpn go=
od enough or does --keepalive not react <br>fast enough for your needs?<br>=
&gt; Russell: I can try this. My issue is that the reconnect needs to reche=
ck proxy information, and basically re-initiate the connection. It should a=
lso reconnect after resume (standby / resume).<br><br><br>&gt; - recurring =
ping ... to provide RTT information (plot and histogram) <br>&gt; - traffic=
 plots (UL / DL traffic) ... and traffic indicators in the System<br>&gt; T=
ray (state and traffic would be nice)<br><br>Things like these are interest=
ing for tech people, I don't think that the <br>average user will get much =
out of it. UL/DL stats added to the tool tip of the <br>tray icon however i=
s easy to implement and interesting enough to anyone that I <br>like it imm=
ediately.<br>&gt; Russell: Sounds good to me - thanks!<br><br><br><br>Heiko=
<br><font color=3D"#999999">--<br>Heiko Hund | Software Engineer | Phone +4=
9-721-25516-237 | Fax -200<br>Astaro a Sophos Company | Amalienbadstr. 41 B=
au 52 | 76227 Karlsruhe | Germany<br>Commercial Register: Mannheim HRA 7027=
10 | Headquarter Location: Karlsruhe<br> <br>Represented by the General Par=
tner Astaro Verwaltungs GmbH<br>Amalienbadstra=C3=9Fe 41 Bau 52 | 76227 Kar=
lsruhe | Germany <br>Commercial Register: Mannheim HRB 708248 | Executive B=
oard: Gert Hansen,<br>Markus Hennig, Jan Hichert, G=C3=BCnter Junk, Dr. Fra=
nk Nellissen<br><br></font></div></blockquote></body></html>=

--===axigen=4731447901168492319758770652387001962518=axigen===--


