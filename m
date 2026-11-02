Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D11606A326
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kTOGA5UJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GGWknI0T;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZVH7LsIJ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=URCR+jzP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=g7gwSqsIEdi1SMmaYq06fKa1+AwrVg+6cwEIvgW/pXQ=; b=kTOGA5UJI6fwNrGDIg8FUXsCtz
	u6YcaTNY3iGQ8WtW8FI/6Y0ngH17UNZ9AvXGkX+Eayq3tDQZS81inCSyZAm9FPVC6UrZO6Mwxj5vm
	zADf0zpSkBisNdTmL8vmo7XWZ19RG+G/X+LwA4Pn0KUDWFHJtQ4YQOBAZareq95+3nXo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNp3t-000000008CA-1InU;
	Mon, 02 Nov 2026 10:14:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNp3r-000000008C4-29qA
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 10:14:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nL3QEy4ZTmVb4RmuQD1n/1kPffwASeKe9ZxS+Y6qLos=; b=GGWknI0TWLYvNTSsOGb8JtosGq
 rcNX7sxR8RaguvIx6tcqjx28p++EbfgkQffapjVNBojLGbKsRnrqBbuRVmJ3YevpcjKrK1FdS65rq
 sXPBm2NwN0QLZhdU/iy+PbHz1LdikbIzLVmU7Kdr6hi2o7LRSFUtXqxgw0nU1nR8YwUE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nL3QEy4ZTmVb4RmuQD1n/1kPffwASeKe9ZxS+Y6qLos=; b=ZVH7LsIJHpeS9MGj720ZWlJxRG
 OSxJ3ykxg25izeryF+IvjWfBi4ze9RrjPxN40rGex2AmDlvFP9eo63eXxjAELdQOK85OwEq+Hs0NS
 lJqbr/zOyY6S/6JZQ21EHDxvNT83sFaj3QZsPxDdFXCFqMEOSpglLtz2tOTjztkLtKGI=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNp3n-0000000038n-1RbQ for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 10:14:43 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso23106245e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 02:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793614473; x=1794219273; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nL3QEy4ZTmVb4RmuQD1n/1kPffwASeKe9ZxS+Y6qLos=;
 b=URCR+jzP8FJX6HSb9Y4eWwpYaSLWL4h6uaeDZlQCgsajZEQvMBqirN3NdZGhbc7m5o
 lfPVuOW9rz5epLpq/RNT9l8+RZ2ezqvEQYwKQehIbfagRM/kbDVw4jaA295/32J62pYO
 r/aUixHRSwXZ+J3wXRL0RSSH6YzmvPDcIpbcDbZunxkSvRUwdyHZlm4jXm0iL0b+Mx0C
 lNGiQCE/nt7jVCSh20/l/kUNu3bU6MRrcNTKEWN20BGj9+GKUreWZKM/cOCsgtsyeMas
 Ta/NmhubJ7FGyyP26dyqhPRUEHBndgnvk8R5Z91iPPg1LcooU3igk1ayp7A3G09GPRaG
 ThbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793614473; x=1794219273;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nL3QEy4ZTmVb4RmuQD1n/1kPffwASeKe9ZxS+Y6qLos=;
 b=z9XWSK0ydwI8dw3nPY0xDfjDYTuI4J78qtHgNPAM50dta6TsXvqmIURp1hyHEHTCca
 3vKQXIxPNSdnatJtd8i7GXUF87VB8pK00GVc0/48L0bL7SM6bf4/IIEEdPtZyuotXlFo
 cuapX0w1QqfKqBvR9MFsG+5IUo3A5Ommb0/md4EFmwJhTTR6HI6HAUvFsa+ATgU+iy1T
 q14SjQ9a5vFifssEP2IoO/BhlfjgD0r4Z4dl89X0JSWj2Hfd0bN09hz7pJO5qBsFM7MR
 3S/Ckx7oJ67zc5gQsIJ9jkQOEeUlNIe9B8QjbhenGc51sOQGtxtSII4VJRi9VIvZSLmC
 VPgg==
X-Gm-Message-State: AFq9FYIespbX2zAjw0nOe03oP7A9r4C8SP7gzB1UDE29Ghm3jrz1J9AT
 xt8LWTKpvKcXHFhg60ZghZhBQwDNco20zxHPANOLe1djgXE9oIOmIDksvrEKDh/ZI4vb0RymNwY
 zyaEs+LFgUpxFZbFAQi15Yh0YTnYvM09xwywXD90bMNtvL/HuZygwg51OGAQ0KQJf+2YO
