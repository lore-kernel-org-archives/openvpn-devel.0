Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67F4C43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 22:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=acKA1u+q3+pgDMDoSIi5huKuGLuXPh3wcJlN+UU63/Y=; b=GEQDxHR2WEko8JDNCOE7Eu9rdD
	QhlKo6zcsx9/ClbMF01dzQEmO7gDfpU3oL36tad/peu/s0D6pRzPUFrgsbQaQP2aTdGFkMsmIozKs
	BXJf6ltGenN6ylkguYa/QL/4cbaq+KnS6glAA34jvabseT3LytzmSrhTPxqoaQu78SGc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wf3BD-0003wh-Ib;
	Wed, 01 Jul 2026 22:13:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wf3BB-0003wa-S2
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 22:13:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=8dqapwp7mPt5KqiZuaFS14lNkV9rq8asOC3M5glEsDM=; b=MMYyXsYG5Ttpig0ffPe6xzJhOz
 L3lKxB5wN6aveVKu7q8qigsJNE5WHosIte9Ad6woROSc8srwy6GJsnuPE5KX8CzqA/lph2x7NMUKM
 h7Ob5NlFdN9Fto4zr0h6GCUURiDbbboYVwWmBizNGhhfnT/cFPJroMLLt23Cw9987aQs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8dqapwp7mPt5KqiZuaFS14lNkV9rq8asOC3M5glEsDM=; b=Q
 dq2DYPg7MLoNfJL0OJV2jnljPeaHXiGd+QgvvfFk3zwnR5mD2MIvkAGtYsmUjWebpzddGxRxu3Jd6
 gvq3C3k9cDafqnUYpXaZ8UY4mgU/Fj//C9Bh2Ip+Ts0N5S1llwXlaUgj4Uy/ItFkfOpvHRgPWd178
 g8YAxsEGiGxCM+zQ=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wf3B7-0002j5-Ja for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 22:13:11 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47488efcf30so705434f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 01 Jul 2026 15:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782943978; x=1783548778; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8dqapwp7mPt5KqiZuaFS14lNkV9rq8asOC3M5glEsDM=;
 b=Ky80jYo4ZCUxA8ZeFaYY2Fu+KpJIAFh+wsjs3d6kc2V14/JYKP/Mh27RmKHBlSjmeC
 qDTJEFJ4YDKM/Gcp5lHoZcouKmsEAI7kpKVdIOhHhIpkPMaXTe2Of5tLnsqPz2fGozt7
 s/VVdjzBCqAatYQIYz92PHAh/X7+8LcF5R/iWSPXYqTRDj0rFwfnYOFJpHQCHBJZ8dhh
 Gb/BXll9eckP6DkDg3uKhmwMqNNpOgTe8VsnztqBCGsFRN5nMUD1R2fcamIIEFTcDJ20
 5vjFE+z5XQV9ZL9BjLj1tdskReiPD3nJErghdd4Skjet5lADaQXG8UZUBSt/3d5fC5Tw
 398A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782943978; x=1783548778;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8dqapwp7mPt5KqiZuaFS14lNkV9rq8asOC3M5glEsDM=;
 b=Qrmopq1i5LN/eXMQWleEYL73fNzgPnyxuJgS/oyVMGbn5H8YcpzW2AlEcb9dIZ/kl3
 Aluj7cj1qgOuLRy+u3LcJ8VUaV4ArBCs5Wql4PoGqBVm5adVmNFpEI3eSFmBWH2bcJld
 87SBMK2WvMbT8IXTbKSw36n6NGoU1W4nH5WzBrMQAjd5Gx4emtf7ZNIqGopHfBF7Bcph
 1ZRdp8GD1ZiK5CJPRREYYhXQaECWFRK6bOKPrsACPWyfDUHUnGKCeORAXJHqfDMYJB8x
 69yosrAYxpK+8wTJKirm/mZ6AM2qytd7yWkQvOKQ6YuGGTiOWM9F85oCRj1oCI4MC60L
 9V1g==
