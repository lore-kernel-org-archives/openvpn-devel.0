Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF36606A31B
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=krMkrwXt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=b/0WfInE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eSFpboS6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=CThFWsde
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=HJQ3hr+e+YCqoxsxmrobhrLoJhSwANDFElWF/OzAUaM=; b=krMkrwXtYUQirUEDNtp2sbbZ+l
	B2Gjf78uGY29gd8Tj1g+fh/9LURkt/FX5awFaDWgyXZdTXYPaSG0YI6m6vkdo6PzWHiLAQ9yeTKQE
	8eqZQLkgXBHmk/dUzIhP+sLAqCXrmob8cEZiMrbPT28LYENJiOoiYQSCGBzySawur9I8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLdlf-000000004sw-2HN4;
	Tue, 27 Oct 2026 09:46:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLdld-000000004sp-3FLl
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 09:46:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FDTCZNwDIPGIL7OzQrFQWU3YWOZuRwE54nnf72TQoOk=; b=b/0WfInEAET79/7VI/v9OeF04r
 cOJuqqxutUQw+G+8DEwrIJWA+OC1SHhYzagfVPb6WohBfQsesSjvrfR2XZbVzWKXnyfSpQAuecipn
 i5hxzp95ibN55rNhHUnNsCFCBRBILe5mZwon1BTG3YT/0SWZYhNLTITi85WRmTfg7q3c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FDTCZNwDIPGIL7OzQrFQWU3YWOZuRwE54nnf72TQoOk=; b=eSFpboS6nMupdWqo/uxAiIbwBr
 baRIJaGNZpblbinYQo7muD2KjhL6wklVVtpOMCYuRVly5OB3MXYS7HdKMgDOdswWrmORtfLwpsrCM
 MKvGifgf80Feh5EWb2FAYxkGOxDQ6H/pHG50ZjTzg2lJz9M8Qb5Hh7i2TnIXG9PYAVlc=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLdlc-000000001Dq-3Efv for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 09:46:53 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a35db1f202so21682345e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 02:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793094406; x=1793699206; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FDTCZNwDIPGIL7OzQrFQWU3YWOZuRwE54nnf72TQoOk=;
 b=CThFWsdebiFtCtBmsqFn1gZnDCnlcJpKg143WDwn++8qwp3bezAGi1q/thX4WGTUMG
 cMxl0gyJNUK+zaUbdE5KFojfJSUTWxKDZDsmzrtUwoRCMoFzxiu5ZHuCmOBN15Jwf0+C
 keaton5+kbuE8a6I2O9XQ4ehP7Sy/AznSheSD6iBJ/RgE8HiIqZxUk44Z+FbbPCxucox
 kDpdsYcubSSqM52PT36AqlMgAmTzE7Tf/ewItyY1G3XGZHyU3OTSCH84KGS+qmazzLko
 dtHvTUpT4Tr+aODA/pHZDrkB6EonvBgGVqFnk4V6nCgWrY3RlT9ZbU9Y9qLEBeMNFwCv
 dd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793094406; x=1793699206;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FDTCZNwDIPGIL7OzQrFQWU3YWOZuRwE54nnf72TQoOk=;
 b=oeFKSYpnv4A9mx6XTicgweZ082gI2fjfJD+bCgcBM1aqfRan9ThzUxfHZPhaDTos00
 x0VxoBXbd0BTyOUHNiQs8ooVsUceh9rGpM1w9MHHXHlGNl9dM9giVxhLZgn2jDjm7sAP
 P8wGXxjBYnZjbH9j3QGiSjzSrd+C6C5YTPStLLgSSCY/PRJR5QNOzRRi2JyEAv3HTBcU
 qSN7mJPXK8S/GjiDiavCrsX33rwJFBN4PQR+Md9fF45P7sOpi6xbpKJgmg/b5gIu6xk9
 QswXvcK8LFZAyEE1+XmQGhoLwni+VetU1NHUzmyQGHRttJFLTFrGkuuOxGvZlsmMpJwP
 J4Ng==
