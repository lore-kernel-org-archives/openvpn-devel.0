Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66348CD8CAA
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XkXGg6XuB0BMeNcoxAYALcrnV3MAFVUounBrgf2LDgk=; b=eVX7qbFgUSB9Mw99LIFjecgsIp
	25lq1fLH08fyZIfbqThKvd/IFVxJa5ZMXhmm9KN5xGnPRT4lUv4U4XhbUAjX+XkgDN6XHGoS138MH
	6GqXxcnpayQZsZVbkzexfkw57XSMYlJ85TjJ35Pn+UmW7nv0BM/p4H21XL8jvJ+ZG054=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWxcf-0004ZJ-UJ;
	Tue, 09 Jun 2026 14:40:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWxce-0004Yy-42
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:40:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=rlAAp22xuLCb9CZoQNhrmXgzqAgLGc3PRP05ob9E35g=; b=ZRLISLkdCex8WrQdleGQCt36mO
 +1K+eCMPfb+7mfcxbGGHr+KBFhM7+BnPbCzjg7ZXhJhBK/bbHIB92tP+J1iWfBqz4Uk0facJ41hMy
 79sm7C9r2kYa7UDgVDNfbSc1drylJLX1/X/r/0hL8MVgWMW4sY3e6s1UpUup/5NsRCQw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rlAAp22xuLCb9CZoQNhrmXgzqAgLGc3PRP05ob9E35g=; b=P
 sx9AFfRXGBSW/ptZMlz5t2LF3+SGodIP/Zazm7IkBQ6h20i0wkEo1jcDfdL8zWnZO1CVcrbLDf6Rg
 /1YqkpVh94if9Yg8zwXMhPi+9G0AoE77YtoRWC0DgrUblzrNdJCQ3ntspefczjfe15ZGfpc5Vp0rV
 l+nqpIcjTfJwH3FQ=;
