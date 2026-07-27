Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0E5C531D0
	for <openvpn-devel@archiver.kernel.org>; Mon, 27 Jul 2026 12:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4kCJd38gV/mPu+uWfHtfSGlytuyHXgOApmzY4iUvzH8=; b=Gd1LaBAPuC8pIXizXFGDDk2DUx
	uuqwrwB0sOeboSpeZoCcwMkUz557nkpuiDcflVNhl4DYKmDCIpcER42orcAhnERLwJNH0erQy3MZC
	t8tIn+SINMVSnSjhk63iM1/cnv3rwF4bun0ZpvQzP4aKd7NA7OkbPnLRMRasBErcnP7g=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woKL7-0003V9-OA;
	Mon, 27 Jul 2026 12:21:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1woKL6-0003V3-Rf
 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 12:21:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=6BLLdVnNULpwxpntadhiIVq1mevB7+wzy2bQjIhDEBg=; b=W+Btke9YYORc7yQ1Z4O7dNFOAC
 uVlzfRwaRd24Bwvh0UyJmDhL0AOggbCqOCIBQPBLzVaGEOVVUpAqp2qbT5TovDkqzcHdBtfRIwlQH
 I0rkejynTDWFfasRuI9a8diu1/6CJUkOtuPqyB1gd/9646xSBf67uj6xZl8W5TL+t56Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6BLLdVnNULpwxpntadhiIVq1mevB7+wzy2bQjIhDEBg=; b=l
 NXepmhSzqvB2dQzkftm82UMfPu4w2gkf8sFZBNrWrjUC39KahJ50x6o4suSk+9KCLLNS0xBFOqwj9
 vq5ubqyaHg8sHN1U+/KA1a2kjOptwbRVsw7UXRXFn4Ui64LmNNRKryG3Yhv4AFIz6rOpwYwrfqZzv
 hbYYgoNpNWM79ows=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1woKL5-0004ig-8E for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 12:21:49 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4954df200ddso17004855e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 27 Jul 2026 05:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785154901; x=1785759701; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6BLLdVnNULpwxpntadhiIVq1mevB7+wzy2bQjIhDEBg=;
 b=AGOohEHdnhWNJZT5EnAtfOta8ufAAPFjh88sDf4MCG6Qgxmze7Cq5czhX9hk9CjozT
 uTMYj8Th5DLvmAmAKj66kCY8Lt2Ey/UNuzcUtRBFg5rJIs1tG9ORkZ0QqAYSzTz0b5pW
 R/tgnjcMfEmSqtlvdjFcaFfJiVpP5cFNAmorf0VklcFgRRc92OXzSFSFYLAUWDfIfC4l
 AprCpl0rbk0NxXjDylD3Z1A5gpKIcs9xC406Jv4CbpFYMgH6udkUXWmvH6tpYwKFk+he
 O/iggWe0PDBOGY+7FdLp+9YIomy2MuXn5vGPzDljzqLgw9ht9H/P6Zxc4nvXGPHRvUVd
 g0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785154901; x=1785759701;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6BLLdVnNULpwxpntadhiIVq1mevB7+wzy2bQjIhDEBg=;
 b=VadSTcxUA1+4k6mY1MMHPG6I/B8WwjlzRbFxV2sJrlg+GsV0cW6lK6T4DF7X6yJ2Sr
 DCsvz/EpgaaszmyYdKypVvbtG/pOhcxmi6tpfvaSZyzG7wujct4vDDHJIBTp5A1Cscea
 fWZOgJoygByGV642+aazT66t/+SCeVABWoBN4/XKI71GMhcAiPe5zopsJD6SUQgwtNVk
 M+za2CMX1KRCQ0ZEuh3+8SrufvslJ8LSiUwnIkJU4nccwdv3ghfgI1hdxv128s1YJpfi
 KdwLIahHkOh0HV+hulTa7lqGK8O/4gUwJgO7VI2i5ODohaRgbC2glDw3OAdZEGYtgBxw
 L2gA==
X-Gm-Message-State: AOJu0Yw6fve7SQkqAe5BUcdLJOPImRuwj+BzrzRfY6+I57WDtUCDU6EO
 FFSZihDg5+pC1qgsWlkx5x0w9u/2ZKeW6GHj7/pvWU/C3HvICQSA69z2dyUjtt30fPD1gjzea/G
 9AFV/AjfSSLxgOSsywWhGZttY/frnmpacBrbWv7Et2nCIoEXM/7kqt75P4ouPFc9k+OkY
X-Gm-Gg: AR+sD12szEZZfQXwSrqCjUr43qVvLRnl2oHV9NVjcCYiH3VWjIJaDWEYYU6dkWsUg5E
 QHBf7vD/mHfuryXBzWW8haSGVES1WLawT3T4dzoECVuePrwAHjBLGURBosccEOTZDFwtgquB/U/
 ysBNCaO0ZED7KyTJF72xaK2iMippF8J4EgRGvWLDisJSVuGt2Z5j4uTWbCfaOtBx7updA0e+ddL
 Y+gLdG54dkzBN6d+6IIj9Uv/5jnCTKd7OJb06L+kAO2VRZNVoXYrhuLU2YguZGh/5Taswc9zB64
 uaWsVeEufB33MnbJf0M5OLnkmyeP4y+0+2Lx+IF6kmFxRLzf56xd+lLldsZvGSEtpsmZROghR9f
 AOGRteD+/aS7v35WRmpqzVG1Sut2DXv+aO04qhrINSj99MCghk+HeRKkfFm3OmmD8yyMKLOoSVf
 qX7B89Y9a0dh3bxqeZb917LDq7mBUp1rUe2ptvulRdMFsL0fvw2uyk6ue/b98sW+Zcs9Y/7PaNg
 ih2MzZuWCvXU31vndocmmEgTcV2cyqDcsDz+2w1zy5iETVyIa/mVjTAZ/Y7BGiAD+6yySFpWdBR
 iuo=
X-Received: by 2002:a05:600c:4454:b0:493:e974:41ac with SMTP id
 5b1f17b1804b1-496b56fa48amr96637675e9.16.1785154900416; 
 Mon, 27 Jul 2026 05:21:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957bff4784sm233911845e9.4.2026.07.27.05.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 05:21:39 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 27 Jul 2026 12:21:36 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Iabe1992b2608661b862a81363574e957d18395f0
