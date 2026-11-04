Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF517606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RSTISkM2;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YMqY6hkX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YoD9DRBV;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JYSbI7aU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=YNhnJZGgFxwfUgX7KFcQb2a6Ka14a5JS8MAQ9rNApag=; b=RSTISkM2CuJ8TuWDGEPOBnevvI
	oe4Wvpo8fwgVuHNhwaawhjVm08Qc/Lym4P0bNEqunXREv1HXXqnsb4Lz/bDfVWR+Xgd80ENN1AxKa
	jaxb8y5Otf8OKfJkJ/wrsNRQCqg/DQGnADX+LHoNEt8L/4HDJ745rGJhUk768lMOR3Ts=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOa3X-000000003TX-1X7b;
	Wed, 04 Nov 2026 12:25:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOa3W-000000003TR-29ZW
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:25:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vnLLXZ1PhHXLKdemXxOIFhycYDQTLkTw2gXeIxpzwpA=; b=YMqY6hkXS94ZtCbfU/AHxUCiD8
 EMPvrcYIDPb3EyAJ+m/5vQ9zek/I+8z7mZuKsotTzsoFxcUMNJPkkFAJA3gbddIw9W34bPpPI2AB9
 4gYkSF9zadjJqcXZUY70k3rHULRslHYCqLENughsLHgroKk3Hksz6uCN7kGL6WOK+5gM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vnLLXZ1PhHXLKdemXxOIFhycYDQTLkTw2gXeIxpzwpA=; b=YoD9DRBVmkfNH7Fp9VcLJehjDF
 rJ/TVRu1kXqlojQ1hEWZIc6OTTp8RwQMGTqeFvEbsiqbCShOaPwHIhQlsJvFg7qYarO/3dw/GnOTi
 Urc0XGzWQYolQSE6ECJbzJB2viNlI6tFXlRgktiXq5gkGtuJXVzpeWDgazhPt0Lnqh1w=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOa3S-000000002AR-1b6L for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:25:30 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso4245315e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 04:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793795120; x=1794399920; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vnLLXZ1PhHXLKdemXxOIFhycYDQTLkTw2gXeIxpzwpA=;
 b=JYSbI7aURdrXuQYpo8GZryllX1fJ6neoYUpAIkW/KJb2AgR0yPL5A4jj4v8B9XmeXG
 F/nRrSY79oL525NpMW+DnSbEPjZGgI8q57nThBoJ8mC4b+qJXfUae1SQzYrSQuS7EzHV
 tNvsVwn1E7igxBNqGzI2fPnlQLDMK3eSBTrv6PCgu6/TtosO3QWk1D30DMFcJgI0tDKB
 BSjvLFCoFPCGcG0tX2Zlf6OgnWEFZbH+4Rgk7LjJdqbCbcPKSkNDkBwf9gWdVJ3jS1hN
 sRSlfCp6/bz5ngOhYE+hvShcZd9UvdVlnVQiBXVqwfTLxveBwOmBPx5CIDXwYGo4Dqzq
 N79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793795120; x=1794399920;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vnLLXZ1PhHXLKdemXxOIFhycYDQTLkTw2gXeIxpzwpA=;
 b=vu0DnDAV0AK6Q1hCJdKLhDJdogN9115JYD5ZhVkfn61WavPPXYs6z/H0pBxDFA01ub
 jhFutBX653Ch+hE7zJQwYze7C2Qx1/x8XXLkBWfAy85sZ2RNhOw/uRu1hpoDceZakxzD
 b+BZFOJSx9itd2XHqrfVvZ03YkLT4uZRKmEkbSKpp6rtZEBG+Tfz4tslHKPt4orzXQA0
 thsE47GLE2gPe5pZbIOgOgDU+kJtbl07J8PQI9xiHwtbnaVGqyGweMvYLUod2arA/0Qi
 HcQuv4kCmid0A40Eiw6/997p6wuB8MddNt0JSiBGNS7BUuwH6FeJf0gXQ/pkia1geFW0
 cg9g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAnZLYF9U38ytKguVbXesw9hb/XBr4hbkv8RJyWgFXI4gu/z1C5zKJx1XTLxaLsJmWmXlQ6vJTQ0hRlG5X@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+Q6rKu481u0VHzQNY0wnf15OBKGsrZlUb8kfb2iBVMAOloz9Fw
 z2TiTshTEE1UYigyEJitNt4enh8GYz8lJBbpxv4QzYEqhz/pGLOQ/I5DcXOmjsDEj9TRNi8Sg+2
 cMKl8cecChbzup/m5rwrJmuZJ2s6SVo6OwjXRhxJAftLMdJ8nJSdsfkcXA48ks0K4Y10B+nCT/U
 Xi2wyVGQ==
