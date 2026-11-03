Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322C2606A326
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Lo/cwPOB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LuO4GFW4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=G2kjdxiW;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LfGLz0xo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QnH7s5WWGtSFKgjdt2QUunHxh7Fcomkb6VvwneQyJbg=; b=Lo/cwPOB0jItGf2khsADFjYCzA
	Wr0s5qZGCHYEiay36QthIlgIbsqBJb8e40QytBaq9+Nw7mBc8lLtz8RcXt5tysVeiK1BaP4MoEvhJ
	yXaMAcqs+S+5qJo2eLTlVGsoZ8tvCxZ/3JERf0n9M8aMx8sNer3QsSACZWwuMbBc4/g4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOGk5-000000006DB-0ZZe;
	Tue, 03 Nov 2026 15:48:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOGk3-000000006D4-2Wz4
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:48:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t0gqmiIvIy+ghkqbxFkxw3a/8mvItibeaSZaQIY53EE=; b=LuO4GFW4kBgK8kFZTT1wTxarH3
 dveh1JS1TzDuimUYjWedyiH3kc2Wt7iu3BB1Ypw8KjsIDVC6evet9OYc8NAsibUFi+/LZmjkJJIoZ
 Ra4q/nbj4v0fIhHDwAUFx+DpqDutBxd8FnqtN8UcRUwdJJuDbVnV7WVXgWUX3X/1djJc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t0gqmiIvIy+ghkqbxFkxw3a/8mvItibeaSZaQIY53EE=; b=G2kjdxiWH+805woaYrepYtK2gh
 sNw+GEi9kBO+XN1naGW+fHIoCD7vxi9GYGdm6w1+DeyVtsLMK/9LlcGJBzUl2Ft4YTGv/bMx1gY1D
 m63Qp9wJggB4YoGNNOA4U7u4h4ux8DuBfgFz3U4eUOGsErNTVkVEfCAq6zwixTLXaV7Q=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOGk1-000000006ow-0ytI for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:48:07 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so5485475e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 07:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793720879; x=1794325679; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=t0gqmiIvIy+ghkqbxFkxw3a/8mvItibeaSZaQIY53EE=;
 b=LfGLz0xoCZ2Syy87+zropSuFfeRBLbLjbsX5iEWdq+VoHr2LTisKo5Ptvqkl4Wxqms
 R/m7DDScs37e07zR/98M5og9454oia77nLsj2ORC+yL67GTJKM2HSX9qTgOXjLFMDrjN
 wpY2dTbSONWjugLM9pVudP16Iv/si2ElgLzb7He3KME0G+Nlrph3OPkuK6he44bHkpRG
 HXzWzIKb3fLyVlUuvT8uFnSwwJzS97BotqzHlqqLrT35q1GZMCeNy1KQXUFtVRiRxRUg
 sb0D7oX9vTWWeV11k3iREYcoD7wbKcOT681panMlI8X8YrGNqxsMMcKqbKaNN3U/7JNj
 yBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793720879; x=1794325679;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=t0gqmiIvIy+ghkqbxFkxw3a/8mvItibeaSZaQIY53EE=;
 b=1vT+ukei/wlezbKaYbhThb40KlMd9TqkZIKaS81KurlSIq5FWeooQ2IMpsgGBNDMnr
 +PUi0nyiLRScHwciQ68iLXZLPA8aitXMer9Ux+6Pjpm/HBfeHYlc5awKFk1p45UrxGDG
 DtD3enursCNV0fNrLymHwbCBin103A2Y98IwUqBDtlKjMHwavaVi8Qmi0gdiVn8TxZeq
 LtTE/759vZokezmMNiezepXKYMeTeiD02VMYI7In3GTR0ipxrpm9Vu38crxq7vYgeDUI
 HtKX4eTEv0Qid8DAUj4lIiMH4JSUFWhiL7Vf42T5MfpMrCNbK6prkBnyUFFUgddN71gZ
 f1XQ==
