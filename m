Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A002606A32A
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JbR5s6KN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Txfoefau;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BZ4GY3Gf;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=F3wklY2p
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DPtuoJcdwUYrgB/bAP+hDNbKZGh39W7fO1+UUudVx3s=; b=JbR5s6KNx5eEEhKa3vGxJIH09g
	vD8PGpxzhSayFUjtgF8d54qhBZ5vaFtJR3TB6FDtqvKOOIg2Tm/x7QUJsPlYwtaEPMMgvSoRCMYdt
	myaUD6D3siKZBXvZG8mSH3v3eoQv2JVwE1dQe06WD4urdsu7TFSuoBuD6dZZdYlkZh5E=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQSYs-000000000tL-0FUh;
	Mon, 09 Nov 2026 16:49:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQSYq-000000000tE-0EQ0
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 16:49:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0+aI25zCQJG2Ycvd2gKiayZ2e8URcXjZouePAlGvvt0=; b=Txfoefau1/1Q4rW21XwIlxsn7e
 if0tHGwjLIuCd4ojw3Dn2cgl2Qbw2uE8ZoCm96HkL2n+N29Gfya+mEvaADiwSzzGclINFs27uqkz5
 KqHubovgYSUATQ4Y0yED8KGrTQHj6hAGKMvwM4xrU1/dYaLuQuBPFBMxmj7hPaJxVTZg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0+aI25zCQJG2Ycvd2gKiayZ2e8URcXjZouePAlGvvt0=; b=BZ4GY3Gfd+6rpa9vo7Thb0y7Nx
 P9bA/BA4Y5bS9ttgyj6EON/AbAFaO8Y1+leUk1pQ6UJdsDrPrByMml0QOaoTFT2XVBXsxUM666BbA
 GFsDlhLKdafau1Wxc1MBpnjwnd8rV0CJ5Gr4+ZeEOtlpedjwuZa0zpP8Xn8XPOXgexYs=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQSYl-000000003zy-2bu6 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 16:49:35 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so9326395e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 08:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794242965; x=1794847765; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0+aI25zCQJG2Ycvd2gKiayZ2e8URcXjZouePAlGvvt0=;
 b=F3wklY2pnKw4Po/pGQ8aICcGVZLnzGKpx7ph0kiMALZnJPjGYC2MlVeMg1dDasOiBb
 qh4siZZIfb+gwrEaQX9l8Bh7lhNdyS3qrNUta2Cfk5VesSWM7WHVAn7C/0WSJ3f5H1is
 W7Mhv1+JAW4ScUdnKt7eW5hf5/5nbF57qCYlqqw2vYsks7szbTJ/GWduHuCCpMDVHDud
 h7TMcKlXK2M+nfzSZ2WmMZD8EgAiBAjzd55yFaSXXWeINivEei2FZ7OIwVc2R4ZWPWMr
 CiqkfBu971E/vQHBLNkx4girLtTN6CXzGN2vZDNXeiemaWp+1OBjojYNQez+mPjIIVXB
 ocug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794242965; x=1794847765;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0+aI25zCQJG2Ycvd2gKiayZ2e8URcXjZouePAlGvvt0=;
 b=fBa/zz2DzK+7K9xji95iKzez7AyDu19iT+FFBLbS2Rn28F5xJ9/SnmaxTNh7f5Hdx1
 860LW8Y+hqaaWm/LaAWVb6kkrT/HePnfy8NgAHSjvcP78NbO8njTi/8kLWwOjR7SFHnQ
 zvLeDvgrBcY4APx+EXg5bKlUy9vCYKBjgDoW2hlQOOpcvSH3r52Mcs7En+yyMdq9Ia1w
 YYPNoJu39Nu8ryf6jnaasHUM5X2rey6t4KGEZ4pe1a6IW2LO9QgLtKXvdoTSFLfoWHpS
 XKkmOfjMEH271ZWpRp3rxuHg311fkivJ73iZD27mMz5M0QrXWqF8ePS+1mt3ax4yCBjF
 70Fg==
X-Gm-Message-State: APuU4Z+R+7WMceFBQMPemT5Tmxwy0jNDFObyGMcH3syQ7qHRasPBU71Y
 c1jvsIA2N65QPf9er7vQabwuISppmRzH7etSjpxUVj73Xum1CZ7mNQlvrFgREx5Lbi/0aQgzIdF
 ntwSadzxbW02vChHgXyNh55XspiTlMN2LP6YmZS903g3W+EzBmUhJIcazsiqaWvFh5/0+
X-Gm-Gg: AYBFou2ICcIntHpIrie36+UmyI0Cy/M0ogNAl2Xhv3AqkiPcpL9bXGNYxPf7t1jHvI4
 jeHgRkaJQqf7Vk3eJvxCVrWXOXKzqK0WJWdBTs+oXFnxMAPznIyBu4QXotmhe3HyocTae7G67sL
 0vCw3M6e1AHd+E+y1pzP4lzFLE/zLCVpGgYpmLheLIahDEit+WoqXhMhkJvOYK1qq1hsI6zUdUX
 Aa5pknqJTnoKVo3gug6z7KeuKSEIWck77DEnrmJNOWe3SNkzSqu9sWzf6hyx3WgyAAOle/uNXV0
 SruBsUrq9fXa57pJxPqnCWJVH6RsGubZHhjHMuGSSB/i7zVF1MVoHntvz84B7rltZIrZV+6AvCK
 2fu2WqIvqL9ZXY1UfWEBD9znpQptQhgcl2WForwZg4hHXGLxiySidyu1RzNziaqPz/nk95Uea6E
 PzFk9ZPajqEdr5p4FVMT4D+VdB5QYGT0iIwceFJ/catcGrYRGo7nvNVEI0lzT5rRMBY9J5zkg1f
 jI5h328hO8J8bhb7q19FVE2Oy3dl/yAm4Fi/ol9Enzo4/zmd4OFNkqq7g06Ccg7J9GFh5xrXDky
 lZA37sAVfPIe1pygV0orRUF3fHzu1ec1dAezmJ7YAQqSa6pdZoxqtBuXbjuxMnbsJVKw9MAPly2
 ADUXQRMvqubP8ExL63UGNMz3SlwFVy2BDbHHA6NTviVXlUb2RRwadj62Po4M6FAzRMePSN9sgVW
 8qhuFTcVvIdIIgzN1VSDV5ovtxGUAtMLwvuuE=
X-Received: by 2002:a05:600c:4f56:b0:4a2:c2b:a91b with SMTP id
 5b1f17b1804b1-4b963c75b4fmr95346075e9.10.1794242964635; 
 Mon, 09 Nov 2026 08:49:24 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49597e00d75sm10739418f8f.58.2026.11.09.08.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 08:49:20 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 16:49:12 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815
