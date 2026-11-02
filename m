Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F191606A324
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KoQVUnSk;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jEKwkape;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XvUQL0L/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=L3qJzC6J
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=OizWjUYJo477S8yGrnsbihMw4vOus20RbZ57HKCDYJU=; b=KoQVUnSksKxY2Tpo7zpEs5HflF
	FJ8/Gxwzggenz4OWGAtwVJGcxRw/65VspIf7Iz42VIfXKrwp+0yhQFmSyh3lnYRnsFq/FQvwjjd45
	v3K9nWr5akOoFetCSfEcLkkRnyLgpGtORSs+OfrKehQdEKTUu9HmSQdnVF5NX+PNADK8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNq2d-000000003Hs-0KoU;
	Mon, 02 Nov 2026 11:17:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNq2b-000000003Hk-3cen
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 11:17:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3fl2lhBJsgMnER9w3y1iGo46TdT7ZPK/8GFDA/4Qx8s=; b=jEKwkape5Kc7GcZPEKwNIXo4uW
 npdf9Y6/3ltiMwB664MDDiTDpKdNOuFwFkCUe9zb4fTtP5/2ViYPC3hf24JoZYg6BLokAVgDU4j+T
 f+r8I2ACJVKE0YDw4IOLcQb0CcRsi9z49Vmz0PXA8AsEkcDNxigqW9TcWeE5Ulk8ivEk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3fl2lhBJsgMnER9w3y1iGo46TdT7ZPK/8GFDA/4Qx8s=; b=XvUQL0L/q78W+h5qTjV2987EP3
 qp/dnLnoU2bADD0pbtUrtpeHj2+ZSKxLB968Pf71LkVpC5ZjjDzHfCBuctae9H5jtKQtiZuy15Jy7
 Z5bHkK4gcDCgYFNwfOOAYrrIZCPRDzqeQjHriub98b74jbhzGlc8L9olhN8l8TvHPX1g=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNq2Y-000000004VU-0VAB for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 11:17:29 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4afe2d546f9so11721775e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 03:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793618239; x=1794223039; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3fl2lhBJsgMnER9w3y1iGo46TdT7ZPK/8GFDA/4Qx8s=;
 b=L3qJzC6Je0ZG1yZG3NlYt/kOyd/y9hka+8smtx6HRFocilZ8DAF9uFUKcM3wRyAqgW
 908lSIC+6aucmxvXr6kqWKQGtY0ak+Quxn5vtUlookwTNd+uNH7x+q+5MesOr6ieevJO
 Xr4JGECl28gYimj7FsRTP48f8ehBslUevK8rSE6t8WbuyJjZgvYyKEElraUamZt6MXrT
 Zp24CZWtL/4uDSWxQYmkVHu01FDGeRTR0oygJ57F5hv6RIitL/HRQObjeu44DIpiBuj8
 YNrT6cJKXKhFj3wGVw/F8H8W6xT5FfO3S0qGgaHmgSo+XN30yH2QuaXsdP8DmW2mhP/+
 wRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793618239; x=1794223039;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3fl2lhBJsgMnER9w3y1iGo46TdT7ZPK/8GFDA/4Qx8s=;
 b=A64UoSJXNbkBoZ5kZDpmtIK94jYLJ+lgp3dLz+SnXwAeD+r6wN865nDgVZ0aZn8TWS
 3qM+M/zaoICuJsX/vvz9X/G0FaunHhoupg5lROB7ocOaukhYqncnYoK3HAxh8DJ6gWim
 VL8H6kjL39t/zlr9Hu8hPlhhyUlai5s2DLjyfmXJ6HFaIeqVG0uxZ8OhlU+0T8WOmhiB
 8C7sgMJfHIwKXv8aHFDlYCm2K9ZJPjKoHVb8ZURiqVfa9r/aYIFAswErtf3p8Jbzzglo
 NGabQcMMv3pZfar8ebQTHXvR57GFvfg9gmBAxCoZ+O1E1RuXnppmyIy3w4alacPh5Mty
 sDmg==
X-Gm-Message-State: AFq9FYKU4Aav0wHqJDs/QO7yxMyL2ICZVW+/kdKbVnnOD8O1QVNBqM4M
 M+Nc4Pvp3wfKjbZDbaX0qhKUMIgohDGf2ohc6Ix+GSyq8b6ML2B+FovzaO80aby3AtGg2i4TKYH
 flHh0hRqwaneam67eXSiyo7YbtQXF3jJBcZDQNpscP8bww/qG69BmkNngoKwqT4j7Py8If2UIbL
 6DbpepdA==
X-Gm-Gg: AYBFou1m+CqMJ2A3BjeB3DHABhzVkIYWEdNZgMDpaSr1na3AtXNDxXo5zfqp1GD7XIC
 RpGAijDWvUY8AQ8a7GgjjmpNUu/Wp4wb/02kudY16NApXA8/RyJe/uBJ6NcILWw3f00zF9/h8Yq
 FZHDmIBBRvPfbQh+8TOxy5ks0yzZ0dk8Tn/r1gMdY3z4FtfDx7A7GRf0LDYK2eDQlYM+bnXg6XC
 h1FBUjpdGrcmqNyhtdiuIeUtjaRgz7WhFBn/2NYBpmLMqh5B4j/c+s6jBddPCQa0msIN3SJUbKD
 yfN1y1pZ8wUUxz4SpcKGjpmhKXzbBiS69K7Y+S73rFGtJJvGMqYM/6Tkau3gTuB0BU1DnS3+LAc
 S7d2T10GwqeYlsSoII5np0vdB3c2hN0cHe6gcdduBfCTGzbCSo2RenOnh29AwPuOpLXXVBMdFs0
 LzIGdt2MXBaHUqxMVofAvk2Pa5aCq+MjBRTLFuOrHolORHIs0gQQCAS/vkpmn3farLP8Jklc8qf
 apaIaUwC9CfBiKuCniFtjbNa1ZZ/YvFJgdfpkonWjOYNZ8Wx7cfkvGnqeKRKYaR9G9toHwMQMrW
 dp7Svsu4vQNS4q7P4mAkv8mandXy+wLed0YGgZf1lC2oGTJD/DsJvnejmF5m/LObZZMSJo4YMH3
 EqpfgWJmIJybO3sXnhXFwQ1EL3DebpRBym5n2zs7H0xTr3LZhGfPQ2jA4rOLOD3xlgSXcTcnWws
 6QppqKBRc+aLT5Y/JlkmmAzGSqCPI4t85ogMM=
X-Received: by 2002:a05:600c:e547:10b0:4ad:5e09:ae43 with SMTP id
 5b1f17b1804b1-4ad5e09ae61mr90530345e9.29.1793618238853; 
 Mon, 02 Nov 2026 03:17:18 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09bcc967sm199238735e9.3.2026.11.02.03.17.18
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 03:17:18 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 11:17:17 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815
X-Gerrit-Change-Number: 2082
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2082?usp=email>
X-Gerrit-Commit: 2c288d527374c38f44541b24f54c56ede74f9750
References: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkk1ZWUyMzFkMTU3NDU5ZTY0MDZmMWY0YzEyY2Q2YzZlMGZjZTkzODE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <01b221e0bce802fc4d83d022333701739960036f-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xNq2Y-000000004VU-0VAB
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0357332605839835392=="
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0357332605839835392==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6WKPEoPTLXY="; charset=UTF-8

--6WKPEoPTLXY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has uploaded this change for review=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2082?usp=3Demail )


Change subject: Remove replay-pe=
rsist
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove =
replay-persist

This feature is very niche and we do not think it is someth=
ing we
should maintain and support going forward=2E

This features saves a =
single packet id to the persist-replay file=2E
This makes the feature only =
properly work in a p2p setup where both
sides use replay-persist to save th=
e last known packet id from the
peer=2E Even then it will only prevent some=
 packet replays until the
