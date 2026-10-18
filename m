Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6459CCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 15:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gvnlTddjQE14sF6Fk6Jp9bOqymkpRxA9E4i73ev7KdI=; b=VwUYjfn0lwyNvhh0jyfRY/Hs2C
	Y4TbNGW0j/f38FTEhMoCVxHkFByr3farzbkuJuPiuyG7Pxnc3afnSAl6sTqxrWA2/c2LkEPwk8kay
	QY2Vk1VR7xKqZGT88TMawtQQhJ5Cd/TJM4RF/aFU5jwmFkmA55Aidp2oyluF+AsgXBVs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xISp1-0005A8-Ey;
	Sun, 18 Oct 2026 15:29:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xISp0-0005A2-2n
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 15:29:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vPZ3LjQaAUVTjzqJ3zTte0kK6eJNgdQmwUx8bDqP3CY=; b=QkYl70HquGxzh/8zUHm8IDwBuH
 mU6i7X6RuYISYe4BSw/mHc5UAWmWu2L1Jxu8vZAXHKluGdWTbNtayfza521mhN6EUpvf6i41TRM4m
 JQ0IU3CLAgoqzBrU+2NHmdNzjiy31uqIOzxY5ST8jJL/F3cW1k8+zooJiarSW9WSw3FQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vPZ3LjQaAUVTjzqJ3zTte0kK6eJNgdQmwUx8bDqP3CY=; b=i44W2X9hGpRzGQJlqy9WvRK/x+
 YVjm/mrdchqXMVcC7vmVdU9CAM+wn489fyGtjT58cPdeGC+2+VDI/AvI/rse/gRyDItgVa+NAFcox
 LmxDPOKtMEGvpIWb3UvjaKnCpRYLX0NronBxTL3AmT9iSqwc+WUJnftSIfkOrlks8ykA=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xISou-0007ed-5g for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 15:29:11 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69IFT18j022602
 for <openvpn-devel@lists.sourceforge.net>; Sun, 18 Oct 2026 17:29:01 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69IFT1sr022601
 for openvpn-devel@lists.sourceforge.net; Sun, 18 Oct 2026 17:29:01 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sun, 18 Oct 2026 17:28:55 +0200
Message-ID: <20261018152900.22589-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1786968495000.I12bef330e2c8a5e5b21c2fa807584319b2b7101f@gerrit.openvpn.net>
References: <gerrit.1786968495000.I12bef330e2c8a5e5b21c2fa807584319b2b7101f@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xISou-0007ed-5g
Subject: [Openvpn-devel] [PATCH v4] Factor out address resolve code to a new
 file resolve.c
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

The code was weirdly split between socket.c, socket_util.c,
and options.c. The new structure makes more sense.

While here move some related string helper code to buffer.h.

Change-Id: I12bef330e2c8a5e5b21c2fa807584319b2b7101f
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1846
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1846
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index bac4dd4..ca443ee 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -576,6 +576,8 @@
     src/openvpn/reflect_filter.h
     src/openvpn/reliable.c
     src/openvpn/reliable.h
+    src/openvpn/resolve.c
+    src/openvpn/resolve.h
     src/openvpn/route.c
     src/openvpn/route.h
     src/openvpn/run_command.c
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 7ecddff..ae4d5ae 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -125,6 +125,7 @@
 	pushlist.h \
 	reflect_filter.c reflect_filter.h \
 	reliable.c reliable.h \
+	resolve.c resolve.h \
 	route.c route.h \
 	run_command.c run_command.h \
 	schedule.c schedule.h \
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index a90ddae..616be73 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -1088,6 +1088,23 @@
     }
 }
 
+bool
+streqnull(const char *a, const char *b)
+{
+    if (a == NULL && b == NULL)
+    {
+        return true;
+    }
+    else if (a == NULL || b == NULL)
+    {
+        return false;
+    }
+    else
+    {
+        return streq(a, b);
+    }
+}
+
 char *
 string_substitute(const char *src, char from, char to, struct gc_arena *gc)
 {
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 58e10f0..afbddf6 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -1830,6 +1830,18 @@
     return 0 == strncmp(str, prefix, strlen(prefix));
 }
 
+/** helper to work around the semantics of the strcmp() return value
+ * @return true if the strings are equal according to strcmp()
+ */
+#define streq(x, y) (!strcmp((x), (y)))
+
+/** compare two strings which might be NULL
+ * @return true if both strings are NULL, or if they are equal according to strcmp()
+ */
+bool streqnull(const char *a, const char *b);
+/** compare two strings which might be NULL, but NULL is never equal
+ * @return true if neither string is NULL and they are equal according to strcmp()
+ */
 bool string_defined_equal(const char *s1, const char *s2);
 char *string_substitute(const char *src, char from, char to, struct gc_arena *gc);
 
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index dcef924..d0d1565 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -30,6 +30,7 @@
 #include "proto.h"
 #include "socket_util.h"
 #include "memdbg.h"
+#include "resolve.h"
 
 static bool
 add_entry(struct client_nat_option_list *dest, const struct client_nat_entry *e)
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 7f4dde4..a40f3e7 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -27,7 +27,7 @@
 #include "syshead.h"
 
 #include "dns.h"
-#include "socket_util.h"
+#include "resolve.h"
 #include "options.h"
 #include "run_command.h"
 #include "domain_helper.h"
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9306a96..eccb814 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -55,6 +55,7 @@
 #include "tun_afunix.h"
 #include "schedule.h"
 #include "options_string.h"
+#include "resolve.h"
 
 #include "memdbg.h"
 
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 0aef2d4..8399fc9 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -44,6 +44,7 @@
 #include "dco.h"
 #include "push.h"
 #include "multi.h"
+#include "resolve.h"
 
 #include "memdbg.h"
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 6664c73..3bc8ee4 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -64,6 +64,7 @@
 #include "domain_helper.h"
 #include "mbuf.h"
 #include "check_file_access.h"
+#include "resolve.h"
 
 #include <ctype.h>
 
@@ -1044,26 +1045,6 @@
 
 #endif /* ifndef _WIN32 */
 
