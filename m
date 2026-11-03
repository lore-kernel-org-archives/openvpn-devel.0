Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE93C606A7BB
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AHUbawdK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IdVD0Q4V;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=G7ZA8rB2;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=BhPJcN69
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zjILAlxYPSam+cGV9TnqEzR53F1ywkbHlwZ4mlrBVes=; b=AHUbawdKqe5IPJHbtlPANXfII0
	Wgg2axiM0tAGpv64bMfQ+6zhdsANKSkNQ3bo2HorUQs9pfaXO5yGNk6YuZ2yw4ioxKDYU4Yw23yHv
	BNMrzjWV6GjD4G/RiOKnuijw+UKh2Fs/MGa+OB9GjvYxMF0OM+xA7Kei5UNmKvbRYD1M=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOG7S-000000001Qx-2NR5;
	Tue, 03 Nov 2026 15:08:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOG7R-000000001Qr-1MZM
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:08:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vxrUGiKXtwbV4W2LwK1+Z0zrkj32cPzZrtL7qWPt9to=; b=IdVD0Q4Vk2FhttEtlsJvo4kzai
 Y+1rreDd7Qard1NnDPtEWWjEuMWHFX/5mCIjEbpn0nKdn8dRex+/JAcDzmXe11geMgCUIZT7L5/Wi
 QNFTPXZhNbCByHFOz4bUxBhIui1YkFtyDHJwN+PoAQ+kMM5FY5JmzMAd2e9BzlA6pCiY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vxrUGiKXtwbV4W2LwK1+Z0zrkj32cPzZrtL7qWPt9to=; b=G7ZA8rB2sEkWIvg6HJxY5ITIKR
 et16mGBy/ajyxUCRNfWrjXdwdvHmqCp3i+LOrGDTIt4ZIG/PzwcWyvp6jZ2lr9otX1lbM4Dp9FCuW
 ApAMRchWGd+Pe1+w7S/oHfxl66oaTgid2G5/vzaiVbQrOuknSn1LkHe4+/FcbBTCfpP4=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOG7N-000000007Xf-3Hcv for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:08:13 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4afe2d546f9so27469175e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 07:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793718483; x=1794323283; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vxrUGiKXtwbV4W2LwK1+Z0zrkj32cPzZrtL7qWPt9to=;
 b=BhPJcN69Umswpk/dml4v0PcV7wqYGThanUTIGJjNoy8SiWkBDW2pCXM9Hq+kO5xEsk
 fYGqnSPSoTz/z+CahkMZ2DZGYeOoOibvMGZVNB6IWhC7JsU2t9+WSzB6B4mfWTVU80gp
 EsM8rHt0VaQazHXuw4QKPmx+Dw2xwOrSWuOdLZ+tATqa2jK5sOQXyyv2gC6wDFKrWmGK
 ZRq8ChXG9oudUIIugLjsnWljbFX/9PTOtNpJRa8io39Ctox6RTJqD11qMrHXu/KLMj+f
 lRnQxzOvRUz2Ok8px8gFGYjNYAAQJuCmDmyi6H+CzmXJOrRumD0Y/ZDvA3vSzdaJBf/j
 m0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793718483; x=1794323283;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vxrUGiKXtwbV4W2LwK1+Z0zrkj32cPzZrtL7qWPt9to=;
 b=ZVEAFGJljtm33mNqB6rGW/JVxhVOP3h7V2vGweqiBLggSydQQ6cCCYL6oOpwLKaX+r
 BrRbINf4Ke1YnZxfvkjNZgez6FtpnkWjFAoHsC+46fKodOxhY6YYGdHP1DGnkM9+Ltuy
 yVNb2e96oDvTYc3dtqXINMPvQrUmiR7XiAYrqimQ667kyZGnf0u0aaqX7DtPNepG3Al4
 xa9BLXmZnXpi08ChaW1QX0jL2PI7oxWBzEOHkt9SBdS6Xi0+RI0GfMtshjdGIqvH89fV
 T2CfIloVsdndCCvK/AHgUoQA3SCuY+X9/VQMOyBk8ZrJofKYfbMU98Cbp6O8Sw9ZhjJk
 4G2Q==
