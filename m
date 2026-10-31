Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D69E606A31D
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RdyPuIj4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Q1UXeh0y;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VSE9BW2q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Qs56C5HPQNVA27UdEnaSl4EXNyVD51i0I9IzEQAwcc8=; b=RdyPuIj4IYfhoA
	TdNQtaHS5eTaJ1PS6GQsD/8P6T3GH4+0nSt7Qc0iTNp3qxHIpJ15aK0dF7Eh1pz+kLY6rJQHHTpwe
	hrM4nvIVqGr7kqb2ePW8/nrpJ4CtYaum1RKUMNkfZ5m09gFu88+MYyBTs58Q9rE+4hjSm1QLaoRYc
	4wc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNES7-000000000c3-2Uju;
	Sat, 31 Oct 2026 19:09:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xNES5-000000000bN-1szD for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 19:09:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zs88Rg1FIhbkyyzClQOnuEVkkt3of2+p5NNm2/cOw7E=; b=Q1UXeh0y78EGHfd4ssr+l92nrQ
 svAV9/NMXFOlpP3gnm830sHkddTL8u3lGiIjUGw6cMohkIiDpH7Ssr7z9eIaSXApHWWQwhrYZjAmC
 Xn00mMSGQkF/r61ilphzN3UpTqTOGlYgPrgUWzGd78r6MrlH+yeqtbFHR0pnEq4sfPuQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zs88Rg1FIhbkyyzClQOnuEVkkt3of2+p5NNm2/cOw7E=; b=VSE9BW2qM71dsiqRxiNEq55LQF
 tMmu4+cizT7P+zL2b0SmnKVKTTiiI3kxk6M40DjhfTZKH+IcXTxPd7iwTB08XiIMqfwFJLGf738Z1
 UO3bbEZg5wd+Xf36voFlgumyH52ZT2DE/M+09xJbWLNPFsUTk+DtIH57ix6XHYp+Zu98=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNERb-000000001M9-1nlP for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 19:08:49 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69VJ8e5M030049
 for <openvpn-devel@lists.sourceforge.net>; Sat, 31 Oct 2026 20:08:40 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69VJ8eq9030048
 for openvpn-devel@lists.sourceforge.net; Sat, 31 Oct 2026 20:08:40 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 31 Oct 2026 20:08:34 +0100
Message-ID: <20261031190839.30023-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793294136000.I61a0d15962584bc48cae459062fead08dc425aeb@gerrit.openvpn.net>
References: <gerrit.1793294136000.I61a0d15962584bc48cae459062fead08dc425aeb@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xNERb-000000001M9-1nlP
Subject: [Openvpn-devel] [PATCH v1] Remove PACKET_TRUNCATION_CHECK
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

This functionality checks if packets might be truncated by checking
the length of the IPv4 header against the length of the buffer to
see if a packet is truncated.

This function has been undocumented and can be only enabled by
manually defining this define.

This might have been useful in 2005 when this function was added
but currently is rather dead code that can a diagnose a problem
that is extremely rare or has been already been fixed outside of
OpenVPN.

Change-Id: I61a0d15962584bc48cae459062fead08dc425aeb
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2071
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2071
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
index d79efbb..e52cb65 100644
--- a/src/openvpn/errlevel.h
+++ b/src/openvpn/errlevel.h
@@ -49,105 +49,103 @@
  * of output.
  */
 
-#define M_VERB0 LOGLEV(0, 0, 0)                     /* Messages displayed even at --verb 0 (fatal errors only) */
+#define M_VERB0 LOGLEV(0, 0, 0)                    /* Messages displayed even at --verb 0 (fatal errors only) */
 
-#define M_INFO LOGLEV(1, 0, 0)                      /* default informational messages */
+#define M_INFO LOGLEV(1, 0, 0)                     /* default informational messages */
 
