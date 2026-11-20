Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD912606A320
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 08:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QN1CouQx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mXlYyh0i;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aFxRNRHL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=aQPlerGe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=1XOurTxV6JpYBGURC/70d1I5r/hAA1xzek4EVPqYL2g=; b=QN1CouQx6dChR5F0of+aN2uKWo
	28EcU8MzDDB3oJC1+3qsErbKz6mT4MRci0rocyfzsZVeaaQ1EjajkiK16uLA1vVgND/WK1xsM9vjY
	HautEI4YYlJRrD7h9BqW9rcUEr//zenGfwK5HcpXzqQr/i8sJg9qXzMNV/LWNFUxhWL4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUK5g-000000003j1-23IU;
	Fri, 20 Nov 2026 08:35:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUK5e-000000003iZ-2jCD
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 08:35:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SI+xD9q3g38iHm4kF5Z03lYyHorPLVDPDcyJ2gl0T38=; b=mXlYyh0iM+SVRfivEY1oDuvj5N
 83vUS5VxivZCnBzQjhLKpSUp5G26EQu56hoAOAEcqv+3HBjAX5usHFXfrfu+hVyAsWSCaGMYvs4K5
 PRZvJUpgfPAdTRUWn7M+NhOJXUG3Ca7OVmvTngAAAXGCzC5ZZirQlrEoKeTTlshqFw4w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SI+xD9q3g38iHm4kF5Z03lYyHorPLVDPDcyJ2gl0T38=; b=aFxRNRHLo4s3jaHV2xjO5LRGDp
 +MVjNV6dnBUqR/7vr7C7jLJ2UKPKYk4bpVo+pBqkZsd43ixMDLagl4dH8cSSfJ6vtgRIygKCkEtUX
 pjB1ZUBoStO5dB5L0bvrOFC2w1xkhT1N+SWySrNhQwziUQ8h1P8SpZNBCIZNpEqz/aVA=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUK5b-000000000Xx-3Wqs for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 08:35:26 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4bb6adaf0f1so5005435e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 00:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795163717; x=1795768517; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SI+xD9q3g38iHm4kF5Z03lYyHorPLVDPDcyJ2gl0T38=;
 b=aQPlerGehwC78IWcIneY03NuzDrnv9k2PWqWLtdSqiJ5fNpZ8/OTfDI6ddvS0LBpXq
 //t176pCYbnbQBv1tUc+mXEG1uioab1Ufm+AfJbJ2DhBvPLefEZq22BWzU1Z5GdSpS6a
 nT3qUep0qL+u+qjyx+/IdPM4CkXzE0HSB+ahwvB6nRp3rwP+dATJR9OHpFyXAKSTcF41
 zzZObur8CS8EKcFNt8VDmVy0aZvam1P/ld9jO6SL/TC5vpKtAjzWDAx/yZUYL7gM6PDN
 agTDYP9xPxCvZ+6/sC7iOmvHL89SYdWRxEKnXnn5A+t/aRkeanCSfcxkhDY6JdFMu/eQ
 g04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795163717; x=1795768517;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SI+xD9q3g38iHm4kF5Z03lYyHorPLVDPDcyJ2gl0T38=;
 b=VB1dReKx+v7++8l03f+JuYZIXKmFE9Tw8saSSWJnm+f57iQ8+f89E5feqq9A8/pq6k
 c0Mq+B1TTD7XGK2BrBR9SgUPNaB/bLqHq8iaiTIWFqH6pZSnaCY0Qp2I4nyXg7vBckZ8
 QLaA5GVbMndm0zR3mC2ErSmQgHSxGz9pYAj/hAllxjL/wZlXRNmgmZZasI3wAjic/9Au
 5HytgR5gpeWmOgTHyPZ+oNk4h1HYnmByutLr4HYI0ZeYZO4SZnVkOSOHdg9wttkzZf5K
 eWgos2Qck1kdFvYU4oOYBgW6rPTZ7PbfhCu8RZFmoyCaEYhVonVomN2qrDFaTHNJwPaL
 XRow==
X-Forwarded-Encrypted: i=1;
 AL+hErFc2pD1ZO+4wlTMFD6Yo9wKq0N0icGMAtioDIKHuA2pkWloRj3aVtV4HgYcdziXEBP8mC9/X/ni5D+Uvl+b@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/GJFcHrUcSsMmla6GGvMrNlcrhA7iUcinavgpW0htPqzovNQlq
 R7nduCA7Pri1RRe0BPgByHGfTTL66XB0eb1ylBKOGPj1Lhp5GYv5kp1Zf5Af7boAFwDJWYKLInm
 02isoitNEjtjKm3FmkeYVudAy7Lcxz6wQ7xNA8JJRrQMaQcXC+iGbC2VN3NGux+Ft85yG
