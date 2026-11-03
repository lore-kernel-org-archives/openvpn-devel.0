Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F416082BFB
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=C4gXp6y4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CjnZCfhl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZErn9I+t;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IfLbvXqG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Zl5hQydLVluT9z2krJAY4KbKeGAZBwQ84oZWdE3G8LY=; b=C4gXp6y4Z+/XL7IRI8h5JIL/8D
	9mU4mxzru+gHpiAk0Pps+X4f1qrdoHR+UMZCe4TCO0hohKlDaVaFE59L3Ou6dq5q00ria6v0KLcop
	BxMDvDG6weeRhDEWzQQRXbsL7f+uO3JQadGeGSSvqS2TZ5nhmrUCg0d3IwNTLBvuwiPk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOCpS-000000000TM-36a0;
	Tue, 03 Nov 2026 11:37:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOCpC-000000000T5-1OnH
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 11:37:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5lgwCJ01ZNv1UUOGt4FcnZa2R3cVH+LziTYm6oNckX8=; b=CjnZCfhlfGUepUI3nUC+u2y/XI
 ItHwVNOzEZhLq2UkBoQrxrkqxj9UPY1DwD+/A762zpl8LayLFCsY1tZqX2Z6C1EGypbNIS/HTes2a
 Pd3lMcnnX0ddcINjiz/k5xe3p9qvgjpkrBguCvl/JZizpwn/Iblgs4EkPA3I3fXrJrwE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5lgwCJ01ZNv1UUOGt4FcnZa2R3cVH+LziTYm6oNckX8=; b=ZErn9I+t8f0FeGOlPtu2WM0qu/
 Da0lZV4gq0+806stFJwpqmHJ97lg8u+3xBxoORWG4BJa7Tor8DRYZIKWQp6boXijhAYoBvZsWMoZ+
 UCYohG7l0OAW0Y2Sr6mXD2gmimDEduT+D/YWASBT7Yzp3ljqRTq8+SmlVvFTWGnZ6Wjo=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOCp4-000000002Lo-3kig for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 11:37:06 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48dfaa3fa12so359573f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 03:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793705816; x=1794310616; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5lgwCJ01ZNv1UUOGt4FcnZa2R3cVH+LziTYm6oNckX8=;
 b=IfLbvXqG8H476OJUbjvVZW8fsR8mifAqJDbr12cbI2+WMUHINxLSgIyfNBEviCxFqL
 jw+STc20W0PbeM2YYUIZIow4c27QVKCGmv5lhg0NgJZqq2KRvgC9BBBVkXxeyBrEuq4U
 wBomTg7hfFzEg5ATQyXMhHIHEJRBloHXZcIyqQv54pQm9TjULLXdMD8bdGVA1OYU6MxN
 psXOscwhJfZnxciEV+/pBfIM9JVYoFO2cKkt9yApfgyhlaqgmSuQml15EUs/U3Dd54bl
 ScSeoqrMP1Nd1j7SELbf3FHcGQMWK1eQNDsVej8vbC8IJq7QnqttfPsg+miHeHjZKGU3
 iG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793705816; x=1794310616;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5lgwCJ01ZNv1UUOGt4FcnZa2R3cVH+LziTYm6oNckX8=;
 b=mDwMTmZM/kjMuslWauHP5zB03fJpJbSCZeePReMb9v1yc7gBdybxolSX0+UxLrPo3R
 uS6oHb5I4LjzhR04lRxQQqzelR3vKAksdGYj9vRcxKlTh0bJrZ0afKmvRAizsXjdoUHr
 emZrLE+eQ9ubgHVEXl/J9LDDE5aiISj5t4R9IdMuy52Z5cEEDOop6qBMftH4pcZKqUXe
 q6dSYL2AC75ZMPpmeupKZ8HqfanccU95sfBUwDXeq/yZPv3ZGhTqo1KGvzV0eH8zlMHq
 1MKC9dHf6sh3/Uz/x93EXAI9iRMfku9k95OAh6IleeCvoLbqEmR21LhZrb4P2AO4SWzk
 9+aQ==
X-Gm-Message-State: APuU4Z+rlmbDQwP2sDNKfW6JTmdHzIZaS5+6bPNrL97Jxy0gA+fp2mqH
 rr4m8iFLQebRG7OZbvF/icLF0h7RKzQW/MXbMuMUcbnixkdne8AEPR6Ge35LCaWO9PVVXXqMbVA
 rKqfK5a7mS/H3RqepZZ7dNsbxr/cnOOw6OiVPhWEI+X69bfIZKckr4mrc+FIDZ0lMtS0OsgVrgN
 o1RFalQg==
X-Gm-Gg: AYBFou21y7a+pJzkp9Xxm/ehk9vGstKj+g57f8AAOrY7yowCXCxlsjnFoLBFchXOV0v
 TASzg6dITSuL2oW75oU0QSZ4RojDNLUlVHTMMg2w74AQmxqjhiQCBjdyiK9Ll6nCMwMwLrTecfo
 nuY733AxvhGLKrMpozO2EvfAIoKjOw18t8xp2RtDVoNx1V7GMnALDomDozBKV5KOAn5wcw2ViNJ
 4SQqBAk7ZqTeTDNhtCsuhOf0hWW60LO90g8IXVOUEA0E0IfaQtbOXHHrET5q8pLkJDeugLOExcT
 IR5YzEgNwK+nsRNoOXTCn1kSrDL5uJu9nI8bTOtp1Hgl4xhSoKmYr2qbKKmwOR6RDKCp5ZqM0Zm
 nhskCKTmq+rTxe0pjopZgDaPK64wDhlDSBCB+VdVNoMg7kNEFtBFonPX/ZzjqZWuAZ08hQRnm/H
 UF/XaIOB92eCgcaZ9FvT4eTHdMGIJyFR+fk2tPgAEfDnUvQpVQPZGf+rCZOSR5Pu2VALoR2NSp/
 Xuy6kQZEiyOSEDI1M+ewlZyCC3PCuwhKqwPFF56FGPMcxaF1FlUeNhSxSFLM4m1gWtKt42Kabq6
 xo6JuuHRQHCj3WcMY2ZbPh9BvZIGxG2OR4WToNA7rYAj9ahtNC38qZonQ09EFgiUeN7B9AxuLFY
 1JTgbH/QZ1upeXzkEePobzsT3R3XLqX7dCJxHeG+y1KOJm3JUkk3jceJx75r4F74vpvOdhWWcDt
 Hm4O/qMv7FzW03ZQ==
X-Received: by 2002:a05:600c:19d3:b0:4a2:526b:d40f with SMTP id
 5b1f17b1804b1-4ac1209eafcmr294496845e9.0.1793705815823; 
 Tue, 03 Nov 2026 03:36:55 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09ad35fdsm229295335e9.2.2026.11.03.03.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:36:55 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 11:36:52 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815
X-Gerrit-Change-Number: 2082
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2082?usp=email>
X-Gerrit-Commit: 32fe3f7efec282f7536150bfcee804658ac0206c
In-Reply-To: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
References: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkk1ZWUyMzFkMTU3NDU5ZTY0MDZmMWY0YzEyY2Q2YzZlMGZjZTkzODE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <085e671f216eca8709cc25a402803998a1bffd8c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOCp4-000000002Lo-3kig
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7233565730404099466=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7233565730404099466==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="M9XkH3Nalmk="; charset=UTF-8

--M9XkH3Nalmk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Gert=
 Doering, R=C4=83zvan Cojocaru=2E

Hello Frank Lichtenheld, Gert Doering, R=
=C4=83zvan Cojocaru, 

I'd like you to reexamine a change=2E Please visit

=
    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail

to look at=
 the new patch set (#4)=2E

The following approvals got outdated and were r=
emoved:
Code-Review+2 by R=C4=83zvan Cojocaru, Code-Review-1 by Gert Doerin=
g


Change subject: Remove replay-persist
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove replay-persist

This feature is very ni=
che and we do not think it is something we
should maintain and support goin=
g forward=2E

This feature saves a single packet id to persist-replay file=
=2E
This makes the feature only properly work in a p2p setup where both
sid=
es use replay-persist to save the last known packet id from the
peer=2E Eve=
n then it will only prevent some packet replays until the
legitimate peer s=
ends a packet again=2E

In server mode (p2mp) each client context has its o=
wn replay state
and saving a single packet id is also not very useful with =
multiple
clients and multiple states=2E

Change-Id: I5ee231d157459e6406f1f4=
c12cd6c6e0fce93815
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M C=
hanges=2Emd
M config=2Eh=2Ecmake=2Ein
M configure=2Eac
M doc/man-sections/l=
ink-options=2Erst
M doc/man-sections/tls-options=2Erst
M doc/man-sections/u=
nsupported-options=2Erst
M src/openvpn/check_file_access=2Ec
M src/openvpn/=
crypto=2Ec
M src/openvpn/crypto=2Eh
M src/openvpn/errlevel=2Eh
M src/openvp=
n/forward=2Ec
M src/openvpn/init=2Ec
M src/openvpn/openvpn=2Eh
M src/openvp=
n/options=2Ec
M src/openvpn/options=2Eh
M src/openvpn/options_show=2Ec
M sr=
c/openvpn/packet_id=2Ec
M src/openvpn/packet_id=2Eh
M src/openvpn/ssl=2Ec
M=
 src/openvpn/syshead=2Eh
M src/openvpn/tls_crypt=2Ec
21 files changed, 34 i=
nsertions(+), 330 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29=
418/openvpn refs/changes/82/2082/4

diff --git a/Changes=2Emd b/Changes=2Em=
d
index 7f47f77=2E=2E89a72fe 100644
--- a/Changes=2Emd
+++ b/Changes=2Emd
@=
@ -30,6 +30,12 @@
   "too complicated", using `--peer-fingerprint` makes TL=
S mode about as easy as
   using `--secret`=2E
 
+* **`replay-persist` has =
been removed**
+
+  This feature has been removed as it was never properly =
implemented for
+  server mode and generally was a niche feature=2E If the =
option is present
+  it will be ignored=2E
+
 ## Maintainer-visible changes=

 
 - The configure-time option `--enable-debug` is no longer  available
di=
ff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein
index 5e06a63=
=2E=2Ef7818cf 100644
--- a/config=2Eh=2Ecmake=2Ein
+++ b/config=2Eh=2Ecmake=
=2Ein
@@ -285,9 +285,6 @@
 /* Define to 1 if you have the <sys/epoll=2Eh> h=
eader file=2E */
 #cmakedefine HAVE_SYS_EPOLL_H
 
-/* Define to 1 if you ha=
ve the <sys/file=2Eh> header file=2E */
-#undef HAVE_SYS_FILE_H
-
 /* Defin=
e to 1 if you have the <sys/inotify=2Eh> header file=2E */
 #cmakedefine HA=
VE_SYS_INOTIFY_H
 
diff --git a/configure=2Eac b/configure=2Eac
index 5f187=
98=2E=2E9326c4e 100644
--- a/configure=2Eac
+++ b/configure=2Eac
@@ -453,7 =
+453,7 @@
 ])
 AC_CHECK_HEADERS([ \
 	sys/time=2Eh sys/ioctl=2Eh sys/stat=
=2Eh \
-	sys/mman=2Eh sys/file=2Eh sys/wait=2Eh \
+	sys/mman=2Eh sys/wait=
=2Eh \
 	libgen=2Eh stropts=2Eh \
 	syslog=2Eh pwd=2Eh grp=2Eh \
 	sys/sock=
io=2Eh sys/uio=2Eh \
@@ -561,8 +561,7 @@
 AC_CHECK_FUNCS([ \
 	daemon chroo=
t getpwnam setuid nice dup dup2 \
 	syslog openlog mlockall getrlimit getgr=
nam setgid \
-	setgroups flock gettimeofday \
-	setsid chdir \
+	setgroups =
gettimeofday setsid chdir \
 	chsize ftruncate execve getpeereid basename d=
irname \
 	epoll_create strlcpy strsep strtok_r \
 ])
diff --git a/doc/man-=
sections/link-options=2Erst b/doc/man-sections/link-options=2Erst
index 735=
ee51=2E=2Ebbdcf7f 100644
--- a/doc/man-sections/link-options=2Erst
+++ b/do=
c/man-sections/link-options=2Erst
@@ -440,19 +440,6 @@
   physical IP layer=
=2E The problem is easily fixed by simply using TCP as
   the VPN transport=
 layer=2E
 
---replay-persist file
-  Persist replay-protection state acros=
s sessions using ``file`` to save
-  and reload the state=2E
-
-  This opti=
on will keep a disk copy of the current replay protection state
-  (i=2Ee=
=2E the most recent packet timestamp and sequence number received from
-  t=
he remote peer), so that if an OpenVPN session is stopped and
-  restarted,=
 it will reject any replays of packets which were already
-  received by th=
e prior session=2E
-
-  This option only makes sense when replay protection=
 is enabled (the
-  default) and you are using TLS mode with ``--tls-auth``=
=2E
-
 --session-timeout n
   Raises :code:`SIGTERM` for the client instanc=
e after ``n`` seconds since
   the beginning of the session, forcing OpenVP=
N to disconnect=2E
diff --git a/doc/man-sections/tls-options=2Erst b/doc/ma=
n-sections/tls-options=2Erst
index c4aa810=2E=2Ede4d324 100644
--- a/doc/ma=
n-sections/tls-options=2Erst
+++ b/doc/man-sections/tls-options=2Erst
@@ -3=
70,10 +370,7 @@
   level has had a chance to authenticate the peer=2E The r=
esult is that
   packets without the correct signature can be dropped immed=
iately upon
   reception, before they have a chance to consume additional s=
ystem
-  resources such as by initiating a TLS handshake=2E ``--tls-auth`` =
can be
-  strengthened by adding the ``--replay-persist`` option which will=
 keep
-  OpenVPN's replay protection state in a file so that it is not lost=

-  across restarts=2E
+  resources such as by initiating a TLS handshake=
=2E
 
   It should be emphasized that this feature is optional and that the=
 key
   file used with ``--tls-auth`` gives a peer nothing more than the po=
wer
diff --git a/doc/man-sections/unsupported-options=2Erst b/doc/man-secti=
ons/unsupported-options=2Erst
index 2794f12=2E=2Effac260 100644
--- a/doc/m=
an-sections/unsupported-options=2Erst
+++ b/doc/man-sections/unsupported-op=
tions=2Erst
@@ -79,3 +79,8 @@
 
 --allow-deprecated-insecure-static-crypto
=
   Removed in OpenVPN 2=2E8 as --secret was also removed=2E
+
+--replay-per=
sist
+  Removed OpenVPN 2=2E8=2E This option never really worked well with =
``--server``
+  and the usefulness of this option in p2p setups is not very=
 high either=2E
+  It is now ignored if present in the configuration file=
=2E
diff --git a/src/openvpn/check_file_access=2Ec b/src/openvpn/check_file=
_access=2Ec
index 90dbb4e=2E=2E09635cb 100644
--- a/src/openvpn/check_file_=
access=2Ec
+++ b/src/openvpn/check_file_access=2Ec
@@ -312,9 +312,6 @@
    =
                                      ce->tls_crypt_v2_file, R_OK, "--tls-c=
rypt-v2");
     }
 
-    errs |=3D check_file_access(CHKACC_DIRPATH | CHKAC=
C_FILEXSTWR, options->packet_id_file,
-                              R_OK |=
 W_OK, "--replay-persist");
-
     /* ** Password files ** */
     errs |=
=3D check_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
    =
                           options->key_pass_file, R_OK, "--askpass");
diff=
 --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index d375273=2E=
=2E9b8c7aaa 100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2E=
c
@@ -403,10 +403,6 @@
     if (packet_id_test(recv, pin))
     {
         =
packet_id_add(recv, pin);
-        if (opt->pid_persist && (opt->flags & CO=
_PACKET_ID_LONG_FORM))
-        {
-            packet_id_persist_save_obj(o=
pt->pid_persist, &opt->packet_id);
-        }
         ret =3D true;
     }=

     else
diff --git a/src/openvpn/crypto=2Eh b/src/openvpn/crypto=2Eh
ind=
ex 203f77b=2E=2E4962835 100644
--- a/src/openvpn/crypto=2Eh
+++ b/src/openv=
pn/crypto=2Eh
@@ -339,11 +339,6 @@
                                  *   Th=
e packet id also used as the IV
                                  *   for A=
EAD/OFB/CFG ciphers=2E
                                  */
-    struct pac=
ket_id_persist *pid_persist;
-    /**< Persistent packet ID state for
-    =
 *   keeping state between successive
-     *   OpenVPN process startups=2E=
 */
-
 #define CO_PACKET_ID_LONG_FORM         (1u << 0)
     /**< Bit-flag =
indicating whether to use
      *   OpenVPN's long packet ID format=2E */
d=
iff --git a/src/openvpn/errlevel=2Eh b/src/openvpn/errlevel=2Eh
index d79ef=
bb=2E=2E60d20ad 100644
--- a/src/openvpn/errlevel=2Eh
+++ b/src/openvpn/err=
level=2Eh
@@ -64,7 +64,6 @@
 #define D_MULTI_ERRORS   LOGLEV(1, 9, M_NONFAT=
