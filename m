Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52C26072C5C
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QGkjmHpD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gmldF//n;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aBc3upzX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=IN0Xp7Yz3qI0/eFMRjiEEuvg/8+CVXRCtd3OvEWveCc=; b=QGkjmHpDxDlYPP
	tlW+TeT9g5MWyZ8gcRXoRr57aXNOdHwg/n2q+KSVn+m2oxImXn1fE2cj8hOXpqst3FZSx8Qz2KROg
	eKrB5J90o3A2iJmZyEiJI3EFly7qfD+1P3KO5TdjKZxrkWPv9B38Y88b3HlVCASIvGjw6Jg/ughS/
	7+I=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNve4-000000001iZ-03ZP;
	Mon, 02 Nov 2026 17:16:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xNve3-000000001iS-0nbg for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 17:16:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2YmLceOtrA+zovCC7H6qgEY4o+MKF6ScTBNqzwyXA8w=; b=gmldF//nCd+n1dMxTD7gmZjnak
 3L5h6PKMx7ueMY9Lp5JrBsgmW+Dg5lAFAllG7r2QfaAFIMJXITIQPyyGuf9shsTHBiNlRrWUMeWfN
 Xvf+Y6s5V/a0Kj2mArLSahtqnRX1Af1hW2+g/oUWuiCfBOuAmmRqJaHd0ZbcKDG6PycY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2YmLceOtrA+zovCC7H6qgEY4o+MKF6ScTBNqzwyXA8w=; b=aBc3upzXKc3jIF5AFiPioXbGMg
 kc5UgO6+EG6PRiEXw+SGCeHqyO+TxBUjhj+CS4ffYi6jtbKlV3WTJ2CPyFhJZrRdBTJRNpzneKmOz
 1yCr7ee0LTP8h6f0dZp0EruBAxCvuzqQCh4WR7i4rPkrGUjwrG2UGyehht5BRCbEGOgk=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNvdz-000000006dt-1YWg for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 17:16:31 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A2HGKxF015644
 for <openvpn-devel@lists.sourceforge.net>; Mon, 2 Nov 2026 18:16:20 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A2HGKah015643
 for openvpn-devel@lists.sourceforge.net; Mon, 2 Nov 2026 18:16:20 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  2 Nov 2026 18:16:14 +0100
Message-ID: <20261102171620.15627-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
References: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xNvdz-000000006dt-1YWg
Subject: [Openvpn-devel] [PATCH v3] Remove replay-persist
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

From: Arne Schwabe <arne@rfc2549.org>

This feature is very niche and we do not think it is something we
should maintain and support going forward.

This feature saves a single packet id to persist-replay file.
This makes the feature only properly work in a p2p setup where both
sides use replay-persist to save the last known packet id from the
peer. Even then it will only prevent some packet replays until the
legitimate peer sends a packet again.

In server mode (p2mp) each client context has its own replay state
and saving a single packet id is also not very useful with multiple
clients and multiple states.

Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2082
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2082
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/Changes.md b/Changes.md
index 7f47f77..89a72fe 100644
--- a/Changes.md
+++ b/Changes.md
@@ -30,6 +30,12 @@
   "too complicated", using `--peer-fingerprint` makes TLS mode about as easy as
   using `--secret`.
 
+* **`replay-persist` has been removed**
+
+  This feature has been removed as it was never properly implemented for
+  server mode and generally was a niche feature. If the option is present
+  it will be ignored.
+
 ## Maintainer-visible changes
 
 - The configure-time option `--enable-debug` is no longer  available
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 5e06a63..f7818cf 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -285,9 +285,6 @@
 /* Define to 1 if you have the <sys/epoll.h> header file. */
 #cmakedefine HAVE_SYS_EPOLL_H
 
-/* Define to 1 if you have the <sys/file.h> header file. */
-#undef HAVE_SYS_FILE_H
-
 /* Define to 1 if you have the <sys/inotify.h> header file. */
 #cmakedefine HAVE_SYS_INOTIFY_H
 
