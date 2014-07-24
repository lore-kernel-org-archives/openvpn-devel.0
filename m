Date: Thu, 24 Jul 2014 16:08:45 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140724140845.GT1118@...1296...>
References: <OF80C424FD.27405071-ONC1257C07.004692C7-C1257C07.004BC7CB@...1923...>
	<OFF4D01B5D.C068F160-ONC1257D1D.0055C3F1-C1257D1D.005A2BE1@...1846...>
	<9998AE72-2992-4D02-8E27-BE9A55BDBDF6@...1286...>
	<20140722193436.GI1118@...1296...>
	<OF0A6F87B6.7643FAD4-ONC1257D1E.00208574-C1257D1E.0022B4AF@...1846...>
	<53D02C7F.10900@...1147...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mhFEuq5UON706CVc"
Content-Disposition: inline
In-Reply-To: <53D02C7F.10900@...1147...>
Subject: Re: [Openvpn-devel] Openvpn 2.3.2: "Could not create temporary
	file" ....Too many open files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

--mhFEuq5UON706CVc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jul 23, 2014 at 11:43:27PM +0200, Jan Just Keijser wrote:
> >Gert, we are sure, there was not a problem with the resources (eg.:=20
> >max open files, max filed descriptors, etc.) on the system.
> >What else can I do about it?
> >
> try debugging this by adding some statements to the client-connect=20
> script, e.g.
>=20
> ls -l /proc/self/fd/* | wc -l >> /tmp/debug.log
> sysctl fs.file-nr >> /tmp/debug.log
>=20
> to find out if there really are no more filehandles available.
> For each connection a new client-connect script is started, so I doubt=20
> that any non-closed file handles will accumulate and cause this problem.

The error message came from OpenVPN, so if there is a leak, it's in
OpenVPN, not in the script.

OTOH, we use openvpn (git master) with client-connect scripts and=20
per-user generated configs on a moderately-loaded system, and have
not run into fd exhaustion issues - and lsof doesn't print anything
interesting either, so it must be something more interesting than
a forgotten close() call...

Arno, are you using plugins?  (A plugin runs in the OpenVPN context,
and if a plugin leaks FDs, it will affect OpenVPN as well)

How does a "lsof -p $processid" for the OpenVPN process look like after
it has run for a few hours?  Mine shows about 20 lines, and most of them
are shared libraries (/lib/...*.so.*) - if it is significantly more for
you, there is the problem.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--mhFEuq5UON706CVc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU9ETbakuBuNlUUl1AQKVQwQAtbevathDr/mLtjDoj4+XkdnkaOLP79h9
sIHK8ihv/EQnD3L37YARX4KnC2oo6N2opxaFwEW5C5gxF7namtpHwyLtJ5E/8VdY
Z9jQypsGVB+Gfsf/ByCVFu0ervZ7diH3wOyCKao1kbMtzCPzWMYXzSHe7/siIDvy
pj4n4pc22jQ=
=SQgT
-----END PGP SIGNATURE-----

--mhFEuq5UON706CVc--