legitimate peer sends a packet again=2E

In serve=
r mode (p2mp) each client context has its own replay state
and saving a sin=
gle packet id is also not very useful with multiple
clients and multiple st=
ates=2E

Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815
Signed-off-by=
: Arne Schwabe <arne@rfc2549=2Eorg>
---
M Changes=2Emd
M configure=2Eac
M d=
oc/man-sections/link-options=2Erst
M doc/man-sections/tls-options=2Erst
M s=
rc/openvpn/check_file_access=2Ec
M src/openvpn/crypto=2Ec
M src/openvpn/cry=
pto=2Eh
M src/openvpn/errlevel=2Eh
M src/openvpn/forward=2Ec
M src/openvpn/=
init=2Ec
M src/openvpn/openvpn=2Eh
M src/openvpn/options=2Ec
M src/openvpn/=
options=2Eh
M src/openvpn/options_show=2Ec
M src/openvpn/packet_id=2Ec
M sr=
c/openvpn/packet_id=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/tls_crypt=2Ec
1=
8 files changed, 19 insertions(+), 310 deletions(-)



  git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/82/2082/1

diff --git a/Chan=
ges=2Emd b/Changes=2Emd
index dd12391=2E=2E093cdae 100644
--- a/Changes=2Em=
d
+++ b/Changes=2Emd
@@ -29,7 +29,12 @@
   today's requirements=2E Use TLS =
mode instead=2E If deploying a PKI CA is considered
   "too complicated", u=
sing `--peer-fingerprint` makes TLS mode about as easy as
   using `--secre=
t`=2E
- 
+
+* **`replay-persist` has been removed**
+
+  This feature has b=
een removed as it was never properly implemented for
+  server mode and gen=
erally was a nice feature=2E
+
 ## Maintainer-visible changes
 
 - The conf=
igure-time option `--enable-debug` is no longer  available
diff --git a/con=
figure=2Eac b/configure=2Eac
index 5f18798=2E=2Eae9396c 100644
--- a/config=
ure=2Eac
+++ b/configure=2Eac
@@ -561,8 +561,7 @@
 AC_CHECK_FUNCS([ \
 	dae=
mon chroot getpwnam setuid nice dup dup2 \
 	syslog openlog mlockall getrli=
mit getgrnam setgid \
-	setgroups flock gettimeofday \
-	setsid chdir \
+	s=
etgroups gettimeofday setsid chdir \
 	chsize ftruncate execve getpeereid b=
asename dirname \
 	epoll_create strlcpy strsep strtok_r \
 ])
diff --git a=
/doc/man-sections/link-options=2Erst b/doc/man-sections/link-options=2Erst
=
index 735ee51=2E=2Ebbdcf7f 100644
--- a/doc/man-sections/link-options=2Erst=

+++ b/doc/man-sections/link-options=2Erst
@@ -440,19 +440,6 @@
   physical=
 IP layer=2E The problem is easily fixed by simply using TCP as
   the VPN =
transport layer=2E
 
---replay-persist file
-  Persist replay-protection st=
ate across sessions using ``file`` to save
-  and reload the state=2E
-
-  =
This option will keep a disk copy of the current replay protection state
- =
 (i=2Ee=2E the most recent packet timestamp and sequence number received fr=
om
-  the remote peer), so that if an OpenVPN session is stopped and
-  res=
tarted, it will reject any replays of packets which were already
-  receive=
d by the prior session=2E
-
-  This option only makes sense when replay pro=
tection is enabled (the
-  default) and you are using TLS mode with ``--tls=
-auth``=2E
-
 --session-timeout n
   Raises :code:`SIGTERM` for the client =
instance after ``n`` seconds since
   the beginning of the session, forcing=
 OpenVPN to disconnect=2E
diff --git a/doc/man-sections/tls-options=2Erst b=
/doc/man-sections/tls-options=2Erst
index c4aa810=2E=2Ede4d324 100644
--- a=
/doc/man-sections/tls-options=2Erst
+++ b/doc/man-sections/tls-options=2Ers=
t
@@ -370,10 +370,7 @@
   level has had a chance to authenticate the peer=
=2E The result is that
   packets without the correct signature can be drop=
ped immediately upon
   reception, before they have a chance to consume add=
itional system
-  resources such as by initiating a TLS handshake=2E ``--tl=
s-auth`` can be
-  strengthened by adding the ``--replay-persist`` option w=
hich will keep
-  OpenVPN's replay protection state in a file so that it is=
 not lost
-  across restarts=2E
+  resources such as by initiating a TLS ha=
ndshake=2E
 
   It should be emphasized that this feature is optional and t=
hat the key
   file used with ``--tls-auth`` gives a peer nothing more than=
 the power
diff --git a/src/openvpn/check_file_access=2Ec b/src/openvpn/che=
ck_file_access=2Ec
index 90dbb4e=2E=2E09635cb 100644
--- a/src/openvpn/chec=
k_file_access=2Ec
+++ b/src/openvpn/check_file_access=2Ec
@@ -312,9 +312,6 =
@@
                                          ce->tls_crypt_v2_file, R_OK, "=
--tls-crypt-v2");
     }
 
-    errs |=3D check_file_access(CHKACC_DIRPATH =
| CHKACC_FILEXSTWR, options->packet_id_file,
-                             =
 R_OK | W_OK, "--replay-persist");
-
     /* ** Password files ** */
     e=
rrs |=3D check_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,=

                               options->key_pass_file, R_OK, "--askpass");=

diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index c18c724=
=2E=2Eb94f57c 100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=
=2Ec
@@ -403,10 +403,6 @@
     if (packet_id_test(recv, pin))
     {
      =
   packet_id_add(recv, pin);
-        if (opt->pid_persist && (opt->flags &=
 CO_PACKET_ID_LONG_FORM))
-        {
-            packet_id_persist_save_ob=
j(opt->pid_persist, &opt->packet_id);
-        }
         ret =3D true;
   =
  }
     else
diff --git a/src/openvpn/crypto=2Eh b/src/openvpn/crypto=2Eh
=
index 203f77b=2E=2E4962835 100644
--- a/src/openvpn/crypto=2Eh
+++ b/src/op=
envpn/crypto=2Eh
@@ -339,11 +339,6 @@
                                  *  =
 The packet id also used as the IV
                                  *   fo=
r AEAD/OFB/CFG ciphers=2E
                                  */
-    struct =
packet_id_persist *pid_persist;
-    /**< Persistent packet ID state for
- =
    *   keeping state between successive
-     *   OpenVPN process startups=
=2E */
-
 #define CO_PACKET_ID_LONG_FORM         (1u << 0)
     /**< Bit-fl=
ag indicating whether to use
      *   OpenVPN's long packet ID format=2E *=
/
diff --git a/src/openvpn/errlevel=2Eh b/src/openvpn/errlevel=2Eh
index d7=
9efbb=2E=2E60d20ad 100644
--- a/src/openvpn/errlevel=2Eh
+++ b/src/openvpn/=
errlevel=2Eh
@@ -64,7 +64,6 @@
 #define D_MULTI_ERRORS   LOGLEV(1, 9, M_NON=
FATAL)   /* show multi-client server errors */
 #define D_EVENT_ERRORS   LO=
GLEV(1, 10, M_NONFATAL)  /* show event=2E[ch] errors */
 #define D_PUSH_ERR=
ORS    LOGLEV(1, 11, M_NONFATAL)  /* show push/pull errors */
-#define D_PI=
D_PERSIST    LOGLEV(1, 12, M_NONFATAL)  /* show packet_id persist errors */=

 #define D_FRAG_ERRORS    LOGLEV(1, 13, M_NONFATAL)  /* show fragmentation=
 errors */
 #define D_ALIGN_ERRORS   LOGLEV(1, 14, M_NONFATAL)  /* show bad=
 struct alignments */
 
