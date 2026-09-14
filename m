Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE35C88E73
	for <openvpn-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HdAsl61/RAv7H8Gn0NzzUsTYUIQGsGEO+hPAtdgINhQ=; b=jyKz+XrJsZIGi6L2UX9iE+6P2i
	8tM5AK8qmwfMw34GyS7dK2IRK/lVLOzywZDBwMmR5KBj1CyFiWBt0lR0vRrmAlLkyRypYmZncCfAm
	ZVbINyR4f00c71xui/511arP9qLV3Rgg6tmzspGs3JipzvhJZ7Wq78UErX+EnFp7Ep54=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x67mt-0001RR-78;
	Mon, 14 Sep 2026 14:36:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x67mr-0001RK-Pj
 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:35:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=BVBu4qXXXvc7B7p69GCjCQsodvuP+o2wGov855W2Sac=; b=SxqVWzZkqbyfD7Vd6Okn08tUkB
 4MEdRbIRCJcLcaiGi0z1fo9n5DyrfsBi7QFs3lX3ne1puGY2nQqj2P4MlDBvSHfUZlbpv6/6vGZ4P
 CImQ2Nd/uJX5pkBAS5ACwHk9RnivcvrfMRj2Ruih2emPvxFz7cHnbj1q+lZHADoN3Z8M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BVBu4qXXXvc7B7p69GCjCQsodvuP+o2wGov855W2Sac=; b=Z
 I16yyldeaR1i7owBj8CwGDbDoPMNzN6nkV4aSYs3ptwoh7Z/Zvys6gTKS60Ub7AXohJxBd9O8QEhN
 hSemIlx14vAB0pcBq9rihfzgzIXMXyPNJHeT+YAU6vNZiFDTQtCdMUAfoQYym6Ya/amYA4MNoE6pi
 wyBDIaJfIKoQmPIo=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x67mn-00021A-U4 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:35:59 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49e66390995so10887475e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 07:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789396551; x=1790001351; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BVBu4qXXXvc7B7p69GCjCQsodvuP+o2wGov855W2Sac=;
 b=UNkE4IcC01xUE9YGH8UHZiMdDrN/JmyEJTsA7fIXs+mNXjfAos9NeuirJeLRld5HT7
 PeBIfVBFmrfgjKTUcU0CFRM9Bo8A3FePoOSXEKKdInohV+jsHKKIEgNZU2gKBrbpWelT
 cY2x6gEwNAq15IajAzequ1pZO//6h8B9b0fYIcpZniOl4eiBWpG5irHQsgXB6Bt/usLU
 /jm9jLyNUBOjDFQjHa1aS6E2oehCEW9495ApF6YeaqN9737sRMJcjUKrN9Qo7x5hJrmc
 q0X6AktQB3bZRzb3Kl2HONLDblfRDFaJs6mQTr+Uxh4PBw77LToh4j5XazeTvk0oitHj
 cB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789396551; x=1790001351;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BVBu4qXXXvc7B7p69GCjCQsodvuP+o2wGov855W2Sac=;
 b=F+x05qRR56t8jIDfFu+UxKDR8p0O24/J0eb/sEFicupjzRAPaRq5Dz2SZ8XpVtajgR
 hUOMQc1pjY3Nyf3Wtn9K/1VjQSiK1EYIb0TnIxLvcWFkDv6KlePsFkcTdExVXO5ufrrp
 WbBcBgn+F0IkFYmBqVpEJLg50/ApMD5ShZ9Dezal+n4Ae6cIUpeJIL/6lFNHKbkA/ow/
 mf4/REgday3xAr2nQRA6YkY/dHC5sAESUASF9ym01MZVghR8qMShcZmWV0KvSNHlkcLB
 7gMUnnUUmSUwl+3D8TSRqh+xyvChmEKliansgLNA02PF8YBchomJu9tAdqNl/OZ0uleV
 Pr1Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxC9k9YiJUivLPCLtj1GgF+6+DxwoiBwJqgNsruho1gOivvV/N9m8+CfUKgISuTPR+INcPUE7iA/MLpLvsQ@lists.sourceforge.net
