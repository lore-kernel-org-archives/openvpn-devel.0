Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE475606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=l75c1m4E;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Vfw8hY/P;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=luF62lAn;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TLBvvwE/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=rZfUR/EQ9eQQji2tET6C0MD/gere5zdAsG3YhCXnV0I=; b=l75c1m4Ee3BbDa60KG6LyxelnE
	zwQKDGFN7QBmP+bkr5zKSjBqShFJoOZ/nxSLEO+MVjnPNeFIlnByP/Dy+HoaaMXQR4zqDYM0GZ3+0
	5t0vaKCHE3DYJ/Iz9WaI3pv9IUhy55A/cIHedyoMGnrFhS2qLvm5vwIdBOyPYUK7Kq+c=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR67K-000000005jS-22GS;
	Wed, 11 Nov 2026 11:03:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR66x-000000005hi-3nUS
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 11:03:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LAt5IyAYLEF8ggyOYVTMUF5s0S+oCjB5DfB3YItk6g8=; b=Vfw8hY/Pyt+MTXlmfQIwWzWAik
 v3rFEkLGtc+Gp5t+BFX3wRVWYypRGSrUatbrx2UvSeCxFURTyPwSeKI5j6EMvRPs/p1Bo6X+Riyau
 g32MlvBRQTchtzz9PdxJf9cJCJP88Up5H6leu6wuDGmzM2QE3CWYcLXskHfR8YkQfpwA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LAt5IyAYLEF8ggyOYVTMUF5s0S+oCjB5DfB3YItk6g8=; b=luF62lAnfLbK5MYw/co/KEDlb7
 BkORkD1oiATVNwpa1R3mztCGbQtO6HuB+vRkNSmxB/56RXsH5yKhQfjab3V/l4TDfcgGgzbMXFQAG
 q7BTWxfptueBmIc4ofem5hWCajgmWe8OU4MVR7ADULT50Bx7Ll2qwAe4iK82vSoTQHIc=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR66o-000000003CR-2Fk7 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 11:03:20 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-491971ac844so2871535f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 03:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794394992; x=1794999792; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LAt5IyAYLEF8ggyOYVTMUF5s0S+oCjB5DfB3YItk6g8=;
 b=TLBvvwE/N9eLiETFd/+WRXIZU9adpJiaxCoOeQIex5PWzJsO9nuJ6LDOBcSyMyzNvH
 jMaa/SD7QtSDkBi3Ln4nPRwqqwxmPTDqz1qAv32Nx6zQZTPNvx+hbMJ9iiZXXBb4v1ah
 8GjkSsNNpmxq/5XBfUYdRWFQqVluJAmZKtExQtSIWmktZGUVsNH2WwHIqyZO8TxJoT8k
 JA+3mAdGzHWH3P98bz5udl2cIhwGhymDzpVgO47pj2mwb+Sg9xenCH6cETbG0QxAW5QM
 VMRhmNxGXVuEiGI6QD40AW44NWrIMzV2rXNNrpyXnyk3d9cuEKodGGl+nA07bhJ5VkdP
 0RMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794394992; x=1794999792;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LAt5IyAYLEF8ggyOYVTMUF5s0S+oCjB5DfB3YItk6g8=;
 b=RcPjNN2mLRdj21wPOMpoE1ovKoqaME8Jdgnbc/XOPW4EKXKMurQnXSavw6OvKRgYUz
 0O8lnQ7i3DQXDwhk0DfE3trZqVyYwT/5dEwYRtqxt3y8aC+NbhxV/FpI78BUyPT7IltF
 9NuGG8BCIssOXhY5SlfxRMT6rGndKO+mWBGRSpKZrbhw2Zpd53aXlClVGwUlqkhluBIY
 G+YRjA1tywq0nVDkuZpQiWcCXScxgpTQUh+K+/k0BdRcrVTwL7xaVwCNPtgyshHNdt/p
 bRm3FChLggn3qwDckTRHYtqGObsFL8sDyGqqPz6hv07T91yx5yYURuNbQ58cHstY3XTg
 63bg==