@@ -161,16 +160,15 @@
 #define D_EVENT_WAIT        =
LOGLEV(8, 70, M_DEBUG)      /* show detailed info from event waits */
 #def=
ine D_MULTI_TCP         LOGLEV(8, 70, M_DEBUG)      /* show debug info from=
 mtcp=2Ec */
 
-#define D_TLS_DEBUG         LOGLEV(9, 70, M_DEBUG)      /* =
show detailed info from TLS routines */
-#define D_COMP              LOGLEV=
(9, 70, M_DEBUG)      /* show compression info */
-#define D_READ_WRITE    =
    LOGLEV(9, 70, M_DEBUG)      /* show all tun/tcp/udp reads/writes/opens =
*/
-#define D_PACKET_CONTENT    LOGLEV(9, 70, M_DEBUG)      /* show before/=
after encryption packet content */
-#define D_TLS_NO_SEND_KEY   LOGLEV(9, 7=
0, M_DEBUG)      /* show when no data channel send-key exists */
-#define D=
_PID_PERSIST_DEBUG LOGLEV(9, 70, M_DEBUG)      /* show packet-id persist de=
bugging info */
-#define D_LINK_RW_VERBOSE   LOGLEV(9, 70, M_DEBUG)      /*=
 increase link reads/writes verbosity */
-#define D_STREAM_DEBUG      LOGLE=
V(9, 70, M_DEBUG)      /* show TCP stream debug info */
-#define D_WIN32_IO=
          LOGLEV(9, 70, M_DEBUG)      /* win32 I/O debugging info */
-#defi=
ne D_PKCS11_DEBUG      LOGLEV(9, 70, M_DEBUG)      /* show PKCS#11 debuggin=
g */
+#define D_TLS_DEBUG       LOGLEV(9, 70, M_DEBUG)        /* show detai=
led info from TLS routines */
+#define D_COMP            LOGLEV(9, 70, M_DE=
BUG)        /* show compression info */
+#define D_READ_WRITE      LOGLEV(9=
, 70, M_DEBUG)        /* show all tun/tcp/udp reads/writes/opens */
+#defin=
e D_PACKET_CONTENT  LOGLEV(9, 70, M_DEBUG)        /* show before/after encr=
yption packet content */
+#define D_TLS_NO_SEND_KEY LOGLEV(9, 70, M_DEBUG) =
       /* show when no data channel send-key exists */
+#define D_LINK_RW_V=
ERBOSE LOGLEV(9, 70, M_DEBUG)        /* increase link reads/writes verbosit=
y */
+#define D_STREAM_DEBUG    LOGLEV(9, 70, M_DEBUG)        /* show TCP s=
tream debug info */
+#define D_WIN32_IO        LOGLEV(9, 70, M_DEBUG)      =
  /* win32 I/O debugging info */
+#define D_PKCS11_DEBUG    LOGLEV(9, 70, M=
_DEBUG)        /* show PKCS#11 debugging */
 
 #define D_SHAPER_DEBUG LOGLE=
V(10, 70, M_DEBUG)          /* show traffic shaper info */
 
diff --git a/s=
rc/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index 681210d=2E=2E0db0584=
 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -744=
,14 +744,6 @@
 static void
 process_coarse_timers(struct context *c)
 {
-  =
  /* flush current packet-id to file once per 60
-     * seconds if --repla=
y-persist was specified */
-    if (packet_id_persist_enabled(&c->c1=2Epid_=
persist)
-        && event_timeout_trigger(&c->c2=2Epacket_id_persist_inter=
val, &c->c2=2Etimeval, ETT_DEFAULT))
-    {
-        packet_id_persist_save=
(&c->c1=2Epid_persist);
-    }
-
     /* Should we write timer-triggered st=
atus file */
     if (c->c1=2Estatus_output
         && event_timeout_trigg=
er(&c->c1=2Estatus_output->et, &c->c2=2Etimeval, ETT_DEFAULT))
diff --git a=
/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 9299c4f=2E=2E8c9098c 100=
644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -66,7 +66,6 @@=

 /*
  * Crypto initialization flags
  */
-#define CF_LOAD_PERSISTED_PACKET=
_ID (1 << 0)
 #define CF_INIT_TLS_MULTI           (1 << 1)
 #define CF_INIT=
_TLS_AUTH_STANDALONE (1 << 2)
 
@@ -737,8 +736,6 @@
 {
     context_clear_1=
(c);
 
-    packet_id_persist_init(&c->c1=2Epid_persist);
-
     init_conne=
ction_list(c);
 
     c->c1=2Elink_sockets_num =3D c->options=2Ece=2Elocal_=
list->len;
@@ -1346,12 +1343,6 @@
                                now);
   =
      }
 
-        /* initialize packet_id persistence timer */
-        if=
 (c->options=2Epacket_id_file)
-        {
-            event_timeout_init(&=
c->c2=2Epacket_id_persist_interval, 60, now);
-        }
-
         /* init=
ialize tmp_int optimization that limits the number of times we call
       =
   * tls_multi_process in the main event loop */
         interval_init(&c-=
>c2=2Etmp_int, TLS_MULTI_HORIZON, TLS_MULTI_REFRESH);
@@ -2957,15 +2948,6 @=
@
     {
         crypto_init_lib_engine(c->options=2Eengine);
     }
-
-  =
  if (flags & CF_LOAD_PERSISTED_PACKET_ID)
-    {
-        /* load a persis=
ted packet-id for cross-session replay-protection */
-        if (c->option=
s=2Epacket_id_file)
-        {
-            packet_id_persist_load(&c->c1=
=2Epid_persist, c->options=2Epacket_id_file);
-        }
-    }
 }
 
 
@@ -=
3354,7 +3336,6 @@
     if (to=2Etls_wrap=2Emode =3D=3D TLS_WRAP_AUTH || to=
=2Etls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT)
     {
         to=2Etls_wrap=2Eo=
pt=2Ekey_ctx_bi =3D c->c1=2Eks=2Etls_wrap_key;
-        to=2Etls_wrap=2Eopt=
=2Epid_persist =3D &c->c1=2Epid_persist;
         to=2Etls_wrap=2Eopt=2Efla=
gs |=3D CO_PACKET_ID_LONG_FORM;
         to=2Etls_wrap=2Eoriginal_wrap_keyd=
ata =3D c->c1=2Eks=2Eoriginal_wrap_keydata;
     }
@@ -3913,11 +3894,6 @@
 =
do_close_packet_id(struct context *c)
 {
     packet_id_free(&c->c2=2Ecrypt=
o_options=2Epacket_id);
-    packet_id_persist_save(&c->c1=2Epid_persist);
=
-    if (!(c->sig->signal_received =3D=3D SIGUSR1))
-    {
-        packet_=
id_persist_close(&c->c1=2Epid_persist);
-    }
 }
 
 #ifdef ENABLE_FRAGMENT=

@@ -4453,7 +4429,7 @@
         }
         else if (c->mode =3D=3D CM_P2P)
=
         {
-            crypto_flags =3D CF_LOAD_PERSISTED_PACKET_ID | CF_I=
NIT_TLS_MULTI;
+            crypto_flags =3D CF_INIT_TLS_MULTI;
         }
