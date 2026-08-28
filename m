Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D15C61DB9
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0vxKnPZsqbiLZbAtJ4G/nsPdNlJ+Z7x2stiDDoqMvPU=; b=lZx16KM2TnkojVYPXqwxryvLym
	VSyFDC6uQRMwQ3zWoJA3vTQxKkNwUk3BEaTt6A4PHGlMcpwozLJMO/GGnigYKTzgVjvYhqLhXz8Nc
	IiuKb7CeLXgf88YX3JouwrFqWOeLArhb8YFVyBWkec4CMOzx6/K4Lv+b0hydbulrMq18=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzw3l-0002W8-Hi;
	Fri, 28 Aug 2026 12:51:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzw3k-0002Vz-Pv
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:51:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=xFsjcna4TBVl0ztvc1O+4qpjmSg/vuWBmBXOIr7v32E=; b=TC2IWN3CL0RCtS6UVFEViKtB0B
 G5ILxObwBTGCGT+XzZQQOekCEWmLIGyDAG1Ir3v930wiGzq++MVfsSL7kaUzqVMeHOgqjoHUtwkri
 +Az1tAk3T3rCTc+xx3MUQbheffbGMVL1c0hYn7mWEG2aIkt07ghpC3griRIonfzVaaX0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xFsjcna4TBVl0ztvc1O+4qpjmSg/vuWBmBXOIr7v32E=; b=a
 QaGFISNqCQNzgSl7LaO3/0hFxkogn9iizVOFzpudtxG7pTkg1p7ofS7fXGUWPZLbGwjt8QobAW339
 llqq6ItUY0LuOp07uBWKD7aBca81rbaMbfXl99L/2+fge63dfGaxFVJad7dqtlsYqUeERHv/+7nwO
 Hrs6mLtQfrakgrFY=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzw3i-0003Gt-KU for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:51:53 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47f93b2fe4cso412600f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 05:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787921504; x=1788526304; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xFsjcna4TBVl0ztvc1O+4qpjmSg/vuWBmBXOIr7v32E=;
 b=EHx/8cSQ7vYupTTu1wyc12l9DuQbnKeCME81bu7MBTmJZeW2WnVHhB9jyFLJcZTvkQ
 PvWvGRgtmITGrtJ0SMbe9ZlcxNn9tcDSs9L/ay4N+4o/AXDidNZY65f2u/nwd4uhZ+Yb
 1BtNKsRuXJByDUM1NRfN6lvf0O/yDc7Cq0Ilgo6eakvNIOnM4ky54DVKggcIzj8MMyMH
 tm7ue300IHjRNaQ27gnx04aFmAV6F1XjNQDfe1A7+k39ez75Hs28TxJCzEyOt0Spr3fP
 D+aKM46DcayTGHvM+bC9m0Bf40QmepC9P/UxDEnT6YQ2k0Qe9dzQj1uzKzytGLTEVmGk
 1Wtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787921504; x=1788526304;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xFsjcna4TBVl0ztvc1O+4qpjmSg/vuWBmBXOIr7v32E=;
 b=ehQtRRA6SsUn8NNnf6EBbcDWrroSzQ4VP8McYwPSrZcOsaP5AIhzr1TocclYU5l7Xa
 UfFpJShofKadZGQDnRrUbzkfmdlh3BJ4wcblJBKxy93Cz2AG5uz01O2CdGl0J9JmFM4b
 dCiKgT0iMcUNzhVXrLIcwNd4AULOye61sOsW46mPnthgDBGAc/vFryavBhvexfTTESiv
 LHRWI6NBXMfE4CK8cTCu1CyNEG3hdVhCkSBiQHDAP3XvpphVVPPaRYDTB5mPp1ks2m8s
 aCWajzaRMC9etp94b5mTI8n85cpSyGs+uX2I++QZ2WFhItC7ffJaWknI+64pgAiyhp+t
 rBEQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqro4h2GWD5P0kaVXRtczOAfS/IMyZZT9Zes7HWDmAD0LpTBdiq6ZgA+W5lCfhxp0VuOLAI0KOPD1EVSBq7@lists.sourceforge.net
X-Gm-Message-State: AFuF++l0Hhn7DIVMeecEGyLsjgEg3SWSpH8OZKDZrdvBBPrWL/5lqhLG
 oGYCPtgCQs4NsON1/gcV9Z4E5QHfDbiRkJSc8smpLIqRT5tkn/sBGf3WO7dlnLtxHQhsbQCK7J1
 8ajk3LKZRd2llZzd4UOx6FSog10XB6zw30pEd29xDhVskcxWQ/FGWn99+Q1ky6cOd09ZE
