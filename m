Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28075606D805
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 09:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=G6SCimLp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DKqSbtX8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fOqpWCGl;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=QN2QmqkM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zpwm7UzITjgsleR+jAmyXLTuCHNezKtxON3bGSN9McI=; b=G6SCimLpZsRA2aN8243mWuV4h8
	1/NZH0VTT6nCxjtVjndS0aS6cNgMwqHwi9Pg669Obb3A2zU2slRxNuC+ri8gLyN8MoTejnC5X4Q1n
	JdJqHZp3KAudhioU6JYFA57pcdWK6F+It4LQo2zXKrGWTFIakJaJXO843OM+O0r2ELMU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOAyr-0000000081u-1LOI;
	Tue, 03 Nov 2026 09:39:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOAyd-0000000081a-1iQj
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 09:38:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oD6WCmTDTowzZpBslqk5PWylEc1QapGIsSB7TBMA3gY=; b=DKqSbtX8hnXW/iBM4esLUBzXw8
 4+sVNXh/sTwwaNmTGYPoP1pUZMQtov8VPiaMTySYNfsG2d9aYg68xhZ/LlhkAHrD3qcmhs2QNTAc5
 I9Zy65WucTEPOxkM3uXucEoBNOqIkiTg7xRJOowmWhqu0kK5iMZi7B0Q2dUooAKNF3r8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oD6WCmTDTowzZpBslqk5PWylEc1QapGIsSB7TBMA3gY=; b=fOqpWCGlyv5WoaeOxkj2HFGaV/
 jO+cCGFkhOepOqOsZSdPhzlqNQawIetQ+J2j1XgLpYJpkf9vjNkFCvPYE8/bxVHHBsjEAJ41V1fC5
 XkzjMqvwbdxH2HDkJDo9qMFxTo0b9HC/C4VxCSv5OYDeylmNASDYc9l54km+XXhwa2bQ=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOAyT-000000006xg-3Sjb for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 09:38:39 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a218c463d1so26316395e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 01:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793698711; x=1794303511; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oD6WCmTDTowzZpBslqk5PWylEc1QapGIsSB7TBMA3gY=;
 b=QN2QmqkMzie/AnBlCCIsijs2zZFxlNrJGnL+qn7nz2UnAKLxW2p/vNyK0/3m1dCqXl
 EZRZMUmSbjY4HW8IHCH9BUYeNYO2oHd4GVUCgHB00WTba6giL7+D0BV8RNMfdEsJuKCK
 mO4FtEOMjBeKynZlBzmAVIPsXtytycFbTfs3/VV/mYTfju7ywwzJ264MiDMEhtWCQblr
 XDgHRRk65AlEWsPi8KW0J9jImqqYyfkteOybHNW3ie/mBKFgW8erakee2FnHresFBTOi
 /eg2eLCtwnVEz6yfQ+fiHIzpqDX9T4RRaSqZUYWvLAFUeghCS0rvRCqh2ARHdhl9vWu3
 1o8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793698711; x=1794303511;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=oD6WCmTDTowzZpBslqk5PWylEc1QapGIsSB7TBMA3gY=;
 b=ALnfX3ScuHWxmePgiQ5HvciHm4CjLMEPv+efZMMWVjJnGnf5A58kkqlIXVAnymBqsH
 UYVWUMi4esgR269n9LAwvVx6/BfJZZcti4r9RVrbfio9EmWoQLu0oHKWvh0mAzA4oS0J
 HwuYQtEJ7c2dMSkslDbKKS6lfrXM9kNeZhsUzEwW0XQl7NZ7HK3KZ0lV8q+mbs6z8ToE
 oeKLX9U+0aB2+F4jnZ+ctWAE2sSavpp2q8wB5Hhj1U2UfJvtjIda9ZHZKtAslSpSL+MP
 dF6e2N1IRdNt86PTmbhSq1UcN7jn+xCih5rXl/irta6+wmTX2jv0/xoSdqzCua1DFRcm
 pDFw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1DXdiIFraoJ0ScMAfrXCt2vtpL9E9XvbIKAyHnOooSKOvy5wQMGy1JG9jMGLwUE22sWW0dqzM6o2KRxrD@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9vaL9Zj8LF7sIihKxdmRHKr3Sw5l+FvVrQzXbf0mg86Nawxa7u
 li7hIZfbGVLDnbz8OE3Fky1LeiOk6x58yAhE+gOsrhBF0CiIoU90aUU0KUP4tKEX92jZDLVE/lv
 AtwbiuOltXeb2uEdrxEDO9iwHortDD4IV/WhcOVTgIxhZ7Ikt6c7pWKQPxYsHu/LvTZJX
