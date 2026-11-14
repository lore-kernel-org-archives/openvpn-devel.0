Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72860606A331
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 17:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HGyI625u;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=cig61MJU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lmMdZdUT;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XaHMy741
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=LfmwHl9kd2jrzC6GQdQ142z8qNWbcUzrBi6k+O29yl0=; b=HGyI625uVNm118r02OV6eyA5x+
	0g7/O5JWahLIp4G+uuQfI/PzqzBiacl03YToliBg6gpw+dHEBFrpVLY27r9ow1njLTOqfBGCfXD4g
	qWOukLkRZ+sXLBtZv+srNEC+iicUanPC7aZDYzOCmy9pyol9dO8ZuK2veaX/Kdn/Xe8s=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSHmF-000000005cX-0iWa;
	Sat, 14 Nov 2026 17:42:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSHmE-000000005cQ-1fuc
 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 17:42:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MvCIPTXUAhT+60TJU9DVfw/4sqgee35LlJ5HU3f+7jw=; b=cig61MJUSrEBLtsYLx/YyFQMVg
 Un1XeMBDCJnX+83pshUjwZDrs7LfUVtkyfhXKX1SZGxGX2JeHtoPxR/10u19s2ACu3tW1I2/PJenl
 DYmzWnKuFjM1pT2cK0cCFOnh6KwQ8XF22O4s7Shnv+46ueOe61L3NfzupJOrsqU38jkA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MvCIPTXUAhT+60TJU9DVfw/4sqgee35LlJ5HU3f+7jw=; b=lmMdZdUTYVL+1cwmgYpbhV0UVX
 zATAyoMh6nsaLFXfn1P5hUnmD8bYLU/1JIlfi0fWjFzZTn+FlHhEQTKeMb896kSKeHro2EzPk/h9b
 IbTC+PE+STtscAvsxa/08w0q6kDln8w91KHy600b+3R8aqiwYvaaVc7+liFlbAZgfD+w=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSHmB-000000002qT-3NF8 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 17:42:58 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-49318428d98so810654f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 09:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794678169; x=1795282969; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MvCIPTXUAhT+60TJU9DVfw/4sqgee35LlJ5HU3f+7jw=;
 b=XaHMy741q0bBZgFtMcpW0qvgmTgPJh98ufR6mID4LHLn4NdvLARUb7OU8ayzrlIuIv
 5eU1mid8Tgo3EYX8dD/BzgtmgGiOjtctLyqBAz8Yb998XyPaY3yZ7HxFhtE4XmCJoOEH
 BPj4UTXmudH9+ZFEJ1fy9LA8iaET0yptqiK7cSw1XiiFYn+Qewi1DNSZfDETSljsJpIs
 qCvaubiPCdcLilP7cyzfC7TAn/AGM2+nlr6baYeLoGxvLnViJKHdoHVHqX2WModgO85X
 L0ReyCkhXD8lkjsdJ+v0/a5HWSit+h7fhLm2/ZFwoI4rtEADPV2+v0amh7uZhPDHTkmf
 pLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794678169; x=1795282969;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MvCIPTXUAhT+60TJU9DVfw/4sqgee35LlJ5HU3f+7jw=;
 b=nTvnrnB4h4IHFhsyhua6p8zX+uXkbhYXbDhwIycy63e1L7wjR+3hipKD/D+Tdp9JSi
 uJ63x6F3/cmldnGNJqwWbvgftw3n7EQ1IbPXcVrpR+lzQ79y7280nNqWQleUtJynqKOG
 d7YUk6WcpwB2Rh8Rjkb0UA2CqLW9lUhwoUS8K8offXzximkq9Um/LZckEzsUNRHxAh8Q
 8VZJVCwNoxxT0BlRACd8DL4aGVp9/g49UmfuFkn3KsABRvcrVL0vCASwRggxY07iJL9w
 tqsH+GTYqvRCF0ik4sWqTXwf3bg2DrFqR/dXpq4JLNidyvqKgdCs2XoCjG5hzro+Z3YV
 NK5Q==
X-Gm-Message-State: APuU4Z8TMHGm6/7MJUcbIDtO+l7f7GLzFK56mi+6PhaO3CXXMCESGvmM
 4T2YBbfioWGyvhkNM8XpxNJGLRT20AzzPYKKi/wSUCXxDltCqXiggDRQ6cRWC3EsguUz2z10nG5
 pEuGb6RjUKv+Jhbl/MRtW9da0va+OrIlEm1j5YPQ2G01JgNXDGA8wTvIGAlGZ8+0pm/bL
