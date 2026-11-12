Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065DA606A32E
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DzmmqzsJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NbsOT9B2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SBTA57Og;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WtUBuB9P
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=o4wOw6ocm24fXxOW2ZGsNKzgsHYVdP3teH3o87lnto0=; b=DzmmqzsJoRvC1b4pC/HJaOkXvf
	DtPe+i64EUigm58q3aHFqUTzs4oyn58vXbwL/29JZuPE+tuMVgkTfNKiMKY+mXiASa7rt5VXQq+ed
	++xybLCHbwzBNkDiMA7E+EjJmsS3DlAr24nINDhnvrunxGpSwZz/s324n/YHQZD0nKJM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRWqP-00000000350-0JJI;
	Thu, 12 Nov 2026 15:36:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRWqN-0000000034s-1sA2
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 15:36:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ULO1XVqhWTPRu/8e2jTsGKbR2/pbhqYDzh1fZDYkKhc=; b=NbsOT9B2zkp9Xqdzr01wAfc8X0
 +/VNlJdMURsJmRBp0PkLdO2KYAIuFeTuw0md08XwQTWULvzg0nScW1Nuy4YAdSJW/u/ku1pF/7fzh
 Pb8wG9QoJ9TXaGFBJPSRVy0x4Eqvzef7k18enNoiuYw5+mhsv8w9PKVqEjoRTixjYPvk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ULO1XVqhWTPRu/8e2jTsGKbR2/pbhqYDzh1fZDYkKhc=; b=SBTA57Og/GLKneTvB+payJRc8Z
 D4dDqXl4fw6Kvas6vWc/Yt/dvwDlGmv7Tt2+hqJhsAkew0w6z8HXvABdXC5/D8MT28pjL3u9ejRjs
 IfOidCEHsuPq5j7n4GWDEJfPSib46/RwZ4NJBhd6f2HXpVro5q2Xn87+zcuVnxG6iznA=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRWqM-000000000og-0sG8 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 15:36:07 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso32334945e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 07:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794497758; x=1795102558; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ULO1XVqhWTPRu/8e2jTsGKbR2/pbhqYDzh1fZDYkKhc=;
 b=WtUBuB9P8tRP+tmY1mgGzJM2LuJUs3rPBBObUex7CosVTWa93VXVEKSbPEGKXrBt19
 q+AkHpXrlhTV8TmPOmyM/9qPC46eR3JZg/HSKF0ur3YeffnkS7tX1IhZACbQvILM5uLq
 MiUwyjcNvHkGycQdHSGCKvPbAT2yQzG+csnhOjg63nBZyUPc8aiqXQKlaUdMaDcbFbSw
 T9/SqbDMkV6BXtIJd3b5iJLam8lmtAurTLUoyR0sGNLauwGKHu0EmxuthDhVuvj99bZ5
 IF/UCTSGVbzkvURBd08xgUr4i/eLfSHnOFys2P6n6J6yoKUvw5sSNRqZINm/nsymlFR4
 aPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794497758; x=1795102558;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ULO1XVqhWTPRu/8e2jTsGKbR2/pbhqYDzh1fZDYkKhc=;
 b=OmWpKEFthsZPXv1+bYQDUp2gokfBreYxIrvILU+3rVQimiKJC/atdNhxN2G5kL0YKA
 50fkuZ+qVjKEhFMkpjru3Q8ml21Q9CFxBYPZNE23McAY85GuzO42eNl5oi7iO8zwfXlx
 3mI8pmKm7giDBbtCnwddCsQYkamfyQhcVMuXtg41GOkahIHcosKt4DJCzvD8t61aMjgq
 CC7smDYBLnq6FVudaqxCItzta8BgV7ccxOlRHYCydpBislKksRHksuQ+EBGKnq2x3mhC
 rkrreM2Yxlul2Jvqtr6VdP3NFI0sGvn2T3zs+rkWzozpfdCm4snTakgDnNO1XeBZs4k7
 32ZA==
