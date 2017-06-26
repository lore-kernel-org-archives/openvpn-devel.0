Reply-To: openvpn-devel@lists.sourceforge.net
References: <1498475606-8337-1-git-send-email-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <99e7102e-8b4a-6b42-3095-40fcfada8c28@...2080...>
Date: Mon, 26 Jun 2017 13:51:13 +0200
MIME-Version: 1.0
In-Reply-To: <1498475606-8337-1-git-send-email-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="W4ASOpHuhUGU26pvknWDap59tnO77V05O"
Subject: Re: [Openvpn-devel] [PATCH] Set tls-cipher restriction before
 loading certificates
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
--W4ASOpHuhUGU26pvknWDap59tnO77V05O
Content-Type: multipart/mixed; boundary="piAgVL7qFsBELTsWnq3owLWTNGvtow3B5";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <99e7102e-8b4a-6b42-3095-40fcfada8c28@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Set tls-cipher restriction before loading
 certificates
References: <1498475606-8337-1-git-send-email-arne@...1227...>
In-Reply-To: <1498475606-8337-1-git-send-email-arne@...1227...>

--piAgVL7qFsBELTsWnq3owLWTNGvtow3B5
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 26/06/17 13:13, Arne Schwabe wrote:
> OpenSSL 1.1 does not allow MD5 signed certificates by default anymore. Th=
is can be enabled again by settings tls-cipher "DEFAULT:@SECLEVEL=3D0" but =
only if the cipher list is set before loading the certificates. This patch =
changes the order of loading.

I'm not fully convinced of the argumentation for this feature - unless
something have changed in OpenSSL 1.1.  I believe the same can be
achieved by setting an environment variable before starting OpenVPN.

  $ OPENSSL_ENABLE_MD5_VERIFY=3D1 /usr/sbin/openvpn ....

I know several Fedora users have deployed this, even when systemd is
involved.  This is needed on systems with OpenSSL 1.0 as well when they
connect to a server having an MD5 based certificate or signed by a CA
with an MD5 based certificate.

So unless OpenSSL 1.1 have changed this behaviour from OpenSSL 1.0, I'm
not really convinced we need this.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc


--piAgVL7qFsBELTsWnq3owLWTNGvtow3B5--

--W4ASOpHuhUGU26pvknWDap59tnO77V05O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZUPUxAAoJEIbPlEyWcf3yizEP/3ep2nMA+eCLa5jJJnrk17tc
03E2db71WbFdesWOcaZwVwGTyOQNzN28XPa58exMFuwuswczmwxhYGI77g7N8Quw
yfiC0BioaK7T97WWPTEdX8e4jlkl2M2KJk/G7qZCeSIUkupvj10K4+Kg4TmbOJs/
ZkOUYOaCRIbxmrz7KcZlTHbU7CZDaWV4a/srDxJ4xXVWmRSYdqgP5RcIfMWCc3bU
elj+VrWbkBAmbrwhD9H0WsXAz3uMqJSa7PjyR8rWAUZ4KuLEY0ZYihcF+w9QkNEW
JNDdM/sM+f05Jpq79My03MEMXbCWwKX3zFunFY1L5lXhSBfHZGEAym21UFa3hjrT
IPn0b/mOJZpmg6GKt4pro2KWU32DoiQoPKdHt3qw+ZA1NEkLcuNKZEGI9NxYQLVD
Ip0guRDKp2UB8cpxyuOy6PtUBdgU7A83cQkOAR70102SjNZxbH5eJJWUtndaGNiR
ethpgtgka06INuMe7+HdL8Qq0V1COYPNMW3b4zRXxU9cdMDS6nLHcF6urfZ1axs4
KvCRZ5WE6PWlllz35B/B35BdU4XhUOYAs1ojEXMX13r4SjQrWMCujTXNoTXVkeCS
xYSzVXoZEeE1wWyFOc8/der2a0xL9nV5vH9XzjlEKvCCZmFlFEPvIgQ+6dnK6+jc
Marlz0wHyw/WTOLxYsQf
=2wxN
-----END PGP SIGNATURE-----

--W4ASOpHuhUGU26pvknWDap59tnO77V05O--

