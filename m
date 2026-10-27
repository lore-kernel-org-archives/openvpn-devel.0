Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5200606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LfSQpPTM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=e9B4iNNZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jrkonBnl;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=S8rDKBXO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=7paoe8RjuEQs0HPtNTIjNao/JLE1vH6Or+pjGF9kAt0=; b=LfSQpPTMh6y7lkaA/tzWRXaPpy
	uj/J8CthnYQOiYvfBVSg5etilq4H4yHWD35Kym5C+jmEA0e+ZXe5kwAJzPdDS+RM5xTWxOmewLBI+
	UvEPySXLNHWhA6ewcgJJpHMfm0IMe5/Ht81hurEBQhnS7CBKuzi2+MJ7dgP58C5oVs2A=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLdlv-000000001mr-1B0n;
	Tue, 27 Oct 2026 09:47:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLdlu-000000001mi-00LG
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 09:47:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9/1pIAiakdwkhqxhU8s6abH7cfqtcl5qYg9dM0T0Yz0=; b=e9B4iNNZGU9U/8Fk1y87UYqBDZ
 2UHjn86BHSDCuFNDHhGsxkLu2UmzJYrFaImpbn5Mb4kBwmR1sfCWyzpPMLmVVrqI+yIP2H52exyNz
 qjMq+z0gm5uRXVMasfZoTOQvEz8zOj7QBmd+X3IuBmkrI3p4M9wAUsY7a8f7Eb6iNXd0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9/1pIAiakdwkhqxhU8s6abH7cfqtcl5qYg9dM0T0Yz0=; b=jrkonBnlKMacrNlB943jH26rm2
 h8KVZGIL+29OhgXSu1foLSVpBbFfgi9kUUqZZ+iJrWNN52L/8IWyg5PXcwmFc6KNCB8kxm5K3XyBK
 a9w9v1kZbksQbIjR8MPH6ZNG5ABKrpUvjUwZEbohIJcKEyCbw+pIHiSmHVB2tCB/gtVc=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLdls-000000001ES-2adq for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 09:47:09 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48b060ec084so2534312f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 02:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793094422; x=1793699222; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9/1pIAiakdwkhqxhU8s6abH7cfqtcl5qYg9dM0T0Yz0=;
 b=S8rDKBXObCsI5OJyzlszBBUcDcaw07U9IOjIVWn1Gbq7f52Bx6XUob3H9qbQEMxb0i
 CNSnOr3E+8VCgMZxy7+AGSdZrtlbQWI8VrGQanu8UlrM9zQXhff43y02m82hJ5AYffyD
 WS3cmte6XQRaQOhjP4AMsoYM9EPBliCRQyD5lBfdgDxNoT9eG2vupD9d1oB6zmBZ8f/T
 rkBQX5BBerDwhBAknrc69HqtMogcgqUMbwJ4OZh4/krBaDYtR9IocHF50cmruD87bUl8
 oINNQHUwezKDB11XdvQ5H8DY2uLrGSYt51Y40MeUkc+mYZtYxzy9kKSfQ9d4hClJHy+c
 4CKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793094422; x=1793699222;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9/1pIAiakdwkhqxhU8s6abH7cfqtcl5qYg9dM0T0Yz0=;
 b=Z2Krf/xzLx3og01LOVfNFY64/IX0Ibg+rWlEm5mI4+6FlsxGf+oSqZ5Uht7tBdRuTH
 qIwUvGuJP5ZpQNu5D21InfkqVviXdzv3KXofPT6h6icKsSGGySPtN/wasrghAXSekMpm
 l7++PoLcjdLD9qM3s8Us4DGKOWjXRmiZfUJqyB08luoU957/ILzQz7B574PxRNqXcEcQ
 npAFYZ3jeNbKNhAoCwmF/Kzr035aUlY5PqRSJoOfZ8gpvMXdNUxfDR5PypVUPyxnD7TG
 ZJo8vOF/2lDMGrNqG6oN2MWqiPt+FAw53C52sr9IC4ryHc+bUiOMvEyael4O1zuxipQb
 w5HQ==
X-Gm-Message-State: AFq9FYJ4MOxdJe4ajM/pyV9+/yQS1PZqVM8beJ/dmGK3AQvErDnVD7B/
 cwqrV/4aP60GiTZcka3ed8ZGS3zgf681p4Y8JWjn81dNaL7n9A7AHGKS97+dF/uIVyBm1yftv8T
 ikym8Uj+oZOVj3R7soDZJSwcs1MAcnwEIZ/80MKQhwAtOc2y2uIBSJxOfdES/6fuU9ovvtacsmm
 cDoGGSyQ==
X-Gm-Gg: AYBFou306+YvXXwXLXVbGSTg1Mry4dsskS5nu6Xd575wxhbz8OV/HLStfuHAHcjO9Q0
 AzftdWgl/rIHGd29G1Zmjx90jaOnfxoFM+sijFqcg2QrV9RH2phztgFyGW9SsHrVfqlvOvYdnVW
 3YYfnjlt2DeAxBcZoZP265on6IIooaZ54U4l/7L2Iu9CKZYyTBJkw33GqXC5irglMXp/qIqbOpV
 e3vDuWIvj00b8/uX2YlMpZuT96zbdOavHpN1kYc9+YF42kuarDO9A0EoZ2qAAtpM3qPOUY/d6Jd
 QxmqOfh1CzBRP2KJyu8l4srmBOEkBsrSNJDepWmVLV6/DGC3Yg7ZeJw6a4v4kMFLF4t8lDyygQR
 KFN7MO+Qe+TTRBRgkk8zxcYfZ0egcqdYYdz1jnWScRhLQJfNIszS3myaAS4FsF+GP2H2MYFupWw
 pf17Hl3ISzu2ygxw6WUJkoAXfPYLsoPVNTMLYjreo5wzRvI0/9ItwNLBqtCsDz5aS0DPID1u5JF
 r2y+TGcAZBlEEMCpE4FpnMKc0B2GOexjFWK96oqulD9IlAA/N/UUe6OiwIDYenbcm4Gd06795l7
 yDm/Ev5JfpIv6ZlZCcZtYtCG+sUChtKxaDYvv1mnyIVKlImoofODmeSJz+iZfLFYsAvZUtSuRDg
 i3MG5TVbOe9SrN7zAAN+X2nNQOpgT8JwSsbnwvv08SeXhKCHlmd/weTLsXLsdExg=