X-Gm-Gg: AYBFou2dtN/9d/Bht4oZnFehSKQVr6zzIdEr6cY6boLSAAqV3407luKf6rDzdBjd2hO
 19chkH13R73FmgtU6Yoyii168DnUXOPhAtfUyHo3L+ilSCcwybPl9Hn61Fo5+OT9diByL0RBy3o
 f4Qw6wK4OTJa9eFMTLRh9bYEtB6lv7CGxHahvYE1u9KQP8FBVMloxgMw+0HTKyIZamFhbNFdXD8
 2dh/pr0DiNnBTbxwPrYBybtnHreklVbMBI3aHTH1Fluhg2fFbYVRlQeblTr+LzPtrhG/RDysPC+
 iw2QvYJChebML6W4mwieHQ4bNCBPVy1WGdGTOP/WukxWXpLn0EvUL9yC75L4Q8ynmP69upmfYZY
 Ejtq0RBjl1qy2QxrplEhmVTyF6HjEeCj3N46KRNgSvjMFfw9Q0rA3XA6oEIKe2pU4DX8v59drGI
 4A/Hoa+tw5epH7tqgNipTBycnOKef6yn9wIgOGutvV5QR99FHDioaD8jscP5qvf32RDdTBPm4ln
 e2L/cwgXrPwN2R+d4tQQKN1tuOLSETbzzKeN7rkcSlwqQSVW1bb71dXkKAsqlkTvdfCQFoRhj1D
 6tGEtfAs4XhlyuB/DRtCf/Ysd7G3l9hJSnt89TkAHuHxN4mvypevCJWhHW2xUGoTwfag2lsQVDD
 03iHn6D+yJNRXauo2mAHzszV62wYslYclpe+MH9IiqubdAdXXelInAcDwI+XEDE6NjSunmfJUof
 8RXSSjUGVY+quRqA==
X-Received: by 2002:a05:600c:1d07:b0:4a0:23f:8b0d with SMTP id
 5b1f17b1804b1-4ac150b229cmr230243585e9.2.1793614472527; 
 Mon, 02 Nov 2026 02:14:32 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abe7700c3bsm239757625e9.0.2026.11.02.02.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 02:14:32 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 10:14:30 +0000
To: Heiko Hund <heiko@openvpn.net>, Selva Nair <selva.nair@gmail.com>,
 Lev Stipakov <lstipakov@gmail.com>, Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Id21a6b106c49d6647783e09a506add0726a1a6d2
X-Gerrit-Change-Number: 2016
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2016?usp=email>
X-Gerrit-Commit: 9d7d3603a68d9a63b66a17d7d42d158c8b87ba33
In-Reply-To: <gerrit.1792329007000.Id21a6b106c49d6647783e09a506add0726a1a6d2@gerrit.openvpn.net>
References: <gerrit.1792329007000.Id21a6b106c49d6647783e09a506add0726a1a6d2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMzI5MDA3MDAwLklkMjFhNmIxMDZjNDlkNjY0Nzc4M2UwOWE1MDZhZGQwNzI2YTFhNmQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <48289a987d1b6647f7e9d661a48c02c06afbd208-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNp3n-0000000038n-1RbQ
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0077246932870495086=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0077246932870495086==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tdIoCkH5510="; charset=UTF-8

--tdIoCkH5510=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Heiko Hund=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2016?usp=
=3Demail )

The following approvals got outdated and were removed:
Code-Rev=
iew+2 by Gert Doering


Change subject: openvpnserv: skip conversion of emp=
ty domain names
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

openvpnserv: skip conversion of empty domain names

Empty entries in a=
n interface's comma separated domain list, were
converted to "=2E" in the r=
esulting MULTI_SZ and used as a match all
in the resulting NRPT rules, so a=
ll DNS queries would be sent
to that adapter's name server(s) instead of on=
ly the ones for its
domains=2E Such lists are not expected to be found in t=
he registry,
but skip empty entries anyway, just to be sure=2E

Also rework=
 the ConvertItfDnsDomains() unit tests to use a helper
that runs the conver=
sion on an individually sized heap buffer with
everything after the input p=
oisoned=2E This detects terminators that
are counted but not written, which=
 zero-initialized stack buffers
hid=2E Also add more tests for empty entrie=
s and buffer size boundaries=2E

Bonus: fix typo in related doxygen comment=
=2E

Reported-by: Marc Heuse <marc@srlabs=2Ede>
Change-Id: Id21a6b106c49d66=
47783e09a506add0726a1a6d2
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlich=
=2Enet>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2016
Message-Id: <20261031225615=2E186=
13-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn=
-devel@lists=2Esourceforge=2Enet/msg40387=2Ehtml
Signed-off-by: Gert Doerin=
g <gert@greenie=2Emuc=2Ede>
---
M src/openvpnserv/interactive=2Ec
M tests/u=
nit_tests/openvpnserv/test_openvpnserv=2Ec
2 files changed, 77 insertions(+=
), 75 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/16/2016/3

diff --git a/src/openvpnserv/interactive=2Ec b/src/=
openvpnserv/interactive=2Ec
index e8203c6e=2E=2Ee2f17f0 100644
--- a/src/op=
envpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -2278,6 =
+2278,7 @@
  * In case of an error \p size is set to 0 and the contents of =
\p domains
  * are invalid=2E
  * Note that domains are deleted from the st=
ring if they match a search domain=2E
+ * Empty entries (e=2Eg=2E from lead=
ing, trailing or double commas) are skipped=2E
  *
  * @param[in]     searc=
h_domains  optional string of comma separated search domains
  * @param[in,=
out] domains         buffer that contains the input comma-separated
@@ -231=
9,7 +2320,7 @@
         PWCHAR comma =3D wcschr(domain, L',');
         siz=
e_t domain_len =3D comma ? (size_t)(comma - domain) : wcslen(domain);
 
