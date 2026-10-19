Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A71CCF2DA
	for <openvpn-devel@archiver.kernel.org>; Mon, 19 Oct 2026 10:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=XAcyy+Igqnt1uRDVrzNc/u1iB+pvJLFVrKrCqU26lJk=; b=mcP7HUXCQ8PpAm
	AgEVXKpdCIP4VpfH2QRC0tDQAHq2pufCIFoQGC3hswSD77O/CpwO8oMdTpXaERIf2CHwJAZ6KtpFM
	En/g1kxsnacYH/Itcx6j1WvRLTGaCk1e9yiiJJ4zVLzLjl0qzUJqF0x5wSCut7shq/t7ZRrxKsS8n
	hto=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIkTG-0001B6-LI;
	Mon, 19 Oct 2026 10:19:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIkTF-0001Az-Cf
 for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 10:19:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JLUG1L3AGjLyoJnVCoI7Vwfr/iFiHKxTZE2FTC5sW/w=; b=dwfNIVhwaizprXKUrRchX9sToh
 EUrnqq3ET3q69tQphz5jrPYXZRYRiLZaMMfpyQSQvMpEGqsFEheTvcwtNDalDuvgciyNO6frnLPGK
 P/dc/NtffloUnDEM/4QKqamRWPlUKyz+CkkbuJjvZVoloHjazuHKm3I8fuA5vC6/DXhg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JLUG1L3AGjLyoJnVCoI7Vwfr/iFiHKxTZE2FTC5sW/w=; b=Q
 xVvWZA956ojKjJWhPBA4q+2O+oImh6rG/azFy47u4XiYqSTIR4KVDWpjKupNnuzzhIrn/QPFip7Kx
 gWKKdKocs/R7KLjGlIZRP9bcaTr2evHgQjpqGHnMIl7g/4q0MP4/h62GUVsfyHM6bwzzowcPA+NCP
 cHl6d6WmQRgS9v/M=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIkTA-0006o0-Ql for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 10:19:54 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a1635f7c89so19161535e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 19 Oct 2026 03:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792405186; x=1793009986; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JLUG1L3AGjLyoJnVCoI7Vwfr/iFiHKxTZE2FTC5sW/w=;
 b=IAnlrBF50wktDOi3YLHcDdxaVhs6+j5ljSREW18l6MDBgiQO5mE2Ccfaep7dR3a0uG
 dm8TdjVdKC+yBZDkU7Ln1/qEgWvbH1VsFCZDUErYXjHPo+xwHNj7NFmz34xWVYkm6wd3
 8+rgNueS80tus+kqmdfmlqmk3/P42Jf0PBIVFHs7j7G/UXkjqdv2+sGH4qwKTFZ/m3HW
 /rlgtpBQ7OmqfpaRd6w49dmdqUhx/TEGmN4+/2T47uuVBNnpMzPTqljTuN3SIXp6zhOb
 xVeyosNS/Xdb64PSJIGuCHL3k+uqIKXxUyNEDXeHS6eQIJxtMlCbfCj9QK1RQn0j25iE
 Fw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792405186; x=1793009986;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JLUG1L3AGjLyoJnVCoI7Vwfr/iFiHKxTZE2FTC5sW/w=;
 b=yKs6Fqr3vB21dQEpE+Lk8HFTxwVy7tteQ/3zjXoogolAcVFH2BwODWEJPPTUWTrlMj
 hj2xcQ60aWHmxMqMAcLGMPDiqcT31bUn5Vx+uWL2Zq0VzgqnPiNSqDDqCuCDLePXAvYk
 H1vA1BogFCngZra2J8FkTslG+ShKquqLP02x1Af0ieCJaq9dlA08yyL0pmyc8ISN0/2j
 mt6aBuzYhHpkvmn9xJCGXxg2EhGxPt877KF2zY00IOv2WUA3c9pJfV2K7ZQT2OkZI55M
 E9V7SkXzWy8qpwrt0++4NP5Fbm8lCTEOYPRSeSkTCdzubru9/fEw/czoJV+4jIQFO/KV
 bwLg==
