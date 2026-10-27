Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8D7606A32D
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=U88Oi11I;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ciGeUufW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lB6Bb9LS;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HCLfBuZv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=gTjmqt8Weey3l9UA5hq83YJhEN7Ukyr0RlCrTLzOFBk=; b=U88Oi11Ijo2i2uhfp8bau/y474
	QGx0SXLtrrhSjrPzELAKIhVpSCo2i5S24IoOkk/VHRhpjiQKRecOIKzUwAX/Jg0UreLON+8cFPG2T
	18HjFBBCPGokBR3hbgKQDyp0ZNSVpmGJtxHD6EqxvBFz0nNqk8LGicLo8VXqs8ZN9Guo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLdm1-000000007Vr-0Ya6;
	Tue, 27 Oct 2026 09:47:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLdlz-000000007VF-16Mm
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 09:47:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iFFzE6nta9NE5xzw4lKUVB+xD7lymo04756COJ4aRNk=; b=ciGeUufWc/Ddfp19mNTy81PWJg
 mB3Wv98DwwxObBz977lgdoFQm741gG1EX8dO49fcAmB2LncKF2jX6C/xwAL0x6PcMc6z8+FWCjTGN
 Yllb1/VytSlGk856hZ3SqT/BMcukIWYuO+Lb5UQk+0vrDsH1h6EPtRFKeomcBk0pndpc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iFFzE6nta9NE5xzw4lKUVB+xD7lymo04756COJ4aRNk=; b=lB6Bb9LSDWUylH0ojzKe+938X7
 1mDk/X7oxbqthw+cAY9KcfcPgdgJMNPIZ6CDvlbuqnx4e5ls2LmqepIxrFF71Jr6E8ZFf90iVgds8
 Er1//2h8DRAMr+9xRZxdMwHxTPP6Vz3EgZgzLlF0wxgxxtcarqOYJzlregXMIgJy8iCM=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLdly-000000001Ec-0GOA for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 09:47:15 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48e47347279so1675866f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 02:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793094427; x=1793699227; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iFFzE6nta9NE5xzw4lKUVB+xD7lymo04756COJ4aRNk=;
 b=HCLfBuZvo0V++3F3ZMRibZeKPqnWMlyFy/A1gPwURGxqo87ekXoszPlgma7SUq6XJT
 IMsOKzDY2ced56HnPXpaKbFlcrDoxdrXYDzGuMJjCjRq4xdEoz9/OhVyzYdXuyVu0n1k
 ZrFt//a01g+JauiWzao+3rY/WsgMvVcAHrFs+cjm6OUprlNr95ieSQ/qr29HsZtvy2IM
 GSyRU2hp4XrjVz/giaaocnKoPJTZxIGwuaOdiZb2edH9PZ5MpFHilhEFKczjZ3nzJvl5
 Az9YWUxja0gp+uZAilwQ2rOTCFJ+RC6l8RUg76lBu9NBLRlrwIx+HNPLrsNf+VmPjc6A
 Ocyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793094427; x=1793699227;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iFFzE6nta9NE5xzw4lKUVB+xD7lymo04756COJ4aRNk=;
 b=MDKEAB6lo407vAhuQblbBflRXQRJtwxgeJCl8aVTFFLpMRVEKQ4yCsirtyaE1cIHle
 +ptrWique1ixf0gewELskDjfRuwvNZbbTr9ULN0sEZmN4I/c4yrWSXp+jrH2LiFtPvdY
 lxonB3coU30LET/GuWh4Psu4j50t6Q7L29WHoIB1bYcFhYxaTZQ/JNcHX+X05zLtkQ52
 EQ5r76G+mdB25tRO0ebccQxCojOZjSIecLNwGHV4r27joq2AWY6JtU2wPY1ntr9wO7vj
 j1MzTCU/SFI/BQgOFqtm3M24Q7LzYK3/lGqmzK3I+UHm1yvjR/Y6i6IP6I15j2/xgfjH
 RNxw==