-  =
      if (ListContainsDomain(search_domains, domain, domain_len))
+        =
if (domain_len =3D=3D 0 || ListContainsDomain(search_domains, domain, domai=
n_len))
         {
             /* Skip this domain */
             domain =
=3D comma ? comma + 1 : domain + domain_len;
@@ -2372,7 +2373,7 @@
 /**
  *=
 Return interface specific domain suffix(es)
  *
- * The \p domains paramte=
r will be set to a MULTI_SZ domains string=2E
+ * The \p domains parameter =
will be set to a MULTI_SZ domains string=2E
  * In case of an error or if n=
o domains are found for the interface
  * \p size is set to 0 and the conte=
nts of \p domains are invalid=2E
  * Note that the domains could have been =
set by DHCP or manually=2E
diff --git a/tests/unit_tests/openvpnserv/test_o=
penvpnserv=2Ec b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
index 4c=
a715b=2E=2Ea99a6f1 100644
--- a/tests/unit_tests/openvpnserv/test_openvpnse=
rv=2Ec
+++ b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
@@ -56,101 +=
56,102 @@
     assert_false(ListContainsDomain(L"internal=2Eopenvpn=2Enet,o=
penvpn=2Ecom", domain, domain_len));
 }
 
+/*
+ * Run ConvertItfDnsDomains(=
) on a heap buffer of exactly capacity bytes,
+ * so that ASAN can detect o=
verruns, with everything after the input string
+ * poisoned, so that termi=
nators which are counted but not written show=2E
+ */
+static void
+check_c=
onvert(PCWSTR search_domains, PCWSTR input, DWORD capacity,
+              =
LSTATUS expected_err, PCWSTR expected)
+{
+    const DWORD glyph_size =3D s=
izeof(wchar_t);
+
+    /* Size of the expected MULTI_SZ including both term=
inators, or 0 */
+    DWORD expected_size =3D 0;
+    if (expected)
+    {
=
+        PCWSTR end =3D expected;
+        while (*end)
+        {
+       =
     end +=3D wcslen(end) + 1;
+        }
+        expected_size =3D (DWORD=
)(end - expected + 1) * glyph_size;
+    }
+
+    DWORD size =3D (DWORD)(wc=
slen(input) + 1) * glyph_size;
+    assert_true(size <=3D capacity);
+
+   =
 wchar_t *domains =3D malloc(capacity);
+    assert_non_null(domains);
+   =
 memset(domains, 0x41, capacity);
+    memcpy(domains, input, size);
+
+   =
 LSTATUS err =3D ConvertItfDnsDomains(search_domains, domains, &size, capac=
ity);
+    assert_int_equal(err, expected_err);
+    assert_int_equal(size,=
 expected_size);
+    if (expected_size)
+    {
+        assert_memory_equa=
l(domains, expected, expected_size);
+    }
+    free(domains);
+}
+
 #defi=
ne BUF_SIZE 64
 static void
 test_convert_itf_dns_domains(void **state)
 {
=
-    DWORD size, len;
-    LSTATUS err;
     const DWORD glyph_size =3D siz=
eof(wchar_t);
+    const DWORD cap =3D BUF_SIZE * glyph_size;
 
     /* Rem=
ove the domain from a single-entry list */
-    wchar_t domains_0[BUF_SIZE]=
 =3D L"openvpn=2Ecom";
-    len =3D (DWORD)wcslen(domains_0) + 1;
-    size=
 =3D len * glyph_size;
-    err =3D ConvertItfDnsDomains(L"openvpn=2Ecom", =
domains_0, &size, sizeof(domains_0));
-    assert_int_equal(size, 0);
-    =
assert_int_equal(err, ERROR_FILE_NOT_FOUND);
+    check_convert(L"openvpn=
=2Ecom", L"openvpn=2Ecom", cap, ERROR_FILE_NOT_FOUND, NULL);
 
     /* Remo=
ve no domain from a single-entry list */
-    wchar_t domains_1[BUF_SIZE] =
=3D L"openvpn=2Ecom";
-    len =3D (DWORD)wcslen(domains_1) + 1;
-    size =
=3D len * glyph_size;
-    wchar_t domains_1_res[] =3D L"=2Eopenvpn=2Ecom\0=
";
-    err =3D ConvertItfDnsDomains(L"openvpn=2Enet", domains_1, &size, si=
zeof(domains_1));
-    assert_memory_equal(domains_1, domains_1_res, size);=

-    assert_int_equal(size, sizeof(domains_1_res));
-    assert_int_equal(=
err, NO_ERROR);
+    check_convert(L"openvpn=2Enet", L"openvpn=2Ecom", cap,=
 NO_ERROR, L"=2Eopenvpn=2Ecom\0");
 
     /* Remove the second domain from =
a two-entry list */
-    wchar_t domains_2[BUF_SIZE] =3D L"openvpn=2Ecom,op=
envpn=2Enet";
-    len =3D (DWORD)wcslen(domains_2) + 1;
-    size =3D len =
* glyph_size;
-    wchar_t domains_2_res[] =3D L"=2Eopenvpn=2Ecom\0";
-    =
err =3D ConvertItfDnsDomains(L"openvpn=2Enet", domains_2, &size, sizeof(dom=
ains_2));
-    assert_memory_equal(domains_2, domains_2_res, size);
-    as=
sert_int_equal(size, sizeof(domains_2_res));
-    assert_int_equal(err, NO_=
ERROR);
+    check_convert(L"openvpn=2Enet", L"openvpn=2Ecom,openvpn=2Enet"=
, cap, NO_ERROR, L"=2Eopenvpn=2Ecom\0");
 
     /* Remove the first domain =
from a two-entry list */
-    wchar_t domains_3[BUF_SIZE] =3D L"openvpn=2Ec=
om,openvpn=2Enet";
-    len =3D (DWORD)wcslen(domains_3) + 1;
-    size =3D=
 len * glyph_size;
-    wchar_t domains_3_res[] =3D L"=2Eopenvpn=2Enet\0";
=
-    err =3D ConvertItfDnsDomains(L"openvpn=2Ecom", domains_3, &size, sizeo=
f(domains_3));
-    assert_memory_equal(domains_3, domains_3_res, size);
- =
   assert_int_equal(size, sizeof(domains_3_res));
-    assert_int_equal(err=
, NO_ERROR);
+    check_convert(L"openvpn=2Ecom", L"openvpn=2Ecom,openvpn=
=2Enet", cap, NO_ERROR, L"=2Eopenvpn=2Enet\0");
 
     /* Remove no domain =
from a two-entry list */
-    wchar_t domains_4[BUF_SIZE] =3D L"openvpn=2Ec=
om,openvpn=2Enet";
-    len =3D (DWORD)wcslen(domains_4) + 1;
-    size =3D=
 len * glyph_size;
-    wchar_t domains_4_res[] =3D L"=2Eopenvpn=2Ecom\0=2E=
openvpn=2Enet\0";
-    err =3D ConvertItfDnsDomains(NULL, domains_4, &size,=
 sizeof(domains_4));
-    assert_memory_equal(domains_4, domains_4_res, siz=
e);
-    assert_int_equal(size, sizeof(domains_4_res));
-    assert_int_equ=
al(err, NO_ERROR);
+    check_convert(NULL, L"openvpn=2Ecom,openvpn=2Enet",=
 cap, NO_ERROR, L"=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet\0");
 
     /* Remove =
the first domain from a three-entry list */
-    wchar_t domains_5[BUF_SIZE=
] =3D L"openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg";
-    len =3D (DWORD)wcs=
len(domains_5) + 1;
-    size =3D len * glyph_size;
-    wchar_t domains_5_=
res[] =3D L"=2Eopenvpn=2Enet\0=2Eopenvpn=2Eorg\0";
-    err =3D ConvertItfD=
nsDomains(L"openvpn=2Ecom", domains_5, &size, sizeof(domains_5));
-    asse=
rt_memory_equal(domains_5, domains_5_res, size);
-    assert_int_equal(size=
, sizeof(domains_5_res));
-    assert_int_equal(err, NO_ERROR);
+    check_=
convert(L"openvpn=2Ecom", L"openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg", cap=
, NO_ERROR,
+                  L"=2Eopenvpn=2Enet\0=2Eopenvpn=2Eorg\0");
 
=
     /* Remove the middle domain from a three-entry list */
-    wchar_t do=
mains_6[BUF_SIZE] =3D L"openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg";
-    le=
n =3D (DWORD)wcslen(domains_6) + 1;
-    size =3D len * glyph_size;
-    wc=
har_t domains_6_res[] =3D L"=2Eopenvpn=2Ecom\0=2Eopenvpn=2Eorg\0";
-    err=
 =3D ConvertItfDnsDomains(L"openvpn=2Enet", domains_6, &size, sizeof(domain=
s_6));
-    assert_memory_equal(domains_6, domains_6_res, size);
-    asser=
t_int_equal(size, sizeof(domains_6_res));
-    assert_int_equal(err, NO_ERR=
OR);
+    check_convert(L"openvpn=2Enet", L"openvpn=2Ecom,openvpn=2Enet,ope=
nvpn=2Eorg", cap, NO_ERROR,
+                  L"=2Eopenvpn=2Ecom\0=2Eopenv=
pn=2Eorg\0");
 
     /* Remove the last domain from a three-entry list */
-=
    wchar_t domains_7[BUF_SIZE] =3D L"openvpn=2Ecom,openvpn=2Enet,openvpn=
=2Eorg";
-    len =3D (DWORD)wcslen(domains_7) + 1;
-    size =3D len * gly=
ph_size;
-    wchar_t domains_7_res[] =3D L"=2Eopenvpn=2Ecom\0=2Eopenvpn=2E=
net\0";
-    err =3D ConvertItfDnsDomains(L"openvpn=2Eorg", domains_7, &siz=
e, sizeof(domains_7));
-    assert_memory_equal(domains_7, domains_7_res, s=
ize);
-    assert_int_equal(size, sizeof(domains_7_res));
-    assert_int_e=
qual(err, NO_ERROR);
+    check_convert(L"openvpn=2Eorg", L"openvpn=2Ecom,o=
penvpn=2Enet,openvpn=2Eorg", cap, NO_ERROR,
+                  L"=2Eopenvpn=
=2Ecom\0=2Eopenvpn=2Enet\0");
 
-    /* Remove the last domain from a four-=
entry list because of size constraints*/
-    wchar_t domains_8[BUF_SIZE] =
=3D L"openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg,am-ende-noch-eine-lange=2Ed=
e";
-    len =3D (DWORD)wcslen(domains_8) + 1;
-    size =3D len * glyph_si=
ze;
-    wchar_t domains_8_res[] =3D L"=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet\0=
=2Eopenvpn=2Eorg\0";
-    err =3D ConvertItfDnsDomains(NULL, domains_8, &si=
ze, sizeof(domains_8));
-    assert_memory_equal(domains_8, domains_8_res, =
size);
-    assert_int_equal(size, sizeof(domains_8_res));
-    assert_int_=
equal(err, ERROR_MORE_DATA);
+    /* Empty entries are skipped */
+    chec=
k_convert(NULL, L",a=2Ecom", cap, NO_ERROR, L"=2Ea=2Ecom\0");
+    check_co=
nvert(NULL, L"a=2Ecom,", cap, NO_ERROR, L"=2Ea=2Ecom\0");
+    check_conver=
t(NULL, L"a=2Ecom,,b=2Ecom", cap, NO_ERROR, L"=2Ea=2Ecom\0=2Eb=2Ecom\0");
+=
    check_convert(L"a=2Ecom", L",a=2Ecom,", cap, ERROR_FILE_NOT_FOUND, NULL=
);
+    check_convert(NULL, L",,,", cap, ERROR_FILE_NOT_FOUND, NULL);
+    =
check_convert(NULL, L"", cap, ERROR_FILE_NOT_FOUND, NULL);
+
+    /* Size i=
s 0 if all domains are removed */
+    check_convert(L"a=2Ecom,b=2Ecom", L"=
b=2Ecom,a=2Ecom", cap, ERROR_FILE_NOT_FOUND, NULL);
+
+    /* Output exactl=
y fills the buffer: 2 * (dot + 5 + NUL) + NUL */
+    check_convert(NULL, L=
"a=2Ecom,b=2Ecom", 15 * glyph_size, NO_ERROR, L"=2Ea=2Ecom\0=2Eb=2Ecom\0");=

+
+    /* Remove the last domain from a four-entry list because of size co=
nstraints,
+     * all four would need 3 * 13 + 28 + 1 =3D 68 glyphs, the b=
uffer is one glyph short */
+    check_convert(NULL, L"openvpn=2Ecom,openvp=
n=2Enet,openvpn=2Eorg,am-ende-noch-eine-lange=2Ede",
+                  67 =
* glyph_size, ERROR_MORE_DATA, L"=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet\0=2Eope=
nvpn=2Eorg\0");
+
+    /* Input fills the buffer, no space for dot and term=
inators */
+    check_convert(NULL, L"a=2Ecom", 6 * glyph_size, ERROR_MORE_=
DATA, NULL);
 }
 
 static void

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2016?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: Id21a6b106c49d6647783e09a506add0726a1a6d2
Gerrit-Change-Num=
ber: 2016
Gerrit-PatchSet: 3
Gerrit-Owner: Heiko Hund <heiko@openvpn=2Enet>=

Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Lev Stipakov <lst=
ipakov@gmail=2Ecom>
Gerrit-Reviewer: Selva Nair <selva=2Enair@gmail=2Ecom>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--tdIoCkH5510=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Heik=
o Hund=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2016?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">openvpnserv: =
skip conversion of empty domain names<br><br>Empty entries in an interface&=
#39;s comma separated domain list, were<br>converted to &quot;=2E&quot; in =
the resulting MULTI_SZ and used as a match all<br>in the resulting NRPT rul=
es, so all DNS queries would be sent<br>to that adapter&#39;s name server(s=
) instead of only the ones for its<br>domains=2E Such lists are not expecte=
d to be found in the registry,<br>but skip empty entries anyway, just to be=
 sure=2E<br><br>Also rework the ConvertItfDnsDomains() unit tests to use a =
helper<br>that runs the conversion on an individually sized heap buffer wit=
h<br>everything after the input poisoned=2E This detects terminators that<b=
r>are counted but not written, which zero-initialized stack buffers<br>hid=
=2E Also add more tests for empty entries and buffer size boundaries=2E<br>=
<br>Bonus: fix typo in related doxygen comment=2E<br><br>Reported-by: Marc =
Heuse &lt;marc@srlabs=2Ede&gt;<br>Change-Id: Id21a6b106c49d6647783e09a506ad=
d0726a1a6d2<br>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&g=
t;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL:=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2016<br>Message-Id: &lt;2026103=
1225615=2E18613-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-ar=
chive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40387=2Ehtml<br>Sign=
ed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/ope=
nvpnserv/interactive=2Ec<br>M tests/unit_tests/openvpnserv/test_openvpnserv=
=2Ec<br>2 files changed, 77 insertions(+), 75 deletions(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/16/2016/3</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpnserv/interactive=2Ec b/src/openv=
pnserv/interactive=2Ec</span><br><span>index e8203c6e=2E=2Ee2f17f0 100644</=
span><br><span>--- a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/=
src/openvpnserv/interactive=2Ec</span><br><span>@@ -2278,6 +2278,7 @@</span=
><br><span>  * In case of an error \p size is set to 0 and the contents of =
\p domains</span><br><span>  * are invalid=2E</span><br><span>  * Note that=
 domains are deleted from the string if they match a search domain=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Empty entries (e=2Eg=
=2E from leading, trailing or double commas) are skipped=2E</span><br><span=
>  *</span><br><span>  * @param[in]     search_domains  optional string of =
comma separated search domains</span><br><span>  * @param[in,out] domains  =
       buffer that contains the input comma-separated</span><br><span>@@ -2=
319,7 +2320,7 @@</span><br><span>         PWCHAR comma =3D wcschr(domain, L=
&#39;,&#39;);</span><br><span>         size_t domain_len =3D comma ? (size_=
t)(comma - domain) : wcslen(domain);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (ListContainsDomain(search_doma=
ins, domain, domain_len))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (domain_len =3D=3D 0 || ListContainsDomain(search_domains,=
 domain, domain_len))</span><br><span>         {</span><br><span>          =
   /* Skip this domain */</span><br><span>             domain =3D comma ? c=
omma + 1 : domain + domain_len;</span><br><span>@@ -2372,7 +2373,7 @@</span=
><br><span> /**</span><br><span>  * Return interface specific domain suffix=
(es)</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * The \p domains paramter will be set to a MULTI_SZ domains string=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The \p domains par=
ameter will be set to a MULTI_SZ domains string=2E</span><br><span>  * In c=
ase of an error or if no domains are found for the interface</span><br><spa=
n>  * \p size is set to 0 and the contents of \p domains are invalid=2E</sp=
an><br><span>  * Note that the domains could have been set by DHCP or manua=
lly=2E</span><br><span>diff --git a/tests/unit_tests/openvpnserv/test_openv=
pnserv=2Ec b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec</span><br><s=
pan>index 4ca715b=2E=2Ea99a6f1 100644</span><br><span>--- a/tests/unit_test=
s/openvpnserv/test_openvpnserv=2Ec</span><br><span>+++ b/tests/unit_tests/o=
penvpnserv/test_openvpnserv=2Ec</span><br><span>@@ -56,101 +56,102 @@</span=
><br><span>     assert_false(ListContainsDomain(L&quot;internal=2Eopenvpn=
=2Enet,openvpn=2Ecom&quot;, domain, domain_len));</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Run ConvertItfDnsDomai=
ns() on a heap buffer of exactly capacity bytes,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * so that ASAN can detect overruns, with ever=
ything after the input string</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * poisoned, so that terminators which are counted but not writte=
n show=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+check_convert(PCWSTR search_domain=
s, PCWSTR input, DWORD capacity,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+              LSTATUS expected_err, PCWSTR expected)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const DWORD glyph_size =3D sizeof(wchar_t);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* Size of the expected MULTI_SZ i=
ncluding both terminators, or 0 */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    DWORD expected_size =3D 0;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (expected)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        PCWSTR end =3D expected;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        while (*end)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            end +=3D wcslen(end) + 1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        expected_size =3D (DWORD)(end - expected + =
1) * glyph_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    DWORD size =3D (DWORD)(wcslen(in=
put) + 1) * glyph_size;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_true(size &lt;=3D capacity);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    wchar_t *domains =3D malloc(capacity);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_non_null(domains);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    memset(domains, 0x41, capacity);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(domains, =
input, size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    LSTATUS err =3D Conve=
rtItfDnsDomains(search_domains, domains, &amp;size, capacity);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(err, expect=
ed_err);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(size, expected_size);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (expected_size)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        assert_memory_equal(domains, expected, expected_size);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    free(domains);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> #define BUF_SIZE 64</span><br><span> static vo=
id</span><br><span> test_convert_itf_dns_domains(void **state)</span><br><s=
pan> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    DWORD size,=
 len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    LSTATUS err;=
</span><br><span>     const DWORD glyph_size =3D sizeof(wchar_t);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const DWORD cap =3D BUF_S=
IZE * glyph_size;</span><br><span> </span><br><span>     /* Remove the doma=
in from a single-entry list */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    wchar_t domains_0[BUF_SIZE] =3D L&quot;openvpn=2Ecom&quot;;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    len =3D (DWORD)wcsle=
n(domains_0) + 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
size =3D len * glyph_size;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    err =3D ConvertItfDnsDomains(L&quot;openvpn=2Ecom&quot;, domains_0=
, &amp;size, sizeof(domains_0));</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    assert_int_equal(size, 0);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    assert_int_equal(err, ERROR_FILE_NOT_FOUND);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    check_convert(L&quot;o=
penvpn=2Ecom&quot;, L&quot;openvpn=2Ecom&quot;, cap, ERROR_FILE_NOT_FOUND, =
NULL);</span><br><span> </span><br><span>     /* Remove no domain from a si=
ngle-entry list */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 wchar_t domains_1[BUF_SIZE] =3D L&quot;openvpn=2Ecom&quot;;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    len =3D (DWORD)wcslen(domains_1)=
 + 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size =3D len=
 * glyph_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wch=
ar_t domains_1_res[] =3D L&quot;=2Eopenvpn=2Ecom\0&quot;;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    err =3D ConvertItfDnsDomains(L&quot=
;openvpn=2Enet&quot;, domains_1, &amp;size, sizeof(domains_1));</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    assert_memory_equal(domains_1=
, domains_1_res, size);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    assert_int_equal(size, sizeof(domains_1_res));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(err, NO_ERROR);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    check_convert(L&quot;o=
penvpn=2Enet&quot;, L&quot;openvpn=2Ecom&quot;, cap, NO_ERROR, L&quot;=2Eop=
envpn=2Ecom\0&quot;);</span><br><span> </span><br><span>     /* Remove the =
second domain from a two-entry list */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    wchar_t domains_2[BUF_SIZE] =3D L&quot;openvpn=2Ecom,o=
penvpn=2Enet&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  len =3D (DWORD)wcslen(domains_2) + 1;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    size =3D len * glyph_size;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    wchar_t domains_2_res[] =3D L&quot;=2Eopenvp=
n=2Ecom\0&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    e=
rr =3D ConvertItfDnsDomains(L&quot;openvpn=2Enet&quot;, domains_2, &amp;siz=
e, sizeof(domains_2));</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    assert_memory_equal(domains_2, domains_2_res, size);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(size, sizeof(domai=
ns_2_res));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert=
_int_equal(err, NO_ERROR);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    check_convert(L&quot;openvpn=2Enet&quot;, L&quot;openvpn=2Ecom,o=
penvpn=2Enet&quot;, cap, NO_ERROR, L&quot;=2Eopenvpn=2Ecom\0&quot;);</span>=
<br><span> </span><br><span>     /* Remove the first domain from a two-entr=
y list */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wchar_t =
domains_3[BUF_SIZE] =3D L&quot;openvpn=2Ecom,openvpn=2Enet&quot;;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    len =3D (DWORD)wcslen(domai=
ns_3) + 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size =
=3D len * glyph_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    wchar_t domains_3_res[] =3D L&quot;=2Eopenvpn=2Enet\0&quot;;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    err =3D ConvertItfDnsDomains=
(L&quot;openvpn=2Ecom&quot;, domains_3, &amp;size, sizeof(domains_3));</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_memory_equal(do=
mains_3, domains_3_res, size);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    assert_int_equal(size, sizeof(domains_3_res));</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(err, NO_ERROR);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_convert(L&=
quot;openvpn=2Ecom&quot;, L&quot;openvpn=2Ecom,openvpn=2Enet&quot;, cap, NO=
_ERROR, L&quot;=2Eopenvpn=2Enet\0&quot;);</span><br><span> </span><br><span=
>     /* Remove no domain from a two-entry list */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    wchar_t domains_4[BUF_SIZE] =3D L&quot;ope=
nvpn=2Ecom,openvpn=2Enet&quot;;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    len =3D (DWORD)wcslen(domains_4) + 1;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    size =3D len * glyph_size;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    wchar_t domains_4_res[] =3D L&=
quot;=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet\0&quot;;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    err =3D ConvertItfDnsDomains(NULL, domains_4=
, &amp;size, sizeof(domains_4));</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    assert_memory_equal(domains_4, domains_4_res, size);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(size, si=
zeof(domains_4_res));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    assert_int_equal(err, NO_ERROR);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    check_convert(NULL, L&quot;openvpn=2Ecom,openvpn=2Enet=
&quot;, cap, NO_ERROR, L&quot;=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet\0&quot;);<=
/span><br><span> </span><br><span>     /* Remove the first domain from a th=
ree-entry list */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
wchar_t domains_5[BUF_SIZE] =3D L&quot;openvpn=2Ecom,openvpn=2Enet,openvpn=
=2Eorg&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    len =
=3D (DWORD)wcslen(domains_5) + 1;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    size =3D len * glyph_size;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    wchar_t domains_5_res[] =3D L&quot;=2Eopenvpn=2Ene=
t\0=2Eopenvpn=2Eorg\0&quot;;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    err =3D ConvertItfDnsDomains(L&quot;openvpn=2Ecom&quot;, domains=
_5, &amp;size, sizeof(domains_5));</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    assert_memory_equal(domains_5, domains_5_res, size);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(size, =
sizeof(domains_5_res));</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    assert_int_equal(err, NO_ERROR);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    check_convert(L&quot;openvpn=2Ecom&quot;, L&quot;ope=
nvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg&quot;, cap, NO_ERROR,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                  L&quot;=2Eopenvp=
n=2Enet\0=2Eopenvpn=2Eorg\0&quot;);</span><br><span> </span><br><span>     =
/* Remove the middle domain from a three-entry list */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    wchar_t domains_6[BUF_SIZE] =3D L&quot=
;openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg&quot;;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    len =3D (DWORD)wcslen(domains_6) + 1;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    size =3D len * glyph_si=
ze;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wchar_t domain=
s_6_res[] =3D L&quot;=2Eopenvpn=2Ecom\0=2Eopenvpn=2Eorg\0&quot;;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    err =3D ConvertItfDnsDomains=
(L&quot;openvpn=2Enet&quot;, domains_6, &amp;size, sizeof(domains_6));</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_memory_equal(do=
mains_6, domains_6_res, size);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    assert_int_equal(size, sizeof(domains_6_res));</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(err, NO_ERROR);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_convert(L&=
quot;openvpn=2Enet&quot;, L&quot;openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg&=
quot;, cap, NO_ERROR,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                  L&quot;=2Eopenvpn=2Ecom\0=2Eopenvpn=2Eorg\0&quot;);</sp=
an><br><span> </span><br><span>     /* Remove the last domain from a three-=
entry list */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wcha=
r_t domains_7[BUF_SIZE] =3D L&quot;openvpn=2Ecom,openvpn=2Enet,openvpn=2Eor=
g&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    len =3D (=
DWORD)wcslen(domains_7) + 1;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    size =3D len * glyph_size;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    wchar_t domains_7_res[] =3D L&quot;=2Eopenvpn=2Ecom\0=
=2Eopenvpn=2Enet\0&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    err =3D ConvertItfDnsDomains(L&quot;openvpn=2Eorg&quot;, domains_7,=
 &amp;size, sizeof(domains_7));</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    assert_memory_equal(domains_7, domains_7_res, size);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(size, siz=
eof(domains_7_res));</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   assert_int_equal(err, NO_ERROR);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    check_convert(L&quot;openvpn=2Eorg&quot;, L&quot;openvp=
n=2Ecom,openvpn=2Enet,openvpn=2Eorg&quot;, cap, NO_ERROR,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                  L&quot;=2Eopenvpn=
=2Ecom\0=2Eopenvpn=2Enet\0&quot;);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* Remove the last domain from a four-e=
ntry list because of size constraints*/</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    wchar_t domains_8[BUF_SIZE] =3D L&quot;openvpn=2Ecom,=
openvpn=2Enet,openvpn=2Eorg,am-ende-noch-eine-lange=2Ede&quot;;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    len =3D (DWORD)wcslen(domains=
_8) + 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size =3D =
len * glyph_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
wchar_t domains_8_res[] =3D L&quot;=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet\0=2Eo=
penvpn=2Eorg\0&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    err =3D ConvertItfDnsDomains(NULL, domains_8, &amp;size, sizeof(domains=
_8));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_memor=
y_equal(domains_8, domains_8_res, size);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    assert_int_equal(size, sizeof(domains_8_res));</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(err, E=
RROR_MORE_DATA);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* Empty entries are skipped */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    check_convert(NULL, L&quot;,a=2Ecom&quot;, cap, NO_ERROR, =
L&quot;=2Ea=2Ecom\0&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    check_convert(NULL, L&quot;a=2Ecom,&quot;, cap, NO_ERROR, L&quo=
t;=2Ea=2Ecom\0&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    check_convert(NULL, L&quot;a=2Ecom,,b=2Ecom&quot;, cap, NO_ERROR, L&=
quot;=2Ea=2Ecom\0=2Eb=2Ecom\0&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    check_convert(L&quot;a=2Ecom&quot;, L&quot;,a=2Ecom,&=
quot;, cap, ERROR_FILE_NOT_FOUND, NULL);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    check_convert(NULL, L&quot;,,,&quot;, cap, ERROR_F=
ILE_NOT_FOUND, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    check_convert(NULL, L&quot;&quot;, cap, ERROR_FILE_NOT_FOUND, NULL);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* Size is 0 if all domains are rem=
oved */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_co=
nvert(L&quot;a=2Ecom,b=2Ecom&quot;, L&quot;b=2Ecom,a=2Ecom&quot;, cap, ERRO=
R_FILE_NOT_FOUND, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Output =
exactly fills the buffer: 2 * (dot + 5 + NUL) + NUL */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    check_convert(NULL, L&quot;a=2Ecom,b=
=2Ecom&quot;, 15 * glyph_size, NO_ERROR, L&quot;=2Ea=2Ecom\0=2Eb=2Ecom\0&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* Remove the last domain fro=
m a four-entry list because of size constraints,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * all four would need 3 * 13 + 28 + 1 =3D=
 68 glyphs, the buffer is one glyph short */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    check_convert(NULL, L&quot;openvpn=2Ecom,openv=
pn=2Enet,openvpn=2Eorg,am-ende-noch-eine-lange=2Ede&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                  67 * glyph_size, E=
RROR_MORE_DATA, L&quot;=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet\0=2Eopenvpn=2Eorg=
\0&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* Input fills the buffe=
r, no space for dot and terminators */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    check_convert(NULL, L&quot;a=2Ecom&quot;, 6 * glyph_=
size, ERROR_MORE_DATA, NULL);</span><br><span> }</span><br><span> </span><b=
r><span> static void</span><br></pre><p>To view, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2016?usp=3Demail">change 2016</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2016?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none=
"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branc=
h: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id21a6b106c=
49d6647783e09a506add0726a1a6d2 </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 2016 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 <=
/div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;heiko@openv=
pn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: Lev Stipakov &lt;lstipakov@gmail=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Selva Nair &lt=
;selva=2Enair@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC=
: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</b=
ody></html>
--tdIoCkH5510=--


--===============0077246932870495086==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0077246932870495086==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0077246932870495086==--

