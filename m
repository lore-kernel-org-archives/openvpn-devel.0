Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC39606A320
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=f9j+8rou;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FledOOaZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cvd4G2Qz;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=EayKCD8r
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jdEjYihXyoTyMZwdjKWfWIsyVf2PKVu3wq3JD1YdF3E=; b=f9j+8rou7Mgh5RgWqiPoLnkEO7
	Dk5s9wnAHnaiBg5DBEwRf80nDL1ZdpEBniyispptbInGtn6bNqVNFCFOHlNQu4P3NlW+M8FBvAAK9
	1b6ZbA680cLNWtaEQSCTt0FfP6H+gimySuMag/1HeGGMUfp3Hj7iX84e4N1gv1FZjWJI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xU0Ms-000000004e0-3iYa;
	Thu, 19 Nov 2026 11:31:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xU0Mr-000000004du-2Fvd
 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 11:31:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rk2iepv72J1mPVAszLsRZOEcFSwXEBJn+nDZ3M+Jom4=; b=FledOOaZv/97E5NocTuJqxHyR+
 kreSFTECdII4NnMMTAPGqHb82saIqh2UWn/lN53qT4T5wP19eRnGIldZhnHtq2KFpLVNF6jazy4Gb
 nMoEX8QKgonRSlM7IuQJQwN0eG8m9wn+upRBLBIdVlFMH/hu2tL24jU996UAkmySkoAU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rk2iepv72J1mPVAszLsRZOEcFSwXEBJn+nDZ3M+Jom4=; b=cvd4G2QzU7v2+MrdWKQhaBAogY
 PR/VEZtkYMw1RIBXYG4F4vL1u6ceZu5qz2UGME1PHxmlHwBGPlsNNavP89NbDTPIFcdnZ7k291lZf
 fHLtdQ++7nbYETngkEq3iZ6CciSby6MVvHuCBV5m3SemP+d+h6Mv/lOpG5EkuwmtUExE=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xU0Mq-000000007MA-0RUh for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 11:31:53 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4bb85e07aadso4419725e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 03:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795087905; x=1795692705; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rk2iepv72J1mPVAszLsRZOEcFSwXEBJn+nDZ3M+Jom4=;
 b=EayKCD8rw/gBzhDYKNc7/MKsuXAJesbWMDArvS4zG6OvkPlBdoiv1VJk0sCqvqsJsi
 lEBdcEdFR4aMXzpN84TF4La9nCM1OFZ2Vn7uj/BjE1iczUaFwbDlZ0DlimV2KBzf4xUx
 qycSm0oneOv9rmWMlsuiPlpyAIPw2S6MuuFwif9HzxFXDmZyGgyRDjbBi0RBXVDI5iq9
 wy0yq426DvRq+PEU/3ni0QE1g/Yp2GMZGIJXAu1sXHCC4OQS0lCzubM2aXNmWyNEGJWH
 8u6x8pluJjWXTJZcL/X4Gi7b9+76ujy4f8Ecy97DLdieT/lzz7n+zVkkUoD0/wK0ZG3D
 QaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795087905; x=1795692705;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rk2iepv72J1mPVAszLsRZOEcFSwXEBJn+nDZ3M+Jom4=;
 b=E237VFqdBStnml2THnfxUCM7tVQrsRdXCTDzp+yDbu7+knAHkXl0dpODQzIfnsDB/u
 dOhm0WzT5NA8yulQxNyjAvMCFCEJTrTJCP1uYYvBpxTio6JfLH/C0BsY9k6SdGzpCjLV
 VdfND6oeSLznf+YFcvNPAV3Px+dfjrCyA+cZX6XFMIPpFcfQCWHeIkUrfhlhPr4WoWh3
 EiV4OThHitT3q8Hzi0uyhwdkuw8wh7zww43xetqAxjcKPFM4+aMp474XV7U1HdAsST0K
 Q2bhL1S914dgUHN0+wy5WzZIvxWn4v877jycVx5nvxSMAg1vYc5F0UohpWKqrG3o1C+2
 a1xQ==
X-Forwarded-Encrypted: i=1;
 AL+hErG75lczcuTIXn7KEiuyDh1veVn+mGns5eQPeNhLCBRc2TCBnda2ZuZgjRxZcUAzn9g4SXIZMkbqd7pLJsnn@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9gLQdtPl2WFF1P3I/OhSAbSDwkvWi0UOxtCHfxHK7/qaZ7zobQ
 dJJQboh7xVSNSb//bHU32bZdfqv4D61M2DruQNrLZmYm8XBGhNe8xmtjCwCUG8H90lyvHBiRGBW
 daOS25XacV8fE3Jc+i0L65GIeZ1BxZfJuAvI1jPfaqaSp6kU6mHLQCKFqPVfWu1vyaxS8zm8Tjt
 fV64wvzg==
