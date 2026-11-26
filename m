Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E46606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WX/RuKAn;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IYtj5oOR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mrp1ApZ6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Yqlg+1r5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Y9c0WB7b+bhRImB7qGvNlU1gonf0+OK89OjNHs+giEk=; b=WX/RuKAnLP1q4atM4Ngii8xkH8
	4OIbgnjqLullZFteWyRu+dm9q93r7NcVDclX2RyMw5pq8uHPRlo41xyBU6uGagtLQ/kqKFISGDf9X
	3s3c/YXPVESyeF46Xd5oDK+E5aCEZG1ys9HDmBYs1UVjORSn+R5BzD0xj0a4Lz8JNiVc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWaSR-000000003WO-3YA0;
	Thu, 26 Nov 2026 14:28:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWaSQ-000000003WA-14s6
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 14:28:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PLkMRg6uKi59lJS+Km1vGzSNUrLwxmz40NfT76eqUMg=; b=IYtj5oORTVDMlcdTZ/9gQzOUg0
 eYewKMRbiDCrHXNRlWagTAftL+ZSWJG3dLqbNT46CdRi/ImaWaJTjRaYmLlFrrccFuSeWF3jmIaYk
 /FT+6qQbwBJiLQAz7ZvyYJEnZYPIg3wzniRIA8QQGxZdB/mn05hk20aZ35jDuoqoBFDU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PLkMRg6uKi59lJS+Km1vGzSNUrLwxmz40NfT76eqUMg=; b=mrp1ApZ6PMCfOLEZbnlRmtCL8z
 S8Tp+3Xy24PvfFJKl/8k6gXfGSs0XeN19MZUWCSaWANw66j0uMmdqi5BpPgickCXqr0KoB0mQpJwJ
 KGhFK9FhY9Sny5p0nn2PEpBBSwRedRqlG/t64Dr4dgR+4pKJF2yvWVQSmIOAEnZt3BnI=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWaSP-000000001Vl-10nl for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 14:28:18 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so4440257f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 06:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795703291; x=1796308091; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PLkMRg6uKi59lJS+Km1vGzSNUrLwxmz40NfT76eqUMg=;
 b=Yqlg+1r55ykR+bp5dtxwXTp1q6gD6KjfhmXgZeLbaLuAp6Tp+Vs3R4Wz4sOZeoOL3S
 4jlQTsu9tbZRqoLRNqh4ENBx9H4Mojl3T0NvxKbJCtNWihlqSKsmbrgpdfAOf2gtgeEQ
 kzA8Fk6Vpg7ZdPbVasKm6T7ezYZCaSmh1QUJvlb9WWZhQL2nrC5Dczldab2nx+uW/CZh
 wHgB5/lfpZYjIBkcFxtXR82J466TU2VYNLePg1A555PCbnCrdCG81Bxkxk37FisDPdvu
 HE1umpLO2JfHjr2p/6AxNbyOSLNhtKs9Zn5InjHV9XYC7LKLzTrUzZmaRhwy4AKXnBkW
 6QDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795703291; x=1796308091;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PLkMRg6uKi59lJS+Km1vGzSNUrLwxmz40NfT76eqUMg=;
 b=LtHA6UIgBaNflLTZBHUsyipRng1mWbrcn/jFummRHdOVnZZrlecIrvD4RC/5ly1PUn
 iBPBGRse6eTPF7JfB+9bHFRVizZZKmmuoOb2EvmCpXHZaZ6N3P84tgHF5F/1ZVYn2ppm
 U6GCI3e43dm3rMn/jJXwVdN3zPtyXkeddVRSFV6RgnavBhT0fSR8NQm546SASXy/7FEH
 9yr0IKs+RHE7s5MLHFdrhrQJhusvXi/ZmxJdj3+s0ev8+Clt7Y50kVKfIuHMStK3TMdC
 rvo5StM+sEJsBiY8XALQecO2SPpSCK6DaMIWlW6jdYVQkGHrq4PFQe9Lzo4ArrwMvCdg
 Z0qw==
