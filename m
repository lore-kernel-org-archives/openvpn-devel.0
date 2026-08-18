Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F24C5DF7E
	for <openvpn-devel@archiver.kernel.org>; Tue, 18 Aug 2026 14:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SaIfNrSB7QY4KKxm06XT6UlVsZYX2xhZONNuT2CcJTw=; b=iqCYi/Tjs4EDPYLrlkex1MHvlc
	A3VtUx6szMKIg49+Hh+ROifN9fTkKG7k+1oBwBau0pzflEqQLaQ2JPADehG3j5P1twXtUmxrRGQQM
	5y50z5F2gRMbN8Kb4SdSfliyNvAkVBPcT7/tJRunGx/hOgmLfoGTw8aNZgCzC800gCA4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwKTR-0007Jw-93;
	Tue, 18 Aug 2026 14:07:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwKT3-0007JP-Gx
 for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 14:07:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=wzHT4M24S/53Wb5H+qTfrvrfPe7GPOHKQwxbwTa8OVA=; b=YyiJ75WuTY9ty/ZNTuvWpw3gQx
 uDbqHj6mPLE8/H6ZWP2JrXWwoPyG5sPIaGKqYcMnos6SngNGVQQZAIWn4fMR4l8TEtwbOThEZhZYd
 4JQBAG0SbGmaD2MUnIeLdbhzQmcAFe/h28IE7OocFOckQUZAlKU6CqrAnV4zyUZQZ8Pw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wzHT4M24S/53Wb5H+qTfrvrfPe7GPOHKQwxbwTa8OVA=; b=d
 dHUpPkKNQ0cMsP1uJ1PIH8ia0bcufQdDYCyM8962eS9E6evsvfRrEc0gpw+V2gbf62RL1hj2/L65/
 DAOyN98Qifv7eeyBtKePKpRTPthPXGRJNIY2NWGMgd+SekBMmw7A1cZKDj8TA5ODfWY+RmsJMIiIm
 ENgCf9eWWCqSvANM=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwKSr-0005A7-39 for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 14:06:57 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-495757ccbc1so42996175e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 18 Aug 2026 07:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787062006; x=1787666806; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wzHT4M24S/53Wb5H+qTfrvrfPe7GPOHKQwxbwTa8OVA=;
 b=YwTfppYppmU3koccba7RnekZYsmrO1PgMFMc4EV3WAfVSdvp2ngzhw6eNnYw3cdGXn
 tmYO5C7av4gdm6kFV8jZSZq0iIFx5CzAJgb3oMHx8/3x7juLmNcMEBX/svSylevsDioB
 RDxaaMhZ2xI1UwBL0/VRjxW6yFegh+Q1Q2xUGEvtwdY4/tbZDFT5XS/1pzV2asoTIh9i
 llxufD1KbrdG6rtafpDDmzU5/8f3WaN5w3bXGedfKXfiHBVURS9eDL4qd5YjHN/Bnts+
 dxRGEoQZL0PomeRD9M0fiywGeh2YIgsi27EKMDznPCZZjia0ulCav+bW0yJxBuATPkyp
 sQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787062006; x=1787666806;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wzHT4M24S/53Wb5H+qTfrvrfPe7GPOHKQwxbwTa8OVA=;
 b=eU9zh5vdzQCFkQQu3+IPEEmkH0c080tfYA3phH++ajTOBousddnsts+YOAshCbXiR6
 mpya036ubv+wNuBjdAK8x1f0yCePFdN+QK3WIZ8jsoITiZzIxJtX5liyUp5arneKHjZY
 bczKr3mp8WqRBJuX7jeFaqlG4QaFAapO7AOpAJqgrLuxWox+f9J0M6orS5V7/R07ZDwr
 alJkkzNyDFs4eiCQdwsbKF7Ro9TWYVBvZkJYp4M1j45jeYb6eVTylAHpqZ8auV3Y6vxR
 0gbQlnLoAdknWJRpfKxf5bHZXflM/NEtou4zqPV7sQLtUvk8xwZxxNUPzFeEd/ZIDgRg
 fVDg==
X-Gm-Message-State: AOJu0YxYlabCq+oK7n4wGrlQ2shjBHQeB4pwyFQg45XnzAWaQS6OuYrv
 q67x00/hEja70HbkU7+1vICNCXfXNOB8/UzoIO2MbpJ9VT721jp8zwdmUmNsTBJy2IpGuocdaUo
 KeaCleeeQR2XQxFsqUQsUmIeFNIONKvknXbAl2LTj9nLzlkxguZW09U/vDm7MoMlROYMr
X-Gm-Gg: AR+sD11mE7TeCiekecA4ab8xKaT4rAvBkWxTuNOUC9qKRNBYmmOdcx1eFfe6BxzRYae
 0rgpLrbphTvbXhRuKxOVhMClmdDBO8kR1B5w+qVQbQhDH5Yavy6hpC58ViVD1tg3t7lc1kFDPQX
 aikGTdPjHAQMLZJxx9camwc7SUAW+rFC2WNYgvaL0T3gxYI+99TwyqmUEdsTkxpT7689iM+BfcM
 wdOpngM0HpNTemREeOCpJ/9PNCBGOI/SvEJbKhqAFLkjLFgaHbR///8aqrgpEh9MGYvpcYfv04p
 rb6CSHZ5ghfxJF7D0QZJfgSXvwpBGQ2HGf/YIUSbVRV1SUT8xxAUnXct1yxGmQ2PH1rQIIAlukP
 W7aIATsbuGpC9bplaxrdzXfhQbR2a8yvvcQYgnNemUwszuTwM1RwcXJ0cfenvz5A5zF69VQjPEr
 jG3zzTnfsl5ykPVrq81bblwPuerP9vIabYM/rCYaAUJrSnZcDLrdSeqqUkBkYsyQAwxlFr1P2TV
 515B/phSpq3qqNQLYCqmRUERKHSXRzQQNtyWqTaIZvjM2rywxTWeM+Pxso86p9i3BY3NtQYvC+l
 Ze1+EfCjmf/l4Q7PzxaukSQf4jzUE5JHUzdwZKrZ/V5ATOzYW1I=
