Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DA5606A31E
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jc5dgY4J;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=aFpg3qEz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AtNIFXLP;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HtqA6+Wo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VdGRRGOmULUUml+Ae1UTUqc2PJ+9EmaGvNfJBDRuqM0=; b=jc5dgY4JmFTzC/tQJtlK5wkOMz
	QFCraxWK6ApIm/AAQs0qnGGUtednUWUjw4JMrWkvsJrYmn/WVN1WG3zOBUTwxU91k4+zxDr5VGcXx
	6Z8yzal32e/GA6TjlQtx6g2PY7Bi4ZCy3y80qD6TCFTYRcgIK2Dcv/XIbdzStszHMyvQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX23J-00000000650-2WTx;
	Fri, 27 Nov 2026 19:56:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xX23H-0000000064t-0SiU
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 19:56:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Fx6MA16M8L2pteEkCaSR3E2oPShRSSxXTDqxE16a/ZY=; b=aFpg3qEzxfzFdAX3HMzCYZ6jfj
 N86FYNlk04+EK2ltITXvNtMZBC6Ytsm/LIcbSVR67/GaUGGgPJmyKlEDugH5d1y/Jf3vxfZt4LIeE
 myBRlTkuSHWtijPodhJSLfUqTCUJ4ykd5UKKj4hVktkV6YOw85705tlUPcszLmPk6k8E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Fx6MA16M8L2pteEkCaSR3E2oPShRSSxXTDqxE16a/ZY=; b=AtNIFXLPM41amIBZtdKFc57D7V
 S+yrm2lUcVUk/c2t5feFB5V4RSgeDi2ARZiORR8dkGWdN1SeBwk9kv7CWqopPt9SLu/n8fxqhRees
 SKTiXLPcwo26nvRtA9q2Jgk+zMZSKxeMgMGATIByi5iFUaZgEFZF95iIcuOzvKM+03Xw=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xX23F-000000001cA-1Yp3 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 19:56:10 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-4a7b8abe209so6597785f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 11:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795809363; x=1796414163; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Fx6MA16M8L2pteEkCaSR3E2oPShRSSxXTDqxE16a/ZY=;
 b=HtqA6+Wo/09UQJcftpOYbnNBETZ7/lyGIURa9a//jBM7F867XBFF6i8aPkJw5SIP9Y
 ChIhuKs8j8HzmkqDb3168KivWtzVsCnv+J223gXUSXGHG+7Z+9DIYHdtRb+cfzOWA+pS
 hGavkr6gb5foRNyNxPBy/Kcdx/KRxP+i4uiTj9LBtuXynjpLfNX7o2JmzgBykxoas68r
 x2/Ox+AwEhULuz3AOD+Vy8nsJ2Upwbo+cqzHxR3wbFrUgvq4UvKhKuBxFAIcgwF5nbjy
 H1vGLALZvoY3ual1aCEmk+TZHH8xT2eNc2bDUro3cGLXRFMdSkIGPlCT4FhpPYUnKVtW
 A8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795809363; x=1796414163;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Fx6MA16M8L2pteEkCaSR3E2oPShRSSxXTDqxE16a/ZY=;
 b=16hKirD33NR7dLT5+2VOdiuQUz/5w3K+uI3zVoK4wNZ0NP/1AJJYpJWRasyPYhPAq8
 1zPnYvl+ufsjG5Ak27QXMNCp3sEf4OgEiGUGODwpXi3H5rNCb7v7TpwIYTADx5U6DqTT
 S/5WWoAuziJ1IdgStTurf/AQhm3Yc0PHeQmhyCAUmRf8e53qGTT0cCqP6Z/hpWcgK3hx
 1rVl4z+nETZTATXYeVHZPqGPofNgW7tnfzgSwGyZSVfB/p01LCSwkZT/N1BMFCE69g12
 Jyfa3PRJ/2ix+VxlpijuyZHizcDx8Fq8CllFkGh3H7Hf5fks95lCOXyGtmbUD2ihhnJp
 0dHg==
