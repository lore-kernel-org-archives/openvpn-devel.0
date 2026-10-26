Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAE9606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 19:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HDS3S7Hm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TwM3kCr1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ey7w+HWC;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cz6rcjYV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3FVUtKQVbI3bXH5gaprlk49VVjaKR7Ua9SUQpt+xaG8=; b=HDS3S7Hmk36oT3L+QQUqNyermL
	2EygyJ8X770nRgrthYaevPrDvQ0lhkRIN19ZYSPFQRY7G5IpEpRJIP63gL0IW8ZF/84BX4AiHvC2j
	uJGTMsqJVkAwIbscT99+4ty7vbHas5EDMfVZYxyfKl0hklwvjoqzq8R+Tm9zJT8OdmqE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLQaz-000000007wp-0i58;
	Mon, 26 Oct 2026 19:43:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLQay-000000007wd-008K
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 19:43:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=swKv53WTA5ITX2t3aGfFYFcuOoeo2SJD6oZX/0nofZE=; b=TwM3kCr1RnYETTXkl5xwDgZ1zV
 TkVpCiqTcZTYculLxYFq4VBDrdzsBLdnm+cYrvCe9RaWtd5FVfemTCi3963eskkxI75j9iIsUgPSw
 x0hs7pLGaZQFUpj1wYU3zyT0pTHoksmutYADINDE4SO0WtR74dR1DKO5p/mBjRRrPLoU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=swKv53WTA5ITX2t3aGfFYFcuOoeo2SJD6oZX/0nofZE=; b=ey7w+HWCG7xSd/DtzDFWp7QK09
 X6dUSyd5guFIh3Gp21hgm5eSUO8+pzATJiv5r0KXi8wAG4RVE2Dc4xExYIzjXgdm7V+hfSsIgYBwA
 u8xJFp9wu+DVkNlztCzJ70OXmoMpacFjiqcosADityhs6AgAwXPJR1vk5WqgH1Hpr0fo=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLQak-000000002F0-0GB5 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 19:42:59 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so1574984f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 12:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793043759; x=1793648559; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=swKv53WTA5ITX2t3aGfFYFcuOoeo2SJD6oZX/0nofZE=;
 b=cz6rcjYVfrb+IJdGGaZjSm8AYRLPFwwL6AAuxRLi8bgIjRizmRQKg3uvALl2bgvsg7
 Dj1Tjc/RH4YsAWLVVAKkKZqmT43Nm/B5z5Vs0ZLNhB4d4D/cUozmwQMf+fuINDN0dO9T
 fCSg0C1tB5wiIDY+F5fW4HTiBbLye2L1YuA7xR4IVG45PNFE+U85pwi+gIt4uRlO2Jxa
 5WJm5vG2sf01Fcm82ZAqSXHtxxOPok0eGhsOtKrhTQbPxJ27sYMsfBhFzt+lL8+ZqYo7
 74QAh6Hf0zOtaruxtBi3+JJK4A4Z2MTfQGnmmXscNSJSbAoupJzUCsLkB+PHKe7lj+bU
 ZzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793043759; x=1793648559;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=swKv53WTA5ITX2t3aGfFYFcuOoeo2SJD6oZX/0nofZE=;
 b=AdCBBKzQPqkBnngETWbEMf/NmRZotWjtNhmiOea2jXpxRdxECJJFF2IxiM+gYUS8no
 KFLGwN0PCYA/gRkkxMpmRY2NQQR7CYRHsjoNLX3yM9pPDhjgbj6ePTOSr0dXagEBfAtz
 UZJQcSyHBjLOEBD2HTHr6iMQeKPRUc+0n9SWqzz/G3TIgtd0Vky4uB6Y6Hu1E/7Dw+vx
 HsB7TvRGVYCPqBASDKbTWalEc+6/2kip7EBnTYmQ7iohGbAkDUtJA92zPgT3MH61p/sF
 5vil189XZ8WUUVFTLogeD3tKg3z8yfk7kRzrHOulzTJvqthnQV7jkdA53AaHjfja129c
 MTQQ==
X-Gm-Message-State: AFq9FYJmLkAJugu3WU2riSqZm5UO5r8rQxORl3zkqxLA5bOxUkttots2
 YDx2jrgBWHKWMXmxEm146n4yP4j7u6Y9wW1eNOnLak7ZrjjvlKPCsj25nmWuFjlM56ru2AftYLT
 4+yt3huKI/cPI5OGr+Sx9HLRI/g93jcEUeftVJfqgZkzt5bykPilUEbMLeW1+PeYcN0cXMIyuT3
 jkuX10Qg==
X-Gm-Gg: AYBFou39bf7FVigYpxmL8RENrSi2XcysH9Pg5d9WaDowCVlmdiSnzSrEx3CA5WbQTKn
 I9F7bR1akxRLrroaig3sH0uYHYiJPE2Yug7W5IlIruvrXB5NyBvk2xZZPVrdcvYadT5jfBp0x2h
 raJ8XRGU7+/I5eUpwOm9O7ujEnurbAxFqngmCI1eTP3dWLQS6e5TVq95GI5kYkwLoRE0JfgXraX
 e7X1IzG17iNXhXL2gITrTpZZwvtIVEXzRRNYTcgRL1NS4yfPb0hoD1kEygOQsTmX4zIMqGXYeA5
 jlQfGyoE3bfgryx4FC1vBVGroeVeulb3kxSBpXIMq92qPVR/YPhkC0R9WSy4KoOI3yZAxP3Xd/q
 TjcfeXyMXZG1kyIZvVtoJa1sm7ThErOffm9WTVxOAPoGQO1YBgGllR6eAzqLmCuZsOEFHJN7kNl
 AfvyEuVI9ZVfBjp6TDZvgewCjnzc1Ssy7KDgr9UFUoOLjq0OamWBc2Cs2mN7R6gNsRmKAUR1Exx
 qe9q8z25F1cHawDYO8Sf1bl2Y2z/MpYjPf5l2Cxvk48DYM5Z1YpijGxOnTX8vJsJTIbHPzwAwxB
 MggzqE9tT6T8WJdBaSIoQgPuqA4wZi9oNQuKjL8RpiWjfRSudr2BJOhvv6hjbQ/OOSgQEgSkx9t
 UVOg0a7dZEb12DyusI8K3udruEsQWVbko91Mo81Bg4HyNpVttgxbzwrZZ2BYv5z4=
X-Received: by 2002:a05:6000:2012:b0:488:83f7:6352 with SMTP id
 ffacd0b85a97d-48e3eb24734mr15402412f8f.4.1793043758599; 
 Mon, 26 Oct 2026 12:42:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd8dcfsm18106814f8f.50.2026.10.26.12.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 12:42:38 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 19:42:27 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5
X-Gerrit-Change-Number: 1859
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1859?usp=email>
X-Gerrit-Commit: c83f663ebf13b507e5d8438651e4f3f190984ac3
In-Reply-To: <gerrit.1787327336000.Ib09bafabf612e9501ea757647c86a450c73228a5@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ib09bafabf612e9501ea757647c86a450c73228a5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkliMDliYWZhYmY2MTJlOTUwMWVhNzU3NjQ3Yzg2YTQ1MGM3MzIyOGE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f76955e485e81504010bdf6960ce247f0103efe3-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xLQak-000000002F0-0GB5
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
Content-Type: multipart/mixed; boundary="===============4655998744251711125=="
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_HTML_MOSTLY,MISSING_HEADERS,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4655998744251711125==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="meVadTPEtq4="; charset=UTF-8

