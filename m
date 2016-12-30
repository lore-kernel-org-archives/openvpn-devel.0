Date: Fri, 30 Dec 2016 16:50:59 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161230155059.GZ78624@...1296...>
References: <CAFHpkQEeLcCtu3RrbzQLEzS8-2B74DTT_5yh1MRnVL7CZ3xcdg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RFt7YL+UU4NXVfbH"
Content-Disposition: inline
In-Reply-To: <CAFHpkQEeLcCtu3RrbzQLEzS8-2B74DTT_5yh1MRnVL7CZ3xcdg@...278...>
Subject: Re: [Openvpn-devel] couple of questions on trac#665
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--RFt7YL+UU4NXVfbH
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 29, 2016 at 09:56:44AM +0500, ???????? ?????????????? wrote:
> I seem to see several times issues like described in #665

It came up on openvpn-users yesterday as well, and that's a bit weird
as our test set covers the case in question ("connect to different remotes
on the same tap device") and I never saw this.  Must be timing related.

> what seems to be strange is couple of things:
>=20
> 1) "OR" clause. why not "AND" ?
> https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/tun.c#L6012-L6=
013

Because both are "not".  So "if not write() or not read() -> error".

The code is correct, otherwise you'd end up with this error
message ("TUN: could not talk to service") which is not there in=20
the logs.


> 2) error message seems to be irrelevant
> https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/tun.c#L6034
>=20
> it might be an error from earlier function calls, not only FlushIpNetTable
> itself.

How?  status is either set in line 6019 or in 6023.  There is no way
6034 can be reached without calling either the iservice-based flushing
or directly calling FlushIpNetTable() - so status is always relevant.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--RFt7YL+UU4NXVfbH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYZoJjAAoJEB2Cnv7KVigSdHcL/0NzY5wf3UPQdx2r6qw0e+uY
LboJVto3G1Iqu+u3SXzLbSjhysFdteDD+WZNdXugyGS3UtStwaT0O24dZiUCW5Da
SVt3k0WzqHuGRJ2Ceo9uhNYPm7SZZBD9xWYxlHq7puDJ4Vf0soXkhQiPn2di3G7w
IER1RrKXGvtGZXIrpnneZFUCnxAobD38CBnBmUgtNVdHYO3i/UxM4fJnwRvoP6NO
UyjJTEQOcnWj3SWjof5Jqax7dGVPii4IAIqHX189TFZzZ/89/vA2Rd4pbNnZhQ+q
egHcbcjXFvJwHln4q2DbAEhGmhn3TKDqsUiO5tsBxPPMNk9vWnTmigsxza6yFfp+
tJa/e6RVhj88sWqhCqAKG4YNGccZtx6A4M1YY71wBwyimXk6SzsipCUnmZb5x+V6
BANZeHkqEmv5K49hc+zwskVdgrxIQS1uaneVMB5DphysSU+0/idKsKHCWIp9O4M0
t2FDy54Ytsc1WHjhmLblAQDuhg1xMmsJ78xBf6Ftrg==
=I9TB
-----END PGP SIGNATURE-----

--RFt7YL+UU4NXVfbH--

