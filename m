Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D24B606A7BA
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HENzAozs;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=AKVtmYFw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=D47wYIn4;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WAwDEFWP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=G0DSErmoKce6KvuT1ICtWwQBVlRFpiDf1B0Vwg+E4WM=; b=HENzAozsOE4Xa5rNcKJ5qM3/zJ
	bkduIYZ1TMec7AAqdtjj5LXEqkUuCUTvtJQZgOBcVPz2y6ji5ywf9YnuE+0NKWRU9GA5FLEesR4Z2
	hvRXmessUbE/zB+tLcg+XAfyGHvr8EDTz5Ggqjm2I/8L3iFNLXr5l1cYf682tcYhm64s=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOG7P-000000005Ju-3X3U;
	Tue, 03 Nov 2026 15:08:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOG7O-000000005Jm-3ux6
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:08:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p6ytnTupJxrllUzROFCJt6t8avJne5qJaWwH8nK2310=; b=AKVtmYFwtQPs+pX46QPIDWoWFG
 Rq6qVVq7YO8bd2ZT+2/TcgGSE8n1CFjvXhX3b30Rmrt2LvUx7ixMAbXNLkbMDhb0x4cqexrnDSnQE
 9Va7eNetNx7Uw7iMjexjDrXx+fd1QV/w37PqbQ4weZvKSCbWLnHoNwpdeI7fBHIIhXg0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p6ytnTupJxrllUzROFCJt6t8avJne5qJaWwH8nK2310=; b=D47wYIn4R1/M31YfbvYp7D2jsK
 C8Ga3Kd2S6ZiwV6izvnNM+Yqgovl4/BS2m19ef6eQpwjELF5omy61iZEg2/2G4ZAL1lPGnNIhySuu
 ZGZPnLHF5cIS6aZVKPAM6xHFeBhkU213xWnM/OiRfZS8/9P09XrLQbfjycdIq0x7UCRg=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOG7M-000000005oB-2Inf for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:08:10 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso3780204f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 07:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793718482; x=1794323282; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=p6ytnTupJxrllUzROFCJt6t8avJne5qJaWwH8nK2310=;
 b=WAwDEFWPNT3+Y8/fmAj8LVC3usnEE/g0A66/qnZ2OW3DP2tyfQWgUmjVVlBTriwj2d
 LbH0Qs6Zs5bz7Z8FMXp7W5N2yLvBzKP5MfPxPSzamr0jkytr7Ja7duNinfcvVWCjhynt
 2Vqb5YEQ4f3aYD30rtSDzkmwaiR8VHI89PSWuRExyDTju6RlQoGkW4KNqbQDCOPfy60K
 nxq8A7jUMpQSw7yyGsonTYJbUut3B3qlOj8LdG+hkl8XCeYyhVXdN3gRL6ORLRr23Mi4
 nPyeYmIQtME+ticfC01NpqI2+Gk2dCuKL0NyN2oQDDfgjkCc0bCfQj+0EEorJGO0Wg0O
 +hIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793718482; x=1794323282;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=p6ytnTupJxrllUzROFCJt6t8avJne5qJaWwH8nK2310=;
 b=gfjkSboT5KjOC9a5+li7gQWHkV4K6WzqaCckP/sSH+8x98xxJ0VGJKgJOoGboi8P8i
 M2D48f0TnSBdBcJEvzCIK5r76QHgNflrogYQl/XueTDI97jZ8z8rbsRwiP0rfWI6/wXG
 K7ExiLOV3t/UTMtscQZ25U2APHlEZBlUe85EsjTmmRnic48NqFVUXboDw6oVz2WzxlC8
 9XeJOewYBBh6YnythsKKAYw5hLsO2iVsRxGbNcS7mmifZH6ON9ZU2UXXj0WQiWGwdQP+
 hU4TadhRZZu25quqNZYnvS/O5s7aZ/vSWAUnqdBtTyzH0TSRv/zp2IUPkhVT8Cf77tlw
 IGoQ==
