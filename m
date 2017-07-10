References: <20170221192737.24166-1-davids@...515...>
	<20170221192737.24166-4-davids@...515...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <24404f85-157d-6d20-9fb7-8b942360a50d@...2181...>
Date: Mon, 10 Jul 2017 12:31:31 +0800
MIME-Version: 1.0
In-Reply-To: <20170221192737.24166-4-davids@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UV647paxij6F91nLENnAuo2GMtnueLthr"
Subject: Re: [Openvpn-devel] [PATCH v2 3/3] Replace deprecated LZ4 function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net
Cc: Christian Hesse <mail@...1798...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UV647paxij6F91nLENnAuo2GMtnueLthr
Content-Type: multipart/mixed; boundary="A6Ue3nNELubAfqdTLvkl6l83q4h3NtiXQ";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net
Cc: Christian Hesse <mail@...1798...>
Message-ID: <24404f85-157d-6d20-9fb7-8b942360a50d@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2 3/3] Replace deprecated LZ4 function
References: <20170221192737.24166-1-davids@...515...>
 <20170221192737.24166-4-davids@...515...>
In-Reply-To: <20170221192737.24166-4-davids@...515...>

--A6Ue3nNELubAfqdTLvkl6l83q4h3NtiXQ
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 22/02/17 03:27, David Sommerseth wrote:
> +#if defined LZ4_VERSION_NUMBER && LZ4_VERSION_NUMBER >=3D 10700
> +        zlen =3D LZ4_compress_default((const char *)BPTR(buf), (char *)B=
PTR(work), BLEN(buf), zlen_max );
> +#else
>          zlen =3D LZ4_compress_limitedOutput((const char *)BPTR(buf), (ch=
ar *)BPTR(work), BLEN(buf), zlen_max );
> +#endif

Instead of cluttering the code with these ifdefs directly in the main
codebase, how about doing it in compat.h, like this (it's a copy/paste -
code might be wrapper by the mail client):


diff --git a/src/compat/compat.h b/src/compat/compat.h
index d5228989..fa1b096e 100644
--- a/src/compat/compat.h
+++ b/src/compat/compat.h
@@ -70,4 +70,13 @@ int inet_pton(int af, const char *src, void *dst);

 #endif

+int ovpn_lz4_compress(const char *src, char *dst, int src_len, int
src_max_len)
+{
+#if defined LZ4_VERSION_NUMBER && LZ4_VERSION_NUMBER >=3D 10700
+    return LZ4_compress_default(src, dst, src_len, src_max_len);
+#else
+    return LZ4_compress_limitedOutput(src, dst, src_len, src_max_len);
+#endif
+}
+
 #endif /* COMPAT_H */
diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index 6e40c325..a23a43c4 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -86,8 +86,8 @@ do_lz4_compress(struct buffer *buf,
             return false;
         }

-        zlen =3D LZ4_compress_limitedOutput((const char *)BPTR(buf),
(char *)BPTR(work), BLEN(buf), zlen_max );
-
+        zlen =3D ovpn_lz4_compress((const char *)BPTR(buf), (char
*)BPTR(work),
+                                 BLEN(buf), zlen_max );
         if (zlen <=3D 0)
         {
             dmsg(D_COMP_ERRORS, "LZ4 compression error");



This way we can put all similar changes in the same file and keep them
under control (IMHO we should avoid having #ifdefs directly in the
middle of the code as much as possible).

Cheers,


--=20
Antonio Quartulli


--A6Ue3nNELubAfqdTLvkl6l83q4h3NtiXQ--

--UV647paxij6F91nLENnAuo2GMtnueLthr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAlljAyYACgkQ0+HICM1s
oFDNXg//YsM9ur7KH419CrhQ8hCFjLGHunLn/sy2v0wF1tQhcpafkk+8AuEURQtn
ZfcCgbdeFo/RgbVKOHbGod75NxHUuxShulDK6KohbMnX4bAHaKQlzx552Jp6Le/n
51a6CkRfn4QUUvKCEhiDFEptjgJRt671b6QaB6jAEFLE0RnQVD2HFecb4Ids5t3K
W5wswsZteipeBJj4wEovmNclM4wvNuXplG5u2onBsOIJglQXdLP8raUPIP82dnn2
fuFobR0so2ysiQnXi47rHcO682Mo6HbeEcMZDCORH3is2c3nz1k/NGHNKRkBWZq6
3OmFQSSyWThb4BmjCXiNhKHZbZeDYR4hmFfE/HZe3Wk/JTGFk8du3jxXWdydDdGV
yu2Mp/E2S+LGLCXaKydgi1iJIT4igYuWQVnEGtUKGNamoZ2w9WD36pDKUpuYhQgl
3+V0dgZCyd/X5Pbhp8vvPSEBP3PnQ6dpF0TsWhcG85Kxwd5y08UFZUSUUxVGxZIJ
R+RoC3xCwWRXSNSeCplGZU0tdszEEAdQRjct8/tI3Et1yS/ZW+oTL/BazTAZsTvJ
jWVhFu7W9pcOomPHov49QlWGZjWVAY/36OBSfQKgDVyfIosMbsYi2lnqOB/GFKr4
G/hrvH8mvwbSDbZezigbOlrzzwXWC2DyJP6v+sZ8CmRvsZveqBY=
=OJh5
-----END PGP SIGNATURE-----

--UV647paxij6F91nLENnAuo2GMtnueLthr--

