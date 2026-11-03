Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230AB606A32C
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=l4o9PmoS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=S+MCmpWL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CwKmHY8n;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LcYqciOQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=nRdVLLmV/udt+aIDWvLKguHcqVbj6A86nOnYpeRE31Q=; b=l4o9PmoSDlaXUTBi/usXPgVbdn
	/WAGu/ZcC7fM6DHs2HxQb0gwSlTGfMMnDuHNlskJWiuAnUaDvRkXyxuyjiR8siIRW1cqMVOg46lyf
	8PjOfBdgY/8VjNXRbfGMw413u8cE4+d2IOZSJtnw7v7fd7UAPKsDHifBitbK60qxuJ04=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOESz-000000002to-0N3e;
	Tue, 03 Nov 2026 13:22:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOESi-000000002tF-19CB
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 13:22:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0E5jOXXArkahF0KvFQpUq7K5SZuMQCo13eWjwFunVK4=; b=S+MCmpWLWaHuX40P5yvNm7Lgc3
 gFxCKcupFdIGUUsEBiXe7BxKKFYMkSFjrXVIWPPTFmsTWssbdFDcxa2r76JrjynwtIdDBXbQ3p5qk
 wkreJ5/c7DBoD9Z8X7yROXnWjofvSAWSjmfjcxRcchxIorPjYaj+VdqHL2njwqhR+nb8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0E5jOXXArkahF0KvFQpUq7K5SZuMQCo13eWjwFunVK4=; b=CwKmHY8nXxx5aGth5g6ssOYl5k
 iN8akW/Z1ek771D01vep7DCNcyqkRaPLacxBb9GdHJ3YwkZdHWLV3W+4CNag/9fkOIxf6cvOWCDSo
 IuJH98lfmNGyyqSmgAHzUHR1ha3VxUVtAUQof8HiOiB2/al7eYvx6loY/CIUNRNspYC0=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOESV-000000003M4-0cW3 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 13:21:56 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so42422115e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 05:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793712104; x=1794316904; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0E5jOXXArkahF0KvFQpUq7K5SZuMQCo13eWjwFunVK4=;
 b=LcYqciOQkFb8krfAv/Iqv07FLHwtcdcdHcoc+4VIZ9C4VlRUwN1B4FIuE3hH5YO4Xr
 OndMp779xdetkos+zQU8CVHJj1MAMuXEun8IWnInh6mgr6QpOJ1t5aR5c40Q+1rlPHBP
 JNB7vrq0eUBrb44i+pEAeu663nveIqqyPRuU30NNuD66HzMK3iEPpbhwktjohOhlxzey
 0UvoVl+JKaFuHWmOb9k+vjyFjk7JjbkRj2M6s7TUiGQ6qov//UZb9lH1Qy9UZkvo7lbN
 1JeTv/VbAhPn+XC+f1dKKTxHfH5Tt9b96xLiktMwkG3HUa9MtXIG6+SRA/KvA0kqWeZm
 KqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793712104; x=1794316904;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0E5jOXXArkahF0KvFQpUq7K5SZuMQCo13eWjwFunVK4=;
 b=I0OEotFYotYe5fbfrqyjLd7RMvV/npbLuVxTkEj8IeFFhsCKRiMA13zLW4nbLAm03b
 KrtQV6HLyZTFkIdmALrIfbHRhA5gmkd43BAs29QsolI8tp9yr3IoBD9ZkflMXX1OHeJD
 yDYnf7hW+ukKYXgnoQObzuppiPO64LRgi14A8F9Wy0uVT5QJ6Bs6X+fe1ltNG39cvKcw
 x/XxtOc1V1NA6/ha1hZd5YuFedO8klHhEZpGQ3+Ts/aK4cTfAZOIXsr7bVlpTQ5CvG2Z
 7pg7cE/YGBk3Pjvjh6X9/KZdNUxQwkv4xffAi7aCVOMaFbIO4ZbKE5DtUzarsJ0I7gzo
 BY1A==
X-Gm-Message-State: APuU4Z+w40o7GT0YroxcufpP3xj7mPZVpBKaTdHMAKvHBn33HBgAif9H
 Al9ZCcQIvjsCmPivbFkBpHoFGcr9kQ4vavGUmHG3Hgd+CPEgprEx/zAceFQbgHHxqKULRdleymf
 oeHaTw2lLkrSGgY6IVi/u+Ql7z6O9SuPnhG+TKOv+WKrlJvtevPZDT01n+2aK9fme4Q2q
X-Gm-Gg: AYBFou11XccykYxEX0ms2O/TeOsq4WR5feqBlDxy07mg+RvDnzEZe7cT9pD9CuQgPyd
 /cx8tRqo2iILczqIsa9GqxZDaFZHqhvxV2eJ6Thcf1ckCjoL4/bvrNtoHHO7RWHCDubKvh0RsPT
 X7GeAKpoBmLCOcossF6jIiims/49rc6nHM3EYRsFJkKhcMDJ8qLcJ21dSLwAobheXmYu6jbXz0y
 M6VapX0uEgrCuivuaMri9UZdimweOgkbsX/H1iqEzn6exBoXgyum6g46KygOZV7ZnS2B/qe/X82
 COY5/Qb+7z80ViriK3VsoDfTzpAjOWn7L4NdFmxk68A6nSLA7XofLEkCj8+oMBllts8hh/Yzkwt
 YdAPB6rVfRx4MSuh/MbYvxY0ptIfIb81ICTxCi6cQ2H2mSuuJWo7UixnZTGr8VxVzoHrOcHxz6G
 Fk8kF6vnQhaxEGORMq3AwCLEUzgvf9BdROtOSZY39z4adMozI1FieXA05c+1tmlx3d4OzbnWDgx
 KhSFh8oMCHsHuZsLBhfvksJRln4F0nv+wd+ihpbsPSZy2wmh934keSUf17m0DfsHa8MLe54Vom3
 DCDUvGEN7Miode7sxP0SrwrDQ16AZw9WTqfaugmTa3fdEiLOqntF1OdPM5P3/f3R9OHXH/wuhgy
 +WILpZP8CUlTU3oBnk5LRo7UNTqMXGZO7iXG2+dDUP5Sz/n9YCamTWOINYYZGLx6aB/Qf8ImCrH
 7iE7Hdc5MNtKtKhA==
X-Received: by 2002:a05:600c:609a:b0:4a1:7c56:d4e2 with SMTP id
 5b1f17b1804b1-4ac1709aa77mr282551135e9.16.1793712103681; 
 Tue, 03 Nov 2026 05:21:43 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a8d60bc5sm59511765e9.8.2026.11.03.05.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 05:21:43 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 13:21:42 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815
X-Gerrit-Change-Number: 2082
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2082?usp=email>
X-Gerrit-Commit: 840af248f93e85d29d3f314fa6cdb24535b780f5
In-Reply-To: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
References: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkk1ZWUyMzFkMTU3NDU5ZTY0MDZmMWY0YzEyY2Q2YzZlMGZjZTkzODE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ce206a7fbfe1cee16ee37d43efc48af788d47eb4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOESV-000000003M4-0cW3
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
Content-Type: multipart/mixed; boundary="===============8103612374127496354=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8103612374127496354==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+8MMANUaWe0="; charset=UTF-8

