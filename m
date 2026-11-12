Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CCE606A323
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VYWj7ob1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kji/zM5N;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MtZDgDeL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=W7ZxsKnr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=sOZiJmgqj5+fAao+7bNNjQiuIS2Q3iqwBSVwwCls+cU=; b=VYWj7ob1v8vZCTWjRcankFZmS4
	ND1cz0aoHbTOtTa370DaR8OknCPbULjz7CD+jHop8gSh2ga0AebDaPOvziJ4Gn1TT5qkZ0Up1pQ+i
	8OvRNkWFskmffDQrMg+BKaRYXckGL6wNmWU/vUkzoVz7eriSuQhqHCHCf6uNysrpBczw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRXcf-000000000W1-2Sja;
	Thu, 12 Nov 2026 16:26:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRXce-000000000Vp-1wsF
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 16:26:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yesrjJBMEGM0O+W4A0LXidKXGts4cIxZcTrKoRCsbck=; b=kji/zM5NFuv5vIbXRVgJqxey2N
 uJoL6no/PY2QHeOAcA6PnXRH/fMofLge5lgEUpwLaEtCjqGBbBL6g4XYUFwOMhuBIabXVs2MFKTUs
 ZofNTmLhR8Q4CsfZdJltHOhGIWkXcojhFj2zl4YvHDaqVEQPnAn69i4J/SrroQwpmN8g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yesrjJBMEGM0O+W4A0LXidKXGts4cIxZcTrKoRCsbck=; b=MtZDgDeLTAFkGzgEKSPL0mV3Ub
 FaTO5KijvpAsxTnNEBCn4llmDCJL/gUFQMoqHGJ71PT2H8EScpMoql0xkCRysMLsncX1gRUITjNcc
 6fLMWq74BHtSpL/MTYbIrj0TwTOx1+w3FBHHnKuPGEQI8nxHkiVD7PmY8dnTxsnYmO7M=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRXcW-000000001wY-3dqS for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 16:26:00 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so44437565e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 08:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794500746; x=1795105546; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yesrjJBMEGM0O+W4A0LXidKXGts4cIxZcTrKoRCsbck=;
 b=W7ZxsKnrYZTgtX3vqF763ulY+WlzzfDTdk1JurEZt2j9w4uEmuyYiV706JPm6mQtcK
 u7+1eeb987BfRiYcVSO1T6fMbbA4uvy+LGKzK0P42udwARSCEob861vYOpH+ukpig14M
 2MpFUDsdrvAi6MsTYtTTHevEcIRYzORqeFWnG3S5xvWWPhLkFVIdfxy53Vk3V3wzd0sY
 5USp/VjTYIvhKjPqT0m2Ah5LrSfLv//HwChu4EboTioKOANUQJr+7KFhc6nuI+1G7ota
 rhpB1a5YNC+/u3ZLfKzX2daJeAW1dIbM+9rilebHbpFIDXvH1faqMH/bloSfKhNmf2VQ
 rJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794500746; x=1795105546;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yesrjJBMEGM0O+W4A0LXidKXGts4cIxZcTrKoRCsbck=;
 b=Kq8un/WgB2CHnMjeBFjHofMpyrpl3Tz8bzDpp29shtreoIHBFjiDwGpQ9t1/PPaS9m
 /Ygrs/eSRd8Ollqf8dDD6eda9k2jJwkKSefVVNFqR7YB9rQ75YDEoI8HLswVJ4vWn/V7
 DUqovMhLc0VZ6rk2VU3R0XGOkRAyyno5drT6/ef4vd4xyBN7sIM/GQWDaeZe6+GjX+vx
 yr9Wdg+8g/BaBwsi7gRMHzDv8PeKj39H8/baffzb3Jcyg4MWBcKKTPDIY1pnwTp9cC4d
 JnjCuYpV7iKZbmhP/iOWyUnxjyAehLKlaFoUyix/PG9TKxeL8UHhknXvXDSsnO4K2INg
 aQ/Q==
X-Gm-Message-State: APuU4Z9fVjRf9Ucxqqc66ELFrJhmnIyME3+0tj6XnNbw7+zstrHh8qn9
 PCwTzjsIfIrXjQEXx06kI7qqoiTovZguilNPUSEiM6ZAXeZLJnFDSldxDg1MP67NejrsenfDV/v
 3wYMmWMnws92g9jQ7iVtCKVcT1e/YSh8jC2eh34azx2MzihANz0vO3MNMJ2iTMS5MbPaf
X-Gm-Gg: AYBFou1mMOSsLxTkk+IclaIC5FsFWO1Op92W2SVoc4GKzW9bXputnhmeCvkB+/3b+Io
 w961SbJcicqrrYH14fxZizU8YQRfEldOX8TjddYcdTZjXOYvjEENxx1fG8rmSflinJh5UCvIEjx
 gPg8icLyv/K250PTX3zrpS/n6wQAAdoBk8zmOLNBbDwEHgW7DQx453UXIcJzWAlZcSXXHpPRYU+
 DFLxftue7rWLCZju/ZvqUBedSxfSWiBhsJ+S1t1kNgu9JhGkTNudvylWh18yYlOhUmw4gFNd9UO
 vn26HPurow0tzo+aVoYTpK/ntkA/yhMGak34JIK8shDY1+baAsKqUZ529T1OSpieey4j6gCmHME
 Cgg2mXEcPUQmYAFZx57V+P2YSwFtV2RCC8Ciupg0Epl2niMK2MFUEWQ6fBa2Q/28+RHHh56NMnk
 3mloOVP0MVvhMncR1cPvC9aQnoRg4tuE2vQ5SyxGrmjPDiisRK3e4AEwzAVJncrVIllvHEoacOm
 u3pKlH/ruePUBbPER3tIaGJSm+tP3sG8XkG5hE7/QtnkXHTQGe8MPIYgBrLNKloAmSj1sMYCGa6
 umq4kiWpcDKQOasxLJVDPhO6x5LHE6NQI54/lZM4ZKIwEnwkISEs8i6Ch9DVhnQBy2Co079hsG2
 bmF3Zd+NSIEvRcOIw7s7WkZoCwp9SF7KLdRGAFe8PU0ES3QI30LrSYK4xeIwUkMyGG9pf4XsBz9
 NDZm4hwJ8tH7z9Ou8=
X-Received: by 2002:a05:600c:3551:b0:4a6:b49f:9ae5 with SMTP id
 5b1f17b1804b1-4ba0938b879mr116758885e9.34.1794500745777; 
 Thu, 12 Nov 2026 08:25:45 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e2538b9sm143468725e9.1.2026.11.12.08.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 08:25:45 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 16:25:44 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815
X-Gerrit-Change-Number: 2082
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2082?usp=email>
X-Gerrit-Commit: 5943795d11b9fec5170d72ca98ee72c993d57c37
In-Reply-To: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
References: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkk1ZWUyMzFkMTU3NDU5ZTY0MDZmMWY0YzEyY2Q2YzZlMGZjZTkzODE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4c38c15f9189fabbaa9722bb0bff9951db9b0541-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRXcW-000000001wY-3dqS
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
Content-Type: multipart/mixed; boundary="===============6191783912036293968=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6191783912036293968==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qry/oIcu3eA="; charset=UTF-8

--qry/oIcu3eA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#9) to the change originally cre=
ated by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?u=
sp=3Demail )

The following approvals got outdated and were removed:
Code-R=
eview+2 by R=C4=83zvan Cojocaru


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


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/82/2082/9

diff --git a/Changes=2Emd b/Changes=2Emd
index 7f47f77=2E=2E89a=
72fe 100644
--- a/Changes=2Emd
+++ b/Changes=2Emd
@@ -30,6 +30,12 @@
   "to=
