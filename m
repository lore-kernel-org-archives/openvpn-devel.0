Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0BCCC6B39
	for <openvpn-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=up/tlFzewVmzYXhjAFo5K8OMedUMNxbTOQCFiT8xeIE=; b=YrmmVGc5hxbrGvA+I8eI+i2fC5
	Rc9XaSCAgtNuM4hHS/3rhY1/i1kSUiz3SypEpUP6MU5m/MQma7JGrV2IAgF+geM0JwLMqHFcGsHwS
	e+qJwuTf9wuWk7Grkk4IIBo+8giavTcpcatezaTBc5cSIGITd9idvvAmzKjCp8zGUyaA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHNNU-0000xE-8K;
	Thu, 15 Oct 2026 15:28:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHNNS-0000x6-PO
 for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 15:28:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=F3WqTM2hx6wT2cdbTKGhu/oaMk5PgLFNhURAFeZq7Qc=; b=HVo1iR+Iqwm5jaIbadu0fmTESB
 xETGzpKilIGuUYwlDfok+ay2GdcX30jbM/XuUI6oBbKOgCX2KDpc0LgxEUJ7sHCgSZCDH68nUT8CJ
 ahsAynD4+u2D3W1jOx1q9Lln3byJJpnhYJ23K+GCmDvdevit+SqBcqyK/ZZ3ZmYeoKl4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=F3WqTM2hx6wT2cdbTKGhu/oaMk5PgLFNhURAFeZq7Qc=; b=K
 4NKwUrOjYLvvEbLtgZc9WKjGHNgOrRl8yDnJ5wHY5YzNQe0X8jpnDql7uKWAGQ2y4/K9U5sTY2maV
 TUVcIVqyWkycWJBaYhBz0LX0pcljuMY8YEIQ7waz0sWoIsLK9FyzyZdHLgtC+fsVrD+zBLaD1FkBj
 fSqhOwhMUtxBYuBY=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHNNL-00022D-Dx for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 15:28:19 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a16bc2278aso39019965e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 08:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792078085; x=1792682885; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=F3WqTM2hx6wT2cdbTKGhu/oaMk5PgLFNhURAFeZq7Qc=;
 b=SBC35ns6D175i/F8SiJEoLAcZq8j/Y84NRZw9Z/Gr8O/VHXt9aqPhUA9+nV90miF+n
 sFVQGIUIY93TaRlPDbod4XBkIWdnMndfQCIGHSm8x3GzSKoqwMVu2MShdOfaSOlpwy3R
 BZjeWN8xXilAwk7iM2vSsVdad37fr0eoLZj0PE70LsG9r+iAlXuvveUA+zlhnmv/vPuX
 mf9NX6iWuTPptrIveGMfDT5q35/FU2XOW8EIo5qqBhGRDEiUOyVeZLu1SibhvCwYDmQL
 kZHXfrkITFojaOp8EeVs1fpxkBtXjKTu5Csxs5ZydlOGyiDt+K15MU/etMhUcyTgZwaX
 gYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792078085; x=1792682885;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=F3WqTM2hx6wT2cdbTKGhu/oaMk5PgLFNhURAFeZq7Qc=;
 b=CNf/+8QCaJruwuUSQkDVGKC+oJop/WAymX7YEcxkI9DUDVWAQ8E/XMskLpqVqjWSqX
 23O4MtNak+NvKMJPTwk9P+xbYuCS5tjasSPkylp3M66K/HrjT5NbdgU1PIz5xVxHqHs/
 qZBg5ojHe41M3tOzQ/m7JuONz8HmrB+LJK+6c/6P6ekBZcBCKq4bWIHDr+XgqhjQCgGa
 0b8Y6BVSveUmi2qDGXXyMRVA/59M+3dsmfi2MVC9c7VN65GPKAVDBB2MgFOpxlZHX8Y+
 2rMfMQkMGH88r7HUfx9jPcIZdrp2QW0NDzQvM7cLwxz6APgp/32Spb86hWFvsHx7OAgl
 ptKw==
X-Gm-Message-State: AFq9FYJkN1mZ6xv4nRNE9M7NYG3uhDQHwVw6xumwkchhzYFVUK0A9WFT
 vuFUVeXKO4KiCHj/RQVbym8TkUvPqCOIYKdpcnh6+YFgmUy+GH2LVp96uB0JshiuqBrZpuyCtEV
 jQyHWFsoUqAc9FzMTo80Ankq77DFfPGryur5PfWQuguZvF0bEeoUapDk3r+DW1k2OWssh
X-Gm-Gg: AYBFou2uAaI1HHziUlG2ILEdfmybrDA0wWA7X9O+/0+Dw9S9wnWTEdf/lSxgPNwugT3
 mlhuaypLGPFinafsv4Kr0mQJP2teiCedUUGu6wMr7YsVqTf4uYh4dFbkBXZpSsvvCzEwczSmYdP
 mULxT2QYu9UzTU/jE0VKkGgl1tOX184SDi9/1JhLsUhUHZpROerqi14G2rQdMEG7EfR7OEfWqnZ
 H54/NNOkeHvHsAR66tCcFXvD839s2kWXw2TzxFpzEx5fr44pPzoq6xsbQDHH/k6RU5W8csle0sX
 OySYISLKlTUtW4Eekwk1yx1WqELUKDf/wYE7Ols5vxuJhqBDKDHMx4Kno4v6Tjk8U2FCGXgHEGm
 0VaweKl/ZAJFUTCAtRAwmS9smjXXHkpHLYYad7RpWln30KO3ibxPOptjhgkC6OFKXoZEmQyiYdj
 FAVJvdlSDfCtG2Si21tLAMb6hoapGBdh5RZiHWXQukidgbM70KtnF/N/VDgdh5qgr+c4ErpcWrZ
 p0dyzmXbH8jRASLX98Blhx3wqc4trZEf7Kg3MCJkxf0TAqOJYEj2ZJLUQAUIzrrseVXBOQW2U+/
 ASeG+4xf9kby81zbK0ZOt7L9HtUY1f8xZG+ljVTT5a6GpjJJpbxnoQvqFvu9
X-Received: by 2002:a05:600c:46cf:b0:49e:8191:e5cb with SMTP id
 5b1f17b1804b1-4a18e4a3ac7mr423554155e9.5.1792078082782; 
 Thu, 15 Oct 2026 08:28:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df57e8549sm4231189f8f.0.2026.10.15.08.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 08:28:01 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 15 Oct 2026 15:27:57 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 33
X-Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
X-Gerrit-Change-Number: 1663
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1663?usp=email>
X-Gerrit-Commit: 571caa34e2fe134029a57769df8182b1c31e33a4
In-Reply-To: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
References: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDY4NTAxMDAwLkk1NjI0OGNmNmQxOTljMmRhNzcwNzc0YjhmZDFlNWRhZjJiMTE2ZjU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <89784f00bf167b618ec92088030bbb938be5bf4c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHNNL-00022D-Dx
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove instances of
 constParameterPointer cppcheck warnings
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7589869655745983873=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7589869655745983873==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rdFKSlJg/4g="; charset=UTF-8

--rdFKSlJg/4g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#33) to the change originally cr=
eated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1663?usp=3Demail )

The following approvals got outdated and were removed:
=
Code-Review+2 by R=C4=83zvan Cojocaru


Change subject: Remove instances of=
 constParameterPointer cppcheck warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove instances of constParameterPointer cppc=
heck warnings

This requires a few suppressions since cppcheck
doesn't quit=
e understand the different code-paths
implemented by preprocessor defines=
=2E

Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
Signed-off-by: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvan=
c@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/166=
3
Message-Id: <20261015113218=2E24245-1-gert@greenie=2Emuc=2Ede>
URL: https=
://lore=2Ekernel=2Eorg/openvpn-devel/20261015113218=2E24245-1-gert@greenie=
=2Emuc=2Ede/
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M de=
v-tools/cppcheck-suppressions=2Exml
M sample/sample-plugins/client-connect/=
sample-client-connect=2Ec
M sample/sample-plugins/defer/multi-auth=2Ec
M sa=
mple/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter=2E=
c
M src/openvpn/buffer=2Eh
M src/openvpn/clinat=2Ec
M src/openvpn/comp=2Ec
=
M src/openvpn/comp=2Eh
M src/openvpn/crypto=2Ec
M src/openvpn/crypto=2Eh
M =
src/openvpn/dco=2Ec
M src/openvpn/dco=2Eh
M src/openvpn/dco_freebsd=2Ec
M s=
rc/openvpn/dco_internal=2Eh
M src/openvpn/dco_linux=2Ec
M src/openvpn/dco_w=
in=2Ec
M src/openvpn/error=2Ec
M src/openvpn/error=2Eh
M src/openvpn/event=
=2Ec
M src/openvpn/event=2Eh
M src/openvpn/forward=2Ec
M src/openvpn/forwar=
d=2Eh
M src/openvpn/init=2Ec
M src/openvpn/init=2Eh
M src/openvpn/interval=
=2Eh
M src/openvpn/list=2Ec
M src/openvpn/list=2Eh
M src/openvpn/manage=2Ec=

M src/openvpn/manage=2Eh
M src/openvpn/mbuf=2Ec
M src/openvpn/mbuf=2Eh
M s=
rc/openvpn/mss=2Ec
M src/openvpn/mss=2Eh
M src/openvpn/mtcp=2Ec
M src/openv=
pn/mtcp=2Eh
M src/openvpn/mudp=2Ec
M src/openvpn/multi=2Ec
M src/openvpn/mu=
lti=2Eh
M src/openvpn/multi_io=2Ec
M src/openvpn/networking=2Eh
M src/openv=
pn/networking_iproute2=2Ec
M src/openvpn/networking_sitnl=2Ec
M src/openvpn=
/occ=2Eh
M src/openvpn/openssl_compat=2Eh
M src/openvpn/options=2Ec
M src/o=
penvpn/options_parse=2Ec
M src/openvpn/otime=2Ec
M src/openvpn/otime=2Eh
M =
src/openvpn/proto=2Eh
M src/openvpn/proxy=2Ec
M src/openvpn/proxy=2Eh
M src=
/openvpn/ps=2Ec
M src/openvpn/ps=2Eh
M src/openvpn/push=2Ec
M src/openvpn/p=
ush=2Eh
M src/openvpn/push_util=2Ec
M src/openvpn/reliable=2Ec
M src/openvp=
n/reliable=2Eh
M src/openvpn/route=2Ec
M src/openvpn/socket=2Ec
M src/openv=
pn/socket=2Eh
M src/openvpn/socket_util=2Eh
M src/openvpn/socks=2Ec
M src/o=
penvpn/socks=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ssl=2Eh
M src/openvpn/=
ssl_backend=2Eh
M src/openvpn/ssl_mbedtls=2Ec
M src/openvpn/ssl_openssl=2Ec=

M src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
M src/openvpn/ssl_veri=
fy=2Ec
M src/openvpn/ssl_verify=2Eh
M src/openvpn/status=2Ec
M src/openvpn/=
status=2Eh
M src/openvpn/tun=2Ec
M src/openvpn/tun=2Eh
M src/openvpn/tun_af=
unix=2Ec
M src/openvpn/tun_afunix=2Eh
M src/openvpn/vlan=2Ec
M src/openvpn/=
vlan=2Eh
M src/openvpn/win32=2Eh
M src/openvpnmsica/openvpnmsica=2Ec
M src/=
openvpnserv/interactive=2Ec
M tests/unit_tests/openvpn/mock_management=2Ec
=
M tests/unit_tests/openvpn/siphash_openssl=2Ec
M tests/unit_tests/openvpn/t=
est_misc=2Ec
M tests/unit_tests/openvpn/test_user_pass=2Ec
88 files changed=
, 398 insertions(+), 284 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/63/1663/33

diff --git a/dev-tools/cppche=
ck-suppressions=2Exml b/dev-tools/cppcheck-suppressions=2Exml
index 9d8c202=
=2E=2Ebd24c3b 100644
--- a/dev-tools/cppcheck-suppressions=2Exml
+++ b/dev-=
tools/cppcheck-suppressions=2Exml
@@ -9,9 +9,6 @@
     <id>constParameterCa=
llback</id>
   </suppress>
   <suppress>
-    <id>constParameterPointer</id=
>
-  </suppress>
-  <suppress>
     <id>unusedFunction</id>
   </suppress>
=
   <suppress>
@@ -65,6 +62,97 @@
     <id>badBitmaskCheck</id>
     <fileNa=
me>tests/unit_tests/openvpn/test_pkt=2Ec</fileName>
   </suppress>
+  <!-- =
IGN: we use casts to remove const -->
+  <suppress>
+    <id>constParameter=
Pointer</id>
+    <fileName>src/openvpn/buffer=2Eh</fileName>
+    <symbolN=
ame>buf</symbolName>
+  </suppress>
+  <!-- FP: const silently removed due =
to pointer arithmetic -->
+  <suppress>
+    <id>constParameterPointer</id>=

+    <fileName>src/openvpn/buffer=2Ec</fileName>
+    <symbolName>buf</sym=
bolName>
+  </suppress>
+  <!-- IGN: external -->
+  <suppress>
+    <id>co=
nstParameterPointer</id>
+    <fileName>/usr/include/*</fileName>
+  </supp=
ress>
+  <!-- IGN: too many false-positives due to stubs -->
+  <suppress>
=
+    <id>constParameterPointer</id>
+    <fileName>tests/unit_tests/openvpn=
*/test_*</fileName>
+  </suppress>
+  <suppress>
+    <id>constParameterPoi=
nter</id>
+    <fileName>tests/unit_tests/openvpn/mock_*</fileName>
+  </su=
ppress>
+  <!-- IGN: too many false-positives due to library/platform-speci=
fic code -->
+  <suppress>
+    <id>constParameterPointer</id>
+    <fileNa=
me>src/openvpn/crypto*</fileName>
+  </suppress>
+  <suppress>
+    <id>con=
stParameterPointer</id>
+    <fileName>src/openvpn/ssl_*</fileName>
+  </su=
ppress>
+  <suppress>
+    <id>constParameterPointer</id>
+    <fileName>sr=
c/openvpn/dco*</fileName>
+  </suppress>
+  <suppress>
+    <id>constParame=
terPointer</id>
+    <fileName>src/openvpn/socket=2E*</fileName>
+  </suppr=
ess>
+  <!-- FP: const is only possible on some platforms
+       These mig=
ht easily hide valid issues but we need to compromise
+       for developer=
 sanity=2E
+       Inline suppressions are often too ugly since they need t=
o go in
+       between our return type line and the function name=2E=2E=2E=

+  -->
+  <suppress>
+    <id>constParameterPointer</id>
+    <fileName>sr=
c/openvpn/dns=2Ec</fileName>
+    <symbolName>duri</symbolName>
+  </suppre=
ss>
+  <suppress>
+    <id>constParameterPointer</id>
+    <fileName>src/op=
envpn/error=2Ec</fileName>
+    <symbolName>gc</symbolName>
+  </suppress>
=
+  <suppress>
+    <id>constParameterPointer</id>
+    <fileName>src/openvp=
n/forward=2Ec</fileName>
+    <symbolName>dco</symbolName>
+  </suppress>
+=
  <suppress>
+    <id>constParameterPointer</id>
+    <fileName>src/openvpn=
/manage=2Ec</fileName>
+    <symbolName>man</symbolName>
+  </suppress>
+  =
<suppress>
+    <id>constParameterPointer</id>
+    <fileName>src/openvpn/m=
isc=2Ec</fileName>
+    <symbolName>up</symbolName>
+  </suppress>
+  <supp=
ress>
+    <id>constParameterPointer</id>
+    <fileName>src/openvpn/option=
s=2Ec</fileName>
+    <symbolName>options</symbolName>
+  </suppress>
+  <s=
uppress>
+    <id>constParameterPointer</id>
+    <fileName>src/openvpn/tun=
=2Ec</fileName>
+    <symbolName>gc</symbolName>
+  </suppress>
+  <!-- IGN=
: weird issue with MinGW debug build throwing -Werror=3Dmaybe-uninitialized=

+       for no good reason -->
+  <suppress>
+    <id>constParameterPointe=
r</id>
+    <fileName>src/openvpn/buffer=2Eh</fileName>
+    <symbolName>p<=
/symbolName>
+  </suppress>
   <!-- FP: cppcheck seems to have wrong signat=
ure of DeviceIoControl() -->
   <suppress>
     <id>constVariablePointer</i=
d>
diff --git a/sample/sample-plugins/client-connect/sample-client-connect=
=2Ec b/sample/sample-plugins/client-connect/sample-client-connect=2Ec
index=
 420de61=2E=2Ecbd98e8 100644
--- a/sample/sample-plugins/client-connect/sam=
ple-client-connect=2Ec
+++ b/sample/sample-plugins/client-connect/sample-cl=
ient-connect=2Ec
@@ -344,7 +344,7 @@
 }
 
 int
-openvpn_plugin_client_conne=
ct(struct plugin_context *context, const char **argv, const char **envp)
+o=
penvpn_plugin_client_connect(const struct plugin_context *context, const ch=
ar **argv, const char **envp)
 {
     /* log environment variables handed t=
o us by OpenVPN, but
      * only if "setenv verb" is 3 or higher (arbitrar=
y number)
@@ -465,7 +465,7 @@
 
 int
 openvpn_plugin_client_connect_defer_v=
2(struct plugin_context *context,
-                                       s=
truct plugin_per_client_context *pcc,
+                                    =
   const struct plugin_per_client_context *pcc,
                           =
             struct openvpn_plugin_string_list **return_list)
 {
     time_=
t time_left =3D pcc->sleep_until - time(NULL);
diff --git a/sample/sample-p=
lugins/defer/multi-auth=2Ec b/sample/sample-plugins/defer/multi-auth=2Ec
in=
dex bacf557=2E=2Ecdd616f 100644
--- a/sample/sample-plugins/defer/multi-aut=
h=2Ec
+++ b/sample/sample-plugins/defer/multi-auth=2Ec
@@ -255,7 +255,7 @@
=
 }
 
 static bool
-do_auth_user_pass(struct plugin_context *context, const =
char *username, const char *password)
+do_auth_user_pass(const struct plugi=
n_context *context, const char *username, const char *password)
 {
     plo=
g(context, PLOG_NOTE, "expect_user=3D%s, received_user=3D%s, expect_passw=
=3D%s, received_passw=3D%s",
          np(context->test_valid_user), np(use=
rname), np(context->test_valid_pass), np(password));
@@ -279,7 +279,7 @@
 
=
 
 static int
-auth_user_pass_verify(struct plugin_context *context, struct=
 plugin_per_client_context *pcc,
+auth_user_pass_verify(const struct plugin=
_context *context, struct plugin_per_client_context *pcc,
                 =
      const char *argv[], const char *envp[])
 {
     /* get username/passw=
ord from envp string array */
diff --git a/sample/sample-plugins/keying-mat=
erial-exporter-demo/keyingmaterialexporter=2Ec b/sample/sample-plugins/keyi=
ng-material-exporter-demo/keyingmaterialexporter=2Ec
index 204374b=2E=2E41c=
5c4f 100644
--- a/sample/sample-plugins/keying-material-exporter-demo/keyin=
gmaterialexporter=2Ec
+++ b/sample/sample-plugins/keying-material-exporter-=
demo/keyingmaterialexporter=2Ec
@@ -187,7 +187,7 @@
 }
 
 static void
