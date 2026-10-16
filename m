Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BA2CC6B38
	for <openvpn-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/da0AQlK+cXWnC7xrWJmDyhKJE1MOTAevJJbf3rk5ek=; b=UdV00YHTQXWEGzKw5uiO68+lob
	bpPO1QS9C0TipHhW/7A0eKx1EGP0vN9rZXoY98IemVqMfGpJRqZDoyHZfdemRIH74/xU5CSTTXXlV
	S5HGgFtQHSGnb5BZ7lygP0N0M/jDFjygLsn5BHfgMngPwuZ1HUxHITrKEdJPMDElCqW0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHcpd-00053Q-TL;
	Fri, 16 Oct 2026 07:58:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xHcpc-00053K-SF
 for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 07:58:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1cr5G2mJkLzfzBa6GsmxwDCcI6kfgPDVyyMvbLLBYvw=; b=Ogvt/lZSmpXhTGvyqzBvmSsw7p
 E9iNYAt+X+ouP0eVC9UDCOfnZjQxnI8aE1n32v2WfStm6ZYBCvjvSybW+dtrLHEl1rRyVikaY2AeA
 +aMW0A5eJzK3ciJuwrhEaJ4z/NCSWmtnz+4XGoK37PI+k9JZKzBFBGJKZFwHbGIw1hAo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1cr5G2mJkLzfzBa6GsmxwDCcI6kfgPDVyyMvbLLBYvw=; b=N6nJ4epHjL/ofGbrNdcKM9o8CU
 DG283eZUKM08MFo6LbQp+cPft4wZj3N6PIKHcox7zrhkEG/hBaVcssocTTQCzoDhuNL79Q2xR8vJE
 xM+KVq8fMpsZNQxnH7UTFpnxo4i/3wOGipZ/Vee9pu9I6avNVrYGa2B3VOCSyHCLoMcA=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xHcpY-00064G-V0 for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 07:58:22 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69G7w5RY035624;
 Fri, 16 Oct 2026 09:58:05 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69G7w5JH035623;
 Fri, 16 Oct 2026 09:58:05 +0200 (CEST) (envelope-from gert)
Date: Fri, 16 Oct 2026 09:58:05 +0200 (CEST)
Message-Id: <202610160758.69G7w5JH035623@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261015153237.10690-1-gert@greenie.muc.de>
References: <20261015153237.10690-1-gert@greenie.muc.de>
X-Headers-End: 1xHcpY-00064G-V0
Subject: [Openvpn-devel] [PATCH applied] Re: Convert Changes.rst to Markdown
 (2.7)
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

I did not compare things line-by-line, trusting you and Razvan to have
done that :-) - I did check very carefully to not break the UTF8 characters
and I think I succeeded in that ("I can see chinese characters displayed
fine in 'git show'").  Out to the world...

Your patch has been applied to the release/2.7 branch.

commit 9438ab76c99081d225ec62d3bd94bf5c1ad29856
Author: Frank Lichtenheld
Date:   Thu Oct 15 17:32:27 2026 +0200

     Convert Changes.rst to Markdown (2.7)

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1988
     Message-Id: <20261015153237.10690-1-gert@greenie.muc.de>
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