X-Gerrit-Change-Number: 2082
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2082?usp=email>
X-Gerrit-Commit: ab58aff7492662bee48d1f3fdde44f249901c4f0
In-Reply-To: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
References: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkk1ZWUyMzFkMTU3NDU5ZTY0MDZmMWY0YzEyY2Q2YzZlMGZjZTkzODE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4c6680ee182b9a6ea9faa6d7c8a5a73f53f3449b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQSYl-000000003zy-2bu6
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
Content-Type: multipart/mixed; boundary="===============5537414754310797535=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5537414754310797535==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mEycHLnfwIg="; charset=UTF-8

--mEycHLnfwIg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, Gert Doering, R=C4=
=83zvan Cojocaru=2E

Hello Frank Lichtenheld, Gert Doering, R=C4=83zvan Coj=
ocaru, 

I'd like you to reexamine a change=2E Please visit

    https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail

to look at the new patch=
 set (#6)=2E

The following approvals got outdated and were removed:
Code-R=
eview+2 by R=C4=83zvan Cojocaru

The change is no longer submittable: Code-=
Review and checks~ChecksSubmitRule are unsatisfied now=2E


Change subject:=
 Remove replay-persist
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

Remove replay-persist

This feature is very niche and we do not =
think it is something we
should maintain and support going forward=2E

This=
 feature saves a single packet id to replay-persist file=2E
This makes the =
feature only properly work in a p2p setup where both
sides use replay-persi=
st to save the last known packet id from the
peer=2E Even then it will only=
 prevent some packet replays until the
legitimate peer sends a packet again=
=2E

In server mode (p2mp) each client context has its own replay state
and=
 saving a single packet id is also not very useful with multiple
clients an=
d multiple states=2E

Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815
=
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M Changes=2Emd
M confi=
g=2Eh=2Ecmake=2Ein
M configure=2Eac
M doc/man-sections/link-options=2Erst
M=
 doc/man-sections/tls-options=2Erst
M doc/man-sections/unsupported-options=
=2Erst
M src/openvpn/check_file_access=2Ec
M src/openvpn/crypto=2Ec
M src/o=
penvpn/crypto=2Eh
M src/openvpn/errlevel=2Eh
M src/openvpn/forward=2Ec
M sr=
c/openvpn/init=2Ec
M src/openvpn/openvpn=2Eh
M src/openvpn/options=2Ec
M sr=
c/openvpn/options=2Eh
M src/openvpn/options_show=2Ec
M src/openvpn/packet_i=
d=2Ec
M src/openvpn/packet_id=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/syshe=
ad=2Eh
M src/openvpn/tls_crypt=2Ec
21 files changed, 33 insertions(+), 330 =
deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/82/2082/6

diff --git a/Changes=2Emd b/Changes=2Emd
index 7f47f77=2E=
=2E89a72fe 100644
--- a/Changes=2Emd
+++ b/Changes=2Emd
@@ -30,6 +30,12 @@
=
   "too complicated", using `--peer-fingerprint` makes TLS mode about as ea=
sy as
   using `--secret`=2E
 
+* **`replay-persist` has been removed**
+
+=
  This feature has been removed as it was never properly implemented for
+ =
 server mode and generally was a niche feature=2E If the option is present
=
+  it will be ignored=2E
+
 ## Maintainer-visible changes
 
 - The configur=
e-time option `--enable-debug` is no longer  available
diff --git a/config=
=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein
index 5e06a63=2E=2Ef7818cf 1006=
44
--- a/config=2Eh=2Ecmake=2Ein
+++ b/config=2Eh=2Ecmake=2Ein
@@ -285,9 +2=
85,6 @@
 /* Define to 1 if you have the <sys/epoll=2Eh> header file=2E */
 =
#cmakedefine HAVE_SYS_EPOLL_H
 
-/* Define to 1 if you have the <sys/file=
=2Eh> header file=2E */
-#undef HAVE_SYS_FILE_H
-
 /* Define to 1 if you ha=
ve the <sys/inotify=2Eh> header file=2E */
 #cmakedefine HAVE_SYS_INOTIFY_H=

 
diff --git a/configure=2Eac b/configure=2Eac
index 5f18798=2E=2E9326c4e =
100644
--- a/configure=2Eac
+++ b/configure=2Eac
@@ -453,7 +453,7 @@
 ])
 A=