X-Gerrit-Change-Number: 1554
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1554?usp=email>
X-Gerrit-Commit: 74c2a965d39fea89c2fe392663eb699fb1324611
In-Reply-To: <gerrit.1772554170000.Iabe1992b2608661b862a81363574e957d18395f0@gerrit.openvpn.net>
References: <gerrit.1772554170000.Iabe1992b2608661b862a81363574e957d18395f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzcyNTU0MTcwMDAwLklhYmUxOTkyYjI2MDg2NjFiODYyYTgxMzYzNTc0ZTk1N2QxODM5NWYwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a883dfa654cbf09962de4a52034cb2a77eed96b9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1woKL5-0004ig-8E
Subject: [Openvpn-devel] [M] Change in openvpn[master]: socket: Never use
 negative buf->len in link_socket_read*
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7679535024756797160=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7679535024756797160==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/vGc3pFWNXY="; charset=UTF-8

--/vGc3pFWNXY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1554?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by plaisthos


Change subject: socket: Never use negative buf->len in link_=
socket_read*
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


socket: Never use negative buf->len in link_socket_read*

We really don't=
 want to use negative buf lengths in
our code=2E So remove some places wher=
e we did so before=2E

Change-Id: Iabe1992b2608661b862a81363574e957d18395f0=

Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1554
Message-Id: <20260708152847=2E60245-1-frank@lichten=
held=2Ecom>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esou=
rceforge=2Enet/msg37536=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2E=
muc=2Ede>
---
M src/openvpn/forward=2Ec
M src/openvpn/socket=2Ec
M src/open=
vpn/socket=2Eh
M src/openvpn/tun=2Eh
4 files changed, 84 insertions(+), 69 =
deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/54/1554/5

diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forwar=
d=2Ec
index ab76b9e=2E=2E46e1a53 100644
--- a/src/openvpn/forward=2Ec
+++ b=
/src/openvpn/forward=2Ec
@@ -929,14 +929,12 @@
      * Set up for recvfrom =
call to read datagram
      * sent to our TCP/UDP port=2E
      */
-    int=
 status;
-
     /*ASSERT (!c->c2=2Eto_tun=2Elen);*/
 
     c->c2=2Ebuf =3D =
c->c2=2Ebuffers->read_link_buf;
     ASSERT(buf_init(&c->c2=2Ebuf, c->c2=2E=
frame=2Ebuf=2Eheadroom));
 
-    status =3D link_socket_read(sock, &c->c2=
=2Ebuf, &c->c2=2Efrom);
+    ssize_t status =3D link_socket_read(sock, &c->=
c2=2Ebuf, &c->c2=2Efrom);
 
     if (socket_connection_reset(sock, status))=

     {
@@ -955,14 +953,14 @@
             if (event_timeout_defined(&c->c2=
=2Eexplicit_exit_notification_interval))
             {
                 ms=
g(D_STREAM_ERRORS,
-                    "Connection reset during exit notif=
ication period, ignoring [%d]", status);
+                    "Connection r=
eset during exit notification period, ignoring [%zd]", status);
           =
      management_sleep(1);
             }
             else
             {
=
                 register_signal(c->sig, SIGUSR1,
                         =
        "connection-reset"); /* SOFT-SIGUSR1 -- TCP connection reset */
-  =
              msg(D_STREAM_ERRORS, "Connection reset, restarting [%d]", sta=
tus);
+                msg(D_STREAM_ERRORS, "Connection reset, restarting [=
%zd]", status);
             }
         }
         return;
@@ -1026,7 +1024=
,7 @@
      * Good, non-zero length packet received=2E
      * Commence mul=
ti-stage processing of packet,
      * such as authenticate, decrypt, decom=
press=2E
-     * If any stage fails, it sets buf=2Elen to 0 or -1,
+     * =
If any stage fails, it sets buf=2Elen to 0,
      * telling downstream stag=
es to ignore the packet=2E
      */
     if (c->c2=2Ebuf=2Elen > 0)
diff --=
git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index b73a5df=2E=2E8b=
cc332 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -=
1102,7 +1102,7 @@
 
 static void stream_buf_close(struct stream_buf *sb);
 =

-static bool stream_buf_added(struct stream_buf *sb, int length_added);
+s=
tatic bool stream_buf_added(struct stream_buf *sb, ssize_t length_added);
 =

 /* For stream protocols, allocate a buffer to build up packet=2E
  * Call=
ed after frame has been finalized=2E */
@@ -1775,6 +1775,10 @@
     }
 }
 
