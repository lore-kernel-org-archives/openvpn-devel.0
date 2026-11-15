Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C372A606A32C
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=J3x6h2mO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JpN7suGx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=UWs8wd6Y;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dgDIexL3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=P0dZrf2o4HhRq83B6RdIYMQ5wLMLbt1cUaon1KPCqco=; b=J3x6h2mOUuGVS6YeJ+OCZcYJHg
	Thh3gMVmFDtq0wWyKEx/kQ4c4npRRjuKvyj5svYEtpPKGAMOfG6beUt1Tp0x7NV2Xo2AxrLH/koL0
	qAFd3wG1r9n6xgwEgzTTWbAh/ivIeGGSaN55rGXfTixHAfw5UiCdxIiRaRIELItzU9GA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xScFO-000000001DQ-0kNu;
	Sun, 15 Nov 2026 15:34:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xScFM-000000001DK-2gGV
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 15:34:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u069jNW5Z9GqK08aGuDmSmkAwwGXeeybqLC50bcqsiY=; b=JpN7suGxbAEoxPx9Gag+3EoF4J
 M6DBbxfdY2oK7WeGEtvRFwgwaumMOMvAFV/Qy942fusHBRAHJHeKGOf81ImX+wB10rrRX7VKY6Ebf
 DoBx1tRSPF6KojzB9SXk2ZGllDFMrQwTMk7tQ87elT7ltnLyuIEOli+9nmRR0jYsLBWQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u069jNW5Z9GqK08aGuDmSmkAwwGXeeybqLC50bcqsiY=; b=UWs8wd6YRKGHnRUFXtIgGHuqTl
 00CCv6nBiewFynmtgIYL/sNL6LUdK2Ha05weBbLF9WSMIx3nRljBsoGWAzoJEKjm4TRRNQ8sKb0G3
 Lrh9AqF8jcddt2XHvFdNwj3yb+8jIYT4ncqZpfpaZn2TDS1solplbDlLEaYs3+QD7eZU=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xScFL-000000003CA-3LXO for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 15:34:24 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so15435375e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 07:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794756857; x=1795361657; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=u069jNW5Z9GqK08aGuDmSmkAwwGXeeybqLC50bcqsiY=;
 b=dgDIexL3iu/acxD26gY/M2/k3IR9nVWnHG6h/sPdaXGHDWe+V9wqm0leuh4kgIYWVQ
 oH5O+Z4oK/iskqGAHyh2I2ABSS/iZHyGPW/hqc4KGFH4Tkz/j9qcnxOkU9wXhFgGAu6Q
 Y5XmSrh+EdcF+oVVoP03X6ctgd9/BxHmOjM2mMbKzTp3DDAb9Np47Q25T04Lw8C+7RvW
 I+BTonk3N5A/YG6m3ER2TiTQ4K6+6c7Rm/SzS7f7R9v1tpukjt1yWKHDaDkJ0Lwxxrf6
 nt3WGXD/c3MRO4WAi3Q5ZMOGz4DYQCPAllSCqr1nrW21rrJYC1SNzoGCji81UKvGKiKq
 OGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794756857; x=1795361657;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u069jNW5Z9GqK08aGuDmSmkAwwGXeeybqLC50bcqsiY=;
 b=OnTbXqFo44tG/LBZVqAmaMNq0ktbgbb+ZSNwlYoRYUr3D3wiL3P60pMmsP0zBvApDa
 dJpM025xxkqNy9QcFLxvqs1x0ZNgIRs9mafbLxJN+D4Ye8G8Sv4kOz190TSkmrT8PdK0
 V42jMpsaEnXk5pyeJSGlcNZGxHAskFZm5sY0hnamXYfd6u4CiW2hZjpM//p40nVTtgYN
 9O5UiuSwkqc7IfJ5VEye8kNVE2Pu9zfsmLQXNo6d3UloSLVwbdtN7qYPN+OKvmOkDigy
 0OMQ21SmhXuZ3buzDxrrszu4GsemR9Q+s8c1RyCO6nAlCz2b3cVEWgBrCsfutvYbN/0G
 9MKw==
X-Gm-Message-State: APuU4Z+E07Iqc0uYAktZXmic10VC8omwUy2J4SBrocpke8M06HqwxiQu
 a8kwZGVEbjEysa5Lq1U/pf71J2RNqmXoE1hcM+qnW9RQW2EPQwTMqxdjdcyTzF7qHV8cwVrWxH5
 P985VJt3zekqANnH/U7GezxCXb4NuOUjYO3t2yecfuGBZGLubufcd68voKoezYJ2iod1UR2oRXv
 HYQfaWlA==