-#define D_LINK_ERRORS    LOGLEV(1, 1, M_NONFATAL)   /* show link errors from main event loop */
-#define D_CRYPT_ERRORS   LOGLEV(1, 2, M_NONFATAL)   /* show errors from encrypt/decrypt */
-#define D_TLS_ERRORS     LOGLEV(1, 3, M_NONFATAL)   /* show TLS control channel errors */
-#define D_RESOLVE_ERRORS LOGLEV(1, 4, M_NONFATAL)   /* show hostname resolve errors */
-#define D_COMP_ERRORS    LOGLEV(1, 5, M_NONFATAL)   /* show compression errors */
-#define D_REPLAY_ERRORS  LOGLEV(1, 6, M_NONFATAL)   /* show packet replay errors */
-#define D_STREAM_ERRORS  LOGLEV(1, 7, M_NONFATAL)   /* TCP stream error requiring restart */
-#define D_IMPORT_ERRORS  LOGLEV(1, 8, M_NONFATAL)   /* show server import option errors */
-#define D_MULTI_ERRORS   LOGLEV(1, 9, M_NONFATAL)   /* show multi-client server errors */
-#define D_EVENT_ERRORS   LOGLEV(1, 10, M_NONFATAL)  /* show event.[ch] errors */
-#define D_PUSH_ERRORS    LOGLEV(1, 11, M_NONFATAL)  /* show push/pull errors */
-#define D_PID_PERSIST    LOGLEV(1, 12, M_NONFATAL)  /* show packet_id persist errors */
-#define D_FRAG_ERRORS    LOGLEV(1, 13, M_NONFATAL)  /* show fragmentation errors */
-#define D_ALIGN_ERRORS   LOGLEV(1, 14, M_NONFATAL)  /* show bad struct alignments */
+#define D_LINK_ERRORS    LOGLEV(1, 1, M_NONFATAL)  /* show link errors from main event loop */
+#define D_CRYPT_ERRORS   LOGLEV(1, 2, M_NONFATAL)  /* show errors from encrypt/decrypt */
+#define D_TLS_ERRORS     LOGLEV(1, 3, M_NONFATAL)  /* show TLS control channel errors */
+#define D_RESOLVE_ERRORS LOGLEV(1, 4, M_NONFATAL)  /* show hostname resolve errors */
+#define D_COMP_ERRORS    LOGLEV(1, 5, M_NONFATAL)  /* show compression errors */
+#define D_REPLAY_ERRORS  LOGLEV(1, 6, M_NONFATAL)  /* show packet replay errors */
+#define D_STREAM_ERRORS  LOGLEV(1, 7, M_NONFATAL)  /* TCP stream error requiring restart */
+#define D_IMPORT_ERRORS  LOGLEV(1, 8, M_NONFATAL)  /* show server import option errors */
+#define D_MULTI_ERRORS   LOGLEV(1, 9, M_NONFATAL)  /* show multi-client server errors */
+#define D_EVENT_ERRORS   LOGLEV(1, 10, M_NONFATAL) /* show event.[ch] errors */
+#define D_PUSH_ERRORS    LOGLEV(1, 11, M_NONFATAL) /* show push/pull errors */
+#define D_PID_PERSIST    LOGLEV(1, 12, M_NONFATAL) /* show packet_id persist errors */
+#define D_FRAG_ERRORS    LOGLEV(1, 13, M_NONFATAL) /* show fragmentation errors */
+#define D_ALIGN_ERRORS   LOGLEV(1, 14, M_NONFATAL) /* show bad struct alignments */
 
-#define D_HANDSHAKE LOGLEV(2, 20, 0)                /* show data & control channel handshakes */
-#define D_CLOSE     LOGLEV(2, 22, 0)                /* show socket and TUN/TAP close */
-#define D_PROXY     LOGLEV(2, 24, 0)                /* show http proxy control packets */
-#define D_ARGV      LOGLEV(2, 25, 0)                /* show struct argv errors */
+#define D_HANDSHAKE LOGLEV(2, 20, 0)               /* show data & control channel handshakes */
+#define D_CLOSE     LOGLEV(2, 22, 0)               /* show socket and TUN/TAP close */
+#define D_PROXY     LOGLEV(2, 24, 0)               /* show http proxy control packets */
+#define D_ARGV      LOGLEV(2, 25, 0)               /* show struct argv errors */
 
