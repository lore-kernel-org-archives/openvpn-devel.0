Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2C4606A329
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DYsoRvC7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DuIXEHKF;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=T+mtcEmc;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Eyx5v7Pw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=OJRD98HpSyMrUD8+8vwRf6W0jgc71lhZwaEGxkYbjJ8=; b=DYsoRvC7nYDhShd79Z4Z1MSSpX
	BSgwWENA3i8mwEKBMCou9dfPabV3/z4oVGD70yJFANOP4RLT35tbGkvcu8RMrjMeLx1LYzanFcaG/
	QxJHPg9ofZclH5yWsipdsN5EtVXILsQOAMg79wV/3dTPOnvSI87AJ03CBRaUDSi0UTSU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPIyE-000000008Eb-3x5j;
	Fri, 06 Nov 2026 12:23:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPIyD-000000008EC-2lPx
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 12:23:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t8+HBl0fj1G3hK8lKZ9gRuAc5sF0wSPCWiw9fqF1Xj4=; b=DuIXEHKFg/BcMU4fjZJ7xX1rYc
 2N6IxifqBMy36GCP4J7OQl3ArT/om3GPm2TWnG4MBQKgZyqyKDc5StVFugdNNINl/WDWyvxjdtBdX
 8nd3SoyoQC4VMav8PRFvGMp9BSMbwg6ZbNNGZqn6npBDDXw1GLz/Tl7N0ysVS3AR+a5E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t8+HBl0fj1G3hK8lKZ9gRuAc5sF0wSPCWiw9fqF1Xj4=; b=T+mtcEmcXMCvEiKMJl1RBcgm49
 yRshmEdLIF4bYAkB/9AdkA0HwwOVU8HCVCXTAzJxsXqSw/hX0b1YJDuddaq+VJ10b0ItqSs8Deqgl
 mv8DkMKmkHBNibYnnfXBzPYL20Jj9bCqg5fRgr4Oo2KL7Q8tegojTgh2kR8SfNW8nYTY=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPIyC-000000005Cl-0uHm for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 12:23:01 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-492f6b7f70dso323553f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 04:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793967774; x=1794572574; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=t8+HBl0fj1G3hK8lKZ9gRuAc5sF0wSPCWiw9fqF1Xj4=;
 b=Eyx5v7PwLU+7rtx7zCklDvemTIB3UZismEF32I/eM+Wz1KJ+mALTHbOoDWXyjwWzd5
 qD03fl2bfdGV7WuqLmKRD5EuAubXgED7pDW5+PLhhNqvC9xIp4NWLc/vK9TZqJpg6p75
 qECngFf2EM5bPT4tPT9y2XFIc6/W8IpNBz/mkaOPrcn/moMB2vCHf6D5Gt5JoOLdtmaR
 MGz77/cN1CRUKkKahjtF5ytGi+iN4rudAEWpuIOH8Ga6VqoOQc+3NJ6LS/KJJfcPCSVQ
 EgGk18tkYSlJdjSRZiVfBOXcnLsm38ATkiEjhG4YN0fQNpoDau/Le0kasoM+iPH7d/E1
 YvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793967774; x=1794572574;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=t8+HBl0fj1G3hK8lKZ9gRuAc5sF0wSPCWiw9fqF1Xj4=;
 b=pQbANFhPMi8++2cXDSQJZw9GMajgYHBeCGMLdx90VC8vk31DDpAYnoPNfwf6ROLEOW
 zTrJ2Cisxqvl2JmcFR0qzp5IVAjXPoplSFg8Vj3HcU9O735HX5DNnT0C9mj2qt9xGyE5
 ekI7c50prbPNDdwpAKZZC9swKRJwiGV9y+ys/mcoiTFyOgWHkWN0fsrobsDKKEoFKWGY
 uRDyDZRr2Bf59jVKB4yUCYa0aJjXd522BetrD9YluGoLkPHrhQoXzdxacsetqc3+iCj/
 3dVmAZsjjmDeRczGZ8KvX+R2CHNohvFTESSbjeFhS7hLuDiddM4yLPDDPQWMGrnHVNrV
 HGxA==
