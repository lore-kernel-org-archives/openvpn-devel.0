Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D963C606A334
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Fow2O4bV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=J8krokkE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CVJs4AVx;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=I6TK/MGz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=k/MGA3y1yPyL1u1h2M0NjsgM6VS2JAZJBScCAxSw7aA=; b=Fow2O4bVjIOEfbnCRcMTdd6IJ6
	LD81NIoUgTMj5CRUemUCJWdgjN7nPlzz2xFzwhdUL+GS09+TCoNJWNPOOI+ckmiglMFNlE4iPc+Ka
	tpBKGgOu3EXZ3LP7FgiPin4Ao1hbT7xhW1nFQ93MDm8k6XdigbJ3LCdbnawO3/o/qPSo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPGUp-000000001p7-2HgW;
	Fri, 06 Nov 2026 09:44:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPGUn-000000001p1-3CNI
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 09:44:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hcuUjQJbnssEOZVFSiP2X86ypnYvPXkj8jJCd7MfGng=; b=J8krokkEjvwqhG5pCntQq2cjRN
 TZwE3wDXSiiSRTDr+hwZ9+nM1iZdB5zz8h+TZPeRCwb5KsJY1+eOvcxBk6GAKzWteqL2mwuteVoS8
 nUfrpgz2gYUyYKka9yNs0a6uctKt6d+OQYmXW46NZYBxuHtvJA4gfdYyycFGtn5zxINk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hcuUjQJbnssEOZVFSiP2X86ypnYvPXkj8jJCd7MfGng=; b=CVJs4AVxN6vKZvZx5lkbi+3rFT
 ESeUUKlN+hiTkl0TFsb9VoH7A5TuNCkCOB9CPMPiCRJd0iCTuEASYZgIukicLnFB+kW/XPdqB9nja
 QjlBdc/T9Xu/L98PGIo0rC4VngIcQu3WUqoY3ioqEjsLiXCxTEyHyw90rGhCtHWffT80=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPGUl-000000006Tr-1yXF for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 09:44:29 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so3678715e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 01:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793958261; x=1794563061; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hcuUjQJbnssEOZVFSiP2X86ypnYvPXkj8jJCd7MfGng=;
 b=I6TK/MGzoMADD0SH4r1eWunnO3WQIVhKxfHgTygBhMNo+TRtUdUrB5MfsAU7auoIlS
 /viLGmYw0mfYFCTDDWMV+6rAHqxEvcU92Zvom2nfT3m7fvS6LmUjAtTUPb66tgzeNbYF
 cgCe8JfSYBl59Qh6m5a/D17RATzm65Ss3TCR9RpMf0GGEhLUtOcL+lJIK/6XfyboVKbX
 RIEdPfrsPGXhhf/hrcrkAE7XXygf0QjXaW3RPBGybKsaR6qUEhJzNRkgA3llRJaKqiuR
 LUJbS9/aIebhEg7oRBOyENI13PhPgfp2GDHVuRUk9sX+McnLvGKFWwKAXVsbvjkSbiSn
 izXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793958261; x=1794563061;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hcuUjQJbnssEOZVFSiP2X86ypnYvPXkj8jJCd7MfGng=;
 b=nH2VMkUI7dyMcOz1D28kfj8BTn7MM5erNSKpIspxgsOjs78H/UGrq6x5D3qawu4TSL
 U2TfISioCZDZCKExD0aXHTO7Y69eQLLYJK6w1IrB/b8V4KXndAcrw1ziWsUAtGeYRHuS
 ClVLYhDgR46xSjhA1NtGmvD7fVEiCMsDoTlhbeVJ+y1oYq0yUmv1wOvTmyx/QkvnhD9K
 o7ydsVQmvcUScshIUQ8FYwW0jWWN54ZQQbVzF9TKCKWwQ0UNyF0T9y59dEMcZlFdeycH
 sQYwgUoCeX8uP3oPh/Ni+JUD2TAl0urXsxOxeA770+xqWsSwoic7XNyEbfpJ5sDGX5hm
 fMhQ==
X-Gm-Message-State: APuU4Z/dISlRlioYvO54XL6bsfG2ajTzFIY273UofkBHpCd1RetjELfC
 FZWJ9yW8IjUH2j2bb/EpImtkQr8L08MDBywky+LvyddJCA8/GcB2fZzTaQ9g1KaRC1hEcMkQzsb
 syuoxtRWyWpkq8GGsXOsTXvzzX3xklBs10LajqnkSh2iYglC7p6QknscsL4bcXDgN+gbMwB9Upu
 mWtKpYWw==
