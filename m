Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E156606A326
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 01:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Ug84t4/o;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Kr2CUd7e;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jAoMapsY;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NnikUhvk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VHDsttGp3PbzCr3JRx/ejyRckapZ05Xb98DDa9sAxDY=; b=Ug84t4/o/oRMrfqKXgxkGY9++b
	CqPt4LVPLEwZC0Y/qr5/DbHpza473+dKRvnt92S8TqQOazQGopgg8+Drlaxk84S/R7HVQW73jd5C2
	n2QPpjA1hDrbGAzrY2K7uKSyLnHnNZ4CQXI9uAG9QCbxLJQVYVQByssHyyOZufWYouV8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xO2wU-000000005Cj-1BrA;
	Tue, 03 Nov 2026 01:04:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xO2wS-000000005CS-483u
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 01:04:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z/CHvjSOrqILjuq5RwwDuzEuMbkb9nJcD8/iw70LdMk=; b=Kr2CUd7eY9FFDDEMgPzzVrpw67
 Vv3HrozYrfi/7i5IQJCCoFKon4t0l88P+M6DGcSw5sI7DZEQ6es13FzL8T7lS9DAy0rdct4hUs1DO
 ugRREd39VnA8qXZsd3z32ZoG4Wv4HSCsr85oZ5idiBkw6raKSRsNCyaqTBRfmCl7Maa0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z/CHvjSOrqILjuq5RwwDuzEuMbkb9nJcD8/iw70LdMk=; b=jAoMapsYpjpdQ1vewpll+OCTsf
 cJWmW05I7OymwXoE7j1FR55Ydz6elDNKJdiS+95jnAdxsSFeGV60otVgdL8fdB+VNxqc5SVhLZo6w
 ilIzQebmkZiU8MGoXDNfuwQfdIjQiZybyqqEfGv/42OqsCsMFDfg+BaOenKZAfVCKkr8=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xO2wQ-000000002hd-0jDg for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 01:04:00 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so31742515e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 17:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793667831; x=1794272631; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=z/CHvjSOrqILjuq5RwwDuzEuMbkb9nJcD8/iw70LdMk=;
 b=NnikUhvkiPHBlwBkzwIQZlIkUqAll4d0CkX+BkJyH8hdncba/8mdRCSLXd7DAWwApQ
 JCFWJTdjYMm10DgngJjFl5Q9eWlnJtAcLZRibsM+op0/qhWWyFx4XpPatxi2DeZ9sMkb
 spOCOUr5NRVTsdqkA6bbDx+cmRpB7LAfRNtam8E1yvBrb88DCZDITfVM2OpNozaniL81
 tCdTM/WKrBj6gKWvv/FY8+LdpOWSTNVCEdu1I/gWZcVNSAH13wrACmhjwyZSRK35o2jS
 9xMn+0tRv4seTcvIL9BEAT0rbpkryZumBTNWwjaTnAg9+k3toUoDws8CnUY6aEUGQwsq
 TpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793667831; x=1794272631;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=z/CHvjSOrqILjuq5RwwDuzEuMbkb9nJcD8/iw70LdMk=;
 b=OAxG73dem79I+ZUWooPeV+3mjLxqAW82WFTGq3kjahh9G+tygp6yvFhBP5t2OVYk1D
 pNy9cdaS2CQiTk/R13Giq3i+40bmhyw/mhfLEu6293rJ1KHsUl0EvaCNLaZ5svcu0I9A
 /10FafaGVjeVudafEg9vv39wXWvmaZ2J9378Q0gnRpfe4oGNrwO3lEgZ1iUs5JSUiLfj
 Wy4zuBo4kfcpmi29ft/bgJJdml2ZBgIg0IVFW7E51VZJ5bmImmwgccA+pFVQPAlo29oM
 FP0fVTZsQqPlJhfbYoYcRdYSPelkegGJJGxg3pbctQEw1oRREcGnlaC2lInrmJZGaZRX
 alpQ==
X-Gm-Message-State: AFq9FYJEavRSAQGm2JWxQYPuVjTPCPezLN+Xhrotl9SEfwLiCSA9iakx
 /C1iJk0hVR5lbO2pPNcIJUWLvnHioPBvEkY4i9x3hwayIcfszwM8jY0d/puVUR7+TferHDW89wC
 uqGDzQLlZCTPW2vOY9PwDWHumMv9NtUgYApVUtSoJ/xHEEifKD6fMee4sKEZ7qhi06ZfVoHWjlf
 d4NDo0vA==
