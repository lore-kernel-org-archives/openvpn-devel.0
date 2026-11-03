Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129F8606A326
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WpJhou7c;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=m97yHVgq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GMIRydWb;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HckrJOIb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Fip1/w1k+8gbkoPj1YdHDyCRsf7HU8+k4PzsYW0iT5k=; b=WpJhou7c2nTsSnbyS57fmqJUVT
	wML8VShuA5GJChoHFgpoWfQJpQ/jokMSHwCQyT8guiQE3XrJ2FGFJ/WcUwaN1y5HD6C9pyjKxYuT9
	B4Cqes4Bn3/48Iy5gzTVsfg56nBpTm/SUHYd9fy/6qt8MXrjW3xEjd8zTsPfZAuMK1hw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOGl9-000000003sX-1Adi;
	Tue, 03 Nov 2026 15:49:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOGl8-000000003sR-1bFi
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:49:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fmP2e//yea3APB1C6lTRUvVUmEWyLeY2tUoYln3P0Eg=; b=m97yHVgqN+djlgQt9k4FzBg84+
 /FuqKC7gleuNS4lFCQtSN+yVGAlSW5F58h7vkaBuLmlZgW1PBgR/wWsIbxF0e76R7N3Cl8Bt64kPa
 C2A4xQoLFeFXMsZB0GldGEuFjXvYFL16EGyKKHKMHfDwrSavjvhUvuzDGAZd7G675WWg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fmP2e//yea3APB1C6lTRUvVUmEWyLeY2tUoYln3P0Eg=; b=GMIRydWb5oW5Ox453rdQRlWIaA
 I7MLir/3tQRoPMynqd/Ac1av4e43ufnBbTe3Gaip7J/M26V8/i4aiBu70HdScN5Iw63AIOBBt9FaY
 1pn6KNjRYeNJeL3neH+a0gXEsfP1Ob/61vIlXWZa8htsnFSjJzIFmlZh6fRALoLituy0=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOGl6-000000006q5-0bhZ for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:49:14 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so2225721f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 07:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793720945; x=1794325745; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fmP2e//yea3APB1C6lTRUvVUmEWyLeY2tUoYln3P0Eg=;
 b=HckrJOIbXutEfGuBhgsARUvpHwGTuyoDd6DA+ACnW7UzFODibCvu75BP43IogCRr3r
 vBif1KuauupqsPdop2aHI3pBUKqgTUZ3fmBSp3oHSRjo0vV8XpBMGUHEazFNfd9JEwmq
 /4FAV4xCM/SvKQxi1bUtWOcePqFFIpDHmoPoltKB2qUkO6MdBnV47AqQPPPu3vOqEtNa
 UDP3hItjZb8mPNeAsxc4v2gIhKfS+GGrOaYA80BOEGIwN3KnSb3DNyz/qunzqkPxdbtN
 OnTktX7rGBpLaLGKlJ/2KyVB0hUNmtpvVQD/rgkfyGwUpat7XftD25tBTGIcCbJqwPv3
 f1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793720945; x=1794325745;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fmP2e//yea3APB1C6lTRUvVUmEWyLeY2tUoYln3P0Eg=;
 b=GnKAf7wdRmdJH64W63i5JKrlDMTIgF9g3CWXYGoVcpCWvEw3YBLWqY2jPF7Rh35yyG
 TDrNhhtbgVqKrGh8TVlxxUXZfXeKgXhTAn6ElPaF8ElIxwez/kJzcLcOZWKc2mG4mz3K
 O/CG5xd9OSolifqlmWMfKCIIzPSs4Qiutuj1k02rud/GVju3OF6k4w4kCnv0u2Ao1x9q
 +lWshi/+zPiH0y64vIZOn7stO/coeaLl1xbFGGU9fJUSUbK+mMZQONrhlN9M+X6XwFLF
 4mKtJv5BcNWh6LfShHUuo8dme72fTvNOCkPoabEqG7sf/Tie9IS91JlwiD+KweFUrXmV
 DtAA==
X-Gm-Message-State: APuU4Z9aHhTod7VDqH2xLBYJAJ+bnKoiYuPk33tD/lQd8bBItGAubFTe
 SsjWLIbTppojlNbEwV9j0LgLacw7VoKO3lChCNyuSpxFCnHrrCoFkMvnUaE7MhkR3wDjyXb4QLt
 nPYGKNRYFoqOiJFAfcgi0gbdnaGYLB+Lsu6yuyVDeeFEB/6ngpqLclDNhiJPJW2UJ3JmE
