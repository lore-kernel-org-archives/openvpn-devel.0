Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E69606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=d2eT+avc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EgK1cUDr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IAU8zTpO;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TQ7uKLln
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=bt8WeOeT0HLATDNKbTNPJ47lE5BFVWAsIycGoI7OSpo=; b=d2eT+avcflRFVeMXDEkWxwreXI
	51laQfck1VeKH+I8pGo1LPvc0D5pkNKb4UeyVDulBYykUgZRVKgepdGApmAmi4kNshCgylKcp+fDS
	WQUGoBYBDXE0+iT0S4Qgrj8RQ+UWSQpa8X3p1r0IEfRoFxMMVsDAtDTZgtVSG2Vz8spk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWaSR-000000001jW-0yUt;
	Thu, 26 Nov 2026 14:28:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWaSP-000000001jK-1laS
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 14:28:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GPs72XhSZ8EVU+cQdNClBo5Q9TwjgjJ6s4TydqMx5Rk=; b=EgK1cUDrQLL6QZ84j5r796lbYn
 sBmRazz3/Gic9wchOJBHj8i84S+pgG9VJLnWiupv79uszbYF5rKzR3ZrrPbBmdKpkgQkQp1GHKyCu
 YFPUM8p7YD/bBnxXExno7A37oArPqhQJGloefHTsJsg32SW1kBXEEv9FnlG58i4EPa1M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GPs72XhSZ8EVU+cQdNClBo5Q9TwjgjJ6s4TydqMx5Rk=; b=IAU8zTpO6Kr8lh71a0t5bS2HGK
 tdrX6RszRGmHTtJeMxIunTjI5dEETKAH6HxY60OxoGlkFjQxaZNhXDeKm4cUP+G6Re7KU7c6Rber6
 U2KJR5TzplzuvoVqSHfYQ6eXC690Rd9L3CoZ8kp/BmYg7djgu3R0mgDaQoMIrjJxsCpA=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWaSN-000000005Of-3ee3 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 14:28:17 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so64386485e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 06:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795703289; x=1796308089; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GPs72XhSZ8EVU+cQdNClBo5Q9TwjgjJ6s4TydqMx5Rk=;
 b=TQ7uKLlnTUQGcfaXdKl5YN6PG9O1SHFx/oVLyJLgBB6y+/I/ruR1qbXXz/hL0/3xpP
 281CGAG87W7p+vk5MA5SGqrv6EG2fgvtfMJRIlRz2oifB1uf5ke44oEzptPzUEIT6eQX
 pvkyyhO/KtLjGITjpE9i4q3Bfd4mJUZZsH9619WlUZWX94uw64Cl+e/FNB496rgWLAKk
 PfD79TwuzqjyThK3RS2gRZbanqw3pOtmBRgzlVfIPjXDwo4Lk/aoDINapllYbiq9dZjk
 fb4YlyX40td7x9DgAeylCyDL8sx6uH//Y8s8PrB9MUp8cLR6zKu8qu0IfX/8zbQv04D1
 9LPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795703289; x=1796308089;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GPs72XhSZ8EVU+cQdNClBo5Q9TwjgjJ6s4TydqMx5Rk=;
 b=wHu5GBbKljML3dV2Tjq4LfDTf67cnzxzdj/hhiFE6mRrYK8JW0G01Lzr9sIZ6OARQk
 LqmZ6u/w3Nkfg4gT0KMpISoFTHhMCfbSWlm6nOpnpAulwV4oK8FbxD6pBKvFQZy7ZLmb
 VV13fSssWdi4Hzs6ocgQudVhGU+zpSbh0BMfjv30VnSZOwHK7uI1wW81EoZxFMv6ARGi
 cqxf/SIthloTYMsZyaBCQRxFf/swXfi5SaUQkMLqpi3lUSA2TFRDRARmJgWYObLEWiTh
 0LMQYQGQvY58G0n9CfAU5z1iKSw/EzXRAFdqaKWPEhPVxZ3VqqMyiM8mu15NxwR+hoVg
 YoWg==
