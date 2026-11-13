Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991D9606A338
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=geYJmm40;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LK6Um+7F;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NRSTZnAf;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=CkyIZody
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=WtHvxZRPVU2H5umnYkv9RsJoRCkC9017UqseCrCx3EM=; b=geYJmm40pH6029mS901aH1lOs/
	3XD6bCcl7F401JxyrALNZGuKqmy9Gh74OuvNa5+SCwU38AhQgluC9r80mWJw+WDUYQ1T0IGP63xMb
	UbdcFEG8Yb0R9BxwtcKwMDmYpfjlaByAPxDABevCaWgzh/bFRdu25cSnqj9414hnqa0U=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRtaw-000000007Dc-47HS;
	Fri, 13 Nov 2026 15:53:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRtav-000000007DW-32f2
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 15:53:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LhO2KSq+CRsuyUoOrz0KW19hfwbjzPmK51fTV3Qbn08=; b=LK6Um+7FhXizfq5mrQiaYDE4jW
 8fBAylHWrkBpD/x6jbwvEgSglO9OihSFYC1jAWsB6t7BxR6ckJO/QI9Pi0ZxEHyujC8mP6G2BbD4E
 Y56WtGY2JqwUdkzBzTFw4nDjlQs9SCP2FNA/aZf7mtPt8gkvUL1ISS4GCxdR2tF8K62g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LhO2KSq+CRsuyUoOrz0KW19hfwbjzPmK51fTV3Qbn08=; b=NRSTZnAfHk5AdJgqmPl3lbwH3Q
 Guh21qH2D96bsQ/W9zpSsh+W1cgxpPxq8N7T2ewHW+cP/FEgYhRRAHt250FidDjI1GilnAdmdGC/Q
 x+x91qFPrbC5rsGL7Ug2L40E3BfEGM0dBkNb29yECyQy42cftWayRktFjYIaOadmW3hk=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRtat-0000000084m-3rqB for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 15:53:41 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so527832f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 07:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794585213; x=1795190013; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LhO2KSq+CRsuyUoOrz0KW19hfwbjzPmK51fTV3Qbn08=;
 b=CkyIZody2yaNcUWU7sYV5wsnlxXVhUKG/ERxaHQ38OtJVD9WgPuFBoSulCtvBBXnq7
 qXNrbEC8NL23llUGJzYY2xq97f6HWNRrbHIAAkTI/dtdnRFXVzp5+juFSz6rWBZHNRRg
 GHskqMeRLuRj23Xto73624ON91zvZJL2v4Jb52IMRcn2p1Acp1oeILMt37Kx/fdaWvTJ
 OMyTygoxb+1+UuXMUjz2LsLT1szFCMJjbkhSCGzJJJYhDexTSoxnmMVDY9mpsYG9F5rA
 YWyQqYs9G4iVf07C6PRFCAEMlamWLptnzNSvA4dAT+GWNpy35Vv5splXeMMZw4Ce7Oha
 PXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794585213; x=1795190013;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LhO2KSq+CRsuyUoOrz0KW19hfwbjzPmK51fTV3Qbn08=;
 b=hldZ7RTzNuixGVajFKtvAKpFgVaJAFs6QQy9Sa1DBzFf/ZtyaP/6S0kITjwQxnllfu
 y+GJUYJajjaL2y+za4aUfXlVgCgtfUwlO9uMBcdJYcxhirCSlPFeNgfZKc+kR83KwSY5
 PnUmp5OsDxUT4x6/l8xf7AOtqjxY97NA5a197wce6FwMFKQlYRJxk0E/HKbBNHTiAtrq
 qPu70BdwzpORVBtbPMSyeRGfLXngYQBm//yXH0i3j52zjYUl2Gk2YriBsOfBHcfxsX9b
 kwHXfLNZnxDhhy1aMuhDHh+z7e62mDK3brXAUmB5ork72TiufRSOESriEQMBULLc9bEC
 eqSg==
X-Forwarded-Encrypted: i=1;
 AL+hErEVO8ddOXw9uQszvaJLJCOXIoIBgcnsdsb+rpHVyHO++om7jphNy5tw55WJw6Rge2IHjpEwvTBBFAq938k3@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+J9ZFrjFonicWnmF7EnRNOVm43GI7F76eLTMFNN3lg8fssTRxc
 cGBGZEG1Btl/7MNEfpKYDl5FWEEZxXsG3ONf5oa46ucfoNHz8OxowPKdmcHMJEYKSSKOcYk9OXQ
 B5ckxuWI/2KfaXf2Wrj23scXdzhNchN33fxHQew/xp3P/0yhL23cZW6ZMGxEc/5JpP47X2eIBgu
 +i6eGG1w==
