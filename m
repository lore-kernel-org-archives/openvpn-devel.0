Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014CD606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=a7cceW8Z;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WHemFPph;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=iWtJxcas;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LNwc9NMu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pqucU74ihasvSXMTwRmdp4a75fH3sw14oTzRY6EyzMY=; b=a7cceW8ZXZjWDrjsLl/FOgpQwA
	IQRA17OqHAc89pie2hx4bW5NZGX18dWIqw4aPQ8rFLOOqg50ar208QBvuvJ+Q1TToROd9wSQwgq1s
	L+OKJwvk9/iSsbx7BHr+q5/7oUpp12+9zv7iFoxyWueyUU9sK5JZjhNNdslx2ocQTaxE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOjq1-000000001kj-23jz;
	Wed, 04 Nov 2026 22:52:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOjpu-000000001jz-2nk3
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 22:52:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6UWPgDqe74um3SHOgLC4aRj8zN9EXcij4wsWPaYNRTc=; b=WHemFPphZ+WMUtAlvDOwhPcvsI
 MlxKMrkuDw6BKVUWAZIfAhtE7xDhy5D9qwRG45ZutMuLBDsvnrk6HexhXoJhWK8iy8O27ZqVWc9lM
 LWaKARSIuiWF9falBFlL7F9RQz78bNjSEK9ZlFRHq9o7lNwKFwQ8Tr8nP31O3/qCm1uA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6UWPgDqe74um3SHOgLC4aRj8zN9EXcij4wsWPaYNRTc=; b=iWtJxcasQ4UQvPQ4uSG8VfXMFD
 wC6Fbb7wlZ+SavWVr108WZUr9xxyEvHTVpjC+7LYeeWZqAAY2wUvxVbGr4CvrxINDK4Fv5f0Nlqej
 MMkIghOlC/XBAkmV3CD2n6jcQD9fnEAxa4hDmv+gbucthKDtCMrMtVTc21OY8kS5NLcs=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOjpH-000000000er-3Mf8 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 22:51:35 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48b042c0759so716667f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 14:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793832681; x=1794437481; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6UWPgDqe74um3SHOgLC4aRj8zN9EXcij4wsWPaYNRTc=;
 b=LNwc9NMunF48NlXQ9kB91u56uIUC7Z3cpftvgtpzPkns8ipy5mqtIlT9bZteXs4xMn
 d1W6/kaMlp/HQvZ90dU8GnzGofQWZzDNo8aShOntpJC5Zjfu4Itk4lpuyxQ7hKfgQCA8
 v9EFnOsHew5wywuUQtw60aLwde8RLurmUmsQTbMlbCIxG2a+ZACn2mt8v39UfmQQioW5
 K0tLyzDU0PFnOaO8f5UYeOGfVv8fMHJyudto9VhDxJAdybzrS+PyiQfWpmiqyjev0leG
 X76lQJCYcNKHASeZ+UxzQ/CZgiOXiBQ7mbYFbeOPyuY+iQEGzLn0d47r97CeG+xf1AGl
 7V+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793832681; x=1794437481;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6UWPgDqe74um3SHOgLC4aRj8zN9EXcij4wsWPaYNRTc=;
 b=xPEYguuW3zmpL5z08dLk5L+jIBTtxMScQCsIrnBjVX5gNyjVjtKrhRPMFaZ/3f2Uff
 ZzBNfWgav8qB1QlSOkorqYUVhgCfQDsD09HhdUHKpaUSmWGKYqA4AVGRWarYPwVoRXTd
 s14gAtYspgC1T430YvZNATphylRPzMtEIi/NXNQyqoRPpL/RbByvyULltMHC0RHXHIaJ
 zfFIbHur1BklnpJAKuxsS5/QY/f/6suf0B0r4u6FahPKsDZCPtWMvE3MPnHMt8lvDk1s
 kmHnSkinczVCm4QBE7FpREHG6qflz8ExmscsfNWd6Cs6vuQdgeZLYrbEnr/7m2P1dt/g
 HKcQ==
X-Gm-Message-State: APuU4Z/1Zj8f/ofRCYxS5ql7ur9l7xpeAqszQuhtMrt0sgKIbQF5QgS5
 tSGFkPt1p3Dgnsby5smHeSrgwUx9VaSiM++ivYUeXMIF2YBK9gbamnGwXvynTzjPzNaFknA0bgz
 b+/8sa14xFoRelMyn2E0Samp+AULsjKO4gSv1u81swjJ5VkEd8BwoXG5XDgqs1Sxfk6WXOwoMvQ
 Mdwjnkig==
X-Gm-Gg: AYBFou0yyAgLUvzIdM9PMyNvE7UH3fR0CdjmeQhqhsKvFL7IABQF5ZfnUXoBUTJ7Jr7
 rEPzyk3CeQSr2//ERb22n2jvqt9ZfNiYbD/km064E5v4N5PzO0qtxl1P4B5pDGZ+tlUdvYM4k91
 L+aalPmlZjItzd6XNCU5ROjWx+vJPYXoXRCcaOlcOwcYZ4FDDLO3fa1fzIqsNXXjmOmX7cLXdOj
 SD4lVHUcFmxZvwSiXx99JkXCHNq6twNOE106uEka/liuv5tjwffL30TNoePKHAioMv0+HQxDMMu
 QrY/cuRoS9GDQoh50XoEQtDjnpgI8CcJd2No99tP2KlmfFJKkuxoiilnk3o2p5u3kKnRd5Ox20N
 7gezHm2pYlI5q3+I8pH9UtOz1bXI3kpTvlSZHqZ6E7KOoFdyt0wYPWe5Qxg5/Oxp7jLvH6gUN0h
 +L1c6VZ+VXWkob9RfjTJwZqohTzuDBDhQ0maGNCpIxZO/NgyKOzaiWP17mQJCptIc5m26rXbYM1
 guHPKx1yjqlP2KrkhV8cZ7QKyAN34mPHNiSlnjFHz2K8ANHF49qQ7aOUq8LIOInHswTHPU9V7OR
 OSeIuLkusZ50aReroDw4AubdqrRTBC93SMY4s/kZ60aPiPKN3F2XjwMNAKP+G+lyxcLGVJ/Gc5l
 +P9Phl0UBjXmbu6cIVCqZpVD8ohM+dvx3D33uXBY+p0GflQYmOKiWOEEbiwtUng4BSJPfgyPKCy
 0eTTHU03tNn1yl0Q==
X-Received: by 2002:a05:6000:41d1:b0:48d:f4ea:49c9 with SMTP id
 ffacd0b85a97d-48e6e5196ffmr40608687f8f.54.1793832680290; 
 Wed, 04 Nov 2026 14:51:20 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed553441sm5637253f8f.43.2026.11.04.14.51.19
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 14:51:19 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 22:51:17 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5
X-Gerrit-Change-Number: 1859
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1859?usp=email>
X-Gerrit-Commit: a6b44bfb1993df37250449250be5113b66181664
In-Reply-To: <gerrit.1787327336000.Ib09bafabf612e9501ea757647c86a450c73228a5@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ib09bafabf612e9501ea757647c86a450c73228a5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkliMDliYWZhYmY2MTJlOTUwMWVhNzU3NjQ3Yzg2YTQ1MGM3MzIyOGE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c1c14a0fa521a2bec7a4b7d7bdc1938113b71af4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOjpH-000000000er-3Mf8
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
Content-Type: multipart/mixed; boundary="===============2429238907986157267=="
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_HTML_MOSTLY,MISSING_HEADERS,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2429238907986157267==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="A9kl5J7E3iQ="; charset=UTF-8

--A9kl5J7E3iQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Arne Schwabe has upl=
oaded a new patch set (#9)=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1859?usp=3Demail )


Change subject: Add python scripts that demonstrate us=
ing the mangement interface
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Add python scripts that demonstrate using the mangement in=
terface

Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5
Signed-off-by=
: Arne Schwabe <arne@rfc2549=2Eorg>
---
M sample/Makefile=2Eam
A sample/man=
agement/omi=2Epy
A sample/management/omi_client_protocol=2Epy
A sample/mana=
gement/omi_server_demo=2Epy
A sample/management/omi_server_protocol=2Epy
A =
sample/management/omi_tools=2Epy
6 files changed, 1,112 insertions(+), 0 de=
letions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/59/1859/9

diff --git a/sample/Makefile=2Eam b/sample/Makefile=2Eam
in=
dex f3528ba=2E=2E28574d9 100644
--- a/sample/Makefile=2Eam
+++ b/sample/Mak=
efile=2Eam
@@ -16,6 +16,7 @@
        $(builddir)/sample-plugins/Makefile
 
=
 EXTRA_DIST =3D \
+	management \
 	sample-plugins \
 	sample-config-files \=

 	sample-keys \
diff --git a/sample/management/omi=2Epy b/sample/managemen=
t/omi=2Epy
new file mode 100644
index 0000000=2E=2E67dae8c
--- /dev/null
++=
+ b/sample/management/omi=2Epy
@@ -0,0 +1,345 @@
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
+# This is an example implemen=
tation in python and asyncio to drive OpenVPN's
+# management interface (OM=
I)=2E The permissive license allows you to use this
+# code in other projec=
ts=2E
+
+"""
+Implementation of the OpenVPN management interface (OMI) prot=
ocol=2E
+
+This implements the generic part of the OMI protocol that is com=
mon
+to both client and server=2E
+"""
+import asyncio
+import inspect
+imp=
ort logging
+import re
+from asyncio import Future, Event, Task, Queue
+fro=
m dataclasses import dataclass
+from datetime import datetime
+from functoo=
ls import partial
+from typing import override, List, Optional
+
+OMI_PASSW=
ORD_PROMPT =3D b"ENTER PASSWORD:"
+
+logger =3D logging=2EgetLogger(__name_=
_)
+
+@dataclass
+class OmiCommandResult:
+    command: str
+    result: Li=
st[str]
+    error: bool
+    status_text: str
+
+
+@dataclass
+class OmiSe=
ndCommand:
+    command: str
+    result: Future[OmiCommandResult]
+
+
+@da=
taclass
+class ConnectionProperties:
+    """
+    Properties for connectin=
g to the management interface=2E
+    """
+    password: Optional[str]
+
+
=
+class OmiProtocol(asyncio=2EProtocol):
+    def __init__(self, finish_futu=
re: Future, connect_data: ConnectionProperties):
+        super()=2E__init_=
_()
+        self=2E_connect_data: ConnectionProperties =3D connect_data
+
=
+        self=2Ebytes_received: int =3D 0
+        self=2Ebytes_sent: int =
=3D 0
+        self=2Eversion: int =3D -1
+        self=2ErecvBuffer: bytes=
 =3D b""
+        self=2Efinish_future: Future =3D finish_future
+        s=
elf=2Etransport: Optional[asyncio=2ETransport] =3D None
+
+        # Event =
to allow waiting for status of the underlying socket
+        # to become a=
vailable for writing
+        self=2E_can_send: Event =3D asyncio=2EEvent()=

+        self=2E_can_send=2Eclear()
+
+        # Event to track when the m=
anagement interface is ready to receive
+        # commands from us
+      =
  self=2E_management_ready: Event =3D asyncio=2EEvent()
+        self=2E_ma=
nagement_ready=2Eclear()
+        self=2E_response =3D []
+
+        self=
=2E_response_ready: Event =3D asyncio=2EEvent()
+        self=2E_response_r=
eady=2Eclear()
+
+        self=2E_send_queue: Queue =3D asyncio=2EQueue()
+=
        self=2E_send_task: Task =3D asyncio=2Ecreate_task(self=2E_send_loop=
())
+
+    @override
+    def eof_received(self) -> None:
+        logger=
=2Einfo('EOF received=2E Shutting down=2E')
+        self=2E_stop()
+
+    =
@override
+    def connection_lost(self, exc: Exception | None) -> None:
+ =
       if exc:
+            logger=2Ewarn(f'Connection lost ({exc})=2E Shut=
ting down=2E')
+        else:
+            logger=2Ewarn(f'Connection lost=
=2E Shutting down=2E')
+        self=2E_stop()
+
+    def _stop(self) -> No=
ne:
+        if not self=2Efinish_future=2Edone():
+            # If we are=
 disconnected or stop, there is no sense trying
+            # to still sen=
d commands to the management interface
+            self=2E_send_task=2Ecan=
cel()
+            self=2Efinish_future=2Eset_result(True)
+
+    async def=
 _send_loop(self) -> None:
+        while True:
+            command: OmiSe=
ndCommand =3D await self=2E_send_queue=2Eget()
+            await self=2E_c=
an_send=2Ewait()
+            self=2Esend_line(command=2Ecommand)
+
+      =
      response: List[str] =3D []
+            response_complete =3D False
+=

+            # This is a bit brittle as it will loop forever if not gettin=
g a
+            # line that starts with ERROR or SUCCESS=2E With a normal =
OpenVPN
+            # daemon that speak the correct protocol this should n=
ot be a
+            # problem
+            while not response_complete:
+ =
               await self=2E_response_ready=2Ewait()
+
+                lin=
e =3D self=2E_response=2Epop(0)
+                response=2Eappend(line)
+
=
+                if not self=2E_response:
+                    self=2E_resp=
onse_ready=2Eclear()
+
+                lastline =3D response[-1]
+        =
        if lastline=2Estartswith('ERROR: '):
+                    error =3D=
 True
+                    response_complete =3D True
+                    =
_, status_text =3D lastline=2Esplit(": ", 1)
+
+                elif lastli=
ne=2Estartswith('SUCCESS: '):
+                    error =3D False
+       =
             response_complete =3D True
+                    _, status_text=
 =3D lastline=2Esplit(": ", 1)
+                elif lastline =3D=3D "END":=

+                    error =3D False
+                    response_complet=
e =3D True
+                    status_text =3D None
+                else:=

+                    # Other lines do not complete a response
+           =
         pass
+
+            # logger=2Edebug(f'Result received command: {r=
esponse}')
+            result =3D OmiCommandResult(command=2Ecommand, resp=
onse[:-1], error, status_text)
+
+            if not command=2Eresult=2Ecan=
celled():
+                command=2Eresult=2Eset_result(result)
+
+       =
     logger=2Edebug(f"Command done=2E")
+
+    @override
+    def pause_wri=
ting(self) -> None:
+        self=2E_can_send=2Eclear()
+
+    @override
+ =
   def resume_writing(self) -> None:
+        self=2E_can_send=2Eset()
+
+ =
   @override
+    def connection_made(self, transport) -> None:
+        pe=
ername =3D transport=2Eget_extra_info('peername')
+        logger=2Einfo('C=
onnection from {}'=2Eformat(peername))
+        self=2Etransport =3D transp=
ort
+        self=2E_can_send=2Eset()
+
+    def _check_pw_response(self, f=
ut: Future[OmiCommandResult]) -> None:
+        if fut=2Eexception():
+    =
        logger=2Eerror(f"Error authenticating with password: {fut=2Eexcepti=
on()}")
+            self=2Etransport=2Eclose()
+            return
+
+    =
    result =3D fut=2Eresult()
+
+        if result=2Eerror or result=2Estat=
us_text !=3D "password is correct":
+            logger=2Eerror(f"Received =
unexpected status after trying to authenticate: {result=2Estatus_text!r}")
=
+            self=2Etransport=2Eclose()
+            return
+
+    def hand=
le_password_prompt(self) -> None:
+        # OMI expects us to authenticate=
 with the password just on
+        # its own on a line
+        if self=2E=
_connect_data=2Epassword:
+            fut =3D self=2Equeue_command(f"{self=
=2E_connect_data=2Epassword}")
+            fut=2Eadd_done_callback(self=2E=
_check_pw_response)
+        else:
+            logger=2Eerror("No password=
 provided for authentication")
+            self=2Etransport=2Eclose()
+
+ =
   @override
+    def data_received(self, data: bytes) -> None:
+        # =
OMI protocol is pure text so decode everything as UTF-8
+        message =
=3D data
+        self=2ErecvBuffer +=3D message
+
+        # Management pr=
otocol does not add a newline after the password prompt
+        if not sel=
f=2E_management_ready=2Eis_set() and self=2ErecvBuffer=2Estartswith(OMI_PAS=
SWORD_PROMPT):
+            logger=2Edebug(f"Received password prompt")
+  =
          self=2ErecvBuffer =3D self=2ErecvBuffer[len(OMI_PASSWORD_PROMPT) =
+ 1:]
+            self=2Ehandle_password_prompt()
+            return
+
+ =
       parts =3D self=2ErecvBuffer=2Esplit(b"\r\n")
+
+        # pass compl=
ete lines to recvLine
+        for part in parts[:-1]:
+            part =
=3D part=2Edecode()
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
+        if not self=2Edispatch_to_handler(f"recv_notify_{comman=
d}", args):
+            logger=2Einfo("Unknown notify line received: " + l=
ine)
+
+
+    def _dispatch_handler_done(self, handler_name:str, fut):
+   =
     if fut=2Eexception():
+            logger=2Eerror(f"Error executing ha=
ndler {handler_name}: {fut=2Eexception()}")
+
+
+    def dispatch_to_handle=
r(self, handlername:str, *args, **kwargs):
+        """
+        Looks up i=
f this class or a subclass has a handler for the given
+        command and=
 either directly calls it or schedules it as a coroutine=2E
+        :retur=
n: true if a handler was found and called
+        """
+        if hasattr(=
self, handlername):
+            handler =3D getattr(self, handlername)
+  =
          if inspect=2Eiscoroutinefunction(handler):
+                logge=
r=2Edebug(f"Calling async handler {handler}")
+                task =3D asy=
ncio=2Ecreate_task(handler(*args, **kwargs))
+                task=2Eadd_do=
ne_callback(partial(self=2E_dispatch_handler_done, handlername))
+         =
   else:
+                try:
+                    logger=2Edebug(f"Callin=
g handler {handler}")
+                    handler(*args, **kwargs)
+      =
          except Exception as e:
+                    logger=2Eerror(f"Erro=
r executing handler {handlername}: {e}", exc_info=3DTrue)
+
+            re=
turn True
+        else:
+            return False
+
+
+    def recv_notify=
_INFO(self, args: str) -> None:
+        m =3D re=2Ematch(r"OpenVPN Managem=
ent Interface Version (?P<version>\d+)", args)
+        if m:
+            =
self=2Eversion =3D int(m=2Egroup("version"))
+            self=2Equeue_comm=
and("version 6")
+            self=2E_management_ready=2Eset()
+        els=
e:
+            logger=2Ewarning(f"Unknown INFO line received: {args}")
+
+=
    def recv_notify_BYTECOUNT(self, args: str) -> None:
+        bytes_rece=
ived, bytes_sent =3D args=2Esplit(",", 1)
+        self=2Ebytes_sent =3D in=
t(bytes_sent)
+        self=2Ebytes_received =3D int(bytes_received)
+
+   =
 async def _release_hold_task(self, hold_time: int =3D 0) -> None:
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
eue_command(self, command: str) -> Future[OmiCommandResult]:
+        cmd =
=3D OmiSendCommand(command, Future())
+        self=2E_send_queue=2Eput_now=
ait(cmd)
+        return cmd=2Eresult
+
+    async def management_ready(sel=
f) -> int:
+        """
+        Waits until the management interface is re=
ady=2E Returns the management interface version=2E
+        """
+        aw=
ait self=2E_management_ready=2Ewait()
+        return self=2Eversion
+
+   =
 def send_line(self, line: str) -> None:
+        logger=2Edebug(f"Sending =
line: {line}")
+        self=2Etransport=2Ewrite(f"{line}\n"=2Eencode())
+
=
+    """
+    Set the bytecount interval=2E Use 0 to disable
+    """
+
+  =
  async def set_bytecount_interval(self, interval: int):
+        return aw=
ait self=2Equeue_command(f"bytecount {interval}")
+
+    async def enable_l=
og(self):
+        return await self=2Equeue_command("log on")
+
+    def r=
ecv_notify_LOG(self, args):
+        # >LOG:1786453401,D,MANAGEMENT: CMD 'b=
ytecount 30'
+        timestamp, level, message =3D args=2Esplit(",", 2)
+
=
+        timestamp =3D datetime=2Efromtimestamp(int(timestamp))
+        le=
vel =3D level=2Estrip()
+        message =3D message=2Estrip()
+        sel=
f=2Elog_message(timestamp, level, message)
+
+    def log_message(self, tim=
e, level, message):
+        """
+        A new log message has been receiv=
ed=2E This method is intended
+        to be overridden by a subclass to ha=
ndle the log messages=2E
+        :param time:    time in local time format=

+        :param level:   level of the log message
+        :param message:=
 the log message itself
+        :return:
+        """
+        logger=2Ede=
bug(f"Received log message: {time}, {level}, {message}")
diff --git a/sampl=
e/management/omi_client_protocol=2Epy b/sample/management/omi_client_protoc=
ol=2Epy
new file mode 100644
index 0000000=2E=2E7a9156c
--- /dev/null
+++ b=
/sample/management/omi_client_protocol=2Epy
@@ -0,0 +1,130 @@
+#!/usr/bin/e=
nv python3
+# Copyright (c) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+# Copyr=
ight (c) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+#
+# Permission is hereby =
granted, free of charge, to any person obtaining a copy
+# of this software=
 and associated documentation files (the "Software"), to deal
+# in the Sof=
tware without restriction, including without limitation the rights
+# to us=
e, copy, modify, merge, publish, distribute, sublicense, and/or sell
+# cop=
ies of the Software, and to permit persons to whom the Software is
+# furni=
shed to do so, subject to the following conditions:
+#
+# The above copyrig=
ht notice and this permission notice shall be included in all
+# copies or =
substantial portions of the Software=2E
+#
+# THE SOFTWARE IS PROVIDED "AS =
IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT=
 LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR =
PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE
+# AUTHORS OR COPYRIGH=
T HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER I=
N AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+# OUT OF OR IN C=
ONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+# SOFTWARE=
=2E
+import asyncio
+import base64
+import logging
+from typing import Tupl=
e
+
+from omi import OmiProtocol, OmiCommandResult
+
+logger =3D logging=2E=
getLogger(__name__)
+
+
+class OMIClientProtocol(OmiProtocol):
+    """
+  =
  Implement the management protocol for the client  
+    """
+
+    def __=
init__(self, finish_future, connect_data):
+        super()=2E__init__(fini=
sh_future=3Dfinish_future, connect_data=3Dconnect_data)
+        self=2E_pa=
rtial_acc_msg =3D b""
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
       # This creates a multiline base64 message but that is what
+        =
    # we want for the management interface to have a not overlong
+        =
    # lines
+            b64msg =3D base64=2Eencodebytes(msg_part)=2Edecode=
()
+
+            flags =3D "6"
+            if part_start + fragment_lengt=
h < len(msg):
+                flags +=3D "F"
+
+            commands=2Eapp=
end(f"acc-msg\n{protocol}\n{flags}\n{b64msg}\nEND")
+
+        cmd_futures =
=3D []
+        for command in commands:
+            cmd_futures=2Eappend(=
self=2Equeue_command(command))
+
+        cmd_results: Tuple[OmiCommandResu=
lt] =3D await asyncio=2Egather(*cmd_futures)
+
+        for cmd_result in c=
md_results:
+            if cmd_result=2Eerror:
+                logger=2Ee=
rror(f"Error: sending ACC message failed: {cmd_result}")
+
+    def recv_no=
tify_ACC_PROTOCOLS(self, args):
+        params =3D args=2Esplit(",")
+    =
    acc_params =3D {}
+
+        for p in params:
+            k, v =3D p=
=2Esplit("=3D", 1)
+            acc_params[k=2Estrip()] =3D v=2Estrip()
+
+=
        self=2E_acc_negotiated_protocols =3D acc_params['protocols']=2Espli=
t(":")
+
+        self=2E_acc_fragment_length =3D int(acc_params['message_l=
en'])
+
+    def recv_notify_ACC(self, args):
+        protocol, fragment, =
b64msg =3D args=2Esplit(",", 2)
+
+        if self=2E_partial_acc_msg and s=
elf=2E_protocol_acc_msg !=3D protocol:
+            logger=2Eerror(f"Receiv=
ed ACC message with protocol {protocol} before "
+                         =
f"previous ACC message with protocol {self=2E_protocol_acc_msg} was complet=
e")
+            self=2E_partial_acc_msg =3D b""
+
+        try:
+         =
   msg =3D base64=2Edecodebytes(b64msg=2Eencode())
+            self=2E_par=
tial_acc_msg +=3D msg
+            self=2E_protocol_acc_msg =3D protocol
+ =
       except Exception as e:
+            logger=2Eerror(f"Error parsing A=
CC message: {e}", exc_info=3DTrue)
+            self=2E_partial_acc_msg =3D=
 b""
+            return
+
+        fragmented =3D fragment !=3D "0"
+     =
   logger=2Edebug(
+            f"Received ACC message (fragment {fragmente=
d}, protocol {protocol!r}), with payload {msg=2Edecode()!r}")
+
+        # =
Message is not yet complete=2E Wait for more fragments=2E
+        if fragm=
ented:
+            return
+
+        if not self=2Edispatch_to_handler(f"r=
eceive_acc_{protocol}", self=2E_partial_acc_msg):
+            logger=2Einf=
o(f"Received unhandled ACC protocol: {protocol}")
+
+        self=2E_partia=
l_acc_msg =3D b""
+        self=2E_protocol_acc_msg =3D ""
diff --git a/sam=
ple/management/omi_server_demo=2Epy b/sample/management/omi_server_demo=2Ep=
y
new file mode 100755
index 0000000=2E=2Ea586232
--- /dev/null
+++ b/sampl=
e/management/omi_server_demo=2Epy
@@ -0,0 +1,305 @@
+#! /usr/bin/env python=
3
+# Copyright (c) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+# Copyright (c) =
2026 Arne Schwabe <arne@rfc2549=2Eorg>
+#
+# Permission is hereby granted, =
free of charge, to any person obtaining a copy
+# of this software and asso=
ciated documentation files (the "Software"), to deal
+# in the Software wit=
hout restriction, including without limitation the rights
+# to use, copy, =
modify, merge, publish, distribute, sublicense, and/or sell
+# copies of th=
e Software, and to permit persons to whom the Software is
+# furnished to d=
o so, subject to the following conditions:
+#
+# The above copyright notice=
 and this permission notice shall be included in all
+# copies or substanti=
al portions of the Software=2E
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITH=
OUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED =
TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE A=
ND NONINFRINGEMENT=2E IN NO EVENT SHALL THE
+# AUTHORS OR COPYRIGHT HOLDERS=
 BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTI=
ON OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+# OUT OF OR IN CONNECTION=
 WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+# SOFTWARE=2E
+
+im=
port asyncio
+import logging
+from asyncio import Future
+from base64 impor=
t standard_b64decode
+from dataclasses import field, dataclass
+from typing=
 import Dict, Optional
+
+from omi_server_protocol import OMIServerProtocol=
, ConnectedClient
+from omi_tools import run_main, start_management_protoco=
l, ConnectData
+from omi_tools import openvpn_escape
+
+# This implement a =
small demonstration of using the
+# OpenVPN Access Server Management Interf=
ace (OMI)
+# and a script that does various action on the client depending
=
+# on the username the user connects with
+# ensure that you have a proper =
certificate based authentication setup
+# before using this script
+# (e=2E=
g=2E https://github=2Ecom/openvpn/openvpn/blob/master/doc/man-sections/exam=
ple-fingerprint=2Erst)
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
+        asy=
ncio=2Ecreate_task(self=2Edo_client_auth(client, kid))
+
+    def client_ev=
ent_REAUTH(self, client: ServerDemoConnectedClient, kid: int, env: dict, ex=
tra: str):
+        print(f"Re-authenticating client {client}, {kid}")
+   =
     client=2Eenv =3D env
+        _ =3D self=2Equeue_command(f"client-auth=
-nt {client=2Ecid} {kid}")
+
+
+    async def deny_client(self, client: Ser=
verDemoConnectedClient, kid: int, reason: str,
+                          c=
lient_reason: Optional[str] =3D None) -> None:
+        # Note, for this te=
st script sending your real reason if you do not
+        # specify a clien=
t reason is okay=2E In a real environment, this kind
+        # of informat=
ion is potentially bad
+
+        if not client_reason:
+            client=
_reason =3D reason
+        client_deny =3D f'client-deny {client=2Ecid} {k=
id} "{openvpn_escape(reason)}" "{openvpn_escape(client_reason)}"'
+        =
await self=2Equeue_command(client_deny)
+
+    async def do_client_auth(sel=
f, client: ServerDemoConnectedClient, kid: int) -> None:
+        username =
=3D client=2Eenv=2Eget("username", "(empty username)")
+
+        # success=

+        if username=2Estartswith("url"):
+            username =3D userna=
me[3:]
+            method =3D "openurl"
+            webauth =3D "OPEN_URL=
:"
+        else:
+            method =3D "webauth"
+            webauth =
=3D "WEB_AUTH::"
+
+        if username =3D=3D 'fail' or 'UV_FAIL' in clien=
t=2Eenv:
+            await self=2Edeny_client(client, kid, "fail")
+      =
  elif username =3D=3D 'failtemp':
+            await self=2Edeny_client(cl=
ient, kid, "TEMP:Go away for a while")
+        elif username =3D=3D 'failn=
':
+            await self=2Edeny_client(client, kid, "Bonus new line for y=
ou!\n")
+        elif username =3D=3D 'failn2':
+            await self=2Ed=
eny_client(client, kid, "Bonus new line for you!\nand another one\n")
+    =
    elif username =3D=3D 'failtemp42':
+            await self=2Edeny_clien=
t(client, kid, "TEMP[backoff 42]:Go away for a 42s")
+        elif username=
 =3D=3D 'failtempnr':
+            await self=2Edeny_client(client, kid, "T=
EMP[backoff 11,advance remote]:Annoy the next server!")
+        elif usern=
ame =3D=3D 'failaccdpc1':
+            await self=2Edeny_client(client, kid=
,
+                                   "ACC[protocol dpc1]: To connect to th=
is server you need to upgrade to a client that supports the OpenVPN Inc dev=
ice posture protocol, e=2Eg=2E OpenVPN Connect version 1=2E2=2E3 or later")=

+        elif username =3D=3D 'failaccflower':
+            await self=2Ed=
eny_client(client, kid, "ACC[protocol flower power]: You need to embrace th=
e flower power")
+        elif username =3D=3D 'failaccdpc1user':
+        =
    await self=2Edeny_client(client, kid,
+                                =
   "ACC[protocol flower power, user c3VjY2Vzcw=3D=3D, pass MTIzNDU2Nzg=3D]:=
 Please come back again  after you enabled dpc1")
+        elif username =
=3D=3D 'success':
+            await self=2Esend_client_auth(client, kid)
+=
        elif username =3D=3D 'faildelay':
+            await asyncio=2Eslee=
p(20)
+            await self=2Edeny_client(client, kid, "I thought 20s abo=
ut it and rejected you after that time")
+        elif username =3D=3D 'suc=
cessdelay':
+            await asyncio=2Esleep(20)
+            await self=
=2Esend_client_auth(client, kid)
+        elif username=2Estartswith('totp'=
):
+            timeout =3D 90
+            extra =3D f"CR_TEXT:E,R:Please =
enter your TOTP code, {username}!"
+            logger=2Einfo(f"The TOTP th=
e client needs to provide is: {self=2Eget_current_totp_code()}")
+         =
   await self=2Esend_pending_auth(client, kid, extra, timeout)
+        eli=
f username =3D=3D 'rick':
+            await asyncio=2Esleep(3)
+          =
  await self=2Esend_pending_auth(client, kid, webauth + "https://www=2Eyout=
ube=2Ecom/watch?v=3DdQw4w9WgXcQ")
+            await asyncio=2Esleep(10)
+ =
           await self=2Edeny_client(client, kid, "I got you")
+        elif=
 username =3D=3D 'openvpn':
+            await self=2Esend_pending_auth(cli=
ent, kid, webauth + "https://community=2Eopenvpn=2Enet")
+            await=
 self=2Esend_client_auth(client, kid)
+        elif username =3D=3D 'google=
ext':
+            await self=2Esend_pending_auth(client, kid, "WEB_AUTH:ex=
ternal:https://www=2Egoogle=2Ecom/search?q=3Dexternal")
+            await =
asyncio=2Esleep(10)
+            await self=2Esend_client_auth(client, kid)=

+        elif username =3D=3D 'google':
+            await self=2Esend_pen=
ding_auth(client, kid, "WEB_AUTH::https://www=2Egoogle=2Ecom/search?q=3Dext=
ernal")
+            await asyncio=2Esleep(10)
+            await self=2Ese=
nd_client_auth(client, kid)
+        elif username =3D=3D 'special':
+     =
       extra =3D f"CR_TEXT:E:This special username is known, doing nothing,=
 really"
+            await self=2Esend_pending_auth(client, kid, extra)
+ =
       elif username in ['dnssec', 'nodns', 'dnssecfb', 'dnsdhcp', 'dnsport=
', 'default']:
+            await asyncio=2Esleep(1)
+            await sel=
f=2Esend_client_auth(client, kid)
+        elif username =3D=3D "notify":
+=
            await self=2Esend_pending_auth(client, kid,
+                  =
                       "NOTIFY::Please wait for 23s to let the server think=
 if it want to admit you")
+            await asyncio=2Esleep(23)
+        =
    await self=2Esend_client_auth(client, kid)
+        else:
+            =
await self=2Edeny_client(client, kid,
+                                   f=
"The username you used ({username}) is unknown, please pick one that I know=
")
+
+    async def send_client_auth(self, client: ServerDemoConnectedClien=
t, kid: int) -> None:
+        username =3D client=2Eenv=2Eget("username")
=
+
+        config =3D ""
+        if username =3D=3D 'dnssec':
+           =
 config +=3D """
+            push "dns server 7 address 8=2E8=2E8=2E8:53"
=
+            push "dns server 7 dnssec yes"
+            """
+        elif =
username =3D=3D 'nodns':
+            pass
+        elif username =3D=3D 'd=
nssecfb':
+            config +=3D """
+            push "dns server 7 addr=
ess 8=2E8=2E8=2E8:53"
+            push "dns server 7 dnssec yes"
+        =
    push "dns server 10 address 8=2E8=2E8=2E8"
+            push "dns serve=
r 10 transport DoT"
+            push "dns server 12 address 8=2E8=2E8=2E8"=

+            push "dns server 12 transport DoH"
+            push "dns ser=
ver 19 address 8=2E8=2E8=2E8:53"
+            """
+        elif username =
=3D=3D 'dnsdhcp':
+            config +=3D """
+            push "dns serve=
r 19 address 8=2E8=2E8=2E8:53"
+            push "dhcp-options dns server 1=
=2E1=2E1=2E1"
+            """
+        elif username =3D=3D 'dnsport':
+  =
          config +=3D """
+            push "dns server 20 address 8=2E8=2E=
8=2E8:5353"
+            """
+        elif username =3D=3D 'default':
+    =
        config +=3D """
+            push "dns server 19 address 8=2E8=2E8=
=2E8:53"
+            push "dhcp-options dns server 1=2E1=2E1=2E1"
+       =
     push "redirect-gateway def1"
+            """
+
+        if not config=
:
+            await self=2Equeue_command(f"client-auth-nt {client=2Ecid} {=
kid}")
+        else:
+            await self=2Equeue_command(f"client-auth=
 {client=2Ecid} {kid}\n{config}\nEND\n")
+
+    async def send_pending_auth=
(self, client: ServerDemoConnectedClient, kid: int, extra: str,
+          =
                      timeout: int =3D 180) -> None:
+        auth_pending_=
totp_cmd =3D f'client-pending-auth {client=2Ecid} {kid} "{openvpn_escape(ex=
tra)}" {timeout}'
+        await self=2Equeue_command(auth_pending_totp_cmd=
)
+
+    def client_event_CR_RESPONSE(self, client: ServerDemoConnectedClie=
nt, kid: int, env: Dict, extra: str) -> None:
+        client=2Eenv =3D env=

+        asyncio=2Ecreate_task(self=2Eclient_crresponse(client, kid, extra=
))
+
+    @staticmethod
+    def get_current_totp_code() -> str:
+        t=
ry:
+            import pyotp
+        except ImportError:
+            ret=
urn "pyotp not found"
+
+        totp =3D pyotp=2ETOTP(totp_secret)
+      =
  return totp=2Enow()
+
+    async def client_crresponse(self, client: Serv=
erDemoConnectedClient, kid: int, response: str) -> None:
+        # Try imp=
orting the pyotp here to allow the script run without pyotp
+        # inst=
alled
+        try:
+            import pyotp
+        except ImportError:
=
+            await self=2Edeny_client(client, kid, "pytop module not found=
=2E Cannot do MFA testing")
+            return
+
+        try:
+          =
  response =3D standard_b64decode(response)
+            response =3D respo=
nse=2Edecode()=2Estrip()
+        except Exception as e:
+            await=
 self=2Edeny_client(client, kid, f"Decoding totp response failed: {e}")
+  =
          return
+
+        totp =3D pyotp=2ETOTP(totp_secret)
+
+        l=
ogger=2Einfo(f"\nCR: expected totp '{totp=2Enow()}', response was '{respons=
e}'\n")
+        # Check if the code is valid (and also allow code +/-1)
+
=
+        if totp=2Everify(response, valid_window=3D1):
+            await s=
elf=2Esend_client_auth(client, kid)
+        else:
+            await self=
=2Edeny_client(client, kid, "TOTP verification failed")
+
+
+async def main=
(connect_data: ConnectData):
+    transport, protocol, finish_future =3D aw=
ait start_management_protocol(connect_data, ServerDemoProtocol)
+
+    mana=
gement_version =3D await protocol=2Emanagement_ready()
+    logger=2Einfo(f=
"Management interface version: {management_version}")
+
+    await protocol=
=2Eenable_log()
+
+    await protocol=2Eset_bytecount_interval(5)
+
+    aw=
ait finish_future
+
+
+if __name__ =3D=3D '__main__':
+    run_main(main)
d=
iff --git a/sample/management/omi_server_protocol=2Epy b/sample/management/=
omi_server_protocol=2Epy
new file mode 100644
index 0000000=2E=2Ece84bbe
--=
- /dev/null
+++ b/sample/management/omi_server_protocol=2Epy
@@ -0,0 +1,239=
 @@
+#!/usr/bin/env python3
+# Copyright (c) 2026 OpenVPN Inc <sales@openvp=
n=2Enet>
+# Copyright (c) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+#
+# Perm=
ission is hereby granted, free of charge, to any person obtaining a copy
+#=
 of this software and associated documentation files (the "Software"), to d=
eal
+# in the Software without restriction, including without limitation th=
e rights
+# to use, copy, modify, merge, publish, distribute, sublicense, a=
nd/or sell
+# copies of the Software, and to permit persons to whom the Sof=
tware is
+# furnished to do so, subject to the following conditions:
+#
+# =
The above copyright notice and this permission notice shall be included in =
all
+# copies or substantial portions of the Software=2E
+#
+# THE SOFTWARE=
 IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, =
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS =
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE
+# AU=
THORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIA=
BILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
=
+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS I=
N THE
+# SOFTWARE=2E
+
+import asyncio
+import base64
+import logging
+from=
 asyncio import Future
+from dataclasses import dataclass, field
+from typi=
ng import List, Tuple, Dict, Optional
+
+from omi import OmiProtocol, Conne=
ctionProperties, OmiCommandResult
+
+logger =3D logging=2EgetLogger(__name_=
_)
+logger=2EsetLevel(logging=2EINFO)
+
+
+@dataclass
+class ConnectedClien=
t:
+    """This represents a connected client instance=2E"""
+    cid: int
=
+    bytes_sent: int =3D 0
+    bytes_received: int =3D 0
+    _partial_acc=
_msg: bytes =3D b""
+    _protocol_acc_msg: str =3D ""
+    _kid_acc_msg: i=
nt =3D -1
+    _acc_fragment_length: int =3D 980
+    acc_negotiated_protoc=
ols: List[str] =3D field(default_factory=3Dlist)
+
+
+class OMIServerProtoc=
ol(OmiProtocol):
+    """
+    This class implement common method for the O=
MI when OpenVPN is running
+    as a server=2E These are mainly helper func=
tion and functionality that
+    is only available/useful for OpenVPN runni=
ng as a server
+    """
+
+    # Connected client class, can be overridden =
by subclasses to store
+    # more information about the connected client
+=
    _connected_client_class =3D ConnectedClient
+
+    def __init__(self, f=
inish_future: Future, connect_data: ConnectionProperties):
+        super()=
=2E__init__(finish_future, connect_data)
+        self=2E_reset_pending_cli=
ent_event()
+        self=2E_connected_clients: Dict =3D {}
+
+    def _res=
et_pending_client_event(self) -> None:
+        self=2E_pending_client_even=
t: str =3D ""
+        self=2E_pending_client_event_cid: int =3D -1
+      =
  self=2E_pending_client_event_kid: int =3D -1
+        self=2E_pending_cli=
ent_event_extra_args: str =3D None
+        self=2E_client_env: Dict =3D {}=

+
+    def recv_notify_CLIENT(self, args: str) -> None:
+        event, ar=
gs =3D args=2Esplit(",", 1)
+
+        if event =3D=3D "ENV":
+            =
if args =3D=3D "END":
+                # Client environment is finished, tr=
igger previous client
+                # event that contained an ENV
+     =
           self=2E_trigger_client_event(self=2E_pending_client_event, self=
=2E_pending_client_event_cid,
+                                           s=
elf=2E_pending_client_event_kid, self=2E_client_env,
+                     =
                      self=2E_pending_client_event_extra_args)
+           =
     self=2E_reset_pending_client_event()
+            else:
+             =
   key, value =3D args=2Esplit("=3D", 1)
+                self=2E_client_en=
v[key] =3D value
+
+        elif event in ("ESTABLISHED", "DISCONNECT"):
+ =
           # This event is followed by a client environment=2E Wait for
+  =
          # the client environment to be completed before triggering the ev=
ent
+            cid =3D int(args)
+
+            self=2E_pending_client_ev=
ent =3D event
+            self=2E_pending_client_event_cid =3D int(cid)
+ =
           self=2E_pending_client_event_kid =3D None
+            if event =
=3D=3D "ESTABLISHED":
+                self=2E_add_client(cid)
+
+        e=
lif event in ("CONNECT", "REAUTH"):
+            # This event is similar to=
 other event but also carries the key-id
+            cid, kid =3D args=2Es=
plit(",", 1)
+            cid, kid =3D int(cid), int(kid)
+            self=
=2E_add_client(cid)
+
+            self=2E_pending_client_event =3D event
+=
            self=2E_pending_client_event_cid =3D int(cid)
+            self=
=2E_pending_client_event_kid =3D int(kid)
+        elif event =3D=3D "CR_RE=
SPONSE":
+            # This event is similar to CONNECT and REAUTH but has=
 an extra
+            # parameter with the crtext response
+            ci=
d, kid, response =3D args=2Esplit(",", 2)
+            cid, kid =3D int(cid=
), int(kid)
+
+            self=2E_pending_client_event =3D event
+        =
    self=2E_pending_client_event_cid =3D int(cid)
+            self=2E_pend=
ing_client_event_kid =3D int(kid)
+            self=2E_pending_client_event=
_extra_args =3D response
+        elif event =3D=3D "ACC":
+            cid=
, kid, acc_args =3D args=2Esplit(",", 2)
+            self=2E_trigger_clien=
t_event(event, int(cid), int(kid), None, acc_args)
+        elif event =3D=
=3D "ADDRESS":
+            # >CLIENT:ADDRESS,{CID},{ADDR},{PRI}
+         =
   cid, extra =3D args=2Esplit(",", 1)
+            self=2E_trigger_client_=
event(event, int(cid), -1, None, extra)
+        else:
+            logger=
=2Einfo(f"Client event {event} not handled=2E (message: {args!r})")
+
+    =
def client_event_ACC(self, client: ConnectedClient, kid: int, env: Dict, ex=
tra: str) -> None:
+        protocol, fragment, b64msg =3D extra=2Esplit(",=
", 2)
+
+        if client=2E_partial_acc_msg and client=2E_protocol_acc_ms=
g !=3D protocol:
+            logger=2Eerror(f"Recieved ACC message with pr=
otocol {protocol} before "
+                         f"previous ACC message=
 with protocol {client=2E_protocol_acc_msg} was complete")
+            cli=
ent=2E_partial_acc_msg =3D b""
+
+        if client=2E_partial_acc_msg and =
client=2E_kid_acc_msg !=3D kid:
+            logger=2Eerror(f"Recieved ACC =
message with different key id {kid} before "
+                         f"pr=
evious ACC message with key id {client=2E_kid_acc_msg} "
+                 =
        f"was complete=2E This is currently not handled")
+            clie=
nt=2E_partial_acc_msg =3D b""
+
+        try:
+            msg =3D base64=
=2Edecodebytes(b64msg=2Eencode())
+            client=2E_partial_acc_msg +=
=3D msg
+            client=2E_protocol_acc_msg =3D protocol
+            c=
lient=2E_kid_acc_msg =3D kid
+
+            # Message is not yet complete=
=2E Wait for more fragments=2E
+            if fragment !=3D "0":
+        =
        return
+
+            handler_name =3D f"receive_acc_client_{protoc=
ol}"
+            if not self=2Edispatch_to_handler(handler_name, client, k=
id, client=2E_partial_acc_msg):
+                logger=2Einfo(f"Received u=
nhandled ACC protocol: {protocol}, handler {handler_name} not found")
+
+  =
          client=2E_partial_acc_msg =3D b""
+            client=2E_protocol=
_acc_msg =3D protocol
+
+        except Exception as e:
+            logger=
=2Eerror(f"Error parsing ACC message from client: {e}", exc_info=3DTrue)
+
=
+        client=2E_partial_acc_msg =3D b""
+
+    def recv_notify_BYTECOUNT=
_CLI(self, args: str) -> None:
+        cid, bytes_received, bytes_sent =3D=
 args=2Esplit(",", 2)
+
+        client =3D self=2E_connected_clients=2Eget=
(int(cid))
+        if client:
+            client=2Ebytes_sent =3D int(byt=
es_sent)
+            client=2Ebytes_received =3D int(bytes_received)
+
+  =
  def _trigger_client_event(self, event: str, cid: int, kid: int, env: Opti=
onal[Dict], extra):
+        client =3D self=2E_connected_clients=2Eget(cid=
, None)
+
+        # Remember ACC protocol options if present
+        if e=
vent =3D=3D "CONNECT" and "acc_protocols" in env:
+            client=2Eacc=
_negotiated_protocols =3D [p=2Estrip() for p in env["acc_protocols"]=2Espli=
t(":")]
+            client=2E_acc_fragment_length =3D int(env['acc_message=
_len'])
+
+        handler_name =3D f"client_event_{event}"
+        if not=
 self=2Edispatch_to_handler(handler_name, client, kid, env, extra):
+      =
      logger=2Einfo(f"Client event {event} not handled=2E Method {handler_n=
ame} does not exist=2E")
+
+    def _add_client(self, cid: int) -> None:
+ =
       if not cid in self=2E_connected_clients:
+            self=2E_connec=
ted_clients[cid] =3D self=2E_connected_client_class(cid=3Dcid)
+
+    def _=
remove_client(self, cid: int) -> bool:
+        if cid in self=2E_connected=
_clients:
+            del self=2E_connected_clients[cid]
+            retu=
rn True
+        else:
+            return False
+
+    async def get_clien=
t_status(self) -> OmiCommandResult:
+        cmd_result =3D self=2Equeue_co=
mmand("status 3")
+        return await cmd_result
+
+    async def send_ac=
c_msg(self, client: ConnectedClient, kid: int, protocol: str, msg: bytes) -=
> None:
+        """
+        Sends out an ACC to the client=2E
+        ""=
"
+        if protocol not in client=2Eacc_negotiated_protocols:
+         =
   logger=2Eerror(f"Error: trying to send ACC message with protocol"
+     =
                    f" {protocol} is not in the negotiated list of "
+     =
                    f"protocols ({client=2Eacc_negotiated_protocols})")
+  =
          return
+
+        # See init=2Ec for the explanation for the leng=
th
+        max_header_size =3D len("ACC,") + len(protocol) + 1 + 4 + 1 + 2=
 + 1
+
+        # calculate fragment size with base64 encoding
+        fra=
gment_length =3D client=2E_acc_fragment_length * 6 // 8 - max_header_size
+=

+        commands =3D []
+        for part_start in range(0, len(msg), fra=
gment_length):
+
+            msg_part =3D msg[part_start:part_start + frag=
ment_length]
+            # This creates a multiline base64 message but tha=
t is what
+            # we want for the management interface to have a not=
 overlong
+            # lines
+            b64msg =3D base64=2Eencodebytes=
(msg_part)=2Edecode()
+
+            flags =3D "6"
+            if part_sta=
rt + fragment_length < len(msg):
+                flags +=3D "F"
+
+       =
     commands=2Eappend(f"client-acc-msg {client=2Ecid} {kid}\n{protocol}\n{=
flags}\n{b64msg}\nEND")
+
+        cmd_futures =3D []
+        for command =
in commands:
+            cmd_futures=2Eappend(self=2Equeue_command(command=
))
+
+        cmd_results: Tuple[OmiCommandResult] =3D await asyncio=2Egath=
er(*cmd_futures)
+        for cmd_result in cmd_results:
+            if cm=
d_result=2Eerror:
+                logger=2Eerror(f"Error: sending ACC mess=
age failed: {cmd_result}")
+
+    def client_event_DISCONNECT(self, client:=
 ConnectedClient, kid: int, _env: dict, _extra: str):
+        self=2E_remo=
ve_client(client=2Ecid)
diff --git a/sample/management/omi_tools=2Epy b/sam=
ple/management/omi_tools=2Epy
new file mode 100644
index 0000000=2E=2E560f6=
ac
--- /dev/null
+++ b/sample/management/omi_tools=2Epy
@@ -0,0 +1,92 @@
+#=
! /usr/bin/python3
+# Copyright (c) 2026 OpenVPN Inc <sales@openvpn=2Enet>
=
+# Copyright (c) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+#
+# Permission is=
 hereby granted, free of charge, to any person obtaining a copy
+# of this =
software and associated documentation files (the "Software"), to deal
+# in=
 the Software without restriction, including without limitation the rights
=
+# to use, copy, modify, merge, publish, distribute, sublicense, and/or sel=
l
+# copies of the Software, and to permit persons to whom the Software is
=
+# furnished to do so, subject to the following conditions:
+#
+# The above=
 copyright notice and this permission notice shall be included in all
+# co=
pies or substantial portions of the Software=2E
+#
+# THE SOFTWARE IS PROVI=
DED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING=
 BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PAR=
TICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE
+# AUTHORS OR =
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, W=
HETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+# OUT OF=
 OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+# =
SOFTWARE=2E
+import asyncio
+import os
+import re
+from dataclasses import =
dataclass
+
+from omi import OmiProtocol, ConnectionProperties
+
+
+@datacl=
ass
+class ConnectData(ConnectionProperties):
+    socket: str
+
+
+openvpn=
_escape_re =3D re=2Ecompile(r'(["\\])')
+filt_ctrl_re =3D re=2Ecompile(r"[\=
x00-\x1f\x7f]+")
+
+
+def openvpn_escape(text):
+    """Escapes a string to=
 be safely used for OpenVPN inside
+    a quoted string
+
+    Something li=
ke 'client-deny 2 3 "{openvpn_escape(reason)}" "{openvpn_escape(client_reas=
on)}"'
+    """
+    text =3D re=2Esub(filt_ctrl_re, ' ', text)
+    text =
=3D re=2Esub(openvpn_escape_re, r'\\\1', text)
+    return text=2Erstrip()
=
+
+
+def get_unix_script_environment() -> ConnectData | None:
+    password=
 =3D os=2Eenviron=2Eget("MANAGEMENT_PASSWORD", None)
+    socket =3D os=2Ee=
nviron=2Eget("MANAGEMENT_SOCKET", None)
+
+    if password and socket:
+   =
     return ConnectData(password=3Dpassword, socket=3Dsocket)
+    else:
+ =
       return None
+
+
+async def start_management_protocol(connect_data: C=
onnectData, protocol: OmiProtocol):
+    # Get a reference to the event loo=
p as we plan to use
+    # low-level APIs=2E
+    loop =3D asyncio=2Eget_ru=
nning_loop()
+
+    finish_future =3D loop=2Ecreate_future()
+
+    print(f=
"Connecting to management socket {connect_data=2Esocket}=2E=2E=2E")
+    tr=
ansport, protocol =3D await loop=2Ecreate_unix_connection(lambda: protocol(=
finish_future, connect_data),
+                                            =
                connect_data=2Esocket)
+
+    return transport, protocol, f=
inish_future
+
+
+def run_main(main_func, connect_parameters: ConnectData =
=3D None):
+    """
+    Example function to run a main function to be eith=
er using the
+    environment variable for the unix-script or to use=2E If =
the unix-script
+    environment are detected, the function will run the ma=
in_func
+    with the ConnectData from the environment=2E If the environmen=
t variables
+    are not available, it will fall back to the connect_parame=
ters
+    if present=2E
+    :param connect_parameters:  fallback connect p=
arameters if unix-script is not available
+    :param main_func:           =
The function to call=2E
+    :return:
+    """
+    unix_script_parameters =
=3D get_unix_script_environment()
+    if unix_script_parameters:
+        =
asyncio=2Erun(main_func(unix_script_parameters))
+    elif connect_paramete=
rs:
+        asyncio=2Erun(main_func(connect_parameters))
+    else:
+     =
   print(f"Must be called via unix-script")

-- 
To view, visit https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5
Ge=
rrit-Change-Number: 1859
Gerrit-PatchSet: 9
Gerrit-Owner: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-CC: Name of user not set #1000061
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--A9kl5J7E3iQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Arne Schwabe <strong>uploaded=
 patch set #9</strong> to this change=2E</p><p><a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1859?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Add python scripts that demonstrate using the mangement interface<br><b=
r>Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5<br>Signed-off-by: Ar=
ne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M sample/Makefile=2Eam<br>A=
 sample/management/omi=2Epy<br>A sample/management/omi_client_protocol=2Epy=
<br>A sample/management/omi_server_demo=2Epy<br>A sample/management/omi_ser=
ver_protocol=2Epy<br>A sample/management/omi_tools=2Epy<br>6 files changed,=
 1,112 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/59/1859/9</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/sample/Makefile=2Eam b/sample/Makefile=2Eam</span><br><span>index=
 f3528ba=2E=2E28574d9 100644</span><br><span>--- a/sample/Makefile=2Eam</sp=
an><br><span>+++ b/sample/Makefile=2Eam</span><br><span>@@ -16,6 +16,7 @@</=
span><br><span>        $(builddir)/sample-plugins/Makefile</span><br><span>=
 </span><br><span> EXTRA_DIST =3D \</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+	management \</span><br><span> 	sample-plugins \</span><br>=
<span> 	sample-config-files \</span><br><span> 	sample-keys \</span><br><sp=
an>diff --git a/sample/management/omi=2Epy b/sample/management/omi=2Epy</sp=
an><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E67dae8=
c</span><br><span>--- /dev/null</span><br><span>+++ b/sample/management/omi=
=2Epy</span><br><span>@@ -0,0 +1,345 @@</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# Copyright (c) 2026 OpenVPN Inc &lt;sales@openvpn=2Ene=
t&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Copyright (c=
) 2026 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+# Permission is hereby granted, free of charge, to any person obta=
ining a copy</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# of th=
is software and associated documentation files (the &quot;Software&quot;), =
to deal</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# in the Sof=
tware without restriction, including without limitation the rights</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# to use, copy, modify, merg=
e, publish, distribute, sublicense, and/or sell</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+# copies of the Software, and to permit persons=
 to whom the Software is</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+# furnished to do so, subject to the following conditions:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+# The above copyright notice and this permission =
notice shall be included in all</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# copies or substantial portions of the Software=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+# THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WIT=
HOUT WARRANTY OF ANY KIND, EXPRESS OR</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF=
 MERCHANTABILITY,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL T=
HE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# AUTHORS OR COPY=
RIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+# LIABILITY, WHETHER IN AN ACTION OF CO=
NTRACT, TORT OR OTHERWISE, ARISING FROM,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR OTHER DEALINGS IN THE</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+# SOFTWARE=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# This is an exampl=
e implementation in python and asyncio to drive OpenVPN&#39;s</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+# management interface (OMI)=2E T=
he permissive license allows you to use this</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+# code in other projects=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+&quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+Implementation of the OpenVPN management interface (OMI) prot=
ocol=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+This implements the generic par=
t of the OMI protocol that is common</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+to both client and server=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+&quot;&quot;&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+import asyncio</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+import inspect</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+import logging</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+import re</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
from asyncio import Future, Event, Task, Queue</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+from dataclasses import dataclass</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+from datetime import datetime</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+from functools import pa=
rtial</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from typing im=
port override, List, Optional</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+OMI_PASSW=
ORD_PROMPT =3D b&quot;ENTER PASSWORD:&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+logger =3D logging=2EgetLogger(__name__)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+@dataclass</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cl=
ass OmiCommandResult:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    command: str</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   result: List[str]</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    error: bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 status_text: str</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+@dataclass</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+class OmiSendCommand:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    command: str</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    result: Future[OmiCommandResult]</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+@dataclass</span><br><span style=3D"color: hsl(120, 100%, 40%);">+class=
 ConnectionProperties:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    Properties for connecting to the management interface=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    password: Optional[st=
r]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+class OmiProtocol(asyncio=2EProtocol):</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    def __init__(self, finish_future=
: Future, connect_data: ConnectionProperties):</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        super()=2E__init__()</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        self=2E_connect_data: Connectio=
nProperties =3D connect_data</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        se=
lf=2Ebytes_received: int =3D 0</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        self=2Ebytes_sent: int =3D 0</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        self=2Eversion: int =3D -1</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        self=2ErecvBuffer: bytes=
 =3D b&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       self=2Efinish_future: Future =3D finish_future</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        self=2Etransport: Optional[asynci=
o=2ETransport] =3D None</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # Event=
 to allow waiting for status of the underlying socket</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        # to become available for writing=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_can=
_send: Event =3D asyncio=2EEvent()</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        self=2E_can_send=2Eclear()</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        # Event to track when the management interface is ready =
to receive</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        #=
 commands from us</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      self=2E_management_ready: Event =3D asyncio=2EEvent()</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        self=2E_management_ready=2E=
clear()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=
=2E_response =3D []</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_res=
ponse_ready: Event =3D asyncio=2EEvent()</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        self=2E_response_ready=2Eclear()</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        self=2E_send_queue: Queue =3D asyncio=2EQueu=
e()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_=
send_task: Task =3D asyncio=2Ecreate_task(self=2E_send_loop())</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    @override</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    def eof_received(self) -&gt; None:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        logger=2Einfo(&#39;EOF receive=
d=2E Shutting down=2E&#39;)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        self=2E_stop()</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    @ove=
rride</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def connec=
tion_lost(self, exc: Exception | None) -&gt; None:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if exc:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            logger=2Ewarn(f&#39;Connection lost =
({exc})=2E Shutting down=2E&#39;)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        else:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            logger=2Ewarn(f&#39;Connection lost=2E Shutting down=2E=
&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=
=2E_stop()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    def _stop(self) -&gt; No=
ne:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if not s=
elf=2Efinish_future=2Edone():</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            # If we are disconnected or stop, there is no sense t=
rying</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            # =
to still send commands to the management interface</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            self=2E_send_task=2Ecancel()</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            self=2Efini=
sh_future=2Eset_result(True)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    async =
def _send_loop(self) -&gt; None:</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        while True:</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            command: OmiSendCommand =3D await self=2E_send_que=
ue=2Eget()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   await self=2E_can_send=2Ewait()</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            self=2Esend_line(command=2Ecommand)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            response: List[str] =3D []</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            response_complete =
=3D False</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            # This is a bit b=
rittle as it will loop forever if not getting a</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            # line that starts with ERROR or SU=
CCESS=2E With a normal OpenVPN</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            # daemon that speak the correct protocol this should=
 not be a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  # problem</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    while not response_complete:</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                await self=2E_response_ready=2Ewait()</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                line =3D self=2E_response=2Epop=
(0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
response=2Eappend(line)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 if not self=2E_response:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    self=2E_response_ready=2Eclear()</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                lastline =3D response[-1]</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                if lastline=2Esta=
rtswith(&#39;ERROR: &#39;):</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                    error =3D True</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    response_complete =3D True</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    _, st=
atus_text =3D lastline=2Esplit(&quot;: &quot;, 1)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                elif lastline=2Estartswith(&#39;SUCCESS: &#39;):=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 error =3D False</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 response_complete =3D True</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                    _, status_text =3D lastline=2Es=
plit(&quot;: &quot;, 1)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                elif lastline =3D=3D &quot;END&quot;:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    error =3D False</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    r=
esponse_complete =3D True</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    status_text =3D None</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                else:</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    # Other lines do not compl=
ete a response</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               pass</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            # logge=
r=2Edebug(f&#39;Result received command: {response}&#39;)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            result =3D OmiCommandResu=
lt(command=2Ecommand, response[:-1], error, status_text)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            if not command=2Eresult=2Ecancelled():</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                command=2E=
result=2Eset_result(result)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 logger=2Edebug(f&quot;Command done=2E&quot;)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    @override</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    def pause_writing(self) -&gt; None:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        self=2E_can_send=2Eclear()</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    @override</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    def resume_writing(self) -&gt; None:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        self=2E_can_send=2Eset()</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    @override</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    def connection_made(self, transport) -&gt; None:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        peername =3D=
 transport=2Eget_extra_info(&#39;peername&#39;)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        logger=2Einfo(&#39;Connection from {}&#=
39;=2Eformat(peername))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        self=2Etransport =3D transport</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        self=2E_can_send=2Eset()</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    def _check_pw_response(self, fut: Future[OmiCommandRes=
ult]) -&gt; None:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if fut=2Eexception():</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            logger=2Eerror(f&quot;Error authenticating with passwor=
d: {fut=2Eexception()}&quot;)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            self=2Etransport=2Eclose()</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            return</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        result =3D fut=2Eresult()</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if result=2Eerror or result=2Estatus_text !=3D &quot;password i=
s correct&quot;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         logger=2Eerror(f&quot;Received unexpected status after trying to a=
uthenticate: {result=2Estatus_text!r}&quot;)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            self=2Etransport=2Eclose()</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            return</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    def handle_password_prompt(self) -&gt; None:</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        # OMI expects =
us to authenticate with the password just on</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        # its own on a line</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if self=2E_connect_data=2Epasswor=
d:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            fut =
=3D self=2Equeue_command(f&quot;{self=2E_connect_data=2Epassword}&quot;)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            fut=2Eadd_=
done_callback(self=2E_check_pw_response)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        else:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            logger=2Eerror(&quot;No password provided for au=
thentication&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            self=2Etransport=2Eclose()</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    @override</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    de=
f data_received(self, data: bytes) -&gt; None:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        # OMI protocol is pure text so decode ev=
erything as UTF-8</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      message =3D data</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        self=2ErecvBuffer +=3D message</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        # Management protocol does not add a newline after the password =
prompt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if no=
t self=2E_management_ready=2Eis_set() and self=2ErecvBuffer=2Estartswith(OM=
I_PASSWORD_PROMPT):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            logger=2Edebug(f&quot;Received password prompt&quot;)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            self=2ErecvBuffer=
 =3D self=2ErecvBuffer[len(OMI_PASSWORD_PROMPT) + 1:]</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            self=2Ehandle_password_prompt=
()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retur=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        parts =3D self=2ErecvBuffer=
=2Esplit(b&quot;\r\n&quot;)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # p=
ass complete lines to recvLine</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        for part in parts[:-1]:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            part =3D part=2Edecode()</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            logger=2Edebug(f&#39;Li=
ne received: {part!r}&#39;)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            self=2Erecv_line(part)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        # keep the last incomplete line for the next call</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        self=2ErecvBuffer =3D par=
ts[-1]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    def recv_line(self, line: st=
r) -&gt; None:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if line=2Estartswith(&quot;&gt;&quot;):</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            # this is an asynchronous message</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            self=2Erecv_no=
tify(line)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        e=
lse:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            # n=
ormal message get passed to the _send_loop task</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            self=2E_response=2Eappend(line)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            self=2E_res=
ponse_ready=2Eset()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def recv_notify=
(self, line: str) -&gt; None:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if not &quot;:&quot; in line:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            logger=2Ewarning(&quot;Invalid line=
 received: &quot; + line)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            return</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        comman=
d, args =3D line[1:]=2Esplit(&quot;:&quot;, 1)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        # do dynamic dispatch based on command to call a handler</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if not self=2E=
dispatch_to_handler(f&quot;recv_notify_{command}&quot;, args):</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            logger=2Einfo(&quot;=
Unknown notify line received: &quot; + line)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def _disp=
atch_handler_done(self, handler_name:str, fut):</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if fut=2Eexception():</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            logger=2Eerror(f&quot;Err=
or executing handler {handler_name}: {fut=2Eexception()}&quot;)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    def dispatch_to_handler(self, handlername:str, *args, **kwargs):<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;&quot;=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Looks=
 up if this class or a subclass has a handler for the given</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        command and either directly=
 calls it or schedules it as a coroutine=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        :return: true if a handler was found and ca=
lled</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;&=
quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if hasattr(self, handlername):</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            handler =3D getattr(self, handlername)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if inspect=2Eiscorout=
inefunction(handler):</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                logger=2Edebug(f&quot;Calling async handler {handler}&quo=
t;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
task =3D asyncio=2Ecreate_task(handler(*args, **kwargs))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                task=2Eadd_done_callba=
ck(partial(self=2E_dispatch_handler_done, handlername))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            else:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                try:</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                    logger=2Edebug(f&quo=
t;Calling handler {handler}&quot;)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                    handler(*args, **kwargs)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                except Exception as=
 e:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
    logger=2Eerror(f&quot;Error executing handler {handlername}: {e}&quot;,=
 exc_info=3DTrue)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return Tr=
ue</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            return Fals=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    def recv_notify_INFO(self, args: str) -&gt; None:</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        m =3D re=2Emat=
ch(r&quot;OpenVPN Management Interface Version (?P&lt;version&gt;\d+)&quot;=
, args)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if m=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            self=
=2Eversion =3D int(m=2Egroup(&quot;version&quot;))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            self=2Equeue_command(&quot;versi=
on 6&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    self=2E_management_ready=2Eset()</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        else:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            logger=2Ewarning(f&quot;Unknown INFO line received: =
{args}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    def recv_notify_BYTEC=
OUNT(self, args: str) -&gt; None:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        bytes_received, bytes_sent =3D args=2Esplit(&quot;,&q=
uot;, 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sel=
f=2Ebytes_sent =3D int(bytes_sent)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        self=2Ebytes_received =3D int(bytes_received)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    async def _release_hold_task(self, hold_t=
ime: int =3D 0) -&gt; None:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        await asyncio=2Esleep(hold_time)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        await self=2Equeue_command(&quot;hold =
release&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    def recv_notify_HOLD=
(self, args):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  _text, hold_time =3D args=2Esplit(&quot;:&quot;, 1)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        hold_time =3D int(hold_time)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        asyncio=2Ecreate_task(self=2E_rel=
ease_hold_task(hold_time))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def queu=
e_command(self, command: str) -&gt; Future[OmiCommandResult]:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        cmd =3D OmiSendCommand(co=
mmand, Future())</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     self=2E_send_queue=2Eput_nowait(cmd)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return cmd=2Eresult</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    async def management_ready(self) -&gt; int:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        &quot;&quot;&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        Waits until the manag=
ement interface is ready=2E Returns the management interface version=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;&quot;&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        await se=
lf=2E_management_ready=2Ewait()</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return self=2Eversion</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    def send_line(self, line: str) -&gt; None:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        logger=2Edebug(f&quot;Sending line: {=
line}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 self=2Etransport=2Ewrite(f&quot;{line}\n&quot;=2Eencode())</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    &quot;&quot;&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    Set the bytecount interval=2E Use 0 to disable<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    async def set_bytecount_interval=
(self, interval: int):</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        return await self=2Equeue_command(f&quot;bytecount {interval}&qu=
ot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    async def enable_log(self):</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return await s=
elf=2Equeue_command(&quot;log on&quot;)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    def recv_notify_LOG(self, args):</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        # &gt;LOG:1786453401,D,MANAGEMENT: CMD &#39;bytec=
ount 30&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 timestamp, level, message =3D args=2Esplit(&quot;,&quot;, 2)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        timestamp =3D datetime=2Efromtimestamp(int(t=
imestamp))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        l=
evel =3D level=2Estrip()</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        message =3D message=2Estrip()</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        self=2Elog_message(timestamp, level, message=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    def log_message(self, time, level=
, message):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
&quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       A new log message has been received=2E This method is intended</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        to be overridden =
by a subclass to handle the log messages=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        :param time:    time in local time format</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        :param level:=
   level of the log message</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        :param message: the log message itself</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        :return:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        &quot;&quot;&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        logger=2Edebug(f&quot;Rece=
ived log message: {time}, {level}, {message}&quot;)</span><br><span>diff --=
git a/sample/management/omi_client_protocol=2Epy b/sample/management/omi_cl=
ient_protocol=2Epy</span><br><span>new file mode 100644</span><br><span>ind=
ex 0000000=2E=2E7a9156c</span><br><span>--- /dev/null</span><br><span>+++ b=
/sample/management/omi_client_protocol=2Epy</span><br><span>@@ -0,0 +1,130 =
@@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#!/usr/bin/env py=
thon3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Copyright (c=
) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+# Copyright (c) 2026 Arne Schwabe &lt;arne@rfc25=
49=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+# Permission is hereby gr=
anted, free of charge, to any person obtaining a copy</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# of this software and associated documen=
tation files (the &quot;Software&quot;), to deal</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# in the Software without restriction, includi=
ng without limitation the rights</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+# to use, copy, modify, merge, publish, distribute, sublicense=
, and/or sell</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# copi=
es of the Software, and to permit persons to whom the Software is</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# furnished to do so, subject=
 to the following conditions:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# The ab=
ove copyright notice and this permission notice shall be included in all</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+# copies or substantia=
l portions of the Software=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# THE SO=
FTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# IMPLIED, INCLU=
DING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+# FITNESS FOR A PARTICULAR PURPOSE A=
ND NONINFRINGEMENT=2E IN NO EVENT SHALL THE</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CL=
AIM, DAMAGES OR OTHER</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# OUT OF OR I=
N CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# SOFTWARE=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+import asyncio</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+import base64</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+import logging</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+from typing import Tuple</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+from omi import OmiProtocol, OmiCommandResult</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+logger =3D logging=2EgetLogger(__name__)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+class OMIClientProtocol(OmiProtocol):</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    &quot;&quot;&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    Implement the management protocol for the client =
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    def __init__(self, finish_futu=
re, connect_data):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       super()=2E__init__(finish_future=3Dfinish_future, connect_data=3Dcon=
nect_data)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s=
elf=2E_partial_acc_msg =3D b&quot;&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        self=2E_protocol_acc_msg =3D &quot;&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_acc_frag=
ment_length =3D 980</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        self=2E_acc_negotiated_protocols =3D []</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    async def send_acc_msg(self, protocol: str, msg: bytes):</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;&quot;&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Sends out =
an ACC to the server using the specified ACC message length</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        :param protocol:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        :param msg:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        :param fragment_length=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        :return:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;&quot;&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if pro=
tocol not in self=2E_acc_negotiated_protocols:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            logger=2Eerror(f&quot;Error: trying =
to send ACC message with protocol &quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                         f&quot;{protocol} is not in t=
he negotiated list of &quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                         f&quot;protocols ({self=2E_acc_negotiated=
_protocols})&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # See init=
=2Ec for the explanation for the length calculation</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        max_header_size =3D len(&quot;ACC=
,&quot;) + len(protocol) + 1 + 4 + 1 + 2 + 1</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        # calculate fragment size with base64 encoding</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        fragment_length =3D self=
=2E_acc_fragment_length * 6 // 8 - max_header_size</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        commands =3D []</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        for part_start in range(0, len(msg), fragment_lengt=
h):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            msg_part =3D msg[part_s=
tart:part_start + fragment_length]</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            # This creates a multiline base64 message but th=
at is what</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   # we want for the management interface to have a not overlong</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            # lines</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            b64msg =3D base64=
=2Eencodebytes(msg_part)=2Edecode()</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         flags =3D &quot;6&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            if part_start + fragment_length &lt; len(msg):</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                flags +=
=3D &quot;F&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            commands=
=2Eappend(f&quot;acc-msg\n{protocol}\n{flags}\n{b64msg}\nEND&quot;)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        cmd_futures =3D []</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        for command in commands:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            cmd_futures=2E=
append(self=2Equeue_command(command))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       cmd_results: Tuple[OmiCommandResult] =3D await asyncio=2Egather(*cmd=
_futures)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        for cmd_result in cmd=
_results:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  if cmd_result=2Eerror:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                logger=2Eerror(f&quot;Error: sending ACC message faile=
d: {cmd_result}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def recv_not=
ify_ACC_PROTOCOLS(self, args):</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        params =3D args=2Esplit(&quot;,&quot;)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        acc_params =3D {}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        for p in params:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            k, v =3D p=2Esplit(&quot;=3D&quot=
;, 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ac=
c_params[k=2Estrip()] =3D v=2Estrip()</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       self=2E_acc_negotiated_protocols =3D acc_params[&#39;protocols&#39;]=
=2Esplit(&quot;:&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E=
_acc_fragment_length =3D int(acc_params[&#39;message_len&#39;])</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    def recv_notify_ACC(self, args):</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        protocol, fragment, b64ms=
g =3D args=2Esplit(&quot;,&quot;, 2)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if self=2E_partial_acc_msg and self=2E_protocol_acc_msg !=3D protocol=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            logger=
=2Eerror(f&quot;Received ACC message with protocol {protocol} before &quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
      f&quot;previous ACC message with protocol {self=2E_protocol_acc_msg} =
was complete&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            self=2E_partial_acc_msg =3D b&quot;&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        try:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            msg =3D base64=2Edecodebytes(b64msg=2Eencode())</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            self=2E_partial=
_acc_msg +=3D msg</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          self=2E_protocol_acc_msg =3D protocol</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        except Exception as e:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            logger=2Eerror(f&quot;Er=
ror parsing ACC message: {e}&quot;, exc_info=3DTrue)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            self=2E_partial_acc_msg =3D b=
&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        fragmented =3D frag=
ment !=3D &quot;0&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        logger=2Edebug(</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            f&quot;Received ACC message (fragment {fragmented}, pro=
tocol {protocol!r}), with payload {msg=2Edecode()!r}&quot;)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        # Message is not yet complete=2E Wait for more=
 fragments=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if fragmented:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if not self=2Ed=
ispatch_to_handler(f&quot;receive_acc_{protocol}&quot;, self=2E_partial_acc=
_msg):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            l=
ogger=2Einfo(f&quot;Received unhandled ACC protocol: {protocol}&quot;)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        self=2E_partial_acc_msg =3D b&quo=
t;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sel=
f=2E_protocol_acc_msg =3D &quot;&quot;</span><br><span>diff --git a/sample/=
management/omi_server_demo=2Epy b/sample/management/omi_server_demo=2Epy</s=
pan><br><span>new file mode 100755</span><br><span>index 0000000=2E=2Ea5862=
32</span><br><span>--- /dev/null</span><br><span>+++ b/sample/management/om=
i_server_demo=2Epy</span><br><span>@@ -0,0 +1,305 @@</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#! /usr/bin/env python3</span><br><span s=
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
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=
mport asyncio</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import=
 logging</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from asynci=
o import Future</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from=
 base64 import standard_b64decode</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+from dataclasses import field, dataclass</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+from typing import Dict, Optional</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+from omi_server_protocol import OMIServerProt=
ocol, ConnectedClient</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+from omi_tools import run_main, start_management_protocol, ConnectData</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+from omi_tools import =
openvpn_escape</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+# This implement a small=
 demonstration of using the</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# OpenVPN Access Server Management Interface (OMI)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+# and a script that does various act=
ion on the client depending</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# on the username the user connects with</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# ensure that you have a proper certificate ba=
sed authentication setup</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+# before using this script</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# (e=2Eg=2E https://github=2Ecom/openvpn/openvpn/blob/master/do=
c/man-sections/example-fingerprint=2Erst)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+# usage:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# --mana=
gement /path/to/omi_server_demo=2Epy unix-script</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+# The main purpose of this script is to test/force certain client=
/server</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# behaviour=
=2E As a test script this is done on the username but also serves</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# as an example how to implem=
ent something similar for normal usage=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# if a username is prefixed with url it uses the old OPEN_URL method (e=
=2Eg=2E urlrick)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - fail: sends AUTH_=
FAILED</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - failn: se=
nds AUTH_FAILED wiht \n</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# - failtemp: sends AUTH_FAILED,TEMP:Go away for a while</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# - failtemp42: sends AUTH_FAILED,=
TEMP and backoff for 42s</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#     - failtempnr: sends AUTH_FAILED,TEMP and instructs to go the nex=
t remote</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - success=
: sends AUTH_SUCCESS</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# - faildelay: sends AUTH_FAILED after 20s</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+# - successdelay: sends AUTH_SUCCESS after 20s</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+# - rick: sends you to a=
 certain youtube site and auth you</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+# - openvpn: sends you to community=2Eopenvpn=2Enet</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# - totp: Does crtext based =
2FA with secret &quot;totpinsecuretotp&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+# - google: sends you to https://www=2Egoogle=2Eco=
m/search?q=3Dhidden without any flags</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+# - googleext: sends you to https://www=2Egoogle=2Ecom/se=
arch?q=3Dexternal with external flags and WEBAUTH \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#         - dnssec: send only dnssec serv=
ers</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - nodns: no dn=
s servers</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - dnssec=
fb: dns server with fallback to dns without dnnsec</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+# - dnsdhcp: dns options and dhcp_options</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+# - dnsport: dns serve=
r with custom port</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
 - failaccdpc1: auth failed message indicating that the client is missing d=
pc1 ACC support=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
 - failaccdpc1user: auth failed message indicating that the client is missi=
ng dpc1 ACC support indicating a auth-token and user for reconnecting</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#     - failaccflower: au=
th failed message indicating that the client is missing flower and power AC=
C support=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - def=
ault: push DNS 8=2E8=2E8=2E8 and default route</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+# - notify: Gives the client a message to displa=
y to the user via notify protocol</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# The=
 hard-coded secret</span><br><span style=3D"color: hsl(120, 100%, 40%);">+t=
otp_secret =3D &quot;totpinsecuretotp&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+logging=2EbasicConfig()</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+logger =3D logging=2EgetLogger(__name__)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+logger=2EsetLevel(logging=2EINFO)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+try:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    import pyotp</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+except ImportError:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    logger=2Einfo(&quot;pyotp module not found=2E TOTP testing disab=
led&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+@dataclass</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+class ServerDemoConnectedClient(ConnectedClient):</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    # Remember the key-id =
that we authenticated</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    authenticated_kid: int =3D -1</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    env: Dict[str, str] =3D field(default_factory=3Ddict)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+class ServerDemoProtocol(OMIServerProtocol):</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    def __init__(self, finish_futu=
re: Future, connect_data: ConnectData =3D None):</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        super()=2E__init__(finish_future, conn=
ect_data)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        se=
lf=2E_connected_client_class =3D ServerDemoConnectedClient</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    def client_event_ESTABLISHED(self, client: ServerDe=
moConnectedClient, kid: int, env: Dict, extra: str):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        print(f&quot;CLient connected: {c=
lient}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    def client_event_CONN=
ECT(self, client: ServerDemoConnectedClient, kid: int, env: Dict, extra: st=
r) -&gt; None:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   print(f&quot;Authenticating client {client=2Ecid}, {kid}&quot;)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        client=2Eauthenticat=
ed_kid =3D kid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   client=2Eenv =3D env</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        asyncio=
=2Ecreate_task(self=2Edo_client_auth(client, kid))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    def client_event_REAUTH(self, client: ServerDemoConnectedCl=
ient, kid: int, env: dict, extra: str):</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        print(f&quot;Re-authenticating client {client},=
 {kid}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  client=2Eenv =3D env</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        _ =3D self=2Equeue_command(f&quot;client-auth-nt {client=2Ecid} =
{kid}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    async def deny_client(self, client: Serve=
rDemoConnectedClient, kid: int, reason: str,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                          client_reason: Optional[=
str] =3D None) -&gt; None:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        # Note, for this test script sending your real reason if you=
 do not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # sp=
ecify a client reason is okay=2E In a real environment, this kind</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        # of information is p=
otentially bad</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if not client_re=
ason:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            cl=
ient_reason =3D reason</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        client_deny =3D f&#39;client-deny {client=2Ecid} {kid} &quot;{op=
envpn_escape(reason)}&quot; &quot;{openvpn_escape(client_reason)}&quot;&#39=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        await self=
=2Equeue_command(client_deny)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    async=
 def do_client_auth(self, client: ServerDemoConnectedClient, kid: int) -&gt=
; None:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        user=
name =3D client=2Eenv=2Eget(&quot;username&quot;, &quot;(empty username)&qu=
ot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        # success</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if username=2Estartswith(&qu=
ot;url&quot;):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       username =3D username[3:]</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            method =3D &quot;openurl&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            webauth =3D &quot;OPEN_URL:=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            method =
=3D &quot;webauth&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            webauth =3D &quot;WEB_AUTH::&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if username =3D=3D &#39;fail&#39; or &#39;UV_FAIL&#39; =
in client=2Eenv:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         await self=2Edeny_client(client, kid, &quot;fail&quot;)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        elif username =3D=3D &=
#39;failtemp&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           await self=2Edeny_client(client, kid, &quot;TEMP:Go away for a w=
hile&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
elif username =3D=3D &#39;failn&#39;:</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            await self=2Edeny_client(client, kid, &quot;B=
onus new line for you!\n&quot;)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        elif username =3D=3D &#39;failn2&#39;:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            await self=2Edeny_client=
(client, kid, &quot;Bonus new line for you!\nand another one\n&quot;)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        elif username =3D=
=3D &#39;failtemp42&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            await self=2Edeny_client(client, kid, &quot;TEMP[backoff =
42]:Go away for a 42s&quot;)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        elif username =3D=3D &#39;failtempnr&#39;:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            await self=2Edeny_clien=
t(client, kid, &quot;TEMP[backoff 11,advance remote]:Annoy the next server!=
&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        elif=
 username =3D=3D &#39;failaccdpc1&#39;:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            await self=2Edeny_client(client, kid,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
          &quot;ACC[protocol dpc1]: To connect to this server you need to u=
pgrade to a client that supports the OpenVPN Inc device posture protocol, e=
=2Eg=2E OpenVPN Connect version 1=2E2=2E3 or later&quot;)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        elif username =3D=3D &#39;fai=
laccflower&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         await self=2Edeny_client(client, kid, &quot;ACC[protocol flower po=
wer]: You need to embrace the flower power&quot;)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        elif username =3D=3D &#39;failaccdpc1=
user&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   await self=2Edeny_client(client, kid,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                   &quot;ACC[protocol =
flower power, user c3VjY2Vzcw=3D=3D, pass MTIzNDU2Nzg=3D]: Please come back=
 again  after you enabled dpc1&quot;)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        elif username =3D=3D &#39;success&#39;:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            await self=2Esend=
_client_auth(client, kid)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        elif username =3D=3D &#39;faildelay&#39;:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            await asyncio=2Esleep(20)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            await sel=
f=2Edeny_client(client, kid, &quot;I thought 20s about it and rejected you =
after that time&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        elif username =3D=3D &#39;successdelay&#39;:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            await asyncio=2Esleep(20)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            await sel=
f=2Esend_client_auth(client, kid)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        elif username=2Estartswith(&#39;totp&#39;):</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            timeout =3D 90</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            extra =3D =
f&quot;CR_TEXT:E,R:Please enter your TOTP code, {username}!&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            logger=2Einfo(f&q=
uot;The TOTP the client needs to provide is: {self=2Eget_current_totp_code(=
)}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  await self=2Esend_pending_auth(client, kid, extra, timeout)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        elif username =3D=3D &#39=
;rick&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    await asyncio=2Esleep(3)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            await self=2Esend_pending_auth(client, kid, webauth + =
&quot;https://www=2Eyoutube=2Ecom/watch?v=3DdQw4w9WgXcQ&quot;)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            await asyncio=2Eslee=
p(10)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            aw=
ait self=2Edeny_client(client, kid, &quot;I got you&quot;)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        elif username =3D=3D &#39;op=
envpn&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    await self=2Esend_pending_auth(client, kid, webauth + &quot;https://com=
munity=2Eopenvpn=2Enet&quot;)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            await self=2Esend_client_auth(client, kid)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        elif username =3D=3D &=
#39;googleext&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            await self=2Esend_pending_auth(client, kid, &quot;WEB_AUTH:exte=
rnal:https://www=2Egoogle=2Ecom/search?q=3Dexternal&quot;)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            await asyncio=2Esleep(10=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            await =
self=2Esend_client_auth(client, kid)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        elif username =3D=3D &#39;google&#39;:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            await self=2Esend_p=
ending_auth(client, kid, &quot;WEB_AUTH::https://www=2Egoogle=2Ecom/search?=
q=3Dexternal&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            await asyncio=2Esleep(10)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            await self=2Esend_client_auth(client, kid)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        elif username =
=3D=3D &#39;special&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            extra =3D f&quot;CR_TEXT:E:This special username is known=
, doing nothing, really&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            await self=2Esend_pending_auth(client, kid, extra)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        elif username =
in [&#39;dnssec&#39;, &#39;nodns&#39;, &#39;dnssecfb&#39;, &#39;dnsdhcp&#39=
;, &#39;dnsport&#39;, &#39;default&#39;]:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            await asyncio=2Esleep(1)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            await self=2Esend_client=
_auth(client, kid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       elif username =3D=3D &quot;notify&quot;:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            await self=2Esend_pending_auth(clie=
nt, kid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                              &quot;NOTIFY::Please wait for 23s to let the =
server think if it want to admit you&quot;)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            await asyncio=2Esleep(23)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            await self=2Esend_cli=
ent_auth(client, kid)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        else:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        await self=2Edeny_client(client, kid,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                                   f&quot;The use=
rname you used ({username}) is unknown, please pick one that I know&quot;)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    async def send_client_auth(self, cl=
ient: ServerDemoConnectedClient, kid: int) -&gt; None:</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        username =3D client=2Eenv=2Eget(=
&quot;username&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        config =
=3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if username =3D=3D &#39;dnssec&#39;:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            config +=3D &quot;&quot;&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            push &quot;dns ser=
ver 7 address 8=2E8=2E8=2E8:53&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            push &quot;dns server 7 dnssec yes&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;&quot;&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        elif u=
sername =3D=3D &#39;nodns&#39;:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            pass</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        elif username =3D=3D &#39;dnssecfb&#39;:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            config +=3D &quot;&quot;&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            pu=
sh &quot;dns server 7 address 8=2E8=2E8=2E8:53&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            push &quot;dns server 7 dnsse=
c yes&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    push &quot;dns server 10 address 8=2E8=2E8=2E8&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            push &quot;dns server 10 t=
ransport DoT&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           push &quot;dns server 12 address 8=2E8=2E8=2E8&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            push &quot;dns serv=
er 12 transport DoH&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            push &quot;dns server 19 address 8=2E8=2E8=2E8:53&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;&qu=
ot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        el=
if username =3D=3D &#39;dnsdhcp&#39;:</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            config +=3D &quot;&quot;&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            push &quot;dns server =
19 address 8=2E8=2E8=2E8:53&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            push &quot;dhcp-options dns server 1=2E1=2E1=2E1&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &q=
uot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     elif username =3D=3D &#39;dnsport&#39;:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            config +=3D &quot;&quot;&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            push &quot;dns =
server 20 address 8=2E8=2E8=2E8:5353&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            &quot;&quot;&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        elif username =3D=3D &#39;default=
&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c=
onfig +=3D &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            push &quot;dns server 19 address 8=2E8=2E8=2E8:53&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            push =
&quot;dhcp-options dns server 1=2E1=2E1=2E1&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            push &quot;redirect-gateway def1&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &q=
uot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if not config:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            await s=
elf=2Equeue_command(f&quot;client-auth-nt {client=2Ecid} {kid}&quot;)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        else:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            await self=2Equeue_=
command(f&quot;client-auth {client=2Ecid} {kid}\n{config}\nEND\n&quot;)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    async def send_pending_auth(self, cli=
ent: ServerDemoConnectedClient, kid: int, extra: str,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                timeout: =
int =3D 180) -&gt; None:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        auth_pending_totp_cmd =3D f&#39;client-pending-auth {client=2E=
cid} {kid} &quot;{openvpn_escape(extra)}&quot; {timeout}&#39;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        await self=2Equeue_comman=
d(auth_pending_totp_cmd)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def client=
_event_CR_RESPONSE(self, client: ServerDemoConnectedClient, kid: int, env: =
Dict, extra: str) -&gt; None:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        client=2Eenv =3D env</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        asyncio=2Ecreate_task(self=2Eclient_crresponse(c=
lient, kid, extra))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    @staticmethod</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def get_current_t=
otp_code() -&gt; str:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        try:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       import pyotp</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        except ImportError:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            return &quot;pyotp not found&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        totp =3D pyotp=2ETOTP(totp_secret)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return totp=2Enow()</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    async def client_crresponse(self, client: S=
erverDemoConnectedClient, kid: int, response: str) -&gt; None:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        # Try importing the pyot=
p here to allow the script run without pyotp</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        # installed</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        try:</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            import pyotp</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        except ImportError:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            await self=2Edeny_client(client,=
 kid, &quot;pytop module not found=2E Cannot do MFA testing&quot;)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            return</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        try:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            response =3D standard_b64decode(response)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            response =
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
0000=2E=2Ece84bbe</span><br><span>--- /dev/null</span><br><span>+++ b/sampl=
e/management/omi_server_protocol=2Epy</span><br><span>@@ -0,0 +1,239 @@</sp=
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
cc_msg: bytes =3D b&quot;&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    _protocol_acc_msg: str =3D &quot;&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    _kid_acc_msg: int =3D -1</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    _acc_fragment_length: int =
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
>+            client=2E_partial_acc_msg =3D b&quot;&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if client=2E_partial_acc_msg and client=2E_kid_a=
cc_msg !=3D kid:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         logger=2Eerror(f&quot;Recieved ACC message with different key id {=
kid} before &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                        f&quot;previous ACC message with key id {client=2E_=
kid_acc_msg} &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                         f&quot;was complete=2E This is currently not handl=
ed&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  client=2E_partial_acc_msg =3D b&quot;&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        try:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            msg =3D base64=2Edecodebytes(b64msg=2Eencode())</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            client=2E_partial_acc_m=
sg +=3D msg</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    client=2E_protocol_acc_msg =3D protocol</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            client=2E_kid_acc_msg =3D kid</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            # Message is not yet complete=2E Wai=
t for more fragments=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            if fragment !=3D &quot;0&quot;:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                return</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            handler_name =3D f&quot;receive_acc_client_{protoco=
l}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 if not self=2Edispatch_to_handler(handler_name, client, kid, client=2E_par=
tial_acc_msg):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           logger=2Einfo(f&quot;Received unhandled ACC protocol: {protocol}=
, handler {handler_name} not found&quot;)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            client=2E_partial_acc_msg =3D b&quot;&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            client=2E_protocol_acc_m=
sg =3D protocol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        except Exceptio=
n as e:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
logger=2Eerror(f&quot;Error parsing ACC message from client: {e}&quot;, exc=
_info=3DTrue)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        client=2E_partial=
_acc_msg =3D b&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def recv=
_notify_BYTECOUNT_CLI(self, args: str) -&gt; None:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        cid, bytes_received, bytes_sent =3D =
args=2Esplit(&quot;,&quot;, 2)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
client =3D self=2E_connected_clients=2Eget(int(cid))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if client:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            client=2Ebytes_sent =3D int(b=
ytes_sent)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   client=2Ebytes_received =3D int(bytes_received)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    def _trigger_client_event(self, event: str, cid: int, kid: =
int, env: Optional[Dict], extra):</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        client =3D self=2E_connected_clients=2Eget(cid, None)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        # Remember ACC protocol option=
s if present</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if event =3D=3D &quot;CONNECT&quot; and &quot;acc_protocols&quot; in env:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            client=
=2Eacc_negotiated_protocols =3D [p=2Estrip() for p in env[&quot;acc_protoco=
ls&quot;]=2Esplit(&quot;:&quot;)]</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            client=2E_acc_fragment_length =3D int(env[&#39;ac=
c_message_len&#39;])</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        handler_na=
me =3D f&quot;client_event_{event}&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if not self=2Edispatch_to_handler(handler_name=
, client, kid, env, extra):</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            logger=2Einfo(f&quot;Client event {event} not handled=
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
=3D"color: hsl(120, 100%, 40%);">+            # This creates a multiline ba=
se64 message but that is what</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            # we want for the management interface to have a not =
overlong</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 # lines</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 b64msg =3D base64=2Eencodebytes(msg_part)=2Edecode()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            flags =3D &quot;6&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            if part_start + fragment_length =
&lt; len(msg):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           flags +=3D &quot;F&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         commands=2Eappend(f&quot;client-acc-msg {client=2Ecid} {kid}\n{pro=
tocol}\n{flags}\n{b64msg}\nEND&quot;)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       cmd_futures =3D []</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        for command in commands:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            cmd_futures=2Eappend(self=2Equeue_command(co=
mmand))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        cmd_results: Tuple[OmiC=
ommandResult] =3D await asyncio=2Egather(*cmd_futures)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        for cmd_result in cmd_results:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if cmd_re=
sult=2Eerror:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          logger=2Eerror(f&quot;Error: sending ACC message failed: {cmd_res=
ult}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    def client_event_DISCON=
NECT(self, client: ConnectedClient, kid: int, _env: dict, _extra: str):</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_remove_=
client(client=2Ecid)</span><br><span>diff --git a/sample/management/omi_too=
ls=2Epy b/sample/management/omi_tools=2Epy</span><br><span>new file mode 10=
0644</span><br><span>index 0000000=2E=2E560f6ac</span><br><span>--- /dev/nu=
ll</span><br><span>+++ b/sample/management/omi_tools=2Epy</span><br><span>@=
@ -0,0 +1,92 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#! /=
usr/bin/python3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Co=
pyright (c) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+# Copyright (c) 2026 Arne Schwabe &lt;=
arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Permission is=
 hereby granted, free of charge, to any person obtaining a copy</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# of this software and associat=
ed documentation files (the &quot;Software&quot;), to deal</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+# in the Software without restrictio=
n, including without limitation the rights</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+# to use, copy, modify, merge, publish, distribute, =
sublicense, and/or sell</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# copies of the Software, and to permit persons to whom the Software is=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# furnished to do s=
o, subject to the following conditions:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# The above copyright notice and this permission notice shall be included=
 in all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# copies or =
substantial portions of the Software=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# IMPL=
IED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+# FITNESS FOR A PARTICULAR=
 PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE =
FOR ANY CLAIM, DAMAGES OR OTHER</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E, ARISING FROM,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# O=
UT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN TH=
E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# SOFTWARE=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+import asyncio</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+import os</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+import re</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+from dataclasses import dataclass</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+from omi import OmiProtocol, ConnectionProperties</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+@dataclass</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+class ConnectData(ConnectionProperties):</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    socket: str</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn_escape_=
re =3D re=2Ecompile(r&#39;([&quot;\\])&#39;)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+filt_ctrl_re =3D re=2Ecompile(r&quot;[\x00-\x1f\x7=
f]+&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+def openvpn_escape(text):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;Escapes a string to=
 be safely used for OpenVPN inside</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    a quoted string</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
Something like &#39;client-deny 2 3 &quot;{openvpn_escape(reason)}&quot; &q=
uot;{openvpn_escape(client_reason)}&quot;&#39;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    text =3D re=2Esub(filt_ctrl_re, &#39; &#3=
9;, text)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    text =
=3D re=2Esub(openvpn_escape_re, r&#39;\\\1&#39;, text)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return text=2Erstrip()</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+def get_unix_script_environment() -&gt; ConnectData | None:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    password =3D os=2Eenviron=
=2Eget(&quot;MANAGEMENT_PASSWORD&quot;, None)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    socket =3D os=2Eenviron=2Eget(&quot;MANAGEMEN=
T_SOCKET&quot;, None)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if password a=
nd socket:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn ConnectData(password=3Dpassword, socket=3Dsocket)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    else:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return None</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+async def st=
art_management_protocol(connect_data: ConnectData, protocol: OmiProtocol):<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # Get a referenc=
e to the event loop as we plan to use</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    # low-level APIs=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    loop =3D asyncio=2Eget_running_loop()</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    finish_future =3D loop=2Ecreate_future()</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    print(f&quot;Connecting to management so=
cket {connect_data=2Esocket}=2E=2E=2E&quot;)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    transport, protocol =3D await loop=2Ecreate_un=
ix_connection(lambda: protocol(finish_future, connect_data),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                  =
                          connect_data=2Esocket)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return transport, protocol, finish_future</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+de=
f run_main(main_func, connect_parameters: ConnectData =3D None):</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    Example function to run=
 a main function to be either using the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    environment variable for the unix-script or to use=
=2E If the unix-script</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    environment are detected, the function will run the main_func</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    with the ConnectData f=
rom the environment=2E If the environment variables</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    are not available, it will fall back =
to the connect_parameters</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if present=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    :param connect_parameters:  fallback connect parameters if unix-scr=
ipt is not available</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    :param main_func:           The function to call=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    :return:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    unix_script_parameters =3D get_unix_s=
cript_environment()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if unix_script_parameters:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        asyncio=2Erun(main_func(unix_script_parameters))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    elif connect_parameters=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        asyncio=2E=
run(main_func(connect_parameters))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    else:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        print(f&quot;Must be called via unix-script&quot;)</span><br><=
/pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1859?usp=3Demail">change 1859</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1859?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1859 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: Name of user not set #1000061 </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></htm=
l>
--A9kl5J7E3iQ=--


--===============2429238907986157267==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2429238907986157267==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2429238907986157267==--

