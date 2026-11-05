Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F46D606A326
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jq/JSm60;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hQYQJPsh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TkVpdqb5;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=eifGCwL8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3iOUBtOomBA7wkZDBoSuLaiA04s5QHW4olZT1jH3uYk=; b=jq/JSm60RH4TIgz9MK5wfp8ZAP
	Zb1ugpSJ6VFCkRPBxg7WmPHQOWZQKZkViX1yu3tL0iV/R/HekZzGE8g9M497JNS3Gzhy6a9zlK1F5
	OX4dFJmaPdGeBTF07R3lN3Sn4Eh1g6Q5mVTuLkFZbxCG70gVZrDPMqk6zVLvRZYLv3EU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOyQl-000000001yU-19QY;
	Thu, 05 Nov 2026 14:27:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOyQj-000000001yN-0tNz
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 14:27:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=71ElScoEFdzCeBWLEv0qwaG78Yu3ExXqBfA0Hx/rZNM=; b=hQYQJPshzyjNo+ODJpg2d5GgRv
 BAtDzkz9UpidcwW/7FuqV7/sk/jtj8ISQKOwz1kzW/PYdBVob/rlh9+u786E3fbu/SNz7ENXWsrxR
 gnVLO7Zww+JwQOP5j2xxRsyda8P5XBXksFCpjpdaM5ongriGycYyJgIrroCPXjPq9kGs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=71ElScoEFdzCeBWLEv0qwaG78Yu3ExXqBfA0Hx/rZNM=; b=TkVpdqb58Vx1fclG61ODyAXxAm
 jl//0EOXgOmKmNIvQdCPatp1iHBmgfxPa8tq8t3LJzS8hT1UQldrGCuu7LwHnVLA/VHtieoC5wGKL
 J0Uk+ScS7CTiyVLzRKPeWMtOcL9zSFuhl2FrZzmPsDM8uN/bhdgKrUr67YNTANQHL5k4=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOyQd-000000003Dn-0qcj for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 14:27:05 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a35db1f202so15399415e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 06:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793888813; x=1794493613; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=71ElScoEFdzCeBWLEv0qwaG78Yu3ExXqBfA0Hx/rZNM=;
 b=eifGCwL8aGlcBeP8VXXLSgNNsQ9R+MGhTprr35UQ+9lPVi0tSqNMRTcV1/mae3YMfJ
 KNYlL7DLfK4YKl+ZABSGUnvl3w+7SnMRmKHdURnAyT+JsMjDqDy13z4BLcI48sH0i5YH
 jrj4C8Di9qR6iQZSCgh61ozdDoGm4y0AC6X1r+fGXl/CnJAgjsLI0GQH5y+OUj0o+7Tc
 2NgA1LmEZGgHYH6vI6Q+ogiWQtGUjxTe9p+Cr8oP9Us2QfrPfTBCOoyxzc2l82mDuX+a
 RWtc8XhP8w8zdHeIWK+c4hQavkSbYi63iDMydykQ3Rrce3W0awe687dNWBzsIOztt6gl
 OB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793888813; x=1794493613;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=71ElScoEFdzCeBWLEv0qwaG78Yu3ExXqBfA0Hx/rZNM=;
 b=eqTzVj5ekiHSAvzAkqqFk5Txi6RnwberISPqzRVyNcjEQaxYYk6Ux3g524hMl2NaiP
 Ga2DyoNJrOhdc/DR94A44obZYFTj3D/kR2c/uDzsJfG+4pByRPVTWzazJ45V4flSIBhP
 WIhvrfCqrJeI2a6G79fphNJOukLskPiuvoVNzr/FOuescbH4kNwPW7qLQcFgl9DGQhcU
 /2gauMfYY3UhN/ngFPUqKydmzzB+bY2pkaYTRBkLENyEHW2EDhWiWLgSvCxPBibvvRhx
 /5a5dPuLDbB4E+Iu8JJkGdrRn+w3qYVLgjevyE7tDfcs52Fo0PFn6bcQ39tl78eTtaTD
 xT4A==
X-Gm-Message-State: APuU4Z8yb52mVm2kxWiHd+1/cnOrxSmNHT73hjZT/b6R7hTrOdKKDbZX
 Qmrg+ecgipoZS9EArivAlMjWdACcPyYRSijqcU69N+WbqaiDlFUvGES5stvrovAWsAMOSiGa65d
 +TU//T4YX8lOHfOEpckprulg4BVFWI/AnK0DMEarBFhX9mhYes1mWzYam1E7Iqa+Ba/b96Zgqoc
 Y5Gq+jzA==
X-Gm-Gg: AYBFou3THdNnjNLbfPZZMRYNG7cYO1hhfadQ9H76le0w47TRm612yUNBOBLSiT3KEu/
 eX0z7vdy3KDQu+C7hdwLxhwIRTQsX0I6QR2NNuOMLvUudUj1d5Kom1zJ2BJx53JNbiSx81i9w+F
 VyabVUs4cJFJGdVWAGyLTvLGeLCKa+OGsvL94xgs6lsHNqHWt3Y87T4GU1MBynNwRIyU4XE3s1/
 kYmM9ygOIf7rOlBCS1nyiE0QkQXCkmfms6VYvmSH3ui8OhTaJ2e7ONosxXJ5CAVyq0AZcdjpMG/
 GxuHnTcaJOQrZjJprNZHloJx5JduE5/TsjT0Kuuw5rU/95gt90Uhju8Pr4ea4Rw+C9Y05tXqAfH
 kfcENDlaFs58enSWTWuGmX1iybrmUI8wNYOomvEVV/aNwMo3sGSxCDzrIktUn4+CFeyywQldiiO
 huudw5Fg1mLsmHRRSBrTlcmfXiBwgy4auhbMAyM7CrP/hm/rTne1ULMlmr79k9x5aujtwpPf5sq
 Nbqwqlq34VzlBVzWN0mrK9t8dUZfFz6+R7R4cvARtGEwqDXjUE58oE2GH/JIVu5bGKuOBsfG2Lm
 KBL4gUvo9DeQfdE0Mst2rxUsD7CqPkWQY56IzPxJZShaOV8mz1n1TJmJAF1FBSqxtisdA2d+6Pt
 AWA87Jgc226X8zUda2fVkl87qd+kVk/hSn5bN3n3zOQEPfePTPknpg857m8K9bIaYHlohIYaeM/
 NTXiib+/5zc8vfrA==
X-Received: by 2002:a05:600c:6384:b0:4a1:702f:c736 with SMTP id
 5b1f17b1804b1-4ac150b20famr429765805e9.3.1793888811724; 
 Thu, 05 Nov 2026 06:26:51 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56ea594cfsm61621695e9.5.2026.11.05.06.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 06:26:51 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 14:26:49 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5
X-Gerrit-Change-Number: 1859
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1859?usp=email>
X-Gerrit-Commit: 8a2342dce3fb0e8d4202e043a13af7f41d5367f5
In-Reply-To: <gerrit.1787327336000.Ib09bafabf612e9501ea757647c86a450c73228a5@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ib09bafabf612e9501ea757647c86a450c73228a5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkliMDliYWZhYmY2MTJlOTUwMWVhNzU3NjQ3Yzg2YTQ1MGM3MzIyOGE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8b87e2dcbd313b9981420c54f63c70fea682a216-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOyQd-000000003Dn-0qcj
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Add python scripts
 that demonstrate using the mangement interface
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
Content-Type: multipart/mixed; boundary="===============7664305293515466163=="
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_HTML_MOSTLY,MISSING_HEADERS,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7664305293515466163==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KcpI/gdQG3k="; charset=UTF-8

--KcpI/gdQG3k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Name of user not set #1000061=2E