--+8MMANUaWe0=
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
 the new patch set (#5)=2E

The following approvals got outdated and were r=
emoved:
Code-Review-1 by R=C4=83zvan Cojocaru


Change subject: Remove repl=
ay-persist
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

R=
emove replay-persist

This feature is very niche and we do not think it is =
something we
should maintain and support going forward=2E

This feature sav=
es a single packet id to persist-replay file=2E
This makes the feature only=
 properly work in a p2p setup where both
sides use replay-persist to save t=
he last known packet id from the
peer=2E Even then it will only prevent som=
e packet replays until the
legitimate peer sends a packet again=2E

In serv=
er mode (p2mp) each client context has its own replay state
and saving a si=
ngle packet id is also not very useful with multiple
clients and multiple s=
tates=2E

Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815
Signed-off-b=
y: Arne Schwabe <arne@rfc2549=2Eorg>
---
M Changes=2Emd
M config=2Eh=2Ecmak=
e=2Ein
M configure=2Eac
M doc/man-sections/link-options=2Erst
M doc/man-sec=
tions/tls-options=2Erst
M doc/man-sections/unsupported-options=2Erst
M src/=
openvpn/check_file_access=2Ec
M src/openvpn/crypto=2Ec
M src/openvpn/crypto=
=2Eh
M src/openvpn/errlevel=2Eh
M src/openvpn/forward=2Ec
M src/openvpn/ini=
t=2Ec
M src/openvpn/openvpn=2Eh
M src/openvpn/options=2Ec
M src/openvpn/opt=
ions=2Eh
M src/openvpn/options_show=2Ec
M src/openvpn/packet_id=2Ec
M src/o=
penvpn/packet_id=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/syshead=2Eh
M src/=
openvpn/tls_crypt=2Ec
21 files changed, 33 insertions(+), 330 deletions(-)
=


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/82/208=
2/5

diff --git a/Changes=2Emd b/Changes=2Emd
index 7f47f77=2E=2E89a72fe 10=
0644
--- a/Changes=2Emd
+++ b/Changes=2Emd
@@ -30,6 +30,12 @@
   "too compl=
icated", using `--peer-fingerprint` makes TLS mode about as easy as
   usin=
g `--secret`=2E
 
+* **`replay-persist` has been removed**
+
+  This featur=
e has been removed as it was never properly implemented for
+  server mode =
and generally was a niche feature=2E If the option is present
+  it will be=
 ignored=2E
+
 ## Maintainer-visible changes
 
 - The configure-time option=
 `--enable-debug` is no longer  available
diff --git a/config=2Eh=2Ecmake=
=2Ein b/config=2Eh=2Ecmake=2Ein
index 5e06a63=2E=2Ef7818cf 100644
--- a/con=
fig=2Eh=2Ecmake=2Ein
+++ b/config=2Eh=2Ecmake=2Ein
@@ -285,9 +285,6 @@
 /* =
Define to 1 if you have the <sys/epoll=2Eh> header file=2E */
 #cmakedefine=
 HAVE_SYS_EPOLL_H
 
-/* Define to 1 if you have the <sys/file=2Eh> header f=
ile=2E */
-#undef HAVE_SYS_FILE_H
-
 /* Define to 1 if you have the <sys/in=
otify=2Eh> header file=2E */
 #cmakedefine HAVE_SYS_INOTIFY_H
 
diff --git =
a/configure=2Eac b/configure=2Eac
index 5f18798=2E=2E9326c4e 100644
--- a/c=
onfigure=2Eac
+++ b/configure=2Eac
@@ -453,7 +453,7 @@
 ])
 AC_CHECK_HEADER=
S([ \
 	sys/time=2Eh sys/ioctl=2Eh sys/stat=2Eh \
-	sys/mman=2Eh sys/file=
=2Eh sys/wait=2Eh \
+	sys/mman=2Eh sys/wait=2Eh \
 	libgen=2Eh stropts=2Eh =
\
 	syslog=2Eh pwd=2Eh grp=2Eh \
 	sys/sockio=2Eh sys/uio=2Eh \
@@ -561,8 +=
561,7 @@
 AC_CHECK_FUNCS([ \
 	daemon chroot getpwnam setuid nice dup dup2 =
\
 	syslog openlog mlockall getrlimit getgrnam setgid \
-	setgroups flock g=
ettimeofday \
-	setsid chdir \
+	setgroups gettimeofday setsid chdir \
 	ch=
size ftruncate execve getpeereid basename dirname \
 	epoll_create strlcpy =
strsep strtok_r \
 ])
diff --git a/doc/man-sections/link-options=2Erst b/do=
c/man-sections/link-options=2Erst
index 735ee51=2E=2Ebbdcf7f 100644
--- a/d=
oc/man-sections/link-options=2Erst
+++ b/doc/man-sections/link-options=2Ers=
t
@@ -440,19 +440,6 @@
   physical IP layer=2E The problem is easily fixed =
by simply using TCP as
   the VPN transport layer=2E
 
---replay-persist fi=
le
-  Persist replay-protection state across sessions using ``file`` to sav=
e
-  and reload the state=2E
-
-  This option will keep a disk copy of the =
current replay protection state
-  (i=2Ee=2E the most recent packet timesta=
mp and sequence number received from
-  the remote peer), so that if an Ope=
nVPN session is stopped and
-  restarted, it will reject any replays of pac=
kets which were already
-  received by the prior session=2E
-
-  This optio=
n only makes sense when replay protection is enabled (the
-  default) and y=
ou are using TLS mode with ``--tls-auth``=2E
-
 --session-timeout n
   Rais=
es :code:`SIGTERM` for the client instance after ``n`` seconds since
   the=
 beginning of the session, forcing OpenVPN to disconnect=2E
diff --git a/do=
c/man-sections/tls-options=2Erst b/doc/man-sections/tls-options=2Erst
index=
 c4aa810=2E=2Ede4d324 100644
--- a/doc/man-sections/tls-options=2Erst
+++ b=
/doc/man-sections/tls-options=2Erst
@@ -370,10 +370,7 @@
   level has had a=
 chance to authenticate the peer=2E The result is that
   packets without t=
he correct signature can be dropped immediately upon
   reception, before t=
hey have a chance to consume additional system
-  resources such as by init=
iating a TLS handshake=2E ``--tls-auth`` can be
-  strengthened by adding t=
he ``--replay-persist`` option which will keep
-  OpenVPN's replay protecti=
on state in a file so that it is not lost
-  across restarts=2E
+  resource=
s such as by initiating a TLS handshake=2E
 
   It should be emphasized tha=
t this feature is optional and that the key
   file used with ``--tls-auth`=
` gives a peer nothing more than the power
diff --git a/doc/man-sections/un=
supported-options=2Erst b/doc/man-sections/unsupported-options=2Erst
index =
2794f12=2E=2E368805e 100644
--- a/doc/man-sections/unsupported-options=2Ers=
t
+++ b/doc/man-sections/unsupported-options=2Erst
@@ -79,3 +79,8 @@
 
 --a=
llow-deprecated-insecure-static-crypto
   Removed in OpenVPN 2=2E8 as --sec=
ret was also removed=2E
+
+--replay-persist
+  Removed in OpenVPN 2=2E8=2E =
This option never really worked well with ``--server``
+  and the usefulnes=
s of this option in p2p setups is not very high either=2E
+  It is now igno=
red if present in the configuration file=2E
diff --git a/src/openvpn/check_=
file_access=2Ec b/src/openvpn/check_file_access=2Ec
index 90dbb4e=2E=2E0963=
5cb 100644
--- a/src/openvpn/check_file_access=2Ec
+++ b/src/openvpn/check_=
file_access=2Ec
@@ -312,9 +312,6 @@
                                       =
   ce->tls_crypt_v2_file, R_OK, "--tls-crypt-v2");
     }
 
-    errs |=3D =
check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->packet_id_fil=
e,
-                              R_OK | W_OK, "--replay-persist");
-
     =
/* ** Password files ** */
     errs |=3D check_file_access(CHKACC_FILE | C=
HKACC_ACPTSTDIN | CHKACC_PRIVATE,
                               options->k=
ey_pass_file, R_OK, "--askpass");
diff --git a/src/openvpn/crypto=2Ec b/src=
/openvpn/crypto=2Ec
index d375273=2E=2E9b8c7aaa 100644
--- a/src/openvpn/cr=
ypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -403,10 +403,6 @@
     if (packet_=
id_test(recv, pin))
     {
         packet_id_add(recv, pin);
-        if (=
opt->pid_persist && (opt->flags & CO_PACKET_ID_LONG_FORM))
-        {
-    =
        packet_id_persist_save_obj(opt->pid_persist, &opt->packet_id);
-   =
     }
         ret =3D true;
     }
     else
diff --git a/src/openvpn/cry=
pto=2Eh b/src/openvpn/crypto=2Eh
index 203f77b=2E=2E4962835 100644
--- a/sr=
c/openvpn/crypto=2Eh
+++ b/src/openvpn/crypto=2Eh
@@ -339,11 +339,6 @@
    =
                              *   The packet id also used as the IV
       =
                           *   for AEAD/OFB/CFG ciphers=2E
                =
                  */
