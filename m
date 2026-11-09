Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC882606EE92
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SwZnZ1/g;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NAZqX1cR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eLKPaRdn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=/n7i1ChTVoMXHOFtevygawvNalmJvvCIUfiKMG6nfTI=; b=SwZnZ1/gqxXsPe
	7mhfRaHd3WZ8zZcCdqwq/YtTCs2ibNdCdt9wFb9o9kYj1rdWyJJRMY3dMw1Z1awqBFfPdj3WPCsTY
	1WvIxeqfH9RUjxVSOKmX9oI+nsedVwsJPg/gOAIAYXqRgbJslIg2uh6iRzN3k12RyrV/zfLrf2Dux
	c3M=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQRf1-000000007J8-0uEa;
	Mon, 09 Nov 2026 15:51:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xQRez-000000007J0-2fCr for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:51:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ltq9jUF1EELYQB3cqHKYSwSRUpLFhL6sGXcrfGvlALk=; b=NAZqX1cRW0+9nqBKMeioWICvdk
 BuaeLe0Do1oRiLNcfwRSpVE5bfrkvt8iZWlyy9RA9uO0iVIPYqFDzvO/lalzKtl82km7Pd6tCCGtk
 66zONNl55qcMttT8CdJeN96Db9E9yquVc3pDEmCiqAsUQgupaOXfTols2HQ5n0O26Pb0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ltq9jUF1EELYQB3cqHKYSwSRUpLFhL6sGXcrfGvlALk=; b=eLKPaRdncGz7QkM4i6QerDakBp
 QQ4U3KM6xUlycECtjuRuhRoQ8dhZ3oya2W07hKzj/cKcOVDUldYOQYIyJrcaeHSNkaWccqCoHf0Ea
 qXrLMpjmOO93nVBiQh0GQHW0/kOb5AygMBl1plhqWdxGv7+dTy1AEZlKQZBIKS6eGbYM=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQRex-000000001aV-1Ye9 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:51:52 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A9Fpico012926
 for <openvpn-devel@lists.sourceforge.net>; Mon, 9 Nov 2026 16:51:44 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A9Fpin6012925
 for openvpn-devel@lists.sourceforge.net; Mon, 9 Nov 2026 16:51:44 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  9 Nov 2026 16:51:37 +0100
Message-ID: <20261109155143.12908-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794059437000.I09e55085cde6dbc0040e111a42128527d59832b8@gerrit.openvpn.net>
References: <gerrit.1794059437000.I09e55085cde6dbc0040e111a42128527d59832b8@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xQRex-000000001aV-1Ye9
Subject: [Openvpn-devel] [PATCH v5] Implement multiline responses for
 pkcs11-id commands
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

From: Marvin Wunderlich <opdopiopi@gmail.com>

Responses to the management interface commands pkcs11-id-[get|count] did
not follow the standard syntax, but instead looked like notifications.

Introduce a new management interface version so that clients announcing
versions >= 7 will receive responses in the new format while keeping
compatibility for older client versions.

If a client announces a management version >= 7 the responses conform to
the common multiline + END syntax. At the same time, it is now possible
to query all PKCS#11 ids using "all" or a range from "start" to
"end" - 1. Failures to retrieve an id will return a partial response
terminated by an "ERROR" message including the erroneous index.
The response format for pkcs11-id-get was changed to return a comma
separated list (index,id,cert_blob) which is easier to parse.

Change-Id: I09e55085cde6dbc0040e111a42128527d59832b8
Signed-off-by: Marvin Wunderlich <opidopiopi@gmail.com>
Acked-by: Selva Nair <selva.nair@gmail.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2148
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2148
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Selva Nair <selva.nair@gmail.com>

        
diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 6c798c0..42ea644 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -617,23 +617,109 @@
 COMMAND -- pkcs11-id-count  (OpenVPN 2.1 or higher)
 ---------------------------------------------------
 
-Retrieve available number of certificates.
+Retrieve available number of PKCS#11 certificates.
+
+For management client versions <7:
+
+     pkcs11-id-count
+
+The reply is ">PKCS11ID-COUNT:<count>".
 
 Example:
 
      pkcs11-id-count
      >PKCS11ID-COUNT:5
 
