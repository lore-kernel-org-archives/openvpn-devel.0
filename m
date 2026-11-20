Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BE3606A320
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 07:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ci5fIk9w;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=cyQKQKwR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OVM8Lk9m;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Eq4DeLX+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=C79VwwqTgwsZEcD6ChSCESB3GDV2PHNyl/cW4rp3Diw=; b=ci5fIk9wjd6v31WNB1DofpSDGW
	EMZ11xUV1hPI2vIQT/om1zm1e6M8nmahMZNzEhRYqYj8a/kBL0Fl3e13PIoiAJbnGHB6b8uhTUNvX
	saZKGkgFwWRwM9x8f94edue2u1DGYG2PT8CZaxf8TJNR1U6gK81N0KXHH7LGIKngf/F8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUJLw-0000000089b-48fX;
	Fri, 20 Nov 2026 07:48:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUJLw-0000000089U-09JG
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 07:48:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=usxu4cAuX5mxDk+Z7EXC/uogcjL8w2xeh4/0J7zKpe4=; b=cyQKQKwRHhe9lt5UOreKVdC/aZ
 EZ98c3TFQcCXyDpDoI/22Hy47wDWOWfRsgF/4dfFyazoPVjDXSQqvP0V41RKt/QwfvOX4nrqTRRM5
 LHxGh3DHwgDWPQtoO7iM3V1fG7SahpcBAAgCErQ8rQR46PqaRtEuXgExH126cx4poOh4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=usxu4cAuX5mxDk+Z7EXC/uogcjL8w2xeh4/0J7zKpe4=; b=OVM8Lk9mkDu5hvSf5p5Pt8eiSX
 vEbdF2KjoOY5FkWvxbpY3PKWJ3NgUE5QuG5/hDym2ahN53fjQv7aEuE7d0Dx2jQLtAjleQdy9d1VQ
 5ZwzHpnSR0Gnhmnh1TUG/2moGTssQTwCuswFSy+a3cuFIngvfw0SHoEbmy/rzz42+aKQ=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUJLu-00000000725-1sL2 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 07:48:11 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so5127755e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 23:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795160884; x=1795765684; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=usxu4cAuX5mxDk+Z7EXC/uogcjL8w2xeh4/0J7zKpe4=;
 b=Eq4DeLX+FtXr9CMhWs/L7z8MBdQBHrT77vWP7SRyi+DpQY+e3b57c1iEBUe5UGlpj7
 0yYqrCF1Zbe+nbAub8m7GxJd/G+/X05ppceDYnXrWLD+Nlbjwhi8izUQAvlQPNomc4aX
 gs4rjXDImHgUKiHj1X37AJ656nuCkRh6gK7XvAKntnfXgrLFveekGM4JR3rn3ltYA710
 Ealv5LZDc6sgdKpqdhX37VyGqc7US6BvodK4et/7tEx60YL80nLlOc2ctfc0DUrbK44K
 lLJJIzYigHCc4bZVBKuIzZXXZuXngerlqS3zTLLVP95jeW/qRXH/EW3JKujTRE64CEQJ
 F/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795160884; x=1795765684;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=usxu4cAuX5mxDk+Z7EXC/uogcjL8w2xeh4/0J7zKpe4=;
 b=pzExVsRnVDPtLXnp20tj7+yxbCVv3i0HrPIxjdi//u10b/mxiBt3Wa5lvwTBdnkG7M
 dZK2HUkIcqA17L8fLogrZx3AspYM0yIUmlnpj40cFuw0F8ZAzmf7za2zaRvd8AmZ204m
 5g+6wJhyajCuQmoxsxwq04wopEcYvzDfGWjUNQiNT3HQBA6SBIYARNs7Of1oPnujTnG/
 1Tp9UYaugB1N1zoHiGJpH3JCCGjJrRKFNg8RHeqsnexCKghS6lgdiDpjXZtRInZjb+ly
 tMlKiDPGa5bvEfL3JxpDHcj+lz+SIbWUpjoEzSStmFp5SWgezQTAQiTEBVjhRRadlIR3
 MX4A==