-file=
_store(char *file, char *content)
+file_store(const char *file, const char =
*content)
 {
     FILE *f;
     if (!(f =3D fopen(file, "w+")))
@@ -203,7 +=
203,7 @@
 server_store(struct openvpn_plugin_args_func_in const *args)
 {
 =
    struct plugin *plugin =3D (struct plugin *)args->handle;
-    struct se=
ssion *sess =3D (struct session *)args->per_client_context;
+    const stru=
ct session *sess =3D args->per_client_context;
 
     char file[MAXPATH];
 =
    snprintf(file, sizeof(file) - 1, "/tmp/openvpn_sso_%s", sess->key);
@@ =
-215,7 +215,7 @@
 client_store(struct openvpn_plugin_args_func_in const *ar=
gs)
 {
     struct plugin *plugin =3D (struct plugin *)args->handle;
-    s=
truct session *sess =3D (struct session *)args->per_client_context;
+    co=
nst struct session *sess =3D args->per_client_context;
 
     char *file =
=3D "/tmp/openvpn_sso_user";
     ovpn_note("app session file: %s", file);
=
diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index 58e10f0=
=2E=2E063a2d4 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=
=2Eh
@@ -1920,7 +1920,7 @@
  * @param a  The arena to test=2E
  */
 static =
inline bool
-gc_defined(struct gc_arena *a)
+gc_defined(const struct gc_are=
na *a)
 {
     return a->list !=3D NULL;
 }
diff --git a/src/openvpn/clinat=
=2Ec b/src/openvpn/clinat=2Ec
index dcef924=2E=2Ed72d42a 100644
--- a/src/o=
penvpn/clinat=2Ec
+++ b/src/openvpn/clinat=2Ec
@@ -158,7 +158,7 @@
 #endif
=
 
 static void
-print_pkt(struct openvpn_iphdr *iph, const char *prefix, co=
nst int direction, const msglvl_t msglevel)
+print_pkt(const struct openvpn=
_iphdr *iph, const char *prefix, const int direction, const msglvl_t msglev=
el)
 {
     struct gc_arena gc =3D gc_new();
 
diff --git a/src/openvpn/com=
p=2Ec b/src/openvpn/comp=2Ec
index b88b79f=2E=2E387a7c4 100644
--- a/src/op=
envpn/comp=2Ec
+++ b/src/openvpn/comp=2Ec
@@ -159,7 +159,7 @@
 #endif /* US=
E_COMP */
 
 bool
-check_compression_settings_valid(struct compress_options=
 *info, msglvl_t msglevel)
+check_compression_settings_valid(const struct c=
ompress_options *info, msglvl_t msglevel)
 {
     /*
      * We also allow =
comp-stub-v2 here as it technically allows escaping of
diff --git a/src/ope=
nvpn/comp=2Eh b/src/openvpn/comp=2Eh
index 29a90a2=2E=2Ead80243 100644
--- =
a/src/openvpn/comp=2Eh
+++ b/src/openvpn/comp=2Eh
@@ -91,7 +91,7 @@
  * fla=
gs of allow-compression and also the whether algorithms are compiled
  * in=

  */
-bool check_compression_settings_valid(struct compress_options *info,=
 msglvl_t msglevel);
+bool check_compression_settings_valid(const struct co=
mpress_options *info, msglvl_t msglevel);
 
 #ifdef USE_COMP
 #include "buf=
fer=2Eh"
diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index=
 1703d4d=2E=2E3d3ab0c 100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn=
/crypto=2Ec
@@ -1105,7 +1105,7 @@
 }
 
 static bool
-key_is_zero(struct key=
 *key, const struct key_type *kt)
+key_is_zero(const struct key *key, const=
 struct key_type *kt)
 {
     size_t cipher_length =3D cipher_kt_key_size(k=
t->cipher);
     for (size_t i =3D 0; i < cipher_length; ++i)
@@ -1123,7 +1=
123,7 @@
  * Make sure that cipher key is a valid key for current key_type=
=2E
  */
 bool
-check_key(struct key *key, const struct key_type *kt)
+chec=
k_key(const struct key *key, const struct key_type *kt)
 {
     if (cipher_=
defined(kt->cipher))
     {
@@ -1196,7 +1196,7 @@
 }
 
 void
-test_crypto(s=
truct crypto_options *co, struct frame *frame)
+test_crypto(struct crypto_o=
ptions *co, const struct frame *frame)
 {
     int i, j;
     struct gc_are=
na gc =3D gc_new();
diff --git a/src/openvpn/crypto=2Eh b/src/openvpn/crypt=
o=2Eh
index ee5b50f=2E=2Ee3c1c6a 100644
--- a/src/openvpn/crypto=2Eh
+++ b/=
src/openvpn/crypto=2Eh
@@ -414,7 +414,7 @@
  */
 int write_key_file(const i=
nt nkeys, const char *filename);
 
-bool check_key(struct key *key, const s=
truct key_type *kt);
+bool check_key(const struct key *key, const struct ke=
y_type *kt);
 
 /**
  * Initialize a key_type structure with=2E
@@ -614,7 +=
614,7 @@
 /** Print a cipher list entry */
 void print_cipher(const char *c=
ipher);
 
-void test_crypto(struct crypto_options *co, struct frame *f);
+v=
oid test_crypto(struct crypto_options *co, const struct frame *f);
 
 
 /* =
key direction functions */
diff --git a/src/openvpn/dco=2Ec b/src/openvpn/d=
co=2Ec
index 9fc0e3b=2E=2Ef3b5d44 100644
--- a/src/openvpn/dco=2Ec
+++ b/sr=
c/openvpn/dco=2Ec
@@ -573,7 +573,7 @@
 }
 
 static bool
-dco_multi_get_loca=
laddr(struct multi_context *m, struct multi_instance *mi,
+dco_multi_get_lo=
caladdr(const struct multi_context *m, const struct multi_instance *mi,
   =
                      struct sockaddr_storage *local)
 {
 #if ENABLE_IP_PKT=
INFO
@@ -585,7 +585,7 @@
         return false;
     }
 
-    struct link_s=
ocket_actual *actual =3D &c->c2=2Elink_socket_infos[0]->lsa->actual;
+    c=
onst struct link_socket_actual *actual =3D &c->c2=2Elink_socket_infos[0]->l=
sa->actual;
 
     switch (actual->dest=2Eaddr=2Esa=2Esa_family)
     {
@@ =
-623,7 +623,7 @@
 }
 
 int
-dco_multi_add_new_peer(struct multi_context *m,=
 struct multi_instance *mi)
+dco_multi_add_new_peer(const struct multi_cont=
ext *m, struct multi_instance *mi)
 {
     const struct context *c =3D &mi-=
>context;
 
@@ -677,7 +677,7 @@
 }
 
 void
-dco_install_iroute(struct multi=
_context *m, struct multi_instance *mi, struct mroute_addr *addr)
+dco_inst=
all_iroute(struct multi_context *m, struct multi_instance *mi, const struct=
 mroute_addr *addr)
 {
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD=
) || defined(_WIN32)
     if (!dco_enabled(&m->top=2Eoptions))
diff --git a=
/src/openvpn/dco=2Eh b/src/openvpn/dco=2Eh
index 7ef75fee=2E=2Ec435f8c 1006=
44
--- a/src/openvpn/dco=2Eh
+++ b/src/openvpn/dco=2Eh
@@ -204,7 +204,7 @@
=
  * @param mi        the client instance
  * @return          0 on success =
or a negative error code otherwise
  */
-int dco_multi_add_new_peer(struct =
multi_context *m, struct multi_instance *mi);
+int dco_multi_add_new_peer(c=
onst struct multi_context *m, struct multi_instance *mi);
 
 /**
  * Instal=
l an iroute in DCO, which means adding a route to the system routing
@@ -21=
5,7 +215,7 @@
  * @param addr      the route to add
  */
 void dco_install_=
iroute(struct multi_context *m, struct multi_instance *mi,
-               =
         struct mroute_addr *addr);
+                        const struct m=
route_addr *addr);
 
 /**
  * Remove all routes added through the specified=
 client
@@ -253,7 +253,7 @@
  * a 64 bit packet counter and AEAD tag at the=
 end=2E
  */
 bool
-dco_supports_epoch_data(struct context *c);
+dco_suppor=
ts_epoch_data(const struct context *c);
 #else  /* if defined(ENABLE_DCO) *=
/
 
 typedef void *dco_context_t;
@@ -350,7 +350,7 @@
 }
 
 static inline i=
nt
-dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *=
mi)
+dco_multi_add_new_peer(const struct multi_context *m, struct multi_ins=
tance *mi)
 {
     return 0;
 }
@@ -384,7 +384,7 @@
 }
 
 static inline boo=
l
-dco_supports_epoch_data(struct context *c)
+dco_supports_epoch_data(cons=
t struct context *c)
 {
     return false;
 }
diff --git a/src/openvpn/dco_=
freebsd=2Ec b/src/openvpn/dco_freebsd=2Ec
index 87eea55=2E=2E3148f10 100644=

--- a/src/openvpn/dco_freebsd=2Ec
+++ b/src/openvpn/dco_freebsd=2Ec
@@ -92=
9,7 +929,7 @@
 }
 
 bool
-dco_supports_epoch_data(struct context *c)
+dco_s=
upports_epoch_data(const struct context *c)
 {
     return false;
 }
diff -=
-git a/src/openvpn/dco_internal=2Eh b/src/openvpn/dco_internal=2Eh
index fc=
f8aca=2E=2E1022e66 100644
--- a/src/openvpn/dco_internal=2Eh
+++ b/src/open=
vpn/dco_internal=2Eh
@@ -59,8 +59,9 @@
  * They are implemented by dco_linu=
x=2Ec
  */
 
-int dco_new_peer(dco_context_t *dco, unsigned int peerid, soc=
ket_descriptor_t sd, struct sockaddr *localaddr,
-                 struct s=
ockaddr *remoteaddr, const struct in_addr *vpn_ipv4, const struct in6_addr =
*vpn_ipv6);
+int dco_new_peer(dco_context_t *dco, unsigned int peerid, sock=
et_descriptor_t sd,
+                 struct sockaddr *localaddr, struct so=
ckaddr *remoteaddr,
+                 const struct in_addr *vpn_ipv4, const=
 struct in6_addr *vpn_ipv6);
 
 int dco_del_peer(dco_context_t *dco, unsign=
ed int peerid);
 
diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_=
linux=2Ec
index a397fb8=2E=2E4412ad0 100644
--- a/src/openvpn/dco_linux=2Ec=

+++ b/src/openvpn/dco_linux=2Ec
@@ -104,7 +104,7 @@
 }
 
 static struct nl=
_msg *
-ovpn_dco_nlmsg_create(dco_context_t *dco, uint8_t cmd)
+ovpn_dco_nl=
msg_create(const dco_context_t *dco, uint8_t cmd)
 {
     struct nl_msg *nl=
_msg =3D nlmsg_alloc();
     if (!nl_msg)
@@ -842,7 +842,7 @@
 
 /* libnl <=
 3=2E11=2E0 does not implement nla_get_uint() */
 static uint64_t
-ovpn_nla=
_get_uint(struct nlattr *attr)
+ovpn_nla_get_uint(const struct nlattr *attr=
)
 {
     if (nla_len(attr) =3D=3D sizeof(uint32_t))
     {
@@ -954,7 +954,=
7 @@
 }
 
 static bool
-ovpn_iface_check(dco_context_t *dco, struct nlattr =
*attrs[])
+ovpn_iface_check(const dco_context_t *dco, struct nlattr *attrs[=
])
 {
     /* we must know which interface this message is referring to in =
order to
      * avoid mixing messages for other instances
@@ -1381,7 +1381=
,7 @@
 }
 
 bool
-dco_supports_epoch_data(struct context *c)
+dco_supports_=
epoch_data(const struct context *c)
 {
     return false;
 }
diff --git a/s=
rc/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec
index 6e5e295=2E=2E12b0666=
 100644
--- a/src/openvpn/dco_win=2Ec
+++ b/src/openvpn/dco_win=2Ec
@@ -109=
2,7 +1092,7 @@
 }
 
 bool
-dco_supports_epoch_data(struct context *c)
+dco_=
supports_epoch_data(const struct context *c)
 {
     OVPN_VERSION ver =3D {=
 0 };
     return dco_get_version(&ver) && ((ver=2EMajor =3D=3D 2 && ver=2E=
Minor >=3D 8) || (ver=2EMajor > 2));
diff --git a/src/openvpn/error=2Ec b/s=
rc/openvpn/error=2Ec
index 26d4c7c=2E=2E32d819d 100644
--- a/src/openvpn/er=
ror=2Ec
+++ b/src/openvpn/error=2Ec
@@ -623,7 +623,7 @@
  * from the OS=2E
=
  */
 void
-x_check_status(ssize_t status, const char *description, struct =
link_socket *sock, struct tuntap *tt)
+x_check_status(ssize_t status, const=
 char *description, struct link_socket *sock, const struct tuntap *tt)
 {
 =
    const char *extended_msg =3D NULL;
 
diff --git a/src/openvpn/error=2Eh=
 b/src/openvpn/error=2Eh
index 9f39572=2E=2E373cbc1 100644
--- a/src/openvp=
n/error=2Eh
+++ b/src/openvpn/error=2Eh
@@ -304,10 +304,10 @@
 void set_che=
ck_status(unsigned int info_level, unsigned int verbose_level);
 
 void x_c=
heck_status(ssize_t status, const char *description, struct link_socket *so=
ck,
-                    struct tuntap *tt);
+                    const str=
uct tuntap *tt);
 
 static inline void
-check_status(ssize_t status, const =
char *description, struct link_socket *sock, struct tuntap *tt)
+check_stat=
us(ssize_t status, const char *description, struct link_socket *sock, const=
 struct tuntap *tt)
 {
     if (status < 0 || check_debug_level(x_cs_verbos=
e_level))
     {
diff --git a/src/openvpn/event=2Ec b/src/openvpn/event=2Ec=

index 4089401=2E=2E5e17ea1 100644
--- a/src/openvpn/event=2Ec
+++ b/src/op=
envpn/event=2Ec
@@ -1012,7 +1012,7 @@
 }
 
 static int
-se_wait_return(stru=
ct se_set *ses, fd_set *read, fd_set *write, struct event_set_return *out,
=
+se_wait_return(struct se_set *ses, const fd_set *read, const fd_set *write=
, struct event_set_return *out,
                int outlen)
 {
     int i, =
j =3D 0;
diff --git a/src/openvpn/event=2Eh b/src/openvpn/event=2Eh
index b=
784dfe=2E=2E0940a1d 100644
--- a/src/openvpn/event=2Eh
+++ b/src/openvpn/ev=
ent=2Eh
@@ -204,7 +204,7 @@
 #else /* ifdef _WIN32 */
 
 static inline void=

-wait_signal(struct event_set *es, void *arg)
+wait_signal(const struct ev=
ent_set *es, const void *arg)
 {
 }
 
diff --git a/src/openvpn/forward=2Ec =
b/src/openvpn/forward=2Ec
index b97fb7a=2E=2E681210d 100644
--- a/src/openv=
pn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -237,7 +237,7 @@
 }
 
 stat=
ic void
-parse_incoming_control_channel_command(struct context *c, struct b=
uffer *buf)
+parse_incoming_control_channel_command(struct context *c, cons=
t struct buffer *buf)
 {
     if (buf_string_match_head_str(buf, "AUTH_FAIL=
ED"))
     {
@@ -507,7 +507,7 @@
 }
 
 int
-get_server_poll_remaining_time(=
struct event_timeout *server_poll_timeout)
+get_server_poll_remaining_time(=
const struct event_timeout *server_poll_timeout)
 {
     update_time();
   =
  int remaining =3D event_timeout_remaining(server_poll_timeout);
@@ -621,7=
 +621,7 @@
  * Buffer reallocation, for use with null encryption=2E
  */
 s=
tatic inline void
-buffer_turnover(const uint8_t *orig_buf, struct buffer *=
dest_stub, struct buffer *src_stub,
+buffer_turnover(const uint8_t *orig_bu=
f, struct buffer *dest_stub, const struct buffer *src_stub,
               =
  struct buffer *storage)
 {
     if (orig_buf =3D=3D src_stub->data && src=
_stub->data !=3D storage->data)
@@ -908,7 +908,7 @@
  */
 
 static inline v=
oid
-socks_postprocess_incoming_link(struct context *c, struct link_socket =
*sock)
+socks_postprocess_incoming_link(struct context *c, const struct lin=
k_socket *sock)
 {
     if (sock->socks_proxy && sock->info=2Eproto =3D=3D =
PROTO_UDP)
     {
@@ -1005,7 +1005,7 @@
 }
 
 bool
-process_incoming_link_p=
art1(struct context *c, struct link_socket_info *lsi, bool floated)
+proces=
s_incoming_link_part1(struct context *c, const struct link_socket_info *lsi=
, bool floated)
 {
     struct gc_arena gc =3D gc_new();
     bool decrypt_=
status =3D false;
@@ -1555,7 +1555,7 @@
  * @param client    Determines whe=
ther to the send packet back via tun or link
  */
 void
-ipv6_send_icmp_unr=
eachable(struct context *c, struct buffer *buf, bool client)
+ipv6_send_icm=
p_unreachable(struct context *c, const struct buffer *buf, bool client)
 {
=
 #define MAX_ICMPV6LEN 1280
     struct openvpn_icmp6hdr icmp6out;
diff --g=
it a/src/openvpn/forward=2Eh b/src/openvpn/forward=2Eh
index 0309725=2E=2E3=
75635b 100644
--- a/src/openvpn/forward=2Eh
+++ b/src/openvpn/forward=2Eh
@=
@ -126,7 +126,7 @@
  */
 void encrypt_sign(struct context *c, bool comp_fra=
g);
 
-int get_server_poll_remaining_time(struct event_timeout *server_poll=
_timeout);
+int get_server_poll_remaining_time(const struct event_timeout *=
server_poll_timeout);
 
 /*************************************************=
*********************/
 /**
@@ -177,7 +177,7 @@
  *
  * @return true if pac=
ket is authenticated, false otherwise=2E
  */
-bool process_incoming_link_p=
art1(struct context *c, struct link_socket_info *lsi, bool floated);
+bool =
process_incoming_link_part1(struct context *c, const struct link_socket_inf=
o *lsi, bool floated);
 
 /**
  * Continues processing a packet read from t=
he external network interface=2E
diff --git a/src/openvpn/init=2Ec b/src/op=
envpn/init=2Ec
index 9306a96=2E=2E3c2ebf9 100644
--- a/src/openvpn/init=2Ec=

+++ b/src/openvpn/init=2Ec
@@ -803,7 +803,7 @@
 }
 
 static void
-init_por=
t_share(struct context *c)
+init_port_share(const struct context *c)
 {
   =
  if (!port_share && (c->options=2Eport_share_host && c->options=2Eport_sha=
re_port))
     {
@@ -1245,7 +1245,7 @@
  * prepending to msg() output=2E
  =
*/
 const char *
-format_common_name(struct context *c, struct gc_arena *gc=
)
+format_common_name(const struct context *c, struct gc_arena *gc)
 {
    =
 struct buffer out =3D alloc_buf_gc(256, gc);
     if (c->c2=2Etls_multi)
@=
@ -1731,7 +1731,7 @@
 
 
 static bool
-can_preserve_tun(struct tuntap *tt)
=
+can_preserve_tun(const struct tuntap *tt)
 {
     if (tt && tt->backend_dr=
iver =3D=3D DRIVER_AFUNIX)
     {
@@ -1753,7 +1753,7 @@
  * @param c pointe=
r to the connection context
  */
 static void
-add_wfp_block(struct context=
 *c)
+add_wfp_block(const struct context *c)
 {
 #if defined(_WIN32)
     /=
* Fortify 'redirect-gateway block-local' with firewall rules? */
@@ -1779,7=
 +1779,7 @@
  * @param adapter_index the VPN adapter index
  */
 static voi=
d
-del_wfp_block(struct context *c, unsigned long adapter_index)
+del_wfp_b=
lock(const struct context *c, unsigned long adapter_index)
 {
 #if defined(=
_WIN32)
     if (c->options=2Eblock_outside_dns || block_local_needed(c->c1=
=2Eroute_list))
diff --git a/src/openvpn/init=2Eh b/src/openvpn/init=2Eh
in=
dex ce8f74e=2E=2Ec486158 100644
--- a/src/openvpn/init=2Eh
+++ b/src/openvp=
n/init=2Eh
@@ -91,7 +91,7 @@
 
 uint64_t pull_permission_mask(const struct =
context *c);
 
-const char *format_common_name(struct context *c, struct gc=
_arena *gc);
+const char *format_common_name(const struct context *c, struc=
t gc_arena *gc);
 
 void reset_coarse_timers(struct context *c);
 
diff --g=
it a/src/openvpn/interval=2Eh b/src/openvpn/interval=2Eh
index 59051bd=2E=
=2E0cfe202 100644
--- a/src/openvpn/interval=2Eh
+++ b/src/openvpn/interval=
=2Eh
@@ -89,7 +89,7 @@
 }
 
 static inline void
-interval_schedule_wakeup(s=
truct interval *top, interval_t *wakeup)
+interval_schedule_wakeup(const st=
ruct interval *top, interval_t *wakeup)
 {
     const time_t local_now =3D =
now;
     interval_earliest_wakeup(wakeup, top->last_test_true + top->refre=
sh, local_now);
@@ -214,7 +214,7 @@
  * This function does not check if the=
 timeout is actually valid=2E
  */
 static inline interval_t
-event_timeout=
_remaining(struct event_timeout *et)
+event_timeout_remaining(const struct =
event_timeout *et)
 {
     return (interval_t)((et->last + et->n) - now);
 =
}
diff --git a/src/openvpn/list=2Ec b/src/openvpn/list=2Ec
index e51dcd0=2E=
=2Edcd59d7 100644
--- a/src/openvpn/list=2Ec
+++ b/src/openvpn/list=2Ec
@@ =
-164,7 +164,7 @@
 }
 
 void
-hash_remove_by_value(struct hash *hash, void *=
value)
+hash_remove_by_value(struct hash *hash, const void *value)
 {
     =
struct hash_iterator hi;
     const struct hash_element *he;
diff --git a/s=
rc/openvpn/list=2Eh b/src/openvpn/list=2Eh
index 55bc3c8=2E=2E23267d0 10064=
4
--- a/src/openvpn/list=2Eh
+++ b/src/openvpn/list=2Eh
@@ -78,7 +78,7 @@
 =

 bool hash_remove_fast(struct hash *hash, struct hash_bucket *bucket, cons=
t void *key, uint64_t hv);
 
-void hash_remove_by_value(struct hash *hash, =
void *value);
+void hash_remove_by_value(struct hash *hash, const void *val=
ue);
 
 struct hash_iterator
 {
diff --git a/src/openvpn/manage=2Ec b/src/o=
penvpn/manage=2Ec
index 0aef2d4=2E=2E1e74f09 100644
--- a/src/openvpn/manag=
e=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -330,7 +330,7 @@
 }
 
 static void
-m=
an_delete_unix_socket(struct management *man)
+man_delete_unix_socket(const=
 struct management *man)
 {
 #if UNIX_SOCK_SUPPORT
     if ((man->settings=
=2Eflags & (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)
@@ -=
676,7 +676,7 @@
  * for the log and echo commands=2E
  */
 static void
-man=
_history(struct management *man, const char *parm, const char *type, struct=
 log_history *log,
+man_history(struct management *man, const char *parm, c=
onst char *type, const struct log_history *log,
             bool *realtime=
, const unsigned int lep_flags)
 {
     struct gc_arena gc =3D gc_new();
@@=
 -852,7 +852,7 @@
 }
 
 static void
-man_net(struct management *man)
+man_n=
et(const struct management *man)
 {
     if (man->persist=2Ecallback=2Eshow=
_net)
     {
@@ -888,7 +888,7 @@
 #ifdef ENABLE_PKCS11
 
 static void
-man_=
pkcs11_id_count(struct management *man)
+man_pkcs11_id_count(const struct m=
anagement *man)
 {
     msg(M_CLIENT, ">PKCS11ID-COUNT:%d", pkcs11_manageme=
nt_id_count());
 }
@@ -2366,7 +2366,7 @@
  * the route/ifconfig/open tun co=
mmand=2E   See doc/android=2Etxt for details=2E
  */
 bool
-management_andr=
oid_control(struct management *man, const char *command, const char *msg)
+=
management_android_control(const struct management *man, const char *comman=
d, const char *msg)
 {
     if (!man)
     {
@@ -3013,7 +3013,7 @@
 }
 
 vo=
id
-management_up_down(struct management *man, const char *updown, const st=
ruct env_set *es)
+management_up_down(const struct management *man, const c=
har *updown, const struct env_set *es)
 {
     if (man->settings=2Eflags & =
MF_UP_DOWN)
     {
@@ -3208,7 +3208,7 @@
 }
 
 void
-management_auth_failur=
e(struct management *man, const char *type, const char *reason)
+management=
_auth_failure(const struct management *man, const char *type, const char *r=
eason)
 {
     if (reason)
     {
diff --git a/src/openvpn/manage=2Eh b/src=
/openvpn/manage=2Eh
index 1e7855d=2E=2Ef2c6916 100644
--- a/src/openvpn/man=
age=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -368,7 +368,7 @@
                  =
               const unsigned int flags, const char *static_challenge);
 
 =
#ifdef TARGET_ANDROID
-bool management_android_control(struct management *m=
an, const char *command, const char *msg);
+bool management_android_control=
(const struct management *man, const char *command, const char *msg);
 
 #d=
efine ANDROID_KEEP_OLD_TUN      1
 #define ANDROID_OPEN_BEFORE_CLOSE 2
@@ -=
382,7 +382,7 @@
 
 void management_event_loop_n_seconds(struct management *=
man, int sec);
 
-void management_up_down(struct management *man, const cha=
r *updown, const struct env_set *es);
+void management_up_down(const struct=
 management *man, const char *updown, const struct env_set *es);
 
 void ma=
nagement_notify(const char *severity, const char *type,
                   =
     const char *text);
@@ -482,7 +482,7 @@
  * OpenVPN calls here to indic=
ate a password failure
  */
 
-void management_auth_failure(struct manageme=
nt *man, const char *type, const char *reason);
+void management_auth_failu=
re(const struct management *man, const char *type, const char *reason);
 
 =
/*
  * Echo an authentication token to management interface
diff --git a/sr=
c/openvpn/mbuf=2Ec b/src/openvpn/mbuf=2Ec
index 5bb397f=2E=2E163251c 100644=

--- a/src/openvpn/mbuf=2Ec
+++ b/src/openvpn/mbuf=2Ec
@@ -165,7 +165,7 @@
=
 }
 
 void
-mbuf_dereference_instance(struct mbuf_set *ms, struct multi_ins=
tance *mi)
+mbuf_dereference_instance(struct mbuf_set *ms, const struct mul=
ti_instance *mi)
 {
     if (ms)
     {
diff --git a/src/openvpn/mbuf=2Eh b=
/src/openvpn/mbuf=2Eh
index cfe698c=2E=2Ee368054 100644
--- a/src/openvpn/m=
buf=2Eh
+++ b/src/openvpn/mbuf=2Eh
@@ -75,7 +75,7 @@
 
 bool mbuf_extract_i=
tem(struct mbuf_set *ms, struct mbuf_item *item);
 
-void mbuf_dereference_=
instance(struct mbuf_set *ms, struct multi_instance *mi);
+void mbuf_derefe=
rence_instance(struct mbuf_set *ms, const struct multi_instance *mi);
 
 st=
atic inline bool
 mbuf_defined(const struct mbuf_set *ms)
diff --git a/src/=
openvpn/mss=2Ec b/src/openvpn/mss=2Ec
index 36bbb43=2E=2E0cfa272d 100644
--=
- a/src/openvpn/mss=2Ec
+++ b/src/openvpn/mss=2Ec
@@ -239,8 +239,8 @@
 }
 
=
 static void
-frame_calculate_fragment(struct frame *frame, struct key_type=
 *kt, const struct options *options,
-                         struct link_=
socket_info *lsi)
+frame_calculate_fragment(struct frame *frame, const stru=
ct key_type *kt, const struct options *options,
+                         c=
onst struct link_socket_info *lsi)
 {
 #if defined(ENABLE_FRAGMENT)
     si=
ze_t overhead;
@@ -269,8 +269,8 @@
 }
 
 static void
-frame_calculate_mssfi=
x(struct frame *frame, struct key_type *kt, const struct options *options,
=
-                       struct link_socket_info *lsi)
+frame_calculate_mssf=
ix(struct frame *frame, const struct key_type *kt, const struct options *op=
tions,
+                       const struct link_socket_info *lsi)
 {
     =
if (options->ce=2Emssfix_fixed)
     {
@@ -314,8 +314,8 @@
 }
 
 void
-fram=
e_calculate_dynamic(struct frame *frame, struct key_type *kt, const struct =
options *options,
-                        struct link_socket_info *lsi)
+f=
rame_calculate_dynamic(struct frame *frame, const struct key_type *kt, cons=
t struct options *options,
+                        const struct link_socke=
t_info *lsi)
 {
     if (options->ce=2Efragment > 0)
     {
diff --git a/sr=
c/openvpn/mss=2Eh b/src/openvpn/mss=2Eh
index 1d092bb=2E=2E2eab55a 100644
-=
-- a/src/openvpn/mss=2Eh
+++ b/src/openvpn/mss=2Eh
@@ -36,8 +36,8 @@
 void =
mss_fixup_dowork(struct buffer *buf, uint16_t maxmss);
 
 /** Set the --mss=
fix option=2E */
-void frame_calculate_dynamic(struct frame *frame, struct =
key_type *kt,
-                             const struct options *options, =
struct link_socket_info *lsi);
+void frame_calculate_dynamic(struct frame *=
frame, const struct key_type *kt,
+                             const struc=
t options *options, const struct link_socket_info *lsi);
 
 /**
  * Checks =
and adjusts the fragment and mssfix value according to the
diff --git a/src=
/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
index 4d173c4=2E=2Ec744638 100644
=
--- a/src/openvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -67,7 +67,7 @@
 }
=
 
 bool
-multi_tcp_instance_specific_init(struct multi_context *m, struct m=
ulti_instance *mi)
+multi_tcp_instance_specific_init(const struct multi_con=
text *m, struct multi_instance *mi)
 {
     /* buffer for queued TCP socket=
 output packets */
     mi->tcp_link_out_deferred =3D mbuf_init(m->top=2Eop=
tions=2En_bcast_buf);
diff --git a/src/openvpn/mtcp=2Eh b/src/openvpn/mtcp=
=2Eh
index 9b7d1d2=2E=2Ebb117fa 100644
--- a/src/openvpn/mtcp=2Eh
+++ b/src=
/openvpn/mtcp=2Eh
@@ -35,7 +35,7 @@
 
 void multi_tcp_dereference_instance(=
struct multi_io *multi_io, struct multi_instance *mi);
 
-bool multi_tcp_in=
stance_specific_init(struct multi_context *m, struct multi_instance *mi);
+=
bool multi_tcp_instance_specific_init(const struct multi_context *m, struct=
 multi_instance *mi);
 
 void multi_tcp_instance_specific_free(struct multi=
_instance *mi);
 
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
=
index 69e30e5=2E=2E201d756 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/open=
vpn/mudp=2Ec
@@ -54,8 +54,9 @@
  * @param sock    the socket to send the re=
ply on
  */
 static void
-send_standalone_reply(struct multi_context *m, st=
ruct buffer *buf, const char *prefix,
-                      const char *de=
tail, struct link_socket *sock)
+send_standalone_reply(struct multi_context=
 *m, const struct buffer *buf,
+                      const char *prefix, c=
onst char *detail,
+                      struct link_socket *sock)
 {
    =
 struct context *c =3D &m->top;
 
@@ -75,7 +76,7 @@
 
 static void
 send_hm=
ac_reset_packet(struct multi_context *m, struct tls_pre_decrypt_state *stat=
e,
-                       struct tls_auth_standalone *tas, struct session_=
id *sid,
+                       const struct tls_auth_standalone *tas, con=
st struct session_id *sid,
                        bool request_resend_wkc,=
 struct link_socket *sock)
 {
     reset_packet_id_send(&state->tls_wrap_tm=
p=2Eopt=2Epacket_id=2Esend);
@@ -117,11 +118,11 @@
 
     enum first_packet=
_verdict verdict;
 
-    struct tls_auth_standalone *tas =3D m->top=2Ec2=2E=
tls_auth_standalone;
+    const struct tls_auth_standalone *tas =3D m->top=
=2Ec2=2Etls_auth_standalone;
 
     verdict =3D tls_pre_decrypt_lite(tas, s=
tate, &m->top=2Ec2=2Efrom, &m->top=2Ec2=2Ebuf);
 
-    uint8_t *hmac_key =
=3D m->top=2Ec2=2Esession_id_key;
+    const uint8_t *hmac_key =3D m->top=
=2Ec2=2Esession_id_key;
     const struct openvpn_sockaddr *from =3D &m->to=
p=2Ec2=2Efrom=2Edest;
     int handwindow =3D m->top=2Eoptions=2Ehandshake_=
window;
 
@@ -240,7 +241,7 @@
 static struct multi_instance *
 handle_conne=
ction_attempt(struct multi_context *m,
                           struct li=
nk_socket *sock,
-                          struct mroute_addr *real)
+    =
                      const struct mroute_addr *real)
 {
     struct gc_are=
na gc =3D gc_new();
 
@@ -308,7 +309,7 @@
  * @return      instance matchin=
g the address, NULL otherwise
  */
 static struct multi_instance *
-multi_g=
et_instance_udp_real(struct multi_context *m, struct mroute_addr *real)
+mu=
lti_get_instance_udp_real(struct multi_context *m, const struct mroute_addr=
 *real)
 {
     struct hash *hash =3D m->hash;
     const uint64_t hv =3D h=
ash_value(hash, real);
@@ -353,7 +354,9 @@
  * maintaining real address has=
h table atomicity=2E
  */
 struct multi_instance *
-multi_get_instance_udp_=
data(struct multi_context *m, bool *floated, struct mroute_addr *real, stru=
ct link_socket *sock)
+multi_get_instance_udp_data(struct multi_context *m,=
 bool *floated,
+                            const struct mroute_addr *real=
,
+                            const struct link_socket *sock)
 {
     stru=
ct multi_instance *mi =3D NULL;
 
diff --git a/src/openvpn/multi=2Ec b/src/=
openvpn/multi=2Ec
index dda9232=2E=2Ea2cfdbf 100644
--- a/src/openvpn/multi=
=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -58,7 +58,7 @@
 
 #ifdef MULTI_DEBUG_EV=
ENT_LOOP
 static const char *
-id(struct multi_instance *mi)
+id(const stru=
ct multi_instance *mi)
 {
     if (mi)
     {
@@ -1336,7 +1336,7 @@
  * sam=
e common name=2E
  */
 static void
-multi_delete_dup(struct multi_context *=
m, struct multi_instance *new_mi)
+multi_delete_dup(struct multi_context *m=
, const struct multi_instance *new_mi)
 {
     if (new_mi)
     {
@@ -2281,=
7 +2281,7 @@
 }
 
 static bool
-multi_client_setup_dco_initial(struct multi=
_context *m, struct multi_instance *mi,
+multi_client_setup_dco_initial(con=
st struct multi_context *m, struct multi_instance *mi,
                    =
            struct gc_arena *gc)
 {
     if (!dco_enabled(&mi->context=2Eop=
tions))
@@ -2479,7 +2479,7 @@
 }
 
 static bool
-multi_check_dest_addr_allo=
wed(struct multi_context *m, struct multi_instance *mi, struct mroute_addr =
*real);
+multi_check_dest_addr_allowed(struct multi_context *m, struct mult=
i_instance *mi, const struct mroute_addr *real);
 
 /**
  * This sets up th=
e client real address (outer tunnel addr) in the
@@ -3130,7 +3130,8 @@
  * =
positive=2E
  */
 static bool
-multi_check_dest_addr_allowed(struct multi_c=
ontext *m, struct multi_instance *mi, struct mroute_addr *real)
+multi_chec=
k_dest_addr_allowed(struct multi_context *m, struct multi_instance *mi,
+  =
                            const struct mroute_addr *real)
 {
     struct =
hash *hash =3D m->hash;
     const uint64_t hv =3D hash_value(hash, real);
=
@@ -3289,7 +3290,7 @@
 
 #if defined(ENABLE_DCO)
 static void
-process_inco=
ming_del_peer(struct multi_context *m, struct multi_instance *mi, dco_conte=
xt_t *dco)
+process_incoming_del_peer(struct multi_context *m, struct multi=
_instance *mi, const dco_context_t *dco)
 {
     const char *reason =3D "ov=
pn-dco: unknown reason";
     switch (dco->dco_del_peer_reason)
@@ -4342,7 =
+4343,7 @@
 
 /* Searches for the address and deletes it if it is owned by =
the multi_instance */
 static void
-multi_unlearn_addr(struct multi_context=
 *m, struct multi_instance *mi, const struct mroute_addr *addr)
+multi_unle=
arn_addr(struct multi_context *m, const struct multi_instance *mi, const st=
ruct mroute_addr *addr)
 {
     struct hash_element *he;
     const uint64_=
t hv =3D hash_value(m->vhash, addr);
@@ -4377,7 +4378,7 @@
  * @param a    =
 The new IPv4 address in network byte order
  */
 static void
-multi_unlear=
n_in_addr_t(struct multi_context *m, struct multi_instance *mi, in_addr_t a=
)
+multi_unlearn_in_addr_t(struct multi_context *m, const struct multi_inst=
ance *mi, in_addr_t a)
 {
     struct mroute_addr addr;
     CLEAR(addr);
@=
@ -4395,7 +4396,7 @@
  * @param a6    The new IPv6 address
  */
 static voi=
d
-multi_unlearn_in6_addr(struct multi_context *m, struct multi_instance *m=
i, struct in6_addr a6)
+multi_unlearn_in6_addr(struct multi_context *m, con=
st struct multi_instance *mi, struct in6_addr a6)
 {
     struct mroute_add=
r addr;
     CLEAR(addr);
diff --git a/src/openvpn/multi=2Eh b/src/openvpn/=
multi=2Eh
index c424ad3=2E=2E5db7147 100644
--- a/src/openvpn/multi=2Eh
+++=
 b/src/openvpn/multi=2Eh
@@ -529,7 +529,7 @@
  */
 
 static inline void
-se=
t_prefix(struct multi_instance *mi)
+set_prefix(const struct multi_instance=
 *mi)
 {
 #ifdef MULTI_DEBUG_EVENT_LOOP
     if (mi->msg_prefix[0])
diff --=
git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec
index 348e424=2E=
=2Ebb5dde58 100644
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi_i=
o=2Ec
@@ -159,7 +159,7 @@
  * a point-to-multipoint tunnel=2E
  */
 static =
unsigned int
-p2mp_iow_flags(const struct multi_context *m, struct link_soc=
ket *sock)
+p2mp_iow_flags(const struct multi_context *m, const struct link=
_socket *sock)
 {
     unsigned int flags =3D IOW_WAIT_SIGNAL;
 
diff --git=
 a/src/openvpn/networking=2Eh b/src/openvpn/networking=2Eh
index bce0c19=2E=
=2E25233c8 100644
--- a/src/openvpn/networking=2Eh
+++ b/src/openvpn/networ=
king=2Eh
@@ -44,7 +44,7 @@
  */
 #if !defined(ENABLE_IPROUTE)
 static inlin=
e int
-net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)
+net_ctx_ini=
t(const struct context *c, openvpn_net_ctx_t *ctx)
 {
     (void)c;
     (v=
oid)ctx;
@@ -75,7 +75,7 @@
  *
  * @return          0 on success, a negativ=
e error code otherwise
  */
-int net_ctx_init(struct context *c, openvpn_ne=
t_ctx_t *ctx);
+int net_ctx_init(const struct context *c, openvpn_net_ctx_t=
 *ctx);
 
 /**
  * Release resources allocated by the internal garbage coll=
ector
@@ -102,7 +102,7 @@
  * @return          0 on success, negative error=
 code on error
  */
 int net_iface_new(openvpn_net_ctx_t *ctx, const openvp=
n_net_iface_t *iface, const char *type,
-                  void *arg);
+   =
               const void *arg);
 
 /**
  * Retrieve the interface type
dif=
f --git a/src/openvpn/networking_iproute2=2Ec b/src/openvpn/networking_ipro=
ute2=2Ec
index a1f3525=2E=2Ef091fb3 100644
--- a/src/openvpn/networking_ipr=
oute2=2Ec
+++ b/src/openvpn/networking_iproute2=2Ec
@@ -36,7 +36,7 @@
 #inc=
lude <netinet/in=2Eh>
 
 int
-net_ctx_init(struct context *c, openvpn_net_c=
tx_t *ctx)
+net_ctx_init(const struct context *c, openvpn_net_ctx_t *ctx)
 =
{
     ctx->es =3D NULL;
     if (c)
@@ -61,7 +61,7 @@
 }
 
 int
-net_iface=
_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type, void *arg=
)
+net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *typ=
e, const void *arg)
 {
     struct argv argv =3D argv_new();
 
diff --git a=
/src/openvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec
index =
83915db=2E=2E49de664 100644
--- a/src/openvpn/networking_sitnl=2Ec
+++ b/sr=
c/openvpn/networking_sitnl=2Ec
@@ -1007,7 +1007,7 @@
 }
 
 static int
-sitn=
l_addr_del(sa_family_t af_family, const char *iface, inet_address_t *addr, =
int prefixlen)
+sitnl_addr_del(sa_family_t af_family, const char *iface, co=
nst inet_address_t *addr, int prefixlen)
 {
     int ifindex;
 
@@ -1250,8 =
+1250,8 @@
 }
 
 static int
-sitnl_route_del(const char *iface, sa_family_t=
 af_family, inet_address_t *dst, int prefixlen,
-                inet_addre=
ss_t *gw, uint32_t table, int metric)
+sitnl_route_del(const char *iface, s=
a_family_t af_family, const inet_address_t *dst, int prefixlen,
+          =
      const inet_address_t *gw, uint32_t table, int metric)
 {
     int ifi=
ndex =3D 0;
 
@@ -1328,7 +1328,7 @@
 
 
 int
-net_iface_new(openvpn_net_ctx=
_t *ctx, const char *iface, const char *type, void *arg)
+net_iface_new(ope=
nvpn_net_ctx_t *ctx, const char *iface, const char *type, const void *arg)
=
 {
     struct sitnl_link_req req =3D {};
     int ret =3D -1;
diff --git a=
/src/openvpn/occ=2Eh b/src/openvpn/occ=2Eh
index bda4f18=2E=2E49def4d 10064=
4
--- a/src/openvpn/occ=2Eh
+++ b/src/openvpn/occ=2Eh
@@ -156,7 +156,7 @@
 =
 * via control channel=2E
  * @return control channel exit message should b=
e used */
 static inline bool
-cc_exit_notify_enabled(struct context *c)
+c=
c_exit_notify_enabled(const struct context *c)
 {
     /* Check if we have =
TLS active at all */
     if (!c->c2=2Etls_multi)
diff --git a/src/openvpn/=
openssl_compat=2Eh b/src/openvpn/openssl_compat=2Eh
index 098bdd5=2E=2E1a93=
4db 100644
--- a/src/openvpn/openssl_compat=2Eh
+++ b/src/openvpn/openssl_c=
ompat=2Eh
@@ -127,7 +127,7 @@
 /* Mimics the functions but only when the de=
fault context without
  * options is chosen */
 static inline const EVP_CIP=
HER *
-EVP_CIPHER_fetch(void *ctx, const char *algorithm, const char *prope=
rties)
+EVP_CIPHER_fetch(const void *ctx, const char *algorithm, const char=
 *properties)
 {
     ASSERT(!ctx);
     ASSERT(!properties);
@@ -135,7 +13=
5,7 @@
 }
 
 static inline const EVP_MD *
-EVP_MD_fetch(void *ctx, const ch=
ar *algorithm, const char *properties)
+EVP_MD_fetch(const void *ctx, const=
 char *algorithm, const char *properties)
 {
     ASSERT(!ctx);
     ASSERT=
(!properties);
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=
=2Ec
index 6664c73=2E=2Ee7585ad 100644
--- a/src/openvpn/options=2Ec
+++ b/=
src/openvpn/options=2Ec
@@ -2429,7 +2429,7 @@
 }
 
 static void
-options_po=
stprocess_mutate_le(struct connection_entry *ce, struct local_entry *le, in=
t mode)
+options_postprocess_mutate_le(const struct connection_entry *ce, s=
truct local_entry *le, int mode)
 {
     /* use the global port if none is =
specified */
     if (!le->port)
@@ -3589,7 +3589,7 @@
 static bool
 verify=
_permission(const char *name, const char *file, int line, const uint64_t ty=
pe,
                   const uint64_t allowed, uint64_t *found, const msglv=
l_t msglevel,
-                  struct options *options, bool is_inline)
+=
                  const struct options *options, bool is_inline)
 {
     if=
 (!(type & allowed))
     {
@@ -3665,7 +3665,7 @@
 }
 
 static inline msglv=
l_t
-msglevel_forward_compatible(struct options *options, const msglvl_t ms=
glevel)
+msglevel_forward_compatible(const struct options *options, const m=
sglvl_t msglevel)
 {
     return options->forward_compatible ? M_WARN : msg=
level;
 }
@@ -4154,7 +4154,7 @@
 }
 
 static void
-show_compression_warning=
(struct compress_options *info)
+show_compression_warning(const struct comp=
ress_options *info)
 {
     if (comp_non_stub_enabled(info))
     {
diff --=
git a/src/openvpn/options_parse=2Ec b/src/openvpn/options_parse=2Ec
index 1=
2934ab=2E=2E79b8098 100644
--- a/src/openvpn/options_parse=2Ec
+++ b/src/op=
envpn/options_parse=2Ec
@@ -258,7 +258,7 @@
 }
 
 static char *
-read_inlin=
e_file(struct in_src *is, const char *close_tag, int *num_lines, struct gc_=
arena *gc)
+read_inline_file(const struct in_src *is, const char *close_tag=
, int *num_lines, struct gc_arena *gc)
 {
     char line[OPTION_LINE_SIZE];=

     struct buffer buf =3D alloc_buf(8 * OPTION_LINE_SIZE);
@@ -302,7 +302=
,7 @@
 }
 
 static int
-check_inline_file(struct in_src *is, char *p[], str=
uct gc_arena *gc)
+check_inline_file(const struct in_src *is, char *p[], st=
ruct gc_arena *gc)
 {
     int num_inline_lines =3D 0;
 
diff --git a/src/o=
penvpn/otime=2Ec b/src/openvpn/otime=2Ec
index 1608458=2E=2E5d3633c 100644
=
--- a/src/openvpn/otime=2Ec
+++ b/src/openvpn/otime=2Ec
@@ -66,7 +66,7 @@
 =
}
 
 void
-update_now_usec(struct timeval *tv)
+update_now_usec(const struc=
t timeval *tv)
 {
     const time_t last =3D now;
     update_now(tv->tv_se=
c);
diff --git a/src/openvpn/otime=2Eh b/src/openvpn/otime=2Eh
index d14f01=
e=2E=2E74d21ff 100644
--- a/src/openvpn/otime=2Eh
+++ b/src/openvpn/otime=
=2Eh
@@ -65,7 +65,7 @@
 void update_now(const time_t system_time);
 
 exter=
n time_t now_usec;
-void update_now_usec(struct timeval *tv);
+void update_=
now_usec(const struct timeval *tv);
 
 static inline int
 openvpn_gettimeof=
day(struct timeval *tv, void *tz)
diff --git a/src/openvpn/proto=2Eh b/src/=
openvpn/proto=2Eh
index 9bb0866=2E=2E1665751 100644
--- a/src/openvpn/proto=
=2Eh
+++ b/src/openvpn/proto=2Eh
@@ -248,7 +248,7 @@
  * and offset of IP h=
eader (via parameter)=2E
  */
 static inline int
-get_tun_ip_ver(int tunnel=
_type, struct buffer *buf, int *ip_hdr_offset)
+get_tun_ip_ver(int tunnel_t=
ype, const struct buffer *buf, int *ip_hdr_offset)
 {
     int ip_ver =3D -=
1;
 
diff --git a/src/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec
index 74a6c=
f9=2E=2Ec3ad7de 100644
--- a/src/openvpn/proxy=2Ec
+++ b/src/openvpn/proxy=
=2Ec
@@ -527,8 +527,9 @@
 }
 
 static bool
-add_proxy_headers(struct http_p=
roxy_info *p, socket_descriptor_t sd, /* already open to proxy */
-        =
          const char *host                                   /* openvpn ser=
ver remote */
+add_proxy_headers(const struct http_proxy_info *p,
+        =
          socket_descriptor_t sd, /* already open to proxy */
+            =
      const char *host        /* openvpn server remote */
 )
 {
     char b=
uf[512];
@@ -597,8 +598,8 @@
                               socket_descript=
or_t sd, /* already open to proxy */
                               const c=
har *host,       /* openvpn server remote */
                              =
 const char *port,       /* openvpn server port */
-                       =
       struct event_timeout *server_poll_timeout, struct buffer *lookahead,=

-                              struct signal_info *sig_info)
+            =
                  const struct event_timeout *server_poll_timeout,
+       =
                       struct buffer *lookahead, struct signal_info *sig_in=
fo)
 {
     struct gc_arena gc =3D gc_new();
     char buf[512];
diff --git=
 a/src/openvpn/proxy=2Eh b/src/openvpn/proxy=2Eh
index e662e7d=2E=2Ea2f4e47=
 100644
--- a/src/openvpn/proxy=2Eh
+++ b/src/openvpn/proxy=2Eh
@@ -89,7 +8=
9,7 @@
                                    socket_descriptor_t sd, /* alrea=
dy open to proxy */
                                    const char *host,  =
     /* openvpn server remote */
                                    const =
char *port,       /* openvpn server port */
-                              =
     struct event_timeout *server_poll_timeout,
+                          =
         const struct event_timeout *server_poll_timeout,
                 =
                   struct buffer *lookahead, struct signal_info *sig_info);=

 
 uint8_t *make_base64_string2(const uint8_t *str, int str_len, struct gc=
_arena *gc);
diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec
index 08c=
2673=2E=2E2679c4d5 100644
--- a/src/openvpn/ps=2Ec
+++ b/src/openvpn/ps=2Ec=

@@ -334,7 +334,7 @@
  * the proxy can determine true client origin=2E
  */=

 static void
-journal_add(const char *journal_dir, struct proxy_connection=
 *pc, struct proxy_connection *cp)
+journal_add(const char *journal_dir, co=
nst struct proxy_connection *pc, struct proxy_connection *cp)
 {
     struc=
t openvpn_sockaddr from, to;
 
@@ -412,7 +412,7 @@
 static bool
 proxy_entr=
y_new(struct proxy_connection **list, struct event_set *es,
               =
  const struct openvpn_sockaddr server_addr, const socket_descriptor_t sd_c=
lient,
-                struct buffer *initial_data, const char *journal_di=
r)
+                const struct buffer *initial_data, const char *journal_=
dir)
 {
     socket_descriptor_t sd_server;
     int status;
@@ -1015,7 +10=
15,7 @@
  * call=2E
  */
 void
-port_share_redirect(struct port_share *ps, =
const struct buffer *head, socket_descriptor_t sd)
+port_share_redirect(con=
st struct port_share *ps, const struct buffer *head, socket_descriptor_t sd=
)
 {
     if (ps)
     {
diff --git a/src/openvpn/ps=2Eh b/src/openvpn/ps=
=2Eh
index 557ecf5=2E=2E918ceb6 100644
--- a/src/openvpn/ps=2Eh
+++ b/src/o=
penvpn/ps=2Eh
@@ -49,7 +49,7 @@
 
 bool is_openvpn_protocol(const struct bu=
ffer *buf);
 
-void port_share_redirect(struct port_share *ps, const struct=
 buffer *head, socket_descriptor_t sd);
+void port_share_redirect(const str=
uct port_share *ps, const struct buffer *head, socket_descriptor_t sd);
 
 =
#endif /* if PORT_SHARE */
 #endif /* ifndef PS_H */
diff --git a/src/openv=
pn/push=2Ec b/src/openvpn/push=2Ec
index 0e281d2=2E=2E8dfe0d5 100644
--- a/=
src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -430,7 +430,7 @@
 }
 
 b=
ool
-send_auth_pending_messages(struct tls_multi *tls_multi, struct tls_ses=
sion *session,
+send_auth_pending_messages(const struct tls_multi *tls_mult=
i, struct tls_session *session,
                            const char *ext=
ra, unsigned int timeout)
 {
     struct key_state *ks =3D &session->key[KS=
_PRIMARY];
diff --git a/src/openvpn/push=2Eh b/src/openvpn/push=2Eh
index d=
ff945f=2E=2E39302f6 100644
--- a/src/openvpn/push=2Eh
+++ b/src/openvpn/pus=
h=2Eh
@@ -117,7 +117,7 @@
  * doc/management-notes=2Etxt under client-pendi=
ng-auth for
  * more details on message format
  */
-bool send_auth_pending=
_messages(struct tls_multi *tls_multi, struct tls_session *session,
+bool s=
end_auth_pending_messages(const struct tls_multi *tls_multi, struct tls_ses=
sion *session,
                                 const char *extra, unsigned=
 int timeout);
 
 void send_restart(struct context *c, const char *kill_msg=
);
diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec
index=
 0213041=2E=2E7fa5987 100644
--- a/src/openvpn/push_util=2Ec
+++ b/src/open=
vpn/push_util=2Ec
@@ -222,7 +222,7 @@
 
 /* Return true if the client suppo=
rts push-update */
 static bool
-support_push_update(struct multi_instance =
*mi)
+support_push_update(const struct multi_instance *mi)
 {
     ASSERT(m=
i->context=2Ec2=2Etls_multi);
     const unsigned int iv_proto_peer =3D ext=
ract_iv_proto(mi->context=2Ec2=2Etls_multi->peer_info);
diff --git a/src/op=
envpn/reliable=2Ec b/src/openvpn/reliable=2Ec
index c268cce=2E=2E7b5b17c 10=
0644
--- a/src/openvpn/reliable=2Ec
+++ b/src/openvpn/reliable=2Ec
@@ -59,7=
 +59,7 @@
 
 /* check if a particular packet_id is present in ack */
 stati=
c inline bool
-reliable_ack_packet_id_present(struct reliable_ack *ack, pac=
ket_id_type pid)
+reliable_ack_packet_id_present(const struct reliable_ack =
*ack, packet_id_type pid)
 {
     for (int i =3D 0; i < ack->len; ++i)
    =
 {
@@ -752,7 +752,7 @@
  */
 
 void
-reliable_mark_active_incoming(struct r=
eliable *rel, struct buffer *buf, packet_id_type pid,
+reliable_mark_active=
_incoming(struct reliable *rel, const struct buffer *buf, packet_id_type pi=
d,
                               int opcode)
 {
     for (int i =3D 0; i <=
 rel->size; ++i)
@@ -812,7 +812,7 @@
 
 /* delete a buffer previously activ=
ated by reliable_mark_active() */
 void
-reliable_mark_deleted(struct relia=
ble *rel, struct buffer *buf)
+reliable_mark_deleted(struct reliable *rel, =
const struct buffer *buf)
 {
     for (int i =3D 0; i < rel->size; ++i)
   =
  {
diff --git a/src/openvpn/reliable=2Eh b/src/openvpn/reliable=2Eh
index =
534feb3=2E=2E7b6fced 100644
--- a/src/openvpn/reliable=2Eh
+++ b/src/openvp=
n/reliable=2Eh
@@ -184,7 +184,7 @@
  * @li False, if there are packet IDs t=
o be acknowledged=2E
  */
 static inline bool
-reliable_ack_empty(struct re=
liable_ack *ack)
+reliable_ack_empty(const struct reliable_ack *ack)
 {
   =
  return !ack->len;
 }
@@ -213,7 +213,7 @@
  * @returns the number of outst=
anding acks
  */
 static inline int
-reliable_ack_outstanding(struct reliab=
le_ack *ack)
+reliable_ack_outstanding(const struct reliable_ack *ack)
 {
 =
    return ack->len;
 }
@@ -369,7 +369,7 @@
  * @param pid The packet's pac=
ket ID=2E
  * @param opcode The packet's opcode=2E
  */
-void reliable_mark=
_active_incoming(struct reliable *rel, struct buffer *buf, packet_id_type p=
id,
+void reliable_mark_active_incoming(struct reliable *rel, const struct =
buffer *buf, packet_id_type pid,
                                    int op=
code);
 
 /**
@@ -422,7 +422,7 @@
  * @param rel The reliable structure ass=
ociated with the given buffer=2E
  * @param buf The buffer of the reliable =
entry which is to be removed=2E
  */
-void reliable_mark_deleted(struct rel=
iable *rel, struct buffer *buf);
+void reliable_mark_deleted(struct reliabl=
e *rel, const struct buffer *buf);
 
 /** @} name Functions for extracting =
incoming packets */
 
diff --git a/src/openvpn/route=2Ec b/src/openvpn/rout=
e=2Ec
index 33b2387=2E=2E4830a5b 100644
--- a/src/openvpn/route=2Ec
+++ b/s=
rc/openvpn/route=2Ec
@@ -898,8 +898,9 @@
 }
 
 static bool
-add_bypass_rout=
es(struct route_bypass *rb, in_addr_t gateway, const struct tuntap *tt,
-  =
                unsigned int flags, const struct route_gateway_info *rgi,
+=
add_bypass_routes(const struct route_bypass *rb, in_addr_t gateway,
+      =
            const struct tuntap *tt, unsigned int flags,
+                 =
 const struct route_gateway_info *rgi,
                   const struct env_=
set *es, openvpn_net_ctx_t *ctx)
 {
     int ret =3D true;
@@ -916,8 +917,9=
 @@
 }
 
 static void
-del_bypass_routes(struct route_bypass *rb, in_addr_t=
 gateway, const struct tuntap *tt,
-                  unsigned int flags, c=
onst struct route_gateway_info *rgi,
+del_bypass_routes(const struct route_=
bypass *rb, in_addr_t gateway,
+                  const struct tuntap *tt, =
unsigned int flags,
+                  const struct route_gateway_info *rgi=
,
                   const struct env_set *es, openvpn_net_ctx_t *ctx)
 {
 =
    int i;
@@ -3939,7 +3941,8 @@
 #else  /* if defined(_WIN32) */
 
 static=
 void
-get_bypass_addresses(struct route_bypass *rb, const unsigned int fla=
gs) /* PLATFORM-SPECIFIC */
+// cppcheck-suppress constParameterPointer ; s=
tub
+get_bypass_addresses(struct route_bypass *rb, const unsigned int flags=
)
 {
 }
 
diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
inde=
x 33def4e=2E=2Edf8e400 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvp=
n/socket=2Ec
@@ -620,7 +620,7 @@
 }
 
 static void
-bind_local(struct link_=
socket *sock)
+bind_local(const struct link_socket *sock)
 {
     /* bind t=
o local address/port */
     if (sock->bind_local)
@@ -916,8 +916,8 @@
 }
 =

 void
-socket_bind(socket_descriptor_t sd, struct addrinfo *local, int ai_=
family, const char *prefix,
-            bool ipv6only)
+socket_bind(socket=
_descriptor_t sd, const struct addrinfo *local, int ai_family,
+           =
 const char *prefix, bool ipv6only)
 {
     struct gc_arena gc =3D gc_new()=
;
 
@@ -1125,8 +1125,8 @@
  * such as TCP=2E
  */
 
-static void stream_buf=
_init(struct stream_buf *sb, struct buffer *buf, const unsigned int sockfla=
gs,
-                            const int proto);
+static void stream_buf_=
init(struct stream_buf *sb, const struct buffer *buf,
+                    =
        const unsigned int sockflags, const int proto);
 
 static void stre=
am_buf_close(struct stream_buf *sb);
 
@@ -1479,7 +1479,7 @@
 }
 
 static v=
oid
-phase2_set_socket_flags(struct link_socket *sock)
+phase2_set_socket_f=
lags(const struct link_socket *sock)
 {
     /* TCP_NODELAY is enabled by d=
efault on every TCP socket; dco-win is
      * skipped as it manages its ow=
n socket */
@@ -2075,7 +2075,7 @@
 }
 
 static void
-stream_buf_init(struct=
 stream_buf *sb, struct buffer *buf, const unsigned int sockflags,
+stream_=
buf_init(struct stream_buf *sb, const struct buffer *buf, const unsigned in=
t sockflags,
                 const int proto)
 {
     sb->buf_init =3D *bu=
f;
@@ -2341,7 +2341,7 @@
 #endif
 
 static ssize_t
-link_socket_read_udp_po=
six_recvmsg(struct link_socket *sock, struct buffer *buf,
+link_socket_read=
_udp_posix_recvmsg(const struct link_socket *sock, struct buffer *buf,
    =
                                struct link_socket_actual *from, socklen_t =
*fromlen)
 {
     struct iovec iov;
@@ -2413,7 +2413,7 @@
 #endif /* if ENA=
BLE_IP_PKTINFO */
 
 ssize_t
-link_socket_read_udp_posix(struct link_socket=
 *sock, struct buffer *buf,
+link_socket_read_udp_posix(const struct link_s=
ocket *sock, struct buffer *buf,
                            struct link_so=
cket_actual *from)
 {
     ssize_t recvlen;
@@ -2476,7 +2476,7 @@
 #if ENAB=
LE_IP_PKTINFO
 
 ssize_t
-link_socket_write_udp_posix_sendmsg(struct link_s=
ocket *sock, struct buffer *buf,
+link_socket_write_udp_posix_sendmsg(const=
 struct link_socket *sock, const struct buffer *buf,
                      =
               struct link_socket_actual *to)
 {
     struct iovec iov;
@@ =
-2672,7 +2672,7 @@
 }
 
 int
-socket_send_queue(struct link_socket *sock, s=
truct buffer *buf, const struct link_socket_actual *to)
+socket_send_queue(=
struct link_socket *sock, const struct buffer *buf, const struct link_socke=
t_actual *to)
 {
     if (sock->writes=2Eiostate =3D=3D IOSTATE_INITIAL)
  =
   {
@@ -2772,8 +2772,8 @@
     return sock->writes=2Eiostate;
 }
 
-void
-=
read_sockaddr_from_overlapped(struct overlapped_io *io, struct sockaddr *ds=
t, int overlapped_ret)
+static void
+read_sockaddr_from_overlapped(const st=
ruct overlapped_io *io, struct sockaddr *dst, int overlapped_ret)
 {
     i=
f (overlapped_ret >=3D 0 && io->addr_defined)
     {
diff --git a/src/openv=
pn/socket=2Eh b/src/openvpn/socket=2Eh
index 46fa29c=2E=2Ecbcdeef 100644
--=
- a/src/openvpn/socket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -268,7 +268,7 @@=

 
 int socket_recv_queue(struct link_socket *sock, int maxsize);
 
-int so=
cket_send_queue(struct link_socket *sock, struct buffer *buf,
+int socket_s=
end_queue(struct link_socket *sock, const struct buffer *buf,
             =
          const struct link_socket_actual *to);
 
 typedef struct
@@ -348,8=
 +348,8 @@
 
 struct link_socket *link_socket_new(void);
 
-void socket_bin=
d(socket_descriptor_t sd, struct addrinfo *local, int af_family, const char=
 *prefix,
-                 bool ipv6only);
+void socket_bind(socket_descri=
ptor_t sd, const struct addrinfo *local, int af_family,
+                 c=
onst char *prefix, bool ipv6only);
 
 int openvpn_connect(socket_descriptor=
_t sd, const struct sockaddr *remote, int connect_timeout,
                =
     volatile int *signal_received);
@@ -496,7 +496,7 @@
 }
 
 static inlin=
e bool
-link_socket_verify_incoming_addr(struct buffer *buf, const struct l=
ink_socket_info *info,
+link_socket_verify_incoming_addr(const struct buffe=
r *buf, const struct link_socket_info *info,
                              =
    const struct link_socket_actual *from_addr)
 {
     if (buf->len > 0)
@=
@ -620,7 +620,7 @@
 
 #else  /* ifdef _WIN32 */
 
-ssize_t link_socket_read=
_udp_posix(struct link_socket *sock, struct buffer *buf,
+ssize_t link_sock=
et_read_udp_posix(const struct link_socket *sock, struct buffer *buf,
     =
                               struct link_socket_actual *from);
 
 #endif =
/* ifdef _WIN32 */
@@ -706,12 +706,12 @@
 
 #else /* ifdef _WIN32 */
 
-ssi=
ze_t link_socket_write_udp_posix_sendmsg(struct link_socket *sock, struct b=
uffer *buf,
+ssize_t link_socket_write_udp_posix_sendmsg(const struct link_=
socket *sock, const struct buffer *buf,
                                   =
          struct link_socket_actual *to);
 
 
 static inline ssize_t
-link_=
socket_write_udp_posix(struct link_socket *sock, struct buffer *buf,
+link_=
socket_write_udp_posix(const struct link_socket *sock, const struct buffer =
*buf,
                             struct link_socket_actual *to)
 {
 #if E=
NABLE_IP_PKTINFO
@@ -727,7 +727,7 @@
 }
 
 static inline ssize_t
-link_sock=
et_write_tcp_posix(struct link_socket *sock, struct buffer *buf)
+link_sock=
et_write_tcp_posix(const struct link_socket *sock, const struct buffer *buf=
)
 {
     return send(sock->sd, CBPTR(buf), BLENZ(buf), MSG_NOSIGNAL);
 }
@=
@ -785,7 +785,7 @@
  * from tunnel packet=2E
  */
 static inline void
-link=
_socket_set_tos(struct link_socket *sock)
+link_socket_set_tos(const struct=
 link_socket *sock)
 {
     if (sock && sock->ptos_defined)
     {
diff --g=
it a/src/openvpn/socket_util=2Eh b/src/openvpn/socket_util=2Eh
index 13f596=
2=2E=2Eadd08ba 100644
--- a/src/openvpn/socket_util=2Eh
+++ b/src/openvpn/s=
ocket_util=2Eh
@@ -439,7 +439,7 @@
 
 
 static inline bool
-addrlist_match_=
proto(const struct openvpn_sockaddr *a1, struct addrinfo *addr_list, const =
int proto)
+addrlist_match_proto(const struct openvpn_sockaddr *a1, const s=
truct addrinfo *addr_list, const int proto)
 {
     return link_socket_prot=
o_connection_oriented(proto) ? addrlist_match(a1, addr_list)
              =
                                           : addrlist_port_match(a1, addr_l=
ist);
diff --git a/src/openvpn/socks=2Ec b/src/openvpn/socks=2Ec
index b84d=
a24=2E=2E0296349 100644
--- a/src/openvpn/socks=2Ec
+++ b/src/openvpn/socks=
=2Ec
@@ -83,7 +83,7 @@
 
 static bool
 socks_proxy_recv_char(uint8_t *c, co=
nst char *name, socket_descriptor_t sd,
-                      struct event=
_timeout *server_poll_timeout,
+                      const struct event_ti=
meout *server_poll_timeout,
                       volatile int *signal_rec=
eived)
 {
     fd_set reads;
@@ -98,8 +98,8 @@
 }
 
 static bool
-socks_use=
rname_password_auth(struct socks_proxy_info *p, socket_descriptor_t sd,
-  =
                           struct event_timeout *server_poll_timeout,
+sock=
s_username_password_auth(const struct socks_proxy_info *p, socket_descripto=
r_t sd,
+                             const struct event_timeout *server_po=
ll_timeout,
                              volatile int *signal_received)
 {=

     char to_send[516];
@@ -157,8 +157,8 @@
 }
 
 static bool
-socks_hands=
hake(struct socks_proxy_info *p, socket_descriptor_t sd,
-                s=
truct event_timeout *server_poll_timeout, volatile int *signal_received)
+s=
ocks_handshake(const struct socks_proxy_info *p, socket_descriptor_t sd,
+ =
               const struct event_timeout *server_poll_timeout, volatile in=
t *signal_received)
 {
     uint8_t buf[2];
     int len =3D 0;
@@ -232,7 +=
232,7 @@
 
 static bool
 recv_socks_reply(socket_descriptor_t sd, struct op=
envpn_sockaddr *addr,
-                 struct event_timeout *server_poll_t=
imeout, volatile int *signal_received)
+                 const struct event=
_timeout *server_poll_timeout, volatile int *signal_received)
 {
     uint8=
_t atyp =3D 0;
     int alen =3D 0;
@@ -334,11 +334,11 @@
 }
 
 void
-estab=
lish_socks_proxy_passthru(struct socks_proxy_info *p,
+establish_socks_prox=
y_passthru(const struct socks_proxy_info *p,
                              =
  socket_descriptor_t sd, /* already open to proxy */
                     =
           const char *host,       /* openvpn server remote */
            =
                    const char *servname,   /* openvpn server port */
-    =
                           struct event_timeout *server_poll_timeout,
+    =
                           const struct event_timeout *server_poll_timeout,=

                                struct signal_info *sig_info)
 {
     char=
 buf[270];
@@ -392,10 +392,10 @@
 }
 
 void
-establish_socks_proxy_udpassoc=
(struct socks_proxy_info *p,
+establish_socks_proxy_udpassoc(const struct s=
ocks_proxy_info *p,
                                socket_descriptor_t ctr=
l_sd, /* already open to proxy */
                                struct op=
envpn_sockaddr *relay_addr,
-                               struct event_ti=
meout *server_poll_timeout,
+                               const struct ev=
ent_timeout *server_poll_timeout,
                                struct si=
gnal_info *sig_info)
 {
     if (!socks_handshake(p, ctrl_sd, server_poll_t=
imeout, &sig_info->signal_received))
diff --git a/src/openvpn/socks=2Eh b/s=
rc/openvpn/socks=2Eh
index caed18c=2E=2E7434bbf 100644
--- a/src/openvpn/so=
cks=2Eh
+++ b/src/openvpn/socks=2Eh
@@ -49,17 +49,17 @@
 
 void socks_proxy=
_close(struct socks_proxy_info *sp);
 
-void establish_socks_proxy_passthru=
(struct socks_proxy_info *p,
+void establish_socks_proxy_passthru(const str=
uct socks_proxy_info *p,
                                     socket_descri=
ptor_t sd, /* already open to proxy */
                                    =
 const char *host,       /* openvpn server remote */
                      =
               const char *servname,   /* openvpn server port */
-         =
                           struct event_timeout *server_poll_timeout,
+    =
                                const struct event_timeout *server_poll_tim=
eout,
                                     struct signal_info *sig_info);
 =

-void establish_socks_proxy_udpassoc(struct socks_proxy_info *p,
+void est=
ablish_socks_proxy_udpassoc(const struct socks_proxy_info *p,
             =
                        socket_descriptor_t ctrl_sd, /* already open to pro=
xy */
                                     struct openvpn_sockaddr *relay_a=
ddr,
-                                    struct event_timeout *server_poll=
_timeout,
+                                    const struct event_timeout *=
server_poll_timeout,
                                     struct signal_inf=
o *sig_info);
 
 void socks_process_incoming_udp(struct buffer *buf, struct=
 link_socket_actual *from);
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/=
ssl=2Ec
index aeec020=2E=2E3594871 100644
--- a/src/openvpn/ssl=2Ec
+++ b/s=
rc/openvpn/ssl=2Ec
@@ -1171,7 +1171,7 @@
 }
 
 struct tls_multi *
-tls_mult=
i_init(struct tls_options *tls_options)
+tls_multi_init(const struct tls_op=
tions *tls_options)
 {
     struct tls_multi *ret;
 
@@ -1212,7 +1212,7 @@
=
  */
 
 struct tls_auth_standalone *
-tls_auth_standalone_init(struct tls_o=
ptions *tls_options, struct gc_arena *gc)
+tls_auth_standalone_init(const s=
truct tls_options *tls_options, struct gc_arena *gc)
 {
     struct tls_aut=
h_standalone *tas;
 
@@ -1631,8 +1631,9 @@
 
 bool
 tls_session_update_cryp=
to_params_do_work(struct tls_multi *multi, struct tls_session *session,
-  =
                                       struct options *options, struct fram=
e *frame,
-                                         struct frame *frame_fra=
gment, struct link_socket_info *lsi,
+                                     =
    const struct options *options, struct frame *frame,
+                  =
                       struct frame *frame_fragment,
+                     =
                    const struct link_socket_info *lsi,
                   =
                       dco_context_t *dco)
 {
     if (session->key[KS_PRIM=
ARY]=2Ecrypto_options=2Ekey_ctx_bi=2Einitialized)
@@ -1704,7 +1705,7 @@
 bo=
ol
 tls_session_update_crypto_params(struct tls_multi *multi, struct tls_se=
ssion *session,
                                  struct options *options, =
struct frame *frame,
-                                 struct frame *frame_=
fragment, struct link_socket_info *lsi,
+                                 s=
truct frame *frame_fragment, const struct link_socket_info *lsi,
          =
                        dco_context_t *dco)
 {
     if (!check_session_ciph=
er(session, options))
@@ -1920,7 +1921,8 @@
 }
 
 static bool
-push_peer_in=
fo_peerid(struct buffer *out, struct tls_multi *multi, struct tls_session *=
session)
+push_peer_info_peerid(struct buffer *out, const struct tls_multi =
*multi,
+                      const struct tls_session *session)
 {
     i=
f (multi->rx_peer_id =3D=3D MAX_PEER_ID || session->opt->dco_enabled)
     =
{
@@ -1955,7 +1957,7 @@
  * @return          true if no error was encounter=
ed
  */
 static bool
-push_peer_info(struct buffer *buf, struct tls_multi *=
multi, struct tls_session *session)
+push_peer_info(struct buffer *buf, con=
st struct tls_multi *multi, struct tls_session *session)
 {
     struct gc_=
arena gc =3D gc_new();
     bool ret =3D false;
@@ -2599,8 +2601,8 @@
 }
 
=
 bool
-session_skip_to_pre_start(struct tls_session *session, struct tls_pr=
e_decrypt_state *state,
-                          struct link_socket_actua=
l *from)
+session_skip_to_pre_start(struct tls_session *session, const stru=
ct tls_pre_decrypt_state *state,
+                          const struct li=
nk_socket_actual *from)
 {
     struct key_state *ks =3D &session->key[KS_P=
RIMARY];
     ks->session_id_remote =3D state->peer_session_id;
@@ -2829,7 =
+2831,7 @@
 
 static bool
 check_outgoing_ciphertext(struct key_state *ks, =
struct tls_session *session,
-                          struct buffer *to_l=
ink, bool *continue_tls_process)
+                          const struct bu=
ffer *to_link, bool *continue_tls_process)
 {
     if (to_link->len)
     {=

@@ -4193,7 +4195,7 @@
 }
 
 void
-tls_post_encrypt(struct tls_multi *multi=
, struct buffer *buf)
+tls_post_encrypt(struct tls_multi *multi, const stru=
ct buffer *buf)
 {
     struct key_state *ks =3D multi->save_ks;
     multi=
->save_ks =3D NULL;
@@ -4324,7 +4326,7 @@
  * into a garbage collectable st=
ring which is returned=2E
  */
 const char *
-protocol_dump(struct buffer *=
buffer, unsigned int flags, struct gc_arena *gc)
+protocol_dump(const struc=
t buffer *buffer, unsigned int flags, struct gc_arena *gc)
 {
     struct b=
uffer out =3D alloc_buf_gc(256, gc);
     struct buffer buf =3D *buffer;
di=
ff --git a/src/openvpn/ssl=2Eh b/src/openvpn/ssl=2Eh
index 5483fbb=2E=2E76c=
3610 100644
--- a/src/openvpn/ssl=2Eh
+++ b/src/openvpn/ssl=2Eh
@@ -166,7 +=
166,7 @@
  *
  * @return A newly allocated and initialized \c tls_multi str=
ucture=2E
  */
-struct tls_multi *tls_multi_init(struct tls_options *tls_op=
tions);
+struct tls_multi *tls_multi_init(const struct tls_options *tls_opt=
ions);
 
 /**
  * Finalize initialization of a \c tls_multi structure=2E
@@=
 -187,7 +187,7 @@
 /*
  * Initialize a standalone tls-auth verification obj=
ect=2E
  */
-struct tls_auth_standalone *tls_auth_standalone_init(struct tl=
s_options *tls_options,
+struct tls_auth_standalone *tls_auth_standalone_in=
it(const struct tls_options *tls_options,
                                 =
                     struct gc_arena *gc);
 
 /**
@@ -373,7 +373,7 @@
  * @=
param multi - The TLS state for this packet's destination VPN tunnel=2E
  *=
 @param buf - The buffer containing the outgoing packet=2E
  */
-void tls_p=
ost_encrypt(struct tls_multi *multi, struct buffer *buf);
+void tls_post_en=
crypt(struct tls_multi *multi, const struct buffer *buf);
 
 /** @} name Fu=
nctions for managing security parameter state for data channel packets */
 =

@@ -463,7 +463,8 @@
  */
 bool tls_session_update_crypto_params(struct tls=
_multi *multi, struct tls_session *session,
                               =
        struct options *options, struct frame *frame,
-                    =
                  struct frame *frame_fragment, struct link_socket_info *ls=
i,
+                                      struct frame *frame_fragment,
+  =
                                    const struct link_socket_info *lsi,
   =
                                    dco_context_t *dco);
 
 /*
@@ -527,7 +5=
28,7 @@
 #define PD_VERBOSE                 (1 << 10)
 #define PD_TLS_CRYPT=
               (1 << 11)
 
-const char *protocol_dump(struct buffer *buffer=
, unsigned int flags, struct gc_arena *gc);
+const char *protocol_dump(cons=
t struct buffer *buffer, unsigned int flags, struct gc_arena *gc);
 
 /*
  =
* debugging code
@@ -566,7 +567,7 @@
 /* Special method to skip the three w=
ay handshake RESET stages=2E This is
  * used by the HMAC code when seeing =
a packet that matches the previous
  * HMAC based stateless server state */=

-bool session_skip_to_pre_start(struct tls_session *session, struct tls_pr=
e_decrypt_state *state,
-                               struct link_socket_=
actual *from);
+bool session_skip_to_pre_start(struct tls_session *session,=
 const struct tls_pre_decrypt_state *state,
+                              =
 const struct link_socket_actual *from);
 
 #endif /* ifndef OPENVPN_SSL_H =
*/
diff --git a/src/openvpn/ssl_backend=2Eh b/src/openvpn/ssl_backend=2Eh
i=
ndex a6d57f2=2E=2E2150d81 100644
--- a/src/openvpn/ssl_backend=2Eh
+++ b/sr=
c/openvpn/ssl_backend=2Eh
@@ -137,7 +137,7 @@
  *
  * @return      true if =
the context is initialised, false if not=2E
  */
-bool tls_ctx_initialised(=
struct tls_root_ctx *ctx);
+bool tls_ctx_initialised(const struct tls_root_=
ctx *ctx);
 
 /**
  * Set any library specific options=2E
diff --git a/src/=
openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index 9983742=2E=2E96=
5ecdb 100644
--- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtl=
s=2Ec
@@ -146,7 +146,7 @@
 }
 
 bool
-tls_ctx_initialised(struct tls_root_c=
tx *ctx)
+tls_ctx_initialised(const struct tls_root_ctx *ctx)
 {
     /* ei=
ther this should be NULL or should be non-null and then have a
      * vali=
d TLS ctx inside as well */
diff --git a/src/openvpn/ssl_openssl=2Ec b/src/=
openvpn/ssl_openssl=2Ec
index 96e90f82=2E=2E7805d43 100644
--- a/src/openvp=
n/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -129,7 +129,7 @@
 }
=
 
 bool
-tls_ctx_initialised(struct tls_root_ctx *ctx)
+tls_ctx_initialised=
(const struct tls_root_ctx *ctx)
 {
     /* either this should be NULL or s=
hould be non-null and then have a
      * valid TLS ctx inside as well */
@=
@ -2025,7 +2025,7 @@
 }
 
 static void
-bio_debug_data(const char *mode, BI=
O *bio, const uint8_t *buf, int len, const char *desc)
+bio_debug_data(cons=
t char *mode, const BIO *bio, const uint8_t *buf, int len, const char *desc=
)
 {
     struct gc_arena gc =3D gc_new();
     if (len > 0)
@@ -2039,7 +20=
39,7 @@
 }
 
 static void
-bio_debug_oc(const char *mode, BIO *bio)
+bio_de=
bug_oc(const char *mode, const BIO *bio)
 {
     open_biofp();
     fprintf=
(biofp, "BIO %s time=3D%" PRIi64 " bio=3D" ptr_format "\n", mode, (int64_t)=
time(NULL),
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
=
index e9afda4=2E=2Ef78782f 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/o=
penvpn/ssl_pkt=2Ec
@@ -119,7 +119,7 @@
  */
 static void
 tls_wrap_control(=
struct tls_wrap_ctx *ctx, uint8_t header, struct buffer *buf,
-            =
     struct session_id *session_id)
+                 const struct session_=
id *session_id)
 {
     if (ctx->mode =3D=3D TLS_WRAP_AUTH || ctx->mode =3D=
=3D TLS_WRAP_NONE)
     {
@@ -403,9 +403,9 @@
 
 
 struct buffer
-tls_reset=
_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,
-   =
                  struct session_id *own_sid, struct session_id *remote_sid=
, uint8_t header,
-                     bool request_resend_wkc)
+tls_reset=
_standalone(struct tls_wrap_ctx *ctx, const struct tls_auth_standalone *tas=
,
+                     const struct session_id *own_sid, const struct sess=
ion_id *remote_sid,
+                     uint8_t header, bool request_rese=
nd_wkc)
 {
     /* Copy buffer here to point at the same data but allow tls=
_wrap_control
      * to potentially change buf to point to another buffer =
without
@@ -490,7 +490,7 @@
 bool
 check_session_hmac_and_pkt_id(struct tls=
_pre_decrypt_state *state,
                               const struct open=
vpn_sockaddr *from,
-                              uint8_t *key,
+         =
                     const uint8_t *key,
                               int=
 handwindow,
                               bool pkt_is_ack)
 {
diff --git =
a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index 03e8930=2E=2E8203=
e4a 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ -=
183,7 +183,7 @@
  * @return              the expected server session id
  *=
/
 bool check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state, =
const struct openvpn_sockaddr *from,
-                                   ui=
nt8_t *key, int handwindow, bool pkt_is_ack);
+                            =
       const uint8_t *key, int handwindow, bool pkt_is_ack);
 
 /*
  * Writ=
e a control channel authentication record=2E
@@ -210,8 +210,9 @@
  * from t=
he tls pre decrypt state=2E
  *
  */
-struct buffer tls_reset_standalone(st=
ruct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,
-                 =
                  struct session_id *own_sid, struct session_id *remote_sid=
,
+struct buffer tls_reset_standalone(struct tls_wrap_ctx *ctx, const struc=
t tls_auth_standalone *tas,
+                                   const struc=
t session_id *own_sid,
+                                   const struct ses=
sion_id *remote_sid,
                                    uint8_t header, bo=
ol request_resend_wkc);
 
 
diff --git a/src/openvpn/ssl_verify=2Ec b/src/o=
penvpn/ssl_verify=2Ec
index 6631718=2E=2E0acba2b 100644
--- a/src/openvpn/s=
sl_verify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -1140,7 +1140,7 @@
  * ca=
che=2E
  */
 static bool
-tls_authentication_status_use_cache(struct tls_mu=
lti *multi)
+tls_authentication_status_use_cache(const struct tls_multi *mu=
lti)
 {
     unsigned int idx =3D min_uint(multi->tas_cache_num_updates, SI=
ZE(cache_intervals) - 1);
     time_t latency =3D cache_intervals[idx];
@@ =
-1284,7 +1284,7 @@
  * Check if the script/plugin left a message in the aut=
h failed message
  * file and relay it to the user */
 static void
-check_f=
or_client_reason(struct tls_multi *multi, struct auth_deferred_status *stat=
us)
+check_for_client_reason(struct tls_multi *multi, const struct auth_def=
erred_status *status)
 {
     struct gc_arena gc =3D gc_new();
     const c=
har *msg =3D key_state_check_auth_failed_message_file(status, &gc);
@@ -155=
3,7 +1553,7 @@
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 static bool
-set_ve=
rify_user_pass_env(struct user_pass *up, struct tls_multi *multi, struct tl=
s_session *session)
+set_verify_user_pass_env(const struct user_pass *up, s=
truct tls_multi *multi, struct tls_session *session)
 {
     /* Is username=
 defined? */
     if ((session->opt->ssl_flags & SSLF_AUTH_USER_PASS_OPTION=
AL) || strlen(up->username))
@@ -1581,7 +1581,7 @@
 }
 
 bool
-ssl_verify_u=
sername_length(struct tls_session *session, const char *username)
+ssl_veri=
fy_username_length(const struct tls_session *session, const char *username)=

 {
     if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME)
     =
    && strlen(username) > TLS_USERNAME_LEN)
diff --git a/src/openvpn/ssl_ve=
rify=2Eh b/src/openvpn/ssl_verify=2Eh
index 3176d76=2E=2Ee77bc4a 100644
---=
 a/src/openvpn/ssl_verify=2Eh
+++ b/src/openvpn/ssl_verify=2Eh
@@ -202,7 +2=
02,7 @@
  * @return              true if name is under limit or username-as=
-common-name
  *                      is not active
  */
-bool ssl_verify_u=
sername_length(struct tls_session *session, const char *username);
+bool ss=
l_verify_username_length(const struct tls_session *session, const char *use=
rname);
 
 /**
  * Runs the --client-crresponse script if one is defined=2E=

@@ -275,7 +275,7 @@
 void auth_set_client_reason(struct tls_multi *multi, =
const char *client_reason);
 
 static inline const char *
-tls_client_reaso=
n(struct tls_multi *multi)
+tls_client_reason(const struct tls_multi *multi=
)
 {
     return multi->client_reason;
 }
diff --git a/src/openvpn/status=
=2Ec b/src/openvpn/status=2Ec
index c7d375b=2E=2Ecfbc38d 100644
--- a/src/o=
penvpn/status=2Ec
+++ b/src/openvpn/status=2Ec
@@ -135,7 +135,7 @@
 }
 
 vo=
id
-status_reset(struct status_output *so)
+status_reset(const struct statu=
s_output *so)
 {
     if (so && so->fd >=3D 0)
     {
diff --git a/src/open=
vpn/status=2Eh b/src/openvpn/status=2Eh
index 7953a4e=2E=2E4c01d75 100644
-=
-- a/src/openvpn/status=2Eh
+++ b/src/openvpn/status=2Eh
@@ -69,7 +69,7 @@
=
 
 bool status_trigger(struct status_output *so);
 
-void status_reset(stru=
ct status_output *so);
+void status_reset(const struct status_output *so);
=
 
 void status_flush(struct status_output *so);
 
diff --git a/src/openvpn/=
tun=2Ec b/src/openvpn/tun=2Ec
index 133f670=2E=2Ef191a6b 100644
--- a/src/o=
penvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -835,7 +835,7 @@
          cons=
t char *ifconfig_ipv6_local_parm,     /* --ifconfig parm 1 IPv6 */
        =
  int ifconfig_ipv6_netbits_parm,
          const char *ifconfig_ipv6_remot=
e_parm,    /* --ifconfig parm 2 IPv6 */
-         struct addrinfo *local_pu=
blic, struct addrinfo *remote_public, const bool strict_warn,
+         con=
st struct addrinfo *local_public, const struct addrinfo *remote_public, con=
st bool strict_warn,
          struct env_set *es, openvpn_net_ctx_t *ctx, =
struct tuntap *tt)
 {
     if (!tt)
@@ -978,7 +978,7 @@
  * -> helper funct=
ion to simplify code below
  */
 static void
-add_route_connected_v6_net(st=
ruct tuntap *tt, const struct env_set *es)
+add_route_connected_v6_net(cons=
t struct tuntap *tt, const struct env_set *es)
 {
     struct route_ipv6 r6=
;
 
@@ -1020,7 +1020,7 @@
  */
 
 in_addr_t
-create_arbitrary_remote(struct=
 tuntap *tt)
+create_arbitrary_remote(const struct tuntap *tt)
 {
     in_a=
ddr_t remote;
 
@@ -1592,7 +1592,7 @@
 }
 
 static void
-undo_ifconfig_ipv4=
(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+undo_ifconfig_ipv4(const struc=
t tuntap *tt, openvpn_net_ctx_t *ctx)
 {
 #if defined(TARGET_LINUX)
     in=
t netbits =3D netmask_to_netbits2(tt->remote_netmask);
@@ -1627,7 +1627,7 @=
@
 }
 
 static void
-undo_ifconfig_ipv6(struct tuntap *tt, openvpn_net_ctx_=
t *ctx)
+undo_ifconfig_ipv6(const struct tuntap *tt, openvpn_net_ctx_t *ctx=
)
 {
 #if defined(TARGET_LINUX)
     if (net_addr_v6_del(ctx, tt->actual_na=
me, &tt->local_ipv6, tt->netbits_ipv6) < 0)
@@ -1652,7 +1652,7 @@
 }
 
 voi=
d
-undo_ifconfig(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+undo_ifconfig(=
const struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
     if (tt->backend_dr=
iver !=3D DRIVER_NULL && tt->backend_driver !=3D DRIVER_AFUNIX)
     {
@@ -=
1720,13 +1720,13 @@
 }
 
 static ssize_t
-write_tun_header(struct tuntap *t=
t, uint8_t *buf, int len)
+write_tun_header(const struct tuntap *tt, const =
uint8_t *buf, int len)
 {
     if (tt->type =3D=3D DEV_TYPE_TUN)
     {
   =
      u_int32_t type;
         struct iovec iv[2];
-        const struct ip=
 *iph =3D (struct ip *)buf;
+        const struct ip *iph =3D (const struct=
 ip *)buf;
 
         if (iph->ip_v =3D=3D 6)
         {
@@ -1737,9 +1737,1=
1 @@
             type =3D htonl(AF_INET);
         }
 
+        /* argumen=
t to writev is a pointer to const but we still need to drop
+         * the=
 const from buf pointer here */
         iv[0]=2Eiov_base =3D &type;
      =
   iv[0]=2Eiov_len =3D sizeof(type);
-        iv[1]=2Eiov_base =3D buf;
+  =
      iv[1]=2Eiov_base =3D (void *)buf;
         iv[1]=2Eiov_len =3D len;
 =

         return header_modify_read_write_return(writev(tt->fd, iv, 2));
@@=
 -1751,7 +1753,7 @@
 }
 
 static ssize_t
-read_tun_header(struct tuntap *tt=
, uint8_t *buf, int len)
+read_tun_header(const struct tuntap *tt, uint8_t =
*buf, int len)
 {
     if (tt->type =3D=3D DEV_TYPE_TUN)
     {
@@ -1777,13=
 +1779,13 @@
  */
 #if !defined(TARGET_DARWIN)
 ssize_t
-write_tun(struct t=
untap *tt, uint8_t *buf, int len)
+write_tun(const struct tuntap *tt, const=
 uint8_t *buf, int len)
 {
     return write_tun_header(tt, buf, len);
 }
 =

 ssize_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
+read_tun(con=
st struct tuntap *tt, uint8_t *buf, int len)
 {
     return read_tun_header=
(tt, buf, len);
 }
@@ -1799,7 +1801,7 @@
 
 #if defined(TARGET_LINUX) || de=
fined(TARGET_FREEBSD)
 static bool
-tun_dco_enabled(struct tuntap *tt)
+tun=
_dco_enabled(const struct tuntap *tt)
 {
     return tt->backend_driver =3D=
=3D DRIVER_DCO;
 }
@@ -2047,13 +2049,13 @@
 }
 
 ssize_t
-write_tun(struct =
tuntap *tt, uint8_t *buf, int len)
+write_tun(const struct tuntap *tt, cons=
t uint8_t *buf, int len)
 {
     return write(tt->fd, buf, len);
 }
 
 ssiz=
e_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
+read_tun(const str=
uct tuntap *tt, uint8_t *buf, int len)
 {
     return read(tt->fd, buf, len=
);
 }
@@ -2252,13 +2254,13 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt, u=
int8_t *buf, int len)
+write_tun(const struct tuntap *tt, const uint8_t *bu=
f, int len)
 {
     return write(tt->fd, buf, len);
 }
 
 ssize_t
-read_tun=
(struct tuntap *tt, uint8_t *buf, int len)
+read_tun(const struct tuntap *t=
t, uint8_t *buf, int len)
 {
     return read(tt->fd, buf, len);
 }
@@ -258=
8,7 +2590,7 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt, uint8_t *buf, in=
t len)
+write_tun(const struct tuntap *tt, const uint8_t *buf, int len)
 {
=
     struct strbuf sbuf;
     sbuf=2Elen =3D len;
@@ -2597,7 +2599,7 @@
 }
=
 
 ssize_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
+read_tun(co=
nst struct tuntap *tt, uint8_t *buf, int len)
 {
     struct strbuf sbuf;
 =
    int f =3D 0;
@@ -3095,7 +3097,7 @@
 }
 
 ssize_t
-write_tun(struct tunt=
ap *tt, uint8_t *buf, int len)
+write_tun(const struct tuntap *tt, const ui=
nt8_t *buf, int len)
 {
     if (tt->backend_driver =3D=3D DRIVER_UTUN)
   =
  {
@@ -3108,7 +3110,7 @@
 }
 
 ssize_t
-read_tun(struct tuntap *tt, uint8_=
t *buf, int len)
+read_tun(const struct tuntap *tt, uint8_t *buf, int len)
=
 {
     if (tt->backend_driver =3D=3D DRIVER_UTUN)
     {
@@ -3243,13 +3245=
,13 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt, uint8_t *buf, int len)
+=
write_tun(const struct tuntap *tt, const uint8_t *buf, int len)
 {
     ret=
urn write(tt->fd, buf, len);
 }
 
 ssize_t
-read_tun(struct tuntap *tt, uin=
t8_t *buf, int len)
+read_tun(const struct tuntap *tt, uint8_t *buf, int le=
n)
 {
     return read(tt->fd, buf, len);
 }
@@ -3311,7 +3313,7 @@
 }
 
 in=
t
-tun_write_queue(struct tuntap *tt, struct buffer *buf)
+tun_write_queue(=
struct tuntap *tt, const struct buffer *buf)
 {
     if (tt->writes=2Eiosta=
te =3D=3D IOSTATE_INITIAL)
     {
@@ -3365,7 +3367,7 @@
 }
 
 int
-tun_writ=
e_win32(struct tuntap *tt, struct buffer *buf)
+tun_write_win32(struct tunt=
ap *tt, const struct buffer *buf)
 {
     int err =3D 0;
     int status =
=3D 0;
@@ -5370,7 +5372,7 @@
 }
 
 void
-fork_register_dns_action(struct tu=
ntap *tt)
+fork_register_dns_action(const struct tuntap *tt)
 {
     if (tt=
 && tt->options=2Eregister_dns && tt->options=2Emsg_channel)
     {
@@ -546=
0,7 +5462,7 @@
 }
 
 static void
-tuntap_get_mtu(struct tuntap *tt)
+tuntap=
_get_mtu(const struct tuntap *tt)
 {
     ULONG mtu =3D 0;
     DWORD len;
=
@@ -6035,7 +6037,7 @@
 }
 
 void
-tun_show_debug(struct tuntap *tt)
+tun_sh=
ow_debug(const struct tuntap *tt)
 {
     if (tt->backend_driver =3D=3D WIN=
DOWS_DRIVER_TAP_WINDOWS6)
     {
@@ -6295,13 +6297,13 @@
 }
 
 ssize_t
-wri=
te_tun(struct tuntap *tt, uint8_t *buf, int len)
+write_tun(const struct tu=
ntap *tt, const uint8_t *buf, int len)
 {
     return write(tt->fd, buf, le=
n);
 }
 
 ssize_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
+read=
_tun(const struct tuntap *tt, uint8_t *buf, int len)
 {
     return read(tt=
->fd, buf, len);
 }
diff --git a/src/openvpn/tun=2Eh b/src/openvpn/tun=2Eh
=
index 7340e7e=2E=2E61fe943 100644
--- a/src/openvpn/tun=2Eh
+++ b/src/openv=
pn/tun=2Eh
@@ -272,9 +272,9 @@
 
 void close_tun_handle(struct tuntap *tt);=

 
-ssize_t write_tun(struct tuntap *tt, uint8_t *buf, int len);
+ssize_t w=
rite_tun(const struct tuntap *tt, const uint8_t *buf, int len);
 
-ssize_t =
read_tun(struct tuntap *tt, uint8_t *buf, int len);
+ssize_t read_tun(const=
 struct tuntap *tt, uint8_t *buf, int len);
 
 #ifdef ENABLE_FEATURE_TUN_PE=
RSIST
 void tuncfg(const char *dev, const char *dev_type, const char *dev_n=
ode, int persist_mode,
@@ -293,7 +293,7 @@
                         const c=
har *ifconfig_ipv6_local_parm,     /* --ifconfig parm 1 / IPv6 */
         =
                int ifconfig_ipv6_netbits_parm,           /* --ifconfig par=
m 1 / bits */
                         const char *ifconfig_ipv6_remote_par=
m,    /* --ifconfig parm 2 / IPv6 */
-                        struct addrin=
fo *local_public, struct addrinfo *remote_public,
+                        =
const struct addrinfo *local_public, const struct addrinfo *remote_public,
=
                         const bool strict_warn, struct env_set *es, openvp=
n_net_ctx_t *ctx,
                         struct tuntap *tt);
 
@@ -320,7 =
+320,7 @@
  * @param tt    the tuntap interface context
  * @param ctx   th=
e networking API opaque context
  */
-void undo_ifconfig(struct tuntap *tt,=
 openvpn_net_ctx_t *ctx);
+void undo_ifconfig(const struct tuntap *tt, open=
vpn_net_ctx_t *ctx);
 
 bool is_dev_type(const char *dev, const char *dev_t=
ype, const char *match_type);
 
@@ -351,7 +351,7 @@
 #define IFCONFIG_DEFAU=
LT IFCONFIG_AFTER_TUN_OPEN
 
 static inline int
-ifconfig_order(struct tunt=
ap *tt)
+ifconfig_order(const struct tuntap *tt)
 {
     if (tt->backend_dr=
iver =3D=3D DRIVER_AFUNIX)
     {
@@ -381,7 +381,7 @@
 #define ROUTE_ORDER_=
DEFAULT ROUTE_AFTER_TUN
 
 static inline int
-route_order(struct tuntap *tt=
)
+route_order(const struct tuntap *tt)
 {
     if (tt->backend_driver =3D=
=3D DRIVER_AFUNIX)
     {
@@ -454,13 +454,13 @@
 
 const char *tap_win_geti=
nfo(const struct tuntap *tt, struct gc_arena *gc);
 
-void tun_show_debug(s=
truct tuntap *tt);
+void tun_show_debug(const struct tuntap *tt);
 
 bool d=
hcp_release_by_adapter_index(const DWORD adapter_index);
 
 bool dhcp_renew=
_by_adapter_index(const DWORD adapter_index);
 
-void fork_register_dns_act=
ion(struct tuntap *tt);
+void fork_register_dns_action(const struct tuntap =
*tt);
 
 void ipconfig_register_dns(const struct env_set *es);
 
@@ -470,7 =
+470,7 @@
 
 int tun_read_queue(struct tuntap *tt, int maxsize);
 
-int tun=
_write_queue(struct tuntap *tt, struct buffer *buf);
+int tun_write_queue(s=
truct tuntap *tt, const struct buffer *buf);
 
 static inline bool
 tuntap_=
stop(int status)
@@ -499,7 +499,7 @@
     return false;
 }
 
-int tun_write=
_win32(struct tuntap *tt, struct buffer *buf);
+int tun_write_win32(struct =
tuntap *tt, const struct buffer *buf);
 
 static inline bool
 is_ip_packet_=
valid(const struct buffer *buf)
@@ -529,19 +529,21 @@
 }
 
 static inline b=
ool
-tuntap_is_dco_win(struct tuntap *tt)
+tuntap_is_dco_win(const struct t=
untap *tt)
 {
     return tt && tt->backend_driver =3D=3D DRIVER_DCO;
 }
 
=
 static inline bool
-tuntap_is_dco_win_timeout(struct tuntap *tt, ssize_t s=
tatus)
+tuntap_is_dco_win_timeout(const struct tuntap *tt, ssize_t status)
=
 {
     return tuntap_is_dco_win(tt) && (status < 0) && (openvpn_errno() =
=3D=3D ERROR_NETNAME_DELETED);
 }
 
 #else  /* ifdef _WIN32 */
 
+// cppche=
ck-suppress-begin constParameterPointer ; stubs
+
 static inline bool
 tunt=
ap_stop(int status)
 {
@@ -565,19 +567,20 @@
     return true;
 }
 
-
 stat=
ic inline bool
-tuntap_is_dco_win(struct tuntap *tt)
+tuntap_is_dco_win(con=
st struct tuntap *tt)
 {
     return false;
 }
 
 static inline bool
-tunta=
p_is_dco_win_timeout(struct tuntap *tt, ssize_t status)
+tuntap_is_dco_win_=
timeout(const struct tuntap *tt, ssize_t status)
 {
     return false;
 }
 =

+// cppcheck-suppress-end constParameterPointer
+
 #endif /* ifdef _WIN32 =
*/
 
 /*
diff --git a/src/openvpn/tun_afunix=2Ec b/src/openvpn/tun_afunix=
=2Ec
index f494d42=2E=2E79d706a 100644
--- a/src/openvpn/tun_afunix=2Ec
+++=
 b/src/openvpn/tun_afunix=2Ec
@@ -49,7 +49,7 @@
 
 
 static void
-tun_afuni=
x_exec_child(const char *dev_node, struct tuntap *tt, struct env_set *env)
=
+tun_afunix_exec_child(const char *dev_node, struct tuntap *tt, const struc=
t env_set *env)
 {
     const char *msgprefix =3D "ERROR: failure executing=
 process for tun:";
     struct argv argv =3D argv_new();
@@ -74,7 +74,7 @@=

 }
 
 void
-open_tun_afunix(struct options *o, int mtu, struct tuntap *tt,=
 struct env_set *orig_env)
+open_tun_afunix(const struct options *o, int mt=
u, struct tuntap *tt, const struct env_set *orig_env)
 {
     struct gc_are=
na gc =3D gc_new();
 
@@ -146,7 +146,7 @@
 }
 
 ssize_t
-write_tun_afunix(s=
truct tuntap *tt, uint8_t *buf, int len)
+write_tun_afunix(struct tuntap *t=
t, const uint8_t *buf, int len)
 {
     const char *msg =3D "ERROR: failure=
 during write to AF_UNIX socket: ";
     if (!openvpn_waitpid_check(tt->afu=
nix=2Echildprocess, msg, M_WARN))
@@ -172,8 +172,11 @@
     return read(tt-=
>fd, buf, len);
 }
 #else  /* ifndef WIN32 */
+
+// cppcheck-suppress-begin=
 constParameterPointer ; stubs
+
 void
-open_tun_afunix(struct options *o, =
int mtu, struct tuntap *tt, struct env_set *orig_env)
+open_tun_afunix(cons=
t struct options *o, int mtu, struct tuntap *tt, const struct env_set *orig=
_env)
 {
     msg(M_ERR, "AF_UNIX socket support not available on this plat=
form");
 }
@@ -186,7 +189,7 @@
 }
 
 ssize_t
-write_tun_afunix(struct tunta=
p *tt, uint8_t *buf, int len)
+write_tun_afunix(struct tuntap *tt, const ui=
nt8_t *buf, int len)
 {
     /* should never be called as open_tun_afunix a=
lways fails */
     ASSERT(0);
@@ -199,4 +202,6 @@
     ASSERT(0);
 }
 
+//=
 cppcheck-suppress-end constParameterPointer
+
 #endif /* ifndef WIN32 */
d=
iff --git a/src/openvpn/tun_afunix=2Eh b/src/openvpn/tun_afunix=2Eh
index 5=
b6a8e0=2E=2E5307e31 100644
--- a/src/openvpn/tun_afunix=2Eh
+++ b/src/openv=
pn/tun_afunix=2Eh
@@ -31,7 +31,7 @@
  * the user provided taking care of im=
plementing the actual tun
  * device=2E
  */
-void open_tun_afunix(struct o=
ptions *o, int mtu, struct tuntap *tt, struct env_set *env);
+void open_tun=
_afunix(const struct options *o, int mtu, struct tuntap *tt, const struct e=
nv_set *env);
 
 
 /**
@@ -43,7 +43,7 @@
 /**
  * Writes a packet to a AF_U=
NIX based tun device=2E
  */
-ssize_t write_tun_afunix(struct tuntap *tt, u=
int8_t *buf, int len);
+ssize_t write_tun_afunix(struct tuntap *tt, const u=
int8_t *buf, int len);
 
 /**
  * Reads a packet from a AF_UNIX based tun d=
evice=2E
diff --git a/src/openvpn/vlan=2Ec b/src/openvpn/vlan=2Ec
index 69a=
c10d=2E=2E04e18d6 100644
--- a/src/openvpn/vlan=2Ec
+++ b/src/openvpn/vlan=
=2Ec
@@ -288,7 +288,7 @@
 }
 
 void
-vlan_process_outgoing_tun(struct multi=
_context *m, struct multi_instance *mi)
+vlan_process_outgoing_tun(const st=
ruct multi_context *m, struct multi_instance *mi)
 {
     if (!m->top=2Eopt=
ions=2Evlan_tagging)
     {
diff --git a/src/openvpn/vlan=2Eh b/src/openvpn=
/vlan=2Eh
index 9389f89=2E=2Ecd2f66f 100644
--- a/src/openvpn/vlan=2Eh
+++ =
b/src/openvpn/vlan=2Eh
@@ -35,6 +35,6 @@
 
 bool vlan_is_tagged(const struc=
t buffer *buf);
 
-void vlan_process_outgoing_tun(struct multi_context *m, =
struct multi_instance *mi);
+void vlan_process_outgoing_tun(const struct mu=
lti_context *m, struct multi_instance *mi);
 
 #endif /* VLAN_H */
diff --g=
it a/src/openvpn/win32=2Eh b/src/openvpn/win32=2Eh
index 8be3d96=2E=2E39ff7=
d8 100644
--- a/src/openvpn/win32=2Eh
+++ b/src/openvpn/win32=2Eh
@@ -227,7=
 +227,7 @@
 void overlapped_io_close(struct overlapped_io *o);
 
 static in=
line bool
-overlapped_io_active(struct overlapped_io *o)
+overlapped_io_act=
ive(const struct overlapped_io *o)
 {
     return o->iostate =3D=3D IOSTATE=
_QUEUED || o->iostate =3D=3D IOSTATE_IMMEDIATE_RETURN;
 }
diff --git a/src/=
openvpnmsica/openvpnmsica=2Ec b/src/openvpnmsica/openvpnmsica=2Ec
index 1a1=
7d95=2E=2Ed2fd9af 100644
--- a/src/openvpnmsica/openvpnmsica=2Ec
+++ b/src/=
openvpnmsica/openvpnmsica=2Ec
@@ -77,7 +77,7 @@
  * @return ERROR_SUCCESS o=
n success; An error code otherwise
  */
 static UINT
-setup_sequence(_In_ M=
SIHANDLE hInstall, _In_z_ LPCWSTR szProperty, _In_ struct msica_arg_seq *se=
q)
+setup_sequence(_In_ MSIHANDLE hInstall, _In_z_ LPCWSTR szProperty, _In_=
 const struct msica_arg_seq *seq)
 {
     UINT uiResult;
     LPWSTR szSequ=
ence =3D msica_arg_seq_join(seq);
diff --git a/src/openvpnserv/interactive=
=2Ec b/src/openvpnserv/interactive=2Ec
index 9a68bbb=2E=2Ed8cf6e1 100644
--=
- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@=
@ -522,7 +522,7 @@
 
 
 static SOCKADDR_INET
-sockaddr_inet(short family, i=
net_address_t *addr)
+sockaddr_inet(short family, const inet_address_t *add=
r)
 {
     SOCKADDR_INET sa_inet;
     ZeroMemory(&sa_inet, sizeof(sa_inet)=
);
diff --git a/tests/unit_tests/openvpn/mock_management=2Ec b/tests/unit_t=
ests/openvpn/mock_management=2Ec
index 77f6ce2=2E=2Efff4c2b 100644
--- a/te=
sts/unit_tests/openvpn/mock_management=2Ec
+++ b/tests/unit_tests/openvpn/m=
ock_management=2Ec
@@ -36,7 +36,7 @@
 struct management *management; /* GLO=
BAL */
 
 void
-management_auth_failure(struct management *man, const char =
*type, const char *reason)
+management_auth_failure(const struct management=
 *man, const char *type, const char *reason)
 {
     ASSERT(false);
 }
diff=
 --git a/tests/unit_tests/openvpn/siphash_openssl=2Ec b/tests/unit_tests/op=
envpn/siphash_openssl=2Ec
index 52f13b8=2E=2Ee7282b2 100644
--- a/tests/uni=
t_tests/openvpn/siphash_openssl=2Ec
+++ b/tests/unit_tests/openvpn/siphash_=
openssl=2Ec
@@ -100,7 +100,7 @@
 }
 
 bool
-siphash_openssl_available(void =
*sip_context)
+siphash_openssl_available(const void *sip_context)
 {
     c=
onst struct siphash_context *sip =3D sip_context;
 
@@ -117,6 +117,8 @@
 }
=
 #else
 /* Do avoid a lot more ifdefs in the test we put dummy functions he=
re */
+// cppcheck-suppress-begin constParameterPointer ; stubs
+
 int
 sip=
hash_openssl(void *sip_context, const void *in, const size_t inlen,
       =
          const void *k, uint8_t *out, const size_t outlen)
@@ -125,7 +127,=
7 @@
 }
 
 bool
-siphash_openssl_available(void *sip_context)
+siphash_open=
ssl_available(const void *sip_context)
 {
     return false;
 }
@@ -141,5 +=
143,6 @@
 {
 }
 
+// cppcheck-suppress-end constParameterPointer
 
 #endif =
/* if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >=3D 0x30000=
000L */
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_te=
sts/openvpn/test_misc=2Ec
index 8d88943=2E=2Eaea40f0 100644
--- a/tests/uni=
t_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
=
@@ -146,7 +146,7 @@
 }
 
 static struct hash_element *
-hash_lookup_by_valu=
e(struct hash *hash, void *value)
+hash_lookup_by_value(struct hash *hash, =
const void *value)
 {
     struct hash_iterator hi;
     struct hash_elemen=
t *he;
diff --git a/tests/unit_tests/openvpn/test_user_pass=2Ec b/tests/uni=
t_tests/openvpn/test_user_pass=2Ec
index c0a0866=2E=2E7636a33 100644
--- a/=
tests/unit_tests/openvpn/test_user_pass=2Ec
+++ b/tests/unit_tests/openvpn/=
test_user_pass=2Ec
@@ -59,7 +59,7 @@
     return mock();
 }
 void
-manageme=
nt_auth_failure(struct management *man, const char *type, const char *reaso=
n)
+management_auth_failure(const struct management *man, const char *type,=
 const char *reason)
 {
     assert_true(0);
 }

-- 
To view, visit https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
=
Gerrit-Change-Number: 1663
Gerrit-PatchSet: 33
Gerrit-Owner: Frank Lichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--rdFKSlJg/4g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #33</strong> to the change originally created by Fra=
nk Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1663?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Remove instances of constParameterPointer cppcheck warnings<br><br>This=
 requires a few suppressions since cppcheck<br>doesn&#39;t quite understand=
 the different code-paths<br>implemented by preprocessor defines=2E<br><br>=
Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58<br>Signed-off-by: Fran=
k Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru =
&lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1663<br>Message-Id: &lt;20261015113218=2E24245-1-gert@greenie=
=2Emuc=2Ede&gt;<br>URL: https://lore=2Ekernel=2Eorg/openvpn-devel/202610151=
13218=2E24245-1-gert@greenie=2Emuc=2Ede/<br>Signed-off-by: Gert Doering &lt=
;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M dev-tools/cppcheck-suppressions=2E=
xml<br>M sample/sample-plugins/client-connect/sample-client-connect=2Ec<br>=
M sample/sample-plugins/defer/multi-auth=2Ec<br>M sample/sample-plugins/key=
ing-material-exporter-demo/keyingmaterialexporter=2Ec<br>M src/openvpn/buff=
er=2Eh<br>M src/openvpn/clinat=2Ec<br>M src/openvpn/comp=2Ec<br>M src/openv=
pn/comp=2Eh<br>M src/openvpn/crypto=2Ec<br>M src/openvpn/crypto=2Eh<br>M sr=
c/openvpn/dco=2Ec<br>M src/openvpn/dco=2Eh<br>M src/openvpn/dco_freebsd=2Ec=
<br>M src/openvpn/dco_internal=2Eh<br>M src/openvpn/dco_linux=2Ec<br>M src/=
openvpn/dco_win=2Ec<br>M src/openvpn/error=2Ec<br>M src/openvpn/error=2Eh<b=
r>M src/openvpn/event=2Ec<br>M src/openvpn/event=2Eh<br>M src/openvpn/forwa=
rd=2Ec<br>M src/openvpn/forward=2Eh<br>M src/openvpn/init=2Ec<br>M src/open=
vpn/init=2Eh<br>M src/openvpn/interval=2Eh<br>M src/openvpn/list=2Ec<br>M s=
rc/openvpn/list=2Eh<br>M src/openvpn/manage=2Ec<br>M src/openvpn/manage=2Eh=
<br>M src/openvpn/mbuf=2Ec<br>M src/openvpn/mbuf=2Eh<br>M src/openvpn/mss=
=2Ec<br>M src/openvpn/mss=2Eh<br>M src/openvpn/mtcp=2Ec<br>M src/openvpn/mt=
cp=2Eh<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvp=
n/multi=2Eh<br>M src/openvpn/multi_io=2Ec<br>M src/openvpn/networking=2Eh<b=
r>M src/openvpn/networking_iproute2=2Ec<br>M src/openvpn/networking_sitnl=
=2Ec<br>M src/openvpn/occ=2Eh<br>M src/openvpn/openssl_compat=2Eh<br>M src/=
openvpn/options=2Ec<br>M src/openvpn/options_parse=2Ec<br>M src/openvpn/oti=
me=2Ec<br>M src/openvpn/otime=2Eh<br>M src/openvpn/proto=2Eh<br>M src/openv=
pn/proxy=2Ec<br>M src/openvpn/proxy=2Eh<br>M src/openvpn/ps=2Ec<br>M src/op=
envpn/ps=2Eh<br>M src/openvpn/push=2Ec<br>M src/openvpn/push=2Eh<br>M src/o=
penvpn/push_util=2Ec<br>M src/openvpn/reliable=2Ec<br>M src/openvpn/reliabl=
e=2Eh<br>M src/openvpn/route=2Ec<br>M src/openvpn/socket=2Ec<br>M src/openv=
pn/socket=2Eh<br>M src/openvpn/socket_util=2Eh<br>M src/openvpn/socks=2Ec<b=
r>M src/openvpn/socks=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl=2Eh=
<br>M src/openvpn/ssl_backend=2Eh<br>M src/openvpn/ssl_mbedtls=2Ec<br>M src=
/openvpn/ssl_openssl=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_=
pkt=2Eh<br>M src/openvpn/ssl_verify=2Ec<br>M src/openvpn/ssl_verify=2Eh<br>=
M src/openvpn/status=2Ec<br>M src/openvpn/status=2Eh<br>M src/openvpn/tun=
=2Ec<br>M src/openvpn/tun=2Eh<br>M src/openvpn/tun_afunix=2Ec<br>M src/open=
vpn/tun_afunix=2Eh<br>M src/openvpn/vlan=2Ec<br>M src/openvpn/vlan=2Eh<br>M=
 src/openvpn/win32=2Eh<br>M src/openvpnmsica/openvpnmsica=2Ec<br>M src/open=
vpnserv/interactive=2Ec<br>M tests/unit_tests/openvpn/mock_management=2Ec<b=
r>M tests/unit_tests/openvpn/siphash_openssl=2Ec<br>M tests/unit_tests/open=
vpn/test_misc=2Ec<br>M tests/unit_tests/openvpn/test_user_pass=2Ec<br>88 fi=
les changed, 398 insertions(+), 284 deletions(-)<br><br></pre><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/63/1663/3=
3</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;"><span>diff --git a/dev-tools/cppcheck-suppressions=2Exml b/dev-tools/cp=
pcheck-suppressions=2Exml</span><br><span>index 9d8c202=2E=2Ebd24c3b 100644=
</span><br><span>--- a/dev-tools/cppcheck-suppressions=2Exml</span><br><spa=
n>+++ b/dev-tools/cppcheck-suppressions=2Exml</span><br><span>@@ -9,9 +9,6 =
@@</span><br><span>     &lt;id&gt;constParameterCallback&lt;/id&gt;</span><=
br><span>   &lt;/suppress&gt;</span><br><span>   &lt;suppress&gt;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;id&gt;constParameterPoi=
nter&lt;/id&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;=
/suppress&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;su=
ppress&gt;</span><br><span>     &lt;id&gt;unusedFunction&lt;/id&gt;</span><=
br><span>   &lt;/suppress&gt;</span><br><span>   &lt;suppress&gt;</span><br=
><span>@@ -65,6 +62,97 @@</span><br><span>     &lt;id&gt;badBitmaskCheck&lt=
;/id&gt;</span><br><span>     &lt;fileName&gt;tests/unit_tests/openvpn/test=
_pkt=2Ec&lt;/fileName&gt;</span><br><span>   &lt;/suppress&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: we use casts to r=
emove const --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/buffer=2Eh&lt;/fil=
eName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;sy=
mbolName&gt;buf&lt;/symbolName&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  &lt;!-- FP: const silently removed due to pointer arithmet=
ic --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;supp=
ress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&=
gt;constParameterPointer&lt;/id&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/buffer=2Ec&lt;/fileName&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&=
gt;buf&lt;/symbolName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  &lt;!-- IGN: external --&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;/usr/include=
/*&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  &lt;!-- IGN: too many false-positives due to stubs --&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;constParameterPointer&=
lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;f=
ileName&gt;tests/unit_tests/openvpn*/test_*&lt;/fileName&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;constParameterPointer=
&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;=
fileName&gt;tests/unit_tests/openvpn/mock_*&lt;/fileName&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: too many false-posi=
tives due to library/platform-specific code --&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    &lt;id&gt;constParameterPointer&lt;/id&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&g=
t;src/openvpn/crypto*&lt;/fileName&gt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvp=
n/ssl_*&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/dco*&lt;/fil=
eName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/sup=
press&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;supp=
ress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&=
gt;constParameterPointer&lt;/id&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/socket=2E*&lt;/fileName&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: const=
 is only possible on some platforms</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+       These might easily hide valid issues but we need to =
compromise</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       fo=
r developer sanity=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+       Inline suppressions are often too ugly since they need to go in</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+       between our ret=
urn type line and the function name=2E=2E=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  --&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/dns=
=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    &lt;symbolName&gt;duri&lt;/symbolName&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    &lt;id&gt;constParameterPointer&lt;/id&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;s=
rc/openvpn/error=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    &lt;symbolName&gt;gc&lt;/symbolName&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;constParameterPointe=
r&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt=
;fileName&gt;src/openvpn/forward=2Ec&lt;/fileName&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;dco&lt;/symbolName&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;con=
stParameterPointer&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    &lt;fileName&gt;src/openvpn/manage=2Ec&lt;/fileName&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;man=
&lt;/symbolName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/misc=2Ec&lt;/file=
Name&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;sym=
bolName&gt;up&lt;/symbolName&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/opti=
ons=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    &lt;symbolName&gt;options&lt;/symbolName&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;constParameterPointer&lt;/i=
d&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileNa=
me&gt;src/openvpn/tun=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    &lt;symbolName&gt;gc&lt;/symbolName&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: weird issue w=
ith MinGW debug build throwing -Werror=3Dmaybe-uninitialized</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+       for no good reason --&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;constPar=
ameterPointer&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    &lt;fileName&gt;src/openvpn/buffer=2Eh&lt;/fileName&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;p&lt;/sy=
mbolName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/=
suppress&gt;</span><br><span>   &lt;!-- FP: cppcheck seems to have wrong si=
gnature of DeviceIoControl() --&gt;</span><br><span>   &lt;suppress&gt;</sp=
an><br><span>     &lt;id&gt;constVariablePointer&lt;/id&gt;</span><br><span=
>diff --git a/sample/sample-plugins/client-connect/sample-client-connect=2E=
c b/sample/sample-plugins/client-connect/sample-client-connect=2Ec</span><b=
r><span>index 420de61=2E=2Ecbd98e8 100644</span><br><span>--- a/sample/samp=
le-plugins/client-connect/sample-client-connect=2Ec</span><br><span>+++ b/s=
ample/sample-plugins/client-connect/sample-client-connect=2Ec</span><br><sp=
an>@@ -344,7 +344,7 @@</span><br><span> }</span><br><span> </span><br><span=
> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-openvpn_plugin_c=
lient_connect(struct plugin_context *context, const char **argv, const char=
 **envp)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn_plu=
gin_client_connect(const struct plugin_context *context, const char **argv,=
 const char **envp)</span><br><span> {</span><br><span>     /* log environm=
ent variables handed to us by OpenVPN, but</span><br><span>      * only if =
&quot;setenv verb&quot; is 3 or higher (arbitrary number)</span><br><span>@=
@ -465,7 +465,7 @@</span><br><span> </span><br><span> int</span><br><span> =
openvpn_plugin_client_connect_defer_v2(struct plugin_context *context,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
             struct plugin_per_client_context *pcc,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                       co=
nst struct plugin_per_client_context *pcc,</span><br><span>                =
                        struct openvpn_plugin_string_list **return_list)</s=
pan><br><span> {</span><br><span>     time_t time_left =3D pcc-&gt;sleep_un=
til - time(NULL);</span><br><span>diff --git a/sample/sample-plugins/defer/=
multi-auth=2Ec b/sample/sample-plugins/defer/multi-auth=2Ec</span><br><span=
>index bacf557=2E=2Ecdd616f 100644</span><br><span>--- a/sample/sample-plug=
ins/defer/multi-auth=2Ec</span><br><span>+++ b/sample/sample-plugins/defer/=
multi-auth=2Ec</span><br><span>@@ -255,7 +255,7 @@</span><br><span> }</span=
><br><span> </span><br><span> static bool</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-do_auth_user_pass(struct plugin_context *context, const=
 char *username, const char *password)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+do_auth_user_pass(const struct plugin_context *context, =
const char *username, const char *password)</span><br><span> {</span><br><s=
pan>     plog(context, PLOG_NOTE, &quot;expect_user=3D%s, received_user=3D%=
s, expect_passw=3D%s, received_passw=3D%s&quot;,</span><br><span>          =
np(context-&gt;test_valid_user), np(username), np(context-&gt;test_valid_pa=
ss), np(password));</span><br><span>@@ -279,7 +279,7 @@</span><br><span> </=
span><br><span> </span><br><span> static int</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-auth_user_pass_verify(struct plugin_context *context=
, struct plugin_per_client_context *pcc,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+auth_user_pass_verify(const struct plugin_context *con=
text, struct plugin_per_client_context *pcc,</span><br><span>              =
         const char *argv[], const char *envp[])</span><br><span> {</span><=
br><span>     /* get username/password from envp string array */</span><br>=
<span>diff --git a/sample/sample-plugins/keying-material-exporter-demo/keyi=
ngmaterialexporter=2Ec b/sample/sample-plugins/keying-material-exporter-dem=
o/keyingmaterialexporter=2Ec</span><br><span>index 204374b=2E=2E41c5c4f 100=
644</span><br><span>--- a/sample/sample-plugins/keying-material-exporter-de=
mo/keyingmaterialexporter=2Ec</span><br><span>+++ b/sample/sample-plugins/k=
eying-material-exporter-demo/keyingmaterialexporter=2Ec</span><br><span>@@ =
-187,7 +187,7 @@</span><br><span> }</span><br><span> </span><br><span> stat=
ic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-file_store(cha=
r *file, char *content)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+file_store(const char *file, const char *content)</span><br><span> {</s=
pan><br><span>     FILE *f;</span><br><span>     if (!(f =3D fopen(file, &q=
uot;w+&quot;)))</span><br><span>@@ -203,7 +203,7 @@</span><br><span> server=
_store(struct openvpn_plugin_args_func_in const *args)</span><br><span> {</=
span><br><span>     struct plugin *plugin =3D (struct plugin *)args-&gt;han=
dle;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct sessio=
n *sess =3D (struct session *)args-&gt;per_client_context;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const struct session *sess =3D a=
rgs-&gt;per_client_context;</span><br><span> </span><br><span>     char fil=
e[MAXPATH];</span><br><span>     snprintf(file, sizeof(file) - 1, &quot;/tm=
p/openvpn_sso_%s&quot;, sess-&gt;key);</span><br><span>@@ -215,7 +215,7 @@<=
/span><br><span> client_store(struct openvpn_plugin_args_func_in const *arg=
s)</span><br><span> {</span><br><span>     struct plugin *plugin =3D (struc=
t plugin *)args-&gt;handle;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    struct session *sess =3D (struct session *)args-&gt;per_client_co=
ntext;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const str=
uct session *sess =3D args-&gt;per_client_context;</span><br><span> </span>=
<br><span>     char *file =3D &quot;/tmp/openvpn_sso_user&quot;;</span><br>=
<span>     ovpn_note(&quot;app session file: %s&quot;, file);</span><br><sp=
an>diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><=
span>index 58e10f0=2E=2E063a2d4 100644</span><br><span>--- a/src/openvpn/bu=
ffer=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -1=
920,7 +1920,7 @@</span><br><span>  * @param a  The arena to test=2E</span><=
br><span>  */</span><br><span> static inline bool</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-gc_defined(struct gc_arena *a)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+gc_defined(const struct gc_arena *a)=
</span><br><span> {</span><br><span>     return a-&gt;list !=3D NULL;</span=
><br><span> }</span><br><span>diff --git a/src/openvpn/clinat=2Ec b/src/ope=
nvpn/clinat=2Ec</span><br><span>index dcef924=2E=2Ed72d42a 100644</span><br=
><span>--- a/src/openvpn/clinat=2Ec</span><br><span>+++ b/src/openvpn/clina=
t=2Ec</span><br><span>@@ -158,7 +158,7 @@</span><br><span> #endif</span><br=
><span> </span><br><span> static void</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-print_pkt(struct openvpn_iphdr *iph, const char *prefix, co=
nst int direction, const msglvl_t msglevel)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+print_pkt(const struct openvpn_iphdr *iph, const ch=
ar *prefix, const int direction, const msglvl_t msglevel)</span><br><span> =
{</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span> </=
span><br><span>diff --git a/src/openvpn/comp=2Ec b/src/openvpn/comp=2Ec</sp=
an><br><span>index b88b79f=2E=2E387a7c4 100644</span><br><span>--- a/src/op=
envpn/comp=2Ec</span><br><span>+++ b/src/openvpn/comp=2Ec</span><br><span>@=
@ -159,7 +159,7 @@</span><br><span> #endif /* USE_COMP */</span><br><span> =
</span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-check_compression_settings_valid(struct compress_options *info, msglvl_t m=
sglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_compr=
ession_settings_valid(const struct compress_options *info, msglvl_t msgleve=
l)</span><br><span> {</span><br><span>     /*</span><br><span>      * We al=
so allow comp-stub-v2 here as it technically allows escaping of</span><br><=
span>diff --git a/src/openvpn/comp=2Eh b/src/openvpn/comp=2Eh</span><br><sp=
an>index 29a90a2=2E=2Ead80243 100644</span><br><span>--- a/src/openvpn/comp=
=2Eh</span><br><span>+++ b/src/openvpn/comp=2Eh</span><br><span>@@ -91,7 +9=
1,7 @@</span><br><span>  * flags of allow-compression and also the whether =
algorithms are compiled</span><br><span>  * in</span><br><span>  */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-bool check_compression_settin=
gs_valid(struct compress_options *info, msglvl_t msglevel);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+bool check_compression_settings_val=
id(const struct compress_options *info, msglvl_t msglevel);</span><br><span=
> </span><br><span> #ifdef USE_COMP</span><br><span> #include &quot;buffer=
=2Eh&quot;</span><br><span>diff --git a/src/openvpn/crypto=2Ec b/src/openvp=
n/crypto=2Ec</span><br><span>index 1703d4d=2E=2E3d3ab0c 100644</span><br><s=
pan>--- a/src/openvpn/crypto=2Ec</span><br><span>+++ b/src/openvpn/crypto=
=2Ec</span><br><span>@@ -1105,7 +1105,7 @@</span><br><span> }</span><br><sp=
an> </span><br><span> static bool</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-key_is_zero(struct key *key, const struct key_type *kt)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+key_is_zero(const struct ke=
y *key, const struct key_type *kt)</span><br><span> {</span><br><span>     =
size_t cipher_length =3D cipher_kt_key_size(kt-&gt;cipher);</span><br><span=
>     for (size_t i =3D 0; i &lt; cipher_length; ++i)</span><br><span>@@ -1=
123,7 +1123,7 @@</span><br><span>  * Make sure that cipher key is a valid k=
ey for current key_type=2E</span><br><span>  */</span><br><span> bool</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-check_key(struct key *key, =
const struct key_type *kt)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+check_key(const struct key *key, const struct key_type *kt)</span><b=
r><span> {</span><br><span>     if (cipher_defined(kt-&gt;cipher))</span><b=
r><span>     {</span><br><span>@@ -1196,7 +1196,7 @@</span><br><span> }</sp=
an><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-test_crypto(struct crypto_options *co, struct frame *frame)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_crypto(struct c=
rypto_options *co, const struct frame *frame)</span><br><span> {</span><br>=
<span>     int i, j;</span><br><span>     struct gc_arena gc =3D gc_new();<=
/span><br><span>diff --git a/src/openvpn/crypto=2Eh b/src/openvpn/crypto=2E=
h</span><br><span>index ee5b50f=2E=2Ee3c1c6a 100644</span><br><span>--- a/s=
rc/openvpn/crypto=2Eh</span><br><span>+++ b/src/openvpn/crypto=2Eh</span><b=
r><span>@@ -414,7 +414,7 @@</span><br><span>  */</span><br><span> int write=
_key_file(const int nkeys, const char *filename);</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-bool check_key(struct key *ke=
y, const struct key_type *kt);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+bool check_key(const struct key *key, const struct key_type *kt)=
;</span><br><span> </span><br><span> /**</span><br><span>  * Initialize a k=
ey_type structure with=2E</span><br><span>@@ -614,7 +614,7 @@</span><br><sp=
an> /** Print a cipher list entry */</span><br><span> void print_cipher(con=
st char *cipher);</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-void test_crypto(struct crypto_options *co, struct frame *f);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_crypto(st=
ruct crypto_options *co, const struct frame *f);</span><br><span> </span><b=
r><span> </span><br><span> /* key direction functions */</span><br><span>di=
ff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</span><br><span>index =
9fc0e3b=2E=2Ef3b5d44 100644</span><br><span>--- a/src/openvpn/dco=2Ec</span=
><br><span>+++ b/src/openvpn/dco=2Ec</span><br><span>@@ -573,7 +573,7 @@</s=
pan><br><span> }</span><br><span> </span><br><span> static bool</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-dco_multi_get_localaddr(struct mu=
lti_context *m, struct multi_instance *mi,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+dco_multi_get_localaddr(const struct multi_context *=
m, const struct multi_instance *mi,</span><br><span>                       =
  struct sockaddr_storage *local)</span><br><span> {</span><br><span> #if E=
NABLE_IP_PKTINFO</span><br><span>@@ -585,7 +585,7 @@</span><br><span>      =
   return false;</span><br><span>     }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    struct link_socket_actual *actual =
=3D &amp;c-&gt;c2=2Elink_socket_infos[0]-&gt;lsa-&gt;actual;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const struct link_socket_actua=
l *actual =3D &amp;c-&gt;c2=2Elink_socket_infos[0]-&gt;lsa-&gt;actual;</spa=
n><br><span> </span><br><span>     switch (actual-&gt;dest=2Eaddr=2Esa=2Esa=
_family)</span><br><span>     {</span><br><span>@@ -623,7 +623,7 @@</span><=
br><span> }</span><br><span> </span><br><span> int</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-dco_multi_add_new_peer(struct multi_context *m=
, struct multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+dco_multi_add_new_peer(const struct multi_context *m, struct multi=
_instance *mi)</span><br><span> {</span><br><span>     const struct context=
 *c =3D &amp;mi-&gt;context;</span><br><span> </span><br><span>@@ -677,7 +6=
77,7 @@</span><br><span> }</span><br><span> </span><br><span> void</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-dco_install_iroute(struct mult=
i_context *m, struct multi_instance *mi, struct mroute_addr *addr)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+dco_install_iroute(struct mu=
lti_context *m, struct multi_instance *mi, const struct mroute_addr *addr)<=
/span><br><span> {</span><br><span> #if defined(TARGET_LINUX) || defined(TA=
RGET_FREEBSD) || defined(_WIN32)</span><br><span>     if (!dco_enabled(&amp=
;m-&gt;top=2Eoptions))</span><br><span>diff --git a/src/openvpn/dco=2Eh b/s=
rc/openvpn/dco=2Eh</span><br><span>index 7ef75fee=2E=2Ec435f8c 100644</span=
><br><span>--- a/src/openvpn/dco=2Eh</span><br><span>+++ b/src/openvpn/dco=
=2Eh</span><br><span>@@ -204,7 +204,7 @@</span><br><span>  * @param mi     =
   the client instance</span><br><span>  * @return          0 on success or=
 a negative error code otherwise</span><br><span>  */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-int dco_multi_add_new_peer(struct multi_con=
text *m, struct multi_instance *mi);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+int dco_multi_add_new_peer(const struct multi_context *m, =
struct multi_instance *mi);</span><br><span> </span><br><span> /**</span><b=
r><span>  * Install an iroute in DCO, which means adding a route to the sys=
tem routing</span><br><span>@@ -215,7 +215,7 @@</span><br><span>  * @param =
addr      the route to add</span><br><span>  */</span><br><span> void dco_i=
nstall_iroute(struct multi_context *m, struct multi_instance *mi,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                        struct =
mroute_addr *addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                        const struct mroute_addr *addr);</span><br><span> <=
/span><br><span> /**</span><br><span>  * Remove all routes added through th=
e specified client</span><br><span>@@ -253,7 +253,7 @@</span><br><span>  * =
a 64 bit packet counter and AEAD tag at the end=2E</span><br><span>  */</sp=
an><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco=
_supports_epoch_data(struct context *c);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+dco_supports_epoch_data(const struct context *c);</spa=
n><br><span> #else  /* if defined(ENABLE_DCO) */</span><br><span> </span><b=
r><span> typedef void *dco_context_t;</span><br><span>@@ -350,7 +350,7 @@</=
span><br><span> }</span><br><span> </span><br><span> static inline int</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_multi_add_new_peer(str=
uct multi_context *m, struct multi_instance *mi)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+dco_multi_add_new_peer(const struct multi_cont=
ext *m, struct multi_instance *mi)</span><br><span> {</span><br><span>     =
return 0;</span><br><span> }</span><br><span>@@ -384,7 +384,7 @@</span><br>=
<span> }</span><br><span> </span><br><span> static inline bool</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-dco_supports_epoch_data(struct con=
text *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_support=
s_epoch_data(const struct context *c)</span><br><span> {</span><br><span>  =
   return false;</span><br><span> }</span><br><span>diff --git a/src/openvp=
n/dco_freebsd=2Ec b/src/openvpn/dco_freebsd=2Ec</span><br><span>index 87eea=
55=2E=2E3148f10 100644</span><br><span>--- a/src/openvpn/dco_freebsd=2Ec</s=
pan><br><span>+++ b/src/openvpn/dco_freebsd=2Ec</span><br><span>@@ -929,7 +=
929,7 @@</span><br><span> }</span><br><span> </span><br><span> bool</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-dco_supports_epoch_data(struc=
t context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_su=
pports_epoch_data(const struct context *c)</span><br><span> {</span><br><sp=
an>     return false;</span><br><span> }</span><br><span>diff --git a/src/o=
penvpn/dco_internal=2Eh b/src/openvpn/dco_internal=2Eh</span><br><span>inde=
x fcf8aca=2E=2E1022e66 100644</span><br><span>--- a/src/openvpn/dco_interna=
l=2Eh</span><br><span>+++ b/src/openvpn/dco_internal=2Eh</span><br><span>@@=
 -59,8 +59,9 @@</span><br><span>  * They are implemented by dco_linux=2Ec</=
span><br><span>  */</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-int dco_new_peer(dco_context_t *dco, unsigned int peerid, s=
ocket_descriptor_t sd, struct sockaddr *localaddr,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                 struct sockaddr *remoteaddr, =
const struct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+int dco_new_peer(dco_context_=
t *dco, unsigned int peerid, socket_descriptor_t sd,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                 struct sockaddr *localad=
dr, struct sockaddr *remoteaddr,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                 const struct in_addr *vpn_ipv4, const struct =
in6_addr *vpn_ipv6);</span><br><span> </span><br><span> int dco_del_peer(dc=
o_context_t *dco, unsigned int peerid);</span><br><span> </span><br><span>d=
iff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec</span><br=
><span>index a397fb8=2E=2E4412ad0 100644</span><br><span>--- a/src/openvpn/=
dco_linux=2Ec</span><br><span>+++ b/src/openvpn/dco_linux=2Ec</span><br><sp=
an>@@ -104,7 +104,7 @@</span><br><span> }</span><br><span> </span><br><span=
> static struct nl_msg *</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-ovpn_dco_nlmsg_create(dco_context_t *dco, uint8_t cmd)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ovpn_dco_nlmsg_create(const dco_conte=
xt_t *dco, uint8_t cmd)</span><br><span> {</span><br><span>     struct nl_m=
sg *nl_msg =3D nlmsg_alloc();</span><br><span>     if (!nl_msg)</span><br><=
span>@@ -842,7 +842,7 @@</span><br><span> </span><br><span> /* libnl &lt; 3=
=2E11=2E0 does not implement nla_get_uint() */</span><br><span> static uint=
64_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_nla_get_uint=
(struct nlattr *attr)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ovpn_nla_get_uint(const struct nlattr *attr)</span><br><span> {</span><br=
><span>     if (nla_len(attr) =3D=3D sizeof(uint32_t))</span><br><span>    =
 {</span><br><span>@@ -954,7 +954,7 @@</span><br><span> }</span><br><span> =
</span><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-ovpn_iface_check(dco_context_t *dco, struct nlattr *attrs[])</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_iface_check(const dco=
_context_t *dco, struct nlattr *attrs[])</span><br><span> {</span><br><span=
>     /* we must know which interface this message is referring to in order=
 to</span><br><span>      * avoid mixing messages for other instances</span=
><br><span>@@ -1381,7 +1381,7 @@</span><br><span> }</span><br><span> </span=
><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_s=
upports_epoch_data(struct context *c)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+dco_supports_epoch_data(const struct context *c)</span><b=
r><span> {</span><br><span>     return false;</span><br><span> }</span><br>=
<span>diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec</span>=
<br><span>index 6e5e295=2E=2E12b0666 100644</span><br><span>--- a/src/openv=
pn/dco_win=2Ec</span><br><span>+++ b/src/openvpn/dco_win=2Ec</span><br><spa=
n>@@ -1092,7 +1092,7 @@</span><br><span> }</span><br><span> </span><br><spa=
n> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_supports_e=
poch_data(struct context *c)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+dco_supports_epoch_data(const struct context *c)</span><br><span> =
{</span><br><span>     OVPN_VERSION ver =3D { 0 };</span><br><span>     ret=
urn dco_get_version(&amp;ver) &amp;&amp; ((ver=2EMajor =3D=3D 2 &amp;&amp; =
ver=2EMinor &gt;=3D 8) || (ver=2EMajor &gt; 2));</span><br><span>diff --git=
 a/src/openvpn/error=2Ec b/src/openvpn/error=2Ec</span><br><span>index 26d4=
c7c=2E=2E32d819d 100644</span><br><span>--- a/src/openvpn/error=2Ec</span><=
br><span>+++ b/src/openvpn/error=2Ec</span><br><span>@@ -623,7 +623,7 @@</s=
pan><br><span>  * from the OS=2E</span><br><span>  */</span><br><span> void=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-x_check_status(ssize_=
t status, const char *description, struct link_socket *sock, struct tuntap =
*tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+x_check_status(=
ssize_t status, const char *description, struct link_socket *sock, const st=
ruct tuntap *tt)</span><br><span> {</span><br><span>     const char *extend=
ed_msg =3D NULL;</span><br><span> </span><br><span>diff --git a/src/openvpn=
/error=2Eh b/src/openvpn/error=2Eh</span><br><span>index 9f39572=2E=2E373cb=
c1 100644</span><br><span>--- a/src/openvpn/error=2Eh</span><br><span>+++ b=
/src/openvpn/error=2Eh</span><br><span>@@ -304,10 +304,10 @@</span><br><spa=
n> void set_check_status(unsigned int info_level, unsigned int verbose_leve=
l);</span><br><span> </span><br><span> void x_check_status(ssize_t status, =
const char *description, struct link_socket *sock,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                    struct tuntap *tt);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                    const =
struct tuntap *tt);</span><br><span> </span><br><span> static inline void</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_status(ssize_t st=
atus, const char *description, struct link_socket *sock, struct tuntap *tt)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_status(ssize_=
t status, const char *description, struct link_socket *sock, const struct t=
untap *tt)</span><br><span> {</span><br><span>     if (status &lt; 0 || che=
ck_debug_level(x_cs_verbose_level))</span><br><span>     {</span><br><span>=
diff --git a/src/openvpn/event=2Ec b/src/openvpn/event=2Ec</span><br><span>=
index 4089401=2E=2E5e17ea1 100644</span><br><span>--- a/src/openvpn/event=
=2Ec</span><br><span>+++ b/src/openvpn/event=2Ec</span><br><span>@@ -1012,7=
 +1012,7 @@</span><br><span> }</span><br><span> </span><br><span> static in=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-se_wait_return(struc=
t se_set *ses, fd_set *read, fd_set *write, struct event_set_return *out,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+se_wait_return(struct=
 se_set *ses, const fd_set *read, const fd_set *write, struct event_set_ret=
urn *out,</span><br><span>                int outlen)</span><br><span> {</s=
pan><br><span>     int i, j =3D 0;</span><br><span>diff --git a/src/openvpn=
/event=2Eh b/src/openvpn/event=2Eh</span><br><span>index b784dfe=2E=2E0940a=
1d 100644</span><br><span>--- a/src/openvpn/event=2Eh</span><br><span>+++ b=
/src/openvpn/event=2Eh</span><br><span>@@ -204,7 +204,7 @@</span><br><span>=
 #else /* ifdef _WIN32 */</span><br><span> </span><br><span> static inline =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-wait_signal(struc=
t event_set *es, void *arg)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+wait_signal(const struct event_set *es, const void *arg)</span><br>=
<span> {</span><br><span> }</span><br><span> </span><br><span>diff --git a/=
src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index b97=
fb7a=2E=2E681210d 100644</span><br><span>--- a/src/openvpn/forward=2Ec</spa=
n><br><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -237,7 +237,7 =
@@</span><br><span> }</span><br><span> </span><br><span> static void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-parse_incoming_control_chann=
el_command(struct context *c, struct buffer *buf)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+parse_incoming_control_channel_command(struct=
 context *c, const struct buffer *buf)</span><br><span> {</span><br><span> =
    if (buf_string_match_head_str(buf, &quot;AUTH_FAILED&quot;))</span><br>=
<span>     {</span><br><span>@@ -507,7 +507,7 @@</span><br><span> }</span><=
br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-get_server_poll_remaining_time(struct event_timeout *server_poll_=
timeout)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_server_=
poll_remaining_time(const struct event_timeout *server_poll_timeout)</span>=
<br><span> {</span><br><span>     update_time();</span><br><span>     int r=
emaining =3D event_timeout_remaining(server_poll_timeout);</span><br><span>=
@@ -621,7 +621,7 @@</span><br><span>  * Buffer reallocation, for use with n=
ull encryption=2E</span><br><span>  */</span><br><span> static inline void<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-buffer_turnover(const =
uint8_t *orig_buf, struct buffer *dest_stub, struct buffer *src_stub,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+buffer_turnover(const uin=
t8_t *orig_buf, struct buffer *dest_stub, const struct buffer *src_stub,</s=
pan><br><span>                 struct buffer *storage)</span><br><span> {</=
span><br><span>     if (orig_buf =3D=3D src_stub-&gt;data &amp;&amp; src_st=
ub-&gt;data !=3D storage-&gt;data)</span><br><span>@@ -908,7 +908,7 @@</spa=
n><br><span>  */</span><br><span> </span><br><span> static inline void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-socks_postprocess_incoming=
_link(struct context *c, struct link_socket *sock)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+socks_postprocess_incoming_link(struct conte=
xt *c, const struct link_socket *sock)</span><br><span> {</span><br><span> =
    if (sock-&gt;socks_proxy &amp;&amp; sock-&gt;info=2Eproto =3D=3D PROTO_=
UDP)</span><br><span>     {</span><br><span>@@ -1005,7 +1005,7 @@</span><br=
><span> }</span><br><span> </span><br><span> bool</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-process_incoming_link_part1(struct context *c, =
struct link_socket_info *lsi, bool floated)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+process_incoming_link_part1(struct context *c, cons=
t struct link_socket_info *lsi, bool floated)</span><br><span> {</span><br>=
<span>     struct gc_arena gc =3D gc_new();</span><br><span>     bool decry=
pt_status =3D false;</span><br><span>@@ -1555,7 +1555,7 @@</span><br><span>=
  * @param client    Determines whether to the send packet back via tun or =
link</span><br><span>  */</span><br><span> void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-ipv6_send_icmp_unreachable(struct context *c, str=
uct buffer *buf, bool client)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ipv6_send_icmp_unreachable(struct context *c, const struct buffer=
 *buf, bool client)</span><br><span> {</span><br><span> #define MAX_ICMPV6L=
EN 1280</span><br><span>     struct openvpn_icmp6hdr icmp6out;</span><br><s=
pan>diff --git a/src/openvpn/forward=2Eh b/src/openvpn/forward=2Eh</span><b=
r><span>index 0309725=2E=2E375635b 100644</span><br><span>--- a/src/openvpn=
/forward=2Eh</span><br><span>+++ b/src/openvpn/forward=2Eh</span><br><span>=
@@ -126,7 +126,7 @@</span><br><span>  */</span><br><span> void encrypt_sign=
(struct context *c, bool comp_frag);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-int get_server_poll_remaining_time(struct =
event_timeout *server_poll_timeout);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+int get_server_poll_remaining_time(const struct event_time=
out *server_poll_timeout);</span><br><span> </span><br><span> /************=
**********************************************************/</span><br><span=
> /**</span><br><span>@@ -177,7 +177,7 @@</span><br><span>  *</span><br><sp=
an>  * @return true if packet is authenticated, false otherwise=2E</span><b=
r><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool proc=
ess_incoming_link_part1(struct context *c, struct link_socket_info *lsi, bo=
ol floated);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool pr=
ocess_incoming_link_part1(struct context *c, const struct link_socket_info =
*lsi, bool floated);</span><br><span> </span><br><span> /**</span><br><span=
>  * Continues processing a packet read from the external network interface=
=2E</span><br><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2E=
c</span><br><span>index 9306a96=2E=2E3c2ebf9 100644</span><br><span>--- a/s=
rc/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><s=
pan>@@ -803,7 +803,7 @@</span><br><span> }</span><br><span> </span><br><spa=
n> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-init_po=
rt_share(struct context *c)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+init_port_share(const struct context *c)</span><br><span> {</span><=
br><span>     if (!port_share &amp;&amp; (c-&gt;options=2Eport_share_host &=
amp;&amp; c-&gt;options=2Eport_share_port))</span><br><span>     {</span><b=
r><span>@@ -1245,7 +1245,7 @@</span><br><span>  * prepending to msg() outpu=
t=2E</span><br><span>  */</span><br><span> const char *</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-format_common_name(struct context *c, str=
uct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fo=
rmat_common_name(const struct context *c, struct gc_arena *gc)</span><br><s=
pan> {</span><br><span>     struct buffer out =3D alloc_buf_gc(256, gc);</s=
pan><br><span>     if (c-&gt;c2=2Etls_multi)</span><br><span>@@ -1731,7 +17=
31,7 @@</span><br><span> </span><br><span> </span><br><span> static bool</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-can_preserve_tun(struct =
tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+can_pres=
erve_tun(const struct tuntap *tt)</span><br><span> {</span><br><span>     i=
f (tt &amp;&amp; tt-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</span><br><spa=
n>     {</span><br><span>@@ -1753,7 +1753,7 @@</span><br><span>  * @param c=
 pointer to the connection context</span><br><span>  */</span><br><span> st=
atic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-add_wfp_bloc=
k(struct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+add_wfp_block(const struct context *c)</span><br><span> {</span><br><span>=
 #if defined(_WIN32)</span><br><span>     /* Fortify &#39;redirect-gateway =
block-local&#39; with firewall rules? */</span><br><span>@@ -1779,7 +1779,7=
 @@</span><br><span>  * @param adapter_index the VPN adapter index</span><b=
r><span>  */</span><br><span> static void</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-del_wfp_block(struct context *c, unsigned long adapter_=
index)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+del_wfp_block=
(const struct context *c, unsigned long adapter_index)</span><br><span> {</=
span><br><span> #if defined(_WIN32)</span><br><span>     if (c-&gt;options=
=2Eblock_outside_dns || block_local_needed(c-&gt;c1=2Eroute_list))</span><b=
r><span>diff --git a/src/openvpn/init=2Eh b/src/openvpn/init=2Eh</span><br>=
<span>index ce8f74e=2E=2Ec486158 100644</span><br><span>--- a/src/openvpn/i=
nit=2Eh</span><br><span>+++ b/src/openvpn/init=2Eh</span><br><span>@@ -91,7=
 +91,7 @@</span><br><span> </span><br><span> uint64_t pull_permission_mask(=
const struct context *c);</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-const char *format_common_name(struct context *c, str=
uct gc_arena *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+c=
onst char *format_common_name(const struct context *c, struct gc_arena *gc)=
;</span><br><span> </span><br><span> void reset_coarse_timers(struct contex=
t *c);</span><br><span> </span><br><span>diff --git a/src/openvpn/interval=
=2Eh b/src/openvpn/interval=2Eh</span><br><span>index 59051bd=2E=2E0cfe202 =
100644</span><br><span>--- a/src/openvpn/interval=2Eh</span><br><span>+++ b=
/src/openvpn/interval=2Eh</span><br><span>@@ -89,7 +89,7 @@</span><br><span=
> }</span><br><span> </span><br><span> static inline void</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-interval_schedule_wakeup(struct interva=
l *top, interval_t *wakeup)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+interval_schedule_wakeup(const struct interval *top, interval_t *wa=
keup)</span><br><span> {</span><br><span>     const time_t local_now =3D no=
w;</span><br><span>     interval_earliest_wakeup(wakeup, top-&gt;last_test_=
true + top-&gt;refresh, local_now);</span><br><span>@@ -214,7 +214,7 @@</sp=
an><br><span>  * This function does not check if the timeout is actually va=
lid=2E</span><br><span>  */</span><br><span> static inline interval_t</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-event_timeout_remaining(str=
uct event_timeout *et)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+event_timeout_remaining(const struct event_timeout *et)</span><br><span>=
 {</span><br><span>     return (interval_t)((et-&gt;last + et-&gt;n) - now)=
;</span><br><span> }</span><br><span>diff --git a/src/openvpn/list=2Ec b/sr=
c/openvpn/list=2Ec</span><br><span>index e51dcd0=2E=2Edcd59d7 100644</span>=
<br><span>--- a/src/openvpn/list=2Ec</span><br><span>+++ b/src/openvpn/list=
=2Ec</span><br><span>@@ -164,7 +164,7 @@</span><br><span> }</span><br><span=
> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-hash_remove_by_value(struct hash *hash, void *value)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+hash_remove_by_value(struct hash *hash,=
 const void *value)</span><br><span> {</span><br><span>     struct hash_ite=
rator hi;</span><br><span>     const struct hash_element *he;</span><br><sp=
an>diff --git a/src/openvpn/list=2Eh b/src/openvpn/list=2Eh</span><br><span=
>index 55bc3c8=2E=2E23267d0 100644</span><br><span>--- a/src/openvpn/list=
=2Eh</span><br><span>+++ b/src/openvpn/list=2Eh</span><br><span>@@ -78,7 +7=
8,7 @@</span><br><span> </span><br><span> bool hash_remove_fast(struct hash=
 *hash, struct hash_bucket *bucket, const void *key, uint64_t hv);</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void hash_re=
move_by_value(struct hash *hash, void *value);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void hash_remove_by_value(struct hash *hash, con=
st void *value);</span><br><span> </span><br><span> struct hash_iterator</s=
pan><br><span> {</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/=
openvpn/manage=2Ec</span><br><span>index 0aef2d4=2E=2E1e74f09 100644</span>=
<br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/ma=
nage=2Ec</span><br><span>@@ -330,7 +330,7 @@</span><br><span> }</span><br><=
span> </span><br><span> static void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-man_delete_unix_socket(struct management *man)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+man_delete_unix_socket(const struc=
t management *man)</span><br><span> {</span><br><span> #if UNIX_SOCK_SUPPOR=
T</span><br><span>     if ((man-&gt;settings=2Eflags &amp; (MF_UNIX_SOCK | =
MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)</span><br><span>@@ -676,7 +676,=
7 @@</span><br><span>  * for the log and echo commands=2E</span><br><span> =
 */</span><br><span> static void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-man_history(struct management *man, const char *parm, const char=
 *type, struct log_history *log,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+man_history(struct management *man, const char *parm, const ch=
ar *type, const struct log_history *log,</span><br><span>             bool =
*realtime, const unsigned int lep_flags)</span><br><span> {</span><br><span=
>     struct gc_arena gc =3D gc_new();</span><br><span>@@ -852,7 +852,7 @@<=
/span><br><span> }</span><br><span> </span><br><span> static void</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-man_net(struct management *man)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_net(const struc=
t management *man)</span><br><span> {</span><br><span>     if (man-&gt;pers=
ist=2Ecallback=2Eshow_net)</span><br><span>     {</span><br><span>@@ -888,7=
 +888,7 @@</span><br><span> #ifdef ENABLE_PKCS11</span><br><span> </span><b=
r><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-m=
an_pkcs11_id_count(struct management *man)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+man_pkcs11_id_count(const struct management *man)</s=
pan><br><span> {</span><br><span>     msg(M_CLIENT, &quot;&gt;PKCS11ID-COUN=
T:%d&quot;, pkcs11_management_id_count());</span><br><span> }</span><br><sp=
an>@@ -2366,7 +2366,7 @@</span><br><span>  * the route/ifconfig/open tun co=
mmand=2E   See doc/android=2Etxt for details=2E</span><br><span>  */</span>=
<br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-manage=
ment_android_control(struct management *man, const char *command, const cha=
r *msg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_a=
ndroid_control(const struct management *man, const char *command, const cha=
r *msg)</span><br><span> {</span><br><span>     if (!man)</span><br><span> =
    {</span><br><span>@@ -3013,7 +3013,7 @@</span><br><span> }</span><br><s=
pan> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-management_up_down(struct management *man, const char *updown, const =
struct env_set *es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
management_up_down(const struct management *man, const char *updown, const =
struct env_set *es)</span><br><span> {</span><br><span>     if (man-&gt;set=
tings=2Eflags &amp; MF_UP_DOWN)</span><br><span>     {</span><br><span>@@ -=
3208,7 +3208,7 @@</span><br><span> }</span><br><span> </span><br><span> voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-management_auth_fail=
ure(struct management *man, const char *type, const char *reason)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+management_auth_failure(const=
 struct management *man, const char *type, const char *reason)</span><br><s=
pan> {</span><br><span>     if (reason)</span><br><span>     {</span><br><s=
pan>diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh</span><br>=
<span>index 1e7855d=2E=2Ef2c6916 100644</span><br><span>--- a/src/openvpn/m=
anage=2Eh</span><br><span>+++ b/src/openvpn/manage=2Eh</span><br><span>@@ -=
368,7 +368,7 @@</span><br><span>                                 const unsi=
gned int flags, const char *static_challenge);</span><br><span> </span><br>=
<span> #ifdef TARGET_ANDROID</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-bool management_android_control(struct management *man, const char *=
command, const char *msg);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+bool management_android_control(const struct management *man, const =
char *command, const char *msg);</span><br><span> </span><br><span> #define=
 ANDROID_KEEP_OLD_TUN      1</span><br><span> #define ANDROID_OPEN_BEFORE_C=
LOSE 2</span><br><span>@@ -382,7 +382,7 @@</span><br><span> </span><br><spa=
n> void management_event_loop_n_seconds(struct management *man, int sec);</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void =
management_up_down(struct management *man, const char *updown, const struct=
 env_set *es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void =
management_up_down(const struct management *man, const char *updown, const =
struct env_set *es);</span><br><span> </span><br><span> void management_not=
ify(const char *severity, const char *type,</span><br><span>               =
         const char *text);</span><br><span>@@ -482,7 +482,7 @@</span><br><=
span>  * OpenVPN calls here to indicate a password failure</span><br><span>=
  */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-void management_auth_failure(struct management *man, const char *type, con=
st char *reason);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id management_auth_failure(const struct management *man, const char *type, =
const char *reason);</span><br><span> </span><br><span> /*</span><br><span>=
  * Echo an authentication token to management interface</span><br><span>di=
ff --git a/src/openvpn/mbuf=2Ec b/src/openvpn/mbuf=2Ec</span><br><span>inde=
x 5bb397f=2E=2E163251c 100644</span><br><span>--- a/src/openvpn/mbuf=2Ec</s=
pan><br><span>+++ b/src/openvpn/mbuf=2Ec</span><br><span>@@ -165,7 +165,7 @=
@</span><br><span> }</span><br><span> </span><br><span> void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-mbuf_dereference_instance(struct mbu=
f_set *ms, struct multi_instance *mi)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+mbuf_dereference_instance(struct mbuf_set *ms, const stru=
ct multi_instance *mi)</span><br><span> {</span><br><span>     if (ms)</spa=
n><br><span>     {</span><br><span>diff --git a/src/openvpn/mbuf=2Eh b/src/=
openvpn/mbuf=2Eh</span><br><span>index cfe698c=2E=2Ee368054 100644</span><b=
r><span>--- a/src/openvpn/mbuf=2Eh</span><br><span>+++ b/src/openvpn/mbuf=
=2Eh</span><br><span>@@ -75,7 +75,7 @@</span><br><span> </span><br><span> b=
ool mbuf_extract_item(struct mbuf_set *ms, struct mbuf_item *item);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void mbuf_d=
ereference_instance(struct mbuf_set *ms, struct multi_instance *mi);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+void mbuf_dereference_inst=
ance(struct mbuf_set *ms, const struct multi_instance *mi);</span><br><span=
> </span><br><span> static inline bool</span><br><span> mbuf_defined(const =
struct mbuf_set *ms)</span><br><span>diff --git a/src/openvpn/mss=2Ec b/src=
/openvpn/mss=2Ec</span><br><span>index 36bbb43=2E=2E0cfa272d 100644</span><=
br><span>--- a/src/openvpn/mss=2Ec</span><br><span>+++ b/src/openvpn/mss=2E=
c</span><br><span>@@ -239,8 +239,8 @@</span><br><span> }</span><br><span> <=
/span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-frame_calculate_fragment(struct frame *frame, struct key_type *kt, c=
onst struct options *options,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                         struct link_socket_info *lsi)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+frame_calculate_fragment(struct =
frame *frame, const struct key_type *kt, const struct options *options,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
  const struct link_socket_info *lsi)</span><br><span> {</span><br><span> #=
if defined(ENABLE_FRAGMENT)</span><br><span>     size_t overhead;</span><br=
><span>@@ -269,8 +269,8 @@</span><br><span> }</span><br><span> </span><br><=
span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fram=
e_calculate_mssfix(struct frame *frame, struct key_type *kt, const struct o=
ptions *options,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                  struct link_socket_info *lsi)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+frame_calculate_mssfix(struct frame *frame, con=
st struct key_type *kt, const struct options *options,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                       const struct link=
_socket_info *lsi)</span><br><span> {</span><br><span>     if (options-&gt;=
ce=2Emssfix_fixed)</span><br><span>     {</span><br><span>@@ -314,8 +314,8 =
@@</span><br><span> }</span><br><span> </span><br><span> void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-frame_calculate_dynamic(struct fram=
e *frame, struct key_type *kt, const struct options *options,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                        struct link=
_socket_info *lsi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+f=
rame_calculate_dynamic(struct frame *frame, const struct key_type *kt, cons=
t struct options *options,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                        const struct link_socket_info *lsi)</span><b=
r><span> {</span><br><span>     if (options-&gt;ce=2Efragment &gt; 0)</span=
><br><span>     {</span><br><span>diff --git a/src/openvpn/mss=2Eh b/src/op=
envpn/mss=2Eh</span><br><span>index 1d092bb=2E=2E2eab55a 100644</span><br><=
span>--- a/src/openvpn/mss=2Eh</span><br><span>+++ b/src/openvpn/mss=2Eh</s=
pan><br><span>@@ -36,8 +36,8 @@</span><br><span> void mss_fixup_dowork(stru=
ct buffer *buf, uint16_t maxmss);</span><br><span> </span><br><span> /** Se=
t the --mssfix option=2E */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-void frame_calculate_dynamic(struct frame *frame, struct key_type *kt=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
         const struct options *options, struct link_socket_info *lsi);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+void frame_calculate_dyn=
amic(struct frame *frame, const struct key_type *kt,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                             const struct=
 options *options, const struct link_socket_info *lsi);</span><br><span> </=
span><br><span> /**</span><br><span>  * Checks and adjusts the fragment and=
 mssfix value according to the</span><br><span>diff --git a/src/openvpn/mtc=
p=2Ec b/src/openvpn/mtcp=2Ec</span><br><span>index 4d173c4=2E=2Ec744638 100=
644</span><br><span>--- a/src/openvpn/mtcp=2Ec</span><br><span>+++ b/src/op=
envpn/mtcp=2Ec</span><br><span>@@ -67,7 +67,7 @@</span><br><span> }</span><=
br><span> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-multi_tcp_instance_specific_init(struct multi_context *m, struct=
 multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+multi_tcp_instance_specific_init(const struct multi_context *m, struct mul=
ti_instance *mi)</span><br><span> {</span><br><span>     /* buffer for queu=
ed TCP socket output packets */</span><br><span>     mi-&gt;tcp_link_out_de=
ferred =3D mbuf_init(m-&gt;top=2Eoptions=2En_bcast_buf);</span><br><span>di=
ff --git a/src/openvpn/mtcp=2Eh b/src/openvpn/mtcp=2Eh</span><br><span>inde=
x 9b7d1d2=2E=2Ebb117fa 100644</span><br><span>--- a/src/openvpn/mtcp=2Eh</s=
pan><br><span>+++ b/src/openvpn/mtcp=2Eh</span><br><span>@@ -35,7 +35,7 @@<=
/span><br><span> </span><br><span> void multi_tcp_dereference_instance(stru=
ct multi_io *multi_io, struct multi_instance *mi);</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-bool multi_tcp_instance_spec=
ific_init(struct multi_context *m, struct multi_instance *mi);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+bool multi_tcp_instance_specific=
_init(const struct multi_context *m, struct multi_instance *mi);</span><br>=
<span> </span><br><span> void multi_tcp_instance_specific_free(struct multi=
_instance *mi);</span><br><span> </span><br><span>diff --git a/src/openvpn/=
mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 69e30e5=2E=2E201d756 =
100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src=
/openvpn/mudp=2Ec</span><br><span>@@ -54,8 +54,9 @@</span><br><span>  * @pa=
ram sock    the socket to send the reply on</span><br><span>  */</span><br>=
<span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sen=
d_standalone_reply(struct multi_context *m, struct buffer *buf, const char =
*prefix,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
         const char *detail, struct link_socket *sock)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+send_standalone_reply(struct multi_conte=
xt *m, const struct buffer *buf,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                      const char *prefix, const char *detail,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
  struct link_socket *sock)</span><br><span> {</span><br><span>     struct =
context *c =3D &amp;m-&gt;top;</span><br><span> </span><br><span>@@ -75,7 +=
76,7 @@</span><br><span> </span><br><span> static void</span><br><span> sen=
d_hmac_reset_packet(struct multi_context *m, struct tls_pre_decrypt_state *=
state,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
        struct tls_auth_standalone *tas, struct session_id *sid,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                       const s=
truct tls_auth_standalone *tas, const struct session_id *sid,</span><br><sp=
an>                        bool request_resend_wkc, struct link_socket *soc=
k)</span><br><span> {</span><br><span>     reset_packet_id_send(&amp;state-=
&gt;tls_wrap_tmp=2Eopt=2Epacket_id=2Esend);</span><br><span>@@ -117,11 +118=
,11 @@</span><br><span> </span><br><span>     enum first_packet_verdict ver=
dict;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    struct tls_auth_standalone *tas =3D m-&gt;top=2Ec2=2Etls_auth_standal=
one;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struc=
t tls_auth_standalone *tas =3D m-&gt;top=2Ec2=2Etls_auth_standalone;</span>=
<br><span> </span><br><span>     verdict =3D tls_pre_decrypt_lite(tas, stat=
e, &amp;m-&gt;top=2Ec2=2Efrom, &amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *hmac_ke=
y =3D m-&gt;top=2Ec2=2Esession_id_key;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const uint8_t *hmac_key =3D m-&gt;top=2Ec2=2Esession=
_id_key;</span><br><span>     const struct openvpn_sockaddr *from =3D &amp;=
m-&gt;top=2Ec2=2Efrom=2Edest;</span><br><span>     int handwindow =3D m-&gt=
;top=2Eoptions=2Ehandshake_window;</span><br><span> </span><br><span>@@ -24=
0,7 +241,7 @@</span><br><span> static struct multi_instance *</span><br><sp=
an> handle_connection_attempt(struct multi_context *m,</span><br><span>    =
                       struct link_socket *sock,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                          struct mroute_addr *re=
al)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
          const struct mroute_addr *real)</span><br><span> {</span><br><spa=
n>     struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>@=
@ -308,7 +309,7 @@</span><br><span>  * @return      instance matching the a=
ddress, NULL otherwise</span><br><span>  */</span><br><span> static struct =
multi_instance *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi=
_get_instance_udp_real(struct multi_context *m, struct mroute_addr *real)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_get_instance_ud=
p_real(struct multi_context *m, const struct mroute_addr *real)</span><br><=
span> {</span><br><span>     struct hash *hash =3D m-&gt;hash;</span><br><s=
pan>     const uint64_t hv =3D hash_value(hash, real);</span><br><span>@@ -=
353,7 +354,9 @@</span><br><span>  * maintaining real address hash table ato=
micity=2E</span><br><span>  */</span><br><span> struct multi_instance *</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_get_instance_udp_da=
ta(struct multi_context *m, bool *floated, struct mroute_addr *real, struct=
 link_socket *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
multi_get_instance_udp_data(struct multi_context *m, bool *floated,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
 const struct mroute_addr *real,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                            const struct link_socket *sock)</s=
pan><br><span> {</span><br><span>     struct multi_instance *mi =3D NULL;</=
span><br><span> </span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/o=
penvpn/multi=2Ec</span><br><span>index dda9232=2E=2Ea2cfdbf 100644</span><b=
r><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=
=2Ec</span><br><span>@@ -58,7 +58,7 @@</span><br><span> </span><br><span> #=
ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span> static const char *</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-id(struct multi_instance *mi)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+id(const struct multi=
_instance *mi)</span><br><span> {</span><br><span>     if (mi)</span><br><s=
pan>     {</span><br><span>@@ -1336,7 +1336,7 @@</span><br><span>  * same c=
ommon name=2E</span><br><span>  */</span><br><span> static void</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-multi_delete_dup(struct multi_con=
text *m, struct multi_instance *new_mi)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+multi_delete_dup(struct multi_context *m, const struct =
multi_instance *new_mi)</span><br><span> {</span><br><span>     if (new_mi)=
</span><br><span>     {</span><br><span>@@ -2281,7 +2281,7 @@</span><br><sp=
an> }</span><br><span> </span><br><span> static bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-multi_client_setup_dco_initial(struct multi=
_context *m, struct multi_instance *mi,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+multi_client_setup_dco_initial(const struct multi_conte=
xt *m, struct multi_instance *mi,</span><br><span>                         =
       struct gc_arena *gc)</span><br><span> {</span><br><span>     if (!dc=
o_enabled(&amp;mi-&gt;context=2Eoptions))</span><br><span>@@ -2479,7 +2479,=
7 @@</span><br><span> }</span><br><span> </span><br><span> static bool</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_check_dest_addr_allo=
wed(struct multi_context *m, struct multi_instance *mi, struct mroute_addr =
*real);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_check_=
dest_addr_allowed(struct multi_context *m, struct multi_instance *mi, const=
 struct mroute_addr *real);</span><br><span> </span><br><span> /**</span><b=
r><span>  * This sets up the client real address (outer tunnel addr) in the=
</span><br><span>@@ -3130,7 +3130,8 @@</span><br><span>  * positive=2E</spa=
n><br><span>  */</span><br><span> static bool</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-multi_check_dest_addr_allowed(struct multi_context =
*m, struct multi_instance *mi, struct mroute_addr *real)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+multi_check_dest_addr_allowed(struct m=
ulti_context *m, struct multi_instance *mi,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                              const struct mroute_a=
ddr *real)</span><br><span> {</span><br><span>     struct hash *hash =3D m-=
&gt;hash;</span><br><span>     const uint64_t hv =3D hash_value(hash, real)=
;</span><br><span>@@ -3289,7 +3290,7 @@</span><br><span> </span><br><span> =
#if defined(ENABLE_DCO)</span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-process_incoming_del_peer(struct multi_cont=
ext *m, struct multi_instance *mi, dco_context_t *dco)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+process_incoming_del_peer(struct multi_c=
ontext *m, struct multi_instance *mi, const dco_context_t *dco)</span><br><=
span> {</span><br><span>     const char *reason =3D &quot;ovpn-dco: unknown=
 reason&quot;;</span><br><span>     switch (dco-&gt;dco_del_peer_reason)</s=
pan><br><span>@@ -4342,7 +4343,7 @@</span><br><span> </span><br><span> /* S=
earches for the address and deletes it if it is owned by the multi_instance=
 */</span><br><span> static void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-multi_unlearn_addr(struct multi_context *m, struct multi_instanc=
e *mi, const struct mroute_addr *addr)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+multi_unlearn_addr(struct multi_context *m, const struct=
 multi_instance *mi, const struct mroute_addr *addr)</span><br><span> {</sp=
an><br><span>     struct hash_element *he;</span><br><span>     const uint6=
4_t hv =3D hash_value(m-&gt;vhash, addr);</span><br><span>@@ -4377,7 +4378,=
7 @@</span><br><span>  * @param a     The new IPv4 address in network byte =
order</span><br><span>  */</span><br><span> static void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-multi_unlearn_in_addr_t(struct multi_cont=
ext *m, struct multi_instance *mi, in_addr_t a)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+multi_unlearn_in_addr_t(struct multi_context *m=
, const struct multi_instance *mi, in_addr_t a)</span><br><span> {</span><b=
r><span>     struct mroute_addr addr;</span><br><span>     CLEAR(addr);</sp=
an><br><span>@@ -4395,7 +4396,7 @@</span><br><span>  * @param a6    The new=
 IPv6 address</span><br><span>  */</span><br><span> static void</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-multi_unlearn_in6_addr(struct mul=
ti_context *m, struct multi_instance *mi, struct in6_addr a6)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+multi_unlearn_in6_addr(struct mul=
ti_context *m, const struct multi_instance *mi, struct in6_addr a6)</span><=
br><span> {</span><br><span>     struct mroute_addr addr;</span><br><span> =
    CLEAR(addr);</span><br><span>diff --git a/src/openvpn/multi=2Eh b/src/o=
penvpn/multi=2Eh</span><br><span>index c424ad3=2E=2E5db7147 100644</span><b=
r><span>--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=
=2Eh</span><br><span>@@ -529,7 +529,7 @@</span><br><span>  */</span><br><sp=
an> </span><br><span> static inline void</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-set_prefix(struct multi_instance *mi)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+set_prefix(const struct multi_instance=
 *mi)</span><br><span> {</span><br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</sp=
an><br><span>     if (mi-&gt;msg_prefix[0])</span><br><span>diff --git a/sr=
c/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>index 348=
e424=2E=2Ebb5dde58 100644</span><br><span>--- a/src/openvpn/multi_io=2Ec</s=
pan><br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><span>@@ -159,7 +159=
,7 @@</span><br><span>  * a point-to-multipoint tunnel=2E</span><br><span> =
 */</span><br><span> static unsigned int</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-p2mp_iow_flags(const struct multi_context *m, struct lin=
k_socket *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+p2mp=
_iow_flags(const struct multi_context *m, const struct link_socket *sock)</=
span><br><span> {</span><br><span>     unsigned int flags =3D IOW_WAIT_SIGN=
AL;</span><br><span> </span><br><span>diff --git a/src/openvpn/networking=
=2Eh b/src/openvpn/networking=2Eh</span><br><span>index bce0c19=2E=2E25233c=
8 100644</span><br><span>--- a/src/openvpn/networking=2Eh</span><br><span>+=
++ b/src/openvpn/networking=2Eh</span><br><span>@@ -44,7 +44,7 @@</span><br=
><span>  */</span><br><span> #if !defined(ENABLE_IPROUTE)</span><br><span> =
static inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_=
ctx_init(struct context *c, openvpn_net_ctx_t *ctx)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+net_ctx_init(const struct context *c, ope=
nvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span>     (void)c;</span=
><br><span>     (void)ctx;</span><br><span>@@ -75,7 +75,7 @@</span><br><spa=
n>  *</span><br><span>  * @return          0 on success, a negative error c=
ode otherwise</span><br><span>  */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-int net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+int net_ctx_init(cons=
t struct context *c, openvpn_net_ctx_t *ctx);</span><br><span> </span><br><=
span> /**</span><br><span>  * Release resources allocated by the internal g=
arbage collector</span><br><span>@@ -102,7 +102,7 @@</span><br><span>  * @r=
eturn          0 on success, negative error code on error</span><br><span> =
 */</span><br><span> int net_iface_new(openvpn_net_ctx_t *ctx, const openvp=
n_net_iface_t *iface, const char *type,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                  void *arg);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                  const void *arg);</span><br><=
span> </span><br><span> /**</span><br><span>  * Retrieve the interface type=
</span><br><span>diff --git a/src/openvpn/networking_iproute2=2Ec b/src/ope=
nvpn/networking_iproute2=2Ec</span><br><span>index a1f3525=2E=2Ef091fb3 100=
644</span><br><span>--- a/src/openvpn/networking_iproute2=2Ec</span><br><sp=
an>+++ b/src/openvpn/networking_iproute2=2Ec</span><br><span>@@ -36,7 +36,7=
 @@</span><br><span> #include &lt;netinet/in=2Eh&gt;</span><br><span> </spa=
n><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_c=
tx_init(struct context *c, openvpn_net_ctx_t *ctx)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+net_ctx_init(const struct context *c, openvp=
n_net_ctx_t *ctx)</span><br><span> {</span><br><span>     ctx-&gt;es =3D NU=
LL;</span><br><span>     if (c)</span><br><span>@@ -61,7 +61,7 @@</span><br=
><span> }</span><br><span> </span><br><span> int</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-net_iface_new(openvpn_net_ctx_t *ctx, const char=
 *iface, const char *type, void *arg)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, =
const char *type, const void *arg)</span><br><span> {</span><br><span>     =
struct argv argv =3D argv_new();</span><br><span> </span><br><span>diff --g=
it a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec</s=
pan><br><span>index 83915db=2E=2E49de664 100644</span><br><span>--- a/src/o=
penvpn/networking_sitnl=2Ec</span><br><span>+++ b/src/openvpn/networking_si=
tnl=2Ec</span><br><span>@@ -1007,7 +1007,7 @@</span><br><span> }</span><br>=
<span> </span><br><span> static int</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-sitnl_addr_del(sa_family_t af_family, const char *iface, inet=
_address_t *addr, int prefixlen)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+sitnl_addr_del(sa_family_t af_family, const char *iface, const=
 inet_address_t *addr, int prefixlen)</span><br><span> {</span><br><span>  =
   int ifindex;</span><br><span> </span><br><span>@@ -1250,8 +1250,8 @@</sp=
an><br><span> }</span><br><span> </span><br><span> static int</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-sitnl_route_del(const char *iface, =
sa_family_t af_family, inet_address_t *dst, int prefixlen,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                inet_address_t *gw, ui=
nt32_t table, int metric)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+sitnl_route_del(const char *iface, sa_family_t af_family, const inet_=
address_t *dst, int prefixlen,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                const inet_address_t *gw, uint32_t table, int me=
tric)</span><br><span> {</span><br><span>     int ifindex =3D 0;</span><br>=
<span> </span><br><span>@@ -1328,7 +1328,7 @@</span><br><span> </span><br><=
span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *=
type, void *arg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net=
_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type, con=
st void *arg)</span><br><span> {</span><br><span>     struct sitnl_link_req=
 req =3D {};</span><br><span>     int ret =3D -1;</span><br><span>diff --gi=
t a/src/openvpn/occ=2Eh b/src/openvpn/occ=2Eh</span><br><span>index bda4f18=
=2E=2E49def4d 100644</span><br><span>--- a/src/openvpn/occ=2Eh</span><br><s=
pan>+++ b/src/openvpn/occ=2Eh</span><br><span>@@ -156,7 +156,7 @@</span><br=
><span>  * via control channel=2E</span><br><span>  * @return control chann=
el exit message should be used */</span><br><span> static inline bool</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-cc_exit_notify_enabled(stru=
ct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cc_ex=
it_notify_enabled(const struct context *c)</span><br><span> {</span><br><sp=
an>     /* Check if we have TLS active at all */</span><br><span>     if (!=
c-&gt;c2=2Etls_multi)</span><br><span>diff --git a/src/openvpn/openssl_comp=
at=2Eh b/src/openvpn/openssl_compat=2Eh</span><br><span>index 098bdd5=2E=2E=
1a934db 100644</span><br><span>--- a/src/openvpn/openssl_compat=2Eh</span><=
br><span>+++ b/src/openvpn/openssl_compat=2Eh</span><br><span>@@ -127,7 +12=
7,7 @@</span><br><span> /* Mimics the functions but only when the default c=
ontext without</span><br><span>  * options is chosen */</span><br><span> st=
atic inline const EVP_CIPHER *</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-EVP_CIPHER_fetch(void *ctx, const char *algorithm, const char *pro=
perties)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+EVP_CIPHER_=
fetch(const void *ctx, const char *algorithm, const char *properties)</span=
><br><span> {</span><br><span>     ASSERT(!ctx);</span><br><span>     ASSER=
T(!properties);</span><br><span>@@ -135,7 +135,7 @@</span><br><span> }</spa=
n><br><span> </span><br><span> static inline const EVP_MD *</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-EVP_MD_fetch(void *ctx, const char *a=
lgorithm, const char *properties)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+EVP_MD_fetch(const void *ctx, const char *algorithm, const ch=
ar *properties)</span><br><span> {</span><br><span>     ASSERT(!ctx);</span=
><br><span>     ASSERT(!properties);</span><br><span>diff --git a/src/openv=
pn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 6664c73=2E=
=2Ee7585ad 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><=
span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -2429,7 +2429,7 @@</s=
pan><br><span> }</span><br><span> </span><br><span> static void</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-options_postprocess_mutate_le(str=
uct connection_entry *ce, struct local_entry *le, int mode)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+options_postprocess_mutate_le(const=
 struct connection_entry *ce, struct local_entry *le, int mode)</span><br><=
span> {</span><br><span>     /* use the global port if none is specified */=
</span><br><span>     if (!le-&gt;port)</span><br><span>@@ -3589,7 +3589,7 =
@@</span><br><span> static bool</span><br><span> verify_permission(const ch=
ar *name, const char *file, int line, const uint64_t type,</span><br><span>=
                   const uint64_t allowed, uint64_t *found, const msglvl_t =
msglevel,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
      struct options *options, bool is_inline)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                  const struct options *options,=
 bool is_inline)</span><br><span> {</span><br><span>     if (!(type &amp; a=
llowed))</span><br><span>     {</span><br><span>@@ -3665,7 +3665,7 @@</span=
><br><span> }</span><br><span> </span><br><span> static inline msglvl_t</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-msglevel_forward_compatib=
le(struct options *options, const msglvl_t msglevel)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+msglevel_forward_compatible(const struct =
options *options, const msglvl_t msglevel)</span><br><span> {</span><br><sp=
an>     return options-&gt;forward_compatible ? M_WARN : msglevel;</span><b=
r><span> }</span><br><span>@@ -4154,7 +4154,7 @@</span><br><span> }</span><=
br><span> </span><br><span> static void</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-show_compression_warning(struct compress_options *info)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+show_compression_warn=
ing(const struct compress_options *info)</span><br><span> {</span><br><span=
>     if (comp_non_stub_enabled(info))</span><br><span>     {</span><br><sp=
an>diff --git a/src/openvpn/options_parse=2Ec b/src/openvpn/options_parse=
=2Ec</span><br><span>index 12934ab=2E=2E79b8098 100644</span><br><span>--- =
a/src/openvpn/options_parse=2Ec</span><br><span>+++ b/src/openvpn/options_p=
arse=2Ec</span><br><span>@@ -258,7 +258,7 @@</span><br><span> }</span><br><=
span> </span><br><span> static char *</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-read_inline_file(struct in_src *is, const char *close_tag, =
int *num_lines, struct gc_arena *gc)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+read_inline_file(const struct in_src *is, const char *clos=
e_tag, int *num_lines, struct gc_arena *gc)</span><br><span> {</span><br><s=
pan>     char line[OPTION_LINE_SIZE];</span><br><span>     struct buffer bu=
f =3D alloc_buf(8 * OPTION_LINE_SIZE);</span><br><span>@@ -302,7 +302,7 @@<=
/span><br><span> }</span><br><span> </span><br><span> static int</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-check_inline_file(struct in_src =
*is, char *p[], struct gc_arena *gc)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+check_inline_file(const struct in_src *is, char *p[], stru=
ct gc_arena *gc)</span><br><span> {</span><br><span>     int num_inline_lin=
es =3D 0;</span><br><span> </span><br><span>diff --git a/src/openvpn/otime=
=2Ec b/src/openvpn/otime=2Ec</span><br><span>index 1608458=2E=2E5d3633c 100=
644</span><br><span>--- a/src/openvpn/otime=2Ec</span><br><span>+++ b/src/o=
penvpn/otime=2Ec</span><br><span>@@ -66,7 +66,7 @@</span><br><span> }</span=
><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-update_now_usec(struct timeval *tv)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+update_now_usec(const struct timeval *tv)</spa=
n><br><span> {</span><br><span>     const time_t last =3D now;</span><br><s=
pan>     update_now(tv-&gt;tv_sec);</span><br><span>diff --git a/src/openvp=
n/otime=2Eh b/src/openvpn/otime=2Eh</span><br><span>index d14f01e=2E=2E74d2=
1ff 100644</span><br><span>--- a/src/openvpn/otime=2Eh</span><br><span>+++ =
b/src/openvpn/otime=2Eh</span><br><span>@@ -65,7 +65,7 @@</span><br><span> =
void update_now(const time_t system_time);</span><br><span> </span><br><spa=
n> extern time_t now_usec;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-void update_now_usec(struct timeval *tv);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void update_now_usec(const struct timeval *tv);<=
/span><br><span> </span><br><span> static inline int</span><br><span> openv=
pn_gettimeofday(struct timeval *tv, void *tz)</span><br><span>diff --git a/=
src/openvpn/proto=2Eh b/src/openvpn/proto=2Eh</span><br><span>index 9bb0866=
=2E=2E1665751 100644</span><br><span>--- a/src/openvpn/proto=2Eh</span><br>=
<span>+++ b/src/openvpn/proto=2Eh</span><br><span>@@ -248,7 +248,7 @@</span=
><br><span>  * and offset of IP header (via parameter)=2E</span><br><span> =
 */</span><br><span> static inline int</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-get_tun_ip_ver(int tunnel_type, struct buffer *buf, int *i=
p_hdr_offset)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_tu=
n_ip_ver(int tunnel_type, const struct buffer *buf, int *ip_hdr_offset)</sp=
an><br><span> {</span><br><span>     int ip_ver =3D -1;</span><br><span> </=
span><br><span>diff --git a/src/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec</=
span><br><span>index 74a6cf9=2E=2Ec3ad7de 100644</span><br><span>--- a/src/=
openvpn/proxy=2Ec</span><br><span>+++ b/src/openvpn/proxy=2Ec</span><br><sp=
an>@@ -527,8 +527,9 @@</span><br><span> }</span><br><span> </span><br><span=
> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-add_prox=
y_headers(struct http_proxy_info *p, socket_descriptor_t sd, /* already ope=
n to proxy */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
          const char *host                                   /* openvpn ser=
ver remote */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_pr=
oxy_headers(const struct http_proxy_info *p,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                  socket_descriptor_t sd, /* alrea=
dy open to proxy */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                  const char *host        /* openvpn server remote */</span=
><br><span> )</span><br><span> {</span><br><span>     char buf[512];</span>=
<br><span>@@ -597,8 +598,8 @@</span><br><span>                             =
  socket_descriptor_t sd, /* already open to proxy */</span><br><span>     =
                          const char *host,       /* openvpn server remote =
*/</span><br><span>                               const char *port,       /=
* openvpn server port */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                              struct event_timeout *server_poll_timeout,=
 struct buffer *lookahead,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                              struct signal_info *sig_info)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
const struct event_timeout *server_poll_timeout,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                              struct buffer *l=
ookahead, struct signal_info *sig_info)</span><br><span> {</span><br><span>=
     struct gc_arena gc =3D gc_new();</span><br><span>     char buf[512];</=
span><br><span>diff --git a/src/openvpn/proxy=2Eh b/src/openvpn/proxy=2Eh</=
span><br><span>index e662e7d=2E=2Ea2f4e47 100644</span><br><span>--- a/src/=
openvpn/proxy=2Eh</span><br><span>+++ b/src/openvpn/proxy=2Eh</span><br><sp=
an>@@ -89,7 +89,7 @@</span><br><span>                                    so=
cket_descriptor_t sd, /* already open to proxy */</span><br><span>         =
                           const char *host,       /* openvpn server remote=
 */</span><br><span>                                    const char *port,  =
     /* openvpn server port */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                                   struct event_timeout *server_po=
ll_timeout,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                           const struct event_timeout *server_poll_timeout,=
</span><br><span>                                    struct buffer *lookahe=
ad, struct signal_info *sig_info);</span><br><span> </span><br><span> uint8=
_t *make_base64_string2(const uint8_t *str, int str_len, struct gc_arena *g=
c);</span><br><span>diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec</s=
pan><br><span>index 08c2673=2E=2E2679c4d5 100644</span><br><span>--- a/src/=
openvpn/ps=2Ec</span><br><span>+++ b/src/openvpn/ps=2Ec</span><br><span>@@ =
-334,7 +334,7 @@</span><br><span>  * the proxy can determine true client or=
igin=2E</span><br><span>  */</span><br><span> static void</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-journal_add(const char *journal_dir, st=
ruct proxy_connection *pc, struct proxy_connection *cp)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+journal_add(const char *journal_dir, co=
nst struct proxy_connection *pc, struct proxy_connection *cp)</span><br><sp=
an> {</span><br><span>     struct openvpn_sockaddr from, to;</span><br><spa=
n> </span><br><span>@@ -412,7 +412,7 @@</span><br><span> static bool</span>=
<br><span> proxy_entry_new(struct proxy_connection **list, struct event_set=
 *es,</span><br><span>                 const struct openvpn_sockaddr server=
_addr, const socket_descriptor_t sd_client,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                struct buffer *initial_data, const ch=
ar *journal_dir)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             const struct buffer *initial_data, const char *journal_dir)</s=
pan><br><span> {</span><br><span>     socket_descriptor_t sd_server;</span>=
<br><span>     int status;</span><br><span>@@ -1015,7 +1015,7 @@</span><br>=
<span>  * call=2E</span><br><span>  */</span><br><span> void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-port_share_redirect(struct port_shar=
e *ps, const struct buffer *head, socket_descriptor_t sd)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+port_share_redirect(const struct port=
_share *ps, const struct buffer *head, socket_descriptor_t sd)</span><br><s=
pan> {</span><br><span>     if (ps)</span><br><span>     {</span><br><span>=
diff --git a/src/openvpn/ps=2Eh b/src/openvpn/ps=2Eh</span><br><span>index =
557ecf5=2E=2E918ceb6 100644</span><br><span>--- a/src/openvpn/ps=2Eh</span>=
<br><span>+++ b/src/openvpn/ps=2Eh</span><br><span>@@ -49,7 +49,7 @@</span>=
<br><span> </span><br><span> bool is_openvpn_protocol(const struct buffer *=
buf);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-void port_share_redirect(struct port_share *ps, const struct buffer *head=
, socket_descriptor_t sd);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void port_share_redirect(const struct port_share *ps, const struct b=
uffer *head, socket_descriptor_t sd);</span><br><span> </span><br><span> #e=
ndif /* if PORT_SHARE */</span><br><span> #endif /* ifndef PS_H */</span><b=
r><span>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br>=
<span>index 0e281d2=2E=2E8dfe0d5 100644</span><br><span>--- a/src/openvpn/p=
ush=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -430,=
7 +430,7 @@</span><br><span> }</span><br><span> </span><br><span> bool</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-send_auth_pending_messages=
(struct tls_multi *tls_multi, struct tls_session *session,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+send_auth_pending_messages(const str=
uct tls_multi *tls_multi, struct tls_session *session,</span><br><span>    =
                        const char *extra, unsigned int timeout)</span><br>=
<span> {</span><br><span>     struct key_state *ks =3D &amp;session-&gt;key=
[KS_PRIMARY];</span><br><span>diff --git a/src/openvpn/push=2Eh b/src/openv=
pn/push=2Eh</span><br><span>index dff945f=2E=2E39302f6 100644</span><br><sp=
an>--- a/src/openvpn/push=2Eh</span><br><span>+++ b/src/openvpn/push=2Eh</s=
pan><br><span>@@ -117,7 +117,7 @@</span><br><span>  * doc/management-notes=
=2Etxt under client-pending-auth for</span><br><span>  * more details on me=
ssage format</span><br><span>  */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-bool send_auth_pending_messages(struct tls_multi *tls_multi, st=
ruct tls_session *session,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+bool send_auth_pending_messages(const struct tls_multi *tls_multi, s=
truct tls_session *session,</span><br><span>                               =
  const char *extra, unsigned int timeout);</span><br><span> </span><br><sp=
an> void send_restart(struct context *c, const char *kill_msg);</span><br><=
span>diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec</sp=
an><br><span>index 0213041=2E=2E7fa5987 100644</span><br><span>--- a/src/op=
envpn/push_util=2Ec</span><br><span>+++ b/src/openvpn/push_util=2Ec</span><=
br><span>@@ -222,7 +222,7 @@</span><br><span> </span><br><span> /* Return t=
rue if the client supports push-update */</span><br><span> static bool</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-support_push_update(struct=
 multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+support_push_update(const struct multi_instance *mi)</span><br><span> {</s=
pan><br><span>     ASSERT(mi-&gt;context=2Ec2=2Etls_multi);</span><br><span=
>     const unsigned int iv_proto_peer =3D extract_iv_proto(mi-&gt;context=
=2Ec2=2Etls_multi-&gt;peer_info);</span><br><span>diff --git a/src/openvpn/=
reliable=2Ec b/src/openvpn/reliable=2Ec</span><br><span>index c268cce=2E=2E=
7b5b17c 100644</span><br><span>--- a/src/openvpn/reliable=2Ec</span><br><sp=
an>+++ b/src/openvpn/reliable=2Ec</span><br><span>@@ -59,7 +59,7 @@</span><=
br><span> </span><br><span> /* check if a particular packet_id is present i=
n ack */</span><br><span> static inline bool</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-reliable_ack_packet_id_present(struct reliable_ack *=
ack, packet_id_type pid)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+reliable_ack_packet_id_present(const struct reliable_ack *ack, packet_=
id_type pid)</span><br><span> {</span><br><span>     for (int i =3D 0; i &l=
t; ack-&gt;len; ++i)</span><br><span>     {</span><br><span>@@ -752,7 +752,=
7 @@</span><br><span>  */</span><br><span> </span><br><span> void</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-reliable_mark_active_incoming(s=
truct reliable *rel, struct buffer *buf, packet_id_type pid,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+reliable_mark_active_incoming(stru=
ct reliable *rel, const struct buffer *buf, packet_id_type pid,</span><br><=
span>                               int opcode)</span><br><span> {</span><b=
r><span>     for (int i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span>@@=
 -812,7 +812,7 @@</span><br><span> </span><br><span> /* delete a buffer pre=
viously activated by reliable_mark_active() */</span><br><span> void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-reliable_mark_deleted(struct=
 reliable *rel, struct buffer *buf)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+reliable_mark_deleted(struct reliable *rel, const struct bu=
ffer *buf)</span><br><span> {</span><br><span>     for (int i =3D 0; i &lt;=
 rel-&gt;size; ++i)</span><br><span>     {</span><br><span>diff --git a/src=
/openvpn/reliable=2Eh b/src/openvpn/reliable=2Eh</span><br><span>index 534f=
eb3=2E=2E7b6fced 100644</span><br><span>--- a/src/openvpn/reliable=2Eh</spa=
n><br><span>+++ b/src/openvpn/reliable=2Eh</span><br><span>@@ -184,7 +184,7=
 @@</span><br><span>  * @li False, if there are packet IDs to be acknowledg=
ed=2E</span><br><span>  */</span><br><span> static inline bool</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-reliable_ack_empty(struct reliable=
_ack *ack)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reliable_=
ack_empty(const struct reliable_ack *ack)</span><br><span> {</span><br><spa=
n>     return !ack-&gt;len;</span><br><span> }</span><br><span>@@ -213,7 +2=
13,7 @@</span><br><span>  * @returns the number of outstanding acks</span><=
br><span>  */</span><br><span> static inline int</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-reliable_ack_outstanding(struct reliable_ack *ac=
k)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reliable_ack_outs=
tanding(const struct reliable_ack *ack)</span><br><span> {</span><br><span>=
     return ack-&gt;len;</span><br><span> }</span><br><span>@@ -369,7 +369,=
7 @@</span><br><span>  * @param pid The packet&#39;s packet ID=2E</span><br=
><span>  * @param opcode The packet&#39;s opcode=2E</span><br><span>  */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-void reliable_mark_activ=
e_incoming(struct reliable *rel, struct buffer *buf, packet_id_type pid,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+void reliable_mark_act=
ive_incoming(struct reliable *rel, const struct buffer *buf, packet_id_type=
 pid,</span><br><span>                                    int opcode);</spa=
n><br><span> </span><br><span> /**</span><br><span>@@ -422,7 +422,7 @@</spa=
n><br><span>  * @param rel The reliable structure associated with the given=
 buffer=2E</span><br><span>  * @param buf The buffer of the reliable entry =
which is to be removed=2E</span><br><span>  */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-void reliable_mark_deleted(struct reliable *rel, s=
truct buffer *buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
void reliable_mark_deleted(struct reliable *rel, const struct buffer *buf);=
</span><br><span> </span><br><span> /** @} name Functions for extracting in=
coming packets */</span><br><span> </span><br><span>diff --git a/src/openvp=
n/route=2Ec b/src/openvpn/route=2Ec</span><br><span>index 33b2387=2E=2E4830=
a5b 100644</span><br><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ =
b/src/openvpn/route=2Ec</span><br><span>@@ -898,8 +898,9 @@</span><br><span=
> }</span><br><span> </span><br><span> static bool</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-add_bypass_routes(struct route_bypass *rb, in_=
addr_t gateway, const struct tuntap *tt,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                  unsigned int flags, const struct route=
_gateway_info *rgi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
add_bypass_routes(const struct route_bypass *rb, in_addr_t gateway,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                  const str=
uct tuntap *tt, unsigned int flags,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                  const struct route_gateway_info *rgi,</sp=
an><br><span>                   const struct env_set *es, openvpn_net_ctx_t=
 *ctx)</span><br><span> {</span><br><span>     int ret =3D true;</span><br>=
<span>@@ -916,8 +917,9 @@</span><br><span> }</span><br><span> </span><br><s=
pan> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-del_b=
ypass_routes(struct route_bypass *rb, in_addr_t gateway, const struct tunta=
p *tt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
   unsigned int flags, const struct route_gateway_info *rgi,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+del_bypass_routes(const struct rou=
te_bypass *rb, in_addr_t gateway,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                  const struct tuntap *tt, unsigned int flags=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
const struct route_gateway_info *rgi,</span><br><span>                   co=
nst struct env_set *es, openvpn_net_ctx_t *ctx)</span><br><span> {</span><b=
r><span>     int i;</span><br><span>@@ -3939,7 +3941,8 @@</span><br><span> =
#else  /* if defined(_WIN32) */</span><br><span> </span><br><span> static v=
oid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_bypass_address=
es(struct route_bypass *rb, const unsigned int flags) /* PLATFORM-SPECIFIC =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+// cppcheck-suppr=
ess constParameterPointer ; stub</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+get_bypass_addresses(struct route_bypass *rb, const unsigned i=
nt flags)</span><br><span> {</span><br><span> }</span><br><span> </span><br=
><span>diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><=
br><span>index 33def4e=2E=2Edf8e400 100644</span><br><span>--- a/src/openvp=
n/socket=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@=
@ -620,7 +620,7 @@</span><br><span> }</span><br><span> </span><br><span> st=
atic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bind_local(s=
truct link_socket *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+bind_local(const struct link_socket *sock)</span><br><span> {</span><b=
r><span>     /* bind to local address/port */</span><br><span>     if (sock=
-&gt;bind_local)</span><br><span>@@ -916,8 +916,8 @@</span><br><span> }</sp=
an><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-socket_bind(socket_descriptor_t sd, struct addrinfo *local, =
int ai_family, const char *prefix,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            bool ipv6only)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+socket_bind(socket_descriptor_t sd, const struct addrin=
fo *local, int ai_family,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            const char *prefix, bool ipv6only)</span><br><span> {</sp=
an><br><span>     struct gc_arena gc =3D gc_new();</span><br><span> </span>=
<br><span>@@ -1125,8 +1125,8 @@</span><br><span>  * such as TCP=2E</span><b=
r><span>  */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-static void stream_buf_init(struct stream_buf *sb, struct buffer *=
buf, const unsigned int sockflags,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                            const int proto);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static void stream_buf_init(struct s=
tream_buf *sb, const struct buffer *buf,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                            const unsigned int sockfla=
gs, const int proto);</span><br><span> </span><br><span> static void stream=
_buf_close(struct stream_buf *sb);</span><br><span> </span><br><span>@@ -14=
79,7 +1479,7 @@</span><br><span> }</span><br><span> </span><br><span> stati=
c void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-phase2_set_sock=
et_flags(struct link_socket *sock)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+phase2_set_socket_flags(const struct link_socket *sock)</spa=
n><br><span> {</span><br><span>     /* TCP_NODELAY is enabled by default on=
 every TCP socket; dco-win is</span><br><span>      * skipped as it manages=
 its own socket */</span><br><span>@@ -2075,7 +2075,7 @@</span><br><span> }=
</span><br><span> </span><br><span> static void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-stream_buf_init(struct stream_buf *sb, struct buf=
fer *buf, const unsigned int sockflags,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+stream_buf_init(struct stream_buf *sb, const struct buf=
fer *buf, const unsigned int sockflags,</span><br><span>                 co=
nst int proto)</span><br><span> {</span><br><span>     sb-&gt;buf_init =3D =
*buf;</span><br><span>@@ -2341,7 +2341,7 @@</span><br><span> #endif</span><=
br><span> </span><br><span> static ssize_t</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-link_socket_read_udp_posix_recvmsg(struct link_socket =
*sock, struct buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+link_socket_read_udp_posix_recvmsg(const struct link_socket *sock, s=
truct buffer *buf,</span><br><span>                                    stru=
ct link_socket_actual *from, socklen_t *fromlen)</span><br><span> {</span><=
br><span>     struct iovec iov;</span><br><span>@@ -2413,7 +2413,7 @@</span=
><br><span> #endif /* if ENABLE_IP_PKTINFO */</span><br><span> </span><br><=
span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_soc=
ket_read_udp_posix(struct link_socket *sock, struct buffer *buf,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+link_socket_read_udp_posix(con=
st struct link_socket *sock, struct buffer *buf,</span><br><span>          =
                  struct link_socket_actual *from)</span><br><span> {</span=
><br><span>     ssize_t recvlen;</span><br><span>@@ -2476,7 +2476,7 @@</spa=
n><br><span> #if ENABLE_IP_PKTINFO</span><br><span> </span><br><span> ssize=
_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_write_u=
dp_posix_sendmsg(struct link_socket *sock, struct buffer *buf,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+link_socket_write_udp_posix_send=
msg(const struct link_socket *sock, const struct buffer *buf,</span><br><sp=
an>                                     struct link_socket_actual *to)</spa=
n><br><span> {</span><br><span>     struct iovec iov;</span><br><span>@@ -2=
672,7 +2672,7 @@</span><br><span> }</span><br><span> </span><br><span> int<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-socket_send_queue(stru=
ct link_socket *sock, struct buffer *buf, const struct link_socket_actual *=
to)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+socket_send_queu=
e(struct link_socket *sock, const struct buffer *buf, const struct link_soc=
ket_actual *to)</span><br><span> {</span><br><span>     if (sock-&gt;writes=
=2Eiostate =3D=3D IOSTATE_INITIAL)</span><br><span>     {</span><br><span>@=
@ -2772,8 +2772,8 @@</span><br><span>     return sock-&gt;writes=2Eiostate;=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-r=
ead_sockaddr_from_overlapped(struct overlapped_io *io, struct sockaddr *dst=
, int overlapped_ret)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_s=
ockaddr_from_overlapped(const struct overlapped_io *io, struct sockaddr *ds=
t, int overlapped_ret)</span><br><span> {</span><br><span>     if (overlapp=
ed_ret &gt;=3D 0 &amp;&amp; io-&gt;addr_defined)</span><br><span>     {</sp=
an><br><span>diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</=
span><br><span>index 46fa29c=2E=2Ecbcdeef 100644</span><br><span>--- a/src/=
openvpn/socket=2Eh</span><br><span>+++ b/src/openvpn/socket=2Eh</span><br><=
span>@@ -268,7 +268,7 @@</span><br><span> </span><br><span> int socket_recv=
_queue(struct link_socket *sock, int maxsize);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-int socket_send_queue(struct lin=
k_socket *sock, struct buffer *buf,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+int socket_send_queue(struct link_socket *sock, const struc=
t buffer *buf,</span><br><span>                       const struct link_soc=
ket_actual *to);</span><br><span> </span><br><span> typedef struct</span><b=
r><span>@@ -348,8 +348,8 @@</span><br><span> </span><br><span> struct link_=
socket *link_socket_new(void);</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-void socket_bind(socket_descriptor_t sd, struct =
addrinfo *local, int af_family, const char *prefix,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                 bool ipv6only);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void socket_bind(socket_descri=
ptor_t sd, const struct addrinfo *local, int af_family,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                 const char *prefix, bo=
ol ipv6only);</span><br><span> </span><br><span> int openvpn_connect(socket=
_descriptor_t sd, const struct sockaddr *remote, int connect_timeout,</span=
><br><span>                     volatile int *signal_received);</span><br><=
span>@@ -496,7 +496,7 @@</span><br><span> }</span><br><span> </span><br><sp=
an> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-link_socket_verify_incoming_addr(struct buffer *buf, const struct link_soc=
ket_info *info,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+link=
_socket_verify_incoming_addr(const struct buffer *buf, const struct link_so=
cket_info *info,</span><br><span>                                  const st=
ruct link_socket_actual *from_addr)</span><br><span> {</span><br><span>    =
 if (buf-&gt;len &gt; 0)</span><br><span>@@ -620,7 +620,7 @@</span><br><spa=
n> </span><br><span> #else  /* ifdef _WIN32 */</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-ssize_t link_socket_read_udp_pos=
ix(struct link_socket *sock, struct buffer *buf,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ssize_t link_socket_read_udp_posix(const struc=
t link_socket *sock, struct buffer *buf,</span><br><span>                  =
                  struct link_socket_actual *from);</span><br><span> </span=
><br><span> #endif /* ifdef _WIN32 */</span><br><span>@@ -706,12 +706,12 @@=
</span><br><span> </span><br><span> #else /* ifdef _WIN32 */</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-ssize_t link_socke=
t_write_udp_posix_sendmsg(struct link_socket *sock, struct buffer *buf,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t link_socket_wri=
te_udp_posix_sendmsg(const struct link_socket *sock, const struct buffer *b=
uf,</span><br><span>                                             struct lin=
k_socket_actual *to);</span><br><span> </span><br><span> </span><br><span> =
static inline ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
link_socket_write_udp_posix(struct link_socket *sock, struct buffer *buf,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+link_socket_write_udp=
_posix(const struct link_socket *sock, const struct buffer *buf,</span><br>=
<span>                             struct link_socket_actual *to)</span><br=
><span> {</span><br><span> #if ENABLE_IP_PKTINFO</span><br><span>@@ -727,7 =
+727,7 @@</span><br><span> }</span><br><span> </span><br><span> static inli=
ne ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_socket=
_write_tcp_posix(struct link_socket *sock, struct buffer *buf)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+link_socket_write_tcp_posix(cons=
t struct link_socket *sock, const struct buffer *buf)</span><br><span> {</s=
pan><br><span>     return send(sock-&gt;sd, CBPTR(buf), BLENZ(buf), MSG_NOS=
IGNAL);</span><br><span> }</span><br><span>@@ -785,7 +785,7 @@</span><br><s=
pan>  * from tunnel packet=2E</span><br><span>  */</span><br><span> static =
inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_socke=
t_set_tos(struct link_socket *sock)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+link_socket_set_tos(const struct link_socket *sock)</span><=
br><span> {</span><br><span>     if (sock &amp;&amp; sock-&gt;ptos_defined)=
</span><br><span>     {</span><br><span>diff --git a/src/openvpn/socket_uti=
l=2Eh b/src/openvpn/socket_util=2Eh</span><br><span>index 13f5962=2E=2Eadd0=
8ba 100644</span><br><span>--- a/src/openvpn/socket_util=2Eh</span><br><spa=
n>+++ b/src/openvpn/socket_util=2Eh</span><br><span>@@ -439,7 +439,7 @@</sp=
an><br><span> </span><br><span> </span><br><span> static inline bool</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-addrlist_match_proto(const s=
truct openvpn_sockaddr *a1, struct addrinfo *addr_list, const int proto)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+addrlist_match_proto(c=
onst struct openvpn_sockaddr *a1, const struct addrinfo *addr_list, const i=
nt proto)</span><br><span> {</span><br><span>     return link_socket_proto_=
connection_oriented(proto) ? addrlist_match(a1, addr_list)</span><br><span>=
                                                         : addrlist_port_ma=
tch(a1, addr_list);</span><br><span>diff --git a/src/openvpn/socks=2Ec b/sr=
c/openvpn/socks=2Ec</span><br><span>index b84da24=2E=2E0296349 100644</span=
><br><span>--- a/src/openvpn/socks=2Ec</span><br><span>+++ b/src/openvpn/so=
cks=2Ec</span><br><span>@@ -83,7 +83,7 @@</span><br><span> </span><br><span=
> static bool</span><br><span> socks_proxy_recv_char(uint8_t *c, const char=
 *name, socket_descriptor_t sd,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                      struct event_timeout *server_poll_timeout,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
  const struct event_timeout *server_poll_timeout,</span><br><span>        =
               volatile int *signal_received)</span><br><span> {</span><br>=
<span>     fd_set reads;</span><br><span>@@ -98,8 +98,8 @@</span><br><span>=
 }</span><br><span> </span><br><span> static bool</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-socks_username_password_auth(struct socks_proxy=
_info *p, socket_descriptor_t sd,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                             struct event_timeout *server_poll_=
timeout,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+socks_usern=
ame_password_auth(const struct socks_proxy_info *p, socket_descriptor_t sd,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
          const struct event_timeout *server_poll_timeout,</span><br><span>=
                              volatile int *signal_received)</span><br><spa=
n> {</span><br><span>     char to_send[516];</span><br><span>@@ -157,8 +157=
,8 @@</span><br><span> }</span><br><span> </span><br><span> static bool</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-socks_handshake(struct so=
cks_proxy_info *p, socket_descriptor_t sd,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                struct event_timeout *server_poll_time=
out, volatile int *signal_received)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+socks_handshake(const struct socks_proxy_info *p, socket_de=
scriptor_t sd,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           const struct event_timeout *server_poll_timeout, volatile int *s=
ignal_received)</span><br><span> {</span><br><span>     uint8_t buf[2];</sp=
an><br><span>     int len =3D 0;</span><br><span>@@ -232,7 +232,7 @@</span>=
<br><span> </span><br><span> static bool</span><br><span> recv_socks_reply(=
socket_descriptor_t sd, struct openvpn_sockaddr *addr,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                 struct event_timeout *ser=
ver_poll_timeout, volatile int *signal_received)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                 const struct event_timeout *s=
erver_poll_timeout, volatile int *signal_received)</span><br><span> {</span=
><br><span>     uint8_t atyp =3D 0;</span><br><span>     int alen =3D 0;</s=
pan><br><span>@@ -334,11 +334,11 @@</span><br><span> }</span><br><span> </s=
pan><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-es=
tablish_socks_proxy_passthru(struct socks_proxy_info *p,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+establish_socks_proxy_passthru(const s=
truct socks_proxy_info *p,</span><br><span>                                =
socket_descriptor_t sd, /* already open to proxy */</span><br><span>       =
                         const char *host,       /* openvpn server remote *=
/</span><br><span>                                const char *servname,   /=
* openvpn server port */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                               struct event_timeout *server_poll_timeout=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
             const struct event_timeout *server_poll_timeout,</span><br><sp=
an>                                struct signal_info *sig_info)</span><br>=
<span> {</span><br><span>     char buf[270];</span><br><span>@@ -392,10 +39=
2,10 @@</span><br><span> }</span><br><span> </span><br><span> void</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-establish_socks_proxy_udpassoc=
(struct socks_proxy_info *p,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+establish_socks_proxy_udpassoc(const struct socks_proxy_info *p,</=
span><br><span>                                socket_descriptor_t ctrl_sd,=
 /* already open to proxy */</span><br><span>                              =
  struct openvpn_sockaddr *relay_addr,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                               struct event_timeout *serve=
r_poll_timeout,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                           const struct event_timeout *server_poll_timeout,=
</span><br><span>                                struct signal_info *sig_in=
fo)</span><br><span> {</span><br><span>     if (!socks_handshake(p, ctrl_sd=
, server_poll_timeout, &amp;sig_info-&gt;signal_received))</span><br><span>=
diff --git a/src/openvpn/socks=2Eh b/src/openvpn/socks=2Eh</span><br><span>=
index caed18c=2E=2E7434bbf 100644</span><br><span>--- a/src/openvpn/socks=
=2Eh</span><br><span>+++ b/src/openvpn/socks=2Eh</span><br><span>@@ -49,17 =
+49,17 @@</span><br><span> </span><br><span> void socks_proxy_close(struct =
socks_proxy_info *sp);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-void establish_socks_proxy_passthru(struct socks_proxy_i=
nfo *p,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void establi=
sh_socks_proxy_passthru(const struct socks_proxy_info *p,</span><br><span> =
                                    socket_descriptor_t sd, /* already open=
 to proxy */</span><br><span>                                     const cha=
r *host,       /* openvpn server remote */</span><br><span>                =
                     const char *servname,   /* openvpn server port */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
          struct event_timeout *server_poll_timeout,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                    const=
 struct event_timeout *server_poll_timeout,</span><br><span>               =
                      struct signal_info *sig_info);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-void establish_socks_proxy=
_udpassoc(struct socks_proxy_info *p,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void establish_socks_proxy_udpassoc(const struct socks_pr=
oxy_info *p,</span><br><span>                                     socket_de=
scriptor_t ctrl_sd, /* already open to proxy */</span><br><span>           =
                          struct openvpn_sockaddr *relay_addr,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                                  =
  struct event_timeout *server_poll_timeout,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                    const struct e=
vent_timeout *server_poll_timeout,</span><br><span>                        =
             struct signal_info *sig_info);</span><br><span> </span><br><sp=
an> void socks_process_incoming_udp(struct buffer *buf, struct link_socket_=
actual *from);</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openv=
pn/ssl=2Ec</span><br><span>index aeec020=2E=2E3594871 100644</span><br><spa=
n>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span=
><br><span>@@ -1171,7 +1171,7 @@</span><br><span> }</span><br><span> </span=
><br><span> struct tls_multi *</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-tls_multi_init(struct tls_options *tls_options)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+tls_multi_init(const struct tls_option=
s *tls_options)</span><br><span> {</span><br><span>     struct tls_multi *r=
et;</span><br><span> </span><br><span>@@ -1212,7 +1212,7 @@</span><br><span=
>  */</span><br><span> </span><br><span> struct tls_auth_standalone *</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_auth_standalone_init(st=
ruct tls_options *tls_options, struct gc_arena *gc)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+tls_auth_standalone_init(const struct tls=
_options *tls_options, struct gc_arena *gc)</span><br><span> {</span><br><s=
pan>     struct tls_auth_standalone *tas;</span><br><span> </span><br><span=
>@@ -1631,8 +1631,9 @@</span><br><span> </span><br><span> bool</span><br><s=
pan> tls_session_update_crypto_params_do_work(struct tls_multi *multi, stru=
ct tls_session *session,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                                         struct options *options, struct=
 frame *frame,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                                  struct frame *frame_fragment, struct link=
_socket_info *lsi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                        const struct options *options, stru=
ct frame *frame,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                      struct frame *frame_fragment,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
              const struct link_socket_info *lsi,</span><br><span>         =
                                 dco_context_t *dco)</span><br><span> {</sp=
an><br><span>     if (session-&gt;key[KS_PRIMARY]=2Ecrypto_options=2Ekey_ct=
x_bi=2Einitialized)</span><br><span>@@ -1704,7 +1705,7 @@</span><br><span> =
bool</span><br><span> tls_session_update_crypto_params(struct tls_multi *mu=
lti, struct tls_session *session,</span><br><span>                         =
         struct options *options, struct frame *frame,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                                 struct fr=
ame *frame_fragment, struct link_socket_info *lsi,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                 struct fram=
e *frame_fragment, const struct link_socket_info *lsi,</span><br><span>    =
                              dco_context_t *dco)</span><br><span> {</span>=
<br><span>     if (!check_session_cipher(session, options))</span><br><span=
>@@ -1920,7 +1921,8 @@</span><br><span> }</span><br><span> </span><br><span=
> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-push_pee=
r_info_peerid(struct buffer *out, struct tls_multi *multi, struct tls_sessi=
on *session)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+push_pe=
er_info_peerid(struct buffer *out, const struct tls_multi *multi,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                      const s=
truct tls_session *session)</span><br><span> {</span><br><span>     if (mul=
ti-&gt;rx_peer_id =3D=3D MAX_PEER_ID || session-&gt;opt-&gt;dco_enabled)</s=
pan><br><span>     {</span><br><span>@@ -1955,7 +1957,7 @@</span><br><span>=
  * @return          true if no error was encountered</span><br><span>  */<=
/span><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-push_peer_info(struct buffer *buf, struct tls_multi *multi, struct t=
ls_session *session)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+push_peer_info(struct buffer *buf, const struct tls_multi *multi, struct t=
ls_session *session)</span><br><span> {</span><br><span>     struct gc_aren=
a gc =3D gc_new();</span><br><span>     bool ret =3D false;</span><br><span=
>@@ -2599,8 +2601,8 @@</span><br><span> }</span><br><span> </span><br><span=
> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-session_skip_to=
_pre_start(struct tls_session *session, struct tls_pre_decrypt_state *state=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
      struct link_socket_actual *from)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+session_skip_to_pre_start(struct tls_session *session, c=
onst struct tls_pre_decrypt_state *state,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                          const struct link_socket_ac=
tual *from)</span><br><span> {</span><br><span>     struct key_state *ks =
=3D &amp;session-&gt;key[KS_PRIMARY];</span><br><span>     ks-&gt;session_i=
d_remote =3D state-&gt;peer_session_id;</span><br><span>@@ -2829,7 +2831,7 =
@@</span><br><span> </span><br><span> static bool</span><br><span> check_ou=
tgoing_ciphertext(struct key_state *ks, struct tls_session *session,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                          st=
ruct buffer *to_link, bool *continue_tls_process)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                          const struct buffer=
 *to_link, bool *continue_tls_process)</span><br><span> {</span><br><span> =
    if (to_link-&gt;len)</span><br><span>     {</span><br><span>@@ -4193,7 =
+4195,7 @@</span><br><span> }</span><br><span> </span><br><span> void</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_post_encrypt(struct tls=
_multi *multi, struct buffer *buf)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+tls_post_encrypt(struct tls_multi *multi, const struct buffe=
r *buf)</span><br><span> {</span><br><span>     struct key_state *ks =3D mu=
lti-&gt;save_ks;</span><br><span>     multi-&gt;save_ks =3D NULL;</span><br=
><span>@@ -4324,7 +4326,7 @@</span><br><span>  * into a garbage collectable=
 string which is returned=2E</span><br><span>  */</span><br><span> const ch=
ar *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-protocol_dump(str=
uct buffer *buffer, unsigned int flags, struct gc_arena *gc)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+protocol_dump(const struct buffer =
*buffer, unsigned int flags, struct gc_arena *gc)</span><br><span> {</span>=
<br><span>     struct buffer out =3D alloc_buf_gc(256, gc);</span><br><span=
>     struct buffer buf =3D *buffer;</span><br><span>diff --git a/src/openv=
pn/ssl=2Eh b/src/openvpn/ssl=2Eh</span><br><span>index 5483fbb=2E=2E76c3610=
 100644</span><br><span>--- a/src/openvpn/ssl=2Eh</span><br><span>+++ b/src=
/openvpn/ssl=2Eh</span><br><span>@@ -166,7 +166,7 @@</span><br><span>  *</s=
pan><br><span>  * @return A newly allocated and initialized \c tls_multi st=
ructure=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-struct tls_multi *tls_multi_init(struct tls_options *tls_options)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct tls_multi *=
tls_multi_init(const struct tls_options *tls_options);</span><br><span> </s=
pan><br><span> /**</span><br><span>  * Finalize initialization of a \c tls_=
multi structure=2E</span><br><span>@@ -187,7 +187,7 @@</span><br><span> /*<=
/span><br><span>  * Initialize a standalone tls-auth verification object=2E=
</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
struct tls_auth_standalone *tls_auth_standalone_init(struct tls_options *tl=
s_options,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct tl=
s_auth_standalone *tls_auth_standalone_init(const struct tls_options *tls_o=
ptions,</span><br><span>                                                   =
   struct gc_arena *gc);</span><br><span> </span><br><span> /**</span><br><=
span>@@ -373,7 +373,7 @@</span><br><span>  * @param multi - The TLS state f=
or this packet&#39;s destination VPN tunnel=2E</span><br><span>  * @param b=
uf - The buffer containing the outgoing packet=2E</span><br><span>  */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-void tls_post_encrypt(stru=
ct tls_multi *multi, struct buffer *buf);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void tls_post_encrypt(struct tls_multi *multi, const =
struct buffer *buf);</span><br><span> </span><br><span> /** @} name Functio=
ns for managing security parameter state for data channel packets */</span>=
<br><span> </span><br><span>@@ -463,7 +463,8 @@</span><br><span>  */</span>=
<br><span> bool tls_session_update_crypto_params(struct tls_multi *multi, s=
truct tls_session *session,</span><br><span>                               =
        struct options *options, struct frame *frame,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                      struc=
t frame *frame_fragment, struct link_socket_info *lsi,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                      st=
ruct frame *frame_fragment,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                                      const struct link_socket_info=
 *lsi,</span><br><span>                                       dco_context_t=
 *dco);</span><br><span> </span><br><span> /*</span><br><span>@@ -527,7 +52=
8,7 @@</span><br><span> #define PD_VERBOSE                 (1 &lt;&lt; 10)<=
/span><br><span> #define PD_TLS_CRYPT               (1 &lt;&lt; 11)</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-const char =
*protocol_dump(struct buffer *buffer, unsigned int flags, struct gc_arena *=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *pro=
tocol_dump(const struct buffer *buffer, unsigned int flags, struct gc_arena=
 *gc);</span><br><span> </span><br><span> /*</span><br><span>  * debugging =
code</span><br><span>@@ -566,7 +567,7 @@</span><br><span> /* Special method=
 to skip the three way handshake RESET stages=2E This is</span><br><span>  =
* used by the HMAC code when seeing a packet that matches the previous</spa=
n><br><span>  * HMAC based stateless server state */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-bool session_skip_to_pre_start(struct tls_s=
ession *session, struct tls_pre_decrypt_state *state,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                               struct link_=
socket_actual *from);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+bool session_skip_to_pre_start(struct tls_session *session, const struct =
tls_pre_decrypt_state *state,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                               const struct link_socket_actual *f=
rom);</span><br><span> </span><br><span> #endif /* ifndef OPENVPN_SSL_H */<=
/span><br><span>diff --git a/src/openvpn/ssl_backend=2Eh b/src/openvpn/ssl_=
backend=2Eh</span><br><span>index a6d57f2=2E=2E2150d81 100644</span><br><sp=
an>--- a/src/openvpn/ssl_backend=2Eh</span><br><span>+++ b/src/openvpn/ssl_=
backend=2Eh</span><br><span>@@ -137,7 +137,7 @@</span><br><span>  *</span><=
br><span>  * @return      true if the context is initialised, false if not=
=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-bool tls_ctx_initialised(struct tls_root_ctx *ctx);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+bool tls_ctx_initialised(const struct tl=
s_root_ctx *ctx);</span><br><span> </span><br><span> /**</span><br><span>  =
* Set any library specific options=2E</span><br><span>diff --git a/src/open=
vpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>index 998=
3742=2E=2E965ecdb 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls=2Ec<=
/span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>@@ -146,7=
 +146,7 @@</span><br><span> }</span><br><span> </span><br><span> bool</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_ctx_initialised(struct =
tls_root_ctx *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+t=
ls_ctx_initialised(const struct tls_root_ctx *ctx)</span><br><span> {</span=
><br><span>     /* either this should be NULL or should be non-null and the=
n have a</span><br><span>      * valid TLS ctx inside as well */</span><br>=
<span>diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2E=
c</span><br><span>index 96e90f82=2E=2E7805d43 100644</span><br><span>--- a/=
src/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_openssl=
=2Ec</span><br><span>@@ -129,7 +129,7 @@</span><br><span> }</span><br><span=
> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-tls_ctx_initialised(struct tls_root_ctx *ctx)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+tls_ctx_initialised(const struct tls_root_ctx =
*ctx)</span><br><span> {</span><br><span>     /* either this should be NULL=
 or should be non-null and then have a</span><br><span>      * valid TLS ct=
x inside as well */</span><br><span>@@ -2025,7 +2025,7 @@</span><br><span> =
}</span><br><span> </span><br><span> static void</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-bio_debug_data(const char *mode, BIO *bio, const=
 uint8_t *buf, int len, const char *desc)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+bio_debug_data(const char *mode, const BIO *bio, cons=
t uint8_t *buf, int len, const char *desc)</span><br><span> {</span><br><sp=
an>     struct gc_arena gc =3D gc_new();</span><br><span>     if (len &gt; =
0)</span><br><span>@@ -2039,7 +2039,7 @@</span><br><span> }</span><br><span=
> </span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-bio_debug_oc(const char *mode, BIO *bio)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+bio_debug_oc(const char *mode, const BIO *bi=
o)</span><br><span> {</span><br><span>     open_biofp();</span><br><span>  =
   fprintf(biofp, &quot;BIO %s time=3D%&quot; PRIi64 &quot; bio=3D&quot; pt=
r_format &quot;\n&quot;, mode, (int64_t)time(NULL),</span><br><span>diff --=
git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span>ind=
ex e9afda4=2E=2Ef78782f 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2E=
c</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@ -119,7 +=
119,7 @@</span><br><span>  */</span><br><span> static void</span><br><span>=
 tls_wrap_control(struct tls_wrap_ctx *ctx, uint8_t header, struct buffer *=
buf,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
struct session_id *session_id)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                 const struct session_id *session_id)</span><br>=
<span> {</span><br><span>     if (ctx-&gt;mode =3D=3D TLS_WRAP_AUTH || ctx-=
&gt;mode =3D=3D TLS_WRAP_NONE)</span><br><span>     {</span><br><span>@@ -4=
03,9 +403,9 @@</span><br><span> </span><br><span> </span><br><span> struct =
buffer</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_reset_stand=
alone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                     struct sess=
ion_id *own_sid, struct session_id *remote_sid, uint8_t header,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                     bool request=
_resend_wkc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_res=
et_standalone(struct tls_wrap_ctx *ctx, const struct tls_auth_standalone *t=
as,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
     const struct session_id *own_sid, const struct session_id *remote_sid,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
  uint8_t header, bool request_resend_wkc)</span><br><span> {</span><br><sp=
an>     /* Copy buffer here to point at the same data but allow tls_wrap_co=
ntrol</span><br><span>      * to potentially change buf to point to another=
 buffer without</span><br><span>@@ -490,7 +490,7 @@</span><br><span> bool</=
span><br><span> check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state =
*state,</span><br><span>                               const struct openvpn=
_sockaddr *from,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                         uint8_t *key,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                              const uint8_t *key,</span>=
<br><span>                               int handwindow,</span><br><span>  =
                             bool pkt_is_ack)</span><br><span> {</span><br>=
<span>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span>=
<br><span>index 03e8930=2E=2E8203e4a 100644</span><br><span>--- a/src/openv=
pn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</span><br><spa=
n>@@ -183,7 +183,7 @@</span><br><span>  * @return              the expected=
 server session id</span><br><span>  */</span><br><span> bool check_session=
_hmac_and_pkt_id(struct tls_pre_decrypt_state *state, const struct openvpn_=
sockaddr *from,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                             uint8_t *key, int handwindow, bool pkt_is_ack)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
                 const uint8_t *key, int handwindow, bool pkt_is_ack);</spa=
n><br><span> </span><br><span> /*</span><br><span>  * Write a control chann=
el authentication record=2E</span><br><span>@@ -210,8 +210,9 @@</span><br><=
span>  * from the tls pre decrypt state=2E</span><br><span>  *</span><br><s=
pan>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct buffer=
 tls_reset_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone =
*tas,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
                   struct session_id *own_sid, struct session_id *remote_si=
d,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct buffer tls=
_reset_standalone(struct tls_wrap_ctx *ctx, const struct tls_auth_standalon=
e *tas,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                       const struct session_id *own_sid,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                   con=
st struct session_id *remote_sid,</span><br><span>                         =
           uint8_t header, bool request_resend_wkc);</span><br><span> </spa=
n><br><span> </span><br><span>diff --git a/src/openvpn/ssl_verify=2Ec b/src=
/openvpn/ssl_verify=2Ec</span><br><span>index 6631718=2E=2E0acba2b 100644</=
span><br><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/src/o=
penvpn/ssl_verify=2Ec</span><br><span>@@ -1140,7 +1140,7 @@</span><br><span=
>  * cache=2E</span><br><span>  */</span><br><span> static bool</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-tls_authentication_status_use_cac=
he(struct tls_multi *multi)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+tls_authentication_status_use_cache(const struct tls_multi *multi)<=
/span><br><span> {</span><br><span>     unsigned int idx =3D min_uint(multi=
-&gt;tas_cache_num_updates, SIZE(cache_intervals) - 1);</span><br><span>   =
  time_t latency =3D cache_intervals[idx];</span><br><span>@@ -1284,7 +1284=
,7 @@</span><br><span>  * Check if the script/plugin left a message in the =
auth failed message</span><br><span>  * file and relay it to the user */</s=
pan><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-check_for_client_reason(struct tls_multi *multi, struct auth_deferred_=
status *status)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+chec=
k_for_client_reason(struct tls_multi *multi, const struct auth_deferred_sta=
tus *status)</span><br><span> {</span><br><span>     struct gc_arena gc =3D=
 gc_new();</span><br><span>     const char *msg =3D key_state_check_auth_fa=
iled_message_file(status, &amp;gc);</span><br><span>@@ -1553,7 +1553,7 @@</=
span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> </spa=
n><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-set_verify_user_pass_env(struct user_pass *up, struct tls_multi *multi, =
struct tls_session *session)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+set_verify_user_pass_env(const struct user_pass *up, struct tls_mu=
lti *multi, struct tls_session *session)</span><br><span> {</span><br><span=
>     /* Is username defined? */</span><br><span>     if ((session-&gt;opt-=
&gt;ssl_flags &amp; SSLF_AUTH_USER_PASS_OPTIONAL) || strlen(up-&gt;username=
))</span><br><span>@@ -1581,7 +1581,7 @@</span><br><span> }</span><br><span=
> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-ssl_verify_username_length(struct tls_session *session, const char *user=
name)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssl_verify_use=
rname_length(const struct tls_session *session, const char *username)</span=
><br><span> {</span><br><span>     if ((session-&gt;opt-&gt;ssl_flags &amp;=
 SSLF_USERNAME_AS_COMMON_NAME)</span><br><span>         &amp;&amp; strlen(u=
sername) &gt; TLS_USERNAME_LEN)</span><br><span>diff --git a/src/openvpn/ss=
l_verify=2Eh b/src/openvpn/ssl_verify=2Eh</span><br><span>index 3176d76=2E=
=2Ee77bc4a 100644</span><br><span>--- a/src/openvpn/ssl_verify=2Eh</span><b=
r><span>+++ b/src/openvpn/ssl_verify=2Eh</span><br><span>@@ -202,7 +202,7 @=
@</span><br><span>  * @return              true if name is under limit or u=
sername-as-common-name</span><br><span>  *                      is not acti=
ve</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-bool ssl_verify_username_length(struct tls_session *session, const char *=
username);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool ssl_=
verify_username_length(const struct tls_session *session, const char *usern=
ame);</span><br><span> </span><br><span> /**</span><br><span>  * Runs the -=
-client-crresponse script if one is defined=2E</span><br><span>@@ -275,7 +2=
75,7 @@</span><br><span> void auth_set_client_reason(struct tls_multi *mult=
i, const char *client_reason);</span><br><span> </span><br><span> static in=
line const char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_=
client_reason(struct tls_multi *multi)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+tls_client_reason(const struct tls_multi *multi)</span><=
br><span> {</span><br><span>     return multi-&gt;client_reason;</span><br>=
<span> }</span><br><span>diff --git a/src/openvpn/status=2Ec b/src/openvpn/=
status=2Ec</span><br><span>index c7d375b=2E=2Ecfbc38d 100644</span><br><spa=
n>--- a/src/openvpn/status=2Ec</span><br><span>+++ b/src/openvpn/status=2Ec=
</span><br><span>@@ -135,7 +135,7 @@</span><br><span> }</span><br><span> </=
span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
tatus_reset(struct status_output *so)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+status_reset(const struct status_output *so)</span><br><s=
pan> {</span><br><span>     if (so &amp;&amp; so-&gt;fd &gt;=3D 0)</span><b=
r><span>     {</span><br><span>diff --git a/src/openvpn/status=2Eh b/src/op=
envpn/status=2Eh</span><br><span>index 7953a4e=2E=2E4c01d75 100644</span><b=
r><span>--- a/src/openvpn/status=2Eh</span><br><span>+++ b/src/openvpn/stat=
us=2Eh</span><br><span>@@ -69,7 +69,7 @@</span><br><span> </span><br><span>=
 bool status_trigger(struct status_output *so);</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-void status_reset(struct status=
_output *so);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void s=
tatus_reset(const struct status_output *so);</span><br><span> </span><br><s=
pan> void status_flush(struct status_output *so);</span><br><span> </span><=
br><span>diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><=
span>index 133f670=2E=2Ef191a6b 100644</span><br><span>--- a/src/openvpn/tu=
n=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -835,7 +=
835,7 @@</span><br><span>          const char *ifconfig_ipv6_local_parm,   =
  /* --ifconfig parm 1 IPv6 */</span><br><span>          int ifconfig_ipv6_=
netbits_parm,</span><br><span>          const char *ifconfig_ipv6_remote_pa=
rm,    /* --ifconfig parm 2 IPv6 */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-         struct addrinfo *local_public, struct addrinfo *remo=
te_public, const bool strict_warn,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+         const struct addrinfo *local_public, const struct a=
ddrinfo *remote_public, const bool strict_warn,</span><br><span>          s=
truct env_set *es, openvpn_net_ctx_t *ctx, struct tuntap *tt)</span><br><sp=
an> {</span><br><span>     if (!tt)</span><br><span>@@ -978,7 +978,7 @@</sp=
an><br><span>  * -&gt; helper function to simplify code below</span><br><sp=
an>  */</span><br><span> static void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-add_route_connected_v6_net(struct tuntap *tt, const struct e=
nv_set *es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_rout=
e_connected_v6_net(const struct tuntap *tt, const struct env_set *es)</span=
><br><span> {</span><br><span>     struct route_ipv6 r6;</span><br><span> <=
/span><br><span>@@ -1020,7 +1020,7 @@</span><br><span>  */</span><br><span>=
 </span><br><span> in_addr_t</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-create_arbitrary_remote(struct tuntap *tt)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+create_arbitrary_remote(const struct tuntap *=
tt)</span><br><span> {</span><br><span>     in_addr_t remote;</span><br><sp=
an> </span><br><span>@@ -1592,7 +1592,7 @@</span><br><span> }</span><br><sp=
an> </span><br><span> static void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-undo_ifconfig_ipv4(struct tuntap *tt, openvpn_net_ctx_t *ctx)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+undo_ifconfig_ipv4(co=
nst struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br=
><span> #if defined(TARGET_LINUX)</span><br><span>     int netbits =3D netm=
ask_to_netbits2(tt-&gt;remote_netmask);</span><br><span>@@ -1627,7 +1627,7 =
@@</span><br><span> }</span><br><span> </span><br><span> static void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-undo_ifconfig_ipv6(struct tu=
ntap *tt, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+undo_ifconfig_ipv6(const struct tuntap *tt, openvpn_net_ctx_t=
 *ctx)</span><br><span> {</span><br><span> #if defined(TARGET_LINUX)</span>=
<br><span>     if (net_addr_v6_del(ctx, tt-&gt;actual_name, &amp;tt-&gt;loc=
al_ipv6, tt-&gt;netbits_ipv6) &lt; 0)</span><br><span>@@ -1652,7 +1652,7 @@=
</span><br><span> }</span><br><span> </span><br><span> void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-undo_ifconfig(struct tuntap *tt, open=
vpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
undo_ifconfig(const struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><s=
pan> {</span><br><span>     if (tt-&gt;backend_driver !=3D DRIVER_NULL &amp=
;&amp; tt-&gt;backend_driver !=3D DRIVER_AFUNIX)</span><br><span>     {</sp=
an><br><span>@@ -1720,13 +1720,13 @@</span><br><span> }</span><br><span> </=
span><br><span> static ssize_t</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-write_tun_header(struct tuntap *tt, uint8_t *buf, int len)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+write_tun_header(const stru=
ct tuntap *tt, const uint8_t *buf, int len)</span><br><span> {</span><br><s=
pan>     if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span>=
<br><span>         u_int32_t type;</span><br><span>         struct iovec iv=
[2];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const str=
uct ip *iph =3D (struct ip *)buf;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        const struct ip *iph =3D (const struct ip *)buf;</spa=
n><br><span> </span><br><span>         if (iph-&gt;ip_v =3D=3D 6)</span><br=
><span>         {</span><br><span>@@ -1737,9 +1737,11 @@</span><br><span>  =
           type =3D htonl(AF_INET);</span><br><span>         }</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* arg=
ument to writev is a pointer to const but we still need to drop</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+         * the const from buf p=
ointer here */</span><br><span>         iv[0]=2Eiov_base =3D &amp;type;</sp=
an><br><span>         iv[0]=2Eiov_len =3D sizeof(type);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        iv[1]=2Eiov_base =3D buf;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        iv[1]=2Eiov_base =
=3D (void *)buf;</span><br><span>         iv[1]=2Eiov_len =3D len;</span><b=
r><span> </span><br><span>         return header_modify_read_write_return(w=
ritev(tt-&gt;fd, iv, 2));</span><br><span>@@ -1751,7 +1753,7 @@</span><br><=
span> }</span><br><span> </span><br><span> static ssize_t</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-read_tun_header(struct tuntap *tt, uint=
8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+r=
ead_tun_header(const struct tuntap *tt, uint8_t *buf, int len)</span><br><s=
pan> {</span><br><span>     if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br>=
<span>     {</span><br><span>@@ -1777,13 +1779,13 @@</span><br><span>  */</=
span><br><span> #if !defined(TARGET_DARWIN)</span><br><span> ssize_t</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-write_tun(struct tuntap *tt,=
 uint8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+write_tun(const struct tuntap *tt, const uint8_t *buf, int len)</span><=
br><span> {</span><br><span>     return write_tun_header(tt, buf, len);</sp=
an><br><span> }</span><br><span> </span><br><span> ssize_t</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-read_tun(struct tuntap *tt, uint8_t *b=
uf, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_tu=
n(const struct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</span>=
<br><span>     return read_tun_header(tt, buf, len);</span><br><span> }</sp=
an><br><span>@@ -1799,7 +1801,7 @@</span><br><span> </span><br><span> #if d=
efined(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><br><span> static boo=
l</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tun_dco_enabled(stru=
ct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tun_d=
co_enabled(const struct tuntap *tt)</span><br><span> {</span><br><span>    =
 return tt-&gt;backend_driver =3D=3D DRIVER_DCO;</span><br><span> }</span><=
br><span>@@ -2047,13 +2049,13 @@</span><br><span> }</span><br><span> </span=
><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-wr=
ite_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+write_tun(const struct tuntap *tt, const uint=
8_t *buf, int len)</span><br><span> {</span><br><span>     return write(tt-=
&gt;fd, buf, len);</span><br><span> }</span><br><span> </span><br><span> ss=
ize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_tun(struct =
tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+read_tun(const struct tuntap *tt, uint8_t *buf, int len)</sp=
an><br><span> {</span><br><span>     return read(tt-&gt;fd, buf, len);</spa=
n><br><span> }</span><br><span>@@ -2252,13 +2254,13 @@</span><br><span> }</=
span><br><span> </span><br><span> ssize_t</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-write_tun(struct tuntap *tt, uint8_t *buf, int len)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+write_tun(const struct =
tuntap *tt, const uint8_t *buf, int len)</span><br><span> {</span><br><span=
>     return write(tt-&gt;fd, buf, len);</span><br><span> }</span><br><span=
> </span><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-read_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+read_tun(const struct tuntap *tt, uint=
8_t *buf, int len)</span><br><span> {</span><br><span>     return read(tt-&=
gt;fd, buf, len);</span><br><span> }</span><br><span>@@ -2588,7 +2590,7 @@<=
/span><br><span> }</span><br><span> </span><br><span> ssize_t</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-write_tun(struct tuntap *tt, uint8_=
t *buf, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+wri=
te_tun(const struct tuntap *tt, const uint8_t *buf, int len)</span><br><spa=
n> {</span><br><span>     struct strbuf sbuf;</span><br><span>     sbuf=2El=
en =3D len;</span><br><span>@@ -2597,7 +2599,7 @@</span><br><span> }</span>=
<br><span> </span><br><span> ssize_t</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-read_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+read_tun(const struct tuntap =
*tt, uint8_t *buf, int len)</span><br><span> {</span><br><span>     struct =
strbuf sbuf;</span><br><span>     int f =3D 0;</span><br><span>@@ -3095,7 +=
3097,7 @@</span><br><span> }</span><br><span> </span><br><span> ssize_t</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-write_tun(struct tuntap *=
tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+write_tun(const struct tuntap *tt, const uint8_t *buf, int len)</spa=
n><br><span> {</span><br><span>     if (tt-&gt;backend_driver =3D=3D DRIVER=
_UTUN)</span><br><span>     {</span><br><span>@@ -3108,7 +3110,7 @@</span><=
br><span> }</span><br><span> </span><br><span> ssize_t</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-read_tun(struct tuntap *tt, uint8_t *buf, =
int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_tun(co=
nst struct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</span><br>=
<span>     if (tt-&gt;backend_driver =3D=3D DRIVER_UTUN)</span><br><span>  =
   {</span><br><span>@@ -3243,13 +3245,13 @@</span><br><span> }</span><br><=
span> </span><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-write_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+write_tun(const struct tuntap *tt=
, const uint8_t *buf, int len)</span><br><span> {</span><br><span>     retu=
rn write(tt-&gt;fd, buf, len);</span><br><span> }</span><br><span> </span><=
br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-read=
_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+read_tun(const struct tuntap *tt, uint8_t *buf, =
int len)</span><br><span> {</span><br><span>     return read(tt-&gt;fd, buf=
, len);</span><br><span> }</span><br><span>@@ -3311,7 +3313,7 @@</span><br>=
<span> }</span><br><span> </span><br><span> int</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-tun_write_queue(struct tuntap *tt, struct buffer =
*buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tun_write_queu=
e(struct tuntap *tt, const struct buffer *buf)</span><br><span> {</span><br=
><span>     if (tt-&gt;writes=2Eiostate =3D=3D IOSTATE_INITIAL)</span><br><=
span>     {</span><br><span>@@ -3365,7 +3367,7 @@</span><br><span> }</span>=
<br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-tun_write_win32(struct tuntap *tt, struct buffer *buf)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+tun_write_win32(struct tuntap=
 *tt, const struct buffer *buf)</span><br><span> {</span><br><span>     int=
 err =3D 0;</span><br><span>     int status =3D 0;</span><br><span>@@ -5370=
,7 +5372,7 @@</span><br><span> }</span><br><span> </span><br><span> void</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-fork_register_dns_action=
(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
fork_register_dns_action(const struct tuntap *tt)</span><br><span> {</span>=
<br><span>     if (tt &amp;&amp; tt-&gt;options=2Eregister_dns &amp;&amp; t=
t-&gt;options=2Emsg_channel)</span><br><span>     {</span><br><span>@@ -546=
0,7 +5462,7 @@</span><br><span> }</span><br><span> </span><br><span> static=
 void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tuntap_get_mtu(s=
truct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tu=
ntap_get_mtu(const struct tuntap *tt)</span><br><span> {</span><br><span>  =
   ULONG mtu =3D 0;</span><br><span>     DWORD len;</span><br><span>@@ -603=
5,7 +6037,7 @@</span><br><span> }</span><br><span> </span><br><span> void</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-tun_show_debug(struct t=
untap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tun_show_=
debug(const struct tuntap *tt)</span><br><span> {</span><br><span>     if (=
tt-&gt;backend_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOWS6)</span><br><span> =
    {</span><br><span>@@ -6295,13 +6297,13 @@</span><br><span> }</span><br>=
<span> </span><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-write_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+write_tun(const struct tuntap *t=
t, const uint8_t *buf, int len)</span><br><span> {</span><br><span>     ret=
urn write(tt-&gt;fd, buf, len);</span><br><span> }</span><br><span> </span>=
<br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-rea=
d_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+read_tun(const struct tuntap *tt, uint8_t *buf,=
 int len)</span><br><span> {</span><br><span>     return read(tt-&gt;fd, bu=
f, len);</span><br><span> }</span><br><span>diff --git a/src/openvpn/tun=2E=
h b/src/openvpn/tun=2Eh</span><br><span>index 7340e7e=2E=2E61fe943 100644</=
span><br><span>--- a/src/openvpn/tun=2Eh</span><br><span>+++ b/src/openvpn/=
tun=2Eh</span><br><span>@@ -272,9 +272,9 @@</span><br><span> </span><br><sp=
an> void close_tun_handle(struct tuntap *tt);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-ssize_t write_tun(struct tuntap *=
tt, uint8_t *buf, int len);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ssize_t write_tun(const struct tuntap *tt, const uint8_t *buf, int =
len);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-ssize_t read_tun(struct tuntap *tt, uint8_t *buf, int len);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ssize_t read_tun(const struct tun=
tap *tt, uint8_t *buf, int len);</span><br><span> </span><br><span> #ifdef =
ENABLE_FEATURE_TUN_PERSIST</span><br><span> void tuncfg(const char *dev, co=
nst char *dev_type, const char *dev_node, int persist_mode,</span><br><span=
>@@ -293,7 +293,7 @@</span><br><span>                         const char *i=
fconfig_ipv6_local_parm,     /* --ifconfig parm 1 / IPv6 */</span><br><span=
>                         int ifconfig_ipv6_netbits_parm,           /* --if=
config parm 1 / bits */</span><br><span>                         const char=
 *ifconfig_ipv6_remote_parm,    /* --ifconfig parm 2 / IPv6 */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                        struct add=
rinfo *local_public, struct addrinfo *remote_public,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        const struct addr=
info *local_public, const struct addrinfo *remote_public,</span><br><span> =
                        const bool strict_warn, struct env_set *es, openvpn=
_net_ctx_t *ctx,</span><br><span>                         struct tuntap *tt=
);</span><br><span> </span><br><span>@@ -320,7 +320,7 @@</span><br><span>  =
* @param tt    the tuntap interface context</span><br><span>  * @param ctx =
  the networking API opaque context</span><br><span>  */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-void undo_ifconfig(struct tuntap *tt, op=
envpn_net_ctx_t *ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void undo_ifconfig(const struct tuntap *tt, openvpn_net_ctx_t *ctx);</sp=
an><br><span> </span><br><span> bool is_dev_type(const char *dev, const cha=
r *dev_type, const char *match_type);</span><br><span> </span><br><span>@@ =
-351,7 +351,7 @@</span><br><span> #define IFCONFIG_DEFAULT IFCONFIG_AFTER_T=
UN_OPEN</span><br><span> </span><br><span> static inline int</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-ifconfig_order(struct tuntap *tt)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ifconfig_order(const s=
truct tuntap *tt)</span><br><span> {</span><br><span>     if (tt-&gt;backen=
d_driver =3D=3D DRIVER_AFUNIX)</span><br><span>     {</span><br><span>@@ -3=
81,7 +381,7 @@</span><br><span> #define ROUTE_ORDER_DEFAULT ROUTE_AFTER_TUN=
</span><br><span> </span><br><span> static inline int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-route_order(struct tuntap *tt)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+route_order(const struct tuntap =
*tt)</span><br><span> {</span><br><span>     if (tt-&gt;backend_driver =3D=
=3D DRIVER_AFUNIX)</span><br><span>     {</span><br><span>@@ -454,13 +454,1=
3 @@</span><br><span> </span><br><span> const char *tap_win_getinfo(const s=
truct tuntap *tt, struct gc_arena *gc);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-void tun_show_debug(struct tuntap *tt);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void tun_show_debug=
(const struct tuntap *tt);</span><br><span> </span><br><span> bool dhcp_rel=
ease_by_adapter_index(const DWORD adapter_index);</span><br><span> </span><=
br><span> bool dhcp_renew_by_adapter_index(const DWORD adapter_index);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void for=
k_register_dns_action(struct tuntap *tt);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void fork_register_dns_action(const struct tuntap *tt=
);</span><br><span> </span><br><span> void ipconfig_register_dns(const stru=
ct env_set *es);</span><br><span> </span><br><span>@@ -470,7 +470,7 @@</spa=
n><br><span> </span><br><span> int tun_read_queue(struct tuntap *tt, int ma=
xsize);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-int tun_write_queue(struct tuntap *tt, struct buffer *buf);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+int tun_write_queue(struct tunt=
ap *tt, const struct buffer *buf);</span><br><span> </span><br><span> stati=
c inline bool</span><br><span> tuntap_stop(int status)</span><br><span>@@ -=
499,7 +499,7 @@</span><br><span>     return false;</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int tun_w=
rite_win32(struct tuntap *tt, struct buffer *buf);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+int tun_write_win32(struct tuntap *tt, const=
 struct buffer *buf);</span><br><span> </span><br><span> static inline bool=
</span><br><span> is_ip_packet_valid(const struct buffer *buf)</span><br><s=
pan>@@ -529,19 +529,21 @@</span><br><span> }</span><br><span> </span><br><s=
pan> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-tuntap_is_dco_win(struct tuntap *tt)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+tuntap_is_dco_win(const struct tuntap *tt)</span><br><sp=
an> {</span><br><span>     return tt &amp;&amp; tt-&gt;backend_driver =3D=
=3D DRIVER_DCO;</span><br><span> }</span><br><span> </span><br><span> stati=
c inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tuntap_i=
s_dco_win_timeout(struct tuntap *tt, ssize_t status)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+tuntap_is_dco_win_timeout(const struct tu=
ntap *tt, ssize_t status)</span><br><span> {</span><br><span>     return tu=
ntap_is_dco_win(tt) &amp;&amp; (status &lt; 0) &amp;&amp; (openvpn_errno() =
=3D=3D ERROR_NETNAME_DELETED);</span><br><span> }</span><br><span> </span><=
br><span> #else  /* ifdef _WIN32 */</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+// cppcheck-suppress-begin constParameter=
Pointer ; stubs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> static inline bool</span><br><span> tuntap_stop(int status)</=
span><br><span> {</span><br><span>@@ -565,19 +567,20 @@</span><br><span>   =
  return true;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static inline bool</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-tuntap_is_dco_win(struct tun=
tap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tuntap_is_d=
co_win(const struct tuntap *tt)</span><br><span> {</span><br><span>     ret=
urn false;</span><br><span> }</span><br><span> </span><br><span> static inl=
ine bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tuntap_is_dco=
_win_timeout(struct tuntap *tt, ssize_t status)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+tuntap_is_dco_win_timeout(const struct tuntap *=
tt, ssize_t status)</span><br><span> {</span><br><span>     return false;</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+// cppcheck-suppress-end constParameterPointer</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* ifde=
f _WIN32 */</span><br><span> </span><br><span> /*</span><br><span>diff --gi=
t a/src/openvpn/tun_afunix=2Ec b/src/openvpn/tun_afunix=2Ec</span><br><span=
>index f494d42=2E=2E79d706a 100644</span><br><span>--- a/src/openvpn/tun_af=
unix=2Ec</span><br><span>+++ b/src/openvpn/tun_afunix=2Ec</span><br><span>@=
@ -49,7 +49,7 @@</span><br><span> </span><br><span> </span><br><span> stati=
c void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tun_afunix_exec=
_child(const char *dev_node, struct tuntap *tt, struct env_set *env)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+tun_afunix_exec_child(cons=
t char *dev_node, struct tuntap *tt, const struct env_set *env)</span><br><=
span> {</span><br><span>     const char *msgprefix =3D &quot;ERROR: failure=
 executing process for tun:&quot;;</span><br><span>     struct argv argv =
=3D argv_new();</span><br><span>@@ -74,7 +74,7 @@</span><br><span> }</span>=
<br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-open_tun_afunix(struct options *o, int mtu, struct tuntap *tt, =
struct env_set *orig_env)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+open_tun_afunix(const struct options *o, int mtu, struct tuntap *tt, =
const struct env_set *orig_env)</span><br><span> {</span><br><span>     str=
uct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>@@ -146,7 +=
146,7 @@</span><br><span> }</span><br><span> </span><br><span> ssize_t</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-write_tun_afunix(struct tu=
ntap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+write_tun_afunix(struct tuntap *tt, const uint8_t *buf, int le=
n)</span><br><span> {</span><br><span>     const char *msg =3D &quot;ERROR:=
 failure during write to AF_UNIX socket: &quot;;</span><br><span>     if (!=
openvpn_waitpid_check(tt-&gt;afunix=2Echildprocess, msg, M_WARN))</span><br=
><span>@@ -172,8 +172,11 @@</span><br><span>     return read(tt-&gt;fd, buf=
, len);</span><br><span> }</span><br><span> #else  /* ifndef WIN32 */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+// cppcheck-suppress-begin constParameterPoi=
nter ; stubs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-open_t=
un_afunix(struct options *o, int mtu, struct tuntap *tt, struct env_set *or=
ig_env)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+open_tun_afu=
nix(const struct options *o, int mtu, struct tuntap *tt, const struct env_s=
et *orig_env)</span><br><span> {</span><br><span>     msg(M_ERR, &quot;AF_U=
NIX socket support not available on this platform&quot;);</span><br><span> =
}</span><br><span>@@ -186,7 +189,7 @@</span><br><span> }</span><br><span> <=
/span><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-write_tun_afunix(struct tuntap *tt, uint8_t *buf, int len)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+write_tun_afunix(struct tuntap *t=
t, const uint8_t *buf, int len)</span><br><span> {</span><br><span>     /* =
should never be called as open_tun_afunix always fails */</span><br><span> =
    ASSERT(0);</span><br><span>@@ -199,4 +202,6 @@</span><br><span>     ASS=
ERT(0);</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+// cppcheck-suppress-end constParameterPointer</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endi=
f /* ifndef WIN32 */</span><br><span>diff --git a/src/openvpn/tun_afunix=2E=
h b/src/openvpn/tun_afunix=2Eh</span><br><span>index 5b6a8e0=2E=2E5307e31 1=
00644</span><br><span>--- a/src/openvpn/tun_afunix=2Eh</span><br><span>+++ =
b/src/openvpn/tun_afunix=2Eh</span><br><span>@@ -31,7 +31,7 @@</span><br><s=
pan>  * the user provided taking care of implementing the actual tun</span>=
<br><span>  * device=2E</span><br><span>  */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-void open_tun_afunix(struct options *o, int mtu, str=
uct tuntap *tt, struct env_set *env);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void open_tun_afunix(const struct options *o, int mtu, st=
ruct tuntap *tt, const struct env_set *env);</span><br><span> </span><br><s=
pan> </span><br><span> /**</span><br><span>@@ -43,7 +43,7 @@</span><br><spa=
n> /**</span><br><span>  * Writes a packet to a AF_UNIX based tun device=2E=
</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
ssize_t write_tun_afunix(struct tuntap *tt, uint8_t *buf, int len);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t write_tun_afunix(st=
ruct tuntap *tt, const uint8_t *buf, int len);</span><br><span> </span><br>=
<span> /**</span><br><span>  * Reads a packet from a AF_UNIX based tun devi=
ce=2E</span><br><span>diff --git a/src/openvpn/vlan=2Ec b/src/openvpn/vlan=
=2Ec</span><br><span>index 69ac10d=2E=2E04e18d6 100644</span><br><span>--- =
a/src/openvpn/vlan=2Ec</span><br><span>+++ b/src/openvpn/vlan=2Ec</span><br=
><span>@@ -288,7 +288,7 @@</span><br><span> }</span><br><span> </span><br><=
span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-vlan_proces=
s_outgoing_tun(struct multi_context *m, struct multi_instance *mi)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+vlan_process_outgoing_tun(co=
nst struct multi_context *m, struct multi_instance *mi)</span><br><span> {<=
/span><br><span>     if (!m-&gt;top=2Eoptions=2Evlan_tagging)</span><br><sp=
an>     {</span><br><span>diff --git a/src/openvpn/vlan=2Eh b/src/openvpn/v=
lan=2Eh</span><br><span>index 9389f89=2E=2Ecd2f66f 100644</span><br><span>-=
-- a/src/openvpn/vlan=2Eh</span><br><span>+++ b/src/openvpn/vlan=2Eh</span>=
<br><span>@@ -35,6 +35,6 @@</span><br><span> </span><br><span> bool vlan_is=
_tagged(const struct buffer *buf);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void vlan_process_outgoing_tun(struct multi=
_context *m, struct multi_instance *mi);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void vlan_process_outgoing_tun(const struct multi_cont=
ext *m, struct multi_instance *mi);</span><br><span> </span><br><span> #end=
if /* VLAN_H */</span><br><span>diff --git a/src/openvpn/win32=2Eh b/src/op=
envpn/win32=2Eh</span><br><span>index 8be3d96=2E=2E39ff7d8 100644</span><br=
><span>--- a/src/openvpn/win32=2Eh</span><br><span>+++ b/src/openvpn/win32=
=2Eh</span><br><span>@@ -227,7 +227,7 @@</span><br><span> void overlapped_i=
o_close(struct overlapped_io *o);</span><br><span> </span><br><span> static=
 inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-overlappe=
d_io_active(struct overlapped_io *o)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+overlapped_io_active(const struct overlapped_io *o)</span>=
<br><span> {</span><br><span>     return o-&gt;iostate =3D=3D IOSTATE_QUEUE=
D || o-&gt;iostate =3D=3D IOSTATE_IMMEDIATE_RETURN;</span><br><span> }</spa=
n><br><span>diff --git a/src/openvpnmsica/openvpnmsica=2Ec b/src/openvpnmsi=
ca/openvpnmsica=2Ec</span><br><span>index 1a17d95=2E=2Ed2fd9af 100644</span=
><br><span>--- a/src/openvpnmsica/openvpnmsica=2Ec</span><br><span>+++ b/sr=
c/openvpnmsica/openvpnmsica=2Ec</span><br><span>@@ -77,7 +77,7 @@</span><br=
><span>  * @return ERROR_SUCCESS on success; An error code otherwise</span>=
<br><span>  */</span><br><span> static UINT</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-setup_sequence(_In_ MSIHANDLE hInstall, _In_z_ LPCWST=
R szProperty, _In_ struct msica_arg_seq *seq)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+setup_sequence(_In_ MSIHANDLE hInstall, _In_z_ LP=
CWSTR szProperty, _In_ const struct msica_arg_seq *seq)</span><br><span> {<=
/span><br><span>     UINT uiResult;</span><br><span>     LPWSTR szSequence =
=3D msica_arg_seq_join(seq);</span><br><span>diff --git a/src/openvpnserv/i=
nteractive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index 9a68=
bbb=2E=2Ed8cf6e1 100644</span><br><span>--- a/src/openvpnserv/interactive=
=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>=
@@ -522,7 +522,7 @@</span><br><span> </span><br><span> </span><br><span> st=
atic SOCKADDR_INET</span><br><span style=3D"color: hsl(0, 100%, 40%);">-soc=
kaddr_inet(short family, inet_address_t *addr)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+sockaddr_inet(short family, const inet_address_t=
 *addr)</span><br><span> {</span><br><span>     SOCKADDR_INET sa_inet;</spa=
n><br><span>     ZeroMemory(&amp;sa_inet, sizeof(sa_inet));</span><br><span=
>diff --git a/tests/unit_tests/openvpn/mock_management=2Ec b/tests/unit_tes=
ts/openvpn/mock_management=2Ec</span><br><span>index 77f6ce2=2E=2Efff4c2b 1=
00644</span><br><span>--- a/tests/unit_tests/openvpn/mock_management=2Ec</s=
pan><br><span>+++ b/tests/unit_tests/openvpn/mock_management=2Ec</span><br>=
<span>@@ -36,7 +36,7 @@</span><br><span> struct management *management; /* =
GLOBAL */</span><br><span> </span><br><span> void</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-management_auth_failure(struct management *man,=
 const char *type, const char *reason)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+management_auth_failure(const struct management *man, co=
nst char *type, const char *reason)</span><br><span> {</span><br><span>    =
 ASSERT(false);</span><br><span> }</span><br><span>diff --git a/tests/unit_=
tests/openvpn/siphash_openssl=2Ec b/tests/unit_tests/openvpn/siphash_openss=
l=2Ec</span><br><span>index 52f13b8=2E=2Ee7282b2 100644</span><br><span>---=
 a/tests/unit_tests/openvpn/siphash_openssl=2Ec</span><br><span>+++ b/tests=
/unit_tests/openvpn/siphash_openssl=2Ec</span><br><span>@@ -100,7 +100,7 @@=
</span><br><span> }</span><br><span> </span><br><span> bool</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-siphash_openssl_available(void *sip_c=
ontext)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_open=
ssl_available(const void *sip_context)</span><br><span> {</span><br><span> =
    const struct siphash_context *sip =3D sip_context;</span><br><span> </s=
pan><br><span>@@ -117,6 +117,8 @@</span><br><span> }</span><br><span> #else=
</span><br><span> /* Do avoid a lot more ifdefs in the test we put dummy fu=
nctions here */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+// c=
ppcheck-suppress-begin constParameterPointer ; stubs</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> si=
phash_openssl(void *sip_context, const void *in, const size_t inlen,</span>=
<br><span>                 const void *k, uint8_t *out, const size_t outlen=
)</span><br><span>@@ -125,7 +127,7 @@</span><br><span> }</span><br><span> <=
/span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
siphash_openssl_available(void *sip_context)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+siphash_openssl_available(const void *sip_context)=
</span><br><span> {</span><br><span>     return false;</span><br><span> }</=
span><br><span>@@ -141,5 +143,6 @@</span><br><span> {</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+// c=
ppcheck-suppress-end constParameterPointer</span><br><span> </span><br><spa=
n> #endif /* if defined(ENABLE_CRYPTO_OPENSSL) &amp;&amp; OPENSSL_VERSION_N=
UMBER &gt;=3D 0x30000000L */</span><br><span>diff --git a/tests/unit_tests/=
openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><s=
pan>index 8d88943=2E=2Eaea40f0 100644</span><br><span>--- a/tests/unit_test=
s/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test=
_misc=2Ec</span><br><span>@@ -146,7 +146,7 @@</span><br><span> }</span><br>=
<span> </span><br><span> static struct hash_element *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-hash_lookup_by_value(struct hash *hash, voi=
d *value)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+hash_looku=
p_by_value(struct hash *hash, const void *value)</span><br><span> {</span><=
br><span>     struct hash_iterator hi;</span><br><span>     struct hash_ele=
ment *he;</span><br><span>diff --git a/tests/unit_tests/openvpn/test_user_p=
ass=2Ec b/tests/unit_tests/openvpn/test_user_pass=2Ec</span><br><span>index=
 c0a0866=2E=2E7636a33 100644</span><br><span>--- a/tests/unit_tests/openvpn=
/test_user_pass=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_use=
r_pass=2Ec</span><br><span>@@ -59,7 +59,7 @@</span><br><span>     return mo=
ck();</span><br><span> }</span><br><span> void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-management_auth_failure(struct management *man, co=
nst char *type, const char *reason)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+management_auth_failure(const struct management *man, const=
 char *type, const char *reason)</span><br><span> {</span><br><span>     as=
sert_true(0);</span><br><span> }</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail">change 166=
3</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: I56248cf6d199c2da770774b8fd1e5daf2b116f58 </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 1663 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 33 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichte=
nheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--rdFKSlJg/4g=--


--===============7589869655745983873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7589869655745983873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7589869655745983873==--