X-Gm-Message-State: AFq9FYJ8p7JZHtE8n9fN3swFyIsl2U8az9QqZeLmMOcQZSaDPX0DKHbD
 klr+1+UsqG3BB7ebTuCeAQ/siuB1rdqEHFu844zJyprmWL97+gsmhWO54NU8dwk125f0qVkrx7/
 1kCrptC7eKvTRcEWOejaktGSzox7pw5NGyu08h4xeIm7W0li73vwdPqZ6RCkXzlYbSGq9+4kwy5
 YV8cCddQ==
X-Gm-Gg: AYBFou3tTE+5CaRiXQV2EM+2MrPk4a97pbmdrDhbiMfp1VfKRYYNtOzNkfT05Kf4Bv6
 BeBr1DNu8in1F6w2h62gsDVMYHXhtkUKNFlO5AZZTRqQi+SH3m/iX/kGdzuhOVpoxNesINSw8hh
 EnpTbYLfx7rmyKpVFJjGPLGTg7vEJRlmml+UiSUsh/O4YbLdxnDJEPof/cIJRg1wptakzA/ohUX
 BRzr2H7qNHsds7QqI17jzm9Bw3kzp+k8zPloNbLuKviJ+e6T9l5io8YTkp3NlGmsrLGJmORF5eQ
 yNT98hx74CABy+Th1877Br9ZxIEllQ44iXbwyE+2gYHTFFbDphuXFxtQMa9j+ctCPeNFLArzHf7
 +SplgVJgSY9br54C8shwmuEFv1DMGnM4nMUVLdET6tb4pGZOnsTfUBmfA6Ul1JNLum2sZqkgLmE
 FLH+5fBa0jyrncD5a+Vw5YPc6JJkw+bdpNSSjz5yNZh+oJRq8Al/o01vswQCL4tpzTZ0jajpVqc
 0xjYCnOmQCzayARe0lAKU8bUB4eLajL8GICbGFo/Ri9nd9iW5rmcF6y9xeTHOJunN00oCPgztPR
 bKZqChbp/bniLb4KjoMxaG08NK4eeGDzgdd1g1XGuQjiE8+pbREcPPCE9vb6ZhuoX1vpbNPyWKb
 4YNmL+daj8Bc5nqoMLei0KN3DxqxDQvw6O1UnAYKe0A==
X-Received: by 2002:a05:6000:27c9:10b0:48d:e6f6:21cf with SMTP id
 ffacd0b85a97d-48e3eb92704mr13788934f8f.31.1793094427198; 
 Tue, 27 Oct 2026 02:47:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd8c05sm28069311f8f.49.2026.10.27.02.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 02:47:06 -0700 (PDT)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 09:47:06 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I4379a167419d464c000dca3c5c032aaebb6dac73
X-Gerrit-Change-Number: 2050
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2050?usp=email>
X-Gerrit-Commit: 6f59a41b6af8349369c39d13db2adcf55d5b3c83
References: <gerrit.1793094393000.I4379a167419d464c000dca3c5c032aaebb6dac73@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkk0Mzc5YTE2NzQxOWQ0NjRjMDAwZGNhM2M1YzAzMmFhZWJiNmRhYzczQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <388bf0022d4bee491f5bbc3ca3be95800c07d123-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLdly-000000001Ec-0GOA
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi_io: avoid
 redundant event_ctl() calls in multi_io_wait()
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
Content-Type: multipart/mixed; boundary="===============4334827958933062914=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4334827958933062914==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qP5XImCcF7Q="; charset=UTF-8

--qP5XImCcF7Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2050?usp=3Demail

to review the following change=2E
=


Change subject: multi_io: avoid redundant event_ctl() calls in multi_io_w=
ait()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi_i=
o: avoid redundant event_ctl() calls in multi_io_wait()

multi_io_wait() re=
gistered each server UDP socket through
multi_io_process_flags(), which cal=
ls socket_set() without a persistent
cache and tun_set() once more for ever=
y UDP socket, also without a
cache=2E Both ended up in an event_ctl() on ev=
ery loop iteration even
though nothing changed=2E

Now that the UDP sockets=
 and the tun device are only ever armed for
reading, set them directly with=
 EVENT_READ, caching the UDP socket
rwflags in the new link_socket=2Erwflag=
s_persistent and the tun ones in
multi_io->tun_rwflags=2E

On a server with=
 two UDP and one TCP listener this removes the
