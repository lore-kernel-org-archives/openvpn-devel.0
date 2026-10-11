Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2FBCA9ECF
	for <openvpn-devel@archiver.kernel.org>; Sun, 11 Oct 2026 20:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kW2ctUT+qhYFMbbDYxeTnYinah95kwx6Xfqqt6JxeoU=; b=bfOjheZmTeCxk8RRAMKAixcrdg
	1FYE+ScTirRm1oP0AKB4D4rZ18fycTm4vYTT/YpuQpb37C/5c/DnT4IOmqcjNj7w13LxQ7hIUnO9w
	9wY70mM7MDZHjO50WLtlbAVUAVVgzwQtnZZYDwm9NrwS+CW5QfWNMQFaU77HJvEizZnU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xG0En-0004hJ-F4;
	Sun, 11 Oct 2026 20:33:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xG0ER-0004gy-MM
 for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 20:33:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=QMOji1W93qXHvBgO0Feji+fccH3q/hdiSh6NqgBKWiE=; b=cErYZL7tWCLSL5jH7GTpNTHGRV
 OVm3E2BJbkGisXt0VNJw8aPhsmMiqnJmQe/fLYqwQmsPOBBUQsmmaxgQMA3oizSJZmEDeRvxugnHA
 9oUU3Pw1fUJ6OTRQuWgqlBcUO+i4luOr8OILd9cCalEZ5ULi87RUzwMsHQA0ReFqevEU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QMOji1W93qXHvBgO0Feji+fccH3q/hdiSh6NqgBKWiE=; b=U
 d2y6BNycGBXbaNzgVLNnudX8KChFtCPfw1iCDeQDwrW/+/9iIndlgg6Ia0rstu22xmWfAp7AO3VCt
 JM1SqHd/P6bg8IBzwLXqQqbNTmVvwCZTdzW3x2fCKr0cdZMbxnvoQamBSeIudMgrO6lBetXCux8zR
 1suHAksPQSnXEBWw=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xG0EM-0003er-E9 for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 20:33:15 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48c02782159so720660f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 11 Oct 2026 13:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791750788; x=1792355588; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QMOji1W93qXHvBgO0Feji+fccH3q/hdiSh6NqgBKWiE=;
 b=Zj4rfddKqTWNXonWjqiOmsV7QgWiO2j0ES9YX+P12cwOeZ44wvB8e8kmaOCzSZS9rP
 aCG3vuon4DMsH9fcpC7iAKg0j9SXxCb1YwrO1EoJpyMPSwZk8GngAuxs+eCwVNl+ST07
 WsIu9XJNGPDtZ0Al5MQTSPTal0J1fr6B3ACC+FF6j+R9leJ8ZgyVAcG00FUPF5UKen0U
 /iTvvnBlVZRIvcdp6SztAHFl9sWC/AT/nbTPNY6XXGVyWxyOWbNai8VGNXUsd+0TYmd/
 XJatXb24/lSTXGvj8LP96ccib7gi5PwFUcl2y7DcTa5yEs4IAf6dZxS55YyKoOzbjb9R
 6SOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791750788; x=1792355588;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QMOji1W93qXHvBgO0Feji+fccH3q/hdiSh6NqgBKWiE=;
 b=KPyskgCRATjlKeIiCMbY9qNy2A8xcLjhTealyeDOuWwDHeNR/lBHYUnd5zT0wVvFVq
 EtSBqsRChRaojL1Irl3I9eFMFw3ZpQQl/LP0Duy/TuQyQ9RpBOcr5/ZEXt0S8U+3qZst
 CrMl1Vulb7hPgWk+61waHR3MxgLRv2VF+xGWWHnSEWqAURhr0vlcWFqEmK3aND5phxDT
 WtyD73nWxb5w0spPr3hQ4tJrlHSGcd8KRSYIkA0x/GqLFgFZgcxLziPb2Dspa682Jr+N
 hAHlG46WWEv4PQVtX1gBFjGE2ujgR6KajgJVHvvP4KIe862QMT/1n1jiF6vxjXZ0yBto
 jyUg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxI8rVDZkk9Y271WFtTSG+Wyh2juQa9Ob7qfEbQ4GP0mpu9dHALm0rhtxwKtLeMnW0OjWZJidSSUzq2Shtr@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIlpiofiRS+GelMCBRgtUHBV30fbi5QXsBmECygFVg+IANHq+vp
 XjdDRCcEQ/Y3vrrL8KtvpC5bevbVqTD1vR4nR8sIns8k1REgugxkne7nA5n7OaceOrU2ujH2oEY
 yEZc+VBCj5DKCNbLlZ3RMKzKJ1UGy7Jl1JcRcCZuerNxDpK0+9BRcWF1rTOMn6rmywvs8
