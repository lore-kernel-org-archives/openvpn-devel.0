Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343C9606A31A
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 23:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=G+SqmP7O;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VJG1bfdq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bsIR5q6y;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=adi6tE9D
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=FPqJw5V6MqC+vXlnInLrvLqBrBHpJ6k6LDc7LWAkZMA=; b=G+SqmP7Okhn9ND2jjDkaWBUWZO
	K8Sv8cUBMEw7ti3pEqR/M//40GFONCFAb8Y/6Cm1WfCZB6IEeLlyR7eFU071PgWS5CTH4HM4IclT4
	HQ15NQXxq2f3OeNZpFln7BjylDU7TirpKmQDIU4lUYhExETFRGzkdvUX2XT7mGH/AOc8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMD27-000000004Bc-2TYy;
	Wed, 28 Oct 2026 23:26:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMD26-000000004BW-3VqM
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 23:26:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/aS2l1Po+CZuDwg+UP4/Y/cgg8TqB1dPYLtHmoOrbSM=; b=VJG1bfdqCLXUniyyufCa2HI2Wi
 9RNiFdmB5m3/hTKBWEUujS/2oQBBysJMxrGq3twpDSnCUnt89ex+34czRPF9B6Utwft8L/PFoPJnV
 14nF2Uv+9xa7yvNYVtJNyK0mx+WNwFWOJEBNgNhV9vSOti0hBcoANuay+AQJVU3dQZy8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/aS2l1Po+CZuDwg+UP4/Y/cgg8TqB1dPYLtHmoOrbSM=; b=bsIR5q6yAZBpzGnrUf0Xt6r58B
 SGZh2fi7YSPvexdYujiW8q8nRBw8wL2j08GJJXWSBvB1GrBFxIBP+7iF8QMje6qT07onB51RwET8w
 cyNS2zKrL64Ls0g6H9Z3oG/I/OS9VD3+64qB9gaL2QR26JWf7b5X30j1NOdDKv85tBRY=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMD25-0000000064d-2Stf for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 23:26:14 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso12615495e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 16:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793229967; x=1793834767; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/aS2l1Po+CZuDwg+UP4/Y/cgg8TqB1dPYLtHmoOrbSM=;
 b=adi6tE9DDZgT6w8pNx3fvPzRzlzResFlQavihNAcQQDkj27z4krVPnDLqnYR3mVAw7
 SitEhfMJOBAFWKTGi10BOkGiYatiM1harSxIwUZTno5bKUoNWuAxjunkjbyHwfFSgPXk
 34mSY95c46j3tLMGYRsqLT+UBQPcQ7Mvswxs6pmOvsaJMv9DGJN1PFMT+h3b+Vt5cZjB
 N1qO/nkRcqOTI2yoDa9XGGTHNORF7+7r3FdB8X91rPPFE1ayJUoRWQZJGcGyhxUMMTrq
 R3FJ0mpP8Pzk9RoIeFHaRFzAHbJJ/mFLB1d0dho5Dj4zRuXfKmIbpfrUQ/T0R1nEvr82
 WnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793229967; x=1793834767;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/aS2l1Po+CZuDwg+UP4/Y/cgg8TqB1dPYLtHmoOrbSM=;
 b=P+46xwGovHX9X69vk2OKw3FSoAA5sUlsBGC4AovW22+C0JXGv4oliZI2DJYieSl12B
 7+CeqE8XVp3dRPMlaXgEBT+gdamvC6MGWAf+pyNBy32oE2bnv/aJRV2RrtQbX75Qdb8f
 AmFQGR0McFBuCtObAvEUv+RbcNn4gTD8rk3iOB40H4FqN5W7XeT7VX7b6ihY/xiCQP28
 s8sTnLMWbb4VG2TGIfB1Mff/+uQNdjGOa5jQzq1pymRvr1jQHZNOHD/hAT6uwK+2AQSt
 K4b9DoyZ/lMQgCK4jlZTMFVFyDzWJQMycm7k8gJbyXpiZqSU7cpT/DKXqZUxfHaQQEPt
 IWug==
