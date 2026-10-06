Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E01CA5FED
	for <openvpn-devel@archiver.kernel.org>; Tue,  6 Oct 2026 13:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o4jUdVDbbD//xoyPyOlCWJIqJSE6xZXtUHXwensNEFo=; b=PEWnLsrzNWjeGjPynoQUrVlDY9
	e7OMfBuewYLOyt53JU5GhXGoBPkMhO8sxoekgzHP3F0eChwdfbjfR5AlhwrXcVGqJnhWb30FfOjM3
	BPpmA+CrKVDX1x75/jFYt6DO7Vujba82FWHJdzOQTe77SXdDDOIKNRbiXw26zVCqq3go=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xE5ZW-0007yf-0s;
	Tue, 06 Oct 2026 13:51:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xE5ZU-0007yQ-8n
 for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 13:51:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=QlOZiOX7Y0cNHaPVSJ0ed9ESQiSToEpwA/AE8+v1a/I=; b=PINgzlsOpM0NCfURFusVbkMlbC
 nZpZr9JbMSbqK9gF4YeC+69beFO1sHbAQ/Bsf2F2kHRBXsmzZeM/KkHJXhBSoZopUi2ODqX2gJaiT
 UZE4F1Bzf+Tf0OzDpN51wFp/JCihtNKBwL4JcWLB9ZVk5FwmHsJPwo0qpvupHUg09IBE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QlOZiOX7Y0cNHaPVSJ0ed9ESQiSToEpwA/AE8+v1a/I=; b=h
 FPsjdYbEtLoK0+YA8/u/0vcvopKeo+TnBbXWDNyK4IlwCY7B0tejKL7sdEwkK9XM6uJGPQgaZKfE9
 jXSwe4f9w7A9g6AkpwH4XGbBtlzVckchl6n3STM7Mv7yZ6zoHTV9tknhdvXk4RHH9BCz6vW/OXLgu
 GMyttQX5p7Aqyir4=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xE5ZT-0006zR-3M for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 13:51:08 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so14337495e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 06 Oct 2026 06:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791294660; x=1791899460; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QlOZiOX7Y0cNHaPVSJ0ed9ESQiSToEpwA/AE8+v1a/I=;
 b=HuO+Tx548yBMyqGvHfEYfe2UOB6YgFMWEATpWBV1JrSHikGfi1F19w1iISHHWJOalu
 2wjeThgpTHuPOzKmRnrznrVhYbu7ysRhKRk/IFiNqyIh8gUT0KQ7A+Tan9v6i9NqPOfn
 H+ZvaWHeLtnikwFR3FEdi2+Omtk0QsKS3VjSXFMCCEM3tf1BEyI547Y5kj3MjkkeoHFi
 h8kIbCJU1u5ZF109TTY20RdqpAX2n3ItcFkWO45A0iRAyfYMtxF/ZMBNpiVPV/CvCwCP
 MupuKNtFinAsZVcBZSMzGd9ThsSwA+1ZcvaS9vYHPxJsmBKuT7iEavlFlp9UnTdlDd+T
 x0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791294660; x=1791899460;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QlOZiOX7Y0cNHaPVSJ0ed9ESQiSToEpwA/AE8+v1a/I=;
 b=o6D0gtFYwrubKX0FpuHj51YK1H++fXwqb5qr3iMrJGUMUhKsxKupXszvfBfmvfi6sF
 ZiOGAf08/c1En5busDMtweepVfDzhrCPbc+RpHy7lurSkcR8em5pJGNYJV06S0p4KZlN
 1BUZ8q+Ghb9I8hkyWEpj23xqg2n6i1+EBj/vE4HTSzxlsREKH0uYmd528tONVbUz26Yy
 EnqjQTBpynhukJEqJycvE9ctRyWVunxxf5nla/voqL250qRUYZe3JuSR9wvuAXgPHo1J
 MNZb2ig5Ljd1As2tCdPNMui4qXHAocLjNWE7v9ujt10Zk9yFe97q+g6Q29/Gjlsvrpkx
 0F5Q==
