Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C95CCA462
	for <openvpn-devel@archiver.kernel.org>; Fri, 16 Oct 2026 08:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AIRivqxwVz1uGDgddIubEkMjmw/D5/QxJrNh0VOxlfM=; b=jN4/jndRU6juJIIVx/YXg/kDfD
	tFJ4zj4aOvBkOmYAvjJjq9+EqWjR3mkSisr2CfypEEoCIIUZRPFfenkPk9b3t2UVGRSMNXyo+4bKm
	OB6MNmW3zRKCx8cXuMq1KLkjB1zvfAJzl+QldIq/OmaiFfeD9U6SXM9/L+o9j3dGbNLQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHdcK-0003aH-EJ;
	Fri, 16 Oct 2026 08:48:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xHdcG-0003aB-Jp
 for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 08:48:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KgrHaeEPpPsL2zpwCQw8zL9/sctntg1nNnZo/dNVoGw=; b=ILKdbH/x2ySdt+raeGtLodFbPq
 qAuWuN4lV2B87+Qt7eaiiP+Zn0CAlzKkMQByikV6KINzJIn/wr11Ci5Ro5njrG1rJctruCtfQOHHg
 NBE/o46p1jwriTLa4JWvc90R87c5gLIjxLYE/QzPPMjXwVXJo8O0JZQtGJkUfkyDH3N8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KgrHaeEPpPsL2zpwCQw8zL9/sctntg1nNnZo/dNVoGw=; b=a1zGhHlwwUdVCPvahW3CXSfmYV
 uuoeuWsQth2/J/ke7XSccjjPkxVus4Ev0cAj25ZyeHcIdy4+oPTTlbeXgXWZ2YjRE05F+pIdVpPZ+
 7gsm9+PpReL3tCNWOWg0L3jM+r6RxvL3GFPFhH24dTyFa5k3P63b/nFTKQ/4Hy4ZnIjU=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xHdcC-0001Sp-86 for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 08:48:40 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69G8mTLC026829
 for <openvpn-devel@lists.sourceforge.net>; Fri, 16 Oct 2026 10:48:29 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69G8mTl9026828
 for openvpn-devel@lists.sourceforge.net; Fri, 16 Oct 2026 10:48:29 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 16 Oct 2026 10:48:23 +0200
Message-ID: <20261016084828.26818-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1791901394000.I5ee597fb3b9efb93dbe19458ae6e7580d27ae3d2@gerrit.openvpn.net>
References: <gerrit.1791901394000.I5ee597fb3b9efb93dbe19458ae6e7580d27ae3d2@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xHdcC-0001Sp-86
Subject: [Openvpn-devel] [PATCH v2] Review usage of strncpy
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

- Some users where re-creating strcpynt
- Some users should have used strcpynt since they
  were not handling truncation at all
- Some users where actually using it like memcpy
  and so should have used that

Partly based on a commit by Alejandro
Pacheco <alepacheco99@gmail.com>.

Change-Id: I5ee597fb3b9efb93dbe19458ae6e7580d27ae3d2
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1993
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1993
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 7f4dde4..713f41e 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -110,7 +110,7 @@
         {
             return false;
         }
-        strncpy(addrcopy, addr, copylen);
+        memcpy(addrcopy, addr, copylen);
         addr = addrcopy;
     }
 
@@ -391,7 +391,7 @@
         {
             *(dst + offset++) = '.';
         }
-        strncpy(dst + offset, src->name, len);
+        memcpy(dst + offset, src->name, len);
         offset += len;
 
         src = src->next;
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 0aef2d4..55e8105 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2374,7 +2374,7 @@
     }
     struct user_pass up;
     CLEAR(up);
-    strncpy(up.username, msg, sizeof(up.username) - 1);
+    strncpynt(up.username, msg, sizeof(up.username));
 
     management_query_user_pass(management, &up, command, GET_USER_PASS_NEED_OK, (void *)0);
     return strcmp("ok", up.password) == 0;
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 6e9591f..0e4669a 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -303,7 +303,7 @@
 
                 if (password_buf[0])
                 {
-                    strncpy(up->password, password_buf, USER_PASS_LEN);
+                    strncpynt(up->password, password_buf, USER_PASS_LEN);
                 }
                 else
                 {
@@ -452,7 +452,7 @@
         /* Use tag for blank password if we are not prompting for one */
         if (flags & GET_USER_PASS_USERNAME_ONLY)
         {
-            strncpy(up->password, blank_up, sizeof(up->password));
+            strncpynt(up->password, blank_up, sizeof(up->password));
         }
 
         string_mod(up->username, CC_PRINT, CC_CRLF, 0);
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 83915db..d6510bb 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -602,7 +602,7 @@
 
     /* save result in output variables */
     memcpy(best_gw, &res.gw, res.addr_size);
-    strncpy(best_iface, res.iface, IFNAMSIZ);
+    strncpynt(best_iface, res.iface, IFNAMSIZ);
 err:
     return ret;
 }
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 6664c73..4385419 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6310,12 +6310,12 @@
     else if (streq(p[0], "override-username") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_INSTANCE);
-        if (strlen(p[1]) > USER_PASS_LEN)
+        if (strlen(p[1]) >= USER_PASS_LEN)
         {
             msg(msglevel,
                 "override-username exceeds the maximum length of %d "
                 "characters",
-                USER_PASS_LEN);
+                USER_PASS_LEN - 1);
 
             /* disable the connection since ignoring the request to
              * set another username might cause serious problems */
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 08c2673..9a36d12 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -75,17 +75,6 @@
     char *jfn;
 };
 
