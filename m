Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21D2606A329
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TY8TbGat;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kCIIBtAq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PAG8HBbS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ZDFlow7SpZm6l9CkdHu2Tm34/pjyLfK8df6JvpQZN7o=; b=TY8TbGatJWD/do
	DBkwUBtfCZ1R8H4VEuEotdvqYUtjwgK2NMs+j+V5dLBGohvSkfyBadIUSAEKuIUPDyKQFreWeEVpI
	d3TDehQYH7Pf81l4W1Gf+d3EKCgLzcvmx9HT3SGmcamgfa+aSOkL6A+wKk7Jra9niRCC3P3DGL+kM
	z5M=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xT24j-000000006rM-2sWH;
	Mon, 16 Nov 2026 19:09:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xT24i-000000006rF-3aiJ for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 19:09:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=47BxBm/xSozbye/SxnrACQQdnxzgJ1iCetDrAGfdb3g=; b=kCIIBtAqf1VROH329Xjfn6DgUX
 rc8JRJI41TuSsbscH9Q3EmZ2jTa523Fa6jnJ4AcouT+LMtiwQvoy5AXa7dm+o6MpJZrbQiQNkXMuO
 h5BJ0RqEqLAVENuB+Ns53B6uPu/gZ+0UWq4qdExCJyZCbsCG5Jv4NT162m3snVIwcnt8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=47BxBm/xSozbye/SxnrACQQdnxzgJ1iCetDrAGfdb3g=; b=PAG8HBbSjAC3oIDfxsGwUxT88H
 y6z3ffiOTZ3P0GidHls1ez3dB6hlC6GJXBu5i3zFEu+hzuw0PlChjSaw5I5rX4Wjxk+Zy4kRTwa1q
 fdzfK1cK+sgRl2mSY9i74gZbcM+RWXZ7uwzIM9SkxlkatlNCmmOx3EIx7GvnJrXStgE8=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xT24h-000000007CK-2YQ8 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 19:09:08 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AGJ90OA002495
 for <openvpn-devel@lists.sourceforge.net>; Mon, 16 Nov 2026 20:09:00 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AGJ90Xg002494
 for openvpn-devel@lists.sourceforge.net; Mon, 16 Nov 2026 20:09:00 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 16 Nov 2026 20:08:55 +0100
Message-ID: <20261116190900.2482-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794854317000.Ice2151259fcaa256d7aee588bc3d68c835ea9eb8@gerrit.openvpn.net>
References: <gerrit.1794854317000.Ice2151259fcaa256d7aee588bc3d68c835ea9eb8@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xT24h-000000007CK-2YQ8
Subject: [Openvpn-devel] [PATCH v1] proxy: drop always-on PROXY_DIGEST_AUTH
 guards
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Razvan Cojocaru <razvanc@mailbox.org>

PROXY_DIGEST_AUTH is unconditionally defined to 1. Remove it and its
#if blocks. In the digest branch of establish_http_proxy_passthru(),
also drop the re-check of auth_method == HTTP_AUTH_DIGEST, which the
enclosing condition already guarantees, and its dead else.

Change-Id: Ice2151259fcaa256d7aee588bc3d68c835ea9eb8
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2203
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2203
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c
index 9bfa074..a6803e9 100644
--- a/src/openvpn/httpdigest.c
+++ b/src/openvpn/httpdigest.c
@@ -26,8 +26,6 @@
 
 #include "syshead.h"
 
-#if PROXY_DIGEST_AUTH
-
 #include "crypto.h"
 #include "httpdigest.h"
 
@@ -141,5 +139,3 @@
     md_ctx_free(md5_ctx);
     CvtHex(RespHash, Response);
 }
-
-#endif /* if PROXY_DIGEST_AUTH */
diff --git a/src/openvpn/httpdigest.h b/src/openvpn/httpdigest.h
index 37f3d98..20db1c4 100644
--- a/src/openvpn/httpdigest.h
+++ b/src/openvpn/httpdigest.h
@@ -20,8 +20,6 @@
  *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */
 
-#if PROXY_DIGEST_AUTH
-
 #define HASHLEN 16
 typedef unsigned char HASH[HASHLEN];
 #define HASHHEXLEN 32
@@ -42,5 +40,3 @@
                         const HASHHEX HEntity,     /* H(entity body) if qop="auth-int" */
                         HASHHEX Response           /* request-digest or response-digest */
 );