=
         else if (child)
         {
@@ -4711,7 +4687,6 @@
     ALLOC_OBJ_CL=
EAR_GC(dest->sig, struct signal_info, &dest->gc);
 
     /* c1 init */
-   =
 packet_id_persist_init(&dest->c1=2Epid_persist);
     dest->c1=2Elink_sock=
ets_num =3D 1;
     do_link_socket_addr_new(dest);
 
diff --git a/src/openv=
pn/openvpn=2Eh b/src/openvpn/openvpn=2Eh
index cdd02b6=2E=2E52f298b 100644
=
--- a/src/openvpn/openvpn=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -75,21 +75,6=
 @@
 };
 
 /*
- * struct packet_id_persist should be empty if we are not
- =
* building with crypto=2E
- */
-#ifndef PACKET_ID_H
-struct packet_id_persi=
st
-{
-    int dummy;
-};
-static inline void
-packet_id_persist_init(struc=
t packet_id_persist *p)
-{
-}
-#endif
-
-/*
  * Packet processing buffers=
=2E
  */
 struct context_buffers
@@ -167,9 +152,6 @@
     /* preresolved an=
d cached host names */
     struct cached_dns_entry *dns_cache;
 
-    /* p=
ersist crypto sequence number to/from file */
-    struct packet_id_persist=
 pid_persist;
-
     struct tuntap *tuntap; /**< Tun/tap virtual network in=
terface=2E */
     bool tuntap_owned;     /**< Whether the tun/tap interfac=
e should
                             *   be cleaned up when this %context =
is
@@ -352,8 +334,6 @@
      *   Channel Crypto module\endlink to
      *  =
 process data channel packet=2E */
 
-    struct event_timeout packet_id_pe=
rsist_interval;
-
 #ifdef USE_COMP
     struct compress_context *comp_conte=
xt;
     /**< Compression context used by the
diff --git a/src/openvpn/opti=
ons=2Ec b/src/openvpn/options=2Ec
index 386f412=2E=2Eb8468b5 100644
--- a/s=
rc/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -573,8 +573,6 @@
  =
   "--replay-window n [t]  : Use a replay protection sliding window of size=
 n\n"
     "                         and a time window of t seconds=2E\n"
 =
    "                         Default n=3D%d t=3D%d\n"
-    "--replay-persi=
st file : Persist replay-protection state across sessions\n"
-    "        =
          using file=2E\n"
     "--test-crypto   : Run a self-test of crypt=
o features enabled=2E\n"
     "                  For debugging only=2E\n"
 =
    "\n"
@@ -7051,7 +7049,7 @@
     else if (streq(p[0], "replay-persist") =
&& p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-      =
  options->packet_id_file =3D p[1];
+        msg(M_WARN, "DEPRECATED OPTION=
: --replay-persist option ignored=2E");
     }
     else if (streq(p[0], "t=
est-crypto") && !p[1])
     {
diff --git a/src/openvpn/options=2Eh b/src/op=
envpn/options=2Eh
index 129267f=2E=2Edd8b75a 100644
--- a/src/openvpn/optio=
ns=2Eh
+++ b/src/openvpn/options=2Eh
@@ -582,7 +582,6 @@
     bool mute_rep=
lay_warnings;
     int replay_window;
     int replay_time;
-    const char=
 *packet_id_file;
     bool test_crypto;
 
     /* TLS (control channel) pa=
rms */
diff --git a/src/openvpn/options_show=2Ec b/src/openvpn/options_show=
=2Ec
index 321a37b=2E=2E54f9c4c 100644
--- a/src/openvpn/options_show=2Ec
+=
++ b/src/openvpn/options_show=2Ec
@@ -501,7 +501,6 @@
     SHOW_BOOL(mute_r=
eplay_warnings);
     SHOW_INT(replay_window);
     SHOW_INT(replay_time);
=
-    SHOW_STR(packet_id_file);
     SHOW_BOOL(test_crypto);
 
     SHOW_BOO=
L(tls_server);
diff --git a/src/openvpn/packet_id=2Ec b/src/openvpn/packet_=
id=2Ec
index 9dd6ce3=2E=2Ef1fadd6 100644
--- a/src/openvpn/packet_id=2Ec
++=
+ b/src/openvpn/packet_id=2Ec
@@ -426,146 +426,6 @@
     return BSTR(&out);=

 }
 
-/* initialize the packet_id_persist structure in a disabled state */=

-void
-packet_id_persist_init(struct packet_id_persist *p)
-{
-    p->file=
name =3D NULL;
-    p->fd =3D -1;
-    p->time =3D p->time_last_written =3D=
 0;
-    p->id =3D p->id_last_written =3D 0;
-}
-
-/* close the file descri=
ptor if it is open, and switch to disabled state */
-void
-packet_id_persis=
t_close(struct packet_id_persist *p)
-{
-    if (packet_id_persist_enabled(=
p))
-    {
-        if (close(p->fd))
-        {
-            msg(D_PID_PER=
SIST | M_ERRNO, "Close error on --replay-persist file %s", p->filename);
- =
       }
-        packet_id_persist_init(p);
-    }
-}
-
-/* load persisted=
 rec packet_id (time and id) only once from file, and set state to enabled =
*/
-void
-packet_id_persist_load(struct packet_id_persist *p, const char *f=
ilename)
-{
-    struct gc_arena gc =3D gc_new();
-    if (!packet_id_persi=
st_enabled(p))
-    {
-        /* open packet-id persist file for both read=
 and write */
-        p->fd =3D platform_open(filename, O_CREAT | O_RDWR |=
 O_BINARY, S_IRUSR | S_IWUSR);
-        if (p->fd =3D=3D -1)
-        {
-  =
          msg(D_PID_PERSIST | M_ERRNO, "Cannot open --replay-persist file %=
s for read/write",
-                filename);
-        }
-        else
-  =
      {
-            struct packet_id_persist_file_image image;
-          =
  ssize_t n;
-
-#if defined(HAVE_FLOCK) && defined(LOCK_EX) && defined(LOCK=
_NB)
-            if (flock(p->fd, LOCK_EX | LOCK_NB))
-            {
-    =
            msg(M_ERR, "Cannot obtain exclusive lock on --replay-persist fi=
le %s", filename);
-            }
-#endif
-
-            p->filename =3D fi=
lename;
-            n =3D read(p->fd, &image, sizeof(image));
-           =
 if (n =3D=3D sizeof(image))
-            {
-                p->time =3D p-=
>time_last_written =3D image=2Etime;
-                p->id =3D p->id_last_=
written =3D image=2Eid;
-                dmsg(D_PID_PERSIST_DEBUG, "PID Per=
sist Read from %s: %s", p->filename,
-                     packet_id_persis=
t_print(p, &gc));
-            }
-            else if (n =3D=3D -1)
-      =
      {
-                msg(D_PID_PERSIST | M_ERRNO, "Read error on --repl=
ay-persist file %s", p->filename);
-            }
-        }
-    }
-    gc=
_free(&gc);
-}
-
-/* save persisted rec packet_id (time and id) to file (on=
ly if enabled state) */
-void
-packet_id_persist_save(struct packet_id_pers=
ist *p)
-{
-    if (packet_id_persist_enabled(p) && p->time
-        && (p-=
>time !=3D p->time_last_written || p->id !=3D p->id_last_written))
-    {
-=
        struct packet_id_persist_file_image image;
-        CLEAR(image);
-=
        off_t seek_ret;
-        struct gc_arena gc =3D gc_new();
-
-      =
  image=2Etime =3D p->time;
-        image=2Eid =3D p->id;
-        seek_re=
t =3D lseek(p->fd, (off_t)0, SEEK_SET);
-        if (seek_ret =3D=3D (off_t=
)0)
-        {
-            const ssize_t n =3D write(p->fd, &image, sizeof=
(image));
-            if (n =3D=3D sizeof(image))
-            {
-        =
        p->time_last_written =3D p->time;
-                p->id_last_writt=
en =3D p->id;
-                dmsg(D_PID_PERSIST_DEBUG, "PID Persist Write=
 to %s: %s", p->filename,
-                     packet_id_persist_print(p, =
&gc));
-            }
-            else
-            {
-                msg=
(D_PID_PERSIST | M_ERRNO, "Cannot write to --replay-persist file %s",
-    =
                p->filename);
-            }
-        }
-        else
-    =
    {
-            msg(D_PID_PERSIST | M_ERRNO, "Cannot seek to beginning o=
f --replay-persist file %s",
-                p->filename);
-        }
-   =
     gc_free(&gc);
-    }
-}
-
-/* transfer packet_id_persist -> packet_id =
*/
-void
-packet_id_persist_load_obj(const struct packet_id_persist *p, str=
uct packet_id *pid)
-{
-    if (p && pid && packet_id_persist_enabled(p) &&=
 p->time)
-    {
-        pid->rec=2Etime =3D p->time;
-        pid->rec=2E=
id =3D p->id;
-    }
-}
-
-const char *
-packet_id_persist_print(const stru=
ct packet_id_persist *p, struct gc_arena *gc)
-{
-    struct buffer out =3D=
 alloc_buf_gc(256, gc);
-
-    buf_printf(&out, "[");
-
-    if (packet_id_=
persist_enabled(p))
-    {
-        buf_printf(&out, " #" packet_id_format,=
 (packet_id_print_type)p->id);
-        if (p->time)
-        {
-          =
  buf_printf(&out, " / time =3D (" packet_id_format ") %s", (packet_id_prin=
t_type)p->time,
-                       time_string(p->time, 0, false, gc))=
;
-        }
-    }
-
-    buf_printf(&out, " ]");
-    return (char *)out=
=2Edata;
-}
-
 #ifndef ENABLE_SMALL
 
 static void
diff --git a/src/openvpn=
/packet_id=2Eh b/src/openvpn/packet_id=2Eh
index 48752d3=2E=2Eae41ef9 10064=
4
--- a/src/openvpn/packet_id=2Eh
+++ b/src/openvpn/packet_id=2Eh
@@ -125,2=
6 +125,6 @@
 };
 
 /*
- * file to facilitate cross-session persistence
- * =
of time/id
- */
-struct packet_id_persist
-{
-    const char *filename;
-  =
  int fd;
-    time_t time;       /* time stamp */
-    packet_id_type id; =
/* sequence number */
-    time_t time_last_written;
-    packet_id_type id=
_last_written;
-};
-
-struct packet_id_persist_file_image
-{
-    time_t ti=
me;       /* time stamp */
-    packet_id_type id; /* sequence number */
-}=
;
-
-/*
  * Keep a record of our current packet-id state
  * on the sending=
 side=2E
  */
