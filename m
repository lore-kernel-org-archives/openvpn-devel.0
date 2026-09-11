Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3884C88E53
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 20:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ot0iqKlGpEN9RJGXihIeqXiQkNBjHzrNzuJ076wYDrc=; b=VYu8P011L+ZoGnebrd1rVPlEA7
	K5kcNKwRRfAWG1hu7Ag+nNoXR92EXzZGnhVIOW39+s0/4cWn9Pgr+Db3GObPadsRdJRgNZLq8rwym
	pXeBxdy5bgj6L1w3qsILAjKIUsOLdRPk7irNr4ussjB1AZE/64eoGvK+fjxYXlbs56Bc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x588B-0007ap-V4;
	Fri, 11 Sep 2026 20:45:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x5889-0007aT-DL
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 20:45:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gN7S8purRvc24n5TdvIl4SlhwfWvP0rKHVkWUahGOEs=; b=CHC8cPCGmcWxU1r2Qn629iDUzr
 DNZBoRLDLPTMMQzrzkDw43wFPp6eglTXciaWZ1b/LeiPxUfJd2yAvm6bHLHzuzwNxHwlnLF4HyBuF
 cVlrMuauPfqhOSX2TuoWZZ60yPYGhld3mKfga1sNdKO1vrk17eV+r2OnBSXd9paJ5HMg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gN7S8purRvc24n5TdvIl4SlhwfWvP0rKHVkWUahGOEs=; b=fYlryXydLI4FSkJjWwh92Cvn0p
 61ERISJr9Vdmlmb7E5yNkj4GPPZyOPB0OZmmQIl8zBWMG1NN0zbDAWy+SaPDqpqbIzSd2LV/D8IF1
 Kc84uzNg9gq9TuRrG76oSrYN8EYbfwy0xanC2bEXOapI2nZk2I2rgzPIg7vRg8Gw54M4=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x5888-0003iw-Rs for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 20:45:53 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 68BKjkeI015765
 for <openvpn-devel@lists.sourceforge.net>; Fri, 11 Sep 2026 22:45:46 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 68BKjkAB015764
 for openvpn-devel@lists.sourceforge.net; Fri, 11 Sep 2026 22:45:46 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 11 Sep 2026 22:45:38 +0200
Message-ID: <20260911204545.15750-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1788815035000.I4351fc499188b7d0cdbcb4f0531e9f157e948c5e@gerrit.openvpn.net>
References: <gerrit.1788815035000.I4351fc499188b7d0cdbcb4f0531e9f157e948c5e@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x5888-0003iw-Rs
Subject: [Openvpn-devel] [PATCH v3] management: Remove management argument
 to functions that do not need it
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

Found when reviewing the cppcheck constParameterPointer
warnings.

Change-Id: I4351fc499188b7d0cdbcb4f0531e9f157e948c5e
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1903
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1903
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 1109a13..453ee7e 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -260,7 +260,7 @@
             struct buffer out = alloc_buf_gc(256, &gc);
             buf_printf(&out, ">PROXY:%u,%s,%s", (l ? l->current : 0) + 1,
                        (proto_is_udp(ce->proto) ? "UDP" : "TCP"), np(ce->remote));
-            management_notify_generic(management, BSTR(&out));
+            management_notify_generic(BSTR(&out));
             management->persist.special_state_msg = BSTR(&out);
         }
         ce->flags |= CE_MAN_QUERY_PROXY;
@@ -425,7 +425,7 @@
 
         buf_printf(&out, ">REMOTE:%s,%s,%s", np(ce->remote), ce->remote_port,
                    proto2ascii(ce->proto, ce->af, false));
-        management_notify_generic(management, BSTR(&out));
+        management_notify_generic(BSTR(&out));
         management->persist.special_state_msg = BSTR(&out);
 
         ce->flags &= ~(CE_MAN_QUERY_REMOTE_MASK << CE_MAN_QUERY_REMOTE_SHIFT);
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 2b0a661..310d2e1 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -843,7 +843,7 @@
 }
 
 static void
