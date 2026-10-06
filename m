Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFBBCA5FED
	for <openvpn-devel@archiver.kernel.org>; Tue,  6 Oct 2026 12:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WeurFGtrYj2KJ9aSb/KFnYGlzFhkhFvIlWifj6LX9P4=; b=Z5C8RIFiZZsB3IJAybENcYDu7y
	9w8m/Yol26haAGzIGOt4J66M2siwoJr63HOazbdMY54GZrjM5ZyUvX2QOu/9UR6oPNr1eWGVMrA3Z
	j3Z8R8cc2HzVsOM6haKot3jYulkkzNP3bQuMprTZjncQXWycr+KALR2uakaZvwopWD+Q=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xE4hi-0002cY-O2;
	Tue, 06 Oct 2026 12:55:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xE4hd-0002c8-4p
 for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 12:55:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=zk52L0XomKu/j8iLD4m/JINoK8xjVPvaY/9rCU29jfU=; b=Cy5gE/Yo2dM6vYueCsXHjIRWyK
 alFiDr6fa7scxc3QvBnOyB8LKdWY32Pt3rHzgoAixS+0N0rsua+EPdspiqSF6PUvZVS+89xDhmP1Z
 o0Gamzlt5KkFZSgdassJAQ6c6uiKgzIPb0x63swRkURgzJb6foIha3RrLODvQMuyD+wg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zk52L0XomKu/j8iLD4m/JINoK8xjVPvaY/9rCU29jfU=; b=K
 uGEAASyui1Upw9eVBRUTgQ8xQLj+h7QN/G06OaCJnYVCc5Rvy6kGjfDaHQg4wcRvZn+qr/K1lZHZp
 kzAQJiOo/RNtWX4PXscMX9WsrS909gxJPnUjNnGBHoJ3u1zAkFuFLL6s792oDs4mf0x1YGiFr74V+
 FIN49rlAaAeOzHDg=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xE4hG-0005bQ-JM for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 12:55:08 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a061a13884so6222925e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 06 Oct 2026 05:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791291300; x=1791896100; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zk52L0XomKu/j8iLD4m/JINoK8xjVPvaY/9rCU29jfU=;
 b=QCnlyaQbrvs7ofyoGI63hYn2/w7cH3Z15kuGaBVMIKVmZ73DYa7RfXUgqJOZ6UhEls
 fCbKDuypjFxmWZtHL5/FQrBPG9uEG1nmHI1vIGdY3MBChdwoYeFcWLzaxiaJddyFDCxc
 bSF2K4UFep1Ubnh+m9zXYj/s8FGRJnoGRYsqxOB2kaIqYYxiArYW19om5OaNOY327afg
 G8EWoWNeiadueH4JB/iZi0cKr/Lt2ZP6SsjeNDawyFNsupVJaH8cYneJM8jXhLYUbkJ1
 fuXmKy10CaBTksobcUh7PAhldEw7XcTOrK35t5PxX5rHXoC4ovNnOq3cNl0IwREnHPT3
 Lh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791291300; x=1791896100;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zk52L0XomKu/j8iLD4m/JINoK8xjVPvaY/9rCU29jfU=;
 b=FezqTfqlYP/n2WG7xablrkjPO1k487zON0jn0HZaCHUaGJnmy6DsEVX6rZu2I53g2X
 J98I1ZlYg04hwPEkpTmX+5tk1wzvWrjtW8I0P9YnlwL/ub02pPAisVTXFzDdqKz1A0Zb
 nfEUOrNbWAQm6tLKAfDeC3jo2Ii5kFvbQ2ZhL3LMG810XbJIF+OtXMrMI2lfkbmmSPrf
 7don3VWECG+R8iX/GePNA77z69CCL78uAHP4k/sM5K4auPCDkL7aLr9MLXzyM4zMN82w
 Z8r28lv5nJ20zecUKmZfPS3xOGg8kP8sMhcLED8hgu1V0M/ocPbddrN95JWQpRKBy9UH
 FpuQ==
X-Gm-Message-State: AFuF++klavAi3uFqATd6SGHpHM0o7V2+rahCgLtq1fIPnuUK7dOS8dhE
 UG6qMgjJ3rjOqt1cEps/deIDLY30xDmvEe/0rRsVaoNTImY6ZT+WeGSuKK4+ivAu0Fvwa70qBfo
 cCnd0rl9Rz3+x5dbMAJNxrRkqmlHVBMj7G97hJYDCNhE873Jm9VSSpBUgmWomB1ahemft
