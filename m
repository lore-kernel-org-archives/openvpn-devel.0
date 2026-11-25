Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A910F606A31E
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=g3eGVZDU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JOvNNVdb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LWZee47p;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=O0x83YdR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=kLGtURSaNQjBv1v2uhNrlXpjoxpInOsWDxf49Xc9sbI=; b=g3eGVZDUEgVeRHzLdaBODgweFz
	YjWtLTjSHvNj745++kPDy5DNf7zOktibpfysUTfwqE7rg4MzM1N+lUW3sZgePcfBkJu3c5pc8X2Ik
	JIvkS3oCa6OEL5l6F5ryQPovMrschLDwjgcldGQprpZOGpRsVvYWKZCNMnCrDOciKDOU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWDCp-000000001Gt-2glO;
	Wed, 25 Nov 2026 13:38:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWDCo-000000001Gf-0v3e
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 13:38:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7L3GCIY73uldqdPUJ7OHFNo0hhj8bx2O5q19ygK1CUU=; b=JOvNNVdbABv+yTFIrJ/M8gtP3i
 b5uRX1Bl+lHeznYZ8cV3hcXvItCIr9fSddCWrCQbNatr3gZNs9AtZNXVtlIcaGYhj+t8vWvvw8GLO
 PiB1wxfC1tM0jknDMrV0lN/MGt3rmoSy5I04A5kS25FSmC9jotSQmIxGOOCZkR7buHp8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7L3GCIY73uldqdPUJ7OHFNo0hhj8bx2O5q19ygK1CUU=; b=LWZee47pSWDB1HWXQgzDi3yTVT
 F2zKe6JVNbQ2NJ1Ju3dBvDEbEewLoZDYqhdQweLm2cmyCz0Yn7r8PVhYEK5ApdQMmH0KQhdlTPJ4x
 /DBwCoWtPQir7q4eOi1Ep5eXrZ4XhvxpJndovMDG+8jdtK8DgYQxvHMfsZeOU+sNEBuU=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWDCk-000000000RS-0XJF for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 13:38:38 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so74511205e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 05:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795613907; x=1796218707; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7L3GCIY73uldqdPUJ7OHFNo0hhj8bx2O5q19ygK1CUU=;
 b=O0x83YdRsyCh01hpJ5AtI+m7rpMDY1eKuyPgDKC+MnXDk8FLESeYx1T0A/uMLIgDRT
 Un53nI2naAsfZYI14Sw5zPw89igusB2HMVsO3ADblEo3hF4BXqlPILQHhZwDVAIHIMKr
 TqM9Ri68l79MgdVfYrTAp3Au4nub8EGTqWx3uIJJVCUHTrS59dS0fEOMeItY9FATt5kv
 pkae7V5kH3aEPEYEZEdPyMp8XzmJtHs+nq3lGsI51myqiVjYQQdcoqZvdPM4/HVZZciA
 5LEqHH58i7ObkD0bKv9NTkyoPvu3CcdNkUNHsMOCoUVQ9Bv41H3Mhi94FwicICQVihL6
 LjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795613907; x=1796218707;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7L3GCIY73uldqdPUJ7OHFNo0hhj8bx2O5q19ygK1CUU=;
 b=Jx8jXyuBEfRDziGVYDFWRb8oQ5aM9g4t6wDmAYpaQmFq4WAU9dEL/zW436PqvEoYYK
 3CDAT8r5L7/NR/157BbCrM496oTYAX1vHtbLnf7gUaYyE5Hh6w9BeMuabJs8VBf9cQZi
 aj4CbH61YoZh0C7DydsWGfdqVbE6wn+p7oATnt5dKbKZ7Bw3QYlt9DsnOebyeq1vbi8Z
 MwXMhHTyvxTk6hQQecfGSRzHNMmknVF7AUF++W9OlIp31629Vy+25edJhEwrTaqfg2HZ
 74jJveGD2AdjF90V06FdKgjDx/5pYZAFn8g/32+0nPmiQN7Fo/OzgWrqgfJs7OR+RuQV
 +1JQ==
X-Gm-Message-State: APuU4Z8prHlXbVmo9LgCzEJVzTDNTkmY5eJBR40OhQyJ/vtTWHlXWaJF
 JO4Dbh1xgCmygCySZ092riNvIdXOM34jQ+aaZ5utQDqvtyesFhIMy3OuH6J5DOwcwhINSfr+ub1
 6Sc1CmVUGxJi1yOiwbzQ2OLCKXyvepppT/BGdl46lrZVX1Uhs0UEBUWytEyOsTQHWscZ/i0/bug
 zDMA4FIA==
