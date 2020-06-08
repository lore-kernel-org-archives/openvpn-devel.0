Date: Mon, 8 Jun 2020 16:16:20 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200608141620.GI1431@...1296...>
References: <20200530000600.1680-1-a@...2181...>
 <20200530000600.1680-7-a@...2181...>
 <20200607112501.GG1431@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="eOvQw5NAV+INVs2h"
Content-Disposition: inline
In-Reply-To: <20200607112501.GG1431@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v4 6/7] options: enable IPv4 redirection
 logic only if really required
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Antonio Quartulli <antonio@...515...>, openvpn-devel@lists.sourceforge.net

--eOvQw5NAV+INVs2h
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jun 07, 2020 at 01:25:01PM +0200, Gert Doering wrote:
> Can we make this conditional in a way that does not break "redirect-priva=
te"?

A very simple patch would be

        if (streq(p[0], "redirect-gateway"))
        {
            options->routes->flags |=3D RG_REROUTE_GW;
        }
+       if (streq(p[0], "redirect-private"))
+       {
+           options->routes->flags |=3D RG_ENABLE;
+       }

and then take your patch as-is ("redirect-gateway with no options" would
set RG_REROUTE_GW, which, if not cleared by !ipv4, would set RG_ENABLE
later on, while "redirect-private" sets the RG_ENABLE itself).

Alternatively, set RG_ENABLE at the top (always), and clear it for "!ipv4"

            else if (streq(p[j], "!ipv4"))
            {
                options->routes->flags &=3D ~(RG_REROUTE_GW|RG_ENABLE);
            }

... this should do the same thing, with less code convolutions.

Configs that have *both* "redirect-private" and "redirect-gateway !ipv4 ipv=
6"
would still be broken.  But I'm not sure such a config is well-defined
in the first place.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--eOvQw5NAV+INVs2h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe3kgzAAoJEB2Cnv7KVigS7dQL/1HYRBs0NTSk6BFFR6nacnVs
7vfBF7gM4EyBVMuFoce2geBI9/5UsHIYdMSMN038ZQwoCNGda2syX3YvggwOiRvi
omhmyA9o74NUTqrga+fgwvhL3atDZepFK6D8R+er2uATddIJTsi2TslpxKT0c8bW
kxaFffRcGHk0HXf2HHM5ewWMXUNz19c3TsJvpwjbjWMlVeWHupIV90UlbiWEPybH
anlXimQAzhCBiHuIIFi29IITLIYNmTOjZ+iuPTFllHnR/kXmQ3Wb6rT9K9BOfdYO
Vdv4wmUeMf9wQqZ+pZ2kKG4KNrFixPpSQ8awDlDh0CUTI8X7Mjlh/UTTstY5zg3F
jcxN3iaDCzBeUXYCCDkn/CHlH5lK9rqIl3QnN5rEMF31eOmQex9A0RTHXUjQMiXd
+8sTP+O9AfVHoWOrJb130XJKVZVZn236Gd/tMPEdatXiAceiVApUmhNLcosbWhmf
QuCCKzR31nw/lHIsJc3mVwKM8bjkrPmQiKeB4RelJA==
=f/RV
-----END PGP SIGNATURE-----

--eOvQw5NAV+INVs2h--

