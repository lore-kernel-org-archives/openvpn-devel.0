Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859BA606A326
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kQvcpRPa;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=V5adfIJe;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cYWoCE1I;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=fR2jWXNm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=BnyDUzDUd8jXqnxhqOksPXSYRxeNmLz3/JOpXkAeFBo=; b=kQvcpRPaeLIxnWXSsaBG1CUuOh
	958yNPZyqzP0+QTEvKjtwvJVDcx8QN/+81UwXdSVxynd7QXqWyPqUTT39+44lkGWrM/1s2HLxXpxw
	UbWB61ufnGHZT0PomDv5Px3K41Dq50CtphhpR22N/DX2dZlIW5OARrfnlPiueavItDM0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPGPG-0000000035M-0Gmk;
	Fri, 06 Nov 2026 09:38:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPGPE-0000000035G-0xhf
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 09:38:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iE8a0wm31iCDJeU1O5j6tb86ZPKBicyE0c9bbue47Cc=; b=V5adfIJein77VeoL03IH1VC302
 CNr3E4d/f/uyP88qDWdciLoJeH/Bj9HZdusMuZk7dmmHbt85cUSYFA+VBRH5GX+7i07r6TlbDxP7W
 w9uS+BIZWtE/DS0EQqkQokW+W5KVeZ+hMCyF8e93HEnt4H5nof7Zumw79e0pM90+zoT4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iE8a0wm31iCDJeU1O5j6tb86ZPKBicyE0c9bbue47Cc=; b=cYWoCE1IL5ZRFERz9+VQCeFFEA
 MWKzZ563wYCrp2REse1gg+grqiiTtb4EoC8l26PJnHr0rpZvdVnNDx1o9Ypa7BG0Iqcc7nlXJO7Ld
 axjK3T2yGbROqCvf6PtrUD+l+7eIOFlftzGxCBtM/bdxqvQRsmo/VXMPq80F+5OEtE4E=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPGPA-0000000011X-0Nci for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 09:38:44 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-490c1d337d8so255760f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 01:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793957913; x=1794562713; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iE8a0wm31iCDJeU1O5j6tb86ZPKBicyE0c9bbue47Cc=;
 b=fR2jWXNmtqryh77sMHKMKbjxUbbdkLXfDSDwCZa46eDKcK5bqMpkajGrHTSF4oFzlQ
 dSk1f8KTe3fg5kibzuLTw0h71FUvg5o6YMPh+Rh0Up+RQ9/bur0fKRBSBQnMQZwzxQy/
 R62jZES0uVtiEhnoLIDlAj2e/pPfRAoAPNoW4IAOC9twdQM7ECcpsrCtroIAjEghsp83
 GVuDchjX2KYbXAW9eMNbeLQLjdSW3r3JHeRVdZy45lqI5l2HLQR41b68TuCW5rDaz2Gl
 pOkNezUrJ/LZRZwC+tJm2uMl8GY1B3skc+GIRqRpN/6m+ZxsD4LjekAz8XzSZCfkUVKo
 4Rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793957913; x=1794562713;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iE8a0wm31iCDJeU1O5j6tb86ZPKBicyE0c9bbue47Cc=;
 b=DP8lhw1BujwRNOW25Oh7e6fiku2DfKeJwmdlzvk5jxDt4Aj50wlZ99hi9Lcv3nrOLH
 Da9r8ITUijd7P8VxkMtTCIxfxDvoPYbxtsNXHt9ZHTbbTv1cqEVKkCIqVVIyVpxK7Vqo
 /7vBqpqQ7fZU4VcFlJnvVs8wRIvqfhALb4zsllbHyO2xiPWDQcxSCSLrmwTb+JuaLMaN
 OB6GdwojN3WvI7YzLQ/RS4CQRnUxD9QnryWlWDdaQbbxY+3pDMyebhiQSHNWE3g33p/w
 BYbZg1ds1Crm2mQOk1ga8ygigKs8L3Aa56CHVnbp3pDCfdMjKwyPmub7pb9FaA5naOo5
 GppA==
X-Gm-Message-State: APuU4Z/UdL2FiSTXgMPyNONkuPpVujE4VZqeCXf/Pw2/POE1OBOtgcnx
 zH54/rJSr64vjNU5QmVNRxTtgWXml344eEeE+GwQupLX7RGldgr8b40B93CJwnrBl5U5UTJieWW
 M+vQ5Scf9eHUVdLk2DYZZSXDHF3E3v/LMF1cUxNJ8eiiOmWuOQA06fwz4QjJYoXVN6RE8lfvReI
 bK4YgL9w==
