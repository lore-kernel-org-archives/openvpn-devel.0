Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BDF606A327
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bM2nXt2O;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TnnuMzSK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aPp3oK0c;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DSWXRz7u
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=eMQvtWmTA2wqtYAghEI7/UWY4tzMQnBP2Cf2fBdeI7U=; b=bM2nXt2OwnZ2WsO7O2WLlP48cR
	Nxjg1sIVPG8ZPQ7h3EwIRoVj03uozBqtHKeFKJBQy3mDKrOPBzrwvDFuVXJNeQhcKci1zPagi3KvX
	PLRmJTiT5ZFMk5+hA4jhvXGSLhUX4FrL9JsaNvk47eCsAM1JG70ixXu0Yz+YuY2YmVZs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNp3s-000000001tD-1Ctp;
	Mon, 02 Nov 2026 10:14:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNp3q-000000001t7-0hr9
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 10:14:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wdQuxhsmce+RcFLIOxFn3pqgyx7oq+RTu3M2mcaVNjw=; b=TnnuMzSKZAkEYh732eM9nehDKK
 5QQ24jyOBrXZsuia0EFB+rCg1HhpirD39SCfopn1AKNe3IOSMgISZ/e8Ai1Db1rYDmNl/aK8kpJ/h
 TrNft4l5O5nPOweQE+Kqz2Hxjg7Ak7+1SmeT8QveZn0YLl0UEu+Dg+oI77zSQtjhI1cc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wdQuxhsmce+RcFLIOxFn3pqgyx7oq+RTu3M2mcaVNjw=; b=aPp3oK0cfZtc1whs+7xiYb7Ahg
 SEfDwG9xrD06xb+U5i/73/byElWrQKlwMl03wn9GKkkWfwbZZa92WSOzK6cORWAV/wUnVdLMshks2
 +UmUJPL44kwaCpLQZow++/ZwajP5idqfaBS1r7+LESeAfHt9uu6EVFhsiuXVbI+Y3KsE=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNp3o-000000002su-19EL for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 10:14:42 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so18041285e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 02:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793614474; x=1794219274; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wdQuxhsmce+RcFLIOxFn3pqgyx7oq+RTu3M2mcaVNjw=;
 b=DSWXRz7u96jrsc6dvt/oLXd2NXXQGjtcR7RZpR6Kwkn4XFGGrOO04XOaBn2QlhKZN+
 5aWSSx4nOMIESB2du+y69/w17EQeaNPeGLRP9uMWX97p9F1XoLbX+Psrqjoy+g/4YNL4
 y92TCQ8Mqfq6UhrCx0KP09yud6FXdDygd812CZcr+5uHVHfU9MN9AiR8pknLuewtf3CM
 ZyJsNITo7lcTQ+NCJ1JomFilMctyKqmkyOS7LnmXl/CyRSQE2t4qYDXTEA4fZ41xTJL0
 yj2ynLRiTvAysu8SlCNj/YKKmVdJ2L82E0/D+EmecohZe+KbRCW0MUSjsFSiXG0X3bm7
 zIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793614474; x=1794219274;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wdQuxhsmce+RcFLIOxFn3pqgyx7oq+RTu3M2mcaVNjw=;
 b=clHLWZUeKGlsl+nbPeU3UylH4ZqO69wBntPnKe3SJOiNP/XBN7BZUfLCHAGXvJ6t93
 3Myftm7p60eYMZJ7T0lW+5sE4zjrxvDIHVjCU+wzfsRKt7mQ/QJT4hasgkfgPEBqTaTV
 8v+6M/+NcJWiBeM5lcuWHmbDgPVa5LOSgucCvRSKzuzQD20DsFzmjg7JqLEDfMdzicLj
 iEWPql3NSsutTzm743/oonvaMfsoKkqN8JOoGKGq2mnQbXIFj5+c1TbzozYn8gFTXYVJ
 qXDNun9c/fiMXAGfUJHEdjdnbx+5EHCjlTVq50s272RooM9zze4qYBVWP9MLLrOZBBwZ
 wCLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxKexFh4b+/cGdAeKhKG9/1T8HMI3GEe/uayMR3CxxL3F+80PW2Bv4hZfDamApId2DL+MStB7V0UVabfrTe@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJsynjDdnDchf4SCmyVRZ7le0CpKn2IMoqf53LGc+XGXxxaPAao
 t8wK7HYpPc/cc/IF0f1KfPnlcvCSy81gH3JmvZMrZZW+WLD+vpraoSyuSnbf9nVGE30lCMCII8Y
 TIOwxYNfTjwrXRhdcT6dbbeTK8rwqQVB95zbzXOFmGp6V/GP9ypcc5mkLy8NnZSyoVg/U