diff --git a/configure.ac b/configure.ac
index 5f18798..9326c4e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -453,7 +453,7 @@
 ])
 AC_CHECK_HEADERS([ \
 	sys/time.h sys/ioctl.h sys/stat.h \
-	sys/mman.h sys/file.h sys/wait.h \
+	sys/mman.h sys/wait.h \
 	libgen.h stropts.h \
 	syslog.h pwd.h grp.h \
 	sys/sockio.h sys/uio.h \
@@ -561,8 +561,7 @@
 AC_CHECK_FUNCS([ \
 	daemon chroot getpwnam setuid nice dup dup2 \
 	syslog openlog mlockall getrlimit getgrnam setgid \
-	setgroups flock gettimeofday \
-	setsid chdir \
+	setgroups gettimeofday setsid chdir \
 	chsize ftruncate execve getpeereid basename dirname \
 	epoll_create strlcpy strsep strtok_r \
 ])
diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
index 735ee51..bbdcf7f 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -440,19 +440,6 @@
   physical IP layer. The problem is easily fixed by simply using TCP as
   the VPN transport layer.
 
---replay-persist file
-  Persist replay-protection state across sessions using ``file`` to save
-  and reload the state.
-
-  This option will keep a disk copy of the current replay protection state
-  (i.e. the most recent packet timestamp and sequence number received from
-  the remote peer), so that if an OpenVPN session is stopped and
-  restarted, it will reject any replays of packets which were already
-  received by the prior session.
-
-  This option only makes sense when replay protection is enabled (the
-  default) and you are using TLS mode with ``--tls-auth``.
-
 --session-timeout n
   Raises :code:`SIGTERM` for the client instance after ``n`` seconds since
   the beginning of the session, forcing OpenVPN to disconnect.
diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
index c4aa810..de4d324 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -370,10 +370,7 @@
   level has had a chance to authenticate the peer. The result is that
   packets without the correct signature can be dropped immediately upon
   reception, before they have a chance to consume additional system
-  resources such as by initiating a TLS handshake. ``--tls-auth`` can be
-  strengthened by adding the ``--replay-persist`` option which will keep
-  OpenVPN's replay protection state in a file so that it is not lost
-  across restarts.
+  resources such as by initiating a TLS handshake.
 
   It should be emphasized that this feature is optional and that the key
   file used with ``--tls-auth`` gives a peer nothing more than the power
diff --git a/doc/man-sections/unsupported-options.rst b/doc/man-sections/unsupported-options.rst
index 0bb5e4b..1b49beb 100644
--- a/doc/man-sections/unsupported-options.rst
+++ b/doc/man-sections/unsupported-options.rst
@@ -76,3 +76,8 @@
   (generated by DH or ECDH) has been considered problematic for many
   years. Please use ``--peer-fingerprint`` and self-signed certificates
   for small setups.
+
+--replay-persist
+  Removed OpenVPN 2.8. This option never really worked well with ``--server``
+  and the usefulness of this option in p2p setups is not very high either.
+  It is now ignored if present in the configuration file.
diff --git a/src/openvpn/check_file_access.c b/src/openvpn/check_file_access.c
index 90dbb4e..09635cb 100644
--- a/src/openvpn/check_file_access.c
+++ b/src/openvpn/check_file_access.c
@@ -312,9 +312,6 @@
                                          ce->tls_crypt_v2_file, R_OK, "--tls-crypt-v2");
     }
 
-    errs |= check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->packet_id_file,
-                              R_OK | W_OK, "--replay-persist");
-
     /* ** Password files ** */
     errs |= check_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
                               options->key_pass_file, R_OK, "--askpass");
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index d375273..9b8c7aaa 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -403,10 +403,6 @@
     if (packet_id_test(recv, pin))
     {
         packet_id_add(recv, pin);
-        if (opt->pid_persist && (opt->flags & CO_PACKET_ID_LONG_FORM))
-        {
-            packet_id_persist_save_obj(opt->pid_persist, &opt->packet_id);
-        }
         ret = true;
     }
     else
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 203f77b..4962835 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -339,11 +339,6 @@
                                  *   The packet id also used as the IV
                                  *   for AEAD/OFB/CFG ciphers.
                                  */
