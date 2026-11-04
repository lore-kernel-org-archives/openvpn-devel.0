Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6954606D824
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VI86G6vw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ga+YMWqY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ippt00u7;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=OdXQKiAv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UVawtMg2vb8ISfuPG2koxHzIgJcJdKvj8HYiaVREluE=; b=VI86G6vwkEk64czndLyMzWJ5f8
	I7NEmQjjDARE2V4N04riMqz0S6q30g5O0mWi+1c7mxP1IeAjAgFwjJEz0QintoC+WUWCL/tluf5kt
	Z6pp7UTMXf46c6Z0I3d2O7oQFnt8lEY9qLqM1wwkBxZp0N3ZcGVn/ilv4HqmyTSPnFig=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOj94-000000007me-1MVv;
	Wed, 04 Nov 2026 22:07:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOj93-000000007mW-1xaS
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 22:07:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9LqToO85DQjjTzHiVlP0FAZyq9nPcYT6G5mZ23qsGHM=; b=ga+YMWqYyZ/Fzrxgc8DDi6IZxr
 NF5gWL7veA9XztXzvWNHilpKvxX93U+yQpHCisv0hA5RbDWxz3w3CBrf8ECUEX9wBiqTBwupT0CBe
 az4WO24xjIdoyAzj2g6K2dQagHWqdX5zeWe+g1r1gtKWcAu3FRqrc8IcHvkVEl8DBOGQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9LqToO85DQjjTzHiVlP0FAZyq9nPcYT6G5mZ23qsGHM=; b=Ippt00u7ZZd3g3z3cA4Of4Rtbx
 fdsZ9rJdk1ZfD65Wvhb8evsxziXmlSVBkjjGh6zyRmwqPK/4A2HM92JQL2U6JD2yqo03J/LkDFeR8
 QezNulJRbrER0+qhha6Akw2FDvBNN4whcbHaLYqhfh6eDlbhKcXat8rkJSeWVKK7zn8w=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOj91-000000002Ad-19JX for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 22:07:49 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so10054385e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 14:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793830061; x=1794434861; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9LqToO85DQjjTzHiVlP0FAZyq9nPcYT6G5mZ23qsGHM=;
 b=OdXQKiAvly//pQ9cPtUam2u5Mg3fciOqSVIZFKpCfNCXwMVV867a5t2yPCy+Oim8yP
 HOcRoMRanj2Yte6lvNT2Wv1tjpythceYytrbOc5WrSblPKgThAcwVr93G1xJy3/qihmA
 2aiYCkzBvxyQRssDs2/Wm8Z00nm1VTvdGQiuGwHO1QGUSPraaCu8BbsrCFAeF9iM5OB6
 01mRB8jKQNwW943z7t3UigRP7j0QEK3YuA103n4PY2Htigw4PXlW/r5FXPfF0EAAIaqQ
 b6139VIVomsR7zZBdWFGK6n7azdZ96E2xzCliRYqAm7QCEBXpiJvpdW2wtXQpBz/31Uz
 fYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793830061; x=1794434861;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9LqToO85DQjjTzHiVlP0FAZyq9nPcYT6G5mZ23qsGHM=;
 b=13+d6GBk0LouBEahY9WOYIe2b3lDOsuddKkLZ7YwET0WS7qMNV6DcboT4BNzpLdXFL
 TV3VpYoEgOvZAyUwl3eH5AWQCIubWDuO6k4KpaB9ra6EGDllf/0kRQqU4uAc9Cj5qGJ4
 q7vy1IV4QBsrZnv9I8JRjEhJS6iJE5p/Y9UGK9mBNQV03U50qrFUHLXrxQYPBpM5wP8q
 5ip/smPtpI972oIOVZQuaoEgioUS4rsET2KVIM3x/WnG86JTWEvl5ZaKeXAjc3smH03n
 hPjjpvbfwokcsjE2Mjiaa/tImhg2BEQAGzyALcPiqmvnWwvmbq9A2yVi0WxDF4O1gYxN
 fo6Q==
X-Gm-Message-State: APuU4Z+S35/bn2wOTyKCAdYupEMQQDOKSTc/w+cAVKzV7f+a8h0pO1DZ
 I7dw+teOL+NOOeKWaLQnd7TCY1cspeMTw7zDkTTuQ6L4nLxT4aWBgi7WSH/P2bqJ6PdwK20c2wA
 6iD9gSAGlElvDV6xbY+5bNtvYYt6LMfKii765fN4typNjBUUR1kBywdu/8tfd/uij9+oR