-static in_addr_t
-get_ip_addr(const char *ip_string, msglvl_t msglevel, bool *error)
-{
-    unsigned int flags = GETADDR_HOST_ORDER;
-    bool succeeded = false;
-    in_addr_t ret;
-
-    if (msglevel & M_FATAL)
-    {
-        flags |= GETADDR_FATAL;
-    }
-
-    ret = getaddr(flags, ip_string, 0, &succeeded, NULL);
-    if (!succeeded && error)
-    {
-        *error = true;
-    }
-    return ret;
-}
-
 /**
  * Returns newly allocated string containing address part without "/nn".
  *
@@ -1086,13 +1067,6 @@
     }
     return ret;
 }
-
-static bool
-ipv6_addr_safe_hexplusbits(const char *ipv6_prefix_spec)
-{
-    return get_ipv6_addr(ipv6_prefix_spec, NULL, NULL, M_WARN);
-}
-
 /**
  * Parses a hexstring and checks if the string has the correct length. Return
  * a verify_hash_list containing the parsed hash string.
@@ -3330,7 +3304,7 @@
     options_postprocess_verify(options);
 #ifndef ENABLE_SMALL
     options_postprocess_filechecks(options);
-#endif /* !ENABLE_SMALL */
+#endif
 }
 
 /*
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index d347830..fc1124a 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -724,8 +724,6 @@
     unsigned int imported_protocol_flags;
 };
 
-#define streq(x, y) (!strcmp((x), (y)))
-
 /*
  * Option classes.
  */
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index 63fc930..fff0e3f 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -31,6 +31,7 @@
 #include "error.h"
 #include "socket_util.h"
 #include "otime.h"
+#include "resolve.h"
 
 #include "memdbg.h"
 
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 08c2673..dc3465c 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -32,6 +32,7 @@
 #include "socket.h"
 #include "fdmisc.h"
 #include "crypto.h"
+#include "resolve.h"
 #include "ps.h"
 
 #include "memdbg.h"
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 0e281d2..b9da90f 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -37,6 +37,7 @@
 #include "memdbg.h"
 #include "ssl_util.h"
 #include "options_util.h"
