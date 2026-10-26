Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CAE606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 02:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QVBUwufI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NtPuuDk0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=O1awzOjD;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JPDSDcjv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2Z8owOK+9TyHlAKfYEKHXD93WtQALnm7r6YROl/ZjnU=; b=QVBUwufI7vdFT8jbfPdlx1v3OK
	3dEGMvyh1PudRjd6qDaFzRltnovhBcyFdjTZ9YB+xJN/Qnceg7I6vszfHadMg5XLZiEjAU1dw9vXw
	TIBwxj8nFfIVOpmFj6I9ZE4SHd0UgamjR+avfTPzgcYQSqzAEXk3hZ5TbT93w7GN1hC4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLAqm-000000006H2-3Yck;
	Mon, 26 Oct 2026 02:54:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLAqb-000000006Gl-1HDC
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 02:54:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sygj7wktUiPFj6xTokA/3DSXLyJqAeMvzCXO8xeItQs=; b=NtPuuDk0c3poJUirU2UyrA2/EN
 v6kPo9Hv1Tfimdndw4503sU30CK24WbqaPiJEhu7wvPjMKCcOFjh+1Sff37BcdyMPeEInmO8utQCa
 IqCG65TyfM35mHKC91kqsATAjvN19/0CGuxFLiqqY6lr+zCALZgAkSX8XI/psJDeGJ0Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sygj7wktUiPFj6xTokA/3DSXLyJqAeMvzCXO8xeItQs=; b=O1awzOjD2UAgYsso/tcctjE+Mk
 jq8fgTaY2p8Rc4tA6wQKDDeUk2r9XyQ2wtQu2C96lExdbNZC+vTuzRcUdqAmLKHT4KW9rKfkd/DsP
 ohul0ZRWwatWt6gLZ0jKUfj0ngm5vaqqTNdOvOHDcWRDgmuHbq/Jv9+w0S5S7xvpyzkA=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLAqY-000000008Kf-0rPz for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 02:54:05 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so19712195e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 25 Oct 2026 19:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792983236; x=1793588036; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sygj7wktUiPFj6xTokA/3DSXLyJqAeMvzCXO8xeItQs=;
 b=JPDSDcjvchfPrXJY2m0kauWqPvcWFewCYxzhegHT/mY3w2kNL7OZ8bZjAaO4grctba
 9yUJo9ouSACoakEBL/BcXc87slRxttatf9pbsR4GWPjCy0e0+BtUKuCuAI3RdoBJS6m9
 BET4QbNUPKe9Hrf+0PKw0pFCXT1PvgTdD6sIKytECgqxryaA6b7akx2B9aOfpwOzgp78
 Pt//RPpkWiiwM81GfK6pKYdSsTHez1AYErQ/D19wKQ2K8LoQrVKxFjmUUuy5RoIvjXcn
 Okpz0kH86QEgICSpWLEbrIp0tC33fGNASkwnWmw1xdhHvOW/KUJEf3J75xzTp7vh2iq/
 e2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792983236; x=1793588036;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sygj7wktUiPFj6xTokA/3DSXLyJqAeMvzCXO8xeItQs=;
 b=Xq+NGWyn80ZH8ByEj7Mr4Vgwd4KgF643tLpR/egoWxkeOHoToQ4hzZ2LewbWbWLvmk
 c3TmsA8AMvfyR3suky+sVKpkFFUgpHukoE1vrof1lSs2L5iSSQy/LtMZuY+ohLy4k+yG
 N1TGNhIwLVIEXh/tKGmQc8Y849HvtZ6bDPmpF8Qvte4v9n9U2fFAHP5fTuLXp14Y9NZZ
 01zvWof4KexqOhuBi2TfNiIM1N6agNgm8lx5aSt3Pk/m0aYaLXwfEBd7uhrz3B7ipgoZ
 yZULwfphFupfW+kJoMGknhCntgWk7uMLWK5P0YPGvZbIrQWIuXiSrDb+ooRNbIo9fVZS
 8I/A==
X-Gm-Message-State: AFq9FYKyGIsQlTpgIWH4Im6bmTWtwZ1ysgKX5lNrY0PNvrNpy9jYIZQf
 ibxW4Zwzk1LmqHP44uOD7dq/KmjrYV6m8JxAZA3B0kI+dqLmJmO2Xa8zSVtCHnVPSA4viqKEAAX
 tzM07D8qcn0puU/HpHPJM9363bzUCebZUu8dxdNMvGhIvbhl3juJCyuLkA9PNz2dXTsqH