-    struct packet_id_persist *pid_persist;
-    /**< Persistent packet ID state for
-     *   keeping state between successive
-     *   OpenVPN process startups. */
-
 #define CO_PACKET_ID_LONG_FORM         (1u << 0)
     /**< Bit-flag indicating whether to use
      *   OpenVPN's long packet ID format. */
diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
index d79efbb..60d20ad 100644
--- a/src/openvpn/errlevel.h
+++ b/src/openvpn/errlevel.h
@@ -64,7 +64,6 @@
 #define D_MULTI_ERRORS   LOGLEV(1, 9, M_NONFATAL)   /* show multi-client server errors */
 #define D_EVENT_ERRORS   LOGLEV(1, 10, M_NONFATAL)  /* show event.[ch] errors */
 #define D_PUSH_ERRORS    LOGLEV(1, 11, M_NONFATAL)  /* show push/pull errors */
-#define D_PID_PERSIST    LOGLEV(1, 12, M_NONFATAL)  /* show packet_id persist errors */
 #define D_FRAG_ERRORS    LOGLEV(1, 13, M_NONFATAL)  /* show fragmentation errors */
 #define D_ALIGN_ERRORS   LOGLEV(1, 14, M_NONFATAL)  /* show bad struct alignments */
 
@@ -161,16 +160,15 @@
 #define D_EVENT_WAIT        LOGLEV(8, 70, M_DEBUG)      /* show detailed info from event waits */
 #define D_MULTI_TCP         LOGLEV(8, 70, M_DEBUG)      /* show debug info from mtcp.c */
 
-#define D_TLS_DEBUG         LOGLEV(9, 70, M_DEBUG)      /* show detailed info from TLS routines */
-#define D_COMP              LOGLEV(9, 70, M_DEBUG)      /* show compression info */
-#define D_READ_WRITE        LOGLEV(9, 70, M_DEBUG)      /* show all tun/tcp/udp reads/writes/opens */
-#define D_PACKET_CONTENT    LOGLEV(9, 70, M_DEBUG)      /* show before/after encryption packet content */
-#define D_TLS_NO_SEND_KEY   LOGLEV(9, 70, M_DEBUG)      /* show when no data channel send-key exists */
-#define D_PID_PERSIST_DEBUG LOGLEV(9, 70, M_DEBUG)      /* show packet-id persist debugging info */
-#define D_LINK_RW_VERBOSE   LOGLEV(9, 70, M_DEBUG)      /* increase link reads/writes verbosity */
-#define D_STREAM_DEBUG      LOGLEV(9, 70, M_DEBUG)      /* show TCP stream debug info */
-#define D_WIN32_IO          LOGLEV(9, 70, M_DEBUG)      /* win32 I/O debugging info */
-#define D_PKCS11_DEBUG      LOGLEV(9, 70, M_DEBUG)      /* show PKCS#11 debugging */
+#define D_TLS_DEBUG       LOGLEV(9, 70, M_DEBUG)        /* show detailed info from TLS routines */
+#define D_COMP            LOGLEV(9, 70, M_DEBUG)        /* show compression info */
+#define D_READ_WRITE      LOGLEV(9, 70, M_DEBUG)        /* show all tun/tcp/udp reads/writes/opens */
+#define D_PACKET_CONTENT  LOGLEV(9, 70, M_DEBUG)        /* show before/after encryption packet content */
+#define D_TLS_NO_SEND_KEY LOGLEV(9, 70, M_DEBUG)        /* show when no data channel send-key exists */
+#define D_LINK_RW_VERBOSE LOGLEV(9, 70, M_DEBUG)        /* increase link reads/writes verbosity */
+#define D_STREAM_DEBUG    LOGLEV(9, 70, M_DEBUG)        /* show TCP stream debug info */
+#define D_WIN32_IO        LOGLEV(9, 70, M_DEBUG)        /* win32 I/O debugging info */
+#define D_PKCS11_DEBUG    LOGLEV(9, 70, M_DEBUG)        /* show PKCS#11 debugging */
 
 #define D_SHAPER_DEBUG LOGLEV(10, 70, M_DEBUG)          /* show traffic shaper info */
 
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 681210d..0db0584 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -744,14 +744,6 @@
 static void
 process_coarse_timers(struct context *c)
 {
-    /* flush current packet-id to file once per 60
-     * seconds if --replay-persist was specified */
-    if (packet_id_persist_enabled(&c->c1.pid_persist)
-        && event_timeout_trigger(&c->c2.packet_id_persist_interval, &c->c2.timeval, ETT_DEFAULT))
-    {
-        packet_id_persist_save(&c->c1.pid_persist);
-    }
-
     /* Should we write timer-triggered status file */
     if (c->c1.status_output
         && event_timeout_trigger(&c->c1.status_output->et, &c->c2.timeval, ETT_DEFAULT))
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9299c4f..8c9098c 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -66,7 +66,6 @@
 /*
  * Crypto initialization flags
  */
-#define CF_LOAD_PERSISTED_PACKET_ID (1 << 0)
 #define CF_INIT_TLS_MULTI           (1 << 1)
 #define CF_INIT_TLS_AUTH_STANDALONE (1 << 2)
 
@@ -737,8 +736,6 @@
 {
     context_clear_1(c);
 
-    packet_id_persist_init(&c->c1.pid_persist);
-
     init_connection_list(c);
 
     c->c1.link_sockets_num = c->options.ce.local_list->len;
@@ -1346,12 +1343,6 @@
                                now);
         }
 
