Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1AC606A330
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 17:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OPmU63xh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Pc03zsvW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mIaljdmd;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SaKT+th8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6xny4pdos6ONObSo7Vpqfqi3G2+EfJAnaMWxKLAww3g=; b=OPmU63xhhNaXrt7WPJSyYw3DPR
	vZ+Txw/hDkzIYaPcfEBDXvRhMCNqaoHM+gqoJ63jaOoJvoWD7DTfCZSoAhuJSktAYTf2QbhA9uXdd
	Zt0MXAHXKm3V5q7YW5k+VNwAwXIV8DjafZCXAA2j1wRf/XKTPhKiL9x4Lak0jAhuj+pk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSHmG-000000002Va-38z7;
	Sat, 14 Nov 2026 17:43:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSHmG-000000002VU-05Ph
 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 17:43:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ItaY6OrqXAkL5HwgA+kc5pL8s41w07DAZQn1wCSi8e0=; b=Pc03zsvW0mAcWJ5XIYrYtr3xJL
 xO0rpUyVTaGDbx5TA/+VREsUY0YIWvWYj9jUhfWgX+CeZxPdwK69PRO3616+8BM/zhkqFe9OZDkRl
 X8ZRgy0v7q7YHF57Et5qWmYmSDU7KULlOI+yDyTpfnHMF0iBVk9qRQrV85eSRt9bDAfI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ItaY6OrqXAkL5HwgA+kc5pL8s41w07DAZQn1wCSi8e0=; b=mIaljdmdEQ3/kjGKQEuS2A3m8v
 lREIvIsEXvtIAIBRzTrFf8JZ1uFK97XBui3OAOtM5h5yaCPmVZyJzXwdWGaqGfrEm8jfH4UrHo0jS
 LmL0/rU04SEa4AMDtxK5ZyuC9NtCqMmSp2zRk2HFSNKAvPw+LBnF3fbWvHjjeJOReFmw=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSHmC-000000002KU-2pcB for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 17:42:59 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-498f5fa4f70so2460850f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 09:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794678170; x=1795282970; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ItaY6OrqXAkL5HwgA+kc5pL8s41w07DAZQn1wCSi8e0=;
 b=SaKT+th8D8jB85FIyq7hgt5LgXWsr7pqVnbDxu7KV8zYXwtRObuMXxgYJjbBDXUwFL
 RHE1auGLpJdI1EsLW0Ef3zkQ/1mBWUVrl5sK04jaksxARJ4phOJ/kqMVeRNXQ9Va1ALB
 +BfqUizgWVEti9QP76z0kemHgbqtdc5+aNi+rEShbYnl2FJjxb7XktMT/8Lfub11FTRy
 J/XmNRNAhGgbbbEF4ut0k43dDQSGuWmPeFUPu39qItNEldcotxKvgAkKUdUCiQEk+ovl
 y4nS4rzADj9YZ8ZhpQUy5CBQXFw1dOmJ+u6JKZrBjjbvnG4NDyZF7725PoKYTkOUY4m2
 Kjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794678170; x=1795282970;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ItaY6OrqXAkL5HwgA+kc5pL8s41w07DAZQn1wCSi8e0=;
 b=Gm6fT8pMma0xurZI7eDcERNSsIZJdr0PyTH7grMvze/X+Qvg9/4Jb6a/MJxg+qH5ML
 Oby66HvQGCrEsLt3c7hf9dv/Dgjx3m3gu+44qAViThXVPBIhoUzIPAH3Rqqdx6iPAS3G
 b3VKiMu6gCRxsGRi9jDB0okuKjuzR6rfcC7XUYzX+HTEIIHbjG/0sTXO+SzC3zW6Cvr8
 /e8+lhiMFGpVSXiFkbTcAL4TstPDA1twm6Ny7ESg6c97/7ERWoVFn0Hv/RBXyKsvIAg1
 3qYwuAH+ZwBXzZNqKOVSL9RgPCKVBuiFIganETbqnXWLbmiChZ0ch0oSm856YFAwMuvt
 cjvA==
