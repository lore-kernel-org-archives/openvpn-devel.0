Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205A4606A324
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OLuqw3Km;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=URT6WORq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=L7BvRFqS;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=OD+zQfis
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zHgqpTlUH9laQwzuQqqQ+iFEhlPUQ34K9vnn+zz0mZM=; b=OLuqw3KmVQt+IxlhKd97vInFo6
	WE3Z/2YbjerjSlbKvjzMSMauyjG+rI9O+BzCH6UoyQu+jgn7dg67LBpVOEL3EUerBY5tWHvRgCQG+
	vyZrm7WAAKBLbd57PszIyoRLq9sCqHVNhkBnxnirRC87fAh9wfGkYwN4Cyj5fS+PL83A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOJ9S-000000001XS-3RHH;
	Tue, 03 Nov 2026 18:22:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOJ9R-000000001XL-3qRe
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 18:22:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kyfKj7jmnKjypIb00lcbNtqC6B+f5KU4YTfe/O2NUHk=; b=URT6WORq6qen22oZcCVdhm8Qs7
 Ncefdf5NW5wmnCMQYF+YRzhTjsIV3eOOJubhLxxnYCP5bRTVXkIEoPUeG3riXJkJLSix4WIAGv+uX
 hLmK0HCaLJdYnBpPqdl4quag8ENcAeZOmVhn72c9zspoSdMbEoWSvds52cOJq6MrIe0A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kyfKj7jmnKjypIb00lcbNtqC6B+f5KU4YTfe/O2NUHk=; b=L7BvRFqSIBmu500amcbIofTGdM
 paPBxN1txOF2NbRhaaPvcX9itgz0QQfQ27iLC42ArsL4QrXZJFDDTx8WCEsSWDE95qzNQufPgQ4fv
 Yg24S6/H/C/ngN6gmAoYqmsXvvm1alzK2my0xb4O20TmLNEfNcdrH5G055Ydt7avXte0=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOJ9N-000000004je-36uC for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 18:22:29 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4afe2d546f9so30154515e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 10:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793730139; x=1794334939; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kyfKj7jmnKjypIb00lcbNtqC6B+f5KU4YTfe/O2NUHk=;
 b=OD+zQfisEDSLfA4sEy1C0JQqkZqahSTjv5G5InrUzWul7VwK41zkLSf3mTdCsFdwtp
 j+Mm+QorGhY2E+5hplx3c/5nvuJGoN4plxaxT4/ur+9lm/GdOD31ok9gW+5NVl2tr1Sy
 8KpXEdPcW2U9WLSp+VaMfqypS/oz/0/jlMF1j67BWVznmRfQdVJJgFPrVk3CjT9cw65I
 45qADqsTPtCisI21rrWCdlaotAs7wuN5gIqrnomkcTrtKJN5rWyBTbnVX70+M9tThvEs
 l48ju0ZwhphFxKy2V/0Tc3354hW3yhneg7ik501SiyPOOhwUFqOJ2cAGC9ohjX5Ver8E
 SYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793730139; x=1794334939;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kyfKj7jmnKjypIb00lcbNtqC6B+f5KU4YTfe/O2NUHk=;
 b=cCwV5JoEwuaMh/QVOPH5UsOLi3XPbCNkiqUdDodtHQxC9NSrqX6AZaKE3gXd5OBD6H
 VnepYSKoT0cXJ6KF1qHJ5QPjS+WPBEETA7IRs+WCsXCbskSP6hIoxcq++0Mq9yOrQjgS
 brtEmYzzk2Sbf/l5pyTIV6TJHIAcyFLiHsZ+7sNmx4JN4dQh9ghTBp6yZMhOnqJrUep8
 R2JhoSRpm3IcDmnmKP2NzBxSug108EoeuEpAemuYTgEWu+c1N9eAQlpcUKmLx0J3UQOR
 kkxSvnpMy6ZYuly4gWMAklJEgERZcuBzsOsLVHpYoDWDnLtObnnIEUhdhhp7rIbbjPp8
 I3Wg==
X-Gm-Message-State: APuU4Z9E5goJIqO3Z+mmjmEVHl8pG+9t9vQ7wM5KWk1YOYws+yarTmhe
 8+qT3RA1JlUlQbPFy7Bb46SRCldRxHyfLPmPO96d3XFwxq6PZCPG1cFA8LFTIFSdibePSYduOYe
 CS8UD42VOrKBrbBnaKIrHNd01v6QZc+uRa4lB0NQSKJJhvzNOjN64WljskRlzxY/cZdreUZ/CoG
 usV7aq7w==
