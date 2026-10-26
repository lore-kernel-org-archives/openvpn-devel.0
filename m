Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACB1606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 19:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gOgd+o4t;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=S2UZ084M;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YoK41trC;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RsUTHpS3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=3svcx6/Powd5EpwwRyinhPTeMf0T01RQBZSra1bo7Tk=; b=gOgd+o4tZU+Jq71+ZyEhsY8Av8
	YHOHCd0SAcWuAUufM/oJfGk4lbKVG9bgrwimt+QLTn2wjktBiMvLWFWQY8EQhGwgSUCiM/KdvqmW7
	9aKRvwpHQZIs/2/hX+3cpMx+orCM4PoP0+1m4R1sDr5A0aNSz8KYv6w5p51xBHqoHffg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLQap-000000003Y8-33zg;
	Mon, 26 Oct 2026 19:42:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLQao-000000003Y0-0Z82
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 19:42:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+GB9qyl11JDDrA6Gw1b6omQzuvZkb86MofNJyWwD1aA=; b=S2UZ084M1McAa8wYDHbZmqONFk
 YWE8rn2+KRDa70msBP7GdKGWI7tT1GQaUxqhFYqQvQTUFXA4GjCXOD1ShSp0kLMV5AzQLsoHjZ/ev
 LYzrA+Wq09b8Rovrmq/24/4/ZULW9xH4mipkOOHxmcaTyV5i+eoxbMn3OXXQGxSEbrQg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+GB9qyl11JDDrA6Gw1b6omQzuvZkb86MofNJyWwD1aA=; b=YoK41trCTI8/SFwSHU6CtrhJhP
 oekZUpCK7JpU4I0nv80L5cFpvDVCXkEkIPMcDZJcmWnrqejJXNkbjgG2oWMfbNR6LN299uW9RZtKG
 PNdbViOM3I60EPEqvRyDZaUNpypMWmTKdst6G8R54Sxyz+4dHjCZyPZX5ITrj55SdNT4=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLQam-000000003XN-0Sw2 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 19:42:49 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso17535435e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 12:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793043761; x=1793648561; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+GB9qyl11JDDrA6Gw1b6omQzuvZkb86MofNJyWwD1aA=;
 b=RsUTHpS3vk1aIhUKL2HZrVyCwgGqCwSdlBEFEarmnTRrphTfH188fUjH2OlJMtpI46
 Bov+MEfBZad/3UMKcXE8NAk3bpDKdbNMBkzQDhmCXd+uD/y7kQP7+vUBuaGlCCMULdef
 CG+xN85ZNGMN/u24aTxMUQ784c0If6BqSA92Gt18Doh2vArO/3JJtrpEPb44+fTST3j6
 LUu4s3xIM/PpWmVXRudbqDfyak3FVVyMUb3mAhRhdABXDeyxU2Vj995hmcpeq+GRDSjY
 RJS3VS07YksmbqeRbN6RWLv0zmRzsr5vYpOHnEPWPvDRCw2GYuR99rFcq+Ha4ktyECop
 LgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793043761; x=1793648561;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+GB9qyl11JDDrA6Gw1b6omQzuvZkb86MofNJyWwD1aA=;
 b=ADPhAX4WdlGLeC/jl/XShSi5eMNRFvSJyoB1CS8YAsWirfKqLbYnBhrzg5NHKhOhi1
 XB4NXESFO+9iT2I2r5Pf0yi0GskNNYakS8goqp47o3KFponThM5IxGMdfAbhB1FIzGRQ
 tre4dYc+D2Ew+JUKuHF3z4e7IjRme94V8MUsjejrA0IXSKY2Yc5WMZFGAtndnc1LDaZy
 mRDA94POJlFTJ/Uwr5pXXdbju7rZcHajjkTgC2YSVYSH4fWpUkZNyDk61HYW59rEAaZj
 YTOXOtbVcQZbl4CeKAhPfa7EkJoAhRjn3QIpD0pq8Yc/d6FxteRsJwyL4ENceq/WsFur
 STUw==