X-Gm-Message-State: AOJu0YwOvVbQko9+9UvhphamoX6dhQI7Ut34Zddbb/Wd5dq4MgCNSW3R
 eMgIvavILRm3FNLV4ia9uDHpjJ66DCbKd1+KDyCjEnyEyj1eK22Yl3YxvvC0b9EeJNQi0X2Zm8N
 tLQJOQ8Fc2+luIVUy3Bhct5xn1lBGcso8+s9yay4NSDSVwjNLGwScFc5vgcGYYJVvauNKdyVUx3
 vqovRYvA==
X-Gm-Gg: AfdE7cm3NK6tBH/AN1woyhmHaA1rbIWcMo4ArhQXHvCHKJVZ0mjB7TpdiSoGpPDnGNz
 hfIpWxtUsu1HXKQD2Hn7s6Z0EyX0VGHrzgj5XJhCyOhy5bNHAYHyFKtZ6dWS5LcX9wkv466SDMU
 m8msjgXLJGul5yBSP1DGWNAmnpBcb9iOBYx5g5vexUEqbL+Ch4bthcRmtbiLcTnqigiVX+LYaGP
 xAEvjOVqBwaoKq3Wo1S719BXrzyB1LCDO3ncdCJsua+67bq0QXeJ7wptzWXXswlo3EFT4N11CdF
 lT0emJWqtj0NZOPfPE39uSM0b4+TeyATNijP6fK2CjxKQyxtLA/lnKBRNcHmbWReg7wFiHNv5me
 0/eZZQBW/hZ8suJAbK4DB31ROz1+OVvswwFmsJ3u5G815CqhGIOOg7FyhtVVwOYMt6kFlVB8Yn6
 1ZWUXwTc6WFzxwTSwRxUWkzZkQCKK4zOZ74exswm/1bfXHPJbJczIfVdzB+b5FiUfVPqwuiqJnm
 y7Lep2aH9xhllOp3rH4lg7jGfrxs4G5DstrB3vp04uaNUTmnq9dYHAENOngtv8q/dwN4GWBUj06
 iiY=
X-Received: by 2002:a05:6000:41f8:b0:475:f0f0:9ef6 with SMTP id
 ffacd0b85a97d-4775b7447f7mr5910891f8f.59.1782943978517; 
 Wed, 01 Jul 2026 15:12:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3db964sm3143239f8f.8.2026.07.01.15.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 15:12:58 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 1 Jul 2026 22:12:56 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iba577d662b389de539b81034735e437199cb495d
X-Gerrit-Change-Number: 1761
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1761?usp=email>
X-Gerrit-Commit: bb285c2156009fbfbc3ceee439e71daf2cc3dc8a
X-Gerrit-Comment-Date: Wed, 1 Jul 2026 22:12:56 +0000
In-Reply-To: <gerrit.1782921496000.Iba577d662b389de539b81034735e437199cb495d@gerrit.openvpn.net>
References: <gerrit.1782921496000.Iba577d662b389de539b81034735e437199cb495d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTIxNDk2MDAwLkliYTU3N2Q2NjJiMzg5ZGU1MzliODEwMzQ3MzVlNDM3MTk5Y2I0OTVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ab1f5cd6b6d168f0579a82c6a2db76ded9f48401-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wf3B7-0002j5-Ja
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: test_tls_crypt: Fix
 issue with temp file name on big endian systems
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
Content-Type: multipart/mixed; boundary="===============0377255974981509679=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0377255974981509679==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FXYR4iXekeE="; charset=UTF-8

--FXYR4iXekeE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1761?usp=3Demail )

Change subject: test_tls_crypt: Fix issue =
with temp file name on big endian systems
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1761?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: Iba577d662b389de539b81034735e437199cb4=
95d
Gerrit-Change-Number: 1761
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Da=
te: Wed, 01 Jul 2026 22:12:56 +0000
Gerrit-HasComments: No
Gerrit-Has-Label=
s: Yes

--FXYR4iXekeE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>Patch set 1:<span style=3D"bo=
rder-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgr=
ound-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1761?usp=3Demail">View Change</a></p><ul style=
=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1761?usp=3Demail">change 1761</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1761?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iba577d662b389d=
e539b81034735e437199cb495d </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1761 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div=
>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Wed, 01 Jul 2026 22:12:56 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Y=
es </div>

</body></html>
--FXYR4iXekeE=--


--===============0377255974981509679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0377255974981509679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0377255974981509679==--

