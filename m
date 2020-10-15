References: <20201013204758.2472-1-gert@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <994754dd-f0e6-06f3-6f36-7ad9d555a069@...2080...>
Date: Thu, 15 Oct 2020 14:01:43 +0200
MIME-Version: 1.0
In-Reply-To: <20201013204758.2472-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="QtWWjZZfR7S0BeayfRxtSGcptoB34SBDQ"
Subject: Re: [Openvpn-devel] [PATCH] Avoid passing NULL to argv_printf_cat()
 in temp_file error case.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: Gert Doering <gert@...1296...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QtWWjZZfR7S0BeayfRxtSGcptoB34SBDQ
Content-Type: multipart/mixed; boundary="IIVosZeUofDbV5RKoKMOMsdyTnmZ5N0P6";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: openvpn-devel@lists.sourceforge.net
Cc: Gert Doering <gert@...1296...>
Message-ID: <994754dd-f0e6-06f3-6f36-7ad9d555a069@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Avoid passing NULL to argv_printf_cat()
 in temp_file error case.
References: <20201013204758.2472-1-gert@...1296...>
In-Reply-To: <20201013204758.2472-1-gert@...1296...>

--IIVosZeUofDbV5RKoKMOMsdyTnmZ5N0P6
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 13/10/2020 22:47, Gert Doering wrote:
> To pass username + password to verify_user_pass_script(), OpenVPN
> can either put both into environment, or create a temp file, and
> pass that file name to the "user-pass-verify" script.  The file
> name is initialized as "", so if no file is desired, it's well
> defined - but if the file can not be created, the pointer is NULL
> afterwards.
>=20
> Change the sequence of events, setting up the argv before the
> "if (file)" conditional, and add the file name only inside that
> clause, if creating the temp file succeeded.
>=20
> commit a4eeef17b2 did not create the problem, but modified the
> code enough so that the static analyzer in gcc 9.2.0 *now* noticed
> and issued a warning.
>=20
>  ssl_verify.c:1132:5: warning: '%s' directive argument is null
>               1132 |     argv_printf_cat(&argv, "%s", tmp_file);
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/ssl_verify.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
I've glared at the code and related code paths, plus (only) compile
tested this change.  And it looks reasonable.

There are also at least two other ways to fix this issue, where this
approach is a bit more intrusive.  One would be to add an "if
(tmp_file)" wrapping around the argv_printf_cat() call, another would be
to set tmp_file to an empty string in the else block with the error
message at line 1122.

But after all, the chosen approach gives a reasonable code execution
flow and I consider it cleaner.  I don't see any reasons why it would be
beneficial to format the command line only after creating the temp file.

So ...

Acked-By: David Sommerseth <davids@...515...>

--=20
kind regards,

David Sommerseth
OpenVPN Inc



--IIVosZeUofDbV5RKoKMOMsdyTnmZ5N0P6--

--QtWWjZZfR7S0BeayfRxtSGcptoB34SBDQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfiDoxAAoJEIbPlEyWcf3yW2AP/3N/l24CIhVfT1oUQjZNoMfs
MD+e1h5WzJDvDeGrnuUwlx/xOj5y5P3xTYRKstyu2STRLlyHEu3B0xM1nkhG72o9
N0n62foW8NNE/ib8sm4gix8uiGXjYPufxe1bpqNluLeREP6hc9zZWqP7YnepTRga
28QUfxVwRysoTpHrmE4H+wAbaeF9BBLCq9CmFIUIyWJ7ZBAdzUtRDoZ3le21/A89
hgU6+JLIQ5Xc19ckmwsJDplnDtvQmwylwfEjaAoDSTAC58r/eWtytu3XktAv9lDh
hcQDJ/d7DYgs1yvssRRt5X73G/HmjMhUS+ckAkL5tWe0w/P3aCrvpIqyWUrouK6L
0vGW1LOm387v7dG1xVQaoDw3Wb58neGhXze1NmW+6++uCIvtO47zye8GBQWuAaPd
PHZ+V/Yzwe4v03sZK1KLsjbg9S21zaABcb9LVNKa3lsAxPUA2DZzF0Al941B9Mcs
wXFX1w6L7B0AbT+wN9YvBQx6qNda57hnqz8MmjbilTmZ/NR4D2wJN2DQ00VduyPc
LpiqxflogAfIZX1zKyyNXDSwCwMcF9QYVMzgPLAxNOE0Ol5uyev92TRbj6bIqDul
n104nKsnPzWMQzz8WQ0Vrdy8bODPk0qePMbiuGxL+ZAthcQrUdVfs6kvYaSZPEeL
EoRbNJpDroG9ge9tZI/d
=woKp
-----END PGP SIGNATURE-----

--QtWWjZZfR7S0BeayfRxtSGcptoB34SBDQ--

