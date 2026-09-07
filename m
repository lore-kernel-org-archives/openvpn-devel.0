Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976E9C79F99
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 21:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2aqdj4wJMxxPTjv8Yk3xrB7EjdtgigZOA0MiUoQmtKQ=; b=evEA6CXKSyF55w6cTXTaKkvKHt
	kTFjERbVPKVCb7DnDPaq039kH2e5zlubE7YQO/kHB52bggq267n1EpRkvesrX+FDGtidEciFoHwI7
	a7MEJ78401VrRpWktbmjoWNyoCQGJFwp1FOOIt5vBnx7mo3Y/+s+cAVpPm2N8yMf42nA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3gW3-0005tr-IB;
	Mon, 07 Sep 2026 21:04:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3gVf-0005tR-BJ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 21:04:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=pJXY9mB7xx4m/sh/zVC/oWbY0EqZ0z3VE4NIeN4Txxc=; b=d8toqyPS56no0di/0RBmq5Xp0X
 CBJUP0/DDJgxLvtpoG086pS46ccCNOcZUt2OHw61bhqrFVl8guNLlbY5i3kDuT7TTxiJC0D38I+Kt
 Z75npeXAB0jb0bJOL09Vvu5BE2TVPbKtr9oMNhORkwk/Yaen8L52gLO1NvkiukzAGMkg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pJXY9mB7xx4m/sh/zVC/oWbY0EqZ0z3VE4NIeN4Txxc=; b=K
 5JG6PwNESsto7O4FlEfUIIT/p0gf7ncqC0Swi0syrTU+9zANGy5j7TrE4346/cgt16UtfmiuF4K10
 iawLUOK2X9oAf1AUOMnIaa/dm3HG7PSxhMR0HNT35QL13RR6etp1vmtdXaPgnvvQ2JQzYime9vGho
 NQmbr1VTWZfw2i8w=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3gVY-0000Qz-S9 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 21:04:06 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-49b0d78a801so39773675e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 14:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788815038; x=1789419838; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pJXY9mB7xx4m/sh/zVC/oWbY0EqZ0z3VE4NIeN4Txxc=;
 b=gxCXTgzwW+sZZ5xxZttAAFchykQXASjSsRVSimTwEx9aN/v4enTgttfJeRlPfQjlW7
 4PT0KAaurtKo96V47EwfQOOumj4iMy88HbX5LfyW7jTQhEv2pQsIA6/vQPH1eEfipdkc
 oTF7wqtBcwi26qvXfZOoct/AOnZjfNsJHxlcf8pMQqy+btML+Vkn9yvclQVdMB2cGGSR
 uVmROGAXC71BmmMd8QI6/9duD5abyahg/4PO04NP4qJZX6OMdapAuIxL4tgkSSqNW9iF
 xJYed56SFKKqT0I5C/UIKEqlIeYqiGTpQ5qJ/7fw3EoNYwzBfesvbxtSI/jnEDBbE9/F
 ni+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788815038; x=1789419838;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pJXY9mB7xx4m/sh/zVC/oWbY0EqZ0z3VE4NIeN4Txxc=;
 b=q5qkL7O84neWN/iNsBde0fcx7uMyXLzOpcUJs3O6dr0FhKhL+PwSuNByBjnJzWl3wJ
 Y2bxC+6yVu1H4m4nI6MT8iGfG+4tWVnmwp66R3G1D9KqiG9XCNKIDo8PeeN2V4Hsz2Ml
 OR+SoGjBhvNMwK/oi3QIMOFJlrCn2ysD6msVsGUVtOgWhBC0ZgOB231iybovRJKdoVx5
 zR7N4C+6di+9bpKfVQ3gtBVQagmpoCw1PX5eIFKCND0U/C8YpqByI+X06wMKOlTCIFGd
 u/oeFxa0qPmmBTNMmyzim/Nsq91pi1H1OgFkTYk+Kv8MwyweoMjN203uTnyCL8ntyfXv
 0JIg==
X-Gm-Message-State: AFuF++kiOOP8DBXYNHH/XYHGkBodUwFFGFWOHAymvcoXjULWklpKaHj3
 H1Sijfg8nBHAg/b+fQadloFb9rtcVE2Tzp2WtZpz3wXsBQRNl67OuR+4N9YLY6gvVDNwmdGO/yA
 wdqHZ1nKAlwZQhMVpF4ZDkb3PU4X/0QTNKXVrgZLy8UzM0D6reFyaEM81ytvtHrHq6rNHvuCquo
 q8ccXCxg==
