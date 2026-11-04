Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B052606E822
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Np0jKuWd;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Hkd/C/aA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=T2F9inKx;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ecwV/Cvv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=F6TCN6UWhuyNfKpD5URkxBMWZywA8SiLE3gfztCCp8E=; b=Np0jKuWdX6xZCDn20d0oKUzHz1
	6YjWyK3xWOxvHxmDzs1P9rJVArvMFcxrwDKKla7aNbrbjMn1ssEMWB8tIp3jksovGGD9RL9lA2ILC
	5OrCY7H6E0yjHMc8E9g+jM1aTZH4o1WdcVL01BXudko7C8QnAJOHqgYudEpkv5QGHk0w=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOj96-000000003or-337N;
	Wed, 04 Nov 2026 22:07:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOj93-000000003nS-2Zqo
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 22:07:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UtIjdzicOLdzViDk3Rr3EnTD1KbOMYeFk11XsNkpjJY=; b=Hkd/C/aAgyQgTB7R6ChgxqCgHl
 HnfZOhJ1+Fe8H13JqqVSTq+5bqRAP5K/RqE/jDY6eLB+7DLVbo4peQMdLBU2jtS5LO7gG9XS6rJCU
 /8yeSSvexOg84xRCt/wwS6QgprEBHCc2zno/sx+y07NljcV5BF9/GS6n8geodE87PFkw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UtIjdzicOLdzViDk3Rr3EnTD1KbOMYeFk11XsNkpjJY=; b=T2F9inKxkTUMh3uVYvIaXflswo
 oGDsUZyWPJDtW43YH1fstwsW5PhwQACaXKmMvDwzaZju6NRt2lquDDw1R1jZOnhnP3u53ElQI+Wg8
 0btBBgs4URTuFXraKvHnJNA+lxXbBqqksCIVyOWGU2FoNqe0SwjjZHEFzZjFJLjncnKo=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOj91-000000007x8-40oT for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 22:07:49 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a4dc547987so6632215e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 14:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793830061; x=1794434861; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UtIjdzicOLdzViDk3Rr3EnTD1KbOMYeFk11XsNkpjJY=;
 b=ecwV/CvvG+m0cTwRs8SGHS7+EaGDpVA+a180HpMqpdT82RtLq6piSgLGcNQb9WYaOt
 kLqC+hg/reST7FKXNxMtxnrCTpbUWovS3oUV6994D3FAJfef7n8EsToZ57yMlofSlts0
 2+Z02oCRw4x5RQXjj2hsht+C9IxyREXCVLv+EZv3ml5zjsUhqRwsxgFG0BNwVM+2uCHJ
 U5hDaXnB3RHlHSjWkunB1kUGSKHPejNDKauE2yFpdkjhRtc7COtWopnfVnnB2lxF/7Vh
 mrxWsshNkUarmDx84EZ+dYJXHpis6w0ZyJiIcPpV4xwfG8gHDoElUR3V1D6TI3b8ZP+I
 qmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793830061; x=1794434861;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UtIjdzicOLdzViDk3Rr3EnTD1KbOMYeFk11XsNkpjJY=;
 b=HU5Frq5wSyE5AN9+0ylc+Q38/goUzyaaUer/xdEjFobBfPtgtFjzUH1O/v7ICVJFq2
 Owdm0fEZB9t7uYbHZ3NRWlcuzIoIOscKT+M6vDxQ9jvB6iqRUuZasuMV0PYAJAqbNQFo
 +P9PkCCfrOmJLvq8fZzlj1zmON63w9MWBTegilEjdAJUI1CWlxw+M8UZe3F1VqMNwF9d
 s+0o5UpuYvmYOByDq+MjAWaDVd3yaYBaljsHXWKiUVqI7ZMafZRlioThYR5f4q0m5bSy
 ccvs1jHpuLlWXzGmzQ+Uq16oa71QLtRCVqtPkwdVcxU1lWZwNKC5htmdI9iMHJWjSJ8D
 YJew==
