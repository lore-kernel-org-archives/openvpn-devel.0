Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F55606A32D
	for <openvpn-devel@archiver.kernel.org>; Sat,  7 Nov 2026 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bNZ6nGnQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=j65GRA3c;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=agPBp8S7;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=c43UqSLg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=SIlIhxz8iCUXpGTpREb+/+fNIUbKevB2wMuflld5Znw=; b=bNZ6nGnQPumLbcjWaBpSrZx86q
	2zXyGiqFp4tOC4Q85f0zJ2immBAD+B8H6JmP6EY2TdeaFEjDsa0cwRbic96xeWpMi82ZvOR0iCfaz
	X/qkKUjRdO/gouRyr7bz6jvsvi4R0u7edEHoHsADoW9ukeQVnLUsiW7n5PR3X495Rc2c=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPiuu-000000000IJ-3WpF;
	Sat, 07 Nov 2026 16:05:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPius-000000000I9-2wJ2
 for openvpn-devel@lists.sourceforge.net;
 Sat, 07 Nov 2026 16:05:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vP6WrdGHSPV95lVsfpV5gZYtg8ucCFqlFa5treOLMV0=; b=j65GRA3cKV+c2Yx5n2wuwnct55
 Nu0c4OVkr4G+eTtIDqkyWzQhr2D6yxbPKQbtwetCsdTDWH2iLuJgGHSqRHWRkqtdqHJqpbbusacsy
 UvLRGjk2o4a8SsymAD88NZ0YOXertwrJE/qkumzqR1TdoTBy62L3Ix8jIKyT4CDDRT0g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vP6WrdGHSPV95lVsfpV5gZYtg8ucCFqlFa5treOLMV0=; b=agPBp8S7qJf5Gu8UZe+elYjCwQ
 pRgLUywDu44Y7E80HKjbN2QpDbalL+zzsVS6HztQQudA3098uvNbFUFVHsEJ51hrAORsZt5aB+R+G
 D7G6AHUCIYuwRxYmckHjR0OjOrLYolzCAIHQTt+QQLqA84CFRW2r89/Udtf/2EvTyKeQ=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPiuq-000000001YR-2sC4 for openvpn-devel@lists.sourceforge.net;
 Sat, 07 Nov 2026 16:05:18 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso13263545e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 07 Nov 2026 08:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794067510; x=1794672310; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vP6WrdGHSPV95lVsfpV5gZYtg8ucCFqlFa5treOLMV0=;
 b=c43UqSLgWbeLLV/yAKOfJzn15wP/FdeUNgapdjnqpJuLo8gT/Qi4BKu134CX6CgL7w
 6IgKLG/YEKcc00la/6AyX2x1372CtNe/70Snv5pAedAq67U33FdJkBrcqqzM5epu+Nzn
 vrTpQnVuFfiPn5d6n63cKyYuFc4JCRKbUo98xZjQDzkGUOMTPVa6kJv5EuyRVbaC/U05
 Yvhnuk7qsUQSm6q1Sg9VJjqmYMBhZZkGsD6dmWbO8v/xJMVO2GFbnE1OOJCHA/QAxCk7
 pXJ+vGMtROQtgMsO7oWfsz+CPQ8RzhisJ5vnwkaLKhJJft9mhFx5ZrJtgYBkzqP0XRUh
 L6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794067510; x=1794672310;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vP6WrdGHSPV95lVsfpV5gZYtg8ucCFqlFa5treOLMV0=;
 b=2wRjZTMit8ASMgZUYYUKrHy05GmpM3oVBRgjSt3N9I1GuLWKXMrLKl5/WJGcgapfR9
 mgSquAQgvJ11Cfz+hhaLN984iyAz6Ob99W9xuktp6wBXdXRwkJMpXmELdaR3MsBnzjfB
 VwgIB1y45htSJLK7/thRzTj2saChTUOOkqww39gx9BIZXTyMSMHJ+LS8Fgrdg8tyCR8e
 1XJlduCL0oD8XAU/RAlSnKPpNI41TyweIcwCADbXB+37GN1vJiVLTU4M7/LEI09+nnNx
 cNv0upwaaG7FEu/kST2hub8ox9YiR1BHOiHINhTlTpZ+8agbJwJ+yE9rKTPkp44vPbTb
 JxuA==
