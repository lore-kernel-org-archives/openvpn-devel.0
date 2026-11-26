Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58FB606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 17:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Duy2OUIM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=H6yum1D9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VYPretk7;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=QgJjmntD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=EfmQw5Kwtqi681dIT2bqV2q+i+5it86YhEwm+0UppGg=; b=Duy2OUIM0eqn90IPBrTjaKjLaE
	HTeI9oJSGvixXjnHKoMNNp7kcWcpt+J81q0hU62EhdzRbLCPfpQfVmrrThT1SM+g6Oxj/b7gPtseb
	I0Vj8Ah0b/kkE5PCO0veTN6lrgpGP8PMazE+Uq7GkxJ1Swd2k+aOWogp9ubsSVM033Y8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWdOl-000000004Ud-0PLm;
	Thu, 26 Nov 2026 17:36:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWdOc-000000004UT-2Rxh
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 17:36:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yPAdFrQvw3TEDFJX4fyeNtP95nH6uUpvmT/7xeyoxXw=; b=H6yum1D9CKNkm9RbPDYGbP5fKk
 +nUCiuz1SL3M0xsMOddKQKMvN7jnYzgWdltgNlgXhgCh4dejVw+TYYTom/lJ12nsU1b/O24RPAM1D
 nHA60hNEBpaYOyjf7JKEaG1SxXR0ko8Oy+KQ21RPWHul7wvli1zRjBo2hW9kY2Pgllj8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yPAdFrQvw3TEDFJX4fyeNtP95nH6uUpvmT/7xeyoxXw=; b=VYPretk7CJg9DCfjKKzigS62vR
 twq7pCxZd5WKKVx9xpVJMyTPPgyWqA743c+qI3TeV6btV6Lc03jndczneuWdgKp8RHi2XXpu7DMse
 juwBEyCmIsZ5IgnoOVNPXE5opcTgnknjFzcxM4l1XMzMWs4jpDo37LRiXGPP10BIflv4=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWdOa-000000005iw-2OVd for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 17:36:33 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4bba60271d7so18843675e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 09:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795714586; x=1796319386; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yPAdFrQvw3TEDFJX4fyeNtP95nH6uUpvmT/7xeyoxXw=;
 b=QgJjmntDFmbBJtjPaBvLQmFvn5fRRysDWpNc+yBeJGc2WhU4OcMQ24NUueblYyqVAu
 8TM2rs1hGkUzD96r4GrIYuTHQ1UyY1U3DVe1CpzXUkfdkA7emG3qKintuRW5FsPw0xgj
 OtzTjRf8X+qTPHIcl1+1zaZWXogiaco+1pSYVSXA0HL4aAAluhysPnkd202YT1vwJ/qC
 rp3aUBNPKlzLh+61Bywpjw3LQfh1imE2f2WnVXBHw5Ql/9NIICWHfLd9G0QD4UNCdxNg
 XmYpl/JMI6v8B9ugeCyxhbWVK4j5tQmrbNizQY8D2bRFvwYNcCce7qwlVNYfQT+7ssGY
 5QzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795714586; x=1796319386;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yPAdFrQvw3TEDFJX4fyeNtP95nH6uUpvmT/7xeyoxXw=;
 b=QF6VYD8ljM4/a+i9mA7zcHF5lHaQ83ZakmOKHNatQX/kgWPzt2aFgnay6vUNLUXDbN
 V/tZrZG2MyXwR3+viMG6Aj6A72NF8fcATbW9yST3aNM+Y1cX54Jnkv7sq+wReZoCAvfx
 Doi/cwbHgG98siikBrvqFyKbj6NSB1rGGQUQ5gMmyu3ZWOqV8Vldt51gF6oCoXqD7UMk
 TTR7uNhYyubVEC6FxMr5t9V28HkiefPykLeyhs0TU70PhMU/mOt5oTd8LgYuq1pXMVS2
 fseWVhqTaAzjeFdt6AR8/DYtl+9F6E/6JzvDmAC5J7YCgYxkM3fxtAlIKDdH/66MZiIY
 mkaw==
