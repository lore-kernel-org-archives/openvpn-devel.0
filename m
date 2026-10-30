Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A06C606A31D
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=m6pVyWUb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Lkbr5E0v;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eF1xEsOH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=eC9K+RGMH01IV+S0gbLdL6i9SeXeN4BwOwdhc5rq/CE=; b=m6pVyWUbL46Vpl
	gvHj7tDOTpLTWhkesTyb9lEnk8rQACgCv9qZ/8X5dP3jrpaylfG0HhYOewsL9YCSc8y40gIs+oMnY
	WkFWp33WoC7vGg9OBlJKG8WwnNisY1U/Z3JUekXv09lTPMcWPSVMIDRukOtqOILM0mkeoJWMvDQO4
	ihA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMuK9-000000001rK-3yhu;
	Fri, 30 Oct 2026 21:39:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xMuK8-000000001rC-3c3x for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 21:39:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CEfCknuZPfZLfHG2o00OK9okJGocqZLRnKMAPPyufKI=; b=Lkbr5E0vhxfxVi+yqvg1tBX1R6
 dMWl7uclp26yDYWVytJQ95qbmLALNn+jMR6xuuZiy/UC65d6T1sWU6O2HSEBo4AjO48hQeIYSDSDq
 q+WPxY43GXv0SP98Q1iNH2yB2QaKom9hIdYYiCsM5z6wRFSlC43+8W/8nizfiLjYTAIA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CEfCknuZPfZLfHG2o00OK9okJGocqZLRnKMAPPyufKI=; b=eF1xEsOHlN3Rk1tu+rRkoANnyZ
 rzpjBMmDYH1vS/AXMnHZbsv1MrOAv2FgymbUeVKovLOENbpLjVxL1YXGv9FWF83RjdZRqFUjVosJh
 hnfSxge8j6Uitqc8UvrTLZ1RLW/CLQzP/nnbiX9PKqci7aD5RwqZcIy78umVl/61h2D4=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMuK7-000000000lv-2HUY for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 21:39:44 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69ULdaVn001041
 for <openvpn-devel@lists.sourceforge.net>; Fri, 30 Oct 2026 22:39:36 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69ULda0B001040
 for openvpn-devel@lists.sourceforge.net; Fri, 30 Oct 2026 22:39:36 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 30 Oct 2026 22:39:30 +0100
Message-ID: <20261030213936.1001-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793212962000.Iac23d5141a8c29e239d0f2aeea497d3a002e609b@gerrit.openvpn.net>
References: <gerrit.1793212962000.Iac23d5141a8c29e239d0f2aeea497d3a002e609b@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xMuK7-000000000lv-2HUY
Subject: [Openvpn-devel] [PATCH v4] Optionally indicate username in
 >PASSWORD '<UP_TYPE>' prompts
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

From: Selva Nair <selva.nair@gmail.com>

When username is included in the config file as inlined or
read from a file, indicate it as a preferred-username in
>PASSWORD Need '<UP_TYPE>' username/password prompts where
'<UP_TYPE>' could be 'Auth', 'HTTP Proxy' or 'SOCKS Proxy'.
The prompt is appended with "UN:<user64>" where <user64> is
the pre-defined username, base64 encoded.

This is treated as a hint, not an enforced value. The management
client still responds with both username and password obtained
from the user. Whether the management client allows the
user to input a different username is left to the client
implementation.

The documentation in management-notes is slightly edited to add
that 'Auth', 'HTTP Proxy', 'SOCKS Proxy' are possible types of
username/password prompts.

Only clients that announce version >=6 are prompted this way.

This helps to fix user reports on OpenVPN-GUI not respecting username
set in the config file.

Change-Id: Iac23d5141a8c29e239d0f2aeea497d3a002e609b
Signed-off-by: Selva Nair <selva.nair@gmail.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2069
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2069
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index eac91a4..b9b367f 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -304,6 +304,9 @@
     username "Auth" foo
     password "Auth" bar
 