-#if 0
-static const char *
-headc(const struct buffer *buf)
-{
-    static char foo[16];
-    strncpy(foo, BSTR(buf), 15);
-    foo[15] = 0;
-    return foo;
-}
-#endif
-
 static inline void
 close_socket_if_defined(const socket_descriptor_t sd)
 {
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 33b2387..9209a76 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2968,8 +2968,7 @@
 
     if (msg.iface.index == TUN_ADAPTER_INDEX_INVALID)
     {
-        strncpy(msg.iface.name, tt->actual_name, sizeof(msg.iface.name));
-        msg.iface.name[sizeof(msg.iface.name) - 1] = '\0';
+        strncpynt(msg.iface.name, tt->actual_name, sizeof(msg.iface.name));
     }
 
     status = do_route_service(add, &msg, sizeof(msg), tt->options.msg_channel);
@@ -3747,7 +3746,7 @@
         {
             rgi->gateway.addr = ntohl(((struct sockaddr_in *)route.gateway)->sin_addr.s_addr);
             rgi->flags = RGI_ADDR_DEFINED | RGI_IFACE_DEFINED;
-            strncpy(rgi->iface, interface->ifr_name, sizeof(rgi->iface));
+            strncpynt(rgi->iface, interface->ifr_name, sizeof(rgi->iface));
         }
 
         int32 address_size = 0;
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 96e90f82..02fd556 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -433,7 +433,7 @@
             len - 1);
     }
 
-    strncpy(openssl_ciphers, ciphers, len);
+    strncpynt(openssl_ciphers, ciphers, len);
 
     for (size_t i = 0; i < strlen(openssl_ciphers); i++)
     {
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 6631718..43ed980 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1640,7 +1640,7 @@
             "TLS: Replacing client provided username '%s' with "
             "username from override-user '%s'",
             up->username, multi->locked_username);
-        strncpy(up->username, multi->locked_username, sizeof(up->username));
+        strncpynt(up->username, multi->locked_username, sizeof(up->username));
     }
 
     /*
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 133f670..9e7e7d7 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -127,8 +127,7 @@
 
     if (addr.iface.index == TUN_ADAPTER_INDEX_INVALID)
     {
-        strncpy(addr.iface.name, tt->actual_name, sizeof(addr.iface.name));
-        addr.iface.name[sizeof(addr.iface.name) - 1] = '\0';
+        strncpynt(addr.iface.name, tt->actual_name, sizeof(addr.iface.name));
     }
 
     if (addr.family == AF_INET)
@@ -212,7 +211,7 @@
         {
             dns.domains[dstlen++] = ',';
         }
-        strncpy(dns.domains + dstlen, o->domain_search_list[i], srclen + 1);
+        memcpy(dns.domains + dstlen, o->domain_search_list[i], srclen + 1);
     }
 
     msg(D_LOW, "%s DNS domains on '%s' (if_index = %lu) using service",
@@ -261,8 +260,7 @@
                               .addr_len = addr_len };
 
     /* interface name is required */
-    strncpy(dns.iface.name, tt->actual_name, sizeof(dns.iface.name));
-    dns.iface.name[sizeof(dns.iface.name) - 1] = '\0';
+    strncpynt(dns.iface.name, tt->actual_name, sizeof(dns.iface.name));
 
     if (addr_len > _countof(dns.addr))
     {
@@ -326,8 +324,7 @@
                                 .addr_len = addr_len };
 
     /* interface name is required */
-    strncpy(wins.iface.name, tt->actual_name, sizeof(wins.iface.name));
-    wins.iface.name[sizeof(wins.iface.name) - 1] = '\0';
+    strncpynt(wins.iface.name, tt->actual_name, sizeof(wins.iface.name));
 
     if (addr_len > _countof(wins.addr))
     {
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 9a68bbb..33151cb 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1810,7 +1810,7 @@
             wide_domains = NULL;
             goto out;
         }
-        strncpy(undo_data->itf_name, itf_name, sizeof(undo_data->itf_name));
+        strncpy_s(undo_data->itf_name, sizeof(undo_data->itf_name), itf_name, _TRUNCATE);
         undo_data->domains = wide_domains;
 
         if (AddDnsSearchDomains(list_key, have_list, wide_domains) == FALSE
diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/openvpn/test_auth_token.c
index 9e7b5b9..89c418e 100644
--- a/tests/unit_tests/openvpn/test_auth_token.c
+++ b/tests/unit_tests/openvpn/test_auth_token.c
@@ -273,7 +273,7 @@
     }
     else if (streq(name, "session_id"))
     {
-        strncpy(last_session_id_value, value, sizeof(last_session_id_value));
+        strncpynt(last_session_id_value, value, sizeof(last_session_id_value));
     }
 }
 
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c
index c0a0866..5ad4730 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -53,7 +53,7 @@
     for (int i = 0; i < QUERY_USER_NUMSLOTS && query_user[i].response != NULL; i++)
     {
         check_expected_ptr(query_user[i].prompt);
-        strncpy(query_user[i].response, mock_ptr_type(char *), query_user[i].response_len);
+        strncpynt(query_user[i].response, mock_ptr_type(char *), query_user[i].response_len);
     }
 
     return mock();


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