-        /* initialize packet_id persistence timer */
-        if (c->options.packet_id_file)
-        {
-            event_timeout_init(&c->c2.packet_id_persist_interval, 60, now);
-        }
-
         /* initialize tmp_int optimization that limits the number of times we call
          * tls_multi_process in the main event loop */
         interval_init(&c->c2.tmp_int, TLS_MULTI_HORIZON, TLS_MULTI_REFRESH);
@@ -2957,15 +2948,6 @@
     {
         crypto_init_lib_engine(c->options.engine);
     }
-
-    if (flags & CF_LOAD_PERSISTED_PACKET_ID)
-    {
-        /* load a persisted packet-id for cross-session replay-protection */
-        if (c->options.packet_id_file)
-        {
-            packet_id_persist_load(&c->c1.pid_persist, c->options.packet_id_file);
-        }
-    }
 }
 
 
@@ -3354,7 +3336,6 @@
     if (to.tls_wrap.mode == TLS_WRAP_AUTH || to.tls_wrap.mode == TLS_WRAP_CRYPT)
     {
         to.tls_wrap.opt.key_ctx_bi = c->c1.ks.tls_wrap_key;
-        to.tls_wrap.opt.pid_persist = &c->c1.pid_persist;
         to.tls_wrap.opt.flags |= CO_PACKET_ID_LONG_FORM;
         to.tls_wrap.original_wrap_keydata = c->c1.ks.original_wrap_keydata;
     }
@@ -3913,11 +3894,6 @@
 do_close_packet_id(struct context *c)
 {
     packet_id_free(&c->c2.crypto_options.packet_id);
-    packet_id_persist_save(&c->c1.pid_persist);
-    if (!(c->sig->signal_received == SIGUSR1))
-    {
-        packet_id_persist_close(&c->c1.pid_persist);
-    }
 }
 
 #ifdef ENABLE_FRAGMENT
@@ -4453,7 +4429,7 @@
         }
         else if (c->mode == CM_P2P)
         {
-            crypto_flags = CF_LOAD_PERSISTED_PACKET_ID | CF_INIT_TLS_MULTI;
+            crypto_flags = CF_INIT_TLS_MULTI;
         }
         else if (child)
         {
@@ -4711,7 +4687,6 @@
     ALLOC_OBJ_CLEAR_GC(dest->sig, struct signal_info, &dest->gc);
 
     /* c1 init */
-    packet_id_persist_init(&dest->c1.pid_persist);
     dest->c1.link_sockets_num = 1;
     do_link_socket_addr_new(dest);
 
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index cdd02b6..52f298b 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -75,21 +75,6 @@
 };
 
 /*
- * struct packet_id_persist should be empty if we are not
- * building with crypto.
- */
-#ifndef PACKET_ID_H
-struct packet_id_persist
-{
-    int dummy;
-};
-static inline void
-packet_id_persist_init(struct packet_id_persist *p)
-{
-}
-#endif
-
-/*
  * Packet processing buffers.
  */
 struct context_buffers