X-Gm-Gg: AYBFou1PMeKMU/fUq/vo0U2bZPnIvu/JJXcH+WGUxTJWI14lsfgMje8LyV3ZtpmZHKZ
 rgL+SDPdAxElSXkO/JHF3Nb5nGmFArQ2GJMFsgQ0w0dXyM1PMTUIRkMofqKOhP/R3vYrs5egVnq
 GEn+5k8Wn7hOfOo2ZIgmTyq9tNWLtMtX1xAKPEM0wTBznIlocWOtNGfDlnYZdpU9S/OfpFb3IhK
 B/4gvoIhMYftS6HIdahM3Y3Vgnq4rkpwF3tX75nqOWEcbFeIyBAYaZ/WuEwl2YW5OKRJsE/yYWn
 oer4MGZM7VQbiRdqZWwwst7kmfSGOavQyBdn3b+VzDVPr1cL+eTxKXNZ2X+GAXvs0QR/SchXzr1
 BAzHiwrZhpMPdLGDTlJVSWyof6g774vp6snGcfTfJavqXY1EI+dnmIOtnVJP/1xcIqBGzAK2/Bn
 /BZuDqDOHVp4jLJTRjjBlJehaNkWl9Qjv0obT/rJpvSBvP3Pl2GCbCJ2gagOoj3nsDulxgRaaX9
 dzMBrh3vC5vt69AyiAG6+jfnbCcV8ei/RiJeh9YwefnT4THZh9v11zmI5IZQKr2fITyBWaRDrl9
 vFvKAZcZq4DGs4tEOol+Bq0ZCi1jMPLrhLR09NYHbIoOMO/ASa3jku4ykuWGr3fuaJlrihuSm2y
 /pd4l4UPKWm8GR8141TaZIqMEgtY6goeFCVRl6CkSr6DgrY5W+VkAxPT0y09vEj/+vLlUsNrCZZ
 xIKbmxwa2ppjSUjA==
X-Received: by 2002:a05:6000:240e:b0:48e:76ab:78f7 with SMTP id
 ffacd0b85a97d-48e76ab7f2bmr23189894f8f.20.1793720945177; 
 Tue, 03 Nov 2026 07:49:05 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80eb1sm27431399f8f.34.2026.11.03.07.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 07:49:04 -0800 (PST)
X-Google-Original-From: "Ralf Lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 15:49:03 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22
X-Gerrit-Change-Number: 1860
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1860?usp=email>
X-Gerrit-Commit: 45fb330724493f03fbc54f182f6fea53283f1a5d
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 15:49:03 +0000
In-Reply-To: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
References: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzQ1NDE2MDAwLkllMjAyODk3MzdkNTAyYTI1ZWVkYzYwNjc3ZDNjMzUwZGRjM2IzYzIyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8c7145a50244d1e547f757167a92962b95917d84-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOGl6-000000006q5-0bhZ
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
From: "Ralf Lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Ralf Lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0014313942465233658=="
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0014313942465233658==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KXFj8nNDh1w="; charset=UTF-8

--KXFj8nNDh1w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Name of user not set #1=
000061=2E

Ralf Lici has posted comments on this change by Arne Schwabe=2E =
( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail )

Change sub=
ject: Add python scripts that demonstrate using the dpc1 ACC protocol
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5:

(=
1 comment)

Patchset:

PS5: 
Pasting here Sashiko's findings (the AI bot ac=
cidentally picked this patch for review):