X-Gm-Message-State: AFq9FYLr6yubQV93mlhJXlcvOlcfE7qWJz/PdTDDlHtSmXeyKcSIUm5m
 GI15+G6TvnLm2WEywsP66wcinBQWJKtkalzzAY9FJfTdz2iNye6th2huTFLOEgli9obNEFIBUK6
 LXBgoUgaC5a8GrL/Aydyh3b7zJSlKwqIBpVgjbZ8mrvnnToTL/y7iM8Ur3xbC3G8AuT4HmgcJJ4
 NC/XNNtA==
X-Gm-Gg: AYBFou07oEVVCvf8leP2Nshzy7iuNtwmUnQjdLuQi50eD0utFiVbFVWVlCS+l2GKwYN
 MfCdqX1t5wyQcxQTvZLj76Ja03kqITqaAxZMH2CGXQ95RLD8x03/33h3vgS84w7Y0c5M+Ey5Fc+
 TiX4FPpj5jldZKMmcGFFH6TW2Hrl1cR+yqyQUlcSwydhW8MZVUvPbTryVS2TtmuntfmDiRlLCQB
 CtS3QlMJqiJjWttEXJ+QlpoMSHuVrLg4UpxHyU56URxKRMcry6kceti2B+4fYoF3Gsa4RNkgqwW
 BB5AMBFs+XM5oSWI5GLmjvD7A1CmgQqYUoI5dQqCOp4k+jedgyMJIGhbVs99V7LSM2v6fZQWTAz
 NeKfbxa/e84Q+V2ITdGYNJmlbPUBPZet0Dyzk94y6exMogTELhMIhSa8N206mtf2jxsHkR1SnGO
 Bq+do5LfS+al+phjUtwzWbkJHomwzqVg0GLj1hSW/1UPQeMnjrA4O4di85kUjzJhBlwgBy9CKjb
 x1uLTJqWYrFMhUGXmGWl666gXRTWxpVeriHgYk2WEg/SyXDMyTtCf99NgVM1cA3XLzDrIFhilaA
 MZY9ILHglY4c/7VZiHago6Xq/bhiw0N/ghMR8M25cBal6NXTgRUterICO5HdpWYzqloLWwfte87
 Ixp9whANxOetn4ZbC3+HVvo5g75fcHK6oJu7CyZBq1Q==
X-Received: by 2002:a05:600c:1c06:b0:4a1:e7ce:107b with SMTP id
 5b1f17b1804b1-4a35ac407fdmr237110745e9.2.1793094406119; 
 Tue, 27 Oct 2026 02:46:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd8ddasm23831737f8f.48.2026.10.27.02.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 02:46:45 -0700 (PDT)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 09:46:45 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I603585c6bb4e407d0df62f4233ff2c135aa00db0
X-Gerrit-Change-Number: 2041
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2041?usp=email>
X-Gerrit-Commit: 2e48699e11ea6707ff614a4e1875347ade768c24
References: <gerrit.1793094393000.I603585c6bb4e407d0df62f4233ff2c135aa00db0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkk2MDM1ODVjNmJiNGU0MDdkMGRmNjJmNDIzM2ZmMmMxMzVhYTAwZGIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b65028f71056564d841c790722ead35758e7ed2f-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLdlc-000000001Dq-3Efv
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
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4157150517557283095=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4157150517557283095==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hmK950cOSGA="; charset=UTF-8

--hmK950cOSGA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2041?usp=3Demail

to review the following change=2E
=


Change subject: mtcp: make set_global_rw_flags TCP only again
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

mtcp: make set_global_=
rw_flags TCP only again

UDP sockets are shared among instances and are alr=
eady set in
multi_io_wait(), so calling socket_set() on them per instance i=
s
redundant=2E

