Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5FC606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LwRgpz+8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mw1lpi22;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Pa9pcCbI;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=W6UybVQK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gRUQ+QnYwGseF9hfhSdLPEzB7wOJb0u6jGtkYRgzeK4=; b=LwRgpz+8d2EIwPHAdv9WsbuWNq
	HemZpgJC3/YaP39wDq6cdB69Xvin881o6AfVlGOVEHYO/CjXh56tlvDNU6rHf1YjLPfOShyYG1p1y
	KdRwCrPgBVyTAsMXfpLgNCGAc6Eexfu7Hw78AzJtsagIRvWDt3w+9IFrKTmzikmIryhg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOjpP-000000007Ho-31iU;
	Wed, 04 Nov 2026 22:51:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOjpM-000000007Hf-3rLq
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 22:51:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8xofG6t/ytWN2ONnURrkMATCUmtXzQirH0e8rpQ0CWo=; b=mw1lpi22futomS6TkMMyDMwTxo
 aVeTaVzAERjd0H4LEvM7qUp2wLjtF5HYXY+FeWgqRQBhv5S+ThhPw3bZVJ8mL8/rmo3AudUFTK7kn
 wHaUEcYQ2a+ZFZ3K1M66PUU/9YbK99GtRyTUnzwKaLbKEjgY0GBJqyqD7y8/E9YG0bC0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8xofG6t/ytWN2ONnURrkMATCUmtXzQirH0e8rpQ0CWo=; b=Pa9pcCbIV26KP5JXk5GEnDtnZF
 PaId5SuegqZ/vV+cdyB6CaJ5ubsy/Bh+TF7sXauGnlV6ZlA4TwroMtZtS1KUBbhhpnoqBsuGAXja1
 37jRXvNLHsSL7G9SqqLpOwTTkNc0Q/7cT6TEoF6+KX0g8mAvX+IPjAAWQJHVvXgcHkv0=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOjpK-000000000eu-1g7b for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 22:51:32 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so10035935e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 14:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793832684; x=1794437484; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8xofG6t/ytWN2ONnURrkMATCUmtXzQirH0e8rpQ0CWo=;
 b=W6UybVQKRkCdY7VgsU70pLJrXmuq5iL29T2UuWNKccmyiBFhoeR/upzyNP8dVBqS97
 XPakpi6uiv7zD7lcIEdDlhe4YZFk3dljDIIMgRUD3IJrTHQrzuhmiUtU/6hG/Vhsyl9k
 9dL14QqPv0T0KinH8LFRgD5BqaoRJGqiDZSUhTbWtF1wGlvN7pQkKDQo9yUF8p/3Sl8P
 gSxUw4G+hzzeitjU2Z4NQ5OVVY8iGbgpB+50jQmgjVAUaj4iMvCE4Z6cDBP3t8BkAISp
 KCWXvXjF/j/qi3ZLy5VBWZn8VJeW30UzRQOUtkXd/dl2dEHnURRjaVtrXdVPupWOqBOl
 xf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793832684; x=1794437484;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8xofG6t/ytWN2ONnURrkMATCUmtXzQirH0e8rpQ0CWo=;
 b=twg7IXyuigEQPLpHBAWDmNs2v2ERIodgLDvl7MAJX0k85pU/PM0YURiCn6T9fzJb//
 L5Vo6LqGzaFRgZFz9Ej8YZhRuoHsUvph3gnNP1ySGz+lnJF2NifwTaSdyJot9SnbmI5p
 RLVUzFfnH55254cg++MblwNMWq7x2WGpTRTgLR1E47OH7RIEfwu8efbZDst7Ur7UonYk
 4V0TQzGVtrI7131tY7vzrw3LMaO/htk+jnkysuYC8zyd1cj/Cm031sZ2lsikUjPeDyJF
 kx27YCead0ciu3AUjAzjUUCny7Ygf+UaLujN+b0Iiv2QaFY9Y3NidO/Df6aswFL4C9ou
 s/zA==
