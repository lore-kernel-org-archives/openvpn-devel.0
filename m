Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE6C606A324
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 00:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hCmUeSMP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iom3srek;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Amsn1j8k;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=C4e0a4ju
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=I99u4Lkyws9/6o7PenMvHuZrREnSWIncDU1VWv04jus=; b=hCmUeSMPB/Lofuf2K3uecyGwRc
	qyprpYOZPusatY969YsR9/Jlf3uF085PYRjEHEJZsOfK6ffFKpEtSuds+12DM4rs4V9dFfKyWwJUh
	n4ZqKjUtdmwSbWelKOSZF/Yv3oJF0BL9ByENQ1oGTFFfehr9tay/66VmvqhQjuu3qLAo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xO2em-000000004jm-1x4X;
	Tue, 03 Nov 2026 00:45:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xO2ek-000000004jf-3cIB
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 00:45:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1uOHOcomYPuW/tW9YE/Jz2Y+NFvU9AA77BAlUdpZNpA=; b=iom3srekylR1e4Q8romUYegTuh
 Q5GNzKLkl+TqpVT57RnddACZqeyvKPR7usB/f88nWMTlxquJFAM2u2WrXCJXq3EO31N4t96Z+leEe
 nSdrsTVWbGmJG3uvClnrmI5kplaPK5O86mGoew5PAXd8P1qq9Tcy8zAUSNEX6rafrB9g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1uOHOcomYPuW/tW9YE/Jz2Y+NFvU9AA77BAlUdpZNpA=; b=Amsn1j8khpRa3+LJDyzY99eghY
 lO2JX+MFg4cRZmYkXWI+NVISIZakbBWtc1xgZeRPtRt/T4dzMxwLPYo5iU+4hdHsJkgmItNcQ7R4z
 rv8EPwk787qgYnLJiQMSXL5/1/aN3OAPPRq99vi/qte0ViTdI9VT1Q5FLDrMBkTc3By4=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xO2ei-000000002FT-3sic for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 00:45:42 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso1712444f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 16:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793666734; x=1794271534; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1uOHOcomYPuW/tW9YE/Jz2Y+NFvU9AA77BAlUdpZNpA=;
 b=C4e0a4juxBUiiAe1Ux/cSkXfQnkSVpZBLsJvD07H/jXGECoM6wXARLYl0/y27njDHU
 RmUCBWeR9+IPLOis1H4kD4MFnDz/d3MtTVPEDR/tLQgzUfAxGpkc/y9qSVcx4cl4CJv9
 oqkCb/2sa1TXK3vFuwKQH4JwVqIvJeHHeWkE4F2u54kq0pWuUGVUNsHGuyFw6McmqdcO
 jYtQfTG/YukF4p0lKmJu/ED4YMkO/7l34fJ2M/4czTZt8EEgFsEOhoWMZ/FpGENKIB0d
 ry8k+ksKPbipbPVB5dlEf3JESjk/UQAXLkZt8cvlLZtRuZn0aAB4LkUd7l5hwQORKms2
 LCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793666734; x=1794271534;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1uOHOcomYPuW/tW9YE/Jz2Y+NFvU9AA77BAlUdpZNpA=;
 b=H+gLZnbLIyO4u1/zwpwcEwGy+VWuaYkqmxyMvRfr7rTEPG9wtwym4PqnqCgHmUZ+jz
 ibeRHRkyvv6T/ejH1OvmkFrezZAohyU0xft8lHN+chkCV9wAwuBU2/Mcby4FizyEUs2z
 QiA0MCmXGATBlVEPXGmocS1YEjqDlthlrfHrIkHQ2vQZs50bYLYKQUBsnpfUjNyDbOjV
 1GsN02qmE7Fx/NE0Btiw5TUIJWle3S9srg4398bKvF1qHhxhf9sccKkMq9lKhy+9sJUZ
 C2aAiNAkVgwIwg7epn4wr9HfYL79htOxUWF3B7jDfMz59W9jLJUQv3Vqel9wrTJV8Kw+
 yHog==
X-Gm-Message-State: APuU4Z9figkJDl40DWph9MZLm6RaxreWfMm6yk23NzqIxAywxNAwzvp9
 cNe90ghEakxlHP1Q74pYndTD0Pa/LPJxyreWNOYsfvEehmXs4ET3AIGgPva1wYIj0CYbRMtdfE8
 rMArJR2TFbiRkGxXXTrWxIFaOIC6mpigAooLFCqig8DcuZ689f1/vTgvsQx/dgLTsosHbRFof1P
 ymHb/I3g==
