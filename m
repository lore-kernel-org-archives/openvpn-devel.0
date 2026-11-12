Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5BE606A8BB
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=K0HEYlPX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jQrdw0LO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gLPUqI1h;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ZMf8HqQo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=FLGoRtMY35es3W2O4rYHY1K2gN3yEC5ynlQT6ylNqww=; b=K0HEYlPXP9FgZVYtDfVdBrwQWn
	rOp6hftUKkrj6SKBylxaEQ6V/ix3Cc1rtjPkE3gV8zqifPXmxBy3QlqLX5egqa+6mxA8U1F0duZks
	dIPd/kKfhokjuArzAGO5WIPUI1WrR3wnRMMNsoXLpyfwwd9kpeALurRgdCJV0cFfA4xA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRQ8m-000000008De-00um;
	Thu, 12 Nov 2026 08:26:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRQ8k-000000008DX-31HE
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 08:26:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ALRfzmvE16bbZbSEROeYEGvcTITkYNW26SvUGfzsAcc=; b=jQrdw0LO1q4t2Of6JvbypXangO
 Tq6+vw5u0fyv/J3t9aMm2gUfIroIoj6V1PMUuLVi+RgHvQIQH/zN60M8fQ6wQCRvMoyPOLlSq7IRu
 kFGB0ZJ3Ag7X6tbb8WAU5LEAAAy1Zle3NNoQ+mEFJWLK5TMKZRuVntUOxen9b5HHw5g0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ALRfzmvE16bbZbSEROeYEGvcTITkYNW26SvUGfzsAcc=; b=gLPUqI1hddFT3uf6OCbsrnH0fO
 6yZIvBIHNJTVT+sJy6RYULZNy2kW4QUcoU6dJiWkxGke1Rxw/81E43HPbCiwxeWdsnzvVzzfltb4h
 Or4KkufkNIKIdYT6aypxq6psyv/IT+vWmKA3zNDlsSGjW14QuZdMHrkVnnCNKcahW1E0=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRQ8i-000000000CF-2TxA for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 08:26:38 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso38012845e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 00:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794471990; x=1795076790; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ALRfzmvE16bbZbSEROeYEGvcTITkYNW26SvUGfzsAcc=;
 b=ZMf8HqQoUMAqNbLIhqFkdrV0QXKU9NSZ0GhOzN3Za//NLBr8ZHEfsNpog57+yTYN5Z
 Inc+RJNNIPKfjrfiiST9FzsKOjViE13vNq+uMtyhlxEY13uX4aWkxGfY7EK7lith+hGb
 Bi3O3pVfm0y+vHokIETOPwWamxtMtZyjzOs8wy5AwGDPa18UswHsBnptk4U13OUMdGop
 Ec5pNaZCDjZKi9eUCl/isz45KKAQpGKKySZ8n4ey5vOGX67/ANap92Xs0VaDPzKH1T6d
 yXvYlV/5wqaWlev1PXxW878H8vmYmqGR27IybAJ3s4MUhV2KUHiki9Q0ZbUZ3aNvzo/e
 XbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794471990; x=1795076790;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ALRfzmvE16bbZbSEROeYEGvcTITkYNW26SvUGfzsAcc=;
 b=dQpjOdA3Gwe2PXI9Xh2d8oEe5NevMKJ6yWX+51CUk/sSbJokjCbg1Tl6eSb1bSWaMc
 6eCkdytbj4bDobQic2oFe2ykFZ4pIQS+YqBZyhoaUU/gRDwONkYfvzwxeDT1p93pDiKN
 1BStS9tO3XLD8B52ht7efMMj2MSrnLd1bjEgoQMy0t1wTwbOhU3W/siatzG6cq9TzWqS
 jb1/UATKRn0Cs3zWBcgTwg5fsm7CiqUXOb7HrXdQkuFK6vRNGjq8dmk7sLu+t/XF2RR9
 Zx4uf9Xgmv5av0lB+svVsbO9FSXUlkniWcY2W+hOwUAwz/6CZbk8HkztuZMAfoCtmnxx
 IWCg==
