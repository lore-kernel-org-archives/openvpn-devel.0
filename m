Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BC2606A31B
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 23:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fBRrXlu3;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZlL3l7wM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=m5jC3E5+;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TAlmu1tk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=dfH5uLKRAW2EzKd1D1MnuOxtZNLWLyHPfcnJRc0ru38=; b=fBRrXlu3PzrgaK+ViG+g8X78vN
	dtk9LLpK6rXwZQM4VidHfnr6HThLWg34dql1CUtXIy8C8WE4A/v431CdV8iWCCuKGxE+5E7ZKM1XN
	uTLkSitaedqbvvsQCdL/CmlMrr7gV5i5sTshZaOapUiuuOc0JQsLwsuPOynddF9rkGXc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xONbE-0000000012a-0fKh;
	Tue, 03 Nov 2026 23:07:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xONbC-0000000012S-1WUD
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 23:07:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OIotS3xl3iI6wqyqlr+MGd488Ou6vjaT0IWv0/RdaMA=; b=ZlL3l7wMhG2KapEEDRV0Dl1522
 8ATVq6ifjegDkeP73PCjqHxUxBhK+VXEehCs4N71uDULHl1bEOZIqDOt3S727FY6AbmTzrKzFYXs5
 mZ+SNpNsUIaaivC/e/8i/0lgumWtF+xRSWMHVsgpkim3gW0jpkyCWvWksj9kSUmEyFhs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OIotS3xl3iI6wqyqlr+MGd488Ou6vjaT0IWv0/RdaMA=; b=m5jC3E5+EjRxSi+8itJSPUA2PZ
 U/TjGTDUJO1c8s0kSIhOKlS7CwfU6JTR9NhWH7PSR2oMEEsXYKNyfv6/5Sl+PpYjOmdngz+esFMuO
 9ybmQKVAAeNJ70Mr2DTHMpthmGhjpehLBy8iDBs8Sn1n7yp9WsmjMEgusMKNZgteXi78=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xONbA-000000002sB-1Egq for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 23:07:26 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so638695e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 15:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793747238; x=1794352038; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OIotS3xl3iI6wqyqlr+MGd488Ou6vjaT0IWv0/RdaMA=;
 b=TAlmu1tkghp5DlS2MlHzwf02zAtZi/+RYZ6SISfZ2CsMgpYJehTJHUlRmG3lcGjnwU
 1ndigt5JNzyOiom8T3rdJsfQ+pwvQcr/TcGEVXXo+t0DQpkDCsr+NlFWG/RaMuzjRn8C
 lH9GfWSGn+Gfy8vn4iB0KMbXu9UiQNIdeziv1J8GbdoAt6WBM2bOmL9YMWFLhiy8X/Vs
 KeBpA2G/eAwUrXpZZvT6O8LTVjNMjz/u4gC9AhC+ZmvR6BIh8YzismlY7j2Ca1dmuCd0
 61HGU3SUJvHxbSNTYxne/uQuqXIc1VXEkYsziOq0KXDlqbqKiVLUnZt8stlqEEpdkenc
 ftXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793747238; x=1794352038;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OIotS3xl3iI6wqyqlr+MGd488Ou6vjaT0IWv0/RdaMA=;
 b=kx52uDbgqjdBMLnEp7Q+vSw8lqinghFFvzGEz0ecWFextm2x43aVuM3X3Q9Kcp+kHh
 wofUKlOXpS4VqX+qwgG3ab2+GQale0yWpbqUssNGZtKz12PMMDW0I0iApua8S4SWJg34
 Q3rcp/ag0U8X1I/zwbOpGFobLA/L+Vp9jq/mYY2jDWvu+K32HNywJxtN1/Kat7mc+L9f
 ID8HhXyXYhGnSybo7OY7zEAjahArvo/jm7iEXnRT/7pEYYFBiV5x5tkJSXuPvOaLHUKZ
 I9XzTy03QNCmLpM4C4nTBprwAOEiJQ/LHRCfJ7boYA46xe5C2wO+HvvmmexQ6/sYzt0y
 g0QA==
