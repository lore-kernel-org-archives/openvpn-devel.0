Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45CBCA9ECC
	for <openvpn-devel@archiver.kernel.org>; Sun, 11 Oct 2026 20:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vOWc42Qdh2uo2x75TIKheOT4p7CI9/Y7cqOgqnnuAKQ=; b=TtPdmlew1e6+V7FnTcQPfwOr3V
	8DKCOZ4rQBVhvN53miQ6LyRX41ippamajXGBVYDrfFtQwkNyPXTS5Rqv/vhDvnTnQPVkqNFKS+EoN
	o6whpC8IkQm2agBzVvsM2JCe0AMGn4HYEKNx31ThIjhhIns9n8ABgVyaghyUTr0+Q4o0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xG0El-0006cK-RT;
	Sun, 11 Oct 2026 20:33:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xG0EQ-0006br-VU
 for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 20:33:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=HRaJsVZLL6rn753AqC6TvicOxM108pthPNvjXpPb9a8=; b=ficAO0wj0wifK28S7MogYNqMre
 1wCZLOHu5BgpMDLpcyyv8Bkvqu8l9avyEyyWu85zoGz1aAcmAuubvQ9CiJMuY9gdmI01yieVkHPw+
 T4HyLlb9tS9C0zWuZnpoOTBw9uxBoMk+Q9DpkCShuw8C4hfZbpT/NAVrCwjzGbs3p+V8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HRaJsVZLL6rn753AqC6TvicOxM108pthPNvjXpPb9a8=; b=R
 CSuvINRv9VU3czoCbb2KWNsYjmVt6Q99KDwVHMJhB+MEIzwKebXeLeRIF1mS3zFRJpiFkPjKuAUyA
 AGGymlE1SCi6vK6s86OF0ka9KzNA5saD+geUa05qqL3/t78AA6BlXSEVNnVlMPqEyiEZjMbmqEUMg
 ZoaUHZynzrRCyrMM=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xG0EM-00053V-4s for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 20:33:15 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a16c1608faso16527545e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 11 Oct 2026 13:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791750787; x=1792355587; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HRaJsVZLL6rn753AqC6TvicOxM108pthPNvjXpPb9a8=;
 b=erOa+3IcPrt9o5LnwqJDfFzXIxQYowEzrxSD9i9WFw682AgZ8pwBRmtjcu7lQOM9L4
 A9lFlAoXVdPqZ1ILTp/dPOHFatrWZqQAVO/Eed5NPM5UlN3mbce3Q2hPtGwFcvbKbJ+2
 9on1Ll422Cu/6KOrOgy8ucRiJeeXQbi0gxv1DeOJN2EHhK8skV6GqdybQojPGjHxnttm
 GlnQ7QkqS7Lmo3Y+cn6HeHs73GHfjkey8pqoN8iT70G2+PSVg5LUZKSFkV0eUs90QGIl
 /0vhFoZzSTgDDf+yVQHPkVjS9OqLDXwCQB7LqcbqcLreiXfOCGSx5z2FVV3L0XZp+Gai
 SF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791750787; x=1792355587;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HRaJsVZLL6rn753AqC6TvicOxM108pthPNvjXpPb9a8=;
 b=SRJJarrJWQEZe21x50ic30iMMws6+jFYLa1zkII1eyRYJC9jPmaI4347fJIn6wXryX
 ZVuj4R9OG4uhYg/XinVqG9vX2bEOU3R46FpEvH9/eqW8oW/+jOZf1yeZi9IO91PF4TIn
 WIXlvNAqFqxkA4YsxAKT/lI4+c2ENJLmedpCLE2ESKUi+kluFnnzy3Fjhztod0S9trdf
 hiZDBsN/FdGpjlWhpchm7WOh8Jvk7pdzfxwIl6LNw4z6GtomzTEid6h6k+vJX7qo8SPH
 EnNBrAEnILp96rkAEZFUDTjCW36WaIuCg/FpfAqT7LfJURv47xx7m4gQlVVaxqJHbiZG
 SO/w==
X-Gm-Message-State: AFq9FYJpYllxov7OTvEDbrfm9qd4i66mZnJUNRpFQYtIMEwwbfMw8e3a
 vjf7ehB1Q6P/4W96XD//UigbpGMvtyTJbYx9RCOyVPY6WUgkbhW7NwzszZGrr3t5TKANQdYOhhw
 pZQHK1vPiJ18hc40djCqi7E093etSMUAFJqXS8m2CHCq9qCIZzRfZTDt2YC4BmEdG1ylzFY5RfT
 yX1T8KWQ==