X-Gm-Gg: AYBFou2jEiOka4Jj/JWhtGeEujPiguJBtWfjF3ZuQ/F4k2b10Qnt79yf+86BNoTd8hy
 ZwnHwRG6n4ic16UpR9kihMTHIviA2Dzqzd8+h8th3bEN8QmLCwb8lzXaUhNlf5mOZFMYW466U5I
 euiMe/m2D6NyREiqHME8We77gK7aDN/ZDV6yYf+MukmUZL2/tJVomAUlvLOOuC5D0uAwOEEdDSo
 SXLR6sdb47KPEYl9//r27bCLDN00dhcA+Gb2KylOKxyRgq6bGyDPaRxqLRfId8JcnhPhCMkW3kG
 ItFbVWy2FdqwLYdJ9IfpYaNGKp8pqDuDQemjEORmIcjUE00b1B9mfyq5DacI2oGiWwpMjlZuQN3
 SeXKmxmlDhKDTaYWRwxPS6LvttgJqx2v1gZVe8qVaSZ8grOB5TlYJyNP/CpQd3s8tFov86CYzvT
 F+qf15IWWGb1n8JgjkmvYfTwDOqnXxR9/4B+qtNBAeqW4j5E3X/W8Akn2DjvGex31MUgpA5QBrP
 qbL2DEQQbInMnzt0XNMpPc8KPCNH3gkxOOYRM7VMLN2uA3iqlL4nf17bnUrGdmmAoKQNY8rCx+Y
 5vIaugybe0Mn9BeY7vESUNRnOJafVGYZZQp3D9fFSKtmCUCAVplMCjNyXCOfBnHbBvfFBlnvPse
 Cn62675LR+3KMLPb15pPEZ9GX7LM1SjmwPR32jfzMvuDBArGiyd/+EEmaLJw8tN6xH54aR7MqIU
 ig1PWCVmNlC6/ixuAH6psy9Pbpy1knL+eC1cxl7g==
X-Received: by 2002:a05:600c:3b88:b0:4a2:191f:7cbd with SMTP id
 5b1f17b1804b1-4bb888078a8mr52924085e9.11.1795163716901; 
 Fri, 20 Nov 2026 00:35:16 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b2052c8sm4018451f8f.41.2026.11.20.00.35.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 00:35:16 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 08:35:15 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Icbfc6b64beea5e70f32449c5a63a08ad862597b9
X-Gerrit-Change-Number: 2224
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2224?usp=email>
X-Gerrit-Commit: 7ec8c790eacaff945c691563fad9882acb05f6d9
X-Gerrit-Comment-Date: Fri, 20 Nov 2026 08:35:15 +0000
In-Reply-To: <gerrit.1795156301000.Icbfc6b64beea5e70f32449c5a63a08ad862597b9@gerrit.openvpn.net>
References: <gerrit.1795156301000.Icbfc6b64beea5e70f32449c5a63a08ad862597b9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTU2MzAxMDAwLkljYmZjNmI2NGJlZWE1ZTcwZjMyNDQ5YzVhNjNhMDhhZDg2MjU5N2I5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <137a325abb3d3643774f7c77cdadaef756d4685a-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUK5b-000000000Xx-3Wqs
Subject: [Openvpn-devel] [M] Change in openvpn[master]: networking: use
 NET_ROUTE_TABLE_DEFAULT (-1) for "no route table"
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8095991766367785741=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8095991766367785741==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hRApQq46j+k="; charset=UTF-8

--hRApQq46j+k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2224?usp=3Demail )

Change=
 subject: networking: use NET_ROUTE_TABLE_DEFAULT (-1) for "no route table"=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 3: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2224?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
Icbfc6b64beea5e70f32449c5a63a08ad862597b9
Gerrit-Change-Number: 2224
Gerrit=
-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ger=
rit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Ge=
rt Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvan=
c@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Comment-Date: Fri, 20 Nov 2026 08:35:15 +0000
Gerrit-HasComments: =
No
Gerrit-Has-Labels: Yes

--hRApQq46j+k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 3:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2224?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2224?usp=
=3Demail">change 2224</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2224?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Icbfc6b64beea5e70f32449c5a63a08ad862597b9 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2224 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Fri, 20 Nov 2026 08:35:15 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--hRApQq46j+k=--


--===============8095991766367785741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8095991766367785741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8095991766367785741==--

