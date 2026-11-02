Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D962D606A324
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LS7O8+n+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kXhgFJ8c;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ekPDPrmm;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NJQ5xQTN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=W0fmBr8P3nBid/infHIl+SDmmj2SzBq4JnGtuCAMj/4=; b=LS7O8+n+/j2iPdYikpIMPxKOUT
	myD7By2DiH4nZTQbz0pRtw0ZBPY5OLmPNiD/6dzUM7WVk+idqJib8Y4g3dj/hOMSzw0zzMj7t9Y5A
	yeDw/t37UipnaPMgBpg5uWfqCfUqnqld7UcXS1aC2KTVX/eqXU7rMrjZ+WUZiG8U9u4M=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNpGJ-000000008ST-2UCm;
	Mon, 02 Nov 2026 10:27:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNpFx-000000008SC-2vwv
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 10:27:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OrS3aOXjjbQO6ibPVCSk3kQlAXgEKbMi6rC2AmqcqFI=; b=kXhgFJ8cDHTce4Udd3C9tIxx7W
 W7rQ5kdPK60NyBfbLcMKNQW91DytiY0KC3mJjDpkvlDONZqFw47rh+Lue6zslsk5PoNgCr52aQsiM
 K3lEdEl0mkxW9xwXwMIOPNKL6HCqZkDpfuEjdwNEUlkQ/NXQyhcuD1sWGOmAoEXwAKSw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OrS3aOXjjbQO6ibPVCSk3kQlAXgEKbMi6rC2AmqcqFI=; b=ekPDPrmmaUrEBI44vx2e4HB+mc
 vaQUx0xBtv+p6ZBciKiUFTbIG8oezhEHJbM83CBBQTxwnG2h6rqXZHFppJTrXdnoKXAlN2l3XG2ZX
 pR1J/HrMAirvvqQEZVOLYkPWzCUUFmBybt7v+h1uGl4tg4Mw40jvIdIMV/hceCQ6Eapw=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNpFu-000000003QJ-3tPn for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 10:27:13 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48e1d0e5dafso2027546f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 02:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793615224; x=1794220024; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OrS3aOXjjbQO6ibPVCSk3kQlAXgEKbMi6rC2AmqcqFI=;
 b=NJQ5xQTNuwpLf1nFnNo3levSmntkOvDHjI1zexxIXFD+xJTP71gWlkGPQQvyN0quCn
 78q6u4989sRDxFXxiEEoz4HqmoAc+5Vmerht+ozcGyzUCtqy5sThknYIhVTCfQ0SdQOa
 0YBkiB8wzBJPWBMg14I3Id8ydYhImTIAE/JXYbmQEaXC29y/vEXvGZJY9jsK2V0hR9Kf
 zOMMi+9gRLtMrYP3dglLuhvYRxHQpB7L5CjPqFysivwzcrEgkIQdmLYz+C55PQSVrGgU
 Kc/N7o6hA0gJRDlqF4aZgnNpy2wvYBKJljknvsKIQ8VnpYKt8VShhNx8AdgUXuBdvr8F
 1r8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793615224; x=1794220024;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OrS3aOXjjbQO6ibPVCSk3kQlAXgEKbMi6rC2AmqcqFI=;
 b=XH1KRxqaNw9/e6uuM2ySuaSKOubNLLvLaHDC3+2b4PRSPWWlZPB8NINxQx7BBEDCqX
 iqngxPgDHhjkP57VxfKlOEZX/IyciLTOdkP8CzQxgLVow3fePYBoudJ0zFx94HsOlyDZ
 flChiACG8sMyeIu46d1a1Pe2Sfl3hi8YNmQHZp5AZuwQG9zAt5Kf1h3czgJJVfCHGnol
 X4+8jOnPQfx4YcdXYogsOLZ4KtVgevBQOt4OrY5OKaxIkYmcBC/tEgGkea4cw1sX6bbB
 NiHsq+l1Ym4KyearH8yZax8GRn8uXhI6DARbPB2TfEB+TKBfgfDuV0fBfbVId2miqYXp
 E85w==
X-Forwarded-Encrypted: i=1;
 AKwUvByiuPjsloZKNaZ9DNXcaF/nHNEIWuPhFn8GYU0spaA2rl6tYR5SHJDxMRcHTrao56UH6BdW463bdqGJJGoQ@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIJq1gWokfUuug9VKgTA5lj9W4hp7zohTSsduEOGpO5a09RdGWp
 VoAOuXmez6Cbo0XBbWY2uKXFI890thT8WHh2g1mzjbC+zWClWb0IHyWH0+VdV3xDIiLJPEYFIVE
 IAbxk/HDRfuzE9/735zbNZnr2QLUZBRAnebb2507Hp4wRhA4OT7SgbD+wxcPRsbIMyKZ3
