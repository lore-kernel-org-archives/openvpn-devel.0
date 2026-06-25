Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C67BCDB479
	for <openvpn-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JwdsonQ7To6CfXlmNwR/7U8dMze3RtH66RSU2jyW+kw=; b=O9sGGalsJSp+ip/ELxmxU4EQcI
	t2Py7Ud7feX61SWFk68MuuWfOU8+ZO1PRXA82crwU93ugg3VOA+FLQ/HjLh3w6qd6QR9XgA9OlB8R
	FHHo7rBgeceXN6moiAjIrfgKSOGqBHzFiHWLu2pxPr3hYcoLQVvlnp1VTxkUGfw8LRKk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wchdU-0003Xy-GG;
	Thu, 25 Jun 2026 10:48:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wchdT-0003Xl-Nu
 for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 10:48:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=0jM315OMRHNzgFQgc41AQW6RB6LBL196n0TH7al6uWQ=; b=AKjntp56BOYzuZ6yVCezGNzRo/
 mf7gWgw4NRM/JQyBhUxvCP2+BnlAnknpW6xaBJ0uVSl98OigQ80HFaTzeJ3CjnfI7nwsoU6PZj95I
 Av/dah3Eh0f6tSISMJSIIJmy6f3JqCwFkz6mVBQhAssOfLpKrq+5xzvP9BtEd3IHIO48=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0jM315OMRHNzgFQgc41AQW6RB6LBL196n0TH7al6uWQ=; b=F
 KynrINGHo9GYoYNx6cyIILsNvYrg59p7Dao/72mh5NjEdkEjAYJ0mGI78yCvSPGECZX8tRHxA8/tZ
 o89Cm5Ei8e37+cJ64uoPVBGh3qqNbnoD3CDErGIOV1U/tBhx8nIWywrI9/lybVHhZTiBWT55hSjBs
 To5aOIeB0C9AJUR4=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wchdS-0001oQ-Mc for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 10:48:44 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-46def4bd5e8so391618f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 25 Jun 2026 03:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782384512; x=1782989312; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0jM315OMRHNzgFQgc41AQW6RB6LBL196n0TH7al6uWQ=;
 b=IfHqIbFLgRwdwhlcn5nyg7a/J6q/foQqOLViImHoMfQEtGXze4YLbgsbhyNcbq5C5x
 3An/XE7K5xz5REveRS7AjHXKNcjXbTb+mggbjm2Y5ZGMMuJL6z3nyBG8xGWyOUNj4KER
 py1reUiwPZgwbm6rBt3Ul467in14Qnx0gWA7LIbtWPMWqLqrwOj5hDKuxjSrxq55O2V0
 lXtvmxwBMzHzXfPawDSTX4D6XLLGzQubx4esTdtJ41U0HaNo+kVk+eEHkqMQMn3aM3nR
 MeCVQoE4a0RpHWZ6riOXKDz/VCFu2s+FTHtEyplTzZct7df7thjJJhR/PgLILR7CXt7w
 FvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782384512; x=1782989312;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0jM315OMRHNzgFQgc41AQW6RB6LBL196n0TH7al6uWQ=;
 b=jMjT0FhsvCCGRKWTeZsffghArk0jhzc6IUoHBdsl7qSDPJrHHl5brTtYyNE5+LuKEL
 6c7PETTxQBOJZn8bdZFZklSd9ASzhGWY95LXXClPhwagtmgiVt2k9XnupE4HVr7UTqRb
 ZwEthEiBhgsjK9oAO/5ibMMuJ4i9Ij3EbZ6u/3JdoGx3ilawkWOd9clU17tP24EUVOzO
 LO4HlC30sacjRJgeINhr2FQMqWK+jvIPMvO5iOQkBmmh/Q2TR4xJ7w2GFkCsNq3G/67i
 JyghcNKhg6CIY91aBIUe5OyPQrVVqMzC1SOhGorGKNV/EmxIR4XtVBDEiow9F731c81z
 0/wQ==
X-Gm-Message-State: AOJu0YyVL/J76yn+hebBca6jeO+AsT437YFwU6c/d9ia/0upSXx+MBgL
 MQbOsFtJBQ1qkaWnQcQCGT0b37gVHr0ofojccFihPfWAFPXKSJPl3isZXfIVEQVv7QB0jSQwYBG
 FYxfSyhIW7epAEYSbFLzc+3e4Kxp34p1Sd5oucutWM2+FnC8L7W/GafIAP4nbrXT9wXn4VTWFfi
 nUeMDk1g==
