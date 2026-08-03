Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09285C55182
	for <openvpn-devel@archiver.kernel.org>; Mon,  3 Aug 2026 13:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=0na3Qn/O+T4c/jCckuxKrgQgdYQj1eK3ocbyMuJqjD0=; b=ekPDZFOIPi5Q3R
	hNVad4FI/SyuIi/KwMmEXqFm91tJuPHxNyFI/Vzf+f9OX26BchY3CfZ41oe+dtnKdTNJ8CZTX0ZnU
	J/CkH29lzFWWDktsWlOPg0hnEl9/CvZ/fsLjeH3HvqLd+pj3XMiIYU8mWxWgc0crugpuFhXWraDtw
	gyc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wqsJu-0001Z4-3Z;
	Mon, 03 Aug 2026 13:03:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wqsJt-0001Yx-Aw
 for openvpn-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 13:03:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wm0g4TnGLQlf0DTGf7LcdXGj/EsmPDjbdkhBZocm6Ak=; b=QAB/gK7h5k+as6xm/Jf22Ba4Mo
 vln+FzAJvD7H0L1zEbrJR1vxJifOIxHjjg3enCVfdiCXUeqbkfb4SLOOT6TzgVLurK+tMTIlWmXVM
 t5+Cj1Ht1Y+ju2//qkwJGyoLcQr7KiVVGXoZdEEVeBlNODpjmd+fvLRFUzGJotAtbWek=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wm0g4TnGLQlf0DTGf7LcdXGj/EsmPDjbdkhBZocm6Ak=; b=U
 eVuiDuAbONUlezp1oycQ+EHfDOVra/mr7MSpUG4rXHt6Z10WO+NROIooDTzKmap7osytH0V7Bwr5i
 1fzijDUGkzua7n0526pi6ruyB23TDVk/iyOCl5B3ht7K0wgtuw74tnwAW6PIx7OnwtoPWFgZHNR27
 jW9/cjw/TwY4lYzE=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wqsJp-0002ZV-3Z for openvpn-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 13:03:02 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4954df200ddso13487595e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 03 Aug 2026 06:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785762174; x=1786366974; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wm0g4TnGLQlf0DTGf7LcdXGj/EsmPDjbdkhBZocm6Ak=;
 b=QQ1SrvQqWjWNN+T+clGwwrV+B/3Wq4nB3MwSWjM7zjYIUD+AcZvZio64asN9dPw3Ig
 6EkhhW7U5ffy5lxvMvXe68+NXEiopLsqDIbzhTiTqoV9eA6+c+8XG6TDWyoZfC2gIF3Z
 Ne1FVmqTbCM75Zxb/Pp8+H+zsMo2Prbbg778orfsMElh2LVszmQMiE1RqrggtTvIHwI2
 eFZ5ghxAMdFikd/oWUa7/Q1x63fhGU8ZhsC5pNNNKhcCi5Sv+oFVKlf5adcU7b3nORIl
 hsydSU5dHg8WY9YF9IGkW/EAcr9S8TPO7xegFXlMrIJcqLDzlsQ9RIWWpBvWPc5Cg40v
 fXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785762174; x=1786366974;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wm0g4TnGLQlf0DTGf7LcdXGj/EsmPDjbdkhBZocm6Ak=;
 b=lrpI2mgA6xEE3PeoltrNbAeKw7+8nXHxpkOoDpdi9xYCsTrZQWroV6v/5e0LX2cM8L
 iWzfKWzrz2WzQBNegDjlZ9lvBKhSOz9PwGXQKqOFP+XtA8WzNGRpPfQJS6cTLAjHwGKs
 Lt2jBI1qeDFg0rGGeCi/IPmAhrkKzXaq3bt1jcRSckD7jax/KjIn20Fy4VzzHMtMTIED
 3jABMKVHWUfyIIT2wxO0/eSF486z9j5tuLaMIx+pbobzjwoa6rJfvzNIhv0yZUypZO2C
 +7AAcolRo7C+NyeguhlOWrMf30e9bZmPsLWS4XV6QqH4gp9xc2K/3loB8Rg1QTdUB9dp
 Go3Q==
X-Gm-Message-State: AOJu0Yz9Vm/UQ4mO6ksWawIEwgoQtOl/LyqqpKS1bHY2vImmcdGcul14
 4YHBdAeqM5hq95Ea8/LrnWvQyDyedDwWQX9+r6cQSPyebuiUovppXB5Wv4fdiHO2mpZmPjbGI4S
 /pCXkP3Nh4XOHH8xvshRZ5CgxoVt8BNNogw4jPQljbLDQh0aV66U+9D15IXhLWsda7XviIykr5u
 iDjiu9dg==
