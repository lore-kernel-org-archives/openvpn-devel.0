Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1C8606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DfYMmMwc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dMYfJ+50;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QlS1S0PG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=CvKav9UixsakgpLplKlrE5kQLE6TbXlExIDXFvOvA9c=; b=DfYMmMwcVXqHdO
	yn3qh1f94dDCxUORz41z5BF4rjADxGWbwj1hn6eqqc5lEWl1C5eNTSD15iArHN9J1MtqBEnlIq0uX
	f1ea9/6vcOwLxJQOA3jyaKc4JHZ3oPfCGgPqnNMxMnrV9ugJalA+p2GqCiTY6+lkmO3sBxdjvWKS/
	hC8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRZKV-000000007cB-2EQA;
	Thu, 12 Nov 2026 18:15:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xRZKT-000000007c5-3sHf for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 18:15:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bPVypZVXefw54nlewmhWvdbSRiNbbNqAe4N4x9gwHiI=; b=dMYfJ+50RG2xCJR18sDeCJt2uQ
 KNAcm0zDM8GrShLfoeOOF72Xx/K+2k6woIVdLM1kQUjfyTHHMvaO4hc62HLkWMb9fjs860o+MltSp
 WPj6UjUKzEpjEj1BfT7cAlGp8HHU+jlZ4mcIABiPmuntNXKFxWqdH2KIqpmjgeCeRDFM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bPVypZVXefw54nlewmhWvdbSRiNbbNqAe4N4x9gwHiI=; b=QlS1S0PGl3vui6UdPNshbyACtk
 tBvK5Y6qEA0jra1yPOvg2h9MIdKkJBORo/l6nXW6TWV/gZWQnTuqG+XtxNYicWepd9RR3P1yVTHKX
 sAKS7m1RGWmnvNgW5Xg7PMqu2eNokbzhUDmn6FUTf9cp4jXais+tcI1Phf0xkgYLkSPc=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRZKS-000000000r2-13HC for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 18:15:21 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ACIFDlA027230
 for <openvpn-devel@lists.sourceforge.net>; Thu, 12 Nov 2026 19:15:13 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ACIFD8H027224
 for openvpn-devel@lists.sourceforge.net; Thu, 12 Nov 2026 19:15:13 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 12 Nov 2026 19:15:06 +0100
Message-ID: <20261112181513.27212-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
References: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xRZKS-000000000r2-13HC
Subject: [Openvpn-devel] [PATCH v4] openvpnserv: keep IPv6 name servers in
 NRPT exclude rules
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

GetNrptExcludeData() stored the IPv6 name servers after the IPv4 list,
but the IPv4 size includes the terminating NUL. With both present, the
string ended at the IPv4 list and the IPv6 servers never made it into
GenericDNSServers. Join the lists by replacing that NUL with a
delimiter.

Both readers now start from an empty string: RegGetValueA() leaves the
buffer untouched when the value is missing, and a slot is reused after
an interface is skipped, so an interface without name servers could
inherit those of the skipped one. They also return the length of the
list without trailing delimiters, instead of the registry value size,
which can include NUL padding.

Broken since 0f3b7d17 ("win: implement --dns option support with
NRPT").

Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Heiko Hund <heiko@ist.eigentlich.net>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2162
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2162
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Heiko Hund <heiko@ist.eigentlich.net>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 81205d6..1b76003 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2128,6 +2128,24 @@
 }
 
 /**
+ * Remove trailing delimiters from a name server list
+ *
+ * @param  addrs      NUL-terminated list of addresses
+ *
+ * @return the size of the list in bytes, including the terminating NUL
+ */
+static DWORD
+TrimNameServers(PSTR addrs)
+{
+    size_t len = strlen(addrs);
+    while (len && (addrs[len - 1] == ',' || addrs[len - 1] == ' '))
+    {
+        addrs[--len] = '\0';
+    }
+    return (DWORD)len + 1;
+}
+
+/**
  * Get DNS server IPv4 addresses of an interface
  *
  * @param  itf_key    registry key of the IPv4 interface data
@@ -2140,6 +2158,7 @@
 static LSTATUS
 GetItfDnsServersV4(HKEY itf_key, PSTR addrs, PDWORD size)
 {
+    addrs[0] = '\0';
     addrs[*size - 1] = '\0';
 
     LSTATUS err;
@@ -2165,7 +2184,7 @@
 
     if (strchr(addrs, '.'))
     {
-        *size = s;
+        *size = TrimNameServers(addrs);
         return NO_ERROR;
     }
 
@@ -2178,13 +2197,15 @@
  *
  * @param  itf_key    registry key of the IPv6 interface data
  * @param  addrs      pointer to the buffer addresses are returned in
- * @param  size       pointer to the size of the buffer
+ * @param  size       pointer to the size of the buffer, contains the
+ *                    size of the addresses on return
  *
  * @return LSTATUS NO_ERROR on success, a Windows error code otherwise
  */
 static LSTATUS
 GetItfDnsServersV6(HKEY itf_key, PSTR addrs, PDWORD size)
 {
+    addrs[0] = '\0';
     addrs[*size - 1] = '\0';
 
     LSTATUS err;
@@ -2231,12 +2252,11 @@
             pos += addr_len;
             s -= (DWORD)addr_len;
         }
-        s = (DWORD)strlen(addrs) + 1;
     }
 
     if (strchr(addrs, ':'))
     {
-        *size = s;
+        *size = TrimNameServers(addrs);
         return NO_ERROR;
     }
 
@@ -2563,6 +2583,11 @@
                               __func__, itf_guid, err);
                 goto next_itf;
             }
+            if (v4_addrs_size && v6_addrs_size)
+            {
+                /* Join the lists: replace the v4 terminating NUL with a delimiter */
+                data[i].addresses[v4_addrs_size - 1] = ',';
+            }
         }
 
         if (v4_addrs_size || v6_addrs_size)


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
