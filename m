Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1C2C98328
	for <openvpn-devel@archiver.kernel.org>; Sat, 26 Sep 2026 08:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WGpQPcEF3Fu/cOeqpxWSI16MatVBR5d1p69Wh0QpApI=; b=bYVWFS14OlkOmO+XGzLj4pqNI4
	EKb/M46dzGuFot4t7Ea8mbTIvdV+u9Y7hLbtnBEdla2DvevPFgJP1UHK8lo8YD5D/WLBM0KZLw5+s
	QG2qzsdpDdkxjDjBaVK5COCPi0QdM7pV+TA7cSaUY9YVtproaXOIO/DMmLS2G2hHW61A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xANch-0003mF-EJ;
	Sat, 26 Sep 2026 08:19:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xANca-0003lu-4p
 for openvpn-devel@lists.sourceforge.net;
 Sat, 26 Sep 2026 08:19:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=vfD0hY0KZ0c50I7WJJipi0bwVXDLvhbNWD9Ezh5m6IQ=; b=fWXe0AvUNj2CA1fPqIJhw1bSnd
 LZYTeYfDyMqpZd5PjOnDMyiNkP1sulLQ6DlZym5uN6R0MGiR3pBV4S6s6ifh9Y72ET+5fwMcsw6fD
 bgyorZ5TwW2tpYGXMDzrdis9asXexOdM+FLX3vLHjE/jRnf5FdvL/RgjvLYQNJaiPXI0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vfD0hY0KZ0c50I7WJJipi0bwVXDLvhbNWD9Ezh5m6IQ=; b=R
 qRK70yQMg0gvqyeoDbosyqIyWY74YoFgEBNxjVpG4Qfm0EK8qa59XlMUKcMw03gnXRqu/e86ZZdi2
 1eUGEKAtOtEZAEFZhy8PZeuCUh6cQGABlENTRILT/umW9DhsE1s8Inh5QTcsEHgCNvPBKAxO/XJp7
 qsjkdg3EifuhQgMw=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xANcW-0005Fi-BH for openvpn-devel@lists.sourceforge.net;
 Sat, 26 Sep 2026 08:19:00 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ffde3cec6so616545e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 26 Sep 2026 01:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790410730; x=1791015530; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vfD0hY0KZ0c50I7WJJipi0bwVXDLvhbNWD9Ezh5m6IQ=;
 b=B3OLYC1vOIIdjaRTMtHFm/CW24iPzcCvqYeSTZ+LUlPeWF6d7zXSSV05z9d1Urc+xr
 lGlztnHbHuC9N/xcvBxrao60xxolBzGifMOY3vvrUR7Fv3uBD/HYT9Vti442ITqoviEM
 HbKyy35u634bxLg24/HP3mmlczKXUpin+FMrYFiStcShBeLCFXgB8yO+tdQPnhtU1Lbh
 lTRhJLrnG7CKPT218OwkBaT0WzrLmBuNYZmSsyduZGbpbDEsQ2D+KH7zaoDDfcT6dDv7
 TtCPQelbl0jb6rZOdUm+p8brbCrhWdQ7A0zJw5hqgTtD7vCy7hxu0Zh66+rc+XR0FcHt
 uuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790410730; x=1791015530;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vfD0hY0KZ0c50I7WJJipi0bwVXDLvhbNWD9Ezh5m6IQ=;
 b=hM3Vi4lDFNKwtbdxg4oLytnuhSt6PbWHDo/UUNB8Mj/0ctoLam7bg4BFbXXGx87+3d
 yLdu49U+Q54NqfS4DbomCSDIcPgQOP9KajpEk59x8hjzhL3u6cbQ5uxXsJzObmdYy9Ah
 qgr8/oGtZ0TxECl7hJrjFccy7gyh5N5lcLwJhw85/rN1nERaJVZZ0+m7u2gUWWeIoS9a
 YAoN1sgBCO8FpKInf8+oGwPMI/rx/8yKPF89PBmL+YckaJ+AoanabJ9v2iy+Q8o6rz0E
 t5zrlbZRVKDu/ZEhMlJkmDBVdnQuq2PBovj+lqYzoJH8zZQbNjRK38ERQxovG3T+O3E6
 jWtA==
X-Gm-Message-State: AFuF++nrdCkam4vU8Wfym/FYQdEcqS7GRGVWgOoX1tXnjaA2ASdl19nh
 e8VoROkJB6lMCExhexYi6PSIXknddjS25lxsYSxK+az/KD303t5uwcZjdz3vrlKJZLNYsHHEsep
 /F9IUAeJQL1V+QJUSGc4MpcA8EJWLNBXC+QAGT8wpiUvDZXKpodcxAdE+0GCD/A0wtDPz
X-Gm-Gg: AYBFou2+tHX9utcd0bOhvEpkThtWuYxlIQLBfo8had295I5cNYeWlg+SYCWNPCHmscl
 pkLQl7uCgoVQNwscCvNrnQi464ACWOf3H5lrKEUY6ndZFI5uBKXH1P1R6thUj15UJ5sLZzT6R21
 +HzoEXtoy4YzUhwEuR1a1R6KY/JYuHOkm5X3loYkYcRPcdf4Xu+zLCcfhAqv/5+Wsr7qMe1CAKj
 58YINsnlpNhdIakSLGE41N9RPRyqlSKGsXyBLMx0s+3xk2qZDfDxGavUHJAEEmk0fYtRIf9sBag
 EmZhzqjZhIFBkCtQG1Vkl1LDAaGp8qU3kxTBuzdVkNdGwxV14bm7jnp5g1yIQDCLNmPaB00uB9t
 AE/wcAjb5g15j/+9PRJ9iL8A1B0E0VCbbp9bDNnRGm2vJOuI+AGdw9+LxOUDlNejuOt6j9jsFtB
 mTK/SLlrhXteLFizcohE9JEaMRcKaYTnXoecqDUOgBsiNdG6bhzkG74SjpVpXK7RA4ar88nin+h
 FrB1Wr4mXZdSX/9+45I/KqQ9yOTUAu48xO5SI8EsNRmMXwTFSCOE6IOEk1cnhg81/YJHTfFSiwt
 5zkVDSLRzzc/yJt5w/LOU1PI4DgNuLdD4Zrcrg2QN26O44XwmEU/da7DZsfGNVZ1I7TOiUA=
X-Received: by 2002:a05:600c:468d:b0:49f:f9d1:e618 with SMTP id
 5b1f17b1804b1-49ff9d1e6b1mr21887435e9.17.1790410729436; 
 Sat, 26 Sep 2026 01:18:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff43ad975sm138328965e9.13.2026.09.26.01.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 01:18:48 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 26 Sep 2026 08:18:47 +0000
To: flichtenheld <frank@lichtenheld.com>, razvanc <razvanc@mailbox.org>,
 plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ie06d3543d0a5d4ca3d3fd6f41498e6917ab4c8a9
X-Gerrit-Change-Number: 1953
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1953?usp=email>
X-Gerrit-Commit: 060b9ebd1460600803d49abed990ab5f71b72395
In-Reply-To: <gerrit.1790352577000.Ie06d3543d0a5d4ca3d3fd6f41498e6917ab4c8a9@gerrit.openvpn.net>
References: <gerrit.1790352577000.Ie06d3543d0a5d4ca3d3fd6f41498e6917ab4c8a9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzUyNTc3MDAwLkllMDZkMzU0M2QwYTVkNGNhM2QzZmQ2ZjQxNDk4ZTY5MTdhYjRjOGE5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9362d913241197257432d62f102ff994c61c40b7-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xANcW-0005Fi-BH
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2578442967885850391=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2578442967885850391==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ONn9GOdpczg="; charset=UTF-8

--ONn9GOdpczg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1953?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by razvanc


Change subject: cppcheck: Clean up suppressions to not annoy d=
evelopers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

c=
ppcheck: Clean up suppressions to not annoy developers

Actually using it i=
n CI has shown that the line number
based suppression is just too annoying=
=2E Therefor:

- Switch to XML based suppressions that allow us to
  use sy=
mbolName in addition to lineNumber to limit the
  suppression=2E
