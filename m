Date: Tue, 14 Mar 2023 15:36:03 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZBCGU5OpXlMB/AOV@...1296...>
References: <20230314130931.173992-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="UoFq4wF7cla6bIEt"
Content-Disposition: inline
In-Reply-To: <20230314130931.173992-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3] Fix memory leaks in HMAC initial
 packet id and dco open tun
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

--UoFq4wF7cla6bIEt
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 14, 2023 at 02:09:31PM +0100, Arne Schwabe wrote:
> The open_tun_dco_generic already allocates the actual_name string, this
> shadows the allocation in the FreeBSD/Linux specific methods.
>=20
> The HMAC leaks are just forgotten frees/deinitialisations. tls_wrap_contr=
ol
> will sometimes return the original buffer (non tls-crypt) and sometimes
> tls_wrap.work, handling this buffer lifetime is a bit more complicated. I=
nstead
> of further complicating that code just give our work buffer the same life=
time
> as the other one inside tls_wrap.work as that is also more consistent.

NAK (as discussed on IRC) as this misses the necessary adjustments to
the pkt_testdriver unit test, so "make check" fails (if cmocka is installed)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--UoFq4wF7cla6bIEt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkEIZTAAoJEB2Cnv7KVigS0IEMAKl2xpPuGjGdKMkZK9gKUzxU
pjr0Z/a+A3urFj2AQyZH/VeMopA2mzt58+xM33UfU/EjomAGUsWu5bhljNdP/bCI
yAuyFN7v3xuF4tVBDVVaa4IyHKVeVHU2MgTj+dTa2sc5OP0Sls+qdg1dcirUS/ra
vJN1BhmK7hwYLTzXaD36xNF8BSoeRXkTbi80DrUQAcfJB9kovsQkD7V75Ajw8T/d
jZsLv+N/Qm/P9ov4FhdNvRZWzQx6XQdzJ9W1BAaM9x4K8udUnnjkDgwHy3y2pxV2
74jDU107Zy1US5E8ZsU0WxZ76/9PvLddklZvDWtZhFvkWKbsgw4sHqTkJXKwDUqG
LNpXPFTos1C5fdl+TSyRP0YtMpFEIQf5vfD6TGFEUuhTVH9bhLFoEiR7noOvkARL
ifFeQoqHcy7AArhfgf9DEwbn1Xng9JM8xDl3NhQIWDPMd8RaQQafOwTXacvcB3FU
nLQAcgv8hKTC8wr9niRrnlJWhesX5tFRz+oYiUCtWQ==
=R0iw
-----END PGP SIGNATURE-----

--UoFq4wF7cla6bIEt--

