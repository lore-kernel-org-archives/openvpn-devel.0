Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0277960A2614
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lTrqHfx5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=aHBTCaL5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FWvoIR9g;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ds4nWkM2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Zcv/Fy4m4b11qrssx1STKIqsarG6puyJnOZx6BImfpM=; b=lTrqHfx5y3mmcH8/BYjqGFgaXI
	wHHTUxuZdL7Glm6cnttwKcE6VsrsZ1h8dF8TixvVMUb7pwcMmuJ189gSZ9PBQetJz1HGS/g7iCpgy
	YdHV4DIREMl9Lem6RGCp/uI3lM9X/0iVUuaPeTDBWHit94nHF3NXD3/Wk5W5aIQxYKXk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQSbG-000000001u8-1Udu;
	Mon, 09 Nov 2026 16:52:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQSbE-000000001u2-3Oaq
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 16:52:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2g1ySCrEpu0F/i5RaHlxB6AJAK3TdOzlY5Tb8pGAJPY=; b=aHBTCaL5Q7j+/iknnQuo0e1ube
 0sMTY9xjMIkmUvKq+YYMPYSDeXvyaUlP+6Cw6PONysM3UYWiwHn2lgTGAmhmDKJAg4avfY7tm8oe9
 /P2G53gouBDeoDwDOYLy54GFqkG6olwZLAAjlC3RwBVxdPf80ijNzSzP6NJURDW4TZ/k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2g1ySCrEpu0F/i5RaHlxB6AJAK3TdOzlY5Tb8pGAJPY=; b=FWvoIR9gRXe8th4JM0ujfMQkoY
 NpBgtIDlLmITkF03IBnuNUscB8KHVf3chHUTpLWUT5w4HUktw9Gm/2Wp9S3QFgwCeVYL8UCyI3PAC
 wqDlVwdUK/wNNJc8evlz7PlfIvvtFoof2xa+ICjf6JlV5uh8Msalt21iWi455LCMAfVE=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQSb8-0000000043l-1Gcq for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 16:52:04 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so6569595e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 08:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794243112; x=1794847912; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2g1ySCrEpu0F/i5RaHlxB6AJAK3TdOzlY5Tb8pGAJPY=;
 b=ds4nWkM2AaKGzDHckxCe5xycZKfe2wUFcwIfXbmguXUkFrsdTdGNjPvusOAu6qJv3Y
 tdtX82SrGoXlapqkI62A7L4UU4uyOc1zoAylxhVx/FBU+jEBqIoRg5/7pVCKUHlA1oOF
 mOMnMQYNBShl/F2rJaH3ZOwzF7cQ7Z8SxZMAtggRNw9ng5EXoHLkoVI0cRoFxrmvgPNV
 f3+C7gH7/mcZO4ikRJt1MwJwgzcLkVrjJDRTT+8uzwZmvoNdxyOILYSkB4s5gPD4AD+E
 SOrNGUkVJcWSyXeWfkArhUEiUm+zWx/zne5yeVQ/0rq2pFtO5bHitPxsyw76goaJGuq1
 79hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794243112; x=1794847912;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2g1ySCrEpu0F/i5RaHlxB6AJAK3TdOzlY5Tb8pGAJPY=;
 b=nS3/InNz3aOupsgFSVlPttqiXaLySqnzvxjCd+6GJCHfcJXAYZCkTkQRLxey0XLbID
 jlNoUa83P0Vfun69vCWNFUr/bBdidkxVPTCh94Z3ActIBX0iH7hEFXz+mjWF7+L52QRN
 Sf192ZNbaTN4/TZSZ7V8Qdzyry86Cr33WQTVAGpW+M4kOTidUvRCFIM9OucGF0rN9OJx
 RPEvGHjfII0u/x3MJ6j+GZxIX/7RgyR5CbS0MAenlbegg/Yum+ltAy8543DgYr6k659P
 sbREWq6NXfWfCX1qDpfFhuxmfhBUqx4XpdEh4UBnt1NQC4ifPOeH9cj0ozZxnriKgwG2
 E1Hw==
X-Gm-Message-State: APuU4Z/d2HOiGZwP7hr/W//r+W6JATShi9PSw8y/RWjc/mFDeRFtRtIa
 jNHS8QBm46+0gdxSl3fSMbAPr1enPzXHGFXSqppDTNzCztBEOAQ/z+R1OeRaqGjBQErhAM5LSkL
 rpg7tKccTfDCBe2SaCxOE0Zz8+d0FYJ6H+QLd3zLrx7YoXied3sK5EbSJa2k+o54YRA7H
X-Gm-Gg: AYBFou38rjo4og5mDoGifQ/uBQcSgYd7RvsFkYa/mbfBLypCad8YkgFP/wOtyGn7jAZ
 bAHNKisVorRF82utERfKo0YvGWxRRh+ifbs1ZY7fw3U60BGxpXm+ZUnWqEkx86f7r4C3p6Z7enR
 dEyL8lzmmziDNLIHhkCCw3JLgStAmVvXqvoio0n5QJtYyun6Lxdy+EsGJHy7AoW23sGPs6KYzMD
 r/3w94WKiyu1SXUxioq95B+MhMQ8QHeBWu5eRi7bR5+urH+JZt7XytSMO2kxq3+7Ffxc00+L7to
 2EeE25lIm+gdEnVDxIZlvJmnHj2tbt3FHudVQ8vW/a04KKRmRt6P60bj/ftK1STxvDY2nzw+DpD
 VINzbye8ACO5rs/gDz/znOCvzfvS0TLI8jWLirVSM3bx2mNeVAuGqhYIP6liIqbdRkq9IwQuRMv
 AXZNTbROK4Lw5nP6Ieo+vHT0L3I/gSftUNTFdnIYwrFf07wZUXTF+0ir0togApaMeme6HrjKDiN
 VQhoFHIUiklLGV0QfUCsyd5tgEj2pgab4MDUgNDG6brSb1kPklh0yRlAO7JYk9QD112vLuZDjlv
 l0HQD5YGolVn/0jJfHqRPx4vywhI72BrC4hLlp7UG0KMTig7odPpZwFGcB9I6x5pvSm2GuU9qj/
 WrmNCZo7XCOb7aEp4TnMTMPylf8a6bQLCc1WSBsMzTkrM0ALtXTOgESTJaQ+LUTsHiN2+QJcqVV
 sbdEaAtvepsHP0CRBTgfnyRtXVdsag8MpEuN4=
X-Received: by 2002:a05:600c:3f16:b0:4a7:76fa:87e9 with SMTP id
 5b1f17b1804b1-4b963c6d9c4mr81103515e9.21.1794243110860; 
 Mon, 09 Nov 2026 08:51:50 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-495b90701c7sm13868462f8f.10.2026.11.09.08.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 08:51:50 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 16:51:47 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368
X-Gerrit-Change-Number: 2081
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2081?usp=email>
X-Gerrit-Commit: 37bc5e99832e79ab44eb53acf01dceca295bc9d9
In-Reply-To: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
References: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkljYWRiZWU1MGEzYWY1NWYwZjIwNjlmNmQ2ZjFjY2M3NDYxODBmMzY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ec6831409d18db894b2bb8272084d15e25845212-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQSb8-0000000043l-1Gcq
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove support for
 --secret
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4798911225964733972=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4798911225964733972==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BtF+1rhSrMc="; charset=UTF-8

--BtF+1rhSrMc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Frank Lichtenheld, R=C4=83zvan Cojocaru, 

I'd l=
ike you to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2081?usp=3Demail

to look at the new patch set (#7)=2E

=

Change subject: Remove support for --secret
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove support for --secret

This has been =
announced for a long time and good alternatives exist=2E

Change-Id: Icadbe=
e50a3af55f0f2069f6d6f1ccc746180f368
Signed-off-by: Arne Schwabe <arne@rfc25=
49=2Eorg>
---
M Changes=2Emd
M INSTALL
M doc/man-sections/generic-options=
=2Erst
M doc/man-sections/protocol-options=2Erst
M doc/man-sections/unsuppo=
rted-options=2Erst
M doc/openvpn=2E8=2Erst
M src/openvpn/check_file_access=
=2Ec
M src/openvpn/crypto=2Ec
M src/openvpn/crypto=2Eh
M src/openvpn/crypto=
_mbedtls=2Ec
M src/openvpn/helper=2Ec
M src/openvpn/init=2Ec
M src/openvpn/=
mtu=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
M src/openvpn/o=
ptions_show=2Ec
M src/openvpn/options_string=2Ec
M src/openvpn/options_stri=
ng=2Eh
M src/openvpn/ssl=2Ec
M tests/unit_tests/openvpn/test_crypto=2Ec
M t=
ests/unit_tests/openvpn/test_pkt=2Ec
21 files changed, 266 insertions(+), 5=
46 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/81/2081/7

diff --git a/Changes=2Emd b/Changes=2Emd
index b5ae881=
=2E=2E7f47f77 100644
--- a/Changes=2Emd
+++ b/Changes=2Emd
@@ -23,6 +23,13 =
@@
   the characters mentioned above were already escaped=2E However, the b=
ehavior of
   Mbed TLS is slightly different from OpenSSL in that it also e=
scapes "=3D"=2E
 
+* **`secret` has been removed**
+
+  Static key mode (no=
n-TLS) is no longer considered "good and secure enough" for
+  today's requ=
irements=2E Use TLS mode instead=2E If deploying a PKI CA is considered
+  =
"too complicated", using `--peer-fingerprint` makes TLS mode about as easy =
as
+  using `--secret`=2E
+
 ## Maintainer-visible changes
 
 - The configu=
re-time option `--enable-debug` is no longer  available
diff --git a/INSTAL=
L b/INSTALL
index 486b1ae=2E=2Ed0ffaf0 100644
--- a/INSTALL
+++ b/INSTALL
@=
@ -144,8 +144,7 @@
 
 Test Crypto:
 
-=2E/openvpn --genkey secret key
-=2E/=
openvpn --test-crypto --secret key
+=2E/openvpn --test-crypto
 
 Test SSL/T=
LS negotiations (runs for 2 minutes):
 
diff --git a/doc/man-sections/gener=
ic-options=2Erst b/doc/man-sections/generic-options=2Erst
index 6815dc2=2E=
=2E17e4372 100644
--- a/doc/man-sections/generic-options=2Erst
+++ b/doc/ma=
n-sections/generic-options=2Erst
@@ -108,7 +108,7 @@
   For example on Wind=
ows, use double backslashes to represent pathnames:
   ::
 
-      secret "=
c:\\OpenVPN\\secret=2Ekey"
+      tls-auth "c:\\OpenVPN\\secret=2Ekey"
 
 
=
   For examples of configuration files, see
@@ -119,7 +119,7 @@
 
       #
=
       # Sample OpenVPN configuration file for
-      # using a pre-shared =
static key=2E
+      # using a p2p connection=2E
       #
       # '#' or '=
;' may be used to delimit comments=2E
 
@@ -133,8 +133,11 @@
       # 10=2E=
1=2E0=2E2 is our remote VPN endpoint
       ifconfig 10=2E1=2E0=2E1 10=2E1=
=2E0=2E2
 
-      # Our pre-shared static key
-      secret static=2Ekey
+ =
     # Our TLS configuration
+      tls-client
+      key mynode=2Ekey
+   =
   cert mynode=2Ecrt
+      ca myca=2Ecrt
 
 --daemon progname
   Become a =
daemon after all initialization functions are completed=2E
diff --git a/doc=
/man-sections/protocol-options=2Erst b/doc/man-sections/protocol-options=2E=
rst
index 52ce5a8=2E=2E9e14787 100644
--- a/doc/man-sections/protocol-optio=
ns=2Erst
+++ b/doc/man-sections/protocol-options=2Erst
@@ -44,12 +44,10 @@
=
   of the AEAD cipher is used instead=2E Note that ``alg`` still specifies
=
   the digest used for ``tls-auth``=2E
 
-  In static-key encryption mode, =
the HMAC key is included in the key file
-  generated by ``--genkey``=2E In=
 TLS mode, the HMAC key is dynamically
-  generated and shared between peer=
s via the TLS control channel=2E If
-  OpenVPN receives a packet with a bad=
 HMAC it will drop the packet=2E HMAC
-  usually adds 16 or 20 bytes per pa=
cket=2E Set ``alg=3Dnone`` to disable
-  authentication=2E
+  The HMAC key =
is dynamically generated and shared between peers via the
+  TLS control ch=
annel=2E If OpenVPN receives a packet with a bad HMAC it
+  will drop the p=
acket=2E HMAC usually adds 16 or 20 bytes per packet=2E Set
+  ``alg=3Dnone=
`` to disable authentication=2E
 
   For more information on HMAC see
   ht=
tps://tools=2Eietf=2Eorg/html/rfc2104
@@ -212,11 +210,6 @@
   have been con=
figured with ``--enable-small``
   (typically used on routers or other embe=
dded devices)=2E
 
-
---allow-deprecated-insecure-static-crypto
-   **DEPRE=
CATED** This allow using OpenVPN without TLS=2E This is deprecated
-   and =
will be removed in OpenVPN 2=2E8=2E
-
 --tran-window n
   Transition window=
 -- our old key can live this many seconds after a new
   a key renegotiati=
on begins (default :code:`3600` seconds)=2E This feature
diff --git a/doc/m=
an-sections/unsupported-options=2Erst b/doc/man-sections/unsupported-option=
s=2Erst
index c273905=2E=2E2794f12 100644
--- a/doc/man-sections/unsupporte=
d-options=2Erst
+++ b/doc/man-sections/unsupported-options=2Erst
@@ -70,3 +=
70,12 @@
   Removed in OpenVPN 2=2E8=2E This option caused the Mbed TLS 3 r=
andom number
   generator to be reseeded on every call=2E It has been remov=
ed because this
   is excessive=2E
+
+--secret
+  Removed in OpenVPN 2=2E8=
=2E Static encryption without a transient key
+  (generated by DH or ECDH) =
has been considered problematic for many
+  years=2E Please use ``--peer-fi=
ngerprint`` and self-signed certificates
+  for small setups=2E
+
+--allow-=
deprecated-insecure-static-crypto
+  Removed in OpenVPN 2=2E8 as --secret w=
as also removed=2E
diff --git a/doc/openvpn=2E8=2Erst b/doc/openvpn=2E8=2Er=
st
index 65130b1=2E=2E2ca9b62 100644
--- a/doc/openvpn=2E8=2Erst
+++ b/doc/=
openvpn=2E8=2Erst
@@ -48,10 +48,8 @@
 OpenVPN is tightly bound to the OpenS=
SL library, and derives much of its
 crypto capabilities from it=2E
 
-Open=
VPN supports conventional encryption using a pre-shared secret key
-**(Stat=
ic Key mode)** or public key security **(SSL/TLS mode)** using
-client & se=
rver certificates=2E OpenVPN also supports non-encrypted
-TCP/UDP tunnels=
=2E
+OpenVPN supports conventional encryption using public key security
+wi=
th TLS **(SSL/TLS mode)** using client & server certificates=2E
 
 OpenVPN =
is designed to work with the **TUN/TAP** virtual networking
 interface that=
 exists on most platforms=2E
diff --git a/src/openvpn/check_file_access=2Ec=
 b/src/openvpn/check_file_access=2Ec
index 25d7f90=2E=2Eab2535d 100644
--- =
a/src/openvpn/check_file_access=2Ec
+++ b/src/openvpn/check_file_access=2Ec=

@@ -312,10 +312,6 @@
                                          ce->tls_cry=
pt_v2_file, R_OK, "--tls-crypt-v2");
     }
 
-    errs |=3D
-        check=
_file_access_inline(options->shared_secret_file_inline, CHKACC_FILE | CHKAC=
C_PRIVATE,
-                                 options->shared_secret_file, R=
_OK, "--secret");
-
     errs |=3D check_file_access(CHKACC_DIRPATH | CHKAC=
C_FILEXSTWR, options->packet_id_file,
                               R_OK |=
 W_OK, "--replay-persist");
 
diff --git a/src/openvpn/crypto=2Ec b/src/ope=
nvpn/crypto=2Ec
index f5e5904=2E=2Ea8ad7f0 100644
--- a/src/openvpn/crypto=
=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -872,7 +872,7 @@
  * Build a struct ke=
y_type=2E
  */
 void
