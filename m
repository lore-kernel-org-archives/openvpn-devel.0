Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790C3C9830B
	for <openvpn-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C/UJcOs/m/hFa+SE6n2UpPffxhDTwlE0KSbE511FLUw=; b=RSCrYwrrd4imvbSkkwSWEaGwmv
	JKEPl2lPJDvhb7GMnZKnCNiC7xYpp4jpBWyN18WxMxUJy9iDjQTfewJm9VVecNE+MRQgFCwt7wSrq
	gUz0bKrw46Noznk3Pqk6HhL1spsV31hCZaUy1i/WSPBbLNiY7jf1boaDYqoV29KLIuwY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9Mdl-00062O-Q0;
	Wed, 23 Sep 2026 13:04:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9Mdb-00061z-LA
 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 13:03:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=zUhpzn4ZFmfubb7wVsRdlOjVdxQwdznIs45AFuu357U=; b=FwiSzTD2TCjQs/26wtGJmk0LRj
 4sJL7LsJHztgXN5bRKurPXa0Gwy65/IbLC6nF5FmYLDd6VaNUlr2+wu6lj4+NGYTSgZxH18nQrLvL
 2DI4LLYXXOLsQqCUVGVD+sybLOy4jpyrL4C7swwlemg9DkYDgjmiskaq2gVdSqTZFzkQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zUhpzn4ZFmfubb7wVsRdlOjVdxQwdznIs45AFuu357U=; b=I
 7S+yQbjkysGqqpz485LVi8F5I35+935DmuqbiMKnVn3toPQLm0UeD3FlvgWbSC13Cg22uNre4B99/
 H2eEGzfABJmJAmueyUTI8Pz9cm6BzYZDc0Gelpj2rjlgx/jexh7/1CF2MB5xrLzGnXbsBBFxoZLml
 /n5JCZ2yMcbBuOs0=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9Mda-0001nm-Vu for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 13:03:52 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cd38e0e5dso11548875e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 06:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790168624; x=1790773424; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zUhpzn4ZFmfubb7wVsRdlOjVdxQwdznIs45AFuu357U=;
 b=AivN4AZUjSOmGXLZ9esggypFl6x1BYO4vJXIExjmDP6oEtUd6lOIv7rm2cmiOYGd1w
 n73Yv/VWbKjcHn0+WLhk3fbWgfiNSWkubvzFCGsDU6lSLoUfqE+ZeNbQBRE98XrZMaxv
 hMuVY00JbZmxaUbI/iMbymhieTTaLfbDBaiMSJt7qopUTpAEeUl9XMDpnPEx82kywyWQ
 oFyyVKAykqNfp3ONYZbgzHyCuOFGrdCVdn9G2irAjxvZ/fI2YU2DvNmEy94sUagEtzE8
 r2abK3fuYRAZIz8j3ChiOwVddKg/3XBeRW4jki4MQ9mOZOx+C8OlrmIp5jutNhWDeIgI
 0SpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790168624; x=1790773424;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zUhpzn4ZFmfubb7wVsRdlOjVdxQwdznIs45AFuu357U=;
 b=esDwuy5U59TEpzp3yxpWMXC8gv1bDLCB6IVjozGY5gvv0kBXUztZR6jpLeeVTqlEXy
 8zagvzKRV2ICEUHsotkwokveECnSyuIXuck8OV22dPWq/AMoR0Hj2fVL3DrSILOL5CRg
 I0M22m7J4Pqe6DGAexOXszJoDzo804w3oiNExzCyGz4JjqKfVEQQiHWJHfLc4dqEdFd8
 dBgUZsdlNI9znIQGNhTiK5zU7rQ80bxdGrprwT3myXhZTX8bfeFmuA/EyCVNI2XGrA6D
 EX6jQMhS4V4ejnehZ5eBypUdQkqbtGJzEyHmEGhl0HqhS83dlJwtzdjPfHhhbb4/dJ94
 9WBA==
X-Gm-Message-State: AFuF++mbKN0QYpbwnnWBzPE6GkWQeagiXR/Cjje0OaqyMKRC8EaY8qaQ
 XULJgywC5ydHIVt7bHADn0K5+MfdSRCVpOlfE1vs1iSz3JiZMxT/5uvnXIA1zRLVkJWU31k7crE
 AsRCWRvANdCcYRdJQllTY/wbFA7migtX8pmwz0WT7aYi0GNUF9go7EfFvwJLmjNVNDt9O+RzyeH
 ZVRLwcQQ==