X-Gm-Gg: AYBFou36ms4MPIg3Cn4d6nG0csTnBzH2n00ZF63D4lHAJL0qNXyCiXVSYoNfw0hZe2H
 M+1/sJo6dSpnDZf9dw7WBaSaLF6ZovgXSYQ6wBzkSANCFzDnl/00B2Nn/7GuZmSnStiuxJuHeNR
 GTFh+MqthRJSiVkNPy2ld6BPveZBosBVmtmez/Yd/urp6flrUscjCtD02zQhUBi5SxR5Y0XHwSF
 Rf11ZHbzovM09GSwLdeba8s8AgzJCQV42AkyIna9w0aFrGNTAwlueF57bl/GcuHf0+N3UsqiP2o
 bR1O7iYp+uochTMBhZCTnZoegRSjph3Mv6uaCDv7DrObHkEHWz90FMZ9jaWSeprJdgzoNdXmemL
 4Hj70SgkcDWRhKaBmSwKmvKI1Fh5JYILQDPfSXijbLvROHkgHFdZXqhJl5vEUjrwiHTx/Or8/1r
 /mM6NlEMvMXuSM06LOxJnv8Invb/nFTtBFY4xDnR5F89oyd0Gm2QrYisz+XupK3cRkbEodYkYN+
 PgZqBIIzsZFb7mNde1wFu+e8EKWQxyUUqcaOayrdrVf1smPZF16QXTVNwwr8sRmUIOaICpwYNy/
 dtjXZOyPiIPWvajfPt6DdAPDkD7b9Of3/7OcJvylffFR1Scu/bFwJxIicJhfr7y/qmA3AXkJqo/
 KxgK5rvmUG9uXGQ3fzQEq9wnh4GGkb8NSFo9dr/6uvyim8qtF00aTMDfxUUasJynI0ef+ODN2Vq
 7XRm9VlqmDqUhLMOu3jyLJjCDT98Nt773DBDI=
X-Received: by 2002:a05:6000:2282:b0:48d:f14a:9188 with SMTP id
 ffacd0b85a97d-48e73851611mr23938263f8f.17.1793666734164; 
 Mon, 02 Nov 2026 16:45:34 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8a7d1sm22328764f8f.38.2026.11.02.16.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 16:45:33 -0800 (PST)
X-Google-Original-From: "Selva Nair (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 00:45:33 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3c8c62c7d90c2b94dd1cd149b4c13b383a2303e9
X-Gerrit-Change-Number: 2096
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2096?usp=email>
X-Gerrit-Commit: baf53af5d25d63929ac7c75503128b228e5d58a3
References: <gerrit.1793666730000.I3c8c62c7d90c2b94dd1cd149b4c13b383a2303e9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjY2NzMwMDAwLkkzYzhjNjJjN2Q5MGMyYjk0ZGQxY2QxNDliNGMxM2IzODNhMjMwM2U5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <633f0f3465170e57cb3ac1fdf29a7dc36ea99b76-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xO2ei-000000002FT-3sic
Subject: [Openvpn-devel] [M] Change in openvpn[master]: misc: Fix username
 overflow spilling into password
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Selva Nair \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: selva.nair@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Selva Nair \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8264459735953168902=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8264459735953168902==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MqYMGYjH8Oc="; charset=UTF-8

--MqYMGYjH8Oc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2096?usp=3Demail

to review the following change=2E
=


Change subject: misc: Fix username overflow spilling into password
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

misc: Fix username =
overflow spilling into password

Consume the complete username line before =
reading the password
from an auth file or inline credentials=2E This also f=
ixes an
exactly full username buffer leaving its newline to be read as
an e=
mpty password in auth files=2E

Existing credential truncation behaviour is=
 unchanged=2E

Tests: Add regression coverage for long and boundary-length
=
usernames with missing, blank, or supplied passwords in both
inlined and ex=
ternal file inputs=2E

