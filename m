Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0C9C98318
	for <openvpn-devel@archiver.kernel.org>; Sat, 26 Sep 2026 08:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/XIBbQogzuszqP/vuM+V37JAFjKC4p3IMkNQiNmj+QM=; b=KexexjTbh2RomueuVaScAGxgOs
	MypfyJPfYFrOL7T0uOOSZUQrs0sqKPCveSijQsG5Lv40zekwCp2Le0vz5EJfBvm0II68+QMjK1p5c
	QqFnDeGgtTBRimKHJbjMu1Q05enCDwD8Qi2S+m2vZNA6QCtgKembm3yIYP5BHWNxci6Q=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xANcs-0002mi-Sv;
	Sat, 26 Sep 2026 08:19:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xANcd-0002iV-4M
 for openvpn-devel@lists.sourceforge.net;
 Sat, 26 Sep 2026 08:19:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=aWm+7PhEpauScmXKarjoLRnAuh0rnytXo1Grxs/16V0=; b=X1nWs9+kzHSHmFn/RcH3Mhe7pR
 q3ybh5TXfgZ4kSF3/ZRx7RWabwijZRJgkRbaCyhwoDnYjSN+ydYZmIlNrbuc62AGLRsoZf4jBP/yY
 C5xn7MUimT0AShB/bGBLvOOVik74mmQjrnG3IIfisg75pe0T+dWK6hTC4Vx9EumbTAgo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=aWm+7PhEpauScmXKarjoLRnAuh0rnytXo1Grxs/16V0=; b=h
 zOxRzZLD4sVe7bTHvrxeTKHQ1WbXHnqUVqfLrLUWdXllWI2XN7/eaHc+LQ8AxQntXHYLLJpdm6n7s
 fxgmJNeW9W6mKvphYP08ecJsv55l4aN9hGbHXQBUC4B0w+EZsT4IARcCEqKbljtzPb65TytGhO3eb
 PpMp6/ZvCIvoLtnM=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xANcX-0005Fj-ID for openvpn-devel@lists.sourceforge.net;
 Sat, 26 Sep 2026 08:19:00 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d8239so11993875e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 26 Sep 2026 01:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790410731; x=1791015531; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aWm+7PhEpauScmXKarjoLRnAuh0rnytXo1Grxs/16V0=;
 b=AlJw+slME5TdjhT80AYwrVqdwiF8bq0dJIGUkALNDAZMfj1dH3Y2hYJ4InPiLoBoSy
 PmipTvBjlQjuzxy+qSmkidswsdBkoB/gLLo7JYqzukuYwHKHwi3iUB4ZLb0Inm3zaD/d
 DART89uHbK55q1zwEOaypBGr21Nbaf/yr6rEyAtcTA3gDA3Z3YC/2mWkTp2m/AeL+HFv
 CBjMMySyOoJ9ofGanFtWhjMlkDJO3VXqgVbH5pg998TB5uqYrt+6m3oBetYqss+EUXrY
 fh6c4O5YuiPlpkDrmrCG50CJXrbj+8YmpDGlVpnR4K0PCURjJQVdEv5ZNNMZGoPSrQQm
 tKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790410731; x=1791015531;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aWm+7PhEpauScmXKarjoLRnAuh0rnytXo1Grxs/16V0=;
 b=Q+rfbgAoOhDa/nAinaMBaaliiEjOwI9Wow6tLBrgaVd57/219Z8ZvVxNeGZ0vj+SLD
 PlPhBFxZHS+ofZszYE2T+iyjWwau0kRYeLCtnEEnGvEMd4Q5OXItuduvi2tQxkFtDcoh
 NYtVZo0ssU0MtaogQRDOsjUmmb69y9COWVnLfOnkz8hc0XWYmZfw+xUQf9Y/J7cvXBnX
 AF7CjOdk2Upk2FhDTRYriZekNu++ez6Dn/rPBri9mSYn5vqFR/YvvWSaopVXVWwlresR
 9h3P47OFf9c6s61dvmPCjYlrfM/I65wUVrEqgogxNPwuViZHWOevd2kmqYRfnh2vGSnv
 2hbg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy+sCkkxTTNuKlbuPmUdZiCFX5JPuuI69TXG6abPrbxk5cxuEk1B972jKsLTJO76cBgYn8QCUNvhkVM5cm+@lists.sourceforge.net
X-Gm-Message-State: AFuF++mxxaAa9dhtVAUKrLqUQg78KqBl+Z0FTJdcaPK80aXKgwQCo1pQ
 PYW3hWU9fxd+5PbdTBv0/P5lWMyYWFblrJRMCcSO4KIYfwqTG7B0BJ0tKleIMcqNlb296HDuG3g
 g4x/9NVDqCAt05U8hnAQSgcxjFVpLLrQ82q75hZmNmsJbnOyBz+iOyZrMJvNnabzB8XM9
X-Gm-Gg: AYBFou2uNto8bE9Tlp1rrylNT8TJGEypxOLYE9wJ0laIpPPxr+B5bqCEM0vZeIAbNgG
 J0XVC4/cCdIylySp06J+gw5tk6JNVJEMewFQbrTRh6KRtkTs7R9Lv06WBS4FR18FfKkoOkwA4d8
 Gj2mdisTlDfyRlwcsp+kIO0HGud1Pznl8liRDgwaTc952k0I71F3mtxKQ15rBnZUwAzvEVtjm9C
 CJXkRh3Sr2bF5ppakxx7pztAGHGG9Jgl+FKuKBsj1skpg2WSg675SAj5ULid+Aml0ovReW1xHEE
 1XtqLBhVNZLcciQBPZB3CaJkoSc3y2qyuudngPr5fRx1psqvWq4JzXafrPpFXxY0eHHtJEPrIDC
 alnJX/4B8tt5gYQgN/1R7bKXxvaGtOhjhUa4xLb3RdJ+oImjXTZGF4jvW55wbWhp67/+bOnT5jQ
 H8bkYpbNsJPPrPhCibNrkQCU1xeW7PvA1J8VWKxymhxuXYTex8iTEDb6nJDNmTHC9xS4EusO99j
 27bTamyHIrosLQrg3qlNpbA6PP3DBBB5RmoD+Ng113KUHQXm7hmxQOgMAVdU7XD6lM0I+/uFviK
 ms7KuUp/9q9D4auYcWvDzIsKe476dGNg5FU+tG+Y2Cg+dLXMmM55eH5BYarX
X-Received: by 2002:a05:600c:4e4c:b0:49c:edfa:15a with SMTP id
 5b1f17b1804b1-49fe7b6f02bmr146880305e9.13.1790410730383; 
 Sat, 26 Sep 2026 01:18:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5de4de4sm214252095e9.8.2026.09.26.01.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 01:18:49 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 26 Sep 2026 08:18:49 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ie06d3543d0a5d4ca3d3fd6f41498e6917ab4c8a9
X-Gerrit-Change-Number: 1953
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1953?usp=email>
X-Gerrit-Commit: 060b9ebd1460600803d49abed990ab5f71b72395
In-Reply-To: <gerrit.1790352577000.Ie06d3543d0a5d4ca3d3fd6f41498e6917ab4c8a9@gerrit.openvpn.net>
References: <gerrit.1790352577000.Ie06d3543d0a5d4ca3d3fd6f41498e6917ab4c8a9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzUyNTc3MDAwLkllMDZkMzU0M2QwYTVkNGNhM2QzZmQ2ZjQxNDk4ZTY5MTdhYjRjOGE5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9362d913241197257432d62f102ff994c61c40b7-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xANcX-0005Fj-ID
Subject: [Openvpn-devel] [L] Change in openvpn[master]: cppcheck: Clean up
 suppressions to not annoy developers
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0881878027029883908=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0881878027029883908==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ahmG++pT6iw="; charset=UTF-8

--ahmG++pT6iw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1953?usp=3Demail )

Change subject: cppcheck: Clean up suppressions to =
not annoy developers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

cppcheck: Clean up suppressions to not annoy developers

Actually u=
sing it in CI has shown that the line number
based suppression is just too =
annoying=2E Therefor:

- Switch to XML based suppressions that allow us to
=
  use symbolName in addition to lineNumber to limit the
  suppression=2E
- =
Suppress knownConditionTrueFalse always=2E There are just
  too many instan=
ces due to how our code is structured=2E
- Also remove some unused suppress=
ions=2E
- Replace some suppressions with code fixes=2E These are
  generall=
y speaking false positives but the code fix
  is less ugly than the suppres=
sion=2E
- Work around one issue with using PRIx64 macro in a
  pre-prepared=
 format string by adding a definition in
  our library definition=2E
- All =
suppressions that remain that were still lineNumber
  based (due to the che=
ck not reporting a symbol), move
  to inline suppressions=2E Inline suppres=
sions are somewhat
  ugly, but these are very few and I see no better
  alt=
ernative=2E Maybe we can get rid of some of them by
  reporting issues to c=
ppcheck=2E (Or, in some cases, by
  improving our code)=2E

While here, mak=
e sure that we always run the Windows scan
as well, so developers get compl=
ete feedback on first push=2E

Change-Id: Ie06d3543d0a5d4ca3d3fd6f41498e691=
7ab4c8a9
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-b=
y: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1953
Message-Id: <20260925213118=2E29507-1-gert@gree=
nie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg39523=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
---
D dev-tools/cppcheck-suppression
A dev-tools/cppcheck-s=
uppressions=2Exml
M dev-tools/openvpn-cppcheck-library=2Ecfg
M dev-tools/ru=
n-cppcheck=2Esh
M src/openvpn/crypto=2Ec
M src/openvpn/multi=2Ec
M src/open=
vpn/multi_io=2Ec
M src/openvpn/ssl_verify=2Ec
M src/openvpnserv/common=2Ec
=
M src/openvpnserv/interactive=2Ec
M tests/unit_tests/openvpn/test_tls_crypt=
=2Ec
11 files changed, 226 insertions(+), 124 deletions(-)




diff --git a=
/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression
deleted fi=
le mode 100644
index 27c9d30=2E=2E0000000
--- a/dev-tools/cppcheck-suppress=
ion
+++ /dev/null
@@ -1,119 +0,0 @@
-# We start with --enable=3Dall, but th=
en suppress some issues that have too many
-# occurences right now=2E They =
still should be fixed at some point
-constParameter
-constParameterCallback=

-constParameterPointer
-invalidPrintfArgType_sint
-invalidPrintfArgType_ui=
nt
-unusedFunction
-usleepCalled
-variableScope
-# We have a lot of library=
 includes, not all of them are really required,
-# so ignore them
-missingI=
ncludeSystem
-# cppcheck doesn't understand about check_malloc_return, so t=
hese are
-# usually misleading
-nullPointerOutOfMemory
-nullPointerArithmet=
icOutOfMemory
-# These are specific false-positives (FP) or ignored (IGN) i=
ssues
-# We might want to move some of them to inline-suppression to avoid
=
-# the static line-numbers
-# IGN: posix=2Ecfg: We are not threadsafe
-getg=
rnamCalled
-getpwnamCalled
-getservbynameCalled
-localtimeCalled
-# FP: pos=
ix=2Ecfg claims suseconds_t is unsigned for some reason
-unsignedLessThanZe=
ro:src/openvpn/otime=2Eh:148
-# IGN: multi code does weird things with poin=
ters to local variables=2E=2E=2E
-autoVariables:src/openvpn/multi=2Ec:4242
=
-autoVariables:src/openvpn/multi_io=2Ec:324
-# IGN: the code header =3D 0 |=
 (OPCODE << P_OPCODE_SHIFT) is used intentionally
-badBitmaskCheck:src/open=
vpn/mudp=2Ec
-badBitmaskCheck:tests/unit_tests/openvpn/test_pkt=2Ec
-# IGN:=
 Windows specific (unsigned long =3D=3D unsigned int)
-compareValueOutOfTyp=
eRangeError:src/openvpn/ssl_verify=2Ec:928
-# FP: cppcheck seems to have wr=
ong signature of DeviceIoControl()
-constVariablePointer:src/openvpn/dco_wi=
n=2Ec
-# IGN: test_networking code would break with iproute2 but that is pr=
evented
-ctunullpointer:src/openvpn/networking_iproute2=2Ec
-# IGN: event c=
ode uses a pointer to store integers
-intToPointerCast:src/openvpn/forward=
=2Ec
-intToPointerCast:src/openvpn/multi_io=2Ec
-intToPointerCast:src/openv=
pn/ps=2Ec
-# FP: constant but differs between platforms
-knownConditionTrue=
False:src/openvpn/error=2Eh:382
-knownConditionTrueFalse:src/openvpn/fdmisc=
=2Ec:80
-knownConditionTrueFalse:src/openvpn/lladdr=2Ec:64
-knownConditionT=
rueFalse:src/openvpn/platform=2Ec
-# FP: code needs to accomodate many diff=
erent defines
-knownConditionTrueFalse:src/openvpn/event=2Ec:1139
-knownCon=
ditionTrueFalse:src/openvpn/event=2Ec:1148
-# FP: dco_win support has "fals=
e" stubs
-knownConditionTrueFalse:src/openvpn/forward=2Ec
-knownConditionTr=
ueFalse:src/openvpn/init=2Ec
-knownConditionTrueFalse:src/openvpn/multi_io=
=2Ec:197
-# FP: cppcheck thinks that some functions always return true, but=
 they don't
-knownConditionTrueFalse:src/openvpn/misc=2Ec:97
-knownConditio=
nTrueFalse:src/openvpn/sig=2Eh:116
-# FP: cert_uri_supported is a wrapper a=
round defines, so it's
-# always constant but differs depending on OpenSSL =
version
-knownConditionTrueFalse:src/openvpn/ssl_openssl=2Ec:1260
-# FP: cp=
pcheck doesn't understand that the function changes szErrMessage
-knownCond=
itionTrueFalse:src/tapctl/main=2Ec:704
-knownConditionTrueFalse:src/openvpn=
msica/dllmain=2Ec:164
-# FP: cppcheck seems to be confused since we cast th=
e pointer to integer
-memleak:src/plugins/down-root/down-root=2Ec:337
-# IG=
N: we just abort instead
-memleakOnRealloc:src/openvpn/dco_freebsd=2Ec:845
=
-# FP: eventmsg=2Eh is not built on Unix
-missingInclude:src/openvpnserv/co=
mmon=2Ec:25
-# IGN: strlen(NULL) is not nice code, but seems to work
-nullP=
ointerRedundantCheck:src/openvpn/init=2Ec:301
-# FP: cppcheck doesn't under=
stand ZeroMemory
-redundantAssignment:src/openvpnserv/interactive=2Ec:204
-=
# IGN: We reuse the same variable name due to macro usage
-shadowVariable:s=
rc/openvpn/options=2Ec:1955
-shadowVariable:src/openvpn/options=2Ec:1973
-#=
 FP: fun:tls_crypt_v2_wrap_unwrap_invalid: cppcheck is confused
-syntaxErro=
r:tests/unit_tests/openvpn/test_tls_crypt=2Ec:684
-# FP: this file is never=
 compiled on _WIN32