C_CHECK_HEADERS([ \
 	sys/time=2Eh sys/ioctl=2Eh sys/stat=2Eh \
-	sys/mman=
=2Eh sys/file=2Eh sys/wait=2Eh \
+	sys/mman=2Eh sys/wait=2Eh \
 	libgen=2Eh=
 stropts=2Eh \
 	syslog=2Eh pwd=2Eh grp=2Eh \
 	sys/sockio=2Eh sys/uio=2Eh =
\
@@ -561,8 +561,7 @@
 AC_CHECK_FUNCS([ \
 	daemon chroot getpwnam setuid n=
ice dup dup2 \
 	syslog openlog mlockall getrlimit getgrnam setgid \
-	setg=
roups flock gettimeofday \
-	setsid chdir \
+	setgroups gettimeofday setsid=
 chdir \
 	chsize ftruncate execve getpeereid basename dirname \
 	epoll_cr=
eate strlcpy strsep strtok_r \
 ])
diff --git a/doc/man-sections/link-optio=
ns=2Erst b/doc/man-sections/link-options=2Erst
index 735ee51=2E=2Ebbdcf7f 1=
00644
--- a/doc/man-sections/link-options=2Erst
+++ b/doc/man-sections/link=
-options=2Erst
@@ -440,19 +440,6 @@
   physical IP layer=2E The problem is =
easily fixed by simply using TCP as
   the VPN transport layer=2E
 
---repl=
ay-persist file
-  Persist replay-protection state across sessions using ``=
file`` to save
-  and reload the state=2E
-
-  This option will keep a disk=
 copy of the current replay protection state
-  (i=2Ee=2E the most recent p=
acket timestamp and sequence number received from
-  the remote peer), so t=
hat if an OpenVPN session is stopped and
-  restarted, it will reject any r=
eplays of packets which were already
-  received by the prior session=2E
-
=
-  This option only makes sense when replay protection is enabled (the
-  d=
efault) and you are using TLS mode with ``--tls-auth``=2E
-
 --session-time=
out n
   Raises :code:`SIGTERM` for the client instance after ``n`` seconds=
 since
   the beginning of the session, forcing OpenVPN to disconnect=2E
di=
ff --git a/doc/man-sections/tls-options=2Erst b/doc/man-sections/tls-option=
s=2Erst
index c4aa810=2E=2Ede4d324 100644
--- a/doc/man-sections/tls-option=
s=2Erst
+++ b/doc/man-sections/tls-options=2Erst
@@ -370,10 +370,7 @@
   le=
vel has had a chance to authenticate the peer=2E The result is that
   pack=
ets without the correct signature can be dropped immediately upon
   recept=
ion, before they have a chance to consume additional system
-  resources su=
ch as by initiating a TLS handshake=2E ``--tls-auth`` can be
-  strengthene=
d by adding the ``--replay-persist`` option which will keep
-  OpenVPN's re=
play protection state in a file so that it is not lost
-  across restarts=
=2E
+  resources such as by initiating a TLS handshake=2E
 
   It should be=
 emphasized that this feature is optional and that the key
   file used wit=
h ``--tls-auth`` gives a peer nothing more than the power
diff --git a/doc/=
man-sections/unsupported-options=2Erst b/doc/man-sections/unsupported-optio=
ns=2Erst
index 2794f12=2E=2E368805e 100644
--- a/doc/man-sections/unsupport=
ed-options=2Erst
+++ b/doc/man-sections/unsupported-options=2Erst
@@ -79,3 =
+79,8 @@
 
 --allow-deprecated-insecure-static-crypto
   Removed in OpenVPN=
 2=2E8 as --secret was also removed=2E
+
+--replay-persist
+  Removed in Op=
enVPN 2=2E8=2E This option never really worked well with ``--server``
+  an=
d the usefulness of this option in p2p setups is not very high either=2E
+ =
 It is now ignored if present in the configuration file=2E
diff --git a/src=
/openvpn/check_file_access=2Ec b/src/openvpn/check_file_access=2Ec
index ab=
2535d=2E=2Ebe9b4b2 100644
--- a/src/openvpn/check_file_access=2Ec
+++ b/src=
/openvpn/check_file_access=2Ec
@@ -312,9 +312,6 @@
                        =
                  ce->tls_crypt_v2_file, R_OK, "--tls-crypt-v2");
     }
 
=
-    errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options=
->packet_id_file,
-                              R_OK | W_OK, "--replay-per=
sist");
-
     /* ** Password files ** */
     errs |=3D check_file_access(=
CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
                          =
     options->key_pass_file, R_OK, "--askpass");
diff --git a/src/openvpn/c=
rypto=2Ec b/src/openvpn/crypto=2Ec
index a8ad7f0=2E=2E6efa005 100644
--- a/=
src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -403,10 +403,6 @@
  =
   if (packet_id_test(recv, pin))
     {
         packet_id_add(recv, pin);=

-        if (opt->pid_persist && (opt->flags & CO_PACKET_ID_LONG_FORM))
- =
       {
-            packet_id_persist_save_obj(opt->pid_persist, &opt->pa=
cket_id);
-        }
         ret =3D true;
     }
     else
diff --git a/s=
rc/openvpn/crypto=2Eh b/src/openvpn/crypto=2Eh
index 5212e17=2E=2E81b8352 1=
00644
--- a/src/openvpn/crypto=2Eh
+++ b/src/openvpn/crypto=2Eh
@@ -333,11 =
+333,6 @@
                                  *   The packet id also used as =
the IV
                                  *   for AEAD/OFB/CFG ciphers=2E
  =
                                */
-    struct packet_id_persist *pid_persi=
st;
-    /**< Persistent packet ID state for
-     *   keeping state betwee=
n successive
-     *   OpenVPN process startups=2E */
-
 #define CO_PACKET_=
ID_LONG_FORM         (1u << 0)
     /**< Bit-flag indicating whether to use=

      *   OpenVPN's long packet ID format=2E */
diff --git a/src/openvpn/e=
rrlevel=2Eh b/src/openvpn/errlevel=2Eh
index e52cb65=2E=2E5cea0ad 100644
--=
- a/src/openvpn/errlevel=2Eh
+++ b/src/openvpn/errlevel=2Eh
@@ -64,7 +64,6 =
@@
 #define D_MULTI_ERRORS   LOGLEV(1, 9, M_NONFATAL)  /* show multi-client=
 server errors */
 #define D_EVENT_ERRORS   LOGLEV(1, 10, M_NONFATAL) /* sh=
ow event=2E[ch] errors */
 #define D_PUSH_ERRORS    LOGLEV(1, 11, M_NONFATA=
L) /* show push/pull errors */
-#define D_PID_PERSIST    LOGLEV(1, 12, M_NO=
NFATAL) /* show packet_id persist errors */
 #define D_FRAG_ERRORS    LOGLE=
V(1, 13, M_NONFATAL) /* show fragmentation errors */
 #define D_ALIGN_ERROR=
S   LOGLEV(1, 14, M_NONFATAL) /* show bad struct alignments */
 
@@ -159,16=
 +158,15 @@
 #define D_EVENT_WAIT        LOGLEV(8, 70, M_DEBUG)      /* sho=
w detailed info from event waits */
 #define D_MULTI_TCP         LOGLEV(8, =
70, M_DEBUG)      /* show debug info from mtcp=2Ec */
 
-#define D_TLS_DEBU=
G         LOGLEV(9, 70, M_DEBUG)      /* show detailed info from TLS routin=
es */
-#define D_COMP              LOGLEV(9, 70, M_DEBUG)      /* show comp=
ression info */
-#define D_READ_WRITE        LOGLEV(9, 70, M_DEBUG)      /*=
 show all tun/tcp/udp reads/writes/opens */
-#define D_PACKET_CONTENT    LO=
GLEV(9, 70, M_DEBUG)      /* show before/after encryption packet content */=

-#define D_TLS_NO_SEND_KEY   LOGLEV(9, 70, M_DEBUG)      /* show when no d=
ata channel send-key exists */
-#define D_PID_PERSIST_DEBUG LOGLEV(9, 70, M=
_DEBUG)      /* show packet-id persist debugging info */
-#define D_LINK_RW=
_VERBOSE   LOGLEV(9, 70, M_DEBUG)      /* increase link reads/writes verbos=
ity */
-#define D_STREAM_DEBUG      LOGLEV(9, 70, M_DEBUG)      /* show TCP=
 stream debug info */
-#define D_WIN32_IO          LOGLEV(9, 70, M_DEBUG)  =
    /* win32 I/O debugging info */