X-Gm-Gg: AYBFou0z/relHK91JWW2xOgjv17fEEl99WosqzPzs+EDUkpLmkVoZ8QV+TwIihxG/hq
 dX0HCi+KX4+tulU2QuMUE7MQWoJWiNZiyZoIXrgJ0dEH4CWJcwB7oLykSkQCeUdARhMPQ+DNTix
 jXdJxX67/KWnb8LplkcoEw16C9sebXPhDTZhVx0bTYyXy4LYkc4RubMRlGxgt+/vtjgXXfq/6hS
 k0Uf6BNYM4AYSjIxFUVf98dqjy/1tDB8Xf8jjBpdEJk66mKZC4DGWN9+fIncQ0lpY9tqL+CqCfg
 XBfz+DVqs2YC1csuW1hH1bIJhBoZhLqiTzJxH7FqFKMZDHnawJ6Z7c3iuJwh6hzCR5DTPhlemOa
 BHhIj35evWBJHM4jHLMyDuFqsLyFMVkWHaqGPtUHVu94P91iIKXFWQCT3f8//wS7itvB8O3W8wv
 ArUDoDrUlCV4MUcT+j2JwDFzBSKlqHDUUMFHC4c11dpYB9r3KlduXxVm00LTuI/GC0KkeKUEwl0
 vU+6e/Sa5PuSQ+r9wuoOZMoWEi5dkym9FSTt5pqM/l7Oe9s+M1BLF7hVmhJsnmJ8QQTJn1NnyDl
 hRxrMtlWAuwh3h8rEq7opcM+v3u4xbPTE2PG4MLL7aReUs7i+6BDcgT2iM689nvkpcwFqcms
X-Received: by 2002:a05:600c:46d3:b0:49f:d6f0:6f24 with SMTP id
 5b1f17b1804b1-49fdeffce04mr37442575e9.2.1790168624056; 
 Wed, 23 Sep 2026 06:03:44 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48868779472sm7182510f8f.23.2026.09.23.06.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:03:43 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 23 Sep 2026 13:03:41 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: If276bd4c5d07fcd26f6749f514f0257eab73249f
X-Gerrit-Change-Number: 1945
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1945?usp=email>
X-Gerrit-Commit: dad238d7807324a3ff14a3a53cee24db17e986d2
X-Gerrit-Comment-Date: Wed, 23 Sep 2026 13:03:41 +0000
In-Reply-To: <gerrit.1790167275000.If276bd4c5d07fcd26f6749f514f0257eab73249f@gerrit.openvpn.net>
References: <gerrit.1790167275000.If276bd4c5d07fcd26f6749f514f0257eab73249f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMTY3Mjc1MDAwLklmMjc2YmQ0YzVkMDdmY2QyNmY2NzQ5ZjUxNGYwMjU3ZWFiNzMyNDlmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cad8a9475785c172631bbd90c6705bc8b739c09c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9Mda-0001nm-Vu
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.7]: proxy:
 Work-around spurious warning on mingw builds
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
Content-Type: multipart/mixed; boundary="===============8208758199072917041=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8208758199072917041==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vSy1Ti07044="; charset=UTF-8

--vSy1Ti07044=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1945?usp=3Demail )

Change subject: proxy: Work-around spuriou=
s warning on mingw builds
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1945?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: rel=
ease/2=2E7
Gerrit-Change-Id: If276bd4c5d07fcd26f6749f514f0257eab73249f
Gerr=
it-Change-Number: 1945
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank=
@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-=
Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed,=
 23 Sep 2026 13:03:41 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--vSy1Ti07044=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos has posted comments=
 on this change by flichtenheld=2E</p><p>Patch set 1:<span style=3D"border-=
radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-=
color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1945?usp=3Demail">View Change</a></p><ul style=3D"li=
st-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1945?usp=3Demail">change 1945</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1945?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:non=
e"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-=
Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release=
/2=2E7 </div>
<div style=3D"display:none"> Gerrit-Change-Id: If276bd4c5d07f=
cd26f6749f514f0257eab73249f </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1945 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Da=
te: Wed, 23 Sep 2026 13:03:41 +0000 </div>
<div style=3D"display:none"> Ger=
rit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: =
Yes </div>

</body></html>
--vSy1Ti07044=--


--===============8208758199072917041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8208758199072917041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8208758199072917041==--

