Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A859A606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=beELUAdx;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ICjAzhis;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eryt3dx1;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IitVUj3+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=EYjv6YUAkwigrOLRv4u3oCwc9MixvEsD0Z+5s7kPQsg=; b=beELUAdxCtleAqAmq+71qGyswK
	isHNDRWxuhFWzV+xGi3NSI/su0CsxFD5BMSkdNsGbPcHhn/1yK2hnIc35Kth7HJXiUa6DmhVd3FAB
	IQx5njSdcyQfeIWw5PQ96YwJdvtX9ya9aysaNfpz5q8ypBhz3dRyaP5dLTcvjUzClVR4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMTYW-000000007qW-3wXZ;
	Thu, 29 Oct 2026 17:04:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMTYW-000000007qL-0FT5
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 17:04:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F/AWZX7lNlhMRW/kWe22T1NzSQaGcHtX3iTTjXF+EKM=; b=ICjAzhisbAWNA0xDyqwIfMTCAM
 HiorO6yaaDOpi0wLtqRpWoNrjkFByHDHOHnaV65f3ZvtmcVICI0K5XUJ8AFe2LXQdGrmS0P9dmaSF
 oFeWcRroYlYO8cvrjJKRsC+wlUIxyIISGMpbp05VUP7HaBAf0sHRyxckKQaObsy5IxUg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F/AWZX7lNlhMRW/kWe22T1NzSQaGcHtX3iTTjXF+EKM=; b=eryt3dx1zqhLkBLf3SHoOKBtNF
 MXNTgyItzx5wC0ajQVlGs9W4aM8u4U855lObv7Dg9VGUSweJC+AuFx71pR6xjuZvuVR04M1wN/D9B
 OQ/lPMWGnuUPljF6ntSV3fYynidSopAnUpeHGmVIBScBEX/Yt3KoleIGcxVnXic1q8YQ=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMTYU-000000000Qm-07Sz for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 17:04:47 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso1746587f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 10:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793293479; x=1793898279; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=F/AWZX7lNlhMRW/kWe22T1NzSQaGcHtX3iTTjXF+EKM=;
 b=IitVUj3+VHQ9z3tlrSSnA8aOLR8mKCY6i6V7YzEjZp+O0W3/SWfPYKAY8Y/g3SWWFM
 hF2X2UmCgwHxna34rxMm0ANNqq8xt0o+m/swhf69plyc7mudMKHj+XAhk1Y0wlLlz8CT
 D/+ujz/7DNB0ECfQhndlFrYpirGUnJT91BUhuyC1ckckzFhDI1Y0YXpyh5IaVt7sFNOJ
 3fQC8kklNjCIs4+T0YcD7buVf7w/7NVqMVnuJqFXszQYWq0pgqzn79xg1+cG/BF02Yiq
 hz7y7tbduhgfdJS1/GPjuVuraASdomomiBW5eHjKq8NrWSv+cJVd1L4eRUNis8j2swDZ
 bEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793293479; x=1793898279;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=F/AWZX7lNlhMRW/kWe22T1NzSQaGcHtX3iTTjXF+EKM=;
 b=LRePeJ5M0siuuZYRBQKWfVHHcPkYp2GsxxEBQb/61pDLW+8ZsZnYf0avnOwTJAPaFU
 1lMQx/OxNszaak+yj9MOyM9WWv2jtXUufZETjCsrMeOkM/Qnief0gy2/coDrQzDbvL6S
 m7xlWcvcDgd/zQml+UIOJTxtjAhYsIQRrC/gy/y9VUQdAGm3dlSoE95mHzw5/rn2YPxY
 6tEcbfvjnZep2npIB2sY38nX4zRyUvE6Nt7kxvAv6IWoY2YJ7BEW0PlK8bOnVk5qijqt
 Nigqw8Rw9hxpHDy0Cl3SV9NlPo38Wn4rqdOToK+kRIerp4Bx5vrmD6j9fUltMaTMICBz
 5ywA==
