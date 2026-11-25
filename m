Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37DC606A321
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 20:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fHIZVzWV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YxmowJdo;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lNFbZiR4;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=aqoaraGJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=+T1Hb7Dvw/SEfPpc5pYuy522t/e1EfbDGluGpgp17o4=; b=fHIZVzWVzvqfgjlXsSeVZ1Mavw
	RPzr0um3AyrxjVO6chyQkjkiJmBS1iy9OT3OjNGcfsKEOQuEd+iqcAScV86vGuygSZjD2SdTTi8o4
	M5qMh4PfECyeoX/Ai6IcJPGIjBzYOLeoLPUqKH3adnhmM6hr3DbtoTRmj9KUFmS5sazw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWJL9-000000004Ah-08tp;
	Wed, 25 Nov 2026 20:11:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWJL6-000000004Aa-3T6V
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 20:11:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pZidrjPY3wEv5Q5Y93WCTntDyioIN5YdtR12XYVt1EU=; b=YxmowJdoylIDamglU+QGuoK8BN
 somFtvPHn1W0TYrcoeb29B4YLha9V3xRw4zZmNibZTWvKOwZpZkU3hjTaRE1ErmRcV8XRIdc/w10b
 cL2CVdZASnjCspk69bIaLDeTT0aeEodBMpov/hjJFhope5XgUdAB6rSAvwzEeS9FrE6w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pZidrjPY3wEv5Q5Y93WCTntDyioIN5YdtR12XYVt1EU=; b=lNFbZiR4cLG5H4hHH6MrEJpZMs
 LWm6QzNt+f1zszm8fLnZP9GNDVvReZJKReiFBck6PynwikbdN7uTlgGxS8H83lt4lNVjb793zKplE
 Jrbwa8s76f2WwXWmm7v1FXVvDEB3S2G80BXa+edB5a1NwLmDFXeyZbvBJBNRYvRJyxiU=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWJL5-000000003d0-1Jnd for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 20:11:36 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4bb666304fdso63643455e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 12:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795637489; x=1796242289; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pZidrjPY3wEv5Q5Y93WCTntDyioIN5YdtR12XYVt1EU=;
 b=aqoaraGJz3W8Q7offo2kvwb/JrKW1GFm3l3ch0UOxo4bjgKAhgTm8t76WgFN5qP7fj
 lBhUCeWIe98LXfLR+HkRsY1F0Nrped2L7BMPY1hUJvUvdL1p0OK1quUjyRmMJgqnNle7
 3xGGnlTBz+uZCl7YvNB5dX95XQWKjpj8ePMQJ7U1qbu7pxoSWHi4uUdravVeZpyHerC3
 MDIIZ9kc+bQrdzoRSn5HUI2fHvGG4Btl+O7RYRb34o4pU/+aHwHjrAkJeazjEvZViYGK
 WYYuVks5Lw0nMAj15mxa7IWTf4cPlLjub31HaHpgge1bvXny3mcnbP7OBZhOcB3WWu8Y
 DP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795637489; x=1796242289;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pZidrjPY3wEv5Q5Y93WCTntDyioIN5YdtR12XYVt1EU=;
 b=PYN7ub+WSFS6qN9v74j5BKYLXL1Wx+KOiV9j9uP1rJnzeMCzt0wXVAZgnVnqEIecVC
 VYLRZOtFdz2KIoD1+dw53JyB53UcR35EHHXAmUhZB1WIskDenn9qkZweI6epOWFISnMb
 Tw1i2zA/tVORVsYRbOkU/ayGyDMNX+KdOumeFvnqxTAjMYM/Yw8ZbALqofSbm6mOWz//
 FRzRvz9QF/mT7y1zLJoYuxYbW+J7MsB9ZmvudX3WegUbty/n3Pst8CHWHYDxT+ZUjD09
 MKhC0/B6cr2gE0erYB4K+YZCwwaIC7G5ZfOGPpy6OvOXLkX58pFsxotV8nA8gWDn2g59
 5WAQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGXXu4ZeSzz8BecipWE34yUL3nGhHcFdcDiDr791t41pNoyo/EawWzwSEhUCt04jVNS3pvXXevAOJuHMlfh@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+CsQUc+r+qDt2P5XKBCmUTWDE4vsbIlYQfzcUkjVL/89zuT6Tt
 n+Dh0E7u2w9BfHaEdsGf878IvRgn1AAROfRBjMLVzv6v8/DUY82nFAhD4t5HSg+Pv4PLo/hl1sx
 NgHrvUXP24yfRXDxhso4S8D2qbh+1sjwNIsMTwnJ3vVnlOahkH3ypYUT9NcioHv7Itpul
