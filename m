Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B36CCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=wrizvGO3qnRpeZ+n136+l9AHh7nE9RkWnPSgwVUwrRs=; b=Ydc5wdLJx/uu23
	TdxmOwCETsFrluDj4riw6D5jzYmBqsQKc5zULLhycU237zeVWuPHM1jTYVeM0+9GYd8ahPI9SkRWi
	R4dG/3VKDutJiz0ZiqL4tBU7XczXzhpMg0Cs3DnRkFqrTzmy+5n1G8PTYz6qc7l2HXath+sTmL9Vm
	jRA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIQey-0004Ss-68;
	Sun, 18 Oct 2026 13:10:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIQej-0004Lo-Ea
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:10:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jPQStz1ei5CFRtQ/EvN/I3mV5rswTaWf4+g87QO+2RY=; b=BUBnItKdxhXE95An065NXTb6ol
 cHmaXHFzoE3zwFw+c/J1CPI9K56SBdIYUzhNKCog79pUFAzgnaJ32xYHUVh91v7mmqRAArmmlbnq4
 NdROX2Py077x38f0hAEVTfu9LTjW8deG9eZMHLH+MxB+5R6Y6+Wy3KM2+Z2h3Mn0vhdg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jPQStz1ei5CFRtQ/EvN/I3mV5rswTaWf4+g87QO+2RY=; b=W
 vO8CupSfujMKC0N6u0TBM7BZCyPmuvb810RpavhJ58yz77sWSCXaLguqaNf6z42b6KxKfdjrOcj98
 qBzKH0JOSChVNG6KydGzsACr5R33hsHMNAys/l126Ozdumz7Lo+OmwOpKplTTNkTPKUr+c7urnQ+Q
 E9f5EmFpSDuXGHdA=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIQeZ-0006fl-O3 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:10:23 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a19cba5c14so13863685e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 06:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792329013; x=1792933813; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jPQStz1ei5CFRtQ/EvN/I3mV5rswTaWf4+g87QO+2RY=;
 b=W3slan7CmcQGFhpYwzNWyMK272Gh/Hpy15T0dDUH8W/slVWcuNcxKXUQXPitt980LQ
 YFXef00jnP3pJRrzl9bN28qcoffUOam6pTe67m6tAzY/jPY+wDT3URv2ehCQU5jlBy8+
 yFTTe4x8A5LikU+sAZdFVXg8hbuN2c+x/SWNqemwoFua8i3ixJHemcD0L8zcMZ4Au7Eq
 p7B3DhBimnRGEDGXC4kCMhT2ft7bmtoydrhkDD4A7IlePMAyi2yaNSlZ+/nv5lPU2aRT
 k/A6w8zXYG0bZmi7F9GtOjuT/ZZNPGaK64rno29Cb3+pTAJmj9Du7x1MxPkkF2bK3TsW
 d62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792329013; x=1792933813;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jPQStz1ei5CFRtQ/EvN/I3mV5rswTaWf4+g87QO+2RY=;
 b=o8XCigLvDWFZfdD+pqqYEi49ETRipK+9M2/q/Ivv++s5iAJCw95I/365PT3c3I8/YN
 fdg0kQC0hvMajjhWHrlfKp/5onYGMaaxZDDqRlVgZDQwXYMpyZRXyO34tFWOREdFk10P
 kxGMSfHp3grTA2DHBubLoXvoS+qyctMWSs+kTh1Hjl38ud/XTBz1IHk80yhjmdQFTG9R
 tQ1iet4w+LM5XGn3q2Uk3VCzQd5S4qZjzMpQKFsi/CQmlIP70cwqKGWNquPR1ttAijfd
 Ybq/V+1QVB9x8BCjOCkizslKIQaVFu3BydjoUSHdjgxx4dlR705vds4vneuzLNWe+oOu
 DmJQ==
X-Gm-Message-State: AFq9FYI54RovC8AKTI5NAQt3XYSDftco35cIfA2bfX+iYeBeuBWahGU9
 v98tQMqxrgP/PYbrc6olNghApD19lOwDcWBxLwBte0naoOQ5GdPaPnBIyC6waFtuTVH18Ol0WFO
 oyynk9IVGw6IXE4fLH1QYikm7hQrFQqXHD89BgVDAwcpX4WqBb0LUy1scYD/rNafRVofAFpvag3
 zTej7pxw==