X-Gm-Gg: AYBFou1+7LPCfcQh531/5Q3bJtZIaed42jwYWsJ/TGl4XkGebeLy6rS6TSNumGUUg0c
 28Oj9b+pYcsii6x39mGfSOrC3eNs+PdBaD+L1JbczJ6cc+7Orni1p1Kva2zSD3rBv93UAV04g3j
 VixfbRRKwuA/wGTd0k/gMD4nEWkwLxshkPaNw4Jlx/i8ND7l/XH/l2PlV7ifjMvGndFgynZPwkp
 9Apobo78EmTOPH35MJrC1jLDazQ0fBw0VfqJrR79UkhwH6eg9aRmiOf6PARYtsn6GP6htOy1eN2
 KanXv5DB8bwKkDzbnvJ0DAwUfFRhlOvJ2XRaaOc1GbZMYKHfiuUAhyrqTbRDD7ZMtavujfB3LnT
 C3/xP0P5CBX5kaLFKTIJ5cFvF+5+FLruO9WnN5PpaWgGUHHp1d+YdIQQAbnGOLi4BDqff3afEt5
 Bx82vIF7WIeGaypOudNKTlbD+TczX93MnTC/DCVU57occ7JFKUOUQEH/9Ys8hJIi7y1Y8W2GTHA
 VRzmPsHmWVeeYUpcvPXso5fcQKa2KgChj8AY0jSh/JNBt/UzDAOMr2gpsTM0SeemurjG/64YChd
 kXvxkleshOoZXysasl0LLQd40RecxHImZNoHcEF4ccHK5ecJg75hVsE8sWAhqFonTNaUV0rNXtK
 1up+b3x9abNmtod5F3ag5P62Qa6UxWr0m9dRjcjGpncWHJ45YVq6w7cQ6NGN+tzrvRQ2r4m2RTI
 wJHhpLhJks3CZ8RA==
X-Received: by 2002:a05:600c:8116:b0:4a0:20b4:ba93 with SMTP id
 5b1f17b1804b1-4ac17e10724mr223978695e9.16.1793615224042; 
 Mon, 02 Nov 2026 02:27:04 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa813d2950sm331239695e9.8.2026.11.02.02.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 02:27:03 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 10:27:02 +0000
To: Selva Nair <selva.nair@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Iac23d5141a8c29e239d0f2aeea497d3a002e609b
X-Gerrit-Change-Number: 2069
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2069?usp=email>
X-Gerrit-Commit: 648cbaff36797e4187775494c091b75b3538b147
In-Reply-To: <gerrit.1793212962000.Iac23d5141a8c29e239d0f2aeea497d3a002e609b@gerrit.openvpn.net>
References: <gerrit.1793212962000.Iac23d5141a8c29e239d0f2aeea497d3a002e609b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjEyOTYyMDAwLklhYzIzZDUxNDFhOGMyOWUyMzlkMGYyYWVlYTQ5N2QzYTAwMmU2MDliQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6af9fa9749885db5fdf19412cd104e674d3e8921-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNpFu-000000003QJ-3tPn
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Optionally indicate
 username in >PASSWORD '<UP_TYPE>' prompts
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, selva.nair@gmail.com,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5559994771673673034=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5559994771673673034==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uB3a+ji6WkE="; charset=UTF-8

--uB3a+ji6WkE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2069?usp=3Demail )

Change subject: Optionally indicate usernam=
e in >PASSWORD '<UP_TYPE>' prompts
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

Optionally indicate username in >PASSWORD '<UP_TYPE>=
' prompts

When username is included in the config file as inlined or
read =
from a file, indicate it as a preferred-username in
>PASSWORD Need '<UP_TYP=
E>' username/password prompts where
'<UP_TYPE>' could be 'Auth', 'HTTP Prox=
y' or 'SOCKS Proxy'=2E
The prompt is appended with "UN:<user64>" where <use=
r64> is
the pre-defined username, base64 encoded=2E

This is treated as a h=
int, not an enforced value=2E The management
client still responds with bot=
h username and password obtained
from the user=2E Whether the management cl=
ient allows the
user to input a different username is left to the client
im=
plementation=2E

The documentation in management-notes is slightly edited t=
o add
that 'Auth', 'HTTP Proxy', 'SOCKS Proxy' are possible types of
userna=
me/password prompts=2E

Only clients that announce version >=3D6 are prompt=
ed this way=2E

