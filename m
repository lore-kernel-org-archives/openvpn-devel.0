Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D612C5DF81
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pxV+gGqEG7ez1kYb2fgIaDOrWzCvItBnwqLuPzCGgZE=; b=dym2+pPFN4UeeC8By3FaZnMK6z
	BFqS0ZfiQW21Kgf64B2FXPh56/aj4dF/8ZBQPzJJPhSBpKRD9IDXqxrpy/DuQ53i1WlJw74UYGZL+
	guMtInDXR6jnj8GFLJzmARv23X17nKzIPxqYENY0T8RiuHF10IrwEdqzheM7qxEMXAuo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwiQI-0006CO-LJ;
	Wed, 19 Aug 2026 15:41:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwiQF-0006C5-Hq
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:41:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=0031ERgJDgTpzmEs+cFTuf4r2q/6iOCVoHeZ9UomsjE=; b=RrgXvzMgu/w+MEwsYfJ3y2UT2Q
 6/h871RGcSNC1J3yZBkyGSwH8jqh1ynCuuZJkN/4bhfwHI9MeUe4lenk88TOmKAExcyNQMWshbyW+
 c8LbaO+VGF1dogS3UfJxENaj0iscya1Iyh6TJVxOROa34ydzpeFYxpzzWzH+fXgsfZS4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0031ERgJDgTpzmEs+cFTuf4r2q/6iOCVoHeZ9UomsjE=; b=R
 cf4uTzMzIMbBXetUrtS+K2ZjM3J1ykdPrjafi4zhFTtUx2Ah89cNW72Yjk4xtRBIiA6coNQuuYPrl
 O6j6NeYrWUuLjc0lM2aFKcGvym+syFMqximjY71e7Gk2LBXM5q3vkTLu0aYTJIlIzT0OOQ/iTMrSu
 F6uZoozDONC+BVYA=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwiPx-0007sK-CJ for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:41:30 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-499ae1c6471so5020655e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 08:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787154083; x=1787758883; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0031ERgJDgTpzmEs+cFTuf4r2q/6iOCVoHeZ9UomsjE=;
 b=Qupd1FqbLJVM5EM9clcXbGyGx8+/6kUuvVh53Idy9Bww4mQxPfxE8XuGJRqRIIbCo2
 tmdcu3SGig5HcIFfjc21kBL1Q2kq8D0QOj5fzEOJDnUgdS+1oYBu/nmCrZkpG4FXzlOn
 GGhndkPcYv5qfwPyCfLw/5PXza69pyHYlvO5UdmueR9mufc2IkyU0iyg1YsGJCaZqfiP
 vcocdZXO3yiR+HEJ2x3Ay67v59tNHLMopSVVXvPElVPovTQu+Ae+yuTNunRJcyfAZDL9
 qDsz50rhabo7+XgtnMjhNknSe0OIzVrliafYogVkl3lW/1AO9fcJnlABSbwOzUsvmcoy
 dMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787154083; x=1787758883;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0031ERgJDgTpzmEs+cFTuf4r2q/6iOCVoHeZ9UomsjE=;
 b=RIMdSQYhKIE8tKHvMiAXZohmSsIs3Nsqcuz/HdE/ZlLpKiuky/TV8VwqqzQIoTxyHo
 tz+zDEfZOP0T5dly0AZbplEKvgsdEdMTQkPmAcenopd4sT8QHzJco1ofCdZH8b52xzDa
 6nryKkjZ19wRKBZsT9PZKdUZa7eZRSMVU32jovO3aSUPCm5dX9TKXpbVmIq4WDHndvmf
 vjYtqAG0Q1jUULG5+vWjaOqa7JqXdz2HVmMo0yv4ZfzLo37/V92p0U9b2Kc3kiH6i7T3
 vQ9TxDQd+iwz+MXI7r2cDkmTEJRwaVM3sNCgz+pNJBW0hjM2bQnSpSaw8ZL5pzwPnqEj
 xTpg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+dWGyyXuXnFkdRMMVNo3oQypCKTb+aSUgeqmWoBI6SJ0F8O6Q6Iu8KkstFirlvZFOpmMxHqmZ+f8Bth0F@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyENJJ4ARfNp43f4EwAA5PBy5CfqI4HEKJqbLFOmfcTS+yAcNTy
 M5xlpvfCcCN7GsrQLWey/rrhM/zuU8kNd0mzI+vmHG7JSUq9UEhF6a8rENSbK+5R8AWdicMJOWY
 3x+bLp3wu477OrlbafMjfDes6fGWcfsIT8uPNyOzYIQAnzVaQjqnTjihfH7ijzG0p+bsUmytKdt
 OyBCaheA==
