Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018D2606A326
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=b3DesYQn;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NIipUEFZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cOkpb1X1;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Jdctem6n
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=A5N7ZvdDwemb+H5P5a/zmcgq8Sz1UTJAegeyZLHbXcE=; b=b3DesYQnmTNajIeyiOwp/FqM29
	sngjQimMb21saBJ8YTOeUKRXHyuYoZ9UJCoN/ZccKHRXbccRl63R3K0xqN5CV1QMOoMG3lEzOaRq+
	2j63vifI7KW0lZ18kIYzCNZDRlCm/xkW/6aWhpRrvINrUUd0llZKLkFk7HLSQ4KTPzYA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWxWs-000000000vV-2YP8;
	Fri, 27 Nov 2026 15:06:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWxWr-000000000vO-2reZ
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 15:06:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=egcl5PWlTjGaMMjokNVK/0lO+5SLrfgb3xqa+v5N7Cc=; b=NIipUEFZ9N4Y/Y3XycPLgxnFDs
 QXZ6QgOaYoy+PNrKt09vebl+1ZUBA/TWdJr2M5da3SDSuEp4IoMsvppLVZ1IDtrl+kYSKyNeK8tMi
 CaqXH8LjRc4APoEZirIfPGiCuhRm/dCbmm9ykGJ8xsink7PotBCONX5pkSfQ3XZQG1cg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=egcl5PWlTjGaMMjokNVK/0lO+5SLrfgb3xqa+v5N7Cc=; b=cOkpb1X1Xx2zphCiL6D41RCpHJ
 Vu5ehM/oGs2S6KqVEgfVh5LnuywSQBTdvPHByjAX/GjKtb7j/VdnzJxRmMLAn+8pkTxreYyorJrg0
 vSvqCq1ieLPuzSsapnfXn1zWagun7vlOzbPXOXvMf/f9FE2MKbvshmorTjAVt5bWIdGU=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWxWq-000000006sA-12cJ for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 15:06:25 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so5387636f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 07:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795791978; x=1796396778; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=egcl5PWlTjGaMMjokNVK/0lO+5SLrfgb3xqa+v5N7Cc=;
 b=Jdctem6nCol1yBy930Oym3ylA/oQNtqi3CeLrwL/F89VwWNgNTRIbPimMzUbDm+yRk
 L8+Kpy1O/eWHfN5Mx2Seb68OT+g1FBDvDoAizxNQ7+KODxeD3stUsfOQGlf5LWXCh+Ly
 JUdnd8tyvPVdAmfN+CpQaA+TZVuB+K7Ie57sD2XACPOnZ2NkmCLqvH3WL5S26EOmof47
 +RSarA+y5yPOwjlR1JvDUWwHmukBRLlgwB0Ci3PlgkkSjhItosBWq/JsWyJzDt74Uvzh
 ZG8ZCqQf2rKBuQ0Qq9rVWHMoeQU+M9Zu97HBAfTEoz23UOJ0rd0j9O2FaYVYZWq+TM9T
 Hylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795791978; x=1796396778;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=egcl5PWlTjGaMMjokNVK/0lO+5SLrfgb3xqa+v5N7Cc=;
 b=LeIN/NBXBvUKw/eUFfPBdlU1M6Mxho1MyulazqrUrxYKRNLXFwgGhe2v3Msl6GbpTS
 Kp7iRgQTufFmiaXu6xMTbfuyrk/0PNRUKCnk4XrFqBWl13QpN7DiBgnvuZraqyoRgf1A
 cYO3zT75P98lO6yln6DZY8YgEJqV5rzSRFQWWyCxicj6QuTLmTjVqGdgiP4FrW9bemFn
 LciVtq93grG0WAgNxxdTwe5poigd2x3M/AGm30KamDBX+NO49wh2N/JQwMcXhdpF9DYN
 U8id/29PAnyxlOt39J9A6N/t7i4CoGNeM2TU24abCOgoZ8qk1GIRCh0HxR+SdiBuycDq
 N2iQ==
