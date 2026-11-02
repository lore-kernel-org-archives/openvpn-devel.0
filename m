Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0586072C44
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SJjPoOCD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hoqH0J/E;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RKUcXxOI;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=D1zhs77h
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=m00B8RikqXT87zNCzfzmg7gs+KbZJgw4Pwj5b6r9fzw=; b=SJjPoOCD4LB5hY9J25iXbJNAwq
	CGYYVBmCaogLVCvXjTAhclQWVX3CxgkIgxlIVF5NQNOShiQNQWUZcE99HQeVu8lcRYQnC87QrIH5a
	t2PzqY6rtdoCPuX18tmnhE6cEKfC9o158piy2ndAElSt1SMAe/YqsggsMJSFclUHIAjg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNtcs-000000005Fv-3lgU;
	Mon, 02 Nov 2026 15:07:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNtcr-000000005Fn-164Z
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 15:07:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cQc6Yhyx4jMcDQmk5LsbqrKuHmU065e1MCMHUfbi3u0=; b=hoqH0J/Eap1LRfjoGYNz53tnl/
 Bt7Uym/8Is3Pu2s0RIElJ8TwD64Wzb+RvQ4F+nZqGqgWqo4uQou1Hj5Gkk+u728B4UNOWXQF5Emxw
 3fM3quawGtEwNT3eksnd77OsSmiNC5n5IWW3b5zV/oJ9f46d6CIwTrFuSW8lJz1LRH9A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cQc6Yhyx4jMcDQmk5LsbqrKuHmU065e1MCMHUfbi3u0=; b=RKUcXxOIJo9yvFGyV9TExk2J8f
 /dQs2FNLcI+CqKWDblboeNXsvJPrLMr94RoeO5QBwz+dz+r4tW09D7C5oR/63hVOH2XBNW1vvc5VY
 2j/OW8SntOs5iSRdk9glH9U4jXumZdWOWWrgfNyI9r4WSGnII26RI4b3CMHfxKzOFj4g=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNtci-0000000033n-44tY for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 15:07:09 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so32102245e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 07:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793632014; x=1794236814; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cQc6Yhyx4jMcDQmk5LsbqrKuHmU065e1MCMHUfbi3u0=;
 b=D1zhs77hPY5ZTLbtnMOY1/1RleogGpRFshXz0eXTjkvpz/dmoGkr31HpfdLQbcKGAt
 ujTmz1cn0JuXiTTJ6mXFc6gvmsexW0OvyL71dc0jJdiCLDz2r+1HzT2mgVi8fAskbI9q
 wpF8YPuqvNhASbnZbv+UMzt91OYWWsWL3cM4Xrk3D+dIX8ltaaP+4I9O0vF9DjcnThY7
 7wftFhH84Pn2NaH5rrmb0R++Lt1TLwnr6xvUEkI7kscWOweqy+BbMnWirfZlCN91Prdh
 Q0La6JrjHKs0GhQ7le/mKolXFOSGtclks43jcVKxXhDrijjFCORmaLBGJvsmvbDz1tZK
 FfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793632014; x=1794236814;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cQc6Yhyx4jMcDQmk5LsbqrKuHmU065e1MCMHUfbi3u0=;
 b=U/teDM5sacQgZMqr703IuOptkpI+tNaXVEuyBo6bW0hmvo3Jyn+dcGLqVOke+xi2An
 BWk39zFcl6sbUMnsrKGmW5cO9iQG+vYf+w6UCBoBC7ZusFpH3GUn2YK9WiO/t2gGOB8Z
 ACRQLgpbMsEuzxkEFW6jEUD9xt6MKmO3kJJoFxN7d4cALhu5BffaaQFzORSVOhTQqadC
 NsvDpFHPi412FyfYsKwxIlNsouqX9dq5cr8dt9UjDO/jm2ZixWSuCiL5CGfNRge0T848
 ynPU7MvTziw3VfxguMknhonBIjpPr6CPTJfR2H94LEYCDVCj+OlQBcLtFLvhoD1rHc2T
 HvVg==
X-Gm-Message-State: AFq9FYK2uG8gfUG2ZCvjpHGLCh+p2DKSDyplVEF2JPknUxgCbxzj9mOs
 metErENpJt9/xvd2c/SYhM3f9OOON3inXc+kS3jDFvUj/1D5rGGqHsuhggAeUmBn79QQhmtVwFy
 5b83HJGxDxAZ+Hk2pKgPA6QKvGYOtKtfWNg1v/mORcJIJuZTdC51RvPe2Yj1fyn5129+kNpqr+R
 IoCnQ5BA==
X-Gm-Gg: AYBFou2LVxw052ogl620cWXq/xJKVMIX8J5kmobH9Q097pullpZW49M8RQ7pKhmWvwF
 zdYmRq3UarXOcACS0HDtpg8HBYHNRuOlFdUishdau40M+eD8ZD22y2kegwMWeH1CKmxx7Y16G1T
 x5Ip9caKrTUBPuwuXwDbHjHlRD8jGPqQrKYXq5rMkrVwPLxnF8rYUW22i0vtq6s1H1jXqbXPXlM
 xbhVaZuL2z+E9KGS4zyaMc0Q4NYxZOeHbwI/7aLc/b3DM7AxrYdmxpgJZAdJF3RxKVDG/+vy4PT
 qdxUFfYYeEJvMJKlRZOSD1zss2X6oaD6Y1EGLdcRRpeCjwjKrWP8M4pbC7d4l8XHKpQd/qmtSnd
 vquMmIcUtKbJp9VyVbsHYTTSH75OlhFnkjDH/R8YE9FJlDPoTIuWmD6mOtEZ41Xav4aeYGC1jlm
 FDR5J7f7c8t5TS24qP4oDBKtjNAqXErwOBjEhwuTM5OVPQTRUkk+e4c9JQht7g8OmHWwqJmIcA6
 t0dkoODbYg56vi2iIq8Z94zkrop8cJ6LkS8mwmxHmd1b50o+MLsVeZiCYPq9PTgW+dAnVb1lRh4
 7Pdgb1RJKZg8XJDETAbkj+PG5XyXMwhPHGehOTWXW8fRDIqdcMLkZUhXLeZnjIWAgv5DrvZWUQA
 quthhjhlEDDlGZq82xG6og4kU23KH29+M7Gn5YCMxKJ7FArpZ18pe48I8VFlDP/8OGou0J/9enk
 hKA/TEgpKfU/SvyQ==
X-Received: by 2002:a05:600c:638f:b0:4a2:c2b:a91b with SMTP id
 5b1f17b1804b1-4ac17d168a6mr230066625e9.10.1793632013841; 
 Mon, 02 Nov 2026 07:06:53 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf6e63e0esm356877975e9.12.2026.11.02.07.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 07:06:53 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 15:06:48 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815
X-Gerrit-Change-Number: 2082
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2082?usp=email>
X-Gerrit-Commit: 672bb8080dde7a781ca6000f014c241b6009e283
In-Reply-To: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
References: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkk1ZWUyMzFkMTU3NDU5ZTY0MDZmMWY0YzEyY2Q2YzZlMGZjZTkzODE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bbbde4a244ed04a208b438e46be5b188bb74fe62-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNtci-0000000033n-44tY
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4691084252375488643=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4691084252375488643==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="En5eDscF1XE="; charset=UTF-8

--En5eDscF1XE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru=2E

Hello Frank Lichtenheld, R=C4=83zvan Cojocaru, 

I'd like you to ree=
xamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2082?usp=3Demail

