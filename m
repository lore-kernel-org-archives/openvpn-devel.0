Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A95EC98325
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=0VBdac+QZo8TjMHcoXhgHzmaktK9zGqzk1FdqyOtpuM=; b=hkTm1FvsyqMi9e
	Y15udSvyJXfCMvgwnflXAbYEkPeUTU3XujHC3LU88HCQbvCxklyA414COMtBFq47f/v5KlhV7vHOX
	mqj1aOk+sZn9VTqLcFxMd055suebX/0NgmOJlnCOfmpaswyPlA2M+wlW6N26Gkb0rgo0u1IZ4ce4g
	xpU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA8Ui-0001a0-IR;
	Fri, 25 Sep 2026 16:09:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA8Ug-0001Zs-Qi
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 16:09:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MS2ORAE+hbvWlidI+RZL2Bibkxv0IpJAxx8K82zvXbg=; b=HMeVa1FB5vYHOayfIxcuwfb9jI
 C2HGybo9BlE67E0vebLk90vZUvHfJTa3njofNy/S4wOxsRLuUx7l3gV81Ba1J9tVA80Q1guWOBreL
 kb/rHFtJKXheXrAugzMk0NvnSWfu0vyt7HVMFKi2cpniXSiMUZaAQ4Elk3PeSekq2+SE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MS2ORAE+hbvWlidI+RZL2Bibkxv0IpJAxx8K82zvXbg=; b=N
 6hojuNp2yIGU7V/Hh12d2xzLkmnuo4E+VQmP6VibXT119uNvV2c/XXrmwHoz9/2ojeO/dApCI6MFC
 l1xfEg3o6vYYTAyx/XPIzel4Yd+qjG+bciwdF2f0tgAEMgVtw3WOUK72Q4VQfAnAtrRa/B/CDkmUR
 OB8aZKyWG/fPo5MQ=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA8Ud-0001CR-2U for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 16:09:50 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912df756so8769545e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 09:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790352580; x=1790957380; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MS2ORAE+hbvWlidI+RZL2Bibkxv0IpJAxx8K82zvXbg=;
 b=XjaIjDoQC+riE5WuNu35YqrAKiwqvw+9jeIbfagkrwcEsVsgn0d91wF9c6KGnLS+ae
 2n9JNOUYHpSnzrW+VCcjMdog99w9OHYDRP3OJQqSaVDBgV84Sca868xrJCQ40WQA7Dw1
 HthomI9QyZWn5kKyan7CNPQWyjs3eC0V0WWQFo1fXsXfs/sjyzIxbYjpxwiZ/g0B5+Xy
 fRXR+oFrO4YqmrVM9nBLHTpBprNXhIo1h92hXs1XQvqKAxfefBwYKZI+IXWheaBB5/tK
 bVEF5EViEtHj5HNv6ySEsrX7LHjVGf42ArLUaNNqLpf2ePEe2jdCiuEAGDOLlaRVVI5i
 B6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790352580; x=1790957380;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MS2ORAE+hbvWlidI+RZL2Bibkxv0IpJAxx8K82zvXbg=;
 b=Vk2d0wAjmZ99ZRZTIZozwt1rop+3q5N0Elotja4L6OXRqiGPoV7tEeGrjKTZ/0SdgZ
 s6D0rx7c8W6xRJb8e2e9ujfd8fzbGRhXvUC+RYc+PuSuJLtkl32D4Pw4oFiTmaRSRw5W
 D6b8JpcCKaT1ufa1xsASHjC3WL534Q0+P8BsGTaXg1eNJ0gFx/MVZuUjjFJxwGAPSTnb
 Lko0b2adrukjYIhU/qHDTsSwtGtlJL25u1w+4i3Bd2h7fymGbLSyruzPQml5oI7tK2X/
 JukoBLVERTt8PkxEdsjqGomyUpVZA+U4AfRN9qKseJVUQo0I3yBfDxDwaXLmkPUiO6M6
 ulow==
X-Gm-Message-State: AFuF++klusw2HHfQGy64/aT9A2lwRX4r9WpN5c1EzgRicilu9iuYf89w
 QbqYE7GyG6lfKrHRze7sRlM52rabbTlhWwn3X3zo43Gl4aAtA3dOaVv2GczNl11MOyhUBqbpQ2G
 m+17IRqj4fv0DRjNXtZ1MZCBTIGlOtUWvhtV7KWbgCYA6jLXjzW22+fjA3GFfYCeMG77iJjyZdj
 y/pOA0jQ==
X-Gm-Gg: AYBFou0bBA2lx5AvacM70DFpisr2Av+wR7MXBvlDgLSiE8mj3OjQhHAyrwa3iwnvkeg
 KA22NBtIYW0x3XBTxyM5INYmhnsc368QtaLGJZRHC25UvyoTf1yUlvv3n7NpzJr2IOCy5Ny9gLH
 NugbDod2DFGi52xRmgIVthcDQ3zEG/y2UKSogwSNQsSf6RNwl4GYcXsRhaKtDu9g+ih0mzulCV1
 n/Gw2FVr8cu+JSf1Eb80xkOdAJwA8DXEmdj70vVP42zMBJv8kRs62CMU4+OYPsBQlP3AcDUG9zu
 CTB81GJpS8mUWZqgoCPh+AC9o1LcVpFMJlmm2RSQfB5gLIX4G82P1zRZXuNqRSI9gqeFGxhvsVF
 Kohh1yNluinfH6EWsmEknmC0/bMrrfAxtTO7mFrHnecTD7FkfrnG48wijNFqGx9X5geRdg4donu
 EIG/0DZ9NjhpahiRlOno/N5Copr2dnGmyY+dqZm8LMHPiHvVh7N5mbcnxeHkKajeWTopL8Crz15
 iVfvmb3fnM3EMR6vCl4NOWgzfhZYUXI8MrztSUVvqUKeCpUImrkgs2KcNEEP1zB8yycmkyjLVvu
 Gxy6oGYvXhkygtQPvyBBKu92dfUoM57+y92DEuIO5EGZ6QE1rF3llT8XFLiB
X-Received: by 2002:a05:600c:a47:b0:49b:9202:6f80 with SMTP id
 5b1f17b1804b1-49fe66abc9cmr110776075e9.6.1790352580080; 
 Fri, 25 Sep 2026 09:09:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff0658747sm81074895e9.1.2026.09.25.09.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 09:09:39 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 16:09:39 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie06d3543d0a5d4ca3d3fd6f41498e6917ab4c8a9
X-Gerrit-Change-Number: 1953
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1953?usp=email>
X-Gerrit-Commit: a1f82017c677cf00f14e74693be1435fcea8a6cd
References: <gerrit.1790352577000.Ie06d3543d0a5d4ca3d3fd6f41498e6917ab4c8a9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzUyNTc3MDAwLkllMDZkMzU0M2QwYTVkNGNhM2QzZmQ2ZjQxNDk4ZTY5MTdhYjRjOGE5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3b3de8367a074e3ff2f0e6e9ee1594ab915087c5-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA8Ud-0001CR-2U
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4151245320545036118=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4151245320545036118==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KlDASNOY0Yk="; charset=UTF-8

--KlDASNOY0Yk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1953?usp=3Demail

to review the following change=2E


Chang=
e subject: cppcheck: Clean up suppressions to not annoy developers
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

cppcheck: Clean up =
suppressions to not annoy developers

Actually using it in CI has shown tha=
t the line number
based suppression is just too annoying=2E Therefor:

- Sw=
itch to XML based suppressions that allow us to
  use symbolName in additio=
n to lineNumber to limit the
  suppression=2E
- Suppress knownConditionTrue=
False always=2E There are just
  too many instances due to how our code is =
structured=2E
- Also remove some unused suppressions=2E
- Replace some supp=
ressions with code fixes=2E These are
  generally speaking false positives =
but the code fix
  is less ugly than the suppression=2E
- Work around one i=
ssue with using PRIx64 macro in a
  pre-prepared format string by adding a =
definition in
  our library definition=2E