X-Received: by 2002:a05:600c:3398:b0:499:52dd:c1f0 with SMTP id
 5b1f17b1804b1-499879298c4mr353463755e9.1.1787062006016; 
 Tue, 18 Aug 2026 07:06:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d078523sm135174215e9.6.2026.08.18.07.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 07:06:45 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 18 Aug 2026 14:06:43 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iba7e5e553679ec0cf47cb2e5d9b2fb1859ea767c
X-Gerrit-Change-Number: 1591
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1591?usp=email>
X-Gerrit-Commit: 4f81de14de7c9f7ca371236f5d30e0d6ba9d6449
In-Reply-To: <gerrit.1774451380000.Iba7e5e553679ec0cf47cb2e5d9b2fb1859ea767c@gerrit.openvpn.net>
References: <gerrit.1774451380000.Iba7e5e553679ec0cf47cb2e5d9b2fb1859ea767c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc0NDUxMzgwMDAwLkliYTdlNWU1NTM2NzllYzBjZjQ3Y2IyZTVkOWIyZmIxODU5ZWE3NjdjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1a3ec7ae57bec5caa83273daa581b95d9d5c0a11-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwKSr-0005A7-39
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2178487917657995544=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2178487917657995544==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="l//mGV5ukgc="; charset=UTF-8

--l//mGV5ukgc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1591?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by razvanc


Change subject: m4: Add ax_code_coverage
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

m4: Add ax_code_coverage

Putting =
this into a separate commit, so that
we can easier track changes we need to=
 do to it=2E
(As the autoconf-archive in general this seems
mostly abandond=
ed)=2E

Change-Id: Iba7e5e553679ec0cf47cb2e5d9b2fb1859ea767c
Signed-off-by:=
 Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <raz=
vanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1591
Message-Id: <20260817131536=2E21559-1-gert@greenie=2Emuc=2Ede>
URL: ht=
tps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg3=
8448=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
A m4/=
ax_code_coverage=2Em4
1 file changed, 273 insertions(+), 0 deletions(-)


 =
 git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/91/1591/2=


diff --git a/m4/ax_code_coverage=2Em4 b/m4/ax_code_coverage=2Em4
new file=
 mode 100644
index 0000000=2E=2E216708a4
--- /dev/null
+++ b/m4/ax_code_cov=
erage=2Em4
@@ -0,0 +1,273 @@
+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+#     https://www=2Egnu=2Eorg/software/a=
utoconf-archive/ax_code_coverage=2Ehtml
+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+#
+# SYNOPSIS
+#
+#   AX_COD=
E_COVERAGE()
+#
+# DESCRIPTION
+#
+#   Defines CODE_COVERAGE_CPPFLAGS, CODE=
_COVERAGE_CFLAGS,
+#   CODE_COVERAGE_CXXFLAGS and CODE_COVERAGE_LIBS which =
should be included
+#   in the CPPFLAGS, CFLAGS CXXFLAGS and LIBS/LIBADD va=
riables of every
+#   build target (program or library) which should be bui=
lt with code
+#   coverage support=2E Also add rules using AX_ADD_AM_MACRO_=
STATIC; and
+#   $enable_code_coverage which can be used in subsequent conf=
igure output=2E
+#   CODE_COVERAGE_ENABLED is defined and substituted, and =
corresponds to the
+#   value of the --enable-code-coverage option, which d=
efaults to being
+#   disabled=2E
+#
+#   Test also for gcov program and cr=
eate GCOV variable that could be
+#   substituted=2E
+#
+#   Note that all =
optimization flags in CFLAGS must be disabled when code
+#   coverage is en=
abled=2E
+#
+#   Usage example:
+#
+#   configure=2Eac:
+#
+#     AX_CODE_C=
OVERAGE
+#
+#   Makefile=2Eam:
+#
+#     include $(top_srcdir)/aminclude_st=
atic=2Eam
+#
+#     my_program_LIBS =3D =2E=2E=2E $(CODE_COVERAGE_LIBS) =2E=
=2E=2E
+#     my_program_CPPFLAGS =3D =2E=2E=2E $(CODE_COVERAGE_CPPFLAGS) =
=2E=2E=2E
+#     my_program_CFLAGS =3D =2E=2E=2E $(CODE_COVERAGE_CFLAGS) =
=2E=2E=2E
+#     my_program_CXXFLAGS =3D =2E=2E=2E $(CODE_COVERAGE_CXXFLAGS=
) =2E=2E=2E
+#
+#     clean-local: code-coverage-clean
+#     distclean-loc=
al: code-coverage-dist-clean
+#
+#   This results in a "check-code-coverage=
" rule being added to any
+#   Makefile=2Eam which do "include $(top_srcdir=
)/aminclude_static=2Eam"
+#   (assuming the module has been configured with=
 --enable-code-coverage)=2E
+#   Running `make check-code-coverage` in that=
 directory will run the
+#   module's test suite (`make check`) and build a=
 code coverage report
+#   detailing the code which was touched, then print=
 the URI for the report=2E
+#
+#   This code was derived from Makefile=2Ede=
cl in GLib, originally licensed
+#   under LGPLv2=2E1+=2E
+#
+# LICENSE
+#
=
+#   Copyright (c) 2012, 2016 Philip Withnall
+#   Copyright (c) 2012 Xan L=
opez
+#   Copyright (c) 2012 Christian Persch
+#   Copyright (c) 2012 Paolo=
 Borelli
+#   Copyright (c) 2012 Dan Winship
+#   Copyright (c) 2015,2018 B=
astien ROUCARIES
+#
+#   This library is free software; you can redistribut=
e it and/or modify it
+#   under the terms of the GNU Lesser General Public=
 License as published by