X-Gm-Message-State: APuU4Z/Xkq2TP1Z5oIKiCZHoSWf4pbS9AAd8M3p1xez67RLQSVXelebj
 7cdqONbTTrF7OQWhbGLh5s8xAEOvZdgIF5bM4lpJSyfE7zVFBmgXrIxRNJWZIUocnUPn16X4caA
 uS3f01tP0NxvXiFEufCGnsU6chBTfnDVmqRhWf1xboP2dAGL4YdyblO0iRqSDaudWU5g8
X-Gm-Gg: AZFdTZdBAximjyMPD8pqMRT/neDXUICIJfb3qqpgOuVWY+z2wuq6VFL4SKf2yacbo6g
 v/XGh4kgzyht3aug9qWHxKJeBia0r3/pa7u4rJGEqw2DKUWcAYTuQenbeulCa3pyCnewOnnVjXX
 nDGbfUkQ06za7VKUy7wkNGVvvqtl/rqktpYYbUFo0AsDr5uNNhI3kHjuADxBIhEF1bY+p1A3sWh
 5APYRNLOQ4fLwglfx9ksPpH7dKBDG47m5aEA07XSVFl/8Sh1eivX29Qww+fp4yEghXu1kGUeuWd
 cOOx/D7qxM/nET+VxieSQYLEti1UJMKnhWCUJKVemNHEqM9eQULulAsLnWtG9ekZnlw1O/F6U+q
 FobwQZwuVCu2w1c602RA0XEqpiNQ+5uuLvqfe3+H4Bd4i59eh/uaYG7D8RBPKL2MD/Nw6b128oB
 usAhIRV0NaiOIw2hUb715f+r5d3EVsvMTkdRMCMbiMLV3bwVnoTwzm2Pr3PUH+m4pcWz3iOHBU4
 gqrjHPRkDdgfM2Kc947458SxLqzPuPMk0qSQHm4InSYz70i1H/73zljhlX0tZ7sHtBs9fefzmHT
 /dKA4z6zbLc1z1rLewXMQYoOF5DA1U92IlW3Xs+Jj8h8gmV3c3hrecaTRqxmuq9Vxd26MFqiIU+
 3VYPDlNn7vbHnzVTvO+l3mxWznizqrS9ELJzuTXhqoNigqwtpuuRwVxgzEto2VD+CTtrCzj68fU
 67Y9r7CAlQXNxQAsA=
X-Received: by 2002:a05:6000:4b15:b0:48d:df08:307c with SMTP id
 ffacd0b85a97d-4abb8ac0d92mr42882069f8f.44.1795791977382; 
 Fri, 27 Nov 2026 07:06:17 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6baa3c4dsm40137364f8f.46.2026.11.27.07.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 07:06:16 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 15:06:15 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8a1b576401313f826a188dc40f226726f378066b
X-Gerrit-Change-Number: 2363
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2363?usp=email>
X-Gerrit-Commit: f04d6e6e58496e544fb7af8b7fe836277ceeb2c6
In-Reply-To: <gerrit.1795791294000.I8a1b576401313f826a188dc40f226726f378066b@gerrit.openvpn.net>
References: <gerrit.1795791294000.I8a1b576401313f826a188dc40f226726f378066b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NzkxMjk0MDAwLkk4YTFiNTc2NDAxMzEzZjgyNmExODhkYzQwZjIyNjcyNmYzNzgwNjZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7db795f9f5512a5e91f9e39e3106f7a7a14aee64-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWxWq-000000006sA-12cJ
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: xkey_provider: free
 the signing context when sign init fails
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3366250226850440973=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3366250226850440973==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LRh64/npUZ8="; charset=UTF-8

--LRh64/npUZ8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Hello Arne Schwabe, 

I'd like you to reexamine a change=2E Please visit
=

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2363?usp=3Demail

