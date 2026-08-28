Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6A9C61DBD
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gwFeHkCPGCNvszlUXhalaLWWI6KcfyAPE6d/VKTcVyU=; b=ZvAkXWosXiinc8leLjmSK86oCG
	pHZUvmCLGxec5xqAQ3QouCgS42TF5f4bYQMo1q2slVa8yX8+2Gj0UowxKkh3q7wzZsoDDh6pBl6DD
	NYhCCZTXuYZaeIQu4eG514zmDaQ0e4oY52/aKPGz+0T+ZMn0sInVEljDcaVEQUkKC4zA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wztkY-00083V-BG;
	Fri, 28 Aug 2026 10:23:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wztkW-00083P-TC
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 10:23:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v5ovCsFuWrxtRCBw7DrpHDqJDLF2LZcg4pOt9pmA/mQ=; b=gD4zlw3XGXtZwo62z/NYtVJizf
 t7sccw4cqMkLFq0SNvuez9tqQlhzwDWfsZosQM7aQcjFSUqBoS4Vts1ad5MCHqhRSiGyk1CsCC+Ft
 w9yZfjTu7o3OLyf5K5pqJTUP3d1Yv0Shw0o+2KSANAKZnHCp9Du8knKCYISXkHx8io48=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=v5ovCsFuWrxtRCBw7DrpHDqJDLF2LZcg4pOt9pmA/mQ=; b=JE8CGlSjGGxwEbUMR7y7UEcyLh
 I4P21WllWN/TNzveOihcsPH8fFoCTVFenN8uYMVQ29k2yKnHuiTZW2HBpzOPYswe92vgYqpSdXUFy
 h0HgckI05bjbynWLse9gRof/IVTBOCfwOUmeZmSVWB3tTA5/GmcTxRrkYtK8mWf9YfT8=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wztkR-00019F-HY for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 10:23:50 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67SANWdc081268;
 Fri, 28 Aug 2026 12:23:32 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67SANVcF081267;
 Fri, 28 Aug 2026 12:23:31 +0200 (CEST) (envelope-from gert)
Date: Fri, 28 Aug 2026 12:23:31 +0200 (CEST)
Message-Id: <202608281023.67SANVcF081267@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260826204139.28986-1-gert@greenie.muc.de>
References: <20260826204139.28986-1-gert@greenie.muc.de>
X-Headers-End: 1wztkR-00019F-HY
Subject: [Openvpn-devel] [PATCH applied] Re: route: Remove unused function
 route_list_vpn_gateway_needed
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
Cc: openvpn-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Another easy one, with no conflicts, and no questions on "will this
break functionality" and all this ;-)

Your patch has been applied to the master branch.

commit 5aa5a11d395b9b18b9d814724eddb564e28d7e9d
Author: Frank Lichtenheld
Date:   Wed Aug 26 22:40:47 2026 +0200

     route: Remove unused function route_list_vpn_gateway_needed

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1864
     Message-Id: <20260826204139.28986-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38743.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
