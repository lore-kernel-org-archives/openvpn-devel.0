Date: Thu, 16 Jul 2020 19:34:58 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200716173458.GF1431@...1296...>
References: <20200716134315.17742-1-arne@...1227...>
 <20200716134315.17742-3-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vhC2VfIu4iQddoqq"
Content-Disposition: inline
In-Reply-To: <20200716134315.17742-3-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v7 3/6] client-connect: Use inotify for
 the deferred client-connect status file
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

--vhC2VfIu4iQddoqq
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jul 16, 2020 at 03:43:12PM +0200, Arne Schwabe wrote:
> As we never do client-connect and authentication at the same time
> it is safe to reuse the existing fields for client-connect return
> status file

I don't have anything with inotify prepared right now, so I can't
really test this (it compiles *without* #define ENABLE_ASYNC_PUSH,
this I can already attest).

It would be good to have Lev test this very thoroughly...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--vhC2VfIu4iQddoqq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfEI/CAAoJEB2Cnv7KVigS+4wMAIDHfBDG2WMnNH/hQclIHf0z
PcGuvUSr5ERsd+R63TCjLAUX85J5Cj1Bk430ifakdecLpqtxpl4xzk66PHerDGQQ
YAIzMCGl/LbY6KOv3bpGtbW5Aaqj2eoVfDAZhRIlFAttsXnNg4BOoWRIV1GFqoPW
uBlZh8x+J3TzltOjgxus9+BUuL2BJg2P6sbw8jvstI+7QbSgcFzGeqFiY9L592SM
rUuY6GdtErRVe7lmgeUCXuVi7LV6jPaDVWZoyx4vr8LIZUvYgOWX2AedeAxpyjD5
xCQBLTEB7UteNVj9IFZiXe4By8rKkQ1atLznLlKN3U+nJIpw6kj+IN0wcylJFF2c
ieHzXOkhn2teHN322OnuwUDkyMBa5oTLXNPCK3lFkDJMU21qcwtqzxS7sr3wCi/S
MDdpL1bh1dIRXhyt/XFv+i43JNMrCuP+EmX6z69iV8F8RG7IUrYidS4l2jOY7+0y
73uMFf7OFQdpU6yfoCTJnKxClmQ+NPFEsA1fmru27A==
=bMJv
-----END PGP SIGNATURE-----

--vhC2VfIu4iQddoqq--

