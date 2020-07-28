Date: Tue, 28 Jul 2020 10:21:09 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200728082109.GB1431@...1296...>
References: <20200719173436.16431-4-arne@...1227...>
 <202007200930.06K9Utis092334@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="tkjB7lJ+uhit2utA"
Content-Disposition: inline
In-Reply-To: <202007200930.06K9Utis092334@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: client-connect: Add
 deferred support to the client-connect plugin v1 handler
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Fabian Knittel <fabian.knittel@...1547...>
Cc: openvpn-devel@lists.sourceforge.net

--tkjB7lJ+uhit2utA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jul 20, 2020 at 11:30:55AM +0200, Gert Doering wrote:
> Testing this with my new "client connect tester" plugin, I discovered
> two things:
[..]
>  - second, we read the "option file" ($ENV{client_connect_config_file})=20
>    multiple times on every PUSH_REQUEST - it works, but this is a latent
>    race condition, reading a "not yet fully written" file.  So we only
>    should do this on "final SUCCESS".

This has been addressed and fixed in commit 08f3c1cab73.

JFTR :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--tkjB7lJ+uhit2utA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfH9/0AAoJEB2Cnv7KVigSkp8L/08f3BzIKCZM9ul3BmnJqazB
70C4uzf8G8M6HLdtrVm1DurbPe9bG5xIvfYLIOi8Vfm4S+GxndanzrWGsUlWQQoh
URIGnouo9zlF/xgoW8L6nowP5ynHmL7pN6HcPGGW9jddB1pm/yp+SUB2vtE8wERO
p2TC1bBsJUDe63MTSVC0Z7deyv3XBydoXC+NotftiXQ9DUGpY96A72+RbjBMEJC7
LzyM6cjy+aiG5aQebbUOlXfHAWb2dA7T65iEtJb7RgluHZqkguQZfBzx6IPq8rLx
KJ24FI4kWXpB4IUpd2N+wHZzPGpDb+93l5ladj+RSFKc6xKu+/wPNIUsV+ZEVPs3
yEAs96GCcEAX7jewQfSlWuWtwCXILodM3lNyepah0TwPZ9nWTi8Uz3axR7dBEbL/
fCSOL2eODE9P/DzCnL8SD295auVwOWfwjMHQvkhLQxLgyHZHitbe8javTEdW+Hc3
VEPvIT35HvOL2Hnd3KwxiCt72KR7MBeqxyCG/eVVaw==
=0+S5
-----END PGP SIGNATURE-----

--tkjB7lJ+uhit2utA--