X-Gm-Message-State: APuU4Z8k0CjblyYYIhev4IkAhB3VMbzyzf5lG+VVaQU+X11QucR8YKIB
 RwupjvYvzKzZnogtnPT7rEHUxpAfk58YnohCRMX14CKShwob7rwOGNDqKeOOA3/8F5RWgfTFCOv
 +liFsYk6piP0OgUJ31emR2rXl2PT+bFmU/JPldPHp098ChDtF15oDYgNTGzAdlJpvGu2/
X-Gm-Gg: AYBFou1Fnaf0L+tof4h8kL8RHEqvzcOpC47OAczj1pMPbbez8gR/BuHqpHXcg5tcv8b
 o4qDUrzNBaaIs39258iNTfd1NLqtJS3ENHiIAUKFyOSvuWhlUravuEU7cZhQV/y7mzcN/stMIG0
 /Z1NoqiZ8d/Sl+wB5CdhtmWq9Ln6SlUFKojffIkvInTu1QERqPFj9Y1lSm+c/VE9qlvnT9SP9fT
 mmAP7WWGXdjYbHK2A9Ch48QB2evzcwbGa8a82PiBDWDi07LfTBaA1wEqBKAOJrFIhTRPsb7zwcP
 kUV/DN9fUDR1JzaUHISh8jQ1/Ge8bFROrwaI2RvhtGa9PEPE7zSDUq1McRwZJs+N0CAZMuPaIcG
 PVd47VpMSU9vMSR6wYaTjpiEuk1KxTIKXFrWJoDTKdGJjLwHrVMh+bWUtBA4hOYDDkJwzxu7fGL
 3W1Tv1/RJo0TgrErpitA/euFTdgdQ6tWDdcOBumhyubfPgtgvxtA5MdrpzyUeqAcQxzhdS0g3Sz
 gkoXczmBL1fI8OYD4S78qNqdaNmJI9OS10DprswNsnBdl/rErItlbyZhHA3O8Gui5uE0D+rJo8n
 3W1IIWX1VcvD231sGINIf3MB5iyPwozN4qILKnBeJJQIVLq3a0jQgLnJhSusqZCtDzvQVGZvlH0
 Yeio0VnKRojG8DL+fuY3M9oBn4oLmZvxoPiiFjUkp0Po3go12KR3G4QQPix/0HPtbN6uJxkrY7G
 yOmBUroqqaDHNtv5an9LpnvcFgTytb7WuFbdkf
X-Received: by 2002:a05:600c:6092:b0:4bb:6ac0:6dc0 with SMTP id
 5b1f17b1804b1-4bb8892097fmr41452975e9.29.1795160883726; 
 Thu, 19 Nov 2026 23:48:03 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9687sm107937995e9.10.2026.11.19.23.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 23:48:03 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 07:48:01 +0000
To: Lev Stipakov <lstipakov@gmail.com>, Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I14ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8
X-Gerrit-Change-Number: 2188
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2188?usp=email>
X-Gerrit-Commit: c91dcba33593c9ff5369d6debbd16c6ca8b0a82b
In-Reply-To: <gerrit.1794825232000.I14ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8@gerrit.openvpn.net>
References: <gerrit.1794825232000.I14ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODI1MjMyMDAwLkkxNGFkNGU0NTExYmQ5OTMzYjg5ZjQ4YWU1YTNhYzZkMmE1ZTBmMmQ4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bf70fbfeee65e68a0bc71920a1eee0c715e45c2d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUJLu-00000000725-1sL2
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv: check
 for a leading non-option in the startup data
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8678390685358381957=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8678390685358381957==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dQhirwbO6Z8="; charset=UTF-8

--dQhirwbO6Z8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Lev Stipakov, R=C4=83zv=
an Cojocaru=2E

Hello Arne Schwabe, Lev Stipakov, 

I'd like you to reexami=
ne a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2188?usp=3Demail