X-Gm-Message-State: APuU4Z/YrK4hVeVDCk/6oCUt0/LouDgfJ3pVVLicA34m3hyv8HPANlBy
 /t01eeubbGrroZF4sERu9glHvgZlLJlxjiJ+fGk669fQrZE2QEjHujuVaH4UcmFjxD2Wn8sT+5h
 pHfYU+RgMakV9jxJ8MWR23CQHIsRcuP57p8pPrlAtVLUPbRgCBMSGVixpQwD5eLdwW8ND
X-Gm-Gg: AYBFou0F08/WcG9GnW62GhCXSls/BY+zB8uy86ubnAlaBhwzvKgLcBFhAVWAwg0QoMc
 TANwGPE1saa6a7VNkomn48U1Px7/oXquysd/NsKKoYvAQiaP1565aEqHL81MIaM0VEi/uN3uTyt
 OVuM1pWaEzeTSXlmRG1fjM8iPh8J8KeHNz4sVRhXhqiA1/8Rr9DXzWIS8OqNcBYfUZoaYioVUYN
 1Aq7TGLS8eZWZobbx++7dh1RB2vo0yM5zRhrdTNRGNiTl39Wn25j9TowcUsTG7GnXK48AQbRHJG
 jCxsYjV1t4tp7F3poRIBCLMA4oFMwZ6hVF6/cHXRxujp0iuRJ9Vya0lzXUb9Xn5nOYLn15JlXoJ
 R9RGQuea/cfSvXxG30K+yqT8AVHowovLgr6HdKc81MCQYQNuLXmybyzgn2P7DWxXmF9yMBinWlf
 ggEPp2i45q/oTFMrd/GP0a1YMkMXeunsQVgcJ0vONSyu1oU++O78nwbcjMtz97Te5rDkYH9vtQk
 gXfssNyElmhr7Hv2RiBWSAasAdRY+NVbTzhmcYBnVpUjfDKUuc7olbr+WS/qrhQ2in2mDbqDOLT
 lGV/K2C7Tn0W4dJkhfYYUUJ24Xkh4LvEVZZKGiEHQVbv+iz9CSEL/PUpTd5Xtb/p9ttXzvbxK9H
 fvHbGIe7DWmIZpDCqAXBjyXZy5L2nraTpk6PXCRRmwjwvP1JLUAOG1KqsjT+pZhGI4bemkkDWKX
 tyR/xcFDjyIAlRDl8NMC31XSUbGP7BOCru5SQ=
X-Received: by 2002:a05:600c:8116:b0:4a0:20b4:ba93 with SMTP id
 5b1f17b1804b1-4ac17e10724mr311151255e9.16.1793720878370; 
 Tue, 03 Nov 2026 07:47:58 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09bcc967sm262763255e9.3.2026.11.03.07.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 07:47:57 -0800 (PST)
X-Google-Original-From: "Ralf Lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 15:47:56 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4
X-Gerrit-Change-Number: 2037
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2037?usp=email>
X-Gerrit-Commit: 4a23150505228078a7fcc42382596d377ea766f8
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 15:47:56 +0000
In-Reply-To: <gerrit.1793043747000.I695967524bb9e83887b8c07d0d09baff6e41acf4@gerrit.openvpn.net>
References: <gerrit.1793043747000.I695967524bb9e83887b8c07d0d09baff6e41acf4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDQzNzQ3MDAwLkk2OTU5Njc1MjRiYjllODM4ODdiOGMwN2QwZDA5YmFmZjZlNDFhY2Y0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <42e09b7376f667375c3a29f67b90b9d7344ae822-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOGk1-000000006ow-0ytI
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add python scripts
 that demonstrate the ACC protocol
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
Content-Type: multipart/mixed; boundary="===============0305732587538470164=="
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0305732587538470164==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2aP0sQiFCs4="; charset=UTF-8

--2aP0sQiFCs4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Name of user not set #1=
000061=2E

Ralf Lici has posted comments on this change by Arne Schwabe=2E =
( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail )

Change sub=
ject: Add python scripts that demonstrate the ACC protocol
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4:

(1 comment)

=
Patchset:

PS4: 
Pasting here Sashiko's findings (the AI bot accidentally p=
icked this patch for review):

