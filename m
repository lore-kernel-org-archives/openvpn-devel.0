Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771AFC61DC2
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 07:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=patPMtnXLK2FTSFkhV1LQDphLNog1HbTgFo0+edTnww=; b=HV/0TyDXuvx+17D65HzGcVC38E
	F7UbZmClwbRIU9agilbaOt7UR3Is03zCTBJzJroVRYXJZ92Av873F2qy1iA65BPkV85DN6sr9Kxt2
	dwOe2wX47lAL0oO93X20pi84OEoWCt92mwQhJQ6GLUVlUcHH4GZyys3FIW4wTXifok00=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wz7yg-0005l3-VO;
	Wed, 26 Aug 2026 07:23:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wz7yf-0005kv-R0
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 07:23:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/upbsnP4WwtVU8/Xfgo+aMNgo+y/woYtah2iGhJ+eks=; b=MLBfTRxSHz1oYo6xrwuBbHDvkM
 y5ilWnnzpI6z5925+i/ci6dmrhJWFPaxJLPZnOtL+zTMgz+njHzrCDMB37ZYOcjo/VFXd2ea4tAXa
 035HalYsdRigeFz3GuU6EnOl3gc8i8KryKT6IvG23vdc8vYGFTCxw7PlPILTiuhD+Pjo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/upbsnP4WwtVU8/Xfgo+aMNgo+y/woYtah2iGhJ+eks=; b=JrJr882GyxWeVm2EOvqvK8FhTK
 R5UTB1n8k638vZ6zw+ysZDdAGOf+A+fJQThwUbaTobHq8WdDkbI6QqL9WTFsO7hmXuw23no1WBeFJ
 ZhIHZuCVgHzio65CszMzfEtxLA2MSyZpyqHya08ZW8xxFJ/SiN4PfWSretkrkPotzcG4=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wz7yb-0008UJ-9Z for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 07:23:15 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67Q7MxcF006652;
 Wed, 26 Aug 2026 09:22:59 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67Q7MxWY006651;
 Wed, 26 Aug 2026 09:22:59 +0200 (CEST) (envelope-from gert)
Date: Wed, 26 Aug 2026 09:22:59 +0200 (CEST)
Message-Id: <202608260722.67Q7MxWY006651@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260824160553.761-1-gert@greenie.muc.de>
References: <20260824160553.761-1-gert@greenie.muc.de>
X-Headers-End: 1wz7yb-0008UJ-9Z
Subject: [Openvpn-devel] [PATCH applied] Re: socket: Fix various conversion
 warnings
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

Closing down on the remaining integer conversion #pragma :-)

Not sure the IFNAMSIZ dance is really needed - setsockopt() will tell
use if it is too long - but we get a better error message this way, so
it's a useful change.

Since I wasn't sure about the changes to the resolving path (is the 
info.af always set here?), I added an extra run of the IPv4/IPv6/DNS
t_client tests on this (all pass).

Your patch has been applied to the master branch.

commit 0d257840e2130815376f94006b4b2671983109d9
Author: Frank Lichtenheld
Date:   Mon Aug 24 18:05:47 2026 +0200

     socket: Fix various conversion warnings

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1476
     Message-Id: <20260824160553.761-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38632.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