X-Gm-Gg: AYBFou02N3xTxRCrKgYA3uKLMt7KF6vCEICipNkJ+aAK8HWcfN24iL6W0774ikVssli
 67Hb/fwb++ujXGpHcLKWIycCfzFVlYt4VK0GJV4keyZAtRag5T79FjkoaoKvbf1h1dWKqqTpjOu
 g1kuUW9s5bglOjYoiyizubHMfvatUuy8X2X8bN6W/swrhAyBOspobzZIKJpK7V5q4RX5NUxsVD/
 hXoRfGgAynzCFEab3J9FGtQBZWHiH72o3I+Ogbmq0eOvMUg5KKIKflZF4WvJZBSHDz1eGy7GMht
 9i+Kdu2/NmGGq6I6NUZhcX+CZVoeyfiBy4XP5inuT0YW5Ieh6wdwUrj91crJCp8/eRiEKhzw2Ig
 h3GYl7aWHhjBQ8S4ziAXeKXrqbG1ANyU9MzrZ3SA6UU7giWsXOYn6vtq64rWvHjnPhvKjFfPHcu
 7hlpEwR13I8EqDs3tfgYLZuzyc6y8Lfmm43XOhnR6ILAme20mUVl4126yHlO9WER8wXA803dfih
 itr0vn8gakkyzOxkJG7G+k7Xpc9UOzg2RKtyvayAmsFXOR21uQiBiin9sJUtGmnIspYUurVVGqn
 yn3ZKcsVFnMd78JirUWWrfyGw4rM9hWAq7i5pAWBLo11E4hDPRgbtWVxvzE2IEH8lFepQmHP+fk
 cafzzGQt0s0al1YAXFCGwKwrhzZgdJbgX0mph22TDyKRldLZTYa7y5xz3sE4KAgAXiqi+IVjEot
 rHg/V3d+DFXq9N79s=
X-Received: by 2002:a5d:5f91:0:b0:496:42eb:e0fd with SMTP id
 ffacd0b85a97d-49c71b5c72emr13607407f8f.31.1794678168894; 
 Sat, 14 Nov 2026 09:42:48 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f7828a4sm12167530f8f.23.2026.11.14.09.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 09:42:48 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 14 Nov 2026 17:42:47 +0000
To: chugly <charlie.vigue@openvpn.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde
X-Gerrit-Change-Number: 1946
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1946?usp=email>
X-Gerrit-Commit: 241c5eb8afa06ee6c7dc05fe3c6b7df7b2379258
In-Reply-To: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
References: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMjEyMjE1MDAwLkk5MDg1YzU1YTdlZmVmZDMxODM5YjAwZWM4ZWM5YTZmMDg1NTc0ZGRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7260cda9233a9112c47fe43cfb8f3504105e6160-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSHmB-000000002qT-3NF8
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 charlie.vigue@openvpn.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3136169361017688857=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3136169361017688857==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vnNde4uj6E0="; charset=UTF-8

--vnNde4uj6E0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#7) to the change originally cre=
ated by chugly=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3De=
mail )

The following approvals got outdated and were removed:
Code-Review+=
2 by R=C4=83zvan Cojocaru


Change subject: tests: add unit tests for route=
=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

tests: =
add unit tests for route=2Ec

route=2Ec has no unit test coverage at all, s=
o there is nowhere to put a
test when touching it=2E  Cover the pure helper=
s it already exports: the
special address predicate, both netmask-to-netbit=
s conversions, and the
IPv6 prefix host-bit masking=2E

The two conversions=
 disagree on a full-length netmask:
netmask_to_netbits() reports -1 and net=
mask_to_netbits2() reports 32=2E
--server relies on the -1 to reject a /32,=
 so pin it down=2E

Rather than add a driver of its own, the tests are host=
ed by
networking_testdriver as case 9, alongside its existing cases=2E  Tha=
t
driver is already gated on HAVE_SITNL, which is what route=2Ec needs: it
=
reaches the routing table through net_route_* on Linux and through
argv/exe=
cve elsewhere, so one set of stubs cannot link on both=2E
t_net=2Esh runs t=
he cases above LAST_AUTO_TEST after it has removed its
dummy interface, so =
the route tests need no interface and no particular
network state=2E

route=
=2Ec links against the real networking_sitnl=2Ec that the driver
already ca=
rries=2E  Only the socket and argv helpers that route=2Ec
references but no=
 test here reaches are stubbed, and those assert rather