-init_key_type(struct key_type *kt, const char *cipher=
name, const char *authname, bool tls_mode,
+init_key_type(struct key_type *=
kt, const char *ciphername, const char *authname,
               bool warn)=

 {
     bool aead_cipher =3D false;
@@ -891,9 +891,9 @@
 
         /* chec=
k legal cipher mode */
         aead_cipher =3D cipher_kt_mode_aead(kt->cip=
her);
-        if (!(cipher_kt_mode_cbc(kt->cipher) || (tls_mode && aead_ci=
pher)
+        if (!(cipher_kt_mode_cbc(kt->cipher) || aead_cipher
 #ifdef =
ENABLE_OFB_CFB_MODE
-              || (tls_mode && cipher_kt_mode_ofb_cfb(k=
t->cipher))
+              || cipher_kt_mode_ofb_cfb(kt->cipher)
 #endif
  =
                 ))
         {
diff --git a/src/openvpn/crypto=2Eh b/src/op=
envpn/crypto=2Eh
index dbe0802=2E=2E5212e17 100644
--- a/src/openvpn/crypto=
=2Eh
+++ b/src/openvpn/crypto=2Eh
@@ -59,14 +59,11 @@
  *
  * @par
  * <b>C=
BC data channel cypto format</b> \n
- * In CBC mode, both TLS-mode and stat=
ic key mode are supported=2E The IV
- * consists of random bits to provide =
unpredictable IVs=2E \n
+ * The IV consists of random bits to provide unpre=
dictable IVs=2E \n
  * <i>CBC IV format:</i> \n
  * <tt> [ - random - ] </t=
t> \n
  * <i>CBC data channel crypto format in TLS-mode:</i> \n
  * <tt> [ =
HMAC ] [ - IV - ] [ * packet ID * ] [ * packet payload * ] </tt> \n
- * <i>=
CBC data channel crypto format in static key mode:</i> \n
- * <tt> [ HMAC ]=
 [ - IV - ] [ * packet ID * ] [ * timestamp * ]
  * [ * packet payload * ] =
</tt>
  *
  * @par
@@ -113,10 +110,7 @@
  * static key mode are supported=
=2E No encryption will be performed on the packet,
  * but packets can stil=
l be authenticated=2E This mode does not require an IV=2E\n
  * <i>No-crypt=
o data channel crypto format in TLS-mode:</i> \n
- * <tt> [ HMAC ] [ - pack=
et ID - ] [ - packet payload - ] </tt> \n
- * <i>No-crypto data channel cry=
pto format in static key mode:</i> \n
- * <tt> [ HMAC ] [ - packet ID - ] [=
 - timestamp - ] [ - packet payload - ] </tt>
- *
+ * <tt> [ HMAC ] [ - pac=
ket ID - ] [ - packet payload - ] </tt> \n *
  */
 
 #ifndef CRYPTO_H
@@ -4=
20,11 +414,9 @@
  * @param kt          The struct key_type to initialize
  =
* @param ciphername  The name of the cipher to use
  * @param authname    T=
he name of the HMAC digest to use
- * @param tls_mode    Specifies whether =
we are running in TLS mode, which allows
- *                    more cipher=
s than static key mode=2E
  * @param warn        Print warnings when null c=
ipher / auth is used=2E
  */
-void init_key_type(struct key_type *kt, const=
 char *ciphername, const char *authname, bool tls_mode,
+void init_key_type=
(struct key_type *kt, const char *ciphername, const char *authname,
       =
             bool warn);
 
 /*
diff --git a/src/openvpn/crypto_mbedtls=2Ec =
b/src/openvpn/crypto_mbedtls=2Ec
index 0ea2375=2E=2E3dc12f8 100644
--- a/sr=
c/openvpn/crypto_mbedtls=2Ec
+++ b/src/openvpn/crypto_mbedtls=2Ec
@@ -1013,=
8 +1013,7 @@
     printf("The following ciphers and cipher modes are availa=
ble for use\n"
            "with " PACKAGE_NAME "=2E  Each cipher shown bel=
ow may be used as a\n"
            "parameter to the --data-ciphers (or --c=
ipher) option=2E  Using a\n"
-           "GCM or CBC mode is recommended=2E=
  In static key mode only CBC\n"
-           "mode is allowed=2E\n\n");
+  =
         "GCM or CBC mode is recommended=2E \n\n");
 #endif
 
     for (siz=
e_t i =3D 0; i < cipher_info_table_entries; i++)
diff --git a/src/openvpn/h=
elper=2Ec b/src/openvpn/helper=2Ec
index d29895b=2E=2E6b5fcee6 100644
--- a=
/src/openvpn/helper=2Ec
+++ b/src/openvpn/helper=2Ec
@@ -266,12 +266,6 @@
 =
            msg(M_USAGE, "--server and --server-bridge cannot be used toget=
her");
         }
 
-        if (o->shared_secret_file)
-        {
-       =
     msg(M_USAGE,
-                "--server and --secret cannot be used to=
gether (you must use SSL/TLS keys)");
-        }
-
         if (!(o->server=
_flags & SF_NOPOOL) && o->ifconfig_pool_defined)
         {
             ms=
g(M_USAGE,
@@ -461,12 +455,6 @@
                 "--server-bridge already d=
efines an ifconfig-pool, so you can't also specify --ifconfig-pool explicit=
ly");
         }
 
-        if (o->shared_secret_file)
-        {
-        =
    msg(M_USAGE,
-                "--server-bridge and --secret cannot be u=
sed together (you must use SSL/TLS keys)");
-        }
-
         if (dev !=
=3D DEV_TYPE_TAP)
         {
             msg(M_USAGE, "--server-bridge dir=
ective only makes sense with --dev tap");
diff --git a/src/openvpn/init=2Ec=
 b/src/openvpn/init=2Ec
index ff3bfe5=2E=2Ec4b6483 100644
--- a/src/openvpn=
/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -1001,35 +1001,10 @@
         platf=
orm_mlockall(true);
     }
 
-    /*
-     * We do not want user to use --g=
enkey with --secret=2E In the transistion
-     * phase we for secret=2E
- =
    */
-    if (options->genkey && options->genkey_type !=3D GENKEY_SECRET =
&& options->shared_secret_file)
-    {
-        msg(M_USAGE, "Using --genke=
y type with --secret filename is "
-                     "not supported=2E =
 Use --genkey type filename instead=2E");
-    }
     if (options->genkey &=
& options->genkey_type =3D=3D GENKEY_SECRET)
     {
         int nbits_writ=
ten;
         const char *genkey_filename =3D options->genkey_filename;
-  =
      if (options->shared_secret_file && options->genkey_filename)
-       =
 {
-            msg(M_USAGE, "You must provide a filename to either --genke=
y "
-                         "or --secret, not both");
-        }
-
-     =
   /*
-         * Copy filename from shared_secret_file to genkey_filename =
to support
-         * the old --genkey --secret foo=2Efile syntax=2E
-    =
     */
-        if (options->shared_secret_file)
-        {
-            m=
sg(M_WARN, "WARNING: Using --genkey --secret filename is "
-               =
         "DEPRECATED=2E  Use --genkey secret filename instead=2E");
-      =
      genkey_filename =3D options->shared_secret_file;
-        }
 
       =
  nbits_written =3D write_key_file(2, genkey_filename);
         if (nbits_=
written < 0)
@@ -1038,7 +1013,7 @@
         }
 
         msg(D_GENKEY | M_N=
OPREFIX, "Randomly generated %d bit key written to %s", nbits_written,
-   =
         options->shared_secret_file);
+            options->genkey_filenam=
e ? options->genkey_filename : "stdout");
         return true;
     }
    =
 else if (options->genkey && options->genkey_type =3D=3D GENKEY_TLS_CRYPTV2=
_SERVER)
@@ -1084,7 +1059,7 @@
     /* sanity check on options for --mktun =
or --rmtun */
     notnull(options->dev, "TUN/TAP device (--dev)");
     if=
 (options->ce=2Eremote || options->ifconfig_local || options->ifconfig_remo=
te_netmask
-        || options->shared_secret_file || options->tls_server |=
| options->tls_client)
+        || options->tls_server || options->tls_clie=
nt)
     {
         msg(M_FATAL | M_OPTERR,
             "options --mktun o=
r --rmtun should only be used together with --dev");
@@ -3040,8 +3015,7 @@
=
     ASSERT(!key_ctx_bi_defined(&c->c1=2Eks=2Estatic_key));
 
     /* Init =
cipher and hash algorithm */
-    init_key_type(&c->c1=2Eks=2Ekey_type, opt=
ions->ciphername, options->authname,
-                  options->test_crypt=
o, true);
+    init_key_type(&c->c1=2Eks=2Ekey_type, options->ciphername, o=
ptions->authname, true);
 
     generate_test_crypto_random_key(&c->c1=2Eks=
=2Ekey_type, &c->c1=2Eks=2Estatic_key,
                                    =
 "test crypto key");
@@ -3051,50 +3025,6 @@
 }
 
 /*
- * Static Key Mode (u=
sing a pre-shared key)
- */
-static void
-do_init_crypto_static(struct cont=
ext *c, const unsigned int flags)
-{
-    const struct options *options =3D=
 &c->options;
-    ASSERT(options->shared_secret_file);
-
-    init_crypto_=
pre(c, flags);
-
-    /* Initialize flags */
-    if (c->options=2Emute_rep=
lay_warnings)
-    {
-        c->c2=2Ecrypto_options=2Eflags |=3D CO_MUTE_R=
EPLAY_WARNINGS;
-    }
-
-    /* Initialize packet ID tracking */
-    pack=
et_id_init(&c->c2=2Ecrypto_options=2Epacket_id, options->replay_window, opt=
ions->replay_time,
-                   "STATIC", 0);
-    c->c2=2Ecrypto_op=
tions=2Epid_persist =3D &c->c1=2Epid_persist;
-    c->c2=2Ecrypto_options=
=2Eflags |=3D CO_PACKET_ID_LONG_FORM;
-    packet_id_persist_load_obj(&c->c=
1=2Epid_persist, &c->c2=2Ecrypto_options=2Epacket_id);
-
-    if (!key_ctx_=
bi_defined(&c->c1=2Eks=2Estatic_key))
-    {
-        /* Get cipher & hash =
algorithms */
-        init_key_type(&c->c1=2Eks=2Ekey_type, options->ciphe=
rname, options->authname,
-                      options->test_crypto, true=
);
-
-        /* Read cipher and hmac keys from shared secret file */
-    =
    crypto_read_openvpn_key(&c->c1=2Eks=2Ekey_type, &c->c1=2Eks=2Estatic_ke=
y,
-                                options->shared_secret_file, options->s=
hared_secret_file_inline,
-                                options->key_dir=
ection, "Static Key Encryption", "secret", NULL);
-    }
-    else
-    {
-=
        msg(M_INFO, "Re-using pre-shared static key");
-    }
-
-    /* Get=
 key schedule */
-    c->c2=2Ecrypto_options=2Ekey_ctx_bi =3D c->c1=2Eks=2E=
static_key;
-}
-
-/*
  * Initialize the tls-auth/crypt key context
  */
 st=
atic void
@@ -3233,7 +3163,7 @@
 
         /* Do not warn if the cipher is =
used only in OCC */
         bool warn =3D options->enable_ncp_fallback;
- =
       init_key_type(&c->c1=2Eks=2Ekey_type, ciphername, options->authname,=
 true, warn);
+        init_key_type(&c->c1=2Eks=2Ekey_type, ciphername, op=
tions->authname, warn);
 
         /* initialize tls-auth/crypt/crypt-v2 ke=
y */
         do_init_tls_wrap_key(c);
@@ -3522,41 +3452,6 @@
     }
 }
 
-=
/*
- * No encryption or authentication=2E
- */
-static void
-do_init_crypto=
_none(struct context *c)
-{
-    ASSERT(!c->options=2Etest_crypto);
-
-    =
/* Initialise key_type with auth/cipher "none", so the key_type struct is
-=
     * valid */
-    init_key_type(&c->c1=2Eks=2Ekey_type, "none", "none", =
c->options=2Etest_crypto, true);
-
-    msg(M_WARN, "******* WARNING ******=
*: All encryption and authentication features "
-                "disabled =
-- All data will be tunnelled as clear text and will not be "
-            =
    "protected against man-in-the-middle changes=2E "
-                "PLE=
ASE DO RECONSIDER THIS CONFIGURATION!");
-}
-
-static void
-do_init_crypto(=
struct context *c, const unsigned int flags)
-{
-    if (c->options=2Eshare=
d_secret_file)
-    {
-        do_init_crypto_static(c, flags);
-    }
-   =
 else if (c->options=2Etls_server || c->options=2Etls_client)
-    {
-     =
   do_init_crypto_tls(c, flags);
-    }
-    else /* no encryption or authe=
ntication=2E */
-    {
-        do_init_crypto_none(c);
-    }
-}
-
 static=
 void
 do_init_frame(struct context *c)
 {
@@ -4613,7 +4508,7 @@
         {=

             crypto_flags =3D CF_INIT_TLS_MULTI;
         }
-        do_in=
it_crypto(c, crypto_flags);
+        do_init_crypto_tls(c, crypto_flags);
 =
        if (IS_SIG(c) && !child)
         {
             goto sig;
diff --g=
it a/src/openvpn/mtu=2Ec b/src/openvpn/mtu=2Ec
index f3c2874=2E=2E5ce40c8 1=
00644
--- a/src/openvpn/mtu=2Ec
+++ b/src/openvpn/mtu=2Ec
@@ -51,7 +51,6 @@=

 unsigned int
 calc_packet_id_size_dc(const struct options *options, const=
 struct key_type *kt)
 {
-    bool tlsmode =3D options->tls_server || optio=
ns->tls_client;
     bool epoch =3D options->imported_protocol_flags & CO_E=
POCH_DATA_KEY_FORMAT;
 
     /* epoch format uses a 64-bit packet id: 16 bi=
t epoch + 48 bit per-epoch counter */
@@ -60,7 +59,7 @@
         return siz=
eof(uint64_t);
     }
 
-    bool packet_id_long_form =3D !tlsmode || ciphe=
r_kt_mode_ofb_cfb(kt->cipher);
+    bool packet_id_long_form =3D cipher_kt_=
mode_ofb_cfb(kt->cipher);
 
     return packet_id_size(packet_id_long_form)=
;
 }
@@ -72,8 +71,6 @@
     /* Sum of all the overhead that reduces the usa=
ble packet size */
     size_t header_size =3D 0;
 
-    bool tlsmode =3D o=
ptions->tls_server || options->tls_client;
-
     /* A socks proxy adds ext=
ra header to each packet
      * (we only support Socks with IPv4, this val=
ue is different for IPv6) */
     if (options->ce=2Esocks_proxy_server && p=
roto_is_udp(options->ce=2Eproto))
@@ -88,10 +85,7 @@
     }
 
     /* Add t=
he opcode and peerid */
-    if (tlsmode)
-    {
-        header_size +=3D =
options->use_peer_id ? 4 : 1;
-    }
+    header_size +=3D options->use_pee=
r_id ? 4 : 1;
 
     unsigned int pkt_id_size =3D calc_packet_id_size_dc(op=
tions, kt);
 
@@ -156,13 +150,6 @@
 {
     struct key_type occ_kt;
 
-    /=
* neither --secret nor TLS mode */
-    if (!o->tls_client && !o->tls_serve=
r && !o->shared_secret_file)
-    {
-        init_key_type(&occ_kt, "none",=
 "none", false, false);
-        return frame_calculate_payload_size(frame,=
 o, &occ_kt);
-    }
-
     /* o->ciphername might be BF-CBC even though th=
e underlying SSL library
      * does not support it=2E For this reason we =
workaround this corner case
      * by pretending to have no encryption ena=
bled and by manually adding
@@ -184,9 +171,7 @@
         ciphername =3D "no=
ne";
     }
 
-    /* We pass tlsmode always true here since as we do not n=
eed to check if
-     * the ciphers are actually valid for non tls in occ c=
alucation */
-    init_key_type(&occ_kt, ciphername, o->authname, true, fal=
se);
+    init_key_type(&occ_kt, ciphername, o->authname, false);
 
     si=
ze_t payload =3D frame_calculate_payload_size(frame, o, &occ_kt);
     over=
head +=3D frame_calculate_protocol_header_size(&occ_kt, o, true);
diff --gi=
t a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 4dfc719=2E=2E45=
4d2d6 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@=
 -558,14 +558,11 @@
     "                  server/remote=2E n =3D # of ret=
ries, default=3D1=2E\n"
     "\n"
     "Data Channel Encryption Options (mu=
st be compatible between peers):\n"
-    "(These options are meaningful for=
 both Static Key & TLS-mode)\n"
     "--auth alg      : Authenticate packet=
s with HMAC using message\n"
     "                  digest algorithm alg (=
default=3D%s)=2E\n"
     "                  (usually adds 16 or 20 bytes pe=
r packet)\n"
     "                  Set alg=3Dnone to disable authenticati=
on=2E\n"
-    "--cipher alg    : Encrypt packets with cipher algorithm alg=
=2E\n"
-    "                  You should usually use --data-ciphers instea=
d=2E\n"
-    "                  Set alg=3Dnone to disable encryption=2E\n"
=
+    "--cipher alg    : Ignored=2E You should usually use --data-ciphers in=
stead=2E\n"
     "--data-ciphers list : List of ciphers that are allowed to=
 be negotiated=2E\n"
 #ifndef ENABLE_CRYPTO_MBEDTLS
     "--engine [name] :=
 Enable OpenSSL hardware crypto engine functionality=2E\n"
@@ -1588,16 +158=
5,17 @@
 static void
 options_postprocess_verify_ce(const struct options *o=
ptions, const struct connection_entry *ce)
 {
+    if (options->test_crypto=
)
+    {
+        return;
+    }
     struct options defaults;
     int dev=
 =3D DEV_TYPE_UNDEF;
     bool pull =3D false;
 
     init_options(&default=
s);
 
-    if (!options->test_crypto)
-    {
-        notnull(options->dev,=
 "TUN/TAP device (--dev)");
-    }
+    notnull(options->dev, "TUN/TAP devi=
ce (--dev)");
 
     /*
      * Get tun/tap/null device type
@@ -2013,27 +2=
011,9 @@
     /*
      * SSL/TLS mode sanity checks=2E
      */
-    if (op=
tions->tls_server + options->tls_client + (options->shared_secret_file !=3D=
 NULL) > 1)
+    if (options->tls_server =3D=3D options->tls_client)
     {=

-        msg(M_USAGE, "specify only one of --tls-server, --tls-client, or =
--secret");
-    }
-
-    if (!options->tls_server && !options->tls_client =
&& !options->test_crypto)
-    {
-        msglvl_t msglevel =3D M_USAGE;
- =
       if (options->allow_deprecated_insecure_static_crypto)
-        {
-  =
          msglevel =3D M_INFO;
-        }
-
-        msg(msglevel, "DEPRECA=
TION: No tls-client or tls-server option in "
-                      "confi=
guration detected=2E OpenVPN 2=2E8 will remove the "
-                     =
 "functionality to run a VPN without TLS=2E "
-                      "See t=
he examples section in the manual page for "
-                      "exampl=
es of a similar quick setup with peer-fingerprint=2E "
-                   =
   "OpenVPN 2=2E7 allows using this configuration when using "
-           =
           "--allow-deprecated-insecure-static-crypto but you should move "=

-                      "to a proper configuration using TLS as soon as pos=
sible=2E");
+        msg(M_USAGE, "OpenVPN configuration must use either --=
tls-server or --tls-client");
     }
 
     if (options->ssl_flags & (SSLF_=
CLIENT_CERT_NOT_REQUIRED | SSLF_CLIENT_CERT_OPTIONAL))
@@ -2053,188 +2033,1=
35 @@
         msg(M_USAGE, "--tls-version-min bigger than --tls-version-ma=
x");
     }
 
-    if (options->tls_server || options->tls_client)
-    {
-=
        check_ca_required(options);
+    check_ca_required(options);
 #ifde=
f ENABLE_PKCS11
-        if (!options->pkcs11_providers[0] && options->pkcs=
11_id)
-        {
-            msg(M_WARN, "Option pkcs11-id is ignored as =
no pkcs11-providers are specified");
-        }
-        else if (!options-=
>pkcs11_providers[0] && options->pkcs11_id_management)
-        {
-        =
    msg(M_WARN,
-                "Option pkcs11-id-management is ignored as=
 no pkcs11-providers are specified");
-        }
+    if (!options->pkcs11_=
providers[0] && options->pkcs11_id)
+    {
+        msg(M_WARN, "Option pkc=
s11-id is ignored as no pkcs11-providers are specified");
+    }
+    else =
if (!options->pkcs11_providers[0] && options->pkcs11_id_management)
+    {
=
+        msg(M_WARN,
+            "Option pkcs11-id-management is ignored a=
s no pkcs11-providers are specified");
+    }
 
-        if (options->pkcs1=
1_providers[0])
-        {
-            if (options->pkcs11_id_management &=
& options->pkcs11_id !=3D NULL)
-            {
-                msg(M_USAGE=
,
-                    "Parameter --pkcs11-id cannot be used when --pkcs11-=
id-management is also specified=2E");
-            }
-            if (!opti=
ons->pkcs11_id_management && options->pkcs11_id =3D=3D NULL)
-            {=

-                msg(M_USAGE,
-                    "Parameter --pkcs11-id =
or --pkcs11-id-management should be specified=2E");
-            }
-       =
     const char use_err[] =3D
-                "Parameter --%s cannot be us=
ed when --pkcs11-provider is also specified=2E";
-            MUST_BE_UNDEF=
(cert_file, "cert");
-            MUST_BE_UNDEF(priv_key_file, "key");
-   =
         MUST_BE_UNDEF(pkcs12_file, "pkcs12");
-            MUST_BE_FALSE(o=
ptions->management_flags & MF_EXTERNAL_KEY, "management-external-key");
-  =
          MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_CERT, "mana=
gement-external-cert");
-#ifdef ENABLE_CRYPTOAPI
-            MUST_BE_UNDEF=
(cryptoapi_cert, "cryptoapicert");
-#endif
-        }
-        else
-#endif=
 /* ifdef ENABLE_PKCS11 */
-#ifdef ENABLE_CRYPTOAPI
-            if (option=
s->cryptoapi_cert)
-        {
-            const char use_err[] =3D
-      =
          "Parameter --%s cannot be used when --cryptoapicert is also speci=
fied=2E";
-            MUST_BE_UNDEF(cert_file, "cert");
-            MUST_=
BE_UNDEF(priv_key_file, "key");
-            MUST_BE_UNDEF(pkcs12_file, "pk=
cs12");
-            MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_=
KEY, "management-external-key");
-            MUST_BE_FALSE(options->manage=
ment_flags & MF_EXTERNAL_CERT, "management-external-cert");
-        }
-   =
     else
-#endif
-            if (options->pkcs12_file)
-        {
-#ifdef=
 ENABLE_CRYPTO_MBEDTLS
-            msg(M_USAGE, "Parameter --pkcs12 cannot=
 be used with the mbed TLS version of OpenVPN=2E");
-#else
-            con=
st char use_err[] =3D "Parameter --%s cannot be used when --pkcs12 is also =
specified=2E";
-            MUST_BE_UNDEF(ca_path, "capath");
-            =
MUST_BE_UNDEF(cert_file, "cert");
-            MUST_BE_UNDEF(priv_key_file,=
 "key");
-            MUST_BE_FALSE(options->management_flags & MF_EXTERNAL=
_KEY, "management-external-key");
-            MUST_BE_FALSE(options->manag=
ement_flags & MF_EXTERNAL_CERT, "management-external-cert");
-#endif       =
/* ifdef ENABLE_CRYPTO_MBEDTLS */
-        }
-        else /* cert/key from=
 none of pkcs11, pkcs12, cryptoapi */
-        {
-            if ((options-=
>management_flags & MF_EXTERNAL_KEY) && options->priv_key_file)
-          =
  {
-                msg(M_USAGE, "--key and --management-external-key are =
mutually exclusive");
-            }
-            if ((options->management_=
flags & MF_EXTERNAL_CERT))
-            {
-                if (options->cer=
t_file)
-                {
-                    msg(M_USAGE, "--cert and --=
management-external-cert are mutually exclusive");
-                }
-    =
            else if (!(options->management_flags & MF_EXTERNAL_KEY))
-     =
           {
-                    msg(M_USAGE,
-                        "--=
management-external-cert must be used with --management-external-key");
-  =
              }
-            }
-            if (pull)
-            {
-     =
           const int sum =3D
-                    ((options->cert_file !=3D=
 NULL) || (options->management_flags & MF_EXTERNAL_CERT))
-                =
    + ((options->priv_key_file !=3D NULL)
-                       || (optio=
ns->management_flags & MF_EXTERNAL_KEY));
-
-                if (sum =3D=3D=
 0)
-                {
-                    if (!options->auth_user_pass_fi=
le)
-                    {
-                        msg(M_USAGE, "No client=
-side authentication method is "
-                                     "spe=
cified=2E  You must use either "
-                                     "--c=
ert/--key, --pkcs12, or "
-                                     "--auth-use=
r-pass");
-                    }
-                }
-                else i=
f (sum !=3D 2)
-                {
-                    msg(M_USAGE, "If you=
 use one of --cert or --key, you must use them both");
-                }
-=
            }
-            else
-            {
-                if (!(optio=
ns->management_flags & MF_EXTERNAL_CERT))
-                {
-             =
       notnull(options->cert_file,
-                            "certificat=
e file (--cert) or PKCS#12 file (--pkcs12)");
-                }
-         =
       if (!(options->management_flags & MF_EXTERNAL_KEY))
-               =
 {
-                    notnull(options->priv_key_file,
-                  =
          "private key file (--key) or PKCS#12 file (--pkcs12)");
-        =
        }
-            }
-        }
-        if (ce->tls_auth_file && ce->t=
ls_crypt_file)
-        {
-            msg(M_USAGE, "--tls-auth and --tls-c=
rypt are mutually exclusive");
-        }
-        if (options->tls_client =
&& ce->tls_crypt_v2_file
-            && (ce->tls_auth_file || ce->tls_cryp=
t_file))
+    if (options->pkcs11_providers[0])
+    {
+        if (options=
->pkcs11_id_management && options->pkcs11_id !=3D NULL)
         {
        =
     msg(M_USAGE,
-                "--tls-crypt-v2, --tls-auth and --tls-cr=
ypt are mutually exclusive in client mode");
+                "Parameter --=
pkcs11-id cannot be used when --pkcs11-id-management is also specified=2E")=
;
         }
-    }
-    else
-    {
-        /*
-         * Make sure user=
 doesn't specify any TLS options
-         * when in non-TLS mode=2E
-     =
    */
-
-        const char use_err[] =3D "Parameter %s can only be specif=
ied in TLS-mode, "
-                               "i=2Ee=2E where --tls-se=
rver or --tls-client is also specified=2E";
-
-        MUST_BE_UNDEF(ca_fil=
e, "ca");
-        MUST_BE_UNDEF(ca_path, "capath");
-        MUST_BE_UNDEF=
(dh_file, "dh");
+        if (!options->pkcs11_id_management && options->pk=
cs11_id =3D=3D NULL)
+        {
+            msg(M_USAGE,
+                =
"Parameter --pkcs11-id or --pkcs11-id-management should be specified=2E");
=
+        }
+        const char use_err[] =3D
+            "Parameter --%s c=
annot be used when --pkcs11-provider is also specified=2E";
         MUST_B=
E_UNDEF(cert_file, "cert");
         MUST_BE_UNDEF(priv_key_file, "key");
-=
#ifndef ENABLE_CRYPTO_MBEDTLS
         MUST_BE_UNDEF(pkcs12_file, "pkcs12")=
;
+        MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_KEY, "mana=
gement-external-key");
+        MUST_BE_FALSE(options->management_flags & M=
F_EXTERNAL_CERT, "management-external-cert");
+#ifdef ENABLE_CRYPTOAPI
+   =
     MUST_BE_UNDEF(cryptoapi_cert, "cryptoapicert");
 #endif
-        MUST_=
BE_UNDEF(cipher_list, "tls-cipher");
-        MUST_BE_UNDEF(cipher_list_tls=
13, "tls-ciphersuites");
-        MUST_BE_UNDEF(tls_cert_profile, "tls-cert=
-profile");
-        MUST_BE_UNDEF(tls_verify, "tls-verify");
-        MUST=
_BE_UNDEF(tls_export_peer_cert_dir, "tls-export-cert");
-        MUST_BE_UN=
DEF(verify_x509_name, "verify-x509-name");
-        MUST_BE_UNDEF(tls_timeo=
ut, "tls-timeout");
-        MUST_BE_UNDEF(renegotiate_bytes, "reneg-bytes"=
);
-        MUST_BE_UNDEF(renegotiate_packets, "reneg-pkts");
-        MUST=
_BE_UNDEF(renegotiate_seconds, "reneg-sec");
-        MUST_BE_UNDEF(handsha=
ke_window, "hand-window");
-        MUST_BE_UNDEF(transition_window, "tran-=
window");
-        MUST_BE_UNDEF(tls_auth_file, "tls-auth");
-        MUST_=
BE_UNDEF(tls_crypt_file, "tls-crypt");
-        MUST_BE_UNDEF(tls_crypt_v2_=
file, "tls-crypt-v2");
-        MUST_BE_UNDEF(single_session, "single-sessi=
on");
-        MUST_BE_UNDEF(push_peer_info, "push-peer-info");
-        MU=
ST_BE_UNDEF(tls_exit, "tls-exit");
-        MUST_BE_UNDEF(crl_file, "crl-ve=
rify");
-        MUST_BE_UNDEF(ns_cert_type, "ns-cert-type");
-        MUST=
_BE_UNDEF(remote_cert_ku[0], "remote-cert-ku");
-        MUST_BE_UNDEF(remo=
te_cert_eku, "remote-cert-eku");
-#ifdef ENABLE_PKCS11
-        MUST_BE_UND=
EF(pkcs11_providers[0], "pkcs11-providers");
-        MUST_BE_UNDEF(pkcs11_=
private_mode[0], "pkcs11-private-mode");
-        MUST_BE_UNDEF(pkcs11_id, =
"pkcs11-id");
-        MUST_BE_UNDEF(pkcs11_id_management, "pkcs11-id-manag=
ement");
+    }
+    else
+#endif /* ifdef ENABLE_PKCS11 */
+#ifdef ENABLE_=
CRYPTOAPI
+        if (options->cryptoapi_cert)
+    {
+        const char =
use_err[] =3D
+            "Parameter --%s cannot be used when --cryptoapic=
ert is also specified=2E";
+        MUST_BE_UNDEF(cert_file, "cert");
+    =
    MUST_BE_UNDEF(priv_key_file, "key");
+        MUST_BE_UNDEF(pkcs12_file=
, "pkcs12");
+        MUST_BE_FALSE(options->management_flags & MF_EXTERNAL=
_KEY, "management-external-key");
+        MUST_BE_FALSE(options->managemen=
t_flags & MF_EXTERNAL_CERT, "management-external-cert");
+    }
+    else
 =
#endif
-
+        if (options->pkcs12_file)
+    {
+#ifdef ENABLE_CRYPTO_MB=
EDTLS
+        msg(M_USAGE, "Parameter --pkcs12 cannot be used with the mbe=
d TLS version of OpenVPN=2E");
+#else
+        const char use_err[] =3D "Pa=
rameter --%s cannot be used when --pkcs12 is also specified=2E";
+        M=
UST_BE_UNDEF(ca_path, "capath");
+        MUST_BE_UNDEF(cert_file, "cert");=

+        MUST_BE_UNDEF(priv_key_file, "key");
+        MUST_BE_FALSE(optio=
ns->management_flags & MF_EXTERNAL_KEY, "management-external-key");
+      =
  MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_CERT, "management-e=
xternal-cert");
+#endif   /* ifdef ENABLE_CRYPTO_MBEDTLS */
+    }
+    els=
e /* cert/key from none of pkcs11, pkcs12, cryptoapi */
+    {
+        if =
((options->management_flags & MF_EXTERNAL_KEY) && options->priv_key_file)
+=
        {
+            msg(M_USAGE, "--key and --management-external-key ar=
e mutually exclusive");
+        }
+        if ((options->management_flags =
& MF_EXTERNAL_CERT))
+        {
+            if (options->cert_file)
+     =
       {
+                msg(M_USAGE, "--cert and --management-external-ce=
rt are mutually exclusive");
+            }
+            else if (!(options=
->management_flags & MF_EXTERNAL_KEY))
+            {
+                msg(=
M_USAGE,
+                    "--management-external-cert must be used with=
 --management-external-key");
+            }
+        }
         if (pull)
=
         {
-            msg(M_USAGE, use_err, "--pull");
+            const=
 int sum =3D
+                ((options->cert_file !=3D NULL) || (options->=
management_flags & MF_EXTERNAL_CERT))
+                + ((options->priv_ke=
y_file !=3D NULL)
+                   || (options->management_flags & MF_EX=
TERNAL_KEY));
+
+            if (sum =3D=3D 0)
+            {
+            =
    if (!options->auth_user_pass_file)
+                {
+                =
    msg(M_USAGE, "No client-side authentication method is "
+              =
                   "specified=2E  You must use either "
+                  =
               "--cert/--key, --pkcs12, or "
+                             =
    "--auth-user-pass");
+                }
+            }
+            els=
e if (sum !=3D 2)
+            {
+                msg(M_USAGE, "If you use =
one of --cert or --key, you must use them both");
+            }
+        }=

+        else
+        {
+            if (!(options->management_flags & MF=
_EXTERNAL_CERT))
+            {
+                notnull(options->cert_file=
,
+                        "certificate file (--cert) or PKCS#12 file (--pk=
cs12)");
+            }
+            if (!(options->management_flags & MF_E=
XTERNAL_KEY))
+            {
+                notnull(options->priv_key_fil=
e,
+                        "private key file (--key) or PKCS#12 file (--pk=
cs12)");
+            }
         }
     }
+    if (ce->tls_auth_file && ce-=
>tls_crypt_file)
+    {
+        msg(M_USAGE, "--tls-auth and --tls-crypt a=
re mutually exclusive");
+    }
+    if (options->tls_client && ce->tls_cry=
pt_v2_file
+        && (ce->tls_auth_file || ce->tls_crypt_file))
+    {
+ =
       msg(M_USAGE,
+            "--tls-crypt-v2, --tls-auth and --tls-cryp=
t are mutually exclusive in client mode");
+    }
+
+
     if (options->aut=
h_user_pass_file && !options->pull)
     {
         msg(M_USAGE, "--auth-us=
er-pass requires --pull");
@@ -6960,32 +6887,6 @@
             goto err;
  =
       }
     }
-    else if (streq(p[0], "secret") && p[1] && !p[3])
-    =
{
-        msg(M_WARN, "DEPRECATED OPTION: The option --secret is deprecate=
d=2E");
-        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INLINE);
-        =
options->shared_secret_file =3D p[1];
-        options->shared_secret_file_=
inline =3D is_inline;
-        if (!is_inline && p[2])
-        {
-        =
    int key_direction;
-
-            key_direction =3D ascii2keydirection(=
msglevel, p[2]);
-            if (key_direction >=3D 0)
-            {
-   =
             options->key_direction =3D key_direction;
-            }
-    =
        else
-            {
-                goto err;
-            }
-    =
    }
-    }
-    else if (streq(p[0], "allow-deprecated-insecure-static-cr=
ypto"))
-    {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
-        options-=
>allow_deprecated_insecure_static_crypto =3D true;
-    }
     else if (str=
eq(p[0], "genkey") && !p[4])
     {
         VERIFY_PERMISSION(OPT_P_GENERA=
L);
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index 33=
b50b2=2E=2E38554a1 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/o=
ptions=2Eh
@@ -569,9 +569,6 @@
     struct static_challenge_info sc_info;
 =
#endif
     /* Cipher parms */
-    const char *shared_secret_file;
-    bo=
ol shared_secret_file_inline;
-    bool allow_deprecated_insecure_static_cr=
ypto;
     int key_direction;
     const char *ciphername;
     bool enable=
_ncp_fallback; /**< If defined fall back to
diff --git a/src/openvpn/option=
s_show=2Ec b/src/openvpn/options_show=2Ec
index 80d36f0=2E=2E321a37b 100644=

--- a/src/openvpn/options_show=2Ec
+++ b/src/openvpn/options_show=2Ec
@@ -=
491,7 +491,6 @@
     }
 #endif
 
-    SHOW_STR_INLINE(shared_secret_file);
=
     SHOW_PARM(key_direction, keydirection2ascii(o->key_direction, false, t=
rue), "%s");
     SHOW_STR(ciphername);
     SHOW_STR(ncp_ciphers);
diff --=
git a/src/openvpn/options_string=2Ec b/src/openvpn/options_string=2Ec
index=
 cfc0595=2E=2E2fd90dd 100644
--- a/src/openvpn/options_string=2Ec
+++ b/src=
/openvpn/options_string=2Ec
@@ -140,83 +140,72 @@
     /*
      * Crypto Op=
tions
      */
-    if (o->shared_secret_file || TLS_CLIENT || TLS_SERVER)
=
+    struct key_type kt;
+
+    ASSERT((TLS_CLIENT =3D=3D true) + (TLS_SERV=
ER =3D=3D true) <=3D 1);
+
+    /* Skip resolving BF-CBC to allow SSL libra=
ries without BF-CBC
+     * to work here in the default configuration */
+ =
   const char *ciphername =3D o->ciphername;
+    size_t keysize =3D 0;
+
+=
    if (strcmp(o->ciphername, "BF-CBC") =3D=3D 0)
     {
-        struct ke=
y_type kt;
-
-        ASSERT((o->shared_secret_file !=3D NULL) + (TLS_CLIEN=
T =3D=3D true) + (TLS_SERVER =3D=3D true) <=3D 1);
-
-        /* Skip resol=
ving BF-CBC to allow SSL libraries without BF-CBC
-         * to work here =
in the default configuration */
-        const char *ciphername =3D o->ciph=
ername;
-        size_t keysize =3D 0;
-
-        if (strcmp(o->ciphername,=
 "BF-CBC") =3D=3D 0)
+        init_key_type(&kt, "none", o->authname, false=
);
+        keysize =3D 128;
+    }
+    else
+    {
+        init_key_type=
(&kt, o->ciphername, o->authname, false);
+        ciphername =3D cipher_kt=
_name(kt=2Ecipher);
+        if (cipher_defined(o->ciphername))
         {
=
-            init_key_type(&kt, "none", o->authname, true, false);
-       =
     keysize =3D 128;
-        }
-        else
-        {
-            init=
_key_type(&kt, o->ciphername, o->authname, true, false);
-            ciphe=
rname =3D cipher_kt_name(kt=2Ecipher);
-            if (cipher_defined(o->c=
iphername))
-            {
-                keysize =3D cipher_kt_key_size(=
kt=2Ecipher) * 8;
-            }
-        }
-        /* Only announce the c=
ipher to our peer if we are willing to
-         * support it */
-        i=
f (p2p_nopull || tls_item_in_cipher_list(ciphername, o->ncp_ciphers))
-    =
    {
-            buf_printf(&out, ",cipher %s", ciphername);
-        }
-=
        buf_printf(&out, ",auth %s", md_kt_name(kt=2Edigest));
-        buf=
_printf(&out, ",keysize %zu", keysize);
-        if (o->shared_secret_file)=

-        {
-            buf_printf(&out, ",secret");
+            keysize =
=3D cipher_kt_key_size(kt=2Ecipher) * 8;
         }
     }
+    /* Only ann=
ounce the cipher to our peer if we are willing to
+     * support it */
+  =
  if (p2p_nopull || tls_item_in_cipher_list(ciphername, o->ncp_ciphers))
+ =
   {
+        buf_printf(&out, ",cipher %s", ciphername);
+    }
+    buf_p=
rintf(&out, ",auth %s", md_kt_name(kt=2Edigest));
+    buf_printf(&out, ",k=
eysize %zu", keysize);
 
     /*
      * SSL Options
      */
+    if (o->c=
e=2Etls_auth_file)
     {
-        if (TLS_CLIENT || TLS_SERVER)
-        {=

-            if (o->ce=2Etls_auth_file)
-            {
-                bu=
f_printf(&out, ",tls-auth");
-            }
-            /* Not adding tls-=
crypt here, because we won't reach this code if
-             * tls-auth/tl=
s-crypt does not match=2E  Removing tls-auth here would
-             * bre=
ak stuff, so leaving that in place=2E */
+        buf_printf(&out, ",tls-au=
th");
+    }
+    /* Not adding tls-crypt here, because we won't reach this=
 code if
+     * tls-auth/tls-crypt does not match=2E  Removing tls-auth he=
re would
+     * break stuff, so leaving that in place=2E */
 
-           =
 buf_printf(&out, ",key-method %d", KEY_METHOD_2);
-        }
+    buf_prin=
tf(&out, ",key-method %d", KEY_METHOD_2);
 
-        if (remote)
+
+    if =
(remote)
+    {
+        if (TLS_CLIENT)
         {
-            if (TLS_CL=
IENT)
-            {
-                buf_printf(&out, ",tls-server");
-   =
         }
-            else if (TLS_SERVER)
-            {
-              =
  buf_printf(&out, ",tls-client");
-            }
+            buf_printf(&=
out, ",tls-server");
         }
-        else
+        else if (TLS_SERVER)=

         {
-            if (TLS_CLIENT)
-            {
-                bu=
f_printf(&out, ",tls-client");
-            }
-            else if (TLS_SER=
VER)
-            {
-                buf_printf(&out, ",tls-server");
-    =
        }
+            buf_printf(&out, ",tls-client");
+        }
+    }
+=
    else
+    {
+        if (TLS_CLIENT)
+        {
+            buf_printf=
(&out, ",tls-client");
+        }
+        else if (TLS_SERVER)
+        {
=
+            buf_printf(&out, ",tls-server");
         }
     }
 
diff --gi=
t a/src/openvpn/options_string=2Eh b/src/openvpn/options_string=2Eh
index 0=
2efed3=2E=2E6d5518a 100644
--- a/src/openvpn/options_string=2Eh
+++ b/src/o=
penvpn/options_string=2Eh
@@ -59,7 +59,6 @@
  *
  * --cipher
  * --auth
- *=
 --secret
  *
  * SSL Options:
  *
diff --git a/src/openvpn/ssl=2Ec b/src/o=
penvpn/ssl=2Ec
index 420daef=2E=2Ea538b52 100644
--- a/src/openvpn/ssl=2Ec
=
+++ b/src/openvpn/ssl=2Ec
@@ -1648,7 +1648,7 @@
         return true;
     =
}
 
-    init_key_type(&session->opt->key_type, options->ciphername, option=
s->authname, true, true);
+    init_key_type(&session->opt->key_type, optio=
ns->ciphername, options->authname, true);
 
     bool packet_id_long_form =
=3D cipher_kt_mode_ofb_cfb(session->opt->key_type=2Ecipher);
     session->=
opt->crypto_flags &=3D ~(CO_PACKET_ID_LONG_FORM);
diff --git a/tests/unit_t=
ests/openvpn/test_crypto=2Ec b/tests/unit_tests/openvpn/test_crypto=2Ec
ind=
ex 07c54b4=2E=2Ef86aca8 100644
--- a/tests/unit_tests/openvpn/test_crypto=
=2Ec
+++ b/tests/unit_tests/openvpn/test_crypto=2Ec
@@ -237,70 +237,58 @@
 =
    /* common defaults */
     o=2Ece=2Etun_mtu =3D 1400;
     o=2Ece=2Epro=
to =3D PROTO_UDP;
+    o=2Etls_client =3D true;
+    o=2Epull =3D true;
 
-=
    /* No crypto at all */
+    /*  auth none, cipher none */
     o=2Eciph=
ername =3D "none";
     o=2Eauthname =3D "none";
     linkmtu =3D calc_opti=
ons_string_link_mtu(&o, &f);
-    assert_int_equal(linkmtu, 1400);
+    ass=
ert_int_equal(linkmtu, 1405);
 
-    /* Static key OCC examples */
-    o=
=2Eshared_secret_file =3D "not null";
-
-    /* secret, auth none, cipher n=
one */
-    o=2Eciphername =3D "none";
-    o=2Eauthname =3D "none";
-    l=
inkmtu =3D calc_options_string_link_mtu(&o, &f);
-    assert_int_equal(link=
mtu, 1408);
-
-    /* secret, cipher AES-128-CBC, auth none */
+    /* ciph=
er AES-128-CBC, auth none */
     o=2Eciphername =3D "AES-128-CBC";
     o=
=2Eauthname =3D "none";
     linkmtu =3D calc_options_string_link_mtu(&o, &=
f);
-    assert_int_equal(linkmtu, 1440);
+    assert_int_equal(linkmtu, 14=
37);
 
-    /* secret, cipher none, auth SHA256 */
+    /* cipher none, aut=
h SHA256 */
     o=2Eciphername =3D "none";
     o=2Eauthname =3D "SHA256";=

     linkmtu =3D calc_options_string_link_mtu(&o, &f);
-    assert_int_equ=
al(linkmtu, 1440);
+    assert_int_equal(linkmtu, 1437);
 
-    /* secret, =
cipher BF-CBC, auth SHA1 */
+    /* cipher BF-CBC, auth SHA1 */
     o=2Eci=
phername =3D "BF-CBC";
     o=2Eauthname =3D "SHA1";
     linkmtu =3D calc_=
options_string_link_mtu(&o, &f);
-    assert_int_equal(linkmtu, 1444);
+   =
 assert_int_equal(linkmtu, 1441);
 
-    /* secret, cipher BF-CBC, auth SHA=
1, tcp-client */
+    /* cipher BF-CBC, auth SHA1, tcp-client */
     o=2Ec=
e=2Eproto =3D PROTO_TCP_CLIENT;
     linkmtu =3D calc_options_string_link_m=
tu(&o, &f);
-    assert_int_equal(linkmtu, 1446);
+    assert_int_equal(lin=
kmtu, 1443);
 
     o=2Ece=2Eproto =3D PROTO_UDP;
 
 #if defined(USE_COMP)
=
     o=2Ecomp=2Ealg =3D COMP_ALG_LZO;
 
-    /* secret, comp-lzo yes, ciphe=
r BF-CBC, auth SHA1 */
+    /*  comp-lzo yes, cipher BF-CBC, auth SHA1 */
 =
    linkmtu =3D calc_options_string_link_mtu(&o, &f);
-    assert_int_equal=
(linkmtu, 1445);
+    assert_int_equal(linkmtu, 1442);
 
 #if defined(ENABL=
E_FRAGMENT)
-    /* secret, comp-lzo yes, cipher BF-CBC, auth SHA1, fragmen=
t 1200 */
+    /* comp-lzo yes, cipher BF-CBC, auth SHA1, fragment 1200 */
=
     o=2Ece=2Efragment =3D 1200;
     linkmtu =3D calc_options_string_link_=
mtu(&o, &f);
-    assert_int_equal(linkmtu, 1449);
+    assert_int_equal(li=
nkmtu, 1446);
     o=2Ece=2Efragment =3D 0;
 #endif
 
     o=2Ecomp=2Ealg =
=3D COMP_ALG_UNDEF;
 #endif
 
-    /* TLS mode */
-    o=2Eshared_secret_fi=
le =3D NULL;
-    o=2Etls_client =3D true;
-    o=2Epull =3D true;
-
     /=
* tls client, cipher AES-128-CBC, auth SHA1, tls-auth */
     o=2Eauthname =
=3D "SHA1";
     o=2Eciphername =3D "AES-128-CBC";
@@ -315,15 +303,8 @@
   =
  linkmtu =3D calc_options_string_link_mtu(&o, &f);
     assert_int_equal(l=
inkmtu, 1457);
 
-    /* tls client, cipher none, auth none */
+    /* tls =
client, auth none, cipher AES-256-GCM */
     o=2Eauthname =3D "none";
-   =
 o=2Eciphername =3D "none";
-
-    linkmtu =3D calc_options_string_link_mtu=
(&o, &f);
-    assert_int_equal(linkmtu, 1405);
-
-    /* tls client, auth =
SHA1, cipher AES-256-GCM */
-    o=2Eauthname =3D "SHA1";
     o=2Ecipherna=
me =3D "AES-256-GCM";
     linkmtu =3D calc_options_string_link_mtu(&o, &f)=
;
     assert_int_equal(linkmtu, 1449);
@@ -332,12 +313,12 @@
 #if defined(=
USE_COMP) && defined(ENABLE_FRAGMENT)
     o=2Ecomp=2Ealg =3D COMP_ALG_LZO;=

 
-    /* tls client, auth SHA1, cipher AES-256-GCM, fragment, comp-lzo ye=
s */
+    /* tls client, auth none, cipher AES-256-GCM, fragment, comp-lzo =
yes */
     o=2Ece=2Efragment =3D 1200;
     linkmtu =3D calc_options_strin=
g_link_mtu(&o, &f);
     assert_int_equal(linkmtu, 1454);
 
-    /* tls cli=
ent, auth SHA1, cipher AES-256-GCM, fragment, comp-lzo yes, socks */
+    /=
* tls client, auth none, cipher AES-256-GCM, fragment, comp-lzo yes, socks =
*/
     o=2Ece=2Esocks_proxy_server =3D "socks=2Eexample=2Ecom";
     linkm=
tu =3D calc_options_string_link_mtu(&o, &f);
     assert_int_equal(linkmtu,=
 1464);
@@ -358,50 +339,41 @@
     o=2Ece=2Etun_mtu =3D 1400;
     o=2Ece=
=2Emssfix =3D 1000;
     o=2Ece=2Eproto =3D PROTO_UDP;
+    o=2Etls_client =
=3D true;
 
-    /* No crypto at all */
+    /*auth none, cipher none */
  =
   o=2Eciphername =3D "none";
     o=2Eauthname =3D "none";
     struct key=
_type kt;
-    init_key_type(&kt, o=2Eciphername, o=2Eauthname, false, fals=
e);
+    init_key_type(&kt, o=2Eciphername, o=2Eauthname, false);
 
-    /*=
 No encryption, just packet id (8) + TCP payload(20) + IP payload(20) */
+ =
   /* No encryption, just packet id (4) + opcode (1) + TCP payload(20) + IP=
 payload(20) */
     frame_calculate_dynamic(&f, &kt, &o, NULL);
-    asser=
t_int_equal(f=2Emss_fix, 952);
+    assert_int_equal(f=2Emss_fix, 955);
 
-=
    /* Static key OCC examples */
-    o=2Eshared_secret_file =3D "not null=
";
-
-    /* secret, auth none, cipher none */
-    o=2Eciphername =3D "non=
e";
-    o=2Eauthname =3D "none";
-    init_key_type(&kt, o=2Eciphername, o=
=2Eauthname, false, false);
-    frame_calculate_dynamic(&f, &kt, &o, NULL)=
;
-    assert_int_equal(f=2Emss_fix, 952);
-
-    /* secret, cipher AES-128=
-CBC, auth none */
+    /* cipher AES-128-CBC, auth none */
     o=2Ecipher=
name =3D "AES-128-CBC";
     o=2Eauthname =3D "none";
-    init_key_type(&k=
t, o=2Eciphername, o=2Eauthname, false, false);
+    init_key_type(&kt, o=
=2Eciphername, o=2Eauthname, false);
 
-    for (int i =3D 990; i <=3D 1010=
; i++)
+    for (int i =3D 990; i <=3D 1015; i++)
     {
         /* 992 - =
1008 should end up with the same mssfix value all they
-         * all resu=
lt in the same CBC block size/padding and <=3D 991 and >=3D1008
+         *=
 all result in the same CBC block size/padding and <=3D 992 and >=3D1009
  =
        * should be one block less and more respectively */
         o=2Ece=
=2Emssfix =3D i;
         frame_calculate_dynamic(&f, &kt, &o, NULL);
-    =
    if (i <=3D 991)
+        if (i <=3D 992)
         {
-            assert=
_int_equal(f=2Emss_fix, 911);
+            assert_int_equal(f=2Emss_fix, 91=
5);
         }
-        else if (i >=3D 1008)
+        else if (i >=3D 1009=
)
         {
-            assert_int_equal(f=2Emss_fix, 943);
+            =
assert_int_equal(f=2Emss_fix, 947);
         }
         else
         {
-  =
          assert_int_equal(f=2Emss_fix, 927);
+            assert_int_equal=
(f=2Emss_fix, 931);
         }
     }
 #ifdef USE_COMP
@@ -410,36 +382,35 @=
@
     /* Same but with compression added=2E Compression adds one byte extr=
a to the
      * payload so the payload should be reduced by compared to th=
e no
      * compression calculation before */
-    for (int i =3D 990; i <=
=3D 1010; i++)
+    for (int i =3D 990; i <=3D 1015; i++)
     {
         /=
* 992 - 1008 should end up with the same mssfix value all they
-         * =
all result in the same CBC block size/padding and <=3D 991 and >=3D1008
+  =
       * all result in the same CBC block size/padding and <=3D 992 and >=
=3D1009
          * should be one block less and more respectively */
     =
    o=2Ece=2Emssfix =3D i;
         frame_calculate_dynamic(&f, &kt, &o, NU=
LL);
-        if (i <=3D 991)
+        if (i <=3D 992)
         {
-        =
    assert_int_equal(f=2Emss_fix, 910);
+            assert_int_equal(f=2Em=
ss_fix, 914);
         }
-        else if (i >=3D 1008)
+        else if (i=
 >=3D 1009)
         {
-            assert_int_equal(f=2Emss_fix, 942);
+  =
          assert_int_equal(f=2Emss_fix, 946);
         }
         else
    =
     {
-            assert_int_equal(f=2Emss_fix, 926);
+            assert=
_int_equal(f=2Emss_fix, 930);
         }
     }
     o=2Ecomp=2Ealg =3D COM=
P_ALG_UNDEF;
 #endif /* ifdef USE_COMP */
 
-    /* tls client, auth SHA1, =
cipher AES-256-GCM */
+    /*  auth SHA1, cipher AES-256-GCM */
     o=2Eau=
thname =3D "SHA1";
     o=2Eciphername =3D "AES-256-GCM";
-    o=2Etls_clie=
nt =3D true;
     o=2Epeer_id =3D 77;
     o=2Euse_peer_id =3D true;
-    i=
nit_key_type(&kt, o=2Eciphername, o=2Eauthname, true, false);
+    init_key=
_type(&kt, o=2Eciphername, o=2Eauthname, false);
 
     for (int i =3D 900;=
 i <=3D 1200; i++)
     {
@@ -685,7 +656,7 @@
 
     data->gc =3D gc_new();=

 
-    init_key_type(&data->kt, "AES-128-GCM", "none", true, false);
+    =
init_key_type(&data->kt, "AES-128-GCM", "none", false);
 
     /* have an e=
poch key that uses 0x23 for the key for all bytes */
     struct epoch_key =
epoch1send =3D { =2Eepoch =3D 1, =2Eepoch_key =3D { 0x23 } };
@@ -907,7 +87=
8,7 @@
     struct epoch_key e17 =3D { =2Eepoch =3D 17, =2Eepoch_key =3D { =
19, 12 } };
     struct key_type kt =3D { 0 };
     struct key_parameters k=
ey_parameters =3D { 0 };
-    init_key_type(&kt, "AES-192-GCM", "none", tru=
e, false);
+    init_key_type(&kt, "AES-192-GCM", "none", false);
 
 
     =
epoch_data_key_derive(&key_parameters, &e17, &kt);
diff --git a/tests/unit_=
tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec
index fb=
bb40f=2E=2E49ba833 100644
--- a/tests/unit_tests/openvpn/test_pkt=2Ec
+++ b=
/tests/unit_tests/openvpn/test_pkt=2Ec
@@ -173,7 +173,7 @@
     tas=2Etls_w=
rap=2Eopt=2Eflags |=3D (CO_IGNORE_PACKET_ID | CO_PACKET_ID_LONG_FORM);
 
  =
   struct key_type tls_crypt_kt;
-    init_key_type(&tls_crypt_kt, "none", =
"SHA1", true, false);
+    init_key_type(&tls_crypt_kt, "none", "SHA1", fal=
se);
 
     crypto_read_openvpn_key(&tls_crypt_kt, &tas=2Etls_wrap=2Eopt=2E=
key_ctx_bi, static_key, true,
                             key_direction, "=
Control Channel Authentication", "tls-auth", NULL);

-- 
To view, visit htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f=
368
Gerrit-Change-Number: 2081
Gerrit-PatchSet: 7
Gerrit-Owner: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@li=
chtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichten=
held <frank@lichtenheld=2Ecom>

--BtF+1rhSrMc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Arne Schwabe <strong>uploaded patch set #7</strong> to this cha=
nge=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=
=3Demail">View Change</a></p><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">Remove support for --secret<br><=
br>This has been announced for a long time and good alternatives exist=2E<b=
r><br>Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368<br>Signed-off-by=
: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M Changes=2Emd<br>M INS=
TALL<br>M doc/man-sections/generic-options=2Erst<br>M doc/man-sections/prot=
ocol-options=2Erst<br>M doc/man-sections/unsupported-options=2Erst<br>M doc=
/openvpn=2E8=2Erst<br>M src/openvpn/check_file_access=2Ec<br>M src/openvpn/=
crypto=2Ec<br>M src/openvpn/crypto=2Eh<br>M src/openvpn/crypto_mbedtls=2Ec<=
br>M src/openvpn/helper=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/mtu=
=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/ope=
nvpn/options_show=2Ec<br>M src/openvpn/options_string=2Ec<br>M src/openvpn/=
options_string=2Eh<br>M src/openvpn/ssl=2Ec<br>M tests/unit_tests/openvpn/t=
est_crypto=2Ec<br>M tests/unit_tests/openvpn/test_pkt=2Ec<br>21 files chang=
ed, 266 insertions(+), 546 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/81/2081/7</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/Changes=2Emd b/Changes=2Emd</span><br><span>index b5ae881=2E=
=2E7f47f77 100644</span><br><span>--- a/Changes=2Emd</span><br><span>+++ b/=
Changes=2Emd</span><br><span>@@ -23,6 +23,13 @@</span><br><span>   the char=
acters mentioned above were already escaped=2E However, the behavior of</sp=
an><br><span>   Mbed TLS is slightly different from OpenSSL in that it also=
 escapes &quot;=3D&quot;=2E</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+* **`secret` has been removed**</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  Static key mode (non-TLS) is no longer considered &quo=
t;good and secure enough&quot; for</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  today&#39;s requirements=2E Use TLS mode instead=2E If dep=
loying a PKI CA is considered</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  &quot;too complicated&quot;, using `--peer-fingerprint` makes T=
LS mode about as easy as</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  using `--secret`=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> ## Maintainer-visible changes</span><br><span> </s=
pan><br><span> - The configure-time option `--enable-debug` is no longer  a=
vailable</span><br><span>diff --git a/INSTALL b/INSTALL</span><br><span>ind=
ex 486b1ae=2E=2Ed0ffaf0 100644</span><br><span>--- a/INSTALL</span><br><spa=
n>+++ b/INSTALL</span><br><span>@@ -144,8 +144,7 @@</span><br><span> </span=
><br><span> Test Crypto:</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-=2E/openvpn --genkey secret key</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-=2E/openvpn --test-crypto --secret key</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+=2E/openvpn --test-crypt=
o</span><br><span> </span><br><span> Test SSL/TLS negotiations (runs for 2 =
minutes):</span><br><span> </span><br><span>diff --git a/doc/man-sections/g=
eneric-options=2Erst b/doc/man-sections/generic-options=2Erst</span><br><sp=
an>index 6815dc2=2E=2E17e4372 100644</span><br><span>--- a/doc/man-sections=
/generic-options=2Erst</span><br><span>+++ b/doc/man-sections/generic-optio=
ns=2Erst</span><br><span>@@ -108,7 +108,7 @@</span><br><span>   For example=
 on Windows, use double backslashes to represent pathnames:</span><br><span=
>   ::</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-      secret &quot;c:\\OpenVPN\\secret=2Ekey&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      tls-auth &quot;c:\\OpenVPN\\secret=
=2Ekey&quot;</span><br><span> </span><br><span> </span><br><span>   For exa=
mples of configuration files, see</span><br><span>@@ -119,7 +119,7 @@</span=
><br><span> </span><br><span>       #</span><br><span>       # Sample OpenV=
PN configuration file for</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-      # using a pre-shared static key=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+      # using a p2p connection=2E</span><br><span>=
       #</span><br><span>       # &#39;#&#39; or &#39;;&#39; may be used to=
 delimit comments=2E</span><br><span> </span><br><span>@@ -133,8 +133,11 @@=
</span><br><span>       # 10=2E1=2E0=2E2 is our remote VPN endpoint</span><=
br><span>       ifconfig 10=2E1=2E0=2E1 10=2E1=2E0=2E2</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-      # Our pre-shared s=
tatic key</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      secret=
 static=2Ekey</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
# Our TLS configuration</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+      tls-client</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+      key mynode=2Ekey</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+      cert mynode=2Ecrt</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+      ca myca=2Ecrt</span><br><span> </span><br><span> --daemon pro=
gname</span><br><span>   Become a daemon after all initialization functions=
 are completed=2E</span><br><span>diff --git a/doc/man-sections/protocol-op=
tions=2Erst b/doc/man-sections/protocol-options=2Erst</span><br><span>index=
 52ce5a8=2E=2E9e14787 100644</span><br><span>--- a/doc/man-sections/protoco=
l-options=2Erst</span><br><span>+++ b/doc/man-sections/protocol-options=2Er=
st</span><br><span>@@ -44,12 +44,10 @@</span><br><span>   of the AEAD ciphe=
r is used instead=2E Note that ``alg`` still specifies</span><br><span>   t=
he digest used for ``tls-auth``=2E</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  In static-key encryption mode, the HMAC k=
ey is included in the key file</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-  generated by ``--genkey``=2E In TLS mode, the HMAC key is dynami=
cally</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  generated and =
shared between peers via the TLS control channel=2E If</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-  OpenVPN receives a packet with a bad HMA=
C it will drop the packet=2E HMAC</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  usually adds 16 or 20 bytes per packet=2E Set ``alg=3Dnone`` =
to disable</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  authentic=
ation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The HMAC =
key is dynamically generated and shared between peers via the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  TLS control channel=2E If OpenV=
PN receives a packet with a bad HMAC it</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  will drop the packet=2E HMAC usually adds 16 or 20 by=
tes per packet=2E Set</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  ``alg=3Dnone`` to disable authentication=2E</span><br><span> </span><br=
><span>   For more information on HMAC see</span><br><span>   https://tools=
=2Eietf=2Eorg/html/rfc2104</span><br><span>@@ -212,11 +210,6 @@</span><br><=
span>   have been configured with ``--enable-small``</span><br><span>   (ty=
pically used on routers or other embedded devices)=2E</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>---allow=
-deprecated-insecure-static-crypto</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-   **DEPRECATED** This allow using OpenVPN without TLS=2E This=
 is deprecated</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   and =
will be removed in OpenVPN 2=2E8=2E</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span> --tran-window n</span><br><span>   Transiti=
on window -- our old key can live this many seconds after a new</span><br><=
span>   a key renegotiation begins (default :code:`3600` seconds)=2E This f=
eature</span><br><span>diff --git a/doc/man-sections/unsupported-options=2E=
rst b/doc/man-sections/unsupported-options=2Erst</span><br><span>index c273=
905=2E=2E2794f12 100644</span><br><span>--- a/doc/man-sections/unsupported-=
options=2Erst</span><br><span>+++ b/doc/man-sections/unsupported-options=2E=
rst</span><br><span>@@ -70,3 +70,12 @@</span><br><span>   Removed in OpenVP=
N 2=2E8=2E This option caused the Mbed TLS 3 random number</span><br><span>=
   generator to be reseeded on every call=2E It has been removed because th=
is</span><br><span>   is excessive=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+-=
-secret</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Removed in=
 OpenVPN 2=2E8=2E Static encryption without a transient key</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  (generated by DH or ECDH) has bee=
n considered problematic for many</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  years=2E Please use ``--peer-fingerprint`` and self-signed =
certificates</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  for s=
mall setups=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+--allow-deprecated-insec=
ure-static-crypto</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
Removed in OpenVPN 2=2E8 as --secret was also removed=2E</span><br><span>di=
ff --git a/doc/openvpn=2E8=2Erst b/doc/openvpn=2E8=2Erst</span><br><span>in=
dex 65130b1=2E=2E2ca9b62 100644</span><br><span>--- a/doc/openvpn=2E8=2Erst=
</span><br><span>+++ b/doc/openvpn=2E8=2Erst</span><br><span>@@ -48,10 +48,=
8 @@</span><br><span> OpenVPN is tightly bound to the OpenSSL library, and =
derives much of its</span><br><span> crypto capabilities from it=2E</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-OpenVPN sup=
ports conventional encryption using a pre-shared secret key</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-**(Static Key mode)** or public key s=
ecurity **(SSL/TLS mode)** using</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-client &amp; server certificates=2E OpenVPN also supports non-en=
crypted</span><br><span style=3D"color: hsl(0, 100%, 40%);">-TCP/UDP tunnel=
s=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+OpenVPN support=
s conventional encryption using public key security</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+with TLS **(SSL/TLS mode)** using client =
&amp; server certificates=2E</span><br><span> </span><br><span> OpenVPN is =
designed to work with the **TUN/TAP** virtual networking</span><br><span> i=
nterface that exists on most platforms=2E</span><br><span>diff --git a/src/=
openvpn/check_file_access=2Ec b/src/openvpn/check_file_access=2Ec</span><br=
><span>index 25d7f90=2E=2Eab2535d 100644</span><br><span>--- a/src/openvpn/=
check_file_access=2Ec</span><br><span>+++ b/src/openvpn/check_file_access=
=2Ec</span><br><span>@@ -312,10 +312,6 @@</span><br><span>                 =
                         ce-&gt;tls_crypt_v2_file, R_OK, &quot;--tls-crypt-=
v2&quot;);</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    errs |=3D</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        check_file_access_inline(options-&gt;shared=
_secret_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                                 options-&gt;s=
hared_secret_file, R_OK, &quot;--secret&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span>     errs |=3D check_file_access=
(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options-&gt;packet_id_file,</span><br><=
span>                               R_OK | W_OK, &quot;--replay-persist&quo=
t;);</span><br><span> </span><br><span>diff --git a/src/openvpn/crypto=2Ec =
b/src/openvpn/crypto=2Ec</span><br><span>index f5e5904=2E=2Ea8ad7f0 100644<=
/span><br><span>--- a/src/openvpn/crypto=2Ec</span><br><span>+++ b/src/open=
vpn/crypto=2Ec</span><br><span>@@ -872,7 +872,7 @@</span><br><span>  * Buil=
d a struct key_type=2E</span><br><span>  */</span><br><span> void</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-init_key_type(struct key_type *=
kt, const char *ciphername, const char *authname, bool tls_mode,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+init_key_type(struct key_type =
*kt, const char *ciphername, const char *authname,</span><br><span>        =
       bool warn)</span><br><span> {</span><br><span>     bool aead_cipher =
=3D false;</span><br><span>@@ -891,9 +891,9 @@</span><br><span> </span><br>=
<span>         /* check legal cipher mode */</span><br><span>         aead_=
cipher =3D cipher_kt_mode_aead(kt-&gt;cipher);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        if (!(cipher_kt_mode_cbc(kt-&gt;cipher) ||=
 (tls_mode &amp;&amp; aead_cipher)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (!(cipher_kt_mode_cbc(kt-&gt;cipher) || aead_ciph=
er</span><br><span> #ifdef ENABLE_OFB_CFB_MODE</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-              || (tls_mode &amp;&amp; cipher_kt_mo=
de_ofb_cfb(kt-&gt;cipher))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+              || cipher_kt_mode_ofb_cfb(kt-&gt;cipher)</span><br><sp=
an> #endif</span><br><span>                   ))</span><br><span>         {=
</span><br><span>diff --git a/src/openvpn/crypto=2Eh b/src/openvpn/crypto=
=2Eh</span><br><span>index dbe0802=2E=2E5212e17 100644</span><br><span>--- =
a/src/openvpn/crypto=2Eh</span><br><span>+++ b/src/openvpn/crypto=2Eh</span=
><br><span>@@ -59,14 +59,11 @@</span><br><span>  *</span><br><span>  * @par=
</span><br><span>  * &lt;b&gt;CBC data channel cypto format&lt;/b&gt; \n</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * In CBC mode, both TLS=
-mode and static key mode are supported=2E The IV</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * consists of random bits to provide unpredict=
able IVs=2E \n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Th=
e IV consists of random bits to provide unpredictable IVs=2E \n</span><br><=
span>  * &lt;i&gt;CBC IV format:&lt;/i&gt; \n</span><br><span>  * &lt;tt&gt=
; [ - random - ] &lt;/tt&gt; \n</span><br><span>  * &lt;i&gt;CBC data chann=
el crypto format in TLS-mode:&lt;/i&gt; \n</span><br><span>  * &lt;tt&gt; [=
 HMAC ] [ - IV - ] [ * packet ID * ] [ * packet payload * ] &lt;/tt&gt; \n<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * &lt;i&gt;CBC data c=
hannel crypto format in static key mode:&lt;/i&gt; \n</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * &lt;tt&gt; [ HMAC ] [ - IV - ] [ * packe=
t ID * ] [ * timestamp * ]</span><br><span>  * [ * packet payload * ] &lt;/=
tt&gt;</span><br><span>  *</span><br><span>  * @par</span><br><span>@@ -113=
,10 +110,7 @@</span><br><span>  * static key mode are supported=2E No encry=
ption will be performed on the packet,</span><br><span>  * but packets can =
still be authenticated=2E This mode does not require an IV=2E\n</span><br><=
span>  * &lt;i&gt;No-crypto data channel crypto format in TLS-mode:&lt;/i&g=
t; \n</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * &lt;tt&gt; [ =
HMAC ] [ - packet ID - ] [ - packet payload - ] &lt;/tt&gt; \n</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * &lt;i&gt;No-crypto data channel=
 crypto format in static key mode:&lt;/i&gt; \n</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * &lt;tt&gt; [ HMAC ] [ - packet ID - ] [ - time=
stamp - ] [ - packet payload - ] &lt;/tt&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * &lt;tt&gt; [ HMAC ] [ - packet ID - ] [ - packet payload - ] &lt;/=
tt&gt; \n *</span><br><span>  */</span><br><span> </span><br><span> #ifndef=
 CRYPTO_H</span><br><span>@@ -420,11 +414,9 @@</span><br><span>  * @param k=
t          The struct key_type to initialize</span><br><span>  * @param cip=
hername  The name of the cipher to use</span><br><span>  * @param authname =
   The name of the HMAC digest to use</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * @param tls_mode    Specifies whether we are running in T=
LS mode, which allows</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *                    more ciphers than static key mode=2E</span><br><span>=
  * @param warn        Print warnings when null cipher / auth is used=2E</s=
pan><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-voi=
d init_key_type(struct key_type *kt, const char *ciphername, const char *au=
thname, bool tls_mode,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void init_key_type(struct key_type *kt, const char *ciphername, const ch=
ar *authname,</span><br><span>                    bool warn);</span><br><sp=
an> </span><br><span> /*</span><br><span>diff --git a/src/openvpn/crypto_mb=
edtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec</span><br><span>index 0ea2375=2E=
=2E3dc12f8 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls=2Ec</spa=
n><br><span>+++ b/src/openvpn/crypto_mbedtls=2Ec</span><br><span>@@ -1013,8=
 +1013,7 @@</span><br><span>     printf(&quot;The following ciphers and cip=
her modes are available for use\n&quot;</span><br><span>            &quot;w=
ith &quot; PACKAGE_NAME &quot;=2E  Each cipher shown below may be used as a=
\n&quot;</span><br><span>            &quot;parameter to the --data-ciphers =
(or --cipher) option=2E  Using a\n&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-           &quot;GCM or CBC mode is recommended=2E  In s=
tatic key mode only CBC\n&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-           &quot;mode is allowed=2E\n\n&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+           &quot;GCM or CBC mode is r=
ecommended=2E \n\n&quot;);</span><br><span> #endif</span><br><span> </span>=
<br><span>     for (size_t i =3D 0; i &lt; cipher_info_table_entries; i++)<=
/span><br><span>diff --git a/src/openvpn/helper=2Ec b/src/openvpn/helper=2E=
c</span><br><span>index d29895b=2E=2E6b5fcee6 100644</span><br><span>--- a/=
src/openvpn/helper=2Ec</span><br><span>+++ b/src/openvpn/helper=2Ec</span><=
br><span>@@ -266,12 +266,6 @@</span><br><span>             msg(M_USAGE, &qu=
ot;--server and --server-bridge cannot be used together&quot;);</span><br><=
span>         }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if (o-&gt;shared_secret_file)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            msg(M_USAGE,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                &quot;--server and --secret cannot be us=
ed together (you must use SSL/TLS keys)&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span>         if (!(o-&gt;server_flags &amp; SF_N=
OPOOL) &amp;&amp; o-&gt;ifconfig_pool_defined)</span><br><span>         {</=
span><br><span>             msg(M_USAGE,</span><br><span>@@ -461,12 +455,6 =
@@</span><br><span>                 &quot;--server-bridge already defines a=
n ifconfig-pool, so you can&#39;t also specify --ifconfig-pool explicitly&q=
uot;);</span><br><span>         }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (o-&gt;shared_secret_file)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            msg(M_USAGE,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                &quot;--server-bridg=
e and --secret cannot be used together (you must use SSL/TLS keys)&quot;);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         if (dev =
!=3D DEV_TYPE_TAP)</span><br><span>         {</span><br><span>             =
msg(M_USAGE, &quot;--server-bridge directive only makes sense with --dev ta=
p&quot;);</span><br><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/i=
nit=2Ec</span><br><span>index ff3bfe5=2E=2Ec4b6483 100644</span><br><span>-=
-- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span>=
<br><span>@@ -1001,35 +1001,10 @@</span><br><span>         platform_mlockal=
l(true);</span><br><span>     }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    /*</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-     * We do not want user to use --genkey with --secret=2E In=
 the transistion</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
* phase we for secret=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (opt=
ions-&gt;genkey &amp;&amp; options-&gt;genkey_type !=3D GENKEY_SECRET &amp;=
&amp; options-&gt;shared_secret_file)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        msg(M_USAGE, &quot;Using --genkey type with --secret filename is &q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
    &quot;not supported=2E  Use --genkey type filename instead=2E&quot;);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span> =
    if (options-&gt;genkey &amp;&amp; options-&gt;genkey_type =3D=3D GENKEY=
_SECRET)</span><br><span>     {</span><br><span>         int nbits_written;=
</span><br><span>         const char *genkey_filename =3D options-&gt;genke=
y_filename;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if=
 (options-&gt;shared_secret_file &amp;&amp; options-&gt;genkey_filename)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            msg(M_USAGE, &quot;You m=
ust provide a filename to either --genkey &quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                         &quot;or --secret, not =
both&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        /*</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-         * Copy filename from shared_secret_file to g=
enkey_filename to support</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-         * the old --genkey --secret foo=2Efile syntax=2E</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-         */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (options-&gt;shared_secret_file)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;WAR=
NING: Using --genkey --secret filename is &quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                        &quot;DEPRECATED=2E  Use=
 --genkey secret filename instead=2E&quot;);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            genkey_filename =3D options-&gt;shared_s=
ecret_file;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }<=
/span><br><span> </span><br><span>         nbits_written =3D write_key_file=
(2, genkey_filename);</span><br><span>         if (nbits_written &lt; 0)</s=
pan><br><span>@@ -1038,7 +1013,7 @@</span><br><span>         }</span><br><s=
pan> </span><br><span>         msg(D_GENKEY | M_NOPREFIX, &quot;Randomly ge=
nerated %d bit key written to %s&quot;, nbits_written,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            options-&gt;shared_secret_file=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            optio=
ns-&gt;genkey_filename ? options-&gt;genkey_filename : &quot;stdout&quot;);=
</span><br><span>         return true;</span><br><span>     }</span><br><sp=
an>     else if (options-&gt;genkey &amp;&amp; options-&gt;genkey_type =3D=
=3D GENKEY_TLS_CRYPTV2_SERVER)</span><br><span>@@ -1084,7 +1059,7 @@</span>=
<br><span>     /* sanity check on options for --mktun or --rmtun */</span><=
br><span>     notnull(options-&gt;dev, &quot;TUN/TAP device (--dev)&quot;);=
</span><br><span>     if (options-&gt;ce=2Eremote || options-&gt;ifconfig_l=
ocal || options-&gt;ifconfig_remote_netmask</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        || options-&gt;shared_secret_file || options-=
&gt;tls_server || options-&gt;tls_client)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        || options-&gt;tls_server || options-&gt;tls_=
client)</span><br><span>     {</span><br><span>         msg(M_FATAL | M_OPT=
ERR,</span><br><span>             &quot;options --mktun or --rmtun should o=
nly be used together with --dev&quot;);</span><br><span>@@ -3040,8 +3015,7 =
@@</span><br><span>     ASSERT(!key_ctx_bi_defined(&amp;c-&gt;c1=2Eks=2Esta=
tic_key));</span><br><span> </span><br><span>     /* Init cipher and hash a=
lgorithm */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_k=
ey_type(&amp;c-&gt;c1=2Eks=2Ekey_type, options-&gt;ciphername, options-&gt;=
authname,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
      options-&gt;test_crypto, true);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    init_key_type(&amp;c-&gt;c1=2Eks=2Ekey_type, options-=
&gt;ciphername, options-&gt;authname, true);</span><br><span> </span><br><s=
pan>     generate_test_crypto_random_key(&amp;c-&gt;c1=2Eks=2Ekey_type, &am=
p;c-&gt;c1=2Eks=2Estatic_key,</span><br><span>                             =
        &quot;test crypto key&quot;);</span><br><span>@@ -3051,50 +3025,6 @=
@</span><br><span> }</span><br><span> </span><br><span> /*</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * Static Key Mode (using a pre-shared=
 key)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-do_init_crypto_static(struct context *c, co=
nst unsigned int flags)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const struct o=
ptions *options =3D &amp;c-&gt;options;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    ASSERT(options-&gt;shared_secret_file);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    init_crypto_pre(c, flags);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    /* Initialize flags */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (c-&gt;options=2Emute_replay_warnings)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        c-&gt;c2=2Ecrypto_options=2Eflags |=3D CO_MUTE_=
REPLAY_WARNINGS;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    /* Initialize packet ID tracking */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    packet_id_init(&amp;=
c-&gt;c2=2Ecrypto_options=2Epacket_id, options-&gt;replay_window, options-&=
gt;replay_time,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
             &quot;STATIC&quot;, 0);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    c-&gt;c2=2Ecrypto_options=2Epid_persist =3D &amp;c-&gt;c=
1=2Epid_persist;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c=
-&gt;c2=2Ecrypto_options=2Eflags |=3D CO_PACKET_ID_LONG_FORM;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    packet_id_persist_load_obj(&amp=
;c-&gt;c1=2Epid_persist, &amp;c-&gt;c2=2Ecrypto_options=2Epacket_id);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (!key_ctx_bi_defined(&amp;c-&gt;c1=2Eks=
=2Estatic_key))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Get cipher =
&amp; hash algorithms */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        init_key_type(&amp;c-&gt;c1=2Eks=2Ekey_type, options-&gt;ciphern=
ame, options-&gt;authname,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                      options-&gt;test_crypto, true);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        /* Read cipher and hmac keys from shared secret fil=
e */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        crypto_re=
ad_openvpn_key(&amp;c-&gt;c1=2Eks=2Ekey_type, &amp;c-&gt;c1=2Eks=2Estatic_k=
ey,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
              options-&gt;shared_secret_file, options-&gt;shared_secret_fil=
e_inline,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                    options-&gt;key_direction, &quot;Static Key Encryption&=
quot;, &quot;secret&quot;, NULL);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_INFO, &quot;Re-usin=
g pre-shared static key&quot;);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Get key schedule */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2=2Ecrypto_=
options=2Ekey_ctx_bi =3D c-&gt;c1=2Eks=2Estatic_key;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span>=
<br><span>  * Initialize the tls-auth/crypt key context</span><br><span>  *=
/</span><br><span> static void</span><br><span>@@ -3233,7 +3163,7 @@</span>=
<br><span> </span><br><span>         /* Do not warn if the cipher is used o=
nly in OCC */</span><br><span>         bool warn =3D options-&gt;enable_ncp=
_fallback;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ini=
t_key_type(&amp;c-&gt;c1=2Eks=2Ekey_type, ciphername, options-&gt;authname,=
 true, warn);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  init_key_type(&amp;c-&gt;c1=2Eks=2Ekey_type, ciphername, options-&gt;auth=
name, warn);</span><br><span> </span><br><span>         /* initialize tls-a=
uth/crypt/crypt-v2 key */</span><br><span>         do_init_tls_wrap_key(c);=
</span><br><span>@@ -3522,41 +3452,6 @@</span><br><span>     }</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * No encryption=
 or authentication=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-do_init_crypto_none(struct c=
ontext *c)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(!c-&gt;options=2Etes=
t_crypto);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    /* Initialise key_type with =
auth/cipher &quot;none&quot;, so the key_type struct is</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-     * valid */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    init_key_type(&amp;c-&gt;c1=2Eks=2Ekey_type=
, &quot;none&quot;, &quot;none&quot;, c-&gt;options=2Etest_crypto, true);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    msg(M_WARN, &quot;******* WARNING *****=
**: All encryption and authentication features &quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                &quot;disabled -- All data =
will be tunnelled as clear text and will not be &quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                &quot;protected against ma=
n-in-the-middle changes=2E &quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                &quot;PLEASE DO RECONSIDER THIS CONFIGURATION!&=
quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-do_init_crypto(struct context *c, const unsigned int flags)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (c-&gt;options=2Eshared_secret_file)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        do_init_crypto_static(c, flags);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    else if (c-&gt;options=2Etls_serve=
r || c-&gt;options=2Etls_client)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   do_init_crypto_tls(c, flags);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    e=
lse /* no encryption or authentication=2E */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        do_init_crypto_none(c);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> s=
tatic void</span><br><span> do_init_frame(struct context *c)</span><br><spa=
n> {</span><br><span>@@ -4613,7 +4508,7 @@</span><br><span>         {</span=
><br><span>             crypto_flags =3D CF_INIT_TLS_MULTI;</span><br><span=
>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        do=
_init_crypto(c, crypto_flags);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        do_init_crypto_tls(c, crypto_flags);</span><br><span>   =
      if (IS_SIG(c) &amp;&amp; !child)</span><br><span>         {</span><br=
><span>             goto sig;</span><br><span>diff --git a/src/openvpn/mtu=
=2Ec b/src/openvpn/mtu=2Ec</span><br><span>index f3c2874=2E=2E5ce40c8 10064=
4</span><br><span>--- a/src/openvpn/mtu=2Ec</span><br><span>+++ b/src/openv=
pn/mtu=2Ec</span><br><span>@@ -51,7 +51,6 @@</span><br><span> unsigned int<=
/span><br><span> calc_packet_id_size_dc(const struct options *options, cons=
t struct key_type *kt)</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    bool tlsmode =3D options-&gt;tls_server || options-=
&gt;tls_client;</span><br><span>     bool epoch =3D options-&gt;imported_pr=
otocol_flags &amp; CO_EPOCH_DATA_KEY_FORMAT;</span><br><span> </span><br><s=
pan>     /* epoch format uses a 64-bit packet id: 16 bit epoch + 48 bit per=
-epoch counter */</span><br><span>@@ -60,7 +59,7 @@</span><br><span>       =
  return sizeof(uint64_t);</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    bool packet_id_long_form =
=3D !tlsmode || cipher_kt_mode_ofb_cfb(kt-&gt;cipher);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    bool packet_id_long_form =3D cipher_=
kt_mode_ofb_cfb(kt-&gt;cipher);</span><br><span> </span><br><span>     retu=
rn packet_id_size(packet_id_long_form);</span><br><span> }</span><br><span>=
@@ -72,8 +71,6 @@</span><br><span>     /* Sum of all the overhead that redu=
ces the usable packet size */</span><br><span>     size_t header_size =3D 0=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  bool tlsmode =3D options-&gt;tls_server || options-&gt;tls_client;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* A s=
ocks proxy adds extra header to each packet</span><br><span>      * (we onl=
y support Socks with IPv4, this value is different for IPv6) */</span><br><=
span>     if (options-&gt;ce=2Esocks_proxy_server &amp;&amp; proto_is_udp(o=
ptions-&gt;ce=2Eproto))</span><br><span>@@ -88,10 +85,7 @@</span><br><span>=
     }</span><br><span> </span><br><span>     /* Add the opcode and peerid =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tlsmode)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        header_size +=3D options-&gt;use=
_peer_id ? 4 : 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    header_size +=
=3D options-&gt;use_peer_id ? 4 : 1;</span><br><span> </span><br><span>    =
 unsigned int pkt_id_size =3D calc_packet_id_size_dc(options, kt);</span><b=
r><span> </span><br><span>@@ -156,13 +150,6 @@</span><br><span> {</span><br=
><span>     struct key_type occ_kt;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* neither --secret nor TLS mode */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!o-&gt;tls_client=
 &amp;&amp; !o-&gt;tls_server &amp;&amp; !o-&gt;shared_secret_file)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        init_key_type(&amp;occ_kt, &quot;no=
ne&quot;, &quot;none&quot;, false, false);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        return frame_calculate_payload_size(frame, o, =
&amp;occ_kt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /*=
 o-&gt;ciphername might be BF-CBC even though the underlying SSL library</s=
pan><br><span>      * does not support it=2E For this reason we workaround =
this corner case</span><br><span>      * by pretending to have no encryptio=
n enabled and by manually adding</span><br><span>@@ -184,9 +171,7 @@</span>=
<br><span>         ciphername =3D &quot;none&quot;;</span><br><span>     }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
/* We pass tlsmode always true here since as we do not need to check if</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-     * the ciphers are ac=
tually valid for non tls in occ calucation */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    init_key_type(&amp;occ_kt, ciphername, o-&gt;au=
thname, true, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    init_key_type(&amp;occ_kt, ciphername, o-&gt;authname, false);</span>=
<br><span> </span><br><span>     size_t payload =3D frame_calculate_payload=
_size(frame, o, &amp;occ_kt);</span><br><span>     overhead +=3D frame_calc=
ulate_protocol_header_size(&amp;occ_kt, o, true);</span><br><span>diff --gi=
t a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index=
 4dfc719=2E=2E454d2d6 100644</span><br><span>--- a/src/openvpn/options=2Ec<=
/span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -558,14 +5=
58,11 @@</span><br><span>     &quot;                  server/remote=2E n =
=3D # of retries, default=3D1=2E\n&quot;</span><br><span>     &quot;\n&quot=
;</span><br><span>     &quot;Data Channel Encryption Options (must be compa=
tible between peers):\n&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    &quot;(These options are meaningful for both Static Key &amp; T=
LS-mode)\n&quot;</span><br><span>     &quot;--auth alg      : Authenticate =
packets with HMAC using message\n&quot;</span><br><span>     &quot;        =
          digest algorithm alg (default=3D%s)=2E\n&quot;</span><br><span>  =
   &quot;                  (usually adds 16 or 20 bytes per packet)\n&quot;=
</span><br><span>     &quot;                  Set alg=3Dnone to disable aut=
hentication=2E\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    &quot;--cipher alg    : Encrypt packets with cipher algorithm alg=2E\n=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;     =
             You should usually use --data-ciphers instead=2E\n&quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;                 =
 Set alg=3Dnone to disable encryption=2E\n&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    &quot;--cipher alg    : Ignored=2E You sho=
uld usually use --data-ciphers instead=2E\n&quot;</span><br><span>     &quo=
t;--data-ciphers list : List of ciphers that are allowed to be negotiated=
=2E\n&quot;</span><br><span> #ifndef ENABLE_CRYPTO_MBEDTLS</span><br><span>=
     &quot;--engine [name] : Enable OpenSSL hardware crypto engine function=
ality=2E\n&quot;</span><br><span>@@ -1588,16 +1585,17 @@</span><br><span> s=
tatic void</span><br><span> options_postprocess_verify_ce(const struct opti=
ons *options, const struct connection_entry *ce)</span><br><span> {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (options-&gt;test_cr=
ypto)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     struc=
t options defaults;</span><br><span>     int dev =3D DEV_TYPE_UNDEF;</span>=
<br><span>     bool pull =3D false;</span><br><span> </span><br><span>     =
init_options(&amp;defaults);</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (!options-&gt;test_crypto)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        notnull(options-&gt;dev, &quot;TUN/TAP device =
(--dev)&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    notnull(options-=
&gt;dev, &quot;TUN/TAP device (--dev)&quot;);</span><br><span> </span><br><=
span>     /*</span><br><span>      * Get tun/tap/null device type</span><br=
><span>@@ -2013,27 +2011,9 @@</span><br><span>     /*</span><br><span>     =
 * SSL/TLS mode sanity checks=2E</span><br><span>      */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;tls_server + option=
s-&gt;tls_client + (options-&gt;shared_secret_file !=3D NULL) &gt; 1)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (options-&gt;tls_s=
erver =3D=3D options-&gt;tls_client)</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        msg(M_USAGE, &quot;specify on=
ly one of --tls-server, --tls-client, or --secret&quot;);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (!options-&gt;tls_server &amp;&amp; !options-&gt;tls_client &amp;&amp=
; !options-&gt;test_crypto)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ms=
glvl_t msglevel =3D M_USAGE;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (options-&gt;allow_deprecated_insecure_static_crypto)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            msglevel =3D M_INFO;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        msg(msglevel, &quot;DEPRECATION: No tls-client or t=
ls-server option in &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                      &quot;configuration detected=2E OpenVPN 2=2E8 wi=
ll remove the &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                     &quot;functionality to run a VPN without TLS=2E &quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
 &quot;See the examples section in the manual page for &quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                      &quot;example=
s of a similar quick setup with peer-fingerprint=2E &quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                      &quot;OpenVPN 2=
=2E7 allows using this configuration when using &quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                      &quot;--allow-deprec=
ated-insecure-static-crypto but you should move &quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                      &quot;to a proper co=
nfiguration using TLS as soon as possible=2E&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_USAGE, &quot;OpenVPN config=
uration must use either --tls-server or --tls-client&quot;);</span><br><spa=
n>     }</span><br><span> </span><br><span>     if (options-&gt;ssl_flags &=
amp; (SSLF_CLIENT_CERT_NOT_REQUIRED | SSLF_CLIENT_CERT_OPTIONAL))</span><br=
><span>@@ -2053,188 +2033,135 @@</span><br><span>         msg(M_USAGE, &quo=
t;--tls-version-min bigger than --tls-version-max&quot;);</span><br><span> =
    }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (options-&gt;tls_server || options-&gt;tls_client)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        check_ca_required(options);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    check_ca_required(options);</span=
><br><span> #ifdef ENABLE_PKCS11</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (!options-&gt;pkcs11_providers[0] &amp;&amp; options-=
&gt;pkcs11_id)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_W=
ARN, &quot;Option pkcs11-id is ignored as no pkcs11-providers are specified=
&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        else if (!options=
-&gt;pkcs11_providers[0] &amp;&amp; options-&gt;pkcs11_id_management)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                &quot;Option pkcs11-i=
d-management is ignored as no pkcs11-providers are specified&quot;);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (!options-&gt;pkcs11_providers[=
0] &amp;&amp; options-&gt;pkcs11_id)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        msg(M_WARN, &quot;Option pkcs11-id is ignored as no pkcs11-provi=
ders are specified&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    els=
e if (!options-&gt;pkcs11_providers[0] &amp;&amp; options-&gt;pkcs11_id_man=
agement)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;Option =
pkcs11-id-management is ignored as no pkcs11-providers are specified&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (opti=
ons-&gt;pkcs11_providers[0])</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       if (options-&gt;pkcs11_id_management &amp;&amp; options-&gt;pkcs11_i=
d !=3D NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                m=
sg(M_USAGE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          &quot;Parameter --pkcs11-id cannot be used when --pkcs11-id-manag=
ement is also specified=2E&quot;);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            if (!options-&gt;pkcs11_id_management &amp;&amp; options-&=
gt;pkcs11_id =3D=3D NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            msg(M_USAGE,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                    &quot;Parameter --pkcs11-id or --pkcs11-id-managemen=
t should be specified=2E&quot;);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            const char use_err[] =3D</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                &quot;Parameter --%s cannot be used when =
--pkcs11-provider is also specified=2E&quot;;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            MUST_BE_UNDEF(cert_file, &quot;cert&quo=
t;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            MUST_=
BE_UNDEF(priv_key_file, &quot;key&quot;);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            MUST_BE_UNDEF(pkcs12_file, &quot;pkcs12&quo=
t;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            MUST_=
BE_FALSE(options-&gt;management_flags &amp; MF_EXTERNAL_KEY, &quot;manageme=
nt-external-key&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            MUST_BE_FALSE(options-&gt;management_flags &amp; MF_EXTERNAL_=
CERT, &quot;management-external-cert&quot;);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#ifdef ENABLE_CRYPTOAPI</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            MUST_BE_UNDEF(cryptoapi_cert, &quot;cr=
yptoapicert&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
ndif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef ENABLE_PKCS11 */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_CRYPTOAPI</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (options-&=
gt;cryptoapi_cert)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            con=
st char use_err[] =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                &quot;Parameter --%s cannot be used when --cryptoapicert is=
 also specified=2E&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            MUST_BE_UNDEF(cert_file, &quot;cert&quot;);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_UNDEF(priv_key_fi=
le, &quot;key&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            MUST_BE_UNDEF(pkcs12_file, &quot;pkcs12&quot;);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_FALSE(options-&gt=
;management_flags &amp; MF_EXTERNAL_KEY, &quot;management-external-key&quot=
;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            MUST_B=
E_FALSE(options-&gt;management_flags &amp; MF_EXTERNAL_CERT, &quot;manageme=
nt-external-cert&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        e=
lse</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            if (options-&gt;pkcs1=
2_file)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_CRYPTO_MBEDT=
LS</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_U=
SAGE, &quot;Parameter --pkcs12 cannot be used with the mbed TLS version of =
OpenVPN=2E&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#el=
se</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            const c=
har use_err[] =3D &quot;Parameter --%s cannot be used when --pkcs12 is also=
 specified=2E&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           MUST_BE_UNDEF(ca_path, &quot;capath&quot;);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_UNDEF(cert_file, &quot=
;cert&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    MUST_BE_UNDEF(priv_key_file, &quot;key&quot;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            MUST_BE_FALSE(options-&gt;manageme=
nt_flags &amp; MF_EXTERNAL_KEY, &quot;management-external-key&quot;);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_FALSE(o=
ptions-&gt;management_flags &amp; MF_EXTERNAL_CERT, &quot;management-extern=
al-cert&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif=
       /* ifdef ENABLE_CRYPTO_MBEDTLS */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        else /* cert/key from none of pkcs11, pkcs12, cryptoapi */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            if ((options-&gt;manage=
ment_flags &amp; MF_EXTERNAL_KEY) &amp;&amp; options-&gt;priv_key_file)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                msg(M_USAGE, &quo=
t;--key and --management-external-key are mutually exclusive&quot;);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            if ((options-&gt;managem=
ent_flags &amp; MF_EXTERNAL_CERT))</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                if (options-&gt;cert_file)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    msg(M_USAGE, &quot;--cert and --m=
anagement-external-cert are mutually exclusive&quot;);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                else if (!(options-&gt;managem=
ent_flags &amp; MF_EXTERNAL_KEY))</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    msg(M_USAGE,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                        &quot;--management-external-cert=
 must be used with --management-external-key&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            if (pull)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                const int sum =3D</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                    ((options-&gt;cert_file !=3D NU=
LL) || (options-&gt;management_flags &amp; MF_EXTERNAL_CERT))</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                    + ((options-&gt=
;priv_key_file !=3D NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                       || (options-&gt;management_flags &amp; MF_EXTERN=
AL_KEY));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                if (sum =3D=3D 0)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    if (!=
options-&gt;auth_user_pass_file)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                        msg(M_USAGE, &quot;No client-side authen=
tication method is &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                                     &quot;specified=2E  You must use e=
ither &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                            &quot;--cert/--key, --pkcs12, or &quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
        &quot;--auth-user-pass&quot;);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                else if (sum !=3D 2)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                    msg(M_USAGE, &quot;If you use o=
ne of --cert or --key, you must use them both&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            else</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                if (!(options-&gt;management_flags &amp; MF_EXTERNAL=
_CERT))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
  notnull(options-&gt;cert_file,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                            &quot;certificate file (--cert) or P=
KCS#12 file (--pkcs12)&quot;);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                if (!(options-&gt;management_flags &amp; MF_EXTERNAL_K=
EY))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    n=
otnull(options-&gt;priv_key_file,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                            &quot;private key file (--key) or P=
KCS#12 file (--pkcs12)&quot;);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (ce-=
&gt;tls_auth_file &amp;&amp; ce-&gt;tls_crypt_file)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            msg(M_USAGE, &quot;--tls-auth and --tls-cry=
pt are mutually exclusive&quot;);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (options-&gt;tls_client &amp;&amp; ce-&gt;tls_crypt_v2_file</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; (ce=
-&gt;tls_auth_file || ce-&gt;tls_crypt_file))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (options-&gt;pkcs11_providers[0])</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (options-&gt;pkcs11_id_managem=
ent &amp;&amp; options-&gt;pkcs11_id !=3D NULL)</span><br><span>         {<=
/span><br><span>             msg(M_USAGE,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                &quot;--tls-crypt-v2, --tls-auth and --=
tls-crypt are mutually exclusive in client mode&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                &quot;Parameter --pkcs1=
1-id cannot be used when --pkcs11-id-management is also specified=2E&quot;)=
;</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        /*</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-         * Make sure user doesn&#39;t specify any=
 TLS options</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
* when in non-TLS mode=2E</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-         */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        const char use_err[=
] =3D &quot;Parameter %s can only be specified in TLS-mode, &quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                              =
 &quot;i=2Ee=2E where --tls-server or --tls-client is also specified=2E&quo=
t;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(ca_file, &quot;ca=
&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_=
BE_UNDEF(ca_path, &quot;capath&quot;);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        MUST_BE_UNDEF(dh_file, &quot;dh&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (!options-&gt;pkcs1=
1_id_management &amp;&amp; options-&gt;pkcs11_id =3D=3D NULL)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(M_USAGE,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                &quot;Parameter --pk=
cs11-id or --pkcs11-id-management should be specified=2E&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        const char use_err[] =3D</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;Parameter=
 --%s cannot be used when --pkcs11-provider is also specified=2E&quot;;</sp=
an><br><span>         MUST_BE_UNDEF(cert_file, &quot;cert&quot;);</span><br=
><span>         MUST_BE_UNDEF(priv_key_file, &quot;key&quot;);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#ifndef ENABLE_CRYPTO_MBEDTLS</spa=
n><br><span>         MUST_BE_UNDEF(pkcs12_file, &quot;pkcs12&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_FALSE(opti=
ons-&gt;management_flags &amp; MF_EXTERNAL_KEY, &quot;management-external-k=
ey&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        M=
UST_BE_FALSE(options-&gt;management_flags &amp; MF_EXTERNAL_CERT, &quot;man=
agement-external-cert&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#ifdef ENABLE_CRYPTOAPI</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        MUST_BE_UNDEF(cryptoapi_cert, &quot;cryptoapicert&quo=
t;);</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        MUST_BE_UNDEF(cipher_list, &quot;tls-cipher&quot;);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(cipher_l=
ist_tls13, &quot;tls-ciphersuites&quot;);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        MUST_BE_UNDEF(tls_cert_profile, &quot;tls-cert-=
profile&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  MUST_BE_UNDEF(tls_verify, &quot;tls-verify&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(tls_export_peer_cert_=
dir, &quot;tls-export-cert&quot;);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        MUST_BE_UNDEF(verify_x509_name, &quot;verify-x509-name=
&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_=
BE_UNDEF(tls_timeout, &quot;tls-timeout&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(renegotiate_bytes, &quot;re=
neg-bytes&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    MUST_BE_UNDEF(renegotiate_packets, &quot;reneg-pkts&quot;);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(renegotiate=
_seconds, &quot;reneg-sec&quot;);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        MUST_BE_UNDEF(handshake_window, &quot;hand-window&quot;=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UND=
EF(transition_window, &quot;tran-window&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(tls_auth_file, &quot;tls-au=
th&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUS=
T_BE_UNDEF(tls_crypt_file, &quot;tls-crypt&quot;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(tls_crypt_v2_file, &quot=
;tls-crypt-v2&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        MUST_BE_UNDEF(single_session, &quot;single-session&quot;);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(push_pee=
r_info, &quot;push-peer-info&quot;);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        MUST_BE_UNDEF(tls_exit, &quot;tls-exit&quot;);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(crl_f=
ile, &quot;crl-verify&quot;);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        MUST_BE_UNDEF(ns_cert_type, &quot;ns-cert-type&quot;);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(remo=
te_cert_ku[0], &quot;remote-cert-ku&quot;);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(remote_cert_eku, &quot;remote-c=
ert-eku&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef=
 ENABLE_PKCS11</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 MUST_BE_UNDEF(pkcs11_providers[0], &quot;pkcs11-providers&quot;);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(pkcs11_p=
rivate_mode[0], &quot;pkcs11-private-mode&quot;);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(pkcs11_id, &quot;pkcs11-i=
d&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST=
_BE_UNDEF(pkcs11_id_management, &quot;pkcs11-id-management&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif /* ifdef ENABLE_PKCS11 */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_CRYPTOAPI</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (options-&gt;cryptoapi_c=
ert)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        const char use_err[] =
=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quo=
t;Parameter --%s cannot be used when --cryptoapicert is also specified=2E&q=
uot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_B=
E_UNDEF(cert_file, &quot;cert&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        MUST_BE_UNDEF(priv_key_file, &quot;key&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(=
pkcs12_file, &quot;pkcs12&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        MUST_BE_FALSE(options-&gt;management_flags &amp; MF_E=
XTERNAL_KEY, &quot;management-external-key&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        MUST_BE_FALSE(options-&gt;management=
_flags &amp; MF_EXTERNAL_CERT, &quot;management-external-cert&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span> #endif</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (options-&gt;pkcs12_file)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_CRYPTO_MBEDTLS</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        msg(M_USAGE, &quot;Paramete=
r --pkcs12 cannot be used with the mbed TLS version of OpenVPN=2E&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        const char use_err[] =3D &q=
uot;Parameter --%s cannot be used when --pkcs12 is also specified=2E&quot;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UND=
EF(ca_path, &quot;capath&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        MUST_BE_UNDEF(cert_file, &quot;cert&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(priv_key=
_file, &quot;key&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        MUST_BE_FALSE(options-&gt;management_flags &amp; MF_EXTERNAL_K=
EY, &quot;management-external-key&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        MUST_BE_FALSE(options-&gt;management_flags &a=
mp; MF_EXTERNAL_CERT, &quot;management-external-cert&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif   /* ifdef ENABLE_CRYPTO_MB=
EDTLS */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    else /* cert/key from=
 none of pkcs11, pkcs12, cryptoapi */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if ((options-&gt;management_flags &amp; MF_EXTERNAL_KEY) &amp;&=
amp; options-&gt;priv_key_file)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            msg(M_USAGE, &quot;--key and --management-external-key are mu=
tually exclusive&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if ((options-&gt;management_flags &amp; MF_EXTERNAL_CERT))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (options-&gt;cert_file)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                msg(M_USAGE,=
 &quot;--cert and --management-external-cert are mutually exclusive&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            else if (!(op=
tions-&gt;management_flags &amp; MF_EXTERNAL_KEY))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                msg(M_USAGE,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    &quot;--management-ex=
ternal-cert must be used with --management-external-key&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>         if=
 (pull)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            msg(M_USAGE, use_err, &quot;--pull&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            const int sum =
=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
((options-&gt;cert_file !=3D NULL) || (options-&gt;management_flags &amp; M=
F_EXTERNAL_CERT))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              + ((options-&gt;priv_key_file !=3D NULL)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                   || (options-&gt;manag=
ement_flags &amp; MF_EXTERNAL_KEY));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          if (sum =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                if (!options-&gt;auth_user_pass_file)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    msg(M_USAGE, &quot;No=
 client-side authentication method is &quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                 &quot;specified=
=2E  You must use either &quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                 &quot;--cert/--key, --pkcs12, =
or &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                       &quot;--auth-user-pass&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            else if (sum !=3D 2)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                msg(M_USAGE, &quot;If yo=
u use one of --cert or --key, you must use them both&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            if (!(options-&gt;management_flags &amp; MF_EXTERNAL_CE=
RT))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                notnu=
ll(options-&gt;cert_file,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                        &quot;certificate file (--cert) or PKCS#12 fi=
le (--pkcs12)&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        if (!(options-&gt;management_flags &amp; MF_EXTERNAL_KEY))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                notnull(options-&g=
t;priv_key_file,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                     &quot;private key file (--key) or PKCS#12 file (--pkcs=
12)&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    }</span><br><span>         }</span><br><span>     }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (ce-&gt;tls_auth_file &amp;&amp;=
 ce-&gt;tls_crypt_file)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ms=
g(M_USAGE, &quot;--tls-auth and --tls-crypt are mutually exclusive&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (options-&gt;tls_client &am=
p;&amp; ce-&gt;tls_crypt_v2_file</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        &amp;&amp; (ce-&gt;tls_auth_file || ce-&gt;tls_crypt_f=
ile))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_USAGE,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;--tls-cry=
pt-v2, --tls-auth and --tls-crypt are mutually exclusive in client mode&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span>     if (options-&gt;auth_user_=
pass_file &amp;&amp; !options-&gt;pull)</span><br><span>     {</span><br><s=
pan>         msg(M_USAGE, &quot;--auth-user-pass requires --pull&quot;);</s=
pan><br><span>@@ -6960,32 +6887,6 @@</span><br><span>             goto err;=
</span><br><span>         }</span><br><span>     }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    else if (streq(p[0], &quot;secret&quot;) &=
amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   msg(M_WARN, &quot;DEPRECATED OPTION: The option --secret is deprecated=
=2E&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        VE=
RIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INLINE);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        options-&gt;shared_secret_file =3D p[1];</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;sha=
red_secret_file_inline =3D is_inline;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (!is_inline &amp;&amp; p[2])</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            int key_direction;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            key_direction =3D ascii2keydirection(msglevel, p[2])=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (key_=
direction &gt;=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       options-&gt;key_direction =3D key_direction;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            else</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                goto err;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[=
0], &quot;allow-deprecated-insecure-static-crypto&quot;))</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;allow_deprecate=
d_insecure_static_crypto =3D true;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    }</span><br><span>     else if (streq(p[0], &quot;genkey&q=
uot;) &amp;&amp; !p[4])</span><br><span>     {</span><br><span>         VER=
IFY_PERMISSION(OPT_P_GENERAL);</span><br><span>diff --git a/src/openvpn/opt=
ions=2Eh b/src/openvpn/options=2Eh</span><br><span>index 33b50b2=2E=2E38554=
a1 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++=
 b/src/openvpn/options=2Eh</span><br><span>@@ -569,9 +569,6 @@</span><br><s=
pan>     struct static_challenge_info sc_info;</span><br><span> #endif</spa=
n><br><span>     /* Cipher parms */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    const char *shared_secret_file;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    bool shared_secret_file_inline;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    bool allow_deprecated_insecur=
e_static_crypto;</span><br><span>     int key_direction;</span><br><span>  =
   const char *ciphername;</span><br><span>     bool enable_ncp_fallback; /=
**&lt; If defined fall back to</span><br><span>diff --git a/src/openvpn/opt=
ions_show=2Ec b/src/openvpn/options_show=2Ec</span><br><span>index 80d36f0=
=2E=2E321a37b 100644</span><br><span>--- a/src/openvpn/options_show=2Ec</sp=
an><br><span>+++ b/src/openvpn/options_show=2Ec</span><br><span>@@ -491,7 +=
491,6 @@</span><br><span>     }</span><br><span> #endif</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR_INLINE(sha=
red_secret_file);</span><br><span>     SHOW_PARM(key_direction, keydirectio=
n2ascii(o-&gt;key_direction, false, true), &quot;%s&quot;);</span><br><span=
>     SHOW_STR(ciphername);</span><br><span>     SHOW_STR(ncp_ciphers);</sp=
an><br><span>diff --git a/src/openvpn/options_string=2Ec b/src/openvpn/opti=
ons_string=2Ec</span><br><span>index cfc0595=2E=2E2fd90dd 100644</span><br>=
<span>--- a/src/openvpn/options_string=2Ec</span><br><span>+++ b/src/openvp=
n/options_string=2Ec</span><br><span>@@ -140,83 +140,72 @@</span><br><span>=
     /*</span><br><span>      * Crypto Options</span><br><span>      */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;shared_secr=
et_file || TLS_CLIENT || TLS_SERVER)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct key_type kt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    ASSERT((TLS_CLIENT =3D=3D true) + (TLS_SERVER =3D=3D true) &lt;=3D 1)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* Skip resolving BF-CBC to allow=
 SSL libraries without BF-CBC</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * to work here in the default configuration */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const char *ciphername =3D o-=
&gt;ciphername;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
size_t keysize =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (strcmp(o-=
&gt;ciphername, &quot;BF-CBC&quot;) =3D=3D 0)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        struct key_type kt;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ASSERT((o-&gt;shared_secret_file !=
=3D NULL) + (TLS_CLIENT =3D=3D true) + (TLS_SERVER =3D=3D true) &lt;=3D 1);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        /* Skip resolving BF-CBC to allow =
SSL libraries without BF-CBC</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-         * to work here in the default configuration */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        const char *ciphername =3D=
 o-&gt;ciphername;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     size_t keysize =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (strc=
mp(o-&gt;ciphername, &quot;BF-CBC&quot;) =3D=3D 0)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        init_key_type(&amp;kt, &quot;none&qu=
ot;, o-&gt;authname, false);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        keysize =3D 128;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        init_key_type(&am=
p;kt, o-&gt;ciphername, o-&gt;authname, false);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        ciphername =3D cipher_kt_name(kt=2Eciph=
er);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (cip=
her_defined(o-&gt;ciphername))</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            init_key_type(&amp;kt, &quo=
t;none&quot;, o-&gt;authname, true, false);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            keysize =3D 128;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        init_key_type(&amp;kt, o-&gt;ciphername, o-&gt;authname, true, fals=
e);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            cipher=
name =3D cipher_kt_name(kt=2Ecipher);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            if (cipher_defined(o-&gt;ciphername))</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                keysize =3D cipher_kt_k=
ey_size(kt=2Ecipher) * 8;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Only =
announce the cipher to our peer if we are willing to</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-         * support it */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (p2p_nopull || tls_item_in_ci=
pher_list(ciphername, o-&gt;ncp_ciphers))</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            buf_printf(&amp;out, &quot;,cipher %s&quot;, ciphername=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;out, &q=
uot;,auth %s&quot;, md_kt_name(kt=2Edigest));</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        buf_printf(&amp;out, &quot;,keysize %zu&quo=
t;, keysize);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
if (o-&gt;shared_secret_file)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        buf_printf(&amp;out, &quot;,secret&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            keysize =3D cipher_kt_key_size(k=
t=2Ecipher) * 8;</span><br><span>         }</span><br><span>     }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* Only announce the cip=
her to our peer if we are willing to</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * support it */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (p2p_nopull || tls_item_in_cipher_list(ciphername,=
 o-&gt;ncp_ciphers))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_p=
rintf(&amp;out, &quot;,cipher %s&quot;, ciphername);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    buf_printf(&amp;out, &quot;,auth %s&quot;, md_kt_na=
me(kt=2Edigest));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  buf_printf(&amp;out, &quot;,keysize %zu&quot;, keysize);</span><br><span>=
 </span><br><span>     /*</span><br><span>      * SSL Options</span><br><sp=
an>      */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
o-&gt;ce=2Etls_auth_file)</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        if (TLS_CLIENT || TLS_SERVER)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (o-&gt;ce=2Etls_auth_file)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                buf_printf(&amp=
;out, &quot;,tls-auth&quot;);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            /* Not adding tls-crypt here, because we won&#39;t reach this c=
ode if</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             * =
tls-auth/tls-crypt does not match=2E  Removing tls-auth here would</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-             * break stuff, so=
 leaving that in place=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        buf_printf(&amp;out, &quot;,tls-auth&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* Not adding tls-crypt here, because we wo=
n&#39;t reach this code if</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * tls-auth/tls-crypt does not match=2E  Removing tls-auth here =
would</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * break s=
tuff, so leaving that in place=2E */</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&amp;out, &quot;,ke=
y-method %d&quot;, KEY_METHOD_2);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    buf_printf(&amp;out, &quot;,key-method %d&quot;, KEY_METHOD_2);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f (remote)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (remote)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (TLS_CLIENT)</span><br><span>      =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (T=
LS_CLIENT)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                buf=
_printf(&amp;out, &quot;,tls-server&quot;);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            else if (TLS_SERVER)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                buf_printf(&amp;out, &quot;,tls-client&quo=
t;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_printf(=
&amp;out, &quot;,tls-server&quot;);</span><br><span>         }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        else if (TLS_SERVER)</span><br><s=
pan>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     if (TLS_CLIENT)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       buf_printf(&amp;out, &quot;,tls-client&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            else if (TLS_SERVER)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                buf_printf(&amp;out, &quot;,tls-=
server&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            b=
uf_printf(&amp;out, &quot;,tls-client&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (TLS_CLIENT)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            buf_printf(&amp;o=
ut, &quot;,tls-client&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        else if (TLS_SERVER)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           buf_printf(&amp;out, &quot;,tls-server&quot;);</span><br><span> =
        }</span><br><span>     }</span><br><span> </span><br><span>diff --g=
it a/src/openvpn/options_string=2Eh b/src/openvpn/options_string=2Eh</span>=
<br><span>index 02efed3=2E=2E6d5518a 100644</span><br><span>--- a/src/openv=
pn/options_string=2Eh</span><br><span>+++ b/src/openvpn/options_string=2Eh<=
/span><br><span>@@ -59,7 +59,6 @@</span><br><span>  *</span><br><span>  * -=
-cipher</span><br><span>  * --auth</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * --secret</span><br><span>  *</span><br><span>  * SSL Option=
s:</span><br><span>  *</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/s=
rc/openvpn/ssl=2Ec</span><br><span>index 420daef=2E=2Ea538b52 100644</span>=
<br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=
=2Ec</span><br><span>@@ -1648,7 +1648,7 @@</span><br><span>         return =
true;</span><br><span>     }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    init_key_type(&amp;session-&gt;opt-&gt;key_typ=
e, options-&gt;ciphername, options-&gt;authname, true, true);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    init_key_type(&amp;session-&g=
t;opt-&gt;key_type, options-&gt;ciphername, options-&gt;authname, true);</s=
pan><br><span> </span><br><span>     bool packet_id_long_form =3D cipher_kt=
_mode_ofb_cfb(session-&gt;opt-&gt;key_type=2Ecipher);</span><br><span>     =
session-&gt;opt-&gt;crypto_flags &amp;=3D ~(CO_PACKET_ID_LONG_FORM);</span>=
<br><span>diff --git a/tests/unit_tests/openvpn/test_crypto=2Ec b/tests/uni=
t_tests/openvpn/test_crypto=2Ec</span><br><span>index 07c54b4=2E=2Ef86aca8 =
100644</span><br><span>--- a/tests/unit_tests/openvpn/test_crypto=2Ec</span=
><br><span>+++ b/tests/unit_tests/openvpn/test_crypto=2Ec</span><br><span>@=
@ -237,70 +237,58 @@</span><br><span>     /* common defaults */</span><br><=
span>     o=2Ece=2Etun_mtu =3D 1400;</span><br><span>     o=2Ece=2Eproto =
=3D PROTO_UDP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o=
=2Etls_client =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    o=2Epull =3D true;</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    /* No crypto at all */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /*  auth none, cipher none */</span><br><=
span>     o=2Eciphername =3D &quot;none&quot;;</span><br><span>     o=2Eaut=
hname =3D &quot;none&quot;;</span><br><span>     linkmtu =3D calc_options_s=
tring_link_mtu(&amp;o, &amp;f);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    assert_int_equal(linkmtu, 1400);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(linkmtu, 1405);</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Static k=
ey OCC examples */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 o=2Eshared_secret_file =3D &quot;not null&quot;;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    /* secret, auth none, cipher none */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    o=2Eciphername =3D &quot;none&quot;;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    o=2Eauthname =3D &quot;non=
e&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    linkmtu =
=3D calc_options_string_link_mtu(&amp;o, &amp;f);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    assert_int_equal(linkmtu, 1408);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    /* secret, cipher AES-128-CBC, auth none */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* cipher AES-128-CBC=
, auth none */</span><br><span>     o=2Eciphername =3D &quot;AES-128-CBC&qu=
ot;;</span><br><span>     o=2Eauthname =3D &quot;none&quot;;</span><br><spa=
n>     linkmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(linkmtu, 14=
40);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(linkmtu, 1437);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    /* secret, cipher none, auth SHA256 */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* cipher none, auth SHA256 */=
</span><br><span>     o=2Eciphername =3D &quot;none&quot;;</span><br><span>=
     o=2Eauthname =3D &quot;SHA256&quot;;</span><br><span>     linkmtu =3D =
calc_options_string_link_mtu(&amp;o, &amp;f);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    assert_int_equal(linkmtu, 1440);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(linkmtu, 1437=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   /* secret, cipher BF-CBC, auth SHA1 */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* cipher BF-CBC, auth SHA1 */</span><br><span>  =
   o=2Eciphername =3D &quot;BF-CBC&quot;;</span><br><span>     o=2Eauthname=
 =3D &quot;SHA1&quot;;</span><br><span>     linkmtu =3D calc_options_string=
_link_mtu(&amp;o, &amp;f);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    assert_int_equal(linkmtu, 1444);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(linkmtu, 1441);</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* secret, ciphe=
r BF-CBC, auth SHA1, tcp-client */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* cipher BF-CBC, auth SHA1, tcp-client */</span><br><sp=
an>     o=2Ece=2Eproto =3D PROTO_TCP_CLIENT;</span><br><span>     linkmtu =
=3D calc_options_string_link_mtu(&amp;o, &amp;f);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    assert_int_equal(linkmtu, 1446);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(linkmtu, =
1443);</span><br><span> </span><br><span>     o=2Ece=2Eproto =3D PROTO_UDP;=
</span><br><span> </span><br><span> #if defined(USE_COMP)</span><br><span> =
    o=2Ecomp=2Ealg =3D COMP_ALG_LZO;</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    /* secret, comp-lzo yes, cipher BF-CBC=
, auth SHA1 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
*  comp-lzo yes, cipher BF-CBC, auth SHA1 */</span><br><span>     linkmtu =
=3D calc_options_string_link_mtu(&amp;o, &amp;f);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    assert_int_equal(linkmtu, 1445);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(linkmtu, =
1442);</span><br><span> </span><br><span> #if defined(ENABLE_FRAGMENT)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* secret, comp-lzo ye=
s, cipher BF-CBC, auth SHA1, fragment 1200 */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* comp-lzo yes, cipher BF-CBC, auth SHA1, fr=
agment 1200 */</span><br><span>     o=2Ece=2Efragment =3D 1200;</span><br><=
span>     linkmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(linkmtu,=
 1449);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(linkmtu, 1446);</span><br><span>     o=2Ece=2Efragment =3D 0;</spa=
n><br><span> #endif</span><br><span> </span><br><span>     o=2Ecomp=2Ealg =
=3D COMP_ALG_UNDEF;</span><br><span> #endif</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    /* TLS mode */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    o=2Eshared_secret_file =3D NULL;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o=2Etls_client =3D =
true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o=2Epull =3D=
 true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n>     /* tls client, cipher AES-128-CBC, auth SHA1, tls-auth */</span><br>=
<span>     o=2Eauthname =3D &quot;SHA1&quot;;</span><br><span>     o=2Eciph=
ername =3D &quot;AES-128-CBC&quot;;</span><br><span>@@ -315,15 +303,8 @@</s=
pan><br><span>     linkmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f)=
;</span><br><span>     assert_int_equal(linkmtu, 1457);</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* tls client, ciph=
er none, auth none */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* tls client, auth none, cipher AES-256-GCM */</span><br><span>     =
o=2Eauthname =3D &quot;none&quot;;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    o=2Eciphername =3D &quot;none&quot;;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    linkmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(lin=
kmtu, 1405);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    /* tls client, auth SHA1, =
cipher AES-256-GCM */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    o=2Eauthname =3D &quot;SHA1&quot;;</span><br><span>     o=2Eciphername =
=3D &quot;AES-256-GCM&quot;;</span><br><span>     linkmtu =3D calc_options_=
string_link_mtu(&amp;o, &amp;f);</span><br><span>     assert_int_equal(link=
mtu, 1449);</span><br><span>@@ -332,12 +313,12 @@</span><br><span> #if defi=
ned(USE_COMP) &amp;&amp; defined(ENABLE_FRAGMENT)</span><br><span>     o=2E=
comp=2Ealg =3D COMP_ALG_LZO;</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    /* tls client, auth SHA1, cipher AES-256-GCM, =
fragment, comp-lzo yes */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* tls client, auth none, cipher AES-256-GCM, fragment, comp-lzo =
yes */</span><br><span>     o=2Ece=2Efragment =3D 1200;</span><br><span>   =
  linkmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);</span><br><span=
>     assert_int_equal(linkmtu, 1454);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    /* tls client, auth SHA1, cipher AES=
-256-GCM, fragment, comp-lzo yes, socks */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* tls client, auth none, cipher AES-256-GCM, fr=
agment, comp-lzo yes, socks */</span><br><span>     o=2Ece=2Esocks_proxy_se=
rver =3D &quot;socks=2Eexample=2Ecom&quot;;</span><br><span>     linkmtu =
=3D calc_options_string_link_mtu(&amp;o, &amp;f);</span><br><span>     asse=
rt_int_equal(linkmtu, 1464);</span><br><span>@@ -358,50 +339,41 @@</span><b=
r><span>     o=2Ece=2Etun_mtu =3D 1400;</span><br><span>     o=2Ece=2Emssfi=
x =3D 1000;</span><br><span>     o=2Ece=2Eproto =3D PROTO_UDP;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    o=2Etls_client =3D true;</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* =
No crypto at all */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /*auth none, cipher none */</span><br><span>     o=2Eciphername =3D &qu=
ot;none&quot;;</span><br><span>     o=2Eauthname =3D &quot;none&quot;;</spa=
n><br><span>     struct key_type kt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    init_key_type(&amp;kt, o=2Eciphername, o=2Eauthname, fal=
se, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    init=
_key_type(&amp;kt, o=2Eciphername, o=2Eauthname, false);</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* No encryption, =
just packet id (8) + TCP payload(20) + IP payload(20) */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* No encryption, just packet id (=
4) + opcode (1) + TCP payload(20) + IP payload(20) */</span><br><span>     =
frame_calculate_dynamic(&amp;f, &amp;kt, &amp;o, NULL);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(f=2Emss_fix, 952);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(=
f=2Emss_fix, 955);</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    /* Static key OCC examples */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    o=2Eshared_secret_file =3D &quot;not null&qu=
ot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    /* secret, auth none, cipher none =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o=2Eciphername =
=3D &quot;none&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    o=2Eauthname =3D &quot;none&quot;;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    init_key_type(&amp;kt, o=2Eciphername, o=2Eauthname, f=
alse, false);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    fram=
e_calculate_dynamic(&amp;f, &amp;kt, &amp;o, NULL);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(f=2Emss_fix, 952);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    /* secret, cipher AES-128-CBC, auth none *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* cipher AES-=
128-CBC, auth none */</span><br><span>     o=2Eciphername =3D &quot;AES-128=
-CBC&quot;;</span><br><span>     o=2Eauthname =3D &quot;none&quot;;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    init_key_type(&amp;kt, o=
=2Eciphername, o=2Eauthname, false, false);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    init_key_type(&amp;kt, o=2Eciphername, o=2Eauth=
name, false);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    for (int i =3D 990; i &lt;=3D 1010; i++)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 990; i &lt;=3D 1015; =
i++)</span><br><span>     {</span><br><span>         /* 992 - 1008 should e=
nd up with the same mssfix value all they</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-         * all result in the same CBC block size/paddin=
g and &lt;=3D 991 and &gt;=3D1008</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+         * all result in the same CBC block size/padding and =
&lt;=3D 992 and &gt;=3D1009</span><br><span>          * should be one block=
 less and more respectively */</span><br><span>         o=2Ece=2Emssfix =3D=
 i;</span><br><span>         frame_calculate_dynamic(&amp;f, &amp;kt, &amp;=
o, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (=
i &lt;=3D 991)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (i &lt;=3D 992)</span><br><span>         {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            assert_int_equal(f=2Emss_fix, 911);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            assert_i=
nt_equal(f=2Emss_fix, 915);</span><br><span>         }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        else if (i &gt;=3D 1008)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        else if (i &gt;=3D 10=
09)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            assert_int_equal(f=2Emss_fix, 943);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            assert_int_equal(f=2Emss_f=
ix, 947);</span><br><span>         }</span><br><span>         else</span><b=
r><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         assert_int_equal(f=2Emss_fix, 927);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            assert_int_equal(f=2Emss_fix, 931);</s=
pan><br><span>         }</span><br><span>     }</span><br><span> #ifdef USE=
_COMP</span><br><span>@@ -410,36 +382,35 @@</span><br><span>     /* Same bu=
t with compression added=2E Compression adds one byte extra to the</span><b=
r><span>      * payload so the payload should be reduced by compared to the=
 no</span><br><span>      * compression calculation before */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 990; i &lt;=3D 1=
010; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (i=
nt i =3D 990; i &lt;=3D 1015; i++)</span><br><span>     {</span><br><span> =
        /* 992 - 1008 should end up with the same mssfix value all they</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-         * all result in =
the same CBC block size/padding and &lt;=3D 991 and &gt;=3D1008</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+         * all result in the sa=
me CBC block size/padding and &lt;=3D 992 and &gt;=3D1009</span><br><span> =
         * should be one block less and more respectively */</span><br><spa=
n>         o=2Ece=2Emssfix =3D i;</span><br><span>         frame_calculate_=
dynamic(&amp;f, &amp;kt, &amp;o, NULL);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (i &lt;=3D 991)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (i &lt;=3D 992)</span><br><span>       =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            assert=
_int_equal(f=2Emss_fix, 910);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            assert_int_equal(f=2Emss_fix, 914);</span><br><span> =
        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else=
 if (i &gt;=3D 1008)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        else if (i &gt;=3D 1009)</span><br><span>         {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            assert_int_equal(f=2Emss=
_fix, 942);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    assert_int_equal(f=2Emss_fix, 946);</span><br><span>         }</span><b=
r><span>         else</span><br><span>         {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            assert_int_equal(f=2Emss_fix, 926);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            assert_i=
nt_equal(f=2Emss_fix, 930);</span><br><span>         }</span><br><span>    =
 }</span><br><span>     o=2Ecomp=2Ealg =3D COMP_ALG_UNDEF;</span><br><span>=
 #endif /* ifdef USE_COMP */</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    /* tls client, auth SHA1, cipher AES-256-GCM *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*  auth SHA1,=
 cipher AES-256-GCM */</span><br><span>     o=2Eauthname =3D &quot;SHA1&quo=
t;;</span><br><span>     o=2Eciphername =3D &quot;AES-256-GCM&quot;;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    o=2Etls_client =3D true;=
</span><br><span>     o=2Epeer_id =3D 77;</span><br><span>     o=2Euse_peer=
_id =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    init=
_key_type(&amp;kt, o=2Eciphername, o=2Eauthname, true, false);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    init_key_type(&amp;kt, o=2Ec=
iphername, o=2Eauthname, false);</span><br><span> </span><br><span>     for=
 (int i =3D 900; i &lt;=3D 1200; i++)</span><br><span>     {</span><br><spa=
n>@@ -685,7 +656,7 @@</span><br><span> </span><br><span>     data-&gt;gc =
=3D gc_new();</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    init_key_type(&amp;data-&gt;kt, &quot;AES-128-GCM&quot;, &quo=
t;none&quot;, true, false);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    init_key_type(&amp;data-&gt;kt, &quot;AES-128-GCM&quot;, &quot;=
none&quot;, false);</span><br><span> </span><br><span>     /* have an epoch=
 key that uses 0x23 for the key for all bytes */</span><br><span>     struc=
t epoch_key epoch1send =3D { =2Eepoch =3D 1, =2Eepoch_key =3D { 0x23 } };</=
span><br><span>@@ -907,7 +878,7 @@</span><br><span>     struct epoch_key e1=
7 =3D { =2Eepoch =3D 17, =2Eepoch_key =3D { 19, 12 } };</span><br><span>   =
  struct key_type kt =3D { 0 };</span><br><span>     struct key_parameters =
key_parameters =3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    init_key_type(&amp;kt, &quot;AES-192-GCM&quot;, &quot;none&quot;, t=
rue, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ini=
t_key_type(&amp;kt, &quot;AES-192-GCM&quot;, &quot;none&quot;, false);</spa=
n><br><span> </span><br><span> </span><br><span>     epoch_data_key_derive(=
&amp;key_parameters, &amp;e17, &amp;kt);</span><br><span>diff --git a/tests=
/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec</s=
pan><br><span>index fbbb40f=2E=2E49ba833 100644</span><br><span>--- a/tests=
/unit_tests/openvpn/test_pkt=2Ec</span><br><span>+++ b/tests/unit_tests/ope=
nvpn/test_pkt=2Ec</span><br><span>@@ -173,7 +173,7 @@</span><br><span>     =
tas=2Etls_wrap=2Eopt=2Eflags |=3D (CO_IGNORE_PACKET_ID | CO_PACKET_ID_LONG_=
FORM);</span><br><span> </span><br><span>     struct key_type tls_crypt_kt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_key_type(&am=
p;tls_crypt_kt, &quot;none&quot;, &quot;SHA1&quot;, true, false);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    init_key_type(&amp;tls_cr=
ypt_kt, &quot;none&quot;, &quot;SHA1&quot;, false);</span><br><span> </span=
><br><span>     crypto_read_openvpn_key(&amp;tls_crypt_kt, &amp;tas=2Etls_w=
rap=2Eopt=2Ekey_ctx_bi, static_key, true,</span><br><span>                 =
            key_direction, &quot;Control Channel Authentication&quot;, &quo=
t;tls-auth&quot;, NULL);</span><br></pre><p>To view, visit <a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail">change 2081</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icadb=
ee50a3af55f0f2069f6d6f1ccc746180f368 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 2081 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></h=
tml>
--BtF+1rhSrMc=--


--===============4798911225964733972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4798911225964733972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4798911225964733972==--

