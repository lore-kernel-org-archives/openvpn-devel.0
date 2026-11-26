Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FDF606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mQVbo3yC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mubQ7jk7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gn92gjZB;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TiAxky6+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=czl7jaxsqAqi+eR6gh5x8tpBEy3Puxcyno05ZNQalkE=; b=mQVbo3yC8nKyxrxr7o4awTW/xq
	dZXW4KfLfah8Yk9j/dKMDks839R3zCcbPVqhiiKgYmkKdq2AxTC6SdLPDGBKZNx8N90J0IpOCU1el
	bNFGn/rvnunmFETKTur/S8G9zJTr76vE+q+GiNYReC532pnmVCVfXTmXE4paRHdvm/4Q=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWWrt-000000004Wz-3ZdL;
	Thu, 26 Nov 2026 10:38:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWWrs-000000004Wr-0uqW
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 10:38:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZvGr0v7lf1PQx5hz+JeVbIY7Gimb3/eVHxSPsAuqKZM=; b=mubQ7jk7ZApo2HLn/nD/K+Fsep
 VnMhFASvMxLEerF5UQzd1irGvrnaCtCCMarn4HWH+S50YWzatcXn5cBHYOeTAnV+xx3jq6u9tBA6z
 lRxMmn73HK8LVVPSyEuREMEXGLa5BI+cd+kLVujCpM1wl2XXZ/zPdI279cQoOu8lV1gc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZvGr0v7lf1PQx5hz+JeVbIY7Gimb3/eVHxSPsAuqKZM=; b=gn92gjZB3B6fEA/79WO4+zFkhl
 I6OsgzvHSoVUIrDWsItWcCT8Jy6teQPcurnn1uVgHAhR2maPfE+8ekWZZvWDTonXGeYlVpkE5Fbaw
 iw1JnbffJo3Uzab2Jf4ZOcPpCLpDLyD+u3wbkHpdqlRydfsDn43Rt5FUmVukXtgBsJrY=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWWrq-000000003lj-1jMm for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 10:38:20 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a00so55249005e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 02:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795689492; x=1796294292; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZvGr0v7lf1PQx5hz+JeVbIY7Gimb3/eVHxSPsAuqKZM=;
 b=TiAxky6+1LP+RvW0CYqDAwf5NAjMGM2KyrlFVRacgoDGrBf/GaqrR7u9GO+kaaJ4qU
 P1UuyIV8znqfxEsX77iB/r9opk7OguqIWmSirbTTuUcxXl6jLwcILr+kb5sYTzxm2EAJ
 3CV+cQLe4eD1pPunGFRjYtdgBLwFzYYYJwuvHi7HO+Bd+PZaojGJ0/1nF+50JAuOKka8
 xnZm3hckE1+I8fwLGdfCiaPZcezPuqbTBk+U76t4+W8Rg6BS85g0vEY8uWr6tURIg3Fs
 GcCM1ygvfdz3k810f/b8evd4KyzErXUC6rQXWQ28yIdo2aslmUu+eWvd3zdA7JXgtHcd
 WhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795689492; x=1796294292;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZvGr0v7lf1PQx5hz+JeVbIY7Gimb3/eVHxSPsAuqKZM=;
 b=A1BKmxYBA70Zhry2GQSaoMn+RSnRwsmPGZBglZ/b76Td2uoEYjc5qctLWzbNIORl3b
 ay7gPqpJOvH4iLvGkeYEXJ2hJU6IifzMG+WdAu0Vj2iDd7x618JVcE/35gD0d9KerFjT
 FEi62CRAVy4Io8LWI0Wq07zE+hxdfUyVo2lMHm/29uI1BiNB5JnopTmz2ga1TPaHQTSW
 +RQJVeV++jvujED54yJlJ84GJFD+a3S/IAyy1SddEL9UKKenSLZ3OR2WD/yMVIuGPRIj
 AbwFq+rzBZOuyMaXsr1GR4Qc1a3Vs+3YlEGO2iwq/mQIIyAPR7gWIzgMg4dSpJfJBEt0
 3kjw==
X-Forwarded-Encrypted: i=1;
 AL+hErHBQQmuEQHNNwE65B4r1TPLB2dJtg04ceRAYvdXr2HGbKsbF/il8njdYBqmuEJ0GWRwTI3wEgUIHGVPXUfT@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9PQ3UMdpg+f63Me4FD1h8Hdc3yUfUV0Oe+8FHS/HYVAvWyGK0a
 TISbgXYwvEGYoO+MB3/7UUZAun7lxQ54DtuAKR6ggoepShCWTZ6TXKdnAR6smdQnZAI5QiMGcFu
 h7B5zpM/hSCAu9ioQMAxgnzb/hpmlvN69Zck0+XpicBEta8VjTTCO39FyRbgVXNs4w+RBiD1cil
 Jg32awMw==
