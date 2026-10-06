Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB2ECA5FED
	for <openvpn-devel@archiver.kernel.org>; Tue,  6 Oct 2026 12:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z1XjJCrgPcWeApqmFeV1BaL2eHbEyjv0pCTToQzCh08=; b=FE3Ak6TP5agpHwXLr4MdNq3Nyy
	JVMPX9UKMKACHvQGmVpVwYlOUgJ4txdTc5oom3BnJ+amHhsQPWL9aG+CcRcGA7hDGy8tHJSxiUgIB
	F8DfwE4jEEVGKrFTIdODKe0Rw36cijYRbfmWmg0XmhUh7SRMro8xMEMPDLzkKeQL0s6A=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xE4hd-0004DA-NK;
	Tue, 06 Oct 2026 12:55:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xE4hc-0004Cl-EF
 for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 12:55:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ddzmd0dOdhzAmLRe0GyQK7wKBzRvEL6QJstveK15hVU=; b=PHt3t53hpfVxHhi9Zo25hgm5Ey
 Adb+65arPBVWMs+IW6Cnb5yFacanXkNWt0pq+xeAXqRCFN9mjosmWAO5MkPMHnbKTrsesjNc62RGY
 lr1PYJNwWAyQxkN2ehetmtb5noA0enMN9D4WKKTLIg87PAH3coGAdlNZs6k4a85WRokE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ddzmd0dOdhzAmLRe0GyQK7wKBzRvEL6QJstveK15hVU=; b=V
 9cXcD8KeSTQ4YJLmg5iJQYy2Qe2pBTbWIJ6maVJYZmwyHXeI/M1J17ced73IftUnUbZHBggp7hWH8
 EWFAfJtQ3rfPXWLzBh6U2rJ+YSINgyGTRtNfnoy0mXF8uSXvO8hMZjMalzhP4y7t6V0FP0DBfkoaz
 pJOKghFqsS7PxdQQ=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xE4hH-0007k0-EK for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 12:55:08 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so27095975e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 06 Oct 2026 05:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791291301; x=1791896101; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ddzmd0dOdhzAmLRe0GyQK7wKBzRvEL6QJstveK15hVU=;
 b=PNHOOeqK/9ypP+hBku5VkPIb0l+yzhjOuDfwAprBbKB9Ft8XjeMqkDmueXw16uskIN
 nUHZSxzrwz3KACgcu6Ux/YGUa0c+kbVZktJpJPdDpPx/os9xjoyrUcgaycupZ36pbE6x
 yQcpWb5lvj4/+/ubYTRETUKQnZbBNh4oD54UHH+py1mFvHaXHyzxCiZ5+HW15B0Hu77B
 Utn66eKqXyIEQS8LYUbMwKT2ZYqg+H2hZZog+jRIjiI7ELkxC9K9Sb3+PV5u5mdiKXCM
 0p8ctx2NHSfivvPqntbSNpyifJ2zI2CutyYmvCntQqPtNClfU9/EhmEtmVo4SY7kmyJt
 i/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791291301; x=1791896101;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ddzmd0dOdhzAmLRe0GyQK7wKBzRvEL6QJstveK15hVU=;
 b=OlIFaH+0Yztcvolilx60ZCEQXrSaBo7UR7gIWL5i9NtlxA4GdxdPSGWRFk9xChoCfC
 jMaW1gWWt/rE8dZq1uU0CNIT6LN+PrHs/WVNToldsEs2FONSDmph9py95VwyYNcCIZTZ
 EQCljv3C0T4MXntwSGo3NgRUeuoqGwT+WO835B06VsnBMZu+cb2ykl87+FGzcMYyfcj4
 BZQcgNGRt3FLbhzREitMU2QIZFkJJdZ8zZ8OED1uLa4ySs+0mWpVvwIes0skMWQ+xP8A
 7gxnpYbIcrVyYvy18J7w1lU1eVeN0yNHJfxbStALJ01FLf0oQ6CWURqGVIZWsUhJtK1a
 V6Tw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw7O9glb4kZRGoXU9ME2y8coscZQuCRKE2rDS5ACoqkW0d73pw/pKtwY3S4JFA0HrX0irjJWwaeUybOvdAI@lists.sourceforge.net
X-Gm-Message-State: AFuF++mintlnNNNxETnf1AxZQFi61h4haiUjZPkOk4q9wa5N36VQOcoh
 tnWZWYEufDRjXi+yCmOzokRO5LgjSvFX4pdSogdvDCawswioZIXN10PuOdgJbQtf2Dm01S1thaB
 0y7SksrDJOXRdlNNdu9wI0bTSmZUPSAvKx2Eg+QVuiFJKE5Nil0qka+79GLzQXqj4pzZv
