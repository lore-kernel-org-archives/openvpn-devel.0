Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AC2C53219
	for <openvpn-devel@archiver.kernel.org>; Mon, 27 Jul 2026 12:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rQ2un3MPR7i9EN16amTFO+Ce1OLTwMPtGajm/mW7tTc=; b=OjWfYCPzq4xYWH2hdAv3m/nPZE
	ioeH7amLEA/hZXgG84fX2e7lNJgsT7AxLigoDRaqJaaCqZWkzn31hu60Jvd/9tiRAKmKQgPUsaC/4
	TS67bWy8q3jbJbKhkaQw/q/slPShyBCWjCcu3yx6OGoJTvYGXpLovFFmLniOVMAL80rk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woKLj-00086I-Kf;
	Mon, 27 Jul 2026 12:22:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1woKLA-00085c-Ix
 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 12:21:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ZJyhF2l2vqRRne0VzTpyp+dr24JXBizfEIAg2jj1Bl8=; b=eutKkJxpIfBKckt3BlUOOYOvia
 /4lbLRGZpW2O5qd4ArZy8Sv6ZqnFLEfJAKdQpeEd2J/AGpB6ro2uAUjJLeooi2wei8D6T8+9vEaAU
 SfgdnQSBijSDdi0BUzzOMoQwCm33vrjnluipOQ+z01ipgfnw6ZcfY17TeYGNCRh4eESI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZJyhF2l2vqRRne0VzTpyp+dr24JXBizfEIAg2jj1Bl8=; b=O
 SexKUqQyiffYz+qVhEJjAYgjqJQt9fD2mbj/5rimTTAN7SePdWIupmWRA5zWzGwn0MYHFpzeWdcES
 4zeKwHrtuwvuj+JH1vWd0sMwa27/BVG7DkRmFLpQpzGSCnGgSsUJCoyNbMkdyEK/UMJZj/J7sq5GN
 UYvGBXvGx/PrCpas=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1woKLA-0006H3-2X for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 12:21:52 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47362928f65so2503366f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 27 Jul 2026 05:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785154902; x=1785759702; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZJyhF2l2vqRRne0VzTpyp+dr24JXBizfEIAg2jj1Bl8=;
 b=aoOP5g7i2ChOzVq61nQ8sN9lM/KcrDLHwsP+3YFBZXDXfDI0j6+hOIAjHJpnC+1dQQ
 r9gQOk+aVgi4JplF8sxkC+p+aCHGKjyl1fMn/WuEW+Fo/udb4uEW17n+4TvnnX1sQg9G
 c+36l3f0LV3dnlnBPYTbG54ybr8tmwRem0C3/U1+Tr4susxJDvn7FIjSRNoEaCLCXekM
 aPVWXUnkfn/r60b7xzg9E+e9lWogzNP8YaAmeSlqDLkVWfInKxWp0aS2IKBvYz0BiYiU
 mKoSmlVlSy0Ot/3XrJnNmK6Icy6HJKWbik1CaI3sPUJl7JS7OCaaXCU/r9cBH28b5HZ2
 jvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785154902; x=1785759702;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZJyhF2l2vqRRne0VzTpyp+dr24JXBizfEIAg2jj1Bl8=;
 b=GZRlg/W1b6u+mOKyGg3qWKe36tb3xYFgPYmKqMEg0l1J3LRiGyCNwaSMh1lLmmQaek
 cssaTGrE71FvBk2asHsM58BxPXDgxCBe8OKm0qR/iZ5MsBmasVsEBkfLVzKWUSQMnMIP
 uOgM9ABlA96hdr1fHAgCXDgXJ50PiTW8b4KOwRJy3xSaJ32hP36eOf2VcfTCvjA8q8nK
 CcE32uSS1yJ+wpB8AKKZa6pusCh9i4Pq17+6+UF/zxx1B2AtV2Pk7uJ6Qqk4ciOML54V
 fJeRDL77ymBSGDD6Xz8REfVk4dz8wAqj9+xGlMiqJjSTfqSPFOgVjn0FqSh/GwGeYqpd
 WR6g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoOTg0ZGdi9OGEhAcE0ZPrZ4PzIqE6qWoeZvIozM6sIAbE0kRgzqwbCPQxtaeIwczaQe74kPuk5PxyTsN/X@lists.sourceforge.net
X-Gm-Message-State: AOJu0Ywr+i4nFFVsz+aGGI4+4uohRdxsRfQvyB5hs7S7+sO/YFtMnyat
 0dMiadRZHbtLOLTJURGfl6XDbsN5RNbwyZ+SKAHWBx8GhNAesCERr6tFFeQRmzPHui+/nA9i0Fu
 8nw6VtkBry0qXWxYcd2iDXxU3SAwsUkpH9AFRIrMiUpHaKI2MEMa3lhEKOxFfaMKhlDZe
X-Gm-Gg: AR+sD11iu7mpXHwVsFvq3/QeOHChLVtON6L0wqf1lzN6QBTXECrdv61NAAx38MotGFf
 N4v4pE3hW2EsEuBl5yQ0n9tDhK0Z0RwtQRUIadxhGqLfXzeChydJXmUQt3yR71C1LDiU6LbgnJA
 xrMV6uP3jvG5Tqi3ZVHf2nYRhOSWm1Re4RsRipqHHipShnN3sI7oDUWvxctiRhiywFSIOZ+Y8gD
 pVeGpDjtpeexcdSayfFT+Zwt1TV3kiO5zv0Qj9/6lehBintmVhhURBsXiqZoQnYJMRGV4mB+w/c
 rDh2BwIpBluUKASpAAQfOl4OyDsaeMX9czZzEsuVRwgp2h1Wjzq0bL05D4PoGZkl0/EBSw1SsQ9
 KUExrBGTWBXtEpedvm+2U7mOEQjm+c2+5epnRyOtBPxmzf9FIPINKkFjchPLiD245iXCMSfsLdH
 8HkV1jEXF+eaXvt51A4dS/MI7UC+UBtHBPl8eKsU45R4u4bGiEFOX63w0rBCyYeHs5TpK7uVcD+
 FTcgrv87LS/KdQn3oE1daq5hFjr2yktb3cCnjuSRvkH0NxqhgH3HAO1PRgIfBjbOqxD