Arn=
e Schwabe has uploaded a new patch set (#10)=2E ( https://gerrit=2Eopenvpn=
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
M sample/Makefile=
=2Eam
A sample/management/omi=2Epy
A sample/management/omi_client_protocol=
=2Epy
A sample/management/omi_server_demo=2Epy
A sample/management/omi_serv=
er_protocol=2Epy
A sample/management/omi_tools=2Epy
6 files changed, 1,133 =
insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/59/1859/10

diff --git a/sample/Makefile=2Eam b/sam=
ple/Makefile=2Eam
index f3528ba=2E=2E28574d9 100644
--- a/sample/Makefile=
=2Eam
+++ b/sample/Makefile=2Eam
@@ -16,6 +16,7 @@
        $(builddir)/samp=
le-plugins/Makefile
 
 EXTRA_DIST =3D \
+	management \
 	sample-plugins \
 =
	sample-config-files \
 	sample-keys \
diff --git a/sample/management/omi=
=2Epy b/sample/management/omi=2Epy
new file mode 100644
index 0000000=2E=2E=
75eeece
--- /dev/null
+++ b/sample/management/omi=2Epy
@@ -0,0 +1,364 @@
+#=
 Copyright (c) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+# Copyright (c) 2026=
 Arne Schwabe <arne@rfc2549=2Eorg>
+#
+# Permission is hereby granted, free=
 of charge, to any person obtaining a copy
+# of this software and associat=
ed documentation files (the "Software"), to deal
+# in the Software without=
 restriction, including without limitation the rights
+# to use, copy, modi=
fy, merge, publish, distribute, sublicense, and/or sell
+# copies of the So=
ftware, and to permit persons to whom the Software is
+# furnished to do so=
, subject to the following conditions:
+#
+# The above copyright notice and=
 this permission notice shall be included in all
+# copies or substantial p=
ortions of the Software=2E
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT =
WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO T=
HE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND N=
ONINFRINGEMENT=2E IN NO EVENT SHALL THE
+# AUTHORS OR COPYRIGHT HOLDERS BE =
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION O=
F CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+# OUT OF OR IN CONNECTION WIT=
H THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+# SOFTWARE=2E
+
+# This=
 is an example implementation in python and asyncio to drive OpenVPN's
+# m=
anagement interface (OMI)=2E The permissive license allows you to use this
=
+# code in other projects=2E
+
+"""
+Implementation of the OpenVPN manageme=
nt interface (OMI) protocol=2E
+
+This implements the generic part of the O=
MI protocol that is common
+to both client and server=2E
+"""
+import async=
io
+import inspect
+import logging
+import re
+from asyncio import Future, =
Event, Task, Queue
+from dataclasses import dataclass
+from datetime import=
 datetime
+from functools import partial
+from typing import override, List=
, Optional, Awaitable, Coroutine
+
+OMI_PASSWORD_PROMPT =3D b"ENTER PASSWOR=
D:"
+
+logger =3D logging=2EgetLogger(__name__)
+
+@dataclass
+class OmiCom=
mandResult:
+    command: str
+    result: List[str]
+    error: bool
+    =
status_text: str
+
+
+@dataclass
+class OmiSendCommand:
+    command: str
+=
    result: Future[OmiCommandResult]
+
+
+@dataclass
+class ConnectionPrope=
rties:
+    """
+    Properties for connecting to the management interface=
=2E
+    """
+    password: Optional[str]
+
+
+class OmiProtocol(asyncio=2E=
Protocol):
+    def __init__(self, finish_future: Future, connect_data: Con=
nectionProperties):
+        super()=2E__init__()
+        self=2E_connect_=
data: ConnectionProperties =3D connect_data
+
+        self=2Ebytes_receive=
d: int =3D 0
+        self=2Ebytes_sent: int =3D 0
+        self=2Eversion:=
 int =3D -1
+        self=2Erecv_buffer: bytes =3D b""
+        self=2Efini=
sh_future: Future =3D finish_future
+        self=2Etransport: Optional[asy=
ncio=2ETransport] =3D None
+
+        # Event to allow waiting for status o=
f the underlying socket
+        # to become available for writing
+       =
 self=2E_can_send: Event =3D asyncio=2EEvent()
+        self=2E_can_send=2E=
clear()
+
+        # Event to track when the management interface is ready =
to receive
+        # commands from us
+        self=2E_management_ready: E=
vent =3D asyncio=2EEvent()
+        self=2E_management_ready=2Eclear()
+   =
     self=2E_response =3D []
+
+        self=2E_response_ready: Event =3D a=
syncio=2EEvent()
+        self=2E_response_ready=2Eclear()
+
+        self=
=2E_send_queue: Queue =3D asyncio=2EQueue()
+        self=2E_send_task: Tas=
k =3D asyncio=2Ecreate_task(self=2E_send_loop())
+
+        self=2Erunning_=
tasks =3D set()
+
+
+    @override
+    def eof_received(self) -> None:
+  =
      logger=2Einfo('EOF received=2E Shutting down=2E')
+        self=2E_st=
op()
+
+    @override
+    def connection_lost(self, exc: Exception | None)=
 -> None:
+        if exc:
+            logger=2Ewarning(f'Connection lost =
({exc})=2E Shutting down=2E')
+        else:
+            logger=2Ewarning(=
f'Connection lost=2E Shutting down=2E')
+        self=2E_stop()
+
+    def =
_stop(self) -> None:
+        if not self=2Efinish_future=2Edone():
+      =
      # If we are disconnected or stop, there is no sense trying
+         =
   # to still send commands to the management interface
+            self=
=2E_send_task=2Ecancel()
+            self=2Efinish_future=2Eset_result(Tru=
e)
+
+    async def _send_loop(self) -> None:
+        while True:
+       =
     command: OmiSendCommand =3D await self=2E_send_queue=2Eget()
+        =
    await self=2E_can_send=2Ewait()
+            self=2Esend_line(command=
=2Ecommand)
+
+            response: List[str] =3D []
+            response=
_complete =3D False
+
+            # This is a bit brittle as it will loop =
forever if not getting a
+            # line that starts with ERROR or SUCC=
ESS=2E With a normal OpenVPN
+            # daemon that speak the correct p=
rotocol this should not be a
+            # problem
+            while not =
response_complete:
+                await self=2E_response_ready=2Ewait()
+=

+                line =3D self=2E_response=2Epop(0)
+                respo=
nse=2Eappend(line)
+
+                if not self=2E_response:
+           =
         self=2E_response_ready=2Eclear()
+
+                lastline =3D r=
esponse[-1]
+                if lastline=2Estartswith('ERROR: '):
+        =
            error =3D True
+                    response_complete =3D True
=
+                    _, status_text =3D lastline=2Esplit(": ", 1)
+
+      =
          elif lastline=2Estartswith('SUCCESS: '):
+                    err=
or =3D False
+                    response_complete =3D True
+             =
       _, status_text =3D lastline=2Esplit(": ", 1)
+                elif l=
astline =3D=3D "END":
+                    error =3D False
+               =
     response_complete =3D True
+                    status_text =3D None
+=
                else:
+                    # Other lines do not complete a =
response
+                    pass
+
+            # logger=2Edebug(f'Result=
 received command: {response}')
+            result =3D OmiCommandResult(co=
mmand=2Ecommand, response[:-1], error, status_text)
+
+            if not c=
ommand=2Eresult=2Ecancelled():
+                command=2Eresult=2Eset_resu=
lt(result)
+
+            logger=2Edebug(f"Command done=2E")
+
+    @overri=
de
+    def pause_writing(self) -> None:
+        self=2E_can_send=2Eclear(=
)
+
+    @override
+    def resume_writing(self) -> None:
+        self=2E_=
can_send=2Eset()
+
+    @override
+    def connection_made(self, transport)=
 -> None:
+        peername =3D transport=2Eget_extra_info('peername')
+   =
     logger=2Einfo('Connection from {}'=2Eformat(peername))
+        self=
=2Etransport =3D transport
+        self=2E_can_send=2Eset()
+
+    def _ch=
eck_pw_response(self, fut: Future[OmiCommandResult]) -> None:
+        if f=
ut=2Eexception():
+            logger=2Eerror(f"Error authenticating with p=
assword: {fut=2Eexception()}")
+            self=2Etransport=2Eclose()
+   =
         return
+
+        result =3D fut=2Eresult()
+
+        if result=
=2Eerror or result=2Estatus_text !=3D "password is correct":
+            l=
ogger=2Eerror(f"Received unexpected status after trying to authenticate: {r=
esult=2Estatus_text!r}")
+            self=2Etransport=2Eclose()
+         =
   return
+
+    def handle_password_prompt(self) -> None:
+        # OMI e=
xpects us to authenticate with the password just on
+        # its own on a=
 line
+        if self=2E_connect_data=2Epassword:
+            fut =3D sel=
f=2Equeue_command(f"{self=2E_connect_data=2Epassword}")
+            fut=2E=
add_done_callback(self=2E_check_pw_response)
+        else:
+            lo=
gger=2Eerror("No password provided for authentication")
+            self=
=2Etransport=2Eclose()
+
+    @override
+    def data_received(self, data: =
bytes) -> None:
+        # OMI protocol is pure text so decode everything a=
s UTF-8
+        message =3D data
+        self=2Erecv_buffer +=3D message
=
+
+        # Management protocol does not add a newline after the password =
prompt
+        if not self=2E_management_ready=2Eis_set() and self=2Erecv_=
buffer=2Estartswith(OMI_PASSWORD_PROMPT):
+            logger=2Edebug(f"Rec=
eived password prompt")
+            self=2Erecv_buffer =3D self=2Erecv_buf=
fer[len(OMI_PASSWORD_PROMPT) + 1:]
+            self=2Ehandle_password_prom=
pt()
+            return
+
+        parts =3D self=2Erecv_buffer=2Esplit(b"=
\r\n")
+
+        # pass complete lines to recvLine
+        for part in pa=
rts[:-1]:
+            part =3D part=2Edecode()
+            logger=2Edebug=
(f'Line received: {part!r}')
+            self=2Erecv_line(part)
+
+       =
 # keep the last incomplete line for the next call
+        self=2Erecv_buf=
fer =3D parts[-1]
+
+    def recv_line(self, line: str) -> None:
+        i=
f line=2Estartswith(">"):
+            # this is an asynchronous message
+ =
           self=2Erecv_notify(line)
+        else:
+            # normal me=
ssage get passed to the _send_loop task
+            self=2E_response=2Eapp=
end(line)
+            self=2E_response_ready=2Eset()
+
+    def recv_notif=
y(self, line: str) -> None:
+        if not ":" in line:
+            logge=
r=2Ewarning("Invalid line received: " + line)
+            return
+
+      =
  command, args =3D line[1:]=2Esplit(":", 1)
+
+        # do dynamic dispat=
ch based on command to call a handler
+        if not self=2Edispatch_to_ha=
ndler(f"recv_notify_{command}", args):
+            logger=2Einfo("Unknown =
notify line received: " + line)
+
+
+
+
+
+    def dispatch_to_handler(self=
, handlername:str, *args, **kwargs):
+        """
+        Looks up if this=
 class or a subclass has a handler for the given
+        command and eithe=
r directly calls it or schedules it as a coroutine=2E
+        :return: tru=
e if a handler was found and called
+        """
+        if hasattr(self, =
handlername):
+            handler =3D getattr(self, handlername)
+        =
    if inspect=2Eiscoroutinefunction(handler):
+                logger=2Ede=
bug(f"Calling async handler {handler}")
+                task =3D self=2Ead=
d_background_task(handler(*args, **kwargs), handlername)
+            else:=

+                try:
+                    logger=2Edebug(f"Calling handle=
r {handler}")
+                    handler(*args, **kwargs)
+              =
  except Exception as e:
+                    logger=2Eerror(f"Error execut=
ing handler {handlername}: {e}", exc_info=3DTrue)
+
+            return Tru=
e
+        else:
+            return False
+
+    def _background_task_done=
(self, handler_name:str, task: Task):
+        self=2Erunning_tasks=2Eremov=
e(task)
+        if task=2Eexception():
+            logger=2Eerror(f"Error=
 executing background task {handler_name}: {task=2Eexception()}")
+
+    de=
f add_background_task(self, func:Coroutine, name:Optional[str]=3DNone) -> T=
ask:
+        """
+        Schedules an async task to run in the background=
 and keep a
+        reference to the task so it will not be garbage collec=
ted=2E
+        """
+        task =3D asyncio=2Ecreate_task(func)
+        =
self=2Erunning_tasks=2Eadd(task)
+
+        if not name:
+            name =
=3D repr(func)
+
+        task=2Eadd_done_callback(partial(self=2E_backgrou=
nd_task_done, name))
+        return task
+
+
+    def recv_notify_INFO(sel=
f, args: str) -> None:
+        m =3D re=2Ematch(r"OpenVPN Management Inter=
face Version (?P<version>\d+)", args)
+        if m:
+            self=2Eve=
rsion =3D int(m=2Egroup("version"))
+            self=2Equeue_command("vers=
ion 6")
+            self=2E_management_ready=2Eset()
+        else:
+     =
       logger=2Ewarning(f"Unknown INFO line received: {args}")
+
+    def r=
ecv_notify_BYTECOUNT(self, args: str) -> None:
+        bytes_received, byt=
es_sent =3D args=2Esplit(",", 1)
+        self=2Ebytes_sent =3D int(bytes_s=
ent)
+        self=2Ebytes_received =3D int(bytes_received)
+
+    async de=
f _release_hold_task(self, hold_time: int =3D 0) -> None:
+        await as=
yncio=2Esleep(hold_time)
+        await self=2Equeue_command("hold release"=
)
+
+    def recv_notify_HOLD(self, args):
+        _text, hold_time =3D ar=
gs=2Esplit(":", 1)
+        hold_time =3D int(hold_time)
+
+        self=2E=
add_background_task(self=2E_release_hold_task(hold_time))
+
+    def queue_=
command(self, command: str) -> Future[OmiCommandResult]:
+        cmd =3D O=
miSendCommand(command, Future())
+        self=2E_send_queue=2Eput_nowait(c=
md)
+        return cmd=2Eresult
+
+    async def management_ready(self) ->=
 int:
+        """
+        Waits until the management interface is ready=
=2E Returns the management interface version=2E
+        """
+        await=
 self=2E_management_ready=2Ewait()
+        return self=2Eversion
+
+    de=
f send_line(self, line: str) -> None:
+        logger=2Edebug(f"Sending lin=
e: {line}")
+        self=2Etransport=2Ewrite(f"{line}\n"=2Eencode())
+
+  =
  """
+    Set the bytecount interval=2E Use 0 to disable
+    """
+
+    a=
sync def set_bytecount_interval(self, interval: int):
+        return await=
 self=2Equeue_command(f"bytecount {interval}")
+
+    async def enable_log(=
self):
+        return await self=2Equeue_command("log on")
+
+    def recv=
_notify_LOG(self, args):
+        # >LOG:1786453401,D,MANAGEMENT: CMD 'byte=
count 30'
+        timestamp, level, message =3D args=2Esplit(",", 2)
+
+  =
      timestamp =3D datetime=2Efromtimestamp(int(timestamp))
+        level=
 =3D level=2Estrip()
+        message =3D message=2Estrip()
+        self=
=2Elog_message(timestamp, level, message)
+
+    def log_message(self, time=
:datetime, level:str, message:str):
+        """
+        A new log message=
 has been received=2E This method is intended
+        to be overridden by =
a subclass to handle the log messages=2E
+        :param time:    time in l=
ocal time format
+        :param level:   level of the log message
+       =
 :param message: the log message itself
+        :return:
+        """
+   =
     logger=2Edebug(f"Received log message: {time}, {level}, {message}")
di=
ff --git a/sample/management/omi_client_protocol=2Epy b/sample/management/o=
mi_client_protocol=2Epy
new file mode 100644
index 0000000=2E=2E0d7d15e
---=
 /dev/null
+++ b/sample/management/omi_client_protocol=2Epy
@@ -0,0 +1,132 =
@@
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
+import asyncio
+import base64
+import logging
+from as=
yncio import Future
+from typing import Tuple
+
+from omi import OmiProtoco=
l, OmiCommandResult
+from sample=2Emanagement=2Eomi import ConnectionProper=
ties
+
+logger =3D logging=2EgetLogger(__name__)
+
+
+class OMIClientProtoc=
ol(OmiProtocol):
+    """
+    Implement the management protocol for the cl=
ient  
+    """
+
+    def __init__(self, finish_future: Future, connect_da=
ta: ConnectionProperties):
+        super()=2E__init__(finish_future=3Dfini=
sh_future, connect_data=3Dconnect_data)
+        self=2E_partial_acc_msg =
=3D b""
+        self=2E_protocol_acc_msg =3D ""
+        self=2E_acc_fragm=
ent_length =3D 980
+        self=2E_acc_negotiated_protocols =3D []
+
+    =
async def send_acc_msg(self, protocol: str, msg: bytes):
+        """
+    =
    Sends out an ACC to the server using the specified ACC message length
+=
        :param protocol:
+        :param msg:
+        :param fragment_leng=
th:
+        :return:
+        """
+        if protocol not in self=2E_acc_=
negotiated_protocols:
+            logger=2Eerror(f"Error: trying to send A=
CC message with protocol "
+                         f"{protocol} is not in=
 the negotiated list of "
+                         f"protocols ({self=2E_a=
cc_negotiated_protocols})")
+            return
+
+        # See init=2Ec f=
or the explanation for the length calculation
+        max_header_size =3D =
len("ACC,") + len(protocol) + 1 + 4 + 1 + 2 + 1
+
+        # calculate frag=
ment size with base64 encoding
+        fragment_length =3D self=2E_acc_fra=
gment_length * 6 // 8 - max_header_size
+
+        commands =3D []
+       =
 for part_start in range(0, len(msg), fragment_length):
+
+            msg_=
part =3D msg[part_start:part_start + fragment_length]
+            # This c=
reates a multiline base64 message but that is what
+            # we want f=
or the management interface to have a not overlong
+            # lines
+  =
          b64msg =3D base64=2Eencodebytes(msg_part)=2Edecode()
+
+         =
   flags =3D "6"
+            if part_start + fragment_length < len(msg):
+=
                flags +=3D "F"
+
+            commands=2Eappend(f"acc-msg\n=
{protocol}\n{flags}\n{b64msg}\nEND")
+
+        cmd_futures =3D []
+       =
 for command in commands:
+            cmd_futures=2Eappend(self=2Equeue_co=
mmand(command))
+
+        cmd_results: Tuple[OmiCommandResult] =3D await a=
syncio=2Egather(*cmd_futures)
+
+        for cmd_result in cmd_results:
+  =
          if cmd_result=2Eerror:
+                logger=2Eerror(f"Error: s=
ending ACC message failed: {cmd_result}")
+
+    def recv_notify_ACC_PROTOC=
OLS(self, args: str):
+        params =3D args=2Esplit(",")
+        acc_pa=
rams =3D {}
+
+        for p in params:
+            k, v =3D p=2Esplit("=
=3D", 1)
+            acc_params[k=2Estrip()] =3D v=2Estrip()
+
+        se=
lf=2E_acc_negotiated_protocols =3D acc_params['protocols']=2Esplit(":")
+
+=
        self=2E_acc_fragment_length =3D int(acc_params['message_len'])
+
+ =
   def recv_notify_ACC(self, args: str):
+        protocol, fragment, b64ms=
g =3D args=2Esplit(",", 2)
+
+        if self=2E_partial_acc_msg and self=
=2E_protocol_acc_msg !=3D protocol:
+            logger=2Eerror(f"Received =
ACC message with protocol {protocol} before "
+                         f"p=
revious ACC message with protocol {self=2E_protocol_acc_msg} was complete")=

+            self=2E_partial_acc_msg =3D b""
+
+        try:
+            =
msg =3D base64=2Edecodebytes(b64msg=2Eencode())
+            self=2E_partia=
l_acc_msg +=3D msg
+            self=2E_protocol_acc_msg =3D protocol
+    =
    except Exception as e:
+            logger=2Eerror(f"Error parsing ACC =
message: {e}", exc_info=3DTrue)
+            self=2E_partial_acc_msg =3D b"=
"
+            return
+
+        fragmented =3D fragment !=3D "0"
+        =
logger=2Edebug(
+            f"Received ACC message (fragment {fragmented},=
 protocol {protocol!r}), with payload {msg=2Edecode()!r}")
+
+        # Mes=
sage is not yet complete=2E Wait for more fragments=2E
+        if fragment=
ed:
+            return
+
+        if not self=2Edispatch_to_handler(f"rece=
ive_acc_{protocol}", self=2E_partial_acc_msg):
+            logger=2Einfo(f=
"Received unhandled ACC protocol: {protocol}")
+
+        self=2E_partial_a=
cc_msg =3D b""
+        self=2E_protocol_acc_msg =3D ""
diff --git a/sample=
/management/omi_server_demo=2Epy b/sample/management/omi_server_demo=2Epy
n=
ew file mode 100755
index 0000000=2E=2Ec0fd4f5
--- /dev/null
+++ b/sample/m=
anagement/omi_server_demo=2Epy
@@ -0,0 +1,305 @@
+#! /usr/bin/env python3
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
+
+impor=
t asyncio
+import logging
+from asyncio import Future
+from base64 import s=
tandard_b64decode
+from dataclasses import field, dataclass
+from typing im=
port Dict, Optional
+
+from omi_server_protocol import OMIServerProtocol, C=
onnectedClient
+from omi_tools import run_main, start_management_protocol, =
ConnectData
+from omi_tools import openvpn_escape
+
+# This implement a sma=
ll demonstration of using the
+# OpenVPN Access Server Management Interface=
 (OMI)
+# and a script that does various action on the client depending
+# =
on the username the user connects with
+# ensure that you have a proper cer=
tificate based authentication setup
+# before using this script
+# (e=2Eg=
=2E https://github=2Ecom/openvpn/openvpn/blob/master/doc/man-sections/examp=
le-fingerprint=2Erst)
+
+# usage:
+# --management /path/to/omi_server_demo=
=2Epy unix-script
+
+# The main purpose of this script is to test/force cer=
tain client/server
+# behaviour=2E As a test script this is done on the use=
rname but also serves
+# as an example how to implement something similar f=
or normal usage=2E
+#
+# if a username is prefixed with url it uses the old=
 OPEN_URL method (e=2Eg=2E urlrick)
+#
+# - fail: sends AUTH_FAILED
+# - fa=
iln: sends AUTH_FAILED wiht \n
+# - failtemp: sends AUTH_FAILED,TEMP:Go awa=
y for a while
+# - failtemp42: sends AUTH_FAILED,TEMP and backoff for 42s
+=
#     - failtempnr: sends AUTH_FAILED,TEMP and instructs to go the next rem=
ote
+# - success: sends AUTH_SUCCESS
+# - faildelay: sends AUTH_FAILED afte=
r 20s
+# - successdelay: sends AUTH_SUCCESS after 20s
+# - rick: sends you =
to a certain youtube site and auth you
+# - openvpn: sends you to community=
=2Eopenvpn=2Enet
+# - totp: Does crtext based 2FA with secret "totpinsecure=
totp"
+# - google: sends you to https://www=2Egoogle=2Ecom/search?q=3Dhidde=
n without any flags
+# - googleext: sends you to https://www=2Egoogle=2Ecom=
/search?q=3Dexternal with external flags and WEBAUTH \
+#         - dnssec:=
 send only dnssec servers
+# - nodns: no dns servers
+# - dnssecfb: dns ser=
ver with fallback to dns without dnnsec
+# - dnsdhcp: dns options and dhcp_=
options
+# - dnsport: dns server with custom port
+# - failaccdpc1: auth fa=
iled message indicating that the client is missing dpc1 ACC support=2E
+# -=
 failaccdpc1user: auth failed message indicating that the client is missing=
 dpc1 ACC support indicating a auth-token and user for reconnecting
+#     =
- failaccflower: auth failed message indicating that the client is missing =
flower and power ACC support=2E
+# - default: push DNS 8=2E8=2E8=2E8 and de=
fault route
+# - notify: Gives the client a message to display to the user =
via notify protocol
+
+# The hard-coded secret
+totp_secret =3D "totpinsecu=
retotp"
+
+logging=2EbasicConfig()
+logger =3D logging=2EgetLogger(__name__=
)
+logger=2EsetLevel(logging=2EINFO)
+
+try:
+    import pyotp
+except Impo=
rtError:
+    logger=2Einfo("pyotp module not found=2E TOTP testing disable=
d")
+
+
+@dataclass
+class ServerDemoConnectedClient(ConnectedClient):
+   =
 # Remember the key-id that we authenticated
+    authenticated_kid: int =
=3D -1
+    env: Dict[str, str] =3D field(default_factory=3Ddict)
+
+
+clas=
s ServerDemoProtocol(OMIServerProtocol):
+    def __init__(self, finish_fut=
ure: Future, connect_data: ConnectData =3D None):
+        super()=2E__init=
__(finish_future, connect_data)
+        self=2E_connected_client_class =3D=
 ServerDemoConnectedClient
+
+    def client_event_ESTABLISHED(self, client=
: ServerDemoConnectedClient, kid: int, env: Dict, extra: str):
+        pri=
nt(f"CLient connected: {client}")
+
+    def client_event_CONNECT(self, cli=
ent: ServerDemoConnectedClient, kid: int, env: Dict, extra: str) -> None:
+=
        print(f"Authenticating client {client=2Ecid}, {kid}")
+        clie=
nt=2Eauthenticated_kid =3D kid
+        client=2Eenv =3D env
+
+        sel=
f=2Eadd_background_task(self=2Edo_client_auth(client, kid))
+
+    def clie=
nt_event_REAUTH(self, client: ServerDemoConnectedClient, kid: int, env: dic=
t, extra: str):
+        print(f"Re-authenticating client {client}, {kid}")=

+        client=2Eenv =3D env
+        _ =3D self=2Equeue_command(f"client=
-auth-nt {client=2Ecid} {kid}")
+
+
+    async def deny_client(self, client=
: ServerDemoConnectedClient, kid: int, reason: str,
+                      =
    client_reason: Optional[str] =3D None) -> None:
+        # Note, for th=
is test script sending your real reason if you do not
+        # specify a =
client reason is okay=2E In a real environment, this kind
+        # of inf=
ormation is potentially bad
+
+        if not client_reason:
+            c=
lient_reason =3D reason
+        client_deny =3D f'client-deny {client=2Eci=
d} {kid} "{openvpn_escape(reason)}" "{openvpn_escape(client_reason)}"'
+   =
     await self=2Equeue_command(client_deny)
+
+    async def do_client_aut=
h(self, client: ServerDemoConnectedClient, kid: int) -> None:
+        user=
name =3D client=2Eenv=2Eget("username", "(empty username)")
+
+        # su=
ccess
+        if username=2Estartswith("url"):
+            username =3D u=
sername[3:]
+            method =3D "openurl"
+            webauth =3D "OPE=
N_URL:"
+        else:
+            method =3D "webauth"
+            webau=
th =3D "WEB_AUTH::"
+
+        if username =3D=3D 'fail' or 'UV_FAIL' in cl=
ient=2Eenv:
+            await self=2Edeny_client(client, kid, "fail")
+   =
     elif username =3D=3D 'failtemp':
+            await self=2Edeny_client=
(client, kid, "TEMP:Go away for a while")
+        elif username =3D=3D 'fa=
iln':
+            await self=2Edeny_client(client, kid, "Bonus new line fo=
r you!\n")
+        elif username =3D=3D 'failn2':
+            await self=
=2Edeny_client(client, kid, "Bonus new line for you!\nand another one\n")
+=
        elif username =3D=3D 'failtemp42':
+            await self=2Edeny_c=
lient(client, kid, "TEMP[backoff 42]:Go away for a 42s")
+        elif user=
name =3D=3D 'failtempnr':
+            await self=2Edeny_client(client, kid=
, "TEMP[backoff 11,advance remote]:Annoy the next server!")
+        elif u=
sername =3D=3D 'failaccdpc1':
+            await self=2Edeny_client(client,=
 kid,
+                                   "ACC[protocol dpc1]: To connect t=
o this server you need to upgrade to a client that supports the OpenVPN Inc=
 device posture protocol, e=2Eg=2E OpenVPN Connect version 1=2E2=2E3 or lat=
er")
+        elif username =3D=3D 'failaccflower':
+            await self=
=2Edeny_client(client, kid, "ACC[protocol flower power]: You need to embrac=
e the flower power")
+        elif username =3D=3D 'failaccdpc1user':
+    =
        await self=2Edeny_client(client, kid,
+                            =
       "ACC[protocol flower power, user c3VjY2Vzcw=3D=3D, pass MTIzNDU2Nzg=
=3D]: Please come back again  after you enabled dpc1")
+        elif userna=
me =3D=3D 'success':
+            await self=2Esend_client_auth(client, kid=
)
+        elif username =3D=3D 'faildelay':
+            await asyncio=2Es=
leep(20)
+            await self=2Edeny_client(client, kid, "I thought 20s =
about it and rejected you after that time")
+        elif username =3D=3D '=
successdelay':
+            await asyncio=2Esleep(20)
+            await se=
lf=2Esend_client_auth(client, kid)
+        elif username=2Estartswith('tot=
p'):
+            timeout =3D 90
+            extra =3D f"CR_TEXT:E,R:Pleas=
e enter your TOTP code, {username}!"
+            logger=2Einfo(f"The TOTP =
the client needs to provide is: {self=2Eget_current_totp_code()}")
+       =
     await self=2Esend_pending_auth(client, kid, extra, timeout)
+        e=
lif username =3D=3D 'rick':
+            await asyncio=2Esleep(3)
+        =
    await self=2Esend_pending_auth(client, kid, webauth + "https://www=2Eyo=
utube=2Ecom/watch?v=3DdQw4w9WgXcQ")
+            await asyncio=2Esleep(10)
=
+            await self=2Edeny_client(client, kid, "I got you")
+        el=
if username =3D=3D 'openvpn':
+            await self=2Esend_pending_auth(c=
lient, kid, webauth + "https://community=2Eopenvpn=2Enet")
+            awa=
it self=2Esend_client_auth(client, kid)
+        elif username =3D=3D 'goog=
leext':
+            await self=2Esend_pending_auth(client, kid, "WEB_AUTH:=
external:https://www=2Egoogle=2Ecom/search?q=3Dexternal")
+            awai=
t asyncio=2Esleep(10)
+            await self=2Esend_client_auth(client, ki=
d)
+        elif username =3D=3D 'google':
+            await self=2Esend_p=
ending_auth(client, kid, "WEB_AUTH::https://www=2Egoogle=2Ecom/search?q=3De=
xternal")
+            await asyncio=2Esleep(10)
+            await self=2E=
send_client_auth(client, kid)
+        elif username =3D=3D 'special':
+   =
         extra =3D f"CR_TEXT:E:This special username is known, doing nothin=
g, really"
+            await self=2Esend_pending_auth(client, kid, extra)
=
+        elif username in ['dnssec', 'nodns', 'dnssecfb', 'dnsdhcp', 'dnspo=
rt', 'default']:
+            await asyncio=2Esleep(1)
+            await s=
elf=2Esend_client_auth(client, kid)
+        elif username =3D=3D "notify":=

+            await self=2Esend_pending_auth(client, kid,
+                =
                         "NOTIFY::Please wait for 23s to let the server thi=
nk if it want to admit you")
+            await asyncio=2Esleep(23)
+      =
      await self=2Esend_client_auth(client, kid)
+        else:
+          =
  await self=2Edeny_client(client, kid,
+                                  =
 f"The username you used ({username}) is unknown, please pick one that I kn=
ow")
+
+    async def send_client_auth(self, client: ServerDemoConnectedCli=
ent, kid: int) -> None:
+        username =3D client=2Eenv=2Eget("username"=
, "(empty username)")
+
+        config =3D ""
+        if username =3D=3D =
'dnssec':
+            config +=3D """
+            push "dns server 7 addr=
ess 8=2E8=2E8=2E8:53"
+            push "dns server 7 dnssec yes"
+        =
    """
+        elif username =3D=3D 'nodns':
+            pass
+        e=
lif username =3D=3D 'dnssecfb':
+            config +=3D """
+            p=
ush "dns server 7 address 8=2E8=2E8=2E8:53"
+            push "dns server 7=
 dnssec yes"
+            push "dns server 10 address 8=2E8=2E8=2E8"
+     =
       push "dns server 10 transport DoT"
+            push "dns server 12 =
address 8=2E8=2E8=2E8"
+            push "dns server 12 transport DoH"
+   =
         push "dns server 19 address 8=2E8=2E8=2E8:53"
+            """
+  =
      elif username =3D=3D 'dnsdhcp':
+            config +=3D """
+       =
     push "dns server 19 address 8=2E8=2E8=2E8:53"
+            push "dhcp-=
options dns server 1=2E1=2E1=2E1"
+            """
+        elif username =
=3D=3D 'dnsport':
+            config +=3D """
+            push "dns serve=
r 20 address 8=2E8=2E8=2E8:5353"
+            """
+        elif username =
=3D=3D 'default':
+            config +=3D """
+            push "dns serve=
r 19 address 8=2E8=2E8=2E8:53"
+            push "dhcp-options dns server 1=
=2E1=2E1=2E1"
+            push "redirect-gateway def1"
+            """
+
=
+        if not config:
+            await self=2Equeue_command(f"client-au=
th-nt {client=2Ecid} {kid}")
+        else:
+            await self=2Equeue=
_command(f"client-auth {client=2Ecid} {kid}\n{config}\nEND\n")
+
+    async=
 def send_pending_auth(self, client: ServerDemoConnectedClient, kid: int, e=
xtra: str,
+                                timeout: int =3D 180) -> None:
=
+        auth_pending_totp_cmd =3D f'client-pending-auth {client=2Ecid} {ki=
d} "{openvpn_escape(extra)}" {timeout}'
+        await self=2Equeue_command=
(auth_pending_totp_cmd)
+
+    def client_event_CR_RESPONSE(self, client: S=
erverDemoConnectedClient, kid: int, env: Dict, extra: str) -> None:
+      =
  client=2Eenv =3D env
+        self=2Eadd_background_task(self=2Eclient_cr=
response(client, kid, extra))
+
+    @staticmethod
+    def get_current_tot=
p_code() -> str:
+        try:
+            import pyotp
+        except Im=
portError:
+            return "pyotp not found"
+
+        totp =3D pyotp=
=2ETOTP(totp_secret)
+        return totp=2Enow()
+
+    async def client_c=
rresponse(self, client: ServerDemoConnectedClient, kid: int, response: str)=
 -> None:
+        # Try importing the pyotp here to allow the script run w=
ithout pyotp
+        # installed
+        try:
+            import pyotp
+=
        except ImportError:
+            await self=2Edeny_client(client, k=
id, "pytop module not found=2E Cannot do MFA testing")
+            return
=
+
+        try:
+            response =3D standard_b64decode(response)
+   =
         response =3D response=2Edecode()=2Estrip()
+        except Excepti=
on as e:
+            await self=2Edeny_client(client, kid, f"Decoding totp=
 response failed: {e}")
+            return
+
+        totp =3D pyotp=2ETOT=
P(totp_secret)
+
+        logger=2Einfo(f"\nCR: expected totp '{totp=2Enow(=
)}', response was '{response}'\n")
+        # Check if the code is valid (a=
nd also allow code +/-1)
+
+        if totp=2Everify(response, valid_window=
=3D1):
+            await self=2Esend_client_auth(client, kid)
+        els=
e:
+            await self=2Edeny_client(client, kid, "TOTP verification fa=
iled")
+
+
+async def main(connect_data: ConnectData):
+    transport, prot=
ocol, finish_future =3D await start_management_protocol(connect_data, Serve=
rDemoProtocol)
+
+    management_version =3D await protocol=2Emanagement_re=
ady()
+    logger=2Einfo(f"Management interface version: {management_versio=
n}")
+
+    await protocol=2Eenable_log()
+
+    await protocol=2Eset_bytec=
ount_interval(5)
+
+    await finish_future
+
+
+if __name__ =3D=3D '__main=
__':
+    run_main(main)
diff --git a/sample/management/omi_server_protocol=
=2Epy b/sample/management/omi_server_protocol=2Epy
new file mode 100644
ind=
ex 0000000=2E=2Ece84bbe
--- /dev/null
+++ b/sample/management/omi_server_pr=
otocol=2Epy
@@ -0,0 +1,239 @@
+#!/usr/bin/env python3
+# Copyright (c) 2026=
 OpenVPN Inc <sales@openvpn=2Enet>
+# Copyright (c) 2026 Arne Schwabe <arne=
@rfc2549=2Eorg>
+#
+# Permission is hereby granted, free of charge, to any =
person obtaining a copy
+# of this software and associated documentation fi=
les (the "Software"), to deal
+# in the Software without restriction, inclu=
ding without limitation the rights
+# to use, copy, modify, merge, publish,=
 distribute, sublicense, and/or sell
+# copies of the Software, and to perm=
it persons to whom the Software is
+# furnished to do so, subject to the fo=
llowing conditions:
+#
+# The above copyright notice and this permission no=
tice shall be included in all
+# copies or substantial portions of the Soft=
ware=2E
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF ME=
RCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E I=
N NO EVENT SHALL THE
+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAI=
M, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR=
 OTHERWISE, ARISING FROM,
+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR T=
HE USE OR OTHER DEALINGS IN THE
+# SOFTWARE=2E
+
+import asyncio
+import ba=
se64
+import logging
+from asyncio import Future
+from dataclasses import d=
ataclass, field
+from typing import List, Tuple, Dict, Optional
+
+from omi=
 import OmiProtocol, ConnectionProperties, OmiCommandResult
+
+logger =3D l=
ogging=2EgetLogger(__name__)
+logger=2EsetLevel(logging=2EINFO)
+
+
+@datac=
lass
+class ConnectedClient:
+    """This represents a connected client ins=
tance=2E"""
+    cid: int
+    bytes_sent: int =3D 0
+    bytes_received: i=
nt =3D 0
+    _partial_acc_msg: bytes =3D b""
+    _protocol_acc_msg: str =
=3D ""
+    _kid_acc_msg: int =3D -1
+    _acc_fragment_length: int =3D 980=

+    acc_negotiated_protocols: List[str] =3D field(default_factory=3Dlist)=

+
+
+class OMIServerProtocol(OmiProtocol):
+    """
+    This class implem=
ent common method for the OMI when OpenVPN is running
+    as a server=2E T=
hese are mainly helper function and functionality that
+    is only availab=
le/useful for OpenVPN running as a server
+    """
+
+    # Connected clien=
t class, can be overridden by subclasses to store
+    # more information a=
bout the connected client
+    _connected_client_class =3D ConnectedClient
=
+
+    def __init__(self, finish_future: Future, connect_data: ConnectionPr=
operties):
+        super()=2E__init__(finish_future, connect_data)
+      =
  self=2E_reset_pending_client_event()
+        self=2E_connected_clients: =
Dict =3D {}
+
+    def _reset_pending_client_event(self) -> None:
+        =
self=2E_pending_client_event: str =3D ""
+        self=2E_pending_client_ev=
ent_cid: int =3D -1
+        self=2E_pending_client_event_kid: int =3D -1
+=
        self=2E_pending_client_event_extra_args: str =3D None
+        self=
=2E_client_env: Dict =3D {}
+
+    def recv_notify_CLIENT(self, args: str) =
-> None:
+        event, args =3D args=2Esplit(",", 1)
+
+        if event =
=3D=3D "ENV":
+            if args =3D=3D "END":
+                # Client =
environment is finished, trigger previous client
+                # event t=
hat contained an ENV
+                self=2E_trigger_client_event(self=2E_=
pending_client_event, self=2E_pending_client_event_cid,
+                  =
                         self=2E_pending_client_event_kid, self=2E_client_e=
nv,
+                                           self=2E_pending_client_even=
t_extra_args)
+                self=2E_reset_pending_client_event()
+      =
      else:
+                key, value =3D args=2Esplit("=3D", 1)
+       =
         self=2E_client_env[key] =3D value
+
+        elif event in ("ESTAB=
LISHED", "DISCONNECT"):
+            # This event is followed by a client e=
nvironment=2E Wait for
+            # the client environment to be complete=
d before triggering the event
+            cid =3D int(args)
+
+           =
 self=2E_pending_client_event =3D event
+            self=2E_pending_client=
_event_cid =3D int(cid)
+            self=2E_pending_client_event_kid =3D N=
one
+            if event =3D=3D "ESTABLISHED":
+                self=2E_ad=
d_client(cid)
+
+        elif event in ("CONNECT", "REAUTH"):
+            =
# This event is similar to other event but also carries the key-id
+       =
     cid, kid =3D args=2Esplit(",", 1)
+            cid, kid =3D int(cid), =
int(kid)
+            self=2E_add_client(cid)
+
+            self=2E_pendin=
g_client_event =3D event
+            self=2E_pending_client_event_cid =3D =
int(cid)
+            self=2E_pending_client_event_kid =3D int(kid)
+      =
  elif event =3D=3D "CR_RESPONSE":
+            # This event is similar to =
CONNECT and REAUTH but has an extra
+            # parameter with the crtex=
t response
+            cid, kid, response =3D args=2Esplit(",", 2)
+      =
      cid, kid =3D int(cid), int(kid)
+
+            self=2E_pending_client=
_event =3D event
+            self=2E_pending_client_event_cid =3D int(cid)=

+            self=2E_pending_client_event_kid =3D int(kid)
+            se=
lf=2E_pending_client_event_extra_args =3D response
+        elif event =3D=
=3D "ACC":
+            cid, kid, acc_args =3D args=2Esplit(",", 2)
+      =
      self=2E_trigger_client_event(event, int(cid), int(kid), None, acc_arg=
s)
+        elif event =3D=3D "ADDRESS":
+            # >CLIENT:ADDRESS,{CI=
D},{ADDR},{PRI}
+            cid, extra =3D args=2Esplit(",", 1)
+         =
   self=2E_trigger_client_event(event, int(cid), -1, None, extra)
+        =
else:
+            logger=2Einfo(f"Client event {event} not handled=2E (mes=
sage: {args!r})")
+
+    def client_event_ACC(self, client: ConnectedClient=
, kid: int, env: Dict, extra: str) -> None:
+        protocol, fragment, b6=
4msg =3D extra=2Esplit(",", 2)
+
+        if client=2E_partial_acc_msg and =
client=2E_protocol_acc_msg !=3D protocol:
+            logger=2Eerror(f"Rec=
ieved ACC message with protocol {protocol} before "
+                      =
   f"previous ACC message with protocol {client=2E_protocol_acc_msg} was co=
mplete")
+            client=2E_partial_acc_msg =3D b""
+
+        if clien=
t=2E_partial_acc_msg and client=2E_kid_acc_msg !=3D kid:
+            logge=
r=2Eerror(f"Recieved ACC message with different key id {kid} before "
+    =
                     f"previous ACC message with key id {client=2E_kid_acc_=
msg} "
+                         f"was complete=2E This is currently not ha=
ndled")
+            client=2E_partial_acc_msg =3D b""
+
+        try:
+   =
         msg =3D base64=2Edecodebytes(b64msg=2Eencode())
+            clien=
t=2E_partial_acc_msg +=3D msg
+            client=2E_protocol_acc_msg =3D p=
rotocol
+            client=2E_kid_acc_msg =3D kid
+
+            # Message=
 is not yet complete=2E Wait for more fragments=2E
+            if fragment=
 !=3D "0":
+                return
+
+            handler_name =3D f"receiv=
e_acc_client_{protocol}"
+            if not self=2Edispatch_to_handler(han=
dler_name, client, kid, client=2E_partial_acc_msg):
+                logger=
=2Einfo(f"Received unhandled ACC protocol: {protocol}, handler {handler_nam=
e} not found")
+
+            client=2E_partial_acc_msg =3D b""
+          =
  client=2E_protocol_acc_msg =3D protocol
+
+        except Exception as e:=

+            logger=2Eerror(f"Error parsing ACC message from client: {e}",=
 exc_info=3DTrue)
+
+        client=2E_partial_acc_msg =3D b""
+
+    def r=
ecv_notify_BYTECOUNT_CLI(self, args: str) -> None:
+        cid, bytes_rece=
ived, bytes_sent =3D args=2Esplit(",", 2)
+
+        client =3D self=2E_con=
nected_clients=2Eget(int(cid))
+        if client:
+            client=2Eby=
tes_sent =3D int(bytes_sent)
+            client=2Ebytes_received =3D int(b=
ytes_received)
+
+    def _trigger_client_event(self, event: str, cid: int,=
 kid: int, env: Optional[Dict], extra):
+        client =3D self=2E_connect=
ed_clients=2Eget(cid, None)
+
+        # Remember ACC protocol options if p=
resent
+        if event =3D=3D "CONNECT" and "acc_protocols" in env:
+    =
        client=2Eacc_negotiated_protocols =3D [p=2Estrip() for p in env["ac=
c_protocols"]=2Esplit(":")]
+            client=2E_acc_fragment_length =3D =
int(env['acc_message_len'])
+
+        handler_name =3D f"client_event_{eve=
nt}"
+        if not self=2Edispatch_to_handler(handler_name, client, kid, =
env, extra):
+            logger=2Einfo(f"Client event {event} not handled=
=2E Method {handler_name} does not exist=2E")
+
+    def _add_client(self, =
cid: int) -> None:
+        if not cid in self=2E_connected_clients:
+     =
       self=2E_connected_clients[cid] =3D self=2E_connected_client_class(ci=
d=3Dcid)
+
+    def _remove_client(self, cid: int) -> bool:
+        if cid=
 in self=2E_connected_clients:
+            del self=2E_connected_clients[c=
id]
+            return True
+        else:
+            return False
+
+  =
  async def get_client_status(self) -> OmiCommandResult:
+        cmd_resul=
t =3D self=2Equeue_command("status 3")
+        return await cmd_result
+
+=
    async def send_acc_msg(self, client: ConnectedClient, kid: int, protoco=
l: str, msg: bytes) -> None:
+        """
+        Sends out an ACC to the =
client=2E
+        """
+        if protocol not in client=2Eacc_negotiated_=
protocols:
+            logger=2Eerror(f"Error: trying to send ACC message =
with protocol"
+                         f" {protocol} is not in the negoti=
ated list of "
+                         f"protocols ({client=2Eacc_negotia=
ted_protocols})")
+            return
+
+        # See init=2Ec for the exp=
lanation for the length
+        max_header_size =3D len("ACC,") + len(prot=
ocol) + 1 + 4 + 1 + 2 + 1
+
+        # calculate fragment size with base64 =
encoding
+        fragment_length =3D client=2E_acc_fragment_length * 6 // =
8 - max_header_size
+
+        commands =3D []
+        for part_start in r=
ange(0, len(msg), fragment_length):
+
+            msg_part =3D msg[part_st=
art:part_start + fragment_length]
+            # This creates a multiline b=
ase64 message but that is what
+            # we want for the management in=
terface to have a not overlong
+            # lines
+            b64msg =3D=
 base64=2Eencodebytes(msg_part)=2Edecode()
+
+            flags =3D "6"
+  =
          if part_start + fragment_length < len(msg):
+                flag=
s +=3D "F"
+
+            commands=2Eappend(f"client-acc-msg {client=2Ecid}=
 {kid}\n{protocol}\n{flags}\n{b64msg}\nEND")
+
+        cmd_futures =3D []
=
+        for command in commands:
+            cmd_futures=2Eappend(self=2E=
queue_command(command))
+
+        cmd_results: Tuple[OmiCommandResult] =3D=
 await asyncio=2Egather(*cmd_futures)
+        for cmd_result in cmd_result=
s:
+            if cmd_result=2Eerror:
+                logger=2Eerror(f"Er=
ror: sending ACC message failed: {cmd_result}")
+
+    def client_event_DIS=
CONNECT(self, client: ConnectedClient, kid: int, _env: dict, _extra: str):
=
+        self=2E_remove_client(client=2Ecid)
diff --git a/sample/management=
/omi_tools=2Epy b/sample/management/omi_tools=2Epy
new file mode 100644
ind=
ex 0000000=2E=2E28cf5ba
--- /dev/null
+++ b/sample/management/omi_tools=2Ep=
y
@@ -0,0 +1,92 @@
+#! /usr/bin/python3
+# Copyright (c) 2026 OpenVPN Inc <=
sales@openvpn=2Enet>
+# Copyright (c) 2026 Arne Schwabe <arne@rfc2549=2Eorg=
>
+#
+# Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
+# of this software and associated documentation files (the "Soft=
ware"), to deal
+# in the Software without restriction, including without l=
imitation the rights
+# to use, copy, modify, merge, publish, distribute, s=
ublicense, and/or sell
+# copies of the Software, and to permit persons to =
whom the Software is
+# furnished to do so, subject to the following condit=
ions:
+#
+# The above copyright notice and this permission notice shall be =
included in all
+# copies or substantial portions of the Software=2E
+#
+# =
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
=
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,=

+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHA=
LL THE
+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, AR=
ISING FROM,
+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHE=
R DEALINGS IN THE
+# SOFTWARE=2E
+import asyncio
+import os
+import re
+fro=
m dataclasses import dataclass
+
+from omi import OmiProtocol, ConnectionPr=
operties
+
+
+@dataclass
+class ConnectData(ConnectionProperties):
+    soc=
ket: str
+
+
+openvpn_escape_re =3D re=2Ecompile(r'(["\\])')
+filt_ctrl_re =
=3D re=2Ecompile(r"[\x00-\x1f\x7f]+")
+
+
+def openvpn_escape(text:str) -> =
str :
+    """Escapes a string to be safely used for OpenVPN inside
+    a =
quoted string
+
+    Something like 'client-deny 2 3 "{openvpn_escape(reaso=
n)}" "{openvpn_escape(client_reason)}"'
+    """
+    text =3D re=2Esub(fil=
t_ctrl_re, ' ', text)
+    text =3D re=2Esub(openvpn_escape_re, r'\\\1', te=
xt)
+    return text=2Erstrip()
+
+
+def get_unix_script_environment() -> C=
onnectData | None:
+    password =3D os=2Eenviron=2Eget("MANAGEMENT_PASSWOR=
D", None)
+    socket =3D os=2Eenviron=2Eget("MANAGEMENT_SOCKET", None)
+
+=
    if password and socket:
+        return ConnectData(password=3Dpassword=
, socket=3Dsocket)
+    else:
+        return None
+
+
+async def start_man=
agement_protocol(connect_data: ConnectData, protocol: OmiProtocol):
+    # =
Get a reference to the event loop as we plan to use
+    # low-level APIs=
=2E
+    loop =3D asyncio=2Eget_running_loop()
+
+    finish_future =3D loo=
p=2Ecreate_future()
+
+    print(f"Connecting to management socket {connect=
_data=2Esocket}=2E=2E=2E")
+    transport, protocol =3D await loop=2Ecreate=
_unix_connection(lambda: protocol(finish_future, connect_data),
+          =
                                                  connect_data=2Esocket)
+
=
+    return transport, protocol, finish_future
+
+
+def run_main(main_func,=
 connect_parameters: ConnectData =3D None):
+    """
+    Example function =
to run a main function to be either using the
+    environment variable for=
 the unix-script or to use=2E If the unix-script
+    environment are detec=
ted, the function will run the main_func
+    with the ConnectData from the=
 environment=2E If the environment variables
+    are not available, it wil=
l fall back to the connect_parameters
+    if present=2E
+    :param connec=
t_parameters:  fallback connect parameters if unix-script is not available
=
+    :param main_func:           The function to call=2E
+    :return:
+   =
 """
+    unix_script_parameters =3D get_unix_script_environment()
+    if =
unix_script_parameters:
+        asyncio=2Erun(main_func(unix_script_parame=
ters))
+    elif connect_parameters:
+        asyncio=2Erun(main_func(conne=
ct_parameters))
+    else:
+        print(f"Must be called via unix-script"=
)

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib09bafabf6=
12e9501ea757647c86a450c73228a5
Gerrit-Change-Number: 1859
Gerrit-PatchSet: =
10
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Name =
of user not set #1000061
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: Name of user not set #1000061

--KcpI/gdQG3k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Name of user not set #1000061=2E </p>
<p>Arne Schwabe=
 <strong>uploaded patch set #10</strong> to this change=2E</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">Add python scripts that demonstrate using the mangement=
 interface<br><br>Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5<br>S=
igned-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M sample/Ma=
kefile=2Eam<br>A sample/management/omi=2Epy<br>A sample/management/omi_clie=
nt_protocol=2Epy<br>A sample/management/omi_server_demo=2Epy<br>A sample/ma=
nagement/omi_server_protocol=2Epy<br>A sample/management/omi_tools=2Epy<br>=
6 files changed, 1,133 insertions(+), 0 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/59/18=
59/10</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/sample/Makefile=2Eam b/sample/Makefile=2Eam</spa=
n><br><span>index f3528ba=2E=2E28574d9 100644</span><br><span>--- a/sample/=
Makefile=2Eam</span><br><span>+++ b/sample/Makefile=2Eam</span><br><span>@@=
 -16,6 +16,7 @@</span><br><span>        $(builddir)/sample-plugins/Makefile=
</span><br><span> </span><br><span> EXTRA_DIST =3D \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	management \</span><br><span> 	sample-pl=
ugins \</span><br><span> 	sample-config-files \</span><br><span> 	sample-ke=
ys \</span><br><span>diff --git a/sample/management/omi=2Epy b/sample/manag=
ement/omi=2Epy</span><br><span>new file mode 100644</span><br><span>index 0=
000000=2E=2E75eeece</span><br><span>--- /dev/null</span><br><span>+++ b/sam=
ple/management/omi=2Epy</span><br><span>@@ -0,0 +1,364 @@</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+# Copyright (c) 2026 OpenVPN Inc &lt;=
sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# Copyright (c) 2026 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+# Permission is hereby granted, free of charge, =
to any person obtaining a copy</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+# of this software and associated documentation files (the &quot=
;Software&quot;), to deal</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+# in the Software without restriction, including without limitation t=
he rights</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# to use, =
copy, modify, merge, publish, distribute, sublicense, and/or sell</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# copies of the Software, and=
 to permit persons to whom the Software is</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+# furnished to do so, subject to the following condi=
tions:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# The above copyright notice an=
d this permission notice shall be included in all</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+# copies or substantial portions of the Softw=
are=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# THE SOFTWARE IS PROVIDED &quo=
t;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+# IMPLIED, INCLUDING BUT NOT LIMITED TO=
 THE WARRANTIES OF MERCHANTABILITY,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E I=
N NO EVENT SHALL THE</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# LIABILITY, WHETHER =
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+# OUT OF OR IN CONNECTION WITH THE S=
OFTWARE OR THE USE OR OTHER DEALINGS IN THE</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+# SOFTWARE=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
 This is an example implementation in python and asyncio to drive OpenVPN&#=
39;s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# management in=
terface (OMI)=2E The permissive license allows you to use this</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+# code in other projects=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+&quot;&quot;&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+Implementation of the OpenVPN management =
interface (OMI) protocol=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+This implem=
ents the generic part of the OMI protocol that is common</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+to both client and server=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+&quot;&quot;&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+import asyncio</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+import inspect</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+import logging</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+import re</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+from asyncio import Future, Event, Task, Queue</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+from dataclasses import data=
class</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from datetime =
import datetime</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from=
 functools import partial</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+from typing import override, List, Optional, Awaitable, Coroutine</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+OMI_PASSWORD_PROMPT =3D b&quot;ENTER PASS=
WORD:&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+logger =3D logging=2EgetLog=
ger(__name__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+@dataclass</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+class OmiCommandResult:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    command: str</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    result: List[str]</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    error: bool</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    status_text: str</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+@dataclass</span><br><span style=3D"color: hsl(120, 100%, 40%);">+class =
OmiSendCommand:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
command: str</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    res=
ult: Future[OmiCommandResult]</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+@dataclass</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+class ConnectionProperties:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    Properties for connect=
ing to the management interface=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    &quot;&quot;&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    password: Optional[str]</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+class OmiPro=
tocol(asyncio=2EProtocol):</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    def __init__(self, finish_future: Future, connect_data: Connecti=
onProperties):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   super()=2E__init__()</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        self=2E_connect_data: ConnectionProperties =3D connect_data</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        self=2Ebytes_received: int =3D 0<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2Ebytes=
_sent: int =3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     self=2Eversion: int =3D -1</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        self=2Erecv_buffer: bytes =3D b&quot;&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        self=2Efinish_future: F=
uture =3D finish_future</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        self=2Etransport: Optional[asyncio=2ETransport] =3D None</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        # Event to allow waiting for status o=
f the underlying socket</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        # to become available for writing</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        self=2E_can_send: Event =3D asyncio=2EEve=
nt()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E=
_can_send=2Eclear()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # Event to =
track when the management interface is ready to receive</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        # commands from us</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        self=2E_management_ready=
: Event =3D asyncio=2EEvent()</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        self=2E_management_ready=2Eclear()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        self=2E_response =3D []</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        self=2E_response_ready: Event =3D asynci=
o=2EEvent()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
self=2E_response_ready=2Eclear()</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  self=2E_send_queue: Queue =3D asyncio=2EQueue()</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        self=2E_send_task: Task =3D asyncio=
=2Ecreate_task(self=2E_send_loop())</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     self=2Erunning_tasks =3D set()</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    @override</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    def eof_received(self) -=
&gt; None:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        l=
ogger=2Einfo(&#39;EOF received=2E Shutting down=2E&#39;)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        self=2E_stop()</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    @override</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    def connection_lost(self, exc: Exception | None) -&gt; N=
one:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if exc:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            logger=
=2Ewarning(f&#39;Connection lost ({exc})=2E Shutting down=2E&#39;)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        else:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            logger=2Ewarning(f&#39=
;Connection lost=2E Shutting down=2E&#39;)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        self=2E_stop()</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    def _stop(self) -&gt; None:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if not self=2Efinish_future=2Edone():</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            # If we are discon=
nected or stop, there is no sense trying</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            # to still send commands to the management=
 interface</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   self=2E_send_task=2Ecancel()</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            self=2Efinish_future=2Eset_result(True)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    async def _send_loop(self) -&gt; None:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        while True:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            command: OmiSen=
dCommand =3D await self=2E_send_queue=2Eget()</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            await self=2E_can_send=2Ewait()</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            self=2Esend_l=
ine(command=2Ecommand)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            resp=
onse: List[str] =3D []</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            response_complete =3D False</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            # This is a bit brittle as it will loop forever if not gett=
ing a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            # =
line that starts with ERROR or SUCCESS=2E With a normal OpenVPN</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            # daemon that speak=
 the correct protocol this should not be a</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            # problem</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            while not response_complete:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                await self=2E=
_response_ready=2Ewait()</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  line =3D self=2E_response=2Epop(0)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                response=2Eappend(line)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                if not self=2E_response:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    self=2E_response=
_ready=2Eclear()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                lastli=
ne =3D response[-1]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                if lastline=2Estartswith(&#39;ERROR: &#39;):</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    error =3D True=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 response_complete =3D True</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                    _, status_text =3D lastline=2Esplit(&quot;: &qu=
ot;, 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                elif lastline=
=2Estartswith(&#39;SUCCESS: &#39;):</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    error =3D False</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    response_complete =3D=
 True</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
      _, status_text =3D lastline=2Esplit(&quot;: &quot;, 1)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                elif lastline =3D=
=3D &quot;END&quot;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    error =3D False</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    response_complete =3D True</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    status_text=
 =3D None</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      else:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            # Other lines do not complete a response</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    pass</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            # logger=2Edebug(f&#39;Result received comm=
and: {response}&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            result =3D OmiCommandResult(command=2Ecommand, response[:-1],=
 error, status_text)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if not=
 command=2Eresult=2Ecancelled():</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                command=2Eresult=2Eset_result(result)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            logger=2Edebug(f&quot;Command done=
=2E&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    @override</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    def pause_writing(self) -&gt; =
None:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=
=2E_can_send=2Eclear()</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    @override</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    def resume_writing=
(self) -&gt; None:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       self=2E_can_send=2Eset()</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    @ov=
erride</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def conne=
ction_made(self, transport) -&gt; None:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        peername =3D transport=2Eget_extra_info(&#39;pe=
ername&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 logger=2Einfo(&#39;Connection from {}&#39;=2Eformat(peername))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        self=2Etransport =3D tr=
ansport</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=
=2E_can_send=2Eset()</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def _check_pw_=
response(self, fut: Future[OmiCommandResult]) -&gt; None:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if fut=2Eexception():</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            logger=2Eerror(=
f&quot;Error authenticating with password: {fut=2Eexception()}&quot;)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            self=2Etransp=
ort=2Eclose()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        result =3D fut=2Er=
esult()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if result=2Eerror or re=
sult=2Estatus_text !=3D &quot;password is correct&quot;:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            logger=2Eerror(f&quot;Rece=
ived unexpected status after trying to authenticate: {result=2Estatus_text!=
r}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  self=2Etransport=2Eclose()</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            return</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def han=
dle_password_prompt(self) -&gt; None:</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        # OMI expects us to authenticate with the passwor=
d just on</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # =
its own on a line</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if self=2E_connect_data=2Epassword:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            fut =3D self=2Equeue_command(f&quot;{self=
=2E_connect_data=2Epassword}&quot;)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            fut=2Eadd_done_callback(self=2E_check_pw_respon=
se)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else:</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            logger=2Ee=
rror(&quot;No password provided for authentication&quot;)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            self=2Etransport=2Eclose(=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    @override</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    def data_received(self, data: bytes) =
-&gt; None:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
# OMI protocol is pure text so decode everything as UTF-8</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        message =3D data</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        self=2Erecv_buffer +=3D =
message</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        # Management protocol d=
oes not add a newline after the password prompt</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if not self=2E_management_ready=2Eis_se=
t() and self=2Erecv_buffer=2Estartswith(OMI_PASSWORD_PROMPT):</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            logger=2Edebug(f&quot=
;Received password prompt&quot;)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            self=2Erecv_buffer =3D self=2Erecv_buffer[len(OMI_=
PASSWORD_PROMPT) + 1:]</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            self=2Ehandle_password_prompt()</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            return</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        parts =3D self=2Erecv_buffer=2Esplit(b&quot;\r\n&quot;)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        # pass complete lines to recvLine=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for part in=
 parts[:-1]:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     part =3D part=2Edecode()</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            logger=2Edebug(f&#39;Line received: {part!r}&#39;)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            self=2Erec=
v_line(part)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        # keep the last in=
complete line for the next call</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        self=2Erecv_buffer =3D parts[-1]</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    def recv_line(self, line: str) -&gt; None:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if line=2Estartswith(&quo=
t;&gt;&quot;):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       # this is an asynchronous message</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            self=2Erecv_notify(line)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        else:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            # normal message get passed t=
o the _send_loop task</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            self=2E_response=2Eappend(line)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            self=2E_response_ready=2Eset()</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    def recv_notify(self, line: str) -&gt; No=
ne:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if not &=
quot;:&quot; in line:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            logger=2Ewarning(&quot;Invalid line received: &quot; + line)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        command, args =3D line[1:]=2Espl=
it(&quot;:&quot;, 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # do dynam=
ic dispatch based on command to call a handler</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if not self=2Edispatch_to_handler(f&quot=
;recv_notify_{command}&quot;, args):</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            logger=2Einfo(&quot;Unknown notify line receiv=
ed: &quot; + line)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def dispatch_to_h=
andler(self, handlername:str, *args, **kwargs):</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        &quot;&quot;&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        Looks up if this class or a subc=
lass has a handler for the given</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        command and either directly calls it or schedules it a=
s a coroutine=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     :return: true if a handler was found and called</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        &quot;&quot;&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if hasattr(self, handlerna=
me):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            han=
dler =3D getattr(self, handlername)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            if inspect=2Eiscoroutinefunction(handler):</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                logger=
=2Edebug(f&quot;Calling async handler {handler}&quot;)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                task =3D self=2Eadd_back=
ground_task(handler(*args, **kwargs), handlername)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            else:</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                try:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                    logger=2Edebug(f&quot;Cal=
ling handler {handler}&quot;)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    handler(*args, **kwargs)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                except Exception as e:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    l=
ogger=2Eerror(f&quot;Error executing handler {handlername}: {e}&quot;, exc_=
info=3DTrue)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            return True</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        else:</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            return False</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    def _background_task_done(self, handl=
er_name:str, task: Task):</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        self=2Erunning_tasks=2Eremove(task)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if task=2Eexception():</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            logger=2Eerror(f&quot;=
Error executing background task {handler_name}: {task=2Eexception()}&quot;)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    def add_background_task(self, func=
:Coroutine, name:Optional[str]=3DNone) -&gt; Task:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        &quot;&quot;&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        Schedules an async task to ru=
n in the background and keep a</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        reference to the task so it will not be garbage collecte=
d=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;&=
quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
task =3D asyncio=2Ecreate_task(func)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        self=2Erunning_tasks=2Eadd(task)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if not name:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            name =3D repr(func)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        task=2Eadd_done_callback(partial(self=2E_background_=
task_done, name))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return task</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    def recv_notify_INFO(self, args: str=
) -&gt; None:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  m =3D re=2Ematch(r&quot;OpenVPN Management Interface Version (?P&lt;versi=
on&gt;\d+)&quot;, args)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if m:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          self=2Eversion =3D int(m=2Egroup(&quot;version&quot;))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            self=2Equeue_comma=
nd(&quot;version 6&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            self=2E_management_ready=2Eset()</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        else:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            logger=2Ewarning(f&quot;Unknown INFO l=
ine received: {args}&quot;)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def rec=
v_notify_BYTECOUNT(self, args: str) -&gt; None:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        bytes_received, bytes_sent =3D args=2Es=
plit(&quot;,&quot;, 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        self=2Ebytes_sent =3D int(bytes_sent)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        self=2Ebytes_received =3D int(bytes_re=
ceived)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    async def _release_hold_tas=
k(self, hold_time: int =3D 0) -&gt; None:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        await asyncio=2Esleep(hold_time)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        await self=2Equeue_comma=
nd(&quot;hold release&quot;)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def re=
cv_notify_HOLD(self, args):</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        _text, hold_time =3D args=2Esplit(&quot;:&quot;, 1)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        hold_time =3D int(h=
old_time)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        self=2Eadd_background=
_task(self=2E_release_hold_task(hold_time))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    def queue_command(self, command: str) -&gt; Future[OmiCommandResul=
t]:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmd =3D =
OmiSendCommand(command, Future())</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        self=2E_send_queue=2Eput_nowait(cmd)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return cmd=2Eresult</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    async def management_ready(self) -&gt; int:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;&quot=
;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Wait=
s until the management interface is ready=2E Returns the management interfa=
ce version=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        await self=2E_management_ready=2Ewait()</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return self=2Eversion</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    def send_line(self, line: str) -&gt; None:</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        logger=2Edebug(f&quo=
t;Sending line: {line}&quot;)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        self=2Etransport=2Ewrite(f&quot;{line}\n&quot;=2Eencode()=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    Set the bytecount interval=2E =
Use 0 to disable</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    async def set_b=
ytecount_interval(self, interval: int):</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return await self=2Equeue_command(f&quot;byteco=
unt {interval}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    async def ena=
ble_log(self):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return await self=2Equeue_command(&quot;log on&quot;)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    def recv_notify_LOG(self, args):</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        # &gt;LOG:1786453401,D,MANAGEMEN=
T: CMD &#39;bytecount 30&#39;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        timestamp, level, message =3D args=2Esplit(&quot;,&quot;,=
 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        timestamp =3D datetime=2Efr=
omtimestamp(int(timestamp))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        level =3D level=2Estrip()</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        message =3D message=2Estrip()</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        self=2Elog_message(timestam=
p, level, message)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def log_message(=
self, time:datetime, level:str, message:str):</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        &quot;&quot;&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        A new log message has been receiv=
ed=2E This method is intended</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        to be overridden by a subclass to handle the log messages=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        :param t=
ime:    time in local time format</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        :param level:   level of the log message</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        :param message: the log =
message itself</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   :return:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
&quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       logger=2Edebug(f&quot;Received log message: {time}, {level}, {messag=
e}&quot;)</span><br><span>diff --git a/sample/management/omi_client_protoco=
l=2Epy b/sample/management/omi_client_protocol=2Epy</span><br><span>new fil=
e mode 100644</span><br><span>index 0000000=2E=2E0d7d15e</span><br><span>--=
- /dev/null</span><br><span>+++ b/sample/management/omi_client_protocol=2Ep=
y</span><br><span>@@ -0,0 +1,132 @@</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#!/usr/bin/env python3</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+# Copyright (c) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Copyright (c)=
 2026 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# Permission is hereby granted, free of charge, to any person obtai=
ning a copy</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# of thi=
s software and associated documentation files (the &quot;Software&quot;), t=
o deal</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# in the Soft=
ware without restriction, including without limitation the rights</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# to use, copy, modify, merge=
, publish, distribute, sublicense, and/or sell</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+# copies of the Software, and to permit persons =
to whom the Software is</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# furnished to do so, subject to the following conditions:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+# The above copyright notice and this permission n=
otice shall be included in all</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+# copies or substantial portions of the Software=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+# THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITH=
OUT WARRANTY OF ANY KIND, EXPRESS OR</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF =
MERCHANTABILITY,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# F=
ITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL TH=
E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# AUTHORS OR COPYR=
IGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+# LIABILITY, WHETHER IN AN ACTION OF CON=
TRACT, TORT OR OTHERWISE, ARISING FROM,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR OTHER DEALINGS IN THE</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+# SOFTWARE=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=
mport asyncio</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import=
 base64</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import loggi=
ng</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from asyncio impo=
rt Future</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from typin=
g import Tuple</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+from omi import OmiProto=
col, OmiCommandResult</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+from sample=2Emanagement=2Eomi import ConnectionProperties</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+logger =3D logging=2EgetLogger(__name__)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+class OMIClientProtocol(OmiProtocol):</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    Implement the management protocol for the cli=
ent  </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;&quo=
t;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    def __init__(self, finish_=
future: Future, connect_data: ConnectionProperties):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        super()=2E__init__(finish_future=
=3Dfinish_future, connect_data=3Dconnect_data)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        self=2E_partial_acc_msg =3D b&quot;&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_pr=
otocol_acc_msg =3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        self=2E_acc_fragment_length =3D 980</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        self=2E_acc_negotiated_protocol=
s =3D []</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    async def send_acc_msg(sel=
f, protocol: str, msg: bytes):</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        &quot;&quot;&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        Sends out an ACC to the server using the specifie=
d ACC message length</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        :param protocol:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        :param msg:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        :param fragment_length:</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        :return:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        &quot;&quot;&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if protocol not in self=2E_acc_negotiated_pro=
tocols:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
logger=2Eerror(f&quot;Error: trying to send ACC message with protocol &quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
       f&quot;{protocol} is not in the negotiated list of &quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                         f&quo=
t;protocols ({self=2E_acc_negotiated_protocols})&quot;)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            return</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        # See init=2Ec for the explanation for the length c=
alculation</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
ax_header_size =3D len(&quot;ACC,&quot;) + len(protocol) + 1 + 4 + 1 + 2 + =
1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        # calculate fragment size wit=
h base64 encoding</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      fragment_length =3D self=2E_acc_fragment_length * 6 // 8 - max_header=
_size</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        commands =3D []</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        for part_start in ran=
ge(0, len(msg), fragment_length):</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       msg_part =3D msg[part_start:part_start + fragment_length]</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            # This creates a m=
ultiline base64 message but that is what</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            # we want for the management interface to =
have a not overlong</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            # lines</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            b64msg =3D base64=2Eencodebytes(msg_part)=2Edecode()</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            flags =3D &quot;6&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if part_start + fragm=
ent_length &lt; len(msg):</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                flags +=3D &quot;F&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            commands=2Eappend(f&quot;acc-msg\n{protocol}\n{flags}\n=
{b64msg}\nEND&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmd_future=
s =3D []</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for=
 command in commands:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            cmd_futures=2Eappend(self=2Equeue_command(command))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        cmd_results: Tuple[OmiCommandResult] =3D=
 await asyncio=2Egather(*cmd_futures)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       for cmd_result in cmd_results:</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            if cmd_result=2Eerror:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                logger=2Eerror(f&quot;Err=
or: sending ACC message failed: {cmd_result}&quot;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    def recv_notify_ACC_PROTOCOLS(self, args: str):</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        params =3D args=2Esp=
lit(&quot;,&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       acc_params =3D {}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for p =
in params:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   k, v =3D p=2Esplit(&quot;=3D&quot;, 1)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            acc_params[k=2Estrip()] =3D v=2Estrip()</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        self=2E_acc_negotiated_protocols=
 =3D acc_params[&#39;protocols&#39;]=2Esplit(&quot;:&quot;)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        self=2E_acc_fragment_length =3D int(acc_params=
[&#39;message_len&#39;])</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def recv_n=
otify_ACC(self, args: str):</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        protocol, fragment, b64msg =3D args=2Esplit(&quot;,&quot;, =
2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if self=2E_partial_acc_msg a=
nd self=2E_protocol_acc_msg !=3D protocol:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            logger=2Eerror(f&quot;Received ACC messa=
ge with protocol {protocol} before &quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                         f&quot;previous ACC message =
with protocol {self=2E_protocol_acc_msg} was complete&quot;)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            self=2E_partial_acc_ms=
g =3D b&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        try:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            msg =3D base64=
=2Edecodebytes(b64msg=2Eencode())</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            self=2E_partial_acc_msg +=3D msg</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            self=2E_protocol_acc_msg=
 =3D protocol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  except Exception as e:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            logger=2Eerror(f&quot;Error parsing ACC message: {e}&quot;=
, exc_info=3DTrue)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           self=2E_partial_acc_msg =3D b&quot;&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        fragmented =3D fragment !=3D &quot;0&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        logger=2Edebug(</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            f&quot;Receiv=
ed ACC message (fragment {fragmented}, protocol {protocol!r}), with payload=
 {msg=2Edecode()!r}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # Me=
ssage is not yet complete=2E Wait for more fragments=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if fragmented:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            return</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if not self=2Edispatch_to_handler(f&quot;receive=
_acc_{protocol}&quot;, self=2E_partial_acc_msg):</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            logger=2Einfo(f&quot;Received unha=
ndled ACC protocol: {protocol}&quot;)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       self=2E_partial_acc_msg =3D b&quot;&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        self=2E_protocol_acc_msg =3D &quot;&qu=
ot;</span><br><span>diff --git a/sample/management/omi_server_demo=2Epy b/s=
ample/management/omi_server_demo=2Epy</span><br><span>new file mode 100755<=
/span><br><span>index 0000000=2E=2Ec0fd4f5</span><br><span>--- /dev/null</s=
pan><br><span>+++ b/sample/management/omi_server_demo=2Epy</span><br><span>=
@@ -0,0 +1,305 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#!=
 /usr/bin/env python3</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# Copyright (c) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+# Copyright (c) 2026 Arne Schwab=
e &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Permiss=
ion is hereby granted, free of charge, to any person obtaining a copy</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+# of this software and as=
sociated documentation files (the &quot;Software&quot;), to deal</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# in the Software without rest=
riction, including without limitation the rights</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# to use, copy, modify, merge, publish, distri=
bute, sublicense, and/or sell</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+# copies of the Software, and to permit persons to whom the Softw=
are is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# furnished t=
o do so, subject to the following conditions:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# The above copyright notice and this permission notice shall be in=
cluded in all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# copi=
es or substantial portions of the Software=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF A=
NY KIND, EXPRESS OR</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+# FITNESS FOR A PART=
ICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+# AUTHORS OR COPYRIGHT HOLDERS BE L=
IABLE FOR ANY CLAIM, DAMAGES OR OTHER</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OT=
HERWISE, ARISING FROM,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS=
 IN THE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# SOFTWARE=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+import asyncio</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+import logging</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+from asyncio import Future</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+from base64 import standard_b64decode<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+from dataclasses imp=
ort field, dataclass</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+from typing import Dict, Optional</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from=
 omi_server_protocol import OMIServerProtocol, ConnectedClient</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+from omi_tools import run_main, =
start_management_protocol, ConnectData</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+from omi_tools import openvpn_escape</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# This implement a small demonstration of using the</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+# OpenVPN Access Server Ma=
nagement Interface (OMI)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+# and a script that does various action on the client depending</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+# on the username the user=
 connects with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# ens=
ure that you have a proper certificate based authentication setup</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# before using this script</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+# (e=2Eg=2E https://gi=
thub=2Ecom/openvpn/openvpn/blob/master/doc/man-sections/example-fingerprint=
=2Erst)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# usage:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# --management /path/to/omi_server_demo=
=2Epy unix-script</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# The main purpose of=
 this script is to test/force certain client/server</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# behaviour=2E As a test script this is d=
one on the username but also serves</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# as an example how to implement something similar for norm=
al usage=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+# if a username is prefixe=
d with url it uses the old OPEN_URL method (e=2Eg=2E urlrick)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+# - fail: sends AUTH_FAILED</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# - failn: sends AUTH_FAILED wiht \n</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+# - failtemp: sends AUTH=
_FAILED,TEMP:Go away for a while</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+# - failtemp42: sends AUTH_FAILED,TEMP and backoff for 42s</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#     - failtempnr: sen=
ds AUTH_FAILED,TEMP and instructs to go the next remote</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+# - success: sends AUTH_SUCCESS</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+# - faildelay: sends AUTH_F=
AILED after 20s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - =
successdelay: sends AUTH_SUCCESS after 20s</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+# - rick: sends you to a certain youtube site and au=
th you</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - openvpn: =
sends you to community=2Eopenvpn=2Enet</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+# - totp: Does crtext based 2FA with secret &quot;totpin=
securetotp&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# -=
 google: sends you to https://www=2Egoogle=2Ecom/search?q=3Dhidden without =
any flags</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - google=
ext: sends you to https://www=2Egoogle=2Ecom/search?q=3Dexternal with exter=
nal flags and WEBAUTH \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#         - dnssec: send only dnssec servers</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# - nodns: no dns servers</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+# - dnssecfb: dns server with fallback t=
o dns without dnnsec</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# - dnsdhcp: dns options and dhcp_options</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+# - dnsport: dns server with custom port</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# - failaccdpc1: auth failed me=
ssage indicating that the client is missing dpc1 ACC support=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# - failaccdpc1user: auth faile=
d message indicating that the client is missing dpc1 ACC support indicating=
 a auth-token and user for reconnecting</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#     - failaccflower: auth failed message indicating t=
hat the client is missing flower and power ACC support=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+# - default: push DNS 8=2E8=2E8=2E8 a=
nd default route</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# -=
 notify: Gives the client a message to display to the user via notify proto=
col</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+# The hard-coded secret</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+totp_secret =3D &quot;totpinsec=
uretotp&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+logging=2EbasicConfig()</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+logger =3D logging=2E=
getLogger(__name__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
logger=2EsetLevel(logging=2EINFO)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+try:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    import pyotp</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+except ImportError:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    logger=2Einfo(&quot=
;pyotp module not found=2E TOTP testing disabled&quot;)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+@d=
ataclass</span><br><span style=3D"color: hsl(120, 100%, 40%);">+class Serve=
rDemoConnectedClient(ConnectedClient):</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    # Remember the key-id that we authenticated</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    authenticated_kid: int =
=3D -1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    env: Dict=
[str, str] =3D field(default_factory=3Ddict)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+class ServerD=
emoProtocol(OMIServerProtocol):</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    def __init__(self, finish_future: Future, connect_data: Con=
nectData =3D None):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        super()=2E__init__(finish_future, connect_data)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        self=2E_connected_client_class =
=3D ServerDemoConnectedClient</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def c=
lient_event_ESTABLISHED(self, client: ServerDemoConnectedClient, kid: int, =
env: Dict, extra: str):</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        print(f&quot;CLient connected: {client}&quot;)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    def client_event_CONNECT(self, client: ServerDemoCo=
nnectedClient, kid: int, env: Dict, extra: str) -&gt; None:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        print(f&quot;Authenticating=
 client {client=2Ecid}, {kid}&quot;)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        client=2Eauthenticated_kid =3D kid</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        client=2Eenv =3D env</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        self=2Eadd_background_task(self=2Edo_=
client_auth(client, kid))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def clien=
t_event_REAUTH(self, client: ServerDemoConnectedClient, kid: int, env: dict=
, extra: str):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   print(f&quot;Re-authenticating client {client}, {kid}&quot;)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        client=2Eenv =3D env</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        _ =3D self=2Eq=
ueue_command(f&quot;client-auth-nt {client=2Ecid} {kid}&quot;)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    async def deny_client(self, client: ServerDemoConnectedClient, kid=
: int, reason: str,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                          client_reason: Optional[str] =3D None) -&gt; None=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # Note, fo=
r this test script sending your real reason if you do not</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        # specify a client reason is =
okay=2E In a real environment, this kind</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        # of information is potentially bad</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if not client_reason:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            client_reason =3D reason</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        client_deny =
=3D f&#39;client-deny {client=2Ecid} {kid} &quot;{openvpn_escape(reason)}&q=
uot; &quot;{openvpn_escape(client_reason)}&quot;&#39;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        await self=2Equeue_command(client=
_deny)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    async def do_client_auth(sel=
f, client: ServerDemoConnectedClient, kid: int) -&gt; None:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        username =3D client=2Eenv=
=2Eget(&quot;username&quot;, &quot;(empty username)&quot;)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        # success</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if username=2Estartswith(&quot;url&quot;):</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            username =3D u=
sername[3:]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    method =3D &quot;openurl&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            webauth =3D &quot;OPEN_URL:&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        else:</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            method =3D &quot;webauth&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            webau=
th =3D &quot;WEB_AUTH::&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f username =3D=3D &#39;fail&#39; or &#39;UV_FAIL&#39; in client=2Eenv:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            await self=
=2Edeny_client(client, kid, &quot;fail&quot;)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        elif username =3D=3D &#39;failtemp&#39;:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            await se=
lf=2Edeny_client(client, kid, &quot;TEMP:Go away for a while&quot;)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        elif username =3D=
=3D &#39;failn&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            await self=2Edeny_client(client, kid, &quot;Bonus new line for=
 you!\n&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   elif username =3D=3D &#39;failn2&#39;:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            await self=2Edeny_client(client, kid, &qu=
ot;Bonus new line for you!\nand another one\n&quot;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        elif username =3D=3D &#39;failtem=
p42&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  await self=2Edeny_client(client, kid, &quot;TEMP[backoff 42]:Go away for =
a 42s&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 elif username =3D=3D &#39;failtempnr&#39;:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            await self=2Edeny_client(client, kid, &=
quot;TEMP[backoff 11,advance remote]:Annoy the next server!&quot;)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        elif username =3D=3D=
 &#39;failaccdpc1&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            await self=2Edeny_client(client, kid,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                   &quot;=
ACC[protocol dpc1]: To connect to this server you need to upgrade to a clie=
nt that supports the OpenVPN Inc device posture protocol, e=2Eg=2E OpenVPN =
Connect version 1=2E2=2E3 or later&quot;)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        elif username =3D=3D &#39;failaccflower&#39;:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            await s=
elf=2Edeny_client(client, kid, &quot;ACC[protocol flower power]: You need t=
o embrace the flower power&quot;)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        elif username =3D=3D &#39;failaccdpc1user&#39;:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            await self=2E=
deny_client(client, kid,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                                   &quot;ACC[protocol flower power, us=
er c3VjY2Vzcw=3D=3D, pass MTIzNDU2Nzg=3D]: Please come back again  after yo=
u enabled dpc1&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        elif username =3D=3D &#39;success&#39;:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            await self=2Esend_client_auth(cli=
ent, kid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        el=
if username =3D=3D &#39;faildelay&#39;:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            await asyncio=2Esleep(20)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            await self=2Edeny_client(=
client, kid, &quot;I thought 20s about it and rejected you after that time&=
quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        elif =
username =3D=3D &#39;successdelay&#39;:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            await asyncio=2Esleep(20)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            await self=2Esend_client_=
auth(client, kid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      elif username=2Estartswith(&#39;totp&#39;):</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            timeout =3D 90</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            extra =3D f&quot;CR_TEXT:E=
,R:Please enter your TOTP code, {username}!&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            logger=2Einfo(f&quot;The TOTP the=
 client needs to provide is: {self=2Eget_current_totp_code()}&quot;)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            await self=2Es=
end_pending_auth(client, kid, extra, timeout)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        elif username =3D=3D &#39;rick&#39;:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            await asynci=
o=2Esleep(3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     await self=2Esend_pending_auth(client, kid, webauth + &quot;https://ww=
w=2Eyoutube=2Ecom/watch?v=3DdQw4w9WgXcQ&quot;)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            await asyncio=2Esleep(10)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            await self=2Edeny_=
client(client, kid, &quot;I got you&quot;)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        elif username =3D=3D &#39;openvpn&#39;:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            await self=
=2Esend_pending_auth(client, kid, webauth + &quot;https://community=2Eopenv=
pn=2Enet&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        await self=2Esend_client_auth(client, kid)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        elif username =3D=3D &#39;googleext&=
#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            aw=
ait self=2Esend_pending_auth(client, kid, &quot;WEB_AUTH:external:https://w=
ww=2Egoogle=2Ecom/search?q=3Dexternal&quot;)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            await asyncio=2Esleep(10)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            await self=2Esend_cl=
ient_auth(client, kid)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        elif username =3D=3D &#39;google&#39;:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            await self=2Esend_pending_auth(cl=
ient, kid, &quot;WEB_AUTH::https://www=2Egoogle=2Ecom/search?q=3Dexternal&q=
uot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            aw=
ait asyncio=2Esleep(10)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            await self=2Esend_client_auth(client, kid)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        elif username =3D=3D &#39;sp=
ecial&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    extra =3D f&quot;CR_TEXT:E:This special username is known, doing nothin=
g, really&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        await self=2Esend_pending_auth(client, kid, extra)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        elif username in [&#39;dnsse=
c&#39;, &#39;nodns&#39;, &#39;dnssecfb&#39;, &#39;dnsdhcp&#39;, &#39;dnspor=
t&#39;, &#39;default&#39;]:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            await asyncio=2Esleep(1)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            await self=2Esend_client_auth(client, =
kid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        elif us=
ername =3D=3D &quot;notify&quot;:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            await self=2Esend_pending_auth(client, kid,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
                &quot;NOTIFY::Please wait for 23s to let the server think i=
f it want to admit you&quot;)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            await asyncio=2Esleep(23)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            await self=2Esend_client_auth(clien=
t, kid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            await =
self=2Edeny_client(client, kid,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                   f&quot;The username you used=
 ({username}) is unknown, please pick one that I know&quot;)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    async def send_client_auth(self, client: ServerDe=
moConnectedClient, kid: int) -&gt; None:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        username =3D client=2Eenv=2Eget(&quot;username=
&quot;, &quot;(empty username)&quot;)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       config =3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if username =3D=3D &#39;dnssec&#39;:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            config +=3D &quot;&quot;&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            push=
 &quot;dns server 7 address 8=2E8=2E8=2E8:53&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            push &quot;dns server 7 dnssec y=
es&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        elif username =3D=3D &#39;nodns&#39;:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            pass</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        elif username =3D=3D &#39;dnssecfb&#39;:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            config +=3D=
 &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            push &quot;dns server 7 address 8=2E8=2E8=2E8:53&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            push &quot;dns s=
erver 7 dnssec yes&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            push &quot;dns server 10 address 8=2E8=2E8=2E8&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            push &quot;dn=
s server 10 transport DoT&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            push &quot;dns server 12 address 8=2E8=2E8=2E8&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            push &=
quot;dns server 12 transport DoH&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            push &quot;dns server 19 address 8=2E8=2E8=
=2E8:53&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        elif username =3D=3D &#39;dnsdhcp&#39;:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            config +=3D &quot;&quot;&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            push &=
quot;dns server 19 address 8=2E8=2E8=2E8:53&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            push &quot;dhcp-options dns serve=
r 1=2E1=2E1=2E1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        elif username =3D=3D &#39;dnsport&#39;:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            config +=3D &quot;&quo=
t;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 push &quot;dns server 20 address 8=2E8=2E8=2E8:5353&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            &quot;&quot;&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        elif username =3D=
=3D &#39;default&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            config +=3D &quot;&quot;&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            push &quot;dns server 19 address 8=2E=
8=2E8=2E8:53&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           push &quot;dhcp-options dns server 1=2E1=2E1=2E1&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            push &quot;redire=
ct-gateway def1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if not config:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         await self=2Equeue_command(f&quot;client-auth-nt {client=2Ecid} {k=
id}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        e=
lse:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            awa=
it self=2Equeue_command(f&quot;client-auth {client=2Ecid} {kid}\n{config}\n=
END\n&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    async def send_pending=
_auth(self, client: ServerDemoConnectedClient, kid: int, extra: str,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
      timeout: int =3D 180) -&gt; None:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        auth_pending_totp_cmd =3D f&#39;client-pending-=
auth {client=2Ecid} {kid} &quot;{openvpn_escape(extra)}&quot; {timeout}&#39=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        await self=
=2Equeue_command(auth_pending_totp_cmd)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    def client_event_CR_RESPONSE(self, client: ServerDemoConnectedClient, =
kid: int, env: Dict, extra: str) -&gt; None:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        client=2Eenv =3D env</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        self=2Eadd_background_task(self=
=2Eclient_crresponse(client, kid, extra))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    @staticmethod</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    def get_current_totp_code() -&gt; str:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        try:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            import pyotp</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        except ImportError:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            return &quot;pyotp not found&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        totp =3D pyotp=2ETOTP(totp_se=
cret)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return=
 totp=2Enow()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    async def client_crre=
sponse(self, client: ServerDemoConnectedClient, kid: int, response: str) -&=
gt; None:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # =
Try importing the pyotp here to allow the script run without pyotp</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        # installed</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        try:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            import pyotp</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        except ImportError:</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            await self=
=2Edeny_client(client, kid, &quot;pytop module not found=2E Cannot do MFA t=
esting&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        try:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            response =3D standard=
_b64decode(response)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            response =3D response=2Edecode()=2Estrip()</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        except Exception as e:</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            await self=2Eden=
y_client(client, kid, f&quot;Decoding totp response failed: {e}&quot;)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            return</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        totp =3D pyotp=2ETOTP(totp_secret)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        logger=2Einfo(f&quot;\nCR: expec=
ted totp &#39;{totp=2Enow()}&#39;, response was &#39;{response}&#39;\n&quot=
;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # Check i=
f the code is valid (and also allow code +/-1)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if totp=2Everify(response, valid_window=3D1):</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            await self=2Esend_cli=
ent_auth(client, kid)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        else:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        await self=2Edeny_client(client, kid, &quot;TOTP verification faile=
d&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+async def main(connect_data: ConnectData):</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    transport, protocol, f=
inish_future =3D await start_management_protocol(connect_data, ServerDemoPr=
otocol)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    management_version =3D awai=
t protocol=2Emanagement_ready()</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    logger=2Einfo(f&quot;Management interface version: {managem=
ent_version}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    await protocol=
=2Eenable_log()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    await protocol=2Ese=
t_bytecount_interval(5)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    await finis=
h_future</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+if __name__ =3D=3D &#39;__main__&#39;:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    run_main(main)</span><br><=
span>diff --git a/sample/management/omi_server_protocol=2Epy b/sample/manag=
ement/omi_server_protocol=2Epy</span><br><span>new file mode 100644</span><=
br><span>index 0000000=2E=2Ece84bbe</span><br><span>--- /dev/null</span><br=
><span>+++ b/sample/management/omi_server_protocol=2Epy</span><br><span>@@ =
-0,0 +1,239 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#!/us=
r/bin/env python3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
Copyright (c) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+# Copyright (c) 2026 Arne Schwabe &l=
t;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Permission =
is hereby granted, free of charge, to any person obtaining a copy</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# of this software and associ=
ated documentation files (the &quot;Software&quot;), to deal</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# in the Software without restrict=
ion, including without limitation the rights</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+# to use, copy, modify, merge, publish, distribute=
, sublicense, and/or sell</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+# copies of the Software, and to permit persons to whom the Software =
is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# furnished to do=
 so, subject to the following conditions:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# The above copyright notice and this permission notice shall be includ=
ed in all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# copies o=
r substantial portions of the Software=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY K=
IND, EXPRESS OR</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# IM=
PLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+# FITNESS FOR A PARTICUL=
AR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+# AUTHORS OR COPYRIGHT HOLDERS BE LIABL=
E FOR ANY CLAIM, DAMAGES OR OTHER</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERW=
ISE, ARISING FROM,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN =
THE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# SOFTWARE=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+import asyncio</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+import base64</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+import logging</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+from asyncio import Future</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+from dataclasses import dataclass, field</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+from typing import List, Tupl=
e, Dict, Optional</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+from omi import OmiPr=
otocol, ConnectionProperties, OmiCommandResult</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+logger =3D logging=2EgetLogger(__name__)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+logger=2EsetLevel(logging=2EINFO)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+@dataclass</span><br><span style=3D"color: hsl(120, 100%, 40%);">+clas=
s ConnectedClient:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   &quot;&quot;&quot;This represents a connected client instance=2E&quot;&q=
uot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cid: =
int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bytes_sent: =
int =3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bytes_=
received: int =3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    _partial_acc_msg: bytes =3D b&quot;&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    _protocol_acc_msg: str =3D &quot;&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    _kid_acc_msg: int =3D=
 -1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    _acc_fragmen=
t_length: int =3D 980</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    acc_negotiated_protocols: List[str] =3D field(default_factory=3Dlist)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+class OMIServerProtocol(OmiProtocol):</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    This class implement common meth=
od for the OMI when OpenVPN is running</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    as a server=2E These are mainly helper function and =
functionality that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   is only available/useful for OpenVPN running as a server</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    # Connected client class, can be overridden by =
subclasses to store</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    # more information about the connected client</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    _connected_client_class =3D ConnectedClie=
nt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    def __init__(self, finish_future=
: Future, connect_data: ConnectionProperties):</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        super()=2E__init__(finish_future, connec=
t_data)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=
=2E_reset_pending_client_event()</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        self=2E_connected_clients: Dict =3D {}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    def _reset_pending_client_event(self) -&gt; None:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_pend=
ing_client_event: str =3D &quot;&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        self=2E_pending_client_event_cid: int =3D -1</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_pending=
_client_event_kid: int =3D -1</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        self=2E_pending_client_event_extra_args: str =3D None</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_client_=
env: Dict =3D {}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    def recv_notify_CL=
IENT(self, args: str) -&gt; None:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        event, args =3D args=2Esplit(&quot;,&quot;, 1)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if event =3D=3D &quot;ENV&quot;:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            if args =3D=
=3D &quot;END&quot;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                # Client environment is finished, trigger previous client<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                # ev=
ent that contained an ENV</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                self=2E_trigger_client_event(self=2E_pending_client_e=
vent, self=2E_pending_client_event_cid,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                           self=2E_pend=
ing_client_event_kid, self=2E_client_env,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                           self=2E_pe=
nding_client_event_extra_args)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                self=2E_reset_pending_client_event()</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            else:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                key, value =3D ar=
gs=2Esplit(&quot;=3D&quot;, 1)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                self=2E_client_env[key] =3D value</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        elif event in (&quot;ESTABLISHED&quot;, &quot=
;DISCONNECT&quot;):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            # This event is followed by a client environment=2E Wait for</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            # the clie=
nt environment to be completed before triggering the event</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            cid =3D int(args)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            self=2E_pending_client_event =3D =
event</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            se=
lf=2E_pending_client_event_cid =3D int(cid)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            self=2E_pending_client_event_kid =3D No=
ne</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if ev=
ent =3D=3D &quot;ESTABLISHED&quot;:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                self=2E_add_client(cid)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        elif event in (&quot;CONNECT&quot;, &quot;REAUTH&q=
uot;):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            #=
 This event is similar to other event but also carries the key-id</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            cid, kid =3D args=
=2Esplit(&quot;,&quot;, 1)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            cid, kid =3D int(cid), int(kid)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            self=2E_add_client(cid)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            self=2E_pending_client_event =3D ev=
ent</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            self=
=2E_pending_client_event_cid =3D int(cid)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            self=2E_pending_client_event_kid =3D int(=
kid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        elif ev=
ent =3D=3D &quot;CR_RESPONSE&quot;:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            # This event is similar to CONNECT and REAUTH b=
ut has an extra</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        # parameter with the crtext response</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            cid, kid, response =3D args=2Esplit(&q=
uot;,&quot;, 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        cid, kid =3D int(cid), int(kid)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            self=2E_pending_client_event =3D event</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            self=2E_pending_client_event_=
cid =3D int(cid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         self=2E_pending_client_event_kid =3D int(kid)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            self=2E_pending_client_event=
_extra_args =3D response</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        elif event =3D=3D &quot;ACC&quot;:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            cid, kid, acc_args =3D args=2Esplit=
(&quot;,&quot;, 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           self=2E_trigger_client_event(event, int(cid), int(kid), None, ac=
c_args)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        elif=
 event =3D=3D &quot;ADDRESS&quot;:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            # &gt;CLIENT:ADDRESS,{CID},{ADDR},{PRI}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            cid, extra =3D a=
rgs=2Esplit(&quot;,&quot;, 1)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            self=2E_trigger_client_event(event, int(cid), -1, Non=
e, extra)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        el=
se:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            logg=
er=2Einfo(f&quot;Client event {event} not handled=2E (message: {args!r})&qu=
ot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    def client_event_ACC(self, cli=
ent: ConnectedClient, kid: int, env: Dict, extra: str) -&gt; None:</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        protocol, fragment, =
b64msg =3D extra=2Esplit(&quot;,&quot;, 2)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if client=2E_partial_acc_msg and client=2E_protocol_acc_msg !=
=3D protocol:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      logger=2Eerror(f&quot;Recieved ACC message with protocol {protocol} b=
efore &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                  f&quot;previous ACC message with protocol {client=2E_prot=
ocol_acc_msg} was complete&quot;)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            client=2E_partial_acc_msg =3D b&quot;&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if client=2E_partial_acc_msg and cli=
ent=2E_kid_acc_msg !=3D kid:</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            logger=2Eerror(f&quot;Recieved ACC message with differ=
ent key id {kid} before &quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                         f&quot;previous ACC message with key id=
 {client=2E_kid_acc_msg} &quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                         f&quot;was complete=2E This is current=
ly not handled&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            client=2E_partial_acc_msg =3D b&quot;&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        try:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            msg =3D base64=2Edecodebytes(b64msg=2Eencode())</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            client=2E_p=
artial_acc_msg +=3D msg</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            client=2E_protocol_acc_msg =3D protocol</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            client=2E_kid_acc_msg =3D k=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            # Message is not yet com=
plete=2E Wait for more fragments=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            if fragment !=3D &quot;0&quot;:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                return</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            handler_name =3D f&quot;receive_acc_cli=
ent_{protocol}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            if not self=2Edispatch_to_handler(handler_name, client, kid, c=
lient=2E_partial_acc_msg):</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                logger=2Einfo(f&quot;Received unhandled ACC protocol=
: {protocol}, handler {handler_name} not found&quot;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            client=2E_partial_acc_msg =3D b&quot;&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            client=2E_pr=
otocol_acc_msg =3D protocol</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        exc=
ept Exception as e:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            logger=2Eerror(f&quot;Error parsing ACC message from client: {e=
}&quot;, exc_info=3DTrue)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        clien=
t=2E_partial_acc_msg =3D b&quot;&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    def recv_notify_BYTECOUNT_CLI(self, args: str) -&gt; None:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        cid, bytes_received, byt=
es_sent =3D args=2Esplit(&quot;,&quot;, 2)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        client =3D self=2E_connected_clients=2Eget(int(cid))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if client:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            client=2Ebytes_sent=
 =3D int(bytes_sent)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            client=2Ebytes_received =3D int(bytes_received)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    def _trigger_client_event(self, event: str, cid: =
int, kid: int, env: Optional[Dict], extra):</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        client =3D self=2E_connected_clients=2Eget(=
cid, None)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        # Remember ACC proto=
col options if present</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if event =3D=3D &quot;CONNECT&quot; and &quot;acc_protocols&quot=
; in env:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  client=2Eacc_negotiated_protocols =3D [p=2Estrip() for p in env[&quot;acc=
_protocols&quot;]=2Esplit(&quot;:&quot;)]</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            client=2E_acc_fragment_length =3D int(env=
[&#39;acc_message_len&#39;])</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ha=
ndler_name =3D f&quot;client_event_{event}&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if not self=2Edispatch_to_handler(hand=
ler_name, client, kid, env, extra):</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            logger=2Einfo(f&quot;Client event {event} not h=
andled=2E Method {handler_name} does not exist=2E&quot;)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    def _add_client(self, cid: int) -&gt; None:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if not cid in self=2E=
_connected_clients:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            self=2E_connected_clients[cid] =3D self=2E_connected_client_cla=
ss(cid=3Dcid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    def _remove_client(se=
lf, cid: int) -&gt; bool:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if cid in self=2E_connected_clients:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            del self=2E_connected_clients[ci=
d]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retur=
n True</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return =
False</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    async def get_client_status(s=
elf) -&gt; OmiCommandResult:</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmd_result =3D self=2Equeue_command(&quot;status 3&quot;)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return await=
 cmd_result</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    async def send_acc_msg(=
self, client: ConnectedClient, kid: int, protocol: str, msg: bytes) -&gt; N=
one:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;&=
quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
Sends out an ACC to the client=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        &quot;&quot;&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if protocol not in client=2Eacc_negotiated_pro=
tocols:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
logger=2Eerror(f&quot;Error: trying to send ACC message with protocol&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
      f&quot; {protocol} is not in the negotiated list of &quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                         f&quo=
t;protocols ({client=2Eacc_negotiated_protocols})&quot;)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            return</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        # See init=2Ec for the explanation for the length<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        max_header_s=
ize =3D len(&quot;ACC,&quot;) + len(protocol) + 1 + 4 + 1 + 2 + 1</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        # calculate fragment size with base64 en=
coding</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fragm=
ent_length =3D client=2E_acc_fragment_length * 6 // 8 - max_header_size</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        commands =3D []</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        for part_start in range(0, le=
n(msg), fragment_length):</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m=
sg_part =3D msg[part_start:part_start + fragment_length]</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            # This creates a multiline=
 base64 message but that is what</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            # we want for the management interface to have a n=
ot overlong</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    # lines</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    b64msg =3D base64=2Eencodebytes(msg_part)=2Edecode()</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            flags =3D &quot;6&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if part_start + fragment_leng=
th &lt; len(msg):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              flags +=3D &quot;F&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            commands=2Eappend(f&quot;client-acc-msg {client=2Ecid} {kid}\n{=
protocol}\n{flags}\n{b64msg}\nEND&quot;)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        cmd_futures =3D []</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        for command in commands:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            cmd_futures=2Eappend(self=2Equeue_command=
(command))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        cmd_results: Tuple[O=
miCommandResult] =3D await asyncio=2Egather(*cmd_futures)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        for cmd_result in cmd_results=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if cmd=
_result=2Eerror:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             logger=2Eerror(f&quot;Error: sending ACC message failed: {cmd_=
result}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    def client_event_DIS=
CONNECT(self, client: ConnectedClient, kid: int, _env: dict, _extra: str):<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_remo=
ve_client(client=2Ecid)</span><br><span>diff --git a/sample/management/omi_=
tools=2Epy b/sample/management/omi_tools=2Epy</span><br><span>new file mode=
 100644</span><br><span>index 0000000=2E=2E28cf5ba</span><br><span>--- /dev=
/null</span><br><span>+++ b/sample/management/omi_tools=2Epy</span><br><spa=
n>@@ -0,0 +1,92 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
! /usr/bin/python3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
 Copyright (c) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+# Copyright (c) 2026 Arne Schwabe &=
lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Permission=
 is hereby granted, free of charge, to any person obtaining a copy</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# of this software and assoc=
iated documentation files (the &quot;Software&quot;), to deal</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+# in the Software without restric=
tion, including without limitation the rights</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+# to use, copy, modify, merge, publish, distribut=
e, sublicense, and/or sell</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+# copies of the Software, and to permit persons to whom the Software=
 is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# furnished to d=
o so, subject to the following conditions:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+# The above copyright notice and this permission notice shall be inclu=
ded in all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# copies =
or substantial portions of the Software=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+# THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY =
KIND, EXPRESS OR</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# I=
MPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+# FITNESS FOR A PARTICU=
LAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+# AUTHORS OR COPYRIGHT HOLDERS BE LIAB=
LE FOR ANY CLAIM, DAMAGES OR OTHER</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHER=
WISE, ARISING FROM,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN=
 THE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# SOFTWARE=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+import asyncio</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+import os</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+import re</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+from dataclasses import dataclass</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+from omi import OmiProtocol, ConnectionProperties</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+@dataclass</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+class ConnectData(ConnectionProperties):</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    socket: str</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn_escape=
_re =3D re=2Ecompile(r&#39;([&quot;\\])&#39;)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+filt_ctrl_re =3D re=2Ecompile(r&quot;[\x00-\x1f\x=
7f]+&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+def openvpn_escape(text:str) -&gt; str :</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;Esc=
apes a string to be safely used for OpenVPN inside</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    a quoted string</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    Something like &#39;client-deny 2 3 &quot;{openvpn_escape(r=
eason)}&quot; &quot;{openvpn_escape(client_reason)}&quot;&#39;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    text =3D re=2Esub(filt_ct=
rl_re, &#39; &#39;, text)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    text =3D re=2Esub(openvpn_escape_re, r&#39;\\\1&#39;, text)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return text=2Erstrip(=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+def get_unix_script_environment() -&gt; ConnectData | No=
ne:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    password =3D=
 os=2Eenviron=2Eget(&quot;MANAGEMENT_PASSWORD&quot;, None)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    socket =3D os=2Eenviron=2Eget(&q=
uot;MANAGEMENT_SOCKET&quot;, None)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if password and socket:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return ConnectData(password=3Dpassword, socket=3Dsocket)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    else:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return None</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+async def start_management_protocol(connect_data: ConnectData, protocol: O=
miProtocol):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # G=
et a reference to the event loop as we plan to use</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    # low-level APIs=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    loop =3D asyncio=2Eget_running_loop(=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    finish_future =3D loop=2Ecreate_f=
uture()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    print(f&quot;Connecting to =
management socket {connect_data=2Esocket}=2E=2E=2E&quot;)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    transport, protocol =3D await loo=
p=2Ecreate_unix_connection(lambda: protocol(finish_future, connect_data),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
                                       connect_data=2Esocket)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return transport, protocol, finish_future</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+def run_main(main_func, connect_parameters: ConnectData =3D None=
):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Example fu=
nction to run a main function to be either using the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    environment variable for the unix-scr=
ipt or to use=2E If the unix-script</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    environment are detected, the function will run the mai=
n_func</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    with the =
ConnectData from the environment=2E If the environment variables</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    are not available, it will=
 fall back to the connect_parameters</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if present=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    :param connect_parameters:  fallback connect parameters =
if unix-script is not available</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    :param main_func:           The function to call=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    :return:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    unix_script_parameters =3D =
get_unix_script_environment()</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if unix_script_parameters:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        asyncio=2Erun(main_func(unix_script_parameters=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    elif connect_=
parameters:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
asyncio=2Erun(main_func(connect_parameters))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    else:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        print(f&quot;Must be called via unix-script&quot;)</=
span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1859?usp=3Demail">change 1859</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: Ib09bafabf612e9501ea757647c86a4=
50c73228a5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1859 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D=
"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: Name of user not set #100=
0061 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openv=
pn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> =
Gerrit-Attention: Name of user not set #1000061 </div>

</body></html>
--KcpI/gdQG3k=--


--===============7664305293515466163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7664305293515466163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7664305293515466163==--