-#define D_PKCS11_DEBUG      LOGLEV(9, 7=
0, M_DEBUG)      /* show PKCS#11 debugging */
+#define D_TLS_DEBUG       LO=
GLEV(9, 70, M_DEBUG)        /* show detailed info from TLS routines */
+#de=
fine D_COMP            LOGLEV(9, 70, M_DEBUG)        /* show compression in=
fo */
+#define D_READ_WRITE      LOGLEV(9, 70, M_DEBUG)        /* show all =
tun/tcp/udp reads/writes/opens */
+#define D_PACKET_CONTENT  LOGLEV(9, 70, =
M_DEBUG)        /* show before/after encryption packet content */
+#define =
D_TLS_NO_SEND_KEY LOGLEV(9, 70, M_DEBUG)        /* show when no data channe=
l send-key exists */
+#define D_LINK_RW_VERBOSE LOGLEV(9, 70, M_DEBUG)     =
   /* increase link reads/writes verbosity */
+#define D_STREAM_DEBUG    LO=
GLEV(9, 70, M_DEBUG)        /* show TCP stream debug info */
+#define D_WIN=
32_IO        LOGLEV(9, 70, M_DEBUG)        /* win32 I/O debugging info */
+=
#define D_PKCS11_DEBUG    LOGLEV(9, 70, M_DEBUG)        /* show PKCS#11 deb=
ugging */
 
 #define D_SHAPER_DEBUG LOGLEV(10, 70, M_DEBUG)          /* sho=
w traffic shaper info */
 
diff --git a/src/openvpn/forward=2Ec b/src/openv=
pn/forward=2Ec
index 82cb6c9=2E=2Eba0e0ec 100644
--- a/src/openvpn/forward=
=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -749,14 +749,6 @@
 static void
 proce=
ss_coarse_timers(struct context *c)
 {
-    /* flush current packet-id to f=
ile once per 60
-     * seconds if --replay-persist was specified */
-    i=
f (packet_id_persist_enabled(&c->c1=2Epid_persist)
-        && event_timeou=
t_trigger(&c->c2=2Epacket_id_persist_interval, &c->c2=2Etimeval, ETT_DEFAUL=
T))
-    {
-        packet_id_persist_save(&c->c1=2Epid_persist);
-    }
-
=
     /* Should we write timer-triggered status file */
     if (c->c1=2Esta=
tus_output
         && event_timeout_trigger(&c->c1=2Estatus_output->et, &c=
->c2=2Etimeval, ETT_DEFAULT))
diff --git a/src/openvpn/init=2Ec b/src/openv=
pn/init=2Ec
index c4b6483=2E=2E4247a37 100644
--- a/src/openvpn/init=2Ec
++=
+ b/src/openvpn/init=2Ec
@@ -67,7 +67,6 @@
 /*
  * Crypto initialization fl=
ags
  */
-#define CF_LOAD_PERSISTED_PACKET_ID (1 << 0)
 #define CF_INIT_TLS=
_MULTI           (1 << 1)
 #define CF_INIT_TLS_AUTH_STANDALONE (1 << 2)
 
@=
@ -742,8 +741,6 @@
 {
     context_clear_1(c);
 
-    packet_id_persist_ini=
t(&c->c1=2Epid_persist);
-
     init_connection_list(c);
 
     c->c1=2Elin=
k_sockets_num =3D c->options=2Ece=2Elocal_list->len;
@@ -1351,12 +1348,6 @@=

                                now);
         }
 
-        /* initialize =
packet_id persistence timer */
-        if (c->options=2Epacket_id_file)
- =
       {
-            event_timeout_init(&c->c2=2Epacket_id_persist_interva=
l, 60, now);
-        }
-
         /* initialize tmp_int optimization that =
limits the number of times we call
          * tls_multi_process in the mai=
n event loop */
         interval_init(&c->c2=2Etmp_int, TLS_MULTI_HORIZON,=
 TLS_MULTI_REFRESH);
@@ -2980,31 +2971,15 @@
 }
 
 static void
