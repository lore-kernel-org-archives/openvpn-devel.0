Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0D8C982FE
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 14:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hGcOPOVCM3tNKMvWZ16NCkn/u71RvA4jhZASXMPboMo=; b=bpa3/UCGd027juzh4NJ/fI7LEN
	ib7WhCZ+M9efCHet0C8x+vW7RZFTSN4UsEoWqPC7wJ0QgmCMEZweASDuILbtqWLmnWRiiTkw8i6wf
	T7jONvdjU5nsjZJSCUr3x0+ILQ/1wKhZY8KVWf7E0OeFxLSNjRXyZbK9xTFteDJh+Z1M=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x91b4-0003EW-69;
	Tue, 22 Sep 2026 14:35:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <drew@linuxkids.com>) id 1x91b3-0003EQ-1K
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 14:35:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dB6hDmBP9l82kh/wQzVt5rVQ0/2bOHurqMSi6r2/P94=; b=hDqO973hIQfKBThIlEQweeQEcf
 Ygm8PAntAcI8FpTFbSzVauaRyaCJLnUTynvkS8Lmk3sQ1HB7AjPgItjGYG84XG5BalqxBULh5br/f
 rU8XOSR9IzFpZ6wo36TM0yD2AkhcEXoyiNvIBf2wXq7yiZxDzhfk+fYOdc8p1pjPAcwY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dB6hDmBP9l82kh/wQzVt5rVQ0/2bOHurqMSi6r2/P94=; b=C
 P1dkycxvX1Q0U2cN4lf9OhJfm4G7qxTsdbduGDaQSfYz7xte5duxtyTYyRS9mXi4rT6oQx31waZtk
 KcK+H1Rshly3i7DTCPB6MOlC4Owc/yb2Y+CzgH2DVwcTSnaAUy25XNtkC8n1nRtpNlGx0YYr3mQ/4
 dw0iwYW1ecIhWouI=;
Received: from mail-qk2-f13.google.com ([74.125.230.205])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x91b2-0005mW-2m for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 14:35:49 +0000
Received: by mail-qk2-f13.google.com with SMTP id
 d75a77b69052e-530e28a62abso10401751cf.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 07:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxkids-com.20251104.gappssmtp.com; s=20251104; t=1790087742; x=1790692542;
 darn=lists.sourceforge.net; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dB6hDmBP9l82kh/wQzVt5rVQ0/2bOHurqMSi6r2/P94=;
 b=CAQMrtCv71Zhfxk52zfHXkh03WZ+vKkcRKiAodcfQrbq9ldNnELcFjkiJHDmO+KrJC
 +w68GThuYiTj6CVHdnTjUU8MJwyTPR2p3MqtFgUB89nA+HNcbLpy+CkXkFcULl4Ipe+1
 7gmV7qn2icX5GR9Ehnpm4CizxsCM7lCmetueSJqQ9NhPn6EM/VhpkecfMvb/O9ol7Pya
 zqR8Y3RjjP7RT5u3LGmSM/AC2LmlensOuQUnakCmpR9GSB9WzKX7AlKG3JD2TdT+cqYw
 mceqfdV/YlOxJ241OFe11kbEasb+IS15lN79MerISfT1ee4YkbbXJnEY9wcRBdfWuxin
 HJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790087742; x=1790692542;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dB6hDmBP9l82kh/wQzVt5rVQ0/2bOHurqMSi6r2/P94=;
 b=eUUlNSoQAwydCJssnQA0E1b9pf2d3ODCdfBUIpvd8kngGnQIWkpD6YTEExKOFFnshB
 YVoXaxRjcWRkLv9DGApNxa/kfXvJRE6JH+zn0ynxolM19hjeh5fiv8slPCcZz+61Q8q/
 gSmNzW+pfJ5alnDLCSOA442OQexFDqZhF9OiwjVhaspGJRdYKskrD+uvdUwjMdf4IlNy
 XOYKnnBQySu6BliGnHWVUJG9kNLPXgDlV0vayxz+u7fHAaUml3nvNjeXklawmteO7Dit
 njPkD2KFuPSkZ7YLsbRIJHKbiYkofFry/LO+di1flTlZSahAfxyuRdHRmvaRjxr1Kxd1
 +eFA==
X-Gm-Message-State: AFuF++mDVHF8JiE5hryYBDPhWlVJUfFJ6OqAuL8ilrsrBL7xJUrnqxL6
 dbUOp2PfqTAVAeEmbrNHfZySoGfeScRkICLWIjWbOkkgW2n53D0eRaCX2mDxjKzGrZaewrDNELR
 30v2PpR+R