X-Gm-Message-State: APuU4Z8ObtM2KvT+mRNcvof9g3JDOTIzR2lbhS0D7bRWEIpluQa9afzo
 4zqx83TvsT/IBbRH1cfep/WscjgOuNTCqQVS4daGstFLEUDFQkZrSioGf2HypGe9w5SB9sz8/DM
 J0owqd9HEha72zd5IkAZk+eDqNoFCQ5bvuuIi0cPX306k4Gbiv54rxbrfuTHOleF5OrOiXypAYM
 acL3GCJg==
X-Gm-Gg: AYBFou1K3Vrwf0Suz2mv5g7n/Fhi6F/tFXqHF9y1enfM9jlkGB6q1uLwIGIYppZi1Sz
 U897sji/vn3/mQXGo9nMpjOvAm2yZZ/hb4Yv2RcnX+L6Im2yPt41L2ZUFIjc0/Oqay9+DNuK0vZ
 VEAvn8/qOLK+tGwfYLOUnHf0lQQuwya6W3IVSK5JoIYD6/L4vtfEs9phAYnS32e0dsjNmuhBRQH
 qtp1YWv93FBG5Gq/SBhm5o8K3yaziOfl1s8Ht0CtM+h0uisNf451vt/3s4ITh73DzbhHb1Sumy+
 dTCtA/9vt9kT+ZScbqAqb7IX5gCEZEgeSoyTKjpiNRUM5AE3oW+ewsu6b7KivKqzI7fxgfrp/8h
 Q/yf4TwklfUzx1UjooMGg2o56E69qvHNx1Q9UIbAOd5X7+5tYl/cQXrOk3fWnWeud8WCQ8zmmPw
 Z6FnBNehk7cj6NqNmO5T2B6GltfYndfGxb8aPeiKhF2av9u9DJP03x/fVnNTHVx3yd8HxWrkdtm
 aJY3QOs2GDPkUpRn7wBDTYfnQY49kb7BPMTR0mj+hSqLBriYgcED+MexjwsxE/7RZpDz+sWy20Q
 TOvUOhyKW6ApjJb3W3a8/gPG0Kt8KyV9/ZX2jvdvRCusFcEvz22HDZFVL4OE97nSncLAyF5UCF+
 FcagQcx2xebaX6+dllokoUntZirQ6iv4zJZ3yqSjyj+TLcDhTAI3VnAz8kAYqhuXJY9foIypEDW
 cQVB9ewBJrSo5OKg==
X-Received: by 2002:a05:600c:6214:b0:4a2:9cda:57cb with SMTP id
 5b1f17b1804b1-4ac151a9077mr324611955e9.1.1793718482793; 
 Tue, 03 Nov 2026 07:08:02 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac0a762bc1sm153554885e9.4.2026.11.03.07.08.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 07:08:02 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 15:07:56 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22
X-Gerrit-Change-Number: 1860
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1860?usp=email>
X-Gerrit-Commit: 45fb330724493f03fbc54f182f6fea53283f1a5d
In-Reply-To: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
References: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzQ1NDE2MDAwLkllMjAyODk3MzdkNTAyYTI1ZWVkYzYwNjc3ZDNjMzUwZGRjM2IzYzIyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <24699879debec5f95ada94bb416c09306a52b09c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOG7N-000000007Xf-3Hcv
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2369691429680528381=="
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2369691429680528381==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FLEil6ykBi4="; charset=UTF-8

--FLEil6ykBi4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Name of user not set #1000061=2E

