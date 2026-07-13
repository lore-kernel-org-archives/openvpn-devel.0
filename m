Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484C4C43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 13 Jul 2026 21:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=xekoO/wj8ETAvo80m80c1QrGmY43s8VwFgJJ4aDBu3Y=; b=fcx4cUQjI2FDPZ
	gk3TeTV3JGyuQ18+py/277NTdbAaPg1zXGQ9n+bz5sAuFRIshqP//VKnUNJGMl1Q4F0qBwhsGSOeP
	+JMQ2rvP5csIfxZq+/OfNDmP7TxNnbfMM3XA216p+qeR6yGBLmv3wkaw9g3i5kqfEKX740nTduX9/
	h5M=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjO6b-0008R8-Ke;
	Mon, 13 Jul 2026 21:22:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjO6Z-0008R2-DJ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 21:22:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JX2eCV0zYXRm9njiYRcJkAbLQCYl2ablqKt5R4Xb/GQ=; b=d5qmkzHnED2MG8J9ggb9b22U0A
 FGTh3aNtpkwL3EA12X1Zrrl4Rq/ovDsR75YmOkuqet8cpotTXK1kTyTsAX7iinpj5Ep7VzdRhhNtD
 J6aj+FQFXmIhbML4D4qwBW4Gi9p7J1Dpw/8ODNQSe2NcR2dv7waCejwe9FUWa6SSUhkY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JX2eCV0zYXRm9njiYRcJkAbLQCYl2ablqKt5R4Xb/GQ=; b=K
 OywbMfhROKKCeIO1yqf9oC0sxZeu5MANS49X1u2MyRo8UTX3BryJBshaF4vit7LiLY/IVM616gAgy
 f7ScDgaWkja33Cwlrv4cQu8l9xajqx9m/Vgsvejwf7Z6deHm901FBRK/Ij/Ke+XhxP2eejqzOCoYm
 wOikyc36rBCNciz8=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjO6X-0004OY-8F for openvpn-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 21:22:23 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-493f0ae9572so14643375e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 13 Jul 2026 14:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783977730; x=1784582530; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JX2eCV0zYXRm9njiYRcJkAbLQCYl2ablqKt5R4Xb/GQ=;
 b=XuBnTV3AcuiyD95xxi0d3oolyHq/wLY4rLel5Rd8l+xRnltdX9+8akqM6R4Pl4IPun
 uZPEyg5xfHgis9kBK5XNDlhrUKG72BRSW75O6kQugAqPnPQuLNedPq+CThJRQl125A0n
 v0DiJ+7g4D0idryC+CjBDnRzA/rEBeaVswX+310HJblwfbDJGkqmDo1itvDSbKCduE/o
 XaIyHAOO16L7bwlQ8nILn/2folBxd6O//0q3woWDrWtheOhs45aZv+293iEa9AoPPnxo
 ouPmHA+8GUq43rHvDxqMm5C9ONoe7SZycxq2dlF4o1DaAIuL9dm0jWWYdSLEH+DPDlfa
 5XKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783977730; x=1784582530;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JX2eCV0zYXRm9njiYRcJkAbLQCYl2ablqKt5R4Xb/GQ=;
 b=n9J0NE0q9l1cH++8lO6MG6HpbOCHe/djbWyQ0EzAtJ0ZFfjM7G/SAcWlVNKqeJT3+z
 9W2RYYTm6bE7R/ueHg+HHLmfq3/iCINFQq64Tkwb/997HjF2+5Z0Oti2iaQgFHMInV35
 FKNsET9xb7EPOpfabMMX3gRcdicl+H7ojV2AijQkzOTmnhadVdk+juaY58ISdtk1vFLB
 29hpONm/SFSyVzmAbqSaDpr9ViRJVEGAKJjSKBnjIlnx3zBr12bvKqCIBfCDY1Yf8ini
 jyDzu4cfhk8weUhqKOjACa696LnoY/pdxB/ZWY2AaFEidCCyzAaU7dBTl5VOHm9vCXy6
 VaCw==
X-Gm-Message-State: AOJu0Yws1nJwB8XMm1g9jJExStksaxpqW3paOPvFAoTeznarRoGVZsmq
 01yuFCR0O9n6i6lZeFycuCncJ+s1tNR1i25SOxEQFxiWxHYf8pmACEGsQQUIA+Z9lmLLBfDh++C
 96p1gDHFyuDJhaR/vAsD0cko038+jShv8L4mRz17Ns7GAt9r44E1Bmoq9dSZat7YkLDW80DG1u5
 f6nkqAig==