@@ -222,28 +202,6 @@
 void packet_id_reap(struct packet_id_re=
c *p);
 
 /*
- * packet ID persistence
- */
-
-/* initialize the packet_id_=
persist structure in a disabled state */
-void packet_id_persist_init(struc=
t packet_id_persist *p);
-
-/* close the file descriptor if it is open, and=
 switch to disabled state */
-void packet_id_persist_close(struct packet_id=
_persist *p);
-
-/* load persisted rec packet_id (time and id) only once fr=
om file, and set state to enabled */
-void packet_id_persist_load(struct pa=
cket_id_persist *p, const char *filename);
-
-/* save persisted rec packet_=
id (time and id) to file (only if enabled state) */
-void packet_id_persist=
_save(struct packet_id_persist *p);
-
-/* transfer packet_id_persist -> pac=
ket_id */
-void packet_id_persist_load_obj(const struct packet_id_persist *=
p, struct packet_id *pid);
-
-/* return an ascii string representing a pack=
et_id_persist object */
-const char *packet_id_persist_print(const struct p=
acket_id_persist *p, struct gc_arena *gc);
-
-/*
  * Read/write a packet ID=
 to/from the buffer=2E  Short form is sequence number
  * only=2E  Long for=
m is sequence number and timestamp=2E
  */
@@ -273,26 +231,6 @@
     return=
 pid->rec=2Einitialized;
 }
 
-/* are we in enabled state? */
-static inlin=
e bool
-packet_id_persist_enabled(const struct packet_id_persist *p)
-{
-  =
  return p->fd >=3D 0;
-}
-
-/* transfer packet_id -> packet_id_persist
-  =
 Note: Only supported for non-epoch format (i=2Ee=2E 32bit ID, not 64bit fo=
rmat),
-   must be enforced at the caller=2E
- */
-static inline void
-pack=
et_id_persist_save_obj(struct packet_id_persist *p, const struct packet_id =
*pid)
-{
-    if (packet_id_persist_enabled(p) && pid->rec=2Etime && pid->r=
ec=2Eid <=3D PACKET_ID_MAX)
-    {
-        p->time =3D pid->rec=2Etime;
- =
       p->id =3D (packet_id_type)pid->rec=2Eid;
-    }
-}
 
 /**
  * Reset =
the current send packet id to its initial state=2E
diff --git a/src/openvpn=
/ssl=2Ec b/src/openvpn/ssl=2Ec
index 55043e5=2E=2E67df7c2 100644
--- a/src/=
openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -878,8 +878,6 @@
     packet_i=
d_init(&ks->crypto_options=2Epacket_id, session->opt->replay_window,
      =
              session->opt->replay_time, "SSL", ks->key_id);
 
-    ks->cry=
pto_options=2Epid_persist =3D NULL;
-
 #ifdef ENABLE_MANAGEMENT
     ks->md=
a_key_id =3D session->opt->mda_context->mda_key_id_counter++;
 #endif
@@ -1=
037,9 +1035,6 @@
         session->tls_wrap=2Eopt=2Epacket_id=2Esend=2Eid =
=3D EARLY_NEG_START;
     }
 
-    /* load most recent packet-id to replay =
protect on --tls-auth */
-    packet_id_persist_load_obj(session->tls_wrap=
=2Eopt=2Epid_persist, &session->tls_wrap=2Eopt=2Epacket_id);
-
     key_sta=
