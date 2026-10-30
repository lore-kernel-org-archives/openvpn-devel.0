Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8697F606A334
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LBe+ajII;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PvBlHER0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XyhxgarU;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=duPuNAWY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=R/W7UbrEN9+ruafDOmdZdObV0YEBYFUmmhNoVTU9wg8=; b=LBe+ajII6vHuz2XfAcincpjZwl
	9KNV7Qegv1hzaKvRD7JkWPf5SWYzo3gIFRb51TQBju1KjbCRD7/XQuHnzzYZcsNtJAY8YTgXDFEG0
	qsalT2t11Xdg2PKsq6xdKkBeCU4zuWeEQ1lMV8dYgo3A2e6wTTZSLQ1fWh+JH+b8PAEQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMr91-000000006Tx-11nm;
	Fri, 30 Oct 2026 18:16:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMr8z-000000006Tk-3950
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 18:16:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E/TAD0jMna2ja0mMWKFr+ZkifzA9M+rHiyR0bNNWX2U=; b=PvBlHER0I7qOAoU06o5BGk9+zU
 j6BAFZgjD0bxsJJauETCePbAyIonrn1swE2tVuEL0olOewln8F0HCbvddmYlv5VHxrlJ5W3rwjXbZ
 oDp4jj/P5kTzzy+b6fdOneCVVSqwrzIodIUPfqKtkuoQu95+xRN9x5qeUe5t3dsax0Qk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E/TAD0jMna2ja0mMWKFr+ZkifzA9M+rHiyR0bNNWX2U=; b=XyhxgarUk0sPCQ3GySt9/Bcisw
 U7h4h44+139FQLY0u6VnV11n0uex1tae57uoShm8Eka6nSS8SxYj5NcCOIMiRW6zx8E9hhJV2yk9w
 XedZQ061jvVKLK+kYWxS7NsmcrYV66ZzlbbJzEdvKxhr54h9jiuc5dnjyWn5nzU4nd70=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMr8x-000000000ii-0l6Q for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 18:16:01 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so13510245e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 11:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793384153; x=1793988953; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=E/TAD0jMna2ja0mMWKFr+ZkifzA9M+rHiyR0bNNWX2U=;
 b=duPuNAWYTE2f+u/D22+cLTXcoZbSSx4QrIZuyaMzpn3LCvyNRBYMihpYd4SiBMSqgj
 DldnpRPAKFM92Qi2JYsGSLHfMRvh2ZeOKX18W4WJhJlZKzBjLRhgeKLgIcE7Jf0u6DB3
 Igy4+oUKNLTUrTieDLC6vjPN/0axfAYBG2bstR3bfPBpPuFZS9jjEzR74rqW7O0VPsT7
 v4m4pCqV0v//+K5VW5WQpWyCMMkluoNZHd3gJ9/fmLJpmbcrTLVdVRc/UFCfOVBqVoaq
 EiiMxyDn6l/9+LlfSIUGWK8WBzDKRBrP8kxDKyWgCFez9rDpVvktI5iPsVVYBR6VXQ3b
 zVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793384153; x=1793988953;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=E/TAD0jMna2ja0mMWKFr+ZkifzA9M+rHiyR0bNNWX2U=;
 b=Nb9WjiviAtHaemDBkp891hN6ODkVCeM6nTKRLSB28jEFdiev7b1N4lxox9DMXAPPzH
 AGcfMD3Ap7K4V9lMbziFVMQh7e7t0AW1WZf90wpfx4GNLSgR7MxKlUpgBKx9yDI9nQFG
 sal+8cC28s2jiHdK0hBWg90A3SznUrPolGYoLpLyFBAe7s/PVwRp57HswJAzOdn5RP3Q
 LfM+zdvXnpUd1o9WERsJNcwH6qjKXqCsfVsiwrlO9V41OnigPQCI9bWzDyTl7i5R2r01
 7vI4vL5zHp9BFSxIjRB/4LuFySigDsYuQIOdYkC2uWLvbcNDryHrOwJKCTLFcmfSV3vR
 h93w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVDg+biUUCfZd9ZuPvLr5MV6dXEl2vVEDWt060PNMyDCjM3yaQxytgGhimEa6C60DS/UK1UV+jmV5XdXNH@lists.sourceforge.net