o complicated", using `--peer-fingerprint` makes TLS mode about as easy as
=
   using `--secret`=2E
 
+* **`replay-persist` has been removed**
+
+  This=
 feature has been removed as it was never properly implemented for
+  serve=
r mode and generally was a niche feature=2E If the option is present
+  it =
will be ignored=2E
+
 ## Maintainer-visible changes
 
 - The configure-time=
 option `--enable-debug` is no longer  available
diff --git a/config=2Eh=2E=
cmake=2Ein b/config=2Eh=2Ecmake=2Ein
index 5e06a63=2E=2Ef7818cf 100644
--- =
a/config=2Eh=2Ecmake=2Ein
+++ b/config=2Eh=2Ecmake=2Ein
@@ -285,9 +285,6 @@=

 /* Define to 1 if you have the <sys/epoll=2Eh> header file=2E */
 #cmaked=
efine HAVE_SYS_EPOLL_H
 
-/* Define to 1 if you have the <sys/file=2Eh> hea=
der file=2E */
-#undef HAVE_SYS_FILE_H
-
 /* Define to 1 if you have the <s=
ys/inotify=2Eh> header file=2E */
 #cmakedefine HAVE_SYS_INOTIFY_H
 
diff -=
-git a/configure=2Eac b/configure=2Eac
index 5f18798=2E=2E9326c4e 100644
--=
- a/configure=2Eac
+++ b/configure=2Eac
@@ -453,7 +453,7 @@
 ])
 AC_CHECK_H=
EADERS([ \
 	sys/time=2Eh sys/ioctl=2Eh sys/stat=2Eh \
-	sys/mman=2Eh sys/f=
ile=2Eh sys/wait=2Eh \
+	sys/mman=2Eh sys/wait=2Eh \
 	libgen=2Eh stropts=
=2Eh \
 	syslog=2Eh pwd=2Eh grp=2Eh \
 	sys/sockio=2Eh sys/uio=2Eh \
@@ -56=
1,8 +561,7 @@
 AC_CHECK_FUNCS([ \
 	daemon chroot getpwnam setuid nice dup =
dup2 \
 	syslog openlog mlockall getrlimit getgrnam setgid \
-	setgroups fl=
ock gettimeofday \
-	setsid chdir \
+	setgroups gettimeofday setsid chdir \=

 	chsize ftruncate execve getpeereid basename dirname \
 	epoll_create str=
lcpy strsep strtok_r \
 ])
diff --git a/doc/man-sections/link-options=2Erst=
 b/doc/man-sections/link-options=2Erst
index 735ee51=2E=2Ebbdcf7f 100644
--=
- a/doc/man-sections/link-options=2Erst
+++ b/doc/man-sections/link-options=
=2Erst
@@ -440,19 +440,6 @@
   physical IP layer=2E The problem is easily f=
ixed by simply using TCP as
   the VPN transport layer=2E
 
---replay-persi=
st file
-  Persist replay-protection state across sessions using ``file`` t=
o save
-  and reload the state=2E
-
-  This option will keep a disk copy of=
 the current replay protection state
-  (i=2Ee=2E the most recent packet ti=
mestamp and sequence number received from
-  the remote peer), so that if a=
n OpenVPN session is stopped and
-  restarted, it will reject any replays o=
f packets which were already
-  received by the prior session=2E
-
-  This =
option only makes sense when replay protection is enabled (the
-  default) =
and you are using TLS mode with ``--tls-auth``=2E
-
 --session-timeout n
  =
 Raises :code:`SIGTERM` for the client instance after ``n`` seconds since
 =
  the beginning of the session, forcing OpenVPN to disconnect=2E
diff --git=
 a/doc/man-sections/tls-options=2Erst b/doc/man-sections/tls-options=2Erst
=
index c4aa810=2E=2Ede4d324 100644
--- a/doc/man-sections/tls-options=2Erst
=
+++ b/doc/man-sections/tls-options=2Erst
@@ -370,10 +370,7 @@
   level has =
had a chance to authenticate the peer=2E The result is that
   packets with=
out the correct signature can be dropped immediately upon
   reception, bef=
ore they have a chance to consume additional system
-  resources such as by=
 initiating a TLS handshake=2E ``--tls-auth`` can be
-  strengthened by add=
ing the ``--replay-persist`` option which will keep
-  OpenVPN's replay pro=
tection state in a file so that it is not lost
-  across restarts=2E
+  res=
ources such as by initiating a TLS handshake=2E
 
   It should be emphasize=
d that this feature is optional and that the key
   file used with ``--tls-=
auth`` gives a peer nothing more than the power
diff --git a/doc/man-sectio=
ns/unsupported-options=2Erst b/doc/man-sections/unsupported-options=2Erst
i=
ndex 2794f12=2E=2E368805e 100644
--- a/doc/man-sections/unsupported-options=
=2Erst
+++ b/doc/man-sections/unsupported-options=2Erst
@@ -79,3 +79,8 @@
 =

 --allow-deprecated-insecure-static-crypto
   Removed in OpenVPN 2=2E8 as =
--secret was also removed=2E
+
+--replay-persist
+  Removed in OpenVPN 2=2E=
8=2E This option never really worked well with ``--server``
+  and the usef=
ulness of this option in p2p setups is not very high either=2E
+  It is now=
 ignored if present in the configuration file=2E
diff --git a/src/openvpn/c=
heck_file_access=2Ec b/src/openvpn/check_file_access=2Ec
index ab2535d=2E=
=2Ebe9b4b2 100644
--- a/src/openvpn/check_file_access=2Ec
+++ b/src/openvpn=
/check_file_access=2Ec
@@ -312,9 +312,6 @@
                                =
          ce->tls_crypt_v2_file, R_OK, "--tls-crypt-v2");
     }
 
-    err=
s |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->packet=
_id_file,
-                              R_OK | W_OK, "--replay-persist");
=
-
     /* ** Password files ** */
     errs |=3D check_file_access(CHKACC_F=
ILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
                               opt=
ions->key_pass_file, R_OK, "--askpass");
diff --git a/src/openvpn/crypto=2E=
c b/src/openvpn/crypto=2Ec
index a8ad7f0=2E=2E6efa005 100644
--- a/src/open=
vpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -403,10 +403,6 @@
     if (p=
acket_id_test(recv, pin))
     {
         packet_id_add(recv, pin);
-      =
  if (opt->pid_persist && (opt->flags & CO_PACKET_ID_LONG_FORM))
-        {=

-            packet_id_persist_save_obj(opt->pid_persist, &opt->packet_id)=
;
-        }
         ret =3D true;
     }
     else
diff --git a/src/openv=
pn/crypto=2Eh b/src/openvpn/crypto=2Eh
index a03c5ce=2E=2E7e240d2 100644
--=
- a/src/openvpn/crypto=2Eh
+++ b/src/openvpn/crypto=2Eh
@@ -332,11 +332,6 @=
@
                                  *   The packet id also used as the IV
 =
                                 *   for AEAD/OFB/CFG ciphers=2E
          =
                        */
-    struct packet_id_persist *pid_persist;
-   =
 /**< Persistent packet ID state for
-     *   keeping state between succes=
sive
-     *   OpenVPN process startups=2E */
-
 #define CO_PACKET_ID_LONG_=
FORM         (1u << 0)
     /**< Bit-flag indicating whether to use
      *=
   OpenVPN's long packet ID format=2E */
diff --git a/src/openvpn/errlevel=
=2Eh b/src/openvpn/errlevel=2Eh
index e52cb65=2E=2E5cea0ad 100644
--- a/src=
/openvpn/errlevel=2Eh
+++ b/src/openvpn/errlevel=2Eh
@@ -64,7 +64,6 @@
 #de=
