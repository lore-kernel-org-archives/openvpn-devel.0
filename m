Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE2FCDB46F
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1grPgWcZf12AZwIgRUaQflqKKGNhNxjwuf0XoVechJM=; b=FBbg9lOqRRAIqOMqyVGpdR38FE
	4rAvO5OqQaCbdboC1LTljxrMcSJVtAVG0vxVDd4wmQcgTINYqt4BSXQj3kH6/ApbzU9b/FJvyJ49d
	ybQYnB4WvXK+uF9TWIR616VeYx9ShhCuwyiWgrY1kQgXTVQFxhXSQmP4V21jma8vAehU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbegc-00015B-Ia;
	Mon, 22 Jun 2026 13:27:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbegb-00014y-BZ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:27:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=SHbjP87/+IwFwJW0GyUDiLDCfB/iSiJNjH0Mk8XcDBU=; b=Ehh4SkXWIYu5T7h66V3zKRQH5N
 WaPTGlew+f9yqEcZ4UPRE0KX2pG+6pTl8X3S6Nlfp4FbpDCXy+B+dEu6oXVeWxohJQHiCXh8Pf3Ne
 vkku2oSO2hOV2ceO7KzJH0JJphWnyAy8DLP5K0OpRTbcrWRBLL5fQ1qSORWqeYseDcmQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SHbjP87/+IwFwJW0GyUDiLDCfB/iSiJNjH0Mk8XcDBU=; b=P
 JgiOiRFiGx4OmelgvlHFHSayGjiLekKfz6BV7vZjMSCf7Mw7iGyrre0giiN0Z3MLgHSG03FPlqgsD
 UM+OIP8f7liHVZCKVsd7OBDuWU+SsV5HwVrTHjL3HNBU/77aYTBU1Csf8AHWqULbuhw9HSuhTYmsL
 cT+NBR2kUmgfoJIs=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbega-0000n7-4z for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:27:37 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-45eeba68948so3331885f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 06:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782134845; x=1782739645; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SHbjP87/+IwFwJW0GyUDiLDCfB/iSiJNjH0Mk8XcDBU=;
 b=g55B+7fpfe9BVr8yuSfvDKYaI5pC/d/hm9dTJ1/RctWJuznP/4bmx15j3Gend/B4vd
 gXTz1XK0WksHfs8qKk0YA+1cIuNJjwfZKIyrZISb/UuhtXh4YsfHlcgNpFZp5tVs2dor
 jOOBnaoLQ4My7hqe0VK5OXjbUNI8sMwOv1k6cKELyDbxWQsPBtJFx6V9fQvR9FfAwrJ4
 09Wl+8JwtsXP8aMN/XiSAikEAbH0uYAXZ6amo1slvQonQMzOv9t9y9URgZiaLVIpdmzd
 4vrrQ+ECSCNcpkHttq9/GdEf/R64R3bdPhh3iUlZ8QuKb/FZh7Tpxqe6BgOLRAMmSXS5
 feFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782134845; x=1782739645;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SHbjP87/+IwFwJW0GyUDiLDCfB/iSiJNjH0Mk8XcDBU=;
 b=kGT8acfeOCZJDaZsm0KAzF8thV1x3hbmcmei8kNKutmP6NeNuti6w+Gu4PyYI1aNlX
 pgA/w4UT5KBspHI783xsaJZVUHXKr4FxUEgkNsgVv02f38pehJIjxksv/rMA2Pka6Ix9
 HXPDOveyIUt47DZ2JAPFzT8MCPk/J7JwCoDqSp9oMsWG/wINLn6cYPhEomKqK2rhjxP+
 C0MpHsXQh1wIwcPcgoeXLc9qZFUP37eJyoC7O3Qr48JNmDt4NAyjgc2p+gDm3jn72U9v
 6SIP7skc0inwhmdsa7qSbWeLeOdm99j9ZXUlLSr1gtwd1hlQiWi7xtmcMHBsnECm7T0/
 GJ2A==
X-Gm-Message-State: AOJu0YwgeIiKeMN+pWTVPVAOkCDe9wGHmdfU6XvY74FiahIy+kcwUCrR
 h+5PDwTsj5HnFApmeX5uKSTzNIsiOOTlGoUy/LK7WoIEsRigxrcCuN4bh0eJ3sGgPxFqgUVqmDJ
 MdKCGTFSJiDLZQ/7tF22/9m9UXO9S9geUb98GAq1WMC0CPCTlb//WksV1/TE2EtFnzveuM+jnH9
 GzaBH30Q==
