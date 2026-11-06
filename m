Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D553606A32F
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=P98RtNOQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Pqz52u9h;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RDgbfRDF;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=E3RG/HqK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=IPwyaUgqr1mLkdLMZhF4UW/wHHICMUrUIHJaS+m3YGM=; b=P98RtNOQbSG9uwH7VZESsnMBW/
	t+npyc72hNcielt20iuxGyj/FlQZwsG/0SxsdEZVe0DvkInAH3mqictzMBbpSXtfiXo2hdYcfZlwp
	6GmXXWq83oIAPxLXZ6GLmx1E4Y1KiA41XZj7Cca8racullrcNJHpa3EVW27+mtFsd8qg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPHyj-000000001wu-1ULh;
	Fri, 06 Nov 2026 11:19:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPHyh-000000001wo-3Yz6
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 11:19:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o4xwGlpvxMkFMRv2Wi85UFzEB0HTyAESC+m8fk9osk8=; b=Pqz52u9hT1TVsp4rF9G0ofjQIG
 FSPWcXrkASymtM9R27+1Jugh4C+eswmHzP0rBD414wMgqiFpFqfgRI0cRTFvkHqbIDt4VhU49//1R
 hULFIIMO7FZIp/jhIU83qHQbkQLiFIATkI9D3oo7gDdcb26eR1zZwCAlmSmFrgsnd3IY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o4xwGlpvxMkFMRv2Wi85UFzEB0HTyAESC+m8fk9osk8=; b=RDgbfRDFGv/2sin29cEBJaYEIq
 b8d8L8plu/AnmslD9iT3BxclDn66AlSZe5OAVti1IK93YnGrRM3hcuvz0QO7CNQWG7qnGIBp75G0P
 eK833VBd2YVQ5iq+C7i1EsN8URVrVjzzT+SkU+zZ/dWEzcRu8AIhqR9O5xLPWJ8IR8Ds=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPHyd-000000003kS-2sad for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 11:19:27 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so4862175e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 03:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793963957; x=1794568757; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=o4xwGlpvxMkFMRv2Wi85UFzEB0HTyAESC+m8fk9osk8=;
 b=E3RG/HqKGCIcF5Mihfm9OjCQbEv3lppomkr0zYuH4M8Qh4mwVK6tzIXBAoPsvfqMzE
 x/uB5Z4v5Y5gQYT1VzOj6JN/Z0dOXFTpKjWCxC73OZ4C8Hhvpvnt+6QYT9q4THGTGi14
 /ODpHV39CTgbIZsJya2TdfGqLfiRSizaO1fBIJzsreA+tqeTNQMQrp/jCdtKJDs+y6Yk
 q1Tix5f1YThMzDQXyGB4/q6LY5UfToBK0Vv4jMNziF8E7K0yVOmYnF/WgO5JoyQqEDaM
 a8YA83FVRSNkCR7oAcuQ/Dj4zir9jteRS8z3PDwHDGaLhoUb+/covWw72XM85Q1DJxdx
 pvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793963957; x=1794568757;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=o4xwGlpvxMkFMRv2Wi85UFzEB0HTyAESC+m8fk9osk8=;
 b=Po1NG+D/vEjeh9e4k301IUoXE2p6+ilSZJIEFlDUob58oasNXdK6R+330/1VxSHEI2
 pvZQgs+gNvPNLJzqgrWzzVoUfhL7AHgXmAQoO1u7C2ux5l6gSq/7bBmS12ksVWwL+pIF
 +z0TF7VRGjhd/dSttbYPzFENptMT6qR2MNiBSe0Au13711gWHTzMpcjLN6oNrBgK1+SU
 4yvFeaqTWDyQCYVH+NPBV51Ny/vkGeBth2aTnHZVeOsQK1a0rHSaaskZJ0iTnA/FBv5J
 5eaHEKkDUYeLKZJQ1TuoP+zJ1nZRItO0pSCqhRYcr+ApyQg5HwpkveZCspM61oT9nu/X
 40dA==