X-Gm-Message-State: AFq9FYIRljHndXbA0o1Xu+Nt6xi2YAzS+IH839WwZczVo0T9dayXzWCt
 /EH2EtLDqKx2oFZW8+WtVE0yXR1xynwcO3OaGmBWv380e4tMxLl1563zjtKrGvChbzBNodzVE2I
 1/tVrf47gjDD5nvlE48+TzDFFTaKtcHb/G5Oy8RZDmb772mJiMcSP30NyYikpWEUQU6OmEbSPMh
 MPE/StPw==
X-Gm-Gg: AYBFou3ngd2i0RvOfhaWZMRkfjr4CbQOZdr0u0BHZhfArIC/RolqTQwPiOcERR51qhW
 x6HG1z4gv9gJSuOvBND3/OSeP1/gZHoNnpOi8o6ggPQWRNUoco41b6ucxpm+ffgWpxEbNwJ0QrA
 CAHwQtlr46LxMWxw8/fojU1rS2w5jvvyl+uhslW+CRyaTANzyXtglfx6OdQBOiUqMLE4imKPvKB
 J2EWbnd25wtRcktUvNg1zoZ0cM4/+GnNkRQTfkIXHCqyRYUhRSOEQtV8yuV7SZAfkk4anWWnUXk
 qauTvDoS0nZH3Yon664gXi9flD3QMxHGgwCBaMsuqrrIHwM3Qaur3ajIrEftm4ZfvGt7dV5rSVn
 IaLseyPha/RUxW4gaO/5T/FeXcPTwWp2c4iRPg7qINdCsTaA1MpudKNVDCzBaN7qerMEbUoBNk2
 AV7NEyTzKtBrJiQkKdTwzt0htU99ZawGXBIWU0wKVZlHOI9X+zb0xvxZWjdp7vX8YQPOR49zBHD
 RuoaLZX/54GXALeSKXuFndIRpGWVT1gwn/+hWcYJFAoWPjl35fcz/dTKgQYLPNx14PMsRSgGj0+
 NmcCkdnlwcOobqqzqyJJxlQNYR3qv+GsMtMKtrfojOWzXHgjUnaTVDjSsEWB
X-Received: by 2002:a05:600c:4503:b0:4a0:a34:6e7d with SMTP id
 5b1f17b1804b1-4a1d7614e56mr165224345e9.18.1792405185981; 
 Mon, 19 Oct 2026 03:19:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1d85f92d9sm191662875e9.4.2026.10.19.03.19.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:19:45 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 19 Oct 2026 10:19:45 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I149d0ba7011e62a115a565813e1f5873907d464e
X-Gerrit-Change-Number: 2022
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2022?usp=email>
X-Gerrit-Commit: 3db18c73c453fff97f95abb0fce091e09530564b
References: <gerrit.1792405183000.I149d0ba7011e62a115a565813e1f5873907d464e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNDA1MTgzMDAwLkkxNDlkMGJhNzAxMWU2MmExMTVhNTY1ODEzZTFmNTg3MzkwN2Q0NjRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4e5ef811dcf1084772616a15df5a145decce4b05-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIkTA-0006o0-Ql
Subject: [Openvpn-devel] [S] Change in openvpn[master]: automake: Add
 build-tests recursive target
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5011607241300717954=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5011607241300717954==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RJJVZZ4wsIc="; charset=UTF-8

--RJJVZZ4wsIc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2022?usp=3Demail

to review the following change=2E
=


Change subject: automake: Add build-tests recursive target
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

automake: Add build-tests=
 recursive target

So that we can build unit-tests without running them=2E
=
Something automake doesn't seem to offer out of the
box=2E

Change-Id: I149=
d0ba7011e62a115a565813e1f5873907d464e
Signed-off-by: Frank Lichtenheld <fra=
nk@lichtenheld=2Ecom>
---
M configure=2Eac
M tests/unit_tests/example_test/=
Makefile=2Eam
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_tests/o=
penvpnserv/Makefile=2Eam
M tests/unit_tests/plugins/auth-pam/Makefile=2Eam
=
5 files changed, 10 insertions(+), 0 deletions(-)



  git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/22/2022/1

