Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1694F606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=X7qQaO97;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=XsIc24Fy;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QNawxPbr;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Bv/QUFaQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VqSFUNi74qGoD541IzLLMOnyceW7zo/zAFusIjU2/hw=; b=X7qQaO97JjDGnonQDJDp9PQxuB
	hDG6E18JnX3MaR66VBLH62i8UfpXMafn0piYf79Rso3aq0EiieHC5Rg1cUxMWM37y6Yvv2v3qh1XD
	42XiV0xsrX8zKkHuSRBmiU8PHg7gFbe26Morc7T5SRemjnu0GBG0PdlJVrL6tXjyTMB4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLKck-000000007mQ-13lu;
	Mon, 26 Oct 2026 13:20:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLKci-000000007mI-3QCi
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 13:20:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=N1Aws3k/A37FXaE9fm1BsYMr3czT+Q+WVZGwRq6Ntps=; b=XsIc24FysAUUVfHFbll/LbH0l5
 xlgHpKPMLMjbPvy7NBcmNBMhb6sF74EJTENS9ZzUu85OAsIYnVA9QjYHZiUIbKwg8iyH7vhaHzHhQ
 TqxzQ/TqQKm7wYegoIsDjB70Sx8cxgfuHQpi+q0QoaIOuWQrJinsGtQ6t3AB0vAuQM/s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=N1Aws3k/A37FXaE9fm1BsYMr3czT+Q+WVZGwRq6Ntps=; b=QNawxPbrRqY8fXPD89KMh8ncuW
 bmtjhDx/Jj4GRlXBjeyhh+27UGlH4rDjI1FtpVUvZDgE9jNWAJumMMVLhWIdeLAKx0YFA4TujVynb
 Ya1ax7emcqViW9IDosrMJxud13QJQ4mZ0PyNIEYmszND44jG0eGOfy5ve9uF1cmztHq0=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLKcg-000000000L6-1F36 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 13:20:24 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso31129875e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 06:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793020816; x=1793625616; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=N1Aws3k/A37FXaE9fm1BsYMr3czT+Q+WVZGwRq6Ntps=;
 b=Bv/QUFaQQFAEdL6NZIj27Tvou9DzaebSPM2F/WfVA1NJQoT8n8skcbVXZogPPaoNbW
 UtT/isdOXfwk6ErPIaJFQQ80+f27MLvVtWtLWxOgIVT501adGCQ9g2HCTM426ZPNH28U
 bzI6A4esTmKKdhiSKS2biP6Tde0MHmXVB8Cz1mcvLeY/taASatkC78txW9V8obKlnwN+
 ATF9Um01kjSk+ZW4K4Vk/sOPnf0/G4pGB4jH0pDSy0x9ivfD2lGy7LNja4ZQnIreGUKr
 M37JUuUgHrp2R6vyhfRXap0DKJGDWF1+5WylROirVMRpBHSfVXYgjWwvjLAhfBnliXFz
 ZrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793020816; x=1793625616;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=N1Aws3k/A37FXaE9fm1BsYMr3czT+Q+WVZGwRq6Ntps=;
 b=WFhGV1wgFJxZWv6vi7VI1oqfCExDHoxAHhOtSIyzmBtgqxcWj86+aoj3mnFwGp43UC
 8F3UIl3WB6NPPSKrZtmAHKuFFs1KEUTmLI/dWQyIlhXpvf0MRSqlUQAZvQZqAW0EiHiB
 dzZDt9kHQy/xAZ+3iTOizhtPDMJFij0VchlL9dXvvjao+QtqAV3iktb5jF5n478rgbmD
 JVMTKbqdtzAgtOrc1xrgkR6hglr/Xkq5kONWfFt6WgYETWUU2S2bWpuzjB7roOIn8CGP
 cEAJScJsAUfE2gQlIWNQZE/12hcOSzaaBWG9IlR2nduR6RaV175sKaFqR1lAK+NyIqcX
 2zVw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxkaZUTWliYGMEfDe8PEB1GPV8Rvn8mDrnhPM/BFifaKiDWCl+lwFjR+mqxGm0GQFJeUcJiFfTmvEt53uP@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJl7yfDesxNky5OTZYTdiDZ/B7Ww7IEh8dhK+fpEQ7fVl6Z7u2F
 Ing+g/3yklpsZQzASY1b6c1tIN1yBMwLCA8/aIQjloBkykpdkBoFkgE2bjRbt72yJCYoHf6binj
 egp+5U5XNevIGprfw9ChcsiQKluTJXhf1pzD/1eDZIGRfUiz+ttFz9b+36yAFY2D8wHlmaB0EyS
 fWwIyotw==