X-Gm-Message-State: APuU4Z/0SqISpIvFiPhr2sp7I9sy9CZsqDcyv4wYkIBoXoeF2O1bvrDa
 zaY+6/+lGklz3X77w4PHOxJOfeoJZoYaMXz1MkDk01k8NcNkH3DmI0lzUWTumtjlm91Q9o4HEIS
 X/FllYRclUXiYnny0VArEBp/Ps3ODXXrbgSu5V3SaZcpmc5x4GrIntw/dtwcSwqbAtbKceTFXA+
 zADr9n9w==
X-Gm-Gg: AYBFou2eB61fuE+6yA4qq2e6F4+MRIRPtQ2pEzlTQDjsDcYEvTo6U2egAcFzEEsrD2b
 IAwkccMPnHU/F5r93j8Oj8PXqtLylcSV2PBPoNdlNjhB1rWClwg8jWe67BW36/maJNZvxrDCDxM
 uKFJTYrBDIeNOGdJfc4BpEmQLwp9p1i6b+91Bgsr0Rmshi94TZxv7yL/TKsckrKLEwEWqRKxeLG
 i8qk2QMLvmCSrLEqzR0R1MTsOxqM+1ZXRmEHwZwEVJFP6Bva884AK9tCORuwPVHa2JmTbRn3LHR
 J/6hZM+A/cvyY9TBgBB0oXj92zUeWZqtdDsLJO2lS7JrqJgmwUIq958x8o1dAVkhVW7sTbDUHya
 k7j8+1b0VL83v9YDm3SjxCSnybjZjzjihr19xkJCH+UWQMBcADXoXd25r6+wBXKUYIYJQ5xQhwh
 duTLiCu5fgz8828qA3iSXwaQFFXBY7ZFnNxjOIam5+SPqjYW4KwF1Jdv+bio+8AakvBnlWzKhge
 wIsKIO0NgxCLgB75C2HM0U0541AVbCaAvoXzA6/r/5ZhMPK5l0jfQmsMfggeWR2dYmH+d1MajLO
 32ZqrmYlr3oLuWbhtyjd+5U9ESXVEO0b/qer2mSgWgs0DprJCAnMcEFk91+xMfPv0L54GnViwAy
 019CVYxMBjTMJJHVNJ+VTodt2tWMJqCvQifTNjpX2iXt8KVL8L6bpTM+TLeuaV4kffeDu6ySF4S
 q67Di68JlumjMrnnA8aD4qKFyh6m/KYiKNLrs=
X-Received: by 2002:a05:6000:2f87:b0:487:27f9:844 with SMTP id
 ffacd0b85a97d-4927835f35bmr4399877f8f.57.1793963956843; 
 Fri, 06 Nov 2026 03:19:16 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d6d6385fsm3020890f8f.16.2026.11.06.03.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 03:19:16 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 11:19:14 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22
X-Gerrit-Change-Number: 1860
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1860?usp=email>
X-Gerrit-Commit: 7f025ccb993f974b4c2c82efd5fd1253f4a957b9
In-Reply-To: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
References: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzQ1NDE2MDAwLkllMjAyODk3MzdkNTAyYTI1ZWVkYzYwNjc3ZDNjMzUwZGRjM2IzYzIyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1afa4b56a6692c257bde1001fd79fb4ea1ca5323-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xPHyd-000000003kS-2sad
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add python scripts
 that demonstrate using the dpc1 ACC protocol
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
Content-Type: multipart/mixed; boundary="===============7878947912294045820=="
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7878947912294045820==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VzBN/b3sM7o="; charset=UTF-8

--VzBN/b3sM7o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Name of user not set #1000061, Ralf L=
ici=2E