X-Gm-Message-State: AFuF++m48qGBumBHkYIIAaj66bfBXJA00qeVpqM2nQlANcg+3TsR2lrk
 FSusPYRkyiwOUNCbdjwaResxtxjz8eF8CUeROglhSVUYDvqkEdfK+iKIjLfdPLtP/NdlmorL31k
 cZG1e6KbTFI6Ci0h9lunM5EPX3DMzLgH0KbvCcUZgqDGPqUBUHHPJHWnoCiEl689eFdrZ
X-Gm-Gg: AYBFou1YX1QUB/7fsldwJviKZ1SKzuFwkmAAz1tfoMKg6ybgJAPJuEZv68EK3mvx0cq
 cx4O0WbZNPM7N24SYGnz/DRwiwh8wfoPdFbusilP8FkVCWujP5YCLyNZ54giAoZd3iFILqv3Mrb
 GQCpKT25qvhmNP2LXnZfX5+g/wiREqLVY/CbGs7raTHh62P+001cRHUeBMoA77GdPHm6rnOQ4Qe
 28wjHtG4SSSAU4z4i8998I7YLkYWH6GOmhBAasvFcYELlcoFGi4DbyjrD9MZ/6OM4rqohZwC24w
 dd5FmY5pDDyVo42/iqSlrRYiYXXausbd9/cxAqBFyo1eAoIS+maeEUN0zGPk8X9nlz6Ijt/rZ+t
 hBh0P48VKqL8BYb3rEz0vKulQOBhba+3p2iCBf+RgXokbqDskHc9671dDniA+mynSt5vuKRK+n0
 HlaLcVkMvKX3WjAN8m0/VLCLbdz6rz8Zy7IpN8kt2tCnrhQfrRhNg7v0ZqjRNkc5iwi/n4bw0SO
 Ut+bSwqG2dM8BNjopRnqUdDDfgh3HPXD2+42Eb6flESp8THRc2AdNhF2/hEcWlkQw8M4VUh8p+n
 9g/igC+N5DmP1w0hqO0D/DFLn/dfGgrwJ/LG8s2e6kOkWh96bzSgUUmavj6c
X-Received: by 2002:a05:600c:3511:b0:4a0:1cfd:321 with SMTP id
 5b1f17b1804b1-4a17b549263mr26918875e9.12.1791294660155; 
 Tue, 06 Oct 2026 06:51:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cd717f8sm3456672f8f.48.2026.10.06.06.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 06:50:59 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 6 Oct 2026 13:50:58 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: Ic30612971367a4aa54ca89f93452efc172d4f4e2
X-Gerrit-Change-Number: 1151
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1151?usp=email>
X-Gerrit-Commit: 5a70f4a53a12f6a78dc741ddee0e14ff0b79f2c6
In-Reply-To: <gerrit.1755870317000.Ic30612971367a4aa54ca89f93452efc172d4f4e2@gerrit.openvpn.net>
References: <gerrit.1755870317000.Ic30612971367a4aa54ca89f93452efc172d4f4e2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzU1ODcwMzE3MDAwLkljMzA2MTI5NzEzNjdhNGFhNTRjYTg5ZjkzNDUyZWZjMTcyZDRmNGUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3b0f74d188c47a5f063d448a0a9e7fd663b76ceb-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xE5ZT-0006zR-3M
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: Introduce
 boolean_flag() and review usages of atoi_warn
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1947552508300763653=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1947552508300763653==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="57h2zyUJaBk="; charset=UTF-8

--57h2zyUJaBk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like y=
ou to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1151?usp=3Demail