+For management client versions >= 7:
+
+     pkcs11-id-count
+
+The reply is a decimal count followed by "END" on a separate line.
+
+Example:
+
+     pkcs11-id-count
+     5
+     END
+
 COMMAND -- pkcs11-id-get  (OpenVPN 2.1 or higher)
 -------------------------------------------------
 
+Retrieve PKCS#11 certificates.
+
+For management client versions < 7:
+
+  pkcs11-id-get <index>
+
 Retrieve certificate by index, the ID string should be provided
 as PKCS#11 identity, the blob is a base 64 encoded certificate.
 
 Example:
 
      pkcs11-id-get 1
-     PKCS11ID-ENTRY:'1', ID:'<snip>', BLOB:'<snip>'
+     >PKCS11ID-ENTRY:'1', ID:'<id>', BLOB:'<blob>'
+
+For management client versions >= 7:
+
+  pkcs11-id-get <index>
+  pkcs11-id-get <start> <end>
+  pkcs11-id-get all
+
+Retrieve a single PKCS#11 certificate at index <index> or multiple
+PKCS#11 certificates from index <start> to <end>-1. Alternatively
+<start> = "all" retrieves all PKCS#11 certificates. A comma separated
+list including index, PKCS#11 id and the base 64 encoded certificate
+will be returned. If any id retrieval results in a failure, the returned
+list will be partial and terminated by "ERROR: .." instead of "END".
+The "ERROR" message will include the index of failure.
+
+Example 1:
+
+  Management interface client sends:
+
+    pkcs11-id-get 1
+
+  OpenVPN daemon responds with:
+
+    1,<id>,<blob>
+    END
+
+Example 2:
+
+  Management interface client sends:
+
+    pkcs11-id-get 1 3
+
+  OpenVPN daemon responds with:
+
+    1,<id_a>,<blob_a>
+    2,<id_b>,<blob_b>
+    END
+
+Example 3:
+
+  Management interface client sends:
+
+    pkcs11-id-get all
+
+  OpenVPN daemon with 3 PKCS#11 certificates responds with:
+
+    0,<id_a>,<blob_a>
+    1,<id_b>,<blob_b>
+    2,<id_c>,<blob_c>
+    END
+
+Example 4:
+
+  Management interface client sends:
+
+    pkcs11-id-get all
+
+  OpenVPN daemon with 3 PKCS#11 certificates fails to retrieve index 1
+
+    0,<id_a>,<blob_a>
+    ERROR: Failed to load PKCS#11 id at index: 1
+
 
 COMMAND -- client-auth  (OpenVPN 2.1 or higher)
 -----------------------------------------------
@@ -1240,7 +1326,7 @@
     "ERROR: [text]".
 
 (2) For commands which print multiple lines of output,
-    the last line will be "END".
+    the last line will be "END" or "ERROR: [text]".
 
 (3) Real-time messages will be in the form ">[source]:[text]",
     where source is "CLIENT", "ECHO", "FATAL", "HOLD", "INFO", "LOG",
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 58f63e6..f00eb30 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -74,6 +74,7 @@
     MCV_USERNAME_ONLY = 4,
     MCV_MULTILINE_PASSWORD = 5,
     MCV_PREFERRED_USERNAME = 6,
+    MCV_MULTILINE_PKCS11_RESPONSE = 7,
 };
 
 struct management *management; /* GLOBAL */
@@ -120,7 +121,8 @@
     msg(M_CLIENT, "pid                    : Show process ID of the current OpenVPN process.");
 #ifdef ENABLE_PKCS11
     msg(M_CLIENT, "pkcs11-id-count        : Get number of available PKCS#11 identities.");
-    msg(M_CLIENT, "pkcs11-id-get index    : Get PKCS#11 identity at index.");
+    msg(M_CLIENT, "pkcs11-id-get i|all [j] : Get PKCS#11 identity at index = i.");
+    msg(M_CLIENT, "                          For version >= 7 also i to j-1 or all.");
 #endif
     msg(M_CLIENT, "client-auth CID KID    : Authenticate client-id/key-id CID/KID (MULTILINE)");
     msg(M_CLIENT, "client-auth-nt CID KID : Authenticate client-id/key-id CID/KID");
