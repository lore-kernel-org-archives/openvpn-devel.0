Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450C1606A31C
	for <openvpn-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mwZJl9sd;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ImEeCd6/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eYt4oFId;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=AT5EmR1r
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0IhSgECSvRbjyqXYLVvd4PVT1Gx3oMtwA3qTKnDgiiE=; b=mwZJl9sdVzECeKPr+W0sgTH29R
	IU21UNa9650LPk9fpnQ2hfXDOQ5515pwKV15wyLhKqNS92qHG/counxeAnaCSm2GzrnSGP4Uw/B57
	6v2V4OgvPMsNUpNkQ55XsQp8NSiPZbu5RgJkHK3O5L6arMgsIVmUheDCIT+vovIr+ppw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQ1rH-0000000087N-30ZX;
	Sun, 08 Nov 2026 12:18:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQ1rG-0000000087H-2AP7
 for openvpn-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 12:18:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qRRDf0MK8xgp2T7jxtjIFzn65KhlZqryvQM0KEPw8t4=; b=ImEeCd6/uNO3/0sA1TIDKtazbS
 UZjfjbDyyfWu+4bjIT50u06tS4lHd2BIvoplty6rWRFDK4kqyUuWKYsDYHVKNa24zhYdnp383Yafz
 sINJLe5fEkB40WhqEVCvM96IisqmZYvxhfeZn8qPshPdD7lC9SBuhTOd/qvZbleGiyPA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qRRDf0MK8xgp2T7jxtjIFzn65KhlZqryvQM0KEPw8t4=; b=eYt4oFIdm19aoYG9hRyhMRZlpR
 Lj97QcrIQ5TKZ0QhWqMrPQY76sC6bLvyQFyhkhCPKQCEBDQyUwJ0mvr/1KlLM0DNpWmqSb1gw497F
 kV6dFpRwdhGQ8CRuXtQyi9Ofrvbv3Y7L17VHwy0iVP5S6x/mPD/euAAWeHL+/GT++xdU=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQ1rF-0000000018F-3jG4 for openvpn-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 12:18:50 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48e4831c028so65631f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 08 Nov 2026 04:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794140323; x=1794745123; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qRRDf0MK8xgp2T7jxtjIFzn65KhlZqryvQM0KEPw8t4=;
 b=AT5EmR1rc1e98J15+duG+O1wywgeWdSXUf93TeSiX57PtaU8NwN9g0/B1oKooRH0gx
 1Q9UTZW3GGgsGLpjvORYRzJJhV0AybeS6/yghRsuUM5BFhR5zOe+9R/6C5nIZW1yBWqk
 NmiROj+973IqFwOEMYkI2fBQL4HAr5poc0JcGSArz7zE+vcSBh7UPA9Vi0XIo5MNvg+X
 r5h8Shm/1GKTSqVOkMIKrN7+bA6wJyM76p+x9wSWg5aUSS9JV17UdeSL+GJZfu2FiwHC
 o8NLVALim8U8aNIBFrmetfDxwzszavw4bLoD2hpCP8bUJ87tNc+olM3VRaROKmp0x7fB
 EXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794140323; x=1794745123;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qRRDf0MK8xgp2T7jxtjIFzn65KhlZqryvQM0KEPw8t4=;
 b=wzCAJFnNmmO+PprrhaHgHWGew+9lX3zjryDh8OoYiHNW/riFnCHhrnLNtsUXZag/Oi
 ZoDI+3zEA4yTW/vytKWdYVCTZo2MtCwviRBU75T2NR4una7+XVBcGWUXOBwoOop5KNAU
 BEq3QdgcRb2+NZOdgy8tuGLmZIc+dSadc+G0DIdTFwWrvqwNsabpbK8FKJ9qbK2lsQqG
 m772iqLnE/lajXz6is/Ah8c+wqoutKZMBcK+bup5BPuvXZGdOZr+sXs6e6EmS9rJWuBF
 H6mEST9MUD/+LhbfMqJ3RR8ygOuxtebIgUH/dRNl1Z+R/gMMWoNveFv06Wxn1vkCj/Ih
 WsOA==
X-Gm-Message-State: APuU4Z+aNJ4X1JqXnh2sy/cdnvklvC12sjk29GskE+Fzzzy//uuJyNq4
 Ev5rsFPQ6tvUGa1Z/6ghsUSAA5Ze25vhKaBlSP+qJpIE6kzMAyE2VCVMAuKN2S1swm+J8eio6sz
 ApIf6IoyVJ3t5ZYdIojc7icMUN4SvMst4zffLNDGNT7dd4bgQ8qwrCJvdOjIRnIuj6VmgfkL+of
 4gblXdMg==
