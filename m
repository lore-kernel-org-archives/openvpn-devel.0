Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20FD606A326
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=H63QhryN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DSCBobK6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZPnY/ACj;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NidO0+xw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=aQdPfwisiL3qjFIS1u9ehRMwVmahDvJmAaQSU0ACZjQ=; b=H63QhryNjRN07ZCIiPzJLZ9Uyn
	U+J35sIG/rT3tu90VarKpIlmmFn+P9KzyO8YUWKJNNNPBnbA0YbRAma223zVHIuC3clvq5rPhDN81
	acZnrlBuAQw6GNJszu0hGDj6thzK7bGWUe5OCJGvUZd2Wzjf0ZG7C1Humw/0ol7sbUYc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOyQh-000000002uC-3uu7;
	Thu, 05 Nov 2026 14:27:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOyQg-000000002tz-07Y3
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 14:27:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CLbyauoEhM6jXAuxun1X2bXNKlDp4IVGGqhp1gz9JyE=; b=DSCBobK6HVn0kpVyA328bThPxD
 MXVPQpoSlIahldnRdbcmYmSA2mcMr1bYyFSSNiFWhuYGLJZSqLIXBrInLhT7DY/PtPliX8PuLhPtZ
 5jkRHqI621QHJjnEO8R39kbItNIREriHI4MFleiTngUAWj7C2C26uTfqcJ87fqoxd9SE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CLbyauoEhM6jXAuxun1X2bXNKlDp4IVGGqhp1gz9JyE=; b=ZPnY/ACjraeqRhamlPmkhhx7PY
 36QMtDYPeVve59CY/dxwtgXgu+AwCds8nZ9Prmd46TUs/PMDDcjRWSXH20wfDDt53EDYbKkFM97B3
 LLzNOn9HYw3gBab/eVbQS46dEIpmRP5BjiH0VdNsNmpet/kkUvKasTgL5FZkBMk1yV5E=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOyQd-000000006I9-2jRx for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 14:27:01 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so18374105e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 06:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793888813; x=1794493613; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CLbyauoEhM6jXAuxun1X2bXNKlDp4IVGGqhp1gz9JyE=;
 b=NidO0+xwfmzuMrFXhHCu2hThDxV5hDhpkSIk0xp0SCv2rdhIPB2eBgbtkrrtilJ7gZ
 kkv2NxYk2C5g139308X5HS7vgJk6jh2qtLUwf1maSoywxWNnpVhdPbeomF+IDcCUVvaZ
 H6/goa+mrjj0YxZ+spiWKyGjviqnu2w4AVMeHMwE3f67DVEOEYYmCTZcGawU9avv0YLc
 R1HZOS5ZRAi7GRIRGWzfCasClrqqzKK8G8fky1L6siPgfg1rEaIPImjAxt8FOPmgo4IE
 PMITD0He1pudL/rv1Vr9Jj5Cz8he2Jtj8MRP/IT9r5dv2pTUHH3G9CC4xEppJN+IzdMU
 uzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793888813; x=1794493613;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CLbyauoEhM6jXAuxun1X2bXNKlDp4IVGGqhp1gz9JyE=;
 b=Y8Z/Qx72Xmr90D8wIL/FDft+KkuUsBj7j3b2skn06g6mNX5K+rZieTNyarIwzdKurC
 Z/01Mn4Qh3yi3VHc7i28jWzhXaHyu7AmsANq6JIZdEVzKP8iTw3bofP0//C8FE+gbQFN
 fVsf1S5KOInAhikCUB1vJANJESqmQ68xPutlYysj/c8xcfDZF7YBBjmum4a/4TJ/qMGe
 uTEjp9x5+nX8RdKXdLPu2fTw7LmX6/9VG0f9B2VROHd3O8XoHTxV6E8s7B+gzL21fcZw
 lipBFiXoVfYlalQNaR5ZrhUbkofIioZ41qX5iGsqfZY7fZijY06S0jt+GcPB3N5DTNSX
 FKTg==
X-Gm-Message-State: APuU4Z8bvYHo6Vozxn802Ms5RzQBoNNG4+EW7s2VDGs/wDinVqysoepM
 JgRuQ0SZPySfFXEEtuSPHK4nBrnNK1hAngCfOfIS/EPnV4P520YeGJFbQJzn49MWKM2tHIIRd9m
 zjAisKbe0zmItqSATiZlePUfpBuWOGREG6zSSk5khs7TWyNKI9keYfS7cgwD1l+IpMANt1IUnyz
 +j9FByhQ==
