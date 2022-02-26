Date: Sat, 26 Feb 2022 11:15:26 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Yhn9vqmohOvaTd2Z@...1296...>
References: <20220224172330.43451-1-mohsin92@...1835...>
 <202202261012.21QACBPu018046@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="zgjIOtJvv47E+0eu"
Content-Disposition: inline
In-Reply-To: <202202261012.21QACBPu018046@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Ignore deprecation warning
 for daemon on macOS
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Saifur Rahman Mohsin <mohsin92@...1835...>
Cc: openvpn-devel@lists.sourceforge.net

--zgjIOtJvv47E+0eu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Feb 26, 2022 at 11:12:11AM +0100, Gert Doering wrote:
> Acked-by: Gert Doering <gert@...1296...>
>=20
> Thanks for your submission.  Indeed, this is the same as Arne sent in
> commit a480eaae1d32a6, which was only applied to one of the plugins in
> question (plugins/down-root) and not plugins/auth-pam.
>=20
> Your patch has been applied to the master branch.
>=20
> commit d5c1ec2913620cec5b453c35d5c851f8c79a7ae1
> Author: Saifur Rahman Mohsin via Openvpn-devel

Unfortunately, I saw the "via Openvpn-devel" too late, so had to
reset "--author" to contain the correct mail address - thus, the commit
ID changed before pushing

commit cd194f552f67a1ad7951d0de9dba7448a3880805
Author: Saifur Rahman Mohsin <mohsin92@...1835...>

Apologies for the confusion.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--zgjIOtJvv47E+0eu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiGf29AAoJEB2Cnv7KVigSZEYL/RNb7qjhZ0WHyqopW43tTH+x
6xhF0dEXLVYSdC9XLbB9I5gRtpZyIp6VooXk4rpwW+Mk/GUjO3eHW+xtiFofevoq
LkDGjlD25/j/Ge8WFVmesuj+sPMFwKqPFbNv7asMk7nZPKKZQrbfg9CeG/CCmtiH
0a8/aLiQO+1njj35IitiVZOudnVzB9Hmgx5GsgZGL13AFSTNSofJgWTiqUvCcN/M
7Hcow/x/maEwGPv05IQCabq6WFLNVaTBxk/xCmuIZJdAGxPo8QrlwBdcF7idG+s7
xUCEhZe26OW/x4+GGva0j/ASS9NDo2UU2VrBYex7p7ZfkF8hlkFFVF3G6JGXUu4b
VvsorNAtYAFFX1Ed8PqgUh1lyt+ij+xHy/GocVYdei+tGsLb5Ia4fBlH59z1nQ9n
Jpgh9RyhvFHloMEpiRVCGBUdf7FzZha0tskr8e5JoSxuGAinHTr19OkECFDd8Hji
nzeXLjICOG2ZPadPtwOdeA8hAsZkbVcANKq3Tg4+vQ==
=QGZE
-----END PGP SIGNATURE-----

--zgjIOtJvv47E+0eu--

