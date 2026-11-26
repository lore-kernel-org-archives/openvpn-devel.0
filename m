Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CD1606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kW5G2BRe;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CfV+hBEY;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Br3alMt9;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=O7i1gES4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=9XcJGUiOFTQxL5AnhBJlMU472A7/0NKTdBN5d8vO/fM=; b=kW5G2BRe7OhXeLyJOIm5CoEHG4
	ZhjHWRJH9LTeb6ujiBgI47uKgIEmNdqfoSFg3q0gPiTDXyiODBRTqV+jhNcJicPG4TpfpYixHhH2G
	RJ+pdJqgNj79+OzAfqmgU4QWJMo0M/Lr4rqJ6ggnU3I506QwXZNYTgp/+C+7IvyWqRss=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWXAE-000000004ta-0U42;
	Thu, 26 Nov 2026 10:57:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWXA9-000000004tR-3tIy
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 10:57:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Xqyavj+38NPrUxs9GdCLE16PlDslA6ibHio3F9xwSro=; b=CfV+hBEYcsJdxzTTyEEqe70AgD
 cM2a9+kOwlaMzn82hIj8mMahpgpkxbhJ7K7wCXmRzPDfmsiQoclIqJWgBkbzEH6gR+eguSLrFeFXx
 lNWZtLqHIy2EHc3hGQf+LtvEK4jJT3WT9TuMVGIV5ezwUqtFcK/9Onp27ol87bOmKKR4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Xqyavj+38NPrUxs9GdCLE16PlDslA6ibHio3F9xwSro=; b=Br3alMt9Bd6T8edoqKaHGwlRAQ
 GdLWe+IAhSwcdeWkJ2O9/lwhZMw8pPYVs4g9tlHfaLKj6Grovi8k5V5KVsTE4icB/fkWNUqSQ/s+N
 1URK6yzmwgL/XX69qNFrjpF8KmlRu2nnqUuETLx1nzZ1YeeFBfiCEKxGvYofw7JzVLq4=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWXA8-000000004NI-1iHA for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 10:57:13 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso53638175e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 02:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795690626; x=1796295426; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Xqyavj+38NPrUxs9GdCLE16PlDslA6ibHio3F9xwSro=;
 b=O7i1gES4QyuaE+ERIUalluDuAnZSLrRXeJ7M7YQzYNyfjWNDj+0tk7p5lH5Rpaio8O
 wzZqhby2uiWCA7s1icTLduydJNYQfjGCLI8cCwHU5xkEEj0pDt+AXmee5vDVwea+T2O7
 3N1yL4NgEX0IoudtgiYEA67P8EQawwQPDZ+UQe1ER3d18SeQ6hH5HX35D2eDGXPdvRDD
 8oxBlYTIYYpjREE6w/RbizMxZxxSzufovTO89Y3l64/0QFDTm0cXeHkwP4UHaYoCzJlA
 XVqIL2t625dTnujw3LoenvF2/gZMyw0n7BEgPvRTob0JdSJSiXCpgKLBW2k2mEfIaOCj
 NgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795690626; x=1796295426;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xqyavj+38NPrUxs9GdCLE16PlDslA6ibHio3F9xwSro=;
 b=aJ9MXNnqW4471KQ0lhghWAEfyTVl6ZLzdOZOfM4rmPovj6YQBbOfTRCRnNjMyvq+G/
 7ZS7o4JbxTLTROVnRcDzrxHt2b8vuLtLZdBQVsxeAP+N4Vk3ZI6lgRQ+MTU6NZOFLisz
 dqi986iM1SrMm52mSoTNh9VJKfxMywpsP5tzzz2PLAaaKhg/cklhLqHbDctPu5kRg9tW
 LgoaBIltkuScIPCz+75mibQOGgNviIuvRzoiZlEjo8JCH2eQkpOzG5Di1nZdRZm7V24M
 LgiOyULGWMosIGY9Y80o3yX1NSaUv0DtDNJSUff8XQ0cD4pMQ7qBA4HNziTz+YbGGGGw
 HhSQ==
X-Gm-Message-State: APuU4Z+XBCyDY2upED3l6DJ0+1B9LiT0GLheNtQAy3qBM8sG0Vl9AGvB
 ZyU0NkO7zA/5NY4Dyp0r3d/APnGdcxVcZmPSQS443Z3Zo3gL/UAPK79/lhVRaecHxo5I3EQmbuU
 dylCd5z15csmkwqpv2ekFeoenY+DWu23PAegfWG1JZz1MT9fZjpWfsc4A5zouGBn37pwSeUTqam
 XyAtkyAw==
