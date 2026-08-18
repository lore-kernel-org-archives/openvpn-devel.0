Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BD6C5DF84
	for <openvpn-devel@archiver.kernel.org>; Tue, 18 Aug 2026 14:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x5SrV4pyGSJgbUftvWFK2ShId7r5kW7CKR+9eQUgD+o=; b=gnwlLxizcX7jp6SgfqUQYm5Hhv
	PWi1HubXRHe6Z1Ey1BKt6LDaSE6q9oux2zxDelAksUMjurTtIbh82Zs1oX8pEqaA19ipsJ+GVdq3w
	4dB3UK58Ew3QIHfjxPU9F8njY7bkYF2VKcgROOLHisLTPmwGaiQOPskIaX1wdg42mrBw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwKTT-0006Vy-Jg;
	Tue, 18 Aug 2026 14:07:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwKT5-0006VI-WE
 for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 14:07:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=IxdSZLSn57UCo0luSbtTCLS7xiV0/3943gCwIiB3YaY=; b=QfxxQogCxxDq4o6lJuL3qc0dH1
 y1cmrZfC+Uy54XizpW1Tagaz4h5i5mgkWt5QJ0c8TiGhPo1Sa5oOO8ds6WcSL5OqEvAB/M264tzIT
 F8IAQBIMb+FDvzO8GQR0SvzckakVFBYf29XFQ5td8Ky5vAU2Hzn/J2I3L25OtRkIpyo8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=IxdSZLSn57UCo0luSbtTCLS7xiV0/3943gCwIiB3YaY=; b=U
 69/koqGGK9qLq8R2FSP3GR03340r0haOHDOK5MDUW8KsHbFtYzOuanVNQ9Hy6AWG6IrKLpcUrbWOJ
 EEQV8EhrWVNjjuh8eabAcxtLiY6iw4XL3c4/xxme9FNo+5dLngi1+hslyiOVq2wCWZnKSd2YxmYc3
 ecHpYvUORO5wS7WU=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwKSv-0000YG-G9 for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 14:06:57 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-482938466a7so3060363f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 18 Aug 2026 07:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787062007; x=1787666807; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IxdSZLSn57UCo0luSbtTCLS7xiV0/3943gCwIiB3YaY=;
 b=bLSLTzKoVMo1OPUkS7AiS726Rqc6K+L8yqZIEtUsCTDzdxWWQgLc/aDQ40shT/mIfQ
 zDUjJiSAclzdVjT5D6Vm589RY/rkmKgJlvfJcubIQT+vBWv4IX3x2bXRWPYsVXbohmm+
 nUfn0w4rWmO/mHMzHlwIh7qHJ6BBt6bSCM9i7A6Bj42t0wg8tKGyyiDWRXVSNOLQ5OG4
 BTo7H8lpQXVpvC8zMe51+N6kqzy96ntV7J8rPPK0DePO6SnqODVz07CUp5pv51mu0gtv
 PsJD8/jBWqQQNlLP6gr4v3gqyT1VRkDgGjErKCjZAiGtcTmb8p/AUCxgiSe3/hKgCAwQ
 gpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787062007; x=1787666807;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IxdSZLSn57UCo0luSbtTCLS7xiV0/3943gCwIiB3YaY=;
 b=Q3YIWBTBx0ayq6n7yCg73YyEnJiOlQUdergrGHsfTEl2+kCFq/bbbfoDIZRxNjjeUu
 tTC2GRi6lYrHRRHjGidyUT+fyMBN2haKSgo3Egohw/HoaDTxJhQpLOuqOWw7fnBycGkI
 1mL+TK4FqkNTWR0Rl5h5HCznp3hxiUU1nbGbYGlMLK5ZgyZ/9h4opzOb4mfAhhXAxVQN
 oIZPi0EiAWTsu3zKI5HnmgrNY3x0YlejVG5RB4wT79EThadvKCvPy39TWGupuYJwYp+h
 qH7e6+t04cvByG/otKM5zYWyGo0IJvNr03t0aHs+lbzJZ9HmFjf+q4gNmK6hDgKe/eIj
 meCQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RokzgCmlgIctPA+Z4FTh7N7nwQNq+5pJ82yxpTKfw5PFGIuDRaPvVvgH6WiBEpWQwM6gKs3IozaMkPyUuiA@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx9AW7TZn3MAKiRt3vaShkHflPP/YxGPC05ZdgUxnoREudf3dvk
 uTBmACoWMEHfqB+xijIfU3rSN14LCw+WT2QFdF13lxWxQPbeKBIk4046LGwfLVAnJ4Yq+kv8Q6D
 tvX+xCGdESulUFf2TmXA1HAU9TQxQPAZ5OjzAmft/vaoAVOexi76l6cbHYg1oySllmC3p
X-Gm-Gg: AR+sD133hNvFje03HkK+4FqzHWUzx3oEVeRV2jxcWa09dCq7blGoH9x8GkvJdDjM10v
 P7cwA+CZ4WVrJjjp9oc/XEucKoHDLtxSkPkDSo9BSwqFLHrr0TUYz/BsaOP/n9+ZCXtOwRf8yBl
 pIV0E/HmMcJGz4bPEeKqr5YyUXq451xewjU9fm2dHzRZX/fSR0ntTHqhqj33RgNvQTS8ZAun8xk
 QQCFPftBk5D0W7+pDxVPNJfZx9z3wDCn88Dne1BVlJ+jGtF8M/0Jlyi7Xf2t09VSxFAqzsCmYUN
 DLH8zDzgznDw9o7+xf8ysGzMSx3DFGy+MFLH8BEXs8PtJhiuFlQfceXswX2Ir4qRHaJaoxwTEDe
 43qeCn215P6TTVub7lgWOBythqukePp+ZT26GMCQxmpXN/uDuBxnS9o2NKg3EEmV4i+11umnnjy
 bLBFQk23IoVMF+KIIpjI2af2Zg+/+rhncsOgn+hpyQt8ITwlhE7rEIF2xTw7Awl7yPZ0V/CbX4W
 lwkzkVTUQi/Ha7miQepe/UAN5Ti5h5FwD5w/JqH+h1a7Ou+WqySRLkGBQcKMQmKJMv1EuY6KTPE
 tGBi2BY2QAvdWBzcjEe+F+E/IlKIyPv/Uni0Egmd7Z5wmxqiDCc=
