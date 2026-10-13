Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9C2CC6B1A
	for <openvpn-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1zARyBld57F1uJV/+1XIXCmdmzEI9O/YYexGbVyzKUE=; b=Oh+w5nkfarJfc1SscDJIgx0E6O
	M95qzAtCsZ71rw0Uba53pEqur6PGSaYhUcbNFdPXllyjBcFx1TZXHAJxYQv5Vv6syZGx4ukJ7HOen
	myVD6W5x4UjGSFq9FV6NuXr5vIgj/ew6SppqPtUw1AcwNOZuT37j2Sjj48xzxwvrUNJg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGhD8-0008RL-EG;
	Tue, 13 Oct 2026 18:26:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGhD7-0008RF-My
 for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 18:26:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=rbXpviUBW38PxikK9/AIkNvII92IANnzXjbOX7qWLGY=; b=hrzUenZku2OJlKAsXTlSzRtKGt
 4Z1fdVAaR1H3iOTqdTRrycX+3jYGgNVvgiFx1MIibSQaAe+NBpW1nDBBS5Mj7eqGTSLlkIMCj045R
 Lu9iI4C+1pFQw3bgr1sk0Euao10/REd55gWRpik/NUXoscV1vaApVlSf/6F4Scu500ls=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rbXpviUBW38PxikK9/AIkNvII92IANnzXjbOX7qWLGY=; b=e
 AOUsDdYypSbgSYwOzX2O7oMak3CKhvvEbCJJqVbj9Km+VoI1eIxH+9nlzi8JZF0q//ousOYEFGgCz
 guX0eW21xL3mp63evyON1T4/R47csRgSmnHVf2hnOtpCBkaaESN5c8++jzPJhSlyrRPnmBMvFxWyU
 sKCDoNwPQYS4U6XQ=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGhD5-0000ER-IT for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 18:26:50 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a16af2a232so26415755e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 11:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791916001; x=1792520801; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rbXpviUBW38PxikK9/AIkNvII92IANnzXjbOX7qWLGY=;
 b=bn6DkR19mYXrhqT2BI3ecRbc7pTPha8Cv/NC9Lf/OLYFrMaUQV3UN3ASRl9hUlc/x3
 6C26PhbpncCB3Tch7uGc6FkoJfoNmK8ck9rrB9wxb2NABDJFGy6jfiDWVSmzEClDNTKw
 jOPPsembajFWx5yIFeNsRsVmLYCJCBN5HYBDS1W64pZMaFHsDJx5MTYODrYE4rJEEk/I
 Xs01c7+N3tV/Rnp1LWJfqdUuo9ZtTDJUt20AivWO9QAeHGn1/mXdwG9RsUkpN/Nr8scO
 9bXjyFd7iF7Yhr6gByseKI+VEWc3+rlycXqxwlP2R4xiE2shPlXR5wb62IEzO7uVjsQL
 8XtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791916001; x=1792520801;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rbXpviUBW38PxikK9/AIkNvII92IANnzXjbOX7qWLGY=;
 b=agBNMEiFC7OOEKXnD5G2bULK2reREVgIovyMKpjsyFhk4AKIXTH+ytI8DBJFoFyOlE
 xxXxoa+VmO4nG3/q/woDRmUPu9NdGJgyQpOSnjxZTZGDo5ZR40CMBvaUzFIMzhUZ+RiN
 hebh66wdNaFpxtJNJo9EDP1aNOeCKNe4D/G8ZVpwbyKzbQVS7k+d+wm5kToneOn8AW/W
 7v5g7afna5F9FGKx37Wo4m2zCuckRizhAxbcK+AHDCP2jh20WzI//8qMSYrsopShlVms
 cy99GZCLIxhjmCm7YJC2BbjbInK/q2ujFXpuO/bLEjkuRaSXCSlTnkF8ThBwKC5Vi/3H
 fQ0w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhwpQV1o5GM9G6KCWpJ6MGaIwxdgqFUdTHmaDMgvxs1XFqia2y6r3oM+fxZ92jZfYX2r1Ee5YIuWJ3JDQQ@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLbwRPoIx7XjWygd+caqGr2ue394ySyxD8VYbQEMISHvnijiKBx
 9DPH1DPDnQqV6HNR+vMepIsuIkG89pg1vcFZ5jMpTKQiU/nzXvma+I0YSA1jVLPNjBfjL2LEj5Z
 sIZrN/NXrhPdZH8LtGvIsidXDMLZcU0R0fBFuLIn80QF6mHp2I99CEk3CqMlrZNtn104J