X-Gm-Message-State: AFq9FYL18JrNkIoOotRRIHiQHlC42zfKIepyuVSc1HMUQFH/hiPYdzht
 TcwgCa6sMvOsH9Rj/FltiO0q6h1+Dh9EittGs5L7sXVAodJc85MqDFhWZnv/O4dl2dHhB5eN/49
 8gr1a2b9eMmMEoCeYk5q2DcdM6lKs50uV5L2D/KS37PaGHQ/hqYpTgXq/Y1TsECETnsS+
X-Gm-Gg: AYBFou2UQyttd3ekg0hZNZ57cxREzIx/kFyNui998M9A7rT5/vU5pFcf66VKVGBXJYQ
 vdFiox7ws4ZXWiaFMii9Wxl468KdxlSWRlX2DujL8+sR6DCHkUfjJKP5XkfDcMKd5WcoHioWa6H
 QAMEJ4dWsaNwIcbHKQNTiohP8R/Y2OADrjc1hE/L5AhZeyu0ffmGAgzR1nwG0slEcjUFdNLGk6g
 12cqMdcWMDVSFkdAPwScUICDHV+H3Y8QF9ijUKjvmcu/88Jdns7+lhW0EOxmK59G/k7BUd8Tdym
 ZP41N5LqgvSAHhsitokSIkaddremXrLgkwCEZgVdwDMgJv9wOUuRqNI8hIAvf3Nu7JeXZioUGoG
 8uQPx7CwgNRJZSfzLEmwRm6IM3Q8+TWHybi/gDz5QySger0rKZsZZfBBxqaLc4FTsVJ9SY7WX3I
 72Nsi6lDqry8sxxYSgVW6QI+cKzoR4OoVhLDwCjyx0bTuiD2cYKqQzTc8KKklXf/V0yljYuuRqe
 2t+KeRW77IcJG+5dYPqpVtZJiPdv9xAuk97cBJHq75UXAPHB6eff6hHMFkl9kRekBRwt2ENQtty
 Y+LLZ/eoymi3gJ6C88WtLkFl6zfCrqfl3j4qUMPlrAx6HuROzh+WtCf8Q0HMs4V0A9UKt8lMs7k
 AhUnuzwJzSsMYHFQeHK0eU/InRI04OojeHIVszb7tLBmG27qMhu3udbHonZyTrlhfG8PCEISky8
 olv28bzuMNAAxvPTc=
X-Received: by 2002:a05:600c:c87:b0:4a1:efbe:529c with SMTP id
 5b1f17b1804b1-4ac17567fe1mr72783115e9.12.1793384152485; 
 Fri, 30 Oct 2026 11:15:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b9a3b1sm4830909f8f.44.2026.10.30.11.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:15:52 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 18:15:51 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I603585c6bb4e407d0df62f4233ff2c135aa00db0
X-Gerrit-Change-Number: 2041
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2041?usp=email>
X-Gerrit-Commit: 538fc7862eb89213d5abd60b7641dc4f4efc6967
In-Reply-To: <gerrit.1793094393000.I603585c6bb4e407d0df62f4233ff2c135aa00db0@gerrit.openvpn.net>
References: <gerrit.1793094393000.I603585c6bb4e407d0df62f4233ff2c135aa00db0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkk2MDM1ODVjNmJiNGU0MDdkMGRmNjJmNDIzM2ZmMmMxMzVhYTAwZGIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3b9ee85fd5c0ad4a82d4e4e8a25fb1fe1df76c6f-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMr8x-000000000ii-0l6Q
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0204700192085895847=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,T_KAM_HTML_FONT_INVALID autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0204700192085895847==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ynT9VzQ8Dvg="; charset=UTF-8

--ynT9VzQ8Dvg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2041?usp=3Demail )

Change subject: mtcp: make set_global_rw_fl=
ags TCP only again
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

mtcp: make set_global_rw_flags TCP only again

