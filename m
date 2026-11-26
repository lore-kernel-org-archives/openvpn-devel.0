Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7AB606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VGRxeDD4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SZ3Q5boo;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IkmLXyKN;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dCtHT9ys
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8/lsGm2yOjFjnAdYpZZTT4dtwEgTaxc1ZOuCbt9KVcM=; b=VGRxeDD4/622gJLZYsBYJlrKn3
	SAPcxDD9vS1NiynLaxwRp4ZKiqS3Lt4s07Z6MrVfadpNsXbq5v3v7ooZwCy46GyLEJbee6wOiy0Sg
	+oO6VwEKlkZBUhTRBP3jFZVXS8K40vfhZDDA3KrVsyItcQPtZ23+DhG5mE1byov3e+bA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWWrt-000000001NL-0S9q;
	Thu, 26 Nov 2026 10:38:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWWrr-000000001NB-31T6
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 10:38:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Vya3CtwojMoYR9KIfQhj6frpfNMfHdpFzGE2unUw0N8=; b=SZ3Q5booXsiD2wMjRr5fxhpPXC
 1kMdPfsQ9AkEFUaVRNsQEn5s3Vb5v7klcZuy4afz5UChc464X7Hg3GOYmYxnGhPKkTz9MNkAK0MJR
 4tSzEE7WS+zX1XJwzPfDO4GNtCOVbfHH0CPUpzG5j1+NoLSnz1jyYD4SOENe6rb8Da8Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Vya3CtwojMoYR9KIfQhj6frpfNMfHdpFzGE2unUw0N8=; b=IkmLXyKNn0u+6Zf0IpG9npt1WC
 CUAVlWDI62Wyb+Guwuqz8/qAOaPK4cvRCSQfjq1m2K/MTkB2UAGyTpQMRz6d9/FqckN+L1bI6UtNy
 V0QswMIDbmho5jBABJ49hxOH1AlOtbcNX+wh2vq5Iw2Qp+hIzAiASc9LFXCXfHt+lQ/w=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWWrp-000000007Et-3oJx for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 10:38:19 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a00so55248945e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 02:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795689491; x=1796294291; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Vya3CtwojMoYR9KIfQhj6frpfNMfHdpFzGE2unUw0N8=;
 b=dCtHT9yshKR1J/GfMDxC45cA/zsGdioX9pRRtuYgTdluix086hlb2MLfBsFs4OlWVq
 uWBqpAuZza3+gVXDbO83w3IfXGbOfMKV4ujU+NYZq5mFtyVAq7go1A/C1aok5U09y5FV
 8GeRDKUxJuIsc2PkVHnQm6UlWGuhFhiQZK3usUmomcXy4he6W9ALaMZxmxheoLOCd0Yg
 Ou7Il1QzaXkTkLrtuhOsy20kTUukMzwIhjCEm5sfUy4ReYYH8c9LtLj2qi9jCuCK3xYS
 3AL+NXNokTTvd6cvZuoMhTbsjeApTlqgaqBcY4tKjTFT+XjzOljsEq1xph9ZKlkZzhar
 511A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795689491; x=1796294291;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Vya3CtwojMoYR9KIfQhj6frpfNMfHdpFzGE2unUw0N8=;
 b=CyCKWWjeZwSnE8xx8khsRvPOrbYZul9mhluWGqcGf2yQ5DUAsDqr695+M45VLQuW2a
 v1tBCBHDsV/qKWjo+tFH1J7DH2c80f3FNoNoRJ81M2R2ff2ZaxZLyCDh9g2XetgjpJVE
 nyjFJDEGt6hNbYdUXdbyAitC05D8kPgNnI1Md/2pOPoU89ZUs/LvqbOoBiG4iDRttq8N
 dfBD/UEIKuW/MK0y+J7TPjGfvFsuUpCkv6U3vutM8xD39KK4dUf1nbi2Nzy/GAVPTRzp
 1xIM9HLMPJfzRto7bXGCbbABeprOBuhilAKDKUAgvUeQbf5N2zFf9S9H37/nvi3VHdGi
 rQcA==
