Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3AAC5CFCF
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pEbzpVPu8KRnGdaFnjChrqj9E/ilNY7DJK8hEqOHGN8=; b=BgmK57B3wpmvUSmZxwShBo32Sm
	haer1YF9URqEA97JgTXxd8EUYH7gudVXkvaSmVfs5p9CyisDnzjpiEp2a4n2MCabOSF+JJUNZlWNW
	3tuJP3GqjLYwH9XDVuGBN3HKbE8CjPLo70UTc/ShrtT1UiLdIyC8nomJqyAScVMZs6eI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuZs0-0000ez-F9;
	Thu, 13 Aug 2026 18:09:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wuZrz-0000es-5v
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 18:09:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E+8c/sxXyx4507mrKDU833XCjMsgi4CuObshLgbhryQ=; b=Vh6NFjCv5NFu9ABcxa/rhZCHgP
 osxWnO77L+20QrwW0jJzwtc1VavszK50vyx9QfqF2DMLGTnJJp0OLrsowZ6UCwVQYQSBrJi+6SzjG
 B44T6Ti099hz8sdISTtVRDs9Hb8UsrOSlsouS4QxGhd/t1pJkxeY4ueAvKcFR30NsH98=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=E+8c/sxXyx4507mrKDU833XCjMsgi4CuObshLgbhryQ=; b=W10Ua1NVKnY4CHQ1e3vWtUuJmq
 B0lr9CXc1st1eTxUMtpngdrsuAMpUaCttvVCxl+0KNAz+IcHcVeSGrfBmXLuLzEzj3PnG/lIvRUOO
 jJ2Rl4uvlWgIQm0nb49KFm9d57rFzrot5vS1TSXmxMP++b1hYHE352TUimI0TR8h8DYw=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuZs1-0001aB-Oo for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 18:09:35 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67DI9RFa003276
 for <openvpn-devel@lists.sourceforge.net>; Thu, 13 Aug 2026 20:09:27 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67DI9Rvs003275
 for openvpn-devel@lists.sourceforge.net; Thu, 13 Aug 2026 20:09:27 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 13 Aug 2026 20:09:21 +0200
Message-ID: <20260813180927.3263-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1783961511000.Ie44556f5ece28b54cc657fa86261b827efb42467@gerrit.openvpn.net>
References: <gerrit.1783961511000.Ie44556f5ece28b54cc657fa86261b827efb42467@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wuZs1-0001aB-Oo
Subject: [Openvpn-devel] [PATCH v1] win32-util.h: Fix includes
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

This file includes various headers but then doesn't
use anything from them. It does not include the header
(buffer.h) it actually uses.

Change-Id: Ie44556f5ece28b54cc657fa86261b827efb42467
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1779
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1779
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/win32-util.h b/src/openvpn/win32-util.h
index 4849ea9..fb83762 100644
--- a/src/openvpn/win32-util.h
+++ b/src/openvpn/win32-util.h
@@ -24,11 +24,7 @@
 #ifndef OPENVPN_WIN32_UTIL_H
 #define OPENVPN_WIN32_UTIL_H
 
-#include <winioctl.h>
-
-#include "mtu.h"
-#include "openvpn-msg.h"
-#include "argv.h"
+#include "buffer.h"
 
 /* Convert a string from UTF-8 to UCS-2 */
 WCHAR *wide_string(const char *utf8, struct gc_arena *gc);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
