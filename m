Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56310CCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 16:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gqOs1/PlGuAN9n6NHvvuIC/bMXJg+Lv4FTJaHR/dAWU=; b=RooblwrAqQifOZaR0aE3Y9n3zL
	I3tHfNOJPixOUTfb6Zt//mp7X5yRPUN8MAnMAHWlaZKJWJH0l5OkICpNJhwvGbTwBRHasDKHGDgRU
	7KmOIgElgQU0COoKwbusDvahDQ+2HChVL3oHZHwQxMZqDFU4r7JU00xBcPDrF6GpRxwA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xI7jB-0003Wz-3Z;
	Sat, 17 Oct 2026 16:57:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xI7j9-0003Wt-FZ
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 16:57:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uFEHU+0yueEU74GB/l/DsW+HmEk85i/P0DI7JUxHZGk=; b=XlgCPK8XcVL5g5BEJAJEuwp6Rt
 itdHkypBm0D2+adVRZCBqv1cJ8D/Q1UjsaXUjBTg8oG8/31bPm3tZjE/A4UVi+UWvfVwini861SyX
 E3AyZn4yo3gVn+V3i7ADPInyiiaReme0brkR+i3+mDiNPcHbnlOmChtcqnBFQMMVAT6o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uFEHU+0yueEU74GB/l/DsW+HmEk85i/P0DI7JUxHZGk=; b=Yj1MElHvVFN3KfJF7ykIlX8GSk
 HrJY+szy60SDZ/rf1XFYAnXDbO1wiWK/ScbJM+XHSeIYGbloV2Hg7NgxLbomWSNHRF4W7gjJIyItY
 ZRa4o3j/090joXqnUq4GE/qrG7DnPWBSQaX1Sv380y6beI+FVgPo6TIoi6o9ZmpB0O9g=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xI7j4-0006NY-N1 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 16:57:44 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69HGvZcL014554
 for <openvpn-devel@lists.sourceforge.net>; Sat, 17 Oct 2026 18:57:35 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69HGvZIv014553
 for openvpn-devel@lists.sourceforge.net; Sat, 17 Oct 2026 18:57:35 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 17 Oct 2026 18:57:29 +0200
Message-ID: <20261017165735.14540-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1791901394000.Ib1b4a9544e09506e95001609262269ab8154241e@gerrit.openvpn.net>
References: <gerrit.1791901394000.Ib1b4a9544e09506e95001609262269ab8154241e@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xI7j4-0006NY-N1
Subject: [Openvpn-devel] [PATCH v2] Replace strncpynt with strlcpy
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

Mostly a straight-forward replacement. But in a few
places I used the additional return code from strlcpy
instead of duplicating the strlen call.

Change-Id: Ib1b4a9544e09506e95001609262269ab8154241e
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1995
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1995
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index b457b6f..969f37f 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -464,7 +464,7 @@
 
     struct user_pass up;
     CLEAR(up);
