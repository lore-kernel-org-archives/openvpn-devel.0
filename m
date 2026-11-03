Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1C9606A32E
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KcbzVKPo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iTtctHyg;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=S3hvE+Gm;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Por3WOHZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ymt44SGN4N45RANJITc++wlcr28v7/uL0xkSgCU9j/Y=; b=KcbzVKPoiXEhXa7vRruYNRoqT1
	NPYuuRm/5OHH8JgKkA9QEh1KxMfjVt9Jr4pyKEbfa5tigcEkuUbWHgWOdA/4UyItJVFpkuIu0lx4o
	novZ7kNdnzndbcbqYAf84QYGNG6uEA+Bh6B2G9Se92i8j727VnsjbAw4DmPm+1hLH7g8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOG7U-000000005TH-03Md;
	Tue, 03 Nov 2026 15:08:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOG7S-000000005T9-1l7U
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:08:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HSQRbL9/85Tre+XP4Q4XhivOz7seeY5HeOc0uagor7E=; b=iTtctHygRXnHBkwWYeskdSGil4
 CpDNtrgQLnlMX+FSWO6BXXEjLTzRngjb8k2stTBvFoHjEEl9GKWXaKCTi5a/9tn2jPmliq7QiG6/j
 X6wPQb/JAwFwVr7Rnggie5qrwJXa5yz7uGtCYlFrp+g63JBVEA3laRKHvt9fZDzakcqs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HSQRbL9/85Tre+XP4Q4XhivOz7seeY5HeOc0uagor7E=; b=S3hvE+GmTkmWGXrlfkD81pA+yy
 ccSB9wMHwUYgIw/nw8GuMjXqDHuOyEiuu1QZvyMWjJkpWBZWehsmBEI4eXfz+7ZRVB0rDkynItK95
 7T2taotPv/KFMCubhe0zKrdfoY2roXnvXrxrqME/KSniGRVIohspaDHkCVo5JpaNGBmg=;