+#   the Free Software Foundation; either version =
2=2E1 of the License, or (at
+#   your option) any later version=2E
+#
+#  =
 This library is distributed in the hope that it will be useful, but
+#   W=
ITHOUT ANY WARRANTY; without even the implied warranty of
+#   MERCHANTABIL=
ITY or FITNESS FOR A PARTICULAR PURPOSE=2E See the GNU Lesser
+#   General =
Public License for more details=2E
+#
+#   You should have received a copy =
of the GNU Lesser General Public License
+#   along with this program=2E If=
 not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+
+#serial 37
+
+m4_define=
(_AX_CODE_COVERAGE_RULES,[
+AX_ADD_AM_MACRO_STATIC([
+# Code coverage
+#
+#=
 Optional:
+#  - CODE_COVERAGE_DIRECTORY: Top-level directory for code cove=
rage reporting=2E
+#    Multiple directories may be specified, separated by=
 whitespace=2E
+#    (Default: \$(top_builddir))
+#  - CODE_COVERAGE_OUTPUT=
_FILE: Filename and path for the =2Einfo file generated
+#    by lcov for c=
ode coverage=2E (Default:
+#    \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-covera=
ge=2Einfo)
+#  - CODE_COVERAGE_OUTPUT_DIRECTORY: Directory for generated co=
de coverage
+#    reports to be created=2E (Default:
+#    \$(PACKAGE_NAME)=
-\$(PACKAGE_VERSION)-coverage)
+#  - CODE_COVERAGE_BRANCH_COVERAGE: Set to =
1 to enforce branch coverage,
+#    set to 0 to disable it and leave empty =
to stay with the default=2E
+#    (Default: empty)
+#  - CODE_COVERAGE_LCOV=
_SHOPTS_DEFAULT: Extra options shared between both lcov
+#    instances=2E =
(Default: based on $CODE_COVERAGE_BRANCH_COVERAGE)
+#  - CODE_COVERAGE_LCOV=
_SHOPTS: Extra options to shared between both lcov
+#    instances=2E (Defa=
ult: $CODE_COVERAGE_LCOV_SHOPTS_DEFAULT)
+#  - CODE_COVERAGE_LCOV_OPTIONS_G=
COVPATH: --gcov-tool pathtogcov
+#  - CODE_COVERAGE_LCOV_OPTIONS_DEFAULT: E=
xtra options to pass to the
+#    collecting lcov instance=2E (Default: $CO=
DE_COVERAGE_LCOV_OPTIONS_GCOVPATH)
+#  - CODE_COVERAGE_LCOV_OPTIONS: Extra =
options to pass to the collecting lcov
+#    instance=2E (Default: $CODE_CO=
VERAGE_LCOV_OPTIONS_DEFAULT)
+#  - CODE_COVERAGE_LCOV_RMOPTS_DEFAULT: Extra=
 options to pass to the filtering
+#    lcov instance=2E (Default: empty)
+=
#  - CODE_COVERAGE_LCOV_RMOPTS: Extra options to pass to the filtering lcov=

+#    instance=2E (Default: $CODE_COVERAGE_LCOV_RMOPTS_DEFAULT)
+#  - CODE=
_COVERAGE_GENHTML_OPTIONS_DEFAULT: Extra options to pass to the
+#    genht=
ml instance=2E (Default: based on $CODE_COVERAGE_BRANCH_COVERAGE)
+#  - COD=
E_COVERAGE_GENHTML_OPTIONS: Extra options to pass to the genhtml
+#    inst=
ance=2E (Default: $CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT)
+#  - CODE_COVERA=
GE_IGNORE_PATTERN: Extra glob pattern of files to ignore
+#
+# The generate=
d report will be titled using the \$(PACKAGE_NAME) and
+# \$(PACKAGE_VERSIO=
N)=2E In order to add the current git hash to the title,
+# use the git-ver=
sion-gen script, available online=2E
+# Optional variables
+# run only on t=
op dir
+if CODE_COVERAGE_ENABLED
+ ifeq (\$(abs_builddir), \$(abs_top_build=
dir))
+CODE_COVERAGE_DIRECTORY ?=3D \$(top_builddir)
+CODE_COVERAGE_OUTPUT_=
FILE ?=3D \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-coverage=2Einfo
+CODE_COVERA=
GE_OUTPUT_DIRECTORY ?=3D \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-coverage
+
+C=
ODE_COVERAGE_BRANCH_COVERAGE ?=3D
+CODE_COVERAGE_LCOV_SHOPTS_DEFAULT ?=3D \=
$(if \$(CODE_COVERAGE_BRANCH_COVERAGE),\
+--rc lcov_branch_coverage=3D\$(CO=
DE_COVERAGE_BRANCH_COVERAGE))
+CODE_COVERAGE_LCOV_SHOPTS ?=3D \$(CODE_COVER=
AGE_LCOV_SHOPTS_DEFAULT)
+CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH ?=3D --gcov-t=
ool \"\$(GCOV)\"
+CODE_COVERAGE_LCOV_OPTIONS_DEFAULT ?=3D \$(CODE_COVERAGE_=
LCOV_OPTIONS_GCOVPATH)
+CODE_COVERAGE_LCOV_OPTIONS ?=3D \$(CODE_COVERAGE_LC=
OV_OPTIONS_DEFAULT)
+CODE_COVERAGE_LCOV_RMOPTS_DEFAULT ?=3D
+CODE_COVERAGE_=
LCOV_RMOPTS ?=3D \$(CODE_COVERAGE_LCOV_RMOPTS_DEFAULT)
+CODE_COVERAGE_GENHT=
ML_OPTIONS_DEFAULT ?=3D\
+\$(if \$(CODE_COVERAGE_BRANCH_COVERAGE),\
+--rc g=
enhtml_branch_coverage=3D\$(CODE_COVERAGE_BRANCH_COVERAGE))
+CODE_COVERAGE_=
GENHTML_OPTIONS ?=3D \$(CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT)
+CODE_COVERA=
GE_IGNORE_PATTERN ?=3D
+
+GITIGNOREFILES :=3D \$(GITIGNOREFILES) \$(CODE_CO=
VERAGE_OUTPUT_FILE) \$(CODE_COVERAGE_OUTPUT_DIRECTORY)
+code_coverage_v_lco=
v_cap =3D \$(code_coverage_v_lcov_cap_\$(V))
+code_coverage_v_lcov_cap_ =3D=
 \$(code_coverage_v_lcov_cap_\$(AM_DEFAULT_VERBOSITY))