-#define D_TLS_DEBUG_LOW LOGLEV(3, 20, 0)            /* low frequency info from tls_session routines */
-#define D_GREMLIN       LOGLEV(3, 30, 0)            /* show simulated outage info from gremlin module */
-#define D_GENKEY        LOGLEV(3, 31, 0)            /* print message after key generation */
-#define D_ROUTE         LOGLEV(3, 0, 0)             /* show routes added and deleted (don't mute) */
-#define D_TUNTAP_INFO   LOGLEV(3, 32, 0)            /* show debugging info from TUN/TAP driver */
-#define D_RESTART       LOGLEV(3, 33, 0)            /* show certain restart messages */
-#define D_PUSH          LOGLEV(3, 34, 0)            /* show push/pull info */
-#define D_IFCONFIG_POOL LOGLEV(3, 35, 0)            /* show ifconfig pool info */
-#define D_AUTH          LOGLEV(3, 37, 0)            /* show user/pass auth info */
-#define D_MULTI_LOW     LOGLEV(3, 38, 0)            /* show point-to-multipoint low-freq debug info */
-#define D_PLUGIN        LOGLEV(3, 39, 0)            /* show plugin calls */
-#define D_MANAGEMENT    LOGLEV(3, 40, 0)            /* show --management info */
-#define D_SCHED_EXIT    LOGLEV(3, 41, 0)            /* show arming of scheduled exit */
-#define D_ROUTE_QUOTA   LOGLEV(3, 42, 0)            /* show route quota exceeded messages */
-#define D_OSBUF         LOGLEV(3, 43, 0)            /* show socket/tun/tap buffer sizes */
-#define D_PS_PROXY      LOGLEV(3, 44, 0)            /* messages related to --port-share option */
-#define D_IFCONFIG      LOGLEV(3, 0, 0)             /* show ifconfig info (don't mute) */
-#define D_DCO           LOGLEV(3, 0, 0)             /* show DCO related messages */
+#define D_TLS_DEBUG_LOW LOGLEV(3, 20, 0)           /* low frequency info from tls_session routines */
+#define D_GREMLIN       LOGLEV(3, 30, 0)           /* show simulated outage info from gremlin module */
+#define D_GENKEY        LOGLEV(3, 31, 0)           /* print message after key generation */
+#define D_ROUTE         LOGLEV(3, 0, 0)            /* show routes added and deleted (don't mute) */
+#define D_TUNTAP_INFO   LOGLEV(3, 32, 0)           /* show debugging info from TUN/TAP driver */
+#define D_RESTART       LOGLEV(3, 33, 0)           /* show certain restart messages */
+#define D_PUSH          LOGLEV(3, 34, 0)           /* show push/pull info */
+#define D_IFCONFIG_POOL LOGLEV(3, 35, 0)           /* show ifconfig pool info */
+#define D_AUTH          LOGLEV(3, 37, 0)           /* show user/pass auth info */
+#define D_MULTI_LOW     LOGLEV(3, 38, 0)           /* show point-to-multipoint low-freq debug info */
+#define D_PLUGIN        LOGLEV(3, 39, 0)           /* show plugin calls */
+#define D_MANAGEMENT    LOGLEV(3, 40, 0)           /* show --management info */
+#define D_SCHED_EXIT    LOGLEV(3, 41, 0)           /* show arming of scheduled exit */
+#define D_ROUTE_QUOTA   LOGLEV(3, 42, 0)           /* show route quota exceeded messages */
+#define D_OSBUF         LOGLEV(3, 43, 0)           /* show socket/tun/tap buffer sizes */
+#define D_PS_PROXY      LOGLEV(3, 44, 0)           /* messages related to --port-share option */
+#define D_IFCONFIG      LOGLEV(3, 0, 0)            /* show ifconfig info (don't mute) */
+#define D_DCO           LOGLEV(3, 0, 0)            /* show DCO related messages */
 
