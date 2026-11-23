Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223E9606A31E
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=chT3KI/r;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jZA9Jsr+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mbI3T0v0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ZJgA6YXR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=yu7MzfjvFR0Mn0INdi+tyNdGeapZPvq5n0l9I63O6Hg=; b=chT3KI/rVK+aSGpfa7erXivHIR
	+iu51ZdXTPT+HFABawRGM0zN1YKH3ODHiAC8PqNg8deGM31vhrWKVBMNg0cZ0vMeoyi4eC+pTQO3q
	h7RTltRwFmHYpg3Ny2Vymv247pSMhMkaS3diaphpfqHyprjEzhqGXX5w+ay0dT9eEi40=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVWTM-000000006la-1pbr;
	Mon, 23 Nov 2026 16:00:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVWTL-000000006lU-0V3P
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 16:00:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kObNGHJXjAvv3MlKspAWBwnb0OW6Dy7GVLnm4bkelU4=; b=jZA9Jsr+VBkHhDTzL929zOCbEv
 iW6yr1AHkH0dGCs4aoHikOz3ZNkN4NJOgfalGKzK/inzC8N3DfuaV03uPvzdffWKQAe/iE32xbkP/
 +l8D5RrIhbAxJdOn0Tl8tma1rQ2iVrnYGBhk+jIOuEBippUr7v5wwKYx1KlsEGjkrHKc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kObNGHJXjAvv3MlKspAWBwnb0OW6Dy7GVLnm4bkelU4=; b=mbI3T0v0OBqnaRMRIlM0GsNFYU
 ucrD3nBqyJNwN93jjYVWy3OplQSLd2U9AqZegM19luX5e7WiTCLqQM0fml0yDopo7ngG7Cqvwe+gG
 FvgcWsgKsTnz5VLfl9dBdOI9BpfGRCS/H3C+TjCNzfUIT6JpNJZXm/d3jv/Czc5itI1M=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVWTI-000000007Lk-38jg for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 16:00:51 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so3343372f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 08:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795449642; x=1796054442; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kObNGHJXjAvv3MlKspAWBwnb0OW6Dy7GVLnm4bkelU4=;
 b=ZJgA6YXRIDsT+8DrZSHZYmCSAiBbV065kyrbvFzpOX+JDK8pFlEHr4VFKGL4HVZc7P
 y3aeMHfEo6bfoZvEDYDqrNcsF5HVOnn+oMH5wNn1Mu96rwOnD5Tf1EFQOBzhPBmEiKVG
 zAneTrpZ9UfS69nmewbsqyjbg7f5z3n14MjatF/FNUpNKuivVjjMqO93E5ptzr39kooV
 fdsJNon7VUK9romaCn32p00TCVwVdfk0x/CItG5a0hy6uhMBnFOHZxV855G0jcNfu17n
 zd8nTEsIG4bwnxdMNeWNssJsBvkL3z+NtBzagoHq3Dd2EKk9jeXGcD9WrvUPOMEk7ukK
 RYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795449642; x=1796054442;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kObNGHJXjAvv3MlKspAWBwnb0OW6Dy7GVLnm4bkelU4=;
 b=h6wM5Kffj1g1ReWOp+sFheO5bHWBeTXQQSAvW67DWXQ5fese/sJ2dqR/esjBs09tM1
 ExNkhgiczKnf1D77Ygd9zLytkDd64XvDkQJrO1j/S0SFhSJuIOESlXOs6kjz8DBHT2F1
 VdDK7nl43qje8Kkcy92UWpSt9/NYCw3JFAPMWc8WZMBRAo+upGyvvPdbkP4BS6M/ABff
 GYlnJickzE/KaoNnh1zWE5RpSwuTSMJTXDFiTGlodGj+WigcARywZZ8j2WEGqkHThS8u
 n+FRntucKwiJ5LlU7xwnAoU8lBJIxYjzI5mis5uGLlvlBO6pkU5E3OJ6A2sB8xVTj/U6
 CwEA==
X-Gm-Message-State: APuU4Z/48+nwv8gjWoT+NmqWarlcL5LGsS8q4f5JIao6I0G1mYXWwhuY
 ja0I9v2+d6psjqU6NiVty9dEC41oc1MNxxTgfYHiVuS/7X0/a/Cy4nTLGBqRRLFxn+mdNTYApO0
 FZ9bR4icUFHfgE9Cot3aKD6tcBSP+Cmn2P4s8kyZ1yS2KuH4oqDfAqoVpeE8WCutBafOTGYJHI6
 FlDTdj4Q==