to look at the new patch set (#3)=2E

The following =
approvals got outdated and were removed:
Code-Review-1 by R=C4=83zvan Cojoc=
aru


Change subject: Remove replay-persist
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove replay-persist

This feature is very=
 niche and we do not think it is something we
should maintain and support g=
oing forward=2E

This feature saves a single packet id to persist-replay fi=
le=2E
This makes the feature only properly work in a p2p setup where both
s=
ides use replay-persist to save the last known packet id from the
peer=2E E=
ven then it will only prevent some packet replays until the
legitimate peer=
 sends a packet again=2E

In server mode (p2mp) each client context has its=
 own replay state
and saving a single packet id is also not very useful wit=
h multiple
clients and multiple states=2E

Change-Id: I5ee231d157459e6406f1=
f4c12cd6c6e0fce93815
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M=
 Changes=2Emd
M config=2Eh=2Ecmake=2Ein
M configure=2Eac
M doc/man-sections=
/link-options=2Erst
M doc/man-sections/tls-options=2Erst
M doc/man-sections=
/unsupported-options=2Erst
M src/openvpn/check_file_access=2Ec
M src/openvp=
n/crypto=2Ec
M src/openvpn/crypto=2Eh
M src/openvpn/errlevel=2Eh
M src/open=
vpn/forward=2Ec
M src/openvpn/init=2Ec
M src/openvpn/openvpn=2Eh
M src/open=
vpn/options=2Ec
M src/openvpn/options=2Eh
M src/openvpn/options_show=2Ec
M =
src/openvpn/packet_id=2Ec
M src/openvpn/packet_id=2Eh
M src/openvpn/ssl=2Ec=

M src/openvpn/syshead=2Eh
M src/openvpn/tls_crypt=2Ec
21 files changed, 25=
 insertions(+), 318 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/82/2082/3

diff --git a/Changes=2Emd b/Changes=
=2Emd
index 7f47f77=2E=2E89a72fe 100644
--- a/Changes=2Emd
+++ b/Changes=2E=
md
@@ -30,6 +30,12 @@
   "too complicated", using `--peer-fingerprint` make=
s TLS mode about as easy as
   using `--secret`=2E
 
+* **`replay-persist` =
has been removed**
+
+  This feature has been removed as it was never prope=
rly implemented for
+  server mode and generally was a niche feature=2E If =
the option is present
+  it will be ignored=2E
+
 ## Maintainer-visible cha=
nges
 
 - The configure-time option `--enable-debug` is no longer  availabl=
e
diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein
index 5e06=
a63=2E=2Ef7818cf 100644
--- a/config=2Eh=2Ecmake=2Ein
+++ b/config=2Eh=2Ecm=
ake=2Ein
@@ -285,9 +285,6 @@
 /* Define to 1 if you have the <sys/epoll=2Eh=
> header file=2E */
 #cmakedefine HAVE_SYS_EPOLL_H
 
-/* Define to 1 if you=
 have the <sys/file=2Eh> header file=2E */
-#undef HAVE_SYS_FILE_H
-
 /* De=
fine to 1 if you have the <sys/inotify=2Eh> header file=2E */
 #cmakedefine=
 HAVE_SYS_INOTIFY_H
 
diff --git a/configure=2Eac b/configure=2Eac
index 5f=
18798=2E=2E9326c4e 100644
--- a/configure=2Eac
+++ b/configure=2Eac
@@ -453=
,7 +453,7 @@
 ])
 AC_CHECK_HEADERS([ \
 	sys/time=2Eh sys/ioctl=2Eh sys/sta=
t=2Eh \
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
index 0bb5e4b=2E=2E1b49beb 100644
--- a/doc/m=
an-sections/unsupported-options=2Erst
+++ b/doc/man-sections/unsupported-op=
tions=2Erst
@@ -76,3 +76,8 @@
   (generated by DH or ECDH) has been conside=
red problematic for many
   years=2E Please use ``--peer-fingerprint`` and =
self-signed certificates
   for small setups=2E
+
+--replay-persist
+  Remo=
ved OpenVPN 2=2E8=2E This option never really worked well with ``--server``=

+  and the usefulness of this option in p2p setups is not very high either=
=2E
+  It is now ignored if present in the configuration file=2E
diff --git=
 a/src/openvpn/check_file_access=2Ec b/src/openvpn/check_file_access=2Ec
in=
dex 90dbb4e=2E=2E09635cb 100644
--- a/src/openvpn/check_file_access=2Ec
+++=
 b/src/openvpn/check_file_access=2Ec
@@ -312,9 +312,6 @@
                  =
                        ce->tls_crypt_v2_file, R_OK, "--tls-crypt-v2");
   =
  }
 
-    errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, o=
ptions->packet_id_file,
-                              R_OK | W_OK, "--repl=
ay-persist");
-
     /* ** Password files ** */
     errs |=3D check_file_a=
ccess(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
                    =
           options->key_pass_file, R_OK, "--askpass");
diff --git a/src/ope=
nvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index d375273=2E=2E9b8c7aaa 100644=

--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -403,10 +403,=
6 @@
     if (packet_id_test(recv, pin))
     {
         packet_id_add(recv=
, pin);
-        if (opt->pid_persist && (opt->flags & CO_PACKET_ID_LONG_FO=
RM))
-        {
-            packet_id_persist_save_obj(opt->pid_persist, &=
opt->packet_id);
-        }
         ret =3D true;
     }
     else
diff --=
git a/src/openvpn/crypto=2Eh b/src/openvpn/crypto=2Eh
index 203f77b=2E=2E49=
62835 100644
--- a/src/openvpn/crypto=2Eh
+++ b/src/openvpn/crypto=2Eh
@@ -=
339,11 +339,6 @@
                                  *   The packet id also u=
sed as the IV
                                  *   for AEAD/OFB/CFG cipher=
s=2E
                                  */
-    struct packet_id_persist *pi=
d_persist;
-    /**< Persistent packet ID state for
-     *   keeping state=
 between successive
-     *   OpenVPN process startups=2E */
-
 #define CO_=
PACKET_ID_LONG_FORM         (1u << 0)
     /**< Bit-flag indicating whether=
 to use
      *   OpenVPN's long packet ID format=2E */
diff --git a/src/op=
envpn/errlevel=2Eh b/src/openvpn/errlevel=2Eh
index d79efbb=2E=2E60d20ad 10=
0644
--- a/src/openvpn/errlevel=2Eh
+++ b/src/openvpn/errlevel=2Eh
@@ -64,7=
 +64,6 @@
 #define D_MULTI_ERRORS   LOGLEV(1, 9, M_NONFATAL)   /* show mult=
i-client server errors */
 #define D_EVENT_ERRORS   LOGLEV(1, 10, M_NONFATA=
L)  /* show event=2E[ch] errors */
 #define D_PUSH_ERRORS    LOGLEV(1, 11, =
M_NONFATAL)  /* show push/pull errors */
-#define D_PID_PERSIST    LOGLEV(1=
, 12, M_NONFATAL)  /* show packet_id persist errors */
 #define D_FRAG_ERRO=
RS    LOGLEV(1, 13, M_NONFATAL)  /* show fragmentation errors */
 #define D=
_ALIGN_ERRORS   LOGLEV(1, 14, M_NONFATAL)  /* show bad struct alignments */=

 
@@ -161,16 +160,15 @@
 #define D_EVENT_WAIT        LOGLEV(8, 70, M_DEBUG=
)      /* show detailed info from event waits */
 #define D_MULTI_TCP      =
   LOGLEV(8, 70, M_DEBUG)      /* show debug info from mtcp=2Ec */
 
-#defi=
ne D_TLS_DEBUG         LOGLEV(9, 70, M_DEBUG)      /* show detailed info fr=
om TLS routines */
-#define D_COMP              LOGLEV(9, 70, M_DEBUG)     =
 /* show compression info */