AL)   /* show multi-client server errors */
 #define D_EVENT_ERRORS   LOGLE=
V(1, 10, M_NONFATAL)  /* show event=2E[ch] errors */
 #define D_PUSH_ERRORS=
    LOGLEV(1, 11, M_NONFATAL)  /* show push/pull errors */
-#define D_PID_P=
ERSIST    LOGLEV(1, 12, M_NONFATAL)  /* show packet_id persist errors */
 #=
define D_FRAG_ERRORS    LOGLEV(1, 13, M_NONFATAL)  /* show fragmentation er=
rors */
 #define D_ALIGN_ERRORS   LOGLEV(1, 14, M_NONFATAL)  /* show bad st=
ruct alignments */
 
@@ -161,16 +160,15 @@
 #define D_EVENT_WAIT        LOG=
LEV(8, 70, M_DEBUG)      /* show detailed info from event waits */
 #define=
 D_MULTI_TCP         LOGLEV(8, 70, M_DEBUG)      /* show debug info from mt=
cp=2Ec */
 
-#define D_TLS_DEBUG         LOGLEV(9, 70, M_DEBUG)      /* sho=
w detailed info from TLS routines */
-#define D_COMP              LOGLEV(9,=
 70, M_DEBUG)      /* show compression info */
-#define D_READ_WRITE       =
 LOGLEV(9, 70, M_DEBUG)      /* show all tun/tcp/udp reads/writes/opens */
=
-#define D_PACKET_CONTENT    LOGLEV(9, 70, M_DEBUG)      /* show before/aft=
er encryption packet content */
-#define D_TLS_NO_SEND_KEY   LOGLEV(9, 70, =
M_DEBUG)      /* show when no data channel send-key exists */
-#define D_PI=
D_PERSIST_DEBUG LOGLEV(9, 70, M_DEBUG)      /* show packet-id persist debug=
ging info */
-#define D_LINK_RW_VERBOSE   LOGLEV(9, 70, M_DEBUG)      /* in=
crease link reads/writes verbosity */
-#define D_STREAM_DEBUG      LOGLEV(9=
, 70, M_DEBUG)      /* show TCP stream debug info */
-#define D_WIN32_IO   =
       LOGLEV(9, 70, M_DEBUG)      /* win32 I/O debugging info */
-#define =
D_PKCS11_DEBUG      LOGLEV(9, 70, M_DEBUG)      /* show PKCS#11 debugging *=
/
+#define D_TLS_DEBUG       LOGLEV(9, 70, M_DEBUG)        /* show detailed=
 info from TLS routines */
+#define D_COMP            LOGLEV(9, 70, M_DEBUG=
)        /* show compression info */
+#define D_READ_WRITE      LOGLEV(9, 7=
0, M_DEBUG)        /* show all tun/tcp/udp reads/writes/opens */
+#define D=
_PACKET_CONTENT  LOGLEV(9, 70, M_DEBUG)        /* show before/after encrypt=
ion packet content */
+#define D_TLS_NO_SEND_KEY LOGLEV(9, 70, M_DEBUG)    =
    /* show when no data channel send-key exists */
+#define D_LINK_RW_VERB=
OSE LOGLEV(9, 70, M_DEBUG)        /* increase link reads/writes verbosity *=
/
+#define D_STREAM_DEBUG    LOGLEV(9, 70, M_DEBUG)        /* show TCP stre=
am debug info */
+#define D_WIN32_IO        LOGLEV(9, 70, M_DEBUG)        /=
* win32 I/O debugging info */
+#define D_PKCS11_DEBUG    LOGLEV(9, 70, M_DE=
BUG)        /* show PKCS#11 debugging */
 
 #define D_SHAPER_DEBUG LOGLEV(1=
0, 70, M_DEBUG)          /* show traffic shaper info */
 
diff --git a/src/=
openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index 681210d=2E=2E0db0584 10=
0644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -744,14=
 +744,6 @@
 static void
 process_coarse_timers(struct context *c)
 {
-    /=
* flush current packet-id to file once per 60
-     * seconds if --replay-p=
ersist was specified */
-    if (packet_id_persist_enabled(&c->c1=2Epid_per=
sist)
-        && event_timeout_trigger(&c->c2=2Epacket_id_persist_interval=
, &c->c2=2Etimeval, ETT_DEFAULT))
-    {
-        packet_id_persist_save(&c=
->c1=2Epid_persist);
-    }
-
     /* Should we write timer-triggered statu=
s file */
     if (c->c1=2Estatus_output
         && event_timeout_trigger(=
&c->c1=2Estatus_output->et, &c->c2=2Etimeval, ETT_DEFAULT))
diff --git a/sr=
c/openvpn/init=2Ec b/src/openvpn/init=2Ec
index ff00151=2E=2E63553fd 100644=

--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -66,7 +66,6 @@
 /=
*
  * Crypto initialization flags
  */
-#define CF_LOAD_PERSISTED_PACKET_ID=
 (1 << 0)
 #define CF_INIT_TLS_MULTI           (1 << 1)
 #define CF_INIT_TL=
S_AUTH_STANDALONE (1 << 2)
 
@@ -741,8 +740,6 @@
 {
     context_clear_1(c)=
;
 
-    packet_id_persist_init(&c->c1=2Epid_persist);
-
     init_connecti=
on_list(c);
 
     c->c1=2Elink_sockets_num =3D c->options=2Ece=2Elocal_lis=
t->len;
@@ -1350,12 +1347,6 @@
                                now);
      =
   }
 
-        /* initialize packet_id persistence timer */
-        if (c=
->options=2Epacket_id_file)
-        {
-            event_timeout_init(&c->=
c2=2Epacket_id_persist_interval, 60, now);
-        }
-
         /* initial=
ize tmp_int optimization that limits the number of times we call
          =
* tls_multi_process in the main event loop */
         interval_init(&c->c2=
=2Etmp_int, TLS_MULTI_HORIZON, TLS_MULTI_REFRESH);
@@ -2955,31 +2946,16 @@
=
 }
 
 static void
-init_crypto_pre(struct context *c, const unsigned int fl=
ags)
-{
-    if (c->options=2Eengine)
-    {
-        crypto_init_lib_engin=
e(c->options=2Eengine);
-    }
-
-    if (flags & CF_LOAD_PERSISTED_PACKET_=
ID)
-    {
-        /* load a persisted packet-id for cross-session replay-=
protection */
-        if (c->options=2Epacket_id_file)
-        {
-       =
     packet_id_persist_load(&c->c1=2Epid_persist, c->options=2Epacket_id_fi=
le);
-        }
-    }
-}
-
-
-static void
 do_init_crypto_test(struct cont=
ext *c)
 {
     const struct options *options =3D &c->options;
     ASSERT(=
options->test_crypto);
 
-    init_crypto_pre(c, 0);
+    const unsigned in=
t flags =3D 0;
+    if (c->options=2Eengine)
+    {
+        crypto_init_li=
b_engine(c->options=2Eengine);
+    }
 
     c->c2=2Ecrypto_options=2Eflags=
 |=3D CO_PACKET_ID_LONG_FORM;
 
@@ -3180,7 +3156,10 @@
     ASSERT(options-=
>tls_server || options->tls_client);
     ASSERT(!options->test_crypto);
 
=
-    init_crypto_pre(c, flags);
+    if (c->options=2Eengine)
+    {
+     =
   crypto_init_lib_engine(c->options=2Eengine);
+    }
 
     /* Make sure =
we are either a TLS client or server but not both */
     ASSERT(options->t=
ls_server =3D=3D !options->tls_client);
@@ -3358,7 +3337,6 @@
     if (to=
=2Etls_wrap=2Emode =3D=3D TLS_WRAP_AUTH || to=2Etls_wrap=2Emode =3D=3D TLS_=
WRAP_CRYPT)
     {
         to=2Etls_wrap=2Eopt=2Ekey_ctx_bi =3D c->c1=2Eks=
=2Etls_wrap_key;
-        to=2Etls_wrap=2Eopt=2Epid_persist =3D &c->c1=2Epi=
d_persist;
         to=2Etls_wrap=2Eopt=2Eflags |=3D CO_PACKET_ID_LONG_FORM=
;
         to=2Etls_wrap=2Eoriginal_wrap_keydata =3D c->c1=2Eks=2Eoriginal_=
wrap_keydata;
     }
@@ -3917,11 +3895,6 @@
 do_close_packet_id(struct cont=
ext *c)
 {
     packet_id_free(&c->c2=2Ecrypto_options=2Epacket_id);
-    p=
acket_id_persist_save(&c->c1=2Epid_persist);
-    if (!(c->sig->signal_rece=
ived =3D=3D SIGUSR1))
-    {
-        packet_id_persist_close(&c->c1=2Epid_=
persist);
-    }
 }
 
 #ifdef ENABLE_FRAGMENT
@@ -4457,7 +4430,7 @@
       =
  }
         else if (c->mode =3D=3D CM_P2P)
         {
-            crypto=
_flags =3D CF_LOAD_PERSISTED_PACKET_ID | CF_INIT_TLS_MULTI;
+            cr=
ypto_flags =3D CF_INIT_TLS_MULTI;
         }
         else if (child)
     =
    {
@@ -4715,7 +4688,6 @@
     ALLOC_OBJ_CLEAR_GC(dest->sig, struct signa=
l_info, &dest->gc);
 
     /* c1 init */
-    packet_id_persist_init(&dest-=
>c1=2Epid_persist);
     dest->c1=2Elink_sockets_num =3D 1;
     do_link_so=
cket_addr_new(dest);
 
diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/o=
penvpn=2Eh
index cdd02b6=2E=2E52f298b 100644
--- a/src/openvpn/openvpn=2Eh
=
+++ b/src/openvpn/openvpn=2Eh
@@ -75,21 +75,6 @@
 };
 
 /*
- * struct packe=
t_id_persist should be empty if we are not
- * building with crypto=2E
- */=

