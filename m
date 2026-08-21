Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937BFC5DF97
	for <openvpn-devel@archiver.kernel.org>; Fri, 21 Aug 2026 20:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=SNf0q80BIMYxl/5GPZLHBkSeLTvYrHt9G+RtOz46uts=; b=O4UI6ei8Qfyems
	6PymwMQxVbQCEcs9A99RgdgbkgBqEBTpPIwgqZ60U2GYyz5lWV6+gOzpnRrG4BcQFl+HGUfvYgHb8
	7l4mnNf/KT1k47wvnqqHfVnX53KfNjEQd/gzcORziE4r1h1ZTBCl6X3EYOWQYB6P9TnvU3yWlhgt0
	+P8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wxWCY-0000dP-1q;
	Fri, 21 Aug 2026 20:50:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wxWCW-0000dA-8j
 for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 20:50:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+mYQKTg7H7qiyEYy+SOAtLVZrwNCItCW9q7V+6LDfPk=; b=BNsPvEn7BiI/kr9BFpiRoqBa/c
 lbcH5suKvgzre07kqumOksq0QxnT+Ez83KJCOkUsHlKzSQZ2VnNgh02AUFnW8sraoJ05O/6bhM6HY
 LZKl4No8uMRQPNKGKql24pYTvXA8aJYr/5EoWR0RhMbsHtjWiYwpp/aUiGvGZd0A2bKA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+mYQKTg7H7qiyEYy+SOAtLVZrwNCItCW9q7V+6LDfPk=; b=H
 tGHbJEXDNJFM0Wzh6D/RTj/8eM6Sq7l66MEmLWuFfxsj3+rbBMv0RvdOWEYog34Ks4FcSEkXPg1rF
 v/hKChgoYSl3P6CCtFywepl/zRpY9Qb3YVGYOgRHuzigr9Yr78ndCtCEIw3r3mDLxrx+MrUowxhMA
 Nduy6C5SkvAlNDZU=;