X-Gm-Gg: AfdE7cmlR+huAyAXk0gaOMF1flVN45khUfFO+LVRH9V2k04dUvz2uFZmTY+FR/Iy6ps
 oE/qBv3XgZEJzcQOBALAvapOW96zfZDMr97BvCY9IdkOkw7fB4DicLLM0DqAgZnut72K1TKi0LM
 HmRrW1vrTOB52TgN4cGdcmcos/3Pckp1g5Dca8GmX21Y+N65S70EsRDGdieAQICfFP2KrjXWs/b
 DhSvDt6JM1ayTRI5EbwytK25xAWfUFvPg8X9kRwq0wdOdAN6onmK++qciMGVn+DwVDyTWFfk7kq
 t7Vdsg0YC+vA53OhJ3nt9UM5IYzuXzByVIN5D5Mb73Kdoz7t6aYZKFiJe11mefIPmoF8iNBM/uz
 LSJJCR1TtOib/ItAthJrH3awXnJLddgymObEngQgIEMCCnlhJMaOHlV/s3L0co/+RjvtSRzNG3/
 NNXXphAr/0Og3ehZMmq67umiVdh8gbOxQCIQJyt+4CEKGjhMnoXfjpveU+POz+mBxlwmVSgaH3t
 i2SfMTFcaCSghVoI4bVSXVqzdfTn4ESMwiGsB0kjGQ2v2umAHxgfezNRbnTqFHS0SN8RhCumHpr
 m3cfg5HVFgKhzw==
X-Received: by 2002:a05:600c:8b35:b0:493:bb6b:5bb5 with SMTP id
 5b1f17b1804b1-493f87ebd6cmr115164915e9.13.1783977729558; 
 Mon, 13 Jul 2026 14:22:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464a96cfsm2645385f8f.20.2026.07.13.14.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 14:22:08 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 13 Jul 2026 21:22:08 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7
X-Gerrit-Change-Number: 1782
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1782?usp=email>
X-Gerrit-Commit: 5c717bb8efc141e6f2354a4bf5cea832f94e43eb
References: <gerrit.1783977723000.Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTc3NzIzMDAwLkllNzM1MmRkMTM2Y2NjZGEyYmQ2YjZlMWEzNmRiMWE1ZjI3YWZkOGY3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1edc4c39dc3f9876bba7b3b9bf6c8127d4eb7594-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjO6X-0004OY-8F
Subject: [Openvpn-devel] [S] Change in openvpn[master]: networking_sitnl:
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6979748465739031095=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6979748465739031095==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="E8T0rMFDVgw="; charset=UTF-8

--E8T0rMFDVgw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1782?usp=3Demail

to review the following change=2E


Chang=
e subject: networking_sitnl: validate netlink replies against the request
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

networking_si=
tnl: validate netlink replies against the request

sitnl_send() passed ever=
y well-formed reply to the callback without
checking it matched the outstan=
ding request: the seq/pid check was
commented out and the sequence number c=
ame from time(NULL)=2E

Seed a monotonically increasing sequence number and=
 drop any message
that is not from the kernel (nl_pid 0) or does not echo o=
ur port id and
sequence number=2E

Change-Id: Ie7352dd136cccda2bd6b6e1a36db=
1a5f27afd8f7
GitHub: fixes OpenVPN/openvpn-private-issues#9
Signed-off-by: =
Antonio Quartulli <antonio@mandelbit=2Ecom>
---
M src/openvpn/networking_si=
tnl=2Ec
1 file changed, 30 insertions(+), 17 deletions(-)



  git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/82/1782/1

diff --git =
a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec
index=
 b3f8e2b=2E=2E3c03315 100644
--- a/src/openvpn/networking_sitnl=2Ec
+++ b/s=
rc/openvpn/networking_sitnl=2Ec
@@ -197,7 +197,7 @@
  * Bind socket to Netl=
ink subsystem
  */
 static int
-sitnl_bind(int fd, uint32_t groups)
+sitnl_=
bind(int fd, uint32_t groups, uint32_t *local_pid)
 {
     socklen_t addr_l=
en;
     struct sockaddr_nl local;
@@ -232,6 +232,8 @@
         return -EIN=
VAL;
     }
 
+    *local_pid =3D local=2Enl_pid;
+
     return 0;
 }
 
