Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88368606A320
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 07:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fzzfbDQX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZPkYYFga;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=beuX8gCj;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=K5I+IMUQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=1zPTbOQr1xcEbFkWfEAx7sRFG5Fp+BF/SBLagB26INA=; b=fzzfbDQXuGRKyviogRyCSaqF6A
	5j0AcrMSHmMe4enc+r+qGVeYAzvdumwL0LKppaPGJ1tJt5CJ5B95fs/tUJT+hxPclTmecqmKO98yy
	B/knMZwXwCofwnTe/Whm0o20oHtlC2fUer9AmIpLajjMLySl5GKhokhAEsuiDZ/OsR68=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUJ0b-000000001OZ-27f8;
	Fri, 20 Nov 2026 07:26:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUJ0F-000000001Mo-3VfO
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 07:25:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ud9q8w6kMoqHhcXEPwmOXe/kQXYRv9NevFE/ObYH6e8=; b=ZPkYYFgaVSKwBuB/z8cs9eBFgv
 556c1qOmEzVBxvglYuinpmMuLFJnQcul6ad71xgZaWHqwpH1XC3o66DKZEAm8j1EHxfPHIsZg4SAc
 1woVzizYHpCIJ4pBURAqfgurRldQ8zdRjg7KtiqztG2hxiTr1EvmcqT1GwaAb9s3W7Ww=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ud9q8w6kMoqHhcXEPwmOXe/kQXYRv9NevFE/ObYH6e8=; b=beuX8gCj0CvYddA8YeTo7Aw+yc
 +ZEbfDbMYQfJ4cnzC6DveWWUyns5rsGdWGR6zqFDTdr9L48kdobs6zqdJtEqVgWd/STfhi0rMSdP9
 C6cmaUor4DwQqRIFAEorN4ipsgB3Z5GXYVoFoAWZkzCZS6CjNPE9/Ta5pgIEhSefl8V4=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUJ0D-000000006Oc-06zF for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 07:25:47 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso3888035e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 23:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795159538; x=1795764338; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ud9q8w6kMoqHhcXEPwmOXe/kQXYRv9NevFE/ObYH6e8=;
 b=K5I+IMUQzda80Pj4bYvsbHWzUzz0dh7y7Qd3uA6jVLwvbdTxIvXomT5872Xr4Nfaft
 yBP52oqLqOjmQ9vaRXhtF7XTqhK8vKAV0g/gdGCHssZwbowIq2WKK/IdC1l9BSl349aB
 /gzJcRrhal32PhDex8/Z1J7CFoEo7SVokLS/h4oOmGbEW6U7q1T49ITROQJ40uU7fLBa
 +FkMUjYhNqypn0FzNrjqoLi1+Ai6MXACrKmfMnoGjRd5Tb4ZHOfKrfIMOzOVfoo81uel
 o31vyByOYAIKjEOgG36sQeFI/CNFckAKnAKzgjGA3T/IBJW1fwY2bn3e4C6wa0kI0mm0
 Gd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795159538; x=1795764338;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Ud9q8w6kMoqHhcXEPwmOXe/kQXYRv9NevFE/ObYH6e8=;
 b=YzOLLe41+6HNlvV9++oUexMuSKa+fuK6tzsDF7UXHtaaw6RcqWd3yjE4Yx7Lsh6SRU
 gT2AUVTgz7PrBmd6k/AxktiSrqEIvxGHt56cIfiSudEnR7djXcMWNWaJiXGIYvK654QJ
 PVKk6bko4oqZpd/mdBbQLyKowcg9lgqIdae5qrW7UXi8sfW5a+VEpUtJOHRqSp5hgezz
 2wMtO58jyNZY/oLApmoEQTtjur3RXnzezKDcZQK49P3xt2CZq40HDtUD5oldiBlQdcjW
 Esu5WXOZiA+A34D9aURJTHGyDXwfhBMZX6TVBcZvNiY90il23uKG6SvadtzLZRXhcskf
 9/cg==
X-Forwarded-Encrypted: i=1;
 AL+hErGjNTFaYnSdXWYo4NCcYx2Vvej+94HQfxAyTulniUhbGckp+H221UjVoN6U3Ull/EA8BG4X5Hd/4fr/kZI+@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/IL2YdB1Jfy8+nX8MDSbnT/m89b/aGNf1RYYqainsdCdS02/xZ
 TE0fSmpRqMKyaKGo3znsORyqSg1Ydw1VF1Q7/YtIOFLL38EZBnGIyYWjR9pEqy5L/99AILd3VBP
 XDJYHi2fJ3YJ6Ua7BXBZ4Q3d3hrwL9VuZPCnXAv/k2+XItpJQlgwc4GeIymPXjEif0RGw