X-Gm-Gg: AfdE7cloujdn+KxLs1XsbXIlyJkepOwQlmEV90ZMEwBbqaTZ1NZWkmZ4Q0qKXtVqWoB
 4PAPR8XFeWnjsHrrJpe09R/Sns/aGLjTSB7Hxy8iyeqlhzBRPiP+CHRqFubWukh15YN/BWiP04o
 ehT7j26o3Ju8bjD8aMh9+Us0wmE48UCjF67+pif7Ak238pXfd5WlPr+phR9iodGBO7ae1FdCcSH
 1NBA3v3JilGVVVNIKDYmg/trQhNXYBWPZ0MfrPSmnV2Ies4Ro+71iH9py1b1RbcnilsQlyHL6UP
 kaHbo262N7phlZbJer6xlYQeuLOwFCE8R4p+d/GJgk+iYWxA8RQRpNXx+Kw46b62foK7Jvo5RNt
 hDcVRfhu1W0eutGBNHCyI56fL2b1WZVvxBRdpZvtHSWBkBk18jYuiH+0tOoLyBpdtapZ4m9A7KB
 4fTUJNncEpzHI0+nkrsGDOMaKXZ80uzHG+qCxtK5Ym+6Xl+pdsCIUBi/MwtDH2BVvVlemCr8VUo
 1noqf7+3RRhtAgmZMns1y3curMDx64RyC4dKdDYnM0CHcPnXrrPAPCVB50V7B87p5f4psQowPQK
 84Y=
X-Received: by 2002:a5d:5f44:0:b0:460:1233:ecf2 with SMTP id
 ffacd0b85a97d-46dc12dfb53mr2944987f8f.30.1782384511416; 
 Thu, 25 Jun 2026 03:48:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c9f240c3dsm12918423f8f.35.2026.06.25.03.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 03:48:30 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 25 Jun 2026 10:48:27 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3f9834cc13c49b9249653d7d8637383f50c2fb87
X-Gerrit-Change-Number: 1729
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1729?usp=email>
X-Gerrit-Commit: 78a52c142ef1f4957c01f932c088fb78e58ac5a7
X-Gerrit-Comment-Date: Thu, 25 Jun 2026 10:48:27 +0000
In-Reply-To: <gerrit.1782252033000.I3f9834cc13c49b9249653d7d8637383f50c2fb87@gerrit.openvpn.net>
References: <gerrit.1782252033000.I3f9834cc13c49b9249653d7d8637383f50c2fb87@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMjUyMDMzMDAwLkkzZjk4MzRjYzEzYzQ5YjkyNDk2NTNkN2Q4NjM3MzgzZjUwYzJmYjg3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6cdbbf9fa1ba2538726dffbb14328bcaeae55a05-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wchdS-0001oQ-Mc
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi: don't let
 stale-routes-check delete permanent routes
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
 antonio@mandelbit.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8266613149768477144=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8266613149768477144==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7dWvO8Vcitg="; charset=UTF-8

--7dWvO8Vcitg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex=2E

plaisthos has posted commen=
ts on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
729?usp=3Demail )

Change subject: multi: don't let stale-routes-check dele=
te permanent routes
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1729?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I3f9834cc13c49b9249653d7d8637383f50c2fb87
Gerrit-Change-Num=
ber: 1729
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
=
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: ordex <an=
tonio@mandelbit=2Ecom>
Gerrit-Comment-Date: Thu, 25 Jun 2026 10:48:27 +0000=

Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--7dWvO8Vcitg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex=2E </p>
<p>Patch set 1:<span style=3D"border-ra=
dius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-co=
lor: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1729?usp=3Demail">View Change</a></p><ul style=3D"list=
-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1729?usp=3Demail">change 1729</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1729?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I3f9834cc13c49b9249653=
d7d8637383f50c2fb87 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1729 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div =
style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 25 Jun 2026 1=
0:48:27 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </=
div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></h=
tml>
--7dWvO8Vcitg=--


--===============8266613149768477144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8266613149768477144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8266613149768477144==--

