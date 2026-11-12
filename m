Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86849606A321
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KbTV9CJG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Z5B/Bffr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=T3LrQeOC;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IE7RtxFR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dlpJhsNR2sTpxhwr6x6kzaQL2eHr0rSzL/i/MlkktwA=; b=KbTV9CJGCoaQ8L3KDkV5RpToOb
	ZveadjiTkxZNIwnpmMpw+7FkKm94P8pD3h2yvtxgZcafG99NPB5DKP7/ZP2GpwqEnJmf8dnJ613Zy
	wyHggiG+bRLRXLkDya4OvPPnMt3SQPTqBKkTaM2H12S4qNl71w+xJ90D4uK7GLE0bq5g=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRXcl-000000007cp-08nC;
	Thu, 12 Nov 2026 16:26:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRXce-000000007cF-3rlf
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 16:26:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QtZZsrtdqtGOGmDX5aB/26I1IArUrZPxqTusV7FAAUg=; b=Z5B/BffrPXLztubIngzKU2wWS5
 07qYsj6V7pxOmFQM4uuouEJoQezBTQwIqf1UfNewdOzP7ipDTLGjfJIb/wEmEQpYTX3KLrzScsCb0
 PW18MkMvZoXRfDLeqMqKtTIMJX9k8BJ8qTEo6AVxdxPIXsigfoahlH0AKryBo/TI28iE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QtZZsrtdqtGOGmDX5aB/26I1IArUrZPxqTusV7FAAUg=; b=T3LrQeOCaE1EcWGDJfL0vdhv+P
 jPOc4nhKpz76q1FhHN6hFbWmoWdiAP75z0fGfcXOkpQoehUqPZ8Ar+T9YYcr5shTe5czXpXTL14Pz
 jbFwbVE8VcVe4lnoJKXwkvVzIEKHmf9FbmZp0xNEoEOhgPvQrv9kI25AvRILPznujnkA=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRXcX-000000005xy-4BZe for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 16:26:00 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so32012885e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 08:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794500747; x=1795105547; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QtZZsrtdqtGOGmDX5aB/26I1IArUrZPxqTusV7FAAUg=;
 b=IE7RtxFRXQxEsGHdllDoLT3dkHUb75Q7Qb6Xd3o9b5G2l0BRPnezl/1tPqYxHRkxxw
 JYhacNwX1HiWG8HbeIR0mnTst1u8oh1WbeYXaurLpsBViqafqZmysNuaUposM3Fqax0O
 2gx7K01EHSUBE+WlT9L0SBFlfsAcujSG00kluLjfVVB4EvwrXUzg0f65FSoMXOxRYnWO
 Z4gm+MjoR3svaXoVkurtq32CCpJl0Zcw4eZUnVPx8uz+BmQHWkJzwHk8chQSyjQNAzg8
 Nbr+APrEJWe6+zuHZQdrpRj6aeJWVYrR41gcKhe+TvZ51NZTWEHg7gpWXXuWsRXIVQ6W
 Q/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794500747; x=1795105547;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QtZZsrtdqtGOGmDX5aB/26I1IArUrZPxqTusV7FAAUg=;
 b=l27uRG6ev3HqChhzR1VKUvKc4FR5mud6fvDIFS0fDtucugpb5/NVGfRyarW6mF6Ydq
 AKPWsp95cXGV6AYLJ1w68ZEyfD7DWDpQbMl321UVxdZ851j24byLY/Cu2+NkPcU1NQ9G
 MHI5r/koNiG+L6qOwLwGPWe/24F6w9x0MGrAoajWN9PicFpD4D0Jtu/SNynIJG27Otb+
 2hRQYA4nTPTjAqfqoth2fv4DB5NqESk2lB+Wj5948WcFkFsINNigSVQizlptV15RPGi6
 Ex1ZWWhUdTY7Sebxcf3qETdh5zbfmagOrthfyH5h3LtKSSUKEBZfdpAtYm1x1CfgdWL1
 fjZA==
X-Forwarded-Encrypted: i=1;
 AL+hErEw5doSg9UK0MbjJu1S3mye1U9b7F8oVK2ji1dbHR3pHindvh7amJUFtxkgKix4ZDYWJuiM6MpLGHZQ4KNp@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8sJFOmzdhLR0PXbBAqOjwEZiIytMtaAupEm0gqRTsIIVLe3b87
 P5RVLPe+cOtjXwsXLE0C/K4CCQdBkPAslGyVwBd8r+kZL1GB+STW7EZtJiLRMq5cYCHu6Xp32M4
 yJCUBskLbH4Fib6WBzYvttIXjegqzven/KCwWOkjnHLSUAS5ovr5TQ0+hcGHOBMqbvJ1xJ+POH4
 jsrLX/NQ==
X-Gm-Gg: AYBFou3Wdzr94RDv3bmBThJaHnRvnNWNk6hH7YrqWUjp8QamfDj0CxAJ6FTNkxHWjFg
 cF+aJVvK9vXZHEaZDibb0w9f7nWzczjjK9hsJ+oskbY6pBNfKYPaI9jgHFtO4EDdepdcGJqp64q
 AlPhajw+h24wj8RWNA/R5g1DyxQhySnETdcJu7SHAN98tkytySCf7XayHqAQYKFFqFWC6E9zLEv
 iN6vadCdQ+CuVIlkfpgOTf0WyZKiPmxmaL5sM240is6ikVnuF8ZBoE09uOgcGwxVICLwnrcs/Cs
 wJle3GvwHtGYx3NthdhRNi/D1S39j2aTDaECMbw7WEGF0OCCp0sxAQ8n7DuQ12QTcZXKPzPfC5+
 E/knRJHT2QFF8hIaKdE64f9x4MN22czyuEzep61vo+0mdQ8AuUYlrH+W4fb1H/QDWmbS4J7yFad
 0c5ciN3w3UtL+o09SrMoEC1QWlqJsu+1RR1X26Yhp2BulgAOU50Sk7R8rBnnl/E+gxJQxGuWxvG
 QY0Rl6GdbeaBAIDSCx8mvrVtNYkNIpnlJ3SYiP1m8gqC5uTfzQvImwngYpmN2PC83e9iqbd7zgi
 Yl6tNZsr1jJE2lfNrSThL3/eCMK9XWy4pcpmQah0X4S0+eW5u3qaEyukHKZEQgjP5ZligflEaQH
 PcDs3126aMKkRs6iA0N4/WRi+crVIygZuvn4Zsk/Ye2mqE/c0ZlfJxbIdZBI3KvpqYfSy1RF5zK
 imfZLiWL8GXEKA620=
X-Received: by 2002:a05:600c:1c0c:b0:4b5:2c72:651c with SMTP id
 5b1f17b1804b1-4ba0939ccd0mr131721125e9.5.1794500746880; 
 Thu, 12 Nov 2026 08:25:46 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e33ae5bsm73148205e9.3.2026.11.12.08.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 08:25:46 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 16:25:45 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815
X-Gerrit-Change-Number: 2082
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2082?usp=email>
X-Gerrit-Commit: 5943795d11b9fec5170d72ca98ee72c993d57c37
In-Reply-To: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
References: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkk1ZWUyMzFkMTU3NDU5ZTY0MDZmMWY0YzEyY2Q2YzZlMGZjZTkzODE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4c38c15f9189fabbaa9722bb0bff9951db9b0541-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRXcX-000000005xy-4BZe
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove replay-persist
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
Content-Type: multipart/mixed; boundary="===============6587580082793479507=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6587580082793479507==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dcu/KSneve4="; charset=UTF-8

--dcu/KSneve4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2082?usp=3Demail )

Change subject: Remove replay-persist
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove replay-pe=
rsist

This feature is very niche and we do not think it is something we
sh=
ould maintain and support going forward=2E

This feature saves a single pac=
ket id to replay-persist file=2E
This makes the feature only properly work =
in a p2p setup where both
sides use replay-persist to save the last known p=
acket id from the
peer=2E Even then it will only prevent some packet replay=
s until the
legitimate peer sends a packet again=2E

In server mode (p2mp) =
each client context has its own replay state
and saving a single packet id =
is also not very useful with multiple
clients and multiple states=2E

Chang=
e-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815
Signed-off-by: Arne Schwabe=
 <arne@rfc2549=2Eorg>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Ger=
rit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082
Message-Id: <20261=
109195550=2E6096-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41040=2Ehtml
Signed-off-b=
y: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M Changes=2Emd
M config=2Eh=
=2Ecmake=2Ein
M configure=2Eac
M doc/man-sections/link-options=2Erst
M doc/=
man-sections/tls-options=2Erst
M doc/man-sections/unsupported-options=2Erst=

M src/openvpn/check_file_access=2Ec
M src/openvpn/crypto=2Ec
M src/openvpn=
/crypto=2Eh
M src/openvpn/errlevel=2Eh
M src/openvpn/forward=2Ec
M src/open=
vpn/init=2Ec
M src/openvpn/openvpn=2Eh
M src/openvpn/options=2Ec
M src/open=
vpn/options=2Eh
M src/openvpn/options_show=2Ec
M src/openvpn/packet_id=2Ec
=
M src/openvpn/packet_id=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/syshead=2Eh=

M src/openvpn/tls_crypt=2Ec
21 files changed, 33 insertions(+), 330 deleti=
ons(-)




diff --git a/Changes=2Emd b/Changes=2Emd
index 7f47f77=2E=2E89a7=
2fe 100644
--- a/Changes=2Emd
+++ b/Changes=2Emd
@@ -30,6 +30,12 @@
   "too=
 complicated", using `--peer-fingerprint` makes TLS mode about as easy as
 =
  using `--secret`=2E
 
+* **`replay-persist` has been removed**
+
+  This =
feature has been removed as it was never properly implemented for
+  server=
 mode and generally was a niche feature=2E If the option is present
+  it w=
ill be ignored=2E
+
 ## Maintainer-visible changes
 
 - The configure-time =
option `--enable-debug` is no longer  available
diff --git a/config=2Eh=2Ec=
make=2Ein b/config=2Eh=2Ecmake=2Ein
index 5e06a63=2E=2Ef7818cf 100644
--- a=
/config=2Eh=2Ecmake=2Ein
+++ b/config=2Eh=2Ecmake=2Ein
@@ -285,9 +285,6 @@
=
 /* Define to 1 if you have the <sys/epoll=2Eh> header file=2E */
 #cmakede=
