Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A80EC624C6
	for <openvpn-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WX+9OI9MyLsxInrQKULRZHBH/2fETEZ7wmndkqEijf4=; b=VTvACiD/RiJrPMYHH+q1YPurm7
	g8CX2nKJIVkBpw+8K6Tl/o1CKI0prWHttJ9lEB45seklCcpzOmpuT5RSj0lo7eIk4VAOhk0iH3Scs
	64cpRFOLJC/xQz2JgJm0TGMWfQO9yI7KJS0JfDW53gHhXGellsWDzYgbgoetzukxzf3Y=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x172P-0001rF-TS;
	Mon, 31 Aug 2026 18:47:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x172C-0001r1-41
 for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 18:47:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jeEbQyVdN45hLLWc0IyxnZq/fviD5eJi2l8fptZJt68=; b=GQRtz7Pdvt+WX6b2YQ+0ovIMxp
 XSDEIjjEuegUIii0PlF+tDpbeXjRBmj3bAVy8VQk7LMO0Ozndeep95j225ZnRmI8HTJIvjNDOTEBv
 GT0lJ3hd05Fw9G92aMJWYHG9aDRJOudwoWlbu36gOwhOmD3+vfiIF6JgfvULp0f++454=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jeEbQyVdN45hLLWc0IyxnZq/fviD5eJi2l8fptZJt68=; b=CUUUJn6SLPVbz0049J0E36o4QT
 wqUTfej2MMLgEOXbXuBXmH/IwZwrnjRkvF7bGht+shyymYJvhHzd6uDonB59TQGMh1A0hrEhoxqqC
 oycEZ1G5188FCsvp1KOQXXr0N9wyqz1Xk4rDN5GDi/mlVAUieasDIzfw7pEgjmS32T8g=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1728-0004BC-VE for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 18:47:08 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67VIkvlL003347
 for <openvpn-devel@lists.sourceforge.net>; Mon, 31 Aug 2026 20:46:57 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67VIkvh4003346
 for openvpn-devel@lists.sourceforge.net; Mon, 31 Aug 2026 20:46:57 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 31 Aug 2026 20:46:50 +0200
Message-ID: <20260831184657.3332-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1788192180000.I371aafba18d336bcfd3912e92c18301e39bf6087@gerrit.openvpn.net>
References: <gerrit.1788192180000.I371aafba18d336bcfd3912e92c18301e39bf6087@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x1728-0004BC-VE
Subject: [Openvpn-devel] [PATCH v1] openvpnserv: don't allow '/' in config
 paths
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

From: Heiko Hund <heiko@ist.eigentlich.net>

Do not allow forward slashes in user provided config paths. The PathCch*
functions do not treat them as path separators, leading to "/../" not
being canonicalized. That, and the fact that Windows file APIs accept
forward slashes leads to possible directory traversal.

Discovered and reported by BreachX Zero Day Labs, using Typhon AI Mil v2.
Contributing Researcher: Vivek Parikh.

Reported-by: Vivek Parikh <vivek.parikh@breachx.ai>
CVE: 2026-78043
Github: OpenVPN/openvpn-private-issues#162
Change-Id: I371aafba18d336bcfd3912e92c18301e39bf6087
Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1885
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1885
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index 7c0a87b..e3ef8b6 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -68,6 +68,11 @@
     {
         return FALSE;
     }
+    /* do not accept forward slashes in paths, as PathCch* functions do not handle these */
+    if (wcschr(workdir, L'/') || wcschr(fname, L'/'))
+    {
+        return FALSE;
+    }
     /* convert fname to full canonical path */
     if (PathIsRelativeW(fname))
     {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
