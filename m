Reply-To: openvpn-devel@lists.sourceforge.net
References: <1511554982-875-1-git-send-email-jim@...2322...>
 <14a28e53-a002-8c03-69e1-44af1529f080@...2181...>
 <18ff01d36c48$e396eac0$aac4c040$@carroll.com>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <57908e74-0039-0021-26f1-0ca2df32d53c@...2080...>
Date: Mon, 4 Dec 2017 23:46:11 +0100
MIME-Version: 1.0
In-Reply-To: <18ff01d36c48$e396eac0$aac4c040$@carroll.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="URvTKeor5i0PpfiOg9Ms8XH6kjJ82X3bR"
Subject: Re: [Openvpn-devel] [PATCH] Added OpenSSL FIPS 2.0 support to
 OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jim Carroll <jim@...2322...>, openvpn-devel@lists.sourceforge.net
Cc: 'Antonio Quartulli' <a@...2181...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--URvTKeor5i0PpfiOg9Ms8XH6kjJ82X3bR
Content-Type: multipart/mixed; boundary="hqvNb9AIOThH2rLj2XkoKb5kDGPSDqqWv";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Jim Carroll <jim@...2322...>, openvpn-devel@lists.sourceforge.net
Cc: 'Antonio Quartulli' <a@...2181...>
Message-ID: <57908e74-0039-0021-26f1-0ca2df32d53c@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Added OpenSSL FIPS 2.0 support to OpenVPN
References: <1511554982-875-1-git-send-email-jim@...2322...>
 <14a28e53-a002-8c03-69e1-44af1529f080@...2181...>
 <18ff01d36c48$e396eac0$aac4c040$@carroll.com>
In-Reply-To: <18ff01d36c48$e396eac0$aac4c040$@carroll.com>

--hqvNb9AIOThH2rLj2XkoKb5kDGPSDqqWv
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 03/12/17 16:10, Jim Carroll wrote:
[...snip...]
> You asked:
>=20
> 	>> +    * OpenSSL 1.0.2m
> 	>> +    * openssl-fips-2.0.2
>=20
> 	> I think the points above are expected to be ">=3D"?
> 	> Or are these versions strictly required?
>=20
> These versions are strictly required. While the fips module is binary
> compatible with OpenSSL 1.0.1x, it would not include OpenSSL bug fixes
> available in 1.0.2m which is required by NIST SP 800-171. And because the
> fips module is only tested and lab certified up to 1.0.2, you cannot take
> the new 1.1.0x branch.  This leaves the user with a single choice 1.0.2m.

[...snip...]

> You commented:
>=20
> 	> Some distro may even provide their own FIPS enabled packages.
>=20
> This is a good point. It is possible that the distro already includes
> OpenSSL 1.0.2m. I should change the instructions to suggest they check for
> this module and then let them know they can skip the step if they already
> have OpenSSL 1.0.2m installed.

According to this knowledge base article from Red Hat, this is how you FIPS
enable a system:  <https://access.redhat.com/solutions/137833>  (Requires a
registered account; no paid subscription needed)

Now, to a detail regarding the OpenSSL version.  RHEL 6 ships with
openssl-1.0.1e and RHEL 7 shipds with openssl-1.0.2k.  And both distributio=
ns
when configured according to the document above are FIPS compliant installs.
I suspect when RHEL 8 comes in the future, it will ship with OpenSSL 1.1.x =
as
well and it would surprise me immensely if that distribution would not be F=
IPS
compliant as well (as Red Hat has a lot of government customers as well)

So I don't think the version is as strict as you say.  But it might be other
distributions have gone through the compliance certification on a different
version.

For OpenVPN's part, I don't think we should enforce any strict versions.  It
is up to admin to ensure a compliant OpenSSL library is installed and the
system is configured accordingly to be FIPS compliant.


--=20
kind regards,

David Sommerseth
OpenVPN, Inc



--hqvNb9AIOThH2rLj2XkoKb5kDGPSDqqWv--

--URvTKeor5i0PpfiOg9Ms8XH6kjJ82X3bR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJaJdA3AAoJEIbPlEyWcf3y3NwQALTslJSGF8l7CDUYR4ql/UXq
jEMNOEn7xzeRoR2WQ7+gfLYEM3egjd3pISvR1qhXF+WheyqMFO4rDNnFQDzCHsj7
MA0DnDBlrjLZ90qAjqpJwa0glhm8K0KjNOg7poYvOZOhouIR1bR8OEMLhIHFKfdN
zvvknmVY/f+JtO1YU1b7cJamzQPSIkr8YkC9wJMaKws0vAVQFootyDVe5BjiiaMz
59f1mm/84N2nMohXaDXSuGV3x06v/mkftQcEtjBXGgXfiChvbrv4t2MRv0cFB6Ek
ueWdu677jNDqQyIRyBkIejt4lzY9SN+a7rvHa5Kl1aKslW8r+ZwyZTWM++vTPIVu
aC1RenZDZ6j77Z0heW2k6Qgo+KXCvRigXczOMHujTie0hZjEj6nUFb3Vi5gQHk2E
4ydQmTnFriXffOsl0pwPKDkOvqOGstcMcWmSTafSlpG1hWM/CYwDvuNs52kpxNjk
FLoBy1QQfwUtI9JD3a1cooqvHZcTm4oR99zNip/fK2PtI9JZ/QKQFsR0vNpMpsZ7
I0T/A0wY2i14BCWx9kqltpKxIBvxH63FXNugtws1D5ypzW6/CVP9CFUy/acUKA+i
p+D4rX+ZP6rOfsyXSyvZ/ztpeevDTJCuLr0W1bOY/iS9Q/D1sSm0j2yPYUpAOPbc
V+Piq6w09w9r06e8qMYV
=ALnW
-----END PGP SIGNATURE-----

--URvTKeor5i0PpfiOg9Ms8XH6kjJ82X3bR--

