Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290D6CA9ED5
	for <openvpn-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=1SM34ScQ/BVZOShpdnyyxQsq/xmmORNmg4MlLmLbFEo=; b=ErorW5qZ1jgkLy
	dUncKw+5sT8AOLtNz4ASg2AekJIRBmXtafmQO5kwT1qYj+9O9eKSrlXvS1VfDhw/vLGP358k4ZhFP
	EuSEyrUhwEaHtKMiiPPwUOgcUbka9jo4ZTM9F0qZQ+S9XL7tjzM4hlLDXVktSgm/QzE0u5bb1e3OC
	McY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGAZO-0002Y6-5F;
	Mon, 12 Oct 2026 07:35:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGAZM-0002Xy-1Y
 for openvpn-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 07:35:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XTm0pGKQXK5TLu40PtP0DvoTQY20E7cWJ/DF8MQGxh8=; b=BqUs8wqgQFvsC5kQofHTuddAx6
 OhVUmlyOhkrK4Vsv4N3LeYDbEk1ekxHd4H6iTGvy5I+R2ZwFUu8GQycV77XvqALPSi9OACDLuAW36
 zDn8NnNpUg+aeFrK0ZU6Bv7nQmip8ZnHovv1dsGJBiYmdqlw0hQZZ7oCblmIxpNZP4Tk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XTm0pGKQXK5TLu40PtP0DvoTQY20E7cWJ/DF8MQGxh8=; b=B
 IfOFu/T7/5xTjh+qPn8tYcTRYkrYPArApmqceKYZJp84rDuNCcudnL6JyBE0ZXfleps2JEeNGFCAb
 3xotz/jvpFBBxx+MOjsTfVtrDYvDE75dJO1EK4d/U+uESRPmjZrYjNq0bkhGbcHa3krnVUSl13Dip
 r1VYxJga/Lgh55Cw=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGAZL-0007It-9u for openvpn-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 07:35:36 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48afcd7ba9bso850477f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 12 Oct 2026 00:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791790529; x=1792395329; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XTm0pGKQXK5TLu40PtP0DvoTQY20E7cWJ/DF8MQGxh8=;
 b=BjcZ/swSTYpYT7CtG07Zz60rsux2sMO1R1kOORCK78WYtlHO/sft1Cpd6MCMjrrvlZ
 oadhYYlOF3994faroOz/SbuGeJc0OFDeBy7561HYrEZwGvQtMgZ4GLkaVi8AhHItJuQq
 R8N/8lWJlaAqa6qR4IDyuzxCbL+NI8GiTtRwei57vuDfjfq/qvi9UgTgx3U4eV20jcez
 Ym19eY5kFgyz2xgGy2BbsIG8MoeMFxx+DPEDjUO++k/UEeBWgxfqv/alKjDdg8wFA5hI
 QZHMylb6nR3/yLyJIGU2vL/jwRF6tqPzo6cyz1Kbc0wdKXHZdBAs6OYTR8VdliZaVgZJ
 EhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791790529; x=1792395329;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XTm0pGKQXK5TLu40PtP0DvoTQY20E7cWJ/DF8MQGxh8=;
 b=PIfkqFBeDD6johMoIXjudiFbZY2Tmg0CuWq2NlZuSUrpf6AaOO5XFfsvHBLZV/LIof
 WJKHjlMpAe6N8N79+epw3YrHOAxqamhtasHAGDY4bgJkc1zkSjmTHw92zWAa7guCerYO
 uSxNgTXRHzoDawA1+vE8K5kcWx0cpMdh67fOvm7bIBj1TjI+NBFbxTpaNpiAcu6ZJTcp
 pxF8tBCyvAULJnLjxTWcOHieqAXf8+vZUE9VD0t21YlT181bKsQx0/MwmK/GDJtlhyPJ
 y3qlImrgjntLP0AsHv7w11b6ETkJWoy2F6Tn3LG3XwHKnsPBx72bH1Zc4YNFDICOtHKH
 l6+g==
X-Gm-Message-State: AFq9FYKuHsSCWmPWxRbTBMwJIzE1IrZLFJKnAuLOkmMRRIsTFKpriZqU
 lePc8FuE4XZRLcStxGNiQjgktnXJ5dt+Ie6ROw+RmJtoDIpbIrZboFk6jRUAUUaK4r65rrokX6c
 VvT08N7Wd2+buX9plooWfdQ7aUGhwtpdb/y8vXeB0/VB1DbOWA8R6ouR4yt0i0d2aWa2LCJkLJT
 OZ+LTxNw==