+code_coverage_v_lco=
v_cap_0 =3D @echo \"  LCOV   --capture\" \$(CODE_COVERAGE_OUTPUT_FILE);
+co=
de_coverage_v_lcov_ign =3D \$(code_coverage_v_lcov_ign_\$(V))
+code_coverag=
e_v_lcov_ign_ =3D \$(code_coverage_v_lcov_ign_\$(AM_DEFAULT_VERBOSITY))
+co=
de_coverage_v_lcov_ign_0 =3D @echo \"  LCOV   --remove\" \"\$(CODE_COVERAGE=
_OUTPUT_FILE)=2Etmp\" \$(CODE_COVERAGE_IGNORE_PATTERN);
+code_coverage_v_ge=
nhtml =3D \$(code_coverage_v_genhtml_\$(V))
+code_coverage_v_genhtml_ =3D \=
$(code_coverage_v_genhtml_\$(AM_DEFAULT_VERBOSITY))
+code_coverage_v_genhtm=
l_0 =3D @echo \"  GEN   \" \"\$(CODE_COVERAGE_OUTPUT_DIRECTORY)\";
+code_co=
verage_quiet =3D \$(code_coverage_quiet_\$(V))
+code_coverage_quiet_ =3D \$=
(code_coverage_quiet_\$(AM_DEFAULT_VERBOSITY))
+code_coverage_quiet_0 =3D -=
-quiet
+
+# sanitizes the test-name: replaces with underscores: dashes and =
dots
+code_coverage_sanitize =3D \$(subst -,_,\$(subst =2E,_,\$(1)))
+
+# U=
se recursive makes in order to ignore errors during check
+check-code-cover=
age:
+	-\$(AM_V_at)\$(MAKE) \$(AM_MAKEFLAGS) -k check
+	\$(AM_V_at)\$(MAKE)=
 \$(AM_MAKEFLAGS) code-coverage-capture
+
+# Capture code coverage data
+co=
de-coverage-capture: code-coverage-capture-hook
+	\$(code_coverage_v_lcov_c=
ap)\$(LCOV) \$(code_coverage_quiet) \$(addprefix --directory ,\$(CODE_COVER=
AGE_DIRECTORY)) --capture --output-file \"\$(CODE_COVERAGE_OUTPUT_FILE)=2Et=
mp\" --test-name \"\$(call code_coverage_sanitize,\$(PACKAGE_NAME)-\$(PACKA=
GE_VERSION))\" --no-checksum --compat-libtool \$(CODE_COVERAGE_LCOV_SHOPTS)=
 \$(CODE_COVERAGE_LCOV_OPTIONS)
+	\$(code_coverage_v_lcov_ign)\$(LCOV) \$(c=
ode_coverage_quiet) \$(addprefix --directory ,\$(CODE_COVERAGE_DIRECTORY)) =
--remove \"\$(CODE_COVERAGE_OUTPUT_FILE)=2Etmp\" \$(CODE_COVERAGE_IGNORE_PA=
TTERN) --output-file \"\$(CODE_COVERAGE_OUTPUT_FILE)\" \$(CODE_COVERAGE_LCO=
V_SHOPTS) \$(CODE_COVERAGE_LCOV_RMOPTS)
+	-@rm -f \"\$(CODE_COVERAGE_OUTPUT=
_FILE)=2Etmp\"
+	\$(code_coverage_v_genhtml)LANG=3DC \$(GENHTML) \$(code_co=
verage_quiet) \$(addprefix --prefix ,\$(CODE_COVERAGE_DIRECTORY)) --output-=
directory \"\$(CODE_COVERAGE_OUTPUT_DIRECTORY)\" --title \"\$(PACKAGE_NAME)=
-\$(PACKAGE_VERSION) Code Coverage\" --legend --show-details \"\$(CODE_COVE=
RAGE_OUTPUT_FILE)\" \$(CODE_COVERAGE_GENHTML_OPTIONS)
+	@echo \"file://\$(a=
bs_builddir)/\$(CODE_COVERAGE_OUTPUT_DIRECTORY)/index=2Ehtml\"
+
+code-cove=
rage-clean:
+	-\$(LCOV) --directory \$(top_builddir) -z
+	-rm -rf \"\$(CODE=
_COVERAGE_OUTPUT_FILE)\" \"\$(CODE_COVERAGE_OUTPUT_FILE)=2Etmp\" \"\$(CODE_=
COVERAGE_OUTPUT_DIRECTORY)\"
+	-find =2E \\( -name \"*=2Egcda\" -o -name \"=
*=2Egcno\" -o -name \"*=2Egcov\" \\) -delete
+
+code-coverage-dist-clean:
+=

+A][M_DISTCHECK_CONFIGURE_FLAGS :=3D \$(A][M_DISTCHECK_CONFIGURE_FLAGS) --=
disable-code-coverage
+ else # ifneq (\$(abs_builddir), \$(abs_top_builddir=
))
+check-code-coverage:
+
+code-coverage-capture: code-coverage-capture-ho=
ok
+
+code-coverage-clean:
+
+code-coverage-dist-clean:
+ endif # ifeq (\$(=
abs_builddir), \$(abs_top_builddir))
+else #! CODE_COVERAGE_ENABLED
+# Use =
recursive makes in order to ignore errors during check
+check-code-coverage=
:
+	@echo \"Need to reconfigure with --enable-code-coverage\"
+# Capture co=
de coverage data
+code-coverage-capture: code-coverage-capture-hook
+	@echo=
 \"Need to reconfigure with --enable-code-coverage\"
+
+code-coverage-clean=
:
+
+code-coverage-dist-clean:
+
+endif #CODE_COVERAGE_ENABLED
+# Hook rule=
 executed before code-coverage-capture, overridable by the user
