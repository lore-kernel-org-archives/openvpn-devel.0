Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A37360A2601
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=V6P0sBU5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Q5zwq6Nb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OBIN/WWz;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bh+dkoRg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Hx/7dyNWHQaCRwrRl1qC9hEQJxQT1xLvBQ+15/Ioy6k=; b=V6P0sBU5ANvtSLaPbe9ZPsYVeT
	a1/qk63KUF1P8+lehYd0V+g4Mqi4DCmcpXtlw7iAt9PBOI07PYdTwDFUWdiZY7aq8cxsmi/uO4n8U
	pjAX7hAg7xgWEVpxL5VPmuY8B6tequaJhyj0bGDXmPAARJusMO97+6WxXgDOsksRyJZQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMr90-0000000082f-1LD0;
	Fri, 30 Oct 2026 18:16:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMr8y-0000000082R-3Z2X
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 18:16:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=139IlWpr7vpU2zdf1DqmBcQM7Jw/qQvBLLIELA9/sZA=; b=Q5zwq6NbkwIIUorfG0vRArgb9Z
 yliB/5VQez9CUDP/m2MgHCZq5WxHJoIqjWNQ75WMsDc/7QaTVxeu92B86mfcatLlFfvz81+atC9Tt
 l+KpaAyH6I9mXnG5XDCvQBMely9grzCT5A6PiZQ2JEu7M1GJsDNglxdq2rfVQJvlpxpc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=139IlWpr7vpU2zdf1DqmBcQM7Jw/qQvBLLIELA9/sZA=; b=OBIN/WWzhJY9TDmaYokMK595QT
 g5brAYSzGJnXgEWjQzLDHqiLZmTiJ7HvirqKNbL6v78IgXbjCZ/Z/mTCqvLpFrh69qlYybswuG4LI
 +O/Ifkqx9KKGan448YiKmErfMNLg77yLxAOUYZCyGkPZKreabxJP+xNWqNjQmM+BQFuw=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMr8w-000000005Fs-2viS for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 18:16:00 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48e4831c028so982809f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 11:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793384152; x=1793988952; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=139IlWpr7vpU2zdf1DqmBcQM7Jw/qQvBLLIELA9/sZA=;
 b=bh+dkoRgF7DcIJ/qHc0gkHesmP8DXTL5c2Wul5X3aIU4rS3v5nupEbHvEgp8kksgUt
 9J8SmfNYYCNjVt8XHBEt1TQdRCm/8Q5X+EfVDiMtynWI+w/CoJZhTyI+5lR7tpGuxXPz
 5Sl+qc/eIssW1xaAddMaQF2CWykTOUfbgbjmLJLUgAe0E9rEucW6IZDvr/G9d2kSLVvj
 z3EA57ZA1EywellTCOX2IbZVHRHvAFM3R1T+TBI06tstZsgYnhdG0uQhOYinCfBWEiZN
 ZEOK7SI6+O5d8bueDYmAac6wO/x9kOX6v/uXFOtiBtSG34cfYiZnpX/Rn8CJSnq0q1iU
 dRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793384152; x=1793988952;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=139IlWpr7vpU2zdf1DqmBcQM7Jw/qQvBLLIELA9/sZA=;
 b=rqhhkT8rKHXPPIKqAmMCb0sd7bAE3E+OdBUzcKlCgElaLt1wKRqoMZ79r9VFbWBLa1
 xd0bgISb+6w9fgOZtzgAETyNDamHOovBsaAdjqEqeRmoQzD1akRtGqtC3oVSxuDViwgJ
 ARSwJvMVHjvV/HM5A1vE4Bc2kECJOY2zZgo3ay6M0T6UT+ii39spdqYnPi4iyY3nejhV
 6iEanjFzqGoenT2EaSQ/TFk4iLUJ/6t+FamtyYnVOCL9UDyamuEMsz8tNf40hhd5Y5sc
 YFW1aY8gpOr5uaruxQp/RDeMq0c8AYJpPymPeJZAddpirbqVdQpvSMxN46Sh7AwezQ0h
 cKQg==