X-Gm-Message-State: APuU4Z8K/y6xJLYi8UWGajcs/AD1cvfVCxudlkrCsflezOymBb2D3xZz
 anONYdUFmbGDLGhoL0ITx15uPp9QCOUv91w75nc9CeWPV5RZeJZcmVSa7NrEtlzD/xf4wZiNMEj
 pd8LAbIpvC9ifDZHYVcYOlmV/ZGPrTdwEohKXytek2JzH7117V4ZXZA0dkIiXOKO8TlqP6TzOQD
 T+8pmiCQ==
X-Gm-Gg: AYBFou3TDHJ4Q5vnKsGZ+mSWtd9bvi7EmpKPNdvWzPVPh1xVkZ1tIFSkEs5u6fDvRh7
 cBNS6eqdQzQ8FuLeRcfPA6nV4Uo2d1YZsN5xDpyb9FUSs5uAJt8IXDj2eyh7Ol957DqtmxH+ETd
 4S0tO01E6AcQg4UDWMUsMpfz8gcVsHcbc1SWH4m+Q7nPgAe25wIUNkwZhznPU2XAfK08baAJxQQ
 ReoWoaIn0H5wgi3O/r0rGp48WKXiBTnJidg5nhKC7/lIjyg2h2Amngug/ifvK+bdeI45Ltd0rYm
 rcsgwHxs6SulIK6z2+wjGHRse/bpLdHgCuUalnhiXAf19J9S7ChItY0S015NlSxO7lHHLTL+Q6Y
 ZB5EGu3mYQ1YA8PH/07zHpLi66+LEMjnlSluIhkVBeI4PyUmjpWPxTSW593DrprM5lhaG3JCydI
 NP75w6kmuVSFL9u4YMa1fAMGMNQr7hCgh/BQp7Tf9KYuFnOyWOXRlVnadRXeRaFMkaP0NEBfHPB
 T6DPPdm0EaI+uGFPmrdVD2g1lL+vGG8DCWy3Qxe7Gh2RB8OJFWXupiL/j8++ZL7lI4MjiS80a1r
 iMPnaraOdLgnA8GL82kuK1jvJ2L94La3QBH1SOYqQ0ytvAMx+YojTXIlLi0DQMR/cM1RrKVEIsp
 zBBa43LDfJmsDfZNFwaGQzO/yAq8AiUilORmk5ch98x53LV/XLcLsnUJvqF0fjAVkWaHTiCX3Fg
 ME2WJJKB77YIDxXtE=
X-Received: by 2002:a05:600c:3554:b0:4a3:5aea:21e5 with SMTP id
 5b1f17b1804b1-4ba0936c8camr88090595e9.9.1794471989767; 
 Thu, 12 Nov 2026 00:26:29 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498369a4238sm16100038f8f.54.2026.11.12.00.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 00:26:29 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 08:26:27 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf
X-Gerrit-Change-Number: 2159
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2159?usp=email>
X-Gerrit-Commit: 840b0bd7cbeb34ecb479f1d12302b8c037337bb0
In-Reply-To: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
References: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAwNzcyMDAwLkk1NzQ2OWNhNTBjNTUxYWQ0NzU1MTA2OTBlY2ZhMmQ1ZTdjZjljZmNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <116f238e08a75ef743bae761da2f5320b9407d94-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRQ8i-000000000CF-2TxA
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv: reject
 a config file passed without --config
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
 openvpn-devel@lists.sourceforge.net, heiko@ist.eigentlich.net,
 antonio@mandelbit.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4429047636699488189=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4429047636699488189==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ifFovEiWkIc="; charset=UTF-8

--ifFovEiWkIc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, R=C4=
=83zvan Cojocaru=2E

Hello Antonio Quartulli, Arne Schwabe, 

I'd like you =
to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2159?usp=3Demail