X-Gm-Gg: AZFdTZe9mO6bQtWhw3bXhrNHytN6AQ/pc0X2snVsGEK2v47c+gcnvDWwkfNmKN34BNl
 q6GoihqBcN3rgUQbcoOPi9YB4/oGquzZWnIv2Sv5NkYyqYtHRF/XcVidAlPTTmggpHD+/eZ59bc
 50/8Pd/XsT3jxMDUkza/pYpDM4LnRfkt7koPULVFw8WFVva06gSaqeEbEYKx8jbCr4aN0wLRMkY
 +tINg26gwbwmQDRWbUYy6pRR6VaCu+JlHeSjGPfP8SArRwgFQZ8Srs68j1XLsk+pBwDsqJfAgPE
 n0gBWNV9oPymFQBt8DnqjSKIEFLzeM0yBZBnVpCdVL7kOlvLMO4MIfniEjCj99G/697LQXLUrJ/
 CIhscxmTK1Dpe+dpZjExhxRkc8uFobJRtgIfPKf6bbYcULYLxkC4GoqVbf+uRVdSkKgpzREWN8P
 sf2kFQcR1PKPbB1GrF09QA+xAV80pLbUNjwdq43GD/9D0c3JnQAQRabM9SMw3RVTBGFfyxbvwkS
 pZ5wtex+2YlQhHMQq8ma/SSzXUlYXseUxmQ4gyiwLL5EdhJRsLIYg9JJrsH/gkBTIYmd97DpNvS
 17p799lZ2VViSCbjX781+zRMN9/gPrDY/qALwBWHdwsmTX8bwHE6eHkTMnMebDN4jtjCiwTaD9b
 2rf3ApLHa0Q48W38dGLiBR5ny3G0Z1iqjORYO9kkdEMhPBLuyZjw1TcYCCUuwPv3yXcgF4rwy1x
 OeS697RDO/JhSsOpyqH98rVXBy+EUAmjTj9MoW
X-Received: by 2002:a05:600c:1d83:b0:4bb:687c:4fbe with SMTP id
 5b1f17b1804b1-4bb88805c26mr319817775e9.8.1795613907401; 
 Wed, 25 Nov 2026 05:38:27 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906c089dsm294583655e9.1.2026.11.25.05.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 05:38:27 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 13:38:26 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I8d081c87af0d746a5e3a2382567f04332639622a
X-Gerrit-Change-Number: 2343
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2343?usp=email>
X-Gerrit-Commit: 0b99b1351ba3803055b067ed1ed059e315aa9340
References: <gerrit.1795613903000.I8d081c87af0d746a5e3a2382567f04332639622a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NjEzOTAzMDAwLkk4ZDA4MWM4N2FmMGQ3NDZhNWUzYTIzODI1NjdmMDQzMzI2Mzk2MjJhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2717ce242bf338b4b6347aab40ddd05181a2e6e6-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWDCk-000000000RS-0XJF
Subject: [Openvpn-devel] [S] Change in openvpn[master]: cppcheck: Add more
 printf-style functions
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8507080902895570677=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8507080902895570677==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/Sby4AoZ8Cw="; charset=UTF-8

--/Sby4AoZ8Cw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2343?usp=3Demail

to review the following change=2E
=


Change subject: cppcheck: Add more printf-style functions
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

cppcheck: Add more printf-st=
yle functions

Also fix the two issues raised by this=2E