+code-cover=
age-capture-hook:
+
+=2EPHONY: check-code-coverage code-coverage-capture co=
de-coverage-dist-clean code-coverage-clean code-coverage-capture-hook
+])
+=
])
+
+AC_DEFUN([_AX_CODE_COVERAGE_ENABLED],[
+	AX_CHECK_GNU_MAKE([],[AC_MSG=
_ERROR([not using GNU make that is needed for coverage])])
+	AC_REQUIRE([AX=
_ADD_AM_MACRO_STATIC])
+	# check for gcov
+	AC_CHECK_TOOL([GCOV],
+		  [$_A=
X_CODE_COVERAGE_GCOV_PROG_WITH],
+		  [:])
+	AS_IF([test "X$GCOV" =3D "X:"]=
,
+	      [AC_MSG_ERROR([gcov is needed to do coverage])])
+	AC_SUBST([GCOV=
])
+
+	dnl Check if gcc is being used
+	AS_IF([ test "$GCC" =3D "no" ], [
+=
		AC_MSG_ERROR([not compiling with gcc, which is required for gcov code cov=
erage])
+	      ])
+
+	AC_CHECK_PROG([LCOV], [lcov], [lcov])
+	AC_CHECK_PRO=
G([GENHTML], [genhtml], [genhtml])
+
+	AS_IF([ test x"$LCOV" =3D x ], [
+		=
AC_MSG_ERROR([To enable code coverage reporting you must have lcov installe=
d])
+	      ])
+
+	AS_IF([ test x"$GENHTML" =3D x ], [
+		AC_MSG_ERROR([Cou=
ld not find genhtml from the lcov package])
+	])
+
+	AC_CHECK_LIB([gcov], [=
_gcov_init], [CODE_COVERAGE_LIBS=3D"-lgcov"], [CODE_COVERAGE_LIBS=3D""])
+
=
+	dnl Build the code coverage flags
+	dnl Define CODE_COVERAGE_LDFLAGS for =
backwards compatibility
+	CODE_COVERAGE_CPPFLAGS=3D"-DNDEBUG"
+	CODE_COVERA=
GE_CFLAGS=3D"-O0 -g -fprofile-arcs -ftest-coverage"
+	CODE_COVERAGE_CXXFLAG=
S=3D"-O0 -g -fprofile-arcs -ftest-coverage"
+
+	AC_SUBST([CODE_COVERAGE_CPP=
FLAGS])
+	AC_SUBST([CODE_COVERAGE_CFLAGS])
+	AC_SUBST([CODE_COVERAGE_CXXFLA=
GS])
+	AC_SUBST([CODE_COVERAGE_LIBS])
+])
+
+AC_DEFUN([AX_CODE_COVERAGE],[
=
+	dnl Check for --enable-code-coverage
+
+	# allow to override gcov locatio=
n
+	AC_ARG_WITH([gcov],
+	  [AS_HELP_STRING([--with-gcov[=3DGCOV]], [use gi=
ven GCOV for coverage (GCOV=3Dgcov)=2E])],
+	  [_AX_CODE_COVERAGE_GCOV_PROG=
_WITH=3D$with_gcov],
+	  [_AX_CODE_COVERAGE_GCOV_PROG_WITH=3Dgcov])
+
+	AC_=
MSG_CHECKING([whether to build with code coverage support])
+	AC_ARG_ENABLE=
([code-coverage],
+	  AS_HELP_STRING([--enable-code-coverage],
+	  [Whether=
 to enable code coverage support]),,
+	  enable_code_coverage=3Dno)
+
+	AM_=
CONDITIONAL([CODE_COVERAGE_ENABLED], [test "x$enable_code_coverage" =3D xye=
s])
+	AC_SUBST([CODE_COVERAGE_ENABLED], [$enable_code_coverage])
+	AC_MSG_R=
ESULT($enable_code_coverage)
+
+	AS_IF([ test "x$enable_code_coverage" =3D =
xyes ], [
+		_AX_CODE_COVERAGE_ENABLED
+	      ])
+
+	_AX_CODE_COVERAGE_RUL=
ES
+])

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1591?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iba7e5e553=
679ec0cf47cb2e5d9b2fb1859ea767c
Gerrit-Change-Number: 1591
Gerrit-PatchSet:=
 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mail=
box=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>

--l//mGV5ukgc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1591?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">m4: Add ax_code_coverage=
<br><br>Putting this into a separate commit, so that<br>we can easier track=
 changes we need to do to it=2E<br>(As the autoconf-archive in general this=
 seems<br>mostly abandonded)=2E<br><br>Change-Id: Iba7e5e553679ec0cf47cb2e5=
