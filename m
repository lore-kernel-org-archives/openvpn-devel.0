Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5D5606A324
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HK+v378B;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gesUoCXA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GYUP6H8j;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Tg0X4P2G
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jjdk1W782sLNBsOui08wDCuyyzyNMULpuVdZ+IDhm2I=; b=HK+v378BYmCHHstArny0Z98Fwf
	aFXdbshW1uhNE3PF943EhORrmn/Lt93XKSVFfX38WW5pBT4+aWGRhOFdiulWWYCXsPp5LSKKXzAj5
	HSIgy8SXl4b51m8xvCTSpK5E7DaS5mx6es4YgeQgKtBHjgXDL/SjU/4NMN1e3dnky2r8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNqVU-000000007dX-1rQP;
	Mon, 02 Nov 2026 11:47:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNqVT-000000007dR-3YwO
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 11:47:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wD5hLPxKw//QO7fsrHUUidmwyWvu7gNnXTxkWWGcdbE=; b=gesUoCXAUbjD463JFn8frhTPyv
 0w5WCTA/M7V6qhS3WBxG+G0sGKaysSFk0W2y9uvpVCy882C/C1RFxGNct4MMSg0kCgQy+cUG6TPq/
 jtkR/0tyGwOyE1aVYqejQgyXYO+4InmaG4QO9lNXGIja0NDk5QD/ysiI53hc4HNoKar0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wD5hLPxKw//QO7fsrHUUidmwyWvu7gNnXTxkWWGcdbE=; b=GYUP6H8jErEoMB0cUfnVx2M28w
 tqIpeIdyfRUxGMEXv2J/5g51QtmAwXG5EIHoj63kECLKOKisCqIYpRw8rTDwM+gutNoAT6pW/ddI0
 o8bvbQ05W5b1Di5xkcy7B0zIdKogd6tJgg1Nojza8k20cxRCb7Teegt1RfrtCqdRA1Fc=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNqVS-000000005lI-0dZY for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 11:47:19 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso19918295e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 03:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793620031; x=1794224831; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wD5hLPxKw//QO7fsrHUUidmwyWvu7gNnXTxkWWGcdbE=;
 b=Tg0X4P2Ga+wFHL6dxFulbvxCylox+oxelBbKhlM0ADA5iza+RkE20Q5ABMZ7qNuZl6
 Jnccmhp12UNZ8HBY5MtVMoI70yWKw/BCmKCZpaYIOTm4fpMP9xwUP+EdnKE6IPYGbcfg
 LwUU+MH7bI8cnGnDz1SoW5SrNW0EPHLFpfJMOVYNIw/Dncoe8PZxKn8Hbau5Q6JC06GQ
 BbNGfVz2daWFDSbkwd+0r/Y6oSal4lvTpgodJ8pTBRu/LyIlAEnQaqdJc3zSK4ANSkkY
 UAtrm1qDVery0mtwY8xqwKGVCr/dwwH7cIxNIJ+bzJBGJcQQ+46MfZ5O8eKzQWkMK4k1
 l3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793620031; x=1794224831;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wD5hLPxKw//QO7fsrHUUidmwyWvu7gNnXTxkWWGcdbE=;
 b=P+w0ROY6cikUv1cYkJJAH1ePRSigjN9wLWKTCqog/Ve1XpbcTmn7IehsiwNux3ndyq
 ZfuILU+6h3dhzPlRABnS+jPB3ZFOYuD1zWEcDwvWp2a9VCL13FLgwp/dAmbmeS6xd8yw
 YyhdrW8ESqGJX3sgHYCFPGtvYh9zOaLyZSUgOnOGUUW+yhD5hkq//cO9osOmOoTQYo8y
 96Xs6Ks4jOsTPfxH22S2PX+CN7pcGlzXKQL6whfdKDuw/T0yNoprPqhlQiEmmckEphHG
 VrHVIcbsJ/f3K5xP/R1/WSsG6wj8jhYGDbYKa11lQFfJb62PP2rZ05+q9EEv4V5IOJXJ
 z8Lg==
X-Gm-Message-State: AFq9FYKP0YYMdYPeCGQ9E6nu8XQWjpbGGq+1wAQmIArJlHF0wMTyzafK
 pGoMceGE7vsts7i34Rua26fpTRthEwWPY+OZPKvgEpqqM3t0fBrOpF7BoNtAHUcjIGQamx9d/mM
 6joJOywR9HHve8CjZcLITxq668mmU34tFBOwExfrC/031A7Z9iNR2dfXBBO3/Wt6EoBDRhLuNYQ
 3E6nTZRw==
