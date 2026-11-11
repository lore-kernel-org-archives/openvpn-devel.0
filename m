Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A95F606A331
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 11:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=id4u+Jbk;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=h8sO+AZq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YKSpvfjI;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dSxJFbNE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3NMRboim9GE6fLcJtENnokLQbJThm26do79DnIawivI=; b=id4u+JbkmywV/NeeIsqDWG4iK+
	Hnr65te394XdSjhfghyWTbqsuIpSFxXGg+A+7zTlhArNDn3bQzs4czOV0dVjWEg0lDFgEWkQCkAxu
	8Vjx++8elRjjSFAJg6LE7iFwp+Hkj4tYX0irgZjiuKo/emwc1KhlRwlIfxZr4boChaWo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR6CH-000000008GF-3wD7;
	Wed, 11 Nov 2026 11:08:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR6CG-000000008G5-0Dr0
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 11:08:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RZ/INgd7/1N/r/sLpF/No4SsB+aOwDe1IrFzcnvD0yA=; b=h8sO+AZqtP5B4Rc0n3BQ955QNd
 OsuMJxKNfkJeFEQUwU/dWPgwZSA62lmsw9ZKN5+toKAuYWwUuiCgbCYPNHcXYRia6UV4hRQNYQj0O
 uQVWcegBvIl0lu3jpRvYwST9UwTJx8YFtvhKVb10rVgKTUrpYFSyVO+h7j1iSyZjibNU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RZ/INgd7/1N/r/sLpF/No4SsB+aOwDe1IrFzcnvD0yA=; b=YKSpvfjI1ajn+73KgTXcNU2yVB
 ykG6xIRA8JRxcecQjHqDhXrXyVSlNmnSkj9MKWfOMYKtlxSsnf6zC8eOmB5/r9U9CbDyNSDcywB5e
 0Fir5hAwt0ly56WdYqbfeI7pd82+pvGC7oZVu5wOaACJnA6mhdJKupNkWrRglUR4Ruhg=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR6CE-000000005SH-2jej for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 11:08:55 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-490585eddfcso2371951f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 03:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794395328; x=1795000128; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RZ/INgd7/1N/r/sLpF/No4SsB+aOwDe1IrFzcnvD0yA=;
 b=dSxJFbNESc1h9Jxr84A7nyj/bO6TOK3dIqw30nT1shxram2vjha2UfqcdKVuG9CntX
 Y0L7QFcMaUjDMlHCjPVHHSTcCiciP5V0Qkw52wPG4XT8qzO8gWEZk37Jnrrer6vQoC5O
 46DtMR2AeeSwN+Ur2XGXE8dnJLBeh2WkLMjAdv6rsR4+sde/crOu67CYLeZgXah14uQK
 H0PZpj6VSlRnSN1amlCJG/R4lmnAbwbznGdVeCVvV1Yo8bd/1i8T1jy1063ZPFFOpvkM
 F1BWDuX0Kjn2EPdFRVe8WMfOR9Ij2sXe+ZVeAQapfS4PDLpw0ret6msG+zW0LIYYND7a
 j8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794395328; x=1795000128;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RZ/INgd7/1N/r/sLpF/No4SsB+aOwDe1IrFzcnvD0yA=;
 b=jj/CqZC+oce2Y2+/zHeson3sgsi5vslDzwoKHkcdZwVSFdMWsBMcdTGiRFVvf3H9ce
 S8Py9JnnxF4kS5TAGNrDft84U4is9twZjpp4stb1fbAjiY93whfLi9VK8vmpAD08/TRD
 prtlnyOar7dZy++qurycBMV5JF2ZuLBRnpf4dfsRiCBkAHfVrWGokbslUn8sqzfVNEZn
 vjmw+X/igFzIJIdV1W9AdYv+XmCXbVzM4ukL7RXGF5pROdKDrlt10aogwasjk0LscwXB
 MaJc/h9cvzJ1dbNXFyMjQxBiyO7RHeM0qAR7iY7werXyjtqzl2AIpX+fkE2hdxoh9Gwr
 Dxdg==
X-Gm-Message-State: APuU4Z+6OCj3gndSFhA7HAZpumDFYpwVUK0qspQ3RcquMBkxP7AeNFoC
 xixyKCh6W9zngl2YQH3FcaD1GO4m3Oj7Fv+t+kk2Al7sDSDoGCC9wumnP4P7ZOfVcU287pq20lo
 HpuCqfhftgn5MtwD15/4Jo75mMIBNIgGTEc3m0ocoxXSLVqRRwMnZMCgjpIJnM7nXt7DS
