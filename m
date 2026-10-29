Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B6D606A31D
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WayAe24s;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EHZv/88Q;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=UK3/qdWa;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HgZoqS/7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=o2WLLIRY/2dStYfXHu2Cv6bweZj4NUWaQ9PPZILXODw=; b=WayAe24sIVFHSEncDa5q8AOhaB
	Dr8ir6K986kfleui0WZ5WweG86LgHuldPMJ22CALgWPYzKkVENaMUfqMga+ZiPdZ77TDIJtDN70NH
	wD3BeBrOVGkIToI8EBY3W/g17IRhmtdT9goXV3HjTDAYZXXzoNO5D81/IaG3eyirxYb8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMTYZ-000000001mA-3Qlm;
	Thu, 29 Oct 2026 17:04:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMTYY-000000001m3-3eZI
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 17:04:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u071lXkFldduiVEcRtO2c+4rxerDRPSx5m1EAwbRw2g=; b=EHZv/88Q72i3vw2WdNM4YA0odZ
 yOg6SHdisKu59xffpKVAb89o6Wo2/TJXOc3TWsgdOWuGPLazxl3RCJl5kAdNCxLcjARBpPcFpzdJv
 cgSiWGKDKeKCIxK+71+3ZXSrOuwy8ICV/btgqpM+6nhrAYjpHs0mzfkc0xcgT8fReZSs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u071lXkFldduiVEcRtO2c+4rxerDRPSx5m1EAwbRw2g=; b=UK3/qdWaSm1idIw9/Kl3ggYoi8
 QMhNxis2xkflpiBjeXcoO2YWOv5sBUn12CiAuuE1kuvZbiOFff/EQEO6Kjqm2tYtV7fZOYs2vP60l
 LoP0U178Wu/ku0s9192GWodrWEQefa9TeI+bf202kIZzEEnPX0M7A9m3jl/SIgUD3gG4=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMTYP-000000000Qh-1Ayu for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 17:04:50 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48c45111bebso1149580f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 10:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793293475; x=1793898275; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=u071lXkFldduiVEcRtO2c+4rxerDRPSx5m1EAwbRw2g=;
 b=HgZoqS/7Or7u3OBGS4kCfJD2SNvRpoe+9I3qi3g00y8CAoyYdMqSaf8TREYuhtSI/n
 62daud9jH5WCZTAKQ12+28oVDH2AXe4DDmnL6ln6Pqf0KJYa2MkuFEcP0ByVcNuIPZgZ
 nHsP8wUj+dEEOLK/ySgwM44fhkCeadpC0PyclRR2bO0VnfhOSOjOnzoi6hhgQWORL79o
 6QJmflWjp60zw8pQ7He9brQAtdnDDo6hKd7Z07QAkBwetJZb0zYJlrMNORg/ysHXLKh0
 QElnQG1d4jjpArf690XegzQJYnUUzwdfZilEPYVAUrch3f8HRoIhypN2WNiRD7miQCfp
 Az0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793293475; x=1793898275;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=u071lXkFldduiVEcRtO2c+4rxerDRPSx5m1EAwbRw2g=;
 b=K+RB3DQHTqWK9LjMHyU3gWGHT6HS7ChtP8383wryZHDXPnO9wJxBkavSLHzirRr+JN
 PX8Tj8Hs4UrpFm2otYrfAoc5795wDptTZCtTjXEgRRPtjZhmS6U/+aTUucqpAbac4Jgl
 foAhRLCv7HGussRvVIwKZz4k/C0nfzy97EJFS7zT2oTqBPofjaKWjX8MJLKUsSvQMBoF
 VrSxybE1plOidt81cBia6+PIMTTRnx8gk9w+uP/Va76mkkc04LuPx+rw2Sw0MDVZGC/S
 hFzNyEXCUzamVB+1HrXNRaC6aYCBEA5xyNGSLk03L/PqCh/GySgWsmOFO615JYR3SU/E
 6cuA==
X-Gm-Message-State: AFq9FYIUFERHEjuEURIKCiZiF5lfn0/Uwh4IyuRHWvobSRVvEJIFM4/a
 XQJARTkFY3AGy4utPhWpBEHj0Tr8g07SJjM1Xgh1KcG7uTFkg/lDgF00ukzxj/wJdEpykInAbVs
 MwKn4gmQM+iAPEcg79OuLK/lYzA+RjePFC/SB4cYrWOEgOR045JwxB5SBKyvc0DqdDznkNBSB97
 y+0sUPVA==
X-Gm-Gg: AYBFou3Cpq/X2QMJx7LlqmLyxk7Ixrw+vzCjFTRErmcYSq1w8udHJPYHWJPiIIXwdkC
 jKzEl/fmyt0mv9dlRLhJGWLBuU3V6q57l8188rtZteiDcvUaUiUgXlc4NAlxISjqRHm7hNwQyY7
 gKr0E0NmCQVyc4VxSjBt48kYwJbX+DYtBVN0eeO/c3uxWedo/Y6W7rhP4Qrz5Bn5VcivNY5adAM
 bw4YAXIzx7063V3kQZvn5eHhRMuhysDzTgeOUXmEMtdyMGsMAEhHCotbXA5oCFzXN0m/toL2Q+j
 5A2MUaWFWUa8F3+UgMpN8aBU2LzSeGyRJErunEPbCbb6PaVJzeIhtLORUZwqRbcs9nAO8pY6OBe
 Zphe1UNYPfhMPepcQ4hM0APk4SMK1K7Q1B/2lO+zCziK4A3uvNjbqz8tcdKDQC47kD7zwYphn8O
 lyGEjp99Weq7AQovIAKGAp+f47uNKcleztMCpam9qi7R9WyllHX3Jx3LW32WjL6PcXpJ5HvjvsG
 keFxc31ryqQ+8QmZu8b27HT64QZ/O+TOftuEXsDlLAlacQ7YaxLLxL2dhBQzlQ6+cEbxFhXLkFI
 p99agkidkgPDdktTNwst5h7pGJQvWNM4RUkxkAZ9l8pdOnRaZvaX9V4C/pat/j8xhkPtQQQKKAz
 MKtPHHdous2zI8KbqbScnJ0boejE3dH+NXXOxszFnog+PRB25wNFPqt4UCZ3H5k3KRfUw0+JBax
 uGw4FlKcOnlgYwx/W8BVx7hA==
X-Received: by 2002:a05:6000:c88:b0:48e:82f:48fc with SMTP id
 ffacd0b85a97d-48e5d2f3fd2mr11966518f8f.31.1793293473567; 
 Thu, 29 Oct 2026 10:04:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6dfa0d58sm364802f8f.33.2026.10.29.10.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 10:04:32 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 29 Oct 2026 17:04:27 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5
X-Gerrit-Change-Number: 1859
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1859?usp=email>
X-Gerrit-Commit: 62f2e92139f2da7f4d5d29f94c3a4d995ff56e41
In-Reply-To: <gerrit.1787327336000.Ib09bafabf612e9501ea757647c86a450c73228a5@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ib09bafabf612e9501ea757647c86a450c73228a5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkliMDliYWZhYmY2MTJlOTUwMWVhNzU3NjQ3Yzg2YTQ1MGM3MzIyOGE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1a33f93edd1042e1f3ef1b93687c79f521436048-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xMTYP-000000000Qh-1Ayu
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
Content-Type: multipart/mixed; boundary="===============2957653820509318376=="
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_HTML_MOSTLY,MISSING_HEADERS,SPF_HELO_PASS,
	SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2957653820509318376==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="T9J2DxYAYX0="; charset=UTF-8

