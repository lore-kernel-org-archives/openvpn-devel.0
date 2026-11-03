Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F2E606A326
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mKIC2MHf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=g3Euflao;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=V/WUAoXV;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=MfNR9Fo8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zLexJwabS18lOHH+hrKIbfoxr3PEZrQLp3VUxyHxvyM=; b=mKIC2MHfrshzG6+BNzcm6m9Dw4
	tS/nIlgzVK3zy2P8ZNCw70dTCcGv2NUSdL25gKh1GiO4hZROPfi4PzDoWyIIH/Mk51a1Op7iXOsdl
	S1sX03QijwyUVugPBLAtk5mJKytuVBWKoOBWAOqy8h2nzi+wsVcBNEYg6/kaRULDHDfI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOJ9V-000000005tV-0va5;
	Tue, 03 Nov 2026 18:22:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOJ9T-000000005tN-37vi
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 18:22:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UQA9ZkMleWL8fpr2iLwkCpL10UVpQKhu4oONvbDXX2Y=; b=g3EuflaoEDcyOoAnZ/0AxxVNvg
 XpQl9LyYh9wlXgfoIuu9x3h8y9kgTgEs8PmGSwOq+lr+jBCNcoiRyYNCnGIUR48kMFeFrvUvvOCzR
 BvlZAyHq5wRipPV6/EuJSDT89jSqsDLDjoXcE5avQfG9cWtmbs/Dtgswet5r8MfYHaDA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UQA9ZkMleWL8fpr2iLwkCpL10UVpQKhu4oONvbDXX2Y=; b=V/WUAoXV4zEYz5twgNm8G76tCP
 /1JTCny3ni4XtnLxBWtYTqj3iEODBNXA+krGC+iNLWE2tgfXyQy0gJqZ9XocYL3pT2euh66ha6S1A
 RdZcrLnww88NK8l9xcBs7UHqpQefpERHXXy50QqCmtTRm+s2PrF9+uyuf7kIj0q9Fc64=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOJ9Q-000000002jo-1u38 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 18:22:31 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so49929915e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 10:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793730142; x=1794334942; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UQA9ZkMleWL8fpr2iLwkCpL10UVpQKhu4oONvbDXX2Y=;
 b=MfNR9Fo8QQZBOMVosBEssG7OyWprMFptsLOe5ZKFTiFDYO2Ubb2YWDJD5TBbZNHDhr
 0F2N0r2pDbRur7B2MGw/nMy1nLfRUL8XDlg9RgKPgViWYIWXjMgNO9BhsXj0B5UUCGPv
 /zDfSec8vkrMokB0immDvmfYlBbzwC0bryd48FNLmer9Lw148mSu760cdLIDTUZoHZaH
 s8OBAfcCJQN9rTzMJSpebjbR/fCQtkaQZvHL82xK25xXNZ/oxYHMjA5LFvDq31XRsV+T
 7eBEdm2Qy7IsNMkkvB1hgB06ZUPqlu6e1ZRog4zFdd2OeZZYIx8mz3uLl5xFkQZv0hc5
 M7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793730142; x=1794334942;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UQA9ZkMleWL8fpr2iLwkCpL10UVpQKhu4oONvbDXX2Y=;
 b=DjtYAsgmWcHkCv/3xhYD2NyR19/ZK4xf0XDBAjZZaadkGQqd8PL+4RtbXED3Aj7C63
 mSo4FSs4YzlRDaLeEKP5M/j+LYWXiz4LTrZjuzePb0q7OvZbY0NGfETkIGsrlTqJLPPs
 VkTWf+EfdKVj8Qllwe6O4twXE2GeX+H7Hldyoa/PX1r2Q7KjfFA+yCEzsHnhgcBQs+hC
 Bou2NvmUa0KvBk4uosQuTGcCR+K4Vu4QRb/XUQYSPowV0RQravAFihgiuLzz6AcRoVNh
 J53DZRkhLwn9cQJsSBckigoI+tA3Df/NlZHi8XQV9Ptlsbfjddsh6vcg11AQOZK1dqN+
 EU8w==