+  The same format is used for HTTP and SOCKS proxy username and password
+  with 'Auth' replaced by 'HTTP Proxy' and 'SOCKS Proxy' respectively.
+
   Example 3:
 
     >PASSWORD:Need 'Auth' username
@@ -394,6 +397,31 @@
   response along with the username and password formatted as described
   in the Challenge/Response Protocol section below
 
+  Example 10:
+
+    >PASSWORD:Need '<UP_TYPE>' username/password UN:<user-base64>
+    >PASSWORD:Need 'Auth' username/password UN:<user-base64> SC:1,Please enter token PIN
+
+  where <UP_TYPE> is any supported type that requires username and password.
+  (see Example 2).
+
+  These work exactly as Examples 2 and 8, respectively, with the following
+  difference. The prompt has an additional word "UN:<user-base64>" where
+  <user-base64> is the base64 encoded form of a pre-defined username. This
+  may be a username inlined in the config file or read from an external
+  user-pass file.
+
+  The management client is expected to show the base64 decoded value to
+  the user. Whether the user can change this username or not is left to
+  the client implementation.
+
+  The response from the management client should follow the same format
+  as in example 2 or example 8, as applicable.
+
+  This prompt is shown only if the management-client announces a
+  version >= 6. Older clients will see the prompt shown in Example 2
+  or 8.
+
 See the "Challenge/Response Protocol" section below for more details
 about examples 8 and 9, including how the management interface client
 should respond.
@@ -530,6 +558,7 @@
     >PK_SIGN:[base64],[alg]     -- version 3 or greater
     >PASSWORD:Need 'Auth' username -- version 4 or greater
     multiline password from client -- version 5 or greater
+    preferred username in >PASSWORD prompt -- version 6 or greater
 
 COMMAND -- auth-retry
 ---------------------
@@ -1454,6 +1483,12 @@
 used, the management interface will send:
 
   >PASSWORD:Need 'Auth' username/password SC:<flag>,<TEXT>
+  or
+  >PASSWORD:Need 'Auth' username/password UN:<user64> SC:<flag>,<TEXT>
+
+  The second form is used only if the client version is >=6, and a
+  preferred username is available. See also Example 10 in the section
+  titled "COMMAND -- password and username"
 
   flag: an integer whose least significant bit is the ECHO flag and
         the next significant bit is the FORMAT flag.
@@ -1463,6 +1498,7 @@
         as described below. Thus flag could take values 0, 1, 2, or 3.
   TEXT: challenge text that should be shown to the user to
       facilitate their response
+  user64: Preferred username, if available, base64 encoded.
 
 For example:
 
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 0fc9ee2..65e2881 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -71,6 +71,7 @@
     MCV_PKSIGN_ALG = 3,
     MCV_USERNAME_ONLY = 4,
     MCV_MULTILINE_PASSWORD = 5,
+    MCV_PREFERRED_USERNAME = 6,
 };
 
 struct management *management; /* GLOBAL */
@@ -3670,6 +3671,26 @@
             buf_printf(&alert_msg, " MSG:%s", up->username);
         }
 
+        if (up_query_mode == UP_QUERY_USER_PASS
+            && (man->connection.client_version >= MCV_PREFERRED_USERNAME)
+            && up->username[0])
+        {
+            /*
+             * The buffer up is prefilled with username from auth-file or inline.
+             * Indicate it in the prompt as base64 encoded.
+             */
+            char *user64 = NULL;
+            if (openvpn_base64_encode(up->username, (int)strlen(up->username), &user64) != -1)
+            {
+                buf_printf(&alert_msg, " UN:%s", user64);
+            }
+            else
+            {
+                msg(M_NONFATAL, "ERROR: could not base64-encode username");
+            }
+            free(user64);
+        }
+
         if (sc)
         {
             buf_printf(&alert_msg, " SC:%d,%s",


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
