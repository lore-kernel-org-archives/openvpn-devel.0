Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94FAC624D6
	for <openvpn-devel@archiver.kernel.org>; Sat,  5 Sep 2026 16:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v3ogRd3APdropVnl9S3ZWF1+ImAfznQ+mcsO6lw7ut0=; b=ILSkwdY9BAfXXfvZj4VKdWAhYU
	3dyZCqtt6D4ZRQ3WkU9YC6luSam3H+Fz2AYJwrCZY+8LXdfSd2YE9YWbehs0N8BKl8TNtdkbhB3DG
	wLhjYyNDqiTbq82EpR9DFIkMhBFtsxxwspu4QrdKojQ3gIlCkCXlYTlU3eEUp6Ui3eAM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2t7d-0001YY-PT;
	Sat, 05 Sep 2026 16:20:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x2t7E-0001WD-OQ
 for openvpn-devel@lists.sourceforge.net;
 Sat, 05 Sep 2026 16:19:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zx5XEqQSg1VEC427lCpNtY4fG67ybTRQnhEtnlLUhv0=; b=abjyfSAOy7O1uDmLLGxZVylaZG
 5ukMq61MsXcdllIbHrdJ2+9ViXGSIrSV6qrJSSdUPzE2VW49+deOD5auL41MqKHEnNcQ9ZVzRE+TA
 vMd/KJs3A55XcVlYl66+9dhN0caFdWB1ofAFceOwGe0y8gjNktudaTxqLrFVOrbyH0Nw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zx5XEqQSg1VEC427lCpNtY4fG67ybTRQnhEtnlLUhv0=; b=ZgQjpRZ7FHZjcyyhMm+fHPUaLM
 c91o4ssVKr3s4AkaWNw/YMZA5Fy7cmfbl92KDjYDUQpTSIQswCtLzMnf2+Q++vArvE0djlG+5BJHJ
 tbeZ4hCIeLsPDUNH0rwtKbtQpQvfZ9yEYWWJMxJbUP9Mwm6fEWEyd1wYZZidUYZkOalc=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2t7D-0002P4-F3 for openvpn-devel@lists.sourceforge.net;
 Sat, 05 Sep 2026 16:19:41 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 685GJWQA008643
 for <openvpn-devel@lists.sourceforge.net>; Sat, 5 Sep 2026 18:19:32 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 685GJWdS008642
 for openvpn-devel@lists.sourceforge.net; Sat, 5 Sep 2026 18:19:32 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat,  5 Sep 2026 18:19:26 +0200
Message-ID: <20260905161931.8629-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1788519683000.Ic334518048d6ca57a504257e210467f9c451d268@gerrit.openvpn.net>
References: <gerrit.1788519683000.Ic334518048d6ca57a504257e210467f9c451d268@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x2t7D-0002P4-F3
Subject: [Openvpn-devel] [PATCH v1] Check for null-bytes in certificate
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

Additionally, we also escape characters in the subject that would make
parsing of the resulting string ambiguous. For example, if the Common
Name is "name, O=InjectedOrg", and the Organization is "RealOrg",
this will now be converted to "CN=name\, O=InjectedOrg, O=RealOrg" to
make it clear which "O" field is legitimate.

With Mbed TLS, the x509_get_subject() function already returned an error
when there is an embedded null-byte. (As of Mbed TLS 3.5.) Here too, we
added a check for null-bytes to the function where we extract individual
fields from the subject.

Also, backend_x509_get_username() is changed so that it returns the
value of the *last* matching field, to be consistent with the behavior
of the OpenSSL backend.

We decided to publish this commit without embargo even though it fixes a
CVE, because exploiting it requires a malicious or very negligent CA.

Discovered and reported by BreachX Zero Day Labs, using Typhon AI Mil v2.
Contributing Researcher: Vivek Parikh.

CVE: 2026-84790
Reported-by: Vivek Parikh <vivek.parikh@breachx.ai>
Github: OpenVPN/openvpn-private-issues#163

Change-Id: Ic334518048d6ca57a504257e210467f9c451d268
Signed-off-by: Max Fillinger <maximilian.fillinger@sentyron.com>
Acked-by: Steffan Karger <steffan@karger.me>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1898
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1898
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Steffan Karger <steffan@karger.me>

        
diff --git a/Changes.rst b/Changes.rst
index 1f992b2..fe81909 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -1,5 +1,25 @@
 Overview of changes in 2.8
 ==========================
