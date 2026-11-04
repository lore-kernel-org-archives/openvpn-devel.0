Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A13606A33E
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MsXd6PWj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hkxGRP6y;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=l5cEs1AD;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GVbrGRSX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XLuLODF7Um65Xnx35i3aYfSs1IRWEl+5nm5SzsvffjQ=; b=MsXd6PWjOEjFpg+yJUnf+iGlJu
	Rg0hC7TVQzrMO/Gy78yTeEqNE/A6OvMFygoc+cE5IIVaYmgb8WE6pF0US5/0ADq9acHhmFUO8JVlN
	APwUbPaVIV2kld3IosULdbMzudND53SHC95wCtvG+8bwHkPZZKv8imfL+M5+0HJIDQmY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOdkK-000000001tJ-3Eqz;
	Wed, 04 Nov 2026 16:21:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOdkG-000000001sj-3lXG
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:21:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KHOJvPAosNt5qSAMnZdSiBgqLxh9M3+9e3/jmruI5Tk=; b=hkxGRP6yB9i5cECYDLP1BjjpMH
 4aVkjdMX7WTNAxlxkH86HN/I0mH42BjJfSVmxM49bMei21TTkiYBelYaYUBSSzambqPoayN9UT1Qp
 tbHfJ/apWAKSO/37J791C0PvwWGzoN+6Afr1aGpTULW3PoTacxzqUS8mGCGq0vMa+5bs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KHOJvPAosNt5qSAMnZdSiBgqLxh9M3+9e3/jmruI5Tk=; b=l5cEs1ADEotMJWrTpEZ5YBorL7
 6KL5rKkLHWaLBJkK48dCKPNmkV9QfofcILHTWQLxjqJijGaBG1ldU2fbjHeI89Y4JPaix1v7buDFb
 r+8HuTaTE2zUkEaMDVCWOXUYFc2jrzj1LoZGdTTjQNuJ9gsSo0TNuirlhyvyQ1CK0vaQ=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOdkB-000000006Ce-2xSl for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:21:49 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so8233665e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 08:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793809301; x=1794414101; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KHOJvPAosNt5qSAMnZdSiBgqLxh9M3+9e3/jmruI5Tk=;
 b=GVbrGRSXgV4n1UKEt4b561dvtApcv78FPAx4mLaZnFvsjy2m8XkH052cD9MG5uLnvB
 6FsavxGFrtYMEcFfB+X+9HI1Z4QjGITfCyXulW/jFK91xO6tUU7PdkwJLwOvBd+JJxAw
 dpBmNh4d8WShzRsHWte/31Xdnq/lUf88y/4PA5eybbGea3CWTYwGosQFHiIWSZm6DWjr
 8YLq7cq83QZ617jnuX0e6C226Cx+akjcloOcXOR34JOmmpzu7KWmW4Rl0no74qTcjb7c
 OCf6yKUNSzZSoVUG3LKiu1/LZjXFwwDLOo3aYLYgDKYu8US94HqJfgFSNAFL5Q3QrE35
 oFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793809301; x=1794414101;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KHOJvPAosNt5qSAMnZdSiBgqLxh9M3+9e3/jmruI5Tk=;
 b=djEXBlyGdIo1S+8rS8ZhHUfmS7crwPdABv3IyyXCK3LpUSIzc36vSkzPQYmGGAv4mE
 RpLfR8IXamlnHBwSSNowXzSlfUYbpvC3vDoRT7Gf02ZrNl/LrMVPkZdGlmImpfPIGMw8
 g8pMu98dAIjo48+jZEFDIfQQYeTQy9bswene9PBIVs9DEnUfIrCTnQY6Bt2OJXkCMe4G
 OaJfjyossMHGAVDFcVrZ+zA7NmTee9YY79HsUflb0dKaotRlXAw2OeNzGvj4MVo8kTxh
 xwYZceMnX+hyiTw7d2CZStWSsXMRxsYvxhf3Z5L6jmQkbZ7Dfr+W6cVN/YqNInH9j0i1
 /bbQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzfOkNBwDQFk82d2cSdEU7M+VFSYAG/ihKcGtpVa/6nCPpgZSTQfEyQtajLX05F1pIaPkCEfvT7NKvVkzUX@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8Ee64CLrYt28hVmvx4MthCL9e8fc7gvQDuOUIo1j3ppwjgIlcx
 FXWJBweIXuHkU4Z1ofiN0y81pP+n5TnZkMl01Ndfhtu8FtyoxLPJdgmiHMuMZhIUOTo4UHpboG1
 RouN9NQmtfc8LrWeTfhYDQ8RG34H3eSRHeds4Zr21gwK+jvdIOhdgrIDzlbLmDGwmS5Gm