X-Gm-Message-State: AFq9FYK1VM2OuOHJe4jCiISebSlpCF33s1hrMYx5j15+u7Q3SBX0RzZV
 DbYUhWxCA2/5XdneBLxtmgaG6r2hFlXp8qUzvA+yYbfXr87pn6lpyfZfFgmZxpAwZ2y7xD5OtX6
 ZqHwEjI5OGcNLltuJzRub110q6Tpqtos4N+9fuDnpqvPCRSlP3C5N0Ga4jKZTP65qxVeSTMs28v
 sarEB8GQ==
X-Gm-Gg: AYBFou0SM8y0C3AlaagFZBKtjYip51Egc9jFwslXDtCfKOu69f1Iw4RyFqQch1D2zV8
 atLgsdMx6uVGn4jWHpliwsoRDesNsrVefOTVCi0eKuFsHsvmugsL3Ie4cWV0XH088I/A2WDNEsD
 D1QAXkw/85n4elyYsHwzZy9w/KPEvWdxjf1ShHbx9Fm7nw+hGbQ0sfiTVO40v1M1jY3nEX2bgIQ
 afMAlkmtr4XzvYsTcTj//KV8TYT8bOHGGripBA3MdzAh9hP/YlO4bx6ei99c/plsYnvSrcpaprz
 9paMfEwjad0FZD+sCf/+1g4lGW8rjSZusDimvjRgalmZbyz4kN4WkNRJf5nw8DHwIU5nX61BAbt
 tkP6mK+b1DV10gB6A7tPzi54J3LfAY9VtVmNR375YyHkDeHo927fYdOdMAx6FzY9qmJMYwjez8T
 HUgR++Kf79YhLRZwqB4hCSiHmcnSwjrmu4qoNR6hPkjykHqWsLcoU/H7O2GbX3XCk/M4EhyePG+
 7G68r39JgE7AY9xhp8XEOdwc7QUBNFrYE7m8GDjQ9siHuPV6m98+elZEUPLeVTQ3SbE0hcqvt5m
 s7ASlP4F6IrXpkQIrDcR89+CS94VYC44BurTvVCGuh4dYDCS/ybZ2OhSjfRzliD4URofbEFETME
 L07XHO62dh3LybHlUtfa7GsZc2A60F/jAWhu/EeueDA==
X-Received: by 2002:a05:600c:3f06:b0:4a1:7e77:c382 with SMTP id
 5b1f17b1804b1-4a35ac99b9dmr137768755e9.5.1793043761229; 
 Mon, 26 Oct 2026 12:42:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc4d76sm18710847f8f.12.2026.10.26.12.42.40
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 12:42:40 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 19:42:40 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4
X-Gerrit-Change-Number: 2037
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2037?usp=email>
X-Gerrit-Commit: 828c0c4cfb73f4b61eb70f243ade1d2930b4906b
References: <gerrit.1793043747000.I695967524bb9e83887b8c07d0d09baff6e41acf4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDQzNzQ3MDAwLkk2OTU5Njc1MjRiYjllODM4ODdiOGMwN2QwZDA5YmFmZjZlNDFhY2Y0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <333b31597ca52ed051295b296820c18512cf3d96-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xLQam-000000003XN-0Sw2
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
Content-Type: multipart/mixed; boundary="===============1729509437421771023=="
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MISSING_HEADERS,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1729509437421771023==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SWrUOHi67i8="; charset=UTF-8

--SWrUOHi67i8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has uploaded this change for review=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2037?usp=3Demail )


Change subject: Add python scrip=
ts that demonstrate the ACC protocol
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

Add python scripts that demonstrate the ACC proto=
col

This adds a small protocol called sys_info that let's the server
query=
 various details about the client to demonstrate the capabilities
of the AC=
C functionality=2E

