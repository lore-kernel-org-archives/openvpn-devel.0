Date: Fri, 19 Nov 2021 20:18:10 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YZf4ch72IZYhz5Tb@...1296...>
References: <CAKuzo_gHxUQfam=J8uKtMAL2ma_Vu0zZcOBMgGHy4BtcQ5panw@...278...>
 <CAGyAFMXvP0iwEiE-G4-d6P4ANSRpr9w-tF++VDL-amgrmPmGuQ@...278...>
 <CAKuzo_gOVrTYqK7s3ZryCSxJmbXE1ogquTDyQfMfZ6GUy4coGA@...278...>
 <CAGyAFMXfhmN+79joNEgcGR9E-+3EMgWyWDCUcC7JAD5bWFvzAA@...278...>
 <CAKuzo_gY+U1KKwLZXiMM=t_2QvJkN3nKxYYhtwzSi2CMrNc9Pg@...278...>
 <CAGyAFMUXsMwaL=wrxrQBh0s+D0RrK=GYbGC1y+HNhXbgvCQq=A@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="OT/0skUkHKMKD85D"
Content-Disposition: inline
In-Reply-To: <CAGyAFMUXsMwaL=wrxrQBh0s+D0RrK=GYbGC1y+HNhXbgvCQq=A@...278...>
Subject: Re: [Openvpn-devel] OpenSSL build on Windows: OPENSSLDIR and
 MODULESDIR
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--OT/0skUkHKMKD85D
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 19, 2021 at 06:15:50PM +0200, Lev Stipakov wrote:
> OPENSSLDIR: "C:\Program Files\OpenVPN\ssl"
> ENGINESDIR: "C:\Users\lev\Projects\vcpkg\packages\openssl_x64-windows-ovp=
n\lib\engines-1_1"
> Seeding source: os-specific
>=20
> ENGINESDIR looks good, no? Is it something we use?

no, not good.

Should I ever want to use an engine, I'd need to create a "c:\users\lev\..."
on my client machine...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--OT/0skUkHKMKD85D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhl/hyAAoJEB2Cnv7KVigSLt0MAKhGlhzceS9mfKvlsEgpfErm
KptU+souP4sljAv7BeUZ4bAK8CLEUYGFSfkhNQ8BnXxUg2tMVBxUEvyvMWNpCo+6
TfcLp/kfsv7p0hF66EF5jVSGSFziZ3YvaN8fkN2XE47j2sB64OlevJUgNBuUdydh
DteH859m6xGoVz3ZWhxx8GS3ldjBr0i6z9+C4dkEP2C1dimTATC7PqvxIVvu72Kl
qnTdh69i92UpLSL0J6ejwTenVl3nLQqaAC4Hl9JbUesolxIMGfhdqCe7zk/UEiYO
bSnIQAabmRsEGtj4BWrE+ydGKX9BMz/9JsH/sPHh3xta4Oj1aNj3lZQ/dm+ftN5Z
TStA38trWSsBwIBW28Tf/UGgtdc2mPltm7BUfXHPyhEieEIJznU5yDaW90ArubX3
sS4uSV1vZR9i1VnRWBW34gIzaN3pI2zgJ/aH5H3c+mHzEBSAqhaiqzxjRayscCBt
YAcuIr5yz0IgQhBSLud3V4SCqNCGGiZBfWUkjeAYEw==
=6nKO
-----END PGP SIGNATURE-----

--OT/0skUkHKMKD85D--