X-Gm-Gg: AZFdTZdnF9LcE4rUrGqmICEIpajIAccLJv3YvLDNcrBfMeD/xF5RwjDZjR07tvfNz4d
 bpb6QAyp/9jWPS+izPOeT6375fySvcPNo671wqg58yP/TSchJWVOj+WbCWASqKvHTNE6hQKH5uN
 h97tMsQqsnxTQ6/qdhShTs5xflYFhaMN6GFxHNnWrWSO4v9Z13l0NudkJ/CwpAtsLqLK70pYcTs
 k2DbJQG0wgsDM8b9C+WBNp1zlIiaAyQFqWH50gYZOPevgQjyggn8KHD0e/Tv5EYNNqkJStZPlCi
 r1hO3Q6cco5M56MWusXdlokY5r6pSO1O6BIb40nLbvkvj+RmZI+UVT+H8+rGxtU/agOx6w/SCDj
 E+BC7Elk7kT4eO5+N45OKq2Uo2m5uQysrpMMoWWM42LeoxzJ3/v9vagW/1zB2iWHC0WKNQc7jUs
 dyFE7sZuO9xLWYtWsnwAnerIDsqa8cY7StW4FTEc4PhvB+79ev3tJTsz6Q5WVWcxh8L5WvsNJlj
 ioBAi2Oh+bWdUrbyIYavTZFA7HFqb0K0gCOlV1IXGjqTsoTGg/ffuEs77t8TrfWmUObTT/M0GqZ
 KO8CI9aLh0EcTr/o7bhMZfRHSf3+5M0M/WXwcSVS8lS8JV0dYTe4dLhDIuRQO5gCNBneXmb1jh6
 mnWn8UEYQN7VffQZSjnHlWkQ6Qsa3dB5pOFrfVHRBObemSy7oJVf0Qh27HVz2YnRhuVRMAK8XRZ
 Jp7mS84hQJID/wYENgK5VGR4fO92qYAGMy0m1a
X-Received: by 2002:a05:600c:4f0d:b0:4bb:5c97:f4b1 with SMTP id
 5b1f17b1804b1-4bb8881941bmr466457375e9.24.1795690625849; 
 Thu, 26 Nov 2026 02:57:05 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b3a7sm661369915e9.3.2026.11.26.02.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 02:57:05 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 10:57:05 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I23ae372cd5d83a8b07cc1dd491349473b816c576
X-Gerrit-Change-Number: 2351
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2351?usp=email>
X-Gerrit-Commit: 3e7517533c063615e0a5f5419799b3fb55055ae2
References: <gerrit.1795690623000.I23ae372cd5d83a8b07cc1dd491349473b816c576@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NjkwNjIzMDAwLkkyM2FlMzcyY2Q1ZDgzYThiMDdjYzFkZDQ5MTM0OTQ3M2I4MTZjNTc2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cfeae27c0ddd287f1bd15e5a8978c0e7640b1d65-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWXA8-000000004NI-1iHA
Subject: [Openvpn-devel] [M] Change in openvpn[master]: ssl_openssl: add
 bio_new_file_or_inline() helper
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
Content-Type: multipart/mixed; boundary="===============5699912200399347930=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5699912200399347930==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XHWURoJ0lPw="; charset=UTF-8

--XHWURoJ0lPw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2351?usp=3Demail

to review the following change=2E
=


Change subject: ssl_openssl: add bio_new_file_or_inline() helper
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl_openssl: add bi=
o_new_file_or_inline() helper

Four loaders opened their input as a memory =
BIO when inline and as a
file BIO otherwise, each with its own copy of the =
if/else=2E Move that
into one helper=2E

Change-Id: I23ae372cd5d83a8b07cc1d=
d491349473b816c576
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
-=
--
M src/openvpn/ssl_openssl=2Ec
1 file changed, 15 insertions(+), 41 delet=
ions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/51/2351/1

diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_op=
enssl=2Ec
index 03e0279=2E=2Eac2ac4c 100644
--- a/src/openvpn/ssl_openssl=
=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -1201,24 +1201,26 @@
 #endif /* d=
efined(HAVE_OPENSSL_STORE_API */
 }
 