X-Gm-Gg: AYBFou12HIqxlOnrdelV9gEnaC5mTwTRpneBbd0NdZubkqDNfdNt0Iwj9UMuXoP0Fjn
 fr/+SUEwW/KIHynbobWKA8XeB39u7r6e9562Qnd4a+2s+7BUD7sg+TJ6RkPweri52oBaJBfSiyj
 v/ajXKjJdIGUW0wtscDYus1KtaPjG5NYLEoQnxB1xZI/K2bYH8CphAnO+NHQrF7hhTPiU/8u7c8
 IDhpxqhr+JjThN2HyQUIgdNKbdfAO1mKeF0IYA3nwcaOlmKJeP/xTgdKI3MtiHAm1P3Yk24xXKU
 ziTC9kXXuAGD992VZ4C/hDaGg4hL55F5FQmVzXkM9XE84f5baJ9OSl23PD2oy85Rfa7WoKNh6DS
 xdEzkUMe7CmoA0QcZdJgcj9qT/9sgIxsKiPMq7qFrApfFFNzXb52yYLl+2wIIXzjpcNozLciw1o
 AhyrEBQxrJWB9BiDb9ag2iwkAAsP272vTlgkzkQ9x4VFIh4v0pjn6Sq2WynxQ9vUEUc+c/q0tE8
 2XJNHp7MVClYaxCs//O04eDvfdRore7o8ZqvtPFlpNaYYtjHD6u1lTf+r3SbQb4uzvjZnCgX2my
 wtYaT37XuR1xFDD696P/qWsvUPecVCzvyb8vhPC+McKiv2xHT51uBnLUqBKq8QAZsmSXiAM=
X-Received: by 2002:a05:600c:e558:20b0:49c:cee0:f383 with SMTP id
 5b1f17b1804b1-4a1d7614f75mr59848585e9.16.1792329012957; 
 Sun, 18 Oct 2026 06:10:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1cca30aa4sm89603515e9.2.2026.10.18.06.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 06:10:12 -0700 (PDT)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 13:10:12 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id21a6b106c49d6647783e09a506add0726a1a6d2
X-Gerrit-Change-Number: 2016
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2016?usp=email>
X-Gerrit-Commit: 41f1d4dc99c8a8059cd789d9bd56cd95c6af8c5e
References: <gerrit.1792329007000.Id21a6b106c49d6647783e09a506add0726a1a6d2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMzI5MDA3MDAwLklkMjFhNmIxMDZjNDlkNjY0Nzc4M2UwOWE1MDZhZGQwNzI2YTFhNmQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8be7b5980bd89ff55075d51ee4443a3f8e8fae93-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIQeZ-0006fl-O3
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv: skip
 conversion of empty domain names
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
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8050001979761300757=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8050001979761300757==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AgqzX1fHPZ0="; charset=UTF-8

--AgqzX1fHPZ0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2016?usp=3Demail

to review the following change=2E
=


Change subject: openvpnserv: skip conversion of empty domain names
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: skip c=
onversion of empty domain names

Empty entries in an interface's comma sepa=
rated domain list, were
converted to "=2E" in the resulting MULTI_SZ and us=
ed as a match all
in the resulting NRPT rules, so all DNS queries would be =
sent
to that adapter's name server(s) instead of only the ones for its
doma=
ins=2E Such lists are not expected to be found in the registry,
but skip em=
pty entries anyway, just to be sure=2E

Also rework the ConvertItfDnsDomain=
s() unit tests to use a helper
that runs the conversion on an individually =
sized heap buffer with
everything after the input poisoned=2E This detects =
terminators that
are counted but not written, which zero-initialized stack =
buffers
hid=2E Also add more tests for empty entries and buffer size bounda=
ries=2E

Bonus: fix typo in related doxygen comment=2E

Reported-by: Marc H=
euse <marc@srlabs=2Ede>
Change-Id: Id21a6b106c49d6647783e09a506add0726a1a6d=
2
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
---
M src/openvp=
nserv/interactive=2Ec
M tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
2=
 files changed, 77 insertions(+), 75 deletions(-)



  git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/16/2016/1

diff --git a/src/op=
envpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index f4b2d39=
=2E=2Eb0c22f8 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvp=
nserv/interactive=2Ec
@@ -2196,6 +2196,7 @@
  * In case of an error \p size=
 is set to 0 and the contents of \p domains
  * are invalid=2E
  * Note tha=
t domains are deleted from the string if they match a search domain=2E
+ * =
Empty entries (e=2Eg=2E from leading, trailing or double commas) are skippe=
d=2E
  *
  * @param[in]     search_domains  optional string of comma separa=
ted search domains
  * @param[in,out] domains         buffer that contains =
the input comma-separated
@@ -2237,7 +2238,7 @@
         PWCHAR comma =3D w=
cschr(domain, L',');
         size_t domain_len =3D comma ? (size_t)(comma =
- domain) : wcslen(domain);
 