X-Gm-Gg: AYBFou1Fw6RSdKNj1Eo4TLpgKQyGI1n8sEZUv+r0kqUjq51DXB+ZQHncuFrq6DUXkM2
 VHUWisQvG8QvGHMaT8U0vbiRydL0fKQOdFeEPtzKMTmi86pf8/Z03aLeizD0PK9jSYUEXFgcDNB
 qDSyIOgJBdtkikXZloGD1AnbI6v9QKOBRZY2TKoxmdB7auuh7wm4ofTz/8pO1EfevTabnZoNIkq
 K1I7Kp0ycsH24xM7vlWTwKFtpPOjg0KbduDNuSf/XAsDUelabJQqGvVdPPZZLhK3AI0cJ3AG9ro
 fOl0dRwL2rhM8sgfFiMOEqKWZQgoRJpv6rkng3MAeFzzSsSh5MJe0W7jklbuougVnD3rCdRdtv6
 bdidzGYNsP0IkuqMx7pqNnA+XPam40Ud+hh1KHtomWGJMx5ZHKeuicM+qSPEhTDRJ2BA4TZLTL2
 wgH4wlwjRJpowqX5jzKAIr/fn7kpHlLEXSm0Y7HbQR2VCu281X90zFFKZIUVc2piSKLqI37ufd1
 WbrKUcfhx4CL76NmTFUyoHsbd8TGqbQvVUDqVRbEOi4Z8K8/Z0mfhcmohSroFNYovlYi6lighnm
 s0+GQIypJzXYH+Yhvp2W4nil5mVGbc8HmMnuB29EhigaYVzGkRw2ZWiLpaVxzqB31NH4Bu1ycvK
 sWnPEVr0DTBcCjxpZWelRwKu9yme5qYq15jYbNYdwww==
X-Received: by 2002:a05:600c:6384:b0:4a2:a3b:7aa8 with SMTP id
 5b1f17b1804b1-4a35ac3acb7mr122108735e9.3.1793020815282; 
 Mon, 26 Oct 2026 06:20:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359fbb725sm193992775e9.0.2026.10.26.06.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 06:20:14 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 13:20:12 +0000
To: Max Fillinger <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I5ebc0d04c501d00dd35e8e23cd25d6696d95d719
X-Gerrit-Change-Number: 2029
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2029?usp=email>
X-Gerrit-Commit: abced4a51301c1228875f58c87e15c7ec4056937
X-Gerrit-Comment-Date: Mon, 26 Oct 2026 13:20:12 +0000
In-Reply-To: <gerrit.1792688397000.I5ebc0d04c501d00dd35e8e23cd25d6696d95d719@gerrit.openvpn.net>
References: <gerrit.1792688397000.I5ebc0d04c501d00dd35e8e23cd25d6696d95d719@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNjg4Mzk3MDAwLkk1ZWJjMGQwNGM1MDFkMDBkZDM1ZThlMjNjZDI1ZDY2OTZkOTVkNzE5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <62a0bad4741f42e235b5797327c5f48d2adcd99b-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLKcg-000000000L6-1F36
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 max@max-fillinger.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2302123329291276954=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2302123329291276954==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CHvlM1OOe6Q="; charset=UTF-8

--CHvlM1OOe6Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Max =
Fillinger=2E

R=C4=83zvan Cojocaru has posted comments on this change by Ma=
x Fillinger=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demai=
l )

Change subject: Remove Mbed TLS 3 compatibility
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review-1

(4 co=
mments)

Patchset:

PS2: 
In addition to the inline comments, it would be n=
ice if we would also drop a line in Changes=2Emd about deprecating this may=
be=2E


File CMakeLists=2Etxt:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2029/comment/adb21a8f_5fc8c805?usp=3Demail :
PS2, Line 320:     check_inclu=
de_files(psa/crypto=2Eh HAVE_PSA_CRYPTO_H)
It seems that after this change =
there are no users left of `psa/crypto=2Eh`, so we should probably remove a=
ll the now-dead checks now from configure=2Eac, CMakeLists=2Etxt and config=
=2Eh=2Ecmake=2Ein=2E