X-Gm-Gg: AYBFou3GB3zHT+KkAJqQ3WGksMSA/BPnPb7pu63isikYvroZdIYJfS7xmfc+jA0hOkv
 KFnltcosPSl5rvECWWuWAqmVnMWprfTx8VW/E43s8sHepG/HGcNg/2sCIlHLXW0ysmH1Ij/y9nm
 FVUPkoge/ffXs2CPzka+SJFiiyO6RGibpW4/5Oeewn+sHSlpLjpsZ04EbdP39r6b/lR972uVieZ
 7aG7b8UjMuuH0uRySdXAMI3NeRsT1cf1ZAX7gNEZi12pAbG/3MHKpwiZOLFmDy0tIwCq9VvWYoh
 CtnDwqqgtkPRfIcicUT0hUarLEclZOZRUaxFetCwNfSy5Mex/E37pEFSATAvnLK+nfJ0ES9RNzd
 fNB4XOuqx4VdUOW5kFT0eSegZCPYoCQ91sol/sg5gk5jceT5lmSX1eui334kRWz/tK37iFCtOQj
 6bvTO+YgcsxEyMrToiC1b9fqmZxDHJ8OEK9zY1P6C3pVRGBCoDUaIg1qTRT+ByIslmf3jOTB7FD
 AZs8jXhyCHRmr6OHiUvI0mp8rBuoKSvUGT6DYDw9IwSZdMJnoLWpKkzC6oCGYG+9ARIdqgNLV9L
 wQ9pJpGQ5BQnLOmzOg+IICGqBP36+P33ZqcBXIn1Q8bozZjfqmRh7JHSoAezTc8Zz7u7lBcix1r
 mx4/cyZR5Ntvkhr9ch52SBwGqqIb49fHlSRdzZDOS5tkRSovU4ly+x7ThnS2ZLDxsga7+cGAky5
 lworglnevCUHccm/g0EmvQyZeo6ldftJ96lK2j
X-Received: by 2002:a05:600c:a45:b0:4ac:86c9:b09c with SMTP id
 5b1f17b1804b1-4bb55a69123mr169258845e9.13.1794756856987; 
 Sun, 15 Nov 2026 07:34:16 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ac0e1esm200663145e9.3.2026.11.15.07.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 07:34:16 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 15:34:16 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I272f840b547dde968ceca2c24de5a922f0721149
X-Gerrit-Change-Number: 2185
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2185?usp=email>
X-Gerrit-Commit: e314a5f908aef0f9660c61d932a0f10a7e0f872b
References: <gerrit.1794756855000.I272f840b547dde968ceca2c24de5a922f0721149@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NzU2ODU1MDAwLkkyNzJmODQwYjU0N2RkZTk2OGNlY2EyYzI0ZGU1YTkyMmYwNzIxMTQ5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <185f7b13199835ecfe6c03d7d522ff882e45dbf8-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xScFL-000000003CA-3LXO
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tun: drop no-op
 IFF_ONE_QUEUE on Linux
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
Content-Type: multipart/mixed; boundary="===============5013438703959522516=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5013438703959522516==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OaT9xDphfeE="; charset=UTF-8

--OaT9xDphfeE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2185?usp=3Demail

to review the following change=2E
=


Change subject: tun: drop no-op IFF_ONE_QUEUE on Linux
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

tun: drop no-op IFF_ONE_QUEUE o=
n Linux

The kernel ignores the flag since Linux 3=2E8, commit 5d097109257c=
 ("tun:
only queue packets on device")=2E Also drop its guard around the
--=
txqueuelen code, since SIOCSIFTXQLEN is always available, and the
stale --t=
un-ipv6 comment=2E

Drop the outdated kernel version and init script note f=
rom INSTALL=2E

Change-Id: I272f840b547dde968ceca2c24de5a922f0721149
Signed=
-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M INSTALL
M src/openvp=
n/tun=2Ec
2 files changed, 3 insertions(+), 15 deletions(-)



  git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/85/2185/1

diff --gi=
t a/INSTALL b/INSTALL
index d0ffaf0=2E=2E0484e98 100644
--- a/INSTALL
+++ b=
/INSTALL
@@ -226,13 +226,10 @@
 
 TUN/TAP Driver References:
 
-* Linux 2=
=2E6 or higher (with integrated TUN/TAP driver):
+* Linux (with integrated =
TUN/TAP driver):
 
-  (1) load driver:              modprobe tun
-  (2) ena=
ble routing:           echo 1 > /proc/sys/net/ipv4/ip_forward
-
-  Note tha=
t (1) needs to be done once per reboot=2E  If you install from RPM (see
-  =
above) and use the openvpn=2Einit script, these steps are taken care of for=
 you=2E
+  (1) load driver (only if /dev/net/tun is missing):  modprobe tun=

+  (2) enable routing:  echo 1 > /proc/sys/net/ipv4/ip_forward
 
 * FreeBS=
D:
 
diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index 70fdd7e=
=2E=2E0ba8a4a 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@=
 -2123,16 +2123,9 @@
             msg(M_ERR, "ERROR: Cannot open TUN/TAP de=
v %s", node);
         }
 
-        /*
-         * Process --tun-ipv6
-    =
     */
         CLEAR(ifr);
         ifr=2Eifr_flags =3D IFF_NO_PI;
 
-#if=
 defined(IFF_ONE_QUEUE) && defined(SIOCSIFTXQLEN)
-        ifr=2Eifr_flags =
|=3D IFF_ONE_QUEUE;
-#endif
-
 #ifdef IFF_BACKPRESSURE
         ifr=2Eifr_f=
lags |=3D IFF_BACKPRESSURE;
 #endif
@@ -2175,7 +2168,6 @@
         /*
     =
     * Try making the TX send queue bigger
          */
-#if defined(IFF_ON=
E_QUEUE) && defined(SIOCSIFTXQLEN)
         if (tt->options=2Etxqueuelen)
 =
        {
             struct ifreq netifr;
@@ -2201,7 +2193,6 @@
         =
        msg(M_WARN | M_ERRNO, "Note: Cannot open control socket on %s", ifr=
=2Eifr_name);
             }
         }