X-Gm-Gg: AYBFou2iW3dHA3SIXUQ6SSnT6EjxOnt03d51FDgiIXOUamHsrn5jZrOSf+n06JTYagd
 ZNiaHXniRjKXWltD1c9wo+WnJXfwdwV+kYjdYLSqXHelVGAJpnRBfGkPN/WN5rrkKteLZvwc6zH
 me6FxU81sdEGwiNdYYiLWCbPCJ267gLLi4iZjAGPJrXvOOsqy+HWnm6sSKKaTXebHiEFWkSq9kp
 A8xbTQCLHYfWkZ30sT0ikUz21qSrPBTa2hhAdQw4mXlL1DIFT9nX08D/QqmUPwulGlsixey698T
 SzpH+JcjfQzXbXIgg76MEVzN78KlWYHEx08XLNCODnGw1+kpppCNNORBH1fEuc84icDAg5C9HQs
 ZI5qN9ZXTGhW+e1utPPs9URHQTCMQo971iXr56UGJuvZBLOgws2u3LIfRN7gAkUfjF3eweL+Ko/
 TukL6fa+mk6IsYyCAjJGa0XqyXiZKiqgIhbLzCWv9ZPv+aGlMCj5EeLx02vR6jhxe00IWeeyXIY
 evCyiwe/REUJOlWSILBQ/m3GoasqyQ2CqWT16SaAy8d5Ch3HGZFlsiQKsr3grE=
X-Received: by 2002:a05:690e:4553:20b0:66e:5f04:f755 with SMTP id
 956f58d0204a3-6717fcb2c71mr3095711d50.22.1790085923373; 
 Tue, 22 Sep 2026 07:05:23 -0700 (PDT)
Received: from MN-277C755CCA3B.localdomain (71-208-239-209.ftmy.qwest.net.
 [71.208.239.209]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-672d166300asm230404d50.3.2026.09.22.07.05.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Sep 2026 07:05:22 -0700 (PDT)
From: Drew Blokzyl <drew@linuxkids.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 22 Sep 2026 10:05:18 -0400
Message-ID: <20260922140520.71500-1-drew@linuxkids.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-Headers-End: 1x91b2-0005mW-2m
Subject: [Openvpn-devel] [PATCH 0/2] Stop failed cipher/digest lookups from
 polluting the OpenSSL error queue
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

This is the root-cause follow-up to the "CRL: cannot read CRL from file"
report (GitHub #1103, PR #1104, which Arne rightly called a symptom fix).

Traced with gdb on OpenVPN 2.7.0 and master against OpenSSL 3.5.5: the
entry that misleads the CRL reload is left by cipher_get() being asked
for the cipher "none". That is the pre-negotiation key_type every server
without --cipher gets (BF-CBC default, not in --data-ciphers), and every
new client instance walks it in do_init_crypto_tls() and the frame/OCC
calculations. cipher_kt_block_size()'s CBC-sibling probe and md_valid()
have the same shape.

Patch 1 makes those probing lookups leave the queue as they found it
(ERR_set_mark/ERR_pop_to_mark, with a wolfSSL fallback in
openssl_compat.h). Patch 2 is the earlier CRL-side change, kept as
hardening: the EOF test now looks at the error PEM_read just raised
rather than the oldest queued one, so no other leftover can produce the
warning either.

Validated on an aarch64 Ubuntu 26.04 server (DCO) with UDP, TCP and
CHACHA20-POLY1305 clients: the queue is empty at multi_create_instance()
and at backend_tls_ctx_reload_crl() entry, three CRL replacements give
three clean reloads (unpatched: three warnings), and a garbage CRL still
fails with "loaded 0 CRLs" / "VERIFY ERROR: CRL not loaded".

Not compile-tested against wolfSSL; the shim is two static inlines.

Drew Blokzyl (2):
  Drop the OpenSSL errors a failed cipher/digest lookup leaves behind
  Make CRL reload EOF detection independent of stale error queue entries

 src/openvpn/crypto_openssl.c | 16 +++++++++++++++-
 src/openvpn/openssl_compat.h | 18 ++++++++++++++++++
 src/openvpn/ssl_openssl.c    | 13 +++++++++++--
 3 files changed, 44 insertions(+), 3 deletions(-)

-- 
2.53.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