te_init(session, &session->key[KS_PRIMARY]);
 
     dmsg(D_TLS_DEBUG, "TLS:=
 tls_session_init: new session object, sid=3D%s",
diff --git a/src/openvpn/=
tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec
index 23c7975=2E=2Ee7fb865 100644=

--- a/src/openvpn/tls_crypt=2Ec
+++ b/src/openvpn/tls_crypt=2Ec
@@ -109,7 =
+109,6 @@
     session->tls_wrap_reneg=2Emode =3D TLS_WRAP_CRYPT;
     sess=
ion->tls_wrap_reneg=2Ecleanup_key_ctx =3D true;
     session->tls_wrap_rene=
g=2Ework =3D alloc_buf(BUF_SIZE(&session->opt->frame));
-    session->tls_w=
rap_reneg=2Eopt=2Epid_persist =3D NULL;
 
     packet_id_init(&session->tls=
_wrap_reneg=2Eopt=2Epacket_id, session->opt->replay_window,
               =
     session->opt->replay_time, "TLS_WRAP_RENEG", session->key_id);

-- 
To=
 view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5ee231d157459e6406f1f4c=
12cd6c6e0fce93815
Gerrit-Change-Number: 2082
Gerrit-PatchSet: 1
Gerrit-Owne=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>

--6WKPEoPTLXY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe has =
uploaded this change for <strong>review</strong>=2E</p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Remove replay-persist<br><br>This feature is very niche and we=
 do not think it is something we<br>should maintain and support going forwa=
rd=2E<br><br>This features saves a single packet id to the persist-replay f=
ile=2E<br>This makes the feature only properly work in a p2p setup where bo=
th<br>sides use replay-persist to save the last known packet id from the<br=
>peer=2E Even then it will only prevent some packet replays until the<br>le=
gitimate peer sends a packet again=2E<br><br>In server mode (p2mp) each cli=
ent context has its own replay state<br>and saving a single packet id is al=
so not very useful with multiple<br>clients and multiple states=2E<br><br>C=
hange-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815<br>Signed-off-by: Arne =
Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M Changes=2Emd<br>M configure=
=2Eac<br>M doc/man-sections/link-options=2Erst<br>M doc/man-sections/tls-op=
tions=2Erst<br>M src/openvpn/check_file_access=2Ec<br>M src/openvpn/crypto=
=2Ec<br>M src/openvpn/crypto=2Eh<br>M src/openvpn/errlevel=2Eh<br>M src/ope=
nvpn/forward=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/openvpn=2Eh<br>=
M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn/opt=
ions_show=2Ec<br>M src/openvpn/packet_id=2Ec<br>M src/openvpn/packet_id=2Eh=
<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/tls_crypt=2Ec<br>18 files change=
d, 19 insertions(+), 310 deletions(-)<br><br></pre><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/82/2082/1</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/Changes=2Emd b/Changes=2Emd</span><br><span>index dd12391=2E=2E0=
93cdae 100644</span><br><span>--- a/Changes=2Emd</span><br><span>+++ b/Chan=
ges=2Emd</span><br><span>@@ -29,7 +29,12 @@</span><br><span>   today&#39;s =
requirements=2E Use TLS mode instead=2E If deploying a PKI CA is considered=
</span><br><span>   &quot;too complicated&quot;, using `--peer-fingerprint`=
 makes TLS mode about as easy as</span><br><span>   using `--secret`=2E</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+* **`replay-persist` has been removed**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  This feature has been removed as it was never properly im=
plemented for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  serv=
er mode and generally was a nice feature=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> ## Maintainer-visible changes</sp=
an><br><span> </span><br><span> - The configure-time option `--enable-debug=
` is no longer  available</span><br><span>diff --git a/configure=2Eac b/con=
figure=2Eac</span><br><span>index 5f18798=2E=2Eae9396c 100644</span><br><sp=
an>--- a/configure=2Eac</span><br><span>+++ b/configure=2Eac</span><br><spa=
n>@@ -561,8 +561,7 @@</span><br><span> AC_CHECK_FUNCS([ \</span><br><span> =
	daemon chroot getpwnam setuid nice dup dup2 \</span><br><span> 	syslog ope=
nlog mlockall getrlimit getgrnam setgid \</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-	setgroups flock gettimeofday \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	setsid chdir \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	setgroups gettimeofday setsid chdir \</span><b=
r><span> 	chsize ftruncate execve getpeereid basename dirname \</span><br><=
span> 	epoll_create strlcpy strsep strtok_r \</span><br><span> ])</span><br=
><span>diff --git a/doc/man-sections/link-options=2Erst b/doc/man-sections/=
link-options=2Erst</span><br><span>index 735ee51=2E=2Ebbdcf7f 100644</span>=
<br><span>--- a/doc/man-sections/link-options=2Erst</span><br><span>+++ b/d=
oc/man-sections/link-options=2Erst</span><br><span>@@ -440,19 +440,6 @@</sp=
an><br><span>   physical IP layer=2E The problem is easily fixed by simply =
using TCP as</span><br><span>   the VPN transport layer=2E</span><br><span>=
 </span><br><span>---replay-persist file</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  Persist replay-protection state across sessions using =
``file`` to save</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  and=
 reload the state=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-  This option will kee=
p a disk copy of the current replay protection state</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  (i=2Ee=2E the most recent packet timestam=
p and sequence number received from</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-  the remote peer), so that if an OpenVPN session is stopped =
and</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  restarted, it wi=
ll reject any replays of packets which were already</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  received by the prior session=2E</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-  This option only makes sense when replay protecti=
on is enabled (the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  d=
efault) and you are using TLS mode with ``--tls-auth``=2E</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> --session-timeout n</=
span><br><span>   Raises :code:`SIGTERM` for the client instance after ``n`=
` seconds since</span><br><span>   the beginning of the session, forcing Op=
enVPN to disconnect=2E</span><br><span>diff --git a/doc/man-sections/tls-op=
tions=2Erst b/doc/man-sections/tls-options=2Erst</span><br><span>index c4aa=
810=2E=2Ede4d324 100644</span><br><span>--- a/doc/man-sections/tls-options=
=2Erst</span><br><span>+++ b/doc/man-sections/tls-options=2Erst</span><br><=
span>@@ -370,10 +370,7 @@</span><br><span>   level has had a chance to auth=
enticate the peer=2E The result is that</span><br><span>   packets without =
the correct signature can be dropped immediately upon</span><br><span>   re=
ception, before they have a chance to consume additional system</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  resources such as by initiating=
 a TLS handshake=2E ``--tls-auth`` can be</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  strengthened by adding the ``--replay-persist`` optio=
n which will keep</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Op=
enVPN&#39;s replay protection state in a file so that it is not lost</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-  across restarts=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  resources such as by init=
iating a TLS handshake=2E</span><br><span> </span><br><span>   It should be=
 emphasized that this feature is optional and that the key</span><br><span>=
   file used with ``--tls-auth`` gives a peer nothing more than the power</=
span><br><span>diff --git a/src/openvpn/check_file_access=2Ec b/src/openvpn=
/check_file_access=2Ec</span><br><span>index 90dbb4e=2E=2E09635cb 100644</s=
pan><br><span>--- a/src/openvpn/check_file_access=2Ec</span><br><span>+++ b=
/src/openvpn/check_file_access=2Ec</span><br><span>@@ -312,9 +312,6 @@</spa=
n><br><span>                                          ce-&gt;tls_crypt_v2_f=
ile, R_OK, &quot;--tls-crypt-v2&quot;);</span><br><span>     }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D ch=
eck_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options-&gt;packet_id_fi=
le,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
            R_OK | W_OK, &quot;--replay-persist&quot;);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* ** Password file=
s ** */</span><br><span>     errs |=3D check_file_access(CHKACC_FILE | CHKA=
CC_ACPTSTDIN | CHKACC_PRIVATE,</span><br><span>                            =
   options-&gt;key_pass_file, R_OK, &quot;--askpass&quot;);</span><br><span=
>diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><sp=
an>index c18c724=2E=2Eb94f57c 100644</span><br><span>--- a/src/openvpn/cryp=
to=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -403=
,10 +403,6 @@</span><br><span>     if (packet_id_test(recv, pin))</span><br=
><span>     {</span><br><span>         packet_id_add(recv, pin);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (opt-&gt;pid_persist =
&amp;&amp; (opt-&gt;flags &amp; CO_PACKET_ID_LONG_FORM))</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            packet_id_persist_save_obj(opt-&gt;pid_p=
ersist, &amp;opt-&gt;packet_id);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        }</span><br><span>         ret =3D true;</span><br><span=
>     }</span><br><span>     else</span><br><span>diff --git a/src/openvpn/=
crypto=2Eh b/src/openvpn/crypto=2Eh</span><br><span>index 203f77b=2E=2E4962=
835 100644</span><br><span>--- a/src/openvpn/crypto=2Eh</span><br><span>+++=
 b/src/openvpn/crypto=2Eh</span><br><span>@@ -339,11 +339,6 @@</span><br><s=
pan>                                  *   The packet id also used as the IV=
</span><br><span>                                  *   for AEAD/OFB/CFG cip=
hers=2E</span><br><span>                                  */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct packet_id_persist *pid_pe=
rsist;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /**&lt; Per=
sistent packet ID state for</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-     *   keeping state between successive</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-     *   OpenVPN process startups=2E */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #define CO_PA=
CKET_ID_LONG_FORM         (1u &lt;&lt; 0)</span><br><span>     /**&lt; Bit-=
flag indicating whether to use</span><br><span>      *   OpenVPN&#39;s long=
 packet ID format=2E */</span><br><span>diff --git a/src/openvpn/errlevel=
