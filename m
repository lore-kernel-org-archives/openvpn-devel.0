Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD53C5CFC1
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 10:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QbcAdk5wsrzAQSQIzQh3a22gme2YIgn8XNZRzRHz8FA=; b=BAY+ZMOrGIP/oLWTQnNvad6m7m
	x8uK1nDxA63ciT9i2O3+ZvO3GH0GhCifmVZ6l2DbouGdqSdbCjtEwOFp4wMYqC7SbXlWRHTIKkuxC
	i2dUSeIumUfnzL4oMAUSrt7Kj1ZN7PoiCVuQQQmPGeT6V2kq6S/B829Xj7asFEmBgT4E=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuoms-0007WK-Mw;
	Fri, 14 Aug 2026 10:05:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuomr-0007WD-IQ
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:05:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=gq2D/CmMdV9OgulVDvmhVMPa/OwgTHA/qQ7nCKFti2I=; b=Qp/EzFzv2rumwxRepTC3dE4amX
 m9O36jrrdvUcUGWXFkkQFly/UxptWlpNygWxZEYxLrg80lKcDtckUGzZnGWvK7o9pYdpS3AN9JjTb
 3WsFvtHgBOevARabuzbLv14rOQHDUStofUOl9ztoe5ohZisPD4IuddgBF8Ao+VSBop04=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gq2D/CmMdV9OgulVDvmhVMPa/OwgTHA/qQ7nCKFti2I=; b=k
 mJKvZqqqzN0F7s8sTzbOCi5J+BhP6TeWvhqTad3CzgQCIHwUjQRF/jD0A4L1T84cGGuHLalrc26+z
 ZpuQdYQVlcYhd7YGp3ejm9lyhMPV7ieEVYr8bt2+pwxXwHWpskNEIfgM4nYwlzfgLQxVijiiZ1rT0
 uq5z9/L/++a8eRZY=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuomo-0000ko-PS for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:05:17 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-47f92e3c14bso692894f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 03:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786701908; x=1787306708; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gq2D/CmMdV9OgulVDvmhVMPa/OwgTHA/qQ7nCKFti2I=;
 b=IG3OnFAuFVcOLHcQPEudzuguUFmX6iOG/BVDD30AvPF6yThAbGmLWAOOnL1L+f8KPO
 n5dlHEE90PD23NiNgGt/rnwKUM2v0TreaWE9Qk2VVIxw9lnOLxsKOgW/r5zD/RHmXZe6
 6bnjXr1im+BkWAjDWc6kTilJWccXVeqVnNYgVgi1bMUTRBcCVnvukPveCEZAXHb9obe0
 f3Ir7jusB3QAhEl/ThZFl4WsCokXKidhWBJU0YZr9M24bAnMrg9m4q+Od5PwYIB4VSFB
 IqscII5kO/392NQMzsOVHVgbBoWn2ZWIG3Yi588yGOzHb/b5/UnSds2T4NS6UVsEFdgn
 +H0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786701908; x=1787306708;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gq2D/CmMdV9OgulVDvmhVMPa/OwgTHA/qQ7nCKFti2I=;
 b=si/ZXvwWv50jJUr2i1DVA9R1HRBvGcfpTBQV+zWOXHcq3G0w5grj+A/e+MOQTlKnL3
 ZYP80zLHayXdsYwil9vN8CA5M2kW5t9+8fNbD0HmXvwl4dxi8CjiAdukoo4h4snCcEOv
 wwuVUKV8kkf6K+6kJfhbKSr3RMO/ymAe5acz8DJbbQ9CS5HusoSKZ4HbI3eIifPz5V7U
 f4znDRjVvRphBmeE08yJMRVvLIp0nB6JcC2A62qQAPdKdUpq9ykBlSmsDFhNrtQ8g/W9
 XLnxKnodJ2GFFFQQThSNZsrRIHHE8U1HHTYk/zu9TFr5H4q6+4lXjLJ+D6375ADDbqfd
 ydiA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqID3sxXHp9YpGXhmK1Zxj6ipYoebVdBpOKak8539RKnFOBbv6pzZAhzEBGE4gek9qvWtVbfc7ReMVmFAis@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yxm6irnUzDUgJnNmjDSRs8xekBMOPh0tpnterLgDUcprJ2eu5Cw
 meUwCrPo68n74WcJKGpvSomeBAPmbFNBd7fTsW+uQC3mI/xZtyNhRyN5BJleof5OqS5uEv2BLh2
 t14XXoIOEBZlwl3uhYKMDTJ2dRToT9OraJhpVx/uMYJOpsUT5BS5GaJEnTOlgLGSxnHcb
