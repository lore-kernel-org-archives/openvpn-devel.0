Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0617606A31A
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LqB7cz9k;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GP11hnC8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JrmKiCGt;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=CfcLsN+t
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5N9nbolHYzC52CkJJvOp81DeXt1YiKZjU61/DIVSNOQ=; b=LqB7cz9kjL1L6YWAVHk7xo/GPx
	fIKnBVBSR97L4pRqA9U9+7v6Zj/H7EPCTKnNIgzrJcqAuI3Vg0TkdwlvT1P5hVYYtU/nIqX9ViUOd
	gyD1Qbk8g+bKmOsvIqICEdW4GQGBR9qU65jRZxX9ddvcHJ7/lWiLxmgTaGtPzXooHivU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMTYc-000000008Tk-2qnL;
	Thu, 29 Oct 2026 17:04:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMTYb-000000008Te-2n5f
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 17:04:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o0p9sD49N808lc6uYJ6m/ElbYqfYF27TVMEKNsbRrpA=; b=GP11hnC8RVT6PNndyYgFHUkKgm
 vTDbTMeofS9I6UUgpUvY+f0xAbVF27QdfKkwtV4cTm5fQR2X5h33+05FlrrxZLDiOSEPKubQj1PQX
 VbuLt6+ziDCk4Rarb0RyvNWmrfJd00bY+RR0kFyyoZ55SXQtUzHvBU+iDpW07bh7EUw4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o0p9sD49N808lc6uYJ6m/ElbYqfYF27TVMEKNsbRrpA=; b=JrmKiCGtmj35X/0mY2bjvvGHRg
 bUeXnsr6EeImI9OQYjiiq0nPrpqo1PMDmlvjlVABZons6ah0WZcpozn4k7xjp+0UyUH0zYYbHBv/u
 N/A1holtIzbZAZSnQP1LInCycDQQzuT57sGm65+sJ4EWAzmg/nlGQ9xKxgx5+T/iAMXI=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMTYP-000000005u6-3Mom for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 17:04:53 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so20255005e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 10:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793293475; x=1793898275; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=o0p9sD49N808lc6uYJ6m/ElbYqfYF27TVMEKNsbRrpA=;
 b=CfcLsN+tKwPlcZUucWewrNuXzAbRUAwL5L6WgqW8E9wSZSSeUBG4DvHqsD5bFbgB2x
 nb6mBQTSTOIwXo48IKTtJwoF1t5+fln5g8FS+5O71AICf4bYprBrA0+123b4HuGV5w4Y
 8+2uFZRUmhMA4rGcH2p239oi7abwtwDOqUB1Yf700nbdDwwYrI09EZ/S1Ac8TrIFrRRy
 DgNHJox4la3Lpw4IhZ1rVDO9xkIAlODkIR3H3GPVFGpDFf+mA4kIv4OYg/a0d+qFxDWk
 SLAAYJ3NAfW2dI/uIPZvwremfGiKArQBd+a4zFirZcX9SthGPVR0lL7SLkOK1DrRl5ZJ
 ZibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793293475; x=1793898275;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=o0p9sD49N808lc6uYJ6m/ElbYqfYF27TVMEKNsbRrpA=;
 b=sQRRuL+dyUSu7aKqNV0m0qxMdKUCaArXIrBXXLV1knIQaQJmOv265UV6eplt2oeJJW
 ZqZJTEB8yUAHjbsIhi9VPzCglYnpoCv2hqSS5B87uREddgdiEGfH6n0Xp2AAt92sROyX
 SqHdcdw/WQbfWx5QnhUsUB66AAIgpzBI4EggmplOfkKHRdFoSdqE20YJ6bX99yRtlCVy
 UvZ3GIBsSDCsmGa+CLU+6KkRVv6a5S1iJH39bWKEcooD6h7JL29lLrUxcRvAPhtJR5Kp
 kEbPaKLaYZ86YNfVyFKMEU2PxbdT9giwH9g8/uXh8LbebDVzJpDTLAf5L88QtL3W9HpX
 UToQ==
X-Gm-Message-State: AFq9FYLM6258i2gFPwIdT41b+cMet6ZUQ1PB4bi2NdFfFxGZtwf/JOe6
 ob3FtMRxTuwtvNowCMJq7dzs1xAVBlJU2ihQKux2LQh7gdxsmUdsxuLFuKPgb2rEYkOIMQ+Ejdt
 nGcQouxT/CWKW2e7F0cMzixXj875xB13Hr43IYACaEGjU1WvPluOtZ7j4iHPIF/NN4YrE3IghwX
 i2UER55w==
