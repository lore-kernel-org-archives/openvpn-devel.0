Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B01606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 11:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FUUu6RqF;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gKnwcRdk;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MAW2C8Z6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=agwZBy3r
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=YSATkNDGncB+NrTiYtKKs/NL49cygiuZh91GyOiw/No=; b=FUUu6RqFKquNWNSk2EPovj3lyc
	IpD3p69hGBz7dHSsaSYWibz64tNBPXOzLlDtPCZUDN90nUKw8eMIi66HiuDHZSghEG5RKtpT4L62X
	f2nefSjDSfhK1nG50tpHA27tmMXM+rag8WuNwAyWKlzTaMS0zFqBWOB9ncQZNtSSNLxo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQkLc-0000000089K-05ar;
	Tue, 10 Nov 2026 11:49:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQkLa-00000000898-3pzj
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 11:49:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/jv8ubm13zZFu8HlrnN31OHTok1Del26M1Afb++KgRk=; b=gKnwcRdkzUIgBBCESYhktvs3QS
 bl8QOYoTYD6JxqfmCNTPfz7c6Y3pGtOQG/kOc3ETeprvLDgfLhAi8F/JwRedt2QjTJARObNlG6z3f
 jvnjBL12RM5wcluq25yhbxl5Zs5IQP6sBbo3epYn0Y9rs1n1ng3CaVXOwWlojGh1fsj8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/jv8ubm13zZFu8HlrnN31OHTok1Del26M1Afb++KgRk=; b=MAW2C8Z6FBCYyqY/rG5ZkvyTgL
 cDSsqZp7O0ToKy2TVsC5ejf6/0uhmk9VdMp4I9x3vrnm7+JuQeOYpzUl+1RdVCFs/U6uKqSXIJY7p
 PxMqrDCFIV4PUfCAL02Q23XXUoAAa8wzluQjBPGFWupGKMQpXLRtTrVDnDwQcQCgINjU=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQkLZ-000000004mZ-1BR3 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 11:49:06 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so11507525e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 03:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794311339; x=1794916139; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/jv8ubm13zZFu8HlrnN31OHTok1Del26M1Afb++KgRk=;
 b=agwZBy3rFlEfAan6G4cKtkRMopJL1QLPgN84k3ThcHsxOn6lkJOgrc8GgtsUWtN55G
 rxvTOzCoH+XNOYiQkq/jpBEQJesGAVXoTJmqYR2rH39upYFWryd+S26U+JemC+VybBmu
 9Dglq65HKSfMle/58Ut6iRewTreljuPB5O0kEnq16pjcroIhE5flxOi/zvcaY7fYQMoM
 rG05mSuE9cOzI/INyCa23nE1e9uEHvf9IbXPQ22IZbqAqjbnrIoyM0s87yax9bjwFL9h
 bnAO2zU+gQBKS52HJ5eQw1zGrT/V7/9Nb1DLjJOfx/ylnxIxVxUsOTV19tctni93/jX4
 6D8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794311339; x=1794916139;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/jv8ubm13zZFu8HlrnN31OHTok1Del26M1Afb++KgRk=;
 b=cw6RSKTiKYzB7R7FYTMl/FyGTIsulf7tj6kcF9t/1qWQ+BSuBRl7Sxk6JFapo9M1Ie
 /Knq9MS8ZbgSqnQiJ6Fi2/u5tI/0Dku3qekW9TbOWXupmWLUbvCdes1WaWdswX87hfJS
 A+96CS9BBjIpO3Mw+95GtIppKve/+pp+Y3Dgidp39m5UCtUMOSRFGhZZeKXQE2g5moBq
 MktOIHrEf3Yqp2C8zqMjXq7XF6OAEDJ+0Lsn1SEc7r/8Y5xOZRxKVkBFZc7+4mEzWHMl
 BPQJnuLSAyBTDuxgyV86HOlyXo26DNmS5TcensV7aFnXcKMkbDL2NMNptv4Aj5msQUdC
 9ubw==
X-Forwarded-Encrypted: i=1;
 AL+hErGigoww+hADlLi3Tf4Kz4dw/1GpTe9RnrTV3teQ6cGNi+TKyYUTMXmxli+ddt7NYbXBbsxwuNaREXTzDH0V@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/0Yj1hkJYyq1ujCINYT8y7WjhmYVGxNUVPkYDBLPFrc/NYnn3i
 J7/eKMXGw1qvc4c7xuopv29vqa3bhZ9bEvAr3zOJgPef8Bk6w+RSvCTKOlwW9mKd4dY6oVlNDG0
 MXYwjr8Wif0PO4mphUkJS4Q5cZ4ejfkw3qQU7/7031AiOT3jCfEn8yqokTo45iwh1Y4zlUlKsYg
 lmSrwsag==