X-Gm-Gg: AYBFou0IttePTeHQI2AW4QWYEPde5cFzMKY3NcCUTvfy5ZEW8RBEGsHk1N4WXdwvJFm
 /zlC753CAV9VWRR+8PQ4t9Ed497sx9LukS0rl06iRs+Z6jFFvUWeYuWev8mgUzqigI4KIHNkZj2
 lZ5+mrI00uioRy9h3JFewxT3xeXAnS8QMDFy8vTYbMZC+307IMpZ2xx5eH+Iu3bG2ScfLp/0viR
 jX4ci+yJqzvRhcHEX4tYri0gzJu7cg/k9AfCvFyL5CxBwM1rc+PNitWuPGsuzOoQNmlS9mhk6/J
 vHBcAEUx22sFVTmGDaODHmI5I0jfAGoaneBR1S4ZPEbTVyylj0WdwjWHUM5fE8rR0GbtViZeZk+
 auRRPiPU7YVLL+9IFu2uvQaBCbXy4ErfvHneWMH6LSyRLcr1aYkHhF/lJIutCHJv2nsbJktoMBX
 tRCMvg7XRtj6GUfN50SvnKsV0BZ1kmgtQwESKDDXnD+4bnW5y3vvJVp2XLD/5hy6UkW8ylQjqw4
 ZDoO8AfNKTveP4W3qlCJ9W2DJOe2K8BfEK2uMWOiuO/+Ne7bfNdAwg4Ve5uZhmK6EOliCO/nZ5Y
 kZsBTgJJFUrjIvRvGHmzO1wjcUabrj0AiMO4igaBOmgyEXkfhpFiBq3FG7E+
X-Received: by 2002:a05:600c:c490:b0:49e:6c11:c4fc with SMTP id
 5b1f17b1804b1-4a17b535e6amr20565125e9.7.1791291299735; 
 Tue, 06 Oct 2026 05:54:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c62289b62sm10440253f8f.20.2026.10.06.05.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 05:54:59 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 6 Oct 2026 12:54:57 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I165c632da6a837d0cca55bee4c2cc390b91d1e54
X-Gerrit-Change-Number: 1962
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1962?usp=email>
X-Gerrit-Commit: bf2d472c88654f859d806a9341e3ac9eba8caba6
In-Reply-To: <gerrit.1790611935000.I165c632da6a837d0cca55bee4c2cc390b91d1e54@gerrit.openvpn.net>
References: <gerrit.1790611935000.I165c632da6a837d0cca55bee4c2cc390b91d1e54@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjExOTM1MDAwLkkxNjVjNjMyZGE2YTgzN2QwY2NhNTViZWU0YzJjYzM5MGI5MWQxZTU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <671524c54c15c75c26b0adee01e241fbe5b2c794-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xE4hG-0005bQ-JM
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi_io: drop
 IOW_MBUF
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1110206434429134098=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1110206434429134098==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xxizznlAdz8="; charset=UTF-8

--xxizznlAdz8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Gianmarco De Gregori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1962?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by R=C4=83zvan Cojocaru


Change subject: multi_io: drop IO=
W_MBUF
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

mult=
i_io: drop IOW_MBUF

Before the UDP and TCP server loops were merged, each =
drained the
bcast/mcast/client-to-client queue its own way: UDP armed EVENT=
_WRITE
through IOW_MBUF, TCP used the flush loop at the end of
multi_io_pro=
cess_io()=2E  The merge kept both, leaving two consumers with
different dis=
ciplines=2E

The queue mixes instances of both protocols and neither consum=
er gets to
pick: mbuf_peek() and multi_get_queue() hand back whatever sits =
at the
head=2E  The TCP side is prepared for that, testing proto_is_dgram()=
 and
tcp_link_out_deferred before writing=2E  The UDP side is not: it write=
s
straight to the instance's own socket, so a TCP instance reaching it
skip=
s the deferred queue that carries backpressure=2E

Drain the queue from the=
 flush loop alone and drop the UDP consumer=2E
IOW_MBUF only existed to arm=
 the socket for it, so it goes as well=2E

This leaves the queue drained fr=
om one event-driven point: the timeout
branch of tunnel_server_loop() does =
not reach the flush loop, so what
multi_io_action(TA_TIMEOUT) manages to qu=
eue there waits for the next
pass that has events=2E  Acting on the queue o=
nly when there is an event
to act on is the simpler rule, and the delay is =
bounded by the next
event=2E

