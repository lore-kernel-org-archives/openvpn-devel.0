Date: Thu, 1 Aug 2013 16:30:58 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130801143058.GM16543@...1296...>
References: <kt8j7m$c5m$1@...1062...> <20130730145731.GW13127@...1152...>
	<20130730151406.GQ16543@...1296...>
	<51FA324F.1090108@...1147...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VZLKKa0PG5KXlQhV"
Content-Disposition: inline
In-Reply-To: <51FA324F.1090108@...1147...>
Subject: Re: [Openvpn-devel] [Openvpn-users] why doesn't openvpn negotiate
	settings?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, openvpn-users@lists.sourceforge.net

--VZLKKa0PG5KXlQhV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 01, 2013 at 12:02:55PM +0200, Jan Just Keijser wrote:
> It should be possible to add negotiation without completely breaking=20
> backwards compatibility; right now, when a server pushes an option to=20
> the client that is unrecognized the client will print a warning but it=20
> will not abort. This could be used to push a 'negotation request' - if=20
> the client responds then a negotation phase can start , during which the=
=20
> encryption key, hashing cipher, MTU settings etc can be negotiated. If=20
> the client does not respond the server would need to assume that it's a=20
> 2.3 or older client.

Maybe I'm a bit naive, but since the data layer cipher is independent of
the TLS cipher anyway, can't we just "push cipher xxx"?

Or is push/pull crypted with the data layer cipher?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--VZLKKa0PG5KXlQhV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUfpxIqkuBuNlUUl1AQJepwP/RMIJcOjI5gay0+Ay4cV7QulWAEyCy0+e
Hv4HWIlOS6bkO/XEEovJJjOx5uLhEedvNBP7QYprH5Js/9p4za1RgmyJoL0ZxdkC
0vOpXsOOht3tEEIxxYVma027uLq0PRJRXS8qSs/FKEFdhmIiyo3xRVxDrmyX+PuQ
cgUFPJrC7yw=
=QP1H
-----END PGP SIGNATURE-----

--VZLKKa0PG5KXlQhV--