-#define D_READ_WRITE        LOGLEV(9, 70, M_D=
EBUG)      /* show all tun/tcp/udp reads/writes/opens */
-#define D_PACKET_=
CONTENT    LOGLEV(9, 70, M_DEBUG)      /* show before/after encryption pack=
et content */
-#define D_TLS_NO_SEND_KEY   LOGLEV(9, 70, M_DEBUG)      /* s=
how when no data channel send-key exists */
-#define D_PID_PERSIST_DEBUG LO=
GLEV(9, 70, M_DEBUG)      /* show packet-id persist debugging info */
-#def=
ine D_LINK_RW_VERBOSE   LOGLEV(9, 70, M_DEBUG)      /* increase link reads/=
writes verbosity */
-#define D_STREAM_DEBUG      LOGLEV(9, 70, M_DEBUG)    =
  /* show TCP stream debug info */
-#define D_WIN32_IO          LOGLEV(9, 7=
0, M_DEBUG)      /* win32 I/O debugging info */
-#define D_PKCS11_DEBUG    =
  LOGLEV(9, 70, M_DEBUG)      /* show PKCS#11 debugging */
+#define D_TLS_D=
EBUG       LOGLEV(9, 70, M_DEBUG)        /* show detailed info from TLS rou=
tines */
+#define D_COMP            LOGLEV(9, 70, M_DEBUG)        /* show c=
ompression info */
+#define D_READ_WRITE      LOGLEV(9, 70, M_DEBUG)       =
 /* show all tun/tcp/udp reads/writes/opens */
+#define D_PACKET_CONTENT  L=
OGLEV(9, 70, M_DEBUG)        /* show before/after encryption packet content=
 */
+#define D_TLS_NO_SEND_KEY LOGLEV(9, 70, M_DEBUG)        /* show when n=
o data channel send-key exists */
+#define D_LINK_RW_VERBOSE LOGLEV(9, 70, =
M_DEBUG)        /* increase link reads/writes verbosity */
+#define D_STREA=
M_DEBUG    LOGLEV(9, 70, M_DEBUG)        /* show TCP stream debug info */
+=
#define D_WIN32_IO        LOGLEV(9, 70, M_DEBUG)        /* win32 I/O debugg=
ing info */
+#define D_PKCS11_DEBUG    LOGLEV(9, 70, M_DEBUG)        /* sho=
w PKCS#11 debugging */
 
 #define D_SHAPER_DEBUG LOGLEV(10, 70, M_DEBUG)   =
       /* show traffic shaper info */
 
diff --git a/src/openvpn/forward=2E=
c b/src/openvpn/forward=2Ec
index 681210d=2E=2E0db0584 100644
--- a/src/ope=
nvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -744,14 +744,6 @@
 static=
 void
 process_coarse_timers(struct context *c)
 {
-    /* flush current pa=
cket-id to file once per 60
-     * seconds if --replay-persist was specifi=
ed */
-    if (packet_id_persist_enabled(&c->c1=2Epid_persist)
-        && =
event_timeout_trigger(&c->c2=2Epacket_id_persist_interval, &c->c2=2Etimeval=
, ETT_DEFAULT))
-    {
-        packet_id_persist_save(&c->c1=2Epid_persist=
);
-    }
-
     /* Should we write timer-triggered status file */
     if =
(c->c1=2Estatus_output
         && event_timeout_trigger(&c->c1=2Estatus_ou=
tput->et, &c->c2=2Etimeval, ETT_DEFAULT))
diff --git a/src/openvpn/init=2Ec=
 b/src/openvpn/init=2Ec
index 9299c4f=2E=2E8c9098c 100644
--- a/src/openvpn=
/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -66,7 +66,6 @@
 /*
  * Crypto initi=
alization flags
  */
-#define CF_LOAD_PERSISTED_PACKET_ID (1 << 0)
 #define=
 CF_INIT_TLS_MULTI           (1 << 1)
 #define CF_INIT_TLS_AUTH_STANDALONE =
(1 << 2)
 
@@ -737,8 +736,6 @@
 {
     context_clear_1(c);
 
-    packet_id=
_persist_init(&c->c1=2Epid_persist);
-
     init_connection_list(c);
 
    =
 c->c1=2Elink_sockets_num =3D c->options=2Ece=2Elocal_list->len;
@@ -1346,1=
2 +1343,6 @@
                                now);
         }
 
-        /*=
 initialize packet_id persistence timer */
-        if (c->options=2Epacket=
_id_file)
-        {
-            event_timeout_init(&c->c2=2Epacket_id_per=
sist_interval, 60, now);
-        }
-
         /* initialize tmp_int optimi=
zation that limits the number of times we call
          * tls_multi_proces=
s in the main event loop */
         interval_init(&c->c2=2Etmp_int, TLS_MU=
LTI_HORIZON, TLS_MULTI_REFRESH);
@@ -2957,15 +2948,6 @@
     {
         cry=
pto_init_lib_engine(c->options=2Eengine);
     }
-
-    if (flags & CF_LOAD=
_PERSISTED_PACKET_ID)
-    {
-        /* load a persisted packet-id for cro=
ss-session replay-protection */
-        if (c->options=2Epacket_id_file)
-=
        {
-            packet_id_persist_load(&c->c1=2Epid_persist, c->opti=
ons=2Epacket_id_file);
-        }
-    }
 }
 
 
@@ -3354,7 +3336,6 @@
     =
if (to=2Etls_wrap=2Emode =3D=3D TLS_WRAP_AUTH || to=2Etls_wrap=2Emode =3D=
=3D TLS_WRAP_CRYPT)
     {
         to=2Etls_wrap=2Eopt=2Ekey_ctx_bi =3D c-=
>c1=2Eks=2Etls_wrap_key;
-        to=2Etls_wrap=2Eopt=2Epid_persist =3D &c-=
>c1=2Epid_persist;
         to=2Etls_wrap=2Eopt=2Eflags |=3D CO_PACKET_ID_L=
ONG_FORM;
         to=2Etls_wrap=2Eoriginal_wrap_keydata =3D c->c1=2Eks=2Eo=
riginal_wrap_keydata;
     }
@@ -3913,11 +3894,6 @@
 do_close_packet_id(str=
uct context *c)
 {
     packet_id_free(&c->c2=2Ecrypto_options=2Epacket_id)=
;
-    packet_id_persist_save(&c->c1=2Epid_persist);
-    if (!(c->sig->sig=
nal_received =3D=3D SIGUSR1))
-    {
-        packet_id_persist_close(&c->c=
1=2Epid_persist);
-    }
 }
 
 #ifdef ENABLE_FRAGMENT
@@ -4453,7 +4429,7 @@=

         }
         else if (c->mode =3D=3D CM_P2P)
         {
-          =
  crypto_flags =3D CF_LOAD_PERSISTED_PACKET_ID | CF_INIT_TLS_MULTI;
+      =
      crypto_flags =3D CF_INIT_TLS_MULTI;
         }
         else if (chil=
d)
         {
@@ -4711,7 +4687,6 @@
     ALLOC_OBJ_CLEAR_GC(dest->sig, stru=
ct signal_info, &dest->gc);
 
     /* c1 init */
-    packet_id_persist_ini=
t(&dest->c1=2Epid_persist);
     dest->c1=2Elink_sockets_num =3D 1;
     do=
_link_socket_addr_new(dest);
 
diff --git a/src/openvpn/openvpn=2Eh b/src/o=
penvpn/openvpn=2Eh
index cdd02b6=2E=2E52f298b 100644
--- a/src/openvpn/open=
vpn=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -75,21 +75,6 @@
 };
 
 /*
- * stru=
ct packet_id_persist should be empty if we are not
- * building with crypto=
=2E
- */
-#ifndef PACKET_ID_H
-struct packet_id_persist
-{
-    int dummy;
=
-};
-static inline void
-packet_id_persist_init(struct packet_id_persist *p=
)
-{
-}
-#endif
-
-/*
  * Packet processing buffers=2E
  */
 struct context=
_buffers
@@ -167,9 +152,6 @@
     /* preresolved and cached host names */
 =
    struct cached_dns_entry *dns_cache;
 
