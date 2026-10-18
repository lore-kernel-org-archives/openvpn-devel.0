Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A806ACCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 12:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nNLaUOAIc2FDKphqj7qauX/gQpphozBb5jIko8V8o58=; b=ioPsFH92TSdo9MIcAQ9zqEHiK7
	mLeneGZPWd7LTQ5NUM7M/g2oTO5B+B+KXDcFZIK2R6R4pOhGz2ZtuZBEpQ7KrU/Nz89hj6OdxT/iB
	HlG1f/7qzlVlD37YaBFPDYZmaG0vSlyfo75Lfel/9HvU5TC+aQucroEN7ZIZutrGK4Ms=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIPnh-0007dC-TS;
	Sun, 18 Oct 2026 12:15:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIPnh-0007d5-Aj
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 12:15:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=oT5JbugsR6m+NwGotslTiCu1/LER59wuc8uuhrhJdIQ=; b=mYLe+Y11GXF/iG4Qe99m68fwI3
 co6ahJjlFzstET5TBc05unWDGA4JjI7+e29cujz85meW3GYn//RKKnKkWxbZOQESaqpFnAbD5GtIB
 7R5MwXGZIpURK1dGnU+DdvcsLABHwnzVfmvpD5Z00oAGZ9Fpl8mxVLzTYPzY2lifmAtE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=oT5JbugsR6m+NwGotslTiCu1/LER59wuc8uuhrhJdIQ=; b=Z
 hToJE5w916iOlFlLzJ3ToZB1kLII5/xcLWz6TR4j6aLGsTemeRSbrQKh+NZt4nKWqQGWGJvLQm2EC
 Ic6Psw3BZfgA66P6+UjM1ByFA6B+/5026HzsIUEv2mxpODBXK9br60AF6aQN5dUy27+vS6ugDqYPp
 xiVkMmFPuRrDivE8=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIPnh-0005TP-3g for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 12:15:41 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso677358f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 05:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792325734; x=1792930534; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oT5JbugsR6m+NwGotslTiCu1/LER59wuc8uuhrhJdIQ=;
 b=S8woQOk3mBs23xfvOMWBFnY9Y2DQqZsewLWOj1Rt9ncWsutBedGgxwVeFNERz3M7rm
 zmPfck2BvRhGA4QY1TkRxAS82FBaOHvsUn/NVbAo180+VbG2ORbs/5lA3KbPZQeqAhvN
 Ywuw7RIQSbkOyAuWtxgFVRpJWwZYuwW1Zas3NFngkGbeS+OttxjDnl7eGU/vpInGnl9L
 vhb07OdpBaJ29bnJBgHjulOIkKYBEZEl61iRFkZ8UbNg6bWr3/ZGnqjXuGiRcqPcukUH
 w82lI889BYOjhHGmmx5F+ohjENVffkq2iDPBh4IxjTB9fuBmIIU1DgrYPKj6U4p8tsHx
 L+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792325734; x=1792930534;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=oT5JbugsR6m+NwGotslTiCu1/LER59wuc8uuhrhJdIQ=;
 b=kXxAxWalKl/wgEWm6VTgGYT7IFEu3L3DibotMMgWqA8qvj4459FxA7CUxvY/ouLVUL
 FA4pj22fg9CHjEP4lVylsrvXImgUT3nfcgGEjkCjaseLYovSUVBkXJ/ZEAOMdkJ90o5g
 ecqGAYVn7TLpwLvYyvM0exHZsmjyo2RqEvNqhPaYNI0qBzIufYv6/6PmLAGWDGvsp489
 I8b0Q1q7Bf4yz/ljwj2NmyIM2cVA/y1qpyBzpvPggcf/k8X0KrWzA6ZC10JF2Tz8ZUrM
 v09GcKPUZO8SQ42JmiwXb90LcHAQ00SSLcxVq5IaF0uWOsTZHoegUCe60nxIxoLo2rz6
 HTrg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRKCw8WHuko1cwTJNAtM9KRxgNkIYYBnOiTCWs7dgOM7RpFvGIVS3DQ+kEBLRcUSnYcws+m6TEFF4NT6FT@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLiWYdnarpOsdtuU80yiNz0ObSXZbJ+q8CxXmq4jsDL5GXPq/Vw
 BcxCcqSgb/fg7rzr+sYGOCUcDO7PRXzGEJNCuuMzKBUGqwHM34fvGKx46phAnYbP+LQzyUU2Wfh
 LJwOiV7ZADx24bKa2wS9GqsmujDOzFWs5TUeKdd0Aru2JtJk3QbkyREfgsnuX/M4J8EJd
X-Gm-Gg: AYBFou1S7GOT3EqYelIgBgHI+N5aWMV8BjgHAh1EX21V7UOMXnf+qabotjbUxex0oGL
 VzAwdHLrcvskeP5pIINelMEkdSMq2GW1bDwfAnqSC/pDwk2dvXC3mUVw96wU6tE69Fi+7BS4F+S
 uOSSWbOX+MwKeYLcENDa8mRRXNwqkC4cT0h7XEt73g8TtH20oCrVds2ovJWwoHNijSjb7l5n5x8
 KCq+uKLEtzab76TAMnVBrFHSarUkE6hP0uhxljdHxc6nXUyPAje9o9LmFX01l1gLj8qBGxaklKW
 I/d8uMTX2I4qZ1qXBw4vRkYv85Dz77mW59MHZwwke4uptESItGdX0qxJ2rTpMXoT67cJH3nJ7WP
 W6AVC/rNuE9wvqLuMbcbLXJMtVc1PcTDWDxpmvfXcvqKaF5UODnLbJZ2oABLtLtX8k1bezgLSvO
 rbROrOD+G0DOl6qnWGmD84O0EXn1OjV9eq9mlZ0pVERaHxZv5Hm6amizro/yMr4W6fJsoz+Jk6y
 tMH38JeasQqCjfvxtRYr8Lo+yZs5pwl83NQx6n5SP24iL8fuxEanZgnJVTp25kO3/d0LkK6+mQw
 /GA1eGR77baf88AJ1tr1ApVJn4V0RqgBiRWhU7/GD0qMMsElgzO/aBiLE61G
