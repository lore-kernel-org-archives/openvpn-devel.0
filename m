Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2CE60A260B
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 13:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iLf/yY+Q;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YJ0Vn3/d;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bbeI9cM6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=eF8tIXVz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=sSYgJZI5KOsJbi5/muSZ2Vr70F9xQYhYAELvEEsJLBc=; b=iLf/yY+QIFxdE9ofqW+1AfqTn4
	AGXsfoTwyBHx7BhE3coJgMC4C5/0znK/71QGwSv/VD9QcySdt5lsiYorAeCAOS0BACdtb4V2Jpext
	9HOS8wWNXXUPBIhF3W3m5482fRmuBP9fi+Pxa8tGYYZPFshMcSZZPAR0uO5IBUtNf/bo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQmFX-000000004OJ-2zTy;
	Tue, 10 Nov 2026 13:50:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQmFW-000000004OD-41aN
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 13:50:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rFDzS910Q4RIUqeZrgzGfF835ruJnf0bODLkGoNoYXQ=; b=YJ0Vn3/dNjoyBDSIrJGo0rukNy
 kg3o5DL3MrfIlkEXI0LJl8TVsd1uIsAEjhLabz3z/lMCODYe8WuuCid8na9RQxji+9lDokoTILnS4
 aBYJbSfwpw42dVQ/XIa+LM5p+Jh0unUFNsE3UgS+4XOcWmeJ1OZBKF0D95qos6ZcPmdY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rFDzS910Q4RIUqeZrgzGfF835ruJnf0bODLkGoNoYXQ=; b=bbeI9cM6spZGsBxD0CTKo369cS
 8lTx3Vbqx11UJMIILtuQxgyQVA6tBvQGdltKm80l+HQR+uE+O/94iBvNj31daTJ5evNXeACCu3HD+
 s4S5NYqH9S8SM+Qwcqrlh4mR9aKERfpfxsthfsktSrQp6Uv14vLh0br4pkbq53QswbNI=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQmFV-000000007aq-0ZpJ for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 13:50:58 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso21915045e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 05:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794318650; x=1794923450; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rFDzS910Q4RIUqeZrgzGfF835ruJnf0bODLkGoNoYXQ=;
 b=eF8tIXVzPhzNNyqhU2U4jZ8Zv3LTMU2+Kh/HtvPvE/ovCIjqjFAhLAOD2jV72MZt8Q
 5QYFymJ790bxhzVWN6CGEJRe9QBrBmw2EdgC5foGK61t0kUV01nm4JEc93147zymgV1s
 Iye+NhCbmRyfVlc2vwuijjmJKcFE3BMW1XYP7OZOlBALoiIgM2TalJfWc5snZtM61C7E
 PQi4ZU5Z2fNEhdMb2InuIak5bGfnbN10uQRf70erartdSPphFbLfZd9ar40ekdb83nIH
 q5Cjc+llhGRjeDB7Tw8f2GFtK1DxFFrZ+zGwh1wZyEiT3x31PzgDXxpW+kutnPHSOuiP
 IkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794318650; x=1794923450;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rFDzS910Q4RIUqeZrgzGfF835ruJnf0bODLkGoNoYXQ=;
 b=SfMWxN5Bb8yLB7uT7LRQqDqk65EVgWbrN6D81CM6knNYEwJ1m1apmupm882ndVZk3s
 tzQaHgn3pEtImBo47dKXsygJ+tjZGL4CoLiDMwAXrIBXKl5FGEAWEwlULiKSjdhvvQ/m
 +59CU5Z0PptUoYJ0yLioWcuKfGOL8nWin6le3kbEW0G8X9EztuWMvuwoBk1Mmbn6Do+8
 Swmax8DyELDaR6ckxRQm6eq+cjtsQbzgYGbQ2oQTzRX/VekiYvHBfpQa3mMP3JmUmSHd
 wyRKZc5jxoZSht6bqilwbml1NgPuLjASRpU7JGN0yXrVlys47fE+98g7lm2TSXEzD1xs
 jkxw==
X-Forwarded-Encrypted: i=1;
 AL+hErEacBKxtsi2IbM71200inBE8mW+tR4gS+BFBOIcsYk/YHj0L2PVzaFgF8cGtrVdLSjsG2BEBBAYZLOYdfgP@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+WwDgd6ztrByzjGBYjCjnz9g3CJ/JnO1Fa8dZ9Iu9wYs5lxmoo
 VJEZToSEjy3X4gEmUH8f0alYwcDjkSM0Wq5hwJo67IcE21HbrGc5YC93WDft8Qarqe/AqTPUzTQ
 /hjBi028AhacaY1J9751hAAFPOJ6UA0uO1SKBM2grBsee1UtnVKfpDJnagXIL4+moe+nh