-#ifndef PACKET_ID_H
-struct packet_id_persist
-{
-    int dummy;
-};
-sta=
tic inline void
-packet_id_persist_init(struct packet_id_persist *p)
-{
-}
=
-#endif
-
-/*
  * Packet processing buffers=2E
  */
 struct context_buffers=

@@ -167,9 +152,6 @@
     /* preresolved and cached host names */
     stru=
ct cached_dns_entry *dns_cache;
 
-    /* persist crypto sequence number to=
/from file */
-    struct packet_id_persist pid_persist;
-
     struct tunt=
ap *tuntap; /**< Tun/tap virtual network interface=2E */
     bool tuntap_o=
wned;     /**< Whether the tun/tap interface should
                       =
      *   be cleaned up when this %context is
@@ -352,8 +334,6 @@
      *  =
 Channel Crypto module\endlink to
      *   process data channel packet=2E =
*/
 
-    struct event_timeout packet_id_persist_interval;
-
 #ifdef USE_CO=
MP
     struct compress_context *comp_context;
     /**< Compression contex=
t used by the
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2E=
c
index a3c7601=2E=2E7032637 100644
--- a/src/openvpn/options=2Ec
+++ b/src=
/openvpn/options=2Ec
@@ -573,8 +573,6 @@
     "--replay-window n [t]  : Use=
 a replay protection sliding window of size n\n"
     "                    =
     and a time window of t seconds=2E\n"
     "                         De=
fault n=3D%d t=3D%d\n"
-    "--replay-persist file : Persist replay-protect=
ion state across sessions\n"
-    "                  using file=2E\n"
     =
"--test-crypto   : Run a self-test of crypto features enabled=2E\n"
     " =
                 For debugging only=2E\n"
     "\n"
@@ -7047,7 +7045,7 @@
 =
    else if (streq(p[0], "replay-persist") && p[1] && !p[2])
     {
       =
  VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->packet_id_file =3D p[=
1];
+        msg(M_WARN, "DEPRECATED OPTION: --replay-persist option ignore=
d=2E");
     }
     else if (streq(p[0], "test-crypto") && !p[1])
     {
di=
ff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index 129267f=
=2E=2Edd8b75a 100644
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
index 55043e5=2E=2E67df7c2 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/=
openvpn/ssl=2Ec
@@ -878,8 +878,6 @@
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
index 23c7975=2E=2Ee7fb865 100644
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce938=
15
Gerrit-Change-Number: 2082
Gerrit-PatchSet: 4
Gerrit-Owner: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lic=
htenheld=2Ecom>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Ger=
rit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gert Doering <gert@greenie=2Emu=
c=2Ede>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--M9XkH3Nalmk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Gert Doering, R=C4=
=83zvan Cojocaru=2E </p>
<p>Arne Schwabe <strong>uploaded patch set #4</str=
ong> to this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2082?usp=3Demail">View Change</a></p><p>The following approvals got=
 outdated and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru, Code-Rev=
iew-1 by Gert Doering</p><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">Remove replay-persist<br><br>This fe=
ature is very niche and we do not think it is something we<br>should mainta=
in and support going forward=2E<br><br>This feature saves a single packet i=
d to persist-replay file=2E<br>This makes the feature only properly work in=
 a p2p setup where both<br>sides use replay-persist to save the last known =
packet id from the<br>peer=2E Even then it will only prevent some packet re=
plays until the<br>legitimate peer sends a packet again=2E<br><br>In server=
 mode (p2mp) each client context has its own replay state<br>and saving a s=
ingle packet id is also not very useful with multiple<br>clients and multip=
le states=2E<br><br>Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815<br=
>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M Changes=
=2Emd<br>M config=2Eh=2Ecmake=2Ein<br>M configure=2Eac<br>M doc/man-section=
s/link-options=2Erst<br>M doc/man-sections/tls-options=2Erst<br>M doc/man-s=
ections/unsupported-options=2Erst<br>M src/openvpn/check_file_access=2Ec<br=
>M src/openvpn/crypto=2Ec<br>M src/openvpn/crypto=2Eh<br>M src/openvpn/errl=
evel=2Eh<br>M src/openvpn/forward=2Ec<br>M src/openvpn/init=2Ec<br>M src/op=
envpn/openvpn=2Eh<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh=
<br>M src/openvpn/options_show=2Ec<br>M src/openvpn/packet_id=2Ec<br>M src/=
openvpn/packet_id=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/syshead=2Eh=
<br>M src/openvpn/tls_crypt=2Ec<br>21 files changed, 34 insertions(+), 330 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/82/2082/4</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/Changes=2Emd b=
/Changes=2Emd</span><br><span>index 7f47f77=2E=2E89a72fe 100644</span><br><=
span>--- a/Changes=2Emd</span><br><span>+++ b/Changes=2Emd</span><br><span>=
@@ -30,6 +30,12 @@</span><br><span>   &quot;too complicated&quot;, using `-=
-peer-fingerprint` makes TLS mode about as easy as</span><br><span>   using=
 `--secret`=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+* **`replay-persist` has been removed**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  This feature has been removed as it was never properly imp=
lemented for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  serve=
r mode and generally was a niche feature=2E If the option is present</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  it will be ignored=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> ## M=
aintainer-visible changes</span><br><span> </span><br><span> - The configur=
e-time option `--enable-debug` is no longer  available</span><br><span>diff=
 --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein</span><br><span>=
index 5e06a63=2E=2Ef7818cf 100644</span><br><span>--- a/config=2Eh=2Ecmake=
=2Ein</span><br><span>+++ b/config=2Eh=2Ecmake=2Ein</span><br><span>@@ -285=
,9 +285,6 @@</span><br><span> /* Define to 1 if you have the &lt;sys/epoll=
=2Eh&gt; header file=2E */</span><br><span> #cmakedefine HAVE_SYS_EPOLL_H</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* De=
fine to 1 if you have the &lt;sys/file=2Eh&gt; header file=2E */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#undef HAVE_SYS_FILE_H</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* Define to =
1 if you have the &lt;sys/inotify=2Eh&gt; header file=2E */</span><br><span=
> #cmakedefine HAVE_SYS_INOTIFY_H</span><br><span> </span><br><span>diff --=
git a/configure=2Eac b/configure=2Eac</span><br><span>index 5f18798=2E=2E93=
26c4e 100644</span><br><span>--- a/configure=2Eac</span><br><span>+++ b/con=
figure=2Eac</span><br><span>@@ -453,7 +453,7 @@</span><br><span> ])</span><=
br><span> AC_CHECK_HEADERS([ \</span><br><span> 	sys/time=2Eh sys/ioctl=2Eh=
 sys/stat=2Eh \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	sys/m=
man=2Eh sys/file=2Eh sys/wait=2Eh \</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+	sys/mman=2Eh sys/wait=2Eh \</span><br><span> 	libgen=2Eh s=
tropts=2Eh \</span><br><span> 	syslog=2Eh pwd=2Eh grp=2Eh \</span><br><span=
> 	sys/sockio=2Eh sys/uio=2Eh \</span><br><span>@@ -561,8 +561,7 @@</span><=
br><span> AC_CHECK_FUNCS([ \</span><br><span> 	daemon chroot getpwnam setui=
d nice dup dup2 \</span><br><span> 	syslog openlog mlockall getrlimit getgr=
nam setgid \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	setgroup=
s flock gettimeofday \</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	setsid chdir \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	se=
tgroups gettimeofday setsid chdir \</span><br><span> 	chsize ftruncate exec=
ve getpeereid basename dirname \</span><br><span> 	epoll_create strlcpy str=
sep strtok_r \</span><br><span> ])</span><br><span>diff --git a/doc/man-sec=
tions/link-options=2Erst b/doc/man-sections/link-options=2Erst</span><br><s=
pan>index 735ee51=2E=2Ebbdcf7f 100644</span><br><span>--- a/doc/man-section=
s/link-options=2Erst</span><br><span>+++ b/doc/man-sections/link-options=2E=
rst</span><br><span>@@ -440,19 +440,6 @@</span><br><span>   physical IP lay=
er=2E The problem is easily fixed by simply using TCP as</span><br><span>  =
 the VPN transport layer=2E</span><br><span> </span><br><span>---replay-per=
sist file</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Persist re=
play-protection state across sessions using ``file`` to save</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  and reload the state=2E</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  This option will keep a disk copy of the current re=
play protection state</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  (i=2Ee=2E the most recent packet timestamp and sequence number received f=
rom</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  the remote peer)=
, so that if an OpenVPN session is stopped and</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-  restarted, it will reject any replays of packets=
 which were already</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
received by the prior session=2E</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  This opt=
ion only makes sense when replay protection is enabled (the</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  default) and you are using TLS mode=
 with ``--tls-auth``=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span> --session-timeout n</span><br><span>   Raises :code:`SI=
GTERM` for the client instance after ``n`` seconds since</span><br><span>  =
 the beginning of the session, forcing OpenVPN to disconnect=2E</span><br><=
span>diff --git a/doc/man-sections/tls-options=2Erst b/doc/man-sections/tls=
-options=2Erst</span><br><span>index c4aa810=2E=2Ede4d324 100644</span><br>=
<span>--- a/doc/man-sections/tls-options=2Erst</span><br><span>+++ b/doc/ma=
n-sections/tls-options=2Erst</span><br><span>@@ -370,10 +370,7 @@</span><br=
><span>   level has had a chance to authenticate the peer=2E The result is =
that</span><br><span>   packets without the correct signature can be droppe=
d immediately upon</span><br><span>   reception, before they have a chance =
to consume additional system</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-  resources such as by initiating a TLS handshake=2E ``--tls-auth`` =
can be</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  strengthened =
by adding the ``--replay-persist`` option which will keep</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  OpenVPN&#39;s replay protection state=
 in a file so that it is not lost</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  across restarts=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  resources such as by initiating a TLS handshake=2E</span><br=
><span> </span><br><span>   It should be emphasized that this feature is op=
tional and that the key</span><br><span>   file used with ``--tls-auth`` gi=
ves a peer nothing more than the power</span><br><span>diff --git a/doc/man=
-sections/unsupported-options=2Erst b/doc/man-sections/unsupported-options=
=2Erst</span><br><span>index 2794f12=2E=2Effac260 100644</span><br><span>--=
- a/doc/man-sections/unsupported-options=2Erst</span><br><span>+++ b/doc/ma=
n-sections/unsupported-options=2Erst</span><br><span>@@ -79,3 +79,8 @@</spa=
n><br><span> </span><br><span> --allow-deprecated-insecure-static-crypto</s=
pan><br><span>   Removed in OpenVPN 2=2E8 as --secret was also removed=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+--replay-persist</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  Removed OpenVPN 2=2E8=2E This option ne=
ver really worked well with ``--server``</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  and the usefulness of this option in p2p setups is n=
ot very high either=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  It is now ignored if present in the configuration file=2E</span><br><s=
pan>diff --git a/src/openvpn/check_file_access=2Ec b/src/openvpn/check_file=
_access=2Ec</span><br><span>index 90dbb4e=2E=2E09635cb 100644</span><br><sp=
an>--- a/src/openvpn/check_file_access=2Ec</span><br><span>+++ b/src/openvp=
n/check_file_access=2Ec</span><br><span>@@ -312,9 +312,6 @@</span><br><span=
>                                          ce-&gt;tls_crypt_v2_file, R_OK, =
&quot;--tls-crypt-v2&quot;);</span><br><span>     }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check_file_ac=
cess(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options-&gt;packet_id_file,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
 R_OK | W_OK, &quot;--replay-persist&quot;);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span>     /* ** Password files ** */</sp=