X-Gm-Gg: AYBFou1rmGumS6HLy0el85TBeT8VGCIz06+kGyQqt5HDpCp3NukqimBUjs2RblfD5oN
 BTkYjpcls0q7K9r70BeQReVBLVdBj7W5F5jNIdTC/1QXBi1U8s2veT/8IEPteNC84zvsHKhNpUM
 DoEEg0i5ZiNCi4+40AxFxPgEaW4yU85OsLgBb6TFmEf6JTCL2S9MOkuZLdifzLGpngKZDxIprr5
 Cu8NqAu0HSgsxjQrlwv0n2pvWRfHT1v1m6Aq+IndkJaNQQAdJPX7nQE6eBVFh31WLhB2CiSjWjJ
 LyDWAGwFd2oGd/mpaIJjNEI3l5YuxeZtIz3ZZGl+sh9Gc/HeUjJYosUaxIC7ILBLeOLPhbHmuyq
 z9EaxMSlPU+3oNHtvPeozHgCbq5XTf5L3/0rHKerdcEFnXA4+5h/tb2twzNcSdDCE6moHZM0S8T
 57QckID1mdxeCC2Rra8iTbt9KGS2ztBuDq/vHnVwXfpSQVvTGqvHHbyGetXUK5qrA77J5VO/Bbz
 5galk/ud8V7n9hgYdLkMPNbAYyRkrzW/dYl1PI8lOyrWAq4par/B2j8dGX4GvKKmEfvGCJp5l4r
 KD7DLkL0XbZfIl57i7bh+BNvef16JvWcposm1+T5JjXeszWNb1Is1Wv72eKdsbpbjMz+DCg6ljO
 rrP172NvHYhyuMjFk5mE/ZDo4UL0RGI9imd6+760rDO9YZno+Ll5foEbl3+/HAL7lAtQi0T0KCE
 2snmLwWU1Oq17kow==
X-Received: by 2002:a5d:5f82:0:b0:491:a219:8509 with SMTP id
 ffacd0b85a97d-49583ee225emr3123016f8f.20.1794140323113; 
 Sun, 08 Nov 2026 04:18:43 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49592f398a4sm3554974f8f.6.2026.11.08.04.18.42
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 04:18:42 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 8 Nov 2026 12:18:41 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Idb22f731a00158ff020a819081a07e1235d8323d
X-Gerrit-Change-Number: 2156
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2156?usp=email>
X-Gerrit-Commit: fdef240d2d2daac61ffb09e68e85847df01cfbcb
X-Gerrit-Comment-Date: Sun, 8 Nov 2026 12:18:41 +0000
In-Reply-To: <gerrit.1794139716000.Idb22f731a00158ff020a819081a07e1235d8323d@gerrit.openvpn.net>
References: <gerrit.1794139716000.Idb22f731a00158ff020a819081a07e1235d8323d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MTM5NzE2MDAwLklkYjIyZjczMWEwMDE1OGZmMDIwYTgxOTA4MWEwN2UxMjM1ZDgzMjNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <71a203fd7aa91b3c61f8e69717e7d383ad98dd74-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xQ1rF-0000000018F-3jG4
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco_linux: clear
 the context, not the pointer, in ovpn_dco_uninit_net...
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8641935755570864238=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8641935755570864238==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FTPK+SumWt8="; charset=UTF-8

--FTPK+SumWt8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Alexandre Laroche=2E

Arne Schwabe ha=
s posted comments on this change by Alexandre Laroche=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2156?usp=3Demail )

Change subject: dco_linux:=
 clear the context, not the pointer, in ovpn_dco_uninit_netlink()
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Rev=
iew+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2156?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idb22f731a00=
158ff020a819081a07e1235d8323d
Gerrit-Change-Number: 2156
Gerrit-PatchSet: 1=

Gerrit-Owner: Alexandre Laroche
Gerrit-Reviewer: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: Alexandre Laroche
Gerrit-Comment-Date: Sun, 08 N=
ov 2026 12:18:41 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--FTPK+SumWt8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Alexandre Laroche=2E </p>
<p>Arne Schwabe has posted =
comments on this change by Alexandre Laroche=2E</p><p>Patch set 1:<span sty=
le=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4p=
x;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2156?usp=3Demail">View Change</a></p><=
ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2156?usp=3Demail">change 215=
6</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2156?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id=
b22f731a00158ff020a819081a07e1235d8323d </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2156 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Alexandre Laroche=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: o=
penvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: Alexandre Laroche </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Sun, 08 Nov 2026 12:18:41 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--FTPK+SumWt8=--


--===============8641935755570864238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8641935755570864238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8641935755570864238==--