-    strncpynt(up.username, multi->locked_username, sizeof(up.username));
+    strlcpy(up.username, multi->locked_username, sizeof(up.username));
 
     generate_auth_token(&up, multi);
 
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index a90ddae..cc1b300 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -257,9 +257,8 @@
     int cap = buf_forward_capacity(buf);
     if (cap > 0)
     {
-        strncpynt((char *)ptr, str, cap);
-        *(buf->data + buf->capacity - 1) = 0; /* windows vsnprintf needs this */
-        buf->len += (int)strlen((char *)ptr);
+        int str_len = (int)strlcpy((char *)ptr, str, cap);
+        buf->len += (str_len < cap) ? str_len : cap - 1;
         ret = true;
     }
     return ret;
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 58e10f0..c66ed1a 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -696,27 +696,6 @@
 }
 
 /**
- * Like \c strncpy() but always null-terminates the destination.
- *
- * Copies at most \c maxlen - 1 characters from \c src into \c dest and
- * writes a null terminator at \c dest[\c maxlen - 1].  Does nothing if
- * \c maxlen is zero.
- *
- * @param dest    Destination buffer.
- * @param src     Source string.
- * @param maxlen  Size of the destination buffer in bytes.
- */
-static inline void
-strncpynt(char *dest, const char *src, size_t maxlen)
-{
-    if (maxlen > 0)
-    {
-        strncpy(dest, src, maxlen - 1);
-        dest[maxlen - 1] = 0;
-    }
-}
-
-/**
  * Return true if the string contains at least one decimal digit.
  *
  * @param src   The null-terminated string to scan.
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 713f41e..87c9c5f 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -444,7 +444,7 @@
         .iface = { .index = tt->adapter_index, .name = "" },
         .flags = server->dnssec == DNS_SECURITY_YES ? nrpt_dnssec : 0,
     };
-    strncpynt(nrpt.iface.name, tt->actual_name, sizeof(nrpt.iface.name));
+    strlcpy(nrpt.iface.name, tt->actual_name, sizeof(nrpt.iface.name));
 
     for (size_t i = 0; i < NRPT_ADDR_NUM; ++i)
     {
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9306a96..55d985d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -393,8 +393,8 @@
                     ALLOC_OBJ_CLEAR_GC(rhs, struct remote_host_store, &c->options.gc);
                     c->options.rh_store = rhs;
                 }
-                strncpynt(rhs->host, p[2], RH_HOST_LEN);
-                strncpynt(rhs->port, p[3], RH_PORT_LEN);
+                strlcpy(rhs->host, p[2], RH_HOST_LEN);
+                strlcpy(rhs->port, p[3], RH_PORT_LEN);
 
                 ce->remote = rhs->host;
                 ce->remote_port = rhs->port;
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 55e8105..8a476e6 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -784,7 +784,7 @@
         ASSERT(man->connection.up_query_type);
         if (streq(man->connection.up_query_type, type))
         {
-            strncpynt(dest, string, len);
+            strlcpy(dest, string, len);
             man_up_finalize(man);
             msg(M_CLIENT, "SUCCESS: '%s' %s entered, but not yet verified", type, prompt);
         }
@@ -2374,7 +2374,7 @@
     }
     struct user_pass up;
     CLEAR(up);
-    strncpynt(up.username, msg, sizeof(up.username));
+    strlcpy(up.username, msg, sizeof(up.username));
 
     management_query_user_pass(management, &up, command, GET_USER_PASS_NEED_OK, (void *)0);
     return strcmp("ok", up.password) == 0;
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 0e4669a..a75bd8f 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -303,7 +303,7 @@
 
                 if (password_buf[0])
                 {
-                    strncpynt(up->password, password_buf, USER_PASS_LEN);
+                    strlcpy(up->password, password_buf, USER_PASS_LEN);
                 }
                 else
                 {
@@ -364,7 +364,7 @@
                     {
                         msg(M_FATAL, "ERROR: could not read challenge response from stdin");
                     }
-                    strncpynt(up->username, ac->user, USER_PASS_LEN);
+                    strlcpy(up->username, ac->user, USER_PASS_LEN);
                     buf_printf(&packed_resp, "CRV1::%s::%s", ac->state_id, response);
                 }
                 else
@@ -452,7 +452,7 @@
         /* Use tag for blank password if we are not prompting for one */
         if (flags & GET_USER_PASS_USERNAME_ONLY)
         {
-            strncpynt(up->password, blank_up, sizeof(up->password));
+            strlcpy(up->password, blank_up, sizeof(up->password));
         }
 
         string_mod(up->username, CC_PRINT, CC_CRLF, 0);
@@ -504,7 +504,7 @@
     if (strlen(token))
     {
         unprotect_user_pass(tk);
-        strncpynt(tk->password, token, USER_PASS_LEN);
+        strlcpy(tk->password, token, USER_PASS_LEN);
         tk->token_defined = true;
 
         /*
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index dda9232..a2b4e52 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -461,7 +461,7 @@
     const char *prefix = multi_instance_string(mi, true, &gc);
     if (prefix)
     {
-        strncpynt(mi->msg_prefix, prefix, sizeof(mi->msg_prefix));
+        strlcpy(mi->msg_prefix, prefix, sizeof(mi->msg_prefix));
     }
     else
     {
@@ -2657,7 +2657,7 @@
         {
             struct user_pass up;
             CLEAR(up);
-            strncpynt(up.username, multi->locked_username, sizeof(up.username));
+            strlcpy(up.username, multi->locked_username, sizeof(up.username));
 
             generate_auth_token(&up, multi);
         }
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index d6510bb..9f1e041 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -602,7 +602,7 @@
 
     /* save result in output variables */
     memcpy(best_gw, &res.gw, res.addr_size);
-    strncpynt(best_iface, res.iface, IFNAMSIZ);
+    strlcpy(best_iface, res.iface, IFNAMSIZ);
 err:
     return ret;
 }
