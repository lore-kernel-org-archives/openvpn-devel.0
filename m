Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73474606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 18:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jzTHVIIo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UVJXHaHn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=E3b7iz+5;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=fEgLCLP0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tbAmMH+qfsxt+2w4QAPzx8MPbC0iBu+0tQf3e/nPH0o=; b=jzTHVIIo5D+Hveg1Ux47gU0RWH
	65MJukRcYzcZ9HfUUcnitR9pfFJiyrjp8iOL4DWK4MF+H1e47yF7417J1OmPEgbDGQc/vpYZ7fRhg
	szYPiNeKEIOIcABPuWAtIx9xshzIl7lDRu3WGRA3KpiA/Ht/lh2kVvTtMS5hzz41pJ5w=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMUnR-000000001ai-2Lko;
	Thu, 29 Oct 2026 18:24:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMUnQ-000000001ac-3YFP
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 18:24:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CUR8Y3y+KMFl+vcBiqeV9bfuqdRj/Rh/4MEqq4JLF5E=; b=UVJXHaHn3r2FpJwXwcggIPnrM2
 7UwWs4+UI1xxYB8FzVtrhL6hKkw+IrVcAmpTbp87T3w1t+Uq1KlOjQtYJDqq/CbuHD2D4i73D0Ygn
 aMwbWMysi+2L2xaI+LbJwfou5WxZUdj+azhvG10L4/q9tbcctokEca5lfA2YTHXzjXRI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CUR8Y3y+KMFl+vcBiqeV9bfuqdRj/Rh/4MEqq4JLF5E=; b=E3b7iz+5jA0FbfuwaFq3iI/g2P
 wwADYkd5CI9FPT/GFNHgLpohrc7oVMOvwQ5wRigyyE3om6gFmo4HfJU0zU8emSTZ+L3GTjjFkTuVz
 +0dCzkPBqD/l95irxQMAZq4IXWl8UA4iG0OTznSN4ym4DbHxSEFinkoP2mC4yFtdl0r0=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMUnM-000000002d4-0Qfl for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 18:24:16 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48e20edd106so1955411f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 11:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793298245; x=1793903045; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CUR8Y3y+KMFl+vcBiqeV9bfuqdRj/Rh/4MEqq4JLF5E=;
 b=fEgLCLP0i4MC9YfANm+F0dFlUyksbv/2SNbiy+HYs/HOhOSV+fK7fyTnXUMmBlsocP
 SUdTUmJxUTu1U0SV76awEz6378y7A9yroy3IBs9Cah7w0R7Pwj0NLdyuyVxMB4pmdADj
 XC1PGNFfp/Ey6Q++CLvI3peC2c2XqgoJ1/xdthG4nockLoCELqkbtFZTeNcOwrjsEgzn
 jD4/2vrlHsGKjMhz5iBUELhy6elB06idWuXmJNfkrx84mexRsvG/cHSnn6bwnDDqcE49
 psju3JQkw0peizIGQsebmoI2aNJnSqlEiS9JPRuct/JNxc9Cs1TGxqaNaomlDCE9OYyc
 2/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793298245; x=1793903045;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CUR8Y3y+KMFl+vcBiqeV9bfuqdRj/Rh/4MEqq4JLF5E=;
 b=Mdclt/ZJa/Em9Na7xOCUMiBJeVZEP70pLhfgc8yVkFurJmyaRYzwjWSEukFrf7bMnp
 FHyv+pWkeDZLhZESQ7kDB7hn4EQlOXFgbbEoprJFhODaRCsiixUfU1rZA8TNG8MSgkp/
 gOuTJhNe+SUCHU5xoI51bbABRYOI5xPESjTE6q9QHVRiD8ZfyHysjBOad37S1oHzA1Vu
 xAHtw9i6Kkiwc9aOJ3wG9Q75oW51ZLuBFJEBvLhQgterWHMzMCfnFhh2Je5Gh7NgstZh
 xt+tEum/Z59wzFUKNjR+CybY7jTBJXF0RFjsjYHzDiX1iv2eNt3FwBIwpK5A1D3Dg6J6
 H/1A==
X-Gm-Message-State: AFq9FYLCyia+BERUKIegEctmV5qQEmMDxj77iqB1fhoH5PTOC7cI0SKI
 eN7ItLhC7D07TkdCydm/Nt/qJzioTdJ3/6EKtQCR4tEFphB5JJ5trvS/PLwyxrbPcJiCWXl35fo
 pXEkXBH87ERDBNpnbkmf5PPsvaFRPdbqBQUK/+yeYkB4NLryP+lRB70Wi7Xth9U6XAVo3
X-Gm-Gg: AYBFou3BymH/z03P3OElLdNUov2/6/GfyVWz2Nq5f6wXdSEML0CnzpGfcDf7IvQkCs0
 NR4eeJ6l2/oxs3QVuTVH9dsH3+nh+TDFs3zoCUGoPqPpHBNJTqgMYnk9X+BvqBOC7FkXskTxXvs
 PAP4O+t/vXVPQdkUL+Eq/av2d51tCcArjmio55alPaNjbFUMd0cGWbbdWPtk82IU0wzuNP7pkkd
 Rk/zxtbQcRaFOHjbXJMjDPOZeZs74ka6HquzpsOOY6WjKy4YUbSu6EbwSloh6gZaYpYB7lbOX0J
 YPiHr9KKizcpCT6SaSpcE9rWBrcB/EixG66oMT4tvXrlUsU5wuOprCCpsWtq461j/JKUOooPeL2
 sZ5bg1hxLKQsJJnYh/d7Ni/a+FuE9GjEhT7A77OG1ZLwmt1P4+h9li1I64Ykmp0ti3ffRCYB4C5
 DF37XhZSrAEVlS3/oDt1QgYYbFWs23oNYGLs4FNHSqUA0Wr/599hS0kPTBBtku2K76/ILr2l81R
 RRY3Tatt6UEd6zw0AmxPcKGdSFSdh2F4da8gthXdnderKRtyp4VR0sWQK9sq9Mu147D6Cwp99gJ
 9b4mkVSHclwQE4/ylbKHFjXJP6HzkdqoZDX004XQxMCAg/rURMWGMRF5pi5mRERBUEaU/fmjeLf
 l4+BQn4WMlS0MmVzPc3hyD6XwIeS7UakY2Ana3E83fFOmEcC3I8ekytkIFICYb/cgf7l9dVZS1t
 fXSXD6rcVmzwcXDMM=
X-Received: by 2002:a05:6000:719:b0:48d:fbf4:895d with SMTP id
 ffacd0b85a97d-48e6e2e7552mr484824f8f.19.1793298245183; 
 Thu, 29 Oct 2026 11:24:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6eb7766csm88911f8f.18.2026.10.29.11.24.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 11:24:04 -0700 (PDT)