+User-visible Changes
+--------------------
+Parsing Distinguished Names in certificates
+    (OpenSSL backend:) OpenVPN now rejects certificates that have a null-byte
+    inside any of the field values of their subject. To avoid ambiguity in the
+    parsed subject, OpenVPN escapes the following characters by prefixing them with
+    a backslash:
+     * " " (space) at the start or end of a field,
+     * "#" at the start of a field,
+     * ",", "+", """, "\", "<", ">" and ";" anywhere.
+
+    As a result, if you use the option ``--verify-x509-name <expected subject>``,
+    you need to prefix these characters with a backslash in your configuration.
+    The subject passed to a ``--tls-verify`` script is escaped in the same way and
+    you may need to adjust your script.
+
+    (Mbed TLS backend:) The behavior has not changed. Subjects with null-bytes were
+    already rejected (assuming OpenVPN was built with Mbed TLS 3.5 or later) and
+    the characters mentioned above were already escaped. However, the behavior of
+    Mbed TLS is slightly different from OpenSSL in that it also escapes "=".
 
 
 Overview of changes in 2.7
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index 2a09e86..9f676ed 100644
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
index b8648fd..a6307f6 100644
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
@@ -385,8 +389,7 @@
     }
 
     X509_NAME_print_ex(subject_bio, X509_get_subject_name(cert), 0,
-                       XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_UTF8_CONVERT
-                           | ASN1_STRFLGS_ESC_CTRL);
+                       XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_ESC_2253 | ASN1_STRFLGS_UTF8_CONVERT);
 
     if (BIO_eof(subject_bio))
     {
@@ -395,6 +398,16 @@
 
     BIO_get_mem_ptr(subject_bio, &subject_mem);
 
+    /* Check subject for '\0' bytes. */
+    for (size_t i = 0; i < subject_mem->length; i++)
+    {
+        if (subject_mem->data[i] == 0)
+        {
+            msg(M_WARN, "ERROR: Certificate subject contains a '\\0' byte.");
+            goto err;
+        }
+    }
+
     subject = gc_malloc(subject_mem->length + 1, false, gc);
 
     memcpy(subject, subject_mem->data, subject_mem->length);
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index 887c492..b07ff2b 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -873,6 +873,157 @@
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
+
+/* Cert with CN="name, O=InjectedOrg" and O=RealOrg.
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
+ * name = "name, O=InjectedOrg"
+ * org = "RealOrg"
+ *
+ * distinguished_name = x509.Name([
+ *     x509.NameAttribute(NameOID.COMMON_NAME, name),
+ *     x509.NameAttribute(NameOID.ORGANIZATION_NAME, org)
+ * ])
+ *
+ * cert = (x509.CertificateBuilder()
+ *             .subject_name(distinguished_name)
+ *             .issuer_name(distinguished_name)
+ *             .public_key(private_key.public_key())
+ *             .serial_number(x509.random_serial_number())
+ *             .not_valid_before(now)
+ *             .not_valid_after(now + datetime.timedelta(days=10 * 365))
+ *             .sign(private_key, hashes.SHA256()))
+ *
+ * print(str(cert.public_bytes(serialization.Encoding.PEM), encoding='utf-8'))
+ */
+static const char *cert_with_rfc_2253_chars =
+    "-----BEGIN CERTIFICATE-----\n"
+    "MIIBnTCCASOgAwIBAgIUR1IGc6A800U14v/ykZNR21aVubowCgYIKoZIzj0EAwIw\n"
+    "MDEcMBoGA1UEAwwTbmFtZSwgTz1JbmplY3RlZE9yZzEQMA4GA1UECgwHUmVhbE9y\n"
+    "ZzAeFw0yNjA4MjgxNTQ3NDdaFw0zNjA4MjUxNTQ3NDdaMDAxHDAaBgNVBAMME25h\n"
+    "bWUsIE89SW5qZWN0ZWRPcmcxEDAOBgNVBAoMB1JlYWxPcmcwdjAQBgcqhkjOPQIB\n"
+    "BgUrgQQAIgNiAAR6zl9QPAbAnHWN//MRdowuhu0Sol6N+lqB/qk+D+2NHCd/t4H9\n"
+    "cJlswUh6EPsmLxgfMYgO2QwClFWEFWvtXQs8BggoidY6i9pmAPhs8+9fmIyuNVpG\n"
+    "3vUWZrUBRgylwaIwCgYIKoZIzj0EAwIDaAAwZQIwKzXmR8YPQZ1pratM9meVmGkH\n"
+    "1rpHgV3U8oeg+jXmfVcZJTpDeDz4yBl4V3KBKT7HAjEAj2qkaTz7fiSwBKsxJQWH\n"
+    "dQFPBCAYU9zZJvlNnEPtmHIwaD/qHXDeClr/HRItU3B9\n"
+    "-----END CERTIFICATE-----\n";
+
+void
+ssl_test_escape_rfc_2253_chars_in_subject(void **state)
+{
+    openvpn_x509_cert_t *cert = get_certificate(cert_with_rfc_2253_chars);
+    struct gc_arena gc = gc_new();
+
+    char *subject = x509_get_subject(cert, &gc);
+    assert_non_null(subject);
+
+    /* Mbed TLS escapes the '=' character but OpenSSL does not. */
+    const char *expected_subject_openssl = "CN=name\\, O=InjectedOrg, O=RealOrg";
+    const char *expected_subject_mbedtls = "CN=name\\, O\\=InjectedOrg, O=RealOrg";
+
+    assert(strcmp(subject, expected_subject_openssl) == 0 || strcmp(subject, expected_subject_mbedtls) == 0);
+    gc_free(&gc);
+    free_certificate(cert);
+}
+
 void
 ssl_test_extract_peer_info(void **state)
 {
@@ -960,6 +1111,9 @@
         cmocka_unit_test(test_data_channel_known_vectors_epoch),
         cmocka_unit_test(test_data_channel_known_vectors_shortpktid),
         cmocka_unit_test(crypto_test_print_cert_details),
+        cmocka_unit_test(ssl_test_extract_last_matching_field),
+        cmocka_unit_test(ssl_test_reject_null_in_cert_subject),
+        cmocka_unit_test(ssl_test_escape_rfc_2253_chars_in_subject),
         cmocka_unit_test(ssl_test_extract_peer_info)
 
     };


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