Received: from mail-ej1-f47.google.com ([209.85.218.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWxca-00057X-UA for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:40:08 +0000
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-beeba001887so745539666b.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 09 Jun 2026 07:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781015994; x=1781620794; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rlAAp22xuLCb9CZoQNhrmXgzqAgLGc3PRP05ob9E35g=;
 b=E+o+pfotRfweH1j3kN3Li+B+Z6yAWBPwmDjWYv1PL5C0JsO0DoYeVsjSMR7B5MwDtI
 ZOQpL0l3aPPxkRsV/Sq5so7W6QOvFqCtzpIGedPUg2LCQGgx57vJOjR5jyXeWboaHwnn
 QgPYLM8msjG342XOrcOuAe4cSmO9irPRL699W97rLM0re6DtVE+afWZQZPVt5pJyy/pw
 SJNQy4j0WqrjBiqIRMnj5o6niow2Q6RF2wCIAc2e9Ks5V/QOa7Rk/8IKlypcM7ksf1Jq
 SJvJVCsx/vhFrzq06BrH+XiL+zq9V49Tz97ucoUwJK/yIqce1de0FkM3YHZBWsntu3S3
 37/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781015994; x=1781620794;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rlAAp22xuLCb9CZoQNhrmXgzqAgLGc3PRP05ob9E35g=;
 b=TLF/mddFUh3A3cqZ6q9mJRcqd86rX4rQF7sSe1UpKtn8+SgYZ7JqaHyzH3C7wLbEfk
 B9tScOAXw8GrvC45PXbId/Avo89fMe0UTq1rmnW+OvoWfy7hhurZuNeyv948125+n+Cy
 laUh9AFLtflB1nMAaRwdAQYZbdq02RqveqyZ69JNRZIcViJq8lO0I3wLdRHtVGYZxmfr
 iqL6A/gJmqw9HVj2kfRYgHnuWj0i0kVnql7XjkarGpQM/VrgNc0hU0baI1dbSb3kyHfJ
 eoD+LHNHjyz8X/IQoCmtVO0sFZGNnZBImaiGR2sbBTEEntj2EZQjjv9aV6HVgZKLQK0v
 yIHA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qXRd1rTLmtdD79posnk1nKO8twhKVei+Q9WalUa/5ACRjeS9/3IiWOjI6Ohy7QnSnEQZJmAKv4GlRG4yk@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyZWMcYDRuH6jabN5c6Oga/U7n07mDkFHjTwXfCwQZNjuY5ykbx
 Iv2OhIS3dbrmRi5MQ1eqLCfvYVgRlRrCkQTao9FsgIl9icX9Dzs6Qv2HvhPfkDtyAuVByW5YHbq
 8COzFjh9FqWi9Om2vd0nNWSgg0/119e/JSxrxdzGVLQl2jKZT6ip9vtyzGnOLg2BE7pPXD/L68x
 pOZz/cRQ==
X-Gm-Gg: Acq92OFncLaPNmQIThoxAFavUv4XkQrqDDDyMo6dws67wcG8ff3SjMlBBHHjyVDUn9R
 9cgoS5VkYyriM151x8O7o7nMSoKwCXShZ8RIR6ynhgm2onXtj7VW/2n/ropzXRYPKSQcBBcVKPx
 PXTFBO2WCdvb9C3Pu0DiPQWEXskiEnDDrQTnPzmwQdjqUvX2icZuFtSnNW/ulABHHqnVuqWiO8z
 4ZXrF8ilI1hM/MIkrWudeuhTVCEyK+Ixys0bebZMdKa7b4aT6Y0fTjaLlxEHHGz1ULzHVEPnClT
 5LfYQ8XLEDab2LYh8nDochgC9BAiy/MpGMHCJrCDVZ1tidPx5yqfyCiUydToS5yqvcpR7bHwpGV
 cB1n2oOStDf8UpyhPbz+Fz53c+LqOhAVLuu5dRTkRAaCovHdptwKtA/Q5S6bczUVWIfYe2gpSjH
 Om3shCa0GA5qLvNmKdxT3EAu4+XPypuW8QwhWmHldiLMnqSumJUH6B01afgEnKi3otFB1JBks5P
 EijFDWDAA3wjpSnTbzg4ZuIsaQmitZwak9+8WZWff4YnZjR6UYNZsvrM5/JMV31vOiAgl7P0pBY
 Ggqz49Dx3pEnxITk6AoiSKFy
X-Received: by 2002:a05:600c:4ec7:b0:490:bd66:e523 with SMTP id
 5b1f17b1804b1-490c25fc134mr312149935e9.20.1780995165510; 
 Tue, 09 Jun 2026 01:52:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcde3sm62122093f8f.1.2026.06.09.01.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 01:52:45 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 9 Jun 2026 08:52:44 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I2df0fec786184b9fcf9b7c56c74816325cdb6942
X-Gerrit-Change-Number: 1702
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1702?usp=email>
X-Gerrit-Commit: 9bb6c3cf8378bba2bd4c7ae2495f6882de92cd95
X-Gerrit-Comment-Date: Tue, 9 Jun 2026 08:52:44 +0000
In-Reply-To: <gerrit.1779455880000.I2df0fec786184b9fcf9b7c56c74816325cdb6942@gerrit.openvpn.net>
References: <gerrit.1779455880000.I2df0fec786184b9fcf9b7c56c74816325cdb6942@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5NDU1ODgwMDAwLkkyZGYwZmVjNzg2MTg0YjlmY2Y5YjdjNTZjNzQ4MTYzMjVjZGI2OTQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <43ebe2e93ac422c16854f172764d23dc9becadad-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWxca-00057X-UA
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mudp: send HMAC
 reset reply synchronously
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net,
 gert@greenie.muc.de
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0281456892954187135=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0281456892954187135==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="084DvU7NoXA="; charset=UTF-8

--084DvU7NoXA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos=2E

ordex has po=
sted comments on this change by its_Giaan=2E ( http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1702?usp=3Demail )

Change subject: mudp: send HMAC reset rep=
ly synchronously
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 2: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1702?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: I2df0fec786184b9fcf9b7c56c74816325cdb6942
Gerrit-Change-Number=
: 1702
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@mandelbit=2Eco=
m>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: ordex =
<antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: =
its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Comment-Date: Tue, 09 Jun 2026=
 08:52:44 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--084DvU7NoXA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: its_Giaan, plaisthos=2E </p>
<p>Patch set 2:<span sty=
le=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4p=
x;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1702?usp=3Demail">View Change</a></p><u=
l style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1702?usp=3Demail">change 1702</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1702?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2df0f=
ec786184b9fcf9b7c56c74816325cdb6942 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1702 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmar=
co@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 09=
 Jun 2026 08:52:44 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
=

</body></html>
--084DvU7NoXA=--


--===============0281456892954187135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0281456892954187135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0281456892954187135==--

