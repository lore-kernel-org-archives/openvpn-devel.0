Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782A3C44507
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c93G+32LrBvSaN4McPs5Vps/gluWf/9ofdwjJnfpcuI=; b=NQR9SiQK6303/rLATLwJHMlHzL
	pUUkCUwGt4Mk1ynNy8JK4sSucNRjoODSdvR/WrllzSa81nn9vMu4xafwBbytW7WXyJEqGVt2sAHuv
	LB4nTXEXY5/Xp6IibppSF/1GdKMM3oye8rjWFZ1y+7+e2zUbuyqe7YYBwHLNhEgAS174=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjboC-00089u-92;
	Tue, 14 Jul 2026 12:00:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjbnz-00089a-Kc
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 12:00:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=A6lW8D0xANO9l1tyKYYO5XXR+BcwFOqxc5f5fbEl6gw=; b=cx0ToCk0HPRQtSlVJ2kh9qsFCt
 aqq/w4xvGWerLuiNfQzTvOwbJ5u8Y8ssNyKntKmhcdoCKpynl2PWSQz7tXO8S/tQEnddf3p1uE+l8
 8UCam+yH11B/S6LsFfYhVALcGllv8nhIMtYVuQ4K0sh146nEB3wU+o/oYAXWiEin6ygE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=A6lW8D0xANO9l1tyKYYO5XXR+BcwFOqxc5f5fbEl6gw=; b=a
 j2C/PYRn0/i2/pTxCia7u94Gk62rIdOp2uQdIPErVBSBMJN1Ct8MBtfYBlGlhUzICEDDueeGc91oL
 zwGO8VqvgWNuLic/K4RpLr34hjhubOD0RX3mWnF64KvW0y/vZ01WwBBOX5dIXxkIyAFiKXpieu2zu
 5N9+1B4VY15LdC5I=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjbnt-0006qc-70 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 12:00:03 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-493ece78b0cso30781735e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 05:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784030394; x=1784635194; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=A6lW8D0xANO9l1tyKYYO5XXR+BcwFOqxc5f5fbEl6gw=;
 b=WI/RHnNG0Tr/h7Vn7yOm9xFH6ESIoBoUUlHUYc8YtCdxRdPAZvH5u6Il1OY4nhtqi9
 C8oA1s3Z5A+bmLLlmXgpKGFVy+pMknx/vt45Qu6sUlptSBNOZtQ2ezXeTpjwLnH7yICO
 12WiM43vRn2D733/hX6HfON2eKY5QrvH1FFoMPXw73MtVjNQQiyeHyEamLUM6AmCGCtk
 F8XFJ1As3k4FHlV5etSka9Z7u/N13G4klnrcVCwz0VdOIKaswkxF3mh4htsg5aeIkG9o
 SEAku58o9HSg6HqUIKt3nWQghRC9WNejZPCYdbSL4HVLGEmwHG+D9GLeYf10bmY7mH8s
 XjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784030395; x=1784635195;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=A6lW8D0xANO9l1tyKYYO5XXR+BcwFOqxc5f5fbEl6gw=;
 b=tL+OgM0UwNQ2XoR17zI4KJGXWYnsgMCQHckPAmyHREI8N6HEKTKJBwBitWJGIe8C2g
 W1I2qV+wK5MGehYRmFDs8m8UThP83DfjQ13qzs5NTt9/XopuH0dWRN/k6Z9sMu5RsB6u
 iSOnA6nq/lJeO0sfi8gMV1A5bF/nk1JOxVX06hEG//q4wDFszzaKJbxMIdYENiI80J58
 ILeTDe0FlGuNCrgSK8Wcwnn1n7hx9upPqsW3RRe3knoymnyDtL8YN4HJ+nFlEIKt9RVG
 gyzc+mMdsE4bParyw1AIHVjE6sINXTU06Akp+PBRJ9RoN8+3mRnTsLeUPMY1ym4ohWRU
 K1QQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpJGklC6GnppUJPWy2mGrhqxjHnvSZlRUc1maeAqgNhfIIx9lSaZv3i7gAKYpFmrWbOqF/qSJMT61IMofC4@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyVUHUAMiowKdlLNU7r7BzGkEsDy0sk5/KWlniL0mYRLwA9nxQV
 SseG7hnDTlH/XSQRRa6KzTPWdxejYcpjEI8+NOrJwNtD+dpA1QUzFFj5ZtODQru/t3X8d+za4pZ
 IPguSpTJGMT3GZ4d27b6esycRdDXTi/gRmemOLgehZpK3NWonkqXgpAxW7hBjVZcGuSvB9kxsa2
 UumGG1Cw==