fine D_MULTI_ERRORS   LOGLEV(1, 9, M_NONFATAL)  /* show multi-client server=
 errors */
 #define D_EVENT_ERRORS   LOGLEV(1, 10, M_NONFATAL) /* show even=
t=2E[ch] errors */
 #define D_PUSH_ERRORS    LOGLEV(1, 11, M_NONFATAL) /* s=
how push/pull errors */
-#define D_PID_PERSIST    LOGLEV(1, 12, M_NONFATAL)=
 /* show packet_id persist errors */
 #define D_FRAG_ERRORS    LOGLEV(1, 13=
, M_NONFATAL) /* show fragmentation errors */
 #define D_ALIGN_ERRORS   LOG=
LEV(1, 14, M_NONFATAL) /* show bad struct alignments */
 
@@ -159,16 +158,1=
5 @@
 #define D_EVENT_WAIT        LOGLEV(8, 70, M_DEBUG)      /* show detai=
led info from event waits */
 #define D_MULTI_TCP         LOGLEV(8, 70, M_D=
EBUG)      /* show debug info from mtcp=2Ec */
 
-#define D_TLS_DEBUG      =
   LOGLEV(9, 70, M_DEBUG)      /* show detailed info from TLS routines */
-=
#define D_COMP              LOGLEV(9, 70, M_DEBUG)      /* show compression=
 info */
-#define D_READ_WRITE        LOGLEV(9, 70, M_DEBUG)      /* show a=
ll tun/tcp/udp reads/writes/opens */
-#define D_PACKET_CONTENT    LOGLEV(9,=
 70, M_DEBUG)      /* show before/after encryption packet content */
-#defi=
ne D_TLS_NO_SEND_KEY   LOGLEV(9, 70, M_DEBUG)      /* show when no data cha=
nnel send-key exists */
-#define D_PID_PERSIST_DEBUG LOGLEV(9, 70, M_DEBUG)=
      /* show packet-id persist debugging info */
-#define D_LINK_RW_VERBOS=
E   LOGLEV(9, 70, M_DEBUG)      /* increase link reads/writes verbosity */
=
-#define D_STREAM_DEBUG      LOGLEV(9, 70, M_DEBUG)      /* show TCP stream=
 debug info */
-#define D_WIN32_IO          LOGLEV(9, 70, M_DEBUG)      /* =
win32 I/O debugging info */
-#define D_PKCS11_DEBUG      LOGLEV(9, 70, M_DE=
BUG)      /* show PKCS#11 debugging */
+#define D_TLS_DEBUG       LOGLEV(9,=
 70, M_DEBUG)        /* show detailed info from TLS routines */
+#define D_=
COMP            LOGLEV(9, 70, M_DEBUG)        /* show compression info */
+=
#define D_READ_WRITE      LOGLEV(9, 70, M_DEBUG)        /* show all tun/tcp=
/udp reads/writes/opens */
+#define D_PACKET_CONTENT  LOGLEV(9, 70, M_DEBUG=
)        /* show before/after encryption packet content */
+#define D_TLS_N=
O_SEND_KEY LOGLEV(9, 70, M_DEBUG)        /* show when no data channel send-=
key exists */
+#define D_LINK_RW_VERBOSE LOGLEV(9, 70, M_DEBUG)        /* i=
ncrease link reads/writes verbosity */
+#define D_STREAM_DEBUG    LOGLEV(9,=
 70, M_DEBUG)        /* show TCP stream debug info */
+#define D_WIN32_IO  =
      LOGLEV(9, 70, M_DEBUG)        /* win32 I/O debugging info */
+#define=
 D_PKCS11_DEBUG    LOGLEV(9, 70, M_DEBUG)        /* show PKCS#11 debugging =
*/
 
 #define D_SHAPER_DEBUG LOGLEV(10, 70, M_DEBUG)          /* show traff=
ic shaper info */
 
diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forw=
ard=2Ec
index 82cb6c9=2E=2Eba0e0ec 100644
--- a/src/openvpn/forward=2Ec
+++=
 b/src/openvpn/forward=2Ec
@@ -749,14 +749,6 @@
 static void
 process_coars=