```
Thank you for your contribut=
ion! Sashiko AI review found 5 potential issue(s) to consider:
- [Medium] s=
ample/management: inconsistent sync and awaited calls to queue_command()
- =
[Medium] sample/management: dpc_completed not reset or tracked per kid on R=
EAUTH
- [Medium] sample/management: missing omi_tools and protocol modules =
in demo scripts
- [Low] sample/management: DpcConnectedClient uses field() =
without @dataclass
- [Low] sample/management: non-executable mode 0644 and =
header errors in demo scripts
--

commit 62ec41043b0ac3e7de9a64fa8a8139f0cf=
01f720
Author: Arne Schwabe (Code Review) via Openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>

Change in openvpn[master]: Add python scripts t=
hat demonstrate using the dpc1 ACC protocol

This commit adds client and se=
rver Python demonstration scripts for the
OpenVPN management interface and =
the dpc1 app custom control protocol=2E

> diff --git a/sample/management/a=
cc_dpc1_client_demo=2Epy b/sample/management/acc_dpc1_client_demo=2Epy
> ne=
w file mode 100755
> index 0000000000000=2E=2E1ae074d5c31a9
> --- /dev/null=

> +++ b/sample/management/acc_dpc1_client_demo=2Epy
> @@ -0,0 +1,114 @@

[=
 =2E=2E=2E ]

> +# This implements a small demonstration of using the
> +# =
OpenVPN Access Server Management Interface (OMI) and an app Custom Control
=
> +# protocol (dpc1)=2E To use this use on the client use
> +
> +# --manage=
ment-client-auth
> +# --app-custom-control dpc1
> +# --management /path/to/=
acc_dpc1_client_demo=2Epy unix-script
> +
> +import base64
> +import json
>=
 +import logging
> +import platform
> +from asyncio import CancelledError, =
Future
> +
> +logging=2EbasicConfig()
> +
> +from omi_tools import run_main=
, start_management_protocol, ConnectData
> +from omi_client_protocol import=
 OMIClientProtocol

[Severity: Medium]
Are the omi_tools, omi_client_protoc=
ol, and omi_server_protocol modules
missing from this commit?

Neither samp=
le/management/ nor the rest of the repository contains
omi_tools=2Epy, omi_=
client_protocol=2Epy, or omi_server_protocol=2Epy, so running
either acc_dp=
c1_client_demo=2Epy or acc_dpc1_server_demo=2Epy fails immediately at
start=
up with ModuleNotFoundError=2E

[ =2E=2E=2E ]

> --- /dev/null
> +++ b/samp=
le/management/acc_dpc1_server_demo=2Epy
> @@ -0,0 +1,157 @@
> +#!/usr/bin/e=
nv python3
> +# Copyright (c) 2026 OpenVPN Inc <sales@openvpn=2Enet>
> +# C=
opyright (c) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
> +#
> +# Permission is=
 hereby granted, free of charge, to any person obtaining a copy
> +# of thi=
s software and associated documentation files (the "Software"), to deal
> +=
# in the Software without restriction, including without limitation the rig=
hts
> +# to use, copy, modify, merge, publish, distribute, sublicense, and/=
or sell
> +# copies of the Software, and to permit persons to whom the Soft=
ware is
> +# furnished to do so, subject to the following conditions:
> +#
=
> +# The above copyright notice and this permission notice shall be include=
d in all
> +# copies or substantial portions of the Software=2E
> +#
> +# T=
HE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>=
 +# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
> +# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT =
SHALL THE
> +# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGE=
S OR OTHER
> +# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERW=
ISE, ARISING FROM,
> +# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE US=
E OR OTHER DEALINGS IN THE
> +# SOFTWARE=2E
> +
> +#
> +#  You should have =
received a copy of the GNU General Public License along
> +#  with this pro=
gram; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
> +
> +# This impl=
ements a small demonstration of using the
> +# OpenVPN Access Server Manage=
ment Interface (OMI) and an app Custom Control
> +# protocol (dpc1)=2E To u=
se this use on the server
> +
> +# --management-client-auth
> +# --app-cust=
om-control dpc1
> +# --management /path/to/acc_dpc1_server_demo=2Epy unix-s=
cript

[Severity: Low]
Should sample/management/acc_dpc1_server_demo=2Epy b=
e committed with executable
file mode 100755 instead of 100644?

Because th=
e usage instructions specify running it via --management
/path/to/acc_dpc1_=
server_demo=2Epy unix-script, invoking it directly without
executable permi=
ssions fails with permission denied=2E

Also, in the headers of these two s=
cripts:
- acc_dpc1_server_demo=2Epy has a stray GNU General Public License =
paragraph
  immediately following the MIT license header=2E
- acc_dpc1_clie=
nt_demo=2Epy instructs passing --management-client-auth on the
  client, wh=
ich OpenVPN rejects because it is a server-only option=2E

[ =2E=2E=2E ]

>=
 +class DpcConnectedClient(ConnectedClient):
> +    # Remember the key-id t=
hat we authenticated
> +    dpc_completed: bool =3D False
> +    env: Dict[=
str, str] =3D field(default_factory=3Ddict)

[Severity: Low]
Is DpcConnecte=
dClient missing the @dataclass decorator?

In Python, a subclass is not pro=
cessed by the dataclasses module unless the
subclass itself is decorated wi=
th @dataclass=2E Without @dataclass on
DpcConnectedClient, env =3D field(de=
fault_factory=3Ddict) is not initialized to a
per-instance dict upon instan=
tiation and instead remains a raw
dataclasses=2EField descriptor object on =
the class until overwritten by
client_event_CONNECT() or client_event_REAUT=
H()=2E

> +
> +
> +class OmiDPCServerProtocol(OMIServerProtocol):
> +    de=
f __init__(self, finish_future: Future, connect_data: ConnectData):
> +    =
    super()=2E__init__(finish_future, connect_data)
> +        self=2E_conn=
ected_client_class =3D DpcConnectedClient
> +
> +    def receive_acc_client=
_dpc1(self, client: DpcConnectedClient, kid: int, acc_message: str):
> +   =
     print(f"Received DPC1 message: {acc_message!r}")
> +        msg =3D js=
on=2Eloads(acc_message)
> +        pprint(msg)
> +
> +        dpc_response =
=3D msg["dpc_response"]
> +        ver =3D dpc_response["ver"]
> +        i=
f ver !=3D "1=2E0":
> +            logger=2Eerror(f"Received unknown ACC pr=
otocol version: {ver}")
> +            return
> +
> +        client_info =
=3D dpc_response=2Eget("client_info", {})
> +        antivirus =3D "antivir=
us" in dpc_response
> +        disk_encryption =3D "disk_encryption" in dpc=
_response
> +
> +        logger=2Einfo(
> +            f"Received DPC1 resp=
onse: antivirus=3D{antivirus}, disk_encryption=3D{disk_encryption}, client_=
info=3D{client_info}")
> +
> +        # Normally here would be a check that=
 the response matches the policy
> +        # this demo script just allows =
everyone with a response to pass
> +        client=2Edpc_completed =3D True=

> +
> +        self=2Equeue_command(f"client-auth-nt {client=2Ecid} {kid}"=
)
> +
> +    async def dpc_request_timeout(self, client: DpcConnectedClient=
, kid: int, timeout: int):
> +        await asyncio=2Esleep(timeout)
> +   =
     if client=2Edpc_completed:
> +            return
> +
> +        client=
_deny =3D f'client-deny {client=2Ecid} {kid} "dpc1 timeout" "Timeout on dev=
ice posture"'
> +        await self=2Equeue_command(client_deny)

[Severity=
: Medium]
Should self=2Equeue_command() be called consistently as either a =
synchronous
method or an awaited coroutine across both scripts?

In OmiDPCS=
erverProtocol, check_client_posture(), dpc_request_timeout(), and
send_clie=
nt_deny_no_dpc1() all use await self=2Equeue_command(=2E=2E=2E):

    await=
 self=2Equeue_command(client_deny)

However, OmiDPCServerProtocol=2Ereceive=
_acc_client_dpc1() and
OmiDpc1ClientProtocol=2E_send_dpc1_client_info() (in=
 acc_dpc1_client_demo=2Epy)
are synchronous methods and call self=2Equeue_c=
ommand(=2E=2E=2E) without await:

    self=2Equeue_command(f"client-auth-nt=
 {client=2Ecid} {kid}")

    command =3D f"acc-msg\ndpc1\n6\n{b64msg}\nEND"=

    self=2Equeue_command(command)

If queue_command() is an async coroutin=
e, the unawaited calls in
receive_acc_client_dpc1() and _send_dpc1_client_i=
nfo() create coroutine
objects that are never executed, silently dropping b=
oth the client posture
response and the server client-auth-nt command=2E Co=
nversely, if queue_command()
is a regular synchronous function returning No=
ne, awaiting it in
check_client_posture(), dpc_request_timeout(), and send_=
client_deny_no_dpc1()
raises a TypeError at runtime=2E

> +
> +    def clie=
nt_event_ESTABLISHED(self, client: DpcConnectedClient, kid: int, env: dict,=
 extra: str):
> +        print(f"CLient connected: {client}")
> +
> +    as=
ync def send_client_deny_no_dpc1(self, client: DpcConnectedClient, kid: int=
):
> +        client_reason =3D "ACC[protocol dpc1]: To connect to this ser=
ver you " \
> +                        "need to upgrade to a client that su=
pports the " \
> +                        "OpenVPN Inc device posture proto=
col and has it " \
> +                        "enabled, e=2Eg=2E OpenVPN fo=
r Android, openvpn3-linux, " \
> +                        "or OpenVPN Conne=
ct"
> +        client_deny =3D f'client-deny {client=2Ecid} {kid} "no dpc1 =
support" "{client_reason}"'
> +        await self=2Equeue_command(client_de=
ny)
> +
> +    def client_event_CONNECT(self, client: DpcConnectedClient, k=
id: int, env: dict, extra: str):
> +        print(f"Authenticating client {=
client}, {kid}, protos: {client=2Eacc_negotiated_protocols}")
> +        cl=
ient=2Eenv =3D env
> +        asyncio=2Ecreate_task(self=2Echeck_client_pos=
ture(client, kid))
> +
> +    def client_event_REAUTH(self, client: DpcConn=
ectedClient, kid: int, env: dict, extra: str):
> +        print(f"Re-authen=
ticating client {client}, {kid}, protos: {client=2Eacc_negotiated_protocols=
}")
> +        client=2Eenv =3D env
> +        # Check client posture again=
 on renegotiation
> +        asyncio=2Ecreate_task(self=2Echeck_client_post=
ure(client, kid))
> +
> +    async def check_client_posture(self, client: D=
pcConnectedClient, kid: int):
> +        await self=2Equeue_command(
> +   =
         f"client-pending-auth {client=2Ecid} {kid} \"NOTIFY::Checking your=
 device posture, please wait\" 180")
> +
> +        await self=2Equeue_comm=
and(f"client-pending-auth {client=2Ecid} {kid} ACC 180")
> +        # In th=
is example we wait for 20 seconds to simulate a posture check on the server=

> +        await asyncio=2Esleep(20)
> +
> +        if "dpc1" not in clien=
t=2Eacc_negotiated_protocols:
> +            await self=2Esend_client_deny_=
no_dpc1(client, kid)
> +            return
> +
> +        dpc_cmd =3D {"dpc=
_request": {"ver": "1=2E0", "correlation_id": "n/a", "timestamp": "yesterda=
y", "client_info": True,
> +                                   "disk_encryp=
tion": {"full": True}, "antivirus": {}}}
> +
> +        dpc_cmd_str =3D jso=
n=2Edumps(dpc_cmd)
> +        acc_protocol =3D "dpc1"
> +
> +        await =
self=2Esend_acc_msg(client, kid, acc_protocol, dpc_cmd_str=2Eencode())
> + =
       asyncio=2Ecreate_task(self=2Edpc_request_timeout(client, kid, 60))

=
[Severity: Medium]
Does keeping a single boolean client=2Edpc_completed wit=
hout resetting it or
tracking the key-id break posture timeouts on renegoti=
ation?

When a client connects via client_event_CONNECT() and responds to t=
he initial
posture check, receive_acc_client_dpc1() sets:

    client=2Edpc=
_completed =3D True

When the client later renegotiates via client_event_RE=
AUTH() with a new kid,
check_client_posture() is spawned without resetting =
client=2Edpc_completed, and
schedules dpc_request_timeout(client, kid, 60)=
=2E If the client never responds
to the renegotiation posture request, dpc_=
request_timeout() sees
client=2Edpc_completed is still True from the initia=
l connection and returns
early without sending client-deny=2E

In addition,=
 because posture completion is not tracked per kid and the tasks
created wi=
th asyncio=2Ecreate_task() in client_event_CONNECT(),
client_event_REAUTH()=
, and check_client_posture() are not tracked or canceled,
overlapping postu=
re checks or unsolicited responses during the 20-second delay
in check_clie=
nt_posture() can race on client=2Edpc_completed=2E

-- 
Sashiko AI review =
=C2=B7 https://sashiko=2Edev/#/patchset/24699879debec5f95ada94bb416c09306a5=
2b09c-EmailReplacePatchSet-HTML@gerrit=2Eopenvpn=2Enet?part=3D1
```