Arn=
e Schwabe has uploaded a new patch set (#5)=2E ( https://gerrit=2Eopenvpn=
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

2 files changed, 271 insertions(+), 0 deletions(-)


  git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/60/1860/5

diff --git a/sampl=
e/management/acc_dpc1_client_demo=2Epy b/sample/management/acc_dpc1_client_=
demo=2Epy
new file mode 100755
index 0000000=2E=2E1ae074d
--- /dev/null
+++=
 b/sample/management/acc_dpc1_client_demo=2Epy
@@ -0,0 +1,114 @@
+#!/usr/bi=
n/env python3
+# Copyright (c) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+# Co=
pyright (c) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+#
+# Permission is here=
by granted, free of charge, to any person obtaining a copy
+# of this softw=
are and associated documentation files (the "Software"), to deal
+# in the =
Software without restriction, including without limitation the rights
+# to=
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+# =
copies of the Software, and to permit persons to whom the Software is
+# fu=
rnished to do so, subject to the following conditions:
+#
+# The above copy=
right notice and this permission notice shall be included in all
+# copies =
or substantial portions of the Software=2E
+#
+# THE SOFTWARE IS PROVIDED "=
AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT =
NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICUL=
AR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE
+# AUTHORS OR COPYR=
IGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHE=
R IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+# OUT OF OR I=
N CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+# SOFTW=
ARE=2E
+
+# This implements a small demonstration of using the
+# OpenVPN A=
ccess Server Management Interface (OMI) and an app Custom Control
+# protoc=
ol (dpc1)=2E To use this use on the client use
+
+# --management-client-aut=
h
+# --app-custom-control dpc1
+# --management /path/to/acc_dpc1_client_dem=
o=2Epy unix-script
+
+import base64
+import json
+import logging
+import pl=
atform
+from asyncio import CancelledError, Future
+
+logging=2EbasicConfig=
()
+
+from omi_tools import run_main, start_management_protocol, ConnectDat=
a
+from omi_client_protocol import OMIClientProtocol
+
+logger =3D logging=
=2EgetLogger(__name__)
+logger=2EsetLevel(logging=2EINFO)
+
+
+class OmiDpc=
1ClientProtocol(OMIClientProtocol):
+    def __init__(self, finish_future: =
Future, connect_data: ConnectData):
+        super()=2E__init__(finish_futu=
re, connect_data)
+
+    def receive_acc_dpc1(self, acc_message: str):
+   =
     msg =3D json=2Eloads(acc_message)
+
+        logger=2Eerror(f"Received=
 dpc1 message: {acc_message}")
+
+        dpc_request =3D msg["dpc_request"=
]
+        ver =3D dpc_request["ver"]
+        if ver !=3D "1=2E0":
+      =
      logger=2Ewarning(f"Received unknown ACC protocol version: {ver}")
+  =
          return
+
+        client_info =3D dpc_request=2Eget("client_info"=
, False)
+        antivirus =3D "antivirus" in dpc_request
+        disk_en=
cryption =3D "disk_encryption" in dpc_request
+
+        logger=2Einfo(
+  =
          f"Received DPC1 request: antivirus=3D{antivirus}, disk_encryption=
=3D{disk_encryption}, client_info=3D{client_info}")
+
+        if client_in=
fo:
+            self=2E_send_dpc1_client_info()
+
+    def _send_dpc1_clie=
nt_info(self):
+        system =3D platform=2Esystem()
+        if system =
=3D=3D "Darwin":
+            system =3D "MacOS"
+
+        response =3D {
=
+            "dpc_response": {
+                "ver": "1=2E0",
+          =
      "client_info": {
+                    "os": {
+                      =
  "type": system,
+                        "version": platform=2Erelease(),=

+                        "extra":
+                            {
+        =
                        "arch": platform=2Emachine(),
+                    =
        }
+                    }
+                }
+            }
+       =
 }
+
+        b64msg =3D base64=2Eb64encode(json=2Edumps(response)=2Eencode=
())=2Edecode()
+
+        command =3D f"acc-msg\ndpc1\n6\n{b64msg}\nEND"
+ =
       self=2Equeue_command(command)
+
+
+async def main(connect_data: Conn=
ectData):
+    transport, protocol, finish_future =3D await start_managemen=
t_protocol(connect_data, OmiDpc1ClientProtocol)
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
diff --git a/sample/management/acc_dpc1_server_demo=2Epy b/sample/manage=
ment/acc_dpc1_server_demo=2Epy
new file mode 100644
index 0000000=2E=2Ee525=
cfa
--- /dev/null
+++ b/sample/management/acc_dpc1_server_demo=2Epy
@@ -0,0=
 +1,157 @@
+#!/usr/bin/env python3
+# Copyright (c) 2026 OpenVPN Inc <sales=
@openvpn=2Enet>
+# Copyright (c) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+#
=
+# Permission is hereby granted, free of charge, to any person obtaining a =
copy
+# of this software and associated documentation files (the "Software"=
), to deal
+# in the Software without restriction, including without limita=
tion the rights
+# to use, copy, modify, merge, publish, distribute, sublic=
ense, and/or sell
+# copies of the Software, and to permit persons to whom =
the Software is
+# furnished to do so, subject to the following conditions:=

+#
+# The above copyright notice and this permission notice shall be inclu=
ded in all
+# copies or substantial portions of the Software=2E
+#
+# THE S=
OFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IM=
PLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# F=
ITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL TH=
E
+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER=

+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEA=
LINGS IN THE
+# SOFTWARE=2E
+
+#
+#  You should have received a copy of the=
 GNU General Public License along
+#  with this program; if not, see <https=
://www=2Egnu=2Eorg/licenses/>=2E
+
+# This implements a small demonstration=
 of using the
+# OpenVPN Access Server Management Interface (OMI) and an ap=
p Custom Control
+# protocol (dpc1)=2E To use this use on the server
+
+# -=
-management-client-auth
+# --app-custom-control dpc1
+# --management /path/=
to/acc_dpc1_server_demo=2Epy unix-script
+
+# Note this is just a demonstra=
tion and not a production-ready solution=2E
+# When modifying this code, ke=
ep the security in mind=2E It is easy to
+# introduce a security problem wh=
en writing scripts handling authentication
+
+import asyncio
+import json
+=
import logging
+from asyncio import Future
+from dataclasses import field
+=
from pprint import pprint
+from typing import Dict
+
+logging=2EbasicConfig=
()
+
+from omi_server_protocol import OMIServerProtocol, ConnectedClient
+f=
rom omi_tools import start_management_protocol, ConnectData, run_main
+
+lo=
gger =3D logging=2EgetLogger(__name__)
+
+
+class DpcConnectedClient(Connec=
tedClient):
+    # Remember the key-id that we authenticated
+    dpc_compl=
eted: bool =3D False
+    env: Dict[str, str] =3D field(default_factory=3Dd=
ict)
+
+
+class OmiDPCServerProtocol(OMIServerProtocol):
+    def __init__(=
self, finish_future: Future, connect_data: ConnectData):
+        super()=
=2E__init__(finish_future, connect_data)
+        self=2E_connected_client_=
class =3D DpcConnectedClient
+
+    def receive_acc_client_dpc1(self, clien=
t: DpcConnectedClient, kid: int, acc_message: str):
+        print(f"Receiv=
ed DPC1 message: {acc_message!r}")
+        msg =3D json=2Eloads(acc_messag=
e)
+        pprint(msg)
+
+        dpc_response =3D msg["dpc_response"]
+  =
      ver =3D dpc_response["ver"]
+        if ver !=3D "1=2E0":
+          =
  logger=2Eerror(f"Received unknown ACC protocol version: {ver}")
+        =
    return
+
+        client_info =3D dpc_response=2Eget("client_info", {})=

+        antivirus =3D "antivirus" in dpc_response
+        disk_encryptio=
n =3D "disk_encryption" in dpc_response
+
+        logger=2Einfo(
+        =
    f"Received DPC1 response: antivirus=3D{antivirus}, disk_encryption=3D{d=
isk_encryption}, client_info=3D{client_info}")
+
+        # Normally here w=
ould be a check that the response matches the policy
+        # this demo s=
cript just allows everyone with a response to pass
+        client=2Edpc_co=
mpleted =3D True
+
+        self=2Equeue_command(f"client-auth-nt {client=
=2Ecid} {kid}")
+
+    async def dpc_request_timeout(self, client: DpcConne=
ctedClient, kid: int, timeout: int):
+        await asyncio=2Esleep(timeout=
)
+        if client=2Edpc_completed:
+            return
+
+        client=
_deny =3D f'client-deny {client=2Ecid} {kid} "dpc1 timeout" "Timeout on dev=
ice posture"'
+        await self=2Equeue_command(client_deny)
+
+    def c=
lient_event_ESTABLISHED(self, client: DpcConnectedClient, kid: int, env: di=
ct, extra: str):
+        print(f"CLient connected: {client}")
+
+    async=
 def send_client_deny_no_dpc1(self, client: DpcConnectedClient, kid: int):
=
+        client_reason =3D "ACC[protocol dpc1]: To connect to this server y=
ou " \
+                        "need to upgrade to a client that supports =
the " \
+                        "OpenVPN Inc device posture protocol and h=
as it " \
+                        "enabled, e=2Eg=2E OpenVPN for Android, =
openvpn3-linux, " \
+                        "or OpenVPN Connect"
+        =
client_deny =3D f'client-deny {client=2Ecid} {kid} "no dpc1 support" "{clie=
nt_reason}"'
+        await self=2Equeue_command(client_deny)
+
+    def cl=
ient_event_CONNECT(self, client: DpcConnectedClient, kid: int, env: dict, e=
xtra: str):
+        print(f"Authenticating client {client}, {kid}, protos:=
 {client=2Eacc_negotiated_protocols}")
+        client=2Eenv =3D env
+     =
   asyncio=2Ecreate_task(self=2Echeck_client_posture(client, kid))
+
+    d=
ef client_event_REAUTH(self, client: DpcConnectedClient, kid: int, env: dic=
t, extra: str):
+        print(f"Re-authenticating client {client}, {kid}, =
protos: {client=2Eacc_negotiated_protocols}")
+        client=2Eenv =3D env=

+        # Check client posture again on renegotiation
+        asyncio=2E=
create_task(self=2Echeck_client_posture(client, kid))
+
+    async def chec=
k_client_posture(self, client: DpcConnectedClient, kid: int):
+        awai=
t self=2Equeue_command(
+            f"client-pending-auth {client=2Ecid} {=
kid} \"NOTIFY::Checking your device posture, please wait\" 180")
+
+       =
 await self=2Equeue_command(f"client-pending-auth {client=2Ecid} {kid} ACC =
180")
+        # In this example we wait for 20 seconds to simulate a postu=
re check on the server
+        await asyncio=2Esleep(20)
+
+        if "dp=
c1" not in client=2Eacc_negotiated_protocols:
+            await self=2Esen=
d_client_deny_no_dpc1(client, kid)
+            return
+
+        dpc_cmd =
=3D {"dpc_request": {"ver": "1=2E0", "correlation_id": "n/a", "timestamp": =
"yesterday", "client_info": True,
+                                   "disk=
_encryption": {"full": True}, "antivirus": {}}}
+
+        dpc_cmd_str =3D =
json=2Edumps(dpc_cmd)
+        acc_protocol =3D "dpc1"
+
+        await sel=
f=2Esend_acc_msg(client, kid, acc_protocol, dpc_cmd_str=2Eencode())
+      =
  asyncio=2Ecreate_task(self=2Edpc_request_timeout(client, kid, 60))
+
+
+a=
sync def main(connect_data: ConnectData):
+    transport, protocol, finish_=
future =3D await start_management_protocol(connect_data, OmiDPCServerProtoc=
ol)
+
+    management_version =3D await protocol=2Emanagement_ready()
+    =
logger=2Edebug(f"Management interface version: {management_version}")
+
+  =
  await protocol=2Eenable_log()
+
+    await protocol=2Eset_bytecount_inter=
val(5)
+
+    await finish_future
+
+
+if __name__ =3D=3D '__main__':
+    =
run_main(main)

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1860?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: n=
ewpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
Ie20289737d502a25eedc60677d3c350ddc3b3c22
Gerrit-Change-Number: 1860
Gerrit=
-PatchSet: 5
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-CC: Name of user not set #1000061
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: Name of user not set #1000061

--FLEil6ykBi4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Name of user not set #1000061=2E </p>
<p>Arne Schwabe=
 <strong>uploaded patch set #5</strong> to this change=2E</p><p><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail">View Change</a=
></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">Add python scripts that demonstrate using the dpc1 ACC p=
rotocol<br><br>The dpc1 protocol is used by the OpenVPN Connect clients and=
<br>OpenVPN Connexa=2E<br><br>Change-Id: Ie20289737d502a25eedc60677d3c350dd=
c3b3c22<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br=
>A sample/management/acc_dpc1_client_demo=2Epy<br>A sample/management/acc_d=
pc1_server_demo=2Epy<br>2 files changed, 271 insertions(+), 0 deletions(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/60/1860/5</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/sample/management/acc_dpc1_=
client_demo=2Epy b/sample/management/acc_dpc1_client_demo=2Epy</span><br><s=
pan>new file mode 100755</span><br><span>index 0000000=2E=2E1ae074d</span><=
br><span>--- /dev/null</span><br><span>+++ b/sample/management/acc_dpc1_cli=
ent_demo=2Epy</span><br><span>@@ -0,0 +1,114 @@</span><br><span style=3D"co=
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
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# This=
 implements a small demonstration of using the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+# OpenVPN Access Server Management Interface (OM=
I) and an app Custom Control</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+# protocol (dpc1)=2E To use this use on the client use</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+# --management-client-auth</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# --app-custom-control dpc1</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+# --management /path/to/acc_dpc1_=
client_demo=2Epy unix-script</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import bas=
e64</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import json</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+import logging</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+import platform</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+from asyncio import CancelledErro=
r, Future</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+logging=2EbasicConfig()</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+from omi_tools import run_main, start_manage=
ment_protocol, ConnectData</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+from omi_client_protocol import OMIClientProtocol</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+logger =3D logging=2EgetLogger(__name__)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+logger=2EsetLevel(logging=2EINFO)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+class OmiDpc1ClientProtocol(OMIClientProtocol):</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    def __init__(self, finish_fu=
ture: Future, connect_data: ConnectData):</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        super()=2E__init__(finish_future, connect_dat=
a)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    def receive_acc_dpc1(self, acc_m=
essage: str):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  msg =3D json=2Eloads(acc_message)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     logger=2Eerror(f&quot;Received dpc1 message: {acc_message}&quot;)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        dpc_request =3D msg[&quot;dpc_req=
uest&quot;]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
ver =3D dpc_request[&quot;ver&quot;]</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if ver !=3D &quot;1=2E0&quot;:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            logger=2Ewarning(f&quot;Rec=
eived unknown ACC protocol version: {ver}&quot;)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            return</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        client_info =3D dpc_request=2Eget(&quot;client_info&quot;,=
 False)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        anti=
virus =3D &quot;antivirus&quot; in dpc_request</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        disk_encryption =3D &quot;disk_encryptio=
n&quot; in dpc_request</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        logger=
=2Einfo(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 f&quot;Received DPC1 request: antivirus=3D{antivirus}, disk_encryption=3D{=
disk_encryption}, client_info=3D{client_info}&quot;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if client_info:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            self=2E_send_dpc1_client_info()</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    def _send_dpc1_client_info(self):</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        system =3D platform=2Esys=
tem()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if sys=
tem =3D=3D &quot;Darwin&quot;:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            system =3D &quot;MacOS&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        response =3D {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            &quot;dpc_response&quot;: {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                &quot;ver&quot;: &quo=
t;1=2E0&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           &quot;client_info&quot;: {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                    &quot;os&quot;: {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                        &quot;type&quot=
;: system,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
               &quot;version&quot;: platform=2Erelease(),</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                        &quot;extra&q=
uot;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
              {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                            &quot;arch&quot;: platform=2Emachine(),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        b64msg =3D base64=2Eb64encode(json=2Edumps(r=
esponse)=2Eencode())=2Edecode()</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 command =3D f&quot;acc-msg\ndpc1\n6\n{b64msg}\nEND&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        self=2Equeue_command(command)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+async def main(connect_data: ConnectData):</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    transport, protocol, finish_fu=
ture =3D await start_management_protocol(connect_data, OmiDpc1ClientProtoco=
l)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    management_version =3D await pro=
tocol=2Emanagement_ready()</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    logger=2Edebug(f&quot;Management interface version: {management_=
version}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    await protocol=2Ese=
t_bytecount_interval(5)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    try:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        await finish_futur=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    except Cancell=
edError:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # I=
gnore errors like ones caused by Control+C in the demo script</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        pass</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if =
__name__ =3D=3D &#39;__main__&#39;:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    run_main(main)</span><br><span>diff --git a/sample/mana=
gement/acc_dpc1_server_demo=2Epy b/sample/management/acc_dpc1_server_demo=
=2Epy</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=
=2Ee525cfa</span><br><span>--- /dev/null</span><br><span>+++ b/sample/manag=
ement/acc_dpc1_server_demo=2Epy</span><br><span>@@ -0,0 +1,157 @@</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#!/usr/bin/env python3</span>=
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
, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  You s=
hould have received a copy of the GNU General Public License along</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#  with this program; if not=
, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# This implements a small demonstration of using the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# OpenVPN Access Server Manage=
ment Interface (OMI) and an app Custom Control</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+# protocol (dpc1)=2E To use this use on the serv=
er</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+# --management-client-auth</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# --app-custom-control dpc1</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# --management /path/=
to/acc_dpc1_server_demo=2Epy unix-script</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# Note this is just a demonstration and not a production-ready solution=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# When modifying=
 this code, keep the security in mind=2E It is easy to</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+# introduce a security problem when writ=
ing scripts handling authentication</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+imp=
ort asyncio</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import j=
son</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import logging</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+from asyncio import F=
uture</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from dataclass=
es import field</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from=
 pprint import pprint</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
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
=3D"color: hsl(120, 100%, 40%);">+class DpcConnectedClient(ConnectedClient)=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # Remember the=
 key-id that we authenticated</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    dpc_completed: bool =3D False</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    env: Dict[str, str] =3D field(default_factory=
=3Ddict)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+class OmiDPCServerProtocol(OMIServerProtocol):</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    def __init__(self,=
 finish_future: Future, connect_data: ConnectData):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        super()=2E__init__(finish_future,=
 connect_data)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   self=2E_connected_client_class =3D DpcConnectedClient</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    def receive_acc_client_dpc1(self, client: DpcConnecte=
dClient, kid: int, acc_message: str):</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        print(f&quot;Received DPC1 message: {acc_message!=
r}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ms=
g =3D json=2Eloads(acc_message)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        pprint(msg)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 dpc_response =3D msg[&quot;dpc_response&quot;]</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        ver =3D dpc_response[&quot;ver&quot;]</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if ver !=3D &=
quot;1=2E0&quot;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          logger=2Eerror(f&quot;Received unknown ACC protocol version: {ver=
}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        client_info =3D dpc_res=
ponse=2Eget(&quot;client_info&quot;, {})</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        antivirus =3D &quot;antivirus&quot; in dpc_res=
ponse</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        disk_e=
ncryption =3D &quot;disk_encryption&quot; in dpc_response</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        logger=2Einfo(</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            f&quot;Received DPC1 response: antivirus=
=3D{antivirus}, disk_encryption=3D{disk_encryption}, client_info=3D{client_=
info}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        # Normally here wo=
uld be a check that the response matches the policy</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        # this demo script just allows ev=
eryone with a response to pass</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        client=2Edpc_completed =3D True</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        self=2Equeue_command(f&quot;client-auth-nt {client=2Eci=
d} {kid}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    async def dpc_reque=
st_timeout(self, client: DpcConnectedClient, kid: int, timeout: int):</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        await asyncio=2Es=
leep(timeout)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if client=2Edpc_completed:</span><br><span style=3D"color: hsl(120, 100%,=
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
><span style=3D"color: hsl(120, 100%, 40%);">+        asyncio=2Ecreate_task=
(self=2Echeck_client_posture(client, kid))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    def client_event_REAUTH(self, client: DpcConnectedClient, kid: int,=
 env: dict, extra: str):</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        print(f&quot;Re-authenticating client {client}, {kid}, protos:=
 {client=2Eacc_negotiated_protocols}&quot;)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        client=2Eenv =3D env</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        # Check client posture again on r=
enegotiation</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 asyncio=2Ecreate_task(self=2Echeck_client_posture(client, kid))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    async def check_client_posture(self, client: =
DpcConnectedClient, kid: int):</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        await self=2Equeue_command(</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            f&quot;client-pending-auth {client=
=2Ecid} {kid} \&quot;NOTIFY::Checking your device posture, please wait\&quo=
t; 180&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        await self=2Equeu=
e_command(f&quot;client-pending-auth {client=2Ecid} {kid} ACC 180&quot;)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        # In this exam=
ple we wait for 20 seconds to simulate a posture check on the server</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        await asyncio=2Esl=
eep(20)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if &quot;dpc1&quot; not=
 in client=2Eacc_negotiated_protocols:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            await self=2Esend_client_deny_no_dpc1(client=
, kid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            r=
eturn</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        dpc_cmd =3D {&quot;dpc_re=
quest&quot;: {&quot;ver&quot;: &quot;1=2E0&quot;, &quot;correlation_id&quot=
;: &quot;n/a&quot;, &quot;timestamp&quot;: &quot;yesterday&quot;, &quot;cli=
ent_info&quot;: True,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                   &quot;disk_encryption&quot;: {&quot;fu=
ll&quot;: True}, &quot;antivirus&quot;: {}}}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        dpc_cmd_str =3D json=2Edumps(dpc_cmd)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        acc_protocol =3D &quot;dpc1&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        await self=2Esend_acc_msg(clie=
nt, kid, acc_protocol, dpc_cmd_str=2Eencode())</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        asyncio=2Ecreate_task(self=2Edpc_request=
_timeout(client, kid, 60))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+async def main(connect_data: Co=
nnectData):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tran=
sport, protocol, finish_future =3D await start_management_protocol(connect_=
data, OmiDPCServerProtocol)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    managem=
ent_version =3D await protocol=2Emanagement_ready()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    logger=2Edebug(f&quot;Management inte=
rface version: {management_version}&quot;)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    await protocol=2Eenable_log()</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   await protocol=2Eset_bytecount_interval(5)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    await finish_future</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+if __name__ =3D=3D &#39;__m=
ain__&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    run_=
main(main)</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1860?usp=3Demail">change 1860</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie20289737d502a25e=
edc60677d3c350ddc3b3c22 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1860 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<=
div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Name of user =
not set #1000061 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: Name of user not set #1000061 </div>

</body>=
</html>
--FLEil6ykBi4=--


--===============2369691429680528381==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2369691429680528381==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2369691429680528381==--

