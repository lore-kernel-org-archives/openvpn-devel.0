Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DAAC43458
	for <openvpn-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/GHjIvMNPxzpvUn3JYWCt9x0pbDzQrq9Dfu5Xbv9ZWc=; b=F1vZ4UTqbbktS8Hb6gCMcL6IyN
	+9Fu2KoqU0fg2LWJ+S/XBCHHz0+TFGiferYquPUNxEGOdhafwqZDjg2/UWU3L5+n1r/ho+E0aTVB6
	V6Ikn02ofK2W4SeRbVls33siSGa3iVxj1fAdkzNre3M5dfnvUH/HLVPwl6LA2NIVHaEg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wh6c7-0005mP-Kd;
	Tue, 07 Jul 2026 14:17:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sd@queasysnail.net>) id 1wh6c5-0005mH-Ku
 for openvpn-devel@lists.sourceforge.net;
 Tue, 07 Jul 2026 14:17:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fsfDjksaJbsbOg2sPTMx6tXj+r159Tb1ZhKhJBi59sE=; b=gCh0rTM3+t4EdU8D0n7+oENZVs
 X4b4J/l53Z/z87uSag3DkDX2hGoQw7eUwBEL9ecujGkMP0ka7E/qfFWZf7k9NnL4Wrvjfo3i0RSHp
 BCTB3JwtCip/DSAp4mbIbpd39lGgalqCXR0M16Jy3IDlwfBtpdD9JSUK4bJKsWoVLYtU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fsfDjksaJbsbOg2sPTMx6tXj+r159Tb1ZhKhJBi59sE=; b=e39pdcnuL2JAyOAQJWfjAr3FRO
 uuHQvDYYKE0Rp1lm/QpUHm/C0NAOU8g141RN81zJ/tGE3B1MQ74qeMW7KHh+yejK0Pp4YhB4puOX8
 FjnFhtnmtklWG3O7LS486jmJ4bXapOnvGy/ffcE+n8wXe9klv23xe4H00s3ZynjS+psc=;
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wh6c0-0005LT-Ma for openvpn-devel@lists.sourceforge.net;
 Tue, 07 Jul 2026 14:17:27 +0000
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 6D2811D00136;
 Tue,  7 Jul 2026 10:17:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 07 Jul 2026 10:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1783433834; x=
 1783520234; bh=fsfDjksaJbsbOg2sPTMx6tXj+r159Tb1ZhKhJBi59sE=; b=g
 /UesSSVCSsSFw7MVaUiF84dFabyqZHkJOg8oBiLfIMw+cSSoBoL2QI3c102TosC1
 Doa16Xd6L2wHkIUoEK9opXktYYbaUvzi/yrlURzLC7OFq4ASTFpuN6Jla57pfPE8
 TbwgnUQtVxWXZpzh5tUWzqk43xGkdzIXWM0WnFNbB+0zAvjumjjzRbLWuyZGk0KM
 D5wHEIo31vzcsb+FzHjRXCR+gtdwGbke3hdBIfaiqbKdW7CYLbt82XGGXvo9X6sJ
 jtaVvlGGjUAguOCrAtR6RMMweU2brmiDw0vdqw4A9UxhfW5nen+kFCVZXNMzMdzw
 XSNeCMxNPjrwsgYpK6mng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1783433834; x=1783520234; bh=fsfDjksaJbsbOg2sPTMx6tXj+r159Tb1ZhK
 hJBi59sE=; b=K55W59BHzxnIB2B9q7cXxdwK+NfRzBAyrVlEGdqfUahehSAEK9X
 SChxNohJFr6KVr1afWF/D6mvjuJ2r0GW4ltNG8fK5TGniITtAbUoiElAOZw0mEfr
 BIwRM7zNYEc3ZlmxLgYRI18tuIq6AM4HtT7/vObbSaxwcL40Nmx1ZGtJpSQdxUN/
 kLVa0KKVcpdxlM/5rpqzlX8iFJP4zWzvoxBdyVqO3fn6lVzL5FMLawd+eUu9v8m1
 0dT8VBV+BginWaJgHYvv5R24MQbOmnKEcXch4vde3PMb3FTSDKVIu56z2PaHwAPW
 8UOq/7GTTReqRC623YX7GKPlYkZjA9igV4g==
X-ME-Sender: <xms:aQpNajl7dSntOpg2q-0ad4dv17dmnaIj7Q_T6ciiTRo6W_wOt7hFAw>
 <xme:aQpNas1M2hKSG3y539tv_YpUStFeqlpe1P8nAf3gyLI3-iI-kYQY9z0ELVxfUsvwB
 NTu23tyLgDfn6YAnx73H9amTkVgdklzmPPzACNc52fzJWXNFpJHtZBF>