--T9J2DxYAYX0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Arne Schwabe has upl=
oaded a new patch set (#6)=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
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
A sample/management/omi=2Epy
A samp=
le/management/omi_client_protocol=2Epy
A sample/management/omi_server_demo=
=2Epy
A sample/management/omi_server_protocol=2Epy
A sample/management/omi_=
tools=2Epy
5 files changed, 1,059 insertions(+), 0 deletions(-)


  git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/59/1859/6

diff -=
-git a/sample/management/omi=2Epy b/sample/management/omi=2Epy
new file mod=
e 100644
index 0000000=2E=2Ec2c47b6
--- /dev/null
+++ b/sample/management/o=
mi=2Epy
@@ -0,0 +1,288 @@
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
+# This is an example implementation in python and as=
yncio to drive OpenVPN's
+# management interface (OMI)=2E The permissive li=
cense allows you to use this
+# code in other projects=2E
+
+"""
+Implement=
ation of the OpenVPN management interface (OMI) protocol=2E
+
+This impleme=
nts the generic part of the OMI protocol that is common
+to both client and=
 server=2E
+"""
+import asyncio
+import logging
+import re
+from asyncio im=
port Future, Event, Task, Queue
+from dataclasses import dataclass
+from da=
tetime import datetime
+from typing import override, List, Optional
+
+logg=
er =3D logging=2EgetLogger(__name__)
+logger=2EsetLevel(logging=2EINFO)
+
+=

+@dataclass
+class OmiCommandResult:
+    command: str
+    result: List[s=
tr]
+    error: bool
+    status_text: str
+
+
+@dataclass
+class OmiSendCo=
mmand:
+    command: str
+    result: Future[OmiCommandResult]
+
+
+@datacl=
ass
+class ConnectionProperties:
+    """
+    Properties for connecting to=
 the management interface=2E
+    """
+    password: Optional[str]
+
+
+cla=
ss OmiProtocol(asyncio=2EProtocol):
+    def __init__(self, finish_future: =
Future, connect_data: ConnectionProperties):
+        super()=2E__init__()
=
+        self=2E_connect_data: ConnectionProperties =3D connect_data
+
+   =
     self=2Ebytes_received: int =3D 0
+        self=2Ebytes_sent: int =3D 0=

+        self=2Eversion: int =3D -1
+        self=2ErecvBuffer: str =3D ""=

+        self=2Efinish_future: Future =3D finish_future
+        self=2Etr=
ansport: Optional[asyncio=2ETransport] =3D None
+
+        # Event to allow=
 waiting for status of the underlying socket
+        # to become available=
 for writing
+        self=2E_can_send: Event =3D asyncio=2EEvent()
+      =
  self=2E_can_send=2Eclear()
+
+        # Event to track when the managemen=
t interface is ready to receive
+        # commands from us
+        self=
=2E_management_ready: Event =3D asyncio=2EEvent()
+        self=2E_manageme=
nt_ready=2Eclear()
+        self=2E_response =3D []
+
+        self=2E_resp=
onse_ready: Event =3D asyncio=2EEvent()
+        self=2E_response_ready=2Ec=
lear()
+
+        self=2E_send_queue: Queue =3D asyncio=2EQueue()
+        =
self=2E_send_task: Task =3D asyncio=2Ecreate_task(self=2E_send_loop())
+
+ =
   @override
+    def eof_received(self) -> None:
+        logger=2Einfo('E=
OF received=2E Shutting down=2E')
+        self=2E_stop()
+
+    @override
=
+    def connection_lost(self, exc: Exception | None) -> None:
+        if =
exc:
+            logger=2Ewarn(f'Connection lost ({exc})=2E Shutting down=
=2E')
+        else:
+            logger=2Ewarn(f'Connection lost=2E Shutti=
ng down=2E')
+        self=2E_stop()
+
+    def _stop(self) -> None:
+     =
   if not self=2Efinish_future=2Edone():
+            # If we are disconnec=
ted or stop, there is no sense trying
+            # to still send commands=
 to the management interface
+            self=2E_send_task=2Ecancel()
+   =
         self=2Efinish_future=2Eset_result(True)
+
+    async def _send_loo=
p(self) -> None:
+        while True:
+            command: OmiSendCommand =
=3D await self=2E_send_queue=2Eget()
+            await self=2E_can_send=2E=
wait()
+            self=2Esend_line(command=2Ecommand)
+
+            resp=
onse: List[str] =3D []
+            response_complete =3D False
+
+        =
    # This is a bit brittle as it will loop forever if not getting a
+     =
       # line that starts with ERROR or SUCCESS=2E With a normal OpenVPN
+ =
           # daemon that speak the correct protocol this should not be a
+ =
           # problem
+            while not response_complete:
+           =
     await self=2E_response_ready=2Ewait()
+
+                line =3D self=
=2E_response=2Epop(0)
+                response=2Eappend(line)
+
+         =
       if not self=2E_response:
+                    self=2E_response_ready=
=2Eclear()
+
+                lastline =3D response[-1]
+                if=
 lastline=2Estartswith('ERROR:'):
+                    status =3D False
+  =
                  response_complete =3D True
+                    _, status=
_text =3D lastline=2Esplit(":", 1)
+
+                elif lastline=2Estart=
swith('SUCCESS:'):
+                    status =3D True
+                  =
  response_complete =3D True
+                    _, status_text =3D lastli=
ne=2Esplit(":", 1)
+                elif lastline =3D=3D "END":
+          =
          status =3D True
+                    response_complete =3D True
+=
                    status_text =3D None
+                else:
+          =
          # Other lines do not complete a response
+                    pas=
s
+
+            # logger=2Edebug(f'Result received command: {response}')
+=
            result =3D OmiCommandResult(command=2Ecommand, response[:-1], s=
tatus, status_text)
+
+            command=2Eresult=2Eset_result(result)
+ =
           logger=2Edebug(f"Command done=2E")
+
+    @override
+    def pau=
se_writing(self) -> None:
+        self=2E_can_send=2Eclear()
+
+    @overr=
ide
+    def resume_writing(self) -> None:
+        self=2E_can_send=2Eset(=
)
+
+    @override
+    def connection_made(self, transport) -> None:
+    =
    peername =3D transport=2Eget_extra_info('peername')
+        logger=2Ei=
nfo('Connection from {}'=2Eformat(peername))
+        self=2Etransport =3D =
transport
+        self=2E_can_send=2Eset()
+
+        # OMI expects us to =
authenticate with the password just on
+        # its own on a line
+      =
  if self=2E_connect_data=2Epassword:
+            self=2Etransport=2Ewrite=
(f"{self=2E_connect_data=2Epassword}\r\n"=2Eencode())
+
+    @override
+   =
 def data_received(self, data: bytes) -> None:
+        # OMI protocol is p=
ure text so decode everything as UTF-8
+        message =3D data=2Edecode()=

+        self=2ErecvBuffer +=3D message
+
+        parts =3D self=2ErecvBu=
ffer=2Esplit("\r\n")
+
+        # pass complete lines to recvLine
+        =
for part in parts[:-1]:
+            logger=2Edebug(f'Line received: {part!=
r}')
+            self=2Erecv_line(part)
+
+        # keep the last incompl=
ete line for the next call
+        self=2ErecvBuffer =3D parts[-1]
+
+    =
def recv_line(self, line: str) -> None:
+        if line=2Estartswith(">"):=

+            # this is an asynchronous message
+            self=2Erecv_no=
tify(line)
+        else:
+            # normal message get passed to the _=
send_loop task
+            self=2E_response=2Eappend(line)
+            se=
lf=2E_response_ready=2Eset()
+
+    def recv_notify(self, line: str) -> Non=
e:
+        if not ":" in line:
+            logger=2Ewarning("Invalid line=
 received: " + line)
+            return
+
+        command, args =3D line[=
1:]=2Esplit(":", 1)
+
+        # do dynamic dispatch based on command to ca=
ll a handler
+        if hasattr(self, f"recv_notify_{command}"):
+        =
    handler =3D getattr(self, f"recv_notify_{command}")
+            handle=
r(args)
+            return
+
+        logger=2Einfo("Unknown notify line r=
eceived: " + line)
+
+    def recv_notify_INFO(self, args: str) -> None:
+ =
       m =3D re=2Ematch(r"OpenVPN Management Interface Version (?P<version>=
\d+)", args)
+        if m:
+            self=2Eversion =3D int(m=2Egroup("=
version"))
+            self=2E_management_ready=2Eset()
+        else:
+  =
          logger=2Ewarning(f"Unknown INFO line received: {args}")
+
+    de=
f recv_notify_BYTECOUNT(self, args: str) -> None:
+        bytes_sent, byte=
s_received =3D args=2Esplit(",", 1)
+        self=2Ebytes_sent =3D int(byte=
s_sent)
+        self=2Ebytes_received =3D int(bytes_received)
+
+    async=
 def _release_hold_task(self, hold_time: int =3D 0) -> None:
+        await=
 asyncio=2Esleep(hold_time)
+        await self=2Equeue_command("hold relea=
se")
+
+    def recv_notify_HOLD(self, args):
+        _text, hold_time =3D=
 args=2Esplit(":", 1)
+        hold_time =3D int(hold_time)
+
+        asyn=
cio=2Ecreate_task(self=2E_release_hold_task(hold_time))
+
+    def queue_co=
mmand(self, command: str) -> Future[OmiCommandResult]:
+        cmd =3D Omi=
SendCommand(command, Future())
+        self=2E_send_queue=2Eput_nowait(cmd=
)
+        return cmd=2Eresult
+
+    async def management_ready(self) -> i=
nt:
+        """
+        Waits until the management interface is ready=2E =
Returns the management interface version=2E
+        """
+        await sel=
f=2E_management_ready=2Ewait()
+        return self=2Eversion
+
+    def se=
nd_line(self, line: str) -> None:
+        logger=2Edebug(f"Sending line: {=
line}")
+        self=2Etransport=2Ewrite(f"{line}\n"=2Eencode())
+
+    ""=
"
+    Set the bytecount interval=2E Use 0 to disable
+    """
+
+    async=
 def set_bytecount_interval(self, interval: int):
+        return await sel=
f=2Equeue_command(f"bytecount {interval}")
+
+    async def enable_log(self=
):
+        return await self=2Equeue_command("log on")
+
+    def recv_not=
ify_LOG(self, args):
+        # >LOG:1786453401,D,MANAGEMENT: CMD 'bytecoun=
t 30'
+        timestamp, level, message =3D args=2Esplit(",", 2)
+
+      =
  timestamp =3D datetime=2Efromtimestamp(int(timestamp))
+        level =3D=
 level=2Estrip()
+        message =3D message=2Estrip()
+        self=2Elog=
_message(timestamp, level, message)
+
+    def log_message(self, time, leve=
l, message):
+        """
+        A new log message has been received=2E T=
his method is intended
+        to be overridden by a subclass to handle th=
e log messages=2E
+        :param time:    time in local time format
+     =
   :param level:   level of the log message
+        :param message: the lo=
g message itself
+        :return:
+        """
+        logger=2Edebug(f"R=
eceived log message: {time}, {level}, {message}")
diff --git a/sample/manag=
ement/omi_client_protocol=2Epy b/sample/management/omi_client_protocol=2Epy=

new file mode 100644
index 0000000=2E=2Ed50cbef
--- /dev/null
+++ b/sample=
/management/omi_client_protocol=2Epy
@@ -0,0 +1,134 @@
+#!/usr/bin/env pyth=
on3
+# Copyright (c) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+# Copyright (c=
) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+#
+# Permission is hereby granted=
, free of charge, to any person obtaining a copy
+# of this software and as=
sociated documentation files (the "Software"), to deal
+# in the Software w=
ithout restriction, including without limitation the rights
+# to use, copy=
, modify, merge, publish, distribute, sublicense, and/or sell
+# copies of =
the Software, and to permit persons to whom the Software is
+# furnished to=
 do so, subject to the following conditions:
+#
+# The above copyright noti=
ce and this permission notice shall be included in all
+# copies or substan=
tial portions of the Software=2E
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WI=
THOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITE=
D TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE=
 AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE
+# AUTHORS OR COPYRIGHT HOLDE=
RS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN AC=
TION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+# OUT OF OR IN CONNECTI=
ON WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+# SOFTWARE=2E
+im=
port base64
+import logging
+from typing import Tuple
+
+from omi import Om=
iProtocol, OmiCommandResult
+
+logger =3D logging=2EgetLogger(__name__)
+lo=
gger=2EsetLevel(logging=2EDEBUG)
+
+
+
+class OMIClientProtocol(OmiProtocol=
):
+    """
+    Implement the management protocol for the client  
+    ""=
"
+    def __init__(self, finish_future, connect_data):
+        super()=2E=
__init__(finish_future=3Dfinish_future, connect_data=3Dconnect_data)
+     =
   self=2E_partial_acc_msg =3D ""
+        self=2E_protocol_acc_msg =3D ""
=
+        self=2E_acc_fragment_length =3D 980
+        self=2E_acc_negotiate=
d_protocols =3D []
+
+    async def send_acc_msg(self, protocol: str, msg: =
bytes):
+        """
+        Sends out an ACC to the server using the spec=
ified ACC message length
+        :param protocol:
+        :param msg:
+  =
      :param fragment_length:
+        :return:
+        """
+        if pr=
otocol not in self=2E_acc_negotiated_protocols:
+            logger=2Eerror=
(f"Error: trying to send ACC message with protocol {protocol} is not in the=
 negotiated list of protocols ({self=2E_acc_negotiated_protocols})")
+
+   =
     # See init=2Ec for the explanation for the length calculation
+       =
 max_header_size =3D len("ACC,") + len(protocol) + 1 + 4 + 1 + 2 + 1
+
+   =
     # calculate fragment size with base64 encoding
+        fragment_lengt=
h =3D self=2E_acc_fragment_length * 6 // 8 - max_header_size
+
+        com=
mands =3D []
+        for part_start in range(0, len(msg), fragment_length)=
:
+
+            msg_part =3D msg[part_start:part_start + fragment_length]
=
+            b64msg =3D base64=2Eencodebytes(msg_part)=2Edecode()
+
+      =
      flags =3D "6"
+            if part_start + fragment_length < len(msg)=
:
+                flags =3D "6:F"
+
+            commands=2Eappend(f"acc-m=
sg\n{protocol}\n{flags}\n{b64msg}\nEND")
+
+        cmd_futures =3D []
+   =
     for command in commands:
+            cmd_futures=2Eappend(self=2Equeu=
e_command(command))
+
+        cmd_results: Tuple[OmiCommandResult] =3D awa=
it asyncio=2Egather(*cmd_futures)
+
+        for cmd_result in cmd_results:=

+            if cmd_result=2Eerror:
+                logger=2Eerror(f"Erro=
r: sending ACC message failed: {cmd_result}")
+
+
+    def recv_notify_ACC_=
PROTOCOLS(self, args):
+        params =3D args=2Esplit(",")
+        acc_p=
arams =3D { }
+
+        for p in params:
+            k, v  =3D p=2Esplit(=
"=3D", 1)
+            acc_params[k=2Estrip()] =3D v=2Estrip()
+
+        s=
elf=2E_acc_negotiated_protocols =3D acc_params['protocols']=2Esplit(":")
+
=
+        self=2E_acc_fragment_length =3D int(acc_params['message_len'])
+
+=
    def recv_notify_ACC(self, args):
+        protocol, fragment, b64msg =
=3D args=2Esplit(",", 2)
+
+        if self=2E_partial_acc_msg and self=2E_=
protocol_acc_msg !=3D protocol:
+            logger=2Eerror(f"Recieved ACC =
message with protocol {protocol} before "
+                          f"prev=
ious ACC message with protocol {self=2E_protocol_acc_msg} was complete")
+ =
           self=2E_partial_acc_msg =3D ""
+
+
+        try:
+            ms=
g =3D base64=2Edecodebytes(b64msg=2Eencode())
+            self=2E_partial_=
acc_msg +=3D msg=2Edecode()
+            self=2E_protocol_acc_msg =3D proto=
col
+        except Exception as e:
+            logger=2Eerror(f"Error par=
sing ACC message: {e}", exc_info=3DTrue)
+            self=2E_partial_acc_m=
sg =3D ""
+            return
+
+        fragmented =3D fragment !=3D "0"
+=
        logger=2Edebug(f"Received ACC message (fragment {fragmented}, proto=
col {protocol!r}), with payload {msg=2Edecode()!r}")
+
+
+        # Message=
 is not yet complete=2E Wait for more fragments=2E
+        if fragmented:
=
+            return
+
+        if hasattr(self, f"receive_acc_{protocol}"):=

+            handler =3D getattr(self, f"receive_acc_{protocol}")
+       =
     logger=2Edebug(f"Calling handler {handler}")
+            try:
+      =
          handler(self=2E_partial_acc_msg)
+            except Exception as=
 e:
+                logger=2Eerror(f"Error parsing ACC message: {e}", exc_=
info=3DTrue)
+                self=2E_partial_acc_msg =3D ""
+        else:=

+            logger=2Einfo(f"Received unhandled ACC protocol: {protocol}")=

+
+        self=2E_partial_acc_msg =3D ""
+        self=2E_protocol_acc_ms=
g =3D ""
\ No newline at end of file
diff --git a/sample/management/omi_ser=
ver_demo=2Epy b/sample/management/omi_server_demo=2Epy
new file mode 100755=

index 0000000=2E=2Ef5db689
--- /dev/null
+++ b/sample/management/omi_serve=
r_demo=2Epy
@@ -0,0 +1,297 @@
+#! /usr/bin/env python3
+# Copyright (c) 202=
6 OpenVPN Inc <sales@openvpn=2Enet>
+# Copyright (c) 2026 Arne Schwabe <arn=
e@rfc2549=2Eorg>
+#
+# Permission is hereby granted, free of charge, to any=
 person obtaining a copy
+# of this software and associated documentation f=
iles (the "Software"), to deal
+# in the Software without restriction, incl=
uding without limitation the rights
+# to use, copy, modify, merge, publish=
, distribute, sublicense, and/or sell
+# copies of the Software, and to per=
mit persons to whom the Software is
+# furnished to do so, subject to the f=
ollowing conditions:
+#
+# The above copyright notice and this permission n=
otice shall be included in all
+# copies or substantial portions of the Sof=
tware=2E
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KI=
ND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF M=
ERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E =
IN NO EVENT SHALL THE
+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLA=
IM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT O=
R OTHERWISE, ARISING FROM,
+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR =
THE USE OR OTHER DEALINGS IN THE
+# SOFTWARE=2E
+
+import asyncio
+import l=
ogging
+from asyncio import Future
+from base64 import standard_b64decode
+=
from typing import Dict, Optional
+
+from omi_server_protocol import OMISer=
verProtocol, ConnectedClient
+from omi_tools import run_main, start_managem=
ent_protocol, ConnectData
+from omi_tools import openvpn_escape
+
+# This i=
mplement a small demonstration of using the
+# OpenVPN Access Server Manage=
ment Interface (OMI)
+# and a script that does various action on the client=
 depending
+# on the username the user connects with
+# ensure that you hav=
e a proper certificate based authentication setup
+# before using this scri=
pt
+# (e=2Eg=2E https://github=2Ecom/openvpn/openvpn/blob/master/doc/man-se=
ctions/example-fingerprint=2Erst)
+
+# usage:
+# --management /path/to/omi_=
server_demo=2Epy unix-script
+
+# The main purpose of this script is to tes=
t/force certain client/server
+# behaviour=2E As a test script this is done=
 on the username but also serves
+# as an example how to implement somethin=
g similar for normal usage=2E
+#
+# if a username is prefixed with url it u=
ses the old OPEN_URL method (e=2Eg=2E urlrick)
+#
+# - fail: sends AUTH_FAI=
LED
+# - failn: sends AUTH_FAILED wiht \n
+# - failtemp: sends AUTH_FAILED,=
TEMP:Go away for a while
+# - failtemp42: sends AUTH_FAILED,TEMP and backof=
f for 42s
+#     - failtempnr: sends AUTH_FAILED,TEMP and instructs to go t=
he next remote
+# - success: sends AUTH_SUCCESS
+# - faildelay: sends AUTH_=
FAILED after 20s
+# - successdelay: sends AUTH_SUCCESS after 20s
+# - rick:=
 sends you to a certain youtube site and auth you
+# - openvpn: sends you t=
o community=2Eopenvpn=2Enet
+# - totp: Does crtext based 2FA with secret "t=
otpinsecuretotp"
+# - google: sends you to https://www=2Egoogle=2Ecom/searc=
h?q=3Dhidden without any flags
+# - googlext: sends you to https://www=2Ego=
ogle=2Ecom/search?q=3Dexternal with external flags and WEBAUTH \
+#        =
 - dnssec: send only dnssec servers
+# - nodns: no dns servers
+# - dnssecf=
b: dns server with fallback to dns without dnnsec
+# - dnsdhcp: dns options=
 and dhcp_options
+# - dnsport: dns server with custom port
+# - failaccdpc=
1: auth failed message indicating that the client is missing dpc1 ACC suppo=
rt=2E
+# - failaccdpc1user: auth failed message indicating that the client =
is missing dpc1 ACC support indicating a auth-token and user for reconnecti=
ng
+#     - failaccflower: auth failed message indicating that the client i=
s missing flower and power ACC support=2E
+# - default: push DNS 8=2E8=2E8=
=2E8 and default route
+# - notify: Gives the client a message to display t=
o the user via notify protocol
+
+# The hard-coded secret
+totp_secret =3D =
"totpinsecuretotp"
+
+logging=2EbasicConfig()
+logger =3D logging=2EgetLogg=
er(__name__)
+logger=2EsetLevel(logging=2EINFO)
+
+try:
+    import pyotp
+=
except ImportError:
+    logger=2Einfo("pyotp module not found=2E TOTP test=
ing disabled")
+
+
+class ServerDemoConnectedClient(ConnectedClient):
+    =
# Remember the key-id that we authenticated
+    authenticated_kid: int =3D=
 -1
+    env: Dict =3D {}
+
+
+class ServerDemoProtocol(OMIServerProtocol):=

+    def __init__(self, finish_future: Future, connect_data: ConnectData =
=3D None):
+        super()=2E__init__(finish_future, connect_data)
+      =
  self=2E_connected_client_class =3D ServerDemoConnectedClient
+
+    def c=
lient_event_ESTABLISHED(self, client: ServerDemoConnectedClient, kid: int, =
env: Dict, extra: str):
+        print(f"CLient connected: {client}")
+
+  =
  def client_event_CONNECT(self, client: ServerDemoConnectedClient, kid: in=
t, env: Dict, extra: str) -> None:
+        print(f"Authenticating client {=
client=2Ecid}, {kid}")
+        client=2Eauthenticated_kid =3D kid
+       =
 client=2Eenv =3D env
+
+        asyncio=2Ecreate_task(self=2Edo_client_aut=
h(client, kid))
+
+    async def deny_client(self, client: ServerDemoConnec=
tedClient, kid: int, reason: str,
+                          client_reason:=
 Optional[str] =3D None) -> None:
+        # Note, for this test script sen=
ding your real reason if you do not
+        # specify a client reason is o=
kay=2E In a real environment, this kind
+        # of information is potent=
ially bad
+
+        if not client_reason:
+            client_reason =3D r=
eason
+        client_deny =3D f'client-deny {client=2Ecid} {kid} "{openvpn=
_escape(reason)}" "{openvpn_escape(client_reason)}"'
+        await self=2E=
queue_command(client_deny)
+
+    async def do_client_auth(self, client: Se=
rverDemoConnectedClient, kid: int) -> None:
+        username =3D client=2E=
env=2Eget("username")
+
+        # success
+        if username=2Estartswit=
h("url"):
+            username =3D username[3:]
+            method =3D "o=
penurl"
+            webauth =3D "OPEN_URL:"
+        else:
+            me=
thod =3D "webauth"
+            webauth =3D "WEB_AUTH::"
+
+        if user=
name =3D=3D 'fail' or 'UV_FAIL' in client=2Eenv:
+            await self=2E=
deny_client(client, kid, "fail")
+        elif username =3D=3D 'failtemp':
=
+            await self=2Edeny_client(client, kid, "TEMP:Go away for a whil=
e")
+        elif username =3D=3D 'failn':
+            await self=2Edeny_c=
lient(client, kid, "Bonus new line for you!\n")
+        elif username =3D=
=3D 'failn2':
+            await self=2Edeny_client(client, kid, "Bonus new=
 line for you!\nand another one\n")
+        elif username =3D=3D 'failtemp=
42':
+            await self=2Edeny_client(client, kid, "TEMP[backoff 42]:G=
o away for a 42s")
+        elif username =3D=3D 'failtempnr':
+           =
 await self=2Edeny_client(client, kid, "TEMP[backoff 11,advance remote]:Ann=
oy the next server!")
+        elif username =3D=3D 'failaccdpc1':
+       =
     await self=2Edeny_client(client, kid,
+                               =
    "ACC[protocol dpc1]: To connect to this server you need to upgrade to a=
 client that supports the OpenVPN Inc device posture protocol, e=2Eg=2E Ope=
nVPN Connect version 1=2E2=2E3 or later")
+        elif username =3D=3D 'fa=
ilaccflower':
+            await self=2Edeny_client(client, kid, "ACC[proto=
col flower power]: You need to embrace the flower power")
+        elif use=
rname =3D=3D 'failaccdpc1user':
+            await self=2Edeny_client(clien=
t, kid,
+                                   "ACC[protocol flower power, use=
r c3VjY2Vzcw=3D=3D, pass MTIzNDU2Nzg=3D]: Please come back again  after you=
 enabled dpc1")
+        elif username =3D=3D 'success':
+            await=
 self=2Esend_client_auth(client, kid)
+        elif username =3D=3D 'failde=
lay':
+            await asyncio=2Esleep(20)
+            await self=2Edeny=
_client(client, kid, "I thought 20s about it and rejected you after that ti=
me")
+        elif username =3D=3D 'successdelay':
+            await async=
io=2Esleep(20)
+            await self=2Esend_client_auth(client, kid)
+   =
     elif username=2Estartswith('totp'):
+            timeout =3D 90
+     =
       extra =3D f"CR_TEXT:E,R:Please enter your TOTP code, {username}!"
+ =
           logger=2Einfo(f"The TOTP the client needs to provide is: {self=
=2Eget_current_totp_code()}")
+            await self=2Esend_pending_auth(c=
lient, kid, extra, timeout)
+        elif username =3D=3D 'rick':
+        =
    await asyncio=2Esleep(3)
+            await self=2Esend_pending_auth(cl=
ient, kid, webauth + "https://www=2Eyoutube=2Ecom/watch?v=3DdQw4w9WgXcQ")
+=
            await asyncio=2Esleep(10)
+            await self=2Edeny_client=
(client, kid, "I got you")
+        elif username =3D=3D 'openvpn':
+      =
      await self=2Esend_pending_auth(client, kid, webauth + "https://commun=
ity=2Eopenvpn=2Enet")
+            await self=2Esend_client_auth(client, ki=
d)
+        elif username =3D=3D 'googleext':
+            await self=2Esen=
d_pending_auth(client, kid, "WEB_AUTH:external:https://www=2Egoogle=2Ecom/s=
earch?q=3Dexternal")
+            await asyncio=2Esleep(10)
+            aw=
ait self=2Esend_client_auth(client, kid)
+        elif username =3D=3D 'goo=
gle':
+            await self=2Esend_pending_auth(client, kid, "WEB_AUTH::h=
ttps://www=2Egoogle=2Ecom/search?q=3Dexternal")
+            await asyncio=
=2Esleep(10)
+            await self=2Esend_client_auth(client, kid)
+     =
   elif username =3D=3D 'special':
+            extra =3D f"CR_TEXT:E:This =
special username is known, doing nothing, really"
+            await self=
=2Esend_pending_auth(client, kid, extra)
+        elif username in ['succes=
s', 'dnssec', 'nodns', 'dnssecfb', 'default']:
+            await asyncio=
=2Esleep(1)
+            await self=2Esend_client_auth(client, kid)
+      =
  elif username =3D=3D "notify":
+            await self=2Esend_pending_aut=
h(client, kid,
+                                         "NOTIFY:Please wai=
t for 23s to let the server think if it want to admit you")
+            aw=
ait asyncio=2Esleep(23)
+            await self=2Esend_client_auth(client, =
kid)
+        else:
+            await self=2Edeny_client(client, kid,
+   =
                                f"The username you used ({username}) is unk=
nown, please pick one that I know")
+
+    async def send_client_auth(self,=
 client: ServerDemoConnectedClient, kid: int) -> None:
+        username =
=3D client=2Eenv=2Eget("username")
+
+        config =3D ""
+        if use=
rname =3D=3D 'dnssec':
+            config +=3D """
+            push "dns =
server 7 address 8=2E8=2E8=2E8:53"
+            push "dns server 7 dnssec y=
es"
+            """
+        elif username =3D=3D 'nodns':
+            pa=
ss
+        elif username =3D=3D 'dnssecfb':
+            config +=3D """
+=
            push "dns server 7 address 8=2E8=2E8=2E8:53"
+            push =
"dns server 7 dnssec yes"
+            push "dns server 10 address 8=2E8=2E=
8=2E8"
+            push "dns server 10 transport DoT"
+            push "d=
ns server 12 address 8=2E8=2E8=2E8"
+            push "dns server 12 transp=
ort DoH"
+            push "dns server 19 address 8=2E8=2E8=2E8:53"
+      =
      """
+        elif username =3D=3D 'dnsdhcp':
+            config +=3D=
 """
+            push "dns server 19 address 8=2E8=2E8=2E8:53"
+          =
  push "dhcp-options dns server 1=2E1=2E1=2E1"
+            """
+        el=
if username =3D=3D 'dnsport':
+            config +=3D """
+            pus=
h "dns server 20 address 8=2E8=2E8=2E8:5353"
+            """
+        elif=
 username =3D=3D 'default':
+            config +=3D """
+            push =
"dns server 19 address 8=2E8=2E8=2E8:53"
+            push "dhcp-options dn=
s server 1=2E1=2E1=2E1"
+            push "redirect-gateway def1"
+        =
    """
+
+        if not config:
+            await self=2Equeue_command(f=
"client-auth-nt {client=2Ecid} {kid}")
+        else:
+            await se=
lf=2Equeue_command(f"client-auth {client=2Ecid} {kid}\n{config}\nEND\n")
+
=
+    async def send_pending_auth(self, client: ServerDemoConnectedClient, k=
id: int, extra: str,
+                                timeout: int =3D 180)=
 -> None:
+        auth_pending_totp_cmd =3D f'client-pending-auth {client=
=2Ecid} {kid} "{extra}" {timeout}'
+        await self=2Equeue_command(auth=
_pending_totp_cmd)
+
+    def client_event_CR_RESPONSE(self, client: Server=
DemoConnectedClient, kid: int, env: Dict, extra: str) -> None:
+        cli=
ent=2Eenv =3D env
+        asyncio=2Ecreate_task(self=2Eclient_crresponse(c=
lient, kid, extra))
+
+    @staticmethod
+    def get_current_totp_code() -=
> str:
+        try:
+            import pyotp
+        except ImportError:=

+            return "pyotp not found"
+
+        totp =3D pyotp=2ETOTP(tot=
p_secret)
+        return totp=2Enow()
+
+    async def client_crresponse(s=
elf, client: ServerDemoConnectedClient, kid: int, response: str) -> None:
+=
        # Try importing the pyotp here to allow the script run without pyot=
p
+        # installed
+        try:
+            import pyotp
+        exc=
ept ImportError:
+            await self=2Edeny_client(client, kid, "pytop =
module not found=2E Cannot do MFA testing")
+            return
+
+        =
try:
+            response =3D standard_b64decode(response)
+            re=
sponse =3D response=2Edecode()=2Estrip()
+        except Exception as e:
+ =
           await self=2Edeny_client(client, kid, f"Decoding totp response f=
ailed: {e}")
+            return
+
+        totp =3D pyotp=2ETOTP(totp_secr=
et)
+
+        logger=2Einfo(f"\nCR: expected totp '{totp=2Enow()}', respon=
se was '{response}'\n")
+        # Check if the code is valid (and also all=
ow code +/-1)
+
+        if totp=2Everify(response, valid_window=3D1):
+   =
         await self=2Esend_client_auth(client, kid)
+        else:
+       =
     await self=2Edeny_client(client, kid, "TOTP verification failed")
+
+
=
+async def main(connect_data: ConnectData):
+    transport, protocol, finis=
h_future =3D await start_management_protocol(connect_data, ServerDemoProtoc=
ol)
+
+    management_version =3D await protocol=2Emanagement_ready()
+    =
logger=2Einfo(f"Management interface version: {management_version}")
+
+   =
 await protocol=2Eenable_log()
+
+    await protocol=2Eset_bytecount_interv=
al(5)
+
+    await finish_future
+
+
+if __name__ =3D=3D '__main__':
+    r=
un_main(main)
diff --git a/sample/management/omi_server_protocol=2Epy b/sam=
ple/management/omi_server_protocol=2Epy
new file mode 100644
index 0000000=
=2E=2Eab36a8d
--- /dev/null
+++ b/sample/management/omi_server_protocol=2Ep=
y
@@ -0,0 +1,235 @@
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
+import asyncio
+import base64
+impo=
rt logging
+from asyncio import Future
+from dataclasses import dataclass
+=
from typing import List, Tuple, Dict
+
+from omi import OmiProtocol, Connec=
tionProperties, OmiCommandResult
+
+logger =3D logging=2EgetLogger(__name__=
)
+logger=2EsetLevel(logging=2EINFO)
+
+
+@dataclass
+class ConnectedClient=
:
+    """This represents a connected client instance=2E"""
+    cid: int
+=
    bytes_sent: int =3D 0
+    bytes_received: int =3D 0
+    _partial_acc_=
msg: str =3D ""
+    _protocol_acc_msg: str =3D ""
+    _kid_acc_msg: int =
=3D -1
+    _acc_fragment_length: int =3D 980
+    acc_negotiated_protocols=
: List[str] =3D []
+
+
+class OMIServerProtocol(OmiProtocol):
+    """
+   =
 This class implement common method for the OMI when OpenVPN is running
+  =
  as a server=2E These are mainly helper function and functionality that
+ =
   is only available/useful for OpenVPN running as a server
+    """
+
+   =
 # Connected client class, can be overridden by subclasses to store
+    # =
more information about the connected client
+    _connected_client_class =
=3D ConnectedClient
+
+    def __init__(self, finish_future: Future, connec=
t_data: ConnectionProperties):
+        super()=2E__init__(finish_future, c=
onnect_data)
+        self=2E_reset_pending_client_event()
+        self=2E=
_connected_clients:Dict =3D {}
+
+    def _reset_pending_client_event(self)=
 -> None:
+        self=2E_pending_client_event:str =3D ""
+        self=2E=
_pending_client_event_cid:int =3D -1
+        self=2E_pending_client_event_=
kid:int =3D -1
+        self=2E_pending_client_event_extra_args:str =3D Non=
e
+        self=2E_client_env:Dict =3D {}
+
+    def recv_notify_CLIENT(sel=
f, args: str) -> None:
+        event, args =3D args=2Esplit(",", 1)
+
+   =
     if event =3D=3D "ENV":
+            if args =3D=3D "END":
+           =
     # Client environment is finished, trigger previous client
+           =
     # event that contained an ENV
+                self=2E_trigger_client_=
event(self=2E_pending_client_event, self=2E_pending_client_event_cid,
+    =
                                       self=2E_pending_client_event_kid, se=
lf=2E_client_env,
+                                           self=2E_pendi=
ng_client_event_extra_args)
+                self=2E_reset_pending_client_e=
vent()
+            else:
+                key, value =3D args=2Esplit("=3D=
", 1)
+                self=2E_client_env[key] =3D value
+
+        elif ev=
ent in ("ESTABLISHED", "DISCONNECT"):
+            # This event is followed=
 by a client environment=2E Wait for
+            # the client environment =
to be completed before triggering the event
+            cid =3D int(args)
=
+
+            self=2E_pending_client_event =3D event
+            self=2E_=
pending_client_event_cid =3D int(cid)
+            self=2E_pending_client_e=
vent_kid =3D None
+            if event =3D=3D "ESTABLISHED":
+            =
    self=2E_add_client(cid)
+
+        elif event in ("CONNECT", "REAUTH"):=

+            # This event is similar to other event but also carries the k=
ey-id
+            cid, kid =3D args=2Esplit(",", 1)
+            cid, kid =
=3D int(cid), int(kid)
+            self=2E_add_client(cid)
+
+            =
self=2E_pending_client_event =3D event
+            self=2E_pending_client_=
event_cid =3D int(cid)
+            self=2E_pending_client_event_kid =3D in=
t(kid)
+        elif event =3D=3D "CR_RESPONSE":
+            # This event =
is similar to CONNECT and REAUTH but has an extra
+            # parameter =
with the crtext response
+            cid, kid, response =3D args=2Esplit("=
,", 2)
+            cid, kid =3D int(cid), int(kid)
+
+            self=2E_=
pending_client_event =3D event
+            self=2E_pending_client_event_ci=
d =3D int(cid)
+            self=2E_pending_client_event_kid =3D int(kid)
+=
            self=2E_pending_client_event_extra_args =3D response
+        e=
lif event =3D=3D "ACC":
+            cid, kid, acc_args =3D args=2Esplit(",=
", 2)
+            self=2E_trigger_client_event(event, int(cid), int(kid), =
None, acc_args)
+        else:
+            logger=2Einfo(f"Client event {e=
vent} not handled=2E (message: {args!r})")
+
+    def client_event_ACC(self=
, client: ConnectedClient, kid: int, env: Dict, extra: str) -> None:
+     =
   protocol, fragment, b64msg =3D extra=2Esplit(",", 2)
+
+        if clien=
t=2E_partial_acc_msg and client=2E_protocol_acc_msg !=3D protocol:
+       =
     logger=2Eerror(f"Recieved ACC message with protocol {protocol} before =
"
+                         f"previous ACC message with protocol {client=2E=
_protocol_acc_msg} was complete")
+            client=2E_partial_acc_msg =
=3D ""
+
+        if client=2E_partial_acc_msg and client=2E_kid_acc_msg !=
=3D kid:
+            logger=2Eerror(f"Recieved ACC message with different =
key id {kid} before "
+                         f"previous ACC message with=
 key id {client=2E_kid_acc_msg} "
+                         f"was complete=
=2E This is currently not handled")
+            client=2E_partial_acc_msg =
=3D ""
+
+        try:
+            msg =3D base64=2Edecodebytes(b64msg=2Ee=
ncode())
+            client=2E_partial_acc_msg +=3D msg=2Edecode()
+      =
      client=2E_protocol_acc_msg =3D protocol
+            client=2E_kid_ac=
c_msg =3D kid
+
+            # Message is not yet complete=2E Wait for more=
 fragments=2E
+            if fragment !=3D "0":
+                return
+
=
+            handler_name =3D f"receive_acc_client_{protocol}"
+           =
 if hasattr(self, handler_name):
+                handler =3D getattr(self,=
 handler_name)
+                logger=2Edebug(f"Calling handler {handler}"=
)
+                try:
+                    handler(client, kid, client=2E=
_partial_acc_msg)
+                except Exception as e:
+                =
    logger=2Eerror(f"Error parsing ACC message: {e}", exc_info=3DTrue)
+   =
         else:
+                logger=2Einfo(f"Received unhandled ACC prot=
ocol: {protocol}, handler {handler_name} not found")
+
+            client=
=2E_partial_acc_msg =3D ""
+            client=2E_protocol_acc_msg =3D prot=
ocol
+
+        except Exception as e:
+            logger=2Eerror(f"Error =
parsing ACC message from client: {e}", exc_info=3DTrue)
+            client=
=2E_partial_acc_msg =3D ""
+            return
+
+        client=2E_partial=
_acc_msg =3D ""
+
+    def recv_notify_BYTECOUNT_CLI(self, args: str) -> No=
ne:
+        cid, bytes_sent, bytes_received =3D args=2Esplit(",", 2)
+
+  =
      client =3D self=2E_connected_clients=2Eget(int(cid))
+        if clie=
nt:
+            client=2Ebytes_sent =3D int(bytes_sent)
+            clien=
t=2Ebytes_received =3D int(bytes_received)
+
+    def _trigger_client_event=
(self, event: str, cid: int, kid: int, env: dict, extra):
+        client =
=3D self=2E_connected_clients=2Eget(cid, None)
+
+        # Remember ACC pr=
otocol options if present
+        if event =3D=3D "CONNECT" and "acc_proto=
cols" in env:
+            client=2Eacc_negotiated_protocols =3D [p=2Estrip=
() for p in env["acc_protocols"]=2Esplit(":")]
+            client=2E_acc_f=
ragment_length =3D int(env['acc_message_len'])
+
+        handler_name =3D =
f"client_event_{event}"
+        if hasattr(self, handler_name):
+         =
   handler =3D getattr(self, handler_name)
+            handler(client, kid=
, env, extra)
+        else:
+            logger=2Einfo(f"Client event {eve=
nt} not handled=2E Method {handler_name} does not exist=2E")
+
+    def _ad=
d_client(self, cid: int) -> None:
+        if not cid in self=2E_connected_=
clients:
+            self=2E_connected_clients[cid] =3D self=2E_connected_=
client_class(cid=3Dcid)
+
+    def _remove_client(self, cid: int) -> None:
=
+        del self=2E_connected_clients[cid]
+
+    async def get_client_sta=
tus(self) -> OmiCommandResult:
+        cmd_result =3D self=2Equeue_command=
("status 3")
+        return await cmd_result
+
+    async def send_acc_msg=
(self, client: ConnectedClient, kid: int, protocol: str, msg: bytes) -> Non=
e:
+        """
+        Sends out an ACC to the client=2E
+        """
+  =
      if protocol not in client=2Eacc_negotiated_protocols:
+            lo=
gger=2Eerror(f"Error: trying to send ACC message with protocol"
+          =
               f" {protocol} is not in the negotiated list of "
+          =
               f"protocols ({client=2Eacc_negotiated_protocols})")
+
+     =
   # See init=2Ec for the explanation for the length
+        max_header_si=
ze =3D len("ACC,") + len(protocol) + 1 + 4 + 1 + 2 + 1
+
+        # calcula=
te fragment size with base64 encoding
+        fragment_length =3D client=
=2E_acc_fragment_length * 6 // 8 - max_header_size
+
+        commands =3D =
[]
+        for part_start in range(0, len(msg), fragment_length):
+
+     =
       msg_part =3D msg[part_start:part_start + fragment_length]
+         =
   b64msg =3D base64=2Eencodebytes(msg_part)=2Edecode()
+
+            flag=
s =3D "6"
+            if part_start + fragment_length < len(msg):
+       =
         flags =3D "6:F"
+
+            commands=2Eappend(f"client-acc-msg =
{client=2Ecid} {kid}\n{protocol}\n{flags}\n{b64msg}\nEND")
+
+        cmd_f=
utures =3D []
+        for command in commands:
+            cmd_futures=2E=
append(self=2Equeue_command(command))
+
+        cmd_results: Tuple[OmiComm=
andResult] =3D await asyncio=2Egather(*cmd_futures)
+        for cmd_result=
 in cmd_results:
+            if cmd_result=2Eerror:
+                logge=
r=2Eerror(f"Error: sending ACC message failed: {cmd_result}")
diff --git a/=
sample/management/omi_tools=2Epy b/sample/management/omi_tools=2Epy
new fil=
e mode 100644
index 0000000=2E=2E4541f34
--- /dev/null
+++ b/sample/managem=
ent/omi_tools=2Epy
@@ -0,0 +1,105 @@
+#! /usr/bin/python3
+# Copyright (c) =
2026 OpenVPN Inc <sales@openvpn=2Enet>
+# Copyright (c) 2026 Arne Schwabe <=
arne@rfc2549=2Eorg>
+#
+# Permission is hereby granted, free of charge, to =
any person obtaining a copy
+# of this software and associated documentatio=
n files (the "Software"), to deal
+# in the Software without restriction, i=
ncluding without limitation the rights
+# to use, copy, modify, merge, publ=
ish, distribute, sublicense, and/or sell
+# copies of the Software, and to =
permit persons to whom the Software is
+# furnished to do so, subject to th=
e following conditions:
+#
+# The above copyright notice and this permissio=
n notice shall be included in all
+# copies or substantial portions of the =
Software=2E
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY=
 KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES O=
F MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=
=2E IN NO EVENT SHALL THE
+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY=
 CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TO=
RT OR OTHERWISE, ARISING FROM,
+# OUT OF OR IN CONNECTION WITH THE SOFTWARE=
 OR THE USE OR OTHER DEALINGS IN THE
+# SOFTWARE=2E
+import asyncio
+import=
 os
+import re
+from dataclasses import dataclass
+
+from omi import OmiPro=
tocol, ConnectionProperties
+
+
+@dataclass
+class ConnectData(ConnectionPr=
operties):
+    socket: str
+
+
+openvpn_escape_re =3D re=2Ecompile(r'(["\\=
])')
+filt_ctrl_re =3D re=2Ecompile(r"[\x00-\x1f\x7f]+")
+def openvpn_escap=
e(text):
+    """Escapes a string to be safely used for OpenVPN inside
+   =
 a quoted string
+
+    Something like 'client-deny 2 3 "{openvpn_escape(re=
ason)}" "{openvpn_escape(client_reason)}"'
+    """
+    text =3D re=2Esub(=
filt_ctrl_re, ' ', text)
+    text =3D re=2Esub(openvpn_escape_re, r'\\\1',=
 text)
+    return text=2Erstrip()
+
+def get_unix_script_environment() -> =
ConnectData | None:
+    password =3D os=2Eenviron=2Eget("MANAGEMENT_PASSWO=
RD", None)
+    socket =3D os=2Eenviron=2Eget("MANAGEMENT_SOCKET", None)
+
=
+    if password and socket:
+        return ConnectData(password=3Dpasswor=
d, socket=3Dsocket)
+    else:
+        return None
+
+
+async def start_ma=
nagement_protocol(connect_data: ConnectData, protocol=3DOmiProtocol):
+    =
# Get a reference to the event loop as we plan to use
+    # low-level APIs=
=2E
+    loop =3D asyncio=2Eget_running_loop()
+
+    finish_future =3D loo=
p=2Ecreate_future()
+
+    print(f"Connecting to management socket {connect=
_data=2Esocket} with passwd {connect_data=2Epassword[:4]}=2E=2E=2E")
+    t=
ransport, protocol =3D await loop=2Ecreate_unix_connection(lambda: protocol=
(finish_future, connect_data),
+                                           =
                 connect_data=2Esocket)
+
+    return transport, protocol, =
finish_future
+
+
+async def main():
+    transport, protocol, finish_futur=
e =3D await start_management_protocol()
+
+    management_version =3D await=
 protocol=2Emanagement_ready()
+    await protocol=2Eenable_log()
+    prin=
t(f"Management interface version: {management_version}")
+
+    await proto=
col=2Eset_bytecount_interval(5)
+
+    await finish_future
+
+
+def run_mai=
n(main_func, connect_parameters: ConnectData =3D None):
+    """
+    Examp=
le function to run a main function to be either using the
+    environment =
variable for the unix-script or to use=2E If the unix-script
+    environme=
nt are detected, the function will fork and run the main_func
+    with the=
 ConnectData from the environment=2E If the environment variables
+    are =
not available, it will not fork will fall back to the connect_parameters
+ =
   if present=2E
+    :param connect_parameters:  fallback connect paramete=
rs if unix-script is not available
+    :param main_func:           The fun=
ction to call=2E
+    :return:
+    """
+    unix_script_parameters =3D get=
_unix_script_environment()
+    if unix_script_parameters:
+        asyncio=
=2Erun(main_func(unix_script_parameters))
+    elif connect_parameters:
+  =
      asyncio=2Erun(main_func(connect_parameters))
+    else:
+        prin=
t(f"Must be called via unix-script")
+
+
+if __name__ =3D=3D '__main__':
+ =
   run_main(main)

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1859?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: Ib09bafabf612e9501ea757647c86a450c73228a5
Gerrit-Change-Number: 1859
Ger=
rit-PatchSet: 6
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-CC: Name of user not set #1000061
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>

--T9J2DxYAYX0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Arne Schwabe <strong>uploaded=
 patch set #6</strong> to this change=2E</p><p><a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1859?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Add python scripts that demonstrate using the mangement interface<br><b=
r>Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5<br>Signed-off-by: Ar=
ne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>A sample/management/omi=2Ep=
y<br>A sample/management/omi_client_protocol=2Epy<br>A sample/management/om=
i_server_demo=2Epy<br>A sample/management/omi_server_protocol=2Epy<br>A sam=
ple/management/omi_tools=2Epy<br>5 files changed, 1,059 insertions(+), 0 de=
letions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/59/1859/6</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/sample/managemen=
t/omi=2Epy b/sample/management/omi=2Epy</span><br><span>new file mode 10064=
4</span><br><span>index 0000000=2E=2Ec2c47b6</span><br><span>--- /dev/null<=
/span><br><span>+++ b/sample/management/omi=2Epy</span><br><span>@@ -0,0 +1=
,288 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Copyright =
(c) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# Copyright (c) 2026 Arne Schwabe &lt;arne@rfc=
2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+# Permission is hereby =
granted, free of charge, to any person obtaining a copy</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+# of this software and associated docum=
entation files (the &quot;Software&quot;), to deal</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+# in the Software without restriction, inclu=
ding without limitation the rights</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+# to use, copy, modify, merge, publish, distribute, sublicen=
se, and/or sell</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# co=
pies of the Software, and to permit persons to whom the Software is</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+# furnished to do so, subje=
ct to the following conditions:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# The =
above copyright notice and this permission notice shall be included in all<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+# copies or substant=
ial portions of the Software=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# THE =
SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# IMPLIED, INC=
LUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# FITNESS FOR A PARTICULAR PURPOSE=
 AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY =
CLAIM, DAMAGES OR OTHER</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# OUT OF OR=
 IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+# SOFTWARE=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+# This is an example implementation in python and a=
syncio to drive OpenVPN&#39;s</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+# management interface (OMI)=2E The permissive license allows you=
 to use this</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# code =
in other projects=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+&quot;&quot;&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Implementation of t=
he OpenVPN management interface (OMI) protocol=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+This implements the generic part of the OMI protocol that is com=
mon</span><br><span style=3D"color: hsl(120, 100%, 40%);">+to both client a=
nd server=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+&quot;&=
quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import a=
syncio</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import loggin=
g</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import re</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+from asyncio import Future, =
Event, Task, Queue</span><br><span style=3D"color: hsl(120, 100%, 40%);">+f=
rom dataclasses import dataclass</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+from datetime import datetime</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+from typing import override, List, Optional</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+logger =3D logging=2EgetLogger(__name__)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+logger=2EsetLevel(logging=
=2EINFO)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+@dataclass</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+class OmiCommandResult:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    command: str</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    result: List[str]</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    error: bool</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    status_text: str</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+@dataclass</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+class OmiSendCommand:</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    command: str</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    result: Future[OmiCommandRe=
sult]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+@dataclass</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+class ConnectionProperties:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &quot;&quot;&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    Properties for connecting to the management in=
terface=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot=
;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pa=
ssword: Optional[str]</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+class OmiProtocol(asyncio=2EProtocol=
):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def __init__(=
self, finish_future: Future, connect_data: ConnectionProperties):</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        super()=2E__init__()<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_conn=
ect_data: ConnectionProperties =3D connect_data</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        self=2Ebytes_received: int =3D 0</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        self=2Ebytes_sent: int =3D 0</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        self=2Eversion: int =
=3D -1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=
=2ErecvBuffer: str =3D &quot;&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        self=2Efinish_future: Future =3D finish_future</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2Etransport=
: Optional[asyncio=2ETransport] =3D None</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        # Event to allow waiting for status of the underlying socket</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        # to become avai=
lable for writing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      self=2E_can_send: Event =3D asyncio=2EEvent()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        self=2E_can_send=2Eclear()</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        # Event to track when the management =
interface is ready to receive</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        # commands from us</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        self=2E_management_ready: Event =3D asyncio=2EEven=
t()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_=
management_ready=2Eclear()</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        self=2E_response =3D []</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        self=2E_response_ready: Event =3D asyncio=2EEvent()</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        self=2E_response_ready=2Ecl=
ear()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        self=2E_send_queue: Queue=
 =3D asyncio=2EQueue()</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        self=2E_send_task: Task =3D asyncio=2Ecreate_task(self=2E_send_l=
oop())</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    @override</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    def eof_received(self) -&gt; None:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        logger=2Ein=
fo(&#39;EOF received=2E Shutting down=2E&#39;)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        self=2E_stop()</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    @override</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    def connection_lost(self, exc: Exception | None) -&gt; None:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if exc:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            logger=2Ewarn(f&#=
39;Connection lost ({exc})=2E Shutting down=2E&#39;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        else:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            logger=2Ewarn(f&#39;Connection lost=
=2E Shutting down=2E&#39;)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        self=2E_stop()</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def _=
stop(self) -&gt; None:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if not self=2Efinish_future=2Edone():</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            # If we are disconnected or stop, =
there is no sense trying</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            # to still send commands to the management interface</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            self=2E_send_=
task=2Ecancel()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        self=2Efinish_future=2Eset_result(True)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    async def _send_loop(self) -&gt; None:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        while True:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            command: OmiSendCommand =3D a=
wait self=2E_send_queue=2Eget()</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            await self=2E_can_send=2Ewait()</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            self=2Esend_line(command=2E=
command)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            response: List[str=
] =3D []</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 response_complete =3D False</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  # This is a bit brittle as it will loop forever if not getting a</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            # line that star=
ts with ERROR or SUCCESS=2E With a normal OpenVPN</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            # daemon that speak the correct p=
rotocol this should not be a</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            # problem</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            while not response_complete:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                await self=2E_response_re=
ady=2Ewait()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                line =3D s=
elf=2E_response=2Epop(0)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                response=2Eappend(line)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                if not self=2E_response:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                    self=2E_response_ready=2Ecle=
ar()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                lastline =3D respo=
nse[-1]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    if lastline=2Estartswith(&#39;ERROR:&#39;):</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    status =3D False</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    response_c=
omplete =3D True</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 _, status_text =3D lastline=2Esplit(&quot;:&quot;, 1)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                elif lastline=2Estartswit=
h(&#39;SUCCESS:&#39;):</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    status =3D True</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    response_complete =3D True</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    _, status=
_text =3D lastline=2Esplit(&quot;:&quot;, 1)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                elif lastline =3D=3D &quot;END&quo=
t;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
    status =3D True</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    response_complete =3D True</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                    status_text =3D None</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                else:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    # Oth=
er lines do not complete a response</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    pass</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            # logger=2Edebug(f&#39;Result received command: {response}&#3=
9;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            resu=
lt =3D OmiCommandResult(command=2Ecommand, response[:-1], status, status_te=
xt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            command=2Eresult=2Eset_=
result(result)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       logger=2Edebug(f&quot;Command done=2E&quot;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    @override</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    def pause_writing(self) -&gt; None:</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        self=2E_can_send=2Eclear()</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    @override</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    def resume_writing(self) -&gt; None:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        self=2E_can_send=2Eset()</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    @override</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    def connection_made(self, transport) -&gt; =
None:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        peerna=
me =3D transport=2Eget_extra_info(&#39;peername&#39;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        logger=2Einfo(&#39;Connection fro=
m {}&#39;=2Eformat(peername))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        self=2Etransport =3D transport</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        self=2E_can_send=2Eset()</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        # OMI expects us to authenticate with the pa=
ssword just on</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   # its own on a line</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if self=2E_connect_data=2Epassword:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            self=2Etransport=2Ewrite(f&quot;{sel=
f=2E_connect_data=2Epassword}\r\n&quot;=2Eencode())</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    @override</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    def data_received(self, data: bytes) -&gt; None:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        # OMI protocol is pure te=
xt so decode everything as UTF-8</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        message =3D data=2Edecode()</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        self=2ErecvBuffer +=3D message</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        parts =3D self=2ErecvBuffer=2Esplit(&q=
uot;\r\n&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        # pass complete=
 lines to recvLine</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       for part in parts[:-1]:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            logger=2Edebug(f&#39;Line received: {part!r}&#39;)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            self=2Ere=
cv_line(part)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        # keep the last i=
ncomplete line for the next call</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        self=2ErecvBuffer =3D parts[-1]</span><br><span style=
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
or: hsl(120, 100%, 40%);">+        if hasattr(self, f&quot;recv_notify_{com=
mand}&quot;):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      handler =3D getattr(self, f&quot;recv_notify_{command}&quot;)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            handler(args)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        logger=2Einfo(&quot;Unknown notif=
y line received: &quot; + line)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def=
 recv_notify_INFO(self, args: str) -&gt; None:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        m =3D re=2Ematch(r&quot;OpenVPN Manageme=
nt Interface Version (?P&lt;version&gt;\d+)&quot;, args)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if m:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            self=2Eversion =3D int(m=2Egroup=
(&quot;version&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            self=2E_management_ready=2Eset()</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        else:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            logger=2Ewarning(f&quot;Unknown INFO line=
 received: {args}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def recv_n=
otify_BYTECOUNT(self, args: str) -&gt; None:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        bytes_sent, bytes_received =3D args=2Espli=
t(&quot;,&quot;, 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        self=2Ebytes_sent =3D int(bytes_sent)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        self=2Ebytes_received =3D int(bytes_recei=
ved)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    async def _release_hold_task(s=
elf, hold_time: int =3D 0) -&gt; None:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        await asyncio=2Esleep(hold_time)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        await self=2Equeue_command(=
&quot;hold release&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def recv_=
notify_HOLD(self, args):</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        _text, hold_time =3D args=2Esplit(&quot;:&quot;, 1)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        hold_time =3D int(hold=
_time)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        asyncio=2Ecreate_task(se=
lf=2E_release_hold_task(hold_time))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 def queue_command(self, command: str) -&gt; Future[OmiCommandResult]:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmd =3D OmiSendC=
ommand(command, Future())</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        self=2E_send_queue=2Eput_nowait(cmd)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return cmd=2Eresult</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    async def management_ready(self) -&gt; int:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;&quot;&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Waits until =
the management interface is ready=2E Returns the management interface versi=
on=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;=
&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 await self=2E_management_ready=2Ewait()</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return self=2Eversion</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    def send_line(self, line: str) -&gt; None:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        logger=2Edebug(f&quot;Sendin=
g line: {line}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        self=2Etransport=2Ewrite(f&quot;{line}\n&quot;=2Eencode())</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    Set the bytecount interval=2E Use 0 t=
o disable</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;=
&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    async def set_bytecoun=
t_interval(self, interval: int):</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        return await self=2Equeue_command(f&quot;bytecount {in=
terval}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    async def enable_log=
(self):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn await self=2Equeue_command(&quot;log on&quot;)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    def recv_notify_LOG(self, args):</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        # &gt;LOG:1786453401,D,MANAGEMENT: CMD =
&#39;bytecount 30&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        timestamp, level, message =3D args=2Esplit(&quot;,&quot;, 2)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        timestamp =3D datetime=2Efromtime=
stamp(int(timestamp))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        level =3D level=2Estrip()</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        message =3D message=2Estrip()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        self=2Elog_message(timestamp, lev=
el, message)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    def log_message(self, =
time, level, message):</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        A new log message has been received=2E This method is int=
ended</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        to be =
overridden by a subclass to handle the log messages=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        :param time:    time in local ti=
me format</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        :p=
aram level:   level of the log message</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        :param message: the log message itself</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        :return:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        &quot;&quot;&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        logger=2Edebug(f&=
quot;Received log message: {time}, {level}, {message}&quot;)</span><br><spa=
n>diff --git a/sample/management/omi_client_protocol=2Epy b/sample/manageme=
nt/omi_client_protocol=2Epy</span><br><span>new file mode 100644</span><br>=
<span>index 0000000=2E=2Ed50cbef</span><br><span>--- /dev/null</span><br><s=
pan>+++ b/sample/management/omi_client_protocol=2Epy</span><br><span>@@ -0,=
0 +1,134 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#!/usr/b=
in/env python3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Cop=
yright (c) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+# Copyright (c) 2026 Arne Schwabe &lt;a=
rne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Permission is =
hereby granted, free of charge, to any person obtaining a copy</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+# of this software and associate=
d documentation files (the &quot;Software&quot;), to deal</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+# in the Software without restriction=
, including without limitation the rights</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+# to use, copy, modify, merge, publish, distribute, s=
ublicense, and/or sell</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+# copies of the Software, and to permit persons to whom the Software is<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+# furnished to do so=
, subject to the following conditions:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# The above copyright notice and this permission notice shall be included =
in all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# copies or s=
ubstantial portions of the Software=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND=
, EXPRESS OR</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# IMPLI=
ED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+# FITNESS FOR A PARTICULAR =
PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE =
FOR ANY CLAIM, DAMAGES OR OTHER</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E, ARISING FROM,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# O=
UT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN TH=
E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# SOFTWARE=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+import base64</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+import logging</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+from typing import Tuple</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+from omi import OmiProtocol, OmiCommandResult</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+logger =3D logging=2EgetLogger(__name__)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+logger=2EsetLevel(lo=
gging=2EDEBUG)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+class OMIClientProtocol(OmiProtocol):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    Implement the management protocol =
for the client  </span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    def __init__(self, finish_future, connect_data):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        super()=2E__init__(finish_future=
=3Dfinish_future, connect_data=3Dconnect_data)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        self=2E_partial_acc_msg =3D &quot;&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_pro=
tocol_acc_msg =3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        self=2E_acc_fragment_length =3D 980</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        self=2E_acc_negotiated_protocols=
 =3D []</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    async def send_acc_msg(self=
, protocol: str, msg: bytes):</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        &quot;&quot;&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        Sends out an ACC to the server using the specified=
 ACC message length</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        :param protocol:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        :param msg:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        :param fragment_length:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        :return:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        &quot;&quot;&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if protocol not in self=2E_acc_negotiated_prot=
ocols:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            l=
ogger=2Eerror(f&quot;Error: trying to send ACC message with protocol {proto=
col} is not in the negotiated list of protocols ({self=2E_acc_negotiated_pr=
otocols})&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        # See init=2Ec=
 for the explanation for the length calculation</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        max_header_size =3D len(&quot;ACC,&quot=
;) + len(protocol) + 1 + 4 + 1 + 2 + 1</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        # calculate fragment size with base64 encoding</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        fragment_length =3D self=2E_acc_=
fragment_length * 6 // 8 - max_header_size</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        commands =3D []</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        for part_start in range(0, len(msg), fragment_length):</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg_part =3D msg[part_start:p=
art_start + fragment_length]</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            b64msg =3D base64=2Eencodebytes(msg_part)=2Edecode()</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            flags =3D &quot;6&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            if part_star=
t + fragment_length &lt; len(msg):</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                flags =3D &quot;6:F&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            commands=2Eappend(f&quot;acc-msg\n{protocol}\=
n{flags}\n{b64msg}\nEND&quot;)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
cmd_futures =3D []</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       for command in commands:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            cmd_futures=2Eappend(self=2Equeue_command(command))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        cmd_results: Tuple[OmiCommandR=
esult] =3D await asyncio=2Egather(*cmd_futures)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        for cmd_result in cmd_results:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            if cmd_result=2Eerror:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                logger=2Eerror(f=
&quot;Error: sending ACC message failed: {cmd_result}&quot;)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    def recv_notify_ACC_PROTOCOLS(self, args):</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        params =3D args=2Esplit(&quot;,&quot;=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        acc_params=
 =3D { }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        for p in params:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            k, v  =3D p=
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
;">+                          f&quot;previous ACC message with protocol {se=
lf=2E_protocol_acc_msg} was complete&quot;)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            self=2E_partial_acc_msg =3D &quot;&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        try:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            msg =3D base64=2Edecodebytes(b64msg=2Eencode())</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            self=2E_par=
tial_acc_msg +=3D msg=2Edecode()</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            self=2E_protocol_acc_msg =3D protocol</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        except Exception as e:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            logger=2E=
error(f&quot;Error parsing ACC message: {e}&quot;, exc_info=3DTrue)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            self=2E_partial=
_acc_msg =3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            return</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fragme=
nted =3D fragment !=3D &quot;0&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        logger=2Edebug(f&quot;Received ACC message (fragme=
nt {fragmented}, protocol {protocol!r}), with payload {msg=2Edecode()!r}&qu=
ot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        # Message is not yet complete=2E Wait for mor=
e fragments=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if fragmented:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if hasattr(sel=
f, f&quot;receive_acc_{protocol}&quot;):</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            handler =3D getattr(self, f&quot;receive_a=
cc_{protocol}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            logger=2Edebug(f&quot;Calling handler {handler}&quot;)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            try:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                handler(self=
=2E_partial_acc_msg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            except Exception as e:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                logger=2Eerror(f&quot;Error parsing ACC mes=
sage: {e}&quot;, exc_info=3DTrue)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                self=2E_partial_acc_msg =3D &quot;&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        else:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            logger=2Einfo(f&qu=
ot;Received unhandled ACC protocol: {protocol}&quot;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        self=2E_partial_acc_msg =3D &quot;&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_protocol_acc_ms=
g =3D &quot;&quot;</span><br><span>\ No newline at end of file</span><br><s=
pan>diff --git a/sample/management/omi_server_demo=2Epy b/sample/management=
/omi_server_demo=2Epy</span><br><span>new file mode 100755</span><br><span>=
index 0000000=2E=2Ef5db689</span><br><span>--- /dev/null</span><br><span>++=
+ b/sample/management/omi_server_demo=2Epy</span><br><span>@@ -0,0 +1,297 @=
@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#! /usr/bin/env py=
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
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+import asyncio</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+import logging</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+from asyncio import Future</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+from base64 import standard_b64decode</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+from typing import Dict, Optional</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+from omi_server_protocol import OMIServer=
Protocol, ConnectedClient</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+from omi_tools import run_main, start_management_protocol, ConnectDat=
a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from omi_tools imp=
ort openvpn_escape</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+# This implement a s=
mall demonstration of using the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# OpenVPN Access Server Management Interface (OMI)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+# and a script that does various=
 action on the client depending</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# on the username the user connects with</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# ensure that you have a proper certifica=
te based authentication setup</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+# before using this script</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# (e=2Eg=2E https://github=2Ecom/openvpn/openvpn/blob/mast=
er/doc/man-sections/example-fingerprint=2Erst)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# usage:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# -=
-management /path/to/omi_server_demo=2Epy unix-script</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+# The main purpose of this script is to test/force certain c=
lient/server</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# behav=
iour=2E As a test script this is done on the username but also serves</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+# as an example how to im=
plement something similar for normal usage=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# if a username is prefixed with url it uses the old OPEN_URL metho=
d (e=2Eg=2E urlrick)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - fail: sends A=
UTH_FAILED</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - failn=
: sends AUTH_FAILED wiht \n</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# - failtemp: sends AUTH_FAILED,TEMP:Go away for a while</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# - failtemp42: sends AUTH_FAI=
LED,TEMP and backoff for 42s</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#     - failtempnr: sends AUTH_FAILED,TEMP and instructs to go the=
 next remote</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - suc=
cess: sends AUTH_SUCCESS</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+# - faildelay: sends AUTH_FAILED after 20s</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+# - successdelay: sends AUTH_SUCCESS after 20s<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - rick: sends you =
to a certain youtube site and auth you</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+# - openvpn: sends you to community=2Eopenvpn=2Enet</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+# - totp: Does crtext ba=
sed 2FA with secret &quot;totpinsecuretotp&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# - google: sends you to https://www=2Egoogle=
=2Ecom/search?q=3Dhidden without any flags</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+# - googlext: sends you to https://www=2Egoogle=2Eco=
m/search?q=3Dexternal with external flags and WEBAUTH \</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#         - dnssec: send only dnssec se=
rvers</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - nodns: no =
dns servers</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - dnss=
ecfb: dns server with fallback to dns without dnnsec</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# - dnsdhcp: dns options and dhcp_options=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - dnsport: dns se=
rver with custom port</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# - failaccdpc1: auth failed message indicating that the client is missin=
g dpc1 ACC support=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# - failaccdpc1user: auth failed message indicating that the client is mi=
ssing dpc1 ACC support indicating a auth-token and user for reconnecting</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#     - failaccflower:=
 auth failed message indicating that the client is missing flower and power=
 ACC support=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - =
default: push DNS 8=2E8=2E8=2E8 and default route</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+# - notify: Gives the client a message to dis=
play to the user via notify protocol</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
The hard-coded secret</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+totp_secret =3D &quot;totpinsecuretotp&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+logging=2EbasicConfig()</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+logger =3D logging=2EgetLogger(__name__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+logger=2EsetLevel(logging=2EINFO)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+try:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    import pyotp</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+except ImportError:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    logger=2Einfo(&quot;pyotp module not found=2E TOTP testing d=
isabled&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+class ServerDemoConnectedClient(Connected=
Client):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # Remem=
ber the key-id that we authenticated</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    authenticated_kid: int =3D -1</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    env: Dict =3D {}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+clas=
s ServerDemoProtocol(OMIServerProtocol):</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    def __init__(self, finish_future: Future, connect_=
data: ConnectData =3D None):</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        super()=2E__init__(finish_future, connect_data)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_connected_clie=
nt_class =3D ServerDemoConnectedClient</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    def client_event_ESTABLISHED(self, client: ServerDemoConnectedClient, k=
id: int, env: Dict, extra: str):</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        print(f&quot;CLient connected: {client}&quot;)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    def client_event_CONNECT(self, client: Ser=
verDemoConnectedClient, kid: int, env: Dict, extra: str) -&gt; None:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        print(f&quot;Authe=
nticating client {client=2Ecid}, {kid}&quot;)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        client=2Eauthenticated_kid =3D kid</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        client=2Eenv =3D e=
nv</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        asyncio=2Ecreate_task(self=
=2Edo_client_auth(client, kid))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asy=
nc def deny_client(self, client: ServerDemoConnectedClient, kid: int, reaso=
n: str,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
              client_reason: Optional[str] =3D None) -&gt; None:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        # Note, for this test =
script sending your real reason if you do not</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        # specify a client reason is okay=2E In a=
 real environment, this kind</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        # of information is potentially bad</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if not client_reason:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            client_reason =3D reason</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        client_deny =3D f&#39;cli=
ent-deny {client=2Ecid} {kid} &quot;{openvpn_escape(reason)}&quot; &quot;{o=
penvpn_escape(client_reason)}&quot;&#39;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        await self=2Equeue_command(client_deny)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    async def do_client_auth(self, client: Se=
rverDemoConnectedClient, kid: int) -&gt; None:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        username =3D client=2Eenv=2Eget(&quot;us=
ername&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        # success</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if username=2Estart=
swith(&quot;url&quot;):</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            username =3D username[3:]</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            method =3D &quot;openurl&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            webauth =3D &quot;=
OPEN_URL:&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    else:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  method =3D &quot;webauth&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            webauth =3D &quot;WEB_AUTH::&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if username =3D=3D &#39;fail&#39; or &#39;UV_F=
AIL&#39; in client=2Eenv:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            await self=2Edeny_client(client, kid, &quot;fail&quot;)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        elif username=
 =3D=3D &#39;failtemp&#39;:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            await self=2Edeny_client(client, kid, &quot;TEMP:Go awa=
y for a while&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        elif username =3D=3D &#39;failn&#39;:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            await self=2Edeny_client(client, kid=
, &quot;Bonus new line for you!\n&quot;)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        elif username =3D=3D &#39;failn2&#39;:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            await self=2Ede=
ny_client(client, kid, &quot;Bonus new line for you!\nand another one\n&quo=
t;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        elif use=
rname =3D=3D &#39;failtemp42&#39;:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            await self=2Edeny_client(client, kid, &quot;TEMP=
[backoff 42]:Go away for a 42s&quot;)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        elif username =3D=3D &#39;failtempnr&#39;:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            await self=2Ed=
eny_client(client, kid, &quot;TEMP[backoff 11,advance remote]:Annoy the nex=
t server!&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     elif username =3D=3D &#39;failaccdpc1&#39;:</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            await self=2Edeny_client(client, k=
id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                   &quot;ACC[protocol dpc1]: To connect to this server you =
need to upgrade to a client that supports the OpenVPN Inc device posture pr=
otocol, e=2Eg=2E OpenVPN Connect version 1=2E2=2E3 or later&quot;)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        elif username =3D=3D=
 &#39;failaccflower&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            await self=2Edeny_client(client, kid, &quot;ACC[protocol =
flower power]: You need to embrace the flower power&quot;)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        elif username =3D=3D &#39;fa=
ilaccdpc1user&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            await self=2Edeny_client(client, kid,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                   &quot;ACC[=
protocol flower power, user c3VjY2Vzcw=3D=3D, pass MTIzNDU2Nzg=3D]: Please =
come back again  after you enabled dpc1&quot;)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        elif username =3D=3D &#39;success&#39;:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            await se=
lf=2Esend_client_auth(client, kid)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        elif username =3D=3D &#39;faildelay&#39;:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            await asyncio=2Esl=
eep(20)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
await self=2Edeny_client(client, kid, &quot;I thought 20s about it and reje=
cted you after that time&quot;)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        elif username =3D=3D &#39;successdelay&#39;:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            await asyncio=2Esl=
eep(20)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
await self=2Esend_client_auth(client, kid)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        elif username=2Estartswith(&#39;totp&#39;):<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            timeout =
=3D 90</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            e=
xtra =3D f&quot;CR_TEXT:E,R:Please enter your TOTP code, {username}!&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            logger=
=2Einfo(f&quot;The TOTP the client needs to provide is: {self=2Eget_current=
_totp_code()}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            await self=2Esend_pending_auth(client, kid, extra, timeout)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        elif username =
=3D=3D &#39;rick&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            await asyncio=2Esleep(3)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            await self=2Esend_pending_auth(client, kid,=
 webauth + &quot;https://www=2Eyoutube=2Ecom/watch?v=3DdQw4w9WgXcQ&quot;)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            await asy=
ncio=2Esleep(10)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         await self=2Edeny_client(client, kid, &quot;I got you&quot;)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        elif username =3D=
=3D &#39;openvpn&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            await self=2Esend_pending_auth(client, kid, webauth + &quot;=
https://community=2Eopenvpn=2Enet&quot;)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            await self=2Esend_client_auth(client, kid)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        elif userna=
me =3D=3D &#39;googleext&#39;:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            await self=2Esend_pending_auth(client, kid, &quot;WE=
B_AUTH:external:https://www=2Egoogle=2Ecom/search?q=3Dexternal&quot;)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            await asyncio=
=2Esleep(10)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     await self=2Esend_client_auth(client, kid)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        elif username =3D=3D &#39;google&#39;:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            await se=
lf=2Esend_pending_auth(client, kid, &quot;WEB_AUTH::https://www=2Egoogle=2E=
com/search?q=3Dexternal&quot;)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            await asyncio=2Esleep(10)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            await self=2Esend_client_auth(clie=
nt, kid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        eli=
f username =3D=3D &#39;special&#39;:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            extra =3D f&quot;CR_TEXT:E:This special userna=
me is known, doing nothing, really&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            await self=2Esend_pending_auth(client, kid=
, extra)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        eli=
f username in [&#39;success&#39;, &#39;dnssec&#39;, &#39;nodns&#39;, &#39;d=
nssecfb&#39;, &#39;default&#39;]:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            await asyncio=2Esleep(1)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            await self=2Esend_client_auth(cl=
ient, kid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        e=
lif username =3D=3D &quot;notify&quot;:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            await self=2Esend_pending_auth(client, kid,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
                      &quot;NOTIFY:Please wait for 23s to let the server th=
ink if it want to admit you&quot;)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            await asyncio=2Esleep(23)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            await self=2Esend_client_auth=
(client, kid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  else:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
await self=2Edeny_client(client, kid,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                   f&quot;The username yo=
u used ({username}) is unknown, please pick one that I know&quot;)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    async def send_client_auth(self, client: Se=
rverDemoConnectedClient, kid: int) -&gt; None:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        username =3D client=2Eenv=2Eget(&quot;us=
ername&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        config =3D &quot;=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if us=
ername =3D=3D &#39;dnssec&#39;:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            config +=3D &quot;&quot;&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            push &quot;dns server 7 addr=
ess 8=2E8=2E8=2E8:53&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            push &quot;dns server 7 dnssec yes&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            &quot;&quot;&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        elif username =
=3D=3D &#39;nodns&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            pass</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        elif username =3D=3D &#39;dnssecfb&#39;:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            config +=3D &quot;&quot;&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            push &quot=
;dns server 7 address 8=2E8=2E8=2E8:53&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            push &quot;dns server 7 dnssec yes&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            push =
&quot;dns server 10 address 8=2E8=2E8=2E8&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            push &quot;dns server 10 transport =
DoT&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  push &quot;dns server 12 address 8=2E8=2E8=2E8&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            push &quot;dns server 12 tra=
nsport DoH&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         push &quot;dns server 19 address 8=2E8=2E8=2E8:53&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            &quot;&quot;&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        elif userna=
me =3D=3D &#39;dnsdhcp&#39;:</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            config +=3D &quot;&quot;&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            push &quot;dns server 19 addr=
ess 8=2E8=2E8=2E8:53&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            push &quot;dhcp-options dns server 1=2E1=2E1=2E1&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;&qu=
ot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        el=
if username =3D=3D &#39;dnsport&#39;:</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            config +=3D &quot;&quot;&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            push &quot;dns server =
20 address 8=2E8=2E8=2E8:5353&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            &quot;&quot;&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        elif username =3D=3D &#39;default&#39;:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            config +=
=3D &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            push &quot;dns server 19 address 8=2E8=2E8=2E8:53&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            push &quot;d=
hcp-options dns server 1=2E1=2E1=2E1&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            push &quot;redirect-gateway def1&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;&qu=
ot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if not config:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            await self=2Eq=
ueue_command(f&quot;client-auth-nt {client=2Ecid} {kid}&quot;)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        else:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            await self=2Equeue_command=
(f&quot;client-auth {client=2Ecid} {kid}\n{config}\nEND\n&quot;)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    async def send_pending_auth(self, client: Ser=
verDemoConnectedClient, kid: int, extra: str,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                                timeout: int =3D =
180) -&gt; None:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     auth_pending_totp_cmd =3D f&#39;client-pending-auth {client=2Ecid} {ki=
d} &quot;{extra}&quot; {timeout}&#39;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        await self=2Equeue_command(auth_pending_totp_cmd)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    def client_event_CR_RESPONSE(self,=
 client: ServerDemoConnectedClient, kid: int, env: Dict, extra: str) -&gt; =
None:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        client=
=2Eenv =3D env</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   asyncio=2Ecreate_task(self=2Eclient_crresponse(client, kid, extra))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    @staticmethod</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    def get_current_totp_code() -&gt; str=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        try:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            import pyotp<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        except Impor=
tError:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
return &quot;pyotp not found&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    totp =3D pyotp=2ETOTP(totp_secret)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        return totp=2Enow()</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    async def client_crresponse(self, client: ServerDemoConnectedCl=
ient, kid: int, response: str) -&gt; None:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        # Try importing the pyotp here to allow the =
script run without pyotp</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        # installed</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        try:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          import pyotp</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        except ImportError:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            await self=2Edeny_client(client, kid, &quot;pytop mo=
dule not found=2E Cannot do MFA testing&quot;)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            return</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        try:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            response =3D standard_b64decode(response)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            response =3D response=2Edecod=
e()=2Estrip()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  except Exception as e:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            await self=2Edeny_client(client, kid, f&quot;Decoding totp=
 response failed: {e}&quot;)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            return</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tot=
p =3D pyotp=2ETOTP(totp_secret)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 logger=2Einfo(f&quot;\nCR: expected totp &#39;{totp=2Enow()}&#39;, respons=
e was &#39;{response}&#39;\n&quot;)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        # Check if the code is valid (and also allow code +=
/-1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if totp=2Everify(response,=
 valid_window=3D1):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            await self=2Esend_client_auth(client, kid)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        else:</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            await self=2Edeny_client(client, k=
id, &quot;TOTP verification failed&quot;)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+async def main(c=
onnect_data: ConnectData):</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    transport, protocol, finish_future =3D await start_management_pr=
otocol(connect_data, ServerDemoProtocol)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    management_version =3D await protocol=2Emanagement_ready()</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    logger=2Einfo(f&quot;Manag=
ement interface version: {management_version}&quot;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    await protocol=2Eenable_log()</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    await protocol=2Eset_bytecount_interval(5)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    await finish_future</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if __name__ =3D=
=3D &#39;__main__&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    run_main(main)</span><br><span>diff --git a/sample/management/omi_s=
erver_protocol=2Epy b/sample/management/omi_server_protocol=2Epy</span><br>=
<span>new file mode 100644</span><br><span>index 0000000=2E=2Eab36a8d</span=
><br><span>--- /dev/null</span><br><span>+++ b/sample/management/omi_server=
_protocol=2Epy</span><br><span>@@ -0,0 +1,235 @@</span><br><span style=3D"c=
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
, 100%, 40%);">+import asyncio</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+import base64</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+import logging</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
from asyncio import Future</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+from dataclasses import dataclass</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+from typing import List, Tuple, Dict</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+from omi import OmiProtocol, ConnectionProperties, OmiCo=
mmandResult</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+logger =3D logging=2EgetLog=
ger(__name__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+logger=
=2EsetLevel(logging=2EINFO)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+@dataclass</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+class ConnectedClient:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;This represent=
s a connected client instance=2E&quot;&quot;&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    cid: int</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    bytes_sent: int =3D 0</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    bytes_received: int =3D 0</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    _partial_acc_msg: str =3D &quot=
;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    _protoco=
l_acc_msg: str =3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    _kid_acc_msg: int =3D -1</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    _acc_fragment_length: int =3D 980</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    acc_negotiated_protocols: List[s=
tr] =3D []</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+class OMIServerProtocol(OmiProtocol):</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    This class implement c=
ommon method for the OMI when OpenVPN is running</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    as a server=2E These are mainly helper fun=
ction and functionality that</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    is only available/useful for OpenVPN running as a server</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    # Connected client class, can be over=
ridden by subclasses to store</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    # more information about the connected client</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    _connected_client_class =3D Con=
nectedClient</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    def __init__(self, fin=
ish_future: Future, connect_data: ConnectionProperties):</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        super()=2E__init__(finish_futu=
re, connect_data)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      self=2E_reset_pending_client_event()</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        self=2E_connected_clients:Dict =3D {}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    def _reset_pending_client_event(self) -&g=
t; None:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sel=
f=2E_pending_client_event:str =3D &quot;&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        self=2E_pending_client_event_cid:int =3D=
 -1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_=
pending_client_event_kid:int =3D -1</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        self=2E_pending_client_event_extra_args:str =3D Non=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_cl=
ient_env:Dict =3D {}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def recv_notif=
y_CLIENT(self, args: str) -&gt; None:</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        event, args =3D args=2Esplit(&quot;,&quot;, 1)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if event =3D=3D &quot;ENV&quot;:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if args =
=3D=3D &quot;END&quot;:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                # Client environment is finished, trigger previous clie=
nt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                #=
 event that contained an ENV</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                self=2E_trigger_client_event(self=2E_pending_clien=
t_event, self=2E_pending_client_event_cid,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                           self=2E_p=
ending_client_event_kid, self=2E_client_env,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                           self=2E=
_pending_client_event_extra_args)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                self=2E_reset_pending_client_event()</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            else:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                key, value =3D=
 args=2Esplit(&quot;=3D&quot;, 1)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                self=2E_client_env[key] =3D value</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        elif event in (&quot;ESTABLISHED&quot;, &q=
uot;DISCONNECT&quot;):</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            # This event is followed by a client environment=2E Wait for=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            # the c=
lient environment to be completed before triggering the event</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            cid =3D int(args)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            self=2E_pending_client_event =
=3D event</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  self=2E_pending_client_event_cid =3D int(cid)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            self=2E_pending_client_event_kid =
=3D None</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 if event =3D=3D &quot;ESTABLISHED&quot;:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                self=2E_add_client(cid)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        elif event in (&quot;CONNECT&quot;, &quot;RE=
AUTH&quot;):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     # This event is similar to other event but also carries the key-id</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            cid, kid =
=3D args=2Esplit(&quot;,&quot;, 1)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            cid, kid =3D int(cid), int(kid)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            self=2E_add_client(cid)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            self=2E_pending_client_even=
t =3D event</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    self=2E_pending_client_event_cid =3D int(cid)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            self=2E_pending_client_event_kid =
=3D int(kid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 elif event =3D=3D &quot;CR_RESPONSE&quot;:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            # This event is similar to CONNECT and =
REAUTH but has an extra</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            # parameter with the crtext response</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            cid, kid, response =3D args=
=2Esplit(&quot;,&quot;, 2)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            cid, kid =3D int(cid), int(kid)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            self=2E_pending_client_event =3D event</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            self=2E_pending_clie=
nt_event_cid =3D int(cid)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            self=2E_pending_client_event_kid =3D int(kid)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            self=2E_pending_cli=
ent_event_extra_args =3D response</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        elif event =3D=3D &quot;ACC&quot;:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            cid, kid, acc_args =3D arg=
s=2Esplit(&quot;,&quot;, 2)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            self=2E_trigger_client_event(event, int(cid), int(kid),=
 None, acc_args)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     else:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   logger=2Einfo(f&quot;Client event {event} not handled=2E (message: {args=
!r})&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    def client_event_ACC(se=
lf, client: ConnectedClient, kid: int, env: Dict, extra: str) -&gt; None:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        protocol, fra=
gment, b64msg =3D extra=2Esplit(&quot;,&quot;, 2)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if client=2E_partial_acc_msg and client=2E_protocol_acc_=
msg !=3D protocol:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           logger=2Eerror(f&quot;Recieved ACC message with protocol {protoc=
ol} before &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                       f&quot;previous ACC message with protocol {client=2E=
_protocol_acc_msg} was complete&quot;)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            client=2E_partial_acc_msg =3D &quot;&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if client=2E_partial_acc_msg and=
 client=2E_kid_acc_msg !=3D kid:</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            logger=2Eerror(f&quot;Recieved ACC message with di=
fferent key id {kid} before &quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                         f&quot;previous ACC message with ke=
y id {client=2E_kid_acc_msg} &quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                         f&quot;was complete=2E This is cur=
rently not handled&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            client=2E_partial_acc_msg =3D &quot;&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        try:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            msg =3D base64=2Edecodebytes(b64msg=2Eencode())<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            client=
=2E_partial_acc_msg +=3D msg=2Edecode()</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            client=2E_protocol_acc_msg =3D protocol</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            client=2E_k=
id_acc_msg =3D kid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            # Messag=
e is not yet complete=2E Wait for more fragments=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if fragment !=3D &quot;0&quot=
;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                r=
eturn</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            handler_name =3D f&qu=
ot;receive_acc_client_{protocol}&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            if hasattr(self, handler_name):</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                handler =3D geta=
ttr(self, handler_name)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                logger=2Edebug(f&quot;Calling handler {handler}&quot;)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                try:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 handler(client, kid, client=2E_partial_acc_msg)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                except Exception as e:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                    logger=
=2Eerror(f&quot;Error parsing ACC message: {e}&quot;, exc_info=3DTrue)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            else:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                logger=2Ei=
nfo(f&quot;Received unhandled ACC protocol: {protocol}, handler {handler_na=
me} not found&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            client=
=2E_partial_acc_msg =3D &quot;&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            client=2E_protocol_acc_msg =3D protocol</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        except Exception as e:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            logger=2Eerror(f&quot;=
Error parsing ACC message from client: {e}&quot;, exc_info=3DTrue)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            client=2E_partia=
l_acc_msg =3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            return</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        clien=
t=2E_partial_acc_msg =3D &quot;&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   def recv_notify_BYTECOUNT_CLI(self, args: str) -&gt; None:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        cid, bytes_sent, bytes_re=
ceived =3D args=2Esplit(&quot;,&quot;, 2)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        client =3D self=2E_connected_clients=2Eget(int(cid))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if client:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            client=2Ebytes_sent =
=3D int(bytes_sent)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            client=2Ebytes_received =3D int(bytes_received)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    def _trigger_client_event(self, event: str, cid: i=
nt, kid: int, env: dict, extra):</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        client =3D self=2E_connected_clients=2Eget(cid, None)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        # Remember ACC protocol options=
 if present</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if event =3D=3D &quot;CONNECT&quot; and &quot;acc_protocols&quot; in env:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            client=2E=
acc_negotiated_protocols =3D [p=2Estrip() for p in env[&quot;acc_protocols&=
quot;]=2Esplit(&quot;:&quot;)]</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            client=2E_acc_fragment_length =3D int(env[&#39;acc_m=
essage_len&#39;])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        handler_name =
=3D f&quot;client_event_{event}&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if hasattr(self, handler_name):</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            handler =3D getattr(self,=
 handler_name)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       handler(client, kid, env, extra)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        else:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            logger=2Einfo(f&quot;Client event {event} not han=
dled=2E Method {handler_name} does not exist=2E&quot;)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    def _add_client(self, cid: int) -&gt; None:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if not cid in self=2E_c=
onnected_clients:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          self=2E_connected_clients[cid] =3D self=2E_connected_client_class=
(cid=3Dcid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    def _remove_client(self=
, cid: int) -&gt; None:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        del self=2E_connected_clients[cid]</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    async def get_client_status(self) -&gt; OmiCommandResult:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmd_result =3D se=
lf=2Equeue_command(&quot;status 3&quot;)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return await cmd_result</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    async def send_acc_msg(self, client: ConnectedClient, ki=
d: int, protocol: str, msg: bytes) -&gt; None:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        &quot;&quot;&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        Sends out an ACC to the client=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;&quot=
;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if p=
rotocol not in client=2Eacc_negotiated_protocols:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            logger=2Eerror(f&quot;Error: tryi=
ng to send ACC message with protocol&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                         f&quot; {protocol} is not i=
n the negotiated list of &quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                         f&quot;protocols ({client=2Eacc_negoti=
ated_protocols})&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # See i=
nit=2Ec for the explanation for the length</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        max_header_size =3D len(&quot;ACC,&quot;) + =
len(protocol) + 1 + 4 + 1 + 2 + 1</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   # calculate fragment size with base64 encoding</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        fragment_length =3D client=2E_acc_fra=
gment_length * 6 // 8 - max_header_size</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        commands =3D []</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        for part_start in range(0, len(msg), fragment_length):</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            msg_part =3D msg[part_start:part_s=
tart + fragment_length]</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            b64msg =3D base64=2Eencodebytes(msg_part)=2Edecode()</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            flags =3D &quot;6&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            if part_start + f=
ragment_length &lt; len(msg):</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                flags =3D &quot;6:F&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            commands=2Eappend(f&quot;client-acc-msg {client=
=2Ecid} {kid}\n{protocol}\n{flags}\n{b64msg}\nEND&quot;)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        cmd_futures =3D []</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        for command in commands:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            cmd_futures=2Eappend(self=
=2Equeue_command(command))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmd_=
results: Tuple[OmiCommandResult] =3D await asyncio=2Egather(*cmd_futures)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for cmd_resul=
t in cmd_results:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          if cmd_result=2Eerror:</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                logger=2Eerror(f&quot;Error: sending ACC messa=
ge failed: {cmd_result}&quot;)</span><br><span>diff --git a/sample/manageme=
nt/omi_tools=2Epy b/sample/management/omi_tools=2Epy</span><br><span>new fi=
le mode 100644</span><br><span>index 0000000=2E=2E4541f34</span><br><span>-=
-- /dev/null</span><br><span>+++ b/sample/management/omi_tools=2Epy</span><=
br><span>@@ -0,0 +1,105 @@</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#! /usr/bin/python3</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+# Copyright (c) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+# Copyright (c) 2026 Arne S=
chwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Pe=
rmission is hereby granted, free of charge, to any person obtaining a copy<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+# of this software a=
nd associated documentation files (the &quot;Software&quot;), to deal</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+# in the Software without=
 restriction, including without limitation the rights</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# to use, copy, modify, merge, publish, d=
istribute, sublicense, and/or sell</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+# copies of the Software, and to permit persons to whom the =
Software is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# furnis=
hed to do so, subject to the following conditions:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+# The above copyright notice and this permission notice shall =
be included in all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
 copies or substantial portions of the Software=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+# THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY=
 OF ANY KIND, EXPRESS OR</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABIL=
ITY,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# FITNESS FOR A=
 PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# AUTHORS OR COPYRIGHT HOLDERS=
 BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT =
OR OTHERWISE, ARISING FROM,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEA=
LINGS IN THE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# SOFTW=
ARE=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import asynci=
o</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import os</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+import re</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+from dataclasses import dataclass</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+from omi import OmiProtocol, ConnectionPr=
operties</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+@dataclass</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+class ConnectData(ConnectionProperties):</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    socket: str</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+open=
vpn_escape_re =3D re=2Ecompile(r&#39;([&quot;\\])&#39;)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+filt_ctrl_re =3D re=2Ecompile(r&quot;[\=
x00-\x1f\x7f]+&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+def openvpn_escape(text):</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    &quot;&quot;&quot;Escapes a string to be safely used for OpenVP=
N inside</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a quote=
d string</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    Something like &#39;client=
-deny 2 3 &quot;{openvpn_escape(reason)}&quot; &quot;{openvpn_escape(client=
_reason)}&quot;&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    text =3D re=2Esub(filt_ctrl_re, &#39; &#39;, text)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    text =3D re=2Esub(openvpn_escape=
_re, r&#39;\\\1&#39;, text)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return text=2Erstrip()</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+def =
get_unix_script_environment() -&gt; ConnectData | None:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    password =3D os=2Eenviron=2Eget(&qu=
ot;MANAGEMENT_PASSWORD&quot;, None)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    socket =3D os=2Eenviron=2Eget(&quot;MANAGEMENT_SOCKET&q=
uot;, None)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if password and socket:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return Conn=
ectData(password=3Dpassword, socket=3Dsocket)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    else:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return None</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+async def start_manage=
ment_protocol(connect_data: ConnectData, protocol=3DOmiProtocol):</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    # Get a reference to the =
event loop as we plan to use</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    # low-level APIs=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    loop =3D asyncio=2Eget_running_loop()</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    finish_future =3D loop=2Ecreate_future()</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    print(f&quot;Connecting to management socket {con=
nect_data=2Esocket} with passwd {connect_data=2Epassword[:4]}=2E=2E=2E&quot=
;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    transport, pr=
otocol =3D await loop=2Ecreate_unix_connection(lambda: protocol(finish_futu=
re, connect_data),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                                           connect_data=2Es=
ocket)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return transport, protocol, =
finish_future</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+async def main():</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    transport, protocol, finish_future =3D awa=
it start_management_protocol()</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mana=
gement_version =3D await protocol=2Emanagement_ready()</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    await protocol=2Eenable_log()</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    print(f&quot;Managemen=
t interface version: {management_version}&quot;)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    await protocol=2Eset_bytecount_interval(5)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    await finish_future</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+def run_main(mai=
n_func, connect_parameters: ConnectData =3D None):</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    Example function to run a main functi=
on to be either using the</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    environment variable for the unix-script or to use=2E If the unix=
-script</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    environm=
ent are detected, the function will fork and run the main_func</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    with the ConnectData from th=
e environment=2E If the environment variables</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    are not available, it will not fork will fall=
 back to the connect_parameters</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if present=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    :param connect_parameters:  fallback connect parameters if un=
ix-script is not available</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    :param main_func:           The function to call=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    :return:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    unix_script_parameters =3D get_u=
nix_script_environment()</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if unix_script_parameters:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        asyncio=2Erun(main_func(unix_script_parameters))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    elif connect_param=
eters:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        async=
io=2Erun(main_func(connect_parameters))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        print(f&quot;Must be called via unix-script&quot;)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+if __name__ =3D=3D &#39;__main__&#39;:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    run_main(main)</span><br></pre><p>To view=
, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Dem=
ail">change 1859</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1859?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> G=
errit-Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5 </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 1859 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: Name of user not set #1000061 </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--T9J2DxYAYX0=--


--===============2957653820509318376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2957653820509318376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2957653820509318376==--