X-Gm-Message-State: APuU4Z8Jhixs06dC/IVdCXRuujOEMwQ1MevV2IV3qeNf66usoSeO6iHZ
 CFYytYMadNFotcz1SFs/CR+l6LHDgX+Fp2+oPFpnocUXvhSrBQt/ZDRfjhkUXpNvRV7bxXB78qK
 QpDgizRTJ175/bgnIKfvFxi+b6qYei08mgMFUa+x2fz+iP3MkpLD3ndNcMcjBz4mHbxqx
X-Gm-Gg: AZFdTZeyR+b3vnMH9jptghapWJDdc4zGBxWdONF8dGKpRkApokIuVDmqZ7Pmp659Mk3
 fFgfM5qzc2KxGUkSfm5rBZ6HYfv/Uun+L7qoJiGGqqAFOzxwNWt+FbJT+Vqn6Tdhi4JXX6g2Naz
 0IcDY+zczSb4H6QQ6eCzmToloZCpoBvDxHKweLDSiaDLSTBph/KF60mFFcXO7RsXyoZ4vMk2lOZ
 5ma1HfEr4WMsM4WdUUmCEubvbf0beuOgGF1gd0CNbN11EH/bZyhm+k+8IxZtQJZ+ZpZ5SWN2shD
 DKXUrZdY7DoMwbu+54Jl2/m1Pe+9BWHPi9clG91fT1dqlc6vWOpEXmTYDmHGQv3kFLg/41wuWJX
 /oi0ng8W23qhYbUQMRLNBGp1oOvqGEHz0DtUxiXt7NsHhP0o4a5cnqdbKjBF1xugDg8xw9cGNxS
 D7GBB3ZCsW69Y1iUuWAgCZKsXOoew1ZcSGPmUGeHwk0WuW2GjATGaP+d4OSHQS9rL7f+QKjS0UR
 qd6SqRuKedobrbjdrzLxKlZQJQYEMfupi7Zrg0gOw+89qRueiCgQaMO+jdDA4jcqEh9h1srlDq5
 mSCgLRJUJQelVH+9dO8aX5EUC1Cmy1tgadABwPPSc3RVYgOW6WC4kHaBKiyqUjRl0+uaspKfyAI
 CfucJrCRNygOAQwYZrn/+lfB1E8CpL/3B/JyszLWjkLatHWyHcu1GCE7zQAjtWbTN8g6e5cJXwj
 h8w2e/sy1jyo+U/qk=
X-Received: by 2002:a05:600c:64c8:b0:4a0:1c0e:b057 with SMTP id
 5b1f17b1804b1-4bb887e2380mr383318045e9.4.1795689490958; 
 Thu, 26 Nov 2026 02:38:10 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884c3063sm584314985e9.15.2026.11.26.02.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 02:38:10 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 10:38:09 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Lev Stipakov <lstipakov@gmail.com>, Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I14ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8
X-Gerrit-Change-Number: 2188
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2188?usp=email>
X-Gerrit-Commit: 85d36443381a87c68a2573b90d01fad8af807f8f
In-Reply-To: <gerrit.1794825232000.I14ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8@gerrit.openvpn.net>
References: <gerrit.1794825232000.I14ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODI1MjMyMDAwLkkxNGFkNGU0NTExYmQ5OTMzYjg5ZjQ4YWU1YTNhYzZkMmE1ZTBmMmQ4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f73611fe2f90136cfe392e60d31c38a72f7bfa83-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWWrp-000000007Et-3oJx
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8820453402241460063=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8820453402241460063==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9/zh7945sX0="; charset=UTF-8

--9/zh7945sX0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#4) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2188?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Lev Stipakov


Change subject: openvpnserv: check for a =
leading non-option in the startup data
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: check for a leading non-option in th=
e startup data

Check sud=2Eoptions directly before doing any other work, i=
nstead of
building the openvpn=2Eexe command line and parsing it back=2E Th=
is also
rejects empty options=2E