X-Gm-Gg: AYBFou0OCraX0hsrczI0aLdbs1pNv8LlN6dn+g2v8XXVjKcHOZxY+MdpzY5/qYa8oug
 as0dO99XkX4pq6GQxtU2AdR/ZV1ncVwLHhCUjYVqGywcnh6xf/OiAy6exklmiOfyPxYYQBESYgN
 US+yu7GWg6lVHne2Ss+xDiX45Xs2AL0bMmaGQkP64O6x0v4TEh707zulxIQAZtPbUBXSw5zYl8m
 e5cwfLs9RpuMI/PzXMN0whfOPjeA9FIhzTsK6XnSTOyxCXZi5FzwLtSN2znsoTZRV5XIbuKTwQb
 TiK3c0sdyrTXTeRYKYKdYVFBmMcOPO1VjbhT5OyYIOCQN9BVZOm4RV+OGXr3mvhPIUMDzs0KFLD
 NFeho15H6rJJBU3g9LQyLt2MkIAwndLNsFauV3Gcne0IxoRFHmJ6c+8wPyyJFKNu6FhsFMTt/xv
 w+efU25vJPXgqYpPwzQlrSWRUp6PxssqYni3dGqHq6b0cLPKYYKUTG6fp8CgAWDajLSFdxEEEAu
 LydLHPJKyhVQHTQ2aQ27s+OnZGpYpT+h/5YWFimMDYlGmPEG0y/uc7SvHveqDa1K5sbVAXp113q
 jQXSyi0qDU4kMZTMfzskdKuB6uRCddS/F05QCrBRHShepfT9NzRnyka0HnQvksASZHQ7Q5fj3GV
 rgJLaJhiv0jfrATKbSM5Y9s0enJ8usfyPooPHue6qCv5YkGbk0FkLaeTu0R6uBuDkoZiuLELPtC
 kzmrn7ihDnrgD2Wg==
X-Received: by 2002:a05:600c:8b04:b0:4a1:db17:c7e6 with SMTP id
 5b1f17b1804b1-4ac150b2044mr260064725e9.2.1793667831475; 
 Mon, 02 Nov 2026 17:03:51 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80ecbsm22979268f8f.35.2026.11.02.17.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 17:03:51 -0800 (PST)
X-Google-Original-From: "Selva Nair (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 01:03:49 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3c8c62c7d90c2b94dd1cd149b4c13b383a2303e9
X-Gerrit-Change-Number: 2096
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2096?usp=email>
X-Gerrit-Commit: eb4fd0629a34094437f4e3d3f0d0816fa9649114
In-Reply-To: <gerrit.1793666730000.I3c8c62c7d90c2b94dd1cd149b4c13b383a2303e9@gerrit.openvpn.net>
References: <gerrit.1793666730000.I3c8c62c7d90c2b94dd1cd149b4c13b383a2303e9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjY2NzMwMDAwLkkzYzhjNjJjN2Q5MGMyYjk0ZGQxY2QxNDliNGMxM2IzODNhMjMwM2U5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f93d7219950e5caef171db6488266d61739d1fee-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xO2wQ-000000002hd-0jDg
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
Content-Type: multipart/mixed; boundary="===============5599954756897729961=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5599954756897729961==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RQWbD32QbD4="; charset=UTF-8

--RQWbD32QbD4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2096?usp=3Demail

to look at the new patch set (#=
2)=2E


Change subject: misc: Fix username overflow spilling into password
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

misc: Fix use=
rname overflow spilling into password

Consume the complete username line b=
efore reading the password
from an auth file or inline credentials=2E This =
also fixes an
exactly full username buffer leaving its newline to be read a=
s
an empty password in auth files=2E

Existing credential truncation behavi=
our is unchanged=2E

Tests: Add regression coverage for long and boundary-l=
ength
usernames with missing, blank, or supplied passwords in both
inlined =
and external file inputs=2E

