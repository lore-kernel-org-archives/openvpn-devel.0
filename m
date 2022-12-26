Date: Mon, 26 Dec 2022 23:19:48 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y6oeBENRNro1NQA+@greenie.muc.de>
References: <20210825210232.22509-1-selva.nair@...277...>
 <20210907223126.8440-1-selva.nair@...277...>
 <20210907223126.8440-3-selva.nair@...277...>
 <ec71e35a-b62d-0efb-9899-8a9e4034349e@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+AfA8aGB/qv6cYo7"
Content-Disposition: inline
In-Reply-To: <ec71e35a-b62d-0efb-9899-8a9e4034349e@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3 3/3] Use a template for "unsupported
 management commands" error
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

--+AfA8aGB/qv6cYo7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Dec 26, 2022 at 08:50:33PM +0100, Arne Schwabe wrote:
> Am 08.09.21 um 00:31 schrieb selva.nair@...277...:
> > From: Selva Nair <selva.nair@...277...>
> >=20
> > The message
> > "ERROR: The 'foo' commmand is not supported by current daemon mode"
> > is repeatedly used in manage.c. Move it to a function for uniformity
> > in messaging.
> >=20
> > v3, v3: no change
>=20
> Acked-By: Arne Schwabe <arne@...1227...>
>=20
> This patch currently has a conflict since PF code was removed. I will=20
> let Gert decide if he wants to adjust the patch or a rebased v4.

This patch set was left way too long out in the sun to dry...  I will
adjust this ("remove the hunk that deals with client-pf"), trivial=20
enough.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--+AfA8aGB/qv6cYo7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjqh4DAAoJEB2Cnv7KVigSfYsL/RGzXkr1vyI5+O/VJK4meUEm
MFkM7aTjwon1+g4BgZpF0UYnnWYkriIYVxSaGD9+J9tC1nmwPFCu57bV144Hox/9
UPeuZdtPvYpQNaC/iNFI3ZL+P3Cfj93G0HjV2dY0pLFwI8lmS8xdT1ARbALBOcoW
6li5n4J2scA/lO8QnRGHMU6pf5o9hec7WIAAFwFzQECGF5nFmfA20dmbVfIzewVo
rm/Q6LyL/44aVKDPUcKv+8Xo3Ro/P8qIh+HId+5kxsrj/+rHQ2+7kDnyZ8J+e6Yr
eqWB2onJ43ScQMcIo2Z1G9ScFnwQC+a5n90GgU97byO7XqCYzMnfGQKgqQPZKBqa
5wzlQRA+vjYmsWGDtwu11bDG3dDekP2WMvCqRX+ofFWIoWOHFTEJ2EcJgUytH8e9
Fx8GJvD7/algAwCe/BF4zoLanI5bpwQPZ8icnVxaueWurY1EPwxojfMms9MkGBp+
ofXL4I7VhbTygFq1qBzWLUPIAmPTFpjfWERGCu9cLA==
=WGnq
-----END PGP SIGNATURE-----

--+AfA8aGB/qv6cYo7--