-init_crypto=
_pre(struct context *c, const unsigned int flags)
-{
-    if (c->options=2E=
engine)
-    {
-        crypto_init_lib_engine(c->options=2Eengine);
-    }=

-
-    if (flags & CF_LOAD_PERSISTED_PACKET_ID)
-    {
-        /* load a =
persisted packet-id for cross-session replay-protection */
-        if (c->=
options=2Epacket_id_file)
-        {
-            packet_id_persist_load(&c=
->c1=2Epid_persist, c->options=2Epacket_id_file);
-        }
-    }
-}
-
-
=
-static void
 do_init_crypto_test(struct context *c)
 {
     const struct o=
ptions *options =3D &c->options;
     ASSERT(options->test_crypto);
 
-    =
init_crypto_pre(c, 0);
+    if (c->options=2Eengine)
+    {
+        crypto=
_init_lib_engine(c->options=2Eengine);
+    }
 
     c->c2=2Ecrypto_options=
=2Eflags |=3D CO_PACKET_ID_LONG_FORM;
 
@@ -3205,7 +3180,10 @@
     ASSERT(=
options->tls_server || options->tls_client);
     ASSERT(!options->test_cry=
pto);
 
-    init_crypto_pre(c, flags);
+    if (c->options=2Eengine)
+    =
{
+        crypto_init_lib_engine(c->options=2Eengine);
+    }
 
     /* Ma=
ke sure we are either a TLS client or server but not both */
     ASSERT(op=
tions->tls_server =3D=3D !options->tls_client);
@@ -3384,7 +3362,6 @@
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
@@ -3943,11 +3920,6 @@
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
@@ -4502,7 +4474,7 @@=

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
@@ -4760,7 +4732,6 @@
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
index 970baa9=2E=2Ead6be88 100644
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
@@ -346,8 +328,6 @@
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
index 454d2d6=2E=2E9ed3964 100644
--- a/src/openvpn/options=2Ec
+=
++ b/src/openvpn/options=2Ec
@@ -571,8 +571,6 @@
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
@@ -7088,7 +708=
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
38554a1=2E=2Eb390ebc 100644
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
index a538b52=2E=2Ecdb94ed 100644
--- a/src/openvpn/ssl=2Ec
+++ b/s=
rc/openvpn/ssl=2Ec
@@ -874,8 +874,6 @@
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
index d66b96d=2E=2E3d27e40 100644
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
Gerrit-PatchSet: 6
Gerrit-Owner: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
G=
errit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Gert Doering <ge=
rt@greenie=2Emuc=2Ede>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenhe=
ld=2Ecom>

--mEycHLnfwIg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, Gert Doering, R=C4=83zvan Cojocaru=
=2E </p>
<p>Arne Schwabe <strong>uploaded patch set #6</strong> to this cha=
nge=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=
=3Demail">View Change</a></p><p>The following approvals got outdated and we=
re removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><p>The change is no lo=
nger submittable: Code-Review and checks~ChecksSubmitRule are unsatisfied n=
ow=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Remove replay-persist<br><br>This feature is very ni=
che and we do not think it is something we<br>should maintain and support g=
oing forward=2E<br><br>This feature saves a single packet id to replay-pers=
ist file=2E<br>This makes the feature only properly work in a p2p setup whe=
re both<br>sides use replay-persist to save the last known packet id from t=
he<br>peer=2E Even then it will only prevent some packet replays until the<=
br>legitimate peer sends a packet again=2E<br><br>In server mode (p2mp) eac=
h client context has its own replay state<br>and saving a single packet id =
is also not very useful with multiple<br>clients and multiple states=2E<br>=
<br>Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815<br>Signed-off-by: =
Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M Changes=2Emd<br>M confi=
g=2Eh=2Ecmake=2Ein<br>M configure=2Eac<br>M doc/man-sections/link-options=
=2Erst<br>M doc/man-sections/tls-options=2Erst<br>M doc/man-sections/unsupp=
orted-options=2Erst<br>M src/openvpn/check_file_access=2Ec<br>M src/openvpn=
/crypto=2Ec<br>M src/openvpn/crypto=2Eh<br>M src/openvpn/errlevel=2Eh<br>M =
src/openvpn/forward=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/openvpn=
=2Eh<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/ope=
nvpn/options_show=2Ec<br>M src/openvpn/packet_id=2Ec<br>M src/openvpn/packe=
t_id=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/syshead=2Eh<br>M src/ope=
nvpn/tls_crypt=2Ec<br>21 files changed, 33 insertions(+), 330 deletions(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/82/2082/6</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/Changes=2Emd b/Changes=2Emd=
</span><br><span>index 7f47f77=2E=2E89a72fe 100644</span><br><span>--- a/Ch=
anges=2Emd</span><br><span>+++ b/Changes=2Emd</span><br><span>@@ -30,6 +30,=
12 @@</span><br><span>   &quot;too complicated&quot;, using `--peer-fingerp=
rint` makes TLS mode about as easy as</span><br><span>   using `--secret`=
=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+* **`replay-persist` has been removed**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  This feature has been removed as it was never properly implemented for=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  server mode and g=
enerally was a niche feature=2E If the option is present</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  it will be ignored=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> ## Maintainer-vi=
sible changes</span><br><span> </span><br><span> - The configure-time optio=
n `--enable-debug` is no longer  available</span><br><span>diff --git a/con=
fig=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein</span><br><span>index 5e06a6=
3=2E=2Ef7818cf 100644</span><br><span>--- a/config=2Eh=2Ecmake=2Ein</span><=
br><span>+++ b/config=2Eh=2Ecmake=2Ein</span><br><span>@@ -285,9 +285,6 @@<=
/span><br><span> /* Define to 1 if you have the &lt;sys/epoll=2Eh&gt; heade=
r file=2E */</span><br><span> #cmakedefine HAVE_SYS_EPOLL_H</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Define to 1 if y=
ou have the &lt;sys/file=2Eh&gt; header file=2E */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#undef HAVE_SYS_FILE_H</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* Define to 1 if you hav=
e the &lt;sys/inotify=2Eh&gt; header file=2E */</span><br><span> #cmakedefi=
ne HAVE_SYS_INOTIFY_H</span><br><span> </span><br><span>diff --git a/config=
ure=2Eac b/configure=2Eac</span><br><span>index 5f18798=2E=2E9326c4e 100644=
</span><br><span>--- a/configure=2Eac</span><br><span>+++ b/configure=2Eac<=
/span><br><span>@@ -453,7 +453,7 @@</span><br><span> ])</span><br><span> AC=
_CHECK_HEADERS([ \</span><br><span> 	sys/time=2Eh sys/ioctl=2Eh sys/stat=2E=
h \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	sys/mman=2Eh sys/=
file=2Eh sys/wait=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+	sys/mman=2Eh sys/wait=2Eh \</span><br><span> 	libgen=2Eh stropts=2Eh \=
</span><br><span> 	syslog=2Eh pwd=2Eh grp=2Eh \</span><br><span> 	sys/socki=
o=2Eh sys/uio=2Eh \</span><br><span>@@ -561,8 +561,7 @@</span><br><span> AC=
_CHECK_FUNCS([ \</span><br><span> 	daemon chroot getpwnam setuid nice dup d=
up2 \</span><br><span> 	syslog openlog mlockall getrlimit getgrnam setgid \=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	setgroups flock gett=
imeofday \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	setsid chd=
ir \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	setgroups gett=
imeofday setsid chdir \</span><br><span> 	chsize ftruncate execve getpeerei=
d basename dirname \</span><br><span> 	epoll_create strlcpy strsep strtok_r=
 \</span><br><span> ])</span><br><span>diff --git a/doc/man-sections/link-o=
ptions=2Erst b/doc/man-sections/link-options=2Erst</span><br><span>index 73=
5ee51=2E=2Ebbdcf7f 100644</span><br><span>--- a/doc/man-sections/link-optio=
ns=2Erst</span><br><span>+++ b/doc/man-sections/link-options=2Erst</span><b=
r><span>@@ -440,19 +440,6 @@</span><br><span>   physical IP layer=2E The pr=
oblem is easily fixed by simply using TCP as</span><br><span>   the VPN tra=
nsport layer=2E</span><br><span> </span><br><span>---replay-persist file</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-  Persist replay-protect=
ion state across sessions using ``file`` to save</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-  and reload the state=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  This option will keep a disk copy of the current replay protec=
tion state</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  (i=2Ee=2E=
 the most recent packet timestamp and sequence number received from</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  the remote peer), so that i=
f an OpenVPN session is stopped and</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-  restarted, it will reject any replays of packets which were=
 already</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  received by=
 the prior session=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  This option only ma=
kes sense when replay protection is enabled (the</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-  default) and you are using TLS mode with ``--t=
ls-auth``=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span> --session-timeout n</span><br><span>   Raises :code:`SIGTERM` for =
the client instance after ``n`` seconds since</span><br><span>   the beginn=
ing of the session, forcing OpenVPN to disconnect=2E</span><br><span>diff -=
-git a/doc/man-sections/tls-options=2Erst b/doc/man-sections/tls-options=2E=
rst</span><br><span>index c4aa810=2E=2Ede4d324 100644</span><br><span>--- a=
/doc/man-sections/tls-options=2Erst</span><br><span>+++ b/doc/man-sections/=
tls-options=2Erst</span><br><span>@@ -370,10 +370,7 @@</span><br><span>   l=
evel has had a chance to authenticate the peer=2E The result is that</span>=
<br><span>   packets without the correct signature can be dropped immediate=
ly upon</span><br><span>   reception, before they have a chance to consume =
additional system</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  re=
sources such as by initiating a TLS handshake=2E ``--tls-auth`` can be</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-  strengthened by adding t=
he ``--replay-persist`` option which will keep</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-  OpenVPN&#39;s replay protection state in a file =
so that it is not lost</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  across restarts=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  resources such as by initiating a TLS handshake=2E</span><br><span> </s=
pan><br><span>   It should be emphasized that this feature is optional and =
that the key</span><br><span>   file used with ``--tls-auth`` gives a peer =
nothing more than the power</span><br><span>diff --git a/doc/man-sections/u=
nsupported-options=2Erst b/doc/man-sections/unsupported-options=2Erst</span=
><br><span>index 2794f12=2E=2E368805e 100644</span><br><span>--- a/doc/man-=
sections/unsupported-options=2Erst</span><br><span>+++ b/doc/man-sections/u=
nsupported-options=2Erst</span><br><span>@@ -79,3 +79,8 @@</span><br><span>=
 </span><br><span> --allow-deprecated-insecure-static-crypto</span><br><spa=
n>   Removed in OpenVPN 2=2E8 as --secret was also removed=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+--replay-persist</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  Removed in OpenVPN 2=2E8=2E This option never really =
worked well with ``--server``</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  and the usefulness of this option in p2p setups is not very hig=
h either=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  It is =
now ignored if present in the configuration file=2E</span><br><span>diff --=
git a/src/openvpn/check_file_access=2Ec b/src/openvpn/check_file_access=2Ec=
</span><br><span>index ab2535d=2E=2Ebe9b4b2 100644</span><br><span>--- a/sr=
c/openvpn/check_file_access=2Ec</span><br><span>+++ b/src/openvpn/check_fil=
e_access=2Ec</span><br><span>@@ -312,9 +312,6 @@</span><br><span>          =
                                ce-&gt;tls_crypt_v2_file, R_OK, &quot;--tls=
-crypt-v2&quot;);</span><br><span>     }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check_file_access(CHKACC=
_DIRPATH | CHKACC_FILEXSTWR, options-&gt;packet_id_file,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                              R_OK | W_O=
K, &quot;--replay-persist&quot;);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span>     /* ** Password files ** */</span><br><spa=
n>     errs |=3D check_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_=
PRIVATE,</span><br><span>                               options-&gt;key_pas=
s_file, R_OK, &quot;--askpass&quot;);</span><br><span>diff --git a/src/open=
vpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index a8ad7f0=2E=2E=
6efa005 100644</span><br><span>--- a/src/openvpn/crypto=2Ec</span><br><span=
>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -403,10 +403,6 @@</span><b=
r><span>     if (packet_id_test(recv, pin))</span><br><span>     {</span><b=
r><span>         packet_id_add(recv, pin);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (opt-&gt;pid_persist &amp;&amp; (opt-&gt;fl=
ags &amp; CO_PACKET_ID_LONG_FORM))</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            packet_id_persist_save_obj(opt-&gt;pid_persist, &amp;opt-&gt;p=
acket_id);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</=
span><br><span>         ret =3D true;</span><br><span>     }</span><br><spa=
n>     else</span><br><span>diff --git a/src/openvpn/crypto=2Eh b/src/openv=
pn/crypto=2Eh</span><br><span>index 5212e17=2E=2E81b8352 100644</span><br><=
span>--- a/src/openvpn/crypto=2Eh</span><br><span>+++ b/src/openvpn/crypto=
=2Eh</span><br><span>@@ -333,11 +333,6 @@</span><br><span>                 =
                 *   The packet id also used as the IV</span><br><span>    =
                              *   for AEAD/OFB/CFG ciphers=2E</span><br><sp=