X-Gm-Gg: AZFdTZeBcvJBqoEC9+AyfaRORBMR+6aEqe87bN3bz391BLmZM6uBfrj0/27NkQt9RuN
 bYlPTRWxpvzOBrjeau/M1+JwQtk9iYWktuDI15O6Ck3kagmhci2hWrRoO8Mk+Ygew2TDCsoWXlC
 +EFle038pN2n9vZJFHra1C9qUTiYvCJbKDFjCZqY4DG/lEVPdp07cGUR7f16QLHtUz9h/6qKfiv
 tVuNxmnhvyF12KKA31I/UoolsqKZgoGFnV+eU2ydYXFH4OsYbS+g/K4BztyBI8Rr9uWWT4PdEJj
 zWWJSUfhTzaCr0J3UcT2IVP/sKuCMSnWKgPKG3rz+hZgRgV2DyvVwp6QTzoNtAblwsegfsYPN27
 jSc0O6R5tz4rcEjaarp+aCSRobvshA6yAkZNh0+46I3pDGWBmBchApklC5crhETOVro4tpRr3rh
 CYhTyxfKr59UqL+rl94EsFKJF7kxT3tiInfqJy1hpQp3ZHeOyOctxNytHodIOQXUvLtqHdhcwxG
 k8Y/1kxomJ3RIim+tuaJf+95ictHGzmEIyvNjqOsDe7/oO5G9CHgQflJYBVCDfQ2/KeJ9IUuucU
 9xEr2EsgeoFjcS8tUF+VG+vNwWMWMVNBboPvp++iVHTvx6disetnTZx0tQHjpCFy920bUIm7lmK
 2vs2Lki3D3pZ/A/7s9eXq7/2RHrsNYluFma4ewZfx/Ii3B8eMtYrAUwfootYOm+laCKItcZUz5Q
 x6wogrdVPK18mzYmKgApHZ6K42dt59ly6XGmZM
X-Received: by 2002:a05:600c:828e:b0:4a1:cd83:b23e with SMTP id
 5b1f17b1804b1-4bb88786ddemr380517575e9.0.1795689491681; 
 Thu, 26 Nov 2026 02:38:11 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb90660cb4sm547967425e9.2.2026.11.26.02.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 02:38:11 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 10:38:11 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I14ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8
X-Gerrit-Change-Number: 2188
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2188?usp=email>
X-Gerrit-Commit: 85d36443381a87c68a2573b90d01fad8af807f8f
In-Reply-To: <gerrit.1794825232000.I14ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8@gerrit.openvpn.net>
References: <gerrit.1794825232000.I14ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODI1MjMyMDAwLkkxNGFkNGU0NTExYmQ5OTMzYjg5ZjQ4YWU1YTNhYzZkMmE1ZTBmMmQ4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f73611fe2f90136cfe392e60d31c38a72f7bfa83-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWWrq-000000003lj-1jMm
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1879429092700198970=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1879429092700198970==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OE4dtpjWjK4="; charset=UTF-8

--OE4dtpjWjK4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2188?usp=3Demail )

Change subject: openvpnserv: check for a le=
ading non-option in the startup data
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




diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/inte=
ractive=2Ec
index be57d43=2E=2Ebddaf86 100644
--- a/src/openvpnserv/interac=
tive=2Ec
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

Gerrit-MessageType: merged
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I14ad4e4511bd9933b89=
f48ae5a3ac6d2a5e0f2d8
Gerrit-Change-Number: 2188
Gerrit-PatchSet: 4
Gerrit-=
Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Lev Stipakov <lstipako=
v@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--OE4dtpjWjK4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2188?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">openvpnserv: check for a leading n=
on-option in the startup data<br><br>Check sud=2Eoptions directly before do=
ing any other work, instead of<br>building the openvpn=2Eexe command line a=
nd parsing it back=2E This also<br>rejects empty options=2E<br><br>Change-I=
d: I14ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8<br>Signed-off-by: Razvan Cojoc=
aru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Lev Stipakov &lt;lstipakov@g=
mail=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
88<br>Message-Id: &lt;20261120080412=2E4368-1-gert@greenie=2Emuc=2Ede&gt;<b=
r>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg41709=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M src/openvpnserv/interactive=2Ec<br>M tests/unit_test=
s/openvpnserv/test_openvpnserv=2Ec<br>2 files changed, 24 insertions(+), 28=
 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interactive=2Ec=
 b/src/openvpnserv/interactive=2Ec</span><br><span>index be57d43=2E=2Ebddaf=
