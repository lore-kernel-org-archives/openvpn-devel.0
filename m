Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F94606A323
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 18:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=F/7licev;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=h4OwJ5/X;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SdH8mqNh;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ZAJr0CKn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=yTUsJMXf0T4v1rxlIHXC1u5t1aEk2u5cD5qN+iPVUwc=; b=F/7licevdffxVFXMREZpGTkB80
	FQ8HkEAPxO1Wj3Opa9x21aLlMthAaX5aYQYVpHSZiV79629aJCg06adCMrkXj33R0DXmfy237g34M
	iZTzQIpYdrPhLblKcL8k9r0QSkeV4/9x4sk8sUQugheFRywfwH0VruQTMCPhJ6pdvYzI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMV9M-00000000227-1teS;
	Thu, 29 Oct 2026 18:46:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMV9K-0000000021x-1O6H
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 18:46:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=73kb7OK/a2M1CKIZfYYZi/g9wyjCRvOzAYXg7WcwEbQ=; b=h4OwJ5/Xa6+Xm9RkczLEiFh7qH
 dzUYSB+dyB1PiwOB+M4ozqsDZNojdV2580xVxIaGHpBxa0E03OEakLvtGkt5G9nnXhJUN0xHI/AZ+
 XUyuMLkrLj9kZtJLrWO714r/XKXnV14W+AD/dORz94emNfBNDLfzqoSMSBv9wOaxlPLk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=73kb7OK/a2M1CKIZfYYZi/g9wyjCRvOzAYXg7WcwEbQ=; b=SdH8mqNhLJ5P67UPXzzmnNObFB
 TTX4nIJwv2QEKvM4/ZxZ1adbVCPbuWcH1mvx74Dfj84QHUHUIL2QLfL0yQThFFBHyBEEbL17XzRl6
 ojo53zD+Nt8kpwpxlyoyj9aGOEA/egI9U/OHQy6bmx9jgILTbeRKlJF+YRANCsJcUn2M=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMV9I-000000003SX-3nvM for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 18:46:54 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so18387875e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 11:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793299606; x=1793904406; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=73kb7OK/a2M1CKIZfYYZi/g9wyjCRvOzAYXg7WcwEbQ=;
 b=ZAJr0CKn0W6it6mGaj2FH4EdjgveWsNtrZqSMOX/uJTdWNCvHJ4h7+I6NNlJsI0NJI
 QCXxq0cQlmlArb8k35JGIKXcX8gWzM7gkh9cbHKs+7u8l1L4slRngtFShxAI6d5nF0+4
 nMvmq8immZjscvtmAiAtZ38bf3B8CaiAblyeZKrPjWVnL68XpxaRHYbwRKI3+WGONZYL
 urqMoRkTvaewR3BMmKdCd8nRx6s55AdzXxKR9d8Vfi4xJxjAVk9E0WeWZO5T4lC2AUgS
 MbvTOuDfmdW2vDaIvyAJ7B1WhirdXtSknWW51jEWIckkxFra6ARU4uXTkZoA0K3s1iUN
 YR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793299606; x=1793904406;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=73kb7OK/a2M1CKIZfYYZi/g9wyjCRvOzAYXg7WcwEbQ=;
 b=w2z+/bsjBxcPkWY0EvFVoIyoSWdNiyGAaxjXq6Tl2wC9ezK/cW2s7P+lqCEFljlCXj
 L6FgUeKstHkhEN5etp17WAigpvwltLvynv0Hk6xEySVTGfxbBexJOpioW7scE9ZKZqJz
 qn7DUe78YbL4QDymRij+wGnalA4h0CXAMnsfcOCTH0c8g6HQdA+LTPIeFiWCmqLd3EbT
 3PJnVcKBnGyQ20/zHSMP3JNas741SdiarxR0bdeX2AHeiCaJ1siT2Q0xEj7C7wnF7GMy
 svguw01h2nm4Nz5shp3r3v/NNX8pWxwflA3xlbUZobRI4/vITDk3z0q3HJ5MGygVL2Ee
 ZPqA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz7IVvZIftC4Ub6tnvln+nQITsenmZhNIHvPPdCeD5dclCKNGvdmvR6EHPNAVW2W4TLNELBfqxElDvknc5+@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKF5AtHa2pipFVV2nZ3eYTKF5Ldzaj0KoyVvGgxf5ADfE7wLd3P
 zarSawEv7V77TWbBwDn1OchErHxPzV0jU7TqWwLNzA5JjlynLE4eJIqKmvmqY2+yxs+eziR+nBj
 RHpzrlbUaiT1a1DsWdF1AYm1MWLKlxRmSJ95ohxhC9uhnD9gBxOWhl09s6TuRaN8c9Uur
