Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2289DCC6B34
	for <openvpn-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5J1YRcZs9Mcy75TkFPSkXUKiKpi/6iZCuVrLdfVzO5c=; b=kO7LofFh5pd48PVCeuDMb8cTSY
	A9ryhuMmdtZS3uZUDK6ts0WIvdNiQcbuI1VttgBgIugFLs3z5vK+Co8+wadFCTeEKfu3kAgovWpJr
	DiHNJyVel0i55Az5mGpKtMaHaZjl2ZRgNqUToGlCw/YzyZ9r3u2NVEBN4GoMggdvcZgQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHJZU-0008WG-0C;
	Thu, 15 Oct 2026 11:24:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHJZT-0008W5-7D
 for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 11:24:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=XjSc0vdxZoG2Za3/rGKNSqQvbNvhOAMYQTNPz7dIi68=; b=LdCaT/BNcYSP0yPSlbMOyFXKYP
 MqZlsJiKLAE1MqGT7jARlDDWwAHT8IFMmRVuhvOpZrICPm4/azYj97zVFYpg353oop7/R0qTStRQI
 dTMHR5XBTuoQ0wH4LBsCYN19TqIqcb/64uwXaN954fN3MTF1RDAuA0GUnploodfEJaLY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XjSc0vdxZoG2Za3/rGKNSqQvbNvhOAMYQTNPz7dIi68=; b=N
 1NnJwAHMgfT1ZoLpLRE4mRzKypxXhj7Rf/e+U6FUZfehROfhJozt/1kjpGfCLHMzIYEQ4FulyOMco
 gkFjAR+dEppj/0ENfluclZ6qyb/jLq/njN1byVb6QLaY+RBgVYZ50ipsg7jnrLXZg09Upnwa1wmMr
 SEuxV0A6Ygm79ckU=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHJZR-0006iD-Py for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 11:24:27 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a0213948d3so31627355e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 04:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792063459; x=1792668259; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XjSc0vdxZoG2Za3/rGKNSqQvbNvhOAMYQTNPz7dIi68=;
 b=dUB5MQeM/WkguBUprmnA7sSGdwxLO0OBqnb40qSlNkcHTbBCmNVRhD4F4eshxDwD7E
 cjCAhaFXTfJBLyioVs/eE++VDrCIAjeTQzDSQfBi+jBuYR1LyWYo5SMJrqMBvJJ/Hzks
 HR+/1BBMg1Um3ohMmqdSecplU3k/7rVBNnoGD90bsI4kCZCX9aqsXpWBjiePOxBRicvr
 Vg3LDf6pU5d1p7Ip49rN9o0w1rRGcA4eo4zdRfABDjQtvJbaakpinmPFCncM17Q0blMF
 82xfZeS2fmiyyGT53KnZ8FBP1tH04JSoLzCmfdrwj383owuZ1cG5HILifRJOepx2WJd1
 iDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792063459; x=1792668259;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XjSc0vdxZoG2Za3/rGKNSqQvbNvhOAMYQTNPz7dIi68=;
 b=RQ+EYYfSM6JyyVJX26S0fpFnKVIXDcZnETWZHWcxVPNmXuY7CI8J+ijjarTKCkqotL
 kSo0p2z/gCE2idhF6FemazBCbC5VMeSx/0VPVeFi5TpFWZl51ZYgfwgAqnklczyEi2UK
 URxpmbzyOzR3/5qJyh/0kIeSyDiqUC2WVU6ko9b3aFYv51GOOLM9i5lQCfEhKXxFK8lI
 W13omQ9DGS7NLw/zPTFpupRo4u7+ZI/aKmisZuVtpFvhXGYQvzJH0TH4XHC/rP1Z0Iw+
 9aLKztXgbGhRNebMfSIOsRAEGSDKAHNTXM84KaMscfUTjA4TUYk0TSwfnv2Dy2h8xALS
 Idhw==
