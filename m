Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7800C624D3
	for <openvpn-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nSyXwnkDCeeTCo6b6zHWCshxH17JBVFepV46EA+Xnqk=; b=LNhiWCn76BOqqjO8XCC3/m/Gtd
	rKxZMX+neYg4Cvnl/5kobhZIauRkG/LzM1P6NO8JnTgvlhwrz6WM43AsPpETza0YiA0Z4XrgbBiu0
	T7Y4/BKpvDY7PpOwQRPSPVy/ydkpgqbkN6rKLBh1eZxqe/gRSaL+kGZtvo1b22S3K0sU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1Rrd-0003xK-T2;
	Tue, 01 Sep 2026 17:01:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1Rra-0003xC-VL
 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 17:01:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=O3aYye/l3/u3Grsc+2pS3sg8RKjzSCydoTPzUGkfezE=; b=mVRUB3gwtWNSuiOX2CBLmAuH0c
 fIr783Ya3iYfTdHoidO25Iir11GFXkT0nKbrF2fr5BUxoka8KZJUXZe6VSopbMWyJT1zRJXipLVv9
 LNbpgfNu7FFFNtRxO2uFcWbAhMcLCnXJu79Tlb14cAHubs7IsU9yswRozwChlXqNTqdM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=O3aYye/l3/u3Grsc+2pS3sg8RKjzSCydoTPzUGkfezE=; b=G
 qTbQqoGr/S9d/4VzAJPdRuTvAEr1RVnR+MSqBwCn3HRCdfN1uuvv3Me8dIM8UxplxzFl7XcAj/IJN
 SbpJ68dQ/bi4irMzbo1frnJIyG8TymifSAzWhxUl4FnGp+0R0Kv6BCjjq4QPNfU1S0OAjZ1VNEkOo
 w8DgJPEltdCWjytg=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1RrZ-0006ld-2x for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 17:01:34 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-499b2981a7bso58269425e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 10:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788282086; x=1788886886; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=O3aYye/l3/u3Grsc+2pS3sg8RKjzSCydoTPzUGkfezE=;
 b=NYWrqliA3XMWi6hEyV9cx8E5yghfOqEWFd8huyhaz9BpX/lizhi2xKHQ/OteHG5Yld
 k+08/QUxNfWuxF7Zp3cAJ1LL5s2JcHZSF3Z0rA2bvgQQekP1Ub2JAXmgep6MWeae2Tri
 pwXpnadqhd8mdbiFaBJB7MqAMMm3lDTjHCO5qzNd1+XuyQe+Y1pG5uEbCzFIy2gwQz97
 /s1BzkdfV+EUd7QeoQ4BL8QTxQlaHSFmPc7m9niDaAP4xqnEDgH73hOwh7TGMH1AKIY6
 lQwQ+/JNtXfTnlHwM1LqFiqC2dMn4F5KgSnExPzFfDbkwjLhhvuKFOpSN6XJQyx3ESkz
 D+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788282086; x=1788886886;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=O3aYye/l3/u3Grsc+2pS3sg8RKjzSCydoTPzUGkfezE=;
 b=f+9ogw0DbwzhnaekYwVOKpJdQTViz0/q6UbBqTU0GyEunbkpVx47mXv+BBjHNPRXRV
 b17Rf3JPD66jW1PO0oMdHZCkIdzswFOLbp7PTgHMdjvx4Qle6dZhrhZYFXiEstUNpGP7
 UN60W2xp71hUeVtXvyqTWW+UNKc1qa2Q3kAloRIWx560tQYuTSODXAglPtzwj4afrgw+
 UqH8A8xbnKmIcOHhafOevJqU0KdKYv1l/9eNQmtE0AmY+jDy79u0ed+a/XGlUroG1X2U
 QXCAgrjVs9ujFp1C73GiJ/dwCN9LnbgNpo6KyGekHon596EgyOfpauxZYCMkk/TZgN3z
 AiDw==