-    struct packet_id_persist *pid_persist;
-    /**< =
Persistent packet ID state for
-     *   keeping state between successive
-=
     *   OpenVPN process startups=2E */
-
 #define CO_PACKET_ID_LONG_FORM  =
       (1u << 0)
     /**< Bit-flag indicating whether to use
      *   Ope=
nVPN's long packet ID format=2E */
diff --git a/src/openvpn/errlevel=2Eh b/=
src/openvpn/errlevel=2Eh
index d79efbb=2E=2E60d20ad 100644
--- a/src/openvp=
n/errlevel=2Eh
+++ b/src/openvpn/errlevel=2Eh
@@ -64,7 +64,6 @@
 #define D_=
MULTI_ERRORS   LOGLEV(1, 9, M_NONFATAL)   /* show multi-client server error=
s */
 #define D_EVENT_ERRORS   LOGLEV(1, 10, M_NONFATAL)  /* show event=2E[=
ch] errors */
 #define D_PUSH_ERRORS    LOGLEV(1, 11, M_NONFATAL)  /* show =
push/pull errors */
-#define D_PID_PERSIST    LOGLEV(1, 12, M_NONFATAL)  /*=
 show packet_id persist errors */
 #define D_FRAG_ERRORS    LOGLEV(1, 13, M=
_NONFATAL)  /* show fragmentation errors */
 #define D_ALIGN_ERRORS   LOGLE=
V(1, 14, M_NONFATAL)  /* show bad struct alignments */
 
@@ -161,16 +160,15=
 @@
 #define D_EVENT_WAIT        LOGLEV(8, 70, M_DEBUG)      /* show detail=
ed info from event waits */
 #define D_MULTI_TCP         LOGLEV(8, 70, M_DE=
BUG)      /* show debug info from mtcp=2Ec */
 
-#define D_TLS_DEBUG       =
  LOGLEV(9, 70, M_DEBUG)      /* show detailed info from TLS routines */
-#=
define D_COMP              LOGLEV(9, 70, M_DEBUG)      /* show compression =
info */
-#define D_READ_WRITE        LOGLEV(9, 70, M_DEBUG)      /* show al=
l tun/tcp/udp reads/writes/opens */
-#define D_PACKET_CONTENT    LOGLEV(9, =
70, M_DEBUG)      /* show before/after encryption packet content */
-#defin=
e D_TLS_NO_SEND_KEY   LOGLEV(9, 70, M_DEBUG)      /* show when no data chan=
nel send-key exists */
-#define D_PID_PERSIST_DEBUG LOGLEV(9, 70, M_DEBUG) =
     /* show packet-id persist debugging info */
-#define D_LINK_RW_VERBOSE=
   LOGLEV(9, 70, M_DEBUG)      /* increase link reads/writes verbosity */
-=
#define D_STREAM_DEBUG      LOGLEV(9, 70, M_DEBUG)      /* show TCP stream =
debug info */
-#define D_WIN32_IO          LOGLEV(9, 70, M_DEBUG)      /* w=
in32 I/O debugging info */
-#define D_PKCS11_DEBUG      LOGLEV(9, 70, M_DEB=
UG)      /* show PKCS#11 debugging */
+#define D_TLS_DEBUG       LOGLEV(9, =
70, M_DEBUG)        /* show detailed info from TLS routines */
+#define D_C=
OMP            LOGLEV(9, 70, M_DEBUG)        /* show compression info */
+#=
define D_READ_WRITE      LOGLEV(9, 70, M_DEBUG)        /* show all tun/tcp/=
udp reads/writes/opens */
+#define D_PACKET_CONTENT  LOGLEV(9, 70, M_DEBUG)=
        /* show before/after encryption packet content */
+#define D_TLS_NO=
_SEND_KEY LOGLEV(9, 70, M_DEBUG)        /* show when no data channel send-k=
ey exists */
+#define D_LINK_RW_VERBOSE LOGLEV(9, 70, M_DEBUG)        /* in=
crease link reads/writes verbosity */
+#define D_STREAM_DEBUG    LOGLEV(9, =
70, M_DEBUG)        /* show TCP stream debug info */
+#define D_WIN32_IO   =
     LOGLEV(9, 70, M_DEBUG)        /* win32 I/O debugging info */
+#define =
D_PKCS11_DEBUG    LOGLEV(9, 70, M_DEBUG)        /* show PKCS#11 debugging *=
/
 
 #define D_SHAPER_DEBUG LOGLEV(10, 70, M_DEBUG)          /* show traffi=
c shaper info */
 
diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forwa=
rd=2Ec
index 681210d=2E=2E0db0584 100644
--- a/src/openvpn/forward=2Ec
+++ =
b/src/openvpn/forward=2Ec
@@ -744,14 +744,6 @@
 static void
 process_coarse=
_timers(struct context *c)
 {
-    /* flush current packet-id to file once =
per 60
-     * seconds if --replay-persist was specified */
-    if (packet=
_id_persist_enabled(&c->c1=2Epid_persist)
-        && event_timeout_trigger=
(&c->c2=2Epacket_id_persist_interval, &c->c2=2Etimeval, ETT_DEFAULT))
-    =
{
-        packet_id_persist_save(&c->c1=2Epid_persist);
-    }
-
     /* S=
hould we write timer-triggered status file */
     if (c->c1=2Estatus_outpu=
t
         && event_timeout_trigger(&c->c1=2Estatus_output->et, &c->c2=2Eti=
meval, ETT_DEFAULT))
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=
=2Ec
index ff00151=2E=2E525df7e 100644
--- a/src/openvpn/init=2Ec
+++ b/src=
/openvpn/init=2Ec
@@ -66,7 +66,6 @@
 /*
  * Crypto initialization flags
  *=
/
-#define CF_LOAD_PERSISTED_PACKET_ID (1 << 0)
 #define CF_INIT_TLS_MULTI =
          (1 << 1)
 #define CF_INIT_TLS_AUTH_STANDALONE (1 << 2)
 
@@ -741,=
8 +740,6 @@
 {
     context_clear_1(c);
 
-    packet_id_persist_init(&c->c=
1=2Epid_persist);
-
     init_connection_list(c);
 
     c->c1=2Elink_socke=
ts_num =3D c->options=2Ece=2Elocal_list->len;
@@ -1350,12 +1347,6 @@
      =
                          now);
         }
 
-        /* initialize packet_=
id persistence timer */
-        if (c->options=2Epacket_id_file)
-        =
{
-            event_timeout_init(&c->c2=2Epacket_id_persist_interval, 60, =
now);
-        }
-
         /* initialize tmp_int optimization that limits =
the number of times we call
          * tls_multi_process in the main event=
 loop */
         interval_init(&c->c2=2Etmp_int, TLS_MULTI_HORIZON, TLS_MU=
LTI_REFRESH);
@@ -2955,31 +2946,15 @@
 }
 
 static void
