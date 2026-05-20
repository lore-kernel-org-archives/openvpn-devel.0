Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A40CD4F3D
	for <openvpn-devel@archiver.kernel.org>; Wed, 20 May 2026 16:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:Date:From:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4HMHExSLQuGrPuKQGW4fvdJJYQjn34GSHzLfIjRoHHM=; b=GBfZaUr1BCXAdtPZYA0vhmG7JV
	4OchK1Cg0droRplWVkOHsFGv/UngiwOScauv8DimoMf0ouKNB995vVAwnq62WytG2sFdiypSYeXBw
	zm3YwoLdLKaJLkCMuUZ2r3ceO3dBlibC/YJncaJf6iOwq0wgOL9EE/p9HvhDPngNrE/U=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wPjN7-0006bP-Ai;
	Wed, 20 May 2026 16:02:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wPjN6-0006bJ-96
 for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 16:02:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=1PlGNjb5UniF8Rd09krG3IZI3tH+B4zaUc8iTRgG3Wc=; b=jjhvEr7gdjJOumSwV9dFMjVz2p
 1PJccLUCZ88q/CNq+psUrNMdoJI8s/kNuo6ucO8kD4XGcP6PwdETSAB8uAGo+OaR0CkdiDStmsrKK
 MMI5ibjNDN3qtZjYkf31ncYVuwqnXpPA8KmxCRQr/PP4OXhYsxrIJGQLe3vcfxjvBLEU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1PlGNjb5UniF8Rd09krG3IZI3tH+B4zaUc8iTRgG3Wc=; b=a
 A62A+MTWrHATqrnauhjqorsY3DnVfZaHuOma4G5BtjXEyVWE0k7yQt4m4SneCmkIfvuFBv3dHHAy2
 jDf5FBT3Hq45BykNMgrnXf4CDJGxn2T0g+gYa0Cz/amc73I9eFd3xFpN6rkxHTvniddw0ZePlY5zP
 2QQwkQ2YyWR6cIMk=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wPjN4-0006vZ-BE for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 16:02:12 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso38200885e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 20 May 2026 09:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779292919; x=1779897719; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1PlGNjb5UniF8Rd09krG3IZI3tH+B4zaUc8iTRgG3Wc=;
 b=Z9idZXy6V07osdkZDJwAV4VYoLoccYiooOYM5xZ3s2D5aolc7wELt5PBhpkScqcLK9
 xDN29IqM90coE7H+B6O1qpyMpzTrKW051OTFK+KiiGXema9kPWA+qFoNVxDKF6Tdf4Bs
 bKcU2MViibM63pv9VdMYnTqgHWXp4HVwIiqBWSGc/+8pGbaAva61oMwM55n0PKr2XyPv
 3PAFhHscKKzmAMY7j6kkjRsjjCXaPcAvdlkHHZtdtHQfxLoXLyBvNRcfcMMr57I5atKT
 kx+nHL4sMU9B+70+eJKwEQGcBkMU4Xq86o5jkRtX0vfC8U/rKlqERI5qBXNJc4V6ZcZh
 bgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779292919; x=1779897719;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1PlGNjb5UniF8Rd09krG3IZI3tH+B4zaUc8iTRgG3Wc=;
 b=GQSfdHIIxN1Uak4uEFysZhYXnVzmcQaDEf/mD+j6rcpyRWZirD5e6Umh/Mu/9WQdGO
 M7izXTLAeWKaMDfXFhL/DaCHjDIxMacK2UTwmjjRLguHCWCdbdatu3U3KaalUovjXAQP
 tjIXEFeT88dTwu6XaIl709MOcYG6/9SXMFc81oHX7FyLHNNO3sGoGAbIcyISX3FTQtDV
 GXZQae3ABledbKyZfElIRANBrWB/nuSHxMyBUUyelBK1TuSvv7cgzbMoI4r0XpO57MY1
 mCUM8Gbp+2OnY3EywqbBg+wRK3nIbOljk2zycuQr+0RpbtsZSAw1prl4lkJKYuuWXNfA
 IBgg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/HHmOVJV6D4CYKdphYGh0pveJjNwvyF4hiv9YuCLC2EmhcDllzV2Wf0SGe934CS2qjwOP6M4C8/yvNHT5U@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx8pWmnJX2uzAIYPKfIka4N01dowdwe0BgmSyYyhUdXnqtgPisq
 0TS3fMV2NeszF5pvYxUdceBFn2qf3GK2WeCXFCsvaC5Os+RHO9DFobXwAgiiK1f4V3EiA9swX/x
 wpUO/WlAsoB6i924H08ZH2Y9eKpvR9b7M+QqC8UtepUv5Iv/VbVPJ7ZE+biHn1uB6kPJtR+KsSP
 W+bBRiJg==