X-Forwarded-Encrypted: i=1;
 AKwUvBycqdfeLLiH24B4v3O8Z0ZPrNkBb3bA9lcHb7wGZUEtf00tkcMwQ9sOR09JaQk8+04Oba4h10uvNacTQoYr@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJv0yVeOWsUrR9HBx8JheUbUEdath7QaaEiil1BFa3XsAn7dAg1
 M6p+ZX7BJMNwvPoSy3dfRuOni6PHjECh/XYv733dPH7zU6ncJSc8pJwGAXYiE55NDHvszzGft6H
 kh1DkcIWBeCfORkQDo1871gaAh6eFYFFpI5exwenz0dp/tv6Q8hAY8oeJOkG35s0GXIqq
X-Gm-Gg: AYBFou1mMH5Nbflb2L13O1S0qZIgdJStXarEkbbXD6luKPORCSaS4RCDJiNSYHagZBw
 1mKRrQTUvfXOsYbUXaUPs1SYdPutupKgXR6CVzQ7uerc7naA8GHt67QH2jQSpecrHcwTroDk3oy
 O+S5u3hmUorL547At5n6ZFfJ70Qc8rOTyHedy/Pfsv89aDKAEPSSGpleXyDhvQDWi7JgtZspPFS
 SowaaUkF4X39EJHDwQJuwYjrkmqJLJu2NpM1wb1wZFzaX8eqwAkhAYYIM7YV3FnyGoaU2KYE27Z
 BSf42pO531cFuqL3mWWANNux18V3rSzu9KgmbclDaH0YNshFIO86N7phyDgqg8dXNPyIqa3Rlno
 jG2qKuzdqsayoRv8aHy0XiH/ilnnk424FRCVGUj6BQSDke+IISj2kd3Hoh0LYAvJtNTfXK2/w5H
 cjgcYX/55oK42++1mdB2WzlszcZ7cIFBbO26UZBu9Ijrb2CKpOQ59K5bAt9vSJuxcsNgVU4bZxq
 j6ZPD6CPdDoepv99r1YgMmH3a8hbBeAWO/5lyEVT55h+EWQr9MePflTxRVHxsk375UbJSAK+2Vo
 aRth9BBZOvDzLfe+9+ytrCZVQaew0F/Bg7zRMjLGZGmEEjrqajpmQLk3yzJJA3QAEndWKCAoghL
 v/FyvSNUa6scml2dPW9Jj9QiqjIUKxHpXkGTJbZXmgV/qUR60KIPW5+TD5GozRDf7LxEfVYzuSf
 GLkneXREnMsWAlE4uH
X-Received: by 2002:a05:600c:524c:b0:4a2:86b7:b76e with SMTP id
 5b1f17b1804b1-4a9661ab517mr79975795e9.13.1793229966906; 
 Wed, 28 Oct 2026 16:26:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa8213ead6sm23481655e9.14.2026.10.28.16.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 16:26:06 -0700 (PDT)
X-Google-Original-From: "Max Fillinger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 23:26:03 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I5ebc0d04c501d00dd35e8e23cd25d6696d95d719
X-Gerrit-Change-Number: 2029
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2029?usp=email>
X-Gerrit-Commit: 8b3cb6f6ef5d5f8c53dfd77d723ca99118732f1b
X-Gerrit-Comment-Date: Wed, 28 Oct 2026 23:26:03 +0000
In-Reply-To: <gerrit.1792688397000.I5ebc0d04c501d00dd35e8e23cd25d6696d95d719@gerrit.openvpn.net>
References: <gerrit.1792688397000.I5ebc0d04c501d00dd35e8e23cd25d6696d95d719@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNjg4Mzk3MDAwLkk1ZWJjMGQwNGM1MDFkMDBkZDM1ZThlMjNjZDI1ZDY2OTZkOTVkNzE5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b3ae30f79b6653282a675beaec90eb20f17de302-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xMD25-0000000064d-2Stf
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Remove Mbed TLS 3
 compatibility
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Max Fillinger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "Max Fillinger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6365780626600168000=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6365780626600168000==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="83YaF9buEkk="; charset=UTF-8

--83YaF9buEkk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Gert=
 Doering, R=C4=83zvan Cojocaru=2E

Max Fillinger has posted comments on thi=
s change by Max Fillinger=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
029?usp=3Demail )

Change subject: Remove Mbed TLS 3 compatibility
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(3 c=
omments)

