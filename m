Date: Wed, 17 Jan 2018 11:53:21 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180117105321.GR69387@...1296...>
References: <1516137848-22565-1-git-send-email-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="M8BZqbl6q5NSES+8"
Content-Disposition: inline
In-Reply-To: <1516137848-22565-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Replace buffer backed strings for
 management_android_control with simple stack variables
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

--M8BZqbl6q5NSES+8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jan 16, 2018 at 10:24:08PM +0100, Arne Schwabe wrote:
>      if (rgi)
>      {
> -        buf_printf(&out, "%s %s %s dev %s", network, netmask, gateway, r=
gi->iface);
> +        snprintf(out, sizeof(out), "%s %s %s dev %s", network, netmask, =
gateway, rgi->iface);

Everything else uses openvpn_snprintf(), which presumably works around
snprintf() platform undefined'ness wrt null-termination on too-long
input.

Most likely this is not *needed* on TARGET_ANDROID code, but for clarity
it might be worth considering.

gert

--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--M8BZqbl6q5NSES+8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaXysgAAoJEB2Cnv7KVigSg/oL/RLfG5a39gfQ0bIf104maBsh
xCvitjKiJVN2JJm1GDH71HafMG+Js5QJnhqbSGF5HcEvh8yWJBR0K4zAQCFlWk8C
NZfJUVlxCuM85oD8/J3Jpqa/cCXh4uSvHQ6GRCM+bjf9QzkbSlD9CKEMUZW9li3N
gb5mHv/sRP5voU496SAYhdqrh4cvDhF5GJTniw3TN8z+EUKgoXdLboIR1MKNGMrh
iDtOCb6Y/kxGI60QODiziU2121xziKzHneWo9C9q9jqLZ6wV8XPB/BJtg6ottG1l
9s6X5ai05b+lAwQXe0W025CawEw7jz5YXfGeGur4U7D4wRBMYeNWFCy0f17EnlpY
5jU5hxhSN+Y2god5p0Pe4VboTmLsI6dWZdcAGdXi+mBmXlcNdqiEO+qXCS3gsn3m
LNv6XWniiW0EBc63oj7vetoFJUmXYYNhaKhfUoaMaNIpk7knbD1idbr1XBw7cAUg
/nTcroHjh/z8sjadv2ot4ucDtoPLhDZWyQ0PzdDVuA==
=QWrY
-----END PGP SIGNATURE-----

--M8BZqbl6q5NSES+8--

