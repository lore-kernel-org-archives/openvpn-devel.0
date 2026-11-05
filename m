Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985BF606D80E
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=e/fmBzFM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GdrFKf1p;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CFt3H2Gs;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SrJqUzGC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=WHVFiDxCZGSyQfWkPz9WqFJbfhDTjV1081OVDIC9ujw=; b=e/fmBzFMSPlGAFifyKvbvfRihF
	G2AIxHlNa0jmLdSvMN7PCOxeqEX9Bv6niiSBr3ngU+g4ifq+eC9dQ5YTq3cWMQ+8XBB8mYRINr+pI
	BnfMxiKJx6ga7bc6ZrDSE6COVRzjcLdeFef1cyQKK60t55q3NOPyGzJXX7+8eCWU9IY8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOxxi-000000002kL-24me;
	Thu, 05 Nov 2026 13:57:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOxxg-000000002kE-36kf
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 13:57:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AGutUq2OZFutvDdAjhCKPV1NCROok1rOii+t1Oy2E1Q=; b=GdrFKf1pVQLVZAdS/oiKmJPgT2
 U85YuJmS2knW6yH6QBX4aaf6j6OQxaA5H8J5DH7gODrp+AAjphurQVZ9VbLRl3qFXymPQ30/dq0Nf
 42gv49oIxBQQuS1YnhRX3KyhBVN9bvzBnuB9Z+sFdA5ijJQKnyevkJ3WUel1eELdC9eU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AGutUq2OZFutvDdAjhCKPV1NCROok1rOii+t1Oy2E1Q=; b=CFt3H2GsiMtPtpwb9OPy5Sqfex
 AMMQDAhtaPqgS1p1S1/d63p/GwC2awk6OdX0TR15vDKP1FHSE8Kgeze2L1djOK3pcoN3lu5QhyCso
 LrER3+p10BwJzSpWKB/RoqkuyQ6YVSHXGDmh0lQNg/NnPURvngiD9hM8l7IC2FOhAqfc=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOxxd-000000002Yz-07Q2 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 13:57:04 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4922523d1afso157463f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 05:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793887014; x=1794491814; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AGutUq2OZFutvDdAjhCKPV1NCROok1rOii+t1Oy2E1Q=;
 b=SrJqUzGCnCEgg8IhRepbqpCnhxw1DJPpekszhUkBE6G8f75/60YTSFrTQacEWBiRMk
 UI322nAarL6qGmCJxr+3C7GlToUqwhM2ZkDizsK6oc5bnVbm1nQfjROGNYHiPoGjd3CN
 jtKQmcwg/JnmfrDL9Cpaz8GeIRjMwPXZF+kUUK+dlCXngeQMxUVcrzZkM40v0IndUokw
 7kXGMM7jtJRti2Lbegqm9wbIZHiunkXm7U8F/fXLBEjtsujhoYx0uqWjTO+Ji9XDwoPl
 5szjFbR/8jJ6sUOjbA5z+hUe4rfIZMS8yVdRYI5p3Pp9cYQVvBqvcZXrXGZs++wcScPD
 /pvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793887014; x=1794491814;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AGutUq2OZFutvDdAjhCKPV1NCROok1rOii+t1Oy2E1Q=;
 b=tvf/5jtjvbEeDWnC9H573vEVkATT1gP8Zi1/f3tp4i9aFstCs4/7TcgTEIa894TM8C
 qSCMUYFXnNMh1iicl6jrIHBQBon+8IbyJmYqC3qoCI6Pv6YTtwLa6hi2U/uTMTO28LsJ
 nkCQYi4x/Kd5E8AOw8sptIShlNKsWPHqZaK+TzBA3NEwHbqdjwIdxrDaKIcbp4/SaNGR
 5ckjwXUGXHP6HdGEM1KcOsclSHrumm5vF3MQcu+jkCmxma9VRhUJ6R6Gq9egU6alxof8
 va91/VLwAHJ0J4K0F87MiOUV8YYETCwtxkRkvHC4bmjVnvCeRt7Q9RKGabAq64tP0pbB
 11Sg==
X-Gm-Message-State: APuU4Z/twJCCEq7yBDOOkYG1UeWq5ZbGO/BOI/Awyu+JJh6FnH/fJYkP
 rpdUjFzBbBxvulX90mpDgaJVc0N6GHtveTzLlH1OzbPjACRfZni6CZ57ol7x4lrk9LQKu0Uneij
 URfw8DTjpXyGLzWegcovRLhOAkLet1e2CEUUMc3CktqLAqLOEDRm0v36wd3INpUqtI16MN5LxPl
 kHJ37S1g==
X-Gm-Gg: AYBFou21lLHWGkSDPPxcOJwr2ULKo4B87n9/wYaWYGmVWfCwTnlfS7aDsgFApHlrxjP
 kdnX3dWIA+RdtgXC67PRxm3/+wORMjssBKupo2RNPdw42hg+GKt2BUgLfxMeBZ2PmCSDX8S1eJ6
 VUWYuXt5w4a7xDOKEGuus78fU3L08Wk95dYurZwDwAjDV4Q1LTXuzjnSqnae7BLUpKCieH45G5B
 lULjtTCJOvRmEh0Si3gMsDkxcJ1bRxV8CenhHSo6+RO6vUfeBtGyOSw5T8HtJKe2U1ZwFI4PMC/
 ERNkRPP/USjBEeTMKWzYVGkDsk7JRJNTInGk6S5PQRMsT//c/qWaHooP1ckC4R9jLdmbv6xLJC+
 4GQBb9XaxEL1ICLmwk/0KsNCHVm6LUQHDm9Yvkt/vJNCTH57Va5znzM7SRRqMJRi6mvYBhwHPau
 rLaiaOS4rpWq740vUSyq3v4DHoJmmxz559ZOPs04kYCFRtENRKhzN7PDjKwfnH13we/AGUBVDS8
 fOAUFmshqKNmznpCeb2AeyUvAm9m95lMafpJV1hvgzSBtDs2GgnIJ3O69GBoEesaz2Zg+yz3WuS
 H1ntaF9pyDaqe4wUeW5k8UW7qKQQmyTIZmfRCnPUtENegrkB/oPT3M4/mLNLVAxlIuWr9JQ87Hp
 4VXvqjp1CxlMdD1PdKen9bQ8BVqgarLmV8nc18bgnR+c6LdiOtqRehzFGs2jJzS3AHFK9wEyUi+
 rcb27B45MQ3Ar/3w==
X-Received: by 2002:a5d:5e8c:0:b0:48e:679a:4b03 with SMTP id
 ffacd0b85a97d-48e6e4f8bbamr44788885f8f.45.1793887013939; 
 Thu, 05 Nov 2026 05:56:53 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed551dbasm9890273f8f.37.2026.11.05.05.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 05:56:53 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 13:56:52 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I13f9f7dd61d7a4cc986155629f6a3c792aaac6d2
X-Gerrit-Change-Number: 2141
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2141?usp=email>
X-Gerrit-Commit: ac887c352dcf82277edf8772139e0056467426c2
In-Reply-To: <gerrit.1793872784000.I13f9f7dd61d7a4cc986155629f6a3c792aaac6d2@gerrit.openvpn.net>
References: <gerrit.1793872784000.I13f9f7dd61d7a4cc986155629f6a3c792aaac6d2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzODcyNzg0MDAwLkkxM2Y5ZjdkZDYxZDdhNGNjOTg2MTU1NjI5ZjZhM2M3OTJhYWFjNmQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9bac6999279b860089af65b77445deb54ca988c8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOxxd-000000002Yz-07Q2
Subject: [Openvpn-devel] [L] Change in openvpn[release/2.7]: backport
 t_client.sh changes from master
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1205575418226430454=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1205575418226430454==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jjYf5YgK2CQ="; charset=UTF-8

--jjYf5YgK2CQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Gert Doering=2E

Hello Frank Lichtenh=
eld, 

I'd like you to reexamine a change=2E Please visit

    https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2141?usp=3Demail

to look at the new patch s=
et (#2)=2E


Change subject: backport t_client=2Esh changes from master
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

backport t_clien=
t=2Esh changes from master

This is basically just copying in the current t=
_client=2Esh=2Ein script from
master, with a number of changes that are not=
 in 2=2E7 yet - most notably
support for "expect failure" cases=2E

Given t=
hat this is a test support script with no dependencies into the
OpenVPN cor=
e, and the large number of non-backported scripts that touch
one line or th=
e other, or re-indent things, copying the whole script
instead of trying to=
 cherry-pick all the individual change seemed like
a much better idea=2E=2E=
=2E

Besides t_client=2Esh, this also brings tests/update_t_client_ips=2Esh=

from master, because the dc16248523 commit will break functionality
otherw=
ise=2E

Here's the list:

commit e2548f6e3b7f9ed3d24020319117b17f30743656
 =
   t_client=2Esh=2Ein: Check whether addresses are in "tentative" state

co=
mmit af6a79c6a83739ca9542e52a02a3449a2f292758
    t_client=2Esh=2Ein: Add a=
bility to filter by test group

commit dc162485236b70ecfe1be639dbd9db8244a8=
5d54
    t_client=2Esh=2Ein: Allow to override the location of t_client_ips=
=2Erc
    (needs updated update_t_client_ips=2Esh)

commit 8b392d642eb4c9b9=
135dc6a442d943159467e058
    t_client=2Esh=2Ein: Add utility function needs=
_openvpn()

commit dc162485236b70ecfe1be639dbd9db8244a85d54
    t_client=2E=
sh=2Ein: Allow to override the location of t_client_ips=2Erc

commit 37ea1c=
7683ccb464f80d6e7e8fbcd4b8baf2ac60
    t_client=2Esh=2Ein: Add support for =
expected test failures

commit ed427eab1683af3adf21553dd1c6b6e4b8b2f10d
   =
 reformat-shell=2Esh: Add --simplify argument

commit f781227c92a3d1017e9d8=
a67e83e4465b43edf66
    Reformat all shell-scripts with shfmt
    (touches =
update_t_client_ips=2Esh)

commit b32d1ab45ec93786191e0dac2c8f5549d6c04258
=
    t_client=2Esh=2Ein: Do not try to guess the absolute path to LOGDIR

co=
mmit da1b2a7081eb2791f3a675945c42d7f3189ef752
    t_client=2Esh=2Ein: Use p=
rintf instead of echo -e

commit 162f19112702d1c8045efd17c5b09022fe1e04fb
 =
   t_client=2Esh=2Ein: Do not run resolvectl if systemd is not running

com=
mit 841ab0b216a424eb0100448362f76a2c12b3a516
    t_client=2Esh: Do not use =
CA_CERT variable as indicator for good =2Erc file

Change-Id: I13f9f7dd61d7=
a4cc986155629f6a3c792aaac6d2
Signed-off-by: Gert Doering <gert@greenie=2Emu=
c=2Ede>
---
M tests/t_client=2Esh=2Ein
M tests/update_t_client_ips=2Esh
2 f=
iles changed, 257 insertions(+), 185 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/2141/2

diff --git a/tests/t=
_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein
index 876e84a=2E=2E5e924bb 100=
755
--- a/tests/t_client=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ein
@@ -19,57=
 +19,82 @@
 srcdir=3D"${srcdir:-=2E}"
 top_builddir=3D"${top_builddir:-=2E=
=2E}"
 openvpn=3D"${openvpn:-${top_builddir}/src/openvpn/openvpn}"
