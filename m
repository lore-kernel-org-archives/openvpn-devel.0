Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7A9C5B572
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 08:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O05V3IxzZUwc0+UOBqbJrKiBXeC6ZN5wrrNnlKNP6NA=; b=htnZJqgX9m5PbNUr1+2E8h4F3b
	BUswaA4EmuaYdWvpvu5UlWC1fbSeccNDtNf/Dw3qaoWkfV1COSp+wSsrp0ZP73D2RwI10JJaA69D7
	39oCLt/zmL+AeJbQ9GjIQljJo81zH06Wqm9/WP3CXMMhnvXPYpwhUpqkCmYGjNkaTnCQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwbGZ-0002z5-Ee;
	Wed, 19 Aug 2026 08:03:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwbGV-0002x9-8e
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 08:03:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=9SKgJ8BTDgR/BvFGH1I8M93rlPRzoKGfV8XskibKakI=; b=PvmgfmRurPR0wdGsmSkPKI3zKx
 9EKBUHNborhqqlTs/giIJfWbX4VKqU26/APsObGHQ/GYWaX1Sda7+JaGe3xnHiPEsVGltW7khB8rG
 lmUrinATlOGUn2A/583u2jbUJt8t9NtYR1mvWUcwYzV6zlL9tq/hzZbiKogCyZ9Tii9w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9SKgJ8BTDgR/BvFGH1I8M93rlPRzoKGfV8XskibKakI=; b=D
 tWobsreArqvC78fnSI+brUjJmJpNkuKNCV2oGx1LqZ+tBQgYbS/UJYMyMNtZdhjWlWjRzvwgpnCq2
 YbzRqFZNTx2HJLNVj+INV64UkLov/J0h81ggXAaTY8OWZJEVRDAXvQTv3vX/F/l6EhlYPlgRLyBOH
 zmbE5jetrdF8mYfw=;