Received: from mail-ej1-f41.google.com ([209.85.218.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOG7L-000000007Xd-0OEr for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:08:14 +0000
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c43373ae89aso641571866b.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 07:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793718480; x=1794323280; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HSQRbL9/85Tre+XP4Q4XhivOz7seeY5HeOc0uagor7E=;
 b=Por3WOHZ1xuLJjyb4ZJdXIgxPVBdDvuYI/XfxCTgHDXCg6YO1uOC09oE3GGbL57nhq
 MvuKaq4k7BuSdubVtt0x5fTwT3by3uznurlKPlZ4PJfdXDy5H0gHYm1OEKS3emd2du59
 BqI0buBmlQVE4NIY6aBvivZJvnOTyHVg2IUqqO6KqC4q6N4Esxd76qYamGfLLoIpu4JZ
 vHEfEkcfu1iAmiPxjwUMBefIAMO+CkYyKiJWbf8qSyC+162XuXsyQ1F8/mmkTHjZ/eJu
 HRtzGKqtHMpq77bVWua0UMmrybFNIChqwdnHTQLqXfxrrOBJMrk5inS5vkgf1Dfz1L4O
 uovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793718480; x=1794323280;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HSQRbL9/85Tre+XP4Q4XhivOz7seeY5HeOc0uagor7E=;
 b=j76+SUzZGzl3y6J3rLQsC9+D0xzgDvdthc52BnEQMLmsgVjCBKx1Yx4mHv6oMVQl7m
 2MjWOEwQ9b72s1VPCusr6388HjS+XiCKIi3tYtXKh5/zrODTqYNk3KwBK1mCxloc0Jj7
 dySXXVRF1uTW9A6H7xQyzt6VAwCxxVMm8RG7R74w+ql3l1j5hH4wOebqhOW83+WZROnN
 HCxMRZ6WrLU/Aus/F3NKfx9zuabU8tUZERYS0fTMP3eqv/C4M5tdmNOv29qcgMJwFU84
 Gp0bSRAWbNbPDw0qI4WCatgEZ7MclkDdoQhJrRbwOcZeaMBFIt19eWksyo33v8Bztv25
 NbHw==
X-Gm-Message-State: APuU4Z/iZ1SnQsc9/9PYqlFUOnk8zMHdnjnRA8OVFY/EqzutmorYNqC8
 nCD+SJ7ExuyzlxnMea53+PFZrLBK8UxpvTQo2aZdDZ5VpCIiWcT/QD7Q5/b/ayk+w0uWEB9/Af8
 hgH3j/2+dVsRy8KE8taIvY74DXpuaJqnmYD8Aq8B2Tuh4jX/YtXr+lhgfoVQHY2jXLNCVzHGofP
 XRTmGtDQ==
X-Gm-Gg: AYBFou1tcPKSG828xIcwjQ6eV0yxlCof2XWhJVP5MASj3yhFzHrYQNPelVfCYow2R+l
 FPca0KLTQLpFCTngUbqGqWOpnZER/qeRvwPQdVm9zHrGqcM1HfdK6eVVVUPTCkxdg/ptGXdBTgb
 vEPBhYUFoSX31NAkh8tKxuLEsyV88cZAETGNwQHZCQl/rmfu1SoU+C2JTVKfJIoOAope0TujcVi
 rqG4NrzDuqLz82YOW1V8oYwkXp7suqwhzrw4SCFrvWZlrQ7s1jbsqUzt7xpeoQWGv0MJI0V5VIt
 nrRF/ZozEpPlTf6rO35ckjp6lyllJ+Qp4CSTzeMYtDHBu/vFZki1BkaKGjQ2WwiNA1HJ/7Ss9Ji
 n9hQKwEBUKVpx1LZtxriK30g2nSVLbKXUs+7JzDyp+P0rA4sCksBw4ghBPdpqWUnpV9d8Z9t2/1
 UomHN7Hb5URgvgTeCrft5Vmt71ESxxMshEOO6L4NMw3Af6fxaz/1b6fK8wZOG3UWBC2sGCsRYQT
 glQlSi/mjkrgBA8+ln+XZRGDe3D1I/WSB69e6TYaz2bCcw7DbkRh4rYXh45CCh2CCwIBd4Xy3Pj
 WBPNmQapxla0aNJW30hQ6GAkDZUVl+rA175kDVMg70Z1dAq6FIw+cPlnWThzW43M4zDM76Lp4kn
 jqAALw4jd46vpQ35wtxKTio/lt8I7UbSV4oz9iJNz4gNG/u4cHfbpeJ7hORYvp6GaFqU/oPrhvk
 0kWQ4I4Bq9Skk3VA==
X-Received: by 2002:a17:907:1c91:b0:c46:645f:cedc with SMTP id
 a640c23a62f3a-c4ca7b804b8mr1134959266b.46.1793718479632; 
 Tue, 03 Nov 2026 07:07:59 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71bae25dsm23128241f8f.59.2026.11.03.07.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 07:07:58 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 15:07:56 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5
X-Gerrit-Change-Number: 1859
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1859?usp=email>
X-Gerrit-Commit: 3650f2825494782ea0620f52fed63d0c3a44e140
In-Reply-To: <gerrit.1787327336000.Ib09bafabf612e9501ea757647c86a450c73228a5@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ib09bafabf612e9501ea757647c86a450c73228a5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkliMDliYWZhYmY2MTJlOTUwMWVhNzU3NjQ3Yzg2YTQ1MGM3MzIyOGE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7bd80e32a852d43bc8a7f30e2358870821147deb-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOG7L-000000007Xd-0OEr
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
Content-Type: multipart/mixed; boundary="===============2189986143277286537=="
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_HTML_MOSTLY,MISSING_HEADERS,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2189986143277286537==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yAkVRYL9zws="; charset=UTF-8

--yAkVRYL9zws=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Name of user not set #1000061=2E

Arn=
e Schwabe has uploaded a new patch set (#7)=2E ( https://gerrit=2Eopenvpn=
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
5 files changed, 1,054 insertions(+), 0 deletio=
ns(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
59/1859/7

diff --git a/sample/management/omi=2Epy b/sample/management/omi=
=2Epy
new file mode 100644
index 0000000=2E=2Ed266bf2
--- /dev/null
+++ b/s=
ample/management/omi=2Epy
@@ -0,0 +1,289 @@
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
+logger =3D logging=2EgetLogger(__name__)
+logger=2EsetLeve=
l(logging=2EINFO)
+
+
+@dataclass
+class OmiCommandResult:
+    command: st=
r
+    result: List[str]
+    error: bool
+    status_text: str
+
+
+@datac=
lass
+class OmiSendCommand:
+    command: str
+    result: Future[OmiComman=
dResult]
+
+
+@dataclass
+class ConnectionProperties:
+    """
+    Propert=
ies for connecting to the management interface=2E
+    """
+    password: O=
ptional[str]
+
+
+class OmiProtocol(asyncio=2EProtocol):
+    def __init__(=
self, finish_future: Future, connect_data: ConnectionProperties):
+        =
super()=2E__init__()
+        self=2E_connect_data: ConnectionProperties =
=3D connect_data
+
+        self=2Ebytes_received: int =3D 0
+        self=
=2Ebytes_sent: int =3D 0
+        self=2Eversion: int =3D -1
+        self=
=2ErecvBuffer: str =3D ""
+        self=2Efinish_future: Future =3D finish_=
future
+        self=2Etransport: Optional[asyncio=2ETransport] =3D None
+
=
+        # Event to allow waiting for status of the underlying socket
+    =
    # to become available for writing
+        self=2E_can_send: Event =3D =
asyncio=2EEvent()
+        self=2E_can_send=2Eclear()
+
+        # Event to=
 track when the management interface is ready to receive
+        # command=
s from us
+        self=2E_management_ready: Event =3D asyncio=2EEvent()
+ =
       self=2E_management_ready=2Eclear()
+        self=2E_response =3D []
=
+
+        self=2E_response_ready: Event =3D asyncio=2EEvent()
+        sel=
f=2E_response_ready=2Eclear()
+
+        self=2E_send_queue: Queue =3D asyn=
cio=2EQueue()
+        self=2E_send_task: Task =3D asyncio=2Ecreate_task(se=
lf=2E_send_loop())
+
+    @override
+    def eof_received(self) -> None:
+ =
       logger=2Einfo('EOF received=2E Shutting down=2E')
+        self=2E_s=
top()
+
+    @override
+    def connection_lost(self, exc: Exception | None=
) -> None:
+        if exc:
+            logger=2Ewarn(f'Connection lost ({=
exc})=2E Shutting down=2E')
+        else:
+            logger=2Ewarn(f'Con=
nection lost=2E Shutting down=2E')
+        self=2E_stop()
+
+    def _stop=
(self) -> None:
+        if not self=2Efinish_future=2Edone():
+           =
 # If we are disconnected or stop, there is no sense trying
+            # =
to still send commands to the management interface
+            self=2E_sen=
d_task=2Ecancel()
+            self=2Efinish_future=2Eset_result(True)
+
+ =
   async def _send_loop(self) -> None:
+        while True:
+            co=
mmand: OmiSendCommand =3D await self=2E_send_queue=2Eget()
+            awa=
it self=2E_can_send=2Ewait()
+            self=2Esend_line(command=2Ecomman=
d)
+
+            response: List[str] =3D []
+            response_complete=
 =3D False
+
+            # This is a bit brittle as it will loop forever i=
f not getting a
+            # line that starts with ERROR or SUCCESS=2E Wi=
th a normal OpenVPN
+            # daemon that speak the correct protocol t=
his should not be a
+            # problem
+            while not response_=
complete:
+                await self=2E_response_ready=2Ewait()
+
+       =
         line =3D self=2E_response=2Epop(0)
+                response=2Eapp=
end(line)
+
+                if not self=2E_response:
+                    =
self=2E_response_ready=2Eclear()
+
+                lastline =3D response[-=
1]
+                if lastline=2Estartswith('ERROR:'):
+                  =
  status =3D False
+                    response_complete =3D True
+       =
             _, status_text =3D lastline=2Esplit(":", 1)
+
+               =
 elif lastline=2Estartswith('SUCCESS:'):
+                    status =3D Tr=
ue
+                    response_complete =3D True
+                    _, =
status_text =3D lastline=2Esplit(":", 1)
+                elif lastline =3D=
=3D "END":
+                    status =3D True
+                    respon=
se_complete =3D True
+                    status_text =3D None
+           =
     else:
+                    # Other lines do not complete a response
+ =
                   pass
+
+            # logger=2Edebug(f'Result received c=
ommand: {response}')
+            result =3D OmiCommandResult(command=2Ecom=
mand, response[:-1], status, status_text)
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
    # OMI expects us to authenticate with the password just on
+        # i=
ts own on a line
+        if self=2E_connect_data=2Epassword:
+            =
self=2Etransport=2Ewrite(f"{self=2E_connect_data=2Epassword}\r\n"=2Eencode(=
))
+
+    @override
+    def data_received(self, data: bytes) -> None:
+   =
     # OMI protocol is pure text so decode everything as UTF-8
+        mes=
sage =3D data=2Edecode()
+        self=2ErecvBuffer +=3D message
+
+       =
 parts =3D self=2ErecvBuffer=2Esplit("\r\n")
+
+        # pass complete lin=
es to recvLine
+        for part in parts[:-1]:
+            logger=2Edebug=
(f'Line received: {part!r}')
+            self=2Erecv_line(part)
+
+       =
 # keep the last incomplete line for the next call
+        self=2ErecvBuff=
er =3D parts[-1]
+
+    def recv_line(self, line: str) -> None:
+        if=
 line=2Estartswith(">"):
+            # this is an asynchronous message
+  =
          self=2Erecv_notify(line)
+        else:
+            # normal mes=
sage get passed to the _send_loop task
+            self=2E_response=2Eappe=
nd(line)
+            self=2E_response_ready=2Eset()
+
+    def recv_notify=
(self, line: str) -> None:
+        if not ":" in line:
+            logger=
=2Ewarning("Invalid line received: " + line)
+            return
+
+       =
 command, args =3D line[1:]=2Esplit(":", 1)
+
+        # do dynamic dispatc=
h based on command to call a handler
+        if hasattr(self, f"recv_notif=
y_{command}"):
+            handler =3D getattr(self, f"recv_notify_{comman=
d}")
+            handler(args)
+            return
+
+        logger=2Einf=
o("Unknown notify line received: " + line)
+
+    def recv_notify_INFO(self=
, args: str) -> None:
+        m =3D re=2Ematch(r"OpenVPN Management Interf=
ace Version (?P<version>\d+)", args)
+        if m:
+            self=2Ever=
sion =3D int(m=2Egroup("version"))
+            self=2Equeue_command("versi=
on 6")
+            self=2E_management_ready=2Eset()
+        else:
+      =
      logger=2Ewarning(f"Unknown INFO line received: {args}")
+
+    def re=
cv_notify_BYTECOUNT(self, args: str) -> None:
+        bytes_sent, bytes_re=
ceived =3D args=2Esplit(",", 1)
+        self=2Ebytes_sent =3D int(bytes_se=
nt)
+        self=2Ebytes_received =3D int(bytes_received)
+
+    async def=
 _release_hold_task(self, hold_time: int =3D 0) -> None:
+        await asy=
ncio=2Esleep(hold_time)
+        await self=2Equeue_command("hold release")=

+
+    def recv_notify_HOLD(self, args):
+        _text, hold_time =3D arg=
s=2Esplit(":", 1)
+        hold_time =3D int(hold_time)
+
+        asyncio=
=2Ecreate_task(self=2E_release_hold_task(hold_time))
+
+    def queue_comma=
nd(self, command: str) -> Future[OmiCommandResult]:
+        cmd =3D OmiSen=
dCommand(command, Future())
+        self=2E_send_queue=2Eput_nowait(cmd)
+=
        return cmd=2Eresult
+
+    async def management_ready(self) -> int:=

+        """
+        Waits until the management interface is ready=2E Ret=
urns the management interface version=2E
+        """
+        await self=
=2E_management_ready=2Ewait()
+        return self=2Eversion
+
+    def sen=
d_line(self, line: str) -> None:
+        logger=2Edebug(f"Sending line: {l=
ine}")
+        self=2Etransport=2Ewrite(f"{line}\n"=2Eencode())
+
+    """=

+    Set the bytecount interval=2E Use 0 to disable
+    """
+
+    async =
def set_bytecount_interval(self, interval: int):
+        return await self=
=2Equeue_command(f"bytecount {interval}")
+
+    async def enable_log(self)=
:
+        return await self=2Equeue_command("log on")
+
+    def recv_noti=
fy_LOG(self, args):
+        # >LOG:1786453401,D,MANAGEMENT: CMD 'bytecount=
 30'
+        timestamp, level, message =3D args=2Esplit(",", 2)
+
+       =
 timestamp =3D datetime=2Efromtimestamp(int(timestamp))
+        level =3D =
level=2Estrip()
+        message =3D message=2Estrip()
+        self=2Elog_=
message(timestamp, level, message)
+
+    def log_message(self, time, level=
, message):
+        """
+        A new log message has been received=2E Th=
is method is intended
+        to be overridden by a subclass to handle the=
 log messages=2E
+        :param time:    time in local time format
+      =
  :param level:   level of the log message
+        :param message: the log=
 message itself
+        :return:
+        """
+        logger=2Edebug(f"Re=
ceived log message: {time}, {level}, {message}")
diff --git a/sample/manage=
ment/omi_client_protocol=2Epy b/sample/management/omi_client_protocol=2Epy
=
new file mode 100644
index 0000000=2E=2E6899083
--- /dev/null
+++ b/sample/=
management/omi_client_protocol=2Epy
@@ -0,0 +1,136 @@
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
+imp=
ort asyncio
+import base64
+import logging
+from typing import Tuple
+
+fro=
m omi import OmiProtocol, OmiCommandResult
+
+logger =3D logging=2EgetLogge=
r(__name__)
+logger=2EsetLevel(logging=2EDEBUG)
+
+
+class OMIClientProtoco=
l(OmiProtocol):
+    """
+    Implement the management protocol for the cli=
ent  
+    """
+
+    def __init__(self, finish_future, connect_data):
+   =
     super()=2E__init__(finish_future=3Dfinish_future, connect_data=3Dconne=
ct_data)
+        self=2E_partial_acc_msg =3D ""
+        self=2E_protocol_=
acc_msg =3D ""
+        self=2E_acc_fragment_length =3D 980
+        self=
=2E_acc_negotiated_protocols =3D []
+
+    async def send_acc_msg(self, pro=
tocol: str, msg: bytes):
+        """
+        Sends out an ACC to the serv=
er using the specified ACC message length
+        :param protocol:
+      =
  :param msg:
+        :param fragment_length:
+        :return:
+        "=
""
+        if protocol not in self=2E_acc_negotiated_protocols:
+         =
   logger=2Eerror(f"Error: trying to send ACC message with protocol "
+    =
                     f"{protocol} is not in the negotiated list of "
+     =
                    f"protocols ({self=2E_acc_negotiated_protocols})")
+   =
         return
+
+        # See init=2Ec for the explanation for the lengt=
h calculation
+        max_header_size =3D len("ACC,") + len(protocol) + 1 =
+ 4 + 1 + 2 + 1
+
+        # calculate fragment size with base64 encoding
+=
        fragment_length =3D self=2E_acc_fragment_length * 6 // 8 - max_head=
er_size
+
+        commands =3D []
+        for part_start in range(0, len(=
msg), fragment_length):
+
+            msg_part =3D msg[part_start:part_sta=
rt + fragment_length]
+            b64msg =3D base64=2Eencodebytes(msg_part=
)=2Edecode()
+
+            flags =3D "6"
+            if part_start + frag=
ment_length < len(msg):
+                flags +=3D "F"
+
+            comm=
ands=2Eappend(f"acc-msg\n{protocol}\n{flags}\n{b64msg}\nEND")
+
+        cm=
d_futures =3D []
+        for command in commands:
+            cmd_futures=
=2Eappend(self=2Equeue_command(command))
+
+        cmd_results: Tuple[OmiC=
ommandResult] =3D await asyncio=2Egather(*cmd_futures)
+
+        for cmd_r=
esult in cmd_results:
+            if cmd_result=2Eerror:
+                =
logger=2Eerror(f"Error: sending ACC message failed: {cmd_result}")
+
+    d=
ef recv_notify_ACC_PROTOCOLS(self, args):
+        params =3D args=2Esplit(=
",")
+        acc_params =3D {}
+
+        for p in params:
+            k,=
 v =3D p=2Esplit("=3D", 1)
+            acc_params[k=2Estrip()] =3D v=2Estr=
ip()
+
+        self=2E_acc_negotiated_protocols =3D acc_params['protocols'=
]=2Esplit(":")
+
+        self=2E_acc_fragment_length =3D int(acc_params['m=
essage_len'])
+
+    def recv_notify_ACC(self, args):
+        protocol, fr=
agment, b64msg =3D args=2Esplit(",", 2)
+
+        if self=2E_partial_acc_m=
sg and self=2E_protocol_acc_msg !=3D protocol:
+            logger=2Eerror(=
f"Recieved ACC message with protocol {protocol} before "
+                 =
        f"previous ACC message with protocol {self=2E_protocol_acc_msg} was=
 complete")
+            self=2E_partial_acc_msg =3D ""
+
+        try:
+  =
          msg =3D base64=2Edecodebytes(b64msg=2Eencode())
+            self=
=2E_partial_acc_msg +=3D msg=2Edecode()
+            self=2E_protocol_acc_m=
sg =3D protocol
+        except Exception as e:
+            logger=2Eerror=
(f"Error parsing ACC message: {e}", exc_info=3DTrue)
+            self=2E_p=
artial_acc_msg =3D ""
+            return
+
+        fragmented =3D fragmen=
t !=3D "0"
+        logger=2Edebug(
+            f"Received ACC message (fr=
agment {fragmented}, protocol {protocol!r}), with payload {msg=2Edecode()!r=
}")
+
+        # Message is not yet complete=2E Wait for more fragments=2E
=
+        if fragmented:
+            return
+
+        if hasattr(self, f"r=
eceive_acc_{protocol}"):
+            handler =3D getattr(self, f"receive_a=
cc_{protocol}")
+            logger=2Edebug(f"Calling handler {handler}")
+=
            try:
+                handler(self=2E_partial_acc_msg)
+       =
     except Exception as e:
+                logger=2Eerror(f"Error parsing=
 ACC message: {e}", exc_info=3DTrue)
+                self=2E_partial_acc_m=
sg =3D ""
+        else:
+            logger=2Einfo(f"Received unhandled AC=
C protocol: {protocol}")
+
+        self=2E_partial_acc_msg =3D ""
+       =
 self=2E_protocol_acc_msg =3D ""
diff --git a/sample/management/omi_server_=
demo=2Epy b/sample/management/omi_server_demo=2Epy
new file mode 100755
ind=
ex 0000000=2E=2E6448817
--- /dev/null
+++ b/sample/management/omi_server_de=
mo=2Epy
@@ -0,0 +1,299 @@
+#! /usr/bin/env python3
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
+
+import asyncio
+import loggi=
ng
+from asyncio import Future
+from base64 import standard_b64decode
+from=
 dataclasses import field
+from typing import Dict, Optional
+
+from omi_se=
rver_protocol import OMIServerProtocol, ConnectedClient
+from omi_tools imp=
ort run_main, start_management_protocol, ConnectData
+from omi_tools import=
 openvpn_escape
+
+# This implement a small demonstration of using the
+# O=
penVPN Access Server Management Interface (OMI)
+# and a script that does v=
arious action on the client depending
+# on the username the user connects =
with
+# ensure that you have a proper certificate based authentication setu=
p
+# before using this script
+# (e=2Eg=2E https://github=2Ecom/openvpn/ope=
nvpn/blob/master/doc/man-sections/example-fingerprint=2Erst)
+
+# usage:
+#=
 --management /path/to/omi_server_demo=2Epy unix-script
+
+# The main purpo=
se of this script is to test/force certain client/server
+# behaviour=2E As=
 a test script this is done on the username but also serves
+# as an exampl=
e how to implement something similar for normal usage=2E
+#
+# if a usernam=
e is prefixed with url it uses the old OPEN_URL method (e=2Eg=2E urlrick)
+=
#
+# - fail: sends AUTH_FAILED
+# - failn: sends AUTH_FAILED wiht \n
+# - f=
ailtemp: sends AUTH_FAILED,TEMP:Go away for a while
+# - failtemp42: sends =
AUTH_FAILED,TEMP and backoff for 42s
+#     - failtempnr: sends AUTH_FAILED=
,TEMP and instructs to go the next remote
+# - success: sends AUTH_SUCCESS
=
+# - faildelay: sends AUTH_FAILED after 20s
+# - successdelay: sends AUTH_S=
UCCESS after 20s
+# - rick: sends you to a certain youtube site and auth yo=
u
+# - openvpn: sends you to community=2Eopenvpn=2Enet
+# - totp: Does crte=
xt based 2FA with secret "totpinsecuretotp"
+# - google: sends you to https=
://www=2Egoogle=2Ecom/search?q=3Dhidden without any flags
+# - googlext: se=
nds you to https://www=2Egoogle=2Ecom/search?q=3Dexternal with external fla=
gs and WEBAUTH \
+#         - dnssec: send only dnssec servers
+# - nodns: =
no dns servers
+# - dnssecfb: dns server with fallback to dns without dnnse=
c
+# - dnsdhcp: dns options and dhcp_options
+# - dnsport: dns server with =
custom port
+# - failaccdpc1: auth failed message indicating that the clien=
t is missing dpc1 ACC support=2E
+# - failaccdpc1user: auth failed message =
indicating that the client is missing dpc1 ACC support indicating a auth-to=
ken and user for reconnecting
+#     - failaccflower: auth failed message i=
ndicating that the client is missing flower and power ACC support=2E
+# - d=
efault: push DNS 8=2E8=2E8=2E8 and default route
+# - notify: Gives the cli=
ent a message to display to the user via notify protocol
+
+# The hard-code=
d secret
+totp_secret =3D "totpinsecuretotp"
+
+logging=2EbasicConfig()
+lo=
gger =3D logging=2EgetLogger(__name__)
+logger=2EsetLevel(logging=2EINFO)
+=

+try:
+    import pyotp
+except ImportError:
+    logger=2Einfo("pyotp mod=
ule not found=2E TOTP testing disabled")
+
+
+class ServerDemoConnectedClie=
nt(ConnectedClient):
+    # Remember the key-id that we authenticated
+    =
authenticated_kid: int =3D -1
+    env:Dict[str, str] =3D field(default_fac=
tory=3Ddict)
+
+
+
+class ServerDemoProtocol(OMIServerProtocol):
+    def _=
_init__(self, finish_future: Future, connect_data: ConnectData =3D None):
+=
        super()=2E__init__(finish_future, connect_data)
+        self=2E_co=
nnected_client_class =3D ServerDemoConnectedClient
+
+    def client_event_=
ESTABLISHED(self, client: ServerDemoConnectedClient, kid: int, env: Dict, e=
xtra: str):
+        print(f"CLient connected: {client}")
+
+    def client=
_event_CONNECT(self, client: ServerDemoConnectedClient, kid: int, env: Dict=
, extra: str) -> None:
+        print(f"Authenticating client {client=2Ecid=
}, {kid}")
+        client=2Eauthenticated_kid =3D kid
+        client=2Een=
v =3D env
+
+        asyncio=2Ecreate_task(self=2Edo_client_auth(client, ki=
d))
+
+    async def deny_client(self, client: ServerDemoConnectedClient, k=
id: int, reason: str,
+                          client_reason: Optional[st=
r] =3D None) -> None:
+        # Note, for this test script sending your re=
al reason if you do not
+        # specify a client reason is okay=2E In a =
real environment, this kind
+        # of information is potentially bad
+
=
+        if not client_reason:
+            client_reason =3D reason
+     =
   client_deny =3D f'client-deny {client=2Ecid} {kid} "{openvpn_escape(reas=
on)}" "{openvpn_escape(client_reason)}"'
+        await self=2Equeue_comman=
d(client_deny)
+
+    async def do_client_auth(self, client: ServerDemoConn=
ectedClient, kid: int) -> None:
+        username =3D client=2Eenv=2Eget("u=
sername")
+
+        # success
+        if username=2Estartswith("url"):
+ =
           username =3D username[3:]
+            method =3D "openurl"
+   =
         webauth =3D "OPEN_URL:"
+        else:
+            method =3D "we=
bauth"
+            webauth =3D "WEB_AUTH::"
+
+        if username =3D=3D =
'fail' or 'UV_FAIL' in client=2Eenv:
+            await self=2Edeny_client(=
client, kid, "fail")
+        elif username =3D=3D 'failtemp':
+           =
 await self=2Edeny_client(client, kid, "TEMP:Go away for a while")
+       =
 elif username =3D=3D 'failn':
+            await self=2Edeny_client(client=
, kid, "Bonus new line for you!\n")
+        elif username =3D=3D 'failn2':=

+            await self=2Edeny_client(client, kid, "Bonus new line for you=
!\nand another one\n")
+        elif username =3D=3D 'failtemp42':
+       =
     await self=2Edeny_client(client, kid, "TEMP[backoff 42]:Go away for a =
42s")
+        elif username =3D=3D 'failtempnr':
+            await self=
=2Edeny_client(client, kid, "TEMP[backoff 11,advance remote]:Annoy the next=
 server!")
+        elif username =3D=3D 'failaccdpc1':
+            await =
self=2Edeny_client(client, kid,
+                                   "ACC[pr=
otocol dpc1]: To connect to this server you need to upgrade to a client tha=
t supports the OpenVPN Inc device posture protocol, e=2Eg=2E OpenVPN Connec=
t version 1=2E2=2E3 or later")
+        elif username =3D=3D 'failaccflower=
':
+            await self=2Edeny_client(client, kid, "ACC[protocol flower =
power]: You need to embrace the flower power")
+        elif username =3D=
=3D 'failaccdpc1user':
+            await self=2Edeny_client(client, kid,
+=
                                   "ACC[protocol flower power, user c3VjY2V=
zcw=3D=3D, pass MTIzNDU2Nzg=3D]: Please come back again  after you enabled =
dpc1")
+        elif username =3D=3D 'success':
+            await self=2Es=
end_client_auth(client, kid)
+        elif username =3D=3D 'faildelay':
+  =
          await asyncio=2Esleep(20)
+            await self=2Edeny_client(c=
lient, kid, "I thought 20s about it and rejected you after that time")
+   =
     elif username =3D=3D 'successdelay':
+            await asyncio=2Eslee=
p(20)
+            await self=2Esend_client_auth(client, kid)
+        elif=
 username=2Estartswith('totp'):
+            timeout =3D 90
+            ex=
tra =3D f"CR_TEXT:E,R:Please enter your TOTP code, {username}!"
+          =
  logger=2Einfo(f"The TOTP the client needs to provide is: {self=2Eget_curr=
ent_totp_code()}")
+            await self=2Esend_pending_auth(client, kid,=
 extra, timeout)
+        elif username =3D=3D 'rick':
+            await a=
syncio=2Esleep(3)
+            await self=2Esend_pending_auth(client, kid, =
webauth + "https://www=2Eyoutube=2Ecom/watch?v=3DdQw4w9WgXcQ")
+           =
 await asyncio=2Esleep(10)
+            await self=2Edeny_client(client, ki=
d, "I got you")
+        elif username =3D=3D 'openvpn':
+            await=
 self=2Esend_pending_auth(client, kid, webauth + "https://community=2Eopenv=
pn=2Enet")
+            await self=2Esend_client_auth(client, kid)
+       =
 elif username =3D=3D 'googleext':
+            await self=2Esend_pending_a=
uth(client, kid, "WEB_AUTH:external:https://www=2Egoogle=2Ecom/search?q=3De=
xternal")
+            await asyncio=2Esleep(10)
+            await self=2E=
send_client_auth(client, kid)
+        elif username =3D=3D 'google':
+    =
        await self=2Esend_pending_auth(client, kid, "WEB_AUTH::https://www=
=2Egoogle=2Ecom/search?q=3Dexternal")
+            await asyncio=2Esleep(10=
)
+            await self=2Esend_client_auth(client, kid)
+        elif use=
rname =3D=3D 'special':
+            extra =3D f"CR_TEXT:E:This special use=
rname is known, doing nothing, really"
+            await self=2Esend_pendi=
ng_auth(client, kid, extra)
+        elif username in ['success', 'dnssec',=
 'nodns', 'dnssecfb', 'default']:
+            await asyncio=2Esleep(1)
+  =
          await self=2Esend_client_auth(client, kid)
+        elif username=
 =3D=3D "notify":
+            await self=2Esend_pending_auth(client, kid,
=
+                                         "NOTIFY:Please wait for 23s to le=
t the server think if it want to admit you")
+            await asyncio=2Es=
leep(23)
+            await self=2Esend_client_auth(client, kid)
+        e=
lse:
+            await self=2Edeny_client(client, kid,
+                  =
                 f"The username you used ({username}) is unknown, please pi=
ck one that I know")
+
+    async def send_client_auth(self, client: Server=
DemoConnectedClient, kid: int) -> None:
+        username =3D client=2Eenv=
=2Eget("username")
+
+        config =3D ""
+        if username =3D=3D 'dn=
ssec':
+            config +=3D """
+            push "dns server 7 address=
 8=2E8=2E8=2E8:53"
+            push "dns server 7 dnssec yes"
+           =
 """
+        elif username =3D=3D 'nodns':
+            pass
+        elif=
 username =3D=3D 'dnssecfb':
+            config +=3D """
+            push=
 "dns server 7 address 8=2E8=2E8=2E8:53"
+            push "dns server 7 dn=
ssec yes"
+            push "dns server 10 address 8=2E8=2E8=2E8"
+        =
    push "dns server 10 transport DoT"
+            push "dns server 12 add=
ress 8=2E8=2E8=2E8"
+            push "dns server 12 transport DoH"
+      =
      push "dns server 19 address 8=2E8=2E8=2E8:53"
+            """
+     =
   elif username =3D=3D 'dnsdhcp':
+            config +=3D """
+          =
  push "dns server 19 address 8=2E8=2E8=2E8:53"
+            push "dhcp-opt=
ions dns server 1=2E1=2E1=2E1"
+            """
+        elif username =3D=
=3D 'dnsport':
+            config +=3D """
+            push "dns server 2=
0 address 8=2E8=2E8=2E8:5353"
+            """
+        elif username =3D=
=3D 'default':
+            config +=3D """
+            push "dns server 1=
9 address 8=2E8=2E8=2E8:53"
+            push "dhcp-options dns server 1=2E=
1=2E1=2E1"
+            push "redirect-gateway def1"
+            """
+
+  =
      if not config:
+            await self=2Equeue_command(f"client-auth-=
nt {client=2Ecid} {kid}")
+        else:
+            await self=2Equeue_co=
mmand(f"client-auth {client=2Ecid} {kid}\n{config}\nEND\n")
+
+    async de=
f send_pending_auth(self, client: ServerDemoConnectedClient, kid: int, extr=
a: str,
+                                timeout: int =3D 180) -> None:
+  =
      auth_pending_totp_cmd =3D f'client-pending-auth {client=2Ecid} {kid} =
"{extra}" {timeout}'
+        await self=2Equeue_command(auth_pending_totp_=
cmd)
+
+    def client_event_CR_RESPONSE(self, client: ServerDemoConnectedC=
lient, kid: int, env: Dict, extra: str) -> None:
+        client=2Eenv =3D =
env
+        asyncio=2Ecreate_task(self=2Eclient_crresponse(client, kid, ex=
tra))
+
+    @staticmethod
+    def get_current_totp_code() -> str:
+      =
  try:
+            import pyotp
+        except ImportError:
+            =
return "pyotp not found"
+
+        totp =3D pyotp=2ETOTP(totp_secret)
+   =
     return totp=2Enow()
+
+    async def client_crresponse(self, client: S=
erverDemoConnectedClient, kid: int, response: str) -> None:
+        # Try =
importing the pyotp here to allow the script run without pyotp
+        # i=
nstalled
+        try:
+            import pyotp
+        except ImportErro=
r:
+            await self=2Edeny_client(client, kid, "pytop module not fou=
nd=2E Cannot do MFA testing")
+            return
+
+        try:
+        =
    response =3D standard_b64decode(response)
+            response =3D res=
ponse=2Edecode()=2Estrip()
+        except Exception as e:
+            awa=
it self=2Edeny_client(client, kid, f"Decoding totp response failed: {e}")
+=
            return
+
+        totp =3D pyotp=2ETOTP(totp_secret)
+
+       =
 logger=2Einfo(f"\nCR: expected totp '{totp=2Enow()}', response was '{respo=
nse}'\n")
+        # Check if the code is valid (and also allow code +/-1)
=
+
+        if totp=2Everify(response, valid_window=3D1):
+            await=
 self=2Esend_client_auth(client, kid)
+        else:
+            await sel=
f=2Edeny_client(client, kid, "TOTP verification failed")
+
+
+async def mai=
n(connect_data: ConnectData):
+    transport, protocol, finish_future =3D a=
wait start_management_protocol(connect_data, ServerDemoProtocol)
+
+    man=
agement_version =3D await protocol=2Emanagement_ready()
+    logger=2Einfo(=
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
diff --git a/sample/management/omi_server_protocol=2Epy b/sample/management=
/omi_server_protocol=2Epy
new file mode 100644
index 0000000=2E=2E5655ac3
-=
-- /dev/null
+++ b/sample/management/omi_server_protocol=2Epy
@@ -0,0 +1,24=
1 @@
+#!/usr/bin/env python3
+# Copyright (c) 2026 OpenVPN Inc <sales@openv=
pn=2Enet>
+# Copyright (c) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+#
+# Per=
mission is hereby granted, free of charge, to any person obtaining a copy
+=
# of this software and associated documentation files (the "Software"), to =
deal
+# in the Software without restriction, including without limitation t=
he rights
+# to use, copy, modify, merge, publish, distribute, sublicense, =
and/or sell
+# copies of the Software, and to permit persons to whom the So=
ftware is
+# furnished to do so, subject to the following conditions:
+#
+#=
 The above copyright notice and this permission notice shall be included in=
 all
+# copies or substantial portions of the Software=2E
+#
+# THE SOFTWAR=
E IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED,=
 INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS=
 FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE
+# A=
UTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LI=
ABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,=

+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN THE
+# SOFTWARE=2E
+
+import asyncio
+import base64
+import logging
+fro=
m asyncio import Future
+from dataclasses import dataclass, field
+from typ=
ing import List, Tuple, Dict, Optional
+
+from omi import OmiProtocol, Conn=
ectionProperties, OmiCommandResult
+
+logger =3D logging=2EgetLogger(__name=
__)
+logger=2EsetLevel(logging=2EINFO)
+
+
+@dataclass
+class ConnectedClie=
nt:
+    """This represents a connected client instance=2E"""
+    cid: int=

+    bytes_sent: int =3D 0
+    bytes_received: int =3D 0
+    _partial_ac=
c_msg: str =3D ""
+    _protocol_acc_msg: str =3D ""
+    _kid_acc_msg: int=
 =3D -1
+    _acc_fragment_length: int =3D 980
+    acc_negotiated_protocol=
s: List[str] =3D field(default_factory=3Dlist)
+
+
+class OMIServerProtocol=
(OmiProtocol):
+    """
+    This class implement common method for the OMI=
 when OpenVPN is running
+    as a server=2E These are mainly helper functi=
on and functionality that
+    is only available/useful for OpenVPN running=
 as a server
+    """
+
+    # Connected client class, can be overridden by=
 subclasses to store
+    # more information about the connected client
+  =
  _connected_client_class =3D ConnectedClient
+
+    def __init__(self, fin=
ish_future: Future, connect_data: ConnectionProperties):
+        super()=
=2E__init__(finish_future, connect_data)
+        self=2E_reset_pending_cli=
ent_event()
+        self=2E_connected_clients:Dict =3D {}
+
+    def _rese=
t_pending_client_event(self) -> None:
+        self=2E_pending_client_event=
:str =3D ""
+        self=2E_pending_client_event_cid:int =3D -1
+        s=
elf=2E_pending_client_event_kid:int =3D -1
+        self=2E_pending_client_=
event_extra_args:str =3D None
+        self=2E_client_env:Dict =3D {}
+
+  =
  def recv_notify_CLIENT(self, args: str) -> None:
+        event, args =3D=
 args=2Esplit(",", 1)
+
+        if event =3D=3D "ENV":
+            if arg=
s =3D=3D "END":
+                # Client environment is finished, trigger =
previous client
+                # event that contained an ENV
+           =
     self=2E_trigger_client_event(self=2E_pending_client_event, self=2E_pen=
ding_client_event_cid,
+                                           self=2E_=
pending_client_event_kid, self=2E_client_env,
+                            =
               self=2E_pending_client_event_extra_args)
+                se=
lf=2E_reset_pending_client_event()
+            else:
+                key,=
 value =3D args=2Esplit("=3D", 1)
+                self=2E_client_env[key] =
=3D value
+
+        elif event in ("ESTABLISHED", "DISCONNECT"):
+        =
    # This event is followed by a client environment=2E Wait for
+         =
   # the client environment to be completed before triggering the event
+  =
          cid =3D int(args)
+
+            self=2E_pending_client_event =3D=
 event
+            self=2E_pending_client_event_cid =3D int(cid)
+        =
    self=2E_pending_client_event_kid =3D None
+            if event =3D=3D =
"ESTABLISHED":
+                self=2E_add_client(cid)
+
+        elif eve=
nt in ("CONNECT", "REAUTH"):
+            # This event is similar to other =
event but also carries the key-id
+            cid, kid =3D args=2Esplit(",=
", 1)
+            cid, kid =3D int(cid), int(kid)
+            self=2E_add=
_client(cid)
+
+            self=2E_pending_client_event =3D event
+       =
     self=2E_pending_client_event_cid =3D int(cid)
+            self=2E_pen=
ding_client_event_kid =3D int(kid)
+        elif event =3D=3D "CR_RESPONSE"=
:
+            # This event is similar to CONNECT and REAUTH but has an ext=
ra
+            # parameter with the crtext response
+            cid, kid,=
 response =3D args=2Esplit(",", 2)
+            cid, kid =3D int(cid), int(=
kid)
+
+            self=2E_pending_client_event =3D event
+            sel=
f=2E_pending_client_event_cid =3D int(cid)
+            self=2E_pending_cli=
ent_event_kid =3D int(kid)
+            self=2E_pending_client_event_extra_=
args =3D response
+        elif event =3D=3D "ACC":
+            cid, kid, =
acc_args =3D args=2Esplit(",", 2)
+            self=2E_trigger_client_event=
(event, int(cid), int(kid), None, acc_args)
+        elif event =3D=3D "ADD=
RESS":
+            # >CLIENT:ADDRESS,{CID},{ADDR},{PRI}
+            cid, =
addr, extra =3D args=2Esplit(",", 2)
+            self=2E_trigger_client_ev=
ent(event, int(cid), -1, None, extra)
+        else:
+            logger=2E=
info(f"Client event {event} not handled=2E (message: {args!r})")
+
+    def=
 client_event_ACC(self, client: ConnectedClient, kid: int, env: Dict, extra=
: str) -> None:
+        protocol, fragment, b64msg =3D extra=2Esplit(",", =
2)
+
+        if client=2E_partial_acc_msg and client=2E_protocol_acc_msg !=
=3D protocol:
+            logger=2Eerror(f"Recieved ACC message with proto=
col {protocol} before "
+                         f"previous ACC message wi=
th protocol {client=2E_protocol_acc_msg} was complete")
+            client=
=2E_partial_acc_msg =3D ""
+
+        if client=2E_partial_acc_msg and clie=
nt=2E_kid_acc_msg !=3D kid:
+            logger=2Eerror(f"Recieved ACC mess=
age with different key id {kid} before "
+                         f"previo=
us ACC message with key id {client=2E_kid_acc_msg} "
+                     =
    f"was complete=2E This is currently not handled")
+            client=
=2E_partial_acc_msg =3D ""
+
+        try:
+            msg =3D base64=2Ede=
codebytes(b64msg=2Eencode())
+            client=2E_partial_acc_msg +=3D ms=
g=2Edecode()
+            client=2E_protocol_acc_msg =3D protocol
+        =
    client=2E_kid_acc_msg =3D kid
+
+            # Message is not yet compl=
ete=2E Wait for more fragments=2E
+            if fragment !=3D "0":
+     =
           return
+
+            handler_name =3D f"receive_acc_client_{pro=
tocol}"
+            if hasattr(self, handler_name):
+                handl=
er =3D getattr(self, handler_name)
+                logger=2Edebug(f"Callin=
g handler {handler}")
+                try:
+                    handler(cl=
ient, kid, client=2E_partial_acc_msg)
+                except Exception as =
e:
+                    logger=2Eerror(f"Error parsing ACC message: {e}", e=
xc_info=3DTrue)
+            else:
+                logger=2Einfo(f"Receive=
d unhandled ACC protocol: {protocol}, handler {handler_name} not found")
+
=
+            client=2E_partial_acc_msg =3D ""
+            client=2E_protoc=
ol_acc_msg =3D protocol
+
+        except Exception as e:
+            logg=
er=2Eerror(f"Error parsing ACC message from client: {e}", exc_info=3DTrue)
=
+            client=2E_partial_acc_msg =3D ""
+            return
+
+      =
  client=2E_partial_acc_msg =3D ""
+
+    def recv_notify_BYTECOUNT_CLI(sel=
f, args: str) -> None:
+        cid, bytes_sent, bytes_received =3D args=2E=
split(",", 2)
+
+        client =3D self=2E_connected_clients=2Eget(int(cid=
))
+        if client:
+            client=2Ebytes_sent =3D int(bytes_sent)=

+            client=2Ebytes_received =3D int(bytes_received)
+
+    def _t=
rigger_client_event(self, event: str, cid: int, kid: int, env: Optional[Dic=
t], extra):
+        client =3D self=2E_connected_clients=2Eget(cid, None)
=
+
+        # Remember ACC protocol options if present
+        if event =3D=
=3D "CONNECT" and "acc_protocols" in env:
+            client=2Eacc_negotia=
ted_protocols =3D [p=2Estrip() for p in env["acc_protocols"]=2Esplit(":")]
=
+            client=2E_acc_fragment_length =3D int(env['acc_message_len'])
=
+
+        handler_name =3D f"client_event_{event}"
+        if hasattr(sel=
f, handler_name):
+            handler =3D getattr(self, handler_name)
+   =
         handler(client, kid, env, extra)
+        else:
+            logge=
r=2Einfo(f"Client event {event} not handled=2E Method {handler_name} does n=
ot exist=2E")
+
+    def _add_client(self, cid: int) -> None:
+        if n=
ot cid in self=2E_connected_clients:
+            self=2E_connected_clients=
[cid] =3D self=2E_connected_client_class(cid=3Dcid)
+
+    def _remove_clie=
nt(self, cid: int) -> None:
+        del self=2E_connected_clients[cid]
+
+=
    async def get_client_status(self) -> OmiCommandResult:
+        cmd_res=
ult =3D self=2Equeue_command("status 3")
+        return await cmd_result
+=

+    async def send_acc_msg(self, client: ConnectedClient, kid: int, proto=
col: str, msg: bytes) -> None:
+        """
+        Sends out an ACC to th=
e client=2E
+        """
+        if protocol not in client=2Eacc_negotiate=
d_protocols:
+            logger=2Eerror(f"Error: trying to send ACC messag=
e with protocol"
+                         f" {protocol} is not in the nego=
tiated list of "
+                         f"protocols ({client=2Eacc_negot=
iated_protocols})")
+            return
+
+        # See init=2Ec for the e=
xplanation for the length
+        max_header_size =3D len("ACC,") + len(pr=
otocol) + 1 + 4 + 1 + 2 + 1
+
+        # calculate fragment size with base6=
4 encoding
+        fragment_length =3D client=2E_acc_fragment_length * 6 /=
/ 8 - max_header_size
+
+        commands =3D []
+        for part_start in=
 range(0, len(msg), fragment_length):
+
+            msg_part =3D msg[part_=
start:part_start + fragment_length]
+            b64msg =3D base64=2Eencode=
bytes(msg_part)=2Edecode()
+
+            flags =3D "6"
+            if par=
t_start + fragment_length < len(msg):
+                flags +=3D "F"
+
+  =
          commands=2Eappend(f"client-acc-msg {client=2Ecid} {kid}\n{protoco=
l}\n{flags}\n{b64msg}\nEND")
+
+        cmd_futures =3D []
+        for com=
mand in commands:
+            cmd_futures=2Eappend(self=2Equeue_command(co=
mmand))
+
+        cmd_results: Tuple[OmiCommandResult] =3D await asyncio=
=2Egather(*cmd_futures)
+        for cmd_result in cmd_results:
+          =
  if cmd_result=2Eerror:
+                logger=2Eerror(f"Error: sending A=
CC message failed: {cmd_result}")
diff --git a/sample/management/omi_tools=
=2Epy b/sample/management/omi_tools=2Epy
new file mode 100644
index 0000000=
=2E=2E6053749
--- /dev/null
+++ b/sample/management/omi_tools=2Epy
@@ -0,0 =
+1,89 @@
+#! /usr/bin/python3
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
+import asyncio
+import os
+import re
+from dataclas=
ses import dataclass
+
+from omi import OmiProtocol, ConnectionProperties
+=

+
+@dataclass
+class ConnectData(ConnectionProperties):
+    socket: str
+=

+
+openvpn_escape_re =3D re=2Ecompile(r'(["\\])')
+filt_ctrl_re =3D re=2Ec=
ompile(r"[\x00-\x1f\x7f]+")
+def openvpn_escape(text):
+    """Escapes a st=
ring to be safely used for OpenVPN inside
+    a quoted string
+
+    Somet=
hing like 'client-deny 2 3 "{openvpn_escape(reason)}" "{openvpn_escape(clie=
nt_reason)}"'
+    """
+    text =3D re=2Esub(filt_ctrl_re, ' ', text)
+   =
 text =3D re=2Esub(openvpn_escape_re, r'\\\1', text)
+    return text=2Erst=
rip()
+
+def get_unix_script_environment() -> ConnectData | None:
+    pass=
word =3D os=2Eenviron=2Eget("MANAGEMENT_PASSWORD", None)
+    socket =3D os=
=2Eenviron=2Eget("MANAGEMENT_SOCKET", None)
+
+    if password and socket:
=
+        return ConnectData(password=3Dpassword, socket=3Dsocket)
+    else=
:
+        return None
+
+
+async def start_management_protocol(connect_dat=
a: ConnectData, protocol=3DOmiProtocol):
+    # Get a reference to the even=
t loop as we plan to use
+    # low-level APIs=2E
+    loop =3D asyncio=2Eg=
et_running_loop()
+
+    finish_future =3D loop=2Ecreate_future()
+
+    pr=
int(f"Connecting to management socket {connect_data=2Esocket} with passwd {=
connect_data=2Epassword[:4]}=2E=2E=2E")
+    transport, protocol =3D await =
loop=2Ecreate_unix_connection(lambda: protocol(finish_future, connect_data)=
,
+                                                            connect_data=
=2Esocket)
+
+    return transport, protocol, finish_future
+
+
+def run_ma=
in(main_func, connect_parameters: ConnectData =3D None):
+    """
+    Exam=
ple function to run a main function to be either using the
+    environment=
 variable for the unix-script or to use=2E If the unix-script
+    environm=
ent are detected, the function will run the main_func
+    with the Connect=
Data from the environment=2E If the environment variables
+    are not avai=
lable, it will fall back to the connect_parameters
+    if present=2E
+    =
:param connect_parameters:  fallback connect parameters if unix-script is n=
ot available
+    :param main_func:           The function to call=2E
+    =
:return:
+    """
+    unix_script_parameters =3D get_unix_script_environme=
nt()
+    if unix_script_parameters:
+        asyncio=2Erun(main_func(unix_=
script_parameters))
+    elif connect_parameters:
+        asyncio=2Erun(ma=
in_func(connect_parameters))
+    else:
+        print(f"Must be called via=
 unix-script")

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1859?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: n=
ewpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
Ib09bafabf612e9501ea757647c86a450c73228a5
Gerrit-Change-Number: 1859
Gerrit=
-PatchSet: 7
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-CC: Name of user not set #1000061
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: Name of user not set #1000061

--yAkVRYL9zws=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Name of user not set #1000061=2E </p>
<p>Arne Schwabe=
 <strong>uploaded patch set #7</strong> to this change=2E</p><p><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail">View Change</a=
></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">Add python scripts that demonstrate using the mangement =
interface<br><br>Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5<br>Si=
gned-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>A sample/man=
agement/omi=2Epy<br>A sample/management/omi_client_protocol=2Epy<br>A sampl=
e/management/omi_server_demo=2Epy<br>A sample/management/omi_server_protoco=
l=2Epy<br>A sample/management/omi_tools=2Epy<br>5 files changed, 1,054 inse=
rtions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/59/1859/7</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
sample/management/omi=2Epy b/sample/management/omi=2Epy</span><br><span>new=
 file mode 100644</span><br><span>index 0000000=2E=2Ed266bf2</span><br><spa=
n>--- /dev/null</span><br><span>+++ b/sample/management/omi=2Epy</span><br>=
<span>@@ -0,0 +1,289 @@</span><br><span style=3D"color: hsl(120, 100%, 40%)=
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
span style=3D"color: hsl(120, 100%, 40%);">+logger =3D logging=2EgetLogger(=
__name__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+logger=2Es=
etLevel(logging=2EINFO)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+@dataclass</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+class OmiCommandResult:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    command: str</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    result: List[str]</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    error: bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    status_text: str</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+@da=
taclass</span><br><span style=3D"color: hsl(120, 100%, 40%);">+class OmiSen=
dCommand:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    comman=
d: str</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    result: F=
uture[OmiCommandResult]</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+@dataclass</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+class ConnectionProperties:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    Properties for connecting =
to the management interface=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    password: Optional[str]</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+class OmiProtoco=
l(asyncio=2EProtocol):</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    def __init__(self, finish_future: Future, connect_data: ConnectionPr=
operties):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s=
uper()=2E__init__()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        self=2E_connect_data: ConnectionProperties =3D connect_data</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        self=2Ebytes_received: int =3D 0</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2Ebytes_sent=
: int =3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
self=2Eversion: int =3D -1</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        self=2ErecvBuffer: str =3D &quot;&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        self=2Efinish_future: Future =3D=
 finish_future</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   self=2Etransport: Optional[asyncio=2ETransport] =3D None</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        # Event to allow waiting for status of the und=
erlying socket</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   # to become available for writing</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        self=2E_can_send: Event =3D asyncio=2EEvent()</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_can_send=
=2Eclear()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        # Event to track whe=
n the management interface is ready to receive</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        # commands from us</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        self=2E_management_ready: Event =
=3D asyncio=2EEvent()</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        self=2E_management_ready=2Eclear()</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        self=2E_response =3D []</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        self=2E_response_ready: Event =3D asyncio=2EEvent=
()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_r=
esponse_ready=2Eclear()</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E=
_send_queue: Queue =3D asyncio=2EQueue()</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        self=2E_send_task: Task =3D asyncio=2Ecreate_t=
ask(self=2E_send_loop())</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    @override<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def eof_received=
(self) -&gt; None:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       logger=2Einfo(&#39;EOF received=2E Shutting down=2E&#39;)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_stop()</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    @override</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    def connection_lost(self, exc: Exception | None)=
 -&gt; None:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if exc:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 logger=2Ewarn(f&#39;Connection lost ({exc})=2E Shutting down=2E&#39;)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        else:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            logger=2Ewarn(f&#3=
9;Connection lost=2E Shutting down=2E&#39;)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        self=2E_stop()</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    def _stop(self) -&gt; None:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if not self=2Efinish_future=2Edone():</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            # If we are disco=
nnected or stop, there is no sense trying</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            # to still send commands to the managemen=
t interface</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    self=2E_send_task=2Ecancel()</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            self=2Efinish_future=2Eset_result(True)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    async def _send_loop(self) -&gt; None:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        while True:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            command: OmiSe=
ndCommand =3D await self=2E_send_queue=2Eget()</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            await self=2E_can_send=2Ewait()</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            self=2Esend_=
line(command=2Ecommand)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            res=
ponse: List[str] =3D []</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            response_complete =3D False</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            # This is a bit brittle as it will loop forever if not get=
ting a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            #=
 line that starts with ERROR or SUCCESS=2E With a normal OpenVPN</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            # daemon that spea=
k the correct protocol this should not be a</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            # problem</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            while not response_complete:</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                await self=
=2E_response_ready=2Ewait()</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     line =3D self=2E_response=2Epop(0)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                response=2Eappend(line)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                if not self=2E_response:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                    self=2E_respo=
nse_ready=2Eclear()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                las=
tline =3D response[-1]</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                if lastline=2Estartswith(&#39;ERROR:&#39;):</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    status =3D F=
alse</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
     response_complete =3D True</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    _, status_text =3D lastline=2Esplit(&quot;:=
&quot;, 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                elif lastlin=
e=2Estartswith(&#39;SUCCESS:&#39;):</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    status =3D True</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    response_complete =3D=
 True</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
      _, status_text =3D lastline=2Esplit(&quot;:&quot;, 1)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                elif lastline =3D=
=3D &quot;END&quot;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    status =3D True</span><br><span style=3D"color: hsl(12=
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
 status, status_text)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            comma=
nd=2Eresult=2Eset_result(result)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            logger=2Edebug(f&quot;Command done=2E&quot;)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    @override</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    def pause_writing(self) -&gt; None:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_can_send=2Ecle=
ar()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    @override</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    def resume_writing(self) -&gt; None:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_can=
_send=2Eset()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    @override</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    def connection_made(self, t=
ransport) -&gt; None:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        peername =3D transport=2Eget_extra_info(&#39;peername&#39;)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        logger=2Einfo(&#3=
9;Connection from {}&#39;=2Eformat(peername))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        self=2Etransport =3D transport</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_can_send=2Eset=
()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        # OMI expects us to authenti=
cate with the password just on</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        # its own on a line</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if self=2E_connect_data=2Epassword:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            self=2Etransport=2Ew=
rite(f&quot;{self=2E_connect_data=2Epassword}\r\n&quot;=2Eencode())</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    @override</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    def data_received(self, data: bytes) -&gt; None:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # OMI proto=
col is pure text so decode everything as UTF-8</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        message =3D data=2Edecode()</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        self=2ErecvBuffer +=3D m=
essage</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        parts =3D self=2ErecvBuf=
fer=2Esplit(&quot;\r\n&quot;)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        #=
 pass complete lines to recvLine</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        for part in parts[:-1]:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            logger=2Edebug(f&#39;Line received: {p=
art!r}&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     self=2Erecv_line(part)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # k=
eep the last incomplete line for the next call</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        self=2ErecvBuffer =3D parts[-1]</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    def recv_line(self, line: str) -&gt; None:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if line=2Est=
artswith(&quot;&gt;&quot;):</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            # this is an asynchronous message</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            self=2Erecv_notify(line)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        else:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            # normal message g=
et passed to the _send_loop task</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            self=2E_response=2Eappend(line)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            self=2E_response_ready=2Es=
et()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    def recv_notify(self, line: st=
r) -&gt; None:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if not &quot;:&quot; in line:</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            logger=2Ewarning(&quot;Invalid line received: &quo=
t; + line)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        command, args =3D lin=
e[1:]=2Esplit(&quot;:&quot;, 1)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 # do dynamic dispatch based on command to call a handler</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if hasattr(self, f&quot;recv_=
notify_{command}&quot;):</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            handler =3D getattr(self, f&quot;recv_notify_{command}&quo=
t;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            hand=
ler(args)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        logger=2Einfo(&quot;Un=
known notify line received: &quot; + line)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    def recv_notify_INFO(self, args: str) -&gt; None:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        m =3D re=2Ematch(r&quot;OpenV=
PN Management Interface Version (?P&lt;version&gt;\d+)&quot;, args)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if m:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            self=2Eversion =3D in=
t(m=2Egroup(&quot;version&quot;))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            self=2Equeue_command(&quot;version 6&quot;)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            self=2E_manag=
ement_ready=2Eset()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        else:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      logger=2Ewarning(f&quot;Unknown INFO line received: {args}&quot;)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    def recv_notify_BYTECOUNT(self, args:=
 str) -&gt; None:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      bytes_sent, bytes_received =3D args=2Esplit(&quot;,&quot;, 1)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2Ebytes_sent =
=3D int(bytes_sent)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        self=2Ebytes_received =3D int(bytes_received)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    async def _release_hold_task(self, hold_time: int =3D 0)=
 -&gt; None:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 await asyncio=2Esleep(hold_time)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        await self=2Equeue_command(&quot;hold release&quot;)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    def recv_notify_HOLD(self, args):</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        _text, hold_t=
ime =3D args=2Esplit(&quot;:&quot;, 1)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        hold_time =3D int(hold_time)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        asyncio=2Ecreate_task(self=2E_release_hold_task(ho=
ld_time))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    def queue_command(self, c=
ommand: str) -&gt; Future[OmiCommandResult]:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        cmd =3D OmiSendCommand(command, Future())<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_send=
_queue=2Eput_nowait(cmd)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return cmd=2Eresult</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
ync def management_ready(self) -&gt; int:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        &quot;&quot;&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        Waits until the management interface i=
s ready=2E Returns the management interface version=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        &quot;&quot;&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        await self=2E_management_=
ready=2Ewait()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return self=2Eversion</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def send_l=
ine(self, line: str) -&gt; None:</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        logger=2Edebug(f&quot;Sending line: {line}&quot;)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2Etransport=
=2Ewrite(f&quot;{line}\n&quot;=2Eencode())</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    Set the bytecount interval=2E Use 0 to disable</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    async def set_bytecount_interval(self, interval: =
int):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return=
 await self=2Equeue_command(f&quot;bytecount {interval}&quot;)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    async def enable_log(self):</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return await self=2Equeue_comma=
nd(&quot;log on&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def recv_not=
ify_LOG(self, args):</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        # &gt;LOG:1786453401,D,MANAGEMENT: CMD &#39;bytecount 30&#39;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        timestamp, level=
, message =3D args=2Esplit(&quot;,&quot;, 2)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        timestamp =3D datetime=2Efromtimestamp(int(timestamp))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        level =3D level=2E=
strip()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mess=
age =3D message=2Estrip()</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        self=2Elog_message(timestamp, level, message)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    def log_message(self, time, level, message):</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;&quot;&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        A new log =
message has been received=2E This method is intended</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        to be overridden by a subclass to=
 handle the log messages=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        :param time:    time in local time format</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        :param level:   level of the =
log message</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
:param message: the log message itself</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        :return:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        &quot;&quot;&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        logger=2Edebug(f&quot;Received log message: =
{time}, {level}, {message}&quot;)</span><br><span>diff --git a/sample/manag=
ement/omi_client_protocol=2Epy b/sample/management/omi_client_protocol=2Epy=
</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E68=
99083</span><br><span>--- /dev/null</span><br><span>+++ b/sample/management=
/omi_client_protocol=2Epy</span><br><span>@@ -0,0 +1,136 @@</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#!/usr/bin/env python3</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+# Copyright (c) 2026 OpenVPN Inc=
 &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+# Copyright (c) 2026 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=
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
: hsl(120, 100%, 40%);">+import asyncio</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+import base64</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+import logging</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+from typing import Tuple</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from =
omi import OmiProtocol, OmiCommandResult</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+logger =3D logging=2EgetLogger(__name__)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+logger=2EsetLevel(logging=2EDEBUG)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
class OMIClientProtocol(OmiProtocol):</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    &quot;&quot;&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    Implement the management protocol for the client  =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;&quot;&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    def __init__(self, finish_futur=
e, connect_data):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      super()=2E__init__(finish_future=3Dfinish_future, connect_data=3Dconn=
ect_data)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        se=
lf=2E_partial_acc_msg =3D &quot;&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        self=2E_protocol_acc_msg =3D &quot;&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_acc_fragme=
nt_length =3D 980</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      self=2E_acc_negotiated_protocols =3D []</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    async def send_acc_msg(self, protocol: str, msg: bytes):</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;&quot;&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Sends out an=
 ACC to the server using the specified ACC message length</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        :param protocol:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        :param msg:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        :param fragment_length:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        :return:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;&quot;&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if proto=
col not in self=2E_acc_negotiated_protocols:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            logger=2Eerror(f&quot;Error: trying to=
 send ACC message with protocol &quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                         f&quot;{protocol} is not in the=
 negotiated list of &quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                         f&quot;protocols ({self=2E_acc_negotiated_p=
rotocols})&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
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
 100%, 40%);">+                flags +=3D &quot;F&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            commands=2Eappend(f&quot;acc-msg\n{protocol}\n=
{flags}\n{b64msg}\nEND&quot;)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
md_futures =3D []</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      for command in commands:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            cmd_futures=2Eappend(self=2Equeue_command(command))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        cmd_results: Tuple[OmiCommandRe=
sult] =3D await asyncio=2Egather(*cmd_futures)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        for cmd_result in cmd_results:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            if cmd_result=2Eerror:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                logger=2Eerror(f&=
quot;Error: sending ACC message failed: {cmd_result}&quot;)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    def recv_notify_ACC_PROTOCOLS(self, args):</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        params =3D args=2Es=
plit(&quot;,&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        acc_params =3D {}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for p=
 in params:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    k, v =3D p=2Esplit(&quot;=3D&quot;, 1)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            acc_params[k=2Estrip()] =3D v=2Estrip()<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        self=2E_acc_negotiated_protocol=
s =3D acc_params[&#39;protocols&#39;]=2Esplit(&quot;:&quot;)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        self=2E_acc_fragment_length =3D int(acc_param=
s[&#39;message_len&#39;])</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def recv_=
notify_ACC(self, args):</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        protocol, fragment, b64msg =3D args=2Esplit(&quot;,&quot;, 2)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if self=2E_partial_acc_msg and s=
elf=2E_protocol_acc_msg !=3D protocol:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            logger=2Eerror(f&quot;Recieved ACC message w=
ith protocol {protocol} before &quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                         f&quot;previous ACC message with=
 protocol {self=2E_protocol_acc_msg} was complete&quot;)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            self=2E_partial_acc_msg =
=3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        try:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            msg =3D base64=2E=
decodebytes(b64msg=2Eencode())</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            self=2E_partial_acc_msg +=3D msg=2Edecode()</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            self=2E_protocol=
_acc_msg =3D protocol</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        except Exception as e:</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            logger=2Eerror(f&quot;Error parsing ACC message: {=
e}&quot;, exc_info=3DTrue)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            self=2E_partial_acc_msg =3D &quot;&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            return</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        fragmented =3D fragment !=3D &quot;0&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        logger=2Edebug(<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            f&quot;R=
eceived ACC message (fragment {fragmented}, protocol {protocol!r}), with pa=
yload {msg=2Edecode()!r}&quot;)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 # Message is not yet complete=2E Wait for more fragments=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if fragmented:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            return</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if hasattr(self, f&quot;receive_acc_{protoc=
ol}&quot;):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    handler =3D getattr(self, f&quot;receive_acc_{protocol}&quot;)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            logger=2Edebug(f=
&quot;Calling handler {handler}&quot;)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            try:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                handler(self=2E_partial_acc_msg)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            except Exception a=
s e:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 logger=2Eerror(f&quot;Error parsing ACC message: {e}&quot;, exc_info=3DTru=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                s=
elf=2E_partial_acc_msg =3D &quot;&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        else:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            logger=2Einfo(f&quot;Received unhandled ACC proto=
col: {protocol}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        self=2E_=
partial_acc_msg =3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        self=2E_protocol_acc_msg =3D &quot;&quot;</span><br><s=
pan>diff --git a/sample/management/omi_server_demo=2Epy b/sample/management=
/omi_server_demo=2Epy</span><br><span>new file mode 100755</span><br><span>=
index 0000000=2E=2E6448817</span><br><span>--- /dev/null</span><br><span>++=
+ b/sample/management/omi_server_demo=2Epy</span><br><span>@@ -0,0 +1,299 @=
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
yle=3D"color: hsl(120, 100%, 40%);">+from dataclasses import field</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+from typing import Dict, Opt=
ional</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+from omi_server_protocol import O=
MIServerProtocol, ConnectedClient</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+from omi_tools import run_main, start_management_protocol, Co=
nnectData</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from omi_t=
ools import openvpn_escape</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# This imple=
ment a small demonstration of using the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# OpenVPN Access Server Management Interface (OMI)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+# and a script that does=
 various action on the client depending</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# on the username the user connects with</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# ensure that you have a proper ce=
rtificate based authentication setup</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# before using this script</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+# (e=2Eg=2E https://github=2Ecom/openvpn/openvpn/bl=
ob/master/doc/man-sections/example-fingerprint=2Erst)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+# usage:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# --management /path/to/omi_server_demo=2Epy unix-script</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+# The main purpose of this script is to test/force ce=
rtain client/server</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
# behaviour=2E As a test script this is done on the username but also serve=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# as an example ho=
w to implement something similar for normal usage=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# if a username is prefixed with url it uses the old OPEN_U=
RL method (e=2Eg=2E urlrick)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - fail:=
 sends AUTH_FAILED</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
 - failn: sends AUTH_FAILED wiht \n</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# - failtemp: sends AUTH_FAILED,TEMP:Go away for a while</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+# - failtemp42: sends =
AUTH_FAILED,TEMP and backoff for 42s</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#     - failtempnr: sends AUTH_FAILED,TEMP and instructs t=
o go the next remote</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# - success: sends AUTH_SUCCESS</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+# - faildelay: sends AUTH_FAILED after 20s</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+# - successdelay: sends AUTH_SUCCESS af=
ter 20s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - rick: se=
nds you to a certain youtube site and auth you</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+# - openvpn: sends you to community=2Eopenvpn=2E=
net</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - totp: Does c=
rtext based 2FA with secret &quot;totpinsecuretotp&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+# - google: sends you to https://www=
=2Egoogle=2Ecom/search?q=3Dhidden without any flags</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# - googlext: sends you to https://www=2E=
google=2Ecom/search?q=3Dexternal with external flags and WEBAUTH \</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#         - dnssec: send onl=
y dnssec servers</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# -=
 nodns: no dns servers</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+# - dnssecfb: dns server with fallback to dns without dnnsec</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# - dnsdhcp: dns options and dh=
cp_options</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - dnspo=
rt: dns server with custom port</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# - failaccdpc1: auth failed message indicating that the client=
 is missing dpc1 ACC support=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# - failaccdpc1user: auth failed message indicating that the cl=
ient is missing dpc1 ACC support indicating a auth-token and user for recon=
necting</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#     - fail=
accflower: auth failed message indicating that the client is missing flower=
 and power ACC support=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+# - default: push DNS 8=2E8=2E8=2E8 and default route</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+# - notify: Gives the client a mess=
age to display to the user via notify protocol</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# The hard-coded secret</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+totp_secret =3D &quot;totpinsecuretotp&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+logging=2EbasicConfig()</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+logger =3D logging=2EgetLogger(__name__)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+logger=2EsetLevel(logging=2EINFO=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+try:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    import pyotp</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+except ImportError:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    logger=2Einfo(&quot;pyotp module not found=2E TOTP =
testing disabled&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+class ServerDemoConnectedClient(Co=
nnectedClient):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
# Remember the key-id that we authenticated</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    authenticated_kid: int =3D -1</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    env:Dict[str, str] =3D field(defa=
ult_factory=3Ddict)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
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
0000=2E=2E5655ac3</span><br><span>--- /dev/null</span><br><span>+++ b/sampl=
e/management/omi_server_protocol=2Epy</span><br><span>@@ -0,0 +1,241 @@</sp=
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
       self=2E_connected_clients:Dict =3D {}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    def _reset_pending_client_event(self) -&gt; None:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        self=2E_pending_client_even=
t:str =3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        self=2E_pending_client_event_cid:int =3D -1</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        self=2E_pending_client_event_kid=
:int =3D -1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
self=2E_pending_client_event_extra_args:str =3D None</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        self=2E_client_env:Dict =3D {}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    def recv_notify_CLIENT(self, args: st=
r) -&gt; None:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   event, args =3D args=2Esplit(&quot;,&quot;, 1)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if event =3D=3D &quot;ENV&quot;:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if args =3D=3D &quot;END&quot=
;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                #=
 Client environment is finished, trigger previous client</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                # event that contained=
 an ENV</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    self=2E_trigger_client_event(self=2E_pending_client_event, self=2E_pend=
ing_client_event_cid,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                           self=2E_pending_client_event_k=
id, self=2E_client_env,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                           self=2E_pending_client_event=
_extra_args)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         self=2E_reset_pending_client_event()</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            else:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                key, value =3D args=2Esplit(&quot;=
=3D&quot;, 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          self=2E_client_env[key] =3D value</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        elif event in (&quot;ESTABLISHED&quot;, &quot;DISCONNECT&quot;=
):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            # Thi=
s event is followed by a client environment=2E Wait for</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            # the client environment to=
 be completed before triggering the event</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            cid =3D int(args)</span><br><span style=
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
yle=3D"color: hsl(120, 100%, 40%);">+            cid, addr, extra =3D args=
=2Esplit(&quot;,&quot;, 2)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            self=2E_trigger_client_event(event, int(cid), -1, None, =
extra)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            logger=
=2Einfo(f&quot;Client event {event} not handled=2E (message: {args!r})&quot=
;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    def client_event_ACC(self, clien=
t: ConnectedClient, kid: int, env: Dict, extra: str) -&gt; None:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        protocol, fragment, b6=
4msg =3D extra=2Esplit(&quot;,&quot;, 2)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if client=2E_partial_acc_msg and client=2E_protocol_acc_msg !=3D =
protocol:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  logger=2Eerror(f&quot;Recieved ACC message with protocol {protocol} befor=
e &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
              f&quot;previous ACC message with protocol {client=2E_protocol=
_acc_msg} was complete&quot;)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            client=2E_partial_acc_msg =3D &quot;&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if client=2E_partial_acc_msg and client=
=2E_kid_acc_msg !=3D kid:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            logger=2Eerror(f&quot;Recieved ACC message with different=
 key id {kid} before &quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                         f&quot;previous ACC message with key id {c=
lient=2E_kid_acc_msg} &quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                         f&quot;was complete=2E This is currently =
not handled&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           client=2E_partial_acc_msg =3D &quot;&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        try:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            msg =3D base64=2Edecodebytes(b64msg=2Eencode())</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            client=2E_parti=
al_acc_msg +=3D msg=2Edecode()</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            client=2E_protocol_acc_msg =3D protocol</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            client=2E_kid_acc_ms=
g =3D kid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            # Message is not =
yet complete=2E Wait for more fragments=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            if fragment !=3D &quot;0&quot;:</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                return</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            handler_name =3D f&quot;receive_=
acc_client_{protocol}&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            if hasattr(self, handler_name):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                handler =3D getattr(self,=
 handler_name)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           logger=2Edebug(f&quot;Calling handler {handler}&quot;)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                try:</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    handler(=
client, kid, client=2E_partial_acc_msg)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                except Exception as e:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    logger=2Eerror(f=
&quot;Error parsing ACC message: {e}&quot;, exc_info=3DTrue)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            else:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                logger=2Einfo(f&quot=
;Received unhandled ACC protocol: {protocol}, handler {handler_name} not fo=
und&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            client=2E_partia=
l_acc_msg =3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            client=2E_protocol_acc_msg =3D protocol</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        except Exception as e:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            logger=2Eerror(f&quot;Error pars=
ing ACC message from client: {e}&quot;, exc_info=3DTrue)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            client=2E_partial_acc_msg =
=3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        client=2E_parti=
al_acc_msg =3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def rec=
v_notify_BYTECOUNT_CLI(self, args: str) -&gt; None:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cid, bytes_sent, bytes_received =
=3D args=2Esplit(&quot;,&quot;, 2)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    client =3D self=2E_connected_clients=2Eget(int(cid))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if client:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            client=2Ebytes_sent =3D int=
(bytes_sent)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     client=2Ebytes_received =3D int(bytes_received)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    def _trigger_client_event(self, event: str, cid: int, ki=
d: int, env: Optional[Dict], extra):</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        client =3D self=2E_connected_clients=2Eget(cid, No=
ne)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        # Remember ACC protocol opt=
ions if present</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if event =3D=3D &quot;CONNECT&quot; and &quot;acc_protocols&quot; in en=
v:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            clien=
t=2Eacc_negotiated_protocols =3D [p=2Estrip() for p in env[&quot;acc_protoc=
ols&quot;]=2Esplit(&quot;:&quot;)]</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            client=2E_acc_fragment_length =3D int(env[&#39;a=
cc_message_len&#39;])</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        handler_n=
ame =3D f&quot;client_event_{event}&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if hasattr(self, handler_name):</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            handler =3D getattr(s=
elf, handler_name)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           handler(client, kid, env, extra)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        else:</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            logger=2Einfo(f&quot;Client event {event} not=
 handled=2E Method {handler_name} does not exist=2E&quot;)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    def _add_client(self, cid: int) -&gt; None:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if not cid in self=
=2E_connected_clients:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            self=2E_connected_clients[cid] =3D self=2E_connected_client_=
class(cid=3Dcid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    def _remove_client=
(self, cid: int) -&gt; None:</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        del self=2E_connected_clients[cid]</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    async def get_client_status(self) -&gt; OmiCommandResult=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmd_result=
 =3D self=2Equeue_command(&quot;status 3&quot;)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return await cmd_result</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    async def send_acc_msg(self, client: ConnectedClie=
nt, kid: int, protocol: str, msg: bytes) -&gt; None:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        &quot;&quot;&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        Sends out an ACC to the cl=
ient=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quo=
t;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if protocol not in client=2Eacc_negotiated_protocols:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            logger=2Eerror(f&quot;Erro=
r: trying to send ACC message with protocol&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                         f&quot; {protocol} i=
s not in the negotiated list of &quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                         f&quot;protocols ({client=2Eacc=
_negotiated_protocols})&quot;)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            return</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        #=
 See init=2Ec for the explanation for the length</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        max_header_size =3D len(&quot;ACC,&quo=
t;) + len(protocol) + 1 + 4 + 1 + 2 + 1</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        # calculate fragment size with base64 encoding</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        fragment_length =3D client=2E_a=
cc_fragment_length * 6 // 8 - max_header_size</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        commands =3D []</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        for part_start in range(0, len(msg), fragment_length):</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            msg_part =3D msg[part_start:=
part_start + fragment_length]</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            b64msg =3D base64=2Eencodebytes(msg_part)=2Edecode()<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            flags =3D &quot;6&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            if part_sta=
rt + fragment_length &lt; len(msg):</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                flags +=3D &quot;F&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            commands=2Eappend(f&quot;client-acc-msg {clie=
nt=2Ecid} {kid}\n{protocol}\n{flags}\n{b64msg}\nEND&quot;)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        cmd_futures =3D []</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        for command in commands:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            cmd_futures=2Eappend(se=
lf=2Equeue_command(command))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cm=
d_results: Tuple[OmiCommandResult] =3D await asyncio=2Egather(*cmd_futures)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for cmd_res=
ult in cmd_results:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            if cmd_result=2Eerror:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                logger=2Eerror(f&quot;Error: sending ACC mes=
sage failed: {cmd_result}&quot;)</span><br><span>diff --git a/sample/manage=
ment/omi_tools=2Epy b/sample/management/omi_tools=2Epy</span><br><span>new =
file mode 100644</span><br><span>index 0000000=2E=2E6053749</span><br><span=
>--- /dev/null</span><br><span>+++ b/sample/management/omi_tools=2Epy</span=
><br><span>@@ -0,0 +1,89 @@</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#! /usr/bin/python3</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# Copyright (c) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+# Copyright (c) 2026 Arne =
Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# P=
ermission is hereby granted, free of charge, to any person obtaining a copy=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# of this software =
and associated documentation files (the &quot;Software&quot;), to deal</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+# in the Software withou=
t restriction, including without limitation the rights</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+# to use, copy, modify, merge, publish, =
distribute, sublicense, and/or sell</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# copies of the Software, and to permit persons to whom the=
 Software is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# furni=
shed to do so, subject to the following conditions:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# The above copyright notice and this permission notice sha=
ll be included in all</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# copies or substantial portions of the Software=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRA=
NTY OF ANY KIND, EXPRESS OR</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTA=
BILITY,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# FITNESS FO=
R A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+# AUTHORS OR COPYRIGHT HOLD=
ERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TO=
RT OR OTHERWISE, ARISING FROM,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER =
DEALINGS IN THE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# SO=
FTWARE=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import asy=
ncio</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import os</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+import re</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+from dataclasses import dataclass</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+from omi import OmiProtocol, ConnectionP=
roperties</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+@dataclass</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+class ConnectData(ConnectionProperties):</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    socket: str</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ope=
nvpn_escape_re =3D re=2Ecompile(r&#39;([&quot;\\])&#39;)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+filt_ctrl_re =3D re=2Ecompile(r&quot;[=
\x00-\x1f\x7f]+&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+def openvpn_escape(text):</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    &quot;&quot;&quot;Escapes a string to be safely used for OpenV=
PN inside</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a quot=
ed string</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    Something like &#39;clien=
t-deny 2 3 &quot;{openvpn_escape(reason)}&quot; &quot;{openvpn_escape(clien=
t_reason)}&quot;&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    text =3D re=2Esub(filt_ctrl_re, &#39; &#39;, text)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    text =3D re=2Esub(openvpn_escap=
e_re, r&#39;\\\1&#39;, text)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return text=2Erstrip()</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+def=
 get_unix_script_environment() -&gt; ConnectData | None:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    password =3D os=2Eenviron=2Eget(&q=
uot;MANAGEMENT_PASSWORD&quot;, None)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    socket =3D os=2Eenviron=2Eget(&quot;MANAGEMENT_SOCKET&=
quot;, None)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if password and socket=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return Con=
nectData(password=3Dpassword, socket=3Dsocket)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    else:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return None</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+async def start_manag=
ement_protocol(connect_data: ConnectData, protocol=3DOmiProtocol):</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    # Get a reference to the=
 event loop as we plan to use</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    # low-level APIs=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    loop =3D asyncio=2Eget_running_loop()</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    finish_future =3D loop=2Ecreate_future()</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    print(f&quot;Connecting to management socket {co=
nnect_data=2Esocket} with passwd {connect_data=2Epassword[:4]}=2E=2E=2E&quo=
t;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    transport, p=
rotocol =3D await loop=2Ecreate_unix_connection(lambda: protocol(finish_fut=
ure, connect_data),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                                            connect_data=2E=
socket)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return transport, protocol,=
 finish_future</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+def run_main(main_func, connect_parameter=
s: ConnectData =3D None):</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    Example function to run a main function to be either using the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    environment var=
iable for the unix-script or to use=2E If the unix-script</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    environment are detected, the fun=
ction will run the main_func</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    with the ConnectData from the environment=2E If the environmen=
t variables</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    are =
not available, it will fall back to the connect_parameters</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if present=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    :param connect_parameters:  fallba=
ck connect parameters if unix-script is not available</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    :param main_func:           The funct=
ion to call=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    :=
return:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;&q=
uot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unix_=
script_parameters =3D get_unix_script_environment()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if unix_script_parameters:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        asyncio=2Erun(main_fun=
c(unix_script_parameters))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    elif connect_parameters:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        asyncio=2Erun(main_func(connect_parameters))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    else:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        print(f&quot;Must be called =
via unix-script&quot;)</span><br></pre><p>To view, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail">change 1859</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib09bafab=
f612e9501ea757647c86a450c73228a5 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1859 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7=
 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Name=
 of user not set #1000061 </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: Name of user not set #1000061 </div>=


</body></html>
--yAkVRYL9zws=--


--===============2189986143277286537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2189986143277286537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2189986143277286537==--