-#define D_SHOW_PARMS       LOGLEV(4, 50, 0)         /* show all parameters on program initiation */
-#define D_LOW              LOGLEV(4, 52, 0)         /* miscellaneous low-frequency debug info */
-#define D_DHCP_OPT         LOGLEV(4, 53, 0)         /* show DHCP options binary string */
-#define D_MBUF             LOGLEV(4, 54, 0)         /* mbuf.[ch] routines */
-#define D_PACKET_TRUNC_ERR LOGLEV(4, 55, 0)         /* PACKET_TRUNCATION_CHECK */
-#define D_MULTI_DROPPED    LOGLEV(4, 57, 0)         /* show point-to-multipoint packet drops */
-#define D_MULTI_MEDIUM     LOGLEV(4, 58, 0)         /* show medium frequency multi messages */
-#define D_X509_ATTR        LOGLEV(4, 59, 0)         /* show x509-track attributes on connection */
-#define D_INIT_MEDIUM      LOGLEV(4, 60, 0)         /* show medium frequency init messages */
-#define D_MTU_INFO         LOGLEV(4, 61, 0)         /* show terse MTU info */
-#define D_PID_DEBUG_LOW    LOGLEV(4, 63, 0)         /* show low-freq packet-id debugging info */
-#define D_PID_DEBUG_MEDIUM LOGLEV(4, 64, 0)         /* show medium-freq packet-id debugging info */
-#define D_CIPHER_INIT      LOGLEV(4, 65, 0)         /* show messages about cipher init */
+#define D_SHOW_PARMS       LOGLEV(4, 50, 0)        /* show all parameters on program initiation */
+#define D_LOW              LOGLEV(4, 52, 0)        /* miscellaneous low-frequency debug info */
+#define D_DHCP_OPT         LOGLEV(4, 53, 0)        /* show DHCP options binary string */
+#define D_MBUF             LOGLEV(4, 54, 0)        /* mbuf.[ch] routines */
+#define D_MULTI_DROPPED    LOGLEV(4, 57, 0)        /* show point-to-multipoint packet drops */
+#define D_MULTI_MEDIUM     LOGLEV(4, 58, 0)        /* show medium frequency multi messages */
+#define D_X509_ATTR        LOGLEV(4, 59, 0)        /* show x509-track attributes on connection */
+#define D_INIT_MEDIUM      LOGLEV(4, 60, 0)        /* show medium frequency init messages */
+#define D_MTU_INFO         LOGLEV(4, 61, 0)        /* show terse MTU info */
+#define D_PID_DEBUG_LOW    LOGLEV(4, 63, 0)        /* show low-freq packet-id debugging info */
+#define D_PID_DEBUG_MEDIUM LOGLEV(4, 64, 0)        /* show medium-freq packet-id debugging info */
+#define D_CIPHER_INIT      LOGLEV(4, 65, 0)        /* show messages about cipher init */
 
-#define D_LOG_RW LOGLEV(5, 0, 0)                    /* Print 'R' or 'W' to stdout for read/write */
+#define D_LOG_RW LOGLEV(5, 0, 0)                   /* Print 'R' or 'W' to stdout for read/write */
 
-#define D_RTNL          LOGLEV(6, 68, M_DEBUG)      /* show RTNL low level operations */
-#define D_LINK_RW       LOGLEV(6, 69, M_DEBUG)      /* show TCP/UDP reads/writes (terse) */
-#define D_TUN_RW        LOGLEV(6, 69, M_DEBUG)      /* show TUN/TAP reads/writes */
-#define D_TAP_WIN_DEBUG LOGLEV(6, 69, M_DEBUG)      /* show TAP-Windows driver debug info */
-#define D_CLIENT_NAT    LOGLEV(6, 69, M_DEBUG)      /* show client NAT debug info */
-#define D_XKEY          LOGLEV(6, 69, M_DEBUG)      /* show xkey-provider debug info */
-#define D_DCO_DEBUG     LOGLEV(6, 69, M_DEBUG)      /* show DCO related lowlevel debug messages */
-#define D_SIGNAL_DEBUG  LOGLEV(6, 69, M_DEBUG)      /* show signal related debug messages */
+#define D_RTNL          LOGLEV(6, 68, M_DEBUG)     /* show RTNL low level operations */
+#define D_LINK_RW       LOGLEV(6, 69, M_DEBUG)     /* show TCP/UDP reads/writes (terse) */
+#define D_TUN_RW        LOGLEV(6, 69, M_DEBUG)     /* show TUN/TAP reads/writes */
+#define D_TAP_WIN_DEBUG LOGLEV(6, 69, M_DEBUG)     /* show TAP-Windows driver debug info */
+#define D_CLIENT_NAT    LOGLEV(6, 69, M_DEBUG)     /* show client NAT debug info */
+#define D_XKEY          LOGLEV(6, 69, M_DEBUG)     /* show xkey-provider debug info */
+#define D_DCO_DEBUG     LOGLEV(6, 69, M_DEBUG)     /* show DCO related lowlevel debug messages */
+#define D_SIGNAL_DEBUG  LOGLEV(6, 69, M_DEBUG)     /* show signal related debug messages */
 