=2Eh b/src/openvpn/errlevel=2Eh</span><br><span>index d79efbb=2E=2E60d20ad =
100644</span><br><span>--- a/src/openvpn/errlevel=2Eh</span><br><span>+++ b=
/src/openvpn/errlevel=2Eh</span><br><span>@@ -64,7 +64,6 @@</span><br><span=
> #define D_MULTI_ERRORS   LOGLEV(1, 9, M_NONFATAL)   /* show multi-client =
server errors */</span><br><span> #define D_EVENT_ERRORS   LOGLEV(1, 10, M_=
NONFATAL)  /* show event=2E[ch] errors */</span><br><span> #define D_PUSH_E=
RRORS    LOGLEV(1, 11, M_NONFATAL)  /* show push/pull errors */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define D_PID_PERSIST    LOGLEV(1=
, 12, M_NONFATAL)  /* show packet_id persist errors */</span><br><span> #de=
fine D_FRAG_ERRORS    LOGLEV(1, 13, M_NONFATAL)  /* show fragmentation erro=
rs */</span><br><span> #define D_ALIGN_ERRORS   LOGLEV(1, 14, M_NONFATAL)  =
/* show bad struct alignments */</span><br><span> </span><br><span>@@ -161,=
16 +160,15 @@</span><br><span> #define D_EVENT_WAIT        LOGLEV(8, 70, M_=
DEBUG)      /* show detailed info from event waits */</span><br><span> #def=
ine D_MULTI_TCP         LOGLEV(8, 70, M_DEBUG)      /* show debug info from=
 mtcp=2Ec */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define D_TLS_DEBUG         LOGLEV(9, 70, M_DEBUG)      /* show de=
tailed info from TLS routines */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define D_COMP              LOGLEV(9, 70, M_DEBUG)      /* show =
compression info */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#d=
efine D_READ_WRITE        LOGLEV(9, 70, M_DEBUG)      /* show all tun/tcp/u=
dp reads/writes/opens */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define D_PACKET_CONTENT    LOGLEV(9, 70, M_DEBUG)      /* show before/a=
fter encryption packet content */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#define D_TLS_NO_SEND_KEY   LOGLEV(9, 70, M_DEBUG)      /* show=
 when no data channel send-key exists */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#define D_PID_PERSIST_DEBUG LOGLEV(9, 70, M_DEBUG)      =
/* show packet-id persist debugging info */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#define D_LINK_RW_VERBOSE   LOGLEV(9, 70, M_DEBUG)   =
   /* increase link reads/writes verbosity */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#define D_STREAM_DEBUG      LOGLEV(9, 70, M_DEBUG) =
     /* show TCP stream debug info */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define D_WIN32_IO          LOGLEV(9, 70, M_DEBUG)      /* =
win32 I/O debugging info */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#define D_PKCS11_DEBUG      LOGLEV(9, 70, M_DEBUG)      /* show PKCS#=
11 debugging */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine D_TLS_DEBUG       LOGLEV(9, 70, M_DEBUG)        /* show detailed info f=
rom TLS routines */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define D_COMP            LOGLEV(9, 70, M_DEBUG)        /* show compression=
 info */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_R=
