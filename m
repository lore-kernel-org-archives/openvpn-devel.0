Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EF4606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZkuCxsVu;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=e7/DaOEU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JWzpKE2D;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=X+ggqi2Y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=Qul6uHMfzHiTovGDfkE6UjxoUsjjB39J8Z12DQYbl3g=; b=ZkuCxsVuHwqY4MAeLX2mTwaulB
	U05PYbrLb/WoLTk1ISbsHyosd9Yu69mnwZDx0WS1REYahmtlr0en21BBbztQ/erbf4AqPMOHKj60z
	oTedC+4vR/KscPl9/XtG4RNaOvRMBGeM4aqWxC6TNGPPSp8LWXfoI6HZUIsrVQkAW2S8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLdlw-000000007U9-4145;
	Tue, 27 Oct 2026 09:47:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLdlv-000000007Tm-0ZRp
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 09:47:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6/xNp9UO7M9IotKx5N4jb7vKC+WSFd+V+mwBqvJsOAc=; b=e7/DaOEU670mU2lOWYNJiHq6pW
 Lv7tQIcYTNa86f0jzv96/6U5bwm4BoXWwrlBDuLFC5filRzCzIUGA8gIuzY8zcJrtFDk1jjJc0XuH
 x+m5tE44cnArh3L0HZ9EIClmVdiY+K2RCuiftwX3g7DwdTk99tmyCxEZc6vBDo3FQ/B0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6/xNp9UO7M9IotKx5N4jb7vKC+WSFd+V+mwBqvJsOAc=; b=JWzpKE2D3m/k3YNgY7rdLhL4cG
 VBAs90znT+ZBNT2BrB1uzVG6l7IUMbkaQ+AWILdrRn89q+ZBAUGl5dX6hW170lxMxib/TR9N4/Nmx
 eCPJ12bZVVyzgIjTk57zZfjt7KSL9dQTXkjGPQIeJZNwH1F6ZUAc5q+rZf4+jeF2wiPM=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLdlt-0000000021b-1cpg for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 09:47:11 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48afbd2c386so2375001f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 02:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793094423; x=1793699223; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6/xNp9UO7M9IotKx5N4jb7vKC+WSFd+V+mwBqvJsOAc=;
 b=X+ggqi2YCKJx1AgHD8MONMbpidzk97aFyEBTrg54VQmMP3yYNekh6ySvYYocDRJFLH
 8zJrezJwftavxow/AQ3PGzDe2uohsE2LuB65ewPliVZJRzcagyWOuHaJ1IkigVsR0JCu
 MEA77dxudS4LKyd1UFKICVUmqWnrDzjwFPCe3C6y6XihMKIoJ2NLxdjNYAiU36D2nQPl
 OaXtekjpD87JTLg1VsogVuSp5zWZ9VJN8fOiMz7EI/fb33BMOqhUwXYrcfPNIbZdcYWQ
 FSYLoAilqTnazX1Woglh7ilJRfTv4pQ2dfuInS6RxIcheC/bkBpCcdjIWCLHjSnZZmlP
 eT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793094423; x=1793699223;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6/xNp9UO7M9IotKx5N4jb7vKC+WSFd+V+mwBqvJsOAc=;
 b=vfc6kD0RE8TBinScBcrbxlotqAo1DdyFSXXD4CX9IySioULf7ABmtFYRAw8npxyE7/
 lyOOegVSi8Y913k8Ux0USk2yUDTDsJQzGcOryVehBE+0LpiFlcc83ErpzDa5qnMlMMtl
 rjK59/OqDjM8pGpixqaclSqZuauIDGkgK87tPSXO4N0GE7tjeOxcMoHtm5jUCWdUHdUy
 /bl7d1f8fBboZ6dUrWLybq4kp356dM+NR5xJF/2sBiAqXcFY9JeKx6jRnpEBrgIl3dBU
 Kn0IRaitdEC97cg177XDs0B8y8OF7Pa8ro9F3uU2/SeOUv7B4dgHPIyEMbUHLOcS1CEh
 7iHg==
X-Gm-Message-State: AFq9FYKoHze6xGmFeJZjL+L8WRechnqxe1A4ag/1EwiXoYuH3iChwYTh
 RRZX1BEWhT5cOHF8ExtHZNySBI0ldN8iCOzC63TSgE+RNI4gYfwl6QndrS0ojCagYDgMayHOxhe
 9rjWFzJiB/K8a6G2YQqq6M+EqcPl7WracNVC3V34viJJB1tsczzcWXcf6jtTvx3Q3ctdtlmw13D
 Z2jo44GA==