X-Gm-Gg: AYBFou3yBZwHPAQTJ14D3daY9XAy1YDiYzIBAEERtmwVxoPqLYfbgwB6NMEvpFV2krq
 AJb2eWaUNmeRFUtDO2vJC3RyMx9WNyDL4XnwNBfrUf3bAyZ6X996vYd+KEMBLVTPxOr1u4BGzol
 FZHA/tJndPMCbDO2T9GxoAPyEkmjXJXuR6pBHelG2jDWYXiDENzec6kmi+h6xYKJ25QgOVPS3lE
 ioA9RKl5SRaqnxwFWrPY7JBHuPqS5jNaelfrRGCrtcdVxTKw03fbq8A7Yo69QCN0P/YhP920F9G
 aHnTVgNLg7MOPWuFIMi4LGskIsILdyYgKhPIKfGKAqW32UaeCBgj+oZKjlv0TJJ3ZFF+dFwJmmF
 nxrb1ymw4tCDq/z0ZNaWqYAkR+gJtiUjILU1n86bNmYycOhMzvA2Y1Q0+YdlukvgcFhMV5K84BG
 zUI4PMeZ/EWt2JbOkNPVbU/av8+UXg/3BJWDwEsacaEA55zZ+2axhtlM1F20y5UOQ3OX3K67M4+
 p7Yw4pHLoANRx4sHx+RuvNcOON3A9FNIbvVlYJQoTlcJPASw72aOCtY+YFUFPj/O8dXSHe6vBti
 Z9ZJ5Nu4MywMgIfo7mGMWo70nngZ25jb16XmcehJ/+isZQPyvQ+VSzlB3dotNCQ4gQknnBGqQ/K
 NjRnnCSXNe5FQHKSXS+JpJac/8hMskhHuaqWPrP52Yn7iJm7SGBKzDretSAztrBddGd2n4bcHj8
 wvXixuu18opp9RuChmFdpI+IH2TNxpLCCVSzb8
X-Received: by 2002:a05:600c:a103:b0:4a1:ddca:8b66 with SMTP id
 5b1f17b1804b1-4a9672f98b9mr115360835e9.31.1793299606133; 
 Thu, 29 Oct 2026 11:46:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7c5063e3sm83718085e9.0.2026.10.29.11.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 11:46:45 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 29 Oct 2026 18:46:43 +0000
To: Heiko Hund <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5aa1a838afa924df292e630efb173c3b1dc5b407
X-Gerrit-Change-Number: 2072
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2072?usp=email>
X-Gerrit-Commit: f43f954d3f38a0a6cbe8b2675be8d5532a726e7a
X-Gerrit-Comment-Date: Thu, 29 Oct 2026 18:46:43 +0000
In-Reply-To: <gerrit.1793298866000.I5aa1a838afa924df292e630efb173c3b1dc5b407@gerrit.openvpn.net>
References: <gerrit.1793298866000.I5aa1a838afa924df292e630efb173c3b1dc5b407@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjk4ODY2MDAwLkk1YWExYTgzOGFmYTkyNGRmMjkyZTYzMGVmYjE3M2MzYjFkYzViNDA3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7c0f928aad581b0a9efe00491e50fa6f7beabb8d-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMV9I-000000003SX-3nvM
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: cmake: don't prefix
 the event message DLL with lib
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0437746141959527504=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0437746141959527504==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QzogZQ63LhI="; charset=UTF-8

--QzogZQ63LhI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund=2E

R=C4=83z=
van Cojocaru has posted comments on this change by Heiko Hund=2E ( https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2072?usp=3Demail )

Change subject: cmak=
e: don't prefix the event message DLL with lib
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2072?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I5aa1a838afa924df292e630efb17=
3c3b1dc5b407
Gerrit-Change-Number: 2072
Gerrit-PatchSet: 1
Gerrit-Owner: He=
iko Hund <heiko@openvpn=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: Heiko Hund <heiko@openvpn=2Enet>
Gerrit-Attention: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 29 Oct 2026 18:46:4=
3 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--QzogZQ63LhI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund=2E </p>
<p>R=C4=83zvan Cojoc=
aru has posted comments on this change by Heiko Hund=2E</p><p>Patch set 1:<=
span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; pad=
ding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2072?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2072?usp=3Demail">ch=
ange 2072</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2072=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I5aa1a838afa924df292e630efb173c3b1dc5b407 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2072 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hu=
nd &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: Heiko Hund &lt;heiko@openvpn=2Enet&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Th=
u, 29 Oct 2026 18:46:43 +0000 </div>
<div style=3D"display:none"> Gerrit-Ha=
sComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </=
div>

</body></html>
--QzogZQ63LhI=--


--===============0437746141959527504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0437746141959527504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0437746141959527504==--