X-Gm-Message-State: AFuF++kcBYDxaQFRcUPXb8TuCbw/aLePXz5Ee0w9HbAVKY3iHAvB/wN2
 rsO+ZzV3A1KpNxiZl9Gi2fmDyQ/Y8sYB7CF2i/LoegoT52CfNzS+KdfUiCdghx9DFzKGIHZy5TU
 F9rgTvKUxK3x7jN1Dv4o0wiH5T4/WjH3phQSQUhFQmUKXep1zSy/+50D9s1ZPhdcRMZ9w
X-Gm-Gg: AR+sD11NZOi1FM/Th/U+GvJAaf48FuSMGQ3mN7bfR4KedCSoPB2adU93iuaR7XWsMM2
 tWYa85Pnj9wJaRBRLfB/WH+QUUdoosSY/JfVcNQYV2CDC7HIbij8HBXqqXV0+Uq2RUdZbDHcxq+
 kCUXtr4U+Ra9mfTw/vhsiYlA5QUZPtiR3OobD7Q2aWeoTKVZxt1bp5rw7kZGCYDJm8X2KE7aC3r
 1iwR8ouwV57wjiLVz1MrVujdiUGtK1pg0ivnbASsDbR8OQjknxbv9Shed4AFbjPKCxgLsSO8b2w
 Z5Ic8CM4xyaA+xP0Quf/yoha1pcFNO9cYbNDsX98ntoBHq4XA5BFKt2x7/TaV5C9hw2Vldn4VZs
 oewRHi95pJZ/zdFPrRSWps+0fOymCo9ej98JHIAK5lJerpRwljSpBzpotANJ0lEtaEtHGtJb/na
 dpCtZDoq/kRZ6nxMRPo40H51vyJ0XUchkBTOQnFj4SvXmeha21kz9REo6EC3yYPYwwRweFISGg6
 xDXQz+2zjdj3PrD+HqhPVT+PNF/aDa6FxGIZSUJ7TMrw+zf2tUhnUi9ibodtlM39H5NOUYpDLro
 8qUas7Lod2tryA7We80h6VLStS+WZzMQW1kI
X-Received: by 2002:a05:600c:524b:b0:49c:c9ac:a4f3 with SMTP id
 5b1f17b1804b1-49cdc42f43dmr165807785e9.1.1788282086310; 
 Tue, 01 Sep 2026 10:01:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce1e1ebsm80333015e9.14.2026.09.01.10.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:01:25 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 1 Sep 2026 17:01:24 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7
X-Gerrit-Change-Number: 1782
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1782?usp=email>
X-Gerrit-Commit: 90ab7be00e73d06f7a5bf72e6a454fcfd5f2818c
In-Reply-To: <gerrit.1783977723000.Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7@gerrit.openvpn.net>
References: <gerrit.1783977723000.Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTc3NzIzMDAwLkllNzM1MmRkMTM2Y2NjZGEyYmQ2YjZlMWEzNmRiMWE1ZjI3YWZkOGY3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dca290c93d3baf649e4257ffac6eed7bb253451f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1RrZ-0006ld-2x
Subject: [Openvpn-devel] [M] Change in openvpn[master]: networking_sitnl:
 validate netlink replies against the request
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8341190943661460332=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8341190943661460332==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gsJ3ZndUnWA="; charset=UTF-8

--gsJ3ZndUnWA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1782?usp=3Demail )

T=
he following approvals got outdated and were removed:
Code-Review+2 by ralf=
_lici


Change subject: networking_sitnl: validate netlink replies against =
the request
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

n=
etworking_sitnl: validate netlink replies against the request

sitnl_send()=
 passed every well-formed reply to the callback without
checking it matched=
 the outstanding request: the seq/pid check was
commented out and the seque=
nce number came from time(NULL)=2E

Seed a monotonically increasing sequenc=
e number and drop any message
that is not from the kernel (nl_pid 0) or doe=
s not echo our port id and
sequence number=2E

Change-Id: Ie7352dd136cccda2=
bd6b6e1a36db1a5f27afd8f7
GitHub: fixes OpenVPN/openvpn-private-issues#9
Rep=
orted-by: Joshua Rogers <contact@joshua=2Ehu>
Found-By: ZeroPath (https://z=
eropath=2Ecom)
Signed-off-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
A=
cked-by: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit URL: https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1782
Message-Id: <20260901151017=2E16221-1-gert@green=
ie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2E=
sourceforge=2Enet/msg38879=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/networking_sitnl=2Ec
1 file changed, 37 inse=
rtions(+), 17 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/82/1782/4