X-Gm-Gg: AYBFou1UhUqBLvjzMNh+M5L2i9DkEnYxDytJxQJDuf/rSR2qnPDTjHiKE+bGDbK9joZ
 Lw6bpuuWsBhQkdVNlCneLd76cWRTXhFhHdcic7i4lGzoKSVbcN02bg01Qx+Z7YNUvHppKiV7jo6
 oY5OuxT6ioDZuEjBQtnao+Vq4rlpydN6JN7424rZVAcYvEnnAip/5ixRvoPXZH271sdkqWuDroh
 HaCvJ26gUPqDN5tVi/4hpSJoRapPZCiXtw0PKftIi+3HQSCwmMLKLajAFhL/7cg/PN3nOkOFv2i
 ZUG5dMrhSqCNm+lgSNt0e5PNA9o7kNKB9LVAxr2zDJPtVU4T6vXU9I33WXtD2Ftg5N8zwy2q184
 7+JtNN6uPZc74e8V3CyacHBd5P7eylugVjlP0cvtmtkZUuQZn3lKzQyaGujmDlCmlO6Mqhf3QWG
 GW/oMkkEO7V1wNOYWIkTvQ6CNDRiaxhGG4p7Q4slbsoVpGpM7Ux3FkSMpwpHG84789AYEnDsOmu
 Js6E+xEEohlrCJOjAyxW+PalazCiKQWnscn4kQbK/dnd+EZgF8mkohUubsm3WKNrTdRzE6uzMsm
 l9e1AGoF/In7EbcbWfPMJwj8iuZ00T+siu/SXLn5XLyh/54L/LsiyQRgXd5HVkjL+HxGjHBQolm
 JtjKp17FJ52K+EBUqyCK5sJaMElkDL87nqWoHns0WjQ==
X-Received: by 2002:a05:600c:8183:b0:4a1:cef3:fb3a with SMTP id
 5b1f17b1804b1-4a35ac99b77mr85627775e9.9.1792983235386; 
 Sun, 25 Oct 2026 19:53:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a2c0458sm159109605e9.11.2026.10.25.19.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 19:53:54 -0700 (PDT)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 02:53:51 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde
X-Gerrit-Change-Number: 1946
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1946?usp=email>
X-Gerrit-Commit: ba8d6bec6cc54fe12ed373e0f52d46fc526763d1
In-Reply-To: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
References: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMjEyMjE1MDAwLkk5MDg1YzU1YTdlZmVmZDMxODM5YjAwZWM4ZWM5YTZmMDg1NTc0ZGRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f3e330c4e8b64ccd751c55132cf91327b1d83945-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLAqY-000000008Kf-0rPz
Subject: [Openvpn-devel] [M] Change in openvpn[master]: tests: add unit
 tests for route.c
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "chugly \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: charlie.vigue@openvpn.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "chugly \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2157026038028543426=="
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2157026038028543426==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tmG4i94aKkw="; charset=UTF-8

--tmG4i94aKkw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru, chugly=2E

Hello Arne Schwabe, Frank Lichtenheld, R=C4=83=
zvan Cojocaru, 

I'd like you to reexamine a change=2E Please visit

    ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail

to look at the n=
ew patch set (#6)=2E

The following approvals got outdated and were removed=
:
Code-Review+2 by R=C4=83zvan Cojocaru

The change is no longer submittabl=
e: Code-Review and checks~ChecksSubmitRule are unsatisfied now=2E


Change =
subject: tests: add unit tests for route=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

tests: add unit tests for route=2Ec

route=
=2Ec has no unit test coverage at all, so there is nowhere to put a
test wh=
en touching it=2E  Cover the pure helpers it already exports: the
special a=
ddress predicate, both netmask-to-netbits conversions, and the
IPv6 prefix =
host-bit masking=2E

The two conversions disagree on a full-length netmask:=

netmask_to_netbits() reports -1 and netmask_to_netbits2() reports 32=2E
--=
server relies on the -1 to reject a /32, so pin it down=2E

Rather than add=
 a driver of its own, the tests are hosted by
networking_testdriver as case=
 9, alongside its existing cases=2E  That
driver is already gated on HAVE_S=
ITNL, which is what route=2Ec needs: it
reaches the routing table through n=
et_route_* on Linux and through
argv/execve elsewhere, so one set of stubs =
cannot link on both=2E
t_net=2Esh runs the cases above LAST_AUTO_TEST after=
 it has removed its
dummy interface, so the route tests need no interface a=
nd no particular
network state=2E

route=2Ec links against the real network=
ing_sitnl=2Ec that the driver
already carries=2E  Only the socket and argv =
helpers that route=2Ec
references but no test here reaches are stubbed, and=
 those assert rather
than return quietly, so a test straying onto one fails=
 loudly=2E

Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde
Signed-off=
-by: Charlie Vigue <charlie=2Evigue@openvpn=2Ecom>
---
M CMakeLists=2Etxt
M=
 tests/t_net=2Esh
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_tes=
ts/openvpn/test_networking=2Ec
A tests/unit_tests/openvpn/test_route=2Ec
A =
tests/unit_tests/openvpn/test_route=2Eh
6 files changed, 228 insertions(+),=
 2 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/46/1946/6

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index=
 184a95a=2E=2Ea68e37c 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
=
@@ -976,7 +976,14 @@
     if (TARGET test_networking)
         target_link_=
options(test_networking PRIVATE -Wl,--wrap=3Dparse_line)
         target_co=
mpile_options(test_networking PRIVATE -UNDEBUG)
+        target_link_librar=
ies(test_networking PUBLIC ${RESOLV_LIBRARIES})
         target_sources(tes=
t_networking PRIVATE
+            tests/unit_tests/openvpn/test_route=2Ec
+=
            tests/unit_tests/openvpn/mock_management=2Ec
+            src/o=
penvpn/route=2Ec
+            src/openvpn/env_set=2Ec
+            src/open=
vpn/run_command=2Ec
+            src/openvpn/socket_util=2Ec
             s=
rc/openvpn/networking_sitnl=2Ec
             src/openvpn/crypto_epoch=2Ec
 =
            src/openvpn/crypto_mbedtls=2Ec
diff --git a/tests/t_net=2Esh b/=
tests/t_net=2Esh
index d63f648=2E=2Efd07277 100755
--- a/tests/t_net=2Esh
+=
++ b/tests/t_net=2Esh
@@ -3,7 +3,7 @@
 IFACE=3D"ovpn-dummy0"
 UNIT_TEST=3D"=
=2E/unit_tests/openvpn/networking_testdriver"
 LAST_AUTO_TEST=3D7
-LAST_TES=
T=3D8
+LAST_TEST=3D9
 
 srcdir=3D"${srcdir:-=2E}"
 top_builddir=3D"${top_bu=
ilddir:-=2E=2E}"
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/test=
s/unit_tests/openvpn/Makefile=2Eam
index 43a6743=2E=2E5abe497 100644
--- a/=
tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makef=
ile=2Eam
@@ -220,8 +220,14 @@
 networking_testdriver_LDFLAGS =3D @TEST_LDFL=
AGS@ -L$(top_srcdir)/src/openvpn \
 	$(OPTIONAL_CRYPTO_LIBS)
 networking_te=
stdriver_SOURCES =3D test_networking=2Ec mock_msg=2Ec \
+	test_route=2Ec te=
st_route=2Eh test_common=2Eh \
+	mock_management=2Ec \
 	$(top_srcdir)/src/=
compat/compat-strlcpy=2Ec \
 	$(top_srcdir)/src/openvpn/networking_sitnl=2E=
c \
+	$(top_srcdir)/src/openvpn/route=2Ec \
+	$(top_srcdir)/src/openvpn/env=
_set=2Ec \
+	$(top_srcdir)/src/openvpn/run_command=2Ec \
+	$(top_srcdir)/sr=
c/openvpn/socket_util=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$(to=
p_srcdir)/src/openvpn/crypto=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_epoch=
=2Ec \
diff --git a/tests/unit_tests/openvpn/test_networking=2Ec b/tests/un=
it_tests/openvpn/test_networking=2Ec
index 1c9cac1=2E=2E849f247 100644
--- =
a/tests/unit_tests/openvpn/test_networking=2Ec
+++ b/tests/unit_tests/openv=
pn/test_networking=2Ec
@@ -2,6 +2,8 @@
 #include "syshead=2Eh"
 #include "n=
etworking=2Eh"
 
+#include "test_route=2Eh"
+
 #include <setjmp=2Eh>
 #incl=
ude <cmocka=2Eh>
 
@@ -212,7 +214,7 @@
 static void
 usage(char *name)
 {
-=
    printf("Usage: %s <0-8>\n", name);
+    printf("Usage: %s <0-9>\n", nam=
e);
 }
 
 int
@@ -272,6 +274,9 @@
             assert_int_equal(net__iface_=
type("dummy0815", NULL), -ENODEV);
             return 0;
 
+        case 9=
:
+            return route_tests();
+
         default:
             print=
f("invalid test: %d\n", test);
             break;
diff --git a/tests/unit_=
tests/openvpn/test_route=2Ec b/tests/unit_tests/openvpn/test_route=2Ec
new =
file mode 100644
index 0000000=2E=2E3cfee9b
--- /dev/null
+++ b/tests/unit_=
tests/openvpn/test_route=2Ec
@@ -0,0 +1,181 @@
+/*
+ *  OpenVPN -- An appli=
cation to securely tunnel IP networks
+ *             over a single UDP por=
t, with support for SSL/TLS-based
+ *             session authentication an=
d key exchange,
+ *             packet encryption, packet authentication, a=
nd
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 O=
penVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; yo=
u can redistribute it and/or modify
+ *  it under the terms of the GNU Gene=
ral Public License version 2
+ *  as published by the Free Software Foundat=
ion=2E
+ *
+ *  This program is distributed in the hope that it will be use=
ful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ =
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU=
 General Public License for more details=2E
+ *
+ *  You should have receiv=
ed a copy of the GNU General Public License along
+ *  with this program; i=
f not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFI=
G_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include "t=
est_common=2Eh"
+
+#include "route=2Eh"
+#include "networking=2Eh"
+
+#incl=
ude "test_route=2Eh"
+
+/* Stubs for functions route=2Ec references but tha=
t no test here reaches=2E
+ * They assert rather than return quietly, so a =
test straying onto one
+ * fails loudly instead of silently doing nothing=
=2E
+ */
+struct argv
+argv_new(void)
+{
+    assert_true(0);
+    struct a=
rgv a =3D { 0 };
+    return a;
+}
+
+void
+argv_free(struct argv *a)
+{
+ =
   assert_true(0);
+}
+
+bool
+get_ipv6_addr(const char *prefix_str, struct=
 in6_addr *network, unsigned int *netbits,
+              msglvl_t msglevel=
)
+{
+    assert_true(0);
+    return false;
+}
+
+in_addr_t
+getaddr(unsig=
ned int flags, const char *hostname, int resolve_retry, bool *succeeded,
+ =
       struct signal_info *sig_info)
+{
+    assert_true(0);
+    return 0;=

+}
+
+int
+openvpn_getaddrinfo(unsigned int flags, const char *hostname, c=
onst char *servname,
+                    int resolve_retry_seconds, struct=
 signal_info *sig_info, int ai_family,
+                    struct addrinfo=
 **res)
+{
+    assert_true(0);
+    return 0;
+}
+
+struct signal_info sig=
info_static; /* GLOBAL */
+
+int
+signal_reset(struct signal_info *si, int =
signum)
+{
+    assert_true(0);
+    return 0;
+}
+
+static void
+test_is_s=
pecial_addr(void **state)
+{
+    assert_true(is_special_addr("net_gateway"=
));
+    assert_true(is_special_addr("vpn_gateway"));
+    assert_true(is_s=
pecial_addr("remote_host"));
+
+    assert_false(is_special_addr("10=2E0=2E=
0=2E1"));
+    assert_false(is_special_addr("default"));
+    assert_false(=
is_special_addr(NULL));
+}
+
+static void
+test_netmask_to_netbits(void **s=
tate)
+{
+    int netbits;
+
+    assert_true(netmask_to_netbits(0x0a000000=
, 0xff000000, &netbits)); /* 10/8 */
+    assert_int_equal(netbits, 8);
+
+=
    assert_true(netmask_to_netbits(0xc0a80100, 0xffffff00, &netbits)); /* 1=
92=2E168=2E1/24 */
+    assert_int_equal(netbits, 24);
+
+    assert_true(n=
etmask_to_netbits(0x00000000, 0x00000000, &netbits)); /* default route */
+=
    assert_int_equal(netbits, 0);
+
+    /* a full-length mask reports -1 r=
ather than 32 */
+    assert_true(netmask_to_netbits(0x0a010203, 0xffffffff=
, &netbits));
+    assert_int_equal(netbits, -1);
+
+    /* host bits set i=
n the network part */
+    assert_false(netmask_to_netbits(0x0a000001, 0xff=
000000, &netbits));
+
+    /* not a contiguous netmask */
+    assert_false=
(netmask_to_netbits(0x0a000000, 0xff00ff00, &netbits));
+}
+
+static void
+=
test_netmask_to_netbits2(void **state)
+{
+    assert_int_equal(netmask_to_=
netbits2(0xff000000), 8);
+    assert_int_equal(netmask_to_netbits2(0xfffff=
f00), 24);
+    assert_int_equal(netmask_to_netbits2(0x00000000), 0);
+
+  =
  /* unlike netmask_to_netbits(), this one reports a full-length mask as 32=
 */
+    assert_int_equal(netmask_to_netbits2(0xffffffff), 32);
+
+    asse=
rt_int_equal(netmask_to_netbits2(0xff00ff00), -1);
+}
+
+static void
+asser=
t_clear_host_bits(const char *addr, unsigned int netbits, const char *expec=
ted)
+{
+    struct route_ipv6 r6;
+    struct in6_addr want;
+
+    CLEAR(=
r6);
+    assert_int_equal(inet_pton(AF_INET6, addr, &r6=2Enetwork), 1);
+ =
   assert_int_equal(inet_pton(AF_INET6, expected, &want), 1);
+    r6=2Enet=
bits =3D netbits;
+
+    route_ipv6_clear_host_bits(&r6);
+    assert_memor=
y_equal(&r6=2Enetwork, &want, sizeof(struct in6_addr));
+}
+
+static void
+=
test_route_ipv6_clear_host_bits(void **state)
+{
+    /* whole bytes cleare=
d */
+    assert_clear_host_bits("2001:db8::1", 64, "2001:db8::");
+    ass=
ert_clear_host_bits("2001:db8:dead:beef::1", 32, "2001:db8::");
+
+    /* a=
 prefix that does not fall on a byte boundary */
+    assert_clear_host_bit=
s("2001:db8:0:00ff::1", 60, "2001:db8:0:00f0::");
+    assert_clear_host_bi=
ts("2001:db8::ffff", 121, "2001:db8::ff80");
+
+    /* nothing to clear, an=
d everything to clear */
+    assert_clear_host_bits("2001:db8::1", 128, "2=
001:db8::1");
+    assert_clear_host_bits("2001:db8::1", 0, "::");
+}
+
+st=
atic const struct CMUnitTest route_test_list[] =3D {
+    cmocka_unit_test(=
test_is_special_addr),
+    cmocka_unit_test(test_netmask_to_netbits),
+   =
 cmocka_unit_test(test_netmask_to_netbits2),
+    cmocka_unit_test(test_rou=
te_ipv6_clear_host_bits),
+};
+
+int
+route_tests(void)
+{
+    openvpn_uni=
t_test_setup();
+    return cmocka_run_group_tests(route_test_list, NULL, N=
ULL);
+}
diff --git a/tests/unit_tests/openvpn/test_route=2Eh b/tests/unit_=
tests/openvpn/test_route=2Eh
new file mode 100644
index 0000000=2E=2Ecaa5c3=
c
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_route=2Eh
@@ -0,0 +1,27=
 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *  =
           over a single UDP port, with support for SSL/TLS-based
+ *      =
       session authentication and key exchange,
+ *             packet encr=
yption, packet authentication, and
+ *             packet compression=2E
+ =
*
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  T=
his program is free software; you can redistribute it and/or modify
+ *  it=
 under the terms of the GNU General Public License version 2
+ *  as publis=
hed by the Free Software Foundation=2E
+ *
+ *  This program is distributed=
 in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without=
 even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICU=
LAR PURPOSE=2E  See the
+ *  GNU General Public License for more details=2E=

+ *
+ *  You should have received a copy of the GNU General Public License=
 along
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/license=
s/>=2E
+ */
+#ifndef TEST_ROUTE_H
+#define TEST_ROUTE_H
+/** Runs the route=
=2Ec unit tests, returns the number of failures */
+int
+route_tests(void);=

+#endif

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/194=
6?usp=3Demail
To unsubscribe, or for help writing mail filters, visit https=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatc=
hset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9085c=
55a7efefd31839b00ec8ec9a6f085574dde
Gerrit-Change-Number: 1946
Gerrit-Patch=
Set: 6
Gerrit-Owner: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-Reviewer=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvan=
c@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-At=
tention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld =
<frank@lichtenheld=2Ecom>

--tmG4i94aKkw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
, chugly=2E </p>
<p>chugly <strong>uploaded patch set #6</strong> to this c=
hange=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?u=
sp=3Demail">View Change</a></p><p>The following approvals got outdated and =
were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><p>The change is no =
longer submittable: Code-Review and checks~ChecksSubmitRule are unsatisfied=
 now=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">tests: add unit tests for route=2Ec<br><br>route=
=2Ec has no unit test coverage at all, so there is nowhere to put a<br>test=
 when touching it=2E  Cover the pure helpers it already exports: the<br>spe=
cial address predicate, both netmask-to-netbits conversions, and the<br>IPv=
6 prefix host-bit masking=2E<br><br>The two conversions disagree on a full-=
length netmask:<br>netmask_to_netbits() reports -1 and netmask_to_netbits2(=
) reports 32=2E<br>--server relies on the -1 to reject a /32, so pin it dow=
n=2E<br><br>Rather than add a driver of its own, the tests are hosted by<br=
>networking_testdriver as case 9, alongside its existing cases=2E  That<br>=
driver is already gated on HAVE_SITNL, which is what route=2Ec needs: it<br=
>reaches the routing table through net_route_* on Linux and through<br>argv=
/execve elsewhere, so one set of stubs cannot link on both=2E<br>t_net=2Esh=
 runs the cases above LAST_AUTO_TEST after it has removed its<br>dummy inte=
rface, so the route tests need no interface and no particular<br>network st=
ate=2E<br><br>route=2Ec links against the real networking_sitnl=2Ec that th=
e driver<br>already carries=2E  Only the socket and argv helpers that route=
=2Ec<br>references but no test here reaches are stubbed, and those assert r=
ather<br>than return quietly, so a test straying onto one fails loudly=2E<b=
r><br>Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde<br>Signed-off-by=
: Charlie Vigue &lt;charlie=2Evigue@openvpn=2Ecom&gt;<br>---<br>M CMakeList=
s=2Etxt<br>M tests/t_net=2Esh<br>M tests/unit_tests/openvpn/Makefile=2Eam<b=
r>M tests/unit_tests/openvpn/test_networking=2Ec<br>A tests/unit_tests/open=
vpn/test_route=2Ec<br>A tests/unit_tests/openvpn/test_route=2Eh<br>6 files =
changed, 228 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/46/1946/6</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 1=
84a95a=2E=2Ea68e37c 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br=
><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -976,7 +976,14 @@</span><b=
r><span>     if (TARGET test_networking)</span><br><span>         target_li=
nk_options(test_networking PRIVATE -Wl,--wrap=3Dparse_line)</span><br><span=
>         target_compile_options(test_networking PRIVATE -UNDEBUG)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        target_link_librarie=
s(test_networking PUBLIC ${RESOLV_LIBRARIES})</span><br><span>         targ=
et_sources(test_networking PRIVATE</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            tests/unit_tests/openvpn/test_route=2Ec</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            tests/unit_tests=
/openvpn/mock_management=2Ec</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            src/openvpn/route=2Ec</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            src/openvpn/env_set=2Ec</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/run_command=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            src=
/openvpn/socket_util=2Ec</span><br><span>             src/openvpn/networkin=
g_sitnl=2Ec</span><br><span>             src/openvpn/crypto_epoch=2Ec</span=
><br><span>             src/openvpn/crypto_mbedtls=2Ec</span><br><span>diff=
 --git a/tests/t_net=2Esh b/tests/t_net=2Esh</span><br><span>index d63f648=
=2E=2Efd07277 100755</span><br><span>--- a/tests/t_net=2Esh</span><br><span=
>+++ b/tests/t_net=2Esh</span><br><span>@@ -3,7 +3,7 @@</span><br><span> IF=
ACE=3D&quot;ovpn-dummy0&quot;</span><br><span> UNIT_TEST=3D&quot;=2E/unit_t=
ests/openvpn/networking_testdriver&quot;</span><br><span> LAST_AUTO_TEST=3D=
7</span><br><span style=3D"color: hsl(0, 100%, 40%);">-LAST_TEST=3D8</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+LAST_TEST=3D9</span><br><s=
pan> </span><br><span> srcdir=3D&quot;${srcdir:-=2E}&quot;</span><br><span>=
 top_builddir=3D&quot;${top_builddir:-=2E=2E}&quot;</span><br><span>diff --=
git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Mak=
efile=2Eam</span><br><span>index 43a6743=2E=2E5abe497 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/=
unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -220,8 +220,14 @@</span=
><br><span> networking_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir=
)/src/openvpn \</span><br><span> 	$(OPTIONAL_CRYPTO_LIBS)</span><br><span> =
networking_testdriver_SOURCES =3D test_networking=2Ec mock_msg=2Ec \</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+	test_route=2Ec test_route=
=2Eh test_common=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+	mock_management=2Ec \</span><br><span> 	$(top_srcdir)/src/compat/compat=
-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/networking_sitnl=
=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir=
)/src/openvpn/route=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+	$(top_srcdir)/src/openvpn/env_set=2Ec \</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/run_command=2Ec \</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/open=
vpn/socket_util=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2E=
c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto=2Ec \</span><br><spa=
n> 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \</span><br><span>diff --git=
 a/tests/unit_tests/openvpn/test_networking=2Ec b/tests/unit_tests/openvpn/=
test_networking=2Ec</span><br><span>index 1c9cac1=2E=2E849f247 100644</span=
><br><span>--- a/tests/unit_tests/openvpn/test_networking=2Ec</span><br><sp=
an>+++ b/tests/unit_tests/openvpn/test_networking=2Ec</span><br><span>@@ -2=
,6 +2,8 @@</span><br><span> #include &quot;syshead=2Eh&quot;</span><br><spa=
n> #include &quot;networking=2Eh&quot;</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_route=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #inc=
lude &lt;setjmp=2Eh&gt;</span><br><span> #include &lt;cmocka=2Eh&gt;</span>=
<br><span> </span><br><span>@@ -212,7 +214,7 @@</span><br><span> static voi=
d</span><br><span> usage(char *name)</span><br><span> {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    printf(&quot;Usage: %s &lt;0-8&gt;\n&=
quot;, name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pr=
intf(&quot;Usage: %s &lt;0-9&gt;\n&quot;, name);</span><br><span> }</span><=
br><span> </span><br><span> int</span><br><span>@@ -272,6 +274,9 @@</span><=
br><span>             assert_int_equal(net__iface_type(&quot;dummy0815&quot=
;, NULL), -ENODEV);</span><br><span>             return 0;</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case 9:</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            return rou=
te_tests();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span>         default:</span><br><span>             printf(&quot;invali=
d test: %d\n&quot;, test);</span><br><span>             break;</span><br><s=
pan>diff --git a/tests/unit_tests/openvpn/test_route=2Ec b/tests/unit_tests=
/openvpn/test_route=2Ec</span><br><span>new file mode 100644</span><br><spa=
n>index 0000000=2E=2E3cfee9b</span><br><span>--- /dev/null</span><br><span>=
+++ b/tests/unit_tests/openvpn/test_route=2Ec</span><br><span>@@ -0,0 +1,18=
1 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to=
 securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *             over a single UDP port, with support for SSL/TLS-ba=
sed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             s=
ession authentication and key exchange,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *             packet encryption, packet authentication=
, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
 packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright =
(C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  This program is free software; you can redistribute it=
 and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  i=
t under the terms of the GNU General Public License version 2</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Soft=
ware Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program i=
s distributed in the hope that it will be useful,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even th=
e implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public Li=
cense for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You sho=
uld have received a copy of the GNU General Public License along</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not,=
 see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifde=
f HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_common=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;route=2Eh&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ne=
tworking=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_=
route=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Stubs for functions =
route=2Ec references but that no test here reaches=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * They assert rather than return quietly=
, so a test straying onto one</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * fails loudly instead of silently doing nothing=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+struct argv</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+argv_new(void)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_true(0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct argv a =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    return a;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+argv_free(struct argv *a)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_true(0);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+get_ipv6_addr(const char *prefix_str, str=
uct in6_addr *network, unsigned int *netbits,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+              msglvl_t msglevel)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_true(0);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in_addr_t</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+getaddr(unsigned int flags, =
const char *hostname, int resolve_retry, bool *succeeded,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        struct signal_info *sig_info)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_true(0);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn_getaddrinfo=
(unsigned int flags, const char *hostname, const char *servname,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    int resolv=
e_retry_seconds, struct signal_info *sig_info, int ai_family,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                    struct addrin=
fo **res)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(0);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+struct signal_info siginfo_static; /* GLOBAL */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
ignal_reset(struct signal_info *si, int signum)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_true(0);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_is_special_addr(void **state)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_true(is_special_addr(&quot;net_ga=
teway&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_true(is_special_addr(&quot;vpn_gateway&quot;));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(is_special_addr(&quot;rem=
ote_host&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(is_s=
pecial_addr(&quot;10=2E0=2E0=2E1&quot;));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_false(is_special_addr(&quot;default&quot;)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(=
is_special_addr(NULL));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_netmask_to_netbits(void **state)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int netbits;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(netmask_to_netbits(0x0a000000, 0xff000000, &amp=
;netbits)); /* 10/8 */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_int_equal(netbits, 8);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(netmask_to_netbits(0xc0a80100, 0xffffff00, &amp;netbits)); /*=
 192=2E168=2E1/24 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_equal(netbits, 24);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_true(netmask_to_netbits(0x00000000, 0x00000000, &amp;netbits)); /* =
default route */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(netbits, 0);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a=
 full-length mask reports -1 rather than 32 */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_true(netmask_to_netbits(0x0a010203, 0=
xffffffff, &amp;netbits));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(netbits, -1);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* host bits set in the network part */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_false(netmask_to_netbits(0x0a000001, =
0xff000000, &amp;netbits));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* not =
a contiguous netmask */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_false(netmask_to_netbits(0x0a000000, 0xff00ff00, &amp;netbit=
s));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+test_netmask_to_netbits2(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(netmask_to_netbits2(0xff000000), 8);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(=
netmask_to_netbits2(0xffffff00), 24);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(netmask_to_netbits2(0x00000000), 0);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* unlike netmask_to_netbits(), th=
is one reports a full-length mask as 32 */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_int_equal(netmask_to_netbits2(0xffffffff)=
, 32);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(netmask_to_=
netbits2(0xff00ff00), -1);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+assert_clear_host_bits(const char *add=
r, unsigned int netbits, const char *expected)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct route_ipv6 r6;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct in6_addr want;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    CLEAR(r6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(inet_pton(AF_INET6, addr, &amp;r6=2Enetwork), 1);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(inet_p=
ton(AF_INET6, expected, &amp;want), 1);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    r6=2Enetbits =3D netbits;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    route_ipv6_clear_host_bits(&amp;r6);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(&amp;r6=2Enetwork=
, &amp;want, sizeof(struct in6_addr));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+test_route_ipv6_clear_host=
_bits(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* whole bytes=
 cleared */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_clear_host_bits(&quot;2001:db8::1&quot;, 64, &quot;2001:db8::&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_clear_host_=
bits(&quot;2001:db8:dead:beef::1&quot;, 32, &quot;2001:db8::&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* a prefix that does not fall on a byte =
boundary */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_clear_host_bits(&quot;2001:db8:0:00ff::1&quot;, 60, &quot;2001:db8:0:00f=
0::&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_clear_host_bits(&quot;2001:db8::ffff&quot;, 121, &quot;2001:db8::ff80&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* nothing to clear, and ever=
ything to clear */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_clear_host_bits(&quot;2001:db8::1&quot;, 128, &quot;2001:db8::1&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_cl=
ear_host_bits(&quot;2001:db8::1&quot;, 0, &quot;::&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static const struct CMUnitTest route_test_list[] =3D {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_is_special_a=
ddr),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_uni=
t_test(test_netmask_to_netbits),</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    cmocka_unit_test(test_netmask_to_netbits2),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_route_ip=
v6_clear_host_bits),</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+route_tests(void)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    openvpn_unit_test_setup();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return cmocka_run_group_tests(route_test_list, NULL, NUL=
L);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n>diff --git a/tests/unit_tests/openvpn/test_route=2Eh b/tests/unit_tests/o=
penvpn/test_route=2Eh</span><br><span>new file mode 100644</span><br><span>=
index 0000000=2E=2Ecaa5c3c</span><br><span>--- /dev/null</span><br><span>++=
+ b/tests/unit_tests/openvpn/test_route=2Eh</span><br><span>@@ -0,0 +1,27 @=
@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to se=
curely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *             over a single UDP port, with support for SSL/TLS-based=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             sess=
ion authentication and key exchange,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *             packet encryption, packet authentication, a=
nd</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pa=
cket compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C)=
 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  This program is free software; you can redistribute it an=
d/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it u=
nder the terms of the GNU General Public License version 2</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Softwar=
e Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is d=
istributed in the hope that it will be useful,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the i=
mplied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public Licen=
se for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should=
 have received a copy of the GNU General Public License along</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, se=
e &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#ifndef TEST_ROUTE_H</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define TEST_ROUTE_H</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/** Runs the route=2Ec unit tests, returns the number of failu=
res */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+route_tests(void);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br></pre><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=
=3Demail">change 1946</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1946?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 1946 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-=
Owner: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ch=
ugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html=
>
--tmG4i94aKkw=--


--===============2157026038028543426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2157026038028543426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2157026038028543426==--