fine HAVE_SYS_EPOLL_H
 
-/* Define to 1 if you have the <sys/file=2Eh> head=
er file=2E */
-#undef HAVE_SYS_FILE_H
-
 /* Define to 1 if you have the <sy=
s/inotify=2Eh> header file=2E */
 #cmakedefine HAVE_SYS_INOTIFY_H
 
diff --=
git a/configure=2Eac b/configure=2Eac
index 5f18798=2E=2E9326c4e 100644
---=
 a/configure=2Eac
+++ b/configure=2Eac
@@ -453,7 +453,7 @@
 ])
 AC_CHECK_HE=
ADERS([ \
 	sys/time=2Eh sys/ioctl=2Eh sys/stat=2Eh \
-	sys/mman=2Eh sys/fi=
le=2Eh sys/wait=2Eh \
+	sys/mman=2Eh sys/wait=2Eh \
 	libgen=2Eh stropts=2E=
h \
 	syslog=2Eh pwd=2Eh grp=2Eh \
 	sys/sockio=2Eh sys/uio=2Eh \
@@ -561,8=
 +561,7 @@
 AC_CHECK_FUNCS([ \
 	daemon chroot getpwnam setuid nice dup dup=
2 \
 	syslog openlog mlockall getrlimit getgrnam setgid \
-	setgroups flock=
 gettimeofday \
-	setsid chdir \
+	setgroups gettimeofday setsid chdir \
 	=
chsize ftruncate execve getpeereid basename dirname \
 	epoll_create strlcp=
y strsep strtok_r \
 ])
diff --git a/doc/man-sections/link-options=2Erst b/=
doc/man-sections/link-options=2Erst
index 735ee51=2E=2Ebbdcf7f 100644
--- a=
/doc/man-sections/link-options=2Erst
+++ b/doc/man-sections/link-options=2E=
rst
@@ -440,19 +440,6 @@
   physical IP layer=2E The problem is easily fixe=
d by simply using TCP as
   the VPN transport layer=2E
 
---replay-persist =
file
-  Persist replay-protection state across sessions using ``file`` to s=
ave
-  and reload the state=2E
-
-  This option will keep a disk copy of th=
e current replay protection state
-  (i=2Ee=2E the most recent packet times=
tamp and sequence number received from
-  the remote peer), so that if an O=
penVPN session is stopped and
-  restarted, it will reject any replays of p=
ackets which were already
-  received by the prior session=2E
-
-  This opt=
ion only makes sense when replay protection is enabled (the
-  default) and=
 you are using TLS mode with ``--tls-auth``=2E
-
 --session-timeout n
   Ra=
ises :code:`SIGTERM` for the client instance after ``n`` seconds since
   t=
he beginning of the session, forcing OpenVPN to disconnect=2E
diff --git a/=
doc/man-sections/tls-options=2Erst b/doc/man-sections/tls-options=2Erst
ind=
ex c4aa810=2E=2Ede4d324 100644
--- a/doc/man-sections/tls-options=2Erst
+++=
 b/doc/man-sections/tls-options=2Erst
@@ -370,10 +370,7 @@
   level has had=
 a chance to authenticate the peer=2E The result is that
   packets without=
 the correct signature can be dropped immediately upon
   reception, before=
 they have a chance to consume additional system
-  resources such as by in=
itiating a TLS handshake=2E ``--tls-auth`` can be
-  strengthened by adding=
 the ``--replay-persist`` option which will keep
-  OpenVPN's replay protec=
tion state in a file so that it is not lost
-  across restarts=2E
+  resour=
ces such as by initiating a TLS handshake=2E
 
   It should be emphasized t=
hat this feature is optional and that the key
   file used with ``--tls-aut=
h`` gives a peer nothing more than the power
diff --git a/doc/man-sections/=
unsupported-options=2Erst b/doc/man-sections/unsupported-options=2Erst
inde=
x 2794f12=2E=2E368805e 100644
--- a/doc/man-sections/unsupported-options=2E=
rst
+++ b/doc/man-sections/unsupported-options=2Erst
@@ -79,3 +79,8 @@
 
 -=
-allow-deprecated-insecure-static-crypto
   Removed in OpenVPN 2=2E8 as --s=
ecret was also removed=2E
+
+--replay-persist
+  Removed in OpenVPN 2=2E8=
=2E This option never really worked well with ``--server``
+  and the usefu=
lness of this option in p2p setups is not very high either=2E
+  It is now =
ignored if present in the configuration file=2E
diff --git a/src/openvpn/ch=
eck_file_access=2Ec b/src/openvpn/check_file_access=2Ec
index ab2535d=2E=2E=
be9b4b2 100644
--- a/src/openvpn/check_file_access=2Ec
+++ b/src/openvpn/ch=
eck_file_access=2Ec
@@ -312,9 +312,6 @@
                                   =
       ce->tls_crypt_v2_file, R_OK, "--tls-crypt-v2");
     }
 
-    errs |=
=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->packet_id=
_file,
-                              R_OK | W_OK, "--replay-persist");
-
 =
    /* ** Password files ** */
     errs |=3D check_file_access(CHKACC_FILE=
 | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
                               option=
s->key_pass_file, R_OK, "--askpass");
diff --git a/src/openvpn/crypto=2Ec b=
/src/openvpn/crypto=2Ec
index a8ad7f0=2E=2E6efa005 100644
--- a/src/openvpn=
/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -403,10 +403,6 @@
     if (pack=
et_id_test(recv, pin))
     {
         packet_id_add(recv, pin);
-        i=
f (opt->pid_persist && (opt->flags & CO_PACKET_ID_LONG_FORM))
-        {
- =
           packet_id_persist_save_obj(opt->pid_persist, &opt->packet_id);
-=
        }
         ret =3D true;
     }
     else
diff --git a/src/openvpn/=
crypto=2Eh b/src/openvpn/crypto=2Eh
index a03c5ce=2E=2E7e240d2 100644
--- a=
/src/openvpn/crypto=2Eh
+++ b/src/openvpn/crypto=2Eh
@@ -332,11 +332,6 @@
 =
                                 *   The packet id also used as the IV
    =
                              *   for AEAD/OFB/CFG ciphers=2E
             =
                     */
-    struct packet_id_persist *pid_persist;
-    /*=
*< Persistent packet ID state for
-     *   keeping state between successiv=
e
-     *   OpenVPN process startups=2E */
-
 #define CO_PACKET_ID_LONG_FOR=
M         (1u << 0)
     /**< Bit-flag indicating whether to use
      *   =
OpenVPN's long packet ID format=2E */
diff --git a/src/openvpn/errlevel=2Eh=
 b/src/openvpn/errlevel=2Eh
index e52cb65=2E=2E5cea0ad 100644
--- a/src/ope=
nvpn/errlevel=2Eh
+++ b/src/openvpn/errlevel=2Eh
@@ -64,7 +64,6 @@
 #define=
 D_MULTI_ERRORS   LOGLEV(1, 9, M_NONFATAL)  /* show multi-client server err=
ors */
 #define D_EVENT_ERRORS   LOGLEV(1, 10, M_NONFATAL) /* show event=2E=
[ch] errors */
 #define D_PUSH_ERRORS    LOGLEV(1, 11, M_NONFATAL) /* show =
push/pull errors */
-#define D_PID_PERSIST    LOGLEV(1, 12, M_NONFATAL) /* =
show packet_id persist errors */
 #define D_FRAG_ERRORS    LOGLEV(1, 13, M_=
NONFATAL) /* show fragmentation errors */
 #define D_ALIGN_ERRORS   LOGLEV(=
1, 14, M_NONFATAL) /* show bad struct alignments */
 
@@ -159,16 +158,15 @@=

 #define D_EVENT_WAIT        LOGLEV(8, 70, M_DEBUG)      /* show detailed =
info from event waits */
 #define D_MULTI_TCP         LOGLEV(8, 70, M_DEBUG=
)      /* show debug info from mtcp=2Ec */
 
-#define D_TLS_DEBUG         L=
OGLEV(9, 70, M_DEBUG)      /* show detailed info from TLS routines */
-#def=
ine D_COMP              LOGLEV(9, 70, M_DEBUG)      /* show compression inf=
o */
-#define D_READ_WRITE        LOGLEV(9, 70, M_DEBUG)      /* show all t=
un/tcp/udp reads/writes/opens */
-#define D_PACKET_CONTENT    LOGLEV(9, 70,=
 M_DEBUG)      /* show before/after encryption packet content */
-#define D=
_TLS_NO_SEND_KEY   LOGLEV(9, 70, M_DEBUG)      /* show when no data channel=
 send-key exists */
-#define D_PID_PERSIST_DEBUG LOGLEV(9, 70, M_DEBUG)    =
  /* show packet-id persist debugging info */
-#define D_LINK_RW_VERBOSE   =
LOGLEV(9, 70, M_DEBUG)      /* increase link reads/writes verbosity */
-#de=
fine D_STREAM_DEBUG      LOGLEV(9, 70, M_DEBUG)      /* show TCP stream deb=
ug info */
-#define D_WIN32_IO          LOGLEV(9, 70, M_DEBUG)      /* win3=
2 I/O debugging info */
-#define D_PKCS11_DEBUG      LOGLEV(9, 70, M_DEBUG)=
      /* show PKCS#11 debugging */
+#define D_TLS_DEBUG       LOGLEV(9, 70,=
 M_DEBUG)        /* show detailed info from TLS routines */
+#define D_COMP=
            LOGLEV(9, 70, M_DEBUG)        /* show compression info */
+#def=
ine D_READ_WRITE      LOGLEV(9, 70, M_DEBUG)        /* show all tun/tcp/udp=
 reads/writes/opens */
+#define D_PACKET_CONTENT  LOGLEV(9, 70, M_DEBUG)   =
     /* show before/after encryption packet content */
+#define D_TLS_NO_SE=
ND_KEY LOGLEV(9, 70, M_DEBUG)        /* show when no data channel send-key =
exists */
+#define D_LINK_RW_VERBOSE LOGLEV(9, 70, M_DEBUG)        /* incre=
ase link reads/writes verbosity */
+#define D_STREAM_DEBUG    LOGLEV(9, 70,=
 M_DEBUG)        /* show TCP stream debug info */