X-Forwarded-Encrypted: i=1;
 AKwUvBznaan+HahKJtq6Kh3Mh338u2i0fxP1UJ6kAkJsvGeL7YfWk+THAFj/H0tOBc8nZ7bnNokopDf3svSKUdN9@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJE0cxhGcQ7JEQpXfManc166VTMoA065ZgpODfRMLZEaRiIQ8I/
 osBSLcSI0A5V5M+2tMfpwolwNGRcNEdNmUn7nImZeoGzYuW/N/ISZxdvcCGemylmJnr4j3hSAvM
 ed02eHbsNeq2nWfGXZvGh1ak5HH0s4fYQ8bPKdQqOaZ9DxxRd1Xk4tnGDyBNyDlyUkO91
X-Gm-Gg: AYBFou0VgsS/c0ZQXDI3upG06/1vJ63/yS4fK8WYClggmwPvWHmImtgZk8zsEZu9H1D
 xoKUYsTHr1Lqq1Az0hfKxtTJiBSGaGm1zfSXBgMTrRSS6XCS8YJnge0FPsxcjY6wj6ZgYdAfKgU
 x3dSaQ1X3HEZ15fnpcNjLZRXlbl8EMAYkdG6VjdhLuSrnfRb2Y8Q6En8vRcRCmExyOgA4bx+FLj
 3wUihnGcaVTAv7oL0Xwpy7k3/r0XBy26sN5pFd1VL2u2ajXGI7eVzq30Nd1RN/u+SfyoZviRFjI
 CB7WytTYjY3bXxdiO7bzoATWWhu8HDA2fYJTIlo0QU+JAdGAPs9g2iMkOAqpLqk5RoTW/ONQQ7Y
 WRZkOb30WYUBFsJf0gPj8G53Q47aAKg3ks7NMETNVtc6e+ZwYgfp9citp3pRrJblmxfdM63R+DN
 MApuj5vRw9U1vnsuVNOuuI2VPXwa59D+zSUeJqiuQPkpiiXd8UafQ6fd8GfhknoGLe2MMBF5o65
 y1WIo4NsanKhsCyZZZP66JcytJ2ozoh+pSXVA8l0K315OSKR4JLLJxP4iSvEqda+cis+GrMJ72A
 8X66a3m5Q5cf9CkBONmIvMZtkxjDDI2SW/ZYeUbP6wiVYtX4EugpXihe3e+m
X-Received: by 2002:a05:600c:8b82:b0:49f:fd2d:23c7 with SMTP id
 5b1f17b1804b1-4a18e4b887amr341315475e9.27.1792063458034; 
 Thu, 15 Oct 2026 04:24:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd9c001dsm60211595e9.12.2026.10.15.04.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 04:24:17 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 15 Oct 2026 11:24:10 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 32
X-Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
X-Gerrit-Change-Number: 1663
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1663?usp=email>
X-Gerrit-Commit: ac97057771001f56bd1c49200febaae4bf0a43ee
X-Gerrit-Comment-Date: Thu, 15 Oct 2026 11:24:10 +0000
In-Reply-To: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
References: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDY4NTAxMDAwLkk1NjI0OGNmNmQxOTljMmRhNzcwNzc0YjhmZDFlNWRhZjJiMTE2ZjU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <84bfaa893baf7a33b721cee0735be5402e45ad71-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHJZR-0006iD-Py
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove instances of
 constParameterPointer cppcheck warnings
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8183152265878076803=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8183152265878076803==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GbjKKmL8R2U="; charset=UTF-8

--GbjKKmL8R2U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail )

Change=
 subject: Remove instances of constParameterPointer cppcheck warnings
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 32: C=
ode-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1663?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: co=
mment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5624=
8cf6d199c2da770774b8fd1e5daf2b116f58
Gerrit-Change-Number: 1663
Gerrit-Patc=
hSet: 32
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-R=
eviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83=
zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-Comment-Date: Thu, 15 Oct 2026 11:24:10 +0000
Gerrit-HasComments: =
No
Gerrit-Has-Labels: Yes

--GbjKKmL8R2U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 32:<span style=3D"border-radius: 3px; display: inline-block; mar=
gin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span><=
/p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demai=
l">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>T=
o view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?us=
p=3Demail">change 1663</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1663?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </d=
iv>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1663 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 32 </div>
<div style=3D"display:none"> Gerrit-O=
wner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Thu, 15 Oct 2026 11:24:10 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--GbjKKmL8R2U=--


--===============8183152265878076803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8183152265878076803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8183152265878076803==--