File src/openvpn/ssl_mbedtls=2Eh:

https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2029/comment/129882b2_460b4b54?usp=3Demail :
PS3, Line 85: };
=
> I think we need to delete this too=2E
Done


https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2029/comment/0b779e65_d0eb9ae0?usp=3Demail :
PS3, Line 106: =
    struct external_context external_key;  /**< External key context */
> T=
his can be deleted now as well=2E
Done


File src/openvpn/ssl_mbedtls=2Ec:
=

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029/comment/ac0d1723_fc701d46?=
usp=3Demail :
PS2, Line 156:     return mbed_ok(mbedtls_ssl_export_keying_m=
aterial(ctx, ekm, ekm_size, label, label_size,
> If there is an easy way to=
 find "this mbedtls build will not work for OpenVPN" we can fail at config =
[=E2=80=A6]
I've tried adding some checks that I think should catch most pr=
oblems=2E

I'm *not* checking for something weird like Mbed TLS with suppor=
t for a TLS protocol but no digital signature algorithm=2E (Is that possibl=
e with pre-shared keys in TLS 1=2E3? I don't know, and I don't want to spen=
d a lot of time finding out=2E)



-- 
To view, visit https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2029?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I5ebc0d04c501d00dd35e8e23cd25d6696d95d719
Gerrit-Change-Numb=
er: 2029
Gerrit-PatchSet: 3
Gerrit-Owner: Max Fillinger <max@max-fillinger=
=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: G=
ert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: Frank Lichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 28 Oct 2026 23:26:03 +00=
00
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Max F=
illinger <max@max-fillinger=2Enet>
Comment-In-Reply-To: R=C4=83zvan Cojocar=
u <razvanc@mailbox=2Eorg>
Comment-In-Reply-To: Gert Doering <gert@greenie=
=2Emuc=2Ede>

--83YaF9buEkk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Gert Doering, R=C4=
=83zvan Cojocaru=2E </p>
<p>Max Fillinger has posted comments on this chang=
e by Max Fillinger=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2029?usp=3Demail">View Change</a></p><p>3 comments:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File=
 src/openvpn/ssl_mbedtls=2Eh:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029/comment/12=
9882b2_460b4b54?usp=3Demail">Patch Set #3, Line 85:</a> <code style=3D"font=
-family:monospace,monospace">};</code></p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I think we need to de=
lete this too=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2029/comment/0b779e65_d0eb9ae0?usp=3Demail">P=
atch Set #3, Line 106:</a> <code style=3D"font-family:monospace,monospace">=
    struct external_context external_key;  /**&lt; External key context */<=
/code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px=
 0; padding: 0 10px;">This can be deleted now as well=2E</blockquote></p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">D=
one</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/open=
vpn/ssl_mbedtls=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029/comment/ac0d1723_fc=
701d46?usp=3Demail">Patch Set #2, Line 156:</a> <code style=3D"font-family:=
monospace,monospace">    return mbed_ok(mbedtls_ssl_export_keying_material(=
ctx, ekm, ekm_size, label, label_size,</code></p><p><blockquote style=3D"bo=
rder-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">If there is an=
 easy way to find &quot;this mbedtls build will not work for OpenVPN&quot; =
we can fail at config [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">I&#39;ve tried adding so=
me checks that I think should catch most problems=2E</p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">I&#39;m *not* chec=
king for something weird like Mbed TLS with support for a TLS protocol but =
no digital signature algorithm=2E (Is that possible with pre-shared keys in=
 TLS 1=2E3? I don&#39;t know, and I don&#39;t want to spend a lot of time f=
inding out=2E)</p></li></ul></li></ul><p>To view, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demail">change 2029</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5ebc0d04c501d=
00dd35e8e23cd25d6696d95d719 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 2029 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: Max Fillinger &lt;max@max-fil=
linger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne =
Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;r=
azvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Ger=
t Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Gert Doering &lt;gert@greenie=2Emuc=2E=
de&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Comment-Date: Wed, 28 Oct 2026 23:26:03 +0000 </div>
<div style=3D"disp=
lay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerr=
it-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: =
Max Fillinger &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:=
none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&=
gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--83YaF9buEkk=--


--===============6365780626600168000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6365780626600168000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6365780626600168000==--

