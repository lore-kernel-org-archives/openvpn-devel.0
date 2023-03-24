Date: Fri, 24 Mar 2023 13:46:37 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZB2brbgptkntUOCo@...1296...>
References: <20230324083816.79436-1-gert@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="nTMIL39aGjNXFl+I"
Content-Disposition: inline
In-Reply-To: <20230324083816.79436-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix compilation without compression
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--nTMIL39aGjNXFl+I
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Mar 24, 2023 at 09:38:16AM +0100, Gert Doering wrote:
> The previous commit (e86bc8b2967) breaks compilation if all compression
> algorithms are disabled (--disable-lz4 --disable-lzo).  A later patch
> in the series would fix this but can not be merged yet.

Just for reference, this got fixed with Arne's commit a8170dd0e76 now,
so this patch is no longer needed.  Marked as such in Patchwork.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--nTMIL39aGjNXFl+I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkHZutAAoJEB2Cnv7KVigSkAgMAJvj9vQGH7mrXTAfZw/qSvCO
Tsg4JU3KbUZZClCYekTZBcnWTjxgSuFE6FHAI3pU6ZvGTjbks3yrNFylS3RIWEdh
nnk04eFhS4F5TEpfrmkSgUw8GFcxCmvccQ8pcmztJjsFAGPN+vxy8CaxrNXs/GsZ
thi44Mgp9QdgTdjQ+xgiypCi6YHNlPuUi5SeQRmYkSxlec6k93LE03SgkpeI2Z1O
F+yoayigSAHjtnpaN5Ft2sn9fcSXa/nRT3NRwosno28xnS14zAC8Vl5pYOtdS7PX
ZDZMsjfnrvdGyb/pyl969cHytYOrIfPc269rWVrPuO559lBVecqVMEYC1X9anqBK
ezE/MYOXl3VWeUW8IgT5Bgh5Sw6i3HPadKWBOc/Uz7+vyiPvlxkgWzzEgv4Ec70j
oT2NuXbS1I42FTG+i5hNbREUrM/ubBWiPO6Vw6t3JRBm6WmOlifiNU0OIlDrpSFL
eElRgX+kHElQXbigtC3zPr76ZdzDI/EmlSJpoMVhww==
=Ccv0
-----END PGP SIGNATURE-----

--nTMIL39aGjNXFl+I--