X-Gm-Gg: AfdE7cmAIIGFVE9W/p0LgztR0XD7xj0Fv/pYY1cI+1nWnwSv55oQGwbh6ZYn78nzKxQ
 VJDhR0AP+9ucdlXecn3Bxnn8IOM8vv1pny2+urSI+/ODCS6QPUId6HDPS/U70gEIPpho4cnGU9w
 NJCvEEyXqcPvHSQNLeIXZuPGjJads5I60yjYxD8oG1IGCjAkjWjSB+XLouAKIVRTvQXmRx0mbQ3
 JKNl4L+ZfDhFJPrrTssi4TVOHjCu+BKetRmVK5ExRQlWdqaavLXW+7Yb3KEtJxZfUeG3inGvr+d
 +XkttUbVv4yNg8D5ZUJaoRe+RUi8BKPRIK/hy6x9Q1QkKwYd9hmrBSK57w0F5LNkVHqxeLii1iB
 R5F3cz0cWs5oPog6fWKqRdoea7JrdzQi/0DdxAlDDSAho7+pWezQLiVZTEcxo9+54C3OFpPM3ZE
 qDnNWQfcLiRp/b8Pr3qwlf7FmbotfzEHiF6f9YmHiWBtFyv/DjgZNjXaTEV7GTXta18nnqGbxyJ
 nSQTkXtea1E++4KRZK9YdCk2/atl1fhCXgWXNw+aj7FfwYAl+ZtCGUxQENcxc3iTIH6m+bU8ytb
 HnA1iDAfBYFOBQ==
X-Received: by 2002:a05:600c:638f:b0:493:dcad:84da with SMTP id
 5b1f17b1804b1-495158c6a66mr34693955e9.1.1784030394360; 
 Tue, 14 Jul 2026 04:59:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a2e8f07sm66297835e9.7.2026.07.14.04.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 04:59:53 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 11:59:51 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
X-Gerrit-Change-Number: 1573
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1573?usp=email>
X-Gerrit-Commit: f3cb575b1f97e1a49f67cf2d4249da9f723d910f
X-Gerrit-Comment-Date: Tue, 14 Jul 2026 11:59:51 +0000
In-Reply-To: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
References: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjU1MDY2MDAwLkk4MDdmMzk4OTAzYWMyMDQ3NTMwODAwYzI5OTQ5NzkzYzZmNGYwZWM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3a5be341843dfa812c63cec567f1ea91fb892aae-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjbnt-0006qc-70
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Replace custom
 hash_func with siphash
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
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6490191513930783658=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6490191513930783658==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LgJkYKDgsWY="; charset=UTF-8

--LgJkYKDgsWY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1573?usp=3Demail )

Change subject: Replace custom hash_func with=
 siphash
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 6:

(1 comment)

File src/openvpn/siphash=2Ec:

http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1573/comment/d81cfaf5_da165304?usp=3Demail :
PS5, Lin=
e 46:     if (siphash_cryptolib_available(ctx) && false)
> you fixed the oc=
curence in siphash=2Eh, but not siphash=2E [=E2=80=A6]
Done



-- 
To view,=
 visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I807f398903ac2047530800c29949793c6=
f4f0ec9
Gerrit-Change-Number: 1573
Gerrit-PatchSet: 6
Gerrit-Owner: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Commen=
t-Date: Tue, 14 Jul 2026 11:59:51 +0000
Gerrit-HasComments: Yes
Gerrit-Has-=
Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg>
Comm=
ent-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--LgJkYKDgsWY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1573?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/siphash=2Ec:</p><ul style=3D"list-style: none;=
 padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573=
/comment/d81cfaf5_da165304?usp=3Demail">Patch Set #5, Line 46:</a> <code st=
yle=3D"font-family:monospace,monospace">    if (siphash_cryptolib_available=
(ctx) &amp;&amp; false)</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">you fixed the occurence in si=
phash=2Eh, but not siphash=2E [=E2=80=A6]</blockquote></p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></u=
l></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1573?usp=3Demail">change 1573</a>=2E To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1573?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0=
ec9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1573 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display=
:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 14 Jul 2026 11:=
59:51 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </d=
iv>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D=
"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--LgJkYKDgsWY=--


--===============6490191513930783658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6490191513930783658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6490191513930783658==--

