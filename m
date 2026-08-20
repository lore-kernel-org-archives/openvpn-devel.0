Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65513C5DF87
	for <openvpn-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x611tOlbJwqARiZfswgHhOOE0zR+X8vVFhd5mkZQ9f4=; b=GRyRfFhn38+p2Larr/o8PlkmZP
	xc6tzdoZPxh9Oxs+5pDBTP2wiWdUpu3i1wyoSElcC3nbo9eGpjGW+vonCgfM7ZJPjI1xj25s+GEwZ
	HH7lB3X3kjHnlURBBMEES/7tIsyFKXDeTNyyahO4shlvaN7MRQyFh9aaAlV/79SwYNS8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wx08K-0000zI-LO;
	Thu, 20 Aug 2026 10:36:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wx088-0000yR-Nc
 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 10:36:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eL/PwVElmK6u+N1HU0Z2n4cBMIivB5peXdH4L6td9bQ=; b=Ll77DTbLL/1EOP5r2tKSXtR513
 I5tC6DRR8bi/SsAD2uLiGw37QJ+VJCrM4jI8VWWw68ZJz1H+9N0H2RNK32NSICOfGA0/trpgUHGIL
 ZzNx5Np/8lGjdCst0lPJDe9jaOmPM5lrUcDo0FFzWMcjGgdhl2SrIvybHPS2+Oz9/TEA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eL/PwVElmK6u+N1HU0Z2n4cBMIivB5peXdH4L6td9bQ=; b=hoUh9j3iKmdi1Se4AuSaoZc+j6
 HRkG0YENwn03OE5kPxrfAzNB4tVQ7IEZ60x6JdQ7JujkjOAduAdb0bf/xwPIp2XkkEvZxmB7xSOYI
 92BHMcglDX+7B1Z5MsloPvz71mC1tRs2JZxt9si8bXiG/9i8Uwb73SXFWMrFnbVQNUgA=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wx086-0005fR-S6 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 10:36:16 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67KAa1X4061983;
 Thu, 20 Aug 2026 12:36:01 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67KAa1p4061982;
 Thu, 20 Aug 2026 12:36:01 +0200 (CEST) (envelope-from gert)
Date: Thu, 20 Aug 2026 12:36:01 +0200 (CEST)
Message-Id: <202608201036.67KAa1p4061982@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260820091539.4592-1-gert@greenie.muc.de>
References: <20260820091539.4592-1-gert@greenie.muc.de>
X-Headers-End: 1wx086-0005fR-S6
Subject: [Openvpn-devel] [PATCH applied] Re: Reformat all shell-scripts with
 shfmt
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

.. and here come the changed shell scripts.  I have stared long and hard
at the changes, and most of them are really harmless ("reduce multiple
blank lines to 1, no whitespace after 'if [ test ]...', "braces for
shell functions on their own line", "reindent inner loop body in 
pipeline constructions").  "git show -w" helps :)

Some are a bit more intrusive ("change '( sleep 5; do_something; )&'
constructs to multiline) but I can't really argue that the new format is 
"actually bad", even if *I* like this more in the compact form.

Your patch has been applied to the master branch.

commit f781227c92a3d1017e9d8a67e83e4465b43edf66
Author: Frank Lichtenheld
Date:   Thu Aug 20 11:15:29 2026 +0200

     Reformat all shell-scripts with shfmt

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1793
     Message-Id: <20260820091539.4592-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38547.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
