Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5F5606A320
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=O1TIGQwi;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mqeTIdMh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JNvCrm5e;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GnHYd5MY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=47BVTKLp8E7hmEopAXzqlthAyuaXbPLA7GwDa5i/FaM=; b=O1TIGQwiihj4/IlmfB5GgL49K9
	rlslov723WmrHF54yKcpraiZdkasp4NXyZzX1G8cfwltzxMZZbA+skG5V/UpnbKvM+El6fSEzbPmu
	Y7bUeLzwDZzFoR0n27bwoRvd3tuLuYkj5P66Pu1E4SNZT5lnSY2QzRHXDYc7pbzsaerI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUJGK-0000000081H-3C0Y;
	Fri, 20 Nov 2026 07:42:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUJGF-0000000080b-2nr1
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 07:42:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oqV3p2u1P4sn5zpSgIwp+TPz61mdbyBEQeYF2AZrJR4=; b=mqeTIdMheLKyxw+/tu7oYUs5Jx
 SClRP77xHWkUzyM0/5X2n610noodPV4zfNUvAXKI1WYACksO+ZVtXNcK+bsMjmjXwWiQZBcaaUqyE
 giCZ1ECRZ4fUwA6fRROQidg4ZZrHzirQqUabKUmAoOyrCm2wsvukoMKYmMo5IQBzPNKg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oqV3p2u1P4sn5zpSgIwp+TPz61mdbyBEQeYF2AZrJR4=; b=JNvCrm5eYlT3zqx/9ARs1uZ662
 x97Dlbp+UZec9PM1e8AfU7udie+B3YwU+jqgULPiAFPLrKio4eGgZYfJaCqeJtE/n/CN/oA8tMvzV
 N2IPQ3ApOLa4sUrIif45t1GvkBmQAyU3OSO4cgu7TLBB4jipOWu0/bfJxO2tH/e9RA/Y=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUJFq-000000006oV-04mk for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 07:41:54 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-497614c95f0so333618f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 23:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795160507; x=1795765307; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oqV3p2u1P4sn5zpSgIwp+TPz61mdbyBEQeYF2AZrJR4=;
 b=GnHYd5MYm3M7VJPzTH92AZmOQjGPmTQBh25D3YmN5VjoszZ97X5rMbjWPxihG3O9FV
 jIYx8ZD9oZpz7S4MRgWjRaxBUkccEAJl1SMdCAZG+S/M0WLLIfwfobuAmeFqOYCpuuFP
 a4YoeepLKJmjLTVRAFMmCKJ1T4dKn5nc59eyL6dhdLoXTqfPLuptMF3t4UnGURmb3XPN
 EGD08Fjz/3kRmPJUg1Avhn18hu/aUlC0Guv7+0UOaCZzSL8fH49XxpOLyrh/YwiUXBJC
 pxTWjrk9iQ1UuP4V9+P+SBdnS9aRsj3pi/kwNM7vU74v0Rjb/iBKaHf3LHvXDT4hkTua
 6Bww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795160507; x=1795765307;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=oqV3p2u1P4sn5zpSgIwp+TPz61mdbyBEQeYF2AZrJR4=;
 b=rmGJSptWxrbjUMu/fmnL7E8JRq0BGrBt7gV2/8cAxP8f9LQiCrahYU0MU6VuhZQQ5c
 fElSSMvW8K8/xnSj+ESwRSuxZ5o4tVbPUBog0jRPhGAaTGsh7pqzCkls5Hxfu2rjgJAD
 E3ZyRxiv1DT2tEPFMsmfYqwfhq8fqQrq3/0TV9TZoD0JdnCLJAMEKuqcvqBt4Z5zoVw1
 TZE8GQYF7HL5FDaT6C2ldrsG2TXKYIejwdMMlLJsGXH10HnzCnWjAWq6IUn9xK0r0bTu
 hHHm/a5kNoAdyg4g8GmlrNOPR3c79H871uzFsMUSzWKt8aGlmiQGpvjp/Qa5JhGO+Pr7
 CToA==
X-Forwarded-Encrypted: i=1;
 AL+hErFH0pAPqhgoECBpuP+Iwn8ApexMaK4fbzw7WgJ9rUKbW+bRMAFrL3v3/iNRjyC3yf3Eg6vwLR8FrC8NS79X@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+zvAcZGSeTweuygSxuWWjhArilOjcXqd4tf0FDNBjJfp8H+ylr
 NEiC0A9aS4v+X7AjOjiKtfbxusda6Qj5uguwO9OAH+NQTmQ+ErVn91kb5ULrlZWxrM9FNDKIk5q
 4JDYr1fdg4bwuLKiGm20Lf5IGMV8dz1t54L2apL9Om8/yYVrQbcYDhO+JTlVgcOvVddpVV4hBMR
 SrmOXPMQ==
