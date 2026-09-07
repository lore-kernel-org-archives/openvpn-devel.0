Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4244AC79F99
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ufd5E86Ra8x81PPVcQ2S0FB8t6iflIp3wCuRAPzttwA=; b=UWXQlgi/j6tWdqLyVKSvG46Jhl
	9ftmSA6P5fW6HAaKL6REDcauFsiBaRz8WhjXvFPm80qjlboxQERmDuh58DFzk0MDU1P3LluKAKHQz
	RBRRuaKUB7zgY95vE4DMK3Mj6LTdjxNCKPYQaDYtc6Z4v2kDR+qKrYwE79f7hElp4Ceg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3bmu-0008Fd-35;
	Mon, 07 Sep 2026 16:01:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3bms-0008FW-M7
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 16:01:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=c3wLhr4AASuLNngMUpN6osWurQpkAs4ozoN+zlQlthI=; b=V1ZaqVYlbv19AiVYHY8cdg2PAm
 HLJ7NcSrKphqy+rebqRfM4Ss1yNmeieROEXSX3PkCpVJovWbz/xAeZqz9fqKw2qnPF4YIkfq91/G0
 2Dwb05d2lTrn9ORk1kLJ14Rg0PXA/ERL3F+NpQhFPFzEeP2m/3QhfBAtNvk/NiyMVRtI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=c3wLhr4AASuLNngMUpN6osWurQpkAs4ozoN+zlQlthI=; b=D
 wCaC8XjQRZHUa2Wk3OzZkTYajgDwq6HLFKKXEB4tiEXH0P7h/r0X8itFrntGE/TLJ4eNqtd1YxwEz
 6JStRePoHp8iiul4+Qj5ZqHdNK+DwKvzOnx4amElaQlS4/nyGJ+5winq3QH3fIeILUpaQcBGF4XbF
 23N4cN9dN47iiDoQ=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3bmq-0005uN-DM for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 16:01:39 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-482f2ee53e7so2748978f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 09:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788796890; x=1789401690; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=c3wLhr4AASuLNngMUpN6osWurQpkAs4ozoN+zlQlthI=;
 b=UVTuSimBuAIVfOYBuSChFP7pQXmg2Tm0vyu6yjN2HnJf5ZWIkJ12BvYDoDDIh1NB5w
 ZJuYc5c65JuLDumz3RfGeDHw2UOz1IezCDpxJYJ8/yj5C5MeYVcxp9A9m+yId/RR9ogk
 Npb29Hb/QI4qkAUzJXdGjQbTvilCgO0rcIIvJYRbzwdb73BYwTQ/jrBrPR5W+drw8NTm
 idxgKhl9gFf9t3X2Vf3+jJs0MJT/3J9IGDkkYlI3JJ1EDnElcnzuqw9ObfFboI0fvvrV
 6PPtpvozJvn8Uvz87f/SkupvTKEYpK+NyS1mY4JxHIQUGJVSm18kHmy+kXlwT4TSN+TS
 IDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788796890; x=1789401690;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=c3wLhr4AASuLNngMUpN6osWurQpkAs4ozoN+zlQlthI=;
 b=g45wkGB4f6GEr9qQOTRjCGN7Tad+uvr19EUeaXaBzvySvqCUR2uTT9MtzPGrhuqKFG
 P5oJJ9KFh1A4qfOFZtVOgCedkTuBB0yzNcfHpCmRIrqOpqJObyUicy+7tGlqkdfI8uNI
 AKJTn2k+CWFcp9ram/xTraDOoxPZZRP/wltZ3GxeOroLGQwXqNPeBM1xvRCRwhE/8Wmr
 ypQiK4IbIhdee0CDKGaE36QtJJD7CCc0FkisVT/4NeJF5Y3xpmIumO93arZmQ2x2Igun
 bTENFo8u5jGAFE4m0WiTSBt2VbXx7ssXCQdNIwA/lHh8MvN3d4uR0dndNKhWVPhbYjzE
 SmQw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxdmuNwtnul0PspdRhWzEmi73jJikblMs3pNpozYQVwevNa1MBgIatoXiFycdXar1Jw7W0+ByZITK6xeYPg@lists.sourceforge.net