X-Received: by 2002:a05:6000:4303:b0:47f:9760:4d2e with SMTP id
 ffacd0b85a97d-47f9fc9cea1mr9635970f8f.24.1785154901491; 
 Mon, 27 Jul 2026 05:21:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c7880dsm48948401f8f.37.2026.07.27.05.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 05:21:41 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 27 Jul 2026 12:21:40 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Iabe1992b2608661b862a81363574e957d18395f0
X-Gerrit-Change-Number: 1554
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1554?usp=email>
X-Gerrit-Commit: 74c2a965d39fea89c2fe392663eb699fb1324611
In-Reply-To: <gerrit.1772554170000.Iabe1992b2608661b862a81363574e957d18395f0@gerrit.openvpn.net>
References: <gerrit.1772554170000.Iabe1992b2608661b862a81363574e957d18395f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzcyNTU0MTcwMDAwLklhYmUxOTkyYjI2MDg2NjFiODYyYTgxMzYzNTc0ZTk1N2QxODM5NWYwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a883dfa654cbf09962de4a52034cb2a77eed96b9-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1woKLA-0006H3-2X
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8088442814750028012=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8088442814750028012==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VYdcvwjAPsU="; charset=UTF-8

--VYdcvwjAPsU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1554?usp=3Demail )

Change subject: socket: Never use negative buf->len=
 in link_socket_read*
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

socket: Never use negative buf->len in link_socket_read*

We rea=
lly don't want to use negative buf lengths in
our code=2E So remove some pl=
aces where we did so before=2E

Change-Id: Iabe1992b2608661b862a81363574e95=
7d18395f0
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-=
by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1554
Message-Id: <20260708152847=2E60245-1-frank@=
lichtenheld=2Ecom>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg37536=2Ehtml
Signed-off-by: Gert Doering <gert@gre=
enie=2Emuc=2Ede>
---
M src/openvpn/forward=2Ec
M src/openvpn/socket=2Ec
M s=
rc/openvpn/socket=2Eh
M src/openvpn/tun=2Eh
4 files changed, 84 insertions(=
+), 69 deletions(-)




diff --git a/src/openvpn/forward=2Ec b/src/openvpn/=
forward=2Ec
index ab76b9e=2E=2E46e1a53 100644
--- a/src/openvpn/forward=2Ec=

+++ b/src/openvpn/forward=2Ec
@@ -929,14 +929,12 @@
      * Set up for rec=
vfrom call to read datagram
      * sent to our TCP/UDP port=2E
      */
- =
   int status;
-
     /*ASSERT (!c->c2=2Eto_tun=2Elen);*/
 
     c->c2=2Ebu=
f =3D c->c2=2Ebuffers->read_link_buf;
     ASSERT(buf_init(&c->c2=2Ebuf, c-=
>c2=2Eframe=2Ebuf=2Eheadroom));
 
