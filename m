Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC52606A32F
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 21:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JY4JK4Qq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=f4ijCaYY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=U/u6Fx8K;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=f9080mF+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gngPUlZsiIsF7ke+vFCrak75WI2BbbKJC3Y2xZEGfZo=; b=JY4JK4Qq0zlfnX5qam3Mhp9oaR
	w4Jom1ycZVwDSqYiB2yT8Qf5r9jFyCjmDuUTIwZRYnmxRvi0lR+HeTGpSU9eQLJwEnP/k5tizLfYU
	dKUqkgmuoGVjT0k5ZkhER9De8R+cwUfR26XFGJABwZNnjwUps7C6zTmGFdTh05lyEANQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNzwQ-000000005tC-0FBq;
	Mon, 02 Nov 2026 21:51:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNzwO-000000005sv-08Ax
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 21:51:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Lb+T3pocUHBRO9lgCgHL0HlQbuzzo5+X54v4LQtMfhs=; b=f4ijCaYYeZP4W+7r3FDSued2iS
 2XETdrCc8t6+I39Ttsa7w4J1B6kxGGqi+IUC8+JqIyAxRxtsHgQ0iaHE7wGNjWA+w5ErOMCa8/ZAS
 oRjH7zLublrbIUwuih6snDwEKaoX2Dw2x2NVrazo0zA1NyNouyEoYOKA0gRYXDlutnxA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Lb+T3pocUHBRO9lgCgHL0HlQbuzzo5+X54v4LQtMfhs=; b=U/u6Fx8KyXz0jwiW3BPOcrOfHV
 sO1W+42V3PDgVWJXyP+4/PzGxB9HRQIfW+igxJ+7m2NByWDl+VdslIokdYMKUf6dnZSnx3kp4M6wS
 sApNF5p7gGEYPVWw7rireVGwT4/yYOS1t5hwviuI26rbamdpXSTzRgE1cTR5LnRTtqTA=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNzwM-000000006B3-2jxO for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 21:51:43 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so31264645e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 13:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793656296; x=1794261096; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Lb+T3pocUHBRO9lgCgHL0HlQbuzzo5+X54v4LQtMfhs=;
 b=f9080mF+5x09afsUmmlED9ZUBlQtYcrYITKP28ndjaMxs72LpWwwk1QeeOvoIaDNYG
 hus9EYkj3QlcMBSwlvlAuqVqTsnE17DVEyMechQIWHjIS6p6rtvFUeknCx72sOdYh7du
 R5EnTQnY1vFAq7gwuvwrNYNZneoGSIRVIFFMAELO66kF1hiN+gUVVnsdh3jS9mDyF4ZJ
 6lKEo63RK7IjptLcLXzIiKKomFk2PqecA37UkItz4L9S5boFaj+VcnuOnp+9opBIVpny
 lcO3U4LyR0NSFiOv92zrC2pNWkt9gFlG9eUmEr20P5V6cSZb9s931ZLzroD5F1d+pzCh
 zxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793656296; x=1794261096;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Lb+T3pocUHBRO9lgCgHL0HlQbuzzo5+X54v4LQtMfhs=;
 b=V7xHuIDCy6dUVfIbqvmFLQT7Y+3iCXKA/McRuQgvcZq+Hho9CLKkj15JCdVVaDBzLT
 Az8vnEemalo3YgEmFdLHjgi+Y7MIbC5TeV/0/PKFdzIrznGie1hBLmkUhGiaSFel3MYB
 V/HWKwJboo0v2PJgmd85VBY86eL7XyRYvUX7HY955yTfqGwLe8RYnt5iTwxiPv2ZAN+h
 WFaquehUV4yxzqm2uJd/Po581HSt6Br5Vh7RELrceaovhkywnMM9w6L9n7UBygeo80Ko
 jnnw4SmrZBlItbTXSjieNW9rUqKF6i+KopVTZawMsz1Uv250kK1/MT4BXw/GZoMY1zY9
 6ygA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+WZbqbzzGbFD2yoj2Tvz1wUF94xkIUbnVazT6Fan+JAqkee/Sz7+EET2sB7nEvj9Xocu3EemCDSPN/R4T@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKpq4TAJ4S8T3k6EYfdEYDn7cLEKPS8m+WSmA3iMYIxf5JjzOUS
 P+nF6IQGoXwdW1AMoqoEZzUCHManhu3/4Jlh4eba8t3AjvCWfHa3oBjVzE/dWd6LBu8w8TzcTEY
 itl9JercOBoCdzxX0fFIgBNZQIaPhEaXg1tmWKmk3HDo5NBja6VWjLKN3N9jU3ifOiK7N