X-Gm-Gg: AYBFou2BmUdqwChkTlox7NwDizr1KY5QW1VZBZ+Vo+x0Gt18f++F7AGngP8mSoaEfGI
 LjGG/Da4rwGwbp7rn/n+S4JLJfz7llIwIc72FAppWutZJtgMkNQrln0F86yZwkSYF/wFv8PB6KT
 sM7zyuxiUZfQpe6LNfTugFDIWv27YJ+k6jlC9pZGUCWKW/rOANMMj+mZ+Kq24mqyTG3/0BYgPl7
 BXAqgW7C4vQPggYZ5fKsaZC9UsU4EzvFyOAGHEtKevqU70KTB0BmCDL9wALqdZWt4PYyYhwOBa6
 B/1FYDi6tZC8tmtCrTG/DuutaKZTi+3jyq9Mrh9gFCihEXK5yU9UKpZRlp9rWEC5SWoYV8GilYj
 ShsTVhQr9Ux/hHaiPs1tla7FzUrxPDwpwQgIKh4fItQKiYg4QWSh8Yph+ci5vhaq4MYQZCgitEC
 QisBNjYFFTQbBRhAkeAenlTgPV4A3rtlvZEHluuKiM+0FILWOH/TN4j2kT4n0itCd4CV1hW05E5
 Y1YMyS81aIjP7bazCHpXtjMP8Le2jSXuKpjGeDwZN9/ZLi3rcptbHOElnQE0dF+A39ILJhDdO4K
 kljAha/5UDe/yITt6pn3xPx12CBhZP23ZGjA2g/OIizbibfLk11a09X0ALXlJgX0oylhxe9UnSR
 SivGugIKfuwDXb4XKT5nkZ8HGU3tNKvBFtAzqgW/aUkAuiWwE/jwLQt0mRv8ptz2F3eM7dQYFbR
 68ZLJAsmz888FapQ==
X-Received: by 2002:a05:600c:811a:b0:4a2:1e1:d55 with SMTP id
 5b1f17b1804b1-4ac187a6b30mr379371005e9.28.1793830060408; 
 Wed, 04 Nov 2026 14:07:40 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56f5e59d3sm15188265e9.10.2026.11.04.14.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 14:07:40 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 22:07:38 +0000
To: Selva Nair <selva.nair@gmail.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I3c8c62c7d90c2b94dd1cd149b4c13b383a2303e9
X-Gerrit-Change-Number: 2096
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2096?usp=email>
X-Gerrit-Commit: 4333525868d68593bbdb5c4270f21275d6a35466
In-Reply-To: <gerrit.1793666730000.I3c8c62c7d90c2b94dd1cd149b4c13b383a2303e9@gerrit.openvpn.net>
References: <gerrit.1793666730000.I3c8c62c7d90c2b94dd1cd149b4c13b383a2303e9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjY2NzMwMDAwLkkzYzhjNjJjN2Q5MGMyYjk0ZGQxY2QxNDliNGMxM2IzODNhMjMwM2U5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ce94520a0cbc4a220924666cbd0ef5aba381de14-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOj91-000000002Ad-19JX
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8582149571408819303=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8582149571408819303==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ql6UtFAD4xQ="; charset=UTF-8

--ql6UtFAD4xQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Selva Nair=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2096?usp=
=3Demail )

The following approvals got outdated and were removed:
Code-Rev=
iew+2 by R=C4=83zvan Cojocaru


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


  git pull ssh://gerrit=2Eopenvpn=2Enet:29=
418/openvpn refs/changes/96/2096/3

diff --git a/src/openvpn/misc=2Ec b/src=
/openvpn/misc=2Ec
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
rrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master=

Gerrit-Change-Id: I3c8c62c7d90c2b94dd1cd149b4c13b383a2303e9
Gerrit-Change-=
Number: 2096
Gerrit-PatchSet: 3
Gerrit-Owner: Selva Nair <selva=2Enair@gmai=
l=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>

--ql6UtFAD4xQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Selv=
a Nair=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2096?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">misc:=
 Fix username overflow spilling into password<br><br>Consume the complete u=
sername line before reading the password<br>from an auth file or inline cre=
dentials=2E This also fixes an<br>exactly full username buffer leaving its =
newline to be read as<br>an empty password in auth files=2E<br><br>Existing=
 credential truncation behaviour is unchanged=2E<br><br>Tests: Add regressi=