@@ -894,26 +896,81 @@
 static void
 man_pkcs11_id_count(const struct management *man)
 {
-    msg(M_CLIENT, ">PKCS11ID-COUNT:%d", pkcs11_management_id_count());
-}
-
-static void
-man_pkcs11_id_get(struct management *man, const int index)
-{
-    char *id = NULL;
-    char *base64 = NULL;
-
-    if (pkcs11_management_id_get(index, &id, &base64))
+    if (man->connection.client_version >= MCV_MULTILINE_PKCS11_RESPONSE)
     {
-        msg(M_CLIENT, ">PKCS11ID-ENTRY:'%d', ID:'%s', BLOB:'%s'", index, id, base64);
+        msg(M_CLIENT, "%d", pkcs11_management_id_count());
+        msg(M_CLIENT, "END");
     }
     else
     {
-        msg(M_CLIENT, ">PKCS11ID-ENTRY:'%d'", index);
+        msg(M_CLIENT, ">PKCS11ID-COUNT:%d", pkcs11_management_id_count());
+    }
+}
+
+static void
+man_pkcs11_id_get(struct management *man, const char *p1, const char *p2)
+{
+    ASSERT(p1);
+
+    if ((streq(p1, "all") || p2 != NULL) && man->connection.client_version < MCV_MULTILINE_PKCS11_RESPONSE)
+    {
+        msg(M_CLIENT, "ERROR: Listing multiple ids is only supported for version >= %d", MCV_MULTILINE_PKCS11_RESPONSE);
+        return;
     }
 
-    free(id);
-    free(base64);
+    if (man->connection.client_version >= MCV_MULTILINE_PKCS11_RESPONSE)
+    {
+        unsigned int count = pkcs11_management_id_count();
+        unsigned int from = (unsigned int)atoi(p1);
+        unsigned int to = p2 ? (unsigned int)atoi(p2) : from + 1;
+
+        if (streq(p1, "all"))
+        {
+            from = 0;
+            to = count;
+        }
+
+        bool error = false;
+        for (unsigned int i = from; i < min_uint(to, count) && !error; i++)
+        {
+            char *id = NULL;
+            char *base64 = NULL;
+
+            if (pkcs11_management_id_get(i, &id, &base64))
+            {
+                msg(M_CLIENT, "%u,%s,%s", i, id, base64);
+            }
+            else
+            {
+                error = true;
+                msg(M_CLIENT, "ERROR: Failed to load PKCS#11 id at index: %u", i);
+            }
+            free(id);
+            free(base64);
+        }
+        if (!error)
+        {
+            msg(M_CLIENT, "END");
+        }
+    }
+    else
+    {
+        int index = atoi(p1);
+
+        char *id = NULL;
+        char *base64 = NULL;
+
+        if (pkcs11_management_id_get(index, &id, &base64))
+        {
+            msg(M_CLIENT, ">PKCS11ID-ENTRY:'%d', ID:'%s', BLOB:'%s'", index, id, base64);
+        }
+        else
+        {
+            msg(M_CLIENT, ">PKCS11ID-ENTRY:'%d'", index);
+        }
+        free(id);
+        free(base64);
+    }
 }
 
 #endif /* ifdef ENABLE_PKCS11 */
@@ -1838,9 +1895,9 @@
     }
     else if (streq(p[0], "pkcs11-id-get"))
     {
-        if (man_need(p, 1, 0))
+        if (man_need(p, 1, MN_AT_LEAST))
         {
-            man_pkcs11_id_get(man, atoi(p[1]));
+            man_pkcs11_id_get(man, p[1], p[2]);
         }
     }
 #endif
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 82c0caa..1d2aff1 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -50,7 +50,7 @@
 #include "socket_util.h"
 #include "mroute.h"
 
-#define MANAGEMENT_VERSION                  6
+#define MANAGEMENT_VERSION                  7
 #define MANAGEMENT_N_PASSWORD_RETRIES       3
 #define MANAGEMENT_LOG_HISTORY_INITIAL_SIZE 100
 #define MANAGEMENT_ECHO_BUFFER_SIZE         100


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