X-Received: by 2002:a05:6000:2612:b0:47f:c648:e265 with SMTP id
 ffacd0b85a97d-48160758afcmr57672456f8f.17.1787062007000; 
 Tue, 18 Aug 2026 07:06:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3b896sm12818767f8f.16.2026.08.18.07.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 07:06:46 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 18 Aug 2026 14:06:46 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iba7e5e553679ec0cf47cb2e5d9b2fb1859ea767c
X-Gerrit-Change-Number: 1591
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1591?usp=email>
X-Gerrit-Commit: 4f81de14de7c9f7ca371236f5d30e0d6ba9d6449
In-Reply-To: <gerrit.1774451380000.Iba7e5e553679ec0cf47cb2e5d9b2fb1859ea767c@gerrit.openvpn.net>
References: <gerrit.1774451380000.Iba7e5e553679ec0cf47cb2e5d9b2fb1859ea767c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc0NDUxMzgwMDAwLkliYTdlNWU1NTM2NzllYzBjZjQ3Y2IyZTVkOWIyZmIxODU5ZWE3NjdjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1a3ec7ae57bec5caa83273daa581b95d9d5c0a11-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwKSv-0000YG-G9
Subject: [Openvpn-devel] [L] Change in openvpn[master]: m4: Add
 ax_code_coverage
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
Content-Type: multipart/mixed; boundary="===============4369417130645642115=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4369417130645642115==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OjUC6WFxJ+k="; charset=UTF-8

--OjUC6WFxJ+k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1591?usp=3Demail )

Change subject: m4: Add ax_code_coverage
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

m4: Add ax_code_covera=
ge

Putting this into a separate commit, so that
we can easier track change=
s we need to do to it=2E
(As the autoconf-archive in general this seems
mos=
tly abandonded)=2E

Change-Id: Iba7e5e553679ec0cf47cb2e5d9b2fb1859ea767c
Si=
gned-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan C=
ojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1591
Message-Id: <20260817131536=2E21559-1-gert@greenie=2Emuc=
=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg38448=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
A m4/ax_code_coverage=2Em4
1 file changed, 273 insertions(+), 0 =
deletions(-)




diff --git a/m4/ax_code_coverage=2Em4 b/m4/ax_code_coverag=
e=2Em4
new file mode 100644
index 0000000=2E=2E216708a4
--- /dev/null
+++ b=
/m4/ax_code_coverage=2Em4
@@ -0,0 +1,273 @@
+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+#     https://www=2Egnu=
=2Eorg/software/autoconf-archive/ax_code_coverage=2Ehtml
+# =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+#
+# SYNOPSIS=

+#
+#   AX_CODE_COVERAGE()
+#
+# DESCRIPTION
+#
+#   Defines CODE_COVERAGE=
_CPPFLAGS, CODE_COVERAGE_CFLAGS,
+#   CODE_COVERAGE_CXXFLAGS and CODE_COVER=
AGE_LIBS which should be included
+#   in the CPPFLAGS, CFLAGS CXXFLAGS and=
 LIBS/LIBADD variables of every
+#   build target (program or library) whic=
h should be built with code
+#   coverage support=2E Also add rules using A=
X_ADD_AM_MACRO_STATIC; and
+#   $enable_code_coverage which can be used in =
subsequent configure output=2E
+#   CODE_COVERAGE_ENABLED is defined and su=
bstituted, and corresponds to the
+#   value of the --enable-code-coverage =
option, which defaults to being
+#   disabled=2E
+#
+#   Test also for gcov=
 program and create GCOV variable that could be
+#   substituted=2E
+#
+#  =
 Note that all optimization flags in CFLAGS must be disabled when code
+#  =
 coverage is enabled=2E