to look at the new patch set (#10)=2E

The =
following approvals got outdated and were removed:
Code-Review+2 by R=C4=83=
zvan Cojocaru

The change is no longer submittable: Code-Review and checks~=
ChecksSubmitRule are unsatisfied now=2E


Change subject: options: Introduc=
e boolean_flag() and review usages of atoi_warn
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

options: Introduce boolean_flag() and re=
view usages of atoi_warn

This uses atoi_constrained=2E Note that this make=
s the tests
stricter since previously any non-zero integer would be
interpr=
eted as "true"=2E

Change-Id: Ic30612971367a4aa54ca89f93452efc172d4f4e2
Sig=
ned-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/openvpn/o=
ptions=2Ec
M src/openvpn/options_util=2Ec
M src/openvpn/options_util=2Eh
M =
tests/unit_tests/openvpn/test_misc=2Ec
4 files changed, 38 insertions(+), 1=
1 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/51/1151/10

diff --git a/src/openvpn/options=2Ec b/src/openvpn/opt=
ions=2Ec
index 5d10390=2E=2Ef19f683 100644
--- a/src/openvpn/options=2Ec
++=
+ b/src/openvpn/options=2Ec
@@ -6388,7 +6388,7 @@
     {
         VERIFY_PE=
RMISSION(OPT_P_GENERAL);
         options->sc_info=2Echallenge_text =3D p[1=
];
-        if (atoi_warn(p[2], msglevel))
+        if (boolean_flag(p[2], =
"static-challenge echo", msglevel))
         {
             options->sc_inf=
o=2Eflags |=3D SC_ECHO;
         }
@@ -6763,7 +6763,7 @@
         options->=
exit_event_name =3D p[1];
         if (p[2])
         {
-            option=
s->exit_event_initial_state =3D (atoi_warn(p[2], msglevel) !=3D 0);
+      =
      options->exit_event_initial_state =3D boolean_flag(p[2], "service sta=
te", msglevel);
         }
     }
     else if (streq(p[0], "allow-nonadmin=
") && !p[2])
@@ -7720,7 +7720,8 @@
     else if (streq(p[0], "show-pkcs11-i=
ds") && !p[3])
     {
         const char *provider =3D p[1];
-        bool=
 cert_private =3D (p[2] =3D=3D NULL ? false : (atoi_warn(p[2], msglevel) !=
=3D 0));
+        bool cert_private =3D (p[2] =3D=3D NULL ? false
+        =
                                  : boolean_flag(p[2], "show-pkcs11-ids pri=
vate", msglevel));
 
 #ifdef DEFAULT_PKCS11_MODULE
         if (!provider)
=
@@ -7766,14 +7767,12 @@
     }
     else if (streq(p[0], "pkcs11-protected-=
authentication"))
     {
-        int j;
-
         VERIFY_PERMISSION(OPT_P=
_GENERAL);
 
-        for (j =3D 1; j < MAX_PARMS && p[j] !=3D NULL; ++j)
+=
        for (int j =3D 1; j < MAX_PARMS && p[j] !=3D NULL; ++j)
         {
=
             options->pkcs11_protected_authentication[j - 1] =3D
-         =
       atoi_warn(p[j], msglevel) !=3D 0 ? 1 : 0;
+                boolean_f=
lag(p[j], p[0], msglevel);
         }
     }
     else if (streq(p[0], "pkc=
s11-private-mode") && p[1])
@@ -7789,13 +7788,11 @@
     }
     else if (st=
req(p[0], "pkcs11-cert-private"))
     {
-        int j;
-
         VERIFY_=
PERMISSION(OPT_P_GENERAL);
 
-        for (j =3D 1; j < MAX_PARMS && p[j] !=
=3D NULL; ++j)
+        for (int j =3D 1; j < MAX_PARMS && p[j] !=3D NULL; =
++j)
         {
-            options->pkcs11_cert_private[j - 1] =3D (bool)=
(atoi_warn(p[j], msglevel));
+            options->pkcs11_cert_private[j - =
1] =3D boolean_flag(p[j], p[0], msglevel);
         }
     }
     else if (=
streq(p[0], "pkcs11-pin-cache") && p[1] && !p[2])
diff --git a/src/openvpn/=
options_util=2Ec b/src/openvpn/options_util=2Ec
index 779c38e=2E=2Ed25d85c =
100644
--- a/src/openvpn/options_util=2Ec
+++ b/src/openvpn/options_util=2E=
c
@@ -194,6 +194,14 @@
     return true;
 }
 
+bool
+boolean_flag(const cha=
r *str, const char *name, msglvl_t msglevel)
+{
+    int number =3D 0;
+   =
 atoi_constrained(str, &number, name, 0, 1, msglevel);
+    return (bool)nu=
mber;
+}
+
 static const char *updatable_options[] =3D { "block-ipv6", "blo=
ck-outside-dns",
                                            "dhcp-option",=
 "dns",
                                            "ifconfig", "ifconfig-i=
pv6",
diff --git a/src/openvpn/options_util=2Eh b/src/openvpn/options_util=
=2Eh
index 1d4ea9b=2E=2E5226a6f 100644
--- a/src/openvpn/options_util=2Eh
+=
++ b/src/openvpn/options_util=2Eh
@@ -69,6 +69,12 @@
                      =
 msglvl_t msglevel);
 
 /**
+ * Converts a str to an boolean if the string =
can be parsed as either 0 or 1=2E
+ * Otherwise print a warning with \p msg=
level and return \c false=2E
+ */
+bool boolean_flag(const char *str, const=
 char *name, msglvl_t msglevel);
+
+/**
  * Filter an option line by all pu=
ll filters=2E
  *
  * If a match is found, the line is modified depending o=
n
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/op=
envpn/test_misc=2Ec
index a41c27b=2E=2E91c2a59 100644
--- a/tests/unit_test=
s/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -44=
1,6 +441,22 @@
     assert_string_equal(mock_msg_buf, "test: Must be an int=
eger >=3D 1, not 0");
     assert_int_equal(parameter, -42);
 
+    /* spec=
ial tests for boolean_flag */
+    assert_false(boolean_flag("0", "test", m=
sglevel));
+    assert_true(boolean_flag("1", "test", msglevel));
+
+    CL=
EAR(mock_msg_buf);
+    assert_false(boolean_flag("foo77", "test", msglevel=
));
+    assert_string_equal(mock_msg_buf, "test: Cannot parse 'foo77' as i=
nteger");
+
+    CLEAR(mock_msg_buf);
+    assert_false(boolean_flag("-77",=
 "test", msglevel));
+    assert_string_equal(mock_msg_buf, "test: Must be =
an integer between 0 and 1, not -77");
+
+    CLEAR(mock_msg_buf);
+    ass=
ert_false(boolean_flag("77", "test", msglevel));
+    assert_string_equal(m=
ock_msg_buf, "test: Must be an integer between 0 and 1, not 77");
+
     mo=
ck_set_debug_level(saved_log_level);
 }
 

-- 
To view, visit https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1151?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Ic30612971367a4aa54ca89f93452efc172d4f4e2
Gerrit=
-Change-Number: 1151
Gerrit-PatchSet: 10
Gerrit-Owner: Frank Lichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <fra=
nk@lichtenheld=2Ecom>

--57h2zyUJaBk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Frank Lichtenheld <strong>uploaded patch set #10</strong> to th=
is change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/11=
51?usp=3Demail">View Change</a></p><p>The following approvals got outdated =
and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><p>The change is=
 no longer submittable: Code-Review and checks~ChecksSubmitRule are unsatis=
fied now=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">options: Introduce boolean_flag() and review u=
sages of atoi_warn<br><br>This uses atoi_constrained=2E Note that this make=
s the tests<br>stricter since previously any non-zero integer would be<br>i=
nterpreted as &quot;true&quot;=2E<br><br>Change-Id: Ic30612971367a4aa54ca89=
f93452efc172d4f4e2<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt;<br>---<br>M src/openvpn/options=2Ec<br>M src/openvpn/options_ut=
il=2Ec<br>M src/openvpn/options_util=2Eh<br>M tests/unit_tests/openvpn/test=
_misc=2Ec<br>4 files changed, 38 insertions(+), 11 deletions(-)<br><br></pr=
e><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/51/1151/10</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn=
/options=2Ec</span><br><span>index 5d10390=2E=2Ef19f683 100644</span><br><s=
pan>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=
=2Ec</span><br><span>@@ -6388,7 +6388,7 @@</span><br><span>     {</span><br=
><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>         =
options-&gt;sc_info=2Echallenge_text =3D p[1];</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        if (atoi_warn(p[2], msglevel))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (boolean_flag(p[2], =
&quot;static-challenge echo&quot;, msglevel))</span><br><span>         {</s=
pan><br><span>             options-&gt;sc_info=2Eflags |=3D SC_ECHO;</span>=
<br><span>         }</span><br><span>@@ -6763,7 +6763,7 @@</span><br><span>=
         options-&gt;exit_event_name =3D p[1];</span><br><span>         if =
(p[2])</span><br><span>         {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            options-&gt;exit_event_initial_state =3D (atoi_warn=
(p[2], msglevel) !=3D 0);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            options-&gt;exit_event_initial_state =3D boolean_flag(p[2=
], &quot;service state&quot;, msglevel);</span><br><span>         }</span><=
br><span>     }</span><br><span>     else if (streq(p[0], &quot;allow-nonad=
min&quot;) &amp;&amp; !p[2])</span><br><span>@@ -7720,7 +7720,8 @@</span><b=
r><span>     else if (streq(p[0], &quot;show-pkcs11-ids&quot;) &amp;&amp; !=
p[3])</span><br><span>     {</span><br><span>         const char *provider =
=3D p[1];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        bool=
 cert_private =3D (p[2] =3D=3D NULL ? false : (atoi_warn(p[2], msglevel) !=
=3D 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        boo=
l cert_private =3D (p[2] =3D=3D NULL ? false</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                          : boolea=
n_flag(p[2], &quot;show-pkcs11-ids private&quot;, msglevel));</span><br><sp=
an> </span><br><span> #ifdef DEFAULT_PKCS11_MODULE</span><br><span>        =
 if (!provider)</span><br><span>@@ -7766,14 +7767,12 @@</span><br><span>   =
  }</span><br><span>     else if (streq(p[0], &quot;pkcs11-protected-authen=
tication&quot;))</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        int j;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
for (j =3D 1; j &lt; MAX_PARMS &amp;&amp; p[j] !=3D NULL; ++j)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        for (int j =3D 1; j &lt;=
 MAX_PARMS &amp;&amp; p[j] !=3D NULL; ++j)</span><br><span>         {</span=
><br><span>             options-&gt;pkcs11_protected_authentication[j - 1] =
=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                at=
oi_warn(p[j], msglevel) !=3D 0 ? 1 : 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                boolean_flag(p[j], p[0], msglevel);</sp=
an><br><span>         }</span><br><span>     }</span><br><span>     else if=
 (streq(p[0], &quot;pkcs11-private-mode&quot;) &amp;&amp; p[1])</span><br><=
span>@@ -7789,13 +7788,11 @@</span><br><span>     }</span><br><span>     el=
se if (streq(p[0], &quot;pkcs11-cert-private&quot;))</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int j;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         VE=
RIFY_PERMISSION(OPT_P_GENERAL);</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        for (j =3D 1; j &lt; MAX_PARMS &amp;&am=
p; p[j] !=3D NULL; ++j)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        for (int j =3D 1; j &lt; MAX_PARMS &amp;&amp; p[j] !=3D NULL; +=
+j)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            options-&gt;pkcs11_cert_private[j - 1] =3D (bool)(atoi=
_warn(p[j], msglevel));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            options-&gt;pkcs11_cert_private[j - 1] =3D boolean_flag(p[j=
], p[0], msglevel);</span><br><span>         }</span><br><span>     }</span=
><br><span>     else if (streq(p[0], &quot;pkcs11-pin-cache&quot;) &amp;&am=
p; p[1] &amp;&amp; !p[2])</span><br><span>diff --git a/src/openvpn/options_=
util=2Ec b/src/openvpn/options_util=2Ec</span><br><span>index 779c38e=2E=2E=
d25d85c 100644</span><br><span>--- a/src/openvpn/options_util=2Ec</span><br=
><span>+++ b/src/openvpn/options_util=2Ec</span><br><span>@@ -194,6 +194,14=
 @@</span><br><span>     return true;</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+boolean_flag(const char *str, const=
 char *name, msglvl_t msglevel)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in=
t number =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
atoi_constrained(str, &amp;number, name, 0, 1, msglevel);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return (bool)number;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> static const char *updatable_opt=
ions[] =3D { &quot;block-ipv6&quot;, &quot;block-outside-dns&quot;,</span><=
br><span>                                            &quot;dhcp-option&quot=
;, &quot;dns&quot;,</span><br><span>                                       =
     &quot;ifconfig&quot;, &quot;ifconfig-ipv6&quot;,</span><br><span>diff =
--git a/src/openvpn/options_util=2Eh b/src/openvpn/options_util=2Eh</span><=
br><span>index 1d4ea9b=2E=2E5226a6f 100644</span><br><span>--- a/src/openvp=
n/options_util=2Eh</span><br><span>+++ b/src/openvpn/options_util=2Eh</span=
><br><span>@@ -69,6 +69,12 @@</span><br><span>                       msglvl=
_t msglevel);</span><br><span> </span><br><span> /**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Converts a str to an boolean if the st=
ring can be parsed as either 0 or 1=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Otherwise print a warning with \p msglevel and return=
 \c false=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+bool boolean_flag(const=
 char *str, const char *name, msglvl_t msglevel);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/**</span><br><span>  * Filter an option line by all pull filter=
s=2E</span><br><span>  *</span><br><span>  * If a match is found, the line =
is modified depending on</span><br><span>diff --git a/tests/unit_tests/open=
vpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>=
index a41c27b=2E=2E91c2a59 100644</span><br><span>--- a/tests/unit_tests/op=
envpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_mis=
c=2Ec</span><br><span>@@ -441,6 +441,22 @@</span><br><span>     assert_stri=
ng_equal(mock_msg_buf, &quot;test: Must be an integer &gt;=3D 1, not 0&quot=
;);</span><br><span>     assert_int_equal(parameter, -42);</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* special tes=
ts for boolean_flag */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_false(boolean_flag(&quot;0&quot;, &quot;test&quot;, msglevel)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(b=
oolean_flag(&quot;1&quot;, &quot;test&quot;, msglevel));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    CLEAR(mock_msg_buf);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_false(boolean_flag(&quot;foo77&quot;, &qu=
ot;test&quot;, msglevel));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_string_equal(mock_msg_buf, &quot;test: Cannot parse &#39;=
foo77&#39; as integer&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR=
(mock_msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_false(boolean_flag(&quot;-77&quot;, &quot;test&quot;, msglevel));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equa=
l(mock_msg_buf, &quot;test: Must be an integer between 0 and 1, not -77&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_msg_buf);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(boolean_flag=
(&quot;77&quot;, &quot;test&quot;, msglevel));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;test=
: Must be an integer between 0 and 1, not 77&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     mock_set_debug_leve=
l(saved_log_level);</span><br><span> }</span><br></pre><p>To view, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1151?usp=3Demail">chang=
e 1151</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1151?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Ic30612971367a4aa54ca89f93452efc172d4f4e2 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1151 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank L=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=


</body></html>
--57h2zyUJaBk=--


--===============1947552508300763653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1947552508300763653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1947552508300763653==--