X-Gm-Gg: AYBFou3FtwZfSzZb++7bajxigdUur4b1T+vPga4mZhB2EQrhDdza13F2Qv1bdaAnXEK
 yk7o9C2/994u4QYXQrYuQC0okEXbui6OhyeaeCmUSxwF8lws02B8qIXBw6cdB8LBbmpiDfAC5UX
 WAdeHsY83Reo0pQt2TJKOF93puJm6C2VRspe/y3qIDp5z4SzqFWe/QTrmM9dcUtnojJi6xgzRlW
 JXHqRJnZpEak9sDQuKgQhd0Ee2d3ND99FtgCR1VGyXFifDH/2eHT4ypwNXzMR+QkDhMCHgNAJNO
 CJ6nCyqoLHh1/IEwwAScMhu6Ll2NS5fDH1kmYwNoiqgRsPFggIiUIifqXtS17efQbKiX1g0r6kl
 vqUHB5uw7cQRNoUozcSyWj5j6q8wFp32+yVFRRDZTYWJrGrpioMM07RhIPBWDqll/tU4ySr71XY
 lMeIYWoypTV7SI8wD5MYmk5V7fWj86xZ5kP8/QUJIPfp9ImX3HH3Q0oGBd1xseSzQGjDGKgmbfD
 ChC/NN4+9aiOfqZlpmTiswSBra+zp+FS9gxsE98RvJMdRTzsC/rakNd7DfIGhY0Hww6JXbkTY7a
 Z9x7o1Ka0X4eZjuV4zVmFRXDwURuelBCRC7A9plxgCVVklS0OsSWzPJA39wlPQz1OknKQR+1tNw
 uQyNgyJImzylO95upPXj+Yt8YurysOmNibNvXfYCIjYQODdIxxJXvq/QZd4Y0+sSndy4tvqZ9Ye
 aj9mUNvqQtbtEI7A==
X-Received: by 2002:a05:600c:34d6:b0:4a2:a9:ed5a with SMTP id
 5b1f17b1804b1-4ac17b2bc58mr201467725e9.8.1793614473447; 
 Mon, 02 Nov 2026 02:14:33 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d425sm19638573f8f.1.2026.11.02.02.14.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 02:14:33 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 10:14:32 +0000
To: Heiko Hund <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Id21a6b106c49d6647783e09a506add0726a1a6d2
X-Gerrit-Change-Number: 2016
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2016?usp=email>
X-Gerrit-Commit: 9d7d3603a68d9a63b66a17d7d42d158c8b87ba33
In-Reply-To: <gerrit.1792329007000.Id21a6b106c49d6647783e09a506add0726a1a6d2@gerrit.openvpn.net>
References: <gerrit.1792329007000.Id21a6b106c49d6647783e09a506add0726a1a6d2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMzI5MDA3MDAwLklkMjFhNmIxMDZjNDlkNjY0Nzc4M2UwOWE1MDZhZGQwNzI2YTFhNmQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <48289a987d1b6647f7e9d661a48c02c06afbd208-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNp3o-000000002su-19EL
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv: skip
 conversion of empty domain names
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 selva.nair@gmail.com, openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5211355042125348570=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5211355042125348570==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HcMFi7S6OD8="; charset=UTF-8

--HcMFi7S6OD8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2016?usp=3Demail )

Change subject: openvpnserv: skip conversio=
n of empty domain names
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

openvpnserv: skip conversion of empty domain names

Empty entrie=
s in an interface's comma separated domain list, were
converted to "=2E" in=
 the resulting MULTI_SZ and used as a match all
in the resulting NRPT rules=
, so all DNS queries would be sent
to that adapter's name server(s) instead=
 of only the ones for its
domains=2E Such lists are not expected to be foun=
d in the registry,
but skip empty entries anyway, just to be sure=2E

Also =
rework the ConvertItfDnsDomains() unit tests to use a helper
that runs the =
conversion on an individually sized heap buffer with
everything after the i=
nput poisoned=2E This detects terminators that
are counted but not written,=
 which zero-initialized stack buffers
hid=2E Also add more tests for empty =
entries and buffer size boundaries=2E

Bonus: fix typo in related doxygen c=
omment=2E

Reported-by: Marc Heuse <marc@srlabs=2Ede>
Change-Id: Id21a6b106=
c49d6647783e09a506add0726a1a6d2
Signed-off-by: Heiko Hund <heiko@ist=2Eeige=
ntlich=2Enet>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2016
Message-Id: <20261031225615=
=2E18613-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg40387=2Ehtml
Signed-off-by: Gert =
Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpnserv/interactive=2Ec
M t=
ests/unit_tests/openvpnserv/test_openvpnserv=2Ec
2 files changed, 77 insert=
ions(+), 75 deletions(-)




diff --git a/src/openvpnserv/interactive=2Ec b=
/src/openvpnserv/interactive=2Ec
index e8203c6e=2E=2Ee2f17f0 100644
--- a/s=
rc/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -22=
78,6 +2278,7 @@
  * In case of an error \p size is set to 0 and the content=
s of \p domains
  * are invalid=2E
  * Note that domains are deleted from t=
he string if they match a search domain=2E
+ * Empty entries (e=2Eg=2E from=
 leading, trailing or double commas) are skipped=2E
  *
  * @param[in]     =
search_domains  optional string of comma separated search domains
  * @para=
m[in,out] domains         buffer that contains the input comma-separated
@@=
 -2319,7 +2320,7 @@
         PWCHAR comma =3D wcschr(domain, L',');
       =
  size_t domain_len =3D comma ? (size_t)(comma - domain) : wcslen(domain);
