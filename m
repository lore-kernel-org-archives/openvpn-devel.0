Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C7DCD98ED
	for <openvpn-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=htg+3kwt+/TTY8CbK6RPskC/6MNj4aw0k1W6yVC0FCk=; b=b7hVwSwNZRRBwSwzjTGr7GB+Tj
	3/12Cj3MEyNte+FntDYLyZKd5tZZRxbkj/FWZNTPh2OcFZMnB2hX8yKxmRnBRqEnNlW2flLP5Vxta
	F2umYvKQ4CGJJywjEtGow6QTW/qOH3qRFQEiRcIiZDDB87ifx+nxTz3fRMvoLf05l0MQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1waC0E-0003RO-Dw;
	Thu, 18 Jun 2026 12:37:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1waC07-0003RF-Vi
 for openvpn-devel@lists.sourceforge.net;
 Thu, 18 Jun 2026 12:37:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yYe8FW+dhARItwOdfpJavda190GsVTOK5OeiZYipO08=; b=IAAV4kHKezxPP8kPxP7mQEZ787
 mqv08LHRW033JwTkHu/G41nXq12rAFzr9ym5ue0SYr7YzXOT4FA/6aw85mE0UiHrbmZUuZEbIxt84
 /+WNQzWAaA1Yl4o8edzB5ee+v1fJVjtqowHYW0oIOfwLS/+eLJSqWGOhCwoRg4W1GxR8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yYe8FW+dhARItwOdfpJavda190GsVTOK5OeiZYipO08=; b=N81mtcpTc44RjXN1gqibeitVTk
 2JJHZSegOcwStFfKMaMtpyLSNmv3GHoVrwMIH/lK9akav/SzFYwSsXCuufZ1EIVXkzp4ghzRYPDF1
 VozSuLToCmZ1yhsavZrSU5r3TItn0mLK1+XTKb1v0+ZrKlagk4Jtj9GaSmi9ySjFiiz4=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1waC05-00070x-EL for openvpn-devel@lists.sourceforge.net;
 Thu, 18 Jun 2026 12:37:44 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 65ICbUvJ018354
 for <openvpn-devel@lists.sourceforge.net>; Thu, 18 Jun 2026 14:37:30 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 65ICbUxa018353
 for openvpn-devel@lists.sourceforge.net; Thu, 18 Jun 2026 14:37:30 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 18 Jun 2026 14:37:24 +0200
Message-ID: <20260618123729.18337-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1781716678000.Iac54e6772b2c26a09227fd638d24d6e2aa35cec6@gerrit.openvpn.net>
References: <gerrit.1781716678000.Iac54e6772b2c26a09227fd638d24d6e2aa35cec6@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1waC05-00070x-EL
Subject: [Openvpn-devel] [PATCH v2] Fix 1-byte buffer overrun on NTLMv2
 proxy responses.
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

An attacker controlling an HTTP proxy (or performing MITM on the
plaintext pre-TLS proxy connection) can trigger a single 0-byte
overrun to a buffer on the stack by sending a crafted NTLM Type
2 challenge response.

The effects of this depend on memory layout, but could possibly lead
to a crashing OpenVPN client.

Reported-by: Tristan Madani (@TristanInSec)
CVE: 2026-11771
Github: OpenVPN/openvpn-private-issues#116

Change-Id: Iac54e6772b2c26a09227fd638d24d6e2aa35cec6
Signed-off-by: Gert Doering <gert@greenie.muc.de>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1713
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.7.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1713
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 244ee94..9c4edf9 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -317,7 +317,7 @@
     if ((flags & 0x00800000) == 0x00800000)
     {
         tib_len = buf2[0x28]; /* Get Target Information block size */
-        if (tib_len + 0x1c + 16 > sizeof(ntlmv2_response))
+        if (tib_len + 0x1c + 16 >= sizeof(ntlmv2_response))
         {
             msg(M_WARN, "NTLM: target information buffer too long for response (len=%d)", tib_len);
             return NULL;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