-init_crypto_pre(st=
ruct context *c, const unsigned int flags)
-{
-    if (c->options=2Eengine)=

-    {
-        crypto_init_lib_engine(c->options=2Eengine);
-    }
-
-   =
 if (flags & CF_LOAD_PERSISTED_PACKET_ID)
-    {
-        /* load a persist=
ed packet-id for cross-session replay-protection */
-        if (c->options=
=2Epacket_id_file)
-        {
-            packet_id_persist_load(&c->c1=2E=
pid_persist, c->options=2Epacket_id_file);
-        }
-    }
-}
-
-
-static=
 void
 do_init_crypto_test(struct context *c)
 {
     const struct options =
*options =3D &c->options;
     ASSERT(options->test_crypto);
 
-    init_cr=
ypto_pre(c, 0);
+    if (c->options=2Eengine)
+    {
+        crypto_init_l=
ib_engine(c->options=2Eengine);
+    }
 
     c->c2=2Ecrypto_options=2Eflag=
s |=3D CO_PACKET_ID_LONG_FORM;
 
@@ -3180,7 +3155,10 @@
     ASSERT(options=
->tls_server || options->tls_client);
     ASSERT(!options->test_crypto);
 =

-    init_crypto_pre(c, flags);
+    if (c->options=2Eengine)
+    {
+    =
    crypto_init_lib_engine(c->options=2Eengine);
+    }
 
     /* Make sure=
 we are either a TLS client or server but not both */
     ASSERT(options->=
tls_server =3D=3D !options->tls_client);
@@ -3358,7 +3336,6 @@
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
@@ -3917,11 +3894,6 @@
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
@@ -4457,7 +4429,7 @@
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
@@ -4715,7 +4687,6 @@
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
Gerrit-PatchSet: 5
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

--+8MMANUaWe0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Gert Doering, R=C4=
=83zvan Cojocaru=2E </p>
<p>Arne Schwabe <strong>uploaded patch set #5</str=
ong> to this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2082?usp=3Demail">View Change</a></p><p>The following approvals got=
 outdated and were removed:
Code-Review-1 by R=C4=83zvan Cojocaru</p><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">Remove replay-persist<br><br>This feature is very niche and we do n=
ot think it is something we<br>should maintain and support going forward=2E=
<br><br>This feature saves a single packet id to persist-replay file=2E<br>=
This makes the feature only properly work in a p2p setup where both<br>side=
s use replay-persist to save the last known packet id from the<br>peer=2E E=
ven then it will only prevent some packet replays until the<br>legitimate p=
eer sends a packet again=2E<br><br>In server mode (p2mp) each client contex=
t has its own replay state<br>and saving a single packet id is also not ver=
y useful with multiple<br>clients and multiple states=2E<br><br>Change-Id: =
I5ee231d157459e6406f1f4c12cd6c6e0fce93815<br>Signed-off-by: Arne Schwabe &l=
t;arne@rfc2549=2Eorg&gt;<br>---<br>M Changes=2Emd<br>M config=2Eh=2Ecmake=
=2Ein<br>M configure=2Eac<br>M doc/man-sections/link-options=2Erst<br>M doc=
/man-sections/tls-options=2Erst<br>M doc/man-sections/unsupported-options=
=2Erst<br>M src/openvpn/check_file_access=2Ec<br>M src/openvpn/crypto=2Ec<b=
r>M src/openvpn/crypto=2Eh<br>M src/openvpn/errlevel=2Eh<br>M src/openvpn/f=
orward=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/openvpn=2Eh<br>M src/=
openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn/options_s=
how=2Ec<br>M src/openvpn/packet_id=2Ec<br>M src/openvpn/packet_id=2Eh<br>M =
src/openvpn/ssl=2Ec<br>M src/openvpn/syshead=2Eh<br>M src/openvpn/tls_crypt=
=2Ec<br>21 files changed, 33 insertions(+), 330 deletions(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/82/2082/5</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/Changes=2Emd b/Changes=2Emd</span><br><sp=
an>index 7f47f77=2E=2E89a72fe 100644</span><br><span>--- a/Changes=2Emd</sp=
an><br><span>+++ b/Changes=2Emd</span><br><span>@@ -30,6 +30,12 @@</span><b=
r><span>   &quot;too complicated&quot;, using `--peer-fingerprint` makes TL=
S mode about as easy as</span><br><span>   using `--secret`=2E</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **`replay-pe=
rsist` has been removed**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  This featur=
e has been removed as it was never properly implemented for</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  server mode and generally was a n=
iche feature=2E If the option is present</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  it will be ignored=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> ## Maintainer-visible changes</s=
pan><br><span> </span><br><span> - The configure-time option `--enable-debu=
g` is no longer  available</span><br><span>diff --git a/config=2Eh=2Ecmake=
=2Ein b/config=2Eh=2Ecmake=2Ein</span><br><span>index 5e06a63=2E=2Ef7818cf =
100644</span><br><span>--- a/config=2Eh=2Ecmake=2Ein</span><br><span>+++ b/=
config=2Eh=2Ecmake=2Ein</span><br><span>@@ -285,9 +285,6 @@</span><br><span=
> /* Define to 1 if you have the &lt;sys/epoll=2Eh&gt; header file=2E */</s=
pan><br><span> #cmakedefine HAVE_SYS_EPOLL_H</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-/* Define to 1 if you have the &lt=
;sys/file=2Eh&gt; header file=2E */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#undef HAVE_SYS_FILE_H</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span> /* Define to 1 if you have the &lt;sys/ino=
tify=2Eh&gt; header file=2E */</span><br><span> #cmakedefine HAVE_SYS_INOTI=
FY_H</span><br><span> </span><br><span>diff --git a/configure=2Eac b/config=
ure=2Eac</span><br><span>index 5f18798=2E=2E9326c4e 100644</span><br><span>=
--- a/configure=2Eac</span><br><span>+++ b/configure=2Eac</span><br><span>@=
@ -453,7 +453,7 @@</span><br><span> ])</span><br><span> AC_CHECK_HEADERS([ =
\</span><br><span> 	sys/time=2Eh sys/ioctl=2Eh sys/stat=2Eh \</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-	sys/mman=2Eh sys/file=2Eh sys/wait=
=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	sys/mman=2Eh=
 sys/wait=2Eh \</span><br><span> 	libgen=2Eh stropts=2Eh \</span><br><span>=
 	syslog=2Eh pwd=2Eh grp=2Eh \</span><br><span> 	sys/sockio=2Eh sys/uio=2Eh=
 \</span><br><span>@@ -561,8 +561,7 @@</span><br><span> AC_CHECK_FUNCS([ \<=
/span><br><span> 	daemon chroot getpwnam setuid nice dup dup2 \</span><br><=
span> 	syslog openlog mlockall getrlimit getgrnam setgid \</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	setgroups flock gettimeofday \</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-	setsid chdir \</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+	setgroups gettimeofday setsid c=
hdir \</span><br><span> 	chsize ftruncate execve getpeereid basename dirnam=
e \</span><br><span> 	epoll_create strlcpy strsep strtok_r \</span><br><spa=
n> ])</span><br><span>diff --git a/doc/man-sections/link-options=2Erst b/do=
c/man-sections/link-options=2Erst</span><br><span>index 735ee51=2E=2Ebbdcf7=
f 100644</span><br><span>--- a/doc/man-sections/link-options=2Erst</span><b=
r><span>+++ b/doc/man-sections/link-options=2Erst</span><br><span>@@ -440,1=
9 +440,6 @@</span><br><span>   physical IP layer=2E The problem is easily f=
ixed by simply using TCP as</span><br><span>   the VPN transport layer=2E</=
span><br><span> </span><br><span>---replay-persist file</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  Persist replay-protection state across =
sessions using ``file`` to save</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-  and reload the state=2E</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  This =
option will keep a disk copy of the current replay protection state</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  (i=2Ee=2E the most recent p=
acket timestamp and sequence number received from</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-  the remote peer), so that if an OpenVPN sessi=
on is stopped and</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  re=
started, it will reject any replays of packets which were already</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-  received by the prior session=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  This option only makes sense when rep=
lay protection is enabled (the</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-  default) and you are using TLS mode with ``--tls-auth``=2E</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> --session=
-timeout n</span><br><span>   Raises :code:`SIGTERM` for the client instanc=
e after ``n`` seconds since</span><br><span>   the beginning of the session=
, forcing OpenVPN to disconnect=2E</span><br><span>diff --git a/doc/man-sec=
tions/tls-options=2Erst b/doc/man-sections/tls-options=2Erst</span><br><spa=
n>index c4aa810=2E=2Ede4d324 100644</span><br><span>--- a/doc/man-sections/=
tls-options=2Erst</span><br><span>+++ b/doc/man-sections/tls-options=2Erst<=
/span><br><span>@@ -370,10 +370,7 @@</span><br><span>   level has had a cha=
nce to authenticate the peer=2E The result is that</span><br><span>   packe=
ts without the correct signature can be dropped immediately upon</span><br>=
<span>   reception, before they have a chance to consume additional system<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-  resources such as by=
 initiating a TLS handshake=2E ``--tls-auth`` can be</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  strengthened by adding the ``--replay-per=
sist`` option which will keep</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  OpenVPN&#39;s replay protection state in a file so that it is not=
 lost</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  across restart=
s=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  resources suc=
h as by initiating a TLS handshake=2E</span><br><span> </span><br><span>   =
It should be emphasized that this feature is optional and that the key</spa=
n><br><span>   file used with ``--tls-auth`` gives a peer nothing more than=
 the power</span><br><span>diff --git a/doc/man-sections/unsupported-option=
s=2Erst b/doc/man-sections/unsupported-options=2Erst</span><br><span>index =
2794f12=2E=2E368805e 100644</span><br><span>--- a/doc/man-sections/unsuppor=
ted-options=2Erst</span><br><span>+++ b/doc/man-sections/unsupported-option=
s=2Erst</span><br><span>@@ -79,3 +79,8 @@</span><br><span> </span><br><span=
> --allow-deprecated-insecure-static-crypto</span><br><span>   Removed in O=
penVPN 2=2E8 as --secret was also removed=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+--replay-persist</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  Removed in OpenVPN 2=2E8=2E This option never really worked well with =
``--server``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  and t=
he usefulness of this option in p2p setups is not very high either=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  It is now ignored if pr=
esent in the configuration file=2E</span><br><span>diff --git a/src/openvpn=
/check_file_access=2Ec b/src/openvpn/check_file_access=2Ec</span><br><span>=
index 90dbb4e=2E=2E09635cb 100644</span><br><span>--- a/src/openvpn/check_f=
ile_access=2Ec</span><br><span>+++ b/src/openvpn/check_file_access=2Ec</spa=
n><br><span>@@ -312,9 +312,6 @@</span><br><span>                           =
               ce-&gt;tls_crypt_v2_file, R_OK, &quot;--tls-crypt-v2&quot;);=
</span><br><span>     }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC=
_FILEXSTWR, options-&gt;packet_id_file,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                              R_OK | W_OK, &quot;--replay=
-persist&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span>     /* ** Password files ** */</span><br><span>     errs |=3D =
check_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,</span><b=
r><span>                               options-&gt;key_pass_file, R_OK, &qu=
ot;--askpass&quot;);</span><br><span>diff --git a/src/openvpn/crypto=2Ec b/=
src/openvpn/crypto=2Ec</span><br><span>index d375273=2E=2E9b8c7aaa 100644</=
span><br><span>--- a/src/openvpn/crypto=2Ec</span><br><span>+++ b/src/openv=
pn/crypto=2Ec</span><br><span>@@ -403,10 +403,6 @@</span><br><span>     if =
(packet_id_test(recv, pin))</span><br><span>     {</span><br><span>        =
 packet_id_add(recv, pin);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (opt-&gt;pid_persist &amp;&amp; (opt-&gt;flags &amp; CO_PAC=
KET_ID_LONG_FORM))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            pac=
ket_id_persist_save_obj(opt-&gt;pid_persist, &amp;opt-&gt;packet_id);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span> =
        ret =3D true;</span><br><span>     }</span><br><span>     else</spa=