86 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</span><br><=
span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -354,24 +354,=
17 @@</span><br><span> /**</span><br><span>  * Check whether the user optio=
ns start with a non-option</span><br><span>  *</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * openvpn=2Eexe takes a lone argument as the conf=
ig file only when there are</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * no other arguments, and takes non-options after the --msg-channel =
handle</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * as its extra=
 parameters=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * op=
envpn=2Eexe takes non-options after the --msg-channel handle the service</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * prepends as its ext=
ra parameters, not as the config file=2E</span><br><span>  *</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * @param  cmdline  openvpn=2Eexe co=
mmand line built by the service</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param  options  user options from the startup data</span><b=
r><span>  *</span><br><span>  * @return BOOL to indicate if the first user =
argument is not an option</span><br><span>  */</span><br><span> static BOOL=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-StartsWithNonOption(c=
onst WCHAR *cmdline)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+StartsWithNonOption(const WCHAR *options)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    int argc;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    WCHAR **argv =3D CommandLineToArgvW(cmd=
line, &amp;argc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
/* &quot;openvpn --msg-channel &lt;handle&gt; &lt;arg&gt;=2E=2E=2E&quot; */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    BOOL ret =3D argv=
 &amp;&amp; argc &gt; 3 &amp;&amp; !IsOption(argv[3]);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    LocalFree(argv);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    return ret;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return !IsOption(options + wcsspn(options, L&quot; \t&quot;));</=
span><br><span> }</span><br><span> </span><br><span> /*</span><br><span>@@ =
-3634,6 +3627,14 @@</span><br><span>         goto out;</span><br><span>    =
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (StartsWithNonOption(sud=2Eoptions))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        ReturnError(pipe, ERROR_STARTUP_DATA,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    L&quot;Options mus=
t start with an option, pass the config file with --config&quot;, 1,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                    &amp;e=
xit_event);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if=
 (!InitializeSecurityDescriptor(&amp;ovpn_sd, SECURITY_DESCRIPTOR_REVISION)=
)</span><br><span>     {</span><br><span>         ReturnLastError(pipe, L&q=
uot;InitializeSecurityDescriptor&quot;);</span><br><span>@@ -3878,14 +3879,=
6 @@</span><br><span>     swprintf(cmdline, cmdline_size, L&quot;openvpn --=
msg-channel %&quot; PRIuPTR L&quot; %ls&quot;,</span><br><span>            =
  (uintptr_t)svc_pipe, sud=2Eoptions);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (StartsWithNonOption(cmdline))</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        ReturnError(pipe, ERROR_STARTUP_=
DATA,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
    L&quot;Options must start with an option, pass the config file with --c=
onfig&quot;, 1,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
              &amp;exit_event);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        goto out;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span>     /*</span><br><span>      * Only authorized users are allowed to=
 use any command line options or</span><br><span>      * have the config fi=
le in locations other than the global config directory=2E</span><br><span>d=
iff --git a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec b/tests/unit_=
tests/openvpnserv/test_openvpnserv=2Ec</span><br><span>index 7db61f7=2E=2Ed=
07fa22 100644</span><br><span>--- a/tests/unit_tests/openvpnserv/test_openv=
pnserv=2Ec</span><br><span>+++ b/tests/unit_tests/openvpnserv/test_openvpns=
erv=2Ec</span><br><span>@@ -304,15 +304,18 @@</span><br><span> static void<=
/span><br><span> test_starts_with_non_option(void **state)</span><br><span>=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(Sta=
rtsWithNonOption(L&quot;openvpn --msg-channel 1 foo=2Eovpn&quot;));</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(StartsWithNon=
Option(L&quot;openvpn --msg-channel 1 \&quot;my vpn=2Eovpn\&quot;&quot;));<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(Starts=
WithNonOption(L&quot;openvpn --msg-channel 1 foo=2Eovpn --verb 3&quot;));</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(StartsW=
ithNonOption(L&quot;openvpn --msg-channel 1 foo=2Eovpn bar&quot;));</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(StartsWithNon=
Option(L&quot;openvpn --msg-channel 1 \&quot;\&quot;&quot;));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_true(StartsWithNonOpti=
on(L&quot;foo=2Eovpn&quot;));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_true(StartsWithNonOption(L&quot;\&quot;my vpn=2Eovpn\&=
quot;&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_true(StartsWithNonOption(L&quot;foo=2Eovpn --verb 3&quot;));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(StartsWithNo=
nOption(L&quot;foo=2Eovpn bar&quot;));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(StartsWithNonOption(L&quot; \tfoo=2Eovpn=
&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_true(StartsWithNonOption(L&quot;\&quot;\&quot;&quot;));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_true(StartsWithNonOption(L&=
quot;&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_true(StartsWithNonOption(L&quot; &quot;));</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    assert_false(StartsWithNon=
Option(L&quot;openvpn --msg-channel 1 &quot;));</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    assert_false(StartsWithNonOption(L&quot;openv=
pn --msg-channel 1 --persist-tun&quot;));</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    assert_false(StartsWithNonOption(L&quot;openvpn --m=
sg-channel 1 --config foo=2Eovpn&quot;));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_false(StartsWithNonOption(L&quot;--persist=
-tun&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_false(StartsWithNonOption(L&quot;--config foo=2Eovpn&quot;));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(StartsWithN=
onOption(L&quot; \t--config foo=2Eovpn&quot;));</span><br><span> }</span><b=
r><span> </span><br><span> static void</span><br></pre><p>To view, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2188?usp=3Demail">chang=
e 2188</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2188?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: I14ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8 </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 2188 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan C=
ojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Lev Stipakov &lt;lstipakov@gmail=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--OE4dtpjWjK4=--


--===============1879429092700198970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1879429092700198970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1879429092700198970==--