X-Google-Original-From: "srkyn (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 29 Oct 2026 18:24:03 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55
X-Gerrit-Change-Number: 1881
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1881?usp=email>
X-Gerrit-Commit: aa282bbb84187cc76c48f8a8805e14eb31ed95a7
In-Reply-To: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
References: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3ODQ5Njc4MDAwLklhY2Q1NmQyNDVlOWFiMzBjZmIyNWIyYjM2NGNhNjYxZmEyODlkYzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8df10a95e0e2484f735a219112306a4e4886442f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMUnM-000000002d4-0Qfl
Subject: [Openvpn-devel] [L] Change in openvpn[master]: compat: close all
 unrelated fds in forked helpers
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "srkyn \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: david@srkyn.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "srkyn \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4075909738635164775=="
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4075909738635164775==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="f+DaYTJ7rSI="; charset=UTF-8

--f+DaYTJ7rSI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Gert Doering, R=C4=83zvan Cojocaru, s=
rkyn=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to reexam=
ine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1881?usp=3Demail

to look at the new patch set (#6)=2E

The following app=
rovals got outdated and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru=


The change is no longer submittable: Code-Review and checks~ChecksSubmitR=
ule are unsatisfied now=2E


Change subject: compat: close all unrelated fd=
s in forked helpers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

compat: close all unrelated fds in forked helpers

The forked auth-=
pam, down-root, and port-share helpers only closed
descriptor numbers 3 thr=
ough 100=2E Descriptors above that range could
remain open in long-lived he=
lper processes, including helpers that
intentionally retain privilege=2E

A=
dd a shared compatibility helper that uses close_range() when available
and=
 falls back to the process descriptor limit=2E Preserve the helper
command =
socket and add coverage for both low and high preserved
descriptors=2E

Cha=
nge-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55
Signed-off-by: David Sark=
isyan <david@srkyn=2Ecom>
---
M CMakeLists=2Etxt
M config=2Eh=2Ecmake=2Ein
=
M configure=2Eac
M src/compat/Makefile=2Eam
A src/compat/compat-close-fds=
=2Ec
A src/compat/compat-close-fds=2Eh
M src/openvpn/ps=2Ec
M src/plugins/a=
uth-pam/Makefile=2Eam
M src/plugins/auth-pam/auth-pam=2Ec
M src/plugins/dow=
n-root/Makefile=2Eam
M src/plugins/down-root/down-root=2Ec
M tests/unit_tes=
ts/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/test_misc=2Ec
13 files =
changed, 296 insertions(+), 73 deletions(-)


  git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/81/1881/6

diff --git a/CMakeLists=2E=
txt b/CMakeLists=2Etxt
index 184a95a=2E=2Ee842317 100644
--- a/CMakeLists=
=2Etxt
+++ b/CMakeLists=2Etxt
@@ -19,6 +19,7 @@
 include(CheckLinkerFlag OP=
TIONAL)
 include(CheckTypeSize)
 include(CheckStructHasMember)
+include(CMa=
kePushCheckState)
 include(CTest)
 
 option(UNSUPPORTED_BUILDS "Allow unsup=
ported builds" OFF)
@@ -197,6 +198,10 @@
     check_symbol_exists(fork unis=
td=2Eh HAVE_FORK)
     check_symbol_exists(execve unistd=2Eh HAVE_EXECVE)
 =
    check_symbol_exists(ftruncate unistd=2Eh HAVE_FTRUNCATE)
+    cmake_pus=
h_check_state()
+    list(APPEND CMAKE_REQUIRED_DEFINITIONS -D_GNU_SOURCE)
=
+    check_symbol_exists(close_range unistd=2Eh HAVE_CLOSE_RANGE)
+    cmak=
e_pop_check_state()
     check_symbol_exists(nice unistd=2Eh HAVE_NICE)
   =
  check_symbol_exists(setgid unistd=2Eh HAVE_SETGID)
     check_symbol_exis=
ts(setuid unistd=2Eh HAVE_SETUID)
@@ -435,6 +440,8 @@
     src/compat/compa=
t-strlcpy=2Ec
     src/compat/compat-strsep=2Ec
     src/compat/compat-strt=
ok_r=2Ec
+    src/compat/compat-close-fds=2Ec
+    src/compat/compat-close-=
fds=2Eh
     src/openvpn/argv=2Ec
     src/openvpn/argv=2Eh
     src/openvp=
n/base64=2Ec
@@ -869,6 +876,11 @@
         src/openvpn/siphash_reference=2E=
c
         src/openvpn/session_id=2Ec
     )
+    if (NOT WIN32)
+        t=
arget_sources(test_misc PRIVATE
+            src/compat/compat-close-fds=2E=
c
+        )
+    endif ()
 
     target_sources(test_ncp PRIVATE
         =
src/openvpn/crypto_epoch=2Ec
diff --git a/config=2Eh=2Ecmake=2Ein b/config=
=2Eh=2Ecmake=2Ein
index 483de45=2E=2Ed87d298 100644
--- a/config=2Eh=2Ecmak=
e=2Ein
+++ b/config=2Eh=2Ecmake=2Ein
@@ -75,6 +75,9 @@
 /* Define to 1 if y=
ou have the `chsize' function=2E */
 #cmakedefine HAVE_CHSIZE
 
+/* Define =
to 1 if you have the `close_range' function=2E */
+#cmakedefine HAVE_CLOSE_=
RANGE
+
 /* struct cmsghdr needed for extended socket error support */
 #cm=
akedefine HAVE_CMSGHDR
 
diff --git a/configure=2Eac b/configure=2Eac
index=
 0ac61b4=2E=2Eda5ffb6 100644
--- a/configure=2Eac
+++ b/configure=2Eac
@@ -=
563,7 +563,7 @@
 	syslog openlog mlockall getrlimit getgrnam setgid \
 	set=
groups flock gettimeofday \
 	setsid chdir \
-	chsize ftruncate execve getp=
eereid basename dirname \
+	chsize ftruncate execve getpeereid basename dir=
name close_range \
 	epoll_create strlcpy strsep strtok_r \
 ])
 
diff --gi=
t a/src/compat/Makefile=2Eam b/src/compat/Makefile=2Eam
index 8b1d44a=2E=2E=
db65edd 100644
--- a/src/compat/Makefile=2Eam
+++ b/src/compat/Makefile=2Ea=
m
@@ -16,6 +16,7 @@
 
 libcompat_la_SOURCES =3D \
 	compat=2Eh \
+	compat-c=
lose-fds=2Ec compat-close-fds=2Eh \
 	compat-dirname=2Ec \
 	compat-basenam=
e=2Ec \
 	compat-gettimeofday=2Ec \
diff --git a/src/compat/compat-close-fd=
s=2Ec b/src/compat/compat-close-fds=2Ec
new file mode 100644
index 0000000=
=2E=2Ef3a266c
--- /dev/null
+++ b/src/compat/compat-close-fds=2Ec
@@ -0,0 +=
1,74 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+=
 *             over a single UDP port, with support for SSL/TLS-based
