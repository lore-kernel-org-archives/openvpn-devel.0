Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D28AC43458
	for <openvpn-devel@archiver.kernel.org>; Thu,  2 Jul 2026 10:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:To:From:Date:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IHJc6UP1xfWt6bgVx0qUZKNj9PBJDERmg4SF2zcto7w=; b=nC8bkcxN1fsls2RJH7pahJIXGZ
	ehD9lnqTNKAxpoZiIgs6MEj8l911Y+0Qm7aQtuZpXGONeehI9nqwfw4GsXH3AGgRxSuQGOnGaT874
	JDYznaeNA7PoDuSx4OgJb/K5mRWwnpLJ8Vi09jkcYUcoBfkxfqYyqlnWjweUJ7yW7cwI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfEvY-0003XM-0f;
	Thu, 02 Jul 2026 10:45:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <frank@lichtenheld.com>) id 1wfEvR-0003Wl-Hi;
 Thu, 02 Jul 2026 10:45:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EB2+WgROp07Y1P3YvymfB5gg6nEYKrpSo0DrXcKECks=; b=V1QlVQI2RvxG7vKTlzt9dRDTNp
 fmK3JkC5ec3xPc95s2P8abrgiz9axw/WdUFIJrNl+4hmXbb3L2BSK4eqnX+Y5qaaMdjDtAEk9jj0c
 GiySzkBPtbSuljlE+ydeZYe/Gfte5EHWOmxXrUp61WblqxKyD7QNEGrZsf6UAzkzMdQo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EB2+WgROp07Y1P3YvymfB5gg6nEYKrpSo0DrXcKECks=; b=C
 a3W4zDwKUrazqwOI/2Pq2AIrwywC6fSD8k7w4D6XQGRzE7FHWWgAJ4BRSt8hB8YyqP3/IRf0xdn4I
 s6/+5XHLXnylmYwrNhuDWGz6GMn+JXlkT3X4Tw+p4ssuXD5hxqTuR+RtxJO6dOLnyX9LKEgZ016KB
 A0ZYdHK46XIWTszQ=;
Received: from mout-p-101.mailbox.org ([80.241.56.151])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wfEvN-0000xH-Ug; Thu, 02 Jul 2026 10:45:46 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4grYSS70vHz8v1l;
 Thu, 02 Jul 2026 12:45:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1782989129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=EB2+WgROp07Y1P3YvymfB5gg6nEYKrpSo0DrXcKECks=;
 b=YKv0LyPa8/clBCWTchx+e7QQKpqus9NSfWUDO8gAZYR0Mh1sFDui53CDREa6tE5ZcmCQqE
 ozd4gF+en6lpGpRY/CsPC0/wBMOQ2DMnvZOJlkZ61mKxclQYnDLcmU+PaKvjaOMbNUdryW
 N5abIPD5IztL3YFrcrinBFJXIJjUuEO1hN9KJdU8H7Sm8Ly30nqPL2PQnObElXSycc+zmS
 tNzJiZbibnDXZXxEB5gJSAkFRzQB6xRpwhpDPnwsXWFhbjGTRw/Twz9x6X8JBbcDAy8Q+o
 bpG+PlLj3Q28YaceHoyEQz4beXeLHPvzbH5lvLqCNOpFM+qUoh2aTrqjFfKbbQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of frank@lichtenheld.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=frank@lichtenheld.com
Date: Thu, 2 Jul 2026 12:45:26 +0200
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-announce@lists.sourceforge.net,
 openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net
Message-ID: <akZBRtRlPgTB9KDh@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
MIME-Version: 1.0
Content-Disposition: inline
X-Rspamd-Queue-Id: 4grYSS70vHz8v1l
X-Headers-End: 1wfEvN-0000xH-Ug
Subject: [Openvpn-devel] Security fixes in OpenVPN 2.5 Git branch
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

As part of the 2.7.5 and 2.6.21 security releases the OpenVPN community project team
also decided to release backports of several of the fixes to the OpenVPN 2.5 code base.

Since 2.5 is not officially supported anymore, there will be no official release and
no preparation of source archives or builds of Windows installers. However, the fixes
are available in the Git repositories in the release/2.5 branch for people that
still produce releases based on 2.5 (e.g. long-term supported Linux distros).

The fixes backported are:

* Clean up metadata handling in tls_crypt_v2_extract_client_key.
  An attacker could repeatedly trigger a memory leak on servers that
  use tls-crypt-v2 and cause the server to crash. (CVE-2026-12932)
* Ensure tls-crypt keys are not setup twice.  An attacker with a valid
  tls-crypt-v2 client key could repeatedly trigger a memory leak on
  the server and cause it to crash. (CVE-2026-13698)
* Fix ack_write_buf use after free.  A race-condition could trigger an
  use-after-free error. (CVE-2026-12996)
* fix server ASSERT() on receiving a suitably malformed packet with
  a valid tls-crypt-v2 key (CVE-2026-35058)
  Bug found by XlabAI Team of Tencent Xuanwu Lab (xlabai@tencent.com),
   and independently by Emma Reuter of Cisco ASIG (TALOS-2026-2381).
  (backported from 2.7.2)
* fix race condition in TLS handshake that could lead to leaking of
  packet data from a previous handshake under specific circumstances
  (CVE-2026-40215)
  Bug found by XlabAI Team of Tencent Xuanwu Lab (xlabai@tencent.com).
  (backported from 2.7.2)

The OpenVPN support policy is documented at

<https://community.openvpn.net/Pages/Supported%20versions>

Kind regards,
-- 
  Frank Lichtenheld


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