- Suppress=
 knownConditionTrueFalse always=2E There are just
  too many instances due =
to how our code is structured=2E
- Also remove some unused suppressions=2E
=
- Replace some suppressions with code fixes=2E These are
  generally speaki=
ng false positives but the code fix
  is less ugly than the suppression=2E
=
- Work around one issue with using PRIx64 macro in a
  pre-prepared format =
string by adding a definition in
  our library definition=2E
- All suppress=
ions that remain that were still lineNumber
  based (due to the check not r=
eporting a symbol), move
  to inline suppressions=2E Inline suppressions ar=
e somewhat
  ugly, but these are very few and I see no better
  alternative=
=2E Maybe we can get rid of some of them by
  reporting issues to cppcheck=
=2E (Or, in some cases, by
  improving our code)=2E

While here, make sure =
that we always run the Windows scan
as well, so developers get complete fee=
dback on first push=2E

Change-Id: Ie06d3543d0a5d4ca3d3fd6f41498e6917ab4c8a=
9
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1953
Message-Id: <20260925213118=2E29507-1-gert@greenie=2Em=
uc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esource=
forge=2Enet/msg39523=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
D dev-tools/cppcheck-suppression
A dev-tools/cppcheck-suppressio=
ns=2Exml
M dev-tools/openvpn-cppcheck-library=2Ecfg
M dev-tools/run-cppchec=
k=2Esh
M src/openvpn/crypto=2Ec
M src/openvpn/multi=2Ec
M src/openvpn/multi=
_io=2Ec
M src/openvpn/ssl_verify=2Ec
M src/openvpnserv/common=2Ec
M src/ope=
nvpnserv/interactive=2Ec
M tests/unit_tests/openvpn/test_tls_crypt=2Ec
11 f=
iles changed, 226 insertions(+), 124 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/53/1953/3

diff --git a/dev-too=
ls/cppcheck-suppression b/dev-tools/cppcheck-suppression
deleted file mode =
100644
index 27c9d30=2E=2E0000000
--- a/dev-tools/cppcheck-suppression
+++ =
/dev/null
@@ -1,119 +0,0 @@
-# We start with --enable=3Dall, but then suppr=
ess some issues that have too many
-# occurences right now=2E They still sh=
ould be fixed at some point
-constParameter
-constParameterCallback
-constP=
arameterPointer
-invalidPrintfArgType_sint
-invalidPrintfArgType_uint
-unus=
edFunction
-usleepCalled
-variableScope
-# We have a lot of library include=
s, not all of them are really required,
-# so ignore them
-missingIncludeSy=
stem
-# cppcheck doesn't understand about check_malloc_return, so these are=

-# usually misleading
-nullPointerOutOfMemory
-nullPointerArithmeticOutOfM=
emory
-# These are specific false-positives (FP) or ignored (IGN) issues
-#=
 We might want to move some of them to inline-suppression to avoid
-# the s=
tatic line-numbers
-# IGN: posix=2Ecfg: We are not threadsafe
-getgrnamCall=
ed
-getpwnamCalled
-getservbynameCalled
-localtimeCalled
-# FP: posix=2Ecfg=
 claims suseconds_t is unsigned for some reason
-unsignedLessThanZero:src/o=
penvpn/otime=2Eh:148
-# IGN: multi code does weird things with pointers to =
local variables=2E=2E=2E
-autoVariables:src/openvpn/multi=2Ec:4242
-autoVar=
iables:src/openvpn/multi_io=2Ec:324
-# IGN: the code header =3D 0 | (OPCODE=
 << P_OPCODE_SHIFT) is used intentionally
-badBitmaskCheck:src/openvpn/mudp=
=2Ec
-badBitmaskCheck:tests/unit_tests/openvpn/test_pkt=2Ec
-# IGN: Windows=
 specific (unsigned long =3D=3D unsigned int)
-compareValueOutOfTypeRangeEr=
ror:src/openvpn/ssl_verify=2Ec:928
-# FP: cppcheck seems to have wrong sign=
ature of DeviceIoControl()
-constVariablePointer:src/openvpn/dco_win=2Ec
-#=
 IGN: test_networking code would break with iproute2 but that is prevented
=
-ctunullpointer:src/openvpn/networking_iproute2=2Ec
-# IGN: event code uses=
 a pointer to store integers
-intToPointerCast:src/openvpn/forward=2Ec
-int=
ToPointerCast:src/openvpn/multi_io=2Ec
-intToPointerCast:src/openvpn/ps=2Ec=

-# FP: constant but differs between platforms
-knownConditionTrueFalse:src=
/openvpn/error=2Eh:382
-knownConditionTrueFalse:src/openvpn/fdmisc=2Ec:80
-=
knownConditionTrueFalse:src/openvpn/lladdr=2Ec:64
-knownConditionTrueFalse:=
src/openvpn/platform=2Ec
-# FP: code needs to accomodate many different def=
ines
-knownConditionTrueFalse:src/openvpn/event=2Ec:1139
-knownConditionTru=
eFalse:src/openvpn/event=2Ec:1148
-# FP: dco_win support has "false" stubs
=
-knownConditionTrueFalse:src/openvpn/forward=2Ec
-knownConditionTrueFalse:s=
rc/openvpn/init=2Ec
-knownConditionTrueFalse:src/openvpn/multi_io=2Ec:197
-=
# FP: cppcheck thinks that some functions always return true, but they don'=
t
-knownConditionTrueFalse:src/openvpn/misc=2Ec:97
-knownConditionTrueFalse=
:src/openvpn/sig=2Eh:116
-# FP: cert_uri_supported is a wrapper around defi=
nes, so it's
-# always constant but differs depending on OpenSSL version
-k=
nownConditionTrueFalse:src/openvpn/ssl_openssl=2Ec:1260
-# FP: cppcheck doe=
sn't understand that the function changes szErrMessage
-knownConditionTrueF=
alse:src/tapctl/main=2Ec:704
-knownConditionTrueFalse:src/openvpnmsica/dllm=
ain=2Ec:164
-# FP: cppcheck seems to be confused since we cast the pointer =
to integer
-memleak:src/plugins/down-root/down-root=2Ec:337
-# IGN: we just=
 abort instead
-memleakOnRealloc:src/openvpn/dco_freebsd=2Ec:845
-# FP: eve=
ntmsg=2Eh is not built on Unix
-missingInclude:src/openvpnserv/common=2Ec:2=
5
-# IGN: strlen(NULL) is not nice code, but seems to work
-nullPointerRedu=
ndantCheck:src/openvpn/init=2Ec:301
-# FP: cppcheck doesn't understand Zero=
Memory
-redundantAssignment:src/openvpnserv/interactive=2Ec:204
-# IGN: We =
reuse the same variable name due to macro usage
-shadowVariable:src/openvpn=
/options=2Ec:1955
-shadowVariable:src/openvpn/options=2Ec:1973
-# FP: fun:t=
ls_crypt_v2_wrap_unwrap_invalid: cppcheck is confused
-syntaxError:tests/un=
it_tests/openvpn/test_tls_crypt=2Ec:684
-# FP: this file is never compiled =
on _WIN32
-umaskCalled:tests/unit_tests/openvpn/test_pkcs11=2Ec
-# FP: yes,=
 t_prev is unitialized, but t_prev_len is 0, so that's handled
-uninitvar:s=
rc/openvpn/crypto_epoch=2Ec:60
-# FP: yes, parm is unitialized, but parm_le=
n is 0, so that's handled
-uninitvar:src/openvpn/options_parse=2Ec:148
-# F=
P: uninit is fine when it is a return parameter
-ctuuninitvar:src/openvpn/c=
rypto_mbedtls_legacy=2Ec:690
-uninitvar:src/openvpnserv/interactive=2Ec:278=
3
-uninitvar:src/tapctl/main=2Ec:566
-# FP: weird parse error, the macro is=
 fine in the rest of the file