X-Received: by 2002:a05:600c:34d5:b0:4a0:2391:6540 with SMTP id
 5b1f17b1804b1-4a35aca2b53mr160055715e9.25.1793094421899; 
 Tue, 27 Oct 2026 02:47:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35b4a8bc1sm119531375e9.4.2026.10.27.02.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 02:47:01 -0700 (PDT)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 09:46:51 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1abb10515665e1d6351689d2c2dd9d4aba8bb98e
X-Gerrit-Change-Number: 2044
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2044?usp=email>
X-Gerrit-Commit: a9d5ae77fc7c73581ea13272333dc6cc7c37dfa0
References: <gerrit.1793094393000.I1abb10515665e1d6351689d2c2dd9d4aba8bb98e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkkxYWJiMTA1MTU2NjVlMWQ2MzUxNjg5ZDJjMmRkOWQ0YWJhOGJiOThlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d4d0659d53f988d4e8c69a88d14f06553bcca6c2-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLdls-000000001ES-2adq
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi_io: drop the
 read cases from multi_io_wait_lite()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4758871296819694738=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4758871296819694738==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="a37zDRRJsy4="; charset=UTF-8

--a37zDRRJsy4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2044?usp=3Demail

to review the following change=2E
=


Change subject: multi_io: drop the read cases from multi_io_wait_lite()
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi_io: dro=
p the read cases from multi_io_wait_lite()

multi_io_action() only polls be=
fore writes: reads are dispatched with
poll false, both from the event loop=
 and when chaining a tun read
after a write=2E The TA_TUN_READ and TA_SOCKE=
T_READ cases of
multi_io_wait_lite() are never reached=2E

Change-Id: I1abb=
10515665e1d6351689d2c2dd9d4aba8bb98e
Signed-off-by: Gianmarco De Gregori <g=
ianmarco@mandelbit=2Ecom>
---
M src/openvpn/multi_io=2Ec
1 file changed, 0 =
insertions(+), 12 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/44/2044/1

diff --git a/src/openvpn/multi_io=2Ec =
b/src/openvpn/multi_io=2Ec
index ac730b4=2E=2E56216d4 100644
--- a/src/open=
vpn/multi_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -235,18 +235,6 @@
 
    =
 switch (action)
     {
-        case TA_TUN_READ:
-            looking_for=
 =3D TUN_READ;
-            tun_input_pending =3D NULL;
-            io_wai=
t(c, IOW_READ_TUN);
-            break;
-
-        case TA_SOCKET_READ:
-  =
          looking_for =3D SOCKET_READ;
-            tun_input_pending =3D N=
ULL;
-            io_wait(c, IOW_READ_LINK);
-            break;
-
        =
 case TA_TUN_WRITE:
             looking_for =3D TUN_WRITE;
             tu=
n_input_pending =3D NULL;

-- 
To view, visit https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2044?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: I1abb10515665e1d6351689d2c2dd9d4aba8bb98e
Gerrit-Change-Number: 20=
44
Gerrit-PatchSet: 1
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelb=
it=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attenti=
on: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--a37zDRRJsy4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gianmarco De Gregori would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2044?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">multi_io: drop the read cases from multi_io_wait_lite()=
<br><br>multi_io_action() only polls before writes: reads are dispatched wi=
th<br>poll false, both from the event loop and when chaining a tun read<br>=
after a write=2E The TA_TUN_READ and TA_SOCKET_READ cases of<br>multi_io_wa=
it_lite() are never reached=2E<br><br>Change-Id: I1abb10515665e1d6351689d2c=
2dd9d4aba8bb98e<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@mandel=
bit=2Ecom&gt;<br>---<br>M src/openvpn/multi_io=2Ec<br>1 file changed, 0 ins=
ertions(+), 12 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/44/2044/1</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>index =
ac730b4=2E=2E56216d4 100644</span><br><span>--- a/src/openvpn/multi_io=2Ec<=
/span><br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><span>@@ -235,18 +=
235,6 @@</span><br><span> </span><br><span>     switch (action)</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ca=
se TA_TUN_READ:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      looking_for =3D TUN_READ;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            tun_input_pending =3D NULL;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            io_wait(c, IOW_READ_TUN);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        case TA_SOCKET_READ:</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            looking_for =3D SOCKET_READ;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            tun_input_pending=
 =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 io_wait(c, IOW_READ_LINK);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            break;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span>         case TA_TUN_WRITE:</span><br><span>           =
  looking_for =3D TUN_WRITE;</span><br><span>             tun_input_pending=
 =3D NULL;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2044?usp=3Demail">change 2044</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2044?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1abb10515665e1d6351=
689d2c2dd9d4aba8bb98e </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 2044 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@=
mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--a37zDRRJsy4=--


--===============4758871296819694738==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4758871296819694738==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4758871296819694738==--

