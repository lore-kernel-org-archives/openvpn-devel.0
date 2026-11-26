Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A67606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Fz0GWbtX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iokUfRkL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NSZG6Fnm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=5ZV502vdlL7RfDTAVi0NgDX/WC4XL5jiTEU9CL2qbu4=; b=Fz0GWbtXNi1g0D
	2Du2dtSWmjBeo7Swbc5s8f3bBXoqAS+EhIK+4TZ/PIbAMbsW2zoPHqaKpxmGmzi8Vkaa4ZlhaOIo2
	bT4LNc12dNjpk3IMga6PUfj6HM4929BlsSZfxuxvbh5i3zPM1dLmSgHfpHtaSwDBr2dZrSCNOZMv5
	03o=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWWYu-0000000088H-349Z;
	Thu, 26 Nov 2026 10:18:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xWWYs-00000000884-43Py for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 10:18:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q+LbVsMMFyXjPwvGbOWNT+cfATMXhT7pmFK2GW2LF0U=; b=iokUfRkL/dUBpmGRdEEheK0O2b
 6iYu6+uvScARv2LDjTBGWJFSV6x84pAs4C3fiOs1bgi51H4v/dxm+0CUR9lHurgz6En2AJi92gPwH
 b3N66UfZcE0HqdNBsPSvnQx45GQgHX0gIEz+9v8SfH94LS3hmrLUXfW9V1jrn6+zqadY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q+LbVsMMFyXjPwvGbOWNT+cfATMXhT7pmFK2GW2LF0U=; b=NSZG6FnmWn7epkXvwZB4+g7OyV
 gTkTsYzVpT8h2txIhHUhd8nZE0Y1OoPeD7zLJFbVuExcoOMueI7IwfY50NKGA3d3trmUvr5OKy3d9
 StChnDKHI4Kes9k8a0IbaRaIOio/S1lZk5a8/AkK8XKfqcxbRfZbxgKqbLVp/UxVgMlw=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWWYp-000000003Kh-3mos for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 10:18:42 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AQAIX2F029147
 for <openvpn-devel@lists.sourceforge.net>; Thu, 26 Nov 2026 11:18:33 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AQAIXwi029143
 for openvpn-devel@lists.sourceforge.net; Thu, 26 Nov 2026 11:18:33 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 26 Nov 2026 11:18:26 +0100
Message-ID: <20261126101832.29100-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795675637000.I5847d602a024044d9109f521de7885d55d28a968@gerrit.openvpn.net>
References: <gerrit.1795675637000.I5847d602a024044d9109f521de7885d55d28a968@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xWWYp-000000003Kh-3mos
Subject: [Openvpn-devel] [PATCH v2] dns: restrict dns var names and values
 in the updown runner
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

From: Heiko Hund <heiko@ist.eigentlich.net>

The updown runner hands the vars it gets from the unprivileged process
to a root script. Only accept what openvpn itself would send, so that a
compromised process cannot affect the script beyond its DNS settings.

