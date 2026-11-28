Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57948606A31C
	for <openvpn-devel@archiver.kernel.org>; Sat, 28 Nov 2026 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=H5n9nHOX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mfKBQ92A;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GcU4em61;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JSeHX1td
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PsrcxIZftjhJLymXZJp/+jrRMfg99Pr+jPvoKHPgmXo=; b=H5n9nHOXR1MXXFTVzLKIkxJeRl
	S5tw5GFbMWiZSD7aODVvdqSVTHUl3CwTB0KWYurelHq85zuEpD/l5Q43Jew46XEuXtchSW3m0ej84
	xQf+Z+rAlz7SheKFE5eVKirfYE6CFE3JwmLnU6lH7eX/VJuTMDcgKj74WhoTIC0XjCvs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xXFAo-000000007Eo-39s2;
	Sat, 28 Nov 2026 09:56:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xXFAn-000000007Ee-2Y4K
 for openvpn-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 09:56:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eDcg90W7ZA7+j2Ws//2zEqpLuk32AUgDZv+Cg/JcCuI=; b=mfKBQ92AvFY6rLYisg4Nt1Nz/6
 DntgdxhGaos9xf84B2/LcxdMLOugq+tuIRjsOlQCog5NxhNY5Yyomp0Dosg2+H8ozu4N3LbNMpbcN
 Obz3yZ+SMc+JdEkNm3Zcioseh6Q+Oj0ROhav3K8sKy52OY9k+8rE1QT2yiU954wgtm74=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eDcg90W7ZA7+j2Ws//2zEqpLuk32AUgDZv+Cg/JcCuI=; b=GcU4em61ZxKjzhzkOqVrkf6lWy
 +RjiVUAH+QywgrrSrUHSjneXyxa9INrlIO7uNbltDkCqC+wic7ALDJkIqtp25brnPbjA4+XcVY6l/
 bRxXC+sw1W3iv3ZkY8sz5+KiHgdzTsUJ/BhvSIjXjhGSnQwmy54dNR6ZcfmEMGTt/mTk=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xXFAm-000000003yc-3Yg7 for openvpn-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 09:56:49 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4bb6057b333so43342115e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 28 Nov 2026 01:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795859802; x=1796464602; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eDcg90W7ZA7+j2Ws//2zEqpLuk32AUgDZv+Cg/JcCuI=;
 b=JSeHX1tdjranvquCv/YbijerubJQiRBCivTA+Y/sxpr8Dci6TpOlr6zgS0UNJVTaUf
 sxar8CKpJ+HiFVLRebl6tZgIi8c0z8Yin5Fr/Aas38yRpJNtVNF1jBaOvQKo7fw1gAO5
 MMc0BnyHUlmMsEfHAc/Vfs1+hWv8WyXrQGis7a8wa9rwERMrhaG1HwhOMN9RbAqFUxkE
 r2W7UNBQW5h5PsfKXpyV2vpbhuA2U03bQ9DBA//QAd+7GnkfSN/IQ6XsHK2KdllcCmvb
 HYC0Vf5xEug8JnTqlZJDCi4NJek6VFUhkAtc+5iZ7BprLwrh5fOsFi8D1b2TDLJz7HHt
 xf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795859802; x=1796464602;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eDcg90W7ZA7+j2Ws//2zEqpLuk32AUgDZv+Cg/JcCuI=;
 b=YlNQH/847F2gpcFzRyMvKts6x0bjmEelcQpnzwXUdUJIkWMFZCBhckIu9+XzoI/OBx
 Q9G2Z9/zyQsp5EHU7rTQyEi6qdf0N9tK8nlzUD5Dfb6Qu2AIWvmqYa3s/RK4A3gn9wwr
 iObFx7bgj5wEOjVcXwXmQFF9QioZmTC3DJfOBqIfCZMmROmqwq9sal3i3+ZSXQCy430K
 hG7lu8Ja8QCtFnX1ey2dGaHO4NGAy88BkTwTPr8zUqzlLvL3WwTM1OBE8HFA8saQjFwD
 JE6SxIWFNGL/oE3N71TBzM2dPqFl+CkgjI1LwFL2qubyw9Q8W03u39f/wppUjzjZQ31W
 wG5A==
X-Forwarded-Encrypted: i=1;
 AL+hErHlJzZTIFArg0gw/PqVfaoo14H59iu0kvcWWazo1AKsptz7jeSJ5ZtrY4EQs0I+9685KFCqUfNXmqKhZH13@lists.sourceforge.net
X-Gm-Message-State: APuU4Z91PAiQkFFv7Gl4776bItCFbbAgPQQon/XOHCRrqo5jupBKlT8q
 bu9gjUVF4sFpOZzcdKg1kprwl00mcU5Xgryme+HlvUYC0Hl561/1ps224pXFeSiY776LgXneU91
 s+QcO5xf4/kFAUZN4t0rhzg97Uct2IHJZ9UmFBZp9oQaKAmVaMecow4I7s8kqFZ2qS2IlIGcVkF
 ZTV7QnVA==