This helps to fix user reports on OpenVPN-GUI not respectin=
g username
set in the config file=2E

Change-Id: Iac23d5141a8c29e239d0f2aee=
a497d3a002e609b
Signed-off-by: Selva Nair <selva=2Enair@gmail=2Ecom>
Acked-=
by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2069
Message-Id: <20261030213936=2E1001-1-gert@gree=
nie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg40351=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
---
M doc/management-notes=2Etxt
M src/openvpn/manage=2Ec
2=
 files changed, 57 insertions(+), 0 deletions(-)




diff --git a/doc/manag=
ement-notes=2Etxt b/doc/management-notes=2Etxt
index eac91a4=2E=2Eb9b367f 1=
00644
--- a/doc/management-notes=2Etxt
+++ b/doc/management-notes=2Etxt
@@ =
-304,6 +304,9 @@
     username "Auth" foo
     password "Auth" bar
 
+  The=
 same format is used for HTTP and SOCKS proxy username and password
+  with=
 'Auth' replaced by 'HTTP Proxy' and 'SOCKS Proxy' respectively=2E
+
   Exa=
mple 3:
 
     >PASSWORD:Need 'Auth' username
@@ -394,6 +397,31 @@
   respo=
nse along with the username and password formatted as described
   in the C=
hallenge/Response Protocol section below
 
+  Example 10:
+
+    >PASSWORD:=
Need '<UP_TYPE>' username/password UN:<user-base64>
+    >PASSWORD:Need 'Au=
th' username/password UN:<user-base64> SC:1,Please enter token PIN
+
+  whe=
re <UP_TYPE> is any supported type that requires username and password=2E
+=
  (see Example 2)=2E
+
+  These work exactly as Examples 2 and 8, respectiv=
ely, with the following
+  difference=2E The prompt has an additional word =
"UN:<user-base64>" where
+  <user-base64> is the base64 encoded form of a p=
re-defined username=2E This
+  may be a username inlined in the config file=
 or read from an external
+  user-pass file=2E
+
+  The management client i=
s expected to show the base64 decoded value to
+  the user=2E Whether the u=
ser can change this username or not is left to
+  the client implementation=
=2E
+
+  The response from the management client should follow the same for=
mat
+  as in example 2 or example 8, as applicable=2E
+
+  This prompt is s=
hown only if the management-client announces a
+  version >=3D 6=2E Older c=
lients will see the prompt shown in Example 2
+  or 8=2E
+
 See the "Challe=
nge/Response Protocol" section below for more details
 about examples 8 and=
 9, including how the management interface client
 should respond=2E
@@ -53=
0,6 +558,7 @@
     >PK_SIGN:[base64],[alg]     -- version 3 or greater
    =
 >PASSWORD:Need 'Auth' username -- version 4 or greater
     multiline pass=
word from client -- version 5 or greater
+    preferred username in >PASSWO=
RD prompt -- version 6 or greater
 
 COMMAND -- auth-retry
 ---------------=
------
@@ -1454,6 +1483,12 @@
 used, the management interface will send:
 
=
   >PASSWORD:Need 'Auth' username/password SC:<flag>,<TEXT>
+  or
+  >PASSW=
ORD:Need 'Auth' username/password UN:<user64> SC:<flag>,<TEXT>
+
+  The sec=
ond form is used only if the client version is >=3D6, and a
+  preferred us=
ername is available=2E See also Example 10 in the section
+  titled "COMMAN=
D -- password and username"
 
   flag: an integer whose least significant b=
it is the ECHO flag and
         the next significant bit is the FORMAT fla=
g=2E
@@ -1463,6 +1498,7 @@
         as described below=2E Thus flag could t=
ake values 0, 1, 2, or 3=2E
   TEXT: challenge text that should be shown to=
 the user to
       facilitate their response
+  user64: Preferred username=
, if available, base64 encoded=2E
 
 For example:
 
diff --git a/src/openvp=
n/manage=2Ec b/src/openvpn/manage=2Ec
index 0fc9ee2=2E=2E65e2881 100644
---=
 a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -71,6 +71,7 @@
  =
   MCV_PKSIGN_ALG =3D 3,
     MCV_USERNAME_ONLY =3D 4,
     MCV_MULTILINE_P=
ASSWORD =3D 5,
+    MCV_PREFERRED_USERNAME =3D 6,
 };
 
 struct management =
*management; /* GLOBAL */
@@ -3670,6 +3671,26 @@
             buf_printf(&a=
lert_msg, " MSG:%s", up->username);
         }
 