X-Gm-Gg: AYBFou0DNdis97aMU9NTxq/J9AxTyLjtjYisNLZVozTqUIwTe4pAz0QUw5BX1DSPppv
 xVy76VERhW3YPXly/zGxIhgtgOv05mUmOOebn9Voo8kl+mYUz2ydEJ7QIXHHzDUyW7lTGGbkxDE
 laoU7ykIuqceHCAymBfN3lAieXP4lnoLq2dvAG6W7U/EMubqvQrhgpcX9CKSgEq5VoOb/vORULP
 LjYfkv7CnUP0vxBWUvBwlGVv9OOsXTVCSeFhWCa0+2gigRZ+0uVAdHK7tyLZ6tFU7o5HsGRLxir
 psn6OIyi/Nx2tS3cAaT9cKCGDTTL/kztSHPa5yeagHszzWXVxoTaXIXhl6asM8JcWe6BgI2QiDY
 TBCIEk15f9wwvYV2vgRcOlNVv7nfKQIa9+34U7mv88tmhkSdwhjMnwjMY9LTqGK0h/wBd0wmIFb
 IhJhw6ODmJCa6XWpKpcrcyrdcf7gFZrjMG08jUFQ9ODY/XdSOo1SzzwV0XbVXyatdbEWNQbaHCx
 rQt7lU5F3YXmxEbHBWFfXdNUC6WhWVmXoIuG3jnfrs8iK7y4FyW0dMwI25wSAN33HB8zc6V8PxP
 3+DQK3KfF3PAsmgHC/9dP0wPORcDzknSD8LY7l/sa/oYJGLWFSFGqshOhz9+dfybzK3wcFfC1jH
 axMczToPQwDdPKH/dIr8aQQes9yfm9kA167oT+1FNSxko8/hFj98nAu+z9B/7zFvP5UFd4+hPRA
 D+e3TjpmHCUkd5KQ==
X-Received: by 2002:a05:6000:4a07:b0:48f:dc98:cf0b with SMTP id
 ffacd0b85a97d-4927efe3573mr3202014f8f.35.1793957913137; 
 Fri, 06 Nov 2026 01:38:33 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d3d609c8sm2862604f8f.6.2026.11.06.01.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 01:38:32 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 09:38:32 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I76cd424b34e91f07a6d187b23a258d9dcbf7ed0f
X-Gerrit-Change-Number: 2145
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2145?usp=email>
X-Gerrit-Commit: ed6d6e0d2cf544637ceadd065a29caccec2fd233
References: <gerrit.1793957909000.I76cd424b34e91f07a6d187b23a258d9dcbf7ed0f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzOTU3OTA5MDAwLkk3NmNkNDI0YjM0ZTkxZjA3YTZkMTg3YjIzYTI1OGQ5ZGNiZjdlZDBmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <938ac618c4d3c4f443d98970112e89d90776d2c8-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPGPA-0000000011X-0Nci
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
Content-Type: multipart/mixed; boundary="===============5833318061300588244=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5833318061300588244==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MQifkSM2JQg="; charset=UTF-8

--MQifkSM2JQg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2145?usp=3Demail

to review the following change=2E
=


Change subject: ssl_verify: share fingerprint and x509 env helpers betwee=
n backends
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

s=
sl_verify: share fingerprint and x509 env helpers between backends

Replace=
 x509_get_sha1_fingerprint() and x509_get_sha256_fingerprint()
with x509_ge=
t_fingerprint(cert, algo, gc) in both backends=2E This also
removes the swi=
tch in verify_cert(), whose default case could not be
reached, as verify_ha=
sh_algo is always MD_SHA1 or MD_SHA256=2E The
backends now switch over the =
enum without a default, so a new
algorithm gets a -Wswitch warning, and ASS=
ERT on unknown values=2E

Move the identical do_setenv_x509() copies from t=
he backends to
ssl_verify=2Ec, with a stub for test_ssl as for verify_cert(=
)=2E

Change-Id: I76cd424b34e91f07a6d187b23a258d9dcbf7ed0f
Signed-off-by: R=
azvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/ssl_verify=2Ec
M s=
rc/openvpn/ssl_verify_backend=2Eh
M src/openvpn/ssl_verify_mbedtls=2Ec
M sr=
c/openvpn/ssl_verify_openssl=2Ec
M tests/unit_tests/openvpn/mock_ssl_depend=
encies=2Ec
5 files changed, 85 insertions(+), 131 deletions(-)



  git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/45/2145/1

diff -=
-git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index 0cdec1=
e=2E=2Ee516fb0 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ss=
l_verify=2Ec
@@ -53,6 +53,22 @@
     string_mod(str, CC_PRINT, CC_CRLF, '_'=
);
 }
 