on coverage for long and boundary-length<br>usernames with missing, blank, =
or supplied passwords in both<br>inlined and external file inputs=2E<br><br=
>Github: OpenVPN/openvpn#1140<br>Change-Id: I3c8c62c7d90c2b94dd1cd149b4c13b=
383a2303e9<br>Signed-off-by: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt;<br=
>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2096<br>Message-Id: &lt;20261103081=
357=2E8587-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40555=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/=
misc=2Ec<br>M tests/unit_tests/openvpn/test_user_pass=2Ec<br>2 files change=
d, 65 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/96/2096/3</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/misc=2Ec b/src/openvpn/misc=2Ec</span><br><span>index =
304a87e=2E=2E8c9ad08 100644</span><br><span>--- a/src/openvpn/misc=2Ec</spa=
n><br><span>+++ b/src/openvpn/misc=2Ec</span><br><span>@@ -250,6 +250,10 @@=
</span><br><span>                 if (!(flags &amp; GET_USER_PASS_PASSWORD_=
ONLY))</span><br><span>                 {</span><br><span>                 =
    buf_parse(&amp;buf, &#39;\n&#39;, up-&gt;username, USER_PASS_LEN);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    /* T=
he password starts on the next line, even if the username was truncated=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   const char *password =3D strchr(auth_file, &#39;\n&#39;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    password =3D p=
assword ? password + 1 : &quot;&quot;;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    buf_set_read(&amp;buf, (uint8_t *)pa=
ssword, strlen(password) + 1);</span><br><span>                 }</span><br=
><span>                 buf_parse(&amp;buf, &#39;\n&#39;, up-&gt;password, =
USER_PASS_LEN);</span><br><span> </span><br><span>@@ -283,6 +287,14 @@</spa=
n><br><span>                         msg(M_FATAL, &quot;Error reading usern=
ame from %s authfile: %s&quot;, prefix,</span><br><span>                   =
          auth_file);</span><br><span>                     }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    if (!strchr(up=
-&gt;username, &#39;\n&#39;))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                        /* Consume the rest of the username lin=
e before reading the password=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                        int c;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                        while ((c =3D fgetc(fp))=
 !=3D &#39;\n&#39; &amp;&amp; c !=3D EOF)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    }</span><br><span>   =
              }</span><br><span>                 chomp(up-&gt;username);</s=
pan><br><span> </span><br><span>diff --git a/tests/unit_tests/openvpn/test_=
user_pass=2Ec b/tests/unit_tests/openvpn/test_user_pass=2Ec</span><br><span=
>index adcf74a=2E=2E776a86a 100644</span><br><span>--- a/tests/unit_tests/o=
penvpn/test_user_pass=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/te=
st_user_pass=2Ec</span><br><span>@@ -366,6 +366,58 @@</span><br><span>     =
assert_string_equal(up=2Epassword, &quot;fuser&quot;);</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_get_us=
er_pass_long_username(void **state)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const char *authfile =3D platform_create_temp_file(platf=
orm_get_tmp_dir(), &quot;user_pass&quot;, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_non_null(authfile);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const size_t lengths[] =3D=
 { USER_PASS_LEN - 2, USER_PASS_LEN - 1, USER_PASS_LEN + 10 };</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const char *endings[] =3D { =
&quot;&quot;, &quot;\n&quot;, &quot;\n\n&quot;, &quot;\nfpassword\n&quot;, =
&quot;\r\nfpassword\r\n&quot; };</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst bool inline_mode[] =3D { false, true };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    for (size_t mode =3D 0; mode &lt; SIZE(inline_m=
ode); mode++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const bool u=
se_inline_creds =3D inline_mode[mode];</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        for (size_t i =3D 0; i &lt; SIZE(lengths); i++)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            for (size_t j =3D =
0; j &lt; SIZE(endings); j++)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                struct user_pass up =3D { 0 };</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                char creds[USER_PASS_LEN + 6=
4];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
memset(creds, &#39;u&#39;, lengths[i]);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                strcpy(creds + lengths[i], endings[j]);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                if =
(!use_inline_creds)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  FILE *fp =3D platform_fopen(authfile, &quot;w&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    ass=
ert_non_null(fp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  assert_true(fputs(creds, fp) &gt;=3D 0);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    assert_int_equal=
(fclose(fp), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                const bo=
ol missing_password =3D j &lt; 3;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                if (missing_password)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    expect_string(query_u=
ser_exec_builtin, query_user[i]=2Eprompt,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                  &quot;Enter UT Pass=
word:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              will_return(query_user_exec_builtin, &quot;cpassword&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                will_r=
eturn(query_user_exec_builtin, true);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                assert_true(get_user_pass_cr(&amp;up, use=
_inline_creds ? creds : authfile, &quot;UT&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                             =
use_inline_creds ? GET_USER_PASS_INLINE_CREDS : 0, NULL));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                /* Truncation must n=
ot change where the password line starts=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                creds[lengths[i] &lt; USER_PASS_=
LEN ? lengths[i] : USER_PASS_LEN - 1] =3D &#39;\0&#39;;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                assert_true(up=2Edefine=
d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
assert_string_equal(up=2Eusername, creds);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                assert_string_equal(up=2Epassword,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
               missing_password ? &quot;cpassword&quot; : &quot;fpassword&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(platform_unlink(authfile)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef ENABLE_M=
ANAGEMENT</span><br><span> static void</span><br><span> test_get_user_pass_=
dynamic_challenge(void **state)</span><br><span>@@ -474,6 +526,7 @@</span><=
br><span>     cmocka_unit_test(test_get_user_pass_inline_creds),</span><br>=
<span>     cmocka_unit_test(test_get_user_pass_authfile_stdin),</span><br><=
span>     cmocka_unit_test(test_get_user_pass_authfile_file),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_get_use=
r_pass_long_username),</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br>=
<span>     cmocka_unit_test(test_get_user_pass_dynamic_challenge),</span><b=
r><span>     cmocka_unit_test(test_get_user_pass_static_challenge),</span><=
br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2096?usp=3Demail">change 2096</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2096?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType=
: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I3c8c62c7d90c2b94dd1cd149b4c13b383a230=
3e9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2096 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>

</body></html>
--ql6UtFAD4xQ=--


--===============8582149571408819303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8582149571408819303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8582149571408819303==--