to look a=
t the new patch set (#2)=2E


Change subject: xkey_provider: free the signi=
ng context when sign init fails
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

xkey_provider: free the signing context when sign init =
fails

xkey_native_sign() returned without EVP_PKEY_CTX_free() when
EVP_PKE=
Y_sign_init_ex() failed=2E

Also drop the unused initialisation of ret=2E

=
Change-Id: I8a1b576401313f826a188dc40f226726f378066b
Signed-off-by: Razvan =
Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/xkey_provider=2Ec
1 file=
 changed, 2 insertions(+), 2 deletions(-)


  git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/63/2363/2

diff --git a/src/openvpn/xke=
y_provider=2Ec b/src/openvpn/xkey_provider=2Ec
index 9211c11=2E=2E5693418 1=
00644
--- a/src/openvpn/xkey_provider=2Ec
+++ b/src/openvpn/xkey_provider=
=2Ec
@@ -1094,7 +1094,6 @@
     ASSERT(key);
 
     EVP_PKEY *pkey =3D key-=
>handle;
-    int ret =3D 0;
 
     ASSERT(sig);
 
@@ -1140,11 +1139,12 @@
=
     if (EVP_PKEY_sign_init_ex(ectx, NULL) !=3D 1)
     {
         msg(M_WA=
RN, "WARN: xkey test_sign: call to EVP_PKEY_sign_init failed");
+        EV=
P_PKEY_CTX_free(ectx);
         return 0;
     }
     EVP_PKEY_CTX_set_para=
ms(ectx, params);
 
-    ret =3D EVP_PKEY_sign(ectx, sig, siglen, tbs, tbsl=
en);
+    int ret =3D EVP_PKEY_sign(ectx, sig, siglen, tbs, tbslen);
     E=
VP_PKEY_CTX_free(ectx);
 
     return ret;

-- 
To view, visit https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2363?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I8a1b576401313f826a188dc40f226726f378066b
Gerri=
t-Change-Number: 2363
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-CC: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>

--LRh64/npUZ8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>R=C4=83=
zvan Cojocaru <strong>uploaded patch set #2</strong> to this change=2E</p><=
p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2363?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">xkey_provider: free the signing context whe=
n sign init fails<br><br>xkey_native_sign() returned without EVP_PKEY_CTX_f=
ree() when<br>EVP_PKEY_sign_init_ex() failed=2E<br><br>Also drop the unused=
 initialisation of ret=2E<br><br>Change-Id: I8a1b576401313f826a188dc40f2267=
26f378066b<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<=
br>---<br>M src/openvpn/xkey_provider=2Ec<br>1 file changed, 2 insertions(+=
), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/63/2363/2</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/xkey_provider=2Ec b/src/openvpn/xkey_provider=2Ec</span><br><span>index =
9211c11=2E=2E5693418 100644</span><br><span>--- a/src/openvpn/xkey_provider=
=2Ec</span><br><span>+++ b/src/openvpn/xkey_provider=2Ec</span><br><span>@@=
 -1094,7 +1094,6 @@</span><br><span>     ASSERT(key);</span><br><span> </sp=
an><br><span>     EVP_PKEY *pkey =3D key-&gt;handle;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int ret =3D 0;</span><br><span> </span>=
<br><span>     ASSERT(sig);</span><br><span> </span><br><span>@@ -1140,11 +=
1139,12 @@</span><br><span>     if (EVP_PKEY_sign_init_ex(ectx, NULL) !=3D =
1)</span><br><span>     {</span><br><span>         msg(M_WARN, &quot;WARN: =
xkey test_sign: call to EVP_PKEY_sign_init failed&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        EVP_PKEY_CTX_free(ectx);</spa=
n><br><span>         return 0;</span><br><span>     }</span><br><span>     =
EVP_PKEY_CTX_set_params(ectx, params);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    ret =3D EVP_PKEY_sign(ectx, sig, sig=
len, tbs, tbslen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   int ret =3D EVP_PKEY_sign(ectx, sig, siglen, tbs, tbslen);</span><br><sp=
an>     EVP_PKEY_CTX_free(ectx);</span><br><span> </span><br><span>     ret=
urn ret;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2363?usp=3Demail">change 2363</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2363?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I8a1b576401313f826a188d=
c40f226726f378066b </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 2363 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>

</body></html>
--LRh64/npUZ8=--


--===============3366250226850440973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3366250226850440973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3366250226850440973==--