diff --git a/src/openvpn/networking_sitnl=
=2Ec b/src/openvpn/networking_sitnl=2Ec
index e6e72d0=2E=2Ea396255 100644
-=
-- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/openvpn/networking_sitnl=2E=
c
@@ -197,7 +197,7 @@
  * Bind socket to Netlink subsystem
  */
 static int=

-sitnl_bind(int fd, uint32_t groups)
+sitnl_bind(int fd, uint32_t groups, =
uint32_t *local_pid)
 {
     socklen_t addr_len;
     struct sockaddr_nl lo=
cal;
@@ -232,6 +232,14 @@
         return -EINVAL;
     }
 
+    /* We boun=
d with nl_pid=3D0, so the kernel assigned this socket a unique port
+     *=
 id (it is not the process pid - a process may own several netlink
+     * =
sockets)=2E getsockname() above is the only way to learn it: hand it back
+=
     * to the caller, which uses it to check that replies are addressed to =
this
+     * socket=2E
+     */
+    *local_pid =3D local=2Enl_pid;
+
     =
return 0;
 }
 
@@ -243,6 +251,7 @@
            void *arg_cb)
 {
     int fd=
, ret;
+    uint32_t local_pid =3D 0;
     struct sockaddr_nl nladdr;
     =
struct nlmsgerr *err;
     struct nlmsghdr *h;
@@ -264,11 +273,17 @@
     n=
laddr=2Enl_pid =3D peer;
     nladdr=2Enl_groups =3D groups;
 
-    /* NB: =
We currently do not verify seq and pid on answers=2E
-     * If we ever wan=
t to start with that we probably need to come up
-     * with something bet=
ter than "seconds since epoch"=2E=2E=2E
+    /* Match replies to requests w=
ith a monotonically increasing sequence
+     * number, seeded once from wa=
ll-clock time so it differs between runs=2E
+     * The kernel echoes this =
seq (and our port id) in its replies, letting the
+     * receive loop belo=
w discard any unrelated or spoofed message=2E
      */
-    payload->nlmsg_=
seq =3D (uint32_t)time(NULL);
+    static uint32_t sitnl_seq;
+    if (!sit=
nl_seq)
+    {
+        sitnl_seq =3D (uint32_t)time(NULL);
+    }
+    pay=
load->nlmsg_seq =3D ++sitnl_seq;
 
     /* no need to send reply */
     if=
 (!cb)
@@ -283,7 +298,7 @@
         return -errno;
     }
 
-    if (sitnl_=
bind(fd, 0) < 0)
+    if (sitnl_bind(fd, 0, &local_pid) < 0)
     {
       =
  msg(M_WARN | M_ERRNO, "%s: can't bind rtnl socket", __func__);
         r=
et =3D -errno;
@@ -357,18 +372,23 @@
                 goto out;
           =
  }
 
-            /*            if (((int)nladdr=2Enl_pid !=3D peer) || (h=
->nlmsg_pid !=3D nladdr=2Enl_pid)
-             *               || (h->nlms=
g_seq !=3D seq))
-             *           {
-             *               =
rcv_len -=3D NLMSG_ALIGN(len);
-             *               h =3D (struct =
nlmsghdr *)((char *)h + NLMSG_ALIGN(len));
-             *               ms=
g(M_DEBUG, "%s: skipping unrelated message=2E nl_pid:%d (peer:%d)
-        =
     * nl_msg_pid:%d nl_seq:%d seq:%d",
-             *                   _=
_func__, (int)nladdr=2Enl_pid, peer, h->nlmsg_pid,
-             *         =
          h->nlmsg_seq, seq);
-             *               continue;
-    =
         *           }
+            /* Discard any message that did not com=
e from the kernel or does
+             * not match the request we sent: on=
ly the kernel (nl_pid 0) can
+             * legitimately reply, and a vali=
d reply echoes our port id and
+             * sequence number=2E This prev=
ents a local process from injecting a
+             * spoofed reply that th=
e callback would otherwise act on=2E
              */
