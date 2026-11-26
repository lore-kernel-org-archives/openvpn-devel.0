Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB935606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Pwy/3143;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=nNKne7hw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KiwKdL/H;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LmSB5i/U
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=lxb2nO7TwViom9dvUZlkAqzQ2lr0qadkkVSvqDBYMxw=; b=Pwy/3143KAYM1sExih19QBM6gD
	VN9z1QQLc8blRj9rZNgjBZ3DrKojk2HcCoo7Ty5h7w4q0w5JiwJ+0aTqCcF7HPs0yPN8NDVn+P68w
	VRpiPuK2UPtR7iZxT6JwllEA0Ux22KgD1fXj1I/XRdEQ6iRN1gI7/mOCRJkudx2zepfY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWZOd-000000006h5-3IoN;
	Thu, 26 Nov 2026 13:20:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWZOd-000000006gw-0d4R
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 13:20:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FNwEugZqjhnaTzXRQ0ADXvMryR0VOUJILOohoJ0FErc=; b=nNKne7hwdTht/rvt92Giir4XgE
 CSisC2t8IcQ+tA3HZzhtK9kvS03JbOFzkc0xv2wNNOXEMa9nGGJ5VZbkDuRoYeOO1kXG2X8AQQ93J
 nHQxpxSu0kaq8YhZRoKh2FLB16n939Nvl2Qn2wd3AInJ2SHsjR2H2oKC2h6dDUxhz/SI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FNwEugZqjhnaTzXRQ0ADXvMryR0VOUJILOohoJ0FErc=; b=KiwKdL/HgitfHBsyy0uS+BIB/C
 FmkLXWDAFekg5a9W1sk2HXPZZFP0CCkG1HoYADgTJEmZ2dppQ3X/NVlsV/Q+XacUwyjI1zJ/cuzvC
 VsZrt8sfe82RLPjY9Vz7IAj+dJLrfQ3LMBEwiPIFwyNHvnt4/eUrJhLZthC4GNkrycVo=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWZOZ-000000003di-38BP for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 13:20:19 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so49694825e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 05:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795699209; x=1796304009; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FNwEugZqjhnaTzXRQ0ADXvMryR0VOUJILOohoJ0FErc=;
 b=LmSB5i/UyPHNfTrkoYgvfmhcEaCGMzZeqYfN/kHsc8N8qVFC3m4xxkYtcheu/116Hn
 I1HB8QY0Edu0KSRpAW3XInvK0tBTHhXkWRXRvxMVe9wGzNsXWYFyYJtrP3gaDWc0P3BC
 83QPOs5M7fhdqoBP1Ef/0QDQtSdy4cx+97QlRzGGMTQKVJOKDBwWA8CKl8DrcImpImpu
 yOCdw5gs8V4sSLd8Pb/zZTRl7H5oa18DTIGuHrBd3PZqMMPCEN63bYFcRHTC8VfrN9p4
 cOC820vszIrZY7lX8Rc3mbrXkTbpwgwDB01gEIcvJc0FqjengFAm3Pv9XMxOXnEi81/p
 hqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795699209; x=1796304009;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FNwEugZqjhnaTzXRQ0ADXvMryR0VOUJILOohoJ0FErc=;
 b=OsW8mD4nLpAuyKqofiTk9pN6aEmlh+F3oQc2C5vEO0bJ9wjoLl37oWN2hrsGakongg
 cNxklVYtCX/33NNDnzafdC5p7i831846GEI6Pb8wZE7Jo9Tkx0gqnFM3Lfv4U6JtLAB1
 Mg0N5BaHFKmaFEd2OXKpTLIEd3duJ9vAMy+59blrATCzUSZOPzRAtWIvIgFX1QR6xfSN
 c6gGRxBPW32VdJOIFT3bppjDqZDZ98SXTDoYtzJRQItCsjwhegfbNnjKKi6JDLkxxfuN
 5ii3iZAL1jOkYwft2CrnFl+LcNt4NmfrNLI4X2YZcqu7IjtCPaUgwFW2kRojwNQNrH/Q
 MDFw==
X-Gm-Message-State: APuU4Z/mneM2/BXPRDbnJyxOH7Otb1QOZKqeDa3tETMmK2Shds2YmzJy
 iRRa0Ftpd24JmNflvF5mFcmk2kkS1CtWTFuEvjaspQu3eC1SpnjwWwVAiM5dduU6TbfXi+GtF79
 YDhHFkja3IMJGlZ4IHhBPYFfokJGu2as+8sM99mDAR8MnDtQEU99dp06zAjZNfV0FAuR7t7U+IT
 KEmXqHdA==
X-Gm-Gg: AZFdTZc+iPAWxMdhffZnvcsPVJIG86YiXrvWed9LwgIplq7AXl3q/X1s2qH/maCvxBH
 tFOwcLHHbUVg+Z6klsUWSNBpt5PdQZJS1wN4KWeUZOce9ane/SSgns6zdoBVlaWzkNSO/fpkmhK
 Lq0Bkspljt/OCpQknf8w2bj5TAj5mrJxew+ZiLpXaUoMIiKKtNhT7hi2oj8OhM92rVJoI3VDgF/
 OcbyjQkfpjNwHesVNzVNT6McZYeZmzLKe/9BOnap9yiSosA44qnjE4bDh98qIz+sZlka6iOD6LM
 3VMfXgP/BDlvAR3EZD1/4jvhrUYAqOw3kpayehT+1Gvp1r4uXuPiIIs2JrjMpdX+BzuxZqKphsl
 KYhl0tbUZVviJtt69CAY6suwl9ofmP+yOiPYgB9SuBfTyRCS38F7q0+D12VzLhn9tpXgUiIwwc4
 zmgOxgDMZW9l3ZBZaZdHn76J2QGsVdtVkLOph96PAbYJb+13jwnUCDwz+krd6jWYICbEPQlMDcE
 hexTTnM8Wq/S7y+nR8RIQp/sPqWW7djlB8KeA0/troMA2QlBLFOZRPJ3rFXN2YRLyYibJUMhpan
 cqX4iBmz/PZnwl9SZz30oOSlu8DhQU+aBnFhC1wl8MwDDCDhEyYvxU0eDWZNeU8v2lTOsHKOvEm
 Vb1pg1bI2xVopzjlAMG+jQ81jICQSS0GT5MD61VaQQXUE3QBE/7dC93kC+LVxeVl9d92vnmOjSy
 GLlxjB7gq8pLr4ZyE=
X-Received: by 2002:a05:600c:3547:b0:4a2:a6e:80f5 with SMTP id
 5b1f17b1804b1-4bb888098bfmr428458395e9.11.1795699208641; 
 Thu, 26 Nov 2026 05:20:08 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853ca452sm583696215e9.15.2026.11.26.05.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 05:20:08 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 13:20:07 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1f775940c13cf989cf804bf637d4a63c3fe5aaaf
X-Gerrit-Change-Number: 2355
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2355?usp=email>
X-Gerrit-Commit: 16ea2d6f7698f7600e5c918afef0d8ec37419077
References: <gerrit.1795699206000.I1f775940c13cf989cf804bf637d4a63c3fe5aaaf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njk5MjA2MDAwLkkxZjc3NTk0MGMxM2NmOTg5Y2Y4MDRiZjYzN2Q0YTYzYzNmZTVhYWFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dda635bc3fd7f143a9793718485922b6daf9c17f-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWZOZ-000000003di-38BP
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Cleaning up Windows
 error handling for signing conversion
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
Content-Type: multipart/mixed; boundary="===============7099932446219951254=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7099932446219951254==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Unn+Krp8ZAs="; charset=UTF-8

--Unn+Krp8ZAs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2355?usp=3Demail

to review the following change=2E
=


Change subject: Cleaning up Windows error handling for signing conversion=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Cleaning u=
p Windows error handling for signing conversion

This is a mess, generally=
=2E Most functions return errors
as DWORD, but the Reg* ones use LSTATUS wh=
ich is signed=2E

Trying to untangle this a bit, but still requires copious=

casting=2E

Change-Id: I1f775940c13cf989cf804bf637d4a63c3fe5aaaf
Signed-of=
f-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M include/openvpn-msg=
=2Eh
M src/openvpn/error=2Ec
M src/openvpn/error=2Eh
M src/openvpn/route=2E=
c
M src/openvpn/tun=2Ec
M src/openvpn/win32=2Ec
M src/openvpnserv/common=2E=
c
M src/openvpnserv/interactive=2Ec
8 files changed, 74 insertions(+), 95 d=
eletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/55/2355/1

diff --git a/include/openvpn-msg=2Eh b/include/openvpn-ms=
g=2Eh
index dd20f7b=2E=2E1af45b5 100644
--- a/include/openvpn-msg=2Eh
+++ b=
/include/openvpn-msg=2Eh
@@ -157,7 +157,7 @@
 typedef struct
 {
     messag=
e_header_t header;
-    int error_number;
+    NETIO_STATUS error_number;
 =
} ack_message_t;
 
 typedef struct