-#define D_SHOW_KEYS          LOGLEV(7, 70, M_DEBUG) /* show data channel encryption keys */
-#define D_SHOW_KEY_SOURCE    LOGLEV(7, 70, M_DEBUG) /* show data channel key source entropy */
-#define D_REL_LOW            LOGLEV(7, 70, M_DEBUG) /* show low frequency info from reliable layer */
-#define D_FRAG_DEBUG         LOGLEV(7, 70, M_DEBUG) /* show fragment debugging info */
-#define D_WIN32_IO_LOW       LOGLEV(7, 70, M_DEBUG) /* low freq win32 I/O debugging info */
-#define D_MTU_DEBUG          LOGLEV(7, 70, M_DEBUG) /* show MTU debugging info */
-#define D_MULTI_DEBUG        LOGLEV(7, 70, M_DEBUG) /* show medium-freq multi debugging info */
-#define D_MSS                LOGLEV(7, 70, M_DEBUG) /* show MSS adjustments */
-#define D_COMP_LOW           LOGLEV(7, 70, M_DEBUG) /* show adaptive compression state changes */
-#define D_CONNECTION_LIST    LOGLEV(7, 70, M_DEBUG) /* show <connection> list info */
-#define D_SCRIPT             LOGLEV(7, 70, M_DEBUG) /* show parms & env vars passed to scripts */
-#define D_SHOW_NET           LOGLEV(7, 70, M_DEBUG) /* show routing table and adapter list */
-#define D_ROUTE_DEBUG        LOGLEV(7, 70, M_DEBUG) /* show verbose route.[ch] output */
-#define D_TLS_STATE_ERRORS   LOGLEV(7, 70, M_DEBUG) /* no TLS state for client */
-#define D_SEMAPHORE_LOW      LOGLEV(7, 70, M_DEBUG) /* show Win32 semaphore waits (low freq) */
-#define D_SEMAPHORE          LOGLEV(7, 70, M_DEBUG) /* show Win32 semaphore waits */
-#define D_TEST_FILE          LOGLEV(7, 70, M_DEBUG) /* show test_file() calls */
-#define D_MANAGEMENT_DEBUG   LOGLEV(3, 70, M_DEBUG) /* show --management debug info */
-#define D_PLUGIN_DEBUG       LOGLEV(7, 70, M_DEBUG) /* show verbose plugin calls */
-#define D_SOCKET_DEBUG       LOGLEV(7, 70, M_DEBUG) /* show socket.[ch] debugging info */
-#define D_SHOW_PKCS11        LOGLEV(7, 70, M_DEBUG) /* show PKCS#11 actions */
-#define D_ALIGN_DEBUG        LOGLEV(7, 70, M_DEBUG) /* show verbose struct alignment info */
-#define D_PACKET_TRUNC_DEBUG LOGLEV(7, 70, M_DEBUG) /* PACKET_TRUNCATION_CHECK verbose */
-#define D_PING               LOGLEV(7, 70, M_DEBUG) /* PING send/receive messages */
-#define D_PS_PROXY_DEBUG     LOGLEV(7, 70, M_DEBUG) /* port share proxy debug */
-#define D_TLS_KEYSELECT      LOGLEV(7, 70, M_DEBUG) /* show key selection for data channel */
-#define D_ARGV_PARSE_CMD     LOGLEV(7, 70, M_DEBUG) /* show parse_line() errors in argv_parse_cmd */
-#define D_CRYPTO_DEBUG       LOGLEV(7, 70, M_DEBUG) /* show detailed info from crypto.c routines */
-#define D_PID_DEBUG          LOGLEV(7, 70, M_DEBUG) /* show packet-id debugging info */
-#define D_PUSH_DEBUG         LOGLEV(7, 73, M_DEBUG) /* show push/pull debugging info */
-#define D_SHOW_OCC           LOGLEV(7, 74, M_DEBUG) /* show options compatibility string */
+#define D_SHOW_KEYS        LOGLEV(7, 70, M_DEBUG)  /* show data channel encryption keys */
+#define D_SHOW_KEY_SOURCE  LOGLEV(7, 70, M_DEBUG)  /* show data channel key source entropy */
+#define D_REL_LOW          LOGLEV(7, 70, M_DEBUG)  /* show low frequency info from reliable layer */
+#define D_FRAG_DEBUG       LOGLEV(7, 70, M_DEBUG)  /* show fragment debugging info */
+#define D_WIN32_IO_LOW     LOGLEV(7, 70, M_DEBUG)  /* low freq win32 I/O debugging info */
+#define D_MTU_DEBUG        LOGLEV(7, 70, M_DEBUG)  /* show MTU debugging info */
+#define D_MULTI_DEBUG      LOGLEV(7, 70, M_DEBUG)  /* show medium-freq multi debugging info */
+#define D_MSS              LOGLEV(7, 70, M_DEBUG)  /* show MSS adjustments */
+#define D_COMP_LOW         LOGLEV(7, 70, M_DEBUG)  /* show adaptive compression state changes */
+#define D_CONNECTION_LIST  LOGLEV(7, 70, M_DEBUG)  /* show <connection> list info */
+#define D_SCRIPT           LOGLEV(7, 70, M_DEBUG)  /* show parms & env vars passed to scripts */
+#define D_SHOW_NET         LOGLEV(7, 70, M_DEBUG)  /* show routing table and adapter list */
+#define D_ROUTE_DEBUG      LOGLEV(7, 70, M_DEBUG)  /* show verbose route.[ch] output */
+#define D_TLS_STATE_ERRORS LOGLEV(7, 70, M_DEBUG)  /* no TLS state for client */
+#define D_SEMAPHORE_LOW    LOGLEV(7, 70, M_DEBUG)  /* show Win32 semaphore waits (low freq) */
+#define D_SEMAPHORE        LOGLEV(7, 70, M_DEBUG)  /* show Win32 semaphore waits */
+#define D_TEST_FILE        LOGLEV(7, 70, M_DEBUG)  /* show test_file() calls */
+#define D_MANAGEMENT_DEBUG LOGLEV(3, 70, M_DEBUG)  /* show --management debug info */
+#define D_PLUGIN_DEBUG     LOGLEV(7, 70, M_DEBUG)  /* show verbose plugin calls */
+#define D_SOCKET_DEBUG     LOGLEV(7, 70, M_DEBUG)  /* show socket.[ch] debugging info */
+#define D_SHOW_PKCS11      LOGLEV(7, 70, M_DEBUG)  /* show PKCS#11 actions */
+#define D_ALIGN_DEBUG      LOGLEV(7, 70, M_DEBUG)  /* show verbose struct alignment info */
+#define D_PING             LOGLEV(7, 70, M_DEBUG)  /* PING send/receive messages */
+#define D_PS_PROXY_DEBUG   LOGLEV(7, 70, M_DEBUG)  /* port share proxy debug */
+#define D_TLS_KEYSELECT    LOGLEV(7, 70, M_DEBUG)  /* show key selection for data channel */
+#define D_ARGV_PARSE_CMD   LOGLEV(7, 70, M_DEBUG)  /* show parse_line() errors in argv_parse_cmd */
+#define D_CRYPTO_DEBUG     LOGLEV(7, 70, M_DEBUG)  /* show detailed info from crypto.c routines */
+#define D_PID_DEBUG        LOGLEV(7, 70, M_DEBUG)  /* show packet-id debugging info */
+#define D_PUSH_DEBUG       LOGLEV(7, 73, M_DEBUG)  /* show push/pull debugging info */
+#define D_SHOW_OCC         LOGLEV(7, 74, M_DEBUG)  /* show options compatibility string */
 
 
 #define D_VLAN_DEBUG LOGLEV(7, 74, M_DEBUG)             /* show VLAN tagging/untagging debug info */
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 681210d..d012b51f 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1159,12 +1159,6 @@
         }
 #endif
 