X-Gm-Gg: AYBFou2hYeXLkqnNti/7AkSeXn/4MHTxknvvZhTiEpNXtIM4Z9QATRCHR3KsYMVnEqF
 WOJlda3J1gASgjbkqh5kFX/EtBfl/+ehCkiMk4GDoaQA3qslTm16UbCpxgX+Sx150F4eSKHvGns
 qLkiqqTjswuDjHRoCI8oMTPcya1w2rKefiw+OIymmXwhGeG8P04dfsUcih4aVOMj8x/CSd8Czan
 UEMVNDjOw5wbFMm3v0CMVPdLPMnQOy37qUXNaneFk0bGByNAJY2xlVl1NbUZ0rfZZVJm8CsGAUs
 AzDSQF66DR8sLM1W2+e0CP0PSlhvCx886iqasPm8T+hj9HCPDdQoMRQ4l1KLTbi+emMXd2klowF
 qLotHH8FEQGtp7fIhRr1yWc/vp4i95VrZPPBI5DbYJ9yonmGQiNz/hOZ7oq3NrCARueMdQnkztQ
 UZ3+SnDmF39jGdzeqiKk/HIsml+6npDIatOxfuyb9U1ybJhTkDp91QEH6GJHRVehmST9tgbYLFi
 ZOc93AjqCqwTI/U7Z25CV1ale8KMFzmI6g32ilk9PRIGlaDPjMgBsDQeHWFJ9klo3bkbN9gtaLV
 wMF2RCAoRcEZfAMoB6LQ1a1gkenX0y6jczwXOr6QLJIM0eMVtg8tcN2zGHahp/e0HQ705x4+T2R
 9e4Efu4o05phXqV1Hd26g9Ni7ru3E32tA99+NvDi+rFmw9sFHSPY7uzxNYQh2nlCk0+GEk1sgs0
 ZPVxB/icV0XRIv5rM=
X-Received: by 2002:a05:6000:4a15:b0:491:68e2:bf2f with SMTP id
 ffacd0b85a97d-499c7ef514amr2929515f8f.52.1794395327754; 
 Wed, 11 Nov 2026 03:08:47 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498365cbeedsm10327498f8f.43.2026.11.11.03.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 03:08:47 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 11:08:46 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf
X-Gerrit-Change-Number: 2159
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2159?usp=email>
X-Gerrit-Commit: 5d019414bc457a8c6d3e9d4bffeb2fe456a44ec0
In-Reply-To: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
References: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAwNzcyMDAwLkk1NzQ2OWNhNTBjNTUxYWQ0NzU1MTA2OTBlY2ZhMmQ1ZTdjZjljZmNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4066a1e2a304efcf9c080f6fb277661863c4283b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xR6CE-000000005SH-2jej
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
Content-Type: multipart/mixed; boundary="===============0936450687502064428=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0936450687502064428==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="u9s5sKV0V1U="; charset=UTF-8

--u9s5sKV0V1U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe=2E

H=
ello Antonio Quartulli, Arne Schwabe, 

I'd like you to reexamine a change=
=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=
=3Demail

to look at the new patch set (#4)=2E


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
2 files changed, 76 insertions=
(+), 22 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/59/2159/4

diff --git a/src/openvpnserv/interactive=2Ec b/sr=
c/openvpnserv/interactive=2Ec
index 81205d6=2E=2E179e9f6 100644
--- a/src/o=
penvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -355,6 =
+355,42 @@
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
+    /* openvpn parses the handle with atoll(), so print it as a decima=
l number */
+    swprintf(cmdline, size, L"openvpn --msg-channel %" PRIuPTR=
 L" %ls", (uintptr_t)svc_pipe,
+             options);
+
+    /* "openvpn -=
-msg-channel <handle> <arg>" */
+    argv =3D CommandLineToArgvW(cmdline, &=
argc);
+    if (argv && argc =3D=3D 4 && !IsOption(argv[3]))
+    {
+      =
  swprintf(cmdline, size, L"openvpn --msg-channel %" PRIuPTR L" --config %l=
s",
+                 (uintptr_t)svc_pipe, options);
+    }
+    LocalFree(=
argv);
+
+    return cmdline;
+}
+
+/*
  * Validate options against a white=
 list=2E Also check the config_file is
  * inside the config_dir=2E The whi=
te list is defined in validate=2Ec
  * The options are taken from the comma=
nd line openvpn is started with,
@@ -396,20 +432,6 @@
         goto out;
  =
   }
 
-    /*
-     * If only one argument, it is the config file
-     */=