-    status =3D link_socket_read(sock, &c=
->c2=2Ebuf, &c->c2=2Efrom);
+    ssize_t status =3D link_socket_read(sock, =
&c->c2=2Ebuf, &c->c2=2Efrom);
 
     if (socket_connection_reset(sock, stat=
us))
     {
@@ -955,14 +953,14 @@
             if (event_timeout_defined(&c=
->c2=2Eexplicit_exit_notification_interval))
             {
               =
  msg(D_STREAM_ERRORS,
-                    "Connection reset during exit n=
otification period, ignoring [%d]", status);
+                    "Connecti=
on reset during exit notification period, ignoring [%zd]", status);
       =
          management_sleep(1);
             }
             else
           =
  {
                 register_signal(c->sig, SIGUSR1,
                     =
            "connection-reset"); /* SOFT-SIGUSR1 -- TCP connection reset */=

-                msg(D_STREAM_ERRORS, "Connection reset, restarting [%d]",=
 status);
+                msg(D_STREAM_ERRORS, "Connection reset, restarti=
ng [%zd]", status);
             }
         }
         return;
@@ -1026,7 +=
1024,7 @@
      * Good, non-zero length packet received=2E
      * Commence=
 multi-stage processing of packet,
      * such as authenticate, decrypt, d=
ecompress=2E
-     * If any stage fails, it sets buf=2Elen to 0 or -1,
+   =
  * If any stage fails, it sets buf=2Elen to 0,
      * telling downstream =
stages to ignore the packet=2E
      */
     if (c->c2=2Ebuf=2Elen > 0)
dif=
f --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index b73a5df=2E=
=2E8bcc332 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec=

@@ -1102,7 +1102,7 @@
 
 static void stream_buf_close(struct stream_buf *s=
b);
 
-static bool stream_buf_added(struct stream_buf *sb, int length_added=
);
+static bool stream_buf_added(struct stream_buf *sb, ssize_t length_adde=
d);
 
 /* For stream protocols, allocate a buffer to build up packet=2E
  *=
 Called after frame has been finalized=2E */
@@ -1775,6 +1775,10 @@
     }
=
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic p=
op
+#endif
+
 void
 link_socket_close(struct link_socket *sock)
 {
@@ -2142=
,12 +2146,13 @@
  * @return true if \c sb->buf contains fully reassembled p=
acket
  */
 static bool
-stream_buf_added(struct stream_buf *sb, int length=
_added)
+stream_buf_added(struct stream_buf *sb, ssize_t length_added)
 {
-=
    dmsg(D_STREAM_DEBUG, "STREAM: ADD length_added=3D%d", length_added);
+ =
   dmsg(D_STREAM_DEBUG, "STREAM: ADD length_added=3D%zd", length_added);
  =
   if (length_added > 0)
     {
-        sb->buf=2Elen +=3D length_added;
+=
        ASSERT(sb->buf=2Elen + length_added <=3D INT_MAX);
+        sb->buf=
=2Elen +=3D (int)length_added;
     }
 
     /* if length unknown, see if w=
e can get the length prefix from
@@ -2249,10 +2254,10 @@
  * Socket Read Ro=
utines
  */
 
-int
+ssize_t
 link_socket_read_tcp(struct link_socket *sock,=
 struct buffer *buf)
 {
-    int len =3D 0;
+    ssize_t len =3D 0;
 
     =
if (!sock->stream_buf=2Eresidual_fully_formed)
     {
@@ -2282,7 +2287,8 @@=

         }
         if (len <=3D 0)
         {
-            return buf->le=
n =3D len;
+            buf->len =3D 0;
+            return len;
         }=

     }
 
@@ -2314,14 +2320,14 @@
     max_int(CMSG_SPACE(sizeof(struct in6=
_pktinfo)), CMSG_SPACE(sizeof(struct in_addr)))
 #endif
 
-static socklen_t=

+static ssize_t
 link_socket_read_udp_posix_recvmsg(struct link_socket *so=
ck, struct buffer *buf,
-                                   struct link_soc=
ket_actual *from)
+                                   struct link_socket_ac=
tual *from, socklen_t *fromlen)
 {
     struct iovec iov;
     uint8_t pkti=
nfo_buf[PKTINFO_BUF_SIZE];
     struct msghdr mesg =3D { 0 };
-    socklen_=
t fromlen =3D sizeof(from->dest=2Eaddr);
+    *fromlen =3D sizeof(from->des=
t=2Eaddr);
 
     ASSERT(sock->sd >=3D 0); /* can't happen */
 
@@ -2330,62=
 +2336,67 @@
     mesg=2Emsg_iov =3D &iov;
     mesg=2Emsg_iovlen =3D 1;
  =
   mesg=2Emsg_name =3D &from->dest=2Eaddr;
-    mesg=2Emsg_namelen =3D from=
len;
+    mesg=2Emsg_namelen =3D *fromlen;
     mesg=2Emsg_control =3D pkti=
nfo_buf;
-    mesg=2Emsg_controllen =3D sizeof pktinfo_buf;
-    buf->len =
=3D recvmsg(sock->sd, &mesg, 0);
-    if (buf->len >=3D 0)
+    mesg=2Emsg_=
controllen =3D (socklen_t)sizeof(pktinfo_buf);
+    ssize_t len =3D recvmsg=
(sock->sd, &mesg, 0);
+    if (len < 0)
     {
-        struct cmsghdr *cms=
g;
-        fromlen =3D mesg=2Emsg_namelen;
-        cmsg =3D CMSG_FIRSTHDR=
(&mesg);
-        if (cmsg !=3D NULL && CMSG_NXTHDR(&mesg, cmsg) =3D=3D NUL=
L
+        buf->len =3D 0;
+        return len;
+    }
+    ASSERT(len <=3D=
 INT_MAX);
+    buf->len =3D (int)len;
+    struct cmsghdr *cmsg;
+    *fro=
mlen =3D mesg=2Emsg_namelen;
+    cmsg =3D CMSG_FIRSTHDR(&mesg);
+    if (c=
msg !=3D NULL && CMSG_NXTHDR(&mesg, cmsg) =3D=3D NULL
 #if defined(HAVE_IN_=
PKTINFO) && defined(HAVE_IPI_SPEC_DST)
-            && cmsg->cmsg_level =3D=
=3D SOL_IP && cmsg->cmsg_type =3D=3D IP_PKTINFO
-            && cmsg->cmsg_=
len >=3D CMSG_LEN(sizeof(struct in_pktinfo)))
+        && cmsg->cmsg_level =
=3D=3D SOL_IP && cmsg->cmsg_type =3D=3D IP_PKTINFO
+        && cmsg->cmsg_l=
en >=3D CMSG_LEN(sizeof(struct in_pktinfo)))
 #elif defined(IP_RECVDSTADDR)=

-            && cmsg->cmsg_level =3D=3D IPPROTO_IP && cmsg->cmsg_type =3D=
=3D IP_RECVDSTADDR
-            && cmsg->cmsg_len >=3D CMSG_LEN(sizeof(stru=
ct in_addr)))
+        && cmsg->cmsg_level =3D=3D IPPROTO_IP && cmsg->cmsg_=
type =3D=3D IP_RECVDSTADDR
+        && cmsg->cmsg_len >=3D CMSG_LEN(sizeof(=
struct in_addr)))
 #else /* if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI=
_SPEC_DST) */
 #error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RE=
CVDSTADDR (fix syshead=2Eh)
 #endif
