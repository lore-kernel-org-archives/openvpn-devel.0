Date: Tue, 21 Oct 2025 08:40:20 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <aPcq1N1o2-mZJH1G@...1296...>
References: <CAOh3LPOK2-L8VCS5VcvpDvDyGQp9o00y9v069OChyK9o9-884Q.ref@...278...>
 <CAOh3LPOK2-L8VCS5VcvpDvDyGQp9o00y9v069OChyK9o9-884Q@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="lfqq87cPwwZguC8d"
Content-Disposition: inline
In-Reply-To: <CAOh3LPOK2-L8VCS5VcvpDvDyGQp9o00y9v069OChyK9o9-884Q@...278...>
Subject: Re: [Openvpn-devel] Quick question for the OpenVPN developers on
 the source code functionality [problem solving]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jon Chiappetta <root@...2904...>
Cc: openvpn-devel@lists.sourceforge.net

--lfqq87cPwwZguC8d
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Oct 20, 2025 at 04:15:22PM -0400, Jon Chiappetta via Openvpn-devel =
wrote:
> I was wondering if any part of the OpenVPN source code parses the IPv4
> packet header for source/destination address already in place?

With tun/tap and ipv4/ipv6, this is a bit of nastiness...

You might want to have a look at drop_if_recursive_routing() in master,
as that one has to find destination address & port and will log source
address & port.

Not sure we have something more convenient.  Grepping for openvpn_iphdr
might turn up something, though :-) (like somewhere in the NAT code).

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--lfqq87cPwwZguC8d
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJo9yrUAAoJEB2Cnv7KVigSr5MMALIn9RVxY9uXgG98BgiKSrB2
1KTLTYZ+xfpJyL4xx1SJgkiDHmvtvgxLG+lKZNPtzkHzGkRGD3I/Kh+2eXIy8Skg
lw0tJct1AKh9x5KriO/skM0ZneG5bvZMI2NEZAXJvJPftrkS2qUBL3KbMv+1Al8C
u2Xt+Du9ldlE+uHUZEF0f+/qHmI66hhOsm8qX9HeHqx6huGKUqCDTOzdtk2tP4gc
kz4gboWe2c11mhOpgZsL+03rqxeGNs9KCWpgQ8nPrNCOnLtVBvV3bHE6bOrN5J3Z
AscwCnVuk3SxSUgQk/nKiKlzicTfwtEj2sYgIM3N3wposwEZNMLR+5xzRV3AUPBx
ZFej019QC8Uf1KjMNoY78049/lNE3RfCMUe431NhZyxo0nAjSJcB1e10eRuEYkQZ
procZmJJaFwOpQNCk32ykQ+L1XJPrXCoSwXRMn3FEtwJ2giAtXvdmP3+nNyxYgSo
03U8Ue0PF69ej+Cb3CS6SmfJ8CdC9uTlYWUyB7xRzg==
=LHlN
-----END PGP SIGNATURE-----

--lfqq87cPwwZguC8d--

