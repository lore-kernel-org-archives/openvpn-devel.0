Date: Sun, 18 Sep 2022 12:46:11 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yyb280l0bg3RbjAF@...1296...>
References: <CAJXQW9Vzf_ypQGSez8X96imiy2Hat0buoY2fp3gmsYs1EXdcpg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="axJ8kweW9WUOEjba"
Content-Disposition: inline
In-Reply-To: <CAJXQW9Vzf_ypQGSez8X96imiy2Hat0buoY2fp3gmsYs1EXdcpg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Allow DNS autoconf by passing hostname
 by IV variables when using push-peer-info
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Ricardo Manriquez <ricardo.manriquez@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--axJ8kweW9WUOEjba
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Sep 18, 2022 at 10:23:14AM +0900, Ricardo Manriquez wrote:
> +
> +            char hostname[64];
> +            gethostname(hostname, 63);
> +            buf_printf(&out, "IV_HOSTNAME=3D%s\n", hostname );

Without entering the discussion if this is a useful addition, the
implementation definitely lacks error handling - gethostname() can
fail, and then we have an unintialized buffer passed to buf_printf().

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--axJ8kweW9WUOEjba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjJvbzAAoJEB2Cnv7KVigS9foL/i2xc1KUZbtXRd/npf6QOefJ
yDAgLtrzOErCFt3WKcxmy7rMuellsGq9fMIyZSHQCW4N1AxOBdOk46wXGrd1NXRL
bGnrRQ8MCPtSEJscwYEhlTjkmrPcDyBnRPeWXA6syZ9WwqTpFcncQsRAKg7+fotW
/VxfDxDSQGyNFZ6L9/g1Z9tO+QqU27UowUYtkyBt3yG527PaCI+NqF0bUndo7ecO
5OK/HUsWhfbuONc+SkQRO99pA/3WxrIn2g/xU8oD11Cyzg0Am6KfU3goAZbCPtf8
FArz+v2kSJ04j9aaIX4Dr7WQY+7FKUmFUlyicn9Fdt/ScPEdwqKf8Aim32R+cpO1
+mxo58LLRs0CLYBsadVp/k1hSEEj69NJnY14K07xiO8KpibGvaNXibg++ybVLJdh
ip7XMOqjNqPVB3P/eqwG+NBh3XkYnaLORFIqlkQ/el41l198GKO2wpVRI+ERpk+A
zu6vIZpLm1B++aIQYM2DMQVeNhGnqyFq9vysQ2olvA==
=2LH3
-----END PGP SIGNATURE-----

--axJ8kweW9WUOEjba--

