Date: Tue, 14 Feb 2023 15:01:44 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y+uUSNTTULTEElt2@...1296...>
References: <20230214135658.1034787-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="52n08Utrv9g0qjvv"
Content-Disposition: inline
In-Reply-To: <20230214135658.1034787-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Add missing check for nl_socket_alloc
 failure
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

--52n08Utrv9g0qjvv
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 14, 2023 at 02:56:58PM +0100, Arne Schwabe wrote:
>  resolve_ovpn_netlink_id(int msglevel)
>  {
> -    int ret;
>      struct nl_sock *nl_sock =3D nl_socket_alloc();
>=20=20
> -    ret =3D genl_connect(nl_sock);
> +    if (!nl_sock)
> +    {
> +        msg(msglevel, "Allocating net link socket failed");
> +    }

... shouldn't we abort in this case, aka, M_FATAL (or "return -errno")?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--52n08Utrv9g0qjvv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJj65RIAAoJEB2Cnv7KVigShnIL/2Vjb0JQ9kLiIuxsjNFoefU2
/YS5Ky1yOm/yJcgojV8UuZq3OyluGDZP2NuVrroGGfku0N4tpBiIR0SQEmcRMBcD
8UXU1kmh9OXBH/e4AkDd/vmGmLJUdtYLmnxVkk0qagfkLvHq99Bj6JEbi68xwk4L
FUSMtb/J9rPsghzLvAoI8/p1NB81TXqygUS2oawuvSLyw6XTe3pK3HniwWODWXxX
5c+vAxfPDJbAD15ymS/25gET3HoYPvjsEenQq+xvTV7l/CQBwQNOgGwlRysUv6Uj
9gftDNybdXubN67/2mQ2O7ObNLV2zsC6IInx20mCaSMwwzLsqndcBZZzrodVbcoz
vhtaRcsrXdj+zaRCxj0lo07eDlPDhcsKJumk6uFfUZFh+nSu5H/mZXg9yuZN/XR+
KbFNx8VzMaxVNmeTkB5G7RrcvoQQeaoVk9Axryp7SlKCAYbOtQLpx4CnCnxLwjVq
ItqZaRhtTmxListXgi9MHgGi0/GcSu8wLSV2X2V4qw==
=mgdc
-----END PGP SIGNATURE-----

--52n08Utrv9g0qjvv--

