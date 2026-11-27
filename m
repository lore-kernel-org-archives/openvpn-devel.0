Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F15606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jeUcKbgl;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=I2Pah5ae;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=S1EYftaP;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=KCxJHsJB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XvoFKBQvROW+g++2btFUQf0X8KpP1KJ2fJ0R31Xme4Y=; b=jeUcKbgl6N0oEh0+QVotodoVfw
	JxoaXSSnd/42sVr0PdeEgpx3GDN6sA/YyukBX2N927zE23bHeHPbeGxo/O0L9sBPa3PBV6aQDBrh6
	lXmw7/7wfV8V3PbRbnjGCPqrOcpJvu4KDGVQ4a6FMnm2VMIwD5qZ3FAdfYjl+7rmEzEk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX23J-000000008F3-0voV;
	Fri, 27 Nov 2026 19:56:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xX23H-000000008Ex-18pF
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 19:56:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HUvUlbilEt7a2QMRZGlRkipgfMoAztlJgZ80wj7VxGk=; b=I2Pah5ae9kWmny7+Em81G3LcA/
 gdZZvPWu3zgpK0gUmQV3AXA2hjkfe2uB6JC22MI743inL9vOREj+FM9g9Iv++EyfMyKrpmcpszztP
 LJkTyBlHwB+F5xdAOJ9b4JDy7einhYAxfaavGjzn5IxX+FcGxS3XP/lxnwNKkpx9Z21s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HUvUlbilEt7a2QMRZGlRkipgfMoAztlJgZ80wj7VxGk=; b=S1EYftaPM+I1xH7mizakbU+YKn
 6mqqnWE6zdvdfPuXydJDlgkFIqA8eC8LWRJIN9fVNJSank6ioKFbAEBwYo+tOl7bbKKKmbe47W3Nl
 a2leaHnni1lMdmF7F0v3+FpZz1T2TInHwqNY/ORofE3Rmawk/ZBZtaYtS5w387H05mBw=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xX23G-000000004Vt-1Eu6 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 19:56:11 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4bb85e07aadso103716145e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 11:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795809363; x=1796414163; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HUvUlbilEt7a2QMRZGlRkipgfMoAztlJgZ80wj7VxGk=;
 b=KCxJHsJBXkD1mU7fhPkwAt6d6hkt/1utCzzvriBy+L57OxWwsG1Q5aik0ncNh8VLd0
 lQipUbRxr1NRS14PnUKS3nUZQluNMGZJ6NYpyJTXX/GcqpL1yzQgU0plO7I9El4Z1Mk6
 xV53uP3E3prhVlmVcOo5qrFAviYajbuz9hzKuwtPvdGM3MOsLUnGXF/S4e2TuywBb1e3
 U7P78W1VlbRnqu6Om1AejloJWyAiPnJvA0/NtqMErb0wU1G1rwGHFwRcuDWJKwXT3/Jb
 ZG9ar8IVybedPforDfmja+hFQ/tk1q/gk0ZehI6OUmmN22rQzzxiRfAuGAIW6VlSyyrU
 Wzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795809363; x=1796414163;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HUvUlbilEt7a2QMRZGlRkipgfMoAztlJgZ80wj7VxGk=;
 b=RPG2Z9QmRGlcByVJvPBdwb0bVHNGmG8B96uu/Pwj9IK4QuZBH+H0KuQSDFgvmBveaM
 ET7ds0hAaXB4vU91xQO44j2bIok4pPKpG4JbBMnatw9h/N5fWxmnNXj6Lv0DruIZR9mW
 i2jbwVboTR4GXs/l2q8ZPHUKMBjk/FxH6a6WSpg4AM+mcI9kZ1G8pv9qo9T8hzELqoo0
 NrxbNSq3yN/Mmm0QWxS+8GS8ntWbeMwxDUTV4u7MyOZegepwgGxZT0/SjCwRX96aT0wG
 Xl4aJqbB1L2F/adDdJN1VpAXIDDqYgvzkh5BcmYJJUzI1zRNRJsezJBGT+A3ziNxH9Ve
 G9zw==