-    /* persist crypto sequence n=
umber to/from file */
-    struct packet_id_persist pid_persist;
-
     str=
uct tuntap *tuntap; /**< Tun/tap virtual network interface=2E */
     bool =
tuntap_owned;     /**< Whether the tun/tap interface should
               =
              *   be cleaned up when this %context is
@@ -352,8 +334,6 @@
 =
     *   Channel Crypto module\endlink to
      *   process data channel pa=
cket=2E */
 
-    struct event_timeout packet_id_persist_interval;
-
 #ifde=
f USE_COMP
     struct compress_context *comp_context;
     /**< Compressio=
n context used by the
diff --git a/src/openvpn/options=2Ec b/src/openvpn/op=
tions=2Ec
index 4e6c705=2E=2Eebfa8b9 100644
--- a/src/openvpn/options=2Ec
+=
++ b/src/openvpn/options=2Ec
@@ -573,8 +573,6 @@
     "--replay-window n [t=
]  : Use a replay protection sliding window of size n\n"
     "            =
             and a time window of t seconds=2E\n"
     "                   =
      Default n=3D%d t=3D%d\n"
-    "--replay-persist file : Persist replay=
-protection state across sessions\n"
-    "                  using file=2E\=
n"
     "--test-crypto   : Run a self-test of crypto features enabled=2E\n"=

     "                  For debugging only=2E\n"
     "\n"
@@ -7048,7 +704=
6,7 @@
     else if (streq(p[0], "replay-persist") && p[1] && !p[2])
     {=

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->packet_id_fil=
e =3D p[1];
+        msg(M_WARN, "DEPRECATED OPTION: --replay-persist optio=
n ignored=2E");
     }
     else if (streq(p[0], "test-crypto") && !p[1])
 =
    {
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index =
129267f=2E=2Edd8b75a 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn=
/options=2Eh
@@ -582,7 +582,6 @@
     bool mute_replay_warnings;
     int r=
eplay_window;
     int replay_time;
-    const char *packet_id_file;
     b=
ool test_crypto;
 
     /* TLS (control channel) parms */
diff --git a/src/=
openvpn/options_show=2Ec b/src/openvpn/options_show=2Ec
index 321a37b=2E=2E=
54f9c4c 100644
--- a/src/openvpn/options_show=2Ec
+++ b/src/openvpn/options=
_show=2Ec
@@ -501,7 +501,6 @@
     SHOW_BOOL(mute_replay_warnings);
     SH=
OW_INT(replay_window);
     SHOW_INT(replay_time);
-    SHOW_STR(packet_id_=
file);
     SHOW_BOOL(test_crypto);
 
     SHOW_BOOL(tls_server);
diff --gi=
t a/src/openvpn/packet_id=2Ec b/src/openvpn/packet_id=2Ec
index 9dd6ce3=2E=
=2Ef1fadd6 100644
--- a/src/openvpn/packet_id=2Ec
+++ b/src/openvpn/packet_=
id=2Ec
@@ -426,146 +426,6 @@
     return BSTR(&out);
 }
 
-/* initialize th=
e packet_id_persist structure in a disabled state */
-void
-packet_id_persi=
st_init(struct packet_id_persist *p)
-{
-    p->filename =3D NULL;
-    p->=
fd =3D -1;
-    p->time =3D p->time_last_written =3D 0;
-    p->id =3D p->i=
d_last_written =3D 0;
-}
-
-/* close the file descriptor if it is open, and=
 switch to disabled state */
-void
-packet_id_persist_close(struct packet_i=
d_persist *p)
-{
-    if (packet_id_persist_enabled(p))
-    {
-        if =
(close(p->fd))
-        {
-            msg(D_PID_PERSIST | M_ERRNO, "Close =
error on --replay-persist file %s", p->filename);
-        }
-        packe=
t_id_persist_init(p);
-    }
-}
-
-/* load persisted rec packet_id (time an=
d id) only once from file, and set state to enabled */
-void
-packet_id_per=
sist_load(struct packet_id_persist *p, const char *filename)
-{
-    struct=
 gc_arena gc =3D gc_new();
-    if (!packet_id_persist_enabled(p))
-    {
-=
        /* open packet-id persist file for both read and write */
-        =
p->fd =3D platform_open(filename, O_CREAT | O_RDWR | O_BINARY, S_IRUSR | S_=
IWUSR);
-        if (p->fd =3D=3D -1)
-        {
-            msg(D_PID_PER=
SIST | M_ERRNO, "Cannot open --replay-persist file %s for read/write",
-   =
             filename);
-        }
-        else
-        {
-            st=
ruct packet_id_persist_file_image image;
-            ssize_t n;
-
-#if def=
ined(HAVE_FLOCK) && defined(LOCK_EX) && defined(LOCK_NB)
-            if (f=
lock(p->fd, LOCK_EX | LOCK_NB))
-            {
-                msg(M_ERR, =
"Cannot obtain exclusive lock on --replay-persist file %s", filename);
-   =
         }
-#endif
-
-            p->filename =3D filename;
-            n =
=3D read(p->fd, &image, sizeof(image));
-            if (n =3D=3D sizeof(im=
age))
-            {
-                p->time =3D p->time_last_written =3D =
image=2Etime;
-                p->id =3D p->id_last_written =3D image=2Eid;=

-                dmsg(D_PID_PERSIST_DEBUG, "PID Persist Read from %s: %s",=
 p->filename,
-                     packet_id_persist_print(p, &gc));
-    =
        }
-            else if (n =3D=3D -1)
-            {
-              =
  msg(D_PID_PERSIST | M_ERRNO, "Read error on --replay-persist file %s", p-=
>filename);
-            }
-        }
-    }
-    gc_free(&gc);
-}
-
-/* sa=
ve persisted rec packet_id (time and id) to file (only if enabled state) */=

-void
-packet_id_persist_save(struct packet_id_persist *p)
-{
-    if (pac=
ket_id_persist_enabled(p) && p->time
-        && (p->time !=3D p->time_last=
_written || p->id !=3D p->id_last_written))
-    {
-        struct packet_i=
d_persist_file_image image;
-        CLEAR(image);
-        off_t seek_ret;=

-        struct gc_arena gc =3D gc_new();
-
-        image=2Etime =3D p->t=
ime;
-        image=2Eid =3D p->id;
-        seek_ret =3D lseek(p->fd, (off=
_t)0, SEEK_SET);
-        if (seek_ret =3D=3D (off_t)0)
-        {
-       =
     const ssize_t n =3D write(p->fd, &image, sizeof(image));
-            =
if (n =3D=3D sizeof(image))
-            {
-                p->time_last_wr=
itten =3D p->time;
-                p->id_last_written =3D p->id;
-        =
        dmsg(D_PID_PERSIST_DEBUG, "PID Persist Write to %s: %s", p->filenam=
e,
-                     packet_id_persist_print(p, &gc));
-            }
-=
            else
-            {
-                msg(D_PID_PERSIST | M_ERRN=
O, "Cannot write to --replay-persist file %s",
-                    p->file=
name);
-            }
-        }
-        else
-        {
-            msg(=
D_PID_PERSIST | M_ERRNO, "Cannot seek to beginning of --replay-persist file=
 %s",
-                p->filename);
-        }
-        gc_free(&gc);
-   =
 }
-}
-
-/* transfer packet_id_persist -> packet_id */
-void
-packet_id_per=
sist_load_obj(const struct packet_id_persist *p, struct packet_id *pid)
-{
=
-    if (p && pid && packet_id_persist_enabled(p) && p->time)
-    {
-     =
   pid->rec=2Etime =3D p->time;
-        pid->rec=2Eid =3D p->id;
-    }
-}=

-
-const char *
-packet_id_persist_print(const struct packet_id_persist *p=
, struct gc_arena *gc)
-{
-    struct buffer out =3D alloc_buf_gc(256, gc);=

-
-    buf_printf(&out, "[");
-
-    if (packet_id_persist_enabled(p))
-  =
  {
-        buf_printf(&out, " #" packet_id_format, (packet_id_print_type)=
p->id);
-        if (p->time)
-        {
-            buf_printf(&out, " / =
time =3D (" packet_id_format ") %s", (packet_id_print_type)p->time,
-      =
                 time_string(p->time, 0, false, gc));
-        }
-    }
-
-=
    buf_printf(&out, " ]");
-    return (char *)out=2Edata;
-}
-
 #ifndef E=
NABLE_SMALL
 
 static void
diff --git a/src/openvpn/packet_id=2Eh b/src/ope=
nvpn/packet_id=2Eh
index 48752d3=2E=2Ec374ccb 100644
--- a/src/openvpn/pack=
et_id=2Eh
+++ b/src/openvpn/packet_id=2Eh
@@ -125,26 +125,6 @@
 };
 
 /*
- =
* file to facilitate cross-session persistence
- * of time/id
- */
-struct =
packet_id_persist
-{
-    const char *filename;
-    int fd;
-    time_t ti=
me;       /* time stamp */
-    packet_id_type id; /* sequence number */
- =
   time_t time_last_written;
-    packet_id_type id_last_written;
-};
-
-st=
ruct packet_id_persist_file_image
-{
-    time_t time;       /* time stamp =
*/
-    packet_id_type id; /* sequence number */
-};
-
-/*
  * Keep a recor=
d of our current packet-id state
  * on the sending side=2E
  */