@@ =
-243,6 +245,7 @@
            void *arg_cb)
 {
     int fd, ret;
+    uint32=
_t local_pid =3D 0;
     struct sockaddr_nl nladdr;
     struct nlmsgerr *e=
rr;
     struct nlmsghdr *h;
@@ -264,11 +267,17 @@
     nladdr=2Enl_pid =3D=
 peer;
     nladdr=2Enl_groups =3D groups;
 
-    /* NB: We currently do no=
t verify seq and pid on answers=2E
-     * If we ever want to start with th=
at we probably need to come up
-     * with something better than "seconds =
since epoch"=2E=2E=2E
+    /* Match replies to requests with a monotonicall=
y increasing sequence
+     * number, seeded once from wall-clock time so i=
t differs between runs=2E
+     * The kernel echoes this seq (and our port =
id) in its replies, letting the
+     * receive loop below discard any unre=
lated or spoofed message=2E
      */
-    payload->nlmsg_seq =3D (uint32_t)=
time(NULL);
+    static uint32_t sitnl_seq;
+    if (!sitnl_seq)
+    {
+  =
      sitnl_seq =3D (uint32_t)time(NULL);
+    }
+    uint32_t seq =3D payl=
oad->nlmsg_seq =3D ++sitnl_seq;
 
     /* no need to send reply */
     if =
(!cb)
@@ -283,7 +292,7 @@
         return -errno;
     }
 
-    if (sitnl_b=
ind(fd, 0) < 0)
+    if (sitnl_bind(fd, 0, &local_pid) < 0)
     {
        =
 msg(M_WARN | M_ERRNO, "%s: can't bind rtnl socket", __func__);
         re=
t =3D -errno;
@@ -357,18 +366,22 @@
                 goto out;
            =
 }
 
-            /*            if (((int)nladdr=2Enl_pid !=3D peer) || (h-=
>nlmsg_pid !=3D nladdr=2Enl_pid)
-             *               || (h->nlmsg=
_seq !=3D seq))
-             *           {
-             *               r=
cv_len -=3D NLMSG_ALIGN(len);
-             *               h =3D (struct n=
lmsghdr *)((char *)h + NLMSG_ALIGN(len));
-             *               msg=
(M_DEBUG, "%s: skipping unrelated message=2E nl_pid:%d (peer:%d)
-         =
    * nl_msg_pid:%d nl_seq:%d seq:%d",
-             *                   __=
func__, (int)nladdr=2Enl_pid, peer, h->nlmsg_pid,
-             *          =
         h->nlmsg_seq, seq);
-             *               continue;
-     =
        *           }
+            /* Discard any message that did not come=
 from the kernel or does
+             * not match the request we sent: onl=
y the kernel (nl_pid 0) can
+             * legitimately reply, and a valid=
 reply echoes our port id and
+             * sequence number=2E This preve=
nts a local process from injecting a
+             * spoofed reply that the=
 callback would otherwise act on=2E
              */
+            if ((nlad=
dr=2Enl_pid !=3D 0) || (h->nlmsg_pid !=3D local_pid)
+                || (h=
->nlmsg_seq !=3D seq))
+            {
+                msg(D_RTNL,
+       =
             "%s: skipping unrelated message=2E nl_pid:%u nlmsg_pid:%u (loc=
al:%u) nlmsg_seq:%u (seq:%u)",
+                    __func__, nladdr=2Enl_p=
id, h->nlmsg_pid, local_pid, h->nlmsg_seq, seq);
+                rcv_len -=
=3D NLMSG_ALIGN(len);
+                h =3D (struct nlmsghdr *)((char *)h =
+ NLMSG_ALIGN(len));
+                continue;
+            }
 
          =
   if (h->nlmsg_type =3D=3D NLMSG_DONE)
             {

-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1782?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8=
f7
Gerrit-Change-Number: 1782
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <anton=
io@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-=
Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--E8T0rMFDVgw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ordex would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1782?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">ne=
tworking_sitnl: validate netlink replies against the request<br><br>sitnl_s=
end() passed every well-formed reply to the callback without<br>checking it=
 matched the outstanding request: the seq/pid check was<br>commented out an=
d the sequence number came from time(NULL)=2E<br><br>Seed a monotonically i=
ncreasing sequence number and drop any message<br>that is not from the kern=
el (nl_pid 0) or does not echo our port id and<br>sequence number=2E<br><br=
>Change-Id: Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7<br>GitHub: fixes Open=
VPN/openvpn-private-issues#9<br>Signed-off-by: Antonio Quartulli &lt;antoni=
o@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/networking_sitnl=2Ec<br>1 fil=
e changed, 30 insertions(+), 17 deletions(-)<br><br></pre><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/82/1782/1</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/networking=
_sitnl=2Ec</span><br><span>index b3f8e2b=2E=2E3c03315 100644</span><br><spa=
n>--- a/src/openvpn/networking_sitnl=2Ec</span><br><span>+++ b/src/openvpn/=
networking_sitnl=2Ec</span><br><span>@@ -197,7 +197,7 @@</span><br><span>  =
* Bind socket to Netlink subsystem</span><br><span>  */</span><br><span> st=
atic int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_bind(in=
t fd, uint32_t groups)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+sitnl_bind(int fd, uint32_t groups, uint32_t *local_pid)</span><br><span=
> {</span><br><span>     socklen_t addr_len;</span><br><span>     struct so=
ckaddr_nl local;</span><br><span>@@ -232,6 +232,8 @@</span><br><span>      =
   return -EINVAL;</span><br><span>     }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    *local_pid =3D local=2Enl_pid;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   =
  return 0;</span><br><span> }</span><br><span> </span><br><span>@@ -243,6 =