-if [ -r=
 "${top_builddir}"/t_client=2Erc ] ; then
-    =2E "${top_builddir}"/t_clie=
nt=2Erc
-elif [ -r "${srcdir}"/t_client=2Erc ] ; then
-    =2E "${srcdir}"/=
t_client=2Erc
-else
-    echo "$0: cannot find 't_client=2Erc' in build dir=
 ('${top_builddir}')" >&2
-    echo "$0: or source directory ('${srcdir}')=
=2E SKIPPING TEST=2E" >&2
-    exit "${TCLIENT_SKIP_RC}"
+t_client_ips_rc=
=3D"${t_client_ips_rc:-${top_builddir}/t_client_ips=2Erc}"
+update_t_client=
_ips=3D"${update_t_client_ips:-${srcdir}/update_t_client_ips=2Esh}"
+
+if [=
 -z "${t_client_rc}" ]; then
+    if [ -r "${top_builddir}"/t_client=2Erc ]=
; then
+        t_client_rc=3D"${top_builddir}"/t_client=2Erc
+    elif [ -=
r "${srcdir}"/t_client=2Erc ]; then
+        t_client_rc=3D"${srcdir}"/t_cl=
ient=2Erc
+    else
+        echo "$0: cannot find 't_client=2Erc' in build=
 dir ('${top_builddir}')" >&2
+        echo "$0: or source directory ('${sr=
cdir}')=2E SKIPPING TEST=2E" >&2
+        exit "${TCLIENT_SKIP_RC}"
+    fi=

 fi
 
 # Check for external dependencies
 FPING=3D"fping"
 FPING6=3D"fping=
6"
-which fping > /dev/null
+which fping >/dev/null
 if [ $? -ne 0 ]; then
=
     echo "$0: fping is not available in \$PATH" >&2
     exit "${TCLIENT_S=
KIP_RC}"
 fi
-which fping6 > /dev/null
+which fping6 >/dev/null
 if [ $? -n=
e 0 ]; then
     echo "$0: fping6 is not available in \$PATH, assuming fpin=
g 4=2E0 or later" >&2
     FPING=3D"fping -4"
     FPING6=3D"fping -6"
 fi
=
 
-KILL_EXEC=3D`which kill`
+KILL_EXEC=3D$(which kill)
 if [ $? -ne 0 ]; th=
en
     echo "$0: kill not found in \$PATH" >&2
     exit "${TCLIENT_SKIP_R=
C}"
 fi
 
-if [ ! -x "${openvpn}" ]
-then
+if [ ! -x "${openvpn}" ]; then
 =
    echo "no (executable) openvpn binary in current build tree=2E FAIL=2E" =
>&2
     exit 1
 fi
 
-if [ ! -w =2E ]
-then
+if [ ! -w =2E ]; then
     ec=
ho "current directory is not writable (required for logging)=2E FAIL=2E" >&=
2
     exit 1
 fi
 
-if [ -z "$CA_CERT" ] ; then
-    echo "CA_CERT not def=
ined in 't_client=2Erc'=2E SKIP test=2E" >&2
+openvpn_version=3D$(${openvpn=
} --version | head -n 1 | cut -f2 -d" " | sed -E 's/^2\=2E([0123456789]+)=
=2E*$/2\1/')
+
+needs_openvpn()
+{
+    needs_version=3D$1
+
+    [ "$openv=
pn_version" -ge "$needs_version" ]
+    return $?
+}
+
+=2E "${t_client_rc}=
"
+
+if [ -z "$TEST_RUN_LIST" ]; then
+    echo "TEST_RUN_LIST empty, no te=
sts defined=2E  SKIP test=2E" >&2
     exit "${TCLIENT_SKIP_RC}"
 fi
 
-if =
[ -z "$TEST_RUN_LIST" ] ; then
-    echo "TEST_RUN_LIST empty, no tests def=
ined=2E  SKIP test=2E" >&2
-    exit "${TCLIENT_SKIP_RC}"
+if [ -n "$TEST_R=
UN_GROUP" ]; then
+    FILTERED_LIST=3D
+    for test in $TEST_RUN_LIST; do=

+        group=3D$(echo $test | sed -E 's/^([0123456789]+)=2E*/\1/')
+    =
    if [ "$group" =3D "$TEST_RUN_GROUP" ]; then
+            FILTERED_LIST=
=3D"$FILTERED_LIST $test"
+        fi
+    done
+    if [ -z "$FILTERED_LIS=
T" ]; then
+        echo "Filtered TEST_RUN_LIST empty (group=3D$TEST_RUN_G=
ROUP), no tests defined=2E  SKIP test=2E" >&2
+        exit "${TCLIENT_SKIP=
_RC}"
+    fi
+    TEST_RUN_LIST=3D$FILTERED_LIST
 fi
 
 # Ensure PREFER_KS=
U is in a known state
@@ -77,16 +102,14 @@
 
 # make sure we have permissio=
ns to run ifconfig/route from OpenVPN
 # can't use "id -u" here - doesn't w=
ork on Solaris
-ID=3D`id`
-if expr "$ID" : "uid=3D0" >/dev/null
-then :
+ID=
=3D$(id)
+if expr "$ID" : "uid=3D0" >/dev/null; then
+    :
 else
-    if [=
 "${PREFER_KSU}" -eq 1 ];
-    then
+    if [ "${PREFER_KSU}" -eq 1 ]; then=

         # Check if we have a valid kerberos ticket
         klist -l 1>/d=
ev/null 2>/dev/null
-        if [ $? -ne 0 ];
-        then
+        if [ $=
? -ne 0 ]; then
             # No kerberos ticket found, skip ksu and fallb=
ack to RUN_SUDO
             PREFER_KSU=3D0
             echo "$0: No Kerbe=
ros ticket available=2E  Will not use ksu=2E"
@@ -95,8 +118,7 @@
         f=
i
     fi
 
-    if [ -z "$RUN_SUDO" ]
-    then
+    if [ -z "$RUN_SUDO" ]=
; then
         echo "$0: this test must run be as root, or RUN_SUDO=3D=2E=
=2E=2E " >&2
         echo "      must be set correctly in 't_client=2Erc'=
=2E SKIP=2E" >&2
         exit "${TCLIENT_SKIP_RC}"
@@ -104,20 +126,22 @@
 =
        # We have to use sudo=2E Make sure that we (hopefully) do not have
=
         # to ask the users password during the test=2E This is done to
   =
      # prevent timing issues, e=2Eg=2E when the waits for openvpn to start=

-	if $RUN_SUDO $KILL_EXEC -0 $$
-	then
-	    echo "$0: $RUN_SUDO $KILL_EXE=
C -0 succeeded, good=2E"
-	else
-	    echo "$0: $RUN_SUDO $KILL_EXEC -0 fai=
led, cannot go on=2E SKIP=2E" >&2
-	    exit "${TCLIENT_SKIP_RC}"
-	fi
+   =
     if $RUN_SUDO $KILL_EXEC -0 $$; then
+            echo "$0: $RUN_SUDO $=
KILL_EXEC -0 succeeded, good=2E"
+        else
+            echo "$0: $RUN_=
SUDO $KILL_EXEC -0 failed, cannot go on=2E SKIP=2E" >&2
+            exit "=
${TCLIENT_SKIP_RC}"
+        fi
     fi
 fi
 
-LOGDIR=3Dt_client-`hostname`=
-`date +%Y%m%d-%H%M%S`
+LOGDIR=3Dt_client-$(hostname)-$(date +%Y%m%d-%H%M%S=
)
+if [ -n "$TEST_RUN_GROUP" ]; then
+    LOGDIR=3D"${LOGDIR}-${TEST_RUN_GR=
OUP}"
+fi
 LOGDIR_ABS=3D"$PWD/$LOGDIR"
-if mkdir $LOGDIR
-then :
+if mkdir =
$LOGDIR; then
+    :
 else
     echo "can't create log directory '$LOGDIR'=
=2E FAIL=2E" >&2
     exit 1
@@ -137,21 +161,28 @@
 output_start()
 {
     =
case $V in
-	0) outbuf=3D"" ;;			# no per-test output at all
-	1) printf "$=
@\n"			# compact, details only on failure
-           outbuf=3D"\n" ;;
-	*)=
 printf "\n$@\n" ;;		# print all, with a bit formatting
+        0) outbuf=
=3D"" ;; # no per-test output at all
+        1)
+            printf "$@\n"=
 # compact, details only on failure
+            outbuf=3D"\n"
+           =
 ;;
+        *) printf "\n$@\n" ;; # print all, with a bit formatting
     =
esac
 }
 
 output()
 {
-    END_NL=3D"\n"; if [ "X$1" =3D "X-n" ] ; then EN=
D_NL=3D"" ; shift ; fi
+    END_NL=3D"\n"
+    if [ "X$1" =3D "X-n" ]; then=

+        END_NL=3D""
+        shift
+    fi
     case $V in
-	0) ;;				# n=
o per-test output at all
-	1) outbuf=3D"$outbuf$@${END_NL}"	# print details=
 only on failure
-           ;;
-	*) printf "$@${END_NL}" ;;	# print everyt=
hing
+        0) ;; # no per-test output at all
+        1)
+            ou=
tbuf=3D"$outbuf$@${END_NL}" # print details only on failure
+            ;;=

+        *) printf "$@${END_NL}" ;; # print everything
     esac
 }
 
@@ -=
159,62 +190,61 @@
 fail()
 {
     output "FAIL: $@\n"
-    fail_count=3D$((=
 $fail_count + 1 ))
+    fail_count=3D$((fail_count + 1))
 }
 
 # print "al=
l interface IP addresses" + "all routes"
 # this is higly system dependent=
=2E=2E=2E
 get_ifconfig_route()
 {
-    UNAME=3D`uname -s`
+    UNAME=3D$(u=
name -s)
     case $UNAME in
-	Linux)
+        Linux)
             # linux =
/ iproute2? (-> if configure got a path)
-            if [ -n "@IPROUTE@" ]=

-            then
+            if [ -n "@IPROUTE@" ]; then
               =
  echo "-- linux iproute2 --"
-                @IPROUTE@ addr show     | gr=
ep -v valid_lft
+                @IPROUTE@ addr show | grep -v valid_lft
  =
               @IPROUTE@ route show
                 @IPROUTE@ -o -6 route =
show | grep -v ' cache' | sed -E -e 's/ expires [0-9]*sec//' -e 's/ (mtu|ho=
plimit|cwnd|ssthresh) [0-9]+//g' -e 's/ (rtt|rttvar) [0-9]+ms//g'
         =
    else
-	        echo "-- linux / ifconfig --"
-	        LANG=3DC @IFCONF=
IG@ -a |egrep  "( addr:|encap:)"
-	        LANG=3DC @NETSTAT@ -rn -4 -6
+  =
              echo "-- linux / ifconfig --"