X-Gm-Message-State: AFuF++m52TWxQyqvFdY/NhZmD4oWk+FlNBYN7YXkvXxjFMl24TDQBrLs
 ArosBgkm+xsm2z5HVa8Jzr2B9uGa7yRikkTyZ+GLxd81PCXPpnZUeKfv7o82MyWupOhzoELutjL
 17GNfSPTHi+wTB8l2o9oEeRyLLj7zHOt0Z/i1ifUL6kiTBB5YVnbNFz1UCnqcJ7GUJ/0r
X-Gm-Gg: AYBFou3HCKd42qb5R3/X13qk2rbnkLs317D44I5My7vYNq3P9CGJsuiNq9/4HRqUMWm
 3eosr54ezeOiL8po/3dbXmxf1AmLhhHYWsLylwsiTSHw4HCwMFNAxHWxxCHA4mTE142iz5b2XIV
 oHOcp+xZV9oVJO31vDq1a7y+ti0SarAd6J8TVk676ni33KQ8bRqgLwD5ux9D7Mw9IYlhCtHGm9f
 NIPH1JTS5y5zTbOiHIPoJAeFSYqdxu4/iOBOus18oQpMuW8ihlyU7bSJJ2HtK0+RmY2gVbyuUoR
 JPj6egP+UFbX4L/XAcYfJT2FEcixql6RsQEfPQKW+7KNE9JCIZ2Z8PwAAtOQjH5GIJtNJjItqwA
 pq57J/x7zkZWapBGYAN0rKmP3NDsw3Tl7w/oncA9qq5RXO622Y6F6gZEehEwrwu+wIwO+LJFQom
 p8id14dU9TpNPT5wrSOVBT02tB1idaMWo5niGB7s1bwTyeWVOTfFb7AL8uBHy3ZKm6swTfLEdCJ
 I+gGIvB85MiAkawj0dTiNYLd1ao3s5ApBtuWO2u3hYehGtAbTGBXFx2iKKpVd2mP8KwDCvb/LHq
 jbQxyw2+L7qcFA68OxQalU4ARrMGz7FJ+SwOdQ+hz4ACwBuGSCa218dV+W6mHw==
X-Received: by 2002:a05:600c:4fc3:b0:49d:16f1:94a5 with SMTP id
 5b1f17b1804b1-49d16f19576mr23870225e9.25.1788796889701; 
 Mon, 07 Sep 2026 09:01:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cffdb2c40sm189339645e9.1.2026.09.07.09.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:01:29 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 16:01:27 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I65beb37a2d822333aa888de1baf11dfcb8490e90
X-Gerrit-Change-Number: 1868
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1868?usp=email>
X-Gerrit-Commit: 6c839553075328e0103ee33d0fb6c26f1e50a2e2
In-Reply-To: <gerrit.1787672720000.I65beb37a2d822333aa888de1baf11dfcb8490e90@gerrit.openvpn.net>
References: <gerrit.1787672720000.I65beb37a2d822333aa888de1baf11dfcb8490e90@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NjcyNzIwMDAwLkk2NWJlYjM3YTJkODIyMzMzYWE4ODhkZTFiYWYxMWRmY2I4NDkwZTkwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d22c57fe72647d0dabd6c1a60ff27c08226f3539-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3bmq-0005uN-DM
Subject: [Openvpn-devel] [S] Change in openvpn[master]: run-cppcheck.sh:
 Make it more configurable
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2647122687534534068=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2647122687534534068==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NqE4rj3VC54="; charset=UTF-8

--NqE4rj3VC54=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

Hello plaistho=
s, 

I'd like you to reexamine a change=2E Please visit

    http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1868?usp=3Demail

to look at the new patch set=
 (#3)=2E


Change subject: run-cppcheck=2Esh: Make it more configurable
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

run-cppcheck=2Es=
h: Make it more configurable

- Allow to easily control verbosity and autom=
atically
  adjust to the verbosity of the Make run
- Allow to easily contro=
l check level=2E With exhaustive the
  check can take hours (due to options=
=2Ec), so we couldn't
  use that in CI

v3:
- Use AM_V_P instead of V to co=
rrectly reflect
  AM_DEFAULT_VERBOSITY

Change-Id: I65beb37a2d822333aa888de=
1baf11dfcb8490e90
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom=
>
---
M Makefile=2Eam
M dev-tools/run-cppcheck=2Esh
2 files changed, 19 ins=
ertions(+), 3 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/68/1868/3

diff --git a/Makefile=2Eam b/Makefile=2Eam
=
index feeaabb=2E=2Edd6cee6 100644
--- a/Makefile=2Eam
+++ b/Makefile=2Eam
@=
@ -96,4 +96,5 @@
 	BUILD_DIR=3D"$(abs_top_builddir)" \
 	SOURCE_DIR=3D"$(ab=
s_top_srcdir)" \
 	INCLUDE_FLAGS=3D"$(LIBNL_GENL_CFLAGS)" \
+	CPPCHECK_VERB=
OSE=3D"$(AM_V_P)" \
 		"$(top_srcdir)/dev-tools/run-cppcheck=2Esh"