an>                                  */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    struct packet_id_persist *pid_persist;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    /**&lt; Persistent packet ID sta=
te for</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     *   keepin=
g state between successive</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-     *   OpenVPN process startups=2E */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span> #define CO_PACKET_ID_LONG_FORM    =
     (1u &lt;&lt; 0)</span><br><span>     /**&lt; Bit-flag indicating wheth=
er to use</span><br><span>      *   OpenVPN&#39;s long packet ID format=2E =
*/</span><br><span>diff --git a/src/openvpn/errlevel=2Eh b/src/openvpn/errl=
evel=2Eh</span><br><span>index e52cb65=2E=2E5cea0ad 100644</span><br><span>=
--- a/src/openvpn/errlevel=2Eh</span><br><span>+++ b/src/openvpn/errlevel=
=2Eh</span><br><span>@@ -64,7 +64,6 @@</span><br><span> #define D_MULTI_ERR=
ORS   LOGLEV(1, 9, M_NONFATAL)  /* show multi-client server errors */</span=
><br><span> #define D_EVENT_ERRORS   LOGLEV(1, 10, M_NONFATAL) /* show even=
t=2E[ch] errors */</span><br><span> #define D_PUSH_ERRORS    LOGLEV(1, 11, =
M_NONFATAL) /* show push/pull errors */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#define D_PID_PERSIST    LOGLEV(1, 12, M_NONFATAL) /* sho=
w packet_id persist errors */</span><br><span> #define D_FRAG_ERRORS    LOG=
LEV(1, 13, M_NONFATAL) /* show fragmentation errors */</span><br><span> #de=
fine D_ALIGN_ERRORS   LOGLEV(1, 14, M_NONFATAL) /* show bad struct alignmen=
ts */</span><br><span> </span><br><span>@@ -159,16 +158,15 @@</span><br><sp=
an> #define D_EVENT_WAIT        LOGLEV(8, 70, M_DEBUG)      /* show detaile=
d info from event waits */</span><br><span> #define D_MULTI_TCP         LOG=
LEV(8, 70, M_DEBUG)      /* show debug info from mtcp=2Ec */</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_TLS_DEBU=
G         LOGLEV(9, 70, M_DEBUG)      /* show detailed info from TLS routin=
es */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_COMP  =
            LOGLEV(9, 70, M_DEBUG)      /* show compression info */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_READ_WRITE        L=