+                LANG=3DC @IFCO=
NFIG@ -a | egrep "( addr:|encap:)"
+                LANG=3DC @NETSTAT@ -rn =
-4 -6
             fi
             ;;
-	FreeBSD|NetBSD|Darwin)
-	   echo "-=
- FreeBSD/NetBSD/Darwin [MacOS X] --"
-	   @IFCONFIG@ -a | egrep "(flags=3D=
|inet)"
-	   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
-	  =
 ;;
-	OpenBSD)
-	   echo "-- OpenBSD --"
-	   @IFCONFIG@ -a | egrep "(flags=
=3D|inet)" | \
-		sed -e 's/pltime [0-9]*//' -e 's/vltime [0-9]*//'
-	   @N=
ETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
-	   ;;
-	SunOS)
-	=
   echo "-- Solaris --"
-	   @IFCONFIG@ -a | egrep "(flags=3D|inet)"
-	   @=
NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
-	   ;;
-	AIX)
-	  =
 echo "-- AIX --"
-	   @IFCONFIG@ -a | egrep "(flags=3D|inet)"
-	   @NETSTA=
T@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
-	   ;;
+        FreeBSD =
| NetBSD | Darwin)
+            echo "-- FreeBSD/NetBSD/Darwin [MacOS X] --=
"
+            @IFCONFIG@ -a | egrep "(flags=3D|inet)"
+            @NETSTA=
T@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
+            ;;
+       =
 OpenBSD)
+            echo "-- OpenBSD --"
+            @IFCONFIG@ -a | eg=
rep "(flags=3D|inet)" |
+                sed -e 's/pltime [0-9]*//' -e 's/v=
ltime [0-9]*//'
+            @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$=
2,$3,$NF }'
+            ;;
+        SunOS)
+            echo "-- Solaris -=
-"
+            @IFCONFIG@ -a | egrep "(flags=3D|inet)"
+            @NETST=
AT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
+            ;;
+       =
 AIX)
+            echo "-- AIX --"
+            @IFCONFIG@ -a | egrep "(fl=
ags=3D|inet)"
+            @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,=
$3,$6 }'
+            ;;
         *)
-           echo "get_ifconfig_route()=
: no idea how to get info on your OS (`uname -s`)=2E  FAIL=2E" >&2
-       =
    exit 20
-           ;;
+            echo "get_ifconfig_route(): no idea=
 how to get info on your OS ($(uname -s))=2E  FAIL=2E" >&2
+            exi=
t 20
+            ;;
     esac
 
     # another round of per-platform infor=
mation gathering, for DNS info
     # for most of the platforms "cat /etc/r=
esolv=2Econf" is good enough
     # except Linux and MacOS
     case $UNAME=
 in
-	Linux)
-            if [ -x /usr/bin/resolvectl -a -d /run/systemd/sy=
stem ] ; then
+        Linux)
+            if [ -x /usr/bin/resolvectl -a -=
d /run/systemd/system ]; then
                 echo "-- linux resolvectl --=
"
                 resolvectl status
             else
@@ -222,7 +252,7 @@
=
                 cat /etc/resolv=2Econf
             fi
             ;;
-	D=
arwin)
+        Darwin)
             echo "-- MacOS scutil --dns"
         =
    scutil --dns
             ;;
@@ -260,19 +290,19 @@
 #  arg2: IPv4/IPv6 =
address that must show up in out of "get_ifconfig_route"
 check_ifconfig()
=
 {
-    proto=3D$1 ; shift
+    proto=3D$1
+    shift
     expect_list=3D"$=
@"
 
-    if [ -z "$expect_list" ] ; then return ; fi
-    if [ "$expect_li=
st" =3D "-" ] ; then return ; fi
+    if [ -z "$expect_list" ]; then return=
; fi
+    if [ "$expect_list" =3D "-" ]; then return; fi
 
-    for expect =
in $expect_list
-    do
-	if get_ifconfig_route | fgrep "$expect" >/dev/nul=
l
-	then :
-	else
-	    fail "check_ifconfig(): expected IPv$proto address =
'$expect' not found in ifconfig output=2E"
-	fi
+    for expect in $expect_=
list; do
+        if get_ifconfig_route | fgrep "$expect" >/dev/null; then
=
+            :
+        else
+            fail "check_ifconfig(): expected =
IPv$proto address '$expect' not found in ifconfig output=2E"
+        fi
  =
   done
 }
 
@@ -283,47 +313,48 @@
 #  arg3=2E=2E=2E -> fping arguments (ho=
st list)
 run_ping_tests()
 {
-    proto=3D$1 ; want=3D$2 ; shift ; shift
+=
    proto=3D$1
+    want=3D$2
+    shift
+    shift
     targetlist=3D"$@"
=
 
     # "no targets" is fine
-    if [ -z "$targetlist" ] ; then return ; =
fi
+    if [ -z "$targetlist" ]; then return; fi
 
     case $proto in
-	4)=
 cmd=3D"$FPING" ;;
-	6) cmd=3D"$FPING6" ;;
-	*) echo "internal error in run=
_ping_tests arg 1: '$proto'" >&2
-	   exit 1 ;;
+        4) cmd=3D"$FPING" =
;;
+        6) cmd=3D"$FPING6" ;;
+        *)
+            echo "internal e=
rror in run_ping_tests arg 1: '$proto'" >&2
+            exit 1
+          =
  ;;
     esac
 
     case $want in
-	want_ok)   sizes_list=3D"64 1440 3000=
" ;;
-	want_fail) sizes_list=3D"64" ;;
+        want_ok) sizes_list=3D"64 1=
440 3000" ;;
+        want_fail) sizes_list=3D"64" ;;
     esac
 
-    for =
bytes in $sizes_list
-    do
-	output "run IPv$proto ping tests ($want), $b=
ytes byte packets=2E=2E=2E"
+    for bytes in $sizes_list; do
+        outp=
ut "run IPv$proto ping tests ($want), $bytes byte packets=2E=2E=2E"
 
-	ech=
o "$cmd -b $bytes -C 20 -p 250 -q $fping_args $targetlist" >>$LOGDIR/$SUF:f=
ping=2Eout
-	$cmd -b $bytes -C 20 -p 250 -q $fping_args $targetlist >>$LOGD=
IR/$SUF:fping=2Eout 2>&1
+        echo "$cmd -b $bytes -C 20 -p 250 -q $fpi=
ng_args $targetlist" >>$LOGDIR/$SUF:fping=2Eout
+        $cmd -b $bytes -C =
20 -p 250 -q $fping_args $targetlist >>$LOGDIR/$SUF:fping=2Eout 2>&1
 
-	# =
while OpenVPN is running, pings must succeed (want=3D'want_ok')
-	# before =
OpenVPN is up, pings must NOT succeed (want=3D'want_fail')
+        # while=
 OpenVPN is running, pings must succeed (want=3D'want_ok')
+        # befor=
e OpenVPN is up, pings must NOT succeed (want=3D'want_fail')
 
-	rc=3D$?
-	=
if [ $rc =3D 0 ] 				# all ping OK
-	then
-	    if [ $want =3D "want_fail" =
]		# not what we want
-	    then
-		fail "IPv$proto ping test succeeded, bu=
t needs to *fail*=2E"
-	    fi
-	else					# ping failed
-	    if [ $want =
=3D "want_ok" ]		# not what we wanted
-	    then
-		fail "IPv$proto ping te=
st ($bytes bytes) failed, but should succeed=2E"
-	    fi
-	fi
+        rc=
=3D$?
+        if [ $rc =3D 0 ]; then                 # all ping OK
+      =
      if [ $want =3D "want_fail" ]; then # not what we want
+              =
  fail "IPv$proto ping test succeeded, but needs to *fail*=2E"
+           =
 fi
+        else                               # ping failed
+            =
if [ $want =3D "want_ok" ]; then # not what we wanted
+                fail=
 "IPv$proto ping test ($bytes bytes) failed, but should succeed=2E"
+      =
      fi
+        fi
     done
 }
 
@@ -334,8 +365,7 @@
 SUMMARY_SKIP=3D
 S=
UMMARY_FAIL=3D
 
-for SUF in $TEST_RUN_LIST
-do
+for SUF in $TEST_RUN_LIST;=
 do
     # get config variables
     eval test_prep=3D\"\$PREPARE_$SUF\"
  =
   eval test_check_skip=3D\"\$CHECK_SKIP_$SUF\"
@@ -347,26 +377,32 @@
     =
eval expect_ifconfig6=3D\"\$EXPECT_IFCONFIG6_$SUF\"
     eval ping4_hosts=
=3D\"\$PING4_HOSTS_$SUF\"
     eval ping6_hosts=3D\"\$PING6_HOSTS_$SUF\"
+ =
   eval expect_fail=3D\"\$EXPECT_FAIL_$SUF\"
     eval fping_args=3D\"\$FPI=
NG_EXTRA_ARGS \$FPING_ARGS_$SUF\"
 
     # If EXCEPT_IFCONFIG* variables fo=
r this test are missing, run an --up
     # script to generate them dynamic=
ally=2E
     if [ -z "$expect_ifconfig4" ] || [ -z "$expect_ifconfig6" ]; t=
hen
-        up=3D"--setenv TESTNUM $SUF --setenv TOP_BUILDDIR ${top_buildd=
ir} --script-security 2 --up ${srcdir}/update_t_client_ips=2Esh"
+        u=
p=3D"--setenv TESTNUM $SUF --setenv RC ${t_client_ips_rc} --script-security=
 2 --up ${update_t_client_ips}"
     else
         up=3D""
     fi
 
     o=
