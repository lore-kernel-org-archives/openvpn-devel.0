Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873C6606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BbePwEwX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=S6BN2+Xq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=D2CKqJJW;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=KjfMdxqv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=lj2P7MbD64d75626pHfdFRl11nZ0sEPCH+Cgc0R1J4Q=; b=BbePwEwXPfxa63OeAIjfTNpWTY
	X/PuYRFhZOykfEYsRpG6okeGD+BSZ+BRk/0k/LLCkGfQ+X+E+wYGihynX2SQmw3OUC478cbq1zzLn
	WXSqZqYb3TVTrxEWwyDmW7hNh1WJagiqxHszXLoilXaGsCR0zLGyihbXxrorN8qO0tYs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSvDZ-000000004Db-2euJ;
	Mon, 16 Nov 2026 11:49:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSvDH-000000004DK-4BbD
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 11:49:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Vpw5LR9EwvzjuI3EoufqFZbywWxCb2RyMQP5aIhry0I=; b=S6BN2+XqW56HkiX/hy6uZXfIl4
 lzE5OrDuPxSx0MZEU12WWCdIVvZTaUN533jqNbhM01ligSjNCiWYc94BjcQojaQ1ybaxwePDjsW1d
 wxAyzPxllihvGiXfaZf4UNgSXSjF2qZ5EghgVWTrqjzY1KJRUQc98HBswd4ZhV9dPBF0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Vpw5LR9EwvzjuI3EoufqFZbywWxCb2RyMQP5aIhry0I=; b=D2CKqJJWThmwcHrAqFqrQ4Fe6v
 SUjs6Q8g5vl0pMFzZJjbtFXXGR9VpjkJOPDyZ9nqU15w0qshBkPY3w/PAukxozP3FZvxgOrGhD8oE
 sUwhttFX65abyHkZQ32LCjatyBnibryxuRrUEkVoGJA15hy6pn2jD0+a/C9pPtFDqt8o=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSvDG-000000002gR-2QLy for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 11:49:31 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4bb68c197c7so16627555e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 03:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794829764; x=1795434564; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Vpw5LR9EwvzjuI3EoufqFZbywWxCb2RyMQP5aIhry0I=;
 b=KjfMdxqvkYiC8FBvj7WO0b0xheau1MKah344CXI0pgCG3/46uo/cHNbCbPa00SoDEh
 bLuX0waf3N1cc/dqqllUwRk6nLUMDh+JMntR2ickA0rYOmb484b+yzFe2E43iyiBSeiJ
 Q25UIGdgarjFVzY8ZpBiNHSfyEsFEgjwixKCwQj7GWlhMAU314T2FPjiRQ6jQnloc5ge
 WgfXDlt+cUYVnfDbP5ZQCXJuhQ1otKWnzDfFeNxLM55UVwe/cSi67+nnLo7dHLb7WfiK
 QWFC1+0Mol9JgjASdKFtzF62SNH8JLA5wIJILa0DptYnMrAS9tCmXxxQAEsD/mJkbTa0
 NtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794829764; x=1795434564;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Vpw5LR9EwvzjuI3EoufqFZbywWxCb2RyMQP5aIhry0I=;
 b=H7BEjUoyn+sUXlXzMA/MzKZ0RsRTKjeNFQEK/t5mB50F/VauRfAjvWdsKz+K0v0wTu
 nP97HFhtPDWxUUqFBYaOCYB5FtTb/KR8jx+iaCj3lzz+64RS02iUF7vX3xnSWETzrFiJ
 zl7kFq75RilpqJMc1GaUdkmXNWg4tTdFGPRozOTOemFn93/uL2zeI6IUnotNq4N4O4rD
 KqyHnQyzN9OKp3quQSRj0CR9zQKErF+RSff3LrFCavUVx4fpvfZqQsfZHgxWnLVbd8H5
 Mzl8SvxiX3hOwCJkbNmaRlsf8/TmG0N4pOLEQdF06nlqmmcIGBRfh70khE/hDypFNfDA
 UH6g==
X-Forwarded-Encrypted: i=1;
 AL+hErEqi1xuz+yMv15Pg/gJkIuwWWAFUYbSfWJJJwcwraKvhXewSDOSJ5ew0G4qZWJl/0hl7KPL9HChwE0R7Zxy@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9HVUzoj/VI7hvmjA1jnO7ST4JoanEi86DbkTJnN6CYc7rzIV8L
 UlPhfCm29Mx1sOChZ4XSTfuliPJ/jl9oNJa62IH908Pj40UdPeov9CgI3mmV8+Pat2BlFdINz79
 aWCUbpe/RveoI4MtApe4A5F1U6ya97T1gEFD39CSi/Ltdvpi2c5IeJQaGLpIGF1/LMLoW2LepT9
 1+lJInkQ==