n><br><span>diff --git a/src/openvpn/crypto=2Eh b/src/openvpn/crypto=2Eh</s=
pan><br><span>index 203f77b=2E=2E4962835 100644</span><br><span>--- a/src/o=
penvpn/crypto=2Eh</span><br><span>+++ b/src/openvpn/crypto=2Eh</span><br><s=
pan>@@ -339,11 +339,6 @@</span><br><span>                                  =
*   The packet id also used as the IV</span><br><span>                     =
             *   for AEAD/OFB/CFG ciphers=2E</span><br><span>              =
                    */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    struct packet_id_persist *pid_persist;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    /**&lt; Persistent packet ID state for</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-     *   keeping state between s=
uccessive</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     *   Ope=
nVPN process startups=2E */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span> #define CO_PACKET_ID_LONG_FORM         (1u &lt;&lt;=
 0)</span><br><span>     /**&lt; Bit-flag indicating whether to use</span><=
br><span>      *   OpenVPN&#39;s long packet ID format=2E */</span><br><spa=
n>diff --git a/src/openvpn/errlevel=2Eh b/src/openvpn/errlevel=2Eh</span><b=
r><span>index d79efbb=2E=2E60d20ad 100644</span><br><span>--- a/src/openvpn=
/errlevel=2Eh</span><br><span>+++ b/src/openvpn/errlevel=2Eh</span><br><spa=
n>@@ -64,7 +64,6 @@</span><br><span> #define D_MULTI_ERRORS   LOGLEV(1, 9, =
M_NONFATAL)   /* show multi-client server errors */</span><br><span> #defin=
e D_EVENT_ERRORS   LOGLEV(1, 10, M_NONFATAL)  /* show event=2E[ch] errors *=
/</span><br><span> #define D_PUSH_ERRORS    LOGLEV(1, 11, M_NONFATAL)  /* s=
how push/pull errors */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define D_PID_PERSIST    LOGLEV(1, 12, M_NONFATAL)  /* show packet_id per=
sist errors */</span><br><span> #define D_FRAG_ERRORS    LOGLEV(1, 13, M_NO=
NFATAL)  /* show fragmentation errors */</span><br><span> #define D_ALIGN_E=
RRORS   LOGLEV(1, 14, M_NONFATAL)  /* show bad struct alignments */</span><=
br><span> </span><br><span>@@ -161,16 +160,15 @@</span><br><span> #define D=
_EVENT_WAIT        LOGLEV(8, 70, M_DEBUG)      /* show detailed info from e=
vent waits */</span><br><span> #define D_MULTI_TCP         LOGLEV(8, 70, M_=
DEBUG)      /* show debug info from mtcp=2Ec */</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#define D_TLS_DEBUG         LOG=
LEV(9, 70, M_DEBUG)      /* show detailed info from TLS routines */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_COMP              L=
OGLEV(9, 70, M_DEBUG)      /* show compression info */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#define D_READ_WRITE        LOGLEV(9, 70, =
M_DEBUG)      /* show all tun/tcp/udp reads/writes/opens */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define D_PACKET_CONTENT    LOGLEV(9,=
 70, M_DEBUG)      /* show before/after encryption packet content */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_TLS_NO_SEND_KEY   =
LOGLEV(9, 70, M_DEBUG)      /* show when no data channel send-key exists */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_PID_PERSIST=
_DEBUG LOGLEV(9, 70, M_DEBUG)      /* show packet-id persist debugging info=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_LINK_RW_=
VERBOSE   LOGLEV(9, 70, M_DEBUG)      /* increase link reads/writes verbosi=
ty */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_STREAM=
_DEBUG      LOGLEV(9, 70, M_DEBUG)      /* show TCP stream debug info */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_WIN32_IO      =
    LOGLEV(9, 70, M_DEBUG)      /* win32 I/O debugging info */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#define D_PKCS11_DEBUG      LOGLEV=
(9, 70, M_DEBUG)      /* show PKCS#11 debugging */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define D_TLS_DEBUG       LOGLEV(9, 70, M_DE=
BUG)        /* show detailed info from TLS routines */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define D_COMP            LOGLEV(9, 70, =
M_DEBUG)        /* show compression info */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define D_READ_WRITE      LOGLEV(9, 70, M_DEBUG)   =
     /* show all tun/tcp/udp reads/writes/opens */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define D_PACKET_CONTENT  LOGLEV(9, 70, M_DE=
BUG)        /* show before/after encryption packet content */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define D_TLS_NO_SEND_KEY LOGLEV(=
9, 70, M_DEBUG)        /* show when no data channel send-key exists */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_LINK_RW_VERBOS=
E LOGLEV(9, 70, M_DEBUG)        /* increase link reads/writes verbosity */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_STREAM_DEB=
UG    LOGLEV(9, 70, M_DEBUG)        /* show TCP stream debug info */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_WIN32_IO        =
LOGLEV(9, 70, M_DEBUG)        /* win32 I/O debugging info */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define D_PKCS11_DEBUG    LOGLEV(9=
, 70, M_DEBUG)        /* show PKCS#11 debugging */</span><br><span> </span>=
<br><span> #define D_SHAPER_DEBUG LOGLEV(10, 70, M_DEBUG)          /* show =
traffic shaper info */</span><br><span> </span><br><span>diff --git a/src/o=
penvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index 681210d=
=2E=2E0db0584 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><b=
r><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -744,14 +744,6 @@<=
/span><br><span> static void</span><br><span> process_coarse_timers(struct =
context *c)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    /* flush current packet-id to file once per 60</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-     * seconds if --replay-persist wa=
s specified */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(packet_id_persist_enabled(&amp;c-&gt;c1=2Epid_persist)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; event_timeout_trigger(=
&amp;c-&gt;c2=2Epacket_id_persist_interval, &amp;c-&gt;c2=2Etimeval, ETT_DE=
FAULT))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        packet_id_persist_save=
(&amp;c-&gt;c1=2Epid_persist);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span>     /* Should we write timer-triggered status file */</span><br>=
<span>     if (c-&gt;c1=2Estatus_output</span><br><span>         &amp;&amp;=
 event_timeout_trigger(&amp;c-&gt;c1=2Estatus_output-&gt;et, &amp;c-&gt;c2=
=2Etimeval, ETT_DEFAULT))</span><br><span>diff --git a/src/openvpn/init=2Ec=
 b/src/openvpn/init=2Ec</span><br><span>index ff00151=2E=2E525df7e 100644</=