X-Gm-Message-State: AFq9FYIPi0HGGlL3VQtgxGSEOf1/N+QxcNsrKZjxKwrXGOcnbNoik2AM
 ywxHgZ5T5EoHQwcfsqqGTE88e0h3DY0JAtxOwffhQQoihxEvdT+RiAey4YjyZbEuErYepdFEtb/
 +jG0s1IhkLr8WSLCROKN/mawP6rG6r8HjEHeZoHwgpeINO32XcfhXSizbZjfD37jq0Y1i
X-Gm-Gg: AYBFou1SNUu/OL027Tt4zNvZZrJP2uLka9iOOlnpDpXna43N7jpipe8bKB7IIHRk/2u
 rO25bcaIqmh+2cYCg3DVDKFkyl1SLmq9EB54ZpuyDwzjXRCB9EWZXg4YyYzP6QPAUQWO9yqmrul
 D61xON7vAl3YLOaWFFyIxUZGWN5DKXe+pKjyCFeEWX7HHYP+YWo2z6PRa5mZ46ZkNaMPC2sp9zZ
 lG0CPPii+nXoeful0DviFMcXcgZSaFyrvZ1kn5R6TckiCxsg7nZGzqvZGojeyeL/ARJXnwc5pkf
 NPzRahYZ7OZ4XF/C4Z1WF8sz0SXVcaqPU7Be8b2mbm/tycphWJ/yt3G62a6LfGEjWjSQKgSLTOg
 Q5VCNxGZHV+rLsVl4vEZ+BB29mH4dY3tdYHnd0+hfza/UInA7/zwJgADT/z9Et4jfn0DsAvexqo
 RuZv6/aGF/o9/RVX81Lw2iIjUCsKOO1/BnJ+RfERu4YURliJVQxG6yt8GxupUbPLxyhr2LTD0tT
 Avlp7sWYlCJqNlJwyqVp4Zt0UdE6tevsnn12FV18Zn9yZTAQGZy3+yjEZC5zv8RD6CgwebIWkTk
 BK9v7LTixhOiWfBz76WdbCUlrI6e8D83zzzbLD61PJ1IekcDLpIAfaegblBczY7Po+3Gv7kj7NV
 YtMGmkDbH0/RmAtQSmOa/eIUE4fgDOSU0igStaqF5yaIpIsUmaXLILv464MAc8VeRCFbJ9Q9ZCI
 Vq04hEayq0llSxaFI=
X-Received: by 2002:a05:600c:470d:b0:4a7:9006:b176 with SMTP id
 5b1f17b1804b1-4ac17471285mr69516915e9.7.1793384151696; 
 Fri, 30 Oct 2026 11:15:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f3229dbsm151461215e9.1.2026.10.30.11.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:15:51 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 18:15:49 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I603585c6bb4e407d0df62f4233ff2c135aa00db0
X-Gerrit-Change-Number: 2041
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2041?usp=email>
X-Gerrit-Commit: 538fc7862eb89213d5abd60b7641dc4f4efc6967
In-Reply-To: <gerrit.1793094393000.I603585c6bb4e407d0df62f4233ff2c135aa00db0@gerrit.openvpn.net>
References: <gerrit.1793094393000.I603585c6bb4e407d0df62f4233ff2c135aa00db0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkk2MDM1ODVjNmJiNGU0MDdkMGRmNjJmNDIzM2ZmMmMxMzVhYTAwZGIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3b9ee85fd5c0ad4a82d4e4e8a25fb1fe1df76c6f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMr8w-000000005Fs-2viS
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mtcp: make
 set_global_rw_flags TCP only again
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7345416495664594158=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7345416495664594158==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KOI6QVJeR70="; charset=UTF-8

--KOI6QVJeR70=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Gianmarco De Gregori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2041?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by R=C4=83zvan Cojocaru


Change subject: mtcp: make set_gl=
obal_rw_flags TCP only again
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

mtcp: make set_global_rw_flags TCP only again

UDP sockets=
 are shared among instances and are already set in
multi_io_wait(), so call=
ing socket_set() on them per instance is
redundant=2E

On a server with two=
 UDP and one TCP listener this saves about one
