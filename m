Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1640CD4F48
	for <openvpn-devel@archiver.kernel.org>; Mon, 18 May 2026 08:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=epfXtp2kZbg4XiOGIvHunSeUcAy8G9VHnbTRG1hqUa4=; b=lPUeTrRtury1YUf3vHc1b/EUl1
	73f7g4BcwjuxhVvBeiS9Wq0zM02qx3H6rcEHstGMeoIrQCJywkxKMNq0cghS1GzakXDNLMku7Q+0p
	JNCmYZ8OMp7Rnc3AT+RGojzZ/zmqLbHYBqheqCsJu0RExHInLibeSFbkLT7STbB0m1zg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wOswh-0000jp-II;
	Mon, 18 May 2026 08:03:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wOswe-0000i0-Io
 for openvpn-devel@lists.sourceforge.net;
 Mon, 18 May 2026 08:03:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:Subject:
 From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OVXmPTgsGRLQ0BLjZJ4fTq17yzY7Ai1/ycrgcXq2zuQ=; b=FCGSX+UYnqcdHuOdj04GkDNix4
 G0zNNla7UCVSqCzC2SYNC2ROcFwmkIlmDBa++3brVHsK4aLKdFJJYrLKgCJyj/yjYM5w4BJNC6SFY
 nuUjQwmsEeYWGQuCN6IPlgW2eIKTiNYiWF1AWs+Y2y9MdXpx2GTITHLdagFhQ9kBP2/A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:Subject:From:To:MIME-Version:
 Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=OVXmPTgsGRLQ0BLjZJ4fTq17yzY7Ai1/ycrgcXq2zuQ=; b=P
 KTX3NktoEF1eLlKfnJOponWdTv2sjyWHtdjrj6V+avJlawpeXprxRU5UXrWS9BpDEIqlvNz6oQbst
 7p3hRfGqFmjSwo+oE5rcPajYfRqMAC6ZROhXKvzaS2HFND/6BxCyP78U2YVYBrlTdhuOVai9WBwLt
 zKMWIpwgJm1zr5SQ=;
Received: from mout-b-202.mailbox.org ([195.10.208.62])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wOswY-0003IM-MP for openvpn-devel@lists.sourceforge.net;
 Mon, 18 May 2026 08:03:22 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4gJqzs4hlmzDs1d;
 Mon, 18 May 2026 10:03:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1779091385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OVXmPTgsGRLQ0BLjZJ4fTq17yzY7Ai1/ycrgcXq2zuQ=;
 b=axajOCTMt6/huoYKt2shIlLYeBRIDabqWT6z2rfBXQIbvQukn7e5BVqwfLuJcTaCg/cVHQ
 GTaYnEI2o7gcAQm/ZgNQITdwAwASJOdFReJX/OBDozMn/Wda0M/mgLzz7ToXi8HgwrKS2e
 mjWGwR/ETvPTh6LGZS8fJOIh1Yv1ymSsR7tbG1BKRboCDxRCnRlZiqu+ZEZwevcsXc2hXr
 KB+3+OuveBUrnUFeIApde+vVPDn49aFhgywo5npPZSpzhxNqGCiQj7olTVeI36SGNPWgA+
 Ul9iibHKJBIOq4i6BD/A6iSxHDY0hwlQk+2kT3OUUFwJ3l3509vSZBERBN7YyQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
Message-ID: <6de6a27a-849a-4a41-b37e-62a02a7122e7@mandelbit.com>
Date: Mon, 18 May 2026 10:02:07 +0200
MIME-Version: 1.0
Content-Language: en-US
To: openvpn-devel@lists.sourceforge.net
From: Ralf Lici <ralf@mandelbit.com>
X-Rspamd-Queue-Id: 4gJqzs4hlmzDs1d
X-Headers-End: 1wOswY-0003IM-MP
Subject: [Openvpn-devel] Debian: OpenVPN 2.6 stops passing traffic after
 kernel 6.12.88-1 upgrade
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
Cc: praveen@debian.org, 1136961@bugs.debian.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Hi,

forwarding this Debian report for visibility:

  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1136961

where a user reports OpenVPN stopped passing traffic after upgrading the
server kernel from 6.12.86-1 to 6.12.88-1 from trixie-security.

---

Package: openvpn
Version: 2.6.14-1+deb13u1
Severity: important
X-Debbugs-Cc: praveen@debian.org

Dear Maintainer,

    * What led up to the situation?

linux-image-amd64 was updated to latest version 6.12.88-1 from trixie
security
to fix recent security vulnerabilities.

    * What exactly did you do (or not do) that was effective (or
      ineffective)?

Our production server was updated first and staging server was left on
previous version of linux kernel 6.12.86-1

    * What was the outcome of this action?

This broke the production vpn - I can connect and get an ip address but
cannot
ping 9.9.9.9 or browse any websites (sometimes I need to lower the link
mtu of
tun0 interface to 1250 but that did not have any effect). staging vpn
continued
to work normally - ping 9.9.9.9 or browse any website. So I removed the
6.12.88-1 kernel package from production and vpn started working again.

    * What outcome did you expect instead?

We should be able to update the kernel to get the recent security fixes.
From
the above observations I think this breakage is related to the recent kernel
update - which affects ipsec related parts - though not sure if openvpn also
depend on the same sub system.

I'm not sure what logs would be relevant here, but I have a snapshot of
the vm
that was not working and can run any tests or get any logs.

Attaching the server configuration for reference (ansible template which
gets copied to server).


-- System Information:
Debian Release: forky/sid
   APT prefers unstable
   APT policy: (500, 'unstable'), (1, 'experimental')
Architecture: amd64 (x86_64)

Kernel: Linux 7.0.4+deb14-amd64 (SMP w/8 CPU threads; PREEMPT)
Locale: LANG=C.UTF-8, LC_CTYPE=C.UTF-8 (charmap=UTF-8), LANGUAGE not set
Shell: /bin/sh linked to /usr/bin/dash
Init: systemd (via /run/systemd/system)
LSM: AppArmor: enabled

Versions of packages openvpn depends on:
ii  debconf [debconf-2.0]  1.5.92
ii  libc6                  2.42-16
ii  libcap-ng0             0.9.3-1
ii  liblz4-1               1.10.0-10
ii  liblzo2-2              2.10-3+b2
ii  libnl-3-200            3.12.0-2+b1
ii  libnl-genl-3-200       3.12.0-2+b1
ii  libpam0g               1.7.0-5+b2
ii  libpkcs11-helper1t64   1.31.0-1+b2
ii  libssl3t64             3.6.2-1
ii  libsystemd0            260.1-1

Versions of packages openvpn recommends:
ii  easy-rsa  3.2.6-1

Versions of packages openvpn suggests:
ii  openssl                        3.6.2-1
ii  openvpn-systemd-resolved       1.3.0-5+b1
ii  systemd-resolved [resolvconf]  260.1-1

-- debconf information:
   openvpn/create_tun: false

-- Server config:
https://bugs.debian.org/cgi-bin/bugreport.cgi?att=1;bug=1136961;filename=server.conf.j2;msg=5

-- 
Ralf Lici
Mandelbit Srl



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