Change-Id: I165c632da6a837d0cca55bee4c2cc390b=
91d1e54
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Ack=
ed-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1962
Message-Id: <20261005132023=2E27464-1-ger=
t@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@l=
ists=2Esourceforge=2Enet/msg39712=2Ehtml
Signed-off-by: Gert Doering <gert@=
greenie=2Emuc=2Ede>
---
M src/openvpn/forward=2Ec
M src/openvpn/forward=2Eh=

M src/openvpn/mudp=2Ec
M src/openvpn/multi_io=2Ec
4 files changed, 3 inser=
tions(+), 17 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/62/1962/3

diff --git a/src/openvpn/forward=2Ec b/src/o=
penvpn/forward=2Ec
index 1604224=2E=2Eb97fb7a 100644
--- a/src/openvpn/forw=
ard=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -2122,14 +2122,6 @@
     }
 
     =
/*
-     * outgoing bcast buffer waiting to be sent?
-     */
-    if (flag=
s & IOW_MBUF)
-    {
-        socket |=3D EVENT_WRITE;
-    }
-
-    /*
   =
   * Force wait on TUN input, even if also waiting on TCP/UDP output
      =
*/
     if (flags & IOW_READ_TUN_FORCE)
diff --git a/src/openvpn/forward=2E=
h b/src/openvpn/forward=2Eh
index 324c0b4=2E=2E0309725 100644
--- a/src/ope=
nvpn/forward=2Eh
+++ b/src/openvpn/forward=2Eh
@@ -58,7 +58,6 @@
 #define I=
OW_SHAPER         (1 << 4)
 #define IOW_CHECK_RESIDUAL (1 << 5)
 #define IO=
W_FRAG           (1 << 6)
-#define IOW_MBUF           (1 << 7)
 #define IOW=
_READ_TUN_FORCE (1 << 8)
 #define IOW_WAIT_SIGNAL    (1 << 9)
 
diff --git =
a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 2b08ada=2E=2E94e03d6 10=
0644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -451,10 +451,=
9 @@
 static inline void
 multi_process_outgoing_link(struct multi_context =
*m, const unsigned int mpp_flags)
 {
-    struct multi_instance *mi =3D mul=
ti_process_outgoing_link_pre(m);
-    if (mi)
+    if (m->pending)
     {
-=
        multi_process_outgoing_link_dowork(m, mi, mpp_flags);
+        mult=
i_process_outgoing_link_dowork(m, m->pending, mpp_flags);
     }
 }
 
diff =
--git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec
index 51c7d31=
=2E=2E348e424 100644
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi=
_io=2Ec
@@ -177,10 +177,6 @@
             flags |=3D IOW_TO_LINK;
         =
}
     }