X-Gm-Message-State: AFuF++ncmNEmwIjZ3Ls8c8UdsUZT53YP8+hAdJ1t446xd4RlX4jqK4iH
 AUy87e7j7TgsFWQWfD5VZTt1ey7qDgpbhADxAOjD5ZMbPEUHXFHmaCuO1kIvteK/nmBxnGroGCt
 7JRmF3S49Nvacp4okwb2IXA9LYu72CpYE7hQeEGaapM/9wuGH2en4tOUkDUxzT+EHtgg4
X-Gm-Gg: AYBFou3p86GJISELLtB56KLsxq9w4Lh+4Mr4ec0wLFwrXJoNjacgqG6aS2+FFoV1+2M
 CzuEYh3rAy9aZQXZEjq9HzFT5xpJotLkHVt/1ZGaa6CfG+cmReoPIkLKqPWVA2xgGzgyOc70DgP
 8AKex0tZg93YbZ+U+YUBpoxaQOpnP6G3jRZTZeY4gVECyqP+VouglhoYT9xHDl4/tKM3LevKGVe
 wTgrsyo+6kicsPZ3I+hcJDaj+sKt/qKArKf+jbefGaxmGY6aoh6w/f2QuC7/xj4T8tKSD2BVpQA
 erPq5dq7i+qPXCEXv30fTT8kTUf9hDmungp1j9x4q8GbOby8ZG8yuE0idIV9ymY49vGkjAisos1
 Sff6UbmUUQdVT6SaBk2zS0/CnEj39OUm5YzbUmQaAFLeUdxaAvaNrCLxBrnQ55Ry00EiQYmjkBR
 9WtzPWL4zUL5Nw3MIYJ1nr+2M9C73cJ8MQTUcbz/vurDXf989LH1TpmniU9zC8SiN/UdqYe5+LH
 g6vXp25YVewRHferCdKpDMrKz4ea5MYRy5KdhwsYtEQnzhlToL/LOD5JFltFl6WlNJ6dnoI+v7q
 kBE2UJR7i7DiJqZ2anpuR9pZHnelXO6X64mhZH9au/IyXFDehjZviityrer/cw==
X-Received: by 2002:a05:600c:3acd:b0:49e:6838:c813 with SMTP id
 5b1f17b1804b1-49e7a67cab1mr29990885e9.33.1789396551172; 
 Mon, 14 Sep 2026 07:35:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c2985dsm679851685e9.6.2026.09.14.07.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:35:50 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 14 Sep 2026 14:35:48 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 22
X-Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
X-Gerrit-Change-Number: 1747
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1747?usp=email>
X-Gerrit-Commit: 0e4f26ec62f719eb61db55882e367f47586a8483
X-Gerrit-Comment-Date: Mon, 14 Sep 2026 14:35:48 +0000
In-Reply-To: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
References: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1YTdlOWUxM2I5Zjk1NDhiN2ZmNzE3ZGFhZTJiNGE5Y2RlM2MwNmYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fd68381c53d6bb36668234bb14dfb2ec1fb2e97a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x67mn-00021A-U4
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add
 --server-probe to order client remotes by probe
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8214012239273867046=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8214012239273867046==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="C9/hhDyoq0A="; charset=UTF-8

--C9/hhDyoq0A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

ralf_lici has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1747?usp=3Demail )

Change subject: oob: Add --server-probe to or=
der client remotes by probe
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 22: Code-Review+1


-- 
To view, visit http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
Gerrit=
-Change-Number: 1747
Gerrit-PatchSet: 22
Gerrit-Owner: stipa <lstipakov@gma=
il=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Re=
viewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comme=
nt-Date: Mon, 14 Sep 2026 14:35:48 +0000
Gerrit-HasComments: No
Gerrit-Has-=
Labels: Yes

--C9/hhDyoq0A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 22:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail">change 1747</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5a7e9e13=
b9f9548b7ff717daae2b4a9cde3c06f2 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1747 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gma=
il=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Comment-Date: Mon, 14 Sep 2026 14:35:48 +0000 </div>
<di=
v style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displ=
ay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--C9/hhDyoq0A=--


--===============8214012239273867046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8214012239273867046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8214012239273867046==--