X-Gm-Gg: AYBFou1ObL78+Qq2Bc3qVKNWCzPx4WVUdQEMVDViOkR+lt97cBhj4Q82gIzDFM+dGbB
 5OTKCw7CN9HnvW7D8Q+QdsGfYvzQfo+6S2UPJ++JW3Gu98s0MRjKi9iBhvorJ/KM/WSbJHhZ+iF
 axw7qRuoaxaGCS8XcEVmiCb7FS6o9N1FwN045XabsFoQx5KdtutYdFuiP4zRDa1WDspsx13iFQl
 uTRHIpS+GdDrPAxLvJrzMvTmNwKIJ9RIDiJQzRpe/b2tfanYJOxrcmp84ua0hNJgqp4+Y5FFrFn
 ezms2X/58iUqj+6948aCBGy4hl8hK8qQueFp75+wEY1L8cun/rj7qt7xSQshQYqZQRRfR883tiP
 GNrV1/Elm2C3WqalmaVKW2OZ18IWH7PmXB8BaCF4K3uo0X+aIU4g9KSOx9rnnLS4+nC0r8tM/VQ
 NUNgmao23dydpl3T6FIeuLqQXiYdl4lIGqdtfwAdTVIGP5JkcJz2ebUagu8fF5WX/fBkCZLcMkL
 Q0RE+u1mb8fFs2UNm9CSCSvjIIKGUvYEc1mAsgAMiBrdd6CBlTqfhUbuovha6aqpepymj9YDizx
 T8YGV2zsie6XqzAoAlfGYmMfE494LTQkuOyH3ss5HXyrDyg4nCQyhFeyg0zr
X-Received: by 2002:a05:600c:c48e:b0:4a1:6843:eabb with SMTP id
 5b1f17b1804b1-4a17b4fae63mr21747325e9.1.1791291300669; 
 Tue, 06 Oct 2026 05:55:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03950375dsm169648535e9.1.2026.10.06.05.55.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 05:55:00 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 6 Oct 2026 12:54:59 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I165c632da6a837d0cca55bee4c2cc390b91d1e54
X-Gerrit-Change-Number: 1962
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1962?usp=email>
X-Gerrit-Commit: bf2d472c88654f859d806a9341e3ac9eba8caba6
In-Reply-To: <gerrit.1790611935000.I165c632da6a837d0cca55bee4c2cc390b91d1e54@gerrit.openvpn.net>
References: <gerrit.1790611935000.I165c632da6a837d0cca55bee4c2cc390b91d1e54@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjExOTM1MDAwLkkxNjVjNjMyZGE2YTgzN2QwY2NhNTViZWU0YzJjYzM5MGI5MWQxZTU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <671524c54c15c75c26b0adee01e241fbe5b2c794-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xE4hH-0007k0-EK
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8627787132843585781=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8627787132843585781==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="B1gSg62z/cA="; charset=UTF-8

--B1gSg62z/cA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1962?usp=3Demail )

Change subject: multi_io: drop IOW_MBUF
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi_io: drop I=
OW_MBUF

Before the UDP and TCP server loops were merged, each drained the
=
bcast/mcast/client-to-client queue its own way: UDP armed EVENT_WRITE
throu=
gh IOW_MBUF, TCP used the flush loop at the end of
multi_io_process_io()=2E=
  The merge kept both, leaving two consumers with
different disciplines=2E
=

The queue mixes instances of both protocols and neither consumer gets to
p=
ick: mbuf_peek() and multi_get_queue() hand back whatever sits at the
head=
=2E  The TCP side is prepared for that, testing proto_is_dgram() and
tcp_li=
nk_out_deferred before writing=2E  The UDP side is not: it writes
straight =
to the instance's own socket, so a TCP instance reaching it
skips the defer=
red queue that carries backpressure=2E

Drain the queue from the flush loop=
 alone and drop the UDP consumer=2E
IOW_MBUF only existed to arm the socket=
 for it, so it goes as well=2E

This leaves the queue drained from one even=
t-driven point: the timeout
branch of tunnel_server_loop() does not reach t=
he flush loop, so what
multi_io_action(TA_TIMEOUT) manages to queue there w=
aits for the next
pass that has events=2E  Acting on the queue only when th=
ere is an event
to act on is the simpler rule, and the delay is bounded by =
the next
event=2E

