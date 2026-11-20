Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AD1606A692
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 21:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PDCfc0p+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=eVcCizmy;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fou6oRjq;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GBwJbI82
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=YUDAzueUhKUdJAJ2nJMKDfXyyvsf4Lggd1HhKL+DVbI=; b=PDCfc0p+iM+CYPGL6UwmC7Ns7Q
	k4SYdY2fYnNB7gg+rQmJWCHEq1tyDjZI45H8MoWsnTZozLCndQE0Mj6tmKCFwf8PRM4iHn1gWGDQ3
	yOkaRkXOH4bzA/c3GeSdMglOJodfHd95E1JbZ79xO8Fm1Lxg40Xht4iUL4zrNP4qDpe4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUWBq-000000003Z0-3EVx;
	Fri, 20 Nov 2026 21:30:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUWBp-000000003Yt-01b5
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 21:30:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nXO2zKdpEw/fMWffU8mAU4pxgdLTQrfLA6gF2aO81+M=; b=eVcCizmy1NrN4d4az23jjgiQOT
 r7IbYledpLLU8n6AAJkPPFW3SJsGpza02VZIV/ZMFLOzqAPUVSgzN64DzjzAdByir5/3UXtpY4sc9
 pDIGLnVdXEqRgT0mIcNQ4CO6lXOqTcIq824xUUDnkOUIwHZUsa2b50OrA9Qr0AqeA+cE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nXO2zKdpEw/fMWffU8mAU4pxgdLTQrfLA6gF2aO81+M=; b=fou6oRjqn6OO4B5YhWh/aL47Rt
 5Xg/DAlfUlo6gOGgV/m2UTXmWJ12E2J/rMkdh4sBTEEAtgIwlbXRslw0YXExY6akU9c0CXgIgfPw4
 l/okz7JZIwHPPYGLksQJXfkrxpXjAxILJ+wdrMO+2eqIvHVOnbfST6m8Xtxu3ens/KBs=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUWBn-000000002NX-2M4f for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 21:30:36 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4bb72b44a97so12085675e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 13:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795210229; x=1795815029; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nXO2zKdpEw/fMWffU8mAU4pxgdLTQrfLA6gF2aO81+M=;
 b=GBwJbI82Wts35DbsybSRA8znCS7sDVjO+MmXWimBjgp/8bkZ9opNDnAIsADn/MlpjJ
 kJGG3V5j/+p3RAgwnZBT1ppLQ20AGDAlbInDxz43UF+E1SyxCfof18VndbqcO7GKDne4
 d2iiaFqLpiPVxaBKdsitq03s1ydRotEygX8sPMYi2oR3YFTiXSuzLAYeuDmzY7StyvVu
 unwQyKERqvHM21vRqFONWo2G4IW6uekqXIkYSM6o+L+ewA6ubgdcbQLE1mv+y7sQv4om
 IFYkss9Dg34JZqOy51gF3z1LmiYo8BcoEVPeW9APuS5L/zpbsEK1Sspr2xBLUKw1Ejsj
 d01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795210229; x=1795815029;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nXO2zKdpEw/fMWffU8mAU4pxgdLTQrfLA6gF2aO81+M=;
 b=omZ0w/MLOTLghqlfIisOiBiP92Ai4fgA0ibxkZdj1e872WbvtESMEzTJBY3xcwLgw/
 CuBrjJM4oPHww/eq6LS8gmFnTd3FPYoq/079wz7b/Q0S/DwXymKii4rZdW+6jj63WV8M
 C4qTlrqmQkU5Q/odTUG+9ou+tsKDEX6pjx78ciyWJWFdvgQHqzKjddq9eTl0QCTBncjP
 yRwvVNFMk8zgbS5Pd3ld3oK/rYyy67UUCiGciiktY/HEdPiDQBvuU5XWrXfbDLqLx0nk
 r6Tecf6REJ2yKFquDgf8WfwZDYtsXs8L2TAGo5Zpq18Ls1SBtb4PW3uhg7GeFwgtud9C
 jazA==
X-Forwarded-Encrypted: i=1;
 AL+hErGcQZaFqiNOgm0qNUPZBgIQLEkNdD5TE6VlciE5NsDSOoMU5mXhzlg2JCPnaWierVeJNB+Poe0mdsdKFOo3@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/3nEmXn0wjuYhCaDG6tkizDgpCpHNuyIVhosuH3J5yllb1jWCD
 IbKpJzB50gdaAtIn8ACChwqIkhFTYY+nvYyFdhJ5swseSZumjsjM2eAw/WhtK15HpXCRGcx9f1G
 GmCfyw5mAzyaV6/nEE+gd+rqj5UZj8WpCyxZy9yxQ5aaLPrPif/K4Hn72KbU92Ltt2XomoRxa5k
 XNXXBNxQ==
