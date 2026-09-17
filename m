Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962DFC88E72
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VmGY2CTCDjbg36UAnZ88laEITijJM/OBZcTk3cKEvWk=; b=dxRIh1L01c0nx21G9+U39YSj9o
	0aa0YuiyEr6RXh8XN+pc7dU3gUww7zeeh4ds6P/6JIle25DHB3U4B6rX4wwy3ZH0gb81v4NsHBc6k
	A3w0kE82e5EBtFe/Ek6SOKNLCPgvvexSvixZrhwMPC9nxXjLcgXEV0RrJnr1b+CS+I5E=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7BVS-0008Di-MF;
	Thu, 17 Sep 2026 12:46:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x7BVO-0008Da-Me
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 12:46:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r+kDYEhv4eqmzZJA8iyhLzIG3wyTdawXSGP46OtjVwU=; b=hSi40/tTl4mlGZc6PVlWDfYaYB
 6N1tyxkoW+aHAQuRtap7XYvxbF15BYCzn1QKxzoJrr0NmH5AyeXV2Ek0NTBjdKvYGI/TXYuL5TRWD
 X7gP/MKAtPOiYwmMFPVxr9Jy46OeGLHdH/eB0QYo8qdKYMRaSP8i5bb9yZRFV3QQJC1o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=r+kDYEhv4eqmzZJA8iyhLzIG3wyTdawXSGP46OtjVwU=; b=j9gBTywwcuTW2KplZkbu+pQMlI
 8KR8v1fgaepubHUve9EWNcqriompNzgUlz0TAHeRovF9pQDZ0zmCSAjCMwDu2qasV9FKJKQWPU4YK
 JOZZQXkoh3D/p9VPvuRUbQEfpYc31fMP4XDAUxB/rRxVh62A7TOquLOBRx/yChvmXH90=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x7BVK-0006YN-4i for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 12:46:20 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 68HCkBeO014309
 for <openvpn-devel@lists.sourceforge.net>; Thu, 17 Sep 2026 14:46:11 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 68HCkBwU014308
 for openvpn-devel@lists.sourceforge.net; Thu, 17 Sep 2026 14:46:11 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 17 Sep 2026 14:46:05 +0200
Message-ID: <20260917124610.14291-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1788781350000.Iea1481e94ba1abe18c39d81cd797187c88427571@gerrit.openvpn.net>
References: <gerrit.1788781350000.Iea1481e94ba1abe18c39d81cd797187c88427571@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x7BVK-0006YN-4i
Subject: [Openvpn-devel] [PATCH v3] Check for null-bytes in certificate
 subjects
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Max Fillinger <maximilian.fillinger@sentyron.com>

When using the OpenSSL library, we escaped embedded null-bytes in a
certificate's subject in x509_get_subject(), but in
extract_x509_field_ssl(), we copied any null-bytes that are contained in
the field value. When using the option --verify-x509-name, this could
lead to an incorrect name being accepted. For example, the common name
"admin\0impersonator" would be accepted when running with
--verify-x509-name admin name.

To fix this, this commit makes x509_get_subject() return an error if the
subject contains an embedded null-byte. This way, OpenVPN won't connect
with peers that present such certificates.

As a defense-in-depth measure, we also check for null-bytes in
extract_x509_field_ssl() in case a future version of OpenVPN has a code
path that avoids x509_get_subject().

With Mbed TLS, the x509_get_subject() function already returned an error
when there is an embedded null-byte. (As of Mbed TLS 3.5.) Here too, we
added a check for null-bytes to the function where we extract individual
fields from the subject.

Also, backend_x509_get_username() is changed so that it returns the
value of the *last* matching field, to be consistent with the behavior
of the OpenSSL backend.

This is a partial backport of the commit
"Check for \0 and RFC 2253 chars in cert subjects" from the master
branch but skipping the part about escaping RFC 2253 characters to avoid
user-visible changes in a patch release. We do not consider the
null-byte check "user-visible" because we don't expect users to put
null-bytes into the common name.

v2: The previous version of the commit unescaped control characters in
the subject, so it had user-visible changes after all. This version
escapes any control characters in the subject.

Discovered and reported by BreachX Zero Day Labs, using Typhon AI Mil v2.
Contributing Researcher: Vivek Parikh.

CVE: 2026-84790
Reported-by: Vivek Parikh <vivek.parikh@breachx.ai>
Github: OpenVPN/openvpn-private-issues#163

