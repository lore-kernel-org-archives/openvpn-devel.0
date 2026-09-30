Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526B0CA5FCE
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2tj5r+SxxhGc/s/sRwMzaN+uFT1rH+ZUoMdYPXXIvrE=; b=ZqUENr+KnS4dI2z+HtvcH7aZhc
	EfaZBeftIQSCtUxe78VfxfHMl3UcgU8QYwPqJarzYFKUwZKepaE6Jy+VURryFvyHOmFTbEjUn9i+B
	+q1lUHLahT7tmQt4HQ1a8uxPCvje2cBI97sllQJRnOscBy6+iShOstHac3BEwSso2Zqw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBuR6-00028M-72;
	Wed, 30 Sep 2026 13:33:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <drew@linuxkids.com>) id 1xBuR4-00028F-Kb
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 13:33:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=evh1pR5G38EdV/dDo1EytuMs32JZynyib+71Qvcipqc=; b=VzkhPO8t/zrFb/8HjPrdUTQJgS
 UdQVbNesKgSeMACRRxz/OBssCDXYXiIs8HefrLw9p+GAOfaLAHPLq5zpvrlUZBYUeYsV7BBxlS9Wo
 Ft14geH7JYPII8ZZJkUtLrQsm/V0MyCb8Ob7DkSOW6OSB5xFe152YGuUkVGq9M2zHNcw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=evh1pR5G38EdV/dDo1EytuMs32JZynyib+71Qvcipqc=; b=E7ujyN3bi2kDkgXYJoR7Ac/ltT
 X3luEozXHkmuoQA4YiarPQo6z2ajIurdIQD/x4mRqTdUr129B6o3e1tcSvWuKuv3HkJftY9BjUIC0
 NYGs58OgD8iVQBskNTbPd1yMvu6hZQ7NbB5r0AQ2cmnw5KkCtpHI6brOIzbFcVUKxMB8=;
Received: from mail-vs2-f36.google.com ([74.125.227.36])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBuR4-0005Gf-Oi for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 13:33:27 +0000
Received: by mail-vs2-f36.google.com with SMTP id
 71dfb90a1353d-5d4ea61c057so841876e0c.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 06:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxkids-com.20251104.gappssmtp.com; s=20251104; t=1790775201; x=1791380001;
 darn=lists.sourceforge.net; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=evh1pR5G38EdV/dDo1EytuMs32JZynyib+71Qvcipqc=;
 b=WX1W24+84x7eK4HzcgHd9+gt/9hWJa1g4ix5jy+aji+sT+zXhsbBgsrzfgJ2eEdgEu
 aJn987ZR58YYiMq+b1tQNcZbY28qWFBHQRy/Kj6wFKySxwjWQrzCo1vjEH0FTDzvs0C9
 khJ82RaEJSEJvSVicKjyERCnujdjzwufHr/stCharUM4A6FbWVBsXpd83qTzun8pJw9y
 0GZ35DbWpoH3GBB1HQDyhRFM4ZUBY2JIZBDxZNDBMO//IoIxH9XAO4S6II9MkFE697P7
 Yti2NTH7CuSrjImKwgyq8jfA7KS+VorihKIFmylJqm1Cu4hkKnu5I4giGXx0RbV4lO5f
 VuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790775201; x=1791380001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=evh1pR5G38EdV/dDo1EytuMs32JZynyib+71Qvcipqc=;
 b=oQUhkaYZcUbuXWBq0JH3QRqnpJXoQuRTC4HS3MR9+42pQuKIciCm1j45AvW6Tb/HCK
 8tYYoXmQexlzIUcAxOUcj4HkFYaSsuwrx1ckcZJJV0Tuz0LFnQdNQlGX/f8gcHS/+yTG
 341IVOV+Mft8kAV7jooy62fnJvvzofWXIrVwc/7YHCr/pL3UUv89VkI6it3ki+GcVRAb
 9pKfTJQr8qE+SPqqnrDWBAu8QhcWF708TRBnOLK/wCQh0NCdi5rojk6hEEv0L1/EYyqF
 UF4R8deau+f6YU5jjQlE1Ae7RmGvcQNuUJt/A/BQDoojL/mkIyYo/E2zHotl6TLxinXd
 ehIA==
X-Gm-Message-State: AFq9FYLGmguLZlxCH2T44D6JQV2pjfAiULnzXIhUHaN3CnqvfAXTHXa4
 FcVBi6Z4DOMjMGlxMGjFgGsd5XNIwwWo3bXtxiLerK8H57hkKbNum2OotQR3jaO2OGA9KJNAy/x
 qsn4cyg==
