References: <20200528235423.27416-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <bba548e3-f796-f871-fd52-450b3b1cbdab@...2080...>
Date: Fri, 29 May 2020 15:51:15 +0200
MIME-Version: 1.0
In-Reply-To: <20200528235423.27416-1-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Eo43K3xMEWd2mNpRIB6af1v2fkHzw0vEz"
Subject: Re: [Openvpn-devel] [PATCH] Add .git-blame-ignore-revs with
 reformat commits
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Eo43K3xMEWd2mNpRIB6af1v2fkHzw0vEz
Content-Type: multipart/mixed; boundary="rxFHrk0PmkCU5rg5ukkwdPS1yIAg0lJCw";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <bba548e3-f796-f871-fd52-450b3b1cbdab@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Add .git-blame-ignore-revs with reformat
 commits
References: <20200528235423.27416-1-arne@...1227...>
In-Reply-To: <20200528235423.27416-1-arne@...1227...>

--rxFHrk0PmkCU5rg5ukkwdPS1yIAg0lJCw
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 29/05/2020 01:54, Arne Schwabe wrote:
> This allows git blame to ignore reformatting changes and instead
> shows the previous commit that changed the line.
>=20
> To avoid manually building the list of commits this commit
> adds a file with a list of reformatting commits. I might have
> missed a few but this should be a good start. To use the file
> use:
>=20
>    git blame --ignore-revs-file=3D.git-blame-ignore-revs file
>=20
> or to automatically always use the file
>=20
>    git config blame.ignoreRevsFile .git-blame-ignore-revs
>=20
> Naming the file .git-blame-ignore-revs is a convention.
>=20
> Some more details in this random blog post:
>=20
> https://www.moxio.com/blog/43/ignoring-bulk-change-commits-with-git-blame
>=20

Feature-ACK ... the commit message could also mention that git 2.23 is need=
ed
as well.

> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  .git-blame-ignore-revs                        | 29 +++++++++++++++++++
>  .../managent-demo/management-demo-server.py   |  0
>  contrib/ovpnkeys.py                           |  0
>  3 files changed, 29 insertions(+)
>  create mode 100644 .git-blame-ignore-revs
>  create mode 100644 contrib/managent-demo/management-demo-server.py
>  create mode 100644 contrib/ovpnkeys.py
>=20
> diff --git a/.git-blame-ignore-revs b/.git-blame-ignore-revs
> new file mode 100644
> index 00000000..3cc811cf
> --- /dev/null
> +++ b/.git-blame-ignore-revs
> @@ -0,0 +1,29 @@
> +# Uncrustify the tests/unit_tests/ part of our tree.=20
> +da1574ef7826d73f01e120cbd1ba40ce39a305b7
> +
> +# Another round of uncrustify code cleanup.
> +9cf7b4925a54d93fbea1cadcf3dc0e11f3ce358f
> +
> +# networking_sitnl.c: uncrustify file
> +2c45d268ca65c522fbabb7c4dab5e721296b4623
> +
> +# Uncrustify tapctl and openvpnmsica
> +6280d3d5536174934ee22d3840457d61896e0e3a

Missing a blank line here, for consistency

> +# tun.c: uncrustify
> +baef44fc8769bbd99f4d699ce9f63180c29a5455
> +
> +# networking_sitnl.c: uncrustify file
> +2c45d268ca65c522fbabb7c4dab5e721296b4623
> +
> +# uncrustify openvpn sources
> +f57431cdc88f22fa4d7962946f0d3187fe058539
> +
> +# More broadly enforce Allman style and braces-around-conditionals
> +4cd4899e8e80efae03c584a760fd107251735723
> +
> +# Merge 'reformatting' branch into master
> +1f004b2f06e987d73e48f7fd7b96b0b248274f58

Are you sure this "merge" commit shouldn't be commit 81d882d5 instead?

> +
> +# The Great Reformatting - first phase
> +81d882d5302b8b647202a6893b57dfdc61fd6df2
> +
> diff --git a/contrib/managent-demo/management-demo-server.py b/contrib/ma=
nagent-demo/management-demo-server.py
> new file mode 100644

This file shouldn't be included in this change.

> index 00000000..e69de29b
> diff --git a/contrib/ovpnkeys.py b/contrib/ovpnkeys.py
> new file mode 100644
> index 00000000..e69de29b
>=20

So a few minor things to look into, otherwise this is really valuable.

I would probably also consider to also add a note about this git feature in
README.  It's not the most ideal file, but I struggle to find a better place
currently (I might have overlooked something).  We would probably benefit
having a separate developers README with all the hints, tips and tricks
developers would need to care about.  That is, however, out of scope for th=
is
change.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--rxFHrk0PmkCU5rg5ukkwdPS1yIAg0lJCw--

--Eo43K3xMEWd2mNpRIB6af1v2fkHzw0vEz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJe0RNYAAoJEIbPlEyWcf3yTM0P/icjWJf4cJ/wXzgZ7drmqI5L
xxv8yWu5Ga6rez5odFtPnNtdnhOZ2CdjoPRE0YVE66C1zI2jpA0ysWFO7UZO3Olc
la4trw3+ZlZcGeLo421zIvcRhK7/vK0A8BpMKtbemZMd4eX4y3AWD2xYpkH46WoN
3o8vuo2nWCeqAwV7aYk5B0DrdsAWa1vNY1leaPS4HLAtMow8BhF/y+LOob6aC3a5
fNmFRiWQdbLEMWHyB9Ke8ilD8cBoa387K22AXT9lyuQKTLY6I156CPyzYSoAFuU1
q7Qn1C9nK/snDjUjkguPQkSwl85CiQDztll/R15B9zfkyGE5KUhwtGS+ZYVd59bX
QEDebwYZfQqRCS9vCYnf7LX3xqRhoCDphLGitPf7fTibWk7WpHKPqpuaUNIjH2/z
gONvrfKYMqcIzARwmJCFi0A4ba6obaetl/1s/cS1d58aL5bmkg3yxPxPVU9Ko1Mv
YSkagNLFo871L0I1YIaj8tq3kEzUzbUzd9I89fJYpYiiTzd7VoeilyTb4Jy0O8vk
nA0tt4OkzfyIWM/FYu1JyfIbUQEkizeA093RQ8yQmth6egywcDu/KIFjQhQ32FJm
Wj+XrselpxHwx/1zyqVgj3vuIyJuwJ6hn6DTpjMJIWY1qmBaiBm8c3qAkKVCdWI5
gOtoGyS6dMAW7RRZZSAH
=s0vf
-----END PGP SIGNATURE-----

--Eo43K3xMEWd2mNpRIB6af1v2fkHzw0vEz--

