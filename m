Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C5B606A329
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=I/42mISa;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JCK46t35;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fnQHpO4u;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cGBp4J/1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ocDTPuhM0foBn/8EmM8/1dFTquXxrItjdc5dOtyRUA8=; b=I/42mISaD63HfB8PIgLx3AKuhK
	zMbd/FnGIkyHQSMgXkh47dggUHM9kijz0S6ZK5uZcCc6OUiaKfA65ScnrM9LxUI1NJ8eDMkg/ozi9
	t21RANR05O1ikVwIoX17DiWZiNlTtLXq7EHiVCaU+2iYeUGxehx9O0NbyXkDjBRk6v8o=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOJ9W-000000001dI-286I;
	Tue, 03 Nov 2026 18:22:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOJ9V-000000001d6-1YZX
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 18:22:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0RGQabvYwfCHkGjGisdNScEuKT0AyPyrGOzR64iaSnE=; b=JCK46t35xPRC1Ze7lNtSViVxwA
 Q+sYlrz5g55K4YW8U3yXjtGmI9ml/PcqpGnIOsFpQs9COh2uQ1M6fuAO43it7zBvGEXGzFyo/YSUd
 pIGctglaiCuA4WgMw7ywQLNPve19gg0KegI746h89A5rX/EyejGoQWo/PZW4f21toeNo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0RGQabvYwfCHkGjGisdNScEuKT0AyPyrGOzR64iaSnE=; b=fnQHpO4uV+2qFZ14FEBDJ6Ne/w
 X2iJLNVe0rP0CSgoVtGSrS8POOE9+0mPzgm3ScLunNwvIy71l/S92UVON1wbX2rjJPQt1BD8/J3Cp
 Baie7dVx7mvAdscCkoS0iDtL5YiEBo1SgsmUPy9Ok4VgP7xWRPUK+XVamN58tZHwFnyQ=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOJ9N-000000002jj-2F5x for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 18:22:33 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so47974565e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 10:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793730139; x=1794334939; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0RGQabvYwfCHkGjGisdNScEuKT0AyPyrGOzR64iaSnE=;
 b=cGBp4J/1RjGZliixEz+iunF34ozaqhd4RRkbJGLYEpqsyJKdnCNEqE/mYQbkk0KxM1
 10h5V+Izzsx4ZEtbcmkOy/AwPdyM2+559UaBxxHV+/YUCHGDGGvXVR8ALrNCWVMOhG63
 Y0I+wUa7oyGZ64rt8xG3jMtS2SxI5VbC28b/QS1BDkuiGmyS7A408HZ8oh9vuzOC1UWn
 lEtjZY6CquOA/CymBLH5z3Ew4rEvBV0r2DCHcm3Bb2wstUGdMVYYyOoqTDCucY5Ufq2e
 d3ATIUfjjVx0LmaPxHuLZTV+pjcm84L9spVaGdsWKK5PcPQ0AeGawZFV8ZBgbzaZMl8t
 4m6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793730139; x=1794334939;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0RGQabvYwfCHkGjGisdNScEuKT0AyPyrGOzR64iaSnE=;
 b=SdaYvZvnhhVDCSp/a87WPdP5vLjd+nl7ZVcUF7TbZzPv/NHXtlWGPEFAIwQSVUsDwk
 z/4DpClGiRNZvCPHjyikXQvnePJRuFsPdtDYDs/6niEkOo57dn2Q1QPaEnvPUWdDX//B
 2NPKcYA+n+ZR9Hi/XqonjaG46Q0J6OMKvwRYdrk6KDKfWQmXUlkh7kDfea27ePjyVGEW
 ogmN5s3gVeqr/KEm6KKitBUrlcxUd4yoOQuY7jSWZiysiEGnKIMJKrIaQrMwdEhSTSRg
 ow8KYWUQkj69LyUTOySshzjYo6A0z96Afp7aK4I6c2Ddl9n94n3JGGRcUVPxzJC8uI0C
 TcVQ==
X-Gm-Message-State: APuU4Z+xlJhYnDa7b2Tzg9HM2maatT6AsvgiwnASlM9qc1sRUS3aVEH1
 hnrXb0x0Vk81WZr+hYWJp4fNjUUvqcunQ4TWzpGuArt4Hi8Uz8Lxxbdlt7XJkurBaYfd7ZNpwYn
 nqyW1iqKgPiCbtmP2rurbYY6Y7O9tnmNTBlYUdfk+mRA2s3CZFDYFLqbgvlWmqaYmvJrAqD3gNW
 C9vsPAnQ==
X-Gm-Gg: AYBFou2C9VevUUQrxf2nNDiTcWrMqTWtvxdmeYgJ4j+DHLG6t52RWJ2OIFcdGndi5z5
 i60wIM29xdGLou8NIf2v8Zr9CCPUg8ldkyDeZeSUC1e9j9DLIuQMJscyJggYj9YDeb2Zg21r7KY
 tJb6nq7vk0Q83ZkzhlWmu/Iv1BMoCzviZRqwseONOrKH0TgJCiUBzRcMiX3UNlT+4+ur4E3RILt
 boCSJAFPwf41TbuyiiucUqrGBdpNlsrP0Jni/PLvXbtw3E0zo6i6KfwBaseBLIUbVJIhGX6jIC2
 IGENbivERpWVB+ojxbRqOGaymnTNyNvVQpd68TAyq85vXnXUZZgiIglglEnmKMIKBXz7wRUlJeH
 GXXbDv8a3+5RnzBnlHXxXZeWAr03lZHZ9BksCsMou9wmJz5fmXrsrVhaaWDGiOkV8RQhxll6xmC
 /QStFuadg20gDklEI+qShnF9s6d0LKWSGYsY/cnWXs9LPY6H0gBdfnDVycYhWH29isA4b14Wdvx
 bKGnI1zPdflcpfpfPPcGL6AE5dnBaDNFxoOHETIZcDXmGCMJrARKGrq3L/wO6sjdka+CelyywmG
 GCZKO4jI5OJOLgpcqiq91c9KRNUdFL94k49MizkSXtlToSJMp3vpejjYZG+80munyB4nlG/xjYa
 zS7RMQCguFJ3mQPCZolN8Tow0f3V3bqUT9jRC7kHMs5T40DhD6NN2K3sk0Wmd+Tq7vE1KF0sW2b
 MrJiRPfdANA2X7uA==
X-Received: by 2002:a05:600c:628d:b0:4a1:f7f4:7ced with SMTP id
 5b1f17b1804b1-4ac185bd243mr321656685e9.17.1793730137919; 
 Tue, 03 Nov 2026 10:22:17 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a98e8f9fsm83901425e9.13.2026.11.03.10.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 10:22:17 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 18:22:15 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5
X-Gerrit-Change-Number: 1859
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1859?usp=email>
X-Gerrit-Commit: 5dd2d2b580e2e623384cc48c9afb28f83e1bfd92
In-Reply-To: <gerrit.1787327336000.Ib09bafabf612e9501ea757647c86a450c73228a5@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ib09bafabf612e9501ea757647c86a450c73228a5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkliMDliYWZhYmY2MTJlOTUwMWVhNzU3NjQ3Yzg2YTQ1MGM3MzIyOGE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <324a5b6db3367e6072c603cd54c0c5292c5ed00f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOJ9N-000000002jj-2F5x
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
Content-Type: multipart/mixed; boundary="===============5994650086397493963=="
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_HTML_MOSTLY,MISSING_HEADERS,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5994650086397493963==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1N9nrIP8DTE="; charset=UTF-8

--1N9nrIP8DTE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Name of user not set #1000061=2E