=
 
-        if (ListContainsDomain(search_domains, domain, domain_len))
+   =
     if (domain_len =3D=3D 0 || ListContainsDomain(search_domains, domain, =
domain_len))
         {
             /* Skip this domain */
             do=
main =3D comma ? comma + 1 : domain + domain_len;
@@ -2372,7 +2373,7 @@
 /*=
*
  * Return interface specific domain suffix(es)
  *
- * The \p domains pa=
ramter will be set to a MULTI_SZ domains string=2E
+ * The \p domains param=
eter will be set to a MULTI_SZ domains string=2E
  * In case of an error or=
 if no domains are found for the interface
  * \p size is set to 0 and the =
contents of \p domains are invalid=2E
  * Note that the domains could have =
been set by DHCP or manually=2E
diff --git a/tests/unit_tests/openvpnserv/t=
est_openvpnserv=2Ec b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
ind=
ex 4ca715b=2E=2Ea99a6f1 100644
--- a/tests/unit_tests/openvpnserv/test_open=
vpnserv=2Ec
+++ b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
@@ -56,=
101 +56,102 @@
     assert_false(ListContainsDomain(L"internal=2Eopenvpn=2E=
net,openvpn=2Ecom", domain, domain_len));
 }
 
+/*
+ * Run ConvertItfDnsDom=
ains() on a heap buffer of exactly capacity bytes,
+ * so that ASAN can det=
ect overruns, with everything after the input string
+ * poisoned, so that =
terminators which are counted but not written show=2E
+ */
+static void
+ch=
eck_convert(PCWSTR search_domains, PCWSTR input, DWORD capacity,
+         =
     LSTATUS expected_err, PCWSTR expected)
+{
+    const DWORD glyph_size =
=3D sizeof(wchar_t);
+
+    /* Size of the expected MULTI_SZ including both=
 terminators, or 0 */
+    DWORD expected_size =3D 0;
+    if (expected)
+ =
   {
+        PCWSTR end =3D expected;
+        while (*end)
+        {
+  =
          end +=3D wcslen(end) + 1;
+        }
+        expected_size =3D (=
DWORD)(end - expected + 1) * glyph_size;
+    }
+
+    DWORD size =3D (DWOR=
D)(wcslen(input) + 1) * glyph_size;
+    assert_true(size <=3D capacity);
+=

+    wchar_t *domains =3D malloc(capacity);
+    assert_non_null(domains);=

+    memset(domains, 0x41, capacity);
+    memcpy(domains, input, size);
+=

+    LSTATUS err =3D ConvertItfDnsDomains(search_domains, domains, &size, =
capacity);
+    assert_int_equal(err, expected_err);
+    assert_int_equal(=
size, expected_size);
+    if (expected_size)
+    {
+        assert_memory=
_equal(domains, expected, expected_size);
+    }
+    free(domains);
+}
+
 =
#define BUF_SIZE 64
 static void
 test_convert_itf_dns_domains(void **state=
)
 {
-    DWORD size, len;
-    LSTATUS err;
     const DWORD glyph_size =
=3D sizeof(wchar_t);
+    const DWORD cap =3D BUF_SIZE * glyph_size;
 
    =
 /* Remove the domain from a single-entry list */
-    wchar_t domains_0[BU=
F_SIZE] =3D L"openvpn=2Ecom";
-    len =3D (DWORD)wcslen(domains_0) + 1;
- =
   size =3D len * glyph_size;
-    err =3D ConvertItfDnsDomains(L"openvpn=
=2Ecom", domains_0, &size, sizeof(domains_0));
-    assert_int_equal(size, =
0);
-    assert_int_equal(err, ERROR_FILE_NOT_FOUND);
+    check_convert(L"=
openvpn=2Ecom", L"openvpn=2Ecom", cap, ERROR_FILE_NOT_FOUND, NULL);
 
     =
/* Remove no domain from a single-entry list */
-    wchar_t domains_1[BUF_=
SIZE] =3D L"openvpn=2Ecom";
-    len =3D (DWORD)wcslen(domains_1) + 1;
-   =
 size =3D len * glyph_size;
-    wchar_t domains_1_res[] =3D L"=2Eopenvpn=
=2Ecom\0";
-    err =3D ConvertItfDnsDomains(L"openvpn=2Enet", domains_1, &=
size, sizeof(domains_1));
-    assert_memory_equal(domains_1, domains_1_res=
, size);
-    assert_int_equal(size, sizeof(domains_1_res));
-    assert_in=
t_equal(err, NO_ERROR);
+    check_convert(L"openvpn=2Enet", L"openvpn=2Eco=
m", cap, NO_ERROR, L"=2Eopenvpn=2Ecom\0");
 
     /* Remove the second doma=
in from a two-entry list */
-    wchar_t domains_2[BUF_SIZE] =3D L"openvpn=
=2Ecom,openvpn=2Enet";
-    len =3D (DWORD)wcslen(domains_2) + 1;
-    size=
 =3D len * glyph_size;
-    wchar_t domains_2_res[] =3D L"=2Eopenvpn=2Ecom\=
0";
-    err =3D ConvertItfDnsDomains(L"openvpn=2Enet", domains_2, &size, s=
izeof(domains_2));
-    assert_memory_equal(domains_2, domains_2_res, size)=
;
-    assert_int_equal(size, sizeof(domains_2_res));
-    assert_int_equal=
(err, NO_ERROR);
+    check_convert(L"openvpn=2Enet", L"openvpn=2Ecom,openv=
pn=2Enet", cap, NO_ERROR, L"=2Eopenvpn=2Ecom\0");
 
     /* Remove the firs=
t domain from a two-entry list */
-    wchar_t domains_3[BUF_SIZE] =3D L"op=
envpn=2Ecom,openvpn=2Enet";
-    len =3D (DWORD)wcslen(domains_3) + 1;
-   =
 size =3D len * glyph_size;
-    wchar_t domains_3_res[] =3D L"=2Eopenvpn=
=2Enet\0";
-    err =3D ConvertItfDnsDomains(L"openvpn=2Ecom", domains_3, &=
size, sizeof(domains_3));
-    assert_memory_equal(domains_3, domains_3_res=
, size);
-    assert_int_equal(size, sizeof(domains_3_res));
-    assert_in=
t_equal(err, NO_ERROR);
+    check_convert(L"openvpn=2Ecom", L"openvpn=2Eco=
m,openvpn=2Enet", cap, NO_ERROR, L"=2Eopenvpn=2Enet\0");
 
     /* Remove n=
o domain from a two-entry list */
-    wchar_t domains_4[BUF_SIZE] =3D L"op=
envpn=2Ecom,openvpn=2Enet";
-    len =3D (DWORD)wcslen(domains_4) + 1;
-   =
 size =3D len * glyph_size;
-    wchar_t domains_4_res[] =3D L"=2Eopenvpn=
=2Ecom\0=2Eopenvpn=2Enet\0";
-    err =3D ConvertItfDnsDomains(NULL, domain=
s_4, &size, sizeof(domains_4));
-    assert_memory_equal(domains_4, domains=
_4_res, size);
-    assert_int_equal(size, sizeof(domains_4_res));
-    ass=
ert_int_equal(err, NO_ERROR);
+    check_convert(NULL, L"openvpn=2Ecom,open=
vpn=2Enet", cap, NO_ERROR, L"=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet\0");
 
    =
 /* Remove the first domain from a three-entry list */
-    wchar_t domains=
_5[BUF_SIZE] =3D L"openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg";
-    len =3D=
 (DWORD)wcslen(domains_5) + 1;
-    size =3D len * glyph_size;
-    wchar_t=
 domains_5_res[] =3D L"=2Eopenvpn=2Enet\0=2Eopenvpn=2Eorg\0";
-    err =3D =
ConvertItfDnsDomains(L"openvpn=2Ecom", domains_5, &size, sizeof(domains_5))=
;
-    assert_memory_equal(domains_5, domains_5_res, size);
-    assert_int=
_equal(size, sizeof(domains_5_res));
-    assert_int_equal(err, NO_ERROR);
=
+    check_convert(L"openvpn=2Ecom", L"openvpn=2Ecom,openvpn=2Enet,openvpn=
=2Eorg", cap, NO_ERROR,
+                  L"=2Eopenvpn=2Enet\0=2Eopenvpn=
=2Eorg\0");
 
     /* Remove the middle domain from a three-entry list */
-=
    wchar_t domains_6[BUF_SIZE] =3D L"openvpn=2Ecom,openvpn=2Enet,openvpn=
=2Eorg";
-    len =3D (DWORD)wcslen(domains_6) + 1;
-    size =3D len * gly=
ph_size;
-    wchar_t domains_6_res[] =3D L"=2Eopenvpn=2Ecom\0=2Eopenvpn=2E=
org\0";
-    err =3D ConvertItfDnsDomains(L"openvpn=2Enet", domains_6, &siz=
e, sizeof(domains_6));
-    assert_memory_equal(domains_6, domains_6_res, s=
ize);
-    assert_int_equal(size, sizeof(domains_6_res));
-    assert_int_e=
qual(err, NO_ERROR);
+    check_convert(L"openvpn=2Enet", L"openvpn=2Ecom,o=
penvpn=2Enet,openvpn=2Eorg", cap, NO_ERROR,
+                  L"=2Eopenvpn=
=2Ecom\0=2Eopenvpn=2Eorg\0");
 
     /* Remove the last domain from a three=
-entry list */
-    wchar_t domains_7[BUF_SIZE] =3D L"openvpn=2Ecom,openvpn=
=2Enet,openvpn=2Eorg";
-    len =3D (DWORD)wcslen(domains_7) + 1;
-    size=
 =3D len * glyph_size;
-    wchar_t domains_7_res[] =3D L"=2Eopenvpn=2Ecom\=
0=2Eopenvpn=2Enet\0";
-    err =3D ConvertItfDnsDomains(L"openvpn=2Eorg", d=
omains_7, &size, sizeof(domains_7));
-    assert_memory_equal(domains_7, do=
mains_7_res, size);
-    assert_int_equal(size, sizeof(domains_7_res));
-  =
  assert_int_equal(err, NO_ERROR);
+    check_convert(L"openvpn=2Eorg", L"o=
penvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg", cap, NO_ERROR,
+                =
  L"=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet\0");
 
-    /* Remove the last domai=
n from a four-entry list because of size constraints*/
-    wchar_t domains=
_8[BUF_SIZE] =3D L"openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg,am-ende-noch-e=
ine-lange=2Ede";
-    len =3D (DWORD)wcslen(domains_8) + 1;
-    size =3D l=
en * glyph_size;
-    wchar_t domains_8_res[] =3D L"=2Eopenvpn=2Ecom\0=2Eop=
envpn=2Enet\0=2Eopenvpn=2Eorg\0";
-    err =3D ConvertItfDnsDomains(NULL, d=
omains_8, &size, sizeof(domains_8));
-    assert_memory_equal(domains_8, do=
mains_8_res, size);
-    assert_int_equal(size, sizeof(domains_8_res));
-  =
  assert_int_equal(err, ERROR_MORE_DATA);
+    /* Empty entries are skipped=
 */
+    check_convert(NULL, L",a=2Ecom", cap, NO_ERROR, L"=2Ea=2Ecom\0");
=
+    check_convert(NULL, L"a=2Ecom,", cap, NO_ERROR, L"=2Ea=2Ecom\0");
+   =
 check_convert(NULL, L"a=2Ecom,,b=2Ecom", cap, NO_ERROR, L"=2Ea=2Ecom\0=2Eb=
=2Ecom\0");
+    check_convert(L"a=2Ecom", L",a=2Ecom,", cap, ERROR_FILE_NO=
T_FOUND, NULL);
+    check_convert(NULL, L",,,", cap, ERROR_FILE_NOT_FOUND,=
 NULL);
+    check_convert(NULL, L"", cap, ERROR_FILE_NOT_FOUND, NULL);
+
+=
    /* Size is 0 if all domains are removed */
+    check_convert(L"a=2Ecom=
,b=2Ecom", L"b=2Ecom,a=2Ecom", cap, ERROR_FILE_NOT_FOUND, NULL);
+
+    /* =
Output exactly fills the buffer: 2 * (dot + 5 + NUL) + NUL */
+    check_co=
nvert(NULL, L"a=2Ecom,b=2Ecom", 15 * glyph_size, NO_ERROR, L"=2Ea=2Ecom\0=
=2Eb=2Ecom\0");
+
+    /* Remove the last domain from a four-entry list bec=
ause of size constraints,
+     * all four would need 3 * 13 + 28 + 1 =3D 6=
8 glyphs, the buffer is one glyph short */
+    check_convert(NULL, L"openv=
pn=2Ecom,openvpn=2Enet,openvpn=2Eorg,am-ende-noch-eine-lange=2Ede",
+      =
            67 * glyph_size, ERROR_MORE_DATA, L"=2Eopenvpn=2Ecom\0=2Eopenvp=
n=2Enet\0=2Eopenvpn=2Eorg\0");
+
+    /* Input fills the buffer, no space f=
or dot and terminators */
+    check_convert(NULL, L"a=2Ecom", 6 * glyph_si=
ze, ERROR_MORE_DATA, NULL);
 }
 
 static void

-- 
To view, visit https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2016?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: Id21a6b106c49d6647783e09a506add0726a1a6d2
Gerrit-=
Change-Number: 2016
Gerrit-PatchSet: 3
Gerrit-Owner: Heiko Hund <heiko@open=
vpn=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Lev Sti=
pakov <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: Selva Nair <selva=2Enair@gma=
il=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>

--HcMFi7S6OD8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2016?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">openvpnserv: skip conversion of em=
pty domain names<br><br>Empty entries in an interface&#39;s comma separated=
 domain list, were<br>converted to &quot;=2E&quot; in the resulting MULTI_S=
Z and used as a match all<br>in the resulting NRPT rules, so all DNS querie=
s would be sent<br>to that adapter&#39;s name server(s) instead of only the=
 ones for its<br>domains=2E Such lists are not expected to be found in the =
registry,<br>but skip empty entries anyway, just to be sure=2E<br><br>Also =
rework the ConvertItfDnsDomains() unit tests to use a helper<br>that runs t=
he conversion on an individually sized heap buffer with<br>everything after=
 the input poisoned=2E This detects terminators that<br>are counted but not=
 written, which zero-initialized stack buffers<br>hid=2E Also add more test=
s for empty entries and buffer size boundaries=2E<br><br>Bonus: fix typo in=
 related doxygen comment=2E<br><br>Reported-by: Marc Heuse &lt;marc@srlabs=
=2Ede&gt;<br>Change-Id: Id21a6b106c49d6647783e09a506add0726a1a6d2<br>Signed=
-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>Acked-by: Gert =
Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2016<br>Message-Id: &lt;20261031225615=2E18613-1-ger=
t@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-d=
evel@lists=2Esourceforge=2Enet/msg40387=2Ehtml<br>Signed-off-by: Gert Doeri=
ng &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpnserv/interactive=
=2Ec<br>M tests/unit_tests/openvpnserv/test_openvpnserv=2Ec<br>2 files chan=
ged, 77 insertions(+), 75 deletions(-)<br><br></pre>
<pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span=
>index e8203c6e=2E=2Ee2f17f0 100644</span><br><span>--- a/src/openvpnserv/i=
nteractive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span>=
<br><span>@@ -2278,6 +2278,7 @@</span><br><span>  * In case of an error \p =
size is set to 0 and the contents of \p domains</span><br><span>  * are inv=
alid=2E</span><br><span>  * Note that domains are deleted from the string i=
f they match a search domain=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Empty entries (e=2Eg=2E from leading, trailing or double com=
mas) are skipped=2E</span><br><span>  *</span><br><span>  * @param[in]     =
search_domains  optional string of comma separated search domains</span><br=
><span>  * @param[in,out] domains         buffer that contains the input co=
mma-separated</span><br><span>@@ -2319,7 +2320,7 @@</span><br><span>       =
  PWCHAR comma =3D wcschr(domain, L&#39;,&#39;);</span><br><span>         s=
ize_t domain_len =3D comma ? (size_t)(comma - domain) : wcslen(domain);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if (ListContainsDomain(search_domains, domain, domain_len))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (domain_len =3D=3D 0 ||=
 ListContainsDomain(search_domains, domain, domain_len))</span><br><span>  =
       {</span><br><span>             /* Skip this domain */</span><br><spa=
n>             domain =3D comma ? comma + 1 : domain + domain_len;</span><b=
r><span>@@ -2372,7 +2373,7 @@</span><br><span> /**</span><br><span>  * Retu=
rn interface specific domain suffix(es)</span><br><span>  *</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * The \p domains paramter will be se=
t to a MULTI_SZ domains string=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * The \p domains parameter will be set to a MULTI_SZ domains=
 string=2E</span><br><span>  * In case of an error or if no domains are fou=
nd for the interface</span><br><span>  * \p size is set to 0 and the conten=
ts of \p domains are invalid=2E</span><br><span>  * Note that the domains c=
ould have been set by DHCP or manually=2E</span><br><span>diff --git a/test=
s/unit_tests/openvpnserv/test_openvpnserv=2Ec b/tests/unit_tests/openvpnser=
v/test_openvpnserv=2Ec</span><br><span>index 4ca715b=2E=2Ea99a6f1 100644</s=
pan><br><span>--- a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec</span=
><br><span>+++ b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec</span><b=
r><span>@@ -56,101 +56,102 @@</span><br><span>     assert_false(ListContain=
sDomain(L&quot;internal=2Eopenvpn=2Enet,openvpn=2Ecom&quot;, domain, domain=
_len));</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Run ConvertItfDnsDomains() on a heap buffer of exactly capacity =
bytes,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * so that AS=
AN can detect overruns, with everything after the input string</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * poisoned, so that terminators=
 which are counted but not written show=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+c=
heck_convert(PCWSTR search_domains, PCWSTR input, DWORD capacity,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+              LSTATUS expecte=
d_err, PCWSTR expected)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const DWOR=
D glyph_size =3D sizeof(wchar_t);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* Size of the expected MULTI_SZ including both terminators, or 0 */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD expected_size =3D=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (expected=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        PCWSTR end =3D expected;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        while (*end=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            end +=3D wcslen(=
end) + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        expected_siz=
e =3D (DWORD)(end - expected + 1) * glyph_size;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    D=
WORD size =3D (DWORD)(wcslen(input) + 1) * glyph_size;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_true(size &lt;=3D capacity);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    wchar_t *domains =3D malloc(capacit=
y);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_non_n=
ull(domains);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    me=
mset(domains, 0x41, capacity);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    memcpy(domains, input, size);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    LSTATUS err =3D ConvertItfDnsDomains(search_domains, domains, &am=
p;size, capacity);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(err, expected_err);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_int_equal(size, expected_size);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (expected_size)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        assert_memory_equal(domains, expe=
cted, expected_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(dom=
ains);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #define BUF_S=
IZE 64</span><br><span> static void</span><br><span> test_convert_itf_dns_d=
omains(void **state)</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    DWORD size, len;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    LSTATUS err;</span><br><span>     const DWORD glyph_si=
ze =3D sizeof(wchar_t);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const DWORD cap =3D BUF_SIZE * glyph_size;</span><br><span> </span>=
<br><span>     /* Remove the domain from a single-entry list */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    wchar_t domains_0[BUF_SIZE] =
=3D L&quot;openvpn=2Ecom&quot;;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    len =3D (DWORD)wcslen(domains_0) + 1;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    size =3D len * glyph_size;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    err =3D ConvertItfDnsDomains(L=
&quot;openvpn=2Ecom&quot;, domains_0, &amp;size, sizeof(domains_0));</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(size, 0=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equa=
l(err, ERROR_FILE_NOT_FOUND);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    check_convert(L&quot;openvpn=2Ecom&quot;, L&quot;openvpn=2Eco=
m&quot;, cap, ERROR_FILE_NOT_FOUND, NULL);</span><br><span> </span><br><spa=
n>     /* Remove no domain from a single-entry list */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    wchar_t domains_1[BUF_SIZE] =3D L&quot=
;openvpn=2Ecom&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    len =3D (DWORD)wcslen(domains_1) + 1;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    size =3D len * glyph_size;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    wchar_t domains_1_res[] =3D L&quot;=2Eopen=
vpn=2Ecom\0&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 err =3D ConvertItfDnsDomains(L&quot;openvpn=2Enet&quot;, domains_1, &amp;s=
ize, sizeof(domains_1));</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    assert_memory_equal(domains_1, domains_1_res, size);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(size, sizeof(dom=
ains_1_res));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    asse=
rt_int_equal(err, NO_ERROR);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    check_convert(L&quot;openvpn=2Enet&quot;, L&quot;openvpn=2Ecom=
&quot;, cap, NO_ERROR, L&quot;=2Eopenvpn=2Ecom\0&quot;);</span><br><span> <=
/span><br><span>     /* Remove the second domain from a two-entry list */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wchar_t domains_2[B=
UF_SIZE] =3D L&quot;openvpn=2Ecom,openvpn=2Enet&quot;;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    len =3D (DWORD)wcslen(domains_2) + 1;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size =3D len * gly=
ph_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wchar_t d=
omains_2_res[] =3D L&quot;=2Eopenvpn=2Ecom\0&quot;;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    err =3D ConvertItfDnsDomains(L&quot;ope=
nvpn=2Enet&quot;, domains_2, &amp;size, sizeof(domains_2));</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    assert_memory_equal(domains_2, do=
mains_2_res, size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  assert_int_equal(size, sizeof(domains_2_res));</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    assert_int_equal(err, NO_ERROR);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    check_convert(L&quot;openvp=
n=2Enet&quot;, L&quot;openvpn=2Ecom,openvpn=2Enet&quot;, cap, NO_ERROR, L&q=
uot;=2Eopenvpn=2Ecom\0&quot;);</span><br><span> </span><br><span>     /* Re=
move the first domain from a two-entry list */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    wchar_t domains_3[BUF_SIZE] =3D L&quot;openvpn=
=2Ecom,openvpn=2Enet&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    len =3D (DWORD)wcslen(domains_3) + 1;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    size =3D len * glyph_size;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    wchar_t domains_3_res[] =3D L&quot;=
=2Eopenvpn=2Enet\0&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    err =3D ConvertItfDnsDomains(L&quot;openvpn=2Ecom&quot;, domains_3,=
 &amp;size, sizeof(domains_3));</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    assert_memory_equal(domains_3, domains_3_res, size);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(size, siz=
eof(domains_3_res));</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   assert_int_equal(err, NO_ERROR);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    check_convert(L&quot;openvpn=2Ecom&quot;, L&quot;openvp=
n=2Ecom,openvpn=2Enet&quot;, cap, NO_ERROR, L&quot;=2Eopenvpn=2Enet\0&quot;=
);</span><br><span> </span><br><span>     /* Remove no domain from a two-en=
try list */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wchar_=
t domains_4[BUF_SIZE] =3D L&quot;openvpn=2Ecom,openvpn=2Enet&quot;;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    len =3D (DWORD)wcslen(dom=
ains_4) + 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size =
=3D len * glyph_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    wchar_t domains_4_res[] =3D L&quot;=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet\0=
&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    err =3D Co=
nvertItfDnsDomains(NULL, domains_4, &amp;size, sizeof(domains_4));</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    assert_memory_equal(domain=
s_4, domains_4_res, size);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    assert_int_equal(size, sizeof(domains_4_res));</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(err, NO_ERROR);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_convert(NULL, =
L&quot;openvpn=2Ecom,openvpn=2Enet&quot;, cap, NO_ERROR, L&quot;=2Eopenvpn=
=2Ecom\0=2Eopenvpn=2Enet\0&quot;);</span><br><span> </span><br><span>     /=
* Remove the first domain from a three-entry list */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    wchar_t domains_5[BUF_SIZE] =3D L&quot;=
openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg&quot;;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    len =3D (DWORD)wcslen(domains_5) + 1;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    size =3D len * glyph_siz=
e;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wchar_t domains=
_5_res[] =3D L&quot;=2Eopenvpn=2Enet\0=2Eopenvpn=2Eorg\0&quot;;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    err =3D ConvertItfDnsDomains(=
L&quot;openvpn=2Ecom&quot;, domains_5, &amp;size, sizeof(domains_5));</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_memory_equal(dom=
ains_5, domains_5_res, size);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    assert_int_equal(size, sizeof(domains_5_res));</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(err, NO_ERROR);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_convert(L&q=
uot;openvpn=2Ecom&quot;, L&quot;openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg&q=
uot;, cap, NO_ERROR,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                  L&quot;=2Eopenvpn=2Enet\0=2Eopenvpn=2Eorg\0&quot;);</spa=
n><br><span> </span><br><span>     /* Remove the middle domain from a three=
-entry list */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wch=
ar_t domains_6[BUF_SIZE] =3D L&quot;openvpn=2Ecom,openvpn=2Enet,openvpn=2Eo=
rg&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    len =3D =
(DWORD)wcslen(domains_6) + 1;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    size =3D len * glyph_size;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    wchar_t domains_6_res[] =3D L&quot;=2Eopenvpn=2Ecom\0=
=2Eopenvpn=2Eorg\0&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    err =3D ConvertItfDnsDomains(L&quot;openvpn=2Enet&quot;, domains_6,=
 &amp;size, sizeof(domains_6));</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    assert_memory_equal(domains_6, domains_6_res, size);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(size, siz=
eof(domains_6_res));</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   assert_int_equal(err, NO_ERROR);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    check_convert(L&quot;openvpn=2Enet&quot;, L&quot;openvp=
n=2Ecom,openvpn=2Enet,openvpn=2Eorg&quot;, cap, NO_ERROR,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                  L&quot;=2Eopenvpn=
=2Ecom\0=2Eopenvpn=2Eorg\0&quot;);</span><br><span> </span><br><span>     /=
* Remove the last domain from a three-entry list */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    wchar_t domains_7[BUF_SIZE] =3D L&quot;=
openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg&quot;;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    len =3D (DWORD)wcslen(domains_7) + 1;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    size =3D len * glyph_siz=
e;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wchar_t domains=
_7_res[] =3D L&quot;=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet\0&quot;;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    err =3D ConvertItfDnsDomains(=
L&quot;openvpn=2Eorg&quot;, domains_7, &amp;size, sizeof(domains_7));</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_memory_equal(dom=
ains_7, domains_7_res, size);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    assert_int_equal(size, sizeof(domains_7_res));</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(err, NO_ERROR);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_convert(L&q=
uot;openvpn=2Eorg&quot;, L&quot;openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg&q=
uot;, cap, NO_ERROR,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                  L&quot;=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet\0&quot;);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* R=
emove the last domain from a four-entry list because of size constraints*/<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wchar_t domains_8[=
BUF_SIZE] =3D L&quot;openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg,am-ende-noch=
-eine-lange=2Ede&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    len =3D (DWORD)wcslen(domains_8) + 1;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    size =3D len * glyph_size;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    wchar_t domains_8_res[] =3D L&quot;=2Eo=
penvpn=2Ecom\0=2Eopenvpn=2Enet\0=2Eopenvpn=2Eorg\0&quot;;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    err =3D ConvertItfDnsDomains(NULL, =
domains_8, &amp;size, sizeof(domains_8));</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    assert_memory_equal(domains_8, domains_8_res, size)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal=
(size, sizeof(domains_8_res));</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    assert_int_equal(err, ERROR_MORE_DATA);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Empty entries are skipped */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_convert(NULL, L=
&quot;,a=2Ecom&quot;, cap, NO_ERROR, L&quot;=2Ea=2Ecom\0&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    check_convert(NULL, L&quot=
;a=2Ecom,&quot;, cap, NO_ERROR, L&quot;=2Ea=2Ecom\0&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    check_convert(NULL, L&quot;a=2E=
com,,b=2Ecom&quot;, cap, NO_ERROR, L&quot;=2Ea=2Ecom\0=2Eb=2Ecom\0&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_convert(L&=
quot;a=2Ecom&quot;, L&quot;,a=2Ecom,&quot;, cap, ERROR_FILE_NOT_FOUND, NULL=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_convert=
(NULL, L&quot;,,,&quot;, cap, ERROR_FILE_NOT_FOUND, NULL);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    check_convert(NULL, L&quot;&quot=
;, cap, ERROR_FILE_NOT_FOUND, NULL);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* Size is 0 if all domains are removed */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    check_convert(L&quot;a=2Ecom,b=2Ecom&quot;, L&=
quot;b=2Ecom,a=2Ecom&quot;, cap, ERROR_FILE_NOT_FOUND, NULL);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* Output exactly fills the buffer: 2 * (dot + 5=
 + NUL) + NUL */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 check_convert(NULL, L&quot;a=2Ecom,b=2Ecom&quot;, 15 * glyph_size, NO_ERRO=
R, L&quot;=2Ea=2Ecom\0=2Eb=2Ecom\0&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* Remove the last domain from a four-entry list because of size co=
nstraints,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * al=
l four would need 3 * 13 + 28 + 1 =3D 68 glyphs, the buffer is one glyph sh=
ort */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_con=
vert(NULL, L&quot;openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg,am-ende-noch-ei=
ne-lange=2Ede&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                  67 * glyph_size, ERROR_MORE_DATA, L&quot;=2Eopenvpn=2Eco=
m\0=2Eopenvpn=2Enet\0=2Eopenvpn=2Eorg\0&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* Input fills the buffer, no space for dot and terminators */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_convert(N=
ULL, L&quot;a=2Ecom&quot;, 6 * glyph_size, ERROR_MORE_DATA, NULL);</span><b=
r><span> }</span><br><span> </span><br><span> static void</span><br></pre><=
p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2016=
?usp=3Demail">change 2016</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2016?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Id21a6b106c49d6647783e09a506add0726a1a6d2 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2016 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-O=
wner: Heiko Hund &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@gree=
nie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Lev=
 Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>

</body></html>
--HcMFi7S6OD8=--


--===============5211355042125348570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5211355042125348570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5211355042125348570==--

