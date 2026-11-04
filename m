Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFFE606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Q92oabrP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Kf6TpMoK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hrMfovpS;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IZsasdoO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=HINo0g9xwhWxy88zrF+g2/hIhAh2Yfi6owP+4CJ/bnw=; b=Q92oabrPi3vKDHfw7fAz/cZJZI
	RKMTmpYHjkEY+s5VoGBx0Z+RtoD5e8caBX+hDLtoHtxE5md446MiQJL6gaxpUZECVpFm33nbdZAZm
	qPiXo/tfEaXP6eZ3B9lOWnfZn+AXdSgcTubxufv94gC85rUimdP2ikqUgf5MzzFKNkaw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOdD2-000000004DL-1Q0b;
	Wed, 04 Nov 2026 15:47:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOdD0-000000004DE-2s4a
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 15:47:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5jhKewJgxQ2qCkLMw9Fhysn9vrE+SldVyHJ9fmFDGIs=; b=Kf6TpMoKJ5kI1et8r2vSzXyxD3
 9sAf0imXhucaSzv9KAbJXXHwRsYFHn0Ia7NPg5QN4qJzokULekHH/JAjKCBfOAoMCyaVxcTWUixXM
 wp+cQd5nB+iUHgDp1PEG+6M6jafqe9aVbTIEQOaGjEIKspicRP+GUqDHBIb4GA7Qe4ZM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5jhKewJgxQ2qCkLMw9Fhysn9vrE+SldVyHJ9fmFDGIs=; b=hrMfovpSKlJilPeoejFwQn4SGV
 L1X0qx9VtQYUh3bsXsr9TwwUl4GGIjsmBWOq3Av90VJyI0Y+21jGTjN5vGIDt1y0ENKalDrB6dcpw
 UHwCrOuwyy7UKqTRKYzmcr/oRqV096dG+hM33QTJxE8tEahKihX6mt4s7abcEKSA4rl8=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOdCz-0000000055j-3yIw for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 15:47:30 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48e20edd106so598512f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 07:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793807243; x=1794412043; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5jhKewJgxQ2qCkLMw9Fhysn9vrE+SldVyHJ9fmFDGIs=;
 b=IZsasdoOTwXWbExHqkR3SImkOl7McBgjJuwNd0Yq0CpHfO32cg2Uzhj5sgEUqY3cLO
 Zm85169srIsLMQjD4IiqkS/V3w77vRaqJyU6r75ZWI5wDZL+PKkN7oXJeiFRHmzRqW7v
 c+27ssUtyzt3+QuKouvX2cgJHfMUziBwNWyJ6GCChdsQuMYt7zrv+0itKo1kjOO1t1iB
 PNzrmMVm8lQxy/nyHKPw3gINf0RCUy8Ik9xdrxcUQ4AiHmEsUIeGfk/JCIpK7+acXxtQ
 xGzVcHmOL4COStlxMpjSrwihIkMENpoxGzw3XtEhxmSTc6g15hWN+B7h0yDjDfuXE0Oi
 KjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793807243; x=1794412043;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5jhKewJgxQ2qCkLMw9Fhysn9vrE+SldVyHJ9fmFDGIs=;
 b=xD6ppmQgid40Ama5lUPajIxe4MiKqAEuGVrgZyL4YItAEtNRaf/jsUns5lfFX+3mmM
 qGhwh6MfzhLHiuvr2ArME0xZCfRuoiXrBERQke+vXP1B89C7V4PvKJ+1n4qjjLvl2/di
 jrYN/y8Enw95I+I+U0VNqAwwfP0u5nUxWpNCzqSIR0Tl42zwymN3+MGAGGej9v8StGUE
 HBM4HknW73ArhIBp1B8hi8dDmDjRz3HOE0Ng+45w2rhjfAyA20SO+MArjgdRNtAGC1Xe
 OQu2znCmxios3UpvQilw+z2lelLonx8leBpE6lPkH0WUozb+rK+O1JllXK8ZhFoUQ5kB
 M06Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8ocwCOy7aMsCylZtwwiGityo6RCBo3XNgRJidE+G7LBSNRAr/NrLu5gWUNELCm04HRerTQllZjxzXoq39@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/8zfBOXIe+pwq1jtMgmAZV5O+2gXX9w8srfNO4vCT8IkLTWwks
 5sswFyhYbayhbD3FFjvWvIpr8+JhFXK8BlSvko3sTxOFk3wpVxWIwoTAbthQ6gkjGmd2LI39w/u
 MGUNvQlBCbfSmtt4Xs/5BNGSKh8wVrPhLnz0TvwveCOz64ZXryUlfbDhTqSCTLM+liHsQ