@@ -1424,7 +1424,7 @@
             return -ENOENT;
         }
 
-        strncpynt(type, RTA_DATA(tb_link[IFLA_INFO_KIND]), IFACE_TYPE_LEN_MAX);
+        strlcpy(type, RTA_DATA(tb_link[IFLA_INFO_KIND]), IFACE_TYPE_LEN_MAX);
     }
 
     return 0;
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 098bdd5..49f2419 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -104,10 +104,10 @@
         curve = "(error fetching curve name)";
     }
 
-    strncpynt(gname, curve, gname_sz);
+    strlcpy(gname, curve, gname_sz);
 
-    /* strncpynt ensures null termination so just strlen is fine here */
-    *gname_len = strlen(curve);
+    /* strlcpy ensures null termination so just strlen is fine here */
+    *gname_len = strlen(gname);
     return 1;
 }
 #endif /* if OPENSSL_VERSION_NUMBER < 0x30000000L && !defined(OPENSSL_NO_EC) */
diff --git a/src/openvpn/options_string.c b/src/openvpn/options_string.c
index 88ab798..cfc0595 100644
--- a/src/openvpn/options_string.c
+++ b/src/openvpn/options_string.c
@@ -385,9 +385,9 @@
 const char *
 options_string_version(const char *s, struct gc_arena *gc)
 {
-    struct buffer out = alloc_buf_gc(4, gc);
-    strncpynt((char *)BPTR(&out), s, 3);
-    return BSTR(&out);
+    char *out = gc_malloc(3, false, gc);
+    strlcpy(out, s, 3);
+    return out;
 }
 
 #if defined(__GNUC__) || defined(__clang__)
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index d7dee97..09c8996 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -224,7 +224,7 @@
     }
     else
     {
-        strncpynt(pin, token_pass.password, pin_max);
+        strlcpy(pin, token_pass.password, pin_max);
         purge_user_pass(&token_pass, true);
 
         if (strlen(pin) == 0)
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 9209a76..60a1f5b 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2968,7 +2968,7 @@
 
     if (msg.iface.index == TUN_ADAPTER_INDEX_INVALID)
     {
-        strncpynt(msg.iface.name, tt->actual_name, sizeof(msg.iface.name));
+        strlcpy(msg.iface.name, tt->actual_name, sizeof(msg.iface.name));
     }
 
     status = do_route_service(add, &msg, sizeof(msg), tt->options.msg_channel);
@@ -3137,7 +3137,7 @@
                 addr = ntohl(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr.s_addr);
 
                 /* get interface name */
-                strncpynt(ifreq.ifr_name, ifr->ifr_name, sizeof(ifreq.ifr_name));
+                strlcpy(ifreq.ifr_name, ifr->ifr_name, sizeof(ifreq.ifr_name));
 
                 /* check that the interface is up */
                 if (ioctl(sd, SIOCGIFFLAGS, &ifreq) < 0)
@@ -3190,7 +3190,7 @@
                 }
 
                 /* save iface name */
-                strncpynt(rgi->iface, ifreq.ifr_name, sizeof(rgi->iface));
+                strlcpy(rgi->iface, ifreq.ifr_name, sizeof(rgi->iface));
                 rgi->flags |= RGI_IFACE_DEFINED;
 
                 /* now get the hardware address. */
@@ -3458,7 +3458,7 @@
 
         CLEAR(ifr);
         ifr.ifr_addr.sa_family = AF_INET;
