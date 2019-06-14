References: <a9f4fde1-61a1-5706-060b-58b8ba687314@...1918...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <6bd7df38-a56c-b5d1-a2c5-329afa6d4346@...1227...>
Date: Fri, 14 Jun 2019 12:07:45 +0200
MIME-Version: 1.0
In-Reply-To: <a9f4fde1-61a1-5706-060b-58b8ba687314@...1918...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RNK3Ygx4MhNx37hXk0hwmIcy5V02u0kE5"
Subject: Re: [Openvpn-devel] [PATCH v2 2/2] Support client reason from auth
 plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Eric Thorpe <eric@...1918...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RNK3Ygx4MhNx37hXk0hwmIcy5V02u0kE5
Content-Type: multipart/mixed; boundary="XuZohJfKNiqMGoNDZyhaPDvuh3HQiosHA";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Eric Thorpe <eric@...1918...>, openvpn-devel@lists.sourceforge.net
Message-ID: <6bd7df38-a56c-b5d1-a2c5-329afa6d4346@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/2] Support client reason from auth
 plugin
References: <a9f4fde1-61a1-5706-060b-58b8ba687314@...1918...>
In-Reply-To: <a9f4fde1-61a1-5706-060b-58b8ba687314@...1918...>

--XuZohJfKNiqMGoNDZyhaPDvuh3HQiosHA
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 11.04.19 um 04:07 schrieb Eric Thorpe:
> Hi All,
>=20
> This patch allows for a client reason to be returned from an auth plugin
> and sent to the connecting client on an auth fail. This change is
> backwards compatible with existing plugins and hasn't caused issues with
> existing plugins like the included pam plugin in our testing. The main
> purpose of this change is to support dynamic challenge/response from
> plugins, currently this is only possible from the management interface.
>=20
> Example usage for this change can be found in a new plugin here modified
> from the included PAM plugin -
> https://github.com/thesparklabs/openvpn-two-factor-extensions/tree/master=
/yubikey-u2f-pam-plugin
>=20

Same as for the 1/2 patch, I would like to postpone this after the
auth-token set has been merged.

The patch "Sent indication that a session is expired to clients" of
auth-token also does the renaming from man_def_auth_set_client_reason to
auth_set_client_reason so this creates a big conflict.

Arne


--XuZohJfKNiqMGoNDZyhaPDvuh3HQiosHA--

--RNK3Ygx4MhNx37hXk0hwmIcy5V02u0kE5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl0DcfEACgkQFRhsZwKx
RFSK2hAAk2IxhtTOvLQerEqbOihy7fLgDyTo7OLfmi6AQdpME4XEBrbUmV1L+F5j
vyXw/he23vU/WrFQrrx1Qxi2Ore3u35UJEhZIkWSMNoo7teypseSqrULCPx8NDrD
pv6mZcJ1YlEPxxpHDy8e8kdywv0Cbi0GwzasWMcJDsac+eP1gL/7kYE3n6yi60tr
3ss7GXBbPNmrTUQZyr/vJlqbkmCVQGusz77MChkOfOfQld267eRdkigIcd+jDY99
auOW4DH49P410Pp7tLv21FbEJn4iVi73NVpAztDovFqTaB3HShnzYYN/8FIb2NMf
+QkQhP3x9EH9uClkziUiXspN990tr4T+Cui8KeB31+YtHn2gNohsMa6ddchP4JY7
rqKjKrLnizujGx/Ac2oXt3JZbnIQYfmxNnYI87X6DXMvNkc8WRaD8l971its0Vsz
UOa0md64nugqTRcAfP6hYnlOaz3v2mghbdrVJg30nvFww3KwGZuLrf0jTlWXJM0e
xFh/8IrFezfOP+vxlGK8JEayUvAdetar1QHKqmOUSX7Gy2vP/9zFC5DR0N9chUa+
D2sxtSshZfy0qh/Y1SintYwImZmbmFLX0URzeyUXoLQT89eeUW8e3ijmohtuqC7L
Fc06PDZdVSK30RmDzCk5M5faR6lvpZAQZpwsI+rZ/J91XqthUI4=
=2Ycb
-----END PGP SIGNATURE-----

--RNK3Ygx4MhNx37hXk0hwmIcy5V02u0kE5--

