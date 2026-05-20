Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30579CD4F3C
	for <openvpn-devel@archiver.kernel.org>; Wed, 20 May 2026 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x0OxIfgPKQL6ztSiUXKpLaKKXRuGqcafTRZ5E+c0gxQ=; b=lwZzZ1rdczJ54307EjVxREHKZj
	kVQaLEnvHmIBplJD5Xtg/LiV2me31L48RIEooL9VMqDliOUbh/zmRjMliOucXTF+q0+A+d/x7KOIf
	Mmhuf03e4+PBK1c+r8lcoTDSD6lOFl17zIBJnWFd9N6+CeaySf3FNEu14BxZ0M0Sksz8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wPjrZ-0007F8-Tp;
	Wed, 20 May 2026 16:33:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wPjrY-0007F0-Gu
 for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 16:33:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=pk6p/9sWGnACFueSCB1QvVNVL/yu5TVlItBMKaJqFq8=; b=Xthbk/dU3OPPN4MTW2wwLmq8/5
 QhRHv2JAJDdr2gGDFDxZzaYx1FlJ3lZU2zP8aqmxYVnrLnLGmEWt1/n8hjv+jSd5y0GgA9gRzevEX
 Hdh3O/M9Oduc5XjJdFRkxlPnqNSk9Zae214ozrnAknlHgPyAZLK/OGU4nGPkRiZIGAdc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pk6p/9sWGnACFueSCB1QvVNVL/yu5TVlItBMKaJqFq8=; b=U
 dbxavx8kxmDg7OI0/OD1VHVI9MqAj3FX4eAk/9uM2nsYnEl47mc2veM/sR14JSytsuGwoIA0MXeR9
 uexDQB3LtU0DoZlsYvBxvxwh7javnPMcNunDIBw89jitkw3nYQ1ky7vm8kwfFC0aTx6jXoW86ubHM
 xhMjvAvgoiKILLQ0=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wPjrX-0000kt-Eq for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 16:33:40 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-459bf19e87bso3106147f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 20 May 2026 09:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779294808; x=1779899608; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pk6p/9sWGnACFueSCB1QvVNVL/yu5TVlItBMKaJqFq8=;
 b=aZHDcoNvjj5ORaKAjmzFZczLwcEItsmInMi1oa+Lr4AByGSaP0e7XrVbX1wRQ+bXb0
 sKZf4zT7PFLAo4NQox2TSWdVdEq1LZ8dYQmBORjEw7Q2MExscvJ0Yd4xqvEmwxHu80t9
 6K/oAygLn+brQ+CSIabs3PPSGzf/6jo6y1cQxbzpcO+vXpUDtMbgugdnp4maFNtLuh5H
 ztLYH7TiYziUc7aUaLO2jBr/l0p4zr1/NsfLSTdMLquDocHvFqKEusRPfX33THucOw9v
 LiJNqlGNTMaZqAsdAbrpTykjrt+njbUp/yRJNc5aOvprk1YQX8cFrG5NIGp+20X4PFE8
 GhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779294808; x=1779899608;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pk6p/9sWGnACFueSCB1QvVNVL/yu5TVlItBMKaJqFq8=;
 b=m93EfguoJJgeGpeKDEt6MO8vHhlL2WXWTn9U2bwKdtUKZXwsUSwSBqpdGYwYQ0w/aN
 QEsf90OCzcDjeGrzYn2Bh4vQPNkGAjDgTVirJH4+ZVtr7n+OZfMml76E2J9urV1pZLRP
 EoaGMfeZEEWZdgE2LXdX/Le4yLTWUpTQHC3b9lvJqt6FTZamHO0JH0Xr86j+Q1fFBGvo
 0Qr1670IjEKFtAYrDngUMzvyVdGEpwZyEfnTzuIq/JU/1maaQzx1JfbHtEZR8SwDE62B
 ASCxFluNTcC7sQQTl6IidGKbYLzPbsY8/DsFGd30XvrCB/LZdkyskZ05NH6tNd1s7D3h
 iBUg==
X-Gm-Message-State: AOJu0YztyVn69Vq+IjlWLtiGkGvC86aAef3iRIKrd6HU/I+4J2mCZi3T
 0PlWqa+PXOgf9PNS5hXVNVwhRIZl8OMbDnWxF6Kes3yCGEMz5Q0ypo3+l6JIHsdXg1k51+OwFXE
 QkAdPsCGDlUYX1NxY04GfYrhk/kL6fJKxP5OrdZOM0uAU/EQg3o6fuVHyR+mCSFANfVBF