-        {
+    {
 #if defined(HAVE_IN_=
PKTINFO) && defined(HAVE_IPI_SPEC_DST)
-            struct in_pktinfo *pkti=
 =3D (struct in_pktinfo *)CMSG_DATA(cmsg);
-            from->pi=2Ein4=2Eip=
i_ifindex =3D
-                (sock->sockflags & SF_PKTINFO_COPY_IIF) ? pk=
ti->ipi_ifindex : 0;
-            from->pi=2Ein4=2Eipi_spec_dst =3D pkti->i=
pi_spec_dst;
+        struct in_pktinfo *pkti =3D (struct in_pktinfo *)CMSG=
_DATA(cmsg);
+        from->pi=2Ein4=2Eipi_ifindex =3D
+            (sock->=
sockflags & SF_PKTINFO_COPY_IIF) ? pkti->ipi_ifindex : 0;
+        from->pi=
=2Ein4=2Eipi_spec_dst =3D pkti->ipi_spec_dst;
 #elif defined(IP_RECVDSTADDR=
)
-            from->pi=2Ein4 =3D *(struct in_addr *)CMSG_DATA(cmsg);
+    =
    from->pi=2Ein4 =3D *(struct in_addr *)CMSG_DATA(cmsg);
 #else /* if def=
ined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST) */
 #error ENABLE_IP_PK=
TINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix syshead=2Eh)
 #endi=
f
-        }
-        else if (cmsg !=3D NULL && CMSG_NXTHDR(&mesg, cmsg) =
=3D=3D NULL
-                 && cmsg->cmsg_level =3D=3D IPPROTO_IPV6 && cm=
sg->cmsg_type =3D=3D IPV6_PKTINFO
-                 && cmsg->cmsg_len >=3D =
CMSG_LEN(sizeof(struct in6_pktinfo)))
-        {
-            struct in6_pk=
tinfo *pkti6 =3D (struct in6_pktinfo *)CMSG_DATA(cmsg);
-            from->=
pi=2Ein6=2Eipi6_ifindex =3D
-                (sock->sockflags & SF_PKTINFO_=
COPY_IIF) ? pkti6->ipi6_ifindex : 0;
-            from->pi=2Ein6=2Eipi6_add=
r =3D pkti6->ipi6_addr;
-        }
-        else if (cmsg !=3D NULL)
-     =
   {
-            msg(M_WARN,
-                "CMSG received that cannot b=
e parsed (cmsg_level=3D%d, cmsg_type=3D%d, cmsg=3Dlen=3D%d)",
-            =
    (int)cmsg->cmsg_level, (int)cmsg->cmsg_type, (int)cmsg->cmsg_len);
-   =
     }
+    }
+    else if (cmsg !=3D NULL && CMSG_NXTHDR(&mesg, cmsg) =3D=
=3D NULL
+             && cmsg->cmsg_level =3D=3D IPPROTO_IPV6 && cmsg->cms=
g_type =3D=3D IPV6_PKTINFO
+             && cmsg->cmsg_len >=3D CMSG_LEN(si=
zeof(struct in6_pktinfo)))
+    {
+        struct in6_pktinfo *pkti6 =3D (s=
truct in6_pktinfo *)CMSG_DATA(cmsg);
+        from->pi=2Ein6=2Eipi6_ifindex=
 =3D
+            (sock->sockflags & SF_PKTINFO_COPY_IIF) ? pkti6->ipi6_ifi=
ndex : 0;
+        from->pi=2Ein6=2Eipi6_addr =3D pkti6->ipi6_addr;
+    }
=
+    else if (cmsg !=3D NULL)
+    {
+        msg(M_WARN,
+            "CMS=
G received that cannot be parsed (cmsg_level=3D%d, cmsg_type=3D%d, cmsg=3Dl=
en=3D%d)",
+            (int)cmsg->cmsg_level, (int)cmsg->cmsg_type, (int)c=
msg->cmsg_len);
     }
 
-    return fromlen;
+    return buf->len;
 }
 #en=
dif /* if ENABLE_IP_PKTINFO */
 