--meVadTPEtq4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has uploaded a new patch set (#4)=2E ( https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1859?usp=3Demail )


Change subject: Add python scripts=
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
5 files changed, 1,032 insertions(+), 0 deletio=
ns(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
59/1859/4

diff --git a/sample/management/omi=2Epy b/sample/management/omi=
=2Epy
new file mode 100644
index 0000000=2E=2E415e6eb
--- /dev/null
+++ b/s=
ample/management/omi=2Epy
@@ -0,0 +1,279 @@
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
+from asyncio import Future
+from dataclasses import dataclass
+from d=
atetime import datetime
+from typing import override, List
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
+    password: str
+
+
+class OmiProtocol(asyn=
cio=2EProtocol):
+    def __init__(self, finish_future, connect_data: Conne=
ctionProperties):
+        super()=2E__init__()
+        self=2Ebytes_recei=
ved =3D None
+        self=2Ebytes_sent =3D None
+        self=2Eversion =
=3D -1
+        self=2ErecvBuffer =3D ""
+        self=2Efinish_future =3D =
finish_future
+        # Event to allow waiting for status of the underlyin=
g socket
+        # to become available for writing
+        self=2E_can_se=
nd =3D asyncio=2EEvent()
+        self=2E_can_send=2Eclear()
+
+        # E=
vent to
+        self=2E_management_ready =3D asyncio=2EEvent()
+        se=
lf=2E_management_ready=2Eclear()
+        self=2E_response =3D []
+
+      =
  self=2E_response_ready =3D asyncio=2EEvent()
+        self=2E_response_re=
ady=2Eclear()
+
+        self=2E_send_task =3D asyncio=2Ecreate_task(self=
=2E_send_loop())
+        self=2E_send_queue =3D asyncio=2EQueue()
+       =
 self=2E_connect_data: ConnectionProperties =3D connect_data
+
+    @overri=
de
+    def eof_received(self):
+        logger=2Einfo('EOF received=2E Shu=
tting down=2E')
+        self=2E_stop()
+
+    @override
+    def connectio=
n_lost(self, excp):
+        if excp:
+            logger=2Einfo(f'Connecti=
on lost ({excp})=2E Shutting down=2E')
+        else:
+            logger=
=2Einfo(f'Connection lost=2E Shutting down=2E')
+        self=2E_stop()
+
+=
    def _stop(self):
+        if not self=2Efinish_future=2Edone():
+      =
      self=2E_send_task=2Ecancel()
+            self=2Efinish_future=2Eset_=
result(True)
+
+    async def _send_loop(self):
+        while True:
+     =
       command: OmiSendCommand =3D await self=2E_send_queue=2Eget()
+      =
      await self=2E_can_send=2Ewait()
+            self=2Esend_line(command=
=2Ecommand)
+
+            response =3D []
+            response_complete =
=3D False
+
+            # This is a bit brittle as it will loop forever if=
 not getting a
+            # line that starts with ERROR or SUCCESS=2E Wit=
h a normal OpenVPN
+            # daemon that speak the correct protocol th=
is should not be a
+            # problem
+            while not response_c=
omplete:
+                await self=2E_response_ready=2Ewait()
+
+        =
        line =3D self=2E_response=2Epop(0)
+                response=2Eappe=
nd(line)
+
+                if not self=2E_response:
+                    s=
elf=2E_response_ready=2Eclear()
+
+                lastline =3D response[-1=
]
+                if lastline=2Estartswith('ERROR:'):
+                   =
 status =3D False
+                    response_complete =3D True
+        =
            _, status_text =3D lastline=2Esplit(":", 1)
+
+                =
elif lastline=2Estartswith('SUCCESS:'):
+                    status =3D Tru=
e
+                    response_complete =3D True
+                    _, s=
tatus_text =3D lastline=2Esplit(":", 1)
+                elif lastline =3D=
=3D "END":
+                    status =3D True
+                    respon=
se_complete =3D True
+                    status_text =3D None
+           =
     else:
+                    pass
+
+            # logger=2Edebug(f'Resu=
lt received command: {response}')
+            result =3D OmiCommandResult(=
command=2Ecommand, response[:-1], status, status_text)
+
+            comma=
nd=2Eresult=2Eset_result(result)
+            logger=2Edebug(f"Command done=
=2E")
+
+    @override
+    def pause_writing(self):
+        self=2E_can_s=
end=2Eclear()
+
+    @override
+    def resume_writing(self):
+        self=
=2E_can_send=2Eset()
+
+    @override
+    def connection_made(self, transp=
ort):
+        peername =3D transport=2Eget_extra_info('peername')
+       =
 logger=2Einfo('Connection from {}'=2Eformat(peername))
+        self=2Etra=
nsport =3D transport
+        self=2E_can_send=2Eset()
+
+        # OMI exp=
ects us to authenticate with the password just on
+        # its own on a l=
ine
+        if self=2E_connect_data=2Epassword:
+            self=2Etransp=
ort=2Ewrite(f"{self=2E_connect_data=2Epassword}\r\n"=2Eencode())
+
+    @ov=
erride
+    def data_received(self, data):
+        # OMI protocol is pure =
text so decode everything as UTF-8
+        message =3D data=2Edecode()
+  =
      self=2ErecvBuffer +=3D message
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
recv_line(self, line):
+        if line=2Estartswith(">"):
+            sel=
f=2Erecv_notify(line)
+        else:
+            self=2E_response=2Eappend=
(line)
+            self=2E_response_ready=2Eset()
+
+    def recv_notify(s=
elf, line):
+        if not ":" in line:
+            logger=2Ewarning("Inv=
alid line received: " + line)
+            return
+
+        command, args =
=3D line[1:]=2Esplit(":", 1)
+
+        # do dynamic dispatch based on comm=
and to call a handler
+        if hasattr(self, f"recv_notify_{command}"):
=
+            handler =3D getattr(self, f"recv_notify_{command}")
+         =
   handler(args)
+            return
+
+        logger=2Einfo("Unknown noti=
fy line received: " + line)
+
+    def recv_notify_INFO(self, args):
+     =
   m =3D re=2Ematch(r"OpenVPN Management Interface Version (?P<version>\d+)=
", args)
+        if m:
+            self=2Eversion =3D int(m=2Egroup("vers=
ion"))
+            self=2E_management_ready=2Eset()
+        else:
+      =
      logger=2Ewarning(f"Unknown INFO line received: {args}")
+
+    def re=
cv_notify_BYTECOUNT(self, args):
+        bytes_sent, bytes_received =3D ar=
gs=2Esplit(",", 1)
+        self=2Ebytes_sent =3D int(bytes_sent)
+        =
self=2Ebytes_received =3D int(bytes_received)
+
+    async def _release_hol=
d_task(self, hold_time: int =3D 0):
+        await asyncio=2Esleep(hold_tim=
e)
+        await self=2Equeue_command("hold release")
+
+    def recv_noti=
fy_HOLD(self, args):
+        _text, hold_time =3D args=2Esplit(":", 1)
+  =
      hold_time =3D int(hold_time)
+
+        asyncio=2Ecreate_task(self=2E=
_release_hold_task(hold_time))
+
+    def queue_command(self, command) -> F=
uture[OmiCommandResult]:
+        cmd =3D OmiSendCommand(command, Future())=

+        self=2E_send_queue=2Eput_nowait(cmd)
+        return cmd=2Eresult=

+
+    async def management_ready(self) -> int:
+        """
+        Wait=
s until the management interface is ready=2E Returns the management interfa=
ce version=2E
+        """
+        await self=2E_management_ready=2Ewait()=

+        return self=2Eversion
+
+    def send_line(self, line):
+        =
logger=2Edebug(f"Sending line: {line}")
+        self=2Etransport=2Ewrite(f=
"{line}\n"=2Eencode())
+
+    """
+    Set the bytecount interval=2E Use 0 =
to disable
+    """
+
+    async def set_bytecount_interval(self, interval:=
 int):
+        return await self=2Equeue_command(f"bytecount {interval}")
=
+
+    async def enable_log(self):
+        return await self=2Equeue_comma=
nd("log on")
+
+    def recv_notify_LOG(self, args):
+        # >LOG:178645=
3401,D,MANAGEMENT: CMD 'bytecount 30'
+        timestamp, level, message =
=3D args=2Esplit(",", 2)
+
+        timestamp =3D datetime=2Efromtimestamp(=
int(timestamp))
+        level =3D level=2Estrip()
+        message =3D mes=
sage=2Estrip()
+        self=2Elog_message(timestamp, level, message)
+
+  =
  def log_message(self, time, level, message):
+        """
+        A new =
log message has been received=2E This method is intended
+        to be ove=
rridden by a subclass to handle the log messages=2E
+        :param time:  =
  time in local time format
+        :param level:   level of the log messa=
ge
+        :param message: the log message itself
+        :return:
+     =
   """
+        logger=2Edebug(f"Received log message: {time}, {level}, {me=
ssage}")
diff --git a/sample/management/omi_client_protocol=2Epy b/sample/m=
anagement/omi_client_protocol=2Epy
new file mode 100644
index 0000000=2E=2E=
ce5d8ad
--- /dev/null
+++ b/sample/management/omi_client_protocol=2Epy
@@ -=
0,0 +1,123 @@
+#!/usr/bin/env python3
+# Copyright (c) 2026 OpenVPN Inc <sa=
les@openvpn=2Enet>
+# Copyright (c) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
=
+#
+# Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+# of this software and associated documentation files (the "Softwa=
re"), to deal
+# in the Software without restriction, including without lim=
itation the rights
+# to use, copy, modify, merge, publish, distribute, sub=
license, and/or sell
+# copies of the Software, and to permit persons to wh=
om the Software is
+# furnished to do so, subject to the following conditio=
ns:
+#
+# The above copyright notice and this permission notice shall be in=
cluded in all
+# copies or substantial portions of the Software=2E
+#
+# TH=
E SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+#=
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+=
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL=
 THE
+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARIS=
ING FROM,
+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER =
DEALINGS IN THE
+# SOFTWARE=2E
+import base64
+import logging
+
+from omi i=
mport OmiProtocol
+
+logger =3D logging=2EgetLogger(__name__)
+logger=2Eset=
Level(logging=2EDEBUG)
+
+
+
+class OMIClientProtocol(OmiProtocol):
+    ""=
"
+    Implement the management protocol for the client  
+    """
+    def=
 __init__(self, finish_future, connect_data):
+        super()=2E__init__(f=
inish_future=3Dfinish_future, connect_data=3Dconnect_data)
+        self=2E=
_partial_acc_msg =3D ""
+        self=2E_protocol_acc_msg =3D ""
+        s=
elf=2E_acc_fragment_length =3D 980
+        self=2E_acc_negotiated_protocol=
s =3D []
+
+    async def send_acc_msg(self, protocol: str, msg: bytes):
+ =
       """
+        Sends out an ACC to the server using the specified ACC =
message length
+        :param protocol:
+        :param msg:
+        :par=
am fragment_length:
+        :return:
+        """
+        if protocol not=
 in self=2E_acc_negotiated_protocols:
+            logger=2Eerror(f"Error: =
trying to send ACC message with protocol {protocol} is not in the negotiate=
d list of protocols ({self=2E_acc_negotiated_protocols})")
+
+        # See=
 init=2Ec for the explanation for the length calculation
+        max_heade=
r_size =3D len("ACC,") + len(protocol) + 1 + 4 + 1 + 2 + 1
+
+        # cal=
culate fragment size with base64 encoding
+        fragment_length =3D self=
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
+            commands=2Eappend(f"acc-msg\n{proto=
col}\n{flags}\n{b64msg}\nEND")
+
+        for command in commands:
+       =
     await self=2Equeue_command(command)
+
+    def recv_notify_ACC_PROTOCO=
LS(self, args):
+        params =3D args=2Esplit(",")
+        acc_params =
=3D { }
+
+        for p in params:
+            k, v  =3D p=2Esplit("=3D",=
 1)
+            acc_params[k=2Estrip()] =3D v=2Estrip()
+
+        self=2E=
_acc_negotiated_protocols =3D acc_params['protocols']=2Esplit(":")
+
+     =
   self=2E_acc_fragment_length =3D int(acc_params['message_len'])
+
+    de=
f recv_notify_ACC(self, args):
+        protocol, fragment, b64msg =3D args=
=2Esplit(",", 2)
+
+        if self=2E_partial_acc_msg and self=2E_protocol=
_acc_msg !=3D protocol:
+            logger=2Eerror(f"Recieved ACC message =
with protocol {protocol} before "
+                          f"previous ACC=
 message with protocol {self=2E_protocol_acc_msg} was complete")
+         =
   self=2E_partial_acc_msg =3D ""
+
+
+        try:
+            msg =3D ba=
se64=2Edecodebytes(b64msg=2Eencode())
+            self=2E_partial_acc_msg =
+=3D msg=2Edecode()
+            self=2E_protocol_acc_msg =3D protocol
+   =
     except Exception as e:
+            logger=2Eerror(f"Error parsing ACC=
 message: {e}", exc_info=3DTrue)
+            return
+
+        fragmented =
=3D fragment !=3D "0"
+        logger=2Edebug(f"Received ACC message (fragm=
ent {fragmented}, protocol {protocol!r}), with payload {msg=2Edecode()!r}")=

+
+
+        # Message is not yet complete=2E Wait for more fragments=2E
+=
        if fragmented:
+            return
+
+        if hasattr(self, f"re=
ceive_acc_{protocol}"):
+            handler =3D getattr(self, f"receive_ac=
c_{protocol}")
+            logger=2Edebug(f"Calling handler {handler}")
+ =
           try:
+                handler(self=2E_partial_acc_msg)
+        =
    except Exception as e:
+                logger=2Eerror(f"Error parsing =
ACC message: {e}", exc_info=3DTrue)
+        else:
+            logger=2Ein=
fo(f"Received unhandled ACC protocol: {protocol}")
+
+        self=2E_parti=
al_acc_msg =3D ""
+        self=2E_protocol_acc_msg =3D ""
\ No newline at =
end of file
diff --git a/sample/management/omi_server_demo=2Epy b/sample/ma=
nagement/omi_server_demo=2Epy
new file mode 100755
index 0000000=2E=2Ed442b=
2b
--- /dev/null
+++ b/sample/management/omi_server_demo=2Epy
@@ -0,0 +1,29=
5 @@
+#! /usr/bin/env python3
+# Copyright (c) 2026 OpenVPN Inc <sales@open=
vpn=2Enet>
+# Copyright (c) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+#
+# Pe=
rmission is hereby granted, free of charge, to any person obtaining a copy
=
+# of this software and associated documentation files (the "Software"), to=
 deal
+# in the Software without restriction, including without limitation =
the rights
+# to use, copy, modify, merge, publish, distribute, sublicense,=
 and/or sell
+# copies of the Software, and to permit persons to whom the S=
oftware is
+# furnished to do so, subject to the following conditions:
+#
+=
# The above copyright notice and this permission notice shall be included i=
n all
+# copies or substantial portions of the Software=2E
+#
+# THE SOFTWA=
RE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED=
, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNES=
S FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE
+# =
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# L=
IABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM=
,
+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS=
 IN THE
+# SOFTWARE=2E
+
+import asyncio
+import logging
+from base64 impor=
t standard_b64decode
+
+from omi_server_protocol import OMIServerProtocol, =
ConnectedClient
+from omi_tools import run_main, start_management_protocol,=
 ConnectData
+from omi_tools import openvpn_escape
+
+# This implement a sm=
all demonstration of using the
+# OpenVPN Access Server Management Interfac=
e (OMI)
+# and a script that does various action on the client depending
+#=
 on the username the user connects with
+# ensure that you have a proper ce=
rtificate based authentication setup
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
+# - googlext: sends you to https://www=2Egoogle=2Ecom/=
search?q=3Dexternal with external flags and WEBAUTH \
+#         - dnssec: =
send only dnssec servers
+# - nodns: no dns servers
+# - dnssecfb: dns serv=
er with fallback to dns without dnnsec
+# - dnsdhcp: dns options and dhcp_o=
ptions
+# - dnsport: dns server with custom port
+# - failaccdpc1: auth fai=
led message indicating that the client is missing dpc1 ACC support=2E
+# - =
failaccdpc1user: auth failed message indicating that the client is missing =
dpc1 ACC support indicating a auth-token and user for reconnecting
+#     -=
 failaccflower: auth failed message indicating that the client is missing f=
lower and power ACC support=2E
+# - default: push DNS 8=2E8=2E8=2E8 and def=
ault route
+# - notify: Gives the client a message to display to the user v=
ia notify protocol
+
+# The hard-coded secret
+totp_secret =3D "totpinsecur=
etotp"
+
+logging=2EbasicConfig()
+logger =3D logging=2EgetLogger(__name__)=

+logger=2EsetLevel(logging=2EINFO)
+
+try:
+    import pyotp
+except Impor=
tError:
+    logger=2Einfo("pytop module not found=2E TOTP testing disabled=
")
+
+class ServerDemoConnectedClient(ConnectedClient):
+    # Remember the=
 key-id that we authenticated
+    authenticated_kid =3D None
+    env =3D =
{}
+
+class ServerDemoProtocol(OMIServerProtocol):
+    def __init__(self, =
finish_future, connect_data: ConnectData =3D None):
+        super()=2E__in=
it__(finish_future, connect_data)
+        self=2E_connected_client_class =
=3D ServerDemoConnectedClient
+
+    def client_event_ESTABLISHED(self, cli=
ent, kid, env, extra):
+        print(f"CLient connected: {client}")
+
+   =
     kid =3D client=2Eauthenticated_kid
+
+    def client_event_CONNECT(sel=
f, client, kid, env, extra):
+        print(f"Authenticating client {client=
=2Ecid}, {kid}")
+        client=2Eauthenticated_kid =3D kid
+        clien=
t=2Eenv =3D env
+
+        asyncio=2Ecreate_task(self=2Edo_client_auth(clie=
nt, kid))
+
+
+    async def deny_client(self, client, kid, reason, client_=
reason=3DNone):
+        # Note, for this test script sending your real rea=
son if you do not
+        # specify a client reason is okay=2E In a real e=
nvironment, this kind
+        # of information is potentially bad
+
+     =
   if not client_reason:
+            client_reason =3D reason
+        cli=
ent_deny =3D f'client-deny {client=2Ecid} {kid} "{openvpn_escape(reason)}" =
"{openvpn_escape(client_reason)}"'
+        await self=2Equeue_command(clie=
nt_deny)
+
+    async def do_client_auth(self, client, kid):
+        usern=
ame =3D client=2Eenv=2Eget("username")
+
+        # success
+        if use=
rname=2Estartswith("url"):
+            username =3D username[3:]
+        =
    method =3D "openurl"
+            webauth =3D "OPEN_URL:"
+        else=
:
+            method =3D "webauth"
+            webauth =3D "WEB_AUTH::"
+=

+        if username =3D=3D 'fail' or 'UV_FAIL' in client=2Eenv:
+        =
    await self=2Edeny_client(client, kid, "fail")
+        elif username =
=3D=3D 'failtemp':
+            await self=2Edeny_client(client, kid, "TEMP=
:Go away for a while")
+        elif username =3D=3D 'failn':
+            =
await self=2Edeny_client(client, kid, "Bonus new line for you!\n")
+       =
 elif username =3D=3D 'failn2':
+            await self=2Edeny_client(clien=
t, kid, "Bonus new line for you!\nand another one\n")
+        elif usernam=
e =3D=3D 'failtemp42':
+            await self=2Edeny_client(client, kid, "=
TEMP[backoff 42]:Go away for a 42s")
+        elif username =3D=3D 'failtem=
pnr':
+            await self=2Edeny_client(client, kid, "TEMP[backoff 11,a=
dvance remote]:Annoy the next server!")
+        elif username =3D=3D 'fail=
accdpc1':
+            await self=2Edeny_client(client, kid, "ACC[protocol =
dpc1]: To connect to this server you need to upgrade to a client that suppo=
rts the OpenVPN Inc device posture protocol, e=2Eg=2E OpenVPN Connect versi=
on 1=2E2=2E3 or later")
+        elif username =3D=3D 'failaccflower':
+   =
         await self=2Edeny_client(client, kid, "ACC[protocol flower power]:=
 You need to embrace the flower power")
+        elif username =3D=3D 'fail=
accdpc1user':
+            await self=2Edeny_client(client, kid, "ACC[proto=
col flower power, user c3VjY2Vzcw=3D=3D, pass MTIzNDU2Nzg=3D]: Please come =
back again  after you enabled dpc1")
+        elif username =3D=3D 'success=
':
+            await self=2Esend_client_auth(client, kid)
+        elif us=
ername =3D=3D 'faildelay':
+            await asyncio=2Esleep(20)
+        =
    await self=2Edeny_client(client, kid, "I thought 20s about it and rejec=
ted you after that time")
+        elif username =3D=3D 'successdelay':
+  =
          await asyncio=2Esleep(20)
+            await self=2Esend_client_a=
uth(client, kid)
+        elif username=2Estartswith('totp'):
+            =
timeout =3D 90
+            extra =3D f"CR_TEXT:E,R:Please enter your TOTP =
code, {username}!"
+            logger=2Einfo(f"The TOTP the client needs t=
o provide is: {self=2Eget_current_totp_code()}")
+            await self=2E=
send_pending_auth(client, kid, extra, timeout)
+        elif username =3D=
=3D 'rick':
+            await asyncio=2Esleep(3)
+            await self=
=2Esend_pending_auth(client, kid, webauth + "https://www=2Eyoutube=2Ecom/wa=
tch?v=3DdQw4w9WgXcQ")
+            await asyncio=2Esleep(10)
+            a=
wait self=2Edeny_client(client, kid, "I got you")
+        elif username =
=3D=3D 'openvpn':
+            await self=2Esend_pending_auth(client, webau=
th + "https://community=2Eopenvpn=2Enet")
+            await self=2Esend_cl=
ient_auth(client, kid)
+        elif username =3D=3D 'googleext':
+        =
    await self=2Esend_pending_auth(client, kid,  "WEB_AUTH:external:https:/=
/www=2Egoogle=2Ecom/search?q=3Dexternal")
+            await asyncio=2Eslee=
p(10)
+            await self=2Esend_client_auth(client, kid)
+        elif=
 username =3D=3D 'google':
+            await self=2Esend_pending_auth(clie=
nt, kid,  "WEB_AUTH::https://www=2Egoogle=2Ecom/search?q=3Dexternal")
+    =
        await asyncio=2Esleep(10)
+            await self=2Esend_client_aut=
h(client, kid)
+        elif username =3D=3D 'special':
+            extra =
=3D f"CR_TEXT:E:This special username is known, doing nothing, really"
+   =
         await self=2Esend_pending_auth(client, kid,extra)
+        elif us=
ername in ['success', 'dnssec', 'nodns', 'dnssecfb', 'default']:
+         =
   await asyncio=2Esleep(1)
+            await self=2Esend_client_auth(clie=
nt, kid)
+        elif username =3D=3D "notify":
+            await self=2E=
send_pending_auth(client ,kid, "NOTIFY:Please wait for 23s to let the serve=
r think if it want to admit you")
+            await asyncio=2Esleep(23)
+ =
           await self=2Esend_client_auth(client, kid)
+        else:
+     =
       await self=2Edeny_client(client, kid, f"The username you used ({user=
name}) is unknown, please pick one that I know")
+
+
+    async def send_cl=
ient_auth(self, client, kid):
+        username =3D client=2Eenv=2Eget("use=
rname")
+
+        config =3D ""
+        if username =3D=3D 'dnssec':
+   =
         config +=3D"""
+            push "dns server 7 address 8=2E8=2E8=
=2E8:53"
+            push "dns server 7 dnssec yes"
+            """
+    =
    elif username =3D=3D 'nodns':
+            pass
+        elif username =
=3D=3D 'dnssecfb':
+            config +=3D"""
+            push "dns serve=
r 7 address 8=2E8=2E8=2E8:53"
+            push "dns server 7 dnssec yes"
+=
            push "dns server 10 address 8=2E8=2E8=2E8"
+            push "d=
ns server 10 transport DoT"
+            push "dns server 12 address 8=2E8=
=2E8=2E8"
+            push "dns server 12 transport DoH"
+            push=
 "dns server 19 address 8=2E8=2E8=2E8:53"
+            """
+        elif us=
ername =3D=3D 'dnsdhcp':
+            config +=3D"""
+            push "dns=
 server 19 address 8=2E8=2E8=2E8:53"
+            push "dhcp-options dns se=
rver 1=2E1=2E1=2E1"
+            """
+        elif username =3D=3D 'dnsport=
':
+            config +=3D"""
+            push "dns server 20 address 8=
=2E8=2E8=2E8:5353"
+            """
+        elif username =3D=3D 'default'=
:
+            config +=3D"""
+            push "dns server 19 address 8=2E=
8=2E8=2E8:53"
+            push "dhcp-options dns server 1=2E1=2E1=2E1"
+  =
          push "redirect-gateway def1"
+            """
+
+        if not c=
onfig:
+            await self=2Equeue_command(f"client-auth-nt {client=2Ec=
id} {kid}")
+        else:
+            await self=2Equeue_command(f"client=
-auth {client=2Ecid} {kid}\n{config}\nEND\n")
+
+
+    async def send_pendi=
ng_auth(self, client, kid, extra, timeout=3D180):
+        auth_pending_tot=
p_cmd =3D f'client-pending-auth {client=2Ecid} {kid} "{extra}" {timeout}'
+=
        await self=2Equeue_command(auth_pending_totp_cmd)
+
+
+    def clie=
nt_event_CR_RESPONSE(self, client, kid, env, extra):
+        client=2Eenv =
=3D env
+        asyncio=2Ecreate_task(self=2Eclient_crresponse(client, kid=
, extra))
+
+
+    def get_current_totp_code(self):
+        try:
+        =
    import pyotp
+        except ImportError:
+            return "pyotp no=
t found"
+
+        totp =3D pyotp=2ETOTP(totp_secret)
+        return totp=
=2Enow()
+
+
+    async def client_crresponse(self, client, kid, response):=

+        # Try importing the pyotp here to allow the script run without py=
otp
+        # installed
+        try:
+            import pyotp
+        e=
xcept ImportError:
+            await self=2Edeny_client(client, kid, "pyto=
p module not found=2E Cannot do MFA testing")
+            return
+
+      =
  try:
+            response =3D standard_b64decode(response)
+            =
response =3D response=2Edecode()=2Estrip()
+        except Exception as e:
=
+            await self=2Edeny_client(client, kid, f"Decoding totp response=
 failed: {e}")
+            return
+
+        totp =3D pyotp=2ETOTP(totp_se=
cret)
+
+        logger=2Einfo(f"\nCR: expected totp '{totp=2Enow()}', resp=
onse was '{response}'\n")
+        # Check if the code is valid (and also a=
llow code +/-1)
+
+        if totp=2Everify(response, valid_window=3D1):
+ =
           await self=2Esend_client_auth(client, kid)
+        else:
+     =
       await self=2Edeny_client(client, kid, "TOTP verification failed")
+
=
+
+
+async def main(connect_data: ConnectData):
+    transport, protocol, f=
inish_future =3D await start_management_protocol(connect_data, ServerDemoPr=
otocol)
+
+    management_version =3D await protocol=2Emanagement_ready()
+=
    print(f"Management interface version: {management_version}")
+
+    awa=
it protocol=2Eenable_log()
+
+    await protocol=2Eset_bytecount_interval(5=
)
+
+    await finish_future
+
+
+if __name__ =3D=3D '__main__':
+   run_ma=
in(main)
diff --git a/sample/management/omi_server_protocol=2Epy b/sample/m=
anagement/omi_server_protocol=2Epy
new file mode 100644
index 0000000=2E=2E=
fd72434
--- /dev/null
+++ b/sample/management/omi_server_protocol=2Epy
@@ -=
0,0 +1,230 @@
+#!/usr/bin/env python3
+# Copyright (c) 2026 OpenVPN Inc <sa=
les@openvpn=2Enet>
+# Copyright (c) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
=
+#
+# Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+# of this software and associated documentation files (the "Softwa=
re"), to deal
+# in the Software without restriction, including without lim=
itation the rights
+# to use, copy, modify, merge, publish, distribute, sub=
license, and/or sell
+# copies of the Software, and to permit persons to wh=
om the Software is
+# furnished to do so, subject to the following conditio=
ns:
+#
+# The above copyright notice and this permission notice shall be in=
cluded in all
+# copies or substantial portions of the Software=2E
+#
+# TH=
E SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+#=
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+=
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL=
 THE
+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARIS=
ING FROM,
+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER =
DEALINGS IN THE
+# SOFTWARE=2E
+import base64
+import logging
+from datacla=
sses import dataclass
+
+from omi import OmiProtocol, ConnectionProperties
=
+
+logger =3D logging=2EgetLogger(__name__)
+logger=2EsetLevel(logging=2EIN=
FO)
+
+@dataclass
+class ConnectedClient:
+    """This represents a connect=
ed client instance=2E"""
+    cid: int
+    bytes_sent: int =3D 0  
+    by=
tes_received: int =3D 0
+    _partial_acc_msg: str =3D ""
+    _protocol_ac=
c_msg: str =3D ""
+    _kid_acc_msg =3D -1
+    _acc_fragment_length =3D 98=
0
+    acc_negotiated_protocols =3D []
+
+
+class OMIServerProtocol(OmiProt=
ocol):
+    """
+    This class implement common method for the OMI when Op=
enVPN is running
+    as a server=2E These are mainly helper function and f=
unctionality that
+    is only available/useful for OpenVPN running as a se=
rver
+    """
+
+    # Connected client class, can be overridden by subclas=
ses to store
+    # more information about the connected client
+    _conne=
cted_client_class =3D ConnectedClient
+
+    def __init__(self, finish_futu=
re, connect_data: ConnectionProperties =3D None):
+        super()=2E__init=
__(finish_future, connect_data)
+        self=2E_reset_pending_client_event=
()
+        self=2E_connected_clients =3D {}
+
+    def _reset_pending_clie=
nt_event(self):
+        self=2E_pending_client_event =3D None
+        sel=
f=2E_pending_client_event_cid =3D -1
+        self=2E_pending_client_event_=
kid =3D -1
+        self=2E_pending_client_event_extra_args =3D None
+     =
   self=2E_client_env =3D {}
+
+    def recv_notify_CLIENT(self, args: str)=
:
+        event, args =3D args=2Esplit(",", 1)
+
+        if event =3D=3D =
"ENV":
+            if args =3D=3D "END":
+                # Client environ=
ment is finished, trigger previous client
+                # event that con=
tained an ENV
+                self=2E_trigger_client_event(self=2E_pending=
_client_event, self=2E_pending_client_event_cid,
+                         =
                  self=2E_pending_client_event_kid, self=2E_client_env,
+  =
                                         self=2E_pending_client_event_extra=
_args)
+                self=2E_reset_pending_client_event()
+            e=
lse:
+                key, value =3D args=2Esplit("=3D", 1)
+              =
  self=2E_client_env[key] =3D value
+
+        elif event in ("ESTABLISHED"=
, "DISCONNECT"):
+            # This event is followed by a client environm=
ent=2E Wait for
+            # the client environment to be completed befor=
e triggering the event
+            cid =3D int(args)
+
+            self=
=2E_pending_client_event =3D event
+            self=2E_pending_client_even=
t_cid =3D int(cid)
+            self=2E_pending_client_event_kid =3D None
+=
            if event =3D=3D "ESTABLISHED":
+                self=2E_add_cli=
ent(cid)
+
+        elif event in ("CONNECT", "REAUTH"):
+            # Thi=
s event is similar to other event but also carries the key-id
+            =
cid, kid =3D args=2Esplit(",", 1)
+            cid, kid =3D int(cid), int(k=
id)
+            self=2E_add_client(cid)
+
+            self=2E_pending_cli=
ent_event =3D event
+            self=2E_pending_client_event_cid =3D int(c=
id)
+            self=2E_pending_client_event_kid =3D int(kid)
+        eli=
f event =3D=3D "CR_RESPONSE":
+            # This event is similar to CONNE=
CT and REAUTH but has an extra
+            # parameter with the crtext res=
ponse
+            cid, kid, response =3D args=2Esplit(",", 2)
+           =
 cid, kid =3D int(cid), int(kid)
+
+            self=2E_pending_client_even=
t =3D event
+            self=2E_pending_client_event_cid =3D int(cid)
+   =
         self=2E_pending_client_event_kid =3D int(kid)
+            self=2E=
_pending_client_event_extra_args =3D response
+        elif event in ("ACC"=
, ):
+            cid, kid, acc_args =3D args=2Esplit(",", 2)
+            =
self=2E_trigger_client_event(event, int(cid), int(kid), None, acc_args)
+  =
      else:
+            logger=2Einfo(f"Client event {event} not handled=
=2E (message: {args!r})")
+
+
+    def client_event_ACC(self, client: Conne=
ctedClient, kid, env, extra):
+        protocol, fragment, b64msg =3D extra=
=2Esplit(",", 2)
+
+        if client=2E_partial_acc_msg and client=2E_prot=
ocol_acc_msg !=3D protocol:
+            logger=2Eerror(f"Recieved ACC mess=
age with protocol {protocol} before "
+                          f"previous=
 ACC message with protocol {client=2E_protocol_acc_msg} was complete")
+   =
         client=2E_partial_acc_msg =3D ""
+
+        if client=2E_partial_a=
cc_msg and client=2E_kid_acc_msg !=3D kd:
+            logger=2Eerror(f"Rec=
ieved ACC message with different key id {kid} before "
+                   =
      f"previous ACC message with key id {client=2E_kid_acc_msg} "
+       =
                  f"was complete=2E This is currently not handled")
+      =
      client=2E_partial_acc_msg =3D ""
+
+
+        try:
+            msg =
=3D base64=2Edecodebytes(b64msg=2Eencode())
+            client=2E_partial_=
acc_msg +=3D msg=2Edecode()
+            client=2E_protocol_acc_msg =3D pro=
tocol
+            client=2E_kid_acc_msg =3D kid
+
+            # Message i=
s not yet complete=2E Wait for more fragments=2E
+            if fragment !=
=3D "0":
+                return
+
+            handler_name =3D f"receive_=
acc_client_{protocol}"
+            if hasattr(self, handler_name):
+      =
          handler =3D getattr(self, handler_name)
+                logger=
=2Edebug(f"Calling handler {handler}")
+                try:
+             =
       handler(client, kid, client=2E_partial_acc_msg)
+                exc=
ept Exception as e:
+                    logger=2Eerror(f"Error parsing ACC=
 message: {e}", exc_info=3DTrue)
+            else:
+                logger=
=2Einfo(f"Received unhandled ACC protocol: {protocol}, handler {handler_nam=
e} not found")
+
+            client=2E_partial_acc_msg =3D ""
+           =
 client=2E_protocol_acc_msg =3D protocol
+
+        except Exception as e:
=
+            logger=2Eerror(f"Error parsing ACC message from client: {e}", =
exc_info=3DTrue)
+            client=2E_partial_acc_msg =3D ""
+           =
 return
+
+
+        client=2E_partial_acc_msg =3D ""
+
+    def recv_notif=
y_BYTECOUNT_CLI(self, args):
+        cid, bytes_sent, bytes_received =3D a=
rgs=2Esplit(",", 2)
+
+        client =3D self=2E_connected_clients=2Eget(i=
nt(cid))
+        if client:
+            client=2Ebytes_sent =3D int(bytes=
_sent)
+            client=2Ebytes_received =3D int(bytes_received)
+
+
+  =
  def _trigger_client_event(self, event, cid, kid, env, extra):
+        cl=
ient =3D self=2E_connected_clients=2Eget(cid, None)
+
+        # Remember A=
CC protocol options if present
+        if event =3D=3D "CONNECT" and "acc_=
protocols" in env:
+            client=2Eacc_negotiated_protocols =3D [p=2E=
strip() for p in env["acc_protocols"]=2Esplit(":")]
+            client=2E_=
acc_fragment_length =3D int(env['acc_message_len'])
+
+        handler_name=
 =3D f"client_event_{event}"
+        if hasattr(self, handler_name):
+    =
        handler =3D getattr(self, handler_name)
+            handler(client=
, kid, env, extra)
+        else:
+            logger=2Einfo(f"Client event=
 {event} not handled=2E Method {handler_name} does not exist=2E")
+
+    de=
f _add_client(self, cid):
+        if not cid in self=2E_connected_clients:=

+            self=2E_connected_clients[cid] =3D self=2E_connected_client_c=
lass(cid =3D cid)
+
+    def _remove_client(self, cid):
+        del self=
=2E_connected_clients[cid]
+
+    async def get_client_status(self) -> OmiC=
ommandResult:
+        cmd_result =3D self=2Equeue_command("status 3")
+   =
     return await cmd_result
+
+    async def send_acc_msg(self, client: Co=
nnectedClient, kid, protocol: str, msg: bytes):
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
+
+        # See init=2Ec for the expl=
anation for the length
+        max_header_size =3D len("ACC,") + len(proto=
col) + 1 + 4 + 1 + 2 + 1
+
+        # calculate fragment size with base64 e=
ncoding
+        fragment_length =3D client=2E_acc_fragment_length * 6 // 8=
 - max_header_size
+
+        commands =3D []
+        for part_start in ra=
nge(0, len(msg), fragment_length):
+
+            msg_part =3D msg[part_sta=
rt:part_start + fragment_length]
+            b64msg =3D base64=2Eencodebyt=
es(msg_part)=2Edecode()
+
+            flags =3D "6"
+            if part_s=
tart + fragment_length < len(msg):
+                flags =3D "6:F"
+
+    =
        commands=2Eappend(f"client-acc-msg {client=2Ecid} {kid}\n{protocol}=
\n{flags}\n{b64msg}\nEND")
+
+        for command in commands:
+           =
 await self=2Equeue_command(command)
+
diff --git a/sample/management/omi_t=
ools=2Epy b/sample/management/omi_tools=2Epy
new file mode 100644
index 000=
0000=2E=2E4541f34
--- /dev/null
+++ b/sample/management/omi_tools=2Epy
@@ -=
0,0 +1,105 @@
+#! /usr/bin/python3
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
+import asyncio
+import os
+import re
+from dat=
aclasses import dataclass
+
+from omi import OmiProtocol, ConnectionPropert=
ies
+
+
+@dataclass
+class ConnectData(ConnectionProperties):
+    socket: =
str
+
+
+openvpn_escape_re =3D re=2Ecompile(r'(["\\])')
+filt_ctrl_re =3D r=
e=2Ecompile(r"[\x00-\x1f\x7f]+")
+def openvpn_escape(text):
+    """Escapes=
 a string to be safely used for OpenVPN inside
+    a quoted string
+
+    =
Something like 'client-deny 2 3 "{openvpn_escape(reason)}" "{openvpn_escape=
(client_reason)}"'
+    """
+    text =3D re=2Esub(filt_ctrl_re, ' ', text)=

+    text =3D re=2Esub(openvpn_escape_re, r'\\\1', text)
+    return text=
=2Erstrip()
+
+def get_unix_script_environment() -> ConnectData | None:
+  =
  password =3D os=2Eenviron=2Eget("MANAGEMENT_PASSWORD", None)
+    socket =
=3D os=2Eenviron=2Eget("MANAGEMENT_SOCKET", None)
+
+    if password and so=
cket:
+        return ConnectData(password=3Dpassword, socket=3Dsocket)
+  =
  else:
+        return None
+
+
+async def start_management_protocol(conne=
ct_data: ConnectData, protocol=3DOmiProtocol):
+    # Get a reference to th=
e event loop as we plan to use
+    # low-level APIs=2E
+    loop =3D async=
io=2Eget_running_loop()
+
+    finish_future =3D loop=2Ecreate_future()
+
+=
    print(f"Connecting to management socket {connect_data=2Esocket} with pa=
sswd {connect_data=2Epassword[:4]}=2E=2E=2E")
+    transport, protocol =3D =
await loop=2Ecreate_unix_connection(lambda: protocol(finish_future, connect=
_data),
+                                                            connec=
t_data=2Esocket)
+
+    return transport, protocol, finish_future
+
+
+asyn=
c def main():
+    transport, protocol, finish_future =3D await start_manag=
ement_protocol()
+
+    management_version =3D await protocol=2Emanagement_=
ready()
+    await protocol=2Eenable_log()
+    print(f"Management interfac=
e version: {management_version}")
+
+    await protocol=2Eset_bytecount_int=
erval(5)
+
+    await finish_future
+
+
+def run_main(main_func, connect_pa=
rameters: ConnectData =3D None):
+    """
+    Example function to run a ma=
in function to be either using the
+    environment variable for the unix-s=
cript or to use=2E If the unix-script
+    environment are detected, the fu=
nction will fork and run the main_func
+    with the ConnectData from the e=
nvironment=2E If the environment variables
+    are not available, it will =
not fork will fall back to the connect_parameters
+    if present=2E
+    :=
param connect_parameters:  fallback connect parameters if unix-script is no=
t available
+    :param main_func:           The function to call=2E
+    :=
return:
+    """
+    unix_script_parameters =3D get_unix_script_environmen=
t()
+    if unix_script_parameters:
+        asyncio=2Erun(main_func(unix_s=
cript_parameters))
+    elif connect_parameters:
+        asyncio=2Erun(mai=
n_func(connect_parameters))
+    else:
+        print(f"Must be called via =
unix-script")
+
+
+if __name__ =3D=3D '__main__':
+    run_main(main)

-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib09bafabf612e9501ea=
757647c86a450c73228a5
Gerrit-Change-Number: 1859
Gerrit-PatchSet: 4
Gerrit-=
Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>

--meVadTPEtq4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe <str=
ong>uploaded patch set #4</strong> to this change=2E</p><p><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail">View Change</a></p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Add python scripts that demonstrate using the mangement inter=
face<br><br>Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5<br>Signed-=
off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>A sample/manageme=
nt/omi=2Epy<br>A sample/management/omi_client_protocol=2Epy<br>A sample/man=
agement/omi_server_demo=2Epy<br>A sample/management/omi_server_protocol=2Ep=
y<br>A sample/management/omi_tools=2Epy<br>5 files changed, 1,032 insertion=
s(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/59/1859/4</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/sample=
/management/omi=2Epy b/sample/management/omi=2Epy</span><br><span>new file =
mode 100644</span><br><span>index 0000000=2E=2E415e6eb</span><br><span>--- =
/dev/null</span><br><span>+++ b/sample/management/omi=2Epy</span><br><span>=
@@ -0,0 +1,279 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
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
=3D"color: hsl(120, 100%, 40%);">+# This is an example implementation in py=
thon and asyncio to drive OpenVPN&#39;s</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# management interface (OMI)=2E The permissive license =
allows you to use this</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+# code in other projects=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+&quot;&q=
uot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Implement=
ation of the OpenVPN management interface (OMI) protocol=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+This implements the generic part of the OMI protocol t=
hat is common</span><br><span style=3D"color: hsl(120, 100%, 40%);">+to bot=
h client and server=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+&quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+import asyncio</span><br><span style=3D"color: hsl(120, 100%, 40%);">+imp=
ort logging</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import r=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from asyncio impor=
t Future</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from datacl=
asses import dataclass</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+from datetime import datetime</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+from typing import override, List</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+logger =3D logging=2EgetLogger(__name__)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+logger=2EsetLevel(logging=2EINFO)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+@dataclass</span><br><span style=3D"color: hsl(120, 100%, 40%);">+clas=
s OmiCommandResult:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    command: str</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 result: List[str]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   error: bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
tatus_text: str</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+@dataclass</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+class OmiSendCommand:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    command: str</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    result: Future[OmiCommandResult]</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+@dataclass</span><br><span style=3D"color: hsl(120, 100%, 40%);">+class =
ConnectionProperties:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    Properties for connecting to the management interface=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    password: str</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+class OmiProtocol(asyncio=2EProtocol):</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    def __init__(self, finish_future, connect_d=
ata: ConnectionProperties):</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        super()=2E__init__()</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        self=2Ebytes_received =3D None</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        self=2Ebytes_sent =3D None</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2Eversion =
=3D -1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=
=2ErecvBuffer =3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        self=2Efinish_future =3D finish_future</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        # Event to allow waiting for =
status of the underlying socket</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        # to become available for writing</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        self=2E_can_send =3D asyncio=2EEv=
ent()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=
=2E_can_send=2Eclear()</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # Event =
to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_m=
anagement_ready =3D asyncio=2EEvent()</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        self=2E_management_ready=2Eclear()</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        self=2E_response =3D []</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        self=2E_response_ready =3D asynci=
o=2EEvent()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
self=2E_response_ready=2Eclear()</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  self=2E_send_task =3D asyncio=2Ecreate_task(self=2E_send_loop())</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_send_queue =
=3D asyncio=2EQueue()</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        self=2E_connect_data: ConnectionProperties =3D connect_data</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    @override</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    def eof_received(self):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        logger=2Einfo(&#39;EOF received=
=2E Shutting down=2E&#39;)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        self=2E_stop()</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    @over=
ride</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def connect=
ion_lost(self, excp):</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if excp:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           logger=2Einfo(f&#39;Connection lost ({excp})=2E Shutting down=2E=
&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            logger=
=2Einfo(f&#39;Connection lost=2E Shutting down=2E&#39;)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        self=2E_stop()</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    def _stop(self):</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if not self=2Efinish_future=2Edone():</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            self=2E_send_tas=
k=2Ecancel()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     self=2Efinish_future=2Eset_result(True)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    async def _send_loop(self):</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        while True:</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            command: OmiSendCommand =3D await self=2E_sen=
d_queue=2Eget()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        await self=2E_can_send=2Ewait()</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            self=2Esend_line(command=2Ecommand)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            response =3D []</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            response_complete =3D Fals=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            # This is a bit brittle a=
s it will loop forever if not getting a</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            # line that starts with ERROR or SUCCESS=2E=
 With a normal OpenVPN</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            # daemon that speak the correct protocol this should not be =
a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            # prob=
lem</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            whil=
e not response_complete:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                await self=2E_response_ready=2Ewait()</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                line =3D self=2E_response=2Epop(0)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                response=
=2Eappend(line)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                if not =
self=2E_response:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  self=2E_response_ready=2Eclear()</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                lastline =3D response[-1]</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                if lastline=2Estartswith(=
&#39;ERROR:&#39;):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   status =3D False</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    response_complete =3D True</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    _, status_te=
xt =3D lastline=2Esplit(&quot;:&quot;, 1)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                elif lastline=2Estartswith(&#39;SUCCESS:&#39;):</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    status =
=3D True</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         response_complete =3D True</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    _, status_text =3D lastline=2Esplit(&qu=
ot;:&quot;, 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           elif lastline =3D=3D &quot;END&quot;:</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    status =3D True</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    response_c=
omplete =3D True</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 status_text =3D None</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                else:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    pass</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            # logger=2Edebug(f&#39;Result received command: {response=
}&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
result =3D OmiCommandResult(command=2Ecommand, response[:-1], status, statu=
s_text)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            command=2Eresult=2E=
set_result(result)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           logger=2Edebug(f&quot;Command done=2E&quot;)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    @override</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    def pause_writing(self):</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        self=2E_can_send=2Eclear()</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    @override</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    def resume_writing(self):</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        self=2E_can_send=2Eset()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    @override</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    def connection_made(self, transport):</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        peername =3D transport=2Eget_extra_i=
nfo(&#39;peername&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        logger=2Einfo(&#39;Connection from {}&#39;=2Eformat(peername))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2Etrans=
port =3D transport</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       self=2E_can_send=2Eset()</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 # OMI expects us to authenticate with the password just on</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        # its own on a line</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if self=2E_connect_=
data=2Epassword:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         self=2Etransport=2Ewrite(f&quot;{self=2E_connect_data=2Epassword}\=
r\n&quot;=2Eencode())</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    @override</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    def data_received(s=
elf, data):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
# OMI protocol is pure text so decode everything as UTF-8</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        message =3D data=2Edecode()</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2ErecvBu=
ffer +=3D message</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        parts =3D sel=
f=2ErecvBuffer=2Esplit(&quot;\r\n&quot;)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        # pass complete lines to recvLine</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        for part in parts[:-1]:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            logger=2Edebug(f&#39;Line r=
eceived: {part!r}&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            self=2Erecv_line(part)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        # keep the last incomplete line for the next call</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        self=2ErecvBuffer =3D parts[-=
1]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    def recv_line(self, line):</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if line=2Estartsw=
ith(&quot;&gt;&quot;):</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            self=2Erecv_notify(line)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        else:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            self=2E_response=2Eappend(line)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            self=2E_response_ready=2E=
set()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    def recv_notify(self, line):<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if not &quot=
;:&quot; in line:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          logger=2Ewarning(&quot;Invalid line received: &quot; + line)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            return</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        command, args =3D line[1:]=2Esplit(&=
quot;:&quot;, 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        # do dynamic d=
ispatch based on command to call a handler</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if hasattr(self, f&quot;recv_notify_{command=
}&quot;):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  handler =3D getattr(self, f&quot;recv_notify_{command}&quot;)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            handler(args)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            return</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        logger=2Einfo(&quot;Unknown notify li=
ne received: &quot; + line)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def rec=
v_notify_INFO(self, args):</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        m =3D re=2Ematch(r&quot;OpenVPN Management Interface Version=
 (?P&lt;version&gt;\d+)&quot;, args)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if m:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            self=2Eversion =3D int(m=2Egroup(&quot;version&quot;=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            self=
=2E_management_ready=2Eset()</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        else:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            logger=2Ewarning(f&quot;Unknown INFO line received: {args}&q=
uot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    def recv_notify_BYTECOUNT(sel=
f, args):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        by=
tes_sent, bytes_received =3D args=2Esplit(&quot;,&quot;, 1)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        self=2Ebytes_sent =3D int(b=
ytes_sent)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s=
elf=2Ebytes_received =3D int(bytes_received)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    async def _release_hold_task(self, hold_time: int =3D 0):</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        await asyncio=2Esle=
ep(hold_time)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  await self=2Equeue_command(&quot;hold release&quot;)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    def recv_notify_HOLD(self, args):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        _text, hold_time =3D args=2Esplit=
(&quot;:&quot;, 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       hold_time =3D int(hold_time)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     asyncio=2Ecreate_task(self=2E_release_hold_task(hold_time))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    def queue_command(self, command) -&gt; Future=
[OmiCommandResult]:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        cmd =3D OmiSendCommand(command, Future())</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        self=2E_send_queue=2Eput_nowait(cmd)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return cmd=
=2Eresult</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    async def management_read=
y(self) -&gt; int:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        Waits until the management interface is ready=2E Returns the =
management interface version=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        &quot;&quot;&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        await self=2E_management_ready=2Ewait()</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return self=2Eversio=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    def send_line(self, line):</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        logger=2Edebug(f&q=
uot;Sending line: {line}&quot;)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        self=2Etransport=2Ewrite(f&quot;{line}\n&quot;=2Eencode=
())</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    Set the bytecount interval=
=2E Use 0 to disable</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    async def s=
et_bytecount_interval(self, interval: int):</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return await self=2Equeue_command(f&quot;by=
tecount {interval}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    async def=
 enable_log(self):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return await self=2Equeue_command(&quot;log on&quot;)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    def recv_notify_LOG(self, args):</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        # &gt;LOG:1786453401,D,MANAG=
EMENT: CMD &#39;bytecount 30&#39;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        timestamp, level, message =3D args=2Esplit(&quot;,&qu=
ot;, 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        timestamp =3D datetime=
=2Efromtimestamp(int(timestamp))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        level =3D level=2Estrip()</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        message =3D message=2Estrip()</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        self=2Elog_message(tim=
estamp, level, message)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def log_mes=
sage(self, time, level, message):</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        &quot;&quot;&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        A new log message has been received=2E This me=
thod is intended</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     to be overridden by a subclass to handle the log messages=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        :param time:    time =
in local time format</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        :param level:   level of the log message</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        :param message: the log message itsel=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        :return:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;&quot;&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        logger=
=2Edebug(f&quot;Received log message: {time}, {level}, {message}&quot;)</sp=
an><br><span>diff --git a/sample/management/omi_client_protocol=2Epy b/samp=
le/management/omi_client_protocol=2Epy</span><br><span>new file mode 100644=
</span><br><span>index 0000000=2E=2Ece5d8ad</span><br><span>--- /dev/null</=
span><br><span>+++ b/sample/management/omi_client_protocol=2Epy</span><br><=
span>@@ -0,0 +1,123 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#!/usr/bin/env python3</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+# Copyright (c) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# Copyright (c) 2026 Arne Sc=
hwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Per=
mission is hereby granted, free of charge, to any person obtaining a copy</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# of this software an=
d associated documentation files (the &quot;Software&quot;), to deal</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+# in the Software without =
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
ARE=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import base64=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import logging</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+from omi import OmiProtocol</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+logger =3D logging=2EgetLogger(__name__)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+logger=2EsetLevel(logging=2EDEB=
UG)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+class OMIClientProtocol(OmiProtocol):</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    &quot;&quot;&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    Implement the management protocol for the client=
  </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def __init=
__(self, finish_future, connect_data):</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        super()=2E__init__(finish_future=3Dfinish_future=
, connect_data=3Dconnect_data)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        self=2E_partial_acc_msg =3D &quot;&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        self=2E_protocol_acc_msg =
=3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     self=2E_acc_fragment_length =3D 980</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        self=2E_acc_negotiated_protocols =3D []</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    async def send_acc_msg(self, protocol: st=
r, msg: bytes):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        Sends out an ACC to the server using the specified ACC message l=
ength</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        :param=
 protocol:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        :=
param msg:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        :=
param fragment_length:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        :return:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if protocol not in self=2E_acc_negotiated_protocols:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            logger=2Eerror(=
f&quot;Error: trying to send ACC message with protocol {protocol} is not in=
 the negotiated list of protocols ({self=2E_acc_negotiated_protocols})&quot=
;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
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
               flags =3D &quot;6:F&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            commands=2Eappend(f&quot;acc-msg\n{protocol}\n{flags}\n{b64ms=
g}\nEND&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        for command in c=
ommands:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 await self=2Equeue_command(command)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  def recv_notify_ACC_PROTOCOLS(self, args):</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        params =3D args=2Esplit(&quot;,&quot;)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        acc_params =3D =
{ }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        for p in params:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            k, v  =3D p=2Espli=
t(&quot;=3D&quot;, 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            acc_params[k=2Estrip()] =3D v=2Estrip()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        self=2E_acc_negotiated_protocols =3D acc_params[&#39=
;protocols&#39;]=2Esplit(&quot;:&quot;)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        self=2E_acc_fragment_length =3D int(acc_params[&#39;message_len&#3=
9;])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    def recv_notify_ACC(self, args=
):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        protocol,=
 fragment, b64msg =3D args=2Esplit(&quot;,&quot;, 2)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if self=2E_partial_acc_msg and self=2E_protocol_acc_=
msg !=3D protocol:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           logger=2Eerror(f&quot;Recieved ACC message with protocol {protoc=
ol} before &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                        f&quot;previous ACC message with protocol {self=2E_=
protocol_acc_msg} was complete&quot;)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            self=2E_partial_acc_msg =3D &quot;&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        try:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            msg =3D base64=2Edecodebytes(b64msg=2Eencode())</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            self=2E_partial=
_acc_msg +=3D msg=2Edecode()</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            self=2E_protocol_acc_msg =3D protocol</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        except Exception as e:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            logger=2Eerro=
r(f&quot;Error parsing ACC message: {e}&quot;, exc_info=3DTrue)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            return</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        fragmented =3D fragment !=3D &quot;0&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        logger=2Edeb=
ug(f&quot;Received ACC message (fragment {fragmented}, protocol {protocol!r=
}), with payload {msg=2Edecode()!r}&quot;)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # Messa=
ge is not yet complete=2E Wait for more fragments=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if fragmented:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            return</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if hasattr(self, f&quot;receive_acc_{protocol}&quo=
t;):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            han=
dler =3D getattr(self, f&quot;receive_acc_{protocol}&quot;)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            logger=2Edebug(f&quot;C=
alling handler {handler}&quot;)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            try:</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                handler(self=2E_partial_acc_msg)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            except Exception as e:</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                logger=
=2Eerror(f&quot;Error parsing ACC message: {e}&quot;, exc_info=3DTrue)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        else:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            logger=2Einfo(f&qu=
ot;Received unhandled ACC protocol: {protocol}&quot;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        self=2E_partial_acc_msg =3D &quot;&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_protocol_acc_ms=
g =3D &quot;&quot;</span><br><span>\ No newline at end of file</span><br><s=
pan>diff --git a/sample/management/omi_server_demo=2Epy b/sample/management=
/omi_server_demo=2Epy</span><br><span>new file mode 100755</span><br><span>=
index 0000000=2E=2Ed442b2b</span><br><span>--- /dev/null</span><br><span>++=
+ b/sample/management/omi_server_demo=2Epy</span><br><span>@@ -0,0 +1,295 @=
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
0%, 40%);">+from base64 import standard_b64decode</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+from omi_server_protocol import OMIServerProtocol, ConnectedClie=
nt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from omi_tools im=
port run_main, start_management_protocol, ConnectData</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+from omi_tools import openvpn_escape</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# This implement a small demonstration of=
 using the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# OpenVPN=
 Access Server Management Interface (OMI)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+# and a script that does various action on the client=
 depending</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# on the =
username the user connects with</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# ensure that you have a proper certificate based authenticatio=
n setup</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# before usi=
ng this script</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# (e=
=2Eg=2E https://github=2Ecom/openvpn/openvpn/blob/master/doc/man-sections/e=
xample-fingerprint=2Erst)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# usage:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+# --management /path/to/=
omi_server_demo=2Epy unix-script</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# The =
main purpose of this script is to test/force certain client/server</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# behaviour=2E As a test scr=
ipt this is done on the username but also serves</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# as an example how to implement something sim=
ilar for normal usage=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# if a userna=
me is prefixed with url it uses the old OPEN_URL method (e=2Eg=2E urlrick)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+# - fail: sends AUTH_FAILED</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# - failn: sends AUTH_FAILED w=
iht \n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - failtemp:=
 sends AUTH_FAILED,TEMP:Go away for a while</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+# - failtemp42: sends AUTH_FAILED,TEMP and backoff =
for 42s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#     - fail=
tempnr: sends AUTH_FAILED,TEMP and instructs to go the next remote</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# - success: sends AUTH_SUCC=
ESS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - faildelay: s=
ends AUTH_FAILED after 20s</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+# - successdelay: sends AUTH_SUCCESS after 20s</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# - rick: sends you to a certain youtube =
site and auth you</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
- openvpn: sends you to community=2Eopenvpn=2Enet</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+# - totp: Does crtext based 2FA with secret &=
quot;totpinsecuretotp&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# - google: sends you to https://www=2Egoogle=2Ecom/search?q=3Dhidd=
en without any flags</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# - googlext: sends you to https://www=2Egoogle=2Ecom/search?q=3Dexternal =
with external flags and WEBAUTH \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#         - dnssec: send only dnssec servers</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+# - nodns: no dns servers</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# - dnssecfb: dns server with =
fallback to dns without dnnsec</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+# - dnsdhcp: dns options and dhcp_options</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# - dnsport: dns server with custom port<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - failaccdpc1: aut=
h failed message indicating that the client is missing dpc1 ACC support=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - failaccdpc1user:=
 auth failed message indicating that the client is missing dpc1 ACC support=
 indicating a auth-token and user for reconnecting</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#     - failaccflower: auth failed message i=
ndicating that the client is missing flower and power ACC support=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+# - default: push DNS 8=2E=
8=2E8=2E8 and default route</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# - notify: Gives the client a message to display to the user via n=
otify protocol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+# The hard-coded secret<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+totp_secret =3D &quo=
t;totpinsecuretotp&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+logging=2Ebasi=
cConfig()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+logger =3D=
 logging=2EgetLogger(__name__)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+logger=2EsetLevel(logging=2EINFO)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+try:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    impor=
t pyotp</span><br><span style=3D"color: hsl(120, 100%, 40%);">+except Impor=
tError:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    logger=
=2Einfo(&quot;pytop module not found=2E TOTP testing disabled&quot;)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+class ServerDemoConnectedClient(ConnectedClie=
nt):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # Remember =
the key-id that we authenticated</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    authenticated_kid =3D None</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    env =3D {}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
class ServerDemoProtocol(OMIServerProtocol):</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    def __init__(self, finish_future, connect_data=
: ConnectData =3D None):</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        super()=2E__init__(finish_future, connect_data)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        self=2E_connected_client_c=
lass =3D ServerDemoConnectedClient</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
def client_event_ESTABLISHED(self, client, kid, env, extra):</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        print(f&quot;CLient connec=
ted: {client}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        kid =3D cl=
ient=2Eauthenticated_kid</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def client=
_event_CONNECT(self, client, kid, env, extra):</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        print(f&quot;Authenticating client {clie=
nt=2Ecid}, {kid}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        client=2Eauthenticated_kid =3D kid</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        client=2Eenv =3D env</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        asyncio=2Ecreate_task(self=2Edo_client_auth(client=
, kid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    async def deny_client(self, client, kid, reaso=
n, client_reason=3DNone):</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        # Note, for this test script sending your real reason if you =
do not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # spe=
cify a client reason is okay=2E In a real environment, this kind</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        # of information is po=
tentially bad</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if not client_rea=
son:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            cli=
ent_reason =3D reason</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        client_deny =3D f&#39;client-deny {client=2Ecid} {kid} &quot;{ope=
nvpn_escape(reason)}&quot; &quot;{openvpn_escape(client_reason)}&quot;&#39;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        await self=
=2Equeue_command(client_deny)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    async=
 def do_client_auth(self, client, kid):</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        username =3D client=2Eenv=2Eget(&quot;username&=
quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        # success</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if username=2Estartswith(&=
quot;url&quot;):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         username =3D username[3:]</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            method =3D &quot;openurl&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            webauth =3D &quot;OPEN_UR=
L:&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        els=
e:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            metho=
d =3D &quot;webauth&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            webauth =3D &quot;WEB_AUTH::&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if username =3D=3D &#39;fail&#39; or &#39;UV_FAIL&#3=
9; in client=2Eenv:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            await self=2Edeny_client(client, kid, &quot;fail&quot;)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        elif username =3D=
=3D &#39;failtemp&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            await self=2Edeny_client(client, kid, &quot;TEMP:Go away fo=
r a while&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     elif username =3D=3D &#39;failn&#39;:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            await self=2Edeny_client(client, kid, &q=
uot;Bonus new line for you!\n&quot;)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        elif username =3D=3D &#39;failn2&#39;:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            await self=2Edeny_c=
lient(client, kid, &quot;Bonus new line for you!\nand another one\n&quot;)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        elif usernam=
e =3D=3D &#39;failtemp42&#39;:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            await self=2Edeny_client(client, kid, &quot;TEMP[bac=
koff 42]:Go away for a 42s&quot;)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        elif username =3D=3D &#39;failtempnr&#39;:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            await self=2Edeny_=
client(client, kid, &quot;TEMP[backoff 11,advance remote]:Annoy the next se=
rver!&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 elif username =3D=3D &#39;failaccdpc1&#39;:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            await self=2Edeny_client(client, kid, =
&quot;ACC[protocol dpc1]: To connect to this server you need to upgrade to =
a client that supports the OpenVPN Inc device posture protocol, e=2Eg=2E Op=
enVPN Connect version 1=2E2=2E3 or later&quot;)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        elif username =3D=3D &#39;failaccflower=
&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            a=
wait self=2Edeny_client(client, kid, &quot;ACC[protocol flower power]: You =
need to embrace the flower power&quot;)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        elif username =3D=3D &#39;failaccdpc1user&#39;:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            await s=
elf=2Edeny_client(client, kid, &quot;ACC[protocol flower power, user c3VjY2=
Vzcw=3D=3D, pass MTIzNDU2Nzg=3D]: Please come back again  after you enabled=
 dpc1&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 elif username =3D=3D &#39;success&#39;:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            await self=2Esend_client_auth(client, kid)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        elif userna=
me =3D=3D &#39;faildelay&#39;:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            await asyncio=2Esleep(20)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            await self=2Edeny_client(client, k=
id, &quot;I thought 20s about it and rejected you after that time&quot;)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        elif username =
=3D=3D &#39;successdelay&#39;:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            await asyncio=2Esleep(20)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            await self=2Esend_client_auth(clie=
nt, kid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        eli=
f username=2Estartswith(&#39;totp&#39;):</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            timeout =3D 90</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            extra =3D f&quot;CR_TEXT:E,R:Please=
 enter your TOTP code, {username}!&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            logger=2Einfo(f&quot;The TOTP the client n=
eeds to provide is: {self=2Eget_current_totp_code()}&quot;)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            await self=2Esend_pendi=
ng_auth(client, kid, extra, timeout)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        elif username =3D=3D &#39;rick&#39;:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            await asyncio=2Esleep=
(3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            awai=
t self=2Esend_pending_auth(client, kid, webauth + &quot;https://www=2Eyoutu=
be=2Ecom/watch?v=3DdQw4w9WgXcQ&quot;)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            await asyncio=2Esleep(10)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            await self=2Edeny_client(cl=
ient, kid, &quot;I got you&quot;)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        elif username =3D=3D &#39;openvpn&#39;:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            await self=2Esend_pen=
ding_auth(client, webauth + &quot;https://community=2Eopenvpn=2Enet&quot;)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            await se=
lf=2Esend_client_auth(client, kid)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        elif username =3D=3D &#39;googleext&#39;:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            await self=2Esend_=
pending_auth(client, kid,  &quot;WEB_AUTH:external:https://www=2Egoogle=2Ec=
om/search?q=3Dexternal&quot;)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            await asyncio=2Esleep(10)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            await self=2Esend_client_auth(clien=
t, kid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        elif=
 username =3D=3D &#39;google&#39;:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            await self=2Esend_pending_auth(client, kid,  &qu=
ot;WEB_AUTH::https://www=2Egoogle=2Ecom/search?q=3Dexternal&quot;)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            await asyncio=2E=
sleep(10)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  await self=2Esend_client_auth(client, kid)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        elif username =3D=3D &#39;special&#39;:</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            extra =3D =
f&quot;CR_TEXT:E:This special username is known, doing nothing, really&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            await =
self=2Esend_pending_auth(client, kid,extra)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        elif username in [&#39;success&#39;, &#39;d=
nssec&#39;, &#39;nodns&#39;, &#39;dnssecfb&#39;, &#39;default&#39;]:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            await asyncio=
=2Esleep(1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    await self=2Esend_client_auth(client, kid)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        elif username =3D=3D &quot;notify&quot;:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            await s=
elf=2Esend_pending_auth(client ,kid, &quot;NOTIFY:Please wait for 23s to le=
t the server think if it want to admit you&quot;)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            await asyncio=2Esleep(23)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            await self=2Ese=
nd_client_auth(client, kid)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        else:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            await self=2Edeny_client(client, kid, f&quot;The username you=
 used ({username}) is unknown, please pick one that I know&quot;)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    async def send_client_auth(self, client, kid):</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        username =3D client=2Eenv=2E=
get(&quot;username&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        confi=
g =3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if username =3D=3D &#39;dnssec&#39;:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            config +=3D&quot;&quot;&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            push &quot;dns se=
rver 7 address 8=2E8=2E8=2E8:53&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            push &quot;dns server 7 dnssec yes&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;&quot;=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        elif =
username =3D=3D &#39;nodns&#39;:</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            pass</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        elif username =3D=3D &#39;dnssecfb&#39;:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            config +=3D&quot;&quot;&=
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
20, 100%, 40%);">+            config +=3D&quot;&quot;&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            push &quot;dns server 1=
9 address 8=2E8=2E8=2E8:53&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            push &quot;dhcp-options dns server 1=2E1=2E1=2E1&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &qu=
ot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    elif username =3D=3D &#39;dnsport&#39;:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            config +=3D&quot;&quot;&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            push &quot;dns se=
rver 20 address 8=2E8=2E8=2E8:5353&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            &quot;&quot;&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        elif username =3D=3D &#39;default=
&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c=
onfig +=3D&quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            push &quot;dns server 19 address 8=2E8=2E8=2E8:53&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            push &=
quot;dhcp-options dns server 1=2E1=2E1=2E1&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            push &quot;redirect-gateway def1&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &qu=
ot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if not config:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            await se=
lf=2Equeue_command(f&quot;client-auth-nt {client=2Ecid} {kid}&quot;)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        else:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            await self=2Equeue_c=
ommand(f&quot;client-auth {client=2Ecid} {kid}\n{config}\nEND\n&quot;)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    async def send_pending_auth(self, client, kid, extra, ti=
meout=3D180):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  auth_pending_totp_cmd =3D f&#39;client-pending-auth {client=2Ecid} {kid} =
&quot;{extra}&quot; {timeout}&#39;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        await self=2Equeue_command(auth_pending_totp_cmd)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    def client_event_CR_RESPONSE(self, client, kid, env, ext=
ra):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        client=
=2Eenv =3D env</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   asyncio=2Ecreate_task(self=2Eclient_crresponse(client, kid, extra))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    def get_current_totp_code(self):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        try:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            import pyotp</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        except ImportError:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            return &quot;pyotp no=
t found&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        totp =3D pyotp=2E=
TOTP(totp_secret)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return totp=2Enow()</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    async def client_crresponse(=
self, client, kid, response):</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        # Try importing the pyotp here to allow the script run wi=
thout pyotp</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
# installed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
try:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            imp=
ort pyotp</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ex=
cept ImportError:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          await self=2Edeny_client(client, kid, &quot;pytop module not foun=
d=2E Cannot do MFA testing&quot;)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            return</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  try:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            r=
esponse =3D standard_b64decode(response)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            response =3D response=2Edecode()=2Estrip()=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        except Exce=
ption as e:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    await self=2Edeny_client(client, kid, f&quot;Decoding totp response fai=
led: {e}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        totp =3D pyotp=
=2ETOTP(totp_secret)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        logger=2Ei=
nfo(f&quot;\nCR: expected totp &#39;{totp=2Enow()}&#39;, response was &#39;=
{response}&#39;\n&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        # Check if the code is valid (and also allow code +/-1)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if totp=2Everify(response, valid_wind=
ow=3D1):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 await self=2Esend_client_auth(client, kid)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        else:</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            await self=2Edeny_client(client, kid, &quot;T=
OTP verification failed&quot;)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+async def main(connect_data: ConnectData):</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    transport, protocol=
, finish_future =3D await start_management_protocol(connect_data, ServerDem=
oProtocol)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    management_version =3D a=
wait protocol=2Emanagement_ready()</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    print(f&quot;Management interface version: {management_v=
ersion}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    await protocol=2Eena=
ble_log()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    await protocol=2Eset_byte=
count_interval(5)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    await finish_futu=
re</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+if __name__ =3D=3D &#39;__main__&#39;:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+   run_main(main)</span><br><span>di=
ff --git a/sample/management/omi_server_protocol=2Epy b/sample/management/o=
mi_server_protocol=2Epy</span><br><span>new file mode 100644</span><br><spa=
n>index 0000000=2E=2Efd72434</span><br><span>--- /dev/null</span><br><span>=
+++ b/sample/management/omi_server_protocol=2Epy</span><br><span>@@ -0,0 +1=
,230 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#!/usr/bin/e=
nv python3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Copyrig=
ht (c) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# Copyright (c) 2026 Arne Schwabe &lt;arn=
e@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Permission is he=
reby granted, free of charge, to any person obtaining a copy</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# of this software and associated =
documentation files (the &quot;Software&quot;), to deal</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+# in the Software without restriction, =
including without limitation the rights</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# to use, copy, modify, merge, publish, distribute, sub=
license, and/or sell</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# copies of the Software, and to permit persons to whom the Software is</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+# furnished to do so, =
subject to the following conditions:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
 The above copyright notice and this permission notice shall be included in=
 all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# copies or sub=
stantial portions of the Software=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
 THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, =
EXPRESS OR</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# IMPLIED=
, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# FITNESS FOR A PARTICULAR PU=
RPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR=
 ANY CLAIM, DAMAGES OR OTHER</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, =
ARISING FROM,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# OUT =
OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# SOFTWARE=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+import base64</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+import logging</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+from dataclasses import dataclass</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+from omi import OmiProtocol, ConnectionPr=
operties</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+logger =3D logging=2EgetLogger=
(__name__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+logger=2E=
setLevel(logging=2EINFO)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+@dataclass</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+class ConnectedClient:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quo=
t;This represents a connected client instance=2E&quot;&quot;&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    cid: int</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    bytes_sent: int =3D 0  </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    bytes_received: int =3D=
 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    _partial_acc_=
msg: str =3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    _protocol_acc_msg: str =3D &quot;&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    _kid_acc_msg =3D -1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    _acc_fragment_length =3D 980</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    acc_negotiated_protocols=
 =3D []</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+class OMIServerProtocol(OmiProtocol):</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    This class implement comm=
on method for the OMI when OpenVPN is running</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    as a server=2E These are mainly helper functi=
on and functionality that</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    is only available/useful for OpenVPN running as a server</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    # Connected client class, can be overrid=
den by subclasses to store</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    # more information about the connected client</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    _connected_client_class =3D Connec=
tedClient</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    def __init__(self, finish=
_future, connect_data: ConnectionProperties =3D None):</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        super()=2E__init__(finish_future=
, connect_data)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    self=2E_reset_pending_client_event()</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        self=2E_connected_clients =3D {}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    def _reset_pending_client_event(self):</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_pending_clien=
t_event =3D None</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     self=2E_pending_client_event_cid =3D -1</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        self=2E_pending_client_event_kid =3D -1</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_pendin=
g_client_event_extra_args =3D None</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        self=2E_client_env =3D {}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    def recv_notify_CLIENT(self, args: str):</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        event, args =3D args=2Esplit(&qu=
ot;,&quot;, 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if event =3D=3D =
&quot;ENV&quot;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         if args =3D=3D &quot;END&quot;:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                # Client environment is finished, trig=
ger previous client</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                # event that contained an ENV</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                self=2E_trigger_client_event(self=
=2E_pending_client_event, self=2E_pending_client_event_cid,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                   =
        self=2E_pending_client_event_kid, self=2E_client_env,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
          self=2E_pending_client_event_extra_args)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                self=2E_reset_pending_client=
_event()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 else:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   key, value =3D args=2Esplit(&quot;=3D&quot;, 1)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                self=2E_client_env[key] =3D =
value</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        elif event in (&quot;ESTA=
BLISHED&quot;, &quot;DISCONNECT&quot;):</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            # This event is followed by a client enviro=
nment=2E Wait for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          # the client environment to be completed before triggering the ev=
ent</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            cid =
=3D int(args)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            self=2E_pendi=
ng_client_event =3D event</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            self=2E_pending_client_event_cid =3D int(cid)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            self=2E_pending_cli=
ent_event_kid =3D None</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            if event =3D=3D &quot;ESTABLISHED&quot;:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                self=2E_add_client(cid)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        elif event in (&quot;CONNECT&q=
uot;, &quot;REAUTH&quot;):</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            # This event is similar to other event but also carries =
the key-id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   cid, kid =3D args=2Esplit(&quot;,&quot;, 1)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            cid, kid =3D int(cid), int(kid)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            self=2E_add_=
client(cid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            self=2E_pending=
_client_event =3D event</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            self=2E_pending_client_event_cid =3D int(cid)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            self=2E_pending_clien=
t_event_kid =3D int(kid)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        elif event =3D=3D &quot;CR_RESPONSE&quot;:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            # This event is similar to =
CONNECT and REAUTH but has an extra</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            # parameter with the crtext response</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            cid, kid, response=
 =3D args=2Esplit(&quot;,&quot;, 2)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            cid, kid =3D int(cid), int(kid)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            self=2E_pending_client_event =3D event</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            self=2E_pen=
ding_client_event_cid =3D int(cid)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            self=2E_pending_client_event_kid =3D int(kid)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            self=2E_pe=
nding_client_event_extra_args =3D response</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        elif event in (&quot;ACC&quot;, ):</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            cid, kid, acc_arg=
s =3D args=2Esplit(&quot;,&quot;, 2)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            self=2E_trigger_client_event(event, int(cid), =
int(kid), None, acc_args)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        else:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            logger=2Einfo(f&quot;Client event {event} not handled=2E (messa=
ge: {args!r})&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    def client_event_ACC(self, client=
: ConnectedClient, kid, env, extra):</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        protocol, fragment, b64msg =3D extra=2Esplit(&quot=
;,&quot;, 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if client=2E_parti=
al_acc_msg and client=2E_protocol_acc_msg !=3D protocol:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            logger=2Eerror(f&quot;Reci=
eved ACC message with protocol {protocol} before &quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                          f&quot;previo=
us ACC message with protocol {client=2E_protocol_acc_msg} was complete&quot=
;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            clien=
t=2E_partial_acc_msg =3D &quot;&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if client=2E_partial_acc_msg and client=2E_kid_acc_msg !=3D kd:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            logger=2Eerr=
or(f&quot;Recieved ACC message with different key id {kid} before &quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
   f&quot;previous ACC message with key id {client=2E_kid_acc_msg} &quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
    f&quot;was complete=2E This is currently not handled&quot;)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            client=2E_partial_a=
cc_msg =3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        try:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg =3D base64=2Edecodebytes(=
b64msg=2Eencode())</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           client=2E_partial_acc_msg +=3D msg=2Edecode()</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            client=2E_protocol_acc_msg=
 =3D protocol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      client=2E_kid_acc_msg =3D kid</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         # Message is not yet complete=2E Wait for more fragments=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            if fragment !=
=3D &quot;0&quot;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               return</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            handl=
er_name =3D f&quot;receive_acc_client_{protocol}&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            if hasattr(self, handler_nam=
e):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
handler =3D getattr(self, handler_name)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                logger=2Edebug(f&quot;Calling handler {=
handler}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            try:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 handler(client, kid, client=2E_partial_acc_msg)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                except Excepti=
on as e:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         logger=2Eerror(f&quot;Error parsing ACC message: {e}&quot;, exc_in=
fo=3DTrue)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   else:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     logger=2Einfo(f&quot;Received unhandled ACC protocol: {protocol}, hand=
ler {handler_name} not found&quot;)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         client=2E_partial_acc_msg =3D &quot;&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            client=2E_protocol_acc_msg =
=3D protocol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        except Exception a=
s e:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            log=
ger=2Eerror(f&quot;Error parsing ACC message from client: {e}&quot;, exc_in=
fo=3DTrue)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   client=2E_partial_acc_msg =3D &quot;&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            return</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        clien=
t=2E_partial_acc_msg =3D &quot;&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   def recv_notify_BYTECOUNT_CLI(self, args):</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        cid, bytes_sent, bytes_received =3D args=
=2Esplit(&quot;,&quot;, 2)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        clie=
nt =3D self=2E_connected_clients=2Eget(int(cid))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if client:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            client=2Ebytes_sent =3D int(bytes_s=
ent)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            cli=
ent=2Ebytes_received =3D int(bytes_received)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def _trig=
ger_client_event(self, event, cid, kid, env, extra):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        client =3D self=2E_connected_clie=
nts=2Eget(cid, None)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # Remember=
 ACC protocol options if present</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if event =3D=3D &quot;CONNECT&quot; and &quot;acc_prot=
ocols&quot; in env:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            client=2Eacc_negotiated_protocols =3D [p=2Estrip() for p in env=
[&quot;acc_protocols&quot;]=2Esplit(&quot;:&quot;)]</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            client=2E_acc_fragment_length=
 =3D int(env[&#39;acc_message_len&#39;])</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        handler_name =3D f&quot;client_event_{event}&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if hasattr(self, handler_n=
ame):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ha=
ndler =3D getattr(self, handler_name)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            handler(client, kid, env, extra)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        else:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            logger=2Einfo(f&quot;Clien=
t event {event} not handled=2E Method {handler_name} does not exist=2E&quot=
;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    def _add_client(self, cid):</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if not cid in se=
lf=2E_connected_clients:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            self=2E_connected_clients[cid] =3D self=2E_connected_clien=
t_class(cid =3D cid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def _remove_cl=
ient(self, cid):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     del self=2E_connected_clients[cid]</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    async def get_client_status(self) -&gt; OmiCommandResult:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        cmd_result =3D self=2Equ=
eue_command(&quot;status 3&quot;)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return await cmd_result</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    async def send_acc_msg(self, client: ConnectedClient, kid, proto=
col: str, msg: bytes):</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        Sends out an ACC to the client=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        &quot;&quot;&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if protocol not in client=
=2Eacc_negotiated_protocols:</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            logger=2Eerror(f&quot;Error: trying to send ACC messag=
e with protocol&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                         f&quot; {protocol} is not in the negotiated list=
 of &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                f&quot;protocols ({client=2Eacc_negotiated_protocols})&quot=
;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        # See init=2Ec for the expla=
nation for the length</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        max_header_size =3D len(&quot;ACC,&quot;) + len(protocol) + 1 + 4=
 + 1 + 2 + 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        # calculate fragme=
nt size with base64 encoding</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        fragment_length =3D client=2E_acc_fragment_length * 6 // 8=
 - max_header_size</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        commands =3D=
 []</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for part=
_start in range(0, len(msg), fragment_length):</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            msg_part =3D msg[part_start:part_start + fragment_lengt=
h]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            b64ms=
g =3D base64=2Eencodebytes(msg_part)=2Edecode()</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            flags =3D &quot;6&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            if part_start + fragment_length &lt; l=
en(msg):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     flags =3D &quot;6:F&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    commands=2Eappend(f&quot;client-acc-msg {client=2Ecid} {kid}\n{protocol=
}\n{flags}\n{b64msg}\nEND&quot;)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  for command in commands:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            await self=2Equeue_command(command)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span>diff --git a/sample/man=
agement/omi_tools=2Epy b/sample/management/omi_tools=2Epy</span><br><span>n=
ew file mode 100644</span><br><span>index 0000000=2E=2E4541f34</span><br><s=
pan>--- /dev/null</span><br><span>+++ b/sample/management/omi_tools=2Epy</s=
pan><br><span>@@ -0,0 +1,105 @@</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#! /usr/bin/python3</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# Copyright (c) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+# Copyright (c) 2026 A=
rne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# Permission is hereby granted, free of charge, to any person obtaining a =
copy</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# of this softw=
are and associated documentation files (the &quot;Software&quot;), to deal<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+# in the Software wi=
thout restriction, including without limitation the rights</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+# to use, copy, modify, merge, publi=
sh, distribute, sublicense, and/or sell</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# copies of the Software, and to permit persons to whom=
 the Software is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# f=
urnished to do so, subject to the following conditions:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+# The above copyright notice and this permission notice s=
hall be included in all</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# copies or substantial portions of the Software=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+# THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WAR=
RANTY OF ANY KIND, EXPRESS OR</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHAN=
TABILITY,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# FITNESS =
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+# AUTHORS OR COPYRIGHT HO=
LDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, =
TORT OR OTHERWISE, ARISING FROM,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHE=
R DEALINGS IN THE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
SOFTWARE=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import a=
syncio</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import os</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+import re</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+from dataclasses import dataclass=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+from omi import OmiProtocol, Connectio=
nProperties</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+@dataclass</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+class ConnectData(ConnectionProperties):</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    socket: str</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+o=
penvpn_escape_re =3D re=2Ecompile(r&#39;([&quot;\\])&#39;)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+filt_ctrl_re =3D re=2Ecompile(r&quot=
;[\x00-\x1f\x7f]+&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+def openvpn_escape(text):</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    &quot;&quot;&quot;Escapes a string to be safely used for Ope=
nVPN inside</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a qu=
oted string</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    Something like &#39;cli=
ent-deny 2 3 &quot;{openvpn_escape(reason)}&quot; &quot;{openvpn_escape(cli=
ent_reason)}&quot;&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    text =3D re=2Esub(filt_ctrl_re, &#39; &#39;, text)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    text =3D re=2Esub(openvpn_esc=
ape_re, r&#39;\\\1&#39;, text)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return text=2Erstrip()</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+d=
ef get_unix_script_environment() -&gt; ConnectData | None:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    password =3D os=2Eenviron=2Eget(=
&quot;MANAGEMENT_PASSWORD&quot;, None)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    socket =3D os=2Eenviron=2Eget(&quot;MANAGEMENT_SOCKE=
T&quot;, None)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if password and sock=
et:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return C=
onnectData(password=3Dpassword, socket=3Dsocket)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    else:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        return None</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+async def start_man=
agement_protocol(connect_data: ConnectData, protocol=3DOmiProtocol):</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    # Get a reference to t=
he event loop as we plan to use</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    # low-level APIs=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    loop =3D asyncio=2Eget_running_loop()</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    finish_future =3D loop=2Ecreate_future()</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    print(f&quot;Connecting to management socket {=
connect_data=2Esocket} with passwd {connect_data=2Epassword[:4]}=2E=2E=2E&q=
uot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    transport,=
 protocol =3D await loop=2Ecreate_unix_connection(lambda: protocol(finish_f=
uture, connect_data),</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                                            connect_data=
=2Esocket)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return transport, protoc=
ol, finish_future</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+async def main():</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    transport, protocol, finish_future =
=3D await start_management_protocol()</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   management_version =3D await protocol=2Emanagement_ready()</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    await protocol=2Eenable_log()=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    print(f&quot;Ma=
nagement interface version: {management_version}&quot;)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    await protocol=2Eset_bytecount_interval(5)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    await finish_future</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+def run_m=
ain(main_func, connect_parameters: ConnectData =3D None):</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    Example function to run a main=
 function to be either using the</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    environment variable for the unix-script or to use=2E If t=
he unix-script</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
nvironment are detected, the function will fork and run the main_func</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    with the ConnectData =
from the environment=2E If the environment variables</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    are not available, it will not fork w=
ill fall back to the connect_parameters</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if present=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    :param connect_parameters:  fallback connect paramete=
rs if unix-script is not available</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    :param main_func:           The function to call=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    :return:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    unix_script_parameters =
=3D get_unix_script_environment()</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if unix_script_parameters:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        asyncio=2Erun(main_func(unix_script_parame=
ters))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    elif conn=
ect_parameters:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    asyncio=2Erun(main_func(connect_parameters))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    else:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        print(f&quot;Must be called via unix-script&quot=
;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+if __name__ =3D=3D &#39;__main__&#39;:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    run_main(main)</span><br></pre><=
p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859=
?usp=3Demail">change 1859</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1859?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatch=
set </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 1859 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> G=
errit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>

</body></html>
--meVadTPEtq4=--


--===============4655998744251711125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4655998744251711125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4655998744251711125==--