X-Gm-Gg: AYBFou3vqOBs8ik1ILkPXftAKJ63AAttLheDU4wXafpF6MW4WsbD+BVpstO0G45wOZo
 m/UxpZ30uAEKFiRaw6U3h7zeGJVbai2CsFLtkZg+rvOLw5z5+AoY5+Cu/L6gxSxnfXsAfHnxyei
 dVTB6xagsiCKNROxj2jfjE2QjFRIQ5J0NEuUTPkfZZIdHLo2TY8JABBRb1yVdRANzrQc8Ph5HQC
 6iVjJ6wKpD4izpETGbW7LXfUfutVRyFDIiSxaE6pKeOikYXSlzUK9mwou6j4/ilPb2X++WS72Ny
 0vCpdytmdpfI9ZI14fltXyPMan0qJsOAi85FrXqr6dFtQCPgpQE7LJ/WvDvIRP36OQxr/Rj7hrx
 JKMGkgt57zET9yZseB8kuwuk2uLe+8Qcj+C8n/O1L/4FAJBLR9yGMy5iG0oglF8F/71RSHIUPKd
 HipTeZBvR7Q1QFlepXyPhSPpqEIH4ycCmybusEn7bHiSvRTVswbW7Na3gq/Bl1E4+DxqB7HIwRB
 a8NaCsb5HnYubykZRnqTS7Lmx9+uQBfjhEgADth/kuiowYXQh3cP9GzodhuKTulqYC6bMKXZLS2
 jAHKB6IbwN/vOAI3XJX52a6PjO/HnAi1T2qD1RisZGu8wWtAfR0N8//g97WZvLJOYWyNVSkitp9
 zo3ubjdncmDRYWNZFYvFMToXUwmGFnqZkIofELhDU9Xn8RPCx/SclMbU5Bxm/rLXuw5DKjMYDto
 xW4LYu0bFvHD/r2gnBi6EnWJtnKNPjPR432pU=
X-Received: by 2002:a05:600c:8b23:b0:4a1:6517:ccf1 with SMTP id
 5b1f17b1804b1-4b6dea6984emr31740515e9.9.1793958260549; 
 Fri, 06 Nov 2026 01:44:20 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b6e28cce1fsm54106625e9.15.2026.11.06.01.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 01:44:20 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 09:44:18 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I76cd424b34e91f07a6d187b23a258d9dcbf7ed0f
X-Gerrit-Change-Number: 2145
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2145?usp=email>
X-Gerrit-Commit: f78670921980cd9e5b9e1339a12d9a57238038e6
In-Reply-To: <gerrit.1793957909000.I76cd424b34e91f07a6d187b23a258d9dcbf7ed0f@gerrit.openvpn.net>
References: <gerrit.1793957909000.I76cd424b34e91f07a6d187b23a258d9dcbf7ed0f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzOTU3OTA5MDAwLkk3NmNkNDI0YjM0ZTkxZjA3YTZkMTg3YjIzYTI1OGQ5ZGNiZjdlZDBmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2b444e6a7a3ff3335b802ab331705f2ca14590d7-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPGUl-000000006Tr-1yXF
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
Content-Type: multipart/mixed; boundary="===============5079565466749875962=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5079565466749875962==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jYUkxDImXF4="; charset=UTF-8

--jYUkxDImXF4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2145?usp=3Demail

to look at the new patch set (#=
2)=2E


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
5 files changed, 82 insertions(+), 131 deletions(-)


 =
 git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/45/2145/2=


diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
inde=
x 0cdec1e=2E=2E3cbc632 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/op=
envpn/ssl_verify=2Ec
@@ -53,6 +53,19 @@
     string_mod(str, CC_PRINT, CC_C=
RLF, '_');
 }
 
+void
+do_setenv_x509(struct env_set *es, const char *name,=
 char *value, int depth)