+        if (up_query_mode=
 =3D=3D UP_QUERY_USER_PASS
+            && (man->connection=2Eclient_versio=
n >=3D MCV_PREFERRED_USERNAME)
+            && up->username[0])
+        {
=
+            /*
+             * The buffer up is prefilled with username fr=
om auth-file or inline=2E
+             * Indicate it in the prompt as base=
64 encoded=2E
+             */
+            char *user64 =3D NULL;
+       =
     if (openvpn_base64_encode(up->username, (int)strlen(up->username), &us=
er64) !=3D -1)
+            {
+                buf_printf(&alert_msg, " UN:=
%s", user64);
+            }
+            else
+            {
+            =
    msg(M_NONFATAL, "ERROR: could not base64-encode username");
+          =
  }
+            free(user64);
+        }
+
         if (sc)
         {
   =
          buf_printf(&alert_msg, " SC:%d,%s",

-- 
To view, visit https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: Iac23d5141a8c29e239d0f2aeea497d3a002e609b
Gerrit-=
Change-Number: 2069
Gerrit-PatchSet: 5
Gerrit-Owner: Selva Nair <selva=2Ena=
ir@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewe=
r: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>

--uB3a+ji6WkE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2069?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Optionally indicate username in &g=
t;PASSWORD &#39;&lt;UP_TYPE&gt;&#39; prompts<br><br>When username is includ=
ed in the config file as inlined or<br>read from a file, indicate it as a p=
referred-username in<br>&gt;PASSWORD Need &#39;&lt;UP_TYPE&gt;&#39; usernam=
e/password prompts where<br>&#39;&lt;UP_TYPE&gt;&#39; could be &#39;Auth&#3=
9;, &#39;HTTP Proxy&#39; or &#39;SOCKS Proxy&#39;=2E<br>The prompt is appen=
ded with &quot;UN:&lt;user64&gt;&quot; where &lt;user64&gt; is<br>the pre-d=
efined username, base64 encoded=2E<br><br>This is treated as a hint, not an=
 enforced value=2E The management<br>client still responds with both userna=
me and password obtained<br>from the user=2E Whether the management client =
allows the<br>user to input a different username is left to the client<br>i=
mplementation=2E<br><br>The documentation in management-notes is slightly e=
dited to add<br>that &#39;Auth&#39;, &#39;HTTP Proxy&#39;, &#39;SOCKS Proxy=
&#39; are possible types of<br>username/password prompts=2E<br><br>Only cli=
ents that announce version &gt;=3D6 are prompted this way=2E<br><br>This he=
lps to fix user reports on OpenVPN-GUI not respecting username<br>set in th=
e config file=2E<br><br>Change-Id: Iac23d5141a8c29e239d0f2aeea497d3a002e609=
b<br>Signed-off-by: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt;<br>Acked-by=
: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2069<br>Message-Id: &lt;20261030213936=2E100=
1-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/op=
envpn-devel@lists=2Esourceforge=2Enet/msg40351=2Ehtml<br>Signed-off-by: Ger=
t Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M doc/management-notes=
=2Etxt<br>M src/openvpn/manage=2Ec<br>2 files changed, 57 insertions(+), 0 =
deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/doc/management-notes=2Etxt b/doc=
/management-notes=2Etxt</span><br><span>index eac91a4=2E=2Eb9b367f 100644</=
span><br><span>--- a/doc/management-notes=2Etxt</span><br><span>+++ b/doc/m=
anagement-notes=2Etxt</span><br><span>@@ -304,6 +304,9 @@</span><br><span> =
    username &quot;Auth&quot; foo</span><br><span>     password &quot;Auth&=
quot; bar</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  The same format is used for HTTP and SOCKS proxy username and pas=
sword</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  with &#39;Au=
th&#39; replaced by &#39;HTTP Proxy&#39; and &#39;SOCKS Proxy&#39; respecti=
vely=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span>   Example 3:</span><br><span> </span><br><span>     &gt;PASSWORD:Need=
 &#39;Auth&#39; username</span><br><span>@@ -394,6 +397,31 @@</span><br><sp=
an>   response along with the username and password formatted as described<=
/span><br><span>   in the Challenge/Response Protocol section below</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Example=
 10:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    &gt;PASSWORD:Need &#39;&lt;UP_=
TYPE&gt;&#39; username/password UN:&lt;user-base64&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    &gt;PASSWORD:Need &#39;Auth&#39; use=
rname/password UN:&lt;user-base64&gt; SC:1,Please enter token PIN</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  where &lt;UP_TYPE&gt; is any supported type th=
at requires username and password=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  (see Example 2)=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 These work exactly as Examples 2 and 8, respectively, with the following</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  difference=2E The p=
rompt has an additional word &quot;UN:&lt;user-base64&gt;&quot; where</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;user-base64&gt; is =
the base64 encoded form of a pre-defined username=2E This</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  may be a username inlined in the co=
nfig file or read from an external</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  user-pass file=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Th=
e management client is expected to show the base64 decoded value to</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  the user=2E Whether the u=
ser can change this username or not is left to</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  the client implementation=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  The response from the management client should follow =
the same format</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  as=
 in example 2 or example 8, as applicable=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  This prompt is shown only if the management-client announces a</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  version &gt;=3D 6=2E O=
lder clients will see the prompt shown in Example 2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  or 8=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> See the &quot;Challenge/Response =
Protocol&quot; section below for more details</span><br><span> about exampl=
es 8 and 9, including how the management interface client</span><br><span> =
should respond=2E</span><br><span>@@ -530,6 +558,7 @@</span><br><span>     =
&gt;PK_SIGN:[base64],[alg]     -- version 3 or greater</span><br><span>    =
 &gt;PASSWORD:Need &#39;Auth&#39; username -- version 4 or greater</span><b=
r><span>     multiline password from client -- version 5 or greater</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    preferred username in &=
gt;PASSWORD prompt -- version 6 or greater</span><br><span> </span><br><spa=
n> COMMAND -- auth-retry</span><br><span> ---------------------</span><br><=
span>@@ -1454,6 +1483,12 @@</span><br><span> used, the management interface=
 will send:</span><br><span> </span><br><span>   &gt;PASSWORD:Need &#39;Aut=
h&#39; username/password SC:&lt;flag&gt;,&lt;TEXT&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  or</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  &gt;PASSWORD:Need &#39;Auth&#39; username/password UN:=
&lt;user64&gt; SC:&lt;flag&gt;,&lt;TEXT&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  The second form is used only if the client version is &gt;=3D6, and =
a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  preferred userna=
me is available=2E See also Example 10 in the section</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  titled &quot;COMMAND -- password and us=
ername&quot;</span><br><span> </span><br><span>   flag: an integer whose le=
ast significant bit is the ECHO flag and</span><br><span>         the next =
significant bit is the FORMAT flag=2E</span><br><span>@@ -1463,6 +1498,7 @@=
</span><br><span>         as described below=2E Thus flag could take values=
 0, 1, 2, or 3=2E</span><br><span>   TEXT: challenge text that should be sh=
own to the user to</span><br><span>       facilitate their response</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  user64: Preferred usernam=
e, if available, base64 encoded=2E</span><br><span> </span><br><span> For e=
xample:</span><br><span> </span><br><span>diff --git a/src/openvpn/manage=
=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 0fc9ee2=2E=2E65e2881 10=
0644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src=
/openvpn/manage=2Ec</span><br><span>@@ -71,6 +71,7 @@</span><br><span>     =
MCV_PKSIGN_ALG =3D 3,</span><br><span>     MCV_USERNAME_ONLY =3D 4,</span><=
br><span>     MCV_MULTILINE_PASSWORD =3D 5,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    MCV_PREFERRED_USERNAME =3D 6,</span><br><span> =
};</span><br><span> </span><br><span> struct management *management; /* GLO=
BAL */</span><br><span>@@ -3670,6 +3671,26 @@</span><br><span>             =
buf_printf(&amp;alert_msg, &quot; MSG:%s&quot;, up-&gt;username);</span><br=
><span>         }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (up_query_mode =3D=3D UP_QUERY_USER_PASS</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; (man=
-&gt;connection=2Eclient_version &gt;=3D MCV_PREFERRED_USERNAME)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; up-&gt;=
username[0])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /*</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+             * The buf=
fer up is prefilled with username from auth-file or inline=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+             * Indicate it in the=
 prompt as base64 encoded=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+             */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            char *user64 =3D NULL;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            if (openvpn_base64_encode(up-&gt;username, =
(int)strlen(up-&gt;username), &amp;user64) !=3D -1)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                buf_printf(&amp;alert_msg, &quo=
t; UN:%s&quot;, user64);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      msg(M_NONFATAL, &quot;ERROR: could not base64-encode username&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            free(user64);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         if =
(sc)</span><br><span>         {</span><br><span>             buf_printf(&am=
p;alert_msg, &quot; SC:%d,%s&quot;,</span><br></pre><p>To view, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demail">change 2=
069</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: Iac23d5141a8c29e239d0f2aeea497d3a002e609b </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 2069 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: Selva Nair &l=
t;selva=2Enair@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>

</body></html>
--uB3a+ji6WkE=--


--===============5559994771673673034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5559994771673673034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5559994771673673034==--