X-Gm-Gg: AYBFou0Czl1H3sjBylRhcsuykK3k6t1eUm5LrlLCWaLBZAlOnJXrUnHCXZN7oAO4eED
 bUOVomKT36JBTo/run5oKIq5uU7PTVNSqBCXAE2dOmI7JIuCjlvsJDPt60MH+J777mByZPbl0vW
 KZ+W1fd4lz9+NkX9fiLqHEE1nbz5niJa7v2bky7XiP9JxvJtSYQoZ7chMH5bH+bwGUVpGNl3s4Q
 +bZ9tQ9zxj7stprgw6KnfkpWNRsHG27XULk+FB5RBFVmUEjdzTO0ycKxz1yUA+0mQfm579bEwEz
 l+26OISkzy+EOKUFA7g1i8xKwYXJ5+Dmugzarno1zjGw6ZVAhqd4Pfc8U1Lrxs3X1vqhIcR9XBj
 6YhO9TVyXvv8VTCCsuYpdunUQdyv8oBOCVEZ+ITxc4VDW81+z2Oi2HP4CWW1hX/bBsUryRLiW6g
 46j5hZOD6MW/hMvKqtQkPOLxaAmf901gFxoQqDCbiGhfyyjaaTkNKqjKVkmH2uOs7oebv8ClxiL
 /LIGXob++cZSS3wpFbTmPXZHq4Aa+nNf2BDMe20bBTNQmUvfKDDOqBoKPZnl4941MR6M/tjPoRX
 uS4P4r2LVnqsRSI8+UUqTtf9k/j2L8fSEEjH8dsmubbkFBBOoVOlZfqtUgWk
X-Received: by 2002:a05:600c:a010:b0:4a0:2500:2cd0 with SMTP id
 5b1f17b1804b1-4a18e4b4646mr128193365e9.18.1791750787465; 
 Sun, 11 Oct 2026 13:33:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf21276sm369374005e9.8.2026.10.11.13.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 13:33:07 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 11 Oct 2026 20:33:06 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: Ic30612971367a4aa54ca89f93452efc172d4f4e2
X-Gerrit-Change-Number: 1151
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1151?usp=email>
X-Gerrit-Commit: 984a5d08e5838afd5db8987837327de731798886
In-Reply-To: <gerrit.1755870317000.Ic30612971367a4aa54ca89f93452efc172d4f4e2@gerrit.openvpn.net>
References: <gerrit.1755870317000.Ic30612971367a4aa54ca89f93452efc172d4f4e2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzU1ODcwMzE3MDAwLkljMzA2MTI5NzEzNjdhNGFhNTRjYTg5ZjkzNDUyZWZjMTcyZDRmNGUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3fbe952230076533708b03c5b882d3d6dd558066-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xG0EM-0003er-E9
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1314691048774900691=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1314691048774900691==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TYwffOV1eWw="; charset=UTF-8

--TYwffOV1eWw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1151?usp=3Demail )

Change subject: options: Introduce boolean_=
flag() and review usages of atoi_warn
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