than return quietly=
, so a test straying onto one fails loudly=2E

Change-Id: I9085c55a7efefd31=
839b00ec8ec9a6f085574dde
Signed-off-by: Charlie Vigue <charlie=2Evigue@open=
vpn=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946
Message-Id: <20261103113600=
=2E30488-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg40621=2Ehtml
Signed-off-by: Gert =
Doering <gert@greenie=2Emuc=2Ede>
---
M CMakeLists=2Etxt
M tests/t_net=2Esh=

M tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/test_n=
etworking=2Ec
A tests/unit_tests/openvpn/test_route=2Ec
A tests/unit_tests/=
openvpn/test_route=2Eh
6 files changed, 228 insertions(+), 2 deletions(-)

=

  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/46/1946=
/7

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index a90eb1a=2E=2E4f4=
8990 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -973,7 +973,14=
 @@
     if (TARGET test_networking)
         target_link_options(test_netw=
orking PRIVATE -Wl,--wrap=3Dparse_line)
         target_compile_options(tes=
t_networking PRIVATE -UNDEBUG)
+        target_link_libraries(test_networki=
ng PUBLIC ${RESOLV_LIBRARIES})
         target_sources(test_networking PRIV=
ATE
+            tests/unit_tests/openvpn/test_route=2Ec
+            tests=
/unit_tests/openvpn/mock_management=2Ec
+            src/openvpn/route=2Ec
=
+            src/openvpn/env_set=2Ec
+            src/openvpn/run_command=
=2Ec
+            src/openvpn/socket_util=2Ec
             src/openvpn/netw=
orking_sitnl=2Ec
             src/openvpn/crypto_epoch=2Ec
             src=
/openvpn/crypto_mbedtls=2Ec
diff --git a/tests/t_net=2Esh b/tests/t_net=2Es=
h
index d63f648=2E=2Efd07277 100755
--- a/tests/t_net=2Esh
+++ b/tests/t_ne=
t=2Esh
@@ -3,7 +3,7 @@
 IFACE=3D"ovpn-dummy0"
 UNIT_TEST=3D"=2E/unit_tests/=
openvpn/networking_testdriver"
 LAST_AUTO_TEST=3D7
-LAST_TEST=3D8
+LAST_TES=
T=3D9
 
 srcdir=3D"${srcdir:-=2E}"
 top_builddir=3D"${top_builddir:-=2E=2E}=
"
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/op=
envpn/Makefile=2Eam
index 70cf7b2=2E=2E6091264 100644
--- a/tests/unit_test=
s/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -21=
9,8 +219,14 @@
 networking_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_sr=
cdir)/src/openvpn \
 	$(OPTIONAL_CRYPTO_LIBS)
 networking_testdriver_SOURCE=
S =3D test_networking=2Ec mock_msg=2Ec \
+	test_route=2Ec test_route=2Eh te=
st_common=2Eh \
+	mock_management=2Ec \
 	$(top_srcdir)/src/compat/compat-s=
trlcpy=2Ec \
 	$(top_srcdir)/src/openvpn/networking_sitnl=2Ec \
+	$(top_src=
dir)/src/openvpn/route=2Ec \
+	$(top_srcdir)/src/openvpn/env_set=2Ec \
+	$(=
top_srcdir)/src/openvpn/run_command=2Ec \
+	$(top_srcdir)/src/openvpn/socke=
t_util=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/src/o=
penvpn/crypto=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \
diff --g=
it a/tests/unit_tests/openvpn/test_networking=2Ec b/tests/unit_tests/openvp=
n/test_networking=2Ec
index 3699a2a1=2E=2Eb580d32 100644
--- a/tests/unit_t=
ests/openvpn/test_networking=2Ec
+++ b/tests/unit_tests/openvpn/test_networ=
king=2Ec
@@ -2,6 +2,8 @@
 #include "syshead=2Eh"
 #include "networking=2Eh"=

 
+#include "test_route=2Eh"
+
 #include <setjmp=2Eh>
 #include <cmocka=2E=
h>
 