OGLEV(9, 70, M_DEBUG)      /* show all tun/tcp/udp reads/writes/opens */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_PACKET_CONTENT=
    LOGLEV(9, 70, M_DEBUG)      /* show before/after encryption packet cont=
ent */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_TLS_N=
O_SEND_KEY   LOGLEV(9, 70, M_DEBUG)      /* show when no data channel send-=
key exists */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define =
D_PID_PERSIST_DEBUG LOGLEV(9, 70, M_DEBUG)      /* show packet-id persist d=
ebugging info */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defi=
ne D_LINK_RW_VERBOSE   LOGLEV(9, 70, M_DEBUG)      /* increase link reads/w=
rites verbosity */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#de=
fine D_STREAM_DEBUG      LOGLEV(9, 70, M_DEBUG)      /* show TCP stream deb=
ug info */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_W=
IN32_IO          LOGLEV(9, 70, M_DEBUG)      /* win32 I/O debugging info */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_PKCS11_DEBU=
G      LOGLEV(9, 70, M_DEBUG)      /* show PKCS#11 debugging */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define D_TLS_DEBUG       LOGLE=
V(9, 70, M_DEBUG)        /* show detailed info from TLS routines */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_COMP            L=
OGLEV(9, 70, M_DEBUG)        /* show compression info */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define D_READ_WRITE      LOGLEV(9, 70=
, M_DEBUG)        /* show all tun/tcp/udp reads/writes/opens */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define D_PACKET_CONTENT  LOGLE=
V(9, 70, M_DEBUG)        /* show before/after encryption packet content */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_TLS_NO_SEN=
D_KEY LOGLEV(9, 70, M_DEBUG)        /* show when no data channel send-key e=
xists */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_L=
INK_RW_VERBOSE LOGLEV(9, 70, M_DEBUG)        /* increase link reads/writes =
verbosity */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 D_STREAM_DEBUG    LOGLEV(9, 70, M_DEBUG)        /* show TCP stream debug i=
nfo */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_WIN=
32_IO        LOGLEV(9, 70, M_DEBUG)        /* win32 I/O debugging info */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_PKCS11_DEBU=
G    LOGLEV(9, 70, M_DEBUG)        /* show PKCS#11 debugging */</span><br><=
span> </span><br><span> #define D_SHAPER_DEBUG LOGLEV(10, 70, M_DEBUG)     =
     /* show traffic shaper info */</span><br><span> </span><br><span>diff =
--git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>i=
ndex 82cb6c9=2E=2Eba0e0ec 100644</span><br><span>--- a/src/openvpn/forward=
=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -749,=
14 +749,6 @@</span><br><span> static void</span><br><span> process_coarse_t=
imers(struct context *c)</span><br><span> {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    /* flush current packet-id to file once per 60</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-     * seconds if --repl=
ay-persist was specified */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (packet_id_persist_enabled(&amp;c-&gt;c1=2Epid_persist)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; event_tim=
eout_trigger(&amp;c-&gt;c2=2Epacket_id_persist_interval, &amp;c-&gt;c2=2Eti=
meval, ETT_DEFAULT))</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        packet_id=
_persist_save(&amp;c-&gt;c1=2Epid_persist);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span>     /* Should we write timer-triggered status file =
*/</span><br><span>     if (c-&gt;c1=2Estatus_output</span><br><span>      =
   &amp;&amp; event_timeout_trigger(&amp;c-&gt;c1=2Estatus_output-&gt;et, &=
amp;c-&gt;c2=2Etimeval, ETT_DEFAULT))</span><br><span>diff --git a/src/open=
vpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index c4b6483=2E=2E4247=
a37 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b=
/src/openvpn/init=2Ec</span><br><span>@@ -67,7 +67,6 @@</span><br><span> /*=
</span><br><span>  * Crypto initialization flags</span><br><span>  */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CF_LOAD_PERSISTED_P=
ACKET_ID (1 &lt;&lt; 0)</span><br><span> #define CF_INIT_TLS_MULTI         =
  (1 &lt;&lt; 1)</span><br><span> #define CF_INIT_TLS_AUTH_STANDALONE (1 &l=
t;&lt; 2)</span><br><span> </span><br><span>@@ -742,8 +741,6 @@</span><br><=
span> {</span><br><span>     context_clear_1(c);</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    packet_id_persist_init(&am=
p;c-&gt;c1=2Epid_persist);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span>     init_connection_list(c);</span><br><span> </span=
><br><span>     c-&gt;c1=2Elink_sockets_num =3D c-&gt;options=2Ece=2Elocal_=
list-&gt;len;</span><br><span>@@ -1351,12 +1348,6 @@</span><br><span>      =
                          now);</span><br><span>         }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* initializ=
e packet_id persistence timer */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (c-&gt;options=2Epacket_id_file)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            event_timeout_init(&amp;c-&gt;c2=2Epacket_=
id_persist_interval, 60, now);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span>         /* initialize tmp_int optimization that limits the n=
umber of times we call</span><br><span>          * tls_multi_process in the=
 main event loop */</span><br><span>         interval_init(&amp;c-&gt;c2=2E=
tmp_int, TLS_MULTI_HORIZON, TLS_MULTI_REFRESH);</span><br><span>@@ -2980,31=
 +2971,15 @@</span><br><span> }</span><br><span> </span><br><span> static v=