+/* Open file for reading, or a memor=
y BIO over its contents if is_inline */
+static BIO *
+bio_new_file_or_inli=
ne(const char *file, bool is_inline)
+{
+    if (is_inline)
+    {
+       =
 return BIO_new_mem_buf(file, -1);
+    }
+    return BIO_new_file(file, "r=
");
+}
+
 static void
 tls_ctx_load_cert_pem_file(struct tls_root_ctx *ctx,=
 const char *cert_file, bool cert_file_inline)
 {
-    BIO *in =3D NULL;
  =
   X509 *x =3D NULL;
     int ret =3D 0;
 
     ASSERT(NULL !=3D ctx);
 
- =
   if (cert_file_inline)
-    {
-        in =3D BIO_new_mem_buf((char *)cer=
t_file, -1);
-    }
-    else
-    {
-        in =3D BIO_new_file((char *)c=
ert_file, "r");
-    }
-
+    BIO *in =3D bio_new_file_or_inline(cert_file,=
 cert_file_inline);
     if (in =3D=3D NULL)
     {
         SSLerr(SSL_F_S=
SL_CTX_USE_CERTIFICATE_FILE, ERR_R_SYS_LIB);
@@ -1331,7 +1333,6 @@
 void
 b=
ackend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_fil=
e, bool crl_inline)
 {
-    BIO *in =3D NULL;
     STACK_OF(X509_CRL) *crls=
 =3D NULL;
 
     X509_STORE *store =3D SSL_CTX_get_cert_store(ssl_ctx->ctx=
);
@@ -1345,15 +1346,7 @@
 
     X509_STORE_set_flags(store, X509_V_FLAG_CR=
L_CHECK | X509_V_FLAG_CRL_CHECK_ALL);
 
-    if (crl_inline)
-    {
-      =
  in =3D BIO_new_mem_buf((char *)crl_file, -1);
-    }
-    else
-    {
-  =
      in =3D BIO_new_file(crl_file, "r");
-    }
-
+    BIO *in =3D bio_new=
_file_or_inline(crl_file, crl_inline);
     if (in =3D=3D NULL)
     {
    =
     msg(M_WARN, "CRL: cannot read: %s", print_key_filename(crl_file, crl_i=
nline));
@@ -1831,17 +1824,7 @@
     if (ca_file)
     {
         openssl_s=
tack_size_t added =3D 0;
-        BIO *in =3D NULL;
-
-        if (ca_file_=
inline)
-        {
-            in =3D BIO_new_mem_buf((char *)ca_file, -1)=
;
-        }
-        else
-        {
-            in =3D BIO_new_file(ca_f=
ile, "r");
-        }
-
+        BIO *in =3D bio_new_file_or_inline(ca_file=
, ca_file_inline);
         if (in)
         {
             info_stack =3D =
PEM_X509_INFO_read_bio(in, NULL, NULL, NULL);
@@ -1968,16 +1951,7 @@
 tls_c=
tx_load_extra_certs(struct tls_root_ctx *ctx, const char *extra_certs_file,=

                          bool extra_certs_file_inline)
 {
-    BIO *in;
-=
    if (extra_certs_file_inline)
-    {
-        in =3D BIO_new_mem_buf((ch=
ar *)extra_certs_file, -1);
-    }
-    else
-    {
-        in =3D BIO_new=
_file(extra_certs_file, "r");
-    }
-
+    BIO *in =3D bio_new_file_or_inl=
ine(extra_certs_file, extra_certs_file_inline);
     if (in =3D=3D NULL)
  =
   {
         crypto_msg(M_FATAL, "Cannot load extra-certs file: %s",

-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2351?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I23ae372cd5d83a8b07cc1=
dd491349473b816c576
Gerrit-Change-Number: 2351
Gerrit-PatchSet: 1
Gerrit-Ow=
ner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Sch=
wabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>

--XHWURoJ0lPw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2351?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">ssl_openssl: add bio_new_file_or_inline() helper<br><br=
>Four loaders opened their input as a memory BIO when inline and as a<br>fi=
le BIO otherwise, each with its own copy of the if/else=2E Move that<br>int=
o one helper=2E<br><br>Change-Id: I23ae372cd5d83a8b07cc1dd491349473b816c576=
<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>=
M src/openvpn/ssl_openssl=2Ec<br>1 file changed, 15 insertions(+), 41 delet=
ions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29=
418/openvpn refs/changes/51/2351/1</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_ope=
nssl=2Ec b/src/openvpn/ssl_openssl=2Ec</span><br><span>index 03e0279=2E=2Ea=
c2ac4c 100644</span><br><span>--- a/src/openvpn/ssl_openssl=2Ec</span><br><=
span>+++ b/src/openvpn/ssl_openssl=2Ec</span><br><span>@@ -1201,24 +1201,26=
 @@</span><br><span> #endif /* defined(HAVE_OPENSSL_STORE_API */</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/* Open file for reading, or a memory BIO over its contents if is_in=
line */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static BIO *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bio_new_file_or_inl=
ine(const char *file, bool is_inline)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (is_inline)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return =
BIO_new_mem_buf(file, -1);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn BIO_new_file(file, &quot;r&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> static void</span><br><span> tls_ctx_load_cert_pem_file(=
struct tls_root_ctx *ctx, const char *cert_file, bool cert_file_inline)</sp=
an><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    BI=
O *in =3D NULL;</span><br><span>     X509 *x =3D NULL;</span><br><span>    =
 int ret =3D 0;</span><br><span> </span><br><span>     ASSERT(NULL !=3D ctx=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (cert_file_inline)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        in =
=3D BIO_new_mem_buf((char *)cert_file, -1);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        in =3D BIO_new_=
file((char *)cert_file, &quot;r&quot;);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    BIO *in =3D b=
io_new_file_or_inline(cert_file, cert_file_inline);</span><br><span>     if=
 (in =3D=3D NULL)</span><br><span>     {</span><br><span>         SSLerr(SS=
L_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_SYS_LIB);</span><br><span>@@ -1331,=
7 +1333,6 @@</span><br><span> void</span><br><span> backend_tls_ctx_reload_=
crl(struct tls_root_ctx *ssl_ctx, const char *crl_file, bool crl_inline)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    B=
IO *in =3D NULL;</span><br><span>     STACK_OF(X509_CRL) *crls =3D NULL;</s=
pan><br><span> </span><br><span>     X509_STORE *store =3D SSL_CTX_get_cert=
_store(ssl_ctx-&gt;ctx);</span><br><span>@@ -1345,15 +1346,7 @@</span><br><=
span> </span><br><span>     X509_STORE_set_flags(store, X509_V_FLAG_CRL_CHE=
CK | X509_V_FLAG_CRL_CHECK_ALL);</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (crl_inline)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        in =3D BIO_new_mem_buf((char *)crl_file, -1);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      in =3D BIO_new_file(crl_file, &quot;r&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 BIO *in =3D bio_new_file_or_inline(crl_file, crl_inline);</span><br><span>=
     if (in =3D=3D NULL)</span><br><span>     {</span><br><span>         ms=
g(M_WARN, &quot;CRL: cannot read: %s&quot;, print_key_filename(crl_file, cr=
l_inline));</span><br><span>@@ -1831,17 +1824,7 @@</span><br><span>     if =
(ca_file)</span><br><span>     {</span><br><span>         openssl_stack_siz=
e_t added =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   BIO *in =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (ca_file_in=
line)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            in =3D BIO_new_m=
em_buf((char *)ca_file, -1);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            in =3D BIO_new=
_file(ca_file, &quot;r&quot;);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        BIO *in =3D bi=
o_new_file_or_inline(ca_file, ca_file_inline);</span><br><span>         if =
(in)</span><br><span>         {</span><br><span>             info_stack =3D=
 PEM_X509_INFO_read_bio(in, NULL, NULL, NULL);</span><br><span>@@ -1968,16 =
+1951,7 @@</span><br><span> tls_ctx_load_extra_certs(struct tls_root_ctx *c=
tx, const char *extra_certs_file,</span><br><span>                         =
 bool extra_certs_file_inline)</span><br><span> {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    BIO *in;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (extra_certs_file_inline)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        in =3D BIO_new_mem_buf((char *)extra_certs_file, -1=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        in =3D BIO_new_file(extra_certs_file, &quot;r&quot;);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    BIO *in =3D bio_new_file_or_inline(extra_certs_file, ex=
tra_certs_file_inline);</span><br><span>     if (in =3D=3D NULL)</span><br>=
<span>     {</span><br><span>         crypto_msg(M_FATAL, &quot;Cannot load=
 extra-certs file: %s&quot;,</span><br></pre><p>To view, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2351?usp=3Demail">change 2351</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2351?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I23a=
e372cd5d83a8b07cc1dd491349473b816c576 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 2351 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--XHWURoJ0lPw=--


--===============5699912200399347930==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5699912200399347930==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5699912200399347930==--

