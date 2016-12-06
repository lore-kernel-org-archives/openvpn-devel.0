Date: Tue, 6 Dec 2016 22:18:18 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161206211818.GQ78624@...1296...>
References: <CAFHpkQFgmWBhUb6YZOGFeR7Eyz34tFbN5BQEzafj0tpqtbmwyQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XQSDX3NWE02rtiZq"
Content-Disposition: inline
In-Reply-To: <CAFHpkQFgmWBhUb6YZOGFeR7Eyz34tFbN5BQEzafj0tpqtbmwyQ@...278...>
Subject: Re: [Openvpn-devel] fuzz testing by google ?
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

--XQSDX3NWE02rtiZq
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Dec 02, 2016 at 08:48:29AM +0500, ???????? ?????????????? wrote:
> https://opensource.googleblog.com/2016/12/announcing-oss-fuzz-continuous-=
fuzzing.html

This is generally interesting, of course.

Fuzzing openvpn "as a whole" is quite complicated, though - we do check
our input very well, so the last time someone tried to fuzz TLS packets
to make openvpn "do bad things", all he got was "go away, you stink,
session destroyed" :-)

Anyway - so what's necessary to make this google fuzz testing work?  Do
we instrument our code, or just tell them "hey, here's a useful piece
of software, go figure it out yourself"?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--XQSDX3NWE02rtiZq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYRysZAAoJEB2Cnv7KVigSKhsL/RdCN8pv0JbeDq6zcCA/u51+
cFYsoDCdjI3VVMDbbFsfvgBdFHNnBMzHfQrSC8Hqklxwn22VHOjuw09DN+ET04pJ
pTsqRZgBhTnFBlWKv3NLufvEVGYJndIAz6dikmQPs/Fe6lTs+eXpxWXb/rd3X76b
HdYrZYlsxTkeYpILtIndPbudmuvic6FytvTRo2COAcY9UWsTN1lPCVUoF6b3mdZi
CdluIolGG8TUviMJbrqeb1xk9OIVdschY4G5X7r7KlIFe/xdw2EQZtGHGzVvwpBi
Sc5Sj+L1d8B5ThY2NjugJK2ZMND/XWf04aGMNU5Z6RlDVyOeJZVViYptKK4mqKZr
DPsUQlJsaXzVUiVVk017e63QRNmfn6VaxctIx7eRdcwKsjfo8iqNoHrkYFkkN17O
lE74YAkDA6T68gDTXuYNrc57DM07OTL621XCOtSrENCr2tp6KUucTZUZPie/5I8h
cD/oIE3eNXDCznXGt2u2rG8ELxb9RbVG6TDvV0sy1Q==
=JmbT
-----END PGP SIGNATURE-----

--XQSDX3NWE02rtiZq--