Change-Id: I165c632da6a837d0cca55bee4c2cc390b91d1e54
Sig=
ned-off-by: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Acked-by: Razv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1962
Message-Id: <20261005132023=2E27464-1-gert@greenie=2Em=
uc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esource=
forge=2Enet/msg39712=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpn/forward=2Ec
M src/openvpn/forward=2Eh
M src/openvp=
n/mudp=2Ec
M src/openvpn/multi_io=2Ec
4 files changed, 3 insertions(+), 17 =
deletions(-)




diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=
=2Ec
index 1604224=2E=2Eb97fb7a 100644
--- a/src/openvpn/forward=2Ec
+++ b/=
src/openvpn/forward=2Ec
@@ -2122,14 +2122,6 @@
     }
 
     /*
-     * out=
going bcast buffer waiting to be sent?
-     */
-    if (flags & IOW_MBUF)
=
-    {
-        socket |=3D EVENT_WRITE;
-    }
-
-    /*
      * Force wai=
t on TUN input, even if also waiting on TCP/UDP output
      */
     if (fl=
ags & IOW_READ_TUN_FORCE)
diff --git a/src/openvpn/forward=2Eh b/src/openvp=
n/forward=2Eh
index 324c0b4=2E=2E0309725 100644
--- a/src/openvpn/forward=
=2Eh
+++ b/src/openvpn/forward=2Eh
@@ -58,7 +58,6 @@
 #define IOW_SHAPER   =
      (1 << 4)
 #define IOW_CHECK_RESIDUAL (1 << 5)
 #define IOW_FRAG      =
     (1 << 6)
-#define IOW_MBUF           (1 << 7)
 #define IOW_READ_TUN_FO=
RCE (1 << 8)
 #define IOW_WAIT_SIGNAL    (1 << 9)
 
diff --git a/src/openvp=
n/mudp=2Ec b/src/openvpn/mudp=2Ec
index 2b08ada=2E=2E94e03d6 100644
--- a/s=
rc/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -451,10 +451,9 @@
 static=
 inline void
 multi_process_outgoing_link(struct multi_context *m, const un=
signed int mpp_flags)
 {
-    struct multi_instance *mi =3D multi_process_o=
utgoing_link_pre(m);
-    if (mi)
+    if (m->pending)
     {
-        mult=
i_process_outgoing_link_dowork(m, mi, mpp_flags);
+        multi_process_ou=
tgoing_link_dowork(m, m->pending, mpp_flags);
     }
 }
 
diff --git a/src/=
openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec
index 51c7d31=2E=2E348e424 =
100644
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -17=
7,10 +177,6 @@
             flags |=3D IOW_TO_LINK;
         }
     }