span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn=
/init=2Ec</span><br><span>@@ -66,7 +66,6 @@</span><br><span> /*</span><br><=
span>  * Crypto initialization flags</span><br><span>  */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#define CF_LOAD_PERSISTED_PACKET_ID (1 =
&lt;&lt; 0)</span><br><span> #define CF_INIT_TLS_MULTI           (1 &lt;&lt=
; 1)</span><br><span> #define CF_INIT_TLS_AUTH_STANDALONE (1 &lt;&lt; 2)</s=
pan><br><span> </span><br><span>@@ -741,8 +740,6 @@</span><br><span> {</spa=
n><br><span>     context_clear_1(c);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    packet_id_persist_init(&amp;c-&gt;c1=
=2Epid_persist);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span>     init_connection_list(c);</span><br><span> </span><br><span=
>     c-&gt;c1=2Elink_sockets_num =3D c-&gt;options=2Ece=2Elocal_list-&gt;l=
en;</span><br><span>@@ -1350,12 +1347,6 @@</span><br><span>                =
                now);</span><br><span>         }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        /* initialize packet_i=
d persistence timer */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        if (c-&gt;options=2Epacket_id_file)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            event_timeout_init(&amp;c-&gt;c2=2Epacket_id_persist=
_interval, 60, now);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan>         /* initialize tmp_int optimization that limits the number of t=
imes we call</span><br><span>          * tls_multi_process in the main even=
t loop */</span><br><span>         interval_init(&amp;c-&gt;c2=2Etmp_int, T=
LS_MULTI_HORIZON, TLS_MULTI_REFRESH);</span><br><span>@@ -2955,31 +2946,15 =
@@</span><br><span> }</span><br><span> </span><br><span> static void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-init_crypto_pre(struct conte=
xt *c, const unsigned int flags)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (c=
-&gt;options=2Eengine)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        crypto_=
init_lib_engine(c-&gt;options=2Eengine);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (flags &amp=
; CF_LOAD_PERSISTED_PACKET_ID)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 /* load a persisted packet-id for cross-session replay-protection */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (c-&gt;options=
=2Epacket_id_file)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            pac=
ket_id_persist_load(&amp;c-&gt;c1=2Epid_persist, c-&gt;options=2Epacket_id_=
file);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span> d=
o_init_crypto_test(struct context *c)</span><br><span> {</span><br><span>  =
   const struct options *options =3D &amp;c-&gt;options;</span><br><span>  =
   ASSERT(options-&gt;test_crypto);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    init_crypto_pre(c, 0);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;options=2Eengine)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        crypto_init_lib_engine(c-&gt;o=
ptions=2Eengine);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span> </span><br><span>     c-&gt;c2=2Ecrypto_options=2Eflag=
s |=3D CO_PACKET_ID_LONG_FORM;</span><br><span> </span><br><span>@@ -3180,7=
 +3155,10 @@</span><br><span>     ASSERT(options-&gt;tls_server || options-=
&gt;tls_client);</span><br><span>     ASSERT(!options-&gt;test_crypto);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ini=
t_crypto_pre(c, flags);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (c-&gt;options=2Eengine)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        crypto_init_lib_engine(c-&gt;options=2Eengine);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><sp=
an>     /* Make sure we are either a TLS client or server but not both */</=
span><br><span>     ASSERT(options-&gt;tls_server =3D=3D !options-&gt;tls_c=
lient);</span><br><span>@@ -3358,7 +3336,6 @@</span><br><span>     if (to=
=2Etls_wrap=2Emode =3D=3D TLS_WRAP_AUTH || to=2Etls_wrap=2Emode =3D=3D TLS_=
WRAP_CRYPT)</span><br><span>     {</span><br><span>         to=2Etls_wrap=
=2Eopt=2Ekey_ctx_bi =3D c-&gt;c1=2Eks=2Etls_wrap_key;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        to=2Etls_wrap=2Eopt=2Epid_persist =
=3D &amp;c-&gt;c1=2Epid_persist;</span><br><span>         to=2Etls_wrap=2Eo=
pt=2Eflags |=3D CO_PACKET_ID_LONG_FORM;</span><br><span>         to=2Etls_w=
rap=2Eoriginal_wrap_keydata =3D c-&gt;c1=2Eks=2Eoriginal_wrap_keydata;</spa=
n><br><span>     }</span><br><span>@@ -3917,11 +3894,6 @@</span><br><span> =
do_close_packet_id(struct context *c)</span><br><span> {</span><br><span>  =
   packet_id_free(&amp;c-&gt;c2=2Ecrypto_options=2Epacket_id);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    packet_id_persist_save(&amp;c-=
&gt;c1=2Epid_persist);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (!(c-&gt;sig-&gt;signal_received =3D=3D SIGUSR1))</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        packet_id_persist_close(&amp;c-&gt;c1=2Epid_per=
sist);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span> }</span><br><span> </span><br><span> #ifdef ENABLE_FRAGMENT</span><=
br><span>@@ -4457,7 +4429,7 @@</span><br><span>         }</span><br><span> =
        else if (c-&gt;mode =3D=3D CM_P2P)</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            crypto_flags =
=3D CF_LOAD_PERSISTED_PACKET_ID | CF_INIT_TLS_MULTI;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            crypto_flags =3D CF_INIT_TLS_=
MULTI;</span><br><span>         }</span><br><span>         else if (child)<=
/span><br><span>         {</span><br><span>@@ -4715,7 +4687,6 @@</span><br>=
<span>     ALLOC_OBJ_CLEAR_GC(dest-&gt;sig, struct signal_info, &amp;dest-&=
gt;gc);</span><br><span> </span><br><span>     /* c1 init */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    packet_id_persist_init(&amp;dest=
-&gt;c1=2Epid_persist);</span><br><span>     dest-&gt;c1=2Elink_sockets_num=
 =3D 1;</span><br><span>     do_link_socket_addr_new(dest);</span><br><span=
> </span><br><span>diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/openv=
pn=2Eh</span><br><span>index cdd02b6=2E=2E52f298b 100644</span><br><span>--=
- a/src/openvpn/openvpn=2Eh</span><br><span>+++ b/src/openvpn/openvpn=2Eh</=
span><br><span>@@ -75,21 +75,6 @@</span><br><span> };</span><br><span> </sp=
an><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * st=
ruct packet_id_persist should be empty if we are not</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * building with crypto=2E</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#ifndef PACKET_ID_H</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-struct packet_id_persist</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    int dummy;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline void</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-packet_id_persist_init(struct=
 packet_id_persist *p)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
/*</span><br><span>  * Packet processing buffers=2E</span><br><span>  */</s=
pan><br><span> struct context_buffers</span><br><span>@@ -167,9 +152,6 @@</=
span><br><span>     /* preresolved and cached host names */</span><br><span=
>     struct cached_dns_entry *dns_cache;</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    /* persist crypto sequence number=
 to/from file */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