utput_start "### test run $SUF: '$test_run_title' ###"
+    if [ -n "$expec=
t_fail" ]; then
+        output "### expect failure: '$expect_fail'"
+    f=
i
     fail_count=3D0
 
     if [ -n "$test_check_skip" ]; then
         ou=
tput "check whether we need to skip: '$test_check_skip'"
-        if eval $=
test_check_skip; then :
+        if eval $test_check_skip; then
+          =
  :
         else
             output "skip check failed, SKIP test $SUF=2E=
"
-	    SUMMARY_SKIP=3D"$SUMMARY_SKIP $SUF"
-	    printf "$outbuf" ; contin=
ue
+            SUMMARY_SKIP=3D"$SUMMARY_SKIP $SUF"
+            printf "$o=
utbuf"
+            continue
         fi
     fi
 
@@ -385,13 +421,14 @@
  =
   output "\nrun pre-openvpn ping tests - targets must not be reachable=2E=
=2E=2E"
     run_ping_tests 4 want_fail "$ping4_hosts"
     run_ping_tests =
6 want_fail "$ping6_hosts"
-    if [ "$fail_count" =3D 0 ] ; then
+    if [=
 "$fail_count" =3D 0 ]; then
         output "OK=2E\n"
     else
-	fail "ma=
ke sure that ping hosts are ONLY reachable via VPN, SKIP test $SUF=2E"
-	SU=
MMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
-	exit_code=3D31
-	printf "$outbuf" ; con=
tinue
+        fail "make sure that ping hosts are ONLY reachable via VPN, =
SKIP test $SUF=2E"
+        SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
+        ex=
it_code=3D31
+        printf "$outbuf"
+        continue
     fi
 
     pid=
file=3D"$LOGDIR_ABS/openvpn-$SUF=2Epid"
@@ -406,38 +443,77 @@
     # to $ov=
pn_init_check times=2E
     ovpn_init_check=3D30
     ovpn_init_success=3D0=

-    while [ $ovpn_init_check -gt 0 ];
-    do
-       sleep 1  # Wait for=
 OpenVPN to initialize and have had time to write the pid file
-       grep=
 "Initialization Sequence Completed" $LOGDIR/$SUF:openvpn=2Elog >/dev/null
=
-       if [ $? -eq 0 ]; then
-           ovpn_init_check=3D0
-           o=
vpn_init_success=3D1
-       fi
-       ovpn_init_check=3D$(( $ovpn_init_ch=
eck - 1 ))
+    while [ $ovpn_init_check -gt 0 ]; do
+        sleep 1 # Wai=
t for OpenVPN to initialize and to write the pid file
+        if [ -n "$ex=
pect_fail" ]; then
+            grep "$expect_fail" $LOGDIR/$SUF:openvpn=2E=
log >/dev/null
+            if [ $? -eq 0 ]; then
+                ovpn_ini=
t_check=3D0
+                ovpn_init_success=3D1
+                sleep 5=
 # give openvpn time to quit
+            fi
+        else
+            gre=
p "Initialization Sequence Completed" $LOGDIR/$SUF:openvpn=2Elog >/dev/null=

+            if [ $? -eq 0 ]; then
+                ovpn_init_check=3D0
+ =
               ovpn_init_success=3D1
+            fi
+        fi
+        o=
vpn_init_check=3D$((ovpn_init_check - 1))
     done
 
-    opid=3D`cat $pid=
file`
+    opid=3D$([ -e $pidfile ] && cat $pidfile)
     if [ -n "$opid" ]=
; then
         output "  OpenVPN running with PID $opid"
     else
-      =
  output "  Could not read OpenVPN PID file"
+        if [ -z "$expect_fail=
" ]; then # print this only if unexpected
+            output "  Could not =
read OpenVPN PID file"
+        fi
     fi
 
-    # If OpenVPN did not star=
t
+    # did we expect a failure?
+    if [ -n "$expect_fail" ]; then
+    =
    if [ -n "$opid" ]; then # OpenVPN did start!
+            output "$0: O=
penVPN did start up, expected failure"
+            $RUN_SUDO $KILL_EXEC $o=
pid $sudopid
+            output "tail -5 $SUF:openvpn=2Elog"
+            =
output "$(tail -5 $LOGDIR/$SUF:openvpn=2Elog)"
+            fail "skip rest=
 of sub-tests for test run $SUF=2E"
+            trap - 0 1 2 3 15
+       =
     SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
+            exit_code=3D32
+     =
       printf "$outbuf"
+            continue
+        elif [ $ovpn_init_su=
ccess -eq 0 ]; then
+            output "$0: OpenVPN failure did not match =
expected failure"
+            output "tail -5 $SUF:openvpn=2Elog"
+       =
     output "$(tail -5 $LOGDIR/$SUF:openvpn=2Elog)"
+            SUMMARY_FA=
IL=3D"$SUMMARY_FAIL $SUF"
+            exit_code=3D33
+            printf "=
$outbuf"
+            continue
+        else
+            output "test run =
$SUF: all tests OK (saw expected failure)=2E"
+            SUMMARY_OK=3D"$S=
UMMARY_OK $SUF"
+            continue
+        fi
+    fi
+
+    # If OpenV=
PN did not start but should have
     if [ $ovpn_init_success -ne 1 -o -z "=
$opid" ]; then
         output "$0:  OpenVPN did not initialize in a reason=
able time"
         if [ -n "$opid" ]; then
-           $RUN_SUDO $KILL_EXE=
C $opid
+            $RUN_SUDO $KILL_EXEC $opid
         fi
         $RUN_S=
UDO $KILL_EXEC $sudopid
-	output "tail -5 $SUF:openvpn=2Elog"
-	output "`ta=
il -5 $LOGDIR/$SUF:openvpn=2Elog`"
-	fail "skip rest of sub-tests for test =
run $SUF=2E"
-	trap - 0 1 2 3 15
-	SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
-	ex=
it_code=3D30
-	printf "$outbuf" ; continue
+        output "tail -5 $SUF:op=
envpn=2Elog"
+        output "$(tail -5 $LOGDIR/$SUF:openvpn=2Elog)"
+     =
   fail "skip rest of sub-tests for test run $SUF=2E"
+        trap - 0 1 2=
 3 15
+        SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
+        exit_code=3D30
=
+        printf "$outbuf"
+        continue
     fi
 
     # make sure open=
vpn client is terminated in case shell exits
@@ -452,17 +528,16 @@
        =
 exit 1
     fi
 
-    if [ "$expect_ifconfig4" =3D "-" ] ; then
+    if [ =
"$expect_ifconfig4" =3D "-" ]; then
         output "skip ifconfig+route ch=
eck"
     else
-	output -n "compare pre-openvpn ifconfig+route with current=
 values=2E=2E=2E"
-	if diff $LOGDIR/$SUF:ifconfig_route_pre=2Etxt \
-		$LOG=
DIR/$SUF:ifconfig_route=2Etxt >/dev/null
-	then
-	    fail "no differences =
between ifconfig/route before OpenVPN start and now=2E"
-	else
-	    output=
 " OK!\n"
-	fi
+        output -n "compare pre-openvpn ifconfig+route with =
current values=2E=2E=2E"
+        if diff $LOGDIR/$SUF:ifconfig_route_pre=
=2Etxt \
+            $LOGDIR/$SUF:ifconfig_route=2Etxt >/dev/null; then
+ =
           fail "no differences between ifconfig/route before OpenVPN start=
 and now=2E"
+        else
+            output " OK!\n"
+        fi
     fi=

 
     # post init script needed?
@@ -483,8 +558,8 @@
     $RUN_SUDO $KILL=
_EXEC $opid
     wait $!
     rc=3D$?
-    if [ $rc !=3D 0 ] ; then
-	fail =
"OpenVPN return code $rc, expect 0"
+    if [ $rc !=3D 0 ]; then
+        f=
ail "OpenVPN return code $rc, expect 0"
     fi
 
     output "\nsave post-=
openvpn ifconfig + route=2E=2E=2E"
@@ -496,23 +571,22 @@
 
     output -n "=
compare pre- and post-openvpn ifconfig + route=2E=2E=2E"
     if diff $LOGD=
IR/$SUF:ifconfig_route_pre=2Etxt \
-	    $LOGDIR/$SUF:ifconfig_route_post=
=2Etxt >$LOGDIR/$SUF:ifconfig_route_diff=2Etxt
-    then
-	output " OK=2E\n=
"
+        $LOGDIR/$SUF:ifconfig_route_post=2Etxt >$LOGDIR/$SUF:ifconfig_ro=
ute_diff=2Etxt; then
+        output " OK=2E\n"
     else
-	output "\n\n" "=
`cat $LOGDIR/$SUF:ifconfig_route_diff=2Etxt`" "\n"
-	fail "differences betw=
een pre- and post-ifconfig/route=2E"
+        output "\n\n" "$(cat $LOGDIR/=
$SUF:ifconfig_route_diff=2Etxt)" "\n"
+        fail "differences between pr=
e- and post-ifconfig/route=2E"
     fi
-    if [ "$fail_count" =3D 0 ] ; th=
en
+    if [ "$fail_count" =3D 0 ]; then
         output "test run $SUF: al=
l tests OK=2E\n"
-	SUMMARY_OK=3D"$SUMMARY_OK $SUF"
+        SUMMARY_OK=3D"$=
SUMMARY_OK $SUF"
     else
-	if [ "$V" -gt 0 ] ; then
-	    printf "$outbuf=
"
-	    echo "test run $SUF: $fail_count test failures=2E FAIL=2E"
+       =
 if [ "$V" -gt 0 ]; then
+            printf "$outbuf"
+            echo "t=
est run $SUF: $fail_count test failures=2E FAIL=2E"
         fi
-	SUMMARY_F=
AIL=3D"$SUMMARY_FAIL $SUF"
-	exit_code=3D30
+        SUMMARY_FAIL=3D"$SUMMA=
RY_FAIL $SUF"
+        exit_code=3D30
     fi
 
     if [ -n "$test_cleanup=
" ]; then
@@ -522,9 +596,9 @@
 
 done
 
-if [ -z "$SUMMARY_OK" ] ; then SUM=
MARY_OK=3D" none"; fi
-if [ -z "$SUMMARY_SKIP" ] ; then SUMMARY_SKIP=3D" no=
ne"; fi
-if [ -z "$SUMMARY_FAIL" ] ; then SUMMARY_FAIL=3D" none"; fi
+if [ =
-z "$SUMMARY_OK" ]; then SUMMARY_OK=3D" none"; fi
+if [ -z "$SUMMARY_SKIP" =
]; then SUMMARY_SKIP=3D" none"; fi
+if [ -z "$SUMMARY_FAIL" ]; then SUMMARY=
_FAIL=3D" none"; fi
 echo "Test sets succeeded:$SUMMARY_OK=2E"
 echo "Test =
sets skipped:$SUMMARY_SKIP=2E"
 echo "Test sets failed:$SUMMARY_FAIL=2E"
di=
ff --git a/tests/update_t_client_ips=2Esh b/tests/update_t_client_ips=2Esh
=
index 96e3826=2E=2Ef02dc7f 100755
--- a/tests/update_t_client_ips=2Esh
+++ =
b/tests/update_t_client_ips=2Esh
@@ -3,14 +3,12 @@
 # This --up script cach=
es the IPs handed out by the test VPN server to a file
 # for later use=2E
=
 
-RC=3D"$TOP_BUILDDIR/t_client_ips=2Erc"
-
-grep EXPECT_IFCONFIG4_$TESTNUM=
=3D $RC > /dev/null 2>&1
+grep EXPECT_IFCONFIG4_$TESTNUM=3D $RC >/dev/null =
2>&1
 if [ $? -ne 0 ]; then
-    echo "EXPECT_IFCONFIG4_$TESTNUM=3D$ifconfi=
g_local" >> $RC
+    echo "EXPECT_IFCONFIG4_$TESTNUM=3D$ifconfig_local" >>$=
RC
 fi
 
-grep EXPECT_IFCONFIG6_$TESTNUM=3D $RC > /dev/null 2>&1
+grep EXPE=
CT_IFCONFIG6_$TESTNUM=3D $RC >/dev/null 2>&1
 if [ $? -ne 0 ]; then
-    ec=
ho "EXPECT_IFCONFIG6_$TESTNUM=3D$ifconfig_ipv6_local" >> $RC
+    echo "EXP=
ECT_IFCONFIG6_$TESTNUM=3D$ifconfig_ipv6_local" >>$RC
 fi

-- 
To view, visi=
t https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2141?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvp=
n
Gerrit-Branch: release/2=2E7
Gerrit-Change-Id: I13f9f7dd61d7a4cc986155629=
f6a3c792aaac6d2
Gerrit-Change-Number: 2141
Gerrit-PatchSet: 2
Gerrit-Owner:=
 Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Frank Lichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=2Ede>

--jjYf5YgK2CQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Gert Doering=2E </p>
<p>Gert Doering <strong>uploaded=
 patch set #2</strong> to this change=2E</p><p><a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2141?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">backport t_client=2Esh changes from master<br><br>This is basically jus=
t copying in the current t_client=2Esh=2Ein script from<br>master, with a n=
umber of changes that are not in 2=2E7 yet - most notably<br>support for &q=
uot;expect failure&quot; cases=2E<br><br>Given that this is a test support =
script with no dependencies into the<br>OpenVPN core, and the large number =
of non-backported scripts that touch<br>one line or the other, or re-indent=
 things, copying the whole script<br>instead of trying to cherry-pick all t=
he individual change seemed like<br>a much better idea=2E=2E=2E<br><br>Besi=
des t_client=2Esh, this also brings tests/update_t_client_ips=2Esh<br>from =
master, because the dc16248523 commit will break functionality<br>otherwise=
=2E<br><br>Here&#39;s the list:<br><br>commit e2548f6e3b7f9ed3d24020319117b=
17f30743656<br>    t_client=2Esh=2Ein: Check whether addresses are in &quot=
;tentative&quot; state<br><br>commit af6a79c6a83739ca9542e52a02a3449a2f2927=
58<br>    t_client=2Esh=2Ein: Add ability to filter by test group<br><br>co=
mmit dc162485236b70ecfe1be639dbd9db8244a85d54<br>    t_client=2Esh=2Ein: Al=
low to override the location of t_client_ips=2Erc<br>    (needs updated upd=
ate_t_client_ips=2Esh)<br><br>commit 8b392d642eb4c9b9135dc6a442d943159467e0=
58<br>    t_client=2Esh=2Ein: Add utility function needs_openvpn()<br><br>c=
ommit dc162485236b70ecfe1be639dbd9db8244a85d54<br>    t_client=2Esh=2Ein: A=
llow to override the location of t_client_ips=2Erc<br><br>commit 37ea1c7683=
ccb464f80d6e7e8fbcd4b8baf2ac60<br>    t_client=2Esh=2Ein: Add support for e=
xpected test failures<br><br>commit ed427eab1683af3adf21553dd1c6b6e4b8b2f10=
d<br>    reformat-shell=2Esh: Add --simplify argument<br><br>commit f781227=
c92a3d1017e9d8a67e83e4465b43edf66<br>    Reformat all shell-scripts with sh=
fmt<br>    (touches update_t_client_ips=2Esh)<br><br>commit b32d1ab45ec9378=
6191e0dac2c8f5549d6c04258<br>    t_client=2Esh=2Ein: Do not try to guess th=
e absolute path to LOGDIR<br><br>commit da1b2a7081eb2791f3a675945c42d7f3189=
ef752<br>    t_client=2Esh=2Ein: Use printf instead of echo -e<br><br>commi=
t 162f19112702d1c8045efd17c5b09022fe1e04fb<br>    t_client=2Esh=2Ein: Do no=
t run resolvectl if systemd is not running<br><br>commit 841ab0b216a424eb01=
00448362f76a2c12b3a516<br>    t_client=2Esh: Do not use CA_CERT variable as=
 indicator for good =2Erc file<br><br>Change-Id: I13f9f7dd61d7a4cc986155629=
f6a3c792aaac6d2<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&=
gt;<br>---<br>M tests/t_client=2Esh=2Ein<br>M tests/update_t_client_ips=2Es=
h<br>2 files changed, 257 insertions(+), 185 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
41/2141/2</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/tests/t_client=2Esh=2Ein b/tests/t_client=2E=
sh=2Ein</span><br><span>index 876e84a=2E=2E5e924bb 100755</span><br><span>-=
-- a/tests/t_client=2Esh=2Ein</span><br><span>+++ b/tests/t_client=2Esh=2Ei=
n</span><br><span>@@ -19,57 +19,82 @@</span><br><span> srcdir=3D&quot;${src=
dir:-=2E}&quot;</span><br><span> top_builddir=3D&quot;${top_builddir:-=2E=
=2E}&quot;</span><br><span> openvpn=3D&quot;${openvpn:-${top_builddir}/src/=
openvpn/openvpn}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-if [ -r &quot;${top_builddir}&quot;/t_client=2Erc ] ; then</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    =2E &quot;${top_builddir}&quot;/t=
_client=2Erc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-elif [ -r=
 &quot;${srcdir}&quot;/t_client=2Erc ] ; then</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    =2E &quot;${srcdir}&quot;/t_client=2Erc</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-else</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    echo &quot;$0: cannot find &#39;t_client=
=2Erc&#39; in build dir (&#39;${top_builddir}&#39;)&quot; &gt;&amp;2</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;$0: or source=
 directory (&#39;${srcdir}&#39;)=2E SKIPPING TEST=2E&quot; &gt;&amp;2</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    exit &quot;${TCLIENT_SK=
IP_RC}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+t_clien=
t_ips_rc=3D&quot;${t_client_ips_rc:-${top_builddir}/t_client_ips=2Erc}&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+update_t_client_ip=
s=3D&quot;${update_t_client_ips:-${srcdir}/update_t_client_ips=2Esh}&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+if [ -z &quot;${t_client_rc}&quot; ]; t=
hen</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ -r &quo=
t;${top_builddir}&quot;/t_client=2Erc ]; then</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        t_client_rc=3D&quot;${top_builddir}&quot;=
/t_client=2Erc</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
lif [ -r &quot;${srcdir}&quot;/t_client=2Erc ]; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        t_client_rc=3D&quot;${srcdir}&quo=
t;/t_client=2Erc</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        echo &=
quot;$0: cannot find &#39;t_client=2Erc&#39; in build dir (&#39;${top_build=
dir}&#39;)&quot; &gt;&amp;2</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        echo &quot;$0: or source directory (&#39;${srcdir}&#39;)=2E=
 SKIPPING TEST=2E&quot; &gt;&amp;2</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span> fi</span><br=
><span> </span><br><span> # Check for external dependencies</span><br><span=
> FPING=3D&quot;fping&quot;</span><br><span> FPING6=3D&quot;fping6&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-which fping &gt; /dev/nu=
ll</span><br><span style=3D"color: hsl(120, 100%, 40%);">+which fping &gt;/=
dev/null</span><br><span> if [ $? -ne 0 ]; then</span><br><span>     echo &=
quot;$0: fping is not available in \$PATH&quot; &gt;&amp;2</span><br><span>=
     exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span> fi</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-which fping6 &gt; /dev/null</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+which fping6 &gt;/dev/null</=
span><br><span> if [ $? -ne 0 ]; then</span><br><span>     echo &quot;$0: f=
ping6 is not available in \$PATH, assuming fping 4=2E0 or later&quot; &gt;&=
amp;2</span><br><span>     FPING=3D&quot;fping -4&quot;</span><br><span>   =
  FPING6=3D&quot;fping -6&quot;</span><br><span> fi</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-KILL_EXEC=3D`which kill`</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+KILL_EXEC=3D$(which ki=
ll)</span><br><span> if [ $? -ne 0 ]; then</span><br><span>     echo &quot;=
$0: kill not found in \$PATH&quot; &gt;&amp;2</span><br><span>     exit &qu=
ot;${TCLIENT_SKIP_RC}&quot;</span><br><span> fi</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-if [ ! -x &quot;${openvpn}&quot=
; ]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-then</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+if [ ! -x &quot;${openvpn}&quot; =
]; then</span><br><span>     echo &quot;no (executable) openvpn binary in c=
urrent build tree=2E FAIL=2E&quot; &gt;&amp;2</span><br><span>     exit 1</=
span><br><span> fi</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-if [ ! -w =2E ]</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ !=
 -w =2E ]; then</span><br><span>     echo &quot;current directory is not wr=
itable (required for logging)=2E FAIL=2E&quot; &gt;&amp;2</span><br><span> =
    exit 1</span><br><span> fi</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-if [ -z &quot;$CA_CERT&quot; ] ; then</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;CA_CERT not defin=
ed in &#39;t_client=2Erc&#39;=2E SKIP test=2E&quot; &gt;&amp;2</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+openvpn_version=3D$(${openvpn} -=
-version | head -n 1 | cut -f2 -d&quot; &quot; | sed -E &#39;s/^2\=2E([0123=
456789]+)=2E*$/2\1/&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+needs_openvpn=
()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    needs_version=3D$1</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    [ &quot;$openvpn_version&quot; -ge &quot;$needs=
_version&quot; ]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return $?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+=2E &quot;${t_client_rc}&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+if [ -z &quot;$TEST_RUN_LIST&quot; ]; then</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    echo &quot;TEST_RUN_LIST em=
pty, no tests defined=2E  SKIP test=2E&quot; &gt;&amp;2</span><br><span>   =
  exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span> fi</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ -z &quot;$TEST_R=
UN_LIST&quot; ] ; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    echo &quot;TEST_RUN_LIST empty, no tests defined=2E  SKIP test=2E&quot=
; &gt;&amp;2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    exit =
&quot;${TCLIENT_SKIP_RC}&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+if [ -n &quot;$TEST_RUN_GROUP&quot; ]; then</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    FILTERED_LIST=3D</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    for test in $TEST_RUN_LIST; do</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        group=3D$(echo $=
test | sed -E &#39;s/^([0123456789]+)=2E*/\1/&#39;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if [ &quot;$group&quot; =3D &quot=
;$TEST_RUN_GROUP&quot; ]; then</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            FILTERED_LIST=3D&quot;$FILTERED_LIST $test&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        fi</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    done</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if [ -z &quot;$FILTERED_LIST&quot; ];=
 then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        echo &=
quot;Filtered TEST_RUN_LIST empty (group=3D$TEST_RUN_GROUP), no tests defin=
ed=2E  SKIP test=2E&quot; &gt;&amp;2</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    TEST_RUN_LIST=3D$FILTERED_LIST</span><br><s=
pan> fi</span><br><span> </span><br><span> # Ensure PREFER_KSU is in a know=
n state</span><br><span>@@ -77,16 +102,14 @@</span><br><span> </span><br><s=
pan> # make sure we have permissions to run ifconfig/route from OpenVPN</sp=
an><br><span> # can&#39;t use &quot;id -u&quot; here - doesn&#39;t work on =
Solaris</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ID=3D`id`</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-if expr &quot;$ID&quot; : =
&quot;uid=3D0&quot; &gt;/dev/null</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-then :</span><br><span style=3D"color: hsl(120, 100%, 40%);">+I=
D=3D$(id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if expr &q=
uot;$ID&quot; : &quot;uid=3D0&quot; &gt;/dev/null; then</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    :</span><br><span> else</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if [ &quot;${PREFER_KSU}&quot=
; -eq 1 ];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    then</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ &quot;${PREFE=
R_KSU}&quot; -eq 1 ]; then</span><br><span>         # Check if we have a va=
lid kerberos ticket</span><br><span>         klist -l 1&gt;/dev/null 2&gt;/=
dev/null</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if [ =
$? -ne 0 ];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        th=
en</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if [ $? -=
ne 0 ]; then</span><br><span>             # No kerberos ticket found, skip =
ksu and fallback to RUN_SUDO</span><br><span>             PREFER_KSU=3D0</s=
pan><br><span>             echo &quot;$0: No Kerberos ticket available=2E  =
Will not use ksu=2E&quot;</span><br><span>@@ -95,8 +118,7 @@</span><br><spa=
n>         fi</span><br><span>     fi</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if [ -z &quot;$RUN_SUDO&quot; ]</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    then</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if [ -z &quot;$RUN_SUDO&quot; ]; t=
hen</span><br><span>         echo &quot;$0: this test must run be as root, =
or RUN_SUDO=3D=2E=2E=2E &quot; &gt;&amp;2</span><br><span>         echo &qu=
ot;      must be set correctly in &#39;t_client=2Erc&#39;=2E SKIP=2E&quot; =
&gt;&amp;2</span><br><span>         exit &quot;${TCLIENT_SKIP_RC}&quot;</sp=
an><br><span>@@ -104,20 +126,22 @@</span><br><span>         # We have to us=
e sudo=2E Make sure that we (hopefully) do not have</span><br><span>       =
  # to ask the users password during the test=2E This is done to</span><br>=
<span>         # prevent timing issues, e=2Eg=2E when the waits for openvpn=
 to start</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	if $RUN_SUD=
O $KILL_EXEC -0 $$</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	th=
en</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    echo &quot;$0:=
 $RUN_SUDO $KILL_EXEC -0 succeeded, good=2E&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	else</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-	    echo &quot;$0: $RUN_SUDO $KILL_EXEC -0 failed, cannot go o=
n=2E SKIP=2E&quot; &gt;&amp;2</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-	    exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-	fi</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if $RUN_SUDO $KILL_EXEC -0 $$; then</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            echo &quot;$0: $RUN_SUDO $KI=
LL_EXEC -0 succeeded, good=2E&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            echo &quot;$0: $RUN_SUDO $KILL_EXEC -0 failed, cannot =
go on=2E SKIP=2E&quot; &gt;&amp;2</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        fi</span><br><span>     f=
i</span><br><span> fi</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-LOGDIR=3Dt_client-`hostname`-`date +%Y%m%d-%H%M%S`</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+LOGDIR=3Dt_client-$(hostna=
me)-$(date +%Y%m%d-%H%M%S)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+if [ -n &quot;$TEST_RUN_GROUP&quot; ]; then</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    LOGDIR=3D&quot;${LOGDIR}-${TEST_RUN_GROU=
P}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fi</span><b=
r><span> LOGDIR_ABS=3D&quot;$PWD/$LOGDIR&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-if mkdir $LOGDIR</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-then :</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+if mkdir $LOGDIR; then</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    :</span><br><span> else</span><br><span>     echo &quot;can&#=
39;t create log directory &#39;$LOGDIR&#39;=2E FAIL=2E&quot; &gt;&amp;2</sp=
an><br><span>     exit 1</span><br><span>@@ -137,21 +161,28 @@</span><br><s=
pan> output_start()</span><br><span> {</span><br><span>     case $V in</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-	0) outbuf=3D&quot;&quot; =
;;			# no per-test output at all</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-	1) printf &quot;$@\n&quot;			# compact, details only on failure=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           outbuf=3D&=
quot;\n&quot; ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	*) p=
rintf &quot;\n$@\n&quot; ;;		# print all, with a bit formatting</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        0) outbuf=3D&quot;&quot=
; ;; # no per-test output at all</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        1)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            printf &quot;$@\n&quot; # compact, details only on failure<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            outbuf=
=3D&quot;\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 *) printf &quot;\n$@\n&quot; ;; # print all, with a bit formatting</span><=
br><span>     esac</span><br><span> }</span><br><span> </span><br><span> ou=
tput()</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    END_NL=3D&quot;\n&quot;; if [ &quot;X$1&quot; =3D &quot;X-n&quot; ]=
 ; then END_NL=3D&quot;&quot; ; shift ; fi</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    END_NL=3D&quot;\n&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if [ &quot;X$1&quot; =3D &quot;X-n&quot;=
 ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        END=
_NL=3D&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       shift</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi<=
/span><br><span>     case $V in</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	0) ;;				# no per-test output at all</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-	1) outbuf=3D&quot;$outbuf$@${END_NL}&quot;	# pri=
nt details only on failure</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-           ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	*)=
 printf &quot;$@${END_NL}&quot; ;;	# print everything</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        0) ;; # no per-test output at all=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        1)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            outbuf=3D&quot;$=
outbuf$@${END_NL}&quot; # print details only on failure</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            ;;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        *) printf &quot;$@${END_NL}&quot; ;;=
 # print everything</span><br><span>     esac</span><br><span> }</span><br>=
<span> </span><br><span>@@ -159,62 +190,61 @@</span><br><span> fail()</span=
><br><span> {</span><br><span>     output &quot;FAIL: $@\n&quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    fail_count=3D$(( $fail_count=
 + 1 ))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fail_cou=
nt=3D$((fail_count + 1))</span><br><span> }</span><br><span> </span><br><sp=
an> # print &quot;all interface IP addresses&quot; + &quot;all routes&quot;=
</span><br><span> # this is higly system dependent=2E=2E=2E</span><br><span=
> get_ifconfig_route()</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    UNAME=3D`uname -s`</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    UNAME=3D$(uname -s)</span><br><span>     case $U=
NAME in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	Linux)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        Linux)</span><br><=
span>             # linux / iproute2? (-&gt; if configure got a path)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            if [ -n &quot;@=
IPROUTE@&quot; ]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    if [ -n &quot;@IPROUTE@&quot; ]; then</span><br><span>                 =
echo &quot;-- linux iproute2 --&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                @IPROUTE@ addr show     | grep -v valid_lft=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                @IP=
ROUTE@ addr show | grep -v valid_lft</span><br><span>                 @IPRO=
UTE@ route show</span><br><span>                 @IPROUTE@ -o -6 route show=
 | grep -v &#39; cache&#39; | sed -E -e &#39;s/ expires [0-9]*sec//&#39; -e=
 &#39;s/ (mtu|hoplimit|cwnd|ssthresh) [0-9]+//g&#39; -e &#39;s/ (rtt|rttvar=
) [0-9]+ms//g&#39;</span><br><span>             else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	        echo &quot;-- linux / ifconfig --&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	        LANG=3D=
C @IFCONFIG@ -a |egrep  &quot;( addr:|encap:)&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	        LANG=3DC @NETSTAT@ -rn -4 -6</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                echo &quo=
t;-- linux / ifconfig --&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                LANG=3DC @IFCONFIG@ -a | egrep &quot;( addr:|enc=
ap:)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       LANG=3DC @NETSTAT@ -rn -4 -6</span><br><span>             fi</span><=
br><span>             ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-	FreeBSD|NetBSD|Darwin)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	   echo &quot;-- FreeBSD/NetBSD/Darwin [MacOS X] --&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	   @IFCONFIG@ -a | egrep &quot;(=
flags=3D|inet)&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
   @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print $1,$2,$3,$NF }&#39;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-	   ;;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	OpenBSD)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-	   echo &quot;-- OpenBSD --&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-	   @IFCONFIG@ -a | egrep &quot;(flags=3D|=
inet)&quot; | \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		sed =
-e &#39;s/pltime [0-9]*//&#39; -e &#39;s/vltime [0-9]*//&#39;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-	   @NETSTAT@ -rn | awk &#39;$3 !~ =
/^UHL/ { print $1,$2,$3,$NF }&#39;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	   ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	S=
unOS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   echo &quot;-=
- Solaris --&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	  =
 @IFCONFIG@ -a | egrep &quot;(flags=3D|inet)&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	   @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { pr=
int $1,$2,$3,$6 }&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	   ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	AIX)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-	   echo &quot;-- AIX --&quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   @IFCONFIG@ -a | e=
grep &quot;(flags=3D|inet)&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-	   @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print $1,$2,$3,$6 }&=
#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   ;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        FreeBSD | NetBSD | Dar=
win)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ech=
o &quot;-- FreeBSD/NetBSD/Darwin [MacOS X] --&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            @IFCONFIG@ -a | egrep &quot;(=
flags=3D|inet)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print $1,$2,$3,$NF }&#=
39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        OpenBSD)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            echo &quot;-=
- OpenBSD --&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           @IFCONFIG@ -a | egrep &quot;(flags=3D|inet)&quot; |</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                sed -e &#39;s/pl=
time [0-9]*//&#39; -e &#39;s/vltime [0-9]*//&#39;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            @NETSTAT@ -rn | awk &#39;$3 !~ /^=
UHL/ { print $1,$2,$3,$NF }&#39;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            ;;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        SunOS)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            echo &quot;-- Solaris --&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            @IFCONFIG@ -a | egrep &quot;(flags=3D=
|inet)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print $1,$2,$3,$6 }&#39;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            ;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        AIX)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            echo &quot;-- AIX --&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            @IFCON=
FIG@ -a | egrep &quot;(flags=3D|inet)&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ {=
 print $1,$2,$3,$6 }&#39;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            ;;</span><br><span>         *)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-           echo &quot;get_ifconfig_route(): no i=
dea how to get info on your OS (`uname -s`)=2E  FAIL=2E&quot; &gt;&amp;2</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-           exit 20</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-           ;;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            echo &quot;get_ifconf=
ig_route(): no idea how to get info on your OS ($(uname -s))=2E  FAIL=2E&qu=
ot; &gt;&amp;2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       exit 20</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       ;;</span><br><span>     esac</span><br><span> </span><br><span>     =
# another round of per-platform information gathering, for DNS info</span><=
br><span>     # for most of the platforms &quot;cat /etc/resolv=2Econf&quot=
; is good enough</span><br><span>     # except Linux and MacOS</span><br><s=
pan>     case $UNAME in</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	Linux)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
if [ -x /usr/bin/resolvectl -a -d /run/systemd/system ] ; then</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        Linux)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            if [ -x /usr/bin/resolvec=
tl -a -d /run/systemd/system ]; then</span><br><span>                 echo =
&quot;-- linux resolvectl --&quot;</span><br><span>                 resolve=
ctl status</span><br><span>             else</span><br><span>@@ -222,7 +252=
,7 @@</span><br><span>                 cat /etc/resolv=2Econf</span><br><sp=
an>             fi</span><br><span>             ;;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	Darwin)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        Darwin)</span><br><span>             echo &quot;-=
- MacOS scutil --dns&quot;</span><br><span>             scutil --dns</span>=
<br><span>             ;;</span><br><span>@@ -260,19 +290,19 @@</span><br><=
span> #  arg2: IPv4/IPv6 address that must show up in out of &quot;get_ifco=
nfig_route&quot;</span><br><span> check_ifconfig()</span><br><span> {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    proto=3D$1 ; shift</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    proto=3D$1</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    shift</span><br><span>   =
  expect_list=3D&quot;$@&quot;</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if [ -z &quot;$expect_list&quot; ] ; then re=
turn ; fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if [ &qu=
ot;$expect_list&quot; =3D &quot;-&quot; ] ; then return ; fi</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if [ -z &quot;$expect_list&quo=
t; ]; then return; fi</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if [ &quot;$expect_list&quot; =3D &quot;-&quot; ]; then return; fi</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    fo=
r expect in $expect_list</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	if get_ifco=
nfig_route | fgrep &quot;$expect&quot; &gt;/dev/null</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	then :</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-	else</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	    fail &quot;check_ifconfig(): expected IPv$proto address &#39;$expect=
&#39; not found in ifconfig output=2E&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	fi</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    for expect in $expect_list; do</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if get_ifconfig_route | fgrep &quot;$expect&qu=
ot; &gt;/dev/null; then</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            :</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   fail &quot;check_ifconfig(): expected IPv$proto address &#39;$expect&#39=
; not found in ifconfig output=2E&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        fi</span><br><span>     done</span><br><span> }=
</span><br><span> </span><br><span>@@ -283,47 +313,48 @@</span><br><span> #=
  arg3=2E=2E=2E -&gt; fping arguments (host list)</span><br><span> run_ping=
_tests()</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    proto=3D$1 ; want=3D$2 ; shift ; shift</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    proto=3D$1</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    want=3D$2</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    shift</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    shift</span><br><span>     targetlist=3D&quot;$@&quot;</span><b=
r><span> </span><br><span>     # &quot;no targets&quot; is fine</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if [ -z &quot;$targetlist&quo=
t; ] ; then return ; fi</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if [ -z &quot;$targetlist&quot; ]; then return; fi</span><br><span>=
 </span><br><span>     case $proto in</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	4) cmd=3D&quot;$FPING&quot; ;;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-	6) cmd=3D&quot;$FPING6&quot; ;;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	*) echo &quot;internal error in run_p=
ing_tests arg 1: &#39;$proto&#39;&quot; &gt;&amp;2</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	   exit 1 ;;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        4) cmd=3D&quot;$FPING&quot; ;;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        6) cmd=3D&quot;$FPING6&qu=
ot; ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            echo &quot=
;internal error in run_ping_tests arg 1: &#39;$proto&#39;&quot; &gt;&amp;2<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            exit 1</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ;;</span>=
<br><span>     esac</span><br><span> </span><br><span>     case $want in</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	want_ok)   sizes_list=
=3D&quot;64 1440 3000&quot; ;;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-	want_fail) sizes_list=3D&quot;64&quot; ;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        want_ok) sizes_list=3D&quot;64 14=
40 3000&quot; ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     want_fail) sizes_list=3D&quot;64&quot; ;;</span><br><span>     esac</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    fo=
r bytes in $sizes_list</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	output &quot;=
run IPv$proto ping tests ($want), $bytes byte packets=2E=2E=2E&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    for bytes in $sizes_li=
st; do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        outpu=
t &quot;run IPv$proto ping tests ($want), $bytes byte packets=2E=2E=2E&quot=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	e=
cho &quot;$cmd -b $bytes -C 20 -p 250 -q $fping_args $targetlist&quot; &gt;=
&gt;$LOGDIR/$SUF:fping=2Eout</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-	$cmd -b $bytes -C 20 -p 250 -q $fping_args $targetlist &gt;&gt;$LOG=
DIR/$SUF:fping=2Eout 2&gt;&amp;1</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        echo &quot;$cmd -b $bytes -C 20 -p 250 -q $fping_args =
$targetlist&quot; &gt;&gt;$LOGDIR/$SUF:fping=2Eout</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        $cmd -b $bytes -C 20 -p 250 -q $fpin=
g_args $targetlist &gt;&gt;$LOGDIR/$SUF:fping=2Eout 2&gt;&amp;1</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	# while OpenVP=
N is running, pings must succeed (want=3D&#39;want_ok&#39;)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-	# before OpenVPN is up, pings must N=
OT succeed (want=3D&#39;want_fail&#39;)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        # while OpenVPN is running, pings must succeed =
(want=3D&#39;want_ok&#39;)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        # before OpenVPN is up, pings must NOT succeed (want=3D&#39;=
want_fail&#39;)</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-	rc=3D$?</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
if [ $rc =3D 0 ] 				# all ping OK</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	  =
  if [ $want =3D &quot;want_fail&quot; ]		# not what we want</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	    then</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-		fail &quot;IPv$proto ping test succeeded, but =
needs to *fail*=2E&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-	    fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	else					#=
 ping failed</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    if [=
 $want =3D &quot;want_ok&quot; ]		# not what we wanted</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-	    then</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-		fail &quot;IPv$proto ping test ($bytes bytes) failed=
, but should succeed=2E&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-	    fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	fi</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        rc=3D$?</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if [ $rc =3D 0 ]; =
then                 # all ping OK</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            if [ $want =3D &quot;want_fail&quot; ]; then # n=
ot what we want</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            fail &quot;IPv$proto ping test succeeded, but needs to *fail*=
=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else   =
                            # ping failed</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            if [ $want =3D &quot;want_ok&quot; ]; the=
n # not what we wanted</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                fail &quot;IPv$proto ping test ($bytes bytes) failed, bu=
t should succeed=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        fi</span><br><span>     done</span><br><span> }</span><br><span> <=
/span><br><span>@@ -334,8 +365,7 @@</span><br><span> SUMMARY_SKIP=3D</span>=
<br><span> SUMMARY_FAIL=3D</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-for SUF in $TEST_RUN_LIST</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-do</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+for SUF in $TEST_RUN_LIST; do</span><br><span>     # get config v=
ariables</span><br><span>     eval test_prep=3D\&quot;\$PREPARE_$SUF\&quot;=
</span><br><span>     eval test_check_skip=3D\&quot;\$CHECK_SKIP_$SUF\&quot=
;</span><br><span>@@ -347,26 +377,32 @@</span><br><span>     eval expect_if=
config6=3D\&quot;\$EXPECT_IFCONFIG6_$SUF\&quot;</span><br><span>     eval p=
ing4_hosts=3D\&quot;\$PING4_HOSTS_$SUF\&quot;</span><br><span>     eval pin=
g6_hosts=3D\&quot;\$PING6_HOSTS_$SUF\&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    eval expect_fail=3D\&quot;\$EXPECT_FAIL_$SUF\&q=
uot;</span><br><span>     eval fping_args=3D\&quot;\$FPING_EXTRA_ARGS \$FPI=
NG_ARGS_$SUF\&quot;</span><br><span> </span><br><span>     # If EXCEPT_IFCO=
NFIG* variables for this test are missing, run an --up</span><br><span>    =
 # script to generate them dynamically=2E</span><br><span>     if [ -z &quo=
t;$expect_ifconfig4&quot; ] || [ -z &quot;$expect_ifconfig6&quot; ]; then</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        up=3D&quot;--se=
tenv TESTNUM $SUF --setenv TOP_BUILDDIR ${top_builddir} --script-security 2=
 --up ${srcdir}/update_t_client_ips=2Esh&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        up=3D&quot;--setenv TESTNUM $SUF --seten=
v RC ${t_client_ips_rc} --script-security 2 --up ${update_t_client_ips}&quo=
t;</span><br><span>     else</span><br><span>         up=3D&quot;&quot;</sp=
an><br><span>     fi</span><br><span> </span><br><span>     output_start &q=
uot;### test run $SUF: &#39;$test_run_title&#39; ###&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if [ -n &quot;$expect_fail&quot;=
 ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        out=
put &quot;### expect failure: &#39;$expect_fail&#39;&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span>     fail_cou=
nt=3D0</span><br><span> </span><br><span>     if [ -n &quot;$test_check_ski=
p&quot; ]; then</span><br><span>         output &quot;check whether we need=
 to skip: &#39;$test_check_skip&#39;&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if eval $test_check_skip; then :</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if eval $test_check_skip;=
 then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            :<=
/span><br><span>         else</span><br><span>             output &quot;ski=
p check failed, SKIP test $SUF=2E&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-	    SUMMARY_SKIP=3D&quot;$SUMMARY_SKIP $SUF&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-	    printf &quot;$outbuf&qu=
ot; ; continue</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       SUMMARY_SKIP=3D&quot;$SUMMARY_SKIP $SUF&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            printf &quot;$outbuf&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            continue</=
span><br><span>         fi</span><br><span>     fi</span><br><span> </span>=
<br><span>@@ -385,13 +421,14 @@</span><br><span>     output &quot;\nrun pre=
-openvpn ping tests - targets must not be reachable=2E=2E=2E&quot;</span><b=
r><span>     run_ping_tests 4 want_fail &quot;$ping4_hosts&quot;</span><br>=
<span>     run_ping_tests 6 want_fail &quot;$ping6_hosts&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if [ &quot;$fail_count&quot; =
=3D 0 ] ; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f [ &quot;$fail_count&quot; =3D 0 ]; then</span><br><span>         output &=
quot;OK=2E\n&quot;</span><br><span>     else</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-	fail &quot;make sure that ping hosts are ONLY reach=
able via VPN, SKIP test $SUF=2E&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	exit_code=3D31</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-	printf &quot;$outbuf&quot; ; continue</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fail &quot;ma=
ke sure that ping hosts are ONLY reachable via VPN, SKIP test $SUF=2E&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        SUMMARY_FAI=
L=3D&quot;$SUMMARY_FAIL $SUF&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        exit_code=3D31</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        printf &quot;$outbuf&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        continue</span><br><span>     fi<=
/span><br><span> </span><br><span>     pidfile=3D&quot;$LOGDIR_ABS/openvpn-=
$SUF=2Epid&quot;</span><br><span>@@ -406,38 +443,77 @@</span><br><span>    =
 # to $ovpn_init_check times=2E</span><br><span>     ovpn_init_check=3D30</=
span><br><span>     ovpn_init_success=3D0</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    while [ $ovpn_init_check -gt 0 ];</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    do</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-       sleep 1  # Wait for OpenVPN to initialize and h=
ave had time to write the pid file</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-       grep &quot;Initialization Sequence Completed&quot; $LOG=
DIR/$SUF:openvpn=2Elog &gt;/dev/null</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-       if [ $? -eq 0 ]; then</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-           ovpn_init_check=3D0</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-           ovpn_init_success=3D1</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-       fi</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-       ovpn_init_check=3D$(( $ovpn_init_che=
ck - 1 ))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while =
[ $ovpn_init_check -gt 0 ]; do</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        sleep 1 # Wait for OpenVPN to initialize and to write th=
e pid file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f [ -n &quot;$expect_fail&quot; ]; then</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            grep &quot;$expect_fail&quot; $LOGDIR/$SUF:=
openvpn=2Elog &gt;/dev/null</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            if [ $? -eq 0 ]; then</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                ovpn_init_check=3D0</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                ovpn_init_success=3D1=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                sle=
ep 5 # give openvpn time to quit</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            fi</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            grep &quot;Initialization Sequence Completed&quot; $LOGDIR/$SU=
F:openvpn=2Elog &gt;/dev/null</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            if [ $? -eq 0 ]; then</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                ovpn_init_check=3D0</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                ovpn_init_success=
=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            fi<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fi</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        ovpn_init_check=3D$((=
ovpn_init_check - 1))</span><br><span>     done</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    opid=3D`cat $pidfile`</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    opid=3D$([ -e $pidfil=
e ] &amp;&amp; cat $pidfile)</span><br><span>     if [ -n &quot;$opid&quot;=
 ]; then</span><br><span>         output &quot;  OpenVPN running with PID $=
opid&quot;</span><br><span>     else</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        output &quot;  Could not read OpenVPN PID file&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if [ -z &qu=
ot;$expect_fail&quot; ]; then # print this only if unexpected</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            output &quot;  Could =
not read OpenVPN PID file&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        fi</span><br><span>     fi</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    # If OpenVPN did not start</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # did we expect a=
 failure?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ -=
n &quot;$expect_fail&quot; ]; then</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if [ -n &quot;$opid&quot; ]; then # OpenVPN did star=
t!</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            outpu=
t &quot;$0: OpenVPN did start up, expected failure&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            $RUN_SUDO $KILL_EXEC $opid=
 $sudopid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  output &quot;tail -5 $SUF:openvpn=2Elog&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            output &quot;$(tail -5 $LOGDIR/$SUF=
:openvpn=2Elog)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            fail &quot;skip rest of sub-tests for test run $SUF=2E&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            trap - 0=
 1 2 3 15</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            exit_code=3D32</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            printf &quot;$outbuf&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            continue<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        elif [ $ovpn=
_init_success -eq 0 ]; then</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            output &quot;$0: OpenVPN failure did not match expected=
 failure&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       output &quot;tail -5 $SUF:openvpn=2Elog&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            output &quot;$(tail -5 $LOGDI=
R/$SUF:openvpn=2Elog)&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            exit_code=3D33</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            printf &qu=
ot;$outbuf&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         continue</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   output &quot;test run $SUF: all tests OK (saw expected failure)=2E&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            SUMMARY=
_OK=3D&quot;$SUMMARY_OK $SUF&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            continue</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        fi</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    # If OpenVPN did not =
start but should have</span><br><span>     if [ $ovpn_init_success -ne 1 -o=
 -z &quot;$opid&quot; ]; then</span><br><span>         output &quot;$0:  Op=
enVPN did not initialize in a reasonable time&quot;</span><br><span>       =
  if [ -n &quot;$opid&quot; ]; then</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-           $RUN_SUDO $KILL_EXEC $opid</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            $RUN_SUDO $KILL_EXEC $opid</s=
pan><br><span>         fi</span><br><span>         $RUN_SUDO $KILL_EXEC $su=
dopid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	output &quot;ta=
il -5 $SUF:openvpn=2Elog&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-	output &quot;`tail -5 $LOGDIR/$SUF:openvpn=2Elog`&quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-	fail &quot;skip rest of sub-te=
sts for test run $SUF=2E&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-	trap - 0 1 2 3 15</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-	SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	exit_code=3D30</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-	printf &quot;$outbuf&quot; ; continue</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        output &quot;tail -5 $=
SUF:openvpn=2Elog&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        output &quot;$(tail -5 $LOGDIR/$SUF:openvpn=2Elog)&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        fail &quot;skip re=
st of sub-tests for test run $SUF=2E&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        trap - 0 1 2 3 15</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SU=
F&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        exit=
_code=3D30</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        p=
rintf &quot;$outbuf&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        continue</span><br><span>     fi</span><br><span> </span><br>=
<span>     # make sure openvpn client is terminated in case shell exits</sp=
an><br><span>@@ -452,17 +528,16 @@</span><br><span>         exit 1</span><b=
r><span>     fi</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if [ &quot;$expect_ifconfig4&quot; =3D &quot;-&quot; ] ; th=
en</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ &quot;$e=
xpect_ifconfig4&quot; =3D &quot;-&quot; ]; then</span><br><span>         ou=
tput &quot;skip ifconfig+route check&quot;</span><br><span>     else</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-	output -n &quot;compare pre=
-openvpn ifconfig+route with current values=2E=2E=2E&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	if diff $LOGDIR/$SUF:ifconfig_route_p=
re=2Etxt \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		$LOGDIR/$=
SUF:ifconfig_route=2Etxt &gt;/dev/null</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-	then</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	    fail &quot;no differences between ifconfig/route before OpenVPN start=
 and now=2E&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	els=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    output &quot; O=
K!\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	fi</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        output -n &quot;com=
pare pre-openvpn ifconfig+route with current values=2E=2E=2E&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if diff $LOGDIR/$SUF=
:ifconfig_route_pre=2Etxt \</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            $LOGDIR/$SUF:ifconfig_route=2Etxt &gt;/dev/null; then</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            fail &quo=
t;no differences between ifconfig/route before OpenVPN start and now=2E&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            output &quot=
; OK!\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  fi</span><br><span>     fi</span><br><span> </span><br><span>     # post =
init script needed?</span><br><span>@@ -483,8 +558,8 @@</span><br><span>   =
  $RUN_SUDO $KILL_EXEC $opid</span><br><span>     wait $!</span><br><span> =
    rc=3D$?</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if [ $=
rc !=3D 0 ] ; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	fa=
il &quot;OpenVPN return code $rc, expect 0&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if [ $rc !=3D 0 ]; then</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        fail &quot;OpenVPN return code=
 $rc, expect 0&quot;</span><br><span>     fi</span><br><span> </span><br><s=
pan>     output &quot;\nsave post-openvpn ifconfig + route=2E=2E=2E&quot;</=
span><br><span>@@ -496,23 +571,22 @@</span><br><span> </span><br><span>    =
 output -n &quot;compare pre- and post-openvpn ifconfig + route=2E=2E=2E&qu=
ot;</span><br><span>     if diff $LOGDIR/$SUF:ifconfig_route_pre=2Etxt \</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	    $LOGDIR/$SUF:ifconf=
ig_route_post=2Etxt &gt;$LOGDIR/$SUF:ifconfig_route_diff=2Etxt</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    then</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	output &quot; OK=2E\n&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        $LOGDIR/$SUF:ifconfig_route_po=
st=2Etxt &gt;$LOGDIR/$SUF:ifconfig_route_diff=2Etxt; then</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        output &quot; OK=2E\n&quot;</=
span><br><span>     else</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-	output &quot;\n\n&quot; &quot;`cat $LOGDIR/$SUF:ifconfig_route_diff=2Et=
xt`&quot; &quot;\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-	fail &quot;differences between pre- and post-ifconfig/route=2E&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        output &quot;\=
n\n&quot; &quot;$(cat $LOGDIR/$SUF:ifconfig_route_diff=2Etxt)&quot; &quot;\=
n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fail=
 &quot;differences between pre- and post-ifconfig/route=2E&quot;</span><br>=
<span>     fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if [=
 &quot;$fail_count&quot; =3D 0 ] ; then</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if [ &quot;$fail_count&quot; =3D 0 ]; then</span><b=
r><span>         output &quot;test run $SUF: all tests OK=2E\n&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-	SUMMARY_OK=3D&quot;$SUMMARY=
_OK $SUF&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   SUMMARY_OK=3D&quot;$SUMMARY_OK $SUF&quot;</span><br><span>     else</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-	if [ &quot;$V&quot; -gt 0=
 ] ; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    printf =
&quot;$outbuf&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	 =
   echo &quot;test run $SUF: $fail_count test failures=2E FAIL=2E&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if [ &quot;$V&q=
uot; -gt 0 ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           printf &quot;$outbuf&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            echo &quot;test run $SUF: $fail_count test fa=
ilures=2E FAIL=2E&quot;</span><br><span>         fi</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	exit_code=3D30</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        SUMMARY_FAIL=
=3D&quot;$SUMMARY_FAIL $SUF&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        exit_code=3D30</span><br><span>     fi</span><br><spa=
n> </span><br><span>     if [ -n &quot;$test_cleanup&quot; ]; then</span><b=
r><span>@@ -522,9 +596,9 @@</span><br><span> </span><br><span> done</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ -z &qu=
ot;$SUMMARY_OK&quot; ] ; then SUMMARY_OK=3D&quot; none&quot;; fi</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-if [ -z &quot;$SUMMARY_SKIP&quot=
; ] ; then SUMMARY_SKIP=3D&quot; none&quot;; fi</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-if [ -z &quot;$SUMMARY_FAIL&quot; ] ; then SUMMAR=
Y_FAIL=3D&quot; none&quot;; fi</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+if [ -z &quot;$SUMMARY_OK&quot; ]; then SUMMARY_OK=3D&quot; none=
&quot;; fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ -z &=
quot;$SUMMARY_SKIP&quot; ]; then SUMMARY_SKIP=3D&quot; none&quot;; fi</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ -z &quot;$SUMMARY_FA=
IL&quot; ]; then SUMMARY_FAIL=3D&quot; none&quot;; fi</span><br><span> echo=
 &quot;Test sets succeeded:$SUMMARY_OK=2E&quot;</span><br><span> echo &quot=
;Test sets skipped:$SUMMARY_SKIP=2E&quot;</span><br><span> echo &quot;Test =
sets failed:$SUMMARY_FAIL=2E&quot;</span><br><span>diff --git a/tests/updat=
e_t_client_ips=2Esh b/tests/update_t_client_ips=2Esh</span><br><span>index =
96e3826=2E=2Ef02dc7f 100755</span><br><span>--- a/tests/update_t_client_ips=
=2Esh</span><br><span>+++ b/tests/update_t_client_ips=2Esh</span><br><span>=
@@ -3,14 +3,12 @@</span><br><span> # This --up script caches the IPs handed=
 out by the test VPN server to a file</span><br><span> # for later use=2E</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-RC=3D=
&quot;$TOP_BUILDDIR/t_client_ips=2Erc&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-grep EXPECT_IFCONFIG4_$TESTNUM=3D $RC &gt; /dev/null 2&gt;&amp;1</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+grep EXPECT_IFCONFIG4_$TESTNU=
M=3D $RC &gt;/dev/null 2&gt;&amp;1</span><br><span> if [ $? -ne 0 ]; then</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;EXPECT_I=
FCONFIG4_$TESTNUM=3D$ifconfig_local&quot; &gt;&gt; $RC</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    echo &quot;EXPECT_IFCONFIG4_$TESTNUM=
=3D$ifconfig_local&quot; &gt;&gt;$RC</span><br><span> fi</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-grep EXPECT_IFCONFIG6_=
$TESTNUM=3D $RC &gt; /dev/null 2&gt;&amp;1</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+grep EXPECT_IFCONFIG6_$TESTNUM=3D $RC &gt;/dev/null =
2&gt;&amp;1</span><br><span> if [ $? -ne 0 ]; then</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    echo &quot;EXPECT_IFCONFIG6_$TESTNUM=3D$if=
config_ipv6_local&quot; &gt;&gt; $RC</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    echo &quot;EXPECT_IFCONFIG6_$TESTNUM=3D$ifconfig_ipv6_=
local&quot; &gt;&gt;$RC</span><br><span> fi</span><br></pre><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2141?usp=3Demail">=
change 2141</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/214=
1?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: release/2=2E7 </div>
<div style=3D"display:none">=
 Gerrit-Change-Id: I13f9f7dd61d7a4cc986155629f6a3c792aaac6d2 </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Number: 2141 </div>
<div style=3D"displ=
ay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Own=
er: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body>=
</html>
--jjYf5YgK2CQ=--


--===============1205575418226430454==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1205575418226430454==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1205575418226430454==--