Github: OpenVPN/openvpn#1140
Change-Id: I3c8c62c7d90=
c2b94dd1cd149b4c13b383a2303e9
Signed-off-by: Selva Nair <selva=2Enair@gmail=
=2Ecom>
---
M src/openvpn/misc=2Ec
M tests/unit_tests/openvpn/test_user_pas=
s=2Ec
2 files changed, 65 insertions(+), 0 deletions(-)



  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/96/2096/1

diff --git a/=
src/openvpn/misc=2Ec b/src/openvpn/misc=2Ec
index 304a87e=2E=2E8c9ad08 1006=
44
--- a/src/openvpn/misc=2Ec
+++ b/src/openvpn/misc=2Ec
@@ -250,6 +250,10 =
@@
                 if (!(flags & GET_USER_PASS_PASSWORD_ONLY))
           =
      {
                     buf_parse(&buf, '\n', up->username, USER_PASS_=
LEN);
+                    /* The password starts on the next line, even if=
 the username was truncated=2E */
+                    const char *password=
 =3D strchr(auth_file, '\n');
+                    password =3D password ? =
password + 1 : "";
+                    buf_set_read(&buf, (uint8_t *)passw=
ord, strlen(password) + 1);
                 }
                 buf_parse(&=
buf, '\n', up->password, USER_PASS_LEN);
 
@@ -283,6 +287,14 @@
           =
              msg(M_FATAL, "Error reading username from %s authfile: %s", p=
refix,
                             auth_file);
                     }
+   =
                 if (!strchr(up->username, '\n'))
+                    {
+ =
                       /* Consume the rest of the username line before read=
ing the password=2E */
+                        int c;
+                   =
     while ((c =3D fgetc(fp)) !=3D '\n' && c !=3D EOF)
+                   =
     {
+                        }
+                    }
                 }=

                 chomp(up->username);
 
diff --git a/tests/unit_tests/open=
vpn/test_user_pass=2Ec b/tests/unit_tests/openvpn/test_user_pass=2Ec
index =
adcf74a=2E=2Edf2955c 100644
--- a/tests/unit_tests/openvpn/test_user_pass=
=2Ec
+++ b/tests/unit_tests/openvpn/test_user_pass=2Ec
@@ -366,6 +366,58 @@=

     assert_string_equal(up=2Epassword, "fuser");
 }
 
+static void
+test_=
get_user_pass_long_username(void **state)
+{
+    struct gc_arena gc =3D gc=
_new();
+    const char *authfile =3D platform_create_temp_file(platform_ge=
t_tmp_dir(), "user_pass", &gc);
+    assert_non_null(authfile);
+    const =
size_t lengths[] =3D { USER_PASS_LEN - 2, USER_PASS_LEN - 1, USER_PASS_LEN =
+ 10 };
+    const char *endings[] =3D { "", "\n", "\n\n", "\nfpassword\n",=
 "\r\nfpassword\r\n" };
+
+    const bool inline_mode[] =3D { false, true }=
;
+    for (size_t mode =3D 0; mode < SIZE(inline_mode); mode++)
+    {
+  =
      const bool use_inline_creds =3D inline_mode[mode];
+        for (size=
_t i =3D 0; i < SIZE(lengths); i++)
+        {
+            for (size_t j =
=3D 0; j < SIZE(endings); j++)
+            {
+                struct user_=
pass up =3D { 0 };
+                char creds[USER_PASS_LEN + 64];
+      =
          memset(creds, 'u', lengths[i]);
+                strcpy(creds + l=
engths[i], endings[j]);
+                if (!use_inline_creds)
+          =
      {
+                    FILE *fp =3D platform_fopen(authfile, "w");
+ =
                   assert_non_null(fp);
+                    assert_true(fp=
uts(creds, fp) >=3D 0);
+                    assert_int_equal(fclose(fp), 0=
);
+                }
+
+                const bool missing_password =3D j =
< 3;
+                if (missing_password)
+                {
+           =
         expect_string(query_user_exec_builtin, query_user[i]=2Eprompt,
+  =
                                "Enter UT Password:");
+                   =
 will_return(query_user_exec_builtin, "cpassword");
+                }
+   =
             will_return(query_user_exec_builtin, true);
+                a=
ssert_true(get_user_pass_cr(&up, use_inline_creds ? creds : authfile, "UT",=

+                                             use_inline_creds ? GET_USER_=
PASS_INLINE_CREDS : 0, NULL));
+                /* Truncation must not chan=
ge where the password line starts=2E */
+                creds[MIN(lengths[=
i], USER_PASS_LEN - 1)] =3D '\0';
+                assert_true(up=2Edefined=
);
+                assert_string_equal(up=2Eusername, creds);
+           =
     assert_string_equal(up=2Epassword,
+                                  =
  missing_password ? "cpassword" : "fpassword");
+            }
+        }
=
+    }
+    assert_true(platform_unlink(authfile));
+    gc_free(&gc);
+}
+=

 #ifdef ENABLE_MANAGEMENT
 static void
 test_get_user_pass_dynamic_challen=
