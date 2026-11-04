Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DFB606A337
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BSTzBA/y;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Qf3brugV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gXUM8UdM;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NcB0bN2b
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=KMzlHZLF0ETerurFGzqELARN6XXrKBlD2JSDj9hhhT8=; b=BSTzBA/y4m5gIV/9HAlrilv5Wr
	36JX7zHV6kvEBmcfT7xnhfqpcWzdVoNEPkznX6Xi/oy0RYYqimTw4o7pQ0jvpKOam5b0ZlMNuSXWe
	X9qI2wAJzeJ6rZp9MOjOdj5gqta/zqMrId+dXhVYZiPFkX+V40KuW76JwhzT3pTxhZVY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOaS0-000000001h6-0mqF;
	Wed, 04 Nov 2026 12:50:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOaRy-000000001gz-3KuX
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:50:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dsciFdv9Bd8pNdB301aaGX47OzpQgVccDCw6OeuLLkI=; b=Qf3brugVbf07MpJspAS8N1neSI
 3b9WnXbrQMh1Uv8oMHkLei5sM/Y2Pwv3OJZaotiYBybDGboCKR2Uk2Yxl+TTllidQZaDPvjoFRMEk
 2vjJ0ptF76znTwRiPlbaj8NjAUPQf+uXSXIs5vnaYaJH8rcwfC+Ge5nZepTu6FCQ/8wc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dsciFdv9Bd8pNdB301aaGX47OzpQgVccDCw6OeuLLkI=; b=gXUM8UdMFvW4V8Z9Fwhpr1YoQV
 4YVAdmeWSvcbto87ikZGbJrhuBTPCzL9Mj4jr9mRP1N3STPEvKj3mqf0NSFeOhD2mrQVIAi5b2Y8t
 xkCN0qeh+bJfvn5LlcqSvAu7NtWWUd/UeaZWvA0QGYyg0Ad9XToWqO61ionJKQ2g2lcY=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOaRx-000000000VP-0gzv for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:50:46 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48afcfc4bf5so610659f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 04:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793796638; x=1794401438; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dsciFdv9Bd8pNdB301aaGX47OzpQgVccDCw6OeuLLkI=;
 b=NcB0bN2bU7TpTv1Qvy0ZwU8Q1fLLJqrV3EpdWByfi9W67OSV0HjvWmJtSXzD9wiFr5
 gQtYXQU0r+UI88/CMjWiUT5vI99sMqWN0xJYVZPaTgoDKSbV/0JtPxkEeMDgwV9S7Tp5
 hlxftOrljDGPyLqEIaRWDlmyKBOrzoVWKd76YAGqVxYxGtU9obYi1R/til4AEwiTIVyS
 k+j8WRfnTnnScdmUvUQBRc71Q8rEkz7a0loBc3AWh6UfnpHBqHtbfuvZNnTj+wITSTDx
 dcsVEYXH0P0B8RuqS20T1s3C6dAkv01sGpK0/g9PQ7qO3WDJZ8nzD6kMRGzrKNIexIww
 S0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793796638; x=1794401438;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dsciFdv9Bd8pNdB301aaGX47OzpQgVccDCw6OeuLLkI=;
 b=fm9NFXLxFdQHBqvwHPCv8ZpGNRx7Zno+2HjHXmWY74ih+o+f8U1XKq3M3xLj6CxxV4
 3/dm85ZhZ2LG24CzE9OAyqJkNV0Qa3M4+XQzH7udX9OsOmuyMiJVhrmla/lrCXt2a2yn
 dnvjRVY2uOQ/TZTtxT4p4mCC1w4pIRKGuQs2Cis9bOvgxXwSfcHdS7ThPVnLV2kMVyV9
 J70rH1n4CwMzRCaGHA6/pDVPnIWVjk2YiAQyNF8tZXUXEpmwWR0LNbW1Tg/4SglALS6T
 Nk5Unu4v9PTuQO2thUk267whO14O+QPn/HhkBenGjA8go3X2aCBz6rAaPV4oAWe3kOjK
 cEHg==