X-Gm-Gg: AZFdTZfeCGFp6FvXC/SSTnVdJIppjJZ86JHTue9cw2tYhs+fUhyrNCcLDDRXeJCoWyK
 NOB4r5oRA4WwNCQfhZRlriQVWRcBlGCfP/lpBbSI/XCKer4OqGwdWvuwIwxWiFjqKAlDNtSa5wP
 UuukqB8knwYK7uDkZAK1qIB6IiFaKU3mFgReiUSZ27s8d6Lid/Ng5S7dJzVlitcP2EP/9Gn/OVQ
 yzhVUeOkwbOSOXjosD+D0sf7ad1eTl2o299/LyL2V2NBFns2/nwlqqysqPJdDqxfECxj/GVmDi9
 RFwBldQ00EbRhlUtHZw5eR/yc5k2UWf0IAOCc/7qFo2yRhSR1LTYuButDLZxRt9t9kMcfl+RtZd
 B1iqacFNA+TUVFmzqjlZcaSvlEmU1fFhnifckJGtEKAShGYERKEDdAekj8c9XWKKADM6LBlro4o
 1kJwg1qRsKPnkqy4dYSpzhhbFqaQcwJvgFajMIbLfE3YD8tOgLPnbqlmMYnhVF+hjsK/yy9c9WO
 Ld6erzrsB1qfAAQw3Mi/Mk7Xln5yPhG/LlPPEpvZXf6GhW75CgdmPQKKsLGpp0eu48jozPaNDrv
 GR0S6yANqOP5wRbwH176p0l11GwPxS3+TWdN+46+Xleq9SqQRsmEbZUxha/xrZMYRyCKVsrfHEO
 qoLaKubvlqyd4c5n4Gz2laDz80hqCf4n4yVfk8nV/KQKVIGuPkx/+gEa3BlocJtyIBQ9SepdGEt
 ScYBM8b694Ox5tmYTu5tbfzaaGW/RyZf2N0f6mPA==
X-Received: by 2002:a05:6000:2602:b0:48a:f404:695e with SMTP id
 ffacd0b85a97d-4abb5518f07mr3937411f8f.50.1795160507137; 
 Thu, 19 Nov 2026 23:41:47 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab9cf005f2sm2707319f8f.45.2026.11.19.23.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 23:41:46 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 07:41:45 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I14ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8
X-Gerrit-Change-Number: 2188
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2188?usp=email>
X-Gerrit-Commit: a1bb251ca077225e246bd77bff2cd92112043438
X-Gerrit-Comment-Date: Fri, 20 Nov 2026 07:41:45 +0000
In-Reply-To: <gerrit.1794825232000.I14ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8@gerrit.openvpn.net>
References: <gerrit.1794825232000.I14ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODI1MjMyMDAwLkkxNGFkNGU0NTExYmQ5OTMzYjg5ZjQ4YWU1YTNhYzZkMmE1ZTBmMmQ4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e54ecec7d47253c1e1f2471f6998717d8b7802f9-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUJFq-000000006oV-04mk
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv: check
 for a leading non-option in the startup data
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
 openvpn-devel@lists.sourceforge.net
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2035891868348606979=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2035891868348606979==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PJ3kQ0nAhoM="; charset=UTF-8

--PJ3kQ0nAhoM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Lev Stipakov has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2188?usp=3Demail )

Change=
 subject: openvpnserv: check for a leading non-option in the startup data
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:=
 Code-Review+1

(1 comment)

Patchset:

PS2: 
LGTM

A nit - the patch remov=
es test_starts_with_non_option (8 assertions) without a replacement, and a =
new check is inlined in a function which cannot be unit-tested=2E

Maybe ke=
ep a small helper taking the options string, like

      static BOOL
      =
StartsWithNonOption(const WCHAR *options)
      {
          return !IsOptio=
n(options + wcsspn(options, L" \t"));
      }


call it from the new locati=
on and point existing tests at it?



-- 
To view, visit https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2188?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: I14ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8
Gerrit-Change-N=
umber: 2188
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@=
mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
G=
errit-Reviewer: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan =
Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 20 Nov 2026 07:41:45 +0000
Gerr=
it-HasComments: Yes
Gerrit-Has-Labels: Yes

--PJ3kQ0nAhoM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Lev Sti=
pakov has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 2:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +1</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2188?usp=3Demail">=
View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2188?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">LGTM<=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">A nit - the patch removes test_starts_with_non_option (8 assertions) wi=
thout a replacement, and a new check is inlined in a function which cannot =
be unit-tested=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Maybe keep a small helper taking the options string, =
like</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">      static BOOL<br>      StartsWithNonOption(const =
WCHAR *options)<br>      {<br>          return !IsOption(options + wcsspn(o=
ptions, L&quot; \t&quot;));<br>      }</pre><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;"><br>call it from the new locat=
ion and point existing tests at it?</p></li></ul></li></ul><p>To view, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2188?usp=3Demail">c=
hange 2188</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2188=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I14ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2188 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Lev Stipakov &lt;lstipakov@g=
mail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
omment-Date: Fri, 20 Nov 2026 07:41:45 +0000 </div>
<div style=3D"display:n=
one"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Ha=
s-Labels: Yes </div>

</body></html>
--PJ3kQ0nAhoM=--


--===============2035891868348606979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2035891868348606979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2035891868348606979==--