X-Gm-Gg: AR+sD10d8AFsrcz0thmOGfyT952QXB0x+ngRDUbgXXXse+Jq4JxNZpJj3QEX/pIE+xF
 kbJiQ24vNAJYSKoQcWEyGJJeoj74kOq6kipMYqcFXgbzFdO5YQLt2Lpjg+IcJOn5cdGZEorP/Sb
 z5dtpAGxTcULyhr0/4LQIk5tTK3EarypbO+04ufDCGETiu/wJCblRP5lEpEIqi7fVMm6acW8izD
 Dy9YG1OKiLDhB9WUZQiwi2tHxv/kGboqQULX8XLF3mMRdNnotpRDxqYUh/QgElCZDO5mhQMRz3M
 BbroeMoyEHTzcrADWDN81kKcRjaL4Ryx1K1vafwuCU7uxqwFK6+PM1ACOtiOM+Ti9P75jTV+riW
 XX0ifEamebnIHL+SC/E6p/2Lk+SGqZwY+hzRNl+3cXnxPuFmeFyhvVXesBKnrkdLuLlHKYBjyNA
 FPqBHO/O7CDQhTKLSNI44cusf12i5CPFoU+y++6XwKx4nFgIYmXFeOMad2JrHlX/grgNDvcqnUf
 oG8ZQvHdzZNPLB/31fDanggFSRaLJ8zw0IbSN2DxZYFjLbBg0v88LyJJSH/BpM5n413Rh1rEiRb
 1tRWvZrIsEvisfhrw0sT6vQg05lntCmKQl9vEM5SuuMIHJRnLvw=
X-Received: by 2002:a05:600c:4e86:b0:493:e460:1f6 with SMTP id
 5b1f17b1804b1-4980c5ec7a1mr192805515e9.0.1785762173800; 
 Mon, 03 Aug 2026 06:02:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b917efsm362821405e9.11.2026.08.03.06.02.53
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 06:02:53 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 3 Aug 2026 13:02:53 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: If458a3362e03630ce699bd122e957169601657a5
X-Gerrit-Change-Number: 1833
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1833?usp=email>
X-Gerrit-Commit: 1a3b086e44f9eae781d82779dfbcc2952c9e5207
References: <gerrit.1785762169000.If458a3362e03630ce699bd122e957169601657a5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1NzYyMTY5MDAwLklmNDU4YTMzNjJlMDM2MzBjZTY5OWJkMTIyZTk1NzE2OTYwMTY1N2E1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9558a1c1d7f8ceaa32b7308081c6852f8dd91474-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wqsJp-0002ZV-3Z
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Replace
 ASSERT(rand_bytes(...)) with prng_bytes
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8188072366925085095=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8188072366925085095==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UtVWWF5IJpo="; charset=UTF-8

--UtVWWF5IJpo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1833?usp=3Demail )


Change subject: Replace ASSERT(rand=
_bytes(=2E=2E=2E)) with prng_bytes
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

Replace ASSERT(rand_bytes(=2E=2E=2E)) with prng_byte=
s

prng_bytes is already ASSERT(rand_bytes(=2E=2E=2E)), so this change is
j=
ust a little cleanup that makes a code a little bit nicer=2E

Change-Id: If=
458a3362e03630ce699bd122e957169601657a5
Signed-off-by: Arne Schwabe <arne@r=
fc2549=2Eorg>
---
M src/openvpn/crypto=2Ec
M src/openvpn/proxy=2Ec
M tests/=
unit_tests/openvpn/test_ssl=2Ec
3 files changed, 9 insertions(+), 9 deletio=
ns(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/33/1833/1

diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
in=
dex ee43d65=2E=2E8f59838 100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/open=
vpn/crypto=2Ec
@@ -1219,7 +1219,7 @@
             ASSERT(cipher_ctx_iv_leng=
th(cipher) >=3D OPENVPN_AEAD_MIN_IV_LEN);
 
             /* Generate dummy =
implicit IV */
-            ASSERT(rand_bytes(co->key_ctx_bi=2Eencrypt=2Eim=
plicit_iv, OPENVPN_MAX_IV_LENGTH));
+            prng_bytes(co->key_ctx_bi=
=2Eencrypt=2Eimplicit_iv, OPENVPN_MAX_IV_LENGTH);
 
             memcpy(co-=
>key_ctx_bi=2Edecrypt=2Eimplicit_iv, co->key_ctx_bi=2Eencrypt=2Eimplicit_iv=
,
                    OPENVPN_MAX_IV_LENGTH);
@@ -1239,7 +1239,7 @@
       =
  ASSERT(buf_init(&src, 0));
         ASSERT(i <=3D src=2Ecapacity);
      =
   src=2Elen =3D i;
-        ASSERT(rand_bytes(BPTR(&src), BLEN(&src)));
+ =
       prng_bytes(BPTR(&src), BLEN(&src));
 
         /* copy source to inp=
ut buf */
         buf =3D work;
diff --git a/src/openvpn/proxy=2Ec b/src/o=
penvpn/proxy=2Ec
index 9f3ec93=2E=2E9acb2fa 100644
--- a/src/openvpn/proxy=
=2Ec
+++ b/src/openvpn/proxy=2Ec
@@ -734,7 +734,7 @@
                 }
 
 =
                /* generate a client nonce */