X-Gm-Message-State: APuU4Z9KB6TVi7sUGrgvjhOXJSRAenZv28pv6pHas6f254VaAb+PysGt
 UPMA6goO0dk5XfajEOEZFmHfq91qeRqYZhzDsQc6NAdnokF2hbckL/ieYDIGJbBsGtZosdpmu7N
 o+oG9sOvzsnrVYGkpvWE0AjQ5I7Fg1vRozn4d2S4B1yj8cIj+W5q7bFUeH7At+43jPA9gWwZ+N+
 aNU6BnSA==
X-Gm-Gg: AYBFou2e3+xCu38qsGxujMPotm/QzQqtT/fMRiuFvxMzuuTx4/fwOHAUN4JyJC7LlHC
 tYcN3NALRNeCc/g2Sy6zmNDrQ/w6KhJ626GN7yLqhcarXi25hSiVsx8l5+X9Kye1THrBrisRfQy
 EZZeZvs6j4hb7rfWY7htYi7VDpOz5X9DelGPDGnU9DjyUEsMcYt9YqPb/6Fu1/JZa4B9FEXYK4U
 MQhyNbDYaB77lbH4QcECHaFEvU1EyAMOeh9qRGZ2OkNFIfYgU6qXVvVQWp19bVUBW8jIgA5u572
 GhlTUR2nmgbdZk0UQK66fKPQLTsaZsaRSMbroZoNGawET5FLkh41Zk/n+1uwoH25BE/AkYjK2q0
 C4P5Nq2DRj4SjRb5ulGY/ozwx1sSBE9sVu2NXtMIa3kxKT7Te0YhIz06O0QKC6WdGf/43pBREhZ
 rs2UTo8fVV1RzahkX0SCh5qYoyGpNxrJcZVG6oogifCGGJ5JjyUbeEiViVXq+tBBnHxf2104+1i
 V1Z71jhGlGhdlCTt/TEu/Hn5ErLwXrfS0xk1MI8QUWI5uwogpkyqd2oEsLEgbRZauGCQuTHvLEs
 /4lfJVaCpzW+ZjIpENhNH/fgj0FECDNhLP/3wf67wV8NjEWn9bxcsGvtqc7VtSk0KDmRIP4i4+3
 3KBF3UEhbwAquNhmf3InqGyTD+j1JOrzvu5198t4WZSM1Qm5jtQvUVeuMV09oORTJrXtSapPEuy
 p7jPKsW2Wg1KnMlw==
X-Received: by 2002:a05:600c:34cc:b0:4a5:dc5d:20f7 with SMTP id
 5b1f17b1804b1-4b6df4f3d3fmr101457995e9.14.1794067509948; 
 Sat, 07 Nov 2026 08:05:09 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b76cb76697sm53262305e9.0.2026.11.07.08.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 08:05:09 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 7 Nov 2026 16:05:09 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ibc9eb15714f14a9f49366fc84072087fc3f013c9
X-Gerrit-Change-Number: 2152
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2152?usp=email>
X-Gerrit-Commit: a4735b9d6380f5a30ddd7174ae78dc86ef90e1de
References: <gerrit.1794067506000.Ibc9eb15714f14a9f49366fc84072087fc3f013c9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDY3NTA2MDAwLkliYzllYjE1NzE0ZjE0YTlmNDkzNjZmYzg0MDcyMDg3ZmMzZjAxM2M5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <74337769f8626d7363f7333234c0ce55e71805c0-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPiuq-000000001YR-2sC4
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_verify: reject
 an empty certificate fingerprint
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5781565586825322013=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5781565586825322013==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="njjmRsbs3Rw="; charset=UTF-8