X-Gm-Gg: AR+sD128JRdmZU5IqiyqGjOSPL8zETEBUilMUQUMXnIYWImgvE5wnRN9Um5VjqkvatS
 R2CoUm1lasUxwO/M5CB1lZfcRhUzASIjS/kS48ki/KF8YrLVmZjADe2rHNs9SUxe+FonmMb/Dkv
 Jeo/cyhUCQqrdL0u5pxFCrdppP2eAwJpqn15slDTMyjKblPR4v/muHiO8+OJMyyVhK5ZHd6iwj8
 E7D0ugJxSftURikjRSPmwETc4le8uw++JQ4egVge08/YbWiq80KOdBAMDGofc6fiAmTtqpRFpay
 ivwp2w/nV45pixlkxU1so6YlzITGF0nbP7bO3Vov+5mtDwngbTUCV6dRJw83ce535Q03sL9e+uV
 9tC3cwKrjob/FYleMGgoP/nip7MOexgLO+uaO7eM/tecWNG3/qDI8flxZDHV/uGAMtSRFDaZDCG
 NZ6uEu8/HF1utkz7m2kunxV6ypFRqHCyyepZwqYBOz03KanJ0J0fuwY4E252n6S7SjoJ3uJfb1I
 veAQdqa5QUES89XF/FHJeA+uy5l+5SgqqlMXVEnWbfywip3OwNMedngOA7TPrK8XWNA+zsTBRjg
 0Gv6onkuD1fm+jvhVMWRKlYrdoS/DyHpWTPR6Bu6adKpu34dmXg=
X-Received: by 2002:a05:600c:c490:b0:499:a5c8:c6f3 with SMTP id
 5b1f17b1804b1-499aa143b7cmr99696055e9.3.1787154082691; 
 Wed, 19 Aug 2026 08:41:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9e784a4sm69778925e9.1.2026.08.19.08.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 08:41:22 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 15:41:20 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e
X-Gerrit-Change-Number: 1774
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1774?usp=email>
X-Gerrit-Commit: 3e9ac12d79222f17b2911a834dd5c473ec6578cb
X-Gerrit-Comment-Date: Wed, 19 Aug 2026 15:41:20 +0000
In-Reply-To: <gerrit.1783600902000.I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e@gerrit.openvpn.net>
References: <gerrit.1783600902000.I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2ZGFmYWI3NGI4MmZiZjc3MGMxNzk4YjQ4NTFhMGZkNWU0YjVkODFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7aaff05b1656a92141933119955860a692fedf10-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwiPx-0007sK-CJ
Subject: [Openvpn-devel] [L] Change in openvpn[master]: options: Factor out
 file access code from options.c
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
Content-Type: multipart/mixed; boundary="===============4955944965887447147=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4955944965887447147==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eHtQCEZnx/I="; charset=UTF-8

--eHtQCEZnx/I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1774?usp=3Demail )

Change subject: options: Factor o=
ut file access code from options=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5: Code-Review+2


-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1774?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e=

Gerrit-Change-Number: 1774
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-Comment-Date: Wed, 19 Aug 2026 15:41:20 +0000
Gerrit-Ha=
sComments: No
Gerrit-Has-Labels: Yes

--eHtQCEZnx/I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 5:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1774?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1774?usp=3Demail">change 1774=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1774?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6daf=
ab74b82fbf770c1798b4851a0fd5e4b5d81e </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1774 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 19 Aug 2026 15:=
41:20 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--eHtQCEZnx/I=--


--===============4955944965887447147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4955944965887447147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4955944965887447147==--