+#define D_WIN32_IO      =
  LOGLEV(9, 70, M_DEBUG)        /* win32 I/O debugging info */
+#define D_P=
KCS11_DEBUG    LOGLEV(9, 70, M_DEBUG)        /* show PKCS#11 debugging */
 =

 #define D_SHAPER_DEBUG LOGLEV(10, 70, M_DEBUG)          /* show traffic s=
haper info */
 
diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=
=2Ec
index 82cb6c9=2E=2Eba0e0ec 100644
--- a/src/openvpn/forward=2Ec
+++ b/=
src/openvpn/forward=2Ec
@@ -749,14 +749,6 @@
 static void
 process_coarse_t=
imers(struct context *c)
 {
-    /* flush current packet-id to file once pe=
r 60
-     * seconds if --replay-persist was specified */
-    if (packet_i=
d_persist_enabled(&c->c1=2Epid_persist)
-        && event_timeout_trigger(&=
c->c2=2Epacket_id_persist_interval, &c->c2=2Etimeval, ETT_DEFAULT))
-    {
=
-        packet_id_persist_save(&c->c1=2Epid_persist);
-    }
-
     /* Sho=
uld we write timer-triggered status file */
     if (c->c1=2Estatus_output
=
         && event_timeout_trigger(&c->c1=2Estatus_output->et, &c->c2=2Etime=
val, ETT_DEFAULT))
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec=

index 29c24f2=2E=2Eaef2f14 100644
--- a/src/openvpn/init=2Ec
+++ b/src/ope=
nvpn/init=2Ec
@@ -67,7 +67,6 @@
 /*
  * Crypto initialization flags
  */
-#=
define CF_LOAD_PERSISTED_PACKET_ID (1 << 0)
 #define CF_INIT_TLS_MULTI     =
      (1 << 1)
 #define CF_INIT_TLS_AUTH_STANDALONE (1 << 2)
 
@@ -738,8 +7=
37,6 @@
 {
     context_clear_1(c);
 
-    packet_id_persist_init(&c->c1=2E=
pid_persist);
-
     init_connection_list(c);
 
     c->c1=2Elink_sockets_n=
um =3D c->options=2Ece=2Elocal_list->len;
@@ -1347,12 +1344,6 @@
          =
                      now);
         }
 
-        /* initialize packet_id p=
ersistence timer */
-        if (c->options=2Epacket_id_file)
-        {
- =
           event_timeout_init(&c->c2=2Epacket_id_persist_interval, 60, now)=
;
-        }
-
         /* initialize tmp_int optimization that limits the =
number of times we call
          * tls_multi_process in the main event loo=
p */
         interval_init(&c->c2=2Etmp_int, TLS_MULTI_HORIZON, TLS_MULTI_=
REFRESH);
@@ -2976,31 +2967,15 @@
 }
 
 static void
-init_crypto_pre(struct=
 context *c, const unsigned int flags)
-{
-    if (c->options=2Eengine)
-  =
  {
-        crypto_init_lib_engine(c->options=2Eengine);
-    }
-
-    if =
(flags & CF_LOAD_PERSISTED_PACKET_ID)
-    {
-        /* load a persisted p=
acket-id for cross-session replay-protection */
-        if (c->options=2Ep=
acket_id_file)
-        {
-            packet_id_persist_load(&c->c1=2Epid_=
persist, c->options=2Epacket_id_file);
-        }
-    }
-}
-
-
-static voi=
d
 do_init_crypto_test(struct context *c)
 {
     const struct options *opt=
ions =3D &c->options;
     ASSERT(options->test_crypto);
 
-    init_crypto=
_pre(c, 0);
+    if (c->options=2Eengine)
+    {
+        crypto_init_lib_e=
ngine(c->options=2Eengine);
+    }
 
     c->c2=2Ecrypto_options=2Eflags |=
=3D CO_PACKET_ID_LONG_FORM;
 
@@ -3201,7 +3176,10 @@
     ASSERT(options->t=
ls_server || options->tls_client);
     ASSERT(!options->test_crypto);
 
- =
   init_crypto_pre(c, flags);
+    if (c->options=2Eengine)
+    {
+       =
 crypto_init_lib_engine(c->options=2Eengine);
+    }
 
     /* Make sure we=
 are either a TLS client or server but not both */
     ASSERT(options->tls=
_server =3D=3D !options->tls_client);
@@ -3380,7 +3358,6 @@
     if (to=2Et=
ls_wrap=2Emode =3D=3D TLS_WRAP_AUTH || to=2Etls_wrap=2Emode =3D=3D TLS_WRAP=
_CRYPT)
     {
         to=2Etls_wrap=2Eopt=2Ekey_ctx_bi =3D c->c1=2Eks=2Et=
ls_wrap_key;
-        to=2Etls_wrap=2Eopt=2Epid_persist =3D &c->c1=2Epid_pe=
rsist;
         to=2Etls_wrap=2Eopt=2Eflags |=3D CO_PACKET_ID_LONG_FORM;
  =
       to=2Etls_wrap=2Eoriginal_wrap_keydata =3D c->c1=2Eks=2Eoriginal_wrap=
_keydata;
     }
@@ -3939,11 +3916,6 @@
 do_close_packet_id(struct context =
*c)
 {
     packet_id_free(&c->c2=2Ecrypto_options=2Epacket_id);
-    packe=
t_id_persist_save(&c->c1=2Epid_persist);
-    if (!(c->sig->signal_received=
 =3D=3D SIGUSR1))
-    {
-        packet_id_persist_close(&c->c1=2Epid_pers=
ist);
-    }
 }
 
 #ifdef ENABLE_FRAGMENT
@@ -4498,7 +4470,7 @@
         }
=
         else if (c->mode =3D=3D CM_P2P)
         {
-            crypto_fla=
gs =3D CF_LOAD_PERSISTED_PACKET_ID | CF_INIT_TLS_MULTI;
+            crypto=
_flags =3D CF_INIT_TLS_MULTI;
         }
         else if (child)
         =
{
@@ -4756,7 +4728,6 @@
     ALLOC_OBJ_CLEAR_GC(dest->sig, struct signal_in=
fo, &dest->gc);
 
     /* c1 init */
-    packet_id_persist_init(&dest->c1=
=2Epid_persist);
     dest->c1=2Elink_sockets_num =3D 1;
     do_link_socke=
t_addr_new(dest);
 
diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/open=
vpn=2Eh
index 970baa9=2E=2Ead6be88 100644
--- a/src/openvpn/openvpn=2Eh
+++=
 b/src/openvpn/openvpn=2Eh
@@ -75,21 +75,6 @@
 };
 
 /*
- * struct packet_i=
d_persist should be empty if we are not
- * building with crypto=2E
- */
-#=
ifndef PACKET_ID_H
-struct packet_id_persist
-{
-    int dummy;
-};
-static=
 inline void
-packet_id_persist_init(struct packet_id_persist *p)
-{
-}
-#e=
ndif
-
-/*
  * Packet processing buffers=2E
  */
 struct context_buffers
@@=
 -167,9 +152,6 @@
     /* preresolved and cached host names */
     struct =
cached_dns_entry *dns_cache;
 
-    /* persist crypto sequence number to/fr=
om file */
-    struct packet_id_persist pid_persist;
-
     struct tuntap =
*tuntap; /**< Tun/tap virtual network interface=2E */
     bool tuntap_owne=
d;     /**< Whether the tun/tap interface should
                          =
   *   be cleaned up when this %context is
@@ -346,8 +328,6 @@
      *   Ch=
annel Crypto module\endlink to
      *   process data channel packet=2E */
=
 
-    struct event_timeout packet_id_persist_interval;
-
 #ifdef USE_COMP
=
     struct compress_context *comp_context;
     /**< Compression context u=
sed by the
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
i=
ndex 454d2d6=2E=2E9ed3964 100644
--- a/src/openvpn/options=2Ec
+++ b/src/op=
envpn/options=2Ec
@@ -571,8 +571,6 @@
     "--replay-window n [t]  : Use a =
replay protection sliding window of size n\n"
     "                       =
  and a time window of t seconds=2E\n"
     "                         Defau=
lt n=3D%d t=3D%d\n"
-    "--replay-persist file : Persist replay-protection=
 state across sessions\n"
-    "                  using file=2E\n"
     "--=
test-crypto   : Run a self-test of crypto features enabled=2E\n"
     "    =
              For debugging only=2E\n"
     "\n"
@@ -7088,7 +7086,7 @@
    =
 else if (streq(p[0], "replay-persist") && p[1] && !p[2])
     {
         V=
ERIFY_PERMISSION(OPT_P_GENERAL);
-        options->packet_id_file =3D p[1];=

+        msg(M_WARN, "DEPRECATED OPTION: --replay-persist option ignored=
=2E");
     }
     else if (streq(p[0], "test-crypto") && !p[1])
     {
dif=
f --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index 38554a1=
=2E=2Eb390ebc 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/option=
s=2Eh
@@ -582,7 +582,6 @@
     bool mute_replay_warnings;
     int replay_w=
indow;
     int replay_time;
-    const char *packet_id_file;
     bool tes=
t_crypto;
 
     /* TLS (control channel) parms */
diff --git a/src/openvpn=
/options_show=2Ec b/src/openvpn/options_show=2Ec
index 321a37b=2E=2E54f9c4c=
 100644
--- a/src/openvpn/options_show=2Ec
+++ b/src/openvpn/options_show=
=2Ec
@@ -501,7 +501,6 @@
     SHOW_BOOL(mute_replay_warnings);
     SHOW_IN=
T(replay_window);
     SHOW_INT(replay_time);
-    SHOW_STR(packet_id_file)=
;
     SHOW_BOOL(test_crypto);
 
     SHOW_BOOL(tls_server);
diff --git a/s=
rc/openvpn/packet_id=2Ec b/src/openvpn/packet_id=2Ec
index 9dd6ce3=2E=2Ef1f=
add6 100644
--- a/src/openvpn/packet_id=2Ec
+++ b/src/openvpn/packet_id=2Ec=

@@ -426,146 +426,6 @@
     return BSTR(&out);
 }
 