- All suppressions that remain th=
at were still lineNumber
  based (due to the check not reporting a symbol),=
 move
  to inline suppressions=2E Inline suppressions are somewhat
  ugly, =
but these are very few and I see no better
  alternative=2E Maybe we can ge=
t rid of some of them by
  reporting issues to cppcheck=2E (Or, in some cas=
es, by
  improving our code)=2E

While here, make sure that we always run t=
he Windows scan
as well, so developers get complete feedback on first push=
=2E

Change-Id: Ie06d3543d0a5d4ca3d3fd6f41498e6917ab4c8a9
Signed-off-by: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
---
D dev-tools/cppcheck-suppress=
ion
A dev-tools/cppcheck-suppressions=2Exml
M dev-tools/openvpn-cppcheck-li=
brary=2Ecfg
M dev-tools/run-cppcheck=2Esh
M src/openvpn/crypto=2Ec
M src/op=
envpn/multi=2Ec
M src/openvpn/multi_io=2Ec
M src/openvpn/ssl_verify=2Ec
M s=
rc/openvpnserv/common=2Ec
M src/openvpnserv/interactive=2Ec
M tests/unit_te=
sts/openvpn/test_tls_crypt=2Ec
11 files changed, 226 insertions(+), 124 del=
etions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/53/1953/1

diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cpp=
check-suppression
deleted file mode 100644
index 299d7a3=2E=2E0000000
--- a=
/dev-tools/cppcheck-suppression
+++ /dev/null
@@ -1,119 +0,0 @@
-# We start=
 with --enable=3Dall, but then suppress some issues that have too many
-# o=
ccurences right now=2E They still should be fixed at some point
-constParam=
eter
-constParameterCallback
-constParameterPointer
-invalidPrintfArgType_s=
int
-invalidPrintfArgType_uint
-unusedFunction
-usleepCalled
-variableScope=

-# We have a lot of library includes, not all of them are really required,=

-# so ignore them
-missingIncludeSystem
-# cppcheck doesn't understand abo=
ut check_malloc_return, so these are
-# usually misleading
-nullPointerOutO=
fMemory
-nullPointerArithmeticOutOfMemory
-# These are specific false-posit=
ives (FP) or ignored (IGN) issues
-# We might want to move some of them to =
inline-suppression to avoid
-# the static line-numbers
-# IGN: posix=2Ecfg:=
 We are not threadsafe
-getgrnamCalled
-getpwnamCalled
-getservbynameCalled=

-localtimeCalled
-# FP: posix=2Ecfg claims suseconds_t is unsigned for som=
e reason
-unsignedLessThanZero:src/openvpn/otime=2Eh:148
-# IGN: multi code=
 does weird things with pointers to local variables=2E=2E=2E
-autoVariables=
:src/openvpn/multi=2Ec:4242
-autoVariables:src/openvpn/multi_io=2Ec:324
-# =
IGN: the code header =3D 0 | (OPCODE << P_OPCODE_SHIFT) is used intentional=
ly
-badBitmaskCheck:src/openvpn/mudp=2Ec
-badBitmaskCheck:tests/unit_tests/=
openvpn/test_pkt=2Ec
-# IGN: Windows specific (unsigned long =3D=3D unsigne=
d int)
-compareValueOutOfTypeRangeError:src/openvpn/ssl_verify=2Ec:928
-# F=
P: cppcheck seems to have wrong signature of DeviceIoControl()
-constVariab=
lePointer:src/openvpn/dco_win=2Ec
-# IGN: test_networking code would break =
with iproute2 but that is prevented
-ctunullpointer:src/openvpn/networking_=
iproute2=2Ec
-# IGN: event code uses a pointer to store integers
-intToPoin=
terCast:src/openvpn/forward=2Ec
-intToPointerCast:src/openvpn/multi_io=2Ec
=
-intToPointerCast:src/openvpn/ps=2Ec
-# FP: constant but differs between pl=
atforms
-knownConditionTrueFalse:src/openvpn/error=2Eh:380
-knownConditionT=
rueFalse:src/openvpn/fdmisc=2Ec:80
-knownConditionTrueFalse:src/openvpn/lla=
ddr=2Ec:64
-knownConditionTrueFalse:src/openvpn/platform=2Ec
-# FP: code ne=
eds to accomodate many different defines
-knownConditionTrueFalse:src/openv=
pn/event=2Ec:1139
-knownConditionTrueFalse:src/openvpn/event=2Ec:1148
-# FP=
: dco_win support has "false" stubs
-knownConditionTrueFalse:src/openvpn/fo=
rward=2Ec
-knownConditionTrueFalse:src/openvpn/init=2Ec
-knownConditionTrue=
False:src/openvpn/multi_io=2Ec:197
-# FP: cppcheck thinks that some functio=
ns always return true, but they don't
-knownConditionTrueFalse:src/openvpn/=
misc=2Ec:97
-knownConditionTrueFalse:src/openvpn/sig=2Eh:116
-# FP: cert_ur=
i_supported is a wrapper around defines, so it's
-# always constant but dif=
fers depending on OpenSSL version
-knownConditionTrueFalse:src/openvpn/ssl_=
openssl=2Ec:1260
-# FP: cppcheck doesn't understand that the function chang=
es szErrMessage
-knownConditionTrueFalse:src/tapctl/main=2Ec:704
-knownCond=
itionTrueFalse:src/openvpnmsica/dllmain=2Ec:164
-# FP: cppcheck seems to be=
 confused since we cast the pointer to integer
-memleak:src/plugins/down-ro=
ot/down-root=2Ec:337
-# IGN: we just abort instead
-memleakOnRealloc:src/op=
envpn/dco_freebsd=2Ec:845
-# FP: eventmsg=2Eh is not built on Unix
-missing=
Include:src/openvpnserv/common=2Ec:25
-# IGN: strlen(NULL) is not nice code=
, but seems to work
-nullPointerRedundantCheck:src/openvpn/init=2Ec:301
-# =
FP: cppcheck doesn't understand ZeroMemory
-redundantAssignment:src/openvpn=
serv/interactive=2Ec:204
-# IGN: We reuse the same variable name due to mac=
ro usage
-shadowVariable:src/openvpn/options=2Ec:1948
-shadowVariable:src/o=
penvpn/options=2Ec:1966
-# FP: fun:tls_crypt_v2_wrap_unwrap_invalid: cppche=
ck is confused
-syntaxError:tests/unit_tests/openvpn/test_tls_crypt=2Ec:684=

-# FP: this file is never compiled on _WIN32
-umaskCalled:tests/unit_tests=
/openvpn/test_pkcs11=2Ec
-# FP: yes, t_prev is unitialized, but t_prev_len =
is 0, so that's handled
-uninitvar:src/openvpn/crypto_epoch=2Ec:60
-# FP: y=
es, parm is unitialized, but parm_len is 0, so that's handled
-uninitvar:sr=
c/openvpn/options_parse=2Ec:148
-# FP: uninit is fine when it is a return p=
arameter
-ctuuninitvar:src/openvpn/crypto_mbedtls_legacy=2Ec:690
-uninitvar=
:src/openvpnserv/interactive=2Ec:2783
-uninitvar:src/tapctl/main=2Ec:566
-#=
 FP: weird parse error, the macro is fine in the rest of the file