-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie20289737d502a25eedc606=
77d3c350ddc3b3c22
Gerrit-Change-Number: 1860
Gerrit-PatchSet: 5
Gerrit-Owne=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Name of user not se=
t #1000061
Gerrit-CC: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Name of us=
er not set #1000061
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-Comment-Date: Tue, 03 Nov 2026 15:49:03 +0000
Gerrit-HasComment=
s: Yes
Gerrit-Has-Labels: No

--KXFj8nNDh1w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Name of user not set #1000061=2E </p>
<=
p>Ralf Lici has posted comments on this change by Arne Schwabe=2E</p><p><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1860?tab=3Dcomments&amp;usp=3Demail">Patch Set #5:</a> </p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Pasting her=
e Sashiko&#39;s findings (the AI bot accidentally picked this patch for rev=
iew):</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">``` Thank you for your contribution! Sashiko AI review found 5 po=
tential issue(s) to consider:</p><ul class=3D"blocks"><li>[Medium] sample/m=
anagement: inconsistent sync and awaited calls to queue_command()</li><li>[=
Medium] sample/management: dpc_completed not reset or tracked per kid on RE=
AUTH</li><li>[Medium] sample/management: missing omi_tools and protocol mod=
ules in demo scripts</li><li>[Low] sample/management: DpcConnectedClient us=
es field() without @dataclass</li><li>[Low] sample/management: non-executab=
le mode 0644 and header errors in demo scripts</li><li>-</li></ul><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">commit =
62ec41043b0ac3e7de9a64fa8a8139f0cf01f720<br>Author: Arne Schwabe (Code Revi=
ew) via Openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;</p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">C=
hange in openvpn[master]: Add python scripts that demonstrate using the dpc=
1 ACC protocol</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-=
wrap: break-word;">This commit adds client and server Python demonstration =
scripts for the<br>OpenVPN management interface and the dpc1 app custom con=
trol protocol=2E</p><blockquote class=3D"blocks" style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;"><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">diff --git a/sample/manageme=
nt/acc_dpc1_client_demo=2Epy b/sample/management/acc_dpc1_client_demo=2Epy<=
br>new file mode 100755<br>index 0000000000000=2E=2E1ae074d5c31a9<br>--- /d=
ev/null<br>+++ b/sample/management/acc_dpc1_client_demo=2Epy<br>@@ -0,0 +1,=
114 @@</p></blockquote><p class=3D"blocks" style=3D"white-space: pre-wrap; =
word-wrap: break-word;">[ =2E=2E=2E ]</p><blockquote class=3D"blocks" style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">+# This=
 implements a small demonstration of using the<br>+# OpenVPN Access Server =
