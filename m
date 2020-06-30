Date: Tue, 30 Jun 2020 16:11:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200630141103.GY1431@...1296...>
References: <523527018.2514117.1583041035054@...2084...>
 <20200301071521.GI1431@...1296...>
 <CAKuzo_j=P8vZvkOL4Rgh1icLJiu0a-r4yQGrD1GSACrn14G9QQ@...278...>
 <f4b83fe0-cbe1-eed3-ff9b-4aaaea5a12b1@...1147...>
 <20200621111403.GP1431@...1296...>
 <CAKuzo_h2oTaNK7A3+3MJ6GSfApr9L9vXYFtzELH8SaaNzqFWuQ@...278...>
 <f664dcaf-7224-1b17-c953-584557f2ac56@...1147...>
 <CAKuzo_iFf2iuOLg4LpXrz42MG1GggvdrcWKJrcDT6j38tQjrUw@...278...>
 <20200624102804.GM1431@...1296...>
 <50ad64e7-b75c-e40b-5d5e-9e89e90db45d@...1147...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="CK8FEzgnN8ZM1cfW"
Content-Disposition: inline
In-Reply-To: <50ad64e7-b75c-e40b-5d5e-9e89e90db45d@...1147...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Multiple DNS search suffixes on
 Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--CK8FEzgnN8ZM1cfW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 30, 2020 at 04:07:52PM +0200, Jan Just Keijser wrote:
> @@ -5697,6 +5740,11 @@ build_dhcp_options_string(struct buffer *buf, cons=
t struct tuntap_options *o)
>      write_dhcp_u32_array(buf, 42, (uint32_t *)o->ntp, o->ntp_len, &error=
);
>      write_dhcp_u32_array(buf, 45, (uint32_t *)o->nbdd, o->nbdd_len, &err=
or);
>=20=20
> +    for (int i=3D0; i < o->domain_search_list_len; i++)
> +    {
> +        write_dhcp_search_str(buf, 119, o->domain_search_list[i], &error=
);
> +    }

I assume that this won't work.  In the DHCP answer, it must be a single=20
option with the concatenated list, not multiple answers with a single=20
domain name each.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--CK8FEzgnN8ZM1cfW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe+0f2AAoJEB2Cnv7KVigSPawL/i3kjdrVTcXJ6jnCFoWrXyPA
SJkqESr2xAMcUKyrMX/JOuVN4Mu3x+iLYfdMZPStschjdI8wghkni1GHsrDj2LqS
+M8WhG9kxEMJrwF1w49+rs2yxaqBkMRuoLUyfcXUYGMwCtGWtwfpIp9nTMTubXQW
AWO4wxjWMIxeckbxAXBBS57ZQ8OvbCjt5jOfHjLZ1jQsY/ePm9Vd3Eer2vbqcaU6
rOPfQiWafGx4UCb4shdglQB/EXXO87k0HkGapP2NCBAK0po/v5jZCGClnvg+hRsZ
uW30sIEJh28EoI5x+vWLd1NQ8Dfx91fSW0VXYgFUnaspLQWn9ZEuESf1+g7XGJsq
2bmXoXFo/V8/88E/vJIepJVI0rH1qX1JEmlWoaLq9eDC0vcDhSXh48kSDlAkDyz6
ZX/KvLg49y36a7QYz01V3eIymT4ifRFlsD4R6fgQUH2oVN1Ht0IkMd5XBLOaFsB0
6Ntbsz0OcP6XzgAGUJE5kpc1GLoVZvcNgkDLsimyzA==
=zHgT
-----END PGP SIGNATURE-----

--CK8FEzgnN8ZM1cfW--