@@ -222,28=
 +202,6 @@
 void packet_id_reap(struct packet_id_rec *p);
 
 /*
- * packet =
ID persistence
- */
-
-/* initialize the packet_id_persist structure in a d=
isabled state */
-void packet_id_persist_init(struct packet_id_persist *p);=

-
-/* close the file descriptor if it is open, and switch to disabled stat=
e */
-void packet_id_persist_close(struct packet_id_persist *p);
-
-/* load=
 persisted rec packet_id (time and id) only once from file, and set state t=
o enabled */
-void packet_id_persist_load(struct packet_id_persist *p, cons=
t char *filename);
-
-/* save persisted rec packet_id (time and id) to file=
 (only if enabled state) */
-void packet_id_persist_save(struct packet_id_p=
ersist *p);
-
-/* transfer packet_id_persist -> packet_id */
-void packet_i=
d_persist_load_obj(const struct packet_id_persist *p, struct packet_id *pid=
);
-
-/* return an ascii string representing a packet_id_persist object */
=
-const char *packet_id_persist_print(const struct packet_id_persist *p, str=
uct gc_arena *gc);
-
-/*
  * Read/write a packet ID to/from the buffer=2E  =
Short form is sequence number
  * only=2E  Long form is sequence number and=
 timestamp=2E
  */
@@ -273,27 +231,6 @@
     return pid->rec=2Einitialized;=

 }
 
-/* are we in enabled state? */
-static inline bool
-packet_id_persis=
t_enabled(const struct packet_id_persist *p)
-{
-    return p->fd >=3D 0;
-=
}
-
-/* transfer packet_id -> packet_id_persist
-   Note: Only supported fo=
r non-epoch format (i=2Ee=2E 32bit ID, not 64bit format),
-   must be enfor=
ced at the caller=2E
- */
-static inline void
-packet_id_persist_save_obj(s=
truct packet_id_persist *p, const struct packet_id *pid)
-{
-    if (packet=
_id_persist_enabled(p) && pid->rec=2Etime && pid->rec=2Eid <=3D PACKET_ID_M=
AX)
-    {
-        p->time =3D pid->rec=2Etime;
-        p->id =3D (packet=
_id_type)pid->rec=2Eid;
-    }
-}
-
 /**
  * Reset the current send packet =
id to its initial state=2E
  * Use very carefully (e=2Eg=2E in the standalo=
ne reset packet context) to
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/=
ssl=2Ec
index 55043e5=2E=2E67df7c2 100644
--- a/src/openvpn/ssl=2Ec
+++ b/s=
rc/openvpn/ssl=2Ec
@@ -878,8 +878,6 @@
     packet_id_init(&ks->crypto_opti=
ons=2Epacket_id, session->opt->replay_window,
                    session->=
opt->replay_time, "SSL", ks->key_id);
 
-    ks->crypto_options=2Epid_persi=
st =3D NULL;
-
 #ifdef ENABLE_MANAGEMENT
     ks->mda_key_id =3D session->o=
pt->mda_context->mda_key_id_counter++;
 #endif
@@ -1037,9 +1035,6 @@
      =
   session->tls_wrap=2Eopt=2Epacket_id=2Esend=2Eid =3D EARLY_NEG_START;
   =
  }
 
-    /* load most recent packet-id to replay protect on --tls-auth */=