X-Gm-Message-State: APuU4Z8CqcpsHcGePrJNDI+tQo5DHQ9I1wFoQOk9gMPL7W5AU7KGRjmG
 hKNDrg1ZwNKcQX2bNpqgx/2ooxHdqc2UT1yCXPUlF26S0J9dITfnLKpW18PgtA/f+/wAuV455wA
 XP19akWi51lieHkF2GBv8vE9PaZrkwa2E7OSIdWAlvzwUFyiLvUhnsdwXZ9M4T2hlDdo5C3Q3DM
 FSe6frLQ==
X-Gm-Gg: AYBFou1Wn1u7N0xie1/lV8RkdQi2TviWBbuZNvyON68ctHgu3LefMbIuK3UsleXZ/yV
 VEhzPmHh//HFWIoNUffUKj21J232ilnwX9VmR3C7n/wex1wXlu7by4N5R1eYCeZMbcN33S5Jk2g
 tA4zf/324q94nVPKqX34yDzM5dT3rCc6DpAOCrNnYwooiNTue2hRzmxgbT86YtZk2IGHiEhsnhi
 9L/jcxKmhI3MyK6qD7uEjXW7EI4P6YDGM29J453jV6eaC7hLWUfQyuAA32lgkczIWwAZ2qWo2nW
 ZVN8EigYVUmVxWTq1Hwv0WOAC3LbszAY2d6XvcxaJKw7366gwqWTG9Mv01EOMReaZVuoTSZzMDA
 061skA2MjmERbT3+K0GA7v5tDQ1qzmL8OqWti3mCXKnrK1gan9eeaqtn07P72vxY23gC93nSopu
 mXAHWxoijBtpuMfuQkt4XSzW6h9AAwBDPATZlLXAQH62z5j5xgahjtaBJjO0p4Oo/rLpT5CIt/U
 HbT41e94indCVBm0R4TUMTJR+MnMmQUdtHCojg2510Ba+g8c4u2bsavHPA1Xd9MuenZ3Lengclz
 pLy2kxuNW8sAJga2dbCGtykSIuukNjSmoG5JlRoDRYpEZO4+0ttx2UTAwgRDZxxdFqJaltsGVtP
 IYYTQ4Cmbs8UAz3WxLy3s8G5KgZgw0YGhe5zqL8gtiuyjaFPi4oxc7nWZTy5STY1quQTtLiR6r/
 n/jUg9zCHqecwP6w==
X-Received: by 2002:a05:6000:4b03:b0:490:6fbc:9457 with SMTP id
 ffacd0b85a97d-4906fbc9509mr2011078f8f.41.1793796638304; 
 Wed, 04 Nov 2026 04:50:38 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fece99a5dsm3623777f8f.21.2026.11.04.04.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 04:50:37 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 12:50:36 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I04c128a934e9a2e767394dbe82427df2ee886178
X-Gerrit-Change-Number: 2118
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2118?usp=email>
X-Gerrit-Commit: a95c2533fd931037fa021b38a42d7cbe6f334cef
In-Reply-To: <gerrit.1793776591000.I04c128a934e9a2e767394dbe82427df2ee886178@gerrit.openvpn.net>
References: <gerrit.1793776591000.I04c128a934e9a2e767394dbe82427df2ee886178@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc2NTkxMDAwLkkwNGMxMjhhOTM0ZTlhMmU3NjczOTRkYmU4MjQyN2RmMmVlODg2MTc4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3d54d284bc0071d66623b4a4d2e2f9002d0dc0c5-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOaRx-000000000VP-0gzv
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_verify: drop the
 return value of verify_user_pass_management()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2035171809204419191=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2035171809204419191==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2rEB8MR8/VU="; charset=UTF-8

--2rEB8MR8/VU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, Frank Lichtenheld, 

I'd like you =
to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2118?usp=3Demail