X-Gm-Gg: AYBFou0OzBtJUQAeIPdCBkcM7o44tnGzEY+iRZHp7AEjGdeKc764Ugf7P3MlctJgBIT
 vsP7Og9sJGpeK6ETdMEwaRWpHv0Y14RBJlb+RfSIxRBYwNmhmagauygANirN4sLkmcLgQIvua4v
 wiVQm31STpf0vamD/vYjKh44jbArJVBRu9lTSrPbGPbsy/aCbiu6npIAsMp1SZ5rUUFO2GAo73i
 SC3YQe3DdlksfgaZKEXVAYQb7dOLGiNHFurGRv3GsIF6T9EMRlvkTP7ZNmpdKbTfk9NYF94CcM9
 xFvB/0SM0xy+/XRgMsa5r7/RGd5f9i2RSBqWR7v35JlmuazfwHsPvt7d+6UAOoKmnPOWf5nKq7U
 3zxNmW/dRBDLjz/z3hJPxknB8I3qOIVYvjkcFBcJ3KuQe/lBpqAfvfNidYkuVbjuiQiBySYbjXB
 GO6um30T/XnXGC2NaNDd/WwrV5MVDPW8lLcVFpsnrF9rdc+G5IXEAz0rULQuUQdEu9gUwRNho33
 Mr66iHk7y5+N/dCLrYB2SkG0mgq8S6gxcMxVBwAPFC7VQ2ZGvLlkHt29/Zs0RodojhCZdyZORRV
 r10gqcYEptNvgsPN9x4dsiGMPbaG70jV0WCu4wzI62xaaniu0fYZOoRTJMam
X-Received: by 2002:a05:600c:1911:b0:49f:faa3:3ca2 with SMTP id
 5b1f17b1804b1-4a18e4aae7emr176932235e9.13.1791790528406; 
 Mon, 12 Oct 2026 00:35:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be8c5e7sm338509765e9.4.2026.10.12.00.35.28
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 00:35:28 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 12 Oct 2026 07:35:27 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib74788b0365f6b44383ce09cf7d4914bbe500f8a
X-Gerrit-Change-Number: 1990
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1990?usp=email>
X-Gerrit-Commit: 2af9751442c600a902b3968f3a72ab5a5e4d2236
References: <gerrit.1791790522000.Ib74788b0365f6b44383ce09cf7d4914bbe500f8a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxNzkwNTIyMDAwLkliNzQ3ODhiMDM2NWY2YjQ0MzgzY2UwOWNmN2Q0OTE0YmJlNTAwZjhhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a365d0085d711638aa8c5608f508be887ef92170-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGAZL-0007It-9u
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Make CRL reload EOF
 detection independent of stale error queue entries
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3074459672130359096=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3074459672130359096==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tl3ZuqT8fJ4="; charset=UTF-8

--tl3ZuqT8fJ4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has uploaded this change for review=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1990?usp=3Demail )


Change subject: Make CRL reload =
EOF detection independent of stale error queue entries
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Make CRL reload EOF detection i=
ndependent of stale error queue entries

backend_tls_ctx_reload_crl() treat=
s a NULL from PEM_read_bio_X509_CRL()
as EOF when ERR_peek_error() shows PE=
M_R_NO_START_LINE=2E ERR_peek_error()
returns the OLDEST queued error, so a=
ny entry left behind earlier in the
thread turns a clean EOF into a "CRL: c=
annot read CRL from file" warning,
prints the unrelated errors as if they c=
ame from the CRL file, and still
installs the CRLs already parsed=2E The pr=
evious commit removes the
leftover that triggered this in practice; this on=
e stops the loop from
depending on the queue being clean at all=2E

If the =
queue is not empty when the CRL is loaded, say so at D_LOW with
the queued =
errors, since that is a bug somewhere else worth seeing, then
start the loo=
p from an empty queue so only errors raised by
PEM_read_bio_X509_CRL() are =
visible=2E Test the error it raised last
rather than the oldest one, and cl=
ear the queue on the EOF path instead
of popping a single entry=2E

Change-=
Id: Ib74788b0365f6b44383ce09cf7d4914bbe500f8a
Signed-off-by: Drew Blokzyl <=
drew@linuxkids=2Ecom>
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
=
M src/openvpn/ssl_openssl=2Ec
1 file changed, 17 insertions(+), 2 deletions=
(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/9=
0/1990/1

diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openss=
l=2Ec
index b88e1d9=2E=2E96e90f82 100644
--- a/src/openvpn/ssl_openssl=2Ec
=
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -1360,6 +1360,19 @@
     }
 
     int =