diff --git a/src/openvpn/error=2Ec b/src=
/openvpn/error=2Ec
index a3f7990=2E=2E18d0b57 100644
--- a/src/openvpn/erro=
r=2Ec
+++ b/src/openvpn/error=2Ec
@@ -219,18 +219,13 @@
     va_end(arglist=
);
 }
 
-#if defined(_WIN32) && (defined(__GNUC__) || defined(__clang__))
-=
#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-convers=
ion"
-#endif
-
 static const char *
 openvpn_strerror(int err, bool crt_err=
or, struct gc_arena *gc)
 {
 #ifdef _WIN32
     if (!crt_error)
     {
-   =
     return strerror_win32(err, gc);
+        return strerror_win32((DWORD)=
err, gc);
     }
 #endif
     return strerror(err);
@@ -694,10 +689,6 @@
  =
   }
 }
 
-#if defined(_WIN32) && (defined(__GNUC__) || defined(__clang__))=

-#pragma GCC diagnostic pop
-#endif
-
 /*
  * In multiclient mode, put a c=
lient-specific prefix
  * before each message=2E
diff --git a/src/openvpn/e=
rror=2Eh b/src/openvpn/error=2Eh
index 0056d05=2E=2E91d4ffe 100644
--- a/sr=
c/openvpn/error=2Eh
+++ b/src/openvpn/error=2Eh
@@ -406,18 +406,13 @@
 }
 #=
endif
 
-#if defined(_WIN32) && (defined(__GNUC__) || defined(__clang__))
-=
#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-convers=
ion"
-#endif
-
 static inline int
 openvpn_errno_maybe_crt(bool *crt_error)=

 {
     int err =3D 0;
 #ifdef _WIN32
     *crt_error =3D false;
-    err =
=3D GetLastError();
+    err =3D (int)GetLastError();
     if (err =3D=3D E=
RROR_SUCCESS)
     {
         /* error is likely C runtime */
@@ -431,10 +4=
26,6 @@
     return err;
 }
 
-#if defined(_WIN32) && (defined(__GNUC__) ||=
 defined(__clang__))
-#pragma GCC diagnostic pop
-#endif
-
 #include "errle=
vel=2Eh"
 
 #endif /* ifndef ERROR_H */
diff --git a/src/openvpn/route=2Ec =
b/src/openvpn/route=2Ec
index 82cb7f0=2E=2E0a1e65f 100644
--- a/src/openvpn=
/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -2805,7 +2805,7 @@
         ret =
=3D (ack=2Eerror_number =3D=3D ERROR_OBJECT_ALREADY_EXISTS) ? RTA_EEXIST : =
RTA_ERROR;
         if (ret =3D=3D RTA_ERROR)
         {
-            msg(M=
_WARN, "ERROR: route %s failed using service: %s [status=3D%d if_index=3D%l=
u]",
+            msg(M_WARN, "ERROR: route %s failed using service: %s [st=
atus=3D%lu if_index=3D%lu]",
                 (add ? "addition" : "deletion=
"), strerror_win32(ack=2Eerror_number, &gc),
                 ack=2Eerror_n=
umber, rt->iface=2Eindex);
         }
