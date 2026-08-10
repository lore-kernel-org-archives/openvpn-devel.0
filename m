Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE96C5AC82
	for <openvpn-devel@archiver.kernel.org>; Mon, 10 Aug 2026 12:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JPQr43opdG+ZBb0EQK9uNQ3k/0fFN2lkIIeM/6HsyfU=; b=bHQGwcd2cjYQ8cptwtg93xxxzk
	gsxtE3gTb/I54RNqt2fg7tybyTDWaFrLTGB8zK7zzuLotGyzeHhPzWn0LXZGNzzE3E8c2/F++n0nu
	USWOGCiJMtf3wSsmEqhRZJgA3gDhLOWPF3wLQjBtHuhADQ0osC3kPx9xiHNWTMUd1Ud0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wtOiN-0008FC-2g;
	Mon, 10 Aug 2026 12:02:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wtOiL-0008F5-IX
 for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 12:02:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=GnnIp/x6oCsEFYzTjte+Oe1YiJ/9ixNGb79HVaXzig0=; b=fZj9gOqKPRWGRArU54Lx5jPgSa
 Nu8uAb0JtXtxiD0eJkWMekepPwTqmbWckKEyxN39ZEnzz+t4GuFVniS5wDymHJW8+Owofb+DXqh8w
 4qsGnT6MqJagPOfrvKwwdZJbupuFH7kyIjgayA1/9V5cu6tUxhoBStSjUZoeB0fW8vEc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GnnIp/x6oCsEFYzTjte+Oe1YiJ/9ixNGb79HVaXzig0=; b=G
 Rfum9asSmvaKdEPiDhmMuyC/3h9W3QjBXh93bYlf4MR00Vg41niHDiTau6N8F+r94/neUJMGPYxQF
 8ZgGGS3EiMeuliUDZybNeNYHcr4nv8YeCQLJHV1kvRlpDdg+LHTWDonGsyMxTEc0a5b8QluJKhxTd
 9lHNIgQhhEkC5290=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wtOiI-0001Pi-HB for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 12:02:46 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso29987695e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 10 Aug 2026 05:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786363335; x=1786968135; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GnnIp/x6oCsEFYzTjte+Oe1YiJ/9ixNGb79HVaXzig0=;
 b=TPGxuLYwB6b1oUGXal5g6sIC5grp9oFJJHHJP8A52f34Z7hywkBs2UsV19tBRkSCrL
 yMe9PLzCQC0WLPTRbhIflcjpsNwAnCJOAU+YQ08sR18B7PF9KZ8narG/iRi6n5r8TsnT
 ayBxbnzouO/GSYnjAP7zJneUv1X1EB6q7nAt5/Otw+Fcdz0bIcK9zoRaXJcbuZj1nDkK
 fSBfa7sqBIlasKLvougny3et8iYXLlArFx6dGNoSfYmKpf/rgL4ZxanY2VuxO9ql77om
 FFcgLtkuD3/k+ZAciegPlgKXqLSHZF4Uioq0KHyuMOor+y6KwhbNaLfHVR7yhogyxWJs
 Cfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786363335; x=1786968135;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GnnIp/x6oCsEFYzTjte+Oe1YiJ/9ixNGb79HVaXzig0=;
 b=b82Ewzg4SxD6e32Mn/zfAM2BH+cqtOdfivEr+bF+7MTpxoAGE6KfN892PY5BJTHw7A
 55KbcqvleqW4cFGaSNnKZf+5MKet3ILEG/OQLLn+WcauWvF+Ba0H873cDC969r0i+lIZ
 93kmPXyOXrF3WBwifNPY6v58QTzh3nTO4ZTJnC87LnU0VrtmXraaI6YJvLzJRTsMvFRU
 FIDHwOvpzJVLJ+rHz4wNzZ9UZX3qYbLen2UfQali9adhDotJ0jvRO9T63BZx6YSM/0Ol
 m5ybHl+YqNNLq5a6veOvisaENPp3ITHqN1uPDVg7a4xRf2ZVydtWcN+a0gRp0W+MiW0/
 iuCw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqWoso02HGmW4pn48FfXFmUjnwwNO6SAcypPTuftrQsHvqZigiGzZC3g4BckZLwXLDXUKA1oBlRPpB57hJ/@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz0YxivV1G2vURLQcSjG3osW/M0byZawryTMMCs/mIS3vJ1Ntgo
 Nzh0Gnmh3MFHyE+VMc5G3HHG5Et1gYdjElq+Jf6/PVPs2JKmuC11VNFGB80eOV73sJQxrQ4Ifd2
 Z80hCVfUS/joSMDOb6AfXcjuLeMVV5rarzz3+OgmfxEfzloBHbv25lB6cchVSsRUbr+DTbvgRzZ
 k4lUy71g==