X-Gm-Message-State: APuU4Z+ISQ/nGRf9QRgC2XTcMLIGgAWlS39O4MMPrkE7DZS2Z2FsWHC2
 Mu8tbJ4FPkFvIjw9amgA6mPZqnkxN/wUww1wj7f0tXoKS8mHtTtUkDnvA+Vmph5ZP7tWL9N8Nlw
 G+0sjbeLrHmlfO2OKSu7y/fIUASEtmyhoSVKwwjWkFxdID4PfbE1W+XQkDKwOfx7qou/c
X-Gm-Gg: AYBFou3+YUoVDg+Q+AagSQQIpd9VVyrWPjw5IP+/cRBlJBX0GBgZXJTigwzyBob7XFV
 c0/U6kO+gHkz2WnVTXe5ump5yNbOA4BGtf+Q/4/U0X2DNj0Dw4ytWuUooWbgMwcayOXh021PLnH
 c/N5X4vBf68Z27W1hz9Dcd0dZR3euLhQLEUZYlmCEsuZYTIuehPloaOmKHW/XYYmHvS1qXlUUc2
 lHnOG49njJoHs1XrgUjOqwJkOGPSpjBMHD4BK+jMAB2EIob/Az9zxKZEg3VgTMNMvz4xIdFYVan
 DBdj17gap5rzGfv7ToTc9EQsOsgbyUaZ6yI11YBpRZpjvGr+iN4/xXD1WvYlIb7AvEhnk+UxCDQ
 AaHBGbsK7/3RiAj8poidaygg2OxtxICZ7mTiC0MjaY2ylVA72Z/EANMNgHAxCCC18n3pIlgKhAp
 LeLwZ+YucjeMoSf/I8Jvv9dsgeAsxxP0NwtPMT2ada0FVrI5ZpZdJKD6Ad1Gdo8+6OwMqzmoA/C
 H+Xp38X20sFWfv5oRLJtIVH/iEKpEJCzJFz3jCv2z8lmeTp36Y9kNkHzPGkBHlY758ste6xvKB8
 YiGsyaTrLj0vkM9oBqwPdS+ec3iym7ZjU3bi8i9dXxs1pNEC+lJf6DQYWcAQk14jxICJolDOR+b
 Lo1qDYnHQIE1YxAEn+sRtFdEgHfZ3sBHdinQ1mudJk3nqnZJonIAwOCu4e8QSFMA1lNhQuNdC4Q
 fRYPU5qCmTg6rFafY=
X-Received: by 2002:a05:6000:1861:b0:48b:1296:52ec with SMTP id
 ffacd0b85a97d-499c68d2bf7mr3820816f8f.18.1794394991597; 
 Wed, 11 Nov 2026 03:03:11 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498363dffa1sm10079680f8f.39.2026.11.11.03.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 03:03:10 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 11:03:08 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf
X-Gerrit-Change-Number: 2159
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2159?usp=email>
X-Gerrit-Commit: cfcfa546220d8c080dd4b07f6cd326808e2ae37b
In-Reply-To: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
References: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAwNzcyMDAwLkk1NzQ2OWNhNTBjNTUxYWQ0NzU1MTA2OTBlY2ZhMmQ1ZTdjZjljZmNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <eeea3915be08c34576ddc00a5b134324f6fcc75e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xR66o-000000003CR-2Fk7
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv: pass a
 lone config file to openvpn with --config
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
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4370265545114004778=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4370265545114004778==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SrbrxqNW8x0="; charset=UTF-8

--SrbrxqNW8x0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe=2E

H=
ello Antonio Quartulli, Arne Schwabe, 

I'd like you to reexamine a change=
=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=
=3Demail