-    else if (mbuf_defined(m->mbuf))
-    {
-        flags |=3D IO=
W_MBUF;
-    }
     else
     {
         flags |=3D IOW_READ;
@@ -565,7 +56=
1,7 @@
     multi_io->n_esr =3D 0;
 
     /*
-     * Process queued mbuf pa=
ckets destined for TCP socket
+     * Drain the queued mbuf packets, datagr=
am and TCP instances alike
      */
     {
         struct multi_instance *=
mi;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I165c632da6=
a837d0cca55bee4c2cc390b91d1e54
Gerrit-Change-Number: 1962
Gerrit-PatchSet: =
3
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Rev=
iewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>

--xxizznlAdz8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Gian=
marco De Gregori=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1962?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">multi_io: drop IOW_MBUF<br><br>Before the UDP and TCP server loops wer=
e merged, each drained the<br>bcast/mcast/client-to-client queue its own wa=
y: UDP armed EVENT_WRITE<br>through IOW_MBUF, TCP used the flush loop at th=
e end of<br>multi_io_process_io()=2E  The merge kept both, leaving two cons=
umers with<br>different disciplines=2E<br><br>The queue mixes instances of =
both protocols and neither consumer gets to<br>pick: mbuf_peek() and multi_=
get_queue() hand back whatever sits at the<br>head=2E  The TCP side is prep=
ared for that, testing proto_is_dgram() and<br>tcp_link_out_deferred before=
 writing=2E  The UDP side is not: it writes<br>straight to the instance&#39=
;s own socket, so a TCP instance reaching it<br>skips the deferred queue th=
at carries backpressure=2E<br><br>Drain the queue from the flush loop alone=
 and drop the UDP consumer=2E<br>IOW_MBUF only existed to arm the socket fo=
r it, so it goes as well=2E<br><br>This leaves the queue drained from one e=
vent-driven point: the timeout<br>branch of tunnel_server_loop() does not r=
each the flush loop, so what<br>multi_io_action(TA_TIMEOUT) manages to queu=
e there waits for the next<br>pass that has events=2E  Acting on the queue =
only when there is an event<br>to act on is the simpler rule, and the delay=
 is bounded by the next<br>event=2E<br><br>Change-Id: I165c632da6a837d0cca5=
5bee4c2cc390b91d1e54<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@m=
andelbit=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962<br>Messag=
e-Id: &lt;20261005132023=2E27464-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: http=
s://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg397=
12=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br=
>---<br>M src/openvpn/forward=2Ec<br>M src/openvpn/forward=2Eh<br>M src/ope=
nvpn/mudp=2Ec<br>M src/openvpn/multi_io=2Ec<br>4 files changed, 3 insertion=
s(+), 17 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/62/1962/3</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index 1604224=
=2E=2Eb97fb7a 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><b=
r><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -2122,14 +2122,6 @=
@</span><br><span>     }</span><br><span> </span><br><span>     /*</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-     * outgoing bcast buffer w=
aiting to be sent?</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (flags &am=
p; IOW_MBUF)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        socket |=3D EVENT=
_WRITE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    /*</span><br><span>      * Force wait on TUN in=
put, even if also waiting on TCP/UDP output</span><br><span>      */</span>=
<br><span>     if (flags &amp; IOW_READ_TUN_FORCE)</span><br><span>diff --g=
it a/src/openvpn/forward=2Eh b/src/openvpn/forward=2Eh</span><br><span>inde=
x 324c0b4=2E=2E0309725 100644</span><br><span>--- a/src/openvpn/forward=2Eh=
</span><br><span>+++ b/src/openvpn/forward=2Eh</span><br><span>@@ -58,7 +58=
,6 @@</span><br><span> #define IOW_SHAPER         (1 &lt;&lt; 4)</span><br>=
<span> #define IOW_CHECK_RESIDUAL (1 &lt;&lt; 5)</span><br><span> #define I=
OW_FRAG           (1 &lt;&lt; 6)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define IOW_MBUF           (1 &lt;&lt; 7)</span><br><span> #defi=
ne IOW_READ_TUN_FORCE (1 &lt;&lt; 8)</span><br><span> #define IOW_WAIT_SIGN=
AL    (1 &lt;&lt; 9)</span><br><span> </span><br><span>diff --git a/src/ope=
nvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 2b08ada=2E=2E94e=
03d6 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ =
b/src/openvpn/mudp=2Ec</span><br><span>@@ -451,10 +451,9 @@</span><br><span=
> static inline void</span><br><span> multi_process_outgoing_link(struct mu=
lti_context *m, const unsigned int mpp_flags)</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    struct multi_instance *mi =
=3D multi_process_outgoing_link_pre(m);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (mi)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (m-&gt;pending)</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        multi_process_outgoing_link_dowor=
k(m, mi, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        multi_process_outgoing_link_dowork(m, m-&gt;pending, mpp_flags);</=
span><br><span>     }</span><br><span> }</span><br><span> </span><br><span>=
diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><br>=
<span>index 51c7d31=2E=2E348e424 100644</span><br><span>--- a/src/openvpn/m=
ulti_io=2Ec</span><br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><span>=
@@ -177,10 +177,6 @@</span><br><span>             flags |=3D IOW_TO_LINK;</=
span><br><span>         }</span><br><span>     }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    else if (mbuf_defined(m-&gt;mbuf))</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        flags |=3D IOW_MBUF;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span>     else</span><b=
r><span>     {</span><br><span>         flags |=3D IOW_READ;</span><br><spa=
n>@@ -565,7 +561,7 @@</span><br><span>     multi_io-&gt;n_esr =3D 0;</span>=
<br><span> </span><br><span>     /*</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-     * Process queued mbuf packets destined for TCP socket</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Drain the queue=
d mbuf packets, datagram and TCP instances alike</span><br><span>      */</=
span><br><span>     {</span><br><span>         struct multi_instance *mi;</=
span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1962?usp=3Demail">change 1962</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1962?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: I165c632da6a837d0cca55bee4c2cc3=
90b91d1e54 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1962 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"=
display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--xxizznlAdz8=--


--===============1110206434429134098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1110206434429134098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1110206434429134098==--

