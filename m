Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C8EC43458
	for <openvpn-devel@archiver.kernel.org>; Fri, 10 Jul 2026 15:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KXTzIR+PdwRc+knSuhcs5NO6b2uO6PfbPh/WpN6icq4=; b=Ki6jd3yGJTBQrz1zgvM/oLbRXp
	SivWffQKTmEZilB7IB5Ux9b5nEGb758T0i4iDaox36VgPJwh2HFx2r296yS6ncgaYW229a3qQ4yhn
	qo3kqGw3KYHw1D40F9wQteYe/64hU0PPdxIGvKs2u/4JLspgdiHRi4XjczjM6mGldU2c=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wiCue-0007aG-SZ;
	Fri, 10 Jul 2026 15:13:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wiCud-0007aA-4i
 for openvpn-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 15:13:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=dFA0LIF9zexuyMyn2NIxfvkrM1BxP6JRjKd5I7VJ8j4=; b=CThArabZTNVMwxTxSIx3yWGyyj
 wO+Kyuj0ND1vPxFQbL4A9rNGhmNtQWrcyFGTLuUwLSjK9WJu/Y5f/jTMpVkWNbkEGwpX53SEWSWHq
 agvfI0khVzHMQb3Jl4/TRNd5Ck0ZoS6m9CsQf8qO39WiFzpBk7uGajWWbBhkYg3r7hNc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dFA0LIF9zexuyMyn2NIxfvkrM1BxP6JRjKd5I7VJ8j4=; b=c
 YiKCmXfVCZ1NE6VfJBYEKV4uxu3om2oVlm0ClT32AwIi0ClilNXq3ONQg7Uyyi2f2cwKMNbsHh3/t
 XFrL18xsA29Rco0zZ+R+DlR9jDECLpl4kAfZh4AZABLEbAtJA+4EmiZ4IUKTEVySgMpoOHBs8ZLyc
 PzBh5ubEdE5G0Cts=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wiCuZ-0005Rv-Up for openvpn-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 15:13:08 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4720d22c94aso1015071f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 10 Jul 2026 08:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783696381; x=1784301181; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dFA0LIF9zexuyMyn2NIxfvkrM1BxP6JRjKd5I7VJ8j4=;
 b=R18CfdN9ddEVpg2Ou/WpcLN2RXrMWYN21OlyTUB0aq8dUc6EgBgzoHadbdJMTworEq
 SWvTDFBaSnQSKnnC9CqkbjrgNjNzfhyPGiwc3BuZA/JMnJVAa/8ceuqob+zeBKcK40Pp
 NjVl1cEwTPu3rwNnGLi7lvkV4GsAhYwswn9xSi6I1BupuzcFjnGhh1EVRicSHH/5wYjX
 cCHv0dCqNM/D5luOOixS07QBLoQCisfSTASdpSpXL+Ff0D/6MZjInePQce2X4geFct/5
 xXvOAU1LNgVgfexDt0Q6Zi2GKuL1V0NL9PEIqfq5pL0u2wOLldsBKZ6/pPH7opee2L7W
 1UVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783696381; x=1784301181;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dFA0LIF9zexuyMyn2NIxfvkrM1BxP6JRjKd5I7VJ8j4=;
 b=EIJ9NtJxioyHrYViiGpbJDe5qVd72KW/a2z8XTonCxbJ1ohZ6ZJ9WtkTYNVfKGSxoE
 F/tucv6yATPYKHJHtWePt9NWZH3A9Df4WO6ui+SXaxP7VF1Psl59nNjXiE1s0UZCd/Ct
 2CEjSmEpjaO7LGdBdpgVdVkaDB9gEFSCYpTLhybh0v5Ezys70hplSXw1oc1ZnfM2ofX5
 ZmUL8eTsQlPj4DXcBGLGPmUulmQ4FbzBnLxZX7MkpvUG1Ci4Cv+x/14SfoUaBjoOTSiM
 r5E7PoN/gx49fOqZidpqJq3hhcSWcZbJ1OR52HPTIlX5uFPl67MGSXQ5Ucdr8sqgqovJ
 gLUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpcNXOXWNqFNE7K7i5Nlm93oLYthC44nNXsUiQD0Os8qSJaXxrY2bh34RwyMctbEWtuQ6TAX07YAGQ+CEJJ@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yzil05g00vFh2WQaiuwdkl+gJgxh7D2tRimMb/ynEyKygGXZTGB
 FOrLftgYsCiOlRMRCEvNQU0mHd2cZa30B5QCsXhn0SwziPCfPgcvRa1VX8Mezq7pK+bCt7SYEGm
 nXcZHMWchfYalZiMKW8gHc0XUpujz/zi1vz+kan637UuCDVYuu48116Myf/edh1W/inGx