On a server with two UDP and one TCP listener this saves ab=
out one
epoll_ctl() per received packet (syscalls per received packet
5=2E7=
5 -> 4=2E61, UDP only 6=2E82 -> 5=2E28) and, at saturation, delivers
about =
10% more traffic with UDP only=2E

Move the function back to mtcp=2Ec as mu=
lti_tcp_set_global_rw_flags()
and skip datagram instances=2E

Change-Id: I6=
03585c6bb4e407d0df62f4233ff2c135aa00db0
Signed-off-by: Gianmarco De Gregori=
 <gianmarco@mandelbit=2Ecom>
---
M src/openvpn/mtcp=2Ec
M src/openvpn/mtcp=
=2Eh
M src/openvpn/multi_io=2Ec
M src/openvpn/multi_io=2Eh
4 files changed,=
 16 insertions(+), 26 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/41/2041/1

diff --git a/src/openvpn/mtcp=2Ec =
b/src/openvpn/mtcp=2Ec
index c744638=2E=2E2b5c5b1 100644
--- a/src/openvpn/=
mtcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -115,6 +115,18 @@
     multi_io->n_e=
sr =3D 0;
 }
 
+void
+multi_tcp_set_global_rw_flags(struct multi_context *m=
, struct multi_instance *mi)
+{
+    if (mi && !proto_is_dgram(mi->context=
=2Ec2=2Elink_sockets[0]->info=2Eproto))
+    {
+        mi->socket_set_call=
ed =3D true;
+        socket_set(mi->context=2Ec2=2Elink_sockets[0], m->mul=
ti_io->es,
+                   mbuf_defined(mi->tcp_link_out_deferred) ? EV=
ENT_WRITE : EVENT_READ, &mi->ev_arg,
+                   &mi->tcp_rwflags);=

+    }
+}
+
 bool
 multi_tcp_process_outgoing_link_ready(struct multi_cont=
ext *m, struct multi_instance *mi,
                                       c=
onst unsigned int mpp_flags)
diff --git a/src/openvpn/mtcp=2Eh b/src/openvp=
n/mtcp=2Eh
index bb117fa=2E=2Ede9d7ba 100644
--- a/src/openvpn/mtcp=2Eh
+++=
 b/src/openvpn/mtcp=2Eh
@@ -39,6 +39,8 @@
 
 void multi_tcp_instance_specif=
ic_free(struct multi_instance *mi);
 
+void multi_tcp_set_global_rw_flags(s=
truct multi_context *m, struct multi_instance *mi);
+
 bool multi_tcp_proce=
ss_outgoing_link(struct multi_context *m, bool defer,
                     =
                 const unsigned int mpp_flags);
 
diff --git a/src/openvpn/=
multi_io=2Ec b/src/openvpn/multi_io=2Ec
index bb5dde58=2E=2Eebee86c 100644
=
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -122,28 +1=
22,6 @@
 }
 
 void
-multi_io_set_global_rw_flags(struct multi_context *m, s=
truct multi_instance *mi)
-{
-    if (!mi)
-    {
-        return;
-    }
-=

-    mi->socket_set_called =3D true;
-    if (proto_is_dgram(mi->context=
=2Ec2=2Elink_sockets[0]->info=2Eproto))
-    {
-        socket_set(mi->cont=
ext=2Ec2=2Elink_sockets[0], m->multi_io->es, EVENT_READ,
-                 =
  &mi->context=2Ec2=2Elink_sockets[0]->ev_arg, NULL);
-    }
-    else
-   =
 {
-        socket_set(mi->context=2Ec2=2Elink_sockets[0], m->multi_io->es,=

-                   mbuf_defined(mi->tcp_link_out_deferred) ? EVENT_WRITE =
: EVENT_READ, &mi->ev_arg,
-                   &mi->tcp_rwflags);
-    }
-}=