-#endif /* if defined(IFF_ONE_QUEUE=
) && defined(SIOCSIFTXQLEN) */
 
         set_nonblock(tt->fd);
         se=
t_cloexec(tt->fd);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2185?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I272f840b547dde968ceca2c24de5a922f0721149
Gerrit-Change-Number: 2185
Gerr=
it-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
G=
errit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>

--OaT9xDphfeE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2185?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">tun: drop no-op IFF_ONE_QUEUE on Linux<br><br>The kerne=
l ignores the flag since Linux 3=2E8, commit 5d097109257c (&quot;tun:<br>on=
ly queue packets on device&quot;)=2E Also drop its guard around the<br>--tx=
queuelen code, since SIOCSIFTXQLEN is always available, and the<br>stale --=
tun-ipv6 comment=2E<br><br>Drop the outdated kernel version and init script=
 note from INSTALL=2E<br><br>Change-Id: I272f840b547dde968ceca2c24de5a922f0=
721149<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>-=
--<br>M INSTALL<br>M src/openvpn/tun=2Ec<br>2 files changed, 3 insertions(+=
), 15 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/85/2185/1</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/INSTALL =
b/INSTALL</span><br><span>index d0ffaf0=2E=2E0484e98 100644</span><br><span=
>--- a/INSTALL</span><br><span>+++ b/INSTALL</span><br><span>@@ -226,13 +22=
6,10 @@</span><br><span> </span><br><span> TUN/TAP Driver References:</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-* Linux 2=
=2E6 or higher (with integrated TUN/TAP driver):</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+* Linux (with integrated TUN/TAP driver):</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  (1) lo=
ad driver:              modprobe tun</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  (2) enable routing:           echo 1 &gt; /proc/sys/net/ip=
v4/ip_forward</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  Note that (1) needs to be d=
one once per reboot=2E  If you install from RPM (see</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  above) and use the openvpn=2Einit script,=
 these steps are taken care of for you=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  (1) load driver (only if /dev/net/tun is missing): =
 modprobe tun</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  (2) =
enable routing:  echo 1 &gt; /proc/sys/net/ipv4/ip_forward</span><br><span>=
 </span><br><span> * FreeBSD:</span><br><span> </span><br><span>diff --git =
a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>index 70fdd7e=
=2E=2E0ba8a4a 100644</span><br><span>--- a/src/openvpn/tun=2Ec</span><br><s=
pan>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -2123,16 +2123,9 @@</span>=
<br><span>             msg(M_ERR, &quot;ERROR: Cannot open TUN/TAP dev %s&q=
uot;, node);</span><br><span>         }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        /*</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-         * Process --tun-ipv6</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-         */</span><br><span>         CLEAR=
(ifr);</span><br><span>         ifr=2Eifr_flags =3D IFF_NO_PI;</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(IFF_=
ONE_QUEUE) &amp;&amp; defined(SIOCSIFTXQLEN)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        ifr=2Eifr_flags |=3D IFF_ONE_QUEUE;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifdef IFF_BACKPRESSURE</=
span><br><span>         ifr=2Eifr_flags |=3D IFF_BACKPRESSURE;</span><br><s=
pan> #endif</span><br><span>@@ -2175,7 +2168,6 @@</span><br><span>         =
/*</span><br><span>          * Try making the TX send queue bigger</span><b=
r><span>          */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
if defined(IFF_ONE_QUEUE) &amp;&amp; defined(SIOCSIFTXQLEN)</span><br><span=
>         if (tt-&gt;options=2Etxqueuelen)</span><br><span>         {</span=
><br><span>             struct ifreq netifr;</span><br><span>@@ -2201,7 +21=
93,6 @@</span><br><span>                 msg(M_WARN | M_ERRNO, &quot;Note: =
Cannot open control socket on %s&quot;, ifr=2Eifr_name);</span><br><span>  =
           }</span><br><span>         }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#endif /* if defined(IFF_ONE_QUEUE) &amp;&amp; defined(SI=
OCSIFTXQLEN) */</span><br><span> </span><br><span>         set_nonblock(tt-=
&gt;fd);</span><br><span>         set_cloexec(tt-&gt;fd);</span><br></pre><=
p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2185=
?usp=3Demail">change 2185</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2185?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchang=
e </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I272f840b547dde968ceca2c24de5a922f0721149 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 2185 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerri=
t-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--OaT9xDphfeE=--


--===============5013438703959522516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5013438703959522516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5013438703959522516==--