Management Interface (OMI) and an app Custom Control<br>+# protocol (dpc1)=
=2E To use this use on the client use<br>+<br>+# --management-client-auth<b=
r>+# --app-custom-control dpc1<br>+# --management /path/to/acc_dpc1_client_=
demo=2Epy unix-script<br>+<br>+import base64<br>+import json<br>+import log=
ging<br>+import platform<br>+from asyncio import CancelledError, Future<br>=
+<br>+logging=2EbasicConfig()<br>+<br>+from omi_tools import run_main, star=
t_management_protocol, ConnectData<br>+from omi_client_protocol import OMIC=
lientProtocol</p></blockquote><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">[Severity: Medium]<br>Are the omi_tools, omi=
_client_protocol, and omi_server_protocol modules<br>missing from this comm=
it?</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Neither sample/management/ nor the rest of the repository contains<=
br>omi_tools=2Epy, omi_client_protocol=2Epy, or omi_server_protocol=2Epy, s=
o running<br>either acc_dpc1_client_demo=2Epy or acc_dpc1_server_demo=2Epy =
fails immediately at<br>startup with ModuleNotFoundError=2E</p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">[ =2E=2E=2E=
 ]</p><blockquote class=3D"blocks" style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;"><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">--- /dev/null<br>+++ b/sample/management/a=