-
-void
 multi_io_free(struct multi_io *multi_io)
 {
     if (multi_io)
@@=
 -378,7 +356,7 @@
 
         case TA_INITIAL:
             ASSERT(mi);
-   =
         multi_io_set_global_rw_flags(m, mi);
+            multi_tcp_set_gl=
obal_rw_flags(m, mi);
             multi_process_post(m, mi, mpp_flags);
  =
           break;
 
@@ -428,7 +406,7 @@
             }
             else
  =
           {
-                multi_io_set_global_rw_flags(m, mi);
+       =
         multi_tcp_set_global_rw_flags(m, mi);
             }
             =
break;
 
diff --git a/src/openvpn/multi_io=2Eh b/src/openvpn/multi_io=2Eh
i=
ndex d6734bd=2E=2E4299cba 100644
--- a/src/openvpn/multi_io=2Eh
+++ b/src/o=
penvpn/multi_io=2Eh
@@ -68,8 +68,6 @@
 
 void multi_io_process_io(struct mu=
lti_context *m);
 
-void multi_io_set_global_rw_flags(struct multi_context =
*m, struct multi_instance *mi);
-
 void multi_io_action(struct multi_contex=
t *m, struct multi_instance *mi, int action, bool poll);
 
 void multi_io_d=
elete_event(struct multi_io *multi_io, event_t event);

-- 
To view, visit =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2041?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I603585c6bb4e407d0df62f4233ff2c135aa0=
0db0
Gerrit-Change-Number: 2041
Gerrit-PatchSet: 1
Gerrit-Owner: Gianmarco =
De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--hmK950cOSGA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gianmarco De Gregori would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2041?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">mtcp: make set_global_rw_flags TCP only again<br><br>UD=
P sockets are shared among instances and are already set in<br>multi_io_wai=
t(), so calling socket_set() on them per instance is<br>redundant=2E<br><br=
>On a server with two UDP and one TCP listener this saves about one<br>epol=
l_ctl() per received packet (syscalls per received packet<br>5=2E75 -&gt; 4=
=2E61, UDP only 6=2E82 -&gt; 5=2E28) and, at saturation, delivers<br>about =
10% more traffic with UDP only=2E<br><br>Move the function back to mtcp=2Ec=
 as multi_tcp_set_global_rw_flags()<br>and skip datagram instances=2E<br><b=
