Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47457CA5FDD
	for <openvpn-devel@archiver.kernel.org>; Sat,  3 Oct 2026 20:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aexai2GgChRWXPyUmVTVhB2NtvZixT8T6lTpAWCFMlM=; b=gjPCjn6kc/iYDxQiI4oupwSrRR
	RpDljDxrFmZ3xDat6cTaepEmca1ldc+0IPFxI0Jnga9TAoUwDDq9rzNXoX6sgJw7mY7LuNb0xU+Mr
	gveHTCYJMeO22ts2DWOH6B4Q/56LARmCJdLcKhEb5rPovynpmX/Or0QffZeWXocUmkAQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xD6YX-0001VA-8w;
	Sat, 03 Oct 2026 20:42:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xD6YV-0001Ul-Fo
 for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 20:42:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2Z86Ng7R9kwirgQM+ESfxlvwms8HQH4V6GK+JpkrnsE=; b=XnGMukb+XkYjRf/4D2hYg4Uc71
 fJB7BAMh5FvEgwu/o1kRZmtZUHlSfRFn4mSWLWYEuPARdU/7l7HqPKzokYZR1Yf408M7FgFD+ChXQ
 PfVrg80jo+hTaRJkMohIaRVuCfoVsS0IDRC3tvDgRGkgCINnpTEzpB4Eaqv0OZw7SGGc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2Z86Ng7R9kwirgQM+ESfxlvwms8HQH4V6GK+JpkrnsE=; b=ZDomLu0x4YDi9/M4vr1vp6lS3U
 X3y1tYJL5+ZtFXkrZS7Gv2NRReoVFHQvSYarXDJFG0SMvywO//J8ip1PBed8uCYQKf+4b3oUgvPU4
 gmXnydm09CTmTOkEHwk5Qx0qjO/EBq27UTGfaLi73PFL+4rNamUbF8nbN/aDYUbA6dkQ=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xD6YR-0001Ns-0L for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 20:42:00 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 693KfquY019365
 for <openvpn-devel@lists.sourceforge.net>; Sat, 3 Oct 2026 22:41:52 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 693KfqqB019364
 for openvpn-devel@lists.sourceforge.net; Sat, 3 Oct 2026 22:41:52 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat,  3 Oct 2026 22:41:45 +0200
Message-ID: <20261003204151.19347-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1790610390000.I7f910599f0f4005f06a88a93b40417ffa37022a8@gerrit.openvpn.net>
References: <gerrit.1790610390000.I7f910599f0f4005f06a88a93b40417ffa37022a8@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xD6YR-0001Ns-0L
Subject: [Openvpn-devel] [PATCH v3] Fix all occurrences of cppcheck
 invalidPrintfArgType_uint
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

Mostly trivially correct. There are some exceptions, though:
- cppcheck treats all numerical literals as "signed" even
  though the compilers would probably be more intelligent.
  Chose different work-arounds for different occurrences.
- Needed to override PRIx64 again for Windows, since there
  it needs to be "llx", not "lx".

Change-Id: I7f910599f0f4005f06a88a93b40417ffa37022a8
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1960
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1960
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/dev-tools/cppcheck-suppressions.xml b/dev-tools/cppcheck-suppressions.xml
index 12521e1..38de5f2a 100644
--- a/dev-tools/cppcheck-suppressions.xml
+++ b/dev-tools/cppcheck-suppressions.xml
@@ -9,9 +9,6 @@
     <id>constParameterCallback</id>
   </suppress>
   <suppress>
-    <id>invalidPrintfArgType_uint</id>
-  </suppress>
-  <suppress>
     <id>unusedFunction</id>
   </suppress>
   <suppress>
diff --git a/dev-tools/openvpn-cppcheck-windows.cfg b/dev-tools/openvpn-cppcheck-windows.cfg
index 9ac7282..932d586 100644
--- a/dev-tools/openvpn-cppcheck-windows.cfg
+++ b/dev-tools/openvpn-cppcheck-windows.cfg
@@ -7,4 +7,7 @@
        understand our likely()/unlikely() macros. -->
   <define name="__builtin_expect(X,Y)" value="(X)" />
   <define name="__builtin_expect_with_probability(exp,c,probability)" value="(exp)" />
+  <!-- cppcheck understands it directly in format string, but not
+       indirectly when the format string is constructed earlier -->
+  <define name="PRIx64" value="&quot;llx&quot;" />
 </def>
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index c01a4e5..7abd06b 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -835,7 +835,7 @@
         struct multi_instance *mi = dco->c->multi->instances[stat->PeerId];
         if (!mi)
         {
-            msg(M_WARN, "%s: received data for a non-existing peer %u", __func__, stat->PeerId);
+            msg(M_WARN, "%s: received data for a non-existing peer %d", __func__, stat->PeerId);
             continue;
         }
 
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index 51bc2de..2c20b0e 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -89,7 +89,7 @@
 };
 
 #ifndef N_DHCP_ADDR