X-Gm-Gg: AYBFou3D3GZyMhuCivY9MDj9N5iKWwpQL335MiCMlg8t8OCCHz9iV38yhjxGFq7Peso
 m/wtU4BJbvxTMYQ9YgEIs+y650N/FGyNWBXl6zLNVwq8zvRPmFbQpqIlKX01q63M6GECx7H9mDv
 iZdB0ecpOT0REeptDsSKMzIZ8n2NjVbonSsFts4LPOgpeN9JFpSFrf+ApWy7nk+00/Ov+J/xdm3
 BB7JwkBWM9p0FKE3NgPMeWWArDh9Tkb7VWL9h1l+2fM9/xMv70P2Sg5ToxzH50luM9ucgkA5sTF
 3Xm6JJQ5WrqF9fPmQpJDC7jzKsEwLVo6eIwKnfaTALI1S3tJeQucSaLmpxF6wDX53ZvYcX9bKwO
 FMY2VYKKrIcG0by0BkaHeIdVTfZH8ffCxIKIxDM7oGFPfb2MJezcXc0oCFleCNStXCfLbOIXdYi
 KjTkM0S8ZF1K2aRIwCilo3/svk6OcziMvHtsB8wzDLTF5hu9bkoT9MpT7b4qIWh8lE0Tyc5WCWA
 eytbMVruBptLnSIpf8VkdaHrKVOq7X4UpIEhLd5UEhdrXvh3UTgr/R04bh46+X4j70jZDNzVwIS
 CnTKsIzAs7YZHzTVrVS/2BFNSDSNFV9+ZQo3vqiqQ+X77GCn7Q85Fgniym8QqS1lcsAuUqk=
X-Received: by 2002:a05:600c:154b:b0:4a1:6af4:c6be with SMTP id
 5b1f17b1804b1-4a18e4d1c0amr246872785e9.34.1791916000596; 
 Tue, 13 Oct 2026 11:26:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0aaaaebsm6943684f8f.14.2026.10.13.11.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 11:26:39 -0700 (PDT)
X-Google-Original-From: "Steffan Karger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 13 Oct 2026 18:26:38 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: I00821d75342daf3f813b829812d648fe298bea81
X-Gerrit-Change-Number: 506
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/506?usp=email>
X-Gerrit-Commit: 233e10aeec7de02d34fa5c517b44612d38ccc00f
X-Gerrit-Comment-Date: Tue, 13 Oct 2026 18:26:38 +0000
In-Reply-To: <gerrit.1706186293000.I00821d75342daf3f813b829812d648fe298bea81@gerrit.openvpn.net>
References: <gerrit.1706186293000.I00821d75342daf3f813b829812d648fe298bea81@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzA2MTg2MjkzMDAwLkkwMDgyMWQ3NTM0MmRhZjNmODEzYjgyOTgxMmQ2NDhmZTI5OGJlYTgxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6f8a513133f7628af4b7564935fe34caad311af9-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGhD5-0000ER-IT
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement support
 for AEAD tag at the end
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
From: "Steffan Karger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: steffan@karger.me, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com, gert@greenie.muc.de
Cc: "Steffan Karger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1977488078329394620=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1977488078329394620==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HbW2Vc5hZv0="; charset=UTF-8

--HbW2Vc5hZv0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Lev Stipakov=2E

Steffan Karger has p=
osted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/506?usp=3Demail )

Change subject: Implement support for=
 AEAD tag at the end
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 9:

(5 comments)

Patchset:

PS9: 
Closing old open comm=
ents=2E


File src/openvpn/crypto=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/506/comment/456fc94e_df3b137d?usp=3Demail :
PS1, Line 426:     uint=
8_t *tag_ptr =3D NULL;
> Not sure if the current static analyzers are smart=
 enough to detect that these (non-const) variables [=E2=80=A6]