+245,7 @@</span><br><span>            void *arg_cb)</span><br><span> {</spa=
n><br><span>     int fd, ret;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    uint32_t local_pid =3D 0;</span><br><span>     struct sockadd=
r_nl nladdr;</span><br><span>     struct nlmsgerr *err;</span><br><span>   =
  struct nlmsghdr *h;</span><br><span>@@ -264,11 +267,17 @@</span><br><span=
>     nladdr=2Enl_pid =3D peer;</span><br><span>     nladdr=2Enl_groups =3D=
 groups;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    /* NB: We currently do not verify seq and pid on answers=2E</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-     * If we ever want to st=
art with that we probably need to come up</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-     * with something better than &quot;seconds since e=
poch&quot;=2E=2E=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* Match replies to requests with a monotonically increasing sequence</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * number, seeded=
 once from wall-clock time so it differs between runs=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * The kernel echoes this seq (and=
 our port id) in its replies, letting the</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * receive loop below discard any unrelated or sp=
oofed message=2E</span><br><span>      */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    payload-&gt;nlmsg_seq =3D (uint32_t)time(NULL);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    static uint32_t sit=
nl_seq;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!sit=
nl_seq)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        sitnl_seq =3D (uin=
t32_t)time(NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t seq=
 =3D payload-&gt;nlmsg_seq =3D ++sitnl_seq;</span><br><span> </span><br><sp=
an>     /* no need to send reply */</span><br><span>     if (!cb)</span><br=
><span>@@ -283,7 +292,7 @@</span><br><span>         return -errno;</span><b=
r><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (sitnl_bind(fd, 0) &lt; 0)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (sitnl_bind(fd, 0, &amp;local_pid) &lt; 0)<=
/span><br><span>     {</span><br><span>         msg(M_WARN | M_ERRNO, &quot=
;%s: can&#39;t bind rtnl socket&quot;, __func__);</span><br><span>         =
ret =3D -errno;</span><br><span>@@ -357,18 +366,22 @@</span><br><span>     =
            goto out;</span><br><span>             }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            /*            =
if (((int)nladdr=2Enl_pid !=3D peer) || (h-&gt;nlmsg_pid !=3D nladdr=2Enl_p=
id)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             *    =
           || (h-&gt;nlmsg_seq !=3D seq))</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-             *           {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-             *               rcv_len -=3D NLMSG_AL=
IGN(len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
 *               h =3D (struct nlmsghdr *)((char *)h + NLMSG_ALIGN(len));</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-             *         =
      msg(M_DEBUG, &quot;%s: skipping unrelated message=2E nl_pid:%d (peer:=
%d)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             * nl_=
msg_pid:%d nl_seq:%d seq:%d&quot;,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-             *                   __func__, (int)nladdr=2Enl_pi=
d, peer, h-&gt;nlmsg_pid,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-             *                   h-&gt;nlmsg_seq, seq);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-             *               continue=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             *      =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /=
* Discard any message that did not come from the kernel or does</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+             * not match the re=
quest we sent: only the kernel (nl_pid 0) can</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+             * legitimately reply, and a valid re=
ply echoes our port id and</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+             * sequence number=2E This prevents a local process from=
 injecting a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
      * spoofed reply that the callback would otherwise act on=2E</span><br=
><span>              */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            if ((nladdr=2Enl_pid !=3D 0) || (h-&gt;nlmsg_pid !=3D local=
_pid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  || (h-&gt;nlmsg_seq !=3D seq))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                msg(D_RTNL,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                    &quot;%s: skipping unrelated message=2E =
nl_pid:%u nlmsg_pid:%u (local:%u) nlmsg_seq:%u (seq:%u)&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    __func__, nl=
addr=2Enl_pid, h-&gt;nlmsg_pid, local_pid, h-&gt;nlmsg_seq, seq);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                rcv_len -=3D =
NLMSG_ALIGN(len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              h =3D (struct nlmsghdr *)((char *)h + NLMSG_ALIGN(len));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                continue=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</spa=
n><br><span> </span><br><span>             if (h-&gt;nlmsg_type =3D=3D NLMS=
G_DONE)</span><br><span>             {</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1782?us=
p=3Demail">change 1782</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1782?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </d=
iv>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1782 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--E8T0rMFDVgw=--


--===============6979748465739031095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6979748465739031095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6979748465739031095==--