-    if (argc =3D=3D first + 1)
-    {
-        WCHAR *argv_tmp[2] =3D { L=
"--config", argv[first] };
-
-        if (!CheckOption(workdir, 2, argv_tmp=
, &settings))
-        {
-            swprintf(errmsg, capacity, msg1, argv=
[first], workdir, settings=2Eovpn_admin_group);
-        }
-        goto ou=
t;
-    }
-
     for (i =3D first; i < argc; ++i)
     {
         if (!IsOp=
tion(argv[i]))
@@ -3567,7 +3589,6 @@
                                   acc=
ording to MSDN=2E */
     LPCWSTR exe_path;
     WCHAR *cmdline =3D NULL;
-=
    size_t cmdline_size;
     undo_lists_t undo_lists;
     WCHAR errmsg[51=
2] =3D L"";
     BOOL flush_pipe =3D TRUE;
@@ -3826,18 +3847,12 @@
        =
 goto out;
     }
 
-    cmdline_size =3D wcslen(sud=2Eoptions) + 128;
-   =
 cmdline =3D malloc(cmdline_size * sizeof(*cmdline));
+    cmdline =3D Buil=
dCmdline(svc_pipe, sud=2Eoptions);
     if (cmdline =3D=3D NULL)
     {
   =
      ReturnLastError(pipe, L"malloc");
         goto out;
     }
