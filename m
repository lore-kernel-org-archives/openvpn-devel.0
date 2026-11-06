Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26DA606C7C3
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PNnoBIEx;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Evr1IfVy;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OvzR9M+v;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WgUb4b11
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=+/P/EV96Z55z8nQOrSLYw0baLCG/Ldq8ldGqTSr4Hno=; b=PNnoBIEx2XMRZKwjThoBncgFx9
	7oHaNCYe0XLGJ3bUeDlRazNdqys2kWzvn9J+efJpAYqcnWgjK3YDKI97bhwbJsXOXBvVaxdthx3Gd
	P6LJtmiRAjeDXiZT9Fb638q5Zeeo4VVORgEcdhsdBVzUqnua74r3EYKJiQqg7Fv1osrE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPILp-000000004g1-3K8n;
	Fri, 06 Nov 2026 11:43:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPILZ-000000004fS-2GK9
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 11:43:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yRFykLG9reK4BgTE5wUegYsJS5DkIDDG3tSE3CRN3vw=; b=Evr1IfVyjL+e+BwSkLknqOFu67
 izf8wiVogAjztFSnhBHUr9VevZ6yc6e5SjRF6u42FVYHF3i4rHcVbTqQPnxhUX6HN6F6RrxrY0QWD
 2gGAOszgQRp5ntrqXEmZ1zDHDNJzeLUNAdwia1AGd0Rz3RVg62ez2qumng8jsKtOnh6g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yRFykLG9reK4BgTE5wUegYsJS5DkIDDG3tSE3CRN3vw=; b=OvzR9M+vU1D34quvObxwMbe67F
 10WF3yvZiuaqm9PKwFII9ExzocZFdlZtOmw6pO311oPkGGtGlw4ozjQGHX5dhhaoXkD98vtCvat7J
 pNrdmF2suJKFKAE/IbQoM+4aI1kGKqhCwFprKJAF7C57yz96ynxMDc3n2q3zXSuY1HLA=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPILM-000000004II-1YuT for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 11:42:54 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so360119f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 03:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793965366; x=1794570166; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yRFykLG9reK4BgTE5wUegYsJS5DkIDDG3tSE3CRN3vw=;
 b=WgUb4b111lOyqzHcSkrALAXp45C13BmrpSSRYDiR6q6CJRw8mt70uLNPeBP9odVcIZ
 IbonvSX903T6iHjlQlhQ/OJnLX3wYSz7qwO4SikDFXAAoPDFoJiy3wEHpyjlanHzdAYm
 gcsgA+eRtOfhK9tRNeWcHa/kCdz9qcKNz/5mQcRdbdw+83OiQI8PKueGZ9Lk9AfrKuR6
 Gp6IJxl27xOK6/GI2RdWMABhPpr3uqCgCGC2jQpkwnbC76LsF3zoLkQ1D/5/w/mOncX7
 u6D7tT1MSxwskJk2XIjAjYNH2bNTYHn9bAMVzHB1ZR8yqNEWTLoNIo54MHeUWqE8VpQL
 V6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793965366; x=1794570166;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yRFykLG9reK4BgTE5wUegYsJS5DkIDDG3tSE3CRN3vw=;
 b=cjWNCt26zzNGe2KWI3rryDLQGT4qTYd19PGFObrrDkIwyRtyWPnF8LjDJLeosx4qHu
 jfUfkouLJsLO54Z5Md+ZlJ6RCwfT87W7LHoquZtk8OoMIfKpJW3TQ4Fo1FJdzQqUyIRm
 2IkEn5GTFopekY8ax20FrYwOkkHcjv/70cIHQ+z7Fj2fxRGlAaHAQrluyI9LZS8jnUPu
 t020p88P1+BS6vkqpV7RywOobDtBbtQa3kmDvjODS/teYI0YoUdOvBvfm0MuesF2FbUL
 NB9kF+5ZFKRvyA3eeL2Zy+D9QdNelvatFHuX/SvV25MnXTzVyP8UIYcf6TC19NO/+dgS
 mgAQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE60sfc+JEDRd8rb2paAj+tA/730sVc40p4EkgeCfcTY/jC6ETr7GKh+RZqq9v6jwB+7JsmZFh2HvMDBInM@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/QNs6Q0QlWzL+/UnwWA7DmseBD2BNS1HV1pC482N15iHXN0MI/
 N9Cq3GwRaah8VDyFdnS/42kxC827+p6sYOuj5xzTZLUlIZsxeRtghebGHhghqWL//2d8i3BSB+u
 6hyiCYcmk2bARiLk/RmDmfqry0GrEDkVjtKb9nKAqmZKiKu7qLslLVGexXzU095/ccuYW3EgAxk
 jNFpStmg==
