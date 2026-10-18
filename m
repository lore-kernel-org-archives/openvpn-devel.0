Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FA9CCA490
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 11:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nyZXBbdiXHLlzRzKoL48mXTuk9CvEiJ+n5ssBYLuJ6Y=; b=iSJQMtAqbs4S16HN16vgTxHD5w
	VEclQQa9AhRbdeDExngEg1LA+Llov1pTJ/UvwcssVTduEuXqEmKGlm5NbGRI9CPt0uGsecbbTS4V2
	7XMJWKRK7LcHPGITC3q8ZyA85UkXsd0yDxQMfV5Rrz4q9OtYabneK6iDYtt87RNR0FIQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIP8W-0001eD-4l;
	Sun, 18 Oct 2026 11:33:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIP8U-0001e1-W9
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 11:33:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=nja49VScX65ynJ+BVk0AJPq2izQPiQtg7p1o1MxDuQ8=; b=mBPeJFASN/upzp6i+swwBO8WMT
 sJ0uyIpiaPpCwDxIsUNbLE5rjBd632Urpp3xQcm5l4hoLuqzKw2MeVm5boURAgRDbd1eHkNx1ToU3
 7f/Olzdx/SIGSWpSZJVl0stsubtXKfSoa5Pr97I3G6pD0Jc9yjSVtrLN86FRqiusMWxs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nja49VScX65ynJ+BVk0AJPq2izQPiQtg7p1o1MxDuQ8=; b=A
 zPnfHwC4u+NNArksiaqscyTX7k477a8flkKgBIkNdyGmyRHLO2apYqWiw2TJ9GBBTJxLe0NZM8Q+n
 1GMEEAQ3mRuJ4IeUQnf8A6LIDmJgAjnp7xWvHeTSuZSp2xWPWuUap3EDCCaFfhRJkmbwWcSHwMEL6
 cg/CcjPLQGVjzHIs=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIP8V-0002nP-01 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 11:33:07 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a1dede3c2cso10410205e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 04:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792323180; x=1792927980; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nja49VScX65ynJ+BVk0AJPq2izQPiQtg7p1o1MxDuQ8=;
 b=cQQQMtT2vnzJCP0k6vYi4KdcdunwVGbUTMEXIXSC4vvLdjyxrZjINJxZcjHHjDTaZH
 4/iW+GahO+BDBlCvl/klf6hBAJvrYx0QL09L1IKEOx1Y//ZmrKQB8i60nrSpgY9z0NPs
 YIe/IVViIF3bjwtlPYFOyVUS66uEwKQKUTW3WmOk+6bdBXdIYpX/RgP2GhOo2TliedaN
 UGnlc6dCe4xR60e8RaFHlIoqrIe/tijPQmSe+woybgwrB4Gyh58WhtdUBUsJcg6eyz9k
 cZjCbWIYht3dOl8Bzktp+3vaQmHlK3PFOO0xUUL98sxdUbSIEZV0s+rL5jwIZeCzvT+2
 /KPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792323180; x=1792927980;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nja49VScX65ynJ+BVk0AJPq2izQPiQtg7p1o1MxDuQ8=;
 b=1ftdcah8LOrRVXvQrHgbKlJ6mlozukvx2bM0giUxaXoPT/YyhAQkFOdVY9rL+VvCqW
 t4jRAS7JH651NZoJ8YI49XrEi1LSNzOR0bqhnUIpw+w5tKcdH1weT5uyikEnIw1O+jrb
 KoUZhmC/M0u0Ry9yo4QyZ8bTh4ORVh7a6MFlI4BvUaeGL49//ypRGDa26y4ExYUWnr+M
 JkzIHqlhKYjfq8ZPfl52WwWhgC88D79RuX33X9/o5/IZGhebjOOzSaw6cjUmiuVjzszN
 iJUjwKF+xKiOq0/Ce/pbdl0nPHbckLQJc/w+FkaiT7qZM9YK7lSci7fx2D6D1q2VAx7O
 cGhg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSGQMDNh54uxz0tIgmSZzt6nZGF9Jrbe0uK261Yrn7M/Xw38c2+gHDKhPWy7e7fdsPIgg+7chlHC7Ez94g@lists.sourceforge.net
X-Gm-Message-State: AFq9FYI973KLqldhteZSh3RN0SQ3PFdoeiKhROWXVnq6E2KrO4oFhTDN
 0KJH7k9+c/IKBSWsffroRWFnOdgmdYbaQKFFVgEkpAGJRdsufAq8BjAqlo0WZWc/HDk5K5TF8Cv
 qiQO1W1W2mUbZWFVhwBzKcntgvPvLD0Gt3zWCVDYl7dO2x0CBbImy7JtuutdaQUS+E6sx