an><br><span>     errs |=3D check_file_access(CHKACC_FILE | CHKACC_ACPTSTDI=
N | CHKACC_PRIVATE,</span><br><span>                               options-=
&gt;key_pass_file, R_OK, &quot;--askpass&quot;);</span><br><span>diff --git=
 a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index d3=
75273=2E=2E9b8c7aaa 100644</span><br><span>--- a/src/openvpn/crypto=2Ec</sp=
an><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -403,10 +403,6=
 @@</span><br><span>     if (packet_id_test(recv, pin))</span><br><span>   =
  {</span><br><span>         packet_id_add(recv, pin);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (opt-&gt;pid_persist &amp;&amp;=
 (opt-&gt;flags &amp; CO_PACKET_ID_LONG_FORM))</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            packet_id_persist_save_obj(opt-&gt;pid_persist, &a=
mp;opt-&gt;packet_id);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        }</span><br><span>         ret =3D true;</span><br><span>     }</s=
pan><br><span>     else</span><br><span>diff --git a/src/openvpn/crypto=2Eh=
 b/src/openvpn/crypto=2Eh</span><br><span>index 203f77b=2E=2E4962835 100644=
</span><br><span>--- a/src/openvpn/crypto=2Eh</span><br><span>+++ b/src/ope=
nvpn/crypto=2Eh</span><br><span>@@ -339,11 +339,6 @@</span><br><span>      =
                            *   The packet id also used as the IV</span><br=
><span>                                  *   for AEAD/OFB/CFG ciphers=2E</s=
pan><br><span>                                  */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    struct packet_id_persist *pid_persist;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    /**&lt; Persistent pa=
cket ID state for</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
 *   keeping state between successive</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-     *   OpenVPN process startups=2E */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #define CO_PACKET_ID_LO=
NG_FORM         (1u &lt;&lt; 0)</span><br><span>     /**&lt; Bit-flag indic=
ating whether to use</span><br><span>      *   OpenVPN&#39;s long packet ID=
 format=2E */</span><br><span>diff --git a/src/openvpn/errlevel=2Eh b/src/o=
penvpn/errlevel=2Eh</span><br><span>index d79efbb=2E=2E60d20ad 100644</span=
><br><span>--- a/src/openvpn/errlevel=2Eh</span><br><span>+++ b/src/openvpn=
/errlevel=2Eh</span><br><span>@@ -64,7 +64,6 @@</span><br><span> #define D_=
MULTI_ERRORS   LOGLEV(1, 9, M_NONFATAL)   /* show multi-client server error=
s */</span><br><span> #define D_EVENT_ERRORS   LOGLEV(1, 10, M_NONFATAL)  /=
* show event=2E[ch] errors */</span><br><span> #define D_PUSH_ERRORS    LOG=
LEV(1, 11, M_NONFATAL)  /* show push/pull errors */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define D_PID_PERSIST    LOGLEV(1, 12, M_NO=
NFATAL)  /* show packet_id persist errors */</span><br><span> #define D_FRA=
G_ERRORS    LOGLEV(1, 13, M_NONFATAL)  /* show fragmentation errors */</spa=
n><br><span> #define D_ALIGN_ERRORS   LOGLEV(1, 14, M_NONFATAL)  /* show ba=
d struct alignments */</span><br><span> </span><br><span>@@ -161,16 +160,15=
 @@</span><br><span> #define D_EVENT_WAIT        LOGLEV(8, 70, M_DEBUG)    =
  /* show detailed info from event waits */</span><br><span> #define D_MULT=