Received: from mail-ed1-f42.google.com ([209.85.208.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwbGR-0003JA-E8 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 08:03:12 +0000
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-69c600f76ccso1146615a12.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 01:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787126581; x=1787731381; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9SKgJ8BTDgR/BvFGH1I8M93rlPRzoKGfV8XskibKakI=;
 b=EGN0Ch8AkOBGQkFo5xDaKXgH1mhaYk1xFUV48sGEAA0s/CJyD2Qd1uOwiLGhLSetwb
 4zIbsPAVFil+WXBqzgwJ5GcnVjboLNZ8XjDniqyuO/GrcwFpkFJ+zfk2OEaJMllARkBS
 JEScelvGqb1/Y1vh23KXCZ2HZeYW8YjSpoMNgNuDMv32vmfLoG60G34wWZSiQ2A/o6Rd
 Ia6/V3fR1YqsSjccq17mEd161u11S+4hSUs2bTEjWLGfVMJjQsXFHI7Pc48wphxh9VTX
 9JY/YWvikgOpI2hLazAGhaFeFGUX/abLMVETmZYhCmn1cBenhjI0Mzc7RqB7Hap86QT0
 JPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787126581; x=1787731381;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9SKgJ8BTDgR/BvFGH1I8M93rlPRzoKGfV8XskibKakI=;
 b=nJBPGbRZRkmpMpZMPbaFvFA0N3qlXpJb/CprOanze7Q5AZF+A5WA1H7RGbvLy1tx4c
 edhvIOarKSam4o5PU5ptqJrfA0CS7ah8VjsN8DsY/3bTkRCU4fURGi/Z+5HdbGZ7vsVm
 1CL+rjv0dTmO8CI128EYFMdHgfiRIVG6fUmJ+m9b9exlT/tqoMaYET9VsuVGmI1QBott
 OiL1qjcH8DUTWwJt31oi+Lox5/TUXap7WGup9nUj2IIybV4RE+m/8gdC4s3VZG5HC6K7
 jsAhjjAbPgYTEFuII38mkhu5a0qcaYhT25kiNFzAUjnWlwzHA2xMlMw30O6NVet0/eNW
 6HUg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGae6B25F7F99QgoDSUmMIS/MJzt4wH8GJF0M6AHUPNmMYMXmDzoGPpwbzPk9q6Gpmj5jc0IIgMv90CS1A@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwRBNoXuuaiLXspo7whSCGNgax5YkzSaHB/irrOMVTlR4nj2dhN
 +35HDz9DFZ/Fll/GxVmtrtSorOsXksD8JLuU73FP70fDPU0xmtLd1IoadJ5u16gOCXwonnqZ8rh
 nC2ojBX2LWPUYt+UkXatPZ2ndHmBSCWrP8GjVIoGMBR80pr5mzoV69Jmx+1wwRaoaygaSEzybPW
 mm7Yk1XQ==
X-Gm-Gg: AR+sD10uK4ZuNhEcdc09pQf5S0XMrL93Aos5/gvjTc8s6t611vTL+J45XGa5Ilng26T
 tmHPXYiEIvFe50Hk9qSCCnigdGpdt1c0x79wpzN1Bh2pdz0ILag0f/G5crtaVAdXh2rgdpzMRD1
 1RiOmDwHeiabvRgzAgjQacGYkOYSJCQtK2PAyhO4Yn32Pk3IwZHIkeoAze2pavVdLJm88AGINSy
 rYMp86CzhM77OMBdCvkDyU/GtIh+FBN+/HKyS1p81fHSnanExBKFNUtwDEsVDlJdLoAwYsamkxs
 RkkHTp20PGXshs083uFFSbl3mPe76qx3gLLYsnGWMVHIY0C8cBjj8UZCvhxiT6qCZo4oChej2t+
 t5z5CrSEhTsqPqLD6v/hWO23TKCW1eQDSFtlaN1snmWmvIYe6/AcY2Qj3ky2F41aNqDBEE/SI6/
 qEEJBiqx7fiCHTxJiG4vVfpZg2mF4VQz45MX4Y+BL8wgU53mrzYFxJI7ZpVQXIhNCu5VjzGRP+x
 VRHf4JSVEbcOuD5ONuU8XFyV8Sipl14FJiR+w7OLcNY0+IYMJ5zqn/wwyBQ2BYcVvPDMR+iblUF
 eF79AXQsFEVOawNpgIqV23FD+B+PCcxiyr+VH3Y2iYNSs0SrnP4=
X-Received: by 2002:a05:6402:3983:b0:69f:fa13:ed3 with SMTP id
 4fb4d7f45d1cf-6a403300de1mr1186617a12.16.1787126581000; 
 Wed, 19 Aug 2026 01:03:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14b80a5sm3972317f8f.24.2026.08.19.01.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 01:03:00 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 08:02:57 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a
X-Gerrit-Change-Number: 1756
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1756?usp=email>
X-Gerrit-Commit: f3ee55c8ce8c348bc1dbf6cc89d941ba8a29a30e
X-Gerrit-Comment-Date: Wed, 19 Aug 2026 08:02:57 +0000
In-Reply-To: <gerrit.1782741377000.Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a@gerrit.openvpn.net>
References: <gerrit.1782741377000.Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzQxMzc3MDAwLklhNGE5YTZiYWZiNmJjYjNmZTMzMWE5MmNmYmI2NGJlNzhmNmFhMzNhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <01df90991c6295487ef0c3c93091ed1319c01eee-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwbGR-0003JA-E8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_client.sh.in:
 Allow to override the location of t_client_ips.rc
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4847638228581463367=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4847638228581463367==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JT9dKKOsmEI="; charset=UTF-8

--JT9dKKOsmEI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1756?usp=3Demail )

Change subject: t_client=2Esh=2Ei=
n: Allow to override the location of t_client_ips=2Erc
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2

(1=
 comment)

File tests/update_t_client_ips=2Esh:

http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1756/comment/cfa9db31_08eb096a?usp=3Demail :
PS3, Line 4: #=
 for later use=2E
We probably want to keep a blank line between the comment=
 describing the file and the grep below, otherwise the comment looks attach=
ed to the grep=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1756?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
a4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a
Gerrit-Change-Number: 1756
Gerrit-=
PatchSet: 3
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Rev=
iewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <raz=
vanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed=
, 19 Aug 2026 08:02:57 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes=


--JT9dKKOsmEI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 3:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1756?usp=3Demail">View Change</a></p=
><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0;"><p>File tests/update_t_client_ips=2Esh:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1756/comment/cfa9db31_08eb096a?usp=3Demail">Patch Set #3=
, Line 4:</a> <code style=3D"font-family:monospace,monospace"># for later u=
se=2E</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">We probably want to keep a blank line between the comment =
describing the file and the grep below, otherwise the comment looks attache=
d to the grep=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1756?usp=3Demail">change 1756</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1756?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia4a9a6bafb6bcb=
3fe331a92cfbb64be78f6aa33a </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1756 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div=
>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Comment-Date: Wed, 19 Aug 2026 08:02:57 +0000 =
</div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div sty=
le=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--JT9dKKOsmEI=--


--===============4847638228581463367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4847638228581463367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4847638228581463367==--