Change-Id: Iea1481e94ba1abe18c39d81cd797187c88427571
Signed-off-by: Max Fillinger <maximilian.fillinger@sentyron.com>
Acked-by: Steffan Karger <steffan@karger.me>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1902
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.7.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1902
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Steffan Karger <steffan@karger.me>

        
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index 66cc66e..1319c07 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -214,6 +214,24 @@
     }
 }
 
+static bool
+asn1_buf_is_cstr_compatible(const mbedtls_asn1_buf *asn1_buf)
+{
+    if (!(asn1_buf->tag == MBEDTLS_ASN1_UTF8_STRING || asn1_buf->tag == MBEDTLS_ASN1_PRINTABLE_STRING
+          || asn1_buf->tag == MBEDTLS_ASN1_IA5_STRING))
+    {
+        return false;
+    }
+    for (size_t i = 0; i < asn1_buf->len; i++)
+    {
+        if (asn1_buf->p[i] == '\0')
+        {
+            return false;
+        }
+    }
+    return true;
+}
+
 result_t
 backend_x509_get_username(char *cn, size_t cn_len, char *x509_username_field, mbedtls_x509_crt *cert)
 {
@@ -259,16 +277,17 @@
     }
 
     /* Find field_oid in the subject name. */
-    mbedtls_x509_name *name = &cert->subject;
-    while (name != NULL)
+    mbedtls_x509_name *name = NULL;
+    mbedtls_x509_name *next = &cert->subject;
+    while (next != NULL)
     {
-        if (strlen(field_oid) == name->oid.len
-            && 0 == memcmp(name->oid.p, field_oid, name->oid.len))
+        if (strlen(field_oid) == next->oid.len
+            && 0 == memcmp(next->oid.p, field_oid, next->oid.len))
         {
-            break;
+            name = next;
         }
 
-        name = name->next;
+        next = next->next;
     }
 
     /* Not found, return an error if this is the peer's certificate */
@@ -277,6 +296,11 @@
         goto fail;
     }
 
+    if (!asn1_buf_is_cstr_compatible(&name->val))
+    {
+        goto fail;
+    }
+
     /* Check that we have room in the buffer, including the terminating '/0' byte. */
     if (cn_len <= name->val.len)
     {
@@ -586,22 +610,11 @@
 static char *
 asn1_buf_to_c_string(const mbedtls_asn1_buf *orig, struct gc_arena *gc)
 {
-    size_t i;
     char *val;
 
-    if (!(orig->tag == MBEDTLS_ASN1_UTF8_STRING || orig->tag == MBEDTLS_ASN1_PRINTABLE_STRING
-          || orig->tag == MBEDTLS_ASN1_IA5_STRING))
+    if (!asn1_buf_is_cstr_compatible(orig))
     {
-        /* Only support C-string compatible types */
-        return string_alloc("ERROR: unsupported ASN.1 string type", gc);
-    }
-
-    for (i = 0; i < orig->len; ++i)
-    {
-        if (orig->p[i] == '\0')
-        {
-            return string_alloc("ERROR: embedded null value", gc);
-        }
+        return string_alloc("ERROR: Unsupported string type or embedded null bytes.", gc);
     }
     val = gc_malloc(orig->len + 1, false, gc);
     memcpy(val, orig->p, orig->len);
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index a30099d..1f2804f 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -196,12 +196,13 @@
     int lastpos = -1;
     int tmp = -1;
     unsigned char *buf = NULL;
+    result_t ret = FAILURE;
 
     ASN1_OBJECT *field_name_obj = OBJ_txt2obj(field_name, 0);
     if (field_name_obj == NULL)
     {
         msg(D_TLS_ERRORS, "Invalid X509 attribute name '%s'", field_name);
-        return FAILURE;
+        goto exit;
     }
 
     ASSERT(size > 0);
@@ -222,28 +223,31 @@
     /* Nothing found */
     if (lastpos == -1)
     {
-        return FAILURE;
+        goto exit;
     }
 
     const X509_NAME_ENTRY *x509ne = X509_NAME_get_entry(x509, lastpos);
     if (!x509ne)
     {
-        return FAILURE;
+        goto exit;
     }
 
     const ASN1_STRING *asn1 = X509_NAME_ENTRY_get_data(x509ne);
     if (!asn1)
     {
-        return FAILURE;
+        goto exit;
     }
-    if (ASN1_STRING_to_UTF8(&buf, asn1) < 0)
+    int length = ASN1_STRING_to_UTF8(&buf, asn1);
+    if (length < 0 || (size_t)length != strlen((char *)buf))
     {
-        return FAILURE;
+        goto exit;
     }
 
     strncpynt(out, (char *)buf, size);
 
-    const result_t ret = (strlen((char *)buf) < size) ? SUCCESS : FAILURE;
+    ret = (strlen((char *)buf) < size) ? SUCCESS : FAILURE;
+
+exit:
     OPENSSL_free(buf);
     return ret;
 }
@@ -384,9 +388,9 @@
         goto err;
     }
 