to look at the new patch set (#5)=2E

The foll=
owing approvals got outdated and were removed:
Code-Review+2 by Antonio Qua=
rtulli

The change is no longer submittable: Code-Review and checks~ChecksS=
ubmitRule are unsatisfied now=2E


Change subject: openvpnserv: reject a co=
nfig file passed without --config
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

openvpnserv: reject a config file passed without --c=
onfig

openvpn=2Eexe takes a lone argument as the config file only when the=
re
are no other arguments, but the service adds --msg-channel=2E Since
c139=
e82d openvpn=2Eexe takes the config file as an extra parameter of
--msg-cha=
nnel and ignores it=2E ValidateOptions() treated it as the
config file, but=
 only ever returned FALSE for it, with an empty error
message if the path w=
as fine=2E

Return an error to all users when the options don't start with =
an
option, and drop the lone argument special case in ValidateOptions(),
so=
 that a lone option is checked against the white list=2E

Change-Id: I57469=
ca50c551ad475510690ecfa2d5e7cf9cfcf
Signed-off-by: Razvan Cojocaru <razvanc=
@mailbox=2Eorg>
---
M src/openvpnserv/interactive=2Ec
M tests/unit_tests/op=
envpnserv/test_openvpnserv=2Ec
2 files changed, 54 insertions(+), 14 deleti=
ons(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/59/2159/5

diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/=
interactive=2Ec
index 81205d6=2E=2Ef753d46 100644
--- a/src/openvpnserv/int=
eractive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -355,6 +355,23 @@
 }
=
 
 /*
+ * openvpn=2Eexe takes a lone argument as the config file only when =
there are
+ * no other arguments, and takes non-options after --msg-channel=
 <handle> as
+ * its extra parameters=2E
+ */
+static BOOL
+StartsWithNonOp=
tion(const WCHAR *cmdline)
+{
+    int argc;
+    WCHAR **argv =3D CommandL=
ineToArgvW(cmdline, &argc);
+    /* "openvpn --msg-channel <handle> <arg>=
=2E=2E=2E" */
+    BOOL ret =3D argv && argc > 3 && !IsOption(argv[3]);
+
+=
    LocalFree(argv);
+    return ret;
+}
+
+/*
  * Validate options against=
 a white list=2E Also check the config_file is
  * inside the config_dir=2E=
 The white list is defined in validate=2Ec
  * The options are taken from t=
he command line openvpn is started with,
@@ -396,20 +413,6 @@
         goto=
 out;
     }
 
-    /*
-     * If only one argument, it is the config file
=
-     */
-    if (argc =3D=3D first + 1)
-    {
-        WCHAR *argv_tmp[2]=
 =3D { L"--config", argv[first] };
-
-        if (!CheckOption(workdir, 2, =
argv_tmp, &settings))
-        {
-            swprintf(errmsg, capacity, ms=
g1, argv[first], workdir, settings=2Eovpn_admin_group);
-        }
-       =
 goto out;
-    }
-
     for (i =3D first; i < argc; ++i)
     {
         i=
f (!IsOption(argv[i]))
@@ -3839,6 +3842,14 @@
     swprintf(cmdline, cmdlin=
e_size, L"openvpn --msg-channel %" PRIuPTR L" %ls",
              (uintptr_=
t)svc_pipe, sud=2Eoptions);
 
+    if (StartsWithNonOption(cmdline))
+    {=

+        ReturnError(pipe, ERROR_STARTUP_DATA,
+                    L"Opti=
ons must start with an option, pass the config file with --config", 1,
+   =
                 &exit_event);
+        goto out;
+    }
+
     /*
      * =
Only authorized users are allowed to use any command line options or
      =
* have the config file in locations other than the global config directory=
=2E
diff --git a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec b/tests/=
unit_tests/openvpnserv/test_openvpnserv=2Ec
index 20fb1af=2E=2E7db61f7 1006=
44
--- a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
+++ b/tests/unit=
_tests/openvpnserv/test_openvpnserv=2Ec
@@ -301,6 +301,33 @@
     assert_me=
rge_result(L"", L"", L"");
 }
 
+static void
+test_starts_with_non_option(v=
oid **state)
+{
+    assert_true(StartsWithNonOption(L"openvpn --msg-channe=
l 1 foo=2Eovpn"));
+    assert_true(StartsWithNonOption(L"openvpn --msg-cha=
nnel 1 \"my vpn=2Eovpn\""));
+    assert_true(StartsWithNonOption(L"openvpn=
 --msg-channel 1 foo=2Eovpn --verb 3"));
+    assert_true(StartsWithNonOpti=
on(L"openvpn --msg-channel 1 foo=2Eovpn bar"));
+    assert_true(StartsWith=
NonOption(L"openvpn --msg-channel 1 \"\""));
+
+    assert_false(StartsWith=
NonOption(L"openvpn --msg-channel 1 "));
+    assert_false(StartsWithNonOpt=
ion(L"openvpn --msg-channel 1 --persist-tun"));
+    assert_false(StartsWit=
hNonOption(L"openvpn --msg-channel 1 --config foo=2Eovpn"));
+}
+
+static v=
oid
+test_validate_lone_option(void **state)
+{
+    WCHAR errmsg[512];
+
+=
    assert_true(ValidateOptions(NULL, L"C:\\OpenVPN\\config\\",
+          =
                      L"openvpn --msg-channel 1 --script-security", errmsg,=

+                                _countof(errmsg)));
+    assert_false(Val=
idateOptions(NULL, L"C:\\OpenVPN\\config\\",
+                             =
    L"openvpn --msg-channel 1 --persist-tun", errmsg,
+                    =
             _countof(errmsg)));
+}
+
 int
 wmain(void)
 {
@@ -311,6 +338,8=
 @@
         cmocka_unit_test(test_append_search_list),
         cmocka_uni=
t_test(test_remove_search_list_tokens),
         cmocka_unit_test(test_merg=
e_openvpn_environment),
+        cmocka_unit_test(test_starts_with_non_opti=
on),
+        cmocka_unit_test(test_validate_lone_option),
     };
 
     i=
nt ret =3D cmocka_run_group_tests_name("openvpnserv tests", tests, NULL, NU=
LL);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I57469ca50=
c551ad475510690ecfa2d5e7cf9cfcf
Gerrit-Change-Number: 2159
Gerrit-PatchSet:=
 5
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Review=
er: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Heiko Hund <heiko@ist=2Eeigentli=
ch=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Atte=
ntion: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>

--ifFovEiWkIc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, R=C4=83zvan Cojocaru=
=2E </p>
<p>R=C4=83zvan Cojocaru <strong>uploaded patch set #5</strong> to =
this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2159?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review+2 by Antonio Quartulli</p><p>The change is =
no longer submittable: Code-Review and checks~ChecksSubmitRule are unsatisf=
ied now=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">openvpnserv: reject a config file passed withou=
t --config<br><br>openvpn=2Eexe takes a lone argument as the config file on=
ly when there<br>are no other arguments, but the service adds --msg-channel=
=2E Since<br>c139e82d openvpn=2Eexe takes the config file as an extra param=
eter of<br>--msg-channel and ignores it=2E ValidateOptions() treated it as =
the<br>config file, but only ever returned FALSE for it, with an empty erro=
r<br>message if the path was fine=2E<br><br>Return an error to all users wh=
en the options don&#39;t start with an<br>option, and drop the lone argumen=
t special case in ValidateOptions(),<br>so that a lone option is checked ag=
ainst the white list=2E<br><br>Change-Id: I57469ca50c551ad475510690ecfa2d5e=
7cf9cfcf<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br=
>---<br>M src/openvpnserv/interactive=2Ec<br>M tests/unit_tests/openvpnserv=
/test_openvpnserv=2Ec<br>2 files changed, 54 insertions(+), 14 deletions(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/59/2159/5</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interactiv=
e=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index 81205d6=2E=2E=
f753d46 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</span>=
<br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -355,6 +=
355,23 @@</span><br><span> }</span><br><span> </span><br><span> /*</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * openvpn=2Eexe takes a lon=
e argument as the config file only when there are</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * no other arguments, and takes non-options =
after --msg-channel &lt;handle&gt; as</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * its extra parameters=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static BOOL</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+StartsWithNonOption(const WCHAR *cmdline)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    int argc;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   WCHAR **argv =3D CommandLineToArgvW(cmdline, &amp;argc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* &quot;openvpn --msg-channel =
&lt;handle&gt; &lt;arg&gt;=2E=2E=2E&quot; */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    BOOL ret =3D argv &amp;&amp; argc &gt; 3 &amp;=
&amp; !IsOption(argv[3]);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LocalFree=
(argv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return r=
et;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/*</span><br><span>  * Validate options against a whi=
te list=2E Also check the config_file is</span><br><span>  * inside the con=
fig_dir=2E The white list is defined in validate=2Ec</span><br><span>  * Th=
e options are taken from the command line openvpn is started with,</span><b=
r><span>@@ -396,20 +413,6 @@</span><br><span>         goto out;</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * =
If only one argument, it is the config file</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (argc =3D=3D first + 1)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        WCHAR *argv_tmp[2] =3D { L&quot;--config&quot;, argv[first] };</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if (!CheckOption(workdir, 2, argv_tmp,=
 &amp;settings))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            swpri=
ntf(errmsg, capacity, msg1, argv[first], workdir, settings=2Eovpn_admin_gro=
up);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        goto out;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span>     for (i =3D first; i &lt; ar=
gc; ++i)</span><br><span>     {</span><br><span>         if (!IsOption(argv=
[i]))</span><br><span>@@ -3839,6 +3842,14 @@</span><br><span>     swprintf(=
cmdline, cmdline_size, L&quot;openvpn --msg-channel %&quot; PRIuPTR L&quot;=
 %ls&quot;,</span><br><span>              (uintptr_t)svc_pipe, sud=2Eoption=
s);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (StartsWithNonOption(cmdline))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        ReturnError(pipe, ERROR_STARTUP_DATA,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    L&quot;Options must s=
tart with an option, pass the config file with --config&quot;, 1,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    &amp;exit=
_event);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        got=
o out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /*</s=
pan><br><span>      * Only authorized users are allowed to use any command =
line options or</span><br><span>      * have the config file in locations o=
ther than the global config directory=2E</span><br><span>diff --git a/tests=
/unit_tests/openvpnserv/test_openvpnserv=2Ec b/tests/unit_tests/openvpnserv=
/test_openvpnserv=2Ec</span><br><span>index 20fb1af=2E=2E7db61f7 100644</sp=
an><br><span>--- a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec</span>=
<br><span>+++ b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec</span><br=
><span>@@ -301,6 +301,33 @@</span><br><span>     assert_merge_result(L&quot=
;&quot;, L&quot;&quot;, L&quot;&quot;);</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+test_starts_with_non_optio=
n(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(Starts=
WithNonOption(L&quot;openvpn --msg-channel 1 foo=2Eovpn&quot;));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(StartsWithNonO=
ption(L&quot;openvpn --msg-channel 1 \&quot;my vpn=2Eovpn\&quot;&quot;));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(Start=
sWithNonOption(L&quot;openvpn --msg-channel 1 foo=2Eovpn --verb 3&quot;));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(Star=
tsWithNonOption(L&quot;openvpn --msg-channel 1 foo=2Eovpn bar&quot;));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(StartsWi=
thNonOption(L&quot;openvpn --msg-channel 1 \&quot;\&quot;&quot;));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_false(StartsWithNonOption(L&quot;ope=
nvpn --msg-channel 1 &quot;));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_false(StartsWithNonOption(L&quot;openvpn --msg-channe=
l 1 --persist-tun&quot;));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_false(StartsWithNonOption(L&quot;openvpn --msg-channel 1 =
--config foo=2Eovpn&quot;));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+test_validate_lone_option(void **sta=
te)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    WCHAR errmsg[512];</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(ValidateOptions(NULL, L&quot;C:\\O=
penVPN\\config\\&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                L&quot;openvpn --msg-channel 1 --script=
-security&quot;, errmsg,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                                _countof(errmsg)));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_false(ValidateOptions(NULL,=
 L&quot;C:\\OpenVPN\\config\\&quot;,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                 L&quot;openvpn --msg-chan=
nel 1 --persist-tun&quot;, errmsg,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                 _countof(errmsg)));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> wmain(=
void)</span><br><span> {</span><br><span>@@ -311,6 +338,8 @@</span><br><spa=
n>         cmocka_unit_test(test_append_search_list),</span><br><span>     =
    cmocka_unit_test(test_remove_search_list_tokens),</span><br><span>     =
    cmocka_unit_test(test_merge_openvpn_environment),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_starts_with=
_non_option),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  cmocka_unit_test(test_validate_lone_option),</span><br><span>     };</spa=
n><br><span> </span><br><span>     int ret =3D cmocka_run_group_tests_name(=
&quot;openvpnserv tests&quot;, tests, NULL, NULL);</span><br></pre><p>To vi=
ew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3D=
email">change 2159</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">sett=
ings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAct=
ion"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2159?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </d=
iv>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2159 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Anto=
nio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--ifFovEiWkIc=--


--===============4429047636699488189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4429047636699488189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4429047636699488189==--

