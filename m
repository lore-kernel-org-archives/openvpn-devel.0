Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECA9606A33D
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 21:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FMYGhSzg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RYDNk0DD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VRU1KHZt;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=UBY/pCUO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Ai88DzgaFWEdSxSfBfFWWm7cm0AnS9VYFOeQcVO59Y8=; b=FMYGhSzgyqF2bsGYI1JLHWvEQ7
	PV2gKL8arl8F8RnvkE/6fnHxww/QXdmrDLn9KpIUzOGe4pYGFLyKsWKuAxaEuCr0zH5COxBKsKKq/
	YC+w1H1WhcXdzi/714/+Go2y7wQ6eK9qHOqJnugVfbTBZ64FdcASLHYOiMOTeHcyf+Xc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xU9zM-000000006nf-2I24;
	Thu, 19 Nov 2026 21:48:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xU9zL-000000006nY-0aoG
 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 21:48:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sA7hqDs0T5qvSuSRbsx/NP/uKpKN0R/e3PxIVZWe01M=; b=RYDNk0DDF1eE399D7CZ/jeOiu6
 wQyjF6D0JEB6iMi5AeDFkIFLKubGymGr0xNyf53BC0dDRtY9jTbtlsC95qCNGLK93n0tPH4uRafL2
 2Ka09qz5RCkjv0oYDEg32/B48Afxfb3IKi2rZWRY/K48CQwYbTgE+eIWmkry+fi5bz/0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sA7hqDs0T5qvSuSRbsx/NP/uKpKN0R/e3PxIVZWe01M=; b=VRU1KHZtFf7LDi2XVwBqWdfkAm
 lpACREV17OW9PmKxWea2OthLfMZ5mKSn88kVL+bLe27GKHhaNa1puAjFvtirK16X0edBqmYpiTvLx
 m2LPKvBGL+6XL1ZFAbwnPm+771fUfoesqlVZxpzoOnvzxuuJWI8R21wXgwHvQdF7cUdc=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xU9zJ-000000004bE-1wn0 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 21:48:15 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so1887685e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 13:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795124887; x=1795729687; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sA7hqDs0T5qvSuSRbsx/NP/uKpKN0R/e3PxIVZWe01M=;
 b=UBY/pCUO6xIauZ7zTk5umbLGQfWF3BxJY/apQRQxIoYw3TlPoBhFYTj2R5YlG5GDOh
 +y4nGDJBUVUjviiXN54Hz7zPA20WWml6TgsMcMqSAvlkuTa0t0d75bZVK3608iV7i5r8
 ONQuqNqpf76asqFXWwyE8v4RatlwRUM2wQufrhq26wy6kFgnjlPUN+PPpAB48mrY2/cg
 mpSXRrZwX/ByW4s1Gxk8tqHZwxfD8b2T7IEaxNF7eYT6/8ZBwlfrei3TCD12NExnj382
 ZHnPDmXvFqRTkgwyzwKtj1PLFj7pTbWbmQwNjEzLfirvPkQ0s1YCAMepewt0kecU1QBY
 Q9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795124887; x=1795729687;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sA7hqDs0T5qvSuSRbsx/NP/uKpKN0R/e3PxIVZWe01M=;
 b=DO9M0tc6ua/4rNgBiBadI5nyuxGO5zyyfQ8jOHK3GK+QAnkug/j4H+bkqd/mmbaNGh
 tXn0H20xlda2Wtz8oIbm9hWK0eBBL/PTWCA6cyJYGHj6V8n8fVaEz+UuOhr7Bhdl4yei
 w2NijWtLdy3BAiZBduQ+8fknY5RaupSHJFEI8dkC7qZ+4aPeiSIeCuenBP0JWbXFdG2S
 9TY9XWMZDlVMXzHZt7/vblXUcQuYkrrvjOf6gHktLoljfqZoT3GCrwonYf9l9Ld6A+fE
 btFD9tODurMChFlHcngn7emh4kY7ihfKwVK63OhBcdUfahAvzO1gvWlZMJrTFtca4RBZ
 EmyA==
X-Forwarded-Encrypted: i=1;
 AL+hErHUgjg9j9fI0IQtVedw5wZcHpBPWkLQPZQO5V6EA+TyC+m9njs1yvgsioC3LUi7R0taQd8HKp2ZkSqSYr43@lists.sourceforge.net
X-Gm-Message-State: APuU4Z//u588kX/j3bq7q1S2dOV6cPIHQft3dgN2zkOizxe1gSQd+655
 IKDPk0ZUYaYc5JXiQguLZGMLR7XTGhgp3PgjrYmq4YAueMUHbHHxkuAOAVZeBjrjojPGIWWAZ4V
 9vl074pmqmFjcoNYkJyjdlE5pnugTEBGgq7MdS4ydD4IES5oSB7Py/ur2DNVAcLLmuAE9FTX4Rd
 +jQj1srQ==
