Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6879C606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YuVOqi/U;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dgW5po8/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Np6N+42n
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=MWvoV6U1JbMMuzHIycQikA6t/HtcROdbh9xhIGvYtmM=; b=YuVOqi/U19FNbL
	6nek8pCDLcFs01FWHhMyqiKhoUVnGv35P3PIqONRElXmWhVW77h1SXOjCqnmPyyCg0D3WAidfbS7F
	p0jTe23OdoXJzty4NDvL38PppSKyMt7VFsdL+502eNIpI9OJP6CnnDcQNeWavYrnXgUK4HktbP/iH
	3WU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRoqi-000000000QX-3zvC;
	Fri, 13 Nov 2026 10:49:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xRoqh-000000000QQ-0neu for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 10:49:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=55sxzi7a3fK1jEEWIchFVpV2xmfeIVQ602m5I9aDv60=; b=dgW5po8/WZFmeQlS9SUweh5vHx
 fBuRj/AjvYI1j2rp+F7CfzIEl2XsOiAyuE79Wjqm2mpjtRABX+LUT57e3H34HqN4Zed5hPc8jWW3M
 jU7U1FPlwpPm7YiWfXofYfScHYWtOX9ysV5GgRkU7TwldzB4wJK7tRb1R+ftgK4jn+qM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=55sxzi7a3fK1jEEWIchFVpV2xmfeIVQ602m5I9aDv60=; b=Np6N+42nhk8fbEC2VGRUnAfTYs
 E8jdTllxqZXeBqpFiBFecdg791QYrSDIyi/VGCkNOZdE80FI2lZX/mhpuuPH2s4SnTZKefQnbXz3t
 Qo/1JyA9Uo6XQ72t4VpAGIAA3DzbUw0P6S2aTpns/a7R4rd0g5im8Y0jfMk52UFyKLkM=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRoqf-000000006pe-2Nu4 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 10:49:39 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ADAnUCa025210
 for <openvpn-devel@lists.sourceforge.net>; Fri, 13 Nov 2026 11:49:30 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ADAnU3I025209
 for openvpn-devel@lists.sourceforge.net; Fri, 13 Nov 2026 11:49:30 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 13 Nov 2026 11:49:24 +0100
Message-ID: <20261113104930.25197-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794395186000.I230b3b2483e15477b179b277dc8f7c91c53fa0c0@gerrit.openvpn.net>
References: <gerrit.1794395186000.I230b3b2483e15477b179b277dc8f7c91c53fa0c0@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xRoqf-000000006pe-2Nu4
Subject: [Openvpn-devel] [PATCH v4] Extract
 tls_pre_decrypt_extract_session_id and pre_decrypt_find_session
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

These functions fulfil steps that can be easily moved to their own
functions to make tls_pre_decrypt a bit more readable.

Change-Id: I230b3b2483e15477b179b277dc8f7c91c53fa0c0
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2175
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2175
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 3ad7fe7..b96e913 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3765,6 +3765,76 @@
     return true;
 }
 
