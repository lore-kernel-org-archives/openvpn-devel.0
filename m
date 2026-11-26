Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56F1606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Kx/20/IN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fMLm6P/y;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=e+o6SuHS;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=f6Dnw3DO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4CHu4R5bCia2vRh89K6h4MjGYEykBF3DYUTPB0+3tQA=; b=Kx/20/INXJR9tJjDIR2MjvHCE/
	i0Dp7WQj10NqjIV6CzwFkGaIVDQgFB/+NGrSOIyJbhkfAdM8SIf2aMSe3pM+zkRUCra2qAV395Nlm
	519ilWVHmsr6JgRY0dikyRhX0ykx8XiaGYEVV/NrcOPSrUsHv6FvG0YZGbiuUvTf8Huk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWcB6-00000000502-3zUM;
	Thu, 26 Nov 2026 16:18:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWcB5-000000004zu-0TgL
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 16:18:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rCaHAZhH31k5FE32Msg9J7ahvRgbmktmMv6e5KioQ7E=; b=fMLm6P/yzkhwR4gFo6g07TK7Dk
 pZJk3AoNitNrYviD06jTDe+5bA3k5eE8QOFDb2Ij/MYgpIlipl+QU0/d2FQJV/sQ7nhIEtx90R9Cv
 BelYD36DxnMPULPzr/oCzYfo6MrqYFZvQ7nVF/F2IU4Oy9nOR6jjhYAj9NFU7eNgGPrg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rCaHAZhH31k5FE32Msg9J7ahvRgbmktmMv6e5KioQ7E=; b=e+o6SuHS4Zv+uhyjXysAeTdAYt
 0gZg+2I7t3RDbn6kJcK5q5OQbxhTSfwxO+smUbglWydU8xUBq4+VKGWCJqywN4DgfNHZZOTYa24JD
 GV6StBz8r6sDuD3P1ja622I07lA7ttwtgDGjxLZRclJPvC+UasA9wvbQ+Gg0srdwIhYg=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWcB1-00000000871-3UxI for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 16:18:31 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so4681881f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 08:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795709901; x=1796314701; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rCaHAZhH31k5FE32Msg9J7ahvRgbmktmMv6e5KioQ7E=;
 b=f6Dnw3DOVQIeEcfdOp5ME2K2+E7M6UMZXA5Ye/2s0q4y8/7ZzaJvV+ABgkBWXd7ut3
 Yp4L0b14VLWJ6iAft/yyn3MHaE6nxqcv8n7GMux3pVE37OpCyKieOej3BryejIBkMw3Z
 hFJjvio3XRiBv8+cA6xNNFSCGsRbGG8k7g9OrK+wbGR6gkoLCEU77WWkh8/LL986yyxv
 e329Nv1oHcPpfL25ITC7oKTSMyMCECTU6rwK1r1WyAGGRgWPTo8Pxm05K6cqNIrA3S73
 PWy5T5z0rxNkooDr/e8DJ1zhLusxq0JEHGpwhmVFwd8RRCihRaLqA9LvwfGaptezd6Sq
 AO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795709901; x=1796314701;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rCaHAZhH31k5FE32Msg9J7ahvRgbmktmMv6e5KioQ7E=;
 b=MH5ALxTSum0w/twszRyYFtBvz9pyVUqt6lNQFgz2hQPUCWIaNB0IVkUYHerB8fjiZ1
 L6Tey5Wz0Fd0pFvusKhePWICEvjliNcWdLpH4jRFIH2I5Uw8/5/xEeFtnItUlk7D1tg+
 SMeUF70z7tqboRPiN5KgZ2qOyWxA8VlwoTaSbMr3O4eEWrliIsUoXn5i8dt3W5GUOy//
 yjmm4V/VNs70pvHrZOevVKi0B8WaVf6r0aySYS1Lvd70LSZdPKLhoJOVwBiAhh7LL84y
 Ag3DLkLK65+dD0oWzyx5xtM0PiLaswSzTh0fXD7o2o1VLhxuWt40UgfzqzhnRJiJnx6i
 Py4Q==
X-Gm-Message-State: APuU4Z9aGOhTxHKaEWPk6up3p1qkt14EEzC2Sc5m49cdylluoJM8hUEf
 RXjxzT7fyjxujAIPUVBAYs2ks7oc9MhkJQI8NpdcwEwR8EbPoe/+jlU7I90RFYa/u0AGx+cDXUH
 Qlp5C8qf52Ln6DI3yT+rp4FrHtJr8peqR5hX+DOzNY5CNQmHP3eIa5N9NFtwa+Lci/NlU0A+wVC
 v+9zbkdQ==
X-Gm-Gg: AZFdTZcohcBgqGRfKaQPPE3nI8p5cIX2AbK0cmrYne3nW12l+IhjxQgtR938tDlltGB
 JAJR8jygfzogc8Bg00DfFsTND6pkJqy9lNvCRKjRYRyG7Viqqa9OGI6fGl2p6vm/DlFhbs9vP+L
 BWieAbihPDsMRTjObxmaTQgaokxxT+obEW6JIZKpdIVQAFvieJCpKTNm1EEeZolLS2Gz9v+TyX3
 JsTQkWrZjKxoJPrUGE282RKaVOkYaXZTK8moV0D3tCION+kxuyUgbYiFJA5gvXOOOWQL/fEiLzR
 KTla54hBPiBg9DXNBBjMR1YlBRZ/q+cT1WNs/cY9ZO4VvQRjd2NjYQE1LZ1M0v7mCilTMX5ujrE
 PVYm6mEWcwNeyIiMSZKfMne+J5F+k7wuoz20KPTYZPjTs4uzV9Y1G3fTccPUAPIOSnqQeZlm9c9
 BULp8HUDCyq72mMXDLAgwGDxqWWgVdAYgdgyHOfKGPFzXHUVmKq8McurgoLF7b1Jy3P9vLfIH7p
 9kzEMollNW1KnunuzU704TpndeAxB4neG0tRIdd7qsIF1CAg8yu2y5DRisNXoytrLaywX1dzrco
 B7VxPwbTtUtuZ9DKPhTUDB/FvX4ZPh2snNULnL+zpCPA3dnxFgBPPECIYM9OV0BLkpBcJDab29s
 daHtldqMpcU2LF5FCDChPJw1BM4b88dn9iuvJRgqnRDXhFnRcU7SU9h4k3no5c1ZloXystgURwx
 Yah5XcDQfUbDIGbsE=
X-Received: by 2002:a05:6000:2601:b0:491:68e2:bf2f with SMTP id
 ffacd0b85a97d-4abb9642f3fmr48415489f8f.52.1795709900932; 
 Thu, 26 Nov 2026 08:18:20 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm43350638f8f.8.2026.11.26.08.18.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 08:18:20 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 16:18:18 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1f775940c13cf989cf804bf637d4a63c3fe5aaaf
X-Gerrit-Change-Number: 2355
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2355?usp=email>
X-Gerrit-Commit: 9673b2028574e8d6b5e9461400e6b8da1cc83d60
In-Reply-To: <gerrit.1795699206000.I1f775940c13cf989cf804bf637d4a63c3fe5aaaf@gerrit.openvpn.net>
References: <gerrit.1795699206000.I1f775940c13cf989cf804bf637d4a63c3fe5aaaf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njk5MjA2MDAwLkkxZjc3NTk0MGMxM2NmOTg5Y2Y4MDRiZjYzN2Q0YTYzYzNmZTVhYWFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a3621e44c1f3e6206fde2d107826114cea100c71-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWcB1-00000000871-3UxI
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Cleaning up Windows
 error handling for sign conversion
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1669880101206730333=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1669880101206730333==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sNeXIK2JIuk="; charset=UTF-8

--sNeXIK2JIuk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like y=
ou to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2355?usp=3Demail

to look at the new patch set (#2)=2E

The f=
ollowing approvals got outdated and were removed:
Build-Request+1 by Frank =
Lichtenheld, Code-Review-1 by R=C4=83zvan Cojocaru


Change subject: Cleani=
ng up Windows error handling for sign conversion
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Cleaning up Windows error handling fo=
r sign conversion

This is a mess, generally=2E Most functions return error=
s
as DWORD, but the Reg* ones use LSTATUS which is signed=2E

Trying to unt=
angle this a bit, but still requires copious
casting=2E

Change-Id: I1f7759=
40c13cf989cf804bf637d4a63c3fe5aaaf
Signed-off-by: Frank Lichtenheld <frank@=
lichtenheld=2Ecom>
---
M include/openvpn-msg=2Eh
M src/openvpn/error=2Ec
M =
src/openvpn/error=2Eh
M src/openvpn/route=2Ec
M src/openvpn/tun=2Ec
M src/o=
penvpn/win32=2Ec
M src/openvpnserv/common=2Ec
M src/openvpnserv/interactive=
=2Ec
8 files changed, 73 insertions(+), 95 deletions(-)


  git pull ssh://=
gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/55/2355/2

diff --git a/i=
nclude/openvpn-msg=2Eh b/include/openvpn-msg=2Eh
index dd20f7b=2E=2E9f0c9ce=
 100644
--- a/include/openvpn-msg=2Eh
+++ b/include/openvpn-msg=2Eh
@@ -157=
,7 +157,7 @@
 typedef struct
 {
     message_header_t header;
-    int erro=
r_number;
+    DWORD error_number;
 } ack_message_t;
 
 typedef struct
diff=
 --git a/src/openvpn/error=2Ec b/src/openvpn/error=2Ec
index a3f7990=2E=2E1=
8d0b57 100644
--- a/src/openvpn/error=2Ec
+++ b/src/openvpn/error=2Ec
@@ -2=
19,18 +219,13 @@
     va_end(arglist);
 }
 
