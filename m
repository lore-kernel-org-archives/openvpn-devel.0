Date: Sat, 13 Sep 2025 19:24:36 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <aMWo1HvleNGzIEDO@...1296...>
References: <65233605-9738-4B2C-8401-37AA5C43D797@...2913...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="04ycY03GQ6wrEyTy"
Content-Disposition: inline
In-Reply-To: <65233605-9738-4B2C-8401-37AA5C43D797@...2913...>
Subject: Re: [Openvpn-devel] [PATCH] Bugfix: Set broadcast address on
 interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Sebastian Marsching <sebastian@...2913...>
Cc: openvpn-devel@lists.sourceforge.net

--04ycY03GQ6wrEyTy
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Sep 13, 2025 at 04:25:25PM +0200, Sebastian Marsching wrote:
> @@ -803,6 +804,16 @@ sitnl_addr_set(int cmd, uint32_t flags, int ifindex,=
 sa_family_t af_family,
>          SITNL_ADDATTR(&req.n, sizeof(req), IFA_LOCAL, local, size);
>      }
>=20=20
> +    if (af_family =3D=3D AF_INET && local && !remote && prefixlen <=3D 3=
0)
> +    {
> +        broadcast =3D *local;
> +        for (i =3D 31; i >=3D prefixlen; i--)

Ah, well, I guess the integer police will come after us... so in modern
parts of OpenVPN we go for local C99 declarations, *and* we take extra
care to make it all -Wsign-conversion safe, so I think this needs to be

+        for (unsigned int i =3D 31; i >=3D prefixlen; i--)

(and no extra "int i" declaration on top)

This said, I see we have a "netbits_to_netmask(bits)" function in=20
route.h -> please use that, it should be something like

+    if (af_family =3D=3D AF_INET && local && !remote && prefixlen <=3D 30)
+    {
+        inet_address_t broadcast =3D *local;
+        broadcast.ipv4 |=3D ~netbits_to_netmask(prefixlen);
+        ...

(maybe with an htonl() wrapped around)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--04ycY03GQ6wrEyTy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJoxajUAAoJEB2Cnv7KVigSv3kL/RZHe6I9+ItnRNL2ttMgls0c
88Gg/n870GKyvSy/pOLAQv99lXs7hxfHkDzJE+mcuiymgQEd3UTXVB8JJYR56cnl
7KuJ/bpqM9JBm2v6xniCnRqdXVIZpLRHlAVWfbQgBYKfjdLMLntwi69i/e83MCC6
OvTr9wI4Zy4ap/b+f+Fkfna46LMCvx4NuX5N5zzEDUOmRMSItzyLLOk6SbvWitkZ
q+BDB0J9fQhRIGbaR0eLhM0JNZSg6wCsSyOH13btFZWUATl4iLA2OzoAquWfHIZh
lpUEr+R4SO+wTy8Lno5WN6lxjJrm4MoE8z/gG2KLrfWEVRbvrFbHB/ZPxkmn8RaM
ZBwE31mtKCWdXhQsvuCRFJvFReDXnLjJOwwu0y19syq1YJ9ZrT931NiCYyVgQF1i
C87SXP1C0QFjwcRzZRmXRn2ANyJiat0StQpuHu9oXLHKJphN5aqaqB75mL4QMoCa
uO7MXICsKHJD+9tBcRfIQw550u9089AUlo/owrrrwQ==
=IcCm
-----END PGP SIGNATURE-----

--04ycY03GQ6wrEyTy--