-/* initialize the pack=
et_id_persist structure in a disabled state */
-void
-packet_id_persist_ini=
t(struct packet_id_persist *p)
-{
-    p->filename =3D NULL;
-    p->fd =3D=
 -1;
-    p->time =3D p->time_last_written =3D 0;
-    p->id =3D p->id_last=
_written =3D 0;
-}
-
-/* close the file descriptor if it is open, and switc=
h to disabled state */
-void
-packet_id_persist_close(struct packet_id_pers=
ist *p)
-{
-    if (packet_id_persist_enabled(p))
-    {
-        if (close=
(p->fd))
-        {
-            msg(D_PID_PERSIST | M_ERRNO, "Close error =
on --replay-persist file %s", p->filename);
-        }
-        packet_id_p=
ersist_init(p);
-    }
-}
-
-/* load persisted rec packet_id (time and id) =
only once from file, and set state to enabled */
-void
-packet_id_persist_l=
oad(struct packet_id_persist *p, const char *filename)
-{
-    struct gc_ar=
ena gc =3D gc_new();
-    if (!packet_id_persist_enabled(p))
-    {
-      =
  /* open packet-id persist file for both read and write */
-        p->fd =
=3D platform_open(filename, O_CREAT | O_RDWR | O_BINARY, S_IRUSR | S_IWUSR)=
;
-        if (p->fd =3D=3D -1)
-        {
-            msg(D_PID_PERSIST |=
 M_ERRNO, "Cannot open --replay-persist file %s for read/write",
-         =
       filename);
-        }
-        else
-        {
-            struct p=
acket_id_persist_file_image image;
-            ssize_t n;
-
-#if defined(H=
AVE_FLOCK) && defined(LOCK_EX) && defined(LOCK_NB)
-            if (flock(p=
->fd, LOCK_EX | LOCK_NB))
-            {
-                msg(M_ERR, "Canno=
t obtain exclusive lock on --replay-persist file %s", filename);
-         =
   }
-#endif
-
-            p->filename =3D filename;
-            n =3D re=
ad(p->fd, &image, sizeof(image));
-            if (n =3D=3D sizeof(image))
=
-            {
-                p->time =3D p->time_last_written =3D image=
=2Etime;
-                p->id =3D p->id_last_written =3D image=2Eid;
-   =
             dmsg(D_PID_PERSIST_DEBUG, "PID Persist Read from %s: %s", p->f=
ilename,
-                     packet_id_persist_print(p, &gc));
-         =
   }
-            else if (n =3D=3D -1)
-            {
-                msg=
(D_PID_PERSIST | M_ERRNO, "Read error on --replay-persist file %s", p->file=
name);
-            }
-        }
-    }
-    gc_free(&gc);
-}
-
-/* save pe=
rsisted rec packet_id (time and id) to file (only if enabled state) */
-voi=
d
-packet_id_persist_save(struct packet_id_persist *p)
-{
-    if (packet_i=
d_persist_enabled(p) && p->time
-        && (p->time !=3D p->time_last_writ=
ten || p->id !=3D p->id_last_written))
-    {
-        struct packet_id_per=
sist_file_image image;
-        CLEAR(image);
-        off_t seek_ret;
-   =
     struct gc_arena gc =3D gc_new();
-
-        image=2Etime =3D p->time;
=
-        image=2Eid =3D p->id;
-        seek_ret =3D lseek(p->fd, (off_t)0,=
 SEEK_SET);
-        if (seek_ret =3D=3D (off_t)0)
-        {
-            =
const ssize_t n =3D write(p->fd, &image, sizeof(image));
-            if (n=
 =3D=3D sizeof(image))
-            {
-                p->time_last_written=
 =3D p->time;
-                p->id_last_written =3D p->id;
-             =
   dmsg(D_PID_PERSIST_DEBUG, "PID Persist Write to %s: %s", p->filename,
- =
                    packet_id_persist_print(p, &gc));
-            }
-     =
       else
-            {
-                msg(D_PID_PERSIST | M_ERRNO, "C=
annot write to --replay-persist file %s",
-                    p->filename)=
;
-            }
-        }
-        else
-        {
-            msg(D_PID=
_PERSIST | M_ERRNO, "Cannot seek to beginning of --replay-persist file %s",=

-                p->filename);
-        }
-        gc_free(&gc);
-    }
-}=

-
-/* transfer packet_id_persist -> packet_id */
-void
-packet_id_persist_=
load_obj(const struct packet_id_persist *p, struct packet_id *pid)
-{
-    =
if (p && pid && packet_id_persist_enabled(p) && p->time)
-    {
-        pi=
d->rec=2Etime =3D p->time;
-        pid->rec=2Eid =3D p->id;
-    }
-}
-
-c=
onst char *
-packet_id_persist_print(const struct packet_id_persist *p, str=
uct gc_arena *gc)
-{
-    struct buffer out =3D alloc_buf_gc(256, gc);
-
- =
   buf_printf(&out, "[");
-
-    if (packet_id_persist_enabled(p))
-    {
-=
        buf_printf(&out, " #" packet_id_format, (packet_id_print_type)p->id=
);
-        if (p->time)
-        {
-            buf_printf(&out, " / time =
=3D (" packet_id_format ") %s", (packet_id_print_type)p->time,
-           =
            time_string(p->time, 0, false, gc));
-        }
-    }
-
-    b=
uf_printf(&out, " ]");
-    return (char *)out=2Edata;
-}
-
 #ifndef ENABLE=
_SMALL
 
 static void
diff --git a/src/openvpn/packet_id=2Eh b/src/openvpn/=
packet_id=2Eh
index 48752d3=2E=2Ec374ccb 100644
--- a/src/openvpn/packet_id=
=2Eh
+++ b/src/openvpn/packet_id=2Eh
@@ -125,26 +125,6 @@
 };
 
 /*
- * fil=
e to facilitate cross-session persistence
- * of time/id
- */
-struct packe=
t_id_persist
-{
-    const char *filename;
-    int fd;
-    time_t time;  =
     /* time stamp */
-    packet_id_type id; /* sequence number */
-    ti=
me_t time_last_written;
-    packet_id_type id_last_written;
-};
-
-struct =
packet_id_persist_file_image
-{
-    time_t time;       /* time stamp */
- =
   packet_id_type id; /* sequence number */
-};
-
-/*
  * Keep a record of =
our current packet-id state
  * on the sending side=2E
  */
@@ -222,28 +202=
,6 @@
 void packet_id_reap(struct packet_id_rec *p);
 
 /*
- * packet ID pe=
rsistence
- */
-
-/* initialize the packet_id_persist structure in a disabl=
ed state */
-void packet_id_persist_init(struct packet_id_persist *p);
-
-/=
* close the file descriptor if it is open, and switch to disabled state */
=
-void packet_id_persist_close(struct packet_id_persist *p);
-
-/* load pers=
isted rec packet_id (time and id) only once from file, and set state to ena=
bled */
-void packet_id_persist_load(struct packet_id_persist *p, const cha=
r *filename);
-
-/* save persisted rec packet_id (time and id) to file (onl=
y if enabled state) */
-void packet_id_persist_save(struct packet_id_persis=
t *p);
-
-/* transfer packet_id_persist -> packet_id */
-void packet_id_per=
sist_load_obj(const struct packet_id_persist *p, struct packet_id *pid);
-
=
-/* return an ascii string representing a packet_id_persist object */
-cons=
t char *packet_id_persist_print(const struct packet_id_persist *p, struct g=
c_arena *gc);
-
-/*
  * Read/write a packet ID to/from the buffer=2E  Short=
 form is sequence number
  * only=2E  Long form is sequence number and time=
stamp=2E
  */
@@ -273,27 +231,6 @@
     return pid->rec=2Einitialized;
 }
 =

-/* are we in enabled state? */
-static inline bool
-packet_id_persist_ena=
bled(const struct packet_id_persist *p)
-{
-    return p->fd >=3D 0;
-}
-
-=
/* transfer packet_id -> packet_id_persist
-   Note: Only supported for non=
-epoch format (i=2Ee=2E 32bit ID, not 64bit format),
-   must be enforced a=
t the caller=2E
- */
-static inline void
-packet_id_persist_save_obj(struct=
 packet_id_persist *p, const struct packet_id *pid)
