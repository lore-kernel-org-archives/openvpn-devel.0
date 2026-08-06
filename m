Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B008C55ABF
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 09:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jyNBU1eiNLCLJLeZYGv2pr4w1elmF86zzXJWBgAh8rw=; b=Lrqts0rfjz87zx0NbAuCEVOkVn
	KHro94cGhd9tN0eAmBRk/YzHzVu6lhX7186OukRlanqrlqOrIR0WDHp1BzwYHQb8ZTmX6U9bgsZRB
	5OyK3l8beYKkfSBZu3jaqY/xE2aXSKAA4JnC/W6LrQB330lK1PB6LlIy+6r4VQzvcffs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wru6y-0000EO-IF;
	Thu, 06 Aug 2026 09:10:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wru6x-0000EH-5j
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 09:09:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QJMPOnc8sNHcHL/7WXBsr1TnSwomBt07awvTlHkpxmM=; b=bSoOszb6i8brv/iQu88408nnYi
 8rSuzf5LDT0dQnLFV5/7yR1OmdRjc94Pfkz9tKJ3Li7P75VInoTU9zM8rbwUzTYR4GO1vQKpZ+RWb
 2R6B3fE1jNRf6ugOJ2YBwQgTHfe2OKgEzXnlik5CZ9hPMlXeN24AFEnexTBKEmqI/ocg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QJMPOnc8sNHcHL/7WXBsr1TnSwomBt07awvTlHkpxmM=; b=WRTKQumdLkJPX/aDI1EBrrohG0
 hEhETY4qrXlQmsgziUJ49Rn7r85du15Ck07eWvejvrB8y1lrWd6l0r9uaYih4AV6rtRorWAxOjFo3
 5Y2jGcnvCtTei3a8S0gK438RRgThYPboW30Hy3TAAEwgPGoWVF5bjmx2Ple/7PVTdaSI=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wru70-0006Ge-9x for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 09:09:59 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67699poD020915
 for <openvpn-devel@lists.sourceforge.net>; Thu, 6 Aug 2026 11:09:51 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67699pd8020914
 for openvpn-devel@lists.sourceforge.net; Thu, 6 Aug 2026 11:09:51 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  6 Aug 2026 11:09:45 +0200
Message-ID: <20260806090951.20900-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1785766260000.I3db70001be7f39cf84d562517647f1a305962b42@gerrit.openvpn.net>
References: <gerrit.1785766260000.I3db70001be7f39cf84d562517647f1a305962b42@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wru70-0006Ge-9x
Subject: [Openvpn-devel] [PATCH v2] Remove local get_random in test_misc.c
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

From: Arne Schwabe <arne@rfc2549.org>

The get_random in test_misc.c conflicts
with the get_random function that OpenVPN defines in crypto.h
Also adjust the implementation in mock_get_random.c to match the
prototype in crypto.h

Change-Id: I3db70001be7f39cf84d562517647f1a305962b42
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Antonio Quartulli <antonio@mandelbit.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1834
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1834
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>
Antonio Quartulli <antonio@mandelbit.com>

        
diff --git a/tests/unit_tests/openvpn/mock_get_random.c b/tests/unit_tests/openvpn/mock_get_random.c
index 0840e31..5cb768b 100644
--- a/tests/unit_tests/openvpn/mock_get_random.c
+++ b/tests/unit_tests/openvpn/mock_get_random.c
@@ -28,7 +28,7 @@
 #include <stdint.h>
 #include <cmocka.h>
 
-unsigned long
+int64_t
 get_random(void)
 {
     /* rand() is not very random, but it's C99 and this is just for testing */
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index 501286c..8da7abe 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -38,6 +38,7 @@
 #include "test_common.h"
 #include "list.h"
 #include "mock_msg.h"
+#include "crypto.h"
 #ifdef _WIN32
 #include "win32-util.h"
 #endif
@@ -141,13 +142,6 @@
     return strcmp((const char *)key1, (const char *)key2) == 0;
 }
 
-static uint32_t
-get_random(void)
-{
-    /* rand() is not very random, but it's C99 and this is just for testing */
-    return (uint32_t)rand();
-}
-
 static struct hash_element *
 hash_lookup_by_value(struct hash *hash, void *value)
 {
@@ -263,7 +257,7 @@
         {
             struct hash_iterator hi;
             struct hash_element *he;
-            inc = (get_random() % 3) + 1;
+            inc = ((uint32_t)get_random() % 3) + 1;
             hash_iterator_init_range(hash, &hi, base, base + inc);
 
             while ((he = hash_iterator_next(&hi)))


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