Change-Id: I14ad4e4511bd9933b89f48ae5a3ac=
6d2a5e0f2d8
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by=
: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2188
Message-Id: <20261120080412=2E4368-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg41709=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpnserv/interactive=2Ec
M tests/unit_tests/openv=
pnserv/test_openvpnserv=2Ec
2 files changed, 24 insertions(+), 28 deletions=
(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/88=
/2188/4

diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/int=
eractive=2Ec
index be57d43=2E=2Ebddaf86 100644
--- a/src/openvpnserv/intera=
ctive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -354,24 +354,17 @@
 /**
=
  * Check whether the user options start with a non-option
  *
- * openvpn=
=2Eexe takes a lone argument as the config file only when there are
- * no =
other arguments, and takes non-options after the --msg-channel handle
- * a=
s its extra parameters=2E
+ * openvpn=2Eexe takes non-options after the --m=
sg-channel handle the service
+ * prepends as its extra parameters, not as =
the config file=2E
  *
- * @param  cmdline  openvpn=2Eexe command line buil=
t by the service
+ * @param  options  user options from the startup data
  =
*
  * @return BOOL to indicate if the first user argument is not an option
=
  */
 static BOOL
-StartsWithNonOption(const WCHAR *cmdline)
+StartsWithNon=
Option(const WCHAR *options)
 {
-    int argc;
-    WCHAR **argv =3D Comman=
dLineToArgvW(cmdline, &argc);
-    /* "openvpn --msg-channel <handle> <arg>=
=2E=2E=2E" */
-    BOOL ret =3D argv && argc > 3 && !IsOption(argv[3]);
-
-=
    LocalFree(argv);
-    return ret;
+    return !IsOption(options + wcssp=
n(options, L" \t"));
 }
 
 /*
@@ -3634,6 +3627,14 @@
         goto out;
   =
  }
 
+    if (StartsWithNonOption(sud=2Eoptions))
+    {
+        ReturnEr=
ror(pipe, ERROR_STARTUP_DATA,
+                    L"Options must start wit=
h an option, pass the config file with --config", 1,
+                    &=
exit_event);
+        goto out;
+    }
+
     if (!InitializeSecurityDescri=
ptor(&ovpn_sd, SECURITY_DESCRIPTOR_REVISION))
     {
         ReturnLastErr=
or(pipe, L"InitializeSecurityDescriptor");
@@ -3878,14 +3879,6 @@
     swpr=
intf(cmdline, cmdline_size, L"openvpn --msg-channel %" PRIuPTR L" %ls",
   =
           (uintptr_t)svc_pipe, sud=2Eoptions);
 
-    if (StartsWithNonOpt=
ion(cmdline))
-    {
-        ReturnError(pipe, ERROR_STARTUP_DATA,
-      =
              L"Options must start with an option, pass the config file wit=
h --config", 1,
-                    &exit_event);
-        goto out;
-    =
}
-
     /*
      * Only authorized users are allowed to use any command li=
ne options or
      * have the config file in locations other than the glob=
al config directory=2E
diff --git a/tests/unit_tests/openvpnserv/test_openv=
pnserv=2Ec b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
index 7db61f=
7=2E=2Ed07fa22 100644
--- a/tests/unit_tests/openvpnserv/test_openvpnserv=
=2Ec
+++ b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
@@ -304,15 +30=
4,18 @@
 static void
 test_starts_with_non_option(void **state)
 {
-    ass=
ert_true(StartsWithNonOption(L"openvpn --msg-channel 1 foo=2Eovpn"));
-    =
assert_true(StartsWithNonOption(L"openvpn --msg-channel 1 \"my vpn=2Eovpn\"=
"));
-    assert_true(StartsWithNonOption(L"openvpn --msg-channel 1 foo=2Eo=
vpn --verb 3"));
-    assert_true(StartsWithNonOption(L"openvpn --msg-chann=
el 1 foo=2Eovpn bar"));
-    assert_true(StartsWithNonOption(L"openvpn --ms=
g-channel 1 \"\""));
+    assert_true(StartsWithNonOption(L"foo=2Eovpn"));
=
+    assert_true(StartsWithNonOption(L"\"my vpn=2Eovpn\""));
+    assert_tr=
ue(StartsWithNonOption(L"foo=2Eovpn --verb 3"));
+    assert_true(StartsWit=
hNonOption(L"foo=2Eovpn bar"));
+    assert_true(StartsWithNonOption(L" \tf=
oo=2Eovpn"));
+    assert_true(StartsWithNonOption(L"\"\""));
+    assert_t=
rue(StartsWithNonOption(L""));
+    assert_true(StartsWithNonOption(L" "));=

 
-    assert_false(StartsWithNonOption(L"openvpn --msg-channel 1 "));
-  =
  assert_false(StartsWithNonOption(L"openvpn --msg-channel 1 --persist-tun"=
));
-    assert_false(StartsWithNonOption(L"openvpn --msg-channel 1 --confi=
g foo=2Eovpn"));
+    assert_false(StartsWithNonOption(L"--persist-tun"));
=
+    assert_false(StartsWithNonOption(L"--config foo=2Eovpn"));
+    assert=
_false(StartsWithNonOption(L" \t--config foo=2Eovpn"));
 }
 
 static void

=
-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2188?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I14ad4e4511bd99=
33b89f48ae5a3ac6d2a5e0f2d8
Gerrit-Change-Number: 2188
Gerrit-PatchSet: 4
Ge=
rrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Lev Stipakov <lst=
ipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>

--9/zh7945sX0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #4</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2188?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Lev Stipakov</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">ope=
nvpnserv: check for a leading non-option in the startup data<br><br>Check s=
ud=2Eoptions directly before doing any other work, instead of<br>building t=
he openvpn=2Eexe command line and parsing it back=2E This also<br>rejects e=
mpty options=2E<br><br>Change-Id: I14ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8=
<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-b=
y: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2188<br>Message-Id: &lt;20261120080412=2E4368-=
1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/open=
vpn-devel@lists=2Esourceforge=2Enet/msg41709=2Ehtml<br>Signed-off-by: Gert =
Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpnserv/interac=
tive=2Ec<br>M tests/unit_tests/openvpnserv/test_openvpnserv=2Ec<br>2 files =
changed, 24 insertions(+), 28 deletions(-)<br><br></pre><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/88/2188/4</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interacti=
ve=2Ec</span><br><span>index be57d43=2E=2Ebddaf86 100644</span><br><span>--=
- a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/i=
nteractive=2Ec</span><br><span>@@ -354,24 +354,17 @@</span><br><span> /**</=
span><br><span>  * Check whether the user options start with a non-option</=
span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
openvpn=2Eexe takes a lone argument as the config file only when there are<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * no other arguments,=
 and takes non-options after the --msg-channel handle</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * as its extra parameters=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * openvpn=2Eexe takes non-option=
s after the --msg-channel handle the service</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * prepends as its extra parameters, not as the co=
nfig file=2E</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * @param  cmdline  openvpn=2Eexe command line built by the serv=
ice</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  optio=
ns  user options from the startup data</span><br><span>  *</span><br><span>=
  * @return BOOL to indicate if the first user argument is not an option</s=
pan><br><span>  */</span><br><span> static BOOL</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-StartsWithNonOption(const WCHAR *cmdline)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+StartsWithNonOption(const W=
CHAR *options)</span><br><span> {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    int argc;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    WCHAR **argv =3D CommandLineToArgvW(cmdline, &amp;argc);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    /* &quot;openvpn --msg-chann=
el &lt;handle&gt; &lt;arg&gt;=2E=2E=2E&quot; */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    BOOL ret =3D argv &amp;&amp; argc &gt; 3 &amp=
;&amp; !IsOption(argv[3]);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    LocalFree(ar=
gv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return !IsOption(=
options + wcsspn(options, L&quot; \t&quot;));</span><br><span> }</span><br>=
<span> </span><br><span> /*</span><br><span>@@ -3634,6 +3627,14 @@</span><b=
r><span>         goto out;</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (StartsWithNonOption=
(sud=2Eoptions))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ReturnErr=
or(pipe, ERROR_STARTUP_DATA,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    L&quot;Options must start with an option, pass=
 the config file with --config&quot;, 1,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    &amp;exit_event);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span>     if (!InitializeSecurityDescrip=
tor(&amp;ovpn_sd, SECURITY_DESCRIPTOR_REVISION))</span><br><span>     {</sp=
an><br><span>         ReturnLastError(pipe, L&quot;InitializeSecurityDescri=
ptor&quot;);</span><br><span>@@ -3878,14 +3879,6 @@</span><br><span>     sw=
printf(cmdline, cmdline_size, L&quot;openvpn --msg-channel %&quot; PRIuPTR =
L&quot; %ls&quot;,</span><br><span>              (uintptr_t)svc_pipe, sud=
=2Eoptions);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (StartsWithNonOption(cmdline))</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        ReturnError(pipe, ERROR_STARTUP_DATA,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                    L&quot;Options must st=
art with an option, pass the config file with --config&quot;, 1,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                    &amp;exit_ev=
ent);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        goto out=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /*</span><br><=
span>      * Only authorized users are allowed to use any command line opti=
ons or</span><br><span>      * have the config file in locations other than=
 the global config directory=2E</span><br><span>diff --git a/tests/unit_tes=
ts/openvpnserv/test_openvpnserv=2Ec b/tests/unit_tests/openvpnserv/test_ope=
nvpnserv=2Ec</span><br><span>index 7db61f7=2E=2Ed07fa22 100644</span><br><s=
pan>--- a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec</span><br><span=
>+++ b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec</span><br><span>@@=
 -304,15 +304,18 @@</span><br><span> static void</span><br><span> test_star=
ts_with_non_option(void **state)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    assert_true(StartsWithNonOption(L&quot;=
openvpn --msg-channel 1 foo=2Eovpn&quot;));</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    assert_true(StartsWithNonOption(L&quot;openvpn --=
msg-channel 1 \&quot;my vpn=2Eovpn\&quot;&quot;));</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    assert_true(StartsWithNonOption(L&quot;ope=
nvpn --msg-channel 1 foo=2Eovpn --verb 3&quot;));</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    assert_true(StartsWithNonOption(L&quot;open=
vpn --msg-channel 1 foo=2Eovpn bar&quot;));</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    assert_true(StartsWithNonOption(L&quot;openvpn --=
msg-channel 1 \&quot;\&quot;&quot;));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_true(StartsWithNonOption(L&quot;foo=2Eovpn&quo=
t;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tru=
e(StartsWithNonOption(L&quot;\&quot;my vpn=2Eovpn\&quot;&quot;));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(StartsWithNon=
Option(L&quot;foo=2Eovpn --verb 3&quot;));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_true(StartsWithNonOption(L&quot;foo=2Eovp=
n bar&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_true(StartsWithNonOption(L&quot; \tfoo=2Eovpn&quot;));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_true(StartsWithNonOptio=
n(L&quot;\&quot;\&quot;&quot;));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_true(StartsWithNonOption(L&quot;&quot;));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(StartsWithNon=
Option(L&quot; &quot;));</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    assert_false(StartsWithNonOption(L&quot;openvpn --=
msg-channel 1 &quot;));</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    assert_false(StartsWithNonOption(L&quot;openvpn --msg-channel 1 --per=
sist-tun&quot;));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
assert_false(StartsWithNonOption(L&quot;openvpn --msg-channel 1 --config fo=
o=2Eovpn&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_false(StartsWithNonOption(L&quot;--persist-tun&quot;));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(StartsWithNon=
Option(L&quot;--config foo=2Eovpn&quot;));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_false(StartsWithNonOption(L&quot; \t--con=
fig foo=2Eovpn&quot;));</span><br><span> }</span><br><span> </span><br><spa=
n> static void</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2188?usp=3Demail">change 2188</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2188?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I14ad4e4511bd993=
3b89f48ae5a3ac6d2a5e0f2d8 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 2188 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>=

<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>

</body></html>
--9/zh7945sX0=--


--===============8820453402241460063==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8820453402241460063==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8820453402241460063==--

