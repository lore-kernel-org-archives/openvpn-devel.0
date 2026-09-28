Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F53BCA5FA5
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KOxJG7v6hl0p9iT3F5W0nWFI1VZtMoI3k+lAs+Fddu0=; b=CUWWZIh2p4XgQT/5ccn9wnPtGN
	saLsRwH5k1ACDMnErtf+6ruh9NmDyWBrlD7mB6ie93v9qb3juCZPofH1oEO7UVjrpY2ZvP6r7xgJW
	oFfG/X0W6JBOvDZE8UpVax9Ss0wTUNEczZYdLw81lg/dsYWx5UnOLFqsOsgC/1p/z4QQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBDVX-0002uw-NK;
	Mon, 28 Sep 2026 15:43:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <drew@linuxkids.com>) id 1xBDVW-0002up-Me
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 15:43:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=htXHWzcn/EPRurmyoB3oJoM0uKNCzIAh5mmayUjMreM=; b=mEhurX6bx3AoZWni+bXzirlk71
 9j1Aj3A3Zpv0YEvLWVMG7bw1E/sdX0NdWdBXLWfhHtWKK1M7XYCuBJ0vbELp1G4oKrhx5Q1HrEejq
 u8OvtKOR0QFGQCPmnwdMjXE/FTPThVC9eyGeAV0I5FYpN4gYA4j1BD7T7Paj/D0mdzQ4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=htXHWzcn/EPRurmyoB3oJoM0uKNCzIAh5mmayUjMreM=; b=JDkNhCbSuwcqX4gyWU4S+qaZZJ
 kUEQTThtYYmFybphGyFdB9tn6jqsugWSbQ+W7BdzHApM60wnaIy+G4dYGKpWdsFc/lbC576yY12fX
 N44fcfurNqOVvfTmY8xVx8AuzF9i3BRGMj+VTZpdWSyipjveYWNzsnSHJ/NSHKcoqIgs=;
