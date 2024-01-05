Date: Fri, 5 Jan 2024 15:59:14 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZZgZQlE49ZjFriwE@...1296...>
References: <20240105135742.21174-1-steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="KCnKrE/YZq4B0qnd"
Content-Disposition: inline
In-Reply-To: <20240105135742.21174-1-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Fix IPv6 route add/delete message log
 level
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--KCnKrE/YZq4B0qnd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jan 05, 2024 at 02:57:42PM +0100, Steffan Karger wrote:
> We have D_ROUTE for route addition/deletion messages, which prints at
> loglevel 3. Use that for IPv6, like we do for IPv4 to reduce terminal
> spam for non-legacy-networking setups. Prvious code would print the
> messages at --verb 1.

Good catch, and a happy new year :-)

Acked-By: Gert Doering <gert@...1296...>

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--KCnKrE/YZq4B0qnd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJlmBlCAAoJEB2Cnv7KVigScK0L/1yn9ostcEa9Q3FjD+9N3Ze9
O7Sqctf4euvcD02+ZoKZvVu0tQq485f9zhq4PNput51XDv7dDs5KPdCqGORHDTW6
spvdd0UrH4sA1/vBHqR4UI7CjCRUhZVat4j6vVCruIm4aC5RQf1BoFgwXwlfadU+
sXdFwaaVpf8nX3wymfnxnXw+dnJRUYzNgv4AYMs0/kQQ7xb63zybo58CRgdU6png
mJnz6q2Nn/MJpYytGlZSqqSZZbhoMbIbhzzlhqc/U90GuaZOJtcqB6CzXMr6SgVh
mbtR2Vl8k5Jy65a2H+5SDLk9QxMwHpt4EC97T68oQNtGUsbojtQrK9j3JIbaRZaO
LhgaEDjr6it8MvNhDbUThvTmNZbo/4gyAew307V1qugsDRuM1fYbrBJzs/mrQUVd
LUimeK3JLvixBaMY4rjbDTgpyrrDL3Awzxrt6HzqjxywFaR1gp2BXOetA5apLybu
NIPRZA/VkoEVpvif2o6/SfNh6zw96M+sWUBmdJjoEg==
=EEH3
-----END PGP SIGNATURE-----

--KCnKrE/YZq4B0qnd--