X-Gm-Gg: AZFdTZejKNLgk3Ne/TvT/PyWRpe6VqOIQWwD1/HUHTaOQsjQPtuXZsAKxSc+3P1Nobb
 NvF3jcCTajhCiPkl/rFGj9i6x355KtdA/Y1t4QH2TnC+0VPB7DDDJ3fdh4I0CoObBs788NK/lUl
 yVu14ogMmzvt/EZWtKlul2QIFgWlxVs6b85Hm+CSdaXqyh14EUD7UsfplYAgjms9+eJjJT1rEYA
 tWVjxlDot8OQvKY51otVjsEu4zTFCfwVQwgId7yOfikgbYPR5/uHSBSWjCqgY9NXxpQTNKm+KuY
 NHrBZLfyWzMcec0USLV4vqLbcHY7SxQz4NpixjWeeC3AM8cqd4o7RR0LEHFcqT5GzJUiTxD4tDE
 YcZNUGgcf91nOcj5R+gXAux8JBBemRNBLuy5iiL7zTSnfWW/WsQW59hP/3jIDrhNhQhoSWbWjMw
 xVCr38nebJJzo3iFpyWM/JaJQ/RBCVmLLp7j0gu/+PhymKGLZKy9SoC7RCRso4plW/Ylf3tZ4kS
 /iIgocO/XqKcDzm0/oMWa2uwecEx6oeJ8jIcPBRLy+jBR9mVHhg4mZqhOo4thiWhg47oTvG7R4m
 BB+s6QuxjQegFBSUpKgsBX8mmbWUXxJjTua3NaHoXR1S5dTyC2jpq4xGVU0W/CUsUl07QTiqZoe
 YYtFOeuzAd01ktXccHqR3jiXFrrW5Gm0DqUUNhMm3R+gX4P8lwQ9n5FLwQkuzkG4y3/AeDIQCLH
 aa0MWvDIv5rrY5tDI=
X-Received: by 2002:a5d:59c3:0:b0:4b5:b60:4814 with SMTP id
 ffacd0b85a97d-4b50b60487bmr3776270f8f.54.1795449641110; 
 Mon, 23 Nov 2026 08:00:41 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bb989b3sm23102893f8f.51.2026.11.23.08.00.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 08:00:40 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 16:00:40 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I01458ac46a5948fccec4afa9fc358a36e67055b5
X-Gerrit-Change-Number: 2331
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2331?usp=email>
X-Gerrit-Commit: bc8290ed11515a0ebeac55a82d270debab89e591
References: <gerrit.1795449639000.I01458ac46a5948fccec4afa9fc358a36e67055b5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NDQ5NjM5MDAwLkkwMTQ1OGFjNDZhNTk0OGZjY2VjNGFmYTlmYzM1OGEzNmU2NzA1NWI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ff63f49c11a292d2123a9a5266c192c1f57e6a58-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVWTI-000000007Lk-38jg
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add buildbot
 configuration script
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
Content-Type: multipart/mixed; boundary="===============7612980454589294329=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7612980454589294329==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3MgQqmJEZgI="; charset=UTF-8

--3MgQqmJEZgI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2331?usp=3Demail

to review the following change=2E
=


Change subject: Add buildbot configuration script
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add buildbot configuration script
=

This will allow us to more easily adapt buildbot
behavior by branch withou=
t having to encode all
the information in the buildbot configuration
itself=
=2E This tries to add some of the advantages
of a system like GHA which alr=
eady has per-branch
information, without moving completely to it=2E

Change=
-Id: I01458ac46a5948fccec4afa9fc358a36e67055b5
Signed-off-by: Frank Lichten=
held <frank@lichtenheld=2Ecom>
---
A =2Ebuildbot/buildbot_props=2Esh
1 file=
 changed, 43 insertions(+), 0 deletions(-)



  git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/31/2331/1

diff --git a/=2Ebuildbot/b=
uildbot_props=2Esh b/=2Ebuildbot/buildbot_props=2Esh
new file mode 100755
i=
ndex 0000000=2E=2E95ac642
--- /dev/null
+++ b/=2Ebuildbot/buildbot_props=2E=
sh
@@ -0,0 +1,43 @@
+# This script encodes some defaults for various operat=
ing systems
+# so that we can store them in git per-branch instead of havin=
g to
+# maintain them in the buildbot configuration for all possible
+# bra=
nches=2E
+
+set -eux
+
+# Defaults
+enable_werror=3D"--enable-werror"
+enab=
le_werror_cmake=3D"-DUSE_WERROR=3DON"
+default_configure_opts=3D
+branch_pk=
g_config_path=3D
+
+uname_kernel=3D$(uname -s)
+# We do not support -Werror=
 builds on NetBSD since they
+# have not been very good about updating the =
compiler in
+# the past
+if [ "$uname_kernel" =3D "NetBSD" ]; then
+    ena=
ble_werror=3D"--disable-werror"
+    enable_werror_cmake=3D"-DUSE_WERROR=3D=
OFF"
+fi
+# On macOS we have different versions of OpenSSL and mbedTLS avai=
lable
+# So choose here a version appropriate for this branch=2E
+if [ "$un=
ame_kernel" =3D "Darwin" ]; then
+    openssl_major=3D4
+    mbedtls_major=
=3D4
+    branch_pkg_config_path=3D"/opt/homebrew/opt/openssl@${openssl_maj=
or}/lib/pkgconfig:/opt/homebrew/opt/mbedtls@${mbedtls_major}/lib/pkgconfig"=