X-Gm-Gg: AYBFou0hdIP1DlOs0rvvHu2re7D7Bb5PigBJzhoGzvPhRNrSZW5FLwLC106mlJJSxAM
 nxzNSyo78e4KKEwd8ex7+f4qvNutZmUnUPmEzCGa2ZRT9f1N7JgeZF2adlnKsJ/vJ4El9VOnDSy
 /iKDDoreExRQArjpe67iV2vq8H6YMdIUq09ko9nWiGk35+me6UBG2ekV7hHDcaDXPhHznF8D85x
 LfSQ1sNuttN2LykM73PEIM0kp2/JdKTteWuLXNc4sKt51T9LFrGM9E1eWhcvpV8scebQUKb+dAk
 4+cbrdsgnZPAe2HIctzeZ+faAUgMXeulwIWCjM6GiayaAUIHyW7RmRvPSdKgDnaaAqAKNaf2La/
 0V4s28RuMBAdMro9nxTSopUkqMMNX+/KsPc8JgMpPHVRQbTBHzCf1CVEF4ltjH5armZ9ulrjyZX
 UUCUXdNw8yKf9GpFs6XXWkjfG1ZhkKgor5VQtoRwSS9TDIamK9fV4c53pD09DnXHwwR8b9me7K6
 e7AkF7n0bWl+EPvvzwJiTDiOd4+vA8EhdMDnG1FX3vjOsK+sMf+cgf9lE0mw2Se/4pxN+B844sH
 izpDCFspGbkJYR2Q1D7bRojGTLEGTN1zM/Zas8ITcTkvTIRrHnGUQvRgJhFTXAXonyWklReuguo
 TNrYJc5nOT2oKjVVdkXd/6BYwv/yZqWGiJsqVIepF/xuqQlarCcpfyeL4vkbFGwI4tH2qf/drtz
 q2KQ2kqtAjszZ4lA==
X-Received: by 2002:a05:600c:840e:b0:4a1:813f:2a60 with SMTP id
 5b1f17b1804b1-4ac17d168b1mr290915105e9.11.1793656295956; 
 Mon, 02 Nov 2026 13:51:35 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b79059sm22416046f8f.30.2026.11.02.13.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 13:51:35 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 21:51:35 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I70ebdadd660e41b40ed53f4238be6885f0a7bb8b
X-Gerrit-Change-Number: 2074
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2074?usp=email>
X-Gerrit-Commit: 24946176aed52c23c52c956df43fd052c232f652
In-Reply-To: <gerrit.1793450471000.I70ebdadd660e41b40ed53f4238be6885f0a7bb8b@gerrit.openvpn.net>
References: <gerrit.1793450471000.I70ebdadd660e41b40ed53f4238be6885f0a7bb8b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDUwNDcxMDAwLkk3MGViZGFkZDY2MGU0MWI0MGVkNTNmNDIzOGJlNjg4NWYwYTdiYjhiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <83f80f6500bee959d005b03d0d30da0d4e7b1802-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xNzwM-000000006B3-2jxO
Subject: [Openvpn-devel] [S] Change in openvpn[master]: port-share: do not
 write journal file through symlinks or hardlinks
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7501509332678726111=="
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MISSING_HEADERS,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7501509332678726111==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="49XrPGApiKE="; charset=UTF-8

--49XrPGApiKE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2074?usp=3Demail )

Change subject: port-share: do not write jo=
urnal file through symlinks or hardlinks
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

port-share: do not write journal file through =
symlinks or hardlinks