Received: from mail-ej1-f52.google.com ([209.85.218.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wxWCM-0005hp-GH for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 20:50:48 +0000
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-c20e70a0962so221098766b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 21 Aug 2026 13:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787345440; x=1787950240; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+mYQKTg7H7qiyEYy+SOAtLVZrwNCItCW9q7V+6LDfPk=;
 b=XRAQ+z1srrvsgEIzPGuMU4T9FASxnM0/tv8/9YDKBHy1Rhw2Idt6c+H0zIU6jRitwR
 N1o9k65MgmFzJtACBDDkFnR2mFzlwidQoozi31yrqWaQdKKgytOrvnjCtZqj3vGr/PVS
 E3/DbM3zku4m+UQLRvR0VyLQPuSdGsPH99S1eG0AXDzg6MefMXjXZt3gbnrqTmi/Ivsu
 8CMeV7vkxskN0niYNNDAqKuas3nglRQsNkysnv9MmzzzIGDiykI40PWoeaLbPaBr2/bV
 Jm4FnuvIL1BApFR17Nm1iIrvbS0Yerh0NjwWx2WBcq262WCmReoyEYEQ7pVNWYlkqHjj
 7SdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787345440; x=1787950240;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+mYQKTg7H7qiyEYy+SOAtLVZrwNCItCW9q7V+6LDfPk=;
 b=Td/bDVHGJ9mihPBHUWyQ7dCYTzlWO9fIqtYlVtw8fcPLLcKjHNhfAkZlwsLQCExVKW
 +13pkEzrelu68M/xNZSUBMSqDC21r8g6Ham1A0LtUfDm5qAIX+fHo2MOS5hIgdWAtdFY
 bBp31rsORfH7FDqD9MP4lr9LOvt7PGEv/v1oy5XeEvQRnYRow+/k9Dry6WGX+DD3Y1N6
 ENskQwOwr5pp6I6rjTWaCebJzvDUwrDLR7TvCry46L6ZMwiJcd7KfV4rvsbSI1Pei6YS
 pK5qonS3OS2Acmj01lO2RWNDz1DiLGu+ZvtQi4wTBiun78+u6ogakQqn0WepIDSZ9yq0
 WHtQ==
X-Gm-Message-State: AFuF++m3jjl0I23uaVQ6mmkx71RrNDDFWmpEWF3huTdFeFrbjiVbBlwq
 8DvX0i+On1Tkre1TPB8cEcQUjLCafzn1y4A4e9Fnbz4b4hekgBpWzOtZlGEpeezoFd728LQ8VE+
 MsLq+R2W2C+8UhwY3Wq8E67jYsPm8hVqPhi3ZIPIUcjl6q0dxHxfps0L7YekrcwOegXm8MVNpcI
 OP/+2OAg==
X-Gm-Gg: AR+sD129x1S9i93BkRra9HLJWRUfGX6IweYIXieEKJy4cVf1BBpDLZVGU2tevqqiHwT
 /KZPI7MOeGAM5f2+cJKaS8aD9J2zHm0xeGZID8WgN259D8+ND4udLr+qbglYFU4OQQPRskzoXru
 BHFDRM/bSmsPir7bM+5rMZepj7ivvt97r92LZ+whZmU75y60Gc8MCzEJdQ7FLGGqN+sa3RE7tYA
 YnwwGucFvBHFRy9nEOPGOgPtuadS6q6bCC8OLnfGJ8aVw8y7dU/0nJFzAKzWqYScm6DJdXbQAXH
 kzoL23K3c+mI56m7ol42yXGQQg8/L9RxJn+a9sjQayAa/qou1aeNaOznSAOvFRJbnZEa+LuNUW4
 uXmDkjpcat8V1nmSaprRvSxYjVmf0gOXO/990hFYzOWNqkcxCfHU0Bttg46IwYlDL/vP7dBkxQn
 zYI/y0iAFA2nTYXYlElHS8XEJ3FyYMBtpOR3q7E9J5cy3qzZ57yEiOTX/jVJEqFGsEiHPaN1ZnH
 3KXViygy4lQrBHjjHlrRheS3uqpRDgjUwNT2GWCzHiOPrkXgJG+Dd7tM2KW+Hw0iXWRNF3p0Fy2
 jHX61giV0s0KAMzSz+U9MlB57MP0G+JVH4jeMLs7abifcXPz9lo=
X-Received: by 2002:a17:906:6a25:b0:c16:12ff:dc8d with SMTP id
 a640c23a62f3a-c246a69a22fmr932459266b.14.1787345439549; 
 Fri, 21 Aug 2026 13:50:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c245931812esm743009466b.60.2026.08.21.13.50.37
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 13:50:37 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 21 Aug 2026 20:50:37 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22
X-Gerrit-Change-Number: 1860
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1860?usp=email>
X-Gerrit-Commit: ab263e6d464258d578337ba54689d29f5251510d
References: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzQ1NDE2MDAwLkllMjAyODk3MzdkNTAyYTI1ZWVkYzYwNjc3ZDNjMzUwZGRjM2IzYzIyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <49446b51b7b92ea250c780f3ca4fd433ab8f7075-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wxWCM-0005hp-GH
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add python scripts
 that demonstrate using the dpc1 ACC protocol
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
Content-Type: multipart/mixed; boundary="===============9126575087400383219=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9126575087400383219==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AeR2JlKUHBs="; charset=UTF-8

--AeR2JlKUHBs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1860?usp=3Demail )


Change subject: Add python scripts =
that demonstrate using the dpc1 ACC protocol
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add python scripts that demonstrate using t=
he dpc1 ACC protocol

The dpc1 protocol is used by the OpenVPN Connect clie=
nts and
OpenVPN Connexa=2E

Change-Id: Ie20289737d502a25eedc60677d3c350ddc3=
b3c22
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
A sample/managem=
ent/acc_dpc1_client_demo=2Epy
A sample/management/acc_dpc1_server_demo=2Epy=

2 files changed, 291 insertions(+), 0 deletions(-)



  git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/60/1860/1

diff --git a/samp=
le/management/acc_dpc1_client_demo=2Epy b/sample/management/acc_dpc1_client=
_demo=2Epy
new file mode 100755
index 0000000=2E=2Ebaaa9af
--- /dev/null
++=
+ b/sample/management/acc_dpc1_client_demo=2Epy
@@ -0,0 +1,121 @@
+#!/opt/h=
omebrew/bin/python3
+#!/usr/bin/env python3
+# Copyright (c) 2026 OpenVPN I=
nc <sales@openvpn=2Enet>
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
+#
+#  You should have received a =
copy of the GNU General Public License along
+#  with this program; if not,=
 see <https://www=2Egnu=2Eorg/licenses/>=2E
+import asyncio
+import base64
=
+import json
+import logging
+import platform
+
+from omi import OmiProtoco=
l
+from omi_tools import run_main, start_management_protocol, ConnectData
+=

+logger =3D logging=2EgetLogger(__name__)
+
+class OmiAccProtocol(OmiProto=
col):
+    def __init__(self, finish_future, connect_data:ConnectData):
+  =
      super()=2E__init__(finish_future, connect_data)
+        self=2Eaccms=
g =3D ""
+
+    def recv_notify_ACC(self, args):
+        # dpc1,0,eyJkcGNf=
cmVx[=2E=2E=2E]
+        protocol, fragment, b64msg =3D args=2Esplit(",", 2=
)
+        if protocol !=3D "dpc1":
+            logging=2Einfo(f"Received =
unknown ACC protocol: {protocol}")
+            return
+
+        msg =3D b=
ase64=2Edecodebytes(b64msg=2Eencode())
+        self=2Eaccmsg +=3D msg=2Ede=
code()
+
+        # Message is not yet complete=2E Wait for more fragments=
=2E
+        if fragment !=3D "0":
+            return
+
+        self=2Epa=
rseDpc1(self=2Eaccmsg)
+        self=2Eaccmsg =3D ""
+
+    def parseDpc1(s=
elf, accmsg):
+        msg =3D json=2Eloads(accmsg)
+
+        logging=2Eer=
ror(f"Received sys_info message: {accmsg}")
+
+        dpc_request =3D msg[=
"dpc_request"]
+        ver =3D dpc_request["ver"]
+        if ver !=3D "1=
=2E0":
+            logging=2Eerror(f"Received unknown ACC protocol version=
: {ver}")
+            return
+
+        client_info =3D dpc_request=2Eget(=
"client_info", False)
+        antivirus =3D "antivirus" in dpc_request
+  =
      disk_encryption =3D "disk_encryption" in dpc_request
+
+        logge=
r=2Einfo(f"Received DPC1 request: antivirus=3D{antivirus}, disk_encryption=
=3D{disk_encryption}, client_info=3D{client_info}")
+
+        if client_in=
fo:
+            self=2E_sendDPC1ClientInfo()
+
+    def _sendDPC1ClientInf=
o(self):
+        system =3D platform=2Esystem()
+        if system =3D=3D =
"Darwin":
+            system =3D "MacOS"
+
+        response =3D {
+      =
      "dpc_response": {
+                "ver": "1=2E0",
+                "=
client_info": {
+                    "os": {
+                        "type=
": system,
+                        "version": platform=2Erelease(),
+     =
                   "extra":
+                            {
+               =
                 "arch": platform=2Emachine(),
+                           =
 }
+                    }
+                }
+            }
+        }
+
+ =
       b64msg =3D base64=2Eb64encode(json=2Edumps(response)=2Eencode())=2Ed=
ecode()
+
+        command =3D f"acc-msg\ndpc1\n6\n{b64msg}\nEND"
+        =
self=2Equeue_command(command)
+
+async def main(connect_data:ConnectData):
=
+    transport, protocol, finish_future =3D await start_management_protocol=
(connect_data, OmiAccProtocol)
+    while True:
+        await asyncio=2Esl=
eep(1)
+        print("=2E", end=3D"", flush=3DTrue)
+
+    management_vers=
ion =3D await protocol=2Emanagement_ready()
+    print(f"Management interfa=
ce version: {management_version}")
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
\ No newline at end of file
diff --git a/sample/managemen=
t/acc_dpc1_server_demo=2Epy b/sample/management/acc_dpc1_server_demo=2Epy
n=
ew file mode 100644
index 0000000=2E=2Ea62d22c
--- /dev/null
+++ b/sample/m=
anagement/acc_dpc1_server_demo=2Epy
@@ -0,0 +1,170 @@
+#!/usr/bin/env /usr/=
bin/python3
+# Copyright (c) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+# Copy=
right (c) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+#
+# Permission is hereby=
 granted, free of charge, to any person obtaining a copy
+# of this softwar=
e and associated documentation files (the "Software"), to deal
+# in the So=
ftware without restriction, including without limitation the rights
+# to u=
se, copy, modify, merge, publish, distribute, sublicense, and/or sell
+# co=
pies of the Software, and to permit persons to whom the Software is
+# furn=
ished to do so, subject to the following conditions:
+#
+# The above copyri=
ght notice and this permission notice shall be included in all
+# copies or=
 substantial portions of the Software=2E
+#
+# THE SOFTWARE IS PROVIDED "AS=
 IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NO=
T LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR=
 PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE
+# AUTHORS OR COPYRIG=
HT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER =
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+# OUT OF OR IN =
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+# SOFTWAR=
E=2E
+
+#
+#  You should have received a copy of the GNU General Public Lic=
ense along
+#  with this program; if not, see <https://www=2Egnu=2Eorg/lice=
nses/>=2E
+import asyncio
+import base64
+import json
+import logging
+impo=
rt platform
+from pprint import pprint
+
+from sample=2Emanagement=2Eomi im=
port OMIServerProtocol
+
+logger =3D logging=2EgetLogger(__name__)
+
+class=
 OmiDPCServerProtocol(OMIServerProtocol):
+    def __init__(self, finish_fu=
ture):
+        super()=2E__init__(finish_future)
+        self=2Eaccmsg =
=3D ""
+
+    def recv_notify_ACC(self, args):
+        # 7,3,dpc1,0,eyJkcG=
NfcmVx[=2E=2E=2E]
+        protocol, fragment, b64msg =3D args=2Esplit(",",=
 2)
+        if protocol !=3D "dpc1":
+            logging=2Einfo(f"Receive=
d unknown ACC protocol: {protocol}")
+            return
+
+        msg =3D=
 base64=2Edecodebytes(b64msg=2Eencode())
+        self=2Eaccmsg +=3D msg=2E=
decode()
+
+        # Message is not yet complete=2E Wait for more fragment=
s=2E
+        if fragment !=3D "0":
+            return
+
+        try:
+  =
          self=2EparseDpc1(self=2Eaccmsg)
+            self=2Eaccmsg =3D ""=

+        except Exception as e:
+            logger=2Eerror(f"Error parsin=
g DPC1 message: {e}", exc_info=3DTrue)
+
+    def parseDpc1(self, accmsg):
=
+        print(f"Received DPC1 message: {accmsg!r}")
+        msg =3D json=
=2Eloads(accmsg)
+        pprint(msg)
+
+        dpc_response =3D msg["dpc_=
response"]
+        ver =3D dpc_response["ver"]
+        if ver !=3D "1=2E0=
":
+            logging=2Eerror(f"Received unknown ACC protocol version: {v=
er}")
+            return
+
+        client_info =3D dpc_response=2Eget("cl=
ient_info", {})
+        antivirus =3D "antivirus" in dpc_response
+       =
 disk_encryption =3D "disk_encryption" in dpc_response
+
+        logger=2E=
info(f"Received DPC1 response: antivirus=3D{antivirus}, disk_encryption=3D{=
disk_encryption}, client_info=3D{client_info}")
+
+
+    def _sendDPC1Clien=
tInfo(self):
+        system =3D platform=2Esystem()
+        if system =3D=
=3D "Darwin":
+            system =3D "MacOS"
+
+        response =3D {
+  =
          "dpc_response": {
+                "ver": "1=2E0",
+             =
   "client_info": {
+                    "os": {
+                        "=
type": system,
+                        "version": platform=2Erelease(),
+ =
                       "extra":
+                            {
+           =
                     "arch": platform=2Emachine(),
+                       =
     }
+                    }
+                }
+            }
+        }
=
+
+        b64msg =3D base64=2Eb64encode(json=2Edumps(response)=2Eencode())=
=2Edecode()
+
+        command =3D f"acc-msg\ndpc1\n6\n{b64msg}\nEND"
+    =
    self=2Equeue_command(command)
+
+    def client_event_ESTABLISHED(self,=
 client, kid, env, extra):
+        print(f"CLient connected: {client}")
+ =
       pprint(env)
+
+    def client_event_CONNECT(self, client, kid, env, =
extra):
+        print(f"Authenticating client {client=2Ecid}, {kid}")
+
+ =
       iv_acc =3D env=2Eget("IV_ACC")
+        if not iv_acc:
+            =
self=2Equeue_command(f"client-auth-nt {client=2Ecid} {kid}")
+
+           =
 return
+        else:
+            pass
+            #cmd =3D f"client-aut=
h {client=2Ecid} {kid}\npush \"custom-control 1280 A:6 dpc1:cck1\"\nEND"
+ =
           #self=2Equeue_command(cmd)
+
+        self=2E_send_dpc1_command(=
client=2Ecid, kid)
+
+    def _send_dpc1_command(self, cid, kid):
+        =
dpc_cmd =3D "{\"dpc_request\":{\"ver\":\"1=2E0\",\"correlation_id\":\"deb44=
46f-2086-4af5-aa6d-ac42285ef3fe\",\"timestamp\":\"Fri Jul 17 14:08:02=2E395=
 2026\",\"client_info\":true}}"
+        dpc_cmd =3D '{"dpc_request":{"ver"=
:"1=2E0","correlation_id":"846fe236-efa0-48aa-b92e-35ae5823d2f7","timestamp=
":"Fri Aug 07 17:47:24=2E370 2026","client_info":true}}'
+        dpc_cmd =
=3D '{"dpc_request":{"ver":"1=2E0","correlation_id":"n/a","timestamp":"yest=
erday","client_info":true, "disk_encryption": {"full": true}, "antivirus":{=
}}}'
+
+
+        self=2Equeue_command(f"client-pending-auth {cid} {kid} AC=
C 180")
+
+        dpc_cmd_base64 =3D base64=2Eencodebytes(dpc_cmd=2Eencode=
())=2Edecode()
+        acc_protocol =3D "dpc1"
+
+        # TODO: Implemen=
t fragmentation
+        cmd =3D f"client-acc-msg {cid} {kid}\n{acc_protoco=
l}\n6\n{dpc_cmd_base64}\nEND"
+
+
+        self=2Equeue_command(cmd)
+
+
+
=
+async def main():
+    # Get a reference to the event loop as we plan to u=
se
+    # low-level APIs=2E
+    loop =3D asyncio=2Eget_running_loop()
+
+ =
   finish_future =3D loop=2Ecreate_future()
+    path =3D '/tmp/test-omi-se=
rver'
+
+    transport, protocol =3D await loop=2Ecreate_unix_connection(la=
mbda: OmiDPCServerProtocol(finish_future), path)
+
+    management_version =
=3D await protocol=2Emanagement_ready()
+    print(f"Management interface v=
ersion: {management_version}")
+    await protocol=2Eenable_log()
+
+    bs=
 =3D await protocol=2Eset_bytecount_interval(30)
+
+    print(f"byte set re=
sult {bs}")
+
+    while not finish_future=2Edone():
+        await asyncio=
=2Esleep(5)
+        #cs:OmiCommandResult =3D await protocol=2Eget_client_s=
tatus()
+        #print("\n"=2Ejoin(cs=2Eresult))
+
+
+
+if __name__ =3D=3D=
 '__main__':
+    asyncio=2Erun(main())
\ No newline at end of file

-- 
To=
 view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project:=
 openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie20289737d502a25eedc60677=
d3c350ddc3b3c22
Gerrit-Change-Number: 1860
Gerrit-PatchSet: 1
Gerrit-Owner:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>

--AeR2JlKUHBs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Add python scripts that demonstrate using the dpc1 ACC protocol<br=
><br>The dpc1 protocol is used by the OpenVPN Connect clients and<br>OpenVP=
N Connexa=2E<br><br>Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22<br=
>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>A sample/=
management/acc_dpc1_client_demo=2Epy<br>A sample/management/acc_dpc1_server=
_demo=2Epy<br>2 files changed, 291 insertions(+), 0 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/60/1860/1</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/sample/management/acc_dpc1_client_dem=
o=2Epy b/sample/management/acc_dpc1_client_demo=2Epy</span><br><span>new fi=
le mode 100755</span><br><span>index 0000000=2E=2Ebaaa9af</span><br><span>-=
-- /dev/null</span><br><span>+++ b/sample/management/acc_dpc1_client_demo=
=2Epy</span><br><span>@@ -0,0 +1,121 @@</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#!/opt/homebrew/bin/python3</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#!/usr/bin/env python3</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+# Copyright (c) 2026 OpenVPN Inc &lt;sales@o=
penvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# C=
opyright (c) 2026 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# Permission is hereby granted, free of charge, to any =
person obtaining a copy</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# of this software and associated documentation files (the &quot;Softwa=
re&quot;), to deal</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
 in the Software without restriction, including without limitation the righ=
ts</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# to use, copy, m=
odify, merge, publish, distribute, sublicense, and/or sell</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+# copies of the Software, and to per=
mit persons to whom the Software is</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# furnished to do so, subject to the following conditions:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+# The above copyright notice and this =
permission notice shall be included in all</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+# copies or substantial portions of the Software=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+# THE SOFTWARE IS PROVIDED &quot;AS IS=
&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WA=
RRANTIES OF MERCHANTABILITY,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EV=
ENT SHALL THE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# AUTH=
ORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# LIABILITY, WHETHER IN AN A=
CTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# OUT OF OR IN CONNECTION WITH THE SOFTWA=
RE OR THE USE OR OTHER DEALINGS IN THE</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+# SOFTWARE=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#  You should have recei=
ved a copy of the GNU General Public License along</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#  with this program; if not, see &lt;https:=
//www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+import asyncio</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+import base64</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+import json</span><br><span style=3D"color: hsl(120, 100%, 40%);">+impo=
rt logging</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import pl=
atform</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+from omi import OmiProtocol</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+from omi_tools import ru=
n_main, start_management_protocol, ConnectData</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+logger =3D logging=2EgetLogger(__name__)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+class OmiAccProtocol(OmiProtocol):</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    def __init__(self, finish_future, connect_data=
:ConnectData):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   super()=2E__init__(finish_future, connect_data)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        self=2Eaccmsg =3D &quot;&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    def recv_notify_ACC(self, args):</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        # dpc1,0,eyJkcGNfcm=
Vx[=2E=2E=2E]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  protocol, fragment, b64msg =3D args=2Esplit(&quot;,&quot;, 2)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if protocol !=3D &quot;=
dpc1&quot;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    logging=2Einfo(f&quot;Received unknown ACC protocol: {protocol}&quot;)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        msg =3D base64=2Edecodebytes(b64=
msg=2Eencode())</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    self=2Eaccmsg +=3D msg=2Edecode()</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       # Message is not yet complete=2E Wait for more fragments=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if fragment !=3D &qu=
ot;0&quot;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        self=2EparseDpc1(sel=
f=2Eaccmsg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
self=2Eaccmsg =3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def =
parseDpc1(self, accmsg):</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        msg =3D json=2Eloads(accmsg)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        logging=2Eerror(f&quot;Received sys_info message: {accmsg}&quot;=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        dpc_request =3D msg[&quot;dpc=
_request&quot;]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    ver =3D dpc_request[&quot;ver&quot;]</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if ver !=3D &quot;1=2E0&quot;:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            logging=2Eerror(f&quot;=
Received unknown ACC protocol version: {ver}&quot;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        client_info =3D dpc_request=2Eget(&quot;client_info&=
quot;, False)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  antivirus =3D &quot;antivirus&quot; in dpc_request</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        disk_encryption =3D &quot;disk_en=
cryption&quot; in dpc_request</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        l=
ogger=2Einfo(f&quot;Received DPC1 request: antivirus=3D{antivirus}, disk_en=
cryption=3D{disk_encryption}, client_info=3D{client_info}&quot;)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if client_info:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            self=2E_sendDPC1ClientInfo()</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    def _sendDPC1ClientInfo(self):</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        system =3D platfor=
m=2Esystem()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if system =3D=3D &quot;Darwin&quot;:</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            system =3D &quot;MacOS&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        response =3D {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            &quot;dpc_response&quot;: {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                &quot;ver&quot;:=
 &quot;1=2E0&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                &quot;client_info&quot;: {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    &quot;os&quot;: {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                        &quot;type=
&quot;: system,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                    &quot;version&quot;: platform=2Erelease(),</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                        &quot;ex=
tra&quot;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                &quot;arch&quot;: platform=2Emachine(),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        b64msg =3D base64=2Eb64encode(json=2Edu=
mps(response)=2Eencode())=2Edecode()</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      command =3D f&quot;acc-msg\ndpc1\n6\n{b64msg}\nEND&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        self=2Equeue_command(com=
mand)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+async def main(connect_data:Conne=
ctData):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    transpo=
rt, protocol, finish_future =3D await start_management_protocol(connect_dat=
a, OmiAccProtocol)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   while True:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   await asyncio=2Esleep(1)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        print(&quot;=2E&quot;, end=3D&quot;&quot;, flush=3DTrue)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    management_version =3D await protocol=
=2Emanagement_ready()</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    print(f&quot;Management interface version: {management_version}&quot;=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    await protocol=2Eset_bytecount_in=
terval(5)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    await finish_future</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+if __name__ =3D=3D &#39;__main__&#39;:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    run_main(main)</span><br><span>\ No newl=
ine at end of file</span><br><span>diff --git a/sample/management/acc_dpc1_=
server_demo=2Epy b/sample/management/acc_dpc1_server_demo=2Epy</span><br><s=
pan>new file mode 100644</span><br><span>index 0000000=2E=2Ea62d22c</span><=
br><span>--- /dev/null</span><br><span>+++ b/sample/management/acc_dpc1_ser=
ver_demo=2Epy</span><br><span>@@ -0,0 +1,170 @@</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#!/usr/bin/env /usr/bin/python3</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+# Copyright (c) 2026 OpenVPN Inc &l=
t;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+# Copyright (c) 2026 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# Permission is hereby granted, free of charge=
, to any person obtaining a copy</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+# of this software and associated documentation files (the &qu=
ot;Software&quot;), to deal</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# in the Software without restriction, including without limitation=
 the rights</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# to use=
, copy, modify, merge, publish, distribute, sublicense, and/or sell</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+# copies of the Software, a=
nd to permit persons to whom the Software is</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+# furnished to do so, subject to the following con=
ditions:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# The above copyright notice =
and this permission notice shall be included in all</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# copies or substantial portions of the S=
oftware=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+# THE SOFTWARE IS PROVIDED =
&quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+# IMPLIED, INCLUDING BUT NOT LIMITE=
D TO THE WARRANTIES OF MERCHANTABILITY,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=
=2E IN NO EVENT SHALL THE</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# LIABILITY, WHE=
THER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# OUT OF OR IN CONNECTION WITH =
THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# SOFTWARE=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  You should =
have received a copy of the GNU General Public License along</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#  with this program; if not, see =
&lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+import asyncio</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+import base64</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+import json</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+import logging</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+import platform</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fro=
m pprint import pprint</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from sample=2Ema=
nagement=2Eomi import OMIServerProtocol</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+logger =3D logging=2EgetLogger(__name__)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+class OmiDPCServerProtocol(OMIServerProtocol):</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    def __init__(self, finish_future):</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        super()=2E__init__=
(finish_future)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    self=2Eaccmsg =3D &quot;&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
def recv_notify_ACC(self, args):</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        # 7,3,dpc1,0,eyJkcGNfcmVx[=2E=2E=2E]</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        protocol, fragment, b64msg =
=3D args=2Esplit(&quot;,&quot;, 2)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if protocol !=3D &quot;dpc1&quot;:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            logging=2Einfo(f&quot;Rec=
eived unknown ACC protocol: {protocol}&quot;)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            return</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        msg =3D base64=2Edecodebytes(b64msg=2Eencode())</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        self=2Eaccmsg +=3D msg=2E=
decode()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        # Message is not yet c=
omplete=2E Wait for more fragments=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if fragment !=3D &quot;0&quot;:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            return</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        try:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            self=2EparseDpc1(self=2Eaccmsg)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            self=2Eaccmsg =3D &quot;&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        except Ex=
ception as e:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      logger=2Eerror(f&quot;Error parsing DPC1 message: {e}&quot;, exc_info=
=3DTrue)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    def parseDpc1(self, accmsg=
):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        print(f&q=
uot;Received DPC1 message: {accmsg!r}&quot;)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        msg =3D json=2Eloads(accmsg)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        pprint(msg)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        dpc_response =3D msg[&quot;dpc_response&quot=
;]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ver =3D d=
pc_response[&quot;ver&quot;]</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if ver !=3D &quot;1=2E0&quot;:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            logging=2Eerror(f&quot;Received unk=
nown ACC protocol version: {ver}&quot;)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            return</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        client_info =3D dpc_response=2Eget(&quot;client_info&quot;, {})</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        antivirus =3D &=
quot;antivirus&quot; in dpc_response</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        disk_encryption =3D &quot;disk_encryption&quot; in=
 dpc_response</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        logger=2Einfo(f&q=
uot;Received DPC1 response: antivirus=3D{antivirus}, disk_encryption=3D{dis=
k_encryption}, client_info=3D{client_info}&quot;)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def =
_sendDPC1ClientInfo(self):</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        system =3D platform=2Esystem()</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if system =3D=3D &quot;Darwin&quot;:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            system =3D &=
quot;MacOS&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        response =3D {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;d=
pc_response&quot;: {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                &quot;ver&quot;: &quot;1=2E0&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                &quot;client_info&quot;: =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
  &quot;os&quot;: {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                        &quot;type&quot;: system,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                        &quot;version&quot;: =
platform=2Erelease(),</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                        &quot;extra&quot;:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                            {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                &quot;ar=
ch&quot;: platform=2Emachine(),</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                            }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        b64ms=
g =3D base64=2Eb64encode(json=2Edumps(response)=2Eencode())=2Edecode()</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        command =3D f&quot;acc-msg\ndpc1\=
n6\n{b64msg}\nEND&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        self=2Equeue_command(command)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    def client_event_ESTABLISHED(self, client, kid, env, extra):</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        print(f&quot;CLient=
 connected: {client}&quot;)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        pprint(env)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def cli=
ent_event_CONNECT(self, client, kid, env, extra):</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        print(f&quot;Authenticating client {c=
lient=2Ecid}, {kid}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        iv_a=
cc =3D env=2Eget(&quot;IV_ACC&quot;)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if not iv_acc:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            self=2Equeue_command(f&quot;client-auth-nt =
{client=2Ecid} {kid}&quot;)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            pass</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            #cmd =3D =
f&quot;client-auth {client=2Ecid} {kid}\npush \&quot;custom-control 1280 A:=
6 dpc1:cck1\&quot;\nEND&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            #self=2Equeue_command(cmd)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        self=2E_send_dpc1_command(client=2Ecid, kid)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    def _send_dpc1_command(self, cid, kid):</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        dpc_cmd =3D &quot;{=
\&quot;dpc_request\&quot;:{\&quot;ver\&quot;:\&quot;1=2E0\&quot;,\&quot;cor=
relation_id\&quot;:\&quot;deb4446f-2086-4af5-aa6d-ac42285ef3fe\&quot;,\&quo=
t;timestamp\&quot;:\&quot;Fri Jul 17 14:08:02=2E395 2026\&quot;,\&quot;clie=
nt_info\&quot;:true}}&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        dpc_cmd =3D &#39;{&quot;dpc_request&quot;:{&quot;ver&quot;:=
&quot;1=2E0&quot;,&quot;correlation_id&quot;:&quot;846fe236-efa0-48aa-b92e-=
35ae5823d2f7&quot;,&quot;timestamp&quot;:&quot;Fri Aug 07 17:47:24=2E370 20=
26&quot;,&quot;client_info&quot;:true}}&#39;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        dpc_cmd =3D &#39;{&quot;dpc_request&quot;:=
{&quot;ver&quot;:&quot;1=2E0&quot;,&quot;correlation_id&quot;:&quot;n/a&quo=
t;,&quot;timestamp&quot;:&quot;yesterday&quot;,&quot;client_info&quot;:true=
, &quot;disk_encryption&quot;: {&quot;full&quot;: true}, &quot;antivirus&qu=
ot;:{}}}&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        self=2Equeue_command(f&quot;client-p=
ending-auth {cid} {kid} ACC 180&quot;)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        dpc_cmd_base64 =3D base64=2Eencodebytes(dpc_cmd=2Eencode())=2Edecod=
e()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        acc_prot=
ocol =3D &quot;dpc1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # TOD=
O: Implement fragmentation</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        cmd =3D f&quot;client-acc-msg {cid} {kid}\n{acc_protocol}\n6=
\n{dpc_cmd_base64}\nEND&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        self=2Equeue_command=
(cmd)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+async def main():</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    # Get a reference to the event loop as we plan to use</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    # low-level APIs=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    loop =3D asyncio=2Eget_runn=
ing_loop()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    finish_future =3D loop=
=2Ecreate_future()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   path =3D &#39;/tmp/test-omi-server&#39;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    transport, protocol =3D await loop=2Ecreate_unix_connection(lambda:=
 OmiDPCServerProtocol(finish_future), path)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    management_version =3D await protocol=2Emanagement_ready()</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    print(f&quot;Management=
 interface version: {management_version}&quot;)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    await protocol=2Eenable_log()</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    bs =3D await protocol=2Eset_bytecount_interval(3=
0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    print(f&quot;byte set result {bs=
}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    while not finish_future=2E=
done():</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        awai=
t asyncio=2Esleep(5)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        #cs:OmiCommandResult =3D await protocol=2Eget_client_status()</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        #print(&quot;\n&=
quot;=2Ejoin(cs=2Eresult))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+if __name__ =3D=3D &#39;__main__&#39;:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    asyncio=2Erun(main())</span=
><br><span>\ No newline at end of file</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?us=
p=3Demail">change 1860</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1860?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </d=
iv>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1860 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--AeR2JlKUHBs=--


--===============9126575087400383219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9126575087400383219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9126575087400383219==--