-unknownM=
acro:src/openvpnserv/interactive=2Ec:3604
-# FP: cppcheck doesn't account f=
or short-circuiting
-unreadVariable:src/openvpn/manage=2Ec:682
-unusedFunct=
ion:src/openvpn/siphash_reference=2Ec
-# FP: exported as DLL
-unusedFunctio=
n:src/openvpnmsica/*=2Ec
-# FP: loaded as plugins
-unusedFunction:src/plugi=
ns/*
-unusedFunction:sample/sample-plugins/*
-# FP: wmain
-unusedFunction:s=
rc/tapctl/main=2Ec:613
-unusedFunction:tests/unit_tests/openvpnserv/test_op=
envpnserv=2Ec
-# IGN: keep mocking around for future use
-unusedFunction:te=
sts/unit_tests/openvpn/mock_msg=2Ec
-unusedFunction:/usr/include/*
-# FP: c=
ppcheck doesn't know the NLA macros
-unusedLabel:src/openvpn/dco_linux=2Ec
=
-# IGN: old code that is difficult to test (MSG_ERRQUEUE), ignore for now
-=
unusedStructMember:src/openvpn/mtu=2Ec:289
-# FP: used implictly by NL macr=
os
-unusedStructMember:src/openvpn/networking_sitnl=2Ec
-# IGN: keep explan=
atory fields in test data
-unusedStructMember:tests/unit_tests/openvpn/test=
_pkcs11=2Ec
-# IGN: nicer to assign generic "arg" early
-variableScope:src/=
openvpn/networking_sitnl=2Ec:1390
-# IGN: nicer to keep the "variable" earl=
ier
-variableScope:src/openvpnserv/interactive=2Ec:2687
-# FP: fun:platform=
_create_temp_file: cppcheck is confused
-wrongPrintfScanfArgNum:src/openvpn=
/platform=2Ec:553
diff --git a/dev-tools/cppcheck-suppressions=2Exml b/dev-=
tools/cppcheck-suppressions=2Exml
new file mode 100644
index 0000000=2E=2E7=
3dd41b
--- /dev/null
+++ b/dev-tools/cppcheck-suppressions=2Exml
@@ -0,0 +1=
,209 @@
+<?xml version=3D"1=2E0"?>
+<suppressions>
+  <!-- We start with en=
able=3Dall, but then suppress some issues that have too many
+       occure=
nces right now=2E They still should be fixed at some point -->
+  <suppress=
>
+    <id>constParameter</id>
+  </suppress>
+  <suppress>
+    <id>constP=
arameterCallback</id>
+  </suppress>
+  <suppress>
+    <id>constParameterP=
ointer</id>
+  </suppress>
+  <suppress>
+    <id>invalidPrintfArgType_sint=
</id>
+  </suppress>
+  <suppress>
+    <id>invalidPrintfArgType_uint</id>
=
+  </suppress>
+  <suppress>
+    <id>unusedFunction</id>
+  </suppress>
+ =
 <suppress>
+    <id>usleepCalled</id>
+  </suppress>
+  <suppress>
+    <i=
d>variableScope</id>
+  </suppress>
+  <!-- We have a lot of library includ=
es, not all of them are really required,
+       so ignore them -->
+  <sup=
press>
+    <id>missingIncludeSystem</id>
+  </suppress>
+  <!-- cppcheck d=
oesn't understand about check_malloc_return, so these are
+       usually m=
isleading -->
+  <suppress>
+    <id>nullPointerOutOfMemory</id>
+  </suppr=
ess>
+  <suppress>
+    <id>nullPointerArithmeticOutOfMemory</id>
+  </supp=
ress>
+  <!-- These are specific false-positives (FP) or ignored (IGN) issu=
es
+       We might want to move some of them to inline-suppression to avoi=
d
+       the static line-numbers -->
+  <!-- IGN: posix=2Ecfg: We are not =
threadsafe -->
+  <suppress>
+    <id>getgrnamCalled</id>
+  </suppress>
+ =
 <suppress>
+    <id>getpwnamCalled</id>
+  </suppress>
+  <suppress>
+    =
<id>getservbynameCalled</id>
+  </suppress>
+  <suppress>
+    <id>localtim=
eCalled</id>
+  </suppress>
+  <!-- IGN: too many false-positives due to pl=
atform-specific code -->
+  <suppress>
+    <id>knownConditionTrueFalse</id=
>
+  </suppress>
+  <!-- FP: posix=2Ecfg claims suseconds_t is unsigned for=
 some reason -->
+  <suppress>
+    <id>unsignedLessThanZero</id>
+    <fil=
eName>src/openvpn/otime=2Eh</fileName>
+    <symbolName>usec</symbolName>
+=
  </suppress>
+  <!-- IGN: the code header =3D 0 | (OPCODE << P_OPCODE_SHIF=
T) is used intentionally -->
+  <suppress>
+    <id>badBitmaskCheck</id>
+ =
   <fileName>src/openvpn/mudp=2Ec</fileName>
+  </suppress>
+  <suppress>
+=
    <id>badBitmaskCheck</id>
+    <fileName>tests/unit_tests/openvpn/test_p=
kt=2Ec</fileName>
+  </suppress>
+  <!-- FP: cppcheck seems to have wrong s=
ignature of DeviceIoControl() -->
+  <suppress>
+    <id>constVariablePoint=
er</id>
+    <fileName>src/openvpn/dco_win=2Ec</fileName>
+    <symbolName>=
buf</symbolName>
+  </suppress>
+  <!-- IGN: test_networking code would bre=
ak with iproute2 but that is prevented -->
+  <suppress>
+    <id>ctunullpo=
inter</id>
+    <fileName>src/openvpn/networking_iproute2=2Ec</fileName>
+ =
 </suppress>
+  <!-- IGN: event code uses a pointer to store integers -->
+=
  <suppress>
+    <id>intToPointerCast</id>
+    <fileName>src/openvpn/forw=
ard=2Ec</fileName>
+  </suppress>
+  <suppress>
+    <id>intToPointerCast</=
id>
+    <fileName>src/openvpn/multi_io=2Ec</fileName>
+  </suppress>
+  <s=
uppress>
+    <id>intToPointerCast</id>
+    <fileName>src/openvpn/ps=2Ec</=
fileName>
+  </suppress>
+  <!-- FP: cppcheck seems to be confused since we=
 cast the pointer to integer -->
+  <suppress>
+    <id>memleak</id>
+    <=
fileName>src/plugins/down-root/down-root=2Ec</fileName>
+    <symbolName>co=
ntext=2Ecommand</symbolName>
+  </suppress>
+  <!-- IGN: we just abort inst=
ead -->
+  <suppress>
+    <id>memleakOnRealloc</id>
+    <fileName>src/ope=
nvpn/dco_freebsd=2Ec</fileName>
+    <symbolName>buf</symbolName>
+  </supp=
ress>
+  <!-- IGN: strlen(NULL) is not nice code, but seems to work -->
+  =
<suppress>
+    <id>nullPointerRedundantCheck</id>
+    <fileName>src/openv=
pn/init=2Ec</fileName>
+    <symbolName>parameters</symbolName>
+  </suppre=
ss>
+  <!-- FP: cppcheck doesn't understand ZeroMemory -->
+  <suppress>
+ =
   <id>redundantAssignment</id>
+    <fileName>src/openvpnserv/interactive=
=2Ec</fileName>
+    <symbolName>overlapped-&gt;hEvent</symbolName>
+  </su=
ppress>
+  <!-- IGN: We reuse the same variable name due to macro usage -->=

+  <suppress>
+    <id>shadowVariable</id>
+    <fileName>src/openvpn/opti=
ons=2Ec</fileName>
+    <symbolName>use_err</symbolName>
+  </suppress>
+  =
<!-- FP: this file is never compiled on _WIN32 -->
+  <suppress>
+    <id>u=
maskCalled</id>
+    <fileName>tests/unit_tests/openvpn/test_pkcs11=2Ec</fi=
leName>
+  </suppress>
+  <!-- FP: yes, t_prev is unitialized, but t_prev_l=
en is 0, so that's handled -->
+  <suppress>
+    <id>uninitvar</id>
+    <=
fileName>src/openvpn/crypto_epoch=2Ec</fileName>
+    <symbolName>t_prev</s=
ymbolName>
+  </suppress>
+  <!-- FP: yes, parm is unitialized, but parm_le=
n is 0, so that's handled -->
+  <suppress>
+    <id>uninitvar</id>
+    <f=
ileName>src/openvpn/options_parse=2Ec</fileName>
+    <symbolName>parm</sym=
bolName>
+  </suppress>
+  <!-- FP: uninit is fine when it is a return para=
meter -->
+  <suppress>
+    <id>uninitvar</id>
+    <fileName>src/openvpns=
erv/interactive=2Ec</fileName>
+    <symbolName>addr_list</symbolName>
+  <=
/suppress>
+  <suppress>
+    <id>uninitvar</id>
+    <fileName>src/tapctl/=
main=2Ec</fileName>
+    <symbolName>guidAdapter</symbolName>
+  </suppress=
>
+  <!-- FP: cppcheck doesn't account for short-circuiting -->
+  <suppres=
s>
+    <id>unreadVariable</id>
+    <fileName>src/openvpn/manage=2Ec</file=
Name>
+    <symbolName>n</symbolName>
+  </suppress>
+  <!-- FP: exported a=
s DLL -->
+  <suppress>
+    <id>unusedFunction</id>
+    <fileName>src/ope=
nvpnmsica/*=2Ec</fileName>
+  </suppress>
+  <!-- FP: loaded as plugins -->=

+  <suppress>
+    <id>unusedFunction</id>
+    <fileName>src/plugins/*</f=
ileName>
+  </suppress>
+  <suppress>
+    <id>unusedFunction</id>
+    <fi=
leName>sample/sample-plugins/*</fileName>
+  </suppress>
+  <!-- IGN: keep =
mocking around for future use -->
+  <suppress>
+    <id>unusedFunction</id=
>
+    <fileName>tests/unit_tests/openvpn/mock_msg=2Ec</fileName>
+  </supp=
ress>
+  <suppress>
+    <id>unusedFunction</id>
+    <fileName>/usr/includ=
e/*</fileName>
+  </suppress>
+  <!-- FP: cppcheck doesn't know the NLA mac=
ros -->
+  <suppress>
+    <id>unusedLabel</id>
+    <fileName>src/openvpn/=
dco_linux=2Ec</fileName>
+  </suppress>
+  <!-- IGN: old code that is diffi=
cult to test (MSG_ERRQUEUE), ignore for now -->
+  <suppress>
+    <id>unus=
edStructMember</id>
+    <fileName>src/openvpn/mtu=2Ec</fileName>
+    <sym=
bolName>probehdr::ttl</symbolName>
+  </suppress>
+  <!-- FP: used implictl=
y by NL macros -->
+  <suppress>
+    <id>unusedStructMember</id>
+    <fil=
eName>src/openvpn/networking_sitnl=2Ec</fileName>
+  </suppress>
+  <!-- IG=
N: keep explanatory fields in test data -->
+  <suppress>
+    <id>unusedSt=
ructMember</id>
+    <fileName>tests/unit_tests/openvpn/test_pkcs11=2Ec</fi=
leName>
+  </suppress>
+</suppressions>
diff --git a/dev-tools/openvpn-cppc=
heck-library=2Ecfg b/dev-tools/openvpn-cppcheck-library=2Ecfg
index 1ea91f4=
=2E=2Eb2c0973 100644
--- a/dev-tools/openvpn-cppcheck-library=2Ecfg
+++ b/d=
ev-tools/openvpn-cppcheck-library=2Ecfg
@@ -26,4 +26,7 @@
   <!-- work arou=
nd macro confusion -->
   <define name=3D"CMSG_FIRSTHDR" value=3D"cmsg_firs=
thdr" />
   <define name=3D"CMSG_NXTHDR" value=3D"cmsg_nxthdr" />
+  <!-- c=
ppcheck understands it directly in format string, but not
+       indirectl=
y when the format string is constructed earlier -->
+  <define name=3D"PRIx=
64" value=3D"&quot;lx&quot;" />
 </def>
diff --git a/dev-tools/run-cppcheck=
=2Esh b/dev-tools/run-cppcheck=2Esh
index 37de267=2E=2E4c4ba2c 100755
--- a=
/dev-tools/run-cppcheck=2Esh
+++ b/dev-tools/run-cppcheck=2Esh
@@ -30,7 +30=
,7 @@
  --enable=3Dall ${disable_arg} \
  --library=3D${SCRIPT_DIR}/openvpn=
-cppcheck-library=2Ecfg \
  --library=3Dopenssl=2Ecfg \
- --suppressions-li=
st=3D${SCRIPT_DIR}/cppcheck-suppression \
+ --suppress-xml=3D${SCRIPT_DIR}/=
cppcheck-suppressions=2Exml --inline-suppr \
  --cppcheck-build-dir=3D${CPP=
CHECK_DIR} \
  --check-level=3D${CPPCHECK_CHECK_LEVEL} --max-configs=3D10 \=

  --error-exitcode=3D1 --showtime=3Dsummary"
@@ -39,13 +39,14 @@
 
 mkdir =
-p "$CPPCHECK_DIR"
 cd "${SOURCE_DIR}"
+ret=3D0
 cppcheck $COMMON_ARGS $INC=
LUDE_FLAGS \
     --platform=3Dunix64 \
     --library=3Dposix=2Ecfg --libr=
ary=3Dbsd=2Ecfg --library=3Dgnu=2Ecfg \
     -U_WIN32 \
     src/openvpn/ s=
rc/compat/ src/plugins/ sample/ \
     tests/unit_tests/example_test/ tests=
/unit_tests/openvpn/ \
-    tests/unit_tests/plugins/
+    tests/unit_tests=
/plugins/ || ret=3D$?
 cppcheck $COMMON_ARGS \
     --platform=3Dwin64 \
  =
   --library=3Dwindows=2Ecfg \
@@ -55,4 +56,6 @@
     -UTARGET_AIX \
     -=
UOPENSSL_NO_EC \
     src/openvpn* src/compat/ \
-    tests/unit_tests/exam=
ple_test/ tests/unit_tests/openvpn*
+    tests/unit_tests/example_test/ tes=
ts/unit_tests/openvpn* || ret=3D$?
+
+exit $ret
diff --git a/src/openvpn/cr=
ypto=2Ec b/src/openvpn/crypto=2Ec
index e5ad31a=2E=2Edc22af5 100644
--- a/s=
rc/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -268,7 +268,7 @@
    =
         }
 
             /* Encrypt packet ID, payload */
