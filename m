Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86D5606A89B
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 18:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NlRcUap5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Oo7cWWXv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=in3MYMb0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HnNEmRgQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=1ic4ArybgwQiPC96pSsbZJl9YjJVYfbjEIZXHxbUHC0=; b=NlRcUap5E2xT7PDf/2ToLam/vb
	SucfI4Kv+jwllKY8hirYslPldng8B1FCL+Vsg39F5pffrwfPS8FOvLIszkTbupDQ2ZMCTOLIPhjuA
	jTsiJxmugs/WbROptDboD2cSS83JzxzUsVzOgk6jZWwabT4zNe3qxafxK9IsxI3E665Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRCtB-000000001xY-19jz;
	Wed, 11 Nov 2026 18:17:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRCtA-000000001xQ-0gC8
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 18:17:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h4fOjHgcuLhW2j9r3Sw4JNcHT4MljPI/LWtkweYTGq0=; b=Oo7cWWXvIfFokV6do2rhDx72NF
 yX7tisLVPCDE3jHBHIEZyeDJYrW4YTFFToBHAJVjj4QnRKDgQaABBxMiUvJe2btc5YXmiZX90Qrue
 XzX3cQI6CLF4IpAIznsqcfWIBK/twJ5GFusG8PG7DcsHyYHOc8lsgtquh/2Rmr1X2zZM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h4fOjHgcuLhW2j9r3Sw4JNcHT4MljPI/LWtkweYTGq0=; b=in3MYMb0RDR2yZOKqGkI6UkHoQ
 Zi9FA03Q07T3WW6Ym7KikPndACwZ9ownr/wzpzgygahb4xo2VsunE3wVA8S0Ar2A6j0yrSCe97i5i
 CcOCTKCxf1RACloBWUXzW6aoREW7Y5CXs+kfvrKtimRFUnjVvdilC99kHYBKGbWKVZbs=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRCt8-000000007hD-3KVP for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 18:17:40 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso23909425e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 10:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794421052; x=1795025852; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=h4fOjHgcuLhW2j9r3Sw4JNcHT4MljPI/LWtkweYTGq0=;
 b=HnNEmRgQXUV3fGitDl2RA/9bno3ZfJuRaQpyALiLXyrmwkCk0mVJbuhZS/I9/FQwjA
 TwBXc21ASF6U9f4RMiCgIbtpX5SPZvFlODih7HVH972d/q6289naofbeEmewSTYYOJ+d
 0/jZUMLN3WV9RysgX+u2+YkZO/Oxp+XD7WXf+ghNDJci3Qqt6Za2qUwdrc1VbDt2u1e8
 E/fLUGgg/iYKVGD4JdxNznrElTBS6AcflxrpCNBJAgEacV+GNhkV9FeofVAwu//inwGe
 cdhu6G55lhZLJsxcoojUDXdGhVedtnx4Wi2mwYdjQIawB0kPi09J3DVCvbAtOToa11j0
 LiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794421052; x=1795025852;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=h4fOjHgcuLhW2j9r3Sw4JNcHT4MljPI/LWtkweYTGq0=;
 b=Oq35tFxXrI/ysX2vsIu9RM0slE5WnKSh3sx6xLcsG1p6ww4zZz1HvmogWdTimTP/Rb
 2Sxzq823CNMI0NrIgzLNBnghjVLJeAZBoNQIQ0bXyxaMrkCFYKzlY7/YFtaO6z0qzLsI
 r4+dlpJ7WquJJ8kOWNsp3SmqLEHemzJUEpTlL+qPpdHnVfrpJuYxz6S0TtVrDAHeyCKV
 6DyJ5SGfKH0lVYsRuGkhaFegl3sfEg+HJi0i6ceXbU4s5V5itKyNzMRkAAA3C8aUNWKR
 o7g3PTjELwu6ma62rlbg1It6NVLdsfu6LShsvg6DAZ7r80fLzEfws/fwl62kAFILtSDr
 CJgQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHcoxWIO3bGvgzxXnkD7xDxejZ5xdadZpUqhdGCR3HB6TQ/ZkFk82WEKvRilcV9FzEeL9AQWpgNlfySwd7x@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/T+gD5ZfhjYpnc681yDSOMdtv7OhJiaUbawfwa56sMaeP22Xfa
 PaLsEaN7u4M8ZdnvV8KC5pMfe5FIljxIXmWN8pKW/0QVQvIaw/fvlJ9rTza3fAa2qin9AMgzJ0P
 g2rP470G21kf+aSU23FKJqxY1KoX/BQZytKz+LP44L6S9Dxo7XzRYzOgki9OqsfcLFB9B