diff --g=
it a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh
index a7aa3c=
4=2E=2Efc14405 100755
--- a/dev-tools/run-cppcheck=2Esh
+++ b/dev-tools/run=
-cppcheck=2Esh
@@ -2,22 +2,37 @@
 
 set -eu
 
+: ${CPPCHECK_VERBOSE:=3Dfals=
e}
+: ${CPPCHECK_CHECK_LEVEL:=3Dexhaustive}
+
+if "${CPPCHECK_VERBOSE}"; th=
en
+    verbosity_arg=3D"-v"
+else
+    verbosity_arg=3D"-q"
+fi
+
+disable=
_arg=3D
+if [ "${CPPCHECK_CHECK_LEVEL}" !=3D exhaustive ]; then
+    # supp=
ress all the information that we should use exhaustive
+    disable_arg=3D"=
--disable=3Dinformation"
+fi
+
 SCRIPT_DIR=3D$(dirname $(readlink -e "${BAS=
H_SOURCE[0]}"))
 : ${SOURCE_DIR:=3D$SCRIPT_DIR/=2E=2E}
 : ${BUILD_DIR:=3D$P=
WD}
 : ${INCLUDE_FLAGS:=3D}
 CPPCHECK_DIR=3D"${BUILD_DIR}/cppcheck_build_di=
r"
-COMMON_ARGS=3D"-j$(nproc) -q \
+COMMON_ARGS=3D"-j$(nproc) ${verbosity_a=
rg} \
  -DMBEDTLS_SSL_PROTO_TLS1_3 -DMBEDTLS_SSL_KEYING_MATERIAL_EXPORT \
 =
 -I=2E/include/ -I=2E/tests/unit_tests/openvpn/ \
  -I=2E/src/compat/ -I=2E=
/src/openvpn/ -I=2E/src/openvpnserv/ -I=2E/src/plugins/auth-pam/ \
  -I${BU=
ILD_DIR} -I${BUILD_DIR}/include/ \
- --enable=3Dall \
+ --enable=3Dall ${di=
sable_arg} \
  --library=3D${SCRIPT_DIR}/openvpn-cppcheck-library=2Ecfg \
 =
 --library=3Dopenssl=2Ecfg \
  --suppressions-list=3D${SCRIPT_DIR}/cppcheck=
-suppression \
  --cppcheck-build-dir=3D${CPPCHECK_DIR} \
- --check-level=
=3Dexhaustive --max-configs=3D10 \
+ --check-level=3D${CPPCHECK_CHECK_LEVEL=
} --max-configs=3D10 \
  --error-exitcode=3D1"
 
 set -x

-- 
To view, visi=
t http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1868?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I65beb37a2d822333aa888de1baf11dfcb8=
490e90
Gerrit-Change-Number: 1868
Gerrit-PatchSet: 3
Gerrit-Owner: flichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eo=
rg>

--NqE4rj3VC54=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p>flichtenheld <strong>up=
loaded patch set #3</strong> to this change=2E</p><p><a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1868?usp=3Demail">View Change</a></p><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">run-cppcheck=2Esh: Make it more configurable<br><br>- Allow to easil=
y control verbosity and automatically<br>  adjust to the verbosity of the M=
ake run<br>- Allow to easily control check level=2E With exhaustive the<br>=
  check can take hours (due to options=2Ec), so we couldn&#39;t<br>  use th=
at in CI<br><br>v3:<br>- Use AM_V_P instead of V to correctly reflect<br>  =
AM_DEFAULT_VERBOSITY<br><br>Change-Id: I65beb37a2d822333aa888de1baf11dfcb84=
90e90<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<b=
r>---<br>M Makefile=2Eam<br>M dev-tools/run-cppcheck=2Esh<br>2 files change=
d, 19 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/68/1868/3</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/Makefile=2Eam b/Makefile=2Eam</span><br><span>index feeaabb=2E=2Ed=
d6cee6 100644</span><br><span>--- a/Makefile=2Eam</span><br><span>+++ b/Mak=
efile=2Eam</span><br><span>@@ -96,4 +96,5 @@</span><br><span> 	BUILD_DIR=3D=
&quot;$(abs_top_builddir)&quot; \</span><br><span> 	SOURCE_DIR=3D&quot;$(ab=
s_top_srcdir)&quot; \</span><br><span> 	INCLUDE_FLAGS=3D&quot;$(LIBNL_GENL_=
CFLAGS)&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	CPP=
CHECK_VERBOSE=3D&quot;$(AM_V_P)&quot; \</span><br><span> 		&quot;$(top_srcd=
ir)/dev-tools/run-cppcheck=2Esh&quot;</span><br><span>diff --git a/dev-tool=
s/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh</span><br><span>index a7a=
a3c4=2E=2Efc14405 100755</span><br><span>--- a/dev-tools/run-cppcheck=2Esh<=
/span><br><span>+++ b/dev-tools/run-cppcheck=2Esh</span><br><span>@@ -2,22 =
+2,37 @@</span><br><span> </span><br><span> set -eu</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+: ${CPPCHECK_VERBOSE:=3Df=
alse}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+: ${CPPCHECK_C=
HECK_LEVEL:=3Dexhaustive}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if &quot;${CP=
PCHECK_VERBOSE}&quot;; then</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    verbosity_arg=3D&quot;-v&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+else</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    verbosity_arg=3D&quot;-q&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+fi</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+disable_arg=
=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ &quot;${CPP=
CHECK_CHECK_LEVEL}&quot; !=3D exhaustive ]; then</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    # suppress all the information that we sho=
uld use exhaustive</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   disable_arg=3D&quot;--disable=3Dinformation&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> SCRIPT_DIR=3D$(dirname $(readlink -e &qu=
ot;${BASH_SOURCE[0]}&quot;))</span><br><span> : ${SOURCE_DIR:=3D$SCRIPT_DIR=
/=2E=2E}</span><br><span> : ${BUILD_DIR:=3D$PWD}</span><br><span> : ${INCLU=
DE_FLAGS:=3D}</span><br><span> CPPCHECK_DIR=3D&quot;${BUILD_DIR}/cppcheck_b=
uild_dir&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-COMMON_=
ARGS=3D&quot;-j$(nproc) -q \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+COMMON_ARGS=3D&quot;-j$(nproc) ${verbosity_arg} \</span><br><span>=
  -DMBEDTLS_SSL_PROTO_TLS1_3 -DMBEDTLS_SSL_KEYING_MATERIAL_EXPORT \</span><=