X-Forwarded-Encrypted: i=1;
 AL+hErF46cp9vpjZuvW8HJ+H9mVQoQnbdB4QET8DGPSJ+oLitIUY1PM5FgZOwot7GRErEzs+/muWpV/JsyqwKRQk@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+MRoSoGHFqFKHqjtCQ77j+drsc6xZoGhD5xw8FmK74Z8nwl3ZY
 YyttyQtJKsN4Ju6Rzy5QqsyEAJt4fLDk8yBG12fJCgavAs9ccyS/WdjWwAJtQ6XNO8ZomfLHAAH
 Ob8KbmEWQRuoiS8rOTml8/UpFfxGu0pLqYy+UKYt4SG8XevSZtawGzPUBLjXowvinqK/+
X-Gm-Gg: AYBFou1s2nDQF/CTlPTWjni9IIwEGxtsYRVOPGq4DhuOTp+2FpQomx6V1KitMiMBdbY
 dV+RM4n6Zs+U04huyU3ZGAIFzNWKSWYMz3Urn/2Kg18cdqQqbq2V7A+v8oHM5PpZkIWeOsr8+w/
 wKYmWwGPSZduGpg2EeUZ4kiSuG64HOefOKs1wORikApdQW8uQFkVAzKmL9ef7s6jYBhDrKB0GIU
 FxiFqOGOJyuZQQKp1rz1Lc3SMT+Z9SeTRjH62SIgkyo0xd0xv1HXi8Q8FO6n6yJjMgWzNubn+bR
 LjuOb03MHqxN4ijzgiu8YJGfBhbvg0L9KzJisG+/dfKPqYNL5TAv/q2RpcN887V9znUl82yKiFC
 pMkfJ2qfwLaEwbdm8f/pjVGoTy5S810erGl5yjLO66MC31Rv24XYYaUX9rz87XwPXBm/ziW8ewy
 VMUzejaDkCelfXNPaQhWQC9AMMEhD2TdeXsrKco0zy1dFymvglweWidaNN4csheNyQ41D5QVXA5
 bl5sQSfIzPsiEkw6veDJeL+uRj5w5DUtEWqjMDci6iEuHB4ctm3jEiteL7VMFSGDTnf329cCioK
 clgR9JJ6f8y1LLBjuhzj9a/YNrbual24JBs8vaCHw5/1vqnEiMMvQjEGUgXZbTd0kESGnhpF8Rq
 3LEZpBgYc6CXtHOKbPAAyOY6bJIBNlSzo0166UINZPBWJ36/gPIT2YI7CdDXpzfU48XRILulKU0
 wOGA2LeE/api69KfIAPVsEFJ5H7GqdkwQzhmWi
X-Received: by 2002:a05:600c:350b:b0:4a1:dda8:eb73 with SMTP id
 5b1f17b1804b1-4ba09381815mr111565485e9.27.1794497758222; 
 Thu, 12 Nov 2026 07:35:58 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb51de7b91sm43329725e9.6.2026.11.12.07.35.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 07:35:57 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 15:35:56 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
X-Gerrit-Change-Number: 1965
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1965?usp=email>
X-Gerrit-Commit: 54fb8770bb4a471837160155a0766d92cc2e0ec6
X-Gerrit-Comment-Date: Thu, 12 Nov 2026 15:35:56 +0000
In-Reply-To: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzU2NzI5MDAwLkk4OWMzMTMzZTAwOWRjNzVkYzJjMTBjNjA3YjNmMGEyNGMwNGU4MTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <584cad584ae8aea68708872fe121297acb728819-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRWqM-000000000og-0sG8
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7965180738416094370=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7965180738416094370==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="g1uSOguxBXY="; charset=UTF-8

--g1uSOguxBXY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Lev =
Stipakov=2E

