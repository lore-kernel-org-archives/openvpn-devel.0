Message-ID: <55DDBBE2.9010205@...1114...>
Date: Wed, 26 Aug 2015 15:15:14 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <55DB4C39.9040105@...2010...>
In-Reply-To: <55DB4C39.9040105@...2010...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="6rT4e4eUxix3GAUxo71irfil9JsBdUX9B"
Subject: Re: [Openvpn-devel] Log cert serial no if it is revoked
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Boris Lytochkin <lytboris@...2010...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6rT4e4eUxix3GAUxo71irfil9JsBdUX9B
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 24/08/15 18:54, Boris Lytochkin wrote:
> Hi.
>=20
> Author: Boris Lytochkin <lytboris@...2010...>
> Sponsored-by: Yandex LLC
>=20
> Log serial number of revoked certificate
>=20
> In most of situations admin of OpenVPN server needs to know which
> particular certificate is used by client.
> In the case when certificate is OK, environment variable can be used for
> that but once it is revoked no user scripts are invoked so there is no
> way to get serial number: only subject is printed in logs. Patch
> attached addresses this issue logging certificate directly on the line
> with certificate subject.
>=20
> Tested with OpenSSL but PolarSSL should be good too.
>=20
> Signed-off-by Boris Lytochkin <lytboris@...2010...>

Feature-wise, this makes a lot of sense.  And as Gert has said, the
serial numbers are unique to the CA being used, which fits OpenVPN use
cases well.  The vast majority of OpenVPN installations with PKI uses an
internal CA which the admins have full control over.

I have only done a code review and a quick compile with 'make check'.
--6rT4e4eUxix3GAUxo71irfil9JsBdUX9B--