X-Gm-Message-State: APuU4Z94BH6DK3OwYdCuhTjcNBAqkERMHbNBARtQ0sKUvar3Swh+nQwM
 ihz8M2c7gdGmsR7AVI9pjHbveNSZ39ZoiLgEbZPHwhR2FlNRWj1+naSG2CTPFoQFO90BfAkLAuD
 NKGyCbCibmO+598NoU9gdfOVLwnNLWkl3XHJMKS5NOhVZPFZAGu489cMibSeIc6OcHcdXj8rd46
 k3csBl2w==
X-Gm-Gg: AYBFou3+hUt5qbvKlTIxu+uirmWm3f9KLPS/qZPcR4VwhxwnDNbqtTua9a6rggHbom9
 KYf4GXx2GaNlkA7d4LiEMsMgiKHR9EnJX+JybmtGxU4JVZMf6zuB9tfhlqGSEFWsl4VaINJEnoR
 vlrgNenZaGXJ8E9I1cKl3ip8KKHuylhuWDcpNYHag8zJPTdD7enpBo5BAU3Vu33g/8siWH7ukAZ
 M0BgtG/7ADxWfpsEBb5EV0i7gD0kH+chhm3MiK/Co5240I/3Ch9K9GpkpozXnUvC/sxa5jZASy6
 O8TXI0URux6XFrKOlItP9AmrBETfgTSIgfpwOYyYeuMf7kiymAr5fAyqvqGK5IIamEOi8xpr1i+
 k68sTCQVLTDPTowo1rAuIKwqRtvezawhF81QUPvCCJGBHvDBnmXyeT021+37rxpCWeLCRCZ4lLV
 45BqXDIhoxu/f5FkohEaPMEnW71X/22tOyDXAVSu597COJNfxHnqqj6O3vY/32e54MejHFZ713I
 t9FgKzPogkywhVEblVDO0kMzg8pbkqxvaNoq6kejfLhcaFZ61cUw6Iw09uKRk86qhTOldR9iMI5
 bYnz0Ry1eU6RMSjDFgt5tR3xT1+9nseoO66z2iEGj2dDgxzEdEHuIBFqGIus8MV1JuyY8BA0U2X
 SC40iofAr4UG5VmABv+We9qKKeAV795UEZroeUFGOd/MjFaP0ARfKD/rwMpaIsFmG5HQPsh4ms0
 ItJZ0ODiwps3tnyw==
X-Received: by 2002:a05:600c:628d:b0:4a1:e01e:1927 with SMTP id
 5b1f17b1804b1-4ac17d16a1bmr304760155e9.5.1793718481573; 
 Tue, 03 Nov 2026 07:08:01 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba53d7sm32605685f8f.53.2026.11.03.07.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 07:08:01 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 15:07:56 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4
X-Gerrit-Change-Number: 2037
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2037?usp=email>
X-Gerrit-Commit: 4a23150505228078a7fcc42382596d377ea766f8
In-Reply-To: <gerrit.1793043747000.I695967524bb9e83887b8c07d0d09baff6e41acf4@gerrit.openvpn.net>
References: <gerrit.1793043747000.I695967524bb9e83887b8c07d0d09baff6e41acf4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDQzNzQ3MDAwLkk2OTU5Njc1MjRiYjllODM4ODdiOGMwN2QwZDA5YmFmZjZlNDFhY2Y0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0e153ba9c81e52ff9debee73e09f2dd317817c81-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOG7M-000000005oB-2Inf
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
Content-Type: multipart/mixed; boundary="===============6316592614472035875=="
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6316592614472035875==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gAJIPiiIy4g="; charset=UTF-8

--gAJIPiiIy4g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Name of user not set #1000061=2E