-umaskCalled:tests/unit_tests/openvpn/test_pkcs11=2Ec
-=
# FP: yes, t_prev is unitialized, but t_prev_len is 0, so that's handled
-u=
ninitvar:src/openvpn/crypto_epoch=2Ec:60
-# FP: yes, parm is unitialized, b=
ut parm_len is 0, so that's handled
-uninitvar:src/openvpn/options_parse=2E=
c:148
-# FP: uninit is fine when it is a return parameter
-ctuuninitvar:src=
/openvpn/crypto_mbedtls_legacy=2Ec:690
-uninitvar:src/openvpnserv/interacti=
ve=2Ec:2783
-uninitvar:src/tapctl/main=2Ec:566
-# FP: weird parse error, th=
e macro is fine in the rest of the file
-unknownMacro:src/openvpnserv/inter=
active=2Ec:3604
-# FP: cppcheck doesn't account for short-circuiting
-unrea=
dVariable:src/openvpn/manage=2Ec:682
-unusedFunction:src/openvpn/siphash_re=
ference=2Ec
-# FP: exported as DLL
-unusedFunction:src/openvpnmsica/*=2Ec
-=
# FP: loaded as plugins
-unusedFunction:src/plugins/*
-unusedFunction:sampl=
e/sample-plugins/*
-# FP: wmain
-unusedFunction:src/tapctl/main=2Ec:613
-un=
usedFunction:tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
-# IGN: keep=
 mocking around for future use
-unusedFunction:tests/unit_tests/openvpn/moc=
k_msg=2Ec
-unusedFunction:/usr/include/*
-# FP: cppcheck doesn't know the N=
LA macros
-unusedLabel:src/openvpn/dco_linux=2Ec
-# IGN: old code that is d=
ifficult to test (MSG_ERRQUEUE), ignore for now
-unusedStructMember:src/ope=
nvpn/mtu=2Ec:289
-# FP: used implictly by NL macros
-unusedStructMember:src=
/openvpn/networking_sitnl=2Ec
-# IGN: keep explanatory fields in test data
=
-unusedStructMember:tests/unit_tests/openvpn/test_pkcs11=2Ec
-# IGN: nicer =
to assign generic "arg" early
-variableScope:src/openvpn/networking_sitnl=
=2Ec:1390
-# IGN: nicer to keep the "variable" earlier
-variableScope:src/o=
penvpnserv/interactive=2Ec:2687
-# FP: fun:platform_create_temp_file: cppch=
eck is confused
-wrongPrintfScanfArgNum:src/openvpn/platform=2Ec:553
diff -=
-git a/dev-tools/cppcheck-suppressions=2Exml b/dev-tools/cppcheck-suppressi=
ons=2Exml
new file mode 100644
index 0000000=2E=2E73dd41b
--- /dev/null
+++=
 b/dev-tools/cppcheck-suppressions=2Exml
@@ -0,0 +1,209 @@
+<?xml version=
=3D"1=2E0"?>
+<suppressions>
+  <!-- We start with enable=3Dall, but then s=
uppress some issues that have too many
+       occurences right now=2E They=
 still should be fixed at some point -->
+  <suppress>
+    <id>constParame=
ter</id>
+  </suppress>
+  <suppress>
+    <id>constParameterCallback</id>
=
+  </suppress>
+  <suppress>
+    <id>constParameterPointer</id>
+  </suppr=
ess>
+  <suppress>
+    <id>invalidPrintfArgType_sint</id>
+  </suppress>
+=
  <suppress>
+    <id>invalidPrintfArgType_uint</id>
+  </suppress>
+  <sup=
press>
+    <id>unusedFunction</id>
+  </suppress>
+  <suppress>
+    <id>u=
sleepCalled</id>
+  </suppress>
+  <suppress>
+    <id>variableScope</id>
+=
  </suppress>
+  <!-- We have a lot of library includes, not all of them ar=
e really required,
+       so ignore them -->
+  <suppress>
+    <id>missin=
gIncludeSystem</id>
+  </suppress>
+  <!-- cppcheck doesn't understand abou=
t check_malloc_return, so these are
+       usually misleading -->
+  <supp=
ress>
+    <id>nullPointerOutOfMemory</id>
+  </suppress>
+  <suppress>
+  =
  <id>nullPointerArithmeticOutOfMemory</id>
+  </suppress>
+  <!-- These ar=
e specific false-positives (FP) or ignored (IGN) issues
+       We might wa=
nt to move some of them to inline-suppression to avoid
+       the static l=
ine-numbers -->
+  <!-- IGN: posix=2Ecfg: We are not threadsafe -->
+  <sup=
press>
+    <id>getgrnamCalled</id>
+  </suppress>
+  <suppress>
+    <id>g=
etpwnamCalled</id>
+  </suppress>
+  <suppress>
+    <id>getservbynameCalle=
d</id>
+  </suppress>
+  <suppress>
+    <id>localtimeCalled</id>
+  </supp=
ress>
+  <!-- IGN: too many false-positives due to platform-specific code -=
->
+  <suppress>
+    <id>knownConditionTrueFalse</id>
+  </suppress>
+  <!=
-- FP: posix=2Ecfg claims suseconds_t is unsigned for some reason -->
+  <s=
uppress>
+    <id>unsignedLessThanZero</id>
+    <fileName>src/openvpn/otim=
e=2Eh</fileName>
+    <symbolName>usec</symbolName>
+  </suppress>
+  <!-- =
IGN: the code header =3D 0 | (OPCODE << P_OPCODE_SHIFT) is used intentional=
ly -->
+  <suppress>
+    <id>badBitmaskCheck</id>
+    <fileName>src/openv=
pn/mudp=2Ec</fileName>
+  </suppress>
+  <suppress>
+    <id>badBitmaskChec=
k</id>
+    <fileName>tests/unit_tests/openvpn/test_pkt=2Ec</fileName>
+  <=
/suppress>
+  <!-- FP: cppcheck seems to have wrong signature of DeviceIoCo=
ntrol() -->
+  <suppress>
+    <id>constVariablePointer</id>
+    <fileName=
>src/openvpn/dco_win=2Ec</fileName>
+    <symbolName>buf</symbolName>
+  </=
suppress>
+  <!-- IGN: test_networking code would break with iproute2 but t=
hat is prevented -->
+  <suppress>
+    <id>ctunullpointer</id>
+    <fileN=
ame>src/openvpn/networking_iproute2=2Ec</fileName>
+  </suppress>
+  <!-- I=
GN: event code uses a pointer to store integers -->
+  <suppress>
+    <id>=
intToPointerCast</id>
+    <fileName>src/openvpn/forward=2Ec</fileName>
+  =
</suppress>
+  <suppress>
+    <id>intToPointerCast</id>
+    <fileName>src=
/openvpn/multi_io=2Ec</fileName>
+  </suppress>
+  <suppress>
+    <id>intT=
oPointerCast</id>
+    <fileName>src/openvpn/ps=2Ec</fileName>
+  </suppres=
s>
+  <!-- FP: cppcheck seems to be confused since we cast the pointer to i=
nteger -->
+  <suppress>
+    <id>memleak</id>
+    <fileName>src/plugins/d=
own-root/down-root=2Ec</fileName>
+    <symbolName>context=2Ecommand</symbo=
lName>
+  </suppress>
+  <!-- IGN: we just abort instead -->
+  <suppress>
=
+    <id>memleakOnRealloc</id>
+    <fileName>src/openvpn/dco_freebsd=2Ec</=
fileName>
+    <symbolName>buf</symbolName>
+  </suppress>
+  <!-- IGN: str=
len(NULL) is not nice code, but seems to work -->
+  <suppress>
+    <id>nu=
llPointerRedundantCheck</id>
+    <fileName>src/openvpn/init=2Ec</fileName>=

+    <symbolName>parameters</symbolName>
+  </suppress>
+  <!-- FP: cppche=
ck doesn't understand ZeroMemory -->
+  <suppress>
+    <id>redundantAssign=
ment</id>
+    <fileName>src/openvpnserv/interactive=2Ec</fileName>
+    <s=
ymbolName>overlapped-&gt;hEvent</symbolName>
+  </suppress>
+  <!-- IGN: We=
 reuse the same variable name due to macro usage -->
+  <suppress>
+    <id=
>shadowVariable</id>
+    <fileName>src/openvpn/options=2Ec</fileName>
+   =
 <symbolName>use_err</symbolName>
+  </suppress>
+  <!-- FP: this file is n=
ever compiled on _WIN32 -->
+  <suppress>
+    <id>umaskCalled</id>
+    <f=
ileName>tests/unit_tests/openvpn/test_pkcs11=2Ec</fileName>
+  </suppress>
=
+  <!-- FP: yes, t_prev is unitialized, but t_prev_len is 0, so that's hand=
led -->
+  <suppress>
+    <id>uninitvar</id>
+    <fileName>src/openvpn/cr=
ypto_epoch=2Ec</fileName>
+    <symbolName>t_prev</symbolName>
+  </suppres=
s>
+  <!-- FP: yes, parm is unitialized, but parm_len is 0, so that's handl=
ed -->
+  <suppress>
+    <id>uninitvar</id>
+    <fileName>src/openvpn/opt=
ions_parse=2Ec</fileName>
+    <symbolName>parm</symbolName>
+  </suppress>=

+  <!-- FP: uninit is fine when it is a return parameter -->
+  <suppress>=

+    <id>uninitvar</id>
+    <fileName>src/openvpnserv/interactive=2Ec</fi=
leName>
+    <symbolName>addr_list</symbolName>
+  </suppress>
+  <suppress=
>
+    <id>uninitvar</id>
+    <fileName>src/tapctl/main=2Ec</fileName>
+  =
  <symbolName>guidAdapter</symbolName>
+  </suppress>
+  <!-- FP: cppcheck =
doesn't account for short-circuiting -->
+  <suppress>
+    <id>unreadVaria=
ble</id>
+    <fileName>src/openvpn/manage=2Ec</fileName>
+    <symbolName>=
n</symbolName>
+  </suppress>
+  <!-- FP: exported as DLL -->
+  <suppress>=

+    <id>unusedFunction</id>
+    <fileName>src/openvpnmsica/*=2Ec</fileNa=
me>
+  </suppress>
+  <!-- FP: loaded as plugins -->
+  <suppress>
+    <id=
>unusedFunction</id>
+    <fileName>src/plugins/*</fileName>
+  </suppress>=

+  <suppress>
+    <id>unusedFunction</id>
+    <fileName>sample/sample-pl=
ugins/*</fileName>
+  </suppress>
+  <!-- IGN: keep mocking around for futu=
re use -->
+  <suppress>
+    <id>unusedFunction</id>
+    <fileName>tests/=
unit_tests/openvpn/mock_msg=2Ec</fileName>
+  </suppress>
+  <suppress>
+  =
  <id>unusedFunction</id>
+    <fileName>/usr/include/*</fileName>
+  </sup=
press>
+  <!-- FP: cppcheck doesn't know the NLA macros -->
+  <suppress>
+=
    <id>unusedLabel</id>
+    <fileName>src/openvpn/dco_linux=2Ec</fileName=
>
+  </suppress>
+  <!-- IGN: old code that is difficult to test (MSG_ERRQU=
EUE), ignore for now -->
+  <suppress>
+    <id>unusedStructMember</id>
+  =
  <fileName>src/openvpn/mtu=2Ec</fileName>
+    <symbolName>probehdr::ttl</=
symbolName>
+  </suppress>
+  <!-- FP: used implictly by NL macros -->
+  <=
suppress>
+    <id>unusedStructMember</id>
+    <fileName>src/openvpn/netwo=
rking_sitnl=2Ec</fileName>
+  </suppress>
+  <!-- IGN: keep explanatory fie=
lds in test data -->
+  <suppress>
+    <id>unusedStructMember</id>
+    <f=
ileName>tests/unit_tests/openvpn/test_pkcs11=2Ec</fileName>
+  </suppress>
=
+</suppressions>
diff --git a/dev-tools/openvpn-cppcheck-library=2Ecfg b/de=
v-tools/openvpn-cppcheck-library=2Ecfg
index decac67=2E=2E0537b39 100644
--=
- a/dev-tools/openvpn-cppcheck-library=2Ecfg
+++ b/dev-tools/openvpn-cppche=
ck-library=2Ecfg
@@ -28,4 +28,7 @@
   <define name=3D"CMSG_NXTHDR" value=3D=
"cmsg_nxthdr" />
   <!-- otherwise a lot of unused variables are shown for =
enable-small builds -->
   <define name=3D"DMSG_ALWAYS_AVAILABLE" value=3D"=
1" />
+  <!-- cppcheck understands it directly in format string, but not
+ =
      indirectly when the format string is constructed earlier -->
+  <defi=
ne name=3D"PRIx64" value=3D"&quot;lx&quot;" />
 </def>
diff --git a/dev-too=
ls/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh
index 37de267=2E=2E4c4ba=
2c 100755
--- a/dev-tools/run-cppcheck=2Esh
+++ b/dev-tools/run-cppcheck=2E=
sh
@@ -30,7 +30,7 @@
  --enable=3Dall ${disable_arg} \
  --library=3D${SCRI=
PT_DIR}/openvpn-cppcheck-library=2Ecfg \
  --library=3Dopenssl=2Ecfg \
- --=
suppressions-list=3D${SCRIPT_DIR}/cppcheck-suppression \
+ --suppress-xml=
=3D${SCRIPT_DIR}/cppcheck-suppressions=2Exml --inline-suppr \
  --cppcheck-=
build-dir=3D${CPPCHECK_DIR} \
  --check-level=3D${CPPCHECK_CHECK_LEVEL} --m=
ax-configs=3D10 \
  --error-exitcode=3D1 --showtime=3Dsummary"
@@ -39,13 +3=
9,14 @@
 
 mkdir -p "$CPPCHECK_DIR"
 cd "${SOURCE_DIR}"
+ret=3D0
 cppcheck =
$COMMON_ARGS $INCLUDE_FLAGS \
     --platform=3Dunix64 \
     --library=3Dp=
osix=2Ecfg --library=3Dbsd=2Ecfg --library=3Dgnu=2Ecfg \
     -U_WIN32 \
  =
   src/openvpn/ src/compat/ src/plugins/ sample/ \
     tests/unit_tests/ex=
ample_test/ tests/unit_tests/openvpn/ \
-    tests/unit_tests/plugins/
+   =
 tests/unit_tests/plugins/ || ret=3D$?
 cppcheck $COMMON_ARGS \
     --plat=
form=3Dwin64 \
     --library=3Dwindows=2Ecfg \
@@ -55,4 +56,6 @@
     -UTA=
RGET_AIX \
     -UOPENSSL_NO_EC \
     src/openvpn* src/compat/ \
-    test=
s/unit_tests/example_test/ tests/unit_tests/openvpn*
+    tests/unit_tests/=
example_test/ tests/unit_tests/openvpn* || ret=3D$?
+
+exit $ret
diff --git=
 a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index e5ad31a=2E=2Edc22a=
f5 100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -268=
,7 +268,7 @@
             }
 
             /* Encrypt packet ID, payload */=

