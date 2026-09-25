Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C949C98328
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZAKfXERl7pu7LTsbexukHXyOphyeHhynyOgvDt8MObs=; b=C9Y2KTGtqE716LAifA1Jmri3jt
	C5Z2yrvdJkAxAf1NCR8XD4xCEp9FFo+asPlsEwTcGiNWKVXqzs9dCV2OQjZ4PFcOLvF3HU3idmep3
	KOid1p4+G0Kz/y9PTtClI7UCpKIRg/oEAmdp/XT//vIYveogE580J1mS0+V7evclMzt0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA8WJ-0001dq-AR;
	Fri, 25 Sep 2026 16:11:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA8W0-0001dX-W5
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 16:11:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=M8Zz/lGqJYNjfeW3YhNq+pTdrhD20Eqn43K0doSvfFU=; b=GD4/ihBu2X5zYfMuYRvsGTqMxa
 +2apSOuSbkAc8Q5jpIWBUVdWsyyDtjgGAzCaKKWs6FNdVOBnrL2IJHECIIvz3knxgyO0u4jpjBypc
 4LS3Vh6FhtEYvV2jiOilxu1YkkM95xbNMu04bQGSxyOunhdLAwgszg2E7WYxttJLYIEk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=M8Zz/lGqJYNjfeW3YhNq+pTdrhD20Eqn43K0doSvfFU=; b=d
 2Brm3jqlLNm7ovPYbwtNBI0OvKpyrykFEnmQUX/bJo3Du6UPWN2WgOrgZZqs3HlcCQi1Ury116ZWp
 Pia8MErIJolv9SdvqgemOCwVqCb+4aKAeP5lv9HIMQMyHGxyI/HrvTSUjW9Nuq9qoZfh4J8J3s89I
 pZXNMbGvmTUvoj8I=;