-    /* t=
here seem to be no common printf specifier that works on all
-     * mingw/=
msvc platforms without trickery, so convert to void* and use
-     * PRIuPT=
R to print that as best compromise */
-    swprintf(cmdline, cmdline_size, =
L"openvpn --msg-channel %" PRIuPTR L" %ls",
-             (uintptr_t)svc_pi=
pe, sud=2Eoptions);
 
     /*
      * Only authorized users are allowed to =
use any command line options or
diff --git a/tests/unit_tests/openvpnserv/t=
est_openvpnserv=2Ec b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
ind=
ex 20fb1af=2E=2E8d1e3e9 100644
--- a/tests/unit_tests/openvpnserv/test_open=
vpnserv=2Ec
+++ b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
@@ -301=
,6 +301,44 @@
     assert_merge_result(L"", L"", L"");
 }
 
+static void
+a=
ssert_cmdline(const WCHAR *options, const WCHAR *expected, BOOL valid)
+{
+=
    WCHAR errmsg[512];
+    WCHAR *cmdline =3D BuildCmdline((HANDLE)0x1, op=
tions);
+
+    assert_non_null(cmdline);
+    assert_int_equal(wcscmp(cmdli=
ne, expected), 0);
+    assert_int_equal(ValidateOptions(NULL, settings=2Ec=
onfig_dir, cmdline, errmsg, _countof(errmsg)),
+                     valid)=
;
+    free(cmdline);
+}
+
+static void
+test_build_validate_cmdline(void *=
*state)
+{
+    wcscpy(settings=2Econfig_dir, L"C:\\OpenVPN\\config\\");
+ =
   wcscpy(settings=2Eovpn_admin_group, L"OpenVPN Administrators");
+
+    /=
* a lone non-option is the config file */
+    assert_cmdline(L"foo=2Eovpn"=
, L"openvpn --msg-channel 1 --config foo=2Eovpn", TRUE);
+    assert_cmdlin=
e(L"\"my vpn=2Eovpn\"", L"openvpn --msg-channel 1 --config \"my vpn=2Eovpn\=
"", TRUE);
+    assert_cmdline(L"=2E=2E\\evil=2Eovpn", L"openvpn --msg-chan=
nel 1 --config =2E=2E\\evil=2Eovpn", FALSE);
+    assert_cmdline(L"stdin", =
L"openvpn --msg-channel 1 --config stdin", FALSE);
+
+    /* a lone option =
is checked against the white list */
+    assert_cmdline(L"--script-securit=
y", L"openvpn --msg-channel 1 --script-security", TRUE);
+    assert_cmdlin=
e(L"--persist-tun", L"openvpn --msg-channel 1 --persist-tun", FALSE);
+    =
assert_cmdline(L"\"--persist-tun\"", L"openvpn --msg-channel 1 \"--persist-=
tun\"", FALSE);
+
+    /* other options are passed unchanged */
+    assert=
_cmdline(L"", L"openvpn --msg-channel 1 ", TRUE);
+    assert_cmdline(L"--c=
onfig foo=2Eovpn --verb 3",
+                   L"openvpn --msg-channel 1 -=
-config foo=2Eovpn --verb 3", TRUE);
+
+    memset(&settings, 0, sizeof(set=
tings));
+}
+
 int
 wmain(void)
 {
@@ -311,6 +349,7 @@
         cmocka_unit=
_test(test_append_search_list),
         cmocka_unit_test(test_remove_searc=
h_list_tokens),
         cmocka_unit_test(test_merge_openvpn_environment),
=
+        cmocka_unit_test(test_build_validate_cmdline),
     };
 
     int =
ret =3D cmocka_run_group_tests_name("openvpnserv tests", tests, NULL, NULL)=
;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I57469ca50c=
551ad475510690ecfa2d5e7cf9cfcf
Gerrit-Change-Number: 2159
Gerrit-PatchSet: =
4
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewe=
r: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-Attention: Antonio Quartulli <antonio@mandelb=
it=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--u9s5sKV0V1U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe=2E </p>
<p>R=C4=83zva=
n Cojocaru <strong>uploaded patch set #4</strong> to this change=2E</p><p><=
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
erv/test_openvpnserv=2Ec<br>2 files changed, 76 insertions(+), 22 deletions=
(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/59/2159/4</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interac=
tive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index 81205d6=2E=
=2E179e9f6 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</sp=
an><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -355,=
6 +355,42 @@</span><br><span> }</span><br><span> </span><br><span> /*</span=
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
%, 40%);">+    /* openvpn parses the handle with atoll(), so print it as a =
decimal number */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  swprintf(cmdline, size, L&quot;openvpn --msg-channel %&quot; PRIuPTR L&qu=
ot; %ls&quot;, (uintptr_t)svc_pipe,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+             options);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* &quot;openvpn --msg-channel &lt;handle&gt; &lt;arg&gt;&quot; */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv =3D CommandLine=
ToArgvW(cmdline, &amp;argc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (argv &amp;&amp; argc =3D=3D 4 &amp;&amp; !IsOption(argv[3]=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        swprintf(cmdline, size,=
 L&quot;openvpn --msg-channel %&quot; PRIuPTR L&quot; --config %ls&quot;,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 (uin=
tptr_t)svc_pipe, options);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Loc=
alFree(argv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return cmdline;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/*</span><br><span>  * Validate options against a white list=
=2E Also check the config_file is</span><br><span>  * inside the config_dir=
=2E The white list is defined in validate=2Ec</span><br><span>  * The optio=
ns are taken from the command line openvpn is started with,</span><br><span=
>@@ -396,20 +432,6 @@</span><br><span>         goto out;</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * If only=
 one argument, it is the config file</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (argc =3D=3D first + 1)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  WCHAR *argv_tmp[2] =3D { L&quot;--config&quot;, argv[first] };</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        if (!CheckOption(workdir, 2, argv_tmp, &amp;s=
ettings))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            swprintf(err=
msg, capacity, msg1, argv[first], workdir, settings=2Eovpn_admin_group);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        goto out;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span>     for (i =3D first; i &lt; argc; ++i=
)</span><br><span>     {</span><br><span>         if (!IsOption(argv[i]))</=
span><br><span>@@ -3567,7 +3589,6 @@</span><br><span>                      =
             according to MSDN=2E */</span><br><span>     LPCWSTR exe_path;=
</span><br><span>     WCHAR *cmdline =3D NULL;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    size_t cmdline_size;</span><br><span>     undo=
_lists_t undo_lists;</span><br><span>     WCHAR errmsg[512] =3D L&quot;&quo=
t;;</span><br><span>     BOOL flush_pipe =3D TRUE;</span><br><span>@@ -3826=
,18 +3847,12 @@</span><br><span>         goto out;</span><br><span>     }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c=
mdline_size =3D wcslen(sud=2Eoptions) + 128;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    cmdline =3D malloc(cmdline_size * sizeof(*cmdlin=
e));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmdline =3D=
 BuildCmdline(svc_pipe, sud=2Eoptions);</span><br><span>     if (cmdline =
=3D=3D NULL)</span><br><span>     {</span><br><span>         ReturnLastErro=
r(pipe, L&quot;malloc&quot;);</span><br><span>         goto out;</span><br>=
<span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* th=
ere seem to be no common printf specifier that works on all</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-     * mingw/msvc platforms without t=
rickery, so convert to void* and use</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-     * PRIuPTR to print that as best compromise */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    swprintf(cmdline, cmdline_s=
ize, L&quot;openvpn --msg-channel %&quot; PRIuPTR L&quot; %ls&quot;,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-             (uintptr_t)svc_=
pipe, sud=2Eoptions);</span><br><span> </span><br><span>     /*</span><br><=
span>      * Only authorized users are allowed to use any command line opti=
ons or</span><br><span>diff --git a/tests/unit_tests/openvpnserv/test_openv=
pnserv=2Ec b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec</span><br><s=
pan>index 20fb1af=2E=2E8d1e3e9 100644</span><br><span>--- a/tests/unit_test=
s/openvpnserv/test_openvpnserv=2Ec</span><br><span>+++ b/tests/unit_tests/o=
penvpnserv/test_openvpnserv=2Ec</span><br><span>@@ -301,6 +301,44 @@</span>=
<br><span>     assert_merge_result(L&quot;&quot;, L&quot;&quot;, L&quot;&qu=
ot;);</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+assert_cmdline(const WCHAR *options, const WCHAR *expected, =
BOOL valid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR errmsg[512];</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR *cmdline =3D =
BuildCmdline((HANDLE)0x1, options);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_non_null(cmdline);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(wcscmp(cmdline, expected), 0);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ValidateOptions=
(NULL, settings=2Econfig_dir, cmdline, errmsg, _countof(errmsg)),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                     valid);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(cmdline);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+test_build_validate_cmdline(void **state)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    wcscpy(settings=2Econfig_dir, L&quot;C:\\OpenVPN\\config\\=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wcscpy(=
settings=2Eovpn_admin_group, L&quot;OpenVPN Administrators&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* a lone non-option is the config file */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_cmdline(L=
&quot;foo=2Eovpn&quot;, L&quot;openvpn --msg-channel 1 --config foo=2Eovpn&=
quot;, TRUE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_cmdline(L&quot;\&quot;my vpn=2Eovpn\&quot;&quot;, L&quot;openvpn --msg=
-channel 1 --config \&quot;my vpn=2Eovpn\&quot;&quot;, TRUE);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_cmdline(L&quot;=2E=2E\=
\evil=2Eovpn&quot;, L&quot;openvpn --msg-channel 1 --config =2E=2E\\evil=2E=
ovpn&quot;, FALSE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_cmdline(L&quot;stdin&quot;, L&quot;openvpn --msg-channel 1 --con=
fig stdin&quot;, FALSE);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a lone =
option is checked against the white list */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_cmdline(L&quot;--script-security&quot;, =
L&quot;openvpn --msg-channel 1 --script-security&quot;, TRUE);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_cmdline(L&quot;--pers=
ist-tun&quot;, L&quot;openvpn --msg-channel 1 --persist-tun&quot;, FALSE);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_cmdline(L=
&quot;\&quot;--persist-tun\&quot;&quot;, L&quot;openvpn --msg-channel 1 \&q=
uot;--persist-tun\&quot;&quot;, FALSE);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* other options are passed unchanged */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_cmdline(L&quot;&quot;, L&quot;openvpn =
--msg-channel 1 &quot;, TRUE);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_cmdline(L&quot;--config foo=2Eovpn --verb 3&quot;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                   L&q=
uot;openvpn --msg-channel 1 --config foo=2Eovpn --verb 3&quot;, TRUE);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    memset(&amp;settings, 0, sizeof(setti=
ngs));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br=
><span> wmain(void)</span><br><span> {</span><br><span>@@ -311,6 +349,7 @@<=
/span><br><span>         cmocka_unit_test(test_append_search_list),</span><=
br><span>         cmocka_unit_test(test_remove_search_list_tokens),</span><=
br><span>         cmocka_unit_test(test_merge_openvpn_environment),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(te=
st_build_validate_cmdline),</span><br><span>     };</span><br><span> </span=
><br><span>     int ret =3D cmocka_run_group_tests_name(&quot;openvpnserv t=
ests&quot;, tests, NULL, NULL);</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail">change 215=
9</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 2159 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan C=
ojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--u9s5sKV0V1U=--


--===============0936450687502064428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0936450687502064428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0936450687502064428==--

