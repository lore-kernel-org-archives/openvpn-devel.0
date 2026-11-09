Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26141606D801
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=K0g1opqR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=nH5dfR7O;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RM6wGJPl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=xfliC8xNf9rzMXa+AUPbGeEstNbTQd37i2MsCSjUg04=; b=K0g1opqR2/CKcD
	9KIhPvYboAr7EnR3+VayApK4UAk5cgm201h6k4HdhIjgGsVvFdzpvT2OSOLRNqzkZ0wF6M2m+Dyii
	W0u5Ru+2pSv7j4XR33s9aBj1xANWPrndoqWzu8JDHgDB28iUana22L1Ms8bW3OwjFSciSdzBjwoN4
	ri8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQOle-000000005uv-2BVm;
	Mon, 09 Nov 2026 12:46:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xQOld-000000005uk-2lKx for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 12:46:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ac7EeguizYITJNTaPCnV4k04T0fAzTB5OL4bO6Exhwk=; b=nH5dfR7OxWOwt+VnwFlURpI7ej
 LbA+ja0PDWZmGqwDa2LDAvcyHhEtxjKov2/aMhcwXf0TiLw7kM1Q9ONlv9H0iXHC6YRmghTvjMzOY
 7CYkJPGtv1wQnC5SWdqRRqfz3JjBdjgBCvTZ/JzUimIRXKoV0/QpEFihkC9xk6ony6d8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ac7EeguizYITJNTaPCnV4k04T0fAzTB5OL4bO6Exhwk=; b=RM6wGJPlMuVZxaGTAoR1Pcdk+H
 XPxJY341Ef0mg31X2H+BIW8on2bNTRa+xgnbgV0iX5JwJS9zDISzMB0MKmkQ7gyG6tA4cEOqKgHMa
 WpQz8EyGgvVkk5zQBYZRAjYlQwYuF9TbZjYVbDmp+LMf2i+kO+6y6mHCOg+jlkEvz9Ik=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQOlc-000000006Xt-0lFx for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 12:46:33 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A9CkOKS026729
 for <openvpn-devel@lists.sourceforge.net>; Mon, 9 Nov 2026 13:46:24 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A9CkOVD026728
 for openvpn-devel@lists.sourceforge.net; Mon, 9 Nov 2026 13:46:24 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  9 Nov 2026 13:46:18 +0100
Message-ID: <20261109124623.26716-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794064434000.Iefcc3cb90f3e6b036a584a74268678dbc17da69f@gerrit.openvpn.net>
References: <gerrit.1794064434000.Iefcc3cb90f3e6b036a584a74268678dbc17da69f@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xQOlc-000000006Xt-0lFx
Subject: [Openvpn-devel] [PATCH v1] Remove unused gc_arena variables
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

These functions create and free a gc_arena they never allocate from.