X-Gm-Gg: AZFdTZezCXZulylD1e/tTtvV5Gvb5Hr48Kh95zPe1SijlVgyzD/2NMDDSMAz09Ij5e2
 b1mDHN9vAbiUCz6/dQNM/HU1j0jS26Jjw8weNaC5481oXqsE+fVdR3OOZ163G3bTODFrkI5Ey+w
 diZkeDE3msW4e+5jaUTda/biowoVAxDhg2Z7FWtl3Asm/uwOy2HcucFS/0I1xw5nzGTkEGAvv49
 QR94yWkPViymWuW9lX2xErc69gdYcO8IrfYD99LB/7j6p1Ugvt17HszWtRnKbsOSLGap777MpWq
 lc0/NK9Fv9hezWUadnWFZEcA4W3WRK8ARdg9iFrRNPyITlppfzM4u72TEOiwoEmINzTrlFrB8Fz
 Dw3xPSpls2/MaTS3Ta3OQ3OjfMe8htXQMPEEhQLJzOUPdrwaJLlDJP4Ru5M5rWh95JenIfz9DmP
 PmZLRkxtSHl64za233P1ZNfHO+JXToOtlDd49mZmc0TkGClB904zekkzMatWPPE2+neQk0UG+Q8
 yj3l/gjKJuKC7l1RMufb/1GhSBL1Z2MougrQ5dWvSWbt4WyAeh+BqEVK2PCvFXa77cFQPeTSwBh
 2N2aTd+cjC9RKgCROivGhfJOP+5/eB5AJz+fJnXz+jo2tx/Y4u0Rl1adI2soqZPpeGLqddEn+UL
 19Ao6oWLBGkrbpLFlsl90a3s/FZ6ZGN2fCg/qTeURC7NZ71IS4MZnqhdfLW0xVPCzEjq05Xg/OM
 2Ad9lGn9I1pMii9dTSDmePqe+sW7WZ5bbub8Cd
X-Received: by 2002:a05:600c:674f:b0:4bb:7e4e:de69 with SMTP id
 5b1f17b1804b1-4bb88814c37mr528059675e9.20.1795859802158; 
 Sat, 28 Nov 2026 01:56:42 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb9065744esm422228935e9.1.2026.11.28.01.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 01:56:41 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 28 Nov 2026 09:56:40 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ie0d772af38b66799499b1b5729915ed77c438441
X-Gerrit-Change-Number: 2348
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2348?usp=email>
X-Gerrit-Commit: 8b8786bbf9cdcb7d8330cf1d4cfc1c627c736d46
X-Gerrit-Comment-Date: Sat, 28 Nov 2026 09:56:40 +0000
In-Reply-To: <gerrit.1795675637000.Ie0d772af38b66799499b1b5729915ed77c438441@gerrit.openvpn.net>
References: <gerrit.1795675637000.Ie0d772af38b66799499b1b5729915ed77c438441@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njc1NjM3MDAwLkllMGQ3NzJhZjM4YjY2Nzk5NDk5YjFiNTcyOTkxNWVkNzdjNDM4NDQxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <36dba949b31196c8a87a470028be15653d2c225d-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xXFAm-000000003yc-3Yg7
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dns: pass dns vars
 to the updown runner via pipe
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
 openvpn-devel@lists.sourceforge.net, abcderyscreenprinting@gmail.com,
 heiko@ist.eigentlich.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Deri Haerudi <abcderyscreenprinting@gmail.com>
Content-Type: multipart/mixed; boundary="===============0333998714814241030=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0333998714814241030==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZF2A5yO6KlA="; charset=UTF-8

--ZF2A5yO6KlA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund=2E

R=C4=83z=
van Cojocaru has posted comments on this change by Heiko Hund=2E ( https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348?usp=3Demail )

Change subject: dns:=
 pass dns vars to the updown runner via pipe
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2


-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: Ie0d772af38b66799499b1b5729915ed7=
7c438441
Gerrit-Change-Number: 2348
Gerrit-PatchSet: 3
Gerrit-Owner: Heiko =
Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Deri Haerudi <abcderyscreenprinting@gm=
ail=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Attention: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Sat, 28 Nov 2026 09=
:56:40 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--ZF2A5yO6KlA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund=2E </p>
<p>R=C4=83zvan Cojoc=
aru has posted comments on this change by Heiko Hund=2E</p><p>Patch set 3:<=
span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; pad=
ding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348?usp=3Demail">ch=
ange 2348</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Ie0d772af38b66799499b1b5729915ed77c438441 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2348 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hu=
nd &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: Deri Haerudi &lt;abcderyscreenp=
rinting@gmail=2Ecom&gt; </div>
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
iv style=3D"display:none"> Gerrit-Comment-Date: Sat, 28 Nov 2026 09:56:40 +=
0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div=
 style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--ZF2A5yO6KlA=--


--===============0333998714814241030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0333998714814241030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0333998714814241030==--

