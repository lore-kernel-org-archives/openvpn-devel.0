Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06727C5CFCF
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nff5REdKlGgH+FhiBMShTdZrQGt+yhplx96wjVIXLvw=; b=XlSmDDB+6kUt1tpXrDLpqUlTUY
	t0LGdddO0NaNQYw2qaEisQMRGJMZpfIzxfQZUPPMEfVdNSAIO/KkjXnooOZUdsB3gbYC0aFaUN/hq
	f4YzzE/2hcbw6JC2jVAwIZvwJqF898gi2NTRci6fEnKFfZu3g5loGOtDQq42dDdPsFuA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuZrW-0007sk-0u;
	Thu, 13 Aug 2026 18:09:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wuZrT-0007sU-UJ
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 18:09:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=veZGtbfQeP38nfVcrYgiGclwgEdIknSIG9bhLfZIM/A=; b=al04kbdV3kUkSAtO/9WEs/hZl+
 oZObd22Gk8DiY3W8hgGX7xqsSEdF14kOj47S1rdptr2AUKJxc2hk8UlWdDvqlFQNMVNpiks1gjoVr
 6vySWM6mVg5tm4QIsOLAoGIV7bL/77LldXD/xD+8WOI+B121x38PzX2BcjuXpNN1kPMs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=veZGtbfQeP38nfVcrYgiGclwgEdIknSIG9bhLfZIM/A=; b=iYcKygA7DsIZlG2SkAIOpvF2Mx
 CYXOKRqTQL6NssuDkP7lKL9aCZxFlSnEonufJF5vyH4EPjCmpQbz316v7+dC5jq8Mz5cvcxahoBRF
 sE3i4QsWYguN0KsUwFz41o0irP0/B09Z14LhmlFrs+FN4aCeABXS5yPY59l5m1eCrPLM=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuZrW-0001X9-Cb for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 18:09:04 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67DI8uLO003226
 for <openvpn-devel@lists.sourceforge.net>; Thu, 13 Aug 2026 20:08:56 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67DI8uPt003225
 for openvpn-devel@lists.sourceforge.net; Thu, 13 Aug 2026 20:08:56 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 13 Aug 2026 20:08:45 +0200
Message-ID: <20260813180856.3208-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1768911587000.Iac4af315c6d7798f09a27383fc0a755a874b9881@gerrit.openvpn.net>
References: <gerrit.1768911587000.Iac4af315c6d7798f09a27383fc0a755a874b9881@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wuZrW-0001X9-Cb
Subject: [Openvpn-devel] [PATCH v3] reliable: Avoid conversion warning in
 reliable_send_timeout
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

It is not realistic that this produced big values
and we already discard negative values. So just use
whatever we get.

Change-Id: Iac4af315c6d7798f09a27383fc0a755a874b9881
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1480
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1480
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 52adacf..690e50d6 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -687,11 +687,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /* in how many seconds should we wake up to check for timeout */
 /* if we return BIG_TIMEOUT, nothing to wait for */
 interval_t
@@ -713,7 +708,7 @@
             }
             else
             {
-                ret = min_int(ret, e->next_try - local_now);
+                ret = min_int(ret, (int)(e->next_try - local_now));
             }
         }
     }
@@ -724,10 +719,6 @@
     return ret;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  * Enable an incoming buffer previously returned by a get function as active.
  */


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