-            int=
 outlen;
+            int outlen =3D 0;
             ASSERT(cipher_ctx_upda=
te(ctx->cipher, BEND(&work), &outlen, BPTR(buf), BLEN(buf)));
             =
ASSERT(buf_inc_len(&work, outlen));
 
@@ -566,7 +566,7 @@
     dmsg(D_PACKE=
T_CONTENT, "DECRYPT AD: %s", format_hex(ad_start, ad_size, 0, &gc));
 
    =
 /* Decrypt and authenticate packet */
-    int outlen;
+    int outlen =3D=
 0;
     if (!cipher_ctx_update(ctx->cipher, BPTR(&work), &outlen, BPTR(buf=
), data_len))
     {
         CRYPT_ERROR("packet decryption failed");
diff=
 --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 3e72b92=2E=2Eb=
e4007f 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -4=
239,6 +4239,7 @@
     struct multi_context multi;
 
     top->mode =3D CM_T=
OP;
+    // cppcheck-suppress autoVariables ; yes, we know this is dangerou=
s
     top->multi =3D &multi;
     context_clear_2(top);
 
diff --git a/src=
/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec
index 3604684=2E=2E5de2438=
 100644
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -3=
21,6 +321,7 @@
 {
     const unsigned int mpp_flags =3D MPP_PRE_SELECT | MP=
P_RECORD_TOUCH;
     struct multi_instance *touched =3D mi;
+    // cppchec=
k-suppress autoVariables ; yes, we know this is dangerous
     m->mpp_touch=
ed =3D &touched;
 
     dmsg(D_MULTI_DEBUG, "MULTI IO: multi_io_dispatch a=
=3D%s mi=3D" ptr_format, pract(action),
diff --git a/src/openvpn/ssl_verify=
=2Ec b/src/openvpn/ssl_verify=2Ec
index 3653eb4=2E=2E6631718 100644
--- a/s=
rc/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -925,6 +925,7=
 @@
 
             errno =3D 0;
             long timeout =3D strtol(BSTR(t=
imeout_buf), NULL, 10);
+            // cppcheck-suppress compareValueOutOf=
TypeRangeError ; ULONG_MAX=3D=3DUINT_MAX on Windows
             if (timeou=
t <=3D 0 || (unsigned long)timeout > UINT_MAX || errno)
             {
    =
             msg(M_WARN, "could not parse auth pending file timeout");
diff=
 --git a/src/openvpnserv/common=2Ec b/src/openvpnserv/common=2Ec
index 7fc8=
c14=2E=2Ecce5318 100644
--- a/src/openvpnserv/common=2Ec
+++ b/src/openvpns=
erv/common=2Ec
@@ -22,6 +22,7 @@
 
 #include "service=2Eh"
 #include "valid=
ate=2Eh"
+// cppcheck-suppress missingInclude ; we run cppcheck on Linux w/=
o this file
 #include "eventmsg=2Eh"
 
 #include <pathcch=2Eh>
diff --git a=
/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index 78=
19f5a=2E=2E4a38aa4 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/o=
penvpnserv/interactive=2Ec
@@ -3601,6 +3601,7 @@
         goto out;
     }
=
     swprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),
+             // cp=
pcheck-suppress unknownMacro ; FP, complains about _L only here=2E=2E=2E
  =
            L"\\\\=2E\\pipe\\" _L(PACKAGE) L"%ls\\service_%lu_%ls", service=
_instance,
              GetCurrentThreadId(), pipe_uuid_str);
     RpcStri=
ngFreeW(&pipe_uuid_str);
diff --git a/tests/unit_tests/openvpn/test_tls_cry=
pt=2Ec b/tests/unit_tests/openvpn/test_tls_crypt=2Ec
index f648e13=2E=2Ef8a=
a199 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt=2Ec
+++ b/tests/u=
nit_tests/openvpn/test_tls_crypt=2Ec
@@ -681,6 +681,7 @@
     struct buffer=
 tmp =3D create_client_key_input(ctx, 12);
 
     /* Make the wrapped key i=
nvalid by flipping a few bits */
+    // cppcheck-suppress syntaxError ; cp=
pcheck is confused by this code
     buf_bptr(&tmp)[buf_len(&tmp) - 20] ^=
=3D 0x55;
 
     assert_false(tls_crypt_v2_extract_client_key(&tmp, &wrap_c=
tx, NULL));

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
953?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newcha=
nge
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie06d35=
43d0a5d4ca3d3fd6f41498e6917ab4c8a9
Gerrit-Change-Number: 1953
Gerrit-PatchS=
et: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@r=
fc2549=2Eorg>

--KlDASNOY0Yk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1953?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">cppcheck: Clean up suppressions to not annoy developers<br><br>Actuall=
y using it in CI has shown that the line number<br>based suppression is jus=
t too annoying=2E Therefor:<br><br>- Switch to XML based suppressions that =
allow us to<br>  use symbolName in addition to lineNumber to limit the<br> =
 suppression=2E<br>- Suppress knownConditionTrueFalse always=2E There are j=
ust<br>  too many instances due to how our code is structured=2E<br>- Also =
remove some unused suppressions=2E<br>- Replace some suppressions with code=
 fixes=2E These are<br>  generally speaking false positives but the code fi=
x<br>  is less ugly than the suppression=2E<br>- Work around one issue with=
 using PRIx64 macro in a<br>  pre-prepared format string by adding a defini=
tion in<br>  our library definition=2E<br>- All suppressions that remain th=
at were still lineNumber<br>  based (due to the check not reporting a symbo=
l), move<br>  to inline suppressions=2E Inline suppressions are somewhat<br=
>  ugly, but these are very few and I see no better<br>  alternative=2E May=
be we can get rid of some of them by<br>  reporting issues to cppcheck=2E (=
Or, in some cases, by<br>  improving our code)=2E<br><br>While here, make s=
ure that we always run the Windows scan<br>as well, so developers get compl=
ete feedback on first push=2E<br><br>Change-Id: Ie06d3543d0a5d4ca3d3fd6f414=
98e6917ab4c8a9<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt;<br>---<br>D dev-tools/cppcheck-suppression<br>A dev-tools/cppcheck-=
suppressions=2Exml<br>M dev-tools/openvpn-cppcheck-library=2Ecfg<br>M dev-t=
ools/run-cppcheck=2Esh<br>M src/openvpn/crypto=2Ec<br>M src/openvpn/multi=
=2Ec<br>M src/openvpn/multi_io=2Ec<br>M src/openvpn/ssl_verify=2Ec<br>M src=
/openvpnserv/common=2Ec<br>M src/openvpnserv/interactive=2Ec<br>M tests/uni=
t_tests/openvpn/test_tls_crypt=2Ec<br>11 files changed, 226 insertions(+), =
124 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/53/1953/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/dev-tools/=
cppcheck-suppression b/dev-tools/cppcheck-suppression</span><br><span>delet=
ed file mode 100644</span><br><span>index 299d7a3=2E=2E0000000</span><br><s=
pan>--- a/dev-tools/cppcheck-suppression</span><br><span>+++ /dev/null</spa=
n><br><span>@@ -1,119 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-# We start with --enable=3Dall, but then suppress some issues that =
have too many</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# occure=
nces right now=2E They still should be fixed at some point</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-constParameter</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-constParameterCallback</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-constParameterPointer</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-invalidPrintfArgType_sint</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-invalidPrintfArgType_uint</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-unusedFunction</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-usleepCalled</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-variableScope</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-# We have a lot of library includes, not all of them are r=
eally required,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# so i=
gnore them</span><br><span style=3D"color: hsl(0, 100%, 40%);">-missingIncl=
udeSystem</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# cppcheck d=
oesn&#39;t understand about check_malloc_return, so these are</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-# usually misleading</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-nullPointerOutOfMemory</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-nullPointerArithmeticOutOfMemory</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-# These are specific fal=
se-positives (FP) or ignored (IGN) issues</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-# We might want to move some of them to inline-suppress=
ion to avoid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# the sta=
tic line-numbers</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# IGN=
: posix=2Ecfg: We are not threadsafe</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-getgrnamCalled</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-getpwnamCalled</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-getservbynameCalled</span><br><span style=3D"color: hsl(0, 100%, 40%);">-l=
ocaltimeCalled</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: p=
osix=2Ecfg claims suseconds_t is unsigned for some reason</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-unsignedLessThanZero:src/openvpn/otime=
=2Eh:148</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# IGN: multi =
code does weird things with pointers to local variables=2E=2E=2E</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-autoVariables:src/openvpn/multi=
=2Ec:4242</span><br><span style=3D"color: hsl(0, 100%, 40%);">-autoVariable=
s:src/openvpn/multi_io=2Ec:324</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-# IGN: the code header =3D 0 | (OPCODE &lt;&lt; P_OPCODE_SHIFT) is=
 used intentionally</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ba=
dBitmaskCheck:src/openvpn/mudp=2Ec</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-badBitmaskCheck:tests/unit_tests/openvpn/test_pkt=2Ec</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-# IGN: Windows specific (unsig=
ned long =3D=3D unsigned int)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-compareValueOutOfTypeRangeError:src/openvpn/ssl_verify=2Ec:928</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: cppcheck seems to ha=
ve wrong signature of DeviceIoControl()</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-constVariablePointer:src/openvpn/dco_win=2Ec</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-# IGN: test_networking code would =
break with iproute2 but that is prevented</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-ctunullpointer:src/openvpn/networking_iproute2=2Ec</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-# IGN: event code uses a p=
ointer to store integers</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-intToPointerCast:src/openvpn/forward=2Ec</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-intToPointerCast:src/openvpn/multi_io=2Ec</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-intToPointerCast:src/openvpn/ps=
=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: constant bu=
t differs between platforms</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-knownConditionTrueFalse:src/openvpn/error=2Eh:380</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-knownConditionTrueFalse:src/openvpn/fdmis=
c=2Ec:80</span><br><span style=3D"color: hsl(0, 100%, 40%);">-knownConditio=
nTrueFalse:src/openvpn/lladdr=2Ec:64</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-knownConditionTrueFalse:src/openvpn/platform=2Ec</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-# FP: code needs to accomodate ma=
ny different defines</span><br><span style=3D"color: hsl(0, 100%, 40%);">-k=
nownConditionTrueFalse:src/openvpn/event=2Ec:1139</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-knownConditionTrueFalse:src/openvpn/event=2Ec:1=
148</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: dco_win supp=
ort has &quot;false&quot; stubs</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-knownConditionTrueFalse:src/openvpn/forward=2Ec</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-knownConditionTrueFalse:src/openvpn/ini=
t=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-knownConditionTr=
ueFalse:src/openvpn/multi_io=2Ec:197</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-# FP: cppcheck thinks that some functions always return true=
, but they don&#39;t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-k=
nownConditionTrueFalse:src/openvpn/misc=2Ec:97</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-knownConditionTrueFalse:src/openvpn/sig=2Eh:116</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: cert_uri_supported=
 is a wrapper around defines, so it&#39;s</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-# always constant but differs depending on OpenSSL vers=