-{
-    if (packet_id_p=
ersist_enabled(p) && pid->rec=2Etime && pid->rec=2Eid <=3D PACKET_ID_MAX)
-=
    {
-        p->time =3D pid->rec=2Etime;
-        p->id =3D (packet_id_t=
ype)pid->rec=2Eid;
-    }
-}
-
 /**
  * Reset the current send packet id to=
 its initial state=2E
  * Use very carefully (e=2Eg=2E in the standalone re=
set packet context) to
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=
=2Ec
index a538b52=2E=2Ecdb94ed 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/=
openvpn/ssl=2Ec
@@ -874,8 +874,6 @@
     packet_id_init(&ks->crypto_options=
=2Epacket_id, session->opt->replay_window,
                    session->opt=
->replay_time, "SSL", ks->key_id);
 
-    ks->crypto_options=2Epid_persist =
=3D NULL;
-
 #ifdef ENABLE_MANAGEMENT
     ks->mda_key_id =3D session->opt-=
>mda_context->mda_key_id_counter++;
 #endif
@@ -1037,9 +1035,6 @@
         =
session->tls_wrap=2Eopt=2Epacket_id=2Esend=2Eid =3D EARLY_NEG_START;
     }=

 
-    /* load most recent packet-id to replay protect on --tls-auth */
- =
   packet_id_persist_load_obj(session->tls_wrap=2Eopt=2Epid_persist, &sessi=
on->tls_wrap=2Eopt=2Epacket_id);
-
     key_state_init(session, &session->k=
ey[KS_PRIMARY]);
 
     dmsg(D_TLS_DEBUG, "TLS: tls_session_init: new sessi=
on object, sid=3D%s",
diff --git a/src/openvpn/syshead=2Eh b/src/openvpn/sy=
shead=2Eh
index 1d6cdc2=2E=2E65baee3 100644
--- a/src/openvpn/syshead=2Eh
+=
++ b/src/openvpn/syshead=2Eh
@@ -127,10 +127,6 @@
 #include <fcntl=2Eh>
 #e=
ndif
 
-#ifdef HAVE_SYS_FILE_H
-#include <sys/file=2Eh>
-#endif
-
 /* These=
 headers belong to C99 and should be always be present */
 #include <stdlib=
=2Eh>
 #include <inttypes=2Eh>
diff --git a/src/openvpn/tls_crypt=2Ec b/src=
/openvpn/tls_crypt=2Ec
index d66b96d=2E=2E3d27e40 100644
--- a/src/openvpn/=
tls_crypt=2Ec
+++ b/src/openvpn/tls_crypt=2Ec
@@ -109,7 +109,6 @@
     sess=
ion->tls_wrap_reneg=2Emode =3D TLS_WRAP_CRYPT;
     session->tls_wrap_reneg=
=2Ecleanup_key_ctx =3D true;
     session->tls_wrap_reneg=2Ework =3D alloc_=
buf(BUF_SIZE(&session->opt->frame));
-    session->tls_wrap_reneg=2Eopt=2Ep=
id_persist =3D NULL;
 
     packet_id_init(&session->tls_wrap_reneg=2Eopt=
=2Epacket_id, session->opt->replay_window,
                    session->opt=
->replay_time, "TLS_WRAP_RENEG", session->key_id);

-- 
To view, visit http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815
Ge=
rrit-Change-Number: 2082
Gerrit-PatchSet: 9
Gerrit-Owner: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-R=
eviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>

--dcu/KSneve4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2082?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Remove replay-persist<br><br>This =
feature is very niche and we do not think it is something we<br>should main=
tain and support going forward=2E<br><br>This feature saves a single packet=
 id to replay-persist file=2E<br>This makes the feature only properly work =
in a p2p setup where both<br>sides use replay-persist to save the last know=
n packet id from the<br>peer=2E Even then it will only prevent some packet =
replays until the<br>legitimate peer sends a packet again=2E<br><br>In serv=
er mode (p2mp) each client context has its own replay state<br>and saving a=
 single packet id is also not very useful with multiple<br>clients and mult=
iple states=2E<br><br>Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815<=
br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Razv=
an Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2082<br>Message-Id: &lt;20261109195550=2E6096-1-ge=
rt@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-=
devel@lists=2Esourceforge=2Enet/msg41040=2Ehtml<br>Signed-off-by: Gert Doer=
ing &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M Changes=2Emd<br>M config=2E=
h=2Ecmake=2Ein<br>M configure=2Eac<br>M doc/man-sections/link-options=2Erst=
<br>M doc/man-sections/tls-options=2Erst<br>M doc/man-sections/unsupported-=
options=2Erst<br>M src/openvpn/check_file_access=2Ec<br>M src/openvpn/crypt=
o=2Ec<br>M src/openvpn/crypto=2Eh<br>M src/openvpn/errlevel=2Eh<br>M src/op=
envpn/forward=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/openvpn=2Eh<br=
>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn/op=
tions_show=2Ec<br>M src/openvpn/packet_id=2Ec<br>M src/openvpn/packet_id=2E=
h<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/syshead=2Eh<br>M src/openvpn/tl=
s_crypt=2Ec<br>21 files changed, 33 insertions(+), 330 deletions(-)<br><br>=
</pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;"><span>diff --git a/Changes=2Emd b/Changes=2Emd</span><br><span>index 7f=
47f77=2E=2E89a72fe 100644</span><br><span>--- a/Changes=2Emd</span><br><spa=
n>+++ b/Changes=2Emd</span><br><span>@@ -30,6 +30,12 @@</span><br><span>   =
&quot;too complicated&quot;, using `--peer-fingerprint` makes TLS mode abou=
t as easy as</span><br><span>   using `--secret`=2E</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+* **`replay-persist` has =
been removed**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  This feature has been =
removed as it was never properly implemented for</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  server mode and generally was a niche featur=
e=2E If the option is present</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  it will be ignored=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> ## Maintainer-visible changes</span><br><sp=
an> </span><br><span> - The configure-time option `--enable-debug` is no lo=
nger  available</span><br><span>diff --git a/config=2Eh=2Ecmake=2Ein b/conf=
ig=2Eh=2Ecmake=2Ein</span><br><span>index 5e06a63=2E=2Ef7818cf 100644</span=
><br><span>--- a/config=2Eh=2Ecmake=2Ein</span><br><span>+++ b/config=2Eh=
=2Ecmake=2Ein</span><br><span>@@ -285,9 +285,6 @@</span><br><span> /* Defin=
e to 1 if you have the &lt;sys/epoll=2Eh&gt; header file=2E */</span><br><s=
pan> #cmakedefine HAVE_SYS_EPOLL_H</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/* Define to 1 if you have the &lt;sys/file=
=2Eh&gt; header file=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#undef HAVE_SYS_FILE_H</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span> /* Define to 1 if you have the &lt;sys/inotify=2Eh&=
gt; header file=2E */</span><br><span> #cmakedefine HAVE_SYS_INOTIFY_H</spa=
n><br><span> </span><br><span>diff --git a/configure=2Eac b/configure=2Eac<=
/span><br><span>index 5f18798=2E=2E9326c4e 100644</span><br><span>--- a/con=
figure=2Eac</span><br><span>+++ b/configure=2Eac</span><br><span>@@ -453,7 =
+453,7 @@</span><br><span> ])</span><br><span> AC_CHECK_HEADERS([ \</span><=
br><span> 	sys/time=2Eh sys/ioctl=2Eh sys/stat=2Eh \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	sys/mman=2Eh sys/file=2Eh sys/wait=2Eh \</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+	sys/mman=2Eh sys/wai=
t=2Eh \</span><br><span> 	libgen=2Eh stropts=2Eh \</span><br><span> 	syslog=
=2Eh pwd=2Eh grp=2Eh \</span><br><span> 	sys/sockio=2Eh sys/uio=2Eh \</span=
><br><span>@@ -561,8 +561,7 @@</span><br><span> AC_CHECK_FUNCS([ \</span><b=
r><span> 	daemon chroot getpwnam setuid nice dup dup2 \</span><br><span> 	s=
yslog openlog mlockall getrlimit getgrnam setgid \</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	setgroups flock gettimeofday \</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	setsid chdir \</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+	setgroups gettimeofday setsid chdir \</=
span><br><span> 	chsize ftruncate execve getpeereid basename dirname \</spa=
n><br><span> 	epoll_create strlcpy strsep strtok_r \</span><br><span> ])</s=
pan><br><span>diff --git a/doc/man-sections/link-options=2Erst b/doc/man-se=
ctions/link-options=2Erst</span><br><span>index 735ee51=2E=2Ebbdcf7f 100644=
</span><br><span>--- a/doc/man-sections/link-options=2Erst</span><br><span>=
+++ b/doc/man-sections/link-options=2Erst</span><br><span>@@ -440,19 +440,6=
 @@</span><br><span>   physical IP layer=2E The problem is easily fixed by =
simply using TCP as</span><br><span>   the VPN transport layer=2E</span><br=
><span> </span><br><span>---replay-persist file</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  Persist replay-protection state across sessions=
 using ``file`` to save</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-  and reload the state=2E</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  This option w=
ill keep a disk copy of the current replay protection state</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  (i=2Ee=2E the most recent packet ti=
mestamp and sequence number received from</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  the remote peer), so that if an OpenVPN session is st=
opped and</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  restarted,=
 it will reject any replays of packets which were already</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  received by the prior session=2E</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-  This option only makes sense when replay prot=
ection is enabled (the</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  default) and you are using TLS mode with ``--tls-auth``=2E</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> --session-timeout=
 n</span><br><span>   Raises :code:`SIGTERM` for the client instance after =
``n`` seconds since</span><br><span>   the beginning of the session, forcin=
g OpenVPN to disconnect=2E</span><br><span>diff --git a/doc/man-sections/tl=
s-options=2Erst b/doc/man-sections/tls-options=2Erst</span><br><span>index =
c4aa810=2E=2Ede4d324 100644</span><br><span>--- a/doc/man-sections/tls-opti=
ons=2Erst</span><br><span>+++ b/doc/man-sections/tls-options=2Erst</span><b=
r><span>@@ -370,10 +370,7 @@</span><br><span>   level has had a chance to a=
uthenticate the peer=2E The result is that</span><br><span>   packets witho=
ut the correct signature can be dropped immediately upon</span><br><span>  =
 reception, before they have a chance to consume additional system</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  resources such as by initiat=
ing a TLS handshake=2E ``--tls-auth`` can be</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  strengthened by adding the ``--replay-persist`` op=
tion which will keep</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 OpenVPN&#39;s replay protection state in a file so that it is not lost</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  across restarts=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  resources such as by i=
nitiating a TLS handshake=2E</span><br><span> </span><br><span>   It should=
 be emphasized that this feature is optional and that the key</span><br><sp=
an>   file used with ``--tls-auth`` gives a peer nothing more than the powe=
r</span><br><span>diff --git a/doc/man-sections/unsupported-options=2Erst b=
/doc/man-sections/unsupported-options=2Erst</span><br><span>index 2794f12=
=2E=2E368805e 100644</span><br><span>--- a/doc/man-sections/unsupported-opt=
ions=2Erst</span><br><span>+++ b/doc/man-sections/unsupported-options=2Erst=
</span><br><span>@@ -79,3 +79,8 @@</span><br><span> </span><br><span> --all=
ow-deprecated-insecure-static-crypto</span><br><span>   Removed in OpenVPN =
2=2E8 as --secret was also removed=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+-=
-replay-persist</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Re=
moved in OpenVPN 2=2E8=2E This option never really worked well with ``--ser=
ver``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  and the usef=
ulness of this option in p2p setups is not very high either=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  It is now ignored if present i=
n the configuration file=2E</span><br><span>diff --git a/src/openvpn/check_=
file_access=2Ec b/src/openvpn/check_file_access=2Ec</span><br><span>index a=
b2535d=2E=2Ebe9b4b2 100644</span><br><span>--- a/src/openvpn/check_file_acc=
ess=2Ec</span><br><span>+++ b/src/openvpn/check_file_access=2Ec</span><br><=
span>@@ -312,9 +312,6 @@</span><br><span>                                  =
        ce-&gt;tls_crypt_v2_file, R_OK, &quot;--tls-crypt-v2&quot;);</span>=
<br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXS=
TWR, options-&gt;packet_id_file,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                              R_OK | W_OK, &quot;--replay-persis=
t&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span>     /* ** Password files ** */</span><br><span>     errs |=3D check_f=
ile_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,</span><br><span=
>                               options-&gt;key_pass_file, R_OK, &quot;--as=
kpass&quot;);</span><br><span>diff --git a/src/openvpn/crypto=2Ec b/src/ope=
nvpn/crypto=2Ec</span><br><span>index a8ad7f0=2E=2E6efa005 100644</span><br=
><span>--- a/src/openvpn/crypto=2Ec</span><br><span>+++ b/src/openvpn/crypt=
o=2Ec</span><br><span>@@ -403,10 +403,6 @@</span><br><span>     if (packet_=
id_test(recv, pin))</span><br><span>     {</span><br><span>         packet_=
id_add(recv, pin);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (opt-&gt;pid_persist &amp;&amp; (opt-&gt;flags &amp; CO_PACKET_ID_L=
ONG_FORM))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            packet_id_p=
ersist_save_obj(opt-&gt;pid_persist, &amp;opt-&gt;packet_id);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span>         =
ret =3D true;</span><br><span>     }</span><br><span>     else</span><br><s=
pan>diff --git a/src/openvpn/crypto=2Eh b/src/openvpn/crypto=2Eh</span><br>=
<span>index a03c5ce=2E=2E7e240d2 100644</span><br><span>--- a/src/openvpn/c=
rypto=2Eh</span><br><span>+++ b/src/openvpn/crypto=2Eh</span><br><span>@@ -=
332,11 +332,6 @@</span><br><span>                                  *   The =
packet id also used as the IV</span><br><span>                             =
     *   for AEAD/OFB/CFG ciphers=2E</span><br><span>                      =
            */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    str=
