Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBA0CDB46F
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sG9KG/AOZsQni9tdaFLdVuYJC4wwBrttThxsCIt4u0Q=; b=j1LycLVpxPLtkmc0HUsPujgXYm
	KLgxiEix04peGqCNTj/4pHDzXZNHRV3YzpJnVsAaA3A6njlov1N5mSP3FyQRFmu/YHMdpUU5iIRY9
	jsJ2DaxWWlI/HrVXfDZUoGI3ObG470Ofs9A0ogkL6rAEIifsyUgtCcTjOsw+Yn/3KpeE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbeco-0001W5-Pk;
	Mon, 22 Jun 2026 13:23:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbecm-0001Vw-V0
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:23:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=xWzoNFb4SiJY9PHMmUL0cEc0OAt8oYno/ywTAR9qIVs=; b=cbN8hm4hBYyRdO5F5mUsYLIXps
 mOm4RjH3MUj9jA8hLdoMKeZkQAW4SRIX8BVdNS8PsOu1unnlysqjeoU/AoIxyTT0BoOhsUn4SzbV0
 dmm5EbAfllqP5L8SffZw9EiEIMR/+qyt9A7YzNkg9VOg43LJkRbLyqbnaDby3wERXCWg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xWzoNFb4SiJY9PHMmUL0cEc0OAt8oYno/ywTAR9qIVs=; b=g
 kfcC8HxEE+ipadfdHggZPFXaIPVYS/wwurTbNqNZ51YQlW8ydE+CDEmUhUM6yW+qFBI7cweH8t7w8
 gaHqwJlqI9FXwH12ksHgsKODjHPrESdPJbXZ87rKdOIQjcNlc9/PsAwtOzUxobRkABYd1fx/pDy6N
 qYneGuhAmbWU38j8=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbecg-0000ZP-7D for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:23:38 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-490b7866869so43722525e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 06:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782134603; x=1782739403; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xWzoNFb4SiJY9PHMmUL0cEc0OAt8oYno/ywTAR9qIVs=;
 b=gyPT6jga9fyRWQ7V2iZjzTHdzVteocoVa9eKRdeBcjANFQTg6i8mfNudeF3pwSHu6I
 7ufcgCGBDvU56pHZ8mail3IGL+1p/ZfTKGOm2BhQbqo3McHX6PpNZQsqPAQ4NzifNp6f
 xqkJ7kGFNByeoLRwsaGbw69ZU7oGIjSdRujUZl2uabQzhkm7vzyZHXjVX6Aj/LkKnBcw
 bOngG8J6VAHldtlZdU+qweMQ1EECp14dUUmqKl9YuuOe6rbj1MSwLKyk6wJvXpRVn1EO
 lz0Ft3hgkFlu2w6p+W+bOVZ/chkj2G3/H//tOoW3q1wuCG6sj4g+lNwANgGKgQ2oYDma
 YbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782134603; x=1782739403;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xWzoNFb4SiJY9PHMmUL0cEc0OAt8oYno/ywTAR9qIVs=;
 b=sZ0aBTloCjIPrMEKbM92LxILWBXaTbuKFVE6nhM/Zwjv4GVpesIoeEkox+8hKbgWZP
 hgvU1hnNnmZPIrVLQhecwGQbSdykD4wlwqOGJM15zPWeGsT6HE+rypOACgYyB+rOrzPQ
 JWrrM8Z/e0OILfkVyF8Y0fLEmx04S2wmZcfDpQMGSWgUDXv0FJ/wSGdfXqgd1IsqPDSS
 ZA2Kyjsj87nB/RN979VXQvxm2zdD2nmudLJfXLfDgsp+Vb9julXwaIPnH2TdOggSljRP
 bskn+WQr4+nhZ4KZNC3V66Woc5ScxrAiZKfceanlcxMOXUoCnp/HR+K1lEmdb0QmJ9Wz
 1SHQ==
X-Gm-Message-State: AOJu0YzT6z1a7/erlPvDR90tu+YD8QhC/B4Wob7SzG/WeOYCL31/TqxW
 EB98oyLXcY1tpBhOE99CitQv2JRiVyVCcY1FwUUABGpgnjwpTnGL4ov5Qfys63CvXxk+pUbiCJU
 oLx3ulzfYqBRLq7tLgHFO4WNXuAnImEivl7bo9xE42jqxpscUEuxrnuFk/gtD9zEHW9tt2iXNMz
 AfvrFjZA==
X-Gm-Gg: AfdE7cnmrcouL3PnPM/nWtR+2sT8CfIbxg7W7Gzlrqtu2qrtILC7I4i3chLT+iK0fBJ
 E6hmCLc3HeuvubT9ik2P8IY/vwMbeO9ELuvHxx5eEEHg2U38fv0G4sA7JmNopNzWJL8S3+swf3m
 uI3xPvNLokij/2zbMCQaD/K3cCaCJXvwhYQqSSOOvdoR0yrH6K7/krkmU0Hn3gRIaiHD2GAygGY
 htYntf0EX7SakHaxQ6tfmtBveci74qIH1B1tuGw/Pt8pghT2RPIDjRnKrY0OrNFCQvTkcW58McB
 xCuYXMXFvcKmKa3l1qC2pEgRawLpYtU40C5crxvbbY9FzqkeMumTisqOCM2rDLz7pua3pwDW5qB
 qUVk0ZlXqeSoHt0PStdnsZwGOY/kPyLuPnxjprqAas/1LqXvljwrDyp5qk5XAns7F9mYCX1KJXX
 WH4x+/RsH1D/OyXqHFFNPFBM9ChGWwiA4Qt6qx5chlBLPDMojsaKcs/qOyxcVG1huU6teY0XhMp
 ACPmjUxdHUTMUsPMkYixqaweLDzz/3hJnP/Bd8zwhD64mtI94e6HGjuBZNXgPPIfV8DkJSb3D/w
 7Hg=
