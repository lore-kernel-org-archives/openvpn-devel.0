Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7C4C9830E
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 09:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=r+zoW4he3GWFZNMJ7yS0ppUANAXfspNWMMVWjR+Yx3k=; b=NECh3t/M/3Otjd
	0ECYdGPASTKQSWeJtuvDDIlN3+cbwU3rVgLMJtFD8EJUYRny//IQEvPLKjLQzC4FP5cb9Q3QmlqgT
	xP+Hp3lbKgptBkRLheS4mocnkNhqydLLyyLBDpgQ3i5uWL/ROkKiFhwXuCfXHyUI75wrjNw4f0ESF
	0lM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA2ar-0004IQ-P9;
	Fri, 25 Sep 2026 09:51:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA2aq-0004I2-HA
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 09:51:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tkL5Lx/ZtdOJAckX7Euj0ciEXy2a6gEuKs9/WID068Y=; b=Nb8XLlz3m/C8lYg/govvxLifP/
 7acGMMw6Y8vU8+YxVU6AgtKnS7wS336zUPkFY8+GMwRUKuewKmWHOXJRp0RxewEGiYfHzAhQ4+kAz
 Aw0+XCCj0T5xNyrskhVaMYsUg/FdAiy6BjJhirOaOf6rpNiioti4Ocx3npIazmEbf9t0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tkL5Lx/ZtdOJAckX7Euj0ciEXy2a6gEuKs9/WID068Y=; b=D
 /sIGVlcYwJpB3KsFt08djpvOlruLedKwFrX8OtfBscUpwFZmwLSuFGRfIJvBAaEIYDIYqCJFE2416
 hM2sp2NyS917ZhSY8wFaTEa6LxSNzkutrerxqB8PpPGp9knd04ythnX5Z2kCO6bSl5N99UQFY9b4c
 d7Wuz504LqFooaqU=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA2ak-0003Wu-9U for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 09:51:44 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e71cdb22bso5011775e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 02:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790329896; x=1790934696; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tkL5Lx/ZtdOJAckX7Euj0ciEXy2a6gEuKs9/WID068Y=;
 b=E41UBLXPjV7pGPw6XGdc9rv3AbzgNez22wcXqDcLDePjAlcYH2+M1LEaT0FYumPnei
 4jO82BWhyZTdBUw0UnnMYllnVJLgva6cyjNenemm7xVsN6jjTwf7bfWY7Oa3wivjBuJm
 fkiPZ/0FouHPQmjEvewEfPnTYs2Q6cDviJDfZn/X2Ahi+7p7hHsloGXnRi++fJG+QP/9
 bJvfwXry90StLbAkAPHftY2uX7BoTOOcpIgAgrIh/NF8MPMsC1Ru9J2UOCYNPXd2WPwI
 u1buWgBflaos1rJvOW6sO5tHs+BMdoQuZC4buMT3M/zwtfTVKy+mPORgB3AVFvoQNFZx
 8e1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790329896; x=1790934696;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tkL5Lx/ZtdOJAckX7Euj0ciEXy2a6gEuKs9/WID068Y=;
 b=gnK8mvB36HSszof/mlvsr2qRgTkKkUtEe+SOs8w2e37YUCdFK4DTfe7vuKflBF1N5m
 8CRrJTSxic7AtSuM1lQoo5IXXlT77onXdv+iRnDTEoXpL0eWxrjGr0UrIABzGlbIenK6
 mqIBGVdPV90aerrJfF8zdIUCDaf2kH8jaMSuHVfT4DxxGtIijKPnL/FxIUMR+PfrZlps
 RYpdhvb0oFfXR/jPSN77w8bAuk3I3ny3Oev0Or1XfvTPZHvgWbWvbG2y3GR8y3jrO774
 z5XM/dGZ3aDpymE96h+Xqc6CIHN/IXSJvk54E+BZ/0md3AFAY7mJ887ak6Wg2nZ0QafC
 BH3A==
X-Gm-Message-State: AFuF++k1dkDUtiqullgO8aCrDHzu2lYdu4Gvhe7DyTtqWNKP7IEUVA+U
 o3hqYyIicnoaESoUhohpzsQOAT8T2el2hAan8+LlU2kTDLmBfBTV0n0XVPmbunf4VBoG2Mb8mLM
 WSOLTisEdgr+KIUoam9+Zn98rtkSeuYH4j9N57U/+yqs08SiZ2j+47zuyqIrhfBH3aWAExX1ONa
 TEISeykQ==