uct packet_id_persist *pid_persist;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    /**&lt; Persistent packet ID state for</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-     *   keeping state between successiv=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     *   OpenVPN pro=
cess startups=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span> #define CO_PACKET_ID_LONG_FORM         (1u &lt;&lt; 0)</spa=
n><br><span>     /**&lt; Bit-flag indicating whether to use</span><br><span=
>      *   OpenVPN&#39;s long packet ID format=2E */</span><br><span>diff -=
-git a/src/openvpn/errlevel=2Eh b/src/openvpn/errlevel=2Eh</span><br><span>=
index e52cb65=2E=2E5cea0ad 100644</span><br><span>--- a/src/openvpn/errleve=
l=2Eh</span><br><span>+++ b/src/openvpn/errlevel=2Eh</span><br><span>@@ -64=
,7 +64,6 @@</span><br><span> #define D_MULTI_ERRORS   LOGLEV(1, 9, M_NONFAT=
AL)  /* show multi-client server errors */</span><br><span> #define D_EVENT=
_ERRORS   LOGLEV(1, 10, M_NONFATAL) /* show event=2E[ch] errors */</span><b=
r><span> #define D_PUSH_ERRORS    LOGLEV(1, 11, M_NONFATAL) /* show push/pu=
ll errors */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D=
_PID_PERSIST    LOGLEV(1, 12, M_NONFATAL) /* show packet_id persist errors =
*/</span><br><span> #define D_FRAG_ERRORS    LOGLEV(1, 13, M_NONFATAL) /* s=
how fragmentation errors */</span><br><span> #define D_ALIGN_ERRORS   LOGLE=
V(1, 14, M_NONFATAL) /* show bad struct alignments */</span><br><span> </sp=
an><br><span>@@ -159,16 +158,15 @@</span><br><span> #define D_EVENT_WAIT   =
     LOGLEV(8, 70, M_DEBUG)      /* show detailed info from event waits */<=
/span><br><span> #define D_MULTI_TCP         LOGLEV(8, 70, M_DEBUG)      /*=
 show debug info from mtcp=2Ec */</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define D_TLS_DEBUG         LOGLEV(9, 70, M=
_DEBUG)      /* show detailed info from TLS routines */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#define D_COMP              LOGLEV(9, 70,=
 M_DEBUG)      /* show compression info */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#define D_READ_WRITE        LOGLEV(9, 70, M_DEBUG)    =
  /* show all tun/tcp/udp reads/writes/opens */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#define D_PACKET_CONTENT    LOGLEV(9, 70, M_DEBUG=
)      /* show before/after encryption packet content */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#define D_TLS_NO_SEND_KEY   LOGLEV(9, 70=
, M_DEBUG)      /* show when no data channel send-key exists */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define D_PID_PERSIST_DEBUG LOGLE=
V(9, 70, M_DEBUG)      /* show packet-id persist debugging info */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define D_LINK_RW_VERBOSE   LO=
GLEV(9, 70, M_DEBUG)      /* increase link reads/writes verbosity */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_STREAM_DEBUG      =
LOGLEV(9, 70, M_DEBUG)      /* show TCP stream debug info */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#define D_WIN32_IO          LOGLEV(9=
, 70, M_DEBUG)      /* win32 I/O debugging info */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define D_PKCS11_DEBUG      LOGLEV(9, 70, M_DE=
BUG)      /* show PKCS#11 debugging */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define D_TLS_DEBUG       LOGLEV(9, 70, M_DEBUG)        =
/* show detailed info from TLS routines */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define D_COMP            LOGLEV(9, 70, M_DEBUG)    =
    /* show compression info */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define D_READ_WRITE      LOGLEV(9, 70, M_DEBUG)        /* show=
 all tun/tcp/udp reads/writes/opens */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define D_PACKET_CONTENT  LOGLEV(9, 70, M_DEBUG)        =
/* show before/after encryption packet content */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define D_TLS_NO_SEND_KEY LOGLEV(9, 70, M_DEB=
UG)        /* show when no data channel send-key exists */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define D_LINK_RW_VERBOSE LOGLEV(9, =
70, M_DEBUG)        /* increase link reads/writes verbosity */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define D_STREAM_DEBUG    LOGLEV=
(9, 70, M_DEBUG)        /* show TCP stream debug info */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define D_WIN32_IO        LOGLEV(9, 70=
, M_DEBUG)        /* win32 I/O debugging info */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define D_PKCS11_DEBUG    LOGLEV(9, 70, M_DEBU=
G)        /* show PKCS#11 debugging */</span><br><span> </span><br><span> #=
define D_SHAPER_DEBUG LOGLEV(10, 70, M_DEBUG)          /* show traffic shap=
er info */</span><br><span> </span><br><span>diff --git a/src/openvpn/forwa=
rd=2Ec b/src/openvpn/forward=2Ec</span><br><span>index 82cb6c9=2E=2Eba0e0ec=
 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b=