truct packet_id_persist pid_persist;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span>     struct tuntap *tuntap; /**&lt; Tun/tap=
 virtual network interface=2E */</span><br><span>     bool tuntap_owned;   =
  /**&lt; Whether the tun/tap interface should</span><br><span>            =
                 *   be cleaned up when this %context is</span><br><span>@@=
 -352,8 +334,6 @@</span><br><span>      *   Channel Crypto module\endlink t=
o</span><br><span>      *   process data channel packet=2E */</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct event_=
timeout packet_id_persist_interval;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span> #ifdef USE_COMP</span><br><span>     struct=
 compress_context *comp_context;</span><br><span>     /**&lt; Compression c=
ontext used by the</span><br><span>diff --git a/src/openvpn/options=2Ec b/s=
rc/openvpn/options=2Ec</span><br><span>index a3c7601=2E=2E7032637 100644</s=
pan><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openv=
pn/options=2Ec</span><br><span>@@ -573,8 +573,6 @@</span><br><span>     &qu=
ot;--replay-window n [t]  : Use a replay protection sliding window of size =
n\n&quot;</span><br><span>     &quot;                         and a time wi=
ndow of t seconds=2E\n&quot;</span><br><span>     &quot;                   =
      Default n=3D%d t=3D%d\n&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    &quot;--replay-persist file : Persist replay-protection s=
tate across sessions\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    &quot;                  using file=2E\n&quot;</span><br><span>  =
   &quot;--test-crypto   : Run a self-test of crypto features enabled=2E\n&=
quot;</span><br><span>     &quot;                  For debugging only=2E\n&=
quot;</span><br><span>     &quot;\n&quot;</span><br><span>@@ -7047,7 +7045,=
7 @@</span><br><span>     else if (streq(p[0], &quot;replay-persist&quot;) =
&amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>  =
       VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        options-&gt;packet_id_file =3D p[1];</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;DEPRE=
CATED OPTION: --replay-persist option ignored=2E&quot;);</span><br><span>  =
   }</span><br><span>     else if (streq(p[0], &quot;test-crypto&quot;) &am=
p;&amp; !p[1])</span><br><span>     {</span><br><span>diff --git a/src/open=
vpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index 129267f=2E=
=2Edd8b75a 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><=
span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -582,7 +582,6 @@</spa=
n><br><span>     bool mute_replay_warnings;</span><br><span>     int replay=
_window;</span><br><span>     int replay_time;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    const char *packet_id_file;</span><br><span>  =
   bool test_crypto;</span><br><span> </span><br><span>     /* TLS (control=
 channel) parms */</span><br><span>diff --git a/src/openvpn/options_show=2E=
c b/src/openvpn/options_show=2Ec</span><br><span>index 321a37b=2E=2E54f9c4c=
 100644</span><br><span>--- a/src/openvpn/options_show=2Ec</span><br><span>=
+++ b/src/openvpn/options_show=2Ec</span><br><span>@@ -501,7 +501,6 @@</spa=
n><br><span>     SHOW_BOOL(mute_replay_warnings);</span><br><span>     SHOW=
_INT(replay_window);</span><br><span>     SHOW_INT(replay_time);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(packet_id_file);</s=
pan><br><span>     SHOW_BOOL(test_crypto);</span><br><span> </span><br><spa=
n>     SHOW_BOOL(tls_server);</span><br><span>diff --git a/src/openvpn/pack=
et_id=2Ec b/src/openvpn/packet_id=2Ec</span><br><span>index 9dd6ce3=2E=2Ef1=
fadd6 100644</span><br><span>--- a/src/openvpn/packet_id=2Ec</span><br><spa=
n>+++ b/src/openvpn/packet_id=2Ec</span><br><span>@@ -426,146 +426,6 @@</sp=
an><br><span>     return BSTR(&amp;out);</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* initialize the p=
acket_id_persist structure in a disabled state */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-packet_id_persist_init(struct packet_id_persist *p)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    p-&gt;filename =3D NULL;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    p-&gt;fd =3D -1;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    p-&gt;time =3D p-&gt;time_last_written =3D 0=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    p-&gt;id =3D p-&=
gt;id_last_written =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-/* close the file descriptor if it is=
 open, and switch to disabled state */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
packet_id_persist_close(struct packet_id_persist *p)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (packet_id_persist_enabled(p))</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if (close(p-&gt;fd))</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            msg(D_PID_PERSIST | M_ERRNO, &quot;Close error on --repl=
ay-persist file %s&quot;, p-&gt;filename);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        packet_id_persist_init(p);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-/* load persisted rec packet_id (ti=
me and id) only once from file, and set state to enabled */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-packet_id_persist_load(struct packet_id_persist *p, co=
nst char *filename)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc=
 =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(!packet_id_persist_enabled(p))</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  /* open packet-id persist file for both read and write */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        p-&gt;fd =3D platform_open(fi=
lename, O_CREAT | O_RDWR | O_BINARY, S_IRUSR | S_IWUSR);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (p-&gt;fd =3D=3D -1)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            msg(D_PID_PERSIST | M_ERRNO, &=
quot;Cannot open --replay-persist file %s for read/write&quot;,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                filename);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            struct packet_id_persist_file_image image;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            ssize_t n;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#if defined(HAVE_FLOCK) &amp;&amp; defined(LOCK_=
EX) &amp;&amp; defined(LOCK_NB)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            if (flock(p-&gt;fd, LOCK_EX | LOCK_NB))</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                msg(M_ERR, &quot;Cannot obt=
ain exclusive lock on --replay-persist file %s&quot;, filename);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           p-&gt;filename =3D filename;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            n =3D read(p-&gt;fd, &amp;image, sizeof(image=
));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (n =
=3D=3D sizeof(image))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        p-&gt;time =3D p-&gt;time_last_written =3D image=2Etime;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                p-&gt;id =3D p-&=
gt;id_last_written =3D image=2Eid;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                dmsg(D_PID_PERSIST_DEBUG, &quot;PID Persist Re=
ad from %s: %s&quot;, p-&gt;filename,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                     packet_id_persist_print(p, &amp;gc));<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            else if (n =3D=3D =
-1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(D_PID_=
PERSIST | M_ERRNO, &quot;Read error on --replay-persist file %s&quot;, p-&g=
t;filename);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* save p=
ersisted rec packet_id (time and id) to file (only if enabled state) */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-packet_id_persist_save(struct packet_id_pe=
rsist *p)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (packet_id_persist_enable=
d(p) &amp;&amp; p-&gt;time</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        &amp;&amp; (p-&gt;time !=3D p-&gt;time_last_written || p-&gt;i=
d !=3D p-&gt;id_last_written))</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 struct packet_id_persist_file_image image;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        CLEAR(image);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        off_t seek_ret;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        struct gc_arena gc =3D gc_new();</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        image=2Etime =3D p-&gt;time;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        image=2Eid =3D p-&gt;id;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        seek_ret =3D lseek(=
p-&gt;fd, (off_t)0, SEEK_SET);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        if (seek_ret =3D=3D (off_t)0)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            const ssize_t n =3D write(p-&gt;fd, &amp;image, si=
zeof(image));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    if (n =3D=3D sizeof(image))</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                p-&gt;time_last_written =3D p-&gt;time;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                p-&gt;id_last_written =
=3D p-&gt;id;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        dmsg(D_PID_PERSIST_DEBUG, &quot;PID Persist Write to %s: %s&quot;, =
p-&gt;filename,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
               packet_id_persist_print(p, &amp;gc));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            else</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                msg(D_PID_PERSIST | M_ERRNO, &quot;Cannot write =
to --replay-persist file %s&quot;,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                    p-&gt;filename);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        else</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            m=
sg(D_PID_PERSIST | M_ERRNO, &quot;Cannot seek to beginning of --replay-pers=
ist file %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             p-&gt;filename);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-/* transfer packet_id_persist -&gt; packet_id */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-packet_id_persist_load_obj(const struct packet_=
id_persist *p, struct packet_id *pid)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (p &amp;&amp; pid &amp;&amp; packet_id_persist_enabled(p) &amp;&amp; p-&=
gt;time)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        pid-&gt;rec=2Etime =
=3D p-&gt;time;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  pid-&gt;rec=2Eid =3D p-&gt;id;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-const char *</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-packet_id_persist_print(const struct packet_id_persist =
*p, struct gc_arena *gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer=
 out =3D alloc_buf_gc(256, gc);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_pri=
ntf(&amp;out, &quot;[&quot;);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (packe=
t_id_persist_enabled(p))</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_p=
rintf(&amp;out, &quot; #&quot; packet_id_format, (packet_id_print_type)p-&g=
t;id);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (p-&=
gt;time)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&a=
mp;out, &quot; / time =3D (&quot; packet_id_format &quot;) %s&quot;, (packe=
t_id_print_type)p-&gt;time,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                       time_string(p-&gt;time, 0, false, gc));</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  buf_printf(&amp;out, &quot; ]&quot;);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    return (char *)out=2Edata;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span> #ifndef ENABLE_SMALL</span><br><span> </span><br><=
span> static void</span><br><span>diff --git a/src/openvpn/packet_id=2Eh b/=
src/openvpn/packet_id=2Eh</span><br><span>index 48752d3=2E=2Ec374ccb 100644=
</span><br><span>--- a/src/openvpn/packet_id=2Eh</span><br><span>+++ b/src/=
openvpn/packet_id=2Eh</span><br><span>@@ -125,26 +125,6 @@</span><br><span>=
 };</span><br><span> </span><br><span> /*</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * file to facilitate cross-session persistence</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * of time/id</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-struct packet_id_persist</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    const char *filename;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    int fd;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 time_t time;       /* time stamp */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    packet_id_type id; /* sequence number */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    time_t time_last_written;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    packet_id_type id_last_wr=