X-Gm-Message-State: APuU4Z/NJBv8EV+sin99s43JQ7lA4zPIgKDitgnA9boX9DI8izfZR+cK
 FUcaP1rpFM5pVWrq5UQx4LjMNKhOkObTet6TY/hPpwP/DVu5yD6zIc/dQmBJjeyhhuITDcOtcKy
 UdJ6ToAhVgIzBfnv309S59IUago41sNVm3mRWmJdL4x22JbIXZZ/x4zKFudkFy9sh5CcCw8r5UO
 KPZskRIg==
X-Gm-Gg: AZFdTZd6qh2xi8hfPkPNu2pl/BXpaKFaGonERPTOyKSbJRYIXn0677TjisAwQfbzGqQ
 Bij/hgRb6ogNPr8gFWEocxXFDuG3qji0vpTMe4SH/9k2shi/VZVSWSelXKlnSM39Mhakmdu/YTr
 PtMxAb2ImnhquMawa55qlRGjyibcWp5ZBH5rh7eVrO/CwORFo3EzFmwsV5o2o9sfyGWFEY8VPaf
 hPMv0DOV7CQ+Eprh1MBZcbD4KEbIEtB5WWTp1Bj+07nSEOFprK01HA+hCeiGN83bSrFItmQx+dK
 WgaygTj+Z0qLPDwILlECDGrAhDPlDYHRECkBbIcY1Bw8MlNy+1uOiCMPpvpFIyxhUL1wlpuQPos
 emnG0oH6Ql72qSBN2RhPSB81ujm8cBwwTed9H5sEBipgmiy5hczxALDG3aVhiwSvf2sPbjt0XRm
 gpzD5ivhexy/9Ae6eACzuSQhho8ylgsX5WJX4nXztoyUMjVtIxqmuo8FR6ZrgtcHv3k5zGmXo+/
 Ymbjv8P/608zVz5g+7W+97LrW8sq4eYN35k0nuEC/UZEjNn3EJSYWFT5gWJyRmQdcSu/sJ/h9S8
 v+HZ2iDkwpenhf01URGoaJSI5edentBKDh/HuH7WfCA2dj4EYdSj/q3UprfO2mLVdJOw2sabIwy
 35yKo55iUY94KXrbIpg2h2+Bppr7uXkserGm/EgDPtpojGGVe645z0k+rIf35vDsK+n1ezcjgP6
 4PNN+OxJ0gV11swEE=
X-Received: by 2002:a05:600c:638f:b0:4aa:2339:a375 with SMTP id
 5b1f17b1804b1-4bb8880607cmr412214725e9.13.1795714585892; 
 Thu, 26 Nov 2026 09:36:25 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8849247asm632131225e9.7.2026.11.26.09.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 09:36:25 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 17:36:25 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I32f1edf8b289ea2f7fda35e32260909c6409344e
X-Gerrit-Change-Number: 2357
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2357?usp=email>
X-Gerrit-Commit: 061b407766b4060e9d92b6e8d5cbae18e3d5db91
References: <gerrit.1795714582000.I32f1edf8b289ea2f7fda35e32260909c6409344e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NzE0NTgyMDAwLkkzMmYxZWRmOGIyODllYTJmN2ZkYTM1ZTMyMjYwOTA5YzY0MDkzNDRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b8f17184deffedfd62f5091487f01ab81127df8f-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWdOa-000000005iw-2OVd
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8680745425305968348=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8680745425305968348==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DESbze5MDpk="; charset=UTF-8

--DESbze5MDpk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2357?usp=3Demail

to review the following change=2E
=


Change subject: openvpnserv: Avoid sign conversion warnings related to st=
ring conversion
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