=
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#=
endif
+
 void
 link_socket_close(struct link_socket *sock)
 {
@@ -2142,12 +=
2146,13 @@
  * @return true if \c sb->buf contains fully reassembled packet=

  */
 static bool
-stream_buf_added(struct stream_buf *sb, int length_adde=
d)
+stream_buf_added(struct stream_buf *sb, ssize_t length_added)
 {
-    d=
msg(D_STREAM_DEBUG, "STREAM: ADD length_added=3D%d", length_added);
+    dm=
sg(D_STREAM_DEBUG, "STREAM: ADD length_added=3D%zd", length_added);
     if=
 (length_added > 0)
     {
-        sb->buf=2Elen +=3D length_added;
+     =
   ASSERT(sb->buf=2Elen + length_added <=3D INT_MAX);
+        sb->buf=2Ele=
n +=3D (int)length_added;
     }
 
     /* if length unknown, see if we can=
 get the length prefix from
@@ -2249,10 +2254,10 @@
  * Socket Read Routine=
s
  */
 
-int
+ssize_t
 link_socket_read_tcp(struct link_socket *sock, stru=
ct buffer *buf)
 {
-    int len =3D 0;
+    ssize_t len =3D 0;
 
     if (!=
sock->stream_buf=2Eresidual_fully_formed)
     {
@@ -2282,7 +2287,8 @@
    =
     }
         if (len <=3D 0)
         {
-            return buf->len =3D=
 len;
+            buf->len =3D 0;
+            return len;
         }
    =
 }
 
@@ -2314,14 +2320,14 @@
     max_int(CMSG_SPACE(sizeof(struct in6_pkti=
nfo)), CMSG_SPACE(sizeof(struct in_addr)))
 #endif
 
-static socklen_t
+sta=
tic ssize_t
 link_socket_read_udp_posix_recvmsg(struct link_socket *sock, s=
truct buffer *buf,
-                                   struct link_socket_a=
ctual *from)
+                                   struct link_socket_actual =
*from, socklen_t *fromlen)
 {
     struct iovec iov;
     uint8_t pktinfo_b=
uf[PKTINFO_BUF_SIZE];
     struct msghdr mesg =3D { 0 };
-    socklen_t fro=
mlen =3D sizeof(from->dest=2Eaddr);
+    *fromlen =3D sizeof(from->dest=2Ea=
ddr);
 
     ASSERT(sock->sd >=3D 0); /* can't happen */
 
@@ -2330,62 +233=
6,67 @@
     mesg=2Emsg_iov =3D &iov;
     mesg=2Emsg_iovlen =3D 1;
     me=
sg=2Emsg_name =3D &from->dest=2Eaddr;
-    mesg=2Emsg_namelen =3D fromlen;
=
+    mesg=2Emsg_namelen =3D *fromlen;
     mesg=2Emsg_control =3D pktinfo_b=
uf;
-    mesg=2Emsg_controllen =3D sizeof pktinfo_buf;
-    buf->len =3D re=
cvmsg(sock->sd, &mesg, 0);
-    if (buf->len >=3D 0)
+    mesg=2Emsg_contro=
llen =3D (socklen_t)sizeof(pktinfo_buf);
+    ssize_t len =3D recvmsg(sock-=
>sd, &mesg, 0);
+    if (len < 0)
     {
-        struct cmsghdr *cmsg;
-  =
      fromlen =3D mesg=2Emsg_namelen;
-        cmsg =3D CMSG_FIRSTHDR(&mesg=
);
-        if (cmsg !=3D NULL && CMSG_NXTHDR(&mesg, cmsg) =3D=3D NULL
+   =
     buf->len =3D 0;
+        return len;
+    }
+    ASSERT(len <=3D INT_M=
AX);
+    buf->len =3D (int)len;
+    struct cmsghdr *cmsg;
+    *fromlen =
=3D mesg=2Emsg_namelen;
+    cmsg =3D CMSG_FIRSTHDR(&mesg);
+    if (cmsg !=
=3D NULL && CMSG_NXTHDR(&mesg, cmsg) =3D=3D NULL
 #if defined(HAVE_IN_PKTIN=
FO) && defined(HAVE_IPI_SPEC_DST)
-            && cmsg->cmsg_level =3D=3D S=
OL_IP && cmsg->cmsg_type =3D=3D IP_PKTINFO
-            && cmsg->cmsg_len >=
=3D CMSG_LEN(sizeof(struct in_pktinfo)))
+        && cmsg->cmsg_level =3D=
=3D SOL_IP && cmsg->cmsg_type =3D=3D IP_PKTINFO
+        && cmsg->cmsg_len =
>=3D CMSG_LEN(sizeof(struct in_pktinfo)))
 #elif defined(IP_RECVDSTADDR)
- =
           && cmsg->cmsg_level =3D=3D IPPROTO_IP && cmsg->cmsg_type =3D=3D =
IP_RECVDSTADDR
-            && cmsg->cmsg_len >=3D CMSG_LEN(sizeof(struct i=
n_addr)))
+        && cmsg->cmsg_level =3D=3D IPPROTO_IP && cmsg->cmsg_type=
 =3D=3D IP_RECVDSTADDR
+        && cmsg->cmsg_len >=3D CMSG_LEN(sizeof(stru=
ct in_addr)))
 #else /* if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPE=
C_DST) */
 #error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDS=
TADDR (fix syshead=2Eh)
 #endif
-        {
+    {
 #if defined(HAVE_IN_PKTI=
NFO) && defined(HAVE_IPI_SPEC_DST)
-            struct in_pktinfo *pkti =3D=
 (struct in_pktinfo *)CMSG_DATA(cmsg);
-            from->pi=2Ein4=2Eipi_if=
index =3D
-                (sock->sockflags & SF_PKTINFO_COPY_IIF) ? pkti->=
ipi_ifindex : 0;
-            from->pi=2Ein4=2Eipi_spec_dst =3D pkti->ipi_s=
pec_dst;
+        struct in_pktinfo *pkti =3D (struct in_pktinfo *)CMSG_DAT=
A(cmsg);
+        from->pi=2Ein4=2Eipi_ifindex =3D
+            (sock->sock=
flags & SF_PKTINFO_COPY_IIF) ? pkti->ipi_ifindex : 0;
+        from->pi=2Ei=
n4=2Eipi_spec_dst =3D pkti->ipi_spec_dst;
 #elif defined(IP_RECVDSTADDR)
- =
           from->pi=2Ein4 =3D *(struct in_addr *)CMSG_DATA(cmsg);
+        =
from->pi=2Ein4 =3D *(struct in_addr *)CMSG_DATA(cmsg);
 #else /* if defined=
(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST) */
 #error ENABLE_IP_PKTINF=
O is set without IP_PKTINFO xor IP_RECVDSTADDR (fix syshead=2Eh)
 #endif
- =
       }
-        else if (cmsg !=3D NULL && CMSG_NXTHDR(&mesg, cmsg) =3D=
=3D NULL
-                 && cmsg->cmsg_level =3D=3D IPPROTO_IPV6 && cmsg-=
>cmsg_type =3D=3D IPV6_PKTINFO
-                 && cmsg->cmsg_len >=3D CMS=
G_LEN(sizeof(struct in6_pktinfo)))
-        {
-            struct in6_pktin=
fo *pkti6 =3D (struct in6_pktinfo *)CMSG_DATA(cmsg);
-            from->pi=
=2Ein6=2Eipi6_ifindex =3D
-                (sock->sockflags & SF_PKTINFO_CO=
PY_IIF) ? pkti6->ipi6_ifindex : 0;
-            from->pi=2Ein6=2Eipi6_addr =
=3D pkti6->ipi6_addr;
-        }
-        else if (cmsg !=3D NULL)
-       =
 {
-            msg(M_WARN,
-                "CMSG received that cannot be =
parsed (cmsg_level=3D%d, cmsg_type=3D%d, cmsg=3Dlen=3D%d)",
-              =
  (int)cmsg->cmsg_level, (int)cmsg->cmsg_type, (int)cmsg->cmsg_len);
-     =
   }