X-Gm-Gg: Acq92OFEkLJvlamrdmDBFLiLQy8EHuXu7a5CZXV8ljhSkWSpAkC2Y0uGCm4wU4NgLeS
 KvTFR0y2vIbrbkOI/HHWF8qcvzPuGQgSZyH1diMJxOb9n61PiFxNqEnyuqvPW5HxymqmvGOx+SE
 wy5bdKcU80J2Xke9XKB3KV+6cRO7Td+WAlOeQWkwHfY2AuL2HzXrZ/IZ5+g6KHuG3UtpxLyznnS
 fIa1NspqoZdtxwIWP5JzTQt32XndfQul9d8DSZweJ3pPIsl7nUJYNjiEaiZjzwB2V2OIbO8aDPe
 uGVWjcnSAtbnAISXHwT+4YEHFKxEAAYa0na9ZYp0ieIsmRoJ53eIyzRMuVIYNLgZOXv5WGR8W9a
 UfCISytWcCP27jRG31sxc81Bhs8M+7BI5B7i4EEv1Yaf3PXG5WF9eGey05Gs/EiwCK7Y7Cr4juo
 s1CaXx/hx+EGIa+6NtVA3dyd2MWCi3Ym8YCndC7VQBTdXwdJgwMonNxx1dUVTDBriibPSVNobrx
 eaArKWh5c8TuelLamEHVqotCDj7+xWjplwmDJpYLm2Oe6Tqq+4aVzlKeWJzapJt89VPOOyVKsB4
 bzYaTns4PQfiKe8VR6vuD2OL
X-Received: by 2002:a5d:5f44:0:b0:45d:3a84:709c with SMTP id
 ffacd0b85a97d-45e5c5ccac2mr40038836f8f.31.1779294808281; 
 Wed, 20 May 2026 09:33:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a17a22sm55755640f8f.22.2026.05.20.09.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 09:33:27 -0700 (PDT)
From: "flichtenheld (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 20 May 2026 16:33:24 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I70560efd113308b7377424127eb2c1da4266371a
X-Gerrit-Change-Number: 1679
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1679?usp=email>
X-Gerrit-Commit: 96d7c0ec791afbd3c412969bab407ac1a37314df
X-Gerrit-Comment-Date: Wed, 20 May 2026 16:33:24 +0000
In-Reply-To: <gerrit.1778963232000.I70560efd113308b7377424127eb2c1da4266371a@gerrit.openvpn.net>
References: <gerrit.1778963232000.I70560efd113308b7377424127eb2c1da4266371a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4OTYzMjMyMDAwLkk3MDU2MGVmZDExMzMwOGI3Mzc3NDI0MTI3ZWIyYzFkYTQyNjYzNzFhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <58d305df4c0d0a1049ce25e1631d1a3f0905c7a8-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wPjrX-0000kt-Eq
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Replace strtok with
 strtok_r
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1666182910651222842=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1666182910651222842==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7CiThk+QR+s="; charset=UTF-8

--7CiThk+QR+s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1679?usp=3Demail )

Change subject: Replace strtok with strtok_r
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5:=


(1 comment)

Patchset:

PS5: 
LGTM=2E However, I have not reviewed the co=
mpat implementation=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1679?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I70560efd113308b7377424127eb2c1da4266371a
Gerrit-Change-Number: 1679
Ge=
rrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-CC: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 20 May 2026 16:33:24 +0000
Ger=
rit-HasComments: Yes
Gerrit-Has-Labels: No

--7CiThk+QR+s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1679?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1679?tab=3Dcomments&amp;usp=
=3Demail">Patch Set #5:</a> </p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">LGTM=2E However, I have not reviewed the c=
ompat implementation=2E</p></li></ul></li></ul><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1679?usp=3Demail">change 1679</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1679?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I70560=
efd113308b7377424127eb2c1da4266371a </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1679 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: flic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-=
Date: Wed, 20 May 2026 16:33:24 +0000 </div>
<div style=3D"display:none"> G=
errit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Label=
s: No </div>

</body></html>
--7CiThk+QR+s=--


--===============1666182910651222842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1666182910651222842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1666182910651222842==--

