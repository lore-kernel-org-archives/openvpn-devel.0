Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A6ECD8C90
	for <openvpn-devel@archiver.kernel.org>; Wed, 10 Jun 2026 17:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jzk5FBDFhGb+OBz9HZdyBNlLJsEiuYjtLo+wsXYm758=; b=F6369iXFLkljXnGeDr32aimIH+
	U3++0tbs9jGoyCdWePCjv5blSpB0Pck/mJXHbSrnFIUFHaRFGYznubHwzWZRT9sQDdZv4TaIJVXJF
	WVBATSxQD1iLI1zAdzuVx+wq9DWcG4CNO//gFPFYa8yum6CiUms6NBxlN5fKnYRAvjuQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXMWG-0006yv-HK;
	Wed, 10 Jun 2026 17:15:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wXMWF-0006yo-Qq
 for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 17:15:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oO0GcQBPvOzuSAR93ACa3NiPGqLSmOdGR8yPfxlwdzI=; b=nU1EJuWSMoFrh4WdgmdTjlqwJV
 qb1D1tvY1avclvrEbyJeFRd93qbGtFM9oXktO+ZX+xn6v+DrpsXjuf+VKy0I10g5KYqc3cJGwPKUR
 7uxjnwKKD1rk1T6oeit2FvFEuL0wYwtiRbxnXUWM/g3zPvaep6IQuaqdORiwkG8W+5FQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oO0GcQBPvOzuSAR93ACa3NiPGqLSmOdGR8yPfxlwdzI=; b=KzNkjMgp52J8VCg6ltoreowpwt
 Y5QjI2pPdqF+fGbOOJLgb5Fg/CiJKIvlB7pMbihZthWkoTZZ3E/Mf/btJ4lN0TMxcaMR755QgREFt
 5PPSfX8vFkMr1otnBJ6uqEoYG8S1dZIxNn2aG0auC+e2OEzz5CdhHMalHl3BlXkWI9G8=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wXMW9-0007qr-PZ for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 17:15:09 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65AHEm1X002952;
 Wed, 10 Jun 2026 19:14:48 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65AHEmvu002951;
 Wed, 10 Jun 2026 19:14:48 +0200 (CEST) (envelope-from gert)
Date: Wed, 10 Jun 2026 19:14:48 +0200 (CEST)
Message-Id: <202606101714.65AHEmvu002951@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260609152103.27418-1-gert@greenie.muc.de>
References: <20260609152103.27418-1-gert@greenie.muc.de>
X-Headers-End: 1wXMW9-0007qr-PZ
Subject: [Openvpn-devel] [PATCH applied] Re: GHA: Maintenance update June
 2026
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

The usual thing... (no code changes either)

Your patch has been applied to the master and release/2.7 branch
(long-term CI infra maintenance).

commit f9e6d5d724851a938a0c064307db513df469eb62 (master)
commit 993488af46c9b89fdcd663656c10a801f13038f8 (release/2.7)
Author: Frank Lichtenheld
Date:   Tue Jun 9 17:20:57 2026 +0200

     GHA: Maintenance update June 2026

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1710
     Message-Id: <20260609152103.27418-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37138.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