num_crls_loaded =3D 0;
+    /*
+     * The EOF test below must only see err=
ors raised by
+     * PEM_read_bio_X509_CRL()=2E Anything already queued wa=
s left by an
+     * earlier operation in this thread and would otherwise b=
e what
+     * ERR_peek_error() returns, turning a clean EOF into "cannot r=
ead CRL"=2E
+     * Report it, since that is a bug elsewhere, then start fr=
om an empty
+     * queue (crypto_msg() drains the queue while printing it)=
=2E
+     */
+    if (ERR_peek_error() !=3D 0)
+    {
+        crypto_msg(D=
_LOW, "CRL: OpenSSL error queue not empty on CRL load");
+    }
+    ERR_cl=
ear_error();
     while (true)
     {
         X509_CRL *crl =3D PEM_read_b=
io_X509_CRL(in, NULL, NULL, NULL);
@@ -1367,13 +1380,15 @@
         {
     =
        /*
              * PEM_R_NO_START_LINE can be considered equivalent=
 to EOF=2E
+             * ERR_peek_last_error() is the error PEM_read_bio_=
X509_CRL()
+             * raised last; ERR_peek_error() would be the oldes=
t queued one=2E
              */
-            bool eof =3D ERR_GET_REASON(E=
RR_peek_error()) =3D=3D PEM_R_NO_START_LINE;
+            bool eof =3D ERR_=
GET_REASON(ERR_peek_last_error()) =3D=3D PEM_R_NO_START_LINE;
             =
/* but warn if no CRLs have been loaded */
             if (num_crls_loaded=
 > 0 && eof)
             {
                 /* remove that error from erro=
r stack */
-                (void)ERR_get_error();
+                ERR_cle=
ar_error();
                 break;
             }
 

-- 
To view, visit ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1990?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: Ib74788b0365f6b44383ce09cf7d4914bbe500f=
8a
Gerrit-Change-Number: 1990
Gerrit-PatchSet: 1
Gerrit-Owner: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--tl3ZuqT8fJ4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe has =
uploaded this change for <strong>review</strong>=2E</p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1990?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Make CRL reload EOF detection independent of stale error queue=
 entries<br><br>backend_tls_ctx_reload_crl() treats a NULL from PEM_read_bi=
o_X509_CRL()<br>as EOF when ERR_peek_error() shows PEM_R_NO_START_LINE=2E E=
RR_peek_error()<br>returns the OLDEST queued error, so any entry left behin=
d earlier in the<br>thread turns a clean EOF into a &quot;CRL: cannot read =
CRL from file&quot; warning,<br>prints the unrelated errors as if they came=
 from the CRL file, and still<br>installs the CRLs already parsed=2E The pr=
evious commit removes the<br>leftover that triggered this in practice; this=
 one stops the loop from<br>depending on the queue being clean at all=2E<br=
><br>If the queue is not empty when the CRL is loaded, say so at D_LOW with=
<br>the queued errors, since that is a bug somewhere else worth seeing, the=
n<br>start the loop from an empty queue so only errors raised by<br>PEM_rea=
d_bio_X509_CRL() are visible=2E Test the error it raised last<br>rather tha=
n the oldest one, and clear the queue on the EOF path instead<br>of popping=
 a single entry=2E<br><br>Change-Id: Ib74788b0365f6b44383ce09cf7d4914bbe500=
f8a<br>Signed-off-by: Drew Blokzyl &lt;drew@linuxkids=2Ecom&gt;<br>Signed-o=
ff-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/ssl_=
openssl=2Ec<br>1 file changed, 17 insertions(+), 2 deletions(-)<br><br></pr=
e><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/90/1990/1</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_openssl=2Ec b/src/open=
vpn/ssl_openssl=2Ec</span><br><span>index b88e1d9=2E=2E96e90f82 100644</spa=
n><br><span>--- a/src/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/src/ope=
nvpn/ssl_openssl=2Ec</span><br><span>@@ -1360,6 +1360,19 @@</span><br><span=
>     }</span><br><span> </span><br><span>     int num_crls_loaded =3D 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * The EOF test below must onl=
y see errors raised by</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * PEM_read_bio_X509_CRL()=2E Anything already queued was left by an=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * earlier oper=
ation in this thread and would otherwise be what</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * ERR_peek_error() returns, turning a cle=
an EOF into &quot;cannot read CRL&quot;=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * Report it, since that is a bug elsewhere, the=
n start from an empty</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * queue (crypto_msg() drains the queue while printing it)=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (ERR_peek_error() !=3D 0)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        crypto_msg(D_LOW, &quot;CRL: Ope=
nSSL error queue not empty on CRL load&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    ERR_clear_error();</span><br><span>     while (true)</span=
><br><span>     {</span><br><span>         X509_CRL *crl =3D PEM_read_bio_X=
509_CRL(in, NULL, NULL, NULL);</span><br><span>@@ -1367,13 +1380,15 @@</spa=
n><br><span>         {</span><br><span>             /*</span><br><span>    =
          * PEM_R_NO_START_LINE can be considered equivalent to EOF=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+             * ERR_peek_=
last_error() is the error PEM_read_bio_X509_CRL()</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+             * raised last; ERR_peek_error() =
would be the oldest queued one=2E</span><br><span>              */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            bool eof =3D ERR_G=
ET_REASON(ERR_peek_error()) =3D=3D PEM_R_NO_START_LINE;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            bool eof =3D ERR_GET_REASON=
(ERR_peek_last_error()) =3D=3D PEM_R_NO_START_LINE;</span><br><span>       =
      /* but warn if no CRLs have been loaded */</span><br><span>          =
   if (num_crls_loaded &gt; 0 &amp;&amp; eof)</span><br><span>             =
{</span><br><span>                 /* remove that error from error stack */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                (void=
)ERR_get_error();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              ERR_clear_error();</span><br><span>                 break;</s=
pan><br><span>             }</span><br></pre><p>To view, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1990?usp=3Demail">change 1990</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1990?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib74=
788b0365f6b44383ce09cf7d4914bbe500f8a </div>
<div style=3D"display:none"> G=
errit-Change-Number: 1990 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</bo=
dy></html>
--tl3ZuqT8fJ4=--


--===============3074459672130359096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3074459672130359096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3074459672130359096==--