X-Gm-Gg: AYBFou3Al4dz10fjR1181bkTohdmOBe38Tl70b+H3J7loQQ2wIVTHEfV8dL/p3MrX9V
 yJb3XitSdjP/cMr6taB7xO9y/e1wuuB87q1OA7zRe/tLfcHAzWG4o3ebJYebOAAYjYPYpfEQnup
 ReMyzvYL0DB3oo3OUfbYXcnRjDuFPTnZYjmAZG+cjy07e7irimb7WBxiX40UbfcFgGtihl+NqIF
 NH9iplx8b4lN/MqEs3kMdeFFbLOHpmRPpsCRN6Warz8pnjTSSkdBxjJuMRN4WsOPE9WinV2p4VZ
 yyKr45VwddodnjRFpcKHrwNTWG6FRyjy2O1fZb8iaPCAdZ1jj9M8Zd0i6X7m5zGQty3qhlAt4Z8
 /vFTCfmTJEXxqCtb5aB0unihQLISRrfdlE4Dn5/2hCd08+TT5jotS7KWQZb+zEOG+kF8zCeZtft
 FVO8ZvdEKANiy+AXyJHH2LWAUd/P8lbJRNJBQ15bxTRuRv3ijkbK+EVhvi5DREEFKxgZAC1KJW+
 aFPOkHHekXFdZPJNN7ZzB9aNj+5O7Ni1jPeH6yeMyWGiLmXHTAvI+SP9bDj7JXmpskD64OX+TwD
 siFEjGNi8W27N9GZe1fvirx2LAlBUL/7HrYhHx72LinSJFub/HEx7usFum5gQquQlJkUIOTU10m
 uZEueMhFryYy1kw81mgnbJvWWF6isHVtN6OEAzXL5hRyTPtG3gIPExLXWFdQPgIU7RBLYkIOREK
 bOcLJHWmKD4cnO+Q==
X-Received: by 2002:a05:6000:420d:b0:492:b5e9:4916 with SMTP id
 ffacd0b85a97d-492b5e9499emr3258980f8f.24.1793965365619; 
 Fri, 06 Nov 2026 03:42:45 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d087a3c5sm2900617f8f.0.2026.11.06.03.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 03:42:45 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 11:42:43 +0000
To: Heiko Hund <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib65ceb898d23777663c32241156d597918a24ffb
X-Gerrit-Change-Number: 2114
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2114?usp=email>
X-Gerrit-Commit: 2dea0d7f7ae25baf03867e3d5e92e34703000ca5
X-Gerrit-Comment-Date: Fri, 6 Nov 2026 11:42:43 +0000
In-Reply-To: <gerrit.1793747232000.Ib65ceb898d23777663c32241156d597918a24ffb@gerrit.openvpn.net>
References: <gerrit.1793747232000.Ib65ceb898d23777663c32241156d597918a24ffb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzQ3MjMyMDAwLkliNjVjZWI4OThkMjM3Nzc2NjNjMzIyNDExNTZkNTk3OTE4YTI0ZmZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e31492722b06a2b9fe9733c93705cc46def1b466-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPILM-000000004II-1YuT
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: don't
 stop if the next pipe instance cannot be created
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4295428819644213435=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4295428819644213435==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2/lqODEE+BI="; charset=UTF-8

--2/lqODEE+BI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund=2E

Frank Li=
chtenheld has posted comments on this change by Heiko Hund=2E ( https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2114?usp=3Demail )

Change subject: openvpn=
serv: don't stop if the next pipe instance cannot be created
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review=
+2

(1 comment)

File src/openvpnserv/interactive=2Ec:

https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2114/comment/cd2c2bbc_31ad694d?usp=3Demail :
PS1, L=
ine 4093:                  * Drop the client and keep listening on this ins=
tance=2E Handing
> All conditions leading to `next_pipe =3D=3D INVALID_HAND=
LE_VALUE` are logged inside CreateClientPipeInst [=E2=80=A6]
Acknowledged

=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2114?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib65ceb898d2377766=
3c32241156d597918a24ffb
Gerrit-Change-Number: 2114
Gerrit-PatchSet: 1
Gerri=
t-Owner: Heiko Hund <heiko@openvpn=2Enet>
Gerrit-Reviewer: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichten=
held=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-Attention: Heiko Hund <heiko@openvpn=2Enet>
Gerrit-Attention: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 06 Nov 20=
26 11:42:43 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In=
-Reply-To: Heiko Hund <heiko@openvpn=2Enet>
Comment-In-Reply-To: Frank Lich=
tenheld <frank@lichtenheld=2Ecom>

--2/lqODEE+BI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund=2E </p>
<p>Frank Lichtenheld=
 has posted comments on this change by Heiko Hund=2E</p><p>Patch set 1:<spa=
n style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; paddin=
g: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2114?usp=3Demail">View Change</a>=
</p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/interactive=2Ec:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2114/comment/cd2c2bbc_31ad694d?usp=3Demail">Patch S=
et #1, Line 4093:</a> <code style=3D"font-family:monospace,monospace">     =
            * Drop the client and keep listening on this instance=2E Handin=
g</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10=
px 0; padding: 0 10px;">All conditions leading to `next_pipe =3D=3D INVALID=
_HANDLE_VALUE` are logged inside CreateClientPipeInst [=E2=80=A6]</blockquo=
te></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Acknowledged</p></li></ul></li></ul><p>To view, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2114?usp=3Demail">change 2114</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2114?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib65ce=
b898d23777663c32241156d597918a24ffb </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 2114 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;heiko@=
openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: Heiko Hund &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 06 Nov 2026 =
11:42:43 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes =
</div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div styl=
e=3D"display:none"> Comment-In-Reply-To: Heiko Hund &lt;heiko@openvpn=2Enet=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: Frank Lichten=
held &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--2/lqODEE+BI=--


--===============4295428819644213435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4295428819644213435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4295428819644213435==--