X-Gm-Gg: AYBFou1SJSpoZf7+uXBD85RwJ3/czZRhgoesijmgUUP+26wiBYBsNiOJpnsXDagepUq
 UymZ+IoIVABup9xJb/j+9t0uemVGsLiAY4mby2pFsFt+pcXU5B8U5NwdUGWbrI1FjblLV+4TFxW
 OtSgsbS8UtZ3K2RdR8CqhVqGrPNfQTUn2D0xjAuPYcOIgat//B3us+akC6IA88cxViCsblBbRVV
 9OLIa8QgJMiERlVeuMYiK7k/nuhBX593ooWMtNcfuYE1cM+TkQHFL6npxbtz6jnvyab6oPr/0Er
 0pIJRmT2x5kLwhvqo9JJWVEiDt/Rdgs8d8MGfp3/eKBifjS8e/hFCsTUtrhwOTHzBSJebYDDDny
 jNoNgqnwOwAw7GO1UHm4CSlZXsVyZNFvxW5jvNgnfWLfiJBaOk7KlypiMxVCk8Xyty7U0M4yy6/
 Z/+WGNhtljUUWaf+BQF44S236SdKCV5KrSkNc065Pr5uYXKCeTlhshuuCSoopBR7qiKzndsbkyT
 nRS5ZqtvZSCdNmEaUbLNlRpb+oZGpTxdkbiqQqTJVH9up1YrSUH2jOaYXVasFjUavmY3owa04QQ
 HE+3LHTyanqBlplPe/5PTJRq4skmWDuuPJffglh2YVPCD7U18w2R2g3OzqmYrDXnXxLnPsDyBvj
 hx+RIv8UFQoXv8TDPeGoIHucdHJcrbEByV9v+mvndT2bOG1tLmAUVYdZI3yyXn1WtzAY+91CNx/
 uHBQhVfpIzed0glW4=
X-Received: by 2002:a05:600c:4e8a:b0:4bb:6f77:1e35 with SMTP id
 5b1f17b1804b1-4bb6f771fe4mr70088155e9.21.1794829763787; 
 Mon, 16 Nov 2026 03:49:23 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55acdccfsm296426865e9.8.2026.11.16.03.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:49:23 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 11:49:21 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118
X-Gerrit-Change-Number: 2177
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2177?usp=email>
X-Gerrit-Commit: 5f21576c5a3cd522f75975f2ace80184e713cabd
X-Gerrit-Comment-Date: Mon, 16 Nov 2026 11:49:21 +0000
In-Reply-To: <gerrit.1794417322000.I6f5ca53d4288b0921610f7a3f84ad55d2ab49118@gerrit.openvpn.net>
References: <gerrit.1794417322000.I6f5ca53d4288b0921610f7a3f84ad55d2ab49118@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDE3MzIyMDAwLkk2ZjVjYTUzZDQyODhiMDkyMTYxMGY3YTNmODRhZDU1ZDJhYjQ5MTE4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5413879d819e783068f6a0be1f017be00137c3b8-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSvDG-000000002gR-2QLy
Subject: [Openvpn-devel] [M] Change in openvpn[master]: networking_sitnl:
 Reduce boilerplate code for parameter checks
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5103447956920026128=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5103447956920026128==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OI2mnlK0RVk="; charset=UTF-8

--OI2mnlK0RVk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, Fran=
k Lichtenheld, R=C4=83zvan Cojocaru=2E

Gert Doering has posted comments on=
 this change by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2177?usp=3Demail )

Change subject: networking_sitnl: Reduce boilerp=
late code for parameter checks
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 3:

(1 comment)

File src/openvpn/networking=
_sitnl=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177/comment/830d8a=
fa_af52d2f5?usp=3Demail :
PS2, Line 893:         if (ret < 0)
> cppcheck co=
mplains that this shadows the outer `int ret` and it looks like it's right=
=2E=2E=2E
Done



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2177?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6=
f5ca53d4288b0921610f7a3f84ad55d2ab49118
Gerrit-Change-Number: 2177
Gerrit-P=
atchSet: 3
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@=
greenie=2Emuc=2Ede>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attent=
ion: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 16 Nov 2026 11:49:21 +0000
=
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Gert Doe=
ring <gert@greenie=2Emuc=2Ede>

--OI2mnlK0RVk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, Frank Lichtenheld, R=
=C4=83zvan Cojocaru=2E </p>
<p>Gert Doering has posted comments on this cha=
nge by Frank Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2177?usp=3Demail">View Change</a></p><p>1 comment:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p=
>File src/openvpn/networking_sitnl=2Ec:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177/=
comment/830d8afa_af52d2f5?usp=3Demail">Patch Set #2, Line 893:</a> <code st=
yle=3D"font-family:monospace,monospace">        if (ret &lt; 0)</code></p><=
p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;">cppcheck complains that this shadows the outer `int ret` and it =
looks like it&#39;s right=2E=2E=2E</blockquote></p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li>=
</ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2177?usp=3Demail">change 2177</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2177?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 2177 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none">=
 Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@ma=
ndelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn=
-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: Antonio Quartulli &lt;antonio@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Da=
te: Mon, 16 Nov 2026 11:49:21 +0000 </div>
<div style=3D"display:none"> Ger=
rit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels:=
 No </div>
<div style=3D"display:none"> Comment-In-Reply-To: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--OI2mnlK0RVk=--


--===============5103447956920026128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5103447956920026128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5103447956920026128==--