-    =
else if (mbuf_defined(m->mbuf))
-    {
-        flags |=3D IOW_MBUF;
-    }=

     else
     {
         flags |=3D IOW_READ;
@@ -565,7 +561,7 @@
     mu=
lti_io->n_esr =3D 0;
 
     /*
-     * Process queued mbuf packets destined=
 for TCP socket
+     * Drain the queued mbuf packets, datagram and TCP ins=
tances alike
      */
     {
         struct multi_instance *mi;

-- 
To vi=
ew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: I165c632da6a837d0cca55bee4c2cc=
390b91d1e54
Gerrit-Change-Number: 1962
Gerrit-PatchSet: 3
Gerrit-Owner: Gia=
nmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvan=
c@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>

--B1gSg62z/cA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1962?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">multi_io: drop IOW_MBUF<br><br>Bef=
ore the UDP and TCP server loops were merged, each drained the<br>bcast/mca=
st/client-to-client queue its own way: UDP armed EVENT_WRITE<br>through IOW=
_MBUF, TCP used the flush loop at the end of<br>multi_io_process_io()=2E  T=
he merge kept both, leaving two consumers with<br>different disciplines=2E<=
br><br>The queue mixes instances of both protocols and neither consumer get=
s to<br>pick: mbuf_peek() and multi_get_queue() hand back whatever sits at =
the<br>head=2E  The TCP side is prepared for that, testing proto_is_dgram()=
 and<br>tcp_link_out_deferred before writing=2E  The UDP side is not: it wr=
ites<br>straight to the instance&#39;s own socket, so a TCP instance reachi=
ng it<br>skips the deferred queue that carries backpressure=2E<br><br>Drain=
 the queue from the flush loop alone and drop the UDP consumer=2E<br>IOW_MB=
UF only existed to arm the socket for it, so it goes as well=2E<br><br>This=
 leaves the queue drained from one event-driven point: the timeout<br>branc=
h of tunnel_server_loop() does not reach the flush loop, so what<br>multi_i=
o_action(TA_TIMEOUT) manages to queue there waits for the next<br>pass that=
 has events=2E  Acting on the queue only when there is an event<br>to act o=
n is the simpler rule, and the delay is bounded by the next<br>event=2E<br>=
<br>Change-Id: I165c632da6a837d0cca55bee4c2cc390b91d1e54<br>Signed-off-by: =
Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<br>Acked-by: Razvan =
Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1962<br>Message-Id: &lt;20261005132023=2E27464-1-gert=
@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-de=
vel@lists=2Esourceforge=2Enet/msg39712=2Ehtml<br>Signed-off-by: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/forward=2Ec<br>M =
src/openvpn/forward=2Eh<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/multi_io=
=2Ec<br>4 files changed, 3 insertions(+), 17 deletions(-)<br><br></pre>
<pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><s=
pan>index 1604224=2E=2Eb97fb7a 100644</span><br><span>--- a/src/openvpn/for=
ward=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -=
2122,14 +2122,6 @@</span><br><span>     }</span><br><span> </span><br><span=
>     /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * outgoi=
ng bcast buffer waiting to be sent?</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (flags &amp; IOW_MBUF)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
socket |=3D EVENT_WRITE;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    /*</span><br><span>      * For=
ce wait on TUN input, even if also waiting on TCP/UDP output</span><br><spa=
n>      */</span><br><span>     if (flags &amp; IOW_READ_TUN_FORCE)</span><=
br><span>diff --git a/src/openvpn/forward=2Eh b/src/openvpn/forward=2Eh</sp=
an><br><span>index 324c0b4=2E=2E0309725 100644</span><br><span>--- a/src/op=
envpn/forward=2Eh</span><br><span>+++ b/src/openvpn/forward=2Eh</span><br><=
span>@@ -58,7 +58,6 @@</span><br><span> #define IOW_SHAPER         (1 &lt;&=
lt; 4)</span><br><span> #define IOW_CHECK_RESIDUAL (1 &lt;&lt; 5)</span><br=
><span> #define IOW_FRAG           (1 &lt;&lt; 6)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define IOW_MBUF           (1 &lt;&lt; 7)</span=
><br><span> #define IOW_READ_TUN_FORCE (1 &lt;&lt; 8)</span><br><span> #def=
ine IOW_WAIT_SIGNAL    (1 &lt;&lt; 9)</span><br><span> </span><br><span>dif=
f --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index=
 2b08ada=2E=2E94e03d6 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</sp=
an><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -451,10 +451,9 @=
@</span><br><span> static inline void</span><br><span> multi_process_outgoi=
ng_link(struct multi_context *m, const unsigned int mpp_flags)</span><br><s=
pan> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct mult=
i_instance *mi =3D multi_process_outgoing_link_pre(m);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (mi)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (m-&gt;pending)</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        multi_process_outg=
oing_link_dowork(m, mi, mpp_flags);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        multi_process_outgoing_link_dowork(m, m-&gt;pending=
, mpp_flags);</span><br><span>     }</span><br><span> }</span><br><span> </=
span><br><span>diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=
=2Ec</span><br><span>index 51c7d31=2E=2E348e424 100644</span><br><span>--- =
a/src/openvpn/multi_io=2Ec</span><br><span>+++ b/src/openvpn/multi_io=2Ec</=
span><br><span>@@ -177,10 +177,6 @@</span><br><span>             flags |=3D=
 IOW_TO_LINK;</span><br><span>         }</span><br><span>     }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    else if (mbuf_defined(m-&gt;m=
buf))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        flags |=3D IOW_MBUF;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span>   =
  else</span><br><span>     {</span><br><span>         flags |=3D IOW_READ;=
</span><br><span>@@ -565,7 +561,7 @@</span><br><span>     multi_io-&gt;n_es=
r =3D 0;</span><br><span> </span><br><span>     /*</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-     * Process queued mbuf packets destined fo=
r TCP socket</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
Drain the queued mbuf packets, datagram and TCP instances alike</span><br><=
span>      */</span><br><span>     {</span><br><span>         struct multi_=
instance *mi;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1962?usp=3Demail">change 1962</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-=
Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master =
</div>
<div style=3D"display:none"> Gerrit-Change-Id: I165c632da6a837d0cca5=
5bee4c2cc390b91d1e54 </div>
<div style=3D"display:none"> Gerrit-Change-Numb=
er: 1962 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div=
 style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@m=
andelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--B1gSg62z/cA=--


--===============8627787132843585781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8627787132843585781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8627787132843585781==--