+ *  =
           session authentication and key exchange,
+ *             packet =
encryption, packet authentication, and
+ *             packet compression=
=2E
+ *
+ *  Copyright (C) 2026 David Sarkisyan
+ *
+ *  This program is fr=
ee software; you can redistribute it and/or modify
+ *  it under the terms =
of the GNU General Public License version 2
+ *  as published by the Free S=
oftware Foundation=2E
+ *
+ *  This program is distributed in the hope that=
 it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied=
 warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  S=
ee the
+ *  GNU General Public License for more details=2E
+ *
+ *  You sho=
uld have received a copy of the GNU General Public License along
+ *  with =
this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#i=
fdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#ifndef _WIN32
+
+#inc=
lude "compat-close-fds=2Eh"
+
+#include <limits=2Eh>
+#include <stdbool=2Eh=
>
+#include <unistd=2Eh>
+#include <syslog=2Eh>
+
+void
+close_fds_except(i=
nt keep)
+{
+    closelog();
+
+#ifdef HAVE_CLOSE_RANGE
+    bool closed =
=3D true;
+    unsigned int first =3D 3;
+    if (keep >=3D 3)
+    {
+    =
    if (keep > 3)
+        {
+            closed =3D close_range(3, (unsign=
ed int)keep - 1, 0) =3D=3D 0;
+        }
+        first =3D (unsigned int)k=
eep + 1;
+    }
+    closed =3D close_range(first, ~0U, 0) =3D=3D 0 && clos=
ed;
+    if (closed)
+    {
+        return;
+    }
+#endif
+
+    const lo=
ng open_max =3D sysconf(_SC_OPEN_MAX);
+    int max_fd =3D 1024;
+    if (o=
pen_max > 0)
+    {
+        max_fd =3D open_max > INT_MAX ? INT_MAX : (int=
)open_max;
+    }
+    for (int fd =3D 3; fd < max_fd; ++fd)
+    {
+      =
  if (fd !=3D keep)
+        {
+            close(fd);
+        }
+    }
+}=

+
+#endif /* !_WIN32 */
diff --git a/src/compat/compat-close-fds=2Eh b/src=
/compat/compat-close-fds=2Eh
new file mode 100644
index 0000000=2E=2E848094=
1
--- /dev/null
+++ b/src/compat/compat-close-fds=2Eh
@@ -0,0 +1,38 @@
+/*
=
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *          =
   over a single UDP port, with support for SSL/TLS-based
+ *             s=
ession authentication and key exchange,
+ *             packet encryption, =
packet authentication, and
+ *             packet compression=2E
+ *
+ *  C=
opyright (C) 2026 David Sarkisyan
+ *
+ *  This program is free software; y=
ou can redistribute it and/or modify
+ *  it under the terms of the GNU Gen=
eral Public License version 2
+ *  as published by the Free Software Founda=
tion=2E
+ *
+ *  This program is distributed in the hope that it will be us=
eful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+=
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GN=
U General Public License for more details=2E
+ *
+ *  You should have recei=
ved a copy of the GNU General Public License along
+ *  with this program; =
if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifndef COMPAT_C=
LOSE_FDS_H
+#define COMPAT_CLOSE_FDS_H
+
+#ifndef _WIN32
+/**
+ * Close des=
criptors inherited across fork that are unrelated to a helper=2E
+ *
+ * St=
andard input, standard output, standard error, and @p keep remain open=2E
+=
 * All other file descriptors starting at 3 are closed=2E
+ *
+ * @param ke=
ep file descriptor used for communication with the parent process
+ */
+voi=
d close_fds_except(int keep);
+#endif
+
+#endif /* COMPAT_CLOSE_FDS_H */
di=
ff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec
index 03c6f48=2E=2E986f0=
d2 100644
--- a/src/openvpn/ps=2Ec
+++ b/src/openvpn/ps=2Ec
@@ -34,6 +34,7 =
@@
 #include "crypto=2Eh"
 #include "resolve=2Eh"
 #include "ps=2Eh"
+#incl=
ude "compat-close-fds=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -86,30 +87,6 @@
 }=

 
 /*
- * Close most of parent's fds=2E
- * Keep stdin/stdout/stderr, plus=
 one
- * other fd which is presumed to be
- * our pipe back to parent=2E
- =
* Admittedly, a bit of a kludge,
- * but posix doesn't give us a kind
- * o=
f FD_CLOEXEC which will stop
- * fds from crossing a fork()=2E
- */
-static=
 void
-close_fds_except(int keep)
-{
-    socket_descriptor_t i;
-    close=
log();
-    for (i =3D 3; i <=3D 100; ++i)
-    {
-        if (i !=3D keep)=

-        {
-            openvpn_close_socket(i);
-        }
-    }
-}
-
-/=
*
  * Usually we ignore signals, because our parent will
  * deal with them=
=2E
  */
diff --git a/src/plugins/auth-pam/Makefile=2Eam b/src/plugins/auth=
-pam/Makefile=2Eam
index e6dc27e=2E=2Efb7fd30 100644
--- a/src/plugins/auth=
-pam/Makefile=2Eam
+++ b/src/plugins/auth-pam/Makefile=2Eam
@@ -9,6 +9,7 @@=

 
 AM_CFLAGS =3D \
 	-I$(top_srcdir)/include \
+	-I$(top_srcdir)/src/compa=
t \
 	$(PLUGIN_AUTH_PAM_CFLAGS) \
 	$(OPTIONAL_CRYPTO_CFLAGS)
 
@@ -23,6 +2=
4,7 @@
 	pamdl=2Ec  pamdl=2Eh \
 	auth-pam=2Eexports
 openvpn_plugin_auth_p=
am_la_LIBADD =3D \
+	$(top_builddir)/src/compat/libcompat=2Ela \
 	$(PLUGIN=
_AUTH_PAM_LIBS)
 openvpn_plugin_auth_pam_la_LDFLAGS =3D $(AM_LDFLAGS) \
 	-=
export-symbols "$(srcdir)/auth-pam=2Eexports" \
diff --git a/src/plugins/au=
th-pam/auth-pam=2Ec b/src/plugins/auth-pam/auth-pam=2Ec
index 948b6af=2E=2E=
a3fd3aa 100644
--- a/src/plugins/auth-pam/auth-pam=2Ec
+++ b/src/plugins/au=
th-pam/auth-pam=2Ec
@@ -51,6 +51,8 @@
 #include <arpa/inet=2Eh>
 #include <=
openvpn-plugin=2Eh>
 
+#include "compat-close-fds=2Eh"
+
 #define DEBUG(ver=