cc_dpc1_server_demo=2Epy<br>@@ -0,0 +1,157 @@<br>+#!/usr/bin/env python3<br=
>+# Copyright (c) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;<br>+# Copyri=
ght (c) 2026 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>+#<br>+# Permission=
 is hereby granted, free of charge, to any person obtaining a copy<br>+# of=
 this software and associated documentation files (the &quot;Software&quot;=
), to deal<br>+# in the Software without restriction, including without lim=
itation the rights<br>+# to use, copy, modify, merge, publish, distribute, =
sublicense, and/or sell<br>+# copies of the Software, and to permit persons=
 to whom the Software is<br>+# furnished to do so, subject to the following=
 conditions:<br>+#<br>+# The above copyright notice and this permission not=
ice shall be included in all<br>+# copies or substantial portions of the So=
ftware=2E<br>+#<br>+# THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT W=
ARRANTY OF ANY KIND, EXPRESS OR<br>+# IMPLIED, INCLUDING BUT NOT LIMITED TO=
 THE WARRANTIES OF MERCHANTABILITY,<br>+# FITNESS FOR A PARTICULAR PURPOSE =
AND NONINFRINGEMENT=2E IN NO EVENT SHALL THE<br>+# AUTHORS OR COPYRIGHT HOL=
DERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER<br>+# LIABILITY, WHETHER IN =
AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,<br>+# OUT OF OR IN =
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE<br>+# SOFT=
WARE=2E<br>+<br>+#<br>+#  You should have received a copy of the GNU Genera=
l Public License along<br>+#  with this program; if not, see &lt;https://ww=
w=2Egnu=2Eorg/licenses/&gt;=2E<br>+<br>+# This implements a small demonstra=
tion of using the<br>+# OpenVPN Access Server Management Interface (OMI) an=
d an app Custom Control<br>+# protocol (dpc1)=2E To use this use on the ser=
ver<br>+<br>+# --management-client-auth<br>+# --app-custom-control dpc1<br>=
+# --management /path/to/acc_dpc1_server_demo=2Epy unix-script</p></blockqu=
ote><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">[Severity: Low]<br>Should sample/management/acc_dpc1_server_demo=2Epy =
be committed with executable<br>file mode 100755 instead of 100644?</p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Bec=
ause the usage instructions specify running it via --management<br>/path/to=
/acc_dpc1_server_demo=2Epy unix-script, invoking it directly without<br>exe=
cutable permissions fails with permission denied=2E</p><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Also, =
in the headers of these two scripts:<br>- acc_dpc1_server_demo=2Epy has a s=
tray GNU General Public License paragraph<br>  immediately following the MI=
T license header=2E<br>- acc_dpc1_client_demo=2Epy instructs passing --mana=
gement-client-auth on the<br>  client, which OpenVPN rejects because it is =
a server-only option=2E</pre><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">[ =2E=2E=2E ]</p><blockquote class=3D"blocks"=
 style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">+=