-man_forget_passwords(struct management *man)
+man_forget_passwords(void)
 {
     ssl_purge_auth(false);
     (void)ssl_clean_auth_token();
@@ -1344,18 +1344,16 @@
  * Checks if the correct number of arguments to a management command are present
  * and otherwise prints an error and returns false.
  *
- * @param man       The management interface struct
  * @param p         pointer to the parameter array
  * @param n         number of arguments required
  * @param flags     if MN_AT_LEAST require at least n parameters and not exactly n
  * @return          Return whether p has n (or at least n) parameters
  */
 static bool
-man_need(struct management *man, const char **p, const int n, unsigned int flags)
+man_need(const char **p, const int n, unsigned int flags)
 {
-    int i;
     ASSERT(p[0]);
-    for (i = 1; i <= n; ++i)
+    for (int i = 1; i <= n; ++i)
     {
         if (!p[i])
         {
@@ -1522,7 +1520,7 @@
     }
     else if (streq(p[0], "signal"))
     {
-        if (man_need(man, p, 1, 0))
+        if (man_need(p, 1, 0))
         {
             man_signal(man, p[1]);
         }
@@ -1554,7 +1552,7 @@
     }
     else if (streq(p[0], "kill"))
     {
-        if (man_need(man, p, 1, 0))
+        if (man_need(p, 1, 0))
         {
             man_kill(man, p[1]);
         }
@@ -1632,7 +1630,7 @@
     }
     else if (streq(p[0], "log"))
     {
-        if (man_need(man, p, 1, MN_AT_LEAST))
+        if (man_need(p, 1, MN_AT_LEAST))
         {
             if (p[1])
             {
@@ -1646,7 +1644,7 @@
     }
     else if (streq(p[0], "echo"))
     {
-        if (man_need(man, p, 1, MN_AT_LEAST))
+        if (man_need(p, 1, MN_AT_LEAST))
         {
             if (p[1])
             {
@@ -1660,14 +1658,14 @@
     }
     else if (streq(p[0], "username"))
     {
-        if (man_need(man, p, 2, 0))
+        if (man_need(p, 2, 0))
         {
             man_query_username(man, p[1], p[2]);
         }
     }
     else if (streq(p[0], "password"))
     {
-        if (man_need(man, p, 1, MN_AT_LEAST))
+        if (man_need(p, 1, MN_AT_LEAST))
         {
             if (p[2])
             {
@@ -1685,25 +1683,25 @@
     }
     else if (streq(p[0], "forget-passwords"))
     {
-        man_forget_passwords(man);
+        man_forget_passwords();
     }
     else if (streq(p[0], "needok"))
     {
-        if (man_need(man, p, 2, 0))
+        if (man_need(p, 2, 0))
         {
             man_query_need_ok(man, p[1], p[2]);
         }
     }
     else if (streq(p[0], "needstr"))
     {
-        if (man_need(man, p, 2, 0))
+        if (man_need(p, 2, 0))
         {
             man_query_need_str(man, p[1], p[2]);
         }
     }
     else if (streq(p[0], "cr-response"))
     {
-        if (man_need(man, p, 1, 0))
+        if (man_need(p, 1, 0))
         {
             man_send_cc_message(man, "CR_RESPONSE", p[1]);
         }
@@ -1718,42 +1716,42 @@
     }
     else if (streq(p[0], "bytecount"))
     {
-        if (man_need(man, p, 1, 0))
+        if (man_need(p, 1, 0))
         {
             man_bytecount(man, atoi(p[1]));
         }
     }
     else if (streq(p[0], "client-kill"))
     {
-        if (man_need(man, p, 1, MN_AT_LEAST))
+        if (man_need(p, 1, MN_AT_LEAST))
         {
             man_client_kill(man, p[1], p[2]);
         }
     }
     else if (streq(p[0], "client-deny"))
     {
-        if (man_need(man, p, 3, MN_AT_LEAST))
+        if (man_need(p, 3, MN_AT_LEAST))
         {
             man_client_deny(man, p[1], p[2], p[3], p[4]);
         }
     }
     else if (streq(p[0], "client-auth-nt"))
     {
-        if (man_need(man, p, 2, 0))
+        if (man_need(p, 2, 0))
         {
             man_client_auth(man, p[1], p[2], false);
         }
     }
     else if (streq(p[0], "client-auth"))
     {
-        if (man_need(man, p, 2, 0))
+        if (man_need(p, 2, 0))
         {
             man_client_auth(man, p[1], p[2], true);
         }
     }
     else if (streq(p[0], "client-pending-auth"))
     {
-        if (man_need(man, p, 4, 0))
+        if (man_need(p, 4, 0))
         {
             man_client_pending_auth(man, p[1], p[2], p[3], p[4]);
         }
@@ -1777,7 +1775,7 @@
     }
     else if (streq(p[0], "pkcs11-id-get"))
     {
-        if (man_need(man, p, 1, 0))
+        if (man_need(p, 1, 0))
         {
             man_pkcs11_id_get(man, atoi(p[1]));
         }
@@ -1789,35 +1787,35 @@
     }
     else if (streq(p[0], "remote-entry-get"))
     {
-        if (man_need(man, p, 1, MN_AT_LEAST))
+        if (man_need(p, 1, MN_AT_LEAST))
         {
             man_remote_entry_get(man, p[1], p[2]);
         }
     }
     else if (streq(p[0], "proxy"))
     {
-        if (man_need(man, p, 1, MN_AT_LEAST))
+        if (man_need(p, 1, MN_AT_LEAST))
         {
             man_proxy(man, p);
         }
     }
     else if (streq(p[0], "remote"))
     {
-        if (man_need(man, p, 1, MN_AT_LEAST))
+        if (man_need(p, 1, MN_AT_LEAST))
         {
             man_remote(man, p);
         }
     }
     else if (streq(p[0], "push-update-broad"))
     {
-        if (man_need(man, p, 1, 0))
+        if (man_need(p, 1, 0))
         {
             man_push_update(man, p, UPT_BROADCAST);
         }
     }
     else if (streq(p[0], "push-update-cid"))
     {
-        if (man_need(man, p, 2, 0))
+        if (man_need(p, 2, 0))
         {
             man_push_update(man, p, UPT_BY_CID);
         }
@@ -1825,7 +1823,7 @@
 #if 1
     else if (streq(p[0], "test"))
     {
-        if (man_need(man, p, 1, 0))
+        if (man_need(p, 1, 0))
         {
             int i;
             const int n = atoi(p[1]);
@@ -3024,13 +3022,13 @@
 }
 
 void
-management_notify(struct management *man, const char *severity, const char *type, const char *text)
+management_notify(const char *severity, const char *type, const char *text)
 {
     msg(M_CLIENT, ">NOTIFY:%s,%s,%s", severity, type, text);
 }
 
 void
-management_notify_generic(struct management *man, const char *str)
+management_notify_generic(const char *str)
 {
     msg(M_CLIENT, "%s", str);
 }
@@ -3128,7 +3126,7 @@
 }
 
 void
-management_learn_addr(struct management *management, struct man_def_auth_context *mdac,
+management_learn_addr(struct man_def_auth_context *mdac,
                       const struct mroute_addr *addr, const bool primary)
 {
     struct gc_arena gc = gc_new();
@@ -3220,7 +3218,7 @@
 }
 
 void
-management_auth_token(struct management *man, const char *token)
+management_auth_token(const char *token)
 {
     msg(M_CLIENT, ">PASSWORD:Auth-Token:%s", token);
 }
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 27d3b60..3ab937c 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -384,10 +384,10 @@
 
 void management_up_down(struct management *man, const char *updown, const struct env_set *es);
 
-void management_notify(struct management *man, const char *severity, const char *type,
+void management_notify(const char *severity, const char *type,
                        const char *text);
 
-void management_notify_generic(struct management *man, const char *str);
+void management_notify_generic(const char *str);
 
 void management_notify_client_needing_auth(struct management *management,
                                            const unsigned int auth_id,
@@ -400,7 +400,7 @@
 void management_notify_client_close(struct management *management,
                                     struct man_def_auth_context *mdac, const struct env_set *es);
 
-void management_learn_addr(struct management *management, struct man_def_auth_context *mdac,
+void management_learn_addr(struct man_def_auth_context *mdac,
                            const struct mroute_addr *addr, const bool primary);
 
 void management_notify_client_cr_response(unsigned mda_key_id,
@@ -487,7 +487,7 @@
 /*
  * Echo an authentication token to management interface
  */
-void management_auth_token(struct management *man, const char *token);
+void management_auth_token(const char *token);
 
 /*
  * These functions drive the bytecount in/out counters.
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 46ff1ba..3e72b92 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1194,7 +1194,7 @@
 #ifdef ENABLE_MANAGEMENT
     if (management && owner)
     {
-        management_learn_addr(management, &mi->context.c2.mda_context, &addr, primary);
+        management_learn_addr(&mi->context.c2.mda_context, &addr, primary);
     }
 #endif
     if (primary && multi_check_push_ifconfig_extra_route(mi, addr.v4.addr))
@@ -1239,7 +1239,7 @@
 #ifdef ENABLE_MANAGEMENT
     if (management && owner)
     {
-        management_learn_addr(management, &mi->context.c2.mda_context, &addr, primary);
+        management_learn_addr(&mi->context.c2.mda_context, &addr, primary);
     }
 #endif
     if (primary && multi_check_push_ifconfig_ipv6_extra_route(mi, &addr.v6.addr))
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7a649de..25a3746 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7373,7 +7373,7 @@
 #ifdef ENABLE_MANAGEMENT
         if (management)
         {
-            management_auth_token(management, p[1]);
+            management_auth_token(p[1]);
         }
 #endif
     }
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index fa7bf1e..da2bb9f 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -179,7 +179,7 @@
 #ifdef ENABLE_MANAGEMENT
         if (management)
         {
-            management_notify(management, "info", c->sig->signal_text, m);
+            management_notify("info", c->sig->signal_text, m);
         }
 #endif
     }
@@ -215,7 +215,7 @@
 #ifdef ENABLE_MANAGEMENT
     if (management)
     {
-        management_notify(management, "info", "remote-exit", "EXIT");
+        management_notify("info", "remote-exit", "EXIT");
     }
 #endif
 }
@@ -245,7 +245,7 @@
         struct buffer out = alloc_buf_gc(256, &gc);
         if (buf_printf(&out, ">%s:%s", "INFOMSG", m))
         {
-            management_notify_generic(management, BSTR(&out));
+            management_notify_generic(BSTR(&out));
         }
         else
         {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
