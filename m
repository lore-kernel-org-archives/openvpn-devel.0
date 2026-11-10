Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50D8606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 11:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lq1jiPxw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NqTr1W13;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FjwJP+Kk;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=fDrPoNWr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ir4C0pSThlQa34HIwQv8DbSZqqAjKtPtMnCvWuqu1jQ=; b=lq1jiPxwX5hekDYLb7Wbxfv/Yo
	Nn5RxGhy29lxvLI3IRACjBpWGd+go+i5CSan4575s5aReiRggjzZMehz/cPQLORjuXL1Rs5H8hyGo
	TPzUALIEnUIaw7jEi/3Ee0ApOpC9ZXYgjoxso4jS1alc327vXMJIqJ4flanRmNl3a8M4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQkM7-000000008E0-0peh;
	Tue, 10 Nov 2026 11:49:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQkM5-000000008Dm-3zwB
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 11:49:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uw1xECGbfRfnhgvVlOa4TYD8yOj2loxgHeBmVImMXtA=; b=NqTr1W13TNG/u02EE7tSTjmH3h
 64VoGz4TyK/CDk61vjlCz2UNIIgPWPUqCboUmj/HS5RTIevY4NDDuqOpKJ1QkiwzKq+VDdlDl6rBe
 lqCgo/pM9RsWz/6bk96PEhfs28gBjRCoheWI4zaRzyVHneAF83IpUpAQdK/zwa8Cb2HU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uw1xECGbfRfnhgvVlOa4TYD8yOj2loxgHeBmVImMXtA=; b=FjwJP+Kkw6VR3gp+XiZIC9TEPF
 Zn3ugTIy9blFCDVKMKE3JPV5THrG7z7qfruYwcPIboA+/90+0L8s0qrb1wen931VW5B4NAT86IpT5
 oTGn2nw4IYhkK0GLiISl4GHFDLBAD77hAc/Zo5RLEJJ/pabJ/t33KJfBNQUfa9niEtF4=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQkM1-000000004n2-3y4n for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 11:49:37 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso18588535e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 03:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794311367; x=1794916167; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uw1xECGbfRfnhgvVlOa4TYD8yOj2loxgHeBmVImMXtA=;
 b=fDrPoNWraeyJA1bEf46Cid4/7zz1qRNbLe7dWF0/U/QETB1uw0KuRSl5ZAm8Ld0WYO
 y7bGXjTta6Iv7RyoaHJcY8li7xSnvfKz7MpwEuuE/kuEWtD4ikjosZm1UwY4ApR8zfPM
 TsjUg/BlL80mV/pcD+6dbWPBqrEjynL2JnxU/24wJONPnGHyr0PlK7wOXV2lqZCmKy5i
 hs4x5L7lJ5QwKAMVvanw+StRahGOSkf6g7QqeCHYhjtWQ/d1ge1ck9l9TENFPdb3W0CD
 TdmzlKajdb8ufAC3fJVLvaDOjYCEfhXdUR9mM0Fm+8JuNlgGxcyIQ12UZsCBcWPgWuK4
 +mNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794311367; x=1794916167;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uw1xECGbfRfnhgvVlOa4TYD8yOj2loxgHeBmVImMXtA=;
 b=aoUW06v4QoiaqBCNfgZRSGHDz/bP6gXPIsxtLK8P2OSLdjsZx6t9q7JfyJvS4Sy63v
 KM+Je95vpOpLspmVO06IAWep8RObR6Kyu6wvEorkLKlr0Zb2EoGZEHtytnTmR8+QkTob
 ejolUaWV5o0RES+IB5NjXwUUOukovI1J6Ai0um0DXwLMM4HmqBno9IugN713AKqVUsu4
 rC1Phf7bYnok8R5TXivZleYS7GrB2/eQgeEZeHhhX9yeQJDb4UY7bbySr9cz1Wcyx+Kl
 4lfLsD8QjjlnUpYWaNEEwS3LbsOEE9tnRmVQEOM0yHGa0sMyv4gUjg1C88VaOWeIoUb4
 nfmw==
X-Gm-Message-State: APuU4Z+rP/vSpuXil5VOErBYYI7H2DW+J+Wj4CuaMnTfa8K2OJxmRgvt
 Sp+4V/xu8zyeoq1FMRE/VvLwsqYyrJWhMaMOp1n8ApA4h54GL/96S0FTXblTmoVsdYtneTP6Bi2
 nmzbsU3XsZ4ner4QT/no09YDnberZ2pGtcn9P/q9gXZanca40zaChUq+nHN7wxVZ4PVsy4dVRk3
 w8/U9ddA==