Github: OpenVPN/openvpn#1140
Change-Id: I3c8c6=
2c7d90c2b94dd1cd149b4c13b383a2303e9
Signed-off-by: Selva Nair <selva=2Enair=
@gmail=2Ecom>
---
M src/openvpn/misc=2Ec
M tests/unit_tests/openvpn/test_us=
er_pass=2Ec
2 files changed, 65 insertions(+), 0 deletions(-)


  git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/96/2096/2

diff --g=
it a/src/openvpn/misc=2Ec b/src/openvpn/misc=2Ec
index 304a87e=2E=2E8c9ad08=
 100644
--- a/src/openvpn/misc=2Ec
+++ b/src/openvpn/misc=2Ec
@@ -250,6 +25=
0,10 @@
                 if (!(flags & GET_USER_PASS_PASSWORD_ONLY))
      =
           {
                     buf_parse(&buf, '\n', up->username, USER_=
PASS_LEN);
+                    /* The password starts on the next line, ev=
en if the username was truncated=2E */
+                    const char *pas=
sword =3D strchr(auth_file, '\n');
+                    password =3D passwo=
rd ? password + 1 : "";
+                    buf_set_read(&buf, (uint8_t *)=
password, strlen(password) + 1);
                 }
                 buf_pa=
rse(&buf, '\n', up->password, USER_PASS_LEN);
 
@@ -283,6 +287,14 @@
      =
                   msg(M_FATAL, "Error reading username from %s authfile: %=
s", prefix,
                             auth_file);
                     }=

+                    if (!strchr(up->username, '\n'))
+                   =
 {
+                        /* Consume the rest of the username line before=
 reading the password=2E */
+                        int c;
+              =
          while ((c =3D fgetc(fp)) !=3D '\n' && c !=3D EOF)
+              =
          {
+                        }
+                    }
             =
    }
                 chomp(up->username);
 
diff --git a/tests/unit_tests=
/openvpn/test_user_pass=2Ec b/tests/unit_tests/openvpn/test_user_pass=2Ec
i=
ndex adcf74a=2E=2E776a86a 100644
--- a/tests/unit_tests/openvpn/test_user_p=
ass=2Ec
+++ b/tests/unit_tests/openvpn/test_user_pass=2Ec
@@ -366,6 +366,58=
 @@
     assert_string_equal(up=2Epassword, "fuser");
 }
 
