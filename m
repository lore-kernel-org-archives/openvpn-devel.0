Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC0ACD98F2
	for <openvpn-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CQXU5lXlDI8/Yz4Jm0Dlp515Rl5lwFyo9DKzdOPjKmw=; b=UStTPYk6jWJaDxVVIYNrDkBews
	VeyGnFEhTyJ18MyObJHaY7l0WtoFifv9SAElh99lJGc6azVOhNrjuX3J+6irdFHyHcMxBptDev/Zl
	3cXTShjTrc7+4leNqVYefOxgjwBPYZhhp20HEYieHdstO/pJi67sb8QuBJLgU5HHB/b8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1waBkn-0003AR-5j;
	Thu, 18 Jun 2026 12:21:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1waBkl-0003AK-FT
 for openvpn-devel@lists.sourceforge.net;
 Thu, 18 Jun 2026 12:21:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Uo0QYwo/PTIsbiDGw3HbVi2C7tAwcUNWlTm1vaSkrxg=; b=Zn2kiB/TP3nq7a2kBFmJ1jtCty
 PQEAnUfS8SOzktT4RNcddsUfN5n6Gq/VC3eyDGN3gbEVzT7FBWOB/I+U9DOgOVZESzUABJFFM8jxe
 zeYzAOwKP8DxzBFqzp58fyMTtwOsX8pP/EtRHVDdE7h4jf6jtRO4f0gzyhA0ylhAsqmM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Uo0QYwo/PTIsbiDGw3HbVi2C7tAwcUNWlTm1vaSkrxg=; b=Q
 YAAGgSuO1KCQdklGjqiIUEfIqmbZIEw28OBVqClRldyle0VXSPuhxMgBvA4/KtpMaZ0gJ1FslEDk5
 3vuxGvIC3DRRMmzv1DZqIUiQEguUZ4Hccir1pTdpjt5mrv64Z0V9wqTIft088BsV6UcSbt+GRJ2kh
 5Wp9yhOlaBZ4F/Eg=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1waBkk-0006Fq-5L for openvpn-devel@lists.sourceforge.net;
 Thu, 18 Jun 2026 12:21:52 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-4629051c9d1so730629f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 18 Jun 2026 05:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781785299; x=1782390099; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Uo0QYwo/PTIsbiDGw3HbVi2C7tAwcUNWlTm1vaSkrxg=;
 b=XuCb6PQ2D4x4D5OK6geX/OnupVZUZytvxy3QAIXa+n0JcFHA4uvIq+tLmsa7vFL4w1
 miks4JNpGB+UARJ7XNMQlaUU1OhIFDpGsimtPzlHloVJs5js706NR5603uYfSzvL4cnf
 KgUDbo0v7Ei8qIfZ9CRu97WAEKkrCxQ4yP/6RAbYX6IJlT4T+tZ6u/zMnWpWw1FJyBwv
 6qxoDk/k/ecfJjQ6eLOoZ/5aUA1HuauDQgJnJalSvEhJ0JhX1hhCVXDP6yXzJQZB21zT
 pybewqHAwMMd2FSu4TEcZnz3FLfsyd2mfgQWqFuQZX+hngK7i9x6ERMj8WaY24fFgoX5
 WFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785299; x=1782390099;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uo0QYwo/PTIsbiDGw3HbVi2C7tAwcUNWlTm1vaSkrxg=;
 b=e1kxYU8xV8410Y5F5gqdhTic/6XXQGpR9MjMkWmupZK06Dx/Hw2tGcgE5g6lQzbf+/
 rza2gBtyLbcWy2t5D8+2mJWARoOWpnR1o6I+yUBduBn/21gZ0lGqVJ0H6C3qMyB0ExIM
 FTwqy7yethWH997REqdyAXpW+0SJs86M2YjIUh2xl63YoRYcR5vkb4jeynRTrfF+SC2h
 0wE7dyheTE0wGw6Wzpgwkjy5ZYZRe2QluLQN5J0uuTqyyzDuAxCcCFkCnENdvkqC1ers
 nygEajbS8Vx79BLGDud5cQLtKOE9eU8OO2PLpFdg6tAQBoZCUXuqoui2QkmBNjgnLOO4
 3xbA==
X-Gm-Message-State: AOJu0YyVz+7TzOe2LdOI6d0nCh4xx/25+uexLjAsBqG36OFA7VodUfLg
 6OTv+6InXZ4ZU+5h78lsQ7A9HfWw3WejMmx1E1oyxpJnyn3s8V4/bhq3+Dp2yOE2Tg3jI51fZPu
 N5sWYWHEqggOOlYh7NFbvwnNXspljC3VMM1KLTirsm5BMOI925vRolnKJqm5QcRJKOnWHwjqm3R
 NjGUPjsQ==