+#
+#   Usage example:
+#
+#   configure=2Eac:
+#
+=
#     AX_CODE_COVERAGE
+#
+#   Makefile=2Eam:
+#
+#     include $(top_srcdi=
r)/aminclude_static=2Eam
+#
+#     my_program_LIBS =3D =2E=2E=2E $(CODE_COV=
ERAGE_LIBS) =2E=2E=2E
+#     my_program_CPPFLAGS =3D =2E=2E=2E $(CODE_COVER=
AGE_CPPFLAGS) =2E=2E=2E
+#     my_program_CFLAGS =3D =2E=2E=2E $(CODE_COVER=
AGE_CFLAGS) =2E=2E=2E
+#     my_program_CXXFLAGS =3D =2E=2E=2E $(CODE_COVER=
AGE_CXXFLAGS) =2E=2E=2E
+#
+#     clean-local: code-coverage-clean
+#     d=
istclean-local: code-coverage-dist-clean
+#
+#   This results in a "check-c=
ode-coverage" rule being added to any
+#   Makefile=2Eam which do "include =
$(top_srcdir)/aminclude_static=2Eam"
+#   (assuming the module has been con=
figured with --enable-code-coverage)=2E
+#   Running `make check-code-cover=
age` in that directory will run the
+#   module's test suite (`make check`)=
 and build a code coverage report
+#   detailing the code which was touched=
, then print the URI for the report=2E
+#
+#   This code was derived from M=
akefile=2Edecl in GLib, originally licensed
+#   under LGPLv2=2E1+=2E
+#
+#=
 LICENSE
+#
+#   Copyright (c) 2012, 2016 Philip Withnall
+#   Copyright (c=
) 2012 Xan Lopez
+#   Copyright (c) 2012 Christian Persch
+#   Copyright (c=
) 2012 Paolo Borelli
+#   Copyright (c) 2012 Dan Winship
+#   Copyright (c)=
 2015,2018 Bastien ROUCARIES
+#
+#   This library is free software; you can=
 redistribute it and/or modify it
+#   under the terms of the GNU Lesser Ge=
neral Public License as published by
+#   the Free Software Foundation; eit=
her version 2=2E1 of the License, or (at
+#   your option) any later versio=
n=2E
+#
+#   This library is distributed in the hope that it will be useful=
, but
+#   WITHOUT ANY WARRANTY; without even the implied warranty of
+#   =
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E See the GNU Lesser
+=
#   General Public License for more details=2E
+#
+#   You should have rece=
ived a copy of the GNU Lesser General Public License
+#   along with this p=
rogram=2E If not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+
+#serial 37
=
+
+m4_define(_AX_CODE_COVERAGE_RULES,[
+AX_ADD_AM_MACRO_STATIC([
+# Code co=
verage
+#
+# Optional:
+#  - CODE_COVERAGE_DIRECTORY: Top-level directory f=
or code coverage reporting=2E
+#    Multiple directories may be specified, =
separated by whitespace=2E
+#    (Default: \$(top_builddir))
+#  - CODE_COV=
ERAGE_OUTPUT_FILE: Filename and path for the =2Einfo file generated
+#    b=
y lcov for code coverage=2E (Default:
+#    \$(PACKAGE_NAME)-\$(PACKAGE_VER=
SION)-coverage=2Einfo)
+#  - CODE_COVERAGE_OUTPUT_DIRECTORY: Directory for =
generated code coverage
+#    reports to be created=2E (Default:
+#    \$(P=
ACKAGE_NAME)-\$(PACKAGE_VERSION)-coverage)
+#  - CODE_COVERAGE_BRANCH_COVER=
AGE: Set to 1 to enforce branch coverage,
+#    set to 0 to disable it and =
leave empty to stay with the default=2E
+#    (Default: empty)
+#  - CODE_C=
OVERAGE_LCOV_SHOPTS_DEFAULT: Extra options shared between both lcov
+#    i=
nstances=2E (Default: based on $CODE_COVERAGE_BRANCH_COVERAGE)
+#  - CODE_C=
OVERAGE_LCOV_SHOPTS: Extra options to shared between both lcov
+#    instan=
ces=2E (Default: $CODE_COVERAGE_LCOV_SHOPTS_DEFAULT)
+#  - CODE_COVERAGE_LC=
OV_OPTIONS_GCOVPATH: --gcov-tool pathtogcov
+#  - CODE_COVERAGE_LCOV_OPTION=
S_DEFAULT: Extra options to pass to the
+#    collecting lcov instance=2E (=
Default: $CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH)
+#  - CODE_COVERAGE_LCOV_OPT=
IONS: Extra options to pass to the collecting lcov
+#    instance=2E (Defau=
lt: $CODE_COVERAGE_LCOV_OPTIONS_DEFAULT)
+#  - CODE_COVERAGE_LCOV_RMOPTS_DE=
FAULT: Extra options to pass to the filtering
+#    lcov instance=2E (Defau=
lt: empty)
+#  - CODE_COVERAGE_LCOV_RMOPTS: Extra options to pass to the fi=
ltering lcov
+#    instance=2E (Default: $CODE_COVERAGE_LCOV_RMOPTS_DEFAULT=
)
+#  - CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT: Extra options to pass to the=

+#    genhtml instance=2E (Default: based on $CODE_COVERAGE_BRANCH_COVERAG=
E)
+#  - CODE_COVERAGE_GENHTML_OPTIONS: Extra options to pass to the genhtm=
l
+#    instance=2E (Default: $CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT)
+#  -=
 CODE_COVERAGE_IGNORE_PATTERN: Extra glob pattern of files to ignore
+#
+# =
The generated report will be titled using the \$(PACKAGE_NAME) and
+# \$(PA=
CKAGE_VERSION)=2E In order to add the current git hash to the title,
+# use=
 the git-version-gen script, available online=2E
+# Optional variables
+# r=
un only on top dir
+if CODE_COVERAGE_ENABLED
+ ifeq (\$(abs_builddir), \$(a=
bs_top_builddir))
+CODE_COVERAGE_DIRECTORY ?=3D \$(top_builddir)
+CODE_COVE=
RAGE_OUTPUT_FILE ?=3D \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-coverage=2Einfo
=
+CODE_COVERAGE_OUTPUT_DIRECTORY ?=3D \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-c=
overage
+
+CODE_COVERAGE_BRANCH_COVERAGE ?=3D
+CODE_COVERAGE_LCOV_SHOPTS_DE=
FAULT ?=3D \$(if \$(CODE_COVERAGE_BRANCH_COVERAGE),\
+--rc lcov_branch_cove=
rage=3D\$(CODE_COVERAGE_BRANCH_COVERAGE))
+CODE_COVERAGE_LCOV_SHOPTS ?=3D \=
$(CODE_COVERAGE_LCOV_SHOPTS_DEFAULT)
+CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH ?=
=3D --gcov-tool \"\$(GCOV)\"
+CODE_COVERAGE_LCOV_OPTIONS_DEFAULT ?=3D \$(CO=
DE_COVERAGE_LCOV_OPTIONS_GCOVPATH)
+CODE_COVERAGE_LCOV_OPTIONS ?=3D \$(CODE=
_COVERAGE_LCOV_OPTIONS_DEFAULT)
+CODE_COVERAGE_LCOV_RMOPTS_DEFAULT ?=3D
+CO=
DE_COVERAGE_LCOV_RMOPTS ?=3D \$(CODE_COVERAGE_LCOV_RMOPTS_DEFAULT)
+CODE_CO=
VERAGE_GENHTML_OPTIONS_DEFAULT ?=3D\
+\$(if \$(CODE_COVERAGE_BRANCH_COVERAG=
E),\
+--rc genhtml_branch_coverage=3D\$(CODE_COVERAGE_BRANCH_COVERAGE))
+CO=
DE_COVERAGE_GENHTML_OPTIONS ?=3D \$(CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT)
=
+CODE_COVERAGE_IGNORE_PATTERN ?=3D
+
+GITIGNOREFILES :=3D \$(GITIGNOREFILES=
) \$(CODE_COVERAGE_OUTPUT_FILE) \$(CODE_COVERAGE_OUTPUT_DIRECTORY)
+code_co=
verage_v_lcov_cap =3D \$(code_coverage_v_lcov_cap_\$(V))
+code_coverage_v_l=
cov_cap_ =3D \$(code_coverage_v_lcov_cap_\$(AM_DEFAULT_VERBOSITY))
+code_co=
verage_v_lcov_cap_0 =3D @echo \"  LCOV   --capture\" \$(CODE_COVERAGE_OUTPU=
T_FILE);
+code_coverage_v_lcov_ign =3D \$(code_coverage_v_lcov_ign_\$(V))
+=
code_coverage_v_lcov_ign_ =3D \$(code_coverage_v_lcov_ign_\$(AM_DEFAULT_VER=
BOSITY))
+code_coverage_v_lcov_ign_0 =3D @echo \"  LCOV   --remove\" \"\$(C=
ODE_COVERAGE_OUTPUT_FILE)=2Etmp\" \$(CODE_COVERAGE_IGNORE_PATTERN);
+code_c=
overage_v_genhtml =3D \$(code_coverage_v_genhtml_\$(V))
+code_coverage_v_ge=
nhtml_ =3D \$(code_coverage_v_genhtml_\$(AM_DEFAULT_VERBOSITY))
+code_cover=
age_v_genhtml_0 =3D @echo \"  GEN   \" \"\$(CODE_COVERAGE_OUTPUT_DIRECTORY)=
\";
+code_coverage_quiet =3D \$(code_coverage_quiet_\$(V))
+code_coverage_q=
uiet_ =3D \$(code_coverage_quiet_\$(AM_DEFAULT_VERBOSITY))
+code_coverage_q=
uiet_0 =3D --quiet
+
+# sanitizes the test-name: replaces with underscores:=
 dashes and dots
+code_coverage_sanitize =3D \$(subst -,_,\$(subst =2E,_,\$=
(1)))
+
+# Use recursive makes in order to ignore errors during check
+chec=
k-code-coverage:
+	-\$(AM_V_at)\$(MAKE) \$(AM_MAKEFLAGS) -k check
+	\$(AM_V=
_at)\$(MAKE) \$(AM_MAKEFLAGS) code-coverage-capture
+
+# Capture code cover=
age data
+code-coverage-capture: code-coverage-capture-hook
+	\$(code_cover=
age_v_lcov_cap)\$(LCOV) \$(code_coverage_quiet) \$(addprefix --directory ,\=
$(CODE_COVERAGE_DIRECTORY)) --capture --output-file \"\$(CODE_COVERAGE_OUTP=
UT_FILE)=2Etmp\" --test-name \"\$(call code_coverage_sanitize,\$(PACKAGE_NA=
ME)-\$(PACKAGE_VERSION))\" --no-checksum --compat-libtool \$(CODE_COVERAGE_=
LCOV_SHOPTS) \$(CODE_COVERAGE_LCOV_OPTIONS)
+	\$(code_coverage_v_lcov_ign)\=
$(LCOV) \$(code_coverage_quiet) \$(addprefix --directory ,\$(CODE_COVERAGE_=
DIRECTORY)) --remove \"\$(CODE_COVERAGE_OUTPUT_FILE)=2Etmp\" \$(CODE_COVERA=
GE_IGNORE_PATTERN) --output-file \"\$(CODE_COVERAGE_OUTPUT_FILE)\" \$(CODE_=
COVERAGE_LCOV_SHOPTS) \$(CODE_COVERAGE_LCOV_RMOPTS)
+	-@rm -f \"\$(CODE_COV=
ERAGE_OUTPUT_FILE)=2Etmp\"
+	\$(code_coverage_v_genhtml)LANG=3DC \$(GENHTML=
) \$(code_coverage_quiet) \$(addprefix --prefix ,\$(CODE_COVERAGE_DIRECTORY=
)) --output-directory \"\$(CODE_COVERAGE_OUTPUT_DIRECTORY)\" --title \"\$(P=
ACKAGE_NAME)-\$(PACKAGE_VERSION) Code Coverage\" --legend --show-details \"=
\$(CODE_COVERAGE_OUTPUT_FILE)\" \$(CODE_COVERAGE_GENHTML_OPTIONS)
+	@echo \=
"file://\$(abs_builddir)/\$(CODE_COVERAGE_OUTPUT_DIRECTORY)/index=2Ehtml\"
=
+
+code-coverage-clean:
+	-\$(LCOV) --directory \$(top_builddir) -z
+	-rm -=
rf \"\$(CODE_COVERAGE_OUTPUT_FILE)\" \"\$(CODE_COVERAGE_OUTPUT_FILE)=2Etmp\=
" \"\$(CODE_COVERAGE_OUTPUT_DIRECTORY)\"
+	-find =2E \\( -name \"*=2Egcda\"=
 -o -name \"*=2Egcno\" -o -name \"*=2Egcov\" \\) -delete
+
+code-coverage-d=
ist-clean:
+
+A][M_DISTCHECK_CONFIGURE_FLAGS :=3D \$(A][M_DISTCHECK_CONFIGU=
RE_FLAGS) --disable-code-coverage
+ else # ifneq (\$(abs_builddir), \$(abs_=
top_builddir))
+check-code-coverage:
+
+code-coverage-capture: code-coverag=
e-capture-hook
+
+code-coverage-clean:
+
+code-coverage-dist-clean:
+ endif=
 # ifeq (\$(abs_builddir), \$(abs_top_builddir))
+else #! CODE_COVERAGE_ENA=
BLED
+# Use recursive makes in order to ignore errors during check
+check-c=
ode-coverage:
+	@echo \"Need to reconfigure with --enable-code-coverage\"
+=
# Capture code coverage data
+code-coverage-capture: code-coverage-capture-=
hook
+	@echo \"Need to reconfigure with --enable-code-coverage\"
+
+code-co=
verage-clean:
+
+code-coverage-dist-clean:
+
+endif #CODE_COVERAGE_ENABLED
=
+# Hook rule executed before code-coverage-capture, overridable by the user=

+code-coverage-capture-hook:
+
+=2EPHONY: check-code-coverage code-coverag=
e-capture code-coverage-dist-clean code-coverage-clean code-coverage-captur=
e-hook
+])
+])
+
+AC_DEFUN([_AX_CODE_COVERAGE_ENABLED],[
+	AX_CHECK_GNU_MAK=
E([],[AC_MSG_ERROR([not using GNU make that is needed for coverage])])
+	AC=
_REQUIRE([AX_ADD_AM_MACRO_STATIC])
+	# check for gcov
+	AC_CHECK_TOOL([GCOV=
],
+		  [$_AX_CODE_COVERAGE_GCOV_PROG_WITH],
+		  [:])
+	AS_IF([test "X$GCO=
V" =3D "X:"],
+	      [AC_MSG_ERROR([gcov is needed to do coverage])])
+	AC=
_SUBST([GCOV])
+
+	dnl Check if gcc is being used
+	AS_IF([ test "$GCC" =3D=
 "no" ], [
+		AC_MSG_ERROR([not compiling with gcc, which is required for g=
cov code coverage])
+	      ])
+
+	AC_CHECK_PROG([LCOV], [lcov], [lcov])
+	=
AC_CHECK_PROG([GENHTML], [genhtml], [genhtml])
+
+	AS_IF([ test x"$LCOV" =
=3D x ], [
+		AC_MSG_ERROR([To enable code coverage reporting you must have=
 lcov installed])
+	      ])
+
+	AS_IF([ test x"$GENHTML" =3D x ], [
+		AC_=
MSG_ERROR([Could not find genhtml from the lcov package])
+	])
+
+	AC_CHECK=
_LIB([gcov], [_gcov_init], [CODE_COVERAGE_LIBS=3D"-lgcov"], [CODE_COVERAGE_=
LIBS=3D""])
+
+	dnl Build the code coverage flags
+	dnl Define CODE_COVERAG=
E_LDFLAGS for backwards compatibility
+	CODE_COVERAGE_CPPFLAGS=3D"-DNDEBUG"=

+	CODE_COVERAGE_CFLAGS=3D"-O0 -g -fprofile-arcs -ftest-coverage"
+	CODE_CO=
VERAGE_CXXFLAGS=3D"-O0 -g -fprofile-arcs -ftest-coverage"
+
+	AC_SUBST([COD=
E_COVERAGE_CPPFLAGS])
+	AC_SUBST([CODE_COVERAGE_CFLAGS])
+	AC_SUBST([CODE_C=
OVERAGE_CXXFLAGS])
+	AC_SUBST([CODE_COVERAGE_LIBS])
+])
+
+AC_DEFUN([AX_COD=
E_COVERAGE],[
+	dnl Check for --enable-code-coverage
+
+	# allow to overrid=
e gcov location
+	AC_ARG_WITH([gcov],
+	  [AS_HELP_STRING([--with-gcov[=3DG=
COV]], [use given GCOV for coverage (GCOV=3Dgcov)=2E])],
+	  [_AX_CODE_COVE=
RAGE_GCOV_PROG_WITH=3D$with_gcov],
+	  [_AX_CODE_COVERAGE_GCOV_PROG_WITH=3D=
gcov])
+
+	AC_MSG_CHECKING([whether to build with code coverage support])
+=
	AC_ARG_ENABLE([code-coverage],
+	  AS_HELP_STRING([--enable-code-coverage]=
,
+	  [Whether to enable code coverage support]),,
+	  enable_code_coverage=
=3Dno)
+
+	AM_CONDITIONAL([CODE_COVERAGE_ENABLED], [test "x$enable_code_cov=
erage" =3D xyes])
+	AC_SUBST([CODE_COVERAGE_ENABLED], [$enable_code_coverag=
e])
+	AC_MSG_RESULT($enable_code_coverage)
+
+	AS_IF([ test "x$enable_code_=
coverage" =3D xyes ], [
+		_AX_CODE_COVERAGE_ENABLED
+	      ])
+
+	_AX_COD=
E_COVERAGE_RULES
+])

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1591?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
ba7e5e553679ec0cf47cb2e5d9b2fb1859ea767c
Gerrit-Change-Number: 1591
Gerrit-=
PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Rev=
iewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <raz=
vanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>

--OjUC6WFxJ+k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1591?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">m4: Add ax_code_coverage<br><br>Putting th=
is into a separate commit, so that<br>we can easier track changes we need t=
o do to it=2E<br>(As the autoconf-archive in general this seems<br>mostly a=
bandonded)=2E<br><br>Change-Id: Iba7e5e553679ec0cf47cb2e5d9b2fb1859ea767c<b=
r>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked=
-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1591<br>Message-Id: &lt;20260817131536=2E=
21559-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Eco=
m/openvpn-devel@lists=2Esourceforge=2Enet/msg38448=2Ehtml<br>Signed-off-by:=
 Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>A m4/ax_code_covera=
ge=2Em4<br>1 file changed, 273 insertions(+), 0 deletions(-)<br><br></pre>
=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/m4/ax_code_coverage=2Em4 b/m4/ax_code_coverage=2Em4</span><=
br><span>new file mode 100644</span><br><span>index 0000000=2E=2E216708a4</=
span><br><span>--- /dev/null</span><br><span>+++ b/m4/ax_code_coverage=2Em4=
</span><br><span>@@ -0,0 +1,273 @@</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
     https://www=2Egnu=2Eorg/software/autoconf-archive/ax_code_coverage=2Eh=
tml</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+# SYNOPSIS</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
   AX_CODE_COVERAGE()</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# DESCRIPTION</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#   Defines CODE_COVERAGE_CPPFLAGS, CODE=
_COVERAGE_CFLAGS,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
  CODE_COVERAGE_CXXFLAGS and CODE_COVERAGE_LIBS which should be included</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#   in the CPPFLAGS, C=
FLAGS CXXFLAGS and LIBS/LIBADD variables of every</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#   build target (program or library) which s=
hould be built with code</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#   coverage support=2E Also add rules using AX_ADD_AM_MACRO_STATIC; a=
nd</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   $enable_code_=
coverage which can be used in subsequent configure output=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#   CODE_COVERAGE_ENABLED is defin=
ed and substituted, and corresponds to the</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#   value of the --enable-code-coverage option, whic=
h defaults to being</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#   disabled=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#   Test also for gcov=
 program and create GCOV variable that could be</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#   substituted=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#   Note that all optimization flags in CFLAGS must be disabled wh=
en code</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   coverage=
 is enabled=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#   Usage example:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#   configure=2Eac:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#     AX_CODE_COVERAGE</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#   Makefile=2Eam:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#     include $(to=
p_srcdir)/aminclude_static=2Eam</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#     =
my_program_LIBS =3D =2E=2E=2E $(CODE_COVERAGE_LIBS) =2E=2E=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#     my_program_CPPFLAGS =3D =2E=
=2E=2E $(CODE_COVERAGE_CPPFLAGS) =2E=2E=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#     my_program_CFLAGS =3D =2E=2E=2E $(CODE_COVERAG=
E_CFLAGS) =2E=2E=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#     my_program_CXXFLAGS =3D =2E=2E=2E $(CODE_COVERAGE_CXXFLAGS) =2E=2E=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#     clean-local: code-coverage-clea=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#     distclean-lo=
cal: code-coverage-dist-clean</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   This=
 results in a &quot;check-code-coverage&quot; rule being added to any</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#   Makefile=2Eam which d=
o &quot;include $(top_srcdir)/aminclude_static=2Eam&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#   (assuming the module has been con=
figured with --enable-code-coverage)=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#   Running `make check-code-coverage` in that director=
y will run the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   m=
odule&#39;s test suite (`make check`) and build a code coverage report</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#   detailing the code w=
hich was touched, then print the URI for the report=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#   This code was derived from Makefile=2Edecl in GLib, or=
iginally licensed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
  under LGPLv2=2E1+=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# LICENSE</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#   Copyright (c) 2012, 2016 Philip Withn=
all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   Copyright (c=
) 2012 Xan Lopez</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  =
 Copyright (c) 2012 Christian Persch</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#   Copyright (c) 2012 Paolo Borelli</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#   Copyright (c) 2012 Dan Winship</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#   Copyright (c) 2015,201=
8 Bastien ROUCARIES</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   This library i=
s free software; you can redistribute it and/or modify it</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#   under the terms of the GNU Lesser=
 General Public License as published by</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#   the Free Software Foundation; either version 2=2E1 =
of the License, or (at</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#   your option) any later version=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#   This library is distributed in the hope that it will be useful, but<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   WITHOUT ANY WARR=
ANTY; without even the implied warranty of</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURP=
OSE=2E See the GNU Lesser</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#   General Public License for more details=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#   You should have received a copy of the GNU Lesser Gener=
al Public License</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
  along with this program=2E If not, see &lt;https://www=2Egnu=2Eorg/licens=
es/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#serial 37</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+m4_define(_AX_CODE_COVERAGE_RULES,[</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+AX_ADD_AM_MACRO_STATIC([</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+# Code coverage</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+# Optional:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#  - CODE_COVERAGE_DIRECTORY: Top-level directory for code covera=
ge reporting=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   =
 Multiple directories may be specified, separated by whitespace=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#    (Default: \$(top_buildd=
ir))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  - CODE_COVER=
AGE_OUTPUT_FILE: Filename and path for the =2Einfo file generated</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#    by lcov for code coverag=
e=2E (Default:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#    =
\$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-coverage=2Einfo)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#  - CODE_COVERAGE_OUTPUT_DIRECTORY: Dire=
ctory for generated code coverage</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#    reports to be created=2E (Default:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#    \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)=
-coverage)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  - CODE=
_COVERAGE_BRANCH_COVERAGE: Set to 1 to enforce branch coverage,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#    set to 0 to disable it and=
 leave empty to stay with the default=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#    (Default: empty)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#  - CODE_COVERAGE_LCOV_SHOPTS_DEFAULT: Extra option=
s shared between both lcov</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#    instances=2E (Default: based on $CODE_COVERAGE_BRANCH_COVERAGE)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  - CODE_COVERAGE_=
LCOV_SHOPTS: Extra options to shared between both lcov</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#    instances=2E (Default: $CODE_COVERA=
GE_LCOV_SHOPTS_DEFAULT)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#  - CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH: --gcov-tool pathtogcov</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#  - CODE_COVERAGE_LCOV_OP=
TIONS_DEFAULT: Extra options to pass to the</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#    collecting lcov instance=2E (Default: $CODE_CO=
VERAGE_LCOV_OPTIONS_GCOVPATH)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#  - CODE_COVERAGE_LCOV_OPTIONS: Extra options to pass to the col=
lecting lcov</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#    in=
stance=2E (Default: $CODE_COVERAGE_LCOV_OPTIONS_DEFAULT)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#  - CODE_COVERAGE_LCOV_RMOPTS_DEFAULT=
: Extra options to pass to the filtering</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#    lcov instance=2E (Default: empty)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#  - CODE_COVERAGE_LCOV_RMOPTS: Ext=
ra options to pass to the filtering lcov</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#    instance=2E (Default: $CODE_COVERAGE_LCOV_RMOPTS_=
DEFAULT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  - CODE_C=
OVERAGE_GENHTML_OPTIONS_DEFAULT: Extra options to pass to the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#    genhtml instance=2E (Default=
: based on $CODE_COVERAGE_BRANCH_COVERAGE)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#  - CODE_COVERAGE_GENHTML_OPTIONS: Extra options to=
 pass to the genhtml</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#    instance=2E (Default: $CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#  - CODE_COVERAGE_IGNORE_P=
ATTERN: Extra glob pattern of files to ignore</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# The generated report will be titled using the \$(PACKAGE_NAME) an=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# \$(PACKAGE_VERSI=
ON)=2E In order to add the current git hash to the title,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+# use the git-version-gen script, ava=
ilable online=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# O=
ptional variables</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
run only on top dir</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
if CODE_COVERAGE_ENABLED</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ ifeq (\$(abs_builddir), \$(abs_top_builddir))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+CODE_COVERAGE_DIRECTORY ?=3D \$(top_build=
dir)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CODE_COVERAGE_O=
UTPUT_FILE ?=3D \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-coverage=2Einfo</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+CODE_COVERAGE_OUTPUT_DIREC=
TORY ?=3D \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-coverage</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+CODE_COVERAGE_BRANCH_COVERAGE ?=3D</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+CODE_COVERAGE_LCOV_SHOPTS_DEFAULT ?=3D \$=
(if \$(CODE_COVERAGE_BRANCH_COVERAGE),\</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+--rc lcov_branch_coverage=3D\$(CODE_COVERAGE_BRANCH_COV=
ERAGE))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CODE_COVERAG=
E_LCOV_SHOPTS ?=3D \$(CODE_COVERAGE_LCOV_SHOPTS_DEFAULT)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH ?=
=3D --gcov-tool \&quot;\$(GCOV)\&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+CODE_COVERAGE_LCOV_OPTIONS_DEFAULT ?=3D \$(CODE_COVERAGE=
_LCOV_OPTIONS_GCOVPATH)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+CODE_COVERAGE_LCOV_OPTIONS ?=3D \$(CODE_COVERAGE_LCOV_OPTIONS_DEFAULT)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+CODE_COVERAGE_LCOV_R=
MOPTS_DEFAULT ?=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+C=
ODE_COVERAGE_LCOV_RMOPTS ?=3D \$(CODE_COVERAGE_LCOV_RMOPTS_DEFAULT)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+CODE_COVERAGE_GENHTML_OPTIO=
NS_DEFAULT ?=3D\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+\$(=
if \$(CODE_COVERAGE_BRANCH_COVERAGE),\</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+--rc genhtml_branch_coverage=3D\$(CODE_COVERAGE_BRANCH_C=
OVERAGE))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CODE_COVER=
AGE_GENHTML_OPTIONS ?=3D \$(CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+CODE_COVERAGE_IGNORE_PATTERN=
 ?=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+GITIGNOREFILES :=3D \$(GITIGNOREF=
ILES) \$(CODE_COVERAGE_OUTPUT_FILE) \$(CODE_COVERAGE_OUTPUT_DIRECTORY)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+code_coverage_v_lcov_cap=
 =3D \$(code_coverage_v_lcov_cap_\$(V))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+code_coverage_v_lcov_cap_ =3D \$(code_coverage_v_lcov_c=
ap_\$(AM_DEFAULT_VERBOSITY))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+code_coverage_v_lcov_cap_0 =3D @echo \&quot;  LCOV   --capture\&qu=
ot; \$(CODE_COVERAGE_OUTPUT_FILE);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+code_coverage_v_lcov_ign =3D \$(code_coverage_v_lcov_ign_\$(=
V))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+code_coverage_v_=
lcov_ign_ =3D \$(code_coverage_v_lcov_ign_\$(AM_DEFAULT_VERBOSITY))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+code_coverage_v_lcov_ign_0 =
=3D @echo \&quot;  LCOV   --remove\&quot; \&quot;\$(CODE_COVERAGE_OUTPUT_FI=
LE)=2Etmp\&quot; \$(CODE_COVERAGE_IGNORE_PATTERN);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+code_coverage_v_genhtml =3D \$(code_coverage=
_v_genhtml_\$(V))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+co=
de_coverage_v_genhtml_ =3D \$(code_coverage_v_genhtml_\$(AM_DEFAULT_VERBOSI=
TY))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+code_coverage_v=
_genhtml_0 =3D @echo \&quot;  GEN   \&quot; \&quot;\$(CODE_COVERAGE_OUTPUT_=
DIRECTORY)\&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+c=
ode_coverage_quiet =3D \$(code_coverage_quiet_\$(V))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+code_coverage_quiet_ =3D \$(code_coverage=
_quiet_\$(AM_DEFAULT_VERBOSITY))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+code_coverage_quiet_0 =3D --quiet</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# sanitizes the test-name: replaces with underscores: dashes and do=
ts</span><br><span style=3D"color: hsl(120, 100%, 40%);">+code_coverage_san=
itize =3D \$(subst -,_,\$(subst =2E,_,\$(1)))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+# Use recursive makes in order to ignore errors during check</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+check-code-coverage:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+	-\$(AM_V_at)\$(MAKE) \$(A=
M_MAKEFLAGS) -k check</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	\$(AM_V_at)\$(MAKE) \$(AM_MAKEFLAGS) code-coverage-capture</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+# Capture code coverage data</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+code-coverage-capture: code-coverage-capt=
ure-hook</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	\$(code_co=
verage_v_lcov_cap)\$(LCOV) \$(code_coverage_quiet) \$(addprefix --directory=
 ,\$(CODE_COVERAGE_DIRECTORY)) --capture --output-file \&quot;\$(CODE_COVER=
AGE_OUTPUT_FILE)=2Etmp\&quot; --test-name \&quot;\$(call code_coverage_sani=
tize,\$(PACKAGE_NAME)-\$(PACKAGE_VERSION))\&quot; --no-checksum --compat-li=
btool \$(CODE_COVERAGE_LCOV_SHOPTS) \$(CODE_COVERAGE_LCOV_OPTIONS)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+	\$(code_coverage_v_lcov_ign=
)\$(LCOV) \$(code_coverage_quiet) \$(addprefix --directory ,\$(CODE_COVERAG=
E_DIRECTORY)) --remove \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)=2Etmp\&quot; \$=
(CODE_COVERAGE_IGNORE_PATTERN) --output-file \&quot;\$(CODE_COVERAGE_OUTPUT=
_FILE)\&quot; \$(CODE_COVERAGE_LCOV_SHOPTS) \$(CODE_COVERAGE_LCOV_RMOPTS)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-@rm -f \&quot;\$(CO=
DE_COVERAGE_OUTPUT_FILE)=2Etmp\&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+	\$(code_coverage_v_genhtml)LANG=3DC \$(GENHTML) \$(code_=
coverage_quiet) \$(addprefix --prefix ,\$(CODE_COVERAGE_DIRECTORY)) --outpu=
t-directory \&quot;\$(CODE_COVERAGE_OUTPUT_DIRECTORY)\&quot; --title \&quot=
;\$(PACKAGE_NAME)-\$(PACKAGE_VERSION) Code Coverage\&quot; --legend --show-=
details \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)\&quot; \$(CODE_COVERAGE_GENHTM=
L_OPTIONS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	@echo \&=
quot;file://\$(abs_builddir)/\$(CODE_COVERAGE_OUTPUT_DIRECTORY)/index=2Ehtm=
l\&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+code-coverage-clean:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+	-\$(LCOV) --directory \$(top=
_builddir) -z</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-rm -=
rf \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)\&quot; \&quot;\$(CODE_COVERAGE_OUTP=
UT_FILE)=2Etmp\&quot; \&quot;\$(CODE_COVERAGE_OUTPUT_DIRECTORY)\&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+	-find =2E \\( -name \&q=
uot;*=2Egcda\&quot; -o -name \&quot;*=2Egcno\&quot; -o -name \&quot;*=2Egco=
v\&quot; \\) -delete</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+code-coverage-dist=
-clean:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+A][M_DISTCHECK_CONFIGURE_FLAGS =
:=3D \$(A][M_DISTCHECK_CONFIGURE_FLAGS) --disable-code-coverage</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ else # ifneq (\$(abs_builddir)=
, \$(abs_top_builddir))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+check-code-coverage:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+code-coverage-=
capture: code-coverage-capture-hook</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cod=
e-coverage-clean:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+code-coverage-dist-cl=
ean:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ endif # ifeq (=
\$(abs_builddir), \$(abs_top_builddir))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+else #! CODE_COVERAGE_ENABLED</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+# Use recursive makes in order to ignore erro=
rs during check</span><br><span style=3D"color: hsl(120, 100%, 40%);">+chec=
k-code-coverage:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	@e=
cho \&quot;Need to reconfigure with --enable-code-coverage\&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# Capture code coverage data<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+code-coverage-captur=
e: code-coverage-capture-hook</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	@echo \&quot;Need to reconfigure with --enable-code-coverage\&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+code-coverage-clean:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+code-coverage-dist-clean:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+endif #CODE_COVERAGE_ENABLED</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+# Hook rule executed before code-coverage-capture, overri=
dable by the user</span><br><span style=3D"color: hsl(120, 100%, 40%);">+co=
de-coverage-capture-hook:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=2EPHONY: che=
ck-code-coverage code-coverage-capture code-coverage-dist-clean code-covera=
ge-clean code-coverage-capture-hook</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+]=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+AC_DEFUN([_AX_CODE_COVERAGE_ENABLED],=
[</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	AX_CHECK_GNU_MAKE=
([],[AC_MSG_ERROR([not using GNU make that is needed for coverage])])</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+	AC_REQUIRE([AX_ADD_AM_MA=
CRO_STATIC])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	# chec=
k for gcov</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	AC_CHECK=
_TOOL([GCOV],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		  [$=
_AX_CODE_COVERAGE_GCOV_PROG_WITH],</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+		  [:])</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+	AS_IF([test &quot;X$GCOV&quot; =3D &quot;X:&quot;],</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+	      [AC_MSG_ERROR([gcov is needed t=
o do coverage])])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	A=
C_SUBST([GCOV])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+	dnl Check if gcc is be=
ing used</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	AS_IF([ te=
st &quot;$GCC&quot; =3D &quot;no&quot; ], [</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+		AC_MSG_ERROR([not compiling with gcc, which is re=
quired for gcov code coverage])</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	      ])</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	AC_CHECK_PROG([L=
COV], [lcov], [lcov])</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	AC_CHECK_PROG([GENHTML], [genhtml], [genhtml])</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+	AS_IF([ test x&quot;$LCOV&quot; =3D x ], [</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+		AC_MSG_ERROR([To enable code coverage =
reporting you must have lcov installed])</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	      ])</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	AS_IF([=
 test x&quot;$GENHTML&quot; =3D x ], [</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+		AC_MSG_ERROR([Could not find genhtml from the lcov pac=
kage])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	])</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+	AC_CHECK_LIB([gcov], [_gcov_init], [CODE_COVERA=
GE_LIBS=3D&quot;-lgcov&quot;], [CODE_COVERAGE_LIBS=3D&quot;&quot;])</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	dnl Build the code coverage flags</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	dnl Define CODE_COVERAGE_LDFLA=
GS for backwards compatibility</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+	CODE_COVERAGE_CPPFLAGS=3D&quot;-DNDEBUG&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+	CODE_COVERAGE_CFLAGS=3D&quot;-O0 -g =
-fprofile-arcs -ftest-coverage&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	CODE_COVERAGE_CXXFLAGS=3D&quot;-O0 -g -fprofile-arcs -fte=
st-coverage&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+	AC_SUBST([CODE_COVER=
AGE_CPPFLAGS])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	AC_S=
UBST([CODE_COVERAGE_CFLAGS])</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	AC_SUBST([CODE_COVERAGE_CXXFLAGS])</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	AC_SUBST([CODE_COVERAGE_LIBS])</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+])</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+AC_DEFUN([AX_CODE_COVERAGE],[</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+	dnl Check for --enable-code-coverage</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	# allow to override gcov location</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	AC_ARG_WITH([gcov],</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	  [AS_HELP_STRING([--with-gcov[=3DGCOV]], [use g=
iven GCOV for coverage (GCOV=3Dgcov)=2E])],</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+	  [_AX_CODE_COVERAGE_GCOV_PROG_WITH=3D$with_gcov],=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	  [_AX_CODE_COVERA=
GE_GCOV_PROG_WITH=3Dgcov])</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	AC_MSG_CHEC=
KING([whether to build with code coverage support])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	AC_ARG_ENABLE([code-coverage],</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+	  AS_HELP_STRING([--enable-c=
ode-coverage],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	  [W=
hether to enable code coverage support]),,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	  enable_code_coverage=3Dno)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+	AM_CONDITIONAL([CODE_COVERAGE_ENABLED], [test &quot;x$enabl=
e_code_coverage&quot; =3D xyes])</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+	AC_SUBST([CODE_COVERAGE_ENABLED], [$enable_code_coverage])</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+	AC_MSG_RESULT($enable=
_code_coverage)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+	AS_IF([ test &quot;x$e=
nable_code_coverage&quot; =3D xyes ], [</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+		_AX_CODE_COVERAGE_ENABLED</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	      ])</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	=
_AX_CODE_COVERAGE_RULES</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+])</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1591?usp=3Demail">change 1591</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1591?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iba7e5e553679ec0=
cf47cb2e5d9b2fb1859ea767c </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 1591 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>=

<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>

</body></html>
--OjUC6WFxJ+k=--


--===============4369417130645642115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4369417130645642115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4369417130645642115==--

