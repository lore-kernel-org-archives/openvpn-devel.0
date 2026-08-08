Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B656CC55174
	for <openvpn-devel@archiver.kernel.org>; Sat,  8 Aug 2026 13:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7n5zpI4hYjk98GIfaCFaDNo2ecL9jpUSQCR1SvyX6vo=; b=dsn96/hSEa9OXeb4oL3NRhDU+W
	4YFlmjScotCvK8clOTmUM7CTNZiW7a7w5At3NrB+lWBdn7EtKUlICTaRm/bbsmlSIsP17HatFPAqJ
	WL9/WLThW1K/EOeh75sDITv7kEIEsrSIvovTsg/iSnn+66ELEmfrGsNCx6WVCpdhTU3g=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsh9p-0000AC-Hb;
	Sat, 08 Aug 2026 13:32:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wsh9o-00009t-G4
 for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 13:32:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0KJInzbHvG5x1X0x72Eym7ZTUgJcR8OKMf+z75RR6v4=; b=Mnj7mkuLUFOojuMZKzHIw4DVGv
 iThrRRE8Ads1bqUViRUT0TJdEHDqsDV8s9ecOHLMWr0NCATLEePULEUHeQJqrMeB/RK7s/5FwxjaV
 Lp0hzwrmZC0DcyMl4WP6/wb8AjK+QhY9JkwvOAW0pMLHBf+cqvhhfEj/VzxoZmmVEDBY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0KJInzbHvG5x1X0x72Eym7ZTUgJcR8OKMf+z75RR6v4=; b=monJtTgrJXqzM1Cty3D+T+5LPG
 31ya6URpZMd6+kmAw5uh5Ho/OpvoL4RuWWekBhWx8e2mx4FHkg0MvJFAXUB5p/LSJlMD/IStdP6VA
 mOWsCp2wgFwevoqFd9YUZPt7az2ssNADYue3GG2ddQgDtXKIcM8JiuLj+TLZr+UtYNV0=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wsh9r-0003Q0-2U for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 13:32:13 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 678DW4ha006151
 for <openvpn-devel@lists.sourceforge.net>; Sat, 8 Aug 2026 15:32:04 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 678DW4V3006150
 for openvpn-devel@lists.sourceforge.net; Sat, 8 Aug 2026 15:32:04 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat,  8 Aug 2026 15:31:58 +0200
Message-ID: <20260808133204.6139-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1775343746000.I81b7168b64c438f759eace1e8f2735891c797bb9@gerrit.openvpn.net>
References: <gerrit.1775343746000.I81b7168b64c438f759eace1e8f2735891c797bb9@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wsh9r-0003Q0-2U
Subject: [Openvpn-devel] [PATCH v12] Hide various functions when unused
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Frank Lichtenheld <frank@lichtenheld.com>

Wrap them into the same ifdef as their only user(s).

Identified by cppcheck.

Change-Id: I81b7168b64c438f759eace1e8f2735891c797bb9
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1611
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1611
This mail reflects revision 12 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 5f2b233..922238d 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -594,6 +594,7 @@
     return str;
 }
 
+#ifdef _WIN32
 /*
  * like buf_null_terminate, but operate on strings
  */
@@ -610,6 +611,7 @@
         *(str + len - 1) = '\0';
     }
 }
+#endif
 
 /*
  * Remove trailing \r and \n chars.
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 833ae6f..c6722c7 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -470,7 +470,9 @@
 
 const char *skip_leading_whitespace(const char *str);
 
+#ifdef _WIN32
 void string_null_terminate(char *str, int len, int capacity);
+#endif
 
 /**
  * Write buffer contents to file.
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 2900352..26d4c7c 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -84,18 +84,20 @@
 /* If non-null, messages should be written here (used for debugging only) */
 static FILE *msgfp; /* GLOBAL */
 
-/* If true, we forked from main OpenVPN process */
-static bool forked; /* GLOBAL */
-
 /* our default output targets */
 static FILE *default_out; /* GLOBAL */
 static FILE *default_err; /* GLOBAL */
 
+/* If true, we forked from main OpenVPN process */
+static bool forked; /* GLOBAL */
+
+#if PORT_SHARE
 void
 msg_forked(void)
 {
     forked = true;
 }
+#endif
 
 bool
 set_debug_level(const int level, const unsigned int flags)
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 3b742d7..45826a2 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -260,8 +260,10 @@
     return check_debug_level(flags) && dont_mute(flags);
 }
 
+#if PORT_SHARE
 /* Call if we forked */
 void msg_forked(void);
+#endif
 
 /* syslog output */
 
@@ -393,12 +395,14 @@
     return false;
 }
 
+#if defined(ENABLE_CRYPTO_OPENSSL)
 /** Convert fatal errors to nonfatal, don't touch other errors */
 static inline msglvl_t
 nonfatal(const msglvl_t err)
 {
     return (err & M_FATAL) ? (err ^ M_FATAL) | M_NONFATAL : err;
 }
+#endif
 
 static inline int
 openvpn_errno_maybe_crt(bool *crt_error)
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 8bcc332..0f66ad51 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2961,6 +2961,8 @@
     return rwflags;
 }
 
+#if UNIX_SOCK_SUPPORT
+
 void
 sd_close(socket_descriptor_t *sd)
 {
@@ -2971,8 +2973,6 @@
     }
 }
 
-#if UNIX_SOCK_SUPPORT
-
 /*
  * code for unix domain sockets
  */
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index b490610..1a532e1 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -366,7 +366,9 @@
 
 void link_socket_close(struct link_socket *sock);
 
+#ifdef ENABLE_MANAGEMENT
 void sd_close(socket_descriptor_t *sd);
+#endif
 
 void bad_address_length(int actual, int expected);
 
diff --git a/src/openvpn/socket_util.h b/src/openvpn/socket_util.h
index 13deeaa..13f5962 100644
--- a/src/openvpn/socket_util.h
+++ b/src/openvpn/socket_util.h
@@ -250,6 +250,7 @@
     }
 }
 
+#ifdef TARGET_ANDROID
 static inline bool
 addr_local(const struct sockaddr *addr)
 {
@@ -269,12 +270,12 @@
             return false;
     }
 }
+#endif
 
-
+#if ENABLE_IP_PKTINFO
 static inline bool
 addr_defined_ipi(const struct link_socket_actual *lsa)
 {
-#if ENABLE_IP_PKTINFO
     if (!lsa)
     {
         return 0;
@@ -296,11 +297,9 @@
         default:
             return 0;
     }
-#else /* if ENABLE_IP_PKTINFO */
-    ASSERT(0);
-#endif
     return false;
 }
+#endif
 
 /*
  * Overhead added to packets by various protocols.
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 32b13db..e4b760e 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -436,6 +436,7 @@
     }
 }
 
+#ifdef TLS1_3_VERSION
 static void
 convert_tls13_list_to_openssl(char *openssl_ciphers, size_t len, const char *ciphers)
 {
@@ -460,6 +461,7 @@
         }
     }
 }
+#endif
 
 void
 tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const char *ciphers)
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/openvpn/test_pkcs11.c
index 8b6e594..042bd8b 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -45,6 +45,7 @@
 
 struct management *management; /* global */
 
+#if defined(ENABLE_CRYPTO_OPENSSL)
 /* replacement for crypto_print_openssl_errors() */
 void
 crypto_print_openssl_errors(const unsigned int flags)
@@ -55,6 +56,7 @@
         msg(flags, "OpenSSL error %lu: %s", e, ERR_error_string(e, NULL));
     }
 }
+#endif
 
 /* stubs for some unused functions instead of pulling in too many dependencies */
 int


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
