From: David Sommerseth <openvpn@...2080...>
References: <9fa97fc4-b708-5131-3d27-deb7809404dd@...2080...>
Message-ID: <2ce4b188-6661-1f18-ffcb-3f8d71bd22fa@...2080...>
Date: Wed, 29 May 2019 22:17:07 +0200
MIME-Version: 1.0
In-Reply-To: <9fa97fc4-b708-5131-3d27-deb7809404dd@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="TbRE5G28T2SC6X1wzVzoS5eoHIPreqQv8"
Subject: Re: [Openvpn-devel] OpenVPN 3 Linux client - v6 beta -
 Debian/Ubuntu repositories
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, OpenVPN Users <Openvpn-users@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TbRE5G28T2SC6X1wzVzoS5eoHIPreqQv8
Content-Type: multipart/mixed; boundary="EAEp4K58SK0ri8TD3hoUxMAOwNbCl5V8D";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>,
 OpenVPN Users <Openvpn-users@lists.sourceforge.net>
Message-ID: <2ce4b188-6661-1f18-ffcb-3f8d71bd22fa@...2080...>
Subject: Re: OpenVPN 3 Linux client - v6 beta - Debian/Ubuntu repositories
References: <9fa97fc4-b708-5131-3d27-deb7809404dd@...2080...>
In-Reply-To: <9fa97fc4-b708-5131-3d27-deb7809404dd@...2080...>

--EAEp4K58SK0ri8TD3hoUxMAOwNbCl5V8D
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Hi,

The Debian 9 (stretch), Ubuntu 16.04 (xenial) and Ubuntu 18.04 (bionic)
repositories for OpenVPN 3 Linux is now available!


Installing the OpenVPN 3 Linux client
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

First ensure that your apt supports the https transport:

   # apt install apt-transport-https

Install the OpenVPN repository key used by the OpenVPN 3 Linux packages

   # wget https://swupdate.openvpn.net/repos/openvpn-repo-pkg-key.pub
   # apt-key add openvpn-repo-pkg-key.pub

Then you need to install the proper repository.  Replace $DISTRO with
stretch, xenial or bionic, depending on your Debian/Ubuntu distribution.

   # wget -O /etc/apt/sources.list.d/openvpn3.list https://swupdate.openvpn=
.net/community/openvpn3/repos/openvpn3-$DISTRO.list
   # apt update

And finally the openvpn3 package can be installed

   # apt install openvpn3



Using the OpenVPN 3 Linux client
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

With all this in place, you can now start VPN tunnels, even as an unprivile=
ged
user, using the openvpn2 and openvpn3 command line interfaces:

   # openvpn2 --config $MY_CONFIGURATION_FILE --verb 6

or=20

   # openvpn3 session-start --config $MY_CONFIGURATION_FILE


If the configuration profile contains --daemon or you used the openvpn3
approach, you can stop the tunnel like this:

   # openvpn3 session-manage --config $MY_CONFIGURATION_FILE --disconnect


For more information, see the man pages for openvpn2, openvpn3 and
openvpn3-linux as starting points.  Both openvpn2 and openvpn3 also
provides --help screens, and openvpn3 also provides that for each
"command" you give to it, like openvpn3 session-manage --help.



If you have any questions, issues, comments, suggestions, etc ... please get
in touch!


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--EAEp4K58SK0ri8TD3hoUxMAOwNbCl5V8D--

--TbRE5G28T2SC6X1wzVzoS5eoHIPreqQv8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJc7ujDAAoJEIbPlEyWcf3yhoIP/2UCsZJeEfILjBD7fckiLXp4
P97/lYuHLTEo+gA8BLKDy2pm8lCjhBkZ50YWOgS+0q8eErV9gP9O6641xYsnXNb4
DjvmEOkw9BpBuhp4C1i7HXHf9r4i3tH75mmR5nkD8gWvcxaDFvagbRaia4UQicoB
8S6HyTZEhun/gql7ljxGU4w/uAL8myVpFaB4E5+/h4LjJbQ4Q5P+7rRDHQRSAbWj
kr7a2TAGtiLa+DyicQkrtuVEnvXu536qgvrZqp0IFMR9Depw5UMqIhiUYBWi6L7+
eEPb3wLxp+1aMLsliFzw6kZEa/KQ30FIYzsXK7MRQLClmPcU1570/RjX+cnWQGP3
UgfLhre3HE7bBbEm4kotaFjzkcRKvHidEphChEEDOcc32qlnFbB3fn9+IVau/FD7
wc4J97h21ibK8VXw7KkPO8aBgNQ7k263LV3yt0qw0GdWc7izomQcN7fCz01Ssy2c
QMO0ijFzdaWCqIbWqXfRPD1/fOsBZoAcUGPyjf+HohAk+WL1FxSuh4bAQgena4/M
Tfo3k5DwcGrYNZRJAatoeseL3FaU75KNgYFcWt7rm/lbYclGZ6i6reSnh4pObtiw
3VXoM4Er/OpPQufwy8VDrufVcgQ1wI8PgVmqfrkhIMeIoeAP364egj3fBVjh6Vby
0u3D8E5Su8XJdm08LmwS
=/LOv
-----END PGP SIGNATURE-----

--TbRE5G28T2SC6X1wzVzoS5eoHIPreqQv8--