+    }
+    else if (cmsg !=3D NULL && CMSG_NXTHDR(&mesg, cmsg) =3D=3D=
 NULL
+             && cmsg->cmsg_level =3D=3D IPPROTO_IPV6 && cmsg->cmsg_t=
ype =3D=3D IPV6_PKTINFO
+             && cmsg->cmsg_len >=3D CMSG_LEN(sizeo=
f(struct in6_pktinfo)))
+    {
+        struct in6_pktinfo *pkti6 =3D (stru=
ct in6_pktinfo *)CMSG_DATA(cmsg);
+        from->pi=2Ein6=2Eipi6_ifindex =
=3D
+            (sock->sockflags & SF_PKTINFO_COPY_IIF) ? pkti6->ipi6_ifin=
dex : 0;
+        from->pi=2Ein6=2Eipi6_addr =3D pkti6->ipi6_addr;
+    }
+=
    else if (cmsg !=3D NULL)
+    {
+        msg(M_WARN,
+            "CMSG=
 received that cannot be parsed (cmsg_level=3D%d, cmsg_type=3D%d, cmsg=3Dle=
n=3D%d)",
+            (int)cmsg->cmsg_level, (int)cmsg->cmsg_type, (int)cm=
sg->cmsg_len);
     }
 
-    return fromlen;
+    return buf->len;
 }
 #end=
if /* if ENABLE_IP_PKTINFO */
 