X-Forwarded-Encrypted: i=1;
 AL+hErHfzITQMtucmr8YUdYsMDblqeIPGqC3Lvbw1HMfxXSFTIYE+77J/N+fi77nzExbYslODsLnjrDIAJbiLkAR@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+txtGFLIQxKpE4tkntg2UYRxT18zvM65mxvuKA3cxW89U1Pgbn
 SAK1Jhg8Mobi8fvTZqJWY4ffiXWlgUmzE0bs3Y04M5A/kq0qyFr1ZIX71r3UHa3nEjWE85oZfMq
 kFGpA92Swjf9D5GzCTC/dfNHgvmGganHFtjGL5itHSZzzvAD0yHBycqggUgyBcUntttXm
X-Gm-Gg: AZFdTZewdc6iVpwVU9CHAXcW+JfTcnq+EBXb865swFMxQ3ziVKBfc4bHP+A9YxDvKgV
 B6vdlynUZWQPlKKV8QH7LhgWlEvTM0VxX+tP2N8LrTwrP//1Tesvms/QwGkV31HQkiqyUeI6eud
 YxH4TUFWccJwrYe43oGVeLNNERQSyiPTRN9ldUc0GszlN12USMuJmP2KqG21xoQdVX+iwCXQUIQ
 Ms64cSPLF1cjzFCXDasXVWM0JnBwl7j4ZgBiX97Gb8+E7rTw2KwITO/DlZNpygfH+dcMNtj5226
 J8mLVFxYh4RqvqYiQrF6N5Mv5oPwen6wlFIQsrbw0c0VHQJhYRHTsRpp4hiM2qT5h9QXyiPEUPa
 w0i9HCWhhJM28qWGZ+hin9fqNzMabnDcw5pZalVw+5jpqfZRrq5tOTASIGgXV3zuJH2H14UQXB0
 LKn0jx1miasMtofoPExmPcD5ye2sVoXmEiVtkeYP8wrkjz7lBdKKLTBkqV+LEPoCMqrBBwnOULZ
 eneJOwVEVORHK3RKilLXBrxGYiJbhbKiaP8SAptGHQa/VQYpmt81SNZtPDX09UQJZw503AZ7nW/
 DCXZ9sAV1chAGEZ9rPQ6YIoQrL2fajl1AjWMT7EcUdcPrfdCJCCwHlo9q225IXXJT5DioDUsqIz
 ZRaOgBccYJ1nqqKZfzLcWziisadYLLk9u6kQtcCY1DaHwcAFU6hqRa7wkWOyO/1SxNwJ2ynw/wa
 RDsej8z36O7+4mPy/N
X-Received: by 2002:a05:6000:22c8:b0:4a6:bc53:2466 with SMTP id
 ffacd0b85a97d-4abb0d52547mr42240221f8f.16.1795703290386; 
 Thu, 26 Nov 2026 06:28:10 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67f204sm48972246f8f.21.2026.11.26.06.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:28:10 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 14:28:09 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Id3a58112fffc8679978ddf5adb44e7be9083e17a
X-Gerrit-Change-Number: 2112
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2112?usp=email>
X-Gerrit-Commit: 6211a5088b13d8854fde397be694fab153858115
In-Reply-To: <gerrit.1793747232000.Id3a58112fffc8679978ddf5adb44e7be9083e17a@gerrit.openvpn.net>
References: <gerrit.1793747232000.Id3a58112fffc8679978ddf5adb44e7be9083e17a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzQ3MjMyMDAwLklkM2E1ODExMmZmZmM4Njc5OTc4ZGRmNWFkYjQ0ZTdiZTkwODNlMTdhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <59cbcba46a336a6fa7bdd752de14f55472f000d3-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xWaSP-000000001Vl-10nl
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: hold
 the service pipe name with a private instance
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, heiko@ist.eigentlich.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============9010381503684452107=="
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MISSING_HEADERS,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9010381503684452107==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PeTetQbe8JM="; charset=UTF-8

--PeTetQbe8JM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2112?usp=3Demail )

Change subject: openvpnserv: hold the servi=
ce pipe name with a private instance
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: hold the service pipe name with a pr=
ivate instance

Only the first pipe instance was created with the flag
FILE=
_FLAG_FIRST_PIPE_INSTANCE, which relied on the service never
closing all of=
 its instances=2E

Create a disconnected instance on first use instead, whi=
ch holds the
name for the lifetime of the service, no matter how many insta=
nces
clients use=2E