X-ME-Received: <xmr:aQpNanTXN-9Nwok4W4IMnJg7JuxYrdwVpjNrEHhgs7Lh4IbRyKALV2y74_4>
X-ME-Proxy-Cause: dmFkZTFS2GZcEDnm2zwUjB4kcUWFxX4Dp8MOPawac2MqxhqESkaU0Lt0rH4A0d4PWHwxKu
 ToTeXMYL7RhieYEYoUoLIBNM3oXHLriBXPWqlfrU/e0/wjJDgViVUFjTt2UXnx+oPSzcZP
 dXngip9LRI3HGV2g/FvOPXW7ymjcNuke+gZckF5lg0WMr9lFN/h9K+uNaSQcOE2RvNq11V
 Zibj2KWcGpFUmvmGgp77KO82y6GeR7zI8Rm3H/xM8agS4WIvuMBjXsA/r234SCjBaONTTN
 vBhFRPCxglubYrsv7pEffYc4NJdT6ks+FGGpbJ9u0Ro32UhNvOs/AnV71B04EEyxMDB2cZ
 396SLtwXXyiVpfoGKzNr64sTNdZJA9eoNcWN+0kj3I0YbmqKLnmFK0qcJT0VHkpS0brFDk
 5YP9zjdOMtCzEIZZkRGVBNlivgUtq7EyUBRkfx0rWEHMbh0bjdihPjRFB+HRwxc8J9En4o
 RDP4xSjq0ow08aXBfOhpItf59wBC16bSv2Q1gk9q+JwVeYLArCstJgiAlPp4j52NVj+SOA
 +Z/acRx5NHzNfkhQU+tDjGFYleMKwq5PyEdsUG8H4Yx8hvq7L54MjVyxYm28CAYQQz7kVT
 CzqyQ9tgBP7JZHonIFnzISQFYGPsAcrIreLYmaf1Sj/rQAcw4yJe7Z4w3qcw
X-ME-Proxy: <xmx:aQpNams9I2W2mJms4GNEfr34owjo9PUYc1mWExBOk0jrvpCLQZSBQA>
 <xmx:aQpNakbGmQvxpUZWwELgwDWLkkfLNsLyxWwltNP4uzTXEDygpgcRvA>
 <xmx:aQpNajs7vDL1xE6nJqq-xhMShYydN96ahaE_Xzg3Z8C3ArdZOmh19g>
 <xmx:aQpNauHsVFcrrHDqCVc7Zm_QN3I1Sz3z_99wkM5P8D9ODvv0OUOjqg>
 <xmx:agpNapVRp_UKqyNStJiQ_MNsO0HnlOlEYAWqnYeQJBNyNxAi0xwjz28j>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 10:17:13 -0400 (EDT)
Date: Tue, 7 Jul 2026 16:17:11 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Ralf Lici <ralf@mandelbit.com>
Message-ID: <ak0KZ8XIkWh8e6AI@krikkit>
References: <cover.1783336121.git.ralf@mandelbit.com>
 <5e4de5963ea48d7e7431e55192f0d6a5784c2a47.1783336121.git.ralf@mandelbit.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5e4de5963ea48d7e7431e55192f0d6a5784c2a47.1783336121.git.ralf@mandelbit.com>
X-Headers-End: 1wh6c0-0005LT-Ma
Subject: Re: [Openvpn-devel] [PATCH ovpn net v5 6/6] ovpn: defer key slot
 crypto freeing to workqueue
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

2026-07-06, 13:34:04 +0200, Ralf Lici wrote:
> Key slots are released through a kref and the existing release path frees
> the AEAD transforms from an RCU callback. That is not safe for all crypto
> implementations: crypto_free_aead can sleep, for example when an async or
> hardware implementation has teardown work to complete.
> 
> The AEAD transforms are only used while a key-slot reference is held, so
> the final kref put is enough to prove that no transform user remains.
> Queue the final crypto teardown on the ovpn workqueue, where sleeping is
> allowed, and keep the slot memory itself RCU-freed after the transforms
> have been released.
> 
> ovpn_crypto_config_get was the remaining lockless reader of transform

nit: encrypt/decrypt is also lockless, the difference is only the
refcount, no?

> state through ovpn_aead_crypto_alg. Make it take a key-slot reference
> before reading that state, so the transform lifetime is consistently tied
> to key-slot references. The previous patch drains ovpn_wq during module

Using rcu_work/queue_rcu_work (see commit 6624bba469a3 ("macsec: use
rcu_work to defer RX SA crypto cleanup out of softirq")) would avoid
some of the refactoring of the destroy helpers, and the (kind of weird
and ugly IMO) refcount dance in ovpn_crypto_config_get (with a fairly
big risk of "well it's dumb to take a refcount here, we could just do
everything under RCU").

-- 
Sabrina


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
