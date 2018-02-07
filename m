Reply-To: openvpn-devel@lists.sourceforge.net
References: <CAFHpkQEFPO+TsXdqva=OGg_9FnErDH7Uw9fs876Co_q2A4=rmA@...278...>
 <CAKuzo_hdyx3MH5Cw=gEujHhEvQ1wnOaZ2r0n7=j3GSsv_C1Z2Q@...278...>
 <CAFHpkQFtN6jk5bNcksmoBDjjMd3UbW4sN+y5rH0zUb2sgDq=gg@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <6febf54c-f7ab-2297-2c75-72235e14e1c5@...2080...>
Date: Wed, 7 Feb 2018 20:58:24 +0100
MIME-Version: 1.0
In-Reply-To: <CAFHpkQFtN6jk5bNcksmoBDjjMd3UbW4sN+y5rH0zUb2sgDq=gg@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="7rk2P3nbObUxc8g4lJY6MBKSNf9OW5pRc"
Subject: Re: [Openvpn-devel] [Openvpn-users] "Reconnect" button in
 openvpn-gui
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, "openvpn users list (openvpn-users@lists.sourceforge.net)" <openvpn-users@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7rk2P3nbObUxc8g4lJY6MBKSNf9OW5pRc
Content-Type: multipart/mixed; boundary="PNfGVwIuSJIsexMSnE1NlEIFZbWX5DxjX";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
 Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 "openvpn users list (openvpn-users@lists.sourceforge.net)"
 <openvpn-users@lists.sourceforge.net>
Message-ID: <6febf54c-f7ab-2297-2c75-72235e14e1c5@...2080...>
Subject: Re: [Openvpn-users] [Openvpn-devel] "Reconnect" button in openvpn-gui
References: <CAFHpkQEFPO+TsXdqva=OGg_9FnErDH7Uw9fs876Co_q2A4=rmA@...278...>
 <CAKuzo_hdyx3MH5Cw=gEujHhEvQ1wnOaZ2r0n7=j3GSsv_C1Z2Q@...278...>
 <CAFHpkQFtN6jk5bNcksmoBDjjMd3UbW4sN+y5rH0zUb2sgDq=gg@...278...>
In-Reply-To: <CAFHpkQFtN6jk5bNcksmoBDjjMd3UbW4sN+y5rH0zUb2sgDq=gg@...278...>

--PNfGVwIuSJIsexMSnE1NlEIFZbWX5DxjX
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 07/02/18 20:32, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
> After auth-token were introduced, when user press "Reconnect", it leads to
> auth fail (saved password is forgotten), we run about 1000 users, nobody
> complains.

This is actually expected, I'd say - but smells like a bug on the server si=
de
authentication.

Selva may correct me if I'm wrong, but my understanding of it when clicking
"Reconnect", the local OpenVPN process which caches the auth-token is stopp=
ed
and a new OpenVPN process is started.  The client should in this case ask f=
or
username/password again.  So in this case, the server side should treat this
connection as a fresh connection with no initial state.

The step of stopping the local client and starting a new and fresh one is
definitely not a bad feature to have on clients.

> It looks like nobody uses that button.
>=20
> So, I asked several users, they confirmed they do not use Reconnect.

This is no good argument for me.  This is one specific setup with 1000 user=
s.
It would be more valuable with 50 different setups having 20 users each.  Y=
our
conclusion is based on a very homogeneous environment.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--PNfGVwIuSJIsexMSnE1NlEIFZbWX5DxjX--

--7rk2P3nbObUxc8g4lJY6MBKSNf9OW5pRc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJae1pgAAoJEIbPlEyWcf3ybk8P+wSx67Fkf6Y/GlQLIE449Zlp
eo5RDS9EYl5fx6cy22eN9JvxxfU3thWoufzRZbwhBs6sequIxFzrO2lNOvuWwHoo
5llIwk+iwvwgQy6fVGw5SEvCyFs2VJurk/oQw8g85aXtUOCRY2v6I2yEN9IwYmdp
iiKxrqcydSziSNMuDXDqPYksOIKAbXkCSNAqKrtJoe50sBLlBmzGa7jQf+iuhC2o
JmTmlDGi9Z2yxf4GHku00z136kBDAhX8l6G1ZZzFf+65tlWFnFd6j6XcyGcE65uf
pfTV0GDTue2Wb6uK8+J0mEr3NsswqsAPKlfYSVqL6bJUM81UfnLcPjPZP2hKfGTF
GtRCE50TfAd3TqXTQSiMx/Vxiu1oQeik1RzEwwJbLHSZ0lAoy0SiokXvMxX5pQw7
NRVdNvKm6SwY6iszhTbQVYs2lnp8dqCijqH1Vk2LqswRrafgRt033qUGUrBqao3k
ZOExg3+MopdT7irhx4pA35p1btMvPDmM2qKoDaD1opMNtC2RO4z+loa1tLcynVGG
Id4BFCVdxVbYa0crzPaEgXqkUOOcLw1XZaPqIRz/AzfsO1weuCd6j1b7tAdA0TrW
2i2biCQBz3XH7TjmKUKEniYXgkkRXFEAl1hdnCIfQHQQJB2Xj+JeG+mNB0lRAFC9
P1JgB4u/vMRbU4kUQJPS
=JJbs
-----END PGP SIGNATURE-----

--7rk2P3nbObUxc8g4lJY6MBKSNf9OW5pRc--