```
Thank you for your contribution! Sashiko=
 AI review found 4 potential issue(s) to consider:
- [High] sample/manageme=
nt: undefined DpcConnectedClient in client_event_REAUTH()
- [Medium] sample=
/management: unhandled OSError from os=2Egetlogin() in send_info_response()=

- [Medium] sample/management: leaked child process on timeout in get_route=
s()
- [Low] sample/management: unused socket import and truncated comment i=
n client demo
--

commit 59f0e39cb91ec113a14b2f7981e12a71495246d9
Author: A=
rne Schwabe (Code Review) via Openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>

Change in openvpn[master]: Add python scripts that demonstrate =
the ACC protocol

This commit adds client and server Python demonstration s=
cripts for the
OpenVPN management interface that implement the sys_info app=
 custom control
(ACC) protocol to query client system details from the serv=
er=2E

> diff --git a/sample/management/acc_sysinfo_client_demo=2Epy b/samp=
le/management/acc_sysinfo_client_demo=2Epy
> new file mode 100755
> index 0=
000000000000=2E=2E99e994e6fd3f1
> --- /dev/null
> +++ b/sample/management/a=
cc_sysinfo_client_demo=2Epy
> @@ -0,0 +1,150 @@

[ =2E=2E=2E ]

> +import o=
s
> +import platform
> +import socket
> +import subprocess
> +from asyncio =
import CancelledError

[ =2E=2E=2E ]

> +class OmiSysInfoClientProtocol(OMI=
ClientProtocol):
> +    def __init__(self, finish_future, connect_data: Con=
nectData):
> +        super()=2E__init__(finish_future, connect_data)
> +
>=
 +
> +    def receive_acc_sys_info(self, acc_message):
> +        print(f"R=
eceived sys_info message: {acc_message!r}")
> +
> +        logger=2Edebug(f=
"Received sys_info message: {acc_message!r}")
> +        msg =3D json=2Eloa=
ds(acc_message)
> +
> +        asyncio=2Ecreate_task(self=2Esend_info_respo=
nse(msg))
> +
> +    async def send_info_response(self, msg):
> +        re=
sponse =3D {}
> +        if msg=2Eget("uname", False):
> +            respo=
nse['uname'] =3D platform=2Euname()=2E_asdict()
> +
> +        if msg=2Eget=
("username", False):
> +            response['username'] =3D os=2Egetlogin(=
)

[Severity: Medium]
When OpenVPN spawns acc_sysinfo_client_demo=2Epy via =
--management =2E=2E=2E
unix-script or runs in a daemon, service, or contain=
er environment without a
controlling terminal, won't os=2Egetlogin() in
Omi=
SysInfoClientProtocol=2Esend_info_response() raise an unhandled OSError?

B=
ecause OmiSysInfoClientProtocol=2Ereceive_acc_sys_info() schedules
send_inf=
o_response() as a background task via asyncio=2Ecreate_task(), an
uncaught =
OSError aborts the coroutine before self=2Esend_acc_msg() is reached,
preve=
nting the client from sending any sys_info response back to the server
when=
ever username is requested=2E

Would catching OSError or falling back to ge=
tpass=2Egetuser() avoid aborting
the response task?

> +
> +        if msg=
=2Eget("hostname", False):
> +            response['hostname'] =3D platform=
=2Enode()
> +
> +        if msg=2Eget("dns-google=2Ecom", False):
> +      =
      try:
> +                loop =3D asyncio=2Eget_running_loop()
> +    =
            # getaddrinfo is a blocking call=2E This is okay for the demo
>=
 +                # here but
> +                addrs =3D [x[4][0] for x in=
 await loop=2Egetaddrinfo('google=2Ecom', 443)]

[Severity: Low]
This isn't=
 a bug, but the comment in
OmiSysInfoClientProtocol=2Esend_info_response() =
is cut off mid-sentence and
describes a blocking getaddrinfo call right abo=
ve await loop=2Egetaddrinfo(),
while the socket module imported at the top =
of the file is unused=2E Should the
unused import be removed and the commen=
t completed or updated?

> +                response["dns-google=2Ecom"] =
=3D addrs
> +
> +            except Exception as e:
> +                logg=
er=2Eerror(f"Error resolving DNS for google=2Ecom: {e}", exc_info=3DTrue)
>=
 +                response["dns-google=2Ecom"] =3D None
> +
> +        if m=
sg=2Eget("route", False):
> +            response['route'] =3D await self=
=2Eget_routes(False)
> +
> +        if msg=2Eget("route6", False):
> +     =
       response['route6'] =3D await self=2Eget_routes(True)
> +
> +        =
msg =3D json=2Edumps(response)=2Eencode()
> +
> +        await self=2Esend_=
acc_msg("sys_info", msg)
> +
> +    async def get_routes(self, v6):

[ =2E=
=2E=2E ]

> +        proc =3D await asyncio=2Esubprocess=2Ecreate_subproces=
s_exec(cmd, *args, stdout=3Dsubprocess=2EPIPE)
> +        try:
> +         =
   output, _ =3D await asyncio=2Ewait_for(proc=2Ecommunicate(), timeout=3D1=
5)
> +        except asyncio=2ETimeoutError:
> +            return "Timeout=
 while waiting for command output"
> +        return output=2Edecode()

[Se=
verity: Medium]
If the route command in OmiSysInfoClientProtocol=2Eget_rout=
es() exceeds the
15-second timeout, asyncio=2Ewait_for() cancels proc=2Ecom=
municate(), but does
returning immediately from the asyncio=2ETimeoutError =
handler leak the running
child process proc and its stdout pipe without cal=
ling proc=2Ekill() and
awaiting proc=2Ewait()?

Also, if the hardcoded bina=
ry path (/usr/sbin/ip or netstat) does not exist
on the client host, create=
_subprocess_exec() will raise an uncaught
FileNotFoundError that aborts Omi=
SysInfoClientProtocol=2Esend_info_response()=2E

> diff --git a/sample/mana=
gement/acc_sysinfo_server_demo=2Epy b/sample/management/acc_sysinfo_server_=
demo=2Epy
> new file mode 100755
> index 0000000000000=2E=2Ea2ab0c1b05a92
>=
 --- /dev/null
> +++ b/sample/management/acc_sysinfo_server_demo=2Epy
> @@ =
-0,0 +1,122 @@

[ =2E=2E=2E ]

> +class SysInfoConnectedClient(ConnectedCli=
ent):
> +    # Remember the key-id that we authenticated
> +    authenticat=
ed_kid =3D None
> +
> +class OMISysInfoServerProtocol(OMIServerProtocol):
>=
 +    def __init__(self, finish_future, connect_data: ConnectData =3D None)=
:
> +        super()=2E__init__(finish_future, connect_data)
> +        sel=
f=2E_connected_client_class =3D SysInfoConnectedClient
> +
> +    def clien=
t_event_ESTABLISHED(self, client, kid, env, extra):
> +        print(f"CLie=
nt connected: {client}")
> +
> +        kid =3D client=2Eauthenticated_kid
=
> +        asyncio=2Ecreate_task(self=2E_send_sys_info_command(client, kid)=
)
> +
> +    def client_event_CONNECT(self, client, kid, env, extra):
> +  =
      print(f"Authenticating client {client=2Ecid}, {kid}")
> +        self=
=2Equeue_command(f"client-auth-nt {client=2Ecid} {kid}")
> +        client=
=2Eauthenticated_kid =3D kid
> +
> +    def client_event_REAUTH(self, clien=
t: DpcConnectedClient, kid: int, env: dict, extra: str):
> +        print(f=
"Re-authenticating client {client} on re-negotiation")
> +        _ =3D sel=
f=2Equeue_command(f"client-auth-nt {client=2Ecid} {kid}")

[Severity: High]=

When acc_sysinfo_server_demo=2Epy is executed, Python evaluates the parame=
ter
annotations of OMISysInfoServerProtocol=2Eclient_event_REAUTH() at clas=
s
definition time=2E Because the script defines SysInfoConnectedClient rath=
er
than DpcConnectedClient, doesn't this immediately crash on startup with
=
NameError: name 'DpcConnectedClient' is not defined?

In addition, when a c=
lient renegotiates its key in client_event_REAUTH(),
should client=2Eauthen=
ticated_kid also be updated to kid, matching
OMISysInfoServerProtocol=2Ecli=
ent_event_CONNECT()?

-- 
Sashiko AI review =C2=B7 https://sashiko=2Edev/#/=
patchset/0e153ba9c81e52ff9debee73e09f2dd317817c81-EmailReplacePatchSet-HTML=
@gerrit=2Eopenvpn=2Enet?part=3D1
```