X-Gm-Gg: AYBFou0I2coyBxzgInBxwEXNbDF7Ig/jSVqiPwseh8BNIXWZCng9glYgBikEeQKBosF
 M6vStpQ29Jf5vo1lA8PEYJh6olt1tVlnyNO7RDUpf35bD8Vxs8xxA0NXGZwvzLKvxrqrETnS5ba
 hvtUbQ0M6nDpPRelBeVwT48Wq6+cHUoFycnsguGgiuJQ6l1CWaMS37dqTfIAHyPsslEuu2B9hFo
 M1/D4q15tJrUGgQbRb3LYMpO6uLBk9QVCYB88NPysjAYqjQBDRW6Z3W4QB+htkQborjq4oXNb1w
 S/I8e9W0sj/GyjQ39smnW87EDjhtUuhkhNo4OYoMkYdjJrEr3Qo3QC44H9Knd5reTZgKr5Z0qEP
 WKkLcAJGRKpy97NvfU3IMZphIV6ULJy7I5sTp8HvzguH96h9D2zUtK2a0OEyGNUhLgFOWPjepkY
 ME0GLX22vXmCNqRtsibVXeRxbyuH6eRha4zvQGE3sOcGR3cWC3jqkU2vkrfaxzWw6rJQGFSsoTs
 tqMAOF59eKbmpCTs8OUm98ao8MbF/agwhmpsUfd9O5E3bWU3n913tX/47yIlHu5AVj1kQh3Gpyo
 wb5tqP34hl8APslm+KK6+IzLHKXncoZEqbNMXZzNmcEvLoIj3/fWUmxR+VKl
X-Received: by 2002:a05:600c:3b0a:b0:4a1:8963:b865 with SMTP id
 5b1f17b1804b1-4a18e447e9emr151262865e9.1.1791750786755; 
 Sun, 11 Oct 2026 13:33:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a199e5db12sm109157765e9.2.2026.10.11.13.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 13:33:06 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 11 Oct 2026 20:33:04 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: Ic30612971367a4aa54ca89f93452efc172d4f4e2
X-Gerrit-Change-Number: 1151
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1151?usp=email>
X-Gerrit-Commit: 984a5d08e5838afd5db8987837327de731798886
In-Reply-To: <gerrit.1755870317000.Ic30612971367a4aa54ca89f93452efc172d4f4e2@gerrit.openvpn.net>
References: <gerrit.1755870317000.Ic30612971367a4aa54ca89f93452efc172d4f4e2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzU1ODcwMzE3MDAwLkljMzA2MTI5NzEzNjdhNGFhNTRjYTg5ZjkzNDUyZWZjMTcyZDRmNGUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3fbe952230076533708b03c5b882d3d6dd558066-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xG0EM-00053V-4s
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7097157817668195475=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7097157817668195475==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Vi4pg3S0Au4="; charset=UTF-8

--Vi4pg3S0Au4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#11) to the change originally cr=
eated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1151?usp=3Demail )

The following approvals got outdated and were removed:
=
Code-Review+2 by R=C4=83zvan Cojocaru


Change subject: options: Introduce =
boolean_flag() and review usages of atoi_warn
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
Acked-by: Razvan Co=
jocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1151
Message-Id: <20261006142321=2E4601-1-gert@greenie=2Emuc=2Ed=
e>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg39741=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede=
>
---
M src/openvpn/options=2Ec
M src/openvpn/options_util=2Ec
M src/openvp=
n/options_util=2Eh
M tests/unit_tests/openvpn/test_misc=2Ec
4 files changed=
, 38 insertions(+), 11 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/51/1151/11

