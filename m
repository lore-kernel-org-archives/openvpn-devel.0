Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5B2C98310
	for <openvpn-devel@archiver.kernel.org>; Thu, 24 Sep 2026 06:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0/HeR0axnB/6SKrEwiKaGeXXlrpNqzmC+6TLAanBNpU=; b=W4qpPA3E1KKfntH5te+js5eNGZ
	JzHlThBBbjzHoqdsPYdg2zrk0UylfEQoErwPplVHykI5LCurrnWiZ9z91QAU3cqa3V432jE15OJV+
	vEudBZ+JEuJY+oViqd/PGtTujZ+HRBE+5BFzo7qEYBQEPp/i2oeIB8o3hLFBApTE3ES8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9cqZ-0002CQ-2O;
	Thu, 24 Sep 2026 06:22:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9cqX-0002CK-92
 for openvpn-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 06:22:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=mHHoAwXTVY3HpRp5bzdi9peHRiFIO3oeuuIUR1Gq5K4=; b=FRlWujGgFw1eeqXvWmHttTmQK6
 9qtufWenoyTCZmkIKPhRjmhoXQei+4DAiClmqTHUkTWhXGqYSzHT8bnY9OewcbWRNyY1rXzPfJgOx
 Ja21bge0TYwasgOHeqPr9mNfm44sYjZ6ae7X3EIqt56+FKiPfMj/lAHHEm1NtS1Vegd8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mHHoAwXTVY3HpRp5bzdi9peHRiFIO3oeuuIUR1Gq5K4=; b=I
 KYpQasWYhNtEVKVe0g1H3dcgeuhd9GmM0/jFFgj4gYPm7wtmKW68FUhc2/T9OYwGi0cCH+BoPAFzN
 5Equ0LJn/C/zL9v1BCgfbFZQXxIHoUgmsQ0hYbC5zakSpJyCTcGs7d/ZYOMfB/kbknc0u+Iuiigbf
 PhUyrYwZrRdAGyFY=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9cqW-0005OB-0V for openvpn-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 06:22:17 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d37b6so9252165e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 23:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790230929; x=1790835729; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mHHoAwXTVY3HpRp5bzdi9peHRiFIO3oeuuIUR1Gq5K4=;
 b=T3S/PVu5UunOIfSEQnjw8M7jMBI9IuOySGZmGvMCWsNiQVNePs34vdyVrKorA4Nx3/
 Ftt4/cM600xYYxolRAufLJpJfJDO3lat/YB9Qr0aOqRPrRuJ8HGPsoM9QMANrqRqIkYD
 zTlwxIx924bST5jTF2kca5xRNXj+0MsaiVDIGVbBO4Ddczm40YlR801wgJwqRmAWN0lL
 lbcYRS5C3UTICFJR/I3R9H80pLVnpC7ooTKrlWoW1zquoXes+E9CNH795kjxqtVDz4Bj
 O1CVmR1Frbjf2LeKJevlDx/iJmf+YiXmFH2XDfB1yCxMzgLuzYbSXONo+/rOopcf1WBR
 nkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790230929; x=1790835729;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mHHoAwXTVY3HpRp5bzdi9peHRiFIO3oeuuIUR1Gq5K4=;
 b=Wd6uGGD05sajFIcPoRF57wAH/Y/YPfKPpYJv/64xZVoAgj+pXi1mL9H5ZV1Z7fxjj2
 KWw1Ie1zQJIi3x7IX48bK4l1Ztc3Ol5Yr/4T//WlUoE18dbPbp73wBoLY/Fwz46ZF8e2
 V/xw/F+2CEkZ27p6uEoPLpZ6gvdqffu40+NGDSHuMYTmlXFtsNaGK8mUdonH8sKdN5Hy
 ID50auM4HK7MQgq015cKNwSL0jfRW6mpLbEB0wdQsiX1QUNKFXmavF7Owo1DRz57YFF/
 +eyqk37r+q+uN08bIjiMeJBUO4CC9Bzv49+cCnqY3up0KXdq9mBmzC+crN7InZILiBrL
 EUQg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQuurun2X/fnUOxArYG89ZlqjBhLtq5x0ALWCqxpcIdoNLwrkoytdexep65+ZFXLUf7za0eDkgi0Eqcra9@lists.sourceforge.net
X-Gm-Message-State: AFuF++kbwRIa/O+lA6Nb1SuDUL8KTpXykXV/ABlDikExU/F25+BBkgSF
 ALR7g2Pv1Oo3VZbb70w5KC/vdqWB6VL4VNa87ghnXEqWdNk0QEScveZAWkQ2K61QeyqxqMDqdR4
 +ngbL4kfNRWIEbPn22yougeOr5uSWVop+h6PPJwogJiLIF91qk1/ktoysXAH0Vl+QmValTyl6LB
 5/hSaLdA==
