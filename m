Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FC0C53219
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gcuZ4T8xuer6Xle9nwSswCpv1VKoCtsxuq43dLMt9jQ=; b=VFUOrqpaVBX/SI498g0TS5a0q4
	1zxDAGBIp3nIStA2GRSgDzHZrokiFIYew8PjwTL9hXfJIfTrCFuNSsJVR6FuJOuz4EiDdBcFx6EUm
	U8BtWU37s8d7/RcYnIVEuzFa6s28PlYQ/uJYQqCB8NpUaulhh+uUPzu0hkECf+YBJ5hQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woh31-0007KL-7W;
	Tue, 28 Jul 2026 12:36:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1woh30-0007KE-0O
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 12:36:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Z6mxOo2mLVW21zYjqfxg6T+N8ptEFCoaOIp8QuLTN5k=; b=moa6IGpSPKab4uM7Eq6UxlggD+
 SL0UgZm0fI56p/2zrsSEUQT3mJJD1KsU/XPs3yqnj1koYj6T/USfFnT8ZbogM6fIabzmanMeTjMyu
 1hklC1bdjmi2ZRhuCptUCR8BnzZIp6RbVQe+AmnX9tiM2JHtC+bP0DfKstUHkZ/W5ftk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Z6mxOo2mLVW21zYjqfxg6T+N8ptEFCoaOIp8QuLTN5k=; b=S
 S+tkC2pfq4uK+Aq7Atmp79bqKQOoMiQgn7YtH0Tch6h2bU6TPh4MWJO5aDRxd1MXg0OP3YhlNetcu
 FIJcAwiHeMFNf8QRmHE4Ovs1fAQHrrA3TNeXlsnVuAOrfanUtHjDjbfAxbWmOVjtVbJk5dxVMZA2+
 rhvaJv85FcLvmR98=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1woh30-0004cM-BJ for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 12:36:38 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so33565635e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 05:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785242188; x=1785846988; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Z6mxOo2mLVW21zYjqfxg6T+N8ptEFCoaOIp8QuLTN5k=;
 b=MR/9Gx42utfQnIvU4OUjDZ3BXDW1fVVMnoGYWh13VhwiYji0cYCrjWwaNY9v3USAWf
 KDuOW4maSHe2Y4xxmnX06rzFMuyIyKnXahBnhFcvedi/9w+la6tsOS0RRDw4tOzERDIP
 V7jgkVarBsTkgAtOwGkxndeWMzIBbD6NRZwOdUI1cmB8KjoG8xloPXbcUnqz86djcTKo
 LiBt0PebTrWXAOwk6f+iXJBC0Zxq35u/FGKarIT/wYmZS87M95FDxOYG5CZuC/C5eT9+
 DsrKz3QWCU/YWe5z394gGGTC/sGzt6lz8HW5OMdiZBZxMRgcj85BpzLpj0hShn3IUgo+
 UWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785242188; x=1785846988;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Z6mxOo2mLVW21zYjqfxg6T+N8ptEFCoaOIp8QuLTN5k=;
 b=MPOwSNvY52F3jjcV8/qaFYBSr8KslvwWk0qV4BQAGOUVKrp1L2jU9q66s9BKF7lJKY
 mtyyduJ4+Nzg+STihUKM13fCcOkxRu+cFsbtXDXhO9HsuXxNVQ6UdquPoCspA35Xx08O
 L4jvDec3rmbpZrmLol3rdLrtXbya2laATe04aF2c7142eIC73y56guwdVSq/s4+sXpK+
 vBcNS0/hWEeBSOHHR4Saqazmu4YV1DBtAJslu5juMoowfblmGxpzemUKQRvccOMdKP9M
 ydAeC8633sbbZDfBYuwCizVOr/ymQHc1PQ9V//+z+gOk3fFOb/yYXsR7qNJ1yV01wt1X
 P1dw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqBIRq3dTsxmWc6zoOaQOhdu8RxA4TRZHNqITbtN0uAU8JSrrY+l7prkHwIglua8p6d6CPJgnqkP7bRS3Wi@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yykmfena43FEucv9iRiPqAKz4TAe9/EsCpaUOlSL9km70L2JopU
 bKyzqsv0/zo9BRC4nTVZff00kY4Dv2KvIYP4Olb0kQbC/HDx/o62VJKQpoCIKI+Cqoavqig9sQ5
 kXFQVu2mNNBMIewaVOywU22ZcC1SVqtqn4gJ50mm3KBPhVa1eWozVAmUjhMllVr15BTBVC/Fa0b
 647OHQCw==
