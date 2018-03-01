Message-ID: <52e860ea74ac958309368374049f14bd.squirrel@...2257...>
Date: Thu, 1 Mar 2018 12:14:06 +0100
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20180301121406_85250"
Subject: [Openvpn-devel] tls fix for upcoming 2.4.5
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

------=_20180301121406_85250
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

I've just done some test builds with 2.4.5 tagged version.

Attached patch makes it build with older systems. Do you see any issue
with the change?

Regards,
Simon
------=_20180301121406_85250
Content-Type: text/x-patch; name="openvpn-2.4.5-tlsv1_version.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="openvpn-2.4.5-tlsv1_version.patch"

--- openvpn-2.4.5/src/openvpn/openssl_compat.h.orig	2018-02-28 21:56:54.000000000 +0100
+++ openvpn-2.4.5/src/openvpn/openssl_compat.h	2018-03-01 11:44:57.000000000 +0100
@@ -672,14 +672,18 @@
     {
         return TLS1_VERSION;
     }
+#ifdef SSL_OP_NO_TLSv1_1
     if (!(sslopt & SSL_OP_NO_TLSv1_1))
     {
         return TLS1_1_VERSION;
     }
+#endif
+#ifdef SSL_OP_NO_TLSv1_2
     if (!(sslopt & SSL_OP_NO_TLSv1_2))
     {
         return TLS1_2_VERSION;
     }
+#endif
     return 0;
 }
 #endif /* SSL_CTX_get_min_proto_version */
------=_20180301121406_85250--



