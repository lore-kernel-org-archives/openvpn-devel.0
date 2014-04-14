Date: Mon, 14 Apr 2014 21:34:22 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140414193422.GN16637@...1296...>
References: <20140413152613.GT16637@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pAmHAVveDVeALTN/"
Content-Disposition: inline
In-Reply-To: <20140413152613.GT16637@...1296...>
Subject: Re: [Openvpn-devel] RFD: ssl library version numbers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--pAmHAVveDVeALTN/
Content-Type: multipart/mixed; boundary="8+VDc6z2qnbY4V6m"
Content-Disposition: inline

--8+VDc6z2qnbY4V6m
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Apr 13, 2014 at 05:26:13PM +0200, Gert Doering wrote:
> OpenVPN does not currently report the version of the SSL library it is
> using - which I'm not sure whether it's by design or just because nobody
> ever added it.  Anyway, right now I think we need it, to help future
> cases.

OK, here's a "continue the discussion" patch.

This is actually surprisingly messy, as the "first line" OpenVPN prints
is a static string that is referenced all over the place, sometimes sent
to file descriptors, sometimes used with msg(), so extending this to
include the "library version numbers" would be a fairly big change.  So
I've decided to just print a second line:

Mon Apr 14 21:23:11 2014 library versions: OpenSSL 1.0.1g 7 Apr 2014, LZO 2=
.06

or

Mon Apr 14 21:27:49 2014 library versions: PolarSSL 1.2.10

(--with-crypto-library=3Dpolarssl --disable-lzo)


If --push-peer-info is set (and only then), this is sent as part of the
peer-info handshake towards the server:

Apr 14 21:23:49 gentoo openvpn[17804]: 2001:608:4:0:222:68ff:fe7f:7420 peer=
 info: IV_SSL=3DOpenSSL_1.0.1g_7_Apr_2014

(this happens after the client has already accepted the server certificate,
and is part of the same message as username+passwort, so if you trust
the server enough to give him your password, there is no "more secure"
point in the handshake to give him your SSL version).

Library version printing is only done for SSL and LZO so far - LZO is
more "look how messy this gets", but it's encapsulated in options.c, so
sort of acceptable.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--8+VDc6z2qnbY4V6m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Add-SSL-library-version-reporting.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 8126ab53978160529f7797e0e50cfa39a3d4c971 Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Sun, 13 Apr 2014 17:29:32 +0200
Subject: [PATCH] Add SSL library version reporting.

Print the version of the SSL and LZO library (if any) used.

SSL library version is also sent as IV_SSL=3D<version> to the server if
--push-peer-info is enabled.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/openvpn.c      |  1 +
 src/openvpn/options.c      | 18 ++++++++++++++++++
 src/openvpn/ssl.c          |  1 +
 src/openvpn/ssl_backend.h  |  6 ++++++
 src/openvpn/ssl_openssl.c  |  6 ++++++
 src/openvpn/ssl_polarssl.c |  8 ++++++++
 6 files changed, 40 insertions(+)

diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 5125eae..fd87fc1 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -220,6 +220,7 @@ openvpn_main (int argc, char *argv[])
=20
 	  /* print version number */
 	  msg (M_INFO, "%s", title_string);
+	  show_library_versions(M_INFO);
=20
 	  /* misc stuff */
 	  pre_setup (&c.options);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 18cb354..dc74b53 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3435,10 +3435,28 @@ usage_small (void)
   openvpn_exit (OPENVPN_EXIT_STATUS_USAGE); /* exit point */
 }
=20
+void
+show_library_versions(const unsigned int flags)
+{
+  msg (flags, "library versions: %s%s%s",
+#ifdef ENABLE_SSL
+	  		get_ssl_library_version(),
+#else
+			"",
+#endif
+#ifdef ENABLE_LZO
+			", LZO ", lzo_version_string()
+#else
+			"", ""
+#endif
+	);
+}
+
 static void
 usage_version (void)
 {
   msg (M_INFO|M_NOPREFIX, "%s", title_string);
+  show_library_versions( M_INFO|M_NOPREFIX );
   msg (M_INFO|M_NOPREFIX, "Originally developed by James Yonan");
   msg (M_INFO|M_NOPREFIX, "Copyright (C) 2002-2010 OpenVPN Technologies, I=
nc. <sales@...515...>");
 #ifndef ENABLE_SMALL
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index d4acc0f..b09e52b 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1835,6 +1835,7 @@ push_peer_info(struct buffer *buf, struct tls_session=
 *session)
 	  get_default_gateway (&rgi);
 	  if (rgi.flags & RGI_HWADDR_DEFINED)
 	    buf_printf (&out, "IV_HWADDR=3D%s\n", format_hex_ex (rgi.hwaddr, 6, 0=
, 1, ":", &gc));
+	  buf_printf (&out, "IV_SSL=3D%s\n", get_ssl_library_version() );
         }
=20
       /* push env vars that begin with UV_ and IV_GUI_VER */
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index a6fc3bd..b1087e1 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -466,4 +466,10 @@ void show_available_tls_ciphers (const char *tls_ciphe=
rs);
  */
 void get_highest_preference_tls_cipher (char *buf, int size);
=20
+/*
+ * return a pointer to a static memory area containing the
+ * name and version number of the SSL library in use
+ */
+char * get_ssl_library_version(void);
+
 #endif /* SSL_BACKEND_H_ */
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 0b63e26..a7d7142 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1320,4 +1320,10 @@ get_highest_preference_tls_cipher (char *buf, int si=
ze)
   SSL_CTX_free (ctx);
 }
=20
+char *
+get_ssl_library_version(void)
+{
+    return  SSLeay_version(SSLEAY_VERSION);
+}
+
 #endif /* defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_OPENSSL) */
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 9dc4e87..8e0b898 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -1079,4 +1079,12 @@ get_highest_preference_tls_cipher (char *buf, int si=
ze)
   strncpynt (buf, cipher_name, size);
 }
=20
+char *
+get_ssl_library_version(void)
+{
+    static char polar_version[30];	/* "at least 18 bytes in size" */
+    version_get_string_full( polar_version );
+    return polar_version;
+}
+
 #endif /* defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_POLARSSL) */
--=20
1.8.3.2


--8+VDc6z2qnbY4V6m--

--pAmHAVveDVeALTN/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU0w4PqkuBuNlUUl1AQLqvgP+KRAr5uYZrYd42RloLJlXI5TXD/aInSCQ
g4IcB8MobWkqJGqvsMkxUoRMr4V3JULlzo9rgVvMcqcOhRzvxZ6+Qsy3J8EtSKu4
XTLiH03pdL7A+mUpAhOfjELyWhVlNroTUD2ZFk5yKjFQjm/Hr1cENovX7rZZ0Pgg
vf/SeDTEKrM=
=INZJ
-----END PGP SIGNATURE-----

--pAmHAVveDVeALTN/--