-int
+ssize_t
 link_socket_read_udp_posix(s=
truct link_socket *sock, struct buffer *buf,
                            st=
ruct link_socket_actual *from)
 {
+    ssize_t recvlen;
     socklen_t from=
len =3D sizeof(from->dest=2Eaddr);
     socklen_t expectedlen =3D af_addr_s=
ize(sock->info=2Eaf);
     addr_zero_host(&from->dest);
@@ -2396,16 +2407,2=
3 @@
     /* Both PROTO_UDPv4 and PROTO_UDPv6 */
     if (sock->info=2Eprot=
o =3D=3D PROTO_UDP && sock->sockflags & SF_USE_IP_PKTINFO)
     {
-        =
fromlen =3D link_socket_read_udp_posix_recvmsg(sock, buf, from);
+        r=
ecvlen =3D link_socket_read_udp_posix_recvmsg(sock, buf, from, &fromlen);
 =
    }
     else
 #endif
     {
-        buf->len =3D recvfrom(sock->sd, BPT=
R(buf), buf_forward_capacity(buf), 0, &from->dest=2Eaddr=2Esa,
-           =
                 &fromlen);
+        recvlen =3D recvfrom(sock->sd, BPTR(bu=
f), buf_forward_capacity(buf), 0,
+                           &from->dest=
=2Eaddr=2Esa, &fromlen);
     }
+    if (recvlen < 0)
+    {
+        buf->=
len =3D 0;
+        return recvlen;
+    }
+    ASSERT(recvlen <=3D INT_MAX=
);
+    buf->len =3D (int)recvlen;
     /* FIXME: won't do anything when so=
ck->info=2Eaf =3D=3D AF_UNSPEC */
-    if (buf->len >=3D 0 && expectedlen &=
& fromlen !=3D expectedlen)
+    if (expectedlen && fromlen !=3D expectedle=
n)
     {
         bad_address_length(fromlen, expectedlen);
     }
@@ -242=
1,7 +2439,9 @@
 ssize_t
 link_socket_write_tcp(struct link_socket *sock, st=
ruct buffer *buf, struct link_socket_actual *to)
 {
-    packet_size_type l=
en =3D (packet_size_type)BLENZ(buf);
+    const int blen =3D BLEN(buf);
+  =
  ASSERT(blen >=3D 0 && blen <=3D PACKET_SIZE_MAX);
+    packet_size_type l=
en =3D (packet_size_type)blen;
     dmsg(D_STREAM_DEBUG, "STREAM: WRITE %u =
offset=3D%d", len, buf->offset);
     ASSERT(len <=3D sock->stream_buf=2Ema=
xlen);
     len =3D htonps(len);
@@ -2433,10 +2453,6 @@
 #endif
 }
 
-#if d=
efined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
=
-
 #if ENABLE_IP_PKTINFO
 
 ssize_t
diff --git a/src/openvpn/socket=2Eh b/s=
rc/openvpn/socket=2Eh
index 5883592=2E=2Eb490610 100644
--- a/src/openvpn/s=
ocket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -54,6 +54,7 @@
  */
 
 typedef ui=
nt16_t packet_size_type;
+#define PACKET_SIZE_MAX UINT16_MAX
 
 /* convert =
a packet_size_type from host to network order */
 #define htonps(x) htons(x=
)
@@ -457,7 +458,7 @@
 #endif /* if PORT_SHARE */
 
 static inline bool
-so=
cket_connection_reset(const struct link_socket *sock, int status)
+socket_c=
onnection_reset(const struct link_socket *sock, ssize_t status)
 {
     if =
(link_socket_connection_oriented(sock))
     {
@@ -584,7 +585,7 @@
  * Sock=
et Read Routines
  */
 
-int link_socket_read_tcp(struct link_socket *sock,=
 struct buffer *buf);
+ssize_t link_socket_read_tcp(struct link_socket *soc=
k, struct buffer *buf);
 
 #ifdef _WIN32
 
@@ -604,20 +605,20 @@
 
 #else  =
/* ifdef _WIN32 */
 
-int link_socket_read_udp_posix(struct link_socket *so=
ck, struct buffer *buf,
-                               struct link_socket_=
actual *from);
+ssize_t link_socket_read_udp_posix(struct link_socket *sock=
, struct buffer *buf,
+                                   struct link_socke=
t_actual *from);
 
 #endif /* ifdef _WIN32 */
 
 /* read a TCP or UDP packe=
t from link */
-static inline int
+static inline ssize_t
 link_socket_read(=
struct link_socket *sock, struct buffer *buf, struct link_socket_actual *fr=
om)
 {
     if (proto_is_udp(sock->info=2Eproto) || socket_is_dco_win(sock)=
)
     /* unified UDPv4 and UDPv6, for DCO-WIN the kernel
      * will stri=
p the length header */
     {
-        int res;
+        ssize_t res;
 
 #i=
fdef _WIN32
         res =3D link_socket_read_udp_win32(sock, buf, from);
d=
iff --git a/src/openvpn/tun=2Eh b/src/openvpn/tun=2Eh
index 6a7af85=2E=2E93=
1e54d 100644
--- a/src/openvpn/tun=2Eh
+++ b/src/openvpn/tun=2Eh
@@ -535,7 =
+535,7 @@
 }
 
 static inline bool
-tuntap_is_dco_win_timeout(struct tuntap=
 *tt, int status)
+tuntap_is_dco_win_timeout(struct tuntap *tt, ssize_t sta=
tus)
 {
     return tuntap_is_dco_win(tt) && (status < 0) && (openvpn_errno=
() =3D=3D ERROR_NETNAME_DELETED);
 }
@@ -573,7 +573,7 @@
 }
 
 static inlin=
e bool
-tuntap_is_dco_win_timeout(struct tuntap *tt, int status)
+tuntap_is=
_dco_win_timeout(struct tuntap *tt, ssize_t status)
 {
     return false;
 =
}

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1554?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iabe1992b260866=
1b862a81363574e957d18395f0
Gerrit-Change-Number: 1554
Gerrit-PatchSet: 5
Ge=
rrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>

--/vGc3pFWNXY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #5</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1554?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">socket: Never use nega=
tive buf-&gt;len in link_socket_read*<br><br>We really don&#39;t want to us=
e negative buf lengths in<br>our code=2E So remove some places where we did=
 so before=2E<br><br>Change-Id: Iabe1992b2608661b862a81363574e957d18395f0<b=
r>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked=
-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1554<br>Message-Id: &lt;20260708152847=
=2E60245-1-frank@lichtenheld=2Ecom&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37536=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/=
forward=2Ec<br>M src/openvpn/socket=2Ec<br>M src/openvpn/socket=2Eh<br>M sr=
c/openvpn/tun=2Eh<br>4 files changed, 84 insertions(+), 69 deletions(-)<br>=
<br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/54/1554/5</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/forward=2Ec b/src/=
openvpn/forward=2Ec</span><br><span>index ab76b9e=2E=2E46e1a53 100644</span=
><br><span>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/=
forward=2Ec</span><br><span>@@ -929,14 +929,12 @@</span><br><span>      * S=
et up for recvfrom call to read datagram</span><br><span>      * sent to ou=
r TCP/UDP port=2E</span><br><span>      */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    int status;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span>     /*ASSERT (!c-&gt;c2=2Eto_tun=2Elen);*/=
</span><br><span> </span><br><span>     c-&gt;c2=2Ebuf =3D c-&gt;c2=2Ebuffe=
rs-&gt;read_link_buf;</span><br><span>     ASSERT(buf_init(&amp;c-&gt;c2=2E=
buf, c-&gt;c2=2Eframe=2Ebuf=2Eheadroom));</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    status =3D link_socket_read(sock,=
 &amp;c-&gt;c2=2Ebuf, &amp;c-&gt;c2=2Efrom);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    ssize_t status =3D link_socket_read(sock, &amp=
;c-&gt;c2=2Ebuf, &amp;c-&gt;c2=2Efrom);</span><br><span> </span><br><span> =
    if (socket_connection_reset(sock, status))</span><br><span>     {</span=
><br><span>@@ -955,14 +953,14 @@</span><br><span>             if (event_tim=
eout_defined(&amp;c-&gt;c2=2Eexplicit_exit_notification_interval))</span><b=
r><span>             {</span><br><span>                 msg(D_STREAM_ERRORS=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
&quot;Connection reset during exit notification period, ignoring [%d]&quot;=
, status);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           &quot;Connection reset during exit notification period, ignoring=
 [%zd]&quot;, status);</span><br><span>                 management_sleep(1)=
;</span><br><span>             }</span><br><span>             else</span><b=
r><span>             {</span><br><span>                 register_signal(c-&=
gt;sig, SIGUSR1,</span><br><span>                                 &quot;con=
nection-reset&quot;); /* SOFT-SIGUSR1 -- TCP connection reset */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                msg(D_STREAM_ERR=
ORS, &quot;Connection reset, restarting [%d]&quot;, status);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                msg(D_STREAM_ERROR=
S, &quot;Connection reset, restarting [%zd]&quot;, status);</span><br><span=
>             }</span><br><span>         }</span><br><span>         return;=
</span><br><span>@@ -1026,7 +1024,7 @@</span><br><span>      * Good, non-ze=
ro length packet received=2E</span><br><span>      * Commence multi-stage p=
rocessing of packet,</span><br><span>      * such as authenticate, decrypt,=
 decompress=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * =
If any stage fails, it sets buf=2Elen to 0 or -1,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * If any stage fails, it sets buf=2Elen =
to 0,</span><br><span>      * telling downstream stages to ignore the packe=
t=2E</span><br><span>      */</span><br><span>     if (c-&gt;c2=2Ebuf=2Elen=
 &gt; 0)</span><br><span>diff --git a/src/openvpn/socket=2Ec b/src/openvpn/=
socket=2Ec</span><br><span>index b73a5df=2E=2E8bcc332 100644</span><br><spa=
n>--- a/src/openvpn/socket=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec=
</span><br><span>@@ -1102,7 +1102,7 @@</span><br><span> </span><br><span> s=
tatic void stream_buf_close(struct stream_buf *sb);</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-static bool stream_buf_adde=
d(struct stream_buf *sb, int length_added);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static bool stream_buf_added(struct stream_buf *sb,=
 ssize_t length_added);</span><br><span> </span><br><span> /* For stream pr=
otocols, allocate a buffer to build up packet=2E</span><br><span>  * Called=
 after frame has been finalized=2E */</span><br><span>@@ -1775,6 +1775,10 @=
@</span><br><span>     }</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(=
__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> void</span><br><span> link_socket_close(struct link_socket *sock)</span>=
<br><span> {</span><br><span>@@ -2142,12 +2146,13 @@</span><br><span>  * @r=
eturn true if \c sb-&gt;buf contains fully reassembled packet</span><br><sp=
an>  */</span><br><span> static bool</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-stream_buf_added(struct stream_buf *sb, int length_added)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+stream_buf_added(struc=
t stream_buf *sb, ssize_t length_added)</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_STREAM_DEBUG, &quot;STREAM:=
 ADD length_added=3D%d&quot;, length_added);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    dmsg(D_STREAM_DEBUG, &quot;STREAM: ADD length_=
added=3D%zd&quot;, length_added);</span><br><span>     if (length_added &gt=
; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        sb-&gt;buf=2Elen +=3D length_added;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        ASSERT(sb-&gt;buf=2Elen + length_adde=
d &lt;=3D INT_MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        sb-&gt;buf=2Elen +=3D (int)length_added;</span><br><span>     }</sp=
an><br><span> </span><br><span>     /* if length unknown, see if we can get=
 the length prefix from</span><br><span>@@ -2249,10 +2254,10 @@</span><br><=
span>  * Socket Read Routines</span><br><span>  */</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ssize_t</span><br><span> link_socket_read_tc=
p(struct link_socket *sock, struct buffer *buf)</span><br><span> {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    int len =3D 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    ssize_t len =3D 0;</span><b=
r><span> </span><br><span>     if (!sock-&gt;stream_buf=2Eresidual_fully_fo=
rmed)</span><br><span>     {</span><br><span>@@ -2282,7 +2287,8 @@</span><b=
r><span>         }</span><br><span>         if (len &lt;=3D 0)</span><br><s=
pan>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     return buf-&gt;len =3D len;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            buf-&gt;len =3D 0;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return len;</span><br><span>         }<=
/span><br><span>     }</span><br><span> </span><br><span>@@ -2314,14 +2320,=
14 @@</span><br><span>     max_int(CMSG_SPACE(sizeof(struct in6_pktinfo)), =
CMSG_SPACE(sizeof(struct in_addr)))</span><br><span> #endif</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static socklen_t</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static ssize_t</span><=
br><span> link_socket_read_udp_posix_recvmsg(struct link_socket *sock, stru=
ct buffer *buf,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                             struct link_socket_actual *from)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
  struct link_socket_actual *from, socklen_t *fromlen)</span><br><span> {</=
span><br><span>     struct iovec iov;</span><br><span>     uint8_t pktinfo_=
buf[PKTINFO_BUF_SIZE];</span><br><span>     struct msghdr mesg =3D { 0 };</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    socklen_t fromlen =
=3D sizeof(from-&gt;dest=2Eaddr);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    *fromlen =3D sizeof(from-&gt;dest=2Eaddr);</span><br><spa=
n> </span><br><span>     ASSERT(sock-&gt;sd &gt;=3D 0); /* can&#39;t happen=
 */</span><br><span> </span><br><span>@@ -2330,62 +2336,67 @@</span><br><sp=
an>     mesg=2Emsg_iov =3D &amp;iov;</span><br><span>     mesg=2Emsg_iovlen=
 =3D 1;</span><br><span>     mesg=2Emsg_name =3D &amp;from-&gt;dest=2Eaddr;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mesg=2Emsg_namele=
n =3D fromlen;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
esg=2Emsg_namelen =3D *fromlen;</span><br><span>     mesg=2Emsg_control =3D=
 pktinfo_buf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mesg=
=2Emsg_controllen =3D sizeof pktinfo_buf;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    buf-&gt;len =3D recvmsg(sock-&gt;sd, &amp;mesg, 0);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (buf-&gt;len &=
gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mesg=
=2Emsg_controllen =3D (socklen_t)sizeof(pktinfo_buf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ssize_t len =3D recvmsg(sock-&gt;sd, =
&amp;mesg, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (len &lt; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        struct cmsghdr *cmsg;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        fromlen =3D mesg=2Emsg_namelen;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        cmsg =3D CMSG_FIRSTHDR(&a=
mp;mesg);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (=
cmsg !=3D NULL &amp;&amp; CMSG_NXTHDR(&amp;mesg, cmsg) =3D=3D NULL</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        buf-&gt;len =3D 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return len;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(len &lt;=3D INT_MAX);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf-&gt;len =3D (i=
nt)len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct c=
msghdr *cmsg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *f=
romlen =3D mesg=2Emsg_namelen;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    cmsg =3D CMSG_FIRSTHDR(&amp;mesg);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (cmsg !=3D NULL &amp;&amp; CMSG_NXTHDR=
(&amp;mesg, cmsg) =3D=3D NULL</span><br><span> #if defined(HAVE_IN_PKTINFO)=
 &amp;&amp; defined(HAVE_IPI_SPEC_DST)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            &amp;&amp; cmsg-&gt;cmsg_level =3D=3D SOL_IP &=
amp;&amp; cmsg-&gt;cmsg_type =3D=3D IP_PKTINFO</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            &amp;&amp; cmsg-&gt;cmsg_len &gt;=3D C=
MSG_LEN(sizeof(struct in_pktinfo)))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        &amp;&amp; cmsg-&gt;cmsg_level =3D=3D SOL_IP &amp;&=
amp; cmsg-&gt;cmsg_type =3D=3D IP_PKTINFO</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        &amp;&amp; cmsg-&gt;cmsg_len &gt;=3D CMSG_LEN=
(sizeof(struct in_pktinfo)))</span><br><span> #elif defined(IP_RECVDSTADDR)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp=
; cmsg-&gt;cmsg_level =3D=3D IPPROTO_IP &amp;&amp; cmsg-&gt;cmsg_type =3D=
=3D IP_RECVDSTADDR</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         &amp;&amp; cmsg-&gt;cmsg_len &gt;=3D CMSG_LEN(sizeof(struct in_add=
r)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&a=
mp; cmsg-&gt;cmsg_level =3D=3D IPPROTO_IP &amp;&amp; cmsg-&gt;cmsg_type =3D=
=3D IP_RECVDSTADDR</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       &amp;&amp; cmsg-&gt;cmsg_len &gt;=3D CMSG_LEN(sizeof(struct in_addr)=
))</span><br><span> #else /* if defined(HAVE_IN_PKTINFO) &amp;&amp; defined=
(HAVE_IPI_SPEC_DST) */</span><br><span> #error ENABLE_IP_PKTINFO is set wit=
hout IP_PKTINFO xor IP_RECVDSTADDR (fix syshead=2Eh)</span><br><span> #endi=
f</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span> #if def=
ined(HAVE_IN_PKTINFO) &amp;&amp; defined(HAVE_IPI_SPEC_DST)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            struct in_pktinfo *pkti =
=3D (struct in_pktinfo *)CMSG_DATA(cmsg);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            from-&gt;pi=2Ein4=2Eipi_ifindex =3D</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                (sock-&gt;soc=
kflags &amp; SF_PKTINFO_COPY_IIF) ? pkti-&gt;ipi_ifindex : 0;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            from-&gt;pi=2Ein4=2Eipi=
_spec_dst =3D pkti-&gt;ipi_spec_dst;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        struct in_pktinfo *pkti =3D (struct in_pktinfo *)C=
MSG_DATA(cmsg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    from-&gt;pi=2Ein4=2Eipi_ifindex =3D</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            (sock-&gt;sockflags &amp; SF_PKTINFO_COPY_I=
IF) ? pkti-&gt;ipi_ifindex : 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        from-&gt;pi=2Ein4=2Eipi_spec_dst =3D pkti-&gt;ipi_spec_=
dst;</span><br><span> #elif defined(IP_RECVDSTADDR)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            from-&gt;pi=2Ein4 =3D *(struct =
in_addr *)CMSG_DATA(cmsg);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        from-&gt;pi=2Ein4 =3D *(struct in_addr *)CMSG_DATA(cmsg);</s=
pan><br><span> #else /* if defined(HAVE_IN_PKTINFO) &amp;&amp; defined(HAVE=
_IPI_SPEC_DST) */</span><br><span> #error ENABLE_IP_PKTINFO is set without =
IP_PKTINFO xor IP_RECVDSTADDR (fix syshead=2Eh)</span><br><span> #endif</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        else if (cmsg !=3D NULL &amp;=
&amp; CMSG_NXTHDR(&amp;mesg, cmsg) =3D=3D NULL</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                 &amp;&amp; cmsg-&gt;cmsg_level =
=3D=3D IPPROTO_IPV6 &amp;&amp; cmsg-&gt;cmsg_type =3D=3D IPV6_PKTINFO</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                 &amp;&amp;=
 cmsg-&gt;cmsg_len &gt;=3D CMSG_LEN(sizeof(struct in6_pktinfo)))</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            struct in6_pktinfo *pkti6 =3D (=
struct in6_pktinfo *)CMSG_DATA(cmsg);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            from-&gt;pi=2Ein6=2Eipi6_ifindex =3D</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                (sock-&gt;sockfl=
ags &amp; SF_PKTINFO_COPY_IIF) ? pkti6-&gt;ipi6_ifindex : 0;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            from-&gt;pi=2Ein6=2Eipi6=
_addr =3D pkti6-&gt;ipi6_addr;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     else if (cmsg !=3D NULL)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        msg(M_WARN,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              &quot;CMSG received that cannot be parsed (cmsg_level=3D%d, c=
msg_type=3D%d, cmsg=3Dlen=3D%d)&quot;,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                (int)cmsg-&gt;cmsg_level, (int)cmsg-&gt;cm=
sg_type, (int)cmsg-&gt;cmsg_len);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if =
(cmsg !=3D NULL &amp;&amp; CMSG_NXTHDR(&amp;mesg, cmsg) =3D=3D NULL</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+             &amp;&amp; cms=
g-&gt;cmsg_level =3D=3D IPPROTO_IPV6 &amp;&amp; cmsg-&gt;cmsg_type =3D=3D I=
PV6_PKTINFO</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
     &amp;&amp; cmsg-&gt;cmsg_len &gt;=3D CMSG_LEN(sizeof(struct in6_pktinf=
o)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        struct in6_pktinfo *p=
kti6 =3D (struct in6_pktinfo *)CMSG_DATA(cmsg);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        from-&gt;pi=2Ein6=2Eipi6_ifindex =3D</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            (sock-&gt;=
sockflags &amp; SF_PKTINFO_COPY_IIF) ? pkti6-&gt;ipi6_ifindex : 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        from-&gt;pi=2Ein6=2E=
ipi6_addr =3D pkti6-&gt;ipi6_addr;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    else if (cmsg !=3D NULL)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg(M_WARN,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        &quot;CMSG received that cannot be parsed (cmsg_level=3D%d, cmsg_ty=
pe=3D%d, cmsg=3Dlen=3D%d)&quot;,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            (int)cmsg-&gt;cmsg_level, (int)cmsg-&gt;cmsg_type,=
 (int)cmsg-&gt;cmsg_len);</span><br><span>     }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    return fromlen;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return buf-&gt;len;</span>=
<br><span> }</span><br><span> #endif /* if ENABLE_IP_PKTINFO */</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ssize_t</span><br><span> link_s=
ocket_read_udp_posix(struct link_socket *sock, struct buffer *buf,</span><b=
r><span>                            struct link_socket_actual *from)</span>=
<br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ssi=
ze_t recvlen;</span><br><span>     socklen_t fromlen =3D sizeof(from-&gt;de=
st=2Eaddr);</span><br><span>     socklen_t expectedlen =3D af_addr_size(soc=
k-&gt;info=2Eaf);</span><br><span>     addr_zero_host(&amp;from-&gt;dest);<=
/span><br><span>@@ -2396,16 +2407,23 @@</span><br><span>     /* Both PROTO_=
UDPv4 and PROTO_UDPv6 */</span><br><span>     if (sock-&gt;info=2Eproto =3D=
=3D PROTO_UDP &amp;&amp; sock-&gt;sockflags &amp; SF_USE_IP_PKTINFO)</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   fromlen =3D link_socket_read_udp_posix_recvmsg(sock, buf, from);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        recvlen =3D link_so=
cket_read_udp_posix_recvmsg(sock, buf, from, &amp;fromlen);</span><br><span=
>     }</span><br><span>     else</span><br><span> #endif</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf-&gt;=
len =3D recvfrom(sock-&gt;sd, BPTR(buf), buf_forward_capacity(buf), 0, &amp=
;from-&gt;dest=2Eaddr=2Esa,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                            &amp;fromlen);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        recvlen =3D recvfrom(sock-&gt;sd, BPTR=
(buf), buf_forward_capacity(buf), 0,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                           &amp;from-&gt;dest=2Eaddr=2Esa,=
 &amp;fromlen);</span><br><span>     }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (recvlen &lt; 0)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        buf-&gt;len =3D 0;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return recvlen;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ASSERT(recvlen &lt;=3D INT_MAX);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    buf-&gt;len =3D (int)recvlen;</span><br><span>  =
   /* FIXME: won&#39;t do anything when sock-&gt;info=2Eaf =3D=3D AF_UNSPEC=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (buf-&gt;le=
n &gt;=3D 0 &amp;&amp; expectedlen &amp;&amp; fromlen !=3D expectedlen)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (expectedlen &am=
p;&amp; fromlen !=3D expectedlen)</span><br><span>     {</span><br><span>  =
       bad_address_length(fromlen, expectedlen);</span><br><span>     }</sp=
an><br><span>@@ -2421,7 +2439,9 @@</span><br><span> ssize_t</span><br><span=
> link_socket_write_tcp(struct link_socket *sock, struct buffer *buf, struc=
t link_socket_actual *to)</span><br><span> {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    packet_size_type len =3D (packet_size_type)BLENZ=
(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int=
 blen =3D BLEN(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    ASSERT(blen &gt;=3D 0 &amp;&amp; blen &lt;=3D PACKET_SIZE_MAX);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_size_type len =
=3D (packet_size_type)blen;</span><br><span>     dmsg(D_STREAM_DEBUG, &quot=
;STREAM: WRITE %u offset=3D%d&quot;, len, buf-&gt;offset);</span><br><span>=
     ASSERT(len &lt;=3D sock-&gt;stream_buf=2Emaxlen);</span><br><span>    =
 len =3D htonps(len);</span><br><span>@@ -2433,10 +2453,6 @@</span><br><spa=
n> #endif</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #if ENABLE_IP_PKTINF=
O</span><br><span> </span><br><span> ssize_t</span><br><span>diff --git a/s=
rc/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span>index 588359=
2=2E=2Eb490610 100644</span><br><span>--- a/src/openvpn/socket=2Eh</span><b=
r><span>+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -54,6 +54,7 @@</spa=
n><br><span>  */</span><br><span> </span><br><span> typedef uint16_t packet=
_size_type;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
PACKET_SIZE_MAX UINT16_MAX</span><br><span> </span><br><span> /* convert a =
packet_size_type from host to network order */</span><br><span> #define hto=
nps(x) htons(x)</span><br><span>@@ -457,7 +458,7 @@</span><br><span> #endif=
 /* if PORT_SHARE */</span><br><span> </span><br><span> static inline bool<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-socket_connection_rese=
t(const struct link_socket *sock, int status)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+socket_connection_reset(const struct link_socket =
*sock, ssize_t status)</span><br><span> {</span><br><span>     if (link_soc=
ket_connection_oriented(sock))</span><br><span>     {</span><br><span>@@ -5=
84,7 +585,7 @@</span><br><span>  * Socket Read Routines</span><br><span>  *=
/</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-in=
t link_socket_read_tcp(struct link_socket *sock, struct buffer *buf);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t link_socket_read_=
tcp(struct link_socket *sock, struct buffer *buf);</span><br><span> </span>=
<br><span> #ifdef _WIN32</span><br><span> </span><br><span>@@ -604,20 +605,=
20 @@</span><br><span> </span><br><span> #else  /* ifdef _WIN32 */</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int link_soc=
ket_read_udp_posix(struct link_socket *sock, struct buffer *buf,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                               s=
truct link_socket_actual *from);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ssize_t link_socket_read_udp_posix(struct link_socket *sock, s=
truct buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                  struct link_socket_actual *from);</span><=
br><span> </span><br><span> #endif /* ifdef _WIN32 */</span><br><span> </sp=
an><br><span> /* read a TCP or UDP packet from link */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static inline ssize_t</span><br><span> link_=
socket_read(struct link_socket *sock, struct buffer *buf, struct link_socke=
t_actual *from)</span><br><span> {</span><br><span>     if (proto_is_udp(so=
ck-&gt;info=2Eproto) || socket_is_dco_win(sock))</span><br><span>     /* un=
ified UDPv4 and UDPv6, for DCO-WIN the kernel</span><br><span>      * will =
strip the length header */</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        int res;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        ssize_t res;</span><br><span> </span><br><=
span> #ifdef _WIN32</span><br><span>         res =3D link_socket_read_udp_w=
in32(sock, buf, from);</span><br><span>diff --git a/src/openvpn/tun=2Eh b/s=
rc/openvpn/tun=2Eh</span><br><span>index 6a7af85=2E=2E931e54d 100644</span>=
<br><span>--- a/src/openvpn/tun=2Eh</span><br><span>+++ b/src/openvpn/tun=
=2Eh</span><br><span>@@ -535,7 +535,7 @@</span><br><span> }</span><br><span=
> </span><br><span> static inline bool</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-tuntap_is_dco_win_timeout(struct tuntap *tt, int status)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+tuntap_is_dco_win_tim=
eout(struct tuntap *tt, ssize_t status)</span><br><span> {</span><br><span>=
     return tuntap_is_dco_win(tt) &amp;&amp; (status &lt; 0) &amp;&amp; (op=
envpn_errno() =3D=3D ERROR_NETNAME_DELETED);</span><br><span> }</span><br><=
span>@@ -573,7 +573,7 @@</span><br><span> }</span><br><span> </span><br><sp=
an> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-tuntap_is_dco_win_timeout(struct tuntap *tt, int status)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+tuntap_is_dco_win_timeout(struct tunt=
ap *tt, ssize_t status)</span><br><span> {</span><br><span>     return fals=
e;</span><br><span> }</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1554?usp=3Demail">change=
 1554</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1554?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div=
 style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Iabe1992b2608661b862a81363574e957d18395f0 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1554 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>

</body></html>
--/vGc3pFWNXY=--


--===============7679535024756797160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7679535024756797160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7679535024756797160==--