diff --git a/src/openvpn/options=
=2Ec b/src/openvpn/options=2Ec
index 60c2f5a=2E=2E6664c73 100644
--- a/src/=
openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -6402,7 +6402,7 @@
   =
  {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->sc_info=2E=
challenge_text =3D p[1];
-        if (atoi_warn(p[2], msglevel))
+        i=
f (boolean_flag(p[2], "static-challenge echo", msglevel))
         {
      =
       options->sc_info=2Eflags |=3D SC_ECHO;
         }
@@ -6777,7 +6777,7=
 @@
         options->exit_event_name =3D p[1];
         if (p[2])
        =
 {
-            options->exit_event_initial_state =3D (atoi_warn(p[2], msgl=
evel) !=3D 0);
+            options->exit_event_initial_state =3D boolean_f=
lag(p[2], "service state", msglevel);
         }
     }
     else if (streq=
(p[0], "allow-nonadmin") && !p[2])
@@ -7734,7 +7734,8 @@
     else if (stre=
q(p[0], "show-pkcs11-ids") && !p[3])
     {
         const char *provider =
=3D p[1];
-        bool cert_private =3D (p[2] =3D=3D NULL ? false : (atoi_=
warn(p[2], msglevel) !=3D 0));
+        bool cert_private =3D (p[2] =3D=3D =
NULL ? false
+                                          : boolean_flag(p[2]=
, "show-pkcs11-ids private", msglevel));
 
 #ifdef DEFAULT_PKCS11_MODULE
  =
       if (!provider)
@@ -7780,14 +7781,12 @@
     }
     else if (streq(p[=
0], "pkcs11-protected-authentication"))
     {
-        int j;
-
         V=
ERIFY_PERMISSION(OPT_P_GENERAL);
 
-        for (j =3D 1; j < MAX_PARMS && =
p[j] !=3D NULL; ++j)
+        for (int j =3D 1; j < MAX_PARMS && p[j] !=3D =
NULL; ++j)
         {
             options->pkcs11_protected_authentication=
[j - 1] =3D
-                atoi_warn(p[j], msglevel) !=3D 0 ? 1 : 0;
+   =
             boolean_flag(p[j], p[0], msglevel);
         }
     }
     els=
e if (streq(p[0], "pkcs11-private-mode") && p[1])
@@ -7803,13 +7802,11 @@
 =
    }
     else if (streq(p[0], "pkcs11-cert-private"))
     {
-        int=
 j;
-
         VERIFY_PERMISSION(OPT_P_GENERAL);
 
-        for (j =3D 1; j=
 < MAX_PARMS && p[j] !=3D NULL; ++j)
+        for (int j =3D 1; j < MAX_PAR=
MS && p[j] !=3D NULL; ++j)
         {
-            options->pkcs11_cert_pri=
vate[j - 1] =3D (bool)(atoi_warn(p[j], msglevel));
+            options->pk=
cs11_cert_private[j - 1] =3D boolean_flag(p[j], p[0], msglevel);
         }=

     }
     else if (streq(p[0], "pkcs11-pin-cache") && p[1] && !p[2])
dif=
f --git a/src/openvpn/options_util=2Ec b/src/openvpn/options_util=2Ec
index=
 779c38e=2E=2Ed25d85c 100644
--- a/src/openvpn/options_util=2Ec
+++ b/src/o=
penvpn/options_util=2Ec
@@ -194,6 +194,14 @@
     return true;
 }
 
+bool
+=
boolean_flag(const char *str, const char *name, msglvl_t msglevel)
+{
+    =
int number =3D 0;
+    atoi_constrained(str, &number, name, 0, 1, msglevel)=
;
+    return (bool)number;
+}
+
 static const char *updatable_options[] =