+{
+    string_mod(value, CC_ANY, CC_CRLF, '?');
+=
    msg(D_X509_ATTR, "X509 ATTRIBUTE name=3D'%s' value=3D'%s' depth=3D%d", =
name, value, depth);
+    const size_t name_expand_size =3D 64 + strlen(nam=
e);
+    char *name_expand =3D (char *)malloc(name_expand_size);
+    check=
_malloc_return(name_expand);
+    snprintf(name_expand, name_expand_size, "=
X509_%d_%s", depth, name);
+    setenv_str(es, name_expand, value);
+    fr=
ee(name_expand);
+}
+
 /*
  * Export the untrusted IP address and port to t=
he environment
  */
@@ -428,8 +441,8 @@
 
     /* export X509 cert fingerpr=
ints */
     {
-        struct buffer sha1 =3D x509_get_sha1_fingerprint(pe=
er_cert, &gc);
-        struct buffer sha256 =3D x509_get_sha256_fingerprin=
t(peer_cert, &gc);
+        struct buffer sha1 =3D x509_get_fingerprint(pee=
r_cert, MD_SHA1, &gc);
+        struct buffer sha256 =3D x509_get_fingerpri=
nt(peer_cert, MD_SHA256, &gc);
 
         snprintf(envname, sizeof(envname)=
, "tls_digest_%d", cert_depth);
         setenv_str(es, envname, format_hex=
_ex(BPTR(&sha1), BLEN(&sha1), 0, 1, ":", &gc));
@@ -671,32 +684,7 @@
 
    =
 if (cert_depth =3D=3D opt->verify_hash_depth && opt->verify_hash)
     {
-=
        struct buffer cert_fp =3D { 0 };
-
-        switch (opt->verify_has=
h_algo)
-        {
-            case MD_SHA1:
-                cert_fp =3D =
x509_get_sha1_fingerprint(cert, &gc);
-                break;
-
-          =
  case MD_SHA256:
-                cert_fp =3D x509_get_sha256_fingerprint(=
cert, &gc);
-                break;
-
-            default:
-              =
  /* This should normally not happen at all; the algorithm used
-          =
       * is parsed by add_option() [options=2Ec] and set to a predefined
- =
                * value in an enumerated type=2E  So if this unlikely scena=
rio
-                 * happens, consider this a failure
-                 =
*/
-                msg(M_WARN,
-                    "Unexpected invalid al=
gorithm used with "
-                    "--verify-hash (%i)",
-           =
         opt->verify_hash_algo);
-                ret =3D FAILURE;
-       =
         goto cleanup;
-        }
-
+        struct buffer cert_fp =3D x509=
_get_fingerprint(cert, opt->verify_hash_algo, &gc);
         const struct v=
erify_hash_list *current_hash =3D opt->verify_hash;
 
         while (curre=
nt_hash)
diff --git a/src/openvpn/ssl_verify_backend=2Eh b/src/openvpn/ssl_=
verify_backend=2Eh
index 46720d6=2E=2E93916b7 100644
--- a/src/openvpn/ssl_=
verify_backend=2Eh
+++ b/src/openvpn/ssl_verify_backend=2Eh
@@ -75,6 +75,17=
 @@
                         const struct buffer *cert_hash);
 
 /*
+ * Exp=
ort an X509 attribute as the X509_<depth>_<name> environment variable,
+ * =
replacing CR and LF in value with '?'=2E
+ *
+ * @param es            Envir=
onment set to add the variable to
+ * @param name          Attribute name
+=
 * @param value         Attribute value, modified in place
+ * @param depth=
         Depth of the certificate the attribute belongs to
+ */
+void do_se=
tenv_x509(struct env_set *es, const char *name, char *value, int depth);
+
=
+/*
  * Library-specific functions=2E
  *
  * The following functions must =
be implemented on a library-specific basis=2E
@@ -91,24 +102,16 @@
 char *x=
509_get_subject(openvpn_x509_cert_t *cert, struct gc_arena *gc);
 
 /**
- *=
 Retrieve the certificate's SHA1 fingerprint=2E
+ * Retrieve the certificat=
e's fingerprint=2E
  *
  * @param cert          Certificate to retrieve the=
 fingerprint from=2E
+ * @param algo          Hash algorithm to use=2E
  * =
@param gc            Garbage collection arena to use when allocating string=
=2E
  *
- * @return              a string containing the certificate finger=
print
+ * @return              a buffer containing the certificate fingerpr=
int
  */
-struct buffer x509_get_sha1_fingerprint(openvpn_x509_cert_t *cert=
, struct gc_arena *gc);
-
-/**
- * Retrieve the certificate's SHA256 finger=
print=2E
- *
- * @param cert          Certificate to retrieve the fingerpri=
nt from=2E
- * @param gc            Garbage collection arena to use when al=
locating string=2E
- *
- * @return              a string containing the cer=
tificate fingerprint
- */
-struct buffer x509_get_sha256_fingerprint(openvp=
n_x509_cert_t *cert, struct gc_arena *gc);
+struct buffer x509_get_fingerpr=
int(openvpn_x509_cert_t *cert, hash_algo_type algo,
+                      =
             struct gc_arena *gc);
 
 /*
  * Retrieve the certificate's use=
rname from the specified field=2E
diff --git a/src/openvpn/ssl_verify_mbedt=
ls=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec
index a132f12=2E=2E376e7c7 1006=
44
--- a/src/openvpn/ssl_verify_mbedtls=2Ec
+++ b/src/openvpn/ssl_verify_mb=
edtls=2Ec
@@ -55,7 +55,7 @@
     session->verified =3D false;
 
     /* Rem=
ember certificate hash */
-    struct buffer cert_fingerprint =3D x509_get_=
sha256_fingerprint(cert, &gc);
+    const struct buffer cert_fingerprint =
=3D x509_get_fingerprint(cert, MD_SHA256, &gc);
     cert_hash_remember(ses=
sion, cert_depth, &cert_fingerprint);
 
     if (session->opt->verify_hash_=
no_ca)
@@ -502,9 +502,23 @@
     return FAILURE;
 }
 
-static struct buffer=

-x509_get_fingerprint(const mbedtls_md_info_t *md_info, mbedtls_x509_crt *=
cert, struct gc_arena *gc)
+struct buffer
+x509_get_fingerprint(mbedtls_x50=
9_crt *cert, hash_algo_type algo, struct gc_arena *gc)
 {
+    mbedtls_md_t=
ype_t md_type =3D MBEDTLS_MD_NONE;
+    switch (algo)
+    {
+        case =
MD_SHA1:
+            md_type =3D MBEDTLS_MD_SHA1;
+            break;
+
+ =
       case MD_SHA256:
+            md_type =3D MBEDTLS_MD_SHA256;
+       =
     break;
+    }
+    ASSERT(md_type !=3D MBEDTLS_MD_NONE);
+
+    const =
mbedtls_md_info_t *md_info =3D mbedtls_md_info_from_type(md_type);
     con=
st size_t md_size =3D mbedtls_md_get_size(md_info);
     struct buffer fing=
erprint =3D alloc_buf_gc(md_size, gc);
     mbedtls_md(md_info, cert->raw=
=2Ep, cert->raw=2Elen, BPTR(&fingerprint));
@@ -512,18 +526,6 @@
     retur=
n fingerprint;
 }
 
-struct buffer
-x509_get_sha1_fingerprint(mbedtls_x509_=
crt *cert, struct gc_arena *gc)
-{
-    return x509_get_fingerprint(mbedtls=
_md_info_from_type(MBEDTLS_MD_SHA1), cert, gc);
-}
-
-struct buffer
-x509_g=
et_sha256_fingerprint(mbedtls_x509_crt *cert, struct gc_arena *gc)
-{
-    =
return x509_get_fingerprint(mbedtls_md_info_from_type(MBEDTLS_MD_SHA256), c=
ert, gc);
-}
-
 char *
 x509_get_subject(mbedtls_x509_crt *cert, struct gc_=
arena *gc)
 {
@@ -542,22 +544,6 @@
     return subject;
 }
 
-static void
-=
do_setenv_x509(struct env_set *es, const char *name, char *value, int depth=
)
-{
-    char *name_expand;
-    size_t name_expand_size;
-
-    string_mo=
d(value, CC_ANY, CC_CRLF, '?');
-    msg(D_X509_ATTR, "X509 ATTRIBUTE name=
=3D'%s' value=3D'%s' depth=3D%d", name, value, depth);
-    name_expand_siz=
e =3D 64 + strlen(name);
-    name_expand =3D (char *)malloc(name_expand_si=
ze);
-    check_malloc_return(name_expand);
-    snprintf(name_expand, name=
_expand_size, "X509_%d_%s", depth, name);
-    setenv_str(es, name_expand, =
value);
-    free(name_expand);
-}
-
 static char *
 asn1_buf_to_c_string(c=
onst mbedtls_asn1_buf *orig, struct gc_arena *gc)
 {
@@ -701,22 +687,13 @@
=
     {
         if (depth =3D=3D 0 || (xt->flags & XT_FULL_CHAIN))
        =
 {
-            if (0 =3D=3D strcmp(xt->name, "SHA1") || 0 =3D=3D strcmp(xt=
->name, "SHA256"))
+            const bool sha1 =3D strcmp(xt->name, "SHA1"=
) =3D=3D 0;
+            if (sha1 || strcmp(xt->name, "SHA256") =3D=3D 0)
 =
            {
                 /* Fingerprint is not part of X509 structure=
 */
-                struct buffer cert_hash;
-                char *finger=
print;
-
-                if (0 =3D=3D strcmp(xt->name, "SHA1"))
-         =
       {
-                    cert_hash =3D x509_get_sha1_fingerprint(cert,=
 &gc);
-                }
-                else
-                {
-       =
             cert_hash =3D x509_get_sha256_fingerprint(cert, &gc);
-       =
         }
-
-                fingerprint =3D
+                const hash_a=
lgo_type algo =3D sha1 ? MD_SHA1 : MD_SHA256;
+                struct buffe=
r cert_hash =3D x509_get_fingerprint(cert, algo, &gc);
+                cha=
r *fingerprint =3D
                     format_hex_ex(BPTR(&cert_hash), BLE=
N(&cert_hash), 0, 1 | FHE_CAPS, ":", &gc);
                 do_setenv_x509(=
es, xt->name, fingerprint, depth);
             }
diff --git a/src/openvpn/=
ssl_verify_openssl=2Ec b/src/openvpn/ssl_verify_openssl=2Ec
index 0c36cf2=
=2E=2Ea278854 100644
--- a/src/openvpn/ssl_verify_openssl=2Ec
+++ b/src/ope=
nvpn/ssl_verify_openssl=2Ec
@@ -61,7 +61,7 @@
     ASSERT(session);
 
     =
X509 *current_cert =3D X509_STORE_CTX_get_current_cert(ctx);
-    struct bu=
ffer cert_hash =3D x509_get_sha256_fingerprint(current_cert, &gc);
+    con=
st struct buffer cert_hash =3D x509_get_fingerprint(current_cert, MD_SHA256=
, &gc);
     cert_hash_remember(session, X509_STORE_CTX_get_error_depth(ctx=
), &cert_hash);
 
     /* did peer present cert which was signed by our roo=
t cert? */
@@ -356,22 +356,25 @@
 }
 
 struct buffer
-x509_get_sha1_fingerp=
rint(X509 *cert, struct gc_arena *gc)
+x509_get_fingerprint(X509 *cert, has=
h_algo_type algo, struct gc_arena *gc)
 {
-    const EVP_MD *sha1 =3D EVP_s=
ha1();
-    struct buffer hash =3D alloc_buf_gc((size_t)EVP_MD_size(sha1), =
gc);
-    X509_digest(cert, EVP_sha1(), BPTR(&hash), NULL);
-    ASSERT(buf=
_inc_len(&hash, (int)EVP_MD_size(sha1)));
-    return hash;
-}
+    const E=
VP_MD *md =3D NULL;
+    switch (algo)
+    {
+        case MD_SHA1:
+     =
       md =3D EVP_sha1();
+            break;
 
-struct buffer
-x509_get_sh=
a256_fingerprint(X509 *cert, struct gc_arena *gc)
-{
-    const EVP_MD *sha=
256 =3D EVP_sha256();
-    struct buffer hash =3D alloc_buf_gc((size_t)EVP_=
MD_size(sha256), gc);
-    X509_digest(cert, EVP_sha256(), BPTR(&hash), NUL=
L);
-    ASSERT(buf_inc_len(&hash, (int)EVP_MD_size(sha256)));
+        cas=
e MD_SHA256:
+            md =3D EVP_sha256();
+            break;
+    }
+=
    ASSERT(md);
+
+    const int md_size =3D EVP_MD_size(md);
+    struct b=
uffer hash =3D alloc_buf_gc((size_t)md_size, gc);
+    X509_digest(cert, md=
, BPTR(&hash), NULL);
+    ASSERT(buf_inc_len(&hash, md_size));
     return=
 hash;
 }
 
@@ -464,23 +467,6 @@
     }
 }
 
-/* worker method for setenv_x=
509_track */
-static void
-do_setenv_x509(struct env_set *es, const char *n=
ame, char *value, int depth)
-{
-    char *name_expand;
-    size_t name_ex=
pand_size;
-
-    string_mod(value, CC_ANY, CC_CRLF, '?');
-    msg(D_X509_=
ATTR, "X509 ATTRIBUTE name=3D'%s' value=3D'%s' depth=3D%d", name, value, de=
pth);
-    name_expand_size =3D 64 + strlen(name);
-    name_expand =3D (ch=
ar *)malloc(name_expand_size);
-    check_malloc_return(name_expand);
-    =
snprintf(name_expand, name_expand_size, "X509_%d_%s", depth, name);
-    se=
tenv_str(es, name_expand, value);
-    free(name_expand);
-}
-
 void
 x509_=
setenv_track(const struct x509_track *xt, struct env_set *es, const int dep=
th, X509 *x509)
 {
@@ -502,19 +488,10 @@
                 case NID_sha1:
  =
               case NID_sha256:
                 {
-                    str=
uct buffer fp_buf;
-                    char *fp_str =3D NULL;
-
-         =
           if (xt->nid =3D=3D NID_sha1)
-                    {
-           =
             fp_buf =3D x509_get_sha1_fingerprint(x509, &gc);
-            =
        }
-                    else
-                    {
-               =
         fp_buf =3D x509_get_sha256_fingerprint(x509, &gc);
-              =
      }
-
-                    fp_str =3D format_hex_ex(BPTR(&fp_buf), BLEN=
(&fp_buf), 0, 1 | FHE_CAPS, ":", &gc);
+                    const hash_algo=
_type algo =3D xt->nid =3D=3D NID_sha1 ? MD_SHA1 : MD_SHA256;
+            =
        struct buffer fp_buf =3D x509_get_fingerprint(x509, algo, &gc);
+  =
                  char *fp_str =3D
+                        format_hex_ex(B=
PTR(&fp_buf), BLEN(&fp_buf), 0, 1 | FHE_CAPS, ":", &gc);
                  =
   do_setenv_x509(es, xt->name, fp_str, depth);
                 }
        =
         break;
diff --git a/tests/unit_tests/openvpn/mock_ssl_dependencies=
=2Ec b/tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec
index b22dd89=2E=
=2E65e4635 100644
--- a/tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec
=
+++ b/tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec
@@ -64,3 +64,9 @@
=
 {
     return FAILURE;
 }
+
+void
+do_setenv_x509(struct env_set *es, cons=
t char *name, char *value, int depth)
+{
+    assert_false(true);
+}

-- 
T=
o view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2145?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Pro=
ject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I76cd424b34e91f07a6d1=
87b23a258d9dcbf7ed0f
Gerrit-Change-Number: 2145
Gerrit-PatchSet: 2
Gerrit-O=
wner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>

--jYUkxDImXF4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru <strong>=
uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"https://g=
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
ncies=2Ec<br>5 files changed, 82 insertions(+), 131 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/45/2145/2</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_verify=2Ec b/src/open=
vpn/ssl_verify=2Ec</span><br><span>index 0cdec1e=2E=2E3cbc632 100644</span>=
<br><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/src/openvp=
n/ssl_verify=2Ec</span><br><span>@@ -53,6 +53,19 @@</span><br><span>     st=
ring_mod(str, CC_PRINT, CC_CRLF, &#39;_&#39;);</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+do_setenv_x509(struct env_=
set *es, const char *name, char *value, int depth)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    string_mod(value, CC_ANY, CC_CRLF, &#39;?&#39;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_X509_ATTR, &quot;X5=
09 ATTRIBUTE name=3D&#39;%s&#39; value=3D&#39;%s&#39; depth=3D%d&quot;, nam=
e, value, depth);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const size_t name_expand_size =3D 64 + strlen(name);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    char *name_expand =3D (char *)malloc=
(name_expand_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    check_malloc_return(name_expand);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    snprintf(name_expand, name_expand_size, &quot;X509_%d=
_%s&quot;, depth, name);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    setenv_str(es, name_expand, value);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    free(name_expand);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> /*</span><br><span>  * Export the untrusted IP =
address and port to the environment</span><br><span>  */</span><br><span>@@=
 -428,8 +441,8 @@</span><br><span> </span><br><span>     /* export X509 cer=
t fingerprints */</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        struct buffer sha1 =3D x509_get_sha1_fingerprint=
(peer_cert, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        struct buffer sha256 =3D x509_get_sha256_fingerprint(peer_cert, &am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struc=
t buffer sha1 =3D x509_get_fingerprint(peer_cert, MD_SHA1, &amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        struct buffer sha2=
56 =3D x509_get_fingerprint(peer_cert, MD_SHA256, &amp;gc);</span><br><span=
> </span><br><span>         snprintf(envname, sizeof(envname), &quot;tls_di=
gest_%d&quot;, cert_depth);</span><br><span>         setenv_str(es, envname=
, format_hex_ex(BPTR(&amp;sha1), BLEN(&amp;sha1), 0, 1, &quot;:&quot;, &amp=
;gc));</span><br><span>@@ -671,32 +684,7 @@</span><br><span> </span><br><sp=
an>     if (cert_depth =3D=3D opt-&gt;verify_hash_depth &amp;&amp; opt-&gt;=
verify_hash)</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        struct buffer cert_fp =3D { 0 };</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        switch (opt-&gt;verify_hash_algo)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            case MD_SHA1:</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                cert_fp =3D x509_get_sha1_fingerpri=
nt(cert, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            case MD_SHA=
256:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                c=
ert_fp =3D x509_get_sha256_fingerprint(cert, &amp;gc);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                break;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            default:</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                /* This should normally not happen at all; the =
algorithm used</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
          * is parsed by add_option() [options=2Ec] and set to a predefined=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 * va=
lue in an enumerated type=2E  So if this unlikely scenario</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                 * happens, consider t=
his a failure</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
         */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      msg(M_WARN,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                &quot;Unexpected invalid algorithm used with &quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    &quot;--v=
erify-hash (%i)&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                    opt-&gt;verify_hash_algo);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                ret =3D FAILURE;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                goto cleanup;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        struct buffer cert_fp =3D x509_get_fingerprint(cert, =
opt-&gt;verify_hash_algo, &amp;gc);</span><br><span>         const struct v=
erify_hash_list *current_hash =3D opt-&gt;verify_hash;</span><br><span> </s=
pan><br><span>         while (current_hash)</span><br><span>diff --git a/sr=
c/openvpn/ssl_verify_backend=2Eh b/src/openvpn/ssl_verify_backend=2Eh</span=
><br><span>index 46720d6=2E=2E93916b7 100644</span><br><span>--- a/src/open=
vpn/ssl_verify_backend=2Eh</span><br><span>+++ b/src/openvpn/ssl_verify_bac=
kend=2Eh</span><br><span>@@ -75,6 +75,17 @@</span><br><span>               =
          const struct buffer *cert_hash);</span><br><span> </span><br><spa=
n> /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Export an X=
509 attribute as the X509_&lt;depth&gt;_&lt;name&gt; environment variable,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * replacing CR and =
LF in value with &#39;?&#39;=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram es            Environment set to add the variable to</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param name          Attribute nam=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param value   =
      Attribute value, modified in place</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param depth         Depth of the certificate the a=
ttribute belongs to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void do_setenv_x=
509(struct env_set *es, const char *name, char *value, int depth);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/*</span><br><span>  * Library-specific functio=
ns=2E</span><br><span>  *</span><br><span>  * The following functions must =
be implemented on a library-specific basis=2E</span><br><span>@@ -91,24 +10=
2,16 @@</span><br><span> char *x509_get_subject(openvpn_x509_cert_t *cert, =
struct gc_arena *gc);</span><br><span> </span><br><span> /**</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * Retrieve the certificate&#39;s SH=
A1 fingerprint=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 Retrieve the certificate&#39;s fingerprint=2E</span><br><span>  *</span><b=
r><span>  * @param cert          Certificate to retrieve the fingerprint fr=
om=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param algo=
          Hash algorithm to use=2E</span><br><span>  * @param gc           =
 Garbage collection arena to use when allocating string=2E</span><br><span>=
  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return        =
      a string containing the certificate fingerprint</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return              a buffer containi=
ng the certificate fingerprint</span><br><span>  */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-struct buffer x509_get_sha1_fingerprint(ope=
nvpn_x509_cert_t *cert, struct gc_arena *gc);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Retrieve the=
 certificate&#39;s SHA256 fingerprint=2E</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * @param cert          Certificate to retrieve the fingerprint from=2E</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param gc            G=
arbage collection arena to use when allocating string=2E</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * @return              a string containing the certificate=
 fingerprint</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-struct buffer x509_get_sha2=
56_fingerprint(openvpn_x509_cert_t *cert, struct gc_arena *gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+struct buffer x509_get_fingerpr=
int(openvpn_x509_cert_t *cert, hash_algo_type algo,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                   struct=
 gc_arena *gc);</span><br><span> </span><br><span> /*</span><br><span>  * R=
etrieve the certificate&#39;s username from the specified field=2E</span><b=
r><span>diff --git a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_v=
erify_mbedtls=2Ec</span><br><span>index a132f12=2E=2E376e7c7 100644</span><=
br><span>--- a/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>+++ b/src=
/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>@@ -55,7 +55,7 @@</span><br=
><span>     session-&gt;verified =3D false;</span><br><span> </span><br><sp=
an>     /* Remember certificate hash */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    struct buffer cert_fingerprint =3D x509_get_sha256_fi=
ngerprint(cert, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const struct buffer cert_fingerprint =3D x509_get_fingerprint(cer=
t, MD_SHA256, &amp;gc);</span><br><span>     cert_hash_remember(session, ce=
rt_depth, &amp;cert_fingerprint);</span><br><span> </span><br><span>     if=
 (session-&gt;opt-&gt;verify_hash_no_ca)</span><br><span>@@ -502,9 +502,23 =
@@</span><br><span>     return FAILURE;</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static struct buffer=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-x509_get_fingerprint(=
const mbedtls_md_info_t *md_info, mbedtls_x509_crt *cert, struct gc_arena *=
gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct buffer</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+x509_get_fingerprint(m=
bedtls_x509_crt *cert, hash_algo_type algo, struct gc_arena *gc)</span><br>=
<span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbedtls=
_md_type_t md_type =3D MBEDTLS_MD_NONE;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    switch (algo)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        case MD_SHA1:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            md_type =3D MBEDTLS_MD_SHA1;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        case MD_SHA256:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            md_type =3D MBEDTLS_MD_SHA256;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    ASSERT(md_type !=3D MBEDTLS_MD_NONE);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const mbedtls_md_info_t *md_info =3D mbedtls_md_=
info_from_type(md_type);</span><br><span>     const size_t md_size =3D mbed=
tls_md_get_size(md_info);</span><br><span>     struct buffer fingerprint =
=3D alloc_buf_gc(md_size, gc);</span><br><span>     mbedtls_md(md_info, cer=
t-&gt;raw=2Ep, cert-&gt;raw=2Elen, BPTR(&amp;fingerprint));</span><br><span=
>@@ -512,18 +526,6 @@</span><br><span>     return fingerprint;</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-struct buffer</span><br><span style=3D"color: hsl(0, 100%, 40%);">-x509_=
get_sha1_fingerprint(mbedtls_x509_crt *cert, struct gc_arena *gc)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    return x509_get_fingerprint(mbedtls_md_info_fro=
m_type(MBEDTLS_MD_SHA1), cert, gc);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-struct buffer</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-x509_get_sha256_fingerprint(mbedtls=
_x509_crt *cert, struct gc_arena *gc)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
return x509_get_fingerprint(mbedtls_md_info_from_type(MBEDTLS_MD_SHA256), c=
ert, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> char *</span><=
br><span> x509_get_subject(mbedtls_x509_crt *cert, struct gc_arena *gc)</sp=
an><br><span> {</span><br><span>@@ -542,22 +544,6 @@</span><br><span>     r=
eturn subject;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-do_setenv_x509(struct env_set *es, const char *name, =
char *value, int depth)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *name_exp=
and;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t name_e=
xpand_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    string_mod(value, CC_ANY, C=
C_CRLF, &#39;?&#39;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    msg(D_X509_ATTR, &quot;X509 ATTRIBUTE name=3D&#39;%s&#39; value=3D&#39;=
%s&#39; depth=3D%d&quot;, name, value, depth);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    name_expand_size =3D 64 + strlen(name);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    name_expand =3D (char *)=
malloc(name_expand_size);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    check_malloc_return(name_expand);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    snprintf(name_expand, name_expand_size, &quot;X509_=
%d_%s&quot;, depth, name);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    setenv_str(es, name_expand, value);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    free(name_expand);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span> static char *</span><br><span> asn1_buf_to_c_string(c=
onst mbedtls_asn1_buf *orig, struct gc_arena *gc)</span><br><span> {</span>=
<br><span>@@ -701,22 +687,13 @@</span><br><span>     {</span><br><span>    =
     if (depth =3D=3D 0 || (xt-&gt;flags &amp; XT_FULL_CHAIN))</span><br><s=
pan>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     if (0 =3D=3D strcmp(xt-&gt;name, &quot;SHA1&quot;) || 0 =3D=3D strcmp(=
xt-&gt;name, &quot;SHA256&quot;))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            const bool sha1 =3D strcmp(xt-&gt;name, &quot;SHA=
1&quot;) =3D=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           if (sha1 || strcmp(xt-&gt;name, &quot;SHA256&quot;) =3D=3D 0)</s=
pan><br><span>             {</span><br><span>                 /* Fingerprin=
t is not part of X509 structure */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                struct buffer cert_hash;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                char *fingerprint;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                if (0 =3D=3D strcmp(xt-&gt;name, &q=
uot;SHA1&quot;))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
           cert_hash =3D x509_get_sha1_fingerprint(cert, &amp;gc);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                else</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    cert_hash =3D x509_=
get_sha256_fingerprint(cert, &amp;gc);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        fingerprint =3D</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                const hash_algo_type algo =3D sha1 ? MD_SHA1 : MD_SHA25=
6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                s=
truct buffer cert_hash =3D x509_get_fingerprint(cert, algo, &amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                char *fin=
gerprint =3D</span><br><span>                     format_hex_ex(BPTR(&amp;c=
ert_hash), BLEN(&amp;cert_hash), 0, 1 | FHE_CAPS, &quot;:&quot;, &amp;gc);<=
/span><br><span>                 do_setenv_x509(es, xt-&gt;name, fingerprin=
t, depth);</span><br><span>             }</span><br><span>diff --git a/src/=
openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_verify_openssl=2Ec</span><=
br><span>index 0c36cf2=2E=2Ea278854 100644</span><br><span>--- a/src/openvp=
n/ssl_verify_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify_opens=
sl=2Ec</span><br><span>@@ -61,7 +61,7 @@</span><br><span>     ASSERT(sessio=
n);</span><br><span> </span><br><span>     X509 *current_cert =3D X509_STOR=
E_CTX_get_current_cert(ctx);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    struct buffer cert_hash =3D x509_get_sha256_fingerprint(current_=
cert, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const struct buffer cert_hash =3D x509_get_fingerprint(current_cert, MD_SHA=
256, &amp;gc);</span><br><span>     cert_hash_remember(session, X509_STORE_=
CTX_get_error_depth(ctx), &amp;cert_hash);</span><br><span> </span><br><spa=
n>     /* did peer present cert which was signed by our root cert? */</span=
><br><span>@@ -356,22 +356,25 @@</span><br><span> }</span><br><span> </span=
><br><span> struct buffer</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-x509_get_sha1_fingerprint(X509 *cert, struct gc_arena *gc)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+x509_get_fingerprint(X509 *cert,=
 hash_algo_type algo, struct gc_arena *gc)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    const EVP_MD *sha1 =3D EVP_sha1=
();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer =
hash =3D alloc_buf_gc((size_t)EVP_MD_size(sha1), gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    X509_digest(cert, EVP_sha1(), BPTR(&amp=
;hash), NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASS=
ERT(buf_inc_len(&amp;hash, (int)EVP_MD_size(sha1)));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return hash;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const EVP_MD *md =3D NULL;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    switch (algo)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        case MD_SHA1:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            md =3D EVP_sha1();</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            break;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-struct buffer</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-x509_get_sha256_fingerprint(X509 *cert, struct gc_a=
rena *gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    const EVP_MD *sha256 =3D EVP=
_sha256();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct =
buffer hash =3D alloc_buf_gc((size_t)EVP_MD_size(sha256), gc);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    X509_digest(cert, EVP_sha256()=
, BPTR(&amp;hash), NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    ASSERT(buf_inc_len(&amp;hash, (int)EVP_MD_size(sha256)));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        case MD_SHA256:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            md =3D EVP_sh=
a256();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(md);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const int md_size =3D EVP_MD_size(md);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer hash =3D =
alloc_buf_gc((size_t)md_size, gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    X509_digest(cert, md, BPTR(&amp;hash), NULL);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_inc_len(&amp;ha=
sh, md_size));</span><br><span>     return hash;</span><br><span> }</span><=
br><span> </span><br><span>@@ -464,23 +467,6 @@</span><br><span>     }</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-/* worker method for setenv_x509_track */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-do_setenv_x509(struct env_set *es, const char *name, =
char *value, int depth)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *name_exp=
and;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t name_e=
xpand_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    string_mod(value, CC_ANY, C=
C_CRLF, &#39;?&#39;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    msg(D_X509_ATTR, &quot;X509 ATTRIBUTE name=3D&#39;%s&#39; value=3D&#39;=
%s&#39; depth=3D%d&quot;, name, value, depth);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    name_expand_size =3D 64 + strlen(name);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    name_expand =3D (char *)=
malloc(name_expand_size);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    check_malloc_return(name_expand);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    snprintf(name_expand, name_expand_size, &quot;X509_=
%d_%s&quot;, depth, name);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    setenv_str(es, name_expand, value);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    free(name_expand);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span> void</span><br><span> x509_setenv_track(const struct =
x509_track *xt, struct env_set *es, const int depth, X509 *x509)</span><br>=
<span> {</span><br><span>@@ -502,19 +488,10 @@</span><br><span>            =
     case NID_sha1:</span><br><span>                 case NID_sha256:</span=
><br><span>                 {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    struct buffer fp_buf;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    char *fp_str =3D NULL;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    if (xt-&gt;nid =3D=3D NID_s=
ha1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
       fp_buf =3D x509_get_sha1_fingerprint(x509, &amp;gc);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                    }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                    else</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                        fp_buf =3D=
 x509_get_sha256_fingerprint(x509, &amp;gc);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                    fp_str =3D format_hex_ex(BPTR(&amp;fp_buf), BLEN(&amp=
;fp_buf), 0, 1 | FHE_CAPS, &quot;:&quot;, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    const hash_algo_type =
algo =3D xt-&gt;nid =3D=3D NID_sha1 ? MD_SHA1 : MD_SHA256;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    struct buffer fp=
_buf =3D x509_get_fingerprint(x509, algo, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    char *fp_str =3D</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
format_hex_ex(BPTR(&amp;fp_buf), BLEN(&amp;fp_buf), 0, 1 | FHE_CAPS, &quot;=
:&quot;, &amp;gc);</span><br><span>                     do_setenv_x509(es, =
xt-&gt;name, fp_str, depth);</span><br><span>                 }</span><br><=
span>                 break;</span><br><span>diff --git a/tests/unit_tests/=
openvpn/mock_ssl_dependencies=2Ec b/tests/unit_tests/openvpn/mock_ssl_depen=
dencies=2Ec</span><br><span>index b22dd89=2E=2E65e4635 100644</span><br><sp=
an>--- a/tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec</span><br><span=
>+++ b/tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec</span><br><span>@=
@ -64,3 +64,9 @@</span><br><span> {</span><br><span>     return FAILURE;</s=
pan><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+do_setenv_x509(struct env_set *es, co=
nst char *name, char *value, int depth)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_false(true);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2145?usp=3Demail">change 2145</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2145?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I76cd424b34e91f07a6d187=
b23a258d9dcbf7ed0f </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 2145 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--jYUkxDImXF4=--


--===============5079565466749875962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5079565466749875962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5079565466749875962==--