+    /* Get the subject with unescaped control characters so that we can check for null bytes. */
     X509_NAME_print_ex(subject_bio, X509_get_subject_name(cert), 0,
-                       XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_UTF8_CONVERT
-                           | ASN1_STRFLGS_ESC_CTRL);
+                       XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_UTF8_CONVERT);
 
     if (BIO_eof(subject_bio))
     {
@@ -394,6 +398,25 @@
     }
 
     BIO_get_mem_ptr(subject_bio, &subject_mem);
+    if (memchr(subject_mem->data, 0, subject_mem->length) != NULL)
+    {
+        msg(M_WARN, "ERROR: Certificate subject contains a '\\0' byte.");
+        goto err;
+    }
+
+    /* Now output the subject with escaped control characters. */
+    if (BIO_reset(subject_bio) != 1)
+    {
+        goto err;
+    }
+    X509_NAME_print_ex(subject_bio, X509_get_subject_name(cert), 0,
+                       XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_UTF8_CONVERT
+                           | ASN1_STRFLGS_ESC_CTRL);
+    if (BIO_eof(subject_bio))
+    {
+        goto err;
+    }
+    BIO_get_mem_ptr(subject_bio, &subject_mem);
 
     subject = gc_malloc(subject_mem->length + 1, false, gc);
 
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index 7e7679c..adfc07a 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -884,6 +884,94 @@
     free_certificate(cert);
 }
 