EAD_WRITE      LOGLEV(9, 70, M_DEBUG)        /* show all tun/tcp/udp reads/=
writes/opens */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine D_PACKET_CONTENT  LOGLEV(9, 70, M_DEBUG)        /* show before/after en=
cryption packet content */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define D_TLS_NO_SEND_KEY LOGLEV(9, 70, M_DEBUG)        /* show when=
 no data channel send-key exists */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define D_LINK_RW_VERBOSE LOGLEV(9, 70, M_DEBUG)        /* =
increase link reads/writes verbosity */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define D_STREAM_DEBUG    LOGLEV(9, 70, M_DEBUG)       =
 /* show TCP stream debug info */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define D_WIN32_IO        LOGLEV(9, 70, M_DEBUG)        /* wi=
n32 I/O debugging info */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define D_PKCS11_DEBUG    LOGLEV(9, 70, M_DEBUG)        /* show PKCS#=
11 debugging */</span><br><span> </span><br><span> #define D_SHAPER_DEBUG L=
OGLEV(10, 70, M_DEBUG)          /* show traffic shaper info */</span><br><s=
pan> </span><br><span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/fo=
rward=2Ec</span><br><span>index 681210d=2E=2E0db0584 100644</span><br><span=
>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=2E=
c</span><br><span>@@ -744,14 +744,6 @@</span><br><span> static void</span><=
br><span> process_coarse_timers(struct context *c)</span><br><span> {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* flush current packet=
-id to file once per 60</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-     * seconds if --replay-persist was specified */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (packet_id_persist_enabled(&amp;c-&g=
t;c1=2Epid_persist)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      &amp;&amp; event_timeout_trigger(&amp;c-&gt;c2=2Epacket_id_persist_in=
terval, &amp;c-&gt;c2=2Etimeval, ETT_DEFAULT))</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        packet_id_persist_save(&amp;c-&gt;c1=2Epid_persist);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* Should we write ti=
mer-triggered status file */</span><br><span>     if (c-&gt;c1=2Estatus_out=
put</span><br><span>         &amp;&amp; event_timeout_trigger(&amp;c-&gt;c1=
=2Estatus_output-&gt;et, &amp;c-&gt;c2=2Etimeval, ETT_DEFAULT))</span><br><=
span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><sp=
an>index 9299c4f=2E=2E8c9098c 100644</span><br><span>--- a/src/openvpn/init=
=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -66,7 +6=
6,6 @@</span><br><span> /*</span><br><span>  * Crypto initialization flags<=
/span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
define CF_LOAD_PERSISTED_PACKET_ID (1 &lt;&lt; 0)</span><br><span> #define =
CF_INIT_TLS_MULTI           (1 &lt;&lt; 1)</span><br><span> #define CF_INIT=
_TLS_AUTH_STANDALONE (1 &lt;&lt; 2)</span><br><span> </span><br><span>@@ -7=
37,8 +736,6 @@</span><br><span> {</span><br><span>     context_clear_1(c);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
packet_id_persist_init(&amp;c-&gt;c1=2Epid_persist);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     init_connection_list(=
c);</span><br><span> </span><br><span>     c-&gt;c1=2Elink_sockets_num =3D =
c-&gt;options=2Ece=2Elocal_list-&gt;len;</span><br><span>@@ -1346,12 +1343,=
6 @@</span><br><span>                                now);</span><br><span>=
         }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        /* initialize packet_id persistence timer */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        if (c-&gt;options=2Epacket_id=
_file)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            event_timeout_i=
nit(&amp;c-&gt;c2=2Epacket_id_persist_interval, 60, now);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span>         /* initialize tmp_int opt=
imization that limits the number of times we call</span><br><span>         =
 * tls_multi_process in the main event loop */</span><br><span>         int=
erval_init(&amp;c-&gt;c2=2Etmp_int, TLS_MULTI_HORIZON, TLS_MULTI_REFRESH);<=
/span><br><span>@@ -2957,15 +2948,6 @@</span><br><span>     {</span><br><sp=
an>         crypto_init_lib_engine(c-&gt;options=2Eengine);</span><br><span=
>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (flags &amp; CF_LOAD_PERSIST=
ED_PACKET_ID)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* load a persis=
ted packet-id for cross-session replay-protection */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (c-&gt;options=2Epacket_id_file)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            packet_id_persist_loa=
d(&amp;c-&gt;c1=2Epid_persist, c-&gt;options=2Epacket_id_file);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span> }</span><br><span> <=
/span><br><span> </span><br><span>@@ -3354,7 +3336,6 @@</span><br><span>   =
  if (to=2Etls_wrap=2Emode =3D=3D TLS_WRAP_AUTH || to=2Etls_wrap=2Emode =3D=
=3D TLS_WRAP_CRYPT)</span><br><span>     {</span><br><span>         to=2Etl=
s_wrap=2Eopt=2Ekey_ctx_bi =3D c-&gt;c1=2Eks=2Etls_wrap_key;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        to=2Etls_wrap=2Eopt=2Epid_per=
sist =3D &amp;c-&gt;c1=2Epid_persist;</span><br><span>         to=2Etls_wra=
p=2Eopt=2Eflags |=3D CO_PACKET_ID_LONG_FORM;</span><br><span>         to=2E=
tls_wrap=2Eoriginal_wrap_keydata =3D c-&gt;c1=2Eks=2Eoriginal_wrap_keydata;=
</span><br><span>     }</span><br><span>@@ -3913,11 +3894,6 @@</span><br><s=
pan> do_close_packet_id(struct context *c)</span><br><span> {</span><br><sp=
an>     packet_id_free(&amp;c-&gt;c2=2Ecrypto_options=2Epacket_id);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    packet_id_persist_save(&a=
mp;c-&gt;c1=2Epid_persist);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (!(c-&gt;sig-&gt;signal_received =3D=3D SIGUSR1))</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        packet_id_persist_close(&amp;c-&gt;c1=2Epi=
d_persist);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span> }</span><br><span> </span><br><span> #ifdef ENABLE_FRAGMENT</s=
pan><br><span>@@ -4453,7 +4429,7 @@</span><br><span>         }</span><br><s=
pan>         else if (c-&gt;mode =3D=3D CM_P2P)</span><br><span>         {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            crypto_fla=
gs =3D CF_LOAD_PERSISTED_PACKET_ID | CF_INIT_TLS_MULTI;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            crypto_flags =3D CF_INIT_TL=
S_MULTI;</span><br><span>         }</span><br><span>         else if (child=
)</span><br><span>         {</span><br><span>@@ -4711,7 +4687,6 @@</span><b=
r><span>     ALLOC_OBJ_CLEAR_GC(dest-&gt;sig, struct signal_info, &amp;dest=
-&gt;gc);</span><br><span> </span><br><span>     /* c1 init */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    packet_id_persist_init(&amp;de=
st-&gt;c1=2Epid_persist);</span><br><span>     dest-&gt;c1=2Elink_sockets_n=
um =3D 1;</span><br><span>     do_link_socket_addr_new(dest);</span><br><sp=
an> </span><br><span>diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/ope=
nvpn=2Eh</span><br><span>index cdd02b6=2E=2E52f298b 100644</span><br><span>=
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
@ -352,8 +334,6 @@</span><br><span>      *   Channel Crypto module\endlink =
to</span><br><span>      *   process data channel packet=2E */</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct event=
_timeout packet_id_persist_interval;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span> #ifdef USE_COMP</span><br><span>     struc=
t compress_context *comp_context;</span><br><span>     /**&lt; Compression =
context used by the</span><br><span>diff --git a/src/openvpn/options=2Ec b/=
src/openvpn/options=2Ec</span><br><span>index 386f412=2E=2Eb8468b5 100644</=
span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/open=
vpn/options=2Ec</span><br><span>@@ -573,8 +573,6 @@</span><br><span>     &q=
uot;--replay-window n [t]  : Use a replay protection sliding window of size=
 n\n&quot;</span><br><span>     &quot;                         and a time w=
indow of t seconds=2E\n&quot;</span><br><span>     &quot;                  =
       Default n=3D%d t=3D%d\n&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    &quot;--replay-persist file : Persist replay-protection =
state across sessions\n&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    &quot;                  using file=2E\n&quot;</span><br><span> =
    &quot;--test-crypto   : Run a self-test of crypto features enabled=2E\n=
&quot;</span><br><span>     &quot;                  For debugging only=2E\n=
&quot;</span><br><span>     &quot;\n&quot;</span><br><span>@@ -7051,7 +7049=
,7 @@</span><br><span>     else if (streq(p[0], &quot;replay-persist&quot;)=
 &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span> =
        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        options-&gt;packet_id_file =3D p[1];</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;DEPR=
ECATED OPTION: --replay-persist option ignored=2E&quot;);</span><br><span> =
    }</span><br><span>     else if (streq(p[0], &quot;test-crypto&quot;) &a=
mp;&amp; !p[1])</span><br><span>     {</span><br><span>diff --git a/src/ope=
nvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index 129267f=2E=
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
src/openvpn/packet_id=2Eh</span><br><span>index 48752d3=2E=2Eae41ef9 100644=
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
span>  */</span><br><span>@@ -273,26 +231,6 @@</span><br><span>     return =
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
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span> </spa=
n><br><span> /**</span><br><span>  * Reset the current send packet id to it=
s initial state=2E</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/o=
penvpn/ssl=2Ec</span><br><span>index 55043e5=2E=2E67df7c2 100644</span><br>=
<span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</=
span><br><span>@@ -878,8 +878,6 @@</span><br><span>     packet_id_init(&amp=
;ks-&gt;crypto_options=2Epacket_id, session-&gt;opt-&gt;replay_window,</spa=
n><br><span>                    session-&gt;opt-&gt;replay_time, &quot;SSL&=
quot;, ks-&gt;key_id);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    ks-&gt;crypto_options=2Epid_persist =3D NULL;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifdef ENA=
BLE_MANAGEMENT</span><br><span>     ks-&gt;mda_key_id =3D session-&gt;opt-&=
gt;mda_context-&gt;mda_key_id_counter++;</span><br><span> #endif</span><br>=
<span>@@ -1037,9 +1035,6 @@</span><br><span>         session-&gt;tls_wrap=
=2Eopt=2Epacket_id=2Esend=2Eid =3D EARLY_NEG_START;</span><br><span>     }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
/* load most recent packet-id to replay protect on --tls-auth */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    packet_id_persist_load_obj(s=
ession-&gt;tls_wrap=2Eopt=2Epid_persist, &amp;session-&gt;tls_wrap=2Eopt=2E=
packet_id);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span>     key_state_init(session, &amp;session-&gt;key[KS_PRIMARY]);</spa=
n><br><span> </span><br><span>     dmsg(D_TLS_DEBUG, &quot;TLS: tls_session=
_init: new session object, sid=3D%s&quot;,</span><br><span>diff --git a/src=
/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec</span><br><span>index 23=
c7975=2E=2Ee7fb865 100644</span><br><span>--- a/src/openvpn/tls_crypt=2Ec</=
span><br><span>+++ b/src/openvpn/tls_crypt=2Ec</span><br><span>@@ -109,7 +1=
09,6 @@</span><br><span>     session-&gt;tls_wrap_reneg=2Emode =3D TLS_WRAP=
_CRYPT;</span><br><span>     session-&gt;tls_wrap_reneg=2Ecleanup_key_ctx =
=3D true;</span><br><span>     session-&gt;tls_wrap_reneg=2Ework =3D alloc_=
buf(BUF_SIZE(&amp;session-&gt;opt-&gt;frame));</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    session-&gt;tls_wrap_reneg=2Eopt=2Epid_persist=
 =3D NULL;</span><br><span> </span><br><span>     packet_id_init(&amp;sessi=
on-&gt;tls_wrap_reneg=2Eopt=2Epacket_id, session-&gt;opt-&gt;replay_window,=
</span><br><span>                    session-&gt;opt-&gt;replay_time, &quot=
;TLS_WRAP_RENEG&quot;, session-&gt;key_id);</span><br></pre><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail">=
change 2082</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/208=
2?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 2082 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne =
Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>

</body></html>
--6WKPEoPTLXY=--


--===============0357332605839835392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0357332605839835392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0357332605839835392==--