Done


https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/506/comment/2abddffa_1703a3ee?usp=3De=
mail :
PS1, Line 463:     ASSERT(buf_inc_len(&work, outlen));
> Good to add=
 a newline to visually separate the decryption from the authentication, but=
 the buf_inc_l [=E2=80=A6]
Done


File src/openvpn/ssl=2Eh:

https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/506/comment/36ee5594_435289d1?usp=3Demail :
PS=
1, Line 111: #define IV_PROTO_DATA_V3        (1<<10)
> This means that this=
 commit can only go in together with commits for a larger peer id and large=
r IV, [=E2=80=A6]
Done


File tests/unit_tests/openvpn/test_ssl=2Ec:

https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/506/comment/9def35a0_b6433278?usp=3De=
mail :
PS4, Line 272: run_data_channel_with_cipher_end(const char *cipher)
=
> s/end/tag_end/ ? (Or even tag_at_end)
Done



-- 
To view, visit https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/506?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I00821d75342daf3f813b829812d648fe298bea81
Gerrit=
-Change-Number: 506
Gerrit-PatchSet: 9
Gerrit-Owner: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Review=
er: Steffan Karger <steffan@karger=2Eme>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Lev Stipakov <lstipakov@=
gmail=2Ecom>
Gerrit-Comment-Date: Tue, 13 Oct 2026 18:26:38 +0000
Gerrit-Ha=
sComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Steffan Karger <s=
teffan@karger=2Eme>

--HbW2Vc5hZv0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Lev Stipakov=2E </p>
<p>Steffan Karger has posted com=
ments on this change by Arne Schwabe=2E</p><p><a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/506?usp=3Demail">View Change</a></p><p>5 comments:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/506?tab=3Dcomments&amp=
;usp=3Demail">Patch Set #9:</a> </p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">Closing old open comments=2E</p></li><=
/ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto=2E=
c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/506/comment/456fc94e_df3b137d?usp=3Demail"=
>Patch Set #1, Line 426:</a> <code style=3D"font-family:monospace,monospace=
">    uint8_t *tag_ptr =3D NULL;</code></p><p><blockquote style=3D"border-l=
eft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Not sure if the curr=
ent static analyzers are smart enough to detect that these (non-const) vari=
ables [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/506/comment/2abddffa_1703a3ee?usp=3Demail">P=
atch Set #1, Line 463:</a> <code style=3D"font-family:monospace,monospace">=
    ASSERT(buf_inc_len(&amp;work, outlen));</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Good to =
add a newline to visually separate the decryption from the authentication, =
but the buf_inc_l [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li s=
tyle=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl=2Eh:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/506/comment/36ee5594_435289d1?usp=3Demail">Patch Set #1,=
 Line 111:</a> <code style=3D"font-family:monospace,monospace">#define IV_P=
ROTO_DATA_V3        (1&lt;&lt;10)</code></p><p><blockquote style=3D"border-=
left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This means that thi=
s commit can only go in together with commits for a larger peer id and larg=
er IV, [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"mar=
gin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_ssl=2Ec:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/506/comment/9def35a0_b6433278?usp=3Demail">Patch Set=
 #4, Line 272:</a> <code style=3D"font-family:monospace,monospace">run_data=
_channel_with_cipher_end(const char *cipher)</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">s/end/ta=
g_end/ ? (Or even tag_at_end)</blockquote></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul>=
<p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/506=
?usp=3Demail">change 506</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/506?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I00821d75342daf3f813b829812d648fe298bea81 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 506 </div>
<div style=3D"displ=
ay:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Own=
er: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Lev Stipakov &lt;=
lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Lev Stipakov &l=
t;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comm=
ent-Date: Tue, 13 Oct 2026 18:26:38 +0000 </div>
<div style=3D"display:none=
"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-L=
abels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: Steffan =
Karger &lt;steffan@karger=2Eme&gt; </div>

</body></html>
--HbW2Vc5hZv0=--


--===============1977488078329394620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1977488078329394620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1977488078329394620==--