X-Forwarded-Encrypted: i=1;
 AL+hErExF3URARaRukGu5KYiAQ9ME5qxsBS4yaQzCtvNBKBF1IQhobs5m5FtSV9x4X5m522QeOxQhghptuioyGeU@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9cSpeOVOxxQSRxf9Z3foqc/y/mUzYl//dtK+KaI9NW218XSxrR
 bzYUjPW1F8SGQqwbWTNlmmDsSTVoVUejsF/14OvFyjpgeb+BDPMbuGoI4hpMOU+hlNoJXHyJcJ3
 /EQIMPCt1jUKXaVR3htimjCXBoRwxi9J1GWVnWmr4RrLOauJ8c0qoJ89U38zn3ZnPWauH
X-Gm-Gg: AYBFou3hHoW3nG3uTLL587oGEprryUc1dBV2oaAaZEBrK56AdcrUwfawXsy7I+t4pte
 rel+Z9rLZ00A+20MeW+cnut3C9AROFvLnxrJJ2t8HLaUKMjxy8j8ZCSFhLTkyNP1tj9IDtxtbXv
 +CoNh9wyoBnL0sXSuC7bmfrNj81XgisVxAqgrGqV8JwAxem7PSNRFI7Vue43G36i4Qdsj6m1/B0
 XWbZ9mj5TAQAPACCANVAwEWdHyWPrYpuwoPyAUiZOiYQB+NObSeqtSLUcC+hZqkeRkpquwwBU0B
 FOUuwYkUxl+7e/+BHMLNBr2k2dlNGmpr5Wqk/A0zKCHxWfxIrkEuLRbZKHoYCp+c0RCpJ0ysaW8
 92MVJzLQA7p9yPLW0/eVs8kjQlRXH+sRA3WkPvPTdU+7DDVPjdfbY7iqqpsssyQf8LVBeWpziby
 mCNCZmGHrh+wpaIrGI7tNLav/7x5qGCQkw0bm/flhGH0iZc8b4ktu6z2Qd2P9G/ga8s6yDtQCtC
 a/o0zBdfRqNot/y4cEH49Kp3LwKqW3X0hxRB0T2EP8ip9UlAFIpL9IfrJ1SYwS9OoKWVGfsgR96
 oCO+CuxY8HI8yx5eFWm7j1oVgJRW6n0Tx/bhUBazlTBUyvGaf9dhXUUqVpeLbzdyLba/3LSma4C
 Kb70JH2Ea9Pwjg5IFpM+BWA1VnW3mGj0E2T/SnPXhcQwkx8VLSqle+4BFycavqlLG3A2wTRi318
 0PR6XnQmKy8DBZi/4=
X-Received: by 2002:a05:6000:40de:b0:490:a481:7ac8 with SMTP id
 ffacd0b85a97d-4927ec0bb02mr4588695f8f.29.1793967773419; 
 Fri, 06 Nov 2026 04:22:53 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d72333f9sm3467123f8f.29.2026.11.06.04.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 04:22:52 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 12:22:51 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I494a427924ea501382275ea96ef85a6abcd780e5
X-Gerrit-Change-Number: 2105
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2105?usp=email>
X-Gerrit-Commit: 4079ffb801003e9bb3f66c653d62b32836fece4c
X-Gerrit-Comment-Date: Fri, 6 Nov 2026 12:22:51 +0000
In-Reply-To: <gerrit.1793709839000.I494a427924ea501382275ea96ef85a6abcd780e5@gerrit.openvpn.net>
References: <gerrit.1793709839000.I494a427924ea501382275ea96ef85a6abcd780e5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzA5ODM5MDAwLkk0OTRhNDI3OTI0ZWE1MDEzODIyNzVlYTk2ZWY4NWE2YWJjZDc4MGU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a1c61febbba01b38006bf0fb0609a4791523ce50-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xPIyC-000000005Cl-0uHm
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Move gc from
 openvpn_net_ctx_t to local variables
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com,
 gert@greenie.muc.de
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2866446170220347352=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2866446170220347352==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="e7GiJ8eldp0="; charset=UTF-8

