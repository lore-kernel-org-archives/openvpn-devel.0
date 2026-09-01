Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D84CC61DD3
	for <openvpn-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=00r1Uo9ubpbTiNB6AdHqO8VjKJv8d045JR9erV0DDhE=; b=aGOB8O1EjgcuxYqmWTInlz4mVI
	0m9tpyAXUZCL3SzF1Rlq+EGtrB96LGT+qDONkjQQYzE+9WHycwN8ed/IsuOOknRmLwvAaULMmgcJI
	g3J655oXZ1Bm0TRsGLfnMKVB3zScnu7K5o1Av1UdqO2P0gKBom/SBgszXiBXt1n4Gdy4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1Rrf-0003ez-TM;
	Tue, 01 Sep 2026 17:01:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1Rre-0003et-1p
 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 17:01:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=i7dzaaguvKwUl+GncMRAh1veX7306sNqkDGm1YPyg2s=; b=OWASKyuGP9Hp3KKFHXJnuYJgp+
 aJQ0lBlv40p2NNE45bZxBTE/LPXvC4loY4En2I0IqNehEHqabNC2UzGgBhFFhGYCVcSN5Ob3e5X0X
 O5kkCuaYPvAd1P9DSvJOGFmkpMsUrqCVWasHK433GydoV5Yt7mqLZ06d+LXH8IGgcSb8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=i7dzaaguvKwUl+GncMRAh1veX7306sNqkDGm1YPyg2s=; b=X
 Cpq+d04K+Jwyf4Y70zyTTdY/bnJYJTAWb8FxNtRg6aJAw1ZGGKrI5XtruG56joz830CD2D0G7O4iT
 JDj+7zbJd3Lu6QWWASDumg/UOZWF7EOnmzfb2N4kthlp/Yfyi/F9oTmm+Qz1qyuavL8Uo4pzksdf8
 UBpdvtoM6Xb4Oz7k=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1Rra-0006lf-Gl for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 17:01:35 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49b8e527d63so12900985e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 10:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788282088; x=1788886888; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=i7dzaaguvKwUl+GncMRAh1veX7306sNqkDGm1YPyg2s=;
 b=cjh72XKO9xq8Aa/Py8GrWagSr0bn2+IGp96hfKIRbJ0JNYNJ6cP86LaHA/9gh7Df5n
 cSXlDVpbzKKBhgeFCseGTa6/t+lrcua5vWep3lgXpAzUhCS6d4fNSQqyT4G0o9QtE1oS
 YFGemEougOJQlR0fgjwXe5WhKVpZlbb0mQoGMyDGDs7xhkYqmXGL69j5bp4aAXTQrdGR
 fVT9iTPo6MCNVLa7vxCArA6+8mTSaa5i2uEAJ4ROaH+blXPUTaLEWyVsMtI0xvPQhDT4
 6917WHYQwLSMQ2UtJ63Xnn01L6BHOkx6OKQ840GV6iHo9y+PsZKJkfAOFfKlpzUQRO6Y
 qyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788282088; x=1788886888;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=i7dzaaguvKwUl+GncMRAh1veX7306sNqkDGm1YPyg2s=;
 b=pZ6EhRRE1s3RqZntoJUViN2Zqw97z8G995uzKMfIhbgeKbvcz1vzpPvKfFOipoRbxD
 SOvZre01JIfRtFK45FSoSwW777IQfMjakzshuur4tprlWUxbyEKLhlzjV3F8rzufpEhA
 PrQ/BKIt3vun49kkqJzeyx+O262wdoCvxjqmf//BoeHLnWeRCtzp7J8HnaB6Y5ok/Lwj
 indl9NURmcamb+ql4jzBt0e48pHozz0e/7rIdr5SEzt2HYZklKkcKZGxBp7IYYVoUCCb
 ZcD9UJgx9XS+omQfzJladERG5r+h9S0vK4u3ojNSTwpCtjEtWBR2vRMEnAeSAmg3e7U7
 8ubw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrHDb1c8XSOu7eakWh2dW0I1zF1Nkw+TcYS0Eaoo4wuFruhHxxChfa3Q4sSAYGWN/4yPD8XlptKnBFdso7x@lists.sourceforge.net