X-Gm-Message-State: APuU4Z9BJeIk9c7zN2kFe/hNRdoCkTlAwnx0aaQS11eQoY8YUPhWnZAA
 IfsCuuPCtz3/gAfoi0giDZnqw61zWn5q+veJ/ZN5Go8aEbSwRI+85aTpS1vYNmVUuQeFM91vk1w
 pQoVZkfSnRi4WuH+lNDEUz5unSxtfeg1/CRy15dO9pGXvudtbEHNENIIaxHqpT0vITG7259cABF
 PRY+YeVw==
X-Gm-Gg: AYBFou2XzbexJL9z3S7JRlNRiSuChQt1VhHLAoO8xjj9+2DWC7nDzp6Ka61c38XLm1g
 7NqplG/c4rXA+Olou54R6TBGzyRK9fsU5A142JHBoFNVbrprxuq8GWto7SDEf1s6l4rJTzrsA9g
 AkKG8FR/5DdYqiTs36oBQEM0et2KHJuVQQ4cXFGvMMkPgDPBqr0zrRrX1dLZZ+YMgc8kv+imhrW
 kXa+ursVNwsOl2lEFsuM+65dZZHlDeUKzhV9m/FIBzx0keaqui2HY9QKQyrQmrN+wV0tEJZjzxA
 qUb+IWGjBK7PYEVzBWWBe0lsB1tzX41sv8v6ZgXX2CUARgnedAN0ocy98YD4OC48l6rwK//hg0g
 esfs0YDpwSZdfnaFh2RMXi2x3uVg/FpGMTaeqOfw1AVHcgtH1MAJJtHg1NmlbFFTAsLuUC3DfSA
 26INMM3DYRNs3gkOuzW9bZ73GRruuwnRpOJ694lyCJxhOeO60KosYnm3LaAKepDWENaPxrxKV31
 eAcH711TTNKjY4cGOb+9bqFckLnuMHu9H85+GqLZDVv2ZXYywxJM23Mlh2DEDAhOnQQNdI4NI0K
 U4MZGtSKfApzGYiTnOgjOPOd/ze74Nc5bAl7dslpEzd7AEyg+q8e0tHodI1H+TytGqpKwjVufrl
 r38EK4NqZAeouD9D3TTFPc51LZJNh9OW2IGXOHknI0pzSWpIS8C3iVbwquJWcUKkSmc9/dLt+eN
 k3CxDL0DiCVysRLj6fwjndKHPiV66Xj94BupU=
X-Received: by 2002:a05:600c:4f55:b0:4a3:d327:6ed with SMTP id
 5b1f17b1804b1-4ac182dcba3mr364320565e9.17.1793747237594; 
 Tue, 03 Nov 2026 15:07:17 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2aaa4b91esm84894135e9.11.2026.11.03.15.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 15:07:17 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 23:07:16 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id3a58112fffc8679978ddf5adb44e7be9083e17a
X-Gerrit-Change-Number: 2112
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2112?usp=email>
X-Gerrit-Commit: db5ed398462510e1e818420deb2c75d56018bd34
References: <gerrit.1793747232000.Id3a58112fffc8679978ddf5adb44e7be9083e17a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzQ3MjMyMDAwLklkM2E1ODExMmZmZmM4Njc5OTc4ZGRmNWFkYjQ0ZTdiZTkwODNlMTdhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e2c8028730a2e87abf1dcb968c60ad7752010ef0-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xONbA-000000002sB-1Egq
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
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8541824056377955554=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8541824056377955554==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rI+0v/SLiIw="; charset=UTF-8

--rI+0v/SLiIw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2112?usp=3Demail

to review the following change=2E
=


Change subject: openvpnserv: hold the service pipe name with a private in=
stance
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

open=
vpnserv: hold the service pipe name with a private instance

Only the first=
 pipe instance was created with the flag
FILE_FLAG_FIRST_PIPE_INSTANCE, whi=
ch relied on the service never
closing all of its instances=2E

Create a di=
sconnected instance on first use instead, which holds the
name for the life=
time of the service, no matter how many instances
clients use=2E