X-Gm-Gg: AYBFou16WFkhxl6v6JFC+Cb4lvcpdFCoquFhBCg5Ez394dfrTMg21SGhwQxh2SzUwyH
 yYuSqasYFq7cHBqPPXxr5GZxb+6ORQ2Kw2zg50oS314m2xEeIiH/4nDb79ITz8o4h481nH+uw3A
 XIn1edUoc//cFzWR5TrlI4V7rf+BQndJe/HABHVshMYNKFy0oU+BcrVNmMRwRq0H4cNDzy/3LeH
 YK3H49P1GME16FdFPR+TF1gBXWt7dt4rs6mFgRngzbd8m5xEhlOIJRo8iQzrjM2kAmJuNLfutLd
 ZERu2rwIrx9xrwi5Up8gX5EVAhPdthTYo1UQENgsjAOc8TV/tEXKr+GJXPdP15Y2x9ybzjKtYOp
 8+D/0FjbfYAuZBKrvVBpxFp6RnUTUZToLdVHpfPbYeMRyPpAfo9qz6Gaq7TbWZO+CGHrnXixRth
 917rJqZWivsGCx8R3l1MNihO80Uvizv6DQP7B6r/3ltEGE/EUsH16pkG6Yi5zmY8Km7LKB5p5Tt
 Z3dIL8Z13MBHJ4fEZMmkbq27wgb750o6ZSdZfzZOXfXIVN+wO7LqagvB6+gp8Kqh5pTbCw07uSl
 OPdm+fEj0bfCy/MhoVkhvxNcZw5Hcdn35x6+ErhhmhB45ewqd5oJZ8BaZ5lH4KtXXZWVv17M3GK
 AzNPpjBeKvP9nAbJNippnD61B6imnxl+kLWrd+3MTydmwTyHKyynrfnJnKZS810N5wEWBYNB4en
 4okHPtCdyvLwWFlMVgCb1bgilNLydzXKfLlUBB
X-Received: by 2002:a05:600c:4709:b0:4a2:397:73fd with SMTP id
 5b1f17b1804b1-4ba02346e8fmr43983095e9.12.1794318650413; 
 Tue, 10 Nov 2026 05:50:50 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0234a5dcsm66125295e9.2.2026.11.10.05.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 05:50:50 -0800 (PST)
X-Google-Original-From: "Marco Baffo (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 13:50:48 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: If6782ca8cb6030170016c79ac6f02598af6a4bf3
X-Gerrit-Change-Number: 2164
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2164?usp=email>
X-Gerrit-Commit: f1c4e2fd753c16929b5e055b5d6d45d70fb6b2b9
X-Gerrit-Comment-Date: Tue, 10 Nov 2026 13:50:48 +0000
In-Reply-To: <gerrit.1794310345000.If6782ca8cb6030170016c79ac6f02598af6a4bf3@gerrit.openvpn.net>
References: <gerrit.1794310345000.If6782ca8cb6030170016c79ac6f02598af6a4bf3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzEwMzQ1MDAwLklmNjc4MmNhOGNiNjAzMDE3MDAxNmM3OWFjNmYwMjU5OGFmNmE0YmYzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0d6f2467d8ac3602c70bcf78f3455bcce4240212-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQmFV-000000007aq-0ZpJ
Subject: [Openvpn-devel] [L] Change in openvpn[master]: options: share the
 reset code of remove_option() and update_option()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Marco Baffo \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: marco@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Marco Baffo \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6871258163711840620=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6871258163711840620==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZEkU70e+6zc="; charset=UTF-8

--ZEkU70e+6zc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Marco Baffo has posted comments on this change by R=C4=83zvan Cojocaru=2E=
 ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2164?usp=3Demail )

Change su=
bject: options: share the reset code of remove_option() and update_option()=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 1: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2164?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
If6782ca8cb6030170016c79ac6f02598af6a4bf3
Gerrit-Change-Number: 2164
Gerrit=
-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ger=
rit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Ma=
rco Baffo <marco@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
G=
errit-Comment-Date: Tue, 10 Nov 2026 13:50:48 +0000
Gerrit-HasComments: No
=
Gerrit-Has-Labels: Yes

--ZEkU70e+6zc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Marco B=
affo has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>Pa=
tch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin:=
 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><=
p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2164?usp=3Demail">V=
iew Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To vi=
ew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2164?usp=3D=
email">change 2164</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">sett=
ings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAct=
ion"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2164?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: If6782ca8cb6030170016c79ac6f02598af6a4bf3 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2164 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Marco Baffo &lt;mar=
co@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Comment-Date: Tue, 10 Nov 2026 13:50:48 +0000 </div>
<div style=3D"=
display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> G=
errit-Has-Labels: Yes </div>

</body></html>
--ZEkU70e+6zc=--


--===============6871258163711840620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6871258163711840620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6871258163711840620==--