X-Gm-Gg: AYBFou3qrLa/gU4eWNeI8bUv1bTPJ3wAN2X8pTppdvgpKPYO2rLfYFkvKJiCfJjHNrP
 EaNS4hPkL69kkTQ/OhHW/XbtG86JLu+2qr4Op4Z7kTpvSl8aYRBBv0QZP24NyHisVX8a597x1i+
 NuG74dZZvFzSKlePPkEkvmEDtZUfVo8SZ8U6HH6sY92FZgcKT/75CcYimRu+Dmfex/rWHZSaopd
 0/zCXysYiOqpMazhYX0NenlvLW4hyxUbHFKCUM7bXBEbClrntATvRs8vFnfUn3VcMIw1h5vMMDZ
 zuO/2FLnKEbPXGWEjhCJQXO9q7P185n+xvKJJxCB6N2/4dDPvdHacnHL8U0v57wGJ4m7RY9yk95
 ueHZMd94XMvwnfATAyAK+Ydr1ROYgI+yDWCp2A85U4n4/lawbnRyTjtuUezWf8La5rLFYOgKtKy
 WFGyDh0lkEe47oghsFg/OS8shHsrL/T9psVaJnhIYSpAPq75iiSzV3duUsVrDQK7c65Nzwo1R0G
 FF2WE7wyz3hss6rXpLXXtBf94hknqVkxvoj2Z2sAFO3gaRt7HvLoysl1DzecHQ+p59LXZzqoGTZ
 uU8s6MOVEJemp8hATkuHeioYwQ1wifkxGNawemyqpTI5r4ImD+UmyUf6IbvZE6leFhUzeQUKE6F
 dyQ035yUNgQx246ewpHbwzjPs+EUiPMZIuuAESMXk8mWuFYHusSQdFuPjsfuGPUH+8cFguf5RiF
 nk2YDauqlHWQ7AlQ==
X-Received: by 2002:a05:600c:354a:b0:4a3:5aee:2c25 with SMTP id
 5b1f17b1804b1-4ac181e759dmr341930885e9.31.1793730138885; 
 Tue, 03 Nov 2026 10:22:18 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2aae24b32sm73357095e9.12.2026.11.03.10.22.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 10:22:18 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 18:22:15 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4
X-Gerrit-Change-Number: 2037
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2037?usp=email>
X-Gerrit-Commit: 83d7171af6b153b64cc428cd58c782effb95014c
In-Reply-To: <gerrit.1793043747000.I695967524bb9e83887b8c07d0d09baff6e41acf4@gerrit.openvpn.net>
References: <gerrit.1793043747000.I695967524bb9e83887b8c07d0d09baff6e41acf4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDQzNzQ3MDAwLkk2OTU5Njc1MjRiYjllODM4ODdiOGMwN2QwZDA5YmFmZjZlNDFhY2Y0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2179069962781a7886a87c52abde020dc77d2114-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOJ9N-000000004je-36uC
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
Content-Type: multipart/mixed; boundary="===============6694108178396172956=="
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6694108178396172956==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kK0K4GQXmQE="; charset=UTF-8

--kK0K4GQXmQE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Name of user not set #1=
000061=2E

