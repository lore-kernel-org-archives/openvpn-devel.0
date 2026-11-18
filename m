Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCD7606A320
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 18:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NldntRX8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=feHH13Sv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=G8YiYhkb;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=fgl3mmKq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=HgGgwX/9Zo9laqi/aSNZli9kuqR8/JrK5a57T0K4FeA=; b=NldntRX8es3dw8Lv8qTbfTfSEV
	LeeNktbcOc/IR5HYIAnmcGstbSyFV6J5FnV62aKgbXHyGYYcBd+coAWF5D4OHQFVhHNDZTt7dVfVd
	uANP608D03Injzl4E9VcRHXqmf3pcFJGYWLZOpRIUdaHEXXXYWXizA17NNNG26POFUWY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTkAg-000000005UC-17gN;
	Wed, 18 Nov 2026 18:14:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTkAe-000000005Tu-3BEh
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 18:14:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I92Da7amyAzvBmX1EUdjVu47zXWYr2EyF6r1OqHPTi0=; b=feHH13Svkcl9IlKWSN+t8YLVRh
 l6UkqZSq9Q0yeHj9Tp49seDpz5Tk4BTQgtdZf+0KclWCXvNt+zPgrOmKU4MaEXPvQ+75pUSBV8pyg
 mcuvKP6/9zceCxxxgya43i7A5cM5Erdme2GWUtyWYvHm8OrtUxBcc7m+I0pZmdrSbyaM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I92Da7amyAzvBmX1EUdjVu47zXWYr2EyF6r1OqHPTi0=; b=G8YiYhkbiD/x/WduGqFCwPcZ2L
 r01kfExTdgTePOT8DYR2J39P14iwlrvCbLHEAwc+zQ+8Tum4lkfYMjoE/Drl5xyPYoUXSrrSnL8LX
 QlpQ4VfKXfDb7xxTh5H+PnTcEHE/DIrd+6TsqL8vkWk9EQeejByCWzzq5o0OI9QLNVuw=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTkAe-000000006qH-0OjO for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 18:14:12 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa88so893944f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 10:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795025645; x=1795630445; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=I92Da7amyAzvBmX1EUdjVu47zXWYr2EyF6r1OqHPTi0=;
 b=fgl3mmKqg6/v2O5Xg8GG1Unmyzg5e6pv6C+CCmQVMeUyolfsnxB7i04j6HKaJGsjUK
 nGhM4IPljFdqm2FHbPHLZCrCNKUNK+ws4O9TeKjYCEADrtlTDn4XnZWKx4GUDASuCXJ+
 JIZqoJ3sjtpU3fBEisuPOr92w8/VucvhJVCmYdPpn3tyAGA7TYLgpJkHxOrgsjUN5OvZ
 lxCyVsVQipX05VYWA2/qq9RsMkiP9uOuF1zNJlInPTK1xoeqW+Rw/bZQf/OUtCUaa4N9
 NryJB708ApRJuYFXNDitq3sGYp8QXkWFK4yr2xuET07zUmiUsWbDMcWtiM052JN0zj9q
 Z0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795025645; x=1795630445;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=I92Da7amyAzvBmX1EUdjVu47zXWYr2EyF6r1OqHPTi0=;
 b=m51c2A0pxgxQM/w+Ly0Iyqj6q2MsS+5aHFj6o8Txxvt5/5aKFHkjZfnwPtsN9ZiCon
 GRifsVPsM7nmbKuFOECLmqZSlDX30JyFf9drDu4G+2rHNncz8e+Um8U1txUJBwEylC03
 zPz3lu/onKgAI5F8cEWOGsqQRTDjFh/ZevhlUBmorZkT0HHxz7lXuouLi/kh99mrO+EJ
 5SoW9YFQ0DPE0ai7WYPTJc9tYq/CFArAfsoAw23beJOqJQBFlW6PbrHv+k1ZiI/ALDwM
 O16lt2cr7S94VoHY4Qcr+3lS0aa2Us1f/tYobLv87la/29CBzufNIiyzQLpzZywU4YKH
 GebQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGKI3/n7a+byY1AC5cN2gpUCr8kUL1ls74YQa7HbGTGmss5wmp2Z02OLoCFp/LcF3+Pkwsh8qX1kZA19upi@lists.sourceforge.net
X-Gm-Message-State: APuU4Z92jDLdL3XE8H9msAoM63pgCKjFc/Qai3JmFey1kWWY03q9S6fl
 ttprRxXwJLPXmMNDmPkPA2YCnzO0IHql8xcn2VaYCbrSyEDg1egBJpugUdnU7nW9Q9Ts58+2I5l
 eLw9NcwFHH8GZ0/miWu6Mfm0dKx7mw87Hn/lrHiCzeKyO3dGpQzgKYl05TwjtRdPOR3X+