X-Gm-Gg: AYBFou03w4zNK4TnL3xPLF92Yqwv+2o8brgvBTqm5UEfvtVL2hvetYnLsYhLg8ks3wa
 bPvLbrW0jWtZosM9eEx60oa97dAFznOxFT4YJ9lioOdh1lESOC04qZpCoFJiJsvqErQSQNHI1R1
 YM2L25bc9SouawxPJzLdLNaUkhNj6MEVuSUXs15sV81jIE/4CiTqJ0Lr0gl5zNLGlH4Em1Poacp
 2VNLGQuHDh6V7mzxHBy4wV00pfCSN5TSJHSVhr+G6G9CDm5fqAgSbSiJ44939KS+aR6T2JhtuqI
 ZkccPXFh2rX6rwCPEG1gtwSzcBnLu2tBMLLowUs+NHoyl8Wy64nSih+MXZZvdxR1biM7jcBBxp+
 FFAqyd7Ms5XumNVdOvAaGmNJBHU7+zsc2AaxSrMp1v/qpBcuD6Abg1MON0qRQe7wfg8+UBft37Z
 NYttbgo08kIPAwQYnOYLELJ0iucD4/zzn5B9nDoUGJgGxtilZ4MgMDcBo6C9A5YfzBosqkCx/Cq
 4NqxcLyTc2rUQwSe09UBjUkrHOiBTUG3SCbSblBt7vKtB7FyHsr/K4So7O9eyl7knYvH45OtF3u
 nDVXj9F89xa73DKq8V/R8nlEYm5uV8zO1nqb4E4b3PsfeyYKIbiCZ2+dlvl344xze2CfqxSV2gf
 I9etecNfXcCrpS2M6QZbNPzGreso2/XbSV7Pl4bANLaslt1JgjO2eAUVBmPMq1MNet6WsJk/Fps
 3u9i1l109z5t12wA==
X-Received: by 2002:a05:600c:6208:b0:4a2:397:73fd with SMTP id
 5b1f17b1804b1-4ac182dc32cmr426572245e9.12.1793888812639; 
 Thu, 05 Nov 2026 06:26:52 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56e58fcb8sm67251735e9.1.2026.11.05.06.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 06:26:52 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 14:26:49 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4
X-Gerrit-Change-Number: 2037
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2037?usp=email>
X-Gerrit-Commit: 89922173c29fd19bf3310aa6ab34db88206542ae
In-Reply-To: <gerrit.1793043747000.I695967524bb9e83887b8c07d0d09baff6e41acf4@gerrit.openvpn.net>
References: <gerrit.1793043747000.I695967524bb9e83887b8c07d0d09baff6e41acf4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDQzNzQ3MDAwLkk2OTU5Njc1MjRiYjllODM4ODdiOGMwN2QwZDA5YmFmZjZlNDFhY2Y0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <67d1d819918ba106750d9248c7e7a1d89e0ba088-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOyQd-000000006I9-2jRx
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add python scripts
 that demonstrate the ACC protocol
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 ralf@mandelbit.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7841887802372507516=="
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7841887802372507516==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3P0J/hWi9Ws="; charset=UTF-8

--3P0J/hWi9Ws=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Name of user not set #1000061, Ralf L=
ici=2E