-#if defined(_WIN32) && (define=
d(__GNUC__) || defined(__clang__))
-#pragma GCC diagnostic push
-#pragma GC=
C diagnostic ignored "-Wsign-conversion"
-#endif
-
 static const char *
 op=
envpn_strerror(int err, bool crt_error, struct gc_arena *gc)
 {
 #ifdef _WI=
N32
     if (!crt_error)
     {
-        return strerror_win32(err, gc);
+ =
       return strerror_win32((DWORD)err, gc);
     }
 #endif
     return st=
rerror(err);
@@ -694,10 +689,6 @@
     }
 }
 
-#if defined(_WIN32) && (defi=
ned(__GNUC__) || defined(__clang__))
-#pragma GCC diagnostic pop
-#endif
-
=
 /*
  * In multiclient mode, put a client-specific prefix
  * before each m=
essage=2E
diff --git a/src/openvpn/error=2Eh b/src/openvpn/error=2Eh
index =
0056d05=2E=2E91d4ffe 100644
--- a/src/openvpn/error=2Eh
+++ b/src/openvpn/e=
rror=2Eh
@@ -406,18 +406,13 @@
 }
 #endif
 
-#if defined(_WIN32) && (define=
d(__GNUC__) || defined(__clang__))
-#pragma GCC diagnostic push
-#pragma GC=
C diagnostic ignored "-Wsign-conversion"
-#endif
-
 static inline int
 open=
vpn_errno_maybe_crt(bool *crt_error)
 {
     int err =3D 0;
 #ifdef _WIN32
=
     *crt_error =3D false;
-    err =3D GetLastError();
+    err =3D (int)G=
etLastError();
     if (err =3D=3D ERROR_SUCCESS)
     {
         /* error =
is likely C runtime */
@@ -431,10 +426,6 @@
     return err;
 }
 
-#if defi=
ned(_WIN32) && (defined(__GNUC__) || defined(__clang__))
-#pragma GCC diagn=
ostic pop
-#endif
-
 #include "errlevel=2Eh"
 
 #endif /* ifndef ERROR_H */=

diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 82cb7f0=
=2E=2E0a1e65f 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2E=
c
@@ -2805,7 +2805,7 @@
         ret =3D (ack=2Eerror_number =3D=3D ERROR_O=
BJECT_ALREADY_EXISTS) ? RTA_EEXIST : RTA_ERROR;
         if (ret =3D=3D RTA=
_ERROR)
         {
-            msg(M_WARN, "ERROR: route %s failed using s=
ervice: %s [status=3D%d if_index=3D%lu]",
+            msg(M_WARN, "ERROR: =
route %s failed using service: %s [status=3D%lu if_index=3D%lu]",
         =
        (add ? "addition" : "deletion"), strerror_win32(ack=2Eerror_number,=
 &gc),
                 ack=2Eerror_number, rt->iface=2Eindex);
         }
=
diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index 65edf73=2E=2E0=
74fe20 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -157,7=
 +157,7 @@
 
     if (ack=2Eerror_number !=3D NO_ERROR)
     {
-        msg=
(M_WARN, "TUN: %s address failed using service: %s [status=3D%d if_index=3D=
%lu]",
+        msg(M_WARN, "TUN: %s address failed using service: %s [stat=
us=3D%lu if_index=3D%lu]",
             (add ? "adding" : "deleting"), stre=
rror_win32(ack=2Eerror_number, &gc), ack=2Eerror_number,
             addr=
=2Eiface=2Eindex);
         goto out;
@@ -228,7 +228,7 @@
 
     if (ack=2E=
error_number !=3D NO_ERROR)
     {
-        msg(M_WARN, "TUN: %s DNS domain=
s failed using service: %s [status=3D%d if_name=3D%s]",
+        msg(M_WARN=
, "TUN: %s DNS domains failed using service: %s [status=3D%lu if_name=3D%s]=
",
             (add ? "adding" : "deleting"), strerror_win32(ack=2Eerror_n=
umber, &gc), ack=2Eerror_number,
             dns=2Eiface=2Ename);
        =
 goto out;
@@ -297,7 +297,7 @@
 
     if (ack=2Eerror_number !=3D NO_ERROR)=

     {
-        msg(M_WARN, "TUN: %s %s dns failed using service: %s [stat=
us=3D%d if_name=3D%s]",
+        msg(M_WARN, "TUN: %s %s dns failed using s=
ervice: %s [status=3D%lu if_name=3D%s]",
             (add ? "adding" : "de=
leting"), ip_proto_name, strerror_win32(ack=2Eerror_number, &gc),
         =
    ack=2Eerror_number, dns=2Eiface=2Ename);
         goto out;
@@ -353,7 +=
353,7 @@
 
     if (ack=2Eerror_number !=3D NO_ERROR)
     {
-        msg(M=
_WARN, "TUN: %s WINS failed using service: %s [status=3D%d if_name=3D%s]",
=
+        msg(M_WARN, "TUN: %s WINS failed using service: %s [status=3D%lu i=
f_name=3D%s]",
             (add ? "adding" : "deleting"), strerror_win32(a=
ck=2Eerror_number, &gc),
             ack=2Eerror_number, wins=2Eiface=2Ena=
me);
         goto out;
@@ -391,7 +391,7 @@
 
     if (ack=2Eerror_number !=
=3D NO_ERROR)
     {
-        msg(M_NONFATAL, "TUN: setting %s mtu using se=
rvice failed: %s [status=3D%d if_index=3D%lu]",
+        msg(M_NONFATAL, "T=
UN: setting %s mtu using service failed: %s [status=3D%lu if_index=3D%lu]",=

             family_name, strerror_win32(ack=2Eerror_number, &gc), ack=2Ee=
rror_number,
             mtu_msg=2Eiface=2Eindex);
     }
@@ -469,7 +469,7=
 @@
 
     if (ack=2Eerror_number !=3D NO_ERROR)
     {
-        msg(M_NONF=
ATAL, "TUN: creating %s adapter using service failed: %s [status=3D%d]",
+ =
       msg(M_NONFATAL, "TUN: creating %s adapter using service failed: %s [=
status=3D%lu]",
             print_tun_backend_driver(driver_type), strerro=
r_win32(ack=2Eerror_number, &gc),
             ack=2Eerror_number);
     }
=
@@ -5305,7 +5305,7 @@
 
     if (ack=2Eerror_number !=3D NO_ERROR)
     {
-=
        msg(M_NONFATAL, "TUN: enabling dhcp using service failed: %s [statu=
s=3D%d if_index=3D%lu]",
+        msg(M_NONFATAL, "TUN: enabling dhcp using=
 service failed: %s [status=3D%lu if_index=3D%lu]",
             strerror_w=
in32(ack=2Eerror_number, &gc), ack=2Eerror_number, dhcp=2Eiface=2Eindex);
 =
    }
     else
@@ -5477,7 +5477,7 @@
 
     else if (ack=2Eerror_number !=
=3D NO_ERROR)
     {
-        msg(M_WARN, "Register_dns failed using servic=
e: %s [status=3D0x%x]",
+        msg(M_WARN, "Register_dns failed using ser=
vice: %s [status=3D0x%lx]",
             strerror_win32(ack=2Eerror_number,=
 &gc), ack=2Eerror_number);
     }
 
diff --git a/src/openvpn/win32=2Ec b/s=
rc/openvpn/win32=2Ec
index 2415847=2E=2Ea4ed152 100644
--- a/src/openvpn/wi=
n32=2Ec
+++ b/src/openvpn/win32=2Ec
@@ -1239,7 +1239,7 @@
     if (ack=2Eer=
ror_number !=3D NO_ERROR)
     {
         msg(M_WARN,
-            "WFP blo=
ck: %s block filters using service failed: %s [status=3D0x%x if_index=3D%lu=
]",
+            "WFP block: %s block filters using service failed: %s [sta=
tus=3D0x%lx if_index=3D%lu]",
             (add ? "adding" : "deleting"), s=
trerror_win32(ack=2Eerror_number, &gc), ack=2Eerror_number,
             da=
ta=2Eiface=2Eindex);
         goto out;
diff --git a/src/openvpnserv/common=
=2Ec b/src/openvpnserv/common=2Ec
index e20feb7=2E=2Ede7847e 100644
--- a/s=
rc/openvpnserv/common=2Ec
+++ b/src/openvpnserv/common=2Ec
@@ -38,7 +38,7 @=
@
 static DWORD
 GetRegString(HKEY key, LPCWSTR value, LPWSTR data, DWORD s=
ize, LPCWSTR default_value)
 {
-    LONG status =3D RegGetValue(key, NULL, =
value, RRF_RT_REG_SZ, NULL, (LPBYTE)data, &size);
+    LSTATUS status =3D R=
egGetValue(key, NULL, value, RRF_RT_REG_SZ, NULL, (LPBYTE)data, &size);
 
 =
    if (status =3D=3D ERROR_FILE_NOT_FOUND && default_value)
     {
@@ -51,=
7 +51,7 @@
 
     if (status !=3D ERROR_SUCCESS)
     {
-        SetLastErr=
or(status);
+        SetLastError((DWORD)status);
         return MsgToEven=
tLog(
             M_SYSERR,
             L"Error querying registry value: =
HKLM\\SOFTWARE\\" _L(PACKAGE_NAME) L"%ls\\%ls",
@@ -91,19 +91,18 @@
 
     =
swprintf(reg_path, _countof(reg_path), L"SOFTWARE\\" _L(PACKAGE_NAME) L"%ls=
", service_instance);
 
-    LONG status =3D RegOpenKeyEx(HKEY_LOCAL_MACHIN=
E, reg_path, 0, KEY_READ, &key);
+    LSTATUS status =3D RegOpenKeyEx(HKEY_=
LOCAL_MACHINE, reg_path, 0, KEY_READ, &key);
     if (status !=3D ERROR_SUC=
CESS)
     {
-        SetLastError(status);
+        SetLastError((DWORD)st=
atus);
         return MsgToEventLog(M_SYSERR, L"Could not open Registry ke=
y HKLM\\%ls not found",
                              reg_path);
     }
 
 =
    /* The default value of REG_KEY is the install path */
-    status =3D =
GetRegString(key, NULL, install_path, sizeof(install_path), NULL);
-    if =
(status !=3D ERROR_SUCCESS)
+    error =3D GetRegString(key, NULL, install_=
path, sizeof(install_path), NULL);
+    if (error !=3D ERROR_SUCCESS)
     =
{
-        error =3D status;
         goto out;
     }
 
diff --git a/src/o=
penvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index 1cb191a=
=2E=2E0792a51 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvp=
nserv/interactive=2Ec
@@ -545,7 +545,7 @@
     return sa_inet;
 }
 
-static=
 DWORD
+static NETIO_STATUS
 InterfaceLuid(const char *iface_name, PNET_LUI=
D luid)
 {
     NETIO_STATUS convert_status;
@@ -569,16 +569,10 @@
     ret=
urn memcmp(item, address, sizeof(MIB_UNICASTIPADDRESS_ROW)) =3D=3D 0 ? TRUE=
 : FALSE;
 }
 
-static DWORD
-DeleteAddress(PMIB_UNICASTIPADDRESS_ROW addr_=
row)
-{
-    return DeleteUnicastIpAddressEntry(addr_row);
-}
-
-static DWO=
RD
+static NETIO_STATUS
 HandleAddressMessage(address_message_t *msg, undo_=
lists_t *lists)
 {
-    DWORD err;
+    NETIO_STATUS err;
     PMIB_UNICAST=
IPADDRESS_ROW addr_row;
     BOOL add =3D msg->header=2Etype =3D=3D msg_add=
_address;
 
@@ -621,12 +615,12 @@
         err =3D AddListItem(&(*lists)[ad=
dress], addr_row);
         if (err)
         {
-            DeleteAddress(=
addr_row);
+            DeleteUnicastIpAddressEntry(addr_row);
         }
 =
    }
     else
     {
-        err =3D DeleteAddress(addr_row);
+        e=
rr =3D DeleteUnicastIpAddressEntry(addr_row);
         if (err)
         {
=
             goto out;
@@ -1225,10 +1219,10 @@
  *
  * @return NO_ERROR on =
success, or the Windows error code for the failure
  */
-static DWORD
+stat=
ic NETIO_STATUS
 InterfaceIdString(PCSTR itf_name, PWSTR str, size_t len)
 =
{
-    DWORD err;
+    NETIO_STATUS err;
     GUID guid;
     NET_LUID luid=
;
     PWSTR iid_str =3D NULL;
@@ -1784,10 +1778,10 @@
  * The gpol value i=
s only valid if the function returns no error=2E In the error
  * case noth=
ing is changed=2E
  */
-static DWORD
+static LSTATUS
 SetDnsSearchDomains(P=
CSTR itf_name, PCSTR domains, PBOOL gpol, undo_lists_t *lists)
 {
-    DWOR=
D err =3D ERROR_OUTOFMEMORY;
+    LSTATUS err =3D ERROR_OUTOFMEMORY;
 
    =
 HKEY list_key;
     BOOL have_list =3D GetDnsSearchListKey(itf_name, gpol,=
 &list_key);
@@ -1882,12 +1876,12 @@
  * @param family    internet address =
family to set the servers for
  * @param value     the value to set the nam=
e servers to
  *
- * @return DWORD NO_ERROR on success, a Windows error cod=
e otherwise
+ * @return NO_ERROR on success, a Windows error code otherwise=

  */
-static DWORD
+static LSTATUS
 SetNameServersValue(PCWSTR itf_id, ADD=
RESS_FAMILY family, PCSTR value)
 {
-    DWORD err;
+    LSTATUS err;
 
   =
  HKEY itfs;
     if (!GetInterfacesKey(family, &itfs))
@@ -1929,9 +1923,9 =
@@
  * @param itf_id    the interface id to clear the servers for
  * @para=
m family    internet address family to clear the servers for
  *
- * @retur=
n DWORD NO_ERROR on success, a Windows error code otherwise
+ * @return NO_=
ERROR on success, a Windows error code otherwise
  */
-static DWORD
+static=
 LSTATUS
 ResetNameServers(PCWSTR itf_id, ADDRESS_FAMILY family)
 {
     re=
turn SetNameServersValue(itf_id, family, "");
@@ -1940,7 +1934,6 @@
 static=
 DWORD
 HandleDNSConfigMessage(const dns_cfg_message_t *msg, undo_lists_t *=
lists)
 {
-    DWORD err =3D 0;
     undo_type_t undo_type =3D (msg->family=
 =3D=3D AF_INET6) ? undo_dns6 : undo_dns4;
     unsigned int addr_len =3D m=
sg->addr_len;
 
@@ -1965,10 +1958,10 @@
     }
 
     WCHAR iid[64];
-    e=
rr =3D InterfaceIdString(msg->iface=2Ename, iid, _countof(iid));
-    if (e=
rr)
+    DWORD iid_err =3D InterfaceIdString(msg->iface=2Ename, iid, _count=
of(iid));
+    if (iid_err)
     {
-        return err;
+        return iid=
_err;
     }
 
     /* We delete all current addresses before adding any
@@=
 -1976,10 +1969,10 @@
      */
     if (addr_len > 0 || msg->header=2Etype =
=3D=3D msg_del_dns_cfg)
     {
-        err =3D ResetNameServers(iid, msg->=
family);
+        LSTATUS err =3D ResetNameServers(iid, msg->family);
     =
    if (err)
         {
-            return err;
+            return (DWORD=
)err;
         }
         free(RemoveListItem(&(*lists)[undo_type], CmpAny,=
 iid));
     }
@@ -1987,13 +1980,14 @@
     if (msg->header=2Etype =3D=3D m=
sg_del_dns_cfg)
     {
         BOOL gpol =3D FALSE;
+        LSTATUS err =
=3D 0;
         if (msg->domains[0])
         {
             /* setting an =
empty domain list removes any previous value */
             err =3D SetDns=
SearchDomains(msg->iface=2Ename, NULL, &gpol, lists);
         }
         A=
pplyDnsSettings(gpol);
-        return err; /* job done */
+        return =
(DWORD)err; /* job done */
     }
 
     if (addr_len > 0)
@@ -2020,10 +201=
4,10 @@
             offset =3D strlen(addrs);
         }
 
-        err =
=3D SetNameServersValue(iid, msg->family, addrs);
+        LSTATUS err =3D =
SetNameServersValue(iid, msg->family, addrs);
         if (err)
         {
=
-            return err;
+            return (DWORD)err;
         }
 
     =
    wchar_t *tmp_iid =3D _wcsdup(iid);
@@ -2036,13 +2030,14 @@
     }
 
   =
  BOOL gpol =3D FALSE;
+    LSTATUS domain_err =3D 0;
     if (msg->domains=
[0])
     {
-        err =3D SetDnsSearchDomains(msg->iface=2Ename, msg->do=
mains, &gpol, lists);
+        domain_err =3D SetDnsSearchDomains(msg->ifac=
e=2Ename, msg->domains, &gpol, lists);
     }
     ApplyDnsSettings(gpol);
=
 
-    return err;
+    return (DWORD)domain_err;
 }
 
 /**
@@ -2076,7 +207=
1,7 @@
  * @param itf_id        the VPN interface ID to set the name server=
s for
  * @param addresses     the list of NRPT addresses
  *
- * @return L=
STATUS NO_ERROR in case of success, a Windows error code otherwise
+ * @ret=
urn NO_ERROR in case of success, a Windows error code otherwise
  */
 stati=
c LSTATUS
 SetNameServerAddresses(PWSTR itf_id, const nrpt_address_t *addre=
sses)
@@ -2147,7 +2142,7 @@
  * @param  size       pointer to the size of t=
he buffer, contains the
  *                    size of the addresses on ret=
urn
  *
- * @return LSTATUS NO_ERROR on success, a Windows error code other=
wise
+ * @return NO_ERROR on success, a Windows error code otherwise
  */
 =
static LSTATUS
 GetItfDnsServersV4(HKEY itf_key, PSTR addrs, PDWORD size)
@=
@ -2193,7 +2188,7 @@
  * @param  size       pointer to the size of the buff=
er, contains the
  *                    size of the addresses on return
  *=

- * @return LSTATUS NO_ERROR on success, a Windows error code otherwise
+ =
* @return NO_ERROR on success, a Windows error code otherwise
  */
 static =
LSTATUS
 GetItfDnsServersV6(HKEY itf_key, PSTR addrs, PDWORD size)
@@ -2304=
,7 +2299,7 @@
  *                                the terminating zeros or 0=
=2E
  * @param[in]     capacity        capacity of the \p domains buffer in=
 bytes
  *
- * @return LSTATUS NO_ERROR if all domain suffix(es) were conve=
rted successfully,
+ * @return NO_ERROR if all domain suffix(es) were conve=
rted successfully,
  *         ERROR_FILE_NOT_FOUND if no domain was left a=
fter the conversion,
  *         ERROR_MORE_DATA if not all converted domai=
ns did fit into the buffer=2E
  *         ERROR_OUTOFMEMORY if the temporar=
y buffer could not be allocated=2E
@@ -2402,7 +2397,7 @@
  *               =
          set to the size of the string returned, including
  *            =
             the terminating zeros or 0=2E
  *
- * @return LSTATUS NO_ERROR=
 if the domain suffix(es) were read successfully,
+ * @return NO_ERROR if t=
he domain suffix(es) were read successfully,
  *         ERROR_FILE_NOT_FOU=
ND if no domain was found for the interface,
  *         ERROR_MORE_DATA if=
 the list did not fit into the buffer,
  *         any other error indicate=
s an error while reading from the registry=2E
@@ -2415,7 +2410,7 @@
       =
  return ERROR_INVALID_PARAMETER;
     }
 
-    LSTATUS err =3D ERROR_FILE_=
NOT_FOUND;
+    LSTATUS err;
     const DWORD buf_size =3D *size;
     cons=
t DWORD glyph_size =3D sizeof(*domains);
     PWSTR values[] =3D { L"Search=
List", L"Domain", L"DhcpDomainSearchList", L"DhcpDomain", NULL };
@@ -2621,=
12 +2616,12 @@
  *
  * @return NO_ERROR on success, or Windows error code
 =
 */
-static DWORD
+static LSTATUS
 SetNrptRule(HKEY nrpt_key, PCWSTR subkey=
, PCSTR address, PCWSTR domains, DWORD dom_size,
             BOOL dnssec)
=
 {
     /* Create rule subkey */
-    DWORD err =3D NO_ERROR;
+    LSTATUS =
err =3D NO_ERROR;
     HKEY rule_key;
     err =3D RegCreateKeyExW(nrpt_key=
, subkey, 0, NULL, 0, KEY_ALL_ACCESS, NULL, &rule_key, NULL);
     if (err)=

@@ -2729,13 +2724,12 @@
             break;
         }
 
-        DWORD er=
r;
         WCHAR subkey[48];
         swprintf(subkey, _countof(subkey), L=
"OpenVPNDNSRoutingX-%02x-%lu", ++n, ovpn_pid);
-        err =3D SetNrptRule=
(nrpt_key, subkey, d->addresses, d->domains, d->domains_size, FALSE);
+    =
    LSTATUS err =3D SetNrptRule(nrpt_key, subkey, d->addresses, d->domains,=
 d->domains_size, FALSE);
         if (err)
         {
-            MsgToEv=
entLog(M_ERR, L"%S: failed to set rule %s (%lu)", __func__, subkey, err);
+=
            MsgToEventLog(M_ERR, L"%S: failed to set rule %s (%ld)", __func=
__, subkey, err);
         }
     }
 }
@@ -2752,11 +2746,11 @@
  *
  * @ret=
urn NO_ERROR on success, or a Windows error code
  */
-static DWORD
+static=
 LSTATUS
 SetNrptRules(HKEY nrpt_key, const nrpt_address_t *addresses, cons=
t char *domains,
              const char *search_domains, BOOL dnssec, DWO=
RD ovpn_pid)
 {
-    DWORD err =3D NO_ERROR;
+    LSTATUS err =3D NO_ERROR;=

     PWSTR wide_domains =3D L"=2E\0"; /* DNS route everything by default *=
/
     DWORD dom_size =3D 6;
 
@@ -2815,7 +2809,7 @@
         err =3D SetNr=
ptRule(nrpt_key, subkey, addr_list, wide_domains, dom_size, dnssec);
      =
   if (err)
         {
-            MsgToEventLog(M_ERR, L"%S: failed to se=
t rule %s (%lu)", __func__, subkey, err);
+            MsgToEventLog(M_ERR,=
 L"%S: failed to set rule %s (%ld)", __func__, subkey, err);
         }
   =
  }
 
@@ -3033,14 +3027,15 @@
     }
 
     HKEY key;
-    LSTATUS err =3D =
OpenNrptBaseKey(&key, &gpol_nrpt);
-    if (err)
+    LSTATUS reg_err =3D O=
penNrptBaseKey(&key, &gpol_nrpt);
+    if (reg_err)
     {
-        return =
err;
+        return (DWORD)reg_err;
     }
 
     /* Add undo information =
first in case there's no heap left */
     PDWORD pid =3D malloc(sizeof(ovp=
n_pid));
+    DWORD err =3D 0;
     if (!pid)
     {
         err =3D ERROR=
_OUTOFMEMORY;
@@ -3056,10 +3051,11 @@
 
     /* Set NRPT rules */
     BOOL=
 dnssec =3D (msg->flags & nrpt_dnssec) !=3D 0;
-    err =3D SetNrptRules(ke=
y, msg->addresses, msg->resolve_domains, msg->search_domains, dnssec,
-    =
                   ovpn_pid);
-    if (err)
+    reg_err =3D SetNrptRules(k=
ey, msg->addresses, msg->resolve_domains, msg->search_domains, dnssec,
+   =
                        ovpn_pid);
+    if (reg_err)
     {
+        err =
=3D (DWORD)reg_err;
         goto out;
     }
 
@@ -3071,9 +3067,10 @@
    =
  */
     if (msg->search_domains[0] || !msg->resolve_domains[0])
     {
- =
       err =3D SetNameServerAddresses(iid, msg->addresses);
-        if (er=
r)
+        reg_err =3D SetNameServerAddresses(iid, msg->addresses);
+     =
   if (reg_err)
         {
+            err =3D (DWORD)reg_err;
           =
  goto out;
         }
     }
@@ -3081,7 +3078,7 @@
     /* Set search doma=
ins, if any */
     if (msg->search_domains[0])
     {
-        err =3D Set=
DnsSearchDomains(msg->iface=2Ename, msg->search_domains, &gpol_list, lists)=
;
+        err =3D (DWORD)SetDnsSearchDomains(msg->iface=2Ename, msg->searc=
h_domains, &gpol_list, lists);
     }
 
     ApplyDnsSettings(gpol_nrpt || =
gpol_list);
@@ -3389,7 +3386,7 @@
             switch (type)
             {=

                 case address:
-                    DeleteAddress(item->da=
ta);
+                    DeleteUnicastIpAddressEntry(item->data);
        =
             break;
 
                 case route:
@@ -3799,7 +3796,7 @@
  =
   RPC_STATUS rpc_stat =3D UuidCreate(&pipe_uuid);
     if (rpc_stat !=3D R=
PC_S_OK)
     {
-        ReturnError(pipe, rpc_stat, L"UuidCreate", 1, &exi=
t_event);
+        ReturnError(pipe, (DWORD)rpc_stat, L"UuidCreate", 1, &ex=
it_event);
         goto out;
     }
 
@@ -3807,7 +3804,7 @@
     rpc_stat =
=3D UuidToStringW(&pipe_uuid, &pipe_uuid_str);
     if (rpc_stat !=3D RPC_S=
_OK)
     {
-        ReturnError(pipe, rpc_stat, L"UuidToString", 1, &exit_=
event);
+        ReturnError(pipe, (DWORD)rpc_stat, L"UuidToString", 1, &ex=
it_event);
         goto out;
     }
     swprintf(ovpn_pipe_name, _countof=
(ovpn_pipe_name),

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2355?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I1f775940c13cf989cf804bf637d4a63c3fe5aaaf
Gerrit-Change-Number: 2355
Ger=
rit-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
G=
errit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: =
Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Co=
jocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mail=
box=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--sNeXIK2JIuk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Frank Lichtenheld <strong>uploaded patch set #2</strong> to thi=
s change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/235=
5?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Build-Request+1 by Frank Lichtenheld, Code-Review-1 by R=
=C4=83zvan Cojocaru</p><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">Cleaning up Windows error handling for=
 sign conversion<br><br>This is a mess, generally=2E Most functions return =
errors<br>as DWORD, but the Reg* ones use LSTATUS which is signed=2E<br><br=
>Trying to untangle this a bit, but still requires copious<br>casting=2E<br=
><br>Change-Id: I1f775940c13cf989cf804bf637d4a63c3fe5aaaf<br>Signed-off-by:=
 Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M include/open=
vpn-msg=2Eh<br>M src/openvpn/error=2Ec<br>M src/openvpn/error=2Eh<br>M src/=
openvpn/route=2Ec<br>M src/openvpn/tun=2Ec<br>M src/openvpn/win32=2Ec<br>M =
src/openvpnserv/common=2Ec<br>M src/openvpnserv/interactive=2Ec<br>8 files =
changed, 73 insertions(+), 95 deletions(-)<br><br></pre><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/55/2355/2</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/include/openvpn-msg=2Eh b/include/openvpn-msg=2Eh</span><br=
><span>index dd20f7b=2E=2E9f0c9ce 100644</span><br><span>--- a/include/open=
vpn-msg=2Eh</span><br><span>+++ b/include/openvpn-msg=2Eh</span><br><span>@=
@ -157,7 +157,7 @@</span><br><span> typedef struct</span><br><span> {</span=
><br><span>     message_header_t header;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    int error_number;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    DWORD error_number;</span><br><span> } ack_message=
_t;</span><br><span> </span><br><span> typedef struct</span><br><span>diff =
--git a/src/openvpn/error=2Ec b/src/openvpn/error=2Ec</span><br><span>index=
 a3f7990=2E=2E18d0b57 100644</span><br><span>--- a/src/openvpn/error=2Ec</s=
pan><br><span>+++ b/src/openvpn/error=2Ec</span><br><span>@@ -219,18 +219,1=
3 @@</span><br><span>     va_end(arglist);</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_WIN3=
2) &amp;&amp; (defined(__GNUC__) || defined(__clang__))</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quo=
t;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span> static const char *</span><br><span> openvpn_strerror(int err, bool =
crt_error, struct gc_arena *gc)</span><br><span> {</span><br><span> #ifdef =
_WIN32</span><br><span>     if (!crt_error)</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        return strerror_win32(=
err, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn strerror_win32((DWORD)err, gc);</span><br><span>     }</span><br><span=
> #endif</span><br><span>     return strerror(err);</span><br><span>@@ -694=
,10 +689,6 @@</span><br><span>     }</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_WIN32) &am=
p;&amp; (defined(__GNUC__) || defined(__clang__))</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * In multiclient m=
ode, put a client-specific prefix</span><br><span>  * before each message=
=2E</span><br><span>diff --git a/src/openvpn/error=2Eh b/src/openvpn/error=
=2Eh</span><br><span>index 0056d05=2E=2E91d4ffe 100644</span><br><span>--- =
a/src/openvpn/error=2Eh</span><br><span>+++ b/src/openvpn/error=2Eh</span><=
br><span>@@ -406,18 +406,13 @@</span><br><span> }</span><br><span> #endif</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if d=
efined(_WIN32) &amp;&amp; (defined(__GNUC__) || defined(__clang__))</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic =
ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> static inline int</span><br><span> openvpn_errno_maybe_c=
rt(bool *crt_error)</span><br><span> {</span><br><span>     int err =3D 0;<=
/span><br><span> #ifdef _WIN32</span><br><span>     *crt_error =3D false;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    err =3D GetLastErro=
r();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    err =3D (in=
t)GetLastError();</span><br><span>     if (err =3D=3D ERROR_SUCCESS)</span>=
<br><span>     {</span><br><span>         /* error is likely C runtime */</=
span><br><span>@@ -431,10 +426,6 @@</span><br><span>     return err;</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#if defined(_WIN32) &amp;&amp; (defined(__GNUC__) || defined(__cla=
ng__))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #includ=
e &quot;errlevel=2Eh&quot;</span><br><span> </span><br><span> #endif /* ifn=
def ERROR_H */</span><br><span>diff --git a/src/openvpn/route=2Ec b/src/ope=
nvpn/route=2Ec</span><br><span>index 82cb7f0=2E=2E0a1e65f 100644</span><br>=
<span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=
=2Ec</span><br><span>@@ -2805,7 +2805,7 @@</span><br><span>         ret =3D=
 (ack=2Eerror_number =3D=3D ERROR_OBJECT_ALREADY_EXISTS) ? RTA_EEXIST : RTA=
_ERROR;</span><br><span>         if (ret =3D=3D RTA_ERROR)</span><br><span>=
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 msg(M_WARN, &quot;ERROR: route %s failed using service: %s [status=3D%d if=
_index=3D%lu]&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            msg(M_WARN, &quot;ERROR: route %s failed using service: %s [st=
atus=3D%lu if_index=3D%lu]&quot;,</span><br><span>                 (add ? &=
quot;addition&quot; : &quot;deletion&quot;), strerror_win32(ack=2Eerror_num=
ber, &amp;gc),</span><br><span>                 ack=2Eerror_number, rt-&gt;=
iface=2Eindex);</span><br><span>         }</span><br><span>diff --git a/src=
/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>index 65edf73=2E=2E0=
74fe20 100644</span><br><span>--- a/src/openvpn/tun=2Ec</span><br><span>+++=
 b/src/openvpn/tun=2Ec</span><br><span>@@ -157,7 +157,7 @@</span><br><span>=
 </span><br><span>     if (ack=2Eerror_number !=3D NO_ERROR)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M=
_WARN, &quot;TUN: %s address failed using service: %s [status=3D%d if_index=
=3D%lu]&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   msg(M_WARN, &quot;TUN: %s address failed using service: %s [status=3D%lu=
 if_index=3D%lu]&quot;,</span><br><span>             (add ? &quot;adding&qu=
ot; : &quot;deleting&quot;), strerror_win32(ack=2Eerror_number, &amp;gc), a=
ck=2Eerror_number,</span><br><span>             addr=2Eiface=2Eindex);</spa=
n><br><span>         goto out;</span><br><span>@@ -228,7 +228,7 @@</span><b=
r><span> </span><br><span>     if (ack=2Eerror_number !=3D NO_ERROR)</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   msg(M_WARN, &quot;TUN: %s DNS domains failed using service: %s [status=
=3D%d if_name=3D%s]&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        msg(M_WARN, &quot;TUN: %s DNS domains failed using service: =
%s [status=3D%lu if_name=3D%s]&quot;,</span><br><span>             (add ? &=
quot;adding&quot; : &quot;deleting&quot;), strerror_win32(ack=2Eerror_numbe=
r, &amp;gc), ack=2Eerror_number,</span><br><span>             dns=2Eiface=
=2Ename);</span><br><span>         goto out;</span><br><span>@@ -297,7 +297=
,7 @@</span><br><span> </span><br><span>     if (ack=2Eerror_number !=3D NO=
_ERROR)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        msg(M_WARN, &quot;TUN: %s %s dns failed using service: %s =
[status=3D%d if_name=3D%s]&quot;,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        msg(M_WARN, &quot;TUN: %s %s dns failed using service=
: %s [status=3D%lu if_name=3D%s]&quot;,</span><br><span>             (add ?=
 &quot;adding&quot; : &quot;deleting&quot;), ip_proto_name, strerror_win32(=
ack=2Eerror_number, &amp;gc),</span><br><span>             ack=2Eerror_numb=
er, dns=2Eiface=2Ename);</span><br><span>         goto out;</span><br><span=
>@@ -353,7 +353,7 @@</span><br><span> </span><br><span>     if (ack=2Eerror=
_number !=3D NO_ERROR)</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;TUN: %s WINS failed using=
 service: %s [status=3D%d if_name=3D%s]&quot;,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;TUN: %s WINS failed us=
ing service: %s [status=3D%lu if_name=3D%s]&quot;,</span><br><span>        =
     (add ? &quot;adding&quot; : &quot;deleting&quot;), strerror_win32(ack=
=2Eerror_number, &amp;gc),</span><br><span>             ack=2Eerror_number,=
 wins=2Eiface=2Ename);</span><br><span>         goto out;</span><br><span>@=
@ -391,7 +391,7 @@</span><br><span> </span><br><span>     if (ack=2Eerror_n=
umber !=3D NO_ERROR)</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        msg(M_NONFATAL, &quot;TUN: setting %s mtu usi=
ng service failed: %s [status=3D%d if_index=3D%lu]&quot;,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        msg(M_NONFATAL, &quot;TUN: se=
tting %s mtu using service failed: %s [status=3D%lu if_index=3D%lu]&quot;,<=
/span><br><span>             family_name, strerror_win32(ack=2Eerror_number=
, &amp;gc), ack=2Eerror_number,</span><br><span>             mtu_msg=2Eifac=
e=2Eindex);</span><br><span>     }</span><br><span>@@ -469,7 +469,7 @@</spa=
n><br><span> </span><br><span>     if (ack=2Eerror_number !=3D NO_ERROR)</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       msg(M_NONFATAL, &quot;TUN: creating %s adapter using service failed:=
 %s [status=3D%d]&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        msg(M_NONFATAL, &quot;TUN: creating %s adapter using service f=
ailed: %s [status=3D%lu]&quot;,</span><br><span>             print_tun_back=
end_driver(driver_type), strerror_win32(ack=2Eerror_number, &amp;gc),</span=
><br><span>             ack=2Eerror_number);</span><br><span>     }</span><=
br><span>@@ -5305,7 +5305,7 @@</span><br><span> </span><br><span>     if (a=
ck=2Eerror_number !=3D NO_ERROR)</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        msg(M_NONFATAL, &quot;TUN: enabli=
ng dhcp using service failed: %s [status=3D%d if_index=3D%lu]&quot;,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_NONFATAL, &q=
uot;TUN: enabling dhcp using service failed: %s [status=3D%lu if_index=3D%l=
u]&quot;,</span><br><span>             strerror_win32(ack=2Eerror_number, &=
amp;gc), ack=2Eerror_number, dhcp=2Eiface=2Eindex);</span><br><span>     }<=
/span><br><span>     else</span><br><span>@@ -5477,7 +5477,7 @@</span><br><=
span> </span><br><span>     else if (ack=2Eerror_number !=3D NO_ERROR)</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     msg(M_WARN, &quot;Register_dns failed using service: %s [status=3D0x%x=
]&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg=
(M_WARN, &quot;Register_dns failed using service: %s [status=3D0x%lx]&quot;=
,</span><br><span>             strerror_win32(ack=2Eerror_number, &amp;gc),=
 ack=2Eerror_number);</span><br><span>     }</span><br><span> </span><br><s=
pan>diff --git a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec</span><br><s=
pan>index 2415847=2E=2Ea4ed152 100644</span><br><span>--- a/src/openvpn/win=
32=2Ec</span><br><span>+++ b/src/openvpn/win32=2Ec</span><br><span>@@ -1239=
,7 +1239,7 @@</span><br><span>     if (ack=2Eerror_number !=3D NO_ERROR)</s=
pan><br><span>     {</span><br><span>         msg(M_WARN,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            &quot;WFP block: %s block f=
ilters using service failed: %s [status=3D0x%x if_index=3D%lu]&quot;,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;WFP blo=
ck: %s block filters using service failed: %s [status=3D0x%lx if_index=3D%l=
u]&quot;,</span><br><span>             (add ? &quot;adding&quot; : &quot;de=
leting&quot;), strerror_win32(ack=2Eerror_number, &amp;gc), ack=2Eerror_num=
ber,</span><br><span>             data=2Eiface=2Eindex);</span><br><span>  =
       goto out;</span><br><span>diff --git a/src/openvpnserv/common=2Ec b/=
src/openvpnserv/common=2Ec</span><br><span>index e20feb7=2E=2Ede7847e 10064=
4</span><br><span>--- a/src/openvpnserv/common=2Ec</span><br><span>+++ b/sr=
c/openvpnserv/common=2Ec</span><br><span>@@ -38,7 +38,7 @@</span><br><span>=
 static DWORD</span><br><span> GetRegString(HKEY key, LPCWSTR value, LPWSTR=
 data, DWORD size, LPCWSTR default_value)</span><br><span> {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    LONG status =3D RegGetValue(key,=
 NULL, value, RRF_RT_REG_SZ, NULL, (LPBYTE)data, &amp;size);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    LSTATUS status =3D RegGetValue=
(key, NULL, value, RRF_RT_REG_SZ, NULL, (LPBYTE)data, &amp;size);</span><br=
><span> </span><br><span>     if (status =3D=3D ERROR_FILE_NOT_FOUND &amp;&=
amp; default_value)</span><br><span>     {</span><br><span>@@ -51,7 +51,7 @=
@</span><br><span> </span><br><span>     if (status !=3D ERROR_SUCCESS)</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      SetLastError(status);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        SetLastError((DWORD)status);</span><br><span>         retur=
n MsgToEventLog(</span><br><span>             M_SYSERR,</span><br><span>   =
          L&quot;Error querying registry value: HKLM\\SOFTWARE\\&quot; _L(P=
ACKAGE_NAME) L&quot;%ls\\%ls&quot;,</span><br><span>@@ -91,19 +91,18 @@</sp=
an><br><span> </span><br><span>     swprintf(reg_path, _countof(reg_path), =
L&quot;SOFTWARE\\&quot; _L(PACKAGE_NAME) L&quot;%ls&quot;, service_instance=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   LONG status =3D RegOpenKeyEx(HKEY_LOCAL_MACHINE, reg_path, 0, KEY_READ, =
&amp;key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LSTAT=
US status =3D RegOpenKeyEx(HKEY_LOCAL_MACHINE, reg_path, 0, KEY_READ, &amp;=
key);</span><br><span>     if (status !=3D ERROR_SUCCESS)</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        SetLastE=
rror(status);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  SetLastError((DWORD)status);</span><br><span>         return MsgToEventLo=
g(M_SYSERR, L&quot;Could not open Registry key HKLM\\%ls not found&quot;,</=
span><br><span>                              reg_path);</span><br><span>   =
  }</span><br><span> </span><br><span>     /* The default value of REG_KEY =
is the install path */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    status =3D GetRegString(key, NULL, install_path, sizeof(install_path),=
 NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (status=
 !=3D ERROR_SUCCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    error =3D GetRegString(key, NULL, install_path, sizeof(install_path), =
NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (error=
 !=3D ERROR_SUCCESS)</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        error =3D status;</span><br><span>         go=
to out;</span><br><span>     }</span><br><span> </span><br><span>diff --git=
 a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span>=
<br><span>index 1cb191a=2E=2E0792a51 100644</span><br><span>--- a/src/openv=
pnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2E=
c</span><br><span>@@ -545,7 +545,7 @@</span><br><span>     return sa_inet;<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-static DWORD</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static NETIO_STATUS</span><br><span> InterfaceLuid(const char *ifac=
e_name, PNET_LUID luid)</span><br><span> {</span><br><span>     NETIO_STATU=
S convert_status;</span><br><span>@@ -569,16 +569,10 @@</span><br><span>   =
  return memcmp(item, address, sizeof(MIB_UNICASTIPADDRESS_ROW)) =3D=3D 0 ?=
 TRUE : FALSE;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static DWORD</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-DeleteAddress(PMIB_UNICASTIPADDRESS_ROW addr_row)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return DeleteUnicastIpAddressEntry(addr=
_row);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-static DWORD</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static NETIO_STATUS</span><br><span> HandleAddressMessage(addre=
ss_message_t *msg, undo_lists_t *lists)</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    DWORD err;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    NETIO_STATUS err;</span><br><span>   =
  PMIB_UNICASTIPADDRESS_ROW addr_row;</span><br><span>     BOOL add =3D msg=
-&gt;header=2Etype =3D=3D msg_add_address;</span><br><span> </span><br><spa=
n>@@ -621,12 +615,12 @@</span><br><span>         err =3D AddListItem(&amp;(=
*lists)[address], addr_row);</span><br><span>         if (err)</span><br><s=
pan>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     DeleteAddress(addr_row);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            DeleteUnicastIpAddressEntry(addr_row);</span><br><spa=
n>         }</span><br><span>     }</span><br><span>     else</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        err =
=3D DeleteAddress(addr_row);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        err =3D DeleteUnicastIpAddressEntry(addr_row);</span><br><=
span>         if (err)</span><br><span>         {</span><br><span>         =
    goto out;</span><br><span>@@ -1225,10 +1219,10 @@</span><br><span>  *</=
span><br><span>  * @return NO_ERROR on success, or the Windows error code f=
or the failure</span><br><span>  */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-static DWORD</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static NETIO_STATUS</span><br><span> InterfaceIdString(PCSTR itf_nam=
e, PWSTR str, size_t len)</span><br><span> {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    DWORD err;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    NETIO_STATUS err;</span><br><span>     GUID guid;</sp=
an><br><span>     NET_LUID luid;</span><br><span>     PWSTR iid_str =3D NUL=
L;</span><br><span>@@ -1784,10 +1778,10 @@</span><br><span>  * The gpol val=
ue is only valid if the function returns no error=2E In the error</span><br=
><span>  * case nothing is changed=2E</span><br><span>  */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-static DWORD</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static LSTATUS</span><br><span> SetDnsSearchD=
omains(PCSTR itf_name, PCSTR domains, PBOOL gpol, undo_lists_t *lists)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    DWO=
RD err =3D ERROR_OUTOFMEMORY;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    LSTATUS err =3D ERROR_OUTOFMEMORY;</span><br><span> </span><b=
r><span>     HKEY list_key;</span><br><span>     BOOL have_list =3D GetDnsS=
earchListKey(itf_name, gpol, &amp;list_key);</span><br><span>@@ -1882,12 +1=
876,12 @@</span><br><span>  * @param family    internet address family to s=
et the servers for</span><br><span>  * @param value     the value to set th=
e name servers to</span><br><span>  *</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * @return DWORD NO_ERROR on success, a Windows error code =
otherwise</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return=
 NO_ERROR on success, a Windows error code otherwise</span><br><span>  */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-static DWORD</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static LSTATUS</span><br><span=
> SetNameServersValue(PCWSTR itf_id, ADDRESS_FAMILY family, PCSTR value)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    D=
WORD err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LSTATU=
S err;</span><br><span> </span><br><span>     HKEY itfs;</span><br><span>  =
   if (!GetInterfacesKey(family, &amp;itfs))</span><br><span>@@ -1929,9 +19=
23,9 @@</span><br><span>  * @param itf_id    the interface id to clear the =
servers for</span><br><span>  * @param family    internet address family to=
 clear the servers for</span><br><span>  *</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * @return DWORD NO_ERROR on success, a Windows error =
code otherwise</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @r=
eturn NO_ERROR on success, a Windows error code otherwise</span><br><span> =
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static DWORD</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static LSTATUS</span><br>=
<span> ResetNameServers(PCWSTR itf_id, ADDRESS_FAMILY family)</span><br><sp=
an> {</span><br><span>     return SetNameServersValue(itf_id, family, &quot=
;&quot;);</span><br><span>@@ -1940,7 +1934,6 @@</span><br><span> static DWO=
RD</span><br><span> HandleDNSConfigMessage(const dns_cfg_message_t *msg, un=
do_lists_t *lists)</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    DWORD err =3D 0;</span><br><span>     undo_type_t undo_=
type =3D (msg-&gt;family =3D=3D AF_INET6) ? undo_dns6 : undo_dns4;</span><b=
r><span>     unsigned int addr_len =3D msg-&gt;addr_len;</span><br><span> <=
/span><br><span>@@ -1965,10 +1958,10 @@</span><br><span>     }</span><br><s=
pan> </span><br><span>     WCHAR iid[64];</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    err =3D InterfaceIdString(msg-&gt;iface=2Ename, iid=
, _countof(iid));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (err)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD i=
id_err =3D InterfaceIdString(msg-&gt;iface=2Ename, iid, _countof(iid));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (iid_err)</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   return err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return iid_err;</span><br><span>     }</span><br><span> </span><br><span=
>     /* We delete all current addresses before adding any</span><br><span>=
@@ -1976,10 +1969,10 @@</span><br><span>      */</span><br><span>     if (a=
ddr_len &gt; 0 || msg-&gt;header=2Etype =3D=3D msg_del_dns_cfg)</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        er=
r =3D ResetNameServers(iid, msg-&gt;family);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        LSTATUS err =3D ResetNameServers(iid, msg-=
&gt;family);</span><br><span>         if (err)</span><br><span>         {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            return err;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return =
(DWORD)err;</span><br><span>         }</span><br><span>         free(Remove=
ListItem(&amp;(*lists)[undo_type], CmpAny, iid));</span><br><span>     }</s=
pan><br><span>@@ -1987,13 +1980,14 @@</span><br><span>     if (msg-&gt;head=
er=2Etype =3D=3D msg_del_dns_cfg)</span><br><span>     {</span><br><span>  =
       BOOL gpol =3D FALSE;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        LSTATUS err =3D 0;</span><br><span>         if (msg-&gt;dom=
ains[0])</span><br><span>         {</span><br><span>             /* setting=
 an empty domain list removes any previous value */</span><br><span>       =
      err =3D SetDnsSearchDomains(msg-&gt;iface=2Ename, NULL, &amp;gpol, li=
sts);</span><br><span>         }</span><br><span>         ApplyDnsSettings(=
gpol);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return =
err; /* job done */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return (DWORD)err; /* job done */</span><br><span>     }</span><br>=
<span> </span><br><span>     if (addr_len &gt; 0)</span><br><span>@@ -2020,=
10 +2014,10 @@</span><br><span>             offset =3D strlen(addrs);</span=
><br><span>         }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        err =3D SetNameServersValue(iid, msg-&gt;family, =
addrs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        LSTA=
TUS err =3D SetNameServersValue(iid, msg-&gt;family, addrs);</span><br><spa=
n>         if (err)</span><br><span>         {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            return err;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            return (DWORD)err;</span><br><span=
>         }</span><br><span> </span><br><span>         wchar_t *tmp_iid =3D=
 _wcsdup(iid);</span><br><span>@@ -2036,13 +2030,14 @@</span><br><span>    =
 }</span><br><span> </span><br><span>     BOOL gpol =3D FALSE;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    LSTATUS domain_err =3D 0;</s=
pan><br><span>     if (msg-&gt;domains[0])</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        err =3D SetDnsSearchDom=
ains(msg-&gt;iface=2Ename, msg-&gt;domains, &amp;gpol, lists);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        domain_err =3D SetDnsSea=
rchDomains(msg-&gt;iface=2Ename, msg-&gt;domains, &amp;gpol, lists);</span>=
<br><span>     }</span><br><span>     ApplyDnsSettings(gpol);</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return err;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (DWORD)dom=
ain_err;</span><br><span> }</span><br><span> </span><br><span> /**</span><b=
r><span>@@ -2076,7 +2071,7 @@</span><br><span>  * @param itf_id        the =
VPN interface ID to set the name servers for</span><br><span>  * @param add=
resses     the list of NRPT addresses</span><br><span>  *</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * @return LSTATUS NO_ERROR in case of =
success, a Windows error code otherwise</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @return NO_ERROR in case of success, a Windows error=
 code otherwise</span><br><span>  */</span><br><span> static LSTATUS</span>=
<br><span> SetNameServerAddresses(PWSTR itf_id, const nrpt_address_t *addre=
sses)</span><br><span>@@ -2147,7 +2142,7 @@</span><br><span>  * @param  siz=
e       pointer to the size of the buffer, contains the</span><br><span>  *=
                    size of the addresses on return</span><br><span>  *</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return LSTATUS NO_ERR=
OR on success, a Windows error code otherwise</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @return NO_ERROR on success, a Windows error c=
ode otherwise</span><br><span>  */</span><br><span> static LSTATUS</span><b=
r><span> GetItfDnsServersV4(HKEY itf_key, PSTR addrs, PDWORD size)</span><b=
r><span>@@ -2193,7 +2188,7 @@</span><br><span>  * @param  size       pointe=
r to the size of the buffer, contains the</span><br><span>  *              =
      size of the addresses on return</span><br><span>  *</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * @return LSTATUS NO_ERROR on success,=
 a Windows error code otherwise</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @return NO_ERROR on success, a Windows error code otherwise<=
/span><br><span>  */</span><br><span> static LSTATUS</span><br><span> GetIt=
fDnsServersV6(HKEY itf_key, PSTR addrs, PDWORD size)</span><br><span>@@ -23=
04,7 +2299,7 @@</span><br><span>  *                                the term=
inating zeros or 0=2E</span><br><span>  * @param[in]     capacity        ca=
pacity of the \p domains buffer in bytes</span><br><span>  *</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * @return LSTATUS NO_ERROR if all d=
omain suffix(es) were converted successfully,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @return NO_ERROR if all domain suffix(es) were=
 converted successfully,</span><br><span>  *         ERROR_FILE_NOT_FOUND i=
f no domain was left after the conversion,</span><br><span>  *         ERRO=
R_MORE_DATA if not all converted domains did fit into the buffer=2E</span><=
br><span>  *         ERROR_OUTOFMEMORY if the temporary buffer could not be=
 allocated=2E</span><br><span>@@ -2402,7 +2397,7 @@</span><br><span>  *    =
                     set to the size of the string returned, including</spa=
n><br><span>  *                         the terminating zeros or 0=2E</span=
><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @ret=
urn LSTATUS NO_ERROR if the domain suffix(es) were read successfully,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return NO_ERROR if th=
e domain suffix(es) were read successfully,</span><br><span>  *         ERR=
OR_FILE_NOT_FOUND if no domain was found for the interface,</span><br><span=
>  *         ERROR_MORE_DATA if the list did not fit into the buffer,</span=
><br><span>  *         any other error indicates an error while reading fro=
m the registry=2E</span><br><span>@@ -2415,7 +2410,7 @@</span><br><span>   =
      return ERROR_INVALID_PARAMETER;</span><br><span>     }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    LSTATUS err =
=3D ERROR_FILE_NOT_FOUND;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    LSTATUS err;</span><br><span>     const DWORD buf_size =3D *size;=
</span><br><span>     const DWORD glyph_size =3D sizeof(*domains);</span><b=
r><span>     PWSTR values[] =3D { L&quot;SearchList&quot;, L&quot;Domain&qu=
ot;, L&quot;DhcpDomainSearchList&quot;, L&quot;DhcpDomain&quot;, NULL };</s=
pan><br><span>@@ -2621,12 +2616,12 @@</span><br><span>  *</span><br><span> =
 * @return NO_ERROR on success, or Windows error code</span><br><span>  */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-static DWORD</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static LSTATUS</span><br><spa=
n> SetNrptRule(HKEY nrpt_key, PCWSTR subkey, PCSTR address, PCWSTR domains,=
 DWORD dom_size,</span><br><span>             BOOL dnssec)</span><br><span>=
 {</span><br><span>     /* Create rule subkey */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    DWORD err =3D NO_ERROR;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    LSTATUS err =3D NO_ERROR;</span><br>=
<span>     HKEY rule_key;</span><br><span>     err =3D RegCreateKeyExW(nrpt=
_key, subkey, 0, NULL, 0, KEY_ALL_ACCESS, NULL, &amp;rule_key, NULL);</span=
><br><span>     if (err)</span><br><span>@@ -2729,13 +2724,12 @@</span><br>=
<span>             break;</span><br><span>         }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        DWORD err;</span><=
br><span>         WCHAR subkey[48];</span><br><span>         swprintf(subke=
y, _countof(subkey), L&quot;OpenVPNDNSRoutingX-%02x-%lu&quot;, ++n, ovpn_pi=
d);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        err =3D Se=
tNrptRule(nrpt_key, subkey, d-&gt;addresses, d-&gt;domains, d-&gt;domains_s=
ize, FALSE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 LSTATUS err =3D SetNrptRule(nrpt_key, subkey, d-&gt;addresses, d-&gt;domai=
ns, d-&gt;domains_size, FALSE);</span><br><span>         if (err)</span><br=
><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        MsgToEventLog(M_ERR, L&quot;%S: failed to set rule %s (%lu)&quot;, =
__func__, subkey, err);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            MsgToEventLog(M_ERR, L&quot;%S: failed to set rule %s (%ld)=
&quot;, __func__, subkey, err);</span><br><span>         }</span><br><span>=
     }</span><br><span> }</span><br><span>@@ -2752,11 +2746,11 @@</span><br=
><span>  *</span><br><span>  * @return NO_ERROR on success, or a Windows er=
ror code</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-static DWORD</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static LSTATUS</span><br><span> SetNrptRules(HKEY nrpt_key, const nrpt_add=
ress_t *addresses, const char *domains,</span><br><span>              const=
 char *search_domains, BOOL dnssec, DWORD ovpn_pid)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    DWORD err =3D NO_ERROR=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LSTATUS err =
=3D NO_ERROR;</span><br><span>     PWSTR wide_domains =3D L&quot;=2E\0&quot=
;; /* DNS route everything by default */</span><br><span>     DWORD dom_siz=
e =3D 6;</span><br><span> </span><br><span>@@ -2815,7 +2809,7 @@</span><br>=
<span>         err =3D SetNrptRule(nrpt_key, subkey, addr_list, wide_domain=
s, dom_size, dnssec);</span><br><span>         if (err)</span><br><span>   =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            Ms=
gToEventLog(M_ERR, L&quot;%S: failed to set rule %s (%lu)&quot;, __func__, =
subkey, err);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      MsgToEventLog(M_ERR, L&quot;%S: failed to set rule %s (%ld)&quot;, __=
func__, subkey, err);</span><br><span>         }</span><br><span>     }</sp=
an><br><span> </span><br><span>@@ -3033,14 +3027,15 @@</span><br><span>    =
 }</span><br><span> </span><br><span>     HKEY key;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    LSTATUS err =3D OpenNrptBaseKey(&amp;ke=
y, &amp;gpol_nrpt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (err)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LSTAT=
US reg_err =3D OpenNrptBaseKey(&amp;key, &amp;gpol_nrpt);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (reg_err)</span><br><span>    =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return err;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return (DWO=
RD)reg_err;</span><br><span>     }</span><br><span> </span><br><span>     /=
* Add undo information first in case there&#39;s no heap left */</span><br>=
<span>     PDWORD pid =3D malloc(sizeof(ovpn_pid));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    DWORD err =3D 0;</span><br><span>    =
 if (!pid)</span><br><span>     {</span><br><span>         err =3D ERROR_OU=
TOFMEMORY;</span><br><span>@@ -3056,10 +3051,11 @@</span><br><span> </span>=
<br><span>     /* Set NRPT rules */</span><br><span>     BOOL dnssec =3D (m=
sg-&gt;flags &amp; nrpt_dnssec) !=3D 0;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    err =3D SetNrptRules(key, msg-&gt;addresses, msg-&gt;=
resolve_domains, msg-&gt;search_domains, dnssec,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                       ovpn_pid);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (err)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    reg_err =3D SetNrptRules(key, msg-&gt=
;addresses, msg-&gt;resolve_domains, msg-&gt;search_domains, dnssec,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
 ovpn_pid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
reg_err)</span><br><span>     {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        err =3D (DWORD)reg_err;</span><br><span>         goto o=
ut;</span><br><span>     }</span><br><span> </span><br><span>@@ -3071,9 +30=
67,10 @@</span><br><span>      */</span><br><span>     if (msg-&gt;search_d=
omains[0] || !msg-&gt;resolve_domains[0])</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        err =3D SetNameServerAdd=
resses(iid, msg-&gt;addresses);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (err)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        reg_err =3D SetNameServerAddresses(iid, msg-&gt;addresses);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (reg_err)=
</span><br><span>         {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            err =3D (DWORD)reg_err;</span><br><span>             go=
to out;</span><br><span>         }</span><br><span>     }</span><br><span>@=
@ -3081,7 +3078,7 @@</span><br><span>     /* Set search domains, if any */<=
/span><br><span>     if (msg-&gt;search_domains[0])</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        err =3D SetDns=
SearchDomains(msg-&gt;iface=2Ename, msg-&gt;search_domains, &amp;gpol_list,=
 lists);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        err=
 =3D (DWORD)SetDnsSearchDomains(msg-&gt;iface=2Ename, msg-&gt;search_domain=
s, &amp;gpol_list, lists);</span><br><span>     }</span><br><span> </span><=
br><span>     ApplyDnsSettings(gpol_nrpt || gpol_list);</span><br><span>@@ =
-3389,7 +3386,7 @@</span><br><span>             switch (type)</span><br><sp=
an>             {</span><br><span>                 case address:</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                    DeleteAddres=
s(item-&gt;data);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  DeleteUnicastIpAddressEntry(item-&gt;data);</span><br><sp=
an>                     break;</span><br><span> </span><br><span>          =
       case route:</span><br><span>@@ -3799,7 +3796,7 @@</span><br><span>  =
   RPC_STATUS rpc_stat =3D UuidCreate(&amp;pipe_uuid);</span><br><span>    =
 if (rpc_stat !=3D RPC_S_OK)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ReturnError(pipe, rpc_stat, L&quot;=
UuidCreate&quot;, 1, &amp;exit_event);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        ReturnError(pipe, (DWORD)rpc_stat, L&quot;UuidCr=
eate&quot;, 1, &amp;exit_event);</span><br><span>         goto out;</span><=
br><span>     }</span><br><span> </span><br><span>@@ -3807,7 +3804,7 @@</sp=
an><br><span>     rpc_stat =3D UuidToStringW(&amp;pipe_uuid, &amp;pipe_uuid=
_str);</span><br><span>     if (rpc_stat !=3D RPC_S_OK)</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ReturnErro=
r(pipe, rpc_stat, L&quot;UuidToString&quot;, 1, &amp;exit_event);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        ReturnError(pipe, (DW=
ORD)rpc_stat, L&quot;UuidToString&quot;, 1, &amp;exit_event);</span><br><sp=
an>         goto out;</span><br><span>     }</span><br><span>     swprintf(=
ovpn_pipe_name, _countof(ovpn_pipe_name),</span><br></pre><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355?usp=3Demail">ch=
ange 2355</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I1f775940c13cf989cf804bf637d4a63c3fe5aaaf </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 2355 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Fran=
k Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>

</body></html>
--sNeXIK2JIuk=--


--===============1669880101206730333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1669880101206730333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1669880101206730333==--