+/* Certificate with two CNs, "foo" and "bar".
+ *
+ * Generated with:
+ * openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -subj "/CN=foo/CN=bar" \
+ * -noenc -out two_cns.crt -keyout two_cns.key
+ */
+static const char *cert_with_two_cns =
+    "-----BEGIN CERTIFICATE-----\n"
+    "MIIByTCCAVCgAwIBAgIUZuvd8Wfnq5jeRc3ohoJ/Vza54wQwCgYIKoZIzj0EAwIw\n"
+    "HDEMMAoGA1UEAwwDZm9vMQwwCgYDVQQDDANiYXIwHhcNMjYwODI4MTU1NjAwWhcN\n"
+    "MjYwOTI3MTU1NjAwWjAcMQwwCgYDVQQDDANmb28xDDAKBgNVBAMMA2JhcjB2MBAG\n"
+    "ByqGSM49AgEGBSuBBAAiA2IABERAfb210NOACy+QVYAu3EXrcGhTJpZDfhpDnE/h\n"
+    "PvPMWGWzqecTYdseArxZc0T/5Xma36IKCjGGsgN9ypZ5oQugQlB/NrVRCJIuHSGA\n"
+    "hGBWFvnUsqdNo765lGwVdBwhY6NTMFEwHQYDVR0OBBYEFPwnD+wK9R81Syk0qyTI\n"
+    "dFT/BNoJMB8GA1UdIwQYMBaAFPwnD+wK9R81Syk0qyTIdFT/BNoJMA8GA1UdEwEB\n"
+    "/wQFMAMBAf8wCgYIKoZIzj0EAwIDZwAwZAIwGxazGb6RRQtXzOWCPLRKId4e+E88\n"
+    "cwoCK3UwzEr8+Ddf54w5cEZC54f5J6AKFUJjAjBpT/JqF41uK57H+8i/16oZkBcm\n"
+    "OyQnlH8W/UzZo3/weTEBTcNW0iuCpIrS6im8pSk=\n"
+    "-----END CERTIFICATE-----\n";
+
+void
+ssl_test_extract_last_matching_field(void **state)
+{
+    /* When there are multiple fields of the same type in the certificate's subject, OpenVPN
+     * should extract the value of the last matching field. This is essentially arbitrary and there
+     * is no correct choice here, but this test exists to make sure that the behavior is consistent
+     * between different backends.
+     */
+    openvpn_x509_cert_t *cert = get_certificate(cert_with_two_cns);
+
+    char username[TLS_USERNAME_LEN + 1] = { 0 };
+    assert_int_equal(backend_x509_get_username(username, sizeof(username), "CN", cert), SUCCESS);
+    assert_string_equal(username, "bar");
+    free_certificate(cert);
+}
+
+/* Certificate with a null-byte embedded in the CN.
+ *
+ * Generated with the following Python script:
+ *
+ * from cryptography import x509
+ * from cryptography.x509.oid import NameOID, ExtensionOID, ExtendedKeyUsageOID
+ * from cryptography.hazmat.primitives import hashes, serialization
+ * from cryptography.hazmat.primitives.asymmetric import ec
+ * import datetime
+ *
+ * private_key = ec.generate_private_key(ec.SECP384R1())
+ * now = datetime.datetime.now(datetime.timezone.utc)
+ * name = "with\x00null"
+ *
+ * cert = (x509.CertificateBuilder()
+ *             .subject_name(x509.Name([x509.NameAttribute(NameOID.COMMON_NAME, name)]))
+ *             .issuer_name(x509.Name([x509.NameAttribute(NameOID.COMMON_NAME, name)]))
+ *             .public_key(private_key.public_key())
+ *             .serial_number(x509.random_serial_number())
+ *             .not_valid_before(now)
+ *             .not_valid_after(now + datetime.timedelta(days=10 * 365))
+ *             .sign(private_key, hashes.SHA256()))
+ *
+ * print(str(cert.public_bytes(serialization.Encoding.PEM), encoding='utf-8'))
+ **/
+static const char *cert_with_null =
+    "-----BEGIN CERTIFICATE-----\n"
+    "MIIBZTCB66ADAgECAhRLWdNRl+C20KKBG4QC9HFPWlOtBzAKBggqhkjOPQQDAjAU\n"
+    "MRIwEAYDVQQDDAl3aXRoAG51bGwwHhcNMjYwODI4MTQzMDA4WhcNMzYwODI1MTQz\n"
+    "MDA4WjAUMRIwEAYDVQQDDAl3aXRoAG51bGwwdjAQBgcqhkjOPQIBBgUrgQQAIgNi\n"
+    "AAT7PE+vJCBiB4CVHBcvJVF9n5n/dGQIn4C8HeYE8M2iXYCIRW5wg6/mlPaeiJY/\n"
+    "Ywh3pa8zhto1+aczbJKTvLgRwXn6N5vNpME1c5iWMzY0WHe1dJyVtoRBvkNvy5+k\n"
+    "GuEwCgYIKoZIzj0EAwIDaQAwZgIxAP2ekdQ8muG8Nv2o3PsBp0CqiaSNByGiP75i\n"
+    "k099bUFvHp/3LSp8Wf4JK2iWzc5h6gIxAINBGg2xjlmMgpXxROKA9qQqaM3d92Mp\n"
+    "EzZyRyPM3PGR83ZPbIaYDq8lCVxVlbYr/Q==\n"
+    "-----END CERTIFICATE-----\n";
+
+void
+ssl_test_reject_null_in_cert_subject(void **state)
+{
+    openvpn_x509_cert_t *cert = get_certificate(cert_with_null);
+    struct gc_arena gc = gc_new();
+
+    /* Trying to get the subject as a whole should fail. */
+    assert_ptr_equal(x509_get_subject(cert, &gc), NULL);
+
+    /* Trying to extract the common name should fail. */
+    char username[TLS_USERNAME_LEN + 1] = { 0 };
+    assert_int_equal(backend_x509_get_username(username, sizeof(username), "CN", cert), FAILURE);
+    gc_free(&gc);
+    free_certificate(cert);
+}
 
 int
 main(void)
@@ -908,7 +996,9 @@
         cmocka_unit_test(test_data_channel_roundtrip_bf_cbc),
         cmocka_unit_test(test_data_channel_known_vectors_epoch),
         cmocka_unit_test(test_data_channel_known_vectors_shortpktid),
-        cmocka_unit_test(crypto_test_print_cert_details)
+        cmocka_unit_test(crypto_test_print_cert_details),
+        cmocka_unit_test(ssl_test_extract_last_matching_field),
+        cmocka_unit_test(ssl_test_reject_null_in_cert_subject)
 
     };
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