-                ASSERT(rand_=
bytes(cnonce_raw, sizeof(cnonce_raw)));
+                prng_bytes(cnonce_=
raw, sizeof(cnonce_raw));
                 cnonce =3D make_base64_string2(c=
nonce_raw, sizeof(cnonce_raw), &gc);
 
 
diff --git a/tests/unit_tests/open=
vpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec
index d473d67=2E=
=2Eb86d57c 100644
--- a/tests/unit_tests/openvpn/test_ssl=2Ec
+++ b/tests/u=
nit_tests/openvpn/test_ssl=2Ec
@@ -322,7 +322,7 @@
         ASSERT(buf_init=
(&src, 0));
         ASSERT(i <=3D src=2Ecapacity);
         src=2Elen =3D =
i;
-        ASSERT(rand_bytes(BPTR(&src), BLEN(&src)));
+        prng_bytes=
(BPTR(&src), BLEN(&src));
 
         /* copy source to input buf */
       =
  buf =3D work;
@@ -368,7 +368,7 @@
     ASSERT(buf_init(&src, 0));
     AS=
SERT(len <=3D src=2Ecapacity);
     src=2Elen =3D len;
-    ASSERT(rand_byt=
es(BPTR(&src), BLEN(&src)));
+    prng_bytes(BPTR(&src), BLEN(&src));
 
   =
  /* copy source to input buf */
     buf =3D work;
@@ -453,10 +453,10 @@
 =
    }
     else
     {
-        ASSERT(rand_bytes(key2=2Ekeys[0]=2Ecipher, =
sizeof(key2=2Ekeys[0]=2Ecipher)));
-        ASSERT(rand_bytes(key2=2Ekeys[0=
]=2Ehmac, sizeof(key2=2Ekeys[0]=2Ehmac)));
-        ASSERT(rand_bytes(key2=
=2Ekeys[1]=2Ecipher, sizeof(key2=2Ekeys[1]=2Ecipher)));
-        ASSERT(ran=
d_bytes(key2=2Ekeys[1]=2Ehmac, sizeof(key2=2Ekeys)[1]=2Ehmac));
+        pr=
ng_bytes(key2=2Ekeys[0]=2Ecipher, sizeof(key2=2Ekeys[0]=2Ecipher));
+      =
  prng_bytes(key2=2Ekeys[0]=2Ehmac, sizeof(key2=2Ekeys[0]=2Ehmac));
+      =
  prng_bytes(key2=2Ekeys[1]=2Ecipher, sizeof(key2=2Ekeys[1]=2Ecipher));
+  =
      prng_bytes(key2=2Ekeys[1]=2Ehmac, sizeof(key2=2Ekeys)[1]=2Ehmac);
   =
  }
 
     struct crypto_options co =3D { 0 };

-- 
To view, visit http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1833?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: If458a3362e03630ce699bd122e957169601657a5
Gerr=
it-Change-Number: 1833
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>

--UtVWWF5IJpo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1833?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Replace ASSERT(rand_bytes(=2E=2E=2E)) with prng_bytes<br><br>prng_=
bytes is already ASSERT(rand_bytes(=2E=2E=2E)), so this change is<br>just a=
 little cleanup that makes a code a little bit nicer=2E<br><br>Change-Id: I=
f458a3362e03630ce699bd122e957169601657a5<br>Signed-off-by: Arne Schwabe &lt=
;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/crypto=2Ec<br>M src/openvpn=
/proxy=2Ec<br>M tests/unit_tests/openvpn/test_ssl=2Ec<br>3 files changed, 9=
 insertions(+), 9 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/33/1833/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index=
 ee43d65=2E=2E8f59838 100644</span><br><span>--- a/src/openvpn/crypto=2Ec</=
