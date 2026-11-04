Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4D4606A326
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=K5efG5ur;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PfouSDEy;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=j+8AOPhB;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YzQa2WKW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Ualjwi85Xht788yaRXMyxYISKzmZ0uBvPUSxyBTrRAw=; b=K5efG5urSWHgzrXltwq1Xwhdd/
	u5DaqdpACa6WYuKrejS9ajGhjoAPxhInWAU7bEZ7sP5KlTaaTGat6dpuDqWTTmLw4YttA8wkoi90h
	cjoU4VmEpbljaO9w+isuK3Xm9D4cNp5s/kvhHLethKx1lMQuhwZOqkJ6HdE6bj7t1Ed0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOjpO-0000000064i-2FPa;
	Wed, 04 Nov 2026 22:51:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOjpN-0000000064Z-0X8E
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 22:51:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wd8vluI0CCkqp3qoiDWQcGJM3f0bAFAEb5nCqCMlnMU=; b=PfouSDEyn7iYqqZBCdZsCfwBJy
 /l9k5jJaJ4BU7vNzkeis7YzgkUSHTjO151QSw4mfMx7Yd6rkLUOvkoEJ0+Z9nFLZ3xp3QjBWVHj+d
 VMrlu5EWk5wAoNr0v1lYwestSYCVGGIOao0cWkR0VQCiZDD91+dItuS6tnGPQlRi9mQ8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wd8vluI0CCkqp3qoiDWQcGJM3f0bAFAEb5nCqCMlnMU=; b=j+8AOPhBqzwsbNWNV9XTZjXoqb
 dIsPmZMX0pU9ZJ0xiKZpvJNi62JCgJQHK/XxYaeMbjyND18ykV3qphqo7CsTA751y5+BwfkUGJ3GZ
 IcudUPxQHNluPtHQMSKwplMv7AhefS01U59WwJ6ODXAFCTj1Fy8exct+YQmI4sHI4PZM=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOjpJ-000000000es-0lTZ for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 22:51:33 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so8975755e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 14:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793832682; x=1794437482; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wd8vluI0CCkqp3qoiDWQcGJM3f0bAFAEb5nCqCMlnMU=;
 b=YzQa2WKW3ieDV94Y9bLLHcBdb8ek8UhCTBGdJiVX8UpWDQYtFaveaXgWv1MQ8q9vn0
 827AiItGPwYxAtTmtPkcfgvSJuB1DctTX+gDSPx7JQLOhXl5Yt4aN8s40EOMVWUPcbmP
 uDqytcJj9vrjrBpJe8v/dioFmgEzYzvXbBixjHiqP1flQfod3MP31Azxi8x547qBuaUC
 Sn7YuewBd8tZhQ/AtpHLdwnoE33BsON2j6kMgad4n5ybWABeoveFzDQL4qW0WYCz67RE
 Lv18ZikUl7ppiSMz/bzfUhtUtR588vjkMclrLSa67Jh1oE9Y8df/nhxGgPwSsEu3N6Xg
 WSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793832682; x=1794437482;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wd8vluI0CCkqp3qoiDWQcGJM3f0bAFAEb5nCqCMlnMU=;
 b=KNowCkGwirgtJ+p0WRxo+6RxUV+sDYAf8WZKtNoFZ7kX4q6xqBsiYPgGgPC6+1wqaa
 k7cuzrZNLt4PEPQhnydmhq4CoA+vBz/UmB6Cuyn0GY8DAqLl7c6X4/e0q8BS43EmsUJk
 t4fTTvdX5vZb2YQNitrlFAPqEl0AF+KWFVkqPVJiXCrfZYKNFOsGpi+rJiUaVx/gY/bq
 NKYNfkO+BsibjiVRgyNijMI2f9A6u4svs/yJNUQmWVHpAbctfNoAsnhGGHiBJ8L/UInI
 AVtWPQvdxDbuPB12ZWWZgBpGOmsEVb9Y/r8S9yEdZL3CRv/zPQRSQjKhOWRauXpFX+SC
 yYOQ==
X-Gm-Message-State: APuU4Z/kag9biAqcJRO85JRb4sHIW6yzKH2cLYCu8ki/QTJlFojhamCh
 b5QSW7asMFnDO0jKH8EFMzkr4AloKqfJ0+VFNYPCAmTFSXRV647tYXTHhWUAYpl+t0ATqPYlp+J
 kgQEEbW2GYsyvy90gCN1eIEpnnJytSU0+c7g0kCqUPqrpIDlpenElLemCzGiiKmFnSs8BWt7VaF
 aC9OKDFQ==