X-Gm-Gg: AYBFou1vd3G4bmumNTTF7PIM7IKrvRCrZkBnmIQ//WSbGq4fEhwOErHfgv2h6nzgtIA
 UZUOKfl2EiN4R/sKMs0adw59zB3K+5kZATd0tmBy9rA0BiQp8/9EopatzeIH3TPAf6LO6SEHnJf
 dOv0AG6atWtEweScvhx1o6SPx0CYLeTQ7iET1JGKL84GKc9nRaVGQ+sbJChp19thGzjE5OUOjIC
 LqvQTZHa/DxyuZmqJRnk0PhaJS9juYjIn49Pkbl3KljPT+7LT4eXl2K0pyoef+4o0hzArI9DJbp
 ea8teIQp6loDVCL2NziiuRBwQd2XPiLRMcnKnvA+dnEF6pYmox+5AhB8p4rxX8n1kR2IEMZN3FS
 XS3fYWcdJL5+X1CKMzTvaatpuTnEkBZZ52n4rocUszmG926DcyKAy5rWz4GkV5TAx+RBtym1OLu
 ZF/lrRH7GGHF7QWnDB+t0kgofILfjK3BraHl7hCox3Uu4O96rEo4SiIlVkbpTyh6r2ws1FMcCK0
 fhQ5WTG0eSMSFxCk5HJlB6ogl/WTDmMMIxTfQ+G3Kn7eUwmOYqnni5ZUGJgH2nUuuVEH0flXT4Z
 xDyLN/1zcdF4vnfMCyg6HKppV7nr6HxEROgk59HwI2+r+XxFiDP36jwgIi2oJ5DAkKsqEoTH/Hx
 Yu0Qx6262sT+6lRw5Rkr4VT2FZ0mcvKosZcin3eniCIVHsSO1lbO1JvADqd5NsWu5rBgn6gAG6Z
 CFikMVeCCRA13Pe6E=
X-Received: by 2002:a05:600c:3b1d:b0:4bb:6991:2330 with SMTP id
 5b1f17b1804b1-4bb8881a890mr99190705e9.22.1795210228786; 
 Fri, 20 Nov 2026 13:30:28 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6ae2dd55sm7542912f8f.30.2026.11.20.13.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 13:30:28 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 21:30:27 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1d36996218c3c61f1f16e2c97f922afa66df6b66
X-Gerrit-Change-Number: 2234
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2234?usp=email>
X-Gerrit-Commit: 3679c6993d79e1edab6ac9f8065a91b94dd06dfc
X-Gerrit-Comment-Date: Fri, 20 Nov 2026 21:30:27 +0000
In-Reply-To: <gerrit.1795207472000.I1d36996218c3c61f1f16e2c97f922afa66df6b66@gerrit.openvpn.net>
References: <gerrit.1795207472000.I1d36996218c3c61f1f16e2c97f922afa66df6b66@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MjA3NDcyMDAwLkkxZDM2OTk2MjE4YzNjNjFmMWYxNmUyYzk3ZjkyMmFmYTY2ZGY2YjY2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dcfc031da9b29f13a552d354c06ab2992c48ea90-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xUWBn-000000002NX-2M4f
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: fix
 reading DHCPv6 name servers
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
Content-Type: multipart/mixed; boundary="===============1545788188099207461=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1545788188099207461==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2jvaLydABok="; charset=UTF-8

--2jvaLydABok=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund=2E

R=C4=83z=
van Cojocaru has posted comments on this change by Heiko Hund=2E ( https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2234?usp=3Demail )

Change subject: open=
vpnserv: fix reading DHCPv6 name servers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(1 comment)

Comm=
it Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2234/comment/c7ddf0=
e6_582539a9?usp=3Demail :
PS1, Line 16: separator is added=2E
The commit me=
ssage doesn't seem to describe the change?



-- 
To view, visit https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2234?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I1d36996218c3c61f1f16e2c97f922afa66df6b66
Gerrit=
-Change-Number: 2234
Gerrit-PatchSet: 1
Gerrit-Owner: Heiko Hund <heiko@ist=
=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Attention: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 20 Nov 2026 21:30:27=
 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--2jvaLydABok=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund=2E </p>
<p>R=C4=83zvan Cojoc=
aru has posted comments on this change by Heiko Hund=2E</p><p>Patch set 1:<=
span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; pad=
ding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2234?usp=3Demail">View Chang=
e</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2234/comment/c7ddf0e6_582539a9?usp=3Demail">Patch Set #1, Line 16:</a=
> <code style=3D"font-family:monospace,monospace">separator is added=2E</co=
de></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">The commit message doesn&#39;t seem to describe the change?</p></li=
></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2234?usp=3Demail">change 2234</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2234?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I1d36996218c3c61f1f16e2c97f922afa66=
df6b66 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2234 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Heiko Hun=
d &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none"> =
Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Comment-Date: Fri, 20 Nov 2026 21:30:27 +=
0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--2jvaLydABok=--


--===============1545788188099207461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1545788188099207461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1545788188099207461==--