X-Gm-Gg: AZFdTZfKundvmE1hWPlLYS1j+K25yEwz7NhClPmO/6jc1q4y2XpdwwZXJzn6vRTA0Mc
 O/RkflVocwflnlYdwOJ5AcGa0zBvhQ++2+TI4Fqo+hk3orScX+aQM2M6K+0m1szEYk7IPV8OK6B
 2Ft70xpSUO37zXHYddyA8yEj7c9FxhnvXfBqEAl4m2kjsQKg93KXvggsNSQa+f96tgZZR9jdLHR
 w7/v2857IIjOmdZa4P3PfqGaToxvRg+VB5vR+32rb8eABiBzfH6SeaAAfuMwmd6IG3iAr2/pGws
 g3hirqqfqyD2Hs7vB7CzFk50LksodJr4Ltvnjgq5YofstGzm3vqTuhLBKualGeMdDWgRukQA0al
 Sv2K8Bcb9gOijTLSQdaCGsMf8sW0cBRss9U4dnFUaxhpJOpxQnrDXM++vGsCX0zX2M5dAbv8wXd
 Ncijy9lmYRJHkHBlaBbjVhjTmndrJCr2+6sKIl9wIo+1oxkK6JYd0PIUTyVYfAxfo7003450mmB
 IdNafHbs/h/cVE87yGNvDMWywExoYfQHbjwPJ4wIRHWiOeDPdDRTkXGWoYFPpb82gLK0Xh+HZUe
 D9vaUfEK4Yjf3MBMbOy7wMlqgA88Nd8XCBXVFwSPFnYv6JHncT/0pYINtRXyd0ojEKW2AmBH2Ux
 rr2YEM4L8vj8crXyBqLwjeX8yVpilcdZ15JQ4aeccZ1fjH7ezX1uqcrLTUfHoBgSr+2hkIbNfph
 Xyk1lHDpbyHKNQrtxc
X-Received: by 2002:a05:600c:37c6:b0:4a1:88df:8a2a with SMTP id
 5b1f17b1804b1-4bb88812a84mr379670915e9.13.1795637488417; 
 Wed, 25 Nov 2026 12:11:28 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b2c5sm536323645e9.5.2026.11.25.12.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 12:11:28 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 20:11:26 +0000
To: Deri Haerudi <abcderyscreenprinting@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Id05f3e4e32aeb806d762858e754adc82f42d4371
X-Gerrit-Change-Number: 2341
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2341?usp=email>
X-Gerrit-Commit: cafe4eab2d6f519bde8d4ebef000ab02a8e66006
X-Gerrit-Comment-Date: Wed, 25 Nov 2026 20:11:26 +0000
In-Reply-To: <gerrit.1795562472000.Id05f3e4e32aeb806d762858e754adc82f42d4371@gerrit.openvpn.net>
References: <gerrit.1795562472000.Id05f3e4e32aeb806d762858e754adc82f42d4371@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTYyNDcyMDAwLklkMDVmM2U0ZTMyYWViODA2ZDc2Mjg1OGU3NTRhZGM4MmY0MmQ0MzcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1bf7e7041c8c1bd199505a6079704a24501d4fff-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWJL5-000000003d0-1Jnd
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dns-scripts: parse
 dns_vars_file as data instead of sourcing it
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@ist.eigentlich.net, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net,
 abcderyscreenprinting@gmail.com
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6888358809064339135=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6888358809064339135==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JqfQg6AiGZc="; charset=UTF-8

--JqfQg6AiGZc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Deri Haerudi=2E

Heiko =
Hund has posted comments on this change by Deri Haerudi=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail )

Change subject: dns-script=
s: parse dns_vars_file as data instead of sourcing it
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(1 comment)

Patchs=
et:

PS3: 
I actually have a patch in the queue that removes use of the tmp=
 file and passes the vars over the pipe directly and then passed in the env=
 to the scripts=2E Think that's the better approach to this issue, than rel=
ying on the relatively complex parsing working in all scripts for all time=
=2E Will push my stuff tonight, please take a look=2E



-- 
To view, visit=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: Id05f3e4e32aeb806d762858e754adc82f42d4=
371
Gerrit-Change-Number: 2341
Gerrit-PatchSet: 3
Gerrit-Owner: Deri Haerud=
i <abcderyscreenprinting@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbo=
x=2Eorg>
Gerrit-CC: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-CC: op=
envpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Der=
i Haerudi <abcderyscreenprinting@gmail=2Ecom>
Gerrit-Attention: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 25 Nov 2026 20:11:=
26 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--JqfQg6AiGZc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Deri Haerudi=2E </p>
<p>Heiko Hund has =
posted comments on this change by Deri Haerudi=2E</p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?tab=3Dc=
omments&amp;usp=3Demail">Patch Set #3:</a> </p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">I actually have a patch in =
the queue that removes use of the tmp file and passes the vars over the pip=
e directly and then passed in the env to the scripts=2E Think that&#39;s th=
e better approach to this issue, than relying on the relatively complex par=
sing working in all scripts for all time=2E Will push my stuff tonight, ple=
ase take a look=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail">change 2341</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div items=
cope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id05f3e4e=
32aeb806d762858e754adc82f42d4371 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 2341 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3=
 </div>
<div style=3D"display:none"> Gerrit-Owner: Deri Haerudi &lt;abcdery=
screenprinting@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Heiko Hund &lt;h=
eiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: Deri Haerudi &lt;abcderyscreen=
printing@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Comment-Date: Wed, 25 Nov 2026 20:11:26 +0000 </div>
<d=
iv style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"dis=
play:none"> Gerrit-Has-Labels: No </div>

</body></html>
--JqfQg6AiGZc=--


--===============6888358809064339135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6888358809064339135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6888358809064339135==--