remaining epoll_ctl() calls =
from the loop (syscalls per received
packet 4=2E64 -> 3=2E36, UDP only 5=2E=
29 -> 3=2E77); at saturation the
server delivers 2-7% more traffic with UDP=
 and uses 4-13% less CPU
at a fixed load=2E

With --enable-async-push the i=
notify descriptor was also registered on
every iteration; register it once =
(1504 -> 12 epoll_ctl() with
deferred auth)=2E

Change-Id: I4379a167419d464=
c000dca3c5c032aaebb6dac73
Signed-off-by: Gianmarco De Gregori <gianmarco@ma=
ndelbit=2Ecom>
---
M src/openvpn/forward=2Eh
M src/openvpn/multi_io=2Ec
M s=
rc/openvpn/multi_io=2Eh
M src/openvpn/socket=2Eh
4 files changed, 12 insert=
ions(+), 6 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/50/2050/1

diff --git a/src/openvpn/forward=2Eh b/src/op=
envpn/forward=2Eh
index 375635b=2E=2E2b29f69 100644
--- a/src/openvpn/forwa=
rd=2Eh
+++ b/src/openvpn/forward=2Eh
@@ -73,8 +73,7 @@
  * Evaluates the cu=
rrent I/O state (`flags`) and context mode to determine
  * which READ or W=
RITE events to register in the event loop=2E
  *
- * @note This function ge=
ts called from client instances from @c io_wait()
- * and from p2mp (Point-=
to-multipoint) instances in @c multi_io_wait()=2E
+ * @note This function g=
ets called from @c io_wait()=2E
  *
  * @param c      Pointer to the core c=
ontext=2E
  * @param es     The event set where descriptors are registered=
=2E
diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec
index =
8580d7d=2E=2E59afb51 100644
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openvp=
n/multi_io=2Ec
@@ -136,7 +136,6 @@
 multi_io_wait(struct multi_context *m)