Arne Schwabe has uploaded a new patch set (#5)=2E ( https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail )


Change subject: Add pyt=
hon scripts that demonstrate the ACC protocol
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add python scripts that demonstrate the =
ACC protocol

This adds a small protocol called sys_info that let's the ser=
ver
query various details about the client to demonstrate the capabilities
=
of the ACC functionality=2E

Change-Id: I695967524bb9e83887b8c07d0d09baff6e=
41acf4
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
A sample/manage=
ment/acc_sysinfo_client_demo=2Epy
A sample/management/acc_sysinfo_server_de=
mo=2Epy
2 files changed, 289 insertions(+), 0 deletions(-)


  git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/37/2037/5

diff --git =
a/sample/management/acc_sysinfo_client_demo=2Epy b/sample/management/acc_sy=
sinfo_client_demo=2Epy
new file mode 100755
index 0000000=2E=2Ecf4f6fa
--- =
/dev/null
+++ b/sample/management/acc_sysinfo_client_demo=2Epy
@@ -0,0 +1,1=
51 @@
+#!/usr/bin/env python3
+# Copyright (c) 2026 OpenVPN Inc <sales@open=
vpn=2Enet>
+# Copyright (c) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+#
+# Pe=
rmission is hereby granted, free of charge, to any person obtaining a copy
=
+# of this software and associated documentation files (the "Software"), to=
 deal
+# in the Software without restriction, including without limitation =
the rights
+# to use, copy, modify, merge, publish, distribute, sublicense,=
 and/or sell
+# copies of the Software, and to permit persons to whom the S=
oftware is
+# furnished to do so, subject to the following conditions:
+#
+=
# The above copyright notice and this permission notice shall be included i=
n all
+# copies or substantial portions of the Software=2E
+#
+# THE SOFTWA=
RE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED=
, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNES=
S FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE
+# =
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# L=
IABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM=
,
+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS=
 IN THE
+# SOFTWARE=2E
+
+# This implements a small demonstration of using =
the
+# OpenVPN Access Server Management Interface (OMI) and an app Custom C=
ontrol
+# protocol (sys_info) to retrieve a number of system information fr=
om the
+# client and push them to the server=2E To use this use on the serv=
er
+
+# --management-client-auth
+# --app-custom-control sys_info
+# --mana=
gement /path/to/acc_sysinfo_server_demo=2Epy unix-script
+
+# and on the cl=
ient
+# --app-custom-control sys_info
+# --management /path/to/acc_sysinfo_=
client_demo=2Epy unix-script
+
+# Note this is just a demonstration and not=
 a production-ready solution=2E
+# When modifying this code, keep the secur=
ity in mind=2E It is easy to
+# introduce a security problem when executing=
 commands on the client=2E
+
+import asyncio
+import json
+import logging
+=
import os
+import platform
+import subprocess
+from asyncio import Cancelle=
dError
+
+logging=2EbasicConfig()
+
+from omi_tools import run_main, start_=
management_protocol, ConnectData
+from omi_client_protocol import OMIClient=
Protocol
+
+logger =3D logging=2EgetLogger(__name__)
+logger=2EsetLevel(log=
ging=2EINFO)
+
+
+class OmiSysInfoClientProtocol(OMIClientProtocol):
+    d=
ef __init__(self, finish_future, connect_data: ConnectData):
+        super=
()=2E__init__(finish_future, connect_data)
+
+    def receive_acc_sys_info(=
self, acc_message):
+        print(f"Received sys_info message: {acc_messag=
e!r}")
+
+        logger=2Edebug(f"Received sys_info message: {acc_message!=
r}")
+        msg =3D json=2Eloads(acc_message)
+
+        asyncio=2Ecreate=
_task(self=2Esend_info_response(msg))
+
+    async def send_info_response(s=
elf, msg):
+        response =3D {}
+        if msg=2Eget("uname", False):
=
+            response['uname'] =3D platform=2Euname()=2E_asdict()
+
+      =
  if msg=2Eget("username", False):
+            try:
+                respo=
nse['username'] =3D os=2Egetlogin()
+            except OSError as ose:
+  =
              response['username'] =3D f"(error encountered fetching userna=
me: {ose})"
+
+        if msg=2Eget("hostname", False):
+            respon=
se['hostname'] =3D platform=2Enode()
+
+        if msg=2Eget("dns-google=2E=
com", False):
+            try:
+                loop =3D asyncio=2Eget_run=
ning_loop()
+                addrs =3D [x[4][0] for x in await loop=2Egetad=
drinfo('google=2Ecom', 443)]
+                response["dns-google=2Ecom"] =
=3D addrs
+
+            except Exception as e:
+                logger=2Ee=
rror(f"Error resolving DNS for google=2Ecom: {e}", exc_info=3DTrue)
+      =
          response["dns-google=2Ecom"] =3D None
+
+        if msg=2Eget("ro=
ute", False):
+            response['route'] =3D await self=2Eget_routes(Fa=
lse)
+
+        if msg=2Eget("route6", False):
+            response['route=
6'] =3D await self=2Eget_routes(True)
+
+        msg =3D json=2Edumps(respo=
nse)=2Eencode()
+
+        await self=2Esend_acc_msg("sys_info", msg)
+
+  =
  async def get_routes(self, v6):
+        if platform=2Esystem() =3D=3D 'L=
inux':
+            cmd =3D '/usr/sbin/ip'
+            if v6:
+           =
     args =3D ['-6', 'route', 'show']
+            else:
+                a=
rgs =3D ['-4', 'route', 'show']
+        elif platform=2Esystem() =3D=3D 'D=
arwin' or platform=2Esystem() =3D=3D 'FreeBSD':
+            # FreeBSD and =
macOS
+            if os=2Epath=2Eexists('/usr/sbin/netstat'):
+           =
     cmd =3D '/usr/sbin/netstat'
+            else:
+                cmd =
=3D '/usr/bin/netstat'
+
+            if v6:
+                args =3D ['-f=
', 'inet6', '-rn']
+            else:
+
+                args =3D ['-f', 'i=
net', '-rn']
+        else:
+            return "Unsupported platform"
+
+ =
       proc =3D await asyncio=2Esubprocess=2Ecreate_subprocess_exec(cmd, *a=
rgs, stdout=3Dsubprocess=2EPIPE)
+        try:
+            output, _ =3D a=
wait asyncio=2Ewait_for(proc=2Ecommunicate(), timeout=3D15)
+        except=
 asyncio=2ETimeoutError:
+            proc=2Ekill()
+            return "Ti=
meout while waiting for command output"
+
+        return output=2Edecode()=

+
+
+async def main(connect_data: ConnectData):
+    transport, protocol, =
finish_future =3D await start_management_protocol(connect_data, OmiSysInfoC=
lientProtocol)
+
+    management_version =3D await protocol=2Emanagement_re=
ady()
+    logger=2Edebug(f"Management interface version: {management_versi=
on}")
+
+    await protocol=2Eset_bytecount_interval(5)
+
+    try:
+      =
  await finish_future
+    except CancelledError:
+        # Ignore errors =
like ones caused by Control+C in the demo script
+        pass
+
+
+if __na=
me__ =3D=3D '__main__':
+    run_main(main)
diff --git a/sample/management/=
acc_sysinfo_server_demo=2Epy b/sample/management/acc_sysinfo_server_demo=2E=
py
new file mode 100755
index 0000000=2E=2E5649588
--- /dev/null
+++ b/samp=
le/management/acc_sysinfo_server_demo=2Epy
@@ -0,0 +1,138 @@
+#! /usr/bin/e=
nv python3
+# Copyright (c) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+# Copyr=
ight (c) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+#
+# Permission is hereby =
granted, free of charge, to any person obtaining a copy
+# of this software=
 and associated documentation files (the "Software"), to deal
+# in the Sof=
tware without restriction, including without limitation the rights
+# to us=
e, copy, modify, merge, publish, distribute, sublicense, and/or sell
+# cop=
ies of the Software, and to permit persons to whom the Software is
+# furni=
shed to do so, subject to the following conditions:
+#
+# The above copyrig=
ht notice and this permission notice shall be included in all
+# copies or =
substantial portions of the Software=2E
+#
+# THE SOFTWARE IS PROVIDED "AS =
IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT=
 LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR =
PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE
+# AUTHORS OR COPYRIGH=
T HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER I=
N AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+# OUT OF OR IN C=
ONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+# SOFTWARE=
=2E
+
+# This implements a small demonstration of using the
+# OpenVPN Acce=
ss Server Management Interface (OMI) and an app Custom Control
+# protocol =
(sys_info) to retrieve a number of system information from the
+# client an=
d push them to the server=2E To use this use on the server
+
+# --managemen=
t-client-auth
+# --app-custom-control sys_info
+# --management /path/to/acc=
_sysinfo_server_demo=2Epy unix-script
+
+# and on the client
+# --app-custo=
m-control sys_info
+# --management /path/to/acc_sysinfo_client_demo=2Epy un=
ix-script
+
+# Note this is just a demonstration and not a production-ready=
 solution=2E
+# When modifying this code, keep the security in mind=2E It i=
s easy to
+# introduce a security problem when executing commands on the cl=
ient=2E
+
+import asyncio
+import json
+import logging
+import random
+
+fr=
om omi_server_protocol import OMIServerProtocol, ConnectedClient
+from omi_=
tools import run_main, start_management_protocol, ConnectData
+
+logging=2E=
basicConfig()
+logger =3D logging=2EgetLogger(__name__)
+logger=2EsetLevel(=
logging=2EINFO)
+
+
+class SysInfoConnectedClient(ConnectedClient):
+    # =
Remember the key-id that we authenticated
+    authenticated_kid: int =3D -=
1
+    username: str =3D ""
+    common_name: str =3D ""
+
+
+class OMISysI=
nfoServerProtocol(OMIServerProtocol):
+    def __init__(self, finish_future=
, connect_data: ConnectData):
+        super()=2E__init__(finish_future, co=
nnect_data)
+        self=2E_connected_client_class =3D SysInfoConnectedCli=
ent
+
+    def client_event_ESTABLISHED(self, client: SysInfoConnectedClien=
t, kid: int, env: dict, extra: str):
+        logger=2Eerror(f"CLient conne=
cted: {client}")
+        from pprint import pprint
+
+        kid =3D clie=
nt=2Eauthenticated_kid
+        client=2Eusername =3D env=2Eget("username",=
 "(no username found)")
+        client=2Ecommon_name =3D env=2Eget("common=
_name", "(no common name found)")
+        asyncio=2Ecreate_task(self=2E_se=
nd_sys_info_command(client, kid))
+
+    def client_event_CONNECT(self, cli=
ent: SysInfoConnectedClient, kid: int, env: dict, extra: str):
+        log=
ger=2Edebug(f"Authenticating client {client=2Ecid}, {kid}")
+        self=
=2Equeue_command(f"client-auth-nt {client=2Ecid} {kid}")
+        client=2E=
authenticated_kid =3D kid
+
+    def client_event_REAUTH(self, client: SysI=
nfoConnectedClient, kid: int, env: dict, extra: str):
+        logger=2Edeb=
ug(f"Re-authenticating client {client} on re-negotiation")
+        _ =3D s=
elf=2Equeue_command(f"client-auth-nt {client=2Ecid} {kid}")
+        client=
=2Eauthenticated_kid =3D kid
+
+
+async def _send_sys_info_command(self, cl=
ient: SysInfoConnectedClient, kid: int):
+    # Give the client some time t=
o settle its routes
+    await asyncio=2Esleep(5)
+
+    if not "sys_info" =
in client=2Eacc_negotiated_protocols:
+        logger=2Einfo(
+            =
f"Client {client=2Ecid} (Username: {client=2Eusername!r}, CN: {client=2Ecom=
mon_name!r}) does not support sys_info protocol")
+        return
+
+    in=
fo =3D ["route", "route6", "dns-google=2Ecom", "username", "hostname", "una=
me"]
+
+    # Pick 3 random infos to request from the client
+    random=2E=
shuffle(info)
+    infos =3D info[:3]
+    request =3D {k: True for k in in=
fos}
+
+    req_str =3D json=2Edumps(request)=2Eencode()
+
+    logger=2Ein=
fo(f"Sending sysinfo request for client {client=2Ecid} with infos: {infos}"=
)
+
+    acc_protocol =3D "sys_info"
+
+    await self=2Esend_acc_msg(clien=
t, kid, acc_protocol, req_str)
+
+
+def receive_acc_client_sys_info(self, c=
lient: SysInfoConnectedClient, kid: int, acc_msg: str):
+    logger=2Einfo(=

+        f"Received sysinfo from client {client=2Ecid} (Username: {client=
=2Eusername!r}, CN: {client=2Ecommon_name!r})")
+
+    response =3D json=2E=
loads(acc_msg)
+    for key in response=2Ekeys():
+        logger=2Einfo(f"=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D {key!r} =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D")
+        if isinstance(response[key], str):
+   =
         for line in response[key]=2Esplit("\n"):
+                logger=
=2Einfo(repr(line))
+        else:
+            logger=2Einfo(repr(response=
[key]))
+
+
+async def main(connect_data: ConnectData):
+    transport, pro=
tocol, finish_future =3D await start_management_protocol(connect_data, OMIS=
ysInfoServerProtocol)
+
+    management_version =3D await protocol=2Emanage=
ment_ready()
+    logger=2Edebug(f"Management interface version: {managemen=
t_version}")
+
+    await protocol=2Eenable_log()
+
+    await protocol=2Es=
et_bytecount_interval(5)
+
+    await finish_future
+
+
+if __name__ =3D=3D=
 '__main__':
+    run_main(main)

-- 
To view, visit https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2037?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ger=
rit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4
Gerrit-Change-N=
umber: 2037
Gerrit-PatchSet: 5
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-CC: Name of user not set #1000061
Gerrit-CC: Ralf Lici <=
ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: Name of user not set #1000061
Gerrit-Attent=
ion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--kK0K4GQXmQE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Name of user not set #1000061=2E </p>
<=
p>Arne Schwabe <strong>uploaded patch set #5</strong> to this change=2E</p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail">=
View Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Add python scripts that demonstrate the AC=
C protocol<br><br>This adds a small protocol called sys_info that let&#39;s=
 the server<br>query various details about the client to demonstrate the ca=
pabilities<br>of the ACC functionality=2E<br><br>Change-Id: I695967524bb9e8=
3887b8c07d0d09baff6e41acf4<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=
=2Eorg&gt;<br>---<br>A sample/management/acc_sysinfo_client_demo=2Epy<br>A =
sample/management/acc_sysinfo_server_demo=2Epy<br>2 files changed, 289 inse=
rtions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/37/2037/5</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
sample/management/acc_sysinfo_client_demo=2Epy b/sample/management/acc_sysi=
nfo_client_demo=2Epy</span><br><span>new file mode 100755</span><br><span>i=
ndex 0000000=2E=2Ecf4f6fa</span><br><span>--- /dev/null</span><br><span>+++=
 b/sample/management/acc_sysinfo_client_demo=2Epy</span><br><span>@@ -0,0 +=
1,151 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#!/usr/bin/=
env python3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Copyri=
ght (c) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# Copyright (c) 2026 Arne Schwabe &lt;arn=
e@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Permission is he=
reby granted, free of charge, to any person obtaining a copy</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# of this software and associated =
documentation files (the &quot;Software&quot;), to deal</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+# in the Software without restriction, =
including without limitation the rights</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# to use, copy, modify, merge, publish, distribute, sub=
license, and/or sell</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# copies of the Software, and to permit persons to whom the Software is</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+# furnished to do so, =
subject to the following conditions:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
 The above copyright notice and this permission notice shall be included in=
 all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# copies or sub=
stantial portions of the Software=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
 THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, =
EXPRESS OR</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# IMPLIED=
, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# FITNESS FOR A PARTICULAR PU=
RPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR=
 ANY CLAIM, DAMAGES OR OTHER</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, =
ARISING FROM,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# OUT =
OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# SOFTWARE=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# This implements a small demonstration of usi=
ng the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# OpenVPN Acc=
ess Server Management Interface (OMI) and an app Custom Control</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# protocol (sys_info) to retrie=
ve a number of system information from the</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+# client and push them to the server=2E To use this =
use on the server</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# --management-client=
-auth</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# --app-custom=
-control sys_info</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
--management /path/to/acc_sysinfo_server_demo=2Epy unix-script</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+# and on the client</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+# --app-custom-control sys_info</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+# --management /path/to/acc_sysinfo_cli=
ent_demo=2Epy unix-script</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Note this i=
s just a demonstration and not a production-ready solution=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+# When modifying this code, keep =
the security in mind=2E It is easy to</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+# introduce a security problem when executing commands on=
 the client=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+import asyncio</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+import json</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+import logging</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+import os</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+import platform</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+import subprocess</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+from asyncio import CancelledError</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+logging=2EbasicConfig()</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
from omi_tools import run_main, start_management_protocol, ConnectData</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+from omi_client_protocol=
 import OMIClientProtocol</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+logger =3D lo=
gging=2EgetLogger(__name__)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+logger=2EsetLevel(logging=2EINFO)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+class OmiSysInfo=
ClientProtocol(OMIClientProtocol):</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    def __init__(self, finish_future, connect_data: ConnectD=
ata):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        super(=
)=2E__init__(finish_future, connect_data)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    def receive_acc_sys_info(self, acc_message):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        print(f&quot;Received sys_info me=
ssage: {acc_message!r}&quot;)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        l=
ogger=2Edebug(f&quot;Received sys_info message: {acc_message!r}&quot;)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg =3D json=2El=
oads(acc_message)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        asyncio=2Ecre=
ate_task(self=2Esend_info_response(msg))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    async def send_info_response(self, msg):</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        response =3D {}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if msg=2Eget(&quot;uname&quot;, Fals=
e):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            resp=
onse[&#39;uname&#39;] =3D platform=2Euname()=2E_asdict()</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if msg=2Eget(&quot;username&quot;, False):</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            try:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                response[&#39=
;username&#39;] =3D os=2Egetlogin()</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            except OSError as ose:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                response[&#39;username&#39;]=
 =3D f&quot;(error encountered fetching username: {ose})&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if msg=2Eget(&quot;hostname&quot;, False):<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            response=
[&#39;hostname&#39;] =3D platform=2Enode()</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if msg=2Eget(&quot;dns-google=2Ecom&quot;, False):</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            try:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                loop =3D asyncio=2E=
get_running_loop()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               addrs =3D [x[4][0] for x in await loop=2Egetaddrinfo(&#39;go=
ogle=2Ecom&#39;, 443)]</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                response[&quot;dns-google=2Ecom&quot;] =3D addrs</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            except Exception as e:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                logger=2Eerror(=
f&quot;Error resolving DNS for google=2Ecom: {e}&quot;, exc_info=3DTrue)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                respon=
se[&quot;dns-google=2Ecom&quot;] =3D None</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if msg=2Eget(&quot;route&quot;, False):</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            response[&#39;route&#39;] =3D aw=
ait self=2Eget_routes(False)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 msg=2Eget(&quot;route6&quot;, False):</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            response[&#39;route6&#39;] =3D await self=2E=
get_routes(True)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg =3D json=
=2Edumps(response)=2Eencode()</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        a=
wait self=2Esend_acc_msg(&quot;sys_info&quot;, msg)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    async def get_routes(self, v6):</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if platform=2Esystem() =3D=3D &#39;L=
inux&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   cmd =3D &#39;/usr/sbin/ip&#39;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            if v6:</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                args =3D [&#39;-6&#39;, &#39;route&#39;, &#39;=
show&#39;]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   else:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     args =3D [&#39;-4&#39;, &#39;route&#39;, &#39;show&#39;]</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        elif platform=2Esystem() =
=3D=3D &#39;Darwin&#39; or platform=2Esystem() =3D=3D &#39;FreeBSD&#39;:</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            # FreeBSD =
and macOS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  if os=2Epath=2Eexists(&#39;/usr/sbin/netstat&#39;):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                cmd =3D &#39;/usr/sbin/ne=
tstat&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   else:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     cmd =3D &#39;/usr/bin/netstat&#39;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            if v6:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                args =3D [&#39;-f&#39;, &#39;inet6&#39;, &#39;-rn&#39;]</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            else:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                args =3D [&#39;-f&#39;, &#39=
;inet&#39;, &#39;-rn&#39;]</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        else:</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            return &quot;Unsupported platform&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        proc =3D await asyncio=2Esubprocess=2Ecreate_subproc=
ess_exec(cmd, *args, stdout=3Dsubprocess=2EPIPE)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        try:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            output, _ =3D await asyncio=2Ewait_for(pr=
oc=2Ecommunicate(), timeout=3D15)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        except asyncio=2ETimeoutError:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            proc=2Ekill()</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            return &quot;Timeout wh=
ile waiting for command output&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return output=2Edecode()</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+async def main(connect_data=
: ConnectData):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
transport, protocol, finish_future =3D await start_management_protocol(conn=
ect_data, OmiSysInfoClientProtocol)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 management_version =3D await protocol=2Emanagement_ready()</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    logger=2Edebug(f&quot;Managemen=
t interface version: {management_version}&quot;)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    await protocol=2Eset_bytecount_interval(5)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    try:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        await finish_future</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    except CancelledError:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        # Ignore errors like ones caused by Control+C=
 in the demo script</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        pass</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+if __name__ =3D=3D &#39;__main__&#39;:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    run_main(main)</span><=
br><span>diff --git a/sample/management/acc_sysinfo_server_demo=2Epy b/samp=
le/management/acc_sysinfo_server_demo=2Epy</span><br><span>new file mode 10=
0755</span><br><span>index 0000000=2E=2E5649588</span><br><span>--- /dev/nu=
ll</span><br><span>+++ b/sample/management/acc_sysinfo_server_demo=2Epy</sp=
an><br><span>@@ -0,0 +1,138 @@</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#! /usr/bin/env python3</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+# Copyright (c) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Copyright (c) 202=
6 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# Permission is hereby granted, free of charge, to any person obtaining=
 a copy</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# of this so=
ftware and associated documentation files (the &quot;Software&quot;), to de=
al</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# in the Software=
 without restriction, including without limitation the rights</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+# to use, copy, modify, merge, pu=
blish, distribute, sublicense, and/or sell</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+# copies of the Software, and to permit persons to w=
hom the Software is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
# furnished to do so, subject to the following conditions:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+# The above copyright notice and this permission notic=
e shall be included in all</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+# copies or substantial portions of the Software=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+# THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT =
WARRANTY OF ANY KIND, EXPRESS OR</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERC=
HANTABILITY,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# FITNE=
SS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+# AUTHORS OR COPYRIGHT=
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+# LIABILITY, WHETHER IN AN ACTION OF CONTRAC=
T, TORT OR OTHERWISE, ARISING FROM,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR O=
THER DEALINGS IN THE</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# SOFTWARE=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+# This implements a smal=
l demonstration of using the</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+# OpenVPN Access Server Management Interface (OMI) and an app Cust=
om Control</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# protoco=
l (sys_info) to retrieve a number of system information from the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# client and push them to the =
server=2E To use this use on the server</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# --management-client-auth</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# --app-custom-control sys_info</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# --management /path/to/acc_sysinfo_server_demo=2Epy un=
ix-script</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# and on the client</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# --app-custom-control sys_in=
fo</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# --management /p=
ath/to/acc_sysinfo_client_demo=2Epy unix-script</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+# Note this is just a demonstration and not a production-ready sol=
ution=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# When modi=
fying this code, keep the security in mind=2E It is easy to</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+# introduce a security problem when=
 executing commands on the client=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+im=
port asyncio</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import =
json</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import logging<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+import random</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+from omi_server_protocol import OMIServerProt=
ocol, ConnectedClient</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+from omi_tools import run_main, start_management_protocol, ConnectData</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+logging=2EbasicConfig()</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+logger =3D logging=2EgetLogger(__name=
__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+logger=2EsetLeve=
l(logging=2EINFO)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+class SysInfoConnectedClient(ConnectedCl=
ient):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # Remembe=
r the key-id that we authenticated</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    authenticated_kid: int =3D -1</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    username: str =3D &quot;&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    common_name: str =3D &quot;=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+class OMISysInfoServerProtocol(OMIServerProtocol):<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def __init__(sel=
f, finish_future, connect_data: ConnectData):</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        super()=2E__init__(finish_future, connect=
_data)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=
=2E_connected_client_class =3D SysInfoConnectedClient</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    def client_event_ESTABLISHED(self, client: SysInfoConnec=
tedClient, kid: int, env: dict, extra: str):</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        logger=2Eerror(f&quot;CLient connected: {c=
lient}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  from pprint import pprint</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        kid=
 =3D client=2Eauthenticated_kid</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        client=2Eusername =3D env=2Eget(&quot;username&quot;, &=
quot;(no username found)&quot;)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        client=2Ecommon_name =3D env=2Eget(&quot;common_name&qu=
ot;, &quot;(no common name found)&quot;)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        asyncio=2Ecreate_task(self=2E_send_sys_info_co=
mmand(client, kid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def client_even=
t_CONNECT(self, client: SysInfoConnectedClient, kid: int, env: dict, extra:=
 str):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        logge=
r=2Edebug(f&quot;Authenticating client {client=2Ecid}, {kid}&quot;)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2Equeue_comman=
d(f&quot;client-auth-nt {client=2Ecid} {kid}&quot;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        client=2Eauthenticated_kid =3D ki=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    def client_event_REAUTH(self, cli=
ent: SysInfoConnectedClient, kid: int, env: dict, extra: str):</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        logger=2Edebug(f&quot;Re=
-authenticating client {client} on re-negotiation&quot;)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        _ =3D self=2Equeue_command(f&q=
uot;client-auth-nt {client=2Ecid} {kid}&quot;)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        client=2Eauthenticated_kid =3D kid</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+async def _send_sys_info_command(self, client: SysInfoConnected=
Client, kid: int):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   # Give the client some time to settle its routes</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    await asyncio=2Esleep(5)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if not &quot;sys_info&quot; in client=2Eacc_neg=
otiated_protocols:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       logger=2Einfo(</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            f&quot;Client {client=2Ecid} (Username: {client=2Eusername!r}=
, CN: {client=2Ecommon_name!r}) does not support sys_info protocol&quot;)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    info =3D [&quot;route&quot;, &quot;route6=
&quot;, &quot;dns-google=2Ecom&quot;, &quot;username&quot;, &quot;hostname&=
quot;, &quot;uname&quot;]</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # Pick 3 =
random infos to request from the client</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    random=2Eshuffle(info)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    infos =3D info[:3]</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    request =3D {k: True for k in infos}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    req_str =3D json=2Edumps(request)=2Ee=
ncode()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    logger=2Einfo(f&quot;Sendin=
g sysinfo request for client {client=2Ecid} with infos: {infos}&quot;)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    acc_protocol =3D &quot;sys_info&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    await self=2Esend_acc_msg(client, =
kid, acc_protocol, req_str)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+def receive_acc_client_sys_inf=
o(self, client: SysInfoConnectedClient, kid: int, acc_msg: str):</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    logger=2Einfo(</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        f&quot;Received sysinfo=
 from client {client=2Ecid} (Username: {client=2Eusername!r}, CN: {client=
=2Ecommon_name!r})&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    response =
=3D json=2Eloads(acc_msg)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    for key in response=2Ekeys():</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        logger=2Einfo(f&quot;=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D {key!r} =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if i=
sinstance(response[key], str):</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            for line in response[key]=2Esplit(&quot;\n&quot;):</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                logge=
r=2Einfo(repr(line))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        else:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       logger=2Einfo(repr(response[key]))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+async def main(c=
onnect_data: ConnectData):</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    transport, protocol, finish_future =3D await start_management_pr=
otocol(connect_data, OMISysInfoServerProtocol)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    management_version =3D await protocol=2Emanagement_ready()</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    logger=2Edebug(f&quo=
t;Management interface version: {management_version}&quot;)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    await protocol=2Eenable_log()</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    await protocol=2Eset_bytecount_interval(5)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    await finish_future</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if __name_=
_ =3D=3D &#39;__main__&#39;:</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    run_main(main)</span><br></pre><p>To view, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail">change 2037</a>=
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
hSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: Name of user not set #1000061 </div>
<div style=3D"display:none"> Gerrit=
-CC: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: Name of user not s=
et #1000061 </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--kK0K4GQXmQE=--


--===============6694108178396172956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6694108178396172956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6694108178396172956==--