-unknownMacro:src/openvpnserv/interactive=2Ec=
:3604
-# FP: cppcheck doesn't account for short-circuiting
-unreadVariable:=
src/openvpn/manage=2Ec:682
-unusedFunction:src/openvpn/siphash_reference=2E=
c
-# FP: exported as DLL
-unusedFunction:src/openvpnmsica/*=2Ec
-# FP: load=
ed as plugins
-unusedFunction:src/plugins/*
-unusedFunction:sample/sample-p=
lugins/*
-# FP: wmain
-unusedFunction:src/tapctl/main=2Ec:613
-unusedFuncti=
on:tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
-# IGN: keep mocking a=
round for future use
-unusedFunction:tests/unit_tests/openvpn/mock_msg=2Ec
=
-unusedFunction:/usr/include/*
-# FP: cppcheck doesn't know the NLA macros
=
-unusedLabel:src/openvpn/dco_linux=2Ec
-# IGN: old code that is difficult t=
o test (MSG_ERRQUEUE), ignore for now
-unusedStructMember:src/openvpn/mtu=
=2Ec:289
-# FP: used implictly by NL macros
-unusedStructMember:src/openvpn=
/networking_sitnl=2Ec
-# IGN: keep explanatory fields in test data
-unusedS=
tructMember:tests/unit_tests/openvpn/test_pkcs11=2Ec
-# IGN: nicer to assig=
n generic "arg" early
-variableScope:src/openvpn/networking_sitnl=2Ec:1390
=
-# IGN: nicer to keep the "variable" earlier
-variableScope:src/openvpnserv=
/interactive=2Ec:2687
-# FP: fun:platform_create_temp_file: cppcheck is con=
fused
-wrongPrintfScanfArgNum:src/openvpn/platform=2Ec:553
diff --git a/dev=
-tools/cppcheck-suppressions=2Exml b/dev-tools/cppcheck-suppressions=2Exml
=
new file mode 100644
index 0000000=2E=2E73dd41b
--- /dev/null
+++ b/dev-too=
ls/cppcheck-suppressions=2Exml
@@ -0,0 +1,209 @@
+<?xml version=3D"1=2E0"?>=

+<suppressions>
+  <!-- We start with enable=3Dall, but then suppress some=
 issues that have too many
+       occurences right now=2E They still shoul=
d be fixed at some point -->
+  <suppress>
+    <id>constParameter</id>
+  =
</suppress>
+  <suppress>
+    <id>constParameterCallback</id>
+  </suppres=
s>
+  <suppress>
+    <id>constParameterPointer</id>
+  </suppress>
+  <sup=
press>
+    <id>invalidPrintfArgType_sint</id>
+  </suppress>
+  <suppress>=

+    <id>invalidPrintfArgType_uint</id>
+  </suppress>
+  <suppress>
+    =
<id>unusedFunction</id>
+  </suppress>
+  <suppress>
+    <id>usleepCalled<=
/id>
+  </suppress>
+  <suppress>
+    <id>variableScope</id>
+  </suppress=
>
+  <!-- We have a lot of library includes, not all of them are really req=
uired,
+       so ignore them -->
+  <suppress>
+    <id>missingIncludeSyst=
em</id>
+  </suppress>
+  <!-- cppcheck doesn't understand about check_mall=
oc_return, so these are
+       usually misleading -->
+  <suppress>
+    <=
id>nullPointerOutOfMemory</id>
+  </suppress>
+  <suppress>
+    <id>nullPo=
interArithmeticOutOfMemory</id>
+  </suppress>
+  <!-- These are specific f=
alse-positives (FP) or ignored (IGN) issues
+       We might want to move s=
ome of them to inline-suppression to avoid
+       the static line-numbers =
-->
+  <!-- IGN: posix=2Ecfg: We are not threadsafe -->
+  <suppress>
+    =
<id>getgrnamCalled</id>
+  </suppress>
+  <suppress>
+    <id>getpwnamCalle=
d</id>
+  </suppress>
+  <suppress>
+    <id>getservbynameCalled</id>
+  </=
suppress>
+  <suppress>
+    <id>localtimeCalled</id>
+  </suppress>
+  <!-=
- IGN: too many false-positives due to platform-specific code -->
+  <suppr=
ess>
+    <id>knownConditionTrueFalse</id>
+  </suppress>
+  <!-- FP: posix=
=2Ecfg claims suseconds_t is unsigned for some reason -->
+  <suppress>
+  =
  <id>unsignedLessThanZero</id>
+    <fileName>src/openvpn/otime=2Eh</fileN=
ame>
+    <symbolName>usec</symbolName>
+  </suppress>
+  <!-- IGN: the cod=
e header =3D 0 | (OPCODE << P_OPCODE_SHIFT) is used intentionally -->
+  <s=
uppress>
+    <id>badBitmaskCheck</id>
+    <fileName>src/openvpn/mudp=2Ec<=
/fileName>
+  </suppress>
+  <suppress>
+    <id>badBitmaskCheck</id>
+    =
<fileName>tests/unit_tests/openvpn/test_pkt=2Ec</fileName>
+  </suppress>
+=
  <!-- FP: cppcheck seems to have wrong signature of DeviceIoControl() -->
=
+  <suppress>
+    <id>constVariablePointer</id>
+    <fileName>src/openvpn=
/dco_win=2Ec</fileName>
+    <symbolName>buf</symbolName>
+  </suppress>
+ =
 <!-- IGN: test_networking code would break with iproute2 but that is preve=
nted -->
+  <suppress>
+    <id>ctunullpointer</id>
+    <fileName>src/open=
vpn/networking_iproute2=2Ec</fileName>
+  </suppress>
+  <!-- IGN: event co=
de uses a pointer to store integers -->
+  <suppress>
+    <id>intToPointer=
Cast</id>
+    <fileName>src/openvpn/forward=2Ec</fileName>
+  </suppress>
=
+  <suppress>
+    <id>intToPointerCast</id>
+    <fileName>src/openvpn/mul=
ti_io=2Ec</fileName>
+  </suppress>
+  <suppress>
+    <id>intToPointerCast=
</id>
+    <fileName>src/openvpn/ps=2Ec</fileName>
+  </suppress>
+  <!-- F=
P: cppcheck seems to be confused since we cast the pointer to integer -->
+=
  <suppress>
+    <id>memleak</id>
+    <fileName>src/plugins/down-root/dow=
n-root=2Ec</fileName>
+    <symbolName>context=2Ecommand</symbolName>
+  </=
suppress>
+  <!-- IGN: we just abort instead -->
+  <suppress>
+    <id>mem=
leakOnRealloc</id>
+    <fileName>src/openvpn/dco_freebsd=2Ec</fileName>
+ =
   <symbolName>buf</symbolName>
+  </suppress>
+  <!-- IGN: strlen(NULL) is=
 not nice code, but seems to work -->
+  <suppress>
+    <id>nullPointerRed=
undantCheck</id>
+    <fileName>src/openvpn/init=2Ec</fileName>
+    <symbo=
lName>parameters</symbolName>
+  </suppress>
+  <!-- FP: cppcheck doesn't u=
nderstand ZeroMemory -->
+  <suppress>
+    <id>redundantAssignment</id>
+ =
   <fileName>src/openvpnserv/interactive=2Ec</fileName>
+    <symbolName>ov=
erlapped-&gt;hEvent</symbolName>
+  </suppress>
+  <!-- IGN: We reuse the s=
ame variable name due to macro usage -->
+  <suppress>
+    <id>shadowVaria=
ble</id>
+    <fileName>src/openvpn/options=2Ec</fileName>
+    <symbolName=
>use_err</symbolName>
+  </suppress>
+  <!-- FP: this file is never compile=
d on _WIN32 -->
+  <suppress>
+    <id>umaskCalled</id>
+    <fileName>test=
s/unit_tests/openvpn/test_pkcs11=2Ec</fileName>
+  </suppress>
+  <!-- FP: =
yes, t_prev is unitialized, but t_prev_len is 0, so that's handled -->
+  <=
suppress>
+    <id>uninitvar</id>
+    <fileName>src/openvpn/crypto_epoch=
=2Ec</fileName>
+    <symbolName>t_prev</symbolName>
+  </suppress>
+  <!--=
 FP: yes, parm is unitialized, but parm_len is 0, so that's handled -->
+  =
<suppress>
+    <id>uninitvar</id>
+    <fileName>src/openvpn/options_parse=
=2Ec</fileName>
+    <symbolName>parm</symbolName>
+  </suppress>
+  <!-- F=
P: uninit is fine when it is a return parameter -->
+  <suppress>
+    <id>=
uninitvar</id>
+    <fileName>src/openvpnserv/interactive=2Ec</fileName>
+ =
   <symbolName>addr_list</symbolName>
+  </suppress>
+  <suppress>
+    <id=
>uninitvar</id>
+    <fileName>src/tapctl/main=2Ec</fileName>
+    <symbolN=
ame>guidAdapter</symbolName>
+  </suppress>
+  <!-- FP: cppcheck doesn't ac=
count for short-circuiting -->
+  <suppress>
+    <id>unreadVariable</id>
+=
    <fileName>src/openvpn/manage=2Ec</fileName>
+    <symbolName>n</symbolN=
ame>
+  </suppress>
+  <!-- FP: exported as DLL -->
+  <suppress>
+    <id>=
unusedFunction</id>
+    <fileName>src/openvpnmsica/*=2Ec</fileName>
+  </s=
uppress>
+  <!-- FP: loaded as plugins -->
+  <suppress>
+    <id>unusedFun=
ction</id>
+    <fileName>src/plugins/*</fileName>
+  </suppress>
+  <suppr=
ess>
+    <id>unusedFunction</id>
+    <fileName>sample/sample-plugins/*</f=
ileName>
+  </suppress>
+  <!-- IGN: keep mocking around for future use -->=

+  <suppress>
+    <id>unusedFunction</id>
+    <fileName>tests/unit_tests=
/openvpn/mock_msg=2Ec</fileName>
+  </suppress>
+  <suppress>
+    <id>unus=
edFunction</id>
+    <fileName>/usr/include/*</fileName>
+  </suppress>
+  =
<!-- FP: cppcheck doesn't know the NLA macros -->
+  <suppress>
+    <id>un=
usedLabel</id>
+    <fileName>src/openvpn/dco_linux=2Ec</fileName>
+  </sup=
press>
+  <!-- IGN: old code that is difficult to test (MSG_ERRQUEUE), igno=
re for now -->
+  <suppress>
+    <id>unusedStructMember</id>
+    <fileNam=
e>src/openvpn/mtu=2Ec</fileName>
+    <symbolName>probehdr::ttl</symbolName=
>
+  </suppress>
+  <!-- FP: used implictly by NL macros -->
+  <suppress>
=
+    <id>unusedStructMember</id>
+    <fileName>src/openvpn/networking_sitn=
l=2Ec</fileName>
+  </suppress>
+  <!-- IGN: keep explanatory fields in tes=
t data -->
+  <suppress>
+    <id>unusedStructMember</id>
+    <fileName>te=
sts/unit_tests/openvpn/test_pkcs11=2Ec</fileName>
+  </suppress>
+</suppres=
sions>
diff --git a/dev-tools/openvpn-cppcheck-library=2Ecfg b/dev-tools/op=
envpn-cppcheck-library=2Ecfg
index decac67=2E=2E0537b39 100644
--- a/dev-to=
ols/openvpn-cppcheck-library=2Ecfg
+++ b/dev-tools/openvpn-cppcheck-library=
=2Ecfg
@@ -28,4 +28,7 @@
   <define name=3D"CMSG_NXTHDR" value=3D"cmsg_nxth=
dr" />
   <!-- otherwise a lot of unused variables are shown for enable-sma=
ll builds -->
   <define name=3D"DMSG_ALWAYS_AVAILABLE" value=3D"1" />
+  <=
!-- cppcheck understands it directly in format string, but not
+       indi=
rectly when the format string is constructed earlier -->
+  <define name=3D=
"PRIx64" value=3D"&quot;lx&quot;" />
 </def>
diff --git a/dev-tools/run-cpp=
check=2Esh b/dev-tools/run-cppcheck=2Esh
index 37de267=2E=2E4c4ba2c 100755
=
--- a/dev-tools/run-cppcheck=2Esh
+++ b/dev-tools/run-cppcheck=2Esh
@@ -30,=
7 +30,7 @@
  --enable=3Dall ${disable_arg} \
  --library=3D${SCRIPT_DIR}/op=
envpn-cppcheck-library=2Ecfg \
  --library=3Dopenssl=2Ecfg \
- --suppressio=
ns-list=3D${SCRIPT_DIR}/cppcheck-suppression \
+ --suppress-xml=3D${SCRIPT_=
DIR}/cppcheck-suppressions=2Exml --inline-suppr \
  --cppcheck-build-dir=3D=
${CPPCHECK_DIR} \
  --check-level=3D${CPPCHECK_CHECK_LEVEL} --max-configs=
=3D10 \
  --error-exitcode=3D1 --showtime=3Dsummary"
@@ -39,13 +39,14 @@
 
=
 mkdir -p "$CPPCHECK_DIR"
 cd "${SOURCE_DIR}"
+ret=3D0
 cppcheck $COMMON_AR=
GS $INCLUDE_FLAGS \
     --platform=3Dunix64 \
     --library=3Dposix=2Ecfg=
 --library=3Dbsd=2Ecfg --library=3Dgnu=2Ecfg \
     -U_WIN32 \
     src/ope=
nvpn/ src/compat/ src/plugins/ sample/ \
     tests/unit_tests/example_test=
/ tests/unit_tests/openvpn/ \
-    tests/unit_tests/plugins/
+    tests/uni=
t_tests/plugins/ || ret=3D$?
 cppcheck $COMMON_ARGS \
     --platform=3Dwin=
64 \
     --library=3Dwindows=2Ecfg \
@@ -55,4 +56,6 @@
     -UTARGET_AIX \=

     -UOPENSSL_NO_EC \
     src/openvpn* src/compat/ \
-    tests/unit_tes=
ts/example_test/ tests/unit_tests/openvpn*
+    tests/unit_tests/example_te=
st/ tests/unit_tests/openvpn* || ret=3D$?
+
+exit $ret
diff --git a/src/ope=
nvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index e5ad31a=2E=2Edc22af5 100644
=
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -268,7 +268,7 =
@@
             }
 
             /* Encrypt packet ID, payload */