Change-Id: I5847d602a024044d9109f521de7885d55d28a968
Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2349
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2349
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 1bd6c85..d00165a1 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -591,10 +591,155 @@
 #define DNS_VARS_MAX_SIZE (64 * 1024)
 
 /**
+ * Check if a dns var name equals a given name
+ *
+ * @param  name     variable name, not NUL terminated
+ * @param  size     size of the name in bytes
+ * @param  expected NUL terminated name to compare with
+ *
+ * @return bool to indicate if the names are equal
+ */
+static bool
+dns_var_name_is(const char *name, size_t size, const char *expected)
+{
+    return size == strlen(expected) && memcmp(name, expected, size) == 0;
+}
+
+/**
+ * Check if a dns var name is allowed
+ *
+ * Besides dev and script_type, only names starting with dns_ and made of
+ * lowercase letters, digits and underscores are allowed.
+ *
+ * @param  name     variable name, not NUL terminated
+ * @param  size     size of the name in bytes
+ *
+ * @return bool to indicate if the name is valid
+ */
+static bool
+dns_var_name_valid(const char *name, size_t size)
+{
+    const char prefix[] = "dns_";
+
+    if (dns_var_name_is(name, size, "dev") || dns_var_name_is(name, size, "script_type"))
+    {
+        return true;
+    }
+
+    if (size < sizeof(prefix) || strncmp(name, prefix, sizeof(prefix) - 1) != 0)
+    {
+        return false;
+    }
+
+    for (size_t i = 0; i < size; ++i)
+    {
+        const char c = name[i];
+        if (!((c >= 'a' && c <= 'z') || (c >= '0' && c <= '9') || c == '_'))
+        {
+            return false;
+        }
+    }
+
+    return true;
+}
+
+/**
+ * Check if a dns var value contains only allowed characters
+ *
+ * Values are domain names, IP addresses, port numbers or keywords, so
+ * domain name characters and colons are allowed. A value must not start
+ * with a dash, so that it cannot be taken for an option.
+ *
+ * @param  value    variable value, not NUL terminated
+ * @param  size     size of the value in bytes
+ *
+ * @return bool to indicate if the value is valid
+ */
+static bool
+dns_var_value_valid(const char *value, size_t size)
+{
+    if (size > 0 && value[0] == '-')
+    {
+        return false;
+    }
+
+    for (size_t i = 0; i < size; ++i)
+    {
+        const unsigned char c = (unsigned char)value[i];
+        if (!is_allowed_domain_ascii(c) && c != ':')
+        {
+            return false;
+        }
+    }
+
+    return true;
+}
+
+/**
+ * Check if a dev value contains only allowed characters
+ *
+ * Interface names may contain more than domain name characters, so a few
+ * characters without special meaning to the shell are allowed as well. A
+ * name must not start with a dash, so that it cannot be taken for an option.
+ *
+ * @param  value    interface name, not NUL terminated
+ * @param  size     size of the name in bytes
+ *
+ * @return bool to indicate if the value is valid
+ */
+static bool
+dns_var_dev_valid(const char *value, size_t size)
+{
+    const char extra[] = "+@%,=";
+
+    if (size == 0 || size >= IFNAMSIZ || value[0] == '-')
+    {
+        return false;
+    }
+
+    for (size_t i = 0; i < size; ++i)
+    {
+        const unsigned char c = (unsigned char)value[i];
+        if (!is_allowed_domain_ascii(c) && !memchr(extra, c, sizeof(extra) - 1))
+        {
+            return false;
+        }
+    }
+
+    return true;
+}
+
+/**
+ * Check if a dns var has an allowed name and value
+ *
+ * @param  name         variable name, not NUL terminated
+ * @param  name_size    size of the name in bytes
+ * @param  value        variable value, not NUL terminated
+ * @param  value_size   size of the value in bytes
+ *
+ * @return bool to indicate if the var is valid
+ */
+static bool
+dns_var_valid(const char *name, size_t name_size, const char *value, size_t value_size)
+{
+    if (!dns_var_name_valid(name, name_size))
+    {
+        return false;
+    }
+
+    if (dns_var_name_is(name, name_size, "dev"))
+    {
+        return dns_var_dev_valid(value, value_size);
+    }
+
+    return dns_var_value_valid(value, value_size);
+}
+
+/**
  * Add dns vars received by the updown runner to an env set
  *
- * Every var must be a name=value pair. If anything is invalid, the vars
- * are rejected as a whole.
+ * Every var must be a name=value pair with a valid name and value. If
+ * anything is invalid, the vars are rejected as a whole.
  *
  * @param  vars     NUL terminated name=value strings, modified in place
  * @param  size     size of @p vars in bytes
@@ -617,7 +762,8 @@
         const size_t var_size = strlen(var);
         char *next = var + var_size + 1;
         char *eq = memchr(var, '=', var_size);
-        if (!eq)
+        if (!eq
+            || !dns_var_valid(var, (size_t)(eq - var), eq + 1, var_size - (size_t)(eq - var) - 1))
         {
             return false;
         }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