X-Gm-Gg: AR+sD12hjfyGM4Fs7fiEWTU+jAdta3Kr9f2YeQYxRdmn5LNTZskW04HOOXZISneXUHU
 Y/rDHAP3iOULrj4ElysBdNc7Bs1voFjQSc7h2t+Pr0NkxMq4nMvxHS0tDdNxtWggRfAjLKyGE3C
 X/dKOS6d0X9VuNiiXIZ7Yguy8otm0qBTYBKWWFWGjEqcV2YQheMLUrmcbDdms6etJBj7T+tICkr
 pqsMeg90GfhC1dvvwGmncxUDfdisE0uU+pYIBixKm1M3X76eoxBfklasr2RVZ6PIJ1djrgo+28r
 c+NCQaaYWYHozcrarF2MMY6TV1G3VnlehnyDuRhpeptNjOxhzuMtUFGo2q1+fJlHTwkv761PLCh
 +SXThNBQKY8NuoC2EFXkeuYGOCy7twTFOX6DSTHM+0q0VTQvSOTuQb3qYAw1JHFAOMqoDMx0NMe
 8HWzc/aXUyi7I0cWwPzCBlEA2lvZOwqShd5wlOgvoasWpipIQUUNJjbDu70XdDd8IT5qcVPLsV5
 /TOOS6huQI+jWB+Exgo+IR1wcKqsgytS9+3IsCycU8Mv1F8nq/lvWRhMWtuLE4ou0FCtXJl47T3
 Vk8ye64RVdIaMSYJGcR3i5xEm4+BDEfsT3Z0r81CLmwDMyhPn/Y=
X-Received: by 2002:a05:600c:64c7:b0:499:728c:a1c7 with SMTP id
 5b1f17b1804b1-499728ca1eemr16759905e9.5.1786363334566; 
 Mon, 10 Aug 2026 05:02:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995e9e7171sm288059695e9.1.2026.08.10.05.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 05:02:13 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 10 Aug 2026 12:02:09 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed
X-Gerrit-Change-Number: 1617
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1617?usp=email>
X-Gerrit-Commit: 5f440cfa6725af843e25a622588fc010486667a4
X-Gerrit-Comment-Date: Mon, 10 Aug 2026 12:02:09 +0000
In-Reply-To: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
References: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1NDIxNTU4MDAwLklkMGNhYTQ5N2M0ZmYxYWQ4NzQzY2IyM2YzMzJmMDAzYjJkMzM5M2VkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <717c3057479139e2459449c658fd2ba88d805454-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wtOiI-0001Pi-HB
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove various
 useless assignments
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1757851026296812948=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1757851026296812948==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mqJuRHFhR6Q="; charset=UTF-8

--mqJuRHFhR6Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1617?usp=3Demail )

Change subject: Remove various useless ass=
ignments
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 11:

(1 comment)

Patchset:

PS11: 
> This commit also removes the i=
nitalisation of the buffer by =3D clear_buf(); While that might do somet [=
=E2=80=A6]
In don't understand your point=2E As the commit message says we =
only remove assignments of values that are never used for anything=2E



--=
 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23=
f332f003b2d3393ed
Gerrit-Change-Number: 1617
Gerrit-PatchSet: 11
Gerrit-Own=
er: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Comment-Date: Mon, 10 Aug 2026 12:02:09 +0000
Gerrit-HasComments: Yes
=
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@rfc2549=
=2Eorg>

--mqJuRHFhR6Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1617?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?tab=3Dcomments&amp;usp=
=3Demail">Patch Set #11:</a> </p><p><blockquote style=3D"border-left: 1px s=
olid #aaa; margin: 10px 0; padding: 0 10px;">This commit also removes the i=
nitalisation of the buffer by =3D clear_buf(); While that might do somet [=
=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">In don&#39;t understand your point=2E As the co=
mmit message says we only remove assignments of values that are never used =
for anything=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail">change 1617</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id0caa497c4ff1ad=
8743cb23f332f003b2d3393ed </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 1617 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </div=
>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Mon, 10 Aug 2026 12:02:09 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: =
No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--mqJuRHFhR6Q=--


--===============1757851026296812948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1757851026296812948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1757851026296812948==--