X-Forwarded-Encrypted: i=1;
 AL+hErFbmjUIYXSrOWEV27Ohboh+6L6719CVr1o953IP4nzHUY56pSetO8bJzA9GM58XWps/kXGT/ViYWGAG3B+o@lists.sourceforge.net
X-Gm-Message-State: APuU4Z90vY4PXU7uhNW8HwbVwNcereaJuIqGFLwmbnWThf7AUuzfJ+fW
 xaLmdzwNoiPkYYUlNGYVs4zBOnGTVx5HBpnFySwgfkRTxgzngx7C/PgvcTbWN6ECyWyma8KFLEf
 I5+SGbnKohTcLkNlyGaPQ3zI4Uz+lSOGzgJVkD8AG3wYbxg8FUfn6REH7hFaRbWa8yD5sztwEpe
 LthtEAdw==
X-Gm-Gg: AYBFou37oorl9NGYbXL1Rkz7d909D5H0ROixrSIAi76zi3+x3l+EsvY2MK3ORPv0dB6
 slqpq97XOFPYuLI/4pjJuX7lokLxWcLoTdpi4DUWcSLVKh7XlAzNpO35vKq45ZkqkM/wTlevbDB
 tiP+jKmaH98DeC2/+2JOuiX45FI9cX79nb5b30mRjtYiscfjDNAtVBFxXBFZenssSo5hM04f0eF
 +xMcz/pQVuyzSqxAigtMo5LlFLAve5PqNFhfLyRw3H4pDBwkWYpnmisWPmI6vEuSKDHVQbWrLgm
 /pndoX7hpJ7Y+M4HutxmZQb73HiXRBQV+W0W2SCRjwbYtZbh7X4jib8mN5FL92mf+hopI4cYx31
 CeAuEZAqpzFIu3Gsi/B/ez0mpOKgn6Q2qBVLAyVLAH3nDsI1aUyQujVHjjTPjINrR/ihylVhpDx
 G2o2eSh6Kz6IhzwokybWKok93d4vBjIw8BYAATV54abrwBg2kFCJc8EpcxSjOuw3cqsW07G7T5H
 vQRZQOWpRJa5JkO4wGBaHYmsQ1V9P5MoTzYF6RnLL3QNWBJuUVIJ3NifJWcV60kNLNO/m8nN0Er
 Ivi43lJFaBZOD2BuD8ZS16HlGKlr5NimYcXBH7GPzBY2cXm+zF2Tbnb/HTqY476L42XvNEuc7Z+
 sfTEaBNeUur/7U77FqUCBwIW6F+rOTP7T2hN0NptvMV0z8kcvQLPEYKQ2Pm2i+2SyYN3FmeiKt5
 u8zz0CZXWBWSV4meTID31qe9kZLvC+KBxALZSl
X-Received: by 2002:a05:6000:4b0f:b0:48e:4a8a:e17f with SMTP id
 ffacd0b85a97d-49c6d453dc6mr13515256f8f.4.1794678169835; 
 Sat, 14 Nov 2026 09:42:49 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f782396sm12428517f8f.24.2026.11.14.09.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 09:42:49 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 14 Nov 2026 17:42:49 +0000
To: chugly <charlie.vigue@openvpn.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde
X-Gerrit-Change-Number: 1946
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1946?usp=email>
X-Gerrit-Commit: 241c5eb8afa06ee6c7dc05fe3c6b7df7b2379258
In-Reply-To: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
References: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMjEyMjE1MDAwLkk5MDg1YzU1YTdlZmVmZDMxODM5YjAwZWM4ZWM5YTZmMDg1NTc0ZGRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7260cda9233a9112c47fe43cfb8f3504105e6160-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSHmC-000000002KU-2pcB
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4645755356984158535=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4645755356984158535==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gqFf2sTNsJU="; charset=UTF-8

--gqFf2sTNsJU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1946?usp=3Demail )

Change subject: tests: add unit tests for r=
oute=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