=
 {
     int status;
-    unsigned int *persistent =3D &m->multi_io->tun_rwf=
lags;
 
     for (int i =3D 0; i < m->top=2Ec1=2Elink_sockets_num; i++)
   =
  {
@@ -144,7 +143,7 @@
 
         if (proto_is_dgram(sock->info=2Eproto))
=
         {
-            multi_io_process_flags(&m->top, m->multi_io->es, so=
ck, IOW_READ | IOW_WAIT_SIGNAL);
+            socket_set(sock, m->multi_io-=
>es, EVENT_READ, &sock->ev_arg, &sock->rwflags_persistent);
         }
    =
     else if (!tuntap_is_dco_win(m->top=2Ec1=2Etuntap))
         {
@@ -152,=
7 +151,7 @@
         }
     }
 
-    tun_set(m->top=2Ec1=2Etuntap, m->multi=
_io->es, EVENT_READ, MULTI_IO_TUN, persistent);
+    tun_set(m->top=2Ec1=2E=
tuntap, m->multi_io->es, EVENT_READ, MULTI_IO_TUN, &m->multi_io->tun_rwflag=
s);
 #if defined(ENABLE_DCO)
     dco_event_set(&m->top=2Ec1=2Etuntap->dco,=
 m->multi_io->es, MULTI_IO_DCO);
 #endif
@@ -167,7 +166,11 @@
 
 #ifdef ENA=
BLE_ASYNC_PUSH
     /* arm inotify watcher */
-    event_ctl(m->multi_io->e=
s, m->top=2Ec2=2Einotify_fd, EVENT_READ, MULTI_IO_FILE_CLOSE_WRITE);
+    i=
f (!m->multi_io->inotify_set)
+    {
+        event_ctl(m->multi_io->es, m-=
>top=2Ec2=2Einotify_fd, EVENT_READ, MULTI_IO_FILE_CLOSE_WRITE);
+        m-=
>multi_io->inotify_set =3D true;
+    }
 #endif
 
     status =3D
diff --gi=
t a/src/openvpn/multi_io=2Eh b/src/openvpn/multi_io=2Eh
index e178240=2E=2E=
6c7fd11 100644
--- a/src/openvpn/multi_io=2Eh
+++ b/src/openvpn/multi_io=2E=
h
@@ -55,6 +55,7 @@
     int n_esr;
     int maxevents;
     unsigned int t=
un_rwflags;
+    bool inotify_set;
 #ifdef ENABLE_MANAGEMENT
     unsigned =
int management_persist_flags;
 #endif
diff --git a/src/openvpn/socket=2Eh b=
/src/openvpn/socket=2Eh
index 52e09c9=2E=2Ee320ff3 100644
--- a/src/openvpn=
/socket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -177,6 +177,9 @@
     /* used f=
or long-term queueing of pre-accepted socket listen */
     bool listen_per=
sistent_queued;
 
+    /* last rwflags set on the shared server-side UDP so=
cket */
+    unsigned int rwflags_persistent;
+
     const char *remote_hos=
t;
     const char *remote_port;
     const char *local_host;

-- 
To view,=
 visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2050?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4379a167419d464c000dca3c5c032=
aaebb6dac73
Gerrit-Change-Number: 2050
Gerrit-PatchSet: 1
Gerrit-Owner: Gia=
nmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>

--qP5XImCcF7Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gianmarco De Gregori would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2050?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">multi_io: avoid redundant event_ctl() calls in multi_io=
_wait()<br><br>multi_io_wait() registered each server UDP socket through<br=
>multi_io_process_flags(), which calls socket_set() without a persistent<br=
>cache and tun_set() once more for every UDP socket, also without a<br>cach=
e=2E Both ended up in an event_ctl() on every loop iteration even<br>though=
 nothing changed=2E<br><br>Now that the UDP sockets and the tun device are =
only ever armed for<br>reading, set them directly with EVENT_READ, caching =
the UDP socket<br>rwflags in the new link_socket=2Erwflags_persistent and t=
he tun ones in<br>multi_io-&gt;tun_rwflags=2E<br><br>On a server with two U=
DP and one TCP listener this removes the<br>remaining epoll_ctl() calls fro=
m the loop (syscalls per received<br>packet 4=2E64 -&gt; 3=2E36, UDP only 5=
=2E29 -&gt; 3=2E77); at saturation the<br>server delivers 2-7% more traffic=
 with UDP and uses 4-13% less CPU<br>at a fixed load=2E<br><br>With --enabl=
e-async-push the inotify descriptor was also registered on<br>every iterati=
on; register it once (1504 -&gt; 12 epoll_ctl() with<br>deferred auth)=2E<b=
r><br>Change-Id: I4379a167419d464c000dca3c5c032aaebb6dac73<br>Signed-off-by=
: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<br>---<br>M src/op=
envpn/forward=2Eh<br>M src/openvpn/multi_io=2Ec<br>M src/openvpn/multi_io=
=2Eh<br>M src/openvpn/socket=2Eh<br>4 files changed, 12 insertions(+), 6 de=
letions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/50/2050/1</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/forw=
ard=2Eh b/src/openvpn/forward=2Eh</span><br><span>index 375635b=2E=2E2b29f6=
9 100644</span><br><span>--- a/src/openvpn/forward=2Eh</span><br><span>+++ =
b/src/openvpn/forward=2Eh</span><br><span>@@ -73,8 +73,7 @@</span><br><span=
>  * Evaluates the current I/O state (`flags`) and context mode to determin=
e</span><br><span>  * which READ or WRITE events to register in the event l=
oop=2E</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * @note This function gets called from client instances from @c io_wa=
it()</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * and from p2mp =
(Point-to-multipoint) instances in @c multi_io_wait()=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @note This function gets called fro=
m @c io_wait()=2E</span><br><span>  *</span><br><span>  * @param c      Poi=
nter to the core context=2E</span><br><span>  * @param es     The event set=
 where descriptors are registered=2E</span><br><span>diff --git a/src/openv=
pn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>index 8580d7d=2E=
=2E59afb51 100644</span><br><span>--- a/src/openvpn/multi_io=2Ec</span><br>=
<span>+++ b/src/openvpn/multi_io=2Ec</span><br><span>@@ -136,7 +136,6 @@</s=
pan><br><span> multi_io_wait(struct multi_context *m)</span><br><span> {</s=
pan><br><span>     int status;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    unsigned int *persistent =3D &amp;m-&gt;multi_io-&gt;tun_rwfla=
gs;</span><br><span> </span><br><span>     for (int i =3D 0; i &lt; m-&gt;t=
op=2Ec1=2Elink_sockets_num; i++)</span><br><span>     {</span><br><span>@@ =
-144,7 +143,7 @@</span><br><span> </span><br><span>         if (proto_is_dg=
ram(sock-&gt;info=2Eproto))</span><br><span>         {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            multi_io_process_flags(&amp;m-=
&gt;top, m-&gt;multi_io-&gt;es, sock, IOW_READ | IOW_WAIT_SIGNAL);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            socket_set(sock,=
 m-&gt;multi_io-&gt;es, EVENT_READ, &amp;sock-&gt;ev_arg, &amp;sock-&gt;rwf=
lags_persistent);</span><br><span>         }</span><br><span>         else =
if (!tuntap_is_dco_win(m-&gt;top=2Ec1=2Etuntap))</span><br><span>         {=
</span><br><span>@@ -152,7 +151,7 @@</span><br><span>         }</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    tun_set(m-&gt;top=2Ec1=2Etuntap, m-&gt;multi_io-&gt;es, EVENT_R=
EAD, MULTI_IO_TUN, persistent);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    tun_set(m-&gt;top=2Ec1=2Etuntap, m-&gt;multi_io-&gt;es, EVE=
NT_READ, MULTI_IO_TUN, &amp;m-&gt;multi_io-&gt;tun_rwflags);</span><br><spa=
n> #if defined(ENABLE_DCO)</span><br><span>     dco_event_set(&amp;m-&gt;to=
p=2Ec1=2Etuntap-&gt;dco, m-&gt;multi_io-&gt;es, MULTI_IO_DCO);</span><br><s=
pan> #endif</span><br><span>@@ -167,7 +166,11 @@</span><br><span> </span><b=
r><span> #ifdef ENABLE_ASYNC_PUSH</span><br><span>     /* arm inotify watch=
er */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    event_ctl(m-=
&gt;multi_io-&gt;es, m-&gt;top=2Ec2=2Einotify_fd, EVENT_READ, MULTI_IO_FILE=
_CLOSE_WRITE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (!m-&gt;multi_io-&gt;inotify_set)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        event_ctl(m-&gt;multi_io-&gt;es, m-&gt;top=2Ec2=2Einotify_fd, EVE=
NT_READ, MULTI_IO_FILE_CLOSE_WRITE);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        m-&gt;multi_io-&gt;inotify_set =3D true;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> #endif=
</span><br><span> </span><br><span>     status =3D</span><br><span>diff --g=
it a/src/openvpn/multi_io=2Eh b/src/openvpn/multi_io=2Eh</span><br><span>in=
dex e178240=2E=2E6c7fd11 100644</span><br><span>--- a/src/openvpn/multi_io=
=2Eh</span><br><span>+++ b/src/openvpn/multi_io=2Eh</span><br><span>@@ -55,=
6 +55,7 @@</span><br><span>     int n_esr;</span><br><span>     int maxeven=
ts;</span><br><span>     unsigned int tun_rwflags;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    bool inotify_set;</span><br><span> #ifde=
f ENABLE_MANAGEMENT</span><br><span>     unsigned int management_persist_fl=
ags;</span><br><span> #endif</span><br><span>diff --git a/src/openvpn/socke=
t=2Eh b/src/openvpn/socket=2Eh</span><br><span>index 52e09c9=2E=2Ee320ff3 1=
00644</span><br><span>--- a/src/openvpn/socket=2Eh</span><br><span>+++ b/sr=
c/openvpn/socket=2Eh</span><br><span>@@ -177,6 +177,9 @@</span><br><span>  =
   /* used for long-term queueing of pre-accepted socket listen */</span><b=
r><span>     bool listen_persistent_queued;</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* last rwflags set on the sh=
ared server-side UDP socket */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    unsigned int rwflags_persistent;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span>     const char *remote_host;<=
/span><br><span>     const char *remote_port;</span><br><span>     const ch=
ar *local_host;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2050?usp=3Demail">change 2050</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2050?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4379a167419d464c0=
00dca3c5c032aaebb6dac73 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2050 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<=
div style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarc=
o@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--qP5XImCcF7Q=--


--===============4334827958933062914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4334827958933062914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4334827958933062914==--