X-Gm-Gg: AfdE7clxj1UGV4HFWchECpuaKMOHXz64T8zl+KXxRN8PpDpQ8iXPrjDymarhsffd0B3
 Ef5Wk4EO4o6E1WBKYprYtv4rrMbZ+zDEJC0iOzLJ4fjdoQnlKH5GStEIYs9ZQt7XjbVs4kIy8t2
 2mttmeOoE/HWPDhH2fOep4rhb187I+FaHyR1p9z6T0X6zWs0dlZNG+ZRrpdYtBgcUn6tGc5XNBb
 7zloQ4CFQZAsSX7qtFkbv8VgrS6djd1vVhiVNA++Qk+iMJFdckhDgtlD8wONaujgb5D3smQTaYD
 jvykzlwqGtjZMu7TZWba6TtfADbO0gLYGSHXfKn2xWrhMEYb53TpFkxLPUnwR3Geiv1o/gAZ2OZ
 sD7ft93Ds4QyVv9fEf2tHlpYTjHaDiJZxcD+dcY3Xq6/PA/gWL0pEbgPmAtF1p9stLU1z1N/lnC
 TRLlZ1rqgDuFhnRTyHDdHEiwyZx9stKwVPuoLR3ZezXWtAFrWQM18aiKomFPYAuAEZnHsnU7igR
 8VNbb6zLqrDGwzSmFdOHwT/HbR3FgBGYiyrxqOKR6uM1FoJN3+EFHD2zgEHy2K0aL6jqUgDM6Bj
 6dw=
X-Received: by 2002:adf:ec47:0:b0:45e:a0ab:8bcb with SMTP id
 ffacd0b85a97d-46506950bedmr20094688f8f.15.1782134843871; 
 Mon, 22 Jun 2026 06:27:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666c57902sm26671163f8f.25.2026.06.22.06.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 06:27:23 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 13:27:21 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I355760e43c3e2da0dda0cdec6e4253c028cefe38
X-Gerrit-Change-Number: 1604
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1604?usp=email>
X-Gerrit-Commit: 3d4d3c880b6d2fb4ed23cea54cf2a618c83b51c1
X-Gerrit-Comment-Date: Mon, 22 Jun 2026 13:27:21 +0000
In-Reply-To: <gerrit.1775130235000.I355760e43c3e2da0dda0cdec6e4253c028cefe38@gerrit.openvpn.net>
References: <gerrit.1775130235000.I355760e43c3e2da0dda0cdec6e4253c028cefe38@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1MTMwMjM1MDAwLkkzNTU3NjBlNDNjM2UyZGEwZGRhMGNkZWM2ZTQyNTNjMDI4Y2VmZTM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7d6cdeb5781cc36160cf6b9253109846013bb9eb-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbega-0000n7-4z
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix building
 wolfSSL with CMake
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0504538186410858820=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0504538186410858820==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Qz2Av9v5bbQ="; charset=UTF-8

--Qz2Av9v5bbQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1604?usp=3Demail )

Change subject: Fix building wolfSSL with CMa=
ke
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 1: Code-Review-1

(1 comment)

File CMakeLists=2Etxt:

http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1604/comment/df9f3af2_b463a3a6?usp=3Demail :
PS1, Li=
ne 328:         target_compile_definitions(${target} PRIVATE EXTERNAL_OPTS_=
OPENVPN)
Since this is originally set via config=2Eh, it would be more cons=
istent with the rest of the code if we set this via config=2Eh=2Ecmake=2Ein=
=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1604?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I355760e43c3e2d=
a0dda0cdec6e4253c028cefe38
Gerrit-Change-Number: 1604
Gerrit-PatchSet: 1
Ge=
rrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Comment-Date: Mon, 22 Jun 2026 13:27:21 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: Yes

--Qz2Av9v5bbQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 1:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1604?usp=3Demail">View Change</a></p><p>1 comment:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File CMakeLists=2Etxt:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1604/comme=
nt/df9f3af2_b463a3a6?usp=3Demail">Patch Set #1, Line 328:</a> <code style=
=3D"font-family:monospace,monospace">        target_compile_definitions(${t=
arget} PRIVATE EXTERNAL_OPTS_OPENVPN)</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Since this is originally=
 set via config=2Eh, it would be more consistent with the rest of the code =
if we set this via config=2Eh=2Ecmake=2Ein=2E</p></li></ul></li></ul><p>To =
view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1604?usp=
=3Demail">change 1604</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1604?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: I355760e43c3e2da0dda0cdec6e4253c028cefe38 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1604 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Comment-Date: Mon, 22 Jun 2026 13:27:21 +0000 </div>
<d=
iv style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"dis=
play:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--Qz2Av9v5bbQ=--


--===============0504538186410858820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0504538186410858820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0504538186410858820==--