X-Gm-Gg: AYBFou3yP2yG7J33Q1YIQaSpQl2/R2fQ/0qWAMSNSVBmQxgtRB40D6pLFB9O1ZZg58m
 Y/JLAs/cT4BC3uzNwjtiAa/qw4lZbjVaVjwYSkh/10kuffPQ49z6fp20ibaiBGTOAxS3hg8iAgK
 3caVCvTWixe1T8k0DBh1KZ8Yi4RsaEDepTUZDHLpKlLMFpZzycuKeq4j3wR+X9NHzFLl1S0BIzt
 Fbx1b1k3H21ZgTyCuuSBiO/N+6GsMOe6N1EfIFvhukv+A58N4qLFxnWxwikAjLV3QSPEni3aE2B
 2gm+XyYkc2eM3a6YU1P+uKJfPWkxxy5R4N3KdjX8I/MrbKM7hjL6KLwmfvvI/vKHGvpykot0XbC
 LB5yern12p9OJ38G/bExBltegtl8kwCVRp7OO+raRIhoR8Qkre+De6nI8Bz7XnNEDANl6Azsc9c
 euca+Irho1pQ2HAVfFIwecDFYyMnEtoc/7swA7SmWTD3HMKE8llIYRZQldvRpOSWaASy7R+yKn0
 X8fABglf449IBajbDcS0KG9PqCE6NiDZTAv4b4BlaHqVd9OTJrIhF73lP3x8wP8JnYPO0cUEn4G
 5s0rbpW/xmGm7+z93gtBl8Hyv5rxU2v5EClkj5iuX8YgZpyosZva7Gz+bOTng7vU1ZPhgJzrAOV
 sa8i5hZRUMaOe9GUKmKPb8mxc59QUE2GF/Z/ODj02DcslKvqM/WJpNCOFIBzSB8SWz8u+5gd5F4
 gKepEjGFNYCfk0uMY=
X-Received: by 2002:a05:600c:1911:b0:4a1:7c56:d4e2 with SMTP id
 5b1f17b1804b1-4bb8880cf84mr19522135e9.16.1795124886439; 
 Thu, 19 Nov 2026 13:48:06 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb895faa2csm4460795e9.1.2026.11.19.13.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 13:48:05 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 19 Nov 2026 21:48:04 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3e6043178935fdd05e6ea78c411dac5decb7ac64
X-Gerrit-Change-Number: 2153
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2153?usp=email>
X-Gerrit-Commit: 01c5fd1c3eb901f136d9ff9c6586bd9acb9615c6
X-Gerrit-Comment-Date: Thu, 19 Nov 2026 21:48:04 +0000
In-Reply-To: <gerrit.1794074511000.I3e6043178935fdd05e6ea78c411dac5decb7ac64@gerrit.openvpn.net>
References: <gerrit.1794074511000.I3e6043178935fdd05e6ea78c411dac5decb7ac64@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDc0NTExMDAwLkkzZTYwNDMxNzg5MzVmZGQwNWU2ZWE3OGM0MTFkYWM1ZGVjYjdhYzY0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <061c0786c696e57f46c940126173aab9bfa54abb-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xU9zJ-000000004bE-1wn0
Subject: [Openvpn-devel] [S] Change in openvpn[master]: networking_freebsd:
 fix route command and return value details
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5128544461047911986=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5128544461047911986==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Xe8BSGPw4Pc="; charset=UTF-8

--Xe8BSGPw4Pc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153?usp=3Demail )

Change=
 subject: networking_freebsd: fix route command and return value details
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:=
 Code-Review-1

(2 comments)

File src/openvpn/networking_freebsd=2Ec:

htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153/comment/a0f1ec09_a03c24ba?usp=
=3Demail :
PS2, Line 38:     /* without -fib, route(8) uses the FIB of the =
process */
this change from "0 means fib 0" to "0 means whatever fib the pr=
ogram runs in and there is no way to set `fib 0` if the program is not in f=
ib 0" needs to be documented somewhere - if we want it at all=2E  Maybe we =
need to just need to redefine "no fib set" to "-1" globally, and then "0" i=
s something different from "not set"=2E


https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2153/comment/39fed7af_9d35ab1c?usp=3Demail :
PS2, Line 111:     r=
eturn net_route_v4("delete", dst, prefixlen, gw, iface, table, metric);
is =
this change necessary for DragonFly?  FreeBSD manpage documents

```
     d=
el         Another name for the delete command=2E
```



-- 
To view, visit=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I3e6043178935fdd05e6ea78c411dac5decb7a=
c64
Gerrit-Change-Number: 2153
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan=
 Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 19 Nov 202=
6 21:48:04 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--Xe8BSGPw4Pc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 2:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153?usp=3Demail">=
View Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/networking_f=
reebsd=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153/comment/a0f1ec09_a03c24ba?us=
p=3Demail">Patch Set #2, Line 38:</a> <code style=3D"font-family:monospace,=
monospace">    /* without -fib, route(8) uses the FIB of the process */</co=
de></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">this change from &quot;0 means fib 0&quot; to &quot;0 means whateve=
r fib the program runs in and there is no way to set `fib 0` if the program=
 is not in fib 0&quot; needs to be documented somewhere - if we want it at =
all=2E  Maybe we need to just need to redefine &quot;no fib set&quot; to &q=
uot;-1&quot; globally, and then &quot;0&quot; is something different from &=
quot;not set&quot;=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2153/comment/39fed7af_9d35ab1c?usp=3Demail">Patch Set #2, Line=
 111:</a> <code style=3D"font-family:monospace,monospace">    return net_ro=
ute_v4(&quot;delete&quot;, dst, prefixlen, gw, iface, table, metric);</code=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">is this change necessary for DragonFly?  FreeBSD manpage documents</p=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">```<br>     del         Another name for the delete command=
=2E<br>```</pre></li></ul></li></ul><p>To view, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2153?usp=3Demail">change 2153</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3e6043178935fdd=
05e6ea78c411dac5decb7ac64 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 2153 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>=

<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 19=
 Nov 2026 21:48:04 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>=


</body></html>
--Xe8BSGPw4Pc=--


--===============5128544461047911986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5128544461047911986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5128544461047911986==--