b) ((verb) >=3D 4)
 
 /* Command codes for foreground -> background communi=
cation */
@@ -240,30 +242,6 @@
 #endif /* ifdef DO_DAEMONIZE */
 
 /*
- * C=
lose most of parent's fds=2E
- * Keep stdin/stdout/stderr, plus one
- * oth=
er fd which is presumed to be
- * our pipe back to parent=2E
- * Admittedly=
, a bit of a kludge,
- * but posix doesn't give us a kind
- * of FD_CLOEXEC=
 which will stop
- * fds from crossing a fork()=2E
- */
-static void
-close=
_fds_except(int keep)
-{
-    int i;
-    closelog();
-    for (i =3D 3; i =
<=3D 100; ++i)
-    {
-        if (i !=3D keep)
-        {
-            clo=
se(i);
-        }
-    }
-}
-
-/*
  * Usually we ignore signals, because ou=
r parent will
  * deal with them=2E
  */
diff --git a/src/plugins/down-root=
/Makefile=2Eam b/src/plugins/down-root/Makefile=2Eam
index 7ca5a4e=2E=2E83b=
c04f 100644
--- a/src/plugins/down-root/Makefile=2Eam
+++ b/src/plugins/dow=
n-root/Makefile=2Eam
@@ -9,6 +9,7 @@
 
 AM_CFLAGS =3D \
 	-I$(top_srcdir)/i=
nclude \
+	-I$(top_srcdir)/src/compat \
 	$(OPTIONAL_CRYPTO_CFLAGS)
 
 if E=
NABLE_PLUGIN_DOWN_ROOT
@@ -19,6 +20,8 @@
 openvpn_plugin_down_root_la_SOURC=
ES =3D \
 	down-root=2Ec \
 	down-root=2Eexports
+openvpn_plugin_down_root_=
la_LIBADD =3D \
+	$(top_builddir)/src/compat/libcompat=2Ela
 openvpn_plugin=
_down_root_la_LDFLAGS =3D $(AM_LDFLAGS) \
 	-export-symbols "$(srcdir)/down=
-root=2Eexports" \
 	-module -shared -avoid-version -no-undefined
diff --gi=
t a/src/plugins/down-root/down-root=2Ec b/src/plugins/down-root/down-root=
=2Ec
index cd57189=2E=2E3f71cdd 100644
--- a/src/plugins/down-root/down-roo=
t=2Ec
+++ b/src/plugins/down-root/down-root=2Ec
@@ -44,6 +44,8 @@
 
 #inclu=
de <openvpn-plugin=2Eh>
 
+#include "compat-close-fds=2Eh"
+
 #define DEBUG=
(verb) ((verb) >=3D 7)
 
 /* Command codes for foreground -> background com=
munication */
@@ -191,30 +193,6 @@
 }
 
 /*
- * Close most of parent's fds=
=2E
- * Keep stdin/stdout/stderr, plus one
- * other fd which is presumed t=
o be
- * our pipe back to parent=2E
- * Admittedly, a bit of a kludge,
- * =
but posix doesn't give us a kind
- * of FD_CLOEXEC which will stop
- * fds =
from crossing a fork()=2E
- */
-static void
-close_fds_except(int keep)
-{
=
-    int i;
-    closelog();
-    for (i =3D 3; i <=3D 100; ++i)
-    {
-  =
      if (i !=3D keep)
-        {
-            close(i);
-        }
-    }
=
-}
-
-/*
  * Usually we ignore signals, because our parent will
  * deal wi=
th them=2E
  */
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests=
/unit_tests/openvpn/Makefile=2Eam
index 43a6743=2E=2E16d1613 100644
--- a/t=
ests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefi=
le=2Eam
@@ -407,6 +407,10 @@
 	$(top_srcdir)/src/openvpn/siphash_reference=
=2Ec \
 	$(top_srcdir)/src/openvpn/session_id=2Ec
 
+if !WIN32
+misc_testdr=
iver_SOURCES +=3D $(top_srcdir)/src/compat/compat-close-fds=2Ec
+endif
+
 p=
ush_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \
 	-I$(to=
p_srcdir)/src/compat \
 	-I$(top_srcdir)/tests/unit_tests/openvpn \
diff --=
git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/tes=
t_misc=2Ec
index aea40f0=2E=2Eee16682 100644
--- a/tests/unit_tests/openvpn=
/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -43,6 +43,14=
 @@
 #include "sid_hash=2Eh"
 #ifdef _WIN32
 #include "win32-util=2Eh"
+#el=
se
+#include "compat-close-fds=2Eh"
+
+#include <errno=2Eh>
+#include <fcnt=
l=2Eh>
+#include <sys/socket=2Eh>
+#include <sys/wait=2Eh>
+#include <unist=
d=2Eh>
 #endif
 #include "test_schedule=2Eh"
 
@@ -550,9 +558,154 @@
     g=
c_free(&gc);
 }
 