+static void
+te=
st_get_user_pass_long_username(void **state)
+{
+    struct gc_arena gc =3D=
 gc_new();
+    const char *authfile =3D platform_create_temp_file(platform=
_get_tmp_dir(), "user_pass", &gc);
+    assert_non_null(authfile);
+    con=
st size_t lengths[] =3D { USER_PASS_LEN - 2, USER_PASS_LEN - 1, USER_PASS_L=
EN + 10 };
+    const char *endings[] =3D { "", "\n", "\n\n", "\nfpassword\=
n", "\r\nfpassword\r\n" };
+
+    const bool inline_mode[] =3D { false, tru=
e };
+    for (size_t mode =3D 0; mode < SIZE(inline_mode); mode++)
+    {
=
+        const bool use_inline_creds =3D inline_mode[mode];
+        for (s=
ize_t i =3D 0; i < SIZE(lengths); i++)
+        {
+            for (size_t =
j =3D 0; j < SIZE(endings); j++)
+            {
+                struct use=
r_pass up =3D { 0 };
+                char creds[USER_PASS_LEN + 64];
+    =
            memset(creds, 'u', lengths[i]);
+                strcpy(creds +=
 lengths[i], endings[j]);
+                if (!use_inline_creds)
+        =
        {
+                    FILE *fp =3D platform_fopen(authfile, "w");
=
+                    assert_non_null(fp);
+                    assert_true(=
fputs(creds, fp) >=3D 0);
+                    assert_int_equal(fclose(fp),=
 0);
+                }
+
+                const bool missing_password =3D =
j < 3;
+                if (missing_password)
+                {
+         =
           expect_string(query_user_exec_builtin, query_user[i]=2Eprompt,
+=
                                  "Enter UT Password:");
+                 =
   will_return(query_user_exec_builtin, "cpassword");
+                }
+ =
               will_return(query_user_exec_builtin, true);
+               =
 assert_true(get_user_pass_cr(&up, use_inline_creds ? creds : authfile, "UT=
",
+                                             use_inline_creds ? GET_USE=
R_PASS_INLINE_CREDS : 0, NULL));
+                /* Truncation must not ch=
ange where the password line starts=2E */
+                creds[lengths[i]=
 < USER_PASS_LEN ? lengths[i] : USER_PASS_LEN - 1] =3D '\0';
+             =
   assert_true(up=2Edefined);
+                assert_string_equal(up=2Euse=
rname, creds);
+                assert_string_equal(up=2Epassword,
+       =
                             missing_password ? "cpassword" : "fpassword");=

+            }
+        }
+    }
+    assert_true(platform_unlink(authfile=
));
+    gc_free(&gc);
+}
+
 #ifdef ENABLE_MANAGEMENT
 static void
 test_ge=
t_user_pass_dynamic_challenge(void **state)
@@ -474,6 +526,7 @@
     cmocka=
_unit_test(test_get_user_pass_inline_creds),
     cmocka_unit_test(test_get=
_user_pass_authfile_stdin),
     cmocka_unit_test(test_get_user_pass_authfi=
le_file),
+    cmocka_unit_test(test_get_user_pass_long_username),
 #ifdef =
ENABLE_MANAGEMENT
     cmocka_unit_test(test_get_user_pass_dynamic_challeng=
e),
     cmocka_unit_test(test_get_user_pass_static_challenge),

-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2096?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3c8c62c7d90c2b94dd1cd149=
b4c13b383a2303e9
Gerrit-Change-Number: 2096
Gerrit-PatchSet: 2
Gerrit-Owner=
: Selva Nair <selva=2Enair@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=


--RQWbD32QbD4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Selva Nair <strong>uploaded p=
atch set #2</strong> to this change=2E</p><p><a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2096?usp=3Demail">View Change</a></p><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
misc: Fix username overflow spilling into password<br><br>Consume the compl=
ete username line before reading the password<br>from an auth file or inlin=
e credentials=2E This also fixes an<br>exactly full username buffer leaving=
 its newline to be read as<br>an empty password in auth files=2E<br><br>Exi=
sting credential truncation behaviour is unchanged=2E<br><br>Tests: Add reg=
ression coverage for long and boundary-length<br>usernames with missing, bl=
ank, or supplied passwords in both<br>inlined and external file inputs=2E<b=
r><br>Github: OpenVPN/openvpn#1140<br>Change-Id: I3c8c62c7d90c2b94dd1cd149b=
4c13b383a2303e9<br>Signed-off-by: Selva Nair &lt;selva=2Enair@gmail=2Ecom&g=
t;<br>---<br>M src/openvpn/misc=2Ec<br>M tests/unit_tests/openvpn/test_user=
_pass=2Ec<br>2 files changed, 65 insertions(+), 0 deletions(-)<br><br></pre=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/96/2096/2</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/src/openvpn/misc=2Ec b/src/openvpn/misc=
=2Ec</span><br><span>index 304a87e=2E=2E8c9ad08 100644</span><br><span>--- =
a/src/openvpn/misc=2Ec</span><br><span>+++ b/src/openvpn/misc=2Ec</span><br=
><span>@@ -250,6 +250,10 @@</span><br><span>                 if (!(flags &a=
mp; GET_USER_PASS_PASSWORD_ONLY))</span><br><span>                 {</span>=
<br><span>                     buf_parse(&amp;buf, &#39;\n&#39;, up-&gt;use=
rname, USER_PASS_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    /* The password starts on the next line, even if the=
 username was truncated=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    const char *password =3D strchr(auth_file, &#=
39;\n&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
             password =3D password ? password + 1 : &quot;&quot;;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    buf_set_r=
ead(&amp;buf, (uint8_t *)password, strlen(password) + 1);</span><br><span> =
                }</span><br><span>                 buf_parse(&amp;buf, &#39=
;\n&#39;, up-&gt;password, USER_PASS_LEN);</span><br><span> </span><br><spa=
n>@@ -283,6 +287,14 @@</span><br><span>                         msg(M_FATAL=
, &quot;Error reading username from %s authfile: %s&quot;, prefix,</span><b=
r><span>                             auth_file);</span><br><span>          =
           }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
             if (!strchr(up-&gt;username, &#39;\n&#39;))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                        /* Consume t=
he rest of the username line before reading the password=2E */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                        int c;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
   while ((c =3D fgetc(fp)) !=3D &#39;\n&#39; &amp;&amp; c !=3D EOF)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
      }</span><br><span>                 }</span><br><span>                =
 chomp(up-&gt;username);</span><br><span> </span><br><span>diff --git a/tes=
ts/unit_tests/openvpn/test_user_pass=2Ec b/tests/unit_tests/openvpn/test_us=
er_pass=2Ec</span><br><span>index adcf74a=2E=2E776a86a 100644</span><br><sp=
an>--- a/tests/unit_tests/openvpn/test_user_pass=2Ec</span><br><span>+++ b/=
tests/unit_tests/openvpn/test_user_pass=2Ec</span><br><span>@@ -366,6 +366,=
58 @@</span><br><span>     assert_string_equal(up=2Epassword, &quot;fuser&q=
uot;);</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+test_get_user_pass_long_username(void **state)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const char *authfile =3D plat=
form_create_temp_file(platform_get_tmp_dir(), &quot;user_pass&quot;, &amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_non_n=
ull(authfile);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst size_t lengths[] =3D { USER_PASS_LEN - 2, USER_PASS_LEN - 1, USER_PASS=
_LEN + 10 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st char *endings[] =3D { &quot;&quot;, &quot;\n&quot;, &quot;\n\n&quot;, &q=
uot;\nfpassword\n&quot;, &quot;\r\nfpassword\r\n&quot; };</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const bool inline_mode[] =3D { false, true };</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t mode =3D 0=
; mode &lt; SIZE(inline_mode); mode++)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        const bool use_inline_creds =3D inline_mode[mode];</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        for (size_t i =3D 0; i =
&lt; SIZE(lengths); i++)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       for (size_t j =3D 0; j &lt; SIZE(endings); j++)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                struct user_pass up =3D { 0 };=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                cha=
r creds[USER_PASS_LEN + 64];</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                memset(creds, &#39;u&#39;, lengths[i]);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                strcpy(creds +=
 lengths[i], endings[j]);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                if (!use_inline_creds)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    FILE *fp =3D platform_fopen(auth=
file, &quot;w&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                    assert_non_null(fp);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    assert_true(fputs(creds, fp) &gt=
;=3D 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         assert_int_equal(fclose(fp), 0);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                const bool missing_password =3D j &lt; 3;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                if (missing_password=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
expect_string(query_user_exec_builtin, query_user[i]=2Eprompt,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
  &quot;Enter UT Password:&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                    will_return(query_user_exec_builtin, &qu=
ot;cpassword&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               will_return(query_user_exec_builtin, true);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                assert_true(get_user=
_pass_cr(&amp;up, use_inline_creds ? creds : authfile, &quot;UT&quot;,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
                     use_inline_creds ? GET_USER_PASS_INLINE_CREDS : 0, NUL=
L));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 /* Truncation must not change where the password line starts=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                creds[lengt=
hs[i] &lt; USER_PASS_LEN ? lengths[i] : USER_PASS_LEN - 1] =3D &#39;\0&#39;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                as=
sert_true(up=2Edefined);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                assert_string_equal(up=2Eusername, creds);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                assert_string_e=
qual(up=2Epassword,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                    missing_password ? &quot;cpassword&quot=
; : &quot;fpassword&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(platfo=
rm_unlink(authfile));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> #ifdef ENABLE_MANAGEMENT</span><br><span> static void</span><br><span> =
test_get_user_pass_dynamic_challenge(void **state)</span><br><span>@@ -474,=
6 +526,7 @@</span><br><span>     cmocka_unit_test(test_get_user_pass_inline=
_creds),</span><br><span>     cmocka_unit_test(test_get_user_pass_authfile_=
stdin),</span><br><span>     cmocka_unit_test(test_get_user_pass_authfile_f=
ile),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_uni=
t_test(test_get_user_pass_long_username),</span><br><span> #ifdef ENABLE_MA=
NAGEMENT</span><br><span>     cmocka_unit_test(test_get_user_pass_dynamic_c=
hallenge),</span><br><span>     cmocka_unit_test(test_get_user_pass_static_=
challenge),</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2096?usp=3Demail">change 2096</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2096?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3c8c62c7d90c2b94d=
d1cd149b4c13b383a2303e9 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2096 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: Selva Nair &lt;selva=2Enair@gmail=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--RQWbD32QbD4=--


--===============5599954756897729961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5599954756897729961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5599954756897729961==--

