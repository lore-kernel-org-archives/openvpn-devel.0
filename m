Message-ID: <49496.109.81.184.65.1461736834.squirrel@...1899...>
Date: Wed, 27 Apr 2016 08:00:34 +0200 (CEST)
From: "Daniel Kubec" <niel@...1898...>
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20160427080034_50304"
Subject: [Openvpn-devel] Exported keying material is always sizeof(unsigned
	char*)
Reply-To: niel@...1898...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

------=_20160427080034_50304
Content-Type: text/plain; charset="ISO-8859-2"
Content-Transfer-Encoding: quoted-printable

There is patch 'git show 41e4b67a229e774ebc57a882c386e10d80e10e7e'
which actually works arround poor support of c99 in MSVC compiler released
in 2013 :)

It introduces the bug because exported key size is always sizeof(unsigned
char *).

There is patch for this.=

------=_20160427080034_50304
Content-Type: text/x-patch; name="openvpn-rfc5705-exported-size-fix.patch"
Content-Disposition: attachment;
	filename="openvpn-rfc5705-exported-size-fix.patch"
Content-Transfer-Encoding: quoted-printable

From 65c273f4d2eb63a26d270b870e303d5eff99cd0a Mon Sep 17 00:00:00 2001
From: Daniel Kubec <niel@...1898...>
Date: Wed, 27 Apr 2016 07:40:31 +0200
Subject: [PATCH 1/1] Exported keying material is always sizeof(unsigned c=
har *)

There is patch 'git show 41e4b67a229e774ebc57a882c386e10d80e10e7e'
which actually works arround poor support of c99 in MSVC compiler release=
d in 2013 :)

It introduces the bug because exported key size is always sizeof(unsigned=
 char *).
There is patch for this.
---
 src/openvpn/ssl_openssl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index ca9b67b..8909ca3 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -144,7 +144,7 @@ key_state_export_keying_material(struct key_state_ssl=
 *ssl,
       struct gc_arena gc =3D gc_new();
       unsigned char* ekm =3D (unsigned char*) gc_malloc(size, true, &gc)=
;
=20
-      if (SSL_export_keying_material(ssl->ssl, ekm, sizeof(ekm),
+      if (SSL_export_keying_material(ssl->ssl, ekm, size,
           session->opt->ekm_label, session->opt->ekm_label_size, NULL, 0=
, 0))
        {
          unsigned int len =3D (size * 2) + 2;
--=20
1.7.1

------=_20160427080034_50304--


