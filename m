Date: Fri, 10 Jun 2016 15:38:48 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160610133848.GE62247@...1296...>
References: <575AA2BD.60908@...277...> <20160610125457.GC62247@...1296...>
	<575AC1E2.9000802@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline
In-Reply-To: <575AC1E2.9000802@...277...>
Subject: Re: [Openvpn-devel] pull-filter reject = server hammering !
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 10, 2016 at 02:34:26PM +0100, debbie10t wrote:
> VPNB modifies VPNA client configs to include
> --pull-filter reject ""

How would VPNB do that?

And what would stop them from just inserting any of the other options
(like, the x509 validation stuff) that leads to "this server stinks, go
try the next one" - having the same effect?

[..]
> IMO,
> if a client wants to ignore and continue using a VPN - OK
> if a client wants to reject a pushed item then there must
> be a real reason, otherwise just ignore.
> If a client believes a server is pushing maliciously then
> they would *not* want to connect again, until it is resolved.

This is a client decision.  As with most of OpenVPN, we just give them
rope.  If they want to hang themselves, they are free to.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV1rC6KkuBuNlUUl1AQKshwP/SLCp8HELkAs/e7Ufx6GxL+kkSkpya9ys
kw4WRMz9fJV5xQHsPMB1X3Je8XxpKWQIwmZRtin2NbMLt+BGSsaY3GM4dqflRxPf
YafuAps4XH7o8ebtSYKorY2rfiVmN7tIA0nHTqFKfrJ3CwHpo6vKsUo2cziWu6IN
3sAPdgJsjHA=
=L1M+
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--

