Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D02606A326
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=U3OEI3HS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fFLwuWsE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jXPDnNvW;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=MeAlRxjd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tEcPcz9gHqBUIoltnitSi8d1+7CsGAtUQj6e8hAzq3Y=; b=U3OEI3HSvEPYZy8QCnaCOQPfIF
	ZnsL0ha588OMQAqwAws0qOH56OWvmBW0JHkGljbG83gBy38l1lZemH2PsqhZYOZy9ApTKEkV6irz+
	A6TC9Y9EFphAC0jvDE9JZrP71FT333StNmglMFcNPqRYKULcEaiNkU/JomHz3/DB3lno=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR4KB-000000006Og-0lit;
	Wed, 11 Nov 2026 09:08:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR4K7-000000006OK-0ny4
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:08:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jv7w6gKRhQIb44pRVnJLsNhMi66bdycNFGzb7Px+yuE=; b=fFLwuWsERr6hiEbEhOwQv3VEgW
 PvTWG+k9Dt1jGmmgq201nvuDSpfUGEOTaOXPtU9m0rKK2h4dkJLpuXgcSNBTjSg2DzzWAtQxtePCz
 IbuoOWGv0wD9Do2aha1BGpllQiUrf4VYRF6O1bUQXFhhvhvp0jbbY6wwp/jI3Wr3y1tc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jv7w6gKRhQIb44pRVnJLsNhMi66bdycNFGzb7Px+yuE=; b=jXPDnNvWF1dtn+LZHoqa5QHMtm
 I/MOD9Oj8aSagxpXTVCh2CzmHmvp6PrTVdJwDsUdG8Q8sibwjYs5DH33CxquuCzMhAeSRG3TEHDnT
 FX4c0qyiolsUTrnRPtF11fBVJBF9SrV7T1Q2wyxS2T96TiY2I9cfIs+1rET3OKoQUJuw=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR4K6-000000007tJ-2RTD for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:08:55 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48fd2e38825so1785791f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 01:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794388128; x=1794992928; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jv7w6gKRhQIb44pRVnJLsNhMi66bdycNFGzb7Px+yuE=;
 b=MeAlRxjdnYKMHb4fMXuotnwzKeIKZHNChhyTIW+5aVPvpHAclfJIOgzoXqHMBG7Z3O
 vXajKNwYPTKefW+xz9+KcDiEG+goZUaO/gUjrHnMJrVNywnbrWQA3AIuQMm61xSiC417
 Klpip+hra1YA5Z0F1C2rjwLjv1YsS0kuX/3NhlKrec0WV01XxMkfl3JSyuzN5DdVwxvi
 bYrBZdEu/ndCngLJf8kj0PexDb/kEqBoUk0RQ/1e4pWR0ZNJtXEIO6qGdWaHj3q1ItVM
 HeBypVwq5Sagoilm4kzBt4lWC91qRoNk2dEg4knXzPon+sSwZeOiAqzprV6s/8Grq8ts
 Vn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794388128; x=1794992928;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jv7w6gKRhQIb44pRVnJLsNhMi66bdycNFGzb7Px+yuE=;
 b=suI/t8GRz5v5fbPOYyWv1TNxbShNkqt7Gf1KB1lasKhSGMt03rBktuIOMID70Lts5j
 vc/weUZ535t+xQv4ziLZyqujIBcV8ct5iW1esRaDOYCk9Pu0jLDvI0apm1gCIrXWHp4d
 Arwlsoeh82Gweq4HnQAjLARKpGKjQHHf7JF8Q80KncNRHvvrZQUEN0Avx0dZwh6oG1PY
 ZsX+reXuSO4uJhatcWOVMx7FXFvj3Y/XMBRkrXuQF7nUCC19ZGTzKGAVMb1VF0C36Q8x
 VnvlvWeGQDGRT0IQK2AKKpAFMpscBZ+HOzkVClRXFnAJb+w/g7N1dq2DH/LublZErceQ
 jeig==
X-Forwarded-Encrypted: i=1;
 AL+hErG7+58Pw4KDsUUtZyg2Nub18M0BI7byM5abJJzVunoARXE15lZnTkDdxCg5HVZdcocjbuhxbjIkWy1rFOqZ@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/ZIQXOhVWZD8IIe1CXysoJFbNpNwhVw56CHv5MkEgo0Y7KtELl
 CmLEhO3OAqz/TPiisLPGqU3MrgUZNLAVp+BqGyr8AXEir3Ktuthepamba0zFkTTkB5ZhZgYIJVC
 n59cUAP2ssKxnUqBN3T47oRilOUdPja6WUrkMa+z0eRJTonyGXQNJ7Xf+cO9H/6q6TlFbwaAKbW
 VFkK2JsQ==
