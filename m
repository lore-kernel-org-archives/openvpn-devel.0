Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52281606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iWMEdgOq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JyHDtBz+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RZ04n4KT;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ZWpGB5gN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ukzkp7RE1Vk9QLjsBvlBBCg/lZgHlqyEY+WqgG6mUuY=; b=iWMEdgOqUOojHe0zyTPD8a/6ln
	ikDEYPIrSM4ZYjKe++hznQfiCo9VnyuWb/3CqHuOSK1Eju4xukBIDOx1GoI0iFVXMPSpnmaePklXl
	8WASYYGUO4ilTsKt5Z5CU9/oJOxzlVtIIbFnXHvESUVi+PLfWOFP3UMks0jfZ/zPAWaQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOX4v-0000000065d-1i5h;
	Wed, 04 Nov 2026 09:14:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOX4V-0000000062W-42tf
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 09:14:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=trIGLBpCWrk+fjxicdOAnVis5FLrauM80zaARb632DA=; b=JyHDtBz+QpubY8l7DvbaUrQAwm
 oor8irxRSKAbOF1xsyB7lxL3o4tgBTtlQbmx0AkUNfGJneVbPtTT2i2XYDN3ji8wRuIVjy8V6fPU/
 gRAkCccv8BzYTX9qttnzF2IqwA409nOtFmuD5FmzIgQn497nNYNQOYYyVixC2+fgkUIM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=trIGLBpCWrk+fjxicdOAnVis5FLrauM80zaARb632DA=; b=RZ04n4KT1TrYjTLWXCS6TG+CV1
 0daszuBNRq+H9bnkvz96u24Q8aRKl2427tyhTsMK+sdmzNUO1uLpGWGmKhXNE56yGctYZ5B6pGsuC
 OCVlVXQ50hSz1IdEk8t0x/UUbYvH/DkWsIddqpT9Zj++RNZ79O6+Ne+mNk1u8Nk/CTvQ=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOX4P-000000004vc-0bV2 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 09:14:16 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so3631645e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 01:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793783646; x=1794388446; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=trIGLBpCWrk+fjxicdOAnVis5FLrauM80zaARb632DA=;
 b=ZWpGB5gNarrIQv+AtjysYTCvnCCqTD3TU3IdC1BbZo1S3u2ZCqMc+XjGT0cQbYV4yw
 xidObV2ao1Iz6UqWPWJY+Ntv5gjZ5cJ3OwIBTQbzovD13CF1bFjJtm/igTO/ZgPbu3hh
 6KbftJYTeqF4RSGaJ+uQBJCuaFgdYDcvrV+zRshgLpe5DMHMTT14n8LTf64w9l8PSLnu
 dmx3ewVP2z4Q+9QCaY8IY1H14DeLrFvrOZU7ujk7+RMAgj137+/RUFx2F5Gd+77TK05J
 SsUoGzH2D6rnRW59DfTndF3NK2sXfn39W2Xdz6pq0UqfnvScHfN/5AVgsFjnqFT3hIxE
 6ZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793783646; x=1794388446;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=trIGLBpCWrk+fjxicdOAnVis5FLrauM80zaARb632DA=;
 b=VBzDqjZ+Cc8uyS2rsGEgwSDneZvCLrczdmhi3F0yjmQ9dpdtppOVybiSFhDInCdPzj
 Oh91MsVOuRwm0UGJ8HoQSG54eMC7tEfPAl6jZjlAydabXnoPCod1iwyJg3Dq/hl/7kUB
 VdXLe0mX5YcHnc3IZfqhCMn6zMLA4ORh5mYbeTmmJ9JMt1WWrzKx3eskmxjL57oSjLja
 gtBiN5M/cGz8hRunVEnvGJT51t9YRtwHP7uGGCBgmj9N87WcVZ0vV3cum82u82iB7l1D
 MStlYyOFXNfFKcupDfcwYYIquBvUgpywixlEaX/jpShuqZvUbtusD9UdkcEtvxb8il5R
 fhXw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzpwVm+kS0CEo8sgbzqfU6aagzCA6mBI/7+231Zw6GPEjPG+Uy4h+tcrwT52HlGB3IjAj+NyB5atQ7UhxzF@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9g7eX0UB/qoIH+yZa1cbroczLS6uFrE/yxZRnBO7zIiIb1Jsji
 x2cciKQNXD+EW1xvZLqvkOSKwAffSILVwQvktzjyCORVZ+YYfkAMIA2j/olzABFsI2Z5FinkLbM
 ST172Qkp9Et2U9UGWZiOKG3CmJVgcpScIUw7ssOkfxr0n5otcRAbyzyJZ30WtzyxhDvjmvcuskT
 yiC7BafA==
X-Gm-Gg: AYBFou0aHdJCCOit4pgrie6qzN6J+BbYCNKtEQKL0bUOLuk09uL7xJbl8p8N7heTrfv
 gnLt9NMFzb1cZthzXDA5maJlIxvxodfFUuNUzYKom08nl1xgqzxNYyDO5Y4p1EzQA/DgHyD08Tq
 sXi41B8EAPk2llmaGytz0zqtKGWgltqD1+XWlRgZQ6MZf/4sHFaVmFqoXXQq99VXNttaezwv1cD
 SWsPU4qlQPDGXcx65IuECofU/keuDG/A996LeSSadzO5aHRpUv5jzojruU/R+UB6/io4VX0+/j7
 pt7KHZigy6hv79w2DrwUtC0BFsuzZ8qns52bYSLytTB/1EPPLE9gikq1D8575TeOr5TEtw1qo/4
 Xdo5x+jk9uZNjQUeHgyoS8lK4jLTirVaIEAO85cwO6uzVx7wsvk/mFldlYaiqRQ/lZyqA/N7f+3
 JL1a1TYtTVq7qG2W5zI9YKMhvq0o3S0QiyuaeSrd32n6zMR1bOSz4f5r/NJRgYOf+MY9jKG1Z+V
 xQov4OAYoVo6EytTNlD1IveG2Esd5TNP/h0ZxAuONazZt3fXtGoAvZ5Q/WPUwOf3aYJjACNVade
 INe2J5nkvRSsKHKsVHfMMU+O/BWo7K47ugWUJtKCD2LeRf3tcqm/RBx3ElhrrMy1UyhJps8iKeb
 JeU/t2ijQFnCP+R9D7lePCmf2Uk/6VZ16j8DoUaHd2Q5wtvB6jD3d4Qf2Auu/Pg3DfkXDLmq5g6
 U8YKMHn3YosZejcGM6KMm6dAn2wCcjxDPJTDQ=