e_timers(struct context *c)
 {
-    /* flush current packet-id to file once=
 per 60
-     * seconds if --replay-persist was specified */
-    if (packe=
t_id_persist_enabled(&c->c1=2Epid_persist)
-        && event_timeout_trigge=
r(&c->c2=2Epacket_id_persist_interval, &c->c2=2Etimeval, ETT_DEFAULT))
-   =
 {
-        packet_id_persist_save(&c->c1=2Epid_persist);
-    }
-
     /* =
Should we write timer-triggered status file */
     if (c->c1=2Estatus_outp=
ut
         && event_timeout_trigger(&c->c1=2Estatus_output->et, &c->c2=2Et=
imeval, ETT_DEFAULT))
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=
=2Ec
index 29c24f2=2E=2Eaef2f14 100644
--- a/src/openvpn/init=2Ec
+++ b/src=
/openvpn/init=2Ec
@@ -67,7 +67,6 @@
 /*
  * Crypto initialization flags
  *=
/
-#define CF_LOAD_PERSISTED_PACKET_ID (1 << 0)
 #define CF_INIT_TLS_MULTI =
          (1 << 1)
 #define CF_INIT_TLS_AUTH_STANDALONE (1 << 2)
 
@@ -738,=
8 +737,6 @@
 {
     context_clear_1(c);
 
-    packet_id_persist_init(&c->c=
1=2Epid_persist);
-
     init_connection_list(c);
 
     c->c1=2Elink_socke=
ts_num =3D c->options=2Ece=2Elocal_list->len;
@@ -1347,12 +1344,6 @@
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
@@ -2976,31 +2967,15 @@
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
 
@@ -3201,7 +3176,10 @@
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
@@ -3380,7 +3358,6 @@
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
@@ -3939,11 +3916,6 @@
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
@@ -4498,7 +4470,7 @@
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
@@ -4756,7 +4728,6 @@
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
index 970baa9=2E=2Ead6be88 100644
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
@@ -346,8 +328,6 @@
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
index 454d2d6=2E=2E9ed3964 100644
--- a/src/openvpn/options=2Ec
+++ b/src=
/openvpn/options=2Ec
@@ -571,8 +571,6 @@
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
@@ -7088,7 +7086,7 @@
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce938=
15
Gerrit-Change-Number: 2082
Gerrit-PatchSet: 9
Gerrit-Owner: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lic=
htenheld=2Ecom>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Ger=
rit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--qry/oIcu3eA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #9</strong> to the change originally created by Arne=
 Schwabe=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/208=
2?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Rem=
ove replay-persist<br><br>This feature is very niche and we do not think it=
 is something we<br>should maintain and support going forward=2E<br><br>Thi=
s feature saves a single packet id to replay-persist file=2E<br>This makes =
the feature only properly work in a p2p setup where both<br>sides use repla=
y-persist to save the last known packet id from the<br>peer=2E Even then it=
 will only prevent some packet replays until the<br>legitimate peer sends a=
 packet again=2E<br><br>In server mode (p2mp) each client context has its o=
wn replay state<br>and saving a single packet id is also not very useful wi=
th multiple<br>clients and multiple states=2E<br><br>Change-Id: I5ee231d157=
459e6406f1f4c12cd6c6e0fce93815<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2=
549=2Eorg&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br=
>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082<br>Message-Id:=
 &lt;20261109195550=2E6096-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://ww=
w=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41040=2Eh=
tml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<b=
r>M Changes=2Emd<br>M config=2Eh=2Ecmake=2Ein<br>M configure=2Eac<br>M doc/=
man-sections/link-options=2Erst<br>M doc/man-sections/tls-options=2Erst<br>=
M doc/man-sections/unsupported-options=2Erst<br>M src/openvpn/check_file_ac=
cess=2Ec<br>M src/openvpn/crypto=2Ec<br>M src/openvpn/crypto=2Eh<br>M src/o=
penvpn/errlevel=2Eh<br>M src/openvpn/forward=2Ec<br>M src/openvpn/init=2Ec<=
br>M src/openvpn/openvpn=2Eh<br>M src/openvpn/options=2Ec<br>M src/openvpn/=
options=2Eh<br>M src/openvpn/options_show=2Ec<br>M src/openvpn/packet_id=2E=
c<br>M src/openvpn/packet_id=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/=
syshead=2Eh<br>M src/openvpn/tls_crypt=2Ec<br>21 files changed, 33 insertio=
ns(+), 330 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/82/2082/9</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/Cha=
nges=2Emd b/Changes=2Emd</span><br><span>index 7f47f77=2E=2E89a72fe 100644<=
/span><br><span>--- a/Changes=2Emd</span><br><span>+++ b/Changes=2Emd</span=
><br><span>@@ -30,6 +30,12 @@</span><br><span>   &quot;too complicated&quot=
;, using `--peer-fingerprint` makes TLS mode about as easy as</span><br><sp=
an>   using `--secret`=2E</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+* **`replay-persist` has been removed**</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  This feature has been removed as it was never pr=
operly implemented for</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  server mode and generally was a niche feature=2E If the option is pres=
ent</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  it will be ign=
ored=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> ## Maintainer-visible changes</span><br><span> </span><br><span> - Th=
e configure-time option `--enable-debug` is no longer  available</span><br>=
<span>diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein</span>=
<br><span>index 5e06a63=2E=2Ef7818cf 100644</span><br><span>--- a/config=2E=
h=2Ecmake=2Ein</span><br><span>+++ b/config=2Eh=2Ecmake=2Ein</span><br><spa=
n>@@ -285,9 +285,6 @@</span><br><span> /* Define to 1 if you have the &lt;s=
ys/epoll=2Eh&gt; header file=2E */</span><br><span> #cmakedefine HAVE_SYS_E=
POLL_H</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-/* Define to 1 if you have the &lt;sys/file=2Eh&gt; header file=2E */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#undef HAVE_SYS_FILE_H</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* De=
fine to 1 if you have the &lt;sys/inotify=2Eh&gt; header file=2E */</span><=
br><span> #cmakedefine HAVE_SYS_INOTIFY_H</span><br><span> </span><br><span=
>diff --git a/configure=2Eac b/configure=2Eac</span><br><span>index 5f18798=
=2E=2E9326c4e 100644</span><br><span>--- a/configure=2Eac</span><br><span>+=
++ b/configure=2Eac</span><br><span>@@ -453,7 +453,7 @@</span><br><span> ])=
</span><br><span> AC_CHECK_HEADERS([ \</span><br><span> 	sys/time=2Eh sys/i=
octl=2Eh sys/stat=2Eh \</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	sys/mman=2Eh sys/file=2Eh sys/wait=2Eh \</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+	sys/mman=2Eh sys/wait=2Eh \</span><br><span> 	libg=
en=2Eh stropts=2Eh \</span><br><span> 	syslog=2Eh pwd=2Eh grp=2Eh \</span><=
br><span> 	sys/sockio=2Eh sys/uio=2Eh \</span><br><span>@@ -561,8 +561,7 @@=
</span><br><span> AC_CHECK_FUNCS([ \</span><br><span> 	daemon chroot getpwn=
am setuid nice dup dup2 \</span><br><span> 	syslog openlog mlockall getrlim=
it getgrnam setgid \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
setgroups flock gettimeofday \</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-	setsid chdir \</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	setgroups gettimeofday setsid chdir \</span><br><span> 	chsize ftrunc=
ate execve getpeereid basename dirname \</span><br><span> 	epoll_create str=
lcpy strsep strtok_r \</span><br><span> ])</span><br><span>diff --git a/doc=
/man-sections/link-options=2Erst b/doc/man-sections/link-options=2Erst</spa=
n><br><span>index 735ee51=2E=2Ebbdcf7f 100644</span><br><span>--- a/doc/man=
-sections/link-options=2Erst</span><br><span>+++ b/doc/man-sections/link-op=
tions=2Erst</span><br><span>@@ -440,19 +440,6 @@</span><br><span>   physica=
l IP layer=2E The problem is easily fixed by simply using TCP as</span><br>=
<span>   the VPN transport layer=2E</span><br><span> </span><br><span>---re=
play-persist file</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Pe=
rsist replay-protection state across sessions using ``file`` to save</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-  and reload the state=2E</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  This option will keep a disk copy of the =
current replay protection state</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-  (i=2Ee=2E the most recent packet timestamp and sequence number =
received from</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  the re=
mote peer), so that if an OpenVPN session is stopped and</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  restarted, it will reject any replays =
of packets which were already</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  received by the prior session=2E</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  This option only makes sense when replay protection is enabled (the</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-  default) and you are usin=
g TLS mode with ``--tls-auth``=2E</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span> --session-timeout n</span><br><span>   Raises=
 :code:`SIGTERM` for the client instance after ``n`` seconds since</span><b=
r><span>   the beginning of the session, forcing OpenVPN to disconnect=2E</=
span><br><span>diff --git a/doc/man-sections/tls-options=2Erst b/doc/man-se=
ctions/tls-options=2Erst</span><br><span>index c4aa810=2E=2Ede4d324 100644<=
/span><br><span>--- a/doc/man-sections/tls-options=2Erst</span><br><span>++=
+ b/doc/man-sections/tls-options=2Erst</span><br><span>@@ -370,10 +370,7 @@=
</span><br><span>   level has had a chance to authenticate the peer=2E The =
result is that</span><br><span>   packets without the correct signature can=
 be dropped immediately upon</span><br><span>   reception, before they have=
 a chance to consume additional system</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  resources such as by initiating a TLS handshake=2E ``--t=
ls-auth`` can be</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  str=
engthened by adding the ``--replay-persist`` option which will keep</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  OpenVPN&#39;s replay protec=
tion state in a file so that it is not lost</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  across restarts=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  resources such as by initiating a TLS handshake=2E=
</span><br><span> </span><br><span>   It should be emphasized that this fea=
ture is optional and that the key</span><br><span>   file used with ``--tls=
-auth`` gives a peer nothing more than the power</span><br><span>diff --git=
 a/doc/man-sections/unsupported-options=2Erst b/doc/man-sections/unsupporte=
d-options=2Erst</span><br><span>index 2794f12=2E=2E368805e 100644</span><br=
><span>--- a/doc/man-sections/unsupported-options=2Erst</span><br><span>+++=
 b/doc/man-sections/unsupported-options=2Erst</span><br><span>@@ -79,3 +79,=
8 @@</span><br><span> </span><br><span> --allow-deprecated-insecure-static-=
crypto</span><br><span>   Removed in OpenVPN 2=2E8 as --secret was also rem=
oved=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+--replay-persist</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  Removed in OpenVPN 2=2E8=2E This=
 option never really worked well with ``--server``</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  and the usefulness of this option in p2p s=
etups is not very high either=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  It is now ignored if present in the configuration file=2E</s=
pan><br><span>diff --git a/src/openvpn/check_file_access=2Ec b/src/openvpn/=
check_file_access=2Ec</span><br><span>index ab2535d=2E=2Ebe9b4b2 100644</sp=
an><br><span>--- a/src/openvpn/check_file_access=2Ec</span><br><span>+++ b/=
src/openvpn/check_file_access=2Ec</span><br><span>@@ -312,9 +312,6 @@</span=
><br><span>                                          ce-&gt;tls_crypt_v2_fi=
le, R_OK, &quot;--tls-crypt-v2&quot;);</span><br><span>     }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D che=
ck_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options-&gt;packet_id_fil=
e,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
           R_OK | W_OK, &quot;--replay-persist&quot;);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* ** Password files=
 ** */</span><br><span>     errs |=3D check_file_access(CHKACC_FILE | CHKAC=
C_ACPTSTDIN | CHKACC_PRIVATE,</span><br><span>                             =
  options-&gt;key_pass_file, R_OK, &quot;--askpass&quot;);</span><br><span>=
diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><spa=
n>index a8ad7f0=2E=2E6efa005 100644</span><br><span>--- a/src/openvpn/crypt=
o=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -403,=
10 +403,6 @@</span><br><span>     if (packet_id_test(recv, pin))</span><br>=
<span>     {</span><br><span>         packet_id_add(recv, pin);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        if (opt-&gt;pid_persist &=
amp;&amp; (opt-&gt;flags &amp; CO_PACKET_ID_LONG_FORM))</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            packet_id_persist_save_obj(opt-&gt;pid_pe=
rsist, &amp;opt-&gt;packet_id);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        }</span><br><span>         ret =3D true;</span><br><span>=
     }</span><br><span>     else</span><br><span>diff --git a/src/openvpn/c=
rypto=2Eh b/src/openvpn/crypto=2Eh</span><br><span>index a03c5ce=2E=2E7e240=
d2 100644</span><br><span>--- a/src/openvpn/crypto=2Eh</span><br><span>+++ =
b/src/openvpn/crypto=2Eh</span><br><span>@@ -332,11 +332,6 @@</span><br><sp=
an>                                  *   The packet id also used as the IV<=
/span><br><span>                                  *   for AEAD/OFB/CFG ciph=
ers=2E</span><br><span>                                  */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    struct packet_id_persist *pid_per=
sist;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /**&lt; Pers=
istent packet ID state for</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-     *   keeping state between successive</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-     *   OpenVPN process startups=2E */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #define CO_PAC=
KET_ID_LONG_FORM         (1u &lt;&lt; 0)</span><br><span>     /**&lt; Bit-f=
lag indicating whether to use</span><br><span>      *   OpenVPN&#39;s long =
packet ID format=2E */</span><br><span>diff --git a/src/openvpn/errlevel=2E=
h b/src/openvpn/errlevel=2Eh</span><br><span>index e52cb65=2E=2E5cea0ad 100=
644</span><br><span>--- a/src/openvpn/errlevel=2Eh</span><br><span>+++ b/sr=
c/openvpn/errlevel=2Eh</span><br><span>@@ -64,7 +64,6 @@</span><br><span> #=
define D_MULTI_ERRORS   LOGLEV(1, 9, M_NONFATAL)  /* show multi-client serv=
er errors */</span><br><span> #define D_EVENT_ERRORS   LOGLEV(1, 10, M_NONF=
ATAL) /* show event=2E[ch] errors */</span><br><span> #define D_PUSH_ERRORS=
    LOGLEV(1, 11, M_NONFATAL) /* show push/pull errors */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#define D_PID_PERSIST    LOGLEV(1, 12, =
M_NONFATAL) /* show packet_id persist errors */</span><br><span> #define D_=
FRAG_ERRORS    LOGLEV(1, 13, M_NONFATAL) /* show fragmentation errors */</s=
pan><br><span> #define D_ALIGN_ERRORS   LOGLEV(1, 14, M_NONFATAL) /* show b=
ad struct alignments */</span><br><span> </span><br><span>@@ -159,16 +158,1=
5 @@</span><br><span> #define D_EVENT_WAIT        LOGLEV(8, 70, M_DEBUG)   =
   /* show detailed info from event waits */</span><br><span> #define D_MUL=
TI_TCP         LOGLEV(8, 70, M_DEBUG)      /* show debug info from mtcp=2Ec=
 */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define D_TLS_DEBUG         LOGLEV(9, 70, M_DEBUG)      /* show detailed in=
fo from TLS routines */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define D_COMP              LOGLEV(9, 70, M_DEBUG)      /* show compressi=
on info */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define D_R=
EAD_WRITE        LOGLEV(9, 70, M_DEBUG)      /* show all tun/tcp/udp reads/=
writes/opens */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defin=
e D_PACKET_CONTENT    LOGLEV(9, 70, M_DEBUG)      /* show before/after encr=
yption packet content */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define D_TLS_NO_SEND_KEY   LOGLEV(9, 70, M_DEBUG)      /* show when no =
data channel send-key exists */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#define D_PID_PERSIST_DEBUG LOGLEV(9, 70, M_DEBUG)      /* show p=
acket-id persist debugging info */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#define D_LINK_RW_VERBOSE   LOGLEV(9, 70, M_DEBUG)      /* inc=
rease link reads/writes verbosity */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define D_STREAM_DEBUG      LOGLEV(9, 70, M_DEBUG)      /* s=
how TCP stream debug info */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#define D_WIN32_IO          LOGLEV(9, 70, M_DEBUG)      /* win32 I/O=
 debugging info */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#de=
fine D_PKCS11_DEBUG      LOGLEV(9, 70, M_DEBUG)      /* show PKCS#11 debugg=
ing */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_TLS=
_DEBUG       LOGLEV(9, 70, M_DEBUG)        /* show detailed info from TLS r=
outines */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D=
_COMP            LOGLEV(9, 70, M_DEBUG)        /* show compression info */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_READ_WRITE=
      LOGLEV(9, 70, M_DEBUG)        /* show all tun/tcp/udp reads/writes/op=
ens */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define D_PAC=
KET_CONTENT  LOGLEV(9, 70, M_DEBUG)        /* show before/after encryption =
packet content */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine D_TLS_NO_SEND_KEY LOGLEV(9, 70, M_DEBUG)        /* show when no data =
channel send-key exists */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define D_LINK_RW_VERBOSE LOGLEV(9, 70, M_DEBUG)        /* increase =
link reads/writes verbosity */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define D_STREAM_DEBUG    LOGLEV(9, 70, M_DEBUG)        /* show =
TCP stream debug info */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#define D_WIN32_IO        LOGLEV(9, 70, M_DEBUG)        /* win32 I/O d=
ebugging info */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine D_PKCS11_DEBUG    LOGLEV(9, 70, M_DEBUG)        /* show PKCS#11 debugg=
ing */</span><br><span> </span><br><span> #define D_SHAPER_DEBUG LOGLEV(10,=
 70, M_DEBUG)          /* show traffic shaper info */</span><br><span> </sp=
