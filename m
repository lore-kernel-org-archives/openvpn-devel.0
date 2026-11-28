Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10399606A323
	for <openvpn-devel@archiver.kernel.org>; Sat, 28 Nov 2026 16:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fb0/udp0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JZuij9iz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=acpE0ZYT;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YkQ9rogp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=fg9/H/PZz5ByNw4W8xVmlbtqkwfQjOYEcTfIrOe8g5A=; b=fb0/udp0GYJ4enbPUjCjKU8qHO
	+osqVM3B9OYrUNXEgkgdA5+L3jpMRawpWs5TLTMpwwtuzNnheX0X5qyf4Y0iE9TiSAx+cH1CiABVE
	aC/lq+T5AUWDjjzR3OhUxaGS8tLS1ALBlc/DolV+w9JOnfqay10is3h5Qb69ijLtUH8w=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xXLJ6-0000000019w-1Gfd;
	Sat, 28 Nov 2026 16:29:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xXLJ5-0000000019q-0xCF
 for openvpn-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 16:29:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1ykLK8QkjXty+dj7/4ylsNKeO/HI3IDsTCcS+XtBtYQ=; b=JZuij9izXiL1nO0nBpNC1U7Oym
 dm6w3gHRgPQ0+FAnk8OgCwV7N0UMk5js/2cthiXtHuSagk7kDDvXzN7OCeU6u4uIZXejF9LRQqY3R
 LUvbOY2aIJxJQhToszLVXArW0EpMBgaVv1ES0ZA/eLVXxg0cc6iBPWS/kkXH/T3oHiCU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1ykLK8QkjXty+dj7/4ylsNKeO/HI3IDsTCcS+XtBtYQ=; b=acpE0ZYT2bIKhYhC6KCWvskZhG
 cbpl/XPuk1NWoQ5GN96ns5ZZK14BlTOM/288/xTsb+jPw5sYHUI4VwpmArtzwQLv5K6pLB5z2tJKd
 EGhWozPEw1Rr8xo/N+388h7e7sEO5dj6h5Hy1q/gBP7bCOJgASAQC2oGR2PeLA4eEZc4=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xXLJ0-000000006zS-0ysi for openvpn-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 16:29:47 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso69524205e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 28 Nov 2026 08:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795883376; x=1796488176; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1ykLK8QkjXty+dj7/4ylsNKeO/HI3IDsTCcS+XtBtYQ=;
 b=YkQ9rogpC6ZAtxjUfYoTJem1cqdea8+ngHvGaoQEJmV9JB4PXIuP8lvWj9MuPXiJuq
 fqUDt57mdCIqGaUuZQW/05b8v9MkGJFkXbjMLzI8+QTMOAXB/iwEiXvXlFb1u5aqDoJ1
 w8pGtkSYbTewtcCcCHBMo2vmeZswFwDHo5SbIAk+2C734HnNWepcDzSf1RrV4K4w//yE
 Zd9i2+E9rcL8fywd1/9M++y0snztk5JM4xiwBO0ZxGJcdnfnVvOeoiqWLHv6p5zMDyTm
 8s6xB1fBFqzP9nmpfO1PRqDe185Z3tbgzYwH11ZJIXUb9dFfxKPTNRnJFYc6tARlM0Hn
 AFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795883376; x=1796488176;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1ykLK8QkjXty+dj7/4ylsNKeO/HI3IDsTCcS+XtBtYQ=;
 b=rk+mi9Xkr/xHGQ4T17wy6YSHYZQRGMsPPuzTcU7BIW18huErIkTw9CnDSypfylDwZ3
 9RhZ5VKqSbgGA3HTVOtvP1q+x03TXTHkksPam6qBUuJk/L3eI9zdLPMGK4oxJtpl8I/7
 fO+51b++QchP+vtzmlqH70Z5LLdlfI91mqLbLFRVnmrj+/DhLXIwbcCggAgO/hbbZKUV
 0mPdXZNuon8KH9I8PWGSIbcvUrmuChuQGeI7IJSUUKayFaK8xgWHgIaFC7hafYo+nsnX
 dR1Nv0hSTSp32fT6WYoWChlzMaRGKgcrZZhyP8MLzaRuTPkl1gcphJGVdB40WR8JXObh
 kGQA==
X-Gm-Message-State: APuU4Z94Rf1XAffnJISDVE9cA8i1pOY3lqZPpiC3MZ4gpHi1ZDTj/JeH
 J4Rrbl7Z5UWks/wKCAl1MSDeDbtvtOIhB/wYF3ZPDsHhXlL9Y4z8TH9wBv9rJw4aQAJvDN+B/dn
 PsRZA2wSNV0LN784LakClIdEsodZVRGa0WZMg5Xa/1v9YhBlJZRhvXCHhW1inBwjD/DJp
X-Gm-Gg: AZFdTZcW66pfJHpH0SSAPgC3JJ63KG6O8UaITAEFoQP0bNygJFTq4GusBjRJhj53xHn
 spGlqxXVeCO/8Yk3gSgxgjbti0y9vDGLSR1Z19Hd/Kz6DpdAqRYZmInF6YjmaSXgnoWB/oA+Dyh
 ZdmVgs74aggKp9dGZlrkOLYUxE5aGNOX/SgjUsbqoOfPquhbxx6j1aszjubrX8qSOxq5n4W+fHE
 +N4mHHpOZ8QqvFMser57nSemt3pSdDwB3MF0WRmZfW/Co7TbTXCzB5cElH6UIg46jnYnkHpczdh
 5cb2lN+K8xeRzgJEVp3vnnx8Wp8ttTdmCDWa1bm1+0Rg9UV6GQUKjhHZZ0ImbYphI6JIwsyyCWr
 xRug6g7hb6STmll0CAT3oRhSgW7Frloy8YVwk1CJVd++vl2XWf4WoPDeqBKctsks83P5699X4Uj
 zJqvcuLUFZfV74MxND393J9xF2p+EVlT5t8SWx68x/sJC5KyC1HYrFwo9Ihio1xu5zL1BZ20Elb
 hhlLOvdiQmtbVy8XTC4Ou1VDA2+DNKg9yO/v+lWkyZfo4JD8G3403+p516Ckz3wb2M0TbX+psv6
 FwOAiuS1NGGk+TYnTLWw8G7SLTFUtbgf3/z7TewAJ2wXsFdx6maaeEXIivBBI0JFdE2l/y/C1sK
 xYp9iRjbvzcSamH1E2x2PJFHVs4vIz3Cry+LM61QSRBAvhBCt39C/lOp7h5JQg4W1H38vlWnE5s
 gg/cCXFlv/rMUmjhU=
X-Received: by 2002:a05:600c:a085:b0:4a2:526b:d410 with SMTP id
 5b1f17b1804b1-4bb8881092bmr575860105e9.13.1795883375021; 
 Sat, 28 Nov 2026 08:29:35 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884865a2sm819611855e9.3.2026.11.28.08.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 08:29:34 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 28 Nov 2026 16:29:34 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I08a26d39f0e7c2fa910bcba574b34d29c8bb8aed
X-Gerrit-Change-Number: 2365
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2365?usp=email>
X-Gerrit-Commit: 71b90a473af9d87665b0b30d9e11c6c67210e671
References: <gerrit.1795883372000.I08a26d39f0e7c2fa910bcba574b34d29c8bb8aed@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1ODgzMzcyMDAwLkkwOGEyNmQzOWYwZTdjMmZhOTEwYmNiYTU3NGIzNGQyOWM4YmI4YWVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <12d140329f0eec007a0b074c9312b13c3ff2ac21-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xXLJ0-000000006zS-0ysi
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Remove the obsolete
 debug/ valgrind helpers
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3034116182061378108=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3034116182061378108==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="E8IYxRVWYog="; charset=UTF-8

--E8IYxRVWYog=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2365?usp=3Demail

to review the following change=2E
=


Change subject: Remove the obsolete debug/ valgrind helpers
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove the obsolete debug=
/ valgrind helpers

