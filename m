Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBCFC43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 11:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HqAYCAGeNn+usps7lKoKqwGxUCw/GyQrC1p6iwN554M=; b=XYVThvysUx77iYWMWghkDmIyoW
	r2xT2o4qiHY2YhRdkxXlaLm57iOadVg/opM9x32SejncoCkt3wgzb5l1e8VMwBNumyi8JdUCeL+k2
	TTQQgl4VCuFAC+idf6k5DZYFRHDeENlUvNSUdxhLUY1DHjKlOKMvnEgcXQol83qNraeU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wetA0-0002vt-4K;
	Wed, 01 Jul 2026 11:31:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wet9m-0002vg-QA
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 11:31:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=FJ9d8O7x/0/T2qw2Q94ChmoDnqL+uzfBBElj9zaR8Ig=; b=gdLj/vF9Y+UMERKnCR4iNS2M8c
 SMdnU1GOwUU6W4Sda7tlgFP1aec4Q4iqmBPdI76+PjO2eV1WxefNlKZlcTVs9xKLiAJG1ltyyoI15
 GlQ5R0RlO/wILHZuU0SsfStLV7PWS7yftADvKXf9WxJJwdjHcXyfx8jTy88KWvtDO9Mg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FJ9d8O7x/0/T2qw2Q94ChmoDnqL+uzfBBElj9zaR8Ig=; b=M
 gYHbnu9PahMH6JI4cACF+2alIGyAvsQJdQp3mjeXYC1EnorgL77xsZYmrsW4H3njMa6aI0TgcwuAu
 ikgGLzm8ORbjQ9AiIHgePLwCbvv2dGWteqvSYj6T4de/iFjNrU3odhRteXxmci3QxV9KNdR+CdZ5x
 HdXRdJ+ngF4gCOp0=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wet9i-0003mr-5C for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 11:31:04 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-475417f010dso337689f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 01 Jul 2026 04:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782905451; x=1783510251; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FJ9d8O7x/0/T2qw2Q94ChmoDnqL+uzfBBElj9zaR8Ig=;
 b=hSzEoj8RA+sRczrr+sivEcKiM0t7WlBlo70AyNOWWRiXENUzfT36aOhmHAzvxSJYXF
 SSyUgZKgWYd3rkfu8fRBSYyvMl1ff3m2o1xJdt9Ujr6hGqYBcUa/nU8zrGOMBE9HHTjq
 lQoac4Kgt4dTj4ttQ1u9pEGBZ7NXFo0oibrG5WyA0qQ2+a4QwrB31jFol688BWyrWGwI
 kBDzg0vHPqga3WqDFXXYtAvqOeWJDS5NKuvyzivymrBjS/9zuKr/GeRroz+LjukjCck5
 n0FFDufgKX6R6EYXZUZITg6oGvsmURh28iTO1jBF29j0RGi7nA303JAQpJMKlfHwd29L
 TGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782905451; x=1783510251;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FJ9d8O7x/0/T2qw2Q94ChmoDnqL+uzfBBElj9zaR8Ig=;
 b=VbWu0so/Glz0J+z2PrmRlwZidnvMdBkPIfWUuw/rFWAEcgRKeb/agf+MZoTqxQ57EC
 MdKTLLUszf0srh+Bgh06TKzUCzlR6LJ5J9kI85QyHlBnrYNFcoBWQJ0NXkcWL1elv07e
 skd/cZcW+IuTLks9vmDu/fo3PKr8XUMyaNjmVRBgmtc4I1wzQ/dhx6vcMgJj56Ves3T7
 DZB92S6LbxXyGgwumzTVgm/z7vBgYlVabfyGLGuwN3dno4KIXH7qA6fyLdb8YwDy2sB8
 +ZwWWLwczPlYcZOtSF+ynNUylpdHMjlIDhQ1dYF/ecyHy2TM5HeeyY8EEC1sk4kHJs+r
 OY8g==
X-Gm-Message-State: AOJu0YzQeCfeDWkVxPF2iOvoaIJYMJezxK6honWiUj05OWRjvZ+eAyIR
 ukyjwjxT6DBbSiScr0Fp4Rt0bD+rqfIFjNA5gw5bX9FKZsH5xtpPAXdzmJEZN/vxaUHdgTqx4PD
 1znC2mDxYFHoif3cZ37PlmJ3Gv224y8mEHrbSuwJNj3ufGCuJTbuCcWaBU7T1wzI+62u8