X-Gm-Gg: AYBFou1Pr5W9Ywsc1b1vhyb9mdhg/dn598gS8qWYEphUph0JDoY4j7DYa4PBbjM4f4v
 DScVu/yO8nLuMtoCRV44ChLcvMw9UXahbGnH3Fdh2a4yp07KUUdwhUsoa8NZCNQpdV8c1A3rRjP
 I5XU3952YQp57DodJI58MvyaeBa2h59Z7LQhpdWQ+mejmydBIQPz15DTo+px2vDqZrvPcr+hfP/
 0S4uNLY0zPP9/2GG1jMov/hAODCiMWRyTzypPzh/61LA6ioP5NfWgamp6ivsqdNUsjhkfACbRZw
 uRPXbM1Z5TsfJOslqnEflDi+AKHtzsxNNHCGrMwapPH8ytOZteEBXad3bltysNZROnVjpGZAilR
 jyGinqAonxpTf2PeagFFmRvOjIJxAZjToc1ah+KqszZhiNUtAmoPbG1nMIvSACJxuudcMGYvuGC
 r7Ry4oxL4zE4HTv26wbEjX8rhPbhJ9Fmj7LmV1+09ERAv3xjL8rFoOc43M+UCutdpuw9+iie0Jx
 +09kZQnMAuV6WOjcJTc9iQ7X759VYEqMEv18mryvE5fT1dW82S/4fUzu2V7wsqGeN8WYAj5AOF1
 RYXzErYVAzkw5QJiQ0ApYy5PuFKv6VXqxkq3wK169AHxrySuzr6sHMQx7CoFW3SrJu6vKfwnEFp
 /GE+InewBL3L7SRz0bYd2zIJQSRijHJ5rovCylMEU8xbDuJcL3F/XKeqZD9yGLS30GbbGn1VRx4
 gWvnbo9nX9mzOaH8wKfqjnAC/ud+ac3HGPTfFR
X-Received: by 2002:a05:600c:154a:b0:4a0:1efa:c74a with SMTP id
 5b1f17b1804b1-4a9678c26dfmr137466965e9.20.1793293474732; 
 Thu, 29 Oct 2026 10:04:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a96a8f28a1sm88898565e9.4.2026.10.29.10.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 10:04:34 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 29 Oct 2026 17:04:27 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4
X-Gerrit-Change-Number: 2037
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2037?usp=email>
X-Gerrit-Commit: 7fc07de241c5135581ccd16e638b6e2c101d6211
In-Reply-To: <gerrit.1793043747000.I695967524bb9e83887b8c07d0d09baff6e41acf4@gerrit.openvpn.net>
References: <gerrit.1793043747000.I695967524bb9e83887b8c07d0d09baff6e41acf4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDQzNzQ3MDAwLkk2OTU5Njc1MjRiYjllODM4ODdiOGMwN2QwZDA5YmFmZjZlNDFhY2Y0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ca7b8ef12671df6fd75896d9d9cb53a9bf5a5ccd-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xMTYP-000000005u6-3Mom
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5284564628900530111=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5284564628900530111==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8MqhLGVD5JQ="; charset=UTF-8