+#include "resolve.h"
 
 /*
  * Auth username/password
diff --git a/src/openvpn/resolve.c b/src/openvpn/resolve.c
new file mode 100644
index 0000000..b8d9899
--- /dev/null
+++ b/src/openvpn/resolve.c
@@ -0,0 +1,665 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn.net>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "syshead.h"
+
+#include "buffer.h"
+#include "crypto.h"
+#include "manage.h"
+#include "openvpn.h"
+#include "socket.h"
+#include "socket_util.h"
+
+#include "resolve.h"
+
+/*
+ * Convert sockflags/getaddr_flags into getaddr_flags
+ */
+unsigned int
+sf2gaf(const unsigned int getaddr_flags, const unsigned int sockflags)
+{
+    if (sockflags & SF_HOST_RANDOMIZE)
+    {
+        return getaddr_flags | GETADDR_RANDOMIZE;
+    }
+    else
+    {
+        return getaddr_flags;
+    }
+}
+
+/*
+ * Functions related to the translation of DNS names to IP addresses.
+ */
+
+/**
+ * Small helper function for openvpn_getaddrinfo to print the address
+ * family when resolving fails
+ */
+static const char *
+getaddrinfo_addr_family_name(int af)
+{
+    switch (af)
+    {
+        case AF_INET:
+            return "[AF_INET]";
+
+        case AF_INET6:
+            return "[AF_INET6]";
+    }
+    return "";
+}
+
+/*
+ * Prepend a random string to hostname to prevent DNS caching.
+ * For example, foo.bar.gov would be modified to <random-chars>.foo.bar.gov.
+ * Of course, this requires explicit support in the DNS server (wildcard).
+ */
+static const char *
+hostname_randomize(const char *hostname, struct gc_arena *gc)
+{
+#define n_rnd_bytes 6
+
+    uint8_t rnd_bytes[n_rnd_bytes];
+    const char *rnd_str;
+    struct buffer hname = alloc_buf_gc(strlen(hostname) + sizeof(rnd_bytes) * 2 + 4, gc);
+
+    prng_bytes(rnd_bytes, sizeof(rnd_bytes));
+    rnd_str = format_hex_ex(rnd_bytes, sizeof(rnd_bytes), 40, 0, NULL, gc);
+    buf_printf(&hname, "%s.%s", rnd_str, hostname);
+    return BSTR(&hname);
+#undef n_rnd_bytes
+}
+
+/*
+ * Translate IPv4/IPv6 addr or hostname into struct addrinfo
+ * If resolve error, try again for resolve_retry_seconds seconds.
+ */
+int
+openvpn_getaddrinfo(unsigned int flags, const char *hostname, const char *servname,
+                    int resolve_retry_seconds, struct signal_info *sig_info, int ai_family,
+                    struct addrinfo **res)
+{
+    struct addrinfo hints;
+    int status;
+    struct signal_info sigrec = { 0 };
+    msglvl_t msglevel = (flags & GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERRORS;
+    struct gc_arena gc = gc_new();
+    const char *print_hostname;
+    const char *print_servname;
+
+    ASSERT(res);
+
+    ASSERT(hostname || servname);
+    ASSERT(!(flags & GETADDR_HOST_ORDER));
+
+    if (servname)
+    {
+        print_servname = servname;
+    }
+    else
+    {
+        print_servname = "";
+    }
+
+    if (flags & GETADDR_MSG_VIRT_OUT)
+    {
+        msglevel |= M_MSG_VIRT_OUT;
+    }
+
+    if ((flags & (GETADDR_FATAL_ON_SIGNAL | GETADDR_WARN_ON_SIGNAL)) && !sig_info)
+    {
+        sig_info = &sigrec;
+    }
+
+    /* try numeric ip addr first */
+    CLEAR(hints);
+    hints.ai_flags = AI_NUMERICHOST;
+
+    if (flags & GETADDR_PASSIVE)
+    {
+        hints.ai_flags |= AI_PASSIVE;
+    }
+
+    if (flags & GETADDR_DATAGRAM)
+    {
+        hints.ai_socktype = SOCK_DGRAM;
+    }
+    else
+    {
+        hints.ai_socktype = SOCK_STREAM;
+    }
+
+    /* if hostname is not set, we want to bind to 'ANY', with
+     * the correct address family - v4-only or v6/v6-dual-stack */
+    if (!hostname)
+    {
+        hints.ai_family = ai_family;
+    }
+
+    status = getaddrinfo(hostname, servname, &hints, res);
+
+    if (status != 0)                      /* parse as numeric address failed? */
+    {
+        const int fail_wait_interval = 5; /* seconds */
+        /* Add +4 to cause integer division rounding up (1 + 4) = 5, (0+4)/5=0 */
+        int resolve_retries =
+            (flags & GETADDR_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) / fail_wait_interval);
+        const char *fmt;
+        msglvl_t level = 0;
+
+        /* this is not a numeric IP, therefore force resolution using the
+         * provided ai_family */
+        hints.ai_family = ai_family;
+
+        if (hostname && (flags & GETADDR_RANDOMIZE))
+        {
+            hostname = hostname_randomize(hostname, &gc);
+        }
+
+        if (hostname)
+        {
+            print_hostname = hostname;
+        }
+        else
+        {
+            print_hostname = "undefined";
+        }
+
+        fmt = "RESOLVE: Cannot resolve host address: %s:%s%s (%s)";
+        if ((flags & GETADDR_MENTION_RESOLVE_RETRY) && !resolve_retry_seconds)
+        {
+            fmt = "RESOLVE: Cannot resolve host address: %s:%s%s (%s)"
+                  "(I would have retried this name query if you had "
+                  "specified the --resolv-retry option.)";
+        }
+
+        if (!(flags & GETADDR_RESOLVE) || status == EAI_FAIL)
+        {
+            msg(msglevel, "RESOLVE: Cannot parse IP address: %s:%s (%s)", print_hostname,
+                print_servname, gai_strerror(status));
+            goto done;
+        }
+
+#ifdef ENABLE_MANAGEMENT
+        if (flags & GETADDR_UPDATE_MANAGEMENT_STATE)
+        {
+            if (management)
+            {
+                management_set_state(management, OPENVPN_STATE_RESOLVE, NULL, NULL, NULL, NULL,
+                                     NULL);
+            }
+        }
+#endif
+
+        /*
+         * Resolve hostname
+         */
+        while (true)
+        {
+#ifndef _WIN32
+            /* force resolv.conf reload */
+            res_init();
+#endif
+            /* try hostname lookup */
+            hints.ai_flags &= ~AI_NUMERICHOST;
+            dmsg(D_SOCKET_DEBUG, "GETADDRINFO flags=0x%04x ai_family=%d ai_socktype=%d", flags,
+                 hints.ai_family, hints.ai_socktype);
+            status = getaddrinfo(hostname, servname, &hints, res);
+
+            if (sig_info)
+            {
+                get_signal(&sig_info->signal_received);
+                if (sig_info->signal_received) /* were we interrupted by a signal? */
+                {
+                    /* why are we overwriting SIGUSR1 ? */
+                    if (signal_reset(sig_info, SIGUSR1) == SIGUSR1) /* ignore SIGUSR1 */
+                    {
+                        msg(level, "RESOLVE: Ignored SIGUSR1 signal received during "
+                                   "DNS resolution attempt");
+                    }
+                    else
+                    {
+                        /* turn success into failure (interrupted syscall) */
+                        if (0 == status)
+                        {
+                            ASSERT(res);
+                            freeaddrinfo(*res);
+                            *res = NULL;
+                            status = EAI_AGAIN; /* = temporary failure */
+                            errno = EINTR;
+                        }
+                        goto done;
+                    }
+                }
+            }
+
+            /* success? */
+            if (0 == status)
+            {
+                break;
+            }
+
+            /* resolve lookup failed, should we
+             * continue or fail? */
+            level = msglevel;
+            if (resolve_retries > 0)
+            {
+                level = D_RESOLVE_ERRORS;
+            }
+
+            msg(level, fmt, print_hostname, print_servname, getaddrinfo_addr_family_name(ai_family),
+                gai_strerror(status));
+
+            if (--resolve_retries <= 0)
+            {
+                goto done;
+            }
+
+            management_sleep(fail_wait_interval);
+        }
+
+        ASSERT(res);
+
+        /* hostname resolve succeeded */
+
+        /*
+         * Do not choose an IP Addresse by random or change the order *
+         * of IP addresses, doing so will break RFC 3484 address selection *
+         */
+    }
+    else
+    {
+        /* IP address parse succeeded */
+        if (flags & GETADDR_RANDOMIZE)
+        {
+            msg(M_WARN, "WARNING: ignoring --remote-random-hostname because the "
+                        "hostname is an IP address");
+        }
+    }
+
+done:
+    if (sig_info && sig_info->signal_received)
+    {
+        msglvl_t level = 0;
+        if (flags & GETADDR_FATAL_ON_SIGNAL)
+        {
+            level = M_FATAL;
+        }
+        else if (flags & GETADDR_WARN_ON_SIGNAL)
+        {
+            level = M_WARN;
+        }
+        msg(level, "RESOLVE: signal received during DNS resolution attempt");
+    }
+
+    gc_free(&gc);
+    return status;
+}
+
+static int
+get_addr_generic(sa_family_t af, unsigned int flags, const char *hostname, void *network,
+                 unsigned int *netbits, int resolve_retry_seconds, struct signal_info *sig_info,
+                 msglvl_t msglevel)
+{
+    char *endp, *sep, *var_host = NULL;
+    struct addrinfo *ai = NULL;
+    unsigned long bits;
+    uint8_t max_bits;
+    int ret = -1;
+
+    if (!hostname)
+    {
+        msg(M_NONFATAL, "Can't resolve null hostname!");
+        goto out;
+    }
+
+    /* assign family specific default values */
+    switch (af)
+    {
+        case AF_INET:
+            bits = 0;
+            max_bits = sizeof(in_addr_t) * 8;
+            break;
+
+        case AF_INET6:
+            bits = 64;
+            max_bits = sizeof(struct in6_addr) * 8;
+            break;
+
+        default:
+            msg(M_WARN, "Unsupported AF family passed to getaddrinfo for %s (%d)", hostname, af);
+            goto out;
+    }
+
+    /* we need to modify the hostname received as input, but we don't want to
+     * touch it directly as it might be a constant string.
+     *
+     * Therefore, we clone the string here and free it at the end of the
+     * function */
+    var_host = strdup(hostname);
+    if (!var_host)
+    {
+        msg(M_NONFATAL | M_ERRNO, "Can't allocate hostname buffer for getaddrinfo");
+        goto out;
+    }
+
+    /* check if this hostname has a /bits suffix */
+    sep = strchr(var_host, '/');
+    if (sep)
+    {
+        bits = strtoul(sep + 1, &endp, 10);
+        if ((*endp != '\0') || (bits > max_bits))
+        {
+            msg(msglevel, "IP prefix '%s': invalid '/bits' spec (%s)", hostname, sep + 1);
+            goto out;
+        }
+        *sep = '\0';
+    }
+
+    ret = openvpn_getaddrinfo(flags & ~GETADDR_HOST_ORDER, var_host, NULL, resolve_retry_seconds,
+                              sig_info, af, &ai);
+    if ((ret == 0) && network)
+    {
+        struct in6_addr *ip6;
+        in_addr_t *ip4;
+
+        if (af != ai->ai_family)
+        {
+            msg(msglevel, "Can't parse %s as IPv%d address", var_host, (af == AF_INET) ? 4 : 6);
+            ret = -1;
+            goto out;
+        }
+
+        switch (af)
+        {
+            case AF_INET:
+                ip4 = network;
+                *ip4 = ((struct sockaddr_in *)ai->ai_addr)->sin_addr.s_addr;
+
+                if (flags & GETADDR_HOST_ORDER)
+                {
+                    *ip4 = ntohl(*ip4);
+                }
+                break;
+
+            case AF_INET6:
+                ip6 = network;
+                *ip6 = ((struct sockaddr_in6 *)ai->ai_addr)->sin6_addr;
+                break;
+
+            default:
+                /* can't get here because 'af' was previously checked */
+                msg(M_WARN, "Unsupported AF family for %s (%d)", var_host, af);
+                goto out;
+        }
+    }
+
+    if (netbits)
+    {
+        *netbits = (unsigned int)bits;
+    }
+
+    /* restore '/' separator, if any */
+    if (sep)
+    {
+        *sep = '/';
+    }
+out:
+    if (ai)
+    {
+        freeaddrinfo(ai);
+    }
+    free(var_host);
+
+    return ret;
+}
+
+in_addr_t
+getaddr(unsigned int flags, const char *hostname, int resolve_retry_seconds, bool *succeeded,
+        struct signal_info *sig_info)
+{
+    in_addr_t addr = { 0 };
+    int status;
+
+    status = get_addr_generic(AF_INET, flags, hostname, &addr, NULL, resolve_retry_seconds,
+                              sig_info, M_WARN);
+    if (status == 0)
+    {
+        if (succeeded)
+        {
+            *succeeded = true;
+        }
+        return addr;
+    }
+    else
+    {
+        if (succeeded)
+        {
+            *succeeded = false;
+        }
+        return 0;
+    }
+}
+
+in_addr_t
+get_ip_addr(const char *ip_string, msglvl_t msglevel, bool *error)
+{
+    unsigned int flags = GETADDR_HOST_ORDER;
+    bool succeeded = false;
+    in_addr_t ret;
+
+    if (msglevel & M_FATAL)
+    {
+        flags |= GETADDR_FATAL;
+    }
+
+    ret = getaddr(flags, ip_string, 0, &succeeded, NULL);
+    if (!succeeded && error)
+    {
+        *error = true;
+    }
+    return ret;
+}
+
+bool
+get_ipv6_addr(const char *hostname, struct in6_addr *network, unsigned int *netbits,
+              msglvl_t msglevel)
+{
+    if (get_addr_generic(AF_INET6, GETADDR_RESOLVE, hostname, network, netbits, 0, NULL, msglevel)
+        < 0)
+    {
+        return false;
+    }
+
+    return true; /* parsing OK, values set */
+}
+
+/*
+ * get_cached_dns_entry return 0 on success and -1
+ * otherwise. (like getaddrinfo)
+ */
+int
+get_cached_dns_entry(struct cached_dns_entry *dns_cache, const char *hostname, const char *servname,
+                     int ai_family, unsigned int resolve_flags, struct addrinfo **ai)
+{
+    struct cached_dns_entry *ph;
+    unsigned int flags;
+
+    /* Only use flags that are relevant for the structure */
+    flags = resolve_flags & GETADDR_CACHE_MASK;
+
+    for (ph = dns_cache; ph; ph = ph->next)
+    {
+        if (streqnull(ph->hostname, hostname) && streqnull(ph->servname, servname)
+            && ph->ai_family == ai_family && ph->flags == flags)
+        {
+            *ai = ph->ai;
+            return 0;
+        }
+    }
+    return -1;
+}
+
+
+static int
+do_preresolve_host(struct context *c, const char *hostname, const char *servname, const int af,
+                   const unsigned int flags)
+{
+    struct addrinfo *ai;
+    int status;
+
+    if (get_cached_dns_entry(c->c1.dns_cache, hostname, servname, af, flags, &ai) == 0)
+    {
+        /* entry already cached, return success */
+        return 0;
+    }
+
+    status = openvpn_getaddrinfo(flags, hostname, servname, c->options.resolve_retry_seconds, NULL,
+                                 af, &ai);
+    if (status == 0)
+    {
+        struct cached_dns_entry *ph;
+
+        ALLOC_OBJ_CLEAR_GC(ph, struct cached_dns_entry, &c->gc);
+        ph->ai = ai;
+        ph->hostname = hostname;
+        ph->servname = servname;
+        ph->flags = flags & GETADDR_CACHE_MASK;
+
+        if (!c->c1.dns_cache)
+        {
+            c->c1.dns_cache = ph;
+        }
+        else
+        {
+            struct cached_dns_entry *prev = c->c1.dns_cache;
+            while (prev->next)
+            {
+                prev = prev->next;
+            }
+            prev->next = ph;
+        }
+
+        gc_addspecial(ai, &gc_freeaddrinfo_callback, &c->gc);
+    }
+    return status;
+}
+
+void
+do_preresolve(struct context *c)
+{
+    struct connection_list *l = c->options.connection_list;
+    const unsigned int preresolve_flags = GETADDR_RESOLVE | GETADDR_UPDATE_MANAGEMENT_STATE
+                                          | GETADDR_MENTION_RESOLVE_RETRY | GETADDR_FATAL;
+
+
+    for (int i = 0; i < l->len; ++i)
+    {
+        int status;
+        const char *remote;
+        unsigned int flags = preresolve_flags;
+
+        struct connection_entry *ce = l->array[i];
+
+        if (proto_is_dgram(ce->proto))
+        {
+            flags |= GETADDR_DATAGRAM;
+        }
+
+        if (c->options.sockflags & SF_HOST_RANDOMIZE)
+        {
+            flags |= GETADDR_RANDOMIZE;
+        }
+
+        if (c->options.ip_remote_hint)
+        {
+            remote = c->options.ip_remote_hint;
+        }
+        else
+        {
+            remote = ce->remote;
+        }
+
+        /* HTTP remote hostname does not need to be resolved */
+        if (!ce->http_proxy_options)
+        {
+            status = do_preresolve_host(c, remote, ce->remote_port, ce->af, flags);
+            if (status != 0)
+            {
+                goto err;
+            }
+        }
+
+        /* Preresolve proxy */
+        if (ce->http_proxy_options)
+        {
+            status = do_preresolve_host(c, ce->http_proxy_options->server,
+                                        ce->http_proxy_options->port, ce->af, preresolve_flags);
+
+            if (status != 0)
+            {
+                goto err;
+            }
+        }
+
+        if (ce->socks_proxy_server)
+        {
+            status =
+                do_preresolve_host(c, ce->socks_proxy_server, ce->socks_proxy_port, ce->af, flags);
+            if (status != 0)
+            {
+                goto err;
+            }
+        }
+
+        if (ce->bind_local)
+        {
+            flags |= GETADDR_PASSIVE;
+            flags &= ~GETADDR_RANDOMIZE;
+
+            for (int j = 0; j < ce->local_list->len; j++)
+            {
+                const struct local_entry *le = ce->local_list->array[j];
+
+                if (!le->local)
+                {
+                    continue;
+                }
+
+                status = do_preresolve_host(c, le->local, le->port, ce->af, flags);
+                if (status != 0)
+                {
+                    goto err;
+                }
+            }
+        }
+    }
+    return;
+
+err:
+    throw_signal_soft(SIGHUP, "Preresolving failed");
+}
diff --git a/src/openvpn/resolve.h b/src/openvpn/resolve.h
new file mode 100644
index 0000000..9069af7
--- /dev/null
+++ b/src/openvpn/resolve.h
@@ -0,0 +1,106 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn.net>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
+ */
+
+/**
+ * @file
+ * DNS resolution
+ */
+#ifndef RESOLVE_H
+#define RESOLVE_H
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "syshead.h"
+
+#include "sig.h"
+
+#define GETADDR_RESOLVE                 (1u << 0)
+#define GETADDR_FATAL                   (1u << 1)
+#define GETADDR_HOST_ORDER              (1u << 2)
+#define GETADDR_MENTION_RESOLVE_RETRY   (1u << 3)
+#define GETADDR_FATAL_ON_SIGNAL         (1u << 4)
+#define GETADDR_WARN_ON_SIGNAL          (1u << 5)
+#define GETADDR_MSG_VIRT_OUT            (1u << 6)
+#define GETADDR_TRY_ONCE                (1u << 7)
+#define GETADDR_UPDATE_MANAGEMENT_STATE (1u << 8)
+#define GETADDR_RANDOMIZE               (1u << 9)
+#define GETADDR_PASSIVE                 (1u << 10)
+#define GETADDR_DATAGRAM                (1u << 11)
+
+#define GETADDR_CACHE_MASK (GETADDR_DATAGRAM | GETADDR_PASSIVE)
+
+/**
+ * Convert sockflags/getaddr_flags into getaddr_flags
+ */
+unsigned int sf2gaf(const unsigned int getaddr_flags, const unsigned int sockflags);
+
+/**
+ * Translate an IPv4 addr or hostname from string form to in_addr_t
+ *
+ * In case of resolve error, it will try again for
+ * resolve_retry_seconds seconds.
+ */
+in_addr_t getaddr(unsigned int flags, const char *hostname, int resolve_retry_seconds,
+                  bool *succeeded, struct signal_info *sig_info);
+
+in_addr_t get_ip_addr(const char *ip_string, msglvl_t msglevel, bool *error);
+
+/**
+ * Translate an IPv6 addr or hostname from string form to in6_addr
+ */
+bool get_ipv6_addr(const char *hostname, struct in6_addr *network, unsigned int *netbits,
+                   msglvl_t msglevel);
+
+static inline bool
+ipv6_addr_safe_hexplusbits(const char *ipv6_prefix_spec)
+{
+    return get_ipv6_addr(ipv6_prefix_spec, NULL, NULL, M_WARN);
+}
+
+int openvpn_getaddrinfo(unsigned int flags, const char *hostname, const char *servname,
+                        int resolve_retry_seconds, struct signal_info *sig_info, int ai_family,
+                        struct addrinfo **res);
+
+void do_preresolve(struct context *c);
+
+/* struct to hold preresolved host names */
+struct cached_dns_entry
+{
+    const char *hostname;
+    const char *servname;
+    int ai_family;
+    unsigned int flags;
+    struct addrinfo *ai;
+    struct cached_dns_entry *next;
+};
+
+/**
+ * get_cached_dns_entry return 0 on success and -1
+ * otherwise. (like getaddrinfo())
+ */
+int get_cached_dns_entry(struct cached_dns_entry *dns_cache, const char *hostname,
+                         const char *servname, int ai_family,
+                         unsigned int resolve_flags, struct addrinfo **ai);
+
+#endif /* RESOLVE_H */
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 33b2387..1077e83 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -42,6 +42,7 @@
 #include "options.h"
 #include "networking.h"
 #include "integer.h"