itten;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-struct packet_id_persist_file_image</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    time_t time;       /* time stamp */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    packet_id_type id; /* sequence number *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-/*</span><br><span>  * Keep a record of our current packet-i=
d state</span><br><span>  * on the sending side=2E</span><br><span>  */</sp=
an><br><span>@@ -222,28 +202,6 @@</span><br><span> void packet_id_reap(stru=
ct packet_id_rec *p);</span><br><span> </span><br><span> /*</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * packet ID persistence</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-/* initialize the packet_id_persist structure in a disabled state */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-void packet_id_persist_ini=
t(struct packet_id_persist *p);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* close th=
e file descriptor if it is open, and switch to disabled state */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-void packet_id_persist_close(str=
uct packet_id_persist *p);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* load persiste=
d rec packet_id (time and id) only once from file, and set state to enabled=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void packet_id_per=
sist_load(struct packet_id_persist *p, const char *filename);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-/* save persisted rec packet_id (time and id) to file (o=
nly if enabled state) */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-void packet_id_persist_save(struct packet_id_persist *p);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-/* transfer packet_id_persist -&gt; packet_id */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-void packet_id_persist_load_ob=
j(const struct packet_id_persist *p, struct packet_id *pid);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-/* return an ascii string representing a packet_id_persis=
t object */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-const char=
 *packet_id_persist_print(const struct packet_id_persist *p, struct gc_aren=
a *gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span>  * Read/write a=
 packet ID to/from the buffer=2E  Short form is sequence number</span><br><=
span>  * only=2E  Long form is sequence number and timestamp=2E</span><br><=
span>  */</span><br><span>@@ -273,27 +231,6 @@</span><br><span>     return =
pid-&gt;rec=2Einitialized;</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-/* are we in enabled state? */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline bool</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-packet_id_persist_enabled(c=
onst struct packet_id_persist *p)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retu=
rn p-&gt;fd &gt;=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-/* transfer packet_id -&gt; packet_id_pe=
rsist</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   Note: Only su=
pported for non-epoch format (i=2Ee=2E 32bit ID, not 64bit format),</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-   must be enforced at the ca=
ller=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-static inline void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-packet_id_persist_save_obj(struct p=
acket_id_persist *p, const struct packet_id *pid)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (packet_id_persist_enabled(p) &amp;&amp; pid-&gt;rec=2Etime =
&amp;&amp; pid-&gt;rec=2Eid &lt;=3D PACKET_ID_MAX)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        p-&gt;time =3D pid-&gt;rec=2Etime;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        p-&gt;id =3D (packet_id_type)pid-=
&gt;rec=2Eid;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><span>  * R=
eset the current send packet id to its initial state=2E</span><br><span>  *=
 Use very carefully (e=2Eg=2E in the standalone reset packet context) to</s=
pan><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span>=
<br><span>index 55043e5=2E=2E67df7c2 100644</span><br><span>--- a/src/openv=
pn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -87=
8,8 +878,6 @@</span><br><span>     packet_id_init(&amp;ks-&gt;crypto_option=
s=2Epacket_id, session-&gt;opt-&gt;replay_window,</span><br><span>         =
           session-&gt;opt-&gt;replay_time, &quot;SSL&quot;, ks-&gt;key_id)=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  ks-&gt;crypto_options=2Epid_persist =3D NULL;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span> #ifdef ENABLE_MANAGEMENT</span>=
<br><span>     ks-&gt;mda_key_id =3D session-&gt;opt-&gt;mda_context-&gt;md=
a_key_id_counter++;</span><br><span> #endif</span><br><span>@@ -1037,9 +103=
5,6 @@</span><br><span>         session-&gt;tls_wrap=2Eopt=2Epacket_id=2Ese=
nd=2Eid =3D EARLY_NEG_START;</span><br><span>     }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* load most recent pac=
ket-id to replay protect on --tls-auth */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    packet_id_persist_load_obj(session-&gt;tls_wrap=2Eo=
pt=2Epid_persist, &amp;session-&gt;tls_wrap=2Eopt=2Epacket_id);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     key_state_i=
nit(session, &amp;session-&gt;key[KS_PRIMARY]);</span><br><span> </span><br=
><span>     dmsg(D_TLS_DEBUG, &quot;TLS: tls_session_init: new session obje=
ct, sid=3D%s&quot;,</span><br><span>diff --git a/src/openvpn/syshead=2Eh b/=
src/openvpn/syshead=2Eh</span><br><span>index 1d6cdc2=2E=2E65baee3 100644</=
span><br><span>--- a/src/openvpn/syshead=2Eh</span><br><span>+++ b/src/open=
vpn/syshead=2Eh</span><br><span>@@ -127,10 +127,6 @@</span><br><span> #incl=
ude &lt;fcntl=2Eh&gt;</span><br><span> #endif</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_SYS_FILE_H</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;sys/file=2Eh&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* These headers belo=
ng to C99 and should be always be present */</span><br><span> #include &lt;=
stdlib=2Eh&gt;</span><br><span> #include &lt;inttypes=2Eh&gt;</span><br><sp=
an>diff --git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec</span=
><br><span>index 23c7975=2E=2Ee7fb865 100644</span><br><span>--- a/src/open=
vpn/tls_crypt=2Ec</span><br><span>+++ b/src/openvpn/tls_crypt=2Ec</span><br=
><span>@@ -109,7 +109,6 @@</span><br><span>     session-&gt;tls_wrap_reneg=
=2Emode =3D TLS_WRAP_CRYPT;</span><br><span>     session-&gt;tls_wrap_reneg=
=2Ecleanup_key_ctx =3D true;</span><br><span>     session-&gt;tls_wrap_rene=
g=2Ework =3D alloc_buf(BUF_SIZE(&amp;session-&gt;opt-&gt;frame));</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    session-&gt;tls_wrap_reneg=
=2Eopt=2Epid_persist =3D NULL;</span><br><span> </span><br><span>     packe=
t_id_init(&amp;session-&gt;tls_wrap_reneg=2Eopt=2Epacket_id, session-&gt;op=
t-&gt;replay_window,</span><br><span>                    session-&gt;opt-&g=
t;replay_time, &quot;TLS_WRAP_RENEG&quot;, session-&gt;key_id);</span><br><=
/pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2082?usp=3Demail">change 2082</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2082?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2082 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ge=
rt Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Gert Doe=
ring &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

<=
/body></html>
--+8MMANUaWe0=--


--===============8103612374127496354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8103612374127496354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8103612374127496354==--