+fi
+# Enable systemd support on Linux by default
+if [ "$uname_kernel" =
=3D "Linux" ]; then
+    default_configure_opts=3D"--enable-systemd"
+fi
+
=
+echo "branch_config_opts=3D$enable_werror $default_configure_opts"
+echo "=
branch_config_opts_cmake=3D$enable_werror_cmake"
+if [ -n "${PKG_CONFIG_PAT=
H:-}" ]; then
+    if [ -n "branch_pkg_config_path" ]; then
+        branch=
_pkg_config_path=3D"$branch_pkg_config_path:$PKG_CONFIG_PATH"
+    else
+  =
      branch_pkg_config_path=3D"$PKG_CONFIG_PATH"
+    fi
+fi
+echo "branch=
_pkg_config_path=3D$branch_pkg_config_path"

-- 
To view, visit https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2331?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: I01458ac46a5948fccec4afa9fc358a36e67055b5
Gerr=
it-Change-Number: 2331
Gerrit-PatchSet: 1
Gerrit-Owner: Frank Lichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--3MgQqmJEZgI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2331?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">Add buildbot configuration script<br><br>This will allow u=
s to more easily adapt buildbot<br>behavior by branch without having to enc=
ode all<br>the information in the buildbot configuration<br>itself=2E This =
tries to add some of the advantages<br>of a system like GHA which already h=
as per-branch<br>information, without moving completely to it=2E<br><br>Cha=
nge-Id: I01458ac46a5948fccec4afa9fc358a36e67055b5<br>Signed-off-by: Frank L=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>A =2Ebuildbot/buildbot=
_props=2Esh<br>1 file changed, 43 insertions(+), 0 deletions(-)<br><br></pr=
e><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/31/2331/1</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/=2Ebuildbot/buildbot_props=2Esh b/=2Eb=
uildbot/buildbot_props=2Esh</span><br><span>new file mode 100755</span><br>=
<span>index 0000000=2E=2E95ac642</span><br><span>--- /dev/null</span><br><s=
pan>+++ b/=2Ebuildbot/buildbot_props=2Esh</span><br><span>@@ -0,0 +1,43 @@<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+# This script encode=
s some defaults for various operating systems</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+# so that we can store them in git per-branch ins=
tead of having to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
maintain them in the buildbot configuration for all possible</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# branches=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+set -eux</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Defaults</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+enable_werror=3D&quot;-=
-enable-werror&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+enable_werror_cmake=3D&quot;-DUSE_WERROR=3DON&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+default_configure_opts=3D</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+branch_pkg_config_path=3D</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+uname_kernel=3D$(uname -s)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# We do not support -Werror builds on Net=
BSD since they</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# hav=
e not been very good about updating the compiler in</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# the past</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+if [ &quot;$uname_kernel&quot; =3D &quot;NetBSD&qu=
ot; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    enab=
le_werror=3D&quot;--disable-werror&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    enable_werror_cmake=3D&quot;-DUSE_WERROR=3DOFF&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# On macOS we have different versi=
ons of OpenSSL and mbedTLS available</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# So choose here a version appropriate for this branch=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ &quot;$uname_ke=
rnel&quot; =3D &quot;Darwin&quot; ]; then</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    openssl_major=3D4</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    mbedtls_major=3D4</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    branch_pkg_config_path=3D&quot;/opt/homebrew/=
opt/openssl@${openssl_major}/lib/pkgconfig:/opt/homebrew/opt/mbedtls@${mbed=
tls_major}/lib/pkgconfig&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Enab=
le systemd support on Linux by default</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+if [ &quot;$uname_kernel&quot; =3D &quot;Linux&quot; ]; =
then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    default_con=
figure_opts=3D&quot;--enable-systemd&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+fi</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+echo &quot;br=
anch_config_opts=3D$enable_werror $default_configure_opts&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+echo &quot;branch_config_opts_c=
make=3D$enable_werror_cmake&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+if [ -n &quot;${PKG_CONFIG_PATH:-}&quot; ]; then</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if [ -n &quot;branch_pkg_con=
fig_path&quot; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        branch_pkg_config_path=3D&quot;$branch_pkg_config_path:$PKG_CONF=
IG_PATH&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    el=
se</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        branch_pk=
g_config_path=3D&quot;$PKG_CONFIG_PATH&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    fi</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+echo =
&quot;branch_pkg_config_path=3D$branch_pkg_config_path&quot;</span><br></pr=
e><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
331?usp=3Demail">change 2331</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2331?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newch=
ange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<di=
v style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Id: I01458ac46a5948fccec4afa9fc358a36e67055b5 </div>=

<div style=3D"display:none"> Gerrit-Change-Number: 2331 </div>
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
--3MgQqmJEZgI=--


--===============7612980454589294329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7612980454589294329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7612980454589294329==--