Change-Id=
: Id3a58112fffc8679978ddf5adb44e7be9083e17a
Signed-off-by: Heiko Hund <heik=
o@ist=2Eeigentlich=2Enet>
---
M src/openvpnserv/interactive=2Ec
1 file chan=
ged, 32 insertions(+), 10 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/12/2112/1

diff --git a/src/openvpnserv/i=
nteractive=2Ec b/src/openvpnserv/interactive=2Ec
index 4a8d0b5=2E=2E5e4b555=
 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interac=
tive=2Ec
@@ -3806,6 +3806,16 @@
 }
 
 
+/**
+ * Create an instance of the s=
ervice pipe clients connect to
+ *
+ * The first call also creates a privat=
e instance with FILE_FLAG_FIRST_PIPE_INSTANCE,
+ * which fails if the pipe =
name already exists=2E It is kept disconnected, so clients
+ * cannot conne=
ct to it, and holds the pipe name for the lifetime of the service=2E
+ * Th=
is way the pipe name is blocked from other processes using it=2E
+ *
+ * @r=
eturn HANDLE of the pipe instance, or INVALID_HANDLE_VALUE on error
+ */
 s=
tatic HANDLE
 CreateClientPipeInstance(VOID)
 {
@@ -3833,21 +3843,33 @@
   =
  sa=2EbInheritHandle =3D FALSE;
 
     DWORD flags =3D PIPE_ACCESS_DUPLEX =
| WRITE_DAC | FILE_FLAG_OVERLAPPED;
-
-    static BOOL first =3D TRUE;
-   =
 if (first)
-    {
-        flags |=3D FILE_FLAG_FIRST_PIPE_INSTANCE;
-    =
    first =3D FALSE;
-    }
+    DWORD mode =3D PIPE_TYPE_MESSAGE | PIPE_RE=
ADMODE_MESSAGE | PIPE_REJECT_REMOTE_CLIENTS;
 
     WCHAR pipe_name[256]; /=
* The entire pipe name string can be up to 256 characters long according
  =
                            to MSDN=2E */
     swprintf(pipe_name, _countof=
(pipe_name), L"\\\\=2E\\pipe\\" _L(PACKAGE) L"%ls\\service",
              =
service_instance);
-    HANDLE pipe =3D CreateNamedPipe(
-        pipe_name=
, flags, PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_REJECT_REMOTE_CLI=
ENTS,
-        PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0, &sa);
+
+    static=
 HANDLE blocker =3D INVALID_HANDLE_VALUE;
+    if (blocker =3D=3D INVALID_H=
ANDLE_VALUE)
+    {
+        blocker =3D CreateNamedPipe(pipe_name, flags |=
 FILE_FLAG_FIRST_PIPE_INSTANCE, mode,
+                                  PI=
PE_UNLIMITED_INSTANCES, 1024, 1024, 0, &sa);
+        if (blocker !=3D INVA=
LID_HANDLE_VALUE && !DisconnectNamedPipe(blocker))
+        {
+            =
DWORD error =3D GetLastError();
+            CloseHandleEx(&blocker);
+    =
        SetLastError(error);
+        }
+    }
+
+    /* Without the first =
instance, fail and try again with the next call */
+    HANDLE pipe =3D INV=
ALID_HANDLE_VALUE;
+    if (blocker !=3D INVALID_HANDLE_VALUE)
+    {
+    =
    pipe =3D CreateNamedPipe(pipe_name, flags, mode, PIPE_UNLIMITED_INSTANC=
ES, 1024, 1024, 0,
+                               &sa);
+    }
 
     Loca=
lFree(sd);
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2112?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: new=
change
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id3a=
58112fffc8679978ddf5adb44e7be9083e17a
Gerrit-Change-Number: 2112
Gerrit-Pat=
chSet: 1
Gerrit-Owner: Heiko Hund <heiko@openvpn=2Enet>
Gerrit-Reviewer: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>

--rI+0v/SLiIw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Heiko Hund would like Arne Sc=
hwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2112?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">openvpnserv: hold the service pipe name with a private instance<b=
r><br>Only the first pipe instance was created with the flag<br>FILE_FLAG_F=
IRST_PIPE_INSTANCE, which relied on the service never<br>closing all of its=
 instances=2E<br><br>Create a disconnected instance on first use instead, w=
hich holds the<br>name for the lifetime of the service, no matter how many =
instances<br>clients use=2E<br><br>Change-Id: Id3a58112fffc8679978ddf5adb44=
e7be9083e17a<br>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&=
gt;<br>---<br>M src/openvpnserv/interactive=2Ec<br>1 file changed, 32 inser=
tions(+), 10 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/12/2112/1</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br=
><span>index 4a8d0b5=2E=2E5e4b555 100644</span><br><span>--- a/src/openvpns=
erv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</=
span><br><span>@@ -3806,6 +3806,16 @@</span><br><span> }</span><br><span> <=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Create an insta=
nce of the service pipe clients connect to</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * The first call also creates a private instance with FILE_FLAG_FIRS=
T_PIPE_INSTANCE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
which fails if the pipe name already exists=2E It is kept disconnected, so =
clients</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * cannot co=
nnect to it, and holds the pipe name for the lifetime of the service=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This way the pipe na=
me is blocked from other processes using it=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @return HANDLE of the pipe instance, or INVALID_HANDLE_VALUE o=
n error</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span> static HANDLE</span><br><span> CreateClientPipeInstance(VOID)</spa=
n><br><span> {</span><br><span>@@ -3833,21 +3843,33 @@</span><br><span>    =
 sa=2EbInheritHandle =3D FALSE;</span><br><span> </span><br><span>     DWOR=
D flags =3D PIPE_ACCESS_DUPLEX | WRITE_DAC | FILE_FLAG_OVERLAPPED;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    static BOOL first =3D TRUE;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (first)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        flags |=3D FILE_FLAG_FIRST_PIPE_INSTANCE;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        first =3D FALSE;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    DWORD mode =3D PIPE_TYPE_MESSAGE | PIPE_REA=
DMODE_MESSAGE | PIPE_REJECT_REMOTE_CLIENTS;</span><br><span> </span><br><sp=
an>     WCHAR pipe_name[256]; /* The entire pipe name string can be up to 2=
56 characters long according</span><br><span>                              =
to MSDN=2E */</span><br><span>     swprintf(pipe_name, _countof(pipe_name),=
 L&quot;\\\\=2E\\pipe\\&quot; _L(PACKAGE) L&quot;%ls\\service&quot;,</span>=
<br><span>              service_instance);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    HANDLE pipe =3D CreateNamedPipe(</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        pipe_name, flags, PIPE_TYPE_MES=
SAGE | PIPE_READMODE_MESSAGE | PIPE_REJECT_REMOTE_CLIENTS,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        PIPE_UNLIMITED_INSTANCES, 1024=
, 1024, 0, &amp;sa);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    static HANDLE =
blocker =3D INVALID_HANDLE_VALUE;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (blocker =3D=3D INVALID_HANDLE_VALUE)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        blocker =3D CreateNamedPipe(pipe_name, fla=
gs | FILE_FLAG_FIRST_PIPE_INSTANCE, mode,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                  PIPE_UNLIMITED_INST=
ANCES, 1024, 1024, 0, &amp;sa);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (blocker !=3D INVALID_HANDLE_VALUE &amp;&amp; !Disco=
nnectNamedPipe(blocker))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       DWORD error =3D GetLastError();</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            CloseHandleEx(&amp;blocker);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            SetLastError(error);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* Without the first instance, fail and try again with the ne=
xt call */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HANDL=
E pipe =3D INVALID_HANDLE_VALUE;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (blocker !=3D INVALID_HANDLE_VALUE)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        pipe =3D CreateNamedPipe(pipe_name, flags, mo=
de, PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                               &amp;sa);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span=
><br><span>     LocalFree(sd);</span><br></pre><p>To view, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2112?usp=3Demail">change 2112</=
a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div =
itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2112?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id=
3a58112fffc8679978ddf5adb44e7be9083e17a </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2112 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;he=
iko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--rI+0v/SLiIw=--


--===============8541824056377955554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8541824056377955554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8541824056377955554==--