X-Gm-Gg: Acq92OHycFfACGIB9kwNr9D6JZz/OD3ef0es43dxduOSxQbQHBOSLmOM3/dSyoGuVso
 0YilGdmN3iVq+SUlg6Z21X83T+M7jFGbkFQl7e8F4KDcuAm7l0CSl4p0+qrnjri7c4vIZXvT4IO
 6tyKe8c2qSIFLZQu/wB9m/wykw2/M31zPwpsXvAa5ERe6eAINNmy1HF/yx+EZlh1i+OJ2DeJoKs
 mCgfjvxW407/s+CYeOu0LhROXLXMwMfiGLx/jvKFa0QtBtCPE0h+otL51Es29hpQTofihV9yt82
 /Ae2BgdnWc5M3za18pWQR+h4X9MqjFA+02tfHDGIgEM7Kggg1Y74S0Q/6BvqcLArPvsL66U/DLf
 zxN3Qzk/X5qKk7EGmnI5x/bE6hWRSq8LGuVIRlRhteBohsLqP/DPcU1uVul0DN5zKbV0MU6VgPK
 QjDFOOs7t9YWm/GIIm69vx+i4QosJNYTufmclwnEAAXe9IKgnSs+mqCEneC2xV6GSNiGRpi63eJ
 kfSQn7qVFxrjduWtX2t481PZl6TKN9qx517ITs7ORWq88MeMQtvMkqsnReazWk/BGgXxZlypOQQ
 YaL0QiIEEduIjFdZq45vl3UI
X-Received: by 2002:a05:600c:470e:b0:48e:8741:fd3d with SMTP id
 5b1f17b1804b1-48fe60ea21dmr354352455e9.14.1779292919004; 
 Wed, 20 May 2026 09:01:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d52c8bsm1458725e9.8.2026.05.20.09.01.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 09:01:58 -0700 (PDT)
From: "plaisthos (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 20 May 2026 16:01:56 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I70560efd113308b7377424127eb2c1da4266371a
X-Gerrit-Change-Number: 1679
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1679?usp=email>
X-Gerrit-Commit: c2db2045f18ba56609fadd81e23bf1bbd5830f11
X-Gerrit-Comment-Date: Wed, 20 May 2026 16:01:56 +0000
In-Reply-To: <gerrit.1778963232000.I70560efd113308b7377424127eb2c1da4266371a@gerrit.openvpn.net>
References: <gerrit.1778963232000.I70560efd113308b7377424127eb2c1da4266371a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4OTYzMjMyMDAwLkk3MDU2MGVmZDExMzMwOGI3Mzc3NDI0MTI3ZWIyYzFkYTQyNjYzNzFhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cd976d57b12cc298823843829d0f6dcfc2a68a6c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wPjN4-0006vZ-BE
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3066810638477842751=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3066810638477842751==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3uAqWG8HLaw="; charset=UTF-8

--3uAqWG8HLaw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1679?usp=3Demail )

Change subject: Replace strtok with strtok_r
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4:=


(1 comment)

File src/openvpn/options_util=2Ec:

http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1679/comment/9ddf5d84_137b19de?usp=3Demail :
PS4, Line 5=
1:         char *lasts;
> The Linux man page for strtok_r warns "On some im=
plementations, *saveptr is required to be NULL on t [=E2=80=A6]
Sounds good=
=2E Will amend the patch to do that=2E



-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1679?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I70560efd113308b7377424127eb2c1da4266371a
Gerrit-Chang=
e-Number: 1679
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-CC: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: op=
envpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: fli=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 20 May 2026 1=
6:01:56 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Repl=
y-To: flichtenheld <frank@lichtenheld=2Ecom>

--3uAqWG8HLaw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1679?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/options_util=2Ec:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1679/comment/9ddf5d84_137b19de?usp=3Demail">Patch Set #4, Line 51:</a> <=
code style=3D"font-family:monospace,monospace">        char *lasts;</code><=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;">The Linux man page for strtok_r warns &quot;On some implemen=
tations, *saveptr is required to be NULL on t [=E2=80=A6]</blockquote></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Sounds good=2E Will amend the patch to do that=2E</p></li></ul></li></ul><p=
>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1679?u=
sp=3Demail">change 1679</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1679?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I70560efd113308b7377424127eb2c1da4266371a </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1679 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Wed, 20 May 2026 16:01:56 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"displ=
ay:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment=
-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body><=
/html>
--3uAqWG8HLaw=--


--===============3066810638477842751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3066810638477842751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3066810638477842751==--