+            if ((nla=
ddr=2Enl_pid !=3D 0) || (h->nlmsg_pid !=3D local_pid)
+                || (=
h->nlmsg_seq !=3D payload->nlmsg_seq))
+            {
+                msg(=
D_RTNL,
+                    "%s: skipping unrelated message=2E nl_pid:%u n=
lmsg_pid:%u (local:%u) nlmsg_seq:%u (seq:%u)",
+                    __func_=
_, nladdr=2Enl_pid, h->nlmsg_pid, local_pid, h->nlmsg_seq,
+               =
     payload->nlmsg_seq);
+                rcv_len -=3D NLMSG_ALIGN(len);
+=
                h =3D (struct nlmsghdr *)((char *)h + NLMSG_ALIGN(len));
+ =
               continue;
+            }
 
             if (h->nlmsg_type =
=3D=3D NLMSG_DONE)
             {

-- 
To view, visit http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1782?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7
Gerrit-Change-Nu=
mber: 1782
Gerrit-PatchSet: 4
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>=

Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: r=
alf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>

--gsJ3ZndUnWA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by ordex=2E</p=
><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1782?usp=3Demail">=
View Change</a></p><p>The following approvals got outdated and were removed=
:
Code-Review+2 by ralf_lici</p><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">networking_sitnl: validate ne=
tlink replies against the request<br><br>sitnl_send() passed every well-for=
med reply to the callback without<br>checking it matched the outstanding re=
quest: the seq/pid check was<br>commented out and the sequence number came =
from time(NULL)=2E<br><br>Seed a monotonically increasing sequence number a=
nd drop any message<br>that is not from the kernel (nl_pid 0) or does not e=
cho our port id and<br>sequence number=2E<br><br>Change-Id: Ie7352dd136cccd=
a2bd6b6e1a36db1a5f27afd8f7<br>GitHub: fixes OpenVPN/openvpn-private-issues#=
9<br>Reported-by: Joshua Rogers &lt;contact@joshua=2Ehu&gt;<br>Found-By: Ze=
roPath (https://zeropath=2Ecom)<br>Signed-off-by: Antonio Quartulli &lt;ant=
onio@mandelbit=2Ecom&gt;<br>Acked-by: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt=
;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1782<br>Message=
-Id: &lt;20260901151017=2E16221-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https=
://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg3887=
9=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>=
---<br>M src/openvpn/networking_sitnl=2Ec<br>1 file changed, 37 insertions(=
+), 17 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/82/1782/4</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/ope=
nvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec</span><br><spa=
n>index e6e72d0=2E=2Ea396255 100644</span><br><span>--- a/src/openvpn/netwo=
rking_sitnl=2Ec</span><br><span>+++ b/src/openvpn/networking_sitnl=2Ec</spa=
n><br><span>@@ -197,7 +197,7 @@</span><br><span>  * Bind socket to Netlink =
subsystem</span><br><span>  */</span><br><span> static int</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-sitnl_bind(int fd, uint32_t groups)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_bind(int fd, uin=
t32_t groups, uint32_t *local_pid)</span><br><span> {</span><br><span>     =
socklen_t addr_len;</span><br><span>     struct sockaddr_nl local;</span><b=
r><span>@@ -232,6 +232,14 @@</span><br><span>         return -EINVAL;</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* We bound with nl_pid=3D0, so the kernel assigned thi=
s socket a unique port</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * id (it is not the process pid - a process may own several netlink=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * sockets)=2E =
getsockname() above is the only way to learn it: hand it back</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * to the caller, which uses =
it to check that replies are addressed to this</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * socket=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    *local_pid =3D local=2Enl_pid;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span>     return 0;</span><br><span>=
 }</span><br><span> </span><br><span>@@ -243,6 +251,7 @@</span><br><span>  =
          void *arg_cb)</span><br><span> {</span><br><span>     int fd, ret=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t local=
_pid =3D 0;</span><br><span>     struct sockaddr_nl nladdr;</span><br><span=
>     struct nlmsgerr *err;</span><br><span>     struct nlmsghdr *h;</span>=
<br><span>@@ -264,11 +273,17 @@</span><br><span>     nladdr=2Enl_pid =3D pe=
er;</span><br><span>     nladdr=2Enl_groups =3D groups;</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* NB: We currently=
 do not verify seq and pid on answers=2E</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-     * If we ever want to start with that we probably ne=
ed to come up</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * w=
ith something better than &quot;seconds since epoch&quot;=2E=2E=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* Match replies to requ=
ests with a monotonically increasing sequence</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * number, seeded once from wall-clock time s=
o it differs between runs=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * The kernel echoes this seq (and our port id) in its replies=
, letting the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 receive loop below discard any unrelated or spoofed message=2E</span><br><=
span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    payl=
oad-&gt;nlmsg_seq =3D (uint32_t)time(NULL);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    static uint32_t sitnl_seq;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (!sitnl_seq)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        sitnl_seq =3D (uint32_t)time(NULL);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    payload-&gt;nlmsg_seq =3D ++sitnl_seq;</=
span><br><span> </span><br><span>     /* no need to send reply */</span><br=
><span>     if (!cb)</span><br><span>@@ -283,7 +298,7 @@</span><br><span>  =
       return -errno;</span><br><span>     }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (sitnl_bind(fd, 0) &lt; 0)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sitnl_bind(f=
d, 0, &amp;local_pid) &lt; 0)</span><br><span>     {</span><br><span>      =
   msg(M_WARN | M_ERRNO, &quot;%s: can&#39;t bind rtnl socket&quot;, __func=
__);</span><br><span>         ret =3D -errno;</span><br><span>@@ -357,18 +3=
72,23 @@</span><br><span>                 goto out;</span><br><span>       =
      }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            /*            if (((int)nladdr=2Enl_pid !=3D peer) || (h-&g=
t;nlmsg_pid !=3D nladdr=2Enl_pid)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-             *               || (h-&gt;nlmsg_seq !=3D seq))</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-             *           =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             *      =
         rcv_len -=3D NLMSG_ALIGN(len);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-             *               h =3D (struct nlmsghdr *)((c=
har *)h + NLMSG_ALIGN(len));</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-             *               msg(M_DEBUG, &quot;%s: skipping unrelat=
ed message=2E nl_pid:%d (peer:%d)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-             * nl_msg_pid:%d nl_seq:%d seq:%d&quot;,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-             *                  =
 __func__, (int)nladdr=2Enl_pid, peer, h-&gt;nlmsg_pid,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-             *                   h-&gt;nl=
msg_seq, seq);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
      *               continue;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-             *           }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            /* Discard any message that did not come from =
the kernel or does</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
            * not match the request we sent: only the kernel (nl_pid 0) can=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * legi=
timately reply, and a valid reply echoes our port id and</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+             * sequence number=2E This=
 prevents a local process from injecting a</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+             * spoofed reply that the callback would=
 otherwise act on=2E</span><br><span>              */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if ((nladdr=2Enl_pid !=3D 0) =
|| (h-&gt;nlmsg_pid !=3D local_pid)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                || (h-&gt;nlmsg_seq !=3D payload-&gt;nlmsg_=
seq))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(=
D_RTNL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        &quot;%s: skipping unrelated message=2E nl_pid:%u nlmsg_pid:%u (loc=
al:%u) nlmsg_seq:%u (seq:%u)&quot;,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    __func__, nladdr=2Enl_pid, h-&gt;nlmsg_=
pid, local_pid, h-&gt;nlmsg_seq,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    payload-&gt;nlmsg_seq);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                rcv_len -=3D NLMSG_ALI=
GN(len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     h =3D (struct nlmsghdr *)((char *)h + NLMSG_ALIGN(len));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                continue;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><sp=
an> </span><br><span>             if (h-&gt;nlmsg_type =3D=3D NLMSG_DONE)</=
span><br><span>             {</span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1782?usp=3Demail=
">change 1782</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/178=
2?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 1782 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: ord=
ex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--gsJ3ZndUnWA=--


--===============8341190943661460332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8341190943661460332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8341190943661460332==--