X-Gm-Gg: AYBFou1CHcueBF6I+BxwId1S329kcY/cjNwt2v21oY1AbMBxu2vfLmcny3WXOrbWpGt
 7W15FFtP7CrhmHAHDoZT1Ne1zXfHmVtMUFZidZfWsLcfuli4VMSOAr1qaRZCOMfq6ORtQUDejl3
 3zExcxDWzgbeFjoThX1JwtKZ3J4IOCqbKrQcCkikwFpILhn3u7n5eaVAQEBuwdul8Bd37C1ptV/
 +jm2d89A8oX3xAJUZ6P07o7gBdJ8NMeJaOy58gi9dg68EZGwknCqJY32i1fNf+iIh63j4Toxxde
 dGu9e49KP7RXU9f94aY6q7KfZCbU//d9O+hoxZxlvX/x6bg/RglmA0YqaVKg2VV5vkK7o87IxXb
 6qdKFERWewJBujwtllCjR9586iA+hJZazHwmJqc5x77L37EYjFQLYN0zJpzucIdh5+zfpsXRH7r
 qET6ZhRS7BX7GY8nbMw/vKIg37mh9UZnHvo60YPkmxyGVskqGHplpvl0rW0naBantfGZOhV4zJa
 k1c6KdyXKgbGc/BoCYIYYxIgvnvV2N4cp0E5brVk44dcdc4WcPN3E4tJqTxyMoX663kLGbOV0BT
 O2q2ycC7DnNN/4/05y89MtrXjnGQcSD1OCOsnWdXpc1hz48mdlZdl69gyh+PArfw6D5DlIpmUVf
 XUxKAomTOvoHwFACCeXcp+v10+uJiGX2bNHavC5fCMB/XGkP/n0fMfb/UgG8gSc9B0SAIbC/+2E
 1oqbtpUUKuEthMMXCSVFsVArZ5woTNtbv0ndZH
X-Received: by 2002:a05:600d:c:b0:4af:83ad:8f70 with SMTP id
 5b1f17b1804b1-4af83ad8fa7mr93433775e9.35.1793620031537; 
 Mon, 02 Nov 2026 03:47:11 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf6e63e0esm344383335e9.12.2026.11.02.03.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 03:47:11 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 11:47:09 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368
X-Gerrit-Change-Number: 2081
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2081?usp=email>
X-Gerrit-Commit: 8292574b42c32903e304a7e88e92e4e60bea50a9
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 11:47:09 +0000
In-Reply-To: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
References: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkljYWRiZWU1MGEzYWY1NWYwZjIwNjlmNmQ2ZjFjY2M3NDYxODBmMzY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1da71cf50dfd48d2e26d1c2a0c2ce98597bc8039-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNqVS-000000005lI-0dZY
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove support for
 --secret
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0775330313841650036=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0775330313841650036==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="M/i8ZZqa+J8="; charset=UTF-8

--M/i8ZZqa+J8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Frank Lichtenheld ha=
s posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2081?usp=3Demail )

Change subject: Remove support fo=
r --secret
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 1: Code-Review-1

(3 comments)

File Changes=2Emd:

https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2081/comment/c3244692_c5ad05e7?usp=3Demail :
=
PS1, Line 32:  
spurious white-space


File doc/man-sections/protocol-optio=
ns=2Erst:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081/comment/89eb1d48=
_d7e22164?usp=3Demail :
PS1, Line 216: --allow-deprecated-insecure-static-c=
rypto
We should add notes for this and `--secret` to unsupported-options=2E=
rst


File tests/unit_tests/openvpn/test_crypto=2Ec:

https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2081/comment/57ac51db_9707e911?usp=3Demail :
PS1, Lin=
e 373:     for (int i =3D 990; i <=3D 1015; i++)
Why all these changes to t=
he numbers? Separate patch that spilled over?



-- 
To view, visit https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368
Gerr=
it-Change-Number: 2081
Gerrit-PatchSet: 1
Gerrit-Owner: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment=
-Date: Mon, 02 Nov 2026 11:47:09 +0000
Gerrit-HasComments: Yes
Gerrit-Has-L=
abels: Yes

--M/i8ZZqa+J8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld has posted =
comments on this change by Arne Schwabe=2E</p><p>Patch set 1:<span style=3D=
"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;bac=
kground-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail">View Change</a></p><p>3 c=
omments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0;"><p>File Changes=2Emd:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081/=
comment/c3244692_c5ad05e7?usp=3Demail">Patch Set #1, Line 32:</a> <code sty=
le=3D"font-family:monospace,monospace"> </code></p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">spurious white-space</p=
></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sectio=
ns/protocol-options=2Erst:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081/comment/89eb1=
d48_d7e22164?usp=3Demail">Patch Set #1, Line 216:</a> <code style=3D"font-f=
amily:monospace,monospace">--allow-deprecated-insecure-static-crypto</code>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">We should add notes for this and `--secret` to unsupported-options=2Er=
st</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/uni=
t_tests/openvpn/test_crypto=2Ec:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081/comment=
/57ac51db_9707e911?usp=3Demail">Patch Set #1, Line 373:</a> <code style=3D"=
font-family:monospace,monospace">    for (int i =3D 990; i &lt;=3D 1015; i+=
+)</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Why all these changes to the numbers? Separate patch that spi=
lled over?</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail">change 2081</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icadbee50a3af55f0=
f2069f6d6f1ccc746180f368 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 2081 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
=
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank =
Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Co=
mment-Date: Mon, 02 Nov 2026 11:47:09 +0000 </div>
<div style=3D"display:no=
ne"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has=
-Labels: Yes </div>

</body></html>
--M/i8ZZqa+J8=--


--===============0775330313841650036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0775330313841650036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0775330313841650036==--