--njjmRsbs3Rw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2152?usp=3Demail

to review the following change=2E
=


Change subject: ssl_verify: reject an empty certificate fingerprint
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl_verify: reje=
ct an empty certificate fingerprint

verify_cert() compares the configured =
hashes over the length of the
computed fingerprint=2E With mbedTLS built wi=
thout SHA-1 the SHA-1
fingerprint is empty, so the zero-length compare matc=
hed the first
entry and --verify-hash <hash> SHA1 accepted any CA certifica=
te at
depth 1=2E Reject an empty fingerprint instead=2E

The compare length=
 has come from the computed fingerprint since
2193d7c0 ("crypto: Enable SHA=
256 fingerprint checking in --verify-hash")=2E

Change-Id: Ibc9eb15714f14a9=
f49366fc84072087fc3f013c9
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
---
M src/openvpn/ssl_verify=2Ec
1 file changed, 7 insertions(+), 0=
 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/52/2152/1

diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/s=
sl_verify=2Ec
index 0cdec1e=2E=2Ea5b57a5 100644
--- a/src/openvpn/ssl_verif=
y=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -697,6 +697,13 @@
               =
  goto cleanup;
         }
 
+        if (BLEN(&cert_fp) =3D=3D 0)
+       =
 {
+            msg(D_TLS_ERRORS, "TLS Error: cannot compute the certificat=
e fingerprint for "
+                              "--verify-hash/--peer-fi=
ngerprint");
+            goto cleanup;
+        }
+
         const struct =
verify_hash_list *current_hash =3D opt->verify_hash;
 
         while (curr=
ent_hash)

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
52?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newcha=
nge
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibc9eb1=
5714f14a9f49366fc84072087fc3f013c9
Gerrit-Change-Number: 2152
Gerrit-PatchS=
et: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Rev=
iewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>

--njjmRsbs3Rw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2152?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">ssl_verify: reject an empty certificate fingerprint<br>=
<br>verify_cert() compares the configured hashes over the length of the<br>=
computed fingerprint=2E With mbedTLS built without SHA-1 the SHA-1<br>finge=
rprint is empty, so the zero-length compare matched the first<br>entry and =
--verify-hash &lt;hash&gt; SHA1 accepted any CA certificate at<br>depth 1=
=2E Reject an empty fingerprint instead=2E<br><br>The compare length has co=
me from the computed fingerprint since<br>2193d7c0 (&quot;crypto: Enable SH=
A256 fingerprint checking in --verify-hash&quot;)=2E<br><br>Change-Id: Ibc9=
eb15714f14a9f49366fc84072087fc3f013c9<br>Signed-off-by: Razvan Cojocaru &lt=
;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/ssl_verify=2Ec<br>1 file=
 changed, 7 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/52/2152/1</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec</spa=
n><br><span>index 0cdec1e=2E=2Ea5b57a5 100644</span><br><span>--- a/src/ope=
nvpn/ssl_verify=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify=2Ec</span>=
<br><span>@@ -697,6 +697,13 @@</span><br><span>                 goto cleanu=
p;</span><br><span>         }</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (BLEN(&amp;cert_fp) =3D=3D 0)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            msg(D_TLS_ERRORS, &quot;=
TLS Error: cannot compute the certificate fingerprint for &quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
&quot;--verify-hash/--peer-fingerprint&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            goto cleanup;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span>         const struct verify_hash_=
list *current_hash =3D opt-&gt;verify_hash;</span><br><span> </span><br><sp=
an>         while (current_hash)</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2152?usp=3Demail">change 215=
2</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2152?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
Ibc9eb15714f14a9f49366fc84072087fc3f013c9 </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 2152 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--njjmRsbs3Rw=--


--===============5781565586825322013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5781565586825322013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5781565586825322013==--