options: Introduce boolean_flag() and review usag=
es of atoi_warn

This uses atoi_constrained=2E Note that this makes the tes=
ts
stricter since previously any non-zero integer would be
interpreted as "=
true"=2E

Change-Id: Ic30612971367a4aa54ca89f93452efc172d4f4e2
Signed-off-b=
y: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <r=
azvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1151
Message-Id: <20261006142321=2E4601-1-gert@greenie=2Emuc=2Ede>
URL: h=
ttps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg=
39741=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M sr=
c/openvpn/options=2Ec
M src/openvpn/options_util=2Ec
M src/openvpn/options_=
util=2Eh
M tests/unit_tests/openvpn/test_misc=2Ec
4 files changed, 38 inser=
tions(+), 11 deletions(-)




diff --git a/src/openvpn/options=2Ec b/src/op=
envpn/options=2Ec
index 60c2f5a=2E=2E6664c73 100644
--- a/src/openvpn/optio=
ns=2Ec
+++ b/src/openvpn/options=2Ec
@@ -6402,7 +6402,7 @@
     {
         =
VERIFY_PERMISSION(OPT_P_GENERAL);
         options->sc_info=2Echallenge_tex=
t =3D p[1];
-        if (atoi_warn(p[2], msglevel))
+        if (boolean_fl=
ag(p[2], "static-challenge echo", msglevel))
         {
             option=
s->sc_info=2Eflags |=3D SC_ECHO;
         }
@@ -6777,7 +6777,7 @@
         =
options->exit_event_name =3D p[1];
         if (p[2])
         {
-         =
   options->exit_event_initial_state =3D (atoi_warn(p[2], msglevel) !=3D 0)=
;
+            options->exit_event_initial_state =3D boolean_flag(p[2], "se=
rvice state", msglevel);
         }
     }
     else if (streq(p[0], "allow=
-nonadmin") && !p[2])
@@ -7734,7 +7734,8 @@
     else if (streq(p[0], "show=
-pkcs11-ids") && !p[3])
     {
         const char *provider =3D p[1];
-   =
     bool cert_private =3D (p[2] =3D=3D NULL ? false : (atoi_warn(p[2], msg=
level) !=3D 0));
+        bool cert_private =3D (p[2] =3D=3D NULL ? false
+=
                                          : boolean_flag(p[2], "show-pkcs11=
-ids private", msglevel));
 
 #ifdef DEFAULT_PKCS11_MODULE
         if (!pr=
ovider)
@@ -7780,14 +7781,12 @@
     }
     else if (streq(p[0], "pkcs11-pr=
otected-authentication"))
     {
-        int j;
-
         VERIFY_PERMISSI=
ON(OPT_P_GENERAL);
 
-        for (j =3D 1; j < MAX_PARMS && p[j] !=3D NULL=
; ++j)
+        for (int j =3D 1; j < MAX_PARMS && p[j] !=3D NULL; ++j)
   =
      {
             options->pkcs11_protected_authentication[j - 1] =3D
- =
               atoi_warn(p[j], msglevel) !=3D 0 ? 1 : 0;
+                b=
oolean_flag(p[j], p[0], msglevel);
         }
     }
     else if (streq(p[=
0], "pkcs11-private-mode") && p[1])
@@ -7803,13 +7802,11 @@
     }
     els=
e if (streq(p[0], "pkcs11-cert-private"))
     {
-        int j;
-
        =
 VERIFY_PERMISSION(OPT_P_GENERAL);
 
-        for (j =3D 1; j < MAX_PARMS &=
& p[j] !=3D NULL; ++j)
+        for (int j =3D 1; j < MAX_PARMS && p[j] !=
=3D NULL; ++j)
         {
-            options->pkcs11_cert_private[j - 1] =
=3D (bool)(atoi_warn(p[j], msglevel));
+            options->pkcs11_cert_pr=
ivate[j - 1] =3D boolean_flag(p[j], p[0], msglevel);
         }
     }
    =
 else if (streq(p[0], "pkcs11-pin-cache") && p[1] && !p[2])
diff --git a/sr=
c/openvpn/options_util=2Ec b/src/openvpn/options_util=2Ec
index 779c38e=2E=
=2Ed25d85c 100644
--- a/src/openvpn/options_util=2Ec
+++ b/src/openvpn/opti=
ons_util=2Ec
@@ -194,6 +194,14 @@
     return true;
 }
 
+bool
+boolean_fla=
g(const char *str, const char *name, msglvl_t msglevel)
+{
+    int number =
=3D 0;
+    atoi_constrained(str, &number, name, 0, 1, msglevel);
+    retu=
rn (bool)number;
+}
+
 static const char *updatable_options[] =3D { "block-=
ipv6", "block-outside-dns",
                                            "dh=
cp-option", "dns",
                                            "ifconfig", =
"ifconfig-ipv6",
diff --git a/src/openvpn/options_util=2Eh b/src/openvpn/op=
tions_util=2Eh
index 1d4ea9b=2E=2E5226a6f 100644
--- a/src/openvpn/options_=
util=2Eh
+++ b/src/openvpn/options_util=2Eh
@@ -69,6 +69,12 @@
            =
           msglvl_t msglevel);
 
 /**
+ * Converts a str to an boolean if t=
he string can be parsed as either 0 or 1=2E
+ * Otherwise print a warning w=
ith \p msglevel and return \c false=2E
+ */
+bool boolean_flag(const char *=
str, const char *name, msglvl_t msglevel);
+
+/**
  * Filter an option line=
 by all pull filters=2E
  *
  * If a match is found, the line is modified d=
epending on
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/uni=
t_tests/openvpn/test_misc=2Ec
index 052dea8=2E=2E8d88943 100644
--- a/tests=
/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=
=2Ec
@@ -441,6 +441,22 @@
     assert_string_equal(mock_msg_buf, "test: Mus=
t be an integer >=3D 1, not 0");
     assert_int_equal(parameter, -42);
 
+=
    /* special tests for boolean_flag */
+    assert_false(boolean_flag("0"=
, "test", msglevel));
+    assert_true(boolean_flag("1", "test", msglevel))=
;
+
+    CLEAR(mock_msg_buf);
+    assert_false(boolean_flag("foo77", "test=
", msglevel));
+    assert_string_equal(mock_msg_buf, "test: Cannot parse '=
foo77' as integer");
+
+    CLEAR(mock_msg_buf);
+    assert_false(boolean_=
flag("-77", "test", msglevel));
+    assert_string_equal(mock_msg_buf, "tes=
t: Must be an integer between 0 and 1, not -77");
+
+    CLEAR(mock_msg_buf=
);
+    assert_false(boolean_flag("77", "test", msglevel));
+    assert_str=
ing_equal(mock_msg_buf, "test: Must be an integer between 0 and 1, not 77")=
;
+
     mock_set_debug_level(saved_log_level);
 }
 

-- 
To view, visit ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1151?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: Ic30612971367a4aa54ca89f93452efc172d4f4e2
=
Gerrit-Change-Number: 1151
Gerrit-PatchSet: 11
Gerrit-Owner: Frank Lichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--TYwffOV1eWw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1151?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">options: Introduce boolean_flag() =
and review usages of atoi_warn<br><br>This uses atoi_constrained=2E Note th=
at this makes the tests<br>stricter since previously any non-zero integer w=
ould be<br>interpreted as &quot;true&quot;=2E<br><br>Change-Id: Ic306129713=
67a4aa54ca89f93452efc172d4f4e2<br>Signed-off-by: Frank Lichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2E=
org&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1151<br>M=
essage-Id: &lt;20261006142321=2E4601-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: =
https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/ms=
g39741=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt=
;<br>---<br>M src/openvpn/options=2Ec<br>M src/openvpn/options_util=2Ec<br>=
M src/openvpn/options_util=2Eh<br>M tests/unit_tests/openvpn/test_misc=2Ec<=
br>4 files changed, 38 insertions(+), 11 deletions(-)<br><br></pre>
<pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>=
index 60c2f5a=2E=2E6664c73 100644</span><br><span>--- a/src/openvpn/options=
=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -6402=
,7 +6402,7 @@</span><br><span>     {</span><br><span>         VERIFY_PERMIS=
SION(OPT_P_GENERAL);</span><br><span>         options-&gt;sc_info=2Echallen=
ge_text =3D p[1];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (atoi_warn(p[2], msglevel))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (boolean_flag(p[2], &quot;static-challenge echo&q=
uot;, msglevel))</span><br><span>         {</span><br><span>             op=
tions-&gt;sc_info=2Eflags |=3D SC_ECHO;</span><br><span>         }</span><b=
r><span>@@ -6777,7 +6777,7 @@</span><br><span>         options-&gt;exit_eve=
nt_name =3D p[1];</span><br><span>         if (p[2])</span><br><span>      =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            optio=
ns-&gt;exit_event_initial_state =3D (atoi_warn(p[2], msglevel) !=3D 0);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            options-&gt=
;exit_event_initial_state =3D boolean_flag(p[2], &quot;service state&quot;,=
 msglevel);</span><br><span>         }</span><br><span>     }</span><br><sp=
an>     else if (streq(p[0], &quot;allow-nonadmin&quot;) &amp;&amp; !p[2])<=
/span><br><span>@@ -7734,7 +7734,8 @@</span><br><span>     else if (streq(p=
[0], &quot;show-pkcs11-ids&quot;) &amp;&amp; !p[3])</span><br><span>     {<=
/span><br><span>         const char *provider =3D p[1];</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        bool cert_private =3D (p[2] =3D=
=3D NULL ? false : (atoi_warn(p[2], msglevel) !=3D 0));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        bool cert_private =3D (p[2] =3D=
=3D NULL ? false</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                       : boolean_flag(p[2], &quot;show-pkcs=
11-ids private&quot;, msglevel));</span><br><span> </span><br><span> #ifdef=
 DEFAULT_PKCS11_MODULE</span><br><span>         if (!provider)</span><br><s=
pan>@@ -7780,14 +7781,12 @@</span><br><span>     }</span><br><span>     els=
e if (streq(p[0], &quot;pkcs11-protected-authentication&quot;))</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        in=
t j;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>=
         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        for (j =3D 1; j &lt; MAX_PAR=
MS &amp;&amp; p[j] !=3D NULL; ++j)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        for (int j =3D 1; j &lt; MAX_PARMS &amp;&amp; p[j] !=
=3D NULL; ++j)</span><br><span>         {</span><br><span>             opti=
ons-&gt;pkcs11_protected_authentication[j - 1] =3D</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                atoi_warn(p[j], msglevel) !=3D=
 0 ? 1 : 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        boolean_flag(p[j], p[0], msglevel);</span><br><span>         }</spa=
n><br><span>     }</span><br><span>     else if (streq(p[0], &quot;pkcs11-p=
rivate-mode&quot;) &amp;&amp; p[1])</span><br><span>@@ -7803,13 +7802,11 @@=
</span><br><span>     }</span><br><span>     else if (streq(p[0], &quot;pkc=
s11-cert-private&quot;))</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        int j;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERA=
L);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        for (j =3D 1; j &lt; MAX_PARMS &amp;&amp; p[j] !=3D NULL; ++j)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int j =3D 1=
; j &lt; MAX_PARMS &amp;&amp; p[j] !=3D NULL; ++j)</span><br><span>        =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            options=
-&gt;pkcs11_cert_private[j - 1] =3D (bool)(atoi_warn(p[j], msglevel));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;=
pkcs11_cert_private[j - 1] =3D boolean_flag(p[j], p[0], msglevel);</span><b=
r><span>         }</span><br><span>     }</span><br><span>     else if (str=
eq(p[0], &quot;pkcs11-pin-cache&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</s=
pan><br><span>diff --git a/src/openvpn/options_util=2Ec b/src/openvpn/optio=
ns_util=2Ec</span><br><span>index 779c38e=2E=2Ed25d85c 100644</span><br><sp=
an>--- a/src/openvpn/options_util=2Ec</span><br><span>+++ b/src/openvpn/opt=
ions_util=2Ec</span><br><span>@@ -194,6 +194,14 @@</span><br><span>     ret=
urn true;</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+boolean_flag(const char *str, const char *name, msglvl_t msglev=
el)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    int number =3D 0;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    atoi_constrained(str, &amp;n=
umber, name, 0, 1, msglevel);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return (bool)number;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> static const char *updatable_options[] =3D { &quot;block-ipv=
6&quot;, &quot;block-outside-dns&quot;,</span><br><span>                   =
                         &quot;dhcp-option&quot;, &quot;dns&quot;,</span><b=
r><span>                                            &quot;ifconfig&quot;, &=
quot;ifconfig-ipv6&quot;,</span><br><span>diff --git a/src/openvpn/options_=
util=2Eh b/src/openvpn/options_util=2Eh</span><br><span>index 1d4ea9b=2E=2E=
5226a6f 100644</span><br><span>--- a/src/openvpn/options_util=2Eh</span><br=
><span>+++ b/src/openvpn/options_util=2Eh</span><br><span>@@ -69,6 +69,12 @=
@</span><br><span>                       msglvl_t msglevel);</span><br><spa=
n> </span><br><span> /**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Converts a str to an boolean if the string can be parsed as either =
0 or 1=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Otherwi=
se print a warning with \p msglevel and return \c false=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+bool boolean_flag(const char *str, const char *name,=
 msglvl_t msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><spa=
n>  * Filter an option line by all pull filters=2E</span><br><span>  *</spa=
n><br><span>  * If a match is found, the line is modified depending on</spa=
n><br><span>diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/uni=
t_tests/openvpn/test_misc=2Ec</span><br><span>index 052dea8=2E=2E8d88943 10=
0644</span><br><span>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span><br=
><span>+++ b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>@@ -441=
,6 +441,22 @@</span><br><span>     assert_string_equal(mock_msg_buf, &quot;=
test: Must be an integer &gt;=3D 1, not 0&quot;);</span><br><span>     asse=
rt_int_equal(parameter, -42);</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* special tests for boolean_flag */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(boolean_f=
lag(&quot;0&quot;, &quot;test&quot;, msglevel));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_true(boolean_flag(&quot;1&quot;, &q=
uot;test&quot;, msglevel));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(m=
ock_msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_false(boolean_flag(&quot;foo77&quot;, &quot;test&quot;, msglevel));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equa=
l(mock_msg_buf, &quot;test: Cannot parse &#39;foo77&#39; as integer&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_msg_buf);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_false(boolean_flag(&qu=
ot;-77&quot;, &quot;test&quot;, msglevel));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;test: M=
ust be an integer between 0 and 1, not -77&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    CLEAR(mock_msg_buf);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_false(boolean_flag(&quot;77&quot;, &quot;test&q=
uot;, msglevel));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_string_equal(mock_msg_buf, &quot;test: Must be an integer between =
0 and 1, not 77&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span>     mock_set_debug_level(saved_log_level);</span><br>=
<span> }</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1151?usp=3Demail">change 1151</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1151?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: Ic30612971367a4aa54ca89f9345=
2efc172d4f4e2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 115=
1 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>

</body></html>
--TYwffOV1eWw=--


--===============1314691048774900691==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1314691048774900691==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1314691048774900691==--