X-Gm-Gg: AR+sD12yCwk9Q+hLEwV85cKHbYhnyc1ApZHybk/TbCGBpaJJ2x1dw6rhHyyXx2yp7hf
 qKyJN3cTlf96GQwTZ7sTCVsFiy/iOkHSxZkzrHgq8PIYaNsNxeh6Z2cBfLUhaEEoaQlz8g5M8MX
 NFm73emZ1FNKkTSXqMnngu3QNbnoBWB/MQotM98EbcH1fSf0FSw3pfcOPz2RaKrBJax0x0jQk6i
 yd9QuXtMrYq1huSrUBDkwNsBaInBIVwm3xpWXiQ5po9tc8nLSUAs0O70SqNcH6yxlQUBHZK25Jn
 8yimv/4LFcYxNng8tmhf2sWLbSFsw+ujrMvYnPc8MD0+QubVuDTD6Cr+tKIZJthCYjcPJGKXGK4
 JxHSo0xJEqnvwm6KKZdHJOpzzVi6GuxJ6nc5lVcWjZOqsMCdjooacUQ2ruqoiVUEq/ngI3zMUhj
 I6zQDMo1c6BiVgil7+h6LgajUpfZ51qz7PvRT5sNKcamvO5NyOcFW1FXEVyAm1L8lGt7mMBw5Ay
 1KzAKWiHxOPlsFiIcsYYlPhD/CKR7F8nnq3SI4FrQfB01ft6jZiIQB83EThYxjEszV/
X-Received: by 2002:a05:600c:354a:b0:493:cc25:9c0e with SMTP id
 5b1f17b1804b1-496c643cdf3mr25392315e9.14.1785242188013; 
 Tue, 28 Jul 2026 05:36:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45b1c2asm77056095e9.5.2026.07.28.05.36.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:36:26 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 12:36:25 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8
X-Gerrit-Change-Number: 1828
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1828?usp=email>
X-Gerrit-Commit: a106971f5cf6983ff862a7c0d8de831cd05b6bb2
X-Gerrit-Comment-Date: Tue, 28 Jul 2026 12:36:25 +0000
In-Reply-To: <gerrit.1785239387000.Ie33aea26026e07c860da7d79880cef6b27b7b0e8@gerrit.openvpn.net>
References: <gerrit.1785239387000.Ie33aea26026e07c860da7d79880cef6b27b7b0e8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MjM5Mzg3MDAwLkllMzNhZWEyNjAyNmUwN2M4NjBkYTdkNzk4ODBjZWY2YjI3YjdiMGU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <718c4ec1a8069eea2bd6f34df7aeb53afe48bd63-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1woh30-0004cM-BJ
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Move schedule test
 to a unit test
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
Content-Type: multipart/mixed; boundary="===============2856059124713128864=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2856059124713128864==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qbg+z0NrMHI="; charset=UTF-8

--qbg+z0NrMHI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1828?usp=3Demail )

Change subject: Move schedule test to a unit =
test
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 4:

(1 comment)

File tests/unit_tests/openvpn/test_misc=2Ec:

http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1828/comment/e034f826_acc38827?usp=3Demai=
l :
PS1, Line 493: <<<<<<< HEAD
> conflict resolution damage
Done



-- 
To=
 view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: o=
penvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie33aea26026e07c860da7d79880=
cef6b27b7b0e8
Gerrit-Change-Number: 1828
Gerrit-PatchSet: 4
Gerrit-Owner: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-=
Comment-Date: Tue, 28 Jul 2026 12:36:25 +0000
Gerrit-HasComments: Yes
Gerri=
t-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom=
>

--qbg+z0NrMHI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1828?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File tests/unit_tests/openvpn/test_misc=2Ec:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1828/comment/e034f826_acc38827?usp=3Demail">Patch Set #1, Line 4=
93:</a> <code style=3D"font-family:monospace,monospace">&lt;&lt;&lt;&lt;&lt=
;&lt;&lt; HEAD</code></p><p><blockquote style=3D"border-left: 1px solid #aa=
a; margin: 10px 0; padding: 0 10px;">conflict resolution damage</blockquote=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=3Demail">change 1828</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:non=
e"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-=
Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master =
</div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie33aea26026e07c860da=
7d79880cef6b27b7b0e8 </div>
<div style=3D"display:none"> Gerrit-Change-Numb=
er: 1828 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div=
 style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: T=
ue, 28 Jul 2026 12:36:25 +0000 </div>
<div style=3D"display:none"> Gerrit-H=
asComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No <=
/div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>

</body></html>
--qbg+z0NrMHI=--


--===============2856059124713128864==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2856059124713128864==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2856059124713128864==--