@@ -212,7 +214,7 @@
 static void
 usage(char *name)
 {
-    printf("Us=
age: %s <0-8>\n", name);
+    printf("Usage: %s <0-9>\n", name);
 }
 
 int
=
@@ -272,6 +274,9 @@
             assert_int_equal(net__iface_type("dummy081=
5", NULL), -ENODEV);
             return 0;
 
+        case 9:
+           =
 return route_tests();
+
         default:
             printf("invalid tes=
t: %d\n", test);
             break;
diff --git a/tests/unit_tests/openvpn/=
test_route=2Ec b/tests/unit_tests/openvpn/test_route=2Ec
new file mode 1006=
44
index 0000000=2E=2E3cfee9b
--- /dev/null
+++ b/tests/unit_tests/openvpn/=
test_route=2Ec
@@ -0,0 +1,181 @@
+/*
+ *  OpenVPN -- An application to secu=
rely tunnel IP networks
+ *             over a single UDP port, with suppor=
t for SSL/TLS-based
+ *             session authentication and key exchange=
,
+ *             packet encryption, packet authentication, and
+ *        =
     packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sa=
les@openvpn=2Enet>
+ *
+ *  This program is free software; you can redistri=
bute it and/or modify
+ *  it under the terms of the GNU General Public Lic=
ense version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *=
  This program is distributed in the hope that it will be useful,
+ *  but =
WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABI=
LITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Publi=
c License for more details=2E
+ *
+ *  You should have received a copy of t=
he GNU General Public License along
+ *  with this program; if not, see <ht=
tps://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include =
"config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include "test_common=2Eh=
"
+
+#include "route=2Eh"
+#include "networking=2Eh"
+
+#include "test_rout=
e=2Eh"
+
+/* Stubs for functions route=2Ec references but that no test here=
 reaches=2E
+ * They assert rather than return quietly, so a test straying =
onto one
+ * fails loudly instead of silently doing nothing=2E
+ */
+struct=
 argv
+argv_new(void)
+{
+    assert_true(0);
+    struct argv a =3D { 0 };=

+    return a;
+}
+
+void
+argv_free(struct argv *a)
+{
+    assert_true(0=
);
+}
+
+bool
+get_ipv6_addr(const char *prefix_str, struct in6_addr *netwo=
rk, unsigned int *netbits,
+              msglvl_t msglevel)
+{
+    assert=
_true(0);
+    return false;
+}
+
+in_addr_t
+getaddr(unsigned int flags, c=
onst char *hostname, int resolve_retry, bool *succeeded,
+        struct si=
gnal_info *sig_info)
+{
+    assert_true(0);
+    return 0;
+}
+
+int
+open=
vpn_getaddrinfo(unsigned int flags, const char *hostname, const char *servn=
ame,
+                    int resolve_retry_seconds, struct signal_info *si=
g_info, int ai_family,
+                    struct addrinfo **res)
+{
+    =
assert_true(0);
+    return 0;
+}
+
+struct signal_info siginfo_static; /* =
GLOBAL */
+
+int
+signal_reset(struct signal_info *si, int signum)
+{
+    =
assert_true(0);
+    return 0;
+}
+
+static void
+test_is_special_addr(void=
 **state)
+{
+    assert_true(is_special_addr("net_gateway"));
+    assert_=
true(is_special_addr("vpn_gateway"));
+    assert_true(is_special_addr("rem=
ote_host"));
+
+    assert_false(is_special_addr("10=2E0=2E0=2E1"));
+    a=
ssert_false(is_special_addr("default"));
+    assert_false(is_special_addr(=
NULL));
+}
+
+static void
+test_netmask_to_netbits(void **state)
+{
+    in=
t netbits;
+
+    assert_true(netmask_to_netbits(0x0a000000, 0xff000000, &n=
etbits)); /* 10/8 */
+    assert_int_equal(netbits, 8);
+
+    assert_true(=
netmask_to_netbits(0xc0a80100, 0xffffff00, &netbits)); /* 192=2E168=2E1/24 =
*/
+    assert_int_equal(netbits, 24);
+
+    assert_true(netmask_to_netbit=
s(0x00000000, 0x00000000, &netbits)); /* default route */
+    assert_int_e=
qual(netbits, 0);
+
+    /* a full-length mask reports -1 rather than 32 */=

+    assert_true(netmask_to_netbits(0x0a010203, 0xffffffff, &netbits));
+ =
   assert_int_equal(netbits, -1);
+
+    /* host bits set in the network pa=
rt */
+    assert_false(netmask_to_netbits(0x0a000001, 0xff000000, &netbits=
));
+
+    /* not a contiguous netmask */
+    assert_false(netmask_to_netb=
its(0x0a000000, 0xff00ff00, &netbits));
+}
+
+static void
+test_netmask_to_=
netbits2(void **state)
+{
+    assert_int_equal(netmask_to_netbits2(0xff000=
000), 8);
+    assert_int_equal(netmask_to_netbits2(0xffffff00), 24);
+    =
assert_int_equal(netmask_to_netbits2(0x00000000), 0);
+
+    /* unlike netm=
ask_to_netbits(), this one reports a full-length mask as 32 */
+    assert_=
int_equal(netmask_to_netbits2(0xffffffff), 32);
+
+    assert_int_equal(net=
mask_to_netbits2(0xff00ff00), -1);
+}
+
+static void
+assert_clear_host_bit=
s(const char *addr, unsigned int netbits, const char *expected)
+{
+    str=
uct route_ipv6 r6;
+    struct in6_addr want;
+
+    CLEAR(r6);
+    assert=
_int_equal(inet_pton(AF_INET6, addr, &r6=2Enetwork), 1);
+    assert_int_eq=
ual(inet_pton(AF_INET6, expected, &want), 1);
+    r6=2Enetbits =3D netbits=
;
+
+    route_ipv6_clear_host_bits(&r6);
+    assert_memory_equal(&r6=2Ene=
twork, &want, sizeof(struct in6_addr));
+}
+
+static void
+test_route_ipv6_=
clear_host_bits(void **state)
+{
+    /* whole bytes cleared */
+    assert=
_clear_host_bits("2001:db8::1", 64, "2001:db8::");
+    assert_clear_host_b=
its("2001:db8:dead:beef::1", 32, "2001:db8::");
+
+    /* a prefix that doe=
s not fall on a byte boundary */
+    assert_clear_host_bits("2001:db8:0:00=
ff::1", 60, "2001:db8:0:00f0::");
+    assert_clear_host_bits("2001:db8::ff=
ff", 121, "2001:db8::ff80");
+
+    /* nothing to clear, and everything to =
clear */
+    assert_clear_host_bits("2001:db8::1", 128, "2001:db8::1");
+ =
   assert_clear_host_bits("2001:db8::1", 0, "::");
+}
+
+static const struc=
t CMUnitTest route_test_list[] =3D {
+    cmocka_unit_test(test_is_special_=
addr),
+    cmocka_unit_test(test_netmask_to_netbits),
+    cmocka_unit_tes=
t(test_netmask_to_netbits2),
+    cmocka_unit_test(test_route_ipv6_clear_ho=
st_bits),
+};
+
+int
+route_tests(void)
+{
+    openvpn_unit_test_setup();
=
+    return cmocka_run_group_tests(route_test_list, NULL, NULL);
+}
diff --=
git a/tests/unit_tests/openvpn/test_route=2Eh b/tests/unit_tests/openvpn/te=
st_route=2Eh
new file mode 100644
index 0000000=2E=2Ecaa5c3c
--- /dev/null
=
+++ b/tests/unit_tests/openvpn/test_route=2Eh
@@ -0,0 +1,27 @@
+/*
+ *  Ope=
nVPN -- An application to securely tunnel IP networks
+ *             over =
a single UDP port, with support for SSL/TLS-based
+ *             session a=
uthentication and key exchange,
+ *             packet encryption, packet a=
uthentication, and
+ *             packet compression=2E
+ *
+ *  Copyright=
 (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is f=
ree software; you can redistribute it and/or modify
+ *  it under the terms=
 of the GNU General Public License version 2
+ *  as published by the Free =
Software Foundation=2E
+ *
+ *  This program is distributed in the hope tha=
t it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implie=
d warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  =
See the
+ *  GNU General Public License for more details=2E
+ *
+ *  You sh=
ould have received a copy of the GNU General Public License along
+ *  with=
 this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+#if=
ndef TEST_ROUTE_H
+#define TEST_ROUTE_H
+/** Runs the route=2Ec unit tests,=
 returns the number of failures */
+int
+route_tests(void);
+#endif

-- 
To=
 view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9085c55a7efefd31839b0=
0ec8ec9a6f085574dde
Gerrit-Change-Number: 1946
Gerrit-PatchSet: 7
Gerrit-Ow=
ner: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--vnNde4uj6E0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #7</strong> to the change originally created by chug=
ly=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=
=3Demail">View Change</a></p><p>The following approvals got outdated and we=
re removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">tests: a=
dd unit tests for route=2Ec<br><br>route=2Ec has no unit test coverage at a=
ll, so there is nowhere to put a<br>test when touching it=2E  Cover the pur=
e helpers it already exports: the<br>special address predicate, both netmas=
k-to-netbits conversions, and the<br>IPv6 prefix host-bit masking=2E<br><br=
>The two conversions disagree on a full-length netmask:<br>netmask_to_netbi=
ts() reports -1 and netmask_to_netbits2() reports 32=2E<br>--server relies =
on the -1 to reject a /32, so pin it down=2E<br><br>Rather than add a drive=
r of its own, the tests are hosted by<br>networking_testdriver as case 9, a=
longside its existing cases=2E  That<br>driver is already gated on HAVE_SIT=
NL, which is what route=2Ec needs: it<br>reaches the routing table through =
net_route_* on Linux and through<br>argv/execve elsewhere, so one set of st=
ubs cannot link on both=2E<br>t_net=2Esh runs the cases above LAST_AUTO_TES=
T after it has removed its<br>dummy interface, so the route tests need no i=
nterface and no particular<br>network state=2E<br><br>route=2Ec links again=
st the real networking_sitnl=2Ec that the driver<br>already carries=2E  Onl=
y the socket and argv helpers that route=2Ec<br>references but no test here=
 reaches are stubbed, and those assert rather<br>than return quietly, so a =
test straying onto one fails loudly=2E<br><br>Change-Id: I9085c55a7efefd318=
39b00ec8ec9a6f085574dde<br>Signed-off-by: Charlie Vigue &lt;charlie=2Evigue=
@openvpn=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946<br>Messag=
e-Id: &lt;20261103113600=2E30488-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: http=
s://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg406=
21=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br=
>---<br>M CMakeLists=2Etxt<br>M tests/t_net=2Esh<br>M tests/unit_tests/open=
vpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/test_networking=2Ec<br>A te=
sts/unit_tests/openvpn/test_route=2Ec<br>A tests/unit_tests/openvpn/test_ro=
ute=2Eh<br>6 files changed, 228 insertions(+), 2 deletions(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/46/1946/7</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</spa=
n><br><span>index a90eb1a=2E=2E4f48990 100644</span><br><span>--- a/CMakeLi=
sts=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -973,7 =
+973,14 @@</span><br><span>     if (TARGET test_networking)</span><br><span=
>         target_link_options(test_networking PRIVATE -Wl,--wrap=3Dparse_li=
ne)</span><br><span>         target_compile_options(test_networking PRIVATE=
 -UNDEBUG)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        t=
arget_link_libraries(test_networking PUBLIC ${RESOLV_LIBRARIES})</span><br>=
<span>         target_sources(test_networking PRIVATE</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            tests/unit_tests/openvpn/test=
_route=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   tests/unit_tests/openvpn/mock_management=2Ec</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            src/openvpn/route=2Ec</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/env_set=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            src=
/openvpn/run_command=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            src/openvpn/socket_util=2Ec</span><br><span>             s=
rc/openvpn/networking_sitnl=2Ec</span><br><span>             src/openvpn/cr=
ypto_epoch=2Ec</span><br><span>             src/openvpn/crypto_mbedtls=2Ec<=
/span><br><span>diff --git a/tests/t_net=2Esh b/tests/t_net=2Esh</span><br>=
<span>index d63f648=2E=2Efd07277 100755</span><br><span>--- a/tests/t_net=
=2Esh</span><br><span>+++ b/tests/t_net=2Esh</span><br><span>@@ -3,7 +3,7 @=
@</span><br><span> IFACE=3D&quot;ovpn-dummy0&quot;</span><br><span> UNIT_TE=
ST=3D&quot;=2E/unit_tests/openvpn/networking_testdriver&quot;</span><br><sp=
an> LAST_AUTO_TEST=3D7</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-LAST_TEST=3D8</span><br><span style=3D"color: hsl(120, 100%, 40%);">+LAST_=
TEST=3D9</span><br><span> </span><br><span> srcdir=3D&quot;${srcdir:-=2E}&q=
uot;</span><br><span> top_builddir=3D&quot;${top_builddir:-=2E=2E}&quot;</s=
pan><br><span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/u=
nit_tests/openvpn/Makefile=2Eam</span><br><span>index 70cf7b2=2E=2E6091264 =
100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><=
br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -2=
19,8 +219,14 @@</span><br><span> networking_testdriver_LDFLAGS =3D @TEST_LD=
FLAGS@ -L$(top_srcdir)/src/openvpn \</span><br><span> 	$(OPTIONAL_CRYPTO_LI=
BS)</span><br><span> networking_testdriver_SOURCES =3D test_networking=2Ec =
mock_msg=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	test=
_route=2Ec test_route=2Eh test_common=2Eh \</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+	mock_management=2Ec \</span><br><span> 	$(top_srcd=
ir)/src/compat/compat-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/src/ope=
nvpn/networking_sitnl=2Ec \</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+	$(top_srcdir)/src/openvpn/route=2Ec \</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/env_set=2Ec \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/=
run_command=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$=
(top_srcdir)/src/openvpn/socket_util=2Ec \</span><br><span> 	$(top_srcdir)/=
src/openvpn/buffer=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto=
=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \</span=
><br><span>diff --git a/tests/unit_tests/openvpn/test_networking=2Ec b/test=
s/unit_tests/openvpn/test_networking=2Ec</span><br><span>index 3699a2a1=2E=
=2Eb580d32 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_netwo=
rking=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_networking=2E=
c</span><br><span>@@ -2,6 +2,8 @@</span><br><span> #include &quot;syshead=
=2Eh&quot;</span><br><span> #include &quot;networking=2Eh&quot;</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quo=
t;test_route=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> #include &lt;setjmp=2Eh&gt;</span><br><span> #include =
&lt;cmocka=2Eh&gt;</span><br><span> </span><br><span>@@ -212,7 +214,7 @@</s=
pan><br><span> static void</span><br><span> usage(char *name)</span><br><sp=
an> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    printf(&quot=
;Usage: %s &lt;0-8&gt;\n&quot;, name);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    printf(&quot;Usage: %s &lt;0-9&gt;\n&quot;, name);</=
span><br><span> }</span><br><span> </span><br><span> int</span><br><span>@@=
 -272,6 +274,9 @@</span><br><span>             assert_int_equal(net__iface_=
type(&quot;dummy0815&quot;, NULL), -ENODEV);</span><br><span>             r=
eturn 0;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        case 9:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            return route_tests();</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span>         default:</span><br><span>       =
      printf(&quot;invalid test: %d\n&quot;, test);</span><br><span>       =
      break;</span><br><span>diff --git a/tests/unit_tests/openvpn/test_rou=
te=2Ec b/tests/unit_tests/openvpn/test_route=2Ec</span><br><span>new file m=
ode 100644</span><br><span>index 0000000=2E=2E3cfee9b</span><br><span>--- /=
dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_route=2Ec</spa=
n><br><span>@@ -0,0 +1,181 @@</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Ope=
nVPN -- An application to securely tunnel IP networks</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             over a single UDP port, wi=
th support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *             session authentication and key exchange,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encrypti=
on, packet authentication, and</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *             packet compression=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software=
; you can redistribute it and/or modify</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  it under the terms of the GNU General Public Licens=
e version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as p=
ublished by the Free Software Foundation=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  This program is distributed in the hope that it will be useful,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY =
WARRANTY; without even the implied warranty of</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR =
PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  GNU General Public License for more details=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  You should have received a copy of the GNU General Public=
 License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  w=
ith this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;test_common=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;route=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;networking=2Eh&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;test_route=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* Stubs for functions route=2Ec references but that no test here reaches=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * They assert rath=
er than return quietly, so a test straying onto one</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * fails loudly instead of silently doing=
 nothing=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+struct argv</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+argv_new(void)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_true(0);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct argv a =3D { 0 };</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return a;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+argv_free(struct argv *a)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+boo=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_ipv6_addr(cons=
t char *prefix_str, struct in6_addr *network, unsigned int *netbits,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+              msglvl_t msg=
level)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(0);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+in_addr_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+getad=
dr(unsigned int flags, const char *hostname, int resolve_retry, bool *succe=
eded,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct=
 signal_info *sig_info)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tru=
e(0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+openvpn_getaddrinfo(unsigned int flags, const char *hostname, const char =
*servname,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           int resolve_retry_seconds, struct signal_info *sig_info, int ai_=
family,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        struct addrinfo **res)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+struct signal_info siginfo_static; /* GLOBAL */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+signal_reset(struct signal_info *si, int signum)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_true(0);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+test_is_special_addr(v=
oid **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(is_specia=
l_addr(&quot;net_gateway&quot;));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_true(is_special_addr(&quot;vpn_gateway&quot;));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(is_spe=
cial_addr(&quot;remote_host&quot;));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_false(is_special_addr(&quot;10=2E0=2E0=2E1&quot;));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_false(is_special_addr(&=
quot;default&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_false(is_special_addr(NULL));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+test_netmask_to_netbit=
s(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int netbits;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_true(netmask_to_netbits(0x0a00000=
0, 0xff000000, &amp;netbits)); /* 10/8 */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(netbits, 8);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_true(netmask_to_netbits(0xc0a80100, 0xffffff00,=
 &amp;netbits)); /* 192=2E168=2E1/24 */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_int_equal(netbits, 24);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_true(netmask_to_netbits(0x00000000, 0x00000000, =
&amp;netbits)); /* default route */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(netbits, 0);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* a full-length mask reports -1 rather than 32 */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(netmask_to_ne=
tbits(0x0a010203, 0xffffffff, &amp;netbits));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(netbits, -1);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* host bits set in the network part */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(netmask_to_n=
etbits(0x0a000001, 0xff000000, &amp;netbits));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* not a contiguous netmask */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_false(netmask_to_netbits(0x0a000000, 0xff=
00ff00, &amp;netbits));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_netmask_to_netbits2(void **state)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(netmask_to_netbits2=
(0xff000000), 8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_int_equal(netmask_to_netbits2(0xffffff00), 24);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(netmask_to_netbit=
s2(0x00000000), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* unlike netma=
sk_to_netbits(), this one reports a full-length mask as 32 */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(netmask_to_n=
etbits2(0xffffffff), 32);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(netmask_to_netbits2(0xff00ff00), -1);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+assert_clear_host_b=
its(const char *addr, unsigned int netbits, const char *expected)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct route_ipv6 r6;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct in6_addr want;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    CLEAR(r6);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(inet_pton(AF_INET6, addr, &amp;r6=2Ene=
twork), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(inet_pton(AF_INET6, expected, &amp;want), 1);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    r6=2Enetbits =3D netbits;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    route_ipv6_clear_host_bits(&amp;r6);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(=
&amp;r6=2Enetwork, &amp;want, sizeof(struct in6_addr));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_rout=
e_ipv6_clear_host_bits(void **state)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* whole bytes cleared */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_clear_host_bits(&quot;2001:db8::1&quot;, 64, &quot;2001=
:db8::&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_clear_host_bits(&quot;2001:db8:dead:beef::1&quot;, 32, &quot;2001:db8=
::&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* a prefix that does no=
t fall on a byte boundary */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_clear_host_bits(&quot;2001:db8:0:00ff::1&quot;, 60, &qu=
ot;2001:db8:0:00f0::&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_clear_host_bits(&quot;2001:db8::ffff&quot;, 121, &quot;=
2001:db8::ff80&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* nothing t=
o clear, and everything to clear */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_clear_host_bits(&quot;2001:db8::1&quot;, 128, &q=
uot;2001:db8::1&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_clear_host_bits(&quot;2001:db8::1&quot;, 0, &quot;::&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static const struct CMUnitTest route_test_list[] =3D {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(=
test_is_special_addr),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    cmocka_unit_test(test_netmask_to_netbits),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_netmask_to_netbits2=
),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_t=
est(test_route_ipv6_clear_host_bits),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+route_tests(void)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    openvpn_unit_test_setup();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return cmocka_run_group_tests(route_t=
est_list, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span>diff --git a/tests/unit_tests/openvpn/test_route=2Eh b=
/tests/unit_tests/openvpn/test_route=2Eh</span><br><span>new file mode 1006=
44</span><br><span>index 0000000=2E=2Ecaa5c3c</span><br><span>--- /dev/null=
</span><br><span>+++ b/tests/unit_tests/openvpn/test_route=2Eh</span><br><s=
pan>@@ -0,0 +1,27 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- A=
n application to securely tunnel IP networks</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *             over a single UDP port, with suppor=
t for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             session authentication and key exchange,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, packe=
t authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *             packet compression=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you ca=
n redistribute it and/or modify</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  it under the terms of the GNU General Public License versio=
n 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published=
 by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  This program is distributed in the hope that it will be useful,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY=
; without even the implied warranty of</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU=
 General Public License for more details=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  You should have received a copy of the GNU General Public Licens=
e along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with thi=
s program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef TEST_ROUTE_H</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define TEST_ROUTE_H</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/** Runs the route=2Ec unit tests, retu=
rns the number of failures */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+route_=
tests(void);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1946?usp=3Demail">change 1946</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6=
f085574dde </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1946 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"=
display:none"> Gerrit-Owner: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--vnNde4uj6E0=--


--===============3136169361017688857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3136169361017688857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3136169361017688857==--