-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4
Gerrit-Chan=
ge-Number: 2037
Gerrit-PatchSet: 4
Gerrit-Owner: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-CC: Name of user not set #1000061
Gerrit-CC: Ralf Li=
ci <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: Name of user not set #1000061
Gerrit-At=
tention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Tue=
, 03 Nov 2026 15:47:56 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--2aP0sQiFCs4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Name of user not set #1000061=2E </p>
<=
p>Ralf Lici has posted comments on this change by Arne Schwabe=2E</p><p><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2037?tab=3Dcomments&amp;usp=3Demail">Patch Set #4:</a> </p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Pasting her=
e Sashiko&#39;s findings (the AI bot accidentally picked this patch for rev=
iew):</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">``` Thank you for your contribution! Sashiko AI review found 4 po=
tential issue(s) to consider:</p><ul class=3D"blocks"><li>[High] sample/man=
agement: undefined DpcConnectedClient in client_event_REAUTH()</li><li>[Med=
ium] sample/management: unhandled OSError from os=2Egetlogin() in send_info=
_response()</li><li>[Medium] sample/management: leaked child process on tim=
eout in get_routes()</li><li>[Low] sample/management: unused socket import =
and truncated comment in client demo</li><li>-</li></ul><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">commit 59f0e39cb91=
ec113a14b2f7981e12a71495246d9<br>Author: Arne Schwabe (Code Review) via Ope=
nvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;</p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Change in op=
envpn[master]: Add python scripts that demonstrate the ACC protocol</p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Thi=
s commit adds client and server Python demonstration scripts for the<br>Ope=
nVPN management interface that implement the sys_info app custom control<br=
>(ACC) protocol to query client system details from the server=2E</p><block=
quote class=3D"blocks" style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;"><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">diff --git a/sample/management/acc_sysinfo_client_demo=
=2Epy b/sample/management/acc_sysinfo_client_demo=2Epy<br>new file mode 100=
755<br>index 0000000000000=2E=2E99e994e6fd3f1<br>--- /dev/null<br>+++ b/sam=
ple/management/acc_sysinfo_client_demo=2Epy<br>@@ -0,0 +1,150 @@</p></block=
quote><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">[ =2E=2E=2E ]</p><blockquote class=3D"blocks" style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;"><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">+import os<br>+import pl=
atform<br>+import socket<br>+import subprocess<br>+from asyncio import Canc=
elledError</p></blockquote><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">[ =2E=2E=2E ]</p><blockquote class=3D"blocks" s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">+cl=
ass OmiSysInfoClientProtocol(OMIClientProtocol):<br>+    def __init__(self,=
 finish_future, connect_data: ConnectData):<br>+        super()=2E__init__(=
finish_future, connect_data)<br>+<br>+<br>+    def receive_acc_sys_info(sel=
f, acc_message):<br>+        print(f&quot;Received sys_info message: {acc_m=
essage!r}&quot;)<br>+<br>+        logger=2Edebug(f&quot;Received sys_info m=
essage: {acc_message!r}&quot;)<br>+        msg =3D json=2Eloads(acc_message=
)<br>+<br>+        asyncio=2Ecreate_task(self=2Esend_info_response(msg))<br=
>+<br>+    async def send_info_response(self, msg):<br>+        response =
=3D {}<br>+        if msg=2Eget(&quot;uname&quot;, False):<br>+            =
response[&#39;uname&#39;] =3D platform=2Euname()=2E_asdict()<br>+<br>+     =
   if msg=2Eget(&quot;username&quot;, False):<br>+            response[&#39=
;username&#39;] =3D os=2Egetlogin()</p></blockquote><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">[Severity: Medium]<br>=
When OpenVPN spawns acc_sysinfo_client_demo=2Epy via --management =2E=2E=2E=
<br>unix-script or runs in a daemon, service, or container environment with=
out a<br>controlling terminal, won&#39;t os=2Egetlogin() in<br>OmiSysInfoCl=
ientProtocol=2Esend_info_response() raise an unhandled OSError?</p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Because=
 OmiSysInfoClientProtocol=2Ereceive_acc_sys_info() schedules<br>send_info_r=
esponse() as a background task via asyncio=2Ecreate_task(), an<br>uncaught =
OSError aborts the coroutine before self=2Esend_acc_msg() is reached,<br>pr=
eventing the client from sending any sys_info response back to the server<b=
r>whenever username is requested=2E</p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Would catching OSError or falling b=
ack to getpass=2Egetuser() avoid aborting<br>the response task?</p><blockqu=
ote class=3D"blocks" style=3D"border-left: 1px solid #aaa; margin: 10px 0; =
padding: 0 10px;"><p class=3D"blocks" style=3D"white-space: pre-wrap; word-=
wrap: break-word;">+<br>+        if msg=2Eget(&quot;hostname&quot;, False):=
<br>+            response[&#39;hostname&#39;] =3D platform=2Enode()<br>+<br=
>+        if msg=2Eget(&quot;dns-google=2Ecom&quot;, False):<br>+          =
  try:<br>+                loop =3D asyncio=2Eget_running_loop()<br>+      =
          # getaddrinfo is a blocking call=2E This is okay for the demo<br>=
+                # here but<br>+                addrs =3D [x[4][0] for x in=
 await loop=2Egetaddrinfo(&#39;google=2Ecom&#39;, 443)]</p></blockquote><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">[S=
everity: Low]<br>This isn&#39;t a bug, but the comment in<br>OmiSysInfoClie=
ntProtocol=2Esend_info_response() is cut off mid-sentence and<br>describes =
a blocking getaddrinfo call right above await loop=2Egetaddrinfo(),<br>whil=
e the socket module imported at the top of the file is unused=2E Should the=
<br>unused import be removed and the comment completed or updated?</p><bloc=
kquote class=3D"blocks" style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;"><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">+                response[&quot;dns-google=2Ecom&quot=
;] =3D addrs<br>+<br>+            except Exception as e:<br>+              =
  logger=2Eerror(f&quot;Error resolving DNS for google=2Ecom: {e}&quot;, ex=
c_info=3DTrue)<br>+                response[&quot;dns-google=2Ecom&quot;] =
=3D None<br>+<br>+        if msg=2Eget(&quot;route&quot;, False):<br>+     =
       response[&#39;route&#39;] =3D await self=2Eget_routes(False)<br>+<br=
>+        if msg=2Eget(&quot;route6&quot;, False):<br>+            response=
[&#39;route6&#39;] =3D await self=2Eget_routes(True)<br>+<br>+        msg =
=3D json=2Edumps(response)=2Eencode()<br>+<br>+        await self=2Esend_ac=
c_msg(&quot;sys_info&quot;, msg)<br>+<br>+    async def get_routes(self, v6=
):</p></blockquote><p class=3D"blocks" style=3D"white-space: pre-wrap; word=
-wrap: break-word;">[ =2E=2E=2E ]</p><blockquote class=3D"blocks" style=3D"=
border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">+        pr=
oc =3D await asyncio=2Esubprocess=2Ecreate_subprocess_exec(cmd, *args, stdo=
ut=3Dsubprocess=2EPIPE)<br>+        try:<br>+            output, _ =3D awai=
t asyncio=2Ewait_for(proc=2Ecommunicate(), timeout=3D15)<br>+        except=
 asyncio=2ETimeoutError:<br>+            return &quot;Timeout while waiting=
 for command output&quot;<br>+        return output=2Edecode()</p></blockqu=
ote><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">[Severity: Medium]<br>If the route command in OmiSysInfoClientProtocol=
=2Eget_routes() exceeds the<br>15-second timeout, asyncio=2Ewait_for() canc=
els proc=2Ecommunicate(), but does<br>returning immediately from the asynci=
o=2ETimeoutError handler leak the running<br>child process proc and its std=
out pipe without calling proc=2Ekill() and<br>awaiting proc=2Ewait()?</p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">A=
lso, if the hardcoded binary path (/usr/sbin/ip or netstat) does not exist<=
br>on the client host, create_subprocess_exec() will raise an uncaught<br>F=
ileNotFoundError that aborts OmiSysInfoClientProtocol=2Esend_info_response(=
)=2E</p><blockquote class=3D"blocks" style=3D"border-left: 1px solid #aaa; =
margin: 10px 0; padding: 0 10px;"><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">diff --git a/sample/management/acc_sysin=
fo_server_demo=2Epy b/sample/management/acc_sysinfo_server_demo=2Epy<br>new=
 file mode 100755<br>index 0000000000000=2E=2Ea2ab0c1b05a92<br>--- /dev/nul=
l<br>+++ b/sample/management/acc_sysinfo_server_demo=2Epy<br>@@ -0,0 +1,122=
 @@</p></blockquote><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">[ =2E=2E=2E ]</p><blockquote class=3D"blocks" style=3D=
"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">+class Sys=
InfoConnectedClient(ConnectedClient):<br>+    # Remember the key-id that we=
 authenticated<br>+    authenticated_kid =3D None<br>+<br>+class OMISysInfo=
ServerProtocol(OMIServerProtocol):<br>+    def __init__(self, finish_future=
, connect_data: ConnectData =3D None):<br>+        super()=2E__init__(finis=
h_future, connect_data)<br>+        self=2E_connected_client_class =3D SysI=
nfoConnectedClient<br>+<br>+    def client_event_ESTABLISHED(self, client, =
kid, env, extra):<br>+        print(f&quot;CLient connected: {client}&quot;=
)<br>+<br>+        kid =3D client=2Eauthenticated_kid<br>+        asyncio=
=2Ecreate_task(self=2E_send_sys_info_command(client, kid))<br>+<br>+    def=
 client_event_CONNECT(self, client, kid, env, extra):<br>+        print(f&q=
uot;Authenticating client {client=2Ecid}, {kid}&quot;)<br>+        self=2Eq=
ueue_command(f&quot;client-auth-nt {client=2Ecid} {kid}&quot;)<br>+        =
client=2Eauthenticated_kid =3D kid<br>+<br>+    def client_event_REAUTH(sel=
f, client: DpcConnectedClient, kid: int, env: dict, extra: str):<br>+      =
  print(f&quot;Re-authenticating client {client} on re-negotiation&quot;)<b=
r>+        _ =3D self=2Equeue_command(f&quot;client-auth-nt {client=2Ecid} =
{kid}&quot;)</p></blockquote><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">[Severity: High]<br>When acc_sysinfo_server_d=
emo=2Epy is executed, Python evaluates the parameter<br>annotations of OMIS=
ysInfoServerProtocol=2Eclient_event_REAUTH() at class<br>definition time=2E=
 Because the script defines SysInfoConnectedClient rather<br>than DpcConnec=
tedClient, doesn&#39;t this immediately crash on startup with<br>NameError:=
 name &#39;DpcConnectedClient&#39; is not defined?</p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">In addition, when a =
client renegotiates its key in client_event_REAUTH(),<br>should client=2Eau=
thenticated_kid also be updated to kid, matching<br>OMISysInfoServerProtoco=
l=2Eclient_event_CONNECT()?</p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">-- <br>Sashiko AI review =C2=B7 https://sas=
hiko=2Edev/#/patchset/0e153ba9c81e52ff9debee73e09f2dd317817c81-EmailReplace=
PatchSet-HTML@gerrit=2Eopenvpn=2Enet?part=3D1<br>```</p></li></ul></li></ul=
><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
37?usp=3Demail">change 2037</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2037?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: commen=
t </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 2037 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerri=
t-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: Name of user not set #1000061 </div>
<div sty=
le=3D"display:none"> Gerrit-CC: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@=
lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: Name of user not set #1000061 </div>
<div style=3D"display:none"> =
Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Comment-Date: Tue, 03 Nov 2026 15:47:56 +=
0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--2aP0sQiFCs4=--


--===============0305732587538470164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0305732587538470164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0305732587538470164==--