-            int outlen;
+            int outlen =3D 0;
             ASSER=
T(cipher_ctx_update(ctx->cipher, BEND(&work), &outlen, BPTR(buf), BLEN(buf)=
));
             ASSERT(buf_inc_len(&work, outlen));
 
@@ -566,7 +566,7 @@
=
     dmsg(D_PACKET_CONTENT, "DECRYPT AD: %s", format_hex(ad_start, ad_size,=
 0, &gc));
 
     /* Decrypt and authenticate packet */
-    int outlen;
+ =
   int outlen =3D 0;
     if (!cipher_ctx_update(ctx->cipher, BPTR(&work), =
&outlen, BPTR(buf), data_len))
     {
         CRYPT_ERROR("packet decrypti=
on failed");
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
ind=
ex fd54946=2E=2Ea6fadf6 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvp=
n/multi=2Ec
@@ -4239,6 +4239,7 @@
     struct multi_context multi;
 
     t=
op->mode =3D CM_TOP;
+    // cppcheck-suppress autoVariables ; yes, we know=
 this is dangerous
     top->multi =3D &multi;
     context_clear_2(top);
 =

diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec
index 4b9=
6c57=2E=2Ebce5018 100644
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/m=
ulti_io=2Ec
@@ -321,6 +321,7 @@
 {
     const unsigned int mpp_flags =3D MP=
P_PRE_SELECT | MPP_RECORD_TOUCH;
     struct multi_instance *touched =3D mi=
;
+    // cppcheck-suppress autoVariables ; yes, we know this is dangerous
=
     m->mpp_touched =3D &touched;
 
     dmsg(D_MULTI_DEBUG, "MULTI IO: mul=
ti_io_dispatch a=3D%s mi=3D" ptr_format, pract(action),
diff --git a/src/op=
envpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index 3653eb4=2E=2E663171=
8 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
=
@@ -925,6 +925,7 @@
 
             errno =3D 0;
             long timeout =
=3D strtol(BSTR(timeout_buf), NULL, 10);
+            // cppcheck-suppress =
compareValueOutOfTypeRangeError ; ULONG_MAX=3D=3DUINT_MAX on Windows
      =
       if (timeout <=3D 0 || (unsigned long)timeout > UINT_MAX || errno)
  =
           {
                 msg(M_WARN, "could not parse auth pending fil=
e timeout");
diff --git a/src/openvpnserv/common=2Ec b/src/openvpnserv/comm=
on=2Ec
index 7fc8c14=2E=2Ecce5318 100644
--- a/src/openvpnserv/common=2Ec
+=
++ b/src/openvpnserv/common=2Ec
@@ -22,6 +22,7 @@
 
 #include "service=2Eh"=

 #include "validate=2Eh"
+// cppcheck-suppress missingInclude ; we run cpp=
check on Linux w/o this file
 #include "eventmsg=2Eh"
 
 #include <pathcch=
=2Eh>
diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/intera=
ctive=2Ec
index 7819f5a=2E=2E4a38aa4 100644
--- a/src/openvpnserv/interacti=
ve=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -3601,6 +3601,7 @@
        =
 goto out;
     }
     swprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),
+=
             // cppcheck-suppress unknownMacro ; FP, complains about _L onl=
y here=2E=2E=2E
              L"\\\\=2E\\pipe\\" _L(PACKAGE) L"%ls\\service=
_%lu_%ls", service_instance,
              GetCurrentThreadId(), pipe_uuid_=
str);
     RpcStringFreeW(&pipe_uuid_str);
diff --git a/tests/unit_tests/op=
envpn/test_tls_crypt=2Ec b/tests/unit_tests/openvpn/test_tls_crypt=2Ec
inde=
x f648e13=2E=2Ef8aa199 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt=
=2Ec
+++ b/tests/unit_tests/openvpn/test_tls_crypt=2Ec
@@ -681,6 +681,7 @@
=
     struct buffer tmp =3D create_client_key_input(ctx, 12);
 
     /* Make=
 the wrapped key invalid by flipping a few bits */
+    // cppcheck-suppres=
s syntaxError ; cppcheck is confused by this code
     buf_bptr(&tmp)[buf_l=
en(&tmp) - 20] ^=3D 0x55;
 
     assert_false(tls_crypt_v2_extract_client_k=
ey(&tmp, &wrap_ctx, NULL));

-- 
To view, visit http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1953?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: Ie06d3543d0a5d4ca3d3fd6f41498e6917ab4c8a9
Gerrit-Change-Number: 1953
=
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razva=
nc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>

--ahmG++pT6iw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1953?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">cppcheck: Clean up suppressions to not ann=
oy developers<br><br>Actually using it in CI has shown that the line number=
<br>based suppression is just too annoying=2E Therefor:<br><br>- Switch to =
XML based suppressions that allow us to<br>  use symbolName in addition to =
lineNumber to limit the<br>  suppression=2E<br>- Suppress knownConditionTru=
eFalse always=2E There are just<br>  too many instances due to how our code=
 is structured=2E<br>- Also remove some unused suppressions=2E<br>- Replace=
 some suppressions with code fixes=2E These are<br>  generally speaking fal=
se positives but the code fix<br>  is less ugly than the suppression=2E<br>=
- Work around one issue with using PRIx64 macro in a<br>  pre-prepared form=
at string by adding a definition in<br>  our library definition=2E<br>- All=
 suppressions that remain that were still lineNumber<br>  based (due to the=
 check not reporting a symbol), move<br>  to inline suppressions=2E Inline =
suppressions are somewhat<br>  ugly, but these are very few and I see no be=
tter<br>  alternative=2E Maybe we can get rid of some of them by<br>  repor=
ting issues to cppcheck=2E (Or, in some cases, by<br>  improving our code)=
=2E<br><br>While here, make sure that we always run the Windows scan<br>as =
well, so developers get complete feedback on first push=2E<br><br>Change-Id=
: Ie06d3543d0a5d4ca3d3fd6f41498e6917ab4c8a9<br>Signed-off-by: Frank Lichten=
held &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1953<br>Message-Id: &lt;20260925213118=2E29507-1-gert@greenie=2Emuc=2Ed=
e&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esource=
forge=2Enet/msg39523=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>D dev-tools/cppcheck-suppression<br>A dev-tools/c=
ppcheck-suppressions=2Exml<br>M dev-tools/openvpn-cppcheck-library=2Ecfg<br=
>M dev-tools/run-cppcheck=2Esh<br>M src/openvpn/crypto=2Ec<br>M src/openvpn=
/multi=2Ec<br>M src/openvpn/multi_io=2Ec<br>M src/openvpn/ssl_verify=2Ec<br=
>M src/openvpnserv/common=2Ec<br>M src/openvpnserv/interactive=2Ec<br>M tes=
ts/unit_tests/openvpn/test_tls_crypt=2Ec<br>11 files changed, 226 insertion=
s(+), 124 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/dev-tools/cppcheck-sup=
pression b/dev-tools/cppcheck-suppression</span><br><span>deleted file mode=
 100644</span><br><span>index 27c9d30=2E=2E0000000</span><br><span>--- a/de=
v-tools/cppcheck-suppression</span><br><span>+++ /dev/null</span><br><span>=
@@ -1,119 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# We=
 start with --enable=3Dall, but then suppress some issues that have too man=
y</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# occurences right n=
ow=2E They still should be fixed at some point</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-constParameter</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-constParameterCallback</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-constParameterPointer</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-invalidPrintfArgType_sint</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-invalidPrintfArgType_uint</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-unusedFunction</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-usleepCalled</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-variableScope</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-# We have a lot of library includes, not all of them are really required=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# so ignore them</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-missingIncludeSystem</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-# cppcheck doesn&#39;t und=
erstand about check_malloc_return, so these are</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-# usually misleading</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-nullPointerOutOfMemory</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-nullPointerArithmeticOutOfMemory</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-# These are specific false-positives (=
FP) or ignored (IGN) issues</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-# We might want to move some of them to inline-suppression to avoid</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-# the static line-numbe=
rs</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# IGN: posix=2Ecfg:=
 We are not threadsafe</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-getgrnamCalled</span><br><span style=3D"color: hsl(0, 100%, 40%);">-getpwn=
amCalled</span><br><span style=3D"color: hsl(0, 100%, 40%);">-getservbyname=
Called</span><br><span style=3D"color: hsl(0, 100%, 40%);">-localtimeCalled=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: posix=2Ecfg cla=
ims suseconds_t is unsigned for some reason</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-unsignedLessThanZero:src/openvpn/otime=2Eh:148</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-# IGN: multi code does weird=
 things with pointers to local variables=2E=2E=2E</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-autoVariables:src/openvpn/multi=2Ec:4242</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-autoVariables:src/openvpn/mu=
lti_io=2Ec:324</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# IGN: =
the code header =3D 0 | (OPCODE &lt;&lt; P_OPCODE_SHIFT) is used intentiona=
lly</span><br><span style=3D"color: hsl(0, 100%, 40%);">-badBitmaskCheck:sr=
c/openvpn/mudp=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bad=
BitmaskCheck:tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-# IGN: Windows specific (unsigned long =3D=3D =
unsigned int)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-compareV=
alueOutOfTypeRangeError:src/openvpn/ssl_verify=2Ec:928</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-# FP: cppcheck seems to have wrong signatu=
re of DeviceIoControl()</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-constVariablePointer:src/openvpn/dco_win=2Ec</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-# IGN: test_networking code would break with iprou=
te2 but that is prevented</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-ctunullpointer:src/openvpn/networking_iproute2=2Ec</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-# IGN: event code uses a pointer to store =
integers</span><br><span style=3D"color: hsl(0, 100%, 40%);">-intToPointerC=
ast:src/openvpn/forward=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-intToPointerCast:src/openvpn/multi_io=2Ec</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-intToPointerCast:src/openvpn/ps=2Ec</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-# FP: constant but differs between =
platforms</span><br><span style=3D"color: hsl(0, 100%, 40%);">-knownConditi=
onTrueFalse:src/openvpn/error=2Eh:382</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-knownConditionTrueFalse:src/openvpn/fdmisc=2Ec:80</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-knownConditionTrueFalse:src/ope=
nvpn/lladdr=2Ec:64</span><br><span style=3D"color: hsl(0, 100%, 40%);">-kno=
wnConditionTrueFalse:src/openvpn/platform=2Ec</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-# FP: code needs to accomodate many different defin=
es</span><br><span style=3D"color: hsl(0, 100%, 40%);">-knownConditionTrueF=
alse:src/openvpn/event=2Ec:1139</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-knownConditionTrueFalse:src/openvpn/event=2Ec:1148</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-# FP: dco_win support has &quot;fals=
e&quot; stubs</span><br><span style=3D"color: hsl(0, 100%, 40%);">-knownCon=
ditionTrueFalse:src/openvpn/forward=2Ec</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-knownConditionTrueFalse:src/openvpn/init=2Ec</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-knownConditionTrueFalse:src/openvp=
n/multi_io=2Ec:197</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# F=
P: cppcheck thinks that some functions always return true, but they don&#39=
;t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-knownConditionTrueF=
alse:src/openvpn/misc=2Ec:97</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-knownConditionTrueFalse:src/openvpn/sig=2Eh:116</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-# FP: cert_uri_supported is a wrapper arou=
nd defines, so it&#39;s</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-# always constant but differs depending on OpenSSL version</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-knownConditionTrueFalse:src/openvpn/=
ssl_openssl=2Ec:1260</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
 FP: cppcheck doesn&#39;t understand that the function changes szErrMessage=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-knownConditionTrueFal=
se:src/tapctl/main=2Ec:704</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-knownConditionTrueFalse:src/openvpnmsica/dllmain=2Ec:164</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-# FP: cppcheck seems to be confused=
 since we cast the pointer to integer</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-memleak:src/plugins/down-root/down-root=2Ec:337</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-# IGN: we just abort instead</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-memleakOnRealloc:src/openv=
pn/dco_freebsd=2Ec:845</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-# FP: eventmsg=2Eh is not built on Unix</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-missingInclude:src/openvpnserv/common=2Ec:25</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-# IGN: strlen(NULL) is not nice c=
ode, but seems to work</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-nullPointerRedundantCheck:src/openvpn/init=2Ec:301</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# FP: cppcheck doesn&#39;t understand ZeroM=
emory</span><br><span style=3D"color: hsl(0, 100%, 40%);">-redundantAssignm=
ent:src/openvpnserv/interactive=2Ec:204</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-# IGN: We reuse the same variable name due to macro usage=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-shadowVariable:src/op=
envpn/options=2Ec:1955</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-shadowVariable:src/openvpn/options=2Ec:1973</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-# FP: fun:tls_crypt_v2_wrap_unwrap_invalid: cppcheck=
 is confused</span><br><span style=3D"color: hsl(0, 100%, 40%);">-syntaxErr=
or:tests/unit_tests/openvpn/test_tls_crypt=2Ec:684</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-# FP: this file is never compiled on _WIN32</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-umaskCalled:tests/unit_t=
ests/openvpn/test_pkcs11=2Ec</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-# FP: yes, t_prev is unitialized, but t_prev_len is 0, so that&#39;s=
 handled</span><br><span style=3D"color: hsl(0, 100%, 40%);">-uninitvar:src=
/openvpn/crypto_epoch=2Ec:60</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-# FP: yes, parm is unitialized, but parm_len is 0, so that&#39;s han=
dled</span><br><span style=3D"color: hsl(0, 100%, 40%);">-uninitvar:src/ope=
nvpn/options_parse=2Ec:148</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-# FP: uninit is fine when it is a return parameter</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-ctuuninitvar:src/openvpn/crypto_mbedtls_l=
egacy=2Ec:690</span><br><span style=3D"color: hsl(0, 100%, 40%);">-uninitva=
r:src/openvpnserv/interactive=2Ec:2783</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-uninitvar:src/tapctl/main=2Ec:566</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-# FP: weird parse error, the macro is fine in =
the rest of the file</span><br><span style=3D"color: hsl(0, 100%, 40%);">-u=
nknownMacro:src/openvpnserv/interactive=2Ec:3604</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-# FP: cppcheck doesn&#39;t account for short-cir=
cuiting</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unreadVariable=
:src/openvpn/manage=2Ec:682</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-unusedFunction:src/openvpn/siphash_reference=2Ec</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-# FP: exported as DLL</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-unusedFunction:src/openvpnmsica/*=2Ec</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: loaded as plugins</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-unusedFunction:src/plugi=
ns/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unusedFunction:sa=
mple/sample-plugins/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
# FP: wmain</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unusedFunc=
tion:src/tapctl/main=2Ec:613</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-unusedFunction:tests/unit_tests/openvpnserv/test_openvpnserv=2Ec</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-# IGN: keep mocking aroun=
d for future use</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unuse=
dFunction:tests/unit_tests/openvpn/mock_msg=2Ec</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-unusedFunction:/usr/include/*</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-# FP: cppcheck doesn&#39;t know the NLA m=
acros</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unusedLabel:src/=
openvpn/dco_linux=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
# IGN: old code that is difficult to test (MSG_ERRQUEUE), ignore for now</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-unusedStructMember:src/o=
penvpn/mtu=2Ec:289</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# F=
P: used implictly by NL macros</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-unusedStructMember:src/openvpn/networking_sitnl=2Ec</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-# IGN: keep explanatory fields in te=
st data</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unusedStructMe=
mber:tests/unit_tests/openvpn/test_pkcs11=2Ec</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-# IGN: nicer to assign generic &quot;arg&quot; earl=
y</span><br><span style=3D"color: hsl(0, 100%, 40%);">-variableScope:src/op=
envpn/networking_sitnl=2Ec:1390</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-# IGN: nicer to keep the &quot;variable&quot; earlier</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-variableScope:src/openvpnserv/int=
eractive=2Ec:2687</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# FP=
: fun:platform_create_temp_file: cppcheck is confused</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-wrongPrintfScanfArgNum:src/openvpn/platform=
=2Ec:553</span><br><span>diff --git a/dev-tools/cppcheck-suppressions=2Exml=
 b/dev-tools/cppcheck-suppressions=2Exml</span><br><span>new file mode 1006=
44</span><br><span>index 0000000=2E=2E73dd41b</span><br><span>--- /dev/null=
</span><br><span>+++ b/dev-tools/cppcheck-suppressions=2Exml</span><br><spa=
n>@@ -0,0 +1,209 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
&lt;?xml version=3D&quot;1=2E0&quot;?&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+&lt;suppressions&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  &lt;!-- We start with enable=3Dall, but then suppr=
ess some issues that have too many</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+       occurences right now=2E They still should be fixed at=
 some point --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &lt;id&gt;constParameter&lt;/id&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    &lt;id&gt;constParameterCallback&lt;/id&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;constParameterPoi=
nter&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &l=
t;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &l=
t;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &=
lt;id&gt;invalidPrintfArgType_sint&lt;/id&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &lt;id&gt;invalidPrintfArgType_uint&lt;/id&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;unused=
Function&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   &lt;id&gt;usleepCalled&lt;/id&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    &lt;id&gt;variableScope&lt;/id&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- We have a lot of library inclu=
des, not all of them are really required,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+       so ignore them --&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    &lt;id&gt;missingIncludeSystem&lt;/id&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- cppcheck =
doesn&#39;t understand about check_malloc_return, so these are</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+       usually misleading --&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;nullPo=
interOutOfMemory&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    &lt;id&gt;nullPointerArithmeticOutOfMemory&lt;/id&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- These are specific f=
alse-positives (FP) or ignored (IGN) issues</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+       We might want to move some of them to inline=
-suppression to avoid</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+       the static line-numbers --&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  &lt;!-- IGN: posix=2Ecfg: We are not threadsafe --&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;getgr=
namCalled&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    &lt;id&gt;getpwnamCalled&lt;/id&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    &lt;id&gt;getservbynameCalled&lt;/id&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;localtimeCalled&lt=
;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/supp=
ress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- I=
GN: too many false-positives due to platform-specific code --&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;knownConditionTr=
ueFalse&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 &lt;!-- FP: posix=2Ecfg claims suseconds_t is unsigned for some reason --&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;uns=
ignedLessThanZero&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    &lt;fileName&gt;src/openvpn/otime=2Eh&lt;/fileName&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;usec&=
lt;/symbolName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 &lt;!-- IGN: the code header =3D 0 | (OPCODE &lt;&lt; P_OPCODE_SHIFT) is u=
sed intentionally --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    &lt;id&gt;badBitmaskCheck&lt;/id&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/mudp=2Ec&lt;/fileN=
ame&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppr=
ess&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppre=
ss&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt=
;badBitmaskCheck&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    &lt;fileName&gt;tests/unit_tests/openvpn/test_pkt=2Ec&lt;/fileN=
ame&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppr=
ess&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP=
: cppcheck seems to have wrong signature of DeviceIoControl() --&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;constVariable=
Pointer&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   &lt;fileName&gt;src/openvpn/dco_win=2Ec&lt;/fileName&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;buf&lt;/symbo=
lName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/sup=
press&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- =
IGN: test_networking code would break with iproute2 but that is prevented -=
-&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;c=
tunullpointer&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    &lt;fileName&gt;src/openvpn/networking_iproute2=2Ec&lt;/fileName&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: ev=
ent code uses a pointer to store integers --&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    &lt;id&gt;intToPointerCast&lt;/id&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/o=
penvpn/forward=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    &lt;id&gt;intToPointerCast&lt;/id&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/multi_=
io=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    &lt;id&gt;intToPointerCast&lt;/id&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/ps=2Ec&lt;/fileNam=
e&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppres=
s&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: =
cppcheck seems to be confused since we cast the pointer to integer --&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;memleak&=
lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;f=
ileName&gt;src/plugins/down-root/down-root=2Ec&lt;/fileName&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;context=
=2Ecommand&lt;/symbolName&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  &lt;!-- IGN: we just abort instead --&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;memleakOnRealloc&lt;/id&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt=
;src/openvpn/dco_freebsd=2Ec&lt;/fileName&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;buf&lt;/symbolName&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: strlen(NU=
LL) is not nice code, but seems to work --&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    &lt;id&gt;nullPointerRedundantCheck&lt;/id&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&g=
t;src/openvpn/init=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    &lt;symbolName&gt;parameters&lt;/symbolName&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: cppcheck =
doesn&#39;t understand ZeroMemory --&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    &lt;id&gt;redundantAssignment&lt;/id&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvp=
nserv/interactive=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    &lt;symbolName&gt;overlapped-&amp;gt;hEvent&lt;/symb=
olName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/su=
ppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!--=
 IGN: We reuse the same variable name due to macro usage --&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;shadowVariable&lt;=
/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;file=
Name&gt;src/openvpn/options=2Ec&lt;/fileName&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;use_err&lt;/symbolName&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: thi=
s file is never compiled on _WIN32 --&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    &lt;id&gt;umaskCalled&lt;/id&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;tests/unit_tests/=
openvpn/test_pkcs11=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  &lt;!-- FP: yes, t_prev is unitialized, but t_prev_l=
en is 0, so that&#39;s handled --&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    &lt;id&gt;uninitvar&lt;/id&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/crypto_ep=
och=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    &lt;symbolName&gt;t_prev&lt;/symbolName&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: yes, parm is unitialized, b=
ut parm_len is 0, so that&#39;s handled --&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    &lt;id&gt;uninitvar&lt;/id&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/op=
tions_parse=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    &lt;symbolName&gt;parm&lt;/symbolName&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: uninit is fine when it=
 is a return parameter --&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    &lt;id&gt;uninitvar&lt;/id&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpnserv/interactive=2Ec=
&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &lt;symbolName&gt;addr_list&lt;/symbolName&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    &lt;id&gt;uninitvar&lt;/id&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/tapctl/m=
ain=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    &lt;symbolName&gt;guidAdapter&lt;/symbolName&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: cppcheck doesn&#39;t ac=
count for short-circuiting --&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    &lt;id&gt;unreadVariable&lt;/id&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/manage=2E=
c&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   &lt;symbolName&gt;n&lt;/symbolName&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  &lt;!-- FP: exported as DLL --&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;unusedFunction&lt;/id&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&=
gt;src/openvpnmsica/*=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  &lt;!-- FP: loaded as plugins --&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;unusedFunction&lt;/i=
d&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileNa=
me&gt;src/plugins/*&lt;/fileName&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    &lt;id&gt;unusedFunction&lt;/id&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;sample/sample-plugi=
ns/*&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  &lt;!-- IGN: keep mocking around for future use --&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;unusedFunction&lt;/id&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&=
gt;tests/unit_tests/openvpn/mock_msg=2Ec&lt;/fileName&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;unusedFunction&lt;/id&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&g=
t;/usr/include/*&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  &lt;!-- FP: cppcheck doesn&#39;t know the NLA macros --&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;unused=
Label&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 &lt;fileName&gt;src/openvpn/dco_linux=2Ec&lt;/fileName&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: old code that is dif=
ficult to test (MSG_ERRQUEUE), ignore for now --&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;unusedStructMember&lt;/id&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&=
gt;src/openvpn/mtu=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    &lt;symbolName&gt;probehdr::ttl&lt;/symbolName&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: used i=
mplictly by NL macros --&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    &lt;id&gt;unusedStructMember&lt;/id&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/networkin=
g_sitnl=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  &lt;!-- IGN: keep explanatory fields in test data --&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;unusedStructMe=
mber&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
&lt;fileName&gt;tests/unit_tests/openvpn/test_pkcs11=2Ec&lt;/fileName&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+&lt;/suppressions&gt;=
</span><br><span>diff --git a/dev-tools/openvpn-cppcheck-library=2Ecfg b/de=
v-tools/openvpn-cppcheck-library=2Ecfg</span><br><span>index decac67=2E=2E0=
537b39 100644</span><br><span>--- a/dev-tools/openvpn-cppcheck-library=2Ecf=
g</span><br><span>+++ b/dev-tools/openvpn-cppcheck-library=2Ecfg</span><br>=
<span>@@ -28,4 +28,7 @@</span><br><span>   &lt;define name=3D&quot;CMSG_NXT=
HDR&quot; value=3D&quot;cmsg_nxthdr&quot; /&gt;</span><br><span>   &lt;!-- =
otherwise a lot of unused variables are shown for enable-small builds --&gt=
;</span><br><span>   &lt;define name=3D&quot;DMSG_ALWAYS_AVAILABLE&quot; va=
lue=3D&quot;1&quot; /&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  &lt;!-- cppcheck understands it directly in format string, but not<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+       indirectly wh=
en the format string is constructed earlier --&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  &lt;define name=3D&quot;PRIx64&quot; value=
=3D&quot;&amp;quot;lx&amp;quot;&quot; /&gt;</span><br><span> &lt;/def&gt;</=
span><br><span>diff --git a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cpp=
check=2Esh</span><br><span>index 37de267=2E=2E4c4ba2c 100755</span><br><spa=
n>--- a/dev-tools/run-cppcheck=2Esh</span><br><span>+++ b/dev-tools/run-cpp=
check=2Esh</span><br><span>@@ -30,7 +30,7 @@</span><br><span>  --enable=3Da=
ll ${disable_arg} \</span><br><span>  --library=3D${SCRIPT_DIR}/openvpn-cpp=
check-library=2Ecfg \</span><br><span>  --library=3Dopenssl=2Ecfg \</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- --suppressions-list=3D${SCRI=
PT_DIR}/cppcheck-suppression \</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ --suppress-xml=3D${SCRIPT_DIR}/cppcheck-suppressions=2Exml --in=
line-suppr \</span><br><span>  --cppcheck-build-dir=3D${CPPCHECK_DIR} \</sp=
an><br><span>  --check-level=3D${CPPCHECK_CHECK_LEVEL} --max-configs=3D10 \=
</span><br><span>  --error-exitcode=3D1 --showtime=3Dsummary&quot;</span><b=
r><span>@@ -39,13 +39,14 @@</span><br><span> </span><br><span> mkdir -p &qu=
ot;$CPPCHECK_DIR&quot;</span><br><span> cd &quot;${SOURCE_DIR}&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ret=3D0</span><br><span> c=
ppcheck $COMMON_ARGS $INCLUDE_FLAGS \</span><br><span>     --platform=3Duni=
x64 \</span><br><span>     --library=3Dposix=2Ecfg --library=3Dbsd=2Ecfg --=
library=3Dgnu=2Ecfg \</span><br><span>     -U_WIN32 \</span><br><span>     =
src/openvpn/ src/compat/ src/plugins/ sample/ \</span><br><span>     tests/=
unit_tests/example_test/ tests/unit_tests/openvpn/ \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    tests/unit_tests/plugins/</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    tests/unit_tests/plugins/ || =
ret=3D$?</span><br><span> cppcheck $COMMON_ARGS \</span><br><span>     --pl=
atform=3Dwin64 \</span><br><span>     --library=3Dwindows=2Ecfg \</span><br=
><span>@@ -55,4 +56,6 @@</span><br><span>     -UTARGET_AIX \</span><br><spa=
n>     -UOPENSSL_NO_EC \</span><br><span>     src/openvpn* src/compat/ \</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    tests/unit_tests/exa=
mple_test/ tests/unit_tests/openvpn*</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    tests/unit_tests/example_test/ tests/unit_tests/openvp=
n* || ret=3D$?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+exit $ret</span><br><spa=
n>diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><s=
pan>index e5ad31a=2E=2Edc22af5 100644</span><br><span>--- a/src/openvpn/cry=
pto=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -26=
8,7 +268,7 @@</span><br><span>             }</span><br><span> </span><br><s=
pan>             /* Encrypt packet ID, payload */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            int outlen;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            int outlen =3D 0;</span><br><=
span>             ASSERT(cipher_ctx_update(ctx-&gt;cipher, BEND(&amp;work),=
 &amp;outlen, BPTR(buf), BLEN(buf)));</span><br><span>             ASSERT(b=
uf_inc_len(&amp;work, outlen));</span><br><span> </span><br><span>@@ -566,7=
 +566,7 @@</span><br><span>     dmsg(D_PACKET_CONTENT, &quot;DECRYPT AD: %s=
&quot;, format_hex(ad_start, ad_size, 0, &amp;gc));</span><br><span> </span=
><br><span>     /* Decrypt and authenticate packet */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int outlen;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    int outlen =3D 0;</span><br><span>     if (=
!cipher_ctx_update(ctx-&gt;cipher, BPTR(&amp;work), &amp;outlen, BPTR(buf),=
 data_len))</span><br><span>     {</span><br><span>         CRYPT_ERROR(&qu=
ot;packet decryption failed&quot;);</span><br><span>diff --git a/src/openvp=
n/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index fd54946=2E=2Ea6fa=
df6 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ =
b/src/openvpn/multi=2Ec</span><br><span>@@ -4239,6 +4239,7 @@</span><br><sp=
an>     struct multi_context multi;</span><br><span> </span><br><span>     =
top-&gt;mode =3D CM_TOP;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    // cppcheck-suppress autoVariables ; yes, we know this is dangerou=
s</span><br><span>     top-&gt;multi =3D &amp;multi;</span><br><span>     c=
ontext_clear_2(top);</span><br><span> </span><br><span>diff --git a/src/ope=
nvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>index 4b96c57=
=2E=2Ebce5018 100644</span><br><span>--- a/src/openvpn/multi_io=2Ec</span><=
br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><span>@@ -321,6 +321,7 @@=
</span><br><span> {</span><br><span>     const unsigned int mpp_flags =3D M=
PP_PRE_SELECT | MPP_RECORD_TOUCH;</span><br><span>     struct multi_instanc=
e *touched =3D mi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   // cppcheck-suppress autoVariables ; yes, we know this is dangerous</spa=
n><br><span>     m-&gt;mpp_touched =3D &amp;touched;</span><br><span> </spa=
n><br><span>     dmsg(D_MULTI_DEBUG, &quot;MULTI IO: multi_io_dispatch a=3D=
%s mi=3D&quot; ptr_format, pract(action),</span><br><span>diff --git a/src/=
openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec</span><br><span>index 3=
653eb4=2E=2E6631718 100644</span><br><span>--- a/src/openvpn/ssl_verify=2Ec=
</span><br><span>+++ b/src/openvpn/ssl_verify=2Ec</span><br><span>@@ -925,6=
 +925,7 @@</span><br><span> </span><br><span>             errno =3D 0;</spa=
n><br><span>             long timeout =3D strtol(BSTR(timeout_buf), NULL, 1=
0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            // c=
ppcheck-suppress compareValueOutOfTypeRangeError ; ULONG_MAX=3D=3DUINT_MAX =
on Windows</span><br><span>             if (timeout &lt;=3D 0 || (unsigned =
long)timeout &gt; UINT_MAX || errno)</span><br><span>             {</span><=
br><span>                 msg(M_WARN, &quot;could not parse auth pending fi=
le timeout&quot;);</span><br><span>diff --git a/src/openvpnserv/common=2Ec =
b/src/openvpnserv/common=2Ec</span><br><span>index 7fc8c14=2E=2Ecce5318 100=
644</span><br><span>--- a/src/openvpnserv/common=2Ec</span><br><span>+++ b/=
src/openvpnserv/common=2Ec</span><br><span>@@ -22,6 +22,7 @@</span><br><spa=
n> </span><br><span> #include &quot;service=2Eh&quot;</span><br><span> #inc=
lude &quot;validate=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+// cppcheck-suppress missingInclude ; we run cppcheck on Linux w/=
o this file</span><br><span> #include &quot;eventmsg=2Eh&quot;</span><br><s=
pan> </span><br><span> #include &lt;pathcch=2Eh&gt;</span><br><span>diff --=
git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</sp=
an><br><span>index 7819f5a=2E=2E4a38aa4 100644</span><br><span>--- a/src/op=
envpnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=
=2Ec</span><br><span>@@ -3601,6 +3601,7 @@</span><br><span>         goto ou=
t;</span><br><span>     }</span><br><span>     swprintf(ovpn_pipe_name, _co=
untof(ovpn_pipe_name),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+             // cppcheck-suppress unknownMacro ; FP, complains about _L =
only here=2E=2E=2E</span><br><span>              L&quot;\\\\=2E\\pipe\\&quo=
t; _L(PACKAGE) L&quot;%ls\\service_%lu_%ls&quot;, service_instance,</span><=
br><span>              GetCurrentThreadId(), pipe_uuid_str);</span><br><spa=
n>     RpcStringFreeW(&amp;pipe_uuid_str);</span><br><span>diff --git a/tes=
ts/unit_tests/openvpn/test_tls_crypt=2Ec b/tests/unit_tests/openvpn/test_tl=
s_crypt=2Ec</span><br><span>index f648e13=2E=2Ef8aa199 100644</span><br><sp=
an>--- a/tests/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>+++ b/=
tests/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>@@ -681,6 +681,=
7 @@</span><br><span>     struct buffer tmp =3D create_client_key_input(ctx=
, 12);</span><br><span> </span><br><span>     /* Make the wrapped key inval=
id by flipping a few bits */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    // cppcheck-suppress syntaxError ; cppcheck is confused by thi=
s code</span><br><span>     buf_bptr(&amp;tmp)[buf_len(&amp;tmp) - 20] ^=3D=
 0x55;</span><br><span> </span><br><span>     assert_false(tls_crypt_v2_ext=
ract_client_key(&amp;tmp, &amp;wrap_ctx, NULL));</span><br></pre><p>To view=
, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1953?usp=3Dema=
il">change 1953</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
953?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: Ie06d3543d0a5d4ca3d3fd6f41498e6917ab4c8a9 </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 1953 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flicht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--ahmG++pT6iw=--


--===============0881878027029883908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0881878027029883908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0881878027029883908==--