doval has been broken since commit 34cb9132 ("build: st=
andard directory
layout") moved it into debug/: it looks up valgrind-suppre=
ss and the
openvpn binary relative to debug/, where neither exists=2E
valgr=
ind-suppress was last updated in commit 3710e66e ("updated
valgrind-suppres=
s for OpenSSL 0=2E9=2E8") and only matches glibc 2=2E5
objects=2E dovalns i=
s a generic valgrind wrapper=2E

Drop the directory, its EXTRA_DIST entry a=
nd the memdbg=2Eh references
to the suppressions file=2E

Change-Id: I08a26=
d39f0e7c2fa910bcba574b34d29c8bb8aed
Signed-off-by: Razvan Cojocaru <razvanc=
@mailbox=2Eorg>
---
M Makefile=2Eam
D debug/doval
D debug/dovalns
D debug/v=
algrind-suppress
M src/openvpn/memdbg=2Eh
5 files changed, 3 insertions(+),=
 1,197 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/65/2365/1

diff --git a/Makefile=2Eam b/Makefile=2Eam
index =
d3910ed=2E=2Ea8afa8e 100644
--- a/Makefile=2Eam
+++ b/Makefile=2Eam
@@ -42,=
7 +42,6 @@
 
 EXTRA_DIST =3D \
 	contrib \
-	debug \
 	ltrc=2Einc \
 	CMake=
Lists=2Etxt \
 	CMakePresets=2Ejson \
diff --git a/debug/doval b/debug/dova=
l
deleted file mode 100755
index e215510=2E=2E0000000
--- a/debug/doval
+++=
 /dev/null
@@ -1,4 +0,0 @@
-#!/bin/bash
-PROGDIR=3D`dirname $0`
-unset LD_L=
IBRARY_PATH
-valgrind --tool=3Dmemcheck --error-limit=3Dno --suppressions=
=3D$PROGDIR/debug/valgrind-suppress --gen-suppressions=3Dall --leak-check=
=3Dfull --show-reachable=3Dyes --num-callers=3D32 $PROGDIR/openvpn "$@"
dif=
f --git a/debug/dovalns b/debug/dovalns
deleted file mode 100755
index 482a=
e3f=2E=2E0000000
--- a/debug/dovalns
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/=
bash
-valgrind --tool=3Dmemcheck --error-limit=3Dno --gen-suppressions=3Dal=
l --leak-check=3Dfull --show-reachable=3Dyes --num-callers=3D32 $*
diff --g=
it a/debug/valgrind-suppress b/debug/valgrind-suppress
deleted file mode 10=
0644
index d7de12f=2E=2E0000000
--- a/debug/valgrind-suppress
+++ /dev/null=

@@ -1,1182 +0,0 @@
-{
-   <insert a suppression name here>
-   Memcheck:Ad=
dr8
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=
=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/li=
b/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   o=
bj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/libc-2=2E5=2E=
so
-   obj:/lib/ld-2=2E5=2Eso
-   fun:__libc_dlopen_mode
-   fun:__nss_look=
up_function
-   obj:/lib/libc-2=2E5=2Eso
-   fun:getgrnam_r
-   fun:getgrna=
m
-   fun:get_group
-   fun:do_init_first_time
-   fun:init_instance
-   fu=
n:init_instance_handle_signals
-   fun:tunnel_server_tcp
-   fun:main
-}
-
=
-{
-   <insert a suppression name here>
-   Memcheck:Addr8
-   obj:/lib/ld-=
2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/l=
ib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   =
obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Es=
o
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/libc-2=2E5=2Eso
-   obj:/lib/ld-2=
=2E5=2Eso
-   fun:__libc_dlopen_mode
-   fun:__nss_lookup_function
-   obj:=
/lib/libc-2=2E5=2Eso
-   fun:getgrnam_r
-   fun:getgrnam
-   fun:get_group
=
-   fun:do_init_first_time
-   fun:init_instance
-   fun:init_instance_hand=
le_signals
-   fun:tunnel_server_udp
-   fun:main
-}
-
-{
-   <insert a sup=
pression name here>
-   Memcheck:Addr8
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/=
lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-  =
 obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2E=
so
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=
=2E5=2Eso
-   obj:/lib/libc-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   fun:_=
_libc_dlopen_mode
-   fun:__nss_lookup_function
-   obj:/lib/libc-2=2E5=2Es=
o
-   fun:getpwnam_r
-   fun:getpwnam
-   fun:get_user
-   fun:management_o=
pen
-   fun:open_management
-   fun:main
-}
-
-{
-   <insert a suppression =
name here>
-   Memcheck:Addr8
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=
=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/li=
b/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   o=
bj:/lib/libc-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   fun:__libc_dlopen_mo=
de
-   fun:__nss_lookup_function
-   fun:__nss_next
-   fun:gethostbyname_r=

-   fun:gethostbyname
-   fun:getaddr
-   fun:resolve_remote
-   fun:link_=
socket_init_phase1
-   fun:init_instance
-   fun:init_instance_handle_signa=
ls
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:A=
ddr8
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-=
2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/l=
ib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/libc-2=2E5=2Eso
- =
  obj:/lib/ld-2=2E5=2Eso
-   fun:__libc_dlopen_mode
-   fun:__nss_lookup_fu=
nction
-   obj:/lib/libc-2=2E5=2Eso
-   fun:gethostbyname_r
-   fun:gethost=
byname
-   fun:getaddr
-   fun:resolve_remote
-   fun:link_socket_init_phas=
e1
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:main
=
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Addr8
-   obj:/li=
b/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   o=
bj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso=

-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/libdl-2=2E5=2Eso
-   obj:/lib/ld-2=
=2E5=2Eso
-   obj:/lib/libdl-2=2E5=2Eso
-   fun:dlopen
-   fun:plugin_list_=
init
-   fun:init_plugins
-   fun:main
-}
-
-{
-   <insert a suppression na=
me here>
-   Memcheck:Addr8
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E=
5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/l=
d-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/libdl-2=2E5=2Eso
-   o=
bj:/lib/ld-2=2E5=2Eso
-   obj:/lib/libdl-2=2E5=2Eso
-   fun:dlopen
-   fun:=
plugin_list_init
-   fun:init_plugins
-   fun:main
-}
-
-{
-   <insert a su=
ppression name here>
-   Memcheck:Addr8
-   obj:/lib/ld-2=2E5=2Eso
-   obj:=
/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
- =
  obj:/lib/libc-2=2E5=2Eso
-   obj:/lib/libdl-2=2E5=2Eso
-   obj:/lib/ld-2=
=2E5=2Eso
-   obj:/lib/libdl-2=2E5=2Eso
-   fun:dlsym
-   fun:libdl_resolve=
_symbol
-   fun:plugin_list_init
-   fun:init_plugins
-   fun:main
-}
-
-{
=
-   <insert a suppression name here>
-   Memcheck:Addr8
-   obj:/lib/ld-2=
=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/li=
b/ld-2=2E5=2Eso
-   obj:/lib/libdl-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
- =
  obj:/lib/libdl-2=2E5=2Eso
-   fun:dlopen
-   fun:plugin_list_init
-   fun=
:init_plugins
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-  =
 Memcheck:Addr8
-   obj:/lib/ld-2=2E7=2Eso
-   obj:/lib/ld-2=2E7=2Eso
-   o=
bj:/lib/ld-2=2E7=2Eso
-   obj:/lib/ld-2=2E7=2Eso
-   obj:/lib/ld-2=2E7=2Eso=

-   obj:/lib/ld-2=2E7=2Eso
-   obj:/lib/ld-2=2E7=2Eso
-   obj:/lib/ld-2=2E=
7=2Eso
-   obj:/lib/ld-2=2E7=2Eso
-   obj:/lib/ld-2=2E7=2Eso
-   obj:/lib/l=
ibc-2=2E7=2Eso
-   obj:/lib/ld-2=2E7=2Eso
-   fun:__libc_dlopen_mode
-   fu=
n:__nss_lookup_function
-   obj:/lib/libc-2=2E7=2Eso
-   fun:getgrnam_r
-  =
 fun:getgrnam
-   fun:get_group
-   fun:do_init_first_time
-   fun:init_ins=
tance
-   fun:init_instance_handle_signals
-   fun:tunnel_server_tcp
-   fu=
n:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Addr8
-   =
obj:/lib/ld-2=2E7=2Eso
-   obj:/lib/ld-2=2E7=2Eso
-   obj:/lib/ld-2=2E7=2Es=
o
-   obj:/lib/ld-2=2E7=2Eso
-   obj:/lib/ld-2=2E7=2Eso
-   obj:/lib/ld-2=
=2E7=2Eso
-   obj:/lib/ld-2=2E7=2Eso
-   obj:/lib/ld-2=2E7=2Eso
-   obj:/li=
b/ld-2=2E7=2Eso
-   obj:/lib/ld-2=2E7=2Eso
-   obj:/lib/libc-2=2E7=2Eso
-  =
 obj:/lib/ld-2=2E7=2Eso
-   fun:__libc_dlopen_mode
-   fun:__nss_lookup_fun=
ction
-   obj:/lib/libc-2=2E7=2Eso
-   fun:getgrnam_r
-   fun:getgrnam
-   =
fun:get_group
-   fun:do_init_first_time
-   fun:init_instance
-   fun:init=
_instance_handle_signals
-   fun:tunnel_server_udp
-   fun:main
-}
-
-{
-  =
 <insert a suppression name here>
-   Memcheck:Addr8
-   obj:/lib/ld-2=2E7=
=2Eso
-   obj:/lib/ld-2=2E7=2Eso
-   obj:/lib/ld-2=2E7=2Eso
-   obj:/lib/ld=
-2=2E7=2Eso
-   obj:/lib/ld-2=2E7=2Eso
-   obj:/lib/ld-2=2E7=2Eso
-   obj:/=
lib/ld-2=2E7=2Eso
-   obj:/lib/ld-2=2E7=2Eso
-   obj:/lib/ld-2=2E7=2Eso
-  =
 obj:/lib/ld-2=2E7=2Eso
-   obj:/lib/libc-2=2E7=2Eso
-   obj:/lib/ld-2=2E7=
=2Eso
-   fun:__libc_dlopen_mode
-   fun:__nss_lookup_function
-   obj:/lib=
/libc-2=2E7=2Eso
-   fun:getgrnam_r
-   fun:getgrnam
-   fun:get_group
-   =
fun:management_open
-   fun:open_management
-   fun:main
-}
-
-{
-   <inser=
t a suppression name here>
-   Memcheck:Addr8
-   obj:/lib/ld-2=2E7=2Eso
- =
  obj:/lib/ld-2=2E7=2Eso
-   obj:/lib/ld-2=2E7=2Eso
-   obj:/lib/ld-2=2E7=
=2Eso
-   obj:/lib/ld-2=2E7=2Eso
-   obj:/lib/ld-2=2E7=2Eso
-   obj:/lib/ld=
-2=2E7=2Eso
-   obj:/lib/ld-2=2E7=2Eso
-   obj:/lib/ld-2=2E7=2Eso
-   obj:/=
lib/ld-2=2E7=2Eso
-   obj:/lib/libc-2=2E7=2Eso
-   obj:/lib/ld-2=2E7=2Eso
-=
   fun:__libc_dlopen_mode
-   fun:__nss_lookup_function
-   obj:/lib/libc-2=
=2E7=2Eso
-   fun:getpwnam_r
-   fun:getpwnam
-   fun:get_user
-   fun:mana=
gement_open
-   fun:open_management
-   fun:main
-}
-
-{
-   <insert a supp=
ression name here>
-   Memcheck:Cond
-   fun:BN_div
-   fun:BN_MONT_CTX_set=

-   fun:BN_MONT_CTX_set_locked
-   obj:/usr/lib/libcrypto=2Eso=2E0=2E9=2E8=

-   fun:RSA_verify
-   fun:EVP_VerifyFinal
-   fun:ASN1_item_verify
-   ob=
j:/usr/lib/libcrypto=2Eso=2E0=2E9=2E8
-   fun:X509_verify_cert
-   fun:ssl_=
verify_cert_chain
-   fun:ssl3_get_client_certificate
-   fun:ssl3_accept
-=
   fun:ssl3_read_bytes
-   fun:ssl3_read
-   obj:/usr/lib/libssl=2Eso=2E0=
=2E9=2E8
-   fun:BIO_read
-   fun:bio_read
-   fun:tls_process
-   fun:tls_=
multi_process
-   fun:check_tls_dowork
-   fun:pre_select
-   fun:multi_pro=
cess_post
-   fun:multi_process_incoming_link
-   fun:multi_tcp_action
-}
-=

-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   fun:BN_div
-=
   fun:BN_MONT_CTX_set
-   fun:BN_MONT_CTX_set_locked
-   obj:/usr/lib/libc=
rypto=2Eso=2E0=2E9=2E8
-   fun:ssl3_ctx_ctrl
-   fun:init_ssl
-   fun:init_=
instance
-   fun:init_instance_handle_signals
-   fun:tunnel_server_tcp
-  =
 fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
- =
  fun:BN_div
-   fun:BN_MONT_CTX_set
-   fun:BN_MONT_CTX_set_locked
-   obj=
:/usr/lib/libcrypto=2Eso=2E0=2E9=2E8
-   fun:ssl3_ctx_ctrl
-   fun:init_ssl=

-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:tunnel_=
server_udp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Me=
mcheck:Cond
-   fun:BN_div
-   fun:BN_MONT_CTX_set
-   fun:BN_MONT_CTX_set_=
locked
-   obj:/usr/lib/libcrypto=2Eso=2E0=2E9=2E8
-   obj:/usr/lib/libcryp=
to=2Eso=2E0=2E9=2E8
-   fun:RSA_sign
-   fun:ssl3_send_server_key_exchange
=
-   fun:ssl3_accept
-   fun:ssl3_read_bytes
-   fun:ssl3_read
-   obj:/usr/=
lib/libssl=2Eso=2E0=2E9=2E8
-   fun:BIO_read
-   fun:bio_read
-   fun:tls_p=
rocess
-   fun:tls_multi_process
-   fun:check_tls_dowork
-   fun:pre_selec=
t
-   fun:multi_process_post
-   fun:multi_process_incoming_link
-   fun:mu=
lti_tcp_action
-   fun:tunnel_server_tcp
-   fun:main
-}
-
-{
-   <insert a=
 suppression name here>
-   Memcheck:Cond
-   fun:BN_div
-   fun:BN_MONT_CT=
X_set
-   fun:BN_mod_exp_mont
-   fun:BN_BLINDING_create_param
-   fun:RSA_=
setup_blinding
-   obj:/usr/lib/libcrypto=2Eso=2E0=2E9=2E8
-   obj:/usr/lib=
/libcrypto=2Eso=2E0=2E9=2E8
-   fun:RSA_sign
-   fun:ssl3_send_server_key_e=
xchange
-   fun:ssl3_accept
-   fun:ssl3_read_bytes
-   fun:ssl3_read
-   o=
bj:/usr/lib/libssl=2Eso=2E0=2E9=2E8
-   fun:BIO_read
-   fun:bio_read
-   f=
un:tls_process
-   fun:tls_multi_process
-   fun:check_tls_dowork
-   fun:p=
re_select
-   fun:multi_process_post
-   fun:multi_process_incoming_link
- =
  fun:multi_tcp_action
-   fun:tunnel_server_tcp
-   fun:main
-}
-
-{
-   <=
insert a suppression name here>
-   Memcheck:Cond
-   fun:BN_div
-   fun:BN=
_nnmod
-   fun:BN_mod_inverse
-   fun:BN_MONT_CTX_set
-   fun:BN_MONT_CTX_s=
et_locked
-   obj:/usr/lib/libcrypto=2Eso=2E0=2E9=2E8
-   fun:ssl3_ctx_ctrl=

-   fun:init_ssl
-   fun:init_instance
-   fun:init_instance_handle_signal=
s
-   fun:tunnel_server_tcp
-   fun:main
-}
-
-{
-   <insert a suppression =
name here>
-   Memcheck:Cond
-   fun:BN_div
-   fun:BN_nnmod
-   fun:BN_mod=
_inverse
-   fun:BN_MONT_CTX_set
-   fun:BN_MONT_CTX_set_locked
-   obj:/us=
r/lib/libcrypto=2Eso=2E0=2E9=2E8
-   fun:ssl3_ctx_ctrl
-   fun:init_ssl
-  =
 fun:init_instance
-   fun:init_instance_handle_signals
-   fun:tunnel_serv=
er_udp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memche=
ck:Cond
-   fun:BN_mod_inverse
-   fun:BN_MONT_CTX_set
-   fun:BN_MONT_CTX_=
set_locked
-   obj:/usr/lib/libcrypto=2Eso=2E0=2E9=2E8
-   fun:RSA_verify
-=
   fun:EVP_VerifyFinal
-   fun:ASN1_item_verify
-   obj:/usr/lib/libcrypto=
=2Eso=2E0=2E9=2E8
-   fun:X509_verify_cert
-   fun:ssl_verify_cert_chain
- =
  fun:ssl3_get_client_certificate
-   fun:ssl3_accept
-   fun:ssl3_read_byt=
es
-   fun:ssl3_read
-   obj:/usr/lib/libssl=2Eso=2E0=2E9=2E8
-   fun:BIO_r=
ead
-   fun:bio_read
-   fun:tls_process
-   fun:tls_multi_process
-   fun:=
check_tls_dowork
-   fun:pre_select
-   fun:multi_process_post
-   fun:mult=
i_process_incoming_link
-   fun:multi_tcp_action
-}
-
-{
-   <insert a supp=
ression name here>
-   Memcheck:Cond
-   fun:BN_mod_inverse
-   fun:BN_MONT=
_CTX_set
-   fun:BN_MONT_CTX_set_locked
-   obj:/usr/lib/libcrypto=2Eso=2E0=
=2E9=2E8
-   fun:ssl3_ctx_ctrl
-   fun:init_ssl
-   fun:init_instance
-   f=
un:init_instance_handle_signals
-   fun:tunnel_server_tcp
-   fun:main
-}
-=

-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   fun:BN_mod_i=
nverse
-   fun:BN_MONT_CTX_set
-   fun:BN_MONT_CTX_set_locked
-   obj:/usr/=
lib/libcrypto=2Eso=2E0=2E9=2E8
-   fun:ssl3_ctx_ctrl
-   fun:init_ssl
-   f=
un:init_instance
-   fun:init_instance_handle_signals
-   fun:tunnel_server=
_udp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck=
:Cond
-   fun:BN_mod_inverse
-   fun:BN_MONT_CTX_set
-   fun:BN_MONT_CTX_se=
t_locked
-   obj:/usr/lib/libcrypto=2Eso=2E0=2E9=2E8
-   obj:/usr/lib/libcr=
ypto=2Eso=2E0=2E9=2E8
-   fun:RSA_sign
-   fun:ssl3_send_server_key_exchang=
e
-   fun:ssl3_accept
-   fun:ssl3_read_bytes
-   fun:ssl3_read
-   obj:/us=
r/lib/libssl=2Eso=2E0=2E9=2E8
-   fun:BIO_read
-   fun:bio_read
-   fun:tls=
_process
-   fun:tls_multi_process
-   fun:check_tls_dowork
-   fun:pre_sel=
ect
-   fun:multi_process_post
-   fun:multi_process_incoming_link
-   fun:=
multi_tcp_action
-   fun:tunnel_server_tcp
-   fun:main
-}
-
-{
-   <insert=
 a suppression name here>
-   Memcheck:Cond
-   fun:BN_mod_inverse
-   fun:=
BN_MONT_CTX_set
-   fun:BN_mod_exp_mont
-   fun:BN_BLINDING_create_param
- =
  fun:RSA_setup_blinding
-   obj:/usr/lib/libcrypto=2Eso=2E0=2E9=2E8
-   ob=
j:/usr/lib/libcrypto=2Eso=2E0=2E9=2E8
-   fun:RSA_sign
-   fun:ssl3_send_se=
rver_key_exchange
-   fun:ssl3_accept
-   fun:ssl3_read_bytes
-   fun:ssl3_=
read
-   obj:/usr/lib/libssl=2Eso=2E0=2E9=2E8
-   fun:BIO_read
-   fun:bio_=
read
-   fun:tls_process
-   fun:tls_multi_process
-   fun:check_tls_dowork=

-   fun:pre_select
-   fun:multi_process_post
-   fun:multi_process_incomi=
ng_link
-   fun:multi_tcp_action
-   fun:tunnel_server_tcp
-   fun:main
-}
=
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   obj:/lib/ld=
-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/=
lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:*
-   obj:*
-   obj:*
=
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   obj:/lib=
/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   ob=
j:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
=
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/libc-2=2E5=2Eso
-   obj:/lib/ld-2=
=2E5=2Eso
-   fun:__libc_dlopen_mode
-   fun:__nss_lookup_function
-   fun:=
__nss_next
-   fun:gethostbyname_r
-   fun:gethostbyname
-   fun:getaddr
- =
  fun:resolve_remote
