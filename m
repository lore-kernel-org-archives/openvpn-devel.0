Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FD8C61DD3
	for <openvpn-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WFYd/xmCralEWBzyppNJNPof0aMWYAlhaimxXhUghTY=; b=DSmk5JYu24Dql9TouXOXe7QIdb
	9R6Q6/geQwjLJ700NOcm5mInicsd7CJ1t24PSS5OVUp0QKuchzeNK5fJ8BEIk3oxa3JW4JtgxpLaN
	d9HUNnTKtEaq7wtZ+cyaFq6HoFzzJlL8hvy5/QIu7XRWK9Kg96rdUsIK3O3pfgELKsro=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1Tsf-0003Wa-AF;
	Tue, 01 Sep 2026 19:10:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1Tsd-0003WT-HW
 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 19:10:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=W4hhnKF5aC6i6HkjVb+Gu5LPK4m5IrHZJhGrSKgQ5Fk=; b=jnXGt07OqwZn5QgdpW3v28ghgL
 yTFhwD9lgJEFYkDLtYKUl4+Mu/EWvZfPS1zmHxuq/nG00pTqbXkuYsBKXfee1zIAIECWnLtE+uGzz
 bHiVQzzOQu1wXck3Hxyjkw5Xoz+XraUrdGCixMU4TR1TGq7+qa3nw00o7RqA9IrhVBCY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=W4hhnKF5aC6i6HkjVb+Gu5LPK4m5IrHZJhGrSKgQ5Fk=; b=O
 hi7OM5up9Ia/DPx6utNVIml7aesRSur/tfg8NAb3TyQR33Azaov4PkhjO6txCNvDLE7UmoUZZGsDT
 mEBgIhbpbXGXJwq8DE3LcqW8lM2dQHVIcQJT2e/bLhSX1/F8vY2n4k5ED0DuC2TihAPWHEV7TexrR
 1gh4uf0/3EMShJZQ=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1TsZ-0003Qw-98 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 19:10:45 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-482e2fdf6ebso271310f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 12:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788289837; x=1788894637; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=W4hhnKF5aC6i6HkjVb+Gu5LPK4m5IrHZJhGrSKgQ5Fk=;
 b=QGoSHasnPmjRBfxuwSXqNAk9M9PLb/AXM8ff2oOehY8nCthY/k5mGe6jl9hfDaj28v
 jhutHPF7YSpSctbsef80neJK7GXBC2lr8cpmd739v0GyqpDdpVCpDZe3/Ev2nOwafSE1
 GV9GIEekuksj3VaznJnYHb9otoRxox8D/ExQtuN11VPM2I+5q58vv2jdM/x01/HRiB3C
 U/8peqpKPqH1YGf2Fh3O1FHj4Mmvryi/ybM7CIp7IahWLhhC1r/4I2kTqCAIJdTSs5sM
 PnjxaE7c+0nijQW6pbBxhQkKb8crg2/7cNgVUTHlsXhE9pT83Wso4PQJ8F6I7Hl5ipWz
 ZYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788289837; x=1788894637;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=W4hhnKF5aC6i6HkjVb+Gu5LPK4m5IrHZJhGrSKgQ5Fk=;
 b=a/jnY8GtB85pewYorRNo/KR0EDXzO8GeIV+gfmQovPs+nY0OysoH1CAnaO2xclqsBd
 8uJIXH5OSTUvZEm+MS20mnq2j0sagki1Wx7QUDQCOAKk+oiiya7IDt75IQDBueu6MQGe
 yV/1dwYxmpbcGJ5LwU5Rw7EcaCr4eXjKOhd+ZNw4NJPlc3EB/TvO4/04bUgirA8srB7v
 Wc2xwCfNLdpgP/ROp2HwWuWjbU0x33JurQwIQ8BvQs3Ig0uRxX/bf+ai+N8w3zuZ4RUI
 TGBbW8slxLY/Jbb9ICg8OrDcV9FmwpCOzZ9O2uU44JkAhhmzrjyt8fVUwzAIBqDMqHFu
 Ax7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzp0kTPeEDaT+2c8P3EY08ianubZYBJE25AbPqy1mGrpWC4xlXgmf7uzhXk1ypL9a5sDnUXqWMFfVBliWYt@lists.sourceforge.net
X-Gm-Message-State: AFuF++k9ot+RpMLwhW7xJqIAhA3CP7Ch8IWy29d5WiqqpKZ7aXAu6Kf6
 kgJNJLngFJ/HxgV7G0bjDa7Tkqo8J4OLrekhXq56a+JHo96bFiZZSDFNT9RSK2eKJEF8c/Zxktu
 oWwemUd/GOcDD/gVbmEkADepXM7WLWgN9rnLcUcvRNPWKHfMH5suebYYJ/Ow1q+CkafTL