-#ifdef PACKET_TRUNCATION_CHECK
-        /* if (c->c2.buf.len > 1) --c->c2.buf.len; */
-        ipv4_packet_size_verify(BPTR(&c->c2.buf), BLEN(&c->c2.buf), TUNNEL_TYPE(c->c1.tuntap),
-                                "POST_DECRYPT", &c->c2.n_trunc_post_decrypt);
-#endif
-
         /*
          * Set our "official" outgoing address, since
          * if buf.len is non-zero, we know the packet
@@ -1347,11 +1341,6 @@
     }
 #endif /* ifdef _WIN32 */
 
-#ifdef PACKET_TRUNCATION_CHECK
-    ipv4_packet_size_verify(BPTR(&c->c2.buf), BLEN(&c->c2.buf), TUNNEL_TYPE(c->c1.tuntap),
-                            "READ_TUN", &c->c2.n_trunc_tun_read);
-#endif
-
     /* Was TUN/TAP interface stopped? */
     if (tuntap_stop(c->c2.buf.len))
     {
@@ -1527,12 +1516,6 @@
         unsigned int flags =
             PIPV4_PASSTOS | PIP_MSSFIX | PIPV4_CLIENT_NAT | PIPV6_ICMP_NOHOST_CLIENT;
         process_ip_header(c, flags, &c->c2.buf, out_sock);
-
-#ifdef PACKET_TRUNCATION_CHECK
-        /* if (c->c2.buf.len > 1) --c->c2.buf.len; */
-        ipv4_packet_size_verify(BPTR(&c->c2.buf), BLEN(&c->c2.buf), TUNNEL_TYPE(c->c1.tuntap),
-                                "PRE_ENCRYPT", &c->c2.n_trunc_pre_encrypt);
-#endif
     }
     if (c->c2.buf.len > 0)
     {
@@ -1932,11 +1915,6 @@
 #endif
         dmsg(D_TUN_RW, "TUN WRITE [%d]", BLEN(&c->c2.to_tun));
 
-#ifdef PACKET_TRUNCATION_CHECK
-        ipv4_packet_size_verify(BPTR(&c->c2.to_tun), BLEN(&c->c2.to_tun), TUNNEL_TYPE(c->c1.tuntap),
-                                "WRITE_TUN", &c->c2.n_trunc_tun_write);
-#endif
-
 #ifdef _WIN32
         size = tun_write_win32(c->c1.tuntap, &c->c2.to_tun);
 #else
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 055305d..90270f5 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -979,31 +979,6 @@
         status_printf(so, "ERROR: bad status format version number");
     }
 