X-Gm-Gg: AR+sD10Zkf/Wt5bup/LBeF0+xarzLXV9hcXzhBuXVJ2bRSKKCBUEWQeETmQ/OwEiMXR
 GdaKgaJnR5glOfvMx939W/0yLMs5n78ahlrxwtkuCA1Xhlyatn1ToZC3XzcGl424ZBSkHDxerM0
 1KeyXcOWg6x0xebQxjQD84E79/Q/RmRGVFe9LN59ajmRw5rGVL1450omuPzvhsq9FSsNSuyy0lA
 YPic/zC0sD8tbRD6Gy9DfbOqkWXZZ+wQG6ncUItq2SER/Tfz+P3AkiVoDk9C80bjJQXv4B9UXci
 5LT2UKPH4XBHua4WlZOksUUeBGuSItNM6EJewPb7vhNUGsR0oKN1wFZjve7q236k7jCzFzmIDAT
 5uE+RIfeet8yBOehykErz/Zyk+Uo61HcY75JWjaz+fK1+YXWtZT8z/9JZkntF6gv2S7QLiYUSw5
 RksvXUk0pqes7i2H5DxekY88oINRebWnFCLTeQeEoX/II4u0THFu47JNU/P8pM2fiXOevGZ2+HW
 zi1jC41rxSYrfwukytwL1WfEHHfVq2wZ+7azt71S5/KXxem0vo1AhnyeyMLw+RUj/xARSg6o2Ds
 rBDQqZhrdD44ZFoH9+lDXwGR5sduTSnvlucWlwPwBufpKvS7Ns4=
X-Received: by 2002:a05:6000:2dc9:b0:482:ea47:4484 with SMTP id
 ffacd0b85a97d-482f7996044mr10350925f8f.8.1787921503946; 
 Fri, 28 Aug 2026 05:51:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbab3f45sm6008351f8f.7.2026.08.28.05.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 05:51:43 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 28 Aug 2026 12:51:42 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I694410615958afbb422d9ead71f04c1a60edc640
X-Gerrit-Change-Number: 1849
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1849?usp=email>
X-Gerrit-Commit: 58fb5785dc6fe6df923ac633b617004c6f7b20e2
X-Gerrit-Comment-Date: Fri, 28 Aug 2026 12:51:42 +0000
In-Reply-To: <gerrit.1787150248000.I694410615958afbb422d9ead71f04c1a60edc640@gerrit.openvpn.net>
References: <gerrit.1787150248000.I694410615958afbb422d9ead71f04c1a60edc640@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MTUwMjQ4MDAwLkk2OTQ0MTA2MTU5NThhZmJiNDIyZDllYWQ3MWYwNGMxYTYwZWRjNjQwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b5f7ac42ba9ee70b3125b5a7769cb1163b7e8637-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzw3i-0003Gt-KU
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mbedtls: Work-around
 bug in mbedtls 4.1.0 and 4.2.0
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 max@max-fillinger.net
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>, MaxF <max@max-fillinger.net>
Content-Type: multipart/mixed; boundary="===============0365099353425189821=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0365099353425189821==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GzMEL8CeW98="; charset=UTF-8

--GzMEL8CeW98=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, flichtenheld, plaisthos=2E

raz=
vanc has posted comments on this change by flichtenheld=2E ( http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1849?usp=3Demail )

Change subject: mbedtls: W=
ork-around bug in mbedtls 4=2E1=2E0 and 4=2E2=2E0
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To =
view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I694410615958afbb422d9ead71f0=
4c1a60edc640
Gerrit-Change-Number: 1849
Gerrit-PatchSet: 2
Gerrit-Owner: fl=
ichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-C=
C: MaxF <max@max-fillinger=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Att=
ention: MaxF <max@max-fillinger=2Enet>
Gerrit-Comment-Date: Fri, 28 Aug 202=
6 12:51:42 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--GzMEL8CeW98=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, flichtenheld, plaisthos=2E </p>
<p>Patch set 2:=
<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; pa=
dding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849?usp=3Demail">View Change=
</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849?usp=3Demail">chan=
ge 1849</a>=2E To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I694410615958afbb422d9ead71f04c1a60edc640 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1849 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: MaxF &lt;max@max-fillinger=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &=
lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-C=
omment-Date: Fri, 28 Aug 2026 12:51:42 +0000 </div>
<div style=3D"display:n=
one"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has=
-Labels: Yes </div>

</body></html>
--GzMEL8CeW98=--


--===============0365099353425189821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0365099353425189821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0365099353425189821==--