diff --git a/src/openvpn/tun=2Ec b/sr=
c/openvpn/tun=2Ec
index 65edf73=2E=2E074fe20 100644
--- a/src/openvpn/tun=
=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -157,7 +157,7 @@
 
     if (ack=2Eerror_n=
umber !=3D NO_ERROR)
     {
-        msg(M_WARN, "TUN: %s address failed us=
ing service: %s [status=3D%d if_index=3D%lu]",
+        msg(M_WARN, "TUN: %=
s address failed using service: %s [status=3D%lu if_index=3D%lu]",
        =
     (add ? "adding" : "deleting"), strerror_win32(ack=2Eerror_number, &gc)=
, ack=2Eerror_number,
             addr=2Eiface=2Eindex);
         goto out=
;
@@ -228,7 +228,7 @@
 
     if (ack=2Eerror_number !=3D NO_ERROR)
     {
-=
        msg(M_WARN, "TUN: %s DNS domains failed using service: %s [status=
=3D%d if_name=3D%s]",
+        msg(M_WARN, "TUN: %s DNS domains failed usin=
g service: %s [status=3D%lu if_name=3D%s]",
             (add ? "adding" : =
"deleting"), strerror_win32(ack=2Eerror_number, &gc), ack=2Eerror_number,
 =
            dns=2Eiface=2Ename);
         goto out;
@@ -297,7 +297,7 @@
 
 =
    if (ack=2Eerror_number !=3D NO_ERROR)
     {
-        msg(M_WARN, "TUN:=
 %s %s dns failed using service: %s [status=3D%d if_name=3D%s]",
+        m=
sg(M_WARN, "TUN: %s %s dns failed using service: %s [status=3D%lu if_name=
=3D%s]",
             (add ? "adding" : "deleting"), ip_proto_name, strerro=
r_win32(ack=2Eerror_number, &gc),
             ack=2Eerror_number, dns=2Eif=
ace=2Ename);
         goto out;
@@ -353,7 +353,7 @@
 
     if (ack=2Eerror_=
number !=3D NO_ERROR)
     {
-        msg(M_WARN, "TUN: %s WINS failed usin=
g service: %s [status=3D%d if_name=3D%s]",
+        msg(M_WARN, "TUN: %s WI=
NS failed using service: %s [status=3D%lu if_name=3D%s]",
             (add=
 ? "adding" : "deleting"), strerror_win32(ack=2Eerror_number, &gc),
       =
      ack=2Eerror_number, wins=2Eiface=2Ename);
         goto out;
@@ -391,=
7 +391,7 @@
 
     if (ack=2Eerror_number !=3D NO_ERROR)
     {
-        ms=
g(M_NONFATAL, "TUN: setting %s mtu using service failed: %s [status=3D%d if=
_index=3D%lu]",
+        msg(M_NONFATAL, "TUN: setting %s mtu using service=
 failed: %s [status=3D%lu if_index=3D%lu]",
             family_name, strer=
ror_win32(ack=2Eerror_number, &gc), ack=2Eerror_number,
             mtu_ms=
g=2Eiface=2Eindex);
     }
@@ -469,7 +469,7 @@
 
     if (ack=2Eerror_numbe=
r !=3D NO_ERROR)
     {
-        msg(M_NONFATAL, "TUN: creating %s adapter =
using service failed: %s [status=3D%d]",
+        msg(M_NONFATAL, "TUN: cre=
ating %s adapter using service failed: %s [status=3D%lu]",
             pri=
nt_tun_backend_driver(driver_type), strerror_win32(ack=2Eerror_number, &gc)=
,
             ack=2Eerror_number);
     }
@@ -5305,7 +5305,7 @@
 
     if =
(ack=2Eerror_number !=3D NO_ERROR)
     {
-        msg(M_NONFATAL, "TUN: en=
abling dhcp using service failed: %s [status=3D%d if_index=3D%lu]",
+      =
  msg(M_NONFATAL, "TUN: enabling dhcp using service failed: %s [status=3D%l=
u if_index=3D%lu]",
             strerror_win32(ack=2Eerror_number, &gc), a=
ck=2Eerror_number, dhcp=2Eiface=2Eindex);
     }
     else
@@ -5477,7 +5477=
,7 @@
 
     else if (ack=2Eerror_number !=3D NO_ERROR)
     {
-        msg=
(M_WARN, "Register_dns failed using service: %s [status=3D0x%x]",
+        =
msg(M_WARN, "Register_dns failed using service: %s [status=3D0x%lx]",
     =
        strerror_win32(ack=2Eerror_number, &gc), ack=2Eerror_number);
     =
}
 
diff --git a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec
index 241584=
7=2E=2Ea4ed152 100644
--- a/src/openvpn/win32=2Ec
+++ b/src/openvpn/win32=
=2Ec
@@ -1239,7 +1239,7 @@
     if (ack=2Eerror_number !=3D NO_ERROR)
     =
{
         msg(M_WARN,
-            "WFP block: %s block filters using serv=
ice failed: %s [status=3D0x%x if_index=3D%lu]",
+            "WFP block: %s=
 block filters using service failed: %s [status=3D0x%lx if_index=3D%lu]",
 =
            (add ? "adding" : "deleting"), strerror_win32(ack=2Eerror_numbe=
r, &gc), ack=2Eerror_number,
             data=2Eiface=2Eindex);
         g=
oto out;
diff --git a/src/openvpnserv/common=2Ec b/src/openvpnserv/common=
=2Ec
index e20feb7=2E=2Ede7847e 100644
--- a/src/openvpnserv/common=2Ec
+++=
 b/src/openvpnserv/common=2Ec
@@ -38,7 +38,7 @@
 static DWORD
 GetRegString=
(HKEY key, LPCWSTR value, LPWSTR data, DWORD size, LPCWSTR default_value)
 =
{
-    LONG status =3D RegGetValue(key, NULL, value, RRF_RT_REG_SZ, NULL, (=
LPBYTE)data, &size);
+    LSTATUS status =3D RegGetValue(key, NULL, value, =
RRF_RT_REG_SZ, NULL, (LPBYTE)data, &size);
 
     if (status =3D=3D ERROR_F=
ILE_NOT_FOUND && default_value)
     {
@@ -51,7 +51,7 @@
 
     if (status =
!=3D ERROR_SUCCESS)
     {
-        SetLastError(status);
+        SetLastE=
rror((DWORD)status);
         return MsgToEventLog(
             M_SYSERR,
=
             L"Error querying registry value: HKLM\\SOFTWARE\\" _L(PACKAGE_=
NAME) L"%ls\\%ls",
@@ -91,19 +91,18 @@
 
     swprintf(reg_path, _countof(r=
eg_path), L"SOFTWARE\\" _L(PACKAGE_NAME) L"%ls", service_instance);
 
-    =
LONG status =3D RegOpenKeyEx(HKEY_LOCAL_MACHINE, reg_path, 0, KEY_READ, &ke=
y);
+    LSTATUS status =3D RegOpenKeyEx(HKEY_LOCAL_MACHINE, reg_path, 0, K=
EY_READ, &key);
     if (status !=3D ERROR_SUCCESS)
     {
-        SetLast=
Error(status);
+        SetLastError((DWORD)status);
         return MsgToE=
ventLog(M_SYSERR, L"Could not open Registry key HKLM\\%ls not found",
     =
                         reg_path);
     }
 
     /* The default value of R=
EG_KEY is the install path */
-    status =3D GetRegString(key, NULL, insta=
ll_path, sizeof(install_path), NULL);
-    if (status !=3D ERROR_SUCCESS)
+=
    error =3D GetRegString(key, NULL, install_path, sizeof(install_path), N=
ULL);
+    if (error !=3D ERROR_SUCCESS)
     {
-        error =3D status;
=
         goto out;
     }
 
diff --git a/src/openvpnserv/interactive=2Ec b/=
src/openvpnserv/interactive=2Ec
index d155fd6=2E=2Ea2769e8 100644
--- a/src=
/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -545,=
7 +545,7 @@
     return sa_inet;
 }
 
-static DWORD
+static NETIO_STATUS
 I=
nterfaceLuid(const char *iface_name, PNET_LUID luid)
 {
     NETIO_STATUS c=
onvert_status;
@@ -569,16 +569,10 @@
     return memcmp(item, address, size=
of(MIB_UNICASTIPADDRESS_ROW)) =3D=3D 0 ? TRUE : FALSE;
 }
 
-static DWORD
-=
DeleteAddress(PMIB_UNICASTIPADDRESS_ROW addr_row)
-{
-    return DeleteUnic=
astIpAddressEntry(addr_row);
-}
-
-static DWORD
+static NETIO_STATUS
 Handl=
eAddressMessage(address_message_t *msg, undo_lists_t *lists)
 {
-    DWORD =
err;
+    NETIO_STATUS err;
     PMIB_UNICASTIPADDRESS_ROW addr_row;
     B=
OOL add =3D msg->header=2Etype =3D=3D msg_add_address;
 
@@ -621,12 +615,12=
 @@
         err =3D AddListItem(&(*lists)[address], addr_row);
         if=
 (err)
         {
-            DeleteAddress(addr_row);
+            Delete=
UnicastIpAddressEntry(addr_row);
         }
     }
     else
     {
-      =
  err =3D DeleteAddress(addr_row);
+        err =3D DeleteUnicastIpAddressE=
ntry(addr_row);
         if (err)
         {
             goto out;
@@ -122=
5,10 +1219,10 @@
  *
  * @return NO_ERROR on success, or the Windows error =
code for the failure
  */
-static DWORD
+static NETIO_STATUS
 InterfaceIdSt=
ring(PCSTR itf_name, PWSTR str, size_t len)
 {
-    DWORD err;
+    NETIO_S=
TATUS err;
     GUID guid;
     NET_LUID luid;
     PWSTR iid_str =3D NULL;=

@@ -1784,10 +1778,10 @@
  * The gpol value is only valid if the function r=
eturns no error=2E In the error
  * case nothing is changed=2E
  */
-static=
 DWORD
+static LSTATUS
 SetDnsSearchDomains(PCSTR itf_name, PCSTR domains, =
PBOOL gpol, undo_lists_t *lists)
 {
-    DWORD err =3D ERROR_OUTOFMEMORY;
+=
    LSTATUS err =3D ERROR_OUTOFMEMORY;
 
     HKEY list_key;
     BOOL have=
_list =3D GetDnsSearchListKey(itf_name, gpol, &list_key);
@@ -1882,12 +1876=
,12 @@
  * @param family    internet address family to set the servers for
=
  * @param value     the value to set the name servers to
  *
- * @return D=
WORD NO_ERROR on success, a Windows error code otherwise
+ * @return NO_ERR=
OR on success, a Windows error code otherwise
  */
-static DWORD
+static LS=
TATUS
 SetNameServersValue(PCWSTR itf_id, ADDRESS_FAMILY family, PCSTR valu=
e)
 {
-    DWORD err;
+    LSTATUS err;
 
     HKEY itfs;
     if (!GetInte=
rfacesKey(family, &itfs))
@@ -1929,9 +1923,9 @@
  * @param itf_id    the in=
terface id to clear the servers for
  * @param family    internet address f=
amily to clear the servers for
  *
- * @return DWORD NO_ERROR on success, a=
 Windows error code otherwise
+ * @return NO_ERROR on success, a Windows er=
ror code otherwise
  */
-static DWORD
+static LSTATUS
 ResetNameServers(PCW=
STR itf_id, ADDRESS_FAMILY family)
 {
     return SetNameServersValue(itf_i=
d, family, "");
@@ -1940,7 +1934,6 @@
 static DWORD
 HandleDNSConfigMessage=
(const dns_cfg_message_t *msg, undo_lists_t *lists)
 {
-    DWORD err =3D 0=
;
     undo_type_t undo_type =3D (msg->family =3D=3D AF_INET6) ? undo_dns6 =
: undo_dns4;
     unsigned int addr_len =3D msg->addr_len;
 
@@ -1965,10 +1=
958,10 @@
     }
 
     WCHAR iid[64];
-    err =3D InterfaceIdString(msg->=
iface=2Ename, iid, _countof(iid));
-    if (err)
+    DWORD iid_err =3D Int=
erfaceIdString(msg->iface=2Ename, iid, _countof(iid));
+    if (iid_err)
  =
   {
-        return err;
+        return iid_err;
     }
 
     /* We dele=
te all current addresses before adding any
@@ -1976,10 +1969,10 @@
      */=

     if (addr_len > 0 || msg->header=2Etype =3D=3D msg_del_dns_cfg)
     {=

-        err =3D ResetNameServers(iid, msg->family);
+        LSTATUS err =
=3D ResetNameServers(iid, msg->family);
         if (err)
         {
-     =
       return err;
+            return (DWORD)err;
         }
         free=
(RemoveListItem(&(*lists)[undo_type], CmpAny, iid));
     }
@@ -1987,13 +19=
80,14 @@
     if (msg->header=2Etype =3D=3D msg_del_dns_cfg)
     {
       =
  BOOL gpol =3D FALSE;
+        LSTATUS err =3D 0;
         if (msg->domain=
s[0])
         {
             /* setting an empty domain list removes any p=
revious value */
             err =3D SetDnsSearchDomains(msg->iface=2Ename=
, NULL, &gpol, lists);
         }
         ApplyDnsSettings(gpol);
-       =
 return err; /* job done */
+        return (DWORD)err; /* job done */
    =
 }
 
     if (addr_len > 0)
@@ -2020,10 +2014,10 @@
             offset =3D=
 strlen(addrs);
         }
 
-        err =3D SetNameServersValue(iid, msg-=
>family, addrs);
+        LSTATUS err =3D SetNameServersValue(iid, msg->fam=
ily, addrs);
         if (err)
         {
-            return err;
+       =
     return (DWORD)err;
         }
 
         wchar_t *tmp_iid =3D _wcsdup(=
iid);
@@ -2036,13 +2030,14 @@
     }
 
     BOOL gpol =3D FALSE;
+    LSTAT=
US domain_err =3D 0;
     if (msg->domains[0])
     {
-        err =3D SetD=
nsSearchDomains(msg->iface=2Ename, msg->domains, &gpol, lists);
+        do=
main_err =3D SetDnsSearchDomains(msg->iface=2Ename, msg->domains, &gpol, li=
sts);
     }
     ApplyDnsSettings(gpol);
 
-    return err;
+    return (D=
WORD)domain_err;
 }
 
 /**
@@ -2076,7 +2071,7 @@
  * @param itf_id        t=
he VPN interface ID to set the name servers for
  * @param addresses     th=
e list of NRPT addresses
  *
- * @return LSTATUS NO_ERROR in case of succes=
s, a Windows error code otherwise
+ * @return NO_ERROR in case of success, =
a Windows error code otherwise
  */
 static LSTATUS
 SetNameServerAddresses=
(PWSTR itf_id, const nrpt_address_t *addresses)
@@ -2147,7 +2142,7 @@
  * @=
param  size       pointer to the size of the buffer, contains the
  *      =
              size of the addresses on return
  *
- * @return LSTATUS NO_ER=
ROR on success, a Windows error code otherwise
+ * @return NO_ERROR on succ=
ess, a Windows error code otherwise
  */
 static LSTATUS
 GetItfDnsServersV=
4(HKEY itf_key, PSTR addrs, PDWORD size)
@@ -2193,7 +2188,7 @@
  * @param  =
size       pointer to the size of the buffer, contains the
  *             =
       size of the addresses on return
  *
- * @return LSTATUS NO_ERROR on =
success, a Windows error code otherwise
+ * @return NO_ERROR on success, a =
Windows error code otherwise
  */
 static LSTATUS
 GetItfDnsServersV6(HKEY =
itf_key, PSTR addrs, PDWORD size)
@@ -2304,7 +2299,7 @@
  *                =
                the terminating zeros or 0=2E
  * @param[in]     capacity  =
      capacity of the \p domains buffer in bytes
  *
- * @return LSTATUS NO=
_ERROR if all domain suffix(es) were converted successfully,
+ * @return NO=
_ERROR if all domain suffix(es) were converted successfully,
  *         ER=
ROR_FILE_NOT_FOUND if no domain was left after the conversion,
  *         =
ERROR_MORE_DATA if not all converted domains did fit into the buffer=2E
  *=
         ERROR_OUTOFMEMORY if the temporary buffer could not be allocated=
=2E
@@ -2402,7 +2397,7 @@
  *                         set to the size of th=
e string returned, including
  *                         the terminating ze=
ros or 0=2E
  *
- * @return LSTATUS NO_ERROR if the domain suffix(es) were =
read successfully,
+ * @return NO_ERROR if the domain suffix(es) were read =
successfully,
  *         ERROR_FILE_NOT_FOUND if no domain was found for t=
he interface,
  *         ERROR_MORE_DATA if the list did not fit into the =
buffer,
  *         any other error indicates an error while reading from t=
he registry=2E
@@ -2415,7 +2410,7 @@
         return ERROR_INVALID_PARAMETE=
R;
     }
 
-    LSTATUS err =3D ERROR_FILE_NOT_FOUND;
+    LSTATUS err;
  =
   const DWORD buf_size =3D *size;
     const DWORD glyph_size =3D sizeof(*=
domains);
     PWSTR values[] =3D { L"SearchList", L"Domain", L"DhcpDomainS=
earchList", L"DhcpDomain", NULL };
@@ -2616,12 +2611,12 @@
  *
  * @return =
NO_ERROR on success, or Windows error code
  */
-static DWORD
+static LSTAT=
US
 SetNrptRule(HKEY nrpt_key, PCWSTR subkey, PCSTR address, PCWSTR domains=
, DWORD dom_size,
             BOOL dnssec)
 {
     /* Create rule subkey *=
/
-    DWORD err =3D NO_ERROR;
+    LSTATUS err =3D NO_ERROR;
     HKEY rul=
e_key;
     err =3D RegCreateKeyExW(nrpt_key, subkey, 0, NULL, 0, KEY_ALL_A=
CCESS, NULL, &rule_key, NULL);
     if (err)
@@ -2724,13 +2719,12 @@
      =
       break;
         }
 
-        DWORD err;
         WCHAR subkey[48];
 =
        swprintf(subkey, _countof(subkey), L"OpenVPNDNSRoutingX-%02x-%lu", =
++n, ovpn_pid);
-        err =3D SetNrptRule(nrpt_key, subkey, d->addresses=
, d->domains, d->domains_size, FALSE);
+        LSTATUS err =3D SetNrptRule=
(nrpt_key, subkey, d->addresses, d->domains, d->domains_size, FALSE);
     =
    if (err)
         {
-            MsgToEventLog(M_ERR, L"%S: failed to s=
et rule %s (%lu)", __func__, subkey, err);
+            MsgToEventLog(M_ERR=
, L"%S: failed to set rule %s (%ld)", __func__, subkey, err);
         }
  =
   }
 }
@@ -2747,11 +2741,11 @@
  *
  * @return NO_ERROR on success, or a W=
indows error code
  */
-static DWORD
+static LSTATUS
 SetNrptRules(HKEY nrp=
t_key, const nrpt_address_t *addresses, const char *domains,
              =
const char *search_domains, BOOL dnssec, DWORD ovpn_pid)
 {
-    DWORD err =
=3D NO_ERROR;
+    LSTATUS err =3D NO_ERROR;
     PWSTR wide_domains =3D L"=
=2E\0"; /* DNS route everything by default */
     DWORD dom_size =3D 6;
 
=
@@ -2810,7 +2804,7 @@
         err =3D SetNrptRule(nrpt_key, subkey, addr_l=
ist, wide_domains, dom_size, dnssec);
         if (err)
         {
-       =
     MsgToEventLog(M_ERR, L"%S: failed to set rule %s (%lu)", __func__, sub=
key, err);
+            MsgToEventLog(M_ERR, L"%S: failed to set rule %s (%=
ld)", __func__, subkey, err);
         }
     }
 
@@ -3028,14 +3022,15 @@
 =
    }
 
     HKEY key;
-    LSTATUS err =3D OpenNrptBaseKey(&key, &gpol_nrp=
t);
-    if (err)
+    LSTATUS reg_err =3D OpenNrptBaseKey(&key, &gpol_nrpt=
);
+    if (reg_err)
     {
-        return err;
+        return (DWORD)reg=
_err;
     }
 
     /* Add undo information first in case there's no heap l=
eft */
     PDWORD pid =3D malloc(sizeof(ovpn_pid));
+    DWORD err =3D 0;
=
     if (!pid)
     {
         err =3D ERROR_OUTOFMEMORY;
@@ -3051,10 +3046=
,11 @@
 
     /* Set NRPT rules */
     BOOL dnssec =3D (msg->flags & nrpt_=
dnssec) !=3D 0;
-    err =3D SetNrptRules(key, msg->addresses, msg->resolve=
_domains, msg->search_domains, dnssec,
-                       ovpn_pid);
-=
    if (err)
+    reg_err =3D SetNrptRules(key, msg->addresses, msg->resolv=
e_domains, msg->search_domains, dnssec,
+                           ovpn_pi=
d);
+    if (reg_err)
     {
+        err =3D (DWORD)reg_err;
         goto=
 out;
     }
 
@@ -3066,9 +3062,10 @@
      */
     if (msg->search_domains=
[0] || !msg->resolve_domains[0])
     {
-        err =3D SetNameServerAddre=
sses(iid, msg->addresses);
-        if (err)
+        reg_err =3D SetNameSe=
rverAddresses(iid, msg->addresses);
+        if (reg_err)
         {
+     =
       err =3D (DWORD)reg_err;
             goto out;
         }
     }
@@ =
-3076,7 +3073,8 @@
     /* Set search domains, if any */
     if (msg->sear=
ch_domains[0])
     {
-        err =3D SetDnsSearchDomains(msg->iface=2Enam=
e, msg->search_domains, &gpol_list, lists);
+        reg_err =3D SetDnsSear=
chDomains(msg->iface=2Ename, msg->search_domains, &gpol_list, lists);
+    =
    err =3D (DWORD)reg_err;
     }
 
     ApplyDnsSettings(gpol_nrpt || gpo=
l_list);
@@ -3384,7 +3382,7 @@
             switch (type)
             {
  =
               case address:
-                    DeleteAddress(item->data)=
;
+                    DeleteUnicastIpAddressEntry(item->data);
           =
          break;
 
                 case route:
@@ -3794,7 +3792,7 @@
     =
RPC_STATUS rpc_stat =3D UuidCreate(&pipe_uuid);
     if (rpc_stat !=3D RPC_=
S_OK)
     {
-        ReturnError(pipe, rpc_stat, L"UuidCreate", 1, &exit_e=
vent);
+        ReturnError(pipe, (DWORD)rpc_stat, L"UuidCreate", 1, &exit_=
event);
         goto out;
     }
 
@@ -3802,7 +3800,7 @@
     rpc_stat =3D=
 UuidToStringW(&pipe_uuid, &pipe_uuid_str);
     if (rpc_stat !=3D RPC_S_OK=
)
     {
-        ReturnError(pipe, rpc_stat, L"UuidToString", 1, &exit_eve=
nt);
+        ReturnError(pipe, (DWORD)rpc_stat, L"UuidToString", 1, &exit_=
event);
         goto out;
     }
     swprintf(ovpn_pipe_name, _countof(ov=
pn_pipe_name),

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2355?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: n=
ewchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1=
f775940c13cf989cf804bf637d4a63c3fe5aaaf
Gerrit-Change-Number: 2355
Gerrit-P=
atchSet: 1
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>

--Unn+Krp8ZAs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">Cleaning up Windows error handling for signing conversion<=
br><br>This is a mess, generally=2E Most functions return errors<br>as DWOR=
D, but the Reg* ones use LSTATUS which is signed=2E<br><br>Trying to untang=
le this a bit, but still requires copious<br>casting=2E<br><br>Change-Id: I=
1f775940c13cf989cf804bf637d4a63c3fe5aaaf<br>Signed-off-by: Frank Lichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M include/openvpn-msg=2Eh<br>M =
src/openvpn/error=2Ec<br>M src/openvpn/error=2Eh<br>M src/openvpn/route=2Ec=
<br>M src/openvpn/tun=2Ec<br>M src/openvpn/win32=2Ec<br>M src/openvpnserv/c=
ommon=2Ec<br>M src/openvpnserv/interactive=2Ec<br>8 files changed, 74 inser=
tions(+), 95 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/55/2355/1</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
include/openvpn-msg=2Eh b/include/openvpn-msg=2Eh</span><br><span>index dd2=
0f7b=2E=2E1af45b5 100644</span><br><span>--- a/include/openvpn-msg=2Eh</spa=
n><br><span>+++ b/include/openvpn-msg=2Eh</span><br><span>@@ -157,7 +157,7 =
@@</span><br><span> typedef struct</span><br><span> {</span><br><span>     =
message_header_t header;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    int error_number;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    NETIO_STATUS error_number;</span><br><span> } ack_message_t;</span=
><br><span> </span><br><span> typedef struct</span><br><span>diff --git a/s=
rc/openvpn/error=2Ec b/src/openvpn/error=2Ec</span><br><span>index a3f7990=
=2E=2E18d0b57 100644</span><br><span>--- a/src/openvpn/error=2Ec</span><br>=
<span>+++ b/src/openvpn/error=2Ec</span><br><span>@@ -219,18 +219,13 @@</sp=
an><br><span>     va_end(arglist);</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_WIN32) &amp;=
&amp; (defined(__GNUC__) || defined(__clang__))</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign=
-conversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> s=
tatic const char *</span><br><span> openvpn_strerror(int err, bool crt_erro=
r, struct gc_arena *gc)</span><br><span> {</span><br><span> #ifdef _WIN32</=
span><br><span>     if (!crt_error)</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        return strerror_win32(err, gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return str=
error_win32((DWORD)err, gc);</span><br><span>     }</span><br><span> #endif=
</span><br><span>     return strerror(err);</span><br><span>@@ -694,10 +689=
,6 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_WIN32) &amp;&amp; =
(defined(__GNUC__) || defined(__clang__))</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span> /*</span><br><span>  * In multiclient mode, put=
 a client-specific prefix</span><br><span>  * before each message=2E</span>=
<br><span>diff --git a/src/openvpn/error=2Eh b/src/openvpn/error=2Eh</span>=
<br><span>index 0056d05=2E=2E91d4ffe 100644</span><br><span>--- a/src/openv=
pn/error=2Eh</span><br><span>+++ b/src/openvpn/error=2Eh</span><br><span>@@=
 -406,18 +406,13 @@</span><br><span> }</span><br><span> #endif</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_WIN=
32) &amp;&amp; (defined(__GNUC__) || defined(__clang__))</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &qu=
ot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span> static inline int</span><br><span> openvpn_errno_maybe_crt(bool *cr=
t_error)</span><br><span> {</span><br><span>     int err =3D 0;</span><br><=
span> #ifdef _WIN32</span><br><span>     *crt_error =3D false;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    err =3D GetLastError();</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    err =3D (int)GetLastEr=
ror();</span><br><span>     if (err =3D=3D ERROR_SUCCESS)</span><br><span> =
    {</span><br><span>         /* error is likely C runtime */</span><br><s=
pan>@@ -431,10 +426,6 @@</span><br><span>     return err;</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
f defined(_WIN32) &amp;&amp; (defined(__GNUC__) || defined(__clang__))</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #include &quot;err=
level=2Eh&quot;</span><br><span> </span><br><span> #endif /* ifndef ERROR_H=
 */</span><br><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=
=2Ec</span><br><span>index 82cb7f0=2E=2E0a1e65f 100644</span><br><span>--- =
a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><=
br><span>@@ -2805,7 +2805,7 @@</span><br><span>         ret =3D (ack=2Eerro=
r_number =3D=3D ERROR_OBJECT_ALREADY_EXISTS) ? RTA_EEXIST : RTA_ERROR;</spa=
n><br><span>         if (ret =3D=3D RTA_ERROR)</span><br><span>         {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN,=
 &quot;ERROR: route %s failed using service: %s [status=3D%d if_index=3D%lu=
]&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 msg(M_WARN, &quot;ERROR: route %s failed using service: %s [status=3D%lu i=
f_index=3D%lu]&quot;,</span><br><span>                 (add ? &quot;additio=
n&quot; : &quot;deletion&quot;), strerror_win32(ack=2Eerror_number, &amp;gc=
),</span><br><span>                 ack=2Eerror_number, rt-&gt;iface=2Einde=
x);</span><br><span>         }</span><br><span>diff --git a/src/openvpn/tun=
=2Ec b/src/openvpn/tun=2Ec</span><br><span>index 65edf73=2E=2E074fe20 10064=
4</span><br><span>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openv=
pn/tun=2Ec</span><br><span>@@ -157,7 +157,7 @@</span><br><span> </span><br>=
<span>     if (ack=2Eerror_number !=3D NO_ERROR)</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot=
;TUN: %s address failed using service: %s [status=3D%d if_index=3D%lu]&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WAR=
N, &quot;TUN: %s address failed using service: %s [status=3D%lu if_index=3D=
%lu]&quot;,</span><br><span>             (add ? &quot;adding&quot; : &quot;=
deleting&quot;), strerror_win32(ack=2Eerror_number, &amp;gc), ack=2Eerror_n=
umber,</span><br><span>             addr=2Eiface=2Eindex);</span><br><span>=
         goto out;</span><br><span>@@ -228,7 +228,7 @@</span><br><span> </s=
pan><br><span>     if (ack=2Eerror_number !=3D NO_ERROR)</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WAR=
N, &quot;TUN: %s DNS domains failed using service: %s [status=3D%d if_name=
=3D%s]&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  msg(M_WARN, &quot;TUN: %s DNS domains failed using service: %s [status=3D=
%lu if_name=3D%s]&quot;,</span><br><span>             (add ? &quot;adding&q=
uot; : &quot;deleting&quot;), strerror_win32(ack=2Eerror_number, &amp;gc), =
ack=2Eerror_number,</span><br><span>             dns=2Eiface=2Ename);</span=
><br><span>         goto out;</span><br><span>@@ -297,7 +297,7 @@</span><br=
><span> </span><br><span>     if (ack=2Eerror_number !=3D NO_ERROR)</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  msg(M_WARN, &quot;TUN: %s %s dns failed using service: %s [status=3D%d if=
_name=3D%s]&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       msg(M_WARN, &quot;TUN: %s %s dns failed using service: %s [status=3D=
%lu if_name=3D%s]&quot;,</span><br><span>             (add ? &quot;adding&q=
uot; : &quot;deleting&quot;), ip_proto_name, strerror_win32(ack=2Eerror_num=
ber, &amp;gc),</span><br><span>             ack=2Eerror_number, dns=2Eiface=
=2Ename);</span><br><span>         goto out;</span><br><span>@@ -353,7 +353=
,7 @@</span><br><span> </span><br><span>     if (ack=2Eerror_number !=3D NO=
_ERROR)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        msg(M_WARN, &quot;TUN: %s WINS failed using service: %s [s=
tatus=3D%d if_name=3D%s]&quot;,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        msg(M_WARN, &quot;TUN: %s WINS failed using service: %s=
 [status=3D%lu if_name=3D%s]&quot;,</span><br><span>             (add ? &qu=
ot;adding&quot; : &quot;deleting&quot;), strerror_win32(ack=2Eerror_number,=
 &amp;gc),</span><br><span>             ack=2Eerror_number, wins=2Eiface=2E=
name);</span><br><span>         goto out;</span><br><span>@@ -391,7 +391,7 =
@@</span><br><span> </span><br><span>     if (ack=2Eerror_number !=3D NO_ER=
ROR)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        msg(M_NONFATAL, &quot;TUN: setting %s mtu using service faile=
d: %s [status=3D%d if_index=3D%lu]&quot;,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        msg(M_NONFATAL, &quot;TUN: setting %s mtu usi=
ng service failed: %s [status=3D%lu if_index=3D%lu]&quot;,</span><br><span>=
             family_name, strerror_win32(ack=2Eerror_number, &amp;gc), ack=
=2Eerror_number,</span><br><span>             mtu_msg=2Eiface=2Eindex);</sp=
an><br><span>     }</span><br><span>@@ -469,7 +469,7 @@</span><br><span> </=
span><br><span>     if (ack=2Eerror_number !=3D NO_ERROR)</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_NO=
NFATAL, &quot;TUN: creating %s adapter using service failed: %s [status=3D%=
d]&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ms=
g(M_NONFATAL, &quot;TUN: creating %s adapter using service failed: %s [stat=
us=3D%lu]&quot;,</span><br><span>             print_tun_backend_driver(driv=
er_type), strerror_win32(ack=2Eerror_number, &amp;gc),</span><br><span>    =
         ack=2Eerror_number);</span><br><span>     }</span><br><span>@@ -53=
05,7 +5305,7 @@</span><br><span> </span><br><span>     if (ack=2Eerror_numb=
er !=3D NO_ERROR)</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        msg(M_NONFATAL, &quot;TUN: enabling dhcp using s=
ervice failed: %s [status=3D%d if_index=3D%lu]&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_NONFATAL, &quot;TUN: enabli=
ng dhcp using service failed: %s [status=3D%lu if_index=3D%lu]&quot;,</span=
><br><span>             strerror_win32(ack=2Eerror_number, &amp;gc), ack=2E=
error_number, dhcp=2Eiface=2Eindex);</span><br><span>     }</span><br><span=
>     else</span><br><span>@@ -5477,7 +5477,7 @@</span><br><span> </span><b=
r><span>     else if (ack=2Eerror_number !=3D NO_ERROR)</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN=
, &quot;Register_dns failed using service: %s [status=3D0x%x]&quot;,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;=
Register_dns failed using service: %s [status=3D0x%lx]&quot;,</span><br><sp=
an>             strerror_win32(ack=2Eerror_number, &amp;gc), ack=2Eerror_nu=
mber);</span><br><span>     }</span><br><span> </span><br><span>diff --git =
a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec</span><br><span>index 24158=
47=2E=2Ea4ed152 100644</span><br><span>--- a/src/openvpn/win32=2Ec</span><b=
r><span>+++ b/src/openvpn/win32=2Ec</span><br><span>@@ -1239,7 +1239,7 @@</=
span><br><span>     if (ack=2Eerror_number !=3D NO_ERROR)</span><br><span> =
    {</span><br><span>         msg(M_WARN,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            &quot;WFP block: %s block filters using se=
rvice failed: %s [status=3D0x%x if_index=3D%lu]&quot;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            &quot;WFP block: %s block fi=
lters using service failed: %s [status=3D0x%lx if_index=3D%lu]&quot;,</span=
><br><span>             (add ? &quot;adding&quot; : &quot;deleting&quot;), =
strerror_win32(ack=2Eerror_number, &amp;gc), ack=2Eerror_number,</span><br>=
<span>             data=2Eiface=2Eindex);</span><br><span>         goto out=
;</span><br><span>diff --git a/src/openvpnserv/common=2Ec b/src/openvpnserv=
/common=2Ec</span><br><span>index e20feb7=2E=2Ede7847e 100644</span><br><sp=
an>--- a/src/openvpnserv/common=2Ec</span><br><span>+++ b/src/openvpnserv/c=
ommon=2Ec</span><br><span>@@ -38,7 +38,7 @@</span><br><span> static DWORD</=
span><br><span> GetRegString(HKEY key, LPCWSTR value, LPWSTR data, DWORD si=
ze, LPCWSTR default_value)</span><br><span> {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    LONG status =3D RegGetValue(key, NULL, value, R=
RF_RT_REG_SZ, NULL, (LPBYTE)data, &amp;size);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    LSTATUS status =3D RegGetValue(key, NULL, val=
ue, RRF_RT_REG_SZ, NULL, (LPBYTE)data, &amp;size);</span><br><span> </span>=
<br><span>     if (status =3D=3D ERROR_FILE_NOT_FOUND &amp;&amp; default_va=
lue)</span><br><span>     {</span><br><span>@@ -51,7 +51,7 @@</span><br><sp=
an> </span><br><span>     if (status !=3D ERROR_SUCCESS)</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        SetLastEr=
ror(status);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 SetLastError((DWORD)status);</span><br><span>         return MsgToEventLog=
(</span><br><span>             M_SYSERR,</span><br><span>             L&quo=
t;Error querying registry value: HKLM\\SOFTWARE\\&quot; _L(PACKAGE_NAME) L&=
quot;%ls\\%ls&quot;,</span><br><span>@@ -91,19 +91,18 @@</span><br><span> <=
/span><br><span>     swprintf(reg_path, _countof(reg_path), L&quot;SOFTWARE=
\\&quot; _L(PACKAGE_NAME) L&quot;%ls&quot;, service_instance);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    LONG status =
=3D RegOpenKeyEx(HKEY_LOCAL_MACHINE, reg_path, 0, KEY_READ, &amp;key);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    LSTATUS status =3D R=
egOpenKeyEx(HKEY_LOCAL_MACHINE, reg_path, 0, KEY_READ, &amp;key);</span><br=
><span>     if (status !=3D ERROR_SUCCESS)</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        SetLastError(status);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        SetLastError(=
(DWORD)status);</span><br><span>         return MsgToEventLog(M_SYSERR, L&q=
uot;Could not open Registry key HKLM\\%ls not found&quot;,</span><br><span>=
                              reg_path);</span><br><span>     }</span><br><=
span> </span><br><span>     /* The default value of REG_KEY is the install =
path */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    status =3D=
 GetRegString(key, NULL, install_path, sizeof(install_path), NULL);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (status !=3D ERROR_SUC=
CESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    error =3D =
GetRegString(key, NULL, install_path, sizeof(install_path), NULL);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (error !=3D ERROR_SUC=
CESS)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        error =3D status;</span><br><span>         goto out;</span><=
br><span>     }</span><br><span> </span><br><span>diff --git a/src/openvpns=
erv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index=
 d155fd6=2E=2Ea2769e8 100644</span><br><span>--- a/src/openvpnserv/interact=
ive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><sp=
an>@@ -545,7 +545,7 @@</span><br><span>     return sa_inet;</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
static DWORD</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
NETIO_STATUS</span><br><span> InterfaceLuid(const char *iface_name, PNET_LU=
ID luid)</span><br><span> {</span><br><span>     NETIO_STATUS convert_statu=
s;</span><br><span>@@ -569,16 +569,10 @@</span><br><span>     return memcmp=
(item, address, sizeof(MIB_UNICASTIPADDRESS_ROW)) =3D=3D 0 ? TRUE : FALSE;<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-static DWORD</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-DeleteAddress(PMIB_UNICASTIPADDRESS_ROW addr_row)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    return DeleteUnicastIpAddressEntry(addr_row);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-static DWORD</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 NETIO_STATUS</span><br><span> HandleAddressMessage(address_message_t *msg,=
 undo_lists_t *lists)</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    DWORD err;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    NETIO_STATUS err;</span><br><span>     PMIB_UNICASTIPADDR=
ESS_ROW addr_row;</span><br><span>     BOOL add =3D msg-&gt;header=2Etype =
=3D=3D msg_add_address;</span><br><span> </span><br><span>@@ -621,12 +615,1=
2 @@</span><br><span>         err =3D AddListItem(&amp;(*lists)[address], a=
ddr_row);</span><br><span>         if (err)</span><br><span>         {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            DeleteAddress(=
addr_row);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   DeleteUnicastIpAddressEntry(addr_row);</span><br><span>         }</span>=
<br><span>     }</span><br><span>     else</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        err =3D DeleteAddress(a=
ddr_row);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        er=
r =3D DeleteUnicastIpAddressEntry(addr_row);</span><br><span>         if (e=
rr)</span><br><span>         {</span><br><span>             goto out;</span=
><br><span>@@ -1225,10 +1219,10 @@</span><br><span>  *</span><br><span>  * =
@return NO_ERROR on success, or the Windows error code for the failure</spa=
n><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stati=
c DWORD</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static NETIO=
_STATUS</span><br><span> InterfaceIdString(PCSTR itf_name, PWSTR str, size_=
t len)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    DWORD err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   NETIO_STATUS err;</span><br><span>     GUID guid;</span><br><span>     N=
ET_LUID luid;</span><br><span>     PWSTR iid_str =3D NULL;</span><br><span>=
@@ -1784,10 +1778,10 @@</span><br><span>  * The gpol value is only valid if=
 the function returns no error=2E In the error</span><br><span>  * case not=
hing is changed=2E</span><br><span>  */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-static DWORD</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static LSTATUS</span><br><span> SetDnsSearchDomains(PCSTR itf_na=
me, PCSTR domains, PBOOL gpol, undo_lists_t *lists)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    DWORD err =3D ERROR_OU=
TOFMEMORY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LSTAT=
US err =3D ERROR_OUTOFMEMORY;</span><br><span> </span><br><span>     HKEY l=
ist_key;</span><br><span>     BOOL have_list =3D GetDnsSearchListKey(itf_na=
me, gpol, &amp;list_key);</span><br><span>@@ -1882,12 +1876,12 @@</span><br=
><span>  * @param family    internet address family to set the servers for<=
/span><br><span>  * @param value     the value to set the name servers to</=
span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
@return DWORD NO_ERROR on success, a Windows error code otherwise</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @return NO_ERROR on succes=
s, a Windows error code otherwise</span><br><span>  */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-static DWORD</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static LSTATUS</span><br><span> SetNameServersVal=
ue(PCWSTR itf_id, ADDRESS_FAMILY family, PCSTR value)</span><br><span> {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    DWORD err;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    LSTATUS err;</span><br><s=
pan> </span><br><span>     HKEY itfs;</span><br><span>     if (!GetInterfac=
esKey(family, &amp;itfs))</span><br><span>@@ -1929,9 +1923,9 @@</span><br><=
span>  * @param itf_id    the interface id to clear the servers for</span><=
br><span>  * @param family    internet address family to clear the servers =
for</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * @return DWORD NO_ERROR on success, a Windows error code otherwise</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return NO_ERROR on s=
uccess, a Windows error code otherwise</span><br><span>  */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-static DWORD</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static LSTATUS</span><br><span> ResetNameSer=
vers(PCWSTR itf_id, ADDRESS_FAMILY family)</span><br><span> {</span><br><sp=
an>     return SetNameServersValue(itf_id, family, &quot;&quot;);</span><br=
><span>@@ -1940,7 +1934,6 @@</span><br><span> static DWORD</span><br><span>=
 HandleDNSConfigMessage(const dns_cfg_message_t *msg, undo_lists_t *lists)<=
/span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 DWORD err =3D 0;</span><br><span>     undo_type_t undo_type =3D (msg-&gt;f=
amily =3D=3D AF_INET6) ? undo_dns6 : undo_dns4;</span><br><span>     unsign=
ed int addr_len =3D msg-&gt;addr_len;</span><br><span> </span><br><span>@@ =
-1965,10 +1958,10 @@</span><br><span>     }</span><br><span> </span><br><sp=
an>     WCHAR iid[64];</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    err =3D InterfaceIdString(msg-&gt;iface=2Ename, iid, _countof(iid));</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (err)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    DWORD iid_err =3D Interfac=
eIdString(msg-&gt;iface=2Ename, iid, _countof(iid));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (iid_err)</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return err;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return iid_err;=
</span><br><span>     }</span><br><span> </span><br><span>     /* We delete=
 all current addresses before adding any</span><br><span>@@ -1976,10 +1969,=
10 @@</span><br><span>      */</span><br><span>     if (addr_len &gt; 0 || =
msg-&gt;header=2Etype =3D=3D msg_del_dns_cfg)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        err =3D ResetNameSer=
vers(iid, msg-&gt;family);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        LSTATUS err =3D ResetNameServers(iid, msg-&gt;family);</span=
><br><span>         if (err)</span><br><span>         {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            return err;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            return (DWORD)err;</span>=
<br><span>         }</span><br><span>         free(RemoveListItem(&amp;(*li=
sts)[undo_type], CmpAny, iid));</span><br><span>     }</span><br><span>@@ -=
1987,13 +1980,14 @@</span><br><span>     if (msg-&gt;header=2Etype =3D=3D m=
sg_del_dns_cfg)</span><br><span>     {</span><br><span>         BOOL gpol =
=3D FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        L=
STATUS err =3D 0;</span><br><span>         if (msg-&gt;domains[0])</span><b=
r><span>         {</span><br><span>             /* setting an empty domain =
list removes any previous value */</span><br><span>             err =3D Set=
DnsSearchDomains(msg-&gt;iface=2Ename, NULL, &amp;gpol, lists);</span><br><=
span>         }</span><br><span>         ApplyDnsSettings(gpol);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        return err; /* job done =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return (D=
WORD)err; /* job done */</span><br><span>     }</span><br><span> </span><br=
><span>     if (addr_len &gt; 0)</span><br><span>@@ -2020,10 +2014,10 @@</s=
pan><br><span>             offset =3D strlen(addrs);</span><br><span>      =
   }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        err =3D SetNameServersValue(iid, msg-&gt;family, addrs);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        LSTATUS err =3D SetNa=
meServersValue(iid, msg-&gt;family, addrs);</span><br><span>         if (er=
r)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            return err;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            return (DWORD)err;</span><br><span>         }</span=
><br><span> </span><br><span>         wchar_t *tmp_iid =3D _wcsdup(iid);</s=
pan><br><span>@@ -2036,13 +2030,14 @@</span><br><span>     }</span><br><spa=
n> </span><br><span>     BOOL gpol =3D FALSE;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    LSTATUS domain_err =3D 0;</span><br><span>   =
  if (msg-&gt;domains[0])</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        err =3D SetDnsSearchDomains(msg-&gt;ifac=
e=2Ename, msg-&gt;domains, &amp;gpol, lists);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        domain_err =3D SetDnsSearchDomains(msg-&g=
t;iface=2Ename, msg-&gt;domains, &amp;gpol, lists);</span><br><span>     }<=
/span><br><span>     ApplyDnsSettings(gpol);</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    return err;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return (DWORD)domain_err;</span><b=
r><span> }</span><br><span> </span><br><span> /**</span><br><span>@@ -2076,=
7 +2071,7 @@</span><br><span>  * @param itf_id        the VPN interface ID =
to set the name servers for</span><br><span>  * @param addresses     the li=
st of NRPT addresses</span><br><span>  *</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * @return LSTATUS NO_ERROR in case of success, a Window=
s error code otherwise</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @return NO_ERROR in case of success, a Windows error code otherwise</=
span><br><span>  */</span><br><span> static LSTATUS</span><br><span> SetNam=
eServerAddresses(PWSTR itf_id, const nrpt_address_t *addresses)</span><br><=
span>@@ -2147,7 +2142,7 @@</span><br><span>  * @param  size       pointer t=
o the size of the buffer, contains the</span><br><span>  *                 =
   size of the addresses on return</span><br><span>  *</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * @return LSTATUS NO_ERROR on success, a =
Windows error code otherwise</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @return NO_ERROR on success, a Windows error code otherwise</sp=
an><br><span>  */</span><br><span> static LSTATUS</span><br><span> GetItfDn=
sServersV4(HKEY itf_key, PSTR addrs, PDWORD size)</span><br><span>@@ -2193,=
7 +2188,7 @@</span><br><span>  * @param  size       pointer to the size of =
the buffer, contains the</span><br><span>  *                    size of the=
 addresses on return</span><br><span>  *</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * @return LSTATUS NO_ERROR on success, a Windows error =
code otherwise</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @r=
eturn NO_ERROR on success, a Windows error code otherwise</span><br><span> =
 */</span><br><span> static LSTATUS</span><br><span> GetItfDnsServersV6(HKE=
Y itf_key, PSTR addrs, PDWORD size)</span><br><span>@@ -2304,7 +2299,7 @@</=
span><br><span>  *                                the terminating zeros or =
0=2E</span><br><span>  * @param[in]     capacity        capacity of the \p =
domains buffer in bytes</span><br><span>  *</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * @return LSTATUS NO_ERROR if all domain suffix(es) =
were converted successfully,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @return NO_ERROR if all domain suffix(es) were converted succes=
sfully,</span><br><span>  *         ERROR_FILE_NOT_FOUND if no domain was l=
eft after the conversion,</span><br><span>  *         ERROR_MORE_DATA if no=
t all converted domains did fit into the buffer=2E</span><br><span>  *     =
    ERROR_OUTOFMEMORY if the temporary buffer could not be allocated=2E</sp=
an><br><span>@@ -2402,7 +2397,7 @@</span><br><span>  *                     =
    set to the size of the string returned, including</span><br><span>  *  =
                       the terminating zeros or 0=2E</span><br><span>  *</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return LSTATUS NO_ER=
ROR if the domain suffix(es) were read successfully,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return NO_ERROR if the domain suffix(=
es) were read successfully,</span><br><span>  *         ERROR_FILE_NOT_FOUN=
D if no domain was found for the interface,</span><br><span>  *         ERR=
OR_MORE_DATA if the list did not fit into the buffer,</span><br><span>  *  =
       any other error indicates an error while reading from the registry=
=2E</span><br><span>@@ -2415,7 +2410,7 @@</span><br><span>         return E=
RROR_INVALID_PARAMETER;</span><br><span>     }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    LSTATUS err =3D ERROR_FILE_N=
OT_FOUND;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LSTATU=
S err;</span><br><span>     const DWORD buf_size =3D *size;</span><br><span=
>     const DWORD glyph_size =3D sizeof(*domains);</span><br><span>     PWS=
TR values[] =3D { L&quot;SearchList&quot;, L&quot;Domain&quot;, L&quot;Dhcp=
DomainSearchList&quot;, L&quot;DhcpDomain&quot;, NULL };</span><br><span>@@=
 -2616,12 +2611,12 @@</span><br><span>  *</span><br><span>  * @return NO_ER=
ROR on success, or Windows error code</span><br><span>  */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-static DWORD</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static LSTATUS</span><br><span> SetNrptRule(H=
KEY nrpt_key, PCWSTR subkey, PCSTR address, PCWSTR domains, DWORD dom_size,=
</span><br><span>             BOOL dnssec)</span><br><span> {</span><br><sp=
an>     /* Create rule subkey */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    DWORD err =3D NO_ERROR;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    LSTATUS err =3D NO_ERROR;</span><br><span>     HKEY =
rule_key;</span><br><span>     err =3D RegCreateKeyExW(nrpt_key, subkey, 0,=
 NULL, 0, KEY_ALL_ACCESS, NULL, &amp;rule_key, NULL);</span><br><span>     =
if (err)</span><br><span>@@ -2724,13 +2719,12 @@</span><br><span>          =
   break;</span><br><span>         }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        DWORD err;</span><br><span>       =
  WCHAR subkey[48];</span><br><span>         swprintf(subkey, _countof(subk=
ey), L&quot;OpenVPNDNSRoutingX-%02x-%lu&quot;, ++n, ovpn_pid);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        err =3D SetNrptRule(nrpt_k=
ey, subkey, d-&gt;addresses, d-&gt;domains, d-&gt;domains_size, FALSE);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        LSTATUS err =3D=
 SetNrptRule(nrpt_key, subkey, d-&gt;addresses, d-&gt;domains, d-&gt;domain=
s_size, FALSE);</span><br><span>         if (err)</span><br><span>         =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            MsgToEve=
ntLog(M_ERR, L&quot;%S: failed to set rule %s (%lu)&quot;, __func__, subkey=
, err);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
MsgToEventLog(M_ERR, L&quot;%S: failed to set rule %s (%ld)&quot;, __func__=
, subkey, err);</span><br><span>         }</span><br><span>     }</span><br=
><span> }</span><br><span>@@ -2747,11 +2741,11 @@</span><br><span>  *</span=
><br><span>  * @return NO_ERROR on success, or a Windows error code</span><=
br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static D=
WORD</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static LSTATUS<=
/span><br><span> SetNrptRules(HKEY nrpt_key, const nrpt_address_t *addresse=
s, const char *domains,</span><br><span>              const char *search_do=
mains, BOOL dnssec, DWORD ovpn_pid)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    DWORD err =3D NO_ERROR;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    LSTATUS err =3D NO_ERROR;</spa=
n><br><span>     PWSTR wide_domains =3D L&quot;=2E\0&quot;; /* DNS route ev=
erything by default */</span><br><span>     DWORD dom_size =3D 6;</span><br=
><span> </span><br><span>@@ -2810,7 +2804,7 @@</span><br><span>         err=
 =3D SetNrptRule(nrpt_key, subkey, addr_list, wide_domains, dom_size, dnsse=
c);</span><br><span>         if (err)</span><br><span>         {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            MsgToEventLog(M_ERR,=
 L&quot;%S: failed to set rule %s (%lu)&quot;, __func__, subkey, err);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            MsgToEventLo=
g(M_ERR, L&quot;%S: failed to set rule %s (%ld)&quot;, __func__, subkey, er=
r);</span><br><span>         }</span><br><span>     }</span><br><span> </sp=
an><br><span>@@ -3028,14 +3022,15 @@</span><br><span>     }</span><br><span=
> </span><br><span>     HKEY key;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    LSTATUS err =3D OpenNrptBaseKey(&amp;key, &amp;gpol_nrpt);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (err)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    LSTATUS reg_err =3D OpenN=
rptBaseKey(&amp;key, &amp;gpol_nrpt);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (reg_err)</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        return err;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return (DWORD)reg_err;</span><b=
r><span>     }</span><br><span> </span><br><span>     /* Add undo informati=
on first in case there&#39;s no heap left */</span><br><span>     PDWORD pi=
d =3D malloc(sizeof(ovpn_pid));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    DWORD err =3D 0;</span><br><span>     if (!pid)</span><br><=
span>     {</span><br><span>         err =3D ERROR_OUTOFMEMORY;</span><br><=
span>@@ -3051,10 +3046,11 @@</span><br><span> </span><br><span>     /* Set =
NRPT rules */</span><br><span>     BOOL dnssec =3D (msg-&gt;flags &amp; nrp=
t_dnssec) !=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
err =3D SetNrptRules(key, msg-&gt;addresses, msg-&gt;resolve_domains, msg-&=
gt;search_domains, dnssec,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                       ovpn_pid);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (err)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    reg_err =3D SetNrptRules(key, msg-&gt;addresses, msg-&gt;reso=
lve_domains, msg-&gt;search_domains, dnssec,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                           ovpn_pid);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (reg_err)</span><br><span=
>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        err =
=3D (DWORD)reg_err;</span><br><span>         goto out;</span><br><span>    =
 }</span><br><span> </span><br><span>@@ -3066,9 +3062,10 @@</span><br><span=
>      */</span><br><span>     if (msg-&gt;search_domains[0] || !msg-&gt;re=
solve_domains[0])</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        err =3D SetNameServerAddresses(iid, msg-&gt;addr=
esses);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (er=
r)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        reg_err =
=3D SetNameServerAddresses(iid, msg-&gt;addresses);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (reg_err)</span><br><span>    =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            e=
rr =3D (DWORD)reg_err;</span><br><span>             goto out;</span><br><sp=
an>         }</span><br><span>     }</span><br><span>@@ -3076,7 +3073,8 @@<=
/span><br><span>     /* Set search domains, if any */</span><br><span>     =
if (msg-&gt;search_domains[0])</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        err =3D SetDnsSearchDomains(msg-&gt=
;iface=2Ename, msg-&gt;search_domains, &amp;gpol_list, lists);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        reg_err =3D SetDnsSearch=
Domains(msg-&gt;iface=2Ename, msg-&gt;search_domains, &amp;gpol_list, lists=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        err =3D (=
DWORD)reg_err;</span><br><span>     }</span><br><span> </span><br><span>   =
  ApplyDnsSettings(gpol_nrpt || gpol_list);</span><br><span>@@ -3384,7 +338=
2,7 @@</span><br><span>             switch (type)</span><br><span>         =
    {</span><br><span>                 case address:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    DeleteAddress(item-&gt;=
data);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       DeleteUnicastIpAddressEntry(item-&gt;data);</span><br><span>        =
             break;</span><br><span> </span><br><span>                 case=
 route:</span><br><span>@@ -3794,7 +3792,7 @@</span><br><span>     RPC_STAT=
US rpc_stat =3D UuidCreate(&amp;pipe_uuid);</span><br><span>     if (rpc_st=
at !=3D RPC_S_OK)</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        ReturnError(pipe, rpc_stat, L&quot;UuidCreate&qu=
ot;, 1, &amp;exit_event);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        ReturnError(pipe, (DWORD)rpc_stat, L&quot;UuidCreate&quot;, 1=
, &amp;exit_event);</span><br><span>         goto out;</span><br><span>    =
 }</span><br><span> </span><br><span>@@ -3802,7 +3800,7 @@</span><br><span>=
     rpc_stat =3D UuidToStringW(&amp;pipe_uuid, &amp;pipe_uuid_str);</span>=
<br><span>     if (rpc_stat !=3D RPC_S_OK)</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        ReturnError(pipe, rpc_s=
tat, L&quot;UuidToString&quot;, 1, &amp;exit_event);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        ReturnError(pipe, (DWORD)rpc_stat=
, L&quot;UuidToString&quot;, 1, &amp;exit_event);</span><br><span>         =
goto out;</span><br><span>     }</span><br><span>     swprintf(ovpn_pipe_na=
me, _countof(ovpn_pipe_name),</span><br></pre><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355?usp=3Demail">change 2355</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1=
f775940c13cf989cf804bf637d4a63c3fe5aaaf </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2355 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--Unn+Krp8ZAs=--


--===============7099932446219951254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7099932446219951254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7099932446219951254==--