X-Gm-Message-State: AFuF++n+k8pGgNRfM1qfjVntvUhCcXHLNHfpHXyRT0YgBQZecznSfamp
 3efJsPfXWconP8+o+Feewj0yce0la3auXrWOWRU+LlEGyIUrhwhEWZxYglrzxKPcr0IfCDisAKw
 O2CyS2W1DV7Xc+ZoLQgH1bac9tcYA00Yat9SsHMiyCDi9gBTD7b0e1j4kOKQKdhRlBN7u
X-Gm-Gg: AR+sD10qwDeMHqTjLsypxVt9gk+QMoFtU49JhDHLzt3K0xn4yWpWbkPM3kEEqsFcA7j
 OYkLSl3/tZaf/W9T3JM+V7ZnCXqQR0AjqibgRonsWH8IEdd09+w6hs0/Kr2j1b9sbXejUtUk6Wh
 Geb4DqrXigVoVi0bcAA9lsshdgY4EiAmqPz52lVKe8zD804jqMtzaOezpaexGSqFgGd5C6implF
 M3FlKjLfb9iDkAkMtfXHXyUfbqev97Dai6mmkARmDgdTfWAKD28V1UF3MxD50BjPNVmrooJDmdf
 Jtvy2GplkJfGZC/4dsJlNDO+W0dQXKrHE1vEwguRQ7+WFK7UQRflPfNel9j+xV390OxqFScDEGu
 Rj5h2Oz/jWee+ewDgmU0fYWqj/JSaWF+7j6TGApB8d+YK50MtijdjQTgch/6cqwG8amPQzM6LzC
 3RXgq/pbUKjojjxlRhETfC8KC5YrOaauI1rlFV/oI54PClN/vSssz7PmZel1LjQpcnCFjsnXFqd
 /gzaBRchZjN4BBJ9SHid42j1DZID4GKmcgeHOaFCHigZjo9WnSQYwGqaObhWte5+hvqCvc6VGEI
 cO1KlF2UqqXOShDlFKhDmwvD3mFmm8nmgA6dfygEpXYZNeSvGKo=
X-Received: by 2002:a05:600c:4e01:b0:49c:cedc:768a with SMTP id
 5b1f17b1804b1-49ccedc76a1mr512147135e9.16.1788282087782; 
 Tue, 01 Sep 2026 10:01:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce3c86a0asm10679455e9.9.2026.09.01.10.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:01:27 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 1 Sep 2026 17:01:27 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7
X-Gerrit-Change-Number: 1782
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1782?usp=email>
X-Gerrit-Commit: 90ab7be00e73d06f7a5bf72e6a454fcfd5f2818c
In-Reply-To: <gerrit.1783977723000.Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7@gerrit.openvpn.net>
References: <gerrit.1783977723000.Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTc3NzIzMDAwLkllNzM1MmRkMTM2Y2NjZGEyYmQ2YjZlMWEzNmRiMWE1ZjI3YWZkOGY3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dca290c93d3baf649e4257ffac6eed7bb253451f-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1Rra-0006lf-Gl
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5033095520358846684=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5033095520358846684==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rTf6KBCN8E4="; charset=UTF-8

--rTf6KBCN8E4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1782?usp=3Demail )

Change subject: networking_sitnl: validate netlink =
replies against the request
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

networking_sitnl: validate netlink replies against the req=
uest

sitnl_send() passed every well-formed reply to the callback without
c=
hecking it matched the outstanding request: the seq/pid check was
commented=
 out and the sequence number came from time(NULL)=2E

Seed a monotonically =
increasing sequence number and drop any message
that is not from the kernel=
 (nl_pid 0) or does not echo our port id and
sequence number=2E

Change-Id:=
 Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7