X-Gm-Gg: AYBFou2UKH9aoTEyQcVtj0/BsK2K6ubI/AS1krZw6gw9chff+ixwvdvuIYCa/g1NcwV
 gNW8bct3xHWnGtIj/dB+TgM7AfpliV718uSrLBUQCjWi1z+rNX3xEq+9+CrwB5Wy2BQoJ+smFtZ
 TPefVV3nfeywZclhwXWd8Y4SgdS1u0SaQUx8lcMATRDUXM67a8rfNGSAsPApTo91RvJvVZlcYHn
 pX5C9FDAXntNFNhfcecVIG9BDCBcQN1pxmvlTOaZu3q8q0NCJkgAV8DFdsH6W+7oATT3PXnvVdA
 +ti/rjLOeHgYZ74Ns9JDCFP9x0pMiX427jM6PWN2mCKvuybqG7sQ7tJahbDtAw4DX6qTIuCiwAB
 MFBMkRTmoydpeaNGyuYv8+zRWX3i/Ryy9+vknXA2PVjkn1aI7ODcoso5vgmviA4brPFpzqpqzaY
 hhaHT12CLcU81riqrKj7YVt1FQlifg27UhY/a2BXFr1cNgUljLUGQBdasON5gghfol43m70sx9J
 yTvQrjQq+CDa2iSvWqZSe8lieqIbr8O7WP/ACevYMcGo0n5yBs4HSC/Adfwh/2OAFlW/T681mSF
 csgQa9bv7h/ZmVcRyJ0pz7QG9dh08B6sLJAmbIciEtNBuUSJMgyfAudX2n1Ag6/p+MwHdfWCEUO
 7ZrmJqqm+tbqt1SChENg/v5o947sGhoY/GGDksmhoMUUWMgu9oajNDxPGCZHgVmY=
X-Received: by 2002:a05:6000:2501:b0:48d:f14a:9173 with SMTP id
 ffacd0b85a97d-48e3eb247a8mr16655634f8f.8.1793094422724; 
 Tue, 27 Oct 2026 02:47:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecdf9bdsm20840121f8f.55.2026.10.27.02.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 02:47:02 -0700 (PDT)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 09:47:02 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2f49f40e49af8503f5c08c5575ffc9a8b4c9aa20
X-Gerrit-Change-Number: 2045
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2045?usp=email>
X-Gerrit-Commit: 0ad283c0198adbac3713822bd4c00ef5a615d7b6
References: <gerrit.1793094393000.I2f49f40e49af8503f5c08c5575ffc9a8b4c9aa20@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkkyZjQ5ZjQwZTQ5YWY4NTAzZjVjMDhjNTU3NWZmYzlhOGI0YzlhYTIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <46a6a853e39574e766e350737699dcfdd403191b-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLdlt-0000000021b-1cpg
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi_io: walk the
 link sockets once in multi_io_wait()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4738686910057233709=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4738686910057233709==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YvnI6W/PO10="; charset=UTF-8

--YvnI6W/PO10=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2045?usp=3Demail

to review the following change=2E
=


Change subject: multi_io: walk the link sockets once in multi_io_wait()
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi_io: wal=
k the link sockets once in multi_io_wait()

multi_io_wait() went over the l=
ink sockets twice: first to register
every socket as a listening socket, th=
en, if a UDP socket is configured,
again to arm the UDP ones=2E The UDP soc=
kets were thus registered twice,
and on Windows the first pass created an F=
D_ACCEPT event for them=2E

Walk the sockets once, arming the UDP sockets a=
nd registering only the
TCP ones as listening sockets=2E Drop the mode chec=
k as well, since
multi_io_wait() only runs in server mode=2E

Change-Id: I2=
f49f40e49af8503f5c08c5575ffc9a8b4c9aa20
Signed-off-by: Gianmarco De Gregori=
 <gianmarco@mandelbit=2Ecom>
---
M src/openvpn/multi_io=2Ec
1 file changed,=
 7 insertions(+), 17 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/45/2045/1

diff --git a/src/openvpn/multi_io=
=2Ec b/src/openvpn/multi_io=2Ec
index 56216d4=2E=2Efb4810b 100644
--- a/src=
/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -168,27 +168,17 @@
=
     int status;
     unsigned int *persistent =3D &m->multi_io->tun_rwflag=
s;
 