X-Received: by 2002:a05:600c:528c:b0:492:4a50:41fe with SMTP id
 5b1f17b1804b1-4924a5042b2mr140425535e9.22.1782134602037; 
 Mon, 22 Jun 2026 06:23:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fe7b9e5sm286881485e9.10.2026.06.22.06.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 06:23:21 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 13:23:08 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I355760e43c3e2da0dda0cdec6e4253c028cefe38
X-Gerrit-Change-Number: 1604
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1604?usp=email>
X-Gerrit-Commit: d6d0507d61a11c6ef19e0b96697cd8581e59a63f
In-Reply-To: <gerrit.1775130235000.I355760e43c3e2da0dda0cdec6e4253c028cefe38@gerrit.openvpn.net>
References: <gerrit.1775130235000.I355760e43c3e2da0dda0cdec6e4253c028cefe38@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1MTMwMjM1MDAwLkkzNTU3NjBlNDNjM2UyZGEwZGRhMGNkZWM2ZTQyNTNjMDI4Y2VmZTM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <27aae2a3e7a95004103830dc6c682d05a2541e87-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbecg-0000ZP-7D
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix building
 wolfSSL with CMake
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4005834904391462269=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4005834904391462269==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uRqoY+l92rU="; charset=UTF-8

--uRqoY+l92rU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#2)=2E ( http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1604?usp=3Demail )


Change subject: Fix building wolfSSL w=
ith CMake
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

F=
ix building wolfSSL with CMake

Change-Id: I355760e43c3e2da0dda0cdec6e4253c=
028cefe38
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M CMakeLists=
=2Etxt
1 file changed, 2 insertions(+), 0 deletions(-)


  git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/04/1604/2

diff --git a/CM=
akeLists=2Etxt b/CMakeLists=2Etxt
index 715d02c=2E=2Ec18df2b 100644
--- a/C=
MakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -327,7 +327,9 @@
     elseif (${W=
OLFSSL})
         pkg_search_module(wolfssl wolfssl REQUIRED)
         targ=
et_link_libraries(${target} PUBLIC ${wolfssl_LINK_LIBRARIES})
+        targ=
et_include_directories(${target} PRIVATE ${wolfssl_INCLUDE_DIRS})
         =
target_include_directories(${target} PRIVATE ${wolfssl_INCLUDE_DIRS}/wolfss=
l)
+        target_compile_definitions(${target} PRIVATE EXTERNAL_OPTS_OPEN=
VPN)
     else ()
         find_package(OpenSSL REQUIRED)
         target_l=
ink_libraries(${target} PUBLIC OpenSSL::SSL OpenSSL::Crypto)

-- 
To view, =
visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1604?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: open=
vpn
Gerrit-Branch: master
Gerrit-Change-Id: I355760e43c3e2da0dda0cdec6e4253=
c028cefe38
Gerrit-Change-Number: 1604
Gerrit-PatchSet: 2
Gerrit-Owner: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>

--uRqoY+l92rU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1604?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Fix building wolfSSL with CMake<br><br>Change-Id: I355760e43c3e2d=
a0dda0cdec6e4253c028cefe38<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=
=2Eorg&gt;<br>---<br>M CMakeLists=2Etxt<br>1 file changed, 2 insertions(+),=
 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/04/1604/2</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=
=2Etxt b/CMakeLists=2Etxt</span><br><span>index 715d02c=2E=2Ec18df2b 100644=
</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2E=
txt</span><br><span>@@ -327,7 +327,9 @@</span><br><span>     elseif (${WOLF=
SSL})</span><br><span>         pkg_search_module(wolfssl wolfssl REQUIRED)<=
/span><br><span>         target_link_libraries(${target} PUBLIC ${wolfssl_L=
INK_LIBRARIES})</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    target_include_directories(${target} PRIVATE ${wolfssl_INCLUDE_DIRS})</=
span><br><span>         target_include_directories(${target} PRIVATE ${wolf=
ssl_INCLUDE_DIRS}/wolfssl)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        target_compile_definitions(${target} PRIVATE EXTERNAL_OPTS_O=
PENVPN)</span><br><span>     else ()</span><br><span>         find_package(=
OpenSSL REQUIRED)</span><br><span>         target_link_libraries(${target} =
PUBLIC OpenSSL::SSL OpenSSL::Crypto)</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1604?usp=
=3Demail">change 1604</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1604?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I355760e43c3e2da0dda0cdec6e4253c028cefe38 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1604 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--uRqoY+l92rU=--


--===============4005834904391462269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4005834904391462269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4005834904391462269==--