-   fun:link_socket_init_phase1
-   fun:init_instance
=
-   fun:init_instance_handle_signals
-   fun:main
-}
-
-{
-   <insert a sup=
pression name here>
-   Memcheck:Cond
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/l=
ib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   =
obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Es=
o
-   obj:/lib/libc-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   fun:__libc_dl=
open_mode
-   fun:__nss_lookup_function
-   obj:/lib/libc-2=2E5=2Eso
-   fu=
n:getgrnam_r
-   fun:getgrnam
-   fun:get_group
-   fun:do_init_first_time
=
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:tunnel_s=
erver_tcp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Mem=
check:Cond
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/l=
ib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   =
obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/libc-2=2E5=
=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   fun:__libc_dlopen_mode
-   fun:__nss_l=
ookup_function
-   obj:/lib/libc-2=2E5=2Eso
-   fun:gethostbyname_r
-   fun=
:gethostbyname
-   fun:getaddr
-   fun:resolve_remote
-   fun:link_socket_i=
nit_phase1
-   fun:init_instance
-   fun:init_instance_handle_signals
-   f=
un:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   =
obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Es=
o
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/libc-2=
=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   fun:__libc_dlopen_mode
-   fun:__n=
ss_lookup_function
-   fun:__nss_next
-   fun:gethostbyname_r
-   fun:getho=
stbyname
-   fun:getaddr
-   fun:resolve_remote
-   fun:link_socket_init_ph=
ase1
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:mai=
n
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   obj:/l=
ib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   =
obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/libc-2=2E5=
=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   fun:__libc_dlopen_mode
-   fun:__nss_l=
ookup_function
-   obj:/lib/libc-2=2E5=2Eso
-   fun:getgrnam_r
-   fun:getg=
rnam
-   fun:get_group
-   fun:do_init_first_time
-   fun:init_instance
-  =
 fun:init_instance_handle_signals
-   fun:tunnel_server_tcp
-   fun:main
-}=