oid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-init_crypto_pre(st=
ruct context *c, const unsigned int flags)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (c-&gt;options=2Eengine)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   crypto_init_lib_engine(c-&gt;options=2Eengine);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
flags &amp; CF_LOAD_PERSISTED_PACKET_ID)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        /* load a persisted packet-id for cross-session replay-protectio=
n */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (c-&gt=
;options=2Epacket_id_file)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     packet_id_persist_load(&amp;c-&gt;c1=2Epid_persist, c-&gt;options=2Epa=
cket_id_file);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br>=
<span> do_init_crypto_test(struct context *c)</span><br><span> {</span><br>=
<span>     const struct options *options =3D &amp;c-&gt;options;</span><br>=
<span>     ASSERT(options-&gt;test_crypto);</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    init_crypto_pre(c, 0);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;options=2Eengi=
ne)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        crypto_init_lib_engine=
(c-&gt;options=2Eengine);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span> </span><br><span>     c-&gt;c2=2Ecrypto_option=
s=2Eflags |=3D CO_PACKET_ID_LONG_FORM;</span><br><span> </span><br><span>@@=
 -3205,7 +3180,10 @@</span><br><span>     ASSERT(options-&gt;tls_server || =
options-&gt;tls_client);</span><br><span>     ASSERT(!options-&gt;test_cryp=
to);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    init_crypto_pre(c, flags);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (c-&gt;options=2Eengine)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        crypto_init_lib_engine(c-&gt;options=2Eengine);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span=
><br><span>     /* Make sure we are either a TLS client or server but not b=
oth */</span><br><span>     ASSERT(options-&gt;tls_server =3D=3D !options-&=
gt;tls_client);</span><br><span>@@ -3384,7 +3362,6 @@</span><br><span>     =
if (to=2Etls_wrap=2Emode =3D=3D TLS_WRAP_AUTH || to=2Etls_wrap=2Emode =3D=
=3D TLS_WRAP_CRYPT)</span><br><span>     {</span><br><span>         to=2Etl=
s_wrap=2Eopt=2Ekey_ctx_bi =3D c-&gt;c1=2Eks=2Etls_wrap_key;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        to=2Etls_wrap=2Eopt=2Epid_per=
sist =3D &amp;c-&gt;c1=2Epid_persist;</span><br><span>         to=2Etls_wra=
p=2Eopt=2Eflags |=3D CO_PACKET_ID_LONG_FORM;</span><br><span>         to=2E=
tls_wrap=2Eoriginal_wrap_keydata =3D c-&gt;c1=2Eks=2Eoriginal_wrap_keydata;=
</span><br><span>     }</span><br><span>@@ -3943,11 +3920,6 @@</span><br><s=
pan> do_close_packet_id(struct context *c)</span><br><span> {</span><br><sp=
an>     packet_id_free(&amp;c-&gt;c2=2Ecrypto_options=2Epacket_id);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    packet_id_persist_save(&a=
mp;c-&gt;c1=2Epid_persist);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (!(c-&gt;sig-&gt;signal_received =3D=3D SIGUSR1))</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        packet_id_persist_close(&amp;c-&gt;c1=2Epi=
d_persist);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span> }</span><br><span> </span><br><span> #ifdef ENABLE_FRAGMENT</s=
pan><br><span>@@ -4502,7 +4474,7 @@</span><br><span>         }</span><br><s=
pan>         else if (c-&gt;mode =3D=3D CM_P2P)</span><br><span>         {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            crypto_fla=
gs =3D CF_LOAD_PERSISTED_PACKET_ID | CF_INIT_TLS_MULTI;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            crypto_flags =3D CF_INIT_TL=
S_MULTI;</span><br><span>         }</span><br><span>         else if (child=
)</span><br><span>         {</span><br><span>@@ -4760,7 +4732,6 @@</span><b=
r><span>     ALLOC_OBJ_CLEAR_GC(dest-&gt;sig, struct signal_info, &amp;dest=
-&gt;gc);</span><br><span> </span><br><span>     /* c1 init */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    packet_id_persist_init(&amp;de=
st-&gt;c1=2Epid_persist);</span><br><span>     dest-&gt;c1=2Elink_sockets_n=
um =3D 1;</span><br><span>     do_link_socket_addr_new(dest);</span><br><sp=
an> </span><br><span>diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/ope=
nvpn=2Eh</span><br><span>index 970baa9=2E=2Ead6be88 100644</span><br><span>=
--- a/src/openvpn/openvpn=2Eh</span><br><span>+++ b/src/openvpn/openvpn=2Eh=
</span><br><span>@@ -75,21 +75,6 @@</span><br><span> };</span><br><span> </=
span><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
struct packet_id_persist should be empty if we are not</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * building with crypto=2E</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#ifndef PACKET_ID_H</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-struct packet_id_persist</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    int dummy;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-packet_id_persist_init(struc=
t packet_id_persist *p)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-/*</span><br><span>  * Packet processing buffers=2E</span><br><span>  */</=
span><br><span> struct context_buffers</span><br><span>@@ -167,9 +152,6 @@<=
/span><br><span>     /* preresolved and cached host names */</span><br><spa=
n>     struct cached_dns_entry *dns_cache;</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    /* persist crypto sequence numbe=
r to/from file */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
struct packet_id_persist pid_persist;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span>     struct tuntap *tuntap; /**&lt; Tun/ta=
p virtual network interface=2E */</span><br><span>     bool tuntap_owned;  =
   /**&lt; Whether the tun/tap interface should</span><br><span>           =
                  *   be cleaned up when this %context is</span><br><span>@=
@ -346,8 +328,6 @@</span><br><span>      *   Channel Crypto module\endlink =
to</span><br><span>      *   process data channel packet=2E */</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct event=
_timeout packet_id_persist_interval;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span> #ifdef USE_COMP</span><br><span>     struc=
t compress_context *comp_context;</span><br><span>     /**&lt; Compression =
context used by the</span><br><span>diff --git a/src/openvpn/options=2Ec b/=
src/openvpn/options=2Ec</span><br><span>index 454d2d6=2E=2E9ed3964 100644</=
span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/open=
vpn/options=2Ec</span><br><span>@@ -571,8 +571,6 @@</span><br><span>     &q=
uot;--replay-window n [t]  : Use a replay protection sliding window of size=
 n\n&quot;</span><br><span>     &quot;                         and a time w=
indow of t seconds=2E\n&quot;</span><br><span>     &quot;                  =
       Default n=3D%d t=3D%d\n&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    &quot;--replay-persist file : Persist replay-protection =
state across sessions\n&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    &quot;                  using file=2E\n&quot;</span><br><span> =
    &quot;--test-crypto   : Run a self-test of crypto features enabled=2E\n=
&quot;</span><br><span>     &quot;                  For debugging only=2E\n=
&quot;</span><br><span>     &quot;\n&quot;</span><br><span>@@ -7088,7 +7086=
,7 @@</span><br><span>     else if (streq(p[0], &quot;replay-persist&quot;)=
 &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span> =
        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        options-&gt;packet_id_file =3D p[1];</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;DEPR=
ECATED OPTION: --replay-persist option ignored=2E&quot;);</span><br><span> =
    }</span><br><span>     else if (streq(p[0], &quot;test-crypto&quot;) &a=
mp;&amp; !p[1])</span><br><span>     {</span><br><span>diff --git a/src/ope=
nvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index 38554a1=2E=
=2Eb390ebc 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><=
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
<br><span>index a538b52=2E=2Ecdb94ed 100644</span><br><span>--- a/src/openv=
pn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -87=
4,8 +874,6 @@</span><br><span>     packet_id_init(&amp;ks-&gt;crypto_option=
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
><br><span>index d66b96d=2E=2E3d27e40 100644</span><br><span>--- a/src/open=
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
 style=3D"display:none"> Gerrit-PatchSet: 6 </div>
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
yle=3D"display:none"> Gerrit-Attention: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--mEycHLnfwIg=--


--===============5537414754310797535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5537414754310797535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5537414754310797535==--