-int
+ssize_t
 link_socket_read_udp_posix(=
struct link_socket *sock, struct buffer *buf,
                            s=
truct link_socket_actual *from)
 {
+    ssize_t recvlen;
     socklen_t fro=
mlen =3D sizeof(from->dest=2Eaddr);
     socklen_t expectedlen =3D af_addr_=
size(sock->info=2Eaf);
     addr_zero_host(&from->dest);
@@ -2396,16 +2407,=
23 @@
     /* Both PROTO_UDPv4 and PROTO_UDPv6 */
     if (sock->info=2Epro=
to =3D=3D PROTO_UDP && sock->sockflags & SF_USE_IP_PKTINFO)
     {
-       =
 fromlen =3D link_socket_read_udp_posix_recvmsg(sock, buf, from);
+        =
recvlen =3D link_socket_read_udp_posix_recvmsg(sock, buf, from, &fromlen);
=
     }
     else
 #endif
     {
-        buf->len =3D recvfrom(sock->sd, BP=
TR(buf), buf_forward_capacity(buf), 0, &from->dest=2Eaddr=2Esa,
-          =
                  &fromlen);
+        recvlen =3D recvfrom(sock->sd, BPTR(b=
uf), buf_forward_capacity(buf), 0,
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

Gerrit-MessageType: merged
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iabe1992b2608661b862=
a81363574e957d18395f0
Gerrit-Change-Number: 1554
Gerrit-PatchSet: 5
Gerrit-=
Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>

--VYdcvwjAPsU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1554?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">socket: Never use negative buf-&gt;len in =
link_socket_read*<br><br>We really don&#39;t want to use negative buf lengt=
hs in<br>our code=2E So remove some places where we did so before=2E<br><br=
>Change-Id: Iabe1992b2608661b862a81363574e957d18395f0<br>Signed-off-by: Fra=
nk Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1554<br>Message-Id: &lt;20260708152847=2E60245-1-frank@lich=
tenheld=2Ecom&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@li=
sts=2Esourceforge=2Enet/msg37536=2Ehtml<br>Signed-off-by: Gert Doering &lt;=
gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/forward=2Ec<br>M src/op=
envpn/socket=2Ec<br>M src/openvpn/socket=2Eh<br>M src/openvpn/tun=2Eh<br>4 =
files changed, 84 insertions(+), 69 deletions(-)<br><br></pre>
<pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>ind=
ex ab76b9e=2E=2E46e1a53 100644</span><br><span>--- a/src/openvpn/forward=2E=
c</span><br><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -929,14 =
+929,12 @@</span><br><span>      * Set up for recvfrom call to read datagra=
m</span><br><span>      * sent to our TCP/UDP port=2E</span><br><span>     =
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int status;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /*=
ASSERT (!c-&gt;c2=2Eto_tun=2Elen);*/</span><br><span> </span><br><span>    =
 c-&gt;c2=2Ebuf =3D c-&gt;c2=2Ebuffers-&gt;read_link_buf;</span><br><span> =
    ASSERT(buf_init(&amp;c-&gt;c2=2Ebuf, c-&gt;c2=2Eframe=2Ebuf=2Eheadroom)=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   status =3D link_socket_read(sock, &amp;c-&gt;c2=2Ebuf, &amp;c-&gt;c2=2Ef=
rom);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ssize_t st=
atus =3D link_socket_read(sock, &amp;c-&gt;c2=2Ebuf, &amp;c-&gt;c2=2Efrom);=
</span><br><span> </span><br><span>     if (socket_connection_reset(sock, s=
tatus))</span><br><span>     {</span><br><span>@@ -955,14 +953,14 @@</span>=
<br><span>             if (event_timeout_defined(&amp;c-&gt;c2=2Eexplicit_e=
xit_notification_interval))</span><br><span>             {</span><br><span>=
                 msg(D_STREAM_ERRORS,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                    &quot;Connection reset during exit noti=
fication period, ignoring [%d]&quot;, status);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                    &quot;Connection reset durin=
g exit notification period, ignoring [%zd]&quot;, status);</span><br><span>=
                 management_sleep(1);</span><br><span>             }</span>=
<br><span>             else</span><br><span>             {</span><br><span>=
                 register_signal(c-&gt;sig, SIGUSR1,</span><br><span>      =
                           &quot;connection-reset&quot;); /* SOFT-SIGUSR1 -=
- TCP connection reset */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                msg(D_STREAM_ERRORS, &quot;Connection reset, restarting=
 [%d]&quot;, status);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                msg(D_STREAM_ERRORS, &quot;Connection reset, restarting [=
%zd]&quot;, status);</span><br><span>             }</span><br><span>       =
  }</span><br><span>         return;</span><br><span>@@ -1026,7 +1024,7 @@<=
/span><br><span>      * Good, non-zero length packet received=2E</span><br>=
<span>      * Commence multi-stage processing of packet,</span><br><span>  =
    * such as authenticate, decrypt, decompress=2E</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-     * If any stage fails, it sets buf=2Elen t=
o 0 or -1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * If=
 any stage fails, it sets buf=2Elen to 0,</span><br><span>      * telling d=
ownstream stages to ignore the packet=2E</span><br><span>      */</span><br=
><span>     if (c-&gt;c2=2Ebuf=2Elen &gt; 0)</span><br><span>diff --git a/s=
rc/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index b73a5d=
f=2E=2E8bcc332 100644</span><br><span>--- a/src/openvpn/socket=2Ec</span><b=
r><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -1102,7 +1102,7 @@<=
/span><br><span> </span><br><span> static void stream_buf_close(struct stre=
am_buf *sb);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-static bool stream_buf_added(struct stream_buf *sb, int length_add=
ed);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool str=
eam_buf_added(struct stream_buf *sb, ssize_t length_added);</span><br><span=
> </span><br><span> /* For stream protocols, allocate a buffer to build up =
packet=2E</span><br><span>  * Called after frame has been finalized=2E */</=
span><br><span>@@ -1775,6 +1775,10 @@</span><br><span>     }</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> void</span><br><span> link_socket_cl=
ose(struct link_socket *sock)</span><br><span> {</span><br><span>@@ -2142,1=
2 +2146,13 @@</span><br><span>  * @return true if \c sb-&gt;buf contains fu=
lly reassembled packet</span><br><span>  */</span><br><span> static bool</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-stream_buf_added(struct =
stream_buf *sb, int length_added)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+stream_buf_added(struct stream_buf *sb, ssize_t length_added)=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  dmsg(D_STREAM_DEBUG, &quot;STREAM: ADD length_added=3D%d&quot;, length_ad=
ded);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_STR=
EAM_DEBUG, &quot;STREAM: ADD length_added=3D%zd&quot;, length_added);</span=
><br><span>     if (length_added &gt; 0)</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        sb-&gt;buf=2Elen +=3D len=
gth_added;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        A=
SSERT(sb-&gt;buf=2Elen + length_added &lt;=3D INT_MAX);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        sb-&gt;buf=2Elen +=3D (int)leng=
th_added;</span><br><span>     }</span><br><span> </span><br><span>     /* =
if length unknown, see if we can get the length prefix from</span><br><span=
>@@ -2249,10 +2254,10 @@</span><br><span>  * Socket Read Routines</span><br=
><span>  */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t<=
/span><br><span> link_socket_read_tcp(struct link_socket *sock, struct buff=
er *buf)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    int len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    ssize_t len =3D 0;</span><br><span> </span><br><span>     if (!soc=
k-&gt;stream_buf=2Eresidual_fully_formed)</span><br><span>     {</span><br>=
<span>@@ -2282,7 +2287,8 @@</span><br><span>         }</span><br><span>    =
     if (len &lt;=3D 0)</span><br><span>         {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            return buf-&gt;len =3D len;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            buf-&gt;len =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            r=
eturn len;</span><br><span>         }</span><br><span>     }</span><br><spa=
n> </span><br><span>@@ -2314,14 +2320,14 @@</span><br><span>     max_int(CM=
SG_SPACE(sizeof(struct in6_pktinfo)), CMSG_SPACE(sizeof(struct in_addr)))</=
span><br><span> #endif</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-static socklen_t</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static ssize_t</span><br><span> link_socket_read_udp_posix_=
recvmsg(struct link_socket *sock, struct buffer *buf,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                   struct l=
ink_socket_actual *from)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                                   struct link_socket_actual *from, so=
cklen_t *fromlen)</span><br><span> {</span><br><span>     struct iovec iov;=
</span><br><span>     uint8_t pktinfo_buf[PKTINFO_BUF_SIZE];</span><br><spa=
n>     struct msghdr mesg =3D { 0 };</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    socklen_t fromlen =3D sizeof(from-&gt;dest=2Eaddr);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    *fromlen =3D sizeof(=
from-&gt;dest=2Eaddr);</span><br><span> </span><br><span>     ASSERT(sock-&=
gt;sd &gt;=3D 0); /* can&#39;t happen */</span><br><span> </span><br><span>=
@@ -2330,62 +2336,67 @@</span><br><span>     mesg=2Emsg_iov =3D &amp;iov;</=
span><br><span>     mesg=2Emsg_iovlen =3D 1;</span><br><span>     mesg=2Ems=
g_name =3D &amp;from-&gt;dest=2Eaddr;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    mesg=2Emsg_namelen =3D fromlen;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    mesg=2Emsg_namelen =3D *fromlen;</spa=
n><br><span>     mesg=2Emsg_control =3D pktinfo_buf;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    mesg=2Emsg_controllen =3D sizeof pktinf=
o_buf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf-&gt;len=
 =3D recvmsg(sock-&gt;sd, &amp;mesg, 0);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (buf-&gt;len &gt;=3D 0)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    mesg=2Emsg_controllen =3D (socklen_t)size=
of(pktinfo_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 ssize_t len =3D recvmsg(sock-&gt;sd, &amp;mesg, 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (len &lt; 0)</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct cmsgh=
dr *cmsg;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        from=
len =3D mesg=2Emsg_namelen;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        cmsg =3D CMSG_FIRSTHDR(&amp;mesg);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        if (cmsg !=3D NULL &amp;&amp; CMSG_NXTHD=
R(&amp;mesg, cmsg) =3D=3D NULL</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        buf-&gt;len =3D 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        return len;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    ASSERT(len &lt;=3D INT_MAX);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    buf-&gt;len =3D (int)len;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct cmsghdr *cmsg;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    *fromlen =3D mesg=2Emsg_namelen;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmsg =3D CMSG_FIRSTH=
DR(&amp;mesg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (cmsg !=3D NULL &amp;&amp; CMSG_NXTHDR(&amp;mesg, cmsg) =3D=3D NULL</span=
><br><span> #if defined(HAVE_IN_PKTINFO) &amp;&amp; defined(HAVE_IPI_SPEC_D=
ST)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &amp;&=
amp; cmsg-&gt;cmsg_level =3D=3D SOL_IP &amp;&amp; cmsg-&gt;cmsg_type =3D=3D=
 IP_PKTINFO</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  &amp;&amp; cmsg-&gt;cmsg_len &gt;=3D CMSG_LEN(sizeof(struct in_pktinfo)))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; =
cmsg-&gt;cmsg_level =3D=3D SOL_IP &amp;&amp; cmsg-&gt;cmsg_type =3D=3D IP_P=
KTINFO</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;=
&amp; cmsg-&gt;cmsg_len &gt;=3D CMSG_LEN(sizeof(struct in_pktinfo)))</span>=
<br><span> #elif defined(IP_RECVDSTADDR)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            &amp;&amp; cmsg-&gt;cmsg_level =3D=3D IPPROT=
O_IP &amp;&amp; cmsg-&gt;cmsg_type =3D=3D IP_RECVDSTADDR</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; cmsg-&gt;cmsg_len=
 &gt;=3D CMSG_LEN(sizeof(struct in_addr)))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        &amp;&amp; cmsg-&gt;cmsg_level =3D=3D IPPROT=
O_IP &amp;&amp; cmsg-&gt;cmsg_type =3D=3D IP_RECVDSTADDR</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; cmsg-&gt;cmsg_len &=
gt;=3D CMSG_LEN(sizeof(struct in_addr)))</span><br><span> #else /* if defin=
ed(HAVE_IN_PKTINFO) &amp;&amp; defined(HAVE_IPI_SPEC_DST) */</span><br><spa=
n> #error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (f=
ix syshead=2Eh)</span><br><span> #endif</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span> #if defined(HAVE_IN_PKTINFO) &amp;&amp; defi=
ned(HAVE_IPI_SPEC_DST)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            struct in_pktinfo *pkti =3D (struct in_pktinfo *)CMSG_DATA(cms=
g);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            from-&=
gt;pi=2Ein4=2Eipi_ifindex =3D</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                (sock-&gt;sockflags &amp; SF_PKTINFO_COPY_IIF) ? pk=
ti-&gt;ipi_ifindex : 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            from-&gt;pi=2Ein4=2Eipi_spec_dst =3D pkti-&gt;ipi_spec_dst;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct in_pkt=
info *pkti =3D (struct in_pktinfo *)CMSG_DATA(cmsg);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        from-&gt;pi=2Ein4=2Eipi_ifindex =
=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            (soc=
k-&gt;sockflags &amp; SF_PKTINFO_COPY_IIF) ? pkti-&gt;ipi_ifindex : 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        from-&gt;pi=2Ein=
4=2Eipi_spec_dst =3D pkti-&gt;ipi_spec_dst;</span><br><span> #elif defined(=
IP_RECVDSTADDR)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      from-&gt;pi=2Ein4 =3D *(struct in_addr *)CMSG_DATA(cmsg);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        from-&gt;pi=2Ein4 =3D *=
(struct in_addr *)CMSG_DATA(cmsg);</span><br><span> #else /* if defined(HAV=
E_IN_PKTINFO) &amp;&amp; defined(HAVE_IPI_SPEC_DST) */</span><br><span> #er=
ror ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix sys=
head=2Eh)</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        else if (cmsg !=3D NULL &amp;&amp; CMSG_NXTHDR(&amp;mesg, cmsg) =3D=
=3D NULL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
    &amp;&amp; cmsg-&gt;cmsg_level =3D=3D IPPROTO_IPV6 &amp;&amp; cmsg-&gt;=
cmsg_type =3D=3D IPV6_PKTINFO</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                 &amp;&amp; cmsg-&gt;cmsg_len &gt;=3D CMSG_LEN(size=
of(struct in6_pktinfo)))</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   struct in6_pktinfo *pkti6 =3D (struct in6_pktinfo *)CMSG_DATA(cmsg);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            from-&gt;pi=
=2Ein6=2Eipi6_ifindex =3D</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                (sock-&gt;sockflags &amp; SF_PKTINFO_COPY_IIF) ? pkti6-=
&gt;ipi6_ifindex : 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            from-&gt;pi=2Ein6=2Eipi6_addr =3D pkti6-&gt;ipi6_addr;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        else if (cmsg !=3D NULL)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                &quot;CMSG received that =
cannot be parsed (cmsg_level=3D%d, cmsg_type=3D%d, cmsg=3Dlen=3D%d)&quot;,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                (int)c=
msg-&gt;cmsg_level, (int)cmsg-&gt;cmsg_type, (int)cmsg-&gt;cmsg_len);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else if (cmsg !=3D NULL &amp;&amp; CMSG_NXTHDR(=
&amp;mesg, cmsg) =3D=3D NULL</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+             &amp;&amp; cmsg-&gt;cmsg_level =3D=3D IPPROTO_IPV6 &a=
mp;&amp; cmsg-&gt;cmsg_type =3D=3D IPV6_PKTINFO</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+             &amp;&amp; cmsg-&gt;cmsg_len &gt;=
=3D CMSG_LEN(sizeof(struct in6_pktinfo)))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        struct in6_pktinfo *pkti6 =3D (struct in6_pktinfo *)CMSG_DA=
TA(cmsg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fr=
om-&gt;pi=2Ein6=2Eipi6_ifindex =3D</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            (sock-&gt;sockflags &amp; SF_PKTINFO_COPY_IIF) ?=
 pkti6-&gt;ipi6_ifindex : 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        from-&gt;pi=2Ein6=2Eipi6_addr =3D pkti6-&gt;ipi6_addr;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    else if (cmsg !=3D NULL)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &quot;CMSG received that cann=
ot be parsed (cmsg_level=3D%d, cmsg_type=3D%d, cmsg=3Dlen=3D%d)&quot;,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            (int)cmsg-&g=
t;cmsg_level, (int)cmsg-&gt;cmsg_type, (int)cmsg-&gt;cmsg_len);</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    return fromlen;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return buf-&gt;len;</span><br><span> }</span><br><span> #endif =
/* if ENABLE_IP_PKTINFO */</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ssize_t</span><br><span> link_socket_read_udp_posix(struct link_sock=
et *sock, struct buffer *buf,</span><br><span>                            s=
truct link_socket_actual *from)</span><br><span> {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ssize_t recvlen;</span><br><span>     so=
cklen_t fromlen =3D sizeof(from-&gt;dest=2Eaddr);</span><br><span>     sock=
len_t expectedlen =3D af_addr_size(sock-&gt;info=2Eaf);</span><br><span>   =
  addr_zero_host(&amp;from-&gt;dest);</span><br><span>@@ -2396,16 +2407,23 =
@@</span><br><span>     /* Both PROTO_UDPv4 and PROTO_UDPv6 */</span><br><s=
pan>     if (sock-&gt;info=2Eproto =3D=3D PROTO_UDP &amp;&amp; sock-&gt;soc=
kflags &amp; SF_USE_IP_PKTINFO)</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        fromlen =3D link_socket_read_udp_p=
osix_recvmsg(sock, buf, from);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        recvlen =3D link_socket_read_udp_posix_recvmsg(sock, buf=
, from, &amp;fromlen);</span><br><span>     }</span><br><span>     else</sp=
an><br><span> #endif</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        buf-&gt;len =3D recvfrom(sock-&gt;sd, BPTR(bu=
f), buf_forward_capacity(buf), 0, &amp;from-&gt;dest=2Eaddr=2Esa,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                            &am=
p;fromlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
recvlen =3D recvfrom(sock-&gt;sd, BPTR(buf), buf_forward_capacity(buf), 0,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
       &amp;from-&gt;dest=2Eaddr=2Esa, &amp;fromlen);</span><br><span>     =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (recvlen &l=
t; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        buf-&gt;len =3D 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return recvle=
n;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(recvlen &lt;=3D INT_=
MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf-&gt;le=
n =3D (int)recvlen;</span><br><span>     /* FIXME: won&#39;t do anything wh=
en sock-&gt;info=2Eaf =3D=3D AF_UNSPEC */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (buf-&gt;len &gt;=3D 0 &amp;&amp; expectedlen &a=
mp;&amp; fromlen !=3D expectedlen)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (expectedlen &amp;&amp; fromlen !=3D expectedlen)</sp=
an><br><span>     {</span><br><span>         bad_address_length(fromlen, ex=
pectedlen);</span><br><span>     }</span><br><span>@@ -2421,7 +2439,9 @@</s=
pan><br><span> ssize_t</span><br><span> link_socket_write_tcp(struct link_s=
ocket *sock, struct buffer *buf, struct link_socket_actual *to)</span><br><=
span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    packet_siz=
e_type len =3D (packet_size_type)BLENZ(buf);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const int blen =3D BLEN(buf);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(blen &gt;=3D 0 &amp;&amp;=
 blen &lt;=3D PACKET_SIZE_MAX);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    packet_size_type len =3D (packet_size_type)blen;</span><br>=
<span>     dmsg(D_STREAM_DEBUG, &quot;STREAM: WRITE %u offset=3D%d&quot;, l=
en, buf-&gt;offset);</span><br><span>     ASSERT(len &lt;=3D sock-&gt;strea=
m_buf=2Emaxlen);</span><br><span>     len =3D htonps(len);</span><br><span>=
@@ -2433,10 +2453,6 @@</span><br><span> #endif</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_=
_GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span> #if ENABLE_IP_PKTINFO</span><br><span> </span><br><span> s=
size_t</span><br><span>diff --git a/src/openvpn/socket=2Eh b/src/openvpn/so=
cket=2Eh</span><br><span>index 5883592=2E=2Eb490610 100644</span><br><span>=
--- a/src/openvpn/socket=2Eh</span><br><span>+++ b/src/openvpn/socket=2Eh</=
span><br><span>@@ -54,6 +54,7 @@</span><br><span>  */</span><br><span> </sp=
an><br><span> typedef uint16_t packet_size_type;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define PACKET_SIZE_MAX UINT16_MAX</span><br><=
span> </span><br><span> /* convert a packet_size_type from host to network =
order */</span><br><span> #define htonps(x) htons(x)</span><br><span>@@ -45=
7,7 +458,7 @@</span><br><span> #endif /* if PORT_SHARE */</span><br><span> =
</span><br><span> static inline bool</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-socket_connection_reset(const struct link_socket *sock, int =
status)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+socket_conne=
ction_reset(const struct link_socket *sock, ssize_t status)</span><br><span=
> {</span><br><span>     if (link_socket_connection_oriented(sock))</span><=
br><span>     {</span><br><span>@@ -584,7 +585,7 @@</span><br><span>  * Soc=
ket Read Routines</span><br><span>  */</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-int link_socket_read_tcp(struct link_soc=
ket *sock, struct buffer *buf);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ssize_t link_socket_read_tcp(struct link_socket *sock, struct b=
uffer *buf);</span><br><span> </span><br><span> #ifdef _WIN32</span><br><sp=
an> </span><br><span>@@ -604,20 +605,20 @@</span><br><span> </span><br><spa=
n> #else  /* ifdef _WIN32 */</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-int link_socket_read_udp_posix(struct link_socket =
*sock, struct buffer *buf,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                               struct link_socket_actual *from);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t link_socket_read_=
udp_posix(struct link_socket *sock, struct buffer *buf,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                   stru=
ct link_socket_actual *from);</span><br><span> </span><br><span> #endif /* =
ifdef _WIN32 */</span><br><span> </span><br><span> /* read a TCP or UDP pac=
ket from link */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stati=
c inline int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
inline ssize_t</span><br><span> link_socket_read(struct link_socket *sock, =
struct buffer *buf, struct link_socket_actual *from)</span><br><span> {</sp=
an><br><span>     if (proto_is_udp(sock-&gt;info=2Eproto) || socket_is_dco_=
win(sock))</span><br><span>     /* unified UDPv4 and UDPv6, for DCO-WIN the=
 kernel</span><br><span>      * will strip the length header */</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        in=
t res;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ssize=
_t res;</span><br><span> </span><br><span> #ifdef _WIN32</span><br><span>  =
       res =3D link_socket_read_udp_win32(sock, buf, from);</span><br><span=
>diff --git a/src/openvpn/tun=2Eh b/src/openvpn/tun=2Eh</span><br><span>ind=
ex 6a7af85=2E=2E931e54d 100644</span><br><span>--- a/src/openvpn/tun=2Eh</s=
pan><br><span>+++ b/src/openvpn/tun=2Eh</span><br><span>@@ -535,7 +535,7 @@=
</span><br><span> }</span><br><span> </span><br><span> static inline bool</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-tuntap_is_dco_win_timeo=
ut(struct tuntap *tt, int status)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+tuntap_is_dco_win_timeout(struct tuntap *tt, ssize_t status)<=
/span><br><span> {</span><br><span>     return tuntap_is_dco_win(tt) &amp;&=
amp; (status &lt; 0) &amp;&amp; (openvpn_errno() =3D=3D ERROR_NETNAME_DELET=
ED);</span><br><span> }</span><br><span>@@ -573,7 +573,7 @@</span><br><span=
> }</span><br><span> </span><br><span> static inline bool</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-tuntap_is_dco_win_timeout(struct tuntap=
 *tt, int status)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tu=
ntap_is_dco_win_timeout(struct tuntap *tt, ssize_t status)</span><br><span>=
 {</span><br><span>     return false;</span><br><span> }</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1554?usp=3Demail">change 1554</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1554?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Iabe1992b2608661b862a81363574e957d1839=
5f0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1554 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display=
:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--VYdcvwjAPsU=--


--===============8088442814750028012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8088442814750028012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8088442814750028012==--