X-Gm-Gg: AYBFou2TOWyLGfNEvuS8WkPoxPc6xYtQqtz8Li+puez/6HyF+VuO5xcE5R+x5QVyAJU
 GmME4YMWI3WhLKWICS6NZxkhkqCTGXDyfYrScqvG+aPisEa7jWh2dkXnC5TevTdubf3SFaWvodK
 Pn1DLcNhie4wA4kJJWTK76YqytjY7Ln2ESMllWjJf4ysHym1GNDaCzXWNc/HqDR4v1V/5wdGduv
 ew0+bjfEhwf9IfU+tC2MCsEOu9aJN4QNEXpmmHYYw2RhdtjJ3mAY/87zLH83+pHeoHwj+HStw6O
 u+XUE8tN8uH/QxVw8BEyMbhhx/cfuzB6MzsdcDXcGGrFPgQD6NZYg2Bqcp3bhyHIs0RQMA8btid
 mnzUz9maM7q51wRYqM9Tr/sPPOXzM5eSNRrQ2jfUtAFE+34dDdCQYW6uZNrm5Q9j8nqoeBZh81U
 ZijGSbOZVaRdq8IB1AAvSvJdg2yfNw+M4iBEOIw5++Eufxwk4NFQznvSdpxV6TA3zV/L2dMsplp
 52XwdX2xhv0hFNvJxHjjIatuW5h17pswg1e2x8H6InjS/S8SO79BdhA7cO2DgrmPBuhOfL4/xrN
 JzYQp7zpBGR8IeHuCR6DCvIcL5wU4c/CUxChdQWhx4ERbzNI8AlECOKr0vj6eE/A0pnEPymYrem
 /d3tZivF+3p7m7RWhJHGrro5c87VsyF+H2Bmbd3OR/t1VbASTex782ynO09KQjrzN2RBwpvLO6I
 kqETJXdXD0T++3vP4=
X-Received: by 2002:a05:600c:6290:b0:4a6:7d6:821f with SMTP id
 5b1f17b1804b1-4ba02350573mr42356315e9.29.1794311367180; 
 Tue, 10 Nov 2026 03:49:27 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01d9df5csm71527825e9.0.2026.11.10.03.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 03:49:26 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 11:49:25 +0000
To: Ralf Lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I704c560fa23c03237d0f8adc30908a617265a5a1
X-Gerrit-Change-Number: 1478
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1478?usp=email>
X-Gerrit-Commit: f2168737871a31ecb94fcc24798e5c4d1e12fd9c
X-Gerrit-Comment-Date: Tue, 10 Nov 2026 11:49:25 +0000
In-Reply-To: <gerrit.1768848003000.I704c560fa23c03237d0f8adc30908a617265a5a1@gerrit.openvpn.net>
References: <gerrit.1768848003000.I704c560fa23c03237d0f8adc30908a617265a5a1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY4ODQ4MDAzMDAwLkk3MDRjNTYwZmEyM2MwMzIzN2QwZjhhZGMzMDkwOGE2MTcyNjVhNWExQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <31b07679a4ce6c1570c1ed0d23a25665321df0d0-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQkM1-000000004n2-3y4n
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tls: reject incoming
 reneg request if primary key is not fully valid
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 ralf@mandelbit.com, antonio@mandelbit.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3392650002882298161=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3392650002882298161==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hh3Pf17zxhY="; charset=UTF-8

--hh3Pf17zxhY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Ralf Lici=2E

Arne=
 Schwabe has posted comments on this change by Ralf Lici=2E ( https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1478?usp=3Demail )

Change subject: tls: reje=
ct incoming reneg request if primary key is not fully valid
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 6: Code-Review+2
=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1478?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I704c560fa23c03237=
d0f8adc30908a617265a5a1
Gerrit-Change-Number: 1478
Gerrit-PatchSet: 6
Gerri=
t-Owner: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Antonio Quartulli <antonio@mandelbit=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: Antoni=
o Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Comment-Date: Tue, 10 Nov 2026=
 11:49:25 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--hh3Pf17zxhY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Ralf Lici=2E </p>
<p>Arne Schwabe =
has posted comments on this change by Ralf Lici=2E</p><p>Patch set 6:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1478?usp=3Demail">View Change</a></=
p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1478?usp=3Demail">change 14=
78</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1478?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I704c560fa23c03237d0f8adc30908a617265a5a1 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1478 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: Ralf Lici =
&lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Antonio Quartulli &lt;antonio@mandelbit=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 10 No=
v 2026 11:49:25 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComment=
s: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</=
body></html>
--hh3Pf17zxhY=--


--===============3392650002882298161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3392650002882298161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3392650002882298161==--

