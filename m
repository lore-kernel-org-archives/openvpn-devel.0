Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91955606A320
	for <openvpn-devel@archiver.kernel.org>; Sat, 21 Nov 2026 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AOxjEuTD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CqRiY2+l;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=il5jl/Hf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=5G7XnagCK3g7UNJxv423re+PH2+ehW1+SibO1B1I00E=; b=AOxjEuTDhR4gNd
	1w2NfaP8FcTOREpTYxwvDIIrQbJn1re8RsJOMEWIkr+/THy3CK67DAj0j9+gE4Bck3m1DkNqx4lel
	C7HI1P0/Ny1BYSuBEu8mHt80sDzdUqPFqPk2jQeyXtGsh4Rm8W2pMrgEuaqv4QrATmvrSDUBgoikl
	urI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUhh4-000000001sZ-0YCr;
	Sat, 21 Nov 2026 09:47:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xUhh2-000000001sD-2u6a for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 09:47:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iOvZ9G3fu0q9SE8AgDyfFxSqP2kgy8a+BPPbgGCQJ/Q=; b=CqRiY2+lAx0f4koiZHg1gm2WUj
 4h+CzalsqCm/wEiibDcH+BOA3A09gLBRVY8i+7ePP4ywLkW+OhEt7QmrlH1Ux9vz8/b9QYSwmA1wX
 5jZUuobyRbgcG0+9VaTrnQcirvRTXSOAK7CE6V1lg6vUBUgCq/3xQ5jj/L98STe/iNAw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iOvZ9G3fu0q9SE8AgDyfFxSqP2kgy8a+BPPbgGCQJ/Q=; b=il5jl/HfEj8jBfrGK0gS8pwUvn
 +68JLww6SAKVXorQC7N2W423Tg6QY3pmjWFGMj9NjPvzLPVgrLcSRp96laZD2z9Cp5ch5x6iMVhXJ
 v58fP7Z2sfSAtq5z0qhBgVic7NoUGapmHquP02d5nz1WNSkYKjcMN9JR74qp7l24uV+A=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUhgb-0000000032T-1Moj for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 09:47:10 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AL9l24G028652
 for <openvpn-devel@lists.sourceforge.net>; Sat, 21 Nov 2026 10:47:02 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AL9l2Cg028651
 for openvpn-devel@lists.sourceforge.net; Sat, 21 Nov 2026 10:47:02 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 21 Nov 2026 10:46:56 +0100
Message-ID: <20261121094701.28638-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795207472000.Id346f35f6ce371b177af7454cd73d3eeccb8ed6c@gerrit.openvpn.net>
References: <gerrit.1795207472000.Id346f35f6ce371b177af7454cd73d3eeccb8ed6c@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xUhgb-0000000032T-1Moj
Subject: [Openvpn-devel] [PATCH v1] openvpnserv: keep NRPT exclude data if
 one address family fails
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

GetNrptExcludeData() skipped an interface completely if reading its
IPv4 or IPv6 name servers error'd, even if the other address family
had servers.

Use the name servers that could be read instead.

Change-Id: Id346f35f6ce371b177af7454cd73d3eeccb8ed6c
Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2235
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2235
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 32b1688..7ea88a1 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2580,11 +2580,15 @@
         /* Get the IPv4 DNS servers */
         DWORD v4_addrs_size = sizeof(data[0].addresses);
         err = GetItfDnsServersV4(v4_itf, data[i].addresses, &v4_addrs_size);
-        if (err && err != ERROR_FILE_NOT_FOUND)
+        if (err)
         {
-            MsgToEventLog(M_SYSERR, L"%S: could not read interface %s v4 name servers (%ld)",
-                          __func__, itf_guid, err);
-            goto next_itf;
+            if (err != ERROR_FILE_NOT_FOUND)
+            {
+                MsgToEventLog(M_SYSERR, L"%S: could not read interface %s v4 name servers (%ld)",
+                              __func__, itf_guid, err);
+            }
+            data[i].addresses[0] = '\0';
+            v4_addrs_size = 0;
         }
 
         /* Get the IPv6 DNS servers, if there's space left */
@@ -2593,19 +2597,21 @@
         if (v6_addrs_size > NRPT_ADDR_SIZE)
         {
             HKEY v6_itf;
-            if (RegOpenKeyExW(v6_itfs, itf_guid, 0, KEY_READ, &v6_itf) != NO_ERROR)
+            err = RegOpenKeyExW(v6_itfs, itf_guid, 0, KEY_READ, &v6_itf);
+            if (!err)
             {
-                MsgToEventLog(M_SYSERR, L"%S: could not open interface %s v6 registry key",
-                              __func__, itf_guid);
-                goto next_itf;
+                err = GetItfDnsServersV6(v6_itf, v6_addrs, &v6_addrs_size);
+                RegCloseKey(v6_itf);
             }
-            err = GetItfDnsServersV6(v6_itf, v6_addrs, &v6_addrs_size);
-            RegCloseKey(v6_itf);
-            if (err && err != ERROR_FILE_NOT_FOUND)
+            if (err)
             {
-                MsgToEventLog(M_SYSERR, L"%S: could not read interface %s v6 name servers (%ld)",
-                              __func__, itf_guid, err);
-                goto next_itf;
+                if (err != ERROR_FILE_NOT_FOUND)
+                {
+                    MsgToEventLog(M_SYSERR, L"%S: could not read interface %s v6 name servers (%ld)",
+                                  __func__, itf_guid, err);
+                }
+                v6_addrs[0] = '\0';
+                v6_addrs_size = 0;
             }
             if (v4_addrs_size && v6_addrs_size)
             {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
