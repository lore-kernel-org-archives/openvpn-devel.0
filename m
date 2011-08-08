From: Heiko Hund <heiko.hund@...1489...>
Date: Mon, 8 Aug 2011 16:08:22 +0200
References: <1311649077083710500@...1315...> <1311721403985112500@...1315...>
	<1312758902759591500@...1315...>
In-Reply-To: <1312758902759591500@...1315...>
MIME-Version: 1.0
Message-Id: <201108081608.22398.heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] Windows Auto-Proxy
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

Hi,

On Monday 08 August 2011 01:15:02 Russell Morris wrote:
> Has anyone had any luck with the auto-proxy function, in particular with
> PAC files? It really doesn't seem to be working for me ... :-(.

Are you aware of https://community.openvpn.net/openvpn/ticket/24 ? This is=
=20
probably what's causing your trouble... and of course the fact that the=20
current impelmentation does not do proxy auto detection.

I'll start resolving these issues now as it is something the GUI is relying=
=20
onto as well. Openvpn should even be able to handle per Dial-up and VPN=20
connection proxy settings if things work out.

> Also, does anyone have a proxy server that requires authentication? I
> currently use a text file (which does work!), but there are also Windows
> functions that should send domain login information automatically. It
> would be nice to to that ... :-).

I like that idea, but t's probably unrelated to auto-proxy. Could you point=
 me=20
to the APIs.

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