X-Gm-Gg: AYBFou26Kqps1UgcvucG5GjFCsbi6tx3EV4FDBjVphEyOFZ+fg9c5AIV8DhBdUOmcE1
 qtuqoW75AomC6377r2Xsm3f6UhT8cSkEFDsyBcbqwH6N+NL9x2b21PJPoPBjDx0/Qn+e8KKvhct
 o00qX2v/8/FScS9fxQKwXdEn4r0ozU+xSDV+lbq51ImjBZ8TBEWXznTh8VYLOyuhxaG55cBo6QP
 aT18Ww2brT7Ao5OSht7Xh4yloQAwDamhQdY8/cJKkZIRheb2BtTPWHB+sfFliIOE5tHROFqKnXb
 BlG+kfp6TvVtnZDPMyg5X6GZKwInncrwVAfTAnD5k0z+Corcj9vee7QNdEUUVohnVeRjqhr0Nel
 AgcmKwB1Q+pPjAv4hIatcUvwWRQ01EPUe2My+e4GM6NpfVVh9nALAVVtVBbi3bbNlWxhmUTGLIF
 bouUuZkqQzUyS4u5f0CR3UngXUdU0hn2L5Df1HkbsQmVzll0cHuBrF6uLZLUcQwuzso/j9yzDoX
 Kn51qd2Q6R5vlFfV2suosMmJ037dWqRxbrP6DcOS3x9lfFLLbnlE72XOOI8Wux5+FOy/NOQ+rr5
 2fyHr+vnO+ImwzsbKRn4D7ITX3zvSFPw8BIaA6fqqMJqEchV7kX8q8T/am/g5sYpaZ3vd/o=
X-Received: by 2002:a05:600c:a013:b0:49d:2555:1a6d with SMTP id
 5b1f17b1804b1-49fe66f1ac3mr18734615e9.16.1790230929400; 
 Wed, 23 Sep 2026 23:22:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5b9c288sm41640285e9.2.2026.09.23.23.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 23:22:08 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 24 Sep 2026 06:22:06 +0000
To: chugly <charlie.vigue@openvpn.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde
X-Gerrit-Change-Number: 1946
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1946?usp=email>
X-Gerrit-Commit: 472d1fe901e0a0261fd0cf88801d08820cd201a6
X-Gerrit-Comment-Date: Thu, 24 Sep 2026 06:22:06 +0000
In-Reply-To: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
References: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMjEyMjE1MDAwLkk5MDg1YzU1YTdlZmVmZDMxODM5YjAwZWM4ZWM5YTZmMDg1NTc0ZGRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <94e6dcd3b9921803c76cf03bed82e923ef7c6913-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9cqW-0005OB-0V
Subject: [Openvpn-devel] [L] Change in openvpn[master]: tests: add a unit
 test driver for route.c
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
 openvpn-devel@lists.sourceforge.net, charlie.vigue@openvpn.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2779387530733862173=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2779387530733862173==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MTPbQRLxKZc="; charset=UTF-8

--MTPbQRLxKZc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: chugly, plaisthos=2E

razvanc has pos=
ted comments on this change by chugly=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1946?usp=3Demail )

Change subject: tests: add a unit test driver=
 for route=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 1: Code-Review-1

(1 comment)

Patchset:

PS1: 
The test only =
builds on Linux (see the currently failed BSD tests)=2E



-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574=
dde
Gerrit-Change-Number: 1946
Gerrit-PatchSet: 1
Gerrit-Owner: chugly <cha=
rlie=2Evigue@openvpn=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: chugly =
<charlie=2Evigue@openvpn=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Comment-Date: Thu, 24 Sep 2026 06:22:06 +0000
Gerrit-H=
asComments: Yes
Gerrit-Has-Labels: Yes

--MTPbQRLxKZc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: chugly, plaisthos=2E </p>
<p>razvanc has posted comme=
nts on this change by chugly=2E</p><p>Patch set 1:<span style=3D"border-rad=
ius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-col=
or: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1946?usp=3Demail">View Change</a></p><p>1 comment:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?tab=3Dcomments&amp;usp=
=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">The test only builds on Linux (see the cur=
rently failed BSD tests)=2E</p></li></ul></li></ul><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail">change 194=
6</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I908=
5c55a7efefd31839b00ec8ec9a6f085574dde </div>
<div style=3D"display:none"> G=
errit-Change-Number: 1946 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: chugly &lt;charlie=
=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 24 Sep 2026 06:=
22:06 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </d=
iv>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></ht=
ml>
--MTPbQRLxKZc=--


--===============2779387530733862173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2779387530733862173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2779387530733862173==--