/src/openvpn/forward=2Ec</span><br><span>@@ -749,14 +749,6 @@</span><br><sp=
an> static void</span><br><span> process_coarse_timers(struct context *c)</=
span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
/* flush current packet-id to file once per 60</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-     * seconds if --replay-persist was specified *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (packet_id_pe=
rsist_enabled(&amp;c-&gt;c1=2Epid_persist)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        &amp;&amp; event_timeout_trigger(&amp;c-&gt;c2=
=2Epacket_id_persist_interval, &amp;c-&gt;c2=2Etimeval, ETT_DEFAULT))</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        packet_id_persist_save(&amp;c-&gt;c=
1=2Epid_persist);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>   =
  /* Should we write timer-triggered status file */</span><br><span>     if=
 (c-&gt;c1=2Estatus_output</span><br><span>         &amp;&amp; event_timeou=
t_trigger(&amp;c-&gt;c1=2Estatus_output-&gt;et, &amp;c-&gt;c2=2Etimeval, ET=
T_DEFAULT))</span><br><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn=
/init=2Ec</span><br><span>index 29c24f2=2E=2Eaef2f14 100644</span><br><span=
>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</spa=
n><br><span>@@ -67,7 +67,6 @@</span><br><span> /*</span><br><span>  * Crypt=
o initialization flags</span><br><span>  */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#define CF_LOAD_PERSISTED_PACKET_ID (1 &lt;&lt; 0)</s=
pan><br><span> #define CF_INIT_TLS_MULTI           (1 &lt;&lt; 1)</span><br=
><span> #define CF_INIT_TLS_AUTH_STANDALONE (1 &lt;&lt; 2)</span><br><span>=
 </span><br><span>@@ -738,8 +737,6 @@</span><br><span> {</span><br><span>  =
   context_clear_1(c);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    packet_id_persist_init(&amp;c-&gt;c1=2Epid_persist);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>    =
 init_connection_list(c);</span><br><span> </span><br><span>     c-&gt;c1=
=2Elink_sockets_num =3D c-&gt;options=2Ece=2Elocal_list-&gt;len;</span><br>=
<span>@@ -1347,12 +1344,6 @@</span><br><span>                              =
  now);</span><br><span>         }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        /* initialize packet_id persistence=
 timer */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (=
c-&gt;options=2Epacket_id_file)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          event_timeout_init(&amp;c-&gt;c2=2Epacket_id_persist_interval, 60=
, now);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         =
/* initialize tmp_int optimization that limits the number of times we call<=
/span><br><span>          * tls_multi_process in the main event loop */</sp=
an><br><span>         interval_init(&amp;c-&gt;c2=2Etmp_int, TLS_MULTI_HORI=
ZON, TLS_MULTI_REFRESH);</span><br><span>@@ -2976,31 +2967,15 @@</span><br>=
<span> }</span><br><span> </span><br><span> static void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-init_crypto_pre(struct context *c, const =
unsigned int flags)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;options=
=2Eengine)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        crypto_init_lib_eng=
ine(c-&gt;options=2Eengine);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (flags &amp; CF_LOAD_PE=
RSISTED_PACKET_ID)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* load a p=
ersisted packet-id for cross-session replay-protection */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if (c-&gt;options=2Epacket_id_f=
ile)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            packet_id_persist=
_load(&amp;c-&gt;c1=2Epid_persist, c-&gt;options=2Epacket_id_file);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span> do_init_crypto=
_test(struct context *c)</span><br><span> {</span><br><span>     const stru=
ct options *options =3D &amp;c-&gt;options;</span><br><span>     ASSERT(opt=
ions-&gt;test_crypto);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    init_crypto_pre(c, 0);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (c-&gt;options=2Eengine)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        crypto_init_lib_engine(c-&gt;options=2Eengi=
ne);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span> </span><br><span>     c-&gt;c2=2Ecrypto_options=2Eflags |=3D CO_PAC=
KET_ID_LONG_FORM;</span><br><span> </span><br><span>@@ -3201,7 +3176,10 @@<=
/span><br><span>     ASSERT(options-&gt;tls_server || options-&gt;tls_clien=
t);</span><br><span>     ASSERT(!options-&gt;test_crypto);</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_crypto_pre(=
c, flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c=
-&gt;options=2Eengine)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cry=
pto_init_lib_engine(c-&gt;options=2Eengine);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     /* Ma=
ke sure we are either a TLS client or server but not both */</span><br><spa=
n>     ASSERT(options-&gt;tls_server =3D=3D !options-&gt;tls_client);</span=
><br><span>@@ -3380,7 +3358,6 @@</span><br><span>     if (to=2Etls_wrap=2Em=
ode =3D=3D TLS_WRAP_AUTH || to=2Etls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT)</sp=
an><br><span>     {</span><br><span>         to=2Etls_wrap=2Eopt=2Ekey_ctx_=
bi =3D c-&gt;c1=2Eks=2Etls_wrap_key;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        to=2Etls_wrap=2Eopt=2Epid_persist =3D &amp;c-&gt;c1=
=2Epid_persist;</span><br><span>         to=2Etls_wrap=2Eopt=2Eflags |=3D C=
O_PACKET_ID_LONG_FORM;</span><br><span>         to=2Etls_wrap=2Eoriginal_wr=
ap_keydata =3D c-&gt;c1=2Eks=2Eoriginal_wrap_keydata;</span><br><span>     =
}</span><br><span>@@ -3939,11 +3916,6 @@</span><br><span> do_close_packet_i=
d(struct context *c)</span><br><span> {</span><br><span>     packet_id_free=
(&amp;c-&gt;c2=2Ecrypto_options=2Epacket_id);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    packet_id_persist_save(&amp;c-&gt;c1=2Epid_pers=
ist);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!(c-&gt;=
sig-&gt;signal_received =3D=3D SIGUSR1))</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        packet_id_persist_close(&amp;c-&gt;c1=2Epid_persist);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span> }</span><=
br><span> </span><br><span> #ifdef ENABLE_FRAGMENT</span><br><span>@@ -4498=
,7 +4470,7 @@</span><br><span>         }</span><br><span>         else if (=
c-&gt;mode =3D=3D CM_P2P)</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            crypto_flags =3D CF_LOAD_PERSIS=
TED_PACKET_ID | CF_INIT_TLS_MULTI;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            crypto_flags =3D CF_INIT_TLS_MULTI;</span><br><s=
pan>         }</span><br><span>         else if (child)</span><br><span>   =
      {</span><br><span>@@ -4756,7 +4728,6 @@</span><br><span>     ALLOC_OB=
J_CLEAR_GC(dest-&gt;sig, struct signal_info, &amp;dest-&gt;gc);</span><br><=
span> </span><br><span>     /* c1 init */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    packet_id_persist_init(&amp;dest-&gt;c1=2Epid_persi=
st);</span><br><span>     dest-&gt;c1=2Elink_sockets_num =3D 1;</span><br><=
span>     do_link_socket_addr_new(dest);</span><br><span> </span><br><span>=
diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh</span><br><s=
pan>index 970baa9=2E=2Ead6be88 100644</span><br><span>--- a/src/openvpn/ope=
nvpn=2Eh</span><br><span>+++ b/src/openvpn/openvpn=2Eh</span><br><span>@@ -=
75,21 +75,6 @@</span><br><span> };</span><br><span> </span><br><span> /*</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * struct packet_id_pers=
ist should be empty if we are not</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * building with crypto=2E</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
ifndef PACKET_ID_H</span><br><span style=3D"color: hsl(0, 100%, 40%);">-str=
uct packet_id_persist</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int dummy;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-static inline void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-packet_id_persist_init(struct packet_id_persist *=
p)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span> =
 * Packet processing buffers=2E</span><br><span>  */</span><br><span> struc=
t context_buffers</span><br><span>@@ -167,9 +152,6 @@</span><br><span>     =
/* preresolved and cached host names */</span><br><span>     struct cached_=
dns_entry *dns_cache;</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    /* persist crypto sequence number to/from file */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct packet_id_pers=
ist pid_persist;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span>     struct tuntap *tuntap; /**&lt; Tun/tap virtual network int=
erface=2E */</span><br><span>     bool tuntap_owned;     /**&lt; Whether th=
e tun/tap interface should</span><br><span>                             *  =
 be cleaned up when this %context is</span><br><span>@@ -346,8 +328,6 @@</s=
pan><br><span>      *   Channel Crypto module\endlink to</span><br><span>  =
    *   process data channel packet=2E */</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    struct event_timeout packet_id_pe=
rsist_interval;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span> #ifdef USE_COMP</span><br><span>     struct compress_context *c=
omp_context;</span><br><span>     /**&lt; Compression context used by the</=
span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=
=2Ec</span><br><span>index 454d2d6=2E=2E9ed3964 100644</span><br><span>--- =
a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</sp=
an><br><span>@@ -571,8 +571,6 @@</span><br><span>     &quot;--replay-window=
 n [t]  : Use a replay protection sliding window of size n\n&quot;</span><b=
r><span>     &quot;                         and a time window of t seconds=
=2E\n&quot;</span><br><span>     &quot;                         Default n=
=3D%d t=3D%d\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   &quot;--replay-persist file : Persist replay-protection state across ses=
sions\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quo=
t;                  using file=2E\n&quot;</span><br><span>     &quot;--test=
-crypto   : Run a self-test of crypto features enabled=2E\n&quot;</span><br=
><span>     &quot;                  For debugging only=2E\n&quot;</span><br=
><span>     &quot;\n&quot;</span><br><span>@@ -7088,7 +7086,7 @@</span><br>=
<span>     else if (streq(p[0], &quot;replay-persist&quot;) &amp;&amp; p[1]=
 &amp;&amp; !p[2])</span><br><span>     {</span><br><span>         VERIFY_P=
ERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        options-&gt;packet_id_file =3D p[1];</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;DEPRECATED OPTION: -=
-replay-persist option ignored=2E&quot;);</span><br><span>     }</span><br>=
<span>     else if (streq(p[0], &quot;test-crypto&quot;) &amp;&amp; !p[1])<=
/span><br><span>     {</span><br><span>diff --git a/src/openvpn/options=2Eh=
 b/src/openvpn/options=2Eh</span><br><span>index 38554a1=2E=2Eb390ebc 10064=
4</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/o=
penvpn/options=2Eh</span><br><span>@@ -582,7 +582,6 @@</span><br><span>    =
 bool mute_replay_warnings;</span><br><span>     int replay_window;</span><=
br><span>     int replay_time;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    const char *packet_id_file;</span><br><span>     bool test_cry=
pto;</span><br><span> </span><br><span>     /* TLS (control channel) parms =
*/</span><br><span>diff --git a/src/openvpn/options_show=2Ec b/src/openvpn/=
options_show=2Ec</span><br><span>index 321a37b=2E=2E54f9c4c 100644</span><b=
r><span>--- a/src/openvpn/options_show=2Ec</span><br><span>+++ b/src/openvp=
n/options_show=2Ec</span><br><span>@@ -501,7 +501,6 @@</span><br><span>    =
 SHOW_BOOL(mute_replay_warnings);</span><br><span>     SHOW_INT(replay_wind=
ow);</span><br><span>     SHOW_INT(replay_time);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    SHOW_STR(packet_id_file);</span><br><span>  =
   SHOW_BOOL(test_crypto);</span><br><span> </span><br><span>     SHOW_BOOL=
(tls_server);</span><br><span>diff --git a/src/openvpn/packet_id=2Ec b/src/=
openvpn/packet_id=2Ec</span><br><span>index 9dd6ce3=2E=2Ef1fadd6 100644</sp=
an><br><span>--- a/src/openvpn/packet_id=2Ec</span><br><span>+++ b/src/open=
vpn/packet_id=2Ec</span><br><span>@@ -426,146 +426,6 @@</span><br><span>   =
  return BSTR(&amp;out);</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-/* initialize the packet_id_persist=
 structure in a disabled state */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-packe=
