Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443B4606A31B
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Y1X04t9J;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=muH7jy5/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HxQyRNiY;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IJ6aViZ+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QCDtsPfqLFB1Scr/wjKTpGWX/mykewqGq/KeL7ktOnc=; b=Y1X04t9JJXsOG+4V5lbH8lCxj4
	7zCokpKci2GxWo5nvCfFnu0Y68gRTkZ0nOLsMOCu8QWWnDfid05Ioc+VFEcqPDoTIPQfb1iJ1oB0C
	RcOsN09DQaaMXrakH3vMlsvPWXihxHpNtv+Q9lsFyKyDF9S8yXmoavDL9FallDypLr3E=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOyQi-000000003Wq-41c9;
	Thu, 05 Nov 2026 14:27:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOyQh-000000003Wj-1xqJ
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 14:27:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Tgz1VlEgmKfPWjnySSsaXGGg8poLoJ7eDCbelZaYlfI=; b=muH7jy5/y3u+jiujXXsPh0tCiw
 SEWo4VBwYzNylXoHrq1K1qF6n5onll2JL3yQWJUze2R29X35GptvNgW48SOn/33PB1sSywp23Xiab
 9i3qaRgB6PWCIkQKOXib1jeWqv4W3m+xqbJPhFOB8ZP2EFtzuL6Bi8fWSEqqgGpe5ivw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Tgz1VlEgmKfPWjnySSsaXGGg8poLoJ7eDCbelZaYlfI=; b=HxQyRNiYJV0oezJYl9bTqS2JTQ
 RnFvE69DJxT6G+tduREn9i9JUsK87/jBKcgrdrkhJysFASCyj/EAR6VAqKmu1VeOHSqr13uxlKJ8X
 P1m1Sst5VXz/yZ0w8Zxh1Poj5jDrwB6ihe2USDh/o9vyxa949J0Z/Lfq1yqYd0hHEZ3Y=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOyQf-000000006IB-1iZU for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 14:27:03 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so14104545e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 06:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793888815; x=1794493615; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Tgz1VlEgmKfPWjnySSsaXGGg8poLoJ7eDCbelZaYlfI=;
 b=IJ6aViZ++9CpEjyykoH7pnX598NSB8qSdXlAOirHDpR4FJoGEobY8bJh9SmsDty3dP
 7OTHNBeZgHRBka7umXzQPbAaH9VtSPKUO1nuCofqk4dX//a2DCD7D/P/KBHnACR2llzQ
 mdUQekOBGiFidWa7ui6PFtHbKF0slxTT9E0I2jQnc1guIxbImtfboBgeQBKztSisa4tJ
 AQhPURNaX0rV18XoV8y7y3dig9H4WSTd5nHxSs9dwLzmkbl18K0iGbsqPg67P8nG1C2R
 Ii9XRWyvMN8o18VOeWLcpYB6ddLw8ovu1bBwKY3IB9fiSnXuApn8snsQiOBBZoZbhjsY
 mZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793888815; x=1794493615;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Tgz1VlEgmKfPWjnySSsaXGGg8poLoJ7eDCbelZaYlfI=;
 b=v+IUbjeNxZ/kjmbzN+T2qiX/n918J/OhyD0d6b0TFo/ZdAl9YPMIMoNwbQVwvfLEAv
 z/w4pu0IJPl0Qu72euPRmmtJNLGQzoc89tCz1cXPE1ewxtbMEayutLg6QGwWGYCztTvE
 4Qq+hDiW62rSRGq8qQzZftAx6+eud5DugSPAJXtP6n7qa34KPSXvwHRo4c4+dpd6SuBy
 HjCIcdUglqGi7e2X5jPhJ3d4D8E+qUbKkH85m6pXDzFN1466D5dAVPSiD8SP1Fi5b1nS
 cmR3ElLNj3yByPsdmrJJwd68wwp5Zng3blIqE6WqhrD/9l81aw6n2Ufq1UYJKwmrLPrh
 VXXA==
X-Gm-Message-State: APuU4Z8VROW+KMzLt1CbRQ+Ns7PereKuMvXg7hrjrSDzttcI5DyxOKNO
 12J24T42ptHdhHuySiG7YTM854x1nF1ZWHqTSAXf7j94l6Lb9muxnuzp8q5kdo2VrXAhep32TgP
 wKkya27DIZ9KksRA9It1AdZAlhql9wAEHDYsnFBNIzW7gn/ofkg8urZ5eHuhb91OQtOSMJekngu
 EW5f4nZQ==