-        strncpynt(ifr.ifr_name, rgi->iface, IFNAMSIZ);
+        strlcpy(ifr.ifr_name, rgi->iface, IFNAMSIZ);
 
         if (ioctl(sockfd, SIOCGIFNETMASK, (char *)&ifr) < 0)
         {
@@ -3487,7 +3487,7 @@
         struct ifreq ifreq = { 0 };
 
         /* now get the hardware address. */
-        strncpynt(ifreq.ifr_name, rgi->iface, sizeof(ifreq.ifr_name));
+        strlcpy(ifreq.ifr_name, rgi->iface, sizeof(ifreq.ifr_name));
         if (ioctl(sockfd, SIOCGIFHWADDR, &ifreq) < 0)
         {
             msg(M_WARN, "GDG: SIOCGIFHWADDR(%s) failed", ifreq.ifr_name);
@@ -3746,7 +3746,7 @@
         {
             rgi->gateway.addr = ntohl(((struct sockaddr_in *)route.gateway)->sin_addr.s_addr);
             rgi->flags = RGI_ADDR_DEFINED | RGI_IFACE_DEFINED;
-            strncpynt(rgi->iface, interface->ifr_name, sizeof(rgi->iface));
+            strlcpy(rgi->iface, interface->ifr_name, sizeof(rgi->iface));
         }
 
         int32 address_size = 0;
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 33def4e..0c585ad 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -3077,7 +3077,7 @@
 sockaddr_unix_init(struct sockaddr_un *local, const char *path)
 {
     local->sun_family = PF_UNIX;
-    strncpynt(local->sun_path, path, sizeof(local->sun_path));
+    strlcpy(local->sun_path, path, sizeof(local->sun_path));
 }
 
 void
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index b84da24..781a5d9 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -58,12 +58,12 @@
     ASSERT(server);
     ASSERT(port);
 
-    strncpynt(p->server, server, sizeof(p->server));
+    strlcpy(p->server, server, sizeof(p->server));
     p->port = port;
 
     if (authfile)
     {
-        strncpynt(p->authfile, authfile, sizeof(p->authfile));
+        strlcpy(p->authfile, authfile, sizeof(p->authfile));
     }
     else
     {
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index aeec020..7b61725 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -272,7 +272,7 @@
         /* prompt for password even if --askpass wasn't specified */
         pem_password_setup(NULL);
         ASSERT(!passbuf.protected);
-        strncpynt(buf, passbuf.password, (size_t)size);
+        strlcpy(buf, passbuf.password, (size_t)size);
         purge_user_pass(&passbuf, false);
 
         return (int)strlen(buf);
@@ -2228,7 +2228,7 @@
         if (session->opt->pull && up != &auth_token)
         {
             unprotect_user_pass(&auth_token);
-            strncpynt(auth_token.username, up->username, USER_PASS_LEN);
+            strlcpy(auth_token.username, up->username, USER_PASS_LEN);
             protect_user_pass(&auth_token);
         }
         protect_user_pass(up);
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 02fd556..2d0be92 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -427,15 +427,14 @@
      * historically used names with - in them. Silently convert names
      * with - to names with _ to support both
      */
-    if (strlen(ciphers) >= (len - 1))
+    size_t ciphers_len = strlcpy(openssl_ciphers, ciphers, len);
+    if (ciphers_len >= len)
     {
-        msg(M_FATAL, "Failed to set restricted TLS 1.3 cipher list, too long (>%zd).",
+        msg(M_FATAL, "Failed to set restricted TLS 1.3 cipher list, too long (>%zu).",
             len - 1);
     }
 
-    strncpynt(openssl_ciphers, ciphers, len);
-
-    for (size_t i = 0; i < strlen(openssl_ciphers); i++)
+    for (size_t i = 0; i < ciphers_len; i++)
     {
         if (openssl_ciphers[i] == '-')
         {
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 43ed980..bdcb8fc 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1640,7 +1640,7 @@
             "TLS: Replacing client provided username '%s' with "
             "username from override-user '%s'",
             up->username, multi->locked_username);
-        strncpynt(up->username, multi->locked_username, sizeof(up->username));
+        strlcpy(up->username, multi->locked_username, sizeof(up->username));
     }
 
     /*
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 6073e4e..146a384 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -157,14 +157,16 @@
                     if ((ssize_t)strlen(buf) != ASN1_STRING_length(name->d.rfc822Name))
                     {
                         msg(D_TLS_ERRORS, "ASN1 ERROR: string contained terminating zero");
-                        OPENSSL_free(buf);
+                    }
+                    else if (strlcpy(out, buf, size) >= size)
+                    {
+                        msg(D_TLS_ERRORS, "ASN1 ERROR: string too long");
                     }
                     else
                     {
-                        strncpynt(out, buf, size);
-                        OPENSSL_free(buf);
                         retval = true;
                     }
+                    OPENSSL_free(buf);
                     break;
 
                 default:
@@ -243,9 +245,7 @@
         goto exit;
     }
 
-    strncpynt(out, (char *)buf, size);
-
-    ret = (strlen((char *)buf) < size) ? SUCCESS : FAILURE;
+    ret = (strlcpy(out, (char *)buf, size) < size) ? SUCCESS : FAILURE;
 
 exit:
     OPENSSL_free(buf);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 9e7e7d7..478c109 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -127,7 +127,7 @@
 
     if (addr.iface.index == TUN_ADAPTER_INDEX_INVALID)
     {
-        strncpynt(addr.iface.name, tt->actual_name, sizeof(addr.iface.name));
+        strlcpy(addr.iface.name, tt->actual_name, sizeof(addr.iface.name));
     }
 
     if (addr.family == AF_INET)
@@ -188,12 +188,12 @@
     };
 
     /* interface name is required */
-    strncpynt(dns.iface.name, tt->actual_name, sizeof(dns.iface.name));
+    strlcpy(dns.iface.name, tt->actual_name, sizeof(dns.iface.name));
 
     /* only use domain when there are no search domains */
     if (o->domain && !o->domain_search_list[0])
     {
-        strncpynt(dns.domains, o->domain, sizeof(dns.domains));
+        strlcpy(dns.domains, o->domain, sizeof(dns.domains));
     }
 
     /* Create a comma separated list of search domains */
@@ -260,7 +260,7 @@
                               .addr_len = addr_len };
 
     /* interface name is required */
-    strncpynt(dns.iface.name, tt->actual_name, sizeof(dns.iface.name));
+    strlcpy(dns.iface.name, tt->actual_name, sizeof(dns.iface.name));
 
     if (addr_len > _countof(dns.addr))
     {
@@ -324,7 +324,7 @@
                                 .addr_len = addr_len };
 
     /* interface name is required */
-    strncpynt(wins.iface.name, tt->actual_name, sizeof(wins.iface.name));
+    strlcpy(wins.iface.name, tt->actual_name, sizeof(wins.iface.name));
 
     if (addr_len > _countof(wins.addr))
     {
@@ -372,7 +372,7 @@
                                   .iface = { .index = tt->adapter_index },
                                   .mtu = mtu,
                                   .family = family };
-    strncpynt(mtu_msg.iface.name, tt->actual_name, sizeof(mtu_msg.iface.name));
+    strlcpy(mtu_msg.iface.name, tt->actual_name, sizeof(mtu_msg.iface.name));
     if (family == AF_INET6 && mtu < 1280)
     {
         msg(M_INFO,
@@ -2119,7 +2119,7 @@
          */
         if (strcmp(dev, "tun") && strcmp(dev, "tap"))
         {
-            strncpynt(ifr.ifr_name, dev, IFNAMSIZ);
+            strlcpy(ifr.ifr_name, dev, IFNAMSIZ);
         }
 
         /*
@@ -2145,7 +2145,7 @@
             if ((ctl_fd = socket(AF_INET, SOCK_DGRAM, 0)) >= 0)
             {
                 CLEAR(netifr);
-                strncpynt(netifr.ifr_name, ifr.ifr_name, IFNAMSIZ);
+                strlcpy(netifr.ifr_name, ifr.ifr_name, IFNAMSIZ);
                 netifr.ifr_qlen = tt->options.txqueuelen;
                 if (ioctl(ctl_fd, SIOCSIFTXQLEN, (void *)&netifr) >= 0)
                 {
@@ -2401,7 +2401,7 @@
         {
             msg(M_ERR, "Can't get flags");
         }
-        strncpynt(ifr.lifr_name, tt->actual_name, sizeof(ifr.lifr_name));
+        strlcpy(ifr.lifr_name, tt->actual_name, sizeof(ifr.lifr_name));
         ifr.lifr_ppa = ppa;
         /* Assign ppa according to the unit number returned by tun device */
         if (ioctl(if_fd, SIOCSLIFNAME, &ifr) < 0)
@@ -2469,7 +2469,7 @@
     }
 
     CLEAR(ifr);
-    strncpynt(ifr.lifr_name, tt->actual_name, sizeof(ifr.lifr_name));
+    strlcpy(ifr.lifr_name, tt->actual_name, sizeof(ifr.lifr_name));
     ifr.lifr_ip_muxid = ip_muxid;
     if (tt->type == DEV_TYPE_TAP)
     {
@@ -2510,7 +2510,7 @@
     {
         struct lifreq ifr;
         CLEAR(ifr);
-        strncpynt(ifr.lifr_name, tt->actual_name, sizeof(ifr.lifr_name));
+        strlcpy(ifr.lifr_name, tt->actual_name, sizeof(ifr.lifr_name));
 
         if (ioctl(tt->ip_fd, SIOCGLIFFLAGS, &ifr) < 0)
         {
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index 69be67a..1149c7b 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -198,7 +198,7 @@
     {
         if (!strcmp(alg.op, "Sign"))
         {
-            strncpynt(alg_str, "ECDSA", sizeof(alg_str));
+            strlcpy(alg_str, "ECDSA", sizeof(alg_str));
         }
         else
         {
@@ -207,7 +207,7 @@
     }
     else if (!strcmp(alg.keytype, "ED448") || !strcmp(alg.keytype, "ED25519"))
     {
-        strncpynt(alg_str, alg.keytype, sizeof(alg_str));
+        strlcpy(alg_str, alg.keytype, sizeof(alg_str));
     }
     /* else assume RSA key */
     else if (!strcmp(alg.padmode, "pkcs1") && (flags & MF_EXTERNAL_KEY_PKCS1PAD))
@@ -221,7 +221,7 @@
             }
             tbs = enc;
             tbslen = enc_len;
-            strncpynt(alg_str, "RSA_PKCS1_PADDING", sizeof(alg_str));
+            strlcpy(alg_str, "RSA_PKCS1_PADDING", sizeof(alg_str));
         }
         /* For undigested message, add hashalg=digest parameter */
         else
@@ -232,7 +232,7 @@
     else if (!strcmp(alg.padmode, "none") && (flags & MF_EXTERNAL_KEY_NOPADDING)
              && !strcmp(alg.op, "Sign")) /* NO_PADDING requires digested data */
     {
-        strncpynt(alg_str, "RSA_NO_PADDING", sizeof(alg_str));
+        strlcpy(alg_str, "RSA_NO_PADDING", sizeof(alg_str));
     }
     else if (!strcmp(alg.padmode, "pss") && (flags & MF_EXTERNAL_KEY_PSSPAD))
     {
diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/openvpn/test_auth_token.c
index 89c418e..3a3bfb4 100644
--- a/tests/unit_tests/openvpn/test_auth_token.c
+++ b/tests/unit_tests/openvpn/test_auth_token.c
@@ -273,7 +273,7 @@
     }
     else if (streq(name, "session_id"))
     {
-        strncpynt(last_session_id_value, value, sizeof(last_session_id_value));
+        strlcpy(last_session_id_value, value, sizeof(last_session_id_value));
     }
 }
 
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/openvpn/test_pkcs11.c
index a54c504..3351eac 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -164,7 +164,7 @@
     if (!strcmp(prefix, "pkcs11-id-request") && flags & GET_USER_PASS_NEED_STR)
     {
         assert_true(pkcs11_id_management);
-        strncpynt(up->password, pkcs11_id_current, sizeof(up->password));
+        strlcpy(up->password, pkcs11_id_current, sizeof(up->password));
     }
     else if (flags & GET_USER_PASS_PASSWORD_ONLY)
     {
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c
index 5ad4730..d1b4c97 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -53,7 +53,7 @@
     for (int i = 0; i < QUERY_USER_NUMSLOTS && query_user[i].response != NULL; i++)
     {
         check_expected_ptr(query_user[i].prompt);
-        strncpynt(query_user[i].response, mock_ptr_type(char *), query_user[i].response_len);
+        strlcpy(query_user[i].response, mock_ptr_type(char *), query_user[i].response_len);
     }
 
     return mock();


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