Arne Schwabe has uploaded a new patch set (#7)=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail )


Change subject: Add pytho=
n scripts that demonstrate the ACC protocol
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add python scripts that demonstrate the ACC=
 protocol

This adds a small protocol called sys_info that let's the server=

query various details about the client to demonstrate the capabilities
of =
the ACC functionality=2E

Change-Id: I695967524bb9e83887b8c07d0d09baff6e41a=
cf4
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
A sample/managemen=
t/acc_sysinfo_client_demo=2Epy
A sample/management/acc_sysinfo_server_demo=
=2Epy
2 files changed, 297 insertions(+), 0 deletions(-)


  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/37/2037/7

diff --git a/=
sample/management/acc_sysinfo_client_demo=2Epy b/sample/management/acc_sysi=
nfo_client_demo=2Epy
new file mode 100755
index 0000000=2E=2E60c4a1d
--- /d=
ev/null
+++ b/sample/management/acc_sysinfo_client_demo=2Epy
@@ -0,0 +1,156=
 @@
+#!/usr/bin/env python3
+# Copyright (c) 2026 OpenVPN Inc <sales@openvp=
n=2Enet>
+# Copyright (c) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+#
+# Perm=
ission is hereby granted, free of charge, to any person obtaining a copy
+#=
 of this software and associated documentation files (the "Software"), to d=
eal
+# in the Software without restriction, including without limitation th=
e rights
+# to use, copy, modify, merge, publish, distribute, sublicense, a=
nd/or sell
+# copies of the Software, and to permit persons to whom the Sof=
tware is
+# furnished to do so, subject to the following conditions:
+#
+# =
The above copyright notice and this permission notice shall be included in =
all
+# copies or substantial portions of the Software=2E
+#
+# THE SOFTWARE=
 IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, =
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS =
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE
+# AU=
THORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIA=
BILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
=
+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS I=
N THE
+# SOFTWARE=2E
+
+# This implements a small demonstration of using th=
e
+# OpenVPN Access Server Management Interface (OMI) and an app Custom Con=
trol
+# protocol (sys_info) to retrieve a number of system information from=
 the
+# client and push them to the server=2E To use this use on the server=

+
+# --management-client-auth
+# --app-custom-control sys_info
+# --manage=
ment /path/to/acc_sysinfo_server_demo=2Epy unix-script
+
+# and on the clie=
nt
+# --app-custom-control sys_info
+# --management /path/to/acc_sysinfo_cl=
ient_demo=2Epy unix-script
+
+# Note this is just a demonstration and not a=
 production-ready solution=2E
+# When modifying this code, keep the securit=
y in mind=2E It is easy to
+# introduce a security problem when executing c=
ommands on the client=2E
+
+import asyncio
+import json
+import logging
+im=
port os
+import platform
+import subprocess
+from asyncio import CancelledE=
rror, Future
+
+logging=2EbasicConfig()
+
+from omi_tools import run_main, =
start_management_protocol, ConnectData
+from omi_client_protocol import OMI=
ClientProtocol
+
+logger =3D logging=2EgetLogger(__name__)
+logger=2EsetLev=
el(logging=2EINFO)
+
+
+class OmiSysInfoClientProtocol(OMIClientProtocol):
=
+    def __init__(self, finish_future: Future, connect_data: ConnectData):
=
+        super()=2E__init__(finish_future, connect_data)
+
+    async def r=
eceive_acc_sys_info(self, acc_message: bytes) -> None:
+        logger=2Ede=
bug(f"Received sys_info message: {acc_message!r}")
+        try:
+         =
   msg =3D json=2Eloads(acc_message)
+
+            await self=2Esend_info_=
response(msg)
+        except Exception as e:
+            logger=2Eerror(f=
"Error processing sysinfo request: {e}")
+
+    async def send_info_respons=
e(self, msg: dict) -> None:
+        response =3D {}
+        if msg=2Eget(=
"uname", False):
+            response['uname'] =3D platform=2Euname()=2E_a=
sdict()
+
+        if msg=2Eget("username", False):
+            try:
+    =
            response['username'] =3D os=2Egetlogin()
+            except OS=
Error as ose:
+                response['username'] =3D f"(error encountere=
d fetching username: {ose})"
+
+        if msg=2Eget("hostname", False):
+ =
           response['hostname'] =3D platform=2Enode()
