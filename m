Date: Mon, 1 Oct 2012 10:39:15 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20121001083914.GS742@...1296...>
References: <12904-1349074708-498972@...1775...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+9kyDs7IugQ0lHaC"
Content-Disposition: inline
In-Reply-To: <12904-1349074708-498972@...1775...>
Subject: Re: [Openvpn-devel] Ability to send variable data from client to
	server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: f7n4ahbmp6@...1774...
Cc: openvpn-devel@lists.sourceforge.net

--+9kyDs7IugQ0lHaC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Oct 01, 2012 at 06:58:28AM +0000, f7n4ahbmp6@...1774... wrote:
> I believe there is ongoing development to allow a variable to be set in t=
he client config which can be used by the client-connect or route-up script=
s on the server. Specifically I need to add a custom route for each client =
depending on a value set in their config file.=20
>=20
> Can anyone point me to a thread where this is being tracked or the person=
 to whom this feature has been assigned as I would like to assist in develo=
pment if possible.

I'm not aware of such a development going on (doesn't mean nobody is=20
working on it, but it wasn't discussed recently on #openvpn-devel or this
list)

Can't you use the client's common-name or username for that?  That's what=20
everybody else seems to be doing...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--+9kyDs7IugQ0lHaC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUGlWsqkuBuNlUUl1AQKLPwQArioYAoqrcAyZ3IXV3zNdvNMl6kgGlpE9
dveOwAnYpMjdmO2bZ+t8QEfLSj5JxJ3D/LycHWp2ZJcSDARDpSmsbXNBAD4xXiV5
uJNC4pI9P8LwXBZritdCt1PMLDg2eic62WmnZQ39XO0+JH6ScXyDyWj1ahzO0WQ/
ZSwYf42jpbs=
=+lHf
-----END PGP SIGNATURE-----

--+9kyDs7IugQ0lHaC--