an><br><span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec=
</span><br><span>index 82cb6c9=2E=2Eba0e0ec 100644</span><br><span>--- a/sr=
c/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</span><=
br><span>@@ -749,14 +749,6 @@</span><br><span> static void</span><br><span>=
 process_coarse_timers(struct context *c)</span><br><span> {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    /* flush current packet-id to fi=
le once per 60</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * =
seconds if --replay-persist was specified */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (packet_id_persist_enabled(&amp;c-&gt;c1=2Epi=
d_persist)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &am=
p;&amp; event_timeout_trigger(&amp;c-&gt;c2=2Epacket_id_persist_interval, &=
amp;c-&gt;c2=2Etimeval, ETT_DEFAULT))</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        packet_id_persist_save(&amp;c-&gt;c1=2Epid_persist);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span>     /* Should we write timer-trigg=
ered status file */</span><br><span>     if (c-&gt;c1=2Estatus_output</span=
><br><span>         &amp;&amp; event_timeout_trigger(&amp;c-&gt;c1=2Estatus=
_output-&gt;et, &amp;c-&gt;c2=2Etimeval, ETT_DEFAULT))</span><br><span>diff=
 --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index =
29c24f2=2E=2Eaef2f14 100644</span><br><span>--- a/src/openvpn/init=2Ec</spa=
n><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -67,7 +67,6 @@</s=
pan><br><span> /*</span><br><span>  * Crypto initialization flags</span><br=
><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CF=
_LOAD_PERSISTED_PACKET_ID (1 &lt;&lt; 0)</span><br><span> #define CF_INIT_T=
LS_MULTI           (1 &lt;&lt; 1)</span><br><span> #define CF_INIT_TLS_AUTH=
_STANDALONE (1 &lt;&lt; 2)</span><br><span> </span><br><span>@@ -738,8 +737=
,6 @@</span><br><span> {</span><br><span>     context_clear_1(c);</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    packet_id=
_persist_init(&amp;c-&gt;c1=2Epid_persist);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span>     init_connection_list(c);</span>=
<br><span> </span><br><span>     c-&gt;c1=2Elink_sockets_num =3D c-&gt;opti=
ons=2Ece=2Elocal_list-&gt;len;</span><br><span>@@ -1347,12 +1344,6 @@</span=
><br><span>                                now);</span><br><span>         }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     /* initialize packet_id persistence timer */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        if (c-&gt;options=2Epacket_id_file)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            event_timeout_init(&amp;c=
-&gt;c2=2Epacket_id_persist_interval, 60, now);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span>         /* initialize tmp_int optimization =
that limits the number of times we call</span><br><span>          * tls_mul=
ti_process in the main event loop */</span><br><span>         interval_init=
(&amp;c-&gt;c2=2Etmp_int, TLS_MULTI_HORIZON, TLS_MULTI_REFRESH);</span><br>=
<span>@@ -2976,31 +2967,15 @@</span><br><span> }</span><br><span> </span><b=
r><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-i=
nit_crypto_pre(struct context *c, const unsigned int flags)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (c-&gt;options=2Eengine)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        crypto_init_lib_engine(c-&gt;options=2Eengine);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (flags &amp; CF_LOAD_PERSISTED_PACKET_ID)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        /* load a persisted packet-id for cross-sessi=
on replay-protection */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        if (c-&gt;options=2Epacket_id_file)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            packet_id_persist_load(&amp;c-&gt;c1=2Epid_persist,=
 c-&gt;options=2Epacket_id_file);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sta=
tic void</span><br><span> do_init_crypto_test(struct context *c)</span><br>=
<span> {</span><br><span>     const struct options *options =3D &amp;c-&gt;=
options;</span><br><span>     ASSERT(options-&gt;test_crypto);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_crypto_=
pre(c, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c=
-&gt;options=2Eengine)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cry=
pto_init_lib_engine(c-&gt;options=2Eengine);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     c-&gt=
;c2=2Ecrypto_options=2Eflags |=3D CO_PACKET_ID_LONG_FORM;</span><br><span> =
</span><br><span>@@ -3201,7 +3176,10 @@</span><br><span>     ASSERT(options=
-&gt;tls_server || options-&gt;tls_client);</span><br><span>     ASSERT(!op=
tions-&gt;test_crypto);</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    init_crypto_pre(c, flags);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (c-&gt;options=2Eengine)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        crypto_init_lib_engine(c-&gt;options=
=2Eengine);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span> </span><br><span>     /* Make sure we are either a TLS clien=
t or server but not both */</span><br><span>     ASSERT(options-&gt;tls_ser=
ver =3D=3D !options-&gt;tls_client);</span><br><span>@@ -3380,7 +3358,6 @@<=
/span><br><span>     if (to=2Etls_wrap=2Emode =3D=3D TLS_WRAP_AUTH || to=2E=
tls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT)</span><br><span>     {</span><br><sp=
an>         to=2Etls_wrap=2Eopt=2Ekey_ctx_bi =3D c-&gt;c1=2Eks=2Etls_wrap_k=
ey;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        to=2Etls_w=
rap=2Eopt=2Epid_persist =3D &amp;c-&gt;c1=2Epid_persist;</span><br><span>  =
       to=2Etls_wrap=2Eopt=2Eflags |=3D CO_PACKET_ID_LONG_FORM;</span><br><=
span>         to=2Etls_wrap=2Eoriginal_wrap_keydata =3D c-&gt;c1=2Eks=2Eori=
ginal_wrap_keydata;</span><br><span>     }</span><br><span>@@ -3939,11 +391=
6,6 @@</span><br><span> do_close_packet_id(struct context *c)</span><br><sp=
an> {</span><br><span>     packet_id_free(&amp;c-&gt;c2=2Ecrypto_options=2E=
packet_id);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    packet=
_id_persist_save(&amp;c-&gt;c1=2Epid_persist);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (!(c-&gt;sig-&gt;signal_received =3D=3D SIG=
USR1))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        packet_id_persist_close=
(&amp;c-&gt;c1=2Epid_persist);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span> }</span><br><span> </span><br><span> #ifdef=
 ENABLE_FRAGMENT</span><br><span>@@ -4498,7 +4470,7 @@</span><br><span>    =
     }</span><br><span>         else if (c-&gt;mode =3D=3D CM_P2P)</span><b=
r><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         crypto_flags =3D CF_LOAD_PERSISTED_PACKET_ID | CF_INIT_TLS_MULTI;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            crypto_f=
lags =3D CF_INIT_TLS_MULTI;</span><br><span>         }</span><br><span>    =
     else if (child)</span><br><span>         {</span><br><span>@@ -4756,7 =
+4728,6 @@</span><br><span>     ALLOC_OBJ_CLEAR_GC(dest-&gt;sig, struct sig=
nal_info, &amp;dest-&gt;gc);</span><br><span> </span><br><span>     /* c1 i=
nit */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    packet_id_p=
ersist_init(&amp;dest-&gt;c1=2Epid_persist);</span><br><span>     dest-&gt;=
c1=2Elink_sockets_num =3D 1;</span><br><span>     do_link_socket_addr_new(d=
est);</span><br><span> </span><br><span>diff --git a/src/openvpn/openvpn=2E=
h b/src/openvpn/openvpn=2Eh</span><br><span>index 970baa9=2E=2Ead6be88 1006=
44</span><br><span>--- a/src/openvpn/openvpn=2Eh</span><br><span>+++ b/src/=
openvpn/openvpn=2Eh</span><br><span>@@ -75,21 +75,6 @@</span><br><span> };<=
/span><br><span> </span><br><span> /*</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * struct packet_id_persist should be empty if we are not</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * building with crypto=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#ifndef PACKET_ID_H</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-struct packet_id_persist</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    int dummy;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static=
 inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-packet_id=
_persist_init(struct packet_id_persist *p)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-/*</span><br><span>  * Packet processing buffers=2E</sp=
an><br><span>  */</span><br><span> struct context_buffers</span><br><span>@=
@ -167,9 +152,6 @@</span><br><span>     /* preresolved and cached host name=
s */</span><br><span>     struct cached_dns_entry *dns_cache;</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* persist cr=
ypto sequence number to/from file */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    struct packet_id_persist pid_persist;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     struct tuntap *tun=
tap; /**&lt; Tun/tap virtual network interface=2E */</span><br><span>     b=
ool tuntap_owned;     /**&lt; Whether the tun/tap interface should</span><b=
r><span>                             *   be cleaned up when this %context i=
s</span><br><span>@@ -346,8 +328,6 @@</span><br><span>      *   Channel Cry=
pto module\endlink to</span><br><span>      *   process data channel packet=
=2E */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    struct event_timeout packet_id_persist_interval;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifdef USE_COMP</span><=
br><span>     struct compress_context *comp_context;</span><br><span>     /=
**&lt; Compression context used by the</span><br><span>diff --git a/src/ope=
nvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 454d2d6=2E=
=2E9ed3964 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><=
span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -571,8 +571,6 @@</spa=
n><br><span>     &quot;--replay-window n [t]  : Use a replay protection sli=
ding window of size n\n&quot;</span><br><span>     &quot;                  =
       and a time window of t seconds=2E\n&quot;</span><br><span>     &quot=