--e7GiJ8eldp0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Gert Doering, R=C4=
=83zvan Cojocaru=2E

Arne Schwabe has posted comments on this change by Arn=
e Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2105?usp=3Demail =
)

Change subject: Move gc from openvpn_net_ctx_t to local variables
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 c=
omment)

File src/openvpn/networking_iproute2=2Ec:

https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2105/comment/3c838f4f_9008f0c9?usp=3Demail :
PS1, Line =
367:     struct gc_arena gc =3D gc_new();
> technically we can just go with=
out a `gc_arena()` in all these places - `print_in6_addr()` uses `gc_ [=E2=
=80=A6]
djpig basically broke calling print_in_addr_t and                  =
     print_in6_addr with a NULL gc as they now return const 
char and you c=
annot free const char strings

So in order to get rid of the gc_arena I wou=
ld need to revert that print_in6_addr and print_in_addr_t return const stri=
ngs

I instead about to reuse the gc inside argv instead adding an extra gc=
 in these function for the new version=2E



-- 
To view, visit https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2105?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I494a427924ea501382275ea96ef85a6abcd780e5
Gerrit=
-Change-Number: 2105
Gerrit-PatchSet: 2
Gerrit-Owner: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=
=2Ecom>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Revi=
ewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Antonio Quartu=
lli <antonio@mandelbit=2Ecom>
Gerrit-Attention: R=C4=83zvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=2Ede>
=
Gerrit-Comment-Date: Fri, 06 Nov 2026 12:22:51 +0000
Gerrit-HasComments: Ye=
s
Gerrit-Has-Labels: No
Comment-In-Reply-To: Gert Doering <gert@greenie=2Em=
uc=2Ede>

--e7GiJ8eldp0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Gert Doering, R=C4=83zvan Cojocaru=
=2E </p>
<p>Arne Schwabe has posted comments on this change by Arne Schwabe=
=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2105?usp=3D=
email">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/networ=
king_iproute2=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2105/comment/3c838f4f_9008=
f0c9?usp=3Demail">Patch Set #1, Line 367:</a> <code style=3D"font-family:mo=
nospace,monospace">    struct gc_arena gc =3D gc_new();</code></p><p><block=
quote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px=
;">technically we can just go without a `gc_arena()` in all these places - =
`print_in6_addr()` uses `gc_ [=E2=80=A6]</blockquote></p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">djpig basically b=
roke calling print_in_addr_t and                       print_in6_addr with =
a NULL gc as they now return const <br>char and you cannot free const char =
strings</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">So in order to get rid of the gc_arena I would need to revert t=
hat print_in6_addr and print_in_addr_t return const strings</p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I instead a=
bout to reuse the gc inside argv instead adding an extra gc in these functi=
on for the new version=2E</p></li></ul></li></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2105?usp=3Demail">change 210=
5</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2105?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4=
94a427924ea501382275ea96ef85a6abcd780e5 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2105 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2E=
de&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: Antonio Quartulli &lt;anto=
nio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Gert Doering &lt;gert@greenie=2Emuc=2Ede&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 06 Nov 202=
6 12:22:51 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Ye=
s </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div sty=
le=3D"display:none"> Comment-In-Reply-To: Gert Doering &lt;gert@greenie=2Em=
uc=2Ede&gt; </div>

</body></html>
--e7GiJ8eldp0=--


--===============2866446170220347352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2866446170220347352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2866446170220347352==--