GitHub: fixes OpenVPN/openvpn-pr=
ivate-issues#9
Reported-by: Joshua Rogers <contact@joshua=2Ehu>
Found-By: Z=
eroPath (https://zeropath=2Ecom)
Signed-off-by: Antonio Quartulli <antonio@=
mandelbit=2Ecom>
Acked-by: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit URL: htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1782
Message-Id: <20260901151017=2E=
16221-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/open=
vpn-devel@lists=2Esourceforge=2Enet/msg38879=2Ehtml
Signed-off-by: Gert Doe=
ring <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/networking_sitnl=2Ec
1 fil=
e changed, 37 insertions(+), 17 deletions(-)




diff --git a/src/openvpn/n=
etworking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec
index e6e72d0=2E=2Ea=
396255 100644
--- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/openvpn/netw=
orking_sitnl=2Ec
@@ -197,7 +197,7 @@
  * Bind socket to Netlink subsystem
 =
 */
 static int
-sitnl_bind(int fd, uint32_t groups)
+sitnl_bind(int fd, ui=
nt32_t groups, uint32_t *local_pid)
 {
     socklen_t addr_len;
     struct=
 sockaddr_nl local;
@@ -232,6 +232,14 @@
         return -EINVAL;
     }
 
=
+    /* We bound with nl_pid=3D0, so the kernel assigned this socket a uniq=
ue port
+     * id (it is not the process pid - a process may own several n=
etlink
+     * sockets)=2E getsockname() above is the only way to learn it:=
 hand it back
+     * to the caller, which uses it to check that replies ar=
e addressed to this
+     * socket=2E
+     */
+    *local_pid =3D local=2E=
nl_pid;
+
     return 0;
 }
 
@@ -243,6 +251,7 @@
            void *arg_cb)=

 {
     int fd, ret;
+    uint32_t local_pid =3D 0;
     struct sockaddr_n=
l nladdr;
     struct nlmsgerr *err;
     struct nlmsghdr *h;
@@ -264,11 +2=
73,17 @@
     nladdr=2Enl_pid =3D peer;
     nladdr=2Enl_groups =3D groups;=

 
-    /* NB: We currently do not verify seq and pid on answers=2E
-     *=
 If we ever want to start with that we probably need to come up
-     * wit=
h something better than "seconds since epoch"=2E=2E=2E
+    /* Match replie=
s to requests with a monotonically increasing sequence
+     * number, seed=
ed once from wall-clock time so it differs between runs=2E
+     * The kern=
el echoes this seq (and our port id) in its replies, letting the
+     * re=
ceive loop below discard any unrelated or spoofed message=2E
      */
-    =
payload->nlmsg_seq =3D (uint32_t)time(NULL);
+    static uint32_t sitnl_seq=
;
+    if (!sitnl_seq)
+    {
+        sitnl_seq =3D (uint32_t)time(NULL);
=
+    }
+    payload->nlmsg_seq =3D ++sitnl_seq;
 
     /* no need to send r=
eply */
     if (!cb)
@@ -283,7 +298,7 @@
         return -errno;
     }
 
=
-    if (sitnl_bind(fd, 0) < 0)
+    if (sitnl_bind(fd, 0, &local_pid) < 0)=

     {
         msg(M_WARN | M_ERRNO, "%s: can't bind rtnl socket", __func=
__);
         ret =3D -errno;
@@ -357,18 +372,23 @@
                 goto o=
ut;
             }
 
-            /*            if (((int)nladdr=2Enl_pid !=
=3D peer) || (h->nlmsg_pid !=3D nladdr=2Enl_pid)
-             *           =
    || (h->nlmsg_seq !=3D seq))
-             *           {
-             *=
               rcv_len -=3D NLMSG_ALIGN(len);
-             *              =
 h =3D (struct nlmsghdr *)((char *)h + NLMSG_ALIGN(len));
-             *  =
             msg(M_DEBUG, "%s: skipping unrelated message=2E nl_pid:%d (pee=
r:%d)
-             * nl_msg_pid:%d nl_seq:%d seq:%d",
-             *     =
              __func__, (int)nladdr=2Enl_pid, peer, h->nlmsg_pid,
-        =
     *                   h->nlmsg_seq, seq);
-             *               =
continue;
-             *           }
+            /* Discard any message t=
hat did not come from the kernel or does
+             * not match the requ=
est we sent: only the kernel (nl_pid 0) can
+             * legitimately re=
ply, and a valid reply echoes our port id and
+             * sequence numb=
er=2E This prevents a local process from injecting a
+             * spoofe=
d reply that the callback would otherwise act on=2E
              */