X-Gm-Gg: AYBFou1bs71jnReTDy3NKaCRAe/JHIscksurbCqozGd7IfmQPURl/WMgdcqCDlFit1J
 KOspT3UOWEbZV1CRWXaWJII6KRl6JxItrpdr5YmO/Lvkcocw7Z4f0LSK0Dvx3joitGAlq5PNYHx
 iN769Lhijpmx0/ImcSYlg64/gJcS6Iwg72XauzL05rkcBTCAYXee7mFGCRC6kl8xllyH5OZ/3ep
 LQb0Zs/39a+J+E/1vTTeVDjl521NUvAwCx8PTludenxBI350hWSyLj98YcfNqGis7RwwLUiAfyl
 DqtZ6seVKzxSlRH5N0UGwsW3sZR2giz3EpmFWLR/fYXkNJsdDuS9KAa1zwp0zivAHZbdncdmT4Y
 r9kgNcd69dWJ/KzUVKC1cABe+APT2nFGJR97vlZsBrr55PwGpPawcbmhJIxuU4eY6Hdbs5uKuff
 4hB6jhTGtzCkjy30OP+vPpe4e7E6Jz9OhfoMKdlBkiQrPbNqwaR4fXwlI7qJ9SYjA6JCgYNvHK0
 aMorHo84IyZLX4qRMo0dQWtpDelT2aSOasHifGPOjeytsZHXIYwXjZsO5oOOrjpceZ1fU1KlRLg
 RHWIEm68NZODPo43KEtsojDuQYjW3ycgdiSVTvpTY3T5RSKtW4GaK80vK3FWGL+ve/PPu1AMMgm
 KpvE0dB6bcik5PXHidWn+PhERKT+vpAwX+ZXpIia8DJ19lLNXxwVIVpJElkyfioiLmvyX237Lv/
 svJzd3vCYKiMPPIg==
X-Received: by 2002:a05:600c:8b55:b0:4a3:59c9:a744 with SMTP id
 5b1f17b1804b1-4ac17191117mr372030745e9.7.1793832682121; 
 Wed, 04 Nov 2026 14:51:22 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm40463795e9.1.2026.11.04.14.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 14:51:21 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 22:51:17 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4
X-Gerrit-Change-Number: 2037
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2037?usp=email>
X-Gerrit-Commit: ddbf72ce8b80dbaaab4d1deca12cd40031e34800
In-Reply-To: <gerrit.1793043747000.I695967524bb9e83887b8c07d0d09baff6e41acf4@gerrit.openvpn.net>
References: <gerrit.1793043747000.I695967524bb9e83887b8c07d0d09baff6e41acf4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDQzNzQ3MDAwLkk2OTU5Njc1MjRiYjllODM4ODdiOGMwN2QwZDA5YmFmZjZlNDFhY2Y0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <308c83b9394bb374da3a22f20f6a38e373e98a5c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOjpJ-000000000es-0lTZ
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
Content-Type: multipart/mixed; boundary="===============9018440835924599518=="
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9018440835924599518==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bUWj4eZH3u4="; charset=UTF-8

--bUWj4eZH3u4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Ralf Lici=2E

