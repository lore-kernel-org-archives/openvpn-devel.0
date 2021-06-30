References: <20210520150932.2565217-1-arne@...1227...>
 <20210520150932.2565217-2-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <a583e303-02f6-dfeb-453d-8c1979c8b29f@...2080...>
Date: Wed, 30 Jun 2021 20:45:14 +0200
MIME-Version: 1.0
In-Reply-To: <20210520150932.2565217-2-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1xXhqerMXMvhy5cZcVg0WxyQY2qJAybo9"
Subject: Re: [Openvpn-devel] [PATCH v2 2/2] Add detailed man page section to
 setup a OpenVPN setup with peer-fingerprint
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1xXhqerMXMvhy5cZcVg0WxyQY2qJAybo9
Content-Type: multipart/mixed; boundary="aC3oCTACdwn7SpRDNiSNyC10fulVfwFYd";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <a583e303-02f6-dfeb-453d-8c1979c8b29f@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/2] Add detailed man page section to
 setup a OpenVPN setup with peer-fingerprint
References: <20210520150932.2565217-1-arne@...1227...>
 <20210520150932.2565217-2-arne@...1227...>
In-Reply-To: <20210520150932.2565217-2-arne@...1227...>

--aC3oCTACdwn7SpRDNiSNyC10fulVfwFYd
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 20/05/2021 17:09, Arne Schwabe wrote:
> This is meant to give new users a quickstart for a useable OpenVPN
> setup. Our own documentation is lacking in this regard and many
> tutorials that can be found online are often questionable in some
> aspects.
>=20
> Linking the individaul RST file on github also give a tutorial
> in a nicely formatted way.
>=20
> Patch V2: Fix grammar/spelling mistakes (thanks ticantech), move
>            to openvpn-examples(5).
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   Changes.rst                              |   4 +
>   doc/Makefile.am                          |   1 +
>   doc/man-sections/example-fingerprint.rst | 196 +++++++++++++++++++++++
>   doc/openvpn-examples.5.rst               |   1 +
>   4 files changed, 202 insertions(+)
>   create mode 100644 doc/man-sections/example-fingerprint.rst

This is basically good; I do have some really minor nit-pick.  I've=20
tested an OpenVPN server built from git and with both a git master=20
client as well as a v2.5.3 client.  Both works with the instructions as=20
given here.   And both man and html files are created correctly.

One confusing thing is that the server config complains about missing CA=20
if there are no peer-fingerprint entries are present.  But that's=20
outside the scope of this documentation.

The nit-pick comes below ...


> diff --git a/doc/man-sections/example-fingerprint.rst b/doc/man-sections/=
example-fingerprint.rst
> new file mode 100644
> index 000000000..c91ca64b9
> --- /dev/null
> +++ b/doc/man-sections/example-fingerprint.rst
> @@ -0,0 +1,196 @@
> +Small OpenVPN setup with peer-fingerprint
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[...snip...]
> +3. Write a server configuration (`server.conf`):
> +::
> +
> +    # The server certificate we created in step 1
> +    cert server.pem
> +    key serverkey.pem
> +
> +    dh none
> +    dev tun
> +
> +    # Listen on IPv6+IPv4 simultaneously
> +    proto udp6
> +
> +    # The ip address the server will distribute
> +    server 192.168.234.0 255.255.255.0

Elsewhere in our documentation, we've been using 10.8.0.0/24 for the=20
example VPN subnets.

> +    server-ipv6 fd00:6f76:706e::/64

The other example subnet we've used for IPv6 is fd15:53b6:dead::2/64,=20
but that's related to --block-ipv6.  I vaguely remember we used some=20
other IPv6 subnet in examples, but not able to find it now.  If this is=20
the standard subnet, feel free to ignore this comment.


These nit-picks does not hold back my approval though; they can be=20
changed on-the-fly if so be.

Acked-By: David Sommerseth <davids@...515...>



--=20
kind regards,

David Sommerseth
OpenVPN Inc



--aC3oCTACdwn7SpRDNiSNyC10fulVfwFYd--

--1xXhqerMXMvhy5cZcVg0WxyQY2qJAybo9
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmDcu7oACgkQhs+UTJZx
/fLXwQ//bZcENELUYvqLvgjZ//uSpobhmtQPgaWtrUvoZ6q48IFz7vtQsxkYcd6T
rYymNlqgKCUuBlnLBGiRpxPrWb/XoWQk8A+jia0cpvDhd9WnqY9lJ4TyS2pANW22
CZer+zmvfisv1ttnJ1DLVOvt7aRVyLUsRSZgABYW16vLOBOXIssap7aZuWIGOTXM
qB0mk6D2eL7DehALTc6alNYwwAe+2VA7LXKri8jo2g1J+PHwaSghdfS3GHgKEtRf
DI8MfCwStHRh0XxQb2cstZjI1dtDRLUBb3yp/8qGBmriZO6CVPxFSqdltd3L4F8l
ZE6smyjv7kAzE0G5yHi4GPXbY980qk7mhMUgk4khlSlLEZl6SmAsLApKAVk49a2f
ABBB33pa3yAbREl14q5r6Ih5vDhRiwsTABc/bNJC9UgW4Qags4WMABQZWiaxuiF3
lrPiZIr282B758rt2Y2QMRZov9jmtkZGmwO0djQehlpe3MfraExyJen8sME3hjJo
4XMOnjberktEZLZVVcr5vH+4l2grS1NhCNPvRU2Q20mCdb9UxpcyZOn0CANtolGh
vz2mlFWyBUuH0p10JFHqBD7QBbFSHLYDI1jvDPzDKIG/Kr68NE+WqOd2KeAqdmf8
gwerGBI+uJkBlMQAKk042D8EtTGUTDwVRvBHcFfqkScB3rfzFWM=
=dDgB
-----END PGP SIGNATURE-----

--1xXhqerMXMvhy5cZcVg0WxyQY2qJAybo9--

