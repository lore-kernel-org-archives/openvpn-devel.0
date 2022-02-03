Date: Thu, 3 Feb 2022 09:32:13 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YfuTDSyc1JOZdf8J@...1296...>
References: <20220203082620.8186-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="J08lsbujM/Chzf/M"
Content-Disposition: inline
In-Reply-To: <20220203082620.8186-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] keyingmaterialexporter.c: include
 strings.h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--J08lsbujM/Chzf/M
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 03, 2022 at 09:26:20AM +0100, Antonio Quartulli wrote:
> strcasecmp() was initially declared in string.h and subsequently moved
> to strings.h. For historical reasons it still exists in string.h, but
> would require _DEFAULT_SOURCE to be defined.
>=20
> Due to the above, just include strings.h as currently dictated by the
> manpage.

If we include strings.h, do we still need string.h then?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--J08lsbujM/Chzf/M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJh+5MMAAoJEB2Cnv7KVigS0N4L/1j0pnhlp26W1oyQ73riEl6l
/Y5WvbQm0JsmOeVBIa8/TBCQSGtdE7Bk6rAfCKL44iPwflQKZnj6k+S+DPq1PVhj
8kiGAiecKoWZ3JtLYafw/3K66CSuwBAF6nXhZJZ1H/MyI3vtZ67tuliCdPlUdcC5
eQL2XDeW1avwJKIL3eQ8tJl4qsAzN+tWavALkhY7P/0/92GKZ6ryOL75m6+GGbP0
EF5H3Y65lmmJrUS4whsRU7CLM1VrAad7H/z49m1BiaT2asCWRF9h1i2RkGIAs16D
AX8aI/tz3UEyLzJiUE80vbywqrMU4rx6Jp72fDPYFzXZ3Uey6qRkeNMgJVIZRT5v
Mw1My/BmPC26FFCKKULYUQgr7rJgjToZf9RiOiJkVRE+FafxnLLnvYpwYPjHcJKI
dZ8VLaXEgy1MqVrxbbhiweojvUMER9EBLnz+RPQUMsPq+wVsgBw5Rpkh4/XAq6R9
ItbiYatsfNd65ks/HbskGuLv0SHkdJL/BSKGm2HakQ==
=07fL
-----END PGP SIGNATURE-----

--J08lsbujM/Chzf/M--