UDP sockets are shar=
ed among instances and are already set in
multi_io_wait(), so calling socke=
t_set() on them per instance is
redundant=2E

On a server with two UDP and =
one TCP listener this saves about one
epoll_ctl() per received packet (sysc=
alls per received packet
5=2E75 -> 4=2E61, UDP only 6=2E82 -> 5=2E28) and, =
at saturation, delivers
about 10% more traffic with UDP only=2E

Move the f=
unction back to mtcp=2Ec as multi_tcp_set_global_rw_flags()
and skip datagr=
am instances=2E

Change-Id: I603585c6bb4e407d0df62f4233ff2c135aa00db0
Signe=
d-off-by: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Acked-by: Razvan=
 Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2041
Message-Id: <20261027130751=2E2950-1-gert@greenie=2Emuc=
=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg40199=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpn/mtcp=2Ec
M src/openvpn/mtcp=2Eh
M src/openvpn/mult=
i_io=2Ec
M src/openvpn/multi_io=2Eh
4 files changed, 16 insertions(+), 26 d=
eletions(-)




diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
in=
dex c744638=2E=2E2b5c5b1 100644
--- a/src/openvpn/mtcp=2Ec
+++ b/src/openvp=
n/mtcp=2Ec
@@ -115,6 +115,18 @@
     multi_io->n_esr =3D 0;
 }
 
+void
+mul=
ti_tcp_set_global_rw_flags(struct multi_context *m, struct multi_instance *=
mi)
+{
+    if (mi && !proto_is_dgram(mi->context=2Ec2=2Elink_sockets[0]->i=
nfo=2Eproto))
+    {
+        mi->socket_set_called =3D true;
+        sock=
et_set(mi->context=2Ec2=2Elink_sockets[0], m->multi_io->es,
+              =
     mbuf_defined(mi->tcp_link_out_deferred) ? EVENT_WRITE : EVENT_READ, &m=
i->ev_arg,
+                   &mi->tcp_rwflags);
+    }
+}
+
 bool
 multi_=
tcp_process_outgoing_link_ready(struct multi_context *m, struct multi_insta=
nce *mi,
                                       const unsigned int mpp_flag=
s)
diff --git a/src/openvpn/mtcp=2Eh b/src/openvpn/mtcp=2Eh
index bb117fa=
=2E=2Ede9d7ba 100644
--- a/src/openvpn/mtcp=2Eh
+++ b/src/openvpn/mtcp=2Eh
=
@@ -39,6 +39,8 @@
 
 void multi_tcp_instance_specific_free(struct multi_ins=
tance *mi);
 
+void multi_tcp_set_global_rw_flags(struct multi_context *m, =
struct multi_instance *mi);
+
 bool multi_tcp_process_outgoing_link(struct =
multi_context *m, bool defer,
                                      const u=
nsigned int mpp_flags);
 
diff --git a/src/openvpn/multi_io=2Ec b/src/openv=
pn/multi_io=2Ec
index bb5dde58=2E=2Eebee86c 100644
--- a/src/openvpn/multi_=
io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -122,28 +122,6 @@
 }
 
 void
-mult=
i_io_set_global_rw_flags(struct multi_context *m, struct multi_instance *mi=
)
-{
-    if (!mi)
-    {
-        return;
-    }
-
-    mi->socket_set_cal=
led =3D true;
-    if (proto_is_dgram(mi->context=2Ec2=2Elink_sockets[0]->i=
nfo=2Eproto))
-    {
-        socket_set(mi->context=2Ec2=2Elink_sockets[0]=
, m->multi_io->es, EVENT_READ,
-                   &mi->context=2Ec2=2Elink=
_sockets[0]->ev_arg, NULL);
-    }
-    else
-    {
-        socket_set(mi-=
>context=2Ec2=2Elink_sockets[0], m->multi_io->es,
-                   mbuf_=
defined(mi->tcp_link_out_deferred) ? EVENT_WRITE : EVENT_READ, &mi->ev_arg,=

-                   &mi->tcp_rwflags);
-    }
-}
-
-void
 multi_io_free(st=
ruct multi_io *multi_io)
 {
     if (multi_io)
@@ -378,7 +356,7 @@
 
      =
   case TA_INITIAL:
             ASSERT(mi);
-            multi_io_set_glob=
al_rw_flags(m, mi);
+            multi_tcp_set_global_rw_flags(m, mi);
    =
         multi_process_post(m, mi, mpp_flags);
             break;
 
@@ -42=
8,7 +406,7 @@
             }
             else
             {
-            =
    multi_io_set_global_rw_flags(m, mi);
+                multi_tcp_set_glo=
bal_rw_flags(m, mi);
             }
             break;
 