X-Gm-Gg: AYBFou02IKMRhpWhP+SV5I2855EOP7D/OzTa302n2hIdrs5JtFLLjM1yMUINM7lSg3J
 bonG7pdtTW9h28/Ek1IDck9eOvsZA6VNJh7adcgsmZLnHxwfJIpwuPoOmlTLGwZOUeqfCOHe2AB
 HbXo4GyvE8D4PeOB+PehYR+EZnUyqDDTRoOtz+tukEncGGg5piogLhkwlZ4TN5KLniofDlh534E
 ThQ5HcK9rsi8Easc0rd1Gfgxnj3Vf34FVZkrTjSXbAP0rniSoqR8Y9EQW6YZt5vSWGvDK7kqq7X
 /r1t9FpZe94Q+oDzUJZJGvQLhFx6bX3TYexPq7mTeW2k5ESUWj7cC0iZOfMVCkzxBUKVl+okDUk
 5V6uBm9aevzKef0Pd8Ern5U6cGw6Ehc+JIsd/J2Mjdjo8y3ZkzvE7rO3OVrzCm83LTNxDfehOzU
 ufSmN1DcgE2XJt8PghhEutw4tjEX5xyuD8wYulRdJewQnkQyknpQ6WpWERM2exciGkOZ+9HH8Z9
 57C8DawJsGI+IrRch/fXWgMh00GZT1oPU2sI/YODR7wP+U6k4oxONJ+wl3/PahF6tQgys1w36vZ
 PasGECol9oRfvsbreTZPAeghlewz2xOlzU//6vZf6JC3hvPNfPTGlpLr7Lql9hV8RJM6jB4mW/P
 ox6pc1qNyGniGiY6jubHNim38xNFxCD2VdR9r5tPw4IVn/IdBHcgPNJRxJsSZj8gCN8LXcxyllM
 pLvuokBsEXyvEaBA==
X-Received: by 2002:a05:600c:e552:b0:4b1:4da2:ca99 with SMTP id
 5b1f17b1804b1-4b14da2cb6fmr191497485e9.10.1793888814596; 
 Thu, 05 Nov 2026 06:26:54 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56b78d656sm80644105e9.0.2026.11.05.06.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 06:26:54 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 14:26:49 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22
X-Gerrit-Change-Number: 1860
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1860?usp=email>
X-Gerrit-Commit: 6e50bb1d2c9a151a25a3ebdec30e88c37bd787f5
In-Reply-To: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
References: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzQ1NDE2MDAwLkllMjAyODk3MzdkNTAyYTI1ZWVkYzYwNjc3ZDNjMzUwZGRjM2IzYzIyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <88655f5ac15a8d9e5b463d616eff63ce4fb9445d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOyQf-000000006IB-1iZU
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
Content-Type: multipart/mixed; boundary="===============3287800955205749787=="
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3287800955205749787==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="33YDqFcFErI="; charset=UTF-8