X-Forwarded-Encrypted: i=1;
 AL+hErHdyKXXW7ziDc9ZGNs+rNFIMyftWNifxoqZQJRYGSWA7e3EPjbiKcuD6iX4ZF9AhStf0Qw39/CXQE7Lq0cr@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+gh0spFCUGrCG8fWG3vc36LedgJO7ekYS9qxp3qMvBZiHO7leY
 h3skiTPJ9+yk3AxZDPvcj7CIRpel9e6Bhnl5iovXP5HJf1P6krj7zRo7emFltTgB8jg2awEMU5s
 oJULoevAQ1GwBI0Qxlj+j3FYdmnUGUJRFGMIDtiljs1Z2RjMEGA+vBupYrnpktM13t8u/
X-Gm-Gg: AZFdTZec4x2Sq2I0qp4fV31nDc8YV5AfpA8grJ+7VHeTdhdd5jcS+9Zh9LVFDqFwGv5
 3v+9qhfjBhFdyEqhcZ9te+JWnXqMBmboohGrjBDoQqlVG/u/m0rSwM5grGPHHFLwmp80+SvfUm0
 Voq477gIgJ/FD4qPYEWP1M4+pj48ryE9hhf2jVifhxEhBk44ey9LE8AYXs599huqf/q8l/T9qAG
 BerzNQFJ170+M9KyQ0X/+LXbgirQOiTlEAvBSeLghgEAikgr0zsuG1rhQjbWMTXasoCsVf/E6r7
 DNg0jLOPwZys5UfAsIr98xeNWwml90uzdzJVcZoGMNFhQU4tnmv17FsACrQkeYDw3NFWcf1OW+g
 yh2FIkaEd/YOd6RX9hyOb9PZL7L7RM2anXrkW0SesEz+5Xk1m/nJWGgPDGL6WYui71dSZq8vGK9
 A7Dx5XpAUIyVi3APW+rJF83IyMt3hI+fY8jHDLuz1g80joNmYYAvB8psym8NwqbTALUsQrab2VQ
 2pn/MPWAVKnSCVFm3CWjzW2MSVvXae5gz9Jl1ecxNZALM7vViq0tji7fzLk13gmGEz3ica6r5V9
 l2o56HridvbCYOzDA5Oj9pld3DTW/3m+TijGD/bTHTn0S07UIFw/ejQhBcHD43g+sPXXT2S5cpt
 H9WpHMOST3nT+Yb15oaGcEYmtl3sfd6cBa4TfI9Isb1isPDJEEwDiZaFjjB5Jhs6sNq4WSBN5Sx
 7Lb/M7ljKn7L4M5Bk=
X-Received: by 2002:a05:600c:a4b:b0:4a1:dade:f049 with SMTP id
 5b1f17b1804b1-4bb88806292mr537026145e9.15.1795809363254; 
 Fri, 27 Nov 2026 11:56:03 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884911e3sm876481365e9.6.2026.11.27.11.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:56:02 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 19:56:02 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I32f1edf8b289ea2f7fda35e32260909c6409344e
X-Gerrit-Change-Number: 2357
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2357?usp=email>
X-Gerrit-Commit: dd4fcd29480665a4857a9261637d061a44f57bae
In-Reply-To: <gerrit.1795714582000.I32f1edf8b289ea2f7fda35e32260909c6409344e@gerrit.openvpn.net>
References: <gerrit.1795714582000.I32f1edf8b289ea2f7fda35e32260909c6409344e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NzE0NTgyMDAwLkkzMmYxZWRmOGIyODllYTJmN2ZkYTM1ZTMyMjYwOTA5YzY0MDkzNDRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <45cac4f458c56eaefd8d9ad41bce374ab0636fc5-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xX23G-000000004Vt-1Eu6
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: Avoid
 sign conversion warnings related to string conversion
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2517805091247072612=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2517805091247072612==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MODOe0wgQKw="; charset=UTF-8

--MODOe0wgQKw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2357?usp=3Demail )