X-Gm-Message-State: APuU4Z8LR0MP/88O4N6BMgko7J+Y8XS8k4Em3hBI41YeBBW+iz7Ar7Ex
 uW3N6z87wyfRpakWeWHDDnD2X62gn+ueJPoXHB2zXK88aqtHjaxAmp6Ow4xId9RZUvgv2At864s
 DwzEg8tOLlQan8OJqXc4RXa4sninjeB9J9oLq74hCy941BH2fWy1nATgIHMiM4e8ucjGWz0hANT
 Qa7MYsOQ==
X-Gm-Gg: AYBFou0DnpdHOh07tgUgwMPjL3UWmj6+244rZfSoEuIIsjOlzLyC6H02EGTgJEjb5Wn
 VdWPg5F+CuTha787RlHTHDOr9bxr88xBYh/DTQZlrPwp6ejK8kkVjWCwTAgYXEEYGUhFaJd20i0
 7kRuge3kWrORqedHmjcFrdC7AQQ1OQzibVTF8NH8mFhmnVtDtvgkIBDz8xkHjCmryjZ/10HBFWo
 C7xE/VRYvJTa2fN2SEugrH+z6DixeJ3MIMaNBNTmhUxE2OBrARMsneNjiimCU3qrqnfeAI0xnVx
 01TX22eI1oIM+BBQNSbmimgooJPVrgwpk+RmGnRBbo5DsV8J1IRWPgf/njf0Cuq+KilekAna9t8
 m8wYA0hHuhlRoyMugHk3Bn5GMkHigBlRuKzDcu5BzMqCju76T6GLsTu+UXxY3b98G2Y294SbJ0r
 PsrDRcLVIgb6loLRktPuEVX2cRrQ2uAU74ArtHGiDQQMMv2qNfXH8P5Y22fVqvMq/uCCk/dOkdn
 MkuOpnCMj9v28kPAp8rHjc2KJfB9+O6wawm8BnS1Y9IUdQ2sHEiihDV0/yUFgtKimsrVti965eX
 IgWSOGkS8jDgHbKO5dqog9XNmizipjn/sJ3V+hR2my5qUAsgNLOog0Kp4JjEfem9FV6hakKTUX6
 VJDyS++0cAbqhDPukGKbdlMRq2GQZxTlWPhiEgtasyJNeTHXgVt3rU0Xq1Ja0YMZPHiyYoSuPt5
 /39vrH2EydDBiecQ==
X-Received: by 2002:a05:600c:3b87:b0:4a2:150f:1607 with SMTP id
 5b1f17b1804b1-4ac1709ad56mr413597015e9.13.1793832683510; 
 Wed, 04 Nov 2026 14:51:23 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56e58fcc6sm29172225e9.2.2026.11.04.14.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 14:51:22 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 22:51:17 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22
X-Gerrit-Change-Number: 1860
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1860?usp=email>
X-Gerrit-Commit: 2eab5e0e8841fc61017933bfe62d7386c7f3de94
In-Reply-To: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
References: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzQ1NDE2MDAwLkllMjAyODk3MzdkNTAyYTI1ZWVkYzYwNjc3ZDNjMzUwZGRjM2IzYzIyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fe5214e4b0c74321f906d962fed3264091f1f2fa-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOjpK-000000000eu-1g7b
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
Content-Type: multipart/mixed; boundary="===============0443032629514892052=="
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0443032629514892052==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="T02+xmqDzg4="; charset=UTF-8

--T02+xmqDzg4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Ralf Lici=2E