X-Gm-Message-State: AFq9FYIIga49DfULbWbQa664SdL4oGFPAWHHvyBnTSFvxVGN0h/X1gEt
 I+VkyOFkvKlLttAbJQcUQyMqzi4gDMDxv9oIRt0J5D12VsxAHwQH3GUe8lPMkf0iF1ei3iLrrvu
 juwPfzbXkhfrJJAaeAYkyr5hLn2/A/SW6LOEZGuH9llum2Rnyocsu4GP8KeMhKkSmSnzO87FNVe
 H3a67LJA==
X-Gm-Gg: AYBFou1FezSc65ic3khst2uaAaaFBsfZQKkhfyUOvpss5eUO7THoOhXGFzq+l8zzHju
 4TtwgpFr1xztj+0mTWmuXFOmD0XqHtW6FQMuJLnPY5DEHXUhz3/gdaVAT05m66nbUr2ne/87C0I
 pku5/VM9BzT9yw2ZbT7vwabNGnZSC3ZYX+iB4aPnUpsPO6OWdBg2kIebOcdBpSIDrliwqt5sOWR
 9U6VRh1Fn3ObGQKS85E2vBaA80sh5zzIralOrNJbUDr5DatCAGGiye9o0Oolaet0T6r3tlIlxdQ
 TcUYOOt6w1Cras73IUOKGh4M2Zk+i/GHmeo39JbgTa2HUMGI2rf3Vtb7/Jahfwn8s+Q5uIsTb6M
 xd77k9k0PcLxI8ep3v7f0YJ9daWsQiXdkrVbHb/LPEEJre2Px7+Uoe4/2YYcnnU9LGUQF5GOgm0
 muq+krv9UtkFOFpojgLBGTx/ICJC2kQjhOGFaWfd0PQfbS4ksW/vL8wREctBH1cmSQtq+Zr2JWZ
 q59vUryRrlW39ROULGDVrBf+CxbCeUqKCUswQfKWEGq3emOOwy15YGXO0SKdoNyOzcM3Kys0yV6
 s5BcwROCLhGswjuEVpfp83TYUsTOIlGw5QSHi3mb2aQ5A4AhH5G1VjHI3BqUMPrFDeclMY529dU
 u188P3OLsffnGv5YjNkmDV9gYfkISbCyjGRogZ2fOk0yiOQWelHgFhK1xQNZgPqbt1HzyPeiPBA
 wZy2aF8nz0Xj9V2aM=
X-Received: by 2002:a5d:5f55:0:b0:48c:4553:790b with SMTP id
 ffacd0b85a97d-48e5d5e2557mr16105995f8f.48.1793293475907; 
 Thu, 29 Oct 2026 10:04:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6df9fdf2sm328827f8f.30.2026.10.29.10.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 10:04:35 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 29 Oct 2026 17:04:27 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22
X-Gerrit-Change-Number: 1860
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1860?usp=email>
X-Gerrit-Commit: c6f1c752d4421e47ddb937aa0cbb5dad6361aeca
In-Reply-To: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
References: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzQ1NDE2MDAwLkllMjAyODk3MzdkNTAyYTI1ZWVkYzYwNjc3ZDNjMzUwZGRjM2IzYzIyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6c51c53c315d3bdc1494d443b3dfc089207015d6-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xMTYU-000000000Qm-07Sz
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
Content-Type: multipart/mixed; boundary="===============4195141464503924285=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4195141464503924285==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SizP7dtfE2k="; charset=UTF-8