X-Forwarded-Encrypted: i=1;
 AKwUvBwaKNK5y0CsSa5NZIBLYNkHEaFh7mcvnlIibnSYcmLuwulnz0kWIsWkguDvygJnGemQvQ5f2GwJ7L2XcrxK@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+pJvGSVS0mF93KsbrQJGvbgGuCMc+0PcT2nvCdvIMBamVDrbSv
 FR5lYYw7f0qlYa5U57mNi1iMpcdPsU5jjiE7xTsKkDM5GVxrz4dFOIJ6LjkYUzEJdNJZLPBAaWv
 aq/4/fzwN+weUhBtSfe1VWn3PpR5JkE/JQ44yN07sEsTQOQQbbJpsN0lg0M1Lhlouns0v
X-Gm-Gg: AYBFou2BQRwNIGfpgyoPSz7HKanLxUvN1HpgD/aykDkmv1xatfYQOOUhRSM4Ri+yCP5
 GsHWjTDzaJfLEntFFbMxbbxPqcWjYH7wyTAmZqVMc3quTZ8ujJgGyc6dErWv9d938l8swvkVZ/O
 i2JqjsakBkEMo7CGR9X3pfbIB6fy3UfZFpbIMBj97rU+JAa7Vg3N20tMhO1QjWGdhQ5H7vhSLGl
 fdzUn41RbV4bwZ0a7hx/0DDw9xuiOZ8WZDVzIkMypA/RSDSJgkpD621jrvgd2OT643XAY15XDOz
 YtvFwijtEoR/fZada2kCkuRQ2ciyZs36UHgkaHZzvMn3qroae5HOM9/mR0uRiOqy+PKdc0mxVRy
 4U9MlkDGAdj3pgIjhAitsAqFg4REO2rLVS6CMJ5JQxFjQgBvSi61Gv7WRFRpyz4XvZQjeH3LkH8
 XB9KKtm35gr3+xKFbJMEovlt72CGsLlXKh0CV4/1TvCaBUnc3TPqOQpkPBJ6DUlnyaMNhYtiTCt
 qTep9dEYfUcrU964b7oGL6jAW6AOM/aX/8fxXluH5SRVcC36CSfmAP6bJV0xyfoP5hD5f+ytMft
 EUrYjkMFadd1x/WP+KSpq3ob8JoUCqRjM4TEt5aFQYjcG0Xps4+yCzxGvx0aIiZQ9QDNvyKOzJx
 XcJ/UY9eLa1b3BzREOtGU8g5CMYyb73u9kVZ+WxZVv05TYLTLmOJ0ouOda1b4GxW++fd3S7f1O+
 bShcv3h7LkhGi255+1BJbiAleQa+ERL+tlEvg=
X-Received: by 2002:a05:600c:890b:b0:4b3:8529:eb27 with SMTP id
 5b1f17b1804b1-4b38529eb48mr85534845e9.27.1793830061273; 
 Wed, 04 Nov 2026 14:07:41 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56fca22f4sm24969055e9.13.2026.11.04.14.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 14:07:40 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 22:07:40 +0000
To: Selva Nair <selva.nair@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I3c8c62c7d90c2b94dd1cd149b4c13b383a2303e9
X-Gerrit-Change-Number: 2096
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2096?usp=email>
X-Gerrit-Commit: 4333525868d68593bbdb5c4270f21275d6a35466
In-Reply-To: <gerrit.1793666730000.I3c8c62c7d90c2b94dd1cd149b4c13b383a2303e9@gerrit.openvpn.net>
References: <gerrit.1793666730000.I3c8c62c7d90c2b94dd1cd149b4c13b383a2303e9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjY2NzMwMDAwLkkzYzhjNjJjN2Q5MGMyYjk0ZGQxY2QxNDliNGMxM2IzODNhMjMwM2U5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ce94520a0cbc4a220924666cbd0ef5aba381de14-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOj91-000000007x8-40oT
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, selva.nair@gmail.com,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1390769686533958219=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1390769686533958219==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="08ve4rYDxk4="; charset=UTF-8

--08ve4rYDxk4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2096?usp=3Demail )

Change subject: misc: Fix username overflow=
 spilling into password
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

misc: Fix username overflow spilling into password

Consume the =
complete username line before reading the password
from an auth file or inl=
ine credentials=2E This also fixes an
exactly full username buffer leaving =
its newline to be read as
an empty password in auth files=2E

Existing cred=
ential truncation behaviour is unchanged=2E

Tests: Add regression coverage=
 for long and boundary-length
usernames with missing, blank, or supplied pa=
sswords in both
inlined and external file inputs=2E