--8MqhLGVD5JQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has uploaded a new patch set (#3)=2E ( https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2037?usp=3Demail )


Change subject: Add python scripts=
 that demonstrate the ACC protocol
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

Add python scripts that demonstrate the ACC protocol=


This adds a small protocol called sys_info that let's the server
query va=
rious details about the client to demonstrate the capabilities
of the ACC f=
unctionality=2E

Change-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4
Signe=
d-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
A sample/management/acc_sys=
info_client_demo=2Epy
A sample/management/acc_sysinfo_server_demo=2Epy
2 fi=
les changed, 262 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/37/2037/3

diff --git a/sample/man=
agement/acc_sysinfo_client_demo=2Epy b/sample/management/acc_sysinfo_client=
_demo=2Epy
new file mode 100755
index 0000000=2E=2Eb768e56
--- /dev/null
++=
+ b/sample/management/acc_sysinfo_client_demo=2Epy
@@ -0,0 +1,144 @@
+#!/us=
r/bin/env python3
+# Copyright (c) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+=
# Copyright (c) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+#
+# Permission is =
hereby granted, free of charge, to any person obtaining a copy
+# of this s=
oftware and associated documentation files (the "Software"), to deal
+# in =
the Software without restriction, including without limitation the rights
+=
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell=

+# copies of the Software, and to permit persons to whom the Software is
+=
# furnished to do so, subject to the following conditions:
+#
+# The above =
copyright notice and this permission notice shall be included in all
+# cop=
ies or substantial portions of the Software=2E
+#
+# THE SOFTWARE IS PROVID=
ED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING =
BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PART=
ICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE
+# AUTHORS OR C=
OPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WH=
ETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+# OUT OF =
OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+# S=
OFTWARE=2E
+
+# This implements a small demonstration of using the
+# OpenV=
PN Access Server Management Interface (OMI) and an app Custom Control
+# pr=
otocol (sys_info) to retrieve a number of system information from the
+# cl=
ient and push them to the server=2E To use this use on the server
+
+# --ma=
nagement-client-auth
+# --app-custom-control sys_info
+# --management /path=
/to/acc_sysinfo_server_demo=2Epy unix-script
+
+# and on the client
+# --ap=
p-custom-control sys_info
+# --management /path/to/acc_sysinfo_client_demo=
=2Epy unix-script
+
+# Note this is just a demonstration and not a producti=
on-ready solution=2E
+# When modifying this code, keep the security in mind=
=2E It is easy to
+# introduce a security problem when executing commands o=
n the client=2E
+
+import asyncio
+import json
+import logging
+import os
+=
import platform
+import socket
+import subprocess
+
+logging=2EbasicConfig(=
)
+
+from omi_tools import run_main, start_management_protocol, ConnectData=

+from omi_client_protocol import OMIClientProtocol
+
+logger =3D logging=
=2EgetLogger(__name__)
+logger=2EsetLevel(logging=2EDEBUG)
+
+
+class OmiSy=
sInfoClientProtocol(OMIClientProtocol):
+    def __init__(self, finish_futu=
re, connect_data: ConnectData):
+        super()=2E__init__(finish_future, =
connect_data)
+
+
+    def receive_acc_sys_info(self, accmsg):
+        pri=
nt(f"Received sys_info message: {accmsg!r}")
+
+        logger=2Edebug(f"Re=
ceived sys_info message: {accmsg!r}")
+
+        msg =3D json=2Eloads(accms=
g)
+
+
+        asyncio=2Ecreate_task(self=2Esend_info_response(msg))
+
+  =
  async def send_info_response(self, msg):
+        response =3D {}
+      =
  if msg=2Eget("uname", False):
+            response['uname'] =3D platform=
=2Euname()=2E_asdict()
+
+        if msg=2Eget("username", False):
+       =
     response['username'] =3D os=2Egetlogin()
+
+        if msg=2Eget("host=
name", False):
+            response['hostname'] =3D platform=2Enode()
+
+ =
       if msg=2Eget("dns-google=2Ecom", False):
+            try:
+        =
        addrs =3D [x[4][0] for x in socket=2Egetaddrinfo('google=2Ecom', 44=
3)]
+                response["dns-google=2Ecom"] =3D addrs
+
+            =
except Exception as e:
+                logger=2Eerror(f"Error resolving DN=
S for google=2Ecom: {e}", exc_info=3DTrue)
+                response["dns-g=
oogle=2Ecom"] =3D None
+
+        if msg=2Eget("route", False):
+          =
  response['route'] =3D await self=2Eget_routes(False)
+
+        if msg=2E=
get("route6", False):
+            response['route6'] =3D await self=2Eget_=
routes(True)
+
+        msg =3D json=2Edumps(response)=2Eencode()
+
+      =
  await self=2Esend_acc_msg("sys_info", msg)
+
+    async def get_routes(se=
lf, v6):
+        if platform=2Esystem() =3D=3D 'linux':
+            cmd =
=3D '/usr/sbin/ip'
+            if v6:
+                args =3D ['-6', 'ro=
ute', 'show']
+            else:
+                args =3D ['-4', 'route', =
'show']
+        elif platform=2Esystem() =3D=3D 'Darwin' or platform=2Esys=
tem() =3D=3D 'FreeBSD':
+            # FreeBSD and macOS
+            if os=
=2Epath=2Eexists('/usr/sbin/netstat'):
+                cmd =3D '/usr/sbin/=
netstat'
+            else:
+                cmd =3D '/usr/bin/netstat'
+
+=
            if v6:
+                args =3D [ '-f', 'inet6', '-rn']
+     =
       else:
+
+                args =3D [ '-f', 'inet', '-rn']
+        el=
se:
+            return "Unsupported platform"
+
+        proc =3D await as=
yncio=2Esubprocess=2Ecreate_subprocess_exec(cmd, *args, stdout=3Dsubprocess=
=2EPIPE)
+        output, _ =3D await proc=2Ecommunicate()
+        return =
output=2Edecode()
+
+
+async def main(connect_data: ConnectData):
+    tran=
sport, protocol, finish_future =3D await start_management_protocol(connect_=
data, OmiSysInfoClientProtocol)
+    while True:
+        await asyncio=2Es=
leep(5)
+        print("=2E", end=3D"", flush=3DTrue)
+
+    management_ver=
sion =3D await protocol=2Emanagement_ready()
+    print(f"Management interf=
ace version: {management_version}")
+
+    await protocol=2Eset_bytecount_i=
nterval(5)
+
+    await finish_future
+
+
+if __name__ =3D=3D '__main__':
+=
    run_main(main)
diff --git a/sample/management/acc_sysinfo_server_demo=
=2Epy b/sample/management/acc_sysinfo_server_demo=2Epy
new file mode 100755=

index 0000000=2E=2Eff02521
--- /dev/null
+++ b/sample/management/acc_sysin=
fo_server_demo=2Epy
@@ -0,0 +1,118 @@
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
+
+from omi_server_protocol =
import OMIServerProtocol, ConnectedClient
+from omi_tools import run_main, =
start_management_protocol, ConnectData
+
+logging=2EbasicConfig()
+logger =
=3D logging=2EgetLogger(__name__)
+logger=2EsetLevel(logging=2EINFO)
+
+cla=
ss SysInfoConnectedClient(ConnectedClient):
+    # Remember the key-id that=
 we authenticated
+    authenticated_kid =3D None
+
+class OMISysInfoServer=
Protocol(OMIServerProtocol):
+    def __init__(self, finish_future, connect=
_data: ConnectData =3D None):
+        super()=2E__init__(finish_future, co=
nnect_data)
+        self=2E_connected_client_class =3D SysInfoConnectedCli=
ent
+
+    def client_event_ESTABLISHED(self, client, kid, env, extra):
+  =
      print(f"CLient connected: {client}")
+
+        kid =3D client=2Eauth=
enticated_kid
+        asyncio=2Ecreate_task(self=2E_send_sys_info_command(=
client, kid))
+
+    def client_event_CONNECT(self, client, kid, env, extra=
):
+        print(f"Authenticating client {client=2Ecid}, {kid}")
+        =
self=2Equeue_command(f"client-auth-nt {client=2Ecid} {kid}")
+        clien=
t=2Eauthenticated_kid =3D kid
+
+    async def _send_sys_info_command(self,=
 client, kid):
+        # Give the client some time to settle its routes
+ =
       await asyncio=2Esleep(5)
+
+        info =3D ["route", "route6", "dn=
s-google=2Ecom", "username", "hostname", "uname"]
+
+        # Pick 3 rando=
m infos to request from the client
+        random=2Eshuffle(info)
+       =
 infos =3D info[:3]
+        request =3D {k: True for k in infos}
+
+      =
  req_str =3D json=2Edumps(request)=2Eencode()
+
+        logger=2Einfo(f"S=
ending sysinfo request for client {client=2Ecid} with infos: {infos}")
+
+ =
       acc_protocol =3D "sys_info"
+
+        await self=2Esend_acc_msg(cli=
ent, kid, acc_protocol, req_str)
+
+    def receive_acc_client_sys_info(sel=
f, client, kid, acc_msg):
+        logger=2Einfo(f"Received sysinfo from cl=
ient {client=2Ecid}")
+        
+        response =3D json=2Eloads(acc_msg)=

+        for key in response=2Ekeys():
+            logger=2Einfo (f"=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D {key!r} =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D")
+            if type(response[key]) =3D=3D str:
+  =
              for line in response[key]=2Esplit("\n"):
+                   =
 logger=2Einfo(repr(line))
+            else:
+                logger=2Einf=
o(repr(response[key]))
+
+
+async def main(connect_data: ConnectData):
+   =
 transport, protocol, finish_future =3D await start_management_protocol(con=
nect_data, OMISysInfoServerProtocol)
+
+    management_version =3D await pr=
otocol=2Emanagement_ready()
+    print(f"Management interface version: {man=
agement_version}")
+
+    await protocol=2Eenable_log()
+
+    await protoc=
ol=2Eset_bytecount_interval(5)
+
+    await finish_future
+
+
+if __name__ =
=3D=3D '__main__':
+   run_main(main)

-- 
To view, visit https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2037?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=


Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4
Gerrit-Cha=
nge-Number: 2037
Gerrit-PatchSet: 3
Gerrit-Owner: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>

--8MqhLGVD5JQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe <str=
ong>uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail">View Change</a></p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Add python scripts that demonstrate the ACC protocol<br><br>T=
his adds a small protocol called sys_info that let&#39;s the server<br>quer=
y various details about the client to demonstrate the capabilities<br>of th=
e ACC functionality=2E<br><br>Change-Id: I695967524bb9e83887b8c07d0d09baff6=
e41acf4<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br=
>A sample/management/acc_sysinfo_client_demo=2Epy<br>A sample/management/ac=
c_sysinfo_server_demo=2Epy<br>2 files changed, 262 insertions(+), 0 deletio=
ns(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/37/2037/3</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/sample/management/acc=
_sysinfo_client_demo=2Epy b/sample/management/acc_sysinfo_client_demo=2Epy<=
/span><br><span>new file mode 100755</span><br><span>index 0000000=2E=2Eb76=
8e56</span><br><span>--- /dev/null</span><br><span>+++ b/sample/management/=
acc_sysinfo_client_demo=2Epy</span><br><span>@@ -0,0 +1,144 @@</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#!/usr/bin/env python3</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# Copyright (c) 2026 OpenVPN =
Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# Copyright (c) 2026 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+# Permission is hereby granted, free of =
charge, to any person obtaining a copy</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+# of this software and associated documentation files (t=
he &quot;Software&quot;), to deal</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+# in the Software without restriction, including without limi=
tation the rights</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# copies of the Softw=
are, and to permit persons to whom the Software is</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+# furnished to do so, subject to the followi=
ng conditions:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+# The above copyright n=
otice and this permission notice shall be included in all</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+# copies or substantial portions of t=
he Software=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+# THE SOFTWARE IS PROVI=
DED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# IMPLIED, INCLUDING BUT NOT LI=
MITED TO THE WARRANTIES OF MERCHANTABILITY,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEM=
ENT=2E IN NO EVENT SHALL THE</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR=
 OTHER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# LIABILITY, =
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# OUT OF OR IN CONNECTION WI=
TH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# SOFTWARE=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+# This implements a small demonstration of using the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+# OpenVPN Access Server Managemen=
t Interface (OMI) and an app Custom Control</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+# protocol (sys_info) to retrieve a number of syste=
m information from the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+# client and push them to the server=2E To use this use on the server</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# --management-client-auth</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# --app-custom-control sys_info</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+# --management /path/t=
o/acc_sysinfo_server_demo=2Epy unix-script</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# and on the client</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# --app-custom-control sys_info</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# --management /path/to/acc_sysinfo_client_demo=2Epy unix-s=
cript</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+# Note this is just a demonstrati=
on and not a production-ready solution=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+# When modifying this code, keep the security in mind=
=2E It is easy to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
introduce a security problem when executing commands on the client=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+import asyncio</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+import json</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+import logging</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+import os</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+import platform</span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=
mport socket</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import =
subprocess</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+logging=2EbasicConfig()</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+from omi_tools import run_main, start_man=
agement_protocol, ConnectData</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+from omi_client_protocol import OMIClientProtocol</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+logger =3D logging=2EgetLogger(__name__)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+logger=2EsetLevel(logging=2EDEBUG=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+class OmiSysInfoClientProtocol(OMIClientProtocol):</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    def __init__(self, fi=
nish_future, connect_data: ConnectData):</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        super()=2E__init__(finish_future, connect_data=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    def receive_acc_sys_info(self, accmsg):</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        print(f&quot;Received sy=
s_info message: {accmsg!r}&quot;)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   logger=2Edebug(f&quot;Received sys_info message: {accmsg!r}&quot;)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        msg =3D json=2Eloads(accmsg)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        asyncio=2Ecreate_task(self=2Esend_info_response(msg))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    async def send_info_response(self, ms=
g):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        response=
 =3D {}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if m=
sg=2Eget(&quot;uname&quot;, False):</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            response[&#39;uname&#39;] =3D platform=2Euname(=
)=2E_asdict()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if msg=2Eget(&quo=
t;username&quot;, False):</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            response[&#39;username&#39;] =3D os=2Egetlogin()</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if msg=2Eget(&quot;hostname&quot;, Fals=
e):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            resp=
onse[&#39;hostname&#39;] =3D platform=2Enode()</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if msg=2Eget(&quot;dns-google=2Ecom&quot;, False):</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            try:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                addrs =3D [x[4]=
[0] for x in socket=2Egetaddrinfo(&#39;google=2Ecom&#39;, 443)]</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                response[&quot;=
dns-google=2Ecom&quot;] =3D addrs</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       except Exception as e:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                logger=2Eerror(f&quot;Error resolving DNS for goo=
gle=2Ecom: {e}&quot;, exc_info=3DTrue)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                response[&quot;dns-google=2Ecom&quot;] =
=3D None</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if msg=2Eget(&quot;rou=
te&quot;, False):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          response[&#39;route&#39;] =3D await self=2Eget_routes(False)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
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
     if platform=2Esystem() =3D=3D &#39;linux&#39;:</span><br><span style=
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
<span style=3D"color: hsl(120, 100%, 40%);">+                args =3D [ &#3=
9;-f&#39;, &#39;inet6&#39;, &#39;-rn&#39;]</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            else:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                args =3D [ &#39;-f&#39;, &#39;inet&#39;, &#39;-rn&#39;]</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            return &quot;Un=
supported platform&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        proc =
=3D await asyncio=2Esubprocess=2Ecreate_subprocess_exec(cmd, *args, stdout=
=3Dsubprocess=2EPIPE)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        output, _ =3D await proc=2Ecommunicate()</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return output=2Edecode()</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+async def main(connect_data: ConnectData):</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    transport, protocol, finish_future =3D awa=
it start_management_protocol(connect_data, OmiSysInfoClientProtocol)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    while True:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        await asyncio=2Esleep(=
5)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        print(&qu=
ot;=2E&quot;, end=3D&quot;&quot;, flush=3DTrue)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    management_version =3D await protocol=2Emanagement_ready()</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    print(f&quot;Manage=
ment interface version: {management_version}&quot;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    await protocol=2Eset_bytecount_interval(5)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    await finish_future</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if __name__=
 =3D=3D &#39;__main__&#39;:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    run_main(main)</span><br><span>diff --git a/sample/management/a=
cc_sysinfo_server_demo=2Epy b/sample/management/acc_sysinfo_server_demo=2Ep=
y</span><br><span>new file mode 100755</span><br><span>index 0000000=2E=2Ef=
f02521</span><br><span>--- /dev/null</span><br><span>+++ b/sample/managemen=
t/acc_sysinfo_server_demo=2Epy</span><br><span>@@ -0,0 +1,118 @@</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#! /usr/bin/env python3</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+# Copyright (c) 2026 OpenV=
PN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+# Copyright (c) 2026 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+# Permission is hereby granted, free =
of charge, to any person obtaining a copy</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+# of this software and associated documentation files=
 (the &quot;Software&quot;), to deal</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# in the Software without restriction, including without l=
imitation the rights</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# to use, copy, modify, merge, publish, distribute, sublicense, and/or sel=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# copies of the So=
ftware, and to permit persons to whom the Software is</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# furnished to do so, subject to the foll=
owing conditions:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+# The above copyrigh=
t notice and this permission notice shall be included in all</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# copies or substantial portions o=
f the Software=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+# THE SOFTWARE IS PR=
OVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# IMPLIED, INCLUDING BUT NOT=
 LIMITED TO THE WARRANTIES OF MERCHANTABILITY,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRIN=
GEMENT=2E IN NO EVENT SHALL THE</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR OTHER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# LIABILIT=
Y, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+# OUT OF OR IN CONNECTION=
 WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+# SOFTWARE=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+# This implements a small demonstration of using the</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+# OpenVPN Access Server Manageme=
nt Interface (OMI) and an app Custom Control</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+# protocol (sys_info) to retrieve a number of syst=
em information from the</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# client and push them to the server=2E To use this use on the server</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+# --management-client-auth</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+# --app-custom-control sys_info</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# --management /path/=
to/acc_sysinfo_server_demo=2Epy unix-script</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+# and on the client</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+# --app-custom-control sys_info</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# --management /path/to/acc_sysinfo_client_demo=2Epy unix-=
script</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+# Note this is just a demonstrat=
ion and not a production-ready solution=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+# When modifying this code, keep the security in min=
d=2E It is easy to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
 introduce a security problem when executing commands on the client=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+import asyncio</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+import json</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+import logging</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+import random</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from omi_=
server_protocol import OMIServerProtocol, ConnectedClient</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+from omi_tools import run_main, start=
_management_protocol, ConnectData</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+loggi=
ng=2EbasicConfig()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+l=
ogger =3D logging=2EgetLogger(__name__)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+logger=2EsetLevel(logging=2EINFO)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+class SysInfoConnectedClient(ConnectedClient):</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    # Remember the key-id that we=
 authenticated</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
uthenticated_kid =3D None</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+class OMISysI=
nfoServerProtocol(OMIServerProtocol):</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    def __init__(self, finish_future, connect_data: Conne=
ctData =3D None):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      super()=2E__init__(finish_future, connect_data)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        self=2E_connected_client_class =
=3D SysInfoConnectedClient</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def clie=
nt_event_ESTABLISHED(self, client, kid, env, extra):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        print(f&quot;CLient connected: {c=
lient}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        kid =3D client=2E=
authenticated_kid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      asyncio=2Ecreate_task(self=2E_send_sys_info_command(client, kid))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    def client_event_CONNECT(self, client=
, kid, env, extra):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        print(f&quot;Authenticating client {client=2Ecid}, {kid}&quot;)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2Equeue_co=
mmand(f&quot;client-auth-nt {client=2Ecid} {kid}&quot;)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        client=2Eauthenticated_kid =3D =
kid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    async def _send_sys_info_comman=
d(self, client, kid):</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        # Give the client some time to settle its routes</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        await asyncio=2Esleep(5)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        info =3D [&quot;route&quot;, &quo=
t;route6&quot;, &quot;dns-google=2Ecom&quot;, &quot;username&quot;, &quot;h=
ostname&quot;, &quot;uname&quot;]</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   # Pick 3 random infos to request from the client</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        random=2Eshuffle(info)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        infos =3D info[:3]</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        request =3D {k:=
 True for k in infos}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        req_str =
=3D json=2Edumps(request)=2Eencode()</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      logger=2Einfo(f&quot;Sending sysinfo request for client {client=2Ecid=
} with infos: {infos}&quot;)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ac=
c_protocol =3D &quot;sys_info&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     await self=2Esend_acc_msg(client, kid, acc_protocol, req_str)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    def receive_acc_client_sys_info(self, clien=
t, kid, acc_msg):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      logger=2Einfo(f&quot;Received sysinfo from client {client=2Ecid}&quot=
;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        response =3D json=2E=
loads(acc_msg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   for key in response=2Ekeys():</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            logger=2Einfo (f&quot;=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D {key!r} =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D&qu=
ot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if =
type(response[key]) =3D=3D str:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                for line in response[key]=2Esplit(&quot;\n&quot=
;):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
    logger=2Einfo(repr(line))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            else:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                logger=2Einfo(repr(response[key]))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+async def main(connect_data: ConnectData):</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    transport, protocol, finish_future =3D await st=
art_management_protocol(connect_data, OMISysInfoServerProtocol)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    management_version =3D await protocol=2Emanage=
ment_ready()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pri=
nt(f&quot;Management interface version: {management_version}&quot;)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    await protocol=2Eenable_log()</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    await protocol=2Eset_bytecount_interval(5)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    await finish_future</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
if __name__ =3D=3D &#39;__main__&#39;:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+   run_main(main)</span><br></pre><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail">change =
2037</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2037 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>

</body></html>
--8MqhLGVD5JQ=--


--===============5284564628900530111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5284564628900530111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5284564628900530111==--