X-Gm-Gg: AYBFou1YLG1cn2NJkyYjMTveF/c5QEiuarI+8f1gE9Fs8f1K9kShfWqxo88QxGKeH88
 SfOW1YLVe8/Vpj60agNyu7Lc+tPEU+LGFvESwAWU8zxJBfAc6bMjjJF5/0s56pYUizz88pclXcA
 LIG/fZwoNEnWJvW18fG9AzeUgfoiD04My0oHiZga4Pqv9Wv66UQ91P+yeuMI8GAXjGJTxXacJFH
 mFvHsyYG2Kwekt1MyEeO/XIX8St4XE88Rq7VBOH+knJUhA94LshTTgIAPnbvDBcCzdoVzXVOGQg
 4RB6woIHV6bYG8wfvMZb7g0xyMidfjvnSSI7dNWhnutkGEGP+QOtirzcgTZMYuHT40QOIZR2eyX
 S1+dYK7g0D6+IkCO3E4FuPEwpbXIW/DiBxAENouwYk1LNevmomK/iYP2A5FYa5l9DyC47IhD65N
 VRYWOzAc/jJwizwXwWfb89KlnYHcDwKAdFBplY9lYGVxcu6qFMgawixMmvUkkYexsMYnKlAvsJC
 Cz2Pt5cfFMjrnEWYbj1eJ77uh1HPAk7LMXsmtUdZItOeM0BNJqb6+VidimAMKlC3bsKN2QgL+ZR
 eOIWtGQXCIL5sotuaHzYrhFbg9EDYMduG/R0o+IbXj6i7MGzDd2HbUJtz8ppyO6fND3UdQfwaRm
 q89DYsK+tgFjolKW/wVk1WJY0rzVYcLI7htcDGAuhjzwmMeEuzCIPTaRslzYvyeI3PpsLcvky/x
 vlIZY9QX9ZSHBmapU=
X-Received: by 2002:a05:600c:848d:b0:4a5:1cf1:b7bd with SMTP id
 5b1f17b1804b1-4bb88810b2dmr42443875e9.16.1795159538235; 
 Thu, 19 Nov 2026 23:25:38 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88f6b6a6sm60504405e9.5.2026.11.19.23.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 23:25:37 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 07:25:36 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iae65693f49f43a66bf6f58bbefa7c33618ebc4a7
X-Gerrit-Change-Number: 2181
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2181?usp=email>
X-Gerrit-Commit: 6fe06c7a62c95324f468efa0c7ed09fc23a61062
X-Gerrit-Comment-Date: Fri, 20 Nov 2026 07:25:36 +0000
In-Reply-To: <gerrit.1794489937000.Iae65693f49f43a66bf6f58bbefa7c33618ebc4a7@gerrit.openvpn.net>
References: <gerrit.1794489937000.Iae65693f49f43a66bf6f58bbefa7c33618ebc4a7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDg5OTM3MDAwLklhZTY1NjkzZjQ5ZjQzYTY2YmY2ZjU4YmJlZmE3YzMzNjE4ZWJjNGE3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9f32387275c225aa5a7411e2a31c98e2b75d335a-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUJ0D-000000006Oc-06zF
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: resolve: store the
 address family in --preresolve cache entries
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1033754387133217929=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1033754387133217929==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Iz+L+PPOVZU="; charset=UTF-8

--Iz+L+PPOVZU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Lev Stipakov has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2181?usp=3Demail )

Change=
 subject: resolve: store the address family in --preresolve cache entries
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:=
 Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2181?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iae=
65693f49f43a66bf6f58bbefa7c33618ebc4a7
Gerrit-Change-Number: 2181
Gerrit-Pa=
tchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Lev S=
tipakov <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mai=
lbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Comment-Date: Fri, 20 Nov 2026 07:25:36 +0000
Gerrit-HasComments: No
Ge=
rrit-Has-Labels: Yes

--Iz+L+PPOVZU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Lev Sti=
pakov has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 2:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2181?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2181?usp=
=3Demail">change 2181</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2181?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Iae65693f49f43a66bf6f58bbefa7c33618ebc4a7 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2181 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Lev Stipako=
v &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Comment-Date: Fri, 20 Nov 2026 07:25:36 +0000 </div>
<div s=
tyle=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:=
none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--Iz+L+PPOVZU=--


--===============1033754387133217929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1033754387133217929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1033754387133217929==--