X-Gm-Gg: AR+sD11hSY/hE6Wu/Nwhi9vedYanf1ew0qmvmzvpYz/Etzg3vhkoASNvDiQ2akXf4V2
 gkH+fkeun7koAjILrtAc0e+iYUuZh+NdhQAG/DSTGj9zhRcLMG/RVJ8weRTV+2Rk8OIuoLPkQsr
 WUp6I2vqX8krd9nc4QHz0k8pDQFty6wguSn72goCNBE0/e+AUmtKfQi4C+QfOVcbSV3fBl/KX7I
 6j3BycpqFGiRGlSsorQ0wpRheqIZ75j8tl/gDATEMBPGYZIev0QHtZvuy+U23M6VsrOibF+D5eK
 bM/Zjf/WFo61AwgfQB2+JDjmMy0jb27ZGKTyxCDjb6SjQTJLgSBLAsljnURWLp7rCTSfHgN1HE8
 lZVq9VxESQH4SwOvw/77jf9ERcJ8bLt4eM+mt6HEQZrKGee8kgTkfh1Sy3oVIbIWhONLwQvXVmo
 kFgD8b5u7F9KmmB3GLPBGmjuD5Lz47NNMKuiu9k/dm9OH2wC8FJZpFxvARXZNQLblw+fSzqjcKo
 egJN38dvIMqClWMh+yxIk7Bk7MYQxkcFqnJ4USL9mOk3rVKieKj93m+7zelq2iqYhw5/LViHHL8
 gvoCyFvDled1hLZUK39aRoJGIZxBP13LUj7+qhEGgFZq9+jnhPE=
X-Received: by 2002:a05:6000:230e:b0:481:60fc:edc6 with SMTP id
 ffacd0b85a97d-48160fcee5bmr5399379f8f.27.1786701907140; 
 Fri, 14 Aug 2026 03:05:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2c6115sm6787351f8f.32.2026.08.14.03.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 03:05:06 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 10:05:03 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5
X-Gerrit-Change-Number: 1610
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1610?usp=email>
X-Gerrit-Commit: e6fd07d842db523bf0b0aeb8952b6b190dbf8188
X-Gerrit-Comment-Date: Fri, 14 Aug 2026 10:05:03 +0000
In-Reply-To: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@gerrit.openvpn.net>
References: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1MzQzNzQ2MDAwLkk4MmE0ZTgyZmY4NzZmYWI3MTVlMDUyZGUxOTAzYzY1YjgzNTM2MGI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d3bbd3d120274e5dc51b94395f8d3d58b4d35f01-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuomo-0000ko-PS
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove various
 unused functions
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============9003165464281085583=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9003165464281085583==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ofaAgtc+Ai0="; charset=UTF-8

--ofaAgtc+Ai0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

stipa has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1610?usp=3Demail )

Change subject: Remove various unus=
ed functions
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 12: Code-Review-1

(2 comments)

File src/openvpn/buffer=2Eh:
=

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1610/comment/f8148efd_ce4f2c31?u=
sp=3Demail :
PS12, Line 818: {
> Yeah, there are some examples in here wher=
e we remove parts of an API that are not currently used bu [=E2=80=A6]
OOB =
patch series (not merged yet) is the consumer of buf_read_u32=2E Besides, w=
e have write_u16/u32/u64 so removing read_u32 would create an inconsistency=
=2E


File src/openvpn/multi_io=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1610/comment/0703568e_f099715c?usp=3Demail :
PS12, Line 666: multi_io_=
delete_event(struct multi_io *multi_io, event_t event)
multi_io=2Eh still h=
as a prototype of multi_io_delete_event



-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5
Gerrit-Chang=
e-Number: 1610
Gerrit-PatchSet: 12
Gerrit-Owner: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: stipa <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Comment-Date: Fri, 14 Aug 2026 10:05:03 +0000
Gerrit-HasComments: Yes
G=
errit-Has-Labels: Yes
Comment-In-Reply-To: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--ofaAgtc+Ai0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 12:<span=
 style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding=
: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail">View Change</a></=
p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/buffer=2Eh:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1610/comment/f8148efd_ce4f2c31?usp=3Demail">Patch Set #12, Li=
ne 818:</a> <code style=3D"font-family:monospace,monospace">{</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">Yeah, there are some examples in here where we remove parts of an =
API that are not currently used bu [=E2=80=A6]</blockquote></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">OOB patch s=
eries (not merged yet) is the consumer of buf_read_u32=2E Besides, we have =
write_u16/u32/u64 so removing read_u32 would create an inconsistency=2E</p>=
</li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mul=
ti_io=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1610/comment/0703568e_f099715c?usp=
=3Demail">Patch Set #12, Line 666:</a> <code style=3D"font-family:monospace=
,monospace">multi_io_delete_event(struct multi_io *multi_io, event_t event)=
</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">multi_io=2Eh still has a prototype of multi_io_delete_event</p>=
</li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1610?usp=3Demail">change 1610</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I82a4e82ff876fab715e052de1903c65b83=
5360b5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1610 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: sti=
pa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Comment-Date: Fri, 14 Aug 2026 10:05:03 +0000 </div>
<div style=3D"=
display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> =
Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply=
-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>

</body></html>
--ofaAgtc+Ai0=--


--===============9003165464281085583==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9003165464281085583==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9003165464281085583==--

