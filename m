Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421C0606A324
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 10:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mcZbHZjB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ExzgKVb7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TXEEJe55;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DiewdX5B
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7AZ/Uyr31HPQyvssdE13bni6QT+KH+ewhNIdd7HvsK0=; b=mcZbHZjBnTqoRNLxhIV06Aq+tr
	ZFJyyP8dFIAY+m61VS1T7eWG2JEDmg8sojzR9u6QCsnLhyot+ajKlzOIBOPCNIpzdk0q+2B2/E7Hl
	BDqY5yVcwNpKRVLANS3V2Ct/FkcyL8vB4TtSYldW/7vn3+qmJfHcqvWTJJaQ0WcsqI7I=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTzpx-000000004w8-3Tb7;
	Thu, 19 Nov 2026 10:57:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTzpw-000000004w2-2Eh0
 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 10:57:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fstZKiNF5D+SgbJz3lQ53CAQcKfQujj7oZKLgrUp0f4=; b=ExzgKVb7y8gyZkdX2ZFQkHq62W
 NCEPFf3Rr4JCdK6BXAw9FI9h6CH9QRuV316fTlOMB3afD2cI1hDBXefo4kVlLfBHUIH+sl6tjskAr
 9o2poCojVAxPXNdMo0BYh9x0Pjinm6nfc6ZtLw8DR6qtZMS4HJCBiZGgGvn+SdtOGwzc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fstZKiNF5D+SgbJz3lQ53CAQcKfQujj7oZKLgrUp0f4=; b=TXEEJe55CkgRIrIiiyQoKJ/Fjq
 xyhNy+dBeP6iJ3Z9/FShCuZMcdZCPXq2doavONb6cUQ4U9F05eGC6cOdsSqa9yolj1xVLnxVAwERU
 say3V8wMJntFB4MnWoFThQjGeaehiz1JYXYozpnlgpjjMugCQOOfHuNopggaBcbDOXY0=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTzpv-00000000668-3KzL for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 10:57:52 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so24480855e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 02:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795085865; x=1795690665; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fstZKiNF5D+SgbJz3lQ53CAQcKfQujj7oZKLgrUp0f4=;
 b=DiewdX5BSiPChDlOgks20oDHRZ7zuypqhNnqyyNMMP/+0zgAdFxMaaaerVKBZez8Fh
 AgKpEZYV5z3bhrEpP2A7M32qlJXP2nVM0g+ZkCzVD/E/MgHI14WE0FXhq70z/AzmqFLm
 sgZ0LSuxV2asWvjQNBM+6DguJt0E5RsYapAmTb4nYoD9E1qBgt1ZCwOqP5RXDiC1mj9o
 Etr5nKOuivNJKyodJLeBpOm3VAxBg6sfcLotyRW5eqWU6spykTc3qBq35jdZvG3FJOYN
 5GiHivbtTuIHkZok9vGlHdwYmBBnGRYi4YUucoUaX2U0ZmX3WbP0Nbjqw31U2tzYZlfZ
 pKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795085865; x=1795690665;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fstZKiNF5D+SgbJz3lQ53CAQcKfQujj7oZKLgrUp0f4=;
 b=gfJSTZT4SSPs8y3hwv0EZHrE7rJzEwF3L6ED5NXCPISLClr/zpb5Nvs5gGA0iIMt1u
 J3JISiR2+GgAts/RDe32xP77S1oMuytEHMWA0kYTVOEkHN8X9wAUMXLGWnZPDhkUo+yn
 Npz44BYVzNR0a6aF0JnF+0edPnxFwy6ifpT1ilg3N5xLiNXH9YeoOZwSb5Cm0+IGz9dq
 fdHKTloB4rCJHGgt2sDR+gSYFL8qVK5i6lGFFgFU7bnbDsAWvHsh1CQZdKn4SwS+dnNR
 oq6dYfEsTbHK2WxGeYGKN8zd5j7Sb5CicT9PQ6tckuEqLY0reEkQIfyh36qMcfywu1r0
 O3uw==
X-Forwarded-Encrypted: i=1;
 AL+hErGXUnLMArt4typ42DVfdVcmCG7RyHAPgoK5OdqhKGGLbnzyyoZ2x/kL3dppgQStOoRGVFXG9NeE3c9i4GB2@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8G+jmuKHq8xECGnveL2LhpbE1AWr5VjpNmY8a21Ek9pvma4L8Z
 ASekuyww8ZFlaDgCIOrDOHkRdyqF1qBU4iXHtLxUOL6OqoVLAq/WNB2wERTVIR/583/gnK6bQZX
 bmLMHMV70A5vurVqaDHXklinKX1PnKn77v5U7CGBV1IkvO7COLU8CLhNEGoTOqpbfH7ZS