X-Gm-Gg: AYBFou3BRui9liXULEuaPCFC/nXCVGLyTUGwXESutavtCIDE9H0jo4iLdthzlgODiA8
 tDa8WSCg4osa6GhjxrHLINDno9ySC4L0zeFX2u4f3Jgc1W2UNEJd5S+w8rxUCx7UnxaYhYq4889
 R19Cx1tft5pUrUK0SQqOcL2FT0A3gpVc4Xm2ciLrgL7v2IYM9Pmn+9yVQHXTtYz7LRpCH6gYyJe
 +j+tNIDsioZRVAsJJh+MT7wBw2tXCcLW42pwozhFrMfv8JxyJd1dMY6RO5aVkzFrZl09jsB4cHN
 RXA8Nd3SaQ0NCxyNOhpD9075KnX6CWaMbF1dceRqK05cJoRUlBVkAxDeGaOjmfJi5KGBn0Yf2zb
 bqBfCViWw2r1epI//+wTmCa5z7j4kLBXM2heq9TpS472nXOTjXD+dIkekxk2C1Yr0qvxpUXyT8F
 FKKFJ3CSXsJzOnBKX5gdOavBGCghPylQojUYFLXvohDBMmLlM6cXgacbbiOH0lMWRm50ctOypsO
 9F/WZpoWt38QYierAbtC1Ua566FkZWEPZw0h1qYbo0QffbEQd6UiydvrBUoBnZ9JQ9SkqJq/oIR
 5v59zjY8l5ntaGBsUuWW2SNjwA1BccrE5v3d7JMfrWEJMOhH148=
X-Received: by 2002:a05:6000:468a:b0:484:36c1:2881 with SMTP id
 ffacd0b85a97d-48440fcd8f7mr16799039f8f.2.1788289836433; 
 Tue, 01 Sep 2026 12:10:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e72b5bsm985705f8f.4.2026.09.01.12.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 12:10:36 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 1 Sep 2026 19:10:34 +0000
To: d12fk <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I787a7067f6ff040c6a1f43f384321bddf5efc97b
X-Gerrit-Change-Number: 1889
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1889?usp=email>
X-Gerrit-Commit: 395f0a0e0661e4acc76432a71735c45d5cd657a2
X-Gerrit-Comment-Date: Tue, 1 Sep 2026 19:10:34 +0000
In-Reply-To: <gerrit.1788282372000.I787a7067f6ff040c6a1f43f384321bddf5efc97b@gerrit.openvpn.net>
References: <gerrit.1788282372000.I787a7067f6ff040c6a1f43f384321bddf5efc97b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MjgyMzcyMDAwLkk3ODdhNzA2N2Y2ZmYwNDBjNmExZjQzZjM4NDMyMWJkZGY1ZWZjOTdiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <60e28449c9cb88c8220e9387c528dd485fbf2f46-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1TsZ-0003Qw-98
Subject: [Openvpn-devel] [M] Change in openvpn[master]: win: don't use NULL
 DACL with system objects
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6106252350291238778=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6106252350291238778==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="x2wvGlq5sbY="; charset=UTF-8

--x2wvGlq5sbY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, d12fk, plaisthos=2E

stipa has=
 posted comments on this change by cron2=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1889?usp=3Demail )

Change subject: win: don't use NULL DACL w=
ith system objects
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 1: Code-Review+2

(1 comment)

Patchset:

PS1: 
Reviewed=
 in private=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1889?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: c=
omment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I787=
a7067f6ff040c6a1f43f384321bddf5efc97b
Gerrit-Change-Number: 1889
Gerrit-Pat=
chSet: 1
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: d12=
fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: stipa <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2E=
de>
Gerrit-Attention: d12fk <heiko@openvpn=2Enet>
Gerrit-Comment-Date: Tue,=
 01 Sep 2026 19:10:34 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--x2wvGlq5sbY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, d12fk, plaisthos=2E </p>
<p>Patch set 1:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1889?usp=3Demail">View Change</a></p=
><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1889?tab=
=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Reviewed in private=2E<=
/p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1889?usp=3Demail">change 1889</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1889?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I787a7067f6ff040c6a1f43f384321=
bddf5efc97b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1889 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D=
"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@openvpn=2Enet=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Tue, 01 Sep 2026 19:10:34 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"=
display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--x2wvGlq5sbY=--


--===============6106252350291238778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6106252350291238778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6106252350291238778==--