-#ifdef PACKET_TRUNCATION_CHECK
-    {
-        status_printf(so, "HEADER,ERRORS,Common Name,TUN Read Trunc,TUN Write Trunc,Pre-encrypt Trunc,Post-decrypt Trunc");
-        hash_iterator_init(m->hash, &hi);
-        while ((he = hash_iterator_next(&hi)))
-        {
-            struct gc_arena gc = gc_new();
-            const struct multi_instance *mi = (struct multi_instance *)he->value;
-
-            if (!mi->halt)
-            {
-                status_printf(so,
-                              "ERRORS,%s," counter_format "," counter_format "," counter_format
-                              "," counter_format,
-                              tls_common_name(mi->context.c2.tls_multi, false),
-                              m->top.c2.n_trunc_tun_read, mi->context.c2.n_trunc_tun_write,
-                              mi->context.c2.n_trunc_pre_encrypt,
-                              mi->context.c2.n_trunc_post_decrypt);
-            }
-            gc_free(&gc);
-        }
-        hash_iterator_free(&hi);
-    }
-#endif /* ifdef PACKET_TRUNCATION_CHECK */
-
     status_flush(so);
     gc_free(&gc_top);
 
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index cdd02b6..970baa9 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -269,12 +269,6 @@
     counter_type link_read_bytes_auth;
     counter_type link_write_bytes;
     counter_type dco_write_bytes;