X-Gm-Message-State: APuU4Z8VeYOECMPTF0MRHbriQFJJIFANOX5BJq7IKbnsAz/LDOqt7m+a
 Q5BwaCzv+tps/xJv7Rc7YhR6XIvcoiBBfA1wQ+ZxnEmkkyAQyGI30Xm0DjN7F7KJESx08BTo5lc
 z2mCsuyYC3lr682Q7b2JnVNI4qYNCxneS0NQMmToUagGAf/3vzNcri55nMzuHkfy1i9d/
X-Gm-Gg: AZFdTZdpLtTXgWIfp/is3GDR16GVpOobf025SrCDfVkhg9lxKBqzwAprguKz0qDMsuu
 XmUHPi+kkknl99qddlHZEmNQQcBgqppqTAhp0Ppsl9ZbqwQ6llDgLuaNQKlcgQu495tSRVi3h7s
 iqssU82ykGp2MjYsBdHLbch9R1BqjJzUl8YoV8f0aRrpe8JpKhvDJiE8CSJXTu4sGaRtXF7zKDE
 4RtKDY+gJ31Np68AWMZyIUoU8ykxlEvpvR0oriQlVeemb2y3hGRPJIZGFKpdjhfqE4hnzmbCVnK
 8DGoCJZ8n65goHwGsXCs9pq55CdofRhU7323nNf6ROcdpUuMp+V71WreTlTIzWpC53MUhqsKTuQ
 PW85Bz3iShlefU5QoPZS68fg4XWRcYCVTRXtgMrNEeFZsBHFII0rZnWHbBRHIt+ToJZt6pXTNqe
 vWHcKE5Uttud5EUmiTGWu0wHKpqstmZxPM8iUHSqPacHD+/SaBL9GZoLDqb1CDOFh9lRtr24MUC
 WXpsSJ65aAuDQK3lHFzsYJ3PGy7JI/xukzZAC8Y7gtAAO6J6uOkFpwm/Yx0VHXwuGEbkoo31/rd
 w52nGuRS376lbRGt0+qdrHXblrbSHEmFTB5aurP6C/1Njv5e8NBu9wQ06zZI2gfWp0Im93x5Dm9
 KYZyTsAabAevezk28T7xab9ToD69PR8hZKBPgDrB29fFFU2QHlK4eSQWf4MvgnsEoecPt43WWO+
 2YN0T6JZpvDakbyjQ=
X-Received: by 2002:a05:600c:64c7:b0:4bb:872a:f500 with SMTP id
 5b1f17b1804b1-4bb887c2697mr523388275e9.3.1795809362494; 
 Fri, 27 Nov 2026 11:56:02 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb90660cb4sm686743895e9.2.2026.11.27.11.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:56:02 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 19:56:01 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I32f1edf8b289ea2f7fda35e32260909c6409344e
X-Gerrit-Change-Number: 2357
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2357?usp=email>
X-Gerrit-Commit: dd4fcd29480665a4857a9261637d061a44f57bae
In-Reply-To: <gerrit.1795714582000.I32f1edf8b289ea2f7fda35e32260909c6409344e@gerrit.openvpn.net>
References: <gerrit.1795714582000.I32f1edf8b289ea2f7fda35e32260909c6409344e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NzE0NTgyMDAwLkkzMmYxZWRmOGIyODllYTJmN2ZkYTM1ZTMyMjYwOTA5YzY0MDkzNDRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <45cac4f458c56eaefd8d9ad41bce374ab0636fc5-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xX23F-000000001cA-1Yp3
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2024541107618809914=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2024541107618809914==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xeEjTsrJMAo="; charset=UTF-8

--xeEjTsrJMAo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
357?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: openvpnserv: Avoid s=
ign conversion warnings related to string conversion
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: Avoid sign conversion=
 warnings related to string conversion

MultiByteToWideChar and similar fun=
ctions take int and
return int=2E Nothing we can do about that except cast=
=2E