-    packet_id_persist_load_obj(session->tls_wrap=2Eopt=2Epid_persist, &se=
ssion->tls_wrap=2Eopt=2Epacket_id);
-
     key_state_init(session, &session=
->key[KS_PRIMARY]);
 
     dmsg(D_TLS_DEBUG, "TLS: tls_session_init: new se=
ssion object, sid=3D%s",
diff --git a/src/openvpn/syshead=2Eh b/src/openvpn=
/syshead=2Eh
index 1d6cdc2=2E=2E65baee3 100644
--- a/src/openvpn/syshead=2E=
h
+++ b/src/openvpn/syshead=2Eh
@@ -127,10 +127,6 @@
 #include <fcntl=2Eh>
=
 #endif
 
-#ifdef HAVE_SYS_FILE_H
-#include <sys/file=2Eh>
-#endif
-
 /* Th=
ese headers belong to C99 and should be always be present */
 #include <std=
lib=2Eh>
 #include <inttypes=2Eh>
diff --git a/src/openvpn/tls_crypt=2Ec b/=
src/openvpn/tls_crypt=2Ec
index 23c7975=2E=2Ee7fb865 100644
--- a/src/openv=
pn/tls_crypt=2Ec
+++ b/src/openvpn/tls_crypt=2Ec
@@ -109,7 +109,6 @@
     s=
ession->tls_wrap_reneg=2Emode =3D TLS_WRAP_CRYPT;
     session->tls_wrap_re=
neg=2Ecleanup_key_ctx =3D true;
     session->tls_wrap_reneg=2Ework =3D all=
oc_buf(BUF_SIZE(&session->opt->frame));
-    session->tls_wrap_reneg=2Eopt=
=2Epid_persist =3D NULL;
 
     packet_id_init(&session->tls_wrap_reneg=2Eo=
pt=2Epacket_id, session->opt->replay_window,
                    session->o=
pt->replay_time, "TLS_WRAP_RENEG", session->key_id);

-- 
To view, visit ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce9=
3815
Gerrit-Change-Number: 2082
Gerrit-PatchSet: 3
Gerrit-Owner: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attentio=
n: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--En5eDscF1XE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe <strong>uploaded patch set #3</strong> to this change=2E</p><p><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail">View=
 Change</a></p><p>The following approvals got outdated and were removed:
Co=
de-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">Remove replay-persist<=
br><br>This feature is very niche and we do not think it is something we<br=
>should maintain and support going forward=2E<br><br>This feature saves a s=
ingle packet id to persist-replay file=2E<br>This makes the feature only pr=
operly work in a p2p setup where both<br>sides use replay-persist to save t=
he last known packet id from the<br>peer=2E Even then it will only prevent =
some packet replays until the<br>legitimate peer sends a packet again=2E<br=
><br>In server mode (p2mp) each client context has its own replay state<br>=
and saving a single packet id is also not very useful with multiple<br>clie=
nts and multiple states=2E<br><br>Change-Id: I5ee231d157459e6406f1f4c12cd6c=
6e0fce93815<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>--=
-<br>M Changes=2Emd<br>M config=2Eh=2Ecmake=2Ein<br>M configure=2Eac<br>M d=
oc/man-sections/link-options=2Erst<br>M doc/man-sections/tls-options=2Erst<=
br>M doc/man-sections/unsupported-options=2Erst<br>M src/openvpn/check_file=
_access=2Ec<br>M src/openvpn/crypto=2Ec<br>M src/openvpn/crypto=2Eh<br>M sr=
c/openvpn/errlevel=2Eh<br>M src/openvpn/forward=2Ec<br>M src/openvpn/init=
=2Ec<br>M src/openvpn/openvpn=2Eh<br>M src/openvpn/options=2Ec<br>M src/ope=
nvpn/options=2Eh<br>M src/openvpn/options_show=2Ec<br>M src/openvpn/packet_=
id=2Ec<br>M src/openvpn/packet_id=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/ope=
nvpn/syshead=2Eh<br>M src/openvpn/tls_crypt=2Ec<br>21 files changed, 25 ins=
ertions(+), 318 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/82/2082/3</pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git =
a/Changes=2Emd b/Changes=2Emd</span><br><span>index 7f47f77=2E=2E89a72fe 10=
0644</span><br><span>--- a/Changes=2Emd</span><br><span>+++ b/Changes=2Emd<=
/span><br><span>@@ -30,6 +30,12 @@</span><br><span>   &quot;too complicated=
&quot;, using `--peer-fingerprint` makes TLS mode about as easy as</span><b=
r><span>   using `--secret`=2E</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+* **`replay-persist` has been removed**</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  This feature has been removed as it was nev=
er properly implemented for</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  server mode and generally was a niche feature=2E If the option is=
 present</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  it will b=
e ignored=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> ## Maintainer-visible changes</span><br><span> </span><br><span>=
 - The configure-time option `--enable-debug` is no longer  available</span=
><br><span>diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein</=
span><br><span>index 5e06a63=2E=2Ef7818cf 100644</span><br><span>--- a/conf=
ig=2Eh=2Ecmake=2Ein</span><br><span>+++ b/config=2Eh=2Ecmake=2Ein</span><br=
><span>@@ -285,9 +285,6 @@</span><br><span> /* Define to 1 if you have the =
&lt;sys/epoll=2Eh&gt; header file=2E */</span><br><span> #cmakedefine HAVE_=
SYS_EPOLL_H</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-/* Define to 1 if you have the &lt;sys/file=2Eh&gt; header file=2E =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#undef HAVE_SYS_FIL=
E_H</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
/* Define to 1 if you have the &lt;sys/inotify=2Eh&gt; header file=2E */</s=
pan><br><span> #cmakedefine HAVE_SYS_INOTIFY_H</span><br><span> </span><br>=
<span>diff --git a/configure=2Eac b/configure=2Eac</span><br><span>index 5f=
18798=2E=2E9326c4e 100644</span><br><span>--- a/configure=2Eac</span><br><s=
pan>+++ b/configure=2Eac</span><br><span>@@ -453,7 +453,7 @@</span><br><spa=
n> ])</span><br><span> AC_CHECK_HEADERS([ \</span><br><span> 	sys/time=2Eh =
sys/ioctl=2Eh sys/stat=2Eh \</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-	sys/mman=2Eh sys/file=2Eh sys/wait=2Eh \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	sys/mman=2Eh sys/wait=2Eh \</span><br><span> =
	libgen=2Eh stropts=2Eh \</span><br><span> 	syslog=2Eh pwd=2Eh grp=2Eh \</s=
pan><br><span> 	sys/sockio=2Eh sys/uio=2Eh \</span><br><span>@@ -561,8 +561=
,7 @@</span><br><span> AC_CHECK_FUNCS([ \</span><br><span> 	daemon chroot g=
etpwnam setuid nice dup dup2 \</span><br><span> 	syslog openlog mlockall ge=
trlimit getgrnam setgid \</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	setgroups flock gettimeofday \</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	setsid chdir \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	setgroups gettimeofday setsid chdir \</span><br><span> 	chsize f=
truncate execve getpeereid basename dirname \</span><br><span> 	epoll_creat=
e strlcpy strsep strtok_r \</span><br><span> ])</span><br><span>diff --git =
a/doc/man-sections/link-options=2Erst b/doc/man-sections/link-options=2Erst=
</span><br><span>index 735ee51=2E=2Ebbdcf7f 100644</span><br><span>--- a/do=
c/man-sections/link-options=2Erst</span><br><span>+++ b/doc/man-sections/li=
nk-options=2Erst</span><br><span>@@ -440,19 +440,6 @@</span><br><span>   ph=
ysical IP layer=2E The problem is easily fixed by simply using TCP as</span=
><br><span>   the VPN transport layer=2E</span><br><span> </span><br><span>=
---replay-persist file</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  Persist replay-protection state across sessions using ``file`` to save</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  and reload the state=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  This option will keep a disk copy of =
the current replay protection state</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-  (i=2Ee=2E the most recent packet timestamp and sequence num=
ber received from</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  th=
e remote peer), so that if an OpenVPN session is stopped and</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  restarted, it will reject any repl=
ays of packets which were already</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  received by the prior session=2E</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-  This option only makes sense when replay protection is enabled (the</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  default) and you are =
using TLS mode with ``--tls-auth``=2E</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span> --session-timeout n</span><br><span>   Ra=
ises :code:`SIGTERM` for the client instance after ``n`` seconds since</spa=
n><br><span>   the beginning of the session, forcing OpenVPN to disconnect=
=2E</span><br><span>diff --git a/doc/man-sections/tls-options=2Erst b/doc/m=
an-sections/tls-options=2Erst</span><br><span>index c4aa810=2E=2Ede4d324 10=
0644</span><br><span>--- a/doc/man-sections/tls-options=2Erst</span><br><sp=
an>+++ b/doc/man-sections/tls-options=2Erst</span><br><span>@@ -370,10 +370=
,7 @@</span><br><span>   level has had a chance to authenticate the peer=2E=
 The result is that</span><br><span>   packets without the correct signatur=
e can be dropped immediately upon</span><br><span>   reception, before they=
 have a chance to consume additional system</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  resources such as by initiating a TLS handshake=2E =
``--tls-auth`` can be</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  strengthened by adding the ``--replay-persist`` option which will keep</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-  OpenVPN&#39;s replay p=
rotection state in a file so that it is not lost</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-  across restarts=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  resources such as by initiating a TLS handsha=
ke=2E</span><br><span> </span><br><span>   It should be emphasized that thi=
s feature is optional and that the key</span><br><span>   file used with ``=
--tls-auth`` gives a peer nothing more than the power</span><br><span>diff =
--git a/doc/man-sections/unsupported-options=2Erst b/doc/man-sections/unsup=
ported-options=2Erst</span><br><span>index 0bb5e4b=2E=2E1b49beb 100644</spa=
n><br><span>--- a/doc/man-sections/unsupported-options=2Erst</span><br><spa=
n>+++ b/doc/man-sections/unsupported-options=2Erst</span><br><span>@@ -76,3=
 +76,8 @@</span><br><span>   (generated by DH or ECDH) has been considered =
problematic for many</span><br><span>   years=2E Please use ``--peer-finger=
print`` and self-signed certificates</span><br><span>   for small setups=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+--replay-persist</span><br><span style=
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
--git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 9=
299c4f=2E=2E8c9098c 100644</span><br><span>--- a/src/openvpn/init=2Ec</span=
><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -66,7 +66,6 @@</sp=
an><br><span> /*</span><br><span>  * Crypto initialization flags</span><br>=
<span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CF_=
LOAD_PERSISTED_PACKET_ID (1 &lt;&lt; 0)</span><br><span> #define CF_INIT_TL=
S_MULTI           (1 &lt;&lt; 1)</span><br><span> #define CF_INIT_TLS_AUTH_=
STANDALONE (1 &lt;&lt; 2)</span><br><span> </span><br><span>@@ -737,8 +736,=
6 @@</span><br><span> {</span><br><span>     context_clear_1(c);</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    packet_id_=
persist_init(&amp;c-&gt;c1=2Epid_persist);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span>     init_connection_list(c);</span><=
br><span> </span><br><span>     c-&gt;c1=2Elink_sockets_num =3D c-&gt;optio=
ns=2Ece=2Elocal_list-&gt;len;</span><br><span>@@ -1346,12 +1343,6 @@</span>=
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
span>@@ -2957,15 +2948,6 @@</span><br><span>     {</span><br><span>        =
 crypto_init_lib_engine(c-&gt;options=2Eengine);</span><br><span>     }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (flags &amp; CF_LOAD_PERSISTED_PACKET_I=
D)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        /* load a persisted packet-=
id for cross-session replay-protection */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (c-&gt;options=2Epacket_id_file)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            packet_id_persist_load(&amp;c-&=
gt;c1=2Epid_persist, c-&gt;options=2Epacket_id_file);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span> }</span><br><span> </span><br><s=
pan> </span><br><span>@@ -3354,7 +3336,6 @@</span><br><span>     if (to=2Et=
ls_wrap=2Emode =3D=3D TLS_WRAP_AUTH || to=2Etls_wrap=2Emode =3D=3D TLS_WRAP=
_CRYPT)</span><br><span>     {</span><br><span>         to=2Etls_wrap=2Eopt=
=2Ekey_ctx_bi =3D c-&gt;c1=2Eks=2Etls_wrap_key;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        to=2Etls_wrap=2Eopt=2Epid_persist =3D &am=
p;c-&gt;c1=2Epid_persist;</span><br><span>         to=2Etls_wrap=2Eopt=2Efl=
ags |=3D CO_PACKET_ID_LONG_FORM;</span><br><span>         to=2Etls_wrap=2Eo=
riginal_wrap_keydata =3D c-&gt;c1=2Eks=2Eoriginal_wrap_keydata;</span><br><=
span>     }</span><br><span>@@ -3913,11 +3894,6 @@</span><br><span> do_clos=
e_packet_id(struct context *c)</span><br><span> {</span><br><span>     pack=
et_id_free(&amp;c-&gt;c2=2Ecrypto_options=2Epacket_id);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    packet_id_persist_save(&amp;c-&gt;c1=
=2Epid_persist);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (!(c-&gt;sig-&gt;signal_received =3D=3D SIGUSR1))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        packet_id_persist_close(&amp;c-&gt;c1=2Epid_persist=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an> }</span><br><span> </span><br><span> #ifdef ENABLE_FRAGMENT</span><br><=
span>@@ -4453,7 +4429,7 @@</span><br><span>         }</span><br><span>     =
    else if (c-&gt;mode =3D=3D CM_P2P)</span><br><span>         {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            crypto_flags =3D CF=
_LOAD_PERSISTED_PACKET_ID | CF_INIT_TLS_MULTI;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            crypto_flags =3D CF_INIT_TLS_MULTI;<=
/span><br><span>         }</span><br><span>         else if (child)</span><=
br><span>         {</span><br><span>@@ -4711,7 +4687,6 @@</span><br><span> =
    ALLOC_OBJ_CLEAR_GC(dest-&gt;sig, struct signal_info, &amp;dest-&gt;gc);=
</span><br><span> </span><br><span>     /* c1 init */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    packet_id_persist_init(&amp;dest-&gt;c1=
=2Epid_persist);</span><br><span>     dest-&gt;c1=2Elink_sockets_num =3D 1;=
</span><br><span>     do_link_socket_addr_new(dest);</span><br><span> </spa=
n><br><span>diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh<=
/span><br><span>index cdd02b6=2E=2E52f298b 100644</span><br><span>--- a/src=
/openvpn/openvpn=2Eh</span><br><span>+++ b/src/openvpn/openvpn=2Eh</span><b=
r><span>@@ -75,21 +75,6 @@</span><br><span> };</span><br><span> </span><br>=
<span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * struct pa=
cket_id_persist should be empty if we are not</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * building with crypto=2E</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#ifndef PACKET_ID_H</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-struct packet_id_persist</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int =
dummy;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-static inline void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-packet_id_persist_init(struct packet_=
id_persist *p)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span=
><br><span>  * Packet processing buffers=2E</span><br><span>  */</span><br>=
<span> struct context_buffers</span><br><span>@@ -167,9 +152,6 @@</span><br=
><span>     /* preresolved and cached host names */</span><br><span>     st=
ruct cached_dns_entry *dns_cache;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* persist crypto sequence number to/fr=
om file */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct =
packet_id_persist pid_persist;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span>     struct tuntap *tuntap; /**&lt; Tun/tap virtu=
al network interface=2E */</span><br><span>     bool tuntap_owned;     /**&=
lt; Whether the tun/tap interface should</span><br><span>                  =
           *   be cleaned up when this %context is</span><br><span>@@ -352,=
8 +334,6 @@</span><br><span>      *   Channel Crypto module\endlink to</spa=
n><br><span>      *   process data channel packet=2E */</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct event_timeou=
t packet_id_persist_interval;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span> #ifdef USE_COMP</span><br><span>     struct compr=
ess_context *comp_context;</span><br><span>     /**&lt; Compression context=
 used by the</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/ope=
nvpn/options=2Ec</span><br><span>index 4e6c705=2E=2Eebfa8b9 100644</span><b=
r><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/opt=
ions=2Ec</span><br><span>@@ -573,8 +573,6 @@</span><br><span>     &quot;--r=
eplay-window n [t]  : Use a replay protection sliding window of size n\n&qu=
ot;</span><br><span>     &quot;                         and a time window o=
f t seconds=2E\n&quot;</span><br><span>     &quot;                         =
Default n=3D%d t=3D%d\n&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    &quot;--replay-persist file : Persist replay-protection state a=
cross sessions\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    &quot;                  using file=2E\n&quot;</span><br><span>     &qu=
ot;--test-crypto   : Run a self-test of crypto features enabled=2E\n&quot;<=
/span><br><span>     &quot;                  For debugging only=2E\n&quot;<=
/span><br><span>     &quot;\n&quot;</span><br><span>@@ -7048,7 +7046,7 @@</=
span><br><span>     else if (streq(p[0], &quot;replay-persist&quot;) &amp;&=
amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>        =
 VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        options-&gt;packet_id_file =3D p[1];</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;DEPRECATED =
OPTION: --replay-persist option ignored=2E&quot;);</span><br><span>     }</=
span><br><span>     else if (streq(p[0], &quot;test-crypto&quot;) &amp;&amp=
; !p[1])</span><br><span>     {</span><br><span>diff --git a/src/openvpn/op=
tions=2Eh b/src/openvpn/options=2Eh</span><br><span>index 129267f=2E=2Edd8b=
75a 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>++=
+ b/src/openvpn/options=2Eh</span><br><span>@@ -582,7 +582,6 @@</span><br><=
span>     bool mute_replay_warnings;</span><br><span>     int replay_window=
;</span><br><span>     int replay_time;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    const char *packet_id_file;</span><br><span>     bool=
 test_crypto;</span><br><span> </span><br><span>     /* TLS (control channe=
l) parms */</span><br><span>diff --git a/src/openvpn/options_show=2Ec b/src=
/openvpn/options_show=2Ec</span><br><span>index 321a37b=2E=2E54f9c4c 100644=
</span><br><span>--- a/src/openvpn/options_show=2Ec</span><br><span>+++ b/s=
rc/openvpn/options_show=2Ec</span><br><span>@@ -501,7 +501,6 @@</span><br><=
span>     SHOW_BOOL(mute_replay_warnings);</span><br><span>     SHOW_INT(re=
play_window);</span><br><span>     SHOW_INT(replay_time);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR(packet_id_file);</span><br=
><span>     SHOW_BOOL(test_crypto);</span><br><span> </span><br><span>     =
SHOW_BOOL(tls_server);</span><br><span>diff --git a/src/openvpn/packet_id=
=2Ec b/src/openvpn/packet_id=2Ec</span><br><span>index 9dd6ce3=2E=2Ef1fadd6=
 100644</span><br><span>--- a/src/openvpn/packet_id=2Ec</span><br><span>+++=
 b/src/openvpn/packet_id=2Ec</span><br><span>@@ -426,146 +426,6 @@</span><b=
r><span>     return BSTR(&amp;out);</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-/* initialize the packet=
_id_persist structure in a disabled state */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-packet_id_persist_init(struct packet_id_persist *p)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    p-&gt;filename =3D NULL;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    p-&gt;fd =3D -1;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    p-&gt;time =3D p-&gt;time_last_written =3D 0;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    p-&gt;id =3D p-&gt;id=
_last_written =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-/* close the file descriptor if it is open=
, and switch to disabled state */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-packe=
t_id_persist_close(struct packet_id_persist *p)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (packet_id_persist_enabled(p))</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        if (close(p-&gt;fd))</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            msg(D_PID_PERSIST | M_ERRNO, &quot;Close error on --replay-per=
sist file %s&quot;, p-&gt;filename);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        packet_id_persist_init(p);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-/* load persisted rec packet_id (time and=
 id) only once from file, and set state to enabled */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-packet_id_persist_load(struct packet_id_persist *p, const ch=
ar *filename)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D g=
c_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!pack=
et_id_persist_enabled(p))</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* o=
pen packet-id persist file for both read and write */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        p-&gt;fd =3D platform_open(filename=
, O_CREAT | O_RDWR | O_BINARY, S_IRUSR | S_IWUSR);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if (p-&gt;fd =3D=3D -1)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            msg(D_PID_PERSIST | M_ERRNO, &quot;C=
annot open --replay-persist file %s for read/write&quot;,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                filename);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            struct packet_id_persist_file_image image;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            ssize_t n;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#if defined(HAVE_FLOCK) &amp;&amp; defined(LOCK_EX) &a=
mp;&amp; defined(LOCK_NB)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            if (flock(p-&gt;fd, LOCK_EX | LOCK_NB))</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                msg(M_ERR, &quot;Cannot obtain ex=
clusive lock on --replay-persist file %s&quot;, filename);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     p-&gt;filename =3D filename;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            n =3D read(p-&gt;fd, &amp;image, sizeof(image));</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (n =3D=3D=
 sizeof(image))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  p-&gt;time =3D p-&gt;time_last_written =3D image=2Etime;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                p-&gt;id =3D p-&gt;id_=