-        if (ListContainsDomain(search_domain=
s, domain, domain_len))
+        if (domain_len =3D=3D 0 || ListContainsDom=
ain(search_domains, domain, domain_len))
         {
             /* Skip th=
is domain */
             domain =3D comma ? comma + 1 : domain + domain_le=
n;
@@ -2290,7 +2291,7 @@
 /**
  * Return interface specific domain suffix(e=
s)
  *
- * The \p domains paramter will be set to a MULTI_SZ domains string=
=2E
+ * The \p domains parameter will be set to a MULTI_SZ domains string=
=2E
  * In case of an error or if no domains are found for the interface
  =
* \p size is set to 0 and the contents of \p domains are invalid=2E
  * Not=
e that the domains could have been set by DHCP or manually=2E
diff --git a/=
tests/unit_tests/openvpnserv/test_openvpnserv=2Ec b/tests/unit_tests/openvp=
nserv/test_openvpnserv=2Ec
index 4ca715b=2E=2Ea99a6f1 100644
--- a/tests/un=
it_tests/openvpnserv/test_openvpnserv=2Ec
+++ b/tests/unit_tests/openvpnser=
v/test_openvpnserv=2Ec
@@ -56,101 +56,102 @@
     assert_false(ListContains=
Domain(L"internal=2Eopenvpn=2Enet,openvpn=2Ecom", domain, domain_len));
 }
=
 
+/*
+ * Run ConvertItfDnsDomains() on a heap buffer of exactly capacity b=
ytes,
+ * so that ASAN can detect overruns, with everything after the input=
 string
+ * poisoned, so that terminators which are counted but not written=
 show=2E
+ */
+static void
+check_convert(PCWSTR search_domains, PCWSTR inp=
ut, DWORD capacity,
+              LSTATUS expected_err, PCWSTR expected)
+=
{
+    const DWORD glyph_size =3D sizeof(wchar_t);
+
+    /* Size of the ex=
pected MULTI_SZ including both terminators, or 0 */
+    DWORD expected_siz=
e =3D 0;
+    if (expected)
+    {
+        PCWSTR end =3D expected;
+     =
   while (*end)
+        {
+            end +=3D wcslen(end) + 1;
+        =
}
+        expected_size =3D (DWORD)(end - expected + 1) * glyph_size;
+   =
 }
+
+    DWORD size =3D (DWORD)(wcslen(input) + 1) * glyph_size;
+    asse=
rt_true(size <=3D capacity);
+
+    wchar_t *domains =3D malloc(capacity);
=
+    assert_non_null(domains);
+    memset(domains, 0x41, capacity);
+    m=
emcpy(domains, input, size);
+
+    LSTATUS err =3D ConvertItfDnsDomains(se=
arch_domains, domains, &size, capacity);
+    assert_int_equal(err, expecte=
d_err);
+    assert_int_equal(size, expected_size);
+    if (expected_size)=

+    {
+        assert_memory_equal(domains, expected, expected_size);
+  =
  }
+    free(domains);
+}
+
 #define BUF_SIZE 64
 static void
 test_conver=
t_itf_dns_domains(void **state)
 {
-    DWORD size, len;
-    LSTATUS err;
=
     const DWORD glyph_size =3D sizeof(wchar_t);
+    const DWORD cap =3D B=
UF_SIZE * glyph_size;
 
     /* Remove the domain from a single-entry list =
*/
-    wchar_t domains_0[BUF_SIZE] =3D L"openvpn=2Ecom";
-    len =3D (DWO=
RD)wcslen(domains_0) + 1;
-    size =3D len * glyph_size;
-    err =3D Conv=
ertItfDnsDomains(L"openvpn=2Ecom", domains_0, &size, sizeof(domains_0));
- =
   assert_int_equal(size, 0);
-    assert_int_equal(err, ERROR_FILE_NOT_FOU=
ND);
+    check_convert(L"openvpn=2Ecom", L"openvpn=2Ecom", cap, ERROR_FILE=
_NOT_FOUND, NULL);
 
     /* Remove no domain from a single-entry list */
-=
    wchar_t domains_1[BUF_SIZE] =3D L"openvpn=2Ecom";
-    len =3D (DWORD)w=
cslen(domains_1) + 1;
-    size =3D len * glyph_size;
-    wchar_t domains_=
1_res[] =3D L"=2Eopenvpn=2Ecom\0";
-    err =3D ConvertItfDnsDomains(L"open=
vpn=2Enet", domains_1, &size, sizeof(domains_1));
-    assert_memory_equal(=
domains_1, domains_1_res, size);
-    assert_int_equal(size, sizeof(domains=
_1_res));
-    assert_int_equal(err, NO_ERROR);
+    check_convert(L"openvp=
n=2Enet", L"openvpn=2Ecom", cap, NO_ERROR, L"=2Eopenvpn=2Ecom\0");
 
     /=
* Remove the second domain from a two-entry list */
-    wchar_t domains_2[=
BUF_SIZE] =3D L"openvpn=2Ecom,openvpn=2Enet";
-    len =3D (DWORD)wcslen(do=
mains_2) + 1;
-    size =3D len * glyph_size;
-    wchar_t domains_2_res[] =
=3D L"=2Eopenvpn=2Ecom\0";
-    err =3D ConvertItfDnsDomains(L"openvpn=2Ene=
t", domains_2, &size, sizeof(domains_2));
-    assert_memory_equal(domains_=
2, domains_2_res, size);
-    assert_int_equal(size, sizeof(domains_2_res))=
;
-    assert_int_equal(err, NO_ERROR);
+    check_convert(L"openvpn=2Enet"=
, L"openvpn=2Ecom,openvpn=2Enet", cap, NO_ERROR, L"=2Eopenvpn=2Ecom\0");
 
=
     /* Remove the first domain from a two-entry list */
-    wchar_t domai=
ns_3[BUF_SIZE] =3D L"openvpn=2Ecom,openvpn=2Enet";
-    len =3D (DWORD)wcsl=
en(domains_3) + 1;
-    size =3D len * glyph_size;
-    wchar_t domains_3_r=
es[] =3D L"=2Eopenvpn=2Enet\0";
-    err =3D ConvertItfDnsDomains(L"openvpn=
=2Ecom", domains_3, &size, sizeof(domains_3));
-    assert_memory_equal(dom=
ains_3, domains_3_res, size);
-    assert_int_equal(size, sizeof(domains_3_=
res));
-    assert_int_equal(err, NO_ERROR);
+    check_convert(L"openvpn=
=2Ecom", L"openvpn=2Ecom,openvpn=2Enet", cap, NO_ERROR, L"=2Eopenvpn=2Enet\=
0");
 
     /* Remove no domain from a two-entry list */
-    wchar_t domai=
ns_4[BUF_SIZE] =3D L"openvpn=2Ecom,openvpn=2Enet";
-    len =3D (DWORD)wcsl=
en(domains_4) + 1;
-    size =3D len * glyph_size;
-    wchar_t domains_4_r=
es[] =3D L"=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet\0";
-    err =3D ConvertItfDn=
sDomains(NULL, domains_4, &size, sizeof(domains_4));
-    assert_memory_equ=
al(domains_4, domains_4_res, size);
-    assert_int_equal(size, sizeof(doma=
ins_4_res));
-    assert_int_equal(err, NO_ERROR);
+    check_convert(NULL,=
 L"openvpn=2Ecom,openvpn=2Enet", cap, NO_ERROR, L"=2Eopenvpn=2Ecom\0=2Eopen=
vpn=2Enet\0");
 
     /* Remove the first domain from a three-entry list */=

-    wchar_t domains_5[BUF_SIZE] =3D L"openvpn=2Ecom,openvpn=2Enet,openvpn=
=2Eorg";
-    len =3D (DWORD)wcslen(domains_5) + 1;
-    size =3D len * gly=
ph_size;
-    wchar_t domains_5_res[] =3D L"=2Eopenvpn=2Enet\0=2Eopenvpn=2E=
org\0";
-    err =3D ConvertItfDnsDomains(L"openvpn=2Ecom", domains_5, &siz=
e, sizeof(domains_5));
-    assert_memory_equal(domains_5, domains_5_res, s=
ize);
-    assert_int_equal(size, sizeof(domains_5_res));
-    assert_int_e=
qual(err, NO_ERROR);
+    check_convert(L"openvpn=2Ecom", L"openvpn=2Ecom,o=
penvpn=2Enet,openvpn=2Eorg", cap, NO_ERROR,
+                  L"=2Eopenvpn=
=2Enet\0=2Eopenvpn=2Eorg\0");
 
     /* Remove the middle domain from a thr=
ee-entry list */
-    wchar_t domains_6[BUF_SIZE] =3D L"openvpn=2Ecom,openv=
pn=2Enet,openvpn=2Eorg";
-    len =3D (DWORD)wcslen(domains_6) + 1;
-    si=
ze =3D len * glyph_size;
-    wchar_t domains_6_res[] =3D L"=2Eopenvpn=2Eco=
m\0=2Eopenvpn=2Eorg\0";
-    err =3D ConvertItfDnsDomains(L"openvpn=2Enet",=
 domains_6, &size, sizeof(domains_6));
-    assert_memory_equal(domains_6, =
domains_6_res, size);
-    assert_int_equal(size, sizeof(domains_6_res));
-=
    assert_int_equal(err, NO_ERROR);
+    check_convert(L"openvpn=2Enet", L=
"openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg", cap, NO_ERROR,
+              =
    L"=2Eopenvpn=2Ecom\0=2Eopenvpn=2Eorg\0");
 
     /* Remove the last dom=
ain from a three-entry list */
-    wchar_t domains_7[BUF_SIZE] =3D L"openv=
pn=2Ecom,openvpn=2Enet,openvpn=2Eorg";
-    len =3D (DWORD)wcslen(domains_7=
) + 1;
-    size =3D len * glyph_size;
-    wchar_t domains_7_res[] =3D L"=
=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet\0";
-    err =3D ConvertItfDnsDomains(L"=
openvpn=2Eorg", domains_7, &size, sizeof(domains_7));
-    assert_memory_eq=
ual(domains_7, domains_7_res, size);
-    assert_int_equal(size, sizeof(dom=
ains_7_res));
-    assert_int_equal(err, NO_ERROR);
+    check_convert(L"op=
envpn=2Eorg", L"openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg", cap, NO_ERROR,
=
+                  L"=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet\0");
 
-    /* Remo=
ve the last domain from a four-entry list because of size constraints*/
-  =
  wchar_t domains_8[BUF_SIZE] =3D L"openvpn=2Ecom,openvpn=2Enet,openvpn=2Eo=
rg,am-ende-noch-eine-lange=2Ede";
-    len =3D (DWORD)wcslen(domains_8) + 1=
;
-    size =3D len * glyph_size;
-    wchar_t domains_8_res[] =3D L"=2Eope=
nvpn=2Ecom\0=2Eopenvpn=2Enet\0=2Eopenvpn=2Eorg\0";
-    err =3D ConvertItfD=
nsDomains(NULL, domains_8, &size, sizeof(domains_8));
-    assert_memory_eq=
ual(domains_8, domains_8_res, size);
-    assert_int_equal(size, sizeof(dom=
ains_8_res));
-    assert_int_equal(err, ERROR_MORE_DATA);
+    /* Empty en=
tries are skipped */
+    check_convert(NULL, L",a=2Ecom", cap, NO_ERROR, L=
"=2Ea=2Ecom\0");
+    check_convert(NULL, L"a=2Ecom,", cap, NO_ERROR, L"=2E=
a=2Ecom\0");
+    check_convert(NULL, L"a=2Ecom,,b=2Ecom", cap, NO_ERROR, L=
"=2Ea=2Ecom\0=2Eb=2Ecom\0");
+    check_convert(L"a=2Ecom", L",a=2Ecom,", c=
ap, ERROR_FILE_NOT_FOUND, NULL);
+    check_convert(NULL, L",,,", cap, ERRO=
R_FILE_NOT_FOUND, NULL);
+    check_convert(NULL, L"", cap, ERROR_FILE_NOT_=
FOUND, NULL);
+
+    /* Size is 0 if all domains are removed */
+    check_=
convert(L"a=2Ecom,b=2Ecom", L"b=2Ecom,a=2Ecom", cap, ERROR_FILE_NOT_FOUND, =
NULL);
+
+    /* Output exactly fills the buffer: 2 * (dot + 5 + NUL) + NUL=
 */
+    check_convert(NULL, L"a=2Ecom,b=2Ecom", 15 * glyph_size, NO_ERROR,=
 L"=2Ea=2Ecom\0=2Eb=2Ecom\0");
+
+    /* Remove the last domain from a four=
-entry list because of size constraints,
+     * all four would need 3 * 13=
 + 28 + 1 =3D 68 glyphs, the buffer is one glyph short */
+    check_conver=
t(NULL, L"openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg,am-ende-noch-eine-lange=
=2Ede",
+                  67 * glyph_size, ERROR_MORE_DATA, L"=2Eopenvpn=
=2Ecom\0=2Eopenvpn=2Enet\0=2Eopenvpn=2Eorg\0");
+
+    /* Input fills the b=
uffer, no space for dot and terminators */
+    check_convert(NULL, L"a=2Ec=
om", 6 * glyph_size, ERROR_MORE_DATA, NULL);
 }
 
 static void

-- 
To view=
, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2016?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id21a6b106c49d6647783e09a50=
6add0726a1a6d2
Gerrit-Change-Number: 2016
Gerrit-PatchSet: 1
Gerrit-Owner: =
Heiko Hund <heiko@openvpn=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--AgqzX1fHPZ0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Heiko Hund would like Arne Sc=
hwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2016?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">openvpnserv: skip conversion of empty domain names<br><br>Empty e=
ntries in an interface&#39;s comma separated domain list, were<br>converted=
 to &quot;=2E&quot; in the resulting MULTI_SZ and used as a match all<br>in=
 the resulting NRPT rules, so all DNS queries would be sent<br>to that adap=
ter&#39;s name server(s) instead of only the ones for its<br>domains=2E Suc=
h lists are not expected to be found in the registry,<br>but skip empty ent=
ries anyway, just to be sure=2E<br><br>Also rework the ConvertItfDnsDomains=
() unit tests to use a helper<br>that runs the conversion on an individuall=
y sized heap buffer with<br>everything after the input poisoned=2E This det=
ects terminators that<br>are counted but not written, which zero-initialize=
d stack buffers<br>hid=2E Also add more tests for empty entries and buffer =
size boundaries=2E<br><br>Bonus: fix typo in related doxygen comment=2E<br>=
<br>Reported-by: Marc Heuse &lt;marc@srlabs=2Ede&gt;<br>Change-Id: Id21a6b1=
06c49d6647783e09a506add0726a1a6d2<br>Signed-off-by: Heiko Hund &lt;heiko@is=
t=2Eeigentlich=2Enet&gt;<br>---<br>M src/openvpnserv/interactive=2Ec<br>M t=
ests/unit_tests/openvpnserv/test_openvpnserv=2Ec<br>2 files changed, 77 ins=
ertions(+), 75 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/16/2016/1</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><b=
r><span>index f4b2d39=2E=2Eb0c22f8 100644</span><br><span>--- a/src/openvpn=
serv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec<=
/span><br><span>@@ -2196,6 +2196,7 @@</span><br><span>  * In case of an err=
or \p size is set to 0 and the contents of \p domains</span><br><span>  * a=
re invalid=2E</span><br><span>  * Note that domains are deleted from the st=
ring if they match a search domain=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Empty entries (e=2Eg=2E from leading, trailing or doub=
le commas) are skipped=2E</span><br><span>  *</span><br><span>  * @param[in=
]     search_domains  optional string of comma separated search domains</sp=
an><br><span>  * @param[in,out] domains         buffer that contains the in=
put comma-separated</span><br><span>@@ -2237,7 +2238,7 @@</span><br><span> =
        PWCHAR comma =3D wcschr(domain, L&#39;,&#39;);</span><br><span>    =
     size_t domain_len =3D comma ? (size_t)(comma - domain) : wcslen(domain=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (ListContainsDomain(search_domains, domain, domain_len))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (domain_len =3D=
=3D 0 || ListContainsDomain(search_domains, domain, domain_len))</span><br>=
<span>         {</span><br><span>             /* Skip this domain */</span>=
<br><span>             domain =3D comma ? comma + 1 : domain + domain_len;<=
/span><br><span>@@ -2290,7 +2291,7 @@</span><br><span> /**</span><br><span>=
  * Return interface specific domain suffix(es)</span><br><span>  *</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * The \p domains paramter wi=
ll be set to a MULTI_SZ domains string=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * The \p domains parameter will be set to a MULTI_SZ=
 domains string=2E</span><br><span>  * In case of an error or if no domains=
 are found for the interface</span><br><span>  * \p size is set to 0 and th=
e contents of \p domains are invalid=2E</span><br><span>  * Note that the d=
omains could have been set by DHCP or manually=2E</span><br><span>diff --gi=
t a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec b/tests/unit_tests/op=
envpnserv/test_openvpnserv=2Ec</span><br><span>index 4ca715b=2E=2Ea99a6f1 1=
00644</span><br><span>--- a/tests/unit_tests/openvpnserv/test_openvpnserv=
=2Ec</span><br><span>+++ b/tests/unit_tests/openvpnserv/test_openvpnserv=2E=
c</span><br><span>@@ -56,101 +56,102 @@</span><br><span>     assert_false(L=
istContainsDomain(L&quot;internal=2Eopenvpn=2Enet,openvpn=2Ecom&quot;, doma=
in, domain_len));</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Run ConvertItfDnsDomains() on a heap buffer of exactly=
 capacity bytes,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
so that ASAN can detect overruns, with everything after the input string</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * poisoned, so that t=
erminators which are counted but not written show=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+check_convert(PCWSTR search_domains, PCWSTR input, DWORD capacity=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              LSTA=
TUS expected_err, PCWSTR expected)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const DWORD glyph_size =3D sizeof(wchar_t);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* Size of the expected MULTI_SZ including both terminators, or 0=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD expect=
ed_size =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (expected)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        PCWSTR end =
=3D expected;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  while (*end)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            end=
 +=3D wcslen(end) + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 expected_size =3D (DWORD)(end - expected + 1) * glyph_size;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    DWORD size =3D (DWORD)(wcslen(input) + 1) * glyph_size;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(size &lt;=
=3D capacity);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    wchar_t *domains =3D=
 malloc(capacity);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_non_null(domains);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    memset(domains, 0x41, capacity);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    memcpy(domains, input, size);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    LSTATUS err =3D ConvertItfDnsDomains(search_domain=
s, domains, &amp;size, capacity);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_int_equal(err, expected_err);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(size, expected_size=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (expected_=
size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        assert_memory_equal(=
domains, expected, expected_size);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    free(domains);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
#define BUF_SIZE 64</span><br><span> static void</span><br><span> test_conv=
ert_itf_dns_domains(void **state)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    DWORD size, len;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    LSTATUS err;</span><br><span>     const=
 DWORD glyph_size =3D sizeof(wchar_t);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const DWORD cap =3D BUF_SIZE * glyph_size;</span><br=
><span> </span><br><span>     /* Remove the domain from a single-entry list=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wchar_t domain=
s_0[BUF_SIZE] =3D L&quot;openvpn=2Ecom&quot;;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    len =3D (DWORD)wcslen(domains_0) + 1;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    size =3D len * glyph_size;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    err =3D ConvertItf=
DnsDomains(L&quot;openvpn=2Ecom&quot;, domains_0, &amp;size, sizeof(domains=
_0));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_e=
qual(size, 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ass=
ert_int_equal(err, ERROR_FILE_NOT_FOUND);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    check_convert(L&quot;openvpn=2Ecom&quot;, L&quot;=
openvpn=2Ecom&quot;, cap, ERROR_FILE_NOT_FOUND, NULL);</span><br><span> </s=
pan><br><span>     /* Remove no domain from a single-entry list */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    wchar_t domains_1[BUF_SIZE=
] =3D L&quot;openvpn=2Ecom&quot;;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    len =3D (DWORD)wcslen(domains_1) + 1;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    size =3D len * glyph_size;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    wchar_t domains_1_res[] =3D L&=
quot;=2Eopenvpn=2Ecom\0&quot;;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    err =3D ConvertItfDnsDomains(L&quot;openvpn=2Enet&quot;, domai=
ns_1, &amp;size, sizeof(domains_1));</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    assert_memory_equal(domains_1, domains_1_res, size);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(size=
, sizeof(domains_1_res));</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    assert_int_equal(err, NO_ERROR);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    check_convert(L&quot;openvpn=2Enet&quot;, L&quot;o=
penvpn=2Ecom&quot;, cap, NO_ERROR, L&quot;=2Eopenvpn=2Ecom\0&quot;);</span>=
<br><span> </span><br><span>     /* Remove the second domain from a two-ent=
ry list */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wchar_t=
 domains_2[BUF_SIZE] =3D L&quot;openvpn=2Ecom,openvpn=2Enet&quot;;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    len =3D (DWORD)wcslen(doma=
ins_2) + 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size =
=3D len * glyph_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    wchar_t domains_2_res[] =3D L&quot;=2Eopenvpn=2Ecom\0&quot;;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    err =3D ConvertItfDnsDomains=
(L&quot;openvpn=2Enet&quot;, domains_2, &amp;size, sizeof(domains_2));</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_memory_equal(do=
mains_2, domains_2_res, size);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    assert_int_equal(size, sizeof(domains_2_res));</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(err, NO_ERROR);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_convert(L&=
quot;openvpn=2Enet&quot;, L&quot;openvpn=2Ecom,openvpn=2Enet&quot;, cap, NO=
_ERROR, L&quot;=2Eopenvpn=2Ecom\0&quot;);</span><br><span> </span><br><span=
>     /* Remove the first domain from a two-entry list */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    wchar_t domains_3[BUF_SIZE] =3D L&q=
uot;openvpn=2Ecom,openvpn=2Enet&quot;;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    len =3D (DWORD)wcslen(domains_3) + 1;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    size =3D len * glyph_size;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    wchar_t domains_3_res[] =
=3D L&quot;=2Eopenvpn=2Enet\0&quot;;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    err =3D ConvertItfDnsDomains(L&quot;openvpn=2Ecom&quot;,=
 domains_3, &amp;size, sizeof(domains_3));</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    assert_memory_equal(domains_3, domains_3_res, size=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equa=
l(size, sizeof(domains_3_res));</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    assert_int_equal(err, NO_ERROR);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    check_convert(L&quot;openvpn=2Ecom&quot;, L&=
quot;openvpn=2Ecom,openvpn=2Enet&quot;, cap, NO_ERROR, L&quot;=2Eopenvpn=2E=
net\0&quot;);</span><br><span> </span><br><span>     /* Remove no domain fr=
om a two-entry list */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    wchar_t domains_4[BUF_SIZE] =3D L&quot;openvpn=2Ecom,openvpn=2Enet&quo=
t;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    len =3D (DWORD=
)wcslen(domains_4) + 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    size =3D len * glyph_size;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    wchar_t domains_4_res[] =3D L&quot;=2Eopenvpn=2Ecom\0=2Eopen=
vpn=2Enet\0&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 err =3D ConvertItfDnsDomains(NULL, domains_4, &amp;size, sizeof(domains_4)=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_memory_e=
qual(domains_4, domains_4_res, size);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    assert_int_equal(size, sizeof(domains_4_res));</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(err, NO_E=
RROR);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_con=
vert(NULL, L&quot;openvpn=2Ecom,openvpn=2Enet&quot;, cap, NO_ERROR, L&quot;=
=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet\0&quot;);</span><br><span> </span><br><s=
pan>     /* Remove the first domain from a three-entry list */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    wchar_t domains_5[BUF_SIZE] =
=3D L&quot;openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg&quot;;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    len =3D (DWORD)wcslen(domains_5) =
+ 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size =3D len =
* glyph_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wcha=
r_t domains_5_res[] =3D L&quot;=2Eopenvpn=2Enet\0=2Eopenvpn=2Eorg\0&quot;;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    err =3D ConvertItf=
DnsDomains(L&quot;openvpn=2Ecom&quot;, domains_5, &amp;size, sizeof(domains=
_5));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_memor=
y_equal(domains_5, domains_5_res, size);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    assert_int_equal(size, sizeof(domains_5_res));</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(err, N=
O_ERROR);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_=
convert(L&quot;openvpn=2Ecom&quot;, L&quot;openvpn=2Ecom,openvpn=2Enet,open=
vpn=2Eorg&quot;, cap, NO_ERROR,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                  L&quot;=2Eopenvpn=2Enet\0=2Eopenvpn=2Eorg\0&q=
uot;);</span><br><span> </span><br><span>     /* Remove the middle domain f=
rom a three-entry list */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    wchar_t domains_6[BUF_SIZE] =3D L&quot;openvpn=2Ecom,openvpn=2Enet,=
openvpn=2Eorg&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   len =3D (DWORD)wcslen(domains_6) + 1;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    size =3D len * glyph_size;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    wchar_t domains_6_res[] =3D L&quot;=2Eopenv=
pn=2Ecom\0=2Eopenvpn=2Eorg\0&quot;;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    err =3D ConvertItfDnsDomains(L&quot;openvpn=2Enet&quot;, =
domains_6, &amp;size, sizeof(domains_6));</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    assert_memory_equal(domains_6, domains_6_res, size)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal=
(size, sizeof(domains_6_res));</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    assert_int_equal(err, NO_ERROR);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    check_convert(L&quot;openvpn=2Enet&quot;, L&q=
uot;openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg&quot;, cap, NO_ERROR,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                  L&quot;=
=2Eopenvpn=2Ecom\0=2Eopenvpn=2Eorg\0&quot;);</span><br><span> </span><br><s=
pan>     /* Remove the last domain from a three-entry list */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    wchar_t domains_7[BUF_SIZE] =3D=
 L&quot;openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg&quot;;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    len =3D (DWORD)wcslen(domains_7) + 1=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size =3D len * g=
lyph_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wchar_t=
 domains_7_res[] =3D L&quot;=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet\0&quot;;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    err =3D ConvertItfDns=
Domains(L&quot;openvpn=2Eorg&quot;, domains_7, &amp;size, sizeof(domains_7)=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_memory_e=
qual(domains_7, domains_7_res, size);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    assert_int_equal(size, sizeof(domains_7_res));</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(err, NO_E=
RROR);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_con=
vert(L&quot;openvpn=2Eorg&quot;, L&quot;openvpn=2Ecom,openvpn=2Enet,openvpn=
=2Eorg&quot;, cap, NO_ERROR,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                  L&quot;=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet\0&quot=
;);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    /* Remove the last domain from a four-entry list because of size constr=
aints*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wchar_t do=
mains_8[BUF_SIZE] =3D L&quot;openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg,am-e=
nde-noch-eine-lange=2Ede&quot;;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    len =3D (DWORD)wcslen(domains_8) + 1;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    size =3D len * glyph_size;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    wchar_t domains_8_res[] =3D L&=
quot;=2Eopenvpn=2Ecom\0=2Eopenvpn=2Enet\0=2Eopenvpn=2Eorg\0&quot;;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    err =3D ConvertItfDnsDomai=
ns(NULL, domains_8, &amp;size, sizeof(domains_8));</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    assert_memory_equal(domains_8, domains_8_r=
es, size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_=
int_equal(size, sizeof(domains_8_res));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    assert_int_equal(err, ERROR_MORE_DATA);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* Empty entries are skipped =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_convert=
(NULL, L&quot;,a=2Ecom&quot;, cap, NO_ERROR, L&quot;=2Ea=2Ecom\0&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_convert(NULL=
, L&quot;a=2Ecom,&quot;, cap, NO_ERROR, L&quot;=2Ea=2Ecom\0&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    check_convert(NULL, L&q=
uot;a=2Ecom,,b=2Ecom&quot;, cap, NO_ERROR, L&quot;=2Ea=2Ecom\0=2Eb=2Ecom\0&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_co=
nvert(L&quot;a=2Ecom&quot;, L&quot;,a=2Ecom,&quot;, cap, ERROR_FILE_NOT_FOU=
ND, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check=
_convert(NULL, L&quot;,,,&quot;, cap, ERROR_FILE_NOT_FOUND, NULL);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    check_convert(NULL, L&qu=
ot;&quot;, cap, ERROR_FILE_NOT_FOUND, NULL);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* Size is 0 if all domains are removed */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    check_convert(L&quot;a=2Ecom,b=2Ecom&=
quot;, L&quot;b=2Ecom,a=2Ecom&quot;, cap, ERROR_FILE_NOT_FOUND, NULL);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Output exactly fills the buffer: 2=
 * (dot + 5 + NUL) + NUL */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    check_convert(NULL, L&quot;a=2Ecom,b=2Ecom&quot;, 15 * glyph_si=
ze, NO_ERROR, L&quot;=2Ea=2Ecom\0=2Eb=2Ecom\0&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Remove the last domain from a four-entry list because=
 of size constraints,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * all four would need 3 * 13 + 28 + 1 =3D 68 glyphs, the buffer is o=
ne glyph short */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  check_convert(NULL, L&quot;openvpn=2Ecom,openvpn=2Enet,openvpn=2Eorg,am-e=
nde-noch-eine-lange=2Ede&quot;,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                  67 * glyph_size, ERROR_MORE_DATA, L&quot;=2Eo=
penvpn=2Ecom\0=2Eopenvpn=2Enet\0=2Eopenvpn=2Eorg\0&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* Input fills the buffer, no space for dot and ter=
minators */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    chec=
k_convert(NULL, L&quot;a=2Ecom&quot;, 6 * glyph_size, ERROR_MORE_DATA, NULL=
);</span><br><span> }</span><br><span> </span><br><span> static void</span>=
<br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2016?usp=3Demail">change 2016</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2016?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn=
 </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Id: Id21a6b106c49d6647783e09a506add0726a1=
a6d2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2016 </div>
=
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: Heiko Hund &lt;heiko@openvpn=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>

</body></html>
--AgqzX1fHPZ0=--


--===============8050001979761300757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8050001979761300757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8050001979761300757==--