-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   obj:/lib/l=
d-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:=
/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/libc-2=2E5=2Eso
=
-   obj:/lib/ld-2=2E5=2Eso
-   fun:__libc_dlopen_mode
-   fun:__nss_lookup_=
function
-   obj:/lib/libc-2=2E5=2Eso
-   fun:gethostbyname_r
-   fun:getho=
stbyname
-   fun:getaddr
-   fun:resolve_remote
-   fun:link_socket_init_ph=
ase1
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:mai=
n
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   obj:/l=
ib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   =
obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/libc-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=
=2Eso
-   fun:__libc_dlopen_mode
-   fun:__nss_lookup_function
-   fun:__ns=
s_next
-   fun:gethostbyname_r
-   fun:gethostbyname
-   fun:getaddr
-   fu=
n:resolve_remote
-   fun:link_socket_init_phase1
-   fun:init_instance
-   =
fun:init_instance_handle_signals
-   fun:main
-}
-
-{
-   <insert a suppres=
sion name here>
-   Memcheck:Cond
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/l=
d-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:=
/lib/libc-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   fun:__libc_dlopen_mode
=
-   fun:__nss_lookup_function
-   obj:/lib/libc-2=2E5=2Eso
-   fun:getgrnam=
_r
-   fun:getgrnam
-   fun:get_group
-   fun:do_init_first_time
-   fun:in=
it_instance
-   fun:init_instance_handle_signals
-   fun:tunnel_server_tcp
=
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond=

-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E=
5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/libc-2=2E5=2Eso
-   obj:/lib=
/ld-2=2E5=2Eso
-   fun:__libc_dlopen_mode
-   fun:__nss_lookup_function
-  =
 obj:/lib/libc-2=2E5=2Eso
-   fun:getgrnam_r
-   fun:getgrnam
-   fun:get_g=
roup
-   fun:do_init_first_time
-   fun:init_instance
-   fun:init_instance=
_handle_signals
-   fun:tunnel_server_udp
-   fun:main
-}
-
-{
-   <insert =
a suppression name here>
-   Memcheck:Cond
-   obj:/lib/ld-2=2E5=2Eso
-   o=
bj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso=

-   obj:/lib/libc-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   fun:__libc_dlo=
pen_mode
-   fun:__nss_lookup_function
-   obj:/lib/libc-2=2E5=2Eso
-   fun=
:gethostbyname_r
-   fun:gethostbyname
-   fun:getaddr
-   fun:resolve_remo=
te
-   fun:link_socket_init_phase1
-   fun:init_instance
-   fun:init_insta=
nce_handle_signals
-   fun:main
-}
-
-{
-   <insert a suppression name here=
>
-   Memcheck:Cond
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-=
   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/libc-2=2E=
5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   fun:__libc_dlopen_mode
-   fun:__nss_=
lookup_function
-   obj:/lib/libc-2=2E5=2Eso
-   fun:getpwnam_r
-   fun:get=
pwnam
-   fun:get_user
-   fun:management_open
-   fun:open_management
-   =
fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-  =
 obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2E=
so
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/libc-2=2E5=2Eso
-   obj:/lib/lib=
dl-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/libdl-2=2E5=2Eso
-   =
fun:dlsym
-   fun:libdl_resolve_symbol
-   fun:plugin_list_init
-   fun:ini=
t_plugins
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Mem=
check:Cond
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/l=
ib/ld-2=2E5=2Eso
-   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/libdl-2=2E5=2Eso
-=
   obj:/lib/ld-2=2E5=2Eso
-   obj:/lib/libdl-2=2E5=2Eso
-   fun:dlopen
-   =
fun:plugin_list_init
-   fun:init_plugins
-   fun:main
-}
-
-{
-   <insert =
a suppression name here>
-   Memcheck:Leak
-   fun:malloc
-   fun:CRYPTO_ma=
lloc
-   fun:sk_new
-   obj:/usr/lib/libssl=2Eso=2E0=2E9=2E8
-   fun:SSL_CO=
MP_get_compression_methods
-   fun:SSL_library_init
-   fun:init_ssl_lib
- =
  fun:init_static
-   fun:main
-}
-
-{
-   <insert a suppression name here>=

-   Memcheck:Leak
-   fun:malloc
-   fun:__nss_lookup_function
-   obj:*
-=
   obj:*
-   fun:getgrnam_r
-   fun:getgrnam
-   fun:get_group
-   fun:do_i=
nit_first_time
-   fun:init_instance
-   fun:init_instance_handle_signals
-=
   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Leak
=
-   fun:malloc
-   fun:__nss_lookup_function
-   obj:*
-   obj:*
-   fun:ge=
tgrnam_r
-   fun:getgrnam
-   fun:get_group
-   fun:do_init_first_time
-   =
fun:init_instance
-   fun:init_instance_handle_signals
-   fun:tunnel_serve=
r_tcp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memchec=
k:Leak
-   fun:malloc
-   fun:__nss_lookup_function
-   obj:*
-   obj:*
-  =
 fun:getgrnam_r
-   fun:getgrnam
-   fun:get_group
-   fun:do_init_first_ti=
me
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:tunne=
l_server_udp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   =
Memcheck:Leak
-   fun:malloc
-   fun:__nss_lookup_function
-   obj:*
-   ob=
j:*
-   fun:getpwnam_r
-   fun:getpwnam
-   fun:get_user
-   fun:management=
_open
-   fun:open_management
-   fun:main
-}
-
-{
-   <insert a suppressio=
n name here>
-   Memcheck:Leak
-   fun:malloc
-   fun:getdelim
-   fun:getp=
ass
-   fun:get_console_input
-   fun:get_user_pass
-   fun:context_init_1
=
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Leak=

-   fun:malloc
-   fun:tsearch
-   fun:__nss_lookup_function
-   obj:*
-  =
 obj:*
-   fun:getgrnam_r
-   fun:getgrnam
-   fun:get_group
-   fun:do_ini=
t_first_time
-   fun:init_instance
-   fun:init_instance_handle_signals
-  =
 fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Leak
- =
  fun:malloc
-   fun:tsearch
-   fun:__nss_lookup_function
-   obj:*
-   ob=
j:*
-   fun:getgrnam_r
-   fun:getgrnam
-   fun:get_group
-   fun:do_init_f=
irst_time
-   fun:init_instance
-   fun:init_instance_handle_signals
-   fu=
n:tunnel_server_tcp
-   fun:main
-}
-
-{
-   <insert a suppression name her=
e>
-   Memcheck:Leak
-   fun:malloc
-   fun:tsearch
-   fun:__nss_lookup_fu=
nction
-   obj:*
-   obj:*
-   fun:getgrnam_r
-   fun:getgrnam
-   fun:get_=
group
-   fun:do_init_first_time
-   fun:init_instance
-   fun:init_instanc=
e_handle_signals
-   fun:tunnel_server_udp
-   fun:main
-}
-
-{
-   <insert=
 a suppression name here>
-   Memcheck:Leak
-   fun:malloc
-   fun:tsearch
=
-   fun:__nss_lookup_function
-   obj:*
-   obj:*
-   fun:getgrnam_r
-   fu=
n:getgrnam
-   fun:get_group
-   fun:management_open
-   fun:open_managemen=
t
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Le=
ak
-   fun:malloc
-   fun:tsearch
-   fun:__nss_lookup_function
-   obj:*
-=
   obj:*
-   fun:getpwnam_r
-   fun:getpwnam
-   fun:get_user
-   fun:manag=
ement_open
-   fun:open_management
-   fun:main
-}
-
-{
-   <insert a suppr=
ession name here>
-   Memcheck:Leak
-   fun:malloc
-   obj:/lib/libc-2=2E5=
=2Eso
-   fun:__nss_database_lookup
-   obj:*
-   obj:*
-   fun:getgrnam_r
=
-   fun:getgrnam
-   fun:get_group
-   fun:do_init_first_time
-   fun:init_=
instance
-   fun:init_instance_handle_signals
-   fun:main
-}
-
-{
-   <ins=
ert a suppression name here>
-   Memcheck:Leak
-   fun:malloc
-   obj:/lib/=
libc-2=2E5=2Eso
-   fun:__nss_database_lookup
-   obj:*
-   obj:*
-   fun:g=
etgrnam_r
-   fun:getgrnam
-   fun:get_group
-   fun:do_init_first_time
-  =
 fun:init_instance
-   fun:init_instance_handle_signals
-   fun:tunnel_serv=
er_tcp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Memche=
ck:Leak
-   fun:malloc
-   obj:/lib/libc-2=2E5=2Eso
-   fun:__nss_database_=
lookup
-   obj:*
-   obj:*
-   fun:getgrnam_r
-   fun:getgrnam
-   fun:get_=
group
-   fun:do_init_first_time
-   fun:init_instance
-   fun:init_instanc=
e_handle_signals
-   fun:tunnel_server_udp
-   fun:main
-}
-
-{
-   <insert=
 a suppression name here>
-   Memcheck:Leak
-   fun:malloc
-   obj:/lib/lib=
c-2=2E5=2Eso
-   fun:__nss_database_lookup
-   obj:*
-   obj:*
-   fun:getp=
wnam_r
-   fun:getpwnam
-   fun:get_user
-   fun:management_open
-   fun:op=
en_management
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-  =
 Memcheck:Leak
-   fun:malloc
-   obj:/lib/libc-2=2E7=2Eso
-   fun:__nss_da=
tabase_lookup
-   obj:*
-   obj:*
-   fun:getgrnam_r
-   fun:getgrnam
-   f=
un:get_group
-   fun:do_init_first_time
-   fun:init_instance
-   fun:init_=
instance_handle_signals
-   fun:tunnel_server_tcp
-   fun:main
-}
-
-{
-   =
<insert a suppression name here>
-   Memcheck:Leak
-   fun:malloc
-   obj:/=
lib/libc-2=2E7=2Eso
-   fun:__nss_database_lookup
-   obj:*
-   obj:*
-   f=
un:getgrnam_r
-   fun:getgrnam
-   fun:get_group
-   fun:do_init_first_time=

-   fun:init_instance
-   fun:init_instance_handle_signals
-   fun:tunnel_=
server_udp
-   fun:main
-}
-
-{
-   <insert a suppression name here>
-   Me=
mcheck:Leak
-   fun:malloc
-   obj:/lib/libc-2=2E7=2Eso
-   fun:__nss_datab=
ase_lookup
-   obj:*
-   obj:*
-   fun:getpwnam_r
-   fun:getpwnam
-   fun:=
get_user
-   fun:management_open
-   fun:open_management
-   fun:main
-}
-
=
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   fun:BN_mod_in=
verse
-}
-
-{
-   <insert a suppression name here>
-   Memcheck:Cond
-   fu=
n:BN_div
-}
diff --git a/src/openvpn/memdbg=2Eh b/src/openvpn/memdbg=2Eh
in=
dex 1f94582=2E=2E62c75ec 100644
--- a/src/openvpn/memdbg=2Eh
+++ b/src/open=
vpn/memdbg=2Eh
@@ -26,20 +26,15 @@
 /*
  * Valgrind debugging support=2E
  =
*
- * Valgrind is a great tool for debugging memory issues,
- * though it s=
eems to generate a lot of warnings in OpenSSL
- * about uninitialized data=
=2E To silence these warnings,
- * I've put together a suppressions file
- =
* in debug/valgrind-suppress=2E
+ * Valgrind is a great tool for debugging =
memory issues=2E
  *
- * Also, grep for VALGRIND_MAKE_READABLE in the OpenV=
PN source=2E
+ * Grep for VALGRIND_MAKE_READABLE in the OpenVPN source=2E
 =
 * Because valgrind thinks that some of the data passed from
  * OpenSSL ba=
ck to OpenVPN is tainted due to being sourced
  * from uninitialized data, =
we need to untaint it before use --
  * otherwise we will get a lot of usel=
ess warnings=2E
  *
- *   valgrind --tool=3Dmemcheck --error-limit=3Dno --s=
uppressions=3Ddebug/valgrind-suppress
- * --gen-suppressions=3Dyes =2E/open=
vpn =2E=2E=2E
+ *   valgrind --tool=3Dmemcheck --error-limit=3Dno --gen-sup=
pressions=3Dyes =2E/openvpn =2E=2E=2E
  */
 
 #ifdef USE_VALGRIND