@@ -167,9 +152,6 @@
     /* preresolved and cached host names */
     struct cached_dns_entry *dns_cache;
 
-    /* persist crypto sequence number to/from file */
-    struct packet_id_persist pid_persist;
-
     struct tuntap *tuntap; /**< Tun/tap virtual network interface. */
     bool tuntap_owned;     /**< Whether the tun/tap interface should
                             *   be cleaned up when this %context is
@@ -352,8 +334,6 @@
      *   Channel Crypto module\endlink to
      *   process data channel packet. */
 
-    struct event_timeout packet_id_persist_interval;
-
 #ifdef USE_COMP
     struct compress_context *comp_context;
     /**< Compression context used by the
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4e6c705..ebfa8b9 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -573,8 +573,6 @@
     "--replay-window n [t]  : Use a replay protection sliding window of size n\n"
     "                         and a time window of t seconds.\n"
     "                         Default n=%d t=%d\n"
-    "--replay-persist file : Persist replay-protection state across sessions\n"
-    "                  using file.\n"
     "--test-crypto   : Run a self-test of crypto features enabled.\n"
     "                  For debugging only.\n"
     "\n"
@@ -7048,7 +7046,7 @@
     else if (streq(p[0], "replay-persist") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->packet_id_file = p[1];
+        msg(M_WARN, "DEPRECATED OPTION: --replay-persist option ignored.");
     }
     else if (streq(p[0], "test-crypto") && !p[1])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 129267f..dd8b75a 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -582,7 +582,6 @@
     bool mute_replay_warnings;
     int replay_window;
     int replay_time;
-    const char *packet_id_file;
     bool test_crypto;
 
     /* TLS (control channel) parms */
diff --git a/src/openvpn/options_show.c b/src/openvpn/options_show.c
index 321a37b..54f9c4c 100644
--- a/src/openvpn/options_show.c
+++ b/src/openvpn/options_show.c
@@ -501,7 +501,6 @@
     SHOW_BOOL(mute_replay_warnings);
     SHOW_INT(replay_window);
     SHOW_INT(replay_time);
-    SHOW_STR(packet_id_file);
     SHOW_BOOL(test_crypto);
 
     SHOW_BOOL(tls_server);
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index 9dd6ce3..f1fadd6 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -426,146 +426,6 @@
     return BSTR(&out);
 }
 