X-Gm-Message-State: APuU4Z/6ha0lxBfghIbMvDWyUjXxucuwAJ+keN2cMt3FqmOgpjMXSxmq
 dHjMYlkUzvtLjPMh27CIyfA7OuWlMkmIgYoiDSzWuWrg8bnlsTNAZ/JmuG3qX4652jjfrp/8qhC
 U5itKsG+4jAySkJZvclBPBlkBBJqO/1B5PJZRe1MCk9A8XMn7ROOy9O3tEqkq0krc/bTByhvAV+
 cTzNgHOA==
X-Gm-Gg: AYBFou3OlSSD5hUCCF10cNRCY3wkSA83DDiZ7VzmrnUpM2HLqsdGYe1x5iChM5aFmsB
 afuUBNnyaIXBhOuHbnIbMz62ztBcCmdbxtS95JVgHnalxSKCkAPBuW8x6KfAFCe1ma7zpWxDd3I
 uuu/6xg/5GHIvHWqQcflFUVWLjXA8P3dKDiWW/BQ7HR+f6hqFNzJDUfEJjZj3D8bVB669MIK11q
 cPzG/dqjckMovy3bq5kJIm6h28tLaQ7TbpFMHktsMPGLecwgF0WOYz26SxL6gmaofwWt1sVcw2P
 dI2QuJhC+0uFloVAvNjC32eAYh2YfhkkC41zdSNN0spaqDxaJRuBJ626xHA6z815+vSk/HuJcdh
 MZXY7fqWwK05K0UTUZJyAFPCE3zetxt/Pd2FSnFSdfiBaSeKxhUyrvMsRGlIn4p9avLT9at1a4c
 BQDrlinm8OPbXj2neEyJ7Ek/pXTqnucN+7a5MbTc+kujyHBHsfqMY0SgVtWtq8Rx7LlaCjNcVXJ
 YtHzKqTNRXW0E2i2EsqjV4qZfmxArFxuC782CpY+xmJaLHn2015h9dCYPqnRvBLcIR8fwpN4oGq
 N+IhUPVl7iJpXLLb0MrDwgn0l+MsqHf2ovpTo7sHvoE5hZscXoG6940Vml8JUvLUxneCd3dWi3b
 bBnInH9Yw8XBe39NBSNUz99Rw+9VV1Q9sdHKiWhXBJKgkbnDL2zc7Bhr/pCHMVcnRs30KQc/ycv
 lW6mYfnDnl6AOhLQ==
X-Received: by 2002:a05:600c:8b0a:b0:4a1:742e:3 with SMTP id
 5b1f17b1804b1-4ac185bc4a1mr322317255e9.27.1793730141737; 
 Tue, 03 Nov 2026 10:22:21 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a9bd5d9fsm74908085e9.15.2026.11.03.10.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 10:22:21 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 18:22:15 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22
X-Gerrit-Change-Number: 1860
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1860?usp=email>
X-Gerrit-Commit: 22604de59ef894681fe6056bfcbc90c4c6a9fda7
In-Reply-To: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
References: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzQ1NDE2MDAwLkllMjAyODk3MzdkNTAyYTI1ZWVkYzYwNjc3ZDNjMzUwZGRjM2IzYzIyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <46172c3a683267b43edc8ff67b639e6d83e45ff0-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOJ9Q-000000002jo-1u38
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
Content-Type: multipart/mixed; boundary="===============2014057457414798497=="
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2014057457414798497==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EPWN6qSSV/c="; charset=UTF-8

--EPWN6qSSV/c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Name of user not set #1=
000061=2E