X-Gm-Gg: AZFdTZcyUziDZG08ogtqTT4FQINcQPxPI15GGlcN8rDBZwmLb7AXqLT4nZXDXhb2mrN
 sNjnzeuptHtzBEQRZo6vNhTaD39lI/AAnMAlUNg1HKyvVDM5JDoby8eyhLAKq7KQvzEfDBOHksa
 lAsOYjQcU7euoxQADq46nbRbsbIvdzXJROyanrc0tHbfcS16g7tGpQpy6Of1JDJg5JoXzJiRGsd
 1uQ2e6eNFnLL+SuqVg6R2nSyiJKE+YcmT/cqOe/Blu5CYHXBlRgpS1bjUYxnvIF3lPz/jEFbZ8w
 FSmJPNb0S4qMGlqi5/IV7DlvFPxmCXsUPTzP9Ng9tpWAjS5tss76kxVSGCAKf57iturgZHq/ac8
 kZTjUnKoXCRbAG6eaf8U+8Yzd30IHH6dFqJ8+sadcPG6tiMYwx9tIQCwqZNYqfJoaLcO6pq7kPx
 BhCz3CoV21Jca6HBLEJs3AK8WZ2igURA9Ko9F7d0ejeDj29BaiiVykZITX0a0/wSx28AQHT4M+y
 pHo5iddnQrDaCMAl6RRTHxKmzCUWo+/iIQxSkpt5wLyWEjR+NgT7nikXn48fX4boQKQUZGpHIyg
 KZdA8zCiPyWvzwD94koyiVQaWA2p3eAS3KkxWeL1WalVZ/oNeDic9enkXoWAHw6fvb0doB0QW/d
 667zZO2Y9yKwlqqHBeSbXfZrcBzSd6Q9aa2llUg4/Ld2DIoNO+jzaVkh/oWz+wfpLHFUkRHUBW8
 fcYgL6KgQ0G+I6xfkG
X-Received: by 2002:a5d:620d:0:b0:491:a219:8506 with SMTP id
 ffacd0b85a97d-4a63bbc3bc8mr5505738f8f.48.1795025645260; 
 Wed, 18 Nov 2026 10:14:05 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a6573ba95csm6607457f8f.56.2026.11.18.10.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 10:14:04 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 18:14:03 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I4571033af79092d85657b176044497245faf5e39
X-Gerrit-Change-Number: 2219
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2219?usp=email>
X-Gerrit-Commit: 9937c88e9ed63eabd2f2d41ef86c7371b5773c7c
X-Gerrit-Comment-Date: Wed, 18 Nov 2026 18:14:03 +0000
In-Reply-To: <gerrit.1795023922000.I4571033af79092d85657b176044497245faf5e39@gerrit.openvpn.net>
References: <gerrit.1795023922000.I4571033af79092d85657b176044497245faf5e39@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MDIzOTIyMDAwLkk0NTcxMDMzYWY3OTA5MmQ4NTY1N2IxNzYwNDQ0OTcyNDVmYWY1ZTM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0d389d57ee486498165f0712c25c3eec0ded7342-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xTkAe-000000006qH-0OjO
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: let the
 interactive service add routes again
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, heiko@ist.eigentlich.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4005835878396003635=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4005835878396003635==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tNzIEphC29c="; charset=UTF-8

--tNzIEphC29c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund=2E

R=C4=83z=
van Cojocaru has posted comments on this change by Heiko Hund=2E ( https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2219?usp=3Demail )

Change subject: opti=
ons: let the interactive service add routes again
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To =
view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2219?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4571033af79092d85657b17604=
4497245faf5e39
Gerrit-Change-Number: 2219
Gerrit-PatchSet: 1
Gerrit-Owner: =
Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Att=
ention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed,=
 18 Nov 2026 18:14:03 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--tNzIEphC29c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund=2E </p>
<p>R=C4=83zvan Cojoc=
aru has posted comments on this change by Heiko Hund=2E</p><p>Patch set 1:<=
span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; pad=
ding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2219?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2219?usp=3Demail">ch=
ange 2219</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2219=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I4571033af79092d85657b176044497245faf5e39 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2219 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hu=
nd &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Comment-Date: Wed, 18 Nov 2026 18:14:03 +0000 </div>
<div style=3D"display=
:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-H=
as-Labels: Yes </div>

</body></html>
--tNzIEphC29c=--


--===============4005835878396003635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4005835878396003635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4005835878396003635==--