r>Change-Id: I603585c6bb4e407d0df62f4233ff2c135aa00db0<br>Signed-off-by: Gi=
anmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<br>---<br>M src/openvp=
n/mtcp=2Ec<br>M src/openvpn/mtcp=2Eh<br>M src/openvpn/multi_io=2Ec<br>M src=
/openvpn/multi_io=2Eh<br>4 files changed, 16 insertions(+), 26 deletions(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/41/2041/1</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mtcp=2Ec b/src=
/openvpn/mtcp=2Ec</span><br><span>index c744638=2E=2E2b5c5b1 100644</span><=
br><span>--- a/src/openvpn/mtcp=2Ec</span><br><span>+++ b/src/openvpn/mtcp=
=2Ec</span><br><span>@@ -115,6 +115,18 @@</span><br><span>     multi_io-&gt=
;n_esr =3D 0;</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+multi_tcp_set_global_rw_flags(struct multi_context *m, stru=
ct multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (mi &amp=
;&amp; !proto_is_dgram(mi-&gt;context=2Ec2=2Elink_sockets[0]-&gt;info=2Epro=
to))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;socket_set_cal=
led =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  socket_set(mi-&gt;context=2Ec2=2Elink_sockets[0], m-&gt;multi_io-&gt;es,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   m=
buf_defined(mi-&gt;tcp_link_out_deferred) ? EVENT_WRITE : EVENT_READ, &amp;=
mi-&gt;ev_arg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
              &amp;mi-&gt;tcp_rwflags);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> bool</span><br><span> multi_tcp_process_outgoing_link_ready(struct mu=
lti_context *m, struct multi_instance *mi,</span><br><span>                =
                       const unsigned int mpp_flags)</span><br><span>diff -=
-git a/src/openvpn/mtcp=2Eh b/src/openvpn/mtcp=2Eh</span><br><span>index bb=
117fa=2E=2Ede9d7ba 100644</span><br><span>--- a/src/openvpn/mtcp=2Eh</span>=
<br><span>+++ b/src/openvpn/mtcp=2Eh</span><br><span>@@ -39,6 +39,8 @@</spa=
n><br><span> </span><br><span> void multi_tcp_instance_specific_free(struct=
 multi_instance *mi);</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+void multi_tcp_set_global_rw_flags(struct multi_context=
 *m, struct multi_instance *mi);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> bool multi_tcp_process_outgoing_link(struct =
multi_context *m, bool defer,</span><br><span>                             =
         const unsigned int mpp_flags);</span><br><span> </span><br><span>d=
iff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><br><=
span>index bb5dde58=2E=2Eebee86c 100644</span><br><span>--- a/src/openvpn/m=
ulti_io=2Ec</span><br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><span>=
@@ -122,28 +122,6 @@</span><br><span> }</span><br><span> </span><br><span> =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_io_set_glob=
al_rw_flags(struct multi_context *m, struct multi_instance *mi)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (!mi)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    mi-&gt;socket_set_called =3D true;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (proto_is_dgram(mi-&gt=
;context=2Ec2=2Elink_sockets[0]-&gt;info=2Eproto))</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        socket_set(mi-&gt;context=2Ec2=2Elink_sockets[0], m-&g=
t;multi_io-&gt;es, EVENT_READ,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                   &amp;mi-&gt;context=2Ec2=2Elink_sockets[0]-&gt;=
ev_arg, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        socket_set(mi-&gt;context=2Ec2=2Elink_socket=
s[0], m-&gt;multi_io-&gt;es,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                   mbuf_defined(mi-&gt;tcp_link_out_deferred) ? EVEN=
T_WRITE : EVENT_READ, &amp;mi-&gt;ev_arg,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                   &amp;mi-&gt;tcp_rwflags);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br=
><span> multi_io_free(struct multi_io *multi_io)</span><br><span> {</span><=
br><span>     if (multi_io)</span><br><span>@@ -378,7 +356,7 @@</span><br><=
span> </span><br><span>         case TA_INITIAL:</span><br><span>          =
   ASSERT(mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     multi_io_set_global_rw_flags(m, mi);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            multi_tcp_set_global_rw_flags(m, mi);</sp=
an><br><span>             multi_process_post(m, mi, mpp_flags);</span><br><=
span>             break;</span><br><span> </span><br><span>@@ -428,7 +406,7=
 @@</span><br><span>             }</span><br><span>             else</span>=
<br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                multi_io_set_global_rw_flags(m, mi);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                multi_tcp_set_global_rw=
_flags(m, mi);</span><br><span>             }</span><br><span>             =
break;</span><br><span> </span><br><span>diff --git a/src/openvpn/multi_io=
=2Eh b/src/openvpn/multi_io=2Eh</span><br><span>index d6734bd=2E=2E4299cba =
100644</span><br><span>--- a/src/openvpn/multi_io=2Eh</span><br><span>+++ b=
/src/openvpn/multi_io=2Eh</span><br><span>@@ -68,8 +68,6 @@</span><br><span=
> </span><br><span> void multi_io_process_io(struct multi_context *m);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void mul=
ti_io_set_global_rw_flags(struct multi_context *m, struct multi_instance *m=
i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
void multi_io_action(struct multi_context *m, struct multi_instance *mi, in=
t action, bool poll);</span><br><span> </span><br><span> void multi_io_dele=
te_event(struct multi_io *multi_io, event_t event);</span><br></pre><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2041?usp=
=3Demail">change 2041</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2041?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I603585c6bb4e407d0df62f4233ff2c135aa00db0 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2041 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--hmK950cOSGA=--


--===============4157150517557283095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4157150517557283095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4157150517557283095==--