-        =
    int outlen;
+            int outlen =3D 0;
             ASSERT(cipher_c=
tx_update(ctx->cipher, BEND(&work), &outlen, BPTR(buf), BLEN(buf)));
      =
       ASSERT(buf_inc_len(&work, outlen));
 
@@ -566,7 +566,7 @@
     dmsg(=
D_PACKET_CONTENT, "DECRYPT AD: %s", format_hex(ad_start, ad_size, 0, &gc));=

 
     /* Decrypt and authenticate packet */
-    int outlen;
+    int out=
len =3D 0;
     if (!cipher_ctx_update(ctx->cipher, BPTR(&work), &outlen, B=
PTR(buf), data_len))
     {
         CRYPT_ERROR("packet decryption failed"=
);
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index fd54946=
=2E=2Ea6fadf6 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2E=
c
@@ -4239,6 +4239,7 @@
     struct multi_context multi;
 
     top->mode =
=3D CM_TOP;
+    // cppcheck-suppress autoVariables ; yes, we know this is =
dangerous
     top->multi =3D &multi;
     context_clear_2(top);
 
diff --g=
it a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec
index 4b96c57=2E=
=2Ebce5018 100644
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi_io=
=2Ec
@@ -321,6 +321,7 @@
 {
     const unsigned int mpp_flags =3D MPP_PRE_S=
ELECT | MPP_RECORD_TOUCH;
     struct multi_instance *touched =3D mi;
+    =
// cppcheck-suppress autoVariables ; yes, we know this is dangerous
     m-=
>mpp_touched =3D &touched;
 
     dmsg(D_MULTI_DEBUG, "MULTI IO: multi_io_d=
ispatch a=3D%s mi=3D" ptr_format, pract(action),
diff --git a/src/openvpn/s=
sl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index 3653eb4=2E=2E6631718 10064=
4
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -925=
,6 +925,7 @@
 
             errno =3D 0;
             long timeout =3D strt=
ol(BSTR(timeout_buf), NULL, 10);
+            // cppcheck-suppress compareV=
alueOutOfTypeRangeError ; ULONG_MAX=3D=3DUINT_MAX on Windows
             i=
f (timeout <=3D 0 || (unsigned long)timeout > UINT_MAX || errno)
          =
   {
                 msg(M_WARN, "could not parse auth pending file timeou=
t");
diff --git a/src/openvpnserv/common=2Ec b/src/openvpnserv/common=2Ec
i=
ndex 7fc8c14=2E=2Ecce5318 100644
--- a/src/openvpnserv/common=2Ec
+++ b/src=
/openvpnserv/common=2Ec
@@ -22,6 +22,7 @@
 
 #include "service=2Eh"
 #inclu=
de "validate=2Eh"
+// cppcheck-suppress missingInclude ; we run cppcheck on=
 Linux w/o this file
 #include "eventmsg=2Eh"
 
 #include <pathcch=2Eh>
dif=
f --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec=

index 7819f5a=2E=2E4a38aa4 100644
--- a/src/openvpnserv/interactive=2Ec
++=
+ b/src/openvpnserv/interactive=2Ec
@@ -3601,6 +3601,7 @@
         goto out=
;
     }
     swprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),
+         =
    // cppcheck-suppress unknownMacro ; FP, complains about _L only here=2E=
=2E=2E
              L"\\\\=2E\\pipe\\" _L(PACKAGE) L"%ls\\service_%lu_%ls"=
, service_instance,
              GetCurrentThreadId(), pipe_uuid_str);
   =
  RpcStringFreeW(&pipe_uuid_str);
diff --git a/tests/unit_tests/openvpn/tes=
t_tls_crypt=2Ec b/tests/unit_tests/openvpn/test_tls_crypt=2Ec
index f648e13=
=2E=2Ef8aa199 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt=2Ec
+++ =
b/tests/unit_tests/openvpn/test_tls_crypt=2Ec
@@ -681,6 +681,7 @@
     stru=
ct buffer tmp =3D create_client_key_input(ctx, 12);
 
     /* Make the wrap=
ped key invalid by flipping a few bits */
+    // cppcheck-suppress syntaxE=
rror ; cppcheck is confused by this code
     buf_bptr(&tmp)[buf_len(&tmp) =
- 20] ^=3D 0x55;
 
     assert_false(tls_crypt_v2_extract_client_key(&tmp, =
&wrap_ctx, NULL));

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1953?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: Ie06d3543d0a5d4ca3d3fd6f41498e6917ab4c8a9
Gerrit-Change-Number: 1953
Gerr=
it-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-=
Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <=
razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>

--ONn9GOdpczg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1953?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">cppcheck: Clean up suppr=
essions to not annoy developers<br><br>Actually using it in CI has shown th=
at the line number<br>based suppression is just too annoying=2E Therefor:<b=
r><br>- Switch to XML based suppressions that allow us to<br>  use symbolNa=
me in addition to lineNumber to limit the<br>  suppression=2E<br>- Suppress=
 knownConditionTrueFalse always=2E There are just<br>  too many instances d=
ue to how our code is structured=2E<br>- Also remove some unused suppressio=
ns=2E<br>- Replace some suppressions with code fixes=2E These are<br>  gene=
rally speaking false positives but the code fix<br>  is less ugly than the =
suppression=2E<br>- Work around one issue with using PRIx64 macro in a<br> =
 pre-prepared format string by adding a definition in<br>  our library defi=
nition=2E<br>- All suppressions that remain that were still lineNumber<br> =
 based (due to the check not reporting a symbol), move<br>  to inline suppr=
essions=2E Inline suppressions are somewhat<br>  ugly, but these are very f=
ew and I see no better<br>  alternative=2E Maybe we can get rid of some of =
them by<br>  reporting issues to cppcheck=2E (Or, in some cases, by<br>  im=
proving our code)=2E<br><br>While here, make sure that we always run the Wi=
ndows scan<br>as well, so developers get complete feedback on first push=2E=
<br><br>Change-Id: Ie06d3543d0a5d4ca3d3fd6f41498e6917ab4c8a9<br>Signed-off-=
by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan C=
ojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1953<br>Message-Id: &lt;20260925213118=2E29507-1-gert@=
greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-dev=
el@lists=2Esourceforge=2Enet/msg39523=2Ehtml<br>Signed-off-by: Gert Doering=
 &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>D dev-tools/cppcheck-suppression=
<br>A dev-tools/cppcheck-suppressions=2Exml<br>M dev-tools/openvpn-cppcheck=
-library=2Ecfg<br>M dev-tools/run-cppcheck=2Esh<br>M src/openvpn/crypto=2Ec=
<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi_io=2Ec<br>M src/openvpn/=
ssl_verify=2Ec<br>M src/openvpnserv/common=2Ec<br>M src/openvpnserv/interac=
tive=2Ec<br>M tests/unit_tests/openvpn/test_tls_crypt=2Ec<br>11 files chang=
ed, 226 insertions(+), 124 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/53/1953/3</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppressio=
n</span><br><span>deleted file mode 100644</span><br><span>index 27c9d30=2E=
=2E0000000</span><br><span>--- a/dev-tools/cppcheck-suppression</span><br><=
span>+++ /dev/null</span><br><span>@@ -1,119 +0,0 @@</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# We start with --enable=3Dall, but then su=
ppress some issues that have too many</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-# occurences right now=2E They still should be fixed at som=
e point</span><br><span style=3D"color: hsl(0, 100%, 40%);">-constParameter=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-constParameterCallbac=
k</span><br><span style=3D"color: hsl(0, 100%, 40%);">-constParameterPointe=
r</span><br><span style=3D"color: hsl(0, 100%, 40%);">-invalidPrintfArgType=
_sint</span><br><span style=3D"color: hsl(0, 100%, 40%);">-invalidPrintfArg=
Type_uint</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unusedFuncti=
on</span><br><span style=3D"color: hsl(0, 100%, 40%);">-usleepCalled</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-variableScope</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-# We have a lot of library includes,=
 not all of them are really required,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-# so ignore them</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-missingIncludeSystem</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-# cppcheck doesn&#39;t understand about check_malloc_return, so t=
hese are</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# usually mis=
leading</span><br><span style=3D"color: hsl(0, 100%, 40%);">-nullPointerOut=
OfMemory</span><br><span style=3D"color: hsl(0, 100%, 40%);">-nullPointerAr=
ithmeticOutOfMemory</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# =
These are specific false-positives (FP) or ignored (IGN) issues</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-# We might want to move some of t=
hem to inline-suppression to avoid</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-# the static line-numbers</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-# IGN: posix=2Ecfg: We are not threadsafe</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-getgrnamCalled</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-getpwnamCalled</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-getservbynameCalled</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-localtimeCalled</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-# FP: posix=2Ecfg claims suseconds_t is unsigned for some =
reason</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unsignedLessTha=
nZero:src/openvpn/otime=2Eh:148</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-# IGN: multi code does weird things with pointers to local variab=
les=2E=2E=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-autoVaria=
bles:src/openvpn/multi=2Ec:4242</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-autoVariables:src/openvpn/multi_io=2Ec:324</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# IGN: the code header =3D 0 | (OPCODE &lt;=
&lt; P_OPCODE_SHIFT) is used intentionally</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-badBitmaskCheck:src/openvpn/mudp=2Ec</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-badBitmaskCheck:tests/unit_tests/openvp=
n/test_pkt=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# IGN: =
Windows specific (unsigned long =3D=3D unsigned int)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-compareValueOutOfTypeRangeError:src/openvpn=
/ssl_verify=2Ec:928</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# =
FP: cppcheck seems to have wrong signature of DeviceIoControl()</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-constVariablePointer:src/openvpn/=
dco_win=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# IGN: tes=
t_networking code would break with iproute2 but that is prevented</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-ctunullpointer:src/openvpn/netw=
orking_iproute2=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# =
IGN: event code uses a pointer to store integers</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-intToPointerCast:src/openvpn/forward=2Ec</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-intToPointerCast:src/openvpn/=
multi_io=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-intToPoin=
terCast:src/openvpn/ps=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-# FP: constant but differs between platforms</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-knownConditionTrueFalse:src/openvpn/error=2Eh:3=
82</span><br><span style=3D"color: hsl(0, 100%, 40%);">-knownConditionTrueF=
alse:src/openvpn/fdmisc=2Ec:80</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-knownConditionTrueFalse:src/openvpn/lladdr=2Ec:64</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-knownConditionTrueFalse:src/openvpn/pl=
atform=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: code =
needs to accomodate many different defines</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-knownConditionTrueFalse:src/openvpn/event=2Ec:1139</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-knownConditionTrueFalse:s=
rc/openvpn/event=2Ec:1148</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-# FP: dco_win support has &quot;false&quot; stubs</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-knownConditionTrueFalse:src/openvpn/forward=
=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-knownConditionTru=
eFalse:src/openvpn/init=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-knownConditionTrueFalse:src/openvpn/multi_io=2Ec:197</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-# FP: cppcheck thinks that some functi=
ons always return true, but they don&#39;t</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-knownConditionTrueFalse:src/openvpn/misc=2Ec:97</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-knownConditionTrueFalse:src/=
openvpn/sig=2Eh:116</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# =
FP: cert_uri_supported is a wrapper around defines, so it&#39;s</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-# always constant but differs dep=
ending on OpenSSL version</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-knownConditionTrueFalse:src/openvpn/ssl_openssl=2Ec:1260</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-# FP: cppcheck doesn&#39;t understan=
d that the function changes szErrMessage</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-knownConditionTrueFalse:src/tapctl/main=2Ec:704</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-knownConditionTrueFalse:src/op=
envpnmsica/dllmain=2Ec:164</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-# FP: cppcheck seems to be confused since we cast the pointer to integ=
er</span><br><span style=3D"color: hsl(0, 100%, 40%);">-memleak:src/plugins=
/down-root/down-root=2Ec:337</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-# IGN: we just abort instead</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-memleakOnRealloc:src/openvpn/dco_freebsd=2Ec:845</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-# FP: eventmsg=2Eh is not built on=
 Unix</span><br><span style=3D"color: hsl(0, 100%, 40%);">-missingInclude:s=
rc/openvpnserv/common=2Ec:25</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-# IGN: strlen(NULL) is not nice code, but seems to work</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-nullPointerRedundantCheck:src/open=
vpn/init=2Ec:301</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# FP:=
 cppcheck doesn&#39;t understand ZeroMemory</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-redundantAssignment:src/openvpnserv/interactive=2Ec:2=
04</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# IGN: We reuse the=
 same variable name due to macro usage</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-shadowVariable:src/openvpn/options=2Ec:1955</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-shadowVariable:src/openvpn/options=
=2Ec:1973</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: fun:tl=
s_crypt_v2_wrap_unwrap_invalid: cppcheck is confused</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-syntaxError:tests/unit_tests/openvpn/test_t=
ls_crypt=2Ec:684</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# FP:=
 this file is never compiled on _WIN32</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-umaskCalled:tests/unit_tests/openvpn/test_pkcs11=2Ec</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: yes, t_prev is unitia=
lized, but t_prev_len is 0, so that&#39;s handled</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-uninitvar:src/openvpn/crypto_epoch=2Ec:60</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: yes, parm is unitiali=
zed, but parm_len is 0, so that&#39;s handled</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-uninitvar:src/openvpn/options_parse=2Ec:148</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: uninit is fine when it =
is a return parameter</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
ctuuninitvar:src/openvpn/crypto_mbedtls_legacy=2Ec:690</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-uninitvar:src/openvpnserv/interactive=2Ec:=
2783</span><br><span style=3D"color: hsl(0, 100%, 40%);">-uninitvar:src/tap=
ctl/main=2Ec:566</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# FP:=
 weird parse error, the macro is fine in the rest of the file</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-unknownMacro:src/openvpnserv/intera=
ctive=2Ec:3604</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: c=
ppcheck doesn&#39;t account for short-circuiting</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-unreadVariable:src/openvpn/manage=2Ec:682</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-unusedFunction:src/openvpn/s=
iphash_reference=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
 FP: exported as DLL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-u=
nusedFunction:src/openvpnmsica/*=2Ec</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-# FP: loaded as plugins</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-unusedFunction:src/plugins/*</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-unusedFunction:sample/sample-plugins/*</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-# FP: wmain</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-unusedFunction:src/tapctl/main=2Ec:613</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-unusedFunction:tests/unit_=
tests/openvpnserv/test_openvpnserv=2Ec</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-# IGN: keep mocking around for future use</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-unusedFunction:tests/unit_tests/openvp=
n/mock_msg=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unusedF=
unction:/usr/include/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-# FP: cppcheck doesn&#39;t know the NLA macros</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-unusedLabel:src/openvpn/dco_linux=2Ec</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-# IGN: old code that is difficult=
 to test (MSG_ERRQUEUE), ignore for now</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-unusedStructMember:src/openvpn/mtu=2Ec:289</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-# FP: used implictly by NL macros</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-unusedStructMember:src/o=
penvpn/networking_sitnl=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-# IGN: keep explanatory fields in test data</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-unusedStructMember:tests/unit_tests/openvpn/tes=
t_pkcs11=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# IGN: ni=
cer to assign generic &quot;arg&quot; early</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-variableScope:src/openvpn/networking_sitnl=2Ec:1390</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-# IGN: nicer to keep th=
e &quot;variable&quot; earlier</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-variableScope:src/openvpnserv/interactive=2Ec:2687</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-# FP: fun:platform_create_temp_file: =
cppcheck is confused</span><br><span style=3D"color: hsl(0, 100%, 40%);">-w=
rongPrintfScanfArgNum:src/openvpn/platform=2Ec:553</span><br><span>diff --g=
it a/dev-tools/cppcheck-suppressions=2Exml b/dev-tools/cppcheck-suppression=
s=2Exml</span><br><span>new file mode 100644</span><br><span>index 0000000=
=2E=2E73dd41b</span><br><span>--- /dev/null</span><br><span>+++ b/dev-tools=
/cppcheck-suppressions=2Exml</span><br><span>@@ -0,0 +1,209 @@</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+&lt;?xml version=3D&quot;1=2E0&q=
uot;?&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+&lt;suppre=
ssions&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!--=
 We start with enable=3Dall, but then suppress some issues that have too ma=
ny</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       occurences=
 right now=2E They still should be fixed at some point --&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;constParameter&lt;/i=
d&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppres=
s&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;c=
onstParameterCallback&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;invalidPrintfArgType_si=
nt&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;=
/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;=
suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt=
;id&gt;invalidPrintfArgType_uint&lt;/id&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    &lt;id&gt;unusedFunction&lt;/id&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;usleepCalled&lt;/id=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;va=
riableScope&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  &lt;!-- We have a lot of library includes, not all of them are really =
required,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       so =
ignore them --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &lt;id&gt;missingIncludeSystem&lt;/id&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  &lt;!-- cppcheck doesn&#39;t understand about che=
ck_malloc_return, so these are</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+       usually misleading --&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    &lt;id&gt;nullPointerOutOfMemory&lt;/id&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;nullPointer=
ArithmeticOutOfMemory&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  &lt;!-- These are specific false-positives (FP) or ignored (=
IGN) issues</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       W=
e might want to move some of them to inline-suppression to avoid</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+       the static line-numbers=
 --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IG=
N: posix=2Ecfg: We are not threadsafe --&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    &lt;id&gt;getgrnamCalled&lt;/id&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;getpwnamCalled&lt;=
/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppr=
ess&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppre=
ss&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt=
;getservbynameCalled&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    &lt;id&gt;localtimeCalled&lt;/id&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: too many false-positives d=
ue to platform-specific code --&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    &lt;id&gt;knownConditionTrueFalse&lt;/id&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: posix=2Ecfg claim=
s suseconds_t is unsigned for some reason --&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    &lt;id&gt;unsignedLessThanZero&lt;/id&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;s=
rc/openvpn/otime=2Eh&lt;/fileName&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    &lt;symbolName&gt;usec&lt;/symbolName&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: the code header =
=3D 0 | (OPCODE &lt;&lt; P_OPCODE_SHIFT) is used intentionally --&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;badBitmaskCh=
eck&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &=
lt;fileName&gt;src/openvpn/mudp=2Ec&lt;/fileName&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;badBitmaskCheck&lt;/id&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;=
tests/unit_tests/openvpn/test_pkt=2Ec&lt;/fileName&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: cppcheck seems to have wro=
ng signature of DeviceIoControl() --&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    &lt;id&gt;constVariablePointer&lt;/id&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openv=
pn/dco_win=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    &lt;symbolName&gt;buf&lt;/symbolName&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: test_networking code wo=
uld break with iproute2 but that is prevented --&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;ctunullpointer&lt;/id&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;s=
rc/openvpn/networking_iproute2=2Ec&lt;/fileName&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: event code uses a pointer =
to store integers --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    &lt;id&gt;intToPointerCast&lt;/id&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/forward=2Ec&lt;/f=
ileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/s=
uppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;su=
ppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;i=
d&gt;intToPointerCast&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    &lt;fileName&gt;src/openvpn/multi_io=2Ec&lt;/fileName&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;intToPo=
interCast&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &lt;fileName&gt;src/openvpn/ps=2Ec&lt;/fileName&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: cppcheck seems to be con=
fused since we cast the pointer to integer --&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    &lt;id&gt;memleak&lt;/id&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/plugins/d=
own-root/down-root=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    &lt;symbolName&gt;context=2Ecommand&lt;/symbolName&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: w=
e just abort instead --&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    &lt;id&gt;memleakOnRealloc&lt;/id&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/dco_freebsd=2E=
c&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   &lt;symbolName&gt;buf&lt;/symbolName&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  &lt;!-- IGN: strlen(NULL) is not nice code, but s=
eems to work --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   &lt;id&gt;nullPointerRedundantCheck&lt;/id&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/init=2Ec&lt;/=
fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt=
;symbolName&gt;parameters&lt;/symbolName&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  &lt;!-- FP: cppcheck doesn&#39;t understand Zero=
Memory --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;=
suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt=
;id&gt;redundantAssignment&lt;/id&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    &lt;fileName&gt;src/openvpnserv/interactive=2Ec&lt;/f=
ileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;=
symbolName&gt;overlapped-&amp;gt;hEvent&lt;/symbolName&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: We reuse the same var=
iable name due to macro usage --&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    &lt;id&gt;shadowVariable&lt;/id&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/options=
=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    &lt;symbolName&gt;use_err&lt;/symbolName&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: this file is never compiled on=
 _WIN32 --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt=
;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &l=
t;id&gt;umaskCalled&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    &lt;fileName&gt;tests/unit_tests/openvpn/test_pkcs11=2Ec&lt;=
/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;=
/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;=
!-- FP: yes, t_prev is unitialized, but t_prev_len is 0, so that&#39;s hand=
led --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;sup=
press&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id=
&gt;uninitvar&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    &lt;fileName&gt;src/openvpn/crypto_epoch=2Ec&lt;/fileName&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;t_=
prev&lt;/symbolName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  &lt;!-- FP: yes, parm is unitialized, but parm_len is 0, so that&#39;=
s handled --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &=
lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
&lt;id&gt;uninitvar&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    &lt;fileName&gt;src/openvpn/options_parse=2Ec&lt;/fileName&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolNam=
e&gt;parm&lt;/symbolName&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  &lt;!-- FP: uninit is fine when it is a return parameter --&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;uninitv=
ar&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &l=
t;fileName&gt;src/openvpnserv/interactive=2Ec&lt;/fileName&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;addr_list&=
lt;/symbolName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &lt;id&gt;uninitvar&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    &lt;fileName&gt;src/tapctl/main=2Ec&lt;/fileName&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;gui=
dAdapter&lt;/symbolName&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  &lt;!-- FP: cppcheck doesn&#39;t account for short-circuiting --&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;unr=
eadVariable&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    &lt;fileName&gt;src/openvpn/manage=2Ec&lt;/fileName&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;n&lt;/symb=
olName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/su=
ppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!--=
 FP: exported as DLL --&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    &lt;id&gt;unusedFunction&lt;/id&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpnmsica/*=2Ec&lt;/f=
ileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/s=
uppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-=
- FP: loaded as plugins --&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    &lt;id&gt;unusedFunction&lt;/id&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/plugins/*&lt;/fileNam=
e&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppres=
s&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;u=
nusedFunction&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    &lt;fileName&gt;sample/sample-plugins/*&lt;/fileName&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: keep mocking a=
round for future use --&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    &lt;id&gt;unusedFunction&lt;/id&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    &lt;fileName&gt;tests/unit_tests/openvpn/moc=
k_msg=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    &lt;id&gt;unusedFunction&lt;/id&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    &lt;fileName&gt;/usr/include/*&lt;/fileName&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: cpp=
check doesn&#39;t know the NLA macros --&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    &lt;id&gt;unusedLabel&lt;/id&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/dc=
o_linux=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  &lt;!-- IGN: old code that is difficult to test (MSG_ERRQUEUE), =
ignore for now --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &lt;id&gt;unusedStructMember&lt;/id&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/mtu=2Ec&lt;/fileNa=
me&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbo=
lName&gt;probehdr::ttl&lt;/symbolName&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  &lt;!-- FP: used implictly by NL macros --&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;unusedStruc=
tMember&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   &lt;fileName&gt;src/openvpn/networking_sitnl=2Ec&lt;/fileName&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: keep explan=
atory fields in test data --&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    &lt;id&gt;unusedStructMember&lt;/id&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;tests/unit_tests/op=
envpn/test_pkcs11=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+&lt;/suppressions&gt;</span><br><span>diff --git a/dev-t=
ools/openvpn-cppcheck-library=2Ecfg b/dev-tools/openvpn-cppcheck-library=2E=
cfg</span><br><span>index decac67=2E=2E0537b39 100644</span><br><span>--- a=
/dev-tools/openvpn-cppcheck-library=2Ecfg</span><br><span>+++ b/dev-tools/o=
penvpn-cppcheck-library=2Ecfg</span><br><span>@@ -28,4 +28,7 @@</span><br><=
span>   &lt;define name=3D&quot;CMSG_NXTHDR&quot; value=3D&quot;cmsg_nxthdr=
&quot; /&gt;</span><br><span>   &lt;!-- otherwise a lot of unused variables=
 are shown for enable-small builds --&gt;</span><br><span>   &lt;define nam=
e=3D&quot;DMSG_ALWAYS_AVAILABLE&quot; value=3D&quot;1&quot; /&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- cppcheck understand=
s it directly in format string, but not</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+       indirectly when the format string is constructed=
 earlier --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &l=
t;define name=3D&quot;PRIx64&quot; value=3D&quot;&amp;quot;lx&amp;quot;&quo=
t; /&gt;</span><br><span> &lt;/def&gt;</span><br><span>diff --git a/dev-too=
ls/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh</span><br><span>index 37=
de267=2E=2E4c4ba2c 100755</span><br><span>--- a/dev-tools/run-cppcheck=2Esh=
</span><br><span>+++ b/dev-tools/run-cppcheck=2Esh</span><br><span>@@ -30,7=
 +30,7 @@</span><br><span>  --enable=3Dall ${disable_arg} \</span><br><span=
>  --library=3D${SCRIPT_DIR}/openvpn-cppcheck-library=2Ecfg \</span><br><sp=
an>  --library=3Dopenssl=2Ecfg \</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- --suppressions-list=3D${SCRIPT_DIR}/cppcheck-suppression \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ --suppress-xml=3D${SCRI=
PT_DIR}/cppcheck-suppressions=2Exml --inline-suppr \</span><br><span>  --cp=
pcheck-build-dir=3D${CPPCHECK_DIR} \</span><br><span>  --check-level=3D${CP=
PCHECK_CHECK_LEVEL} --max-configs=3D10 \</span><br><span>  --error-exitcode=
=3D1 --showtime=3Dsummary&quot;</span><br><span>@@ -39,13 +39,14 @@</span><=
br><span> </span><br><span> mkdir -p &quot;$CPPCHECK_DIR&quot;</span><br><s=
pan> cd &quot;${SOURCE_DIR}&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ret=3D0</span><br><span> cppcheck $COMMON_ARGS $INCLUDE_FLAGS=
 \</span><br><span>     --platform=3Dunix64 \</span><br><span>     --librar=
y=3Dposix=2Ecfg --library=3Dbsd=2Ecfg --library=3Dgnu=2Ecfg \</span><br><sp=
an>     -U_WIN32 \</span><br><span>     src/openvpn/ src/compat/ src/plugin=
s/ sample/ \</span><br><span>     tests/unit_tests/example_test/ tests/unit=
_tests/openvpn/ \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
tests/unit_tests/plugins/</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    tests/unit_tests/plugins/ || ret=3D$?</span><br><span> cppcheck $=
COMMON_ARGS \</span><br><span>     --platform=3Dwin64 \</span><br><span>   =
  --library=3Dwindows=2Ecfg \</span><br><span>@@ -55,4 +56,6 @@</span><br><=
span>     -UTARGET_AIX \</span><br><span>     -UOPENSSL_NO_EC \</span><br><=
span>     src/openvpn* src/compat/ \</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    tests/unit_tests/example_test/ tests/unit_tests/openvpn*=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tests/unit_test=
s/example_test/ tests/unit_tests/openvpn* || ret=3D$?</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+exit $ret</span><br><span>diff --git a/src/openvpn/crypto=2E=
c b/src/openvpn/crypto=2Ec</span><br><span>index e5ad31a=2E=2Edc22af5 10064=
4</span><br><span>--- a/src/openvpn/crypto=2Ec</span><br><span>+++ b/src/op=
envpn/crypto=2Ec</span><br><span>@@ -268,7 +268,7 @@</span><br><span>      =
       }</span><br><span> </span><br><span>             /* Encrypt packet I=
D, payload */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    int outlen;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        int outlen =3D 0;</span><br><span>             ASSERT(cipher_ctx_up=
date(ctx-&gt;cipher, BEND(&amp;work), &amp;outlen, BPTR(buf), BLEN(buf)));<=
/span><br><span>             ASSERT(buf_inc_len(&amp;work, outlen));</span>=
<br><span> </span><br><span>@@ -566,7 +566,7 @@</span><br><span>     dmsg(D=
_PACKET_CONTENT, &quot;DECRYPT AD: %s&quot;, format_hex(ad_start, ad_size, =
0, &amp;gc));</span><br><span> </span><br><span>     /* Decrypt and authent=
icate packet */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in=
t outlen;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ou=
tlen =3D 0;</span><br><span>     if (!cipher_ctx_update(ctx-&gt;cipher, BPT=
R(&amp;work), &amp;outlen, BPTR(buf), data_len))</span><br><span>     {</sp=
an><br><span>         CRYPT_ERROR(&quot;packet decryption failed&quot;);</s=
pan><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</s=
pan><br><span>index fd54946=2E=2Ea6fadf6 100644</span><br><span>--- a/src/o=
penvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><spa=
n>@@ -4239,6 +4239,7 @@</span><br><span>     struct multi_context multi;</s=
pan><br><span> </span><br><span>     top-&gt;mode =3D CM_TOP;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    // cppcheck-suppress autoVari=
ables ; yes, we know this is dangerous</span><br><span>     top-&gt;multi =
=3D &amp;multi;</span><br><span>     context_clear_2(top);</span><br><span>=
 </span><br><span>diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi=
_io=2Ec</span><br><span>index 4b96c57=2E=2Ebce5018 100644</span><br><span>-=
-- a/src/openvpn/multi_io=2Ec</span><br><span>+++ b/src/openvpn/multi_io=2E=
c</span><br><span>@@ -321,6 +321,7 @@</span><br><span> {</span><br><span>  =
   const unsigned int mpp_flags =3D MPP_PRE_SELECT | MPP_RECORD_TOUCH;</spa=
n><br><span>     struct multi_instance *touched =3D mi;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    // cppcheck-suppress autoVariables =
; yes, we know this is dangerous</span><br><span>     m-&gt;mpp_touched =3D=
 &amp;touched;</span><br><span> </span><br><span>     dmsg(D_MULTI_DEBUG, &=
quot;MULTI IO: multi_io_dispatch a=3D%s mi=3D&quot; ptr_format, pract(actio=
n),</span><br><span>diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/s=
sl_verify=2Ec</span><br><span>index 3653eb4=2E=2E6631718 100644</span><br><=
span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/src/openvpn/ssl=
_verify=2Ec</span><br><span>@@ -925,6 +925,7 @@</span><br><span> </span><br=
><span>             errno =3D 0;</span><br><span>             long timeout =
=3D strtol(BSTR(timeout_buf), NULL, 10);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            // cppcheck-suppress compareValueOutOfType=
RangeError ; ULONG_MAX=3D=3DUINT_MAX on Windows</span><br><span>           =
  if (timeout &lt;=3D 0 || (unsigned long)timeout &gt; UINT_MAX || errno)</=
span><br><span>             {</span><br><span>                 msg(M_WARN, =
&quot;could not parse auth pending file timeout&quot;);</span><br><span>dif=
f --git a/src/openvpnserv/common=2Ec b/src/openvpnserv/common=2Ec</span><br=
><span>index 7fc8c14=2E=2Ecce5318 100644</span><br><span>--- a/src/openvpns=
erv/common=2Ec</span><br><span>+++ b/src/openvpnserv/common=2Ec</span><br><=
span>@@ -22,6 +22,7 @@</span><br><span> </span><br><span> #include &quot;se=
rvice=2Eh&quot;</span><br><span> #include &quot;validate=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+// cppcheck-suppress missing=
Include ; we run cppcheck on Linux w/o this file</span><br><span> #include =
&quot;eventmsg=2Eh&quot;</span><br><span> </span><br><span> #include &lt;pa=
thcch=2Eh&gt;</span><br><span>diff --git a/src/openvpnserv/interactive=2Ec =
b/src/openvpnserv/interactive=2Ec</span><br><span>index 7819f5a=2E=2E4a38aa=
4 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</span><br><s=
pan>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -3601,6 +3601,=
7 @@</span><br><span>         goto out;</span><br><span>     }</span><br><s=
pan>     swprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+             // cppcheck-suppress u=
nknownMacro ; FP, complains about _L only here=2E=2E=2E</span><br><span>   =
           L&quot;\\\\=2E\\pipe\\&quot; _L(PACKAGE) L&quot;%ls\\service_%lu=
_%ls&quot;, service_instance,</span><br><span>              GetCurrentThrea=
dId(), pipe_uuid_str);</span><br><span>     RpcStringFreeW(&amp;pipe_uuid_s=
tr);</span><br><span>diff --git a/tests/unit_tests/openvpn/test_tls_crypt=
=2Ec b/tests/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>index f6=
48e13=2E=2Ef8aa199 100644</span><br><span>--- a/tests/unit_tests/openvpn/te=
st_tls_crypt=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_tls_cr=
ypt=2Ec</span><br><span>@@ -681,6 +681,7 @@</span><br><span>     struct buf=
fer tmp =3D create_client_key_input(ctx, 12);</span><br><span> </span><br><=
span>     /* Make the wrapped key invalid by flipping a few bits */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    // cppcheck-suppress sy=
ntaxError ; cppcheck is confused by this code</span><br><span>     buf_bptr=
(&amp;tmp)[buf_len(&amp;tmp) - 20] ^=3D 0x55;</span><br><span> </span><br><=
span>     assert_false(tls_crypt_v2_extract_client_key(&amp;tmp, &amp;wrap_=
ctx, NULL));</span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1953?usp=3Demail">change 1953</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1953?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie06d3543d0a5d4ca3=
d3fd6f41498e6917ab4c8a9 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1953 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<=
div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--ONn9GOdpczg=--


--===============2578442967885850391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2578442967885850391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2578442967885850391==--