to look at the new patch set (#2)=2E

The foll=
owing approvals got outdated and were removed:
Code-Review-1 by Frank Licht=
enheld


Change subject: ssl_verify: drop the return value of verify_user_p=
ass_management()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

ssl_verify: drop the return value of verify_user_pass_management()

Th=
e function cannot fail since a4eeef17 ("Add function for common env
setting=
 of verify user/pass calls") moved the username check out of it,
so it alwa=
ys returned KMDA_SUCCESS and man_def_auth could never become
KMDA_ERROR=2E =
Make it void, track only whether deferred management auth
is enabled, and d=
rop the KMDA_* codes=2E

Change-Id: I04c128a934e9a2e767394dbe82427df2ee8861=
78
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn=
/ssl_verify=2Ec
1 file changed, 6 insertions(+), 28 deletions(-)


  git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/18/2118/2

diff =
--git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index 0cdec=
1e=2E=2Ef5af932 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/s=
sl_verify=2Ec
@@ -1521,18 +1521,9 @@
 
 
 #ifdef ENABLE_MANAGEMENT
-/*
- * =
management deferred internal ssl_verify=2Ec status codes
- */
-#define KMDA=
_ERROR   0
-#define KMDA_SUCCESS 1
-#define KMDA_UNDEF   2
-#define KMDA_DE=
F     3
-
-static int
+static void
 verify_user_pass_management(struct tls_=
session *session, const struct user_pass *up)
 {
-    int retval =3D KMDA_E=
RROR;
     const struct key_state *ks =3D &session->key[KS_PRIMARY]; /* pri=
mary key */
 
     /* set username/password in private env space */
@@ -154=
5,10 +1536,6 @@
     }
 
     setenv_del(session->opt->es, "password");
-
-=
    retval =3D KMDA_SUCCESS;
-
-    return retval;
 }
 #endif /* ifdef ENAB=
LE_MANAGEMENT */
 
@@ -1613,12 +1600,7 @@
     ASSERT(up && !up->protected)=
;
 
 #ifdef ENABLE_MANAGEMENT
-    int man_def_auth =3D KMDA_UNDEF;
-
-    =
if (management_enable_def_auth(management))
-    {
-        man_def_auth =
=3D KMDA_DEF;
-    }
+    const bool man_def_auth =3D management_enable_def=
_auth(management);
 #endif
 
     /* enforce character class restrictions i=
n username/password */
@@ -1706,9 +1688,9 @@
     if (!skip_auth)
     {
 #=
ifdef ENABLE_MANAGEMENT
-        if (man_def_auth =3D=3D KMDA_DEF)
+       =
 if (man_def_auth)
         {
-            man_def_auth =3D verify_user_pas=
s_management(session, up);
+            verify_user_pass_management(session=
, up);
         }
 #endif
         if (plugin_defined(session->opt->plugins=
, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY))
@@ -1736,11 +1718,7 @@
     bool s=
cript_ok =3D script_status =3D=3D OPENVPN_PLUGIN_FUNC_SUCCESS
             =
         || script_status =3D=3D OPENVPN_PLUGIN_FUNC_DEFERRED;
 
-    if (s=
cript_ok && plugin_ok && tls_lock_username(multi, up->username)
-#ifdef ENA=
BLE_MANAGEMENT
-        && man_def_auth !=3D KMDA_ERROR
-#endif
-    )
+   =
 if (script_ok && plugin_ok && tls_lock_username(multi, up->username))
    =
 {
         ks->authenticated =3D KS_AUTH_TRUE;
         if (plugin_status =
=3D=3D OPENVPN_PLUGIN_FUNC_DEFERRED
@@ -1749,7 +1727,7 @@
             ks->=
authenticated =3D KS_AUTH_DEFERRED;
         }
 #ifdef ENABLE_MANAGEMENT
- =
       if (man_def_auth !=3D KMDA_UNDEF)
+        if (man_def_auth)
       =
  {
             if (skip_auth)
             {

-- 
To view, visit https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2118?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: I04c128a934e9a2e767394dbe82427df2ee886178
G=
errit-Change-Number: 2118
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojo=
caru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld =
<frank@lichtenheld=2Ecom>

--2rEB8MR8/VU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>R=C4=83zvan Cojocaru <strong>uploaded patch set #2</strong> to =
this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2118?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review-1 by Frank Lichtenheld</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">ssl=
_verify: drop the return value of verify_user_pass_management()<br><br>The =
function cannot fail since a4eeef17 (&quot;Add function for common env<br>s=
etting of verify user/pass calls&quot;) moved the username check out of it,=
<br>so it always returned KMDA_SUCCESS and man_def_auth could never become<=
br>KMDA_ERROR=2E Make it void, track only whether deferred management auth<=
br>is enabled, and drop the KMDA_* codes=2E<br><br>Change-Id: I04c128a934e9=
a2e767394dbe82427df2ee886178<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt;<br>---<br>M src/openvpn/ssl_verify=2Ec<br>1 file changed,=
 6 insertions(+), 28 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/18/2118/2</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec</span><br><=
span>index 0cdec1e=2E=2Ef5af932 100644</span><br><span>--- a/src/openvpn/ss=
l_verify=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify=2Ec</span><br><sp=
an>@@ -1521,18 +1521,9 @@</span><br><span> </span><br><span> </span><br><sp=
an> #ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * managemen=
t deferred internal ssl_verify=2Ec status codes</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define KMDA_ERROR   0</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define KMDA_SUCCESS 1</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#define KMDA_UNDEF   2</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define KMDA_DEF     3</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static in=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span>=
<br><span> verify_user_pass_management(struct tls_session *session, const s=
truct user_pass *up)</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    int retval =3D KMDA_ERROR;</span><br><span>     const=
 struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY]; /* primary key =
*/</span><br><span> </span><br><span>     /* set username/password in priva=
te env space */</span><br><span>@@ -1545,10 +1536,6 @@</span><br><span>    =
 }</span><br><span> </span><br><span>     setenv_del(session-&gt;opt-&gt;es=
, &quot;password&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retval =3D KMD=
A_SUCCESS;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    return retval;</span><br><sp=
an> }</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span=
> </span><br><span>@@ -1613,12 +1600,7 @@</span><br><span>     ASSERT(up &a=
mp;&amp; !up-&gt;protected);</span><br><span> </span><br><span> #ifdef ENAB=
LE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int =
man_def_auth =3D KMDA_UNDEF;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (manage=
ment_enable_def_auth(management))</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    man_def_auth =3D KMDA_DEF;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst bool man_def_auth =3D management_enable_def_auth(management);</span><b=
r><span> #endif</span><br><span> </span><br><span>     /* enforce character=
 class restrictions in username/password */</span><br><span>@@ -1706,9 +168=
8,9 @@</span><br><span>     if (!skip_auth)</span><br><span>     {</span><b=
r><span> #ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if (man_def_auth =3D=3D KMDA_DEF)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (man_def_auth)</span><br><span=
>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  man_def_auth =3D verify_user_pass_management(session, up);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            verify_user_pass_manag=
ement(session, up);</span><br><span>         }</span><br><span> #endif</spa=
n><br><span>         if (plugin_defined(session-&gt;opt-&gt;plugins, OPENVP=
N_PLUGIN_AUTH_USER_PASS_VERIFY))</span><br><span>@@ -1736,11 +1718,7 @@</sp=
an><br><span>     bool script_ok =3D script_status =3D=3D OPENVPN_PLUGIN_FU=
NC_SUCCESS</span><br><span>                      || script_status =3D=3D OP=
ENVPN_PLUGIN_FUNC_DEFERRED;</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (script_ok &amp;&amp; plugin_ok &amp;&amp; t=
ls_lock_username(multi, up-&gt;username)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        &amp;&amp; man_def_auth !=3D KMDA_ERROR</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    )</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (script_ok &amp;&amp; plugin_ok &amp;&amp; tls_lo=
ck_username(multi, up-&gt;username))</span><br><span>     {</span><br><span=
>         ks-&gt;authenticated =3D KS_AUTH_TRUE;</span><br><span>         i=
f (plugin_status =3D=3D OPENVPN_PLUGIN_FUNC_DEFERRED</span><br><span>@@ -17=
49,7 +1727,7 @@</span><br><span>             ks-&gt;authenticated =3D KS_AU=
TH_DEFERRED;</span><br><span>         }</span><br><span> #ifdef ENABLE_MANA=
GEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (man=
_def_auth !=3D KMDA_UNDEF)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (man_def_auth)</span><br><span>         {</span><br><span=
>             if (skip_auth)</span><br><span>             {</span><br></pre=
><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
18?usp=3Demail">change 2118</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2118?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpat=
chset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<d=
iv style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Id: I04c128a934e9a2e767394dbe82427df2ee886178 </div=
>
<div style=3D"display:none"> Gerrit-Change-Number: 2118 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> G=
errit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank L=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt; </div>

</body></html>
--2rEB8MR8/VU=--


--===============2035171809204419191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2035171809204419191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2035171809204419191==--