Change-Id: I32f1edf8b289ea2f7fda35e32260909c6409344e
Signed-off-by: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvan=
c@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/235=
7
Message-Id: <20261126192127=2E18879-1-gert@greenie=2Emuc=2Ede>
URL: https=
://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg4206=
4=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/op=
envpnserv/common=2Ec
M src/openvpnserv/interactive=2Ec
2 files changed, 5 i=
nsertions(+), 14 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/57/2357/2

diff --git a/src/openvpnserv/common=2Ec =
b/src/openvpnserv/common=2Ec
index e20feb7=2E=2Eca4fc15 100644
--- a/src/op=
envpnserv/common=2Ec
+++ b/src/openvpnserv/common=2Ec
@@ -30,11 +30,6 @@
 L=
PCWSTR service_instance =3D L"";
 static wchar_t win_sys_path[MAX_PATH];
 
=
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-=
#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 static DWORD
=
 GetRegString(HKEY key, LPCWSTR value, LPWSTR data, DWORD size, LPCWSTR def=
ault_value)
 {
@@ -301,11 +296,11 @@
 utf8to16_size(const char *utf8, int s=
ize)
 {
     int n =3D MultiByteToWideChar(CP_UTF8, 0, utf8, size, NULL, 0)=
;
-    if (n =3D=3D 0)
+    if (n <=3D 0)
     {
         return NULL;
    =
 }
-    wchar_t *utf16 =3D malloc(n * sizeof(wchar_t));
+    wchar_t *utf16=
 =3D malloc((size_t)n * sizeof(wchar_t));
     if (!utf16)
     {
         =
return NULL;
@@ -314,10 +309,6 @@
     return utf16;
 }
 
-#if defined(__GN=
UC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 const wc=
har_t *
 get_win_sys_path(void)
 {
diff --git a/src/openvpnserv/interactive=
=2Ec b/src/openvpnserv/interactive=2Ec
index 1cb191a=2E=2Ee94ece3 100644
--=
- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@=
@ -2766,7 +2766,7 @@
         size_t domains_len =3D strlen(domains);
     =
    dom_size =3D (DWORD)domains_len + 2; /* len + the trailing NULs */
 
- =
       wide_domains =3D utf8to16_size(domains, dom_size);
+        wide_dom=
ains =3D utf8to16_size(domains, (int)dom_size);
         if (!wide_domains)=

         {
             return ERROR_OUTOFMEMORY;
@@ -3920,9 +3920,9 @@
  =
   CloseHandleEx(&stdin_read);
     CloseHandleEx(&svc_pipe);
 
-    DWORD =
input_size =3D WideCharToMultiByte(CP_UTF8, 0, sud=2Estd_input, -1, NULL, 0=
, NULL, NULL);
+    int input_size =3D WideCharToMultiByte(CP_UTF8, 0, sud=
=2Estd_input, -1, NULL, 0, NULL, NULL);
     LPSTR input =3D NULL;
-    if =
(input_size && (input =3D malloc(input_size)))
+    if (input_size > 0 && (=
input =3D malloc((size_t)input_size)))
     {
         DWORD written;
     =
    WideCharToMultiByte(CP_UTF8, 0, sud=2Estd_input, -1, input, input_size,=
 NULL, NULL);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2357?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: ne=
wpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
32f1edf8b289ea2f7fda35e32260909c6409344e
Gerrit-Change-Number: 2357
Gerrit-=
PatchSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>

--xeEjTsrJMAo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2357?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">openvpnserv: Avoid sign conversion warnings related to string conversio=
n<br><br>MultiByteToWideChar and similar functions take int and<br>return i=
nt=2E Nothing we can do about that except cast=2E<br><br>Change-Id: I32f1ed=
f8b289ea2f7fda35e32260909c6409344e<br>Signed-off-by: Frank Lichtenheld &lt;=
frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2357<=
br>Message-Id: &lt;20261126192127=2E18879-1-gert@greenie=2Emuc=2Ede&gt;<br>=
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2En=
et/msg42064=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2E=
de&gt;<br>---<br>M src/openvpnserv/common=2Ec<br>M src/openvpnserv/interact=
ive=2Ec<br>2 files changed, 5 insertions(+), 14 deletions(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/57/2357/2</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpnserv/common=2Ec b/src/openvpns=
erv/common=2Ec</span><br><span>index e20feb7=2E=2Eca4fc15 100644</span><br>=
<span>--- a/src/openvpnserv/common=2Ec</span><br><span>+++ b/src/openvpnser=
v/common=2Ec</span><br><span>@@ -30,11 +30,6 @@</span><br><span> LPCWSTR se=
rvice_instance =3D L&quot;&quot;;</span><br><span> static wchar_t win_sys_p=
ath[MAX_PATH];</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot=
;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> static DWORD</span><br><span> GetRegString(HKEY key, LPCWSTR value, L=
PWSTR data, DWORD size, LPCWSTR default_value)</span><br><span> {</span><br=
><span>@@ -301,11 +296,11 @@</span><br><span> utf8to16_size(const char *utf=
8, int size)</span><br><span> {</span><br><span>     int n =3D MultiByteToW=
ideChar(CP_UTF8, 0, utf8, size, NULL, 0);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (n =3D=3D 0)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (n &lt;=3D 0)</span><br><span>     {</span><br><=
span>         return NULL;</span><br><span>     }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    wchar_t *utf16 =3D malloc(n * sizeof(wchar_=
t));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wchar_t *ut=
f16 =3D malloc((size_t)n * sizeof(wchar_t));</span><br><span>     if (!utf1=
6)</span><br><span>     {</span><br><span>         return NULL;</span><br><=
span>@@ -314,10 +309,6 @@</span><br><span>     return utf16;</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span> const wchar_t *</span><br><span> get_win_sys=
_path(void)</span><br><span> {</span><br><span>diff --git a/src/openvpnserv=
/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index 1c=
b191a=2E=2Ee94ece3 100644</span><br><span>--- a/src/openvpnserv/interactive=
=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>=
@@ -2766,7 +2766,7 @@</span><br><span>         size_t domains_len =3D strle=
n(domains);</span><br><span>         dom_size =3D (DWORD)domains_len + 2; /=
* len + the trailing NULs */</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        wide_domains =3D utf8to16_size(domains, do=
m_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        wid=
e_domains =3D utf8to16_size(domains, (int)dom_size);</span><br><span>      =
   if (!wide_domains)</span><br><span>         {</span><br><span>          =
   return ERROR_OUTOFMEMORY;</span><br><span>@@ -3920,9 +3920,9 @@</span><b=
r><span>     CloseHandleEx(&amp;stdin_read);</span><br><span>     CloseHand=
leEx(&amp;svc_pipe);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    DWORD input_size =3D WideCharToMultiByte(CP_UTF8, 0, s=
ud=2Estd_input, -1, NULL, 0, NULL, NULL);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    int input_size =3D WideCharToMultiByte(CP_UTF8, 0=
, sud=2Estd_input, -1, NULL, 0, NULL, NULL);</span><br><span>     LPSTR inp=
ut =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (i=
nput_size &amp;&amp; (input =3D malloc(input_size)))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (input_size &gt; 0 &amp;&amp; (inp=
ut =3D malloc((size_t)input_size)))</span><br><span>     {</span><br><span>=
         DWORD written;</span><br><span>         WideCharToMultiByte(CP_UTF=
8, 0, sud=2Estd_input, -1, input, input_size, NULL, NULL);</span><br></pre>=
<p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/235=
7?usp=3Demail">change 2357</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2357?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatc=
hset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<di=
v style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Id: I32f1edf8b289ea2f7fda35e32260909c6409344e </div>=

<div style=3D"display:none"> Gerrit-Change-Number: 2357 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> G=
errit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>

</body></html>
--xeEjTsrJMAo=--


--===============2024541107618809914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2024541107618809914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2024541107618809914==--

