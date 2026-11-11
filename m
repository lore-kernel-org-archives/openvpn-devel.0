Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02F4606A327
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QMywNffX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Akq9yCdr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WmT+O7nB;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=UjLd/4gS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=//9OVJvVm8YrpBnBappUu9HHYetg3HnfAvxyEyJ19I4=; b=QMywNffX9JPMlZFG3JpNynSmIs
	+Lbm3cVoLYlAhN5YWdq+c53J5nfR3qaP37+HDHo8mWYM+Vevojtdu30Q2IzK/sRG0+/6cp0hnyT80
	VKy66LKl2iG39jX450n6IlC58BjX2+Fw4508okFqLtRMCIZD4hMsTJl0Nv1rm9BVURqY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR5pG-000000004MY-1gtH;
	Wed, 11 Nov 2026 10:45:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR5pE-000000004ML-4Bqp
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 10:45:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rbLRE8oCYo2NNqjqHN9Rhqn94NoXbhUCZC5+n2BaszM=; b=Akq9yCdrquNq5hi5T16l/An4eR
 BOpJDCrF79944AMDjM6zrqNqBlJil/34G4AVVrAlon4wwOx2YmBMYcaUzTZq868HpvO9OyEnfeHQ5
 i1DRJy3q7AoRMRiSFAH5dYNNfMkennl9j3SahQrYfNrqYXJxocJ4sfa7pmgTpi/ni02w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rbLRE8oCYo2NNqjqHN9Rhqn94NoXbhUCZC5+n2BaszM=; b=WmT+O7nBdKNLHYQvaZErbM8yJL
 Igig2X+Ch3aLeWKz7DEDf1tqgupQFQmvDhzXynTrWDIOhqk0Df6ziHSHe6kaKZMPAQy7m3Swv70+u
 wjB3hs3VgpSoVp69FnjuD0pwS+9MYb6KAsElObaxUAIKQDI7449SylLpE+6ncvYYoofo=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR5pD-000000002nN-0AKE for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 10:45:08 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so30465435e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 02:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794393900; x=1794998700; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rbLRE8oCYo2NNqjqHN9Rhqn94NoXbhUCZC5+n2BaszM=;
 b=UjLd/4gSGIQaVbnN3EsOx37/PDOJFl/nCN383V31Aa3EaVe7T58iyK5aqjRsnqdxeJ
 Br4LaeT9F+9xxtgFgkIjNr03/xEg9Kl5+N5/ojntIl8RiK3KjBrVhxg7wSkauiJfL6Id
 Ss6eaz0fq0AsmN6pbRRpLQJzpRZF84XKk+v+WYBpdo1bkQIf+To+ylzzK8WT/N/CUGf7
 hIaH0I9YZ9HlBP3whCgvPSjL9QIZMthfiUz4OSYSwgImNJTV2r+6OvYtDVqJFysVYWeV
 ubyKChlLCZZ0GTDtGIgxnThLSMlKwMgVSpwcz8PqS3X5wgOE0Y3UsFrcfjbGVwKvzleE
 +e5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794393900; x=1794998700;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rbLRE8oCYo2NNqjqHN9Rhqn94NoXbhUCZC5+n2BaszM=;
 b=jtsq9+mtqYbdzOm9+uNvUiEWiLQRGPD2Ms71vJo8K1lnAlipAeVkHAtWISabgGfLV9
 S1oIwBxl0BvEpTkHcquo4vwZhg9a+0tkTfyy6NJ4DU2Qj+HA21Uzwv12CDjKFKBbIzyO
 EjB6hkJ/ZwLr6lflbwCFYqNFvo5r5yzPOGpRc5RzoP4nM0cQ3laQx1xwPiZVgVaW9YJR
 TdR7J0OekvnP75yN2CS7//u53IdGsAozb2FWoEN7Qk4SZwEWMW8mV84MQocwn4JVqaXA
 9IOJWV4IQ82m4i6EHXXe2+w4rWiN5ZblBJH5ELV3QuZQITAlnBklexyy5SQmdQ/mK2id
 i1kw==
