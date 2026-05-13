Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22092CD4F24
	for <openvpn-devel@archiver.kernel.org>; Wed, 13 May 2026 15:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2USijEK1tK8s3LlqI4Z2m+htQlVaN2JPOq1+UJ3QYSg=; b=cwr/Gq3SJ7tUI40QicKmpIyM2D
	+a7u7MDXvh27xjC/k26lBdnZgUCnN9lcSz8d4YUup2nOdqgRu7IssLtATP+YjD5glmesbPJzFrHPa
	YkvfdUWPJQaMgtdYpBsPeCRO9tkMm2DMFtKqyXAjSI8of0UXcqzjv0wjQXJ1nbUkVwFc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNBCi-0001YS-0O;
	Wed, 13 May 2026 15:08:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wNBCe-0001Y2-SM
 for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 15:08:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gvf4GKPQkBb9t+xh+JGJakR3KM34XE9UQv2Hzkt1tuc=; b=BI32VwYjk2WXjv1F6FRmhLV7yC
 GSE/ngojiWG66GSOcEwKx9dgwemlfkciM1XxV1srU5xDhi5CG76l/qXOoiutLSZCdmNg6Xl8TvB+K
 ukIkpKK7lFP9zRdr9S9iSV0gVOoVJ/TiUFBTP4dWbCxHVYtPfbQ3O00mcnDJ9bBaFakE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gvf4GKPQkBb9t+xh+JGJakR3KM34XE9UQv2Hzkt1tuc=; b=QatKlBalfvhQrIwTIsBAnBlwT3
 5axbG/+TQZu9vLFwcZCh6khJ84iNlxYyG/nQzHjD6zVCAs0AUlbGuHoHSEmY6MNXLCo5C4XGbBfKI
 YIHza7NQn5OYq9sciubnm8teO0dDOfjEKW/irqdAEy2grT/ZspMNVclmm4LzsZs79TmI=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNBCc-0006kD-3c for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 15:08:53 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 64DF8cYZ027425
 for <openvpn-devel@lists.sourceforge.net>; Wed, 13 May 2026 17:08:38 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.1/8.18.1/Submit) id 64DF8cfi027424
 for openvpn-devel@lists.sourceforge.net; Wed, 13 May 2026 17:08:38 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 13 May 2026 17:08:32 +0200
Message-ID: <20260513150838.27382-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <gerrit.1778239616000.I04e35928244e6ecda8c58285a812516662b50742@gerrit.openvpn.net>
References: <gerrit.1778239616000.I04e35928244e6ecda8c58285a812516662b50742@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wNBCc-0006kD-3c
Subject: [Openvpn-devel] [PATCH v2] Do not use deprecated aliases on Windows
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

Both these work perfectly fine but are discouraged
and might cause warnings by compilers.

Identified by cppcheck.

Change-Id: I04e35928244e6ecda8c58285a812516662b50742
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Heiko Hund <heiko@openvpn.net>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1673
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1673
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Heiko Hund <heiko@openvpn.net>

        
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index e17936a..bf80bbd 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -235,7 +235,7 @@
         if (pvext && cbext >= sizeof(CERT_TEMPLATE_EXT))
         {
             const CERT_TEMPLATE_EXT *cte = (const CERT_TEMPLATE_EXT *)pvext;
-            if (!stricmp(cert_prop, cte->pszObjId))
+            if (!_stricmp(cert_prop, cte->pszObjId))
             {
                 /* found direct OID match with certificate property specified */
                 gc_free(&gc);
@@ -244,7 +244,7 @@
 
             const CRYPT_OID_INFO *tmpl_oid =
                 find_oid(CRYPT_OID_INFO_NAME_KEY, tmpl_name, CRYPT_TEMPLATE_OID_GROUP_ID);
-            if (tmpl_oid && !stricmp(tmpl_oid->pszOID, cte->pszObjId))
+            if (tmpl_oid && !_stricmp(tmpl_oid->pszOID, cte->pszObjId))
             {
                 /* found OID match in extension against resolved key */
                 gc_free(&gc);
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index d698c04..95e457c 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -508,7 +508,7 @@
             *iTicks += MSICA_ADAPTER_TICK_SIZE;
             break;
         }
-        else if (wcsicmp(szDisplayName, pAdapterOther->szName) == 0)
+        else if (_wcsicmp(szDisplayName, pAdapterOther->szName) == 0)
         {
             /* Adapter with a same name found. */
             for (LPCWSTR hwid = pAdapterOther->szzHardwareIDs;; hwid += wcslen(hwid) + 1)
@@ -521,7 +521,7 @@
                     dwResult = ERROR_ALREADY_EXISTS;
                     goto cleanup_pAdapterList;
                 }
-                else if (wcsicmp(hwid, szHardwareId) == 0)
+                else if (_wcsicmp(hwid, szHardwareId) == 0)
                 {
                     /* This is an adapter with the requested hardware ID. We already have what we
                      * want! */
@@ -583,7 +583,7 @@
     for (struct tap_adapter_node *pAdapter = pAdapterList; pAdapter != NULL;
          pAdapter = pAdapter->pNext)
     {
-        if (wcsicmp(szDisplayName, pAdapter->szName) == 0)
+        if (_wcsicmp(szDisplayName, pAdapter->szName) == 0)
         {
             /* Adapter found. */
             WCHAR szArgument[8 /*disable=|enable=|delete=*/
@@ -1083,7 +1083,7 @@
                 for (struct tap_adapter_node *pAdapter = pAdapterList; pAdapter != NULL;
                      pAdapter = pAdapter->pNext)
                 {
-                    if (wcsicmp(szName, pAdapter->szName) == 0)
+                    if (_wcsicmp(szName, pAdapter->szName) == 0)
                     {
                         /* Adapter found. */
                         dwResult = tap_delete_adapter(NULL, &pAdapter->guid, &bRebootRequired);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
