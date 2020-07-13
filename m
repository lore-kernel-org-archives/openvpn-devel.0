Date: Mon, 13 Jul 2020 14:06:10 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200713120610.GX1431@...1296...>
References: <20200711093655.23686-1-arne@...1227...>
 <20200711093655.23686-4-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="j3c9wG5bhwVbKt4m"
Content-Disposition: inline
In-Reply-To: <20200711093655.23686-4-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v5 04/14] client-connect: Move
 multi_client_connect_setenv into early_setup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--j3c9wG5bhwVbKt4m
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sat, Jul 11, 2020 at 11:36:45AM +0200, Arne Schwabe wrote:
> From: Fabian Knittel <fabian.knittel@...1547...>
>=20
> This patch moves multi_client_connect_setenv into
> multi_client_connect_early_setup and makes sure that every client-connect
> handling function updates the virtual address selection.
>=20
> Background: This unifies how the client-connect handling functions work.


Tested on the server side framework, all tests succeed
=20=20=20=20
23...
Test sets succeeded: 1 1a 1b 1d 2 2a 2b 2c 2d 3 4 5 6 8 8a 9.
Test sets failed: none.
24...
Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2d 2e 3 4 4a 5 6 8 8a 9.
Test sets failed: none.
master...
Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2d 2e 3 4 5 6 7 7a 8 8a 9 =
2f 4b
.
Test sets failed: none.
=20

The patch itself looks a bit strange, now code seems to be duplicated...

... hopefully this gets better in the next patches.
=20
gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--j3c9wG5bhwVbKt4m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfDE4qAAoJEB2Cnv7KVigSFZIL/j85OlRqp/8HifQ3ULLii9X6
t3l5RbQY5TDCzgZ/JCTYQkgdsZe2XzjpTNmjL9YX1xtN5xjgqv+RdJcPUV1pFCd6
nXxR4JyR93UuU7YCnsP9TOxdw5iWZNXRGnZPKTeygKrzOVuxuv06lSq3E5Ng+MmQ
XJlkln9eYP84rL9tBvoY9+i9e6rAohx/CjMZuS0HXDaz+jq7OJXmg+LzEyI1DUND
Hmkt9rJzBojuJpeAZcwaqAvjGRMEKys3YFYx13u2v/JxP4S5eHHMEer8aVjR66Ye
9eow3Lk69YsPl2NVKgb47NO/4WmkLv9KBer5NriR3/EboT1KVSglqjc7mj3ow8Gd
A5c0wegtk1N4V209pqJxXLjawUMXIctwubPCTQSf1YgMqHcSIWScY7OLlrGq232g
vkutjuyxVIuyGioD+oRP8CdoJCxZZx06ks2ZkA6V9cHo8BZpCE6rmM/r4FwyLsWv
iujyk0zyy2btt0OibdYlAnIRzlpUnWh8XFbSuq6XPQ==
=hP5+
-----END PGP SIGNATURE-----

--j3c9wG5bhwVbKt4m--