test=
s: add unit tests for route=2Ec

route=2Ec has no unit test coverage at all=
, so there is nowhere to put a
test when touching it=2E  Cover the pure hel=
pers it already exports: the
special address predicate, both netmask-to-net=
bits conversions, and the
IPv6 prefix host-bit masking=2E

The two conversi=
ons disagree on a full-length netmask:
netmask_to_netbits() reports -1 and =
netmask_to_netbits2() reports 32=2E
--server relies on the -1 to reject a /=
32, so pin it down=2E

Rather than add a driver of its own, the tests are h=
osted by
networking_testdriver as case 9, alongside its existing cases=2E  =
That
driver is already gated on HAVE_SITNL, which is what route=2Ec needs: =
it
reaches the routing table through net_route_* on Linux and through
argv/=
execve elsewhere, so one set of stubs cannot link on both=2E
t_net=2Esh run=
s the cases above LAST_AUTO_TEST after it has removed its
dummy interface, =
so the route tests need no interface and no particular
network state=2E

ro=
ute=2Ec links against the real networking_sitnl=2Ec that the driver
already=
 carries=2E  Only the socket and argv helpers that route=2Ec
references but=
 no test here reaches are stubbed, and those assert rather
than return quie=
tly, so a test straying onto one fails loudly=2E

Change-Id: I9085c55a7efef=
d31839b00ec8ec9a6f085574dde
Signed-off-by: Charlie Vigue <charlie=2Evigue@o=
penvpn=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL:=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946
Message-Id: <2026110311360=
0=2E30488-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/=
openvpn-devel@lists=2Esourceforge=2Enet/msg40621=2Ehtml
Signed-off-by: Gert=
 Doering <gert@greenie=2Emuc=2Ede>
---
M CMakeLists=2Etxt
M tests/t_net=2Es=
h
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/test_=
networking=2Ec
A tests/unit_tests/openvpn/test_route=2Ec
A tests/unit_tests=
/openvpn/test_route=2Eh
6 files changed, 228 insertions(+), 2 deletions(-)
=




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

Gerrit-MessageType: merged
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9085c55a7efefd31839b00ec8e=
c9a6f085574dde
Gerrit-Change-Number: 1946
Gerrit-PatchSet: 7
Gerrit-Owner: =
chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--gqFf2sTNsJU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1946?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">tests: add unit tests for route=2E=
c<br><br>route=2Ec has no unit test coverage at all, so there is nowhere to=
 put a<br>test when touching it=2E  Cover the pure helpers it already expor=
ts: the<br>special address predicate, both netmask-to-netbits conversions, =
and the<br>IPv6 prefix host-bit masking=2E<br><br>The two conversions disag=
ree on a full-length netmask:<br>netmask_to_netbits() reports -1 and netmas=
k_to_netbits2() reports 32=2E<br>--server relies on the -1 to reject a /32,=
 so pin it down=2E<br><br>Rather than add a driver of its own, the tests ar=
e hosted by<br>networking_testdriver as case 9, alongside its existing case=
s=2E  That<br>driver is already gated on HAVE_SITNL, which is what route=2E=
c needs: it<br>reaches the routing table through net_route_* on Linux and t=
hrough<br>argv/execve elsewhere, so one set of stubs cannot link on both=2E=
<br>t_net=2Esh runs the cases above LAST_AUTO_TEST after it has removed its=
<br>dummy interface, so the route tests need no interface and no particular=
<br>network state=2E<br><br>route=2Ec links against the real networking_sit=
nl=2Ec that the driver<br>already carries=2E  Only the socket and argv help=
ers that route=2Ec<br>references but no test here reaches are stubbed, and =
those assert rather<br>than return quietly, so a test straying onto one fai=
ls loudly=2E<br><br>Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde<br=
>Signed-off-by: Charlie Vigue &lt;charlie=2Evigue@openvpn=2Ecom&gt;<br>Acke=
d-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946<br>Message-Id: &lt;20261103113600=
=2E30488-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40621=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=
=2Etxt<br>M tests/t_net=2Esh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br=
>M tests/unit_tests/openvpn/test_networking=2Ec<br>A tests/unit_tests/openv=
pn/test_route=2Ec<br>A tests/unit_tests/openvpn/test_route=2Eh<br>6 files c=
hanged, 228 insertions(+), 2 deletions(-)<br><br></pre>
<pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMa=
keLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index a90eb1a=2E=2E4f48990=
 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeL=