-    if (!tuntap_is_dco_win(m->top=2Ec1=2Etuntap))
+    for (int i =3D=
 0; i < m->top=2Ec1=2Elink_sockets_num; i++)
     {
-        for (int i =3D=
 0; i < m->top=2Ec1=2Elink_sockets_num; i++)
+        struct link_socket *s=
ock =3D m->top=2Ec2=2Elink_sockets[i];
+
+        if (proto_is_dgram(sock->=
info=2Eproto))
         {
-            socket_set_listen_persistent(m->top=
=2Ec2=2Elink_sockets[i], m->multi_io->es,
-                                =
         &m->top=2Ec2=2Elink_sockets[i]->ev_arg);
+            multi_io_pro=
cess_flags(&m->top, m->multi_io->es, sock, p2mp_iow_flags(m, sock));
      =
   }
-    }
-
-    if (has_udp_in_local_list(&m->top=2Eoptions))
-    {
-  =
      for (int i =3D 0; i < m->top=2Ec1=2Elink_sockets_num; i++)
+        e=
lse if (!tuntap_is_dco_win(m->top=2Ec1=2Etuntap))
         {
-            s=
truct link_socket *sock =3D m->top=2Ec2=2Elink_sockets[i];
-
-            i=
f ((m->top=2Eoptions=2Emode =3D=3D MODE_SERVER) && proto_is_dgram(sock->inf=
o=2Eproto))
-            {
-                unsigned int flags =3D p2mp_iow=
_flags(m, sock);
-
-                multi_io_process_flags(&m->top, m->mult=
i_io->es, sock, flags);
-            }
+            socket_set_listen_persi=
stent(sock, m->multi_io->es, &sock->ev_arg);
         }
     }
 

-- 
To vi=
ew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2045?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2f49f40e49af8503f5c08c5575=
ffc9a8b4c9aa20
Gerrit-Change-Number: 2045
Gerrit-PatchSet: 1
Gerrit-Owner: =
Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>

--YvnI6W/PO10=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gianmarco De Gregori would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2045?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">multi_io: walk the link sockets once in multi_io_wait()=
<br><br>multi_io_wait() went over the link sockets twice: first to register=
<br>every socket as a listening socket, then, if a UDP socket is configured=
,<br>again to arm the UDP ones=2E The UDP sockets were thus registered twic=
e,<br>and on Windows the first pass created an FD_ACCEPT event for them=2E<=
br><br>Walk the sockets once, arming the UDP sockets and registering only t=
he<br>TCP ones as listening sockets=2E Drop the mode check as well, since<b=
r>multi_io_wait() only runs in server mode=2E<br><br>Change-Id: I2f49f40e49=
af8503f5c08c5575ffc9a8b4c9aa20<br>Signed-off-by: Gianmarco De Gregori &lt;g=
ianmarco@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/multi_io=2Ec<br>1 file=
 changed, 7 insertions(+), 17 deletions(-)<br><br></pre><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/45/2045/1</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><=
br><span>index 56216d4=2E=2Efb4810b 100644</span><br><span>--- a/src/openvp=
n/multi_io=2Ec</span><br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><sp=
an>@@ -168,27 +168,17 @@</span><br><span>     int status;</span><br><span> =
    unsigned int *persistent =3D &amp;m-&gt;multi_io-&gt;tun_rwflags;</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!=
tuntap_is_dco_win(m-&gt;top=2Ec1=2Etuntap))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; m-&gt;top=2Ec1=2Elink_=
sockets_num; i++)</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        for (int i =3D 0; i &lt; m-&gt;top=2Ec1=2Elink_s=
ockets_num; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     struct link_socket *sock =3D m-&gt;top=2Ec2=2Elink_sockets[i];</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (proto_is_dgram(sock-&gt;info=2Epro=
to))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            socket_set_listen_persistent(m-&gt;top=2Ec2=2Elink_so=
ckets[i], m-&gt;multi_io-&gt;es,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                                         &amp;m-&gt;top=2Ec2=2El=
ink_sockets[i]-&gt;ev_arg);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            multi_io_process_flags(&amp;m-&gt;top, m-&gt;multi_io-&=
gt;es, sock, p2mp_iow_flags(m, sock));</span><br><span>         }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (has_udp_in_local_list(&amp;m-&gt;top=2Eoptions))</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        for (int i =3D 0; i &lt; m-&gt;top=2Ec1=
=2Elink_sockets_num; i++)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        else if (!tuntap_is_dco_win(m-&gt;top=2Ec1=2Etuntap))</span><=
br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          struct link_socket *sock =3D m-&gt;top=2Ec2=2Elink_sockets[i];</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if ((m-&gt;top=2Eoptions=2Emode=
 =3D=3D MODE_SERVER) &amp;&amp; proto_is_dgram(sock-&gt;info=2Eproto))</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                unsigned int flags=
 =3D p2mp_iow_flags(m, sock);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   multi_io_process_flags(&amp;m-&gt;top, m-&gt;multi_io-&gt;es, sock, flag=
s);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            socket_set_l=
isten_persistent(sock, m-&gt;multi_io-&gt;es, &amp;sock-&gt;ev_arg);</span>=
<br><span>         }</span><br><span>     }</span><br></pre><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2045?usp=3Demail">=
change 2045</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/204=
5?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: I2f49f40e49af8503f5c08c5575ffc9a8b4c9aa20 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 2045 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Gianm=
arco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</bod=
y></html>
--YvnI6W/PO10=--


--===============4738686910057233709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4738686910057233709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4738686910057233709==--