-- 
To v=
iew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2365?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project:=
 openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I08a26d39f0e7c2fa910bcba57=
4b34d29c8bb8aed
Gerrit-Change-Number: 2365
Gerrit-PatchSet: 1
Gerrit-Owner:=
 R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>

--E8IYxRVWYog=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2365?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">Remove the obsolete debug/ valgrind helpers<br><br>dova=
l has been broken since commit 34cb9132 (&quot;build: standard directory<br=
>layout&quot;) moved it into debug/: it looks up valgrind-suppress and the<=
br>openvpn binary relative to debug/, where neither exists=2E<br>valgrind-s=
uppress was last updated in commit 3710e66e (&quot;updated<br>valgrind-supp=
ress for OpenSSL 0=2E9=2E8&quot;) and only matches glibc 2=2E5<br>objects=
=2E dovalns is a generic valgrind wrapper=2E<br><br>Drop the directory, its=
 EXTRA_DIST entry and the memdbg=2Eh references<br>to the suppressions file=
=2E<br><br>Change-Id: I08a26d39f0e7c2fa910bcba574b34d29c8bb8aed<br>Signed-o=
ff-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M Makefile=
=2Eam<br>D debug/doval<br>D debug/dovalns<br>D debug/valgrind-suppress<br>M=
 src/openvpn/memdbg=2Eh<br>5 files changed, 3 insertions(+), 1,197 deletion=