Arn=
e Schwabe has uploaded a new patch set (#4)=2E ( https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2037?usp=3Demail )


Change subject: Add python scripts =
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
les changed, 272 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/37/2037/4

diff --git a/sample/man=
agement/acc_sysinfo_client_demo=2Epy b/sample/management/acc_sysinfo_client=
_demo=2Epy
new file mode 100755
index 0000000=2E=2E99e994e
--- /dev/null
++=
+ b/sample/management/acc_sysinfo_client_demo=2Epy
@@ -0,0 +1,150 @@
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
+from asyncio import Canc=
elledError
+
+logging=2EbasicConfig()
+
+from omi_tools import run_main, st=
art_management_protocol, ConnectData
+from omi_client_protocol import OMICl=
ientProtocol
+
+logger =3D logging=2EgetLogger(__name__)
+logger=2EsetLevel=
(logging=2EINFO)
+
+
+class OmiSysInfoClientProtocol(OMIClientProtocol):
+ =
   def __init__(self, finish_future, connect_data: ConnectData):
+        s=
uper()=2E__init__(finish_future, connect_data)
+
+
+    def receive_acc_sys=
_info(self, acc_message):
+        print(f"Received sys_info message: {acc_=
message!r}")
+
+        logger=2Edebug(f"Received sys_info message: {acc_me=
ssage!r}")
+        msg =3D json=2Eloads(acc_message)
+
+        asyncio=2E=
create_task(self=2Esend_info_response(msg))
+
+    async def send_info_resp=
onse(self, msg):
+        response =3D {}
+        if msg=2Eget("uname", Fa=
lse):
+            response['uname'] =3D platform=2Euname()=2E_asdict()
+
+=
        if msg=2Eget("username", False):
+            response['username'] =
=3D os=2Egetlogin()
+
+        if msg=2Eget("hostname", False):
+          =
  response['hostname'] =3D platform=2Enode()
+
+        if msg=2Eget("dns-g=
oogle=2Ecom", False):
+            try:
+                loop =3D asyncio=
=2Eget_running_loop()
+                # getaddrinfo is a blocking call=2E =
This is okay for the demo
+                # here but
+                addr=
s =3D [x[4][0] for x in await loop=2Egetaddrinfo('google=2Ecom', 443)]
+   =
             response["dns-google=2Ecom"] =3D addrs
+
+            except E=
xception as e:
+                logger=2Eerror(f"Error resolving DNS for go=
ogle=2Ecom: {e}", exc_info=3DTrue)
+                response["dns-google=2E=
com"] =3D None
+
+        if msg=2Eget("route", False):
+            respon=
se['route'] =3D await self=2Eget_routes(False)
+
+        if msg=2Eget("rou=
te6", False):
+            response['route6'] =3D await self=2Eget_routes(T=
rue)
+
+        msg =3D json=2Edumps(response)=2Eencode()
+
+        await =
self=2Esend_acc_msg("sys_info", msg)
+
+    async def get_routes(self, v6):=

+        if platform=2Esystem() =3D=3D 'Linux':
+            cmd =3D '/usr=
/sbin/ip'
+            if v6:
+                args =3D ['-6', 'route', 'sh=
ow']
+            else:
+                args =3D ['-4', 'route', 'show']
+=
        elif platform=2Esystem() =3D=3D 'Darwin' or platform=2Esystem() =3D=
=3D 'FreeBSD':
+            # FreeBSD and macOS
+            if os=2Epath=
=2Eexists('/usr/sbin/netstat'):
+                cmd =3D '/usr/sbin/netstat=
'
+            else:
+                cmd =3D '/usr/bin/netstat'
+
+       =
     if v6:
+                args =3D [ '-f', 'inet6', '-rn']
+            =
else:
+
+                args =3D [ '-f', 'inet', '-rn']
+        else:
+  =
          return "Unsupported platform"
+
+        proc =3D await asyncio=
=2Esubprocess=2Ecreate_subprocess_exec(cmd, *args, stdout=3Dsubprocess=2EPI=
PE)
+        try:
+            output, _ =3D await asyncio=2Ewait_for(proc=
=2Ecommunicate(), timeout=3D15)
+        except asyncio=2ETimeoutError:
+  =
          return "Timeout while waiting for command output"
+        return=
 output=2Edecode()
+
+
+async def main(connect_data: ConnectData):
+    tra=
nsport, protocol, finish_future =3D await start_management_protocol(connect=
_data, OmiSysInfoClientProtocol)
+
+    management_version =3D await protoc=
ol=2Emanagement_ready()
+    logger=2Edebug(f"Management interface version:=
 {management_version}")
+
+    await protocol=2Eset_bytecount_interval(5)
+=

+    try:
+        await finish_future
+    except CancelledError:
+      =
  # Ignore errors like ones caused by Control+C in the demo script
+       =
 pass
+
+
+if __name__ =3D=3D '__main__':
+    run_main(main)
diff --git a/=
sample/management/acc_sysinfo_server_demo=2Epy b/sample/management/acc_sysi=
nfo_server_demo=2Epy
new file mode 100755
index 0000000=2E=2E764b7de
--- /d=
ev/null
+++ b/sample/management/acc_sysinfo_server_demo=2Epy
@@ -0,0 +1,122=
 @@
+#! /usr/bin/env python3
+# Copyright (c) 2026 OpenVPN Inc <sales@openv=
pn=2Enet>
+# Copyright (c) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+#
+# Per=
mission is hereby granted, free of charge, to any person obtaining a copy
+=
# of this software and associated documentation files (the "Software"), to =
deal
+# in the Software without restriction, including without limitation t=
he rights
+# to use, copy, modify, merge, publish, distribute, sublicense, =
and/or sell
+# copies of the Software, and to permit persons to whom the So=
ftware is
+# furnished to do so, subject to the following conditions:
+#
+#=
 The above copyright notice and this permission notice shall be included in=
 all
+# copies or substantial portions of the Software=2E
+#
+# THE SOFTWAR=
E IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED,=
 INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS=
 FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE
+# A=
UTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LI=
ABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,=

+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN THE
+# SOFTWARE=2E
+
+# This implements a small demonstration of using t=
he
+# OpenVPN Access Server Management Interface (OMI) and an app Custom Co=
ntrol
+# protocol (sys_info) to retrieve a number of system information fro=
m the
+# client and push them to the server=2E To use this use on the serve=
r
+
+# --management-client-auth
+# --app-custom-control sys_info
+# --manag=
ement /path/to/acc_sysinfo_server_demo=2Epy unix-script
+
+# and on the cli=
ent
+# --app-custom-control sys_info
+# --management /path/to/acc_sysinfo_c=
lient_demo=2Epy unix-script
+
+# Note this is just a demonstration and not =
a production-ready solution=2E
+# When modifying this code, keep the securi=
ty in mind=2E It is easy to
+# introduce a security problem when executing =
commands on the client=2E
+
+import asyncio
+import json
+import logging
+i=
mport random
+
+from omi_server_protocol import OMIServerProtocol, Connecte=
dClient
+from omi_tools import run_main, start_management_protocol, Connect=
Data
+
+logging=2EbasicConfig()
+logger =3D logging=2EgetLogger(__name__)
+=
logger=2EsetLevel(logging=2EINFO)
+
+class SysInfoConnectedClient(Connected=
Client):
+    # Remember the key-id that we authenticated
+    authenticate=
d_kid =3D None
+
+class OMISysInfoServerProtocol(OMIServerProtocol):
+    d=
ef __init__(self, finish_future, connect_data: ConnectData =3D None):
+    =
    super()=2E__init__(finish_future, connect_data)
+        self=2E_connec=
ted_client_class =3D SysInfoConnectedClient
+
+    def client_event_ESTABLI=
SHED(self, client, kid, env, extra):
+        print(f"CLient connected: {cl=
ient}")
+
+        kid =3D client=2Eauthenticated_kid
+        asyncio=2Ecr=
eate_task(self=2E_send_sys_info_command(client, kid))
+
+    def client_eve=
nt_CONNECT(self, client, kid, env, extra):
+        print(f"Authenticating =
client {client=2Ecid}, {kid}")
+        self=2Equeue_command(f"client-auth-=
nt {client=2Ecid} {kid}")
+        client=2Eauthenticated_kid =3D kid
+
+  =
  def client_event_REAUTH(self, client: DpcConnectedClient, kid: int, env: =
dict, extra: str):
+        print(f"Re-authenticating client {client} on re=
-negotiation")
+        _ =3D self=2Equeue_command(f"client-auth-nt {client=
=2Ecid} {kid}")
+
+    async def _send_sys_info_command(self, client, kid):=

+        # Give the client some time to settle its routes
+        await a=
syncio=2Esleep(5)
+
+        info =3D ["route", "route6", "dns-google=2Ecom=
", "username", "hostname", "uname"]
+
+        # Pick 3 random infos to req=
uest from the client
+        random=2Eshuffle(info)
+        infos =3D inf=
o[:3]
+        request =3D {k: True for k in infos}
+
+        req_str =3D =
json=2Edumps(request)=2Eencode()
+
+        logger=2Einfo(f"Sending sysinfo=
 request for client {client=2Ecid} with infos: {infos}")
+
+        acc_pro=
tocol =3D "sys_info"
+
+        await self=2Esend_acc_msg(client, kid, acc_=
protocol, req_str)
+
+    def receive_acc_client_sys_info(self, client, kid=
, acc_msg):
+        logger=2Einfo(f"Received sysinfo from client {client=
=2Ecid}")
+        
+        response =3D json=2Eloads(acc_msg)
+        fo=
r key in response=2Ekeys():
+            logger=2Einfo (f"=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D {key!r} =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D")
+            if isinstance(response[key], str):
+              =
  for line in response[key]=2Esplit("\n"):
+                    logger=2Ein=
fo(repr(line))
+            else:
+                logger=2Einfo(repr(respo=
nse[key]))
+
+
+async def main(connect_data: ConnectData):
+    transport, =
protocol, finish_future =3D await start_management_protocol(connect_data, O=
MISysInfoServerProtocol)
+
+    management_version =3D await protocol=2Eman=
agement_ready()
+    logger=2Edebug(f"Management interface version: {manage=
ment_version}")
+
+    await protocol=2Eenable_log()
+
+    await protocol=
=2Eset_bytecount_interval(5)
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
Gerrit-PatchSet: 4
Gerrit-Owner: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-CC: Name of user not set #1000061
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Name of=
 user not set #1000061

--gAJIPiiIy4g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Name of user not set #1000061=2E </p>
<p>Arne Schwabe=
 <strong>uploaded patch set #4</strong> to this change=2E</p><p><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail">View Change</a=
></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">Add python scripts that demonstrate the ACC protocol<br>=
<br>This adds a small protocol called sys_info that let&#39;s the server<br=
>query various details about the client to demonstrate the capabilities<br>=
of the ACC functionality=2E<br><br>Change-Id: I695967524bb9e83887b8c07d0d09=
baff6e41acf4<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>-=
--<br>A sample/management/acc_sysinfo_client_demo=2Epy<br>A sample/manageme=
nt/acc_sysinfo_server_demo=2Epy<br>2 files changed, 272 insertions(+), 0 de=
letions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/37/2037/4</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/sample/managemen=
t/acc_sysinfo_client_demo=2Epy b/sample/management/acc_sysinfo_client_demo=
=2Epy</span><br><span>new file mode 100755</span><br><span>index 0000000=2E=
=2E99e994e</span><br><span>--- /dev/null</span><br><span>+++ b/sample/manag=
ement/acc_sysinfo_client_demo=2Epy</span><br><span>@@ -0,0 +1,150 @@</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#!/usr/bin/env python3</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+# Copyright (c) 2026 Op=
enVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+# Copyright (c) 2026 Arne Schwabe &lt;arne@rfc2549=2Eorg&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# Permission is hereby granted, fr=
ee of charge, to any person obtaining a copy</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+# of this software and associated documentation fi=
les (the &quot;Software&quot;), to deal</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# in the Software without restriction, including withou=
t limitation the rights</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# copies of the=
 Software, and to permit persons to whom the Software is</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+# furnished to do so, subject to the f=
ollowing conditions:</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# The above copyr=
ight notice and this permission notice shall be included in all</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# copies or substantial portion=
s of the Software=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# THE SOFTWARE IS=
 PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+# IMPLIED, INCLUDING BUT =
NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+# FITNESS FOR A PARTICULAR PURPOSE AND NONINF=
RINGEMENT=2E IN NO EVENT SHALL THE</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMA=
GES OR OTHER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# LIABI=
LITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+# OUT OF OR IN CONNECT=
ION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+# SOFTWARE=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+# This implements a small demonstration of using the</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+# OpenVPN Access Server Man=
agement Interface (OMI) and an app Custom Control</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+# protocol (sys_info) to retrieve a number of=
 system information from the</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+# client and push them to the server=2E To use this use on the ser=
ver</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+# --management-client-auth</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# --app-custom-control sys_i=
nfo</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# --management /=
path/to/acc_sysinfo_server_demo=2Epy unix-script</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+# and on the client</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+# --app-custom-control sys_info</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+# --management /path/to/acc_sysinfo_client_demo=2Epy =
unix-script</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+# Note this is just a demon=
stration and not a production-ready solution=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+# When modifying this code, keep the security i=
n mind=2E It is easy to</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# introduce a security problem when executing commands on the client=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+import asyncio</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+import json</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+import logging</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+import os</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+import platform</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+import socket</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+import subprocess</span><br><span style=3D"color: hsl(120, 100%, 40%);">+f=
rom asyncio import CancelledError</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+loggi=
ng=2EbasicConfig()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+from omi_tools impor=
t run_main, start_management_protocol, ConnectData</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+from omi_client_protocol import OMIClientPro=
tocol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+logger =3D logging=2EgetLogger(__=
name__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+logger=2Eset=
Level(logging=2EINFO)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+class OmiSysInfoClientProtocol(OMICl=
ientProtocol):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    d=
ef __init__(self, finish_future, connect_data: ConnectData):</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        super()=2E__init__(finish_=
future, connect_data)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    def receive_acc_sys_info(self, a=
cc_message):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 print(f&quot;Received sys_info message: {acc_message!r}&quot;)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        logger=2Edebug(f&quot;Received sys_info me=
ssage: {acc_message!r}&quot;)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        msg =3D json=2Eloads(acc_message)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        asyncio=2Ecreate_task(self=2Esend_info_response(msg)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    async def send_info_response(self=
, msg):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        resp=
onse =3D {}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if msg=2Eget(&quot;uname&quot;, False):</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            response[&#39;uname&#39;] =3D platform=2Eun=
ame()=2E_asdict()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if msg=2Eget(=
&quot;username&quot;, False):</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            response[&#39;username&#39;] =3D os=2Egetlogin()</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if msg=2Eget(&quot;hostname&quot;=
, False):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  response[&#39;hostname&#39;] =3D platform=2Enode()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if msg=2Eget(&quot;dns-google=2Ecom&quot;, False):</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            try:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                loop =3D=
 asyncio=2Eget_running_loop()</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                # getaddrinfo is a blocking call=2E This is okay =
for the demo</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         # here but</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                addrs =3D [x[4][0] for x in await loop=2Egetaddrinfo(&#39;g=
oogle=2Ecom&#39;, 443)]</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                response[&quot;dns-google=2Ecom&quot;] =3D addrs</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            except Exception as e:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                logger=2Eerror=
(f&quot;Error resolving DNS for google=2Ecom: {e}&quot;, exc_info=3DTrue)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                respo=
nse[&quot;dns-google=2Ecom&quot;] =3D None</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if msg=2Eget(&quot;route&quot;, False):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            response[&#39;route&#39;] =3D=
 await self=2Eget_routes(False)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if msg=2Eget(&quot;route6&quot;, False):</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            response[&#39;route6&#39;] =3D await self=
=2Eget_routes(True)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg =3D jso=
n=2Edumps(response)=2Eencode()</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
await self=2Esend_acc_msg(&quot;sys_info&quot;, msg)</span><br><span style=
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
                args =3D [ &#39;-f&#39;, &#39;inet6&#39;, &#39;-rn&#39;]</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            else:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                args =3D [ &#39;-f&#39;, =
&#39;inet&#39;, &#39;-rn&#39;]</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        else:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            return &quot;Unsupported platform&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        proc =3D await asyncio=2Esubprocess=2Ecreate_subp=
rocess_exec(cmd, *args, stdout=3Dsubprocess=2EPIPE)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        try:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            output, _ =3D await asyncio=2Ewait_f=
or(proc=2Ecommunicate(), timeout=3D15)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        except asyncio=2ETimeoutError:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            return &quot;Timeout whil=
e waiting for command output&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return output=2Edecode()</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+async def =
main(connect_data: ConnectData):</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    transport, protocol, finish_future =3D await start_managem=
ent_protocol(connect_data, OmiSysInfoClientProtocol)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    management_version =3D await protocol=2Emanagement_ready=
()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    logger=2Edebu=
g(f&quot;Management interface version: {management_version}&quot;)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    await protocol=2Eset_bytecount_interval(5)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    try:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        await finish_future</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    except CancelledError:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        # Ignore errors like ones =
caused by Control+C in the demo script</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        pass</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+if __name__ =3D=3D &#39;__=
main__&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    run=
_main(main)</span><br><span>diff --git a/sample/management/acc_sysinfo_serv=
er_demo=2Epy b/sample/management/acc_sysinfo_server_demo=2Epy</span><br><sp=
an>new file mode 100755</span><br><span>index 0000000=2E=2E764b7de</span><b=
r><span>--- /dev/null</span><br><span>+++ b/sample/management/acc_sysinfo_s=
erver_demo=2Epy</span><br><span>@@ -0,0 +1,122 @@</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#! /usr/bin/env python3</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# Copyright (c) 2026 OpenVPN Inc &lt;sale=
s@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
# Copyright (c) 2026 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+# Permission is hereby granted, free of charge, to a=
ny person obtaining a copy</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+# of this software and associated documentation files (the &quot;Sof=
tware&quot;), to deal</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# in the Software without restriction, including without limitation the r=
ights</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# to use, copy=
, modify, merge, publish, distribute, sublicense, and/or sell</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+# copies of the Software, and to =
permit persons to whom the Software is</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+# furnished to do so, subject to the following condition=
s:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+# The above copyright notice and th=
is permission notice shall be included in all</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+# copies or substantial portions of the Software=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# THE SOFTWARE IS PROVIDED &quot;A=
S IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# IMPLIED, INCLUDING BUT NOT LIMITED TO T=
HE WARRANTIES OF MERCHANTABILITY,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN =
NO EVENT SHALL THE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+# LIABILITY, WHETHER IN=
 AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+# OUT OF OR IN CONNECTION WITH THE SOF=
TWARE OR THE USE OR OTHER DEALINGS IN THE</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+# SOFTWARE=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# T=
his implements a small demonstration of using the</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+# OpenVPN Access Server Management Interface =
(OMI) and an app Custom Control</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# protocol (sys_info) to retrieve a number of system informatio=
n from the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# client =
and push them to the server=2E To use this use on the server</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+# --management-client-auth</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# --app-custom-control sys_info</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# --management /path/to/acc_sysinf=
o_server_demo=2Epy unix-script</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# and on=
 the client</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# --app-=
custom-control sys_info</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# --management /path/to/acc_sysinfo_client_demo=2Epy unix-script</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+# Note this is just a demonstration and not a=
 production-ready solution=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+# When modifying this code, keep the security in mind=2E It is ea=
sy to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# introduce a =
security problem when executing commands on the client=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+import asyncio</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+import json</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+import logging</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+import random</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+from omi_server_protocol=
 import OMIServerProtocol, ConnectedClient</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+from omi_tools import run_main, start_management_pro=
tocol, ConnectData</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+logging=2EbasicConfi=
g()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+logger =3D loggi=
ng=2EgetLogger(__name__)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+logger=2EsetLevel(logging=2EINFO)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
class SysInfoConnectedClient(ConnectedClient):</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    # Remember the key-id that we authenticated<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    authenticated_ki=
d =3D None</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+class OMISysInfoServerProtoc=
ol(OMIServerProtocol):</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    def __init__(self, finish_future, connect_data: ConnectData =3D None=
):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        super()=
=2E__init__(finish_future, connect_data)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        self=2E_connected_client_class =3D SysInfoConn=
ectedClient</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    def client_event_ESTABL=
ISHED(self, client, kid, env, extra):</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        print(f&quot;CLient connected: {client}&quot;)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        kid =3D client=2Eauthenticated_ki=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        asyncio=2E=
create_task(self=2E_send_sys_info_command(client, kid))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    def client_event_CONNECT(self, client, kid, env, extra=
):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        print(f&q=
uot;Authenticating client {client=2Ecid}, {kid}&quot;)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        self=2Equeue_command(f&quot;clie=
nt-auth-nt {client=2Ecid} {kid}&quot;)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        client=2Eauthenticated_kid =3D kid</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    def client_event_REAUTH(self, client: DpcConnect=
edClient, kid: int, env: dict, extra: str):</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        print(f&quot;Re-authenticating client {clie=
nt} on re-negotiation&quot;)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        _ =3D self=2Equeue_command(f&quot;client-auth-nt {client=
=2Ecid} {kid}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    async def _sen=
d_sys_info_command(self, client, kid):</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        # Give the client some time to settle its routes=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        await async=
io=2Esleep(5)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        info =3D [&quot;r=
oute&quot;, &quot;route6&quot;, &quot;dns-google=2Ecom&quot;, &quot;usernam=
e&quot;, &quot;hostname&quot;, &quot;uname&quot;]</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        # Pick 3 random infos to request from the client</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        random=2Eshuffle(in=
fo)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        infos =
=3D info[:3]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 request =3D {k: True for k in infos}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       req_str =3D json=2Edumps(request)=2Eencode()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        logger=2Einfo(f&quot;Sending sysinfo request for cli=
ent {client=2Ecid} with infos: {infos}&quot;)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        acc_protocol =3D &quot;sys_info&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        await self=2Esend_acc_msg(client, kid, acc_protocol,=
 req_str)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    def receive_acc_client_sy=
s_info(self, client, kid, acc_msg):</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        logger=2Einfo(f&quot;Received sysinfo from client {=
client=2Ecid}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
sponse =3D json=2Eloads(acc_msg)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        for key in response=2Ekeys():</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            logger=2Einfo (f&quot;=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D {key!r} =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            if isinstance(response[key], str):</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                for line in response[key]=2Es=
plit(&quot;\n&quot;):</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                    logger=2Einfo(repr(line))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            else:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                logger=2Einfo(repr(response[key])=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+async def main(connect_data: ConnectData):</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    transport, protocol, finish_f=
uture =3D await start_management_protocol(connect_data, OMISysInfoServerPro=
tocol)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    management_version =3D await=
 protocol=2Emanagement_ready()</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    logger=2Edebug(f&quot;Management interface version: {managem=
ent_version}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    await protocol=
=2Eenable_log()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    await protocol=2Ese=
t_bytecount_interval(5)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    await finis=
h_future</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+if __name__ =3D=3D &#39;__main__&#39;:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+   run_main(main)</span><br></=
pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2037?usp=3Demail">change 2037</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2037?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2037 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: Name of user not set #1000061 </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Name of user not set #1000061 </div>

</body></html>
--gAJIPiiIy4g=--


--===============6316592614472035875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6316592614472035875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6316592614472035875==--