last_written =3D image=2Eid;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                dmsg(D_PID_PERSIST_DEBUG, &quot;PID Persist Read fro=
m %s: %s&quot;, p-&gt;filename,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                     packet_id_persist_print(p, &amp;gc));</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            else if (n =3D=3D -1)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                msg(D_PID_PERSIS=
T | M_ERRNO, &quot;Read error on --replay-persist file %s&quot;, p-&gt;file=
name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* save persisted=
 rec packet_id (time and id) to file (only if enabled state) */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-packet_id_persist_save(struct packet_id_persist *p=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (packet_id_persist_enabled(p) &am=
p;&amp; p-&gt;time</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     &amp;&amp; (p-&gt;time !=3D p-&gt;time_last_written || p-&gt;id !=3D p=
-&gt;id_last_written))</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct =
packet_id_persist_file_image image;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        CLEAR(image);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        off_t seek_ret;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        struct gc_arena gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        image=2Etime =3D p-&gt;time;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        image=2Eid =3D p-&gt;id;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        seek_ret =3D lseek(p-&gt;fd=
, (off_t)0, SEEK_SET);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        if (seek_ret =3D=3D (off_t)0)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            const ssize_t n =3D write(p-&gt;fd, &amp;image, sizeof(ima=
ge));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (=
n =3D=3D sizeof(image))</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          p-&gt;time_last_written =3D p-&gt;time;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                p-&gt;id_last_written =3D p-&gt=
;id;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                d=
msg(D_PID_PERSIST_DEBUG, &quot;PID Persist Write to %s: %s&quot;, p-&gt;fil=
ename,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
      packet_id_persist_print(p, &amp;gc));</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            else</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                msg(D_PID_PERSIST | M_ERRNO, &quot;Cannot write to --repla=
y-persist file %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                    p-&gt;filename);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_PID_P=
ERSIST | M_ERRNO, &quot;Cannot seek to beginning of --replay-persist file %=
s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   p-&gt;filename);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        gc_fre=
e(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-/* transfer packet_id_persist -&gt; packet_id */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-packet_id_persist_load_obj(const struct packet_id_persist=
 *p, struct packet_id *pid)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (p &amp=
;&amp; pid &amp;&amp; packet_id_persist_enabled(p) &amp;&amp; p-&gt;time)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        pid-&gt;rec=2Etime =3D p-&gt;ti=
me;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        pid-&gt;re=
c=2Eid =3D p-&gt;id;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-const char *</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-packet_id_persist_print(const struct packet_id_persist *p, struct g=
c_arena *gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer out =3D all=
oc_buf_gc(256, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_printf(&amp;out=
, &quot;[&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (packet_id_persist=
_enabled(p))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;o=
ut, &quot; #&quot; packet_id_format, (packet_id_print_type)p-&gt;id);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (p-&gt;time)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&amp;out, &quo=
t; / time =3D (&quot; packet_id_format &quot;) %s&quot;, (packet_id_print_t=
ype)p-&gt;time,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                 time_string(p-&gt;time, 0, false, gc));</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_printf=
(&amp;out, &quot; ]&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    return (char *)out=2Edata;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span> #ifndef ENABLE_SMALL</span><br><span> </span><br><span> static=
 void</span><br><span>diff --git a/src/openvpn/packet_id=2Eh b/src/openvpn/=
packet_id=2Eh</span><br><span>index 48752d3=2E=2Ec374ccb 100644</span><br><=
span>--- a/src/openvpn/packet_id=2Eh</span><br><span>+++ b/src/openvpn/pack=
et_id=2Eh</span><br><span>@@ -125,26 +125,6 @@</span><br><span> };</span><b=
r><span> </span><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * file to facilitate cross-session persistence</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * of time/id</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-struct packet_id_persist</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const=
 char *filename;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
nt fd;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    time_t time=
;       /* time stamp */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    packet_id_type id; /* sequence number */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    time_t time_last_written;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    packet_id_type id_last_written;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-struct packet_id_persist_file_image</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    time_t time;       /* time stamp */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    packet_id_type id; /* sequence number */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-/*</span><br><span>  * Keep a record of our current packet-id state</spa=
n><br><span>  * on the sending side=2E</span><br><span>  */</span><br><span=
>@@ -222,28 +202,6 @@</span><br><span> void packet_id_reap(struct packet_id=
_rec *p);</span><br><span> </span><br><span> /*</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * packet ID persistence</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* initial=
ize the packet_id_persist structure in a disabled state */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-void packet_id_persist_init(struct pac=
ket_id_persist *p);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* close the file descr=
iptor if it is open, and switch to disabled state */</span><br><span style=
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
n>index 55043e5=2E=2E67df7c2 100644</span><br><span>--- a/src/openvpn/ssl=
=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -878,8 +8=
78,6 @@</span><br><span>     packet_id_init(&amp;ks-&gt;crypto_options=2Epa=
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
><span>index 23c7975=2E=2Ee7fb865 100644</span><br><span>--- a/src/openvpn/=
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

<div style=3D"display:none"> Gerrit-MessageType: newpatch=
set </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 2082 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> G=
errit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body=
></html>
--En5eDscF1XE=--


--===============4691084252375488643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4691084252375488643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4691084252375488643==--