X-Gm-Gg: AYBFou3cf67lvZRXIR77kcNwcK6qoNnJgHI67Or7UWUPUgdljaCWNR5NZkiYyHTSi0K
 0Pc/JWbY/N8XJTyy0SaZHlgY5Qnj0vYr1Lsg15LgtJ0X3UG64I720/puIK8+kNNcCriO12JMUPA
 xHBwn5o7RTmV28ptDFR4sT4HOaE0LliCXnTGRGWRjKcId0GRNZmtzaCYkPyE33Y7Gz0FIVs95Rn
 JBNuDbrtKB89tlJZ9RckFyf2PZMexzM0u6fRBMJRh/1+5hYGemhZAwN1zvbrYNa6PGDAnZ0jlv3
 u97WlAGorB/hIkAEdz1LY3er20fs6lvf1kx2iMe+MLYrWqzW1lk8NRuMm0YrJHcvMNPaSHN+PFK
 v3kjKWnigu4cqdRqC/uZpsX+U/5pygi/1pL2SQ0La4+k9sDVJgQq14/dtTjskkay6BoTOXHcsK7
 KfQDtXyEBAL1I07gKa+/JqfywST7QORgH44xUSRPDuV7j/DAHfQktSqmYz24D94ZULnAO5eHro3
 Dy9uFDoHwGCUiULr6sskc3vS4Ea1g3g+2KPJs4foIHwu0/3P/pGXow8mQJkjht/jsQ4UjRljxYj
 JjbKbTB59yDL75aB0oDnKwKzmmxKJdqv9au03L7oymqLB7keYabjHkhGzRe4zIKUiUdNEBw=
X-Received: by 2002:a05:600c:3155:b0:49f:ce73:5e94 with SMTP id
 5b1f17b1804b1-49fe670aa3dmr89157645e9.34.1790329895345; 
 Fri, 25 Sep 2026 02:51:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5de187asm133475895e9.7.2026.09.25.02.51.34
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 02:51:34 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 09:51:34 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I440c4c73865fdbd80f2c607e83c50e345a0e2438
X-Gerrit-Change-Number: 1950
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1950?usp=email>
X-Gerrit-Commit: cf481197cd8c5e5270f11dbaa63c87265e2b13c8
References: <gerrit.1790329891000.I440c4c73865fdbd80f2c607e83c50e345a0e2438@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzI5ODkxMDAwLkk0NDBjNGM3Mzg2NWZkYmQ4MGYyYzYwN2U4M2M1MGUzNDVhMGUyNDM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d8a0e3f4cdce2e0e543782c5d480f368e324a4b1-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA2ak-0003Wu-9U
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Drop the OpenSSL
 errors a failed cipher/digest lookup leaves behind
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
Content-Type: multipart/mixed; boundary="===============8060845992875863947=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8060845992875863947==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="y2kNymM0afk="; charset=UTF-8

--y2kNymM0afk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1950?usp=3Demail )


Change subject: Drop the OpenSSL er=
rors a failed cipher/digest lookup leaves behind
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Drop the OpenSSL errors a failed ciph=
er/digest lookup leaves behind