X-Gm-Gg: AYBFou3Lc7mUsbHJSYXJB199pLeJNZ9anMVS2/eEllP3NMFYQcw3sdY7mIqbZ4CTgeL
 cA5AJ3sgqleZeaL9G4EhOLUiYkzf83VSs9MHWr/hdbQSMzN6GqpyI4r90ShBNJkS/eQW0kWb3CS
 NFELUFe4a70bzTpnKQ7Xe5ssCnA46NR78/dEOjHHzWSt8hgGgt5I8M4Ebn5s0kgwUzVwVB9Jb0/
 wB2XR9hKvy2mH6paR4yqAaadBNsXnQt0pe4z2uwViAX+0sUfl8YjtInULXQtl41+DAl54w1Sr/1
 P7hKD2k8Ssu99HeOVBye0C7frp2OjZkZ2FJsOct15yCSYwnsDkmcMBI8xQLFghfeaS5Ub7nA4d5
 Rs3sbH++XIUK3KO49MteUo5DvX+0+XjbqYWk6lpuX8lv/Xzk5NukriAg/n6vWh0QcPLYZhS9erS
 3WC4PHdm2vkenpxNC2RlCoihY52iM+uXlq+Sf6Ug79yzPNqeGpttMGLiuXj5FlWIyN1xJPJ9kVM
 OGUyTgEjtuBNhi9WpEvWlixfRYbYhGpXYRnV35k9YjCm/jtTujK5Bq203ewS2zTX/hzt82q8fX0
 KngBEpv60CEXMw9fo7Esq+1/LFLxc9n5E+8xdRBs/rVu46E3zTdQsIPfuGkyY1sDDXsx7QRixRm
 jIjRNnx/FqI/FP3cMmu4F7xn8Dz1+Ff2+y6rHkEjdj9AJ7l5hrmVPLWv7KFFlFBK2BrnhA75XCw
 kih6VT2c2V0WAopTA=
X-Received: by 2002:a05:600c:4410:b0:4a1:d49e:9ce with SMTP id
 5b1f17b1804b1-4ba01d8aab0mr33134635e9.2.1794311338545; 
 Tue, 10 Nov 2026 03:48:58 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835c37bdfsm4794938f8f.22.2026.11.10.03.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 03:48:58 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 11:48:56 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5
X-Gerrit-Change-Number: 2158
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2158?usp=email>
X-Gerrit-Commit: 3f8d4f6fe041f8005cc926cd887cc0a2a6fe27c6
X-Gerrit-Comment-Date: Tue, 10 Nov 2026 11:48:56 +0000
In-Reply-To: <gerrit.1794261747000.I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5@gerrit.openvpn.net>
References: <gerrit.1794261747000.I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MjYxNzQ3MDAwLkkzYmNiNGNiOGUxN2ZmODBhNWNiOGFjZGFmMThkMTA3MjE1OTE4NGU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6d1ec62a74dc8f5b55ba581f67ad68545830afce-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQkLZ-000000004mZ-1BR3
Subject: [Openvpn-devel] [M] Change in openvpn[master]: crypto*: Avoid sign
 conversion warnings by using defines directly
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1682090150665028544=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1682090150665028544==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OyZooJZ+BTw="; charset=UTF-8

--OyZooJZ+BTw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail )

Change=
 subject: crypto*: Avoid sign conversion warnings by using defines directly=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 2: Code-Review-1

(2 comments)

Commit Message:

https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2158/comment/fbe7339f_12d826a8?usp=3Demail :
PS2, Line 1=
3: I do not think that using an intermediate variabl
Typo: "variable"=2E


=
File src/openvpn/crypto=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
58/comment/e3080b51_2cd0ffb9?usp=3Demail :
PS2, Line 539:     const uintptr=
_t ad_size =3D (uintptr_t)(BPTR(buf) - ad_start);
`uintptr_t` doesn't sound=
 like the right type to use here=2E My man page says: "integer types wide e=
nough to hold pointers", but that's not what it is used for here=2E

`size_=
t` would probably make more sense=2E



-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5
Gerrit-Chan=
ge-Number: 2158
Gerrit-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 10 Nov 2026 11:48:56 =
+0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--OyZooJZ+BTw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail=
">View Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2158/comment/fbe7339f_12d826a8?usp=3Demail">Patch Set #2=
, Line 13:</a> <code style=3D"font-family:monospace,monospace">I do not thi=
nk that using an intermediate variabl</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Typo: &quot;variable&quo=
t;=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/op=
envpn/crypto=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158/comment/e3080b51_2cd0=
ffb9?usp=3Demail">Patch Set #2, Line 539:</a> <code style=3D"font-family:mo=
nospace,monospace">    const uintptr_t ad_size =3D (uintptr_t)(BPTR(buf) - =
ad_start);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">`uintptr_t` doesn&#39;t sound like the right type to =
use here=2E My man page says: &quot;integer types wide enough to hold point=
ers&quot;, but that&#39;s not what it is used for here=2E</p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">`size_t` woul=
d probably make more sense=2E</p></li></ul></li></ul><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail">change =
2158</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2158 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Comment-Date: Tue, 10 Nov 2026 11:48:56 +0000 </div>
<div style=3D"displ=
ay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: Yes </div>

</body></html>
--OyZooJZ+BTw=--


--===============1682090150665028544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1682090150665028544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1682090150665028544==--