Github: OpenVPN/openvp=
n#1140
Change-Id: I3c8c62c7d90c2b94dd1cd149b4c13b383a2303e9
Signed-off-by: =
Selva Nair <selva=2Enair@gmail=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2096
Me=
ssage-Id: <20261103081357=2E8587-1-gert@greenie=2Emuc=2Ede>
URL: https://ww=
w=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40555=2Eh=
tml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn=
/misc=2Ec
M tests/unit_tests/openvpn/test_user_pass=2Ec
2 files changed, 65=
 insertions(+), 0 deletions(-)




diff --git a/src/openvpn/misc=2Ec b/src/=
openvpn/misc=2Ec
index 304a87e=2E=2E8c9ad08 100644
--- a/src/openvpn/misc=
=2Ec
+++ b/src/openvpn/misc=2Ec
@@ -250,6 +250,10 @@
                 if (!=
(flags & GET_USER_PASS_PASSWORD_ONLY))
                 {
                 =
    buf_parse(&buf, '\n', up->username, USER_PASS_LEN);
+                  =
  /* The password starts on the next line, even if the username was truncat=
ed=2E */
+                    const char *password =3D strchr(auth_file, '\=
n');
+                    password =3D password ? password + 1 : "";
+     =
               buf_set_read(&buf, (uint8_t *)password, strlen(password) + 1=
);
                 }
                 buf_parse(&buf, '\n', up->password, =
USER_PASS_LEN);
 
@@ -283,6 +287,14 @@
                         msg(M_FATAL=
, "Error reading username from %s authfile: %s", prefix,
                  =
           auth_file);
                     }
+                    if (!str=
chr(up->username, '\n'))
+                    {
+                        /*=
 Consume the rest of the username line before reading the password=2E */
+ =
                       int c;
+                        while ((c =3D fgetc(=
fp)) !=3D '\n' && c !=3D EOF)
+                        {
+                 =
       }
+                    }
                 }
                 chomp(u=
p->username);
 
diff --git a/tests/unit_tests/openvpn/test_user_pass=2Ec b/=
tests/unit_tests/openvpn/test_user_pass=2Ec
index adcf74a=2E=2E776a86a 1006=
44
--- a/tests/unit_tests/openvpn/test_user_pass=2Ec
+++ b/tests/unit_tests=
/openvpn/test_user_pass=2Ec
@@ -366,6 +366,58 @@
     assert_string_equal(u=
p=2Epassword, "fuser");
 }
 
+static void
+test_get_user_pass_long_username=
(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    const char *au=
thfile =3D platform_create_temp_file(platform_get_tmp_dir(), "user_pass", &=
gc);
+    assert_non_null(authfile);
+    const size_t lengths[] =3D { USER=
_PASS_LEN - 2, USER_PASS_LEN - 1, USER_PASS_LEN + 10 };
+    const char *en=
dings[] =3D { "", "\n", "\n\n", "\nfpassword\n", "\r\nfpassword\r\n" };
+
+=
    const bool inline_mode[] =3D { false, true };
+    for (size_t mode =3D=
 0; mode < SIZE(inline_mode); mode++)
+    {
+        const bool use_inline=
_creds =3D inline_mode[mode];
+        for (size_t i =3D 0; i < SIZE(length=
s); i++)
+        {
+            for (size_t j =3D 0; j < SIZE(endings); j+=
+)
+            {
+                struct user_pass up =3D { 0 };
+        =
        char creds[USER_PASS_LEN + 64];
+                memset(creds, 'u',=
 lengths[i]);
+                strcpy(creds + lengths[i], endings[j]);
+   =
             if (!use_inline_creds)
+                {
+                   =
 FILE *fp =3D platform_fopen(authfile, "w");
+                    assert_no=
n_null(fp);
+                    assert_true(fputs(creds, fp) >=3D 0);
+   =
                 assert_int_equal(fclose(fp), 0);
+                }
+
+   =
             const bool missing_password =3D j < 3;
+                if (mi=
ssing_password)
+                {
+                    expect_string(query=
_user_exec_builtin, query_user[i]=2Eprompt,
+                              =
    "Enter UT Password:");
+                    will_return(query_user_exec=
_builtin, "cpassword");
+                }
+                will_return(que=
ry_user_exec_builtin, true);
+                assert_true(get_user_pass_cr(=
&up, use_inline_creds ? creds : authfile, "UT",
+                          =
                   use_inline_creds ? GET_USER_PASS_INLINE_CREDS : 0, NULL)=
);
+                /* Truncation must not change where the password line s=
tarts=2E */
+                creds[lengths[i] < USER_PASS_LEN ? lengths[i] =
: USER_PASS_LEN - 1] =3D '\0';
+                assert_true(up=2Edefined);
=
+                assert_string_equal(up=2Eusername, creds);
+              =
  assert_string_equal(up=2Epassword,
+                                    m=
issing_password ? "cpassword" : "fpassword");
+            }
+        }
+  =
  }
+    assert_true(platform_unlink(authfile));
+    gc_free(&gc);
+}
+
 #=