to look at the new patch set (#3)=2E


Change subject: openvpnser=
v: pass a lone config file to openvpn with --config
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: pass a lone config fi=
le to openvpn with --config

openvpn=2Eexe takes a lone argument as the con=
fig file only when there
are no other arguments, but the service adds --msg=
-channel=2E Before
c139e82d openvpn=2Eexe rejected the config file for lack=
ing a leading
"--", since then it takes it as an extra parameter of --msg-c=
hannel and
ignores it=2E ValidateOptions() treated it as the config file, b=
ut only
ever returned FALSE for it=2E

Put --config in front of a lone non-=
option when building the command
line, so that ValidateOptions() checks wha=
t openvpn=2Eexe gets, and drop
its special case for a lone argument=2E

Cha=
nge-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf
Signed-off-by: Razvan Coj=
ocaru <razvanc@mailbox=2Eorg>
---
M src/openvpnserv/interactive=2Ec
M tests=
/unit_tests/openvpnserv/test_openvpnserv=2Ec
2 files changed, 78 insertions=
(+), 22 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/59/2159/3

diff --git a/src/openvpnserv/interactive=2Ec b/sr=
c/openvpnserv/interactive=2Ec
index 81205d6=2E=2E15a5e56 100644
--- a/src/o=
penvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -355,6 =
+355,44 @@
 }
 
 /*
+ * Build the command line openvpn is started with=2E o=
penvpn=2Eexe takes a lone
+ * argument as the config file only when there a=
re no other arguments, so a
+ * lone non-option gets a --config in front=2E=
 It is put in front of the
+ * unsplit options, so that they are split the =
same way with and without it=2E
+ * Returns the command line to be freed by=
 the caller, or NULL on error=2E
+ */
+static WCHAR *
+BuildCmdline(HANDLE =
svc_pipe, const WCHAR *options)
+{
+    size_t size =3D wcslen(options) + 1=
28;
+    WCHAR *cmdline =3D malloc(size * sizeof(*cmdline));
+    WCHAR **a=
rgv;
+    int argc;
+
+    if (!cmdline)
+    {
+        return NULL;
+    =
}
+
+    /* there seems to be no common printf specifier that works on all
=
+     * mingw/msvc platforms without trickery, so convert to void* and use
=
+     * PRIuPTR to print that as best compromise */
+    swprintf(cmdline, =
size, L"openvpn --msg-channel %" PRIuPTR L" %ls", (uintptr_t)svc_pipe,
+   =
          options);
+
+    /* "openvpn --msg-channel <handle> <arg>" */
+  =
  argv =3D CommandLineToArgvW(cmdline, &argc);
+    if (argv && argc =3D=3D=
 4 && !IsOption(argv[3]))
+    {
+        swprintf(cmdline, size, L"openvpn=
 --msg-channel %" PRIuPTR L" --config %ls",
+                 (uintptr_t)sv=
c_pipe, options);
+    }
+    LocalFree(argv);
+
+    return cmdline;
+}
+
=
+/*
  * Validate options against a white list=2E Also check the config_file=
 is
  * inside the config_dir=2E The white list is defined in validate=2Ec
=
  * The options are taken from the command line openvpn is started with,
@@=
 -396,20 +434,6 @@
         goto out;
     }
 
-    /*
-     * If only one =
argument, it is the config file
-     */
-    if (argc =3D=3D first + 1)
- =
   {
-        WCHAR *argv_tmp[2] =3D { L"--config", argv[first] };
-
-     =
   if (!CheckOption(workdir, 2, argv_tmp, &settings))
-        {
-         =
   swprintf(errmsg, capacity, msg1, argv[first], workdir, settings=2Eovpn_a=
dmin_group);
-        }
-        goto out;
-    }
-
     for (i =3D first; =
i < argc; ++i)
     {
         if (!IsOption(argv[i]))
@@ -3567,7 +3591,6 @=
@
                                   according to MSDN=2E */
     LPCWSTR e=
xe_path;
     WCHAR *cmdline =3D NULL;
-    size_t cmdline_size;
     undo_=
lists_t undo_lists;
     WCHAR errmsg[512] =3D L"";
     BOOL flush_pipe =
=3D TRUE;
@@ -3826,18 +3849,12 @@
         goto out;
     }
 