Arne Schw=
abe has uploaded a new patch set (#7)=2E ( https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1860?usp=3Demail )


Change subject: Add python scripts that dem=
onstrate using the dpc1 ACC protocol
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

Add python scripts that demonstrate using the dpc=
1 ACC protocol

The dpc1 protocol is used by the OpenVPN Connect clients an=
d
OpenVPN Connexa=2E

Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22
=
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
A sample/management/ac=
c_dpc1_client_demo=2Epy
A sample/management/acc_dpc1_server_demo=2Epy
2 fil=
es changed, 265 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/60/1860/7

diff --git a/sample/mana=
gement/acc_dpc1_client_demo=2Epy b/sample/management/acc_dpc1_client_demo=
=2Epy
new file mode 100755
index 0000000=2E=2E9849f15
--- /dev/null
+++ b/s=
ample/management/acc_dpc1_client_demo=2Epy
@@ -0,0 +1,110 @@
+#!/usr/bin/en=
v python3
+# Copyright (c) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+# Copyri=
ght (c) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+#
+# Permission is hereby g=
ranted, free of charge, to any person obtaining a copy
+# of this software =
and associated documentation files (the "Software"), to deal
+# in the Soft=
ware without restriction, including without limitation the rights
+# to use=
, copy, modify, merge, publish, distribute, sublicense, and/or sell
+# copi=
es of the Software, and to permit persons to whom the Software is
+# furnis=
hed to do so, subject to the following conditions:
+#
+# The above copyrigh=
t notice and this permission notice shall be included in all
+# copies or s=
ubstantial portions of the Software=2E
+#
+# THE SOFTWARE IS PROVIDED "AS I=
S", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT =
LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR P=
URPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE
+# AUTHORS OR COPYRIGHT=
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN=
 AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+# OUT OF OR IN CO=
NNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+# SOFTWARE=
=2E
+
+# This implements a small demonstration of using the
+# OpenVPN Acce=
ss Server Management Interface (OMI) and an app Custom Control
+# protocol =
(dpc1)=2E To use this use on the client use
+
+# --management-client-auth
+=
# --app-custom-control dpc1
+# --management /path/to/acc_dpc1_client_demo=
=2Epy unix-script
+
+import base64
+import json
+import logging
+import pla=
tform
+from asyncio import CancelledError, Future
+
+logging=2EbasicConfig(=
)
+
+from omi_tools import run_main, start_management_protocol, ConnectData=

+from omi_client_protocol import OMIClientProtocol
+
+logger =3D logging=
=2EgetLogger(__name__)
+
+class OmiDpc1ClientProtocol(OMIClientProtocol):
+=
    def __init__(self, finish_future: Future, connect_data: ConnectData):
+=
        super()=2E__init__(finish_future, connect_data)
+
+    async def re=
ceive_acc_dpc1(self, acc_message: bytes):
+        msg =3D json=2Eloads(acc=
_message)
+
+        logger=2Eerror(f"Received dpc1 message: {acc_message}"=
)
+
+        dpc_request =3D msg["dpc_request"]
+        ver =3D dpc_reques=
t["ver"]
+        if ver !=3D "1=2E0":
+            logger=2Ewarning(f"Rece=
ived unknown ACC protocol version: {ver}")
+            return
+
+        c=
lient_info =3D dpc_request=2Eget("client_info", False)
+        antivirus =
=3D "antivirus" in dpc_request
+        disk_encryption =3D "disk_encryptio=
n" in dpc_request
+
+        logger=2Einfo(
+            f"Received DPC1 re=
quest: antivirus=3D{antivirus}, disk_encryption=3D{disk_encryption}, client=
_info=3D{client_info}")
+
+        if client_info:
+            await self=
=2E_send_dpc1_client_info()
+
+    async def _send_dpc1_client_info(self):
=
+        system =3D platform=2Esystem()
+        if system =3D=3D "Darwin":=

+            system =3D "MacOS"
+
+        response =3D {
+            "dp=
c_response": {
+                "ver": "1=2E0",
+                "client_in=
fo": {
+                    "os": {
+                        "type": system=
,
+                        "version": platform=2Erelease(),
+              =
          "extra":
+                            {
+                        =
        "arch": platform=2Emachine(),
+                            }
+     =
               }
+                }
+            }
+        }
+
+        ac=
c_msg =3D json=2Edumps(response)=2Eencode()
+        await self=2Esend_acc_=
msg("dpc1", acc_msg)
+
+
+async def main(connect_data: ConnectData):
+    t=
ransport, protocol, finish_future =3D await start_management_protocol(conne=
ct_data, OmiDpc1ClientProtocol)
+
+    management_version =3D await protoco=
l=2Emanagement_ready()
+    logger=2Edebug(f"Management interface version: =
{management_version}")
+
+    await protocol=2Eset_bytecount_interval(5)
+
=
+    try:
+        await finish_future
+    except CancelledError:
+       =
 # Ignore errors like ones caused by Control+C in the demo script
+        =
pass
+
+
+if __name__ =3D=3D '__main__':
+    run_main(main)
diff --git a/s=
ample/management/acc_dpc1_server_demo=2Epy b/sample/management/acc_dpc1_ser=
ver_demo=2Epy
new file mode 100755
index 0000000=2E=2E0a6dad5
--- /dev/null=

+++ b/sample/management/acc_dpc1_server_demo=2Epy
@@ -0,0 +1,155 @@
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
otocol (dpc1)=2E To use this use on the server
+
+# --management-client-aut=
h
+# --app-custom-control dpc1
+# --management /path/to/acc_dpc1_server_dem=
o=2Epy unix-script
+
+# Note this is just a demonstration and not a product=
ion-ready solution=2E
+# When modifying this code, keep the security in min=
d=2E It is easy to
+# introduce a security problem when writing scripts han=
dling authentication
+
+import asyncio
+import json
+import logging
+from a=
syncio import Future
+from dataclasses import field, dataclass
+from pprint=
 import pprint
+from typing import Dict
+
+logging=2EbasicConfig()
+
+from =
omi_server_protocol import OMIServerProtocol, ConnectedClient
+from omi_too=
ls import start_management_protocol, ConnectData, run_main
+
+logger =3D lo=
gging=2EgetLogger(__name__)
+
+
+@dataclass
+class DpcConnectedClient(Conne=
ctedClient):
+    # Remember the key-id that we authenticated
+    dpc_comp=
leted: bool =3D False
+    env: Dict[str, str] =3D field(default_factory=3D=
dict)
+
+
+class OmiDPCServerProtocol(OMIServerProtocol):
+    def __init__=
(self, finish_future: Future, connect_data: ConnectData):
+        super()=
=2E__init__(finish_future, connect_data)
+        self=2E_connected_client_=
class =3D DpcConnectedClient
+
+    def receive_acc_client_dpc1(self, clien=
t: DpcConnectedClient, kid: int, acc_message: bytes):
+        print(f"Rece=
ived DPC1 message: {acc_message!r}")
+        msg =3D json=2Eloads(acc_mess=
age)
+        pprint(msg)
+
+        dpc_response =3D msg["dpc_response"]
+=
        ver =3D dpc_response["ver"]
+        if ver !=3D "1=2E0":
+        =
    logger=2Eerror(f"Received unknown ACC protocol version: {ver}")
+      =
      return
+
+        client_info =3D dpc_response=2Eget("client_info", {=
})
+        antivirus =3D "antivirus" in dpc_response
+        disk_encrypt=
ion =3D "disk_encryption" in dpc_response
+
+        logger=2Einfo(
+      =
      f"Received DPC1 response: antivirus=3D{antivirus}, disk_encryption=3D=
{disk_encryption}, client_info=3D{client_info}")
+
+        # Normally here=
 would be a check that the response matches the policy
+        # this demo=
 script just allows everyone with a response to pass
+        client=2Edpc_=
completed =3D True
+
+        _ =3D self=2Equeue_command(f"client-auth-nt {=
client=2Ecid} {kid}")
+
+    async def dpc_request_timeout(self, client: Dp=
cConnectedClient, kid: int, timeout: int):
+        await asyncio=2Esleep(t=
imeout)
+        if client=2Edpc_completed:
+            return
+
+        =
client_deny =3D f'client-deny {client=2Ecid} {kid} "dpc1 timeout" "Timeout =
on device posture"'
+        await self=2Equeue_command(client_deny)
+
+   =
 def client_event_ESTABLISHED(self, client: DpcConnectedClient, kid: int, e=
nv: dict, extra: str):
+        print(f"CLient connected: {client}")
+
+   =
 async def send_client_deny_no_dpc1(self, client: DpcConnectedClient, kid: =
int):
+        client_reason =3D "ACC[protocol dpc1]: To connect to this se=
rver you " \
+                        "need to upgrade to a client that sup=
ports the " \
+                        "OpenVPN Inc device posture protocol=
 and has it " \
+                        "enabled, e=2Eg=2E OpenVPN for And=
roid, openvpn3-linux, " \
+                        "or OpenVPN Connect"
+  =
      client_deny =3D f'client-deny {client=2Ecid} {kid} "no dpc1 support" =
"{client_reason}"'
+        await self=2Equeue_command(client_deny)
+
+    =
def client_event_CONNECT(self, client: DpcConnectedClient, kid: int, env: d=
ict, extra: str):
+        print(f"Authenticating client {client}, {kid}, p=
rotos: {client=2Eacc_negotiated_protocols}")
+        client=2Eenv =3D env
=
+        asyncio=2Ecreate_task(self=2Echeck_client_posture(client, kid))
+
=
+    def client_event_REAUTH(self, client: DpcConnectedClient, kid: int, en=
v: dict, extra: str):
+        print(f"Re-authenticating client {client}, {=
kid}, protos: {client=2Eacc_negotiated_protocols}")
+        client=2Eenv =
=3D env
+        # Check client posture again on renegotiation
+        asy=
ncio=2Ecreate_task(self=2Echeck_client_posture(client, kid))
+
+    async d=
ef check_client_posture(self, client: DpcConnectedClient, kid: int):
+     =
   await self=2Equeue_command(
+            f"client-pending-auth {client=
=2Ecid} {kid} \"NOTIFY::Checking your device posture, please wait\" 180")
+=

+        await self=2Equeue_command(f"client-pending-auth {client=2Ecid} {=
kid} ACC 180")
+        # In this example we wait for 20 seconds to simulat=
e a posture check on the server
+        await asyncio=2Esleep(20)
+
+     =
   if "dpc1" not in client=2Eacc_negotiated_protocols:
+            await s=
elf=2Esend_client_deny_no_dpc1(client, kid)
+            return
+
+        =
dpc_cmd =3D {"dpc_request": {"ver": "1=2E0", "correlation_id": "n/a", "time=
stamp": "yesterday", "client_info": True,
+                                =
   "disk_encryption": {"full": True}, "antivirus": {}}}
+
+        dpc_cmd_=
str =3D json=2Edumps(dpc_cmd)
+        acc_protocol =3D "dpc1"
+
+        c=
lient=2Edpc_completed =3D False
+        await self=2Esend_acc_msg(client, =
kid, acc_protocol, dpc_cmd_str=2Eencode())
+        asyncio=2Ecreate_task(s=
elf=2Edpc_request_timeout(client, kid, 60))
+
+
+async def main(connect_dat=
a: ConnectData):
+    transport, protocol, finish_future =3D await start_ma=
nagement_protocol(connect_data, OmiDPCServerProtocol)
+
+    management_ver=
sion =3D await protocol=2Emanagement_ready()
+    logger=2Edebug(f"Manageme=
nt interface version: {management_version}")
+
+    await protocol=2Eenable=
_log()
+
+    await protocol=2Eset_bytecount_interval(5)
+
+    await finis=
h_future
+
+
+if __name__ =3D=3D '__main__':
+    run_main(main)

-- 
To vi=
ew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie20289737d502a25eedc6067=
7d3c350ddc3b3c22
Gerrit-Change-Number: 1860
Gerrit-PatchSet: 7
Gerrit-Owner=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Name of user not set=
 #1000061
Gerrit-CC: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Ralf Lici <=
ralf@mandelbit=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>

--T02+xmqDzg4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Ralf Lici=2E </p>
<p>Arne Schwabe <stro=
ng>uploaded patch set #7</strong> to this change=2E</p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Add python scripts that demonstrate using the dpc1 ACC protoco=
l<br><br>The dpc1 protocol is used by the OpenVPN Connect clients and<br>Op=
enVPN Connexa=2E<br><br>Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c2=
2<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>A sam=
ple/management/acc_dpc1_client_demo=2Epy<br>A sample/management/acc_dpc1_se=
rver_demo=2Epy<br>2 files changed, 265 insertions(+), 0 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/60/1860/7</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/sample/management/acc_dpc1_client=
_demo=2Epy b/sample/management/acc_dpc1_client_demo=2Epy</span><br><span>ne=
w file mode 100755</span><br><span>index 0000000=2E=2E9849f15</span><br><sp=
an>--- /dev/null</span><br><span>+++ b/sample/management/acc_dpc1_client_de=
mo=2Epy</span><br><span>@@ -0,0 +1,110 @@</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#!/usr/bin/env python3</span><br><span style=3D"color=
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
ements a small demonstration of using the</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+# OpenVPN Access Server Management Interface (OMI) an=
d an app Custom Control</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# protocol (dpc1)=2E To use this use on the client use</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# --management-client-auth</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+# --app-custom-control dpc1</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+# --management /path/to/acc_dpc1_client_=
demo=2Epy unix-script</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import base64</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+import json</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+import logging</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+import platform</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+from asyncio import CancelledError, Futu=
re</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+logging=2EbasicConfig()</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+from omi_tools import run_main, start_management_pr=
otocol, ConnectData</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
from omi_client_protocol import OMIClientProtocol</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+logger =3D logging=2EgetLogger(__name__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+class OmiDpc1ClientProtocol(OMIClientProtocol):</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    def __init__(self, finish_fu=
ture: Future, connect_data: ConnectData):</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        super()=2E__init__(finish_future, connect_dat=
a)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    async def receive_acc_dpc1(self,=
 acc_message: bytes):</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        msg =3D json=2Eloads(acc_message)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        logger=2Eerror(f&quot;Received dpc1 message: {acc_message}&quo=
t;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        dpc_request =3D msg[&quot;d=
pc_request&quot;]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      ver =3D dpc_request[&quot;ver&quot;]</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if ver !=3D &quot;1=2E0&quot;:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            logger=2Ewarning(f&qu=
ot;Received unknown ACC protocol version: {ver}&quot;)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            return</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        client_info =3D dpc_request=2Eget(&quot;client_info&=
quot;, False)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  antivirus =3D &quot;antivirus&quot; in dpc_request</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        disk_encryption =3D &quot;disk_en=
cryption&quot; in dpc_request</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        l=
ogger=2Einfo(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      f&quot;Received DPC1 request: antivirus=3D{antivirus}, disk_encryptio=
n=3D{disk_encryption}, client_info=3D{client_info}&quot;)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if client_info:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            await self=2E_send_dpc1_client_info()</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    async def _send_dpc1_client_info(self=
):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        system =
=3D platform=2Esystem()</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if system =3D=3D &quot;Darwin&quot;:</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            system =3D &quot;MacOS&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        response =3D {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &quot;dpc_response&quot;: {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot=
;ver&quot;: &quot;1=2E0&quot;,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                &quot;client_info&quot;: {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    &quot;os&quot;: {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
 &quot;type&quot;: system,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                        &quot;version&quot;: platform=2Erelease(),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
   &quot;extra&quot;:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                            {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                &quot;arch&quot;: platform=2Ema=
chine(),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        acc_msg =3D json=2Edumps(res=
ponse)=2Eencode()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      await self=2Esend_acc_msg(&quot;dpc1&quot;, acc_msg)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+async def main(connect_data: ConnectData):</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    transport, protocol, finish_future =3D await st=
art_management_protocol(connect_data, OmiDpc1ClientProtocol)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    management_version =3D await protocol=2Emanagemen=
t_ready()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    logger=
=2Edebug(f&quot;Management interface version: {management_version}&quot;)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    await protocol=2Eset_bytecount_inter=
val(5)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    try:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        await finish_future</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    except CancelledError:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        # Ignore errors li=
ke ones caused by Control+C in the demo script</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        pass</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if __name__ =3D=3D=
 &#39;__main__&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    run_main(main)</span><br><span>diff --git a/sample/management/acc_dpc1=
_server_demo=2Epy b/sample/management/acc_dpc1_server_demo=2Epy</span><br><=
span>new file mode 100755</span><br><span>index 0000000=2E=2E0a6dad5</span>=
<br><span>--- /dev/null</span><br><span>+++ b/sample/management/acc_dpc1_se=
rver_demo=2Epy</span><br><span>@@ -0,0 +1,155 @@</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#!/usr/bin/env python3</span><br><span style=
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
0%, 40%);">+# protocol (dpc1)=2E To use this use on the server</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+# --management-client-auth</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+# --app-custom-control dpc1</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+# --management /path/to/acc_dpc1_ser=
ver_demo=2Epy unix-script</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Note this i=
s just a demonstration and not a production-ready solution=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+# When modifying this code, keep =
the security in mind=2E It is easy to</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+# introduce a security problem when writing scripts handl=
ing authentication</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+import asyncio</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+import json</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+import logging</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+from asyncio import Future</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+from dataclasses import field, =
dataclass</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from pprin=
t import pprint</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from=
 typing import Dict</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+logging=2EbasicConf=
ig()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+from omi_server_protocol import OM=
IServerProtocol, ConnectedClient</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+from omi_tools import start_management_protocol, ConnectData, =
run_main</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+logger =3D logging=2EgetLogger=
(__name__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+@dataclass</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+class DpcConnectedClient(ConnectedClient):</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    # Remember the key-id that we=
 authenticated</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    d=
pc_completed: bool =3D False</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    env: Dict[str, str] =3D field(default_factory=3Ddict)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+class OmiDPCServerProtocol(OMIServerProtocol):</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    def __init__(self, finish_future: F=
uture, connect_data: ConnectData):</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        super()=2E__init__(finish_future, connect_data)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_connecte=
d_client_class =3D DpcConnectedClient</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   def receive_acc_client_dpc1(self, client: DpcConnectedClient, kid: int, =
acc_message: bytes):</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        print(f&quot;Received DPC1 message: {acc_message!r}&quot;)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        msg =3D json=2Eload=
s(acc_message)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   pprint(msg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        dpc_response =3D=
 msg[&quot;dpc_response&quot;]</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        ver =3D dpc_response[&quot;ver&quot;]</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if ver !=3D &quot;1=2E0&quot;:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            logger=
=2Eerror(f&quot;Received unknown ACC protocol version: {ver}&quot;)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            return</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        client_info =3D dpc_response=2Eget(&quo=
t;client_info&quot;, {})</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        antivirus =3D &quot;antivirus&quot; in dpc_response</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        disk_encryption =3D &q=
uot;disk_encryption&quot; in dpc_response</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        logger=2Einfo(</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            f&quot;Received DPC1 response: antivirus=3D{antivirus}, d=
isk_encryption=3D{disk_encryption}, client_info=3D{client_info}&quot;)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        # Normally here would be a check =
that the response matches the policy</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        # this demo script just allows everyone with a res=
ponse to pass</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  client=2Edpc_completed =3D True</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   _ =3D self=2Equeue_command(f&quot;client-auth-nt {client=2Ecid} {kid}&qu=
ot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    async def dpc_request_timeout(=
self, client: DpcConnectedClient, kid: int, timeout: int):</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        await asyncio=2Esleep(timeou=
t)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if client=
=2Edpc_completed:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        client_deny =
=3D f&#39;client-deny {client=2Ecid} {kid} &quot;dpc1 timeout&quot; &quot;T=
imeout on device posture&quot;&#39;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        await self=2Equeue_command(client_deny)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    def client_event_ESTABLISHED(self, client: Dpc=
ConnectedClient, kid: int, env: dict, extra: str):</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        print(f&quot;CLient connected: {clie=
nt}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    async def send_client_de=
ny_no_dpc1(self, client: DpcConnectedClient, kid: int):</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        client_reason =3D &quot;ACC[pro=
tocol dpc1]: To connect to this server you &quot; \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        &quot;need to upg=
rade to a client that supports the &quot; \</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                        &quot;OpenVPN Inc device po=
sture protocol and has it &quot; \</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                        &quot;enabled, e=2Eg=2E OpenVPN for =
Android, openvpn3-linux, &quot; \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                        &quot;or OpenVPN Connect&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        client_deny =3D f&=
#39;client-deny {client=2Ecid} {kid} &quot;no dpc1 support&quot; &quot;{cli=
ent_reason}&quot;&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        await self=2Equeue_command(client_deny)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    def client_event_CONNECT(self, client: DpcConnectedClient, =
kid: int, env: dict, extra: str):</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        print(f&quot;Authenticating client {client}, {kid}, p=
rotos: {client=2Eacc_negotiated_protocols}&quot;)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        client=2Eenv =3D env</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        asyncio=2Ecreate_task(self=
=2Echeck_client_posture(client, kid))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   def client_event_REAUTH(self, client: DpcConnectedClient, kid: int, env:=
 dict, extra: str):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        print(f&quot;Re-authenticating client {client}, {kid}, protos: {cli=
ent=2Eacc_negotiated_protocols}&quot;)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        client=2Eenv =3D env</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        # Check client posture again on renegot=
iation</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        async=
io=2Ecreate_task(self=2Echeck_client_posture(client, kid))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    async def check_client_posture(self, client: DpcCon=
nectedClient, kid: int):</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        await self=2Equeue_command(</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            f&quot;client-pending-auth {client=2Ecid} =
{kid} \&quot;NOTIFY::Checking your device posture, please wait\&quot; 180&q=
uot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        await self=2Equeue_comman=
d(f&quot;client-pending-auth {client=2Ecid} {kid} ACC 180&quot;)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        # In this example we w=
ait for 20 seconds to simulate a posture check on the server</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        await asyncio=2Esleep(20)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if &quot;dpc1&quot; not in clie=
nt=2Eacc_negotiated_protocols:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            await self=2Esend_client_deny_no_dpc1(client, kid)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        dpc_cmd =3D {&quot;dpc_request&qu=
ot;: {&quot;ver&quot;: &quot;1=2E0&quot;, &quot;correlation_id&quot;: &quot=
;n/a&quot;, &quot;timestamp&quot;: &quot;yesterday&quot;, &quot;client_info=
&quot;: True,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                             &quot;disk_encryption&quot;: {&quot;full&quot;=
: True}, &quot;antivirus&quot;: {}}}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      dpc_cmd_str =3D json=2Edumps(dpc_cmd)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        acc_protocol =3D &quot;dpc1&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        client=2Edpc_completed =3D False</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        await self=2Esend_a=
cc_msg(client, kid, acc_protocol, dpc_cmd_str=2Eencode())</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        asyncio=2Ecreate_task(self=2E=
dpc_request_timeout(client, kid, 60))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+async def main(conne=
ct_data: ConnectData):</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    transport, protocol, finish_future =3D await start_management_protoc=
ol(connect_data, OmiDPCServerProtocol)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    management_version =3D await protocol=2Emanagement_ready()</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    logger=2Edebug(f&quot;Manage=
ment interface version: {management_version}&quot;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    await protocol=2Eenable_log()</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    await protocol=2Eset_bytecount_interval(5)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    await finish_future</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if __name__ =3D=
=3D &#39;__main__&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    run_main(main)</span><br></pre><p>To view, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail">change 1860</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie2028973=
7d502a25eedc60677d3c350ddc3b3c22 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1860 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7=
 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Name=
 of user not set #1000061 </div>
<div style=3D"display:none"> Gerrit-CC: Ra=
lf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Ralf Lici &lt;ralf@mandel=
bit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--T02+xmqDzg4=--


--===============0443032629514892052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0443032629514892052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0443032629514892052==--