X-Gm-Gg: AYBFou0zZ3c+iLuuPPdydnaI23nbIxOpn7Is2kP7fWRcy7vEHSBvJiIne/Fq2kZ9lBR
 k5Wa+sn0fpuDqvrZWlsfRME1q2ans1BWZIMfZpK6oIjNRKcDfaCtqvXr0sCiuweL5L3lnNHZhTv
 mFfxTD6+BENdgiXh/MGUneOIwWckZPDGsNkX2DH+BCdn/U5FMSGwoFUCTpUJbEVVkeKrzMy0jsR
 Z1lphX28yU+raSFt8Ae/XgqZaK4PSTPDOMyqSS1e0t48nO/LZEIX1r1hhXMMjByAPAsDzMgJCs1
 CHJr0O5RwEZ7Z09zkTgHLKYR2YbxOMBMZ1Mid3MPxs0sgIXVORY0XTELU4KsrxdoDRoybYvtB0u
 GYGJRwRUvTHWkhJhkTM4Z+tnuDMroBMZjebg07MO2RK9knvcl28JpD+PRYIf6XujqESJsIZSXvH
 eRShMl18+JCBWpVwFI5HLfc/6vubPGixsXKiEO4DED+Edw3hGbixluMC6nSsc2WoMxm52kuXEv4
 SvvcZyhpvX3rVBfczPL+hgUg/nE9HXfFddDemx7bc3ymw4NFcw2Bjgzyq/uX6opVFzONgjwOcN2
 1YxR/g9a3wB+7Gn7wFbq7PXpe4fNTs1UciA77XlsMcZMDV/wCS8UvA8O7Mq5ZaywfMrmNL0aNRl
 ExuWZN5uki5/VdFPuX6/u190E4fxzQ9v1TuSJebSI2QvP7fvx2mNisNySihKUdkA4V9fa8zS6X3
 mqnL5Nl5AsRfvqKxX8hIwGZR6BahmLO6QdUKo=
X-Received: by 2002:a05:600c:5295:b0:4a1:e92b:ae4a with SMTP id
 5b1f17b1804b1-4b3c3545146mr75866635e9.21.1793809300869; 
 Wed, 04 Nov 2026 08:21:40 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fec8d8748sm4762829f8f.16.2026.11.04.08.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:21:40 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 16:21:39 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
X-Gerrit-Change-Number: 1965
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1965?usp=email>
X-Gerrit-Commit: cdbf85ced0fbcfffe1527f249ed44aeae5f048d4
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 16:21:39 +0000
In-Reply-To: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzU2NzI5MDAwLkk4OWMzMTMzZTAwOWRjNzVkYzJjMTBjNjA3YjNmMGEyNGMwNGU4MTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b9110bda00b500b5dc3156ceba0abe1066357847-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOdkB-000000006Ce-2xSl
Subject: [Openvpn-devel] [L] Change in openvpn[master]: control_msg: Add a
 shared TLV codec and use it for early negotiation
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0220546044292309823=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0220546044292309823==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PPQ82Q4k8AQ="; charset=UTF-8

--PPQ82Q4k8AQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Lev Stipakov has posted comments on this change by Lev=
 Stipakov=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail =
)

Change subject: control_msg: Add a shared TLV codec and use it for early=
 negotiation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 5:

(2 comments)

File src/openvpn/ssl=2Ec:

https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1965/comment/dd290fdb_7fa313ee?usp=3Demail :
PS3,=
 Line 2665:                 }
> I don't think this is necessary=2E There is=
 no problem in accept an optional bit here=2E
Removing the break would chan=
ge the existing behavior=2E On the existing code 0x8001 falls to default an=
d is skipped=2E In this new code it is parsed, and a length other than 2 fa=
ils the handshake=2E

While no-one now sends 0x8001, I would still prefer n=
ot to change the behavior=2E


File tests/unit_tests/openvpn/test_control_m=
sg=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965/comment/4c17a5b5_e=
55353b4?usp=3Demail :
PS4, Line 163: /* Writing fails, rather than writes a=
 partial TLV, when buf is too small=2E */
> The write functions don't check=
 for space up front, so a failed write does leave a partial TLV: `BLE [=E2=
=80=A6]
Fixed=2E ctrl_msg_tlv_write_header() now reserves header + value up=
 front, so a failed write leaves buf untouched=2E Also fixed the test=2E


=

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I89c3133e009dc75dc2=
c10c607b3f0a24c04e8146
Gerrit-Change-Number: 1965
Gerrit-PatchSet: 5
Gerrit=
-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lich=
tenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 04 Nov 2026 16:21:39=
 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Comment-In-Reply-To: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>

--PPQ82Q4k8AQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Lev Stipakov has posted comments on this change by Lev Stipakov=
=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3D=
email">View Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl=
=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965/comment/dd290fdb_7fa313ee?usp=3Dem=
ail">Patch Set #3, Line 2665:</a> <code style=3D"font-family:monospace,mono=
space">                }</code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">I don&#39;t think this is ne=
cessary=2E There is no problem in accept an optional bit here=2E</blockquot=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Removing the break would change the existing behavior=2E On the exis=
ting code 0x8001 falls to default and is skipped=2E In this new code it is =
parsed, and a length other than 2 fails the handshake=2E</p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">While no-one n=
ow sends 0x8001, I would still prefer not to change the behavior=2E</p></li=
></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/op=
envpn/test_control_msg=2Ec:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965/comment/4c17=
a5b5_e55353b4?usp=3Demail">Patch Set #4, Line 163:</a> <code style=3D"font-=
family:monospace,monospace">/* Writing fails, rather than writes a partial =
TLV, when buf is too small=2E */</code></p><p><blockquote style=3D"border-l=
eft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">The write functions =
don&#39;t check for space up front, so a failed write does leave a partial =
TLV: `BLE [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Fixed=2E ctrl_msg_tlv_write_header()=
 now reserves header + value up front, so a failed write leaves buf untouch=
ed=2E Also fixed the test=2E</p></li></ul></li></ul><p>To view, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail">change 1=
965</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1965 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: Lev Stipak=
ov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru =
&lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 0=
4 Nov 2026 16:21:39 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCom=
ments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>=

<div style=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt=
;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Comment-In-R=
eply-To: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></h=
tml>
--PPQ82Q4k8AQ=--


--===============0220546044292309823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0220546044292309823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0220546044292309823==--

