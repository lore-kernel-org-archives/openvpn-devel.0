From: Heiko Hund <hhund@...194...>
Date: Fri, 26 Nov 2010 11:51:46 +0100
References: <4CEF8D73.4050202@...515...>
In-Reply-To: <4CEF8D73.4050202@...515...>
MIME-Version: 1.0
Message-Id: <201011261151.46403.hhund@...194...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (25th Nov 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

On Friday 26 November 2010 11:35:31 Samuli Sepp=E4nen wrote:
> Discussed the "Windows route add command failed" issue:
>=20
> <https://community.openvpn.net/openvpn/ticket/68>
>=20
> This lead into more high-level discussion about whether failing to add
> route(s) should be treated as a fatal OpenVPN error. Agreed that this is
> the case if OpenVPN fails to add non-existing routes, but not if OpenVPN
> fails when adding routes that already exist (e.g. local routes). Also
> agreed that OpenVPN should print a meaningful error message to logs
> (e.g. "Admin rights needed") if user lacks privileges to add routes.
> This message should also be pushed to the Windows GUI using the
> management API "echo" command.

I think this should rather be reported in the "state" notification, at leas=
t=20
that would be the best place for the GUI to grab it.

Heiko
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro GmbH & Co. KG | An der RaumFabrik 33a | 76227 Karlsruhe | Germany
Commercial Register: Mannheim HRA 702710 | Headquarter Location: Karlsruhe
=20
Represented by the General Partner Astaro Verwaltungs GmbH
An der RaumFabrik 33a | 76227 Karlsruhe | Germany=20
Commercial Register: Mannheim HRB 708248 | Executive Board: Gert Hansen,
Markus Hennig, Jan Hichert, G=FCnter Junk, Dr. Frank Nellissen