X-Gm-Gg: AYBFou2A463Lkn+2d5HClnUZc9UT8CLoqJMKHxUIZF2FJUsCQl+S9+al+ZBmAZbIJcH
 ZFlVKKOe80l3Wm4rZA4f58kiQybgCDEsLVJyMUPkXNDQUNdLtrP9S5366KH49enjhG3AmUlG22Q
 wI/uQDk8DNfaS5hQz7EQAMvP5nqIVg9+Kg6mxK6LM3nct/Wi6GMXT0yk6Cw41NSRcW251q+i2d0
 y55J4zu8cJfkEkI0ewjSQu6bYLmQM0v7XltBKD1eS2e3qxWCpBkneFQ/AYCfkRUDIYgVOaH3RyF
 OW6CRJWR9OCui3O6DVeT/2AEd2klmsD9lIO8WA0W+qSv/GijvbPxY4A/4wB2R8Dgva8VqkX79QI
 lWlt8KMXHiIJ80/0Ky/IdUSU4Soa49PHm1kSLajp6dj/DGoMgObbjQbqWjdzBOa+oEM++pdAolA
 ab9NGLWP7OMYQoLNBHh5kJPC4jOBsoHyb+3553RrmZkyXzwvCWf1qDXFi1+mzk4rNDX3lK6k2dZ
 0k6YnZByLwUQw1vvw2l2+OZUfCjdvCErjpxbYpnPIVYE4BdFrPu3GJk94eYShQSDLpKyRhyqahP
 pkFcJ5PZ+lQxX7oVJvJ7BV07D4fdTeFNosLYVOufCFRA2u3skrLNLRplqk9vfHlpcLnISMWW+ZF
 qTwgPL4svBnZZ7K6hfLl1nMmyXe1IkMYurKI2VKoi1ZyG+dW0RvrCWN4RVSUvUEReED74fNBOIE
 EnQqkusgeKwBkZjQc=
X-Received: by 2002:a05:600c:470a:b0:4ac:86c9:b09c with SMTP id
 5b1f17b1804b1-4ba0936e8efmr60950645e9.13.1794421052112; 
 Wed, 11 Nov 2026 10:17:32 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba08ddbe68sm126158375e9.0.2026.11.11.10.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 10:17:31 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 18:17:30 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie7228ee95c2b43f9be2bf4c6a9a959af2f729088
X-Gerrit-Change-Number: 2176
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2176?usp=email>
X-Gerrit-Commit: 06f245d36aadd447111cf3c431d60625678e967d
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 18:17:30 +0000
In-Reply-To: <gerrit.1794417322000.Ie7228ee95c2b43f9be2bf4c6a9a959af2f729088@gerrit.openvpn.net>
References: <gerrit.1794417322000.Ie7228ee95c2b43f9be2bf4c6a9a959af2f729088@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDE3MzIyMDAwLkllNzIyOGVlOTVjMmI0M2Y5YmUyYmY0YzZhOWE5NTlhZjJmNzI5MDg4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <07f2cadb8ac6374306089a5f92bb5679a6921e7e-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRCt8-000000007hD-3KVP
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tun: Make
 error_flags unsigned consistently
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5704786790942059957=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5704786790942059957==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UJwqQFWlkvY="; charset=UTF-8

--UJwqQFWlkvY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2176?usp=3Demail )

Change=
 subject: tun: Make error_flags unsigned consistently
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2176?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie7228ee95c2b43f9be2bf4c=
6a9a959af2f729088
Gerrit-Change-Number: 2176
Gerrit-PatchSet: 1
Gerrit-Owne=
r: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Dat=
e: Wed, 11 Nov 2026 18:17:30 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels=
: Yes

--UJwqQFWlkvY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2176?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2176?usp=
=3Demail">change 2176</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2176?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ie7228ee95c2b43f9be2bf4c6a9a959af2f729088 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2176 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Wed, 11 Nov 2026 18:17:30 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--UJwqQFWlkvY=--


--===============5704786790942059957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5704786790942059957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5704786790942059957==--