Change-Id: I8d081=
c87af0d746a5e3a2382567f04332639622a
Signed-off-by: Frank Lichtenheld <frank=
@lichtenheld=2Ecom>
---
M dev-tools/openvpn-cppcheck-library=2Ecfg
M dev-to=
ols/openvpn-cppcheck-windows=2Ecfg
M src/openvpn/networking_iproute2=2Ec
M =
src/openvpnserv/interactive=2Ec
4 files changed, 14 insertions(+), 2 deleti=
ons(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/43/2343/1

diff --git a/dev-tools/openvpn-cppcheck-library=2Ecfg b/dev-to=
ols/openvpn-cppcheck-library=2Ecfg
index 0537b39=2E=2E37195d8 100644
--- a/=
dev-tools/openvpn-cppcheck-library=2Ecfg
+++ b/dev-tools/openvpn-cppcheck-l=
ibrary=2Ecfg
@@ -6,6 +6,12 @@
       <formatstr />
     </arg>
   </functio=
n>
+  <function name=3D"argv_printf">
+    <formatstr type=3D"printf"/>
+  =
  <arg nr=3D"2">
+      <formatstr />
+    </arg>
+  </function>
   <functi=
on name=3D"buf_printf">
     <formatstr type=3D"printf"/>
     <arg nr=3D"2=
">
diff --git a/dev-tools/openvpn-cppcheck-windows=2Ecfg b/dev-tools/openvp=
n-cppcheck-windows=2Ecfg
index 932d586=2E=2Edca2b07 100644
--- a/dev-tools/=
openvpn-cppcheck-windows=2Ecfg
+++ b/dev-tools/openvpn-cppcheck-windows=2Ec=
fg
@@ -2,6 +2,12 @@
 <!-- Only used for the Windows run=2E Can't be in open=
vpn-cppcheck-library=2Ecfg
      because it conflicts with gnu=2Ecfg=2E -->=

 <def>
+  <function name=3D"MsgToEventLog">
+    <formatstr type=3D"printf=
"/>
+    <arg nr=3D"2">
+      <formatstr />
+    </arg>
+  </function>
   =
<!-- MinGW uses GCC, so we need to handle GCC builtins=2E gnu=2Ecfg has the=
se,
        but we do not load it for Windows=2E Without this cppcheck does=
 not
        understand our likely()/unlikely() macros=2E -->
diff --git a/=
src/openvpn/networking_iproute2=2Ec b/src/openvpn/networking_iproute2=2Ec
i=
ndex 6c4c8f4=2E=2Eb079757 100644
--- a/src/openvpn/networking_iproute2=2Ec
=
+++ b/src/openvpn/networking_iproute2=2Ec
@@ -112,7 +112,7 @@
 {
     struc=
t argv argv =3D argv_new();
 
-    argv_printf(&argv, "%s link set dev %s u=
p mtu %d", iproute_path, iface, mtu);
+    argv_printf(&argv, "%s link set =
dev %s up mtu %u", iproute_path, iface, mtu);
     argv_msg(M_INFO, &argv);=

     openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip link set fail=
ed");
 
diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/inte=
ractive=2Ec
index be57d43=2E=2Ead0fda2 100644
--- a/src/openvpnserv/interac=
tive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -466,7 +466,7 @@
     siz=
e =3D bytes / sizeof(*data);
     if ((size =3D=3D 0) || (size > 4096)) /* =
our startup data is 1024 wchars at the moment */
     {
-        MsgToEvent=
Log(M_SYSERR, L"malformed startup data: %lu bytes received", size);
+      =
  MsgToEventLog(M_SYSERR, L"malformed startup data: %zu bytes received", si=
ze);
         ReturnError(pipe, ERROR_STARTUP_DATA, L"GetStartupData", 1, &=
exit_event);
         goto err;
     }

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2343?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: I8d081c87af0d746a5e3a2382567f04332639622a
Gerrit-Ch=
ange-Number: 2343
Gerrit-PatchSet: 1
Gerrit-Owner: Frank Lichtenheld <frank=
@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--/Sby4AoZ8Cw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2343?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">cppcheck: Add more printf-style functions<br><br>Also fix =
the two issues raised by this=2E<br><br>Change-Id: I8d081c87af0d746a5e3a238=
2567f04332639622a<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt;<br>---<br>M dev-tools/openvpn-cppcheck-library=2Ecfg<br>M dev-to=
ols/openvpn-cppcheck-windows=2Ecfg<br>M src/openvpn/networking_iproute2=2Ec=
<br>M src/openvpnserv/interactive=2Ec<br>4 files changed, 14 insertions(+),=
 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/43/2343/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/dev-tools/=
openvpn-cppcheck-library=2Ecfg b/dev-tools/openvpn-cppcheck-library=2Ecfg</=
span><br><span>index 0537b39=2E=2E37195d8 100644</span><br><span>--- a/dev-=
tools/openvpn-cppcheck-library=2Ecfg</span><br><span>+++ b/dev-tools/openvp=
n-cppcheck-library=2Ecfg</span><br><span>@@ -6,6 +6,12 @@</span><br><span> =
      &lt;formatstr /&gt;</span><br><span>     &lt;/arg&gt;</span><br><span=
>   &lt;/function&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  &lt;function name=3D&quot;argv_printf&quot;&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &lt;formatstr type=3D&quot;printf&quo=
t;/&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;arg =
nr=3D&quot;2&quot;&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+      &lt;formatstr /&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    &lt;/arg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  &lt;/function&gt;</span><br><span>   &lt;function name=3D&quot;buf_=
printf&quot;&gt;</span><br><span>     &lt;formatstr type=3D&quot;printf&quo=
t;/&gt;</span><br><span>     &lt;arg nr=3D&quot;2&quot;&gt;</span><br><span=
>diff --git a/dev-tools/openvpn-cppcheck-windows=2Ecfg b/dev-tools/openvpn-=
cppcheck-windows=2Ecfg</span><br><span>index 932d586=2E=2Edca2b07 100644</s=
pan><br><span>--- a/dev-tools/openvpn-cppcheck-windows=2Ecfg</span><br><spa=
n>+++ b/dev-tools/openvpn-cppcheck-windows=2Ecfg</span><br><span>@@ -2,6 +2=
,12 @@</span><br><span> &lt;!-- Only used for the Windows run=2E Can&#39;t =
be in openvpn-cppcheck-library=2Ecfg</span><br><span>      because it confl=
icts with gnu=2Ecfg=2E --&gt;</span><br><span> &lt;def&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  &lt;function name=3D&quot;MsgToEve=
ntLog&quot;&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
&lt;formatstr type=3D&quot;printf&quot;/&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &lt;arg nr=3D&quot;2&quot;&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+      &lt;formatstr /&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;/arg&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  &lt;/function&gt;</span><br><s=
pan>   &lt;!-- MinGW uses GCC, so we need to handle GCC builtins=2E gnu=2Ec=
fg has these,</span><br><span>        but we do not load it for Windows=2E =
Without this cppcheck does not</span><br><span>        understand our likel=
y()/unlikely() macros=2E --&gt;</span><br><span>diff --git a/src/openvpn/ne=
tworking_iproute2=2Ec b/src/openvpn/networking_iproute2=2Ec</span><br><span=
>index 6c4c8f4=2E=2Eb079757 100644</span><br><span>--- a/src/openvpn/networ=
king_iproute2=2Ec</span><br><span>+++ b/src/openvpn/networking_iproute2=2Ec=
</span><br><span>@@ -112,7 +112,7 @@</span><br><span> {</span><br><span>   =
  struct argv argv =3D argv_new();</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s link se=
t dev %s up mtu %d&quot;, iproute_path, iface, mtu);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    argv_printf(&amp;argv, &quot;%s link =
set dev %s up mtu %u&quot;, iproute_path, iface, mtu);</span><br><span>    =
 argv_msg(M_INFO, &amp;argv);</span><br><span>     openvpn_execve_check(&am=
p;argv, ctx-&gt;es, S_FATAL, &quot;Linux ip link set failed&quot;);</span><=
br><span> </span><br><span>diff --git a/src/openvpnserv/interactive=2Ec b/s=
rc/openvpnserv/interactive=2Ec</span><br><span>index be57d43=2E=2Ead0fda2 1=
00644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</span><br><span=
>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -466,7 +466,7 @@<=
/span><br><span>     size =3D bytes / sizeof(*data);</span><br><span>     i=
f ((size =3D=3D 0) || (size &gt; 4096)) /* our startup data is 1024 wchars =
at the moment */</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        MsgToEventLog(M_SYSERR, L&quot;malformed startup =
data: %lu bytes received&quot;, size);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        MsgToEventLog(M_SYSERR, L&quot;malformed startup=
 data: %zu bytes received&quot;, size);</span><br><span>         ReturnErro=
r(pipe, ERROR_STARTUP_DATA, L&quot;GetStartupData&quot;, 1, &amp;exit_event=
);</span><br><span>         goto err;</span><br><span>     }</span><br></pr=
e><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
343?usp=3Demail">change 2343</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2343?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newch=
ange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<di=
v style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Id: I8d081c87af0d746a5e3a2382567f04332639622a </div>=

<div style=3D"display:none"> Gerrit-Change-Number: 2343 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> G=
errit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>

</body></html>
--/Sby4AoZ8Cw=--


--===============8507080902895570677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8507080902895570677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8507080902895570677==--