epoll_ctl() per received pac=
ket (syscalls per received packet
5=2E75 -> 4=2E61, UDP only 6=2E82 -> 5=2E=
28) and, at saturation, delivers
about 10% more traffic with UDP only=2E

M=
ove the function back to mtcp=2Ec as multi_tcp_set_global_rw_flags()
and sk=
ip datagram instances=2E

Change-Id: I603585c6bb4e407d0df62f4233ff2c135aa00=
db0
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Acked-b=
y: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2041
Message-Id: <20261027130751=2E2950-1-gert@green=
ie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2E=
sourceforge=2Enet/msg40199=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/mtcp=2Ec
M src/openvpn/mtcp=2Eh
M src/openvp=
n/multi_io=2Ec
M src/openvpn/multi_io=2Eh
4 files changed, 16 insertions(+)=
, 26 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/41/2041/2

diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=
=2Ec
index c744638=2E=2E2b5c5b1 100644
--- a/src/openvpn/mtcp=2Ec
+++ b/src=
/openvpn/mtcp=2Ec
@@ -115,6 +115,18 @@
     multi_io->n_esr =3D 0;
 }
 
+vo=
id
+multi_tcp_set_global_rw_flags(struct multi_context *m, struct multi_ins=
tance *mi)
+{
+    if (mi && !proto_is_dgram(mi->context=2Ec2=2Elink_socket=
s[0]->info=2Eproto))
+    {
+        mi->socket_set_called =3D true;
+     =
   socket_set(mi->context=2Ec2=2Elink_sockets[0], m->multi_io->es,
+       =
            mbuf_defined(mi->tcp_link_out_deferred) ? EVENT_WRITE : EVENT_R=
EAD, &mi->ev_arg,
+                   &mi->tcp_rwflags);
+    }
+}
+
 bool
=
 multi_tcp_process_outgoing_link_ready(struct multi_context *m, struct mult=
i_instance *mi,
                                       const unsigned int m=
pp_flags)
diff --git a/src/openvpn/mtcp=2Eh b/src/openvpn/mtcp=2Eh
index bb=
117fa=2E=2Ede9d7ba 100644
--- a/src/openvpn/mtcp=2Eh
+++ b/src/openvpn/mtcp=
=2Eh
@@ -39,6 +39,8 @@
 
 void multi_tcp_instance_specific_free(struct mult=
i_instance *mi);
 
+void multi_tcp_set_global_rw_flags(struct multi_context=
 *m, struct multi_instance *mi);
+
 bool multi_tcp_process_outgoing_link(st=
ruct multi_context *m, bool defer,
                                      co=
nst unsigned int mpp_flags);
 
diff --git a/src/openvpn/multi_io=2Ec b/src/=
openvpn/multi_io=2Ec
index bb5dde58=2E=2Eebee86c 100644
--- a/src/openvpn/m=
ulti_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -122,28 +122,6 @@
 }
 
 void
=
-multi_io_set_global_rw_flags(struct multi_context *m, struct multi_instanc=
e *mi)
-{
-    if (!mi)
-    {
-        return;
-    }
-
-    mi->socket_se=
t_called =3D true;
-    if (proto_is_dgram(mi->context=2Ec2=2Elink_sockets[=
0]->info=2Eproto))
-    {
-        socket_set(mi->context=2Ec2=2Elink_socke=
ts[0], m->multi_io->es, EVENT_READ,
-                   &mi->context=2Ec2=
=2Elink_sockets[0]->ev_arg, NULL);
-    }
-    else
-    {
-        socket_=
set(mi->context=2Ec2=2Elink_sockets[0], m->multi_io->es,
-                 =
  mbuf_defined(mi->tcp_link_out_deferred) ? EVENT_WRITE : EVENT_READ, &mi->=
ev_arg,
-                   &mi->tcp_rwflags);
-    }
-}
-
-void
 multi_io_=
