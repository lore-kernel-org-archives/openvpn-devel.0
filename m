References: <20200420102102.20981-1-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <c903b0d3-fa94-ff5d-686f-1e826d86405e@...1227...>
Date: Mon, 20 Apr 2020 12:31:27 +0200
MIME-Version: 1.0
In-Reply-To: <20200420102102.20981-1-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HUPvcpz2wyQbwjG3k56lLiwNJmmqNPBzR"
Subject: Re: [Openvpn-devel] [PATCH] remove bogus file check on --genkey
 argument
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HUPvcpz2wyQbwjG3k56lLiwNJmmqNPBzR
Content-Type: multipart/mixed; boundary="d2mQPjR0NxxaOqCsLzLUXeqRw4pL5s3Un"

--d2mQPjR0NxxaOqCsLzLUXeqRw4pL5s3Un
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 20.04.20 um 12:21 schrieb Antonio Quartulli:
> When invoking openvpn as standalone with the --genkey
> argument, options_postprocess() is not called at all
> because do_genkey() takes over the execution earlier.
>=20
> For this reason, checking the --genkey argument in
> options_postprocess_filechecks() is a no-op.
>=20
> Geti rid of the bogus check altogether.

Typo!

Acked-By: Arne Schwabe <arne@...1227...


--d2mQPjR0NxxaOqCsLzLUXeqRw4pL5s3Un--

--HUPvcpz2wyQbwjG3k56lLiwNJmmqNPBzR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl6def8ACgkQFRhsZwKx
RFR2nw/9Gz2iN7Alr2tS45IUBLbbdWi6ouPFl6B/VzsjMxsSLboxDM3iVb0uQ/B3
oUXMc3gfWva67npq4BK7ijtYVkdD30pX7nxvx4JYdG8/dhujCGohq1s9IOZxIi+R
ri+c9AIG3eRkGSb7bs/lUJkwydKQ/8uTYy4j2ygXmdptgScO1L0IQTtJEFtImXFa
mjhWly3b/4I+xYPMH6XPbBQY16J0/Ipz1wbgYI8SLFveXZ0ntmWISQJltbUgEfCq
Pae7nnB3v2XxCm8sGG54kLFpNMry3Q0oNUnELV/lmH3obsrc18+Oymf42lV9raTv
3eClhWnfrAGqSWl8VqGqslnHZn7MxqiCbtMur3PTsIgbOnadd+kuS0g2uauCHaEm
CFkYRQoT52EW0vpI8lkojAdUxh9FpwRGF9QfoeR3jrB0NBg5X1q/c2RwTflJhUmQ
/rKAvSSDhw3FISUh+bj2jC1JybK4GaqR1oVmGZ0b6PbVo4UN+Kw44Ki989Y+X7L+
PZLwJqLQRmglTdSThqWpdcYrO02Zn9glj4PCBAHwmu0xp/5JAzjPUOmUE6GDV29a
JdsWRHC/DwAgooeIJNpf8OGVIsQVZcb99Kc2DlepxZN7JHtG72Lipf/N7cxiV8oI
I6TikpyMf6UgDStjuZy+FVDwHX7Nrwd1uYczrp8b7u6u/oLuj+0=
=8/kT
-----END PGP SIGNATURE-----

--HUPvcpz2wyQbwjG3k56lLiwNJmmqNPBzR--

