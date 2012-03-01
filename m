From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 1 Mar 2012 10:11:23 +0100
Message-ID: <1520356.eXbvvCDeOI@...1526...>
In-Reply-To: <1330556666604858500@...1315...>
References: <4F4CE4FE.3010009@...515...> <1717163.B6krV9DGdl@...1524...>
	<1330556666604858500@...1315...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN 2.3-alpha1 / GUI
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Russell Morris <openvpn@...1315...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Wednesday 29 February 2012 23:04:26 Russell Morris wrote:
> 1) Makes sense - and that's what I'm doing currently, querying for proxy
> information (in Windows, including PAC files as well).

The functionality in the GUI will be the same as in the patches posted earl=
ier=20
using WPAD, PAC and the IE settings to get proxy info out of Windows.

> - NTLM login to proxy server (using login information)

Isn't NTLM auth supported by openvpn already? I guess that'll be an easy=20
improvement, just a checkbox to activate the option. Is there anything else?

> - automatic reconnect (when network connections change), or no reconnect =
if
> on the same subnet as the server

Isn't that handled within openvpn good enough or does --keepalive not react=
=20
fast enough for your needs?

> - recurring ping ... to provide RTT information (plot and histogram)=20
> - traffic plots (UL / DL traffic) ... and traffic indicators in the System
> Tray (state and traffic would be nice)

Things like these are interesting for tech people, I don't think that the=20
average user will get much out of it. UL/DL stats added to the tool tip of =
the=20
tray icon however is easy to implement and interesting enough to anyone tha=
t I=20
like it immediately.

Heiko
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro a Sophos Company | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germ=
any
Commercial Register: Mannheim HRA 702710 | Headquarter Location: Karlsruhe
=20
Represented by the General Partner Astaro Verwaltungs GmbH
Amalienbadstra=DFe 41 Bau 52 | 76227 Karlsruhe | Germany=20
Commercial Register: Mannheim HRB 708248 | Executive Board: Gert Hansen,
Markus Hennig, Jan Hichert, G=FCnter Junk, Dr. Frank Nellissen


