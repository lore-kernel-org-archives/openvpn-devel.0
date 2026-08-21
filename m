Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154ECC5DF94
	for <openvpn-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=WIWj7O4tgpX2vDORuKtJX1nZm52s+nXs6O1hhi2YAzQ=; b=gYmZOOHhEY3t3D
	BpsJKEkR5HWe6k4mYOuRGvrrlJUVf5NFtkZeHW7d1/4ssqlWspAlcgAQuL3kCxppdK/ERzm6JSeJE
	lPmDsiRqO1TEDKE/Nttrn9OmRLA/S6gnug28KvJLUYj94oAyY4j1Igqi/Q1KeEGfs9ORWsphT7c59
	TFA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wxRV2-0002Hs-75;
	Fri, 21 Aug 2026 15:49:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wxRV0-0002Hd-V2
 for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:49:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HybLQv2/QZmak3TNwjLvs8e6b6DXhcCkfRvJDy2WWNY=; b=e+kBimPMvNuLvH8Un2SXd2wcXL
 EbiUqqxra8qwaJlu9J4P/LYDAvzQw3CXYnJYr4YLaq34QRhQU4B34+qafd7tzP0pGfuOm9gr3RTTo
 3lw7EfCei/MdAyyGyvEKT6NwDeDDK9/BrFmw4zJjNb3YBFfAIJ+HkLH3GvocwzEJ9DzA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HybLQv2/QZmak3TNwjLvs8e6b6DXhcCkfRvJDy2WWNY=; b=L
 b0y5r/k3tINOc/v/4DEVykzBFcxoBPsqsAhzBhszQAVKW33OC1bzIORCg5qyalBhm1ZNjsnlOVObX
 iFXfBfbZqq5piFmOc2RQt3INVz7l2GC2iKNxk0twa29QMDkBmf45lqS6fYQgC23SBzpTWVK7BQKhy
 bZbeGTXfBV+QkTgI=;