-    cmdline_=
size =3D wcslen(sud=2Eoptions) + 128;
-    cmdline =3D malloc(cmdline_size =
* sizeof(*cmdline));
+    cmdline =3D BuildCmdline(svc_pipe, sud=2Eoptions)=
;
     if (cmdline =3D=3D NULL)
     {
         ReturnLastError(pipe, L"mal=
loc");
         goto out;
     }
-    /* there seem to be no common printf =
specifier that works on all
-     * mingw/msvc platforms without trickery, =
so convert to void* and use
-     * PRIuPTR to print that as best compromis=
e */
-    swprintf(cmdline, cmdline_size, L"openvpn --msg-channel %" PRIuPT=
R L" %ls",
-             (uintptr_t)svc_pipe, sud=2Eoptions);
 
     /*
   =
   * Only authorized users are allowed to use any command line options or
d=
iff --git a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec b/tests/unit_=
tests/openvpnserv/test_openvpnserv=2Ec
index 20fb1af=2E=2E8d1e3e9 100644
--=
- a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
+++ b/tests/unit_test=
s/openvpnserv/test_openvpnserv=2Ec
@@ -301,6 +301,44 @@
     assert_merge_r=
esult(L"", L"", L"");
 }
 
+static void
+assert_cmdline(const WCHAR *option=
s, const WCHAR *expected, BOOL valid)
+{
+    WCHAR errmsg[512];
+    WCHAR=
 *cmdline =3D BuildCmdline((HANDLE)0x1, options);
+
+    assert_non_null(cm=
dline);
+    assert_int_equal(wcscmp(cmdline, expected), 0);
+    assert_in=
t_equal(ValidateOptions(NULL, settings=2Econfig_dir, cmdline, errmsg, _coun=
tof(errmsg)),
+                     valid);
+    free(cmdline);
+}
+
+stati=
c void
+test_build_validate_cmdline(void **state)
+{
+    wcscpy(settings=
=2Econfig_dir, L"C:\\OpenVPN\\config\\");
+    wcscpy(settings=2Eovpn_admin=
_group, L"OpenVPN Administrators");
+
+    /* a lone non-option is the conf=
ig file */
+    assert_cmdline(L"foo=2Eovpn", L"openvpn --msg-channel 1 --c=
onfig foo=2Eovpn", TRUE);
+    assert_cmdline(L"\"my vpn=2Eovpn\"", L"openv=
pn --msg-channel 1 --config \"my vpn=2Eovpn\"", TRUE);
+    assert_cmdline(=
L"=2E=2E\\evil=2Eovpn", L"openvpn --msg-channel 1 --config =2E=2E\\evil=2Eo=
vpn", FALSE);
+    assert_cmdline(L"stdin", L"openvpn --msg-channel 1 --con=
fig stdin", FALSE);
+
+    /* a lone option is checked against the white li=
st */
+    assert_cmdline(L"--script-security", L"openvpn --msg-channel 1 -=
-script-security", TRUE);
+    assert_cmdline(L"--persist-tun", L"openvpn -=
-msg-channel 1 --persist-tun", FALSE);
+    assert_cmdline(L"\"--persist-tu=
n\"", L"openvpn --msg-channel 1 \"--persist-tun\"", FALSE);
+
+    /* other=
 options are passed unchanged */
+    assert_cmdline(L"", L"openvpn --msg-c=
hannel 1 ", TRUE);
+    assert_cmdline(L"--config foo=2Eovpn --verb 3",
+  =
                 L"openvpn --msg-channel 1 --config foo=2Eovpn --verb 3", T=
RUE);
+
+    memset(&settings, 0, sizeof(settings));
+}
+
 int
 wmain(void)=

 {
@@ -311,6 +349,7 @@
         cmocka_unit_test(test_append_search_list),=

         cmocka_unit_test(test_remove_search_list_tokens),
         cmocka=
_unit_test(test_merge_openvpn_environment),
+        cmocka_unit_test(test_=
build_validate_cmdline),
     };
 
     int ret =3D cmocka_run_group_tests_=
name("openvpnserv tests", tests, NULL, NULL);

-- 
To view, visit https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf
Ge=
rrit-Change-Number: 2159
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <antonio@man=
delbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attention: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>

--SrbrxqNW8x0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe=2E </p>
<p>R=C4=83zva=
n Cojocaru <strong>uploaded patch set #3</strong> to this change=2E</p><p><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail">View=
 Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">openvpnserv: pass a lone config file to openvp=
n with --config<br><br>openvpn=2Eexe takes a lone argument as the config fi=
le only when there<br>are no other arguments, but the service adds --msg-ch=
annel=2E Before<br>c139e82d openvpn=2Eexe rejected the config file for lack=
ing a leading<br>&quot;--&quot;, since then it takes it as an extra paramet=
er of --msg-channel and<br>ignores it=2E ValidateOptions() treated it as th=
e config file, but only<br>ever returned FALSE for it=2E<br><br>Put --confi=
g in front of a lone non-option when building the command<br>line, so that =
ValidateOptions() checks what openvpn=2Eexe gets, and drop<br>its special c=
ase for a lone argument=2E<br><br>Change-Id: I57469ca50c551ad475510690ecfa2=
d5e7cf9cfcf<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
<br>---<br>M src/openvpnserv/interactive=2Ec<br>M tests/unit_tests/openvpns=
erv/test_openvpnserv=2Ec<br>2 files changed, 78 insertions(+), 22 deletions=
(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/59/2159/3</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interac=
tive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index 81205d6=2E=
=2E15a5e56 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</sp=
an><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -355,=
6 +355,44 @@</span><br><span> }</span><br><span> </span><br><span> /*</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Build the command line=
 openvpn is started with=2E openvpn=2Eexe takes a lone</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * argument as the config file only when=
 there are no other arguments, so a</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * lone non-option gets a --config in front=2E It is put in=
 front of the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * uns=
plit options, so that they are split the same way with and without it=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Returns the command=
 line to be freed by the caller, or NULL on error=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static WCHAR *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+BuildCmdline(HANDLE svc_pipe, const WCHAR *options)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    size_t size =3D wcslen(options) + 128;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR *cmdline =3D ma=
lloc(size * sizeof(*cmdline));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    WCHAR **argv;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    int argc;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!cmdline=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return NULL;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* there seems to be no common printf specifier that works o=
n all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * mingw/m=
svc platforms without trickery, so convert to void* and use</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * PRIuPTR to print that as bes=
t compromise */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
swprintf(cmdline, size, L&quot;openvpn --msg-channel %&quot; PRIuPTR L&quot=
; %ls&quot;, (uintptr_t)svc_pipe,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+             options);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* &quot;openvpn --msg-channel &lt;handle&gt; &lt;arg&gt;&quot; */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    argv =3D CommandLineTo=
ArgvW(cmdline, &amp;argc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (argv &amp;&amp; argc =3D=3D 4 &amp;&amp; !IsOption(argv[3]))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        swprintf(cmdline, size, L=
&quot;openvpn --msg-channel %&quot; PRIuPTR L&quot; --config %ls&quot;,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                 (uintp=
tr_t)svc_pipe, options);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Local=
Free(argv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return cmdline;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/*</span><br><span>  * Validate options against a white list=2E =
Also check the config_file is</span><br><span>  * inside the config_dir=2E =
The white list is defined in validate=2Ec</span><br><span>  * The options a=
re taken from the command line openvpn is started with,</span><br><span>@@ =
-396,20 +434,6 @@</span><br><span>         goto out;</span><br><span>     }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * If only one=
 argument, it is the config file</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (argc =3D=3D first + 1)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        WC=
HAR *argv_tmp[2] =3D { L&quot;--config&quot;, argv[first] };</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (!CheckOption(workdir, 2, argv_tmp, &amp;setti=
ngs))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            swprintf(errmsg,=
 capacity, msg1, argv[first], workdir, settings=2Eovpn_admin_group);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        goto out;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span>     for (i =3D first; i &lt; argc; ++i)</=
span><br><span>     {</span><br><span>         if (!IsOption(argv[i]))</spa=
n><br><span>@@ -3567,7 +3591,6 @@</span><br><span>                         =
          according to MSDN=2E */</span><br><span>     LPCWSTR exe_path;</s=
pan><br><span>     WCHAR *cmdline =3D NULL;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    size_t cmdline_size;</span><br><span>     undo_li=
sts_t undo_lists;</span><br><span>     WCHAR errmsg[512] =3D L&quot;&quot;;=
</span><br><span>     BOOL flush_pipe =3D TRUE;</span><br><span>@@ -3826,18=
 +3849,12 @@</span><br><span>         goto out;</span><br><span>     }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cmdl=
ine_size =3D wcslen(sud=2Eoptions) + 128;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    cmdline =3D malloc(cmdline_size * sizeof(*cmdline))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmdline =3D Bu=
ildCmdline(svc_pipe, sud=2Eoptions);</span><br><span>     if (cmdline =3D=
=3D NULL)</span><br><span>     {</span><br><span>         ReturnLastError(p=
ipe, L&quot;malloc&quot;);</span><br><span>         goto out;</span><br><sp=
an>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* there=
 seem to be no common printf specifier that works on all</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-     * mingw/msvc platforms without tric=
kery, so convert to void* and use</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-     * PRIuPTR to print that as best compromise */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    swprintf(cmdline, cmdline_size=
, L&quot;openvpn --msg-channel %&quot; PRIuPTR L&quot; %ls&quot;,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-             (uintptr_t)svc_pip=
e, sud=2Eoptions);</span><br><span> </span><br><span>     /*</span><br><spa=
n>      * Only authorized users are allowed to use any command line options=
 or</span><br><span>diff --git a/tests/unit_tests/openvpnserv/test_openvpns=
erv=2Ec b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec</span><br><span=
>index 20fb1af=2E=2E8d1e3e9 100644</span><br><span>--- a/tests/unit_tests/o=
penvpnserv/test_openvpnserv=2Ec</span><br><span>+++ b/tests/unit_tests/open=
vpnserv/test_openvpnserv=2Ec</span><br><span>@@ -301,6 +301,44 @@</span><br=
><span>     assert_merge_result(L&quot;&quot;, L&quot;&quot;, L&quot;&quot;=
);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+assert_cmdline(const WCHAR *options, const WCHAR *expected, BOO=
L valid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR errmsg[512];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR *cmdline =3D Bui=
ldCmdline((HANDLE)0x1, options);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_non_null(cmdline);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(wcscmp(cmdline, expected), 0);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ValidateOptions(NU=
LL, settings=2Econfig_dir, cmdline, errmsg, _countof(errmsg)),</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                     valid);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(cmdline);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+test_build_validate_cmdline(void **state)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    wcscpy(settings=2Econfig_dir, L&quot;C:\\OpenVPN\\config\\&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wcscpy(se=
ttings=2Eovpn_admin_group, L&quot;OpenVPN Administrators&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* a lone non-option is the config file */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_cmdline(L&q=
uot;foo=2Eovpn&quot;, L&quot;openvpn --msg-channel 1 --config foo=2Eovpn&qu=
ot;, TRUE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_cmdline(L&quot;\&quot;my vpn=2Eovpn\&quot;&quot;, L&quot;openvpn --msg-c=
hannel 1 --config \&quot;my vpn=2Eovpn\&quot;&quot;, TRUE);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_cmdline(L&quot;=2E=2E\\e=
vil=2Eovpn&quot;, L&quot;openvpn --msg-channel 1 --config =2E=2E\\evil=2Eov=
pn&quot;, FALSE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_cmdline(L&quot;stdin&quot;, L&quot;openvpn --msg-channel 1 --confi=
g stdin&quot;, FALSE);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a lone op=
tion is checked against the white list */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_cmdline(L&quot;--script-security&quot;, L&=
quot;openvpn --msg-channel 1 --script-security&quot;, TRUE);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_cmdline(L&quot;--persis=
t-tun&quot;, L&quot;openvpn --msg-channel 1 --persist-tun&quot;, FALSE);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_cmdline(L&q=
uot;\&quot;--persist-tun\&quot;&quot;, L&quot;openvpn --msg-channel 1 \&quo=
t;--persist-tun\&quot;&quot;, FALSE);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* other options are passed unchanged */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_cmdline(L&quot;&quot;, L&quot;openvpn --=
msg-channel 1 &quot;, TRUE);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_cmdline(L&quot;--config foo=2Eovpn --verb 3&quot;,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                   L&quo=
t;openvpn --msg-channel 1 --config foo=2Eovpn --verb 3&quot;, TRUE);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    memset(&amp;settings, 0, sizeof(settings)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><sp=
an> wmain(void)</span><br><span> {</span><br><span>@@ -311,6 +349,7 @@</spa=
n><br><span>         cmocka_unit_test(test_append_search_list),</span><br><=
span>         cmocka_unit_test(test_remove_search_list_tokens),</span><br><=
span>         cmocka_unit_test(test_merge_openvpn_environment),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_b=
uild_validate_cmdline),</span><br><span>     };</span><br><span> </span><br=
><span>     int ret =3D cmocka_run_group_tests_name(&quot;openvpnserv tests=
&quot;, tests, NULL, NULL);</span><br></pre><p>To view, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail">change 2159</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5=
7469ca50c551ad475510690ecfa2d5e7cf9cfcf </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2159 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojoc=
aru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--SrbrxqNW8x0=--


--===============4370265545114004778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4370265545114004778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4370265545114004778==--