journal_add() creates <journal dir>/<local ip:port> =
with
O_CREAT | O_TRUNC and writes the remote client's address into it=2E
Th=
e name is predictable (the proxy connection's ephemeral local port)
and the=
 write is triggered by any TCP client sending non-OpenVPN data
to the share=
d port=2E Anyone who can create entries in the journal
directory can theref=
ore plant symlinks or hardlinks and have the
port-share process, which runs=
 as root unless --user is used, truncate
and overwrite an arbitrary file wi=
th the client address=2E

Create the journal file with O_EXCL | O_NOFOLLOW =
instead=2E Entries are
removed as soon as the proxied connection is closed,=
 so an existing
entry is either a leftover from a proxy process that exited=
 without
cleaning up, or something planted=2E Unlink it and retry the exclu=
sive
create once, which keeps the old behavior of replacing stale entries=
=2E

Also document that the journal directory must not be writable by other=

users=2E

Github: closes OpenVPN/openvpn#1124
Change-Id: I70ebdadd660e41b4=
0ed53f4238be6885f0a7bb8b
Signed-off-by: Naveed Khan <dxbnaveed=2Ek@gmail=2E=
com>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074
Message-Id: <20261102093834=2E29593=
-1-gert@greenie=2Emuc=2Ede>
URL: https://lore=2Ekernel=2Eorg/openvpn-devel/=
20261102093834=2E29593-1-gert@greenie=2Emuc=2Ede
Signed-off-by: Gert Doerin=
g <gert@greenie=2Emuc=2Ede>
---
M doc/man-sections/server-options=2Erst
M s=
rc/openvpn/ps=2Ec
2 files changed, 13 insertions(+), 1 deletion(-)




diff=
 --git a/doc/man-sections/server-options=2Erst b/doc/man-sections/server-op=
tions=2Erst
index 9dfa6bd=2E=2E7a09809 100644
--- a/doc/man-sections/server=
-options=2Erst
+++ b/doc/man-sections/server-options=2Erst
@@ -489,6 +489,1=
0 @@
   the origin of the connection=2E Each generated file will be automat=
ically
   deleted when the proxied connection is torn down=2E
 
+  The file=
s in ``dir`` are created and removed with the privileges of the
+  OpenVPN =
process, so ``dir`` must not be writable by any user other than
+  the one =
OpenVPN runs as=2E
+
   Not implemented on Windows=2E
 
 --push option
diff=
 --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec
index 03c6f48=2E=2Ef8cfe1c=
5 100644
--- a/src/openvpn/ps=2Ec
+++ b/src/openvpn/ps=2Ec
@@ -341,7 +341,1=
5 @@
         check_malloc_return(jfn);
         snprintf(jfn, fnlen, "%s/%=
s", journal_dir, t);
         dmsg(D_PS_PROXY_DEBUG, "PORT SHARE PROXY: cli=
ent origin %s -> %s", jfn, f);
-        int fd =3D platform_open(jfn, O_CRE=
AT | O_TRUNC | O_WRONLY, S_IRUSR | S_IWUSR | S_IRGRP);
+        /* never wr=
ite through a pre-existing symlink or hardlink */
+        const int flags =
=3D O_CREAT | O_EXCL | O_WRONLY | O_NOFOLLOW;
+        int fd =3D platform_=
open(jfn, flags, S_IRUSR | S_IWUSR | S_IRGRP);
+        if (fd =3D=3D -1 &&=
 errno =3D=3D EEXIST)
+        {
+            /* stale entry, e=2Eg=2E left=
 behind by a killed proxy process */
+            unlink(jfn);
+           =
 fd =3D platform_open(jfn, flags, S_IRUSR | S_IWUSR | S_IRGRP);
+        }
=
         if (fd !=3D -1)
         {
             ssize_t write_len =3D strl=
en(f);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Ge=
rrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I70ebdadd660e=
41b40ed53f4238be6885f0a7bb8b
Gerrit-Change-Number: 2074
Gerrit-PatchSet: 3
=
Gerrit-Owner: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru =
<razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>

--49XrPGApiKE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2074?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">port-share: do not write journal f=
ile through symlinks or hardlinks<br><br>journal_add() creates &lt;journal =
dir&gt;/&lt;local ip:port&gt; with<br>O_CREAT | O_TRUNC and writes the remo=
te client&#39;s address into it=2E<br>The name is predictable (the proxy co=
nnection&#39;s ephemeral local port)<br>and the write is triggered by any T=
CP client sending non-OpenVPN data<br>to the shared port=2E Anyone who can =
create entries in the journal<br>directory can therefore plant symlinks or =
hardlinks and have the<br>port-share process, which runs as root unless --u=
ser is used, truncate<br>and overwrite an arbitrary file with the client ad=
dress=2E<br><br>Create the journal file with O_EXCL | O_NOFOLLOW instead=2E=
 Entries are<br>removed as soon as the proxied connection is closed, so an =
existing<br>entry is either a leftover from a proxy process that exited wit=
hout<br>cleaning up, or something planted=2E Unlink it and retry the exclus=
ive<br>create once, which keeps the old behavior of replacing stale entries=
=2E<br><br>Also document that the journal directory must not be writable by=
 other<br>users=2E<br><br>Github: closes OpenVPN/openvpn#1124<br>Change-Id:=
 I70ebdadd660e41b40ed53f4238be6885f0a7bb8b<br>Signed-off-by: Naveed Khan &l=
t;dxbnaveed=2Ek@gmail=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
074<br>Message-Id: &lt;20261102093834=2E29593-1-gert@greenie=2Emuc=2Ede&gt;=
<br>URL: https://lore=2Ekernel=2Eorg/openvpn-devel/20261102093834=2E29593-1=
-gert@greenie=2Emuc=2Ede<br>Signed-off-by: Gert Doering &lt;gert@greenie=2E=
muc=2Ede&gt;<br>---<br>M doc/man-sections/server-options=2Erst<br>M src/ope=
nvpn/ps=2Ec<br>2 files changed, 13 insertions(+), 1 deletion(-)<br><br></pr=
e>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/doc/man-sections/server-options=2Erst b/doc/man-sections=
/server-options=2Erst</span><br><span>index 9dfa6bd=2E=2E7a09809 100644</sp=
an><br><span>--- a/doc/man-sections/server-options=2Erst</span><br><span>++=
+ b/doc/man-sections/server-options=2Erst</span><br><span>@@ -489,6 +489,10=
 @@</span><br><span>   the origin of the connection=2E Each generated file =
will be automatically</span><br><span>   deleted when the proxied connectio=
n is torn down=2E</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  The files in ``dir`` are created and removed with the pri=
vileges of the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Ope=
nVPN process, so ``dir`` must not be writable by any user other than</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  the one OpenVPN runs as=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
>   Not implemented on Windows=2E</span><br><span> </span><br><span> --push=
 option</span><br><span>diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2E=
c</span><br><span>index 03c6f48=2E=2Ef8cfe1c5 100644</span><br><span>--- a/=
src/openvpn/ps=2Ec</span><br><span>+++ b/src/openvpn/ps=2Ec</span><br><span=
>@@ -341,7 +341,15 @@</span><br><span>         check_malloc_return(jfn);</s=
pan><br><span>         snprintf(jfn, fnlen, &quot;%s/%s&quot;, journal_dir,=
 t);</span><br><span>         dmsg(D_PS_PROXY_DEBUG, &quot;PORT SHARE PROXY=
: client origin %s -&gt; %s&quot;, jfn, f);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        int fd =3D platform_open(jfn, O_CREAT | O_TRU=
NC | O_WRONLY, S_IRUSR | S_IWUSR | S_IRGRP);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        /* never write through a pre-existing syml=
ink or hardlink */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       const int flags =3D O_CREAT | O_EXCL | O_WRONLY | O_NOFOLLOW;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        int fd =3D platfor=
m_open(jfn, flags, S_IRUSR | S_IWUSR | S_IRGRP);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (fd =3D=3D -1 &amp;&amp; errno =3D=
=3D EEXIST)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* sta=
le entry, e=2Eg=2E left behind by a killed proxy process */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            unlink(jfn);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            fd =3D platform_op=
en(jfn, flags, S_IRUSR | S_IWUSR | S_IRGRP);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span>         if (fd !=3D -1)=
</span><br><span>         {</span><br><span>             ssize_t write_len =
=3D strlen(f);</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2074?usp=3Demail">change 2074</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-=
Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master =
</div>
<div style=3D"display:none"> Gerrit-Change-Id: I70ebdadd660e41b40ed5=
3f4238be6885f0a7bb8b </div>
<div style=3D"display:none"> Gerrit-Change-Numb=
er: 2074 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div=
 style=3D"display:none"> Gerrit-Owner: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--49XrPGApiKE=--


--===============7501509332678726111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7501509332678726111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7501509332678726111==--