class DpcConnectedClient(ConnectedClient):<br>+    # Remember the key-id th=
at we authenticated<br>+    dpc_completed: bool =3D False<br>+    env: Dict=
[str, str] =3D field(default_factory=3Ddict)</p></blockquote><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">[Severity: Lo=
w]<br>Is DpcConnectedClient missing the @dataclass decorator?</p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">In Pyth=
on, a subclass is not processed by the dataclasses module unless the<br>sub=
class itself is decorated with @dataclass=2E Without @dataclass on<br>DpcCo=
nnectedClient, env =3D field(default_factory=3Ddict) is not initialized to =
a<br>per-instance dict upon instantiation and instead remains a raw<br>data=
classes=2EField descriptor object on the class until overwritten by<br>clie=
nt_event_CONNECT() or client_event_REAUTH()=2E</p><blockquote class=3D"bloc=
ks" style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">+<br>+<br>+class OmiDPCServerProtocol(OMIServerProtocol):<br>+    def __i=
nit__(self, finish_future: Future, connect_data: ConnectData):<br>+        =
super()=2E__init__(finish_future, connect_data)<br>+        self=2E_connect=
ed_client_class =3D DpcConnectedClient<br>+<br>+    def receive_acc_client_=
dpc1(self, client: DpcConnectedClient, kid: int, acc_message: str):<br>+   =
     print(f&quot;Received DPC1 message: {acc_message!r}&quot;)<br>+       =
 msg =3D json=2Eloads(acc_message)<br>+        pprint(msg)<br>+<br>+       =
 dpc_response =3D msg[&quot;dpc_response&quot;]<br>+        ver =3D dpc_res=
ponse[&quot;ver&quot;]<br>+        if ver !=3D &quot;1=2E0&quot;:<br>+     =
       logger=2Eerror(f&quot;Received unknown ACC protocol version: {ver}&q=
uot;)<br>+            return<br>+<br>+        client_info =3D dpc_response=
=2Eget(&quot;client_info&quot;, {})<br>+        antivirus =3D &quot;antivir=
us&quot; in dpc_response<br>+        disk_encryption =3D &quot;disk_encrypt=
ion&quot; in dpc_response<br>+<br>+        logger=2Einfo(<br>+            f=
&quot;Received DPC1 response: antivirus=3D{antivirus}, disk_encryption=3D{d=
isk_encryption}, client_info=3D{client_info}&quot;)<br>+<br>+        # Norm=
ally here would be a check that the response matches the policy<br>+       =
 # this demo script just allows everyone with a response to pass<br>+      =
  client=2Edpc_completed =3D True<br>+<br>+        self=2Equeue_command(f&q=
uot;client-auth-nt {client=2Ecid} {kid}&quot;)<br>+<br>+    async def dpc_r=
equest_timeout(self, client: DpcConnectedClient, kid: int, timeout: int):<b=
r>+        await asyncio=2Esleep(timeout)<br>+        if client=2Edpc_compl=
eted:<br>+            return<br>+<br>+        client_deny =3D f&#39;client-=
deny {client=2Ecid} {kid} &quot;dpc1 timeout&quot; &quot;Timeout on device =
posture&quot;&#39;<br>+        await self=2Equeue_command(client_deny)</p><=
/blockquote><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">[Severity: Medium]<br>Should self=2Equeue_command() be called =
consistently as either a synchronous<br>method or an awaited coroutine acro=
ss both scripts?</p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">In OmiDPCServerProtocol, check_client_posture(), dpc_r=
equest_timeout(), and<br>send_client_deny_no_dpc1() all use await self=2Equ=
eue_command(=2E=2E=2E):</p><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">    await self=2Equeue_command(cli=
ent_deny)</pre><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">However, OmiDPCServerProtocol=2Ereceive_acc_client_dpc1() a=
nd<br>OmiDpc1ClientProtocol=2E_send_dpc1_client_info() (in acc_dpc1_client_=
demo=2Epy)<br>are synchronous methods and call self=2Equeue_command(=2E=2E=
=2E) without await:</p><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">    self=2Equeue_command(f&quot;client=
-auth-nt {client=2Ecid} {kid}&quot;)</pre><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">    command =3D f&q=
uot;acc-msg\ndpc1\n6\n{b64msg}\nEND&quot;<br>    self=2Equeue_command(comma=
nd)</pre><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">If queue_command() is an async coroutine, the unawaited calls in<=
br>receive_acc_client_dpc1() and _send_dpc1_client_info() create coroutine<=
br>objects that are never executed, silently dropping both the client postu=
re<br>response and the server client-auth-nt command=2E Conversely, if queu=
e_command()<br>is a regular synchronous function returning None, awaiting i=
t in<br>check_client_posture(), dpc_request_timeout(), and send_client_deny=
_no_dpc1()<br>raises a TypeError at runtime=2E</p><blockquote class=3D"bloc=
ks" style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">+<br>+    def client_event_ESTABLISHED(self, client: DpcConnectedClient, =
kid: int, env: dict, extra: str):<br>+        print(f&quot;CLient connected=
: {client}&quot;)<br>+<br>+    async def send_client_deny_no_dpc1(self, cli=
ent: DpcConnectedClient, kid: int):<br>+        client_reason =3D &quot;ACC=
[protocol dpc1]: To connect to this server you &quot; \<br>+               =
         &quot;need to upgrade to a client that supports the &quot; \<br>+ =
                       &quot;OpenVPN Inc device posture protocol and has it=
 &quot; \<br>+                        &quot;enabled, e=2Eg=2E OpenVPN for A=