-/* initialize the packet_id_persist structure in a disabled state */
-void
-packet_id_persist_init(struct packet_id_persist *p)
-{
-    p->filename = NULL;
-    p->fd = -1;
-    p->time = p->time_last_written = 0;
-    p->id = p->id_last_written = 0;
-}
-
-/* close the file descriptor if it is open, and switch to disabled state */
-void
-packet_id_persist_close(struct packet_id_persist *p)
-{
-    if (packet_id_persist_enabled(p))
-    {
-        if (close(p->fd))
-        {
-            msg(D_PID_PERSIST | M_ERRNO, "Close error on --replay-persist file %s", p->filename);
-        }
-        packet_id_persist_init(p);
-    }
-}
-
-/* load persisted rec packet_id (time and id) only once from file, and set state to enabled */
-void
-packet_id_persist_load(struct packet_id_persist *p, const char *filename)
-{
-    struct gc_arena gc = gc_new();
-    if (!packet_id_persist_enabled(p))
-    {
-        /* open packet-id persist file for both read and write */
-        p->fd = platform_open(filename, O_CREAT | O_RDWR | O_BINARY, S_IRUSR | S_IWUSR);
-        if (p->fd == -1)
-        {
-            msg(D_PID_PERSIST | M_ERRNO, "Cannot open --replay-persist file %s for read/write",
-                filename);
-        }
-        else
-        {
-            struct packet_id_persist_file_image image;
-            ssize_t n;
-
-#if defined(HAVE_FLOCK) && defined(LOCK_EX) && defined(LOCK_NB)
-            if (flock(p->fd, LOCK_EX | LOCK_NB))
-            {
-                msg(M_ERR, "Cannot obtain exclusive lock on --replay-persist file %s", filename);
-            }
-#endif
-
-            p->filename = filename;
-            n = read(p->fd, &image, sizeof(image));
-            if (n == sizeof(image))
-            {
-                p->time = p->time_last_written = image.time;
-                p->id = p->id_last_written = image.id;
-                dmsg(D_PID_PERSIST_DEBUG, "PID Persist Read from %s: %s", p->filename,
-                     packet_id_persist_print(p, &gc));
-            }
-            else if (n == -1)
-            {
-                msg(D_PID_PERSIST | M_ERRNO, "Read error on --replay-persist file %s", p->filename);
-            }
-        }
-    }
-    gc_free(&gc);
-}
-
-/* save persisted rec packet_id (time and id) to file (only if enabled state) */
-void
-packet_id_persist_save(struct packet_id_persist *p)
-{
-    if (packet_id_persist_enabled(p) && p->time
-        && (p->time != p->time_last_written || p->id != p->id_last_written))
-    {
-        struct packet_id_persist_file_image image;
-        CLEAR(image);
-        off_t seek_ret;
-        struct gc_arena gc = gc_new();
-
-        image.time = p->time;
-        image.id = p->id;
-        seek_ret = lseek(p->fd, (off_t)0, SEEK_SET);
-        if (seek_ret == (off_t)0)
-        {
-            const ssize_t n = write(p->fd, &image, sizeof(image));
-            if (n == sizeof(image))
-            {
-                p->time_last_written = p->time;
-                p->id_last_written = p->id;
-                dmsg(D_PID_PERSIST_DEBUG, "PID Persist Write to %s: %s", p->filename,
-                     packet_id_persist_print(p, &gc));
-            }
-            else
-            {
-                msg(D_PID_PERSIST | M_ERRNO, "Cannot write to --replay-persist file %s",
-                    p->filename);
-            }
-        }
-        else
-        {
-            msg(D_PID_PERSIST | M_ERRNO, "Cannot seek to beginning of --replay-persist file %s",
-                p->filename);
-        }
-        gc_free(&gc);
-    }
-}
-
-/* transfer packet_id_persist -> packet_id */
-void
-packet_id_persist_load_obj(const struct packet_id_persist *p, struct packet_id *pid)
-{
-    if (p && pid && packet_id_persist_enabled(p) && p->time)
-    {
-        pid->rec.time = p->time;
-        pid->rec.id = p->id;
-    }
-}
-
-const char *
-packet_id_persist_print(const struct packet_id_persist *p, struct gc_arena *gc)
-{
-    struct buffer out = alloc_buf_gc(256, gc);
-
-    buf_printf(&out, "[");
-
-    if (packet_id_persist_enabled(p))
-    {
-        buf_printf(&out, " #" packet_id_format, (packet_id_print_type)p->id);
-        if (p->time)
-        {
-            buf_printf(&out, " / time = (" packet_id_format ") %s", (packet_id_print_type)p->time,
-                       time_string(p->time, 0, false, gc));
-        }
-    }
-
-    buf_printf(&out, " ]");
-    return (char *)out.data;
-}
-
 #ifndef ENABLE_SMALL
 
 static void
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index 48752d3..c374ccb 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -125,26 +125,6 @@
 };
 
 /*
- * file to facilitate cross-session persistence
- * of time/id
- */
-struct packet_id_persist
-{
-    const char *filename;
-    int fd;
-    time_t time;       /* time stamp */
-    packet_id_type id; /* sequence number */
-    time_t time_last_written;
-    packet_id_type id_last_written;
-};
-
-struct packet_id_persist_file_image
-{
-    time_t time;       /* time stamp */
-    packet_id_type id; /* sequence number */
-};
-
-/*
  * Keep a record of our current packet-id state
  * on the sending side.
  */