=3D { "block-ipv6", "block-outside-dns",
                                  =
          "dhcp-option", "dns",
                                           =
 "ifconfig", "ifconfig-ipv6",
diff --git a/src/openvpn/options_util=2Eh b/s=
rc/openvpn/options_util=2Eh
index 1d4ea9b=2E=2E5226a6f 100644
--- a/src/ope=
nvpn/options_util=2Eh
+++ b/src/openvpn/options_util=2Eh
@@ -69,6 +69,12 @@=

                       msglvl_t msglevel);
 
 /**
+ * Converts a str to an=
 boolean if the string can be parsed as either 0 or 1=2E
+ * Otherwise prin=
t a warning with \p msglevel and return \c false=2E
+ */
+bool boolean_flag=
(const char *str, const char *name, msglvl_t msglevel);
+
+/**
  * Filter a=
n option line by all pull filters=2E
  *
  * If a match is found, the line =
is modified depending on
diff --git a/tests/unit_tests/openvpn/test_misc=2E=
c b/tests/unit_tests/openvpn/test_misc=2Ec
index 052dea8=2E=2E8d88943 10064=
4
--- a/tests/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openv=
pn/test_misc=2Ec
@@ -441,6 +441,22 @@
     assert_string_equal(mock_msg_buf=
, "test: Must be an integer >=3D 1, not 0");
     assert_int_equal(paramete=
r, -42);
 
+    /* special tests for boolean_flag */
+    assert_false(bool=
ean_flag("0", "test", msglevel));
+    assert_true(boolean_flag("1", "test"=
, msglevel));
+
+    CLEAR(mock_msg_buf);
+    assert_false(boolean_flag("f=
oo77", "test", msglevel));
+    assert_string_equal(mock_msg_buf, "test: Ca=
nnot parse 'foo77' as integer");
+
+    CLEAR(mock_msg_buf);
+    assert_fa=
lse(boolean_flag("-77", "test", msglevel));
+    assert_string_equal(mock_m=
sg_buf, "test: Must be an integer between 0 and 1, not -77");
+
+    CLEAR(=
mock_msg_buf);
+    assert_false(boolean_flag("77", "test", msglevel));
+  =
  assert_string_equal(mock_msg_buf, "test: Must be an integer between 0 and=
 1, not 77");
+
     mock_set_debug_level(saved_log_level);
 }
 

-- 
To vi=
ew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1151?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic30612971367a4aa54ca89f9=
3452efc172d4f4e2
Gerrit-Change-Number: 1151
Gerrit-PatchSet: 11
Gerrit-Owne=
r: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>

--Vi4pg3S0Au4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #11</strong> to the change originally created by Fra=
nk Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1151?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">options: Introduce boolean_flag() and review usages of atoi_warn<br><br=
>This uses atoi_constrained=2E Note that this makes the tests<br>stricter s=
ince previously any non-zero integer would be<br>interpreted as &quot;true&=
quot;=2E<br><br>Change-Id: Ic30612971367a4aa54ca89f93452efc172d4f4e2<br>Sig=
ned-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: =
Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1151<br>Message-Id: &lt;20261006142321=2E4601-=
1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/open=
vpn-devel@lists=2Esourceforge=2Enet/msg39741=2Ehtml<br>Signed-off-by: Gert =
Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/options=2Ec=
<br>M src/openvpn/options_util=2Ec<br>M src/openvpn/options_util=2Eh<br>M t=
ests/unit_tests/openvpn/test_misc=2Ec<br>4 files changed, 38 insertions(+),=
 11 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/51/1151/11</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 60c2f5a=2E=
=2E6664c73 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><=
span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -6402,7 +6402,7 @@</s=
pan><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENER=
AL);</span><br><span>         options-&gt;sc_info=2Echallenge_text =3D p[1]=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (atoi_war=
n(p[2], msglevel))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (boolean_flag(p[2], &quot;static-challenge echo&quot;, msglevel))=
</span><br><span>         {</span><br><span>             options-&gt;sc_inf=
o=2Eflags |=3D SC_ECHO;</span><br><span>         }</span><br><span>@@ -6777=
,7 +6777,7 @@</span><br><span>         options-&gt;exit_event_name =3D p[1]=
;</span><br><span>         if (p[2])</span><br><span>         {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            options-&gt;exit_even=
t_initial_state =3D (atoi_warn(p[2], msglevel) !=3D 0);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            options-&gt;exit_event_init=
ial_state =3D boolean_flag(p[2], &quot;service state&quot;, msglevel);</spa=
n><br><span>         }</span><br><span>     }</span><br><span>     else if =
(streq(p[0], &quot;allow-nonadmin&quot;) &amp;&amp; !p[2])</span><br><span>=
@@ -7734,7 +7734,8 @@</span><br><span>     else if (streq(p[0], &quot;show-=
pkcs11-ids&quot;) &amp;&amp; !p[3])</span><br><span>     {</span><br><span>=
         const char *provider =3D p[1];</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        bool cert_private =3D (p[2] =3D=3D NULL ? false :=
 (atoi_warn(p[2], msglevel) !=3D 0));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        bool cert_private =3D (p[2] =3D=3D NULL ? false</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
                     : boolean_flag(p[2], &quot;show-pkcs11-ids private&quo=
t;, msglevel));</span><br><span> </span><br><span> #ifdef DEFAULT_PKCS11_MO=
DULE</span><br><span>         if (!provider)</span><br><span>@@ -7780,14 +7=
781,12 @@</span><br><span>     }</span><br><span>     else if (streq(p[0], =
&quot;pkcs11-protected-authentication&quot;))</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        int j;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         VERIFY_PE=
RMISSION(OPT_P_GENERAL);</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        for (j =3D 1; j &lt; MAX_PARMS &amp;&amp; p[j]=
 !=3D NULL; ++j)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     for (int j =3D 1; j &lt; MAX_PARMS &amp;&amp; p[j] !=3D NULL; ++j)</sp=
an><br><span>         {</span><br><span>             options-&gt;pkcs11_pro=
tected_authentication[j - 1] =3D</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                atoi_warn(p[j], msglevel) !=3D 0 ? 1 : 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                boolean_fl=
ag(p[j], p[0], msglevel);</span><br><span>         }</span><br><span>     }=
</span><br><span>     else if (streq(p[0], &quot;pkcs11-private-mode&quot;)=
 &amp;&amp; p[1])</span><br><span>@@ -7803,13 +7802,11 @@</span><br><span> =
    }</span><br><span>     else if (streq(p[0], &quot;pkcs11-cert-private&q=
uot;))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        int j;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        for (j =3D=
 1; j &lt; MAX_PARMS &amp;&amp; p[j] !=3D NULL; ++j)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        for (int j =3D 1; j &lt; MAX_PARM=
S &amp;&amp; p[j] !=3D NULL; ++j)</span><br><span>         {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            options-&gt;pkcs11_cert_=
private[j - 1] =3D (bool)(atoi_warn(p[j], msglevel));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            options-&gt;pkcs11_cert_priva=
te[j - 1] =3D boolean_flag(p[j], p[0], msglevel);</span><br><span>         =
}</span><br><span>     }</span><br><span>     else if (streq(p[0], &quot;pk=
cs11-pin-cache&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>dif=
f --git a/src/openvpn/options_util=2Ec b/src/openvpn/options_util=2Ec</span=
><br><span>index 779c38e=2E=2Ed25d85c 100644</span><br><span>--- a/src/open=
vpn/options_util=2Ec</span><br><span>+++ b/src/openvpn/options_util=2Ec</sp=
an><br><span>@@ -194,6 +194,14 @@</span><br><span>     return true;</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+boole=
an_flag(const char *str, const char *name, msglvl_t msglevel)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int number =3D 0;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    atoi_constrained(str, &amp;number, name, 0, 1=
, msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn (bool)number;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> st=
atic const char *updatable_options[] =3D { &quot;block-ipv6&quot;, &quot;bl=
ock-outside-dns&quot;,</span><br><span>                                    =
        &quot;dhcp-option&quot;, &quot;dns&quot;,</span><br><span>         =
                                   &quot;ifconfig&quot;, &quot;ifconfig-ipv=
6&quot;,</span><br><span>diff --git a/src/openvpn/options_util=2Eh b/src/op=
envpn/options_util=2Eh</span><br><span>index 1d4ea9b=2E=2E5226a6f 100644</s=
pan><br><span>--- a/src/openvpn/options_util=2Eh</span><br><span>+++ b/src/=
openvpn/options_util=2Eh</span><br><span>@@ -69,6 +69,12 @@</span><br><span=
>                       msglvl_t msglevel);</span><br><span> </span><br><sp=
an> /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Converts =
a str to an boolean if the string can be parsed as either 0 or 1=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * Otherwise print a warnin=
g with \p msglevel and return \c false=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+bool boolean_flag(const char *str, const char *name, msglvl_t msgleve=
l);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Filter an o=
ption line by all pull filters=2E</span><br><span>  *</span><br><span>  * I=
f a match is found, the line is modified depending on</span><br><span>diff =
--git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/t=
est_misc=2Ec</span><br><span>index 052dea8=2E=2E8d88943 100644</span><br><s=
pan>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/test=
s/unit_tests/openvpn/test_misc=2Ec</span><br><span>@@ -441,6 +441,22 @@</sp=
an><br><span>     assert_string_equal(mock_msg_buf, &quot;test: Must be an =
integer &gt;=3D 1, not 0&quot;);</span><br><span>     assert_int_equal(para=
meter, -42);</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* special tests for boolean_flag */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(boolean_flag(&quot;0&quo=
t;, &quot;test&quot;, msglevel));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_true(boolean_flag(&quot;1&quot;, &quot;test&quot;,=
 msglevel));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_msg_buf);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(bool=
ean_flag(&quot;foo77&quot;, &quot;test&quot;, msglevel));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf,=
 &quot;test: Cannot parse &#39;foo77&#39; as integer&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    CLEAR(mock_msg_buf);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_false(boolean_flag(&quot;-77&quot;, &=
quot;test&quot;, msglevel));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_string_equal(mock_msg_buf, &quot;test: Must be an integ=
er between 0 and 1, not -77&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 CLEAR(mock_msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_false(boolean_flag(&quot;77&quot;, &quot;test&quot;, msglevel)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string=
_equal(mock_msg_buf, &quot;test: Must be an integer between 0 and 1, not 77=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span>     mock_set_debug_level(saved_log_level);</span><br><span> }</span>=
<br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1151?usp=3Demail">change 1151</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1151?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Ic30612971367a4aa54ca89f93452efc172=
d4f4e2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1151 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>

</body></html>
--Vi4pg3S0Au4=--


--===============7097157817668195475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7097157817668195475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7097157817668195475==--