;                         Default n=3D%d t=3D%d\n&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    &quot;--replay-persist file : Persist=
 replay-protection state across sessions\n&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    &quot;                  using file=2E\n&quot=
;</span><br><span>     &quot;--test-crypto   : Run a self-test of crypto fe=
atures enabled=2E\n&quot;</span><br><span>     &quot;                  For =
debugging only=2E\n&quot;</span><br><span>     &quot;\n&quot;</span><br><sp=
an>@@ -7088,7 +7086,7 @@</span><br><span>     else if (streq(p[0], &quot;re=
play-persist&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     =
{</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;packet_id_file =
=3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ms=
g(M_WARN, &quot;DEPRECATED OPTION: --replay-persist option ignored=2E&quot;=
);</span><br><span>     }</span><br><span>     else if (streq(p[0], &quot;t=
est-crypto&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>=
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><s=
pan>index 38554a1=2E=2Eb390ebc 100644</span><br><span>--- a/src/openvpn/opt=
ions=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -=
582,7 +582,6 @@</span><br><span>     bool mute_replay_warnings;</span><br><=
span>     int replay_window;</span><br><span>     int replay_time;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    const char *packet_id_file=
;</span><br><span>     bool test_crypto;</span><br><span> </span><br><span>=
     /* TLS (control channel) parms */</span><br><span>diff --git a/src/ope=
nvpn/options_show=2Ec b/src/openvpn/options_show=2Ec</span><br><span>index =
321a37b=2E=2E54f9c4c 100644</span><br><span>--- a/src/openvpn/options_show=
=2Ec</span><br><span>+++ b/src/openvpn/options_show=2Ec</span><br><span>@@ =
-501,7 +501,6 @@</span><br><span>     SHOW_BOOL(mute_replay_warnings);</spa=
n><br><span>     SHOW_INT(replay_window);</span><br><span>     SHOW_INT(rep=
lay_time);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_ST=
R(packet_id_file);</span><br><span>     SHOW_BOOL(test_crypto);</span><br><=
span> </span><br><span>     SHOW_BOOL(tls_server);</span><br><span>diff --g=
it a/src/openvpn/packet_id=2Ec b/src/openvpn/packet_id=2Ec</span><br><span>=
index 9dd6ce3=2E=2Ef1fadd6 100644</span><br><span>--- a/src/openvpn/packet_=
id=2Ec</span><br><span>+++ b/src/openvpn/packet_id=2Ec</span><br><span>@@ -=
426,146 +426,6 @@</span><br><span>     return BSTR(&amp;out);</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-/* initialize the packet_id_persist structure in a disabled state */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-packet_id_persist_init(struct packet_id_per=
sist *p)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    p-&gt;filename =3D NULL;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    p-&gt;fd =3D -1;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    p-&gt;time =3D p-&gt;ti=
me_last_written =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    p-&gt;id =3D p-&gt;id_last_written =3D 0;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* close the fil=
e descriptor if it is open, and switch to disabled state */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-packet_id_persist_close(struct packet_id_persist *p)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (packet_id_persist_enabled(p))</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (close(p-&gt;fd))</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            msg(D_PID_PERSIST | M_ERRNO, &quot;C=
lose error on --replay-persist file %s&quot;, p-&gt;filename);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        packet_id_persist_init(p);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* load persist=
ed rec packet_id (time and id) only once from file, and set state to enable=
d */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-packet_id_persist_load(struct pack=
et_id_persist *p, const char *filename)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (!packet_id_persist_enabled(p))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        /* open packet-id persist file for both read and wr=
ite */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        p-&gt;f=
d =3D platform_open(filename, O_CREAT | O_RDWR | O_BINARY, S_IRUSR | S_IWUS=
R);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (p-&gt;=
fd =3D=3D -1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_PI=
D_PERSIST | M_ERRNO, &quot;Cannot open --replay-persist file %s for read/wr=
ite&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     filename);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            struct packet_id_persist_fi=
le_image image;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      ssize_t n;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(HAVE_FLOCK) &a=
mp;&amp; defined(LOCK_EX) &amp;&amp; defined(LOCK_NB)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (flock(p-&gt;fd, LOCK_EX | L=
OCK_NB))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(M=
_ERR, &quot;Cannot obtain exclusive lock on --replay-persist file %s&quot;,=
 filename);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            p-&gt;filename =3D filename;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            n =3D read(p-&gt;fd, &a=
mp;image, sizeof(image));</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            if (n =3D=3D sizeof(image))</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                p-&gt;time =3D p-&gt;time_last_written =3D im=
age=2Etime;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      p-&gt;id =3D p-&gt;id_last_written =3D image=2Eid;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                dmsg(D_PID_PERSIST_DEBUG=
, &quot;PID Persist Read from %s: %s&quot;, p-&gt;filename,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                     packet_id_persis=
t_print(p, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    else if (n =3D=3D -1)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            msg(D_PID_PERSIST | M_ERRNO, &quot;Read error on --replay-persi=
st file %s&quot;, p-&gt;filename);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-/* save persisted rec packet_id (time and id) to file (only if e=
nabled state) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-packet_id_persist_save=
(struct packet_id_persist *p)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (pack=
et_id_persist_enabled(p) &amp;&amp; p-&gt;time</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        &amp;&amp; (p-&gt;time !=3D p-&gt;time_las=
t_written || p-&gt;id !=3D p-&gt;id_last_written))</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        struct packet_id_persist_file_image image;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        CLEAR(image);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        off_t seek_ret;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        struct gc_arena gc =3D =
gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        image=2Etime =3D p-&gt;ti=
me;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        image=2Eid=
 =3D p-&gt;id;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 seek_ret =3D lseek(p-&gt;fd, (off_t)0, SEEK_SET);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if (seek_ret =3D=3D (off_t)0)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            const ssize_t n =3D write(p-&g=
t;fd, &amp;image, sizeof(image));</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            if (n =3D=3D sizeof(image))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                p-&gt;time_last_written =3D p-&gt;t=
ime;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                p=
-&gt;id_last_written =3D p-&gt;id;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                dmsg(D_PID_PERSIST_DEBUG, &quot;PID Persist Wr=
ite to %s: %s&quot;, p-&gt;filename,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                     packet_id_persist_print(p, &amp;gc));</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            else</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                msg(D_PID_PERSIST | M_ERRNO=
, &quot;Cannot write to --replay-persist file %s&quot;,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    p-&gt;filename);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            msg(D_PID_PERSIST | M_ERRNO, &quot;Cannot seek to begin=
ning of --replay-persist file %s&quot;,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                p-&gt;filename);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        gc_free(&amp;gc);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-/* transfer packet_id_persist -&gt; =
packet_id */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-packet_id_persist_load_obj=
(const struct packet_id_persist *p, struct packet_id *pid)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (p &amp;&amp; pid &amp;&amp; packet_id_persist_enab=
led(p) &amp;&amp; p-&gt;time)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
pid-&gt;rec=2Etime =3D p-&gt;time;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        pid-&gt;rec=2Eid =3D p-&gt;id;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-const char *</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-packet_id_persist_print(const stru=
ct packet_id_persist *p, struct gc_arena *gc)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    struct buffer out =3D alloc_buf_gc(256, gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    buf_printf(&amp;out, &quot;[&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (packet_id_persist_enabled(p))</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        buf_printf(&amp;out, &quot; #&quot; packet_id_format, (p=
acket_id_print_type)p-&gt;id);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        if (p-&gt;time)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           buf_printf(&amp;out, &quot; / time =3D (&quot; packet_id_format =
&quot;) %s&quot;, (packet_id_print_type)p-&gt;time,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                       time_string(p-&gt;ti=
me, 0, false, gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    buf_printf(&amp;out, &quot; ]&quot;);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    return (char *)out=2Edata;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifndef ENABLE_SMALL</sp=
an><br><span> </span><br><span> static void</span><br><span>diff --git a/sr=
c/openvpn/packet_id=2Eh b/src/openvpn/packet_id=2Eh</span><br><span>index 4=
8752d3=2E=2Ec374ccb 100644</span><br><span>--- a/src/openvpn/packet_id=2Eh<=
/span><br><span>+++ b/src/openvpn/packet_id=2Eh</span><br><span>@@ -125,26 =
+125,6 @@</span><br><span> };</span><br><span> </span><br><span> /*</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * file to facilitate cross-s=
ession persistence</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
of time/id</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-struct packet_id_persist</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    const char *filename;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    int fd;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    time_t time;       /* time stamp */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    packet_id_type id; /* sequence=
 number */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    time_t =
time_last_written;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 packet_id_type id_last_written;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-struct packet_id_persist_file=
_image</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    time_t time;       /* time stam=
p */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    packet_id_typ=
e id; /* sequence number */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span>  * Keep a reco=
rd of our current packet-id state</span><br><span>  * on the sending side=
=2E</span><br><span>  */</span><br><span>@@ -222,28 +202,6 @@</span><br><sp=
an> void packet_id_reap(struct packet_id_rec *p);</span><br><span> </span><=
br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * packet=
 ID persistence</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/* initialize the packet_id_persist structu=
re in a disabled state */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-void packet_id_persist_init(struct packet_id_persist *p);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-/* close the file descriptor if it is open, and switch t=
o disabled state */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-vo=
id packet_id_persist_close(struct packet_id_persist *p);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-/* load persisted rec packet_id (time and id) only once from =
file, and set state to enabled */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-void packet_id_persist_load(struct packet_id_persist *p, const =
char *filename);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-/* save persisted rec pack=
et_id (time and id) to file (only if enabled state) */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-void packet_id_persist_save(struct packet_=
id_persist *p);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-/* transfer packet_id_persi=
st -&gt; packet_id */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
void packet_id_persist_load_obj(const struct packet_id_persist *p, struct p=
acket_id *pid);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-/* return an ascii string r=
epresenting a packet_id_persist object */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-const char *packet_id_persist_print(const struct packet=
_id_persist *p, struct gc_arena *gc);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</s=
pan><br><span>  * Read/write a packet ID to/from the buffer=2E  Short form =
is sequence number</span><br><span>  * only=2E  Long form is sequence numbe=
r and timestamp=2E</span><br><span>  */</span><br><span>@@ -273,27 +231,6 @=
@</span><br><span>     return pid-&gt;rec=2Einitialized;</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* =
are we in enabled state? */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-packet_id_persist_enabled(const struct packet_id_persist *p)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    return p-&gt;fd &gt;=3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* transf=
er packet_id -&gt; packet_id_persist</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-   Note: Only supported for non-epoch format (i=2Ee=2E 32bit=
 ID, not 64bit format),</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-   must be enforced at the caller=2E</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
tatic inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pack=
et_id_persist_save_obj(struct packet_id_persist *p, const struct packet_id =
*pid)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (packet_id_persist_enabled(p)=
 &amp;&amp; pid-&gt;rec=2Etime &amp;&amp; pid-&gt;rec=2Eid &lt;=3D PACKET_I=
D_MAX)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        p-&gt;time =3D pid-&gt;=
rec=2Etime;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        p-=
&gt;id =3D (packet_id_type)pid-&gt;rec=2Eid;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> /**</span><br><span>  * Reset the current send packet id to its initia=
l state=2E</span><br><span>  * Use very carefully (e=2Eg=2E in the standalo=
ne reset packet context) to</span><br><span>diff --git a/src/openvpn/ssl=2E=
c b/src/openvpn/ssl=2Ec</span><br><span>index a538b52=2E=2Ecdb94ed 100644</=
span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/=
ssl=2Ec</span><br><span>@@ -874,8 +874,6 @@</span><br><span>     packet_id_=
init(&amp;ks-&gt;crypto_options=2Epacket_id, session-&gt;opt-&gt;replay_win=
dow,</span><br><span>                    session-&gt;opt-&gt;replay_time, &=
quot;SSL&quot;, ks-&gt;key_id);</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    ks-&gt;crypto_options=2Epid_persist =3D NUL=
L;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #=
ifdef ENABLE_MANAGEMENT</span><br><span>     ks-&gt;mda_key_id =3D session-=
&gt;opt-&gt;mda_context-&gt;mda_key_id_counter++;</span><br><span> #endif</=
span><br><span>@@ -1037,9 +1035,6 @@</span><br><span>         session-&gt;t=
ls_wrap=2Eopt=2Epacket_id=2Esend=2Eid =3D EARLY_NEG_START;</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    /* load most recent packet-id to replay protect on --tls-auth */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    packet_id_persist_loa=
d_obj(session-&gt;tls_wrap=2Eopt=2Epid_persist, &amp;session-&gt;tls_wrap=
=2Eopt=2Epacket_id);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span>     key_state_init(session, &amp;session-&gt;key[KS_PRIMAR=
Y]);</span><br><span> </span><br><span>     dmsg(D_TLS_DEBUG, &quot;TLS: tl=
s_session_init: new session object, sid=3D%s&quot;,</span><br><span>diff --=
git a/src/openvpn/syshead=2Eh b/src/openvpn/syshead=2Eh</span><br><span>ind=
ex 1d6cdc2=2E=2E65baee3 100644</span><br><span>--- a/src/openvpn/syshead=2E=
h</span><br><span>+++ b/src/openvpn/syshead=2Eh</span><br><span>@@ -127,10 =
+127,6 @@</span><br><span> #include &lt;fcntl=2Eh&gt;</span><br><span> #end=
if</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
ifdef HAVE_SYS_FILE_H</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#include &lt;sys/file=2Eh&gt;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span> /* These headers belong to C99 and should be always be present *=
/</span><br><span> #include &lt;stdlib=2Eh&gt;</span><br><span> #include &l=
t;inttypes=2Eh&gt;</span><br><span>diff --git a/src/openvpn/tls_crypt=2Ec b=
/src/openvpn/tls_crypt=2Ec</span><br><span>index d66b96d=2E=2E3d27e40 10064=
4</span><br><span>--- a/src/openvpn/tls_crypt=2Ec</span><br><span>+++ b/src=
/openvpn/tls_crypt=2Ec</span><br><span>@@ -109,7 +109,6 @@</span><br><span>=
     session-&gt;tls_wrap_reneg=2Emode =3D TLS_WRAP_CRYPT;</span><br><span>=
     session-&gt;tls_wrap_reneg=2Ecleanup_key_ctx =3D true;</span><br><span=
>     session-&gt;tls_wrap_reneg=2Ework =3D alloc_buf(BUF_SIZE(&amp;session=
-&gt;opt-&gt;frame));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    session-&gt;tls_wrap_reneg=2Eopt=2Epid_persist =3D NULL;</span><br><spa=
n> </span><br><span>     packet_id_init(&amp;session-&gt;tls_wrap_reneg=2Eo=
pt=2Epacket_id, session-&gt;opt-&gt;replay_window,</span><br><span>        =
            session-&gt;opt-&gt;replay_time, &quot;TLS_WRAP_RENEG&quot;, se=
ssion-&gt;key_id);</span><br></pre><p>To view, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail">change 2082</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5ee231d15745=
9e6406f1f4c12cd6c6e0fce93815 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 2082 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Fr=
ank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;r=
azvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ope=
nvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body><=
/html>
--qry/oIcu3eA=--


--===============6191783912036293968==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6191783912036293968==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6191783912036293968==--