+
+        if msg=2Eg=
et("dns-google=2Ecom", False):
+            try:
+                loop =3D =
asyncio=2Eget_running_loop()
+                addrs =3D [x[4][0] for x in a=
wait loop=2Egetaddrinfo('google=2Ecom', 443)]
+                response["dn=
s-google=2Ecom"] =3D addrs
+
+            except Exception as e:
+         =
       logger=2Eerror(f"Error resolving DNS for google=2Ecom: {e}", exc_inf=
o=3DTrue)
+                response["dns-google=2Ecom"] =3D None
+
+       =
 if msg=2Eget("route", False):
+            response['route'] =3D await sel=
f=2Eget_routes(False)
+
+        if msg=2Eget("route6", False):
+          =
  response['route6'] =3D await self=2Eget_routes(True)
+
+        msg =3D j=
son=2Edumps(response)=2Eencode()
+
+        await self=2Esend_acc_msg("sys_=
info", msg)
+
+    @staticmethod
+    async def get_routes(v6: bool) -> str=
:
+        try:
+            if platform=2Esystem() =3D=3D 'Linux':
+      =
          if not os=2Epath=2Eexists('/usr/sbin/ip'):
+                    r=
eturn "Command /usr/sbin/ip does not exist"
+                cmd =3D '/usr/=
sbin/ip'
+                if v6:
+                    args =3D ['-6', 'rout=
e', 'show']
+                else:
+                    args =3D ['-4', 'ro=
ute', 'show']
+            elif platform=2Esystem() =3D=3D 'Darwin' or plat=
form=2Esystem() =3D=3D 'FreeBSD':
+                # FreeBSD and macOS
+   =
             if os=2Epath=2Eexists('/usr/sbin/netstat'):
+                 =
   cmd =3D '/usr/sbin/netstat'
+                else:
+                    =
cmd =3D '/usr/bin/netstat'
+
+                if v6:
+                    a=
rgs =3D ['-f', 'inet6', '-rn']
+                else:
+
+                  =
  args =3D ['-f', 'inet', '-rn']
+            else:
+                return=
 "Unsupported platform"
+
+            proc =3D await asyncio=2Esubprocess=
=2Ecreate_subprocess_exec(cmd, *args, stdout=3Dsubprocess=2EPIPE)
+
+      =
      output, _ =3D await asyncio=2Ewait_for(proc=2Ecommunicate(), timeout=
=3D15)
+        except asyncio=2ETimeoutError, OSError:
+            proc=
=2Ekill()
+            return "Timeout while waiting for command output"
+
=
+        return output=2Edecode()
+
+
+async def main(connect_data: Connect=
Data):
+    transport, protocol, finish_future =3D await start_management_p=
rotocol(connect_data, OmiSysInfoClientProtocol)
+
+    management_version =
=3D await protocol=2Emanagement_ready()
+    logger=2Edebug(f"Management in=
terface version: {management_version}")
+
+    await protocol=2Eset_bytecou=
nt_interval(5)
+
+    try:
+        await finish_future
+    except Cancell=
edError:
+        # Ignore errors like ones caused by Control+C in the demo=
 script
+        pass
+
+
+if __name__ =3D=3D '__main__':
+    run_main(mai=
n)
diff --git a/sample/management/acc_sysinfo_server_demo=2Epy b/sample/man=
agement/acc_sysinfo_server_demo=2Epy
new file mode 100755
index 0000000=2E=
=2E9918e11
--- /dev/null
+++ b/sample/management/acc_sysinfo_server_demo=2E=
py
@@ -0,0 +1,141 @@
+#! /usr/bin/env python3
+# Copyright (c) 2026 OpenVPN=
 Inc <sales@openvpn=2Enet>
+# Copyright (c) 2026 Arne Schwabe <arne@rfc2549=
=2Eorg>
+#
+# Permission is hereby granted, free of charge, to any person o=
btaining a copy
+# of this software and associated documentation files (the=
 "Software"), to deal
+# in the Software without restriction, including wit=
hout limitation the rights
+# to use, copy, modify, merge, publish, distrib=
ute, sublicense, and/or sell
+# copies of the Software, and to permit perso=
ns to whom the Software is
+# furnished to do so, subject to the following =
conditions:
+#
+# The above copyright notice and this permission notice sha=
ll be included in all
+# copies or substantial portions of the Software=2E
=
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVE=
NT SHALL THE
+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE, ARISING FROM,
+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE O=
R OTHER DEALINGS IN THE
+# SOFTWARE=2E
+
+# This implements a small demonst=
ration of using the
+# OpenVPN Access Server Management Interface (OMI) and=
 an app Custom Control
+# protocol (sys_info) to retrieve a number of syste=
m information from the
+# client and push them to the server=2E To use this=
 use on the server
+
+# --management-client-auth
+# --app-custom-control sy=
s_info
+# --management /path/to/acc_sysinfo_server_demo=2Epy unix-script
+
=
+# and on the client
+# --app-custom-control sys_info
+# --management /path=
/to/acc_sysinfo_client_demo=2Epy unix-script
+
+# Note this is just a demon=
stration and not a production-ready solution=2E
+# When modifying this code=
, keep the security in mind=2E It is easy to
+# introduce a security proble=
m when executing commands on the client=2E
+
+import asyncio
+import json
+=
import logging
+import random
+from dataclasses import dataclass
+
+from om=
i_server_protocol import OMIServerProtocol, ConnectedClient
+from omi_tools=
 import run_main, start_management_protocol, ConnectData
+
+logging=2Ebasic=
Config()
+logger =3D logging=2EgetLogger(__name__)
+logger=2EsetLevel(loggi=
ng=2EINFO)
+
+
+@dataclass
+class SysInfoConnectedClient(ConnectedClient):
=
+    # Remember the key-id that we authenticated
+    authenticated_kid: in=
t =3D -1
+    username: str =3D ""
+    common_name: str =3D ""
+
+
+class =
OMISysInfoServerProtocol(OMIServerProtocol):
+    def __init__(self, finish=
_future, connect_data: ConnectData):
+        super()=2E__init__(finish_fut=
ure, connect_data)
+        self=2E_connected_client_class =3D SysInfoConne=
ctedClient
+
+    def client_event_ESTABLISHED(self, client: SysInfoConnect=
edClient, kid: int, env: dict, extra: str):
+        logger=2Edebug(f"CLien=
t connected: {client}")
+
+        kid =3D client=2Eauthenticated_kid
+    =
    client=2Eusername =3D env=2Eget("username", "(no username found)")
+   =
     client=2Ecommon_name =3D env=2Eget("common_name", "(no common name fou=
nd)")
+        self=2Eadd_background_task(self=2E_send_sys_info_command(cli=
ent, kid))
+
+    def client_event_CONNECT(self, client: SysInfoConnectedCl=
ient, kid: int, env: dict, extra: str):
+        logger=2Edebug(f"Authentic=
ating client {client=2Ecid}, {kid}")
+        self=2Equeue_command(f"client=
-auth-nt {client=2Ecid} {kid}")
+        client=2Eauthenticated_kid =3D kid=

+
+    def client_event_REAUTH(self, client: SysInfoConnectedClient, kid: =
int, env: dict, extra: str):
+        logger=2Edebug(f"Re-authenticating cl=
ient {client} on re-negotiation")
+        _ =3D self=2Equeue_command(f"cli=
ent-auth-nt {client=2Ecid} {kid}")
+        client=2Eauthenticated_kid =3D =
kid
+
+    async def _send_sys_info_command(self, client: SysInfoConnectedC=
lient, kid: int):
+        # Give the client some time to settle its routes=

+        await asyncio=2Esleep(5)
+
+        if "sys_info" not in client=
=2Eacc_negotiated_protocols:
+            logger=2Einfo(
+                f=
"Client {client=2Ecid} (Username: {client=2Eusername!r}, CN: {client=2Ecomm=
on_name!r}) does not support sys_info protocol")
+            return
+
+   =
     info =3D ["route", "route6", "dns-google=2Ecom", "username", "hostname=
", "uname"]
+
+        # Pick 3 random infos to request from the client
+  =
      random=2Eshuffle(info)
+        infos =3D info[:3]
+        request =
=3D {k: True for k in infos}
+
+        req_str =3D json=2Edumps(request)=
=2Eencode()
+
+        logger=2Einfo(f"Sending sysinfo request for client {=
client=2Ecid} with infos: {infos}")
+
+        acc_protocol =3D "sys_info"
=
+
+        await self=2Esend_acc_msg(client, kid, acc_protocol, req_str)
+
=
+    def receive_acc_client_sys_info(self, client: SysInfoConnectedClient, =
kid: int, acc_msg: bytes):
+        try:
+            logger=2Einfo(
+     =
           f"Received sysinfo from client {client=2Ecid} (Username: {client=
=2Eusername!r}, CN: {client=2Ecommon_name!r})")
+
+            response =3D=
 json=2Eloads(acc_msg)
+            for key in response=2Ekeys():
+        =
        logger=2Einfo(f"=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D {key!r} =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D")
+                if isin=
stance(response[key], str):
+                    for line in response[key]=
=2Esplit("\n"):
+                        logger=2Einfo(repr(line))
+       =
         else:
+                    logger=2Einfo(repr(response[key]))
+
+ =
       except Exception as e:
+            logger=2Eerror(f"Error processin=
g sysinfo from client {client=2Ecid}: {e}")
+
+
+async def main(connect_dat=
a: ConnectData):
+    transport, protocol, finish_future =3D await start_ma=
nagement_protocol(connect_data, OMISysInfoServerProtocol)
+
+    management=
_version =3D await protocol=2Emanagement_ready()
+    logger=2Edebug(f"Mana=
gement interface version: {management_version}")
+
+    await protocol=2Een=
able_log()
+
+    await protocol=2Eset_bytecount_interval(5)
+
+    await f=
inish_future
+
+
+if __name__ =3D=3D '__main__':
+    run_main(main)

-- 
T=
o view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Pro=
ject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I695967524bb9e83887b8=
c07d0d09baff6e41acf4
Gerrit-Change-Number: 2037
Gerrit-PatchSet: 7
Gerrit-O=
wner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Name of user not=
 set #1000061
Gerrit-CC: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Name of=
 user not set #1000061
Gerrit-Attention: Ralf Lici <ralf@mandelbit=2Ecom>

--3P0J/hWi9Ws=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Name of user not set #1000061, Ralf Lici=2E </p>
<p>A=
rne Schwabe <strong>uploaded patch set #7</strong> to this change=2E</p><p>=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail">Vie=
w Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Add python scripts that demonstrate the ACC p=
rotocol<br><br>This adds a small protocol called sys_info that let&#39;s th=
e server<br>query various details about the client to demonstrate the capab=
ilities<br>of the ACC functionality=2E<br><br>Change-Id: I695967524bb9e8388=
7b8c07d0d09baff6e41acf4<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eo=
rg&gt;<br>---<br>A sample/management/acc_sysinfo_client_demo=2Epy<br>A samp=
le/management/acc_sysinfo_server_demo=2Epy<br>2 files changed, 297 insertio=
ns(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/37/2037/7</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/sampl=
e/management/acc_sysinfo_client_demo=2Epy b/sample/management/acc_sysinfo_c=
lient_demo=2Epy</span><br><span>new file mode 100755</span><br><span>index =
0000000=2E=2E60c4a1d</span><br><span>--- /dev/null</span><br><span>+++ b/sa=
mple/management/acc_sysinfo_client_demo=2Epy</span><br><span>@@ -0,0 +1,156=
 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#!/usr/bin/env p=
ython3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Copyright (=
c) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+# Copyright (c) 2026 Arne Schwabe &lt;arne@rfc2=
549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+# Permission is hereby g=
ranted, free of charge, to any person obtaining a copy</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+# of this software and associated docume=
ntation files (the &quot;Software&quot;), to deal</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+# in the Software without restriction, includ=
ing without limitation the rights</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+# to use, copy, modify, merge, publish, distribute, sublicens=
e, and/or sell</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# cop=
ies of the Software, and to permit persons to whom the Software is</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# furnished to do so, subjec=
t to the following conditions:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# The a=
bove copyright notice and this permission notice shall be included in all</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# copies or substanti=
al portions of the Software=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# THE S=
OFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRES=
S OR</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# IMPLIED, INCL=
UDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+# FITNESS FOR A PARTICULAR PURPOSE =
AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY C=
LAIM, DAMAGES OR OTHER</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISIN=
G FROM,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# OUT OF OR =
IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+# SOFTWARE=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+# This implements a small demonstration of using the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# OpenVPN Access Se=
rver Management Interface (OMI) and an app Custom Control</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+# protocol (sys_info) to retrieve a n=
umber of system information from the</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# client and push them to the server=2E To use this use on=
 the server</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+# --management-client-auth<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+# --app-custom-contr=
ol sys_info</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# --mana=
gement /path/to/acc_sysinfo_server_demo=2Epy unix-script</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+# and on the client</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+# --app-custom-control sys_info</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+# --management /path/to/acc_sysinfo_client_de=
mo=2Epy unix-script</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Note this is just=
 a demonstration and not a production-ready solution=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+# When modifying this code, keep the se=
curity in mind=2E It is easy to</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# introduce a security problem when executing commands on the c=
lient=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+import asyncio</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+import json</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+import logging</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+import os</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+import platform</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+import subprocess</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+from asyncio import CancelledError, Future</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+logging=2EbasicConfig()</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+from omi_tools import run_main, start_management_protocol, ConnectData</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+from omi_client_protoc=
ol import OMIClientProtocol</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+logger =3D =
logging=2EgetLogger(__name__)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+logger=2EsetLevel(logging=2EINFO)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+class OmiSysIn=
foClientProtocol(OMIClientProtocol):</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    def __init__(self, finish_future: Future, connect_data=
: ConnectData):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    super()=2E__init__(finish_future, connect_data)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    async def receive_acc_sys_info(self, acc_message: bytes)=
 -&gt; None:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 logger=2Edebug(f&quot;Received sys_info message: {acc_message!r}&quot;)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        try:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            msg =3D json=2Elo=
ads(acc_message)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            await self=
=2Esend_info_response(msg)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        except Exception as e:</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            logger=2Eerror(f&quot;Error processing sysinf=
o request: {e}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    async def sen=
d_info_response(self, msg: dict) -&gt; None:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        response =3D {}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if msg=2Eget(&quot;uname&quot;, False)=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            respon=
se[&#39;uname&#39;] =3D platform=2Euname()=2E_asdict()</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if msg=2Eget(&quot;username&quot;, False):</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            try:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                response[&#39;u=
sername&#39;] =3D os=2Egetlogin()</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            except OSError as ose:</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                response[&#39;username&#39;] =
=3D f&quot;(error encountered fetching username: {ose})&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if msg=2Eget(&quot;hostname&quot;, False):</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            response[=
&#39;hostname&#39;] =3D platform=2Enode()</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if msg=2Eget(&quot;dns-google=2Ecom&quot;, False):</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            try:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                loop =3D asyncio=2Eg=
et_running_loop()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              addrs =3D [x[4][0] for x in await loop=2Egetaddrinfo(&#39;goo=
gle=2Ecom&#39;, 443)]</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                response[&quot;dns-google=2Ecom&quot;] =3D addrs</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            except Exception as e:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                logger=2Eerror(f=
&quot;Error resolving DNS for google=2Ecom: {e}&quot;, exc_info=3DTrue)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                respons=
e[&quot;dns-google=2Ecom&quot;] =3D None</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if msg=2Eget(&quot;route&quot;, False):</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            response[&#39;route&#39;] =3D awa=
it self=2Eget_routes(False)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
msg=2Eget(&quot;route6&quot;, False):</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            response[&#39;route6&#39;] =3D await self=2Eg=
et_routes(True)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg =3D json=2E=
dumps(response)=2Eencode()</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        awai=
t self=2Esend_acc_msg(&quot;sys_info&quot;, msg)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    @staticmethod</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    async def get_routes(v6: bool) -&gt; str:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        try:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            if platform=2Esystem() =3D=3D &#39;L=
inux&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       if not os=2Epath=2Eexists(&#39;/usr/sbin/ip&#39;):</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    return &quot;Comm=
and /usr/sbin/ip does not exist&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                cmd =3D &#39;/usr/sbin/ip&#39;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                if v6:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                    args =
=3D [&#39;-6&#39;, &#39;route&#39;, &#39;show&#39;]</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                else:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    args =3D [&#39;-4&#=
39;, &#39;route&#39;, &#39;show&#39;]</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            elif platform=2Esystem() =3D=3D &#39;Darwin&#=
39; or platform=2Esystem() =3D=3D &#39;FreeBSD&#39;:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                # FreeBSD and macOS</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                if os=2Ep=
ath=2Eexists(&#39;/usr/sbin/netstat&#39;):</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    cmd =3D &#39;/usr/sbin/netstat&#=
39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
else:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
      cmd =3D &#39;/usr/bin/netstat&#39;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                if v6:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    args =3D [&#39;-f&#39;, &#39;inet6&#39;, &#39;-rn&=
#39;]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  else:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    args =3D [&=
#39;-f&#39;, &#39;inet&#39;, &#39;-rn&#39;]</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            else:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                return &quot;Unsupported platform&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            proc =3D await asyncio=
=2Esubprocess=2Ecreate_subprocess_exec(cmd, *args, stdout=3Dsubprocess=2EPI=
PE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            output, _ =3D await asy=
ncio=2Ewait_for(proc=2Ecommunicate(), timeout=3D15)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        except asyncio=2ETimeoutError, OS=
Error:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            p=
roc=2Ekill()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     return &quot;Timeout while waiting for command output&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return output=2Edecode()</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+async def main(connect_data: ConnectData):</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    transport, protocol, finish_future =3D await st=
art_management_protocol(connect_data, OmiSysInfoClientProtocol)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    management_version =3D await protocol=2Emanage=
ment_ready()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    log=
ger=2Edebug(f&quot;Management interface version: {management_version}&quot;=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    await protocol=2Eset_bytecount_in=
terval(5)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    try:</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        await finish_future</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    except CancelledError:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        # Ignore errors l=
ike ones caused by Control+C in the demo script</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        pass</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if __name__ =3D=
=3D &#39;__main__&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    run_main(main)</span><br><span>diff --git a/sample/management/acc_s=
ysinfo_server_demo=2Epy b/sample/management/acc_sysinfo_server_demo=2Epy</s=
pan><br><span>new file mode 100755</span><br><span>index 0000000=2E=2E9918e=
11</span><br><span>--- /dev/null</span><br><span>+++ b/sample/management/ac=
c_sysinfo_server_demo=2Epy</span><br><span>@@ -0,0 +1,141 @@</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#! /usr/bin/env python3</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# Copyright (c) 2026 OpenVPN I=
nc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+# Copyright (c) 2026 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# Permission is hereby granted, free of c=
harge, to any person obtaining a copy</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+# of this software and associated documentation files (th=
e &quot;Software&quot;), to deal</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+# in the Software without restriction, including without limit=
ation the rights</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# t=
o use, copy, modify, merge, publish, distribute, sublicense, and/or sell</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+# copies of the Softwa=
re, and to permit persons to whom the Software is</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+# furnished to do so, subject to the followin=
g conditions:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+# The above copyright no=
tice and this permission notice shall be included in all</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+# copies or substantial portions of th=
e Software=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+# THE SOFTWARE IS PROVID=
ED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+# IMPLIED, INCLUDING BUT NOT LIM=
ITED TO THE WARRANTIES OF MERCHANTABILITY,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEME=
NT=2E IN NO EVENT SHALL THE</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# LIABILITY, W=
HETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# OUT OF OR IN CONNECTION WIT=
H THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+# SOFTWARE=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+# This implements a small demonstration of using the</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+# OpenVPN Access Server Management I=
nterface (OMI) and an app Custom Control</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+# protocol (sys_info) to retrieve a number of system i=
nformation from the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
# client and push them to the server=2E To use this use on the server</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+# --management-client-auth</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+# --app-custom-control sys_info</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+# --management /path/to/a=
cc_sysinfo_server_demo=2Epy unix-script</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# and on the client</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# --app-custom-control sys_info</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+# --management /path/to/acc_sysinfo_client_demo=2Epy unix-scri=
pt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+# Note this is just a demonstration =
and not a production-ready solution=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+# When modifying this code, keep the security in mind=2E=
 It is easy to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# int=
roduce a security problem when executing commands on the client=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+import asyncio</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+import json</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+import logging</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+import random</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+from dataclasses import dataclass</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+f=
rom omi_server_protocol import OMIServerProtocol, ConnectedClient</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+from omi_tools import run_mai=
n, start_management_protocol, ConnectData</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+logging=2EbasicConfig()</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+logger =3D logging=2EgetLogger(__name__)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+logger=2EsetLevel(logging=2EINFO)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+@dataclass</span><br><span style=3D"color: hsl(120, 100%, 40%);">+class=
 SysInfoConnectedClient(ConnectedClient):</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    # Remember the key-id that we authenticated</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    authenticated_kid: in=
t =3D -1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    usernam=
e: str =3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    common_name: str =3D &quot;&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+class OMISysInfo=
ServerProtocol(OMIServerProtocol):</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    def __init__(self, finish_future, connect_data: ConnectD=
ata):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        super(=
)=2E__init__(finish_future, connect_data)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        self=2E_connected_client_class =3D SysInfoCon=
nectedClient</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    def client_event_ESTAB=
LISHED(self, client: SysInfoConnectedClient, kid: int, env: dict, extra: st=
r):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        logger=
=2Edebug(f&quot;CLient connected: {client}&quot;)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        kid =3D client=2Eauthenticated_kid</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        client=2Eusername =3D env=2Eget(&=
quot;username&quot;, &quot;(no username found)&quot;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        client=2Ecommon_name =3D env=2Ege=
t(&quot;common_name&quot;, &quot;(no common name found)&quot;)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        self=2Eadd_background_ta=
sk(self=2E_send_sys_info_command(client, kid))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    def client_event_CONNECT(self, client: SysInfoConnectedClient, =
kid: int, env: dict, extra: str):</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        logger=2Edebug(f&quot;Authenticating client {client=
=2Ecid}, {kid}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        self=2Equeue_command(f&quot;client-auth-nt {client=2Ecid} {kid}&q=
uot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        client=
=2Eauthenticated_kid =3D kid</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def cl=
ient_event_REAUTH(self, client: SysInfoConnectedClient, kid: int, env: dict=
, extra: str):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   logger=2Edebug(f&quot;Re-authenticating client {client} on re-negotiatio=
n&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        _ =
=3D self=2Equeue_command(f&quot;client-auth-nt {client=2Ecid} {kid}&quot;)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        client=2Eaut=
henticated_kid =3D kid</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    async def _s=
end_sys_info_command(self, client: SysInfoConnectedClient, kid: int):</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        # Give the client=
 some time to settle its routes</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        await asyncio=2Esleep(5)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if &quot;sys_info&quot; not in client=2Eacc_negotiated_protoc=
ols:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            log=
ger=2Einfo(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        f&quot;Client {client=2Ecid} (Username: {client=2Eusername!r}, CN: =
{client=2Ecommon_name!r}) does not support sys_info protocol&quot;)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            return</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        info =3D [&quot;route&quot;, &quot;rout=
e6&quot;, &quot;dns-google=2Ecom&quot;, &quot;username&quot;, &quot;hostnam=
e&quot;, &quot;uname&quot;]</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # P=
ick 3 random infos to request from the client</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        random=2Eshuffle(info)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        infos =3D info[:3]</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        request =3D {k: True fo=
r k in infos}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        req_str =3D json=
=2Edumps(request)=2Eencode()</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        lo=
gger=2Einfo(f&quot;Sending sysinfo request for client {client=2Ecid} with i=
nfos: {infos}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        acc_protoc=
ol =3D &quot;sys_info&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        awa=
it self=2Esend_acc_msg(client, kid, acc_protocol, req_str)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    def receive_acc_client_sys_info(self, client: SysIn=
foConnectedClient, kid: int, acc_msg: bytes):</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        try:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            logger=2Einfo(</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                f&quot;Received sysinfo from clie=
nt {client=2Ecid} (Username: {client=2Eusername!r}, CN: {client=2Ecommon_na=
me!r})&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            response =3D =
json=2Eloads(acc_msg)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            for key in response=2Ekeys():</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                logger=2Einfo(f&quot;=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D {key!r} =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                if isinstance(response[key], str):</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                    for line in response[key=
]=2Esplit(&quot;\n&quot;):</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                        logger=2Einfo(repr(line))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                else:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    logger=2Einfo(re=
pr(response[key]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        except Excep=
tion as e:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   logger=2Eerror(f&quot;Error processing sysinfo from client {client=2Ecid=
}: {e}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+async def main(connect_data: ConnectData):</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    transport, protoc=
ol, finish_future =3D await start_management_protocol(connect_data, OMISysI=
nfoServerProtocol)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    management_versi=
on =3D await protocol=2Emanagement_ready()</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    logger=2Edebug(f&quot;Management interface versi=
on: {management_version}&quot;)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    awa=
it protocol=2Eenable_log()</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    await pr=
otocol=2Eset_bytecount_interval(5)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
await finish_future</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+if __name__ =3D=3D &#39;__main__&#39;:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    run_main(main)<=
/span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2037?usp=3Demail">change 2037</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: I695967524bb9e83887b8c07d0d09ba=
ff6e41acf4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2037 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"=
display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: Name of user not set #1000=
061 </div>
<div style=3D"display:none"> Gerrit-CC: Ralf Lici &lt;ralf@mande=
lbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: Name of user not set #1000061 </div>
<div style=
=3D"display:none"> Gerrit-Attention: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt;=
 </div>

</body></html>
--3P0J/hWi9Ws=--


--===============7841887802372507516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7841887802372507516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7841887802372507516==--

