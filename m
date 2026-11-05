Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D4A606A330
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=i1s3SDwp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gRSQxmFY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fIrnISES;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=eyhVY56Y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=KF/4dAePLokOauZ1i23x/FSDXP2xdMgtiU/ggOYIZXE=; b=i1s3SDwpsuRNbuhtWZ2Lj6h5CG
	wsb3xsR7Ys++ZmsIWvCC6rpUjy3BU3UWB4S0SCaKoTmIxqptMcUXQu6S7gjgZxkCgkSJA0JE2atI7
	8VU5SAUhhboF92AinlGhkJzRfyz/j8LbsooW9jtilGSjC2H7lYuJSF1dKrzQoSI5TxzE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xP1KE-000000006DW-3Mfh;
	Thu, 05 Nov 2026 17:32:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xP1KA-000000006DN-1NUt
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 17:32:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0shBI9eNxj8mLErHegDmDFNR3bVC+OjP5kJI7+/nEro=; b=gRSQxmFYa0zggT5/TKNLYBC/Yz
 nJpaWOAkZt3bf3PRy8HUCYikm5RYiiMM9F+XuPGgsBJhhXfadIAWrAazfTLcCFuc8+stGlSKLvgMW
 tgeVH7m5pTG6bEJUtsnazNI/E7+xOe6KKAnf/go6vNFpcWteXnMDHiiyOc7QdRdL6zBs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0shBI9eNxj8mLErHegDmDFNR3bVC+OjP5kJI7+/nEro=; b=fIrnISESvw51vqTRk6NbCG4IM+
 IEPmJ/1+ORKtlOC3j6udcLt9T0Zq+5Q/KuOODEyuDdV7/acaVkpvOHbrhS8EpFDTqOHFL5yeEtJx+
 N2cCpH0sjS4g0CxEL9XaWHyC8jYU8vMhdwSVeLaMohCjqxF819QnoFV34f4EuCRJkp90=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xP1K9-000000008KB-25HZ for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 17:32:30 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-491f34b4e0fso397958f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 09:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793899943; x=1794504743; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0shBI9eNxj8mLErHegDmDFNR3bVC+OjP5kJI7+/nEro=;
 b=eyhVY56YYGx2zH6AZAMyP0Mbccf/VpPXLbEmyZp9L3OxEU8ZyO7yijy8ufthWwaF0K
 Xf1CZPjdfJI4ScSx/e3wPDBzj2abNyYeByXM01VtF+d2b62se3SMwYMhXHzQsGiFJk0O
 VxYP57AaY0T2d39Ish6Utz91M6OsaPrS6s/HVfskdGWwQZY87DcyUViZpy0nQ7Mz9wLh
 5f2cqFVPfzNF3hHOudiWuTZHr0ZUrYuJPSd4CnLf+fbpoh2zjVq1AeVOvkVLhGNGXa2M
 4SVK93xwJrPZCVINzmhLTWUlFiKN+U5C6glGUWSANyy5raD+Juo91XluQ701WR2kvn18
 mRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793899943; x=1794504743;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0shBI9eNxj8mLErHegDmDFNR3bVC+OjP5kJI7+/nEro=;
 b=HeHfEbSfPxmSQy6+ivlqwBLMuKgJ2gt+7WJg639dxigY/xPKMV48Q+Ux226GUqguDB
 skoHqcjWTHqCbrcoN9XB2ezXKL83EYmdTgvj/FRkL6g9jpQI0OlQ7soApCg2FDage/uL
 7w8OL90RT9KeG/BMEbrhmAIarVmrtEy0mzLNdE3YxqhINumOxEQ9tlEk2jONNHNxOkqM
 ZB83qL6zjOFGUPIBSip5mHvADMuyct64hkUlRKO/8C1f1VR6b2yMXWSV4oXEyPVv04Si
 NkhEAdaJPE8lN5a/KwxqDgcRQTPKLxecsI+kM9S2PE7oBoV/1yV1Xu9i+uvnhHgHBaxH
 4LOA==
X-Gm-Message-State: APuU4Z8Nx18wK2YchzYz6ZzNHh5NRE2jK2OpIdAsisLZZN2FZTpd+2PV
 +l1TFuEQYa2xPtrVArcJtA/49xiRHHZZm/XYWbhg323LWJGtfbHdNsDJS4yXBbIqhmwQwd+x+9a
 uXiRfUmNNewDqJJQ3KlKiDkv6I1Bes/hfKP/t/hwXyD6VJL5qPj7JwRYgsVp7t0WN8YroOEAHJf
 Oyhffjfg==