I_TCP         LOGLEV(8, 70, M_DEBUG)      /* show debug info from mtcp=2Ec =
*/</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
define D_TLS_DEBUG         LOGLEV(9, 70, M_DEBUG)      /* show detailed inf=
o from TLS routines */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define D_COMP              LOGLEV(9, 70, M_DEBUG)      /* show compressio=
n info */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_RE=
AD_WRITE        LOGLEV(9, 70, M_DEBUG)      /* show all tun/tcp/udp reads/w=
rites/opens */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 D_PACKET_CONTENT    LOGLEV(9, 70, M_DEBUG)      /* show before/after encry=
ption packet content */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define D_TLS_NO_SEND_KEY   LOGLEV(9, 70, M_DEBUG)      /* show when no d=
ata channel send-key exists */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define D_PID_PERSIST_DEBUG LOGLEV(9, 70, M_DEBUG)      /* show pa=
cket-id persist debugging info */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#define D_LINK_RW_VERBOSE   LOGLEV(9, 70, M_DEBUG)      /* incr=
ease link reads/writes verbosity */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#define D_STREAM_DEBUG      LOGLEV(9, 70, M_DEBUG)      /* sh=
ow TCP stream debug info */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#define D_WIN32_IO          LOGLEV(9, 70, M_DEBUG)      /* win32 I/O =
debugging info */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine D_PKCS11_DEBUG      LOGLEV(9, 70, M_DEBUG)      /* show PKCS#11 debuggi=
ng */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_TLS_=
DEBUG       LOGLEV(9, 70, M_DEBUG)        /* show detailed info from TLS ro=
utines */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_=
COMP            LOGLEV(9, 70, M_DEBUG)        /* show compression info */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_READ_WRITE =
     LOGLEV(9, 70, M_DEBUG)        /* show all tun/tcp/udp reads/writes/ope=
ns */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_PACK=
ET_CONTENT  LOGLEV(9, 70, M_DEBUG)        /* show before/after encryption p=
acket content */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine D_TLS_NO_SEND_KEY LOGLEV(9, 70, M_DEBUG)        /* show when no data c=
hannel send-key exists */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define D_LINK_RW_VERBOSE LOGLEV(9, 70, M_DEBUG)        /* increase l=
ink reads/writes verbosity */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define D_STREAM_DEBUG    LOGLEV(9, 70, M_DEBUG)        /* show T=
CP stream debug info */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define D_WIN32_IO        LOGLEV(9, 70, M_DEBUG)        /* win32 I/O de=
bugging info */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine D_PKCS11_DEBUG    LOGLEV(9, 70, M_DEBUG)        /* show PKCS#11 debuggi=
ng */</span><br><span> </span><br><span> #define D_SHAPER_DEBUG LOGLEV(10, =
70, M_DEBUG)          /* show traffic shaper info */</span><br><span> </spa=
n><br><span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec<=
/span><br><span>index 681210d=2E=2E0db0584 100644</span><br><span>--- a/src=
/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</span><b=
r><span>@@ -744,14 +744,6 @@</span><br><span> static void</span><br><span> =
process_coarse_timers(struct context *c)</span><br><span> {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    /* flush current packet-id to fil=
e once per 60</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * s=
econds if --replay-persist was specified */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (packet_id_persist_enabled(&amp;c-&gt;c1=2Epid=
_persist)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &amp=
;&amp; event_timeout_trigger(&amp;c-&gt;c2=2Epacket_id_persist_interval, &a=
mp;c-&gt;c2=2Etimeval, ETT_DEFAULT))</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       packet_id_persist_save(&amp;c-&gt;c1=2Epid_persist);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span>     /* Should we write timer-trigge=
red status file */</span><br><span>     if (c-&gt;c1=2Estatus_output</span>=
<br><span>         &amp;&amp; event_timeout_trigger(&amp;c-&gt;c1=2Estatus_=
output-&gt;et, &amp;c-&gt;c2=2Etimeval, ETT_DEFAULT))</span><br><span>diff =
--git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index f=
f00151=2E=2E63553fd 100644</span><br><span>--- a/src/openvpn/init=2Ec</span=
><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -66,7 +66,6 @@</sp=
an><br><span> /*</span><br><span>  * Crypto initialization flags</span><br>=
<span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CF_=
LOAD_PERSISTED_PACKET_ID (1 &lt;&lt; 0)</span><br><span> #define CF_INIT_TL=
S_MULTI           (1 &lt;&lt; 1)</span><br><span> #define CF_INIT_TLS_AUTH_=
STANDALONE (1 &lt;&lt; 2)</span><br><span> </span><br><span>@@ -741,8 +740,=
6 @@</span><br><span> {</span><br><span>     context_clear_1(c);</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    packet_id_=
persist_init(&amp;c-&gt;c1=2Epid_persist);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span>     init_connection_list(c);</span><=
br><span> </span><br><span>     c-&gt;c1=2Elink_sockets_num =3D c-&gt;optio=
ns=2Ece=2Elocal_list-&gt;len;</span><br><span>@@ -1350,12 +1347,6 @@</span>=
<br><span>                                now);</span><br><span>         }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    /* initialize packet_id persistence timer */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        if (c-&gt;options=2Epacket_id_file)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            event_timeout_init(&amp;c-=
&gt;c2=2Epacket_id_persist_interval, 60, now);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span>         /* initialize tmp_int optimization t=
hat limits the number of times we call</span><br><span>          * tls_mult=
i_process in the main event loop */</span><br><span>         interval_init(=
&amp;c-&gt;c2=2Etmp_int, TLS_MULTI_HORIZON, TLS_MULTI_REFRESH);</span><br><=
span>@@ -2955,31 +2946,16 @@</span><br><span> }</span><br><span> </span><br=
><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-in=
it_crypto_pre(struct context *c, const unsigned int flags)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (c-&gt;options=2Eengine)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        crypto_init_lib_engine(c-&gt;options=2Eengine);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (flags &amp; CF_LOAD_PERSISTED_PACKET_ID)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        /* load a persisted packet-id for cross-session =
replay-protection */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (c-&gt;options=2Epacket_id_file)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            packet_id_persist_load(&amp;c-&gt;c1=2Epid_persist, c-=
&gt;options=2Epacket_id_file);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static=
 void</span><br><span> do_init_crypto_test(struct context *c)</span><br><sp=
an> {</span><br><span>     const struct options *options =3D &amp;c-&gt;opt=
ions;</span><br><span>     ASSERT(options-&gt;test_crypto);</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_crypto_pre=
(c, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const un=
signed int flags =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (c-&gt;options=2Eengine)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        crypto_init_lib_engine(c-&gt;options=2Eengine);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><sp=
an>     c-&gt;c2=2Ecrypto_options=2Eflags |=3D CO_PACKET_ID_LONG_FORM;</spa=
n><br><span> </span><br><span>@@ -3180,7 +3156,10 @@</span><br><span>     A=
SSERT(options-&gt;tls_server || options-&gt;tls_client);</span><br><span>  =
   ASSERT(!options-&gt;test_crypto);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    init_crypto_pre(c, flags);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;options=2Eengine)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        crypto_init_lib_engine(c-=
&gt;options=2Eengine);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span> </span><br><span>     /* Make sure we are either =
a TLS client or server but not both */</span><br><span>     ASSERT(options-=
&gt;tls_server =3D=3D !options-&gt;tls_client);</span><br><span>@@ -3358,7 =
+3337,6 @@</span><br><span>     if (to=2Etls_wrap=2Emode =3D=3D TLS_WRAP_AU=
TH || to=2Etls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT)</span><br><span>     {</s=
pan><br><span>         to=2Etls_wrap=2Eopt=2Ekey_ctx_bi =3D c-&gt;c1=2Eks=
=2Etls_wrap_key;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   to=2Etls_wrap=2Eopt=2Epid_persist =3D &amp;c-&gt;c1=2Epid_persist;</span=
><br><span>         to=2Etls_wrap=2Eopt=2Eflags |=3D CO_PACKET_ID_LONG_FORM=
;</span><br><span>         to=2Etls_wrap=2Eoriginal_wrap_keydata =3D c-&gt;=
c1=2Eks=2Eoriginal_wrap_keydata;</span><br><span>     }</span><br><span>@@ =
-3917,11 +3895,6 @@</span><br><span> do_close_packet_id(struct context *c)<=
/span><br><span> {</span><br><span>     packet_id_free(&amp;c-&gt;c2=2Ecryp=
to_options=2Epacket_id);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    packet_id_persist_save(&amp;c-&gt;c1=2Epid_persist);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if (!(c-&gt;sig-&gt;signal_receiv=
ed =3D=3D SIGUSR1))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        packet_id_=
persist_close(&amp;c-&gt;c1=2Epid_persist);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span> }</span><br><span> </span><br>=
<span> #ifdef ENABLE_FRAGMENT</span><br><span>@@ -4457,7 +4430,7 @@</span><=
br><span>         }</span><br><span>         else if (c-&gt;mode =3D=3D CM_=
P2P)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            crypto_flags =3D CF_LOAD_PERSISTED_PACKET_ID | CF_INI=
T_TLS_MULTI;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     crypto_flags =3D CF_INIT_TLS_MULTI;</span><br><span>         }</span><=
br><span>         else if (child)</span><br><span>         {</span><br><spa=
n>@@ -4715,7 +4688,6 @@</span><br><span>     ALLOC_OBJ_CLEAR_GC(dest-&gt;si=
g, struct signal_info, &amp;dest-&gt;gc);</span><br><span> </span><br><span=
>     /* c1 init */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  packet_id_persist_init(&amp;dest-&gt;c1=2Epid_persist);</span><br><span> =
    dest-&gt;c1=2Elink_sockets_num =3D 1;</span><br><span>     do_link_sock=
et_addr_new(dest);</span><br><span> </span><br><span>diff --git a/src/openv=
pn/openvpn=2Eh b/src/openvpn/openvpn=2Eh</span><br><span>index cdd02b6=2E=
=2E52f298b 100644</span><br><span>--- a/src/openvpn/openvpn=2Eh</span><br><=
span>+++ b/src/openvpn/openvpn=2Eh</span><br><span>@@ -75,21 +75,6 @@</span=
><br><span> };</span><br><span> </span><br><span> /*</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * struct packet_id_persist should be empty=
 if we are not</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * buil=
ding with crypto=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef PACKET_ID_H<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct packet_id_persi=
st</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    int dummy;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-static inline void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-packet_id_persist_init(struct packet_id_persist *p)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span>  * Packet processin=
g buffers=2E</span><br><span>  */</span><br><span> struct context_buffers</=
span><br><span>@@ -167,9 +152,6 @@</span><br><span>     /* preresolved and =
cached host names */</span><br><span>     struct cached_dns_entry *dns_cach=
e;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   /* persist crypto sequence number to/from file */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct packet_id_persist pid_persist;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     s=
truct tuntap *tuntap; /**&lt; Tun/tap virtual network interface=2E */</span=
><br><span>     bool tuntap_owned;     /**&lt; Whether the tun/tap interfac=
e should</span><br><span>                             *   be cleaned up whe=
n this %context is</span><br><span>@@ -352,8 +334,6 @@</span><br><span>    =
  *   Channel Crypto module\endlink to</span><br><span>      *   process da=
ta channel packet=2E */</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    struct event_timeout packet_id_persist_interval;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifdef=
 USE_COMP</span><br><span>     struct compress_context *comp_context;</span=