X-Gm-Message-State: APuU4Z8JfvXYPyb/MI8gTvU2DFQPsw/Va87cu3qM7g65ZpApM0zGB1Gr
 ddJyFNA3WCeqSBuAkrSXYMEyAc26tTF08gBebaczGBN/VDW/14VQcmCoRC/uS9hEh/PSqXXwqLf
 o0dLCAh4f88qrFdl9/ww01SsAeS/FcQ70q88d4qRknycqPmdr1iYLm9DEU+RLu8rXlx8W
X-Gm-Gg: AYBFou32xh3UwvqPrUzRMz/dmsRDbfoR9IMp1gDuOM3iuBX5iCrulVQzlGQmFsK30xQ
 glXwp/iH1yVOaUcoQJzGtjGUCQNz+cEJXXBOjJQmoptJN0XF3Bzpt75imvNlfUrmDrhvVHSyuda
 0M3wMCLFppUqfNNNgJU/nieGRTURmme3nk1raRqhnVzz2h4Z3MlUprybeKaWa/vITmmGWgC69KT
 7zJS6CivQFiCorQ5VfyWOBAbUMfI5CJCmwR9nbBy3BU7iWb78phjAthUeRiqNc9l4z3p14xroL5
 I0lUZDRIJur4zPDC9Z358EPIOllXs6sbE531fFKS/PMcGPkdxbrtLkQc/oBWxE7HKThVYuDoWXH
 aUABRDdJ5/vZUO1AKNqNXOxNMmH5RM1/nRHYdsBa50b64BMksaLhI6ISK38vAH5CsKCk0G4GMyS
 t4+yyD4nRxY+rn1oDEJt+qy6Qyj9ZUzpMiU+YnP/H+m9FQB93sjusA8elNkb4eewrMJcWnjHPq8
 Y7CDAwdnOEUJfVa29SlTtynEVSsXDF8Pu7b3d6hTGbIk2uZtvKqxCC/I9sq1kgDgl55IirI+T6C
 0arbuspCVsJ6SUT4CIPgYo8gW2e3+vqy5RYrX/LwHAF3xH3FuvOwMLhtxfQpi9rNyDLM5C2M+9y
 aMSHvSVgHh2ZUEpAaZ1lzmXHKFRUbrJ0ylkLcPV83ywHfv5MCdde62LD1DDrASUInICB7VpPR1Y
 gEMRl51teoMzTRBjM=
X-Received: by 2002:a05:600c:37c8:b0:4a7:6bc7:f778 with SMTP id
 5b1f17b1804b1-4ba093cd0b0mr35478055e9.30.1794393900263; 
 Wed, 11 Nov 2026 02:45:00 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba020433casm124778355e9.7.2026.11.11.02.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 02:44:59 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 10:44:58 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf
X-Gerrit-Change-Number: 2159
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2159?usp=email>
X-Gerrit-Commit: f4af39057c64d44f868638c8bf1f5614b184bbd2
In-Reply-To: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
References: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAwNzcyMDAwLkk1NzQ2OWNhNTBjNTUxYWQ0NzU1MTA2OTBlY2ZhMmQ1ZTdjZjljZmNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2e5d63e47f4efe5b41b8f9a1635b2309db560f04-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xR5pD-000000002nN-0AKE
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
Content-Type: multipart/mixed; boundary="===============4805604735314195127=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4805604735314195127==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="E538u7lmSqw="; charset=UTF-8

--E538u7lmSqw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, R=C4=
=83zvan Cojocaru=2E

Hello Antonio Quartulli, Arne Schwabe, 

I'd like you =
to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2159?usp=3Demail