X-Gm-Gg: AYBFou3jyu4C1ziq4OV7gbebX6AR+p1TPRrE2SNGWtodpHniATqDIYIBxwkM/wC6GMT
 YuarKG2ZcPYS5EBNZg/0YxQde5Yq1gCZHYJVbW6JHosb0eCIuumhouCqfrPsY2fylrPsUHwdEWd
 TFtY7jzEY13fEWowwaSLNsmm3RKzMkixA4Oew8lR3cInI4uU4rC5ZL4WYIaUJRhUOiSxM/92Sfi
 satrSOXY5Tgc+9kJL/1w1QEqu0g6mTX9mGfZhjoa53JMwqB/EUgDQPIScQZLr4rkUfDgWMzTrnU
 9YKnmtIchz8DoVQ2YVuQvSDnr+8Fm9sdigjZrSGZbG/t3AhJZARAbB+hpzkkkjYVKS1pkvLKMrW
 EEvOwz/FGN1Za5cpbJ5VttjPXo+mxev95Uhp6raIxuC1vqf9HmNafd7Hsh8LZvzYA0VM0BjD6ce
 X5kzoPjBX9UYj8ugq22zJ9P8rD0cxt0OeNFlJIC+8K1DIq6MTZfZvj2aCKq1rx0sBx63yIdX7J0
 ckcqjQLk7vxAXxkVTzQyJp/w8cdnOovVg78naXPEoGeGDIfkZ+jHKWUCvkYZO5ADiNaDOhNqT5L
 8G5yYaBncuWCNNxLFgQedRJdN0dSafLYAmM2z3YIBTUQrA/S1lycm55Z1V5zpw==
X-Received: by 2002:a05:600c:4e16:b0:49c:fc6c:bdfc with SMTP id
 5b1f17b1804b1-49cfc6cc01bmr210652155e9.19.1788815038182; 
 Mon, 07 Sep 2026 14:03:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883c5bc5sm32841868f8f.24.2026.09.07.14.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 14:03:57 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 21:03:55 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I65beb37a2d822333aa888de1baf11dfcb8490e90
X-Gerrit-Change-Number: 1868
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1868?usp=email>
X-Gerrit-Commit: dac08c156a18733f6dd8e687ea3a3572a5b1782a
In-Reply-To: <gerrit.1787672720000.I65beb37a2d822333aa888de1baf11dfcb8490e90@gerrit.openvpn.net>
References: <gerrit.1787672720000.I65beb37a2d822333aa888de1baf11dfcb8490e90@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NjcyNzIwMDAwLkk2NWJlYjM3YTJkODIyMzMzYWE4ODhkZTFiYWYxMWRmY2I4NDkwZTkwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5be72094ab0c9ba8105031b4a4c993a9c5af4f96-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3gVY-0000Qz-S9
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
Content-Type: multipart/mixed; boundary="===============0418667742485223363=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0418667742485223363==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NIEOpnsx104="; charset=UTF-8

--NIEOpnsx104=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello pla=
isthos, razvanc, 

I'd like you to reexamine a change=2E Please visit

    =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1868?usp=3Demail

