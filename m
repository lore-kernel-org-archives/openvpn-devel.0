Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0424CD4851
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 09:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=12u5XCiOD9sKjhz615QQ24ldVNvZZSlgY3Ii4SbUko0=; b=TIvsGhaAJciOOgUpu4YvDnSiSH
	ZbnnwKUgjmSLM8+mi0JNEShmG9HFqFlK4CW46gsug3YKF9nkND4ersE186H9llNP8xdz/2Xza6E4M
	aG0op82asO6O44kneM+2EFAvh/+eXnG1kXbgIUVsBXJX6RSo3nq7PyytKMlo2XT/WMAs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNSE5-00051J-T3;
	Thu, 14 May 2026 09:19:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wNSE4-00051A-0x
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 09:19:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mYBy7O91h8gttg1Er3MEOvdqrKcXnYUw+tdgy4ToglI=; b=G2zwjG3O2+2nr8jJNXbH3SwgyP
 D80ob/RODY8H+13LvlWqYUgOozyqEqkakPwjaxjJMdCzzpLtyxVwpt8BUVhqK2vXSQwG/eMazyFu2
 +OyZfK5HNYUdc00mPHImAbTBBRM0m5gv1Xd+sh3nEipdNI/gotyyaLeGgH5Yre0PtCq4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mYBy7O91h8gttg1Er3MEOvdqrKcXnYUw+tdgy4ToglI=; b=hKs5Z1tn9vQ+lAvMGLD2PBLIl5
 R+cy8A2rHKvcbNf7SDQkkrCTx3Rt84RGAJcHLNunHBo5NtzmqX9O+uvJyXEl3BJxMaHqtnA/YAoEq
 AKveJarEXPoMxbWHpym/vFIjQKyS5e5ZJbCCMDV+67ysfZ1cw55MmpYeROsoFDXa+BPA=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNSE0-0002Zd-UF for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 09:19:28 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 64E9JI4b018222
 for <openvpn-devel@lists.sourceforge.net>; Thu, 14 May 2026 11:19:18 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.1/8.18.1/Submit) id 64E9JIUh018221
 for openvpn-devel@lists.sourceforge.net; Thu, 14 May 2026 11:19:18 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 14 May 2026 11:19:12 +0200
Message-ID: <20260514091918.18197-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <gerrit.1778239616000.I3d391016dcd3c66e58f3f05b356bcd419224acb1@gerrit.openvpn.net>
References: <gerrit.1778239616000.I3d391016dcd3c66e58f3f05b356bcd419224acb1@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wNSE0-0002Zd-UF
Subject: [Openvpn-devel] [PATCH v2] openvpnserv: Use same variant of
 UuidToString and RpcStringFree
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

Probably not a real issue since it should always use the
W version in our case, but still unclean.

Fixes a cppcheck complaint.

Change-Id: I3d391016dcd3c66e58f3f05b356bcd419224acb1
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Heiko Hund <heiko@openvpn.net>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1671
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1671
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Heiko Hund <heiko@openvpn.net>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index e25c511..bd310e4 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -3484,7 +3484,7 @@
     swprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),
              L"\\\\.\\pipe\\" _L(PACKAGE) L"%ls\\service_%lu_%ls", service_instance,
              GetCurrentThreadId(), pipe_uuid_str);
-    RpcStringFree(&pipe_uuid_str);
+    RpcStringFreeW(&pipe_uuid_str);
 
     /* make a security descriptor for the named pipe with access
      * restricted to the user and SYSTEM


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
