Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97CFCA5FFE
	for <openvpn-devel@archiver.kernel.org>; Mon,  5 Oct 2026 16:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+QaKjo6jXyoDvPvhu4K8oMx6QMpkDasJPS0h+llMu+g=; b=DtFgzP6gQAlEXI2itZL8GyuiAt
	TX4GDR5uMur4jE0G+CYfmtljs8Pk1gq4dxuBglnjWbjt/t4yUNA5qpzFboB7mKN6q98S/okGlMUJo
	Z0MA1QCwbRyH0h3Io3e6qpF0duFfETi148r0cj56TDBPdaROqHRcpmQsAR73tSFRYUbw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDldE-0005sx-W6;
	Mon, 05 Oct 2026 16:33:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDlcz-0005sf-Vs
 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 16:33:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=jaFt41xVRwVzeRLWaDORdU+KJCQtxWrzk8rwb1wDjhU=; b=HycrfcbSghHONSVWMOmxqNaz4P
 VLBuz2WJeL19IiQsTvJfxnFIhLFTpC/H7ccNIh7tnABN6Qo2qAM3k2su2itLpsDFyI0d08cmvR+L1
 07WQfsVNtWz6W/NqG3hT1VarEVQ1ydfULlMTTQspdRxY+00H2YezSnzsLtL9132VhUU4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jaFt41xVRwVzeRLWaDORdU+KJCQtxWrzk8rwb1wDjhU=; b=B
 OljoVm/qySNXVga/Leh2S+ngOt/C1MDUX5pLcMmDJGjat7bBjSwmTXMRasPLgfdRAB1PBqo9WCPnO
 PhjVMlFW0RZeuGUfZmZRK3MPrKQZUbgh84ZdaCXniMC3PvmkL7KR0Dvi/+q7XCSSMXKTmTR9Cc6Ni
 Y+IC5fB25UnzMatw=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDlcv-0004TU-Re for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 16:33:23 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso2007388f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 05 Oct 2026 09:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791217995; x=1791822795; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jaFt41xVRwVzeRLWaDORdU+KJCQtxWrzk8rwb1wDjhU=;
 b=XCGsVvkUBvyLz5578KqW/XD4PuJRxlimDiKA401Oi/KBET10tKaJC82F7pdqR7QrvW
 oQ1lY8tGxW6jiKR26nvPQ6cxkFDn6Q+aOHjr3OgRrnEpexbj4Z5X177CwU3ZmGn3a1Mh
 X1aNhv2MpdsVkEA/d/S5pbHhUmiJUkh9OIVRb0cRkjXKyAgEyWyjo5usY/VDGscLfnvg
 c8yAg18bMJi1GhKaRs+YIYCSdXspY+ln7M5nLxHoKxisAUffK8yWDt2dis07sMmcI4A5
 QW2N1+qezgV+pEI/ratTnmIRF0YukpnHMzG/2Um9E1CEbeyLDbKOEdmEs046aqFKmlMJ
 g4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791217995; x=1791822795;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jaFt41xVRwVzeRLWaDORdU+KJCQtxWrzk8rwb1wDjhU=;
 b=OC420G8AyQj6VoRbkAKVaJOIAnfX5ND5qEgoNj+wjaBB1fhh+Xg6y00trDZq7xefv4
 cF2jlLGX9lRFPbiZWUDryleFX3a5PBibUt541pQPYqoiAeqXV7Dxb6mYn33pESNyVw/U
 HUQG80BiALPOfWX5jRrDI3fe0Bj1hg2aIi9VsAtmvJXAu0gKZ7k1JMPPUSfk0hCqocr5
 jBSFMR2+G5nMtqDa1qKWFxOjifLbw9PvG5txxCrXKz/BYSVuFqjFU+lCguw5QKks16uP
 4QpBY78xGuUmF/Sj2EscRQu5Dqh+2lDV9GLK4rWQ146Y+RjR4r9AoSG7iPwL2+iCrElw
 3rVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjF/WC0LKVkhN0NHDqIuc5lBJRcfugUyclWa7oaGfEEDFp65nrfQsRLcAE06nVU0oYHJ5wJ+gNTl+YuAnI@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJkcwtr1Uom9SFzWTeOhDxHEaWUnyPxTyiXFUC32ldWpINSNBTn
 /ilt7XDucU7AOS8G9L3ZKpEG8HCVBFOX0gmbOFb+fyqcr5UWJ4OMBXCoWP2cQtbYKuwkRYZ48NB
 FdUH9XJseewXgF+e967t630QwdwQu2liSqdAKBzB/3ERSgpFRySu9IYSkoTWwgak2vGwK