R=C4=83zvan Cojocaru has posted comments on this change by Lev=
 Stipakov=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail =
)

Change subject: control_msg: Add a shared TLV codec and use it for early=
 negotiation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 6: Code-Review-1

(3 comments)

File src/openvpn/control_msg=
=2Eh:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965/comment/7f20a6cf_6e9=
d416a?usp=3Demail :
PS6, Line 45: /* TLV header bit layout of the first 16-=
bit field */
Should this comment be above `CTRL_MSG_TLV_OPTIONAL_FLAG` / `C=
TRL_MSG_TLV_TYPE_MASK`?


File src/openvpn/control_msg=2Ec:

https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1965/comment/e27aa5e4_fdbb0623?usp=3Demail :
P=
S6, Line 62:     int field =3D buf_read_u16(buf);
Checking `BLEN(buf) < CTR=
L_MSG_TLV_HEADER_LEN` first would match the write side and not partly consu=
me `buf` on failure cases=2E


File tests/unit_tests/openvpn/test_control_m=
sg=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965/comment/553ee3d2_c=
799ce91?usp=3Demail :
PS6, Line 40:  * client to resend its WKc, as older v=
ersions wrote it by hand=2E */
I think Arne -2'd this in its previous versi=
on over this wording in test_pkt=2Ec=2E

Maybe we could cut it to just "The=
 early negotiation flags TLV of a reset packet asking a tls-crypt-v2 client=
 to resend its WKc=2E"?



-- 
To view, visit https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1965?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
Gerrit-Change-Number: 1965=

Gerrit-PatchSet: 6
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerr=
it-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Fra=
nk Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Lev Stipakov <lstipakov@gmail=2Ecom=
>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attent=
ion: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Thu, =
12 Nov 2026 15:35:56 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--g1uSOguxBXY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Lev Stipakov=2E </p>=

<p>R=C4=83zvan Cojocaru has posted comments on this change by Lev Stipakov=
=2E</p><p>Patch set 6:<span style=3D"border-radius: 3px; display: inline-bl=
ock; margin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1=
</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?us=
p=3Demail">View Change</a></p><p>3 comments:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/c=
ontrol_msg=2Eh:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965/comment/7f20a6cf_6e9d41=
6a?usp=3Demail">Patch Set #6, Line 45:</a> <code style=3D"font-family:monos=
pace,monospace">/* TLV header bit layout of the first 16-bit field */</code=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Should this comment be above `CTRL_MSG_TLV_OPTIONAL_FLAG` / `CTRL_MSG=
_TLV_TYPE_MASK`?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>=
File src/openvpn/control_msg=2Ec:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965/commen=
t/e27aa5e4_fdbb0623?usp=3Demail">Patch Set #6, Line 62:</a> <code style=3D"=
font-family:monospace,monospace">    int field =3D buf_read_u16(buf);</code=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Checking `BLEN(buf) &lt; CTRL_MSG_TLV_HEADER_LEN` first would match t=
he write side and not partly consume `buf` on failure cases=2E</p></li></ul=
></li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn=
/test_control_msg=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965/comment/553ee3d2_=
c799ce91?usp=3Demail">Patch Set #6, Line 40:</a> <code style=3D"font-family=
:monospace,monospace"> * client to resend its WKc, as older versions wrote =
it by hand=2E */</code></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">I think Arne -2&#39;d this in its previous vers=
ion over this wording in test_pkt=2Ec=2E</p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">Maybe we could cut it to just =
&quot;The early negotiation flags TLV of a reset packet asking a tls-crypt-=
v2 client to resend its WKc=2E&quot;?</p></li></ul></li></ul><p>To view, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail"=
>change 1965</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
65?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146 </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 1965 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: Lev St=
ipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Lev Stipakov &l=
t;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 12=
 Nov 2026 15:35:56 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>=


</body></html>
--g1uSOguxBXY=--


--===============7965180738416094370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7965180738416094370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7965180738416094370==--

