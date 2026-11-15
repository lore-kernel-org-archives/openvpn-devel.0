Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F270606A31F
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 21:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XKKByDYc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IJq53tld;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZNWhooeG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0GqxUOFdAy1aqPXm8dPbVfrOa/tkfxAxZVmgCyNaOmE=; b=XKKByDYc0koAMw
	dYqvmwppEqG5sO79/9JrcOV5npl5EjG5ouai+8qAgqDBXZmmEqgJIiGgMPDAzl+Ux0J/ZGoXXeJ2R
	SxMBzaT0MYzjVuJHAQ414DHpVWpL2DqJlghHBSuH9IjXWNW6iUDma3XoSS/jAUCYoLpfBtXQge2pr
	xvs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSi8Q-000000000FN-3ssh;
	Sun, 15 Nov 2026 21:51:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xSi8O-000000000FG-3ayE for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 21:51:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zXOGWbNwazZgg35dTz4HmHGtTA00PZhvvkqhNAU3fLY=; b=I
 Jq53tldCuz11CalKf/Iw0Bl/CAFEPh7WTK7Se8pkffMn9eIpIPrS/9iY70dgFf2zE2UDQweaWCxag
 LMYoFgNdmcb5AHC6AmQZZQW32p38eaHhRPmnPLt8K4y/Ub5yoNY9F1wpeD4fcSeXsk2hB7+AjEN1a
 cNaewuf22gd8heGg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zXOGWbNwazZgg35dTz4HmHGtTA00PZhvvkqhNAU3fLY=; b=ZNWhooeGbNzBdbmbNQhSTZRPax
 zfl5cWjP6hBk7mo/3U5S0X/m+WbjxfAStQk4OPf/ERhoTbYJSAHbPnGE1R1QnqxUsn7fR84S8R4RR
 1j58/uR51GSW/xUgryx2i2GP57W3iiZabKC5l+dZ7vtg0UZxCwqTkvZlulkCwHegKCG8=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSi8N-000000000Z3-1INr for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 21:51:36 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AFLpSrJ060827;
 Sun, 15 Nov 2026 22:51:28 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AFLpRwI060826;
 Sun, 15 Nov 2026 22:51:27 +0100 (CET) (envelope-from gert)
Date: Sun, 15 Nov 2026 22:51:27 +0100 (CET)
Message-Id: <202611152151.6AFLpRwI060826@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261115170015.10294-1-gert@greenie.muc.de>
References: <20261115170015.10294-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xSi8N-000000000Z3-1INr
Subject: [Openvpn-devel] [PATCH applied] Re: auth-pam: Include dlfcn.h for
 dlerror()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I still tend towards "just rip out the whole dlopen()" thing, but in
the meantime we can as well repair it ;-) - so here go, straightforward
enough.

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 59e30622405b59197d32d839cf5185521a0b1088 (master)
commit 3c367c6c36498fa18cacc87394ea2144844d592f (release/2.7)
Author: Razvan Cojocaru
Date:   Sun Nov 15 18:00:10 2026 +0100

     auth-pam: Include dlfcn.h for dlerror()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2184
     Message-Id: <20261115170015.10294-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41375.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