d9b2fb1859ea767c<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Ge=
rrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1591<br>Message-Id: &l=
t;20260817131536=2E21559-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38448=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>A m4/ax_code_coverage=2Em4<br>1 file changed, 273 insertions(+), 0 deletio=
ns(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/91/1591/2</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/m4/ax_code_coverage=
=2Em4 b/m4/ax_code_coverage=2Em4</span><br><span>new file mode 100644</span=
><br><span>index 0000000=2E=2E216708a4</span><br><span>--- /dev/null</span>=
<br><span>+++ b/m4/ax_code_coverage=2Em4</span><br><span>@@ -0,0 +1,273 @@<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#     https://www=2Egnu=2Eorg/softwar=
e/autoconf-archive/ax_code_coverage=2Ehtml</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# SYNOPSIS=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#   AX_CODE_COVERAGE()</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+# DESCRIPTION</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
   Defines CODE_COVERAGE_CPPFLAGS, CODE_COVERAGE_CFLAGS,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#   CODE_COVERAGE_CXXFLAGS and CODE_CO=
VERAGE_LIBS which should be included</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#   in the CPPFLAGS, CFLAGS CXXFLAGS and LIBS/LIBADD varia=
bles of every</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   bu=
ild target (program or library) which should be built with code</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#   coverage support=2E Also ad=
d rules using AX_ADD_AM_MACRO_STATIC; and</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#   $enable_code_coverage which can be used in subseq=
uent configure output=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#   CODE_COVERAGE_ENABLED is defined and substituted, and corresponds =
to the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   value of =
the --enable-code-coverage option, which defaults to being</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#   disabled=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#   Test also for gcov program and create GCOV variable th=
at could be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   subs=
tituted=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#   Note that all optimizat=
ion flags in CFLAGS must be disabled when code</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#   coverage is enabled=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#   Usage example:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  =
 configure=2Eac:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#     AX_CODE_COVERAG=
E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#   Makefile=2Eam:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#     include $(top_srcdir)/aminclude_static=2Eam</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#     my_program_LIBS =3D =2E=2E=2E $(COD=
E_COVERAGE_LIBS) =2E=2E=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#     my_program_CPPFLAGS =3D =2E=2E=2E $(CODE_COVERAGE_CPPFLAGS) =
=2E=2E=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#     my_p=
rogram_CFLAGS =3D =2E=2E=2E $(CODE_COVERAGE_CFLAGS) =2E=2E=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#     my_program_CXXFLAGS =3D =2E=
=2E=2E $(CODE_COVERAGE_CXXFLAGS) =2E=2E=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#     clean-local: code-coverage-clean</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#     distclean-local: code-coverage-dist-clean</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#   This results in a &quot;check-code-co=
verage&quot; rule being added to any</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#   Makefile=2Eam which do &quot;include $(top_srcdir)/ami=
nclude_static=2Eam&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#   (assuming the module has been configured with --enable-code-covera=
ge)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   Running `=
make check-code-coverage` in that directory will run the</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#   module&#39;s test suite (`make che=
ck`) and build a code coverage report</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#   detailing the code which was touched, then print the =
URI for the report=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   This code wa=
s derived from Makefile=2Edecl in GLib, originally licensed</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#   under LGPLv2=2E1+=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+# LICENSE</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
   Copyright (c) 2012, 2016 Philip Withnall</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#   Copyright (c) 2012 Xan Lopez</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#   Copyright (c) 2012 Christian Persc=
h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   Copyright (c) =
2012 Paolo Borelli</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
   Copyright (c) 2012 Dan Winship</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#   Copyright (c) 2015,2018 Bastien ROUCARIES</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#   This library is free software; you can redistribu=
te it and/or modify it</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#   under the terms of the GNU Lesser General Public License as publishe=
d by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   the Free So=
ftware Foundation; either version 2=2E1 of the License, or (at</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#   your option) any later versi=
on=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#   This library is distributed =
in the hope that it will be useful, but</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#   WITHOUT ANY WARRANTY; without even the implied warr=
anty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   MERCHANT=
ABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E See the GNU Lesser</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#   General Public License fo=
r more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   You should have =
received a copy of the GNU Lesser General Public License</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#   along with this program=2E If not,=
 see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#serial 37</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+m4_define(_AX_COD=
E_COVERAGE_RULES,[</span><br><span style=3D"color: hsl(120, 100%, 40%);">+A=
X_ADD_AM_MACRO_STATIC([</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# Code coverage</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Optional:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#  - CODE_COVERAGE_DIRECTO=
RY: Top-level directory for code coverage reporting=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#    Multiple directories may be specifi=
ed, separated by whitespace=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#    (Default: \$(top_builddir))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#  - CODE_COVERAGE_OUTPUT_FILE: Filename and path f=
or the =2Einfo file generated</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#    by lcov for code coverage=2E (Default:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#    \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)=
-coverage=2Einfo)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
 - CODE_COVERAGE_OUTPUT_DIRECTORY: Directory for generated code coverage</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#    reports to be cre=
ated=2E (Default:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
   \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-coverage)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#  - CODE_COVERAGE_BRANCH_COVERAGE: Set to 1 =
to enforce branch coverage,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#    set to 0 to disable it and leave empty to stay with the defaul=
t=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#    (Default: =
empty)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  - CODE_COV=
ERAGE_LCOV_SHOPTS_DEFAULT: Extra options shared between both lcov</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#    instances=2E (Default: b=
ased on $CODE_COVERAGE_BRANCH_COVERAGE)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#  - CODE_COVERAGE_LCOV_SHOPTS: Extra options to shared=
 between both lcov</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
    instances=2E (Default: $CODE_COVERAGE_LCOV_SHOPTS_DEFAULT)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#  - CODE_COVERAGE_LCOV_OPTIONS_=
GCOVPATH: --gcov-tool pathtogcov</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#  - CODE_COVERAGE_LCOV_OPTIONS_DEFAULT: Extra options to pass=
 to the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#    collect=
ing lcov instance=2E (Default: $CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#  - CODE_COVERAGE_LCOV_OP=
TIONS: Extra options to pass to the collecting lcov</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#    instance=2E (Default: $CODE_COVERAGE=
_LCOV_OPTIONS_DEFAULT)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#  - CODE_COVERAGE_LCOV_RMOPTS_DEFAULT: Extra options to pass to the fil=
tering</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#    lcov ins=
tance=2E (Default: empty)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#  - CODE_COVERAGE_LCOV_RMOPTS: Extra options to pass to the filterin=
g lcov</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#    instance=
=2E (Default: $CODE_COVERAGE_LCOV_RMOPTS_DEFAULT)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#  - CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT: E=
xtra options to pass to the</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#    genhtml instance=2E (Default: based on $CODE_COVERAGE_BRANCH_C=
OVERAGE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  - CODE_C=
OVERAGE_GENHTML_OPTIONS: Extra options to pass to the genhtml</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#    instance=2E (Default: $CODE_=
COVERAGE_GENHTML_OPTIONS_DEFAULT)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#  - CODE_COVERAGE_IGNORE_PATTERN: Extra glob pattern of file=
s to ignore</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+# The generated report wil=
l be titled using the \$(PACKAGE_NAME) and</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+# \$(PACKAGE_VERSION)=2E In order to add the current=
 git hash to the title,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# use the git-version-gen script, available online=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+# Optional variables</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+# run only on top dir</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+if CODE_COVERAGE_ENABLED</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ ifeq (\$(abs_builddir), \$(a=
bs_top_builddir))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CO=
DE_COVERAGE_DIRECTORY ?=3D \$(top_builddir)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+CODE_COVERAGE_OUTPUT_FILE ?=3D \$(PACKAGE_NAME)-\$(=
PACKAGE_VERSION)-coverage=2Einfo</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+CODE_COVERAGE_OUTPUT_DIRECTORY ?=3D \$(PACKAGE_NAME)-\$(PACKAG=
E_VERSION)-coverage</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CODE_COVERAGE_BRANC=
H_COVERAGE ?=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CODE=
_COVERAGE_LCOV_SHOPTS_DEFAULT ?=3D \$(if \$(CODE_COVERAGE_BRANCH_COVERAGE),=
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+--rc lcov_branch_c=
overage=3D\$(CODE_COVERAGE_BRANCH_COVERAGE))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+CODE_COVERAGE_LCOV_SHOPTS ?=3D \$(CODE_COVERAGE_LC=
OV_SHOPTS_DEFAULT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+C=
ODE_COVERAGE_LCOV_OPTIONS_GCOVPATH ?=3D --gcov-tool \&quot;\$(GCOV)\&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+CODE_COVERAGE_LCOV_O=
PTIONS_DEFAULT ?=3D \$(CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+CODE_COVERAGE_LCOV_OPTIONS ?=3D \$(=
CODE_COVERAGE_LCOV_OPTIONS_DEFAULT)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+CODE_COVERAGE_LCOV_RMOPTS_DEFAULT ?=3D</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+CODE_COVERAGE_LCOV_RMOPTS ?=3D \$(CODE_C=
OVERAGE_LCOV_RMOPTS_DEFAULT)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT ?=3D\</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+\$(if \$(CODE_COVERAGE_BRANCH_COVERAGE),\=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+--rc genhtml_branch=
_coverage=3D\$(CODE_COVERAGE_BRANCH_COVERAGE))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+CODE_COVERAGE_GENHTML_OPTIONS ?=3D \$(CODE_COVER=
AGE_GENHTML_OPTIONS_DEFAULT)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+CODE_COVERAGE_IGNORE_PATTERN ?=3D</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+GITIGNOREFILES :=3D \$(GITIGNOREFILES) \$(CODE_COVERAGE_OUTPUT_FILE) \$=
(CODE_COVERAGE_OUTPUT_DIRECTORY)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+code_coverage_v_lcov_cap =3D \$(code_coverage_v_lcov_cap_\$(V)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+code_coverage_v_lc=
ov_cap_ =3D \$(code_coverage_v_lcov_cap_\$(AM_DEFAULT_VERBOSITY))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+code_coverage_v_lcov_cap_0 =
=3D @echo \&quot;  LCOV   --capture\&quot; \$(CODE_COVERAGE_OUTPUT_FILE);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+code_coverage_v_lcov_=
ign =3D \$(code_coverage_v_lcov_ign_\$(V))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+code_coverage_v_lcov_ign_ =3D \$(code_coverage_v_lco=
v_ign_\$(AM_DEFAULT_VERBOSITY))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+code_coverage_v_lcov_ign_0 =3D @echo \&quot;  LCOV   --remove\&=
quot; \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)=2Etmp\&quot; \$(CODE_COVERAGE_IG=
NORE_PATTERN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+code_=
coverage_v_genhtml =3D \$(code_coverage_v_genhtml_\$(V))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+code_coverage_v_genhtml_ =3D \$(code_c=
overage_v_genhtml_\$(AM_DEFAULT_VERBOSITY))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+code_coverage_v_genhtml_0 =3D @echo \&quot;  GEN   =
\&quot; \&quot;\$(CODE_COVERAGE_OUTPUT_DIRECTORY)\&quot;;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+code_coverage_quiet =3D \$(code_cover=
age_quiet_\$(V))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cod=
e_coverage_quiet_ =3D \$(code_coverage_quiet_\$(AM_DEFAULT_VERBOSITY))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+code_coverage_quiet_0 =
=3D --quiet</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+# sanitizes the test-name: =
replaces with underscores: dashes and dots</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+code_coverage_sanitize =3D \$(subst -,_,\$(subst =2E=
,_,\$(1)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# Use recursive makes in ord=
er to ignore errors during check</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+check-code-coverage:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	-\$(AM_V_at)\$(MAKE) \$(AM_MAKEFLAGS) -k check</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+	\$(AM_V_at)\$(MAKE) \$(AM_MAKEFL=
AGS) code-coverage-capture</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Capture co=
de coverage data</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cod=
e-coverage-capture: code-coverage-capture-hook</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+	\$(code_coverage_v_lcov_cap)\$(LCOV) \$(code_co=
verage_quiet) \$(addprefix --directory ,\$(CODE_COVERAGE_DIRECTORY)) --capt=
ure --output-file \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)=2Etmp\&quot; --test-=
name \&quot;\$(call code_coverage_sanitize,\$(PACKAGE_NAME)-\$(PACKAGE_VERS=
ION))\&quot; --no-checksum --compat-libtool \$(CODE_COVERAGE_LCOV_SHOPTS) \=
$(CODE_COVERAGE_LCOV_OPTIONS)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	\$(code_coverage_v_lcov_ign)\$(LCOV) \$(code_coverage_quiet) \$(=
addprefix --directory ,\$(CODE_COVERAGE_DIRECTORY)) --remove \&quot;\$(CODE=
_COVERAGE_OUTPUT_FILE)=2Etmp\&quot; \$(CODE_COVERAGE_IGNORE_PATTERN) --outp=
ut-file \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)\&quot; \$(CODE_COVERAGE_LCOV_S=
HOPTS) \$(CODE_COVERAGE_LCOV_RMOPTS)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	-@rm -f \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)=2Etmp\&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	\$(code_coverage_v=
_genhtml)LANG=3DC \$(GENHTML) \$(code_coverage_quiet) \$(addprefix --prefix=
 ,\$(CODE_COVERAGE_DIRECTORY)) --output-directory \&quot;\$(CODE_COVERAGE_O=
UTPUT_DIRECTORY)\&quot; --title \&quot;\$(PACKAGE_NAME)-\$(PACKAGE_VERSION)=
 Code Coverage\&quot; --legend --show-details \&quot;\$(CODE_COVERAGE_OUTPU=
T_FILE)\&quot; \$(CODE_COVERAGE_GENHTML_OPTIONS)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	@echo \&quot;file://\$(abs_builddir)/\$(CODE_=
COVERAGE_OUTPUT_DIRECTORY)/index=2Ehtml\&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+code-coverage-clean:</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	-\$(LCOV) --directory \$(top_builddir) -z</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	-rm -rf \&quot;\$(CODE_COVERAGE_OUTPUT_F=
ILE)\&quot; \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)=2Etmp\&quot; \&quot;\$(COD=
E_COVERAGE_OUTPUT_DIRECTORY)\&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+	-find =2E \\( -name \&quot;*=2Egcda\&quot; -o -name \&quot=
;*=2Egcno\&quot; -o -name \&quot;*=2Egcov\&quot; \\) -delete</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+code-coverage-dist-clean:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+A][M_DISTCHECK_CONFIGURE_FLAGS :=3D \$(A][M_DISTCHECK_CONFIGURE_FL=
AGS) --disable-code-coverage</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ else # ifneq (\$(abs_builddir), \$(abs_top_builddir))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+check-code-coverage:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+code-coverage-capture: code-coverage-capture-hook=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+code-coverage-clean:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+code-coverage-dist-clean:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ endif # ifeq (\$(abs_builddir), \$(abs_top_buildd=
ir))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+else #! CODE_CO=
VERAGE_ENABLED</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Use=
 recursive makes in order to ignore errors during check</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+check-code-coverage:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+	@echo \&quot;Need to reconfigure with=
 --enable-code-coverage\&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+# Capture code coverage data</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+code-coverage-capture: code-coverage-capture-hook</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+	@echo \&quot;Need to rec=
onfigure with --enable-code-coverage\&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+code-coverage-clean:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+code-coverage=
-dist-clean:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+endif #CODE_COVERAGE_ENABL=
ED</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Hook rule execu=
ted before code-coverage-capture, overridable by the user</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+code-coverage-capture-hook:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+=2EPHONY: check-code-coverage code-coverage-capt=
ure code-coverage-dist-clean code-coverage-clean code-coverage-capture-hook=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+])</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+])</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+AC_DEFUN([_AX_CODE_COVERAGE_ENABLED],[</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	AX_CHECK_GNU_MAKE([],[AC_MSG_ERROR([not using GNU ma=
ke that is needed for coverage])])</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+	AC_REQUIRE([AX_ADD_AM_MACRO_STATIC])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	# check for gcov</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	AC_CHECK_TOOL([GCOV],</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+		  [$_AX_CODE_COVERAGE_GCOV_PROG_WITH=
],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		  [:])</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+	AS_IF([test &quot;X$GCOV&qu=
ot; =3D &quot;X:&quot;],</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	      [AC_MSG_ERROR([gcov is needed to do coverage])])</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+	AC_SUBST([GCOV])</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+	dnl Check if gcc is being used</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	AS_IF([ test &quot;$GCC&quot; =3D &quot;=
no&quot; ], [</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		AC_M=
SG_ERROR([not compiling with gcc, which is required for gcov code coverage]=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	      ])</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	AC_CHECK_PROG([LCOV], [lcov], [lcov])</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+	AC_CHECK_PROG([GENHTML], [g=
enhtml], [genhtml])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	AS_IF([ test x&quo=
t;$LCOV&quot; =3D x ], [</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+		AC_MSG_ERROR([To enable code coverage reporting you must have lcov i=
nstalled])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	      ])=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+	AS_IF([ test x&quot;$GENHTML&quot; =
=3D x ], [</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		AC_MSG_=
ERROR([Could not find genhtml from the lcov package])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	])</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	=
AC_CHECK_LIB([gcov], [_gcov_init], [CODE_COVERAGE_LIBS=3D&quot;-lgcov&quot;=
], [CODE_COVERAGE_LIBS=3D&quot;&quot;])</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	dnl Build the code coverage flags</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+	dnl Define CODE_COVERAGE_LDFLAGS for backwards compatibili=
ty</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	CODE_COVERAGE_CP=
PFLAGS=3D&quot;-DNDEBUG&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	CODE_COVERAGE_CFLAGS=3D&quot;-O0 -g -fprofile-arcs -ftest-covera=
ge&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	CODE_COVER=
AGE_CXXFLAGS=3D&quot;-O0 -g -fprofile-arcs -ftest-coverage&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	AC_SUBST([CODE_COVERAGE_CPPFLAGS])</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+	AC_SUBST([CODE_COVERAGE_CFLAGS])=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	AC_SUBST([CODE_COV=
ERAGE_CXXFLAGS])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	AC=
_SUBST([CODE_COVERAGE_LIBS])</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+AC_DEFUN([AX_CODE_COVERAGE]=
,[</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	dnl Check for --=
enable-code-coverage</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	# allow to overri=
de gcov location</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	AC=
_ARG_WITH([gcov],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	 =
 [AS_HELP_STRING([--with-gcov[=3DGCOV]], [use given GCOV for coverage (GCOV=
=3Dgcov)=2E])],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	  [=
_AX_CODE_COVERAGE_GCOV_PROG_WITH=3D$with_gcov],</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	  [_AX_CODE_COVERAGE_GCOV_PROG_WITH=3Dgcov])</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+	AC_MSG_CHECKING([whether to build with =
code coverage support])</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+	AC_ARG_ENABLE([code-coverage],</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+	  AS_HELP_STRING([--enable-code-coverage],</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+	  [Whether to enable code coverage=
 support]),,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	  enab=
le_code_coverage=3Dno)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	AM_CONDITIONAL(=
[CODE_COVERAGE_ENABLED], [test &quot;x$enable_code_coverage&quot; =3D xyes]=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	AC_SUBST([CODE_CO=
VERAGE_ENABLED], [$enable_code_coverage])</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	AC_MSG_RESULT($enable_code_coverage)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	AS_IF([ test &quot;x$enable_code_coverage&quot; =3D x=
yes ], [</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		_AX_CODE_=
COVERAGE_ENABLED</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	  =
    ])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+	_AX_CODE_COVERAGE_RULES</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+])</span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1591?usp=3Demail">change 1591</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1591?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: Iba7e5e553679ec0cf47cb2e5d9b2fb1859ea767c=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1591 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</bod=
y></html>
--l//mGV5ukgc=--


--===============2178487917657995544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2178487917657995544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2178487917657995544==--