Change-Id: Iefcc3cb90f3e6b036a584a74268678dbc17da69f
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2149
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2149
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index ff3bfe5..3bc4de4 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -117,8 +117,6 @@
             const char *ifconfig_remote, const char *context, const char *signal_text,
             const char *script_type, struct env_set *es)
 {
-    struct gc_arena gc = gc_new();
-
     if (signal_text)
     {
         setenv_str(es, "signal", signal_text);
@@ -174,8 +172,6 @@
         openvpn_run_script(&argv, es, S_FATAL, "--up/--down");
         argv_free(&argv);
     }
-
-    gc_free(&gc);
 }
 
 /*
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 58f63e6..3410253 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2325,9 +2325,7 @@
 
     if (!ignore_sys_error(err, crt_error))
     {
-        struct gc_arena gc = gc_new();
         msg(D_MANAGEMENT, "MANAGEMENT: TCP %s error: %s", prefix, strerror(err));
-        gc_free(&gc);
         return true;
     }
     else
@@ -3151,11 +3149,8 @@
 management_notify_client_cr_response(unsigned mda_key_id, const struct man_def_auth_context *mdac,
                                      const struct env_set *es, const char *response)
 {
-    struct gc_arena gc;
     if (management)
     {
-        gc = gc_new();
-
         msg(M_CLIENT, ">CLIENT:CR_RESPONSE,%lu,%u,%s", mdac->cid, mda_key_id, response);
         man_output_extra_env(management, "CLIENT");
         if (management->connection.env_filter_level > 0)
@@ -3163,7 +3158,6 @@
             man_output_peer_info_env(management, mdac);
         }
         man_output_env(es, true, management->connection.env_filter_level, "CLIENT");
-        gc_free(&gc);
     }
 }
 
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 3f514d6..3e25a6e 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -726,7 +726,6 @@
 multi_create_instance(struct multi_context *m, const struct mroute_addr *real,
                       struct link_socket *sock)
 {
-    struct gc_arena gc = gc_new();
     struct multi_instance *mi;
 
     msg(D_MULTI_MEDIUM, "MULTI: multi_create_instance called");
@@ -792,12 +791,10 @@
     mi->ev_arg.type = EVENT_ARG_MULTI_INSTANCE;
     mi->ev_arg.u.mi = mi;
 
-    gc_free(&gc);
     return mi;
 
 err:
     multi_close_instance(m, mi, false);
-    gc_free(&gc);
     return NULL;
 }
 
@@ -2243,7 +2240,6 @@
     if (mi->context.options.client_connect_script)
     {
         struct argv argv = argv_new();
-        struct gc_arena gc = gc_new();
 
         setenv_str(mi->context.c2.es, "script_type", "client-connect");
 
@@ -2279,7 +2275,6 @@
             ccs_delete_deferred_ret_file(mi);
         }
         argv_free(&argv);
-        gc_free(&gc);
     }
     return ret;
 }
diff --git a/src/openvpn/options_string.c b/src/openvpn/options_string.c
index cfc0595..ed4d742 100644
--- a/src/openvpn/options_string.c
+++ b/src/openvpn/options_string.c
@@ -344,7 +344,6 @@
 bool
 options_cmp_equal_safe(char *actual, const char *expected, size_t actual_n)
 {
-    struct gc_arena gc = gc_new();
     bool ret = true;
 
     if (actual_n > 0)
@@ -360,7 +359,6 @@
             ret = !strcmp(actual, expected);
         }
     }
-    gc_free(&gc);
     return ret;
 }
 
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 08461b8..d1f228e 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -560,7 +560,6 @@
 
     if (p->plugin_handle && (p->plugin_type_mask & OPENVPN_PLUGIN_MASK(type)))
     {
-        struct gc_arena gc = gc_new();
         struct argv a = argv_insert_head(av, p->so_pathname);
 
         dmsg(D_PLUGIN_DEBUG, "PLUGIN_CALL: PRE type=%s", plugin_type_name(type));
@@ -609,7 +608,6 @@
         }
 
         argv_free(&a);
-        gc_free(&gc);
     }
     return status;
 }
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 53550c4..d0d26c6 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3090,7 +3090,6 @@
 void
 get_default_gateway(struct route_gateway_info *rgi, in_addr_t dest, openvpn_net_ctx_t *ctx)
 {
-    struct gc_arena gc = gc_new();
     int sd = -1;
     char best_name[IFNAMSIZ];
 
@@ -3216,7 +3215,6 @@
     {
         close(sd);
     }
-    gc_free(&gc);
 }
 
 /* IPv6 implementation using netlink
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 307b5c6..1fbd07b 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -499,7 +499,6 @@
                      const struct addrinfo *local, bool do_listen,
                      bool nowait, volatile int *signal_received)
 {
-    struct gc_arena gc = gc_new();
     socket_descriptor_t new_sd = SOCKET_UNDEFINED;
 
     CLEAR(*act);
@@ -521,7 +520,6 @@
         get_signal(signal_received);
         if (*signal_received)
         {
-            gc_free(&gc);
             return sd;
         }
 
@@ -552,7 +550,6 @@
 
     tcp_connection_established(act);
 
-    gc_free(&gc);
     return new_sd;
 }
 
@@ -803,8 +800,6 @@
 static void
 resolve_bind_local(struct link_socket *sock)
 {
-    struct gc_arena gc = gc_new();
-
     /* resolve local address if undefined */
     if (!sock->info.lsa->bind_local)
     {
@@ -846,8 +841,6 @@
             sock->info.af = (sa_family_t)sock->info.lsa->bind_local->ai_family;
         }
     }
-
-    gc_free(&gc);
 }
 
 static void
@@ -2673,7 +2666,6 @@
 void
 socket_bind_unix(socket_descriptor_t sd, struct sockaddr_un *local, const char *prefix)
 {
-    struct gc_arena gc = gc_new();
     const mode_t orig_umask = umask(0);
 
     if (bind(sd, (struct sockaddr *)local, sizeof(struct sockaddr_un)))
@@ -2683,7 +2675,6 @@
     }
 
     umask(orig_umask);
-    gc_free(&gc);
 }
 
 socket_descriptor_t
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 943ad9f..bcea331 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -666,7 +666,6 @@
 void
 warn_on_use_of_common_subnets(openvpn_net_ctx_t *ctx)
 {
-    struct gc_arena gc = gc_new();
     struct route_gateway_info rgi;
     const unsigned int needed = (RGI_ADDR_DEFINED | RGI_NETMASK_DEFINED);
 
@@ -680,7 +679,6 @@
                 "NOTE: your local LAN uses the extremely common subnet address 192.168.0.x or 192.168.1.x.  Be aware that this might create routing conflicts if you connect to the VPN server from public locations such as internet cafes that use the same subnet.");
         }
     }
-    gc_free(&gc);
 }
 
 /*


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
