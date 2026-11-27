Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BCB606A31F
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=M1mapGJm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EVn1DUCb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CesIqqyM;
	dkim=neutral header.d=lichtenheld.com header.i=@lichtenheld.com header.a=rsa-sha256 header.s=MBO0001 header.b=k20eRXRb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:To:From:Date:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=p+oq0V5Gwt22y4bZeNq4kpUFhxwKIOmRDTs5QD0qyEo=; b=M1mapGJmub10BPX2GGxPooZo25
	8V9spRaK3mxcY1JlQF/ePwgrmxaW1vEcwv8YbfWV5cTgg8X+mYF3jpS2njfwm3RXUq5RR7obC9ZN7
	Ft+dVCZBCHsboHXHreLot64bIY6w9Gl0vJFUyYVIWRHKm/UkvUeDrG3N1/NtDX+v7Dxo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWwbD-000000007H6-3H1B;
	Fri, 27 Nov 2026 14:06:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <frank@lichtenheld.com>) id 1xWwb6-000000007Gv-0Atr
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 14:06:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bOqbCO1jgxjojjKRMof9prcIu1+aHyGNx1F15LLJCsM=; b=EVn1DUCbxo8BErxTWI2dMyb7FQ
 l0joV6hjHN2cyAyipM3jrURgZeyqQsA5MTY79jBaUWTeXmzsMp+SCheXXTRTTKDV2mqJM3+fnUo8b
 +SuHMCbHwEafSdASakwfyu5ten3QAaw65BfJJ64wRmjjVgBVCMvxSq1N/m/OzmEkVvKw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bOqbCO1jgxjojjKRMof9prcIu1+aHyGNx1F15LLJCsM=; b=CesIqqyMPftmvjHkFhF96StNeE
 u9A9kuGfyUyTPyQgDrFivsNNzvagqVZRq52mYX5GJn1/6iXG1BKxSi8yMxVWvT4iSStc7IfTzS+ci
 KzpnuBaIsoG6gZ8OcVnejQxtIpwAdqocmUuYABnUdapZ7TzGTSSLRwuRUXglKC2hfAqY=;
Received: from mout-p-101.mailbox.org ([80.241.56.151])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWwb4-000000005dz-1sS3 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 14:06:43 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jbZw94vTZz8vM9
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 15:06:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1795788393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=bOqbCO1jgxjojjKRMof9prcIu1+aHyGNx1F15LLJCsM=;
 b=k20eRXRbszqWFl/QM1zOcXZ+atcQIoh0RPoSakX1r7AzSUZElvV7Wvktmekl/F+m41fu4z
 7w2QAdcjWpQZBRkpKknaeWmoQdzAwdCvzShiJ0U1oGicLuq1ui2Ig/Hjxa+ifOYf/jS7x6
 wgJWWEprh/gHQ/p7vS/mCEOxR4bILBAnZt7CnSuLPxDqV7Rcx72Zg7Eehd3CxRPfBQfqfJ
 EX1bKci71mcswMQB4FYCRa2whhV3UN3v6Lwxo61HsOedLsAjn1FYVhV0WR9j6rftIqixrW
 4Wy8MkpzQf/EHmjEH8cYe/GoZnuuFpG2FjW/2cDybcvXJVhmIhmnlAm6SJ/EHw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of frank@lichtenheld.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=frank@lichtenheld.com
Date: Fri, 27 Nov 2026 15:06:32 +0100
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <awmOaCkBE_sZ50To@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Rspamd-Queue-Id: 4jbZw94vTZz8vM9
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xWwb4-000000005dz-1sS3
Subject: [Openvpn-devel] About Triggering buildbot Builds from Gerrit
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi.

With many new submitters in Gerrit after fixing the authentication 
(yay!) it has become more urgent to add a way for trusted developers 
(i.e. people whose changes trigger automatic builds in buildbot) to do 
test builds of changes from non-trusted developers. So far the only way 
to do that was to upload the change again to change the owner. That 
obviously does not scale.

I have now added a new Gerrit Label "Build-Trigger". All trusted 
developers should have permission to set this label (if I missed someone 
please let me know in IRC). If you set it to "+1" then buildbot will 
trigger one build for this change. The trigger for the build is the 
exact action of changing it from "0" to "+1". New versions of the change 
will not trigger further builds, but votes will be removed, so new 
builds can easily be triggered by voting "+1" again.

This does not solve the issue that buildbot logs are not accessible via 
the links in Gerrit for non-trusted developers due to being hidden 
behind a VPN. That will require a separate effort to figure out. Logs 
are publicly available via the 
https://sourceforge.net/p/openvpn/mailman/openvpn-builds/ mailing list. 
But I would encourage everyone who triggers builds to also follow up to 
any failures to make sure the submitter has all required information.

Regards,
-- 
  Frank Lichtenheld


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