><br><span>     /**&lt; Compression context used by the</span><br><span>dif=
f --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span=
>index a3c7601=2E=2E7032637 100644</span><br><span>--- a/src/openvpn/option=
s=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -573=
,8 +573,6 @@</span><br><span>     &quot;--replay-window n [t]  : Use a repl=
ay protection sliding window of size n\n&quot;</span><br><span>     &quot; =
                        and a time window of t seconds=2E\n&quot;</span><br=
><span>     &quot;                         Default n=3D%d t=3D%d\n&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;--replay-persi=
st file : Persist replay-protection state across sessions\n&quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;                  usi=
ng file=2E\n&quot;</span><br><span>     &quot;--test-crypto   : Run a self-=
test of crypto features enabled=2E\n&quot;</span><br><span>     &quot;     =
             For debugging only=2E\n&quot;</span><br><span>     &quot;\n&qu=
ot;</span><br><span>@@ -7047,7 +7045,7 @@</span><br><span>     else if (str=
eq(p[0], &quot;replay-persist&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</spa=
n><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt=
;packet_id_file =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        msg(M_WARN, &quot;DEPRECATED OPTION: --replay-persist option =
ignored=2E&quot;);</span><br><span>     }</span><br><span>     else if (str=
eq(p[0], &quot;test-crypto&quot;) &amp;&amp; !p[1])</span><br><span>     {<=
/span><br><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=
=2Eh</span><br><span>index 129267f=2E=2Edd8b75a 100644</span><br><span>--- =
a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</sp=
an><br><span>@@ -582,7 +582,6 @@</span><br><span>     bool mute_replay_warn=
ings;</span><br><span>     int replay_window;</span><br><span>     int repl=
ay_time;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const cha=
r *packet_id_file;</span><br><span>     bool test_crypto;</span><br><span> =
</span><br><span>     /* TLS (control channel) parms */</span><br><span>dif=
f --git a/src/openvpn/options_show=2Ec b/src/openvpn/options_show=2Ec</span=
><br><span>index 321a37b=2E=2E54f9c4c 100644</span><br><span>--- a/src/open=
vpn/options_show=2Ec</span><br><span>+++ b/src/openvpn/options_show=2Ec</sp=
an><br><span>@@ -501,7 +501,6 @@</span><br><span>     SHOW_BOOL(mute_replay=
_warnings);</span><br><span>     SHOW_INT(replay_window);</span><br><span> =
    SHOW_INT(replay_time);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    SHOW_STR(packet_id_file);</span><br><span>     SHOW_BOOL(test_cryp=
to);</span><br><span> </span><br><span>     SHOW_BOOL(tls_server);</span><b=
r><span>diff --git a/src/openvpn/packet_id=2Ec b/src/openvpn/packet_id=2Ec<=
/span><br><span>index 9dd6ce3=2E=2Ef1fadd6 100644</span><br><span>--- a/src=
/openvpn/packet_id=2Ec</span><br><span>+++ b/src/openvpn/packet_id=2Ec</spa=
n><br><span>@@ -426,146 +426,6 @@</span><br><span>     return BSTR(&amp;out=
);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-/* initialize the packet_id_persist structure in a disabl=
ed state */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-packet_id_persist_init(stru=
ct packet_id_persist *p)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    p-&gt;filenam=
e =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    p-&gt;=
fd =3D -1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    p-&gt;t=
ime =3D p-&gt;time_last_written =3D 0;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    p-&gt;id =3D p-&gt;id_last_written =3D 0;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
/* close the file descriptor if it is open, and switch to disabled state */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-packet_id_persist_close(struct packet_=
id_persist *p)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (packet_id_persist_e=
nabled(p))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (close(p-&gt;fd)=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_PID_PERSIST | =
M_ERRNO, &quot;Close error on --replay-persist file %s&quot;, p-&gt;filenam=
e);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        packet_id_persist_init=
(p);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-/* load persisted rec packet_id (time and id) only once from file, and set=
 state to enabled */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-v=