-
-#endif /* if PROXY_DIGEST_AUTH */
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index cd9f3b2..437733e 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -348,14 +348,12 @@
                 *data = string_alloc(buf + 26, NULL);
                 ret = HTTP_AUTH_BASIC;
             }
-#if PROXY_DIGEST_AUTH
             else if (!strncmp(buf + 20, "Digest ", 7))
             {
                 msg(D_PROXY, "PROXY AUTH DIGEST: '%s'", buf);
                 *data = string_alloc(buf + 27, NULL);
                 ret = HTTP_AUTH_DIGEST;
             }
-#endif
         }
     }
 }
@@ -714,121 +712,108 @@
         {
             processed = true;
         }
-#if PROXY_DIGEST_AUTH
         else if (p->auth_method == HTTP_AUTH_DIGEST && !processed)
         {
             const char *pa = p->proxy_authenticate;
-            const int method = p->auth_method;
             ASSERT(pa);
 
-            if (method == HTTP_AUTH_DIGEST)
+            const char *http_method = "CONNECT";
+            const char *nonce_count = "00000001";
+            const char *qop = "auth";
+            const char *username = p->up.username;
+            const char *password = p->up.password;
+            char *opaque_kv = "";
+            char uri[128];
+            uint8_t cnonce_raw[8];
+            HASHHEX session_key;
+            HASHHEX response;
+
+            const char *realm = get_pa_var("realm", pa, &gc);
+            const char *nonce = get_pa_var("nonce", pa, &gc);
+            const char *algor = get_pa_var("algorithm", pa, &gc);
+            const char *opaque = get_pa_var("opaque", pa, &gc);
+
+            if (!realm || !nonce)
             {
-                const char *http_method = "CONNECT";
-                const char *nonce_count = "00000001";
-                const char *qop = "auth";
-                const char *username = p->up.username;
-                const char *password = p->up.password;
-                char *opaque_kv = "";
-                char uri[128];
-                uint8_t cnonce_raw[8];
-                uint8_t *cnonce;
-                HASHHEX session_key;
-                HASHHEX response;
-
-                const char *realm = get_pa_var("realm", pa, &gc);
-                const char *nonce = get_pa_var("nonce", pa, &gc);
-                const char *algor = get_pa_var("algorithm", pa, &gc);
-                const char *opaque = get_pa_var("opaque", pa, &gc);
-
-                if (!realm || !nonce)
-                {
-                    msg(D_LINK_ERRORS, "HTTP proxy: digest auth failed, malformed response "
-                                       "from server: realm= or nonce= missing");
-                    goto error;
-                }
-
-                /* generate a client nonce */
-                prng_bytes(cnonce_raw, sizeof(cnonce_raw));
-                cnonce = make_base64_string2(cnonce_raw, sizeof(cnonce_raw), &gc);
-
-
-                /* build the digest response */
-                snprintf(uri, sizeof(uri), "%s:%s", host, port);
-
-                if (opaque)
-                {
-                    const size_t len = strlen(opaque) + 16;
-                    opaque_kv = gc_malloc(len, false, &gc);
-                    snprintf(opaque_kv, len, ", opaque=\"%s\"", opaque);
-                }
-
-                DigestCalcHA1(algor, username, realm, password, nonce, (char *)cnonce, session_key);
-                DigestCalcResponse(session_key, nonce, nonce_count, (char *)cnonce, qop,
-                                   http_method, uri, NULL, response);
-
-                /* format HTTP CONNECT message */
-                snprintf(buf, sizeof(buf), "%s %s HTTP/%s", http_method, uri,
-                         p->options.http_version);
-
-                msg(D_PROXY, "Send to HTTP proxy: '%s'", buf);
-
-                /* send HTTP CONNECT message to proxy */
-                if (!send_line_crlf(sd, buf))
-                {
-                    goto error;
-                }
-
-                /* send HOST etc, */
-                if (!add_proxy_headers(p, sd, host))
-                {
-                    goto error;
-                }
-
-                /* send digest response */
-                if (!checked_snprintf(
-                        buf, sizeof(buf),
-                        "Proxy-Authorization: Digest username=\"%s\", realm=\"%s\", nonce=\"%s\", uri=\"%s\", qop=%s, nc=%s, cnonce=\"%s\", response=\"%s\"%s",
-                        username, realm, nonce, uri, qop, nonce_count, cnonce, response, opaque_kv))
-                {
-                    goto error;
-                }
-
-                msg(D_PROXY, "Send to HTTP proxy: '%s'", buf);
-                if (!send_line_crlf(sd, buf))
-                {
-                    goto error;
-                }
-                if (!send_crlf(sd))
-                {
-                    goto error;
-                }
-                /* clear any sensitive content in buf */
-                secure_memzero(buf, sizeof(buf));
-
-                /* receive reply from proxy */
-                if (!recv_line(sd, buf, sizeof(buf),
-                               get_server_poll_remaining_time(server_poll_timeout), true, NULL,
-                               signal_received))
-                {
-                    goto error;
-                }
-
-                /* remove trailing CR, LF */
-                chomp(buf);
-
-                msg(D_PROXY, "HTTP proxy returned: '%s'", buf);
-
-                /* parse return string */
-                nparms = sscanf(buf, "%*s %d", &status);
-                processed = true;
-            }
-            else
-            {
-                msg(D_PROXY, "HTTP proxy: digest method not supported");
+                msg(D_LINK_ERRORS, "HTTP proxy: digest auth failed, malformed response "
+                                   "from server: realm= or nonce= missing");
                 goto error;
             }
+
+            /* generate a client nonce */
+            prng_bytes(cnonce_raw, sizeof(cnonce_raw));
+            uint8_t *cnonce = make_base64_string2(cnonce_raw, sizeof(cnonce_raw), &gc);
+
+            /* build the digest response */
+            snprintf(uri, sizeof(uri), "%s:%s", host, port);
+
+            if (opaque)
+            {
+                const size_t len = strlen(opaque) + 16;
+                opaque_kv = gc_malloc(len, false, &gc);
+                snprintf(opaque_kv, len, ", opaque=\"%s\"", opaque);
+            }
+
+            DigestCalcHA1(algor, username, realm, password, nonce, (char *)cnonce, session_key);
+            DigestCalcResponse(session_key, nonce, nonce_count, (char *)cnonce, qop,
+                               http_method, uri, NULL, response);
+
+            /* format HTTP CONNECT message */
+            snprintf(buf, sizeof(buf), "%s %s HTTP/%s", http_method, uri,
+                     p->options.http_version);
+
+            msg(D_PROXY, "Send to HTTP proxy: '%s'", buf);
+
+            /* send HTTP CONNECT message to proxy */
+            if (!send_line_crlf(sd, buf))
+            {
+                goto error;
+            }
+
+            /* send HOST etc, */
+            if (!add_proxy_headers(p, sd, host))
+            {
+                goto error;
+            }
+
+            /* send digest response */
+            if (!checked_snprintf(
+                    buf, sizeof(buf),
+                    "Proxy-Authorization: Digest username=\"%s\", realm=\"%s\", nonce=\"%s\", uri=\"%s\", qop=%s, nc=%s, cnonce=\"%s\", response=\"%s\"%s",
+                    username, realm, nonce, uri, qop, nonce_count, cnonce, response, opaque_kv))
+            {
+                goto error;
+            }
+
+            msg(D_PROXY, "Send to HTTP proxy: '%s'", buf);
+            if (!send_line_crlf(sd, buf))
+            {
+                goto error;
+            }
+            if (!send_crlf(sd))
+            {
+                goto error;
+            }
+            /* clear any sensitive content in buf */
+            secure_memzero(buf, sizeof(buf));
+
+            /* receive reply from proxy */
+            if (!recv_line(sd, buf, sizeof(buf),
+                           get_server_poll_remaining_time(server_poll_timeout), true, NULL,
+                           signal_received))
+            {
+                goto error;
+            }
+
+            /* remove trailing CR, LF */
+            chomp(buf);
+
+            msg(D_PROXY, "HTTP proxy returned: '%s'", buf);
+
+            /* parse return string */
+            nparms = sscanf(buf, "%*s %d", &status);
+            processed = true;
         }
-#endif /* if PROXY_DIGEST_AUTH */
         else if (p->options.auth_retry)
         {
             /* figure out what kind of authentication the proxy needs */
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 65baee3..8f27436 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -480,11 +480,6 @@
 #endif
 
 /*
- * Should we include proxy digest auth functionality
- */
-#define PROXY_DIGEST_AUTH 1
-
-/*
  * Do we have CryptoAPI capability?
  */
 #if defined(_WIN32) && defined(ENABLE_CRYPTO_OPENSSL) && !defined(ENABLE_CRYPTO_WOLFSSL)


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