Arne Schwabe has uploaded a new patch set (#6)=2E ( https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail )


Change subject: Add pyt=
hon scripts that demonstrate using the dpc1 ACC protocol
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
2 files changed, 273 insertions(+), 0 deletions(-)


  git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/60/1860/6

diff -=
-git a/sample/management/acc_dpc1_client_demo=2Epy b/sample/management/acc_=
dpc1_client_demo=2Epy
new file mode 100755
index 0000000=2E=2E1ae074d
--- /=
dev/null
+++ b/sample/management/acc_dpc1_client_demo=2Epy
@@ -0,0 +1,114 @=
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
+logger=2EsetLevel(logging=2EINFO)
+
+
=
+class OmiDpc1ClientProtocol(OMIClientProtocol):
+    def __init__(self, fi=
nish_future: Future, connect_data: ConnectData):
+        super()=2E__init_=
_(finish_future, connect_data)
+
+    def receive_acc_dpc1(self, acc_messag=
e: str):
+        msg =3D json=2Eloads(acc_message)
+
+        logger=2Eerr=
or(f"Received dpc1 message: {acc_message}")
+
+        dpc_request =3D msg[=
"dpc_request"]
+        ver =3D dpc_request["ver"]
+        if ver !=3D "1=
=2E0":
+            logger=2Ewarning(f"Received unknown ACC protocol versio=
n: {ver}")
+            return
+
+        client_info =3D dpc_request=2Eget=
("client_info", False)
+        antivirus =3D "antivirus" in dpc_request
+ =
       disk_encryption =3D "disk_encryption" in dpc_request
+
+        logg=
er=2Einfo(
+            f"Received DPC1 request: antivirus=3D{antivirus}, d=
isk_encryption=3D{disk_encryption}, client_info=3D{client_info}")
+
+      =
  if client_info:
+            self=2E_send_dpc1_client_info()
+
+    def _=
send_dpc1_client_info(self):
+        system =3D platform=2Esystem()
+     =
   if system =3D=3D "Darwin":
+            system =3D "MacOS"
+
+        re=
sponse =3D {
+            "dpc_response": {
+                "ver": "1=2E0"=
,
+                "client_info": {
+                    "os": {
+         =
               "type": system,
+                        "version": platform=
=2Erelease(),
+                        "extra":
+                          =
  {
+                                "arch": platform=2Emachine(),
+       =
                     }
+                    }
+                }
+         =
   }
+        }
+
+        b64msg =3D base64=2Eb64encode(json=2Edumps(respo=
nse)=2Eencode())=2Edecode()
+
+        command =3D f"acc-msg\ndpc1\n6\n{b64=
msg}\nEND"
+        self=2Equeue_command(command)
+
+
+async def main(conne=
ct_data: ConnectData):
+    transport, protocol, finish_future =3D await st=
art_management_protocol(connect_data, OmiDpc1ClientProtocol)
+
+    managem=
ent_version =3D await protocol=2Emanagement_ready()
+    logger=2Edebug(f"M=
anagement interface version: {management_version}")
+
+    await protocol=
=2Eset_bytecount_interval(5)
+
+    try:
+        await finish_future
+    =
except CancelledError:
+        # Ignore errors like ones caused by Control=
+C in the demo script
+        pass
+
+
+if __name__ =3D=3D '__main__':
+  =
  run_main(main)
diff --git a/sample/management/acc_dpc1_server_demo=2Epy b=
/sample/management/acc_dpc1_server_demo=2Epy
new file mode 100644
index 000=
0000=2E=2Eec1cf4a
--- /dev/null
+++ b/sample/management/acc_dpc1_server_dem=
o=2Epy
@@ -0,0 +1,159 @@
+#!/usr/bin/env python3
+# Copyright (c) 2026 Open=
VPN Inc <sales@openvpn=2Enet>
+# Copyright (c) 2026 Arne Schwabe <arne@rfc2=
549=2Eorg>
+#
+# Permission is hereby granted, free of charge, to any perso=
n obtaining a copy
+# of this software and associated documentation files (=
the "Software"), to deal
+# in the Software without restriction, including =
without limitation the rights
+# to use, copy, modify, merge, publish, dist=
ribute, sublicense, and/or sell
+# copies of the Software, and to permit pe=
rsons to whom the Software is
+# furnished to do so, subject to the followi=
ng conditions:
+#
+# The above copyright notice and this permission notice =
shall be included in all
+# copies or substantial portions of the Software=
=2E
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, E=
XPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHA=
NTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO=
 EVENT SHALL THE
+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, D=
AMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTH=
ERWISE, ARISING FROM,
+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE U=
SE OR OTHER DEALINGS IN THE
+# SOFTWARE=2E
+
+#
+#  You should have receive=
d a copy of the GNU General Public License along
+#  with this program; if =
not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+
+# This implements a smal=
l demonstration of using the
+# OpenVPN Access Server Management Interface =
(OMI) and an app Custom Control
+# protocol (dpc1)=2E To use this use on th=
e server
+
+# --management-client-auth
+# --app-custom-control dpc1
+# --ma=
nagement /path/to/acc_dpc1_server_demo=2Epy unix-script
+
+# Note this is j=
ust a demonstration and not a production-ready solution=2E
+# When modifyin=
g this code, keep the security in mind=2E It is easy to
+# introduce a secu=
rity problem when writing scripts handling authentication
+
+import asyncio=

+import json
+import logging
+from asyncio import Future
+from dataclasses=
 import field, dataclass
+from pprint import pprint
+from typing import Dic=
t
+
+logging=2EbasicConfig()
+
+from omi_server_protocol import OMIServerPr=
otocol, ConnectedClient
+from omi_tools import start_management_protocol, C=
onnectData, run_main
+
+logger =3D logging=2EgetLogger(__name__)
+
+
+@data=
class
+class DpcConnectedClient(ConnectedClient):
+    # Remember the key-i=
d that we authenticated
+    dpc_completed: bool =3D False
+    env: Dict[s=
tr, str] =3D field(default_factory=3Ddict)
+
+
+class OmiDPCServerProtocol(=
OMIServerProtocol):
+    def __init__(self, finish_future: Future, connect_=
data: ConnectData):
+        super()=2E__init__(finish_future, connect_data=
)
+        self=2E_connected_client_class =3D DpcConnectedClient
+
+    def=
 receive_acc_client_dpc1(self, client: DpcConnectedClient, kid: int, acc_me=
ssage: str):
+        print(f"Received DPC1 message: {acc_message!r}")
+   =
     msg =3D json=2Eloads(acc_message)
+        pprint(msg)
+
+        dpc_=
response =3D msg["dpc_response"]
+        ver =3D dpc_response["ver"]
+    =
    if ver !=3D "1=2E0":
+            logger=2Eerror(f"Received unknown ACC=
 protocol version: {ver}")
+            return
+
+        client_info =3D d=
pc_response=2Eget("client_info", {})
+        antivirus =3D "antivirus" in =
dpc_response
+        disk_encryption =3D "disk_encryption" in dpc_response=

+
+        logger=2Einfo(
+            f"Received DPC1 response: antivirus=
=3D{antivirus}, disk_encryption=3D{disk_encryption}, client_info=3D{client_=
info}")
+
+        # Normally here would be a check that the response match=
es the policy
+        # this demo script just allows everyone with a respo=
nse to pass
+        client=2Edpc_completed =3D True
+
+        _ =3D self=
=2Equeue_command(f"client-auth-nt {client=2Ecid} {kid}")
+
+    async def d=
pc_request_timeout(self, client: DpcConnectedClient, kid: int, timeout: int=
):
+        await asyncio=2Esleep(timeout)
+        if client=2Edpc_complet=
ed:
+            return
+
+        client_deny =3D f'client-deny {client=2E=
cid} {kid} "dpc1 timeout" "Timeout on device posture"'
+        await self=
=2Equeue_command(client_deny)
+
+    def client_event_ESTABLISHED(self, cli=
ent: DpcConnectedClient, kid: int, env: dict, extra: str):
+        print(f=
"CLient connected: {client}")
+
+    async def send_client_deny_no_dpc1(sel=
f, client: DpcConnectedClient, kid: int):
+        client_reason =3D "ACC[p=
rotocol dpc1]: To connect to this server you " \
+                        "=
need to upgrade to a client that supports the " \
+                        =
"OpenVPN Inc device posture protocol and has it " \
+                      =
  "enabled, e=2Eg=2E OpenVPN for Android, openvpn3-linux, " \
+            =
            "or OpenVPN Connect"
+        client_deny =3D f'client-deny {cl=
ient=2Ecid} {kid} "no dpc1 support" "{client_reason}"'
+        await self=
=2Equeue_command(client_deny)
+
+    def client_event_CONNECT(self, client:=
 DpcConnectedClient, kid: int, env: dict, extra: str):
+        print(f"Aut=
henticating client {client}, {kid}, protos: {client=2Eacc_negotiated_protoc=
ols}")
+        client=2Eenv =3D env
+        asyncio=2Ecreate_task(self=2E=
check_client_posture(client, kid))
+
+    def client_event_REAUTH(self, cli=
ent: DpcConnectedClient, kid: int, env: dict, extra: str):
+        print(f=
"Re-authenticating client {client}, {kid}, protos: {client=2Eacc_negotiated=
_protocols}")
+        client=2Eenv =3D env
+        # Check client posture=
 again on renegotiation
+        asyncio=2Ecreate_task(self=2Echeck_client_=
posture(client, kid))
+
+    async def check_client_posture(self, client: D=
pcConnectedClient, kid: int):
+        await self=2Equeue_command(
+       =
     f"client-pending-auth {client=2Ecid} {kid} \"NOTIFY::Checking your dev=
ice posture, please wait\" 180")
+
+        await self=2Equeue_command(f"cl=
ient-pending-auth {client=2Ecid} {kid} ACC 180")
+        # In this example=
 we wait for 20 seconds to simulate a posture check on the server
+        =
await asyncio=2Esleep(20)
+
+        if "dpc1" not in client=2Eacc_negotiat=
ed_protocols:
+            await self=2Esend_client_deny_no_dpc1(client, ki=
d)
+            return
+
+        dpc_cmd =3D {"dpc_request": {"ver": "1=2E=
0", "correlation_id": "n/a", "timestamp": "yesterday", "client_info": True,=

+                                   "disk_encryption": {"full": True}, "an=
tivirus": {}}}
+
+        dpc_cmd_str =3D json=2Edumps(dpc_cmd)
+        ac=
c_protocol =3D "dpc1"
+
+        client=2Edpc_completed =3D False
+        =
await self=2Esend_acc_msg(client, kid, acc_protocol, dpc_cmd_str=2Eencode()=
)
+        asyncio=2Ecreate_task(self=2Edpc_request_timeout(client, kid, 60=
))
+
+
+async def main(connect_data: ConnectData):
+    transport, protocol=
, finish_future =3D await start_management_protocol(connect_data, OmiDPCSer=
verProtocol)
+
+    management_version =3D await protocol=2Emanagement_read=
y()
+    logger=2Edebug(f"Management interface version: {management_version=
}")
+
+    await protocol=2Eenable_log()
+
+    await protocol=2Eset_byteco=
unt_interval(5)
+
+    await finish_future
+
+
+if __name__ =3D=3D '__main_=
_':
+    run_main(main)

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1860?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22
Gerrit-Change-Number: 18=
60
Gerrit-PatchSet: 6
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-CC: Name of user not set #1000061
Gerrit-CC: Ralf Lici <ralf@mand=
elbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: Name of user not set #1000061
Gerrit-Attention: Arne=
 Schwabe <arne-openvpn@rfc2549=2Eorg>

--EPWN6qSSV/c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Name of user not set #1000061=2E </p>
<=
p>Arne Schwabe <strong>uploaded patch set #6</strong> to this change=2E</p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail">=
View Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Add python scripts that demonstrate using =
the dpc1 ACC protocol<br><br>The dpc1 protocol is used by the OpenVPN Conne=
ct clients and<br>OpenVPN Connexa=2E<br><br>Change-Id: Ie20289737d502a25eed=
c60677d3c350ddc3b3c22<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg=
&gt;<br>---<br>A sample/management/acc_dpc1_client_demo=2Epy<br>A sample/ma=
nagement/acc_dpc1_server_demo=2Epy<br>2 files changed, 273 insertions(+), 0=
 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/60/1860/6</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/sample/manage=
ment/acc_dpc1_client_demo=2Epy b/sample/management/acc_dpc1_client_demo=2Ep=
y</span><br><span>new file mode 100755</span><br><span>index 0000000=2E=2E1=
ae074d</span><br><span>--- /dev/null</span><br><span>+++ b/sample/managemen=
t/acc_dpc1_client_demo=2Epy</span><br><span>@@ -0,0 +1,114 @@</span><br><sp=
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
%);">+# This implements a small demonstration of using the</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+# OpenVPN Access Server Management I=
nterface (OMI) and an app Custom Control</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+# protocol (dpc1)=2E To use this use on the client use=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+# --management-client-auth</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# --app-custom-control dpc1</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+# --management /path/to=
/acc_dpc1_client_demo=2Epy unix-script</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
import base64</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import=
 json</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import logging=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import platform</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+from asyncio import Can=
celledError, Future</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+logging=2EbasicConf=
ig()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+from omi_tools import run_main, st=
art_management_protocol, ConnectData</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+from omi_client_protocol import OMIClientProtocol</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+logger =3D logging=2EgetLogger(__name__)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+logger=2EsetLevel(logging=
=2EINFO)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+class OmiDpc1ClientProtocol(OMIClientProtocol):</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def __init__(self=
, finish_future: Future, connect_data: ConnectData):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        super()=2E__init__(finish_future,=
 connect_data)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    def receive_acc_dpc1=
(self, acc_message: str):</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        msg =3D json=2Eloads(acc_message)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        logger=2Eerror(f&quot;Received dpc1 message: {acc_message}=
&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        dpc_request =3D msg[&qu=
ot;dpc_request&quot;]</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        ver =3D dpc_request[&quot;ver&quot;]</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if ver !=3D &quot;1=2E0&quot;:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            logger=2Ewarning(=
f&quot;Received unknown ACC protocol version: {ver}&quot;)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            return</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        client_info =3D dpc_request=2Eget(&quot;client_i=
nfo&quot;, False)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      antivirus =3D &quot;antivirus&quot; in dpc_request</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        disk_encryption =3D &quot;disk=
_encryption&quot; in dpc_request</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  logger=2Einfo(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         f&quot;Received DPC1 request: antivirus=3D{antivirus}, disk_encryp=
tion=3D{disk_encryption}, client_info=3D{client_info}&quot;)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if client_info:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            self=2E_send_dpc1_client_info()</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    def _send_dpc1_client_info(self):</span>=
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
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+async def main(connect_data: ConnectData):</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    transport, protocol, fini=
sh_future =3D await start_management_protocol(connect_data, OmiDpc1ClientPr=
otocol)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    management_version =3D awai=
t protocol=2Emanagement_ready()</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    logger=2Edebug(f&quot;Management interface version: {manage=
ment_version}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    await protocol=
=2Eset_bytecount_interval(5)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    try:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        await finish_=
future</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    except Ca=
ncelledError:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  # Ignore errors like ones caused by Control+C in the demo script</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        pass</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+if __name__ =3D=3D &#39;__main__&#39;:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    run_main(main)</span><br><span>diff --git a/sample=
/management/acc_dpc1_server_demo=2Epy b/sample/management/acc_dpc1_server_d=
emo=2Epy</span><br><span>new file mode 100644</span><br><span>index 0000000=
=2E=2Eec1cf4a</span><br><span>--- /dev/null</span><br><span>+++ b/sample/ma=
nagement/acc_dpc1_server_demo=2Epy</span><br><span>@@ -0,0 +1,159 @@</span>=
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
 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  =
You should have received a copy of the GNU General Public License along</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#  with this program; i=
f not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# This implements a small demonstration of using the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+# OpenVPN Access Server M=
anagement Interface (OMI) and an app Custom Control</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# protocol (dpc1)=2E To use this use on t=
he server</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# --management-client-auth</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+# --app-custom-control=
 dpc1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# --management=
 /path/to/acc_dpc1_server_demo=2Epy unix-script</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+# Note this is just a demonstration and not a production-ready sol=
ution=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# When modi=
fying this code, keep the security in mind=2E It is easy to</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+# introduce a security problem when=
 writing scripts handling authentication</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+import asyncio</span><br><span style=3D"color: hsl(120, 100%, 40%);">+imp=
ort json</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import logg=
ing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from asyncio imp=
ort Future</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from data=
classes import field, dataclass</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+from pprint import pprint</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+from typing import Dict</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+logging=2EbasicConfig()</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from omi_ser=
ver_protocol import OMIServerProtocol, ConnectedClient</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+from omi_tools import start_management_p=
rotocol, ConnectData, run_main</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+logger =
=3D logging=2EgetLogger(__name__)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+@dataclass</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+class DpcConnectedClient(Connecte=
dClient):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # Reme=
mber the key-id that we authenticated</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    dpc_completed: bool =3D False</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    env: Dict[str, str] =3D field(default=
_factory=3Ddict)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+class OmiDPCServerProtocol(OMIServerProto=
col):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def __init=
__(self, finish_future: Future, connect_data: ConnectData):</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        super()=2E__init__(finish_f=
uture, connect_data)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        self=2E_connected_client_class =3D DpcConnectedClient</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    def receive_acc_client_dpc1(self, client: DpcCo=
nnectedClient, kid: int, acc_message: str):</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        print(f&quot;Received DPC1 message: {acc_me=
ssage!r}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg =3D json=2Eloads(acc_message)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        pprint(msg)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       dpc_response =3D msg[&quot;dpc_response&quot;]</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        ver =3D dpc_response[&quot;ver&qu=
ot;]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if ver =
!=3D &quot;1=2E0&quot;:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            logger=2Eerror(f&quot;Received unknown ACC protocol version=
: {ver}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        client_info =3D d=
pc_response=2Eget(&quot;client_info&quot;, {})</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        antivirus =3D &quot;antivirus&quot; in d=
pc_response</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
disk_encryption =3D &quot;disk_encryption&quot; in dpc_response</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        logger=2Einfo(</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            f&quot;Received DPC1 response: anti=
virus=3D{antivirus}, disk_encryption=3D{disk_encryption}, client_info=3D{cl=
ient_info}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # Normally he=
re would be a check that the response matches the policy</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        # this demo script just allows=
 everyone with a response to pass</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        client=2Edpc_completed =3D True</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        _ =3D self=2Equeue_command(f&quot;client-auth-nt {cl=
ient=2Ecid} {kid}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    async def =
dpc_request_timeout(self, client: DpcConnectedClient, kid: int, timeout: in=
t):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        await as=
yncio=2Esleep(timeout)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if client=2Edpc_completed:</span><br><span style=3D"color: hsl(1=
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
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        asyncio=2Ecr=
eate_task(self=2Echeck_client_posture(client, kid))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    def client_event_REAUTH(self, client: DpcConnectedClient=
, kid: int, env: dict, extra: str):</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        print(f&quot;Re-authenticating client {client}, {ki=
d}, protos: {client=2Eacc_negotiated_protocols}&quot;)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        client=2Eenv =3D env</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        # Check client posture =
again on renegotiation</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        asyncio=2Ecreate_task(self=2Echeck_client_posture(client, kid))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    async def check_client_posture(self=
, client: DpcConnectedClient, kid: int):</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        await self=2Equeue_command(</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            f&quot;client-pending-auth=
 {client=2Ecid} {kid} \&quot;NOTIFY::Checking your device posture, please w=
ait\&quot; 180&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        await sel=
f=2Equeue_command(f&quot;client-pending-auth {client=2Ecid} {kid} ACC 180&q=
uot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # In t=
his example we wait for 20 seconds to simulate a posture check on the serve=
r</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        await asyn=
cio=2Esleep(20)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if &quot;dpc1&q=
uot; not in client=2Eacc_negotiated_protocols:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            await self=2Esend_client_deny_no_dpc=
1(client, kid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        dpc_cmd =3D {&quo=
t;dpc_request&quot;: {&quot;ver&quot;: &quot;1=2E0&quot;, &quot;correlation=
_id&quot;: &quot;n/a&quot;, &quot;timestamp&quot;: &quot;yesterday&quot;, &=
quot;client_info&quot;: True,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                   &quot;disk_encryption&quot;: {=
&quot;full&quot;: True}, &quot;antivirus&quot;: {}}}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        dpc_cmd_str =3D json=2Edumps(dpc_cmd)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        acc_protocol =3D &quot;dpc=
1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        client=2Edpc_completed =
=3D False</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        aw=
ait self=2Esend_acc_msg(client, kid, acc_protocol, dpc_cmd_str=2Eencode())<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        asyncio=2Ecr=
eate_task(self=2Edpc_request_timeout(client, kid, 60))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+asy=
nc def main(connect_data: ConnectData):</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    transport, protocol, finish_future =3D await start_=
management_protocol(connect_data, OmiDPCServerProtocol)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    management_version =3D await protocol=2Emanagement_rea=
dy()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    logger=2Ede=
bug(f&quot;Management interface version: {management_version}&quot;)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    await protocol=2Eenable_log()</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    await protocol=2Eset_bytecount_interval(5)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    await finish_future</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
if __name__ =3D=3D &#39;__main__&#39;:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    run_main(main)</span><br></pre><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail">change=
 1860</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1860 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: Name of user not set #1000061 </div>
<div style=3D"display:none=
"> Gerrit-CC: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Name of u=
ser not set #1000061 </div>
<div style=3D"display:none"> Gerrit-Attention: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--EPWN6qSSV/c=--


--===============2014057457414798497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2014057457414798497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2014057457414798497==--