+     =
       if ((nladdr=2Enl_pid !=3D 0) || (h->nlmsg_pid !=3D local_pid)
+     =
           || (h->nlmsg_seq !=3D payload->nlmsg_seq))
+            {
+     =
           msg(D_RTNL,
+                    "%s: skipping unrelated message=
=2E nl_pid:%u nlmsg_pid:%u (local:%u) nlmsg_seq:%u (seq:%u)",
+            =
        __func__, nladdr=2Enl_pid, h->nlmsg_pid, local_pid, h->nlmsg_seq,
+=
                    payload->nlmsg_seq);
+                rcv_len -=3D NLMS=
G_ALIGN(len);
+                h =3D (struct nlmsghdr *)((char *)h + NLMSG_=
ALIGN(len));
+                continue;
+            }
 
             if (h=
->nlmsg_type =3D=3D NLMSG_DONE)
             {

-- 
To view, visit http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1782?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7
Gerrit-=
Change-Number: 1782
Gerrit-PatchSet: 4
Gerrit-Owner: ordex <antonio@mandelb=
it=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Re=
viewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>

--rTf6KBCN8E4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1782?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">networking_sitnl: validate netlink replies=
 against the request<br><br>sitnl_send() passed every well-formed reply to =
the callback without<br>checking it matched the outstanding request: the se=
q/pid check was<br>commented out and the sequence number came from time(NUL=
L)=2E<br><br>Seed a monotonically increasing sequence number and drop any m=
essage<br>that is not from the kernel (nl_pid 0) or does not echo our port =
id and<br>sequence number=2E<br><br>Change-Id: Ie7352dd136cccda2bd6b6e1a36d=
b1a5f27afd8f7<br>GitHub: fixes OpenVPN/openvpn-private-issues#9<br>Reported=
-by: Joshua Rogers &lt;contact@joshua=2Ehu&gt;<br>Found-By: ZeroPath (https=
://zeropath=2Ecom)<br>Signed-off-by: Antonio Quartulli &lt;antonio@mandelbi=
t=2Ecom&gt;<br>Acked-by: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt;<br>Gerrit U=
RL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1782<br>Message-Id: &lt;2026=
0901151017=2E16221-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email=
-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38879=2Ehtml<br>S=
igned-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/=
openvpn/networking_sitnl=2Ec<br>1 file changed, 37 insertions(+), 17 deleti=
ons(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/src/openvpn/networking_sitnl=2Ec b/src=
/openvpn/networking_sitnl=2Ec</span><br><span>index e6e72d0=2E=2Ea396255 10=
0644</span><br><span>--- a/src/openvpn/networking_sitnl=2Ec</span><br><span=
>+++ b/src/openvpn/networking_sitnl=2Ec</span><br><span>@@ -197,7 +197,7 @@=
</span><br><span>  * Bind socket to Netlink subsystem</span><br><span>  */<=
/span><br><span> static int</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-sitnl_bind(int fd, uint32_t groups)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+sitnl_bind(int fd, uint32_t groups, uint32_t *local_p=
id)</span><br><span> {</span><br><span>     socklen_t addr_len;</span><br><=
span>     struct sockaddr_nl local;</span><br><span>@@ -232,6 +232,14 @@</s=
pan><br><span>         return -EINVAL;</span><br><span>     }</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* We bound=
 with nl_pid=3D0, so the kernel assigned this socket a unique port</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * id (it is not the pro=
cess pid - a process may own several netlink</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * sockets)=2E getsockname() above is the only=
 way to learn it: hand it back</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * to the caller, which uses it to check that replies are ad=
dressed to this</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * socket=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *local_pid =3D =
local=2Enl_pid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span>     return 0;</span><br><span> }</span><br><span> </span><br>=
<span>@@ -243,6 +251,7 @@</span><br><span>            void *arg_cb)</span><=
br><span> {</span><br><span>     int fd, ret;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    uint32_t local_pid =3D 0;</span><br><span>   =
  struct sockaddr_nl nladdr;</span><br><span>     struct nlmsgerr *err;</sp=
an><br><span>     struct nlmsghdr *h;</span><br><span>@@ -264,11 +273,17 @@=
</span><br><span>     nladdr=2Enl_pid =3D peer;</span><br><span>     nladdr=
=2Enl_groups =3D groups;</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    /* NB: We currently do not verify seq and pid on a=
nswers=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * If we=
 ever want to start with that we probably need to come up</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-     * with something better than &quot=
;seconds since epoch&quot;=2E=2E=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* Match replies to requests with a monotonically incre=
asing sequence</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* number, seeded once from wall-clock time so it differs between runs=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * The kernel echo=
es this seq (and our port id) in its replies, letting the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * receive loop below discard any=
 unrelated or spoofed message=2E</span><br><span>      */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    payload-&gt;nlmsg_seq =3D (uint32_t=
)time(NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sta=
tic uint32_t sitnl_seq;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (!sitnl_seq)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        si=
tnl_seq =3D (uint32_t)time(NULL);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    payload-&gt;nlmsg_seq =3D ++sitnl_seq;</span><br><span> </span><br><spa=
n>     /* no need to send reply */</span><br><span>     if (!cb)</span><br>=
<span>@@ -283,7 +298,7 @@</span><br><span>         return -errno;</span><br=
><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    if (sitnl_bind(fd, 0) &lt; 0)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (sitnl_bind(fd, 0, &amp;local_pid) &lt; 0)</=
span><br><span>     {</span><br><span>         msg(M_WARN | M_ERRNO, &quot;=
%s: can&#39;t bind rtnl socket&quot;, __func__);</span><br><span>         r=
et =3D -errno;</span><br><span>@@ -357,18 +372,23 @@</span><br><span>      =
           goto out;</span><br><span>             }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            /*            i=
f (((int)nladdr=2Enl_pid !=3D peer) || (h-&gt;nlmsg_pid !=3D nladdr=2Enl_pi=
d)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             *     =
          || (h-&gt;nlmsg_seq !=3D seq))</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-             *           {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-             *               rcv_len -=3D NLMSG_ALI=
GN(len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
*               h =3D (struct nlmsghdr *)((char *)h + NLMSG_ALIGN(len));</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-             *          =
     msg(M_DEBUG, &quot;%s: skipping unrelated message=2E nl_pid:%d (peer:%=
d)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             * nl_m=
sg_pid:%d nl_seq:%d seq:%d&quot;,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-             *                   __func__, (int)nladdr=2Enl_pid=
, peer, h-&gt;nlmsg_pid,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-             *                   h-&gt;nlmsg_seq, seq);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-             *               continue;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             *       =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /*=
 Discard any message that did not come from the kernel or does</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+             * not match the req=
uest we sent: only the kernel (nl_pid 0) can</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+             * legitimately reply, and a valid rep=
ly echoes our port id and</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+             * sequence number=2E This prevents a local process from =
injecting a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
     * spoofed reply that the callback would otherwise act on=2E</span><br>=
<span>              */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            if ((nladdr=2Enl_pid !=3D 0) || (h-&gt;nlmsg_pid !=3D local_=
pid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 || (h-&gt;nlmsg_seq !=3D payload-&gt;nlmsg_seq))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                msg(D_RTNL,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    &quot;%s: skipping un=
related message=2E nl_pid:%u nlmsg_pid:%u (local:%u) nlmsg_seq:%u (seq:%u)&=
quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       __func__, nladdr=2Enl_pid, h-&gt;nlmsg_pid, local_pid, h-&gt;nlmsg_s=
eq,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
    payload-&gt;nlmsg_seq);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                rcv_len -=3D NLMSG_ALIGN(len);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                h =3D (struct nlmsghdr *=
)((char *)h + NLMSG_ALIGN(len));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                continue;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            }</span><br><span> </span><br><span>        =
     if (h-&gt;nlmsg_type =3D=3D NLMSG_DONE)</span><br><span>             {=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1782?usp=3Demail">change 1782</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1782?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:non=
e"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie7352dd136cccda2bd6b6=
e1a36db1a5f27afd8f7 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1782 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div =
style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>

</body></html>
--rTf6KBCN8E4=--


--===============5033095520358846684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5033095520358846684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5033095520358846684==--