t_id_persist_init(struct packet_id_persist *p)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    p-&gt;filename =3D NULL;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    p-&gt;fd =3D -1;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    p-&gt;time =3D p-&gt;time_last_written =3D 0;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    p-&gt;id =3D p-&gt;id_last_writt=
en =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-/* close the file descriptor if it is open, and switc=
h to disabled state */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-packet_id_persis=
t_close(struct packet_id_persist *p)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (packet_id_persist_enabled(p))</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   if (close(p-&gt;fd))</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  msg(D_PID_PERSIST | M_ERRNO, &quot;Close error on --replay-persist file %=
s&quot;, p-&gt;filename);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
packet_id_persist_init(p);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-/* load persisted rec packet_id (time and id) only o=
nce from file, and set state to enabled */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-packet_id_persist_load(struct packet_id_persist *p, const char *filenam=
e)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!packet_id_persi=
st_enabled(p))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* open packet-=
id persist file for both read and write */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        p-&gt;fd =3D platform_open(filename, O_CREAT |=
 O_RDWR | O_BINARY, S_IRUSR | S_IWUSR);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (p-&gt;fd =3D=3D -1)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            msg(D_PID_PERSIST | M_ERRNO, &quot;Cannot open =
--replay-persist file %s for read/write&quot;,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                filename);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           struct packet_id_persist_file_image image;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            ssize_t n;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#if defined(HAVE_FLOCK) &amp;&amp; defined(LOCK_EX) &amp;&amp; =
defined(LOCK_NB)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       if (flock(p-&gt;fd, LOCK_EX | LOCK_NB))</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                msg(M_ERR, &quot;Cannot obtain exclusive l=
ock on --replay-persist file %s&quot;, filename);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            p-&g=
t;filename =3D filename;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            n =3D read(p-&gt;fd, &amp;image, sizeof(image));</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            if (n =3D=3D sizeof(i=
mage))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                p-&gt;t=
ime =3D p-&gt;time_last_written =3D image=2Etime;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                p-&gt;id =3D p-&gt;id_last_writ=
ten =3D image=2Eid;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              dmsg(D_PID_PERSIST_DEBUG, &quot;PID Persist Read from %s: %s&=
quot;, p-&gt;filename,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                     packet_id_persist_print(p, &amp;gc));</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            else if (n =3D=3D -1)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                msg(D_PID_PERSIST | M_E=
RRNO, &quot;Read error on --replay-persist file %s&quot;, p-&gt;filename);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-/* save persisted rec pa=
cket_id (time and id) to file (only if enabled state) */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-packet_id_persist_save(struct packet_id_persist *p)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (packet_id_persist_enabled(p) &amp;&amp;=
 p-&gt;time</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &a=
mp;&amp; (p-&gt;time !=3D p-&gt;time_last_written || p-&gt;id !=3D p-&gt;id=
_last_written))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct packet_=
id_persist_file_image image;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        CLEAR(image);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        off_t seek_ret;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        struct gc_arena gc =3D gc_new();</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        image=2Etime =3D p-&gt;time;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        image=2Eid =3D p-&gt;id;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        seek_ret =3D lseek(p-&gt;fd, (off_=
t)0, SEEK_SET);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  if (seek_ret =3D=3D (off_t)0)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          const ssize_t n =3D write(p-&gt;fd, &amp;image, sizeof(image));</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (n =3D=
=3D sizeof(image))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     p-&gt;time_last_written =3D p-&gt;time;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                p-&gt;id_last_written =3D p-&gt;id;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                dmsg(D=
_PID_PERSIST_DEBUG, &quot;PID Persist Write to %s: %s&quot;, p-&gt;filename=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
 packet_id_persist_print(p, &amp;gc));</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            else</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            msg(D_PID_PERSIST | M_ERRNO, &quot;Cannot write to --replay-per=
sist file %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                  p-&gt;filename);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_PID_PERSIS=
T | M_ERRNO, &quot;Cannot seek to beginning of --replay-persist file %s&quo=
t;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                p-=
&gt;filename);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        gc_free(&am=
p;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-/* transfer packet_id_persist -&gt; packet_id */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-packet_id_persist_load_obj(const struct packet_id_persist *p=
, struct packet_id *pid)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (p &amp;&a=
mp; pid &amp;&amp; packet_id_persist_enabled(p) &amp;&amp; p-&gt;time)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        pid-&gt;rec=2Etime =3D p-&gt;time;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        pid-&gt;rec=
=2Eid =3D p-&gt;id;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-const char *</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-packet_id_persist_print(const struct packet_id_persist *p, struct gc=
_arena *gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer out =3D allo=
c_buf_gc(256, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_printf(&amp;out,=
 &quot;[&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (packet_id_persist_=
enabled(p))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;ou=
t, &quot; #&quot; packet_id_format, (packet_id_print_type)p-&gt;id);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (p-&gt;time)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&amp;out, &quot=
; / time =3D (&quot; packet_id_format &quot;) %s&quot;, (packet_id_print_ty=
pe)p-&gt;time,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                time_string(p-&gt;time, 0, false, gc));</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_printf(=
&amp;out, &quot; ]&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    return (char *)out=2Edata;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span> #ifndef ENABLE_SMALL</span><br><span> </span><br><span> static =
void</span><br><span>diff --git a/src/openvpn/packet_id=2Eh b/src/openvpn/p=
acket_id=2Eh</span><br><span>index 48752d3=2E=2Ec374ccb 100644</span><br><s=
pan>--- a/src/openvpn/packet_id=2Eh</span><br><span>+++ b/src/openvpn/packe=
t_id=2Eh</span><br><span>@@ -125,26 +125,6 @@</span><br><span> };</span><br=
><span> </span><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * file to facilitate cross-session persistence</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * of time/id</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-struct packet_id_persist</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const =
char *filename;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in=
t fd;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    time_t time;=
       /* time stamp */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    packet_id_type id; /* sequence number */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    time_t time_last_written;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    packet_id_type id_last_written;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-struct packet_id_persist_file_image</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    time_t time;       /* time stamp */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    packet_id_type id; /* sequence number */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-/*</span><br><span>  * Keep a record of our current packet-id state</span=
><br><span>  * on the sending side=2E</span><br><span>  */</span><br><span>=
@@ -222,28 +202,6 @@</span><br><span> void packet_id_reap(struct packet_id_=
rec *p);</span><br><span> </span><br><span> /*</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * packet ID persistence</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* initiali=
ze the packet_id_persist structure in a disabled state */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-void packet_id_persist_init(struct pack=
et_id_persist *p);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-/* close the file descri=
ptor if it is open, and switch to disabled state */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void packet_id_persist_close(struct packet_=
id_persist *p);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-/* load persisted rec packe=
t_id (time and id) only once from file, and set state to enabled */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-void packet_id_persist_load(s=
truct packet_id_persist *p, const char *filename);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-/* save persisted rec packet_id (time and id) to file (only if enab=
led state) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void pac=
ket_id_persist_save(struct packet_id_persist *p);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-/* transfer packet_id_persist -&gt; packet_id */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-void packet_id_persist_load_obj(const str=
uct packet_id_persist *p, struct packet_id *pid);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-/* return an ascii string representing a packet_id_persist object */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-const char *packet_id=
_persist_print(const struct packet_id_persist *p, struct gc_arena *gc);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-/*</span><br><span>  * Read/write a packet ID =
to/from the buffer=2E  Short form is sequence number</span><br><span>  * on=
ly=2E  Long form is sequence number and timestamp=2E</span><br><span>  */</=
span><br><span>@@ -273,27 +231,6 @@</span><br><span>     return pid-&gt;rec=
=2Einitialized;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/* are we in enabled state? */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-static inline bool</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-packet_id_persist_enabled(const struc=
t packet_id_persist *p)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return p-&gt;f=
d &gt;=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-/* transfer packet_id -&gt; packet_id_persist</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-   Note: Only supported fo=
r non-epoch format (i=2Ee=2E 32bit ID, not 64bit format),</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-   must be enforced at the caller=2E</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-static inline void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-packet_id_persist_save_obj(struct packet_id=
_persist *p, const struct packet_id *pid)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (packet_id_persist_enabled(p) &amp;&amp; pid-&gt;rec=2Etime &amp;&am=
p; pid-&gt;rec=2Eid &lt;=3D PACKET_ID_MAX)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        p-&gt;time =3D pid-&gt;rec=2Etime;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        p-&gt;id =3D (packet_id_type)pid-&gt;rec=
=2Eid;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><span>  * Reset the=
 current send packet id to its initial state=2E</span><br><span>  * Use ver=
y carefully (e=2Eg=2E in the standalone reset packet context) to</span><br>=
<span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><spa=
n>index a538b52=2E=2Ecdb94ed 100644</span><br><span>--- a/src/openvpn/ssl=
=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -874,8 +8=
74,6 @@</span><br><span>     packet_id_init(&amp;ks-&gt;crypto_options=2Epa=
cket_id, session-&gt;opt-&gt;replay_window,</span><br><span>               =
     session-&gt;opt-&gt;replay_time, &quot;SSL&quot;, ks-&gt;key_id);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ks-&=
gt;crypto_options=2Epid_persist =3D NULL;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><s=
pan>     ks-&gt;mda_key_id =3D session-&gt;opt-&gt;mda_context-&gt;mda_key_=
id_counter++;</span><br><span> #endif</span><br><span>@@ -1037,9 +1035,6 @@=
</span><br><span>         session-&gt;tls_wrap=2Eopt=2Epacket_id=2Esend=2Ei=
d =3D EARLY_NEG_START;</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    /* load most recent packet-id=
 to replay protect on --tls-auth */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    packet_id_persist_load_obj(session-&gt;tls_wrap=2Eopt=2Ep=
id_persist, &amp;session-&gt;tls_wrap=2Eopt=2Epacket_id);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     key_state_init(se=
ssion, &amp;session-&gt;key[KS_PRIMARY]);</span><br><span> </span><br><span=
>     dmsg(D_TLS_DEBUG, &quot;TLS: tls_session_init: new session object, si=
d=3D%s&quot;,</span><br><span>diff --git a/src/openvpn/syshead=2Eh b/src/op=
envpn/syshead=2Eh</span><br><span>index 1d6cdc2=2E=2E65baee3 100644</span><=
br><span>--- a/src/openvpn/syshead=2Eh</span><br><span>+++ b/src/openvpn/sy=
shead=2Eh</span><br><span>@@ -127,10 +127,6 @@</span><br><span> #include &l=
t;fcntl=2Eh&gt;</span><br><span> #endif</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_SYS_FILE_H</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#include &lt;sys/file=2Eh&gt;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* These headers belong t=
o C99 and should be always be present */</span><br><span> #include &lt;stdl=
ib=2Eh&gt;</span><br><span> #include &lt;inttypes=2Eh&gt;</span><br><span>d=
iff --git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec</span><br=
><span>index d66b96d=2E=2E3d27e40 100644</span><br><span>--- a/src/openvpn/=
tls_crypt=2Ec</span><br><span>+++ b/src/openvpn/tls_crypt=2Ec</span><br><sp=
an>@@ -109,7 +109,6 @@</span><br><span>     session-&gt;tls_wrap_reneg=2Emo=
de =3D TLS_WRAP_CRYPT;</span><br><span>     session-&gt;tls_wrap_reneg=2Ecl=
eanup_key_ctx =3D true;</span><br><span>     session-&gt;tls_wrap_reneg=2Ew=
ork =3D alloc_buf(BUF_SIZE(&amp;session-&gt;opt-&gt;frame));</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    session-&gt;tls_wrap_reneg=2Eopt=
=2Epid_persist =3D NULL;</span><br><span> </span><br><span>     packet_id_i=
nit(&amp;session-&gt;tls_wrap_reneg=2Eopt=2Epacket_id, session-&gt;opt-&gt;=
replay_window,</span><br><span>                    session-&gt;opt-&gt;repl=
ay_time, &quot;TLS_WRAP_RENEG&quot;, session-&gt;key_id);</span><br></pre><=
p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082=
?usp=3Demail">change 2082</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2082?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2082 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-O=
wner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &l=
t;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>

</body></html>
--dcu/KSneve4=--


--===============6587580082793479507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6587580082793479507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6587580082793479507==--