X-Gm-Gg: AYBFou0PwLP0luQt8hctW4iqLhhkTGxqzTRGbbuDk+jiy/a/qB4MTGz6pBmL88l2NCN
 qti08tmYgmxxXBNYQYXh3sGgzJeItZSlxthWsqWmoJq9dw0zeFLzFitxyRLcCUKiz7Xvy+91rBr
 kVcTm/Nyl/Of/S7uEF5BpFs4qNdWrwo7/4QUmimo/CV9ELv6faa6MffFli/kul/9489pJm7h8IS
 7o4ziN4SwElrbkNSRgo/nWAK0YizO4tl1wA08ybRWxeFPfK9lKh0bLLeWQkRiZhrCI6HkI+J10R
 AWYmi/0fT2xjBk74xmLsGGdPhZEfnTDi63sn96dfnXFVDIVMZ38uQtkzEhFui6XF7yHeddDMp0W
 8L2nGesToQuZM7/AaDsh3/iXb9P1t3NalID8WzcC2xgsVVZwcGwK8ZoyBJA56t9/GxojzMqHSlh
 zOHa1tJiVI3Mf5qf9wMqnvpX06A/Y7gYphVHyOFE5dGZaf0a7cfSWyKezWzVaasu6f4nQ4Ss/le
 mmEfekRp9xeMV/pC31/fBPPavd6Tw2FfBsie5MDOK6EyKrb0pUfyQprfdmEh4dBq1H7Vic1cRbJ
 dlx89fTn1pFDAElop0xpTZvUy6i3n/1VT4s+1LiDEM31zzHAxAV3CZ/xpP2xnn3wgcj3Lwhl9Yg
 6WbgwjggrBk7RkEow871d6lUC9ALSMsokrtx8ejpFY+ycMIKtbpFiLpASwApUCTHNcZCzEvBtMj
 AdEJR5elbaKke+EFA=
X-Received: by 2002:a05:6000:4a12:b0:492:bcc3:9e86 with SMTP id
 ffacd0b85a97d-49c73ce5a06mr6289003f8f.32.1794585213000; 
 Fri, 13 Nov 2026 07:53:33 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c604ecda5sm5833024f8f.37.2026.11.13.07.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 07:53:32 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 15:53:31 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I387f652ecba92283a272610ff0780273c4902996
X-Gerrit-Change-Number: 2183
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2183?usp=email>
X-Gerrit-Commit: b93ff5f6b9df9d34173ca02098a47ccfc7799c17
X-Gerrit-Comment-Date: Fri, 13 Nov 2026 15:53:31 +0000
In-Reply-To: <gerrit.1794571077000.I387f652ecba92283a272610ff0780273c4902996@gerrit.openvpn.net>
References: <gerrit.1794571077000.I387f652ecba92283a272610ff0780273c4902996@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NTcxMDc3MDAwLkkzODdmNjUyZWNiYTkyMjgzYTI3MjYxMGZmMDc4MDI3M2M0OTAyOTk2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8a647ab8ca637eee6ac150535bd32de0cd72f48c-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRtat-0000000084m-3rqB
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_openssl: free
 what PKCS12_parse() returns
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2778992249095366359=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2778992249095366359==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="U7XPgpRb9lQ="; charset=UTF-8

--U7XPgpRb9lQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2183?usp=3Demail )

Cha=
nge subject: ssl_openssl: free what PKCS12_parse() returns
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2
=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2183?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I387f652ecba92283a=
272610ff0780273c4902996
Gerrit-Change-Number: 2183
Gerrit-PatchSet: 1
Gerri=
t-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne=
 Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comm=
ent-Date: Fri, 13 Nov 2026 15:53:31 +0000
Gerrit-HasComments: No
Gerrit-Has=
-Labels: Yes

--U7XPgpRb9lQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2183?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2183?=
usp=3Demail">change 2183</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2183?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I387f652ecba92283a272610ff0780273c4902996 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2183 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Fri, 13 Nov 2026 15:53:31 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--U7XPgpRb9lQ=--


--===============2778992249095366359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2778992249095366359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2778992249095366359==--

