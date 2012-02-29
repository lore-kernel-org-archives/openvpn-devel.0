From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 29 Feb 2012 11:17:38 +0100
Message-ID: <21488509.z1FzZULYLD@...1526...>
In-Reply-To: <319492303.20120228213418@...449...>
References: <4F4CE4FE.3010009@...515...>
	<CAOazyz0x4hKsREcGi+9TGc+AO0d+i1d5qbmPJ2hQfCsUbVanNQ@...278...>
	<319492303.20120228213418@...449...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
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
To: openvpn-devel@lists.sourceforge.net, Carsten =?ISO-8859-1?Q?Kr=FCger?= <C.Krueger@...448...>
Cc: "openvpn-devel@" <lists.sourceforge.netopenvpn-devel@lists.sourceforge.net>

On Tuesday 28 February 2012 20:34:18 Carsten Kr=FCger wrote:
> Add the following lines to client.ovpn
> --------------------------------
> management localhost 1000
> management-query-passwords
> auth-retry interact
> management-hold
> --------------------------------
> and start the service.

That's pretty much what the GUI is using at the moment.

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