Change subject: openvpnserv: Avoid sign con=
version warnings related to string conversion
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: Avoid sign conversion warni=
ngs related to string conversion

MultiByteToWideChar and similar functions=
 take int and
return int=2E Nothing we can do about that except cast=2E

Ch=
ange-Id: I32f1edf8b289ea2f7fda35e32260909c6409344e
Signed-off-by: Frank Lic=
htenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2357
Messa=
ge-Id: <20261126192127=2E18879-1-gert@greenie=2Emuc=2Ede>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg42064=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpns=
erv/common=2Ec
M src/openvpnserv/interactive=2Ec
2 files changed, 5 inserti=
ons(+), 14 deletions(-)




diff --git a/src/openvpnserv/common=2Ec b/src/o=
penvpnserv/common=2Ec
index e20feb7=2E=2Eca4fc15 100644
--- a/src/openvpnse=
rv/common=2Ec
+++ b/src/openvpnserv/common=2Ec
@@ -30,11 +30,6 @@
 LPCWSTR =
service_instance =3D L"";
 static wchar_t win_sys_path[MAX_PATH];
 
-#if de=
fined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma=
 GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 static DWORD
 GetReg=
String(HKEY key, LPCWSTR value, LPWSTR data, DWORD size, LPCWSTR default_va=
lue)
 {
@@ -301,11 +296,11 @@
 utf8to16_size(const char *utf8, int size)
 {=

     int n =3D MultiByteToWideChar(CP_UTF8, 0, utf8, size, NULL, 0);
-    =
if (n =3D=3D 0)
+    if (n <=3D 0)
     {
         return NULL;
     }
-   =
 wchar_t *utf16 =3D malloc(n * sizeof(wchar_t));
+    wchar_t *utf16 =3D ma=
lloc((size_t)n * sizeof(wchar_t));
     if (!utf16)
     {
         return =
NULL;
@@ -314,10 +309,6 @@
     return utf16;
 }
 
-#if defined(__GNUC__) |=
| defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 const wchar_t *=

 get_win_sys_path(void)
 {
diff --git a/src/openvpnserv/interactive=2Ec b/=
src/openvpnserv/interactive=2Ec
index 1cb191a=2E=2Ee94ece3 100644
--- a/src=
/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -2766=
,7 +2766,7 @@
         size_t domains_len =3D strlen(domains);
         dom=
_size =3D (DWORD)domains_len + 2; /* len + the trailing NULs */
 
-        =
wide_domains =3D utf8to16_size(domains, dom_size);
+        wide_domains =
=3D utf8to16_size(domains, (int)dom_size);
         if (!wide_domains)
    =
     {
             return ERROR_OUTOFMEMORY;
@@ -3920,9 +3920,9 @@
     Cl=
oseHandleEx(&stdin_read);
     CloseHandleEx(&svc_pipe);
 
-    DWORD input=
_size =3D WideCharToMultiByte(CP_UTF8, 0, sud=2Estd_input, -1, NULL, 0, NUL=
L, NULL);
+    int input_size =3D WideCharToMultiByte(CP_UTF8, 0, sud=2Estd=
_input, -1, NULL, 0, NULL, NULL);
     LPSTR input =3D NULL;
-    if (input=
_size && (input =3D malloc(input_size)))
+    if (input_size > 0 && (input =
=3D malloc((size_t)input_size)))
     {
         DWORD written;
         Wi=
deCharToMultiByte(CP_UTF8, 0, sud=2Estd_input, -1, input, input_size, NULL,=
 NULL);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2357=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:=
//gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I32f1edf8b28=
9ea2f7fda35e32260909c6409344e
Gerrit-Change-Number: 2357
Gerrit-PatchSet: 2=

Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--MODOe0wgQKw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2357?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">openvpnserv: Avoid sign conversion=
 warnings related to string conversion<br><br>MultiByteToWideChar and simil=
ar functions take int and<br>return int=2E Nothing we can do about that exc=
ept cast=2E<br><br>Change-Id: I32f1edf8b289ea2f7fda35e32260909c6409344e<br>=
Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-b=
y: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2357<br>Message-Id: &lt;20261126192127=2E18=
879-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/=
openvpn-devel@lists=2Esourceforge=2Enet/msg42064=2Ehtml<br>Signed-off-by: G=
ert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpnserv/com=
mon=2Ec<br>M src/openvpnserv/interactive=2Ec<br>2 files changed, 5 insertio=
ns(+), 14 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/common=
=2Ec b/src/openvpnserv/common=2Ec</span><br><span>index e20feb7=2E=2Eca4fc1=
5 100644</span><br><span>--- a/src/openvpnserv/common=2Ec</span><br><span>+=
++ b/src/openvpnserv/common=2Ec</span><br><span>@@ -30,11 +30,6 @@</span><b=
r><span> LPCWSTR service_instance =3D L&quot;&quot;;</span><br><span> stati=
c wchar_t win_sys_path[MAX_PATH];</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> static DWORD</span><br><span> GetRegString(HKEY =
key, LPCWSTR value, LPWSTR data, DWORD size, LPCWSTR default_value)</span><=
br><span> {</span><br><span>@@ -301,11 +296,11 @@</span><br><span> utf8to16=
_size(const char *utf8, int size)</span><br><span> {</span><br><span>     i=
nt n =3D MultiByteToWideChar(CP_UTF8, 0, utf8, size, NULL, 0);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (n =3D=3D 0)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (n &lt;=3D 0)</span><br><sp=
an>     {</span><br><span>         return NULL;</span><br><span>     }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    wchar_t *utf16 =3D mal=
loc(n * sizeof(wchar_t));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    wchar_t *utf16 =3D malloc((size_t)n * sizeof(wchar_t));</span><br=
><span>     if (!utf16)</span><br><span>     {</span><br><span>         ret=
urn NULL;</span><br><span>@@ -314,10 +309,6 @@</span><br><span>     return =
utf16;</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span> const wchar_t *</span><=
br><span> get_win_sys_path(void)</span><br><span> {</span><br><span>diff --=
git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</sp=
an><br><span>index 1cb191a=2E=2Ee94ece3 100644</span><br><span>--- a/src/op=
envpnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=
=2Ec</span><br><span>@@ -2766,7 +2766,7 @@</span><br><span>         size_t =
domains_len =3D strlen(domains);</span><br><span>         dom_size =3D (DWO=
RD)domains_len + 2; /* len + the trailing NULs */</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        wide_domains =3D utf8=
to16_size(domains, dom_size);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        wide_domains =3D utf8to16_size(domains, (int)dom_size);</=
span><br><span>         if (!wide_domains)</span><br><span>         {</span=
><br><span>             return ERROR_OUTOFMEMORY;</span><br><span>@@ -3920,=
9 +3920,9 @@</span><br><span>     CloseHandleEx(&amp;stdin_read);</span><br=
><span>     CloseHandleEx(&amp;svc_pipe);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    DWORD input_size =3D WideCharToMu=
ltiByte(CP_UTF8, 0, sud=2Estd_input, -1, NULL, 0, NULL, NULL);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    int input_size =3D WideCharT=
oMultiByte(CP_UTF8, 0, sud=2Estd_input, -1, NULL, 0, NULL, NULL);</span><br=
><span>     LPSTR input =3D NULL;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (input_size &amp;&amp; (input =3D malloc(input_size)))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (input_size &g=
t; 0 &amp;&amp; (input =3D malloc((size_t)input_size)))</span><br><span>   =
  {</span><br><span>         DWORD written;</span><br><span>         WideCh=
arToMultiByte(CP_UTF8, 0, sud=2Estd_input, -1, input, input_size, NULL, NUL=
L);</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2357?usp=3Demail">change 2357</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2357?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I32f1edf8b289ea2f7fda35e322609=
09c6409344e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2357 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D=
"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>

</body></html>
--MODOe0wgQKw=--


--===============2517805091247072612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2517805091247072612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2517805091247072612==--