-#define N_DHCP_ADDR 4
+#define N_DHCP_ADDR 4u
 #endif
 
 #ifndef N_SEARCH_LIST_LEN
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index e7d3a24..178c43f 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1305,7 +1305,7 @@
             break;
 
         default:
-            msg(D_DCO_DEBUG, "%s: received message of type %u - ignoring", __func__,
+            msg(D_DCO_DEBUG, "%s: received message of type %d - ignoring", __func__,
                 dco->dco_message_type);
             return;
     }
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 81890d4..3c2ebf9 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -258,7 +258,7 @@
         gc = gc_new();
         {
             struct buffer out = alloc_buf_gc(256, &gc);
-            buf_printf(&out, ">PROXY:%u,%s,%s", (l ? l->current : 0) + 1,
+            buf_printf(&out, ">PROXY:%d,%s,%s", (l ? l->current : 0) + 1,
                        (proto_is_udp(ce->proto) ? "UDP" : "TCP"), np(ce->remote));
             management_notify_generic(BSTR(&out));
             management->persist.special_state_msg = BSTR(&out);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 95e93da..5a57c0a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5139,7 +5139,7 @@
         }
         else
         {
-            msg(msglevel, "argument to --bind-dev is longer than allowed %u", IFNAMSIZ - 1);
+            msg(msglevel, "argument to --bind-dev is longer than allowed %d", IFNAMSIZ - 1);
             goto err;
         }
     }
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index ab581f4..ccdd43d 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -551,7 +551,7 @@
         ++attempts;
 
         if (!checked_snprintf(fname, sizeof(fname), fname_fmt, max_prefix_len, prefix,
-                              get_random(), get_random()))
+                              (uint64_t)get_random(), (uint64_t)get_random()))
         {
             msg(M_WARN, "ERROR: temporary filename too long");
             return NULL;
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index d72596e..a514d92a 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -351,7 +351,7 @@
     parse_auth_pending_keywords(buffer, &server_timeout);
 
     msg(D_PUSH,
-        "AUTH_PENDING received, extending handshake timeout from %us "
+        "AUTH_PENDING received, extending handshake timeout from %ds "
         "to %us",
         c->options.handshake_window, min_uint(max_timeout, server_timeout));
 
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 469edb3..b8bac7a 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2822,7 +2822,7 @@
         ret = (ack.error_number == ERROR_OBJECT_ALREADY_EXISTS) ? RTA_EEXIST : RTA_ERROR;
         if (ret == RTA_ERROR)
         {
-            msg(M_WARN, "ERROR: route %s failed using service: %s [status=%u if_index=%lu]",
+            msg(M_WARN, "ERROR: route %s failed using service: %s [status=%d if_index=%lu]",
                 (add ? "addition" : "deletion"), strerror_win32(ack.error_number, &gc),
                 ack.error_number, rt->iface.index);
         }
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 6a8e78e..3594871 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1690,7 +1690,7 @@
                                    options->ping_rec_timeout, frame->mss_fix);
             if (ret < 0)
             {
-                msg(D_DCO, "Cannot set DCO peer parameters for peer (id=%u): %s",
+                msg(D_DCO, "Cannot set DCO peer parameters for peer (id=%d): %s",
                     multi->dco_peer_id, strerror(-ret));
                 return false;
             }
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 2d8f36d..85b3074 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -153,7 +153,7 @@
 
     if (ack.error_number != NO_ERROR)
     {
-        msg(M_WARN, "TUN: %s address failed using service: %s [status=%u if_index=%lu]",
+        msg(M_WARN, "TUN: %s address failed using service: %s [status=%d if_index=%lu]",
             (add ? "adding" : "deleting"), strerror_win32(ack.error_number, &gc), ack.error_number,
             addr.iface.index);
         goto out;
@@ -224,7 +224,7 @@
 
     if (ack.error_number != NO_ERROR)
     {
-        msg(M_WARN, "TUN: %s DNS domains failed using service: %s [status=%u if_name=%s]",
+        msg(M_WARN, "TUN: %s DNS domains failed using service: %s [status=%d if_name=%s]",
             (add ? "adding" : "deleting"), strerror_win32(ack.error_number, &gc), ack.error_number,
             dns.iface.name);
         goto out;
@@ -294,7 +294,7 @@
 
     if (ack.error_number != NO_ERROR)
     {
-        msg(M_WARN, "TUN: %s %s dns failed using service: %s [status=%u if_name=%s]",
+        msg(M_WARN, "TUN: %s %s dns failed using service: %s [status=%d if_name=%s]",
             (add ? "adding" : "deleting"), ip_proto_name, strerror_win32(ack.error_number, &gc),
             ack.error_number, dns.iface.name);
         goto out;
@@ -351,7 +351,7 @@
 
     if (ack.error_number != NO_ERROR)
     {
-        msg(M_WARN, "TUN: %s WINS failed using service: %s [status=%u if_name=%s]",
+        msg(M_WARN, "TUN: %s WINS failed using service: %s [status=%d if_name=%s]",
             (add ? "adding" : "deleting"), strerror_win32(ack.error_number, &gc),
             ack.error_number, wins.iface.name);
         goto out;
@@ -389,7 +389,7 @@
 
     if (ack.error_number != NO_ERROR)
     {
-        msg(M_NONFATAL, "TUN: setting %s mtu using service failed: %s [status=%u if_index=%lu]",
+        msg(M_NONFATAL, "TUN: setting %s mtu using service failed: %s [status=%d if_index=%lu]",
             family_name, strerror_win32(ack.error_number, &gc), ack.error_number,
             mtu_msg.iface.index);
     }
@@ -467,7 +467,7 @@
 
     if (ack.error_number != NO_ERROR)
     {
-        msg(M_NONFATAL, "TUN: creating %s adapter using service failed: %s [status=%u]",
+        msg(M_NONFATAL, "TUN: creating %s adapter using service failed: %s [status=%d]",
             print_tun_backend_driver(driver_type), strerror_win32(ack.error_number, &gc),
             ack.error_number);
     }
@@ -5192,7 +5192,7 @@
 
     if (ack.error_number != NO_ERROR)
     {
-        msg(M_NONFATAL, "TUN: enabling dhcp using service failed: %s [status=%u if_index=%lu]",
+        msg(M_NONFATAL, "TUN: enabling dhcp using service failed: %s [status=%d if_index=%lu]",
             strerror_win32(ack.error_number, &gc), ack.error_number, dhcp.iface.index);
     }
     else
@@ -5441,7 +5441,7 @@
     {
         msg(M_FATAL,
             "ERROR:  This version of " PACKAGE_NAME
-            " requires a TAP-Windows driver that is at least version %u.%u -- If you recently upgraded your " PACKAGE_NAME
+            " requires a TAP-Windows driver that is at least version %d.%d -- If you recently upgraded your " PACKAGE_NAME
             " distribution, a reboot is probably required at this point to get Windows to see the new driver.",
             TAP_WIN_MIN_MAJOR, TAP_WIN_MIN_MINOR);
     }
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 0ff2a0b..393e856 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -105,7 +105,7 @@
     uint8_t netbios_node_type; /* NBT 1,2,4,8 (46) */
 
 /* Max # of addresses allowed for  DNS, WINS, etc. */
-#define N_DHCP_ADDR 4
+#define N_DHCP_ADDR 4u
 
     /* DNS (6) */
     in_addr_t dns[N_DHCP_ADDR];
diff --git a/src/openvpnmsica/msica_arg.c b/src/openvpnmsica/msica_arg.c
index d763d93..c1809f0 100644
--- a/src/openvpnmsica/msica_arg.c
+++ b/src/openvpnmsica/msica_arg.c
@@ -57,7 +57,7 @@
     struct msica_arg *p = malloc(sizeof(struct msica_arg) + argument_size);
     if (p == NULL)
     {
-        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__,
+        msg(M_FATAL, "%s: malloc(%zu) failed", __FUNCTION__,
             sizeof(struct msica_arg) + argument_size);
     }
     memcpy(p->val, argument, argument_size);
@@ -77,7 +77,7 @@
     struct msica_arg *p = malloc(sizeof(struct msica_arg) + argument_size);
     if (p == NULL)
     {
-        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__,
+        msg(M_FATAL, "%s: malloc(%zu) failed", __FUNCTION__,
             sizeof(struct msica_arg) + argument_size);
     }
     memcpy(p->val, argument, argument_size);
@@ -102,7 +102,7 @@
     LPWSTR str = malloc(size);
     if (str == NULL)
     {
-        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, size);
+        msg(M_FATAL, "%s: malloc(%zu) failed", __FUNCTION__, size);
         return NULL;
     }
 
diff --git a/src/openvpnmsica/msiex.c b/src/openvpnmsica/msiex.c
index 4d48f06..c6bc648 100644
--- a/src/openvpnmsica/msiex.c
+++ b/src/openvpnmsica/msiex.c
@@ -51,7 +51,7 @@
         *pszValue = (LPWSTR)malloc(++dwLength * sizeof(WCHAR));
         if (*pszValue == NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
+            msg(M_FATAL, "%s: malloc(%zu) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
             return ERROR_OUTOFMEMORY;
         }
 
@@ -64,7 +64,7 @@
         LPWSTR szBufHeap = (LPWSTR)malloc(++dwLength * sizeof(WCHAR));
         if (szBufHeap == NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
+            msg(M_FATAL, "%s: malloc(%zu) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
             return ERROR_OUTOFMEMORY;
         }
 
@@ -107,7 +107,7 @@
         *pszValue = (LPWSTR)malloc(++dwLength * sizeof(WCHAR));
         if (*pszValue == NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
+            msg(M_FATAL, "%s: malloc(%zu) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
             return ERROR_OUTOFMEMORY;
         }
 
@@ -120,7 +120,7 @@
         LPWSTR szBufHeap = (LPWSTR)malloc(++dwLength * sizeof(WCHAR));
         if (szBufHeap == NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
+            msg(M_FATAL, "%s: malloc(%zu) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
             return ERROR_OUTOFMEMORY;
         }
 
@@ -163,7 +163,7 @@
         *pszValue = (LPWSTR)malloc(++dwLength * sizeof(WCHAR));
         if (*pszValue == NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
+            msg(M_FATAL, "%s: malloc(%zu) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
             return ERROR_OUTOFMEMORY;
         }
 
@@ -176,7 +176,7 @@
         LPWSTR szBufHeap = (LPWSTR)malloc(++dwLength * sizeof(WCHAR));
         if (szBufHeap == NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
+            msg(M_FATAL, "%s: malloc(%zu) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
             return ERROR_OUTOFMEMORY;
         }
 
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index e510e4d..d2fd9af 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -165,7 +165,7 @@
         pAdapterAdresses = (PIP_ADAPTER_ADDRESSES)malloc(ulAdapterAdressesSize);
         if (pAdapterAdresses == NULL)
         {
-            msg(M_NONFATAL, "%s: malloc(%u) failed", __FUNCTION__, ulAdapterAdressesSize);
+            msg(M_NONFATAL, "%s: malloc(%lu) failed", __FUNCTION__, ulAdapterAdressesSize);
             uiResult = ERROR_OUTOFMEMORY;
             goto cleanup_pAdapterList;
         }
@@ -208,7 +208,7 @@
     szAdaptersTail = szAdapters;
     if (szAdapters == NULL)
     {
-        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__,
+        msg(M_FATAL, "%s: malloc(%zu) failed", __FUNCTION__,
             adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(WCHAR));
         uiResult = ERROR_OUTOFMEMORY;
         goto cleanup_pAdapterAdresses;
@@ -220,7 +220,7 @@
     szAdaptersActiveTail = szAdaptersActive;
     if (szAdaptersActive == NULL)
     {
-        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__,
+        msg(M_FATAL, "%s: malloc(%zu) failed", __FUNCTION__,
             adapter_count * (38 /*GUID*/ + 1 /*separator/terminator*/) * sizeof(WCHAR));
         uiResult = ERROR_OUTOFMEMORY;
         goto cleanup_szAdapters;
@@ -405,7 +405,7 @@
         szPath = (LPWSTR)malloc((++dwPathSize) * sizeof(WCHAR));
         if (szPath == NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwPathSize * sizeof(WCHAR));
+            msg(M_FATAL, "%s: malloc(%zu) failed", __FUNCTION__, dwPathSize * sizeof(WCHAR));
             uiResult = ERROR_OUTOFMEMORY;
             goto cleanup_MsiCreateRecord;
         }
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 82b24f4..026d5aa 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -311,7 +311,7 @@
      * Same format as error messages (3 line string) with error = 0 in
      * 0x%08x format, PID on line 2 and a description "Process ID" on line 3
      */
-    swprintf(buf, _countof(buf), L"0x%08x\n0x%08x\n%ls", 0, pid, msg);
+    swprintf(buf, _countof(buf), L"0x%08x\n0x%08lx\n%ls", 0, pid, msg);
 
     WritePipeAsync(pipe, buf, (DWORD)(wcslen(buf) * 2), count, events);
 }
@@ -380,7 +380,7 @@
     if (!argv)
     {
         swprintf(errmsg, capacity,
-                 L"Cannot validate options: CommandLineToArgvW failed with error = 0x%08x",
+                 L"Cannot validate options: CommandLineToArgvW failed with error = 0x%08lx",
                  GetLastError());
         goto out;
     }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
