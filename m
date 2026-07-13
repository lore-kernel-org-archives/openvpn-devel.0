Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530BAC43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ggfkgK/xPyNu2QVbLKa9owhOcmCOdUUAwqW7nglOveY=; b=FG7f/sCWuzwVY8ihO3O0RpqfFE
	2R0+zpbS12tP89UluSwa+stkAz2jeHw2Zvsu2GKcG6eH4I3+Ef/u+3sLLpMbusk6UsbNdnpvRoy7K
	MuE8sunEL5sYQ+hEc/54rgeXbZbMfaAZ5AYN0q/xIOjf10iTmWr7qFEBl8hiFYgMT0Vw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjIKA-0004a8-V3;
	Mon, 13 Jul 2026 15:12:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjIK3-0004Zn-OA
 for openvpn-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 15:11:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=aAkeWFt1h/lP79w23UpAhhFTGX7EuDdFOxgek3ssToI=; b=h7UDtQmMC6Mwp+JFDB1jS3nQD7
 7xv8ZEZ1ZFxxU3aInRJBqUPcCMlf2eIE5yIY29jwJxLWGaWWXg2qEapKIyz6+Np93Z15tlNLfWanp
 wAqx7KOXOde8ugWC10sI9B0L6UwRUFW/f0xWMJx/skTLJbw0zUl32znxBoUgrUp1h7+U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=aAkeWFt1h/lP79w23UpAhhFTGX7EuDdFOxgek3ssToI=; b=H
 1G38fPN9ECeyPfwjIulzhJqN4wCpBS4RaZbkrkqiFw9UAE/0kg9f3ezN9PIJAH9NdIeNET5G9mnBi
 LH0bqQ9ebjkR/k4mCnKXSqrU5EFqSRBHAu2Fp2Ew/M2CpRdvGpwmh0iGWQMoRCBJkkni2LsJ4RDvK
 zSO9eG8sHi05hHrg=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjIK2-00022Z-Bp for openvpn-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 15:11:56 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-493e4ccccc2so21655495e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 13 Jul 2026 08:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783955503; x=1784560303; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aAkeWFt1h/lP79w23UpAhhFTGX7EuDdFOxgek3ssToI=;
 b=Xdb8nbr6PRtWmE4DapOBiRDXiduI5cZ1x8kyMXX3X/irzB21VdUopPIDgux3SAlD9Z
 A9j5Dzu864yLK0MeE3RO1Akz98OvlY5tCCjmkiMjUju2/9dWTJ8CQHW2JJG20Wc+/v/Y
 wu+FV9BaBZIUXwORmowVBif0UcvpfTwJem9/uFwO3cs0L9dzmpumSebqGbdrgW4sM0OS
 DtfkOojOKQy/fPKmekgsUyGUx1Kd+jGqrIABd7A9TAU1OKU+MPrmx/UzVS/vnJtaGVCz
 vHWfhUKWW9Dhqe6WV9HkPShe+4TJssggo9L5P86puhddMoW7Iq+oMoeCxsy2HQzw6W+j
 +H7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783955503; x=1784560303;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aAkeWFt1h/lP79w23UpAhhFTGX7EuDdFOxgek3ssToI=;
 b=fSKXdB0aA9qDxwCf1nXiiawGfuaUIcH+ngwnA84fXnANbNoO5b/WgxhwMooanF8saR
 eR7rd6+Wiktr5cpJBv0wne37PYqNXRkwTElc/FSzJGWLtQlzlGAqRK701r5WJiQQoTOb
 11T96UrB7S4aiq//3eQZZKHVPhQtDIxednvylp4y+GLxgXwYzGTGAVpFB+R0/YkSpNYI
 Qbf/g1XpRrPDw9w1S5ug7cwLOgeAMpqHWk33n0YMNp0hHedhOhmWsPgeKexLL/n5Z7cG
 OD90VCndU9Tp6Sae6T54q+3ct1x+3KQAL+nmjcFqlVtSAi9IXmLbtfLc2Ko/H2bt+EFe
 v6Ug==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp/7oFq5lWIYVDxTImX6DXZ1YuiF/468EQlPw5SCJHF4ia21vEjDxUzBbqn9epyPG/XLGPsKHEDlXm78h4l@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxpKMp7oR0DGfbJRUaDDv+sEaD7wJ6nRFRjNpSP/sKHecZSedVr
 oq62k5INLsLzOqJug1Y/30pWfE4ucxH/dXzGbJUbe/6E9HUgijC9UO7MD5faH0hxBtaN3AS50Ef
 OwmICJ9AVhKQcC7IahC3uXNUxlufdgkMzAUHjHMPBnwIkVGpYzBJkCdNl0uwzR/wMQbXOoPVt7r
 Ip1lDd+A==