to look at the new patch set (#2)=2E

The foll=
owing approvals got outdated and were removed:
Code-Review-1 by Antonio Qua=
rtulli


Change subject: openvpnserv: pass a lone config file to openvpn wi=
th --config
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

o=
penvpnserv: pass a lone config file to openvpn with --config

openvpn=2Eexe=
 takes a lone argument as the config file only when there
are no other argu=
ments, but the service adds --msg-channel=2E Before
c139e82d openvpn=2Eexe =
rejected the config file for lacking a leading
"--", since then it takes it=
 as an extra parameter of --msg-channel and
ignores it=2E ValidateOptions()=
 treated it as the config file, but only
ever returned FALSE for it=2E

Put=
 --config in front of a lone non-option when building the command
line, so =
that ValidateOptions() checks what openvpn=2Eexe gets, and drop
its special=
 case for a lone argument=2E

Change-Id: I57469ca50c551ad475510690ecfa2d5e7=
cf9cfcf
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/op=
envpnserv/interactive=2Ec
M tests/unit_tests/openvpnserv/test_openvpnserv=
=2Ec
2 files changed, 77 insertions(+), 22 deletions(-)


  git pull ssh://=
gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/59/2159/2

diff --git a/s=
rc/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index 8120=
5d6=2E=2Ef9e783a 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/ope=
nvpnserv/interactive=2Ec
@@ -355,6 +355,43 @@
 }
 
 /*
+ * Build the comman=
d line openvpn is started with=2E openvpn=2Eexe takes a lone
+ * argument a=
s the config file only when there are no other arguments, so a
+ * lone non=
-option gets a --config in front=2E It is put in front of the
+ * unsplit o=
ptions, so that they are split the same way with and without it=2E
+ * Retu=
rns the command line to be freed by the caller, or NULL on error=2E
+ */
+s=
tatic WCHAR *
+BuildCmdline(HANDLE svc_pipe, const WCHAR *options)
+{
+    =
/* there seem to be no common printf specifier that works on all
+     * mi=
ngw/msvc platforms without trickery, so convert to void* and use
+     * PR=
IuPTR to print that as best compromise */
+    const WCHAR *fmt =3D L"openv=
pn --msg-channel %" PRIuPTR L" %ls%ls";
+    size_t size =3D wcslen(options=
) + 128;
+    WCHAR *cmdline =3D malloc(size * sizeof(*cmdline));
+    WCHA=
R **argv;
+    int argc;
+
+    if (!cmdline)
+    {
+        return NULL;
=
+    }
+
+    swprintf(cmdline, size, fmt, (uintptr_t)svc_pipe, L"", option=
s);
+
+    /* "openvpn --msg-channel <handle> <arg>" */
+    argv =3D Comma=
ndLineToArgvW(cmdline, &argc);
+    if (argv && argc =3D=3D 4 && !IsOption(=
argv[3]))
+    {
+        swprintf(cmdline, size, fmt, (uintptr_t)svc_pipe,=
 L"--config ", options);
+    }
+    LocalFree(argv);
+
+    return cmdline=
;
+}
+
+/*
  * Validate options against a white list=2E Also check the conf=
ig_file is
  * inside the config_dir=2E The white list is defined in valida=
te=2Ec
  * The options are taken from the command line openvpn is started w=
ith,
@@ -396,20 +433,6 @@
         goto out;
     }
 
-    /*
-     * If on=
ly one argument, it is the config file
-     */
-    if (argc =3D=3D first =
+ 1)
-    {
-        WCHAR *argv_tmp[2] =3D { L"--config", argv[first] };
-=

-        if (!CheckOption(workdir, 2, argv_tmp, &settings))
-        {
-  =
          swprintf(errmsg, capacity, msg1, argv[first], workdir, settings=
=2Eovpn_admin_group);
-        }
-        goto out;
-    }
-
     for (i =
=3D first; i < argc; ++i)
     {
         if (!IsOption(argv[i]))
@@ -3567,=
7 +3590,6 @@
                                   according to MSDN=2E */
   =
  LPCWSTR exe_path;
     WCHAR *cmdline =3D NULL;
-    size_t cmdline_size;=

     undo_lists_t undo_lists;
     WCHAR errmsg[512] =3D L"";
     BOOL fl=
ush_pipe =3D TRUE;
@@ -3826,18 +3848,12 @@
         goto out;
     }
 
-   =
 cmdline_size =3D wcslen(sud=2Eoptions) + 128;
-    cmdline =3D malloc(cmdl=
ine_size * sizeof(*cmdline));
+    cmdline =3D BuildCmdline(svc_pipe, sud=
=2Eoptions);
     if (cmdline =3D=3D NULL)
     {
         ReturnLastError(=
pipe, L"malloc");
         goto out;
     }
-    /* there seem to be no com=
mon printf specifier that works on all
-     * mingw/msvc platforms without=
 trickery, so convert to void* and use
-     * PRIuPTR to print that as bes=
t compromise */
-    swprintf(cmdline, cmdline_size, L"openvpn --msg-channe=
l %" PRIuPTR L" %ls",
-             (uintptr_t)svc_pipe, sud=2Eoptions);
 