Received: from mail-wr2-f34.google.com ([74.125.225.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA8Vy-0001De-1y for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 16:11:12 +0000
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48884b926f0so41514f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 09:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790352663; x=1790957463; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=M8Zz/lGqJYNjfeW3YhNq+pTdrhD20Eqn43K0doSvfFU=;
 b=WBc+5qiEJYKsTeeU/QsEqicH1DmH9EJRAgQLyrcvneirbLhu4Y2l300VNuCMfJVF5I
 J29JGNvFiLy+l5aZJcZ6RczFiCKNpedSHO6s6m5gw0yUs7zFjQOUIUglwpnamfd7B1BE
 ls9bLFPa0sdH+W8jnw8uqhaKX3U6w0dRBZgDsTBSa9v56Duo6RRuMJ291pXGuuTso+OB
 j2Hu/ULx2dt7CpOZXe29L8vQ94jzvPEeE8h/CwTciRV/PaHSNhZK89ipyjvQteQdL4q0
 tvcI70thZQDKUgnwPQnEGJ7rI9DNVgSCp3cygd9Wxrgt4Bn66qbsnIhEbgvYyZsmi5Ed
 +KKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790352663; x=1790957463;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=M8Zz/lGqJYNjfeW3YhNq+pTdrhD20Eqn43K0doSvfFU=;
 b=z6JCEELY12b/WhrL/3DwccC9fj19cQS3r9HSpybx3qkblST0bgZ8BvpmkvpJCjrVQG
 Az8x1/nTjjl64EntPYsAcXqjBB8reQwidc+uT+czb3L8Ye88UoA/wbQxx3y8L2sfyKjg
 0Von+ivQBC7PGEkzDKia3MVaPI1ue9RpfMT75veLHGXCApZ+QmNGeF1JAVzPiE2KXO3Z
 zD2SInpey7rqTzLKDl8vFHNd4Z7Xx+W26MvOvSQ4267vBmXQsYG0pmHzDdYeepgW2MxR
 yfTOaEFY0RyhpNe94pJ3gI4NVJtYSyulK6ibTFwwnsQAs45LOuT9i1UpqEsvBn7CuXXT
 igpA==
X-Gm-Message-State: AFuF++nRqJD6GRaPWpUjxQ8+W9YXh1UMBy3B3nCoB92txZQDiHYGs+md
 iVkUzEmxrsl5POZP7rtcT2dcdkEj3we90esY1DiMSJscekkeFNtlbgCIEibUbDnc21/90T5NMvU
 0PnX177Bhg+ooghJDu1+prdOJXNdfjTA+rI4dRV83pBinfsKD/UNFiySZH/Jo9UN8QWQK
X-Gm-Gg: AYBFou1s/Z4lzVy6rjGVnXDrZj+eiHUuQt9agSx4Bdk2Sc9zjvl+2RQ7y5fHQKAijKW
 9qRlK4lKhSHF2JxNQf06OewU1CBfrjL7B5U/Q2UDd0gxyGab8VzG4BqdHzXSh4FiQ0wGlY3L/pS
 rMmuKspvQXWqXSEA59k0hbENZAuJhirL7DHAGudck3TElGbz5Qk3U4RnbhWPSscCPPQUzyXg+/X
 x9w8HOmBx0nhAFB/UVuuiTEMpQsuDwgkmIPV1njpPQIOiWE05D8Mbt1D20fYEGdfPCtA5YUp8C9
 f4fvyEUFsEJaEw9M6RqMbyS03mLi3WQ2mrVx//YUVoFuTYKC+7aeywFuFcUMksR69EeUjduqKoQ
 5ulFcOhmwB22INNtuxR3orML7ZTt0vRn1cn/mugyRBo1OORm6O4JFidKkwvS1JhnMgz/iIuCMqg
 vy3f+Q1J1bRruPSyA+MYE5oF8S7yxLr2+zk3HhKrobWLHe4utk9PYNL9XQltKW16pPd1J+XoY9L
 zFnW9sk36aaGoGT7P9TI7yhswHHIam5hFW5ZKbaUK0xzp7mJvs+QIRx1EWAvnUhhy3Dw7IImyKF
 8Y7cptQvkyiGYAAly4D/f3pf8IUfuCDRltcfjTzigtDD9SFeGdFQ28MQu+UDIQ==
X-Received: by 2002:a05:6000:41ee:b0:487:9a8:9f31 with SMTP id
 ffacd0b85a97d-4887177a9a5mr11781565f8f.41.1790352663091; 
 Fri, 25 Sep 2026 09:11:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a30bcdbsm8286798f8f.2.2026.09.25.09.11.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 09:11:02 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 16:10:58 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ie06d3543d0a5d4ca3d3fd6f41498e6917ab4c8a9
X-Gerrit-Change-Number: 1953
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1953?usp=email>
X-Gerrit-Commit: 3262f93a6a2b812f996b2686ad87b5d993cbfb1b
In-Reply-To: <gerrit.1790352577000.Ie06d3543d0a5d4ca3d3fd6f41498e6917ab4c8a9@gerrit.openvpn.net>
References: <gerrit.1790352577000.Ie06d3543d0a5d4ca3d3fd6f41498e6917ab4c8a9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzUyNTc3MDAwLkllMDZkMzU0M2QwYTVkNGNhM2QzZmQ2ZjQxNDk4ZTY5MTdhYjRjOGE5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a85d9aaea9827d5f3bdbab60fb68febd638259bb-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA8Vy-0001De-1y
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
Content-Type: multipart/mixed; boundary="===============2679197380129833189=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2679197380129833189==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4DZtzl31OsA="; charset=UTF-8

--4DZtzl31OsA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1953?usp=3Demail

to look at the new patch set (#2)=2E

=

Change subject: cppcheck: Clean up suppressions to not annoy developers
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

cppcheck: Cle=
an up suppressions to not annoy developers

Actually using it in CI has sho=
wn that the line number
based suppression is just too annoying=2E Therefor:=


- Switch to XML based suppressions that allow us to
  use symbolName in a=
ddition to lineNumber to limit the
  suppression=2E
- Suppress knownConditi=
onTrueFalse always=2E There are just
  too many instances due to how our co=
de is structured=2E
- Also remove some unused suppressions=2E
- Replace som=
e suppressions with code fixes=2E These are
  generally speaking false posi=
tives but the code fix
  is less ugly than the suppression=2E
- Work around=
 one issue with using PRIx64 macro in a
  pre-prepared format string by add=
ing a definition in
  our library definition=2E
- All suppressions that rem=
ain that were still lineNumber
  based (due to the check not reporting a sy=
mbol), move
  to inline suppressions=2E Inline suppressions are somewhat
  =
ugly, but these are very few and I see no better
  alternative=2E Maybe we =
can get rid of some of them by
  reporting issues to cppcheck=2E (Or, in so=
me cases, by
  improving our code)=2E

While here, make sure that we always=
 run the Windows scan
as well, so developers get complete feedback on first=
 push=2E

Change-Id: Ie06d3543d0a5d4ca3d3fd6f41498e6917ab4c8a9
Signed-off-b=
y: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
D dev-tools/cppcheck-sup=
pression
A dev-tools/cppcheck-suppressions=2Exml
M dev-tools/openvpn-cppche=
ck-library=2Ecfg
M dev-tools/run-cppcheck=2Esh
M src/openvpn/crypto=2Ec
M s=
rc/openvpn/multi=2Ec
M src/openvpn/multi_io=2Ec
M src/openvpn/ssl_verify=2E=
c
M src/openvpnserv/common=2Ec
M src/openvpnserv/interactive=2Ec
M tests/un=
it_tests/openvpn/test_tls_crypt=2Ec
11 files changed, 226 insertions(+), 12=
4 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/53/1953/2

diff --git a/dev-tools/cppcheck-suppression b/dev-tools=
/cppcheck-suppression
deleted file mode 100644
index 27c9d30=2E=2E0000000
-=
-- a/dev-tools/cppcheck-suppression
+++ /dev/null
@@ -1,119 +0,0 @@
-# We s=
tart with --enable=3Dall, but then suppress some issues that have too many
=
-# occurences right now=2E They still should be fixed at some point
-constP=
arameter
-constParameterCallback
-constParameterPointer
-invalidPrintfArgTy=
pe_sint
-invalidPrintfArgType_uint
-unusedFunction
-usleepCalled
-variableS=
cope
-# We have a lot of library includes, not all of them are really requi=
red,
-# so ignore them
-missingIncludeSystem
-# cppcheck doesn't understand=
 about check_malloc_return, so these are
-# usually misleading
-nullPointer=
OutOfMemory
-nullPointerArithmeticOutOfMemory
-# These are specific false-p=
ositives (FP) or ignored (IGN) issues
-# We might want to move some of them=
 to inline-suppression to avoid
-# the static line-numbers
-# IGN: posix=2E=
cfg: We are not threadsafe
-getgrnamCalled
-getpwnamCalled
-getservbynameCa=
lled
-localtimeCalled
-# FP: posix=2Ecfg claims suseconds_t is unsigned for=
 some reason
-unsignedLessThanZero:src/openvpn/otime=2Eh:148
-# IGN: multi =
code does weird things with pointers to local variables=2E=2E=2E
-autoVaria=
bles:src/openvpn/multi=2Ec:4242
-autoVariables:src/openvpn/multi_io=2Ec:324=

-# IGN: the code header =3D 0 | (OPCODE << P_OPCODE_SHIFT) is used intenti=
onally
-badBitmaskCheck:src/openvpn/mudp=2Ec
-badBitmaskCheck:tests/unit_te=
sts/openvpn/test_pkt=2Ec
-# IGN: Windows specific (unsigned long =3D=3D uns=
igned int)
-compareValueOutOfTypeRangeError:src/openvpn/ssl_verify=2Ec:928
=
-# FP: cppcheck seems to have wrong signature of DeviceIoControl()
-constVa=
riablePointer:src/openvpn/dco_win=2Ec
-# IGN: test_networking code would br=
eak with iproute2 but that is prevented
-ctunullpointer:src/openvpn/network=
ing_iproute2=2Ec
-# IGN: event code uses a pointer to store integers
-intTo=
PointerCast:src/openvpn/forward=2Ec
-intToPointerCast:src/openvpn/multi_io=
=2Ec
-intToPointerCast:src/openvpn/ps=2Ec
-# FP: constant but differs betwe=
en platforms
-knownConditionTrueFalse:src/openvpn/error=2Eh:382
-knownCondi=
tionTrueFalse:src/openvpn/fdmisc=2Ec:80
-knownConditionTrueFalse:src/openvp=
n/lladdr=2Ec:64
-knownConditionTrueFalse:src/openvpn/platform=2Ec
-# FP: co=
de needs to accomodate many different defines
-knownConditionTrueFalse:src/=
openvpn/event=2Ec:1139
-knownConditionTrueFalse:src/openvpn/event=2Ec:1148
=
-# FP: dco_win support has "false" stubs
-knownConditionTrueFalse:src/openv=
pn/forward=2Ec
-knownConditionTrueFalse:src/openvpn/init=2Ec
-knownConditio=
nTrueFalse:src/openvpn/multi_io=2Ec:197
-# FP: cppcheck thinks that some fu=
nctions always return true, but they don't
-knownConditionTrueFalse:src/ope=
nvpn/misc=2Ec:97
-knownConditionTrueFalse:src/openvpn/sig=2Eh:116
-# FP: ce=
rt_uri_supported is a wrapper around defines, so it's
-# always constant bu=
t differs depending on OpenSSL version
-knownConditionTrueFalse:src/openvpn=
/ssl_openssl=2Ec:1260
-# FP: cppcheck doesn't understand that the function =
changes szErrMessage
-knownConditionTrueFalse:src/tapctl/main=2Ec:704
-know=
nConditionTrueFalse:src/openvpnmsica/dllmain=2Ec:164
-# FP: cppcheck seems =
to be confused since we cast the pointer to integer
-memleak:src/plugins/do=
wn-root/down-root=2Ec:337
-# IGN: we just abort instead
-memleakOnRealloc:s=
rc/openvpn/dco_freebsd=2Ec:845
-# FP: eventmsg=2Eh is not built on Unix
-mi=
ssingInclude:src/openvpnserv/common=2Ec:25
-# IGN: strlen(NULL) is not nice=
 code, but seems to work
-nullPointerRedundantCheck:src/openvpn/init=2Ec:30=
1
-# FP: cppcheck doesn't understand ZeroMemory
-redundantAssignment:src/op=
envpnserv/interactive=2Ec:204
-# IGN: We reuse the same variable name due t=
o macro usage
-shadowVariable:src/openvpn/options=2Ec:1955
-shadowVariable:=
src/openvpn/options=2Ec:1973
-# FP: fun:tls_crypt_v2_wrap_unwrap_invalid: c=
ppcheck is confused
-syntaxError:tests/unit_tests/openvpn/test_tls_crypt=2E=
c:684
-# FP: this file is never compiled on _WIN32
-umaskCalled:tests/unit_=
tests/openvpn/test_pkcs11=2Ec
-# FP: yes, t_prev is unitialized, but t_prev=
_len is 0, so that's handled
-uninitvar:src/openvpn/crypto_epoch=2Ec:60
-# =
FP: yes, parm is unitialized, but parm_len is 0, so that's handled
-uninitv=
ar:src/openvpn/options_parse=2Ec:148
-# FP: uninit is fine when it is a ret=
urn parameter
-ctuuninitvar:src/openvpn/crypto_mbedtls_legacy=2Ec:690
-unin=
itvar:src/openvpnserv/interactive=2Ec:2783
-uninitvar:src/tapctl/main=2Ec:5=
66
-# FP: weird parse error, the macro is fine in the rest of the file
-unk=
nownMacro:src/openvpnserv/interactive=2Ec:3604
-# FP: cppcheck doesn't acco=
unt for short-circuiting
-unreadVariable:src/openvpn/manage=2Ec:682
-unused=
Function:src/openvpn/siphash_reference=2Ec
-# FP: exported as DLL
-unusedFu=
nction:src/openvpnmsica/*=2Ec
-# FP: loaded as plugins
-unusedFunction:src/=
plugins/*
-unusedFunction:sample/sample-plugins/*
-# FP: wmain
-unusedFunct=
ion:src/tapctl/main=2Ec:613
-unusedFunction:tests/unit_tests/openvpnserv/te=
st_openvpnserv=2Ec
-# IGN: keep mocking around for future use
-unusedFuncti=
on:tests/unit_tests/openvpn/mock_msg=2Ec
-unusedFunction:/usr/include/*
-# =
FP: cppcheck doesn't know the NLA macros
-unusedLabel:src/openvpn/dco_linux=
=2Ec
-# IGN: old code that is difficult to test (MSG_ERRQUEUE), ignore for =
now
-unusedStructMember:src/openvpn/mtu=2Ec:289
-# FP: used implictly by NL=
 macros
-unusedStructMember:src/openvpn/networking_sitnl=2Ec
-# IGN: keep e=
xplanatory fields in test data
-unusedStructMember:tests/unit_tests/openvpn=
/test_pkcs11=2Ec
-# IGN: nicer to assign generic "arg" early
-variableScope=
:src/openvpn/networking_sitnl=2Ec:1390
-# IGN: nicer to keep the "variable"=
 earlier
-variableScope:src/openvpnserv/interactive=2Ec:2687
-# FP: fun:pla=
tform_create_temp_file: cppcheck is confused
-wrongPrintfScanfArgNum:src/op=
envpn/platform=2Ec:553
diff --git a/dev-tools/cppcheck-suppressions=2Exml b=
/dev-tools/cppcheck-suppressions=2Exml
new file mode 100644
index 0000000=
=2E=2E73dd41b
--- /dev/null
+++ b/dev-tools/cppcheck-suppressions=2Exml
@@ =
-0,0 +1,209 @@
+<?xml version=3D"1=2E0"?>
+<suppressions>
+  <!-- We start =
with enable=3Dall, but then suppress some issues that have too many
+      =
 occurences right now=2E They still should be fixed at some point -->
+  <s=
uppress>
+    <id>constParameter</id>
+  </suppress>
+  <suppress>
+    <id=
>constParameterCallback</id>
+  </suppress>
+  <suppress>
+    <id>constPar=
ameterPointer</id>
+  </suppress>
+  <suppress>
+    <id>invalidPrintfArgTy=
pe_sint</id>
+  </suppress>
+  <suppress>
+    <id>invalidPrintfArgType_uin=
t</id>
+  </suppress>
+  <suppress>
+    <id>unusedFunction</id>
+  </suppr=
ess>
+  <suppress>
+    <id>usleepCalled</id>
+  </suppress>
+  <suppress>
=
+    <id>variableScope</id>
+  </suppress>
+  <!-- We have a lot of library=
 includes, not all of them are really required,
+       so ignore them -->
=
+  <suppress>
+    <id>missingIncludeSystem</id>
+  </suppress>
+  <!-- cpp=
check doesn't understand about check_malloc_return, so these are
+       us=
ually misleading -->
+  <suppress>
+    <id>nullPointerOutOfMemory</id>
+  =
</suppress>
+  <suppress>
+    <id>nullPointerArithmeticOutOfMemory</id>
+ =
 </suppress>
+  <!-- These are specific false-positives (FP) or ignored (IG=
N) issues
+       We might want to move some of them to inline-suppression =
to avoid
+       the static line-numbers -->
+  <!-- IGN: posix=2Ecfg: We a=
re not threadsafe -->
+  <suppress>
+    <id>getgrnamCalled</id>
+  </suppr=
ess>
+  <suppress>
+    <id>getpwnamCalled</id>
+  </suppress>
+  <suppress=
>
+    <id>getservbynameCalled</id>
+  </suppress>
+  <suppress>
+    <id>l=
ocaltimeCalled</id>
+  </suppress>
+  <!-- IGN: too many false-positives du=
e to platform-specific code -->
+  <suppress>
+    <id>knownConditionTrueFa=
lse</id>
+  </suppress>
+  <!-- FP: posix=2Ecfg claims suseconds_t is unsig=
ned for some reason -->
+  <suppress>
+    <id>unsignedLessThanZero</id>
+ =
   <fileName>src/openvpn/otime=2Eh</fileName>
+    <symbolName>usec</symbol=
Name>
+  </suppress>
+  <!-- IGN: the code header =3D 0 | (OPCODE << P_OPCO=
DE_SHIFT) is used intentionally -->
+  <suppress>
+    <id>badBitmaskCheck<=
/id>
+    <fileName>src/openvpn/mudp=2Ec</fileName>
+  </suppress>
+  <supp=
ress>
+    <id>badBitmaskCheck</id>
+    <fileName>tests/unit_tests/openvpn=
/test_pkt=2Ec</fileName>
+  </suppress>
+  <!-- FP: cppcheck seems to have =
wrong signature of DeviceIoControl() -->
+  <suppress>
+    <id>constVariab=
lePointer</id>
+    <fileName>src/openvpn/dco_win=2Ec</fileName>
+    <symb=
olName>buf</symbolName>
+  </suppress>
+  <!-- IGN: test_networking code wo=
uld break with iproute2 but that is prevented -->
+  <suppress>
+    <id>ct=
unullpointer</id>
+    <fileName>src/openvpn/networking_iproute2=2Ec</fileN=
ame>
+  </suppress>
+  <!-- IGN: event code uses a pointer to store integer=
s -->
+  <suppress>
+    <id>intToPointerCast</id>
+    <fileName>src/openv=
pn/forward=2Ec</fileName>
+  </suppress>
+  <suppress>
+    <id>intToPointe=
rCast</id>
+    <fileName>src/openvpn/multi_io=2Ec</fileName>
+  </suppress=
>
+  <suppress>
+    <id>intToPointerCast</id>
+    <fileName>src/openvpn/p=
s=2Ec</fileName>
+  </suppress>
+  <!-- FP: cppcheck seems to be confused s=
ince we cast the pointer to integer -->
+  <suppress>
+    <id>memleak</id>=

+    <fileName>src/plugins/down-root/down-root=2Ec</fileName>
+    <symbol=
Name>context=2Ecommand</symbolName>
+  </suppress>
+  <!-- IGN: we just abo=
rt instead -->
+  <suppress>
+    <id>memleakOnRealloc</id>
+    <fileName>=
src/openvpn/dco_freebsd=2Ec</fileName>
+    <symbolName>buf</symbolName>
+ =
 </suppress>
+  <!-- IGN: strlen(NULL) is not nice code, but seems to work =
-->
+  <suppress>
+    <id>nullPointerRedundantCheck</id>
+    <fileName>sr=
c/openvpn/init=2Ec</fileName>
+    <symbolName>parameters</symbolName>
+  <=
/suppress>
+  <!-- FP: cppcheck doesn't understand ZeroMemory -->
+  <suppr=
ess>
+    <id>redundantAssignment</id>
+    <fileName>src/openvpnserv/inter=
active=2Ec</fileName>
+    <symbolName>overlapped-&gt;hEvent</symbolName>
+=
  </suppress>
+  <!-- IGN: We reuse the same variable name due to macro usa=
ge -->
+  <suppress>
+    <id>shadowVariable</id>
+    <fileName>src/openvp=
n/options=2Ec</fileName>
+    <symbolName>use_err</symbolName>
+  </suppres=
s>
+  <!-- FP: this file is never compiled on _WIN32 -->
+  <suppress>
+   =
 <id>umaskCalled</id>
+    <fileName>tests/unit_tests/openvpn/test_pkcs11=
=2Ec</fileName>
+  </suppress>
+  <!-- FP: yes, t_prev is unitialized, but =
t_prev_len is 0, so that's handled -->
+  <suppress>
+    <id>uninitvar</id=
>
+    <fileName>src/openvpn/crypto_epoch=2Ec</fileName>
+    <symbolName>t=
_prev</symbolName>
+  </suppress>
+  <!-- FP: yes, parm is unitialized, but=
 parm_len is 0, so that's handled -->
+  <suppress>
+    <id>uninitvar</id>=

+    <fileName>src/openvpn/options_parse=2Ec</fileName>
+    <symbolName>p=
arm</symbolName>
+  </suppress>
+  <!-- FP: uninit is fine when it is a ret=
urn parameter -->
+  <suppress>
+    <id>uninitvar</id>
+    <fileName>src/=
openvpnserv/interactive=2Ec</fileName>
+    <symbolName>addr_list</symbolNa=
me>
+  </suppress>
+  <suppress>
+    <id>uninitvar</id>
+    <fileName>src=
/tapctl/main=2Ec</fileName>
+    <symbolName>guidAdapter</symbolName>
+  </=
suppress>
+  <!-- FP: cppcheck doesn't account for short-circuiting -->
+  =
<suppress>
+    <id>unreadVariable</id>
+    <fileName>src/openvpn/manage=
=2Ec</fileName>
+    <symbolName>n</symbolName>
+  </suppress>
+  <!-- FP: =
exported as DLL -->
+  <suppress>
+    <id>unusedFunction</id>
+    <fileNa=
me>src/openvpnmsica/*=2Ec</fileName>
+  </suppress>
+  <!-- FP: loaded as p=
lugins -->
+  <suppress>
+    <id>unusedFunction</id>
+    <fileName>src/pl=
ugins/*</fileName>
+  </suppress>
+  <suppress>
+    <id>unusedFunction</id=
>
+    <fileName>sample/sample-plugins/*</fileName>
+  </suppress>
+  <!-- =
IGN: keep mocking around for future use -->
+  <suppress>
+    <id>unusedFu=
nction</id>
+    <fileName>tests/unit_tests/openvpn/mock_msg=2Ec</fileName>=

+  </suppress>
+  <suppress>
+    <id>unusedFunction</id>
+    <fileName>/=
usr/include/*</fileName>
+  </suppress>
+  <!-- FP: cppcheck doesn't know t=
he NLA macros -->
+  <suppress>
+    <id>unusedLabel</id>
+    <fileName>sr=
c/openvpn/dco_linux=2Ec</fileName>
+  </suppress>
+  <!-- IGN: old code tha=
t is difficult to test (MSG_ERRQUEUE), ignore for now -->
+  <suppress>
+  =
  <id>unusedStructMember</id>
+    <fileName>src/openvpn/mtu=2Ec</fileName>=

+    <symbolName>probehdr::ttl</symbolName>
+  </suppress>
+  <!-- FP: use=
d implictly by NL macros -->
+  <suppress>
+    <id>unusedStructMember</id>=

+    <fileName>src/openvpn/networking_sitnl=2Ec</fileName>
+  </suppress>
=
+  <!-- IGN: keep explanatory fields in test data -->
+  <suppress>
+    <i=
d>unusedStructMember</id>
+    <fileName>tests/unit_tests/openvpn/test_pkcs=
11=2Ec</fileName>
+  </suppress>
+</suppressions>
diff --git a/dev-tools/op=
envpn-cppcheck-library=2Ecfg b/dev-tools/openvpn-cppcheck-library=2Ecfg
ind=
ex decac67=2E=2E0537b39 100644
--- a/dev-tools/openvpn-cppcheck-library=2Ec=
fg
+++ b/dev-tools/openvpn-cppcheck-library=2Ecfg
@@ -28,4 +28,7 @@
   <def=
ine name=3D"CMSG_NXTHDR" value=3D"cmsg_nxthdr" />
   <!-- otherwise a lot o=
f unused variables are shown for enable-small builds -->
   <define name=3D=
"DMSG_ALWAYS_AVAILABLE" value=3D"1" />
+  <!-- cppcheck understands it dire=
ctly in format string, but not
+       indirectly when the format string is=
 constructed earlier -->
+  <define name=3D"PRIx64" value=3D"&quot;lx&quot;=
" />
 </def>
diff --git a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppch=
eck=2Esh
index 37de267=2E=2E4c4ba2c 100755
--- a/dev-tools/run-cppcheck=2Es=
h
+++ b/dev-tools/run-cppcheck=2Esh
@@ -30,7 +30,7 @@
  --enable=3Dall ${di=
sable_arg} \
  --library=3D${SCRIPT_DIR}/openvpn-cppcheck-library=2Ecfg \
 =
 --library=3Dopenssl=2Ecfg \
- --suppressions-list=3D${SCRIPT_DIR}/cppcheck=
-suppression \
+ --suppress-xml=3D${SCRIPT_DIR}/cppcheck-suppressions=2Exml=
 --inline-suppr \
  --cppcheck-build-dir=3D${CPPCHECK_DIR} \
  --check-leve=
l=3D${CPPCHECK_CHECK_LEVEL} --max-configs=3D10 \
  --error-exitcode=3D1 --s=
howtime=3Dsummary"
@@ -39,13 +39,14 @@
 
 mkdir -p "$CPPCHECK_DIR"
 cd "${S=
OURCE_DIR}"
+ret=3D0
 cppcheck $COMMON_ARGS $INCLUDE_FLAGS \
     --platfor=
m=3Dunix64 \
     --library=3Dposix=2Ecfg --library=3Dbsd=2Ecfg --library=
=3Dgnu=2Ecfg \
     -U_WIN32 \
     src/openvpn/ src/compat/ src/plugins/ s=
ample/ \
     tests/unit_tests/example_test/ tests/unit_tests/openvpn/ \
- =
   tests/unit_tests/plugins/
+    tests/unit_tests/plugins/ || ret=3D$?
 cp=
pcheck $COMMON_ARGS \
     --platform=3Dwin64 \
     --library=3Dwindows=2E=
cfg \
@@ -55,4 +56,6 @@
     -UTARGET_AIX \
     -UOPENSSL_NO_EC \
     src=
/openvpn* src/compat/ \
-    tests/unit_tests/example_test/ tests/unit_test=
s/openvpn*
+    tests/unit_tests/example_test/ tests/unit_tests/openvpn* ||=
 ret=3D$?
+
+exit $ret
diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/cr=
ypto=2Ec
index e5ad31a=2E=2Edc22af5 100644
--- a/src/openvpn/crypto=2Ec
+++=
 b/src/openvpn/crypto=2Ec
@@ -268,7 +268,7 @@
             }
 
            =
 /* Encrypt packet ID, payload */
-            int outlen;
+            int=
 outlen =3D 0;
             ASSERT(cipher_ctx_update(ctx->cipher, BEND(&wor=
k), &outlen, BPTR(buf), BLEN(buf)));
             ASSERT(buf_inc_len(&work,=
 outlen));
 
@@ -566,7 +566,7 @@
     dmsg(D_PACKET_CONTENT, "DECRYPT AD: %=
s", format_hex(ad_start, ad_size, 0, &gc));
 
     /* Decrypt and authentic=
ate packet */
-    int outlen;
+    int outlen =3D 0;
     if (!cipher_ctx_=
update(ctx->cipher, BPTR(&work), &outlen, BPTR(buf), data_len))
     {
    =
     CRYPT_ERROR("packet decryption failed");
diff --git a/src/openvpn/mult=
i=2Ec b/src/openvpn/multi=2Ec
index fd54946=2E=2Ea6fadf6 100644
--- a/src/o=
penvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -4239,6 +4239,7 @@
     str=
uct multi_context multi;
 
     top->mode =3D CM_TOP;
+    // cppcheck-supp=
ress autoVariables ; yes, we know this is dangerous
     top->multi =3D &mu=
lti;
     context_clear_2(top);
 
diff --git a/src/openvpn/multi_io=2Ec b/s=
rc/openvpn/multi_io=2Ec
index 4b96c57=2E=2Ebce5018 100644
--- a/src/openvpn=
/multi_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -321,6 +321,7 @@
 {
     co=
nst unsigned int mpp_flags =3D MPP_PRE_SELECT | MPP_RECORD_TOUCH;
     stru=
ct multi_instance *touched =3D mi;
+    // cppcheck-suppress autoVariables =
; yes, we know this is dangerous
     m->mpp_touched =3D &touched;
 
     d=
msg(D_MULTI_DEBUG, "MULTI IO: multi_io_dispatch a=3D%s mi=3D" ptr_format, p=
ract(action),
diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_ver=
ify=2Ec
index 3653eb4=2E=2E6631718 100644
--- a/src/openvpn/ssl_verify=2Ec
=
+++ b/src/openvpn/ssl_verify=2Ec
@@ -925,6 +925,7 @@
 
             errno =
=3D 0;
             long timeout =3D strtol(BSTR(timeout_buf), NULL, 10);
+=
            // cppcheck-suppress compareValueOutOfTypeRangeError ; ULONG_MA=
X=3D=3DUINT_MAX on Windows
             if (timeout <=3D 0 || (unsigned lon=
g)timeout > UINT_MAX || errno)
             {
                 msg(M_WARN, =
"could not parse auth pending file timeout");
diff --git a/src/openvpnserv/=
common=2Ec b/src/openvpnserv/common=2Ec
index 7fc8c14=2E=2Ecce5318 100644
-=
-- a/src/openvpnserv/common=2Ec
+++ b/src/openvpnserv/common=2Ec
@@ -22,6 +=
22,7 @@
 
 #include "service=2Eh"
 #include "validate=2Eh"
+// cppcheck-sup=
press missingInclude ; we run cppcheck on Linux w/o this file
 #include "ev=
entmsg=2Eh"
 
 #include <pathcch=2Eh>
diff --git a/src/openvpnserv/interact=
ive=2Ec b/src/openvpnserv/interactive=2Ec
index 7819f5a=2E=2E4a38aa4 100644=

--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2E=
c
@@ -3601,6 +3601,7 @@
         goto out;
     }
     swprintf(ovpn_pipe_n=
ame, _countof(ovpn_pipe_name),
+             // cppcheck-suppress unknownMa=
cro ; FP, complains about _L only here=2E=2E=2E
              L"\\\\=2E\\pi=
pe\\" _L(PACKAGE) L"%ls\\service_%lu_%ls", service_instance,
              =
GetCurrentThreadId(), pipe_uuid_str);
     RpcStringFreeW(&pipe_uuid_str);
=
diff --git a/tests/unit_tests/openvpn/test_tls_crypt=2Ec b/tests/unit_tests=
/openvpn/test_tls_crypt=2Ec
index f648e13=2E=2Ef8aa199 100644
--- a/tests/u=
nit_tests/openvpn/test_tls_crypt=2Ec
+++ b/tests/unit_tests/openvpn/test_tl=
s_crypt=2Ec
@@ -681,6 +681,7 @@
     struct buffer tmp =3D create_client_ke=
y_input(ctx, 12);
 
     /* Make the wrapped key invalid by flipping a few =
bits */
+    // cppcheck-suppress syntaxError ; cppcheck is confused by thi=
s code
     buf_bptr(&tmp)[buf_len(&tmp) - 20] ^=3D 0x55;
 
     assert_fal=
se(tls_crypt_v2_extract_client_key(&tmp, &wrap_ctx, NULL));

-- 
To view, v=
isit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1953?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: Ie06d3543d0a5d4ca3d3fd6f41498e69=
17ab4c8a9
Gerrit-Change-Number: 1953
Gerrit-PatchSet: 2
Gerrit-Owner: flich=
tenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--4DZtzl31OsA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld <strong>uploaded pa=
tch set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1953?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">cp=
pcheck: Clean up suppressions to not annoy developers<br><br>Actually using=
 it in CI has shown that the line number<br>based suppression is just too a=
nnoying=2E Therefor:<br><br>- Switch to XML based suppressions that allow u=
s to<br>  use symbolName in addition to lineNumber to limit the<br>  suppre=
ssion=2E<br>- Suppress knownConditionTrueFalse always=2E There are just<br>=
  too many instances due to how our code is structured=2E<br>- Also remove =
some unused suppressions=2E<br>- Replace some suppressions with code fixes=
=2E These are<br>  generally speaking false positives but the code fix<br> =
 is less ugly than the suppression=2E<br>- Work around one issue with using=
 PRIx64 macro in a<br>  pre-prepared format string by adding a definition i=
n<br>  our library definition=2E<br>- All suppressions that remain that wer=
e still lineNumber<br>  based (due to the check not reporting a symbol), mo=
ve<br>  to inline suppressions=2E Inline suppressions are somewhat<br>  ugl=
y, but these are very few and I see no better<br>  alternative=2E Maybe we =
can get rid of some of them by<br>  reporting issues to cppcheck=2E (Or, in=
 some cases, by<br>  improving our code)=2E<br><br>While here, make sure th=
at we always run the Windows scan<br>as well, so developers get complete fe=
edback on first push=2E<br><br>Change-Id: Ie06d3543d0a5d4ca3d3fd6f41498e691=
7ab4c8a9<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
;<br>---<br>D dev-tools/cppcheck-suppression<br>A dev-tools/cppcheck-suppre=
ssions=2Exml<br>M dev-tools/openvpn-cppcheck-library=2Ecfg<br>M dev-tools/r=
un-cppcheck=2Esh<br>M src/openvpn/crypto=2Ec<br>M src/openvpn/multi=2Ec<br>=
M src/openvpn/multi_io=2Ec<br>M src/openvpn/ssl_verify=2Ec<br>M src/openvpn=
serv/common=2Ec<br>M src/openvpnserv/interactive=2Ec<br>M tests/unit_tests/=
openvpn/test_tls_crypt=2Ec<br>11 files changed, 226 insertions(+), 124 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/53/1953/2</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/dev-tools/cppcheck=
-suppression b/dev-tools/cppcheck-suppression</span><br><span>deleted file =
mode 100644</span><br><span>index 27c9d30=2E=2E0000000</span><br><span>--- =
a/dev-tools/cppcheck-suppression</span><br><span>+++ /dev/null</span><br><s=
pan>@@ -1,119 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
# We start with --enable=3Dall, but then suppress some issues that have too=
 many</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# occurences rig=
ht now=2E They still should be fixed at some point</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-constParameter</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-constParameterCallback</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-constParameterPointer</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-invalidPrintfArgType_sint</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-invalidPrintfArgType_uint</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-unusedFunction</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-usleepCalled</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-variableScope</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-# We have a lot of library includes, not all of them are really req=
uired,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# so ignore the=
m</span><br><span style=3D"color: hsl(0, 100%, 40%);">-missingIncludeSystem=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# cppcheck doesn&#39;=
t understand about check_malloc_return, so these are</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# usually misleading</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-nullPointerOutOfMemory</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-nullPointerArithmeticOutOfMemory</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-# These are specific false-posi=
tives (FP) or ignored (IGN) issues</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-# We might want to move some of them to inline-suppression to =
avoid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# the static lin=
e-numbers</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# IGN: posix=
=2Ecfg: We are not threadsafe</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-getgrnamCalled</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-getpwnamCalled</span><br><span style=3D"color: hsl(0, 100%, 40%);">-getser=
vbynameCalled</span><br><span style=3D"color: hsl(0, 100%, 40%);">-localtim=
eCalled</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: posix=2E=
cfg claims suseconds_t is unsigned for some reason</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-unsignedLessThanZero:src/openvpn/otime=2Eh:148=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# IGN: multi code doe=
s weird things with pointers to local variables=2E=2E=2E</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-autoVariables:src/openvpn/multi=2Ec:4242=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-autoVariables:src/ope=
nvpn/multi_io=2Ec:324</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
# IGN: the code header =3D 0 | (OPCODE &lt;&lt; P_OPCODE_SHIFT) is used int=
entionally</span><br><span style=3D"color: hsl(0, 100%, 40%);">-badBitmaskC=
heck:src/openvpn/mudp=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-badBitmaskCheck:tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-# IGN: Windows specific (unsigned long =
=3D=3D unsigned int)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-c=
ompareValueOutOfTypeRangeError:src/openvpn/ssl_verify=2Ec:928</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-# FP: cppcheck seems to have wrong =
signature of DeviceIoControl()</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-constVariablePointer:src/openvpn/dco_win=2Ec</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# IGN: test_networking code would break wit=
h iproute2 but that is prevented</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-ctunullpointer:src/openvpn/networking_iproute2=2Ec</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-# IGN: event code uses a pointer to=
 store integers</span><br><span style=3D"color: hsl(0, 100%, 40%);">-intToP=
ointerCast:src/openvpn/forward=2Ec</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-intToPointerCast:src/openvpn/multi_io=2Ec</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-intToPointerCast:src/openvpn/ps=2Ec</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: constant but differs b=
etween platforms</span><br><span style=3D"color: hsl(0, 100%, 40%);">-known=
ConditionTrueFalse:src/openvpn/error=2Eh:382</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-knownConditionTrueFalse:src/openvpn/fdmisc=2Ec:80</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-knownConditionTrueFalse:=
src/openvpn/lladdr=2Ec:64</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-knownConditionTrueFalse:src/openvpn/platform=2Ec</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# FP: code needs to accomodate many differe=
nt defines</span><br><span style=3D"color: hsl(0, 100%, 40%);">-knownCondit=
ionTrueFalse:src/openvpn/event=2Ec:1139</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-knownConditionTrueFalse:src/openvpn/event=2Ec:1148</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: dco_win support has &q=
uot;false&quot; stubs</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
knownConditionTrueFalse:src/openvpn/forward=2Ec</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-knownConditionTrueFalse:src/openvpn/init=2Ec</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-knownConditionTrueFalse:sr=
c/openvpn/multi_io=2Ec:197</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-# FP: cppcheck thinks that some functions always return true, but they=
 don&#39;t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-knownCondit=
ionTrueFalse:src/openvpn/misc=2Ec:97</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-knownConditionTrueFalse:src/openvpn/sig=2Eh:116</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-# FP: cert_uri_supported is a wrap=
per around defines, so it&#39;s</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-# always constant but differs depending on OpenSSL version</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-knownConditionTrueFalse:src/=
openvpn/ssl_openssl=2Ec:1260</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-# FP: cppcheck doesn&#39;t understand that the function changes szEr=
rMessage</span><br><span style=3D"color: hsl(0, 100%, 40%);">-knownConditio=
nTrueFalse:src/tapctl/main=2Ec:704</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-knownConditionTrueFalse:src/openvpnmsica/dllmain=2Ec:164</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: cppcheck seems to be =
confused since we cast the pointer to integer</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-memleak:src/plugins/down-root/down-root=2Ec:337</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-# IGN: we just abort inst=
ead</span><br><span style=3D"color: hsl(0, 100%, 40%);">-memleakOnRealloc:s=
rc/openvpn/dco_freebsd=2Ec:845</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-# FP: eventmsg=2Eh is not built on Unix</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-missingInclude:src/openvpnserv/common=2Ec:25</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-# IGN: strlen(NULL) is no=
t nice code, but seems to work</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-nullPointerRedundantCheck:src/openvpn/init=2Ec:301</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-# FP: cppcheck doesn&#39;t understand=
 ZeroMemory</span><br><span style=3D"color: hsl(0, 100%, 40%);">-redundantA=
ssignment:src/openvpnserv/interactive=2Ec:204</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-# IGN: We reuse the same variable name due to macro=
 usage</span><br><span style=3D"color: hsl(0, 100%, 40%);">-shadowVariable:=
src/openvpn/options=2Ec:1955</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-shadowVariable:src/openvpn/options=2Ec:1973</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-# FP: fun:tls_crypt_v2_wrap_unwrap_invalid: cp=
pcheck is confused</span><br><span style=3D"color: hsl(0, 100%, 40%);">-syn=
taxError:tests/unit_tests/openvpn/test_tls_crypt=2Ec:684</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-# FP: this file is never compiled on _WI=
N32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-umaskCalled:tests/=
unit_tests/openvpn/test_pkcs11=2Ec</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-# FP: yes, t_prev is unitialized, but t_prev_len is 0, so that=
&#39;s handled</span><br><span style=3D"color: hsl(0, 100%, 40%);">-uninitv=
ar:src/openvpn/crypto_epoch=2Ec:60</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-# FP: yes, parm is unitialized, but parm_len is 0, so that&#39=
;s handled</span><br><span style=3D"color: hsl(0, 100%, 40%);">-uninitvar:s=
rc/openvpn/options_parse=2Ec:148</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-# FP: uninit is fine when it is a return parameter</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-ctuuninitvar:src/openvpn/crypto_mbe=
dtls_legacy=2Ec:690</span><br><span style=3D"color: hsl(0, 100%, 40%);">-un=
initvar:src/openvpnserv/interactive=2Ec:2783</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-uninitvar:src/tapctl/main=2Ec:566</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-# FP: weird parse error, the macro is fi=
ne in the rest of the file</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-unknownMacro:src/openvpnserv/interactive=2Ec:3604</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-# FP: cppcheck doesn&#39;t account for sho=
rt-circuiting</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unreadVa=
riable:src/openvpn/manage=2Ec:682</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-unusedFunction:src/openvpn/siphash_reference=2Ec</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-# FP: exported as DLL</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-unusedFunction:src/openvpnmsica/*=2E=
c</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: loaded as plug=
ins</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unusedFunction:src=
/plugins/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unusedFunct=
ion:sample/sample-plugins/*</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-# FP: wmain</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unus=
edFunction:src/tapctl/main=2Ec:613</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-unusedFunction:tests/unit_tests/openvpnserv/test_openvpnserv=
=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# IGN: keep mocki=
ng around for future use</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-unusedFunction:tests/unit_tests/openvpn/mock_msg=2Ec</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-unusedFunction:/usr/include/*</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-# FP: cppcheck doesn&#39;t know t=
he NLA macros</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unusedLa=
bel:src/openvpn/dco_linux=2Ec</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-# IGN: old code that is difficult to test (MSG_ERRQUEUE), ignore fo=
r now</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unusedStructMemb=
er:src/openvpn/mtu=2Ec:289</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-# FP: used implictly by NL macros</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-unusedStructMember:src/openvpn/networking_sitnl=2Ec</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-# IGN: keep explanatory fiel=
ds in test data</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unused=
StructMember:tests/unit_tests/openvpn/test_pkcs11=2Ec</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# IGN: nicer to assign generic &quot;arg&qu=
ot; early</span><br><span style=3D"color: hsl(0, 100%, 40%);">-variableScop=
e:src/openvpn/networking_sitnl=2Ec:1390</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-# IGN: nicer to keep the &quot;variable&quot; earlier</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-variableScope:src/openvpn=
serv/interactive=2Ec:2687</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-# FP: fun:platform_create_temp_file: cppcheck is confused</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-wrongPrintfScanfArgNum:src/openvpn/=
platform=2Ec:553</span><br><span>diff --git a/dev-tools/cppcheck-suppressio=
ns=2Exml b/dev-tools/cppcheck-suppressions=2Exml</span><br><span>new file m=
ode 100644</span><br><span>index 0000000=2E=2E73dd41b</span><br><span>--- /=
dev/null</span><br><span>+++ b/dev-tools/cppcheck-suppressions=2Exml</span>=
<br><span>@@ -0,0 +1,209 @@</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+&lt;?xml version=3D&quot;1=2E0&quot;?&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+&lt;suppressions&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  &lt;!-- We start with enable=3Dall, but th=
en suppress some issues that have too many</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+       occurences right now=2E They still should be =
fixed at some point --&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    &lt;id&gt;constParameter&lt;/id&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &lt;id&gt;constParameterCallback&lt;/id&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;constPara=
meterPointer&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    &lt;id&gt;invalidPrintfArgType_sint&lt;/id&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;invalidPrintfArgType_uint&l=
t;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/sup=
press&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;supp=
ress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&=
gt;unusedFunction&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    &lt;id&gt;usleepCalled&lt;/id&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &lt;id&gt;variableScope&lt;/id&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- We have a lot of libr=
ary includes, not all of them are really required,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+       so ignore them --&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;missingIncludeSystem&l=
t;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/sup=
press&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- =
cppcheck doesn&#39;t understand about check_malloc_return, so these are</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+       usually misleadi=
ng --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;supp=
ress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&=
gt;nullPointerOutOfMemory&lt;/id&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    &lt;id&gt;nullPointerArithmeticOutOfMemory&lt;/id&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- These are s=
pecific false-positives (FP) or ignored (IGN) issues</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+       We might want to move some of them=
 to inline-suppression to avoid</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+       the static line-numbers --&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: posix=2Ecfg: We are not thread=
safe --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;su=
ppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;i=
d&gt;getgrnamCalled&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    &lt;id&gt;getpwnamCalled&lt;/id&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    &lt;id&gt;getservbynameCalled&lt;/id&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;localtim=
eCalled&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 &lt;!-- IGN: too many false-positives due to platform-specific code --&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;knownC=
onditionTrueFalse&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  &lt;!-- FP: posix=2Ecfg claims suseconds_t is unsigned for some =
reason --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;=
suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt=
;id&gt;unsignedLessThanZero&lt;/id&gt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/otime=2Eh&lt;/fileName&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolNam=
e&gt;usec&lt;/symbolName&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  &lt;!-- IGN: the code header =3D 0 | (OPCODE &lt;&lt; P_OPCODE_S=
HIFT) is used intentionally --&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    &lt;id&gt;badBitmaskCheck&lt;/id&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/mudp=2Ec=
&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
&lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
&lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 &lt;id&gt;badBitmaskCheck&lt;/id&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    &lt;fileName&gt;tests/unit_tests/openvpn/test_pkt=2Ec=
&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
&lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
&lt;!-- FP: cppcheck seems to have wrong signature of DeviceIoControl() --&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;con=
stVariablePointer&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    &lt;fileName&gt;src/openvpn/dco_win=2Ec&lt;/fileName&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;buf=
&lt;/symbolName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  &lt;!-- IGN: test_networking code would break with iproute2 but that is p=
revented --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &l=
t;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &=
lt;id&gt;ctunullpointer&lt;/id&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    &lt;fileName&gt;src/openvpn/networking_iproute2=2Ec&lt;/=
fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/=
suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!=
-- IGN: event code uses a pointer to store integers --&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;intToPointerCast&lt;/id=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileNam=
e&gt;src/openvpn/forward=2Ec&lt;/fileName&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &lt;id&gt;intToPointerCast&lt;/id&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/open=
vpn/multi_io=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    &lt;id&gt;intToPointerCast&lt;/id&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/ps=2Ec&l=
t;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &l=
t;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &l=
t;!-- FP: cppcheck seems to be confused since we cast the pointer to intege=
r --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppr=
ess&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&g=
t;memleak&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &lt;fileName&gt;src/plugins/down-root/down-root=2Ec&lt;/fileName&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt=
;context=2Ecommand&lt;/symbolName&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  &lt;!-- IGN: we just abort instead --&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;memleakOnRealloc&lt;=
/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;file=
Name&gt;src/openvpn/dco_freebsd=2Ec&lt;/fileName&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;buf&lt;/symbolName&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: s=
trlen(NULL) is not nice code, but seems to work --&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;nullPointerRedundantCheck&l=
t;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fi=
leName&gt;src/openvpn/init=2Ec&lt;/fileName&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;parameters&lt;/symbolName=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: c=
ppcheck doesn&#39;t understand ZeroMemory --&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    &lt;id&gt;redundantAssignment&lt;/id&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;sr=
c/openvpnserv/interactive=2Ec&lt;/fileName&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;overlapped-&amp;gt;hEvent&=
lt;/symbolName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 &lt;!-- IGN: We reuse the same variable name due to macro usage --&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;shadowVari=
able&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
&lt;fileName&gt;src/openvpn/options=2Ec&lt;/fileName&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;use_err&lt;/symb=
olName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/su=
ppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!--=
 FP: this file is never compiled on _WIN32 --&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    &lt;id&gt;umaskCalled&lt;/id&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;tests/uni=
t_tests/openvpn/test_pkcs11=2Ec&lt;/fileName&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  &lt;!-- FP: yes, t_prev is unitialized, but =
t_prev_len is 0, so that&#39;s handled --&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &lt;id&gt;uninitvar&lt;/id&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/cry=
pto_epoch=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    &lt;symbolName&gt;t_prev&lt;/symbolName&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: yes, parm is unitializ=
ed, but parm_len is 0, so that&#39;s handled --&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;uninitvar&lt;/id&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/op=
envpn/options_parse=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    &lt;symbolName&gt;parm&lt;/symbolName&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: uninit is fine=
 when it is a return parameter --&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    &lt;id&gt;uninitvar&lt;/id&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpnserv/inter=
active=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    &lt;symbolName&gt;addr_list&lt;/symbolName&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;uninitvar&lt;/id&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;sr=
c/tapctl/main=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    &lt;symbolName&gt;guidAdapter&lt;/symbolName&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: cppcheck does=
n&#39;t account for short-circuiting --&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    &lt;id&gt;unreadVariable&lt;/id&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/=
manage=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    &lt;symbolName&gt;n&lt;/symbolName&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: exported as DLL --&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;unusedFunction=
&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;=
fileName&gt;src/openvpnmsica/*=2Ec&lt;/fileName&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: loaded as plugins --&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;unusedFun=
ction&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 &lt;fileName&gt;src/plugins/*&lt;/fileName&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    &lt;id&gt;unusedFunction&lt;/id&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;sample/s=
ample-plugins/*&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  &lt;!-- IGN: keep mocking around for future use --&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;unusedFuncti=
on&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &l=
t;fileName&gt;tests/unit_tests/openvpn/mock_msg=2Ec&lt;/fileName&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;unusedFunctio=
n&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt=
;fileName&gt;/usr/include/*&lt;/fileName&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  &lt;!-- FP: cppcheck doesn&#39;t know the NLA ma=
cros --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;su=
ppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;i=
d&gt;unusedLabel&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    &lt;fileName&gt;src/openvpn/dco_linux=2Ec&lt;/fileName&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: old code =
that is difficult to test (MSG_ERRQUEUE), ignore for now --&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;unusedStructMember=
&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;=
fileName&gt;src/openvpn/mtu=2Ec&lt;/fileName&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;probehdr::ttl&lt;/symbol=
Name&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/supp=
ress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- F=
P: used implictly by NL macros --&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    &lt;id&gt;unusedStructMember&lt;/id&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/ne=
tworking_sitnl=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  &lt;!-- IGN: keep explanatory fields in test data --&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;unusedS=
tructMember&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    &lt;fileName&gt;tests/unit_tests/openvpn/test_pkcs11=2Ec&lt;/fileNam=
e&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppres=
s&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+&lt;/suppressi=
ons&gt;</span><br><span>diff --git a/dev-tools/openvpn-cppcheck-library=2Ec=
fg b/dev-tools/openvpn-cppcheck-library=2Ecfg</span><br><span>index decac67=
=2E=2E0537b39 100644</span><br><span>--- a/dev-tools/openvpn-cppcheck-libra=
ry=2Ecfg</span><br><span>+++ b/dev-tools/openvpn-cppcheck-library=2Ecfg</sp=
an><br><span>@@ -28,4 +28,7 @@</span><br><span>   &lt;define name=3D&quot;C=
MSG_NXTHDR&quot; value=3D&quot;cmsg_nxthdr&quot; /&gt;</span><br><span>   &=
lt;!-- otherwise a lot of unused variables are shown for enable-small build=
s --&gt;</span><br><span>   &lt;define name=3D&quot;DMSG_ALWAYS_AVAILABLE&q=
uot; value=3D&quot;1&quot; /&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  &lt;!-- cppcheck understands it directly in format string, b=
ut not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       indire=
ctly when the format string is constructed earlier --&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  &lt;define name=3D&quot;PRIx64&quot=
; value=3D&quot;&amp;quot;lx&amp;quot;&quot; /&gt;</span><br><span> &lt;/de=
f&gt;</span><br><span>diff --git a/dev-tools/run-cppcheck=2Esh b/dev-tools/=
run-cppcheck=2Esh</span><br><span>index 37de267=2E=2E4c4ba2c 100755</span><=
br><span>--- a/dev-tools/run-cppcheck=2Esh</span><br><span>+++ b/dev-tools/=
run-cppcheck=2Esh</span><br><span>@@ -30,7 +30,7 @@</span><br><span>  --ena=
ble=3Dall ${disable_arg} \</span><br><span>  --library=3D${SCRIPT_DIR}/open=
vpn-cppcheck-library=2Ecfg \</span><br><span>  --library=3Dopenssl=2Ecfg \<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- --suppressions-list=
=3D${SCRIPT_DIR}/cppcheck-suppression \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ --suppress-xml=3D${SCRIPT_DIR}/cppcheck-suppressions=
=2Exml --inline-suppr \</span><br><span>  --cppcheck-build-dir=3D${CPPCHECK=
_DIR} \</span><br><span>  --check-level=3D${CPPCHECK_CHECK_LEVEL} --max-con=
figs=3D10 \</span><br><span>  --error-exitcode=3D1 --showtime=3Dsummary&quo=
t;</span><br><span>@@ -39,13 +39,14 @@</span><br><span> </span><br><span> m=
kdir -p &quot;$CPPCHECK_DIR&quot;</span><br><span> cd &quot;${SOURCE_DIR}&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ret=3D0</span><=
br><span> cppcheck $COMMON_ARGS $INCLUDE_FLAGS \</span><br><span>     --pla=
tform=3Dunix64 \</span><br><span>     --library=3Dposix=2Ecfg --library=3Db=
sd=2Ecfg --library=3Dgnu=2Ecfg \</span><br><span>     -U_WIN32 \</span><br>=
<span>     src/openvpn/ src/compat/ src/plugins/ sample/ \</span><br><span>=
     tests/unit_tests/example_test/ tests/unit_tests/openvpn/ \</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    tests/unit_tests/plugins/</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    tests/unit_tests/pl=
ugins/ || ret=3D$?</span><br><span> cppcheck $COMMON_ARGS \</span><br><span=
>     --platform=3Dwin64 \</span><br><span>     --library=3Dwindows=2Ecfg \=
</span><br><span>@@ -55,4 +56,6 @@</span><br><span>     -UTARGET_AIX \</spa=
n><br><span>     -UOPENSSL_NO_EC \</span><br><span>     src/openvpn* src/co=
mpat/ \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tests/unit=
_tests/example_test/ tests/unit_tests/openvpn*</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    tests/unit_tests/example_test/ tests/unit_te=
sts/openvpn* || ret=3D$?</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+exit $ret</spa=
n><br><span>diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</s=
pan><br><span>index e5ad31a=2E=2Edc22af5 100644</span><br><span>--- a/src/o=
penvpn/crypto=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><s=
pan>@@ -268,7 +268,7 @@</span><br><span>             }</span><br><span> </s=
pan><br><span>             /* Encrypt packet ID, payload */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            int outlen;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            int outlen =3D 0;</sp=
an><br><span>             ASSERT(cipher_ctx_update(ctx-&gt;cipher, BEND(&am=
p;work), &amp;outlen, BPTR(buf), BLEN(buf)));</span><br><span>             =
ASSERT(buf_inc_len(&amp;work, outlen));</span><br><span> </span><br><span>@=
@ -566,7 +566,7 @@</span><br><span>     dmsg(D_PACKET_CONTENT, &quot;DECRYP=
T AD: %s&quot;, format_hex(ad_start, ad_size, 0, &amp;gc));</span><br><span=
> </span><br><span>     /* Decrypt and authenticate packet */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    int outlen;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    int outlen =3D 0;</span><br><span> =
    if (!cipher_ctx_update(ctx-&gt;cipher, BPTR(&amp;work), &amp;outlen, BP=
TR(buf), data_len))</span><br><span>     {</span><br><span>         CRYPT_E=
RROR(&quot;packet decryption failed&quot;);</span><br><span>diff --git a/sr=
c/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index fd54946=
=2E=2Ea6fadf6 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br>=
<span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -4239,6 +4239,7 @@</sp=
an><br><span>     struct multi_context multi;</span><br><span> </span><br><=
span>     top-&gt;mode =3D CM_TOP;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    // cppcheck-suppress autoVariables ; yes, we know this i=
s dangerous</span><br><span>     top-&gt;multi =3D &amp;multi;</span><br><s=
pan>     context_clear_2(top);</span><br><span> </span><br><span>diff --git=
 a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>inde=
x 4b96c57=2E=2Ebce5018 100644</span><br><span>--- a/src/openvpn/multi_io=2E=
c</span><br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><span>@@ -321,6 =
+321,7 @@</span><br><span> {</span><br><span>     const unsigned int mpp_fl=
ags =3D MPP_PRE_SELECT | MPP_RECORD_TOUCH;</span><br><span>     struct mult=
i_instance *touched =3D mi;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    // cppcheck-suppress autoVariables ; yes, we know this is dange=
rous</span><br><span>     m-&gt;mpp_touched =3D &amp;touched;</span><br><sp=
an> </span><br><span>     dmsg(D_MULTI_DEBUG, &quot;MULTI IO: multi_io_disp=
atch a=3D%s mi=3D&quot; ptr_format, pract(action),</span><br><span>diff --g=
it a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec</span><br><spa=
n>index 3653eb4=2E=2E6631718 100644</span><br><span>--- a/src/openvpn/ssl_v=
erify=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify=2Ec</span><br><span>=
@@ -925,6 +925,7 @@</span><br><span> </span><br><span>             errno =
=3D 0;</span><br><span>             long timeout =3D strtol(BSTR(timeout_bu=
f), NULL, 10);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       // cppcheck-suppress compareValueOutOfTypeRangeError ; ULONG_MAX=3D=
=3DUINT_MAX on Windows</span><br><span>             if (timeout &lt;=3D 0 |=
| (unsigned long)timeout &gt; UINT_MAX || errno)</span><br><span>          =
   {</span><br><span>                 msg(M_WARN, &quot;could not parse aut=
h pending file timeout&quot;);</span><br><span>diff --git a/src/openvpnserv=
/common=2Ec b/src/openvpnserv/common=2Ec</span><br><span>index 7fc8c14=2E=
=2Ecce5318 100644</span><br><span>--- a/src/openvpnserv/common=2Ec</span><b=
r><span>+++ b/src/openvpnserv/common=2Ec</span><br><span>@@ -22,6 +22,7 @@<=
/span><br><span> </span><br><span> #include &quot;service=2Eh&quot;</span><=
br><span> #include &quot;validate=2Eh&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+// cppcheck-suppress missingInclude ; we run cppche=
ck on Linux w/o this file</span><br><span> #include &quot;eventmsg=2Eh&quot=
;</span><br><span> </span><br><span> #include &lt;pathcch=2Eh&gt;</span><br=
><span>diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/inter=
active=2Ec</span><br><span>index 7819f5a=2E=2E4a38aa4 100644</span><br><spa=
n>--- a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnse=
rv/interactive=2Ec</span><br><span>@@ -3601,6 +3601,7 @@</span><br><span>  =
       goto out;</span><br><span>     }</span><br><span>     swprintf(ovpn_=
pipe_name, _countof(ovpn_pipe_name),</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+             // cppcheck-suppress unknownMacro ; FP, compl=
ains about _L only here=2E=2E=2E</span><br><span>              L&quot;\\\\=
=2E\\pipe\\&quot; _L(PACKAGE) L&quot;%ls\\service_%lu_%ls&quot;, service_in=
stance,</span><br><span>              GetCurrentThreadId(), pipe_uuid_str);=
</span><br><span>     RpcStringFreeW(&amp;pipe_uuid_str);</span><br><span>d=
iff --git a/tests/unit_tests/openvpn/test_tls_crypt=2Ec b/tests/unit_tests/=
openvpn/test_tls_crypt=2Ec</span><br><span>index f648e13=2E=2Ef8aa199 10064=
4</span><br><span>--- a/tests/unit_tests/openvpn/test_tls_crypt=2Ec</span><=
br><span>+++ b/tests/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>=
@@ -681,6 +681,7 @@</span><br><span>     struct buffer tmp =3D create_clien=
t_key_input(ctx, 12);</span><br><span> </span><br><span>     /* Make the wr=
apped key invalid by flipping a few bits */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    // cppcheck-suppress syntaxError ; cppcheck is =
confused by this code</span><br><span>     buf_bptr(&amp;tmp)[buf_len(&amp;=
tmp) - 20] ^=3D 0x55;</span><br><span> </span><br><span>     assert_false(t=
ls_crypt_v2_extract_client_key(&amp;tmp, &amp;wrap_ctx, NULL));</span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1953?usp=3Demail">change 1953</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1953?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpa=
tchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: Ie06d3543d0a5d4ca3d3fd6f41498e6917ab4c8a9 </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1953 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> =
Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</=
body></html>
--4DZtzl31OsA=--


--===============2679197380129833189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2679197380129833189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2679197380129833189==--