@@ -222,28 +202,6 @@
 void packet_id_reap(struct packet_id_rec *p);
 
 /*
- * packet ID persistence
- */
-
-/* initialize the packet_id_persist structure in a disabled state */
-void packet_id_persist_init(struct packet_id_persist *p);
-
-/* close the file descriptor if it is open, and switch to disabled state */
-void packet_id_persist_close(struct packet_id_persist *p);
-
-/* load persisted rec packet_id (time and id) only once from file, and set state to enabled */
-void packet_id_persist_load(struct packet_id_persist *p, const char *filename);
-
-/* save persisted rec packet_id (time and id) to file (only if enabled state) */
-void packet_id_persist_save(struct packet_id_persist *p);
-
-/* transfer packet_id_persist -> packet_id */
-void packet_id_persist_load_obj(const struct packet_id_persist *p, struct packet_id *pid);
-
-/* return an ascii string representing a packet_id_persist object */
-const char *packet_id_persist_print(const struct packet_id_persist *p, struct gc_arena *gc);
-
-/*
  * Read/write a packet ID to/from the buffer.  Short form is sequence number
  * only.  Long form is sequence number and timestamp.
  */
@@ -273,27 +231,6 @@
     return pid->rec.initialized;
 }
 
-/* are we in enabled state? */
-static inline bool
-packet_id_persist_enabled(const struct packet_id_persist *p)
-{
-    return p->fd >= 0;
-}
-
-/* transfer packet_id -> packet_id_persist
-   Note: Only supported for non-epoch format (i.e. 32bit ID, not 64bit format),
-   must be enforced at the caller.
- */
-static inline void
-packet_id_persist_save_obj(struct packet_id_persist *p, const struct packet_id *pid)
-{
-    if (packet_id_persist_enabled(p) && pid->rec.time && pid->rec.id <= PACKET_ID_MAX)
-    {
-        p->time = pid->rec.time;
-        p->id = (packet_id_type)pid->rec.id;
-    }
-}
-
 /**
  * Reset the current send packet id to its initial state.
  * Use very carefully (e.g. in the standalone reset packet context) to
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 55043e5..67df7c2 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -878,8 +878,6 @@
     packet_id_init(&ks->crypto_options.packet_id, session->opt->replay_window,
                    session->opt->replay_time, "SSL", ks->key_id);
 
-    ks->crypto_options.pid_persist = NULL;
-
 #ifdef ENABLE_MANAGEMENT
     ks->mda_key_id = session->opt->mda_context->mda_key_id_counter++;
 #endif
@@ -1037,9 +1035,6 @@
         session->tls_wrap.opt.packet_id.send.id = EARLY_NEG_START;
     }
 
-    /* load most recent packet-id to replay protect on --tls-auth */
-    packet_id_persist_load_obj(session->tls_wrap.opt.pid_persist, &session->tls_wrap.opt.packet_id);
-
     key_state_init(session, &session->key[KS_PRIMARY]);
 
     dmsg(D_TLS_DEBUG, "TLS: tls_session_init: new session object, sid=%s",
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 1d6cdc2..65baee3 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -127,10 +127,6 @@
 #include <fcntl.h>
 #endif
 
-#ifdef HAVE_SYS_FILE_H
-#include <sys/file.h>
-#endif
-
 /* These headers belong to C99 and should be always be present */
 #include <stdlib.h>
 #include <inttypes.h>
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 23c7975..e7fb865 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -109,7 +109,6 @@
     session->tls_wrap_reneg.mode = TLS_WRAP_CRYPT;
     session->tls_wrap_reneg.cleanup_key_ctx = true;
     session->tls_wrap_reneg.work = alloc_buf(BUF_SIZE(&session->opt->frame));
-    session->tls_wrap_reneg.opt.pid_persist = NULL;
 
     packet_id_init(&session->tls_wrap_reneg.opt.packet_id, session->opt->replay_window,
                    session->opt->replay_time, "TLS_WRAP_RENEG", session->key_id);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