Arn=
e Schwabe has uploaded a new patch set (#8)=2E ( https://gerrit=2Eopenvpn=
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
nt/omi=2Epy
A sample/management/omi_client_protocol=2Epy
A sample/managemen=
t/omi_server_demo=2Epy
A sample/management/omi_server_protocol=2Epy
A sampl=
e/management/omi_tools=2Epy
5 files changed, 1,091 insertions(+), 0 deletio=
ns(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
59/1859/8

diff --git a/sample/management/omi=2Epy b/sample/management/omi=
=2Epy
new file mode 100644
index 0000000=2E=2E196329b
--- /dev/null
+++ b/s=
ample/management/omi=2Epy
@@ -0,0 +1,317 @@
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
+# This is an example implementati=
on in python and asyncio to drive OpenVPN's
+# management interface (OMI)=
=2E The permissive license allows you to use this
+# code in other projects=
=2E
+
+"""
+Implementation of the OpenVPN management interface (OMI) protoc=
ol=2E
+
+This implements the generic part of the OMI protocol that is commo=
n
+to both client and server=2E
+"""
+import asyncio
+import logging
+impor=
t re
+from asyncio import Future, Event, Task, Queue
+from dataclasses impo=
rt dataclass
+from datetime import datetime
+from typing import override, L=
ist, Optional
+
+OMI_PASSWORD_PROMPT =3D "ENTER PASSWORD:"
+
+logger =3D lo=
gging=2EgetLogger(__name__)
+logger=2EsetLevel(logging=2EINFO)
+
+
+@datacl=
ass
+class OmiCommandResult:
+    command: str
+    result: List[str]
+    =
error: bool
+    status_text: str
+
+
+@dataclass
+class OmiSendCommand:
+ =
   command: str
+    result: Future[OmiCommandResult]
+
+
+@dataclass
+clas=
s ConnectionProperties:
+    """
+    Properties for connecting to the mana=
gement interface=2E
+    """
+    password: Optional[str]
+
+
+class OmiPro=
tocol(asyncio=2EProtocol):
+    def __init__(self, finish_future: Future, c=
onnect_data: ConnectionProperties):
+        super()=2E__init__()
+        =
self=2E_connect_data: ConnectionProperties =3D connect_data
+
+        self=
=2Ebytes_received: int =3D 0
+        self=2Ebytes_sent: int =3D 0
+       =
 self=2Eversion: int =3D -1
+        self=2ErecvBuffer: str =3D ""
+       =
 self=2Efinish_future: Future =3D finish_future
+        self=2Etransport: =
Optional[asyncio=2ETransport] =3D None
+
+        # Event to allow waiting =
for status of the underlying socket
+        # to become available for writ=
ing
+        self=2E_can_send: Event =3D asyncio=2EEvent()
+        self=2E=
_can_send=2Eclear()
+
+        # Event to track when the management interfa=
ce is ready to receive
+        # commands from us
+        self=2E_managem=
ent_ready: Event =3D asyncio=2EEvent()
+        self=2E_management_ready=2E=
clear()
+        self=2E_response =3D []
+
+        self=2E_response_ready:=
 Event =3D asyncio=2EEvent()
+        self=2E_response_ready=2Eclear()
+
+ =
       self=2E_send_queue: Queue =3D asyncio=2EQueue()
+        self=2E_sen=
d_task: Task =3D asyncio=2Ecreate_task(self=2E_send_loop())
+
+    @overrid=
e
+    def eof_received(self) -> None:
+        logger=2Einfo('EOF received=
=2E Shutting down=2E')
+        self=2E_stop()
+
+    @override
+    def co=
nnection_lost(self, exc: Exception | None) -> None:
+        if exc:
+     =
       logger=2Ewarn(f'Connection lost ({exc})=2E Shutting down=2E')
+     =
   else:
+            logger=2Ewarn(f'Connection lost=2E Shutting down=2E')=

+        self=2E_stop()
+
+    def _stop(self) -> None:
+        if not se=
lf=2Efinish_future=2Edone():
+            # If we are disconnected or stop,=
 there is no sense trying
+            # to still send commands to the mana=
gement interface
+            self=2E_send_task=2Ecancel()
+            sel=
f=2Efinish_future=2Eset_result(True)
+
+    async def _send_loop(self) -> N=
one:
+        while True:
+            command: OmiSendCommand =3D await se=
lf=2E_send_queue=2Eget()
+            await self=2E_can_send=2Ewait()
+    =
        self=2Esend_line(command=2Ecommand)
+
+            response: List[s=
tr] =3D []
+            response_complete =3D False
+
+            # This i=
s a bit brittle as it will loop forever if not getting a
+            # lin=
e that starts with ERROR or SUCCESS=2E With a normal OpenVPN
+            #=
 daemon that speak the correct protocol this should not be a
+            #=
 problem
+            while not response_complete:
+                await s=
elf=2E_response_ready=2Ewait()
+
+                line =3D self=2E_response=
=2Epop(0)
+                response=2Eappend(line)
+
+                if no=
t self=2E_response:
+                    self=2E_response_ready=2Eclear()
+=

+                lastline =3D response[-1]
+                print(lastline=
)
+                if lastline=2Estartswith('ERROR: '):
+                  =
  error =3D True
+                    response_complete =3D True
+         =
           _, status_text =3D lastline=2Esplit(": ", 1)
+
+                =
elif lastline=2Estartswith('SUCCESS: '):
+                    error =3D Fal=
se
+                    response_complete =3D True
+                    _, =
status_text =3D lastline=2Esplit(": ", 1)
+                elif lastline =
=3D=3D "END":
+                    error =3D False
+                    res=
ponse_complete =3D True
+                    status_text =3D None
+        =
        else:
+                    # Other lines do not complete a response=

+                    pass
+
+            # logger=2Edebug(f'Result receive=
d command: {response}')
+            result =3D OmiCommandResult(command=2E=
command, response[:-1], error, status_text)
+
+            command=2Eresult=
=2Eset_result(result)
+            logger=2Edebug(f"Command done=2E")
+
+  =
  @override
+    def pause_writing(self) -> None:
+        self=2E_can_send=
=2Eclear()
+
+    @override
+    def resume_writing(self) -> None:
+       =
 self=2E_can_send=2Eset()
+
+    @override
+    def connection_made(self, t=
ransport) -> None:
+        peername =3D transport=2Eget_extra_info('peerna=
me')
+        logger=2Einfo('Connection from {}'=2Eformat(peername))
+     =
   self=2Etransport =3D transport
+        self=2E_can_send=2Eset()
+
+    =
def _check_pw_response(self, fut: Future[OmiCommandResult]) -> None:
+     =
   if fut=2Eexception():
+            logger=2Eerror(f"Error authenticating=
 with password: {fut=2Eexception()}")
+            self=2Etransport=2Eclose=
()
+            return
+
+        result =3D fut=2Eresult()
+
+        if r=
esult=2Eerror or result=2Estatus_text !=3D "password is correct":
+        =
    logger=2Eerror(f"Received unexpected status after trying to authenticat=
e: {result=2Estatus_text!r}")
+            self=2Etransport=2Eclose()
+    =
        return
+
+    def handle_password_prompt(self) -> None:
+        # =
OMI expects us to authenticate with the password just on
+        # its own=
 on a line
+        if self=2E_connect_data=2Epassword:
+            fut =
=3D self=2Equeue_command(f"{self=2E_connect_data=2Epassword}")
+           =
 fut=2Eadd_done_callback(self=2E_check_pw_response)
+        else:
+       =
     logger=2Eerror("No password provided for authentication")
+           =
 self=2Etransport=2Eclose()
+
+    @override
+    def data_received(self, d=
ata: bytes) -> None:
+        # OMI protocol is pure text so decode everyth=
ing as UTF-8
+        message =3D data=2Edecode()
+        self=2ErecvBuffe=
r +=3D message
+
+        # Management protocol does not add a newline afte=
r the password prompt
+        if not self=2E_management_ready=2Eis_set() a=
nd self=2ErecvBuffer=2Estartswith(OMI_PASSWORD_PROMPT):
+            logger=
=2Edebug(f"Received password prompt")
+            self=2ErecvBuffer =3D se=
lf=2ErecvBuffer[len(OMI_PASSWORD_PROMPT) + 1:]
+            self=2Ehandle_p=
assword_prompt()
+            return
+
+        parts =3D self=2ErecvBuffer=
=2Esplit("\r\n")
+
+        # pass complete lines to recvLine
+        for =
part in parts[:-1]:
+            logger=2Edebug(f'Line received: {part!r}')=

+            self=2Erecv_line(part)
+
+        # keep the last incomplete =
line for the next call
+        self=2ErecvBuffer =3D parts[-1]
+
+    def =
recv_line(self, line: str) -> None:
+        if line=2Estartswith(">"):
+  =
          # this is an asynchronous message
+            self=2Erecv_notify=
(line)
+        else:
+            # normal message get passed to the _send=
_loop task
+            self=2E_response=2Eappend(line)
+            self=
=2E_response_ready=2Eset()
+
+    def recv_notify(self, line: str) -> None:=

+        if not ":" in line:
+            logger=2Ewarning("Invalid line r=
eceived: " + line)
+            return
+
+        command, args =3D line[1:=
]=2Esplit(":", 1)
+
+        # do dynamic dispatch based on command to call=
 a handler
+        if hasattr(self, f"recv_notify_{command}"):
+          =
  handler =3D getattr(self, f"recv_notify_{command}")
+            handler(=
args)
+            return
+
+        logger=2Einfo("Unknown notify line rec=
eived: " + line)
+
+    def recv_notify_INFO(self, args: str) -> None:
+   =
     m =3D re=2Ematch(r"OpenVPN Management Interface Version (?P<version>\d=
+)", args)
+        if m:
+            self=2Eversion =3D int(m=2Egroup("ve=
rsion"))
+            self=2Equeue_command("version 6")
+            self=
=2E_management_ready=2Eset()
+        else:
+            logger=2Ewarning(f=
"Unknown INFO line received: {args}")
+
+    def recv_notify_BYTECOUNT(self=
, args: str) -> None:
+        bytes_sent, bytes_received =3D args=2Esplit(=
",", 1)
+        self=2Ebytes_sent =3D int(bytes_sent)
+        self=2Ebyte=
s_received =3D int(bytes_received)
+
+    async def _release_hold_task(self=
, hold_time: int =3D 0) -> None:
+        await asyncio=2Esleep(hold_time)
=
+        await self=2Equeue_command("hold release")
+
+    def recv_notify_=
HOLD(self, args):
+        _text, hold_time =3D args=2Esplit(":", 1)
+     =
   hold_time =3D int(hold_time)
+
+        asyncio=2Ecreate_task(self=2E_re=
lease_hold_task(hold_time))
+
+    def queue_command(self, command: str) ->=
 Future[OmiCommandResult]:
+        cmd =3D OmiSendCommand(command, Future(=
))
+        self=2E_send_queue=2Eput_nowait(cmd)
+        return cmd=2Eresu=
lt
+
+    async def management_ready(self) -> int:
+        """
+        Wa=
its until the management interface is ready=2E Returns the management inter=
face version=2E
+        """
+        await self=2E_management_ready=2Ewait=
()
+        return self=2Eversion
+
+    def send_line(self, line: str) -> =
None:
+        logger=2Edebug(f"Sending line: {line}")
+        self=2Etran=
sport=2Ewrite(f"{line}\n"=2Eencode())
+
+    """
+    Set the bytecount int=
erval=2E Use 0 to disable
+    """
+
+    async def set_bytecount_interval(=
self, interval: int):
+        return await self=2Equeue_command(f"bytecoun=
t {interval}")
+
+    async def enable_log(self):
+        return await sel=
f=2Equeue_command("log on")
+
+    def recv_notify_LOG(self, args):
+      =
  # >LOG:1786453401,D,MANAGEMENT: CMD 'bytecount 30'
+        timestamp, le=
vel, message =3D args=2Esplit(",", 2)
+
+        timestamp =3D datetime=2Ef=
romtimestamp(int(timestamp))
+        level =3D level=2Estrip()
+        me=
ssage =3D message=2Estrip()
+        self=2Elog_message(timestamp, level, m=
essage)
+
+    def log_message(self, time, level, message):
+        """
+ =
       A new log message has been received=2E This method is intended
+    =
    to be overridden by a subclass to handle the log messages=2E
+        :=
param time:    time in local time format
+        :param level:   level of =
the log message
+        :param message: the log message itself
+        :r=
eturn:
+        """
+        logger=2Edebug(f"Received log message: {time},=
 {level}, {message}")
diff --git a/sample/management/omi_client_protocol=2E=
py b/sample/management/omi_client_protocol=2Epy
new file mode 100644
index =
0000000=2E=2E6899083
--- /dev/null
+++ b/sample/management/omi_client_proto=
col=2Epy
@@ -0,0 +1,136 @@
+#!/usr/bin/env python3
+# Copyright (c) 2026 Op=
enVPN Inc <sales@openvpn=2Enet>
+# Copyright (c) 2026 Arne Schwabe <arne@rf=
c2549=2Eorg>
+#
+# Permission is hereby granted, free of charge, to any per=
son obtaining a copy
+# of this software and associated documentation files=
 (the "Software"), to deal
+# in the Software without restriction, includin=
g without limitation the rights
+# to use, copy, modify, merge, publish, di=
stribute, sublicense, and/or sell
+# copies of the Software, and to permit =
persons to whom the Software is
+# furnished to do so, subject to the follo=
wing conditions:
+#
+# The above copyright notice and this permission notic=
e shall be included in all
+# copies or substantial portions of the Softwar=
e=2E
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, =
EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCH=
ANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN N=
O EVENT SHALL THE
+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, =
DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OT=
HERWISE, ARISING FROM,
+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE =
USE OR OTHER DEALINGS IN THE
+# SOFTWARE=2E
+import asyncio
+import base64
=
+import logging
+from typing import Tuple
+
+from omi import OmiProtocol, O=
miCommandResult
+
+logger =3D logging=2EgetLogger(__name__)
+logger=2EsetLe=
vel(logging=2EDEBUG)
+
+
+class OMIClientProtocol(OmiProtocol):
+    """
+ =
   Implement the management protocol for the client  
+    """
+
+    def _=
_init__(self, finish_future, connect_data):
+        super()=2E__init__(fin=
ish_future=3Dfinish_future, connect_data=3Dconnect_data)
+        self=2E_p=
artial_acc_msg =3D ""
+        self=2E_protocol_acc_msg =3D ""
+        sel=
f=2E_acc_fragment_length =3D 980
+        self=2E_acc_negotiated_protocols =
=3D []
+
+    async def send_acc_msg(self, protocol: str, msg: bytes):
+   =
     """
+        Sends out an ACC to the server using the specified ACC me=
ssage length
+        :param protocol:
+        :param msg:
+        :param=
 fragment_length:
+        :return:
+        """
+        if protocol not i=
n self=2E_acc_negotiated_protocols:
+            logger=2Eerror(f"Error: tr=
ying to send ACC message with protocol "
+                         f"{proto=
col} is not in the negotiated list of "
+                         f"protoco=
ls ({self=2E_acc_negotiated_protocols})")
+            return
+
+        # =
See init=2Ec for the explanation for the length calculation
+        max_he=
ader_size =3D len("ACC,") + len(protocol) + 1 + 4 + 1 + 2 + 1
+
+        # =
calculate fragment size with base64 encoding
+        fragment_length =3D s=
elf=2E_acc_fragment_length * 6 // 8 - max_header_size
+
+        commands =
=3D []
+        for part_start in range(0, len(msg), fragment_length):
+
+ =
           msg_part =3D msg[part_start:part_start + fragment_length]
+     =
       b64msg =3D base64=2Eencodebytes(msg_part)=2Edecode()
+
+            =
flags =3D "6"
+            if part_start + fragment_length < len(msg):
+   =
             flags +=3D "F"
+
+            commands=2Eappend(f"acc-msg\n{pr=
otocol}\n{flags}\n{b64msg}\nEND")
+
+        cmd_futures =3D []
+        fo=
r command in commands:
+            cmd_futures=2Eappend(self=2Equeue_comma=
nd(command))
+
+        cmd_results: Tuple[OmiCommandResult] =3D await asyn=
cio=2Egather(*cmd_futures)
+
+        for cmd_result in cmd_results:
+     =
       if cmd_result=2Eerror:
+                logger=2Eerror(f"Error: send=
ing ACC message failed: {cmd_result}")
+
+    def recv_notify_ACC_PROTOCOLS=
(self, args):
+        params =3D args=2Esplit(",")
+        acc_params =3D=
 {}
+
+        for p in params:
+            k, v =3D p=2Esplit("=3D", 1)
+=
            acc_params[k=2Estrip()] =3D v=2Estrip()
+
+        self=2E_acc_=
negotiated_protocols =3D acc_params['protocols']=2Esplit(":")
+
+        se=
lf=2E_acc_fragment_length =3D int(acc_params['message_len'])
+
+    def rec=
v_notify_ACC(self, args):
+        protocol, fragment, b64msg =3D args=2Esp=
lit(",", 2)
+
+        if self=2E_partial_acc_msg and self=2E_protocol_acc_=
msg !=3D protocol:
+            logger=2Eerror(f"Recieved ACC message with =
protocol {protocol} before "
+                         f"previous ACC messa=
ge with protocol {self=2E_protocol_acc_msg} was complete")
+            sel=
f=2E_partial_acc_msg =3D ""
+
+        try:
+            msg =3D base64=2Ed=
ecodebytes(b64msg=2Eencode())
+            self=2E_partial_acc_msg +=3D msg=
=2Edecode()
+            self=2E_protocol_acc_msg =3D protocol
+        exc=
ept Exception as e:
+            logger=2Eerror(f"Error parsing ACC message=
: {e}", exc_info=3DTrue)
+            self=2E_partial_acc_msg =3D ""
+     =
       return
+
+        fragmented =3D fragment !=3D "0"
+        logger=
=2Edebug(
+            f"Received ACC message (fragment {fragmented}, proto=
col {protocol!r}), with payload {msg=2Edecode()!r}")
+
+        # Message i=
s not yet complete=2E Wait for more fragments=2E
+        if fragmented:
+ =
           return
+
+        if hasattr(self, f"receive_acc_{protocol}"):
+=
            handler =3D getattr(self, f"receive_acc_{protocol}")
+         =
   logger=2Edebug(f"Calling handler {handler}")
+            try:
+        =
        handler(self=2E_partial_acc_msg)
+            except Exception as e=
:
+                logger=2Eerror(f"Error parsing ACC message: {e}", exc_in=
fo=3DTrue)
+                self=2E_partial_acc_msg =3D ""
+        else:
+=
            logger=2Einfo(f"Received unhandled ACC protocol: {protocol}")
+=

+        self=2E_partial_acc_msg =3D ""
+        self=2E_protocol_acc_msg =
=3D ""
diff --git a/sample/management/omi_server_demo=2Epy b/sample/managem=
ent/omi_server_demo=2Epy
new file mode 100755
index 0000000=2E=2E7c3f56a
--=
- /dev/null
+++ b/sample/management/omi_server_demo=2Epy
@@ -0,0 +1,298 @@
=
+#! /usr/bin/env python3
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
+import asyncio
+import logging
+from asyncio import =
Future
+from base64 import standard_b64decode
+from dataclasses import fiel=
d
+from typing import Dict, Optional
+
+from omi_server_protocol import OMI=
ServerProtocol, ConnectedClient
+from omi_tools import run_main, start_mana=
gement_protocol, ConnectData
+from omi_tools import openvpn_escape
+
+# Thi=
s implement a small demonstration of using the
+# OpenVPN Access Server Man=
agement Interface (OMI)
+# and a script that does various action on the cli=
ent depending
+# on the username the user connects with
+# ensure that you =
have a proper certificate based authentication setup
+# before using this s=
cript
+# (e=2Eg=2E https://github=2Ecom/openvpn/openvpn/blob/master/doc/man=
-sections/example-fingerprint=2Erst)
+
+# usage:
+# --management /path/to/o=
mi_server_demo=2Epy unix-script
+
+# The main purpose of this script is to =
test/force certain client/server
+# behaviour=2E As a test script this is d=
one on the username but also serves
+# as an example how to implement somet=
hing similar for normal usage=2E
+#
+# if a username is prefixed with url i=
t uses the old OPEN_URL method (e=2Eg=2E urlrick)
+#
+# - fail: sends AUTH_=
FAILED
+# - failn: sends AUTH_FAILED wiht \n
+# - failtemp: sends AUTH_FAIL=
ED,TEMP:Go away for a while
+# - failtemp42: sends AUTH_FAILED,TEMP and bac=
koff for 42s
+#     - failtempnr: sends AUTH_FAILED,TEMP and instructs to g=
o the next remote
+# - success: sends AUTH_SUCCESS
+# - faildelay: sends AU=
TH_FAILED after 20s
+# - successdelay: sends AUTH_SUCCESS after 20s
+# - ri=
ck: sends you to a certain youtube site and auth you
+# - openvpn: sends yo=
u to community=2Eopenvpn=2Enet
+# - totp: Does crtext based 2FA with secret=
 "totpinsecuretotp"
+# - google: sends you to https://www=2Egoogle=2Ecom/se=
arch?q=3Dhidden without any flags
+# - googlext: sends you to https://www=
=2Egoogle=2Ecom/search?q=3Dexternal with external flags and WEBAUTH \
+#   =
      - dnssec: send only dnssec servers
+# - nodns: no dns servers
+# - dn=
ssecfb: dns server with fallback to dns without dnnsec
+# - dnsdhcp: dns op=
tions and dhcp_options
+# - dnsport: dns server with custom port
+# - faila=
ccdpc1: auth failed message indicating that the client is missing dpc1 ACC =
support=2E
+# - failaccdpc1user: auth failed message indicating that the cl=
ient is missing dpc1 ACC support indicating a auth-token and user for recon=
necting
+#     - failaccflower: auth failed message indicating that the cli=
ent is missing flower and power ACC support=2E
+# - default: push DNS 8=2E8=
=2E8=2E8 and default route
+# - notify: Gives the client a message to displ=
ay to the user via notify protocol
+
+# The hard-coded secret
+totp_secret =
=3D "totpinsecuretotp"
+
+logging=2EbasicConfig()
+logger =3D logging=2Eget=
Logger(__name__)
+logger=2EsetLevel(logging=2EINFO)
+
+try:
+    import pyo=
tp
+except ImportError:
+    logger=2Einfo("pyotp module not found=2E TOTP =
testing disabled")
+
+
+class ServerDemoConnectedClient(ConnectedClient):
+=
    # Remember the key-id that we authenticated
+    authenticated_kid: int=
 =3D -1
+    env: Dict[str, str] =3D field(default_factory=3Ddict)
+
+
+cla=
ss ServerDemoProtocol(OMIServerProtocol):
+    def __init__(self, finish_fu=
ture: Future, connect_data: ConnectData =3D None):
+        super()=2E__ini=
t__(finish_future, connect_data)
+        self=2E_connected_client_class =
=3D ServerDemoConnectedClient
+
+    def client_event_ESTABLISHED(self, cli=
ent: ServerDemoConnectedClient, kid: int, env: Dict, extra: str):
+        =
print(f"CLient connected: {client}")
+
+    def client_event_CONNECT(self, =
client: ServerDemoConnectedClient, kid: int, env: Dict, extra: str) -> None=
:
+        print(f"Authenticating client {client=2Ecid}, {kid}")
+        c=
lient=2Eauthenticated_kid =3D kid
+        client=2Eenv =3D env
+
+        =
asyncio=2Ecreate_task(self=2Edo_client_auth(client, kid))
+
+    async def =
deny_client(self, client: ServerDemoConnectedClient, kid: int, reason: str,=

+                          client_reason: Optional[str] =3D None) -> None:=

+        # Note, for this test script sending your real reason if you do n=
ot
+        # specify a client reason is okay=2E In a real environment, thi=
s kind
+        # of information is potentially bad
+
+        if not clien=
t_reason:
+            client_reason =3D reason
+        client_deny =3D f'=
client-deny {client=2Ecid} {kid} "{openvpn_escape(reason)}" "{openvpn_escap=
e(client_reason)}"'
+        await self=2Equeue_command(client_deny)
+
+   =
 async def do_client_auth(self, client: ServerDemoConnectedClient, kid: int=
) -> None:
+        username =3D client=2Eenv=2Eget("username")
+
+        =
# success
+        if username=2Estartswith("url"):
+            username =
=3D username[3:]
+            method =3D "openurl"
+            webauth =3D=
 "OPEN_URL:"
+        else:
+            method =3D "webauth"
+            =
webauth =3D "WEB_AUTH::"
+
+        if username =3D=3D 'fail' or 'UV_FAIL' =
in client=2Eenv:
+            await self=2Edeny_client(client, kid, "fail")=

+        elif username =3D=3D 'failtemp':
+            await self=2Edeny_c=
lient(client, kid, "TEMP:Go away for a while")
+        elif username =3D=
=3D 'failn':
+            await self=2Edeny_client(client, kid, "Bonus new =
line for you!\n")
+        elif username =3D=3D 'failn2':
+            awai=
t self=2Edeny_client(client, kid, "Bonus new line for you!\nand another one=
\n")
+        elif username =3D=3D 'failtemp42':
+            await self=2E=
deny_client(client, kid, "TEMP[backoff 42]:Go away for a 42s")
+        eli=
f username =3D=3D 'failtempnr':
+            await self=2Edeny_client(clien=
t, kid, "TEMP[backoff 11,advance remote]:Annoy the next server!")
+        =
elif username =3D=3D 'failaccdpc1':
+            await self=2Edeny_client(c=
lient, kid,
+                                   "ACC[protocol dpc1]: To con=
nect to this server you need to upgrade to a client that supports the OpenV=
PN Inc device posture protocol, e=2Eg=2E OpenVPN Connect version 1=2E2=2E3 =
or later")
+        elif username =3D=3D 'failaccflower':
+            awai=
t self=2Edeny_client(client, kid, "ACC[protocol flower power]: You need to =
embrace the flower power")
+        elif username =3D=3D 'failaccdpc1user':=

+            await self=2Edeny_client(client, kid,
+                      =
             "ACC[protocol flower power, user c3VjY2Vzcw=3D=3D, pass MTIzND=
U2Nzg=3D]: Please come back again  after you enabled dpc1")
+        elif u=
sername =3D=3D 'success':
+            await self=2Esend_client_auth(client=
, kid)
+        elif username =3D=3D 'faildelay':
+            await asynci=
o=2Esleep(20)
+            await self=2Edeny_client(client, kid, "I thought=
 20s about it and rejected you after that time")
+        elif username =3D=
=3D 'successdelay':
+            await asyncio=2Esleep(20)
+            awa=
it self=2Esend_client_auth(client, kid)
+        elif username=2Estartswith=
('totp'):
+            timeout =3D 90
+            extra =3D f"CR_TEXT:E,R:=
Please enter your TOTP code, {username}!"
+            logger=2Einfo(f"The =
TOTP the client needs to provide is: {self=2Eget_current_totp_code()}")
+  =
          await self=2Esend_pending_auth(client, kid, extra, timeout)
+    =
    elif username =3D=3D 'rick':
+            await asyncio=2Esleep(3)
+   =
         await self=2Esend_pending_auth(client, kid, webauth + "https://www=
=2Eyoutube=2Ecom/watch?v=3DdQw4w9WgXcQ")
+            await asyncio=2Esleep=
(10)
+            await self=2Edeny_client(client, kid, "I got you")
+     =
   elif username =3D=3D 'openvpn':
+            await self=2Esend_pending_a=
uth(client, kid, webauth + "https://community=2Eopenvpn=2Enet")
+          =
  await self=2Esend_client_auth(client, kid)
+        elif username =3D=3D =
'googleext':
+            await self=2Esend_pending_auth(client, kid, "WEB_=
AUTH:external:https://www=2Egoogle=2Ecom/search?q=3Dexternal")
+           =
 await asyncio=2Esleep(10)
+            await self=2Esend_client_auth(clien=
t, kid)
+        elif username =3D=3D 'google':
+            await self=2Es=
end_pending_auth(client, kid, "WEB_AUTH::https://www=2Egoogle=2Ecom/search?=
q=3Dexternal")
+            await asyncio=2Esleep(10)
+            await se=
lf=2Esend_client_auth(client, kid)
+        elif username =3D=3D 'special':=

+            extra =3D f"CR_TEXT:E:This special username is known, doing n=
othing, really"
+            await self=2Esend_pending_auth(client, kid, ex=
tra)
+        elif username in ['success', 'dnssec', 'nodns', 'dnssecfb', '=
default']:
+            await asyncio=2Esleep(1)
+            await self=2E=
send_client_auth(client, kid)
+        elif username =3D=3D "notify":
+    =
        await self=2Esend_pending_auth(client, kid,
+                      =
                   "NOTIFY:Please wait for 23s to let the server think if i=
t want to admit you")
+            await asyncio=2Esleep(23)
+            a=
wait self=2Esend_client_auth(client, kid)
+        else:
+            await=
 self=2Edeny_client(client, kid,
+                                   f"The =
username you used ({username}) is unknown, please pick one that I know")
+
=
+    async def send_client_auth(self, client: ServerDemoConnectedClient, ki=
d: int) -> None:
+        username =3D client=2Eenv=2Eget("username")
+
+  =
      config =3D ""
+        if username =3D=3D 'dnssec':
+            conf=
ig +=3D """
+            push "dns server 7 address 8=2E8=2E8=2E8:53"
+    =
        push "dns server 7 dnssec yes"
+            """
+        elif usern=
ame =3D=3D 'nodns':
+            pass
+        elif username =3D=3D 'dnssec=
fb':
+            config +=3D """
+            push "dns server 7 address 8=
=2E8=2E8=2E8:53"
+            push "dns server 7 dnssec yes"
+            p=
ush "dns server 10 address 8=2E8=2E8=2E8"
+            push "dns server 10 =
transport DoT"
+            push "dns server 12 address 8=2E8=2E8=2E8"
+   =
         push "dns server 12 transport DoH"
+            push "dns server 1=
9 address 8=2E8=2E8=2E8:53"
+            """
+        elif username =3D=3D =
'dnsdhcp':
+            config +=3D """
+            push "dns server 19 ad=
dress 8=2E8=2E8=2E8:53"
+            push "dhcp-options dns server 1=2E1=2E=
1=2E1"
+            """
+        elif username =3D=3D 'dnsport':
+         =
   config +=3D """
+            push "dns server 20 address 8=2E8=2E8=2E8:5=
353"
+            """
+        elif username =3D=3D 'default':
+           =
 config +=3D """
+            push "dns server 19 address 8=2E8=2E8=2E8:53"=

+            push "dhcp-options dns server 1=2E1=2E1=2E1"
+            pus=
h "redirect-gateway def1"
+            """
+
+        if not config:
+     =
       await self=2Equeue_command(f"client-auth-nt {client=2Ecid} {kid}")
+=
        else:
+            await self=2Equeue_command(f"client-auth {client=
=2Ecid} {kid}\n{config}\nEND\n")
+
+    async def send_pending_auth(self, c=
lient: ServerDemoConnectedClient, kid: int, extra: str,
+                  =
              timeout: int =3D 180) -> None:
+        auth_pending_totp_cmd=
 =3D f'client-pending-auth {client=2Ecid} {kid} "{extra}" {timeout}'
+     =
   await self=2Equeue_command(auth_pending_totp_cmd)
+
+    def client_even=
t_CR_RESPONSE(self, client: ServerDemoConnectedClient, kid: int, env: Dict,=
 extra: str) -> None:
+        client=2Eenv =3D env
+        asyncio=2Ecrea=
te_task(self=2Eclient_crresponse(client, kid, extra))
+
+    @staticmethod
=
+    def get_current_totp_code() -> str:
+        try:
+            import =
pyotp
+        except ImportError:
+            return "pyotp not found"
+
=
+        totp =3D pyotp=2ETOTP(totp_secret)
+        return totp=2Enow()
+
=
+    async def client_crresponse(self, client: ServerDemoConnectedClient, k=
id: int, response: str) -> None:
+        # Try importing the pyotp here to=
 allow the script run without pyotp
+        # installed
+        try:
+   =
         import pyotp
+        except ImportError:
+            await self=
=2Edeny_client(client, kid, "pytop module not found=2E Cannot do MFA testin=
g")
+            return
+
+        try:
+            response =3D standard_=
b64decode(response)
+            response =3D response=2Edecode()=2Estrip()=

+        except Exception as e:
+            await self=2Edeny_client(clie=
nt, kid, f"Decoding totp response failed: {e}")
+            return
+
+    =
    totp =3D pyotp=2ETOTP(totp_secret)
+
+        logger=2Einfo(f"\nCR: exp=
ected totp '{totp=2Enow()}', response was '{response}'\n")
+        # Check=
 if the code is valid (and also allow code +/-1)
+
+        if totp=2Everif=
y(response, valid_window=3D1):
+            await self=2Esend_client_auth(c=
lient, kid)
+        else:
+            await self=2Edeny_client(client, ki=
d, "TOTP verification failed")
+
+
+async def main(connect_data: ConnectDat=
a):
+    transport, protocol, finish_future =3D await start_management_prot=
ocol(connect_data, ServerDemoProtocol)
+
+    management_version =3D await =
protocol=2Emanagement_ready()
+    logger=2Einfo(f"Management interface ver=
sion: {management_version}")
+
+    await protocol=2Eenable_log()
+
+    aw=
ait protocol=2Eset_bytecount_interval(5)
+
+    await finish_future
+
+
+if=
 __name__ =3D=3D '__main__':
+    run_main(main)
diff --git a/sample/manage=
ment/omi_server_protocol=2Epy b/sample/management/omi_server_protocol=2Epy
=
new file mode 100644
index 0000000=2E=2Ea922e8e
--- /dev/null
+++ b/sample/=
management/omi_server_protocol=2Epy
@@ -0,0 +1,248 @@
+#!/usr/bin/env pytho=
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
+
+i=
mport asyncio
+import base64
+import logging
+from asyncio import Future
+f=
rom dataclasses import dataclass, field
+from typing import List, Tuple, Di=
ct, Optional
+
+from omi import OmiProtocol, ConnectionProperties, OmiComma=
ndResult
+
+logger =3D logging=2EgetLogger(__name__)
+logger=2EsetLevel(log=
ging=2EINFO)
+
+
+@dataclass
+class ConnectedClient:
+    """This represent=
s a connected client instance=2E"""
+    cid: int
+    bytes_sent: int =3D =
0
+    bytes_received: int =3D 0
+    _partial_acc_msg: str =3D ""
+    _pr=
otocol_acc_msg: str =3D ""
+    _kid_acc_msg: int =3D -1
+    _acc_fragment=
_length: int =3D 980
+    acc_negotiated_protocols: List[str] =3D field(def=
ault_factory=3Dlist)
+
+
+class OMIServerProtocol(OmiProtocol):
+    """
+ =
   This class implement common method for the OMI when OpenVPN is running
+=
    as a server=2E These are mainly helper function and functionality that
=
+    is only available/useful for OpenVPN running as a server
+    """
+
+ =
   # Connected client class, can be overridden by subclasses to store
+    =
# more information about the connected client
+    _connected_client_class =
=3D ConnectedClient
+
+    def __init__(self, finish_future: Future, connec=
t_data: ConnectionProperties):
+        super()=2E__init__(finish_future, c=
onnect_data)
+        self=2E_reset_pending_client_event()
+        self=2E=
_connected_clients: Dict =3D {}
+
+    def _reset_pending_client_event(self=
) -> None:
+        self=2E_pending_client_event: str =3D ""
+        self=
=2E_pending_client_event_cid: int =3D -1
+        self=2E_pending_client_ev=
ent_kid: int =3D -1
+        self=2E_pending_client_event_extra_args: str =
=3D None
+        self=2E_client_env: Dict =3D {}
+
+    def recv_notify_CL=
IENT(self, args: str) -> None:
+        event, args =3D args=2Esplit(",", 1=
)
+
+        if event =3D=3D "ENV":
+            if args =3D=3D "END":
+   =
             # Client environment is finished, trigger previous client
+   =
             # event that contained an ENV
+                self=2E_trigger=
_client_event(self=2E_pending_client_event, self=2E_pending_client_event_ci=
d,
+                                           self=2E_pending_client_event=
_kid, self=2E_client_env,
+                                           self=
=2E_pending_client_event_extra_args)
+                self=2E_reset_pending=
_client_event()
+            else:
+                key, value =3D args=2Es=
plit("=3D", 1)
+                self=2E_client_env[key] =3D value
+
+      =
  elif event in ("ESTABLISHED", "DISCONNECT"):
+            # This event is=
 followed by a client environment=2E Wait for
+            # the client env=
ironment to be completed before triggering the event
+            cid =3D i=
nt(args)
+
+            self=2E_pending_client_event =3D event
+           =
 self=2E_pending_client_event_cid =3D int(cid)
+            self=2E_pending=
_client_event_kid =3D None
+            if event =3D=3D "ESTABLISHED":
+   =
             self=2E_add_client(cid)
+
+        elif event in ("CONNECT", "=
REAUTH"):
+            # This event is similar to other event but also carr=
ies the key-id
+            cid, kid =3D args=2Esplit(",", 1)
+            =
cid, kid =3D int(cid), int(kid)
+            self=2E_add_client(cid)
+
+   =
         self=2E_pending_client_event =3D event
+            self=2E_pendin=
g_client_event_cid =3D int(cid)
+            self=2E_pending_client_event_k=
id =3D int(kid)
+        elif event =3D=3D "CR_RESPONSE":
+            # Th=
is event is similar to CONNECT and REAUTH but has an extra
+            # p=
arameter with the crtext response
+            cid, kid, response =3D args=
=2Esplit(",", 2)
+            cid, kid =3D int(cid), int(kid)
+
+          =
  self=2E_pending_client_event =3D event
+            self=2E_pending_clien=
t_event_cid =3D int(cid)
+            self=2E_pending_client_event_kid =3D =
int(kid)
+            self=2E_pending_client_event_extra_args =3D response
=
+        elif event =3D=3D "ACC":
+            cid, kid, acc_args =3D args=
=2Esplit(",", 2)
+            self=2E_trigger_client_event(event, int(cid),=
 int(kid), None, acc_args)
+        elif event =3D=3D "ADDRESS":
+         =
   # >CLIENT:ADDRESS,{CID},{ADDR},{PRI}
+            cid, extra =3D args=2E=
split(",", 1)
+            self=2E_trigger_client_event(event, int(cid), -1=
, None, extra)
+        else:
+            logger=2Einfo(f"Client event {ev=
ent} not handled=2E (message: {args!r})")
+
+    def client_event_ACC(self,=
 client: ConnectedClient, kid: int, env: Dict, extra: str) -> None:
+      =
  protocol, fragment, b64msg =3D extra=2Esplit(",", 2)
+
+        if client=
=2E_partial_acc_msg and client=2E_protocol_acc_msg !=3D protocol:
+        =
    logger=2Eerror(f"Recieved ACC message with protocol {protocol} before "=

+                         f"previous ACC message with protocol {client=2E_=
protocol_acc_msg} was complete")
+            client=2E_partial_acc_msg =3D=
 ""
+
+        if client=2E_partial_acc_msg and client=2E_kid_acc_msg !=3D =
kid:
+            logger=2Eerror(f"Recieved ACC message with different key =
id {kid} before "
+                         f"previous ACC message with key=
 id {client=2E_kid_acc_msg} "
+                         f"was complete=2E T=
his is currently not handled")
+            client=2E_partial_acc_msg =3D "=
"
+
+        try:
+            msg =3D base64=2Edecodebytes(b64msg=2Eencode=
())
+            client=2E_partial_acc_msg +=3D msg=2Edecode()
+           =
 client=2E_protocol_acc_msg =3D protocol
+            client=2E_kid_acc_msg=
 =3D kid
+
+            # Message is not yet complete=2E Wait for more frag=
ments=2E
+            if fragment !=3D "0":
+                return
+
+    =
        handler_name =3D f"receive_acc_client_{protocol}"
+            if h=
asattr(self, handler_name):
+                handler =3D getattr(self, hand=
ler_name)
+                logger=2Edebug(f"Calling handler {handler}")
+  =
              try:
+                    handler(client, kid, client=2E_part=
ial_acc_msg)
+                except Exception as e:
+                    l=
ogger=2Eerror(f"Error parsing ACC message: {e}", exc_info=3DTrue)
+        =
    else:
+                logger=2Einfo(f"Received unhandled ACC protocol:=
 {protocol}, handler {handler_name} not found")
+
+            client=2E_pa=
rtial_acc_msg =3D ""
+            client=2E_protocol_acc_msg =3D protocol
+=

+        except Exception as e:
+            logger=2Eerror(f"Error parsin=
g ACC message from client: {e}", exc_info=3DTrue)
+            client=2E_pa=
rtial_acc_msg =3D ""
+            return
+
+        client=2E_partial_acc_m=
sg =3D ""
+
+    def recv_notify_BYTECOUNT_CLI(self, args: str) -> None:
+ =
       cid, bytes_sent, bytes_received =3D args=2Esplit(",", 2)
+
+        =
client =3D self=2E_connected_clients=2Eget(int(cid))
+        if client:
+ =
           client=2Ebytes_sent =3D int(bytes_sent)
+            client=2Eby=
tes_received =3D int(bytes_received)
+
+    def _trigger_client_event(self,=
 event: str, cid: int, kid: int, env: Optional[Dict], extra):
+        clie=
nt =3D self=2E_connected_clients=2Eget(cid, None)
+
+        # Remember ACC=
 protocol options if present
+        if event =3D=3D "CONNECT" and "acc_pr=
otocols" in env:
+            client=2Eacc_negotiated_protocols =3D [p=2Est=
rip() for p in env["acc_protocols"]=2Esplit(":")]
+            client=2E_ac=
c_fragment_length =3D int(env['acc_message_len'])
+
+        handler_name =
=3D f"client_event_{event}"
+        if hasattr(self, handler_name):
+     =
       handler =3D getattr(self, handler_name)
+            handler(client,=
 kid, env, extra)
+        else:
+            logger=2Einfo(f"Client event =
{event} not handled=2E Method {handler_name} does not exist=2E")
+
+    def=
 _add_client(self, cid: int) -> None:
+        if not cid in self=2E_connec=
ted_clients:
+            self=2E_connected_clients[cid] =3D self=2E_connec=
ted_client_class(cid=3Dcid)
+
+    def _remove_client(self, cid: int) -> bo=
ol:
+        if cid in self=2E_connected_clients:
+            del self=2E_=
connected_clients[cid]
+            return True
+        else:
+           =
 return False
+
+    async def get_client_status(self) -> OmiCommandResult:=

+        cmd_result =3D self=2Equeue_command("status 3")
+        return a=
wait cmd_result
+
+    async def send_acc_msg(self, client: ConnectedClient=
, kid: int, protocol: str, msg: bytes) -> None:
+        """
+        Sends=
 out an ACC to the client=2E
+        """
+        if protocol not in clien=
t=2Eacc_negotiated_protocols:
+            logger=2Eerror(f"Error: trying t=
o send ACC message with protocol"
+                         f" {protocol} i=
s not in the negotiated list of "
+                         f"protocols ({c=
lient=2Eacc_negotiated_protocols})")
+            return
+
+        # See i=
nit=2Ec for the explanation for the length
+        max_header_size =3D len=
("ACC,") + len(protocol) + 1 + 4 + 1 + 2 + 1
+
+        # calculate fragmen=
t size with base64 encoding
+        fragment_length =3D client=2E_acc_frag=
ment_length * 6 // 8 - max_header_size
+
+        commands =3D []
+        =
for part_start in range(0, len(msg), fragment_length):
+
+            msg_p=
art =3D msg[part_start:part_start + fragment_length]
+            b64msg =
=3D base64=2Eencodebytes(msg_part)=2Edecode()
+
+            flags =3D "6"
=
+            if part_start + fragment_length < len(msg):
+                f=
lags +=3D "F"
+
+            commands=2Eappend(f"client-acc-msg {client=2Ec=
id} {kid}\n{protocol}\n{flags}\n{b64msg}\nEND")
+
+        cmd_futures =3D =
[]
+        for command in commands:
+            cmd_futures=2Eappend(self=
=2Equeue_command(command))
+
+        cmd_results: Tuple[OmiCommandResult] =
=3D await asyncio=2Egather(*cmd_futures)
+        for cmd_result in cmd_res=
ults:
+            if cmd_result=2Eerror:
+                logger=2Eerror(f=
"Error: sending ACC message failed: {cmd_result}")
+
+    def client_event_=
DISCONNECT(self, client: ConnectedClient, kid: int, _env: dict, _extra: str=
):
+        self=2E_remove_client(client=2Ecid)
diff --git a/sample/managem=
ent/omi_tools=2Epy b/sample/management/omi_tools=2Epy
new file mode 100644
=
index 0000000=2E=2E560f6ac
--- /dev/null
+++ b/sample/management/omi_tools=
=2Epy
@@ -0,0 +1,92 @@
+#! /usr/bin/python3
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
+import asyncio
+import os
+import r=
e
+from dataclasses import dataclass
+
+from omi import OmiProtocol, Connec=
tionProperties
+
+
+@dataclass
+class ConnectData(ConnectionProperties):
+ =
   socket: str
+
+
+openvpn_escape_re =3D re=2Ecompile(r'(["\\])')
+filt_ct=
rl_re =3D re=2Ecompile(r"[\x00-\x1f\x7f]+")
+
+
+def openvpn_escape(text):
=
+    """Escapes a string to be safely used for OpenVPN inside
+    a quoted=
 string
+
+    Something like 'client-deny 2 3 "{openvpn_escape(reason)}" "=
{openvpn_escape(client_reason)}"'
+    """
+    text =3D re=2Esub(filt_ctrl=
_re, ' ', text)
+    text =3D re=2Esub(openvpn_escape_re, r'\\\1', text)
+ =
   return text=2Erstrip()
+
+
+def get_unix_script_environment() -> Connect=
Data | None:
+    password =3D os=2Eenviron=2Eget("MANAGEMENT_PASSWORD", No=
ne)
+    socket =3D os=2Eenviron=2Eget("MANAGEMENT_SOCKET", None)
+
+    if=
 password and socket:
+        return ConnectData(password=3Dpassword, sock=
et=3Dsocket)
+    else:
+        return None
+
+
+async def start_managemen=
t_protocol(connect_data: ConnectData, protocol: OmiProtocol):
+    # Get a =
reference to the event loop as we plan to use
+    # low-level APIs=2E
+   =
 loop =3D asyncio=2Eget_running_loop()
+
+    finish_future =3D loop=2Ecrea=
te_future()
+
+    print(f"Connecting to management socket {connect_data=2E=
socket}=2E=2E=2E")
+    transport, protocol =3D await loop=2Ecreate_unix_co=
nnection(lambda: protocol(finish_future, connect_data),
+                  =
                                          connect_data=2Esocket)
+
+    ret=
urn transport, protocol, finish_future
+
+
+def run_main(main_func, connect=
_parameters: ConnectData =3D None):
+    """
+    Example function to run a=
 main function to be either using the
+    environment variable for the uni=
x-script or to use=2E If the unix-script
+    environment are detected, the=
 function will run the main_func
+    with the ConnectData from the environ=
ment=2E If the environment variables
+    are not available, it will fall b=
ack to the connect_parameters
+    if present=2E
+    :param connect_parame=
ters:  fallback connect parameters if unix-script is not available
+    :pa=
ram main_func:           The function to call=2E
+    :return:
+    """
+  =
  unix_script_parameters =3D get_unix_script_environment()
+    if unix_scr=
ipt_parameters:
+        asyncio=2Erun(main_func(unix_script_parameters))
+=
    elif connect_parameters:
+        asyncio=2Erun(main_func(connect_param=
eters))
+    else:
+        print(f"Must be called via unix-script")

-- 
T=
o view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Pro=
ject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib09bafabf612e9501ea7=
57647c86a450c73228a5
Gerrit-Change-Number: 1859
Gerrit-PatchSet: 8
Gerrit-O=
wner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Name of user not=
 set #1000061
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Name of user not set #1000061

--1N9nrIP8DTE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Name of user not set #1000061=2E </p>
<p>Arne Schwabe=
 <strong>uploaded patch set #8</strong> to this change=2E</p><p><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail">View Change</a=
></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">Add python scripts that demonstrate using the mangement =
interface<br><br>Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5<br>Si=
gned-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>A sample/man=
agement/omi=2Epy<br>A sample/management/omi_client_protocol=2Epy<br>A sampl=
e/management/omi_server_demo=2Epy<br>A sample/management/omi_server_protoco=
l=2Epy<br>A sample/management/omi_tools=2Epy<br>5 files changed, 1,091 inse=
rtions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/59/1859/8</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
sample/management/omi=2Epy b/sample/management/omi=2Epy</span><br><span>new=
 file mode 100644</span><br><span>index 0000000=2E=2E196329b</span><br><spa=
n>--- /dev/null</span><br><span>+++ b/sample/management/omi=2Epy</span><br>=
<span>@@ -0,0 +1,317 @@</span><br><span style=3D"color: hsl(120, 100%, 40%)=
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
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+# This is an example implementation=
 in python and asyncio to drive OpenVPN&#39;s</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+# management interface (OMI)=2E The permissive li=
cense allows you to use this</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+# code in other projects=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+&q=
uot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Imp=
lementation of the OpenVPN management interface (OMI) protocol=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+This implements the generic part of the OMI prot=
ocol that is common</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
to both client and server=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+&quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+import asyncio</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+import logging</span><br><span style=3D"color: hsl(120, 100%, 40%);">+im=
port re</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from asyncio=
 import Future, Event, Task, Queue</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+from dataclasses import dataclass</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+from datetime import datetime</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+from typing import override, List, O=
ptional</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+OMI_PASSWORD_PROMPT =3D &quot;E=
NTER PASSWORD:&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+logger =3D logging=
=2EgetLogger(__name__)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+logger=2EsetLevel(logging=2EINFO)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+@dataclass</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+class OmiCommandResult:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    command: str</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    result: List[str]</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    error: bool</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    status_text: str</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+@dataclass</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cl=
ass OmiSendCommand:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    command: str</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 result: Future[OmiCommandResult]</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+@dataclass</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+class ConnectionProperties:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    Properties for con=
necting to the management interface=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    &quot;&quot;&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    password: Optional[str]</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+class Om=
iProtocol(asyncio=2EProtocol):</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    def __init__(self, finish_future: Future, connect_data: Conn=
ectionProperties):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       super()=2E__init__()</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        self=2E_connect_data: ConnectionProperties =3D connect_data=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        self=2Ebytes_received: int =3D=
 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2Eby=
tes_sent: int =3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        self=2Eversion: int =3D -1</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        self=2ErecvBuffer: str =3D &quot;&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        self=2Efinish_future: Fu=
ture =3D finish_future</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        self=2Etransport: Optional[asyncio=2ETransport] =3D None</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        # Event to allow waiting for status of=
 the underlying socket</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        # to become available for writing</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        self=2E_can_send: Event =3D asyncio=2EEven=
t()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_=
can_send=2Eclear()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # Event to t=
rack when the management interface is ready to receive</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        # commands from us</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        self=2E_management_ready:=
 Event =3D asyncio=2EEvent()</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        self=2E_management_ready=2Eclear()</span><br><span style=
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
 @override</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def e=
of_received(self) -&gt; None:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        logger=2Einfo(&#39;EOF received=2E Shutting down=2E&#39;)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_sto=
p()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    @override</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    def connection_lost(self, exc: Except=
ion | None) -&gt; None:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if exc:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            logger=2Ewarn(f&#39;Connection lost ({exc})=2E Shutting down=2E=
&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            logger=
=2Ewarn(f&#39;Connection lost=2E Shutting down=2E&#39;)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        self=2E_stop()</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    def _stop(self) -&gt; None:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if not self=2Efinish_future=2Edon=
e():</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            # I=
f we are disconnected or stop, there is no sense trying</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            # to still send commands to=
 the management interface</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            self=2E_send_task=2Ecancel()</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            self=2Efinish_future=2Eset_result(Tr=
ue)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    async def _send_loop(self) -&gt=
; None:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        whil=
e True:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
command: OmiSendCommand =3D await self=2E_send_queue=2Eget()</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            await self=2E_can_send=
=2Ewait()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  self=2Esend_line(command=2Ecommand)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           response: List[str] =3D []</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            response_complete =3D False</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            # This is a bit brittle as it will loop fore=
ver if not getting a</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            # line that starts with ERROR or SUCCESS=2E With a normal Open=
VPN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            # da=
emon that speak the correct protocol this should not be a</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            # problem</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            while not response_comp=
lete:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  await self=2E_response_ready=2Ewait()</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                line =3D self=2E_response=2Epop(0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                response=2Eappend(line)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                if not self=2E_response:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 self=2E_response_ready=2Eclear()</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           lastline =3D response[-1]</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                print(lastline)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                if lastline=2Estartswith(&#39;=
ERROR: &#39;):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               error =3D True</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    response_complete =3D True</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    _, status_text =3D=
 lastline=2Esplit(&quot;: &quot;, 1)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              elif lastline=2Estartswith(&#39;SUCCESS: &#39;):</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    error =3D Fa=
lse</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
    response_complete =3D True</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                    _, status_text =3D lastline=2Esplit(&quot;: =
&quot;, 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       elif lastline =3D=3D &quot;END&quot;:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                    error =3D False</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    response_compl=
ete =3D True</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
             status_text =3D None</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                else:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    # Other lines do not complete a respons=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
  pass</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            # logger=2Edebug(f&#=
39;Result received command: {response}&#39;)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            result =3D OmiCommandResult(command=2E=
command, response[:-1], error, status_text)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            command=2Eresult=2Eset_result(result)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            logger=2Edebug(f&quot;Comman=
d done=2E&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    @override</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    def pause_writing(self) =
-&gt; None:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
self=2E_can_send=2Eclear()</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    @overrid=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def resume_wri=
ting(self) -&gt; None:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        self=2E_can_send=2Eset()</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 @override</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def c=
onnection_made(self, transport) -&gt; None:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        peername =3D transport=2Eget_extra_info(&#3=
9;peername&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     logger=2Einfo(&#39;Connection from {}&#39;=2Eformat(peername))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2Etransport =
=3D transport</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  self=2E_can_send=2Eset()</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def _che=
ck_pw_response(self, fut: Future[OmiCommandResult]) -&gt; None:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if fut=2Eexception():</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            logger=2E=
error(f&quot;Error authenticating with password: {fut=2Eexception()}&quot;)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            self=2E=
transport=2Eclose()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        result =3D f=
ut=2Eresult()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if result=2Eerror=
 or result=2Estatus_text !=3D &quot;password is correct&quot;:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            logger=2Eerror(f&quo=
t;Received unexpected status after trying to authenticate: {result=2Estatus=
_text!r}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        self=2Etransport=2Eclose()</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            return</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    d=
ef handle_password_prompt(self) -&gt; None:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        # OMI expects us to authenticate with the p=
assword just on</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    # its own on a line</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if self=2E_connect_data=2Epassword:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            fut =3D self=2Equeue_command(f&quot=
;{self=2E_connect_data=2Epassword}&quot;)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            fut=2Eadd_done_callback(self=2E_check_pw_=
response)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        el=
se:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            logg=
er=2Eerror(&quot;No password provided for authentication&quot;)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            self=2Etransport=2E=
close()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    @override</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    def data_received(self, data: byt=
es) -&gt; None:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    # OMI protocol is pure text so decode everything as UTF-8</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        message =3D data=2Edecode=
()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2Ere=
cvBuffer +=3D message</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # Managem=
ent protocol does not add a newline after the password prompt</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if not self=2E_management=
_ready=2Eis_set() and self=2ErecvBuffer=2Estartswith(OMI_PASSWORD_PROMPT):<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            logger=
=2Edebug(f&quot;Received password prompt&quot;)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            self=2ErecvBuffer =3D self=2ErecvBu=
ffer[len(OMI_PASSWORD_PROMPT) + 1:]</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            self=2Ehandle_password_prompt()</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            return</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        parts =3D self=2ErecvBuffer=2Esplit(&quot;\r\n&=
quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        # pass complete lines to=
 recvLine</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fo=
r part in parts[:-1]:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            logger=2Edebug(f&#39;Line received: {part!r}&#39;)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            self=2Erecv_line(p=
art)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        # keep the last incomplete=
 line for the next call</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        self=2ErecvBuffer =3D parts[-1]</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    def recv_line(self, line: str) -&gt; None:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if line=2Estartswith(&quot;&gt;&q=
uot;):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            #=
 this is an asynchronous message</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            self=2Erecv_notify(line)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        else:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            # normal message get passed to the _sen=
d_loop task</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    self=2E_response=2Eappend(line)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            self=2E_response_ready=2Eset()</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    def recv_notify(self, line: str) -&gt; None:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if not &quot;:&quo=
t; in line:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    logger=2Ewarning(&quot;Invalid line received: &quot; + line)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            return</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        command, args =3D line[1:]=2Esplit(&quot;:=
&quot;, 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        # do dynamic dispatc=
h based on command to call a handler</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if hasattr(self, f&quot;recv_notify_{command}&quot=
;):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            hand=
ler =3D getattr(self, f&quot;recv_notify_{command}&quot;)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            handler(args)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            return</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        logger=2Einfo(&quot;Unknown notify line rec=
eived: &quot; + line)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def recv_noti=
fy_INFO(self, args: str) -&gt; None:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        m =3D re=2Ematch(r&quot;OpenVPN Management Interfa=
ce Version (?P&lt;version&gt;\d+)&quot;, args)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if m:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            self=2Eversion =3D int(m=2Egroup(&quot;ver=
sion&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     self=2Equeue_command(&quot;version 6&quot;)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            self=2E_management_ready=2Eset()</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            logger=2Ewarnin=
g(f&quot;Unknown INFO line received: {args}&quot;)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    def recv_notify_BYTECOUNT(self, args: str) -&gt; None:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        bytes_sent, byte=
s_received =3D args=2Esplit(&quot;,&quot;, 1)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        self=2Ebytes_sent =3D int(bytes_sent)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2Ebytes_re=
ceived =3D int(bytes_received)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asyn=
c def _release_hold_task(self, hold_time: int =3D 0) -&gt; None:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        await asyncio=2Esleep(=
hold_time)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        a=
wait self=2Equeue_command(&quot;hold release&quot;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    def recv_notify_HOLD(self, args):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        _text, hold_time =3D args=2Esplit=
(&quot;:&quot;, 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       hold_time =3D int(hold_time)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     asyncio=2Ecreate_task(self=2E_release_hold_task(hold_time))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    def queue_command(self, command: str) -&gt; F=
uture[OmiCommandResult]:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        cmd =3D OmiSendCommand(command, Future())</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        self=2E_send_queue=2Eput_nowait(=
cmd)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return =
cmd=2Eresult</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    async def management_r=
eady(self) -&gt; int:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        Waits until the management interface is ready=2E Returns t=
he management interface version=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        &quot;&quot;&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        await self=2E_management_ready=2Ewait()</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return self=2Ever=
sion</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    def send_line(self, line: str)=
 -&gt; None:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 logger=2Edebug(f&quot;Sending line: {line}&quot;)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        self=2Etransport=2Ewrite(f&quot;{lin=
e}\n&quot;=2Eencode())</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Set the b=
ytecount interval=2E Use 0 to disable</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    &quot;&quot;&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    async def set_bytecount_interval(self, interval: int):</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return await self=2Equeue_=
command(f&quot;bytecount {interval}&quot;)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    async def enable_log(self):</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return await self=2Equeue_command(&quot;log on&quot=
;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    def recv_notify_LOG(self, args):=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # &gt;LOG:1=
786453401,D,MANAGEMENT: CMD &#39;bytecount 30&#39;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        timestamp, level, message =3D args=
=2Esplit(&quot;,&quot;, 2)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        time=
stamp =3D datetime=2Efromtimestamp(int(timestamp))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        level =3D level=2Estrip()</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        message =3D message=2E=
strip()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=
=2Elog_message(timestamp, level, message)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    def log_message(self, time, level, message):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        &quot;&quot;&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        A new log message has been=
 received=2E This method is intended</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        to be overridden by a subclass to handle the log m=
essages=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        :=
param time:    time in local time format</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        :param level:   level of the log message</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        :param message: t=
he log message itself</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        :return:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        logger=2Edebug(f&quot;Received log message: {time}, {level}, =
{message}&quot;)</span><br><span>diff --git a/sample/management/omi_client_=
protocol=2Epy b/sample/management/omi_client_protocol=2Epy</span><br><span>=
new file mode 100644</span><br><span>index 0000000=2E=2E6899083</span><br><=
span>--- /dev/null</span><br><span>+++ b/sample/management/omi_client_proto=
col=2Epy</span><br><span>@@ -0,0 +1,136 @@</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#!/usr/bin/env python3</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+# Copyright (c) 2026 OpenVPN Inc &lt;sales@openvp=
n=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Copyri=
ght (c) 2026 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=
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
40%);">+import asyncio</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+import base64</span><br><span style=3D"color: hsl(120, 100%, 40%);">+imp=
ort logging</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from typ=
ing import Tuple</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+from omi import OmiPro=
tocol, OmiCommandResult</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+logger =3D logg=
ing=2EgetLogger(__name__)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+logger=2EsetLevel(logging=2EDEBUG)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+class OMIClientPr=
otocol(OmiProtocol):</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    Implement the management protocol for the client  </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    def __init__(self, finish_future, connect_data):=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        super()=2E_=
_init__(finish_future=3Dfinish_future, connect_data=3Dconnect_data)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_partial_acc=
_msg =3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        self=2E_protocol_acc_msg =3D &quot;&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        self=2E_acc_fragment_length =3D 9=
80</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_a=
cc_negotiated_protocols =3D []</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asyn=
c def send_acc_msg(self, protocol: str, msg: bytes):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        &quot;&quot;&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        Sends out an ACC to the se=
rver using the specified ACC message length</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        :param protocol:</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        :param msg:</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        :param fragment_length:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        :return:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        &quot;&quot;&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if protocol not in sel=
f=2E_acc_negotiated_protocols:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            logger=2Eerror(f&quot;Error: trying to send ACC mess=
age with protocol &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                         f&quot;{protocol} is not in the negotiated li=
st of &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                  f&quot;protocols ({self=2E_acc_negotiated_protocols})&quo=
t;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retu=
rn</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        # See init=2Ec for the expla=
nation for the length calculation</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        max_header_size =3D len(&quot;ACC,&quot;) + len(proto=
col) + 1 + 4 + 1 + 2 + 1</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # calc=
ulate fragment size with base64 encoding</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        fragment_length =3D self=2E_acc_fragment_lengt=
h * 6 // 8 - max_header_size</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        co=
mmands =3D []</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  for part_start in range(0, len(msg), fragment_length):</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            msg_part =3D msg[part_start:part_start + frag=
ment_length]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     b64msg =3D base64=2Eencodebytes(msg_part)=2Edecode()</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            flags =3D &quot;6&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            if part_start + fragment_len=
gth &lt; len(msg):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               flags +=3D &quot;F&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            commands=2Eappend(f&quot;acc-msg\n{protocol}\n{flags}\n{b64msg=
}\nEND&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmd_futures =3D [=
]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for comman=
d in commands:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       cmd_futures=2Eappend(self=2Equeue_command(command))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        cmd_results: Tuple[OmiCommandResult] =3D await =
asyncio=2Egather(*cmd_futures)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
for cmd_result in cmd_results:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            if cmd_result=2Eerror:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                logger=2Eerror(f&quot;Error: send=
ing ACC message failed: {cmd_result}&quot;)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    def recv_notify_ACC_PROTOCOLS(self, args):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        params =3D args=2Esplit(&quot;,&q=
uot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        acc_pa=
rams =3D {}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        for p in params:</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            k, v =3D p=
=2Esplit(&quot;=3D&quot;, 1)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            acc_params[k=2Estrip()] =3D v=2Estrip()</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        self=2E_acc_negotiated_protocols =3D acc_para=
ms[&#39;protocols&#39;]=2Esplit(&quot;:&quot;)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        self=2E_acc_fragment_length =3D int(acc_params[&#39;message=
_len&#39;])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    def recv_notify_ACC(sel=
f, args):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        pr=
otocol, fragment, b64msg =3D args=2Esplit(&quot;,&quot;, 2)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if self=2E_partial_acc_msg and self=2E_protoco=
l_acc_msg !=3D protocol:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            logger=2Eerror(f&quot;Recieved ACC message with protocol {=
protocol} before &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                         f&quot;previous ACC message with protocol {sel=
f=2E_protocol_acc_msg} was complete&quot;)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            self=2E_partial_acc_msg =3D &quot;&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        try:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            msg =3D base64=2Edecodebytes(b64m=
sg=2Eencode())</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       self=2E_partial_acc_msg +=3D msg=2Edecode()</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            self=2E_protocol_acc_msg =3D pro=
tocol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        except=
 Exception as e:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         logger=2Eerror(f&quot;Error parsing ACC message: {e}&quot;, exc_in=
fo=3DTrue)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   self=2E_partial_acc_msg =3D &quot;&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        fragmented =3D fragment !=3D &quot;0&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        logger=2Edebug(</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            f&quot;Received ACC mess=
age (fragment {fragmented}, protocol {protocol!r}), with payload {msg=2Edec=
ode()!r}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        # Message is no=
t yet complete=2E Wait for more fragments=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if fragmented:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            return</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if hasattr(self, f&quot;receive_acc_{protocol}&quot;):</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            handler =3D =
getattr(self, f&quot;receive_acc_{protocol}&quot;)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            logger=2Edebug(f&quot;Calling ha=
ndler {handler}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            try:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                handler(self=2E_partial_acc_msg)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            except Exception as e:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                logger=2Eerror(=
f&quot;Error parsing ACC message: {e}&quot;, exc_info=3DTrue)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                self=2E_partial_a=
cc_msg =3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        else:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          logger=2Einfo(f&quot;Received unhandled ACC protocol: {protocol}&=
quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        self=2E_partial_acc_msg =
=3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     self=2E_protocol_acc_msg =3D &quot;&quot;</span><br><span>diff --git a=
/sample/management/omi_server_demo=2Epy b/sample/management/omi_server_demo=
=2Epy</span><br><span>new file mode 100755</span><br><span>index 0000000=2E=
=2E7c3f56a</span><br><span>--- /dev/null</span><br><span>+++ b/sample/manag=
ement/omi_server_demo=2Epy</span><br><span>@@ -0,0 +1,298 @@</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#! /usr/bin/env python3</span><br>=
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
%);">+import asyncio</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+import logging</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from=
 asyncio import Future</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+from base64 import standard_b64decode</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+from dataclasses import field</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+from typing import Dict, Optional</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+from omi_server_protocol import OMIServerProtocol=
, ConnectedClient</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fr=
om omi_tools import run_main, start_management_protocol, ConnectData</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+from omi_tools import open=
vpn_escape</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# This implement a small dem=
onstration of using the</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# OpenVPN Access Server Management Interface (OMI)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+# and a script that does various action =
on the client depending</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# on the username the user connects with</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+# ensure that you have a proper certificate based =
authentication setup</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# before using this script</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# (e=2Eg=2E https://github=2Ecom/openvpn/openvpn/blob/master/doc/ma=
n-sections/example-fingerprint=2Erst)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
 usage:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# --manageme=
nt /path/to/omi_server_demo=2Epy unix-script</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+# The main purpose of this script is to test/force certain client/ser=
ver</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# behaviour=2E A=
s a test script this is done on the username but also serves</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# as an example how to implement s=
omething similar for normal usage=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
 if a username is prefixed with url it uses the old OPEN_URL method (e=2Eg=
=2E urlrick)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+# - fail: sends AUTH_FAIL=
ED</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - failn: sends =
AUTH_FAILED wiht \n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
# - failtemp: sends AUTH_FAILED,TEMP:Go away for a while</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+# - failtemp42: sends AUTH_FAILED,TEMP=
 and backoff for 42s</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#     - failtempnr: sends AUTH_FAILED,TEMP and instructs to go the next re=
mote</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - success: se=
nds AUTH_SUCCESS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# -=
 faildelay: sends AUTH_FAILED after 20s</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# - successdelay: sends AUTH_SUCCESS after 20s</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# - rick: sends you to a cer=
tain youtube site and auth you</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+# - openvpn: sends you to community=2Eopenvpn=2Enet</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+# - totp: Does crtext based 2FA =
with secret &quot;totpinsecuretotp&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+# - google: sends you to https://www=2Egoogle=2Ecom/se=
arch?q=3Dhidden without any flags</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+# - googlext: sends you to https://www=2Egoogle=2Ecom/search?=
q=3Dexternal with external flags and WEBAUTH \</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#         - dnssec: send only dnssec servers</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+# - nodns: no dns serve=
rs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - dnssecfb: dns=
 server with fallback to dns without dnnsec</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+# - dnsdhcp: dns options and dhcp_options</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# - dnsport: dns server with =
custom port</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - fail=
accdpc1: auth failed message indicating that the client is missing dpc1 ACC=
 support=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - fail=
accdpc1user: auth failed message indicating that the client is missing dpc1=
 ACC support indicating a auth-token and user for reconnecting</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#     - failaccflower: auth fail=
ed message indicating that the client is missing flower and power ACC suppo=
rt=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - default: p=
ush DNS 8=2E8=2E8=2E8 and default route</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# - notify: Gives the client a message to display to th=
e user via notify protocol</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# The hard-c=
oded secret</span><br><span style=3D"color: hsl(120, 100%, 40%);">+totp_sec=
ret =3D &quot;totpinsecuretotp&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+lo=
gging=2EbasicConfig()</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+logger =3D logging=2EgetLogger(__name__)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+logger=2EsetLevel(logging=2EINFO)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+try:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    import pyotp</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
except ImportError:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    logger=2Einfo(&quot;pyotp module not found=2E TOTP testing disabled&quo=
t;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+class ServerDemoConnectedClient(ConnectedClient):</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    # Remember the key-i=
d that we authenticated</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    authenticated_kid: int =3D -1</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    env: Dict[str, str] =3D field(default_factory=3Ddict)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+class ServerDemoProtocol(OMIServerProtocol):</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    def __init__(self, finish_fu=
ture: Future, connect_data: ConnectData =3D None):</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        super()=2E__init__(finish_future, co=
nnect_data)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
self=2E_connected_client_class =3D ServerDemoConnectedClient</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    def client_event_ESTABLISHED(self, client: Server=
DemoConnectedClient, kid: int, env: Dict, extra: str):</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        print(f&quot;CLient connected: {=
client}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    def client_event_CON=
NECT(self, client: ServerDemoConnectedClient, kid: int, env: Dict, extra: s=
tr) -&gt; None:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    print(f&quot;Authenticating client {client=2Ecid}, {kid}&quot;)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        client=2Eauthentica=
ted_kid =3D kid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    client=2Eenv =3D env</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        asynci=
o=2Ecreate_task(self=2Edo_client_auth(client, kid))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    async def deny_client(self, client: ServerDemoConnectedC=
lient, kid: int, reason: str,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                          client_reason: Optional[str] =3D None) =
-&gt; None:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
# Note, for this test script sending your real reason if you do not</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        # specify a client =
reason is okay=2E In a real environment, this kind</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        # of information is potentially bad<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if not client_reason:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            client_reason =3D=
 reason</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        clie=
nt_deny =3D f&#39;client-deny {client=2Ecid} {kid} &quot;{openvpn_escape(re=
ason)}&quot; &quot;{openvpn_escape(client_reason)}&quot;&#39;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        await self=2Equeue_comman=
d(client_deny)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    async def do_client_=
auth(self, client: ServerDemoConnectedClient, kid: int) -&gt; None:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        username =3D client=
=2Eenv=2Eget(&quot;username&quot;)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    # success</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if username=2Estartswith(&quot;url&quot;):</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            username =3D username[3:]</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            method =3D &quot;ope=
nurl&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   webauth =3D &quot;OPEN_URL:&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        else:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            method =3D &quot;webauth&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            webauth =3D &quot;WEB_AUTH::&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if username =3D=3D &#39;f=
ail&#39; or &#39;UV_FAIL&#39; in client=2Eenv:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            await self=2Edeny_client(client, kid=
, &quot;fail&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        elif username =3D=3D &#39;failtemp&#39;:</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            await self=2Edeny_client(client, k=
id, &quot;TEMP:Go away for a while&quot;)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        elif username =3D=3D &#39;failn&#39;:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            await self=2Ede=
ny_client(client, kid, &quot;Bonus new line for you!\n&quot;)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        elif username =3D=3D &#39=
;failn2&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      await self=2Edeny_client(client, kid, &quot;Bonus new line for you!\n=
and another one\n&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        elif username =3D=3D &#39;failtemp42&#39;:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            await self=2Edeny_client(cl=
ient, kid, &quot;TEMP[backoff 42]:Go away for a 42s&quot;)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        elif username =3D=3D &#39;fa=
iltempnr&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       await self=2Edeny_client(client, kid, &quot;TEMP[backoff 11,advance =
remote]:Annoy the next server!&quot;)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        elif username =3D=3D &#39;failaccdpc1&#39;:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            await self=2E=
deny_client(client, kid,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                                   &quot;ACC[protocol dpc1]: To connec=
t to this server you need to upgrade to a client that supports the OpenVPN =
Inc device posture protocol, e=2Eg=2E OpenVPN Connect version 1=2E2=2E3 or =
later&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 elif username =3D=3D &#39;failaccflower&#39;:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            await self=2Edeny_client(client, kid=
, &quot;ACC[protocol flower power]: You need to embrace the flower power&qu=
ot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        elif us=
ername =3D=3D &#39;failaccdpc1user&#39;:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            await self=2Edeny_client(client, kid,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
           &quot;ACC[protocol flower power, user c3VjY2Vzcw=3D=3D, pass MTI=
zNDU2Nzg=3D]: Please come back again  after you enabled dpc1&quot;)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        elif username =3D=
=3D &#39;success&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            await self=2Esend_client_auth(client, kid)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        elif username =3D=3D &#39;fai=
ldelay&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     await asyncio=2Esleep(20)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            await self=2Edeny_client(client, kid, &quot;I though=
t 20s about it and rejected you after that time&quot;)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        elif username =3D=3D &#39;succes=
sdelay&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     await asyncio=2Esleep(20)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            await self=2Esend_client_auth(client, kid)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        elif username=2Estart=
swith(&#39;totp&#39;):</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            timeout =3D 90</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            extra =3D f&quot;CR_TEXT:E,R:Please enter your TOTP c=
ode, {username}!&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            logger=2Einfo(f&quot;The TOTP the client needs to provide is=
: {self=2Eget_current_totp_code()}&quot;)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            await self=2Esend_pending_auth(client, ki=
d, extra, timeout)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       elif username =3D=3D &#39;rick&#39;:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            await asyncio=2Esleep(3)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            await self=2Esend_pend=
ing_auth(client, kid, webauth + &quot;https://www=2Eyoutube=2Ecom/watch?v=
=3DdQw4w9WgXcQ&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            await asyncio=2Esleep(10)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            await self=2Edeny_client(client, kid, &quot=
;I got you&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      elif username =3D=3D &#39;openvpn&#39;:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            await self=2Esend_pending_auth(client=
, kid, webauth + &quot;https://community=2Eopenvpn=2Enet&quot;)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            await self=2Esend_c=
lient_auth(client, kid)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        elif username =3D=3D &#39;googleext&#39;:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            await self=2Esend_pending_aut=
h(client, kid, &quot;WEB_AUTH:external:https://www=2Egoogle=2Ecom/search?q=
=3Dexternal&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           await asyncio=2Esleep(10)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            await self=2Esend_client_auth(client, kid)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        elif username =
=3D=3D &#39;google&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            await self=2Esend_pending_auth(client, kid, &quot;WEB_AUTH=
::https://www=2Egoogle=2Ecom/search?q=3Dexternal&quot;)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            await asyncio=2Esleep(10)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            await sel=
f=2Esend_client_auth(client, kid)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        elif username =3D=3D &#39;special&#39;:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            extra =3D f&quot;CR_T=
EXT:E:This special username is known, doing nothing, really&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            await self=2Esend=
_pending_auth(client, kid, extra)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        elif username in [&#39;success&#39;, &#39;dnssec&#39;=
, &#39;nodns&#39;, &#39;dnssecfb&#39;, &#39;default&#39;]:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            await asyncio=2Esleep(1)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            await s=
elf=2Esend_client_auth(client, kid)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        elif username =3D=3D &quot;notify&quot;:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            await self=2Esend_=
pending_auth(client, kid,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                         &quot;NOTIFY:Please wait for=
 23s to let the server think if it want to admit you&quot;)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            await asyncio=2Esleep(2=
3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            await=
 self=2Esend_client_auth(client, kid)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        else:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            await self=2Edeny_client(client, kid,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
  f&quot;The username you used ({username}) is unknown, please pick one tha=
t I know&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    async def send_clie=
nt_auth(self, client: ServerDemoConnectedClient, kid: int) -&gt; None:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        username =3D cli=
ent=2Eenv=2Eget(&quot;username&quot;)</span><br><span style=3D"color: hsl(1=
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
auth {client=2Ecid} {kid} &quot;{extra}&quot; {timeout}&#39;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        await self=2Equeue_command=
(auth_pending_totp_cmd)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def client_=
event_CR_RESPONSE(self, client: ServerDemoConnectedClient, kid: int, env: D=
ict, extra: str) -&gt; None:</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        client=2Eenv =3D env</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        asyncio=2Ecreate_task(self=2Eclient_crresponse(cl=
ient, kid, extra))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    @staticmethod</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    def get_current_to=
tp_code() -&gt; str:</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        try:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      import pyotp</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       except ImportError:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            return &quot;pyotp not found&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        totp =3D pyotp=2ETOTP(totp_secret)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        return totp=2Enow()</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    async def client_crresponse(self, client: Se=
rverDemoConnectedClient, kid: int, response: str) -&gt; None:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        # Try importing the pyotp=
 here to allow the script run without pyotp</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        # installed</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        try:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            import pyotp</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        except ImportError:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            await self=2Edeny_client(client, =
kid, &quot;pytop module not found=2E Cannot do MFA testing&quot;)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            return</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        try:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            response =3D standard_b64decode(response)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            response =
=3D response=2Edecode()=2Estrip()</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        except Exception as e:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            await self=2Edeny_client(client, kid, =
f&quot;Decoding totp response failed: {e}&quot;)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            return</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        totp =3D pyotp=2ETOTP(totp_secret)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        logger=2Einfo(f&quot;\nCR: expected totp &#39;{totp=
=2Enow()}&#39;, response was &#39;{response}&#39;\n&quot;)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        # Check if the code is valid=
 (and also allow code +/-1)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
totp=2Everify(response, valid_window=3D1):</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            await self=2Esend_client_auth(client, ki=
d)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            await self=
=2Edeny_client(client, kid, &quot;TOTP verification failed&quot;)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+async def main(connect_data: ConnectData):</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    transport, protocol, finish_future =3D a=
wait start_management_protocol(connect_data, ServerDemoProtocol)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    management_version =3D await protocol=2Emanag=
ement_ready()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    lo=
gger=2Einfo(f&quot;Management interface version: {management_version}&quot;=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    await protocol=2Eenable_log()</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    await protocol=2Eset_bytecount_interv=
al(5)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    await finish_future</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+if __name__ =3D=3D &#39;__main__&#39;:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    run_main(main)</span><br><span>diff --git a/=
sample/management/omi_server_protocol=2Epy b/sample/management/omi_server_p=
rotocol=2Epy</span><br><span>new file mode 100644</span><br><span>index 000=
0000=2E=2Ea922e8e</span><br><span>--- /dev/null</span><br><span>+++ b/sampl=
e/management/omi_server_protocol=2Epy</span><br><span>@@ -0,0 +1,248 @@</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#!/usr/bin/env python3<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Copyright (c) 2026=
 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+# Copyright (c) 2026 Arne Schwabe &lt;arne@rfc2549=2Eo=
rg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# Permission is hereby granted,=
 free of charge, to any person obtaining a copy</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+# of this software and associated documentation=
 files (the &quot;Software&quot;), to deal</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+# in the Software without restriction, including wit=
hout limitation the rights</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+# to use, copy, modify, merge, publish, distribute, sublicense, and/=
or sell</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# copies of =
the Software, and to permit persons to whom the Software is</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+# furnished to do so, subject to th=
e following conditions:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# The above co=
pyright notice and this permission notice shall be included in all</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# copies or substantial port=
ions of the Software=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# THE SOFTWARE=
 IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+# IMPLIED, INCLUDING B=
UT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# FITNESS FOR A PARTICULAR PURPOSE AND NO=
NINFRINGEMENT=2E IN NO EVENT SHALL THE</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, =
DAMAGES OR OTHER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# L=
IABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# OUT OF OR IN CON=
NECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+# SOFTWARE=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+import asyncio</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+import base64</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+import logging</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+from asyncio import Future</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+from dataclasses import dataclass, field</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+from typing import List, Tuple, Dict, Optional=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+from omi import OmiProtocol, Connectio=
nProperties, OmiCommandResult</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+logger =
=3D logging=2EgetLogger(__name__)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+logger=2EsetLevel(logging=2EINFO)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+@dataclass=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+class ConnectedClie=
nt:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;=
&quot;This represents a connected client instance=2E&quot;&quot;&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    cid: int</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    bytes_sent: int =3D 0</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    bytes_received: int =
=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    _partial_a=
cc_msg: str =3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    _protocol_acc_msg: str =3D &quot;&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    _kid_acc_msg: int =3D -1</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    _acc_fragment_length: int =
=3D 980</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    acc_nego=
tiated_protocols: List[str] =3D field(default_factory=3Dlist)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+class OMIServerProtocol(OmiProtocol):</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &quot;&quot;&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    This class implement common method for the OMI=
 when OpenVPN is running</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    as a server=2E These are mainly helper function and functionality =
that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    is only ava=
ilable/useful for OpenVPN running as a server</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    # Connected client class, can be overridden by subclasses to =
store</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # more inf=
ormation about the connected client</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    _connected_client_class =3D ConnectedClient</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    def __init__(self, finish_future: Future, conn=
ect_data: ConnectionProperties):</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        super()=2E__init__(finish_future, connect_data)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_reset_pend=
ing_client_event()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       self=2E_connected_clients: Dict =3D {}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    def _reset_pending_client_event(self) -&gt; None:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        self=2E_pending_client_eve=
nt: str =3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        self=2E_pending_client_event_cid: int =3D -1</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        self=2E_pending_client_event_=
kid: int =3D -1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    self=2E_pending_client_event_extra_args: str =3D None</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        self=2E_client_env: Dict =3D =
{}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    def recv_notify_CLIENT(self, arg=
s: str) -&gt; None:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        event, args =3D args=2Esplit(&quot;,&quot;, 1)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if event =3D=3D &quot;ENV&quot;:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            if args =3D=3D &quot;END&q=
uot;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  # Client environment is finished, trigger previous client</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                # event that contai=
ned an ENV</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       self=2E_trigger_client_event(self=2E_pending_client_event, self=2E_p=
ending_client_event_cid,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                                           self=2E_pending_client_even=
t_kid, self=2E_client_env,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                           self=2E_pending_client_ev=
ent_extra_args)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            self=2E_reset_pending_client_event()</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            else:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                key, value =3D args=2Esplit(&quo=
t;=3D&quot;, 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            self=2E_client_env[key] =3D value</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        elif event in (&quot;ESTABLISHED&quot;, &quot;DISCONNECT&quo=
t;):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            # T=
his event is followed by a client environment=2E Wait for</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            # the client environment =
to be completed before triggering the event</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            cid =3D int(args)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            self=2E_pending_client_event =3D event</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            self=2E_pending_c=
lient_event_cid =3D int(cid)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            self=2E_pending_client_event_kid =3D None</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            if event =3D=3D &quo=
t;ESTABLISHED&quot;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                self=2E_add_client(cid)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        elif event in (&quot;CONNECT&quot;, &quot;REAUTH&quot;):</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            # This event is =
similar to other event but also carries the key-id</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            cid, kid =3D args=2Esplit(&quot;=
,&quot;, 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    cid, kid =3D int(cid), int(kid)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            self=2E_add_client(cid)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            self=2E_pending_client_event =3D event</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            self=2E_pending_c=
lient_event_cid =3D int(cid)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            self=2E_pending_client_event_kid =3D int(kid)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        elif event =3D=3D &q=
uot;CR_RESPONSE&quot;:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            # This event is similar to CONNECT and REAUTH but has an ext=
ra</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            # par=
ameter with the crtext response</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            cid, kid, response =3D args=2Esplit(&quot;,&quot;, =
2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            cid, =
kid =3D int(cid), int(kid)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
self=2E_pending_client_event =3D event</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            self=2E_pending_client_event_cid =3D int(cid=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            self=
=2E_pending_client_event_kid =3D int(kid)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            self=2E_pending_client_event_extra_args =
=3D response</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 elif event =3D=3D &quot;ACC&quot;:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            cid, kid, acc_args =3D args=2Esplit(&quot;,&quo=
t;, 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            s=
elf=2E_trigger_client_event(event, int(cid), int(kid), None, acc_args)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        elif event =3D=
=3D &quot;ADDRESS&quot;:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            # &gt;CLIENT:ADDRESS,{CID},{ADDR},{PRI}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            cid, extra =3D args=2Espli=
t(&quot;,&quot;, 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            self=2E_trigger_client_event(event, int(cid), -1, None, extra)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            logger=2Einfo(=
f&quot;Client event {event} not handled=2E (message: {args!r})&quot;)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    def client_event_ACC(self, client: Conne=
ctedClient, kid: int, env: Dict, extra: str) -&gt; None:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        protocol, fragment, b64msg =3D=
 extra=2Esplit(&quot;,&quot;, 2)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if client=2E_partial_acc_msg and client=2E_protocol_acc_msg !=3D protocol=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            logger=
=2Eerror(f&quot;Recieved ACC message with protocol {protocol} before &quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
      f&quot;previous ACC message with protocol {client=2E_protocol_acc_msg=
} was complete&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            client=2E_partial_acc_msg =3D &quot;&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if client=2E_partial_acc_msg and client=2E_kid_ac=
c_msg !=3D kid:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        logger=2Eerror(f&quot;Recieved ACC message with different key id {k=
id} before &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                       f&quot;previous ACC message with key id {client=2E_k=
id_acc_msg} &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                        f&quot;was complete=2E This is currently not handle=
d&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 client=2E_partial_acc_msg =3D &quot;&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        try:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          msg =3D base64=2Edecodebytes(b64msg=2Eencode())</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            client=2E_partial_acc_msg=
 +=3D msg=2Edecode()</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            client=2E_protocol_acc_msg =3D protocol</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            client=2E_kid_acc_msg =3D kid=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            # Message is not yet compl=
ete=2E Wait for more fragments=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            if fragment !=3D &quot;0&quot;:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                return</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            handler_name =3D f&quot;receive_acc_clien=
t_{protocol}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           if hasattr(self, handler_name):</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                handler =3D getattr(self, handler_na=
me)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
logger=2Edebug(f&quot;Calling handler {handler}&quot;)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                try:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    handler(client, kid=
, client=2E_partial_acc_msg)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                except Exception as e:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    logger=2Eerror(f&quot;Error=
 parsing ACC message: {e}&quot;, exc_info=3DTrue)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            else:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                logger=2Einfo(f&quot;Received u=
nhandled ACC protocol: {protocol}, handler {handler_name} not found&quot;)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            client=2E_partial_acc_msg =
=3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         client=2E_protocol_acc_msg =3D protocol</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        except Exception as e:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            logger=2Eerror(f&quot;Error parsing ACC me=
ssage from client: {e}&quot;, exc_info=3DTrue)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            client=2E_partial_acc_msg =3D &quot;=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            r=
eturn</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        client=2E_partial_acc_msg=
 =3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def recv_notify_B=
YTECOUNT_CLI(self, args: str) -&gt; None:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        cid, bytes_sent, bytes_received =3D args=2Esp=
lit(&quot;,&quot;, 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        client =
=3D self=2E_connected_clients=2Eget(int(cid))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if client:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            client=2Ebytes_sent =3D int(bytes_sent=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            client=
=2Ebytes_received =3D int(bytes_received)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    def _trigger_client_event(self, event: str, cid: int, kid: int, env:=
 Optional[Dict], extra):</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        client =3D self=2E_connected_clients=2Eget(cid, None)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        # Remember ACC protocol options if pres=
ent</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if event=
 =3D=3D &quot;CONNECT&quot; and &quot;acc_protocols&quot; in env:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            client=2Eacc_nego=
tiated_protocols =3D [p=2Estrip() for p in env[&quot;acc_protocols&quot;]=
=2Esplit(&quot;:&quot;)]</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            client=2E_acc_fragment_length =3D int(env[&#39;acc_message=
_len&#39;])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        handler_name =3D f&=
quot;client_event_{event}&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if hasattr(self, handler_name):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            handler =3D getattr(self, han=
dler_name)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   handler(client, kid, env, extra)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        else:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            logger=2Einfo(f&quot;Client event {event} not handled=
=2E Method {handler_name} does not exist=2E&quot;)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    def _add_client(self, cid: int) -&gt; None:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if not cid in self=2E_conne=
cted_clients:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      self=2E_connected_clients[cid] =3D self=2E_connected_client_class(cid=
=3Dcid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    def _remove_client(self, ci=
d: int) -&gt; bool:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if cid in self=2E_connected_clients:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            del self=2E_connected_clients[cid]</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            return True=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            return False<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    async def get_client_status(self) -=
&gt; OmiCommandResult:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        cmd_result =3D self=2Equeue_command(&quot;status 3&quot;)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return await cmd_r=
esult</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    async def send_acc_msg(self, =
client: ConnectedClient, kid: int, protocol: str, msg: bytes) -&gt; None:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;&quot;&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Sends =
out an ACC to the client=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if protocol not in client=2Eacc_negotiated_protocols=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            logger=
=2Eerror(f&quot;Error: trying to send ACC message with protocol&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
f&quot; {protocol} is not in the negotiated list of &quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                         f&quot;prot=
ocols ({client=2Eacc_negotiated_protocols})&quot;)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            return</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        # See init=2Ec for the explanation for the length</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        max_header_size =
=3D len(&quot;ACC,&quot;) + len(protocol) + 1 + 4 + 1 + 2 + 1</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        # calculate fragment size with base64 encodi=
ng</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fragment_=
length =3D client=2E_acc_fragment_length * 6 // 8 - max_header_size</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        commands =3D []</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        for part_start in range(0, len(ms=
g), fragment_length):</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg_p=
art =3D msg[part_start:part_start + fragment_length]</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            b64msg =3D base64=2Eencodebyt=
es(msg_part)=2Edecode()</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            fla=
gs =3D &quot;6&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            if part_start + fragment_length &lt; len(msg):</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                flags +=3D &quot;F&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            commands=2Eappend(f&q=
uot;client-acc-msg {client=2Ecid} {kid}\n{protocol}\n{flags}\n{b64msg}\nEND=
&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        cmd_futures =3D []</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        for command in c=
ommands:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 cmd_futures=2Eappend(self=2Equeue_command(command))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        cmd_results: Tuple[OmiCommandResult] =3D await async=
io=2Egather(*cmd_futures)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        for cmd_result in cmd_results:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            if cmd_result=2Eerror:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                logger=2Eerror(f&qu=
ot;Error: sending ACC message failed: {cmd_result}&quot;)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    def client_event_DISCONNECT(self, client: ConnectedC=
lient, kid: int, _env: dict, _extra: str):</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        self=2E_remove_client(client=2Ecid)</span><b=
r><span>diff --git a/sample/management/omi_tools=2Epy b/sample/management/o=
mi_tools=2Epy</span><br><span>new file mode 100644</span><br><span>index 00=
00000=2E=2E560f6ac</span><br><span>--- /dev/null</span><br><span>+++ b/samp=
le/management/omi_tools=2Epy</span><br><span>@@ -0,0 +1,92 @@</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#! /usr/bin/python3</span><br><sp=
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
hsl(120, 100%, 40%);">+import asyncio</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+import os</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+import re</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fr=
om dataclasses import dataclass</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from om=
i import OmiProtocol, ConnectionProperties</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+@dataclass</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+class ConnectData(Connec=
tionProperties):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 socket: str</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+openvpn_escape_re =3D re=2Ecompile(r&#39;([&q=
uot;\\])&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+filt_=
ctrl_re =3D re=2Ecompile(r&quot;[\x00-\x1f\x7f]+&quot;)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+de=
f openvpn_escape(text):</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    &quot;&quot;&quot;Escapes a string to be safely used for OpenVPN in=
side</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a quoted st=
ring</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    Something like &#39;client-den=
y 2 3 &quot;{openvpn_escape(reason)}&quot; &quot;{openvpn_escape(client_rea=
son)}&quot;&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    text =3D re=2Esub(filt_ctrl_re, &#39; &#39;, text)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    text =3D re=2Esub(openvpn_escape_re,=
 r&#39;\\\1&#39;, text)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return text=2Erstrip()</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+def get_unix_script_environ=
ment() -&gt; ConnectData | None:</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    password =3D os=2Eenviron=2Eget(&quot;MANAGEMENT_PASSWORD&=
quot;, None)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    soc=
ket =3D os=2Eenviron=2Eget(&quot;MANAGEMENT_SOCKET&quot;, None)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if password and socket:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return ConnectData(password=3Dpas=
sword, socket=3Dsocket)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    else:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  return None</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+async def start_management_protocol(connect_=
data: ConnectData, protocol: OmiProtocol):</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    # Get a reference to the event loop as we plan t=
o use</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # low-leve=
l APIs=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    loop =
=3D asyncio=2Eget_running_loop()</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi=
nish_future =3D loop=2Ecreate_future()</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    print(f&quot;Connecting to management socket {connect_data=2Esocket}=2E=
=2E=2E&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tr=
ansport, protocol =3D await loop=2Ecreate_unix_connection(lambda: protocol(=
finish_future, connect_data),</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                                            conne=
ct_data=2Esocket)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return transport,=
 protocol, finish_future</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+def run_main(main_func, connect_p=
arameters: ConnectData =3D None):</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    &quot;&quot;&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    Example function to run a main function to be either u=
sing the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    environ=
ment variable for the unix-script or to use=2E If the unix-script</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    environment are detected,=
 the function will run the main_func</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    with the ConnectData from the environment=2E If the en=
vironment variables</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    are not available, it will fall back to the connect_parameters</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if present=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    :param connect_parameters:=
  fallback connect parameters if unix-script is not available</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    :param main_func:           T=
he function to call=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    :return:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
&quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   unix_script_parameters =3D get_unix_script_environment()</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if unix_script_parameters:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        asyncio=2Erun(ma=
in_func(unix_script_parameters))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    elif connect_parameters:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        asyncio=2Erun(main_func(connect_parameters))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        print(f&quot;Must be c=
alled via unix-script&quot;)</span><br></pre><p>To view, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail">change 1859</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib=
09bafabf612e9501ea757647c86a450c73228a5 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1859 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: Name of user not set #1000061 </div>
<div style=3D"display:none"> Gerrit=
-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: Name of user not set #1000061=
 </div>

</body></html>
--1N9nrIP8DTE=--


--===============5994650086397493963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5994650086397493963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5994650086397493963==--