Change-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4
Si=
gned-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
A sample/management/acc_=
sysinfo_client_demo=2Epy
A sample/management/acc_sysinfo_server_demo=2Epy
2=
 files changed, 258 insertions(+), 0 deletions(-)



  git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/37/2037/1

diff --git a/sample=
/management/acc_sysinfo_client_demo=2Epy b/sample/management/acc_sysinfo_cl=
ient_demo=2Epy
new file mode 100755
index 0000000=2E=2Ec5c562a
--- /dev/nul=
l
+++ b/sample/management/acc_sysinfo_client_demo=2Epy
@@ -0,0 +1,143 @@
+#=
!/usr/bin/env python3
+# Copyright (c) 2026 OpenVPN Inc <sales@openvpn=2Ene=
t>
+# Copyright (c) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+#
+# Permission=
 is hereby granted, free of charge, to any person obtaining a copy
+# of th=
is software and associated documentation files (the "Software"), to deal
+#=
 in the Software without restriction, including without limitation the righ=
ts
+# to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+# copies of the Software, and to permit persons to whom the Software =
is
+# furnished to do so, subject to the following conditions:
+#
+# The ab=
ove copyright notice and this permission notice shall be included in all
+#=
 copies or substantial portions of the Software=2E
+#
+# THE SOFTWARE IS PR=
OVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUD=
ING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A =
PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE
+# AUTHORS =
OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY=
, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+# OUT=
 OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
=
+# SOFTWARE=2E
+
+# This implement a small demonstration of using the
+# Op=
enVPN Access Server Management Interface (OMI) and an app Custom Control
+#=
 protocol (sys_info) to retrieve a number of system information from the
+#=
 client and push them to the server=2E To use this use on the server
+
+# -=
-app-custom-control sys_info
+# --management /path/to/acc_sysinfo_server_de=
mo=2Epy unix-script
+
+# and on the client
+# --app-custom-control sys_info=

+# --management /path/to/acc_sysinfo_client_demo=2Epy unix-script
+
+# Not=
e this is just a demonstration and not a production-ready solution=2E
+# Wh=
en modifying this code, keep the security in mind=2E It is easy to
+# intro=
duce a security problem when executing commands on the client=2E
+
+import =
asyncio
+import json
+import logging
+import os
+import platform
+import so=
cket
+import subprocess
+
+logging=2EbasicConfig()
+
+from omi_tools import=
 run_main, start_management_protocol, ConnectData
+from omi_client_protocol=
 import OMIClientProtocol