to look at the =
new patch set (#4)=2E

The change is no longer submittable: checks~ChecksSu=
bmitRule is unsatisfied now=2E


Change subject: run-cppcheck=2Esh: Make it=
 more configurable
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

run-cppcheck=2Esh: Make it more configurable

- Allow to easily con=
trol verbosity and automatically
  adjust to the verbosity of the Make run
=
- Allow to easily control check level=2E With exhaustive the
  check can ta=
ke hours (due to options=2Ec), so we couldn't
  use that in CI

v3:
- Use A=
M_V_P instead of V to correctly reflect
  AM_DEFAULT_VERBOSITY

Change-Id: =
I65beb37a2d822333aa888de1baf11dfcb8490e90
Signed-off-by: Frank Lichtenheld =
<frank@lichtenheld=2Ecom>
---
M Makefile=2Eam
M dev-tools/run-cppcheck=2Esh=

2 files changed, 19 insertions(+), 3 deletions(-)


  git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/68/1868/4

diff --git a/Makefi=
le=2Eam b/Makefile=2Eam
index 66252e6=2E=2E125fe84 100644
--- a/Makefile=2E=
am
+++ b/Makefile=2Eam
@@ -96,4 +96,5 @@
 	BUILD_DIR=3D"$(abs_top_builddir)=
" \
 	SOURCE_DIR=3D"$(abs_top_srcdir)" \
 	INCLUDE_FLAGS=3D"$(LIBNL_GENL_CF=
LAGS)" \
+	CPPCHECK_VERBOSE=3D"$(AM_V_P)" \
 		"$(top_srcdir)/dev-tools/run=
-cppcheck=2Esh"
diff --git a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cp=
pcheck=2Esh
index a7aa3c4=2E=2Efc14405 100755
--- a/dev-tools/run-cppcheck=
=2Esh
+++ b/dev-tools/run-cppcheck=2Esh
@@ -2,22 +2,37 @@
 
 set -eu
 
+: $=
{CPPCHECK_VERBOSE:=3Dfalse}
+: ${CPPCHECK_CHECK_LEVEL:=3Dexhaustive}
+
+if =
"${CPPCHECK_VERBOSE}"; then
+    verbosity_arg=3D"-v"
+else
+    verbosity_=
arg=3D"-q"
+fi
+
+disable_arg=3D
+if [ "${CPPCHECK_CHECK_LEVEL}" !=3D exhau=
stive ]; then
+    # suppress all the information that we should use exhaus=
tive
+    disable_arg=3D"--disable=3Dinformation"
+fi
+
 SCRIPT_DIR=3D$(dir=
name $(readlink -e "${BASH_SOURCE[0]}"))
 : ${SOURCE_DIR:=3D$SCRIPT_DIR/=2E=
=2E}
 : ${BUILD_DIR:=3D$PWD}
 : ${INCLUDE_FLAGS:=3D}
 CPPCHECK_DIR=3D"${BUI=
LD_DIR}/cppcheck_build_dir"
-COMMON_ARGS=3D"-j$(nproc) -q \
+COMMON_ARGS=3D=
"-j$(nproc) ${verbosity_arg} \
  -DMBEDTLS_SSL_PROTO_TLS1_3 -DMBEDTLS_SSL_K=
EYING_MATERIAL_EXPORT \
  -I=2E/include/ -I=2E/tests/unit_tests/openvpn/ \
=
  -I=2E/src/compat/ -I=2E/src/openvpn/ -I=2E/src/openvpnserv/ -I=2E/src/plu=
gins/auth-pam/ \
  -I${BUILD_DIR} -I${BUILD_DIR}/include/ \
- --enable=3Dal=
l \
+ --enable=3Dall ${disable_arg} \
  --library=3D${SCRIPT_DIR}/openvpn-c=
ppcheck-library=2Ecfg \
  --library=3Dopenssl=2Ecfg \
  --suppressions-list=
=3D${SCRIPT_DIR}/cppcheck-suppression \
  --cppcheck-build-dir=3D${CPPCHECK=
_DIR} \
- --check-level=3Dexhaustive --max-configs=3D10 \
+ --check-level=
=3D${CPPCHECK_CHECK_LEVEL} --max-configs=3D10 \
  --error-exitcode=3D1"
 
 =
set -x

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1868?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I65beb37a2=
d822333aa888de1baf11dfcb8490e90
Gerrit-Change-Number: 1868
Gerrit-PatchSet:=
 4
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mail=
box=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attentio=
n: flichtenheld <frank@lichtenheld=2Ecom>

--NIEOpnsx104=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>flichtenheld <stro=
ng>uploaded patch set #4</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1868?usp=3Demail">View Change</a></p><p=
>The change is no longer submittable: checks~ChecksSubmitRule is unsatisfie=
d now=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">run-cppcheck=2Esh: Make it more configurable<br><=
br>- Allow to easily control verbosity and automatically<br>  adjust to the=
 verbosity of the Make run<br>- Allow to easily control check level=2E With=
 exhaustive the<br>  check can take hours (due to options=2Ec), so we could=
