Date: Fri, 17 Apr 2020 10:51:59 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200417085159.GC1431@...1296...>
References: <20200416113930.15192-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="fu8qefuGDGSqcFud"
Content-Disposition: inline
In-Reply-To: <20200416113930.15192-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/3] Use crypto library functions for
 const time memcmp when possible
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

--fu8qefuGDGSqcFud
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 16, 2020 at 01:39:28PM +0200, Arne Schwabe wrote:
> index 18a86ceb..dadf0a90 100644
> --- a/src/openvpn/crypto.h
> +++ b/src/openvpn/crypto.h
> @@ -528,21 +528,7 @@ void crypto_read_openvpn_key(const struct key_type *=
key_type,
>   * As memcmp(), but constant-time.
>   * Returns 0 when data is equal, non-zero otherwise.
>   */
> -static inline int
> -memcmp_constant_time(const void *a, const void *b, size_t size)
> -{

Not sure I understand the motivation for this change.  "Just so uncrustify
stops trying to change this" is not really strong.

Also, keeping the "inline" part would be good...  this is in the per-packet
path.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--fu8qefuGDGSqcFud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJemW4vAAoJEB2Cnv7KVigSzpoMAK/M09FVPEvKD+tE3qLe3JNv
P1T5g7c6zfPQSY6uoxTtBwiZqNxjSVjqBtrM8YAimGy3i9Sx5kt/Btc7IXqvtzII
DNO0cQ16gCrXdV28/ORrtBUT+jhj2lcd4yY6bEHmtwFxyzxRlOn5EgLbPulQwY0f
0QMwtr7g+4XV+lfTU8rfYmjK9sVKS/55obzd8poIFO6Ab63ZGiy+LjIEn9V/8+lu
kZZpp8pMTn+YT7DUkSnbD6AMVnm+tB1oumFIZpNAVTHnSWDDcXP6KALOpCSh3CSL
ICopTsr42CAPuW1dOSlF9VOgCMxps3P1JXgLFhv/+NKcxmqPq+jsrnVYBsXI66lh
NTuU5XORkTEcaIY4UszAVlGe3yG+30S7lH5ixA0NCbAIOwr5q5arLC8v3obfQDgm
cZ9sgIFac0MAa22jvvoSHYNn6cs2syi4O5Vvayoay79yqQtIn3h05vNWbnrg0Phy
ACaPvvctmJ7Lm+nlX5aZWUAC5QoJING0TQzi38QPuw==
=MO3K
-----END PGP SIGNATURE-----

--fu8qefuGDGSqcFud--