X-Gm-Message-State: APuU4Z+deO0oP0ef16CLuFaIRzlRvJquyCcdSSz/qBGJN/YdjkZ9dXE3
 jzwgRVQNhNUyHmaLsmh10nVkA148gy7WF8XSTqzgMDy/6EAN3StcgJ1E2gcy4jkRrwHqESNdA1Z
 8QcgAs/TxqjB9M37lcexnq9FTVf9EOrhKS46xJYKqVB1DOe9hAL8oVs33uDv5ZDCJyiJWnWxG3+
 EATjcasQ==
X-Gm-Gg: AZFdTZdDmz2CsZIct4VXSPYeRczNgJHcjn5m+G3Mo3x8FiBqI/YkmJK99TVwBgsNuhm
 CMECIzAZVDvZRVVqKHwP9QHTDr1M064Juznly4mEx4Ovld1x3Q+S112yr1QVQAlOLQXVRHIZkse
 LAsYqjXjcH7jnNZclygCoTFHMhKo+nmzbR6d6naiZ9681dq67HPgzE/3q9c0oTfqPXiwAaS0N04
 IMfq8kRYU6WmtE5Z5u9AqzHvdVFeM++l7rgo9Fyfy7zqGIKre2XmcxpE88F/Ozn1RZWV9vwaXDT
 8WWRe4LqacIem5T2dzrIPjjN9PHH/1m9irlLQHLDZ96KU6jPYE2e0qtgwT1rmm8nQW/ba2N47af
 ZaPun/s8hMMQADnHcDiqfIThsTPeiUjePz/+7nxVzT7K14GIuLRDxsPny1oKEEUlJtBzqdZSZPv
 xzJ52MyFDoetSjsqAUF7hOxqTWl16uTpBAtdS4uniCIs1oyjYe/LQSojKDcS76Uy1GaUETWPDZI
 hn3hgR+FJ604k017N0REGE7KevltZmBffiD2YvOuEPwyyHmCjPRoB2lYrCuelTDTLZ7B6/TbGR6
 4PmBGw/1bZn/RpUdcS+C9qgDDCOSqCNI9mwBsdHtWYU68FiRcSjIgDNKszp1drRtbX5yAg0SYCy
 y9sMnc3qfaBBPLubQ2B/TwBU87GtNTf5xFqGHYU2CfAzVPKiUwtKbOviKkEhKNblUYbxss2R1x9
 sGflVz35ArOZGD776h
X-Received: by 2002:a05:600c:4e02:b0:4bb:8636:dd7d with SMTP id
 5b1f17b1804b1-4bb88817f77mr428984005e9.24.1795703288991; 
 Thu, 26 Nov 2026 06:28:08 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b09bsm1121841795e9.4.2026.11.26.06.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:28:08 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 14:28:07 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Id3a58112fffc8679978ddf5adb44e7be9083e17a
X-Gerrit-Change-Number: 2112
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2112?usp=email>
X-Gerrit-Commit: 6211a5088b13d8854fde397be694fab153858115
In-Reply-To: <gerrit.1793747232000.Id3a58112fffc8679978ddf5adb44e7be9083e17a@gerrit.openvpn.net>
References: <gerrit.1793747232000.Id3a58112fffc8679978ddf5adb44e7be9083e17a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzQ3MjMyMDAwLklkM2E1ODExMmZmZmM4Njc5OTc4ZGRmNWFkYjQ0ZTdiZTkwODNlMTdhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <59cbcba46a336a6fa7bdd752de14f55472f000d3-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWaSN-000000005Of-3ee3
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4359105890777534432=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4359105890777534432==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IBjJKSverAs="; charset=UTF-8

--IBjJKSverAs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Heiko Hund=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2112?usp=
=3Demail )

