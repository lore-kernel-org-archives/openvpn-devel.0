Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EC2C5516D
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PQ5bVtnrvl63V8NDGRrAaJB/CGZTPbPDw9cxVwl2Nfk=; b=N1S+AB0KCWsimvJHq48nlGhByX
	tFxkmlQpDrqkTKXg83otzrrvXcOB9iZi9YeLgDzTnV8Pp18t3HyhZP+QLloH2LqdlK2Re8mnydQqd
	wpHGOrSxpmKZnGGLRWfIE9NNNbrB++gl3o3rpmC5hFRyLbYPyKHS6oONGFeK1lQ2I1co=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpXdO-0007rr-AB;
	Thu, 30 Jul 2026 20:45:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wpXdM-0007ri-Pr
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 20:45:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pcnBmR8qLIdXKCqNoE2FlFLgiWR2nyIqq0tPL4d0UAQ=; b=KNJwVnmFC55mpyvF73+738i3S2
 OCkZpf4WO1bZ2mnvstyq6kFzFlSZZPHioPHXIhiTqm8apWEwyS7ZOivSfXAdir0fZMPTN9sDtPxIO
 ayoUbnjwQqAJTNL+SaCys9LApIAxnG6CCcrUlWuu7OdpBV5ydbcZdxgpjBpgtMHvkv/A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pcnBmR8qLIdXKCqNoE2FlFLgiWR2nyIqq0tPL4d0UAQ=; b=J8E8gYIzTM5SVpWYI0+T1bWS6k
 bP+fLlil8om1r880hjJwTLA/qxpS1S40rst9eCHNWmdYe2kPWB9o3WwJ1JlMFUoLp5g0IxpBU+RzZ
 vRXjM8DijmXcWJxGtlzuaMXNqIp+tGiGb1juS9yHRcg2fFN0y7RpVF4iZ+s4A4nmt63I=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wpXdQ-0004Xn-6N for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 20:45:41 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 66UKjXEO083476;
 Thu, 30 Jul 2026 22:45:33 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 66UKjXtB083475;
 Thu, 30 Jul 2026 22:45:33 +0200 (CEST) (envelope-from gert)
Date: Thu, 30 Jul 2026 22:45:33 +0200 (CEST)
Message-Id: <202607302045.66UKjXtB083475@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260730101616.28738-1-frank@lichtenheld.com>
References: <20260730101616.28738-1-frank@lichtenheld.com>
X-Headers-End: 1wpXdQ-0004Xn-6N
Subject: [Openvpn-devel] [PATCH applied] Re: Move schedule test to a unit
 test
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

Nice cleanup :-) - and the test succeeds.

[ RUN      ] schedule_test
[       OK ] schedule_test

Your patch has been applied to the master branch.

commit 4babf1873d905e8ddf0e388bb8d9ee4690738ed8
Author: Arne Schwabe
Date:   Thu Jul 30 12:16:16 2026 +0200

     Move schedule test to a unit test

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1828
     Message-Id: <20260730101616.28738-1-frank@lichtenheld.com>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38056.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