Arne Schwabe has uploaded a new patch set (#9)=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail )


Change subject: Add pytho=
n scripts that demonstrate using the dpc1 ACC protocol
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add python scripts that demonst=
rate using the dpc1 ACC protocol

The dpc1 protocol is used by the OpenVPN =
Connect clients and
OpenVPN Connexa=2E

Change-Id: Ie20289737d502a25eedc606=
77d3c350ddc3b3c22
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
A sa=
mple/management/acc_dpc1_client_demo=2Epy
A sample/management/acc_dpc1_serv=
er_demo=2Epy
2 files changed, 268 insertions(+), 0 deletions(-)


  git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/60/1860/9

diff -=
-git a/sample/management/acc_dpc1_client_demo=2Epy b/sample/management/acc_=
dpc1_client_demo=2Epy
new file mode 100755
index 0000000=2E=2E9849f15
--- /=
dev/null
+++ b/sample/management/acc_dpc1_client_demo=2Epy
@@ -0,0 +1,110 @=
@
+#!/usr/bin/env python3
+# Copyright (c) 2026 OpenVPN Inc <sales@openvpn=
=2Enet>
+# Copyright (c) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+#
+# Permi=
ssion is hereby granted, free of charge, to any person obtaining a copy
+# =
of this software and associated documentation files (the "Software"), to de=
al
+# in the Software without restriction, including without limitation the=
 rights
+# to use, copy, modify, merge, publish, distribute, sublicense, an=
d/or sell
+# copies of the Software, and to permit persons to whom the Soft=
ware is
+# furnished to do so, subject to the following conditions:
+#
+# T=
he above copyright notice and this permission notice shall be included in a=
ll
+# copies or substantial portions of the Software=2E
+#
+# THE SOFTWARE =
IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, I=
NCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS F=
OR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE
+# AUT=
HORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIAB=
ILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+=
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN=
 THE
+# SOFTWARE=2E
+
+# This implements a small demonstration of using the=

+# OpenVPN Access Server Management Interface (OMI) and an app Custom Cont=
rol
+# protocol (dpc1)=2E To use this use on the client use
+
+# --manageme=
nt-client-auth
+# --app-custom-control dpc1
+# --management /path/to/acc_dp=
c1_client_demo=2Epy unix-script
+
+import base64
+import json
+import loggi=
ng
+import platform
+from asyncio import CancelledError, Future
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
+
+class OmiDpc1ClientProtocol(OMIClien=
tProtocol):
+    def __init__(self, finish_future: Future, connect_data: Co=
nnectData):
+        super()=2E__init__(finish_future, connect_data)
+
+   =
 async def receive_acc_dpc1(self, acc_message: bytes):
+        msg =3D jso=
n=2Eloads(acc_message)
+
+        logger=2Eerror(f"Received dpc1 message: {=
acc_message}")
+
+        dpc_request =3D msg["dpc_request"]
+        ver =
=3D dpc_request["ver"]
+        if ver !=3D "1=2E0":
+            logger=2E=
warning(f"Received unknown ACC protocol version: {ver}")
+            retur=
n
+
+        client_info =3D dpc_request=2Eget("client_info", False)
+     =
   antivirus =3D "antivirus" in dpc_request
+        disk_encryption =3D "d=
isk_encryption" in dpc_request
+
+        logger=2Einfo(
+            f"Rec=
eived DPC1 request: antivirus=3D{antivirus}, disk_encryption=3D{disk_encryp=
tion}, client_info=3D{client_info}")
+
+        if client_info:
+          =
  await self=2E_send_dpc1_client_info()
+
+    async def _send_dpc1_client_=
info(self):
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
+        acc_msg =3D json=2Edumps(response)=2Eencode()
+        await sel=
f=2Esend_acc_msg("dpc1", acc_msg)
+
+
+async def main(connect_data: Connect=
Data):
+    transport, protocol, finish_future =3D await start_management_p=
rotocol(connect_data, OmiDpc1ClientProtocol)
+
+    management_version =3D =
await protocol=2Emanagement_ready()
+    logger=2Edebug(f"Management interf=
ace version: {management_version}")
+
+    await protocol=2Eset_bytecount_i=
nterval(5)
+
+    try:
+        await finish_future
+    except CancelledEr=
ror:
+        # Ignore errors like ones caused by Control+C in the demo scr=
ipt
+        pass
+
+
+if __name__ =3D=3D '__main__':
+    run_main(main)
d=
iff --git a/sample/management/acc_dpc1_server_demo=2Epy b/sample/management=
/acc_dpc1_server_demo=2Epy
new file mode 100755
index 0000000=2E=2E1e43914
=
--- /dev/null
+++ b/sample/management/acc_dpc1_server_demo=2Epy
@@ -0,0 +1,=
158 @@
+#!/usr/bin/env python3
+# Copyright (c) 2026 OpenVPN Inc <sales@ope=
nvpn=2Enet>
+# Copyright (c) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+#
+# P=
ermission is hereby granted, free of charge, to any person obtaining a copy=

+# of this software and associated documentation files (the "Software"), t=
o deal
+# in the Software without restriction, including without limitation=
 the rights
+# to use, copy, modify, merge, publish, distribute, sublicense=
, and/or sell
+# copies of the Software, and to permit persons to whom the =
Software is
+# furnished to do so, subject to the following conditions:
+#
=
+# The above copyright notice and this permission notice shall be included =
in all
+# copies or substantial portions of the Software=2E
+#
+# THE SOFTW=
ARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIE=
D, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNE=
SS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE
+#=
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# =
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FRO=
M,
+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN THE
+# SOFTWARE=2E
+
+# This implements a small demonstration of using=
 the
+# OpenVPN Access Server Management Interface (OMI) and an app Custom =
Control
+# protocol (dpc1)=2E To use this use on the server
+
+# --manageme=
nt-client-auth
+# --app-custom-control dpc1
+# --management /path/to/acc_dp=
c1_server_demo=2Epy unix-script
+
+# Note this is just a demonstration and =
not a production-ready solution=2E
+# When modifying this code, keep the se=
curity in mind=2E It is easy to
+# introduce a security problem when writin=
g scripts handling authentication
+
+import asyncio
+import json
+import lo=
gging
+from asyncio import Future
+from dataclasses import field, dataclass=

+from typing import Dict
+
+logging=2EbasicConfig()
+
+from omi_server_pro=
tocol import OMIServerProtocol, ConnectedClient
+from omi_tools import star=
t_management_protocol, ConnectData, run_main
+
+logger =3D logging=2EgetLog=
ger(__name__)
+
+
+@dataclass
+class DpcConnectedClient(ConnectedClient):
+=
    # Remember the key-id is still pending authentication
+    pending_dpc_=
kid: int =3D -1
+    env: Dict[str, str] =3D field(default_factory=3Ddict)
=
+
+
+class OmiDPCServerProtocol(OMIServerProtocol):
+    def __init__(self,=
 finish_future: Future, connect_data: ConnectData):
+        super()=2E__in=
it__(finish_future, connect_data)
+        self=2E_connected_client_class =
=3D DpcConnectedClient
+
+    def receive_acc_client_dpc1(self, client: Dpc=
ConnectedClient, kid: int, acc_message: bytes):
+        logger=2Einfo(f"Re=
ceived DPC1 message: {acc_message!r}")
+        msg =3D json=2Eloads(acc_me=
ssage)
+
+        dpc_response =3D msg["dpc_response"]
+        ver =3D dpc=
_response["ver"]
+        if ver !=3D "1=2E0":
+            logger=2Eerror(=
f"Received unknown ACC protocol version: {ver}")
+            return
+
+   =
     client_info =3D dpc_response=2Eget("client_info", {})
+        antivir=
us =3D "antivirus" in dpc_response
+        disk_encryption =3D "disk_encry=
ption" in dpc_response
+
+        logger=2Einfo(
+            f"Received DP=
C1 response: antivirus=3D{antivirus}, disk_encryption=3D{disk_encryption}, =
client_info=3D{client_info}")
+
+        # Normally here would be a check t=
hat the response matches the policy
+        # this demo script just allows=
 everyone with a response to pass
+        if kid =3D=3D client=2Epending_d=
pc_kid:
+            client=2Epending_dpc_kid =3D -1
+            self=2Ead=
d_background_task(self=2Eauthenticate_client(client, kid))
+
+    async def=
 authenticate_client(self, client: DpcConnectedClient, kid:int):
+        #=
 Simulate that we think a bit about the response
+        await asyncio=2Es=
leep(3)
+        await self=2Equeue_command(f"client-auth-nt {client=2Ecid}=
 {kid}")
+
+    async def dpc_request_timeout(self, client: DpcConnectedCli=
ent, kid: int, timeout: int):
+        await asyncio=2Esleep(timeout)
+    =
    if client=2Epending_dpc_kid !=3D kid:
+            return
+
+        cl=
ient_deny =3D f'client-deny {client=2Ecid} {kid} "dpc1 timeout" "Timeout on=
 device posture"'
+        await self=2Equeue_command(client_deny)
+
+    d=
ef client_event_ESTABLISHED(self, client: DpcConnectedClient, kid: int, env=
: dict, extra: str):
+        print(f"CLient connected: {client}")
+
+    a=
sync def send_client_deny_no_dpc1(self, client: DpcConnectedClient, kid: in=
t):
+        client_reason =3D "ACC[protocol dpc1]: To connect to this serv=
er you " \
+                        "need to upgrade to a client that suppo=
rts the " \
+                        "OpenVPN Inc device posture protocol a=
nd has it " \
+                        "enabled, e=2Eg=2E OpenVPN for Andro=
id, openvpn3-linux, " \
+                        "or OpenVPN Connect"
+    =
    client_deny =3D f'client-deny {client=2Ecid} {kid} "no dpc1 support" "{=
client_reason}"'
+        await self=2Equeue_command(client_deny)
+
+    de=
f client_event_CONNECT(self, client: DpcConnectedClient, kid: int, env: dic=
t, extra: str):
+        print(f"Authenticating client {client}, {kid}, pro=
tos: {client=2Eacc_negotiated_protocols}")
+        client=2Eenv =3D env
+ =
       self=2Eadd_background_task(self=2Echeck_client_posture(client, kid))=

+
+    def client_event_REAUTH(self, client: DpcConnectedClient, kid: int,=
 env: dict, extra: str):
+        print(f"Re-authenticating client {client}=
, {kid}, protos: {client=2Eacc_negotiated_protocols}")
+        client=2Een=
v =3D env
+        # Check client posture again on renegotiation
+        s=
elf=2Eadd_background_task(self=2Echeck_client_posture(client, kid))
+
+    =
async def check_client_posture(self, client: DpcConnectedClient, kid: int):=

+        await self=2Equeue_command(
+            f"client-pending-auth {c=
lient=2Ecid} {kid} \"NOTIFY::Checking your device posture, please wait\" 18=
0")
+
+        await self=2Equeue_command(f"client-pending-auth {client=2Ec=
id} {kid} ACC 180")
+        # In this example we wait for 20 seconds to si=
mulate a posture check on the server
+        await asyncio=2Esleep(20)
+
+=
        if "dpc1" not in client=2Eacc_negotiated_protocols:
+            aw=
ait self=2Esend_client_deny_no_dpc1(client, kid)
+            return
+
+   =
     dpc_cmd =3D {"dpc_request": {"ver": "1=2E0", "correlation_id": "n/a", =
"timestamp": "yesterday", "client_info": True,
+                           =
        "disk_encryption": {"full": True}, "antivirus": {}}}
+
+        dpc=
_cmd_str =3D json=2Edumps(dpc_cmd)
+        acc_protocol =3D "dpc1"
+
+    =
    client=2Epending_dpc_kid =3D kid
+        await self=2Esend_acc_msg(cli=
ent, kid, acc_protocol, dpc_cmd_str=2Eencode())
+        self=2Eadd_backgro=
und_task(self=2Edpc_request_timeout(client, kid, 60))
+
+
+async def main(c=
onnect_data: ConnectData):
+    transport, protocol, finish_future =3D awai=
t start_management_protocol(connect_data, OmiDPCServerProtocol)
+
+    mana=
gement_version =3D await protocol=2Emanagement_ready()
+    logger=2Edebug(=
f"Management interface version: {management_version}")
+
+    await protoco=
l=2Eenable_log()
+
+    await protocol=2Eset_bytecount_interval(5)
+
+    a=
wait finish_future
+
+
+if __name__ =3D=3D '__main__':
+    run_main(main)
=

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie20289737d502a=
25eedc60677d3c350ddc3b3c22
Gerrit-Change-Number: 1860
Gerrit-PatchSet: 9
Ge=
rrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Name of us=
er not set #1000061
Gerrit-CC: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: N=
ame of user not set #1000061
Gerrit-Attention: Ralf Lici <ralf@mandelbit=2E=
com>

--VzBN/b3sM7o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Name of user not set #1000061, Ralf Lici=2E </p>
<p>A=
rne Schwabe <strong>uploaded patch set #9</strong> to this change=2E</p><p>=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail">Vie=
w Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Add python scripts that demonstrate using the=
 dpc1 ACC protocol<br><br>The dpc1 protocol is used by the OpenVPN Connect =
clients and<br>OpenVPN Connexa=2E<br><br>Change-Id: Ie20289737d502a25eedc60=
677d3c350ddc3b3c22<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt=
;<br>---<br>A sample/management/acc_dpc1_client_demo=2Epy<br>A sample/manag=
ement/acc_dpc1_server_demo=2Epy<br>2 files changed, 268 insertions(+), 0 de=
letions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/60/1860/9</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/sample/managemen=
t/acc_dpc1_client_demo=2Epy b/sample/management/acc_dpc1_client_demo=2Epy</=
span><br><span>new file mode 100755</span><br><span>index 0000000=2E=2E9849=
f15</span><br><span>--- /dev/null</span><br><span>+++ b/sample/management/a=
cc_dpc1_client_demo=2Epy</span><br><span>@@ -0,0 +1,110 @@</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#!/usr/bin/env python3</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+# Copyright (c) 2026 OpenVPN Inc =
&lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# Copyright (c) 2026 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+# Permission is hereby granted, free of char=
ge, to any person obtaining a copy</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+# of this software and associated documentation files (the &=
quot;Software&quot;), to deal</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+# in the Software without restriction, including without limitati=
on the rights</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# to u=
se, copy, modify, merge, publish, distribute, sublicense, and/or sell</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+# copies of the Software,=
 and to permit persons to whom the Software is</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+# furnished to do so, subject to the following c=
onditions:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+# The above copyright notic=
e and this permission notice shall be included in all</span><br><span style=
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
;">+# This implements a small demonstration of using the</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+# OpenVPN Access Server Management Int=
erface (OMI) and an app Custom Control</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+# protocol (dpc1)=2E To use this use on the client use</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+# --management-client-auth</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+# --app-custom-control dpc1</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+# --management /path/to/a=
cc_dpc1_client_demo=2Epy unix-script</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+im=
port base64</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import j=
son</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import logging</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+import platform</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+from asyncio import Cance=
lledError, Future</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+logging=2EbasicConfig=
()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+from omi_tools import run_main, star=
t_management_protocol, ConnectData</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+from omi_client_protocol import OMIClientProtocol</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+logger =3D logging=2EgetLogger(__name__)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+class OmiDpc1ClientProtocol(OMIClientProtocol):=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def __init__(se=
lf, finish_future: Future, connect_data: ConnectData):</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        super()=2E__init__(finish_future=
, connect_data)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    async def receive_a=
cc_dpc1(self, acc_message: bytes):</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        msg =3D json=2Eloads(acc_message)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        logger=2Eerror(f&quot;Received dpc1 message: {acc=
_message}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        dpc_request =
=3D msg[&quot;dpc_request&quot;]</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        ver =3D dpc_request[&quot;ver&quot;]</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if ver !=3D &quot;1=2E0&quot;=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            logger=
=2Ewarning(f&quot;Received unknown ACC protocol version: {ver}&quot;)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            return</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        client_info =3D dpc_request=2Eget(&qu=
ot;client_info&quot;, False)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        antivirus =3D &quot;antivirus&quot; in dpc_request</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        disk_encryption =3D=
 &quot;disk_encryption&quot; in dpc_request</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        logger=2Einfo(</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            f&quot;Received DPC1 request: antivirus=3D{antivirus}, =
disk_encryption=3D{disk_encryption}, client_info=3D{client_info}&quot;)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if client_info:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            await self=2E_send_dpc1_c=
lient_info()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    async def _send_dpc1_c=
lient_info(self):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      system =3D platform=2Esystem()</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if system =3D=3D &quot;Darwin&quot;:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            system =3D &quot;MacO=
S&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        response =3D {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;dpc_respon=
se&quot;: {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        &quot;ver&quot;: &quot;1=2E0&quot;,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                &quot;client_info&quot;: {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    &quot;os=
&quot;: {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
              &quot;type&quot;: system,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                        &quot;version&quot;: platform=
=2Erelease(),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                  &quot;extra&quot;:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                            {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                &quot;arch&quot;=
: platform=2Emachine(),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                            }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        acc_msg =3D j=
son=2Edumps(response)=2Eencode()</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        await self=2Esend_acc_msg(&quot;dpc1&quot;, acc_msg)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+async def main(connect_data: ConnectData):</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    transport, protocol, finish_futu=
re =3D await start_management_protocol(connect_data, OmiDpc1ClientProtocol)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    management_version =3D await proto=
col=2Emanagement_ready()</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    logger=2Edebug(f&quot;Management interface version: {management_ve=
rsion}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    await protocol=2Eset_=
bytecount_interval(5)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    try:</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        await finish_future<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    except Cancelled=
Error:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # Ign=
ore errors like ones caused by Control+C in the demo script</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        pass</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if _=
_name__ =3D=3D &#39;__main__&#39;:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    run_main(main)</span><br><span>diff --git a/sample/manag=
ement/acc_dpc1_server_demo=2Epy b/sample/management/acc_dpc1_server_demo=2E=
py</span><br><span>new file mode 100755</span><br><span>index 0000000=2E=2E=
1e43914</span><br><span>--- /dev/null</span><br><span>+++ b/sample/manageme=
nt/acc_dpc1_server_demo=2Epy</span><br><span>@@ -0,0 +1,158 @@</span><br><s=
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
 hsl(120, 100%, 40%);">+# protocol (dpc1)=2E To use this use on the server<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+# --management-client-auth</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+# --app-custom-control dpc1</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+# --management /path/to/=
acc_dpc1_server_demo=2Epy unix-script</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
 Note this is just a demonstration and not a production-ready solution=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# When modifying this=
 code, keep the security in mind=2E It is easy to</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+# introduce a security problem when writing s=
cripts handling authentication</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import a=
syncio</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import json</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+import logging</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+from asyncio import Future=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from dataclasses im=
port field, dataclass</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+from typing import Dict</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+logging=2Ebas=
icConfig()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+from omi_server_protocol imp=
ort OMIServerProtocol, ConnectedClient</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+from omi_tools import start_management_protocol, Connect=
Data, run_main</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+logger =3D logging=2Eget=
Logger(__name__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+@dataclass</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+class DpcConnectedClient(ConnectedClient):</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    # Remember the key-id i=
s still pending authentication</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    pending_dpc_kid: int =3D -1</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    env: Dict[str, str] =3D field(default_factory=3D=
dict)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+class OmiDPCServerProtocol(OMIServerProtocol):</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    def __init__(self, fi=
nish_future: Future, connect_data: ConnectData):</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        super()=2E__init__(finish_future, conn=
ect_data)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        se=
lf=2E_connected_client_class =3D DpcConnectedClient</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    def receive_acc_client_dpc1(self, client: DpcConnectedCl=
ient, kid: int, acc_message: bytes):</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        logger=2Einfo(f&quot;Received DPC1 message: {acc_m=
essage!r}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     msg =3D json=2Eloads(acc_message)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        dpc_response =3D msg[&quot;dpc_response&quot;]</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        ver =3D dpc_response[&quot;ver&q=
uot;]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if ver=
 !=3D &quot;1=2E0&quot;:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            logger=2Eerror(f&quot;Received unknown ACC protocol versio=
n: {ver}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        client_info =3D =
dpc_response=2Eget(&quot;client_info&quot;, {})</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        antivirus =3D &quot;antivirus&quot; in =
dpc_response</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 disk_encryption =3D &quot;disk_encryption&quot; in dpc_response</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        logger=2Einfo(</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            f&quot;Received DPC1 response: ant=
ivirus=3D{antivirus}, disk_encryption=3D{disk_encryption}, client_info=3D{c=
lient_info}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # Normally h=
ere would be a check that the response matches the policy</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        # this demo script just allow=
s everyone with a response to pass</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if kid =3D=3D client=2Epending_dpc_kid:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            client=2Epending_dpc=
_kid =3D -1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    self=2Eadd_background_task(self=2Eauthenticate_client(client, kid))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    async def authenticate_client(self, c=
lient: DpcConnectedClient, kid:int):</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        # Simulate that we think a bit about the response<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        await asynci=
o=2Esleep(3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 await self=2Equeue_command(f&quot;client-auth-nt {client=2Ecid} {kid}&quot=
;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    async def dpc_request_timeout(se=
lf, client: DpcConnectedClient, kid: int, timeout: int):</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        await asyncio=2Esleep(timeout)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if client=
=2Epending_dpc_kid !=3D kid:</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            return</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cli=
ent_deny =3D f&#39;client-deny {client=2Ecid} {kid} &quot;dpc1 timeout&quot=
; &quot;Timeout on device posture&quot;&#39;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        await self=2Equeue_command(client_deny)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    def client_event_ESTABLISHED(self, cl=
ient: DpcConnectedClient, kid: int, env: dict, extra: str):</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        print(f&quot;CLient connect=
ed: {client}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    async def send_=
client_deny_no_dpc1(self, client: DpcConnectedClient, kid: int):</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        client_reason =3D &quo=
t;ACC[protocol dpc1]: To connect to this server you &quot; \</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                        &quot;need=
 to upgrade to a client that supports the &quot; \</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                        &quot;OpenVPN Inc de=
vice posture protocol and has it &quot; \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                        &quot;enabled, e=2Eg=2E OpenV=
PN for Android, openvpn3-linux, &quot; \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                        &quot;or OpenVPN Connect&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        client_deny=
 =3D f&#39;client-deny {client=2Ecid} {kid} &quot;no dpc1 support&quot; &qu=
ot;{client_reason}&quot;&#39;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        await self=2Equeue_command(client_deny)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    def client_event_CONNECT(self, client: DpcConnectedC=
lient, kid: int, env: dict, extra: str):</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        print(f&quot;Authenticating client {client}, {=
kid}, protos: {client=2Eacc_negotiated_protocols}&quot;)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        client=2Eenv =3D env</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        self=2Eadd_background=
_task(self=2Echeck_client_posture(client, kid))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    def client_event_REAUTH(self, client: DpcConnectedClient, kid:=
 int, env: dict, extra: str):</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        print(f&quot;Re-authenticating client {client}, {kid}, pr=
otos: {client=2Eacc_negotiated_protocols}&quot;)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        client=2Eenv =3D env</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        # Check client posture again =
on renegotiation</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     self=2Eadd_background_task(self=2Echeck_client_posture(client, kid))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    async def check_client_posture(self,=
 client: DpcConnectedClient, kid: int):</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        await self=2Equeue_command(</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            f&quot;client-pending-auth =
{client=2Ecid} {kid} \&quot;NOTIFY::Checking your device posture, please wa=
it\&quot; 180&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        await self=
=2Equeue_command(f&quot;client-pending-auth {client=2Ecid} {kid} ACC 180&qu=
ot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # In th=
is example we wait for 20 seconds to simulate a posture check on the server=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        await async=
io=2Esleep(20)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if &quot;dpc1&qu=
ot; not in client=2Eacc_negotiated_protocols:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            await self=2Esend_client_deny_no_dpc1=
(client, kid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        dpc_cmd =3D {&quot=
;dpc_request&quot;: {&quot;ver&quot;: &quot;1=2E0&quot;, &quot;correlation_=
id&quot;: &quot;n/a&quot;, &quot;timestamp&quot;: &quot;yesterday&quot;, &q=
uot;client_info&quot;: True,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                   &quot;disk_encryption&quot;: {&=
quot;full&quot;: True}, &quot;antivirus&quot;: {}}}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        dpc_cmd_str =3D json=2Edumps(dpc_cmd)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        acc_protocol =3D &quot;dpc=
1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        client=2Epending_dpc_ki=
d =3D kid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        aw=
ait self=2Esend_acc_msg(client, kid, acc_protocol, dpc_cmd_str=2Eencode())<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2Eadd_b=
ackground_task(self=2Edpc_request_timeout(client, kid, 60))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+async def main(connect_data: ConnectData):</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    transport, protocol, finish_future =3D await s=
tart_management_protocol(connect_data, OmiDPCServerProtocol)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    management_version =3D await protocol=2Emanagemen=
t_ready()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    logger=
=2Edebug(f&quot;Management interface version: {management_version}&quot;)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    await protocol=2Eenable_log()</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    await protocol=2Eset_bytecount_interval(5=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    await finish_future</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+if __name__ =3D=3D &#39;__main__&#39;:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    run_main(main)</span><br></pre><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail">ch=
ange 1860</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 1860 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: Name of user not set #1000061 </div>
<div style=3D"display:=
none"> Gerrit-CC: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Name=
 of user not set #1000061 </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>

</body></html>
--VzBN/b3sM7o=--


--===============7878947912294045820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7878947912294045820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7878947912294045820==--