X-Gm-Gg: AYBFou2QvEODiLB2u7j7HEiip3bDoTxw6gMSZgFHSLSUN2U52WPZxx83YXbxKaXQYt4
 csr/zPXWm4ZgRSOoQFldr+5lX1pedRYkbg2SJeLx50/bTMbIqBFev/LOiKCJo8Trjqd6brOyFLx
 oh+xzXsTfs7oS/TVJdxFgYzcy7EWhA8acXykbzr7Yehh+U5STL75ffGdwwrFU3tbKFyzvYUtCxn
 YgoZcUtVhvhozDoQKRILhp8kNvEv6tsJ+HaZEMKunL68wftVdHDZ4vdKUectM2qFrkNdb+NQ6IG
 dJfx8fA4QaS4Ian0tny0P7XbK00kGA/0EWby9ZrYOkWdi0iKs7Eqimu6POtF38VevGJ3APrjFFo
 2rj+VZGk5Y8R6pkjbfzwqoRZunAqpoN8HjlbJ/ij3QpyWzJBs2AryD27TBFl7bVoPsflhxRZqNH
 vIlaFrDO6hPM5bZkbKwjCRBnQq1UdzxqxFAmOfdVnjdc1lrbFTmmkx8qV2jGan/stNJWB0GLmlL
 oackWP/tR306dlCzgOJmb0rYKMS0G/Gm3ZTsFAX6XuXDqsFw9B8EhXM5VbMwj4=
X-Received: by 2002:a05:690e:4885:10b0:673:4a02:a126 with SMTP id
 956f58d0204a3-676834802c4mr521959d50.33.1790774830078; 
 Wed, 30 Sep 2026 06:27:10 -0700 (PDT)
Received: from MN-277C755CCA3B.localdomain (71-208-239-209.ftmy.qwest.net.
 [71.208.239.209]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67680ac3521sm704189d50.1.2026.09.30.06.27.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Sep 2026 06:27:08 -0700 (PDT)
From: Drew Blokzyl <drew@linuxkids.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 30 Sep 2026 09:27:05 -0400
Message-ID: <20260930132707.51452-1-drew@linuxkids.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260922140520.71500-1-drew@linuxkids.com>
References: <20260922140520.71500-1-drew@linuxkids.com>
MIME-Version: 1.0
X-Headers-End: 1xBuR4-0005Gf-Oi
Subject: [Openvpn-devel] [PATCH v3 0/2] Stop failed cipher/digest lookups
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Root-cause follow-up to the "CRL: cannot read CRL from file" report
(GitHub #1103, PR #1104, Gerrit change 1950 for v1 of patch 1).

Changes in v3, both from Arne's review on the PR:

Patch 1: md_get() gets the same "none" guard as cipher_get(). Note this
changes md_get("none") from a fatal "Message hash algorithm 'none' not
found" to a NULL return; no caller passes "none" today (md_kt_name(),
md_kt_size() and md_defined() check first), so behaviour is unchanged,
but a future caller would hit the NULL rather than the fatal. Say if
you would rather have an ASSERT there.

Patch 2: instead of clearing the queue silently before the CRL read
loop, report a non-empty queue at D_LOW with the queued errors, then
clear. crypto_msg() only drains the queue when the level is enabled, so
the explicit ERR_clear_error() after it is what empties the queue at
normal verbosity.

Changes in v2: patch 1 returns NULL for "none" before touching OpenSSL,
no error marks and no wolfSSL shim, so cipher_valid_reason() keeps the
OpenSSL reason for unknown names (Razvan's point on Gerrit 1950).

Validation on the aarch64 Ubuntu 26.04 server (OpenSSL 3.5.5, DCO) with
gdb watching the queue:

- v3, both patches: UDP, TCP, CHACHA20-POLY1305 and a plain client
  after it enter multi_create_instance() and backend_tls_ctx_reload_crl()
  with an empty queue; four CRL replacements give four clean reloads; a
  garbage CRL still fails with "loaded 0 CRLs" / "VERIFY ERROR: CRL not
  loaded".
- patch 2 alone on master, i.e. with the "none" polluter still live:
  the new D_LOW line fires with the stale "unsupported" entry printed
  above it, followed by "loaded 1 CRLs" and no false warning, on both
  a UDP and a TCP handshake after a CRL replacement.

Drew Blokzyl (2):
  Do not look up the "none" cipher or digest in OpenSSL
  Make CRL reload EOF detection independent of stale error queue entries

 src/openvpn/crypto_openssl.c | 17 +++++++++++++++++
 src/openvpn/ssl_openssl.c    | 19 +++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

-- 
2.53.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