openvpnserv: Avoid sign conversion warnings related to string conversi=
on

MultiByteToWideChar and similar functions take int and
return int=2E No=
thing we can do about that except cast=2E

Change-Id: I32f1edf8b289ea2f7fda=
35e32260909c6409344e
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2E=
com>
---
M src/openvpnserv/common=2Ec
M src/openvpnserv/interactive=2Ec
2 f=
iles changed, 5 insertions(+), 14 deletions(-)



  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/57/2357/1

diff --git a/src/ope=
nvpnserv/common=2Ec b/src/openvpnserv/common=2Ec
index de7847e=2E=2E6c1250b=
 100644
--- a/src/openvpnserv/common=2Ec
+++ b/src/openvpnserv/common=2Ec
@=
@ -30,11 +30,6 @@
 LPCWSTR service_instance =3D L"";
 static wchar_t win_sy=
s_path[MAX_PATH];
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma G=
CC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#en=
dif
-
 static DWORD
 GetRegString(HKEY key, LPCWSTR value, LPWSTR data, DWO=
RD size, LPCWSTR default_value)
 {
@@ -300,11 +295,11 @@
 utf8to16_size(con=
st char *utf8, int size)
 {
     int n =3D MultiByteToWideChar(CP_UTF8, 0, =
utf8, size, NULL, 0);
-    if (n =3D=3D 0)
+    if (n <=3D 0)
     {
      =
   return NULL;
     }
-    wchar_t *utf16 =3D malloc(n * sizeof(wchar_t));=

+    wchar_t *utf16 =3D malloc((size_t)n * sizeof(wchar_t));
     if (!utf=
16)
     {
         return NULL;
@@ -313,10 +308,6 @@
     return utf16;
 }=

 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop=

-#endif
-
 const wchar_t *
 get_win_sys_path(void)
 {
diff --git a/src/ope=
nvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index 0792a51=2E=
=2Ee99f8b5 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnse=
rv/interactive=2Ec
@@ -2760,7 +2760,7 @@
         size_t domains_len =3D st=
rlen(domains);
         dom_size =3D (DWORD)domains_len + 2; /* len + the t=
railing NULs */
 
-        wide_domains =3D utf8to16_size(domains, dom_size=
);
+        wide_domains =3D utf8to16_size(domains, (int)dom_size);
       =
  if (!wide_domains)
         {
             return ERROR_OUTOFMEMORY;
@@ -=
3917,9 +3917,9 @@
     CloseHandleEx(&stdin_read);
     CloseHandleEx(&svc_=
pipe);
 
-    DWORD input_size =3D WideCharToMultiByte(CP_UTF8, 0, sud=2Est=
d_input, -1, NULL, 0, NULL, NULL);
+    int input_size =3D WideCharToMultiB=
yte(CP_UTF8, 0, sud=2Estd_input, -1, NULL, 0, NULL, NULL);
     LPSTR input=
 =3D NULL;
-    if (input_size && (input =3D malloc(input_size)))
+    if (=
input_size > 0 && (input =3D malloc((size_t)input_size)))
     {
         D=
WORD written;
         WideCharToMultiByte(CP_UTF8, 0, sud=2Estd_input, -1,=
 input, input_size, NULL, NULL);

-- 
To view, visit https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2357?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ger=
rit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I32f1edf8b289ea2f7fda35e32260909c6409344e
Gerrit-Change-Num=
ber: 2357
Gerrit-PatchSet: 1
Gerrit-Owner: Frank Lichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atten=
tion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--DESbze5MDpk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2357?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">openvpnserv: Avoid sign conversion warnings related to str=
ing conversion<br><br>MultiByteToWideChar and similar functions take int an=
d<br>return int=2E Nothing we can do about that except cast=2E<br><br>Chang=
e-Id: I32f1edf8b289ea2f7fda35e32260909c6409344e<br>Signed-off-by: Frank Lic=
htenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpnserv/common=
=2Ec<br>M src/openvpnserv/interactive=2Ec<br>2 files changed, 5 insertions(=
+), 14 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/57/2357/1</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/ope=
nvpnserv/common=2Ec b/src/openvpnserv/common=2Ec</span><br><span>index de78=
47e=2E=2E6c1250b 100644</span><br><span>--- a/src/openvpnserv/common=2Ec</s=
pan><br><span>+++ b/src/openvpnserv/common=2Ec</span><br><span>@@ -30,11 +3=
0,6 @@</span><br><span> LPCWSTR service_instance =3D L&quot;&quot;;</span><=
br><span> static wchar_t win_sys_path[MAX_PATH];</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defin=
ed(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma =
GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#p=
ragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> static DWORD</span><br><span> GetRe=
gString(HKEY key, LPCWSTR value, LPWSTR data, DWORD size, LPCWSTR default_v=
alue)</span><br><span> {</span><br><span>@@ -300,11 +295,11 @@</span><br><s=
pan> utf8to16_size(const char *utf8, int size)</span><br><span> {</span><br=
><span>     int n =3D MultiByteToWideChar(CP_UTF8, 0, utf8, size, NULL, 0);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (n =3D=3D 0)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (n &lt;=3D 0)<=
/span><br><span>     {</span><br><span>         return NULL;</span><br><spa=
n>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wchar_t *=
utf16 =3D malloc(n * sizeof(wchar_t));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    wchar_t *utf16 =3D malloc((size_t)n * sizeof(wchar_t=
));</span><br><span>     if (!utf16)</span><br><span>     {</span><br><span=
>         return NULL;</span><br><span>@@ -313,10 +308,6 @@</span><br><span=
>     return utf16;</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang=
__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagno=
stic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> const wcha=
r_t *</span><br><span> get_win_sys_path(void)</span><br><span> {</span><br>=
<span>diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/intera=
ctive=2Ec</span><br><span>index 0792a51=2E=2Ee99f8b5 100644</span><br><span=
>--- a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnser=
v/interactive=2Ec</span><br><span>@@ -2760,7 +2760,7 @@</span><br><span>   =
      size_t domains_len =3D strlen(domains);</span><br><span>         dom_=
size =3D (DWORD)domains_len + 2; /* len + the trailing NULs */</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        wide_dom=
ains =3D utf8to16_size(domains, dom_size);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        wide_domains =3D utf8to16_size(domains, (int=
)dom_size);</span><br><span>         if (!wide_domains)</span><br><span>   =
      {</span><br><span>             return ERROR_OUTOFMEMORY;</span><br><s=
pan>@@ -3917,9 +3917,9 @@</span><br><span>     CloseHandleEx(&amp;stdin_rea=
d);</span><br><span>     CloseHandleEx(&amp;svc_pipe);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    DWORD input_size =3D=
 WideCharToMultiByte(CP_UTF8, 0, sud=2Estd_input, -1, NULL, 0, NULL, NULL);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int input_size =
=3D WideCharToMultiByte(CP_UTF8, 0, sud=2Estd_input, -1, NULL, 0, NULL, NUL=
L);</span><br><span>     LPSTR input =3D NULL;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (input_size &amp;&amp; (input =3D malloc(in=
put_size)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
input_size &gt; 0 &amp;&amp; (input =3D malloc((size_t)input_size)))</span>=
<br><span>     {</span><br><span>         DWORD written;</span><br><span>  =
       WideCharToMultiByte(CP_UTF8, 0, sud=2Estd_input, -1, input, input_si=
ze, NULL, NULL);</span><br></pre><p>To view, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2357?usp=3Demail">change 2357</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2357?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I32f1edf8b289ea=
2f7fda35e32260909c6409344e </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 2357 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div=
>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--DESbze5MDpk=--


--===============8680745425305968348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8680745425305968348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8680745425305968348==--