n&#39;t<br>  use that in CI<br><br>v3:<br>- Use AM_V_P instead of V to corr=
ectly reflect<br>  AM_DEFAULT_VERBOSITY<br><br>Change-Id: I65beb37a2d822333=
aa888de1baf11dfcb8490e90<br>Signed-off-by: Frank Lichtenheld &lt;frank@lich=
tenheld=2Ecom&gt;<br>---<br>M Makefile=2Eam<br>M dev-tools/run-cppcheck=2Es=
h<br>2 files changed, 19 insertions(+), 3 deletions(-)<br><br></pre><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/68/=
1868/4</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/Makefile=2Eam b/Makefile=2Eam</span><br><span>i=
ndex 66252e6=2E=2E125fe84 100644</span><br><span>--- a/Makefile=2Eam</span>=
<br><span>+++ b/Makefile=2Eam</span><br><span>@@ -96,4 +96,5 @@</span><br><=
span> 	BUILD_DIR=3D&quot;$(abs_top_builddir)&quot; \</span><br><span> 	SOUR=
CE_DIR=3D&quot;$(abs_top_srcdir)&quot; \</span><br><span> 	INCLUDE_FLAGS=3D=
&quot;$(LIBNL_GENL_CFLAGS)&quot; \</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+	CPPCHECK_VERBOSE=3D&quot;$(AM_V_P)&quot; \</span><br><span>=
 		&quot;$(top_srcdir)/dev-tools/run-cppcheck=2Esh&quot;</span><br><span>di=
ff --git a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh</span>=
<br><span>index a7aa3c4=2E=2Efc14405 100755</span><br><span>--- a/dev-tools=
/run-cppcheck=2Esh</span><br><span>+++ b/dev-tools/run-cppcheck=2Esh</span>=
<br><span>@@ -2,22 +2,37 @@</span><br><span> </span><br><span> set -eu</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+: ${CP=
PCHECK_VERBOSE:=3Dfalse}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+: ${CPPCHECK_CHECK_LEVEL:=3Dexhaustive}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+if &quot;${CPPCHECK_VERBOSE}&quot;; then</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    verbosity_arg=3D&quot;-v&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    verbosity_arg=3D&quot;-q&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+disable_arg=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+if [ &quot;${CPPCHECK_CHECK_LEVEL}&quot; !=3D exhaustive ]; then</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    # suppress all the inform=
ation that we should use exhaustive</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    disable_arg=3D&quot;--disable=3Dinformation&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> SCRIPT_DIR=3D$(dirname =
$(readlink -e &quot;${BASH_SOURCE[0]}&quot;))</span><br><span> : ${SOURCE_D=
IR:=3D$SCRIPT_DIR/=2E=2E}</span><br><span> : ${BUILD_DIR:=3D$PWD}</span><br=
><span> : ${INCLUDE_FLAGS:=3D}</span><br><span> CPPCHECK_DIR=3D&quot;${BUIL=
D_DIR}/cppcheck_build_dir&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-COMMON_ARGS=3D&quot;-j$(nproc) -q \</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+COMMON_ARGS=3D&quot;-j$(nproc) ${verbosity_arg} \=
</span><br><span>  -DMBEDTLS_SSL_PROTO_TLS1_3 -DMBEDTLS_SSL_KEYING_MATERIAL=
_EXPORT \</span><br><span>  -I=2E/include/ -I=2E/tests/unit_tests/openvpn/ =
\</span><br><span>  -I=2E/src/compat/ -I=2E/src/openvpn/ -I=2E/src/openvpns=
erv/ -I=2E/src/plugins/auth-pam/ \</span><br><span>  -I${BUILD_DIR} -I${BUI=
LD_DIR}/include/ \</span><br><span style=3D"color: hsl(0, 100%, 40%);">- --=
enable=3Dall \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ --en=
able=3Dall ${disable_arg} \</span><br><span>  --library=3D${SCRIPT_DIR}/ope=
nvpn-cppcheck-library=2Ecfg \</span><br><span>  --library=3Dopenssl=2Ecfg \=
</span><br><span>  --suppressions-list=3D${SCRIPT_DIR}/cppcheck-suppression=
 \</span><br><span>  --cppcheck-build-dir=3D${CPPCHECK_DIR} \</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- --check-level=3Dexhaustive --max-c=
onfigs=3D10 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ --che=
ck-level=3D${CPPCHECK_CHECK_LEVEL} --max-configs=3D10 \</span><br><span>  -=
-error-exitcode=3D1&quot;</span><br><span> </span><br><span> set -x</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1868?usp=3Demail">change 1868</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1868?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pro=
ject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Id: I65beb37a2d822333aa888de=
1baf11dfcb8490e90 </div>
<div style=3D"display:none"> Gerrit-Change-Number:=
 1868 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div st=
yle=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--NIEOpnsx104=--


--===============0418667742485223363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0418667742485223363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0418667742485223363==--