free(struct multi_io *multi_io)
 {
     if (multi_io)
@@ -378,7 +356,7 @@
 =

         case TA_INITIAL:
             ASSERT(mi);
-            multi_io_s=
et_global_rw_flags(m, mi);
+            multi_tcp_set_global_rw_flags(m, mi=
);
             multi_process_post(m, mi, mpp_flags);
             break;
 =

@@ -428,7 +406,7 @@
             }
             else
             {
-     =
           multi_io_set_global_rw_flags(m, mi);
+                multi_tcp_=
set_global_rw_flags(m, mi);
             }
             break;
 
diff --git=
 a/src/openvpn/multi_io=2Eh b/src/openvpn/multi_io=2Eh
index d6734bd=2E=2E4=
299cba 100644
--- a/src/openvpn/multi_io=2Eh
+++ b/src/openvpn/multi_io=2Eh=

@@ -68,8 +68,6 @@
 
 void multi_io_process_io(struct multi_context *m);
 
=
-void multi_io_set_global_rw_flags(struct multi_context *m, struct multi_in=
stance *mi);
-
 void multi_io_action(struct multi_context *m, struct multi_=
instance *mi, int action, bool poll);
 
 void multi_io_delete_event(struct =
multi_io *multi_io, event_t event);

-- 
To view, visit https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2041?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I603585c6bb4e407d0df62f4233ff2c135aa00db0
Gerrit-Chang=
e-Number: 2041
Gerrit-PatchSet: 2
Gerrit-Owner: Gianmarco De Gregori <gianm=
arco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--KOI6QVJeR70=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Gian=
marco De Gregori=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2041?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">mtcp: make set_global_rw_flags TCP only again<br><br>UDP sockets are s=
hared among instances and are already set in<br>multi_io_wait(), so calling=
 socket_set() on them per instance is<br>redundant=2E<br><br>On a server wi=
th two UDP and one TCP listener this saves about one<br>epoll_ctl() per rec=
eived packet (syscalls per received packet<br>5=2E75 -&gt; 4=2E61, UDP only=
 6=2E82 -&gt; 5=2E28) and, at saturation, delivers<br>about 10% more traffi=
c with UDP only=2E<br><br>Move the function back to mtcp=2Ec as multi_tcp_s=
et_global_rw_flags()<br>and skip datagram instances=2E<br><br>Change-Id: I6=
03585c6bb4e407d0df62f4233ff2c135aa00db0<br>Signed-off-by: Gianmarco De Greg=
ori &lt;gianmarco@mandelbit=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2041<br>Message-Id: &lt;20261027130751=2E2950-1-gert@greenie=2Emuc=2Ed=
e&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esource=
forge=2Enet/msg40199=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/mtcp=2Ec<br>M src/openvpn/mtcp=2Eh<=
br>M src/openvpn/multi_io=2Ec<br>M src/openvpn/multi_io=2Eh<br>4 files chan=
ged, 16 insertions(+), 26 deletions(-)<br><br></pre><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/2041/2</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</span><br><span>ind=
ex c744638=2E=2E2b5c5b1 100644</span><br><span>--- a/src/openvpn/mtcp=2Ec</=
span><br><span>+++ b/src/openvpn/mtcp=2Ec</span><br><span>@@ -115,6 +115,18=
 @@</span><br><span>     multi_io-&gt;n_esr =3D 0;</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_tcp_set_global_r=
