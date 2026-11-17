Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8085606A323
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=POCn0eex;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Wx9F621E;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CztSqE+t;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=aBGw4KUp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=fwFGK5jmNZ8bWCCvHCbIF25izTexS/u2bcI33TM7y2c=; b=POCn0eex+0gOqiZ8vvELPAuKMj
	i5j34FaxQgYrRIG90OFq8GLIVgGUO2+0i+jYXg5+uC6GgxVwc/9Pa0HmXY7V/SdkYGJ2l+PPnYU64
	6JVKaHgZEtywcZkpZrVQCXW038wBsh4J3fBmkzcQ+RrdH4uHOSxqkoBfMal+yIxiZ2S0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTHGl-000000003CZ-3C4O;
	Tue, 17 Nov 2026 11:22:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTHGk-000000003CT-3w7J
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:22:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FL1qgkWjwfIsAueyC+RfQ/TdhdGfKS6h9rcYUGTRkPc=; b=Wx9F621E8pz3pl6G8a8sfyMa7q
 s/iHdFDBnqca9Gq4sEseuN6+qwe8J2g5jWW283XkLfyCeKaVl8jMBHsvtBaDECyrJDyVDfsQYEY+o
 iUnLTTqeOf+lUlOlVZ/A9RWeb1qXn+k5+n6Bk5/UYctdSZ4gQnwmzXh2dqZonbBi7VQ8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FL1qgkWjwfIsAueyC+RfQ/TdhdGfKS6h9rcYUGTRkPc=; b=CztSqE+tJ1YUNZ553jIMTra+fd
 /QcniRpePVmbO3UnhjURFQF4IDmR8rTVvYizdmU+fBl7s1/NdTEr6xaFqSwNZYne8V7pWOLcZxdpV
 NdRVPIUg8+TBmZlTBgW3yXOoA1OC5S2G/cOptz3BTzDEaFC9CglxxQRlDkXf0FuhBS7w=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTHGi-000000007ag-3JQ0 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:22:34 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so37392865e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 03:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794914546; x=1795519346; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FL1qgkWjwfIsAueyC+RfQ/TdhdGfKS6h9rcYUGTRkPc=;
 b=aBGw4KUpMt+yLk+7C2NHh7a1mnY8uiZcpMIlMT/HSe8MtSVZk/KD/Lv9KdPt4GeO+a
 lZg5IauOf8e3atJwP24zx/z8Iy5XVAkDVz0usB9shUsvn9FyoQ9Zg7TGbFjJEzRb6B6z
 sXiuGBldOgb3wPtpl0SwUVIr1nDedtSh8gD3NsQIVKjl4xPN65l2OfQ211MTTUuEufIZ
 MybKJPejvTQ5sPiUOjm/rZukSWa7gk7TD0rp/wkD9JXnv8/ZSJskH5cRbeaD4AOcLB3L
 +bhNLRMMG3kphOLMKShdpGX8F5LFuBBPYgF/U98f+X/Rk18hcjjHx559Z/rYoYJxyZil
 k0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794914546; x=1795519346;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FL1qgkWjwfIsAueyC+RfQ/TdhdGfKS6h9rcYUGTRkPc=;
 b=MeBuk6M2gnTjzZWtM5pVA7EH/tEe23dd4VnosFuw8U+fv/2JGHeZjsowCXy+3Jnni1
 k+6iWjUDwlwByjg/VMdtKrjE9FYtHS5Xk1smg7qOmGYP5fRZ8aKTbM45/28N5ZxWUl7v
 B4pMvxHDtcnJfmlZYbTACYkO00aQzY1xuz30XRS7jr4BHB6bKeQxXQDmeS4aln7Utoki
 kyA0wk7H7ocvhFMlTfkjBsr1C+L53BCG6ydYu8ICUotwNcTHpBz7gYKt/XmTF5VUDNOb
 HzuQL6BhupPhVbuHHhnge6+CTGTbdAr7o8OPHycxc2kjRiqO5zqxaVmYM1FSDRT6DQN/
 fADQ==
X-Gm-Message-State: APuU4Z+x9cNVriItB0IZWovFkgAlEpGXV79HFXolUAFjxgNlk+Wb1mbR
 nl0lYnNIw7U3wep/PS9KXy7VbSAkBjiIvCfXkPmBWdAQLsA7vJo3LNcJSo3jXvQjtjJ+VDj0+Gg
 VTfE1qPVgdYPo/4JknfXuC5jzgHT4VrELbaSf/LXnv1s7vblpyYJPMdYQOMvwQ6U+LS4g67+DPC
 clGOED2g==
X-Gm-Gg: AYBFou2tjsP2Kaw4PZcFKWQN8dFE5gOucn3YAiApbhkNkR5YjWzo8Vut0iOWqj/vaDt
 6CswIm7lkQ4JM9GcU40qGuw25uzXDRbinHfrpzzspkrJXRvVi5J9ushTtGLXWXFQnnBxb4UCumW
 pG6W6Hic5U4smSPhbb+C7dSdsFSy7jOlXPnsD88Q8jDtqgZwHeF9tcKhytnqGKv+W5HdLnZdeVN
 bqeMZBMbgtIXyYtw3q8hwg+QMgT/uXU1zo5C76eW6y6GZIgbIGeP3XqE2rg2tMJja1U9pjobOA/
 mpyEsgDmEZDxKqBfzhRvDbTMZAfD0Fe6TO4/B2vW6bnpms4NgEjAHWbPNumt4l/jBOSPrExlymA
 Kl4AJzkWhqlW1z/DUU7XLJP1rJDJwV2j2Pl0j0H0YhTthFE5DBteos0yXALoNFEErfQVZToGrsO
 IVNn5bh6Hjx++ItFhykR9iqbC2ZM/GS8mgoSxq33a0Vzjmna4AuxhFnIoDKsyzYJBWanNnbCkTE
 1eOxbcmrlYnOaOccnaRNDhWdBeoliZqkhqNvaJjYKSm8TJtoMAzntrKsjrNUZPnXIp9uyZaaAom
 h/Tw9vfSQmav8UbQiueIUnMlxEaDn2dxX178sePMgjZlLjLn2mjD8MzBfii1+YlsL4vtJ/BYiJO
 36rSWlc8N0Xvqf9fbQVVSz7L6zNQdLKy/bd+ysEUkBGcCDHKIqourtVIft4K3dGl5Kbf0Rymutu
 b9iZd+5tMkbBRAiBo=
