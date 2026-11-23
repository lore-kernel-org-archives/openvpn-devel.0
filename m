Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4738606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RMEUcJ+E;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lzSNXKde;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WYnTMhGv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=gTSF0f7BuvKBT/yJWugO1iqgdEtDHBraVNzjU9t90fg=; b=RMEUcJ+E+gJ0f2
	ySO5oa9DiY/we+zWhr75+Toq47a/pPaajVDaSnI3mSFdzp3NXzhnj7fdRCoDzkZg43bJffk5qbxLK
	eHQYbKWyFJYdg2H5t3qYP1mLSpcMjMyeVj8Mmjw/duDRKpQ/bIZlcbuBZkb1P69o1X4wCC1HyasJj
	Mjo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVXml-000000000Pk-1AoI;
	Mon, 23 Nov 2026 17:24:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xVXmh-000000000Ou-2sOR for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:24:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3dLQt9Gh9TtavsHdi6qGCPleF6nuvhgh/gXXdranD70=; b=lzSNXKdeC8KlF1sx0jbjHGjcPL
 4ycJfvHjxXd/aC4FLZSLGX8ElbgbbjWPDvIuAQCnuHq7vgalyO4DFzfD8xLm1hNvINoGg6SHB/LOj
 QMsa9BFyFbk1fTGMCCJv1nXSRatbn5v9LlV7mFco0ZRyKpNvY25BmHp1TfjgTK2xE97s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3dLQt9Gh9TtavsHdi6qGCPleF6nuvhgh/gXXdranD70=; b=WYnTMhGvuln3OKVEircGMCRjcz
 e80kGBEUQ9MlyRdC+xjbwI93/O+q+ZsFSHfRVZeNYR+uEdkEJyPMUL73Hhr+lW6EHOHyMH21vANcL
 aMO5dSciceXhUlLxvVfprxD/YsuNfEN6dvyf+CSy2cmbxZLAFtUWdmKi2ubdL2M1cmdE=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVXmf-000000001bc-3ToR for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:24:55 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ANHOluI022134
 for <openvpn-devel@lists.sourceforge.net>; Mon, 23 Nov 2026 18:24:47 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ANHOlYD022133
 for openvpn-devel@lists.sourceforge.net; Mon, 23 Nov 2026 18:24:47 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 23 Nov 2026 18:24:41 +0100
Message-ID: <20261123172446.22118-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794834286000.I00b340f30dc3518994b74c49565736524b7df318@gerrit.openvpn.net>
References: <gerrit.1794834286000.I00b340f30dc3518994b74c49565736524b7df318@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xVXmf-000000001bc-3ToR
Subject: [Openvpn-devel] [PATCH v2] gerrit-send-mail: Support user
 authentication
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

From: Frank Lichtenheld <frank@lichtenheld.com>

Required for changes in private projects.

Change-Id: I00b340f30dc3518994b74c49565736524b7df318
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2195
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2195
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/dev-tools/gerrit-send-mail.py b/dev-tools/gerrit-send-mail.py
index ae904d5..d6e78a9 100755
--- a/dev-tools/gerrit-send-mail.py
+++ b/dev-tools/gerrit-send-mail.py
@@ -18,10 +18,18 @@
 # Extract a patch from Gerrit and transform it in a file suitable as input
 # for git send-email.
 
+# Note: This generally works without authentication since it only reads
+# information and doesn't change any state in Gerrit itself.
+# To access changes in projects that are not viewable by anonymous
+# visitors set GERRIT_USER and GERRIT_PASS environment variables.
+# GERRIT_PASS can be a token as generated on your user settings page
+# under "HTTP Credentials".
+
 import argparse
 import base64
 from datetime import timezone
 import json
+import os
 import sys
 from urllib.parse import urlparse
 
@@ -29,9 +37,11 @@
 import requests
 
 
-def get_details(args):
+def get_details(args, gerrit_api_url, auth):
     params = {"o": ["CURRENT_REVISION", "LABELS", "DETAILED_ACCOUNTS"]}
-    r = requests.get(f"{args.url}/changes/{args.changeid}", params=params)
+    r = requests.get(
+        f"{gerrit_api_url}/changes/{args.changeid}", params=params, auth=auth
+    )
     print(r.url)
     json_txt = r.text.removeprefix(")]}'\n")
     json_data = json.loads(json_txt)
@@ -76,9 +86,10 @@
     }
 
 
-def get_patch(details, args):
+def get_patch(details, args, gerrit_api_url, auth):
     r = requests.get(
-        f"{args.url}/changes/{args.changeid}/revisions/{details['revision']}/patch?download"
+        f"{gerrit_api_url}/changes/{args.changeid}/revisions/{details['revision']}/patch?download",
+        auth=auth,
     )
     print(r.url)
     patch_text = base64.b64decode(r.text).decode()
@@ -138,8 +149,16 @@
     parser.add_argument("-u", "--url", default="https://gerrit.openvpn.net")
     args = parser.parse_args()
 
-    details = get_details(args)
-    patch = get_patch(details, args)
+    auth = None
+    gerrit_api_url = args.url
+    if "GERRIT_USER" in os.environ:
+        gerrit_user = os.environ["GERRIT_USER"]
+        gerrit_pass = os.environ["GERRIT_PASS"]
+        auth = requests.auth.HTTPBasicAuth(gerrit_user, gerrit_pass)
+        gerrit_api_url += "/a"
+
+    details = get_details(args, gerrit_api_url, auth)
+    patch = get_patch(details, args, gerrit_api_url, auth)
     apply_patch_mods(patch, details, args)
 
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