ndroid, openvpn3-linux, &quot; \<br>+                        &quot;or OpenV=
PN Connect&quot;<br>+        client_deny =3D f&#39;client-deny {client=2Eci=
d} {kid} &quot;no dpc1 support&quot; &quot;{client_reason}&quot;&#39;<br>+ =
       await self=2Equeue_command(client_deny)<br>+<br>+    def client_even=
t_CONNECT(self, client: DpcConnectedClient, kid: int, env: dict, extra: str=
):<br>+        print(f&quot;Authenticating client {client}, {kid}, protos: =
{client=2Eacc_negotiated_protocols}&quot;)<br>+        client=2Eenv =3D env=
<br>+        asyncio=2Ecreate_task(self=2Echeck_client_posture(client, kid)=
)<br>+<br>+    def client_event_REAUTH(self, client: DpcConnectedClient, ki=
d: int, env: dict, extra: str):<br>+        print(f&quot;Re-authenticating =
client {client}, {kid}, protos: {client=2Eacc_negotiated_protocols}&quot;)<=
br>+        client=2Eenv =3D env<br>+        # Check client posture again o=
n renegotiation<br>+        asyncio=2Ecreate_task(self=2Echeck_client_postu=
re(client, kid))<br>+<br>+    async def check_client_posture(self, client: =
DpcConnectedClient, kid: int):<br>+        await self=2Equeue_command(<br>+=
            f&quot;client-pending-auth {client=2Ecid} {kid} \&quot;NOTIFY::=
Checking your device posture, please wait\&quot; 180&quot;)<br>+<br>+      =
  await self=2Equeue_command(f&quot;client-pending-auth {client=2Ecid} {kid=
} ACC 180&quot;)<br>+        # In this example we wait for 20 seconds to si=
mulate a posture check on the server<br>+        await asyncio=2Esleep(20)<=
br>+<br>+        if &quot;dpc1&quot; not in client=2Eacc_negotiated_protoco=
ls:<br>+            await self=2Esend_client_deny_no_dpc1(client, kid)<br>+=
            return<br>+<br>+        dpc_cmd =3D {&quot;dpc_request&quot;: {=
&quot;ver&quot;: &quot;1=2E0&quot;, &quot;correlation_id&quot;: &quot;n/a&q=
uot;, &quot;timestamp&quot;: &quot;yesterday&quot;, &quot;client_info&quot;=
: True,<br>+                                   &quot;disk_encryption&quot;:=
 {&quot;full&quot;: True}, &quot;antivirus&quot;: {}}}<br>+<br>+        dpc=
_cmd_str =3D json=2Edumps(dpc_cmd)<br>+        acc_protocol =3D &quot;dpc1&=
quot;<br>+<br>+        await self=2Esend_acc_msg(client, kid, acc_protocol,=
 dpc_cmd_str=2Eencode())<br>+        asyncio=2Ecreate_task(self=2Edpc_reque=
st_timeout(client, kid, 60))</p></blockquote><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">[Severity: Medium]<br>Does ke=
eping a single boolean client=2Edpc_completed without resetting it or<br>tr=
acking the key-id break posture timeouts on renegotiation?</p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">When a clien=
t connects via client_event_CONNECT() and responds to the initial<br>postur=
e check, receive_acc_client_dpc1() sets:</p><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">    client=2Edpc_=
completed =3D True</pre><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">When the client later renegotiates via client_even=
t_REAUTH() with a new kid,<br>check_client_posture() is spawned without res=
etting client=2Edpc_completed, and<br>schedules dpc_request_timeout(client,=
 kid, 60)=2E If the client never responds<br>to the renegotiation posture r=
equest, dpc_request_timeout() sees<br>client=2Edpc_completed is still True =
from the initial connection and returns<br>early without sending client-den=
y=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">In addition, because posture completion is not tracked per kid and=
 the tasks<br>created with asyncio=2Ecreate_task() in client_event_CONNECT(=
),<br>client_event_REAUTH(), and check_client_posture() are not tracked or =
canceled,<br>overlapping posture checks or unsolicited responses during the=
 20-second delay<br>in check_client_posture() can race on client=2Edpc_comp=
leted=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">-- <br>Sashiko AI review =C2=B7 https://sashiko=2Edev/#/patchs=
et/24699879debec5f95ada94bb416c09306a52b09c-EmailReplacePatchSet-HTML@gerri=
t=2Eopenvpn=2Enet?part=3D1<br>```</p></li></ul></li></ul><p>To view, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail">cha=
nge 1860</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1860 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 5 </div>
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
<div style=3D"displa=
y:none"> Gerrit-Comment-Date: Tue, 03 Nov 2026 15:49:03 +0000 </div>
<div s=
tyle=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display=
:none"> Gerrit-Has-Labels: No </div>

</body></html>
--KXFj8nNDh1w=--


--===============0014313942465233658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0014313942465233658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0014313942465233658==--