X-Gm-Gg: AYBFou1eEgPb1FLfaVkJrOeg5SQyS9CyNcFDI7MOlK4bH/nc3itE5mZ0aXz2H/F270U
 XA1MJJhA8dmXOmQ6syyEzhqTcMUBosVcynhswBRu95zoawo/p4av9tYsorS087YJ0lRlloC6QLw
 fVj+KJSXZ8ARKxjL95XPaTtzTLofIYbJjlsyVpcjmnseMRWCRIx5abQCdds3x38NJn928nXO6zg
 NMpZwDMzDik75rOq0XPY8JO2JgGxdxnjk58c7UABTguWQ0PiDEGQyayzqfoN+CcXaPRDh9g7J62
 /jFfCKAsoU2KXw11+Pimf4Ys0r39/aqCkT8QZtks3YZ9LQ/etkTW4gQbmaIsOKhCmq4BG3NIFK2
 kYw8RRMmw4kj5/RzTs5hjtERXhDauSUDE5fDsoz/3WNEQiTqgw547KtVy+g8G621lf6TUyv/26K
 QPnnXYU7uJsG4AgrehrE3oz5BOcNS2M8BwKYBL/iAQ/5KEoo4Sm+v2KKj5TcMWbhVS65jjo3raX
 eVDL9cQDGkNPKjBKOhozJUVjtj8/nX53cDhwbyhKiLR2bObCmChy0moY4pLj7B9MImAGAtGGIlz
 BXaZy1rFchltj/vbTsxmQlrPhnmfEK1m2MyBA+CLIbLEc/MSn/UoVbZw8zKKj8H1S3slAIBZvcY
 lczKm+JVFaQdJJacHx+vYzhtVAOU1eHdQRjM1BxF25C4Kp8AysB2FCOG5zwW3ZO7LZrn+veotVG
 bW+OiPCQWcbYAQUQ==
X-Received: by 2002:a05:6000:616:b0:490:369b:f50e with SMTP id
 ffacd0b85a97d-492762c542bmr665015f8f.19.1793899942636; 
 Thu, 05 Nov 2026 09:32:22 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed553441sm10144098f8f.43.2026.11.05.09.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 09:32:22 -0800 (PST)
X-Google-Original-From: "Ralf Lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 17:32:20 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4
X-Gerrit-Change-Number: 2037
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2037?usp=email>
X-Gerrit-Commit: 89922173c29fd19bf3310aa6ab34db88206542ae
X-Gerrit-Comment-Date: Thu, 5 Nov 2026 17:32:20 +0000
In-Reply-To: <gerrit.1793043747000.I695967524bb9e83887b8c07d0d09baff6e41acf4@gerrit.openvpn.net>
References: <gerrit.1793043747000.I695967524bb9e83887b8c07d0d09baff6e41acf4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDQzNzQ3MDAwLkk2OTU5Njc1MjRiYjllODM4ODdiOGMwN2QwZDA5YmFmZjZlNDFhY2Y0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <80821c068df8f42b12daf9b8a66fe6197197e14e-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xP1K9-000000008KB-25HZ
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add python scripts
 that demonstrate the ACC protocol
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Ralf Lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Ralf Lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3993338141830898542=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3993338141830898542==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uWOlRlCupto="; charset=UTF-8

--uWOlRlCupto=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Name of user not set #1=
000061=2E

Ralf Lici has posted comments on this change by Arne Schwabe=2E =
( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail )

Change sub=
ject: Add python scripts that demonstrate the ACC protocol
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 7:

(1 comment)

=
Patchset:

PS7: 
https://sashiko=2Edev/#/patchset/67d1d819918ba106750d9248c=
7e7a1d89e0ba088-EmailReplacePatchSet-HTML@gerrit=2Eopenvpn=2Enet?part=3D1

=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I695967524bb9e8388=
7b8c07d0d09baff6e41acf4
Gerrit-Change-Number: 2037
Gerrit-PatchSet: 7
Gerri=
t-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Name of user =
not set #1000061
Gerrit-CC: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Name=
 of user not set #1000061
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Comment-Date: Thu, 05 Nov 2026 17:32:20 +0000
Gerrit-HasC=
omments: Yes
Gerrit-Has-Labels: No

--uWOlRlCupto=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Name of user not set #1000061=2E </p>
<=
p>Ralf Lici has posted comments on this change by Arne Schwabe=2E</p><p><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2037?tab=3Dcomments&amp;usp=3Demail">Patch Set #7:</a> </p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">https://sas=
hiko=2Edev/#/patchset/67d1d819918ba106750d9248c7e7a1d89e0ba088-EmailReplace=
PatchSet-HTML@gerrit=2Eopenvpn=2Enet?part=3D1</p></li></ul></li></ul><p>To =
view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=
=3Demail">change 2037</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2037?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2037 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: Name of user not set #1000061 </div>
<div style=3D=
"display:none"> Gerrit-CC: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Name of user not set #1000061 </div>
<div style=3D"display:none"> Gerri=
t-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Comment-Date: Thu, 05 Nov 2026 17:32:20 +0000 =
</div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div sty=
le=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--uWOlRlCupto=--


--===============3993338141830898542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3993338141830898542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3993338141830898542==--