X-Gm-Gg: AfdE7cmGo9bAqguHiV1dbvhZcKFwHX10Wh52mtVOXcWp9R8CZBzqyhNo3tcPv+rHnWb
 hY5bVKegpJ6G70cODnRRD8Q7drxNTtMTm/ErtjvtBAc+dRrp4xNU7L27bYZ65hf5QYMA0ZCayWH
 9HBqknHdHmSwvqUciZg45EMKTfy0EPJU1L1zZbNJWXfs9YWv4EfYH7wLPIwMbXpdjm789Peh03d
 IIQ9eFJ5daflb8xrVKBuueHGtvwUWXaDdioX7404KpVvNZnLEnCRzIhbMEepisS02IPc7EUs5s2
 TTLUO5jMAnTeC+pGVJMQGlYQsYeEZqEsH3C842fPThMVFAADtOg8QBlagtIvb9oooHIs9hvJR+F
 eChKdJ1ulrVoL1qKTMfLXzBl2/T0Tff2nXisuWYH0TVOZ/0oHoYV9hs6hlenynwHssT3OjcNFlL
 d0LZUii3zoSWggPiBCNIhb9xinwuzcY067Z/QlhWaJJlKabKJNe1oUxe0VzLaBbl+W/8uWxshL8
 onEt0eCyvGwRSUydxXpQIIpw/H6I4Idsaz/fQxDl43GjWy8/EIpqgyHFfsZEO6nzxp4d6PQzrLf
 fqk=
X-Received: by 2002:a05:6000:4709:b0:475:f0d1:eb60 with SMTP id
 ffacd0b85a97d-47df07c6075mr13750719f8f.59.1783696380623; 
 Fri, 10 Jul 2026 08:13:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d905sm63105653f8f.2.2026.07.10.08.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 08:13:00 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 10 Jul 2026 15:12:58 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I704c560fa23c03237d0f8adc30908a617265a5a1
X-Gerrit-Change-Number: 1478
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1478?usp=email>
X-Gerrit-Commit: c28a85bbd0eaa065ca92c77676e488c2e394a3a6
X-Gerrit-Comment-Date: Fri, 10 Jul 2026 15:12:58 +0000
In-Reply-To: <gerrit.1768848003000.I704c560fa23c03237d0f8adc30908a617265a5a1@gerrit.openvpn.net>
References: <gerrit.1768848003000.I704c560fa23c03237d0f8adc30908a617265a5a1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY4ODQ4MDAzMDAwLkk3MDRjNTYwZmEyM2MwMzIzN2QwZjhhZGMzMDkwOGE2MTcyNjVhNWExQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8c8649fa0687fb8c5efe1e4b69823a8b8c40b326-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wiCuZ-0005Rv-Up
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tls: reject incoming
 reneg request if primary key is not fully valid
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5021570058303766429=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5021570058303766429==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="P9lHISjwCv0="; charset=UTF-8

--P9lHISjwCv0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

ralf_lici has po=
sted comments on this change by ralf_lici=2E ( http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1478?usp=3Demail )

Change subject: tls: reject incoming rene=
g request if primary key is not fully valid
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4:

(1 comment)

Patchset:

PS3:=
 
> I agree that ignoring the reneg and going to `done` is less harmful=2E =
[=E2=80=A6]
Switched to `goto done` on v4=2E



-- 
To view, visit http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1478?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I704c560fa23c03237d0f8adc30908a617265a5a1
Gerrit=
-Change-Number: 1478
Gerrit-PatchSet: 4
Gerrit-Owner: ralf_lici <ralf@mande=
lbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: orde=
x <antonio@mandelbit=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>
Gerrit-Comment-=
Date: Fri, 10 Jul 2026 15:12:58 +0000
Gerrit-HasComments: Yes
Gerrit-Has-La=
bels: No
Comment-In-Reply-To: ordex <antonio@mandelbit=2Ecom>
Comment-In-Re=
ply-To: ralf_lici <ralf@mandelbit=2Ecom>

--P9lHISjwCv0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1478?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1478?tab=3Dcomments=
&amp;usp=3Demail">Patch Set #3:</a> </p><p><blockquote style=3D"border-left=
: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I agree that ignoring t=
he reneg and going to `done` is less harmful=2E [=E2=80=A6]</blockquote></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Switched to `goto done` on v4=2E</p></li></ul></li></ul><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1478?usp=3Demail">cha=
nge 1478</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1478?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I704c560fa23c03237d0f8adc30908a617265a5a1 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1478 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici =
&lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio=
@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Comment-Date: Fri, 10 Jul 2026 15:12:58 +0000=
 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div st=
yle=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:no=
ne"> Comment-In-Reply-To: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Comment-In-Reply-To: ralf_lici &lt;ralf@mandelbit=
=2Ecom&gt; </div>

</body></html>
--P9lHISjwCv0=--


--===============5021570058303766429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5021570058303766429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5021570058303766429==--