Arne Schw=
abe has uploaded a new patch set (#6)=2E ( https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2037?usp=3Demail )


Change subject: Add python scripts that dem=
onstrate the ACC protocol
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

Add python scripts that demonstrate the ACC protocol

This ad=
ds a small protocol called sys_info that let's the server
query various det=
ails about the client to demonstrate the capabilities
of the ACC functional=
ity=2E

Change-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4
Signed-off-by:=
 Arne Schwabe <arne@rfc2549=2Eorg>
---
A sample/management/acc_sysinfo_clie=
nt_demo=2Epy
A sample/management/acc_sysinfo_server_demo=2Epy
2 files chang=
ed, 291 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/37/2037/6

diff --git a/sample/management=
/acc_sysinfo_client_demo=2Epy b/sample/management/acc_sysinfo_client_demo=
=2Epy
new file mode 100755
index 0000000=2E=2Ea53eb6c
--- /dev/null
+++ b/s=
ample/management/acc_sysinfo_client_demo=2Epy
@@ -0,0 +1,151 @@
+#!/usr/bin=
/env python3
+# Copyright (c) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+# Cop=
yright (c) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+#
+# Permission is hereb=
y granted, free of charge, to any person obtaining a copy
+# of this softwa=
re and associated documentation files (the "Software"), to deal
+# in the S=
oftware without restriction, including without limitation the rights
+# to =
use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+# c=
opies of the Software, and to permit persons to whom the Software is
+# fur=
nished to do so, subject to the following conditions:
+#
+# The above copyr=
ight notice and this permission notice shall be included in all
+# copies o=
r substantial portions of the Software=2E
+#
+# THE SOFTWARE IS PROVIDED "A=
S IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT N=
OT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULA=
R PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE
+# AUTHORS OR COPYRI=
GHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER=
 IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+# OUT OF OR IN=
 CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+# SOFTWA=
RE=2E
+
+# This implements a small demonstration of using the
+# OpenVPN Ac=
cess Server Management Interface (OMI) and an app Custom Control
+# protoco=
l (sys_info) to retrieve a number of system information from the
+# client =
and push them to the server=2E To use this use on the server
+
+# --managem=
ent-client-auth
+# --app-custom-control sys_info
+# --management /path/to/a=
cc_sysinfo_server_demo=2Epy unix-script
+
+# and on the client
+# --app-cus=
tom-control sys_info
+# --management /path/to/acc_sysinfo_client_demo=2Epy =
unix-script
+
+# Note this is just a demonstration and not a production-rea=
dy solution=2E
+# When modifying this code, keep the security in mind=2E It=
 is easy to
+# introduce a security problem when executing commands on the =
client=2E
+
+import asyncio
+import json
+import logging
+import os
+import=
 platform
+import subprocess
+from asyncio import CancelledError
+
+logging=
=2EbasicConfig()
+
+from omi_tools import run_main, start_management_protoc=
ol, ConnectData
+from omi_client_protocol import OMIClientProtocol
+
+logge=
r =3D logging=2EgetLogger(__name__)
+logger=2EsetLevel(logging=2EINFO)
+
+
=
+class OmiSysInfoClientProtocol(OMIClientProtocol):
+    def __init__(self,=
 finish_future, connect_data: ConnectData):
+        super()=2E__init__(fin=
ish_future, connect_data)
+
+    async def receive_acc_sys_info(self, acc_m=
essage:bytes):
+        print(f"Received sys_info message: {acc_message!r}"=
)
+
+        logger=2Edebug(f"Received sys_info message: {acc_message!r}")
=
+        msg =3D json=2Eloads(acc_message)
+
+        await self=2Esend_inf=
o_response(msg)
+
+    async def send_info_response(self, msg):
+        re=
sponse =3D {}
+        if msg=2Eget("uname", False):
+            response[=
'uname'] =3D platform=2Euname()=2E_asdict()
+
+        if msg=2Eget("userna=
me", False):
+            try:
+                response['username'] =3D os=
=2Egetlogin()
+            except OSError as ose:
+                response=
['username'] =3D f"(error encountered fetching username: {ose})"
+
+       =
 if msg=2Eget("hostname", False):
+            response['hostname'] =3D pla=
tform=2Enode()
+
+        if msg=2Eget("dns-google=2Ecom", False):
+       =
     try:
+                loop =3D asyncio=2Eget_running_loop()
+         =
       addrs =3D [x[4][0] for x in await loop=2Egetaddrinfo('google=2Ecom',=
 443)]
+                response["dns-google=2Ecom"] =3D addrs
+
+         =
   except Exception as e:
+                logger=2Eerror(f"Error resolving=
 DNS for google=2Ecom: {e}", exc_info=3DTrue)
+                response["dn=
s-google=2Ecom"] =3D None
+
+        if msg=2Eget("route", False):
+       =
     response['route'] =3D await self=2Eget_routes(False)
+
+        if msg=
=2Eget("route6", False):
+            response['route6'] =3D await self=2Eg=
et_routes(True)
+
+        msg =3D json=2Edumps(response)=2Eencode()
+
+   =
     await self=2Esend_acc_msg("sys_info", msg)
+
+    async def get_routes=
(self, v6):
+        if platform=2Esystem() =3D=3D 'Linux':
+            cm=
d =3D '/usr/sbin/ip'
+            if v6:
+                args =3D ['-6', '=
route', 'show']
+            else:
+                args =3D ['-4', 'route'=
, 'show']
+        elif platform=2Esystem() =3D=3D 'Darwin' or platform=2Es=
ystem() =3D=3D 'FreeBSD':
+            # FreeBSD and macOS
+            if =
os=2Epath=2Eexists('/usr/sbin/netstat'):
+                cmd =3D '/usr/sbi=
n/netstat'
+            else:
+                cmd =3D '/usr/bin/netstat'
+=

+            if v6:
+                args =3D ['-f', 'inet6', '-rn']
+    =
        else:
+
+                args =3D ['-f', 'inet', '-rn']
+        el=
se:
+            return "Unsupported platform"
+
+        proc =3D await as=
yncio=2Esubprocess=2Ecreate_subprocess_exec(cmd, *args, stdout=3Dsubprocess=
=2EPIPE)
+        try:
+            output, _ =3D await asyncio=2Ewait_for(=
proc=2Ecommunicate(), timeout=3D15)
+        except asyncio=2ETimeoutError:=

+            proc=2Ekill()
+            return "Timeout while waiting for =
command output"
+
+        return output=2Edecode()
+
+
+async def main(con=
nect_data: ConnectData):
+    transport, protocol, finish_future =3D await =
start_management_protocol(connect_data, OmiSysInfoClientProtocol)
+
+    ma=
nagement_version =3D await protocol=2Emanagement_ready()
+    logger=2Edebu=
g(f"Management interface version: {management_version}")
+
+    await proto=
col=2Eset_bytecount_interval(5)
+
+    try:
+        await finish_future
+ =
   except CancelledError:
+        # Ignore errors like ones caused by Cont=
rol+C in the demo script
+        pass
+
+
+if __name__ =3D=3D '__main__':
=
+    run_main(main)
diff --git a/sample/management/acc_sysinfo_server_demo=
=2Epy b/sample/management/acc_sysinfo_server_demo=2Epy
new file mode 100755=

index 0000000=2E=2Edfc87db
--- /dev/null
+++ b/sample/management/acc_sysin=
fo_server_demo=2Epy
@@ -0,0 +1,140 @@
+#! /usr/bin/env python3
+# Copyright=
 (c) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+# Copyright (c) 2026 Arne Schw=
abe <arne@rfc2549=2Eorg>
+#
+# Permission is hereby granted, free of charge=
, to any person obtaining a copy
+# of this software and associated documen=
tation files (the "Software"), to deal
+# in the Software without restricti=
on, including without limitation the rights
+# to use, copy, modify, merge,=
 publish, distribute, sublicense, and/or sell
+# copies of the Software, an=
d to permit persons to whom the Software is
+# furnished to do so, subject =
to the following conditions:
+#
+# The above copyright notice and this perm=
ission notice shall be included in all
+# copies or substantial portions of=
 the Software=2E
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY O=
F ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANT=
IES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGE=
MENT=2E IN NO EVENT SHALL THE
+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR=
 ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT=
, TORT OR OTHERWISE, ARISING FROM,
+# OUT OF OR IN CONNECTION WITH THE SOFT=
WARE OR THE USE OR OTHER DEALINGS IN THE
+# SOFTWARE=2E
+
+# This implement=
s a small demonstration of using the
+# OpenVPN Access Server Management In=
terface (OMI) and an app Custom Control
+# protocol (sys_info) to retrieve =
a number of system information from the
+# client and push them to the serv=
er=2E To use this use on the server
+
+# --management-client-auth
+# --app-=
custom-control sys_info
+# --management /path/to/acc_sysinfo_server_demo=2E=
py unix-script
+
+# and on the client
+# --app-custom-control sys_info
+# -=
-management /path/to/acc_sysinfo_client_demo=2Epy unix-script
+
+# Note thi=
s is just a demonstration and not a production-ready solution=2E
+# When mo=
difying this code, keep the security in mind=2E It is easy to
+# introduce =
a security problem when executing commands on the client=2E
+
+import async=
io
+import json
+import logging
+import random
+from dataclasses import dat=
aclass
+
+from omi_server_protocol import OMIServerProtocol, ConnectedClien=
t
+from omi_tools import run_main, start_management_protocol, ConnectData
+=

+logging=2EbasicConfig()
+logger =3D logging=2EgetLogger(__name__)
+logger=
=2EsetLevel(logging=2EINFO)
+
+
+@dataclass
+class SysInfoConnectedClient(C=
onnectedClient):
+    # Remember the key-id that we authenticated
+    auth=
enticated_kid: int =3D -1
+    username: str =3D ""
+    common_name: str =
=3D ""
+
+
+class OMISysInfoServerProtocol(OMIServerProtocol):
+    def __i=
nit__(self, finish_future, connect_data: ConnectData):
+        super()=2E_=
_init__(finish_future, connect_data)
+        self=2E_connected_client_clas=
s =3D SysInfoConnectedClient
+
+    def client_event_ESTABLISHED(self, clie=
nt: SysInfoConnectedClient, kid: int, env: dict, extra: str):
+        logg=
er=2Eerror(f"CLient connected: {client}")
+        from pprint import pprin=
t
+
+        kid =3D client=2Eauthenticated_kid
+        client=2Eusername =
=3D env=2Eget("username", "(no username found)")
+        client=2Ecommon_n=
ame =3D env=2Eget("common_name", "(no common name found)")
+        asyncio=
=2Ecreate_task(self=2E_send_sys_info_command(client, kid))
+
+    def clien=
t_event_CONNECT(self, client: SysInfoConnectedClient, kid: int, env: dict, =
extra: str):
+        logger=2Edebug(f"Authenticating client {client=2Ecid}=
, {kid}")
+        self=2Equeue_command(f"client-auth-nt {client=2Ecid} {ki=
d}")
+        client=2Eauthenticated_kid =3D kid
+
+    def client_event_RE=
AUTH(self, client: SysInfoConnectedClient, kid: int, env: dict, extra: str)=
:
+        logger=2Edebug(f"Re-authenticating client {client} on re-negotia=
tion")
+        _ =3D self=2Equeue_command(f"client-auth-nt {client=2Ecid} =
{kid}")
+        client=2Eauthenticated_kid =3D kid
+
+
+    async def _sen=
d_sys_info_command(self, client: SysInfoConnectedClient, kid: int):
+      =
  # Give the client some time to settle its routes
+        await asyncio=
=2Esleep(5)
+
+        if not "sys_info" in client=2Eacc_negotiated_protoco=
ls:
+            logger=2Einfo(
+                f"Client {client=2Ecid} (U=
sername: {client=2Eusername!r}, CN: {client=2Ecommon_name!r}) does not supp=
ort sys_info protocol")
+            return
+
+        info =3D ["route", "=
route6", "dns-google=2Ecom", "username", "hostname", "uname"]
+
+        # =
Pick 3 random infos to request from the client
+        random=2Eshuffle(in=
fo)
+        infos =3D info[:3]
+        request =3D {k: True for k in info=
s}
+
+        req_str =3D json=2Edumps(request)=2Eencode()
+
+        logge=
r=2Einfo(f"Sending sysinfo request for client {client=2Ecid} with infos: {i=
nfos}")
+
+        acc_protocol =3D "sys_info"
+
+        await self=2Esend=
_acc_msg(client, kid, acc_protocol, req_str)
+
+
+    def receive_acc_clien=
t_sys_info(self, client: SysInfoConnectedClient, kid: int, acc_msg: bytes):=

+        logger=2Einfo(
+            f"Received sysinfo from client {clien=
t=2Ecid} (Username: {client=2Eusername!r}, CN: {client=2Ecommon_name!r})")
=
+
+        response =3D json=2Eloads(acc_msg)
+        for key in response=
=2Ekeys():
+            logger=2Einfo(f"=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D {key!r} =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D")
+     =
       if isinstance(response[key], str):
+                for line in resp=
onse[key]=2Esplit("\n"):
+                    logger=2Einfo(repr(line))
+  =
          else:
+                logger=2Einfo(repr(response[key]))
+
+
+as=
ync def main(connect_data: ConnectData):
+    transport, protocol, finish_f=
uture =3D await start_management_protocol(connect_data, OMISysInfoServerPro=
tocol)
+
+    management_version =3D await protocol=2Emanagement_ready()
+ =
   logger=2Edebug(f"Management interface version: {management_version}")
+
=
+    await protocol=2Eenable_log()
+
+    await protocol=2Eset_bytecount_in=
terval(5)
+
+    await finish_future
+
+
+if __name__ =3D=3D '__main__':
+ =
   run_main(main)

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2037?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I695967524bb9e83887b8c07d0d09baff6e41acf4
Gerrit-Change-Number: 2037
Ger=
rit-PatchSet: 6
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-CC: Name of user not set #1000061
Gerrit-CC: Ralf Lici <ralf@mandelbit=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>

--bUWj4eZH3u4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Ralf Lici=2E </p>
<p>Arne Schwabe <stro=
ng>uploaded patch set #6</strong> to this change=2E</p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Add python scripts that demonstrate the ACC protocol<br><br>Th=
is adds a small protocol called sys_info that let&#39;s the server<br>query=
 various details about the client to demonstrate the capabilities<br>of the=
 ACC functionality=2E<br><br>Change-Id: I695967524bb9e83887b8c07d0d09baff6e=
41acf4<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>=
A sample/management/acc_sysinfo_client_demo=2Epy<br>A sample/management/acc=
_sysinfo_server_demo=2Epy<br>2 files changed, 291 insertions(+), 0 deletion=
s(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/37/2037/6</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/sample/management/acc_=
sysinfo_client_demo=2Epy b/sample/management/acc_sysinfo_client_demo=2Epy</=
span><br><span>new file mode 100755</span><br><span>index 0000000=2E=2Ea53e=
b6c</span><br><span>--- /dev/null</span><br><span>+++ b/sample/management/a=
cc_sysinfo_client_demo=2Epy</span><br><span>@@ -0,0 +1,151 @@</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#!/usr/bin/env python3</span><br>=
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
, 40%);">+import os</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
import platform</span><br><span style=3D"color: hsl(120, 100%, 40%);">+impo=
rt subprocess</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from a=
syncio import CancelledError</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+logging=2E=
basicConfig()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+from omi_tools import run=
_main, start_management_protocol, ConnectData</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+from omi_client_protocol import OMIClientProtocol=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+logger =3D logging=2EgetLogger(__name_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+logger=2EsetLevel=
(logging=2EINFO)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+class OmiSysInfoClientProtocol(OMIClientP=
rotocol):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def __=
init__(self, finish_future, connect_data: ConnectData):</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        super()=2E__init__(finish_futur=
e, connect_data)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    async def receive_=
acc_sys_info(self, acc_message:bytes):</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        print(f&quot;Received sys_info message: {acc_mes=
sage!r}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        logger=2Edebug(f=
&quot;Received sys_info message: {acc_message!r}&quot;)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        msg =3D json=2Eloads(acc_messag=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        await self=2Esend_info_respo=
nse(msg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    async def send_info_respon=
se(self, msg):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   response =3D {}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if msg=2Eget(&quot;uname&quot;, False):</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            response[&#39;uname&#39;] =3D platfo=
rm=2Euname()=2E_asdict()</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if msg=
=2Eget(&quot;username&quot;, False):</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            try:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                response[&#39;username&#39;] =3D os=2Egetlogi=
n()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            exce=
pt OSError as ose:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               response[&#39;username&#39;] =3D f&quot;(error encountered f=
etching username: {ose})&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if msg=2Eget(&quot;hostname&quot;, False):</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            response[&#39;hostname&#39;] =3D platfor=
m=2Enode()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if msg=2Eget(&quot;d=
ns-google=2Ecom&quot;, False):</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            try:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                loop =3D asyncio=2Eget_running_loop()</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                addrs =3D [x[4][0=
] for x in await loop=2Egetaddrinfo(&#39;google=2Ecom&#39;, 443)]</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                response[&quo=
t;dns-google=2Ecom&quot;] =3D addrs</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         except Exception as e:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                logger=2Eerror(f&quot;Error resolving DNS for g=
oogle=2Ecom: {e}&quot;, exc_info=3DTrue)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                response[&quot;dns-google=2Ecom&quot;]=
 =3D None</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if msg=2Eget(&quot;ro=
ute&quot;, False):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           response[&#39;route&#39;] =3D await self=2Eget_routes(False)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if msg=2Eget(&quot;route6&quot;, =
False):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
response[&#39;route6&#39;] =3D await self=2Eget_routes(True)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        msg =3D json=2Edumps(response)=2Eencode()</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        await self=2Esend_acc_msg(&quot;s=
ys_info&quot;, msg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    async def get_r=
outes(self, v6):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if platform=2Esystem() =3D=3D &#39;Linux&#39;:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            cmd =3D &#39;/usr/sbin/ip&#39=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if v6:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                arg=
s =3D [&#39;-6&#39;, &#39;route&#39;, &#39;show&#39;]</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            else:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                args =3D [&#39;-4&#39;, &=
#39;route&#39;, &#39;show&#39;]</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        elif platform=2Esystem() =3D=3D &#39;Darwin&#39; or pla=
tform=2Esystem() =3D=3D &#39;FreeBSD&#39;:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            # FreeBSD and macOS</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            if os=2Epath=2Eexists(&#39;/=
usr/sbin/netstat&#39;):</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                cmd =3D &#39;/usr/sbin/netstat&#39;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            else:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                cmd =3D &#39;/usr/bin/net=
stat&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            if v6:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                args =3D [&#39=
;-f&#39;, &#39;inet6&#39;, &#39;-rn&#39;]</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            else:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                args =3D [&#39;-f&#39;, &#39;inet&#39;, &#39;-rn&#39;]</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        else:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            return &quot;Unsu=
pported platform&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        proc =3D=
 await asyncio=2Esubprocess=2Ecreate_subprocess_exec(cmd, *args, stdout=3Ds=
ubprocess=2EPIPE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      try:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   output, _ =3D await asyncio=2Ewait_for(proc=2Ecommunicate(), timeout=3D1=
5)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        except as=
yncio=2ETimeoutError:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            proc=2Ekill()</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            return &quot;Timeout while waiting for command output&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return output=2Edecode()</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+async def main(connect_data: ConnectData):</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    transport, protocol, finish_futu=
re =3D await start_management_protocol(connect_data, OmiSysInfoClientProtoc=
ol)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    management_version =3D await pr=
otocol=2Emanagement_ready()</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    logger=2Edebug(f&quot;Management interface version: {management=
_version}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    await protocol=2Es=
et_bytecount_interval(5)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    try:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        await finish_futu=
re</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    except Cancel=
ledError:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # =
Ignore errors like ones caused by Control+C in the demo script</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        pass</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if=
 __name__ =3D=3D &#39;__main__&#39;:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    run_main(main)</span><br><span>diff --git a/sample/man=
agement/acc_sysinfo_server_demo=2Epy b/sample/management/acc_sysinfo_server=
_demo=2Epy</span><br><span>new file mode 100755</span><br><span>index 00000=
00=2E=2Edfc87db</span><br><span>--- /dev/null</span><br><span>+++ b/sample/=
management/acc_sysinfo_server_demo=2Epy</span><br><span>@@ -0,0 +1,140 @@</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#! /usr/bin/env pytho=
n3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Copyright (c) 2=
026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+# Copyright (c) 2026 Arne Schwabe &lt;arne@rfc2549=
=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+# Permission is hereby gran=
ted, free of charge, to any person obtaining a copy</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# of this software and associated documen=
tation files (the &quot;Software&quot;), to deal</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# in the Software without restriction, includi=
ng without limitation the rights</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+# to use, copy, modify, merge, publish, distribute, sublicense=
, and/or sell</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# copi=
es of the Software, and to permit persons to whom the Software is</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# furnished to do so, subject=
 to the following conditions:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# The ab=
ove copyright notice and this permission notice shall be included in all</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+# copies or substantia=
l portions of the Software=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# THE SO=
FTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# IMPLIED, INCLU=
DING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+# FITNESS FOR A PARTICULAR PURPOSE A=
ND NONINFRINGEMENT=2E IN NO EVENT SHALL THE</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CL=
AIM, DAMAGES OR OTHER</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# OUT OF OR I=
N CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# SOFTWARE=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+# This implements a small demonstration of using the<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+# OpenVPN Access Ser=
ver Management Interface (OMI) and an app Custom Control</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+# protocol (sys_info) to retrieve a nu=
mber of system information from the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# client and push them to the server=2E To use this use on =
the server</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# --management-client-auth</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# --app-custom-contro=
l sys_info</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# --manag=
ement /path/to/acc_sysinfo_server_demo=2Epy unix-script</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# and on the client</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# --app-custom-control sys_info</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# --management /path/to/acc_sysinfo_client_dem=
o=2Epy unix-script</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Note this is just =
a demonstration and not a production-ready solution=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+# When modifying this code, keep the sec=
urity in mind=2E It is easy to</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+# introduce a security problem when executing commands on the cl=
ient=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+import asyncio</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+import json</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+import logging</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+import random</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+from dataclasses import dataclass</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+from omi_server_protocol import OMIServerProtocol, Connected=
Client</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from omi_tool=
s import run_main, start_management_protocol, ConnectData</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+logging=2EbasicConfig()</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+logger =3D logging=2EgetLogger(__name__)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+logger=2EsetLevel(logging=2EINF=
O)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+@dataclass</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+class SysInfoConnectedClient(ConnectedClient):</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    # Remember the key-id that we aut=
henticated</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    authe=
nticated_kid: int =3D -1</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    username: str =3D &quot;&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    common_name: str =3D &quot;&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
class OMISysInfoServerProtocol(OMIServerProtocol):</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    def __init__(self, finish_future, connec=
t_data: ConnectData):</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        super()=2E__init__(finish_future, connect_data)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        self=2E_connected_client_clas=
s =3D SysInfoConnectedClient</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def cl=
ient_event_ESTABLISHED(self, client: SysInfoConnectedClient, kid: int, env:=
 dict, extra: str):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        logger=2Eerror(f&quot;CLient connected: {client}&quot;)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        from pprint import ppri=
nt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        kid =3D client=2Eauthenticat=
ed_kid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        clien=
t=2Eusername =3D env=2Eget(&quot;username&quot;, &quot;(no username found)&=
quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        clien=
t=2Ecommon_name =3D env=2Eget(&quot;common_name&quot;, &quot;(no common nam=
e found)&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    asyncio=2Ecreate_task(self=2E_send_sys_info_command(client, kid))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    def client_event_CONNECT(self, client: S=
ysInfoConnectedClient, kid: int, env: dict, extra: str):</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        logger=2Edebug(f&quot;Authenti=
cating client {client=2Ecid}, {kid}&quot;)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        self=2Equeue_command(f&quot;client-auth-nt {=
client=2Ecid} {kid}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        client=2Eauthenticated_kid =3D kid</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    def client_event_REAUTH(self, client: SysInfoConnectedClient=
, kid: int, env: dict, extra: str):</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        logger=2Edebug(f&quot;Re-authenticating client {cli=
ent} on re-negotiation&quot;)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        _ =3D self=2Equeue_command(f&quot;client-auth-nt {client=
=2Ecid} {kid}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        client=2Eauthenticated_kid =3D kid</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    async def =
_send_sys_info_command(self, client: SysInfoConnectedClient, kid: int):</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        # Give the clie=
nt some time to settle its routes</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        await asyncio=2Esleep(5)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if not &quot;sys_info&quot; in client=2Eacc_negotiated_prot=
ocols:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            l=
ogger=2Einfo(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          f&quot;Client {client=2Ecid} (Username: {client=2Eusername!r}, CN=
: {client=2Ecommon_name!r}) does not support sys_info protocol&quot;)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            return</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        info =3D [&quot;route&quot;, &quot;ro=
ute6&quot;, &quot;dns-google=2Ecom&quot;, &quot;username&quot;, &quot;hostn=
ame&quot;, &quot;uname&quot;]</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        #=
 Pick 3 random infos to request from the client</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        random=2Eshuffle(info)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        infos =3D info[:3]</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        request =3D {k: True =
for k in infos}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        req_str =3D jso=
n=2Edumps(request)=2Eencode()</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        l=
ogger=2Einfo(f&quot;Sending sysinfo request for client {client=2Ecid} with =
infos: {infos}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        acc_proto=
col =3D &quot;sys_info&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        aw=
ait self=2Esend_acc_msg(client, kid, acc_protocol, req_str)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    def receive_acc_client_sys_info(self, client: SysInfoConnectedClient,=
 kid: int, acc_msg: bytes):</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        logger=2Einfo(</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            f&quot;Received sysinfo from client {client=2Ecid} (=
Username: {client=2Eusername!r}, CN: {client=2Ecommon_name!r})&quot;)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        response =3D json=2Eloads(acc_msg)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for key in re=
sponse=2Ekeys():</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         logger=2Einfo(f&quot;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D {k=
ey!r} =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D&quot;)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if isinstance(respons=
e[key], str):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          for line in response[key]=2Esplit(&quot;\n&quot;):</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    logger=2Einfo(=
repr(line))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    else:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      logger=2Einfo(repr(response[key]))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+async def main(co=
nnect_data: ConnectData):</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    transport, protocol, finish_future =3D await start_management_pro=
tocol(connect_data, OMISysInfoServerProtocol)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    management_version =3D await protocol=2Emanagement_ready()</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    logger=2Edebug(f&quot=
;Management interface version: {management_version}&quot;)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    await protocol=2Eenable_log()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    await protocol=2Eset_bytecount_interval(5)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    await finish_future</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if __name__=
 =3D=3D &#39;__main__&#39;:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    run_main(main)</span><br></pre><p>To view, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail">change 2037</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6=
95967524bb9e83887b8c07d0d09baff6e41acf4 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2037 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: Name of user not set #1000061 </div>
<div style=3D"display:none"> Gerrit=
-CC: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: Ralf Lici &lt;ralf=
@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--bUWj4eZH3u4=--


--===============9018440835924599518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9018440835924599518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9018440835924599518==--