X-Gm-Gg: AfdE7ckMHI7g4RmjT6OWep7yUeJ/5jskkJZ0CQa+wY05jRVHR8SVjXwoIgO2ITTVV6A
 ToWhSab/6Ujq39cO22T/wJDePLcFPjmgOgfcv4ByFeqy8hjZEWaoyOYSBT30dsWpSsDDhz6ZUIN
 tnReS7VKD0f5TvIc9y6wdm7oFcGycS1tYrDs7vjbU+Wy5axrLOfytMpEzSBQG86w+J+09saOIPr
 RZUUKsOKS34UUt82qCDRFjqtn0cXJEQLm8e4MLopCkCqToxI+/r1tKILUD1Gk86GY7XGKj5tq37
 ClnkGF3gdroyk4jZMoEc1jROp5Sbg44UGLP6Vxcdf/8YFcCSY6KrnZBe45qsuTTr+Y/me3PnrWv
 QOu94IjMYJznpQnzr2JZrCq8X7/KN1u559eB5Urfhqrw1OqpXBqSlNzL3LnrxBqXPfGX0eQLZ00
 JeEblLUD2NQY3e2y74pmfqNTL4t6D0X3ZyplMkDi4A77+7l0OVLwMNqbPvsy1tYOK/vQQWMTNOH
 lzcsuUEnqBrDFS+B3Kh2OS02C2O0Zsf5hXACDwMWO9CbgiBkYLa51ylsPUaCzPQizGVq+URM8Nf
 TNM=
X-Received: by 2002:a05:6000:186f:b0:475:cd6f:720a with SMTP id
 ffacd0b85a97d-477571cb959mr2095013f8f.1.1782905450785; 
 Wed, 01 Jul 2026 04:30:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-475643cd64bsm17006770f8f.14.2026.07.01.04.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 04:30:49 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 1 Jul 2026 11:30:47 +0000
To: d12fk <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6595695ab6401047d498d530f8739686880bea3a
X-Gerrit-Change-Number: 1733
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1733?usp=email>
X-Gerrit-Commit: 522eaaef80c1394de08ecf773b6595d0b17a84b3
X-Gerrit-Comment-Date: Wed, 1 Jul 2026 11:30:47 +0000
In-Reply-To: <gerrit.1782500411000.I6595695ab6401047d498d530f8739686880bea3a@gerrit.openvpn.net>
References: <gerrit.1782500411000.I6595695ab6401047d498d530f8739686880bea3a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTAwNDExMDAwLkk2NTk1Njk1YWI2NDAxMDQ3ZDQ5OGQ1MzBmODczOTY4Njg4MGJlYTNhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d0cd678794178aa1b6e3fc155d90f334d327d63c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wet9i-0003mr-5C
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mingw: avoid C99
 "hh" scanf length modifier
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
Reply-To: arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3792709099410844243=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3792709099410844243==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OegVaUQ41o4="; charset=UTF-8

--OegVaUQ41o4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk=2E

plaisthos has posted commen=
ts on this change by d12fk=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
733?usp=3Demail )

Change subject: mingw: avoid C99 "hh" scanf length modif=
ier
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 2:

(1 comment)

File src/openvpn/crypto=2Ec:

http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1733/comment/3dd58ae2_6f546134?usp=3Demail :
PS2, Line 1=
477:                         ASSERT(sscanf((const char *)hex_byte, "%" SCNx=
8, &u) =3D=3D 1);
I am confused about this one=2E Does that mean we have a =
toolchain that defines SCNx8 as hh but then cannot work with that?



-- 
T=
o view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1733?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6595695ab6401047d498d530f8=
739686880bea3a
Gerrit-Change-Number: 1733
Gerrit-PatchSet: 2
Gerrit-Owner: =
d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: d12fk <heiko@openvpn=2Enet>
Gerrit-Comment-Date: Wed, 01=
 Jul 2026 11:30:47 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--OegVaUQ41o4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: d12fk=2E </p>
<p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1733?usp=3Demail">View Change</a></p><p>1 comment:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0;"><p>File src/openvpn/crypto=2Ec:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1733/comme=
nt/3dd58ae2_6f546134?usp=3Demail">Patch Set #2, Line 1477:</a> <code style=
=3D"font-family:monospace,monospace">                        ASSERT(sscanf(=
(const char *)hex_byte, &quot;%&quot; SCNx8, &amp;u) =3D=3D 1);</code></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
I am confused about this one=2E Does that mean we have a toolchain that def=
ines SCNx8 as hh but then cannot work with that?</p></li></ul></li></ul><p>=
To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1733?us=
p=3Demail">change 1733</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1733?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> G=
errit-Change-Id: I6595695ab6401047d498d530f8739686880bea3a </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 1733 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner=
: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12=
fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-C=
omment-Date: Wed, 01 Jul 2026 11:30:47 +0000 </div>
<div style=3D"display:n=
one"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Ha=
s-Labels: No </div>

</body></html>
--OegVaUQ41o4=--


--===============3792709099410844243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3792709099410844243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3792709099410844243==--