X-Gm-Gg: AYBFou35KWuoME6gtWM06NvDGIlrZ4ZQ3z2HE01v7VlOra6CyljjfriGDEEmMrvYIO3
 a5sCPCbyRoMxBCM3LZtHY9iOqAAax4a4OH/mm2p6yghUeJL6vfQYNmVAwZaKivrSPW0l3YqQFPw
 3x5MTux3+BjQ6MQFbacwaEs7FSgF/brF4JUKeYBQU/ivJEsTUDXX47EXFDv8TVOpk5YPq/ZSGcP
 HkjlOvNUTbe1EyNAMYFVszjqK+5Z2pjoh4FJOqCQAeW5kNC87bJbmsaVuDfIqE+vgRZ4RCfIcR6
 0P5AvE14f8CTb+f8n7JxvnEqzuDwAnziixvQpPT99OmkhGY3UDd54Eaeu7JcUo6gLlyVKKrkQju
 HJgmuxQ22P9aH3qOtRi+V9Ib0xYm1jJ5/gtv08fTM7BGj9uYLV83e0Z7mKqjBmF5IOFFXOMu30r
 Gal5BF1nwsxV0cSCFGApn4Y8c8BeB+biNX6NtIY07EaNOa0o79WwfHxrWmWBKr8Hpx/fhd+/0il
 eCFBaQpfOmRJb4Ca8tVV8Q4REd/Frlytd5tFlEERxczdlv1vTJuTdSXDDx7zk7R7iMRcrnfHzoL
 nbu2Vy4GoCE1EiY4hfmhPAEOm2CnaatTTReGzuCgxg/iy4EYzIUv/AzGkgqy
X-Received: by 2002:a05:6000:2610:b0:48b:e25:21d6 with SMTP id
 ffacd0b85a97d-48c47ff9c6cmr13427447f8f.41.1791217995127; 
 Mon, 05 Oct 2026 09:33:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622704a5sm10632948f8f.15.2026.10.05.09.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 09:33:14 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 5 Oct 2026 16:33:12 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 28
X-Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
X-Gerrit-Change-Number: 1663
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1663?usp=email>
X-Gerrit-Commit: 7fa8dee66ae7df3684ff1a1cb6689c7a9e867863
X-Gerrit-Comment-Date: Mon, 5 Oct 2026 16:33:12 +0000
In-Reply-To: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
References: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDY4NTAxMDAwLkk1NjI0OGNmNmQxOTljMmRhNzcwNzc0YjhmZDFlNWRhZjJiMTE2ZjU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <43214a44e6d91e1cd2943ee3bc8b3b00f67d1cae-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDlcv-0004TU-Re
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove instances of
 constParameterPointer cppcheck warnings
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1337373605093482429=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1337373605093482429==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="e6GzW53Bjh4="; charset=UTF-8

--e6GzW53Bjh4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail )

Change=
 subject: Remove instances of constParameterPointer cppcheck warnings
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 28:

=
(8 comments)

File sample/sample-plugins/keying-material-exporter-demo/keyi=
ngmaterialexporter=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663/co=
mment/217790cb_35ca2ff3?usp=3Demail :
PS28, Line 205:     const struct sess=
ion *sess =3D (struct session *)args->per_client_context;
> Why not `(const=
 struct session *)args->per_client_context;`? Or just remove the cast, sinc=
e we're ca [=E2=80=A6]
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/16=
63/comment/d849dd16_b7476dff?usp=3Demail :
PS28, Line 217:     const struct=
 session *sess =3D (struct session *)args->per_client_context;
> Here too, =
why not `(const struct session *)args->per_client_context;`? Or just remove=
 the cast, sinc [=E2=80=A6]
Done


File src/openvpn/socket=2Eh:

https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/28f55df4_87dc1a55?usp=3Demail=
 :
PS28, Line 835:  * sock is modified on Windows via &sock->listen_handle =
*/
> I think these comments apply to literally the next line, which here is=
 `static inline void`=2E [=E2=80=A6]
yeah, this was a left-over from when t=
rying inline-suppressions and deciding they were too ugly for this case due=
 to this limitation=2E


File src/openvpn/ssl_backend=2Eh:

https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/655c10df_694e342b?usp=3Demail :
P=
S28, Line 173: void tls_ctx_restrict_ciphers_tls13(const struct tls_root_ct=
x *ctx, const char *ciphers);
> It looks like this will end up calling `SSL=
_CTX_set_ciphersuites()` which uses a non-const `SSL_CTX  [=E2=80=A6]
Done
=


File src/openvpn/ssl_openssl=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1663/comment/482eec4f_2a80e704?usp=3Demail :
PS28, Line 1150:     ret =
=3D SSL_CTX_use_certificate(tls_ctx->ctx, x);
> This actually uses a non-co=
nst pointer in `tls_ctx->ctx` (`int SSL_CTX_use_certificate(SSL_CTX *ctx, [=
=E2=80=A6]
Done


File src/openvpn/tun=2Ec:

https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1663/comment/a78768bf_b72f0746?usp=3Demail :
PS28, Line 1729: =
        const struct ip *iph =3D (struct ip *)buf;
> Since we're here, why =
not `const struct ip *iph =3D (const struct ip *)buf;`?
Done


File src/ope=
nvpn/tun_afunix=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663/comme=
nt/3fc72ff9_67392fb1?usp=3Demail :
PS28, Line 192: write_tun_afunix(struct =
tuntap *tt, uint8_t *buf, int len)
> This no longer matches the header=2E
D=
one


File tests/unit_tests/openvpn/siphash_openssl=2Ec:

https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1663/comment/aae98122_3faf1771?usp=3Demail :
PS28=
, Line 129: siphash_openssl_available(void *sip_context)
> This no longer m=
atches the header=2E
Done



-- 
To view, visit https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1663?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-M=
essageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
Gerrit-Change-Number: 16=
63
Gerrit-PatchSet: 28
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan=
 Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 05 Oct 2026 16:33:12 +0000
Ger=
rit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan=
 Cojocaru <razvanc@mailbox=2Eorg>

--e6GzW53Bjh4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by Frank Lichtenheld=2E</p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail">Vi=
ew Change</a></p><p>8 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File sample/sample-plugins/keyi=
ng-material-exporter-demo/keyingmaterialexporter=2Ec:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1663/comment/217790cb_35ca2ff3?usp=3Demail">Patch Set #28, Line 20=
5:</a> <code style=3D"font-family:monospace,monospace">    const struct ses=
sion *sess =3D (struct session *)args-&gt;per_client_context;</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">Why not `(const struct session *)args-&gt;per_client_context;`? Or=
 just remove the cast, since we&#39;re ca [=E2=80=A6]</blockquote></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done=
</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663/com=
ment/d849dd16_b7476dff?usp=3Demail">Patch Set #28, Line 217:</a> <code styl=
e=3D"font-family:monospace,monospace">    const struct session *sess =3D (s=
truct session *)args-&gt;per_client_context;</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Here too=
, why not `(const struct session *)args-&gt;per_client_context;`? Or just r=
emove the cast, sinc [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/socket=2Eh:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1663/comment/28f55df4_87dc1a55?usp=3Demail">Patch Se=
t #28, Line 835:</a> <code style=3D"font-family:monospace,monospace"> * soc=
k is modified on Windows via &amp;sock-&gt;listen_handle */</code></p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">I think these comments apply to literally the next line, which here =
is `static inline void`=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">yeah, this was a le=
ft-over from when trying inline-suppressions and deciding they were too ugl=
y for this case due to this limitation=2E</p></li></ul></li><li style=3D"ma=
rgin: 0; padding: 0;"><p>File src/openvpn/ssl_backend=2Eh:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1663/comment/655c10df_694e342b?usp=3Demail">Patch Set #28, Li=
ne 173:</a> <code style=3D"font-family:monospace,monospace">void tls_ctx_re=
strict_ciphers_tls13(const struct tls_root_ctx *ctx, const char *ciphers);<=
/code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px=
 0; padding: 0 10px;">It looks like this will end up calling `SSL_CTX_set_c=
iphersuites()` which uses a non-const `SSL_CTX  [=E2=80=A6]</blockquote></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/o=
penvpn/ssl_openssl=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/482eec4f=
_2a80e704?usp=3Demail">Patch Set #28, Line 1150:</a> <code style=3D"font-fa=
mily:monospace,monospace">    ret =3D SSL_CTX_use_certificate(tls_ctx-&gt;c=
tx, x);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; marg=
in: 10px 0; padding: 0 10px;">This actually uses a non-const pointer in `tl=
s_ctx-&gt;ctx` (`int SSL_CTX_use_certificate(SSL_CTX *ctx, [=E2=80=A6]</blo=
ckquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p=
>File src/openvpn/tun=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/a7876=
8bf_b72f0746?usp=3Demail">Patch Set #28, Line 1729:</a> <code style=3D"font=
-family:monospace,monospace">        const struct ip *iph =3D (struct ip *)=
buf;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin:=
 10px 0; padding: 0 10px;">Since we&#39;re here, why not `const struct ip *=
iph =3D (const struct ip *)buf;`?</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/tun_afunix=2Ec:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/3fc72ff9_67392fb1?usp=3Demail">Pa=
tch Set #28, Line 192:</a> <code style=3D"font-family:monospace,monospace">=
write_tun_afunix(struct tuntap *tt, uint8_t *buf, int len)</code></p><p><bl=
ockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 1=
0px;">This no longer matches the header=2E</blockquote></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></=
ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openv=
pn/siphash_openssl=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/aae98122=
_3faf1771?usp=3Demail">Patch Set #28, Line 129:</a> <code style=3D"font-fam=
ily:monospace,monospace">siphash_openssl_available(void *sip_context)</code=
></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; p=
adding: 0 10px;">This no longer matches the header=2E</blockquote></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done=
</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1663?usp=3Demail">change 1663</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: I56248cf6d199c2da770774b8fd=
1e5daf2b116f58 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 16=
63 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 28 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 05 Oct=
 2026 16:33:12 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div=
 style=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt; </div>

</body></html>
--e6GzW53Bjh4=--


--===============1337373605093482429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1337373605093482429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1337373605093482429==--