ge(void **state)
@@ -474,6 +526,7 @@
     cmocka_unit_test(test_get_user_pa=
ss_inline_creds),
     cmocka_unit_test(test_get_user_pass_authfile_stdin),=

     cmocka_unit_test(test_get_user_pass_authfile_file),
+    cmocka_unit_=
test(test_get_user_pass_long_username),
 #ifdef ENABLE_MANAGEMENT
     cmoc=
ka_unit_test(test_get_user_pass_dynamic_challenge),
     cmocka_unit_test(t=
est_get_user_pass_static_challenge),

-- 
To view, visit https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2096?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: maste=
r
Gerrit-Change-Id: I3c8c62c7d90c2b94dd1cd149b4c13b383a2303e9
Gerrit-Change=
-Number: 2096
Gerrit-PatchSet: 1
Gerrit-Owner: Selva Nair <selva=2Enair@gma=
il=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attenti=
on: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--MqYMGYjH8Oc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Selva Nair would like Arne Sc=
hwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2096?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">misc: Fix username overflow spilling into password<br><br>Consume=
 the complete username line before reading the password<br>from an auth fil=
e or inline credentials=2E This also fixes an<br>exactly full username buff=
er leaving its newline to be read as<br>an empty password in auth files=2E<=
br><br>Existing credential truncation behaviour is unchanged=2E<br><br>Test=
s: Add regression coverage for long and boundary-length<br>usernames with m=
issing, blank, or supplied passwords in both<br>inlined and external file i=
nputs=2E<br><br>Github: OpenVPN/openvpn#1140<br>Change-Id: I3c8c62c7d90c2b9=
4dd1cd149b4c13b383a2303e9<br>Signed-off-by: Selva Nair &lt;selva=2Enair@gma=
il=2Ecom&gt;<br>---<br>M src/openvpn/misc=2Ec<br>M tests/unit_tests/openvpn=
/test_user_pass=2Ec<br>2 files changed, 65 insertions(+), 0 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/96/2096/1</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/misc=2Ec b/src/op=
envpn/misc=2Ec</span><br><span>index 304a87e=2E=2E8c9ad08 100644</span><br>=
<span>--- a/src/openvpn/misc=2Ec</span><br><span>+++ b/src/openvpn/misc=2Ec=
</span><br><span>@@ -250,6 +250,10 @@</span><br><span>                 if (=
!(flags &amp; GET_USER_PASS_PASSWORD_ONLY))</span><br><span>               =
  {</span><br><span>                     buf_parse(&amp;buf, &#39;\n&#39;, =
up-&gt;username, USER_PASS_LEN);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    /* The password starts on the next line, e=
ven if the username was truncated=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    const char *password =3D strchr(aut=
h_file, &#39;\n&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    password =3D password ? password + 1 : &quot;&quot;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 buf_set_read(&amp;buf, (uint8_t *)password, strlen(password) + 1);</span><=
br><span>                 }</span><br><span>                 buf_parse(&amp=
;buf, &#39;\n&#39;, up-&gt;password, USER_PASS_LEN);</span><br><span> </spa=
n><br><span>@@ -283,6 +287,14 @@</span><br><span>                         m=
sg(M_FATAL, &quot;Error reading username from %s authfile: %s&quot;, prefix=
,</span><br><span>                             auth_file);</span><br><span>=
                     }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    if (!strchr(up-&gt;username, &#39;\n&#39;))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                        /*=
 Consume the rest of the username line before reading the password=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
  int c;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
             while ((c =3D fgetc(fp)) !=3D &#39;\n&#39; &amp;&amp; c !=3D E=
OF)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
              }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                }</span><br><span>                 }</span><br><span>      =
           chomp(up-&gt;username);</span><br><span> </span><br><span>diff -=
-git a/tests/unit_tests/openvpn/test_user_pass=2Ec b/tests/unit_tests/openv=
pn/test_user_pass=2Ec</span><br><span>index adcf74a=2E=2Edf2955c 100644</sp=
an><br><span>--- a/tests/unit_tests/openvpn/test_user_pass=2Ec</span><br><s=
pan>+++ b/tests/unit_tests/openvpn/test_user_pass=2Ec</span><br><span>@@ -3=
66,6 +366,58 @@</span><br><span>     assert_string_equal(up=2Epassword, &qu=
ot;fuser&quot;);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_get_user_pass_long_username(void **state)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *authfil=
e =3D platform_create_temp_file(platform_get_tmp_dir(), &quot;user_pass&quo=
t;, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_non_null(authfile);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const size_t lengths[] =3D { USER_PASS_LEN - 2, USER_PASS_LEN - 1,=
 USER_PASS_LEN + 10 };</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const char *endings[] =3D { &quot;&quot;, &quot;\n&quot;, &quot;\n\n=
&quot;, &quot;\nfpassword\n&quot;, &quot;\r\nfpassword\r\n&quot; };</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const bool inline_mode[] =3D { false, true=
 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t =
mode =3D 0; mode &lt; SIZE(inline_mode); mode++)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        const bool use_inline_creds =3D inline_mode[mode];</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (size_t i=
 =3D 0; i &lt; SIZE(lengths); i++)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            for (size_t j =3D 0; j &lt; SIZE(endings); j++)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                struct user_pass up =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       char creds[USER_PASS_LEN + 64];</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                memset(creds, &#39;u&#39;, lengths[i]);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                strc=
py(creds + lengths[i], endings[j]);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                if (!use_inline_creds)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    FILE *fp =3D platform=
_fopen(authfile, &quot;w&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    assert_non_null(fp);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    assert_true(fputs(cre=
ds, fp) &gt;=3D 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    assert_int_equal(fclose(fp), 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                const bool missing_password =3D j &lt; 3;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                if (mi=
ssing_password)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              expect_string(query_user_exec_builtin, query_user[i]=2Eprompt=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
                &quot;Enter UT Password:&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    will_return(query_user_exe=
c_builtin, &quot;cpassword&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                will_return(query_user_exec_builtin, true);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                assert=
_true(get_user_pass_cr(&amp;up, use_inline_creds ? creds : authfile, &quot;=
UT&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                                   use_inline_creds ? GET_USER_PASS_INLINE_=
CREDS : 0, NULL));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               /* Truncation must not change where the password line starts=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   creds[MIN(lengths[i], USER_PASS_LEN - 1)] =3D &#39;\0&#39;;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                assert_true(up=
=2Edefined);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         assert_string_equal(up=2Eusername, creds);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                assert_string_equal(up=2E=
password,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                          missing_password ? &quot;cpassword&quot; : &quot;=
fpassword&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_true(platform_unlink(=
authfile));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_f=
ree(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef=
 ENABLE_MANAGEMENT</span><br><span> static void</span><br><span> test_get_u=
ser_pass_dynamic_challenge(void **state)</span><br><span>@@ -474,6 +526,7 @=
@</span><br><span>     cmocka_unit_test(test_get_user_pass_inline_creds),</=
span><br><span>     cmocka_unit_test(test_get_user_pass_authfile_stdin),</s=
pan><br><span>     cmocka_unit_test(test_get_user_pass_authfile_file),</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(tes=
t_get_user_pass_long_username),</span><br><span> #ifdef ENABLE_MANAGEMENT</=
span><br><span>     cmocka_unit_test(test_get_user_pass_dynamic_challenge),=
</span><br><span>     cmocka_unit_test(test_get_user_pass_static_challenge)=
,</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2096?usp=3Demail">change 2096</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2096?usp=3Demail"/><meta itemprop=3D"name" co=
ntent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Me=
ssageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: op=
envpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div=
 style=3D"display:none"> Gerrit-Change-Id: I3c8c62c7d90c2b94dd1cd149b4c13b3=
83a2303e9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2096 </=
div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"d=
isplay:none"> Gerrit-Owner: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--MqYMGYjH8Oc=--


--===============8264459735953168902==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8264459735953168902==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8264459735953168902==--