ists=2Etxt</span><br><span>@@ -973,7 +973,14 @@</span><br><span>     if (TA=
RGET test_networking)</span><br><span>         target_link_options(test_net=
working PRIVATE -Wl,--wrap=3Dparse_line)</span><br><span>         target_co=
mpile_options(test_networking PRIVATE -UNDEBUG)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        target_link_libraries(test_networking P=
UBLIC ${RESOLV_LIBRARIES})</span><br><span>         target_sources(test_net=
working PRIVATE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        tests/unit_tests/openvpn/test_route=2Ec</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            tests/unit_tests/openvpn/mock_manag=
ement=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  src/openvpn/route=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            src/openvpn/env_set=2Ec</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            src/openvpn/run_command=2Ec</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/socket_util=
=2Ec</span><br><span>             src/openvpn/networking_sitnl=2Ec</span><b=
r><span>             src/openvpn/crypto_epoch=2Ec</span><br><span>         =
    src/openvpn/crypto_mbedtls=2Ec</span><br><span>diff --git a/tests/t_net=
=2Esh b/tests/t_net=2Esh</span><br><span>index d63f648=2E=2Efd07277 100755<=
/span><br><span>--- a/tests/t_net=2Esh</span><br><span>+++ b/tests/t_net=2E=
sh</span><br><span>@@ -3,7 +3,7 @@</span><br><span> IFACE=3D&quot;ovpn-dumm=
y0&quot;</span><br><span> UNIT_TEST=3D&quot;=2E/unit_tests/openvpn/networki=
ng_testdriver&quot;</span><br><span> LAST_AUTO_TEST=3D7</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-LAST_TEST=3D8</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+LAST_TEST=3D9</span><br><span> </span><br><span=
> srcdir=3D&quot;${srcdir:-=2E}&quot;</span><br><span> top_builddir=3D&quot=
;${top_builddir:-=2E=2E}&quot;</span><br><span>diff --git a/tests/unit_test=
s/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br>=
<span>index 70cf7b2=2E=2E6091264 100644</span><br><span>--- a/tests/unit_te=
sts/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Ma=
kefile=2Eam</span><br><span>@@ -219,8 +219,14 @@</span><br><span> networkin=
g_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn \</span=
><br><span> 	$(OPTIONAL_CRYPTO_LIBS)</span><br><span> networking_testdriver=
_SOURCES =3D test_networking=2Ec mock_msg=2Ec \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	test_route=2Ec test_route=2Eh test_common=2Eh =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_management=
=2Ec \</span><br><span> 	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</spa=
n><br><span> 	$(top_srcdir)/src/openvpn/networking_sitnl=2Ec \</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/route=
=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir=
)/src/openvpn/env_set=2Ec \</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+	$(top_srcdir)/src/openvpn/run_command=2Ec \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/socket_util=2E=
c \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><spa=
n> 	$(top_srcdir)/src/openvpn/crypto=2Ec \</span><br><span> 	$(top_srcdir)/=
src/openvpn/crypto_epoch=2Ec \</span><br><span>diff --git a/tests/unit_test=
s/openvpn/test_networking=2Ec b/tests/unit_tests/openvpn/test_networking=2E=
c</span><br><span>index 3699a2a1=2E=2Eb580d32 100644</span><br><span>--- a/=
tests/unit_tests/openvpn/test_networking=2Ec</span><br><span>+++ b/tests/un=
it_tests/openvpn/test_networking=2Ec</span><br><span>@@ -2,6 +2,8 @@</span>=
<br><span> #include &quot;syshead=2Eh&quot;</span><br><span> #include &quot=
;networking=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;test_route=2Eh&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #include &lt;setjmp=
=2Eh&gt;</span><br><span> #include &lt;cmocka=2Eh&gt;</span><br><span> </sp=
an><br><span>@@ -212,7 +214,7 @@</span><br><span> static void</span><br><sp=
an> usage(char *name)</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    printf(&quot;Usage: %s &lt;0-8&gt;\n&quot;, name);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    printf(&quot;Usag=
e: %s &lt;0-9&gt;\n&quot;, name);</span><br><span> }</span><br><span> </spa=
n><br><span> int</span><br><span>@@ -272,6 +274,9 @@</span><br><span>      =
       assert_int_equal(net__iface_type(&quot;dummy0815&quot;, NULL), -ENOD=
EV);</span><br><span>             return 0;</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        case 9:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            return route_tests();</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>      =
   default:</span><br><span>             printf(&quot;invalid test: %d\n&qu=
ot;, test);</span><br><span>             break;</span><br><span>diff --git =
a/tests/unit_tests/openvpn/test_route=2Ec b/tests/unit_tests/openvpn/test_r=
oute=2Ec</span><br><span>new file mode 100644</span><br><span>index 0000000=
=2E=2E3cfee9b</span><br><span>--- /dev/null</span><br><span>+++ b/tests/uni=
t_tests/openvpn/test_route=2Ec</span><br><span>@@ -0,0 +1,181 @@</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunne=
l IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    =
         over a single UDP port, with support for SSL/TLS-based</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *             session authenti=