File src/openvpn/ssl_mbedtls=2Ec:

https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2029/comment/b99cd3dc_a5937fa5?usp=3Demail :
PS2,=
 Line 156:     return mbed_ok(mbedtls_ssl_export_keying_material(ctx, ekm, =
ekm_size, label, label_size,
`MBEDTLS_SSL_KEYING_MATERIAL_EXPORT` seems to =
gate availability of `mbedtls_ssl_export_keying_material()`, so in theory t=
here could exist mbedTLS builds that don't offer it=2E

We may want to chec=
k for it in configure=2Eac, or do some #ifdef-ery here with an #error if th=
e macro is not set?


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029/comme=
nt/a441b1e5_cea634c6?usp=3Demail :
PS2, Line 514:         mbedtls_pk_contex=
t *mut_prv =3D (mbedtls_pk_context *)ctx->priv_key; /* remove const */
`ctx=
` is not `const` here, so the cast shouldn't be necessary=2E



-- 
To view=
, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I5ebc0d04c501d00dd35e8e23cd25=
d6696d95d719
Gerrit-Change-Number: 2029
Gerrit-PatchSet: 2
Gerrit-Owner: Ma=
x Fillinger <max@max-fillinger=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: Max Fillinger <max@max-fillinger=2Enet>
Gerrit-Attention: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@li=
chtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 26 Oct 2026 13:20:12 +0000
Gerri=
t-HasComments: Yes
Gerrit-Has-Labels: Yes

--CHvlM1OOe6Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Max Fillinger=2E </p=
>
<p>R=C4=83zvan Cojocaru has posted comments on this change by Max Filling=
er=2E</p><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-=
block; margin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review =
-1</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?=
usp=3Demail">View Change</a></p><p>4 comments:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2029?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:<=
/a> </p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">In addition to the inline comments, it would be nice if we would a=
lso drop a line in Changes=2Emd about deprecating this maybe=2E</p></li></u=
l></li><li style=3D"margin: 0; padding: 0;"><p>File CMakeLists=2Etxt:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2029/comment/adb21a8f_5fc8c805?usp=3Demail">Patch =
Set #2, Line 320:</a> <code style=3D"font-family:monospace,monospace">    c=
heck_include_files(psa/crypto=2Eh HAVE_PSA_CRYPTO_H)</code></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">It seems th=
at after this change there are no users left of `psa/crypto=2Eh`, so we sho=
uld probably remove all the now-dead checks now from configure=2Eac, CMakeL=
ists=2Etxt and config=2Eh=2Ecmake=2Ein=2E</p></li></ul></li><li style=3D"ma=
rgin: 0; padding: 0;"><p>File src/openvpn/ssl_mbedtls=2Ec:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2029/comment/b99cd3dc_a5937fa5?usp=3Demail">Patch Set #2, Lin=
e 156:</a> <code style=3D"font-family:monospace,monospace">    return mbed_=
ok(mbedtls_ssl_export_keying_material(ctx, ekm, ekm_size, label, label_size=
,</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">`MBEDTLS_SSL_KEYING_MATERIAL_EXPORT` seems to gate availabilit=
y of `mbedtls_ssl_export_keying_material()`, so in theory there could exist=
 mbedTLS builds that don&#39;t offer it=2E</p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">We may want to check for it =
in configure=2Eac, or do some #ifdef-ery here with an #error if the macro i=
s not set?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2029/comment/a441b1e5_cea634c6?usp=3Demail">Patch Set #2, Line 514:</a>=
 <code style=3D"font-family:monospace,monospace">        mbedtls_pk_context=
 *mut_prv =3D (mbedtls_pk_context *)ctx-&gt;priv_key; /* remove const */</c=
ode></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">`ctx` is not `const` here, so the cast shouldn&#39;t be necessary=
=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2029?usp=3Demail">change 2029</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I5ebc0d04c501d00dd35e8=
e23cd25d6696d95d719 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 2029 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div =
style=3D"display:none"> Gerrit-Owner: Max Fillinger &lt;max@max-fillinger=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc=
@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: Max Fillinger &lt;max@max-fillinger=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Comment-Date: Mon, 26 Oct 2026 13:20:12 +0000 </=
div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--CHvlM1OOe6Q=--


--===============2302123329291276954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2302123329291276954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2302123329291276954==--