--33YDqFcFErI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Arne Schwabe has upl=
oaded a new patch set (#8)=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1860?usp=3Demail )


Change subject: Add python scripts that demonstrate us=
ing the dpc1 ACC protocol
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

Add python scripts that demonstrate using the dpc1 ACC protoc=
ol

The dpc1 protocol is used by the OpenVPN Connect clients and
OpenVPN Co=
nnexa=2E

Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22
Signed-off-b=
y: Arne Schwabe <arne@rfc2549=2Eorg>
---
A sample/management/acc_dpc1_clien=
t_demo=2Epy
A sample/management/acc_dpc1_server_demo=2Epy
2 files changed, =
267 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/60/1860/8

diff --git a/sample/management/acc_d=
pc1_client_demo=2Epy b/sample/management/acc_dpc1_client_demo=2Epy
new file=
 mode 100755
index 0000000=2E=2E9849f15
--- /dev/null
+++ b/sample/manageme=
nt/acc_dpc1_client_demo=2Epy
@@ -0,0 +1,110 @@
+#!/usr/bin/env python3
+# C=
opyright (c) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+# Copyright (c) 2026 A=
rne Schwabe <arne@rfc2549=2Eorg>
+#
+# Permission is hereby granted, free o=
f charge, to any person obtaining a copy
+# of this software and associated=
 documentation files (the "Software"), to deal
+# in the Software without r=
estriction, including without limitation the rights
+# to use, copy, modify=
, merge, publish, distribute, sublicense, and/or sell
+# copies of the Soft=
ware, and to permit persons to whom the Software is
+# furnished to do so, =
subject to the following conditions:
+#
+# The above copyright notice and t=
his permission notice shall be included in all
+# copies or substantial por=
tions of the Software=2E
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WA=
RRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE=
 WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NON=
INFRINGEMENT=2E IN NO EVENT SHALL THE
+# AUTHORS OR COPYRIGHT HOLDERS BE LI=
ABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF =
CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+# OUT OF OR IN CONNECTION WITH =
THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+# SOFTWARE=2E
+
+# This i=
mplements a small demonstration of using the
+# OpenVPN Access Server Manag=
ement Interface (OMI) and an app Custom Control
+# protocol (dpc1)=2E To us=
e this use on the client use
+
+# --management-client-auth
+# --app-custom-=
control dpc1
+# --management /path/to/acc_dpc1_client_demo=2Epy unix-script=

+
+import base64
+import json
+import logging
+import platform
+from async=
io import CancelledError, Future
+
+logging=2EbasicConfig()
+
+from omi_too=
ls import run_main, start_management_protocol, ConnectData
+from omi_client=
_protocol import OMIClientProtocol
+
+logger =3D logging=2EgetLogger(__name=
__)
+
+class OmiDpc1ClientProtocol(OMIClientProtocol):
+    def __init__(se=
lf, finish_future: Future, connect_data: ConnectData):
+        super()=2E_=
_init__(finish_future, connect_data)
+
+    async def receive_acc_dpc1(self=
, acc_message: bytes):
+        msg =3D json=2Eloads(acc_message)
+
+      =
  logger=2Eerror(f"Received dpc1 message: {acc_message}")
+
+        dpc_re=
quest =3D msg["dpc_request"]
+        ver =3D dpc_request["ver"]
+        i=
f ver !=3D "1=2E0":
+            logger=2Ewarning(f"Received unknown ACC pr=
otocol version: {ver}")
+            return
+
+        client_info =3D dpc_=
request=2Eget("client_info", False)
+        antivirus =3D "antivirus" in d=
pc_request
+        disk_encryption =3D "disk_encryption" in dpc_request
+
=
+        logger=2Einfo(
+            f"Received DPC1 request: antivirus=3D{=
antivirus}, disk_encryption=3D{disk_encryption}, client_info=3D{client_info=
}")
+
+        if client_info:
+            await self=2E_send_dpc1_client_=
info()
+
+    async def _send_dpc1_client_info(self):
+        system =3D p=
latform=2Esystem()
+        if system =3D=3D "Darwin":
+            system =
=3D "MacOS"
+
+        response =3D {
+            "dpc_response": {
+     =
           "ver": "1=2E0",
+                "client_info": {
+             =
       "os": {
+                        "type": system,
+                  =
      "version": platform=2Erelease(),
+                        "extra":
+ =
                           {
+                                "arch": platf=
orm=2Emachine(),
+                            }
+                    }
+   =
             }
+            }
+        }
+
+        acc_msg =3D json=2Edump=
s(response)=2Eencode()
+        await self=2Esend_acc_msg("dpc1", acc_msg)
=
+
+
+async def main(connect_data: ConnectData):
+    transport, protocol, f=
inish_future =3D await start_management_protocol(connect_data, OmiDpc1Clien=
tProtocol)
+
+    management_version =3D await protocol=2Emanagement_ready(=
)
+    logger=2Edebug(f"Management interface version: {management_version}"=
)
+
+    await protocol=2Eset_bytecount_interval(5)
+
+    try:
+        aw=
ait finish_future
+    except CancelledError:
+        # Ignore errors like=
 ones caused by Control+C in the demo script
+        pass
+
+
+if __name__=
 =3D=3D '__main__':
+    run_main(main)
diff --git a/sample/management/acc_=
dpc1_server_demo=2Epy b/sample/management/acc_dpc1_server_demo=2Epy
new fil=
e mode 100755
index 0000000=2E=2E5b2c836
--- /dev/null
+++ b/sample/managem=
ent/acc_dpc1_server_demo=2Epy
@@ -0,0 +1,157 @@
+#!/usr/bin/env python3
+# =
Copyright (c) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+# Copyright (c) 2026 =
Arne Schwabe <arne@rfc2549=2Eorg>
+#
+# Permission is hereby granted, free =
of charge, to any person obtaining a copy
+# of this software and associate=
d documentation files (the "Software"), to deal
+# in the Software without =
restriction, including without limitation the rights
+# to use, copy, modif=
y, merge, publish, distribute, sublicense, and/or sell
+# copies of the Sof=
tware, and to permit persons to whom the Software is
+# furnished to do so,=
 subject to the following conditions:
+#
+# The above copyright notice and =
this permission notice shall be included in all
+# copies or substantial po=
rtions of the Software=2E
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT W=
ARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO TH=
E WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NO=
NINFRINGEMENT=2E IN NO EVENT SHALL THE
+# AUTHORS OR COPYRIGHT HOLDERS BE L=
IABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF=
 CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+# OUT OF OR IN CONNECTION WITH=
 THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+# SOFTWARE=2E
+
+# This =
implements a small demonstration of using the
+# OpenVPN Access Server Mana=
gement Interface (OMI) and an app Custom Control
+# protocol (dpc1)=2E To u=
se this use on the server
+
+# --management-client-auth
+# --app-custom-con=
trol dpc1
+# --management /path/to/acc_dpc1_server_demo=2Epy unix-script
+
=
+# Note this is just a demonstration and not a production-ready solution=2E=

+# When modifying this code, keep the security in mind=2E It is easy to
+#=
 introduce a security problem when writing scripts handling authentication
=
+
+import asyncio
+import json
+import logging
+from asyncio import Future
=
+from dataclasses import field, dataclass
+from typing import Dict
+
+loggi=
ng=2EbasicConfig()
+
+from omi_server_protocol import OMIServerProtocol, Co=
nnectedClient
+from omi_tools import start_management_protocol, ConnectData=
, run_main
+
+logger =3D logging=2EgetLogger(__name__)
+
+
+@dataclass
+cla=
ss DpcConnectedClient(ConnectedClient):
+    # Remember the key-id that we =
authenticated
+    pending_dpc_kid: int =3D -1
+    env: Dict[str, str] =3D=
 field(default_factory=3Ddict)
+
+
+class OmiDPCServerProtocol(OMIServerPro=
tocol):
+    def __init__(self, finish_future: Future, connect_data: Connec=
tData):
+        super()=2E__init__(finish_future, connect_data)
+        s=
elf=2E_connected_client_class =3D DpcConnectedClient
+
+    def receive_acc=
_client_dpc1(self, client: DpcConnectedClient, kid: int, acc_message: bytes=
):
+        logger=2Einfo(f"Received DPC1 message: {acc_message!r}")
+     =
   msg =3D json=2Eloads(acc_message)
+
+        dpc_response =3D msg["dpc_r=
esponse"]
+        ver =3D dpc_response["ver"]
+        if ver !=3D "1=2E0"=
:
+            logger=2Eerror(f"Received unknown ACC protocol version: {ver=
}")
+            return
+
+        client_info =3D dpc_response=2Eget("clie=
nt_info", {})
+        antivirus =3D "antivirus" in dpc_response
+        d=
isk_encryption =3D "disk_encryption" in dpc_response
+
+        logger=2Ein=
fo(
+            f"Received DPC1 response: antivirus=3D{antivirus}, disk_en=
cryption=3D{disk_encryption}, client_info=3D{client_info}")
+
+        # No=
rmally here would be a check that the response matches the policy
+        =
# this demo script just allows everyone with a response to pass
+        cl=
ient=2Epending_dpc_kid =3D -1
+        self=2Eadd_background_task(self=2Eau=
thenticate_client(client, kid))
+
+    async def authenticate_client(self, =
client: DpcConnectedClient, kid:int):
+        # Simulate that we think a b=
it about the response
+        await asyncio=2Esleep(3)
+        await self=
=2Equeue_command(f"client-auth-nt {client=2Ecid} {kid}")
+
+    async def d=
pc_request_timeout(self, client: DpcConnectedClient, kid: int, timeout: int=
):
+        await asyncio=2Esleep(timeout)
+        if client=2Epending_dpc=
_kid !=3D kid:
+            return
+
+        client_deny =3D f'client-deny=
 {client=2Ecid} {kid} "dpc1 timeout" "Timeout on device posture"'
+        =
await self=2Equeue_command(client_deny)
+
+    def client_event_ESTABLISHED=
(self, client: DpcConnectedClient, kid: int, env: dict, extra: str):
+     =
   print(f"CLient connected: {client}")
+
+    async def send_client_deny_n=
o_dpc1(self, client: DpcConnectedClient, kid: int):
+        client_reason =
=3D "ACC[protocol dpc1]: To connect to this server you " \
+               =
         "need to upgrade to a client that supports the " \
+              =
          "OpenVPN Inc device posture protocol and has it " \
+            =
            "enabled, e=2Eg=2E OpenVPN for Android, openvpn3-linux, " \
+  =
                      "or OpenVPN Connect"
+        client_deny =3D f'clien=
t-deny {client=2Ecid} {kid} "no dpc1 support" "{client_reason}"'
+        a=
wait self=2Equeue_command(client_deny)
+
+    def client_event_CONNECT(self=
, client: DpcConnectedClient, kid: int, env: dict, extra: str):
+        pr=
int(f"Authenticating client {client}, {kid}, protos: {client=2Eacc_negotiat=
ed_protocols}")
+        client=2Eenv =3D env
+        self=2Eadd_backgroun=
d_task(self=2Echeck_client_posture(client, kid))
+
+    def client_event_RE=
AUTH(self, client: DpcConnectedClient, kid: int, env: dict, extra: str):
+ =
       print(f"Re-authenticating client {client}, {kid}, protos: {client=2E=
acc_negotiated_protocols}")
+        client=2Eenv =3D env
+        # Check =
client posture again on renegotiation
+        self=2Eadd_background_task(s=
elf=2Echeck_client_posture(client, kid))
+
+    async def check_client_post=
ure(self, client: DpcConnectedClient, kid: int):
+        await self=2Equeu=
e_command(
+            f"client-pending-auth {client=2Ecid} {kid} \"NOTIFY=
::Checking your device posture, please wait\" 180")
+
+        await self=
=2Equeue_command(f"client-pending-auth {client=2Ecid} {kid} ACC 180")
+    =
    # In this example we wait for 20 seconds to simulate a posture check on=
 the server
+        await asyncio=2Esleep(20)
+
+        if "dpc1" not in =
client=2Eacc_negotiated_protocols:
+            await self=2Esend_client_de=
ny_no_dpc1(client, kid)
+            return
+
+        dpc_cmd =3D {"dpc_re=
quest": {"ver": "1=2E0", "correlation_id": "n/a", "timestamp": "yesterday",=
 "client_info": True,
+                                   "disk_encryption"=
: {"full": True}, "antivirus": {}}}
+
+        dpc_cmd_str =3D json=2Edumps=
(dpc_cmd)
+        acc_protocol =3D "dpc1"
+
+        client=2Epending_dpc_=
kid =3D kid
+        await self=2Esend_acc_msg(client, kid, acc_protocol, d=
pc_cmd_str=2Eencode())
+        self=2Eadd_background_task(self=2Edpc_reque=
st_timeout(client, kid, 60))
+
+
+async def main(connect_data: ConnectData)=
:
+    transport, protocol, finish_future =3D await start_management_protoc=
ol(connect_data, OmiDPCServerProtocol)
+
+    management_version =3D await =
protocol=2Emanagement_ready()
+    logger=2Edebug(f"Management interface ve=
rsion: {management_version}")
+
+    await protocol=2Eenable_log()
+
+    a=
wait protocol=2Eset_bytecount_interval(5)
+
+    await finish_future
+
+
+i=
f __name__ =3D=3D '__main__':
+    run_main(main)

-- 
To view, visit https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c2=
2
Gerrit-Change-Number: 1860
Gerrit-PatchSet: 8
Gerrit-Owner: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Name of user not set #1000061
Gerri=
t-CC: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>

--33YDqFcFErI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Arne Schwabe <strong>uploaded=
 patch set #8</strong> to this change=2E</p><p><a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1860?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Add python scripts that demonstrate using the dpc1 ACC protocol<br><br>=
The dpc1 protocol is used by the OpenVPN Connect clients and<br>OpenVPN Con=
nexa=2E<br><br>Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22<br>Sign=
ed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>A sample/manag=
ement/acc_dpc1_client_demo=2Epy<br>A sample/management/acc_dpc1_server_demo=
=2Epy<br>2 files changed, 267 insertions(+), 0 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/60/1860/8</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/sample/management/acc_dpc1_client_demo=2Ep=
y b/sample/management/acc_dpc1_client_demo=2Epy</span><br><span>new file mo=
de 100755</span><br><span>index 0000000=2E=2E9849f15</span><br><span>--- /d=
ev/null</span><br><span>+++ b/sample/management/acc_dpc1_client_demo=2Epy</=
span><br><span>@@ -0,0 +1,110 @@</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#!/usr/bin/env python3</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# Copyright (c) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Copyright (c) 20=
26 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+# Permission is hereby granted, free of charge, to any person obtainin=
g a copy</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# of this s=
oftware and associated documentation files (the &quot;Software&quot;), to d=
eal</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# in the Softwar=
e without restriction, including without limitation the rights</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+# to use, copy, modify, merge, p=
ublish, distribute, sublicense, and/or sell</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+# copies of the Software, and to permit persons to =
whom the Software is</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# furnished to do so, subject to the following conditions:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+# The above copyright notice and this permission noti=
ce shall be included in all</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# copies or substantial portions of the Software=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+# THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT=
 WARRANTY OF ANY KIND, EXPRESS OR</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MER=
CHANTABILITY,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# FITN=
ESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# AUTHORS OR COPYRIGH=
T HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# LIABILITY, WHETHER IN AN ACTION OF CONT=
RACT, TORT OR OTHERWISE, ARISING FROM,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE O=
R OTHER DEALINGS IN THE</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# SOFTWARE=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# This implements a s=
mall demonstration of using the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# OpenVPN Access Server Management Interface (OMI) and an app C=
ustom Control</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# prot=
ocol (dpc1)=2E To use this use on the client use</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+# --management-client-auth</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# --app-custom-control dpc1</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+# --management /path/to/acc_dpc1_client_demo=2Epy =
unix-script</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+import base64</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+import json</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+import logging</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+import platform</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+from asyncio import CancelledError, Future</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+logging=2EbasicConfig()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+from omi_tools import run_main, start_management_protocol, C=
onnectData</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from omi_=
client_protocol import OMIClientProtocol</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+logger =3D logging=2EgetLogger(__name__)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+class OmiDpc1ClientProtocol(OMIClientProtocol):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    def __init__(self, finish_future: Fut=
ure, connect_data: ConnectData):</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        super()=2E__init__(finish_future, connect_data)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    async def receive_acc_dpc1(self, acc_mess=
age: bytes):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 msg =3D json=2Eloads(acc_message)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    logger=2Eerror(f&quot;Received dpc1 message: {acc_message}&quot;)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        dpc_request =3D msg[&quot;dpc_reques=
t&quot;]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ver=
 =3D dpc_request[&quot;ver&quot;]</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if ver !=3D &quot;1=2E0&quot;:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            logger=2Ewarning(f&quot;Recei=
ved unknown ACC protocol version: {ver}&quot;)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            return</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        client_info =3D dpc_request=2Eget(&quot;client_info&quot;, F=
alse)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        antivi=
rus =3D &quot;antivirus&quot; in dpc_request</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        disk_encryption =3D &quot;disk_encryption&=
quot; in dpc_request</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        logger=2Ei=
nfo(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            f&q=
uot;Received DPC1 request: antivirus=3D{antivirus}, disk_encryption=3D{disk=
_encryption}, client_info=3D{client_info}&quot;)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if client_info:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            await self=2E_send_dpc1_client_info()</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    async def _send_dpc1_client_info(self):</span>=
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
lor: hsl(120, 100%, 40%);">+        acc_msg =3D json=2Edumps(response)=2Een=
code()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        await=
 self=2Esend_acc_msg(&quot;dpc1&quot;, acc_msg)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+async def =
main(connect_data: ConnectData):</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    transport, protocol, finish_future =3D await start_managem=
ent_protocol(connect_data, OmiDpc1ClientProtocol)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    management_version =3D await protocol=2Emanagement_ready()</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    logger=2Edebug(f&=
quot;Management interface version: {management_version}&quot;)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    await protocol=2Eset_bytecount_interval(5)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    try:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        await finish_future</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    except CancelledError:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        # Ignore errors like ones cau=
sed by Control+C in the demo script</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        pass</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+if __name__ =3D=3D &#39;__mai=
n__&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    run_ma=
in(main)</span><br><span>diff --git a/sample/management/acc_dpc1_server_dem=
o=2Epy b/sample/management/acc_dpc1_server_demo=2Epy</span><br><span>new fi=
le mode 100755</span><br><span>index 0000000=2E=2E5b2c836</span><br><span>-=
-- /dev/null</span><br><span>+++ b/sample/management/acc_dpc1_server_demo=
=2Epy</span><br><span>@@ -0,0 +1,157 @@</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#!/usr/bin/env python3</span><br><span style=3D"color: =
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
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# This impl=
ements a small demonstration of using the</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+# OpenVPN Access Server Management Interface (OMI) an=
d an app Custom Control</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# protocol (dpc1)=2E To use this use on the server</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# --management-client-auth</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+# --app-custom-control dpc1</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+# --management /path/to/acc_dpc1_server_demo=
=2Epy unix-script</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Note this is just a=
 demonstration and not a production-ready solution=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# When modifying this code, keep the secu=
rity in mind=2E It is easy to</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+# introduce a security problem when writing scripts handling auth=
entication</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+import asyncio</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+import json</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+import logging</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+from asyncio import Future</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+from dataclasses import field, dataclas=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from typing import=
 Dict</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+logging=2EbasicConfig()</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+from omi_server_protocol import OMIServerProtoco=
l, ConnectedClient</span><br><span style=3D"color: hsl(120, 100%, 40%);">+f=
rom omi_tools import start_management_protocol, ConnectData, run_main</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+logger =3D logging=2EgetLogger(__name__)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+@dataclass</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+class DpcConnectedClient(ConnectedClient):</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    # Remember the key-id that we authenticate=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pending_dpc_ki=
d: int =3D -1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    en=
v: Dict[str, str] =3D field(default_factory=3Ddict)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+clas=
s OmiDPCServerProtocol(OMIServerProtocol):</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    def __init__(self, finish_future: Future, connec=
t_data: ConnectData):</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        super()=2E__init__(finish_future, connect_data)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        self=2E_connected_client_clas=
s =3D DpcConnectedClient</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def receiv=
e_acc_client_dpc1(self, client: DpcConnectedClient, kid: int, acc_message: =
bytes):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        logg=
er=2Einfo(f&quot;Received DPC1 message: {acc_message!r}&quot;)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg =3D json=2Eloads(acc=
_message)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        dpc_response =3D msg[=
&quot;dpc_response&quot;]</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        ver =3D dpc_response[&quot;ver&quot;]</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if ver !=3D &quot;1=2E0&quot;:</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            logger=2Ee=
rror(f&quot;Received unknown ACC protocol version: {ver}&quot;)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            return</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        client_info =3D dpc_response=2Eget(&quot;cl=
ient_info&quot;, {})</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        antivirus =3D &quot;antivirus&quot; in dpc_response</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        disk_encryption =3D &quot;=
disk_encryption&quot; in dpc_response</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       logger=2Einfo(</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            f&quot;Received DPC1 response: antivirus=3D{antivirus}, disk_=
encryption=3D{disk_encryption}, client_info=3D{client_info}&quot;)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        # Normally here would be a check that t=
he response matches the policy</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        # this demo script just allows everyone with a response =
to pass</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        clie=
nt=2Epending_dpc_kid =3D -1</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        self=2Eadd_background_task(self=2Eauthenticate_client(clien=
t, kid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    async def authenticate_cli=
ent(self, client: DpcConnectedClient, kid:int):</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        # Simulate that we think a bit about th=
e response</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        a=
wait asyncio=2Esleep(3)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        await self=2Equeue_command(f&quot;client-auth-nt {client=2Ecid}=
 {kid}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    async def dpc_request=
_timeout(self, client: DpcConnectedClient, kid: int, timeout: int):</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        await asyncio=2Esle=
ep(timeout)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if client=2Epending_dpc_kid !=3D kid:</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            return</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      client_deny =3D f&#39;client-deny {client=2Ecid} {kid} &quot;dpc1 tim=
eout&quot; &quot;Timeout on device posture&quot;&#39;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        await self=2Equeue_command(client=
_deny)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    def client_event_ESTABLISHED=
(self, client: DpcConnectedClient, kid: int, env: dict, extra: str):</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        print(f&quot;CLien=
t connected: {client}&quot;)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    async =
def send_client_deny_no_dpc1(self, client: DpcConnectedClient, kid: int):</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        client_reason=
 =3D &quot;ACC[protocol dpc1]: To connect to this server you &quot; \</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                        &=
quot;need to upgrade to a client that supports the &quot; \</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                        &quot;OpenV=
PN Inc device posture protocol and has it &quot; \</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                        &quot;enabled, e=2Eg=
=2E OpenVPN for Android, openvpn3-linux, &quot; \</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                        &quot;or OpenVPN Conn=
ect&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cl=
ient_deny =3D f&#39;client-deny {client=2Ecid} {kid} &quot;no dpc1 support&=
quot; &quot;{client_reason}&quot;&#39;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        await self=2Equeue_command(client_deny)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    def client_event_CONNECT(self, client: DpcC=
onnectedClient, kid: int, env: dict, extra: str):</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        print(f&quot;Authenticating client {c=
lient}, {kid}, protos: {client=2Eacc_negotiated_protocols}&quot;)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        client=2Eenv =3D env<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2Eadd_b=
ackground_task(self=2Echeck_client_posture(client, kid))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    def client_event_REAUTH(self, client: DpcConnectedCli=
ent, kid: int, env: dict, extra: str):</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        print(f&quot;Re-authenticating client {client}, =
{kid}, protos: {client=2Eacc_negotiated_protocols}&quot;)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        client=2Eenv =3D env</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        # Check client postu=
re again on renegotiation</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        self=2Eadd_background_task(self=2Echeck_client_posture(client=
, kid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    async def check_client_post=
ure(self, client: DpcConnectedClient, kid: int):</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        await self=2Equeue_command(</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            f&quot;client-pend=
ing-auth {client=2Ecid} {kid} \&quot;NOTIFY::Checking your device posture, =
please wait\&quot; 180&quot;)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        a=
wait self=2Equeue_command(f&quot;client-pending-auth {client=2Ecid} {kid} A=
CC 180&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  # In this example we wait for 20 seconds to simulate a posture check on t=
he server</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        aw=
ait asyncio=2Esleep(20)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if &quo=
t;dpc1&quot; not in client=2Eacc_negotiated_protocols:</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            await self=2Esend_client_den=
y_no_dpc1(client, kid)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            return</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dpc_cmd =
=3D {&quot;dpc_request&quot;: {&quot;ver&quot;: &quot;1=2E0&quot;, &quot;co=
rrelation_id&quot;: &quot;n/a&quot;, &quot;timestamp&quot;: &quot;yesterday=
&quot;, &quot;client_info&quot;: True,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                   &quot;disk_encryption=
&quot;: {&quot;full&quot;: True}, &quot;antivirus&quot;: {}}}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        dpc_cmd_str =3D json=2Edumps(dpc_cmd)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        acc_protocol =3D &=
quot;dpc1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        client=2Ependin=
g_dpc_kid =3D kid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      await self=2Esend_acc_msg(client, kid, acc_protocol, dpc_cmd_str=2Een=
code())</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=
=2Eadd_background_task(self=2Edpc_request_timeout(client, kid, 60))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+async def main(connect_data: ConnectData):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    transport, protocol, finish_future =
=3D await start_management_protocol(connect_data, OmiDPCServerProtocol)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    management_version =3D await protocol=
=2Emanagement_ready()</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    logger=2Edebug(f&quot;Management interface version: {management_versi=
on}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    await protocol=2Eenable_=
log()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    await protocol=2Eset_bytecoun=
t_interval(5)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    await finish_future</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+if __name__ =3D=3D &#39;__main__&#39;:</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    run_main(main)</span><br></pre><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=
=3Demail">change 1860</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1860?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 1860 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-=
Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: Name of user not set #1000061 </div>
<div style=
=3D"display:none"> Gerrit-CC: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></htm=
l>
--33YDqFcFErI=--


--===============3287800955205749787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3287800955205749787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3287800955205749787==--