X-Gm-Gg: AYBFou16Cazo4gKApRyh6mYC2oX5B2U+Zq+PEyU4km/OU5NjO/2RYiYQRjhXWz4GK+Q
 5CdcIlXOHSpYR6+3uO6xfrQC+P3+Wkeend/Unm4qys3kNwpFfCLQjW+VzorxFCfkhWKwqqLG1hg
 Lgivx3qTv3Zr3IqeGJLdmqS6pohJch4BMsfE+U5WDBGlV0lBlhKhE86EYI8LTYQVuE48f0Hlhom
 EevesM7KaE7xyOydY1gYxtZ0p6e22WxcaRG25554StUdk9Wq2GiQdfxi5WqDqu9qgvG4EY8s4cr
 9VXHlPGJ/rmVmcTPoP1320oHJWTGqqDX1oq5nI8BRFJM1TP1QDRmEKJdfdYJxD09Kk/Az5BlTRM
 BBxuLkrPRT5lyBxM5HdWe1qIrQYqFe1XNbiZTmXgWxuyoLH8wUhrs32Ot5Ff7f0FrtiSy7b8bxD
 LARrx3vAPa6aVWlbk1zxeQbjkcfZFt188JgCIpTQm1DdnxtTcoj/uprlyFcBNZKK0QdfxgKjOIF
 SDb0/yHiKs0xvXfbP67gjtfqU1Trz9P+DaXJW9CeLJhvqrMsLxIpAjjHzyXj77XDCwsPAnV08R/
 oirgTxNXknHJUjOK8jMDux33WvOQGB2Oi8zHGbaVzHq8Qjpy7uCQNTlsGpWGzTlzgvj60oJ2MlD
 /Q/ylkYuT/q+A+PfvRF6FRCyooYh7ssR9sSliiRnAaOl6wHnffgRPq2rVI0r2/xbf5Ak1D3g0jP
 uyRODJ7h1ql/ooRQ==
X-Received: by 2002:a05:600c:4714:b0:4a6:30c3:1114 with SMTP id
 5b1f17b1804b1-4ac180f1c7amr284334535e9.12.1793698711163; 
 Tue, 03 Nov 2026 01:38:31 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a80e0fe6sm51780735e9.1.2026.11.03.01.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:38:30 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 09:38:29 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ie3384ba46347801a6dea11b97cdf9edc17632c4d
X-Gerrit-Change-Number: 2048
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2048?usp=email>
X-Gerrit-Commit: aaba27c973311e58a96a9ecb06dec7f74cc6ece7
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 09:38:29 +0000
In-Reply-To: <gerrit.1793094393000.Ie3384ba46347801a6dea11b97cdf9edc17632c4d@gerrit.openvpn.net>
References: <gerrit.1793094393000.Ie3384ba46347801a6dea11b97cdf9edc17632c4d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkllMzM4NGJhNDYzNDc4MDFhNmRlYTExYjk3Y2RmOWVkYzE3NjMyYzRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a0a0eae74fbaa63b6c623d063b439e5f40e2b3e6-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOAyT-000000006xg-3Sjb
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi: remove
 m->pending
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3727216693220714999=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3727216693220714999==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pZzE/MkfNjI="; charset=UTF-8

--pZzE/MkfNjI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


R=C4=83zvan Cojocaru has posted comments on this change by Gianmarco De G=
regori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2048?usp=3Demail )

=
Change subject: multi: remove m->pending
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, vis=
it https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2048?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: Ie3384ba46347801a6dea11b97cdf9edc176=
32c4d
Gerrit-Change-Number: 2048
Gerrit-PatchSet: 2
Gerrit-Owner: Gianmarco=
 De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mail=
box=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Atten=
tion: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Comment-Date:=
 Tue, 03 Nov 2026 09:38:29 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: =
Yes

--pZzE/MkfNjI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>R=C4=83=
zvan Cojocaru has posted comments on this change by Gianmarco De Gregori=2E=
</p><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block=
; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</s=
pan></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2048?usp=
=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></=
ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2048?usp=3Demail">change 2048</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2048?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comm=
ent </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: Ie3384ba46347801a6dea11b97cdf9edc17632c4d </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 2048 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> G=
errit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 03 Nov 2026 09:3=
8:29 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html=
>
--pZzE/MkfNjI=--


--===============3727216693220714999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3727216693220714999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3727216693220714999==--