+/**
+ * Read the session form the packet buffer buf and puts it into the
+ * parameter sid.
+ *
+ * @return true if the extraction was successful, false otherwise
+ */
+static bool
+tls_pre_decrypt_extract_session_id(const struct link_socket_actual *from,
+                                   struct buffer buf, struct session_id *sid)
+{
+    /* skip op code */
+    buf_advance(&buf, 1);
+    if (!session_id_read(sid, &buf) || !session_id_defined(sid))
+    {
+        struct gc_arena gc = gc_new();
+        msg(D_TLS_ERRORS, "TLS Error: session-id not found in packet from %s",
+            print_link_socket_actual(from, &gc));
+        gc_free(&gc);
+        return false;
+    }
+    return true;
+}
+
+/**
+ *  Find session matching the session id in sid in multi.session array
+ *
+ * @return index of session in multi.session array, TM_SIZE if not found
+ *         and -1 on error
+ */
+static int
+tls_pre_decrypt_find_session(struct tls_multi *multi, const struct link_socket_actual *from,
+                             const struct session_id *sid)
+{
+    struct gc_arena gc = gc_new();
+    int i;
+    /* use session ID to match up packet with appropriate tls_session object */
+    for (i = 0; i < TM_SIZE; ++i)
+    {
+        struct tls_session *session = &multi->session[i];
+        struct key_state *ks = &session->key[KS_PRIMARY];
+
+        dmsg(
+            D_TLS_DEBUG,
+            "TLS: initial packet test, i=%d state=%s, mysid=%s, rec-sid=%s, rec-ip=%s, stored-sid=%s, stored-ip=%s",
+            i, state_name(ks->state), session_id_print(&session->session_id, &gc),
+            session_id_print(sid, &gc), print_link_socket_actual(from, &gc),
+            session_id_print(&ks->session_id_remote, &gc),
+            print_link_socket_actual(&ks->remote_addr, &gc));
+
+        if (session_id_equal(&ks->session_id_remote, sid))
+        /* found a match */
+        {
+            if (i == TM_LAME_DUCK)
+            {
+                msg(D_TLS_ERRORS, "TLS ERROR: received control packet with stale session-id=%s",
+                    session_id_print(sid, &gc));
+                i = -1;
+                goto done;
+            }
+            dmsg(D_TLS_DEBUG, "TLS: found match, session[%d], sid=%s", i,
+                 session_id_print(sid, &gc));
+            break;
+        }
+    }
+
+done:
+    gc_free(&gc);
+    return i;
+}
+
 /*
  *
  * When we are in TLS mode, this is the first routine which sees
@@ -3820,7 +3890,6 @@
     /* control channel packet */
     bool do_burst = false;
     bool new_link = false;
-    struct session_id sid; /* remote session ID */
 
     /* verify legal opcode */
     if (!tls_pre_decrypt_verify_opcode(op, multi->opt.server, from))
@@ -3834,46 +3903,16 @@
     dmsg(D_TLS_DEBUG, "TLS: control channel, op=%s, IP=%s", packet_opcode_name(op),
          print_link_socket_actual(from, &gc));
 
-    /* get remote session-id */
+    struct session_id sid; /* remote session ID */
+    if (!tls_pre_decrypt_extract_session_id(from, *buf, &sid))
     {
-        struct buffer tmp = *buf;
-        buf_advance(&tmp, 1);
-        if (!session_id_read(&sid, &tmp) || !session_id_defined(&sid))
-        {
-            msg(D_TLS_ERRORS, "TLS Error: session-id not found in packet from %s",
-                print_link_socket_actual(from, &gc));
-            goto error;
-        }
+        goto error;
     }
 
-    int i;
-    /* use session ID to match up packet with appropriate tls_session object */
-    for (i = 0; i < TM_SIZE; ++i)
+    int i = tls_pre_decrypt_find_session(multi, from, &sid);
+    if (i == -1)
     {
-        struct tls_session *session = &multi->session[i];
-        struct key_state *ks = &session->key[KS_PRIMARY];
-
-        dmsg(
-            D_TLS_DEBUG,
-            "TLS: initial packet test, i=%d state=%s, mysid=%s, rec-sid=%s, rec-ip=%s, stored-sid=%s, stored-ip=%s",
-            i, state_name(ks->state), session_id_print(&session->session_id, &gc),
-            session_id_print(&sid, &gc), print_link_socket_actual(from, &gc),
-            session_id_print(&ks->session_id_remote, &gc),
-            print_link_socket_actual(&ks->remote_addr, &gc));
-
-        if (session_id_equal(&ks->session_id_remote, &sid))
-        /* found a match */
-        {
-            if (i == TM_LAME_DUCK)
-            {
-                msg(D_TLS_ERRORS, "TLS ERROR: received control packet with stale session-id=%s",
-                    session_id_print(&sid, &gc));
-                goto error;
-            }
-            dmsg(D_TLS_DEBUG, "TLS: found match, session[%d], sid=%s", i,
-                 session_id_print(&sid, &gc));
-            break;
-        }
+        goto error;
     }
 
     /*


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