X-Gm-Gg: AYBFou0ss2UsClz3z+lFtjtWE6jv7Y2EAhKuPRyn5l0La2hxpzPeUV0phaAhmWX4OfM
 R3FVmOj6A/zA5OuER2GuEqE0z77Ss+1+WoLG6oIEqeAeSluZOMlHiENTgt7uhdgAu9Ip41Y/Vqp
 d69jutEiYhs2VU+CQZ1YP5tgx9a+CeKvkOPdhoqgtYV7WJiU2S9WigLDaNt8V1/ZLaIsW9OU4qA
 HZWjFZzueOySLZ2BbgrqmTVC5jCQyp9OJmsOR93X0RBvPEtqsVEkSPN+1JX7PKp9RJMUcFmdgJw
 7o61zAivsthaukoHxC7/ihyjENkdCs2tZMcVOXwoTFAOv5xENjtBy3OKhq9FmfdDgQupcxbkDLK
 5K6b94DTxN3EBkBBFfyxXD9GKBQ+DxF0IsyY4zbd8965Oq3LhSaNaeqbv33/kbkeChyL3/ms3MX
 izBkXICtjzn9Et0/149gbmJ7DxGx27lO9iBNInt+3uz2VLdT41iFuXn5zVUKI9ga78CiWFnC4lN
 xzr9706eIv1V5BMdCjAJqjeSElnY8rMqLe402tZFaoFglC8SniEhb6HCIkWKygXITu/lyV34+vk
 VIwh3pU6loof6O3XwLaQPtLgxMK4c1ymTif1SKCsUuQhmKLnBuOAPRd2CJSLREpxbseIiiMPPTr
 1hSy+IHgBWxmolRiWoWqjiv2MJCQxNqAq4Fe8PIolVpC52A6YQ87a7VoKfga3mvH0nO2zDoQSMg
 O2Fj2eEQg3Qmd6wlS6Lr22kw+tPeeliqGmR0l6
X-Received: by 2002:a05:600c:800f:b0:4bb:5bf3:8ee9 with SMTP id
 5b1f17b1804b1-4bb7da4ec63mr113057245e9.31.1795085865043; 
 Thu, 19 Nov 2026 02:57:45 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8534d908sm30781165e9.9.2026.11.19.02.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 02:57:44 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 19 Nov 2026 10:57:43 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 28
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: dda90ce314178fc7e85df6a52ef4842fe1911b6a
X-Gerrit-Comment-Date: Thu, 19 Nov 2026 10:57:43 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c2679a2b1647a8ff3eeb60fc9916d8018edb8a5b-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xTzpv-00000000668-3KzL
Subject: [Openvpn-devel] [L] Change in openvpn[master]: control_msg: Add
 P_CONTROL_V2 and the probe request and reply TLVs
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com,
 charlie.vigue@openvpn.com
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1116471356304425147=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1116471356304425147==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5x6IYJ75s6M="; charset=UTF-8

--5x6IYJ75s6M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Ralf=
 Lici, R=C4=83zvan Cojocaru, chugly=2E

Lev Stipakov has posted comments on=
 this change by Lev Stipakov=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1741?usp=3Demail )

Change subject: control_msg: Add P_CONTROL_V2 and the=
 probe request and reply TLVs
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 28:

(2 comments)

Commit Message:

https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/46bf1b77_338f7048?usp=3Demail =
:
PS27, Line 41: CONTROL_AUX_V1 after them needs to be carved back out of a=
 range=2E
> `CONTROL_AUX_V1` doesn't appear in this patch=2E
Right, that wa=
s a leftover from when AUX patch was in series=2E Dropped=2E


File tests/u=
nit_tests/openvpn/test_probe=2Eh:

https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1741/comment/1bde22c5_aeba379d?usp=3Demail :
PS27, Line 53: #endif
> New=
line before this?
Fixed=2E



-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1741?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
Gerrit-Change-Number:=
 1741
Gerrit-PatchSet: 28
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom=
>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewe=
r: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Ralf Lici <=
ralf@mandelbit=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbo=
x=2Eorg>
Gerrit-Reviewer: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: =
Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: chugly <charlie=2Evigue@=
openvpn=2Ecom>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eor=
g>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Atten=
tion: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Thu,=
 19 Nov 2026 10:57:43 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
C=
omment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--5x6IYJ75s6M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Ralf Lici, R=C4=83zv=
an Cojocaru, chugly=2E </p>
<p>Lev Stipakov has posted comments on this cha=
nge by Lev Stipakov=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1741?usp=3Demail">View Change</a></p><p>2 comments:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Com=
mit Message:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/46bf1b77_338f7048?u=
sp=3Demail">Patch Set #27, Line 41:</a> <code style=3D"font-family:monospac=
e,monospace">CONTROL_AUX_V1 after them needs to be carved back out of a ran=
ge=2E</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin=
: 10px 0; padding: 0 10px;">`CONTROL_AUX_V1` doesn&#39;t appear in this pat=
ch=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">Right, that was a leftover from when AUX patch was i=
n series=2E Dropped=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0=
;"><p>File tests/unit_tests/openvpn/test_probe=2Eh:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1741/comment/1bde22c5_aeba379d?usp=3Demail">Patch Set #27, Line 53:<=
/a> <code style=3D"font-family:monospace,monospace">#endif</code></p><p><bl=
ockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 1=
0px;">Newline before this?</blockquote></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Fixed=2E</p></li></ul></li></ul=
><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
41?usp=3Demail">change 1741</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1741?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: commen=
t </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 1741 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 28 </div>
<div style=3D"display:none"> Gerr=
it-Owner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld =
&lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: chugly &lt;charlie=
=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: o=
penvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: Ralf Lici &lt;ralf@mandelbit=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: chugly &lt;charli=
e=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Comment-Date: Thu, 19 Nov 2026 10:57:43 +0000 </div>
<div style=3D"=
display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> =
Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-=
To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></htm=
l>
--5x6IYJ75s6M=--


--===============1116471356304425147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1116471356304425147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1116471356304425147==--