w_flags(struct multi_context *m, struct multi_instance *mi)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (mi &amp;&amp; !proto_is_dgram(mi-&gt;context=
=2Ec2=2Elink_sockets[0]-&gt;info=2Eproto))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        mi-&gt;socket_set_called =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        socket_set(mi-&gt;context=2Ec2=2E=
link_sockets[0], m-&gt;multi_io-&gt;es,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                   mbuf_defined(mi-&gt;tcp_link_out_def=
erred) ? EVENT_WRITE : EVENT_READ, &amp;mi-&gt;ev_arg,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                   &amp;mi-&gt;tcp_rwfla=
gs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><span> multi_t=
cp_process_outgoing_link_ready(struct multi_context *m, struct multi_instan=
ce *mi,</span><br><span>                                       const unsign=
ed int mpp_flags)</span><br><span>diff --git a/src/openvpn/mtcp=2Eh b/src/o=
penvpn/mtcp=2Eh</span><br><span>index bb117fa=2E=2Ede9d7ba 100644</span><br=
><span>--- a/src/openvpn/mtcp=2Eh</span><br><span>+++ b/src/openvpn/mtcp=2E=
h</span><br><span>@@ -39,6 +39,8 @@</span><br><span> </span><br><span> void=
 multi_tcp_instance_specific_free(struct multi_instance *mi);</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+void multi_tcp_=
set_global_rw_flags(struct multi_context *m, struct multi_instance *mi);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool=
 multi_tcp_process_outgoing_link(struct multi_context *m, bool defer,</span=
><br><span>                                      const unsigned int mpp_fla=
gs);</span><br><span> </span><br><span>diff --git a/src/openvpn/multi_io=2E=
c b/src/openvpn/multi_io=2Ec</span><br><span>index bb5dde58=2E=2Eebee86c 10=
0644</span><br><span>--- a/src/openvpn/multi_io=2Ec</span><br><span>+++ b/s=
rc/openvpn/multi_io=2Ec</span><br><span>@@ -122,28 +122,6 @@</span><br><spa=
n> }</span><br><span> </span><br><span> void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-multi_io_set_global_rw_flags(struct multi_context *m=
, struct multi_instance *mi)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mi)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m=
i-&gt;socket_set_called =3D true;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (proto_is_dgram(mi-&gt;context=2Ec2=2Elink_sockets[0]-&g=
t;info=2Eproto))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        socket_set(mi=
-&gt;context=2Ec2=2Elink_sockets[0], m-&gt;multi_io-&gt;es, EVENT_READ,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                   &amp;m=
i-&gt;context=2Ec2=2Elink_sockets[0]-&gt;ev_arg, NULL);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        soc=
ket_set(mi-&gt;context=2Ec2=2Elink_sockets[0], m-&gt;multi_io-&gt;es,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                   mbuf_def=
ined(mi-&gt;tcp_link_out_deferred) ? EVENT_WRITE : EVENT_READ, &amp;mi-&gt;=
ev_arg,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
     &amp;mi-&gt;tcp_rwflags);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-void</span><br><span> multi_io_free(struct multi=
_io *multi_io)</span><br><span> {</span><br><span>     if (multi_io)</span>=
<br><span>@@ -378,7 +356,7 @@</span><br><span> </span><br><span>         ca=
se TA_INITIAL:</span><br><span>             ASSERT(mi);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            multi_io_set_global_rw_flags(=
m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
multi_tcp_set_global_rw_flags(m, mi);</span><br><span>             multi_pr=
ocess_post(m, mi, mpp_flags);</span><br><span>             break;</span><br=
><span> </span><br><span>@@ -428,7 +406,7 @@</span><br><span>             }=
</span><br><span>             else</span><br><span>             {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                multi_io_set_gl=
obal_rw_flags(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                multi_tcp_set_global_rw_flags(m, mi);</span><br><span>   =
          }</span><br><span>             break;</span><br><span> </span><br=
><span>diff --git a/src/openvpn/multi_io=2Eh b/src/openvpn/multi_io=2Eh</sp=
an><br><span>index d6734bd=2E=2E4299cba 100644</span><br><span>--- a/src/op=
envpn/multi_io=2Eh</span><br><span>+++ b/src/openvpn/multi_io=2Eh</span><br=
><span>@@ -68,8 +68,6 @@</span><br><span> </span><br><span> void multi_io_p=
rocess_io(struct multi_context *m);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void multi_io_set_global_rw_flags(struct mu=
lti_context *m, struct multi_instance *mi);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> void multi_io_action(struct multi_c=
ontext *m, struct multi_instance *mi, int action, bool poll);</span><br><sp=
an> </span><br><span> void multi_io_delete_event(struct multi_io *multi_io,=
 event_t event);</span><br></pre><p>To view, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2041?usp=3Demail">change 2041</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2041?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I603585c6bb4e=
407d0df62f4233ff2c135aa00db0 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 2041 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gia=
nmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--KOI6QVJeR70=--


--===============7345416495664594158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7345416495664594158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7345416495664594158==--