to look at the new patch set (#3)=2E

The following appr=
ovals got outdated and were removed:
Code-Review+1 by Lev Stipakov


Change=
 subject: openvpnserv: check for a leading non-option in the startup data
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: =
check for a leading non-option in the startup data

Check sud=2Eoptions dir=
ectly before doing any other work, instead of
building the openvpn=2Eexe co=
mmand line and parsing it back=2E This also
rejects empty options=2E

Chang=
e-Id: I14ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8
Signed-off-by: Razvan Cojoc=
aru <razvanc@mailbox=2Eorg>
---
M src/openvpnserv/interactive=2Ec
M tests/u=
nit_tests/openvpnserv/test_openvpnserv=2Ec
2 files changed, 24 insertions(+=
), 28 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/88/2188/3

diff --git a/src/openvpnserv/interactive=2Ec b/src/=
openvpnserv/interactive=2Ec
index 354fe09=2E=2Ef0078ac 100644
--- a/src/ope=
nvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -357,24 +=
357,17 @@
 /**
  * Check whether the user options start with a non-option
 =
 *
- * openvpn=2Eexe takes a lone argument as the config file only when the=
re are
- * no other arguments, and takes non-options after the --msg-channe=
l handle
- * as its extra parameters=2E
+ * openvpn=2Eexe takes non-options=
 after the --msg-channel handle the service
+ * prepends as its extra param=
eters, not as the config file=2E
  *
- * @param  cmdline  openvpn=2Eexe com=
mand line built by the service
+ * @param  options  user options from the s=
tartup data
  *
  * @return BOOL to indicate if the first user argument is =
not an option
  */
 static BOOL
-StartsWithNonOption(const WCHAR *cmdline)
=
+StartsWithNonOption(const WCHAR *options)
 {
-    int argc;
-    WCHAR **a=
rgv =3D CommandLineToArgvW(cmdline, &argc);
-    /* "openvpn --msg-channel =
<handle> <arg>=2E=2E=2E" */
-    BOOL ret =3D argv && argc > 3 && !IsOption=
(argv[3]);
-
-    LocalFree(argv);
-    return ret;
+    return !IsOption(o=
ptions + wcsspn(options, L" \t"));
 }
 
 /*
@@ -3639,6 +3632,14 @@
        =
 goto out;
     }
 
+    if (StartsWithNonOption(sud=2Eoptions))
+    {
+  =
      ReturnError(pipe, ERROR_STARTUP_DATA,
+                    L"Options =
must start with an option, pass the config file with --config", 1,
+       =
             &exit_event);
+        goto out;
+    }
+
     if (!Initialize=
SecurityDescriptor(&ovpn_sd, SECURITY_DESCRIPTOR_REVISION))
     {
        =
 ReturnLastError(pipe, L"InitializeSecurityDescriptor");
@@ -3883,14 +3884,=
6 @@
     swprintf(cmdline, cmdline_size, L"openvpn --msg-channel %" PRIuPT=
R L" %ls",
              (uintptr_t)svc_pipe, sud=2Eoptions);
 
-    if (St=
artsWithNonOption(cmdline))
-    {
-        ReturnError(pipe, ERROR_STARTUP=
_DATA,
-                    L"Options must start with an option, pass the c=
onfig file with --config", 1,
-                    &exit_event);
-        g=
oto out;
-    }
-
     /*
      * Only authorized users are allowed to use =
any command line options or
      * have the config file in locations other=
 than the global config directory=2E
diff --git a/tests/unit_tests/openvpns=
erv/test_openvpnserv=2Ec b/tests/unit_tests/openvpnserv/test_openvpnserv=2E=
c
index 7db61f7=2E=2Ed07fa22 100644
--- a/tests/unit_tests/openvpnserv/test=
_openvpnserv=2Ec
+++ b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
@@=
 -304,15 +304,18 @@
 static void
 test_starts_with_non_option(void **state)=

 {
-    assert_true(StartsWithNonOption(L"openvpn --msg-channel 1 foo=2Eov=
pn"));
-    assert_true(StartsWithNonOption(L"openvpn --msg-channel 1 \"my =
vpn=2Eovpn\""));
-    assert_true(StartsWithNonOption(L"openvpn --msg-chann=
el 1 foo=2Eovpn --verb 3"));
-    assert_true(StartsWithNonOption(L"openvpn=
 --msg-channel 1 foo=2Eovpn bar"));
-    assert_true(StartsWithNonOption(L"=
openvpn --msg-channel 1 \"\""));
+    assert_true(StartsWithNonOption(L"foo=
=2Eovpn"));
+    assert_true(StartsWithNonOption(L"\"my vpn=2Eovpn\""));
+ =
   assert_true(StartsWithNonOption(L"foo=2Eovpn --verb 3"));
+    assert_tr=
ue(StartsWithNonOption(L"foo=2Eovpn bar"));
+    assert_true(StartsWithNonO=
ption(L" \tfoo=2Eovpn"));
+    assert_true(StartsWithNonOption(L"\"\""));
+=
    assert_true(StartsWithNonOption(L""));
+    assert_true(StartsWithNonOp=
tion(L" "));
 
-    assert_false(StartsWithNonOption(L"openvpn --msg-channe=
l 1 "));
-    assert_false(StartsWithNonOption(L"openvpn --msg-channel 1 --=
persist-tun"));
-    assert_false(StartsWithNonOption(L"openvpn --msg-chann=
el 1 --config foo=2Eovpn"));
+    assert_false(StartsWithNonOption(L"--pers=
ist-tun"));
+    assert_false(StartsWithNonOption(L"--config foo=2Eovpn"));=

+    assert_false(StartsWithNonOption(L" \t--config foo=2Eovpn"));
 }
 
 s=
tatic void

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
188?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpa=
tchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I14a=
d4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8
Gerrit-Change-Number: 2188
Gerrit-Pat=
chSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-=
Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Lev St=
ipakov <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-Attention: Lev Stipakov <lstipakov@gmail=2Eco=
m>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-At=
tention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--dQhirwbO6Z8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Lev Stipakov, R=C4=83zvan Cojocaru=2E <=
/p>
<p>R=C4=83zvan Cojocaru <strong>uploaded patch set #3</strong> to this =
change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2188?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+1 by Lev Stipakov</p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">openvpnserv: =
check for a leading non-option in the startup data<br><br>Check sud=2Eoptio=
ns directly before doing any other work, instead of<br>building the openvpn=
=2Eexe command line and parsing it back=2E This also<br>rejects empty optio=
ns=2E<br><br>Change-Id: I14ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8<br>Signed=
-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/open=
vpnserv/interactive=2Ec<br>M tests/unit_tests/openvpnserv/test_openvpnserv=
=2Ec<br>2 files changed, 24 insertions(+), 28 deletions(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/88/2188/3</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpnserv/interactive=2Ec b/src/openv=
pnserv/interactive=2Ec</span><br><span>index 354fe09=2E=2Ef0078ac 100644</s=
pan><br><span>--- a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/s=
rc/openvpnserv/interactive=2Ec</span><br><span>@@ -357,24 +357,17 @@</span>=
<br><span> /**</span><br><span>  * Check whether the user options start wit=
h a non-option</span><br><span>  *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * openvpn=2Eexe takes a lone argument as the config file only=
 when there are</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * no =
other arguments, and takes non-options after the --msg-channel handle</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * as its extra parameters=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * openvpn=2Eexe=
 takes non-options after the --msg-channel handle the service</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * prepends as its extra paramete=
rs, not as the config file=2E</span><br><span>  *</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * @param  cmdline  openvpn=2Eexe command line =
built by the service</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param  options  user options from the startup data</span><br><span>  *=
</span><br><span>  * @return BOOL to indicate if the first user argument is=
 not an option</span><br><span>  */</span><br><span> static BOOL</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-StartsWithNonOption(const WCHAR =
*cmdline)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+StartsWith=
NonOption(const WCHAR *options)</span><br><span> {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    int argc;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    WCHAR **argv =3D CommandLineToArgvW(cmdline, &amp;=
argc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* &quot;op=
envpn --msg-channel &lt;handle&gt; &lt;arg&gt;=2E=2E=2E&quot; */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    BOOL ret =3D argv &amp;&amp;=
 argc &gt; 3 &amp;&amp; !IsOption(argv[3]);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    LocalFree(argv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return !IsOption(options + wcsspn(options, L&quot; \t&quot;));</span><br><s=
pan> }</span><br><span> </span><br><span> /*</span><br><span>@@ -3639,6 +36=
32,14 @@</span><br><span>         goto out;</span><br><span>     }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (St=
artsWithNonOption(sud=2Eoptions))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        ReturnError(pipe, ERROR_STARTUP_DATA,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                    L&quot;Options must start wit=
h an option, pass the config file with --config&quot;, 1,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    &amp;exit_event);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto out;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (!Initiali=
zeSecurityDescriptor(&amp;ovpn_sd, SECURITY_DESCRIPTOR_REVISION))</span><br=
><span>     {</span><br><span>         ReturnLastError(pipe, L&quot;Initial=
izeSecurityDescriptor&quot;);</span><br><span>@@ -3883,14 +3884,6 @@</span>=
<br><span>     swprintf(cmdline, cmdline_size, L&quot;openvpn --msg-channel=
 %&quot; PRIuPTR L&quot; %ls&quot;,</span><br><span>              (uintptr_=
t)svc_pipe, sud=2Eoptions);</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (StartsWithNonOption(cmdline))</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        ReturnError(pipe, ERROR_STARTUP_DATA,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                    L&quot;=
Options must start with an option, pass the config file with --config&quot;=
, 1,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
   &amp;exit_event);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       goto out;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>    =
 /*</span><br><span>      * Only authorized users are allowed to use any co=
mmand line options or</span><br><span>      * have the config file in locat=
ions other than the global config directory=2E</span><br><span>diff --git a=
/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec b/tests/unit_tests/openv=
pnserv/test_openvpnserv=2Ec</span><br><span>index 7db61f7=2E=2Ed07fa22 1006=
44</span><br><span>--- a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec<=
/span><br><span>+++ b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec</sp=
an><br><span>@@ -304,15 +304,18 @@</span><br><span> static void</span><br><=
span> test_starts_with_non_option(void **state)</span><br><span> {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(StartsWithNonO=
ption(L&quot;openvpn --msg-channel 1 foo=2Eovpn&quot;));</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    assert_true(StartsWithNonOption(L&qu=
ot;openvpn --msg-channel 1 \&quot;my vpn=2Eovpn\&quot;&quot;));</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(StartsWithNonOpti=
on(L&quot;openvpn --msg-channel 1 foo=2Eovpn --verb 3&quot;));</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    assert_true(StartsWithNonOptio=
n(L&quot;openvpn --msg-channel 1 foo=2Eovpn bar&quot;));</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    assert_true(StartsWithNonOption(L&qu=
ot;openvpn --msg-channel 1 \&quot;\&quot;&quot;));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_true(StartsWithNonOption(L&quot;f=
oo=2Eovpn&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_true(StartsWithNonOption(L&quot;\&quot;my vpn=2Eovpn\&quot;&quot;=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(=
StartsWithNonOption(L&quot;foo=2Eovpn --verb 3&quot;));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(StartsWithNonOption(L&q=
uot;foo=2Eovpn bar&quot;));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_true(StartsWithNonOption(L&quot; \tfoo=2Eovpn&quot;));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(Start=
sWithNonOption(L&quot;\&quot;\&quot;&quot;));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_true(StartsWithNonOption(L&quot;&quot;=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(=
StartsWithNonOption(L&quot; &quot;));</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    assert_false(StartsWithNonOption(L&qu=
ot;openvpn --msg-channel 1 &quot;));</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    assert_false(StartsWithNonOption(L&quot;openvpn --msg-ch=
annel 1 --persist-tun&quot;));</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    assert_false(StartsWithNonOption(L&quot;openvpn --msg-channel =
1 --config foo=2Eovpn&quot;));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_false(StartsWithNonOption(L&quot;--persist-tun&quot;)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(=
StartsWithNonOption(L&quot;--config foo=2Eovpn&quot;));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_false(StartsWithNonOption(L&=
quot; \t--config foo=2Eovpn&quot;));</span><br><span> }</span><br><span> </=
span><br><span> static void</span><br></pre><p>To view, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2188?usp=3Demail">change 2188</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2188?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1=
4ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2188 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojoc=
aru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Lev Stipakov &lt;lstipakov@gmail=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@m=
ailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--dQhirwbO6Z8=--


--===============8678390685358381957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8678390685358381957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8678390685358381957==--