Change-Id: Id3a58112fffc8679978ddf5adb44e7be9083e17a
S=
igned-off-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Acked-by: Razvan Co=
jocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2112
Message-Id: <20261117182119=2E17648-1-gert@greenie=2Emuc=2E=
de>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg41580=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede=
>
---
M src/openvpnserv/interactive=2Ec
1 file changed, 32 insertions(+), 1=
0 deletions(-)




diff --git a/src/openvpnserv/interactive=2Ec b/src/openv=
pnserv/interactive=2Ec
index f00e75e=2E=2E1cb191a 100644
--- a/src/openvpns=
erv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -4022,6 +4022,=
16 @@
 }
 
 
+/**
+ * Create an instance of the service pipe clients connec=
t to
+ *
+ * The first call also creates a private instance with FILE_FLAG_=
FIRST_PIPE_INSTANCE,
+ * which fails if the pipe name already exists=2E It =
is kept disconnected, so clients
+ * cannot connect to it, and holds the pi=
pe name for the lifetime of the service=2E
+ * This way the pipe name is bl=
ocked from other processes using it=2E
+ *
+ * @return HANDLE of the pipe i=
nstance, or INVALID_HANDLE_VALUE on error
+ */
 static HANDLE
 CreateClient=
PipeInstance(VOID)
 {
@@ -4049,21 +4059,33 @@
     sa=2EbInheritHandle =3D =
FALSE;
 
     DWORD flags =3D PIPE_ACCESS_DUPLEX | WRITE_DAC | FILE_FLAG_OV=
ERLAPPED;
-
-    static BOOL first =3D TRUE;
-    if (first)
-    {
-      =
  flags |=3D FILE_FLAG_FIRST_PIPE_INSTANCE;
-        first =3D FALSE;
-    =
}
+    DWORD mode =3D PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_REJE=
CT_REMOTE_CLIENTS;
 
     WCHAR pipe_name[256]; /* The entire pipe name str=
ing can be up to 256 characters long according
                            =
  to MSDN=2E */
     swprintf(pipe_name, _countof(pipe_name), L"\\\\=2E\\pi=
pe\\" _L(PACKAGE) L"%ls\\service",
              service_instance);
-    HA=
NDLE pipe =3D CreateNamedPipe(
-        pipe_name, flags, PIPE_TYPE_MESSAGE=
 | PIPE_READMODE_MESSAGE | PIPE_REJECT_REMOTE_CLIENTS,
-        PIPE_UNLIMI=
TED_INSTANCES, 1024, 1024, 0, &sa);
+
+    static HANDLE blocker =3D INVALI=
D_HANDLE_VALUE;
+    if (blocker =3D=3D INVALID_HANDLE_VALUE)
+    {
+     =
   blocker =3D CreateNamedPipe(pipe_name, flags | FILE_FLAG_FIRST_PIPE_INST=
ANCE, mode,
+                                  PIPE_UNLIMITED_INSTANCES, 10=
24, 1024, 0, &sa);
+        if (blocker !=3D INVALID_HANDLE_VALUE && !Disco=
nnectNamedPipe(blocker))
+        {
+            DWORD error =3D GetLastErr=
or();
+            CloseHandleEx(&blocker);
+            SetLastError(error=
);
+        }
+    }
+
+    /* Without the first instance, fail and try aga=
in with the next call */
+    HANDLE pipe =3D INVALID_HANDLE_VALUE;
+    if=
 (blocker !=3D INVALID_HANDLE_VALUE)
+    {
+        pipe =3D CreateNamedPi=
pe(pipe_name, flags, mode, PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0,
+      =
                         &sa);
+    }
 
     LocalFree(sd);
 

-- 
To view,=
 visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2112?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: Id3a58112fffc8679978ddf5adb44e7be=
9083e17a
Gerrit-Change-Number: 2112
Gerrit-PatchSet: 2
Gerrit-Owner: Heiko =
Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--PeTetQbe8JM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2112?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">openvpnserv: hold the service pipe=
 name with a private instance<br><br>Only the first pipe instance was creat=
ed with the flag<br>FILE_FLAG_FIRST_PIPE_INSTANCE, which relied on the serv=
ice never<br>closing all of its instances=2E<br><br>Create a disconnected i=
nstance on first use instead, which holds the<br>name for the lifetime of t=
he service, no matter how many instances<br>clients use=2E<br><br>Change-Id=
: Id3a58112fffc8679978ddf5adb44e7be9083e17a<br>Signed-off-by: Heiko Hund &l=
t;heiko@ist=2Eeigentlich=2Enet&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc=
@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2112<br>Message-Id: &lt;20261117182119=2E17648-1-gert@greenie=2Emuc=2Ede&=
gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg41580=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M src/openvpnserv/interactive=2Ec<br>1 file chang=
ed, 32 insertions(+), 10 deletions(-)<br><br></pre>
<pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/ope=
nvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>=
index f00e75e=2E=2E1cb191a 100644</span><br><span>--- a/src/openvpnserv/int=
eractive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><b=
r><span>@@ -4022,6 +4022,16 @@</span><br><span> }</span><br><span> </span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Create an instance of =
the service pipe clients connect to</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* The first call also creates a private instance with FILE_FLAG_FIRST_PIPE_=
INSTANCE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * which f=
ails if the pipe name already exists=2E It is kept disconnected, so clients=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * cannot connect t=
o it, and holds the pipe name for the lifetime of the service=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * This way the pipe name is b=
locked from other processes using it=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @return HANDLE of the pipe instance, or INVALID_HANDLE_VALUE on error=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
> static HANDLE</span><br><span> CreateClientPipeInstance(VOID)</span><br><=
span> {</span><br><span>@@ -4049,21 +4059,33 @@</span><br><span>     sa=2Eb=
InheritHandle =3D FALSE;</span><br><span> </span><br><span>     DWORD flags=
 =3D PIPE_ACCESS_DUPLEX | WRITE_DAC | FILE_FLAG_OVERLAPPED;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    static BOOL first =3D TRUE;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (first)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        flags |=3D FILE_FLAG_FIRST_PIPE_INSTANCE;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        first =3D FALSE;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    DWORD mode =3D PIPE_TYPE_MESSAGE | PIPE_READMODE_M=
ESSAGE | PIPE_REJECT_REMOTE_CLIENTS;</span><br><span> </span><br><span>    =
 WCHAR pipe_name[256]; /* The entire pipe name string can be up to 256 char=
acters long according</span><br><span>                              to MSDN=
=2E */</span><br><span>     swprintf(pipe_name, _countof(pipe_name), L&quot=
;\\\\=2E\\pipe\\&quot; _L(PACKAGE) L&quot;%ls\\service&quot;,</span><br><sp=
an>              service_instance);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    HANDLE pipe =3D CreateNamedPipe(</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        pipe_name, flags, PIPE_TYPE_MESSAGE | =
PIPE_READMODE_MESSAGE | PIPE_REJECT_REMOTE_CLIENTS,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        PIPE_UNLIMITED_INSTANCES, 1024, 102=
4, 0, &amp;sa);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    static HANDLE block=
er =3D INVALID_HANDLE_VALUE;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (blocker =3D=3D INVALID_HANDLE_VALUE)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        blocker =3D CreateNamedPipe(pipe_name, flags | =
FILE_FLAG_FIRST_PIPE_INSTANCE, mode,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                  PIPE_UNLIMITED_INSTANCES=
, 1024, 1024, 0, &amp;sa);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (blocker !=3D INVALID_HANDLE_VALUE &amp;&amp; !Disconnect=
NamedPipe(blocker))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  DWORD error =3D GetLastError();</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            CloseHandleEx(&amp;blocker);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            SetLastError(error);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* Without the first instance, fail and try again with the next ca=
ll */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HANDLE pip=
e =3D INVALID_HANDLE_VALUE;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (blocker !=3D INVALID_HANDLE_VALUE)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        pipe =3D CreateNamedPipe(pipe_name, flags, mode, P=
IPE_UNLIMITED_INSTANCES, 1024, 1024, 0,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                               &amp;sa);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br>=
<span>     LocalFree(sd);</span><br></pre><p>To view, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2112?usp=3Demail">change 2112</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div items=
cope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2112?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id3a58112f=
ffc8679978ddf5adb44e7be9083e17a </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 2112 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 =
</div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;heiko@ist=
=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--PeTetQbe8JM=--


--===============9010381503684452107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9010381503684452107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9010381503684452107==--