diff --git a/config=
ure=2Eac b/configure=2Eac
index e83aba7=2E=2E83ed4d4 100644
--- a/configure=
=2Eac
+++ b/configure=2Eac
@@ -59,6 +59,8 @@
 AC_CANONICAL_HOST
 AC_USE_SYS=
TEM_EXTENSIONS
 
+AM_EXTRA_RECURSIVE_TARGETS([build-tests])
+
 AX_CODE_COVE=
RAGE
 
 AC_ARG_ENABLE(
diff --git a/tests/unit_tests/example_test/Makefile=
=2Eam b/tests/unit_tests/example_test/Makefile=2Eam
index 1ae80c8=2E=2E942e=
9d1 100644
--- a/tests/unit_tests/example_test/Makefile=2Eam
+++ b/tests/un=
it_tests/example_test/Makefile=2Eam
@@ -15,3 +15,5 @@
 example2_testdriver_=
CFLAGS  =3D @TEST_CFLAGS@
 example2_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
 =
example2_testdriver_SOURCES =3D test2=2Ec
+
+build-tests-local: $(check_PRO=
GRAMS)
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tes=
ts/openvpn/Makefile=2Eam
index 38299f5=2E=2E43a6743 100644
--- a/tests/unit=
_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@=
@ -445,3 +445,5 @@
 	$(top_srcdir)/src/openvpn/env_set=2Ec \
 	$(top_srcdir=
)/src/openvpn/run_command=2Ec \
 	$(top_srcdir)/src/openvpn/socket_util=2Ec=

+
+build-tests-local: $(check_PROGRAMS)
diff --git a/tests/unit_tests/open=
vpnserv/Makefile=2Eam b/tests/unit_tests/openvpnserv/Makefile=2Eam
index 19=
de666=2E=2E210c9e6 100644
--- a/tests/unit_tests/openvpnserv/Makefile=2Eam
=
+++ b/tests/unit_tests/openvpnserv/Makefile=2Eam
@@ -14,3 +14,5 @@
 	$(top_=
srcdir)/src/openvpnserv/validate=2Ec \
 	$(top_srcdir)/src//openvpn/wfp_blo=
ck=2Ec \
 	$(top_srcdir)/src//openvpn/wfp_block=2Eh
+
+build-tests-local: $=
(check_PROGRAMS)
diff --git a/tests/unit_tests/plugins/auth-pam/Makefile=2E=
am b/tests/unit_tests/plugins/auth-pam/Makefile=2Eam
index 7da299c=2E=2Efd7=
cf91 100644
--- a/tests/unit_tests/plugins/auth-pam/Makefile=2Eam
+++ b/tes=
ts/unit_tests/plugins/auth-pam/Makefile=2Eam
@@ -12,3 +12,5 @@
 auth_pam_te=
stdriver_SOURCES =3D test_search_and_replace=2Ec  $(top_srcdir)/src/plugins=
/auth-pam/utils=2Eh $(top_srcdir)/src/plugins/auth-pam/utils=2Ec
 auth_pam_=
testdriver_CFLAGS  =3D @TEST_CFLAGS@ -I$(top_srcdir)/src/plugins/auth-pam
 =
auth_pam_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
+
+build-tests-local: $(chec=
k_PROGRAMS)

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2022?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newc=
hange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I149d=
0ba7011e62a115a565813e1f5873907d464e
Gerrit-Change-Number: 2022
Gerrit-Patc=
hSet: 1
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Re=
viewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <a=
rne-openvpn@rfc2549=2Eorg>

--RJJVZZ4wsIc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2022?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">automake: Add build-tests recursive target<br><br>So that =
we can build unit-tests without running them=2E<br>Something automake doesn=
&#39;t seem to offer out of the<br>box=2E<br><br>Change-Id: I149d0ba7011e62=
a115a565813e1f5873907d464e<br>Signed-off-by: Frank Lichtenheld &lt;frank@li=
chtenheld=2Ecom&gt;<br>---<br>M configure=2Eac<br>M tests/unit_tests/exampl=
e_test/Makefile=2Eam<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests=
/unit_tests/openvpnserv/Makefile=2Eam<br>M tests/unit_tests/plugins/auth-pa=
m/Makefile=2Eam<br>5 files changed, 10 insertions(+), 0 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/22/2022/1</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/configure=2Eac b/configure=2Eac</=
span><br><span>index e83aba7=2E=2E83ed4d4 100644</span><br><span>--- a/conf=
igure=2Eac</span><br><span>+++ b/configure=2Eac</span><br><span>@@ -59,6 +5=
9,8 @@</span><br><span> AC_CANONICAL_HOST</span><br><span> AC_USE_SYSTEM_EX=
TENSIONS</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+AM_EXTRA_RECURSIVE_TARGETS([build-tests])</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> AX_CODE_COVERAGE</span><br><=
span> </span><br><span> AC_ARG_ENABLE(</span><br><span>diff --git a/tests/u=
nit_tests/example_test/Makefile=2Eam b/tests/unit_tests/example_test/Makefi=
le=2Eam</span><br><span>index 1ae80c8=2E=2E942e9d1 100644</span><br><span>-=
-- a/tests/unit_tests/example_test/Makefile=2Eam</span><br><span>+++ b/test=
s/unit_tests/example_test/Makefile=2Eam</span><br><span>@@ -15,3 +15,5 @@</=
span><br><span> example2_testdriver_CFLAGS  =3D @TEST_CFLAGS@</span><br><sp=
an> example2_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span> example=
2_testdriver_SOURCES =3D test2=2Ec</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buil=
d-tests-local: $(check_PROGRAMS)</span><br><span>diff --git a/tests/unit_te=
sts/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><b=
r><span>index 38299f5=2E=2E43a6743 100644</span><br><span>--- a/tests/unit_=
tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/=
Makefile=2Eam</span><br><span>@@ -445,3 +445,5 @@</span><br><span> 	$(top_s=
rcdir)/src/openvpn/env_set=2Ec \</span><br><span> 	$(top_srcdir)/src/openvp=
n/run_command=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/socket_util=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+build-tests-local: $(check_PROGRAM=
S)</span><br><span>diff --git a/tests/unit_tests/openvpnserv/Makefile=2Eam =
b/tests/unit_tests/openvpnserv/Makefile=2Eam</span><br><span>index 19de666=
=2E=2E210c9e6 100644</span><br><span>--- a/tests/unit_tests/openvpnserv/Mak=
efile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpnserv/Makefile=2Eam=
</span><br><span>@@ -14,3 +14,5 @@</span><br><span> 	$(top_srcdir)/src/open=
vpnserv/validate=2Ec \</span><br><span> 	$(top_srcdir)/src//openvpn/wfp_blo=
ck=2Ec \</span><br><span> 	$(top_srcdir)/src//openvpn/wfp_block=2Eh</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+build-tests-local: $(check_PROGRAMS)</span><br=
><span>diff --git a/tests/unit_tests/plugins/auth-pam/Makefile=2Eam b/tests=
/unit_tests/plugins/auth-pam/Makefile=2Eam</span><br><span>index 7da299c=2E=
=2Efd7cf91 100644</span><br><span>--- a/tests/unit_tests/plugins/auth-pam/M=
akefile=2Eam</span><br><span>+++ b/tests/unit_tests/plugins/auth-pam/Makefi=
le=2Eam</span><br><span>@@ -12,3 +12,5 @@</span><br><span> auth_pam_testdri=
ver_SOURCES =3D test_search_and_replace=2Ec  $(top_srcdir)/src/plugins/auth=
-pam/utils=2Eh $(top_srcdir)/src/plugins/auth-pam/utils=2Ec</span><br><span=
> auth_pam_testdriver_CFLAGS  =3D @TEST_CFLAGS@ -I$(top_srcdir)/src/plugins=
/auth-pam</span><br><span> auth_pam_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+build-tests-local: $(check_PROGRAMS)</sp=
an><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2022?usp=3Demail">change 2022</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2022?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn=
 </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Id: I149d0ba7011e62a115a565813e1f5873907d=
464e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2022 </div>
=
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--RJJVZZ4wsIc=--


--===============5011607241300717954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5011607241300717954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5011607241300717954==--

