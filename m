From: Heiko Hund <hhund@...194...>
Date: Thu, 29 Apr 2010 08:07:04 +0200
References: <4BD83FC0.5090607@...515...>
	<201004281638.57498.hhund@...194...>
	<r2n9e0cf0bf1004280745v8f0d3cc9t439f516b6d06cb4@...278...>
In-Reply-To: <r2n9e0cf0bf1004280745v8f0d3cc9t439f516b6d06cb4@...278...>
MIME-Version: 1.0
Message-Id: <201004290807.04865.hhund@...194...>
Subject: Re: [Openvpn-devel] Any volunteer Windows devs to change OpenVPN
	proxying code to use "new" InternetQueryOption API?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On Wednesday 28 April 2010 16:45:47 Alon Bar-Lev wrote:
> On Wed, Apr 28, 2010 at 5:38 PM, Heiko Hund <hhund@...194...> wrote:
> > On Wednesday 28 April 2010 16:24:31 Alon Bar-Lev wrote:
> >> The IE API is user specific.
> >> As OpenVPN runs as a service using own user or system account, IE API
> >> is not suitable.
> >=20
> > Sadly I haven't found the WinHttpGetProxyForUrl API in MinGW W32API. So,
> > use of this might rather be a long-term goal as it takes a while to get
> > it included.
>=20
> No problem to add simple prototypes and perform GetProcAddress().

Not pretty, but yes.

> > If the service is started by the GUI it still makes sense to use user
> > specific proxy settings, doesn't it? One could consider auto-proxy for
> > auto-started VPNs a misconfiguration, as well. Or am I mislead?
>=20
> If this is a service that is started, it cannot access your proxy
> without more tweaks.

Currently not that's true, but the service interface needs to be extended t=
o=20
pass data between the GUI and openvpn in the future anyways.

Heiko
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro GmbH & Co. KG | An der RaumFabrik 33a | 76227 Karlsruhe | Germany

Astaro GmbH & Co. KG
Commercial Register: Mannheim HRA 702710
Headquarter Location: Karlsruhe
=20
Represented by the General Partner Astaro Verwaltungs GmbH
An der RaumFabrik 33a | 76227 Karlsruhe | Germany=20
Commercial Register: Mannheim HRB 708248
Executive Board: Gert Hansen, Markus Hennig, Jan Hichert, G=C3=BCnter Junk,=
 Dr.=20
Frank Nellissen