ion</span><br><span style=3D"color: hsl(0, 100%, 40%);">-knownConditionTrue=
False:src/openvpn/ssl_openssl=2Ec:1260</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-# FP: cppcheck doesn&#39;t understand that the function ch=
anges szErrMessage</span><br><span style=3D"color: hsl(0, 100%, 40%);">-kno=
wnConditionTrueFalse:src/tapctl/main=2Ec:704</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-knownConditionTrueFalse:src/openvpnmsica/dllmain=2Ec=
:164</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: cppcheck se=
ems to be confused since we cast the pointer to integer</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-memleak:src/plugins/down-root/down-root=
=2Ec:337</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# IGN: we jus=
t abort instead</span><br><span style=3D"color: hsl(0, 100%, 40%);">-memlea=
kOnRealloc:src/openvpn/dco_freebsd=2Ec:845</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-# FP: eventmsg=2Eh is not built on Unix</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-missingInclude:src/openvpnserv/commo=
n=2Ec:25</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# IGN: strlen=
(NULL) is not nice code, but seems to work</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-nullPointerRedundantCheck:src/openvpn/init=2Ec:301</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: cppcheck doesn&#39;=
t understand ZeroMemory</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-redundantAssignment:src/openvpnserv/interactive=2Ec:204</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-# IGN: We reuse the same variable name =
due to macro usage</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sha=
dowVariable:src/openvpn/options=2Ec:1948</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-shadowVariable:src/openvpn/options=2Ec:1966</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-# FP: fun:tls_crypt_v2_wrap_unwrap=
_invalid: cppcheck is confused</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-syntaxError:tests/unit_tests/openvpn/test_tls_crypt=2Ec:684</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: this file is never com=
piled on _WIN32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-umaskC=
alled:tests/unit_tests/openvpn/test_pkcs11=2Ec</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-# FP: yes, t_prev is unitialized, but t_prev_len i=
s 0, so that&#39;s handled</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-uninitvar:src/openvpn/crypto_epoch=2Ec:60</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-# FP: yes, parm is unitialized, but parm_len is 0,=
 so that&#39;s handled</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-uninitvar:src/openvpn/options_parse=2Ec:148</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-# FP: uninit is fine when it is a return parameter</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-ctuuninitvar:src/openvp=