diff --git a/src/=
openvpn/multi_io=2Eh b/src/openvpn/multi_io=2Eh
index d6734bd=2E=2E4299cba =
100644
--- a/src/openvpn/multi_io=2Eh
+++ b/src/openvpn/multi_io=2Eh
@@ -68=
,8 +68,6 @@
 
 void multi_io_process_io(struct multi_context *m);
 
-void m=
ulti_io_set_global_rw_flags(struct multi_context *m, struct multi_instance =
*mi);
-
 void multi_io_action(struct multi_context *m, struct multi_instanc=
e *mi, int action, bool poll);
 
 void multi_io_delete_event(struct multi_i=
o *multi_io, event_t event);

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2041?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I603585c6bb4e407d0df62f4233ff2c135aa00db0
Gerrit-Change-Number: =
2041
Gerrit-PatchSet: 2
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mande=
lbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--ynT9VzQ8Dvg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2041?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">mtcp: make set_global_rw_flags TCP=
 only again<br><br>UDP sockets are shared among instances and are already s=
et in<br>multi_io_wait(), so calling socket_set() on them per instance is<b=
r>redundant=2E<br><br>On a server with two UDP and one TCP listener this sa=
ves about one<br>epoll_ctl() per received packet (syscalls per received pac=
ket<br>5=2E75 -&gt; 4=2E61, UDP only 6=2E82 -&gt; 5=2E28) and, at saturatio=
n, delivers<br>about 10% more traffic with UDP only=2E<br><br>Move the func=
tion back to mtcp=2Ec as multi_tcp_set_global_rw_flags()<br>and skip datagr=
am instances=2E<br><br>Change-Id: I603585c6bb4e407d0df62f4233ff2c135aa00db0=
<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<b=
r>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2041<br>Message-Id: &lt;2026102713=
0751=2E2950-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archiv=
e=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40199=2Ehtml<br>Signed-o=
ff-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn=
/mtcp=2Ec<br>M src/openvpn/mtcp=2Eh<br>M src/openvpn/multi_io=2Ec<br>M src/=
openvpn/multi_io=2Eh<br>4 files changed, 16 insertions(+), 26 deletions(-)<=
br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</=
span><br><span>index c744638=2E=2E2b5c5b1 100644</span><br><span>--- a/src/=
openvpn/mtcp=2Ec</span><br><span>+++ b/src/openvpn/mtcp=2Ec</span><br><span=
>@@ -115,6 +115,18 @@</span><br><span>     multi_io-&gt;n_esr =3D 0;</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mult=
i_tcp_set_global_rw_flags(struct multi_context *m, struct multi_instance *m=
i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (mi &amp;&amp; !proto_is_dgr=
am(mi-&gt;context=2Ec2=2Elink_sockets[0]-&gt;info=2Eproto))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        mi-&gt;socket_set_called =3D true;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        socket_set(mi-&gt;=
context=2Ec2=2Elink_sockets[0], m-&gt;multi_io-&gt;es,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                   mbuf_defined(mi-&gt;t=
cp_link_out_deferred) ? EVENT_WRITE : EVENT_READ, &amp;mi-&gt;ev_arg,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                   &amp;m=
i-&gt;tcp_rwflags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br=
><span> multi_tcp_process_outgoing_link_ready(struct multi_context *m, stru=
ct multi_instance *mi,</span><br><span>                                    =
   const unsigned int mpp_flags)</span><br><span>diff --git a/src/openvpn/m=
tcp=2Eh b/src/openvpn/mtcp=2Eh</span><br><span>index bb117fa=2E=2Ede9d7ba 1=
00644</span><br><span>--- a/src/openvpn/mtcp=2Eh</span><br><span>+++ b/src/=
openvpn/mtcp=2Eh</span><br><span>@@ -39,6 +39,8 @@</span><br><span> </span>=
<br><span> void multi_tcp_instance_specific_free(struct multi_instance *mi)=
;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
void multi_tcp_set_global_rw_flags(struct multi_context *m, struct multi_in=
stance *mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> bool multi_tcp_process_outgoing_link(struct multi_context *m, bo=
ol defer,</span><br><span>                                      const unsig=
ned int mpp_flags);</span><br><span> </span><br><span>diff --git a/src/open=
vpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>index bb5dde58=
=2E=2Eebee86c 100644</span><br><span>--- a/src/openvpn/multi_io=2Ec</span><=
br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><span>@@ -122,28 +122,6 @=
@</span><br><span> }</span><br><span> </span><br><span> void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-multi_io_set_global_rw_flags(struct =
multi_context *m, struct multi_instance *mi)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (!mi)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    mi-&gt;socket_set_called =3D true;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (proto_is_dgram(mi-&gt;context=2Ec2=2Eli=
nk_sockets[0]-&gt;info=2Eproto))</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   socket_set(mi-&gt;context=2Ec2=2Elink_sockets[0], m-&gt;multi_io-&gt;es,=
 EVENT_READ,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
          &amp;mi-&gt;context=2Ec2=2Elink_sockets[0]-&gt;ev_arg, NULL);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        socket_set(mi-&gt;context=2Ec2=2Elink_sockets[0], m-&gt;multi_=
io-&gt;es,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
        mbuf_defined(mi-&gt;tcp_link_out_deferred) ? EVENT_WRITE : EVENT_RE=
AD, &amp;mi-&gt;ev_arg,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                   &amp;mi-&gt;tcp_rwflags);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span> multi_io_f=
ree(struct multi_io *multi_io)</span><br><span> {</span><br><span>     if (=
multi_io)</span><br><span>@@ -378,7 +356,7 @@</span><br><span> </span><br><=
span>         case TA_INITIAL:</span><br><span>             ASSERT(mi);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            multi_io_set_=
global_rw_flags(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            multi_tcp_set_global_rw_flags(m, mi);</span><br><span>     =
        multi_process_post(m, mi, mpp_flags);</span><br><span>             =
break;</span><br><span> </span><br><span>@@ -428,7 +406,7 @@</span><br><spa=
n>             }</span><br><span>             else</span><br><span>        =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 multi_io_set_global_rw_flags(m, mi);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                multi_tcp_set_global_rw_flags(m, mi);</sp=
an><br><span>             }</span><br><span>             break;</span><br><=
span> </span><br><span>diff --git a/src/openvpn/multi_io=2Eh b/src/openvpn/=
multi_io=2Eh</span><br><span>index d6734bd=2E=2E4299cba 100644</span><br><s=
pan>--- a/src/openvpn/multi_io=2Eh</span><br><span>+++ b/src/openvpn/multi_=
io=2Eh</span><br><span>@@ -68,8 +68,6 @@</span><br><span> </span><br><span>=
 void multi_io_process_io(struct multi_context *m);</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-void multi_io_set_global_rw=
_flags(struct multi_context *m, struct multi_instance *mi);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void multi_io_actio=
n(struct multi_context *m, struct multi_instance *mi, int action, bool poll=
);</span><br><span> </span><br><span> void multi_io_delete_event(struct mul=
ti_io *multi_io, event_t event);</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2041?usp=3Demail">change 204=
1</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2041?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"disp=
lay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerr=
it-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I60=
3585c6bb4e407d0df62f4233ff2c135aa00db0 </div>
<div style=3D"display:none"> =
Gerrit-Change-Number: 2041 </div>
<div style=3D"display:none"> Gerrit-Patch=
Set: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Gianmarco De Grego=
ri &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@m=
ailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--ynT9VzQ8Dvg=--


--===============0204700192085895847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0204700192085895847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0204700192085895847==--