X-Received: by 2002:a05:600c:3494:b0:4bb:6c71:b268 with SMTP id
 5b1f17b1804b1-4bb6c71c232mr144456665e9.6.1794914545802; 
 Tue, 17 Nov 2026 03:22:25 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a38b9b986esm4083329f8f.59.2026.11.17.03.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 03:22:25 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 11:22:24 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I76cd424b34e91f07a6d187b23a258d9dcbf7ed0f
X-Gerrit-Change-Number: 2145
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2145?usp=email>
X-Gerrit-Commit: 401e8f02c1ca7b0914b22b7b48bd866ecec9517d
In-Reply-To: <gerrit.1793957909000.I76cd424b34e91f07a6d187b23a258d9dcbf7ed0f@gerrit.openvpn.net>
References: <gerrit.1793957909000.I76cd424b34e91f07a6d187b23a258d9dcbf7ed0f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzOTU3OTA5MDAwLkk3NmNkNDI0YjM0ZTkxZjA3YTZkMTg3YjIzYTI1OGQ5ZGNiZjdlZDBmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <959b7591ed50a41c261cd9339e9a5a69f6edc5ef-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTHGi-000000007ag-3JQ0
Subject: [Openvpn-devel] [M] Change in openvpn[master]: ssl_verify: share
 fingerprint and x509 env helpers between backends
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
Content-Type: multipart/mixed; boundary="===============7774674531494965910=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7774674531494965910==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tPnNYlyTMz0="; charset=UTF-8

--tPnNYlyTMz0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2145?usp=3Demail

to look at the new patch set (#=
3)=2E


Change subject: ssl_verify: share fingerprint and x509 env helpers =
between backends
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

ssl_verify: share fingerprint and x509 env helpers between backends

R=
eplace x509_get_sha1_fingerprint() and x509_get_sha256_fingerprint()
with x=
509_get_fingerprint(cert, algo, gc) in both backends=2E This also
removes t=
he switch in verify_cert(), whose default case could not be
reached, as ver=
ify_hash_algo is always MD_SHA1 or MD_SHA256=2E The
backends now switch ove=
r the enum without a default, so a new
algorithm gets a -Wswitch warning, a=
nd ASSERT on unknown values=2E

Move the identical do_setenv_x509() copies =
from the backends to
ssl_verify=2Ec, with a stub for test_ssl as for verify=
_cert()=2E

Change-Id: I76cd424b34e91f07a6d187b23a258d9dcbf7ed0f
Signed-off=
-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/ssl_verify=
=2Ec
M src/openvpn/ssl_verify_backend=2Eh
M src/openvpn/ssl_verify_mbedtls=
=2Ec
M src/openvpn/ssl_verify_openssl=2Ec
M tests/unit_tests/openvpn/mock_s=
sl_dependencies=2Ec
5 files changed, 82 insertions(+), 130 deletions(-)


 =
 git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/45/2145/3=


diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
inde=
x 8641d15=2E=2E3df8e5ed 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/o=
penvpn/ssl_verify=2Ec
@@ -53,6 +53,19 @@
     string_mod(str, CC_PRINT, CC_=
CRLF, '_');
 }
 
+void
+do_setenv_x509(struct env_set *es, const char *name=
, char *value, int depth)
+{
+    string_mod(value, CC_ANY, CC_CRLF, '?');
=
+    msg(D_X509_ATTR, "X509 ATTRIBUTE name=3D'%s' value=3D'%s' depth=3D%d",=
 name, value, depth);
+    const size_t name_expand_size =3D 64 + strlen(na=
me);
+    char *name_expand =3D (char *)malloc(name_expand_size);
+    chec=
k_malloc_return(name_expand);
+    snprintf(name_expand, name_expand_size, =
"X509_%d_%s", depth, name);
+    setenv_str(es, name_expand, value);
+    f=
ree(name_expand);
+}
+
 /*
  * Export the untrusted IP address and port to =
the environment
  */