n/crypto_mbedtls_legacy=2Ec:690</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-uninitvar:src/openvpnserv/interactive=2Ec:2783</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-uninitvar:src/tapctl/main=2Ec:566</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: weird parse error, the=
 macro is fine in the rest of the file</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-unknownMacro:src/openvpnserv/interactive=2Ec:3604</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-# FP: cppcheck doesn&#39;t acc=
ount for short-circuiting</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-unreadVariable:src/openvpn/manage=2Ec:682</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-unusedFunction:src/openvpn/siphash_reference=2Ec</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: exported as DLL</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-unusedFunction:src/openv=
pnmsica/*=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: lo=
aded as plugins</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unused=
Function:src/plugins/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-unusedFunction:sample/sample-plugins/*</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-# FP: wmain</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-unusedFunction:src/tapctl/main=2Ec:613</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-unusedFunction:tests/unit_tests/openvpnserv/test_o=
penvpnserv=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# IGN: =
keep mocking around for future use</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-unusedFunction:tests/unit_tests/openvpn/mock_msg=2Ec</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-unusedFunction:/usr/include/*</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: cppcheck doesn&#3=
9;t know the NLA macros</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-unusedLabel:src/openvpn/dco_linux=2Ec</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-# IGN: old code that is difficult to test (MSG_ERRQUEUE),=
 ignore for now</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unused=
StructMember:src/openvpn/mtu=2Ec:289</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-# FP: used implictly by NL macros</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-unusedStructMember:src/openvpn/networking_sitnl=
=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# IGN: keep expla=
natory fields in test data</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-unusedStructMember:tests/unit_tests/openvpn/test_pkcs11=2Ec</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-# IGN: nicer to assign generic &=
quot;arg&quot; early</span><br><span style=3D"color: hsl(0, 100%, 40%);">-v=
ariableScope:src/openvpn/networking_sitnl=2Ec:1390</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-# IGN: nicer to keep the &quot;variable&quot; =
earlier</span><br><span style=3D"color: hsl(0, 100%, 40%);">-variableScope:=
src/openvpnserv/interactive=2Ec:2687</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-# FP: fun:platform_create_temp_file: cppcheck is confused</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-wrongPrintfScanfArgNum:s=
rc/openvpn/platform=2Ec:553</span><br><span>diff --git a/dev-tools/cppcheck=
-suppressions=2Exml b/dev-tools/cppcheck-suppressions=2Exml</span><br><span=
>new file mode 100644</span><br><span>index 0000000=2E=2E73dd41b</span><br>=
<span>--- /dev/null</span><br><span>+++ b/dev-tools/cppcheck-suppressions=
=2Exml</span><br><span>@@ -0,0 +1,209 @@</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+&lt;?xml version=3D&quot;1=2E0&quot;?&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+&lt;suppressions&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- We start with enable=
=3Dall, but then suppress some issues that have too many</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+       occurences right now=2E They st=
ill should be fixed at some point --&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    &lt;id&gt;constParameter&lt;/id&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;constParameterCallback=
&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/s=
uppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;su=
ppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;i=
d&gt;constParameterPointer&lt;/id&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    &lt;id&gt;invalidPrintfArgType_sint&lt;/id&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;invalidPrintfA=
rgType_uint&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    &lt;id&gt;unusedFunction&lt;/id&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    &lt;id&gt;usleepCalled&lt;/id&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;variableScope&lt;/id&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- We have =
a lot of library includes, not all of them are really required,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+       so ignore them --&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;missingIn=
cludeSystem&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  &lt;!-- cppcheck doesn&#39;t understand about check_malloc_return, so =
these are</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       usu=
ally misleading --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    &lt;id&gt;nullPointerOutOfMemory&lt;/id&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    &lt;id&gt;nullPointerArithmeticOutOfMemory=
&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/s=
uppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-=
- These are specific false-positives (FP) or ignored (IGN) issues</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+       We might want to move =
some of them to inline-suppression to avoid</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+       the static line-numbers --&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: posix=2Ecfg: We ar=
e not threadsafe --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    &lt;id&gt;getgrnamCalled&lt;/id&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &lt;id&gt;getpwnamCalled&lt;/id&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;getservbynameCalled&=
lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/su=
ppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;sup=
press&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id=
&gt;localtimeCalled&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  &lt;!-- IGN: too many false-positives due to platform-specific=
 code --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;s=
uppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;=
id&gt;knownConditionTrueFalse&lt;/id&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  &lt;!-- FP: posix=2Ecfg claims suseconds_t is unsign=
ed for some reason --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    &lt;id&gt;unsignedLessThanZero&lt;/id&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/otime=2Eh&lt=
;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &=
lt;symbolName&gt;usec&lt;/symbolName&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  &lt;!-- IGN: the code header =3D 0 | (OPCODE &lt;&lt=
; P_OPCODE_SHIFT) is used intentionally --&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    &lt;id&gt;badBitmaskCheck&lt;/id&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/open=
vpn/mudp=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    &lt;id&gt;badBitmaskCheck&lt;/id&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;tests/unit_tests/openvpn/=
test_pkt=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  &lt;!-- FP: cppcheck seems to have wrong signature of DeviceIoC=
ontrol() --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &l=
t;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &=
lt;id&gt;constVariablePointer&lt;/id&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/dco_win=2Ec&lt;/fileNa=
me&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbo=
lName&gt;buf&lt;/symbolName&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  &lt;!-- IGN: test_networking code would break with iproute2 b=
ut that is prevented --&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    &lt;id&gt;ctunullpointer&lt;/id&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/networking_iprou=
te2=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  &lt;!-- IGN: event code uses a pointer to store integers --&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;intToPointe=
rCast&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 &lt;fileName&gt;src/openvpn/forward=2Ec&lt;/fileName&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;intToPointerCast&lt;/id&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName=
&gt;src/openvpn/multi_io=2Ec&lt;/fileName&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &lt;id&gt;intToPointerCast&lt;/id&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/open=
vpn/ps=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  &lt;!-- FP: cppcheck seems to be confused since we cast the point=
er to integer --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    &lt;id&gt;memleak&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    &lt;fileName&gt;src/plugins/down-root/down-root=2Ec&lt;/fi=
leName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;s=
ymbolName&gt;context=2Ecommand&lt;/symbolName&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: we just abort instead --&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;memleakO=
nRealloc&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    &lt;fileName&gt;src/openvpn/dco_freebsd=2Ec&lt;/fileName&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;buf&lt;/=
symbolName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt=
;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt=
;!-- IGN: strlen(NULL) is not nice code, but seems to work --&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;nullPointerRedun=
dantCheck&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &lt;fileName&gt;src/openvpn/init=2Ec&lt;/fileName&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;parameters&lt;=
/symbolName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &l=
t;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &l=
t;!-- FP: cppcheck doesn&#39;t understand ZeroMemory --&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;redundantAssignment&lt=
;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fil=
eName&gt;src/openvpnserv/interactive=2Ec&lt;/fileName&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;overlapped-&amp=
;gt;hEvent&lt;/symbolName&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  &lt;!-- IGN: We reuse the same variable name due to macro usage=
 --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppre=
ss&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt=
;shadowVariable&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    &lt;fileName&gt;src/openvpn/options=2Ec&lt;/fileName&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;use_e=
rr&lt;/symbolName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  &lt;!-- FP: this file is never compiled on _WIN32 --&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;umaskCalled&lt;/id&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&g=
t;tests/unit_tests/openvpn/test_pkcs11=2Ec&lt;/fileName&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: yes, t_prev is unitia=
lized, but t_prev_len is 0, so that&#39;s handled --&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;uninitvar&lt;/id&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/=
openvpn/crypto_epoch=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &lt;symbolName&gt;t_prev&lt;/symbolName&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: yes, parm i=
s unitialized, but parm_len is 0, so that&#39;s handled --&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;uninitvar&lt;/id&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&g=
t;src/openvpn/options_parse=2Ec&lt;/fileName&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;parm&lt;/symbolName&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: uninit=
 is fine when it is a return parameter --&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &lt;id&gt;uninitvar&lt;/id&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpnserv=
/interactive=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    &lt;symbolName&gt;addr_list&lt;/symbolName&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;uninitvar&lt;/id&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName=
&gt;src/tapctl/main=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    &lt;symbolName&gt;guidAdapter&lt;/symbolName&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: cppchec=
k doesn&#39;t account for short-circuiting --&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    &lt;id&gt;unreadVariable&lt;/id&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/op=
envpn/manage=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    &lt;symbolName&gt;n&lt;/symbolName&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: exported as DLL --&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;unusedFu=
nction&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &lt;fileName&gt;src/openvpnmsica/*=2Ec&lt;/fileName&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: loaded as plugins --&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;unuse=
dFunction&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &lt;fileName&gt;src/plugins/*&lt;/fileName&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;unusedFunction&lt;/id&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;s=
ample/sample-plugins/*&lt;/fileName&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  &lt;!-- IGN: keep mocking around for future use --&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;unuse=
dFunction&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &lt;fileName&gt;tests/unit_tests/openvpn/mock_msg=2Ec&lt;/fileName&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;unused=
Function&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    &lt;fileName&gt;/usr/include/*&lt;/fileName&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: cppcheck doesn&#39;t know t=
he NLA macros --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    &lt;id&gt;unusedLabel&lt;/id&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/dco_linux=2Ec&lt;/fileName=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: =
old code that is difficult to test (MSG_ERRQUEUE), ignore for now --&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;unusedStr=
uctMember&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &lt;fileName&gt;src/openvpn/mtu=2Ec&lt;/fileName&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;probehdr::ttl&l=
t;/symbolName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
&lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
&lt;!-- FP: used implictly by NL macros --&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    &lt;id&gt;unusedStructMember&lt;/id&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/o=
penvpn/networking_sitnl=2Ec&lt;/fileName&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  &lt;!-- IGN: keep explanatory fields in test dat=
a --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppr=
ess&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&g=
t;unusedStructMember&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    &lt;fileName&gt;tests/unit_tests/openvpn/test_pkcs11=2Ec&lt=
;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt=
;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+&lt;/=
suppressions&gt;</span><br><span>diff --git a/dev-tools/openvpn-cppcheck-li=
brary=2Ecfg b/dev-tools/openvpn-cppcheck-library=2Ecfg</span><br><span>inde=
x 1ea91f4=2E=2Eb2c0973 100644</span><br><span>--- a/dev-tools/openvpn-cppch=
eck-library=2Ecfg</span><br><span>+++ b/dev-tools/openvpn-cppcheck-library=
=2Ecfg</span><br><span>@@ -26,4 +26,7 @@</span><br><span>   &lt;!-- work ar=
ound macro confusion --&gt;</span><br><span>   &lt;define name=3D&quot;CMSG=
_FIRSTHDR&quot; value=3D&quot;cmsg_firsthdr&quot; /&gt;</span><br><span>   =
&lt;define name=3D&quot;CMSG_NXTHDR&quot; value=3D&quot;cmsg_nxthdr&quot; /=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- cppch=
eck understands it directly in format string, but not</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+       indirectly when the format string =
is constructed earlier --&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  &lt;define name=3D&quot;PRIx64&quot; value=3D&quot;&amp;quot;lx=
&amp;quot;&quot; /&gt;</span><br><span> &lt;/def&gt;</span><br><span>diff -=
-git a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh</span><br>=
<span>index 37de267=2E=2E4c4ba2c 100755</span><br><span>--- a/dev-tools/run=
-cppcheck=2Esh</span><br><span>+++ b/dev-tools/run-cppcheck=2Esh</span><br>=
<span>@@ -30,7 +30,7 @@</span><br><span>  --enable=3Dall ${disable_arg} \</=
span><br><span>  --library=3D${SCRIPT_DIR}/openvpn-cppcheck-library=2Ecfg \=
</span><br><span>  --library=3Dopenssl=2Ecfg \</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- --suppressions-list=3D${SCRIPT_DIR}/cppcheck-supp=
ression \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ --suppres=
s-xml=3D${SCRIPT_DIR}/cppcheck-suppressions=2Exml --inline-suppr \</span><b=
r><span>  --cppcheck-build-dir=3D${CPPCHECK_DIR} \</span><br><span>  --chec=
k-level=3D${CPPCHECK_CHECK_LEVEL} --max-configs=3D10 \</span><br><span>  --=
error-exitcode=3D1 --showtime=3Dsummary&quot;</span><br><span>@@ -39,13 +39=
,14 @@</span><br><span> </span><br><span> mkdir -p &quot;$CPPCHECK_DIR&quot=
;</span><br><span> cd &quot;${SOURCE_DIR}&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ret=3D0</span><br><span> cppcheck $COMMON_ARGS =
$INCLUDE_FLAGS \</span><br><span>     --platform=3Dunix64 \</span><br><span=
>     --library=3Dposix=2Ecfg --library=3Dbsd=2Ecfg --library=3Dgnu=2Ecfg \=
</span><br><span>     -U_WIN32 \</span><br><span>     src/openvpn/ src/comp=
at/ src/plugins/ sample/ \</span><br><span>     tests/unit_tests/example_te=
st/ tests/unit_tests/openvpn/ \</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    tests/unit_tests/plugins/</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    tests/unit_tests/plugins/ || ret=3D$?</span><br><sp=
an> cppcheck $COMMON_ARGS \</span><br><span>     --platform=3Dwin64 \</span=
><br><span>     --library=3Dwindows=2Ecfg \</span><br><span>@@ -55,4 +56,6 =
@@</span><br><span>     -UTARGET_AIX \</span><br><span>     -UOPENSSL_NO_EC=
 \</span><br><span>     src/openvpn* src/compat/ \</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    tests/unit_tests/example_test/ tests/unit_=
tests/openvpn*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    t=
ests/unit_tests/example_test/ tests/unit_tests/openvpn* || ret=3D$?</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+exit $ret</span><br><span>diff --git a/src/ope=
nvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index e5ad31a=2E=
=2Edc22af5 100644</span><br><span>--- a/src/openvpn/crypto=2Ec</span><br><s=
pan>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -268,7 +268,7 @@</span>=
<br><span>             }</span><br><span> </span><br><span>             /* =
Encrypt packet ID, payload */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            int outlen;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            int outlen =3D 0;</span><br><span>             ASSE=
RT(cipher_ctx_update(ctx-&gt;cipher, BEND(&amp;work), &amp;outlen, BPTR(buf=
), BLEN(buf)));</span><br><span>             ASSERT(buf_inc_len(&amp;work, =
outlen));</span><br><span> </span><br><span>@@ -566,7 +566,7 @@</span><br><=
span>     dmsg(D_PACKET_CONTENT, &quot;DECRYPT AD: %s&quot;, format_hex(ad_=
start, ad_size, 0, &amp;gc));</span><br><span> </span><br><span>     /* Dec=
rypt and authenticate packet */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    int outlen;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    int outlen =3D 0;</span><br><span>     if (!cipher_ctx_update(ctx=
-&gt;cipher, BPTR(&amp;work), &amp;outlen, BPTR(buf), data_len))</span><br>=
<span>     {</span><br><span>         CRYPT_ERROR(&quot;packet decryption f=
ailed&quot;);</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/open=
vpn/multi=2Ec</span><br><span>index 3e72b92=2E=2Ebe4007f 100644</span><br><=
span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2E=
c</span><br><span>@@ -4239,6 +4239,7 @@</span><br><span>     struct multi_c=
ontext multi;</span><br><span> </span><br><span>     top-&gt;mode =3D CM_TO=
P;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    // cppcheck-s=
uppress autoVariables ; yes, we know this is dangerous</span><br><span>    =
 top-&gt;multi =3D &amp;multi;</span><br><span>     context_clear_2(top);</=
span><br><span> </span><br><span>diff --git a/src/openvpn/multi_io=2Ec b/sr=
c/openvpn/multi_io=2Ec</span><br><span>index 3604684=2E=2E5de2438 100644</s=
pan><br><span>--- a/src/openvpn/multi_io=2Ec</span><br><span>+++ b/src/open=
vpn/multi_io=2Ec</span><br><span>@@ -321,6 +321,7 @@</span><br><span> {</sp=
an><br><span>     const unsigned int mpp_flags =3D MPP_PRE_SELECT | MPP_REC=
ORD_TOUCH;</span><br><span>     struct multi_instance *touched =3D mi;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    // cppcheck-suppress=
 autoVariables ; yes, we know this is dangerous</span><br><span>     m-&gt;=
mpp_touched =3D &amp;touched;</span><br><span> </span><br><span>     dmsg(D=
_MULTI_DEBUG, &quot;MULTI IO: multi_io_dispatch a=3D%s mi=3D&quot; ptr_form=
at, pract(action),</span><br><span>diff --git a/src/openvpn/ssl_verify=2Ec =
b/src/openvpn/ssl_verify=2Ec</span><br><span>index 3653eb4=2E=2E6631718 100=
644</span><br><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/=
src/openvpn/ssl_verify=2Ec</span><br><span>@@ -925,6 +925,7 @@</span><br><s=
pan> </span><br><span>             errno =3D 0;</span><br><span>           =
  long timeout =3D strtol(BSTR(timeout_buf), NULL, 10);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            // cppcheck-suppress compar=
eValueOutOfTypeRangeError ; ULONG_MAX=3D=3DUINT_MAX on Windows</span><br><s=
pan>             if (timeout &lt;=3D 0 || (unsigned long)timeout &gt; UINT_=
MAX || errno)</span><br><span>             {</span><br><span>              =
   msg(M_WARN, &quot;could not parse auth pending file timeout&quot;);</spa=
n><br><span>diff --git a/src/openvpnserv/common=2Ec b/src/openvpnserv/commo=
n=2Ec</span><br><span>index 7fc8c14=2E=2Ecce5318 100644</span><br><span>---=
 a/src/openvpnserv/common=2Ec</span><br><span>+++ b/src/openvpnserv/common=
=2Ec</span><br><span>@@ -22,6 +22,7 @@</span><br><span> </span><br><span> #=
include &quot;service=2Eh&quot;</span><br><span> #include &quot;validate=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+// cppcheck-=
suppress missingInclude ; we run cppcheck on Linux w/o this file</span><br>=
<span> #include &quot;eventmsg=2Eh&quot;</span><br><span> </span><br><span>=
 #include &lt;pathcch=2Eh&gt;</span><br><span>diff --git a/src/openvpnserv/=
interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index 781=
9f5a=2E=2E4a38aa4 100644</span><br><span>--- a/src/openvpnserv/interactive=
=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>=
@@ -3601,6 +3601,7 @@</span><br><span>         goto out;</span><br><span>  =
   }</span><br><span>     swprintf(ovpn_pipe_name, _countof(ovpn_pipe_name)=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             // cp=
pcheck-suppress unknownMacro ; FP, complains about _L only here=2E=2E=2E</s=
pan><br><span>              L&quot;\\\\=2E\\pipe\\&quot; _L(PACKAGE) L&quot=
;%ls\\service_%lu_%ls&quot;, service_instance,</span><br><span>            =
  GetCurrentThreadId(), pipe_uuid_str);</span><br><span>     RpcStringFreeW=
(&amp;pipe_uuid_str);</span><br><span>diff --git a/tests/unit_tests/openvpn=
/test_tls_crypt=2Ec b/tests/unit_tests/openvpn/test_tls_crypt=2Ec</span><br=
><span>index f648e13=2E=2Ef8aa199 100644</span><br><span>--- a/tests/unit_t=
ests/openvpn/test_tls_crypt=2Ec</span><br><span>+++ b/tests/unit_tests/open=
vpn/test_tls_crypt=2Ec</span><br><span>@@ -681,6 +681,7 @@</span><br><span>=
     struct buffer tmp =3D create_client_key_input(ctx, 12);</span><br><spa=
n> </span><br><span>     /* Make the wrapped key invalid by flipping a few =
bits */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    // cppch=
eck-suppress syntaxError ; cppcheck is confused by this code</span><br><spa=
n>     buf_bptr(&amp;tmp)[buf_len(&amp;tmp) - 20] ^=3D 0x55;</span><br><spa=
n> </span><br><span>     assert_false(tls_crypt_v2_extract_client_key(&amp;=
tmp, &amp;wrap_ctx, NULL));</span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1953?usp=3Demail">change 1953</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1953?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie06d35=
43d0a5d4ca3d3fd6f41498e6917ab4c8a9 </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 1953 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--KlDASNOY0Yk=--


--===============4151245320545036118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4151245320545036118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4151245320545036118==--