X-Received: by 2002:a05:6000:420f:b0:48d:f7af:be35 with SMTP id
 ffacd0b85a97d-48e07f9c33amr10680509f8f.29.1792325733252; 
 Sun, 18 Oct 2026 05:15:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4c5813sm23548093f8f.17.2026.10.18.05.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 05:15:32 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 12:15:31 +0000
To: Steffan Karger <steffan@karger.me>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668
X-Gerrit-Change-Number: 2010
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2010?usp=email>
X-Gerrit-Commit: b2d31a2fa8b5ae6544ba75ab3a7c8111c51c3390
X-Gerrit-Comment-Date: Sun, 18 Oct 2026 12:15:31 +0000
In-Reply-To: <gerrit.1792274029000.Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668@gerrit.openvpn.net>
References: <gerrit.1792274029000.Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjc0MDI5MDAwLkljMzYxMjNjNWE0YTJiMjI5NWZmZGY0NzE3NGUyYWNlYjlkMTdkNjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ea48197b75547200d97eb84274d51516c2b99d9c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIPnh-0005TP-3g
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: gen-sample-keys.sh:
 use a random serial
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
 openvpn-devel@lists.sourceforge.net, steffan@karger.me
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4522146126481178631=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4522146126481178631==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dzEs5K+1AgM="; charset=UTF-8

--dzEs5K+1AgM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Steffan Karger=2E

R=C4=
=83zvan Cojocaru has posted comments on this change by Steffan Karger=2E ( =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demail )

Change subje=
ct: gen-sample-keys=2Esh: use a random serial
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

Patchset:

P=
S1: 
> I don't think we need to support LibreSSL for generating the sample =
certs=2E [=E2=80=A6]
```
openssl ca -batch -config openssl=2Ecnf -extension=
s server -out sample-ca/server=2Ecrt -in sample-ca/server=2Ecsr
Using confi=
guration from openssl=2Ecnf
variable lookup failed for CA_default::serial
1=
40133332040520:error:02FFF002:system library:func(4095):No such file or dir=
ectory:bio/bss_file=2Ec:124:fopen('sample-ca/index=2Etxt=2Eattr', 'rb')
140=
133332040520:error:20FFF080:BIO routines:CRYPTO_internal:no such file:bio/b=
ss_file=2Ec:127:
140133332040520:error:0EFFF072:configuration file routines=
:CRYPTO_internal:no such file:conf/conf_def=2Ec:200:
140133332040520:error:=
0EFFF06C:configuration file routines:CRYPTO_internal:no value:conf/conf_lib=
=2Ec:322:group=3DCA_default name=3Demail_in_dn
140133332040520:error:0EFFF0=
6C:configuration file routines:CRYPTO_internal:no value:conf/conf_lib=2Ec:3=
22:group=3DCA_default name=3Dserial
```



-- 
To view, visit https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668
Gerrit-Cha=
nge-Number: 2010
Gerrit-PatchSet: 1
Gerrit-Owner: Steffan Karger <steffan@k=
arger=2Eme>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Steffan=
 Karger <steffan@karger=2Eme>
Gerrit-Attention: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Comment-Date: Sun, 18 Oct 2026 12:15:31 +0000
Gerrit-=
HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Comment-In-Reply-To: Steffan Karger <steffan@=
karger=2Eme>

--dzEs5K+1AgM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Steffan Karger=2E </p>
<p>R=C4=83zvan C=
ojocaru has posted comments on this change by Steffan Karger=2E</p><p><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demail">View Cha=
nge</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li=
 style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2010?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
I don&#39;t think we need to support LibreSSL for generating the sample cer=
ts=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">```<br>openssl ca -batch -config openssl=
=2Ecnf -extensions server -out sample-ca/server=2Ecrt -in sample-ca/server=
=2Ecsr<br>Using configuration from openssl=2Ecnf<br>variable lookup failed =
for CA_default::serial<br>140133332040520:error:02FFF002:system library:fun=
c(4095):No such file or directory:bio/bss_file=2Ec:124:fopen(&#39;sample-ca=
/index=2Etxt=2Eattr&#39;, &#39;rb&#39;)<br>140133332040520:error:20FFF080:B=
IO routines:CRYPTO_internal:no such file:bio/bss_file=2Ec:127:<br>140133332=
040520:error:0EFFF072:configuration file routines:CRYPTO_internal:no such f=
ile:conf/conf_def=2Ec:200:<br>140133332040520:error:0EFFF06C:configuration =
file routines:CRYPTO_internal:no value:conf/conf_lib=2Ec:322:group=3DCA_def=
ault name=3Demail_in_dn<br>140133332040520:error:0EFFF06C:configuration fil=
e routines:CRYPTO_internal:no value:conf/conf_lib=2Ec:322:group=3DCA_defaul=
t name=3Dserial<br>```</p></li></ul></li></ul><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demail">change 2010</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic36=
123c5a4a2b2295ffdf47174e2aceb9d17d668 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 2010 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Steffan Karger &lt;=
steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 1=
8 Oct 2026 12:15:31 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCom=
ments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>=

<div style=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt=
;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Comment-In-R=
eply-To: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>

</body></html>
--dzEs5K+1AgM=--


--===============4522146126481178631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4522146126481178631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4522146126481178631==--