@@ -433,8 +446,8 @@
 
     /* export X509 cert fingerp=
rints */
     {
-        struct buffer sha1 =3D x509_get_sha1_fingerprint(p=
eer_cert, &gc);
-        struct buffer sha256 =3D x509_get_sha256_fingerpri=
nt(peer_cert, &gc);
+        struct buffer sha1 =3D x509_get_fingerprint(pe=
er_cert, MD_SHA1, &gc);
+        struct buffer sha256 =3D x509_get_fingerpr=
int(peer_cert, MD_SHA256, &gc);
 
         snprintf(envname, sizeof(envname=
), "tls_digest_%d", cert_depth);
         setenv_str(es, envname, format_he=
x_ex(BPTR(&sha1), BLEN(&sha1), 0, 1, ":", &gc));
@@ -676,31 +689,7 @@
 
   =
  if (cert_depth =3D=3D opt->verify_hash_depth && opt->verify_hash)
     {
=
-        struct buffer cert_fp =3D { 0 };
-
-        switch (opt->verify_ha=
sh_algo)
-        {
-            case MD_SHA1:
-                cert_fp =3D=
 x509_get_sha1_fingerprint(cert, &gc);
-                break;
-
-         =
   case MD_SHA256:
-                cert_fp =3D x509_get_sha256_fingerprint=
(cert, &gc);
-                break;
-
-            default:
-             =
   /* This should normally not happen at all; the algorithm used
-         =
        * is parsed by add_option() [options=2Ec] and set to a predefined
-=
                 * value in an enumerated type=2E  So if this unlikely scen=
ario
-                 * happens, consider this a failure
-                =
 */
-                msg(M_WARN,
-                    "Unexpected invalid a=
lgorithm used with "
-                    "--verify-hash (%i)",
-          =
          opt->verify_hash_algo);
-                ret =3D FAILURE;
-      =
          goto cleanup;
-        }
+        struct buffer cert_fp =3D x509_=
get_fingerprint(cert, opt->verify_hash_algo, &gc);
 
         if (BLEN(&cer=
t_fp) =3D=3D 0)
         {
diff --git a/src/openvpn/ssl_verify_backend=2Eh =
b/src/openvpn/ssl_verify_backend=2Eh
index 46720d6=2E=2E93916b7 100644
--- =
a/src/openvpn/ssl_verify_backend=2Eh
+++ b/src/openvpn/ssl_verify_backend=
=2Eh
@@ -75,6 +75,17 @@
                         const struct buffer *cert_=
hash);
 
 /*
+ * Export an X509 attribute as the X509_<depth>_<name> enviro=
nment variable,
+ * replacing CR and LF in value with '?'=2E
+ *
+ * @param=
 es            Environment set to add the variable to
+ * @param name      =
    Attribute name
+ * @param value         Attribute value, modified in pl=
ace
+ * @param depth         Depth of the certificate the attribute belongs=
 to
+ */
+void do_setenv_x509(struct env_set *es, const char *name, char *v=
alue, int depth);
+
+/*
  * Library-specific functions=2E
  *
  * The follo=
wing functions must be implemented on a library-specific basis=2E
@@ -91,24=
 +102,16 @@
 char *x509_get_subject(openvpn_x509_cert_t *cert, struct gc_ar=
ena *gc);
 
 /**
- * Retrieve the certificate's SHA1 fingerprint=2E
+ * Ret=
rieve the certificate's fingerprint=2E
  *
  * @param cert          Certifi=
cate to retrieve the fingerprint from=2E
+ * @param algo          Hash algo=
rithm to use=2E
  * @param gc            Garbage collection arena to use wh=
en allocating string=2E
  *
- * @return              a string containing th=
e certificate fingerprint
+ * @return              a buffer containing the =
certificate fingerprint
  */
-struct buffer x509_get_sha1_fingerprint(openv=
pn_x509_cert_t *cert, struct gc_arena *gc);
-
-/**
- * Retrieve the certifi=
cate's SHA256 fingerprint=2E
- *
- * @param cert          Certificate to re=
trieve the fingerprint from=2E
- * @param gc            Garbage collection =
arena to use when allocating string=2E
- *
- * @return              a strin=
g containing the certificate fingerprint
- */
-struct buffer x509_get_sha25=
6_fingerprint(openvpn_x509_cert_t *cert, struct gc_arena *gc);
+struct buff=
er x509_get_fingerprint(openvpn_x509_cert_t *cert, hash_algo_type algo,
+  =
                                 struct gc_arena *gc);
 
 /*
  * Retrieve t=
he certificate's username from the specified field=2E
diff --git a/src/open=
vpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec
index bba2f=
2f=2E=2E37d0d79 100644
--- a/src/openvpn/ssl_verify_mbedtls=2Ec
+++ b/src/o=
penvpn/ssl_verify_mbedtls=2Ec
@@ -55,7 +55,7 @@
     session->verified =3D =
false;
 
     /* Remember certificate hash */
-    struct buffer cert_finge=
rprint =3D x509_get_sha256_fingerprint(cert, &gc);
+    const struct buffer=
 cert_fingerprint =3D x509_get_fingerprint(cert, MD_SHA256, &gc);
     cert=
_hash_remember(session, cert_depth, &cert_fingerprint);
 
     if (session-=
>opt->verify_hash_no_ca)
@@ -507,9 +507,23 @@
     return FAILURE;
 }
 
-st=
atic struct buffer
-x509_get_fingerprint(const mbedtls_md_info_t *md_info, =
mbedtls_x509_crt *cert, struct gc_arena *gc)
+struct buffer
+x509_get_finge=
rprint(mbedtls_x509_crt *cert, hash_algo_type algo, struct gc_arena *gc)
 {=

+    mbedtls_md_type_t md_type =3D MBEDTLS_MD_NONE;
+    switch (algo)
+  =
  {
+        case MD_SHA1:
+            md_type =3D MBEDTLS_MD_SHA1;
+     =
       break;
+
+        case MD_SHA256:
+            md_type =3D MBEDTLS_M=
D_SHA256;
+            break;
+    }
+    ASSERT(md_type !=3D MBEDTLS_MD_NO=
NE);
+
+    const mbedtls_md_info_t *md_info =3D mbedtls_md_info_from_type(=
md_type);
     const size_t md_size =3D mbedtls_md_get_size(md_info);
     =
struct buffer fingerprint =3D alloc_buf_gc(md_size, gc);
     mbedtls_md(md=
_info, cert->raw=2Ep, cert->raw=2Elen, BPTR(&fingerprint));
@@ -517,18 +531=
,6 @@
     return fingerprint;
 }
 
-struct buffer
-x509_get_sha1_fingerpri=
nt(mbedtls_x509_crt *cert, struct gc_arena *gc)
-{
-    return x509_get_fin=
gerprint(mbedtls_md_info_from_type(MBEDTLS_MD_SHA1), cert, gc);
-}
-
-struc=
t buffer
-x509_get_sha256_fingerprint(mbedtls_x509_crt *cert, struct gc_are=
na *gc)
-{
-    return x509_get_fingerprint(mbedtls_md_info_from_type(MBEDT=
LS_MD_SHA256), cert, gc);
-}
-
 char *
 x509_get_subject(mbedtls_x509_crt *=
cert, struct gc_arena *gc)
 {
@@ -547,22 +549,6 @@
     return subject;
 }
=
 
-static void
-do_setenv_x509(struct env_set *es, const char *name, char *=
value, int depth)
-{
-    char *name_expand;
-    size_t name_expand_size;
=
-
-    string_mod(value, CC_ANY, CC_CRLF, '?');
-    msg(D_X509_ATTR, "X509=
 ATTRIBUTE name=3D'%s' value=3D'%s' depth=3D%d", name, value, depth);
-    =
name_expand_size =3D 64 + strlen(name);
-    name_expand =3D (char *)malloc=
(name_expand_size);
-    check_malloc_return(name_expand);
-    snprintf(na=
me_expand, name_expand_size, "X509_%d_%s", depth, name);
-    setenv_str(es=
, name_expand, value);
-    free(name_expand);
-}
-
 static char *
 asn1_bu=
f_to_c_string(const mbedtls_asn1_buf *orig, struct gc_arena *gc)
 {
@@ -706=
,22 +692,13 @@
     {
         if (depth =3D=3D 0 || (xt->flags & XT_FULL_C=
HAIN))
         {
-            if (0 =3D=3D strcmp(xt->name, "SHA1") || 0 =
=3D=3D strcmp(xt->name, "SHA256"))
+            const bool sha1 =3D strcmp(=
xt->name, "SHA1") =3D=3D 0;
+            if (sha1 || strcmp(xt->name, "SHA2=
56") =3D=3D 0)
             {
                 /* Fingerprint is not part o=
f X509 structure */
-                struct buffer cert_hash;
-            =
    char *fingerprint;
-
-                if (0 =3D=3D strcmp(xt->name, "SH=
A1"))
-                {
-                    cert_hash =3D x509_get_sha1_f=
ingerprint(cert, &gc);
-                }
-                else
-          =
      {
-                    cert_hash =3D x509_get_sha256_fingerprint(cert=
, &gc);
-                }
-
-                fingerprint =3D
+            =
    const hash_algo_type algo =3D sha1 ? MD_SHA1 : MD_SHA256;
+            =
    struct buffer cert_hash =3D x509_get_fingerprint(cert, algo, &gc);
+   =
             char *fingerprint =3D
                     format_hex_ex(BPTR(=
&cert_hash), BLEN(&cert_hash), 0, 1 | FHE_CAPS, ":", &gc);
                =
 do_setenv_x509(es, xt->name, fingerprint, depth);
             }
diff --gi=
t a/src/openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_verify_openssl=2Ec=

index 731ab3e=2E=2Ee56eba0 100644
--- a/src/openvpn/ssl_verify_openssl=2Ec=

+++ b/src/openvpn/ssl_verify_openssl=2Ec
@@ -61,7 +61,7 @@
     ASSERT(ses=
sion);
 
     X509 *current_cert =3D X509_STORE_CTX_get_current_cert(ctx);
=
-    struct buffer cert_hash =3D x509_get_sha256_fingerprint(current_cert, =
&gc);
+    const struct buffer cert_hash =3D x509_get_fingerprint(current_c=
ert, MD_SHA256, &gc);
     cert_hash_remember(session, X509_STORE_CTX_get_e=
rror_depth(ctx), &cert_hash);
 
     /* did peer present cert which was sig=
ned by our root cert? */
@@ -360,22 +360,25 @@
 }
 
 struct buffer
-x509_ge=
t_sha1_fingerprint(X509 *cert, struct gc_arena *gc)
+x509_get_fingerprint(X=
509 *cert, hash_algo_type algo, struct gc_arena *gc)
 {
-    const EVP_MD *=
sha1 =3D EVP_sha1();
-    struct buffer hash =3D alloc_buf_gc((size_t)EVP_M=
D_size(sha1), gc);
-    X509_digest(cert, EVP_sha1(), BPTR(&hash), NULL);
-=
    ASSERT(buf_inc_len(&hash, (int)EVP_MD_size(sha1)));
-    return hash;
-=
}
+    const EVP_MD *md =3D NULL;
+    switch (algo)
+    {
+        case M=
D_SHA1:
+            md =3D EVP_sha1();
+            break;
 
-struct buffe=
r
-x509_get_sha256_fingerprint(X509 *cert, struct gc_arena *gc)
-{
-    con=
st EVP_MD *sha256 =3D EVP_sha256();
-    struct buffer hash =3D alloc_buf_g=
c((size_t)EVP_MD_size(sha256), gc);
-    X509_digest(cert, EVP_sha256(), BP=
TR(&hash), NULL);
-    ASSERT(buf_inc_len(&hash, (int)EVP_MD_size(sha256)))=
;
+        case MD_SHA256:
+            md =3D EVP_sha256();
+            b=
reak;
+    }
+    ASSERT(md);
+
+    const int md_size =3D EVP_MD_size(md);=

+    struct buffer hash =3D alloc_buf_gc((size_t)md_size, gc);
+    X509_d=
igest(cert, md, BPTR(&hash), NULL);
+    ASSERT(buf_inc_len(&hash, md_size)=
);
     return hash;
 }
 
@@ -468,23 +471,6 @@
     }
 }
 
-/* worker metho=
d for setenv_x509_track */
-static void
-do_setenv_x509(struct env_set *es,=
 const char *name, char *value, int depth)
-{
-    char *name_expand;
-    =
size_t name_expand_size;
-
-    string_mod(value, CC_ANY, CC_CRLF, '?');
- =
   msg(D_X509_ATTR, "X509 ATTRIBUTE name=3D'%s' value=3D'%s' depth=3D%d", n=
ame, value, depth);
-    name_expand_size =3D 64 + strlen(name);
-    name_=
expand =3D (char *)malloc(name_expand_size);
-    check_malloc_return(name_=
expand);
-    snprintf(name_expand, name_expand_size, "X509_%d_%s", depth, =
name);
-    setenv_str(es, name_expand, value);
-    free(name_expand);
-}
=
-
 void
 x509_setenv_track(const struct x509_track *xt, struct env_set *es,=
 const int depth, X509 *x509)
 {
@@ -506,19 +492,10 @@
                 cas=
e NID_sha1:
                 case NID_sha256:
                 {
-         =
           struct buffer fp_buf;
-                    char *fp_str =3D NULL=
;
-
-                    if (xt->nid =3D=3D NID_sha1)
-                    =
{
-                        fp_buf =3D x509_get_sha1_fingerprint(x509, &gc);=

-                    }
-                    else
-                    {
- =
                       fp_buf =3D x509_get_sha256_fingerprint(x509, &gc);
-=
                    }
-
-                    fp_str =3D format_hex_ex(BPTR(=
&fp_buf), BLEN(&fp_buf), 0, 1 | FHE_CAPS, ":", &gc);
+                    c=
onst hash_algo_type algo =3D xt->nid =3D=3D NID_sha1 ? MD_SHA1 : MD_SHA256;=

+                    struct buffer fp_buf =3D x509_get_fingerprint(x509, a=
lgo, &gc);
+                    char *fp_str =3D
+                        f=
ormat_hex_ex(BPTR(&fp_buf), BLEN(&fp_buf), 0, 1 | FHE_CAPS, ":", &gc);
    =
                 do_setenv_x509(es, xt->name, fp_str, depth);
             =
    }
                 break;
diff --git a/tests/unit_tests/openvpn/mock_ss=
l_dependencies=2Ec b/tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec
ind=
ex b22dd89=2E=2E65e4635 100644
--- a/tests/unit_tests/openvpn/mock_ssl_depe=
ndencies=2Ec
+++ b/tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec
@@ -6=
4,3 +64,9 @@
 {
     return FAILURE;
 }
+
+void
+do_setenv_x509(struct env_=
set *es, const char *name, char *value, int depth)
+{
+    assert_false(tru=
e);
+}

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2145?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchs=
et
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I76cd424=
b34e91f07a6d187b23a258d9dcbf7ed0f
Gerrit-Change-Number: 2145
Gerrit-PatchSe=
t: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Revi=
ewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>

--tPnNYlyTMz0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru <strong>=
uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2145?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">ssl_verify: share fingerprint and x509 env helpers between backen=
ds<br><br>Replace x509_get_sha1_fingerprint() and x509_get_sha256_fingerpri=
nt()<br>with x509_get_fingerprint(cert, algo, gc) in both backends=2E This =
also<br>removes the switch in verify_cert(), whose default case could not b=
e<br>reached, as verify_hash_algo is always MD_SHA1 or MD_SHA256=2E The<br>=
backends now switch over the enum without a default, so a new<br>algorithm =
gets a -Wswitch warning, and ASSERT on unknown values=2E<br><br>Move the id=
entical do_setenv_x509() copies from the backends to<br>ssl_verify=2Ec, wit=
h a stub for test_ssl as for verify_cert()=2E<br><br>Change-Id: I76cd424b34=
e91f07a6d187b23a258d9dcbf7ed0f<br>Signed-off-by: Razvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/ssl_verify=2Ec<br>M src/openvpn=
/ssl_verify_backend=2Eh<br>M src/openvpn/ssl_verify_mbedtls=2Ec<br>M src/op=
envpn/ssl_verify_openssl=2Ec<br>M tests/unit_tests/openvpn/mock_ssl_depende=
ncies=2Ec<br>5 files changed, 82 insertions(+), 130 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/45/2145/3</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_verify=2Ec b/src/open=
vpn/ssl_verify=2Ec</span><br><span>index 8641d15=2E=2E3df8e5ed 100644</span=
><br><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/src/openv=
pn/ssl_verify=2Ec</span><br><span>@@ -53,6 +53,19 @@</span><br><span>     s=
tring_mod(str, CC_PRINT, CC_CRLF, &#39;_&#39;);</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+do_setenv_x509(struct env=
_set *es, const char *name, char *value, int depth)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    string_mod(value, CC_ANY, CC_CRLF, &#39;?&#39;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_X509_ATTR, &quot=
;X509 ATTRIBUTE name=3D&#39;%s&#39; value=3D&#39;%s&#39; depth=3D%d&quot;, =
name, value, depth);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const size_t name_expand_size =3D 64 + strlen(name);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    char *name_expand =3D (char *)mal=
loc(name_expand_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    check_malloc_return(name_expand);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    snprintf(name_expand, name_expand_size, &quot;X509=
_%d_%s&quot;, depth, name);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    setenv_str(es, name_expand, value);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    free(name_expand);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> /*</span><br><span>  * Export the untrusted =
IP address and port to the environment</span><br><span>  */</span><br><span=
>@@ -433,8 +446,8 @@</span><br><span> </span><br><span>     /* export X509 =
cert fingerprints */</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        struct buffer sha1 =3D x509_get_sha1_fingerpr=
int(peer_cert, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        struct buffer sha256 =3D x509_get_sha256_fingerprint(peer_cert, =
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        st=
ruct buffer sha1 =3D x509_get_fingerprint(peer_cert, MD_SHA1, &amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct buffer s=
ha256 =3D x509_get_fingerprint(peer_cert, MD_SHA256, &amp;gc);</span><br><s=
pan> </span><br><span>         snprintf(envname, sizeof(envname), &quot;tls=
_digest_%d&quot;, cert_depth);</span><br><span>         setenv_str(es, envn=
ame, format_hex_ex(BPTR(&amp;sha1), BLEN(&amp;sha1), 0, 1, &quot;:&quot;, &=
amp;gc));</span><br><span>@@ -676,31 +689,7 @@</span><br><span> </span><br>=
<span>     if (cert_depth =3D=3D opt-&gt;verify_hash_depth &amp;&amp; opt-&=
gt;verify_hash)</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        struct buffer cert_fp =3D { 0 };</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        switch (opt-&gt;verify_hash_algo)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            case MD_SHA1:</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                cert_fp =3D x509_get_sha1_finger=
print(cert, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            case MD_=
SHA256:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  cert_fp =3D x509_get_sha256_fingerprint(cert, &amp;gc);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                break;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            default:</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                /* This should normally not happen at all; t=
he algorithm used</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
             * is parsed by add_option() [options=2Ec] and set to a predefi=
ned</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 *=
 value in an enumerated type=2E  So if this unlikely scenario</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                 * happens, conside=
r this a failure</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
            */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         msg(M_WARN,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   &quot;Unexpected invalid algorithm used with &quot;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                    &quot;=
--verify-hash (%i)&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                    opt-&gt;verify_hash_algo);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                ret =3D FAILURE;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                goto cleanup;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        struct buffer cert_fp =3D x50=
9_get_fingerprint(cert, opt-&gt;verify_hash_algo, &amp;gc);</span><br><span=
> </span><br><span>         if (BLEN(&amp;cert_fp) =3D=3D 0)</span><br><spa=
n>         {</span><br><span>diff --git a/src/openvpn/ssl_verify_backend=2E=
h b/src/openvpn/ssl_verify_backend=2Eh</span><br><span>index 46720d6=2E=2E9=
3916b7 100644</span><br><span>--- a/src/openvpn/ssl_verify_backend=2Eh</spa=
n><br><span>+++ b/src/openvpn/ssl_verify_backend=2Eh</span><br><span>@@ -75=
,6 +75,17 @@</span><br><span>                         const struct buffer *=
cert_hash);</span><br><span> </span><br><span> /*</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Export an X509 attribute as the X509_&lt;d=
epth&gt;_&lt;name&gt; environment variable,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * replacing CR and LF in value with &#39;?&#39;=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param es            Environment =
set to add the variable to</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param name          Attribute name</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param value         Attribute value, modified=
 in place</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
depth         Depth of the certificate the attribute belongs to</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void do_setenv_x509(struct env_set *es, const c=
har *name, char *value, int depth);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*<=
/span><br><span>  * Library-specific functions=2E</span><br><span>  *</span=
><br><span>  * The following functions must be implemented on a library-spe=
cific basis=2E</span><br><span>@@ -91,24 +102,16 @@</span><br><span> char *=
x509_get_subject(openvpn_x509_cert_t *cert, struct gc_arena *gc);</span><br=
><span> </span><br><span> /**</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * Retrieve the certificate&#39;s SHA1 fingerprint=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Retrieve the certificate&#39;s=
 fingerprint=2E</span><br><span>  *</span><br><span>  * @param cert        =
  Certificate to retrieve the fingerprint from=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param algo          Hash algorithm to use=
=2E</span><br><span>  * @param gc            Garbage collection arena to us=
e when allocating string=2E</span><br><span>  *</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * @return              a string containing the c=
ertificate fingerprint</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @return              a buffer containing the certificate fingerprint<=
/span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
truct buffer x509_get_sha1_fingerprint(openvpn_x509_cert_t *cert, struct gc=
_arena *gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * Retrieve the certificate&#39;s SHA256 fingerp=
rint=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * @param cert          Certifica=
te to retrieve the fingerprint from=2E</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * @param gc            Garbage collection arena to use wh=
en allocating string=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return       =
       a string containing the certificate fingerprint</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-struct buffer x509_get_sha256_fingerprint(openvpn_x509_cert_=
t *cert, struct gc_arena *gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+struct buffer x509_get_fingerprint(openvpn_x509_cert_t *cert, ha=
sh_algo_type algo,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                  struct gc_arena *gc);</span><br><span> </=
span><br><span> /*</span><br><span>  * Retrieve the certificate&#39;s usern=
ame from the specified field=2E</span><br><span>diff --git a/src/openvpn/ss=
l_verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>i=
ndex bba2f2f=2E=2E37d0d79 100644</span><br><span>--- a/src/openvpn/ssl_veri=
fy_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify_mbedtls=2Ec</sp=
an><br><span>@@ -55,7 +55,7 @@</span><br><span>     session-&gt;verified =
=3D false;</span><br><span> </span><br><span>     /* Remember certificate h=
ash */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buff=
er cert_fingerprint =3D x509_get_sha256_fingerprint(cert, &amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct buffer cer=
t_fingerprint =3D x509_get_fingerprint(cert, MD_SHA256, &amp;gc);</span><br=
><span>     cert_hash_remember(session, cert_depth, &amp;cert_fingerprint);=
</span><br><span> </span><br><span>     if (session-&gt;opt-&gt;verify_hash=
_no_ca)</span><br><span>@@ -507,9 +507,23 @@</span><br><span>     return FA=
ILURE;</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-static struct buffer</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-x509_get_fingerprint(const mbedtls_md_info_t *md_info,=
 mbedtls_x509_crt *cert, struct gc_arena *gc)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+struct buffer</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+x509_get_fingerprint(mbedtls_x509_crt *cert, hash_algo_=
type algo, struct gc_arena *gc)</span><br><span> {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    mbedtls_md_type_t md_type =3D MBEDTLS_MD=
_NONE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch (a=
lgo)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        case MD_SHA1:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            md_type =3D MBE=
DTLS_MD_SHA1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        case MD_SHA256:</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            md_type =
=3D MBEDTLS_MD_SHA256;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            break;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(m=
d_type !=3D MBEDTLS_MD_NONE);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const=
 mbedtls_md_info_t *md_info =3D mbedtls_md_info_from_type(md_type);</span><=
br><span>     const size_t md_size =3D mbedtls_md_get_size(md_info);</span>=
<br><span>     struct buffer fingerprint =3D alloc_buf_gc(md_size, gc);</sp=
an><br><span>     mbedtls_md(md_info, cert-&gt;raw=2Ep, cert-&gt;raw=2Elen,=
 BPTR(&amp;fingerprint));</span><br><span>@@ -517,18 +531,6 @@</span><br><s=
pan>     return fingerprint;</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-struct buffer</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-x509_get_sha1_fingerprint(mbedtls_x509_=
crt *cert, struct gc_arena *gc)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return=
 x509_get_fingerprint(mbedtls_md_info_from_type(MBEDTLS_MD_SHA1), cert, gc)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-struct buffer</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-x509_get_sha256_fingerprint(mbedtls_x509_crt *cert, struct gc_arena *=
gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    return x509_get_fingerprint(mbedtl=
s_md_info_from_type(MBEDTLS_MD_SHA256), cert, gc);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> char *</span><br><span> x509_get_subject(mbedtls=
_x509_crt *cert, struct gc_arena *gc)</span><br><span> {</span><br><span>@@=
 -547,22 +549,6 @@</span><br><span>     return subject;</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-stat=
ic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do_setenv_x509=
(struct env_set *es, const char *name, char *value, int depth)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    char *name_expand;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    size_t name_expand_size;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    string_mod(value, CC_ANY, CC_CRLF, &#39;?&#39;);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    msg(D_X509_ATTR, &quot;X509 ATTR=
IBUTE name=3D&#39;%s&#39; value=3D&#39;%s&#39; depth=3D%d&quot;, name, valu=
e, depth);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    name_ex=
pand_size =3D 64 + strlen(name);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    name_expand =3D (char *)malloc(name_expand_size);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    check_malloc_return(name_exp=
and);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    snprintf(nam=
e_expand, name_expand_size, &quot;X509_%d_%s&quot;, depth, name);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    setenv_str(es, name_expand,=
 value);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    free(name=
_expand);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static char *<=
/span><br><span> asn1_buf_to_c_string(const mbedtls_asn1_buf *orig, struct =
gc_arena *gc)</span><br><span> {</span><br><span>@@ -706,22 +692,13 @@</spa=
n><br><span>     {</span><br><span>         if (depth =3D=3D 0 || (xt-&gt;f=
lags &amp; XT_FULL_CHAIN))</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (0 =3D=3D strcmp(xt-&gt;name=
, &quot;SHA1&quot;) || 0 =3D=3D strcmp(xt-&gt;name, &quot;SHA256&quot;))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            const bool=
 sha1 =3D strcmp(xt-&gt;name, &quot;SHA1&quot;) =3D=3D 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            if (sha1 || strcmp(xt-&gt=
;name, &quot;SHA256&quot;) =3D=3D 0)</span><br><span>             {</span><=
br><span>                 /* Fingerprint is not part of X509 structure */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                struct =
buffer cert_hash;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            char *fingerprint;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    if (0 =3D=3D strcmp(xt-&gt;name, &quot;SHA1&quot;))</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    cert_hash =3D x509_get_=
sha1_fingerprint(cert, &amp;gc);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                else</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                    cert_hash =3D x509_get_sha256_fingerprint(cert, &amp;=
gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                fingerprint =3D</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                const hash_alg=
o_type algo =3D sha1 ? MD_SHA1 : MD_SHA256;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                struct buffer cert_hash =3D x509_ge=
t_fingerprint(cert, algo, &amp;gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                char *fingerprint =3D</span><br><span>     =
                format_hex_ex(BPTR(&amp;cert_hash), BLEN(&amp;cert_hash), 0=
, 1 | FHE_CAPS, &quot;:&quot;, &amp;gc);</span><br><span>                 d=
o_setenv_x509(es, xt-&gt;name, fingerprint, depth);</span><br><span>       =
      }</span><br><span>diff --git a/src/openvpn/ssl_verify_openssl=2Ec b/s=
rc/openvpn/ssl_verify_openssl=2Ec</span><br><span>index 731ab3e=2E=2Ee56eba=
0 100644</span><br><span>--- a/src/openvpn/ssl_verify_openssl=2Ec</span><br=
><span>+++ b/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>@@ -61,7 +6=
1,7 @@</span><br><span>     ASSERT(session);</span><br><span> </span><br><s=
pan>     X509 *current_cert =3D X509_STORE_CTX_get_current_cert(ctx);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer cert_hash=
 =3D x509_get_sha256_fingerprint(current_cert, &amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const struct buffer cert_hash =3D =
x509_get_fingerprint(current_cert, MD_SHA256, &amp;gc);</span><br><span>   =
  cert_hash_remember(session, X509_STORE_CTX_get_error_depth(ctx), &amp;cer=
t_hash);</span><br><span> </span><br><span>     /* did peer present cert wh=
ich was signed by our root cert? */</span><br><span>@@ -360,22 +360,25 @@</=
span><br><span> }</span><br><span> </span><br><span> struct buffer</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-x509_get_sha1_fingerprint(X509=
 *cert, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+x509_get_fingerprint(X509 *cert, hash_algo_type algo, struct gc_ar=
ena *gc)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    const EVP_MD *sha1 =3D EVP_sha1();</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    struct buffer hash =3D alloc_buf_gc((size_t)EVP_=
MD_size(sha1), gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  X509_digest(cert, EVP_sha1(), BPTR(&amp;hash), NULL);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    ASSERT(buf_inc_len(&amp;hash, (int)EV=
P_MD_size(sha1)));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 return hash;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const EVP_MD *md =3D N=
ULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch (alg=
o)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        case MD_SHA1:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            md =3D EVP_sha1()=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-str=
uct buffer</span><br><span style=3D"color: hsl(0, 100%, 40%);">-x509_get_sh=
a256_fingerprint(X509 *cert, struct gc_arena *gc)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    const EVP_MD *sha256 =3D EVP_sha256();</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    struct buffer hash =3D alloc_buf_gc((size_=
t)EVP_MD_size(sha256), gc);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    X509_digest(cert, EVP_sha256(), BPTR(&amp;hash), NULL);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(buf_inc_len(&amp;has=
h, (int)EVP_MD_size(sha256)));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        case MD_SHA256:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            md =3D EVP_sha256();</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    ASSERT(md);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
int md_size =3D EVP_MD_size(md);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct buffer hash =3D alloc_buf_gc((size_t)md_size, gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    X509_digest(cert=
, md, BPTR(&amp;hash), NULL);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    ASSERT(buf_inc_len(&amp;hash, md_size));</span><br><span>    =
 return hash;</span><br><span> }</span><br><span> </span><br><span>@@ -468,=
23 +471,6 @@</span><br><span>     }</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-/* worker method for set=
env_x509_track */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stat=
ic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do_setenv_x509=
(struct env_set *es, const char *name, char *value, int depth)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    char *name_expand;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    size_t name_expand_size;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    string_mod(value, CC_ANY, CC_CRLF, &#39;?&#39;);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    msg(D_X509_ATTR, &quot;X509 ATTR=
IBUTE name=3D&#39;%s&#39; value=3D&#39;%s&#39; depth=3D%d&quot;, name, valu=
e, depth);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    name_ex=
pand_size =3D 64 + strlen(name);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    name_expand =3D (char *)malloc(name_expand_size);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    check_malloc_return(name_exp=
and);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    snprintf(nam=
e_expand, name_expand_size, &quot;X509_%d_%s&quot;, depth, name);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    setenv_str(es, name_expand,=
 value);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    free(name=
_expand);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span><br=
><span> x509_setenv_track(const struct x509_track *xt, struct env_set *es, =
const int depth, X509 *x509)</span><br><span> {</span><br><span>@@ -506,19 =
+492,10 @@</span><br><span>                 case NID_sha1:</span><br><span>=
                 case NID_sha256:</span><br><span>                 {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                    struct b=
uffer fp_buf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            char *fp_str =3D NULL;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            if (xt-&gt;nid =3D=3D NID_sha1)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                        fp_buf =3D x509_get_sha1_fing=
erprint(x509, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                    else</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                        fp_buf =3D x509_get_sha256_fingerprint(x509, &=
amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                    fp_str =3D for=
mat_hex_ex(BPTR(&amp;fp_buf), BLEN(&amp;fp_buf), 0, 1 | FHE_CAPS, &quot;:&q=
uot;, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                const hash_algo_type algo =3D xt-&gt;nid =3D=3D NID_sha1 ? =
MD_SHA1 : MD_SHA256;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    struct buffer fp_buf =3D x509_get_fingerprint(x509, al=
go, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              char *fp_str =3D</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                        format_hex_ex(BPTR(&amp;fp_buf), BLEN(&a=
mp;fp_buf), 0, 1 | FHE_CAPS, &quot;:&quot;, &amp;gc);</span><br><span>     =
                do_setenv_x509(es, xt-&gt;name, fp_str, depth);</span><br><=
span>                 }</span><br><span>                 break;</span><br><=
span>diff --git a/tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec b/test=
s/unit_tests/openvpn/mock_ssl_dependencies=2Ec</span><br><span>index b22dd8=
9=2E=2E65e4635 100644</span><br><span>--- a/tests/unit_tests/openvpn/mock_s=
sl_dependencies=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/mock_ssl=
_dependencies=2Ec</span><br><span>@@ -64,3 +64,9 @@</span><br><span> {</spa=
n><br><span>     return FAILURE;</span><br><span> }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
do_setenv_x509(struct env_set *es, const char *name, char *value, int depth=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_false(true);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br></pre><p>To view, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2145?usp=3Demail"=
>change 2145</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
45?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: I76cd424b34e91f07a6d187b23a258d9dcbf7ed0f </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 2145 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</bod=
y></html>
--tPnNYlyTMz0=--


--===============7774674531494965910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7774674531494965910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7774674531494965910==--