br><span>  -I=2E/include/ -I=2E/tests/unit_tests/openvpn/ \</span><br><span=
>  -I=2E/src/compat/ -I=2E/src/openvpn/ -I=2E/src/openvpnserv/ -I=2E/src/pl=
ugins/auth-pam/ \</span><br><span>  -I${BUILD_DIR} -I${BUILD_DIR}/include/ =
\</span><br><span style=3D"color: hsl(0, 100%, 40%);">- --enable=3Dall \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ --enable=3Dall ${disa=
ble_arg} \</span><br><span>  --library=3D${SCRIPT_DIR}/openvpn-cppcheck-lib=
rary=2Ecfg \</span><br><span>  --library=3Dopenssl=2Ecfg \</span><br><span>=
  --suppressions-list=3D${SCRIPT_DIR}/cppcheck-suppression \</span><br><spa=
n>  --cppcheck-build-dir=3D${CPPCHECK_DIR} \</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- --check-level=3Dexhaustive --max-configs=3D10 \</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ --check-level=3D${CPPC=
HECK_CHECK_LEVEL} --max-configs=3D10 \</span><br><span>  --error-exitcode=
=3D1&quot;</span><br><span> </span><br><span> set -x</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1868?usp=3Demail">change 1868</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1868?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I65beb37a2d822333aa888de1baf11dfcb8490=
e90 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1868 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt;r=
azvanc@mailbox=2Eorg&gt; </div>

</body></html>
--NqE4rj3VC54=--


--===============2647122687534534068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2647122687534534068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2647122687534534068==--

