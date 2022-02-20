Date: Sun, 20 Feb 2022 15:06:37 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YhJK7fJArT4cSACJ@...1296...>
References: <20220216140457.6651-1-maximilian.fillinger@...2507...>
 <472272250.61274.1645030262738@...2642...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Lib8AxP/121/R7u9"
Content-Disposition: inline
In-Reply-To: <472272250.61274.1645030262738@...2642...>
Subject: Re: [Openvpn-devel] [Patch v2] Add warning about mbed TLS licensing
 problem
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: Max Fillinger <maximilian.fillinger@...2507...>, openvpn-devel@lists.sourceforge.net

--Lib8AxP/121/R7u9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Feb 16, 2022 at 05:51:02PM +0100, Frank Lichtenheld wrote:
> > Max Fillinger <maximilian.fillinger@...2507...> hat am 16.02.2022 15:04=
 geschrieben:
> >=20
> > Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
> > ---
> >  README.mbedtls | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
>=20
> Might be good to also add a note in the "Deprecated Features" section of =
Changes.rst?
> Just to increase visibility.

For v3, we've decided that we just mention the problem, but do not
state a formal depreciation date - the license issue is still under
debate, I've been told, so maybe we can continue to support mbedTLS.

We'll see... and 2.7 is quite some time away.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Lib8AxP/121/R7u9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiEkrtAAoJEB2Cnv7KVigSCO8MAK08DDDIRJuf2x6780CPPTUc
9fLrX1SMX2Ai5heXSvKqPAIChzzNOQcOD2AvyiJ4ZwmOSmMW/XrXkJMqt67pR9n6
VcmWifgMj2Gzzk4mPJqLSU0hRZYyFLxq0spP0ethbJw1gFDmMQhTOBKm3fBgysAX
5LHcjvMzb9VfwKpo8XA8tovAGQJv+CA0NnN7jkn1Oo/IAr8rkg7TQAwBLamFEvmh
TprZVKrXwVcWU+Ne15Ou/jKVYigI4DeSrXDikKKALZAqEOHeF4h17UMJM7FQnr+a
Dgvk51HycVvdrTqRXj5lAGaCkr3JdZC2c8bkNLwcqlZHb+VBWSljbsZ9iiY6iYth
EHV5Fj32KVyPbfBbu+DvHVIA1wQJ+gmaevdgLyJAIAyofiWqoVriW58h/5EmxYl7
AnGRZ0BuVPIxGkLmg6+b0mYKvnr00ZH21Wql0fOZ7TDlj9xm3zd+E31+ZkfjPKWv
/t5jYOnqAZRjvB5jynRBfWWN1xUimYbFpjPop/CMuA==
=7Djm
-----END PGP SIGNATURE-----

--Lib8AxP/121/R7u9--