The following approvals got outdated and were removed:
Code-Rev=
iew+2 by R=C4=83zvan Cojocaru


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


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/12/2112/2

diff --git a/src/openvpnserv/interactive=2Ec b/src/open=
vpnserv/interactive=2Ec
index f00e75e=2E=2E1cb191a 100644
--- a/src/openvpn=
serv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -4022,6 +4022=
,16 @@
 }
 
 
+/**
+ * Create an instance of the service pipe clients conne=
ct to
+ *
+ * The first call also creates a private instance with FILE_FLAG=
_FIRST_PIPE_INSTANCE,
+ * which fails if the pipe name already exists=2E It=
 is kept disconnected, so clients
+ * cannot connect to it, and holds the p=
ipe name for the lifetime of the service=2E
+ * This way the pipe name is b=
locked from other processes using it=2E
+ *
+ * @return HANDLE of the pipe =
instance, or INVALID_HANDLE_VALUE on error
+ */
 static HANDLE
 CreateClien=
tPipeInstance(VOID)
 {
@@ -4049,21 +4059,33 @@
     sa=2EbInheritHandle =3D=
 FALSE;
 
     DWORD flags =3D PIPE_ACCESS_DUPLEX | WRITE_DAC | FILE_FLAG_O=
VERLAPPED;
-
-    static BOOL first =3D TRUE;
-    if (first)
-    {
-     =
   flags |=3D FILE_FLAG_FIRST_PIPE_INSTANCE;
-        first =3D FALSE;
-   =
 }
+    DWORD mode =3D PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_REJ=
ECT_REMOTE_CLIENTS;
 
     WCHAR pipe_name[256]; /* The entire pipe name st=
ring can be up to 256 characters long according
                           =
   to MSDN=2E */
     swprintf(pipe_name, _countof(pipe_name), L"\\\\=2E\\p=
ipe\\" _L(PACKAGE) L"%ls\\service",
              service_instance);
-    H=
ANDLE pipe =3D CreateNamedPipe(
-        pipe_name, flags, PIPE_TYPE_MESSAG=
E | PIPE_READMODE_MESSAGE | PIPE_REJECT_REMOTE_CLIENTS,
-        PIPE_UNLIM=
ITED_INSTANCES, 1024, 1024, 0, &sa);
+
+    static HANDLE blocker =3D INVAL=
ID_HANDLE_VALUE;
+    if (blocker =3D=3D INVALID_HANDLE_VALUE)
+    {
+    =
    blocker =3D CreateNamedPipe(pipe_name, flags | FILE_FLAG_FIRST_PIPE_INS=
TANCE, mode,
+                                  PIPE_UNLIMITED_INSTANCES, 1=
024, 1024, 0, &sa);
+        if (blocker !=3D INVALID_HANDLE_VALUE && !Disc=
onnectNamedPipe(blocker))
+        {
+            DWORD error =3D GetLastEr=
ror();
+            CloseHandleEx(&blocker);
+            SetLastError(erro=
r);
+        }
+    }
+
+    /* Without the first instance, fail and try ag=
ain with the next call */
+    HANDLE pipe =3D INVALID_HANDLE_VALUE;
+    i=
f (blocker !=3D INVALID_HANDLE_VALUE)
+    {
+        pipe =3D CreateNamedP=
ipe(pipe_name, flags, mode, PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0,
+     =
                          &sa);
+    }
 
     LocalFree(sd);
 

-- 
To view=
, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2112?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id3a58112fffc8679978ddf5a=
db44e7be9083e17a
Gerrit-Change-Number: 2112
Gerrit-PatchSet: 2
Gerrit-Owner=
: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@=
mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--IBjJKSverAs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Heik=
o Hund=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2112?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">openv=
pnserv: hold the service pipe name with a private instance<br><br>Only the =
first pipe instance was created with the flag<br>FILE_FLAG_FIRST_PIPE_INSTA=
NCE, which relied on the service never<br>closing all of its instances=2E<b=
r><br>Create a disconnected instance on first use instead, which holds the<=
br>name for the lifetime of the service, no matter how many instances<br>cl=
ients use=2E<br><br>Change-Id: Id3a58112fffc8679978ddf5adb44e7be9083e17a<br=
>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>Acked-by=
: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2112<br>Message-Id: &lt;20261117182119=2E176=
48-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg41580=2Ehtml<br>Signed-off-by: Ge=
rt Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpnserv/inte=
ractive=2Ec<br>1 file changed, 32 insertions(+), 10 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/12/2112/2</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interactive=2Ec b/src=
/openvpnserv/interactive=2Ec</span><br><span>index f00e75e=2E=2E1cb191a 100=
644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</span><br><span>+=
++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -4022,6 +4022,16 @@=
</span><br><span> }</span><br><span> </span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Create an instance of the service pipe clients conne=
ct to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * The first call also creates =
a private instance with FILE_FLAG_FIRST_PIPE_INSTANCE,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * which fails if the pipe name already =
exists=2E It is kept disconnected, so clients</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * cannot connect to it, and holds the pipe name =
for the lifetime of the service=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * This way the pipe name is blocked from other processes us=
ing it=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return HANDLE of the pi=
pe instance, or INVALID_HANDLE_VALUE on error</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span> static HANDLE</span><br><spa=
n> CreateClientPipeInstance(VOID)</span><br><span> {</span><br><span>@@ -40=
49,21 +4059,33 @@</span><br><span>     sa=2EbInheritHandle =3D FALSE;</span=
><br><span> </span><br><span>     DWORD flags =3D PIPE_ACCESS_DUPLEX | WRIT=
E_DAC | FILE_FLAG_OVERLAPPED;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    static BO=
OL first =3D TRUE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (first)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        flags |=3D FILE_FL=
AG_FIRST_PIPE_INSTANCE;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        first =3D FALSE;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD=
 mode =3D PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_REJECT_REMOTE_CL=
IENTS;</span><br><span> </span><br><span>     WCHAR pipe_name[256]; /* The =
entire pipe name string can be up to 256 characters long according</span><b=
r><span>                              to MSDN=2E */</span><br><span>     sw=
printf(pipe_name, _countof(pipe_name), L&quot;\\\\=2E\\pipe\\&quot; _L(PACK=
AGE) L&quot;%ls\\service&quot;,</span><br><span>              service_insta=
nce);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    HANDLE pipe =
=3D CreateNamedPipe(</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       pipe_name, flags, PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_R=
EJECT_REMOTE_CLIENTS,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0, &amp;sa);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    static HANDLE blocker =3D INVALID_HANDLE_VALUE;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (blocker =3D=3D =
INVALID_HANDLE_VALUE)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bloc=
ker =3D CreateNamedPipe(pipe_name, flags | FILE_FLAG_FIRST_PIPE_INSTANCE, m=
ode,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                   PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0, &amp;sa);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (blocker !=3D =
INVALID_HANDLE_VALUE &amp;&amp; !DisconnectNamedPipe(blocker))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            DWORD error =3D GetLastError(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            Close=
HandleEx(&amp;blocker);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            SetLastError(error);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Without the first i=
nstance, fail and try again with the next call */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    HANDLE pipe =3D INVALID_HANDLE_VALUE;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (blocker !=3D IN=
VALID_HANDLE_VALUE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        pipe =
=3D CreateNamedPipe(pipe_name, flags, mode, PIPE_UNLIMITED_INSTANCES, 1024,=
 1024, 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                     &amp;sa);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span> </span><br><span>     LocalFree(sd);</spa=
n><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2112?usp=3Demail">change 2112</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2112?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Id3a58112fffc8679978ddf5adb44e7be90=
83e17a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2112 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>

</body></html>
--IBjJKSverAs=--


--===============4359105890777534432==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4359105890777534432==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4359105890777534432==--