oid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-packet_id_persist_=
load(struct packet_id_persist *p, const char *filename)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (!packet_id_persist_enabled(p))</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        /* open packet-id persist file for =
both read and write */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        p-&gt;fd =3D platform_open(filename, O_CREAT | O_RDWR | O_BINARY, =
S_IRUSR | S_IWUSR);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      if (p-&gt;fd =3D=3D -1)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        msg(D_PID_PERSIST | M_ERRNO, &quot;Cannot open --replay-persist fil=
e %s for read/write&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                filename);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            struct pack=
et_id_persist_file_image image;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            ssize_t n;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if define=
d(HAVE_FLOCK) &amp;&amp; defined(LOCK_EX) &amp;&amp; defined(LOCK_NB)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (flock(p-&gt=
;fd, LOCK_EX | LOCK_NB))</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           msg(M_ERR, &quot;Cannot obtain exclusive lock on --replay-persis=
t file %s&quot;, filename);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
ndif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            p-&gt;filename =3D filenam=
e;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            n =3D r=
ead(p-&gt;fd, &amp;image, sizeof(image));</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            if (n =3D=3D sizeof(image))</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                p-&gt;time =3D p-&gt;time_l=
ast_written =3D image=2Etime;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                p-&gt;id =3D p-&gt;id_last_written =3D image=2Eid;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                dmsg(D=
_PID_PERSIST_DEBUG, &quot;PID Persist Read from %s: %s&quot;, p-&gt;filenam=
e,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
  packet_id_persist_print(p, &amp;gc));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            else if (n =3D=3D -1)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                msg(D_PID_PERSIST | M_ERRNO, &quot;Read error=
 on --replay-persist file %s&quot;, p-&gt;filename);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/* save persisted rec packet_id (time and i=
d) to file (only if enabled state) */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-p=
acket_id_persist_save(struct packet_id_persist *p)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (packet_id_persist_enabled(p) &amp;&amp; p-&gt;time</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; (p-&gt;tim=
e !=3D p-&gt;time_last_written || p-&gt;id !=3D p-&gt;id_last_written))</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        struct packet_id_persist_file_ima=
ge image;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        CLEA=
R(image);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        off_=
t seek_ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        st=
ruct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        imag=
e=2Etime =3D p-&gt;time;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        image=2Eid =3D p-&gt;id;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        seek_ret =3D lseek(p-&gt;fd, (off_t)0, SEEK_SET);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (seek_ret =3D=
=3D (off_t)0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            const ss=
ize_t n =3D write(p-&gt;fd, &amp;image, sizeof(image));</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            if (n =3D=3D sizeof(image))</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                p-&gt;time_last=
_written =3D p-&gt;time;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                p-&gt;id_last_written =3D p-&gt;id;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                dmsg(D_PID_PERSIST_DEBUG, =
&quot;PID Persist Write to %s: %s&quot;, p-&gt;filename,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                     packet_id_persist_p=
rint(p, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(D_PI=
D_PERSIST | M_ERRNO, &quot;Cannot write to --replay-persist file %s&quot;,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    p-=
&gt;filename);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            msg(D_PID_PERSIST | M_ERRNO, &quot;C=
annot seek to beginning of --replay-persist file %s&quot;,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                p-&gt;filename);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        gc_free(&amp;gc);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* transfer packe=
t_id_persist -&gt; packet_id */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-packet_=
id_persist_load_obj(const struct packet_id_persist *p, struct packet_id *pi=
d)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (p &amp;&amp; pid &amp;&amp; pac=
ket_id_persist_enabled(p) &amp;&amp; p-&gt;time)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        pid-&gt;rec=2Etime =3D p-&gt;time;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        pid-&gt;rec=2Eid =3D p-&gt;id;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-const ch=
ar *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-packet_id_persist=
_print(const struct packet_id_persist *p, struct gc_arena *gc)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    struct buffer out =3D alloc_buf_gc(256, gc);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    buf_printf(&amp;out, &quot;[&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (packet_id_persist_enabled(p))</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        buf_printf(&amp;out, &quot; #&quot; packet=
_id_format, (packet_id_print_type)p-&gt;id);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (p-&gt;time)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            buf_printf(&amp;out, &quot; / time =3D (&quot; pac=
ket_id_format &quot;) %s&quot;, (packet_id_print_type)p-&gt;time,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                       time_str=
ing(p-&gt;time, 0, false, gc));</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    buf_printf(&amp;out, &quot; ]&quot;=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (char *)=
out=2Edata;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifndef ENAB=
LE_SMALL</span><br><span> </span><br><span> static void</span><br><span>dif=
f --git a/src/openvpn/packet_id=2Eh b/src/openvpn/packet_id=2Eh</span><br><=
span>index 48752d3=2E=2Ec374ccb 100644</span><br><span>--- a/src/openvpn/pa=
cket_id=2Eh</span><br><span>+++ b/src/openvpn/packet_id=2Eh</span><br><span=
>@@ -125,26 +125,6 @@</span><br><span> };</span><br><span> </span><br><span=
> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * file to facili=
tate cross-session persistence</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * of time/id</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct packet_id_=
persist</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    const char *filename;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    int fd;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    time_t time;       /* time stamp */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    packet_id_type id;=
 /* sequence number */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    time_t time_last_written;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    packet_id_type id_last_written;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct packet_id_=
persist_file_image</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    time_t time;       =
/* time stamp */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    p=
acket_id_type id; /* sequence number */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span>  *=
 Keep a record of our current packet-id state</span><br><span>  * on the se=
nding side=2E</span><br><span>  */</span><br><span>@@ -222,28 +202,6 @@</sp=
an><br><span> void packet_id_reap(struct packet_id_rec *p);</span><br><span=
> </span><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * packet ID persistence</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-/* initialize the packet_id_persist=
 structure in a disabled state */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-void packet_id_persist_init(struct packet_id_persist *p);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-/* close the file descriptor if it is open, and =
switch to disabled state */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-void packet_id_persist_close(struct packet_id_persist *p);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-/* load persisted rec packet_id (time and id) only on=
ce from file, and set state to enabled */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-void packet_id_persist_load(struct packet_id_persist *p=
, const char *filename);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* save persisted =
rec packet_id (time and id) to file (only if enabled state) */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-void packet_id_persist_save(struct=
 packet_id_persist *p);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* transfer packet_=
id_persist -&gt; packet_id */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-void packet_id_persist_load_obj(const struct packet_id_persist *p, =
struct packet_id *pid);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* return an ascii =
string representing a packet_id_persist object */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-const char *packet_id_persist_print(const struc=
t packet_id_persist *p, struct gc_arena *gc);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-/*</span><br><span>  * Read/write a packet ID to/from the buffer=2E  Sho=
rt form is sequence number</span><br><span>  * only=2E  Long form is sequen=
ce number and timestamp=2E</span><br><span>  */</span><br><span>@@ -273,27 =
+231,6 @@</span><br><span>     return pid-&gt;rec=2Einitialized;</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-/* are we in enabled state? */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-static inline bool</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-packet_id_persist_enabled(const struct packet_id_persist *p)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return p-&gt;fd &gt;=3D 0;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
/* transfer packet_id -&gt; packet_id_persist</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-   Note: Only supported for non-epoch format (i=2Ee=
=2E 32bit ID, not 64bit format),</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-   must be enforced at the caller=2E</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-static inline void</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-packet_id_persist_save_obj(struct packet_id_persist *p, const struct p=
acket_id *pid)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (packet_id_persist_e=
nabled(p) &amp;&amp; pid-&gt;rec=2Etime &amp;&amp; pid-&gt;rec=2Eid &lt;=3D=
 PACKET_ID_MAX)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        p-&gt;time =3D=
 pid-&gt;rec=2Etime;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       p-&gt;id =3D (packet_id_type)pid-&gt;rec=2Eid;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span> /**</span><br><span>  * Reset the current send packet id to i=
ts initial state=2E</span><br><span>  * Use very carefully (e=2Eg=2E in the=
 standalone reset packet context) to</span><br><span>diff --git a/src/openv=
pn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 55043e5=2E=2E67df7c2=
 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src=
/openvpn/ssl=2Ec</span><br><span>@@ -878,8 +878,6 @@</span><br><span>     p=
acket_id_init(&amp;ks-&gt;crypto_options=2Epacket_id, session-&gt;opt-&gt;r=
eplay_window,</span><br><span>                    session-&gt;opt-&gt;repla=
y_time, &quot;SSL&quot;, ks-&gt;key_id);</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    ks-&gt;crypto_options=2Epid_persis=
t =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     ks-&gt;mda_key_id =3D=
 session-&gt;opt-&gt;mda_context-&gt;mda_key_id_counter++;</span><br><span>=
 #endif</span><br><span>@@ -1037,9 +1035,6 @@</span><br><span>         sess=
ion-&gt;tls_wrap=2Eopt=2Epacket_id=2Esend=2Eid =3D EARLY_NEG_START;</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    /* load most recent packet-id to replay protect on --tls-au=
th */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    packet_id_pe=
rsist_load_obj(session-&gt;tls_wrap=2Eopt=2Epid_persist, &amp;session-&gt;t=
ls_wrap=2Eopt=2Epacket_id);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span>     key_state_init(session, &amp;session-&gt;key[KS=
_PRIMARY]);</span><br><span> </span><br><span>     dmsg(D_TLS_DEBUG, &quot;=
TLS: tls_session_init: new session object, sid=3D%s&quot;,</span><br><span>=
diff --git a/src/openvpn/syshead=2Eh b/src/openvpn/syshead=2Eh</span><br><s=
pan>index 1d6cdc2=2E=2E65baee3 100644</span><br><span>--- a/src/openvpn/sys=
head=2Eh</span><br><span>+++ b/src/openvpn/syshead=2Eh</span><br><span>@@ -=
127,10 +127,6 @@</span><br><span> #include &lt;fcntl=2Eh&gt;</span><br><spa=
n> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#ifdef HAVE_SYS_FILE_H</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#include &lt;sys/file=2Eh&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span> /* These headers belong to C99 and should be always be pr=
esent */</span><br><span> #include &lt;stdlib=2Eh&gt;</span><br><span> #inc=
lude &lt;inttypes=2Eh&gt;</span><br><span>diff --git a/src/openvpn/tls_cryp=
t=2Ec b/src/openvpn/tls_crypt=2Ec</span><br><span>index 23c7975=2E=2Ee7fb86=
5 100644</span><br><span>--- a/src/openvpn/tls_crypt=2Ec</span><br><span>++=
+ b/src/openvpn/tls_crypt=2Ec</span><br><span>@@ -109,7 +109,6 @@</span><br=
><span>     session-&gt;tls_wrap_reneg=2Emode =3D TLS_WRAP_CRYPT;</span><br=
><span>     session-&gt;tls_wrap_reneg=2Ecleanup_key_ctx =3D true;</span><b=
r><span>     session-&gt;tls_wrap_reneg=2Ework =3D alloc_buf(BUF_SIZE(&amp;=
session-&gt;opt-&gt;frame));</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    session-&gt;tls_wrap_reneg=2Eopt=2Epid_persist =3D NULL;</span><=
br><span> </span><br><span>     packet_id_init(&amp;session-&gt;tls_wrap_re=
neg=2Eopt=2Epacket_id, session-&gt;opt-&gt;replay_window,</span><br><span> =
                   session-&gt;opt-&gt;replay_time, &quot;TLS_WRAP_RENEG&qu=
ot;, session-&gt;key_id);</span><br></pre><p>To view, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail">change 2082</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div items=
cope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5ee2=
31d157459e6406f1f4c12cd6c6e0fce93815 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 2082 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt=
;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--M9XkH3Nalmk=--


--===============7233565730404099466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7233565730404099466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7233565730404099466==--