+#include "resolve.h"
 
 #include "memdbg.h"
 
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 33def4e..386f395 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -38,6 +38,7 @@
 #include "manage.h"
 #include "openvpn.h"
 #include "forward.h"
+#include "resolve.h"
 
 #include "memdbg.h"
 
@@ -54,366 +55,6 @@
     return false;
 }
 
-/*
- * Convert sockflags/getaddr_flags into getaddr_flags
- */
-static unsigned int
-sf2gaf(const unsigned int getaddr_flags, const unsigned int sockflags)
-{
-    if (sockflags & SF_HOST_RANDOMIZE)
-    {
-        return getaddr_flags | GETADDR_RANDOMIZE;
-    }
-    else
-    {
-        return getaddr_flags;
-    }
-}
-
-/*
- * Functions related to the translation of DNS names to IP addresses.
- */
-static int
-get_addr_generic(sa_family_t af, unsigned int flags, const char *hostname, void *network,
-                 unsigned int *netbits, int resolve_retry_seconds, struct signal_info *sig_info,
-                 msglvl_t msglevel)
-{
-    char *endp, *sep, *var_host = NULL;
-    struct addrinfo *ai = NULL;
-    unsigned long bits;
-    uint8_t max_bits;
-    int ret = -1;
-
-    if (!hostname)
-    {
-        msg(M_NONFATAL, "Can't resolve null hostname!");
-        goto out;
-    }
-
-    /* assign family specific default values */
-    switch (af)
-    {
-        case AF_INET:
-            bits = 0;
-            max_bits = sizeof(in_addr_t) * 8;
-            break;
-
-        case AF_INET6:
-            bits = 64;
-            max_bits = sizeof(struct in6_addr) * 8;
-            break;
-
-        default:
-            msg(M_WARN, "Unsupported AF family passed to getaddrinfo for %s (%d)", hostname, af);
-            goto out;
-    }
-
-    /* we need to modify the hostname received as input, but we don't want to
-     * touch it directly as it might be a constant string.
-     *
-     * Therefore, we clone the string here and free it at the end of the
-     * function */
-    var_host = strdup(hostname);
-    if (!var_host)
-    {
-        msg(M_NONFATAL | M_ERRNO, "Can't allocate hostname buffer for getaddrinfo");
-        goto out;
-    }
-
-    /* check if this hostname has a /bits suffix */
-    sep = strchr(var_host, '/');
-    if (sep)
-    {
-        bits = strtoul(sep + 1, &endp, 10);
-        if ((*endp != '\0') || (bits > max_bits))
-        {
-            msg(msglevel, "IP prefix '%s': invalid '/bits' spec (%s)", hostname, sep + 1);
-            goto out;
-        }
-        *sep = '\0';
-    }
-
-    ret = openvpn_getaddrinfo(flags & ~GETADDR_HOST_ORDER, var_host, NULL, resolve_retry_seconds,
-                              sig_info, af, &ai);
-    if ((ret == 0) && network)
-    {
-        struct in6_addr *ip6;
-        in_addr_t *ip4;
-
-        if (af != ai->ai_family)
-        {
-            msg(msglevel, "Can't parse %s as IPv%d address", var_host, (af == AF_INET) ? 4 : 6);
-            ret = -1;
-            goto out;
-        }
-
-        switch (af)
-        {
-            case AF_INET:
-                ip4 = network;
-                *ip4 = ((struct sockaddr_in *)ai->ai_addr)->sin_addr.s_addr;
-
-                if (flags & GETADDR_HOST_ORDER)
-                {
-                    *ip4 = ntohl(*ip4);
-                }
-                break;
-
-            case AF_INET6:
-                ip6 = network;
-                *ip6 = ((struct sockaddr_in6 *)ai->ai_addr)->sin6_addr;
-                break;
-
-            default:
-                /* can't get here because 'af' was previously checked */
-                msg(M_WARN, "Unsupported AF family for %s (%d)", var_host, af);
-                goto out;
-        }
-    }
-
-    if (netbits)
-    {
-        *netbits = (unsigned int)bits;
-    }
-
-    /* restore '/' separator, if any */
-    if (sep)
-    {
-        *sep = '/';
-    }
-out:
-    if (ai)
-    {
-        freeaddrinfo(ai);
-    }
-    free(var_host);
-
-    return ret;
-}
-
-in_addr_t
-getaddr(unsigned int flags, const char *hostname, int resolve_retry_seconds, bool *succeeded,
-        struct signal_info *sig_info)
-{
-    in_addr_t addr = { 0 };
-    int status;
-
-    status = get_addr_generic(AF_INET, flags, hostname, &addr, NULL, resolve_retry_seconds,
-                              sig_info, M_WARN);
-    if (status == 0)
-    {
-        if (succeeded)
-        {
-            *succeeded = true;
-        }
-        return addr;
-    }
-    else
-    {
-        if (succeeded)
-        {
-            *succeeded = false;
-        }
-        return 0;
-    }
-}
-
-bool
-get_ipv6_addr(const char *hostname, struct in6_addr *network, unsigned int *netbits,
-              msglvl_t msglevel)
-{
-    if (get_addr_generic(AF_INET6, GETADDR_RESOLVE, hostname, network, netbits, 0, NULL, msglevel)
-        < 0)
-    {
-        return false;
-    }
-
-    return true; /* parsing OK, values set */
-}
-
-static inline bool
-streqnull(const char *a, const char *b)
-{
-    if (a == NULL && b == NULL)
-    {
-        return true;
-    }
-    else if (a == NULL || b == NULL)
-    {
-        return false;
-    }
-    else
-    {
-        return streq(a, b);
-    }
-}
-
-/*
- * get_cached_dns_entry return 0 on success and -1
- * otherwise. (like getaddrinfo)
- */
-static int
-get_cached_dns_entry(struct cached_dns_entry *dns_cache, const char *hostname, const char *servname,
-                     int ai_family, unsigned int resolve_flags, struct addrinfo **ai)
-{
-    struct cached_dns_entry *ph;
-    unsigned int flags;
-
-    /* Only use flags that are relevant for the structure */
-    flags = resolve_flags & GETADDR_CACHE_MASK;
-
-    for (ph = dns_cache; ph; ph = ph->next)
-    {
-        if (streqnull(ph->hostname, hostname) && streqnull(ph->servname, servname)
-            && ph->ai_family == ai_family && ph->flags == flags)
-        {
-            *ai = ph->ai;
-            return 0;
-        }
-    }
-    return -1;
-}
-
-
-static int
-do_preresolve_host(struct context *c, const char *hostname, const char *servname, const int af,
-                   const unsigned int flags)
-{
-    struct addrinfo *ai;
-    int status;
-
-    if (get_cached_dns_entry(c->c1.dns_cache, hostname, servname, af, flags, &ai) == 0)
-    {
-        /* entry already cached, return success */
-        return 0;
-    }
-
-    status = openvpn_getaddrinfo(flags, hostname, servname, c->options.resolve_retry_seconds, NULL,
-                                 af, &ai);
-    if (status == 0)
-    {
-        struct cached_dns_entry *ph;
-
-        ALLOC_OBJ_CLEAR_GC(ph, struct cached_dns_entry, &c->gc);
-        ph->ai = ai;
-        ph->hostname = hostname;
-        ph->servname = servname;
-        ph->flags = flags & GETADDR_CACHE_MASK;
-
-        if (!c->c1.dns_cache)
-        {
-            c->c1.dns_cache = ph;
-        }
-        else
-        {
-            struct cached_dns_entry *prev = c->c1.dns_cache;
-            while (prev->next)
-            {
-                prev = prev->next;
-            }
-            prev->next = ph;
-        }
-
-        gc_addspecial(ai, &gc_freeaddrinfo_callback, &c->gc);
-    }
-    return status;
-}
-
-void
-do_preresolve(struct context *c)
-{
-    struct connection_list *l = c->options.connection_list;
-    const unsigned int preresolve_flags = GETADDR_RESOLVE | GETADDR_UPDATE_MANAGEMENT_STATE
-                                          | GETADDR_MENTION_RESOLVE_RETRY | GETADDR_FATAL;
-
-
-    for (int i = 0; i < l->len; ++i)
-    {
-        int status;
-        const char *remote;
-        unsigned int flags = preresolve_flags;
-
-        struct connection_entry *ce = l->array[i];
-
-        if (proto_is_dgram(ce->proto))
-        {
-            flags |= GETADDR_DATAGRAM;
-        }
-
-        if (c->options.sockflags & SF_HOST_RANDOMIZE)
-        {
-            flags |= GETADDR_RANDOMIZE;
-        }
-
-        if (c->options.ip_remote_hint)
-        {
-            remote = c->options.ip_remote_hint;
-        }
-        else
-        {
-            remote = ce->remote;
-        }
-
-        /* HTTP remote hostname does not need to be resolved */
-        if (!ce->http_proxy_options)
-        {
-            status = do_preresolve_host(c, remote, ce->remote_port, ce->af, flags);
-            if (status != 0)
-            {
-                goto err;
-            }
-        }
-
-        /* Preresolve proxy */
-        if (ce->http_proxy_options)
-        {
-            status = do_preresolve_host(c, ce->http_proxy_options->server,
-                                        ce->http_proxy_options->port, ce->af, preresolve_flags);
-
-            if (status != 0)
-            {
-                goto err;
-            }
-        }
-
-        if (ce->socks_proxy_server)
-        {
-            status =
-                do_preresolve_host(c, ce->socks_proxy_server, ce->socks_proxy_port, ce->af, flags);
-            if (status != 0)
-            {
-                goto err;
-            }
-        }
-
-        if (ce->bind_local)
-        {
-            flags |= GETADDR_PASSIVE;
-            flags &= ~GETADDR_RANDOMIZE;
-
-            for (int j = 0; j < ce->local_list->len; j++)
-            {
-                const struct local_entry *le = ce->local_list->array[j];
-
-                if (!le->local)
-                {
-                    continue;
-                }
-
-                status = do_preresolve_host(c, le->local, le->port, ce->af, flags);
-                if (status != 0)
-                {
-                    goto err;
-                }
-            }
-        }
-    }
-    return;
-
-err:
-    throw_signal_soft(SIGHUP, "Preresolving failed");
-}
-
 static int
 socket_get_sndbuf(socket_descriptor_t sd)
 {
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 46fa29c..bef228c 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -62,17 +62,6 @@
 /* convert a packet_size_type from network to host order */
 #define ntohps(x) ntohs(x)
 
-/* struct to hold preresolved host names */
-struct cached_dns_entry
-{
-    const char *hostname;
-    const char *servname;
-    int ai_family;
-    unsigned int flags;
-    struct addrinfo *ai;
-    struct cached_dns_entry *next;
-};
-
 /* IP addresses which are persistent across SIGUSR1s */
 struct link_socket_addr
 {
@@ -362,8 +351,6 @@
 
 void link_socket_init_phase2(struct context *c, struct link_socket *sock);
 
-void do_preresolve(struct context *c);
-
 void link_socket_close(struct link_socket *sock);
 
 #ifdef ENABLE_MANAGEMENT
diff --git a/src/openvpn/socket_util.c b/src/openvpn/socket_util.c
index 913ac69..879be73 100644
--- a/src/openvpn/socket_util.c
+++ b/src/openvpn/socket_util.c
@@ -490,271 +490,6 @@
     return ""; /* Make the compiler happy */
 }
 
-/**
- * Small helper function for openvpn_getaddrinfo to print the address
- * family when resolving fails
- */
-static const char *
-getaddrinfo_addr_family_name(int af)
-{
-    switch (af)
-    {
-        case AF_INET:
-            return "[AF_INET]";
-
-        case AF_INET6:
-            return "[AF_INET6]";
-    }
-    return "";
-}
-
-/*
- * Prepend a random string to hostname to prevent DNS caching.
- * For example, foo.bar.gov would be modified to <random-chars>.foo.bar.gov.
- * Of course, this requires explicit support in the DNS server (wildcard).
- */
-static const char *
-hostname_randomize(const char *hostname, struct gc_arena *gc)
-{
-#define n_rnd_bytes 6
-
-    uint8_t rnd_bytes[n_rnd_bytes];
-    const char *rnd_str;
-    struct buffer hname = alloc_buf_gc(strlen(hostname) + sizeof(rnd_bytes) * 2 + 4, gc);
-
-    prng_bytes(rnd_bytes, sizeof(rnd_bytes));
-    rnd_str = format_hex_ex(rnd_bytes, sizeof(rnd_bytes), 40, 0, NULL, gc);
-    buf_printf(&hname, "%s.%s", rnd_str, hostname);
-    return BSTR(&hname);
-#undef n_rnd_bytes
-}
-
-/*
- * Translate IPv4/IPv6 addr or hostname into struct addrinfo
- * If resolve error, try again for resolve_retry_seconds seconds.
- */
-int
-openvpn_getaddrinfo(unsigned int flags, const char *hostname, const char *servname,
-                    int resolve_retry_seconds, struct signal_info *sig_info, int ai_family,
-                    struct addrinfo **res)
-{
-    struct addrinfo hints;
-    int status;
-    struct signal_info sigrec = { 0 };
-    msglvl_t msglevel = (flags & GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERRORS;
-    struct gc_arena gc = gc_new();
-    const char *print_hostname;
-    const char *print_servname;
-
-    ASSERT(res);
-
-    ASSERT(hostname || servname);
-    ASSERT(!(flags & GETADDR_HOST_ORDER));
-
-    if (servname)
-    {
-        print_servname = servname;
-    }
-    else
-    {
-        print_servname = "";
-    }
-
-    if (flags & GETADDR_MSG_VIRT_OUT)
-    {
-        msglevel |= M_MSG_VIRT_OUT;
-    }
-
-    if ((flags & (GETADDR_FATAL_ON_SIGNAL | GETADDR_WARN_ON_SIGNAL)) && !sig_info)
-    {
-        sig_info = &sigrec;
-    }
-
-    /* try numeric ip addr first */
-    CLEAR(hints);
-    hints.ai_flags = AI_NUMERICHOST;
-
-    if (flags & GETADDR_PASSIVE)
-    {
-        hints.ai_flags |= AI_PASSIVE;
-    }
-
-    if (flags & GETADDR_DATAGRAM)
-    {
-        hints.ai_socktype = SOCK_DGRAM;
-    }
-    else
-    {
-        hints.ai_socktype = SOCK_STREAM;
-    }
-
-    /* if hostname is not set, we want to bind to 'ANY', with
-     * the correct address family - v4-only or v6/v6-dual-stack */
-    if (!hostname)
-    {
-        hints.ai_family = ai_family;
-    }
-
-    status = getaddrinfo(hostname, servname, &hints, res);
-
-    if (status != 0)                      /* parse as numeric address failed? */
-    {
-        const int fail_wait_interval = 5; /* seconds */
-        /* Add +4 to cause integer division rounding up (1 + 4) = 5, (0+4)/5=0 */
-        int resolve_retries =
-            (flags & GETADDR_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) / fail_wait_interval);
-        const char *fmt;
-        msglvl_t level = 0;
-
-        /* this is not a numeric IP, therefore force resolution using the
-         * provided ai_family */
-        hints.ai_family = ai_family;
-
-        if (hostname && (flags & GETADDR_RANDOMIZE))
-        {
-            hostname = hostname_randomize(hostname, &gc);
-        }
-
-        if (hostname)
-        {
-            print_hostname = hostname;
-        }
-        else
-        {
-            print_hostname = "undefined";
-        }
-
-        fmt = "RESOLVE: Cannot resolve host address: %s:%s%s (%s)";
-        if ((flags & GETADDR_MENTION_RESOLVE_RETRY) && !resolve_retry_seconds)
-        {
-            fmt = "RESOLVE: Cannot resolve host address: %s:%s%s (%s)"
-                  "(I would have retried this name query if you had "
-                  "specified the --resolv-retry option.)";
-        }
-
-        if (!(flags & GETADDR_RESOLVE) || status == EAI_FAIL)
-        {
-            msg(msglevel, "RESOLVE: Cannot parse IP address: %s:%s (%s)", print_hostname,
-                print_servname, gai_strerror(status));
-            goto done;
-        }
-
-#ifdef ENABLE_MANAGEMENT
-        if (flags & GETADDR_UPDATE_MANAGEMENT_STATE)
-        {
-            if (management)
-            {
-                management_set_state(management, OPENVPN_STATE_RESOLVE, NULL, NULL, NULL, NULL,
-                                     NULL);
-            }
-        }
-#endif
-
-        /*
-         * Resolve hostname
-         */
-        while (true)
-        {
-#ifndef _WIN32
-            /* force resolv.conf reload */
-            res_init();
-#endif
-            /* try hostname lookup */
-            hints.ai_flags &= ~AI_NUMERICHOST;
-            dmsg(D_SOCKET_DEBUG, "GETADDRINFO flags=0x%04x ai_family=%d ai_socktype=%d", flags,
-                 hints.ai_family, hints.ai_socktype);
-            status = getaddrinfo(hostname, servname, &hints, res);
-
-            if (sig_info)
-            {
-                get_signal(&sig_info->signal_received);
-                if (sig_info->signal_received) /* were we interrupted by a signal? */
-                {
-                    /* why are we overwriting SIGUSR1 ? */
-                    if (signal_reset(sig_info, SIGUSR1) == SIGUSR1) /* ignore SIGUSR1 */
-                    {
-                        msg(level, "RESOLVE: Ignored SIGUSR1 signal received during "
-                                   "DNS resolution attempt");
-                    }
-                    else
-                    {
-                        /* turn success into failure (interrupted syscall) */
-                        if (0 == status)
-                        {
-                            ASSERT(res);
-                            freeaddrinfo(*res);
-                            *res = NULL;
-                            status = EAI_AGAIN; /* = temporary failure */
-                            errno = EINTR;
-                        }
-                        goto done;
-                    }
-                }
-            }
-
-            /* success? */
-            if (0 == status)
-            {
-                break;
-            }
-
-            /* resolve lookup failed, should we
-             * continue or fail? */
-            level = msglevel;
-            if (resolve_retries > 0)
-            {
-                level = D_RESOLVE_ERRORS;
-            }
-
-            msg(level, fmt, print_hostname, print_servname, getaddrinfo_addr_family_name(ai_family),
-                gai_strerror(status));
-
-            if (--resolve_retries <= 0)
-            {
-                goto done;
-            }
-
-            management_sleep(fail_wait_interval);
-        }
-
-        ASSERT(res);
-
-        /* hostname resolve succeeded */
-
-        /*
-         * Do not choose an IP Addresse by random or change the order *
-         * of IP addresses, doing so will break RFC 3484 address selection *
-         */
-    }
-    else
-    {
-        /* IP address parse succeeded */
-        if (flags & GETADDR_RANDOMIZE)
-        {
-            msg(M_WARN, "WARNING: ignoring --remote-random-hostname because the "
-                        "hostname is an IP address");
-        }
-    }
-
-done:
-    if (sig_info && sig_info->signal_received)
-    {
-        msglvl_t level = 0;
-        if (flags & GETADDR_FATAL_ON_SIGNAL)
-        {
-            level = M_FATAL;
-        }
-        else if (flags & GETADDR_WARN_ON_SIGNAL)
-        {
-            level = M_WARN;
-        }
-        msg(level, "RESOLVE: signal received during DNS resolution attempt");
-    }
-
-    gc_free(&gc);
-    return status;
-}
-
 /*
  * We do our own inet_aton because the glibc function
  * isn't very good about error checking.
diff --git a/src/openvpn/socket_util.h b/src/openvpn/socket_util.h
index 13f5962..038ec36 100644
--- a/src/openvpn/socket_util.h
+++ b/src/openvpn/socket_util.h
@@ -110,44 +110,6 @@
 void setenv_link_socket_actual(struct env_set *es, const char *name_prefix,
                                const struct link_socket_actual *act, const unsigned int flags);
 
-/*
- * DNS resolution
- */
-
-#define GETADDR_RESOLVE                 (1u << 0)
-#define GETADDR_FATAL                   (1u << 1)
-#define GETADDR_HOST_ORDER              (1u << 2)
-#define GETADDR_MENTION_RESOLVE_RETRY   (1u << 3)
-#define GETADDR_FATAL_ON_SIGNAL         (1u << 4)
-#define GETADDR_WARN_ON_SIGNAL          (1u << 5)
-#define GETADDR_MSG_VIRT_OUT            (1u << 6)
-#define GETADDR_TRY_ONCE                (1u << 7)
-#define GETADDR_UPDATE_MANAGEMENT_STATE (1u << 8)
-#define GETADDR_RANDOMIZE               (1u << 9)
-#define GETADDR_PASSIVE                 (1u << 10)
-#define GETADDR_DATAGRAM                (1u << 11)
-
-#define GETADDR_CACHE_MASK (GETADDR_DATAGRAM | GETADDR_PASSIVE)
-
-/**
- * Translate an IPv4 addr or hostname from string form to in_addr_t
- *
- * In case of resolve error, it will try again for
- * resolve_retry_seconds seconds.
- */
-in_addr_t getaddr(unsigned int flags, const char *hostname, int resolve_retry_seconds,
-                  bool *succeeded, struct signal_info *sig_info);
-
-/**
- * Translate an IPv6 addr or hostname from string form to in6_addr
- */
-bool get_ipv6_addr(const char *hostname, struct in6_addr *network, unsigned int *netbits,
-                   msglvl_t msglevel);
-
-int openvpn_getaddrinfo(unsigned int flags, const char *hostname, const char *servname,
-                        int resolve_retry_seconds, struct signal_info *sig_info, int ai_family,
-                        struct addrinfo **res);
-
 /* return values of openvpn_inet_aton */
 #define OIA_HOSTNAME 0
 #define OIA_IP       1
@@ -301,7 +263,7 @@
 }
 #endif
 
-/*
+/**
  * Overhead added to packets by various protocols.
  */
 static inline int
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 133f670..fcde7fc 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -39,7 +39,7 @@
 #include "fdmisc.h"
 #include "common.h"
 #include "run_command.h"
-#include "socket_util.h"
+#include "resolve.h"
 #include "manage.h"
 #include "route.h"
 #include "win32.h"


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