+
+logger =3D logging=2EgetLogger(__name__)
+logg=
er=2EsetLevel(logging=2EDEBUG)
+
+
+class OmiSysInfoClientProtocol(OMIClien=
tProtocol):
+    def __init__(self, finish_future, connect_data: ConnectDat=
a):
+        super()=2E__init__(finish_future, connect_data)
+
+
+    def r=
eceive_acc_sys_info(self, accmsg):
+        print(f"Received sys_info messa=
ge: {accmsg!r}")
+
+        logger=2Edebug(f"Received sys_info message: {ac=
cmsg!r}")
+
+        msg =3D json=2Eloads(accmsg)
+
+
+        asyncio=2Ecr=
eate_task(self=2Esend_info_response(msg))
+
+    async def send_info_respon=
se(self, msg):
+        response =3D {}
+        if msg=2Eget("uname", Fals=
e):
+            response['uname'] =3D platform=2Euname()=2E_asdict()
+
+  =
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
+                addrs =3D [x[4][0]=
 for x in socket=2Egetaddrinfo('google=2Ecom', 443)]
+                respo=
nse["dns-google=2Ecom"] =3D addrs
+
+            except Exception as e:
+  =
              logger=2Eerror(f"Error resolving DNS for google=2Ecom: {e}", =
exc_info=3DTrue)
+                response["dns-google=2Ecom"] =3D None
+
+=
        if msg=2Eget("route", False):
+            response['route'] =3D aw=
ait self=2Eget_routes(False)
+
+        if msg=2Eget("route6", False):
+   =
         response['route6'] =3D await self=2Eget_routes(True)
+
+        ms=
g =3D json=2Edumps(response)=2Eencode()
+
+        await self=2Esend_acc_ms=
g("sys_info", msg)
+
+    async def get_routes(self, v6):
+        if platf=
orm=2Esystem() =3D=3D 'linux':
+            cmd =3D '/usr/sbin/ip'
+       =
     if v6:
+                args =3D ['-6', 'route', 'show']
+            =
else:
+                args =3D ['-4', 'route', 'show']
+        elif platf=
orm=2Esystem() =3D=3D 'Darwin' or os=2Eplatform() =3D=3D 'FreeBSD':
+      =
      # FreeBSD and macOS
+            if os=2Epath=2Eexists('/usr/sbin/net=
stat'):
+                cmd =3D '/usr/sbin/netstat'
+            else:
+  =
              cmd =3D '/usr/bin/netstat'
+
+            if v6:
+           =
     args =3D [ '-f', 'inet6', '-rn']
+            else:
+
+               =
 args =3D [ '-f', 'inet', '-rn']
+        else:
+            return "Unsupp=
orted platform"
+
+        proc =3D await asyncio=2Esubprocess=2Ecreate_sub=
process_exec(cmd, *args, stdout=3Dsubprocess=2EPIPE)
+        output, _ =3D=
 await proc=2Ecommunicate()
+        return output=2Edecode()
+
+
+async de=
f main(connect_data: ConnectData):
+    transport, protocol, finish_future =
=3D await start_management_protocol(connect_data, OmiSysInfoClientProtocol)=

+    while True:
+        await asyncio=2Esleep(5)
+        print("=2E", e=
nd=3D"", flush=3DTrue)
+
+    management_version =3D await protocol=2Emanag=
ement_ready()
+    print(f"Management interface version: {management_versio=
n}")
+
+    await protocol=2Eset_bytecount_interval(5)
+
+    await finish_=
future
+
+
+if __name__ =3D=3D '__main__':
+    run_main(main)
diff --git a=
/sample/management/acc_sysinfo_server_demo=2Epy b/sample/management/acc_sys=
info_server_demo=2Epy
new file mode 100755
index 0000000=2E=2Ef084767
--- /=
dev/null
+++ b/sample/management/acc_sysinfo_server_demo=2Epy
@@ -0,0 +1,11=
5 @@
+#! /usr/bin/env python3
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
+import asyncio
+# This implement a small demonstr=
ation of using the
+# OpenVPN Access Server Management Interface (OMI) and =
an app Custom Control
+# protocol (sys_info) to retrieve a number of system=
 information from the
+# client and push them to the server=2E To use this =
use on the server
+
+# --app-custom-control sys_info
+# --management /path/=
to/acc_sysinfo_server_demo=2Epy unix-script
+
+# and on the client
+# --app=
-custom-control sys_info
+# --management /path/to/acc_sysinfo_client_demo=
=2Epy unix-script
+
+import base64
+import json
+import logging
+import ran=
dom
+from pprint import pformat
+
+from omi_server_protocol import OMIServe=
rProtocol, ConnectedClient
+from omi_tools import run_main, start_managemen=
t_protocol, ConnectData
+
+logging=2EbasicConfig()
+logger =3D logging=2Ege=
tLogger(__name__)
+logger=2EsetLevel(logging=2EINFO)
+
+class SysInfoConnec=
tedClient(ConnectedClient):
+    # Remember the key-id that we authenticate=
d
+    authenticated_kid =3D None
+
+class OMISysInfoServerProtocol(OMIServ=
erProtocol):
+    def __init__(self, finish_future, connect_data: ConnectDa=
ta =3D None):
+        super()=2E__init__(finish_future, connect_data)
+   =
     self=2E_connected_client_class =3D SysInfoConnectedClient
+
+    def c=
lient_event_ESTABLISHED(self, client, kid, env, extra):
+        print(f"CL=
ient connected: {client}")
+
+        kid =3D client=2Eauthenticated_kid
+ =
       asyncio=2Ecreate_task(self=2E_send_sys_info_command(client, kid))
+
=
+    def client_event_CONNECT(self, client, kid, env, extra):
+        prin=
t(f"Authenticating client {client=2Ecid}, {kid}")
+        self=2Equeue_com=
mand(f"client-auth-nt {client=2Ecid} {kid}")
+        client=2Eauthenticate=
d_kid =3D kid
+
+    async def _send_sys_info_command(self, client, kid):
+=
        # Give the client some time to settle its routes
+        await asy=
ncio=2Esleep(5)
+
+        info =3D ["route", "route6", "dns-google=2Ecom",=
 "username", "hostname", "uname"]
+
+        # Pick 3 random infos to reque=
st from the client
+        random=2Eshuffle(info)
+        infos =3D info[=
:3]
+        request =3D {k: True for k in infos}
+
+        req_str =3D js=
on=2Edumps(request)=2Eencode()
+
+        logger=2Einfo(f"Sending sysinfo r=
equest for client {client=2Ecid} with infos: {infos}")
+
+        acc_proto=
col =3D "sys_info"
+
+        await self=2Esend_acc_msg(client, kid, acc_pr=
otocol, req_str)
+
+    def receive_acc_client_sys_info(self, client, kid, =
acc_msg):
+        logger=2Einfo(f"Received sysinfo from client {client=2Ec=
id}")
+        
+        response =3D json=2Eloads(acc_msg)
+        for ke=
y in response=2Ekeys():
+            logger=2Einfo (f"=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D {key!r} =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D")
+            if type(response[key]) =3D=3D str:
+                for =
line in response[key]=2Esplit("\n"):
+                    logger=2Einfo(rep=
r(line))
+            else:
+                logger=2Einfo(repr(response[ke=
y]))
+
+
+async def main(connect_data: ConnectData):
+    transport, protoc=
ol, finish_future =3D await start_management_protocol(connect_data, OMISysI=
nfoServerProtocol)
+
+    management_version =3D await protocol=2Emanagemen=
t_ready()
+    print(f"Management interface version: {management_version}")=

+
+    await protocol=2Eenable_log()
+
+    await protocol=2Eset_bytecount=
_interval(5)
+
+    await finish_future
+
+
+if __name__ =3D=3D '__main__':=

+   run_main(main)

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2037?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I695967524bb9e83887b8c07d0d09baff6e41acf4
Gerrit-Change-Number: 2037
Ger=
rit-PatchSet: 1
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--SWrUOHi67i8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe has =
uploaded this change for <strong>review</strong>=2E</p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Add python scripts that demonstrate the ACC protocol<br><br>Th=
is adds a small protocol called sys_info that let&#39;s the server<br>query=
 various details about the client to demonstrate the capabilities<br>of the=
 ACC functionality=2E<br><br>Change-Id: I695967524bb9e83887b8c07d0d09baff6e=
41acf4<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>=
A sample/management/acc_sysinfo_client_demo=2Epy<br>A sample/management/acc=
_sysinfo_server_demo=2Epy<br>2 files changed, 258 insertions(+), 0 deletion=
s(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/37/2037/1</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/sample/management/acc_=
sysinfo_client_demo=2Epy b/sample/management/acc_sysinfo_client_demo=2Epy</=
span><br><span>new file mode 100755</span><br><span>index 0000000=2E=2Ec5c5=
62a</span><br><span>--- /dev/null</span><br><span>+++ b/sample/management/a=
cc_sysinfo_client_demo=2Epy</span><br><span>@@ -0,0 +1,143 @@</span><br><sp=
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
%);">+# This implement a small demonstration of using the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+# OpenVPN Access Server Management In=
terface (OMI) and an app Custom Control</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# protocol (sys_info) to retrieve a number of system in=
formation from the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
 client and push them to the server=2E To use this use on the server</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+# --app-custom-control sys_info</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+# --management /path/to/acc_sysin=
fo_server_demo=2Epy unix-script</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# and o=
n the client</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# --app=
-custom-control sys_info</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+# --management /path/to/acc_sysinfo_client_demo=2Epy unix-script</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+# Note this is just a demonstration and not =
a production-ready solution=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+# When modifying this code, keep the security in mind=2E It is e=
asy to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# introduce a=
 security problem when executing commands on the client=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+import asyncio</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+import json</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+import logging</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+import os</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import p=
latform</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import socke=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import subprocess<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+logging=2EbasicConfig()</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+from omi_tools import run_main, start_management_proto=
col, ConnectData</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fro=
m omi_client_protocol import OMIClientProtocol</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+logger =3D logging=2EgetLogger(__name__)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+logger=2EsetLevel(logging=2EDEBUG)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+class OmiSysInfoClientProtocol(OMIClientProtocol):</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    def __init__(self, finish_future, =
connect_data: ConnectData):</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        super()=2E__init__(finish_future, connect_data)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    def receive_acc_sys_info(self, accmsg):</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        print(f&quot;Received sys_info messag=
e: {accmsg!r}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        logger=2Ed=
ebug(f&quot;Received sys_info message: {accmsg!r}&quot;)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        msg =3D json=2Eloads(accmsg)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     asyncio=2Ecreate_task(self=2Esend_info_response(msg))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    async def send_info_response(self, msg):</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        response =3D {}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if msg=2Eget(&quot=
;uname&quot;, False):</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            response[&#39;uname&#39;] =3D platform=2Euname()=2E_asdict()<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if msg=2Eget(&quot;username&quo=
t;, False):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    response[&#39;username&#39;] =3D os=2Egetlogin()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if msg=2Eget(&quot;hostname&quot;, False):</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            response[&#39;hos=
tname&#39;] =3D platform=2Enode()</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if msg=2Eget(&quot;dns-google=2Ecom&quot;, False):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            try:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                addrs =3D [x[4][0] for x in =
socket=2Egetaddrinfo(&#39;google=2Ecom&#39;, 443)]</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                response[&quot;dns-google=2E=
com&quot;] =3D addrs</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            except=
 Exception as e:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             logger=2Eerror(f&quot;Error resolving DNS for google=2Ecom: {e=
}&quot;, exc_info=3DTrue)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                response[&quot;dns-google=2Ecom&quot;] =3D None</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if msg=2Eget(&quot;route&quot;, Fals=
e):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            resp=
onse[&#39;route&#39;] =3D await self=2Eget_routes(False)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if msg=2Eget(&quot;route6&quot;, False):</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            response[&#39;ro=
ute6&#39;] =3D await self=2Eget_routes(True)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        msg =3D json=2Edumps(response)=2Eencode()</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        await self=2Esend_acc_msg(&quot;sys_info&quot;, ms=
g)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
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
(120, 100%, 40%);">+        await asyncio=2Esleep(5)</span><br><span style=
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
 mode 100755</span><br><span>index 0000000=2E=2Ef084767</span><br><span>---=
 /dev/null</span><br><span>+++ b/sample/management/acc_sysinfo_server_demo=
=2Epy</span><br><span>@@ -0,0 +1,115 @@</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#! /usr/bin/env python3</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+# Copyright (c) 2026 OpenVPN Inc &lt;sales@openvpn=
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
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import asyn=
cio</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# This implement=
 a small demonstration of using the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# OpenVPN Access Server Management Interface (OMI) and an a=
pp Custom Control</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
protocol (sys_info) to retrieve a number of system information from the</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+# client and push them =
to the server=2E To use this use on the server</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# --app-custom-control sys_info</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# --management /path/to/acc_sysinfo_server_demo=2Epy un=
ix-script</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# and on the client</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# --app-custom-control sys_in=
fo</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# --management /p=
ath/to/acc_sysinfo_client_demo=2Epy unix-script</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+import base64</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+import json</span><br><span style=3D"color: hsl(120, 100%, 40%);">+impor=
t logging</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import ran=
dom</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from pprint impo=
rt pformat</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+from omi_server_protocol imp=
ort OMIServerProtocol, ConnectedClient</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+from omi_tools import run_main, start_management_protoco=
l, ConnectData</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+logging=2EbasicConfig()<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+logger =3D logging=
=2EgetLogger(__name__)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+logger=2EsetLevel(logging=2EINFO)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cl=
ass SysInfoConnectedClient(ConnectedClient):</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    # Remember the key-id that we authenticated</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    authenticated_kid =
=3D None</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+class OMISysInfoServerProtocol=
(OMIServerProtocol):</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    def __init__(self, finish_future, connect_data: ConnectData =3D None):=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        super()=2E_=
_init__(finish_future, connect_data)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        self=2E_connected_client_class =3D SysInfoConnecte=
dClient</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    def client_event_ESTABLISHE=
D(self, client, kid, env, extra):</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        print(f&quot;CLient connected: {client}&quot;)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        kid =3D client=2Eauthenticated_kid</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        asyncio=2Ecrea=
te_task(self=2E_send_sys_info_command(client, kid))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    def client_event_CONNECT(self, client, kid, env, extra):=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        print(f&quo=
t;Authenticating client {client=2Ecid}, {kid}&quot;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        self=2Equeue_command(f&quot;clien=
t-auth-nt {client=2Ecid} {kid}&quot;)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        client=2Eauthenticated_kid =3D kid</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    async def _send_sys_info_command(self, client, ki=
d):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # Give t=
he client some time to settle its routes</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        await asyncio=2Esleep(5)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        info =3D [&quot;route&quot;, &quot;route6&quot;, &qu=
ot;dns-google=2Ecom&quot;, &quot;username&quot;, &quot;hostname&quot;, &quo=
t;uname&quot;]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        # Pick 3 random =
infos to request from the client</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        random=2Eshuffle(info)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        infos =3D info[:3]</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        request =3D {k: True for k in infos}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        req_str =3D json=2Edumps(reque=
st)=2Eencode()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        logger=2Einfo(f&=
quot;Sending sysinfo request for client {client=2Ecid} with infos: {infos}&=
quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        acc_protocol =3D &quot;s=
ys_info&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        await self=2Esend=
_acc_msg(client, kid, acc_protocol, req_str)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    def receive_acc_client_sys_info(self, client, kid, acc_msg):</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        logger=2Einfo(f&=
quot;Received sysinfo from client {client=2Ecid}&quot;)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        response =3D json=2Eloads(acc_msg)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        for key in response=
=2Ekeys():</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   logger=2Einfo (f&quot;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D {key!r}=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D&quot;)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            if type(response[key]) =3D=
=3D str:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     for line in response[key]=2Esplit(&quot;\n&quot;):</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    logger=2Einfo(repr(=
line))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            e=
lse:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 logger=2Einfo(repr(response[key]))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+async def main(connect=
_data: ConnectData):</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    transport, protocol, finish_future =3D await start_management_protocol=
(connect_data, OMISysInfoServerProtocol)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    management_version =3D await protocol=2Emanagement_ready()</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    print(f&quot;Management in=
terface version: {management_version}&quot;)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    await protocol=2Eenable_log()</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    await protocol=2Eset_bytecount_interval(5)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    await finish_future</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+if __name__ =3D=3D &#39;_=
_main__&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   run=
_main(main)</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2037?usp=3Demail">change 2037</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I695967524bb9e83887b=
8c07d0d09baff6e41acf4 </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 2037 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--SWrUOHi67i8=--


--===============1729509437421771023==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1729509437421771023==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1729509437421771023==--