X-Gm-Gg: AfdE7cnRv0qB2EwwnpnMfkZXH6BSy46PcOy7J6v3I7YYBtI/pRXKMWm8Tvm3M1wYdpD
 vT0Y7MUTlza5SuNkNbTT+4N5fmqjWY21zRp2LZHXTaGNe+8JzxmYCQc9pYwlJpoUDwjwquxsngZ
 gtAXjZ9Ms9fIaZvUjnO/YMp1KNkHyd8gwORvjcDu1fANQxAWLNr2JmTNgZj9ebaHLAoXfCIZKo+
 ByzyBKlrdyY4NEqLXpDTyG3ct5PRfoA6UIJQrLTX+zRK9ESSR8OLgc8ZYPY+PFYUadONLGDcY4x
 mfBbffiSeGpleQnXWBm5uk2AX1aLoopfYPwkQKndnT6rsiFf/1jAHE5K35SwPongfQ+sIqo/fXu
 w+60rtUmSZ5slUDefMLk7FJ8zRbODgILzoGX9FsPq4TLSbcjk2t6BkKXHjeoyyfROvPYYpzV74w
 /YVmVzoKykFDO8USnX9pvWsv9Qp8cGIScS0lW4a8x0H40+KX5EOgNp/2VO5skhdyTHObhfYR1mi
 9PzR4jj89QVrVaFdHr56IXmlVcg+Sd4tLaoGIfGfQqJJCm3rDJmyfp2qV69s0faoCofn85NqQXQ
 B8w=
X-Received: by 2002:a05:600c:a111:b0:490:bd1d:472a with SMTP id
 5b1f17b1804b1-492333fac3emr129245025e9.15.1781785297906; 
 Thu, 18 Jun 2026 05:21:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-462236047c8sm18616843f8f.10.2026.06.18.05.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 05:21:37 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 18 Jun 2026 12:21:36 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iac54e6772b2c26a09227fd638d24d6e2aa35cec6
X-Gerrit-Change-Number: 1713
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1713?usp=email>
X-Gerrit-Commit: 57bce06563118f9853c6002ae87653f3ec125f15
X-Gerrit-Comment-Date: Thu, 18 Jun 2026 12:21:36 +0000
In-Reply-To: <gerrit.1781716678000.Iac54e6772b2c26a09227fd638d24d6e2aa35cec6@gerrit.openvpn.net>
References: <gerrit.1781716678000.Iac54e6772b2c26a09227fd638d24d6e2aa35cec6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgxNzE2Njc4MDAwLklhYzU0ZTY3NzJiMmMyNmEwOTIyN2ZkNjM4ZDI0ZDZlMmFhMzVjZWM2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b35707445dabc124d74c3af4010e0e0f385c34e0-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1waBkk-0006Fq-5L
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.7]: Fix 1-byte
 buffer overrun on NTLMv2 proxy responses.
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2595555125801805958=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2595555125801805958==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oD+rKMKxHkA="; charset=UTF-8

--oD+rKMKxHkA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2=2E

plaisthos has posted commen=
ts on this change by cron2=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
713?usp=3Demail )

Change subject: Fix 1-byte buffer overrun on NTLMv2 prox=
y responses=2E
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 2:

(1 comment)

Patchset:

PS2: 
This is quite convoluted cod=
e but the fix looks good=2E



-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1713?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E7
=
Gerrit-Change-Id: Iac54e6772b2c26a09227fd638d24d6e2aa35cec6
Gerrit-Change-N=
umber: 1713
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede=
>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: cron2 <=
gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Date: Thu, 18 Jun 2026 12:21:36 +00=
00
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--oD+rKMKxHkA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2=2E </p>
<p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1713?usp=3Demail">View Change</a></p><p>1 comment:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1713?tab=3Dcomments&amp;usp=
=3Demail">Patch Set #2:</a> </p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">This is quite convoluted code but the fix =
looks good=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1713?usp=3Demail">change 1713</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1713?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: rele=
ase/2=2E7 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iac54e6772b=
2c26a09227fd638d24d6e2aa35cec6 </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 1713 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 <=
/div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Em=
uc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emu=
c=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 18=
 Jun 2026 12:21:36 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
=

</body></html>
--oD+rKMKxHkA=--


--===============2595555125801805958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2595555125801805958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2595555125801805958==--