=
     /*
      * Only authorized users are allowed to use any command line o=
ptions or
diff --git a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec b/=
tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
index 20fb1af=2E=2E82c398=
e 100644
--- a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
+++ b/test=
s/unit_tests/openvpnserv/test_openvpnserv=2Ec
@@ -301,6 +301,44 @@
     ass=
ert_merge_result(L"", L"", L"");
 }
 
+static void
+assert_cmdline(const WC=
HAR *options, const WCHAR *expected, BOOL valid)
+{
+    WCHAR errmsg[512];=

+    WCHAR *cmdline =3D BuildCmdline((HANDLE)1, options);
+
+    assert_no=
n_null(cmdline);
+    assert_int_equal(wcscmp(cmdline, expected), 0);
+    =
assert_int_equal(ValidateOptions(NULL, settings=2Econfig_dir, cmdline, errm=
sg, _countof(errmsg)),
+                     valid);
+    free(cmdline);
+}=

+
+static void
+test_build_validate_cmdline(void **state)
+{
+    wcscpy(s=
ettings=2Econfig_dir, L"C:\\OpenVPN\\config\\");
+    wcscpy(settings=2Eovp=
n_admin_group, L"OpenVPN Administrators");
+
+    /* a lone non-option is t=
he config file */
+    assert_cmdline(L"foo=2Eovpn", L"openvpn --msg-channe=
l 1 --config foo=2Eovpn", TRUE);
+    assert_cmdline(L"\"my vpn=2Eovpn\"", =
L"openvpn --msg-channel 1 --config \"my vpn=2Eovpn\"", TRUE);
+    assert_c=
mdline(L"=2E=2E\\evil=2Eovpn", L"openvpn --msg-channel 1 --config =2E=2E\\e=
vil=2Eovpn", FALSE);
+    assert_cmdline(L"stdin", L"openvpn --msg-channel =
1 --config stdin", FALSE);
+
+    /* a lone option is checked against the w=
hite list */
+    assert_cmdline(L"--script-security", L"openvpn --msg-chan=
nel 1 --script-security", TRUE);
+    assert_cmdline(L"--persist-tun", L"op=
envpn --msg-channel 1 --persist-tun", FALSE);
+    assert_cmdline(L"\"--per=
sist-tun\"", L"openvpn --msg-channel 1 \"--persist-tun\"", FALSE);
+
+    /=
* other options are passed unchanged */
+    assert_cmdline(L"", L"openvpn =
--msg-channel 1 ", TRUE);
+    assert_cmdline(L"--config foo=2Eovpn --verb =
3",
+                   L"openvpn --msg-channel 1 --config foo=2Eovpn --ver=
b 3", TRUE);
+
+    memset(&settings, 0, sizeof(settings));
+}
+
 int
 wmai=
n(void)
 {
@@ -311,6 +349,7 @@
         cmocka_unit_test(test_append_search=
_list),
         cmocka_unit_test(test_remove_search_list_tokens),
        =
 cmocka_unit_test(test_merge_openvpn_environment),
+        cmocka_unit_tes=
t(test_build_validate_cmdline),
     };
 
     int ret =3D cmocka_run_group=
_tests_name("openvpnserv tests", tests, NULL, NULL);

-- 
To view, visit ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9=
cfcf
Gerrit-Change-Number: 2159
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zva=
n Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <anto=
nio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attention=
: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>

--E538u7lmSqw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, R=C4=83zvan Cojocaru=
=2E </p>
<p>R=C4=83zvan Cojocaru <strong>uploaded patch set #2</strong> to =
this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2159?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review-1 by Antonio Quartulli</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">ope=
nvpnserv: pass a lone config file to openvpn with --config<br><br>openvpn=
=2Eexe takes a lone argument as the config file only when there<br>are no o=
ther arguments, but the service adds --msg-channel=2E Before<br>c139e82d op=
envpn=2Eexe rejected the config file for lacking a leading<br>&quot;--&quot=
;, since then it takes it as an extra parameter of --msg-channel and<br>ign=
ores it=2E ValidateOptions() treated it as the config file, but only<br>eve=
r returned FALSE for it=2E<br><br>Put --config in front of a lone non-optio=
n when building the command<br>line, so that ValidateOptions() checks what =
openvpn=2Eexe gets, and drop<br>its special case for a lone argument=2E<br>=
<br>Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf<br>Signed-off-by: =
Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpnserv/i=
nteractive=2Ec<br>M tests/unit_tests/openvpnserv/test_openvpnserv=2Ec<br>2 =
files changed, 77 insertions(+), 22 deletions(-)<br><br></pre><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/59/2159/2=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/int=
eractive=2Ec</span><br><span>index 81205d6=2E=2Ef9e783a 100644</span><br><s=
pan>--- a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/openvpn=
serv/interactive=2Ec</span><br><span>@@ -355,6 +355,43 @@</span><br><span> =
}</span><br><span> </span><br><span> /*</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Build the command line openvpn is started with=2E op=
envpn=2Eexe takes a lone</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * argument as the config file only when there are no other arguments,=
 so a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * lone non-op=
tion gets a --config in front=2E It is put in front of the</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * unsplit options, so that they are=
 split the same way with and without it=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Returns the command line to be freed by the calle=
r, or NULL on error=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static WCHAR =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+BuildCmdline(HANDL=
E svc_pipe, const WCHAR *options)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* there seem to be no common printf specifier that works on all</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * mingw/msvc platforms wi=
thout trickery, so convert to void* and use</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * PRIuPTR to print that as best compromise */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const WCHAR *fmt=
 =3D L&quot;openvpn --msg-channel %&quot; PRIuPTR L&quot; %ls%ls&quot;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t size =3D wcs=
len(options) + 128;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    WCHAR *cmdline =3D malloc(size * sizeof(*cmdline));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    WCHAR **argv;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int argc;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!cmdline)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    swprintf(cmdline, size, fmt, (uintp=
tr_t)svc_pipe, L&quot;&quot;, options);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* &quot;openvpn --msg-channel &lt;handle&gt; &lt;arg&gt;&quot; */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv =3D CommandLin=
eToArgvW(cmdline, &amp;argc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (argv &amp;&amp; argc =3D=3D 4 &amp;&amp; !IsOption(argv[3=
]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        swprintf(cmdline, size=
, fmt, (uintptr_t)svc_pipe, L&quot;--config &quot;, options);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    LocalFree(argv);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return cmdline;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span>  * Vali=
date options against a white list=2E Also check the config_file is</span><b=
r><span>  * inside the config_dir=2E The white list is defined in validate=
=2Ec</span><br><span>  * The options are taken from the command line openvp=
n is started with,</span><br><span>@@ -396,20 +433,6 @@</span><br><span>   =
      goto out;</span><br><span>     }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    /*</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-     * If only one argument, it is the config file</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (argc =3D=3D first + 1)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        WCHAR *argv_tmp[2] =3D { L&quot;--confi=
g&quot;, argv[first] };</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!CheckO=
ption(workdir, 2, argv_tmp, &amp;settings))</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            swprintf(errmsg, capacity, msg1, argv[first], workdir=
, settings=2Eovpn_admin_group);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      goto out;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     =
for (i =3D first; i &lt; argc; ++i)</span><br><span>     {</span><br><span>=
         if (!IsOption(argv[i]))</span><br><span>@@ -3567,7 +3590,6 @@</spa=
n><br><span>                                   according to MSDN=2E */</spa=
n><br><span>     LPCWSTR exe_path;</span><br><span>     WCHAR *cmdline =3D =
NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t cmdli=
ne_size;</span><br><span>     undo_lists_t undo_lists;</span><br><span>    =
 WCHAR errmsg[512] =3D L&quot;&quot;;</span><br><span>     BOOL flush_pipe =
=3D TRUE;</span><br><span>@@ -3826,18 +3848,12 @@</span><br><span>         =
goto out;</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    cmdline_size =3D wcslen(sud=2Eoptions) + 1=
28;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cmdline =3D ma=
lloc(cmdline_size * sizeof(*cmdline));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    cmdline =3D BuildCmdline(svc_pipe, sud=2Eoptions);</=
span><br><span>     if (cmdline =3D=3D NULL)</span><br><span>     {</span><=
br><span>         ReturnLastError(pipe, L&quot;malloc&quot;);</span><br><sp=
an>         goto out;</span><br><span>     }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    /* there seem to be no common printf specifier t=
hat works on all</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
* mingw/msvc platforms without trickery, so convert to void* and use</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-     * PRIuPTR to print that=
 as best compromise */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    swprintf(cmdline, cmdline_size, L&quot;openvpn --msg-channel %&quot; P=
RIuPTR L&quot; %ls&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-             (uintptr_t)svc_pipe, sud=2Eoptions);</span><br><span> </sp=
an><br><span>     /*</span><br><span>      * Only authorized users are allo=
wed to use any command line options or</span><br><span>diff --git a/tests/u=
nit_tests/openvpnserv/test_openvpnserv=2Ec b/tests/unit_tests/openvpnserv/t=
est_openvpnserv=2Ec</span><br><span>index 20fb1af=2E=2E82c398e 100644</span=
><br><span>--- a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec</span><b=
r><span>+++ b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec</span><br><=
span>@@ -301,6 +301,44 @@</span><br><span>     assert_merge_result(L&quot;&=
quot;, L&quot;&quot;, L&quot;&quot;);</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+assert_cmdline(const WCHAR *=
options, const WCHAR *expected, BOOL valid)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    WCHAR errmsg[512];</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    WCHAR *cmdline =3D BuildCmdline((HANDLE)1, options);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_non_null(cmdline);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(wcscmp(cmdline, e=
xpected), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_int_equal(ValidateOptions(NULL, settings=2Econfig_dir, cmdline, errmsg=
, _countof(errmsg)),</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                     valid);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    free(cmdline);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+test_build_validate_cmdline(void **s=
tate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    wcscpy(settings=2Econfig_dir=
, L&quot;C:\\OpenVPN\\config\\&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    wcscpy(settings=2Eovpn_admin_group, L&quot;OpenVPN A=
dministrators&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a lone non=
-option is the config file */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_cmdline(L&quot;foo=2Eovpn&quot;, L&quot;openvpn --msg-=
channel 1 --config foo=2Eovpn&quot;, TRUE);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_cmdline(L&quot;\&quot;my vpn=2Eovpn\&quo=
t;&quot;, L&quot;openvpn --msg-channel 1 --config \&quot;my vpn=2Eovpn\&quo=
t;&quot;, TRUE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_cmdline(L&quot;=2E=2E\\evil=2Eovpn&quot;, L&quot;openvpn --msg-chan=
nel 1 --config =2E=2E\\evil=2Eovpn&quot;, FALSE);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_cmdline(L&quot;stdin&quot;, L&quot=
;openvpn --msg-channel 1 --config stdin&quot;, FALSE);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* a lone option is checked against the white list */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_cmdline(L&=
quot;--script-security&quot;, L&quot;openvpn --msg-channel 1 --script-secur=
ity&quot;, TRUE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_cmdline(L&quot;--persist-tun&quot;, L&quot;openvpn --msg-channel 1=
 --persist-tun&quot;, FALSE);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_cmdline(L&quot;\&quot;--persist-tun\&quot;&quot;, L&qu=
ot;openvpn --msg-channel 1 \&quot;--persist-tun\&quot;&quot;, FALSE);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* other options are passed unchanged */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_cmdline(=
L&quot;&quot;, L&quot;openvpn --msg-channel 1 &quot;, TRUE);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_cmdline(L&quot;--config=
 foo=2Eovpn --verb 3&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                   L&quot;openvpn --msg-channel 1 --config foo=2Eov=
pn --verb 3&quot;, TRUE);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memset(&a=
mp;settings, 0, sizeof(settings));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> int</span><br><span> wmain(void)</span><br><span> {</span><b=
r><span>@@ -311,6 +349,7 @@</span><br><span>         cmocka_unit_test(test_=
append_search_list),</span><br><span>         cmocka_unit_test(test_remove_=
search_list_tokens),</span><br><span>         cmocka_unit_test(test_merge_o=
penvpn_environment),</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        cmocka_unit_test(test_build_validate_cmdline),</span><br><span>   =
  };</span><br><span> </span><br><span>     int ret =3D cmocka_run_group_te=
sts_name(&quot;openvpnserv tests&quot;, tests, NULL, NULL);</span><br></pre=
><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
59?usp=3Demail">change 2159</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2159?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpat=
chset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<d=
iv style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf </div=
>
<div style=3D"display:none"> Gerrit-Change-Number: 2159 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> G=
errit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@man=
delbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne =
Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: Antonio Quartulli &=
lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>

</body></html>
--E538u7lmSqw=--


--===============4805604735314195127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4805604735314195127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4805604735314195127==--