X-Gm-Gg: AYBFou2RcF2DmBasc0dyeL5NlFzkm2smGQNljkhIIVkrQhTcpGP5NRqiM6l+Ysv1qXc
 TEEfZ7eKEFOEX8DD1iqYs/g2eRSaF0qQTGo/YEFuRmZtThsqgw/oRt/6Wa0zupW+CwYOoQTAV7/
 Ae6eEESYIu8Ha4vV/a9JZ6C4HWAIQA4Yc3enzUX3gYAmB7Lq70aJ/z3Qub7vom1gYeLUXXOgLaP
 HM2B8LaSDxVmYL93iGgshwuw3Aht8i01eMGRorU1aQSk2+bFq8YlcZCr6y8x7daIet96v0E51xI
 RPmT1FoZwTd7zXjYhNZteUmMDryECX/jz61peh7oIJvquk3ydbvDO4H48K4GB5X2dYzMKzFS8cl
 +4YxiuJNT7ENRa3hHYGkMJTXmqu3kAMd37L8nB9vIJRUownrK0BDCFE6Pwi5ehCl02fXoKqnLX8
 D98qs/mWIFhFu4G64HGA/l1cr3seBt7hwxLvQK8baanM1f+pRF5y7zNZim3XngqfuYhyeG3Hwne
 J27Qr3rVq+zrICCJcfy9V5Zs1rjgwg1egKKcIZI/r9mOUIhM/GD4ponWwYdyCVX8VkMCgCxf4Yw
 CfWcADwMlJBVVEBbm8EZDRvtZeNNH7raP67jbv7ZGyA3eYl4WGP6Wg/PoizB
X-Received: by 2002:a05:600c:34d2:b0:4a0:1c10:1372 with SMTP id
 5b1f17b1804b1-4a1d7614d3amr93739925e9.27.1792323179962; 
 Sun, 18 Oct 2026 04:32:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4edea3sm17147498f8f.28.2026.10.18.04.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 04:32:58 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 11:32:56 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I64e0850d48647a2c0e3d385c2f20a9f445931727
X-Gerrit-Change-Number: 1786
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1786?usp=email>
X-Gerrit-Commit: 5255415de686e0056566ac9daf1b536d83ef9667
X-Gerrit-Comment-Date: Sun, 18 Oct 2026 11:32:56 +0000
In-Reply-To: <gerrit.1784067448000.I64e0850d48647a2c0e3d385c2f20a9f445931727@gerrit.openvpn.net>
References: <gerrit.1784067448000.I64e0850d48647a2c0e3d385c2f20a9f445931727@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLkk2NGUwODUwZDQ4NjQ3YTJjMGUzZDM4NWMyZjIwYTlmNDQ1OTMxNzI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ee29692ff4d2928d36c1a66bd322b8c4496cdfa1-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIP8V-0002nP-01
Subject: [Openvpn-devel] [L] Change in openvpn[master]: multi: assign IPv6
 addresses from a tagged subnet-pool
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
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8580775189541062732=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8580775189541062732==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="o7EYknAJeh4="; charset=UTF-8

--o7EYknAJeh4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Antonio Quartulli ha=
s posted comments on this change by Antonio Quartulli=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail )

Change subject: multi: ass=
ign IPv6 addresses from a tagged subnet-pool
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 7:

PS7: cppcheck cleanup only, =
no functional change=2E

- options=2Ec: the --subnet-pool-ipv6 prefix-lengt=
h error message used %d for the unsigned netbits; now %u (invalidPrintfArgT=
ype_sint)=2E
- multi=2Ec: multi_get_group_pool() picked the pool tag with "=
d4 ? d4->tag : d6->tag", safe only because of the preceding ASSERT(d4 || d6=
), which cppcheck does not model (nullPointerRedundantCheck); the tag is no=
w chosen with an explicit NULL check and asserted=2E
- test_subnet_pool=2Ec=
: one pair of pool definitions per scenario in the IPv6 test, as in 1783 (r=
edundantAssignment)=2E

With this, "make cppcheck CPPCHECK_CHECK_LEVEL=3Dno=
rmal" reports no new findings for any patch of the series compared to maste=
r=2E


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1786?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Ge=
rrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I64e0850d4864=
7a2c0e3d385c2f20a9f445931727
Gerrit-Change-Number: 1786
Gerrit-PatchSet: 7
=
Gerrit-Owner: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Sun, 18 Oct 2026 11:32:56 +0000
Ger=
rit-HasComments: No
Gerrit-Has-Labels: No

--o7EYknAJeh4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Antonio Quartulli has posted =
comments on this change by Antonio Quartulli=2E</p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">PS7: cppcheck cleanup o=
nly, no functional change=2E</p><ul class=3D"blocks"><li>options=2Ec: the -=
-subnet-pool-ipv6 prefix-length error message used %d for the unsigned netb=
its; now %u (invalidPrintfArgType_sint)=2E</li><li>multi=2Ec: multi_get_gro=
up_pool() picked the pool tag with &quot;d4 ? d4-&gt;tag : d6-&gt;tag&quot;=
, safe only because of the preceding ASSERT(d4 || d6), which cppcheck does =
not model (nullPointerRedundantCheck); the tag is now chosen with an explic=
it NULL check and asserted=2E</li><li>test_subnet_pool=2Ec: one pair of poo=
l definitions per scenario in the IPv6 test, as in 1783 (redundantAssignmen=
t)=2E</li></ul><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">With this, &quot;make cppcheck CPPCHECK_CHECK_LEVEL=3Dnorma=
l&quot; reports no new findings for any patch of the series compared to mas=
ter=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=
=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></=
ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1786?usp=3Demail">change 1786</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1786?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comm=
ent </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: I64e0850d48647a2c0e3d385c2f20a9f445931727 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 1786 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> G=
errit-Owner: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 18 Oct 2026 1=
1:32:56 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </=
div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></ht=
ml>
--o7EYknAJeh4=--


--===============8580775189541062732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8580775189541062732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8580775189541062732==--