cation and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *             packet encryption, packet authentication, and</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet compres=
sion=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 O=
penVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  This program is free software; you can redistribute it and/or modify<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the ter=
ms of the GNU General Public License version 2</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundation=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed i=
n the hope that it will be useful,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warra=
nty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTA=
BILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for more =
details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have receiv=
ed a copy of the GNU General Public License along</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https:=
//www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;conf=
ig=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;test_common=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;route=2Eh&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#include &quot;networking=2Eh&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_route=2Eh&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Stubs for functions route=2Ec referenc=
es but that no test here reaches=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * They assert rather than return quietly, so a test strayi=
ng onto one</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * fails=
 loudly instead of silently doing nothing=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+struct argv</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+argv_new(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(0);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct argv a =3D =
{ 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return a;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+argv_free(struct argv *a)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_true(0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+get_ipv6_addr(const char *prefix_str, struct in6_addr *netwo=
rk, unsigned int *netbits,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+              msglvl_t msglevel)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_true(0);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+in_addr_t</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+getaddr(unsigned int flags, const char *hostnam=
e, int resolve_retry, bool *succeeded,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        struct signal_info *sig_info)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(0);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+openvpn_getaddrinfo(unsigned int flags, =
const char *hostname, const char *servname,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                    int resolve_retry_seconds, stru=
ct signal_info *sig_info, int ai_family,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    struct addrinfo **res)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_true(0);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct signal_inf=
o siginfo_static; /* GLOBAL */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+signal_reset(struct sign=
al_info *si, int signum)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tr=
ue(0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+test_is_special_addr(void **state)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_true(is_special_addr(&quot;net_gateway&quot;));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(is_special_a=
ddr(&quot;vpn_gateway&quot;));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(is_special_addr(&quot;remote_host&quot;));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_false(is_special_addr(&quot;10=2E=
0=2E0=2E1&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_false(is_special_addr(&quot;default&quot;));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_false(is_special_addr(NULL));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+test_netmask_to_netbits(void **state)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    int netbits;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
true(netmask_to_netbits(0x0a000000, 0xff000000, &amp;netbits)); /* 10/8 */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal=
(netbits, 8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(netmask_t=
o_netbits(0xc0a80100, 0xffffff00, &amp;netbits)); /* 192=2E168=2E1/24 */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(n=
etbits, 24);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(netmask_to=
_netbits(0x00000000, 0x00000000, &amp;netbits)); /* default route */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(netbi=
ts, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* a full-length mask repor=
ts -1 rather than 32 */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_true(netmask_to_netbits(0x0a010203, 0xffffffff, &amp;netbits=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(netbits, -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* host bits set=
 in the network part */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_false(netmask_to_netbits(0x0a000001, 0xff000000, &amp;netbit=
s));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* not a contiguous netmask */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ne=
tmask_to_netbits(0x0a000000, 0xff00ff00, &amp;netbits));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_net=
mask_to_netbits2(void **state)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_equal(netmask_to_netbits2(0xff000000), 8);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_int_equal(netmask_to_netbits2(0xf=
fffff00), 24);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(netmask_to_netbits2(0x00000000), 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* unlike netmask_to_netbits(), this one reports a full-=
length mask as 32 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_equal(netmask_to_netbits2(0xffffffff), 32);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_int_equal(netmask_to_netbits2(0xff00ff00), =
-1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+assert_clear_host_bits(const char *addr, unsigned int netbit=
s, const char *expected)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ro=
ute_ipv6 r6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct in6_addr want;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(r6);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(inet=
_pton(AF_INET6, addr, &amp;r6=2Enetwork), 1);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(inet_pton(AF_INET6, expected=
, &amp;want), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  r6=2Enetbits =3D netbits;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    route_i=
pv6_clear_host_bits(&amp;r6);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_memory_equal(&amp;r6=2Enetwork, &amp;want, sizeof(stru=
ct in6_addr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_route_ipv6_clear_host_bits(void **state)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* whole bytes cleared */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_clear_host_bits(&quo=
t;2001:db8::1&quot;, 64, &quot;2001:db8::&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_clear_host_bits(&quot;2001:db8:dea=
d:beef::1&quot;, 32, &quot;2001:db8::&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* a prefix that does not fall on a byte boundary */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_clear_host_bits(&quo=
t;2001:db8:0:00ff::1&quot;, 60, &quot;2001:db8:0:00f0::&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_clear_host_bits(&quo=
t;2001:db8::ffff&quot;, 121, &quot;2001:db8::ff80&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* nothing to clear, and everything to clear */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_clear_host_bi=
ts(&quot;2001:db8::1&quot;, 128, &quot;2001:db8::1&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_clear_host_bits(&quot;200=
1:db8::1&quot;, 0, &quot;::&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static const struct C=
MUnitTest route_test_list[] =3D {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    cmocka_unit_test(test_is_special_addr),</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_netmask_to_=
netbits),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka=
_unit_test(test_netmask_to_netbits2),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    cmocka_unit_test(test_route_ipv6_clear_host_bits),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+route_tests(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_unit_te=
st_setup();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn cmocka_run_group_tests(route_test_list, NULL, NULL);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/tests/un=
it_tests/openvpn/test_route=2Eh b/tests/unit_tests/openvpn/test_route=2Eh</=
span><br><span>new file mode 100644</span><br><span>index 0000000=2E=2Ecaa5=
c3c</span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/op=
envpn/test_route=2Eh</span><br><span>@@ -0,0 +1,27 @@</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networ=
ks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             ov=
er a single UDP port, with support for SSL/TLS-based</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             session authentication and=
 key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          packet encryption, packet authentication, and</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc=
 &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This=
 program is free software; you can redistribute it and/or modify</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the =
GNU General Public License version 2</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  as published by the Free Software Foundation=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in the ho=
pe that it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY o=
r FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  GNU General Public License for more details=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a co=
py of the GNU General Public License along</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www=
=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifnde=
f TEST_ROUTE_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne TEST_ROUTE_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** =
Runs the route=2Ec unit tests, returns the number of failures */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+route_tests(void);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br></pre><p>To view, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail">change 19=
46</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: I9085c55a7efefd31839b00ec8ec9a6f085574dde </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 1946 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: chugly &lt;ch=
arlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>

</body></html>
--gqFf2sTNsJU=--


--===============4645755356984158535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4645755356984158535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4645755356984158535==--