X-Gm-Gg: AfdE7cnzDTDY1cqjbCvTPVjMgkeuqaBnHnLEQMddv6wM0iMldqydHRXkD4jx+YG2njr
 tnj1WhFyqA6sch0aLJqMp91xADnFsMNvUFEX/AFLvCb1HOOyhZh70iqEvLnHoYqKbAUN2vmAoKl
 jLjZA9OscesgcLyVQTJ16+RKgpgA+zFW6vqHCXpCvCOSEt8G6hqwjXh7UjTiIM2nFzrLFWwp1q2
 4JpCiGlHdiIobrMNoKWMEjOhRMe1/bCp7cbLimkoP+r1CavUiVb4/kMJLEeDRgPu3m0tCG8/HtD
 1llryr2cAEXJD1FJlXwjDwGAaRgnqrxMk1BlGZg2MTiEj7oA4gHhQQJ8OmoNdnwGQnb05unkH7P
 uEMVb2raODn4nJXkVqfVSSsrp9I5eItpwAdMxZEO/CQji6R5itkyu1LiN3Ax94EXhqhEj00vYQk
 Zmi8IwROU/ADQrthzDZHzSHUke/SicBX6Dn4AXIzztMyi9ToaZi01UbaxqHMHeEPw/p8eGb230d
 xuhVEtmk9xHzkN1eyOeu9DumOKWf9hCxM7Lh61JR+16Zxp3IakL8ENxAxRWpO3rMIXkNFFrvL+q
 MAY=
X-Received: by 2002:a05:600c:310f:b0:493:c601:3e23 with SMTP id
 5b1f17b1804b1-493f87d5d1amr93772935e9.5.1783955502546; 
 Mon, 13 Jul 2026 08:11:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634e036sm69980f8f.5.2026.07.13.08.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:11:41 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 13 Jul 2026 15:11:39 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf
X-Gerrit-Change-Number: 1777
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1777?usp=email>
X-Gerrit-Commit: 2c747537d1f04bced9b309cc9509e25ed1c4f30a
X-Gerrit-Comment-Date: Mon, 13 Jul 2026 15:11:39 +0000
In-Reply-To: <gerrit.1783945377000.I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf@gerrit.openvpn.net>
References: <gerrit.1783945377000.I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTQ1Mzc3MDAwLkk0ZWJlYjhjMWYwZjk0MmRhOWIyZTI1ZjE4Zjg4NTY2ZjgzNzJmYWJmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a741275a5a076413cebb9abeabebfb449958c2f9-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjIK2-00022Z-Bp
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_client.sh.in: Add
 ability to filter by test group
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8497523557365697071=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8497523557365697071==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hOjYkA2WMHw="; charset=UTF-8

--hOjYkA2WMHw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

cron2 has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1777?usp=3Demail )

Change subject: t_client=2Esh=2Ein:=
 Add ability to filter by test group
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(1 comment)

Patchse=
t:

PS1: 
I think this change makes sense, but as "just a code change" it i=
s a bit hard to find and remember (I think I understand what it does - use =
with `TEST_RUN_GROUP=3D2` to only get "2, 2a, 2b, =2E=2E=2E" tests - but ma=
ybe we should make this explicit somewhere, like in the example t_client=2E=
rc file?)



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
777?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4ebeb8c1=
f0f942da9b2e25f18f88566f8372fabf
Gerrit-Change-Number: 1777
Gerrit-PatchSet=
: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: c=
ron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attenti=
on: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 13 Jul=
 2026 15:11:39 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--hOjYkA2WMHw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 1:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Demail">View Change</a></p=
><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777?tab=
=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">I think this change mak=
es sense, but as &quot;just a code change&quot; it is a bit hard to find an=
d remember (I think I understand what it does - use with `TEST_RUN_GROUP=3D=
2` to only get &quot;2, 2a, 2b, =2E=2E=2E&quot; tests - but maybe we should=
 make this explicit somewhere, like in the example t_client=2Erc file?)</p>=
</li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1777?usp=3Demail">change 1777</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I4ebeb8c1f0f942da9b2e25f18f88566f83=
72fabf </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1777 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emu=
c=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Comment-Date: Mon, 13 Jul 2026 15:11:39 +0000 </div>
<div style=3D=
"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none">=
 Gerrit-Has-Labels: Yes </div>

</body></html>
--hOjYkA2WMHw=--


--===============8497523557365697071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8497523557365697071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8497523557365697071==--