X-Gm-Gg: AYBFou3C3BnmvWXJFFJ3/KATfQGYq9et4xd8wTxg1ruPJ2g8Xa+x44oZqHKp7lqYcAt
 FY/HwxljtwkarQoy7+V9YNwpssphtMz9Dq/QtvD30hM5fvcBtPNX343AdzZGYsxetW2LiSR9irt
 rkrfRKeEjGzxCm+CviY1xpSymhq6XOJzoDtEJAaMWIFbNkDqt6iX5hr2J7PKBDTCECaKid2h66F
 dF7jbWRd7ZydAGoigTf9Z4YIglnL3gglThnmkgxZlv4bYamAdOO8L4olIdmaHlm1tYGa7t57QUL
 X/seZhWFYyQgdlYwNuyOyxm+GA/VsD6EpNn6mO3+Unn2XY/oLcGu7Gvl/znQ4zU2oKHciY5AUjL
 m5ddLagNjJnxpEruBuq2cnMdvwgqakULnUxFpe/1rLWrN0e0Al6+zWa7AsyoK/zMt4xRdHfdrSV
 IIapJhCmMeZIU8PIvaowDqFdrHbZmzL/VkHCcc89RaSE4HvzupqolmJ2sue1TzHwHNkinJfS+jW
 vQ7M0y7UPzIQV8qH5R+MDUDCe6GXyMDCb4s7bRlWGIOACD4xwsOzLn+9XjgnPoOdyHWEPzAiTwi
 4LMpVNOXdEKCWB1DWBZg4uKxHcb8oETQFbkNejwmascBh66UGlSnTVKsVuMbxpY9fUCfFhEeCmd
 xkChR1OYhP2JU/OnIgMcJ/AdCc7ws8cF1w8d2QMz8CbPYPoTtu9Xd2v2n7kE4L+H27m1PNDz5C0
 j9bU+dKCG74dJgiw==
X-Received: by 2002:a05:600c:c16a:b0:4a1:fbd2:f689 with SMTP id
 5b1f17b1804b1-4ac16fa352emr369637345e9.7.1793795119714; 
 Wed, 04 Nov 2026 04:25:19 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fea180ee1sm4283544f8f.4.2026.11.04.04.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 04:25:19 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 12:25:18 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I8b9efc75656e01df9afe99c280ba8c9c82e937f0
X-Gerrit-Change-Number: 2120
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2120?usp=email>
X-Gerrit-Commit: 476ca73437086cce61452a674af56d625672386d
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 12:25:18 +0000
In-Reply-To: <gerrit.1793776960000.I8b9efc75656e01df9afe99c280ba8c9c82e937f0@gerrit.openvpn.net>
References: <gerrit.1793776960000.I8b9efc75656e01df9afe99c280ba8c9c82e937f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc2OTYwMDAwLkk4YjllZmM3NTY1NmUwMWRmOWFmZTk5YzI4MGJhOGM5YzgyZTkzN2YwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5b93bc6063b65d033a282bb77b2fb005d5efa7fa-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOa3S-000000002AR-1b6L
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tun: log the actual
 error in Windows tun_read_queue()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0174536982806165259=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0174536982806165259==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="B861i/LCJ/A="; charset=UTF-8

--B861i/LCJ/A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2120?usp=3Demail )

Cha=
nge subject: tun: log the actual error in Windows tun_read_queue()
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-=
Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
20?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8b9efc75=
656e01df9afe99c280ba8c9c82e937f0
Gerrit-Change-Number: 2120
Gerrit-PatchSet=
: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Revie=
wer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Licht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Comment-Date: Wed, 04 Nov 2026 12:25:18 +0000
Gerrit-HasComments: No
G=
errit-Has-Labels: Yes

--B861i/LCJ/A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2120?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2120?=
usp=3Demail">change 2120</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2120?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I8b9efc75656e01df9afe99c280ba8c9c82e937f0 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2120 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 12:25:18 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--B861i/LCJ/A=--


--===============0174536982806165259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0174536982806165259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0174536982806165259==--