ifdef ENABLE_MANAGEMENT
 static void
 test_get_user_pass_dynamic_challenge(=
void **state)
@@ -474,6 +526,7 @@
     cmocka_unit_test(test_get_user_pass_=
inline_creds),
     cmocka_unit_test(test_get_user_pass_authfile_stdin),
  =
   cmocka_unit_test(test_get_user_pass_authfile_file),
+    cmocka_unit_tes=
t(test_get_user_pass_long_username),
 #ifdef ENABLE_MANAGEMENT
     cmocka_=
unit_test(test_get_user_pass_dynamic_challenge),
     cmocka_unit_test(test=
_get_user_pass_static_challenge),

-- 
To view, visit https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2096?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerr=
it-Change-Id: I3c8c62c7d90c2b94dd1cd149b4c13b383a2303e9
Gerrit-Change-Numbe=
r: 2096
Gerrit-PatchSet: 3
Gerrit-Owner: Selva Nair <selva=2Enair@gmail=2Ec=
om>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revie=
wer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>

--08ve4rYDxk4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2096?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">misc: Fix username overflow spilli=
ng into password<br><br>Consume the complete username line before reading t=
he password<br>from an auth file or inline credentials=2E This also fixes a=
n<br>exactly full username buffer leaving its newline to be read as<br>an e=
mpty password in auth files=2E<br><br>Existing credential truncation behavi=
our is unchanged=2E<br><br>Tests: Add regression coverage for long and boun=
dary-length<br>usernames with missing, blank, or supplied passwords in both=
<br>inlined and external file inputs=2E<br><br>Github: OpenVPN/openvpn#1140=
<br>Change-Id: I3c8c62c7d90c2b94dd1cd149b4c13b383a2303e9<br>Signed-off-by: =
Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2096<br>Message-Id: &lt;20261103081357=2E8587-1-gert@greenie=2Em=
uc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2E=
sourceforge=2Enet/msg40555=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@g=
reenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/misc=2Ec<br>M tests/unit_test=
s/openvpn/test_user_pass=2Ec<br>2 files changed, 65 insertions(+), 0 deleti=
ons(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/src/openvpn/misc=2Ec b/src/openvpn/mis=
c=2Ec</span><br><span>index 304a87e=2E=2E8c9ad08 100644</span><br><span>---=
 a/src/openvpn/misc=2Ec</span><br><span>+++ b/src/openvpn/misc=2Ec</span><b=
r><span>@@ -250,6 +250,10 @@</span><br><span>                 if (!(flags &=
amp; GET_USER_PASS_PASSWORD_ONLY))</span><br><span>                 {</span=
><br><span>                     buf_parse(&amp;buf, &#39;\n&#39;, up-&gt;us=
ername, USER_PASS_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    /* The password starts on the next line, even if th=
e username was truncated=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                    const char *password =3D strchr(auth_file, &=
#39;\n&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              password =3D password ? password + 1 : &quot;&quot;;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    buf_set_=
read(&amp;buf, (uint8_t *)password, strlen(password) + 1);</span><br><span>=
                 }</span><br><span>                 buf_parse(&amp;buf, &#3=
9;\n&#39;, up-&gt;password, USER_PASS_LEN);</span><br><span> </span><br><sp=
an>@@ -283,6 +287,14 @@</span><br><span>                         msg(M_FATA=
L, &quot;Error reading username from %s authfile: %s&quot;, prefix,</span><=
br><span>                             auth_file);</span><br><span>         =
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              if (!strchr(up-&gt;username, &#39;\n&#39;))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                        /* Consume =
the rest of the username line before reading the password=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        int c;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
    while ((c =3D fgetc(fp)) !=3D &#39;\n&#39; &amp;&amp; c !=3D EOF)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       }</span><br><span>                 }</span><br><span>               =
  chomp(up-&gt;username);</span><br><span> </span><br><span>diff --git a/te=
sts/unit_tests/openvpn/test_user_pass=2Ec b/tests/unit_tests/openvpn/test_u=
ser_pass=2Ec</span><br><span>index adcf74a=2E=2E776a86a 100644</span><br><s=
pan>--- a/tests/unit_tests/openvpn/test_user_pass=2Ec</span><br><span>+++ b=
/tests/unit_tests/openvpn/test_user_pass=2Ec</span><br><span>@@ -366,6 +366=
,58 @@</span><br><span>     assert_string_equal(up=2Epassword, &quot;fuser&=
quot;);</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+test_get_user_pass_long_username(void **state)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const char *authfile =3D pla=
tform_create_temp_file(platform_get_tmp_dir(), &quot;user_pass&quot;, &amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_non_=
null(authfile);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const size_t lengths[] =3D { USER_PASS_LEN - 2, USER_PASS_LEN - 1, USER_PAS=
S_LEN + 10 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst char *endings[] =3D { &quot;&quot;, &quot;\n&quot;, &quot;\n\n&quot;, &=
quot;\nfpassword\n&quot;, &quot;\r\nfpassword\r\n&quot; };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const bool inline_mode[] =3D { false, true };</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t mode =3D =
0; mode &lt; SIZE(inline_mode); mode++)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        const bool use_inline_creds =3D inline_mode[mode];</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        for (size_t i =3D 0; i=
 &lt; SIZE(lengths); i++)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        for (size_t j =3D 0; j &lt; SIZE(endings); j++)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                struct user_pass up =3D { 0 }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ch=
ar creds[USER_PASS_LEN + 64];</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                memset(creds, &#39;u&#39;, lengths[i]);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                strcpy(creds =
+ lengths[i], endings[j]);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                if (!use_inline_creds)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                    FILE *fp =3D platform_fopen(aut=
hfile, &quot;w&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    assert_non_null(fp);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                    assert_true(fputs(creds, fp) &g=
t;=3D 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
          assert_int_equal(fclose(fp), 0);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                const bool missing_password =3D j &lt; 3;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                if (missing_passwor=
d)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 expect_string(query_user_exec_builtin, query_user[i]=2Eprompt,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
   &quot;Enter UT Password:&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    will_return(query_user_exec_builtin, &q=
uot;cpassword&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                will_return(query_user_exec_builtin, true);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                assert_true(get_use=
r_pass_cr(&amp;up, use_inline_creds ? creds : authfile, &quot;UT&quot;,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
                      use_inline_creds ? GET_USER_PASS_INLINE_CREDS : 0, NU=
LL));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  /* Truncation must not change where the password line starts=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                creds[leng=
ths[i] &lt; USER_PASS_LEN ? lengths[i] : USER_PASS_LEN - 1] =3D &#39;\0&#39=
;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                a=
ssert_true(up=2Edefined);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                assert_string_equal(up=2Eusername, creds);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                assert_string_=
equal(up=2Epassword,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                    missing_password ? &quot;cpassword&quo=
t; : &quot;fpassword&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(platf=
orm_unlink(authfile));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> #ifdef ENABLE_MANAGEMENT</span><br><span> static void</span><br><span>=
 test_get_user_pass_dynamic_challenge(void **state)</span><br><span>@@ -474=
,6 +526,7 @@</span><br><span>     cmocka_unit_test(test_get_user_pass_inlin=
e_creds),</span><br><span>     cmocka_unit_test(test_get_user_pass_authfile=
_stdin),</span><br><span>     cmocka_unit_test(test_get_user_pass_authfile_=
file),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_un=
it_test(test_get_user_pass_long_username),</span><br><span> #ifdef ENABLE_M=
ANAGEMENT</span><br><span>     cmocka_unit_test(test_get_user_pass_dynamic_=
challenge),</span><br><span>     cmocka_unit_test(test_get_user_pass_static=
_challenge),</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2096?usp=3Demail">change 2096</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2096?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I3c8c62c7d90c2b94dd1cd1=
49b4c13b383a2303e9 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 2096 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: Selva Nair &lt;selva=2Enair@gmail=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>

</body></html>
--08ve4rYDxk4=--


--===============1390769686533958219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1390769686533958219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1390769686533958219==--