Received: from mail-ed1-f42.google.com ([209.85.208.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wxRUw-0005d5-GC for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:49:43 +0000
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6983d3dae7aso3874387a12.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 21 Aug 2026 08:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787327372; x=1787932172; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HybLQv2/QZmak3TNwjLvs8e6b6DXhcCkfRvJDy2WWNY=;
 b=cofLcdM2KWdVhjXaMObitU21gWFgtrWdGVOWZWBVekA6UGGHtLZJfM44x40erG0J1z
 7RsKeZ7Uk/3EoRK9Sg28dcr9dF4qHRvABtlci2JHneELpxjXjJU+80ReyB8juaVDwhcH
 8dUKgbO30Zmv4SGyiViltJJq6vm0OHdKhyMoZlg3+OvpdyUBqA4M+6aEBkWs4wKH/o9s
 h63ptsQpRg6thk2XU7+ziM+t9QzE9Ct4pQT/7YcqKiMJp7SZlDDZj72/1k+PVcsWtKYX
 c8GDk4zXfPYtV7XbbBTz9KEMAQVCRO+fxSehKLhwTVdj9/bLVkuXilhC+waifACDRZbW
 LhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787327372; x=1787932172;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HybLQv2/QZmak3TNwjLvs8e6b6DXhcCkfRvJDy2WWNY=;
 b=L3XNjBYI+MpE2AtJsXg3OlHvD8XgbyXNjHaelHwtdVPxukYOgIB+bdZTsvjGGPgUkt
 a+/kqt1EpBKQjCletGQglWyFhOGSH0ybHBJ0V+09vUBNdUI7mAAgY3K3BO9BGQ7N4m5D
 1++8UZ+84xIzoGa7zaBPgwjWv9g9xIhsu9BrFF9jo1pUn7R/dqus4P/SdF+5LF0XIUXK
 oA73BV/+88R8Yml/NWo3/Cjek2M+tORFfF94jw+ihVfqiHzLSsbcqsHRMr290l/7/HRz
 7xWpnObLyphLgSTxx6RnKcJa1W1XDHMF/4+3BeWACCC0dqi7lOXRQX9sHU0znfoxF+Pz
 1QCw==
X-Gm-Message-State: AFuF++kcd9PZ5GaqwzQBQbsYVSesm/UHgYWO8JEmHJRENI2hA8WaQYgd
 duYQ1L+/5tqD2fQDVoANJLmPImbNoxuYSs2vgHRTHLXHSeHPurSH2UUIM5rdw0KVjItc3LOyMwE
 +eT41P2AuRi4gayhLq/okCxtpD++bo7UlAUH90LZIUlLner4Eq22m24GrUGFCkR4dfdVi4qjxIi
 7Fxn/bhg==
X-Gm-Gg: AR+sD12mi0f7YNl8mte827uqvGFS2bm7PF5048YeQYywvlyYLgE2SLJmt2T8TrR/L5i
 8p6zGbVWrxSKYAIYPcUJLzlxyuwZnU3hpuhOG9w8WLUz0N+7M6bZkEvMiQK/wIUb8CZFlcowvfA
 ujsCBzdleU5epQB+Nqj3GTvZ3Dl29mgDvmmeualMmW43hik/GZDwFj22xz25mdEeynCfYkbcx7E
 rtkcwaweX0qDFdaEqK9t+QHTwyZzJzsH4PZTrDNwXV/ZVDj3agk4szD3rmZZu9L6foNaGlOzech
 QglQYpp5JRRXx+YhKoDRRGRjZJ4A2guoeoNZhTLEfqaC7PrCk0C8kyOx3bsme0M3GkopCD7adQB
 0EKOI7i5kvm5kkuM+j6HktxlEsApRYa6C4e8gLpKboeyJ/TxW2Yi2fElCm0jUuXWYHqjtos4vlc
 VH3tpE4rFjGGg4Nyyn0OBNe+1a9W80IyILgd2DJ58TUuzxO7ODBneqgq3mjZwWIXiyXfO/xuW9p
 2bNLFiBOEM/RuDgYfQRSa6cpUjo7RsBPwU8Mit+butPRurmGG7Dy9ou4pCvJSmatrDRGQpFZ3aP
 xDon30EYQk8ieHoJpcGvN1G+0BIJ9GH8j1EhaopC+KQQUH2h3Dc=
X-Received: by 2002:a17:907:8d8e:b0:c20:61e0:e3ab with SMTP id
 a640c23a62f3a-c244d45a6b4mr1244534566b.3.1787327371120; 
 Fri, 21 Aug 2026 08:49:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24589e1ac0sm501623666b.11.2026.08.21.08.49.30
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 08:49:30 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 21 Aug 2026 15:49:29 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5
X-Gerrit-Change-Number: 1859
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1859?usp=email>
X-Gerrit-Commit: 2137330bbf353f24784c67ed259ddd3c897fc296
References: <gerrit.1787327336000.Ib09bafabf612e9501ea757647c86a450c73228a5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkliMDliYWZhYmY2MTJlOTUwMWVhNzU3NjQ3Yzg2YTQ1MGM3MzIyOGE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c73d1ec33f6e06abdf2b3024f7e30c40b72151a2-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wxRUw-0005d5-GC
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add python scripts
 that demonstrate using the mangement interface
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6059879059053732170=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6059879059053732170==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nTp7E02q0+4="; charset=UTF-8

--nTp7E02q0+4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1859?usp=3Demail )


Change subject: Add python scripts =
that demonstrate using the mangement interface
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add python scripts that demonstrate usin=
g the mangement interface

Change-Id: Ib09bafabf612e9501ea757647c86a450c732=
28a5
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
A sample/manageme=
nt/acc_sysinfo_client_demo=2Epy
A sample/management/acc_sysinfo_server_demo=
=2Epy
A sample/management/omi=2Epy
A sample/management/omi_tools=2Epy
4 fil=
es changed, 774 insertions(+), 0 deletions(-)



  git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/59/1859/1

diff --git a/sample/man=
agement/acc_sysinfo_client_demo=2Epy b/sample/management/acc_sysinfo_client=
_demo=2Epy
new file mode 100755
index 0000000=2E=2E7a7f015
--- /dev/null
++=
+ b/sample/management/acc_sysinfo_client_demo=2Epy
@@ -0,0 +1,174 @@
+#!/op=
t/homebrew/bin/python3
+# Copyright (c) 2026 OpenVPN Inc <sales@openvpn=2En=
et>
+# Copyright (c) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+#
+# Permissio=
n is hereby granted, free of charge, to any person obtaining a copy
+# of t=
his software and associated documentation files (the "Software"), to deal
+=
# in the Software without restriction, including without limitation the rig=
hts
+# to use, copy, modify, merge, publish, distribute, sublicense, and/or=
 sell
+# copies of the Software, and to permit persons to whom the Software=
 is
+# furnished to do so, subject to the following conditions:
+#
+# The a=
bove copyright notice and this permission notice shall be included in all
+=
# copies or substantial portions of the Software=2E
+#
+# THE SOFTWARE IS P=
ROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLU=
DING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A=
 PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE
+# AUTHORS=
 OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILIT=
Y, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+# OU=
T OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE=

+# SOFTWARE=2E
+
+# This implement a small demonstration of using the
+# O=
penVPN Access Server Management Interface (OMI) and an app Custom Control
+=
# protocol (info_sample) to retrieve a number of system information from th=
e
+# client and push them to the server=2E To use this use on the server
+
=
+# --app-custom-control info_sample
+# --management /path/to/acc_sysinfo_se=
rver_demo=2Epy unix-script
+
+# and on the client
+# --app-custom-control i=
nfo_sample
+# --management /path/to/acc_sysinfo_client_demo=2Epy unix-scrip=
t
+
+# Note this is just a demonstration and not a production-ready solutio=
n=2E
+# When modifying this code, keep the security in mind=2E It is easy t=
o
+# introduce a security problem when executing commands on the client=2E
=
+
+import asyncio
+import base64
+import json
+import logging
+import os
+i=
mport platform
+import socket
+import subprocess
+
+from omi import OmiProt=
ocol
+from omi_tools import run_main, start_management_protocol, ConnectDat=
a
+
+logger =3D logging=2EgetLogger(__name__)
+logger=2EsetLevel(logging=2E=
DEBUG)
+
+
+class OmiSysInfoClientProtocol(OmiProtocol):
+    def __init__(=
self, finish_future, connect_data: ConnectData):
+        super()=2E__init_=
_(finish_future, connect_data)
+        self=2E_acc_msg =3D ""
+
+    def r=
ecv_notify_ACC(self, args):
+        protocol, fragment, b64msg =3D args=2E=
split(",", 2)
+        if protocol !=3D "sys_info":
+            logging=2E=
info(f"Received unknown ACC protocol: {protocol}")
+            return
+
+ =
       msg =3D base64=2Edecodebytes(b64msg=2Eencode())
+        self=2E_acc=
_msg +=3D msg=2Edecode()
+
+        # Message is not yet complete=2E Wait f=
or more fragments=2E
+        if fragment !=3D "0":
+            return
+
+=
        try:
+            self=2Eparse_sysinfo_message(self=2E_acc_msg)
+  =
      except Exception as e:
+            logging=2Eerror(f"Error parsing A=
CC message: {e}", exc_info=3DTrue)
+        self=2E_acc_msg =3D ""
+
+    d=
ef parse_sysinfo_message(self, accmsg):
+        msg =3D json=2Eloads(accms=
g)
+
+        logging=2Einfo(f"Received sys_info message: {accmsg}")
+
+   =
     asyncio=2Ecreate_task(self=2Esend_info_response(msg))
+
+    async def=
 send_info_response(self, msg):
+        response =3D {}
+        if msg=2E=
get("uname", False):
+            response['uname'] =3D platform=2Euname()=
=2E_asdict()
+
+        if msg=2Eget("username", False):
+            respo=
nse['username'] =3D os=2Egetlogin()
+
+        if msg=2Eget("hostname", Fal=
se):
+            response['hostname'] =3D platform=2Enode()
+
+        if =
msg=2Eget("dns-google=2Ecom", False):
+            try:
+                ad=
drs =3D [x[4][0] for x in socket=2Egetaddrinfo('google=2Ecom', 443)]
+     =
           response["dns-google=2Ecom"] =3D addrs
+
+            except Exc=
eption as e:
+                logging=2Eerror(f"Error resolving DNS for goo=
gle=2Ecom: {e}", exc_info=3DTrue)
+                response["dns-google=2Ec=
om"] =3D None
+
+        if msg=2Eget("route", False):
+            respons=
e['route'] =3D await self=2Eget_routes(False)
+
+        if msg=2Eget("rout=
e6", False):
+            response['route6'] =3D await self=2Eget_routes(Tr=
ue)
+
+        # TODO implement fragmentation
+
+        msg =3D json=2Edum=
ps(response)=2Eencode()
+        # 980 chars after base64 encoding
+       =
 fragment_length =3D 980*6//8
+
+        for part_start in range(0, len(msg=
), fragment_length):
+
+            msg_part =3D msg[part_start:part_start =
+ fragment_length]
+            b64msg =3D base64=2Eencodebytes(msg_part)=
=2Edecode()
+
+            protocol =3D "sys_info"
+
+            flags =3D=
 "6"
+            if part_start + fragment_length < len(msg):
+            =
    flags =3D "6:F"
+
+            command =3D f"acc-msg\n{protocol}\n{flag=
s}\n{b64msg}\nEND"
+            self=2Equeue_command(command)
+
+    async =
def get_routes(self, v6):
+        if platform=2Esystem() =3D=3D 'linux':
+=
            cmd =3D '/usr/sbin/ip'
+            if v6:
+                arg=
s =3D ['-6', 'route', 'show']
+            else:
+                args =3D =
['-4', 'route', 'show']
+        elif platform=2Esystem() =3D=3D 'Darwin' o=
r os=2Eplatform() =3D=3D 'FreeBSD':
+            # FreeBSD and macOS
+     =
       if os=2Epath=2Eexists('/usr/sbin/netstat'):
+                cmd =3D=
 '/usr/sbin/netstat'
+            else:
+                cmd =3D '/usr/bin/=
netstat'
+
+            if v6:
+                args =3D [ '-f', 'inet6', '=
-rn']
+            else:
+
+                args =3D [ '-f', 'inet', '-rn']=

+        else:
+            return "Unsupported platform"
+
+        proc =
=3D await asyncio=2Esubprocess=2Ecreate_subprocess_exec(cmd, *args, stdout=
=3Dsubprocess=2EPIPE)
+        output, _ =3D await proc=2Ecommunicate()
+  =
      return output=2Edecode()
+
+
+async def main(connect_data: ConnectDat=
a):
+    transport, protocol, finish_future =3D await start_management_prot=
ocol(connect_data, OmiSysInfoClientProtocol)
+    while True:
+        awai=
t asyncio=2Esleep(1)
+        print("=2E", end=3D"", flush=3DTrue)
+
+    m=
anagement_version =3D await protocol=2Emanagement_ready()
+    print(f"Mana=
gement interface version: {management_version}")
+
+    await protocol=2Ese=
t_bytecount_interval(5)
+
+    await finish_future
+
+
+if __name__ =3D=3D =
'__main__':
+    run_main(main)
diff --git a/sample/management/acc_sysinfo_=
server_demo=2Epy b/sample/management/acc_sysinfo_server_demo=2Epy
new file =
mode 100755
index 0000000=2E=2E139d2f9
--- /dev/null
+++ b/sample/managemen=
t/acc_sysinfo_server_demo=2Epy
@@ -0,0 +1,135 @@
+#!/opt/homebrew/bin/pytho=
n3
+# Copyright (c) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+# Copyright (c)=
 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+#
+# Permission is hereby granted,=
 free of charge, to any person obtaining a copy
+# of this software and ass=
ociated documentation files (the "Software"), to deal
+# in the Software wi=
thout restriction, including without limitation the rights
+# to use, copy,=
 modify, merge, publish, distribute, sublicense, and/or sell
+# copies of t=
he Software, and to permit persons to whom the Software is
+# furnished to =
do so, subject to the following conditions:
+#
+# The above copyright notic=
e and this permission notice shall be included in all
+# copies or substant=
ial portions of the Software=2E
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WIT=
HOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED=
 TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE =
AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE
+# AUTHORS OR COPYRIGHT HOLDER=
S BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACT=
ION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+# OUT OF OR IN CONNECTIO=
N WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+# SOFTWARE=2E
+imp=
ort asyncio
+# This implement a small demonstration of using the
+# OpenVPN=
 Access Server Management Interface (OMI) and an app Custom Control
+# prot=
ocol (info_sample) to retrieve a number of system information from the
+# c=
lient and push them to the server=2E To use this use on the server
+
+# --a=
pp-custom-control info_sample
+# --management /path/to/acc_sysinfo_server_d=
emo=2Epy unix-script
+
+# and on the client
+# --app-custom-control info_sa=
mple
+# --management /path/to/acc_sysinfo_client_demo=2Epy unix-script
+
+i=
mport base64
+import json
+import logging
+import random
+from pprint impor=
t pprint, pformat
+
+from omi import OMIServerProtocol, ConnectedClient
+fr=
om omi_tools import run_main, start_management_protocol, ConnectData
+
+log=
ger =3D logging=2EgetLogger(__name__)
+logger=2EsetLevel(logging=2EINFO)
+
=
+class SysInoConnectedClient(ConnectedClient):
+    accmsg =3D ""
+
+class =
OMISysInfoServerProtocol(OMIServerProtocol):
+    def __init__(self, finish=
_future, connect_data: ConnectData =3D None):
+        super()=2E__init__(f=
inish_future, connect_data)
+        self=2Eaccmsg =3D ""
+        self=2E_=
connected_client_class =3D SysInoConnectedClient
+
+
+    def client_event_=
ACC(self,client, kid, env, extra):
+        protocol, fragment, b64msg =3D =
extra=2Esplit(",", 2)
+        if protocol !=3D "sys_info":
+            lo=
gging=2Einfo(f"Received unknown ACC protocol: {protocol}")
+            ret=
urn
+
+        try:
+
+            msg =3D base64=2Edecodebytes(b64msg=2Een=
code())
+            client=2Eaccmsg +=3D msg=2Edecode()
+
+            # M=
essage is not yet complete=2E Wait for more fragments=2E
+            if fr=
agment !=3D "0":
+                return
+
+            self=2Eparse_sys_in=
fo_reply(client=2Eaccmsg)
+            client=2Eaccmsg =3D ""
+
+        ex=
cept Exception as e:
+            logger=2Eerror(f"Error parsing sys_info m=
essage: {e}", exc_info=3DTrue)
+
+    def parse_sys_info_reply(self, accmsg=
):
+        logger=2Edebug(f"Received sys_info message: {accmsg!r}")
+     =
   client_info =3D json=2Eloads(accmsg)
+
+        logger=2Einfo(f"Received=
 sys_info response: {pformat(client_info)}")
+
+    def client_event_ESTABL=
ISHED(self, client, kid, env, extra):
+        print(f"CLient connected: {c=
lient}")
+        pprint(env)
+
+        # TODO: track kid and don't assume=
 we haven't done a renegotiation
+        kid =3D 1
+        asyncio=2Ecrea=
te_task(self=2E_send_sys_info_command(client=2Ecid, kid))
+
+    def client=
_event_CONNECT(self, client, kid, env, extra):
+        print(f"Authenticat=
ing client {client=2Ecid}, {kid}")
+        self=2Equeue_command(f"client-a=
uth-nt {client=2Ecid} {kid}")
+
+    async def _send_sys_info_command(self,=
 cid, kid):
+        # Give the client some time to settle its routes
+    =
    await asyncio=2Esleep(5)
+
+        info =3D ["route", "route6", "dns-g=
oogle=2Ecom", "username", "hostname", "uname"]
+        # Pick 3 random inf=
os from the client
+
+        infos =3D random=2Echoices(info, k=3D3)
+    =
    request =3D {k: True for k in infos}
+
+        for i in info:
+       =
     request =3D {i: True}
+            req_str =3D json=2Edumps(request)=
=2Eencode()
+
+            logger=2Einfo(f"Sending sysinfo request for clie=
nt {cid} with infos: {infos}")
+
+            req_base64 =3D base64=2Eencod=
ebytes(req_str)=2Edecode()
+            acc_protocol =3D "sys_info"
+
+    =
        # TODO: Implement fragmentation
+            cmd =3D f"client-acc-m=
sg {cid} {kid}\n{acc_protocol}\n6\n{req_base64}\nEND"
+
+            await =
self=2Equeue_command(cmd)
+
+
+async def main(connect_data: ConnectData):
+=
    transport, protocol, finish_future =3D await start_management_protocol(=
connect_data, OMISysInfoServerProtocol)
+
+    management_version =3D await=
 protocol=2Emanagement_ready()
+    print(f"Management interface version: {=
management_version}")
+
+    await protocol=2Eenable_log()
+
+    await pro=
tocol=2Eset_bytecount_interval(5)
+
+    await finish_future
+
+
+if __name=
__ =3D=3D '__main__':
+    run_main(main)
diff --git a/sample/management/om=
i=2Epy b/sample/management/omi=2Epy
new file mode 100644
index 0000000=2E=
=2E2a7f90e
--- /dev/null
+++ b/sample/management/omi=2Epy
@@ -0,0 +1,372 @@=

+#!/opt/homebrew/bin/python3
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
+# This is an example implementation in python and=
 asyncio to drive OpenVPN's
+# management interface (OMI)=2E The permissive=
 license allows you to use this
+# code in other projects=2E
+
+"""
+Implem=
entation of the OpenVPN management interface (OMI) protocol=2E
+"""
+import=
 asyncio
+import logging
+import re
+from asyncio import Future
+from datac=
lasses import dataclass
+from datetime import datetime
+from typing import =
override, List
+
+logger =3D logging=2EgetLogger(__name__)
+logger=2EsetLev=
el(logging=2EINFO)
+
+
+@dataclass
+class OmiCommandResult:
+    command: s=
tr
+    result: List[str]
+    error: bool
+    status_text: str
+
+
+@data=
class
+class OmiSendCommand:
+    command: str
+    result: Future[OmiComma=
ndResult]
+
+
+@dataclass
+class ConnectionProperties:
+    """
+    Proper=
ties for connecting to the management interface=2E
+    """
+    password: =
str
+
+
+class OmiProtocol(asyncio=2EProtocol):
+    def __init__(self, fin=
ish_future, connect_data: ConnectionProperties):
+        super()=2E__init_=
_()
+        self=2Ebytes_received =3D None
+        self=2Ebytes_sent =3D =
None
+        self=2Eversion =3D -1
+        self=2ErecvBuffer =3D ""
+    =
    self=2Efinish_future =3D finish_future
+        self=2E_can_send =3D as=
yncio=2EEvent()
+        self=2E_can_send=2Eclear()
+
+        self=2E_mana=
gement_ready =3D asyncio=2EEvent()
+        self=2E_management_ready=2Eclea=
r()
+        self=2E_response =3D []
+
+        self=2E_response_ready =3D =
asyncio=2EEvent()
+        self=2E_response_ready=2Eclear()
+
+        self=
=2E_send_task =3D asyncio=2Ecreate_task(self=2E_send_loop())
+        self=
=2E_send_queue =3D asyncio=2EQueue()
+        self=2E_connect_data: Connect=
ionProperties =3D connect_data
+
+    @override
+    def eof_received(self)=
:
+        logger=2Einfo('EOF received=2E Shutting down=2E')
+        self=
=2E_stop()
+
+    @override
+    def connection_lost(self, excp):
+        =
if excp:
+            logger=2Einfo(f'Connection lost ({excp})=2E Shutting =
down=2E')
+        else:
+            logger=2Einfo(f'Connection lost=2E Sh=
utting down=2E')
+        self=2E_stop()
+
+    def _stop(self):
+        i=
f not self=2Efinish_future=2Edone():
+            self=2E_send_task=2Ecance=
l()
+            self=2Efinish_future=2Eset_result(True)
+
+    async def _=
send_loop(self):
+        while True:
+            command: OmiSendCommand =
=3D await self=2E_send_queue=2Eget()
+            await self=2E_can_send=2E=
wait()
+            self=2Esend_line(command=2Ecommand)
+
+            resp=
onse =3D []
+            response_complete =3D False
+
+            # This =
is a bit brittle as it will loop forever if not getting a
+            # li=
ne that starts with ERROR or SUCCESS=2E But this is the OMI protocol
+     =
       while not response_complete:
+                await self=2E_response=
_ready=2Ewait()
+
+                line =3D self=2E_response=2Epop(0)
+    =
            response=2Eappend(line)
+
+                if not self=2E_respo=
nse:
+                    self=2E_response_ready=2Eclear()
+
+             =
   lastline =3D response[-1]
+                if lastline=2Estartswith('ERR=
OR:'):
+                    status =3D False
+                    response_=
complete =3D True
+                    _, status_text =3D lastline=2Esplit(=
":", 1)
+
+                elif lastline=2Estartswith('SUCCESS:'):
+       =
             status =3D True
+                    response_complete =3D Tru=
e
+                    _, status_text =3D lastline=2Esplit(":", 1)
+       =
         elif lastline =3D=3D "END":
+                    status =3D True
+=
                    response_complete =3D True
+                    status_=
text =3D None
+                else:
+                    pass
+
+         =
   # logger=2Edebug(f'Result received command: {response}')
+
+            =
result =3D OmiCommandResult(command=2Ecommand, response[:-1], status, statu=
s_text)
+
+            command=2Eresult=2Eset_result(result)
+            l=
ogger=2Edebug(f"Command done=2E")
+
+    @override
+    def pause_writing(s=
elf):
+        self=2E_can_send=2Eclear()
+
+    @override
+    def resume_=
writing(self):
+        self=2E_can_send=2Eset()
+
+    @override
+    def =
connection_made(self, transport):
+        peername =3D transport=2Eget_ext=
ra_info('peername')
+        logging=2Einfo('Connection from {}'=2Eformat(p=
eername))
+        self=2Etransport =3D transport
+        self=2E_can_send=
=2Eset()
+
+        # OMI expects us to authenticate with the password just=
 on
+        # its own on a line
+        if self=2E_connect_data=2Epasswor=
d:
+            self=2Etransport=2Ewrite(f"{self=2E_connect_data=2Epassword=
}\r\n"=2Eencode())
+
+    @override
+    def data_received(self, data):
+  =
      # OMI protocol is pure text so decode everything as UTF-8
+        me=
ssage =3D data=2Edecode()
+        self=2ErecvBuffer +=3D message
+
+      =
  parts =3D self=2ErecvBuffer=2Esplit("\r\n")
+
+        # pass complete li=
nes to recvLine
+        for part in parts[:-1]:
+            logger=2Edebu=
g(f'Line received: {part!r}')
+            self=2Erecv_line(part)
+
+      =
  # keep the last incomplete line for the next call
+        self=2ErecvBuf=
fer =3D parts[-1]
+
+    def recv_line(self, line):
+        if line=2Estar=
tswith(">"):
+            self=2Erecv_notify(line)
+        else:
+        =
    self=2E_response=2Eappend(line)
+            self=2E_response_ready=2Es=
et()
+
+    def recv_notify(self, line):
+        if not ":" in line:
+    =
        logger=2Ewarning("Invalid line received: " + line)
+            ret=
urn
+
+        command, args =3D line[1:]=2Esplit(":", 1)
+
+        # do d=
ynamic dispatch based on command to call a handler
+        if hasattr(self=
, f"recv_notify_{command}"):
+            handler =3D getattr(self, f"recv_=
notify_{command}")
+            handler(args)
+            return
+
+      =
  logger=2Einfo("Unknown notify line received: " + line)
+
+    def recv_no=
tify_INFO(self, args):
+        m =3D re=2Ematch(r"OpenVPN Management Inter=
face Version (?P<version>\d+)", args)
+        if m:
+            self=2Eve=
rsion =3D int(m=2Egroup("version"))
+            self=2E_management_ready=
=2Eset()
+        else:
+            logger=2Ewarning(f"Unknown INFO line r=
eceived: {args}")
+
+    def recv_notify_BYTECOUNT(self, args):
+        by=
tes_sent, bytes_received =3D args=2Esplit(",", 1)
+        self=2Ebytes_sen=
t =3D int(bytes_sent)
+        self=2Ebytes_received =3D int(bytes_received=
)
+
+    async def _release_hold_task(self, hold_time: int =3D 0):
+       =
 await asyncio=2Esleep(hold_time)
+        await self=2Equeue_command("hold=
 release")
+
+    def recv_notify_HOLD(self, args):
+        _text, hold_ti=
me =3D args=2Esplit(":", 1)
+        hold_time =3D int(hold_time)
+
+      =
  asyncio=2Ecreate_task(self=2E_release_hold_task(hold_time))
+
+    def qu=
eue_command(self, command) -> Future[OmiCommandResult]:
+        cmd =3D Om=
iSendCommand(command, Future())
+        self=2E_send_queue=2Eput_nowait(cm=
d)
+        return cmd=2Eresult
+
+    async def management_ready(self) -> =
int:
+        """
+        Waits until the management interface is ready=2E=
 Returns the management interface version=2E
+        """
+        await se=
lf=2E_management_ready=2Ewait()
+        return self=2Eversion
+
+    def s=
end_line(self, line):
+        logger=2Edebug(f"Sending line: {line}")
+   =
     self=2Etransport=2Ewrite(f"{line}\n"=2Eencode())
+
+    """
+    Set t=
he bytecount interval=2E Use 0 to disable
+    """
+
+    async def set_byt=
ecount_interval(self, interval: int):
+        return await self=2Equeue_co=
mmand(f"bytecount {interval}")
+
+    async def enable_log(self):
+        =
return await self=2Equeue_command("log on")
+
+    def recv_notify_LOG(self=
, args):
+        # >LOG:1786453401,D,MANAGEMENT: CMD 'bytecount 30'
+     =
   timestamp, level, message =3D args=2Esplit(",", 2)
+
+        timestamp =
=3D datetime=2Efromtimestamp(int(timestamp))
+        level =3D level=2Estr=
ip()
+        message =3D message=2Estrip()
+        self=2Elog_message(tim=
estamp, level, message)
+
+    def log_message(self, time, level, message):=

+        """
+        A new log message has been received=2E This method i=
s intended
+        to be overridden by a subclass to handle the log messag=
es=2E
+        :param time:    time in local time format
+        :param le=
vel:   level of the log message
+        :param message: the log message it=
self
+        :return:
+        """
+        logger=2Edebug(f"Received log =
message: {time}, {level}, {message}")
+
+
+@dataclass
+class ConnectedClien=
t:
+    cid: int
+    bytes_sent: int =3D 0
+    bytes_received: int =3D 0
=
+
+
+class OMIServerProtocol(OmiProtocol):
+    """
+    This class impleme=
nt common method for the OMI when OpenVPN is running
+    as a server=2E
+ =
   """
+
+    # Connected client class, can be overridden by subclasses to =
store
+    # more information about the connected client
+    _connected_cl=
ient_class =3D ConnectedClient
+
+    def __init__(self, finish_future, con=
nect_data: ConnectionProperties =3D None):
+        super()=2E__init__(fini=
sh_future, connect_data)
+        self=2E_reset_pending_client_event()
+   =
     self=2E_connected_clients =3D {}
+
+    def _reset_pending_client_even=
t(self):
+        self=2E_pending_client_event =3D None
+        self=2E_pe=
nding_client_event_cid =3D -1
+        self=2E_pending_client_event_kid =3D=
 None
+        self=2E_pending_client_event_extra_args =3D None
+        se=
lf=2E_client_env =3D {}
+
+    def recv_notify_CLIENT(self, args: str):
+  =
      event, args =3D args=2Esplit(",", 1)
+
+        if event =3D=3D "ENV"=
:
+            if args =3D=3D "END":
+                # Client environment =
is finished, trigger previous client
+                # event that containe=
d an ENV
+                self=2E_trigger_client_event(self=2E_pending_clie=
nt_event, self=2E_pending_client_event_cid,
+                              =
             self=2E_pending_client_event_kid, self=2E_client_env,
+       =
                                    self=2E_pending_client_event_extra_args=
)
+                self=2E_reset_pending_client_event()
+            else:
=
+                key, value =3D args=2Esplit("=3D", 1)
+                sel=
f=2E_client_env[key] =3D value
+
+        elif event in ("ESTABLISHED", "DI=
SCONNECT"):
+            # This event is followed by a client environment=
=2E Wait for
+            # the client evironment to be completed before tr=
iggering the event
+            cid =3D int(args)
+
+            self=2E_pe=
nding_client_event =3D event
+            self=2E_pending_client_event_cid =
=3D int(cid)
+            self=2E_pending_client_event_kid =3D None
+      =
      if event =3D=3D "ESTABLISHED":
+                self=2E_add_client(ci=
d)
+
+        elif event in ("CONNECT", "REAUTH", "CR_RESPONSE"):
+        =
    # This event is similar to other event but also carries the key-id
+   =
         cid, kid =3D args=2Esplit(",", 1)
+            cid, kid =3D int(ci=
d), int(kid)
+            self=2E_add_client(cid)
+
+            self=2E_pe=
nding_client_event =3D event
+            self=2E_pending_client_event_cid =
=3D int(cid)
+            self=2E_pending_client_event_kid =3D int(kid)
+  =
      elif event in ("ACC",):
+            cid, kid, acc_args =3D args=2Esp=
lit(",", 2)
+            self=2E_trigger_client_event(event, int(cid), int(=
kid), None, acc_args)
+        else:
+            logger=2Edebug(f"Client e=
vent {event} not handled=2E")
+
+    def recv_notify_BYTECOUNT_CLI(self, ar=
gs):
+        cid, bytes_sent, bytes_received =3D args=2Esplit(",", 2)
+
+ =
       client =3D self=2E_connected_clients=2Eget(int(cid))
+        if cli=
ent:
+            client=2Ebytes_sent =3D int(bytes_sent)
+            clie=
nt=2Ebytes_received =3D int(bytes_received)
+
+    def _trigger_client_even=
t(self, event, cid, kid, env, extra):
+        handler_name =3D f"client_ev=
ent_{event}"
+        if hasattr(self, handler_name):
+            handler =
=3D getattr(self, handler_name)
+            client =3D self=2E_connected_c=
lients=2Eget(cid, None)
+            handler(client, kid, env, extra)
+    =
    else:
+            logger=2Edebug(f"Client event {event} not handled=2E=
 Method {handler_name} does not exist=2E")
+
+    def _add_client(self, cid=
):
+        if not cid in self=2E_connected_clients:
+            self=2E_c=
onnected_clients[cid] =3D self=2E_connected_client_class(cid =3D cid)
+
+  =
  def _remove_client(self, cid):
+        del self=2E_connected_clients[cid=
]
+
+    async def get_client_status(self) -> OmiCommandResult:
+        cm=
d_result =3D self=2Equeue_command("status 3")
+        return await cmd_res=
ult
diff --git a/sample/management/omi_tools=2Epy b/sample/management/omi_t=
ools=2Epy
new file mode 100644
index 0000000=2E=2Eafa0e46
--- /dev/null
+++=
 b/sample/management/omi_tools=2Epy
@@ -0,0 +1,93 @@
+#! /usr/bin/python3
+=
# Copyright (c) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+# Copyright (c) 202=
6 Arne Schwabe <arne@rfc2549=2Eorg>
+#
+# Permission is hereby granted, fre=
e of charge, to any person obtaining a copy
+# of this software and associa=
ted documentation files (the "Software"), to deal
+# in the Software withou=
t restriction, including without limitation the rights
+# to use, copy, mod=
ify, merge, publish, distribute, sublicense, and/or sell
+# copies of the S=
oftware, and to permit persons to whom the Software is
+# furnished to do s=
o, subject to the following conditions:
+#
+# The above copyright notice an=
d this permission notice shall be included in all
+# copies or substantial =
portions of the Software=2E
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT=
 WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO =
THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND =
NONINFRINGEMENT=2E IN NO EVENT SHALL THE
+# AUTHORS OR COPYRIGHT HOLDERS BE=
 LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION =
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+# OUT OF OR IN CONNECTION WI=
TH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+# SOFTWARE=2E
+import =
asyncio
+import os
+import sys
+from dataclasses import dataclass
+
+from o=
mi import OmiProtocol, ConnectionProperties
+
+
+@dataclass
+class ConnectD=
ata(ConnectionProperties):
+    socket: str
+
+
+def get_unix_script_enviro=
nment() -> ConnectData | None:
+    password =3D os=2Eenviron=2Eget("MANAGE=
MENT_PASSWORD", None)
+    socket =3D os=2Eenviron=2Eget("MANAGEMENT_SOCKET=
", None)
+
+    if password and socket:
+        return ConnectData(passwor=
d=3Dpassword, socket=3Dsocket)
+    else:
+        return None
+
+
+async d=
ef start_management_protocol(connect_data: ConnectData, protocol=3DOmiProto=
col):
+    # Get a reference to the event loop as we plan to use
+    # low=
-level APIs=2E
+    loop =3D asyncio=2Eget_running_loop()
+
+    finish_fut=
ure =3D loop=2Ecreate_future()
+
+    print(f"Connecting to management sock=
et {connect_data=2Esocket} with passwd {connect_data=2Epassword[:4]}=2E=2E=
=2E")
+    transport, protocol =3D await loop=2Ecreate_unix_connection(lamb=
da: protocol(finish_future, connect_data),
+                               =
                             connect_data=2Esocket)
+
+    return transport=
, protocol, finish_future
+
+
+async def main():
+    transport, protocol, =
finish_future =3D await start_management_protocol()
+
+    management_versi=
on =3D await protocol=2Emanagement_ready()
+    await protocol=2Eenable_log=
()
+    print(f"Management interface version: {management_version}")
+
+   =
 await protocol=2Eset_bytecount_interval(5)
+
+    await finish_future
+
+
=
+def run_main(main_func, connect_parameters: ConnectData =3D None):
+    ""=
"
+    Example function to run a main function to be either using the
+    =
environment variable for the unix-script or to use=2E If the unix-script
+ =
   environment are detected, the function will fork and run the main_func
+=
    with the ConnectData from the environment=2E If the environment variabl=
es
+    are not available, it will not fork will fall back to the connect_p=
arameters
+    if present=2E
+    :param connect_parameters:  fallback conn=
ect parameters if unix-script is not available
+    :param main_func:      =
     The function to call=2E
+    :return:
+    """
+    unix_script_parame=
ters =3D get_unix_script_environment()
+    if unix_script_parameters:
+   =
     asyncio=2Erun(main_func(unix_script_parameters))
+    elif connect_par=
ameters:
+        asyncio=2Erun(main_func(connect_parameters))
+    else:
+=
        print(f"Must be called via unix-script")
+
+
+if __name__ =3D=3D '_=
_main__':
+    run_main(main)

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1859?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5
Gerrit-Change-Number=
: 1859
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--nTp7E02q0+4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Add python scripts that demonstrate using the mangement interface<=
br><br>Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5<br>Signed-off-b=
y: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>A sample/management/ac=
c_sysinfo_client_demo=2Epy<br>A sample/management/acc_sysinfo_server_demo=
=2Epy<br>A sample/management/omi=2Epy<br>A sample/management/omi_tools=2Epy=
<br>4 files changed, 774 insertions(+), 0 deletions(-)<br><br></pre><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/59/=
1859/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/sample/management/acc_sysinfo_client_demo=2Epy =
b/sample/management/acc_sysinfo_client_demo=2Epy</span><br><span>new file m=
ode 100755</span><br><span>index 0000000=2E=2E7a7f015</span><br><span>--- /=
dev/null</span><br><span>+++ b/sample/management/acc_sysinfo_client_demo=2E=
py</span><br><span>@@ -0,0 +1,174 @@</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#!/opt/homebrew/bin/python3</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+# Copyright (c) 2026 OpenVPN Inc &lt;sales@openvpn=
=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Copyrig=
ht (c) 2026 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# Permission is hereby granted, free of charge, to any pers=
on obtaining a copy</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
# of this software and associated documentation files (the &quot;Software&q=
uot;), to deal</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# in =
the Software without restriction, including without limitation the rights</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# to use, copy, modif=
y, merge, publish, distribute, sublicense, and/or sell</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+# copies of the Software, and to permit =
persons to whom the Software is</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# furnished to do so, subject to the following conditions:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# The above copyright notice and this per=
mission notice shall be included in all</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# copies or substantial portions of the Software=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# THE SOFTWARE IS PROVIDED &quot;AS IS&qu=
ot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRA=
NTIES OF MERCHANTABILITY,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT=
 SHALL THE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# AUTHORS=
 OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# LIABILITY, WHETHER IN AN ACTI=
ON OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR=
 THE USE OR OTHER DEALINGS IN THE</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+# SOFTWARE=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# This impl=
ement a small demonstration of using the</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+# OpenVPN Access Server Management Interface (OMI) and=
 an app Custom Control</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+# protocol (info_sample) to retrieve a number of system information from=
 the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# client and pu=
sh them to the server=2E To use this use on the server</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# --app-custom-control info_sample</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+# --management /path/to/acc_sysinfo_server_d=
emo=2Epy unix-script</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# and on the clien=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# --app-custom-con=
trol info_sample</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# -=
-management /path/to/acc_sysinfo_client_demo=2Epy unix-script</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+# Note this is just a demonstration and not a produc=
tion-ready solution=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+# When modifying this code, keep the security in mind=2E It is easy to</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# introduce a securit=
y problem when executing commands on the client=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+import asyncio</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+import base64</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+import json</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import =
logging</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import os</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+import platform</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+import socket</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+import subprocess</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+from omi import OmiProtocol</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+from omi_tools import run_main, start_managem=
ent_protocol, ConnectData</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+logger =3D lo=
gging=2EgetLogger(__name__)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+logger=2EsetLevel(logging=2EDEBUG)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+class OmiSysInf=
oClientProtocol(OmiProtocol):</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    def __init__(self, finish_future, connect_data: ConnectData):=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        super()=2E_=
_init__(finish_future, connect_data)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        self=2E_acc_msg =3D &quot;&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    def recv_notify_ACC(self, args):</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        protocol, fragment, b64msg =3D =
args=2Esplit(&quot;,&quot;, 2)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if protocol !=3D &quot;sys_info&quot;:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            logging=2Einfo(f&quot;Rec=
eived unknown ACC protocol: {protocol}&quot;)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            return</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        msg =3D base64=2Edecodebytes(b64msg=2Eencode())</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        self=2E_acc_msg +=3D msg=
=2Edecode()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        # Message is not ye=
t complete=2E Wait for more fragments=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if fragment !=3D &quot;0&quot;:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            return</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        try:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            self=2Eparse_sysinfo_message(self=2E_acc_msg)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        except Exceptio=
n as e:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
logging=2Eerror(f&quot;Error parsing ACC message: {e}&quot;, exc_info=3DTru=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_a=
cc_msg =3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def parse_s=
ysinfo_message(self, accmsg):</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        msg =3D json=2Eloads(accmsg)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        logging=2Einfo(f&quot;Received sys_info message: {accmsg}&q=
uot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        asyncio=2Ecreate_task(sel=
f=2Esend_info_response(msg))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    async =
def send_info_response(self, msg):</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        response =3D {}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if msg=2Eget(&quot;uname&quot;, False):</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            response[&#39;un=
ame&#39;] =3D platform=2Euname()=2E_asdict()</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if msg=2Eget(&quot;username&quot;, False):</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            response[&#39;username&#39=
;] =3D os=2Egetlogin()</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if msg=
=2Eget(&quot;hostname&quot;, False):</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            response[&#39;hostname&#39;] =3D platform=2Eno=
de()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if msg=2Eget(&quot;dns-goo=
gle=2Ecom&quot;, False):</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            try:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                addrs =3D [x[4][0] for x in socket=2Egetaddrinfo(&#39;goo=
gle=2Ecom&#39;, 443)]</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                response[&quot;dns-google=2Ecom&quot;] =3D addrs</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            except Exception as e:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                logging=2Eerror(=
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
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        # TODO impleme=
nt fragmentation</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg =3D json=
=2Edumps(response)=2Eencode()</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        # 980 chars after base64 encoding</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        fragment_length =3D 980*6//8</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        for part_start in range(0, len(ms=
g), fragment_length):</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg_p=
art =3D msg[part_start:part_start + fragment_length]</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            b64msg =3D base64=2Eencodebyt=
es(msg_part)=2Edecode()</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            pro=
tocol =3D &quot;sys_info&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    flags =3D &quot;6&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            if part_start + fragment_length &lt; len(msg):</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                flags =3D &q=
uot;6:F&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            command =3D f=
&quot;acc-msg\n{protocol}\n{flags}\n{b64msg}\nEND&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            self=2Equeue_command(comman=
d)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    async def get_routes(self, v6):<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if platform=
=2Esystem() =3D=3D &#39;linux&#39;:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            cmd =3D &#39;/usr/sbin/ip&#39;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            if v6:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                args =3D [&#39;-6&#39=
;, &#39;route&#39;, &#39;show&#39;]</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            else:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                args =3D [&#39;-4&#39;, &#39;route&#39;, &#39=
;show&#39;]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
elif platform=2Esystem() =3D=3D &#39;Darwin&#39; or os=2Eplatform() =3D=3D =
&#39;FreeBSD&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           # FreeBSD and macOS</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            if os=2Epath=2Eexists(&#39;/usr/sbin/netstat&#39;):<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                cmd =
=3D &#39;/usr/sbin/netstat&#39;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            else:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                cmd =3D &#39;/usr/bin/netstat&#39;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            if v6:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                args =3D [ &#39;-f&#39;, &#39;inet6&#3=
9;, &#39;-rn&#39;]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           else:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                args =
=3D [ &#39;-f&#39;, &#39;inet&#39;, &#39;-rn&#39;]</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        else:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            return &quot;Unsupported platform&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        proc =3D await asyncio=2Esubp=
rocess=2Ecreate_subprocess_exec(cmd, *args, stdout=3Dsubprocess=2EPIPE)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        output, _ =3D a=
wait proc=2Ecommunicate()</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return output=2Edecode()</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+async def main(conn=
ect_data: ConnectData):</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    transport, protocol, finish_future =3D await start_management_proto=
col(connect_data, OmiSysInfoClientProtocol)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    while True:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        await asyncio=2Esleep(1)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        print(&quot;=2E&quot;, end=3D&quo=
t;&quot;, flush=3DTrue)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    management_=
version =3D await protocol=2Emanagement_ready()</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    print(f&quot;Management interface version: =
{management_version}&quot;)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    await p=
rotocol=2Eset_bytecount_interval(5)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 await finish_future</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+if __name__ =3D=3D &#39;__main__&#39;=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    run_main(main)=
</span><br><span>diff --git a/sample/management/acc_sysinfo_server_demo=2Ep=
y b/sample/management/acc_sysinfo_server_demo=2Epy</span><br><span>new file=
 mode 100755</span><br><span>index 0000000=2E=2E139d2f9</span><br><span>---=
 /dev/null</span><br><span>+++ b/sample/management/acc_sysinfo_server_demo=
=2Epy</span><br><span>@@ -0,0 +1,135 @@</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#!/opt/homebrew/bin/python3</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+# Copyright (c) 2026 OpenVPN Inc &lt;sales@open=
vpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Copy=
right (c) 2026 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# Permission is hereby granted, free of charge, to any per=
son obtaining a copy</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# of this software and associated documentation files (the &quot;Software&=
quot;), to deal</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# in=
 the Software without restriction, including without limitation the rights<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+# to use, copy, modi=
fy, merge, publish, distribute, sublicense, and/or sell</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+# copies of the Software, and to permit=
 persons to whom the Software is</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+# furnished to do so, subject to the following conditions:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# The above copyright notice and this per=
mission notice shall be included in all</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# copies or substantial portions of the Software=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# THE SOFTWARE IS PROVIDED &quot;AS IS&qu=
ot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRA=
NTIES OF MERCHANTABILITY,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT=
 SHALL THE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# AUTHORS=
 OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# LIABILITY, WHETHER IN AN ACTI=
ON OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR=
 THE USE OR OTHER DEALINGS IN THE</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+# SOFTWARE=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+import asyncio</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+# This implement a small demonstration of using the</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+# OpenVPN Access Server Management Inter=
face (OMI) and an app Custom Control</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# protocol (info_sample) to retrieve a number of system in=
formation from the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
 client and push them to the server=2E To use this use on the server</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+# --app-custom-control info_sample</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# --management /path/to/acc_sy=
sinfo_server_demo=2Epy unix-script</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# an=
d on the client</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# --=
app-custom-control info_sample</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+# --management /path/to/acc_sysinfo_client_demo=2Epy unix-script=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+import base64</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+import json</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+import logging</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+import random</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+from pprint import pprint, pformat</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+from omi import OMIServerProtocol, ConnectedClient</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+from omi_tools import run_main, star=
t_management_protocol, ConnectData</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+logg=
er =3D logging=2EgetLogger(__name__)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+logger=2EsetLevel(logging=2EINFO)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+class SysInoConnectedClient(ConnectedClient):</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    accmsg =3D &quot;&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+class OMISysInfoServerProtocol(OMIServerProtocol=
):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def __init__(=
self, finish_future, connect_data: ConnectData =3D None):</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        super()=2E__init__(finish_fut=
ure, connect_data)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       self=2Eaccmsg =3D &quot;&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        self=2E_connected_client_class =3D SysInoConnecte=
dClient</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    def client_event_ACC(self,client, kid, env, ex=
tra):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        protoc=
ol, fragment, b64msg =3D extra=2Esplit(&quot;,&quot;, 2)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if protocol !=3D &quot;sys_inf=
o&quot;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 logging=2Einfo(f&quot;Received unknown ACC protocol: {protocol}&quot;)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            return</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        try:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            msg =3D base64=2Edecodebytes(b64msg=2Eencode())</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            client=2Eaccmsg=
 +=3D msg=2Edecode()</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            # Mess=
age is not yet complete=2E Wait for more fragments=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if fragment !=3D &quot;0&quot=
;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                r=
eturn</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            self=2Eparse_sys_info=
_reply(client=2Eaccmsg)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            client=2Eaccmsg =3D &quot;&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        except Exception as e:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            logger=2Eerror(f&quot;Error parsing sys_in=
fo message: {e}&quot;, exc_info=3DTrue)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    def parse_sys_info_reply(self, accmsg):</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        logger=2Edebug(f&quot;Received sys_info me=
ssage: {accmsg!r}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        client_info =3D json=2Eloads(accmsg)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        logger=2Einfo(f&quot;Received sys_info response: {pforma=
t(client_info)}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def client_e=
vent_ESTABLISHED(self, client, kid, env, extra):</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        print(f&quot;CLient connected: {client=
}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ppr=
int(env)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        # TODO: track kid and =
don&#39;t assume we haven&#39;t done a renegotiation</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        kid =3D 1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        asyncio=2Ecreate_task(self=2E_sen=
d_sys_info_command(client=2Ecid, kid))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    def client_event_CONNECT(self, client, kid, env, extra):</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        print(f&quot;Authenticatin=
g client {client=2Ecid}, {kid}&quot;)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        self=2Equeue_command(f&quot;client-auth-nt {clien=
t=2Ecid} {kid}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    async def _se=
nd_sys_info_command(self, cid, kid):</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        # Give the client some time to settle its routes</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        await asyncio=
=2Esleep(5)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        info =3D [&quot;rou=
te&quot;, &quot;route6&quot;, &quot;dns-google=2Ecom&quot;, &quot;username&=
quot;, &quot;hostname&quot;, &quot;uname&quot;]</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        # Pick 3 random infos from the client</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        infos =3D random=2Echoices(info,=
 k=3D3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        requ=
est =3D {k: True for k in infos}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  for i in info:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         request =3D {i: True}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            req_str =3D json=2Edumps(request)=2Eencode()</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            logger=2Einfo(f&quot;Sending sysin=
fo request for client {cid} with infos: {infos}&quot;)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            req_base64 =3D base64=2Eencodebytes(req_str)=2E=
decode()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 acc_protocol =3D &quot;sys_info&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            # TODO: Implement fragmentation</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            cmd =3D f&quot;client-acc-msg {cid} {ki=
d}\n{acc_protocol}\n6\n{req_base64}\nEND&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            await self=2Equeue_command(cmd)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+asyn=
c def main(connect_data: ConnectData):</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    transport, protocol, finish_future =3D await start_m=
anagement_protocol(connect_data, OMISysInfoServerProtocol)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    management_version =3D await protocol=2Emanagement_=
ready()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    print(f&=
quot;Management interface version: {management_version}&quot;)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    await protocol=2Eenable_log()</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    await protocol=2Eset_bytecount_interval(5)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    await finish_future</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if __na=
me__ =3D=3D &#39;__main__&#39;:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    run_main(main)</span><br><span>diff --git a/sample/manageme=
nt/omi=2Epy b/sample/management/omi=2Epy</span><br><span>new file mode 1006=
44</span><br><span>index 0000000=2E=2E2a7f90e</span><br><span>--- /dev/null=
</span><br><span>+++ b/sample/management/omi=2Epy</span><br><span>@@ -0,0 +=
1,372 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#!/opt/home=
brew/bin/python3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# C=
opyright (c) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+# Copyright (c) 2026 Arne Schwabe &lt=
;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Permission i=
s hereby granted, free of charge, to any person obtaining a copy</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# of this software and associa=
ted documentation files (the &quot;Software&quot;), to deal</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+# in the Software without restricti=
on, including without limitation the rights</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+# to use, copy, modify, merge, publish, distribute,=
 sublicense, and/or sell</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+# copies of the Software, and to permit persons to whom the Software i=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# furnished to do =
so, subject to the following conditions:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+# The above copyright notice and this permission notice shall be include=
d in all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# copies or=
 substantial portions of the Software=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+# THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KI=
ND, EXPRESS OR</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# IMP=
LIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+# FITNESS FOR A PARTICULA=
R PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE=
 FOR ANY CLAIM, DAMAGES OR OTHER</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE, ARISING FROM,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN T=
HE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# SOFTWARE=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# This is an example implementation in py=
thon and asyncio to drive OpenVPN&#39;s</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# management interface (OMI)=2E The permissive license =
allows you to use this</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+# code in other projects=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+&quot;&q=
uot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Implement=
ation of the OpenVPN management interface (OMI) protocol=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+&quot;&quot;&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+import asyncio</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+import logging</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+import re</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+from asyncio import Future</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+from dataclasses import dataclass</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+from datetime import datetime</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+from typing import overri=
de, List</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+logger =3D logging=2EgetLogger=
(__name__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+logger=2E=
setLevel(logging=2EINFO)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+@dataclass</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+class OmiCommandResult:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    command: str</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    result: List[str]</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    error: bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    status_text: str</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+@da=
taclass</span><br><span style=3D"color: hsl(120, 100%, 40%);">+class OmiSen=
dCommand:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    comman=
d: str</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    result: F=
uture[OmiCommandResult]</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+@dataclass</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+class ConnectionProperties:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    Properties for connecting =
to the management interface=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    password: str</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+class OmiProtocol(asyncio=
=2EProtocol):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    de=
f __init__(self, finish_future, connect_data: ConnectionProperties):</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        super()=2E__init__=
()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2Eby=
tes_received =3D None</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        self=2Ebytes_sent =3D None</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        self=2Eversion =3D -1</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        self=2ErecvBuffer =3D &quot;&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2Efinish_fut=
ure =3D finish_future</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        self=2E_can_send =3D asyncio=2EEvent()</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        self=2E_can_send=2Eclear()</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        self=2E_management_ready =3D asyncio=2EEve=
nt()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E=
_management_ready=2Eclear()</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        self=2E_response =3D []</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        self=2E_response_ready =3D asyncio=2EEvent()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        self=2E_response_ready=2Eclear()<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        self=2E_send_task =3D asyncio=
=2Ecreate_task(self=2E_send_loop())</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        self=2E_send_queue =3D asyncio=2EQueue()</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_connect_data: =
ConnectionProperties =3D connect_data</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   @override</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def=
 eof_received(self):</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        logger=2Einfo(&#39;EOF received=2E Shutting down=2E&#39;)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_stop()</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    @override</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    def connection_lost(self, excp):</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if excp:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            logger=2Einfo(f&#39;Conn=
ection lost ({excp})=2E Shutting down=2E&#39;)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        else:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            logger=2Einfo(f&#39;Connection lost=2E Shu=
tting down=2E&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        self=2E_stop()</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def _stop(se=
lf):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if not =
self=2Efinish_future=2Edone():</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            self=2E_send_task=2Ecancel()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            self=2Efinish_future=2Eset_re=
sult(True)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    async def _send_loop(sel=
f):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        while Tr=
ue:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            comm=
and: OmiSendCommand =3D await self=2E_send_queue=2Eget()</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            await self=2E_can_send=2Ew=
ait()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            se=
lf=2Esend_line(command=2Ecommand)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       response =3D []</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            response_complete =3D False</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            # This is a bit brittle as it will loop forever if not gett=
ing a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            # =
line that starts with ERROR or SUCCESS=2E But this is the OMI protocol</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            while not re=
sponse_complete:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             await self=2E_response_ready=2Ewait()</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                line =3D self=2E_response=2Epop(0)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                response=2Eappen=
d(line)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                if not self=2E_=
response:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
          self=2E_response_ready=2Eclear()</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                lastline =3D response[-1]</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                if lastline=2Estartswith(&#39;ERR=
OR:&#39;):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           status =3D False</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                    response_complete =3D True</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                    _, status_text =3D l=
astline=2Esplit(&quot;:&quot;, 1)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           elif lastline=2Estartswith(&#39;SUCCESS:&#39;):</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    status =3D True<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
response_complete =3D True</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    _, status_text =3D lastline=2Esplit(&quot;:&quot=
;, 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  elif lastline =3D=3D &quot;END&quot;:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    status =3D True</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    response_complete =
=3D True</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         status_text =3D None</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                else:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    pass</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          # logger=2Edebug(f&#39;Result received command: {response}&#39;)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            result =3D OmiCommandResult=
(command=2Ecommand, response[:-1], status, status_text)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            command=2Eresult=2Eset_result(result)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            logger=2Edebug(f=
&quot;Command done=2E&quot;)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    @overr=
ide</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def pause_wr=
iting(self):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 self=2E_can_send=2Eclear()</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    @overri=
de</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def resume_wr=
iting(self):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 self=2E_can_send=2Eset()</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    @override=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def connection_=
made(self, transport):</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        peername =3D transport=2Eget_extra_info(&#39;peername&#39;)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        logging=2Einfo(&=
#39;Connection from {}&#39;=2Eformat(peername))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        self=2Etransport =3D transport</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_can_send=2Es=
et()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        # OMI expects us to authen=
ticate with the password just on</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        # its own on a line</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if self=2E_connect_data=2Epassword:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            self=2Etransport=
=2Ewrite(f&quot;{self=2E_connect_data=2Epassword}\r\n&quot;=2Eencode())</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    @override</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    def data_received(self, data):</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        # OMI protocol is pure t=
ext so decode everything as UTF-8</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        message =3D data=2Edecode()</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        self=2ErecvBuffer +=3D message</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        parts =3D self=2ErecvBuffer=2Esplit(&=
quot;\r\n&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        # pass complet=
e lines to recvLine</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        for part in parts[:-1]:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            logger=2Edebug(f&#39;Line received: {part!r}&#39;)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            self=2Er=
ecv_line(part)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        # keep the last =
incomplete line for the next call</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        self=2ErecvBuffer =3D parts[-1]</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    def recv_line(self, line):</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if line=2Estartswith(&quot;&gt;&quot;):</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            self=2Ere=
cv_notify(line)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    else:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  self=2E_response=2Eappend(line)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            self=2E_response_ready=2Eset()</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    def recv_notify(self, line):</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if not &quot;:&quot; in line:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            logger=2Ewarni=
ng(&quot;Invalid line received: &quot; + line)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            return</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        command, args =3D line[1:]=2Esplit(&quot;:&quot;, 1)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        # do dynamic dispatch based on command=
 to call a handler</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if hasattr(self, f&quot;recv_notify_{command}&quot;):</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            handler =3D getattr(se=
lf, f&quot;recv_notify_{command}&quot;)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            handler(args)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            return</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        logger=2Einfo(&quot;Unknown notify line received: &quot; + li=
ne)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    def recv_notify_INFO(self, args=
):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m =3D re=
=2Ematch(r&quot;OpenVPN Management Interface Version (?P&lt;version&gt;\d+)=
&quot;, args)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if m:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
self=2Eversion =3D int(m=2Egroup(&quot;version&quot;))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            self=2E_management_ready=2Es=
et()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            logger=2E=
warning(f&quot;Unknown INFO line received: {args}&quot;)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    def recv_notify_BYTECOUNT(self, args):</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        bytes_sent, bytes_received=
 =3D args=2Esplit(&quot;,&quot;, 1)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        self=2Ebytes_sent =3D int(bytes_sent)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        self=2Ebytes_received =3D=
 int(bytes_received)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    async def _rel=
ease_hold_task(self, hold_time: int =3D 0):</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        await asyncio=2Esleep(hold_time)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        await self=2Equeue_com=
mand(&quot;hold release&quot;)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def =
recv_notify_HOLD(self, args):</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        _text, hold_time =3D args=2Esplit(&quot;:&quot;, 1)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        hold_time =3D int=
(hold_time)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        asyncio=2Ecreate_ta=
sk(self=2E_release_hold_task(hold_time))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    def queue_command(self, command) -&gt; Future[OmiCommandResult]:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmd =3D OmiSendC=
ommand(command, Future())</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        self=2E_send_queue=2Eput_nowait(cmd)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return cmd=2Eresult</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    async def management_ready(self) -&gt; int:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;&quot;&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Waits until =
the management interface is ready=2E Returns the management interface versi=
on=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;=
&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 await self=2E_management_ready=2Ewait()</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return self=2Eversion</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    def send_line(self, line):</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        logger=2Edebug(f&quot;Sending line: {line}&q=
uot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=
=2Etransport=2Ewrite(f&quot;{line}\n&quot;=2Eencode())</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    &quot;&quot;&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    Set the bytecount interval=2E Use 0 to disable</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    async def set_bytecount_interval(self=
, interval: int):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return await self=2Equeue_command(f&quot;bytecount {interval}&quot;)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    async def enable_log(self):</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return await self=
=2Equeue_command(&quot;log on&quot;)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  def recv_notify_LOG(self, args):</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        # &gt;LOG:1786453401,D,MANAGEMENT: CMD &#39;bytecoun=
t 30&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ti=
mestamp, level, message =3D args=2Esplit(&quot;,&quot;, 2)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        timestamp =3D datetime=2Efromtimestamp(int(time=
stamp))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        leve=
l =3D level=2Estrip()</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        message =3D message=2Estrip()</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        self=2Elog_message(timestamp, level, message)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    def log_message(self, time, level, m=
essage):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &qu=
ot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    A new log message has been received=2E This method is intended</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        to be overridden by =
a subclass to handle the log messages=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        :param time:    time in local time format</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        :param level:   =
level of the log message</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        :param message: the log message itself</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        :return:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        &quot;&quot;&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        logger=2Edebug(f&quot;Receive=
d log message: {time}, {level}, {message}&quot;)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+@dataclas=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+class ConnectedCli=
ent:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cid: int</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    bytes_sent: int =
=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bytes_rece=
ived: int =3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+class OMIServerProtocol(OmiProtocol):</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    This class imple=
ment common method for the OMI when OpenVPN is running</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    as a server=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    # Connected client class, can be overridden by subcla=
sses to store</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # =
more information about the connected client</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    _connected_client_class =3D ConnectedClient</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    def __init__(self, finish_future, con=
nect_data: ConnectionProperties =3D None):</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        super()=2E__init__(finish_future, connect_da=
ta)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_=
reset_pending_client_event()</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        self=2E_connected_clients =3D {}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    def _reset_pending_client_event(self):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        self=2E_pending_client_event =3D =
None</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E=
_pending_client_event_cid =3D -1</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        self=2E_pending_client_event_kid =3D None</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        self=2E_pending_client_e=
vent_extra_args =3D None</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        self=2E_client_env =3D {}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    def recv_notify_CLIENT(self, args: str):</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        event, args =3D args=2Esplit(&quot;,&quot;=
, 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if event =3D=3D &quot;ENV&=
quot;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
f args =3D=3D &quot;END&quot;:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                # Client environment is finished, trigger previo=
us client</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      # event that contained an ENV</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                self=2E_trigger_client_event(self=2E_pendin=
g_client_event, self=2E_pending_client_event_cid,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                           se=
lf=2E_pending_client_event_kid, self=2E_client_env,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
  self=2E_pending_client_event_extra_args)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                self=2E_reset_pending_client_event()=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            else:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                key, =
value =3D args=2Esplit(&quot;=3D&quot;, 1)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                self=2E_client_env[key] =3D value</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        elif event in (&quot;ESTABLISHED&=
quot;, &quot;DISCONNECT&quot;):</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            # This event is followed by a client environment=2E=
 Wait for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  # the client evironment to be completed before triggering the event</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            cid =3D int(a=
rgs)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            self=2E_pending_client=
_event =3D event</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         self=2E_pending_client_event_cid =3D int(cid)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            self=2E_pending_client_event=
_kid =3D None</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      if event =3D=3D &quot;ESTABLISHED&quot;:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                self=2E_add_client(cid)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        elif event in (&quot;CONNECT&quot;, &qu=
ot;REAUTH&quot;, &quot;CR_RESPONSE&quot;):</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            # This event is similar to other event b=
ut also carries the key-id</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            cid, kid =3D args=2Esplit(&quot;,&quot;, 1)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            cid, kid =3D int(cid=
), int(kid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    self=2E_add_client(cid)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 self=2E_pending_client_event =3D event</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            self=2E_pending_client_event_cid =3D int(ci=
d)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            self=
=2E_pending_client_event_kid =3D int(kid)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        elif event in (&quot;ACC&quot;,):</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            cid, kid, acc_args =
=3D args=2Esplit(&quot;,&quot;, 2)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            self=2E_trigger_client_event(event, int(cid), in=
t(kid), None, acc_args)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        else:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          logger=2Edebug(f&quot;Client event {event} not handled=2E&quot;)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    def recv_notify_BYTECOUNT_CLI(self,=
 args):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cid,=
 bytes_sent, bytes_received =3D args=2Esplit(&quot;,&quot;, 2)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        client =3D self=2E_connected_clients=2Eget(=
int(cid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 client:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 client=2Ebytes_sent =3D int(bytes_sent)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            client=2Ebytes_received =3D int(bytes_rece=
ived)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    def _trigger_client_event(sel=
f, event, cid, kid, env, extra):</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        handler_name =3D f&quot;client_event_{event}&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if hasattr(self=
, handler_name):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         handler =3D getattr(self, handler_name)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            client =3D self=2E_connected_clien=
ts=2Eget(cid, None)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            handler(client, kid, env, extra)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        else:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            logger=2Edebug(f&quot;Client event {event} n=
ot handled=2E Method {handler_name} does not exist=2E&quot;)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    def _add_client(self, cid):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if not cid in self=2E_connected_c=
lients:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
self=2E_connected_clients[cid] =3D self=2E_connected_client_class(cid =3D c=
id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    def _remove_client(self, cid):<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        del self=2E_=
connected_clients[cid]</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    async def ge=
t_client_status(self) -&gt; OmiCommandResult:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        cmd_result =3D self=2Equeue_command(&quot=
;status 3&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return await cmd_result</span><br><span>diff --git a/sample/management=
/omi_tools=2Epy b/sample/management/omi_tools=2Epy</span><br><span>new file=
 mode 100644</span><br><span>index 0000000=2E=2Eafa0e46</span><br><span>---=
 /dev/null</span><br><span>+++ b/sample/management/omi_tools=2Epy</span><br=
><span>@@ -0,0 +1,93 @@</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#! /usr/bin/python3</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# Copyright (c) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# Copyright (c) 2026 Arne Schw=
abe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Permi=
ssion is hereby granted, free of charge, to any person obtaining a copy</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+# of this software and =
associated documentation files (the &quot;Software&quot;), to deal</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# in the Software without re=
striction, including without limitation the rights</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+# to use, copy, modify, merge, publish, dist=
ribute, sublicense, and/or sell</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# copies of the Software, and to permit persons to whom the Sof=
tware is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# furnished=
 to do so, subject to the following conditions:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+# The above copyright notice and this permission notice shall be =
included in all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# co=
pies or substantial portions of the Software=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+# THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF=
 ANY KIND, EXPRESS OR</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# FITNESS FOR A PA=
RTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+# AUTHORS OR COPYRIGHT HOLDERS BE=
 LIABLE FOR ANY CLAIM, DAMAGES OR OTHER</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR =
OTHERWISE, ARISING FROM,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALIN=
GS IN THE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# SOFTWARE=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import asyncio</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+import os</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+import sys</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+from dataclasses import dataclass</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+from omi import OmiProtocol, ConnectionProper=
ties</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+@dataclass</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+class ConnectData(ConnectionProperties):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    socket: str</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+def get_=
unix_script_environment() -&gt; ConnectData | None:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    password =3D os=2Eenviron=2Eget(&quot=
;MANAGEMENT_PASSWORD&quot;, None)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    socket =3D os=2Eenviron=2Eget(&quot;MANAGEMENT_SOCKET&quo=
t;, None)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if password and socket:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return Connec=
tData(password=3Dpassword, socket=3Dsocket)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return None</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+async def start_manageme=
nt_protocol(connect_data: ConnectData, protocol=3DOmiProtocol):</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    # Get a reference to the ev=
ent loop as we plan to use</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    # low-level APIs=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    loop =3D asyncio=2Eget_running_loop()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    finish_future =3D loop=2Ecreate_future()</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    print(f&quot;Connecting to management socket {conn=
ect_data=2Esocket} with passwd {connect_data=2Epassword[:4]}=2E=2E=2E&quot;=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    transport, pro=
tocol =3D await loop=2Ecreate_unix_connection(lambda: protocol(finish_futur=
e, connect_data),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                                                          connect_data=2Eso=
cket)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return transport, protocol, f=
inish_future</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+async def main():</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    transport, protocol, finish_future =3D awai=
t start_management_protocol()</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    manag=
ement_version =3D await protocol=2Emanagement_ready()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    await protocol=2Eenable_log()</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    print(f&quot;Management=
 interface version: {management_version}&quot;)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    await protocol=2Eset_bytecount_interval(5)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    await finish_future</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+def run_main(main=
_func, connect_parameters: ConnectData =3D None):</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    Example function to run a main functi=
on to be either using the</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    environment variable for the unix-script or to use=2E If the unix=
-script</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    environm=
ent are detected, the function will fork and run the main_func</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    with the ConnectData from th=
e environment=2E If the environment variables</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    are not available, it will not fork will fall=
 back to the connect_parameters</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if present=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    :param connect_parameters:  fallback connect parameters if un=
ix-script is not available</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    :param main_func:           The function to call=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    :return:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    unix_script_parameters =3D get_u=
nix_script_environment()</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if unix_script_parameters:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        asyncio=2Erun(main_func(unix_script_parameters))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    elif connect_param=
eters:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        async=
io=2Erun(main_func(connect_parameters))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        print(f&quot;Must be called via unix-script&quot;)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+if __name__ =3D=3D &#39;__main__&#39;:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    run_main(main)</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1859?usp=3Demail">change 1859</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1859?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5 <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 1859 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none=
"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>

</body></html>
--nTp7E02q0+4=--


--===============6059879059053732170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6059879059053732170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6059879059053732170==--