Received: from mail-vs2-f42.google.com ([74.125.227.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBDVR-0005ol-EP for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 15:43:10 +0000
Received: by mail-vs2-f42.google.com with SMTP id
 71dfb90a1353d-5c98e1942dfso2743008e0c.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 08:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxkids-com.20251104.gappssmtp.com; s=20251104; t=1790610179; x=1791214979;
 darn=lists.sourceforge.net; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=htXHWzcn/EPRurmyoB3oJoM0uKNCzIAh5mmayUjMreM=;
 b=pMCSgt4Guml9RNpK7ZKu65XLE9Z8/AnFyr4Un23GAkl+ERB8pskyXyOPqGqQvq3Hi3
 zh7UVRFOR00KAEZ8eZK7DJ+qDnQ+IoriiUzmZLCVr/eCIbS4wmZX5U1LvYWlYSu6JDeN
 HC4lvYOdD+Jmr8m04yqNg3TiS2IyvLyn/dBiyzcU1dm0SZx/Nc+7S4wQYFuBEENxLY+T
 OpE9jCQdoSHX/vYFAwQAQ9E8gtCBJFfomTYLy4pk0fgo6B5z2pekp29k1+qvOGFZRNjN
 oF2iGxU4B2ZtPC5lbZ7ZUApXEprHDlhSVXqO9/CgD3TldecPWNn8h3Ep2Jqs2frx1wfD
 TaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790610179; x=1791214979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=htXHWzcn/EPRurmyoB3oJoM0uKNCzIAh5mmayUjMreM=;
 b=mHj8LkSCOBcmvkcSbJLiyU1DLQjX/ilCHV4ynJgCIiFURywUeTLjMDE8c8YC1pf1/J
 jdQlU1EupXV+0FkAVrPDlaMx41m1hYJGVmbSKa1t7CL4JnLfYJQ+BTeoS3alUbbtDXPU
 lpZ2QSFwk3ofu/WZq+ryyaKpe8Z1Tv7pVO/dSdXSaMjFK7XYvUsVaFQEE3K3av3f8NEt
 oJ2gTw8tVhiyydhUVpsHSQa1YzRBDyUx5/p44g3MlSS9cog2JSoR67ZcDjlYUh6z5+Eh
 oj2dfJsCUMWEEB3eN1Vc8eQYJy+vTQdGAf8j3AdgFWpwjITEqdRr+AxsTflTBI6ORa2Q
 smFQ==
X-Gm-Message-State: AFq9FYJfb0amnG3KgE5GukO1bVZk3exBfES3mdRVeewd16yxAh2k2PtU
 W97mE1zmUw0pKrYpYS6UoLQq3MPWo1k3qrBste3sNBpKpnws3Q8B4a2BEetUc5R0Oa41szJj5fD
 cbwh+J256
X-Gm-Gg: AYBFou2qGZ6OHDIdGuCm6PqxURxtji2qzdDHoFM6AcBrOsU05GuwOtycr39VX25WipB
 H2+1fgQ4TqWnhQ0wTaJ1YBGjpG/t/z1eCA8p8WbwviOhShaltV0UbvL8BmYejBb9zrzLhIC6awl
 HDl7gWwPpGUwwMRj6bWGmRUK2QvQVAXOCK8I7VEqjxYWHmboeGss5xop7kygDllloxL4Ju5RbBF
 ZnIVAW7LXPePssoHibfKdTk6hBDdfydyJWCY2kiHr5eGv3pAsPVk22+Qxb83ewxBxRrV9wGQZOZ
 jEpG+/5Szx8MW8vJ3bV4MpFzQisI4OgFvyFH53OvpfMQXZoxUOfvQrlbcDCBU85kbqozeFckArk
 HGuHPSJHi0CktvRkdXUF+2TvPzbmeboQ66UmSnhce4eewAXWs2R92bwCjnP11cLgUl2rNx5NU4L
 OKZWZYbIzyTNRnKLaLBY3D0MMj3eUbloNAPJrVBbzn4Xfmr3vV5cBIo2/NYm3flai8yExuWJfDG
 iIWSKEgeCurMK0uKQ/H8aSnhsDU9wLZfxJhneS08UCxezfG6SVOnKyY8+1DwfUzZtziyRVPQQ==
X-Received: by 2002:a05:690c:c609:b0:865:838f:485b with SMTP id
 00721157ae682-8a64860b4dcmr58849607b3.4.1790606252796; 
 Mon, 28 Sep 2026 07:37:32 -0700 (PDT)
Received: from MN-277C755CCA3B.localdomain (71-208-239-209.ftmy.qwest.net.
 [71.208.239.209]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8a860e5e9besm45668487b3.11.2026.09.28.07.37.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 07:37:31 -0700 (PDT)
From: Drew Blokzyl <drew@linuxkids.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 28 Sep 2026 10:37:28 -0400
Message-ID: <20260928143730.47047-1-drew@linuxkids.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260922140520.71500-1-drew@linuxkids.com>
References: <20260922140520.71500-1-drew@linuxkids.com>
MIME-Version: 1.0
X-Headers-End: 1xBDVR-0005ol-EP
Subject: [Openvpn-devel] [PATCH v2 0/2] Stop failed cipher/digest lookups
 from polluting the OpenSSL error queue
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
Cc: Ubuntu <ubuntu@ip-10-241-5-229.remotetesting.secureworks.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Ubuntu <ubuntu@ip-10-241-5-229.remotetesting.secureworks.com>

Root-cause follow-up to the "CRL: cannot read CRL from file" report
(GitHub #1103, PR #1104, Gerrit change 1950 for v1 of patch 1).

Changes in v2:

Patch 1 takes the shape Arne suggested on the PR review: cipher_get()
returns NULL for "none" before touching OpenSSL, no error marks and no
wolfSSL shim, so cipher_valid_reason() keeps finding the OpenSSL reason
on the queue when it reports an unknown cipher (Razvan's point on
Gerrit 1950). The CBC-sibling probe in cipher_kt_block_size() and
md_valid() are left as they are and named in the commit message;
measured on the same rig, the entry the CHACHA20-CBC probe leaves does
not survive to the next client instance.

Patch 2 is unchanged.

Validated again on the aarch64 Ubuntu 26.04 server (OpenSSL 3.5.5,
DCO) with gdb watching the queue: five client instances (UDP, TCP,
CHACHA20-POLY1305, a plain one after it, and one against a garbage CRL)
enter multi_create_instance() and backend_tls_ctx_reload_crl() with an
empty queue, four CRL replacements give four clean reloads, the garbage
CRL still fails with "loaded 0 CRLs" / "VERIFY ERROR: CRL not loaded".

Drew Blokzyl (2):
  Do not look up the "none" cipher in OpenSSL
  Make CRL reload EOF detection independent of stale error queue entries

 src/openvpn/crypto_openssl.c |  9 +++++++++
 src/openvpn/ssl_openssl.c    | 13 +++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

-- 
2.53.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