X-Gm-Gg: AYBFou3wEo/zOUHi6PgflemEqg5mHdYKVygh+zwlrdI4IhI+czYwQtLQcoOT2CVulGe
 eTOtF9ImOF/atjXUufzHSOcs21O//34l83pnQQkyARugzNbQp+ebqtUPXazNFw7pB9vOO4Db7qk
 j+MCWLQLTBBj7pbeqkBnMIvfWuYLsxnPHlwkBoRjr8G11R2waOe7efSaE7OYvrUyt/6QQjKJW9r
 8A+nmM8e2WHZwX0RIQP68Vq58IHX2hLlR8JULGusTtHIIku89YEJmpgtcyoEPldnYNLC4Vrfctp
 AWGtTUtSZpiUPfyExtJ4S5/RcUXl1K22LxBdkSZDcV6OIYK9IOiDCFkd0F5lxD+gNplljz0zuJh
 gRs6lheOOwvmVWpsuT/NoCnIdlLLBa7uUqTX31NG73KB/XnBvlmUjUumxOINnaCjQTHTcjV8Fqv
 3V7b+P2PRj/krV3z3qpA42d4EFEczU9IBj7giYgbm+c+NeAQJ3dFclHS6MQDdp5Q5Pjn7+NWI0N
 lnPOzVrY0IWVd1r+qg19hxwW5qp0lFZcCTWvyRKuY0hj2oE3HkRXvuBAXPxoNdzUdePkDYdeP81
 Ktf/hdFWUYcpbVkjJh30eYapiHvtdr5ZT3mZL5I9Mg2kmba4S8mhBzpVEFaAffYUsVbMjZgztrD
 XmHwyZIIIElED6MsYDMT3QVgm4m2nQn8pJKaOd9aHlhUxjlMCmb3Ee7K6xEXaTi7Fs/7ZKyZV5x
 mMfEPLpkJuzdj8ZBQ=
X-Received: by 2002:a05:6000:2008:b0:48e:d88:55f4 with SMTP id
 ffacd0b85a97d-499c38bce0cmr2869849f8f.2.1794388127881; 
 Wed, 11 Nov 2026 01:08:47 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498362eb158sm9613858f8f.36.2026.11.11.01.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 01:08:47 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 09:08:45 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972
X-Gerrit-Change-Number: 2162
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2162?usp=email>
X-Gerrit-Commit: 2e800a1dd0418ad2290286c2154a9466036f6233
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 09:08:45 +0000
In-Reply-To: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
References: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzA0Mjg4MDAwLkljNjAyYjEyNWQ4NTdmMWJlZWQ0YWY4NjYxZjUyMmQzMzliYzllOTcyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <acf5b48762889059532cdc34341d6143d51df68e-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xR4K6-000000007tJ-2RTD
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: keep
 IPv6 name servers in NRPT exclude rules
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
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5630625718859224060=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5630625718859224060==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eB8MThHTi8M="; charset=UTF-8

--eB8MThHTi8M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demail )

Cha=
nge subject: openvpnserv: keep IPv6 name servers in NRPT exclude rules
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(=
1 comment)

Patchset:

PS1: 
> As far as I understand, this patch fixes als=
o a separate bug: both readers now set addrs[0] =3D '\0' f [=E2=80=A6]
Yep,=
 that was intended=2E Added some text to the commit message, please let me =
know if you want additional info or rewording=2E Thanks!



-- 
To view, vi=
sit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d339b=
c9e972
Gerrit-Change-Number: 2162
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83z=
van Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <an=
tonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attent=
ion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 11=
 Nov 2026 09:08:45 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comm=
ent-In-Reply-To: Antonio Quartulli <antonio@mandelbit=2Ecom>

--eB8MThHTi8M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demail"=
>View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2162?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">As far as I understand, this patch fixes also a separate bug: both r=
eaders now set addrs[0] =3D &#39;\0&#39; f [=E2=80=A6]</blockquote></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Yep=
, that was intended=2E Added some text to the commit message, please let me=
 know if you want additional info or rewording=2E Thanks!</p></li></ul></li=
></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2162?usp=3Demail">change 2162</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2162?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 2162 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none">=
 Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@m=
andelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Antonio Quartulli=
 &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Comment-Date: Wed, 11 Nov 2026 09:08:45 +0000 <=
/div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div styl=
e=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none=
"> Comment-In-Reply-To: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; <=
/div>

</body></html>
--eB8MThHTi8M=--


--===============5630625718859224060==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5630625718859224060==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5630625718859224060==--