X-Received: by 2002:a05:600c:848c:b0:4a3:5da2:38ae with SMTP id
 5b1f17b1804b1-4ac17a3628emr353409485e9.14.1793783645963; 
 Wed, 04 Nov 2026 01:14:05 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a80e184esm130520545e9.2.2026.11.04.01.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 01:14:05 -0800 (PST)
X-Google-Original-From: "Name of user not set (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 09:14:03 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22
X-Gerrit-Change-Number: 1860
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1860?usp=email>
X-Gerrit-Commit: 22604de59ef894681fe6056bfcbc90c4c6a9fda7
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 09:14:03 +0000
In-Reply-To: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
References: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzQ1NDE2MDAwLkllMjAyODk3MzdkNTAyYTI1ZWVkYzYwNjc3ZDNjMzUwZGRjM2IzYzIyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1d683b5b9d3335e3de51328bffa65c6ffcecce39-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOX4P-000000004vc-0bV2
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add python scripts
 that demonstrate using the dpc1 ACC protocol
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Name of user not set \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 ralf@mandelbit.com
Cc: "Name of user not set \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7659570746957631324=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7659570746957631324==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6RxNpIS2qzU="; charset=UTF-8

--6RxNpIS2qzU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Ralf Lici=2E

Name of u=
ser not set #1000061 has posted comments on this change by Arne Schwabe=2E =
( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail )

Change sub=
ject: Add python scripts that demonstrate using the dpc1 ACC protocol
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 6:

(=
3 comments)

File sample/management/acc_dpc1_client_demo=2Epy:

https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1860/comment/e8c3d033_8e84a97e?usp=3Demail =
:
PS4, Line 86:                 "ver": "1=2E0",
missing correlation_id and =
timestamp


File sample/management/acc_dpc1_server_demo=2Epy:

https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1860/comment/ce361a79_aeb3e62c?usp=3Demail :=

PS4, Line 68:         dpc_response =3D msg["dpc_response"]
Shouldn't we ac=
cept only response with the same correlation_id as request?


https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1860/comment/7dac9071_179da6ee?usp=3Demail :
=
PS4, Line 123:         dpc_cmd =3D {"dpc_request": {"ver": "1=2E0", "correl=
ation_id": "n/a", "timestamp": "yesterday", "client_info": True,
timestamp =
shouldn't be real timestamp? correlation_id shouldn't be real uuid?



-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie20289737d502a25eedc606=
77d3c350ddc3b3c22
Gerrit-Change-Number: 1860
Gerrit-PatchSet: 6
Gerrit-Owne=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Name of user not se=
t #1000061
Gerrit-CC: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Ralf Lici =
<ralf@mandelbit=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Comment-Date: Wed, 04 Nov 2026 09:14:03 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No

--6RxNpIS2qzU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Ralf Lici=2E </p>
<p>Name of user not s=
et #1000061 has posted comments on this change by Arne Schwabe=2E</p><p><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail">View C=
hange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File sample/management/acc_dpc1_cli=
ent_demo=2Epy:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860/comment/e8c3d033_8e84a9=
7e?usp=3Demail">Patch Set #4, Line 86:</a> <code style=3D"font-family:monos=
pace,monospace">                &quot;ver&quot;: &quot;1=2E0&quot;,</code><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">missing correlation_id and timestamp</p></li></ul></li><li style=3D"mar=
gin: 0; padding: 0;"><p>File sample/management/acc_dpc1_server_demo=2Epy:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1860/comment/ce361a79_aeb3e62c?usp=3Demail">Pa=
tch Set #4, Line 68:</a> <code style=3D"font-family:monospace,monospace">  =
      dpc_response =3D msg[&quot;dpc_response&quot;]</code></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Shouldn&#39=
;t we accept only response with the same correlation_id as request?</p></li=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860/comment/7da=
c9071_179da6ee?usp=3Demail">Patch Set #4, Line 123:</a> <code style=3D"font=
-family:monospace,monospace">        dpc_cmd =3D {&quot;dpc_request&quot;: =
{&quot;ver&quot;: &quot;1=2E0&quot;, &quot;correlation_id&quot;: &quot;n/a&=
quot;, &quot;timestamp&quot;: &quot;yesterday&quot;, &quot;client_info&quot=
;: True,</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word=
-wrap: break-word;">timestamp shouldn&#39;t be real timestamp? correlation_=
id shouldn&#39;t be real uuid?</p></li></ul></li></ul><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail">change=
 1860</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1860 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: Name of user not set #1000061 </div>
<div style=3D"display:none">=
 Gerrit-CC: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Ralf Lici =
&lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 09:14:03 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--6RxNpIS2qzU=--


--===============7659570746957631324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7659570746957631324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7659570746957631324==--