s(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/65/2365/1</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/Makefile=2Eam b/Makefi=
le=2Eam</span><br><span>index d3910ed=2E=2Ea8afa8e 100644</span><br><span>-=
-- a/Makefile=2Eam</span><br><span>+++ b/Makefile=2Eam</span><br><span>@@ -=
42,7 +42,6 @@</span><br><span> </span><br><span> EXTRA_DIST =3D \</span><br=
><span> 	contrib \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	de=
bug \</span><br><span> 	ltrc=2Einc \</span><br><span> 	CMakeLists=2Etxt \</=
span><br><span> 	CMakePresets=2Ejson \</span><br><span>diff --git a/debug/d=
oval b/debug/doval</span><br><span>deleted file mode 100755</span><br><span=
>index e215510=2E=2E0000000</span><br><span>--- a/debug/doval</span><br><sp=
an>+++ /dev/null</span><br><span>@@ -1,4 +0,0 @@</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#!/bin/bash</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-PROGDIR=3D`dirname $0`</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-unset LD_LIBRARY_PATH</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-valgrind --tool=3Dmemcheck --error-limit=3Dno --suppressi=
ons=3D$PROGDIR/debug/valgrind-suppress --gen-suppressions=3Dall --leak-chec=
k=3Dfull --show-reachable=3Dyes --num-callers=3D32 $PROGDIR/openvpn &quot;$=
@&quot;</span><br><span>diff --git a/debug/dovalns b/debug/dovalns</span><b=
r><span>deleted file mode 100755</span><br><span>index 482ae3f=2E=2E0000000=
</span><br><span>--- a/debug/dovalns</span><br><span>+++ /dev/null</span><b=
r><span>@@ -1,2 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#!/bin/bash</span><br><span style=3D"color: hsl(0, 100%, 40%);">-valgrind=
 --tool=3Dmemcheck --error-limit=3Dno --gen-suppressions=3Dall --leak-check=
=3Dfull --show-reachable=3Dyes --num-callers=3D32 $*</span><br><span>diff -=
-git a/debug/valgrind-suppress b/debug/valgrind-suppress</span><br><span>de=
leted file mode 100644</span><br><span>index d7de12f=2E=2E0000000</span><br=
><span>--- a/debug/valgrind-suppress</span><br><span>+++ /dev/null</span><b=
r><span>@@ -1,1182 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   &lt;insert a=
 suppression name here&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-   Memcheck:Addr8</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/libc-2=2E5=2Eso</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:__libc_dlopen_mod=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:__nss_lookup_=
function</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/l=
ibc-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:=
getgrnam_r</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:getg=
rnam</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:get_group<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:do_init_first_t=
ime</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:init_instan=
ce</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:init_instanc=
e_handle_signals</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fu=
n:tunnel_server_tcp</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
 fun:main</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-   &lt;insert a suppression name here&gt;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-   Memcheck:Addr8</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2E=
so</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E=
5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/lib=
c-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/l=
ib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fu=
n:__libc_dlopen_mode</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
  fun:__nss_lookup_function</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-   obj:/lib/libc-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-   fun:getgrnam_r</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-   fun:getgrnam</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-   fun:get_group</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
fun:do_init_first_time</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-   fun:init_instance</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
   fun:init_instance_handle_signals</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-   fun:tunnel_server_udp</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-   fun:main</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-   &lt;insert a suppression name here&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-   Memcheck:Addr8</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=
=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=
=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/=
ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/=
lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   o=
bj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-   obj:/lib/libc-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-   fun:__libc_dlopen_mode</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-   fun:__nss_lookup_function</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-   obj:/lib/libc-2=2E5=2Eso</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   fun:getpwnam_r</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-   fun:getpwnam</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-   fun:get_user</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-   fun:management_open</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-   fun:open_management</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-   fun:main</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-   &lt;insert a suppression name here&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-   Memcheck:Addr8</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=
=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=
=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/=
ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/=
lib/libc-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
 obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-   fun:__libc_dlopen_mode</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-   fun:__nss_lookup_function</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-   fun:__nss_next</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-   fun:gethostbyname_r</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-   fun:gethostbyname</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-   fun:getaddr</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-   fun:resolve_remote</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-   fun:link_socket_init_phase1</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-   fun:init_instance</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-   fun:init_instance_handle_signals</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-   fun:main</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-   &lt;insert a suppression name here&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-   Memcheck:Addr8</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2E=
so</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E=
5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-=
2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib=
/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:=
/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
obj:/lib/libc-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-   fun:__libc_dlopen_mode</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-   fun:__nss_lookup_function</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-   obj:/lib/libc-2=2E5=2Eso</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-   fun:gethostbyname_r</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-   fun:gethostbyname</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-   fun:getaddr</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-   fun:resolve_remote</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-   fun:link_socket_init_phase1</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-   fun:init_instance</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-   fun:init_instance_handle_signals</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-   fun:main</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-   &lt;insert a suppression name=
 here&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   Memcheck:=
Addr8</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=
=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/=
ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/=
lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   o=
bj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-   obj:/lib/libdl-2=2E5=2Eso</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-   obj:/lib/libdl-2=2E5=2Eso</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   fun:dlopen</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-   fun:plugin_list_init</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-   fun:init_plugins</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-   fun:main</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-   &lt;insert a suppression name here&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-   Memcheck:Addr8</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2E=
so</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E=
5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-=
2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib=
/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:=
/lib/libdl-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-   obj:/lib/libdl-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-   fun:dlopen</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-   fun:plugin_list_init</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-   fun:init_plugins</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-   fun:main</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-   &lt;insert a suppression name here&gt;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-   Memcheck:Addr8</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/libc-2=2E5=2Eso</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/libdl-2=2E5=2Eso<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=
=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/libd=
l-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:dl=
sym</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:libdl_resol=
ve_symbol</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:plugi=
n_list_init</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:ini=
t_plugins</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:main<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   &lt;i=
nsert a suppression name here&gt;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-   Memcheck:Addr8</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-   obj:/lib/libdl-2=2E5=2Eso</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/libdl-2=2E5=2Eso</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-   fun:dlopen</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-   fun:plugin_list_init</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-   fun:init_plugins</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-   fun:main</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-   &lt;insert a suppression name her=
e&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   Memcheck:Addr=
8</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E7=
=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=
=2E7=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/=
ld-2=2E7=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/=
lib/ld-2=2E7=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   o=
bj:/lib/ld-2=2E7=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
   obj:/lib/ld-2=2E7=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-   obj:/lib/ld-2=2E7=2Eso</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-   obj:/lib/ld-2=2E7=2Eso</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-   obj:/lib/ld-2=2E7=2Eso</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-   obj:/lib/ld-2=2E7=2Eso</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-   obj:/lib/libc-2=2E7=2Eso</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E7=2Eso</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   fun:__libc_dlopen_mode</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-   fun:__nss_lookup_function</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/libc-2=2E7=2Eso</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:getgrnam_r</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-   fun:getgrnam</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-   fun:get_group</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-   fun:do_init_first_time</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance_handle_signals</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:tunnel_server_tcp=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:main</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   &lt;insert a s=
uppression name here&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-   Memcheck:Addr8</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
  obj:/lib/ld-2=2E7=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-   obj:/lib/ld-2=2E7=2Eso</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-   obj:/lib/ld-2=2E7=2Eso</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-   obj:/lib/ld-2=2E7=2Eso</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-   obj:/lib/ld-2=2E7=2Eso</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-   obj:/lib/ld-2=2E7=2Eso</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E7=2Eso</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E7=2Eso</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E7=2Eso</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E7=2Eso</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/libc-2=2E7=2Eso</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E7=2Eso</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:__libc_dlopen_mode=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:__nss_lookup_f=
unction</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/li=
bc-2=2E7=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:g=
etgrnam_r</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:getgr=
nam</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:get_group</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:do_init_first_ti=
me</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:init_instanc=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance=
_handle_signals</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun=
:tunnel_server_udp</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
fun:main</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-   &lt;insert a suppression name here&gt;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-   Memcheck:Addr8</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-   obj:/lib/ld-2=2E7=2Eso</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E7=2Eso</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E7=2Eso</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E7=2Eso</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E7=2Eso</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E7=2Eso</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E7=2Eso</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E7=2Eso</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E7=2Eso<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E7=
=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/libc=
-2=2E7=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/li=
b/ld-2=2E7=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun=
:__libc_dlopen_mode</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
 fun:__nss_lookup_function</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-   obj:/lib/libc-2=2E7=2Eso</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-   fun:getgrnam_r</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-   fun:getgrnam</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-   fun:get_group</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   f=
un:management_open</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
fun:open_management</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
 fun:main</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-   &lt;insert a suppression name here&gt;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-   Memcheck:Addr8</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-   obj:/lib/ld-2=2E7=2Eso</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E7=2Eso</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E7=2Eso</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E7=2Eso</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E7=2Eso</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E7=2Eso</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E7=2Eso</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E7=2Eso</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E7=2E=
so</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E=
7=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/lib=
c-2=2E7=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/l=
ib/ld-2=2E7=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fu=
n:__libc_dlopen_mode</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
  fun:__nss_lookup_function</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-   obj:/lib/libc-2=2E7=2Eso</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-   fun:getpwnam_r</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-   fun:getpwnam</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-   fun:get_user</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   f=
un:management_open</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
fun:open_management</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
 fun:main</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-   &lt;insert a suppression name here&gt;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-   Memcheck:Cond</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-   fun:BN_div</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-   fun:BN_MONT_CTX_set</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-   fun:BN_MONT_CTX_set_locked</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-   obj:/usr/lib/libcrypto=2Eso=2E0=2E9=2E8</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-   fun:RSA_verify</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-   fun:EVP_VerifyFinal</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-   fun:ASN1_item_verify</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-   obj:/usr/lib/libcrypto=2Eso=2E0=2E=
9=2E8</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:X509_veri=
fy_cert</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:ssl_ver=
ify_cert_chain</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:=
ssl3_get_client_certificate</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-   fun:ssl3_accept</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-   fun:ssl3_read_bytes</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-   fun:ssl3_read</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
  obj:/usr/lib/libssl=2Eso=2E0=2E9=2E8</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-   fun:BIO_read</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-   fun:bio_read</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-   fun:tls_process</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-   fun:tls_multi_process</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-   fun:check_tls_dowork</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-   fun:pre_select</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-   fun:multi_process_post</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-   fun:multi_process_incoming_link</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-   fun:multi_tcp_action</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-   &lt;insert a suppression name here&g=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   Memcheck:Cond</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:BN_div</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-   fun:BN_MONT_CTX_set</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-   fun:BN_MONT_CTX_set_locked</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/usr/lib/libcryp=
to=2Eso=2E0=2E9=2E8</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
 fun:ssl3_ctx_ctrl</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
fun:init_ssl</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:in=
it_instance</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:ini=
t_instance_handle_signals</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-   fun:tunnel_server_tcp</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-   fun:main</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-   &lt;insert a suppression name here&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   Memcheck:Cond</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-   fun:BN_div</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-   fun:BN_MONT_CTX_set</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-   fun:BN_MONT_CTX_set_locked</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-   obj:/usr/lib/libcrypto=2Eso=2E0=2E9=2E8</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:ssl3_ctx_ctrl</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:init_ssl</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance_handle_signal=
s</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:tunnel_server=
_udp</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:main</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   &lt;insert=
 a suppression name here&gt;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-   Memcheck:Cond</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-   fun:BN_div</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun=
:BN_MONT_CTX_set</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fu=
n:BN_MONT_CTX_set_locked</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-   obj:/usr/lib/libcrypto=2Eso=2E0=2E9=2E8</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-   obj:/usr/lib/libcrypto=2Eso=2E0=2E9=2E8</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-   fun:RSA_sign</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-   fun:ssl3_send_server_key_exchange=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:ssl3_accept</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:ssl3_read_bytes</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:ssl3_read</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/usr/lib/libssl=2Eso=
=2E0=2E9=2E8</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:BI=
O_read</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:bio_read=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:tls_process</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:tls_multi_process=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:check_tls_dowo=
rk</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:pre_select</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:multi_process_po=
st</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:multi_proces=
s_incoming_link</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun=
:multi_tcp_action</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   f=
un:tunnel_server_tcp</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
  fun:main</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-   &lt;insert a suppression name here&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-   Memcheck:Cond</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-   fun:BN_div</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-   fun:BN_MONT_CTX_set</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-   fun:BN_mod_exp_mont</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-   fun:BN_BLINDING_create_param</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-   fun:RSA_setup_blinding</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-   obj:/usr/lib/libcrypto=2Eso=2E0=2E9=2E8</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/usr/lib/libcrypto=2E=
so=2E0=2E9=2E8</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:=
RSA_sign</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:ssl3_s=
end_server_key_exchange</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-   fun:ssl3_accept</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
  fun:ssl3_read_bytes</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
   fun:ssl3_read</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   ob=
j:/usr/lib/libssl=2Eso=2E0=2E9=2E8</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-   fun:BIO_read</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-   fun:bio_read</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-   fun:tls_process</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
 fun:tls_multi_process</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-   fun:check_tls_dowork</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-   fun:pre_select</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
  fun:multi_process_post</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-   fun:multi_process_incoming_link</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-   fun:multi_tcp_action</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-   fun:tunnel_server_tcp</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-   fun:main</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-   &lt;insert a suppression name here&gt;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-   Memcheck:Cond</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-   fun:BN_div</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   fun:BN_nnmod</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-   fun:BN_mod_inverse</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-   fun:BN_MONT_CTX_set</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-   fun:BN_MONT_CTX_set_locked</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-   obj:/usr/lib/libcrypto=2Eso=2E0=2E9=
=2E8</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:ssl3_ctx_c=
trl</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:init_ssl</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance_hand=
le_signals</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:tunn=
el_server_tcp</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:m=
ain</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   &=
lt;insert a suppression name here&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-   Memcheck:Cond</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-   fun:BN_div</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-   fun:BN_nnmod</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
fun:BN_mod_inverse</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
fun:BN_MONT_CTX_set</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
 fun:BN_MONT_CTX_set_locked</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-   obj:/usr/lib/libcrypto=2Eso=2E0=2E9=2E8</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-   fun:ssl3_ctx_ctrl</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-   fun:init_ssl</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-   fun:init_instance</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-   fun:init_instance_handle_signals</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-   fun:tunnel_server_udp</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-   fun:main</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-   &lt;insert a suppression name he=
re&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   Memcheck:Con=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:BN_mod_invers=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:BN_MONT_CTX_s=
et</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:BN_MONT_CTX_=
set_locked</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/usr=
/lib/libcrypto=2Eso=2E0=2E9=2E8</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-   fun:RSA_verify</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-   fun:EVP_VerifyFinal</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-   fun:ASN1_item_verify</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-   obj:/usr/lib/libcrypto=2Eso=2E0=2E9=2E8</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   fun:X509_verify_cert</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-   fun:ssl_verify_cert_chain</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-   fun:ssl3_get_client_certificate=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:ssl3_accept</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:ssl3_read_bytes</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:ssl3_read</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/usr/lib/libssl=2Eso=
=2E0=2E9=2E8</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:BI=
O_read</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:bio_read=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:tls_process</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:tls_multi_process=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:check_tls_dowo=
rk</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:pre_select</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:multi_process_po=
st</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:multi_proces=
s_incoming_link</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun=
:multi_tcp_action</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-   &lt;insert a suppression name here&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   Memcheck:Cond</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-   fun:BN_mod_inverse</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-   fun:BN_MONT_CTX_set</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-   fun:BN_MONT_CTX_set_locked</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-   obj:/usr/lib/libcrypto=2Eso=2E0=2E9=
=2E8</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:ssl3_ctx_c=
trl</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:init_ssl</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance_hand=
le_signals</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:tunn=
el_server_tcp</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:m=
ain</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   &=
lt;insert a suppression name here&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-   Memcheck:Cond</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-   fun:BN_mod_inverse</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-   fun:BN_MONT_CTX_set</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-   fun:BN_MONT_CTX_set_locked</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-   obj:/usr/lib/libcrypto=2Eso=2E0=2E9=2E8</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-   fun:ssl3_ctx_ctrl</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-   fun:init_ssl</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance_handle_signals</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:tunnel_server_udp</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:main</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   &lt;insert a suppr=
ession name here&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
  Memcheck:Cond</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun=
:BN_mod_inverse</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun=
:BN_MONT_CTX_set</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fu=
n:BN_MONT_CTX_set_locked</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-   obj:/usr/lib/libcrypto=2Eso=2E0=2E9=2E8</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-   obj:/usr/lib/libcrypto=2Eso=2E0=2E9=2E8</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-   fun:RSA_sign</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-   fun:ssl3_send_server_key_exchange=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:ssl3_accept</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:ssl3_read_bytes</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:ssl3_read</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/usr/lib/libssl=2Eso=
=2E0=2E9=2E8</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:BI=
O_read</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:bio_read=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:tls_process</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:tls_multi_process=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:check_tls_dowo=
rk</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:pre_select</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:multi_process_po=
st</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:multi_proces=
s_incoming_link</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun=
:multi_tcp_action</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   f=
un:tunnel_server_tcp</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
  fun:main</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-   &lt;insert a suppression name here&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-   Memcheck:Cond</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-   fun:BN_mod_inverse</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-   fun:BN_MONT_CTX_set</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-   fun:BN_mod_exp_mont</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-   fun:BN_BLINDING_create_param</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   fun:RSA_setup_blinding</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-   obj:/usr/lib/libcrypto=2Eso=2E0=2E9=
=2E8</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/usr/lib/l=
ibcrypto=2Eso=2E0=2E9=2E8</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-   fun:RSA_sign</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
 fun:ssl3_send_server_key_exchange</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-   fun:ssl3_accept</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-   fun:ssl3_read_bytes</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-   fun:ssl3_read</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-   obj:/usr/lib/libssl=2Eso=2E0=2E9=2E8</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-   fun:BIO_read</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-   fun:bio_read</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-   fun:tls_process</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-   fun:tls_multi_process</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-   fun:check_tls_dowork</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-   fun:pre_select</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-   fun:multi_process_post</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-   fun:multi_process_incoming_link</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-   fun:multi_tcp_action</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-   fun:tunnel_server_tcp</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   fun:main</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-   &lt;insert a suppression name here&g=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   Memcheck:Cond</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Es=
o</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=
=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=
=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/=
ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/=
lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   o=
bj:*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:*</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-   obj:*</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-   &lt;insert a suppression n=
ame here&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   Memche=
ck:Cond</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld=
-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/li=
b/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj=
:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
 obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-   obj:/lib/libc-2=2E5=2Eso</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-   fun:__libc_dlopen_mode</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-   fun:__nss_lookup_function</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-   fun:__nss_next</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   fun:gethostbyname_r</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-   fun:gethostbyname</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   fun:getaddr</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-   fun:resolve_remote</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-   fun:link_socket_init_phase1</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance_handle_signals</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:main</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-   &lt;insert a suppress=
ion name here&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   M=
emcheck:Cond</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/l=
ib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   ob=
j:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
  obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-   obj:/lib/libc-2=2E5=2Eso</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-   fun:__libc_dlopen_mode</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-   fun:__nss_lookup_function</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/libc-2=2E5=2Eso</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:getgrnam_r</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-   fun:getgrnam</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-   fun:get_group</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   fun:do_init_first_time</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance_handle_signals</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:tunnel_server_tcp</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:main</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   &lt;insert a sup=
pression name here&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-   Memcheck:Cond</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   o=
bj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-   obj:/lib/libc-2=2E5=2Eso</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-   fun:__libc_dlopen_mode</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-   fun:__nss_lookup_function</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/libc-2=2E5=2Eso<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:gethostbyname_r=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:gethostbyname<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:getaddr</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:resolve_remote</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:link_socket_init_phase=
1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance_=
handle_signals</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:=
main</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
&lt;insert a suppression name here&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-   Memcheck:Cond</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/libc-2=2E5=2Eso</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-   fun:__libc_dlopen_mode</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:__nss_lookup_function<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:__nss_next</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:gethostbyname_r</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:gethostbyname</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:getaddr</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-   fun:resolve_remote</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-   fun:link_socket_init_phase1</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance_hand=
le_signals</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:main=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   &lt;=
insert a suppression name here&gt;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-   Memcheck:Cond</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-   obj:/lib/libc-2=2E5=2Eso</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-   fun:__libc_dlopen_mode</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-   fun:__nss_lookup_function</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/libc-2=2E5=2Es=
o</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:getgrnam_r</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:getgrnam</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-   fun:get_group</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-   fun:do_init_first_time</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance_handle_sign=
als</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:tunnel_serv=
er_tcp</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:main</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   &lt;in=
sert a suppression name here&gt;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-   Memcheck:Cond</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-   obj:/lib/libc-2=2E5=2Eso</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-   fun:__libc_dlopen_mode</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-   fun:__nss_lookup_function</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/libc-2=2E5=2Eso<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:gethostbyname_r=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:gethostbyname<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:getaddr</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:resolve_remote</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:link_socket_init_phase=
1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance_=
handle_signals</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:=
main</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
&lt;insert a suppression name here&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-   Memcheck:Cond</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-   obj:/lib/libc-2=2E5=2Eso</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-   fun:__libc_dlopen_mode</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-   fun:__nss_lookup_function</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:__nss_next</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-   fun:gethostbyname_r</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:gethostbyname</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-   fun:getaddr</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-   fun:resolve_remote</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-   fun:link_socket_init_phase1</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance_handle_s=
ignals</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:main</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   &lt;in=
sert a suppression name here&gt;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-   Memcheck:Cond</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-   obj:/lib/libc-2=2E5=2Eso</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   fun:__libc_dlopen_mode</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-   fun:__nss_lookup_function</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/libc-2=2E5=2Eso</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:getgrnam_r</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-   fun:getgrnam</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-   fun:get_group</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-   fun:do_init_first_time</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance_handle_signals</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:tunnel_server_tcp=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:main</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   &lt;insert a s=
uppression name here&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-   Memcheck:Cond</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
 obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-   obj:/lib/libc-2=2E5=2Eso</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-   fun:__libc_dlopen_mode</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-   fun:__nss_lookup_function</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/libc-2=2E5=2Eso</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-   fun:getgrnam_r</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-   fun:getgrnam</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   fun:get_group</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-   fun:do_init_first_time</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance_handle_signals</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:tunnel_server_udp</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:main</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-   &lt;insert a suppre=
ssion name here&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
 Memcheck:Cond</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:=
/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-   obj:/lib/libc-2=2E5=2Eso</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-   fun:__libc_dlopen_mode</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-   fun:__nss_lookup_function</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/libc-2=2E5=2Eso</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-   fun:gethostbyname_r</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-   fun:gethostbyname</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-   fun:getaddr</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   fun:resolve_remote</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   fun:link_socket_init_phase1</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance_handle_signals=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:main</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   &lt;insert a s=
uppression name here&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-   Memcheck:Cond</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
 obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-   obj:/lib/libc-2=2E5=2Eso</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-   fun:__libc_dlopen_mode</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-   fun:__nss_lookup_function</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/libc-2=2E5=2Eso</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-   fun:getpwnam_r</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-   fun:getpwnam</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   fun:get_user</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-   fun:management_open</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-   fun:open_management</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-   fun:main</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   &lt;insert a suppression name here&gt;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-   Memcheck:Cond</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Es=
o</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=
=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=
=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/=
libc-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj=
:/lib/libdl-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-   obj:/lib/libdl-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-   fun:dlsym</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-   fun:libdl_resolve_symbol</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-   fun:plugin_list_init</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-   fun:init_plugins</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-   fun:main</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-   &lt;insert a suppression name here&gt;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-   Memcheck:Cond</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Eso</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/libdl-2=2E5=2Eso</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/ld-2=2E5=2Es=
o</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/libdl-2=
=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:dlope=
n</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:plugin_list_i=
nit</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:init_plugin=
s</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:main</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   &lt;insert a =
suppression name here&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-   Memcheck:Leak</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
  fun:malloc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:CR=
YPTO_malloc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:sk_=
new</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/usr/lib/li=
bssl=2Eso=2E0=2E9=2E8</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
   fun:SSL_COMP_get_compression_methods</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-   fun:SSL_library_init</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-   fun:init_ssl_lib</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-   fun:init_static</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-   fun:main</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-   &lt;insert a suppression name here&gt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-   Memcheck:Leak</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-   fun:malloc</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-   fun:__nss_lookup_function</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-   obj:*</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-   obj:*</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-   fun:getgrnam_r</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-   fun:getgrnam</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
fun:get_group</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:d=
o_init_first_time</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   f=
un:init_instance</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fu=
n:init_instance_handle_signals</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-   fun:main</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-   &lt;insert a suppression name here&gt;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-   Memcheck:Leak</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-   fun:malloc</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-   fun:__nss_lookup_function</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-   obj:*</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-   obj:*</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-   fun:getgrnam_r</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
fun:getgrnam</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:ge=
t_group</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:do_init=
_first_time</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:ini=
t_instance</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:init=
_instance_handle_signals</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-   fun:tunnel_server_tcp</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-   fun:main</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-   &lt;insert a suppression name here&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   Memcheck:Leak</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-   fun:malloc</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-   fun:__nss_lookup_function</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-   obj:*</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-   obj:*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
   fun:getgrnam_r</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   f=
un:getgrnam</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:get=
_group</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:do_init_=
first_time</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:init=
_instance</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:init_=
instance_handle_signals</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-   fun:tunnel_server_udp</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-   fun:main</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-   &lt;insert a suppression name here&gt;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-   Memcheck:Leak</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-   fun:malloc</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-   fun:__nss_lookup_function</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-   obj:*</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-   obj:*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
fun:getpwnam_r</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:=
getpwnam</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:get_us=
er</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:management_o=
pen</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:open_manage=
ment</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:main</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   &lt;insert=
 a suppression name here&gt;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-   Memcheck:Leak</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-   fun:malloc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun=
:getdelim</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:getpa=
ss</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:get_console_=
input</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:get_user_=
pass</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:context_in=
it_1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:main</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   &lt;insert=
 a suppression name here&gt;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-   Memcheck:Leak</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-   fun:malloc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun=
:tsearch</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:__nss_=
lookup_function</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj=
:*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:*</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-   fun:getgrnam_r</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-   fun:getgrnam</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-   fun:get_group</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-   fun:do_init_first_time</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance_handle_signals</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:main</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-   &lt;insert a suppressi=
on name here&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   Me=
mcheck:Leak</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:mal=
loc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:tsearch</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:__nss_lookup_funct=
ion</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:*</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-   obj:*</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   fun:getgrnam_r</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-   fun:getgrnam</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-   fun:get_group</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-   fun:do_init_first_time</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-   fun:init_instance</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-   fun:init_instance_handle_signals</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-   fun:tunnel_server_tcp</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-   fun:main</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-   &lt;insert a suppression name h=
ere&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   Memcheck:Le=
ak</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:malloc</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:tsearch</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-   fun:__nss_lookup_function</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:*</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-   obj:*</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-   fun:getgrnam_r</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-   fun:getgrnam</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-   fun:get_group</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-   fun:do_init_first_time</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-   fun:init_instance</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-   fun:init_instance_handle_signals</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-   fun:tunnel_server_udp</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-   fun:main</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   &lt;insert a suppression name here&gt;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-   Memcheck:Leak</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:malloc</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-   fun:tsearch</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   fun:__nss_lookup_function</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-   obj:*</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-   obj:*</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-   fun:getgrnam_r</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-   fun:getgrnam</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-   fun:get_group</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
 fun:management_open</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
  fun:open_management</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
   fun:main</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-   &lt;insert a suppression name here&gt;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-   Memcheck:Leak</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-   fun:malloc</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-   fun:tsearch</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-   fun:__nss_lookup_function</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-   obj:*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
 obj:*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:getpwnam=
_r</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:getpwnam</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:get_user</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-   fun:management_open</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-   fun:open_management</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:main</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-   &lt;insert a suppressi=
on name here&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   Me=
mcheck:Leak</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:mal=
loc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/libc-2=
=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:__nss=
_database_lookup</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   ob=
j:*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:*</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-   fun:getgrnam_r</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-   fun:getgrnam</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-   fun:get_group</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-   fun:do_init_first_time</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance_handle_signals</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:main</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-   &lt;insert a suppressi=
on name here&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   Me=
mcheck:Leak</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:mal=
loc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/libc-2=
=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:__nss=
_database_lookup</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   ob=
j:*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:*</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-   fun:getgrnam_r</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-   fun:getgrnam</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-   fun:get_group</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-   fun:do_init_first_time</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance_handle_signals</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:tunnel_server_tcp</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:main</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-   &lt;insert a suppre=
ssion name here&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
 Memcheck:Leak</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:=
malloc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/lib=
c-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:__=
nss_database_lookup</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
 obj:*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:*</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:getgrnam_r</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-   fun:getgrnam</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-   fun:get_group</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   fun:do_init_first_time</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance_handle_signals</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:tunnel_server_udp</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:main</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   &lt;insert a sup=
pression name here&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-   Memcheck:Leak</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   f=
un:malloc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/=
libc-2=2E5=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun=
:__nss_database_lookup</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-   obj:*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:*</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:getpwnam_r</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:getpwnam</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-   fun:get_user</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-   fun:management_open</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-   fun:open_management</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-   fun:main</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-   &lt;insert a suppression name he=
re&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   Memcheck:Lea=
k</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:malloc</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/libc-2=2E7=2Eso<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:__nss_database_=
lookup</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:*</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:*</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-   fun:getgrnam_r</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   fun:getgrnam</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-   fun:get_group</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-   fun:do_init_first_time</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-   fun:init_instance</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-   fun:init_instance_handle_signals</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-   fun:tunnel_server_tcp</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-   fun:main</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-   &lt;insert a suppression n=
ame here&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   Memche=
ck:Leak</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:malloc<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/libc-2=2E7=
=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:__nss_dat=
abase_lookup</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:*<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:*</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-   fun:getgrnam_r</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-   fun:getgrnam</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   fun:get_group</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-   fun:do_init_first_time</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   fun:init_instance_handle_signals</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:tunnel_server_udp</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:main</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-   &lt;insert a suppre=
ssion name here&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
 Memcheck:Leak</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:=
malloc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:/lib/lib=
c-2=2E7=2Eso</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:__=
nss_database_lookup</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
 obj:*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   obj:*</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:getpwnam_r</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-   fun:getpwnam</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-   fun:get_user</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-   fun:management_open</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-   fun:open_management</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-   fun:main</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-   &lt;insert a suppression name here=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   Memcheck:Cond<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-   fun:BN_mod_inverse<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   &lt;i=
nsert a suppression name here&gt;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-   Memcheck:Cond</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-   fun:BN_div</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}=
</span><br><span>diff --git a/src/openvpn/memdbg=2Eh b/src/openvpn/memdbg=
=2Eh</span><br><span>index 1f94582=2E=2E62c75ec 100644</span><br><span>--- =
a/src/openvpn/memdbg=2Eh</span><br><span>+++ b/src/openvpn/memdbg=2Eh</span=
><br><span>@@ -26,20 +26,15 @@</span><br><span> /*</span><br><span>  * Valg=
rind debugging support=2E</span><br><span>  *</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * Valgrind is a great tool for debugging memory is=
sues,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * though it see=
ms to generate a lot of warnings in OpenSSL</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * about uninitialized data=2E To silence these warni=
ngs,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * I&#39;ve put t=
ogether a suppressions file</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * in debug/valgrind-suppress=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Valgrind is a great tool for debugging memory issues=
=2E</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * Also, grep for VALGRIND_MAKE_READABLE in the OpenVPN source=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * Grep for VALGRIND_MAKE_R=
EADABLE in the OpenVPN source=2E</span><br><span>  * Because valgrind think=
s that some of the data passed from</span><br><span>  * OpenSSL back to Ope=
nVPN is tainted due to being sourced</span><br><span>  * from uninitialized=
 data, we need to untaint it before use --</span><br><span>  * otherwise we=
 will get a lot of useless warnings=2E</span><br><span>  *</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- *   valgrind --tool=3Dmemcheck --erro=
r-limit=3Dno --suppressions=3Ddebug/valgrind-suppress</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * --gen-suppressions=3Dyes =2E/openvpn =2E=
=2E=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   valgrind=
 --tool=3Dmemcheck --error-limit=3Dno --gen-suppressions=3Dyes =2E/openvpn =
=2E=2E=2E</span><br><span>  */</span><br><span> </span><br><span> #ifdef US=
E_VALGRIND</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2365?usp=3Demail">change 2365</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2365?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I08a26d39f0e7c2fa910=
bcba574b34d29c8bb8aed </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 2365 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne S=
chwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--E8IYxRVWYog=--


--===============3034116182061378108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3034116182061378108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3034116182061378108==--