cipher_get() looks a cipher up with EVP_CIP=
HER_fetch() and hands the
result, possibly NULL, to callers that only care =
whether it exists:
cipher_valid_reason(), cipher_kt_mode_cbc/ofb_cfb/aead()=
,
cipher_kt_block_size(), cipher_kt_insecure()=2E A failed fetch is a norma=
l
outcome for them, but under OpenSSL 3 it also pushes an
EVP_R_UNSUPPORTED=
 error ("digital envelope routines::unsupported,
Algorithm (none : 0)") ont=
o the thread's error queue, and nobody pops it=2E

The common way to get th=
ere is not exotic=2E A server that does not set
--cipher gets the legacy de=
fault BF-CBC, which is not in --data-ciphers,
so do_init_crypto_tls() initi=
alises the pre-negotiation key_type with
cipher "none"=2E Every new client =
instance then runs init_instance() ->
do_init_crypto_tls() -> cipher_kt_mod=
e_ofb_cfb("none"), and the frame
and OCC calculations (calculate_crypto_ove=
rhead(), frame_calculate_*())
walk the same key_type, each fetching "none" =
and failing=2E
cipher_kt_block_size() adds a second case for AEAD ciphers w=
hose CBC
sibling does not exist (CHACHA20-POLY1305 -> "CHACHA20-CBC")=2E
md=
_valid() has the same shape for digests=2E

The stale entry then misleads c=
ode that classifies an unrelated failure
with ERR_peek_error(), which retur=
ns the OLDEST queued entry=2E The visible
symptom is backend_tls_ctx_reload=
_crl() logging "CRL: cannot read CRL
from file" on the first handshake afte=
r the CRL file changes although
the CRL loaded fine (GitHub #1103)=2E Trace=
d with gdb on OpenVPN 2=2E7=2E0 and
master with OpenSSL 3=2E5=2E5: the sing=
le entry on the queue at reload entry
is the cipher_kt_mode_ofb_cfb("none")=
 fetch from do_init_crypto_tls()
of that same client instance=2E

Bracket t=
he probing fetches with ERR_set_mark()/ERR_pop_to_mark() so a
failed lookup=
 leaves the queue as it found it; the return value already
carries the answ=
er these callers want=2E wolfSSL's compatibility layer has
no error marks, =
so openssl_compat=2Eh maps them to ERR_clear_error() there=2E

With this ch=
ange the error queue is empty at multi_create_instance() and
at backend_tls=
_ctx_reload_crl() entry for UDP, TCP and CHACHA20-POLY1305
clients, and the=
 spurious warning is gone: three CRL replacements, three
handshakes, zero w=
arnings (unpatched: three of three)=2E

Change-Id: I440c4c73865fdbd80f2c607=
e83c50e345a0e2438
Signed-off-by: Drew Blokzyl <drew@linuxkids=2Ecom>
Signed=
-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/crypto_openssl=
=2Ec
M src/openvpn/openssl_compat=2Eh
2 files changed, 33 insertions(+), 1 =
deletion(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/50/1950/1

diff --git a/src/openvpn/crypto_openssl=2Ec b/src/openvpn=
/crypto_openssl=2Ec
index 29c5fa6=2E=2E575db98 100644
--- a/src/openvpn/cry=
pto_openssl=2Ec
+++ b/src/openvpn/crypto_openssl=2Ec
@@ -569,7 +569,17 @@
 =
    ASSERT(ciphername);
 
     ciphername =3D translate_cipher_name_from_op=
envpn(ciphername);
-    return EVP_CIPHER_fetch(NULL, ciphername, NULL);
+
=
+    /* A failed fetch leaves an EVP "unsupported" error on the thread's
+ =
    * error queue=2E Callers legitimately probe names OpenSSL does not know=

+     * ("none" for the not-yet-negotiated key_type, the CBC sibling of an=

+     * AEAD cipher, user supplied names) and only look at the return valu=
e,
+     * so drop whatever the fetch raised instead of leaving it for an
+=
     * unrelated ERR_peek_error() to misinterpret later=2E */
+    ERR_set_=
mark();
+    evp_cipher_type *cipher =3D EVP_CIPHER_fetch(NULL, ciphername,=
 NULL);
+    ERR_pop_to_mark();
+    return cipher;
 }
 
 bool
@@ -692,7 +7=
02,9 @@
 
     strcpy(mode_str, "-CBC");
 
+    ERR_set_mark();
     cbc_ci=
pher =3D EVP_CIPHER_fetch(NULL, translate_cipher_name_from_openvpn(name), N=
ULL);
+    ERR_pop_to_mark();
     if (cbc_cipher)
     {
         block_si=
ze =3D EVP_CIPHER_block_size(cbc_cipher);
@@ -1001,7 +1013,9 @@
 bool
 md_v=
alid(const char *digest)
 {
+    ERR_set_mark();
     evp_md_type *md =3D E=
VP_MD_fetch(NULL, digest, NULL);
+    ERR_pop_to_mark();
     bool valid =
=3D (md !=3D NULL);
     EVP_MD_free(md);
     return valid;
diff --git a/s=
rc/openvpn/openssl_compat=2Eh b/src/openvpn/openssl_compat=2Eh
index 098bdd=
5=2E=2E3029f7a 100644
--- a/src/openvpn/openssl_compat=2Eh
+++ b/src/openvp=
n/openssl_compat=2Eh
@@ -47,6 +47,24 @@
 
 /* Define the type of error=2E T=
his is something that is less
  * intrusive than casts everywhere */
+#if d=
efined(ENABLE_CRYPTO_WOLFSSL)
+/* wolfSSL's OpenSSL compatibility layer has=
 no error queue marks=2E The
+ * callers use them to drop what a failed loo=
kup raised, so fall back to
+ * clearing the queue=2E */
+static inline int=

+ERR_set_mark(void)
+{
+    return 1;
+}
+
+static inline int
+ERR_pop_to_=
mark(void)
+{
+    ERR_clear_error();
+    return 1;
+}
+#endif /* defined(=
ENABLE_CRYPTO_WOLFSSL) */
+
 #if defined(OPENSSL_IS_AWSLC)
 typedef uint32_=
t openssl_err_t;
 typedef size_t openssl_stack_size_t;

-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: I440c4c73865fdbd80f2c607e83c50e345a0e24=
38
Gerrit-Change-Number: 1950
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>

--y2kNymM0afk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Drop the OpenSSL errors a failed cipher/digest lookup leaves behin=
d<br><br>cipher_get() looks a cipher up with EVP_CIPHER_fetch() and hands t=
he<br>result, possibly NULL, to callers that only care whether it exists:<b=
r>cipher_valid_reason(), cipher_kt_mode_cbc/ofb_cfb/aead(),<br>cipher_kt_bl=
ock_size(), cipher_kt_insecure()=2E A failed fetch is a normal<br>outcome f=
or them, but under OpenSSL 3 it also pushes an<br>EVP_R_UNSUPPORTED error (=
&quot;digital envelope routines::unsupported,<br>Algorithm (none : 0)&quot;=
) onto the thread&#39;s error queue, and nobody pops it=2E<br><br>The commo=
n way to get there is not exotic=2E A server that does not set<br>--cipher =
gets the legacy default BF-CBC, which is not in --data-ciphers,<br>so do_in=
it_crypto_tls() initialises the pre-negotiation key_type with<br>cipher &qu=
ot;none&quot;=2E Every new client instance then runs init_instance() -&gt;<=
br>do_init_crypto_tls() -&gt; cipher_kt_mode_ofb_cfb(&quot;none&quot;), and=
 the frame<br>and OCC calculations (calculate_crypto_overhead(), frame_calc=
ulate_*())<br>walk the same key_type, each fetching &quot;none&quot; and fa=
iling=2E<br>cipher_kt_block_size() adds a second case for AEAD ciphers whos=
e CBC<br>sibling does not exist (CHACHA20-POLY1305 -&gt; &quot;CHACHA20-CBC=
&quot;)=2E<br>md_valid() has the same shape for digests=2E<br><br>The stale=
 entry then misleads code that classifies an unrelated failure<br>with ERR_=
peek_error(), which returns the OLDEST queued entry=2E The visible<br>sympt=
om is backend_tls_ctx_reload_crl() logging &quot;CRL: cannot read CRL<br>fr=
om file&quot; on the first handshake after the CRL file changes although<br=
>the CRL loaded fine (GitHub #1103)=2E Traced with gdb on OpenVPN 2=2E7=2E0=
 and<br>master with OpenSSL 3=2E5=2E5: the single entry on the queue at rel=
oad entry<br>is the cipher_kt_mode_ofb_cfb(&quot;none&quot;) fetch from do_=
init_crypto_tls()<br>of that same client instance=2E<br><br>Bracket the pro=
bing fetches with ERR_set_mark()/ERR_pop_to_mark() so a<br>failed lookup le=
aves the queue as it found it; the return value already<br>carries the answ=
er these callers want=2E wolfSSL&#39;s compatibility layer has<br>no error =
marks, so openssl_compat=2Eh maps them to ERR_clear_error() there=2E<br><br=
>With this change the error queue is empty at multi_create_instance() and<b=
r>at backend_tls_ctx_reload_crl() entry for UDP, TCP and CHACHA20-POLY1305<=
br>clients, and the spurious warning is gone: three CRL replacements, three=
<br>handshakes, zero warnings (unpatched: three of three)=2E<br><br>Change-=
Id: I440c4c73865fdbd80f2c607e83c50e345a0e2438<br>Signed-off-by: Drew Blokzy=
l &lt;drew@linuxkids=2Ecom&gt;<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2=
549=2Eorg&gt;<br>---<br>M src/openvpn/crypto_openssl=2Ec<br>M src/openvpn/o=
penssl_compat=2Eh<br>2 files changed, 33 insertions(+), 1 deletion(-)<br><b=
r></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/50/1950/1</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto_openssl=2Ec b=
/src/openvpn/crypto_openssl=2Ec</span><br><span>index 29c5fa6=2E=2E575db98 =
100644</span><br><span>--- a/src/openvpn/crypto_openssl=2Ec</span><br><span=
>+++ b/src/openvpn/crypto_openssl=2Ec</span><br><span>@@ -569,7 +569,17 @@<=
/span><br><span>     ASSERT(ciphername);</span><br><span> </span><br><span>=
     ciphername =3D translate_cipher_name_from_openvpn(ciphername);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    return EVP_CIPHER_fetch(N=
ULL, ciphername, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* A failed=
 fetch leaves an EVP &quot;unsupported&quot; error on the thread&#39;s</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * error queue=2E Ca=
llers legitimately probe names OpenSSL does not know</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * (&quot;none&quot; for the not-yet-=
negotiated key_type, the CBC sibling of an</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * AEAD cipher, user supplied names) and only lo=
ok at the return value,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * so drop whatever the fetch raised instead of leaving it for an</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * unrelated ERR_=
peek_error() to misinterpret later=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    ERR_set_mark();</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    evp_cipher_type *cipher =3D EVP_CIPHER_fetch(NULL,=
 ciphername, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    ERR_pop_to_mark();</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return cipher;</span><br><span> }</span><br><span> </span><br><span>=
 bool</span><br><span>@@ -692,7 +702,9 @@</span><br><span> </span><br><span=
>     strcpy(mode_str, &quot;-CBC&quot;);</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    ERR_set_mark();</span><br><span=
>     cbc_cipher =3D EVP_CIPHER_fetch(NULL, translate_cipher_name_from_open=
vpn(name), NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  ERR_pop_to_mark();</span><br><span>     if (cbc_cipher)</span><br><span> =
    {</span><br><span>         block_size =3D EVP_CIPHER_block_size(cbc_cip=
her);</span><br><span>@@ -1001,7 +1013,9 @@</span><br><span> bool</span><br=
><span> md_valid(const char *digest)</span><br><span> {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ERR_set_mark();</span><br><span>   =
  evp_md_type *md =3D EVP_MD_fetch(NULL, digest, NULL);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ERR_pop_to_mark();</span><br><span>=
     bool valid =3D (md !=3D NULL);</span><br><span>     EVP_MD_free(md);</=
span><br><span>     return valid;</span><br><span>diff --git a/src/openvpn/=
openssl_compat=2Eh b/src/openvpn/openssl_compat=2Eh</span><br><span>index 0=
98bdd5=2E=2E3029f7a 100644</span><br><span>--- a/src/openvpn/openssl_compat=
=2Eh</span><br><span>+++ b/src/openvpn/openssl_compat=2Eh</span><br><span>@=
@ -47,6 +47,24 @@</span><br><span> </span><br><span> /* Define the type of =
error=2E This is something that is less</span><br><span>  * intrusive than =
casts everywhere */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#if defined(ENABLE_CRYPTO_WOLFSSL)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* wolfSSL&#39;s OpenSSL compatibility layer has no error qu=
eue marks=2E The</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
callers use them to drop what a failed lookup raised, so fall back to</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * clearing the queue=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline int=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ERR_set_mark(void)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return 1;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 inline int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ERR_pop_=
to_mark(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    ERR_clear_error();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 1;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif /* defined(ENABLE_CRYPTO_WOLFSSL) */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #if=
 defined(OPENSSL_IS_AWSLC)</span><br><span> typedef uint32_t openssl_err_t;=
</span><br><span> typedef size_t openssl_stack_size_t;</span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=
=3Demail">change 1950</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1950?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I440c4c73865fdbd80f2c607e83c50e345a0e2438 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1950 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--y2kNymM0afk=--


--===============8060845992875863947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8060845992875863947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8060845992875863947==--