X-Gm-Gg: AYBFou2hEpoN5fyFYFGMVWR//gWgm7r2S9oBeUrrKbrsThKtVsEvSR0KcyUR4O016XQ
 hwcDcX7ZjZjCwAi36SNIeJTl0Gc5bCtfhXQ5GX2juy8ZPssneqaCZYfyOFQ74bcGNNbZu6rUch/
 kLJr5GrDQE6tIktEVWrivXWh/DiNucOR2U4vGibBGFiKw73iGQC6VzLEYPpLyznUZaMabJlP1Qm
 xKBR/u5YRQUHxUzQQF1FgR87ZqbfUUBV4pbtF+WJHIMjSffMypG9DqK0W4DlmahEmghYHYvfGkC
 3jPX8Ev13BGpmhqGZ46+323/aZzWp10yk5fxtOTCqNZc0EP3ZhY7py9SuBnn438zpENyr/ONj35
 7CwDWQFBBLaSKLFj8ibBL7huli9npQQwBEykdbouRfmMuT6XpJjfev0Dpypnf3Ykm/krFiWb9pC
 VZq1yiSGMkesX490/3KAzkpXoemMzIFdtfx8nnvww6n2jd46cDv8uGlgpL1by/8XiMHYDHxpR/X
 7qwTuaTPSSH9xg40dF3rHfpVqTXfb/9xnebj/FvX8ZDLVMu7FegiOd1efddP46ZY6l5YfA67SNv
 jMad/94jyi9mKNqO/xyPLLetz800T8YmErU2trs6z6dLpB6i39MoU+K4xxT/D58hNAqPDrhP/+5
 VbczI6tGCp5aIACtjuBI/zTWzSj5DJ5ebq0Y8GYN3ITH+BahNOFMSL7HHf1NSWepb2+01BV8A7P
 GnL03Sp0x6H7q1+Q==
X-Received: by 2002:a5d:6950:0:b0:48e:3bc4:a367 with SMTP id
 ffacd0b85a97d-48e6e2fab84mr28712315f8f.33.1793807243115; 
 Wed, 04 Nov 2026 07:47:23 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fec8d87b5sm4407750f8f.11.2026.11.04.07.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 07:47:22 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 15:47:21 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
X-Gerrit-Change-Number: 1965
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1965?usp=email>
X-Gerrit-Commit: de5de87aafd7ad3390d7c748f79a37cf6dd6eb24
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 15:47:21 +0000
In-Reply-To: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzU2NzI5MDAwLkk4OWMzMTMzZTAwOWRjNzVkYzJjMTBjNjA3YjNmMGEyNGMwNGU4MTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1846715d5730f6a134501a14cd4048f191854379-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOdCz-0000000055j-3yIw
Subject: [Openvpn-devel] [L] Change in openvpn[master]: control_msg: Add a
 shared TLV codec and use it for early negotiation
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3091768128380755069=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3091768128380755069==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="el8kW5aJD6o="; charset=UTF-8

--el8kW5aJD6o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Lev =
Stipakov=2E

R=C4=83zvan Cojocaru has posted comments on this change by Lev=
 Stipakov=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail =
)

Change subject: control_msg: Add a shared TLV codec and use it for early=
 negotiation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 4: Code-Review-1

(1 comment)

File tests/unit_tests/openvpn/t=
est_control_msg=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965/comme=
nt/ad09aaf6_b44cb7d9?usp=3Demail :
PS4, Line 163: /* Writing fails, rather =
than writes a partial TLV, when buf is too small=2E */
The write functions =
don't check for space up front, so a failed write does leave a partial TLV:=
 `BLEN(&buf)` is `2` after the first call and `4` after the second=2E The t=
est only checks the return values, so it passes anyway=2E

I vaguely rememb=
er this from the prototype OpenVPN 3 implementation as well=2E =F0=9F=98=80=


That may be fine, in which case saying so in control_msg=2Eh is OK=2E



=
-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I89c3133e009dc75dc2=
c10c607b3f0a24c04e8146
Gerrit-Change-Number: 1965
Gerrit-PatchSet: 4
Gerrit=
-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lich=
tenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Attention: Arne Sch=
wabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <fran=
k@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 04 Nov 2026 15:47:21 +0000
G=
errit-HasComments: Yes
Gerrit-Has-Labels: Yes

--el8kW5aJD6o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Lev Stipakov=2E </p>=

<p>R=C4=83zvan Cojocaru has posted comments on this change by Lev Stipakov=
=2E</p><p>Patch set 4:<span style=3D"border-radius: 3px; display: inline-bl=
ock; margin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1=
</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?us=
p=3Demail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tes=
ts/openvpn/test_control_msg=2Ec:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965/comment=
/ad09aaf6_b44cb7d9?usp=3Demail">Patch Set #4, Line 163:</a> <code style=3D"=
font-family:monospace,monospace">/* Writing fails, rather than writes a par=
tial TLV, when buf is too small=2E */</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">The write functions don&=
#39;t check for space up front, so a failed write does leave a partial TLV:=
 `BLEN(&amp;buf)` is `2` after the first call and `4` after the second=2E T=
he test only checks the return values, so it passes anyway=2E</p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I vague=
ly remember this from the prototype OpenVPN 3 implementation as well=2E =F0=
=9F=98=80</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">That may be fine, in which case saying so in control_msg=2Eh =
is OK=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail">change 1965</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I89c3133e009dc75dc2c=
10c607b3f0a24c04e8146 </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 1965 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: Lev Stipakov &lt;lstipakov@gmail=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 15:47:21 +0000 </div>
<=
div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"di=
splay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--el8kW5aJD6o=--


--===============3091768128380755069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3091768128380755069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3091768128380755069==--