X-Gm-Gg: AYBFou0v0SQyKQ/NvOF07/t9AL6QGc5+e/mYAui8/OjhDz+ChcptwgLLPhlVqfb7j4q
 wjo0/7rGCSDQ1gPvDgKjEpHC+Jcc/+xf6D72vnEBfKeHjrA5VkE62M/fy191GW4M7WDWhVb3vJ5
 uLxX+VsaJY260cZK9q2SNWnkJuGHCNogyIbbDeJd8j9v0dOoZ3t5uJL9xaWuAFPSZY6STD1PNRI
 L1wvNKTKOmSh8lHtndHCEHh0r6hRX6P430QqflNWB1IkKdg5xjhElr0BRHAO93gFVyb8W4IkF0x
 gOcjWD+vrAmU312pC5jqwmF+5gogaiYkTeLvd0+tZgXuK+eA+FXyT+JUScddlkWrITxPGmEVYmK
 wW1Vhb8473jvUcdlgdzT4sWVdiC3ixze9AUMsb06AhWhAA1xLNeBGlVVn6tIn9UzJJcBYvlQ5/D
 Ld+4o2kGcxbn1yWwgD3EgMS9nAEID6QCxV52D/IUmWLn44QSPCOI1RCgQBlwZAEZNnHfYefcf7o
 BC8FpvwEd4E6R7k6pWuhLpr2T6711U9/TLVoCTopV4byEqCuIsmW4GQFtGybUNVJEPi5B4I7Eic
 b+uFYSIeMGlv453Me6dLjO+H1Hjg7Jj6yw5cN459Q6TdnccRdQfQrmW7CCQw3ZHNTZnknTnms1d
 odfhVk7tu5pyfmM7bIe/DmdU37mCTB2QdyXjmQgIVbJdk/XVA0KqmaXZXyWVfcG+rRXgQN5huQ4
 kONkn1B87rijx6ADc=
X-Received: by 2002:a05:600c:4e93:b0:4a4:4d57:8487 with SMTP id
 5b1f17b1804b1-4bb7da138f5mr117297385e9.5.1795087905272; 
 Thu, 19 Nov 2026 03:31:45 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb84e804d2sm27028945e9.5.2026.11.19.03.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 03:31:44 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 19 Nov 2026 11:31:43 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I9a78e57cff805e1896d79a17fbcd4132c5a4b1b3
X-Gerrit-Change-Number: 2220
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2220?usp=email>
X-Gerrit-Commit: 6131a57429a2bd74c378bb73cf696be4482e79f0
X-Gerrit-Comment-Date: Thu, 19 Nov 2026 11:31:43 +0000
In-Reply-To: <gerrit.1795024630000.I9a78e57cff805e1896d79a17fbcd4132c5a4b1b3@gerrit.openvpn.net>
References: <gerrit.1795024630000.I9a78e57cff805e1896d79a17fbcd4132c5a4b1b3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MDI0NjMwMDAwLkk5YTc4ZTU3Y2ZmODA1ZTE4OTZkNzlhMTdmYmNkNDEzMmM1YTRiMWIzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a645fbd00667d7e295b86788f7246aa534e4a9ef-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xU0Mq-000000007MA-0RUh
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl: fix MSVC C4047
 in key_method_2_read()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4053113527948624159=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4053113527948624159==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5/5+Hpdwz8A="; charset=UTF-8

--5/5+Hpdwz8A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Lev Stipakov has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2220?usp=3Demail )

Change=
 subject: ssl: fix MSVC C4047 in key_method_2_read()
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2

(1 co=
mment)

Patchset:

PS1: 
My bad - it works on 14=2E51=2E36231 (19=2E51=2E36=
260) but fails on 14=2E52=2E37025 (19=2E52=2E37029),



-- 
To view, visit =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2220?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: I9a78e57cff805e1896d79a17fbcd4132c5a4b1=
b3
Gerrit-Change-Number: 2220
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan =
Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Reviewer: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atten=
tion: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 19 Nov 2026 1=
1:31:43 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--5/5+Hpdwz8A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Lev Sti=
pakov has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2220?usp=3Demail">=
View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2220?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">My ba=
d - it works on 14=2E51=2E36231 (19=2E51=2E36260) but fails on 14=2E52=2E37=
025 (19=2E52=2E37029),</p></li></ul></li></ul><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2220?usp=3Demail">change 2220</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2220?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9a7=
8e57cff805e1896d79a17fbcd4132c5a4b1b3 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 2220 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Lev Stipakov &lt;lstipakov@gmail=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date=
: Thu, 19 Nov 2026 11:31:43 +0000 </div>
<div style=3D"display:none"> Gerri=
t-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Y=
es </div>

</body></html>
--5/5+Hpdwz8A=--


--===============4053113527948624159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4053113527948624159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4053113527948624159==--

