Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFA2606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SZ6ubh1m;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jqbnHyuq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gJRc6lBC;
	dkim=neutral header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=HNvN9izW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Date:Content-Transfer-Encoding:
	Content-Type:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:To:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=t6xy7oAwGsk38+Nkg7g3RrZNq2rasv3JWXcU7eBwgjQ=; b=SZ6ubh1mZNM2GB
	OoxKedKo72IPihvwky7PVgtC/wWjIN4qYnZF2RquKsZswgdmdvdqLYUcMb9WcZtN37T0Pcl24/6d1
	lKurusSFL98JPZ/BQtvwnu1c8Gmt5Bui+kLmsMaLxd+bf9VqEKUfAsMVOZhJAmTPSuGGlNS8dgqQG
	aQQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTaym-000000000i3-39Tj;
	Wed, 18 Nov 2026 08:25:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <979504756@qq.com>) id 1xTayl-000000000hZ-0OoG
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 08:25:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:Date:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/yuDMQsxGkjeUnE+0l+pHlPMKZ7PuVCANjxNOcnsOnM=; b=jqbnHyuqP6JzQugtzmzN9g09BN
 c4hjRR6STqtEjufSpyYHF9XfsWlwv3Jxu9M+i3K7oe4N6mpm5eiKiYNx6cXXtoH8lFplcB7pPwrW8
 eMjQb2u9szJrtLPD+tfvNwWYfHDW0Pic/E+oiLIgRG0ddiTWyb7i7KkJt57OogtyOC9s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:Date:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/yuDMQsxGkjeUnE+0l+pHlPMKZ7PuVCANjxNOcnsOnM=; b=gJRc6lBCKO889dBq/OrhXO88/e
 plK6EcSSxMa4htLHX2PUmJx9eZE7yt6c2GYQsQXorxebq8xou0xg+GRrmfE1E3Nn0c6kxkbsuivDN
 KRp4lFN3MtmEtZMewDWvYNXdJijdJXaz3LPOioXjy4tWCVb+uJ0PhcpS5aedtqGeWRD4=;
Received: from out203-205-221-192.mail.qq.com ([203.205.221.192])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTayj-000000006lM-07RU for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 08:25:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1794990308; bh=/yuDMQsxGkjeUnE+0l+pHlPMKZ7PuVCANjxNOcnsOnM=;
 h=From:To:Cc:Subject:In-Reply-To:References;
 b=HNvN9izWWeXDvY3/eNoXz26zx0wsbNQYAiAZxFljPGoFZmYkciiYAsLxxXB2m4B1F
 Y7eP4FWbPI+/yclaq4XVN9BMetd4nPAgluCTNvVZGOoJUKeYw6v3UkDNM076KVjWQI
 zH/MdxhhmTc9fVYTA92P4bKF4rgCnoZc0eqJJsiQ=
Received: from localhost.localdomain ([124.223.3.35])
 by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
 id 646274E9; Wed, 18 Nov 2026 16:25:06 +0800
X-QQ-mid: xmsmtpt1794990306t5d5udx2i
Message-ID: <tencent_51DD448155556539AEA21F7F7B844E4CE806@qq.com>
X-QQ-XMAILINFO: NKDEJ657lpu+ci0oj5h2iDzJYJZgAn1dNNp7ZvazQkuuD39dh5PGgyGbwoRMIC
 +jF5iNPB5yS90ljrQZcYi96McimXNOljSqpIeRrR2K+843ZuYm1kfCkbwlSEIFuT2zoqasKlHqlq
 r9jEV8l+zc3rSO33RUCfCHkHSGTCG5GlKG+dTczDtEsgVM4Tq7JkfSBJ97Z34RktT1CWRoyl0II2
 oagS6SaF/Ek/GXfQRfHUp1bu3ih5ZNI82hkrJU7ou2pDtJLIHPbXQtdJ/Rt7nEq5QCNArJ522Gm2
 mBlqQkBLNcpS/3Q/MvlQh28ntWUuHCNpzd9VS5W1VePq/BvhW9EtaHUTQHvIuhZ3+J4kuGUW7pQ2
 37mOQ1fx65nXrxxRwsG9aC1ds/KnFwkPM2Rm8+9k4OsDKE/RtyEnaN/B7y8f8RXbqkbaasU9gdww
 G490sOXZlvk6Yse2P/gu8X6rB//l5lpQWQrIlkQtMHfcg53cZh6BKMalZuSIDd+A12xIQ3wMc3Yc
 fBFt7Wz2D15KO9b/a8NtJgP7S1F9Bz98k44g0d6MJljVCx5qqApsop3JLzm0fmGjlq3Bs4FWiq7t
 EiHRxQeaa7bNaMo3xHWNtciQDEirVLN70nCnmk7sZlcmj6AOCe8yaRF/j8o/J6yVuKBpJR/mdV4B
 +1VeqH6ehcsptjeDydzXkYrv72Iy/SdDfHh5+D2ybewSSU0eiMvo6+o7DRVbvysvUCuytFT3FBHP
 H0ejYiE0cvKP7WpmbjInbELX//s2H6FH+U/3T7XU5iZAiiUUU9gH5LZEZO5DlehDRk+sLjIeo2nR
 Ksc9zbziF7sdVUND2eNJg6fHdkEzEs6COmIJpjNUMCBCqDDr7Oa0YmjdCkQ/La4+f1Xg9gkthftM
 5vSDVpV3hV2nHtZ4f2qu6YnlkD18Vm4pof/nHRS04GOuQVHUdWR+hkQfQTcxdAh3T+JS+i9fx+Wr
 Tnq9zlEcnMZ6/yRcGgDfssJbCs6CW/0qgU7mlnkuMe/emyI1bV+nC3dVVxVs9SBrZi218bonQaWh
 ooQvTJ3ORd0UFpNFDc5kQtWaEL3GBCkMqV9ybA4w==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
To: openvpn-devel@lists.sourceforge.net
In-Reply-To: <20261118070037.3265825-1-979504756@qq.com>
References: <20261118070037.3265825-1-979504756@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 2.4 (++)
X-Headers-End: 1xTayj-000000006lM-07RU
Subject: Re: [Openvpn-devel] [PATCH] ovpn-dco: hold peer ref in
 ovpn_tcp_read_sock under RCU
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: Liu Chong via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Reply-To: Liu Chong <979504756@qq.com>
Cc: antonio@openvpn.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Nov 2026 08:25:20 +0000
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ralf,

Thank you for the review and for the Reviewed-by.

I am sending a v2 that addresses both nits:
- Signed-off-by now uses my real name "Liu Chong"
- the RCU hold comment is shortened as you suggested

Thanks again.

Regards,
Liu Chong



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