--SizP7dtfE2k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has uploaded a new patch set (#4)=2E ( https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1860?usp=3Demail )


Change subject: Add python scripts=
 that demonstrate using the dpc1 ACC protocol
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add python scripts that demonstrate usin=
g the dpc1 ACC protocol

The dpc1 protocol is used by the OpenVPN Connect c=
lients and
OpenVPN Connexa=2E

Change-Id: Ie20289737d502a25eedc60677d3c350d=
dc3b3c22
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
A sample/mana=
gement/acc_dpc1_client_demo=2Epy
A sample/management/acc_dpc1_server_demo=
=2Epy
2 files changed, 264 insertions(+), 0 deletions(-)


  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/60/1860/4

diff --git a/=
sample/management/acc_dpc1_client_demo=2Epy b/sample/management/acc_dpc1_cl=
ient_demo=2Epy
new file mode 100755
index 0000000=2E=2Eabe1617
--- /dev/nul=
l
+++ b/sample/management/acc_dpc1_client_demo=2Epy
@@ -0,0 +1,117 @@
+#!/u=
sr/bin/env python3
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
+
+#
+#  You should have received a copy of the GNU General Pub=
lic License along
+#  with this program; if not, see <https://www=2Egnu=2Eo=
rg/licenses/>=2E
+import asyncio
+import base64
+import json
+import loggin=
g
+import platform
+
+from omi import OmiProtocol
+from omi_tools import ru=
n_main, start_management_protocol, ConnectData
+
+logger =3D logging=2EgetL=
ogger(__name__)
+
+class OmiAccProtocol(OmiProtocol):
+    def __init__(sel=
f, finish_future, connect_data:ConnectData):
+        super()=2E__init__(fi=
nish_future, connect_data)
+        self=2Eaccmsg =3D ""
+
+    def recv_no=
tify_ACC(self, args):
+        # dpc1,0,eyJkcGNfcmVx[=2E=2E=2E]
+        pr=
otocol, fragment, b64msg =3D args=2Esplit(",", 2)
+        if protocol !=3D=
 "dpc1":
+            logger=2Einfo(f"Received unknown ACC protocol: {proto=
col}")
+            return
+
+        msg =3D base64=2Edecodebytes(b64msg=
=2Eencode())
+        self=2Eaccmsg +=3D msg=2Edecode()
+
+        # Messag=
e is not yet complete=2E Wait for more fragments=2E
+        if fragment !=
=3D "0":
+            return
+
+        self=2EparseDpc1(self=2Eaccmsg)
+  =
      self=2Eaccmsg =3D ""
+
+    def parseDpc1(self, accmsg):
+        msg=
 =3D json=2Eloads(accmsg)
+
+        logger=2Eerror(f"Received sys_info mes=
sage: {accmsg}")
+
+        dpc_request =3D msg["dpc_request"]
+        ver=
 =3D dpc_request["ver"]
+        if ver !=3D "1=2E0":
+            logger=
=2Eerror(f"Received unknown ACC protocol version: {ver}")
+            retu=
rn
+
+        client_info =3D dpc_request=2Eget("client_info", False)
+    =
    antivirus =3D "antivirus" in dpc_request
+        disk_encryption =3D "=
disk_encryption" in dpc_request
+
+        logger=2Einfo(f"Received DPC1 re=
quest: antivirus=3D{antivirus}, disk_encryption=3D{disk_encryption}, client=
_info=3D{client_info}")
+
+        if client_info:
+            self=2E_sen=
dDPC1ClientInfo()
+
+    def _sendDPC1ClientInfo(self):
+        system =3D=
 platform=2Esystem()
+        if system =3D=3D "Darwin":
+            syste=
m =3D "MacOS"
+
+        response =3D {
+            "dpc_response": {
+   =
             "ver": "1=2E0",
+                "client_info": {
+           =
         "os": {
+                        "type": system,
+                =
        "version": platform=2Erelease(),
+                        "extra":
=
+                            {
+                                "arch": pla=
tform=2Emachine(),
+                            }
+                    }
+ =
               }
+            }
+        }
+
+        b64msg =3D base64=2Eb=
64encode(json=2Edumps(response)=2Eencode())=2Edecode()
+
+        command =
=3D f"acc-msg\ndpc1\n6\n{b64msg}\nEND"
+        self=2Equeue_command(comman=
d)
+
+async def main(connect_data:ConnectData):
+    transport, protocol, f=
inish_future =3D await start_management_protocol(connect_data, OmiAccProtoc=
ol)
+
+    management_version =3D await protocol=2Emanagement_ready()
+    =
print(f"Management interface version: {management_version}")
+
+    await p=
rotocol=2Eset_bytecount_interval(5)
+
+    await finish_future
+
+
+if __na=
me__ =3D=3D '__main__':
+    run_main(main)
\ No newline at end of file
dif=
f --git a/sample/management/acc_dpc1_server_demo=2Epy b/sample/management/a=
cc_dpc1_server_demo=2Epy
new file mode 100644
index 0000000=2E=2Ebd14274
--=
- /dev/null
+++ b/sample/management/acc_dpc1_server_demo=2Epy
@@ -0,0 +1,14=
7 @@
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
+#
+#  You should have received a copy of the GNU G=
eneral Public License along
+#  with this program; if not, see <https://www=
=2Egnu=2Eorg/licenses/>=2E
+
+# This implements a small demonstration of us=
ing the
+# OpenVPN Access Server Management Interface (OMI) and an app Cust=
om Control
+# protocol (dpc1)=2E To use this use on the server
+
+# --manag=
ement-client-auth
+# --app-custom-control dpc1
+# --management /path/to/acc=
_dpc1_server_demo=2Epy unix-script
+
+# Note this is just a demonstration a=
nd not a production-ready solution=2E
+# When modifying this code, keep the=
 security in mind=2E It is easy to
+# introduce a security problem when wri=
ting scripts handling authentication
+
+import asyncio
+import json
+import=
 logging
+from pprint import pprint
+
+logging=2EbasicConfig()
+
+from omi_=
server_protocol import OMIServerProtocol, ConnectedClient
+from omi_tools i=
mport start_management_protocol, ConnectData, run_main
+
+logger =3D loggin=
g=2EgetLogger(__name__)
+
+
+class DpcConnectedClient(ConnectedClient):
+  =
  # Remember the key-id that we authenticated
+    dpc_completed =3D False
=
+    env =3D {}
+
+
+class OmiDPCServerProtocol(OMIServerProtocol):
+    de=
f __init__(self, finish_future, connect_data: ConnectData =3D None):
+     =
   super()=2E__init__(finish_future, connect_data)
+        self=2E_connect=
ed_client_class =3D DpcConnectedClient
+
+    def receive_acc_client_dpc1(s=
elf, client: DpcConnectedClient, kid, accmsg):
+        print(f"Received DP=
C1 message: {accmsg!r}")
+        msg =3D json=2Eloads(accmsg)
+        ppr=
int(msg)
+
+        dpc_response =3D msg["dpc_response"]
+        ver =3D d=
pc_response["ver"]
+        if ver !=3D "1=2E0":
+            logger=2Eerro=
r(f"Received unknown ACC protocol version: {ver}")
+            return
+
+ =
       client_info =3D dpc_response=2Eget("client_info", {})
+        antiv=
irus =3D "antivirus" in dpc_response
+        disk_encryption =3D "disk_enc=
ryption" in dpc_response
+
+        logger=2Einfo(
+            f"Received =
DPC1 response: antivirus=3D{antivirus}, disk_encryption=3D{disk_encryption}=
, client_info=3D{client_info}")
+
+        # Normally here would be a check=
 that the response matches the policy
+        # this demo script just allo=
ws everyone with a response to pass
+        client=2Edpc_completed =3D Tru=
e
+
+        self=2Equeue_command(f"client-auth-nt {client=2Ecid} {kid}")
+=

+    async def dpc_request_timeout(self, client, kid, timeout):
+        a=
wait asyncio=2Esleep(timeout)
+        if client=2Edpc_completed:
+        =
    return
+
+        client_deny =3D f'client-deny {client=2Ecid} {kid} "d=
pc1 timeout" "Timeout on device posture"'
+        await self=2Equeue_comma=
nd(client_deny)
+
+    def client_event_ESTABLISHED(self, client, kid, env,=
 extra):
+            print(f"CLient connected: {client}")
+            ppr=
int(env)
+
+    async def send_client_deny_no_dpc1(self, client: DpcConnect=
edClient, kid: int):
+        client_reason =3D "ACC[protocol dpc1]: To con=
nect to this server you " \
+                        "need to upgrade to a =
client that supports the " \
+                        "OpenVPN Inc device p=
osture protocol and has it " \
+                        "enabled, e=2Eg=2E =
OpenVPN for Android, openvpn3-linux, " \
+                        "or OpenV=
PN Connect"
+        client_deny =3D f'client-deny {client=2Ecid} {kid} "no=
 dpc1 support" "{client_reason}"'
+        await self=2Equeue_command(clien=
t_deny)
+
+    def client_event_CONNECT(self, client, kid, env, extra):
+  =
      print(f"Authenticating client {client}, {kid}, protos: {client=2Eacc_=
negotiated_protocols}")
+        client=2Eenv =3D env
+        asyncio=2Ecr=
eate_task(self=2Echeck_client_posture(client, kid))
+
+    async def check_=
client_posture(self, client, kid):
+        await self=2Equeue_command(f"cl=
ient-pending-auth {client=2Ecid} {kid} \"NOTIFY::Checking your device postu=
re, please wait\" 180")
+
+        await self=2Equeue_command(f"client-pend=
ing-auth {client=2Ecid} {kid} ACC 180")
+        await asyncio=2Esleep(20)
=
+
+        if "dpc1" not in client=2Eacc_negotiated_protocols:
+           =
 await self=2Esend_client_deny_no_dpc1(client, kid)
+            return
+
+=
        dpc_cmd =3D {"dpc_request": {"ver": "1=2E0", "correlation_id": "n/a=
", "timestamp": "yesterday", "client_info": True,
+                        =
               "disk_encryption": {"full": True}, "antivirus": {}}}
+
+    =
    dpc_cmd_str =3D json=2Edumps(dpc_cmd)
+        acc_protocol =3D "dpc1"
=
+
+        await self=2Esend_acc_msg(client, kid, acc_protocol, dpc_cmd_str=
=2Eencode())
+        asyncio=2Ecreate_task(self=2Edpc_request_timeout(clie=
nt, kid, 60))
+
+
+async def main(connect_data: ConnectData):
+    transpor=
t, protocol, finish_future =3D await start_management_protocol(connect_data=
, OmiDPCServerProtocol)
+
+    management_version =3D await protocol=2Emana=
gement_ready()
+    print(f"Management interface version: {management_versi=
on}")
+
+    await protocol=2Eenable_log()
+
+    await protocol=2Eset_byte=
count_interval(5)
+
+    await finish_future
+
+
+if __name__ =3D=3D '__mai=
n__':
+    run_main(main)

-- 
To view, visit https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1860?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22
Gerrit-Change-Number: =
1860
Gerrit-PatchSet: 4
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--SizP7dtfE2k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe <str=
ong>uploaded patch set #4</strong> to this change=2E</p><p><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail">View Change</a></p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Add python scripts that demonstrate using the dpc1 ACC protoc=
ol<br><br>The dpc1 protocol is used by the OpenVPN Connect clients and<br>O=
penVPN Connexa=2E<br><br>Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c=
22<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>A sa=
mple/management/acc_dpc1_client_demo=2Epy<br>A sample/management/acc_dpc1_s=
erver_demo=2Epy<br>2 files changed, 264 insertions(+), 0 deletions(-)<br><b=
r></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/60/1860/4</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/sample/management/acc_dpc1_clien=
t_demo=2Epy b/sample/management/acc_dpc1_client_demo=2Epy</span><br><span>n=
ew file mode 100755</span><br><span>index 0000000=2E=2Eabe1617</span><br><s=
pan>--- /dev/null</span><br><span>+++ b/sample/management/acc_dpc1_client_d=
emo=2Epy</span><br><span>@@ -0,0 +1,117 @@</span><br><span style=3D"color: =
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
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#  You should have received a=
 copy of the GNU General Public License along</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#  with this program; if not, see &lt;https://www=
=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+import asyncio</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+import base64</span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=
mport json</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import lo=
gging</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import platfor=
m</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+from omi import OmiProtocol</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+from omi_tools import run_mai=
n, start_management_protocol, ConnectData</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+logger =3D logging=2EgetLogger(__name__)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+class OmiAccProtocol(OmiProtocol):</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    def __init__(self, finish_future, connect_data:Conn=
ectData):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        su=
per()=2E__init__(finish_future, connect_data)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        self=2Eaccmsg =3D &quot;&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    def recv_notify_ACC(self, args):</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        # dpc1,0,eyJkcGNfcmVx[=
=2E=2E=2E]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        p=
rotocol, fragment, b64msg =3D args=2Esplit(&quot;,&quot;, 2)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if protocol !=3D &quot;dpc=
1&quot;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 logger=2Einfo(f&quot;Received unknown ACC protocol: {protocol}&quot;)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            return</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        msg =3D base64=2Edecodebytes(b64msg=
=2Eencode())</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 self=2Eaccmsg +=3D msg=2Edecode()</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    # Message is not yet complete=2E Wait for more fragments=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if fragment !=3D &quot;=
0&quot;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        self=2EparseDpc1(self=
=2Eaccmsg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s=
elf=2Eaccmsg =3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def p=
arseDpc1(self, accmsg):</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        msg =3D json=2Eloads(accmsg)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        logger=2Eerror(f&quot;Received sys_info message: {accmsg}&quot;)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        dpc_request =3D msg[&quot;dpc_r=
equest&quot;]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  ver =3D dpc_request[&quot;ver&quot;]</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if ver !=3D &quot;1=2E0&quot;:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            logger=2Eerror(f&quot;Rec=
eived unknown ACC protocol version: {ver}&quot;)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            return</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        client_info =3D dpc_request=2Eget(&quot;client_info&quot;,=
 False)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        anti=
virus =3D &quot;antivirus&quot; in dpc_request</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        disk_encryption =3D &quot;disk_encryptio=
n&quot; in dpc_request</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        logger=
=2Einfo(f&quot;Received DPC1 request: antivirus=3D{antivirus}, disk_encrypt=
ion=3D{disk_encryption}, client_info=3D{client_info}&quot;)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if client_info:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            self=2E_sendDPC1ClientInfo()</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    def _sendDPC1ClientInfo(self):</span><br><sp=
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
yle=3D"color: hsl(120, 100%, 40%);">+async def main(connect_data:ConnectDat=
a):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    transport, p=
rotocol, finish_future =3D await start_management_protocol(connect_data, Om=
iAccProtocol)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    management_version =
=3D await protocol=2Emanagement_ready()</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    print(f&quot;Management interface version: {managem=
ent_version}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    await protocol=
=2Eset_bytecount_interval(5)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    await =
finish_future</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+if __name__ =3D=3D &#39;__main__&#39;:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    run_main(main)</span>=
<br><span>\ No newline at end of file</span><br><span>diff --git a/sample/m=
anagement/acc_dpc1_server_demo=2Epy b/sample/management/acc_dpc1_server_dem=
o=2Epy</span><br><span>new file mode 100644</span><br><span>index 0000000=
=2E=2Ebd14274</span><br><span>--- /dev/null</span><br><span>+++ b/sample/ma=
nagement/acc_dpc1_server_demo=2Epy</span><br><span>@@ -0,0 +1,147 @@</span>=
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
ing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from pprint impo=
rt pprint</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+logging=2EbasicConfig()</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+from omi_server_protocol import OMIServerPro=
tocol, ConnectedClient</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+from omi_tools import start_management_protocol, ConnectData, run_main</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+logger =3D logging=2EgetLogger(__name__)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+class DpcConnectedClient(ConnectedClient):</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    # Remember the key-id that we =
authenticated</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dp=
c_completed =3D False</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    env =3D {}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+class OmiDPCServerProtocol(OMIServerProto=
col):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def __init=
__(self, finish_future, connect_data: ConnectData =3D None):</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        super()=2E__init__(finish_=
future, connect_data)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        self=2E_connected_client_class =3D DpcConnectedClient</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    def receive_acc_client_dpc1(self, client: DpcC=
onnectedClient, kid, accmsg):</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        print(f&quot;Received DPC1 message: {accmsg!r}&quot;)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg =3D json=2E=
loads(accmsg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  pprint(msg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        dpc_response =3D =
msg[&quot;dpc_response&quot;]</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        ver =3D dpc_response[&quot;ver&quot;]</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if ver !=3D &quot;1=2E0&quot;:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            logger=
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
   self=2Equeue_command(f&quot;client-auth-nt {client=2Ecid} {kid}&quot;)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    async def dpc_request_timeout(self, =
client, kid, timeout):</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        await asyncio=2Esleep(timeout)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if client=2Edpc_completed:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            return</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        client_deny =3D f&#39;client-deny {client=2Ecid} {=
kid} &quot;dpc1 timeout&quot; &quot;Timeout on device posture&quot;&#39;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        await self=2Eq=
ueue_command(client_deny)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    def clien=
t_event_ESTABLISHED(self, client, kid, env, extra):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            print(f&quot;CLient connected=
: {client}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          pprint(env)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    async def sen=
d_client_deny_no_dpc1(self, client: DpcConnectedClient, kid: int):</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        client_reason =3D &q=
uot;ACC[protocol dpc1]: To connect to this server you &quot; \</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                        &quot;ne=
ed to upgrade to a client that supports the &quot; \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        &quot;OpenVPN Inc=
 device posture protocol and has it &quot; \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                        &quot;enabled, e=2Eg=2E Op=
enVPN for Android, openvpn3-linux, &quot; \</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                        &quot;or OpenVPN Connect&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        client_d=
eny =3D f&#39;client-deny {client=2Ecid} {kid} &quot;no dpc1 support&quot; =
&quot;{client_reason}&quot;&#39;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        await self=2Equeue_command(client_deny)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    def client_event_CONNECT(self, client, kid, env, =
extra):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        prin=
t(f&quot;Authenticating client {client}, {kid}, protos: {client=2Eacc_negot=
iated_protocols}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        client=2Eenv =3D env</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        asyncio=2Ecreate_task(self=2Echeck_client_posture(clie=
nt, kid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    async def check_client_po=
sture(self, client, kid):</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        await self=2Equeue_command(f&quot;client-pending-auth {client=
=2Ecid} {kid} \&quot;NOTIFY::Checking your device posture, please wait\&quo=
t; 180&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        await self=2Equeu=
e_command(f&quot;client-pending-auth {client=2Ecid} {kid} ACC 180&quot;)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        await asyncio=
=2Esleep(20)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if &quot;dpc1&quot=
; not in client=2Eacc_negotiated_protocols:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            await self=2Esend_client_deny_no_dpc1(c=
lient, kid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        dpc_cmd =3D {&quot;d=
pc_request&quot;: {&quot;ver&quot;: &quot;1=2E0&quot;, &quot;correlation_id=
&quot;: &quot;n/a&quot;, &quot;timestamp&quot;: &quot;yesterday&quot;, &quo=
t;client_info&quot;: True,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                       &quot;disk_encryption&quot;: =
{&quot;full&quot;: True}, &quot;antivirus&quot;: {}}}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        dpc_cmd_str =3D json=2Edumps(dpc_cmd)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        acc_protocol =3D &quot;dpc=
1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        await self=2Esend_acc_m=
sg(client, kid, acc_protocol, dpc_cmd_str=2Eencode())</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        asyncio=2Ecreate_task(self=2Edpc_=
request_timeout(client, kid, 60))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+async def main(connect_d=
ata: ConnectData):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   transport, protocol, finish_future =3D await start_management_protocol(c=
onnect_data, OmiDPCServerProtocol)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
management_version =3D await protocol=2Emanagement_ready()</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    print(f&quot;Management interfac=
e version: {management_version}&quot;)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    await protocol=2Eenable_log()</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
wait protocol=2Eset_bytecount_interval(5)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    await finish_future</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+if __name__ =3D=3D &#39;__main_=
_&#39;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    run_main=
(main)</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1860?usp=3Demail">change 1860</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie20289737d502a25eedc60=
677d3c350ddc3b3c22 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1860 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--SizP7dtfE2k=--


--===============4195141464503924285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4195141464503924285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4195141464503924285==--