+void
+do_setenv_x509(struct env_set *es, const char *name, char *v=
alue, int depth)
+{
+    char *name_expand;
+    size_t name_expand_size;
+=

+    string_mod(value, CC_ANY, CC_CRLF, '?');
+    msg(D_X509_ATTR, "X509 =
ATTRIBUTE name=3D'%s' value=3D'%s' depth=3D%d", name, value, depth);
+    n=
ame_expand_size =3D 64 + strlen(name);
+    name_expand =3D (char *)malloc(=
name_expand_size);
+    check_malloc_return(name_expand);
+    snprintf(nam=
e_expand, name_expand_size, "X509_%d_%s", depth, name);
+    setenv_str(es,=
 name_expand, value);
+    free(name_expand);
+}
+
 /*
  * Export the untru=
sted IP address and port to the environment
  */
@@ -428,8 +444,8 @@
 
    =
 /* export X509 cert fingerprints */
     {
-        struct buffer sha1 =3D=
 x509_get_sha1_fingerprint(peer_cert, &gc);
-        struct buffer sha256 =
=3D x509_get_sha256_fingerprint(peer_cert, &gc);
+        struct buffer sha=
1 =3D x509_get_fingerprint(peer_cert, MD_SHA1, &gc);
+        struct buffer=
 sha256 =3D x509_get_fingerprint(peer_cert, MD_SHA256, &gc);
 
         snp=
rintf(envname, sizeof(envname), "tls_digest_%d", cert_depth);
         sete=
nv_str(es, envname, format_hex_ex(BPTR(&sha1), BLEN(&sha1), 0, 1, ":", &gc)=
);
@@ -671,32 +687,7 @@
 
     if (cert_depth =3D=3D opt->verify_hash_depth=
 && opt->verify_hash)
     {
-        struct buffer cert_fp =3D { 0 };
-
- =
       switch (opt->verify_hash_algo)
-        {
-            case MD_SHA1:=

-                cert_fp =3D x509_get_sha1_fingerprint(cert, &gc);
-      =
          break;
-
-            case MD_SHA256:
-                cert_fp =
=3D x509_get_sha256_fingerprint(cert, &gc);
-                break;
-
-    =
        default:
-                /* This should normally not happen at all=
; the algorithm used
-                 * is parsed by add_option() [options=
=2Ec] and set to a predefined
-                 * value in an enumerated ty=
pe=2E  So if this unlikely scenario
-                 * happens, consider t=
his a failure
-                 */
-                msg(M_WARN,
-          =
          "Unexpected invalid algorithm used with "
-                    "-=
-verify-hash (%i)",
-                    opt->verify_hash_algo);
-         =
       ret =3D FAILURE;
-                goto cleanup;
-        }
-
+      =
  struct buffer cert_fp =3D x509_get_fingerprint(cert, opt->verify_hash_alg=
o, &gc);
         const struct verify_hash_list *current_hash =3D opt->veri=
fy_hash;
 
         while (current_hash)
diff --git a/src/openvpn/ssl_verif=
y_backend=2Eh b/src/openvpn/ssl_verify_backend=2Eh
index 46720d6=2E=2E93916=
b7 100644
--- a/src/openvpn/ssl_verify_backend=2Eh
+++ b/src/openvpn/ssl_ve=
rify_backend=2Eh
@@ -75,6 +75,17 @@
                         const struct b=
uffer *cert_hash);
 
 /*
+ * Export an X509 attribute as the X509_<depth>_<=
name> environment variable,
+ * replacing CR and LF in value with '?'=2E
+ =
*
+ * @param es            Environment set to add the variable to
+ * @para=
m name          Attribute name
+ * @param value         Attribute value, mo=
dified in place
+ * @param depth         Depth of the certificate the attri=
bute belongs to
+ */
+void do_setenv_x509(struct env_set *es, const char *n=
ame, char *value, int depth);
+
+/*
  * Library-specific functions=2E
  *
 =
 * The following functions must be implemented on a library-specific basis=
=2E
@@ -91,24 +102,16 @@
 char *x509_get_subject(openvpn_x509_cert_t *cert,=
 struct gc_arena *gc);
 
 /**
- * Retrieve the certificate's SHA1 fingerpri=
nt=2E
+ * Retrieve the certificate's fingerprint=2E
  *
  * @param cert    =
      Certificate to retrieve the fingerprint from=2E
+ * @param algo      =
    Hash algorithm to use=2E
  * @param gc            Garbage collection ar=
ena to use when allocating string=2E
  *
- * @return              a string =
containing the certificate fingerprint
+ * @return              a buffer co=
ntaining the certificate fingerprint
  */
-struct buffer x509_get_sha1_fing=
erprint(openvpn_x509_cert_t *cert, struct gc_arena *gc);
-
-/**
- * Retriev=
e the certificate's SHA256 fingerprint=2E
- *
- * @param cert          Cert=
ificate to retrieve the fingerprint from=2E
- * @param gc            Garbag=
e collection arena to use when allocating string=2E
- *
- * @return        =
      a string containing the certificate fingerprint
- */
-struct buffer x=
509_get_sha256_fingerprint(openvpn_x509_cert_t *cert, struct gc_arena *gc);=

+struct buffer x509_get_fingerprint(openvpn_x509_cert_t *cert, hash_algo_t=
ype algo,
+                                   struct gc_arena *gc);
 
 /*
 =
 * Retrieve the certificate's username from the specified field=2E
diff --g=
it a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=2E=
c
index a132f12=2E=2Ecc4afb3 100644
--- a/src/openvpn/ssl_verify_mbedtls=2E=
c
+++ b/src/openvpn/ssl_verify_mbedtls=2Ec
@@ -55,7 +55,7 @@
     session->=
verified =3D false;
 
     /* Remember certificate hash */
-    struct buff=
er cert_fingerprint =3D x509_get_sha256_fingerprint(cert, &gc);
+    struct=
 buffer cert_fingerprint =3D x509_get_fingerprint(cert, MD_SHA256, &gc);
  =
   cert_hash_remember(session, cert_depth, &cert_fingerprint);
 
     if (s=
ession->opt->verify_hash_no_ca)
@@ -502,9 +502,23 @@
     return FAILURE;
 =
}
 
-static struct buffer
-x509_get_fingerprint(const mbedtls_md_info_t *md=
_info, mbedtls_x509_crt *cert, struct gc_arena *gc)
+struct buffer
+x509_ge=
t_fingerprint(mbedtls_x509_crt *cert, hash_algo_type algo, struct gc_arena =
*gc)
 {
+    mbedtls_md_type_t md_type =3D MBEDTLS_MD_NONE;
+    switch (al=
go)
+    {
+        case MD_SHA1:
+            md_type =3D MBEDTLS_MD_SHA1;=

+            break;
+
+        case MD_SHA256:
+            md_type =3D MB=
EDTLS_MD_SHA256;
+            break;
+    }
+    ASSERT(md_type !=3D MBEDTL=
S_MD_NONE);
+
+    const mbedtls_md_info_t *md_info =3D mbedtls_md_info_fro=
m_type(md_type);
     const size_t md_size =3D mbedtls_md_get_size(md_info)=
;
     struct buffer fingerprint =3D alloc_buf_gc(md_size, gc);
     mbedtl=
s_md(md_info, cert->raw=2Ep, cert->raw=2Elen, BPTR(&fingerprint));
@@ -512,=
18 +526,6 @@
     return fingerprint;
 }
 
-struct buffer
-x509_get_sha1_fi=
ngerprint(mbedtls_x509_crt *cert, struct gc_arena *gc)
-{
-    return x509_=
get_fingerprint(mbedtls_md_info_from_type(MBEDTLS_MD_SHA1), cert, gc);
-}
-=

-struct buffer
-x509_get_sha256_fingerprint(mbedtls_x509_crt *cert, struct=
 gc_arena *gc)
-{
-    return x509_get_fingerprint(mbedtls_md_info_from_typ=
e(MBEDTLS_MD_SHA256), cert, gc);
-}
-
 char *
 x509_get_subject(mbedtls_x50=
9_crt *cert, struct gc_arena *gc)
 {
@@ -542,22 +544,6 @@
     return subje=
ct;
 }
 
-static void
-do_setenv_x509(struct env_set *es, const char *name,=
 char *value, int depth)
-{
-    char *name_expand;
-    size_t name_expand=
_size;
-
-    string_mod(value, CC_ANY, CC_CRLF, '?');
-    msg(D_X509_ATTR=
, "X509 ATTRIBUTE name=3D'%s' value=3D'%s' depth=3D%d", name, value, depth)=
;
-    name_expand_size =3D 64 + strlen(name);
-    name_expand =3D (char *=
)malloc(name_expand_size);
-    check_malloc_return(name_expand);
-    snpr=
intf(name_expand, name_expand_size, "X509_%d_%s", depth, name);
-    setenv=
_str(es, name_expand, value);
-    free(name_expand);
-}
-
 static char *
 =
asn1_buf_to_c_string(const mbedtls_asn1_buf *orig, struct gc_arena *gc)
 {
=
@@ -701,22 +687,13 @@
     {
         if (depth =3D=3D 0 || (xt->flags & XT=
_FULL_CHAIN))
         {
-            if (0 =3D=3D strcmp(xt->name, "SHA1")=
 || 0 =3D=3D strcmp(xt->name, "SHA256"))
+            bool sha1 =3D strcmp(=
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
    hash_algo_type algo =3D sha1 ? MD_SHA1 : MD_SHA256;
+                st=
ruct buffer cert_hash =3D x509_get_fingerprint(cert, algo, &gc);
+         =
       char *fingerprint =3D
                     format_hex_ex(BPTR(&cert_=
hash), BLEN(&cert_hash), 0, 1 | FHE_CAPS, ":", &gc);
                 do_se=
tenv_x509(es, xt->name, fingerprint, depth);
             }
diff --git a/sr=
c/openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_verify_openssl=2Ec
index=
 0c36cf2=2E=2Ead02bb0 100644
--- a/src/openvpn/ssl_verify_openssl=2Ec
+++ b=
/src/openvpn/ssl_verify_openssl=2Ec
@@ -61,7 +61,7 @@
     ASSERT(session);=

 
     X509 *current_cert =3D X509_STORE_CTX_get_current_cert(ctx);
-    s=
truct buffer cert_hash =3D x509_get_sha256_fingerprint(current_cert, &gc);
=
+    struct buffer cert_hash =3D x509_get_fingerprint(current_cert, MD_SHA2=
56, &gc);
     cert_hash_remember(session, X509_STORE_CTX_get_error_depth(c=
tx), &cert_hash);
 
     /* did peer present cert which was signed by our r=
oot cert? */
@@ -356,22 +356,25 @@
 }
 
 struct buffer
-x509_get_sha1_finge=
rprint(X509 *cert, struct gc_arena *gc)
+x509_get_fingerprint(X509 *cert, h=
ash_algo_type algo, struct gc_arena *gc)
 {
-    const EVP_MD *sha1 =3D EVP=
_sha1();
-    struct buffer hash =3D alloc_buf_gc((size_t)EVP_MD_size(sha1)=
, gc);
-    X509_digest(cert, EVP_sha1(), BPTR(&hash), NULL);
-    ASSERT(b=
uf_inc_len(&hash, (int)EVP_MD_size(sha1)));
-    return hash;
-}
+    const=
 EVP_MD *md =3D NULL;
+    switch (algo)
+    {
+        case MD_SHA1:
+   =
         md =3D EVP_sha1();
+            break;
 
-struct buffer
-x509_get_=
sha256_fingerprint(X509 *cert, struct gc_arena *gc)
-{
-    const EVP_MD *s=
ha256 =3D EVP_sha256();
-    struct buffer hash =3D alloc_buf_gc((size_t)EV=
P_MD_size(sha256), gc);
-    X509_digest(cert, EVP_sha256(), BPTR(&hash), N=
ULL);
-    ASSERT(buf_inc_len(&hash, (int)EVP_MD_size(sha256)));
+        c=
ase MD_SHA256:
+            md =3D EVP_sha256();
+            break;
+    }=

+    ASSERT(md);
+
+    const int md_size =3D EVP_MD_size(md);
+    struct=
 buffer hash =3D alloc_buf_gc((size_t)md_size, gc);
+    X509_digest(cert, =
md, BPTR(&hash), NULL);
+    ASSERT(buf_inc_len(&hash, md_size));
     retu=
rn hash;
 }
 
@@ -464,23 +467,6 @@
     }
 }
 
-/* worker method for setenv=
_x509_track */
-static void
-do_setenv_x509(struct env_set *es, const char =
*name, char *value, int depth)
-{
-    char *name_expand;
-    size_t name_=
expand_size;
-
-    string_mod(value, CC_ANY, CC_CRLF, '?');
-    msg(D_X50=
9_ATTR, "X509 ATTRIBUTE name=3D'%s' value=3D'%s' depth=3D%d", name, value, =
depth);
-    name_expand_size =3D 64 + strlen(name);
-    name_expand =3D (=
char *)malloc(name_expand_size);
-    check_malloc_return(name_expand);
-  =
  snprintf(name_expand, name_expand_size, "X509_%d_%s", depth, name);
-    =
setenv_str(es, name_expand, value);
-    free(name_expand);
-}
-
 void
 x50=
9_setenv_track(const struct x509_track *xt, struct env_set *es, const int d=
epth, X509 *x509)
 {
@@ -502,19 +488,10 @@
                 case NID_sha1:
=
                 case NID_sha256:
                 {
-                    s=
truct buffer fp_buf;
-                    char *fp_str =3D NULL;
-
-       =
             if (xt->nid =3D=3D NID_sha1)
-                    {
-         =
               fp_buf =3D x509_get_sha1_fingerprint(x509, &gc);
-          =
          }
-                    else
-                    {
-             =
           fp_buf =3D x509_get_sha256_fingerprint(x509, &gc);
-            =
        }
-
-                    fp_str =3D format_hex_ex(BPTR(&fp_buf), BL=
EN(&fp_buf), 0, 1 | FHE_CAPS, ":", &gc);
+                    hash_algo_typ=
e algo =3D xt->nid =3D=3D NID_sha1 ? MD_SHA1 : MD_SHA256;
+                =
    struct buffer fp_buf =3D x509_get_fingerprint(x509, algo, &gc);
+      =
              char *fp_str =3D
+                        format_hex_ex(BPTR(=
&fp_buf), BLEN(&fp_buf), 0, 1 | FHE_CAPS, ":", &gc);
                     d=
o_setenv_x509(es, xt->name, fp_str, depth);
                 }
            =
     break;
diff --git a/tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec=
 b/tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec
index b22dd89=2E=2E65=
e4635 100644
--- a/tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec
+++ b=
/tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec
@@ -64,3 +64,9 @@
 {
  =
   return FAILURE;
 }
+
+void
+do_setenv_x509(struct env_set *es, const cha=
r *name, char *value, int depth)
+{
+    assert_false(true);
+}

-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2145?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I76cd424b34e91f07a6d187b23a=
258d9dcbf7ed0f
Gerrit-Change-Number: 2145
Gerrit-PatchSet: 1
Gerrit-Owner: =
R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>

--MQifkSM2JQg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2145?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">ssl_verify: share fingerprint and x509 env helpers betw=
een backends<br><br>Replace x509_get_sha1_fingerprint() and x509_get_sha256=
_fingerprint()<br>with x509_get_fingerprint(cert, algo, gc) in both backend=
s=2E This also<br>removes the switch in verify_cert(), whose default case c=
ould not be<br>reached, as verify_hash_algo is always MD_SHA1 or MD_SHA256=
=2E The<br>backends now switch over the enum without a default, so a new<br=
>algorithm gets a -Wswitch warning, and ASSERT on unknown values=2E<br><br>=
Move the identical do_setenv_x509() copies from the backends to<br>ssl_veri=
fy=2Ec, with a stub for test_ssl as for verify_cert()=2E<br><br>Change-Id: =
I76cd424b34e91f07a6d187b23a258d9dcbf7ed0f<br>Signed-off-by: Razvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/ssl_verify=2Ec<br>M =
src/openvpn/ssl_verify_backend=2Eh<br>M src/openvpn/ssl_verify_mbedtls=2Ec<=
br>M src/openvpn/ssl_verify_openssl=2Ec<br>M tests/unit_tests/openvpn/mock_=
ssl_dependencies=2Ec<br>5 files changed, 85 insertions(+), 131 deletions(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/45/2145/1</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_verify=2Ec=
 b/src/openvpn/ssl_verify=2Ec</span><br><span>index 0cdec1e=2E=2Ee516fb0 10=
0644</span><br><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b=
/src/openvpn/ssl_verify=2Ec</span><br><span>@@ -53,6 +53,22 @@</span><br><s=
pan>     string_mod(str, CC_PRINT, CC_CRLF, &#39;_&#39;);</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+do_setenv_x509(=
struct env_set *es, const char *name, char *value, int depth)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    char *name_expand;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    size_t name_expand_size;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    string_mod(value, CC_ANY, CC_CRLF, &#39;?&#39;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_X509_ATTR, &quo=
t;X509 ATTRIBUTE name=3D&#39;%s&#39; value=3D&#39;%s&#39; depth=3D%d&quot;,=
 name, value, depth);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    name_expand_size =3D 64 + strlen(name);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    name_expand =3D (char *)malloc(name_expand_si=
ze);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_mallo=
c_return(name_expand);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    snprintf(name_expand, name_expand_size, &quot;X509_%d_%s&quot;, dept=
h, name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    setenv=
_str(es, name_expand, value);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    free(name_expand);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> /*</span><br><span>  * Export the untrusted IP address and por=
t to the environment</span><br><span>  */</span><br><span>@@ -428,8 +444,8 =
@@</span><br><span> </span><br><span>     /* export X509 cert fingerprints =
*/</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        struct buffer sha1 =3D x509_get_sha1_fingerprint(peer_cert, &am=
p;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct =
buffer sha256 =3D x509_get_sha256_fingerprint(peer_cert, &amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        struct buffer sha1 =
=3D x509_get_fingerprint(peer_cert, MD_SHA1, &amp;gc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        struct buffer sha256 =3D x509_ge=
t_fingerprint(peer_cert, MD_SHA256, &amp;gc);</span><br><span> </span><br><=
span>         snprintf(envname, sizeof(envname), &quot;tls_digest_%d&quot;,=
 cert_depth);</span><br><span>         setenv_str(es, envname, format_hex_e=
x(BPTR(&amp;sha1), BLEN(&amp;sha1), 0, 1, &quot;:&quot;, &amp;gc));</span><=
br><span>@@ -671,32 +687,7 @@</span><br><span> </span><br><span>     if (ce=
rt_depth =3D=3D opt-&gt;verify_hash_depth &amp;&amp; opt-&gt;verify_hash)</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        struct buffer cert_fp =3D { 0 };</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      switch (opt-&gt;verify_hash_algo)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            case MD_SHA1:</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                cert_fp =3D x509_get_sha1_fingerprint(cert, &amp;=
gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                b=
reak;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            case MD_SHA256:</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                cert_fp =3D x50=
9_get_sha256_fingerprint(cert, &amp;gc);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                break;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           default:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              /* This should normally not happen at all; the algorithm used=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 * is=
 parsed by add_option() [options=2Ec] and set to a predefined</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                 * value in an enum=
erated type=2E  So if this unlikely scenario</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                 * happens, consider this a failure<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(M_WA=
RN,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
  &quot;Unexpected invalid algorithm used with &quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    &quot;--verify-hash (%i=
)&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
       opt-&gt;verify_hash_algo);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                ret =3D FAILURE;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                goto cleanup;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        struct buffer cert_fp =3D x509_get_fingerprint(cert, opt-&gt;verif=
y_hash_algo, &amp;gc);</span><br><span>         const struct verify_hash_li=
st *current_hash =3D opt-&gt;verify_hash;</span><br><span> </span><br><span=
>         while (current_hash)</span><br><span>diff --git a/src/openvpn/ssl=
_verify_backend=2Eh b/src/openvpn/ssl_verify_backend=2Eh</span><br><span>in=
dex 46720d6=2E=2E93916b7 100644</span><br><span>--- a/src/openvpn/ssl_verif=
y_backend=2Eh</span><br><span>+++ b/src/openvpn/ssl_verify_backend=2Eh</spa=
n><br><span>@@ -75,6 +75,17 @@</span><br><span>                         con=
st struct buffer *cert_hash);</span><br><span> </span><br><span> /*</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * Export an X509 attribute=
 as the X509_&lt;depth&gt;_&lt;name&gt; environment variable,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * replacing CR and LF in value w=
ith &#39;?&#39;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param es      =
      Environment set to add the variable to</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param name          Attribute name</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param value         Attribu=
te value, modified in place</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param depth         Depth of the certificate the attribute belo=
ngs to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void do_setenv_x509(struct en=
v_set *es, const char *name, char *value, int depth);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/*</span><br><span>  * Library-specific functions=2E</span><=
br><span>  *</span><br><span>  * The following functions must be implemente=
d on a library-specific basis=2E</span><br><span>@@ -91,24 +102,16 @@</span=
><br><span> char *x509_get_subject(openvpn_x509_cert_t *cert, struct gc_are=
na *gc);</span><br><span> </span><br><span> /**</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * Retrieve the certificate&#39;s SHA1 fingerprin=
t=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Retrieve the=
 certificate&#39;s fingerprint=2E</span><br><span>  *</span><br><span>  * @=
param cert          Certificate to retrieve the fingerprint from=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param algo          Has=
h algorithm to use=2E</span><br><span>  * @param gc            Garbage coll=
ection arena to use when allocating string=2E</span><br><span>  *</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * @return              a strin=
g containing the certificate fingerprint</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @return              a buffer containing the certif=
icate fingerprint</span><br><span>  */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-struct buffer x509_get_sha1_fingerprint(openvpn_x509_cert_=
t *cert, struct gc_arena *gc);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * Retrieve the certificate&#3=
9;s SHA256 fingerprint=2E</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param cert =
         Certificate to retrieve the fingerprint from=2E</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * @param gc            Garbage collecti=
on arena to use when allocating string=2E</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * @return              a string containing the certificate fingerprint</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-struct buffer x509_get_sha256_fingerprint(=
openvpn_x509_cert_t *cert, struct gc_arena *gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+struct buffer x509_get_fingerprint(openvpn_x50=
9_cert_t *cert, hash_algo_type algo,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                   struct gc_arena *gc);</=
span><br><span> </span><br><span> /*</span><br><span>  * Retrieve the certi=
ficate&#39;s username from the specified field=2E</span><br><span>diff --gi=
t a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec=
</span><br><span>index a132f12=2E=2Ecc4afb3 100644</span><br><span>--- a/sr=
c/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_veri=
fy_mbedtls=2Ec</span><br><span>@@ -55,7 +55,7 @@</span><br><span>     sessi=
on-&gt;verified =3D false;</span><br><span> </span><br><span>     /* Rememb=
er certificate hash */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    struct buffer cert_fingerprint =3D x509_get_sha256_fingerprint(cert, &=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
buffer cert_fingerprint =3D x509_get_fingerprint(cert, MD_SHA256, &amp;gc);=
</span><br><span>     cert_hash_remember(session, cert_depth, &amp;cert_fin=
gerprint);</span><br><span> </span><br><span>     if (session-&gt;opt-&gt;v=
erify_hash_no_ca)</span><br><span>@@ -502,9 +502,23 @@</span><br><span>    =
 return FAILURE;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static struct buffer</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-x509_get_fingerprint(const mbedtls_md_info_=
t *md_info, mbedtls_x509_crt *cert, struct gc_arena *gc)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+struct buffer</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+x509_get_fingerprint(mbedtls_x509_crt *cert,=
 hash_algo_type algo, struct gc_arena *gc)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    mbedtls_md_type_t md_type =3D=
 MBEDTLS_MD_NONE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  switch (algo)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case MD_SH=
A1:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            md_t=
ype =3D MBEDTLS_MD_SHA1;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            break;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case MD=
_SHA256:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 md_type =3D MBEDTLS_MD_SHA256;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            break;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 ASSERT(md_type !=3D MBEDTLS_MD_NONE);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const mbedtls_md_info_t *md_info =3D mbedtls_md_info_from_type(md_type)=
;</span><br><span>     const size_t md_size =3D mbedtls_md_get_size(md_info=
);</span><br><span>     struct buffer fingerprint =3D alloc_buf_gc(md_size,=
 gc);</span><br><span>     mbedtls_md(md_info, cert-&gt;raw=2Ep, cert-&gt;r=
aw=2Elen, BPTR(&amp;fingerprint));</span><br><span>@@ -512,18 +526,6 @@</sp=
an><br><span>     return fingerprint;</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct buffer</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-x509_get_sha1_fingerprint(mbed=
tls_x509_crt *cert, struct gc_arena *gc)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   return x509_get_fingerprint(mbedtls_md_info_from_type(MBEDTLS_MD_SHA1), =
cert, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-struct buffer</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-x509_get_sha256_fingerprint(mbedtls_x509_crt *cert, struct g=
c_arena *gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    return x509_get_fingerpri=
nt(mbedtls_md_info_from_type(MBEDTLS_MD_SHA256), cert, gc);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span> char *</span><br><span> x509_get_subjec=
t(mbedtls_x509_crt *cert, struct gc_arena *gc)</span><br><span> {</span><br=
><span>@@ -542,22 +544,6 @@</span><br><span>     return subject;</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do_se=
tenv_x509(struct env_set *es, const char *name, char *value, int depth)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    char *name_expand;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    size_t name_expand_size;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    string_mod(value, CC_ANY, CC_CRLF, &#39;?&#39;);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_X509_ATTR, &quo=
t;X509 ATTRIBUTE name=3D&#39;%s&#39; value=3D&#39;%s&#39; depth=3D%d&quot;,=
 name, value, depth);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    name_expand_size =3D 64 + strlen(name);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    name_expand =3D (char *)malloc(name_expand_size);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    check_malloc_retu=
rn(name_expand);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
nprintf(name_expand, name_expand_size, &quot;X509_%d_%s&quot;, depth, name)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    setenv_str(es, n=
ame_expand, value);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  free(name_expand);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> sta=
tic char *</span><br><span> asn1_buf_to_c_string(const mbedtls_asn1_buf *or=
ig, struct gc_arena *gc)</span><br><span> {</span><br><span>@@ -701,22 +687=
,13 @@</span><br><span>     {</span><br><span>         if (depth =3D=3D 0 |=
| (xt-&gt;flags &amp; XT_FULL_CHAIN))</span><br><span>         {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            if (0 =3D=3D strcmp(=
xt-&gt;name, &quot;SHA1&quot;) || 0 =3D=3D strcmp(xt-&gt;name, &quot;SHA256=
&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 bool sha1 =3D strcmp(xt-&gt;name, &quot;SHA1&quot;) =3D=3D 0;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            if (sha1 || strcmp(x=
t-&gt;name, &quot;SHA256&quot;) =3D=3D 0)</span><br><span>             {</s=
pan><br><span>                 /* Fingerprint is not part of X509 structure=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                st=
ruct buffer cert_hash;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                char *fingerprint;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         if (0 =3D=3D strcmp(xt-&gt;name, &quot;SHA1&quot;))</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                    cert_hash =3D x509_g=
et_sha1_fingerprint(cert, &amp;gc);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                else</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                    cert_hash =3D x509_get_sha256_fingerprint(cert, &a=
mp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                fingerprint =3D</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                hash_algo_t=
ype algo =3D sha1 ? MD_SHA1 : MD_SHA256;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                struct buffer cert_hash =3D x509_get_f=
ingerprint(cert, algo, &amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                char *fingerprint =3D</span><br><span>        =
             format_hex_ex(BPTR(&amp;cert_hash), BLEN(&amp;cert_hash), 0, 1=
 | FHE_CAPS, &quot;:&quot;, &amp;gc);</span><br><span>                 do_s=
etenv_x509(es, xt-&gt;name, fingerprint, depth);</span><br><span>          =
   }</span><br><span>diff --git a/src/openvpn/ssl_verify_openssl=2Ec b/src/=
openvpn/ssl_verify_openssl=2Ec</span><br><span>index 0c36cf2=2E=2Ead02bb0 1=
00644</span><br><span>--- a/src/openvpn/ssl_verify_openssl=2Ec</span><br><s=
pan>+++ b/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>@@ -61,7 +61,7=
 @@</span><br><span>     ASSERT(session);</span><br><span> </span><br><span=
>     X509 *current_cert =3D X509_STORE_CTX_get_current_cert(ctx);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer cert_hash =
=3D x509_get_sha256_fingerprint(current_cert, &amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct buffer cert_hash =3D x509_ge=
t_fingerprint(current_cert, MD_SHA256, &amp;gc);</span><br><span>     cert_=
hash_remember(session, X509_STORE_CTX_get_error_depth(ctx), &amp;cert_hash)=
;</span><br><span> </span><br><span>     /* did peer present cert which was=
 signed by our root cert? */</span><br><span>@@ -356,22 +356,25 @@</span><b=
r><span> }</span><br><span> </span><br><span> struct buffer</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-x509_get_sha1_fingerprint(X509 *cert,=
 struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+x509_get_fingerprint(X509 *cert, hash_algo_type algo, struct gc_arena *gc=
)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   const EVP_MD *sha1 =3D EVP_sha1();</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    struct buffer hash =3D alloc_buf_gc((size_t)EVP_MD_size=
(sha1), gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    X509_=
digest(cert, EVP_sha1(), BPTR(&amp;hash), NULL);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    ASSERT(buf_inc_len(&amp;hash, (int)EVP_MD_si=
ze(sha1)));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return=
 hash;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const EVP_MD *md =3D NULL;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch (algo)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        case MD_SHA1:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            md =3D EVP_sha1();</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct buf=
fer</span><br><span style=3D"color: hsl(0, 100%, 40%);">-x509_get_sha256_fi=
ngerprint(X509 *cert, struct gc_arena *gc)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    const EVP_MD *sha256 =3D EVP_sha256();</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    struct buffer hash =3D alloc_buf_gc((size_t)EVP_M=
D_size(sha256), gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   X509_digest(cert, EVP_sha256(), BPTR(&amp;hash), NULL);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(buf_inc_len(&amp;hash, (int=
)EVP_MD_size(sha256)));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        case MD_SHA256:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            md =3D EVP_sha256();</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            break;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ASSERT(md);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int md_=
size =3D EVP_MD_size(md);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct buffer hash =3D alloc_buf_gc((size_t)md_size, gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    X509_digest(cert, md, B=
PTR(&amp;hash), NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    ASSERT(buf_inc_len(&amp;hash, md_size));</span><br><span>     return=
 hash;</span><br><span> }</span><br><span> </span><br><span>@@ -464,23 +467=
,6 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-/* worker method for setenv_x50=
9_track */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do_setenv_x509(struct=
 env_set *es, const char *name, char *value, int depth)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    char *name_expand;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    size_t name_expand_size;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    string_mod(value, CC_ANY, CC_CRLF, &#39;?&#39;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    msg(D_X509_ATTR, &quot;X509 ATTRIBUTE n=
ame=3D&#39;%s&#39; value=3D&#39;%s&#39; depth=3D%d&quot;, name, value, dept=
h);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    name_expand_si=
ze =3D 64 + strlen(name);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    name_expand =3D (char *)malloc(name_expand_size);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    check_malloc_return(name_expand);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    snprintf(name_expan=
d, name_expand_size, &quot;X509_%d_%s&quot;, depth, name);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    setenv_str(es, name_expand, value)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    free(name_expand=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span>=
 x509_setenv_track(const struct x509_track *xt, struct env_set *es, const i=
nt depth, X509 *x509)</span><br><span> {</span><br><span>@@ -502,19 +488,10=
 @@</span><br><span>                 case NID_sha1:</span><br><span>       =
          case NID_sha256:</span><br><span>                 {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                    struct buffer f=
p_buf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
     char *fp_str =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
     if (xt-&gt;nid =3D=3D NID_sha1)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                    {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                        fp_buf =3D x509_get_sha1_fingerprint=
(x509, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                      fp_buf =3D x509_get_sha256_fingerprint(x509, &amp;gc)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    fp_str =3D format_hex=
_ex(BPTR(&amp;fp_buf), BLEN(&amp;fp_buf), 0, 1 | FHE_CAPS, &quot;:&quot;, &=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         hash_algo_type algo =3D xt-&gt;nid =3D=3D NID_sha1 ? MD_SHA1 : MD_=
SHA256;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        struct buffer fp_buf =3D x509_get_fingerprint(x509, algo, &amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 char *fp_str =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                      format_hex_ex(BPTR(&amp;fp_buf), BLEN(&amp;fp_buf), 0=
, 1 | FHE_CAPS, &quot;:&quot;, &amp;gc);</span><br><span>                  =
   do_setenv_x509(es, xt-&gt;name, fp_str, depth);</span><br><span>        =
         }</span><br><span>                 break;</span><br><span>diff --g=
it a/tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec b/tests/unit_tests/=
openvpn/mock_ssl_dependencies=2Ec</span><br><span>index b22dd89=2E=2E65e463=
5 100644</span><br><span>--- a/tests/unit_tests/openvpn/mock_ssl_dependenci=
es=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/mock_ssl_dependencies=
=2Ec</span><br><span>@@ -64,3 +64,9 @@</span><br><span> {</span><br><span> =
    return FAILURE;</span><br><span> }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+do_setenv_x509(=
struct env_set *es, const char *name, char *value, int depth)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_false(true);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br></pre><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2145?usp=3Demail">change 2145</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2145?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7=
6cd424b34e91f07a6d187b23a258d9dcbf7ed0f </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2145 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojoc=
aru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--MQifkSM2JQg=--


--===============5833318061300588244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5833318061300588244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5833318061300588244==--

