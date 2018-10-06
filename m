Date: Sat, 6 Oct 2018 15:26:57 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20181006132657.GT962@...1296...>
References: <6cf2ad26-d6e6-50a7-cb2c-d15a5ff4a198@...1856...>
 <20171112084830.22912-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="uLekVA18SmRka8J6"
Content-Disposition: inline
In-Reply-To: <20171112084830.22912-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v6] merge *-inline.h files with their
 main header
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

--uLekVA18SmRka8J6
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Nov 12, 2017 at 04:48:30PM +0800, Antonio Quartulli wrote:
> *-inline.h files are not very useful anymore.
> In the attempt of cleaning up the code some more,
> merge them into their main header files.
>=20
> At the same time, move functions from fowrard.h
> to forward.c, when they are used only in the latter.
>=20
> No functional change is part of this patch.
>=20
> Cc: Steffan Karger <steffan@...1856...>
> Signed-off-by: Antonio Quartulli <a@...2181...>

I'd love to merge this, but I can't - besides the easily fixed rebases
("the company that is mentioned in the copyright notices has been
renamed"), there are actual changes in pf-inline.h that make it different
from "the pf-inline.h that the patch removes"

@@ -31,20 +31,24 @@
 #define PCT_SRC  1
 #define PCT_DEST 2
 static inline bool
-pf_c2c_test(const struct context *src, const struct context *dest, const c=
har *prefix)
+pf_c2c_test(const struct pf_context *src_pf, const struct tls_multi *src,
+            const struct pf_context *dest_pf, const struct tls_multi *dest,
+            const char *prefix)

...
-pf_addr_test(const struct context *src, const struct mroute_addr *dest, co=
nst char *prefix)
+pf_addr_test(const struct pf_context *src_pf, const struct context *src,
+             const struct mroute_addr *dest, const char *prefix)



so it seems you had "pf changes" in your tree when sending this patch...

Can you easily rebase this to "unchanged master"?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--uLekVA18SmRka8J6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbuLghAAoJEB2Cnv7KVigS8DYMAJLKhrSztWRHHVMjM57kaj7u
KInV/1nPB6Fo9ustnkCu9Mqkbf/hLRlUJM9ZrfCgImEF3gn3jbN1rkYXTyxKU2x6
RGfyc/gTubGTw5EkfkKD/llZr4O0rcRjrXY6FKU2Vy2A2nyzV2EtEiUcEFIM9fXp
tSnb8EYKmLBA6rhL4qLXknVI1Qf9mvXpRly+QbVBM5L7nbjpNjWHcrjCaVAeQrDQ
8yBV/QJa37Nlt5hFfD/cmPo8ZipeUGA+n02eyRbRdaJ1/XG6wuBnRljiyrlD9tPn
7/rcoiS0J4bK7Jn14qTiXXNUQkELluCSNCx4nVQCF/xGKA0BClc+zsCME+UdQ8bO
+QMjiV1N8BTyCOFwlsnGYxY4X56h7L892VHsq648DZLmixolfu4K4enMqCkNUydl
/qAZjGPnqBaU7vky6/KA+TFiRyUaHMqtMz8iMDqt5kfFBnJOmun4XkqDDAR2Gwvy
GJpi8Yl7CPt2pBjbDKb4gVpAkOwQk8JY1gXeByz+SQ==
=qdv0
-----END PGP SIGNATURE-----

--uLekVA18SmRka8J6--