span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -1219,7 +121=
9,7 @@</span><br><span>             ASSERT(cipher_ctx_iv_length(cipher) &gt=
;=3D OPENVPN_AEAD_MIN_IV_LEN);</span><br><span> </span><br><span>          =
   /* Generate dummy implicit IV */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            ASSERT(rand_bytes(co-&gt;key_ctx_bi=2Eencrypt=2Ei=
mplicit_iv, OPENVPN_MAX_IV_LENGTH));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            prng_bytes(co-&gt;key_ctx_bi=2Eencrypt=2Eimpli=
cit_iv, OPENVPN_MAX_IV_LENGTH);</span><br><span> </span><br><span>         =
    memcpy(co-&gt;key_ctx_bi=2Edecrypt=2Eimplicit_iv, co-&gt;key_ctx_bi=2Ee=
ncrypt=2Eimplicit_iv,</span><br><span>                    OPENVPN_MAX_IV_LE=
NGTH);</span><br><span>@@ -1239,7 +1239,7 @@</span><br><span>         ASSER=
T(buf_init(&amp;src, 0));</span><br><span>         ASSERT(i &lt;=3D src=2Ec=
apacity);</span><br><span>         src=2Elen =3D i;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ASSERT(rand_bytes(BPTR(&amp;src), B=
LEN(&amp;src)));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     prng_bytes(BPTR(&amp;src), BLEN(&amp;src));</span><br><span> </span><b=
r><span>         /* copy source to input buf */</span><br><span>         bu=
f =3D work;</span><br><span>diff --git a/src/openvpn/proxy=2Ec b/src/openvp=
n/proxy=2Ec</span><br><span>index 9f3ec93=2E=2E9acb2fa 100644</span><br><sp=
an>--- a/src/openvpn/proxy=2Ec</span><br><span>+++ b/src/openvpn/proxy=2Ec<=
/span><br><span>@@ -734,7 +734,7 @@</span><br><span>                 }</spa=
n><br><span> </span><br><span>                 /* generate a client nonce *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                ASSE=
RT(rand_bytes(cnonce_raw, sizeof(cnonce_raw)));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                prng_bytes(cnonce_raw, sizeof(c=
nonce_raw));</span><br><span>                 cnonce =3D make_base64_string=
2(cnonce_raw, sizeof(cnonce_raw), &amp;gc);</span><br><span> </span><br><sp=
an> </span><br><span>diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/t=
ests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>index d473d67=2E=2Eb86=
d57c 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_ssl=2Ec</sp=
an><br><span>+++ b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>@@=
 -322,7 +322,7 @@</span><br><span>         ASSERT(buf_init(&amp;src, 0));</=
span><br><span>         ASSERT(i &lt;=3D src=2Ecapacity);</span><br><span> =
        src=2Elen =3D i;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        ASSERT(rand_bytes(BPTR(&amp;src), BLEN(&amp;src)));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        prng_bytes(BPTR(&amp;src=
), BLEN(&amp;src));</span><br><span> </span><br><span>         /* copy sour=
ce to input buf */</span><br><span>         buf =3D work;</span><br><span>@=
@ -368,7 +368,7 @@</span><br><span>     ASSERT(buf_init(&amp;src, 0));</spa=
n><br><span>     ASSERT(len &lt;=3D src=2Ecapacity);</span><br><span>     s=
rc=2Elen =3D len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
ASSERT(rand_bytes(BPTR(&amp;src), BLEN(&amp;src)));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    prng_bytes(BPTR(&amp;src), BLEN(&amp;=
src));</span><br><span> </span><br><span>     /* copy source to input buf *=
/</span><br><span>     buf =3D work;</span><br><span>@@ -453,10 +453,10 @@<=
/span><br><span>     }</span><br><span>     else</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(rand_bytes=
(key2=2Ekeys[0]=2Ecipher, sizeof(key2=2Ekeys[0]=2Ecipher)));</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(rand_bytes(key2=2Ekey=
s[0]=2Ehmac, sizeof(key2=2Ekeys[0]=2Ehmac)));</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        ASSERT(rand_bytes(key2=2Ekeys[1]=2Ecipher, =
sizeof(key2=2Ekeys[1]=2Ecipher)));</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        ASSERT(rand_bytes(key2=2Ekeys[1]=2Ehmac, sizeof(key2=
=2Ekeys)[1]=2Ehmac));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        prng_bytes(key2=2Ekeys[0]=2Ecipher, sizeof(key2=2Ekeys[0]=2Eciphe=
r));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        prng_by=
tes(key2=2Ekeys[0]=2Ehmac, sizeof(key2=2Ekeys[0]=2Ehmac));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        prng_bytes(key2=2Ekeys[1]=2E=
cipher, sizeof(key2=2Ekeys[1]=2Ecipher));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        prng_bytes(key2=2Ekeys[1]=2Ehmac, sizeof(key2=
=2Ekeys)[1]=2Ehmac);</span><br><span>     }</span><br><span> </span><br><sp=
an>     struct crypto_options co =3D { 0 };</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
33?usp=3Demail">change 1833</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1833?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchang=
e </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: If458a3362e03630ce699bd122e957169601657a5 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 1833 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerri=
t-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>

</body></html>
--UtVWWF5IJpo=--


--===============8188072366925085095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8188072366925085095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8188072366925085095==--