+#ifndef _WIN32
+static bool
+fd_is_closed(int fd)
+{
+  =
  errno =3D 0;
+    return fcntl(fd, F_GETFD) =3D=3D -1 && errno =3D=3D EBA=
DF;
+}
+
+static bool
+fd_is_open(int fd)
+{
+    return fcntl(fd, F_GETFD)=
 !=3D -1;
+}
+
+static int
+run_close_fds_case(int keep_target)
+{
+    int=
 control[2];
+    if (socketpair(AF_UNIX, SOCK_STREAM, 0, control) < 0)
+  =
  {
+        return EXIT_FAILURE;
+    }
+
+    const pid_t pid =3D fork();=

+    if (pid < 0)
+    {
+        close(control[0]);
+        close(contro=
l[1]);
+        return EXIT_FAILURE;
+    }
+
+    if (pid =3D=3D 0)
+    {=

+        close(control[0]);
+
+        int keep =3D control[1];
+        c=
onst long open_max =3D sysconf(_SC_OPEN_MAX);
+        if (open_max > 3 && =
keep_target >=3D open_max)
+        {
+            keep_target =3D (int)ope=
n_max - 1;
+        }
+        if (keep_target >=3D 3 && keep_target !=3D k=
eep)
+        {
+            if (dup2(keep, keep_target) < 0)
+            =
{
+                _exit(EXIT_FAILURE);
+            }
+            close(k=
eep);
+            keep =3D keep_target;
+        }
+
+        const int so=
urce =3D open("/dev/null", O_RDWR);
+        if (source < 0)
+        {
+  =
          _exit(EXIT_FAILURE);
+        }
+        for (int fd =3D STDIN_FI=
LENO; fd <=3D STDERR_FILENO; ++fd)
+        {
+            if (dup2(source,=
 fd) < 0)
+            {
+                _exit(EXIT_FAILURE);
+           =
 }
+        }
+        const int close_fd_1 =3D dup(source);
+        const=
 int close_fd_2 =3D dup(source);
+        if (close_fd_1 < 0 || close_fd_2 =
< 0)
+        {
+            _exit(EXIT_FAILURE);
+        }
+
+        con=
st int close_target =3D 101;
+        int close_fd_high =3D -1;
+        if=
 (open_max > close_target && keep !=3D close_target)
+        {
+          =
  close_fd_high =3D dup2(source, close_target);
+            if (close_fd_h=
igh < 0)
+            {
+                _exit(EXIT_FAILURE);
+            =
}
+        }
+        if (source > STDERR_FILENO && source !=3D keep)
+    =
    {
+            close(source);
+        }
+
+        close_fds_except(ke=
ep);
+
+        const char result =3D fd_is_open(STDIN_FILENO) && fd_is_ope=
n(STDOUT_FILENO)
+                                    && fd_is_open(STDERR_=
FILENO)
+                                    && fd_is_closed(close_fd_1)
+ =
                                   && fd_is_closed(close_fd_2)
+           =
                         && (close_fd_high < 0 || fd_is_closed(close_fd_hig=
h))
+                                ? '1'
+                               =
 : '0';
+        if (write(keep, &result, sizeof(result)) !=3D sizeof(resul=
t))
+        {
+            _exit(EXIT_FAILURE);
+        }
+        close(=
keep);
+        _exit(result =3D=3D '1' ? EXIT_SUCCESS : EXIT_FAILURE);
+  =
  }
+
+    close(control[1]);
+    char result =3D '0';
+    const ssize_t =
size =3D read(control[0], &result, sizeof(result));
+    close(control[0]);=

+
+    int status =3D 0;
+    if (waitpid(pid, &status, 0) !=3D pid)
+    =
{
+        return EXIT_FAILURE;
+    }
+
+    return size =3D=3D sizeof(res=
ult) && result =3D=3D '1' && WIFEXITED(status)
+                   && WEXIT=
STATUS(status) =3D=3D EXIT_SUCCESS
+               ? EXIT_SUCCESS
+        =
       : EXIT_FAILURE;
+}
+
+static void
+test_close_fds_default_keep(void =
**state)
+{
+    (void)state;
+    assert_int_equal(run_close_fds_case(-1),=
 EXIT_SUCCESS);
+}
+
+static void
+test_close_fds_keep_three(void **state)
=
+{
+    (void)state;
+    assert_int_equal(run_close_fds_case(3), EXIT_SUCC=
ESS);
+}
+
+static void
+test_close_fds_keep_middle(void **state)
+{
+    (=
void)state;
+    assert_int_equal(run_close_fds_case(150), EXIT_SUCCESS);
+=
}
+#endif /* !_WIN32 */
+
 const struct CMUnitTest misc_tests[] =3D {
 #ifd=
ef _WIN32
     cmocka_unit_test(test_win_path_in_dir),
+#else
+    cmocka_u=
nit_test(test_close_fds_default_keep),
+    cmocka_unit_test(test_close_fds=
_keep_three),
+    cmocka_unit_test(test_close_fds_keep_middle),
 #endif
  =
   cmocka_unit_test(test_compat_lzo_string),
     cmocka_unit_test(test_aut=
h_fail_temp_no_flags),

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1881?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Cha=
nge-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55
Gerrit-Change-Number: 188=
1
Gerrit-PatchSet: 6
Gerrit-Owner: srkyn <david@srkyn=2Ecom>
Gerrit-Reviewe=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan C=
ojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: Frank Lichtenheld <frank@lichten=
held=2Ecom>
Gerrit-CC: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: op=
envpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: srk=
yn <david@srkyn=2Ecom>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mail=
box=2Eorg>
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=2Ede>

--f+DaYTJ7rSI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Gert Doering, R=C4=83zvan Cojocaru, srkyn=2E </p>
<p>=
srkyn <strong>uploaded patch set #6</strong> to this change=2E</p><p><a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Re=
view+2 by R=C4=83zvan Cojocaru</p><p>The change is no longer submittable: C=
ode-Review and checks~ChecksSubmitRule are unsatisfied now=2E</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">compat: close all unrelated fds in forked helpers<br><br>The forked aut=
h-pam, down-root, and port-share helpers only closed<br>descriptor numbers =
3 through 100=2E Descriptors above that range could<br>remain open in long-=
lived helper processes, including helpers that<br>intentionally retain priv=
ilege=2E<br><br>Add a shared compatibility helper that uses close_range() w=
hen available<br>and falls back to the process descriptor limit=2E Preserve=
 the helper<br>command socket and add coverage for both low and high preser=
ved<br>descriptors=2E<br><br>Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa2=
89dc55<br>Signed-off-by: David Sarkisyan &lt;david@srkyn=2Ecom&gt;<br>---<b=
r>M CMakeLists=2Etxt<br>M config=2Eh=2Ecmake=2Ein<br>M configure=2Eac<br>M =
src/compat/Makefile=2Eam<br>A src/compat/compat-close-fds=2Ec<br>A src/comp=
at/compat-close-fds=2Eh<br>M src/openvpn/ps=2Ec<br>M src/plugins/auth-pam/M=
akefile=2Eam<br>M src/plugins/auth-pam/auth-pam=2Ec<br>M src/plugins/down-r=
oot/Makefile=2Eam<br>M src/plugins/down-root/down-root=2Ec<br>M tests/unit_=
tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/test_misc=2Ec<br>=
13 files changed, 296 insertions(+), 73 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/81/18=
81/6</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><sp=
an>index 184a95a=2E=2Ee842317 100644</span><br><span>--- a/CMakeLists=2Etxt=
</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -19,6 +19,7 @@</=
span><br><span> include(CheckLinkerFlag OPTIONAL)</span><br><span> include(=
CheckTypeSize)</span><br><span> include(CheckStructHasMember)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+include(CMakePushCheckState)</spa=
n><br><span> include(CTest)</span><br><span> </span><br><span> option(UNSUP=
PORTED_BUILDS &quot;Allow unsupported builds&quot; OFF)</span><br><span>@@ =
-197,6 +198,10 @@</span><br><span>     check_symbol_exists(fork unistd=2Eh =
HAVE_FORK)</span><br><span>     check_symbol_exists(execve unistd=2Eh HAVE_=
EXECVE)</span><br><span>     check_symbol_exists(ftruncate unistd=2Eh HAVE_=
FTRUNCATE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmake=
_push_check_state()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    list(APPEND CMAKE_REQUIRED_DEFINITIONS -D_GNU_SOURCE)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    check_symbol_exists(close_range u=
nistd=2Eh HAVE_CLOSE_RANGE)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    cmake_pop_check_state()</span><br><span>     check_symbol_exist=
s(nice unistd=2Eh HAVE_NICE)</span><br><span>     check_symbol_exists(setgi=
d unistd=2Eh HAVE_SETGID)</span><br><span>     check_symbol_exists(setuid u=
nistd=2Eh HAVE_SETUID)</span><br><span>@@ -435,6 +440,8 @@</span><br><span>=
     src/compat/compat-strlcpy=2Ec</span><br><span>     src/compat/compat-s=
trsep=2Ec</span><br><span>     src/compat/compat-strtok_r=2Ec</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    src/compat/compat-close-fds=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/compat/=
compat-close-fds=2Eh</span><br><span>     src/openvpn/argv=2Ec</span><br><s=
pan>     src/openvpn/argv=2Eh</span><br><span>     src/openvpn/base64=2Ec</=
span><br><span>@@ -869,6 +876,11 @@</span><br><span>         src/openvpn/si=
phash_reference=2Ec</span><br><span>         src/openvpn/session_id=2Ec</sp=
an><br><span>     )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (NOT WIN32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       target_sources(test_misc PRIVATE</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            src/compat/compat-close-fds=2Ec</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        )</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    endif ()</span><br><span> </span><br>=
<span>     target_sources(test_ncp PRIVATE</span><br><span>         src/ope=
nvpn/crypto_epoch=2Ec</span><br><span>diff --git a/config=2Eh=2Ecmake=2Ein =
b/config=2Eh=2Ecmake=2Ein</span><br><span>index 483de45=2E=2Ed87d298 100644=
</span><br><span>--- a/config=2Eh=2Ecmake=2Ein</span><br><span>+++ b/config=
=2Eh=2Ecmake=2Ein</span><br><span>@@ -75,6 +75,9 @@</span><br><span> /* Def=
ine to 1 if you have the `chsize&#39; function=2E */</span><br><span> #cmak=
edefine HAVE_CHSIZE</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* Define to 1 if you have the `close_range&#39; function=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine =
HAVE_CLOSE_RANGE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> /* struct cmsghdr needed for extended socket error support *=
/</span><br><span> #cmakedefine HAVE_CMSGHDR</span><br><span> </span><br><s=
pan>diff --git a/configure=2Eac b/configure=2Eac</span><br><span>index 0ac6=
1b4=2E=2Eda5ffb6 100644</span><br><span>--- a/configure=2Eac</span><br><spa=
n>+++ b/configure=2Eac</span><br><span>@@ -563,7 +563,7 @@</span><br><span>=
 	syslog openlog mlockall getrlimit getgrnam setgid \</span><br><span> 	set=
groups flock gettimeofday \</span><br><span> 	setsid chdir \</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	chsize ftruncate execve getpeereid =
basename dirname \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	=
chsize ftruncate execve getpeereid basename dirname close_range \</span><br=
><span> 	epoll_create strlcpy strsep strtok_r \</span><br><span> ])</span><=
br><span> </span><br><span>diff --git a/src/compat/Makefile=2Eam b/src/comp=
at/Makefile=2Eam</span><br><span>index 8b1d44a=2E=2Edb65edd 100644</span><b=
r><span>--- a/src/compat/Makefile=2Eam</span><br><span>+++ b/src/compat/Mak=
efile=2Eam</span><br><span>@@ -16,6 +16,7 @@</span><br><span> </span><br><s=
pan> libcompat_la_SOURCES =3D \</span><br><span> 	compat=2Eh \</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+	compat-close-fds=2Ec compat-clo=
se-fds=2Eh \</span><br><span> 	compat-dirname=2Ec \</span><br><span> 	compa=
t-basename=2Ec \</span><br><span> 	compat-gettimeofday=2Ec \</span><br><spa=
n>diff --git a/src/compat/compat-close-fds=2Ec b/src/compat/compat-close-fd=
s=2Ec</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=
=2Ef3a266c</span><br><span>--- /dev/null</span><br><span>+++ b/src/compat/c=
ompat-close-fds=2Ec</span><br><span>@@ -0,0 +1,74 @@</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networ=
ks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             ov=
er a single UDP port, with support for SSL/TLS-based</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             session authentication and=
 key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          packet encryption, packet authentication, and</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2026 David Sarkisyan<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; yo=
u can redistribute it and/or modify</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  it under the terms of the GNU General Public License ve=
rsion 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publi=
shed by the Free Software Foundation=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  This program is distributed in the hope that it will be useful,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARR=
ANTY; without even the implied warranty of</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURP=
OSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
GNU General Public License for more details=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  You should have received a copy of the GNU General Public Lic=
ense along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with =
this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
ndef _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;compat-close=
-fds=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;limits=2Eh&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;std=
bool=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &lt;unistd=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &lt;syslog=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+close_fds_except(int keep=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    closelog();</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#ifdef HAVE_CLOSE_RANGE</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    bool closed =3D true;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    unsigned int first =3D 3;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (keep &gt;=3D 3)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (keep &gt; 3)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            closed =3D close_range(3, (unsigned int)ke=
ep - 1, 0) =3D=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        f=
irst =3D (unsigned int)keep + 1;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   closed =3D close_range(first, ~0U, 0) =3D=3D 0 &amp;&amp; closed;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (closed)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const long open=
_max =3D sysconf(_SC_OPEN_MAX);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    int max_fd =3D 1024;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (open_max &gt; 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        max_fd =3D open_max &gt; INT_MAX ? INT_MAX : (int)open_max;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    for (int fd =3D 3; fd &lt; ma=
x_fd; ++fd)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (fd !=3D ke=
ep)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            close(fd);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /*=
 !_WIN32 */</span><br><span>diff --git a/src/compat/compat-close-fds=2Eh b/=
src/compat/compat-close-fds=2Eh</span><br><span>new file mode 100644</span>=
<br><span>index 0000000=2E=2E8480941</span><br><span>--- /dev/null</span><b=
r><span>+++ b/src/compat/compat-close-fds=2Eh</span><br><span>@@ -0,0 +1,38=
 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to =
securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *             over a single UDP port, with support for SSL/TLS-bas=
ed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             se=
ssion authentication and key exchange,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *             packet encryption, packet authentication,=
 and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =
packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (=
C) 2026 David Sarkisyan</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This prog=
ram is free software; you can redistribute it and/or modify</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU G=
eneral Public License version 2</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  as published by the Free Software Foundation=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  This program is distributed in the hope that=
 it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNE=
SS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  GNU General Public License for more details=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a copy of th=
e GNU General Public License along</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eo=
rg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#ifndef COMPAT_CLOSE_FDS_H</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define COMPAT_CLOSE_FDS_H</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#ifndef _WIN32</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Close descriptors inherited across fork that are unrelated=
 to a helper=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Standard input, st=
andard output, standard error, and @p keep remain open=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * All other file descriptors startin=
g at 3 are closed=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param keep f=
ile descriptor used for communication with the parent process</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void close_fds_except(int keep);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif /* COMPAT_CLOSE_FDS_H */</span><br><span>diff --git a/src/ope=
nvpn/ps=2Ec b/src/openvpn/ps=2Ec</span><br><span>index 03c6f48=2E=2E986f0d2=
 100644</span><br><span>--- a/src/openvpn/ps=2Ec</span><br><span>+++ b/src/=
openvpn/ps=2Ec</span><br><span>@@ -34,6 +34,7 @@</span><br><span> #include =
&quot;crypto=2Eh&quot;</span><br><span> #include &quot;resolve=2Eh&quot;</s=
pan><br><span> #include &quot;ps=2Eh&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;compat-close-fds=2Eh&quot;</span><br>=
<span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> <=
/span><br><span>@@ -86,30 +87,6 @@</span><br><span> }</span><br><span> </sp=
an><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Cl=
ose most of parent&#39;s fds=2E</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * Keep stdin/stdout/stderr, plus one</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * other fd which is presumed to be</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * our pipe back to parent=2E</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * Admittedly, a bit of a k=
ludge,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * but posix do=
esn&#39;t give us a kind</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * of FD_CLOEXEC which will stop</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * fds from crossing a fork()=2E</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-clo=
se_fds_except(int keep)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    socket_descrip=
tor_t i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    closelog(=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 3; i=
 &lt;=3D 100; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (i !=3D =
keep)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            openvpn_close_so=
cket(i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</spa=
n><br><span>  * Usually we ignore signals, because our parent will</span><b=
r><span>  * deal with them=2E</span><br><span>  */</span><br><span>diff --g=
it a/src/plugins/auth-pam/Makefile=2Eam b/src/plugins/auth-pam/Makefile=2Ea=
m</span><br><span>index e6dc27e=2E=2Efb7fd30 100644</span><br><span>--- a/s=
rc/plugins/auth-pam/Makefile=2Eam</span><br><span>+++ b/src/plugins/auth-pa=
m/Makefile=2Eam</span><br><span>@@ -9,6 +9,7 @@</span><br><span> </span><br=
><span> AM_CFLAGS =3D \</span><br><span> 	-I$(top_srcdir)/include \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+	-I$(top_srcdir)/src/compat=
 \</span><br><span> 	$(PLUGIN_AUTH_PAM_CFLAGS) \</span><br><span> 	$(OPTION=
AL_CRYPTO_CFLAGS)</span><br><span> </span><br><span>@@ -23,6 +24,7 @@</span=
><br><span> 	pamdl=2Ec  pamdl=2Eh \</span><br><span> 	auth-pam=2Eexports</s=
pan><br><span> openvpn_plugin_auth_pam_la_LIBADD =3D \</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+	$(top_builddir)/src/compat/libcompat=2E=
la \</span><br><span> 	$(PLUGIN_AUTH_PAM_LIBS)</span><br><span> openvpn_plu=
gin_auth_pam_la_LDFLAGS =3D $(AM_LDFLAGS) \</span><br><span> 	-export-symbo=
ls &quot;$(srcdir)/auth-pam=2Eexports&quot; \</span><br><span>diff --git a/=
src/plugins/auth-pam/auth-pam=2Ec b/src/plugins/auth-pam/auth-pam=2Ec</span=
><br><span>index 948b6af=2E=2Ea3fd3aa 100644</span><br><span>--- a/src/plug=
ins/auth-pam/auth-pam=2Ec</span><br><span>+++ b/src/plugins/auth-pam/auth-p=
am=2Ec</span><br><span>@@ -51,6 +51,8 @@</span><br><span> #include &lt;arpa=
/inet=2Eh&gt;</span><br><span> #include &lt;openvpn-plugin=2Eh&gt;</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
quot;compat-close-fds=2Eh&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> #define DEBUG(verb) ((verb) &gt;=3D 4)</span>=
<br><span> </span><br><span> /* Command codes for foreground -&gt; backgrou=
nd communication */</span><br><span>@@ -240,30 +242,6 @@</span><br><span> #=
endif /* ifdef DO_DAEMONIZE */</span><br><span> </span><br><span> /*</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * Close most of parent&#39;=
s fds=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Keep stdin=
/stdout/stderr, plus one</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * other fd which is presumed to be</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * our pipe back to parent=2E</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * Admittedly, a bit of a kludge,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * but posix doesn&#39;t give us a kin=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * of FD_CLOEXEC whi=
ch will stop</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * fds fr=
om crossing a fork()=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-close_fds_except(int keep)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    closelog();</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    for (i =3D 3; i &lt;=3D 100; ++i)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (i !=3D keep)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            close(i);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-/*</span><br><span>  * Usually we ignore signals, because our=
 parent will</span><br><span>  * deal with them=2E</span><br><span>  */</sp=
an><br><span>diff --git a/src/plugins/down-root/Makefile=2Eam b/src/plugins=
/down-root/Makefile=2Eam</span><br><span>index 7ca5a4e=2E=2E83bc04f 100644<=
/span><br><span>--- a/src/plugins/down-root/Makefile=2Eam</span><br><span>+=
++ b/src/plugins/down-root/Makefile=2Eam</span><br><span>@@ -9,6 +9,7 @@</s=
pan><br><span> </span><br><span> AM_CFLAGS =3D \</span><br><span> 	-I$(top_=
srcdir)/include \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-=
I$(top_srcdir)/src/compat \</span><br><span> 	$(OPTIONAL_CRYPTO_CFLAGS)</sp=
an><br><span> </span><br><span> if ENABLE_PLUGIN_DOWN_ROOT</span><br><span>=
@@ -19,6 +20,8 @@</span><br><span> openvpn_plugin_down_root_la_SOURCES =3D =
\</span><br><span> 	down-root=2Ec \</span><br><span> 	down-root=2Eexports</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn_plugin_down_r=
oot_la_LIBADD =3D \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
	$(top_builddir)/src/compat/libcompat=2Ela</span><br><span> openvpn_plugin_=
down_root_la_LDFLAGS =3D $(AM_LDFLAGS) \</span><br><span> 	-export-symbols =
&quot;$(srcdir)/down-root=2Eexports&quot; \</span><br><span> 	-module -shar=
ed -avoid-version -no-undefined</span><br><span>diff --git a/src/plugins/do=
wn-root/down-root=2Ec b/src/plugins/down-root/down-root=2Ec</span><br><span=
>index cd57189=2E=2E3f71cdd 100644</span><br><span>--- a/src/plugins/down-r=
oot/down-root=2Ec</span><br><span>+++ b/src/plugins/down-root/down-root=2Ec=
</span><br><span>@@ -44,6 +44,8 @@</span><br><span> </span><br><span> #incl=
ude &lt;openvpn-plugin=2Eh&gt;</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &quot;compat-close-fds=2Eh&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #defin=
e DEBUG(verb) ((verb) &gt;=3D 7)</span><br><span> </span><br><span> /* Comm=
and codes for foreground -&gt; background communication */</span><br><span>=
@@ -191,30 +193,6 @@</span><br><span> }</span><br><span> </span><br><span> =
/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Close most of pa=
rent&#39;s fds=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * K=
eep stdin/stdout/stderr, plus one</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * other fd which is presumed to be</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * our pipe back to parent=2E</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * Admittedly, a bit of a kludge,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * but posix doesn&#39;t give=
 us a kind</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * of FD_CL=
OEXEC which will stop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * fds from crossing a fork()=2E</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-close_fds_except(=
int keep)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    closelog();</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    for (i =3D 3; i &lt;=3D 100; ++i)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        if (i !=3D keep)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            close(i);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-/*</span><br><span>  * Usually we ignore signals, be=
cause our parent will</span><br><span>  * deal with them=2E</span><br><span=
>  */</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b=
/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index 43a6743=2E=2E=
16d1613 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam=
</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><sp=
an>@@ -407,6 +407,10 @@</span><br><span> 	$(top_srcdir)/src/openvpn/siphash=
_reference=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/session_id=2Ec=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=
f !WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+misc_testdr=
iver_SOURCES +=3D $(top_srcdir)/src/compat/compat-close-fds=2Ec</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> push_update_msg_testdriver_=
CFLAGS =3D -I$(top_srcdir)/src/openvpn \</span><br><span> 	-I$(top_srcdir)/=
src/compat \</span><br><span> 	-I$(top_srcdir)/tests/unit_tests/openvpn \</=
span><br><span>diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/=
unit_tests/openvpn/test_misc=2Ec</span><br><span>index aea40f0=2E=2Eee16682=
 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span>=
<br><span>+++ b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>@@ -=
43,6 +43,14 @@</span><br><span> #include &quot;sid_hash=2Eh&quot;</span><br=
><span> #ifdef _WIN32</span><br><span> #include &quot;win32-util=2Eh&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;compat-close-fds=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;errno=2Eh&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;fcntl=2Eh&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;sys/=
socket=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &lt;sys/wait=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &lt;unistd=2Eh&gt;</span><br><span> #endif</span><br><span> #=
include &quot;test_schedule=2Eh&quot;</span><br><span> </span><br><span>@@ =
-550,9 +558,154 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#ifndef _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fd_is_closed(=
int fd)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    errno =3D 0;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return fcntl(fd, F_GETFD) =3D=
=3D -1 &amp;&amp; errno =3D=3D EBADF;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+fd_is_open(int fd)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return fcntl(fd, F_GETFD) !=3D -1;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+run_close_fds_case(int keep_target)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    int control[2];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (socketpair(AF_UNIX, SOCK_STREAM, 0, control) &lt; 0)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return EXIT_FAILURE;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const pid_t pid =3D fork();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (pid &lt; 0)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        close(control[0]);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        close(control[1]);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return EXIT_FAILURE;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (p=
id =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        close(control=
[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        int keep =3D control[1];<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const long o=
pen_max =3D sysconf(_SC_OPEN_MAX);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (open_max &gt; 3 &amp;&amp; keep_target &gt;=3D o=
pen_max)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            keep_targ=
et =3D (int)open_max - 1;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (keep_target &gt;=3D 3 &amp;&amp; keep_target !=3D keep)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (dup2(keep, keep_target) &=
lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                _ex=
it(EXIT_FAILURE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    close(keep);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         keep =3D keep_target;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const int =
source =3D open(&quot;/dev/null&quot;, O_RDWR);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (source &lt; 0)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            _exit(EXIT_FAILURE);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        for (int fd =3D STDIN_FILENO; fd &lt;=
=3D STDERR_FILENO; ++fd)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       if (dup2(source, fd) &lt; 0)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                _exit(EXIT_FAILURE);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        const int close_fd_1 =3D dup(source);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        const int close_fd_2 =3D dup(s=
ource);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
close_fd_1 &lt; 0 || close_fd_2 &lt; 0)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            _exit(EXIT_FAILURE);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  const int close_target =3D 101;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        int close_fd_high =3D -1;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (open_max &gt; close_target &amp;&am=
p; keep !=3D close_target)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         close_fd_high =3D dup2(source, close_target);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            if (close_fd_high &lt; 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                _exit(EXIT_F=
AILURE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (source &gt; STD=
ERR_FILENO &amp;&amp; source !=3D keep)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            close(source);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        clos=
e_fds_except(keep);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const char =
result =3D fd_is_open(STDIN_FILENO) &amp;&amp; fd_is_open(STDOUT_FILENO)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
              &amp;&amp; fd_is_open(STDERR_FILENO)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                    &amp;&am=
p; fd_is_closed(close_fd_1)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                                    &amp;&amp; fd_is_closed(close_f=
d_2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                     &amp;&amp; (close_fd_high &lt; 0 || fd_is_closed(close=
_fd_high))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                       ? &#39;1&#39;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                : &#39;0&#39;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (write(keep, &amp;re=
sult, sizeof(result)) !=3D sizeof(result))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            _exit(EXIT_FAILURE);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        close(keep);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        _exit(result =3D=3D &#39;1&#39; ? EXIT_SUCCESS : E=
XIT_FAILURE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    close(control[1]);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    char result =3D &#39;0&#39;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const ssize_t size =
=3D read(control[0], &amp;result, sizeof(result));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    close(control[0]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int status =3D 0;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (waitpid(pid, &amp;status, 0) !=3D pid)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return EXIT_FAILURE;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return size =3D=3D sizeof(result) &amp;&amp; result =3D=3D &#39;1=
&#39; &amp;&amp; WIFEXITED(status)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                   &amp;&amp; WEXITSTATUS(status) =3D=3D EXI=
T_SUCCESS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
     ? EXIT_SUCCESS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
               : EXIT_FAILURE;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+test_close_fds_default_keep(void *=
*state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    (void)state;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(run_close_fd=
s_case(-1), EXIT_SUCCESS);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+test_close_fds_keep_three(void **state=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    (void)state;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(run_close_fds_case=
(3), EXIT_SUCCESS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+test_close_fds_keep_middle(void **state)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    (void)state;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_int_equal(run_close_fds_case(150)=
, EXIT_SUCCESS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* !_WIN32 */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> co=
nst struct CMUnitTest misc_tests[] =3D {</span><br><span> #ifdef _WIN32</sp=
an><br><span>     cmocka_unit_test(test_win_path_in_dir),</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    cmocka_unit_test(test_close_fds_default_keep),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test=
(test_close_fds_keep_three),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    cmocka_unit_test(test_close_fds_keep_middle),</span><br><span>=
 #endif</span><br><span>     cmocka_unit_test(test_compat_lzo_string),</spa=
n><br><span>     cmocka_unit_test(test_auth_fail_temp_no_flags),</span><br>=
</pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1881?usp=3Demail">change 1881</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1881?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1881 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: srkyn &lt;david@srkyn=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: srkyn &lt;david@srkyn=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: Gert Doering &lt;gert@gree=
nie=2Emuc=2Ede&gt; </div>

</body></html>
--f+DaYTJ7rSI=--


--===============4075909738635164775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4075909738635164775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4075909738635164775==--