-#ifdef PACKET_TRUNCATION_CHECK
-    counter_type n_trunc_tun_read;
-    counter_type n_trunc_tun_write;
-    counter_type n_trunc_pre_encrypt;
-    counter_type n_trunc_post_decrypt;
-#endif
 
     /*
      * Timer objects for ping and inactivity
diff --git a/src/openvpn/proto.c b/src/openvpn/proto.c
index 2cdb147..a2b07df 100644
--- a/src/openvpn/proto.c
+++ b/src/openvpn/proto.c
@@ -163,52 +163,3 @@
     /* Take the one's complement of sum */
     return ((uint16_t)~sum);
 }
-
-#ifdef PACKET_TRUNCATION_CHECK
-
-void
-ipv4_packet_size_verify(const uint8_t *data, const int size, const int tunnel_type,
-                        const char *prefix, counter_type *errors)
-{
-    if (size > 0)
-    {
-        struct buffer buf;
-
-        buf_set_read(&buf, data, size);
-
-        if (is_ipv4(tunnel_type, &buf))
-        {
-            const struct openvpn_iphdr *pip;
-            int hlen;
-            int totlen;
-            const char *msgstr = "PACKET SIZE INFO";
-            msglvl_t msglevel = D_PACKET_TRUNC_DEBUG;
-
-            if (BLENZ(&buf) < sizeof(struct openvpn_iphdr))
-            {
-                return;
-            }
-
-            verify_align_4(&buf);
-            pip = (struct openvpn_iphdr *)BPTR(&buf);
-
-            hlen = OPENVPN_IPH_GET_LEN(pip->version_len);
-            totlen = ntohs(pip->tot_len);
-
-            if (BLEN(&buf) != totlen)
-            {
-                msgstr = "PACKET TRUNCATION ERROR";
-                msglevel = D_PACKET_TRUNC_ERR;
-                if (errors)
-                {
-                    ++(*errors);
-                }
-            }
-
-            msg(msglevel, "%s %s: size=%d totlen=%d hlen=%d errcount=" counter_format, msgstr,
-                prefix, BLEN(&buf), totlen, hlen, errors ? *errors : (counter_type)0);
-        }
-    }
-}
-
-#endif /* ifdef PACKET_TRUNCATION_CHECK */
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index 1665751..14f9264 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -307,11 +307,6 @@
 uint16_t ip_checksum(const sa_family_t af, const uint8_t *payload, const int len_payload,
                      const uint8_t *src_addr, const uint8_t *dest_addr, const int proto);
 
-#ifdef PACKET_TRUNCATION_CHECK
-void ipv4_packet_size_verify(const uint8_t *data, const int size, const int tunnel_type,
-                             const char *prefix, counter_type *errors);
-
-#endif
 
 #define OPENVPN_8021Q_MIN_VID 1
 #define OPENVPN_8021Q_MAX_VID 4094
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 81654f9..0cdb01a 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -504,12 +504,6 @@
         comp_print_stats(c->c2.comp_context, so);
     }
 #endif
-#ifdef PACKET_TRUNCATION_CHECK
-    status_printf(so, "TUN read truncations," counter_format, c->c2.n_trunc_tun_read);
-    status_printf(so, "TUN write truncations," counter_format, c->c2.n_trunc_tun_write);
-    status_printf(so, "Pre-encrypt truncations," counter_format, c->c2.n_trunc_pre_encrypt);
-    status_printf(so, "Post-decrypt truncations," counter_format, c->c2.n_trunc_post_decrypt);
-#endif
 #ifdef _WIN32
     if (tuntap_defined(c->c1.tuntap))
     {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
