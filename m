Date: Fri, 29 Nov 2019 11:52:07 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20191129105207.GU40538@...1296...>
References: <20191128080631.117-1-lstipakov@...277...>
 <E1iaLck-0000Aj-5c@...2508...>
 <CAKuzo_jR6WYsM9QZhdyp8sW6avFGhDnFzx_dNN63JD4iiSmFag@...278...>
 <20191128194320.GM40538@...1296...>
 <2aa50cbc-cc17-81d5-ec9a-98fd5e8ba503@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="CVv82Ujxifzgs+3E"
Content-Disposition: inline
In-Reply-To: <2aa50cbc-cc17-81d5-ec9a-98fd5e8ba503@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] fix clang warning about missing braces
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: Gert Doering <gert@...1296...>, Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CVv82Ujxifzgs+3E
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 29, 2019 at 11:47:02AM +0100, David Sommerseth wrote:
> With GCC-4.3.8, I see this warning:

This is about as old as you :-) - do we care about suppressing warnings
in old gcc versions that might suppress a *relevant* warning when
compiling with a current gcc version?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--CVv82Ujxifzgs+3E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJd4PhWAAoJEB2Cnv7KVigSM6MMAIi7WOGUGlmpFLuKKg9nhEO+
C/PlQ67YlOwsBpUn9Rm4rPMCG/T6dz5dGYmcWRaRfwWykHqKLq00mahMuh7kfyRw
iZ/fgIbzdgmkN16av/RddI5EkPAU5QbCXL+pveyaY6CTuiq7L5zoxqTdTyFwPyuI
9q8qm6HbIqBzcMUR/gRBb0ys2afn3qfyKiH/EsAMdhaOmIxHBBT4SYimjqCPxYi4
V9uxPl43pEzClmHYSOkq2B8UNdrGGhXwnKGwDdFfnjJ2MJhIzq2LhcYmx7FZuS44
3OFAYvdpBYtFWJT5P5vIaPguP5ciEB/P8br0SJhDNbCBeovajwL6j/Poir0dUs2j
P7rPRWB4qgRDFedWu5ntc1Zzl5pT85wDpusPaMGFMsSvIuWm6lWY8OzkBlPO9IGP
fKgJ0IN3uO2p1hD6UhKk40oCeLvxjuhwKV2XzsQMpkMy+bIYXheDpBaNoUUBOJAS
kFtmC5dyQFoPfW4X8W1aI+P30BHpdHvBjmBwZePbMQ==
=BxWI
-----END PGP SIGNATURE-----

--CVv82Ujxifzgs+3E--

