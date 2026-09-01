Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3400C624D3
	for <openvpn-devel@archiver.kernel.org>; Tue,  1 Sep 2026 14:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GpOg3NAfHUYzPgUk3+NSZ8Tbx6tQ56ntH/d5muwuCUk=; b=O7cDk6I3EZTFGZD0e0RCjr+Kyl
	o/No4n/cl5lx3dTDE7hv2/Cjevqw3jLal7YGRWh3YsKfFOR07P/hSpcYquTps9j/ytexSpzgdIKlz
	alz1pPcCesKkeXtUmpe0fNucUU9be0uP8LbF/kNPa0dld+qBis5XP9iyyomz8NyP6Wug=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1Plr-0002ZN-Bd;
	Tue, 01 Sep 2026 14:47:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1PlZ-0002Yi-EL
 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 14:47:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=h09aMnGDV9xrtUNZv++J3hz0CcQPhQrnJeVGS9EknCY=; b=UzKQTkgaTL2izX8xzki9Zd/TgZ
 brTBvjOaJrCkHMzbdJGspsViF0hWQ+qAZbHxoSonmXm2dsLCdBpFa3DcKWBjrY/wryfzKYKceA2l0
 l1UvkKRC8DNiI72CSIYyQFx7zjChHsQmM840s9v+cxIUSKGC0ag/Y3fzZ14PdhPYYwgE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=h09aMnGDV9xrtUNZv++J3hz0CcQPhQrnJeVGS9EknCY=; b=f
 /QyLrvNyavGmMJNVUwxqwaNYRJkhQl6MOmP+9dioibzW6ifws8/kTz3L+jPZrTcOSRq4caVHs/+E9
 Tm7oT9RgbI5rBoZ2/BfZgfVoZ2YoaXtvxjuLglYZ7tzEyl/mQQQzKJz94BqEWV8YgP/5z+IC04n5N
 +wrkHln8i+2qZvrs=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1PlJ-0004Iu-LJ for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 14:46:58 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so979840f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 07:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788274011; x=1788878811; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=h09aMnGDV9xrtUNZv++J3hz0CcQPhQrnJeVGS9EknCY=;
 b=VdTQwiCFjdS+e9FhOAilLzS3/sXFr2E3EV/oZVST9OlaZnWS0EEQBZM9AybNRmDVt8
 oalT0AILgrFG9vKU4KA6TMW2uYabz+5oIQyWcPxIcBVHYvXDjCfB7q6l980lvBqIRhOC
 UeS45tkpQMc/S1n0zoUQ5ClwFxZoUGgWbX1PxtfkhUvkX4mou3cI9lV+DLgp04BuhW8+
 cgxVktHgLW6LkieBi6lAf2z++TdpVNWTXgV9F7UpREzGT96TyXlxjyDzOyH3SvTnazPk
 XlzjyvOcjImZj0hBtn/AAe8Zvzvo7kQB3yzV+dS7dDL4jtNF/e8pvZgOdDY1KjhNHsnl
 XTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788274011; x=1788878811;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=h09aMnGDV9xrtUNZv++J3hz0CcQPhQrnJeVGS9EknCY=;
 b=ALB95d3m/bgU7fedBBFRwahGcph1jkQlaI+hOU0h4o+wLPRqAHqGayc9HBArYAZ5G0
 31NV9NGaSIMtGiE1t0J9tJb03/PaHrNVyd6wjiEJ4I2ZoBj86lS/rZdrtzNfG/2WHmdh
 7yz3OCQTpDoHKiBu9z71aZwXGGOjSByo6gk2lqDmNMeqMDYCdZm8XL44HjqTaNto2Tox
 Y2Mpu6y7uGxqf5MwkmuvlP/lhEE6UwxPXbQsTrlk8s0A3teS/MwrWtbTqnfqv/C8+HfV
 m85x/twwbhFAMAip1As5hZPs4tKmW4DOdrPzF90uLb4ShJrRpDAE5hmwiZfmrHZCmkJR
 fOfQ==
X-Gm-Message-State: AFuF++kOs6BzPE0syr1XqRh1HRDuCXkNfA04sy6iz716GlGMWdVeb9n6
 AgVhSuv0Jkvw3qEarQJDqzJqk2gTA+bJFM0RYr2EvIho8WSqBnLuGy77QfVeUouERcmbZy6T5H7
 jR4kQYk7lkevqIGqLPEkHMcE7jYA2GN/T1HTsBsMmI2rpUAyIvhdAL4wLPG8LZEjKThm0
X-Gm-Gg: AYBFou2vCBdJrWSR9H4SIHCM3rLCm4+7tydoutZI/LUMmMft4vj1LNzJ2DoomLNBEsy
 iG3uGMOn5IG6L+l/c++M4D5VJ/CgVDPbLJEQmYmkCrro/3/shb7B+xL7btbOmAIJtGovee8Da0O
 4jYNPOL8TwBIWPa5xd1mptXzlPbEPwZVEa6jjlS/Np0Nqu3fsOmMfJdDnLfaBYYV1nibd3+1Ki5
 LmGRQdpOvjigs8uCSD88zfmxHe/M0G+u8jxO5MimyJZTxTvYbpys2Qad7qgTupiekocoidgxUhe
 09hvC72EHYZQQDDqANNfC5+pQc7XxxMAxnD4AgsP5eY9mSY2FCD+PGrNBLh+8SgL47WxE6nBEJp
 vhLBkbFNwqrZ90ElAC2w21Lp0/hBlvOzYkOuNPZKsyTCn5+KCZb8/7ixUGaIeIEPdqr58wLJc91
 3CR10mB/buPgDgBnlccXNFCjbO7pGgEC7ewwmvvzS3rqa5QcxM6Gd+LRsq/217+IT0wrQQyDV0n
 BTBMZNLqZB8WtMgharwb99fP0CoTCAwSnqGsvGXLfDHfABN8l7pGoLYl4URpBCCGr40dDqYD6ht
 X5vrChtYGNt4IcCSD+Eo93139Jd3Ifwe8zztVM80afzheB7IAFh7ou9b9RB7qA==
X-Received: by 2002:a05:6000:2f8a:b0:47f:90df:4ec6 with SMTP id
 ffacd0b85a97d-482f7984d67mr49238286f8f.6.1788274010848; 
 Tue, 01 Sep 2026 07:46:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48442d7e452sm5044264f8f.35.2026.09.01.07.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 07:46:50 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 1 Sep 2026 14:46:49 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7
X-Gerrit-Change-Number: 1782
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1782?usp=email>
X-Gerrit-Commit: 2d51d6444e7d1fb73223752b9031a79006ee62ab
In-Reply-To: <gerrit.1783977723000.Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7@gerrit.openvpn.net>
References: <gerrit.1783977723000.Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTc3NzIzMDAwLkllNzM1MmRkMTM2Y2NjZGEyYmQ2YjZlMWEzNmRiMWE1ZjI3YWZkOGY3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <953df0452863bff1cabcf4e50bec7bdae89a24ca-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1PlJ-0004Iu-LJ
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2323904879830743429=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2323904879830743429==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="H3i3CdjVNoc="; charset=UTF-8

--H3i3CdjVNoc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos, ralf_lici=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1782?usp=3Demail

to look a=
t the new patch set (#3)=2E

The following approvals got outdated and were =
removed:
Code-Review+2 by ralf_lici

The change is no longer submittable: C=
ode-Review and checks~ChecksSubmitRule are unsatisfied now=2E


Change subj=
ect: networking_sitnl: validate netlink replies against the request
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

networking_sitnl: v=
alidate netlink replies against the request

sitnl_send() passed every well=
-formed reply to the callback without
checking it matched the outstanding r=
equest: the seq/pid check was
commented out and the sequence number came fr=
om time(NULL)=2E

Seed a monotonically increasing sequence number and drop =
any message
that is not from the kernel (nl_pid 0) or does not echo our por=
t id and
sequence number=2E

Change-Id: Ie7352dd136cccda2bd6b6e1a36db1a5f27=
afd8f7
GitHub: fixes OpenVPN/openvpn-private-issues#9
Signed-off-by: Antoni=
o Quartulli <antonio@mandelbit=2Ecom>
---
M src/openvpn/networking_sitnl=2E=
c
1 file changed, 37 insertions(+), 17 deletions(-)


  git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/82/1782/3

diff --git a/src/o=
penvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec
index e6e72d=
0=2E=2Ea396255 100644
--- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/open=
vpn/networking_sitnl=2Ec
@@ -197,7 +197,7 @@
  * Bind socket to Netlink sub=
system
  */
 static int
-sitnl_bind(int fd, uint32_t groups)
+sitnl_bind(in=
t fd, uint32_t groups, uint32_t *local_pid)
 {
     socklen_t addr_len;
   =
  struct sockaddr_nl local;
@@ -232,6 +232,14 @@
         return -EINVAL;
 =
    }
 
+    /* We bound with nl_pid=3D0, so the kernel assigned this socke=
t a unique port
+     * id (it is not the process pid - a process may own s=
everal netlink
+     * sockets)=2E getsockname() above is the only way to l=
earn it: hand it back
+     * to the caller, which uses it to check that re=
plies are addressed to this
+     * socket=2E
+     */
+    *local_pid =3D =
local=2Enl_pid;
+
     return 0;
 }
 
@@ -243,6 +251,7 @@
            void =
*arg_cb)
 {
     int fd, ret;
+    uint32_t local_pid =3D 0;
     struct so=
ckaddr_nl nladdr;
     struct nlmsgerr *err;
     struct nlmsghdr *h;
@@ -2=
64,11 +273,17 @@
     nladdr=2Enl_pid =3D peer;
     nladdr=2Enl_groups =3D=
 groups;
 
-    /* NB: We currently do not verify seq and pid on answers=2E=

-     * If we ever want to start with that we probably need to come up
-  =
   * with something better than "seconds since epoch"=2E=2E=2E
+    /* Matc=
h replies to requests with a monotonically increasing sequence
+     * numb=
er, seeded once from wall-clock time so it differs between runs=2E
+     * =
The kernel echoes this seq (and our port id) in its replies, letting the
+ =
    * receive loop below discard any unrelated or spoofed message=2E
      =
*/
-    payload->nlmsg_seq =3D (uint32_t)time(NULL);
+    static uint32_t s=
itnl_seq;
+    if (!sitnl_seq)
+    {
+        sitnl_seq =3D (uint32_t)time=
(NULL);
+    }
+    payload->nlmsg_seq =3D ++sitnl_seq;
 
     /* no need t=
o send reply */
     if (!cb)
@@ -283,7 +298,7 @@
         return -errno;
 =
    }
 
-    if (sitnl_bind(fd, 0) < 0)
+    if (sitnl_bind(fd, 0, &local_p=
id) < 0)
     {
         msg(M_WARN | M_ERRNO, "%s: can't bind rtnl socket"=
, __func__);
         ret =3D -errno;
@@ -357,18 +372,23 @@
               =
  goto out;
             }
 
-            /*            if (((int)nladdr=2E=
nl_pid !=3D peer) || (h->nlmsg_pid !=3D nladdr=2Enl_pid)
-             *   =
            || (h->nlmsg_seq !=3D seq))
-             *           {
-      =
       *               rcv_len -=3D NLMSG_ALIGN(len);
-             *      =
         h =3D (struct nlmsghdr *)((char *)h + NLMSG_ALIGN(len));
-        =
     *               msg(M_DEBUG, "%s: skipping unrelated message=2E nl_pid=
:%d (peer:%d)
-             * nl_msg_pid:%d nl_seq:%d seq:%d",
-           =
  *                   __func__, (int)nladdr=2Enl_pid, peer, h->nlmsg_pid,
-=
             *                   h->nlmsg_seq, seq);
-             *       =
        continue;
-             *           }
+            /* Discard any m=
essage that did not come from the kernel or does
+             * not match =
the request we sent: only the kernel (nl_pid 0) can
+             * legitim=
ately reply, and a valid reply echoes our port id and
+             * seque=
nce number=2E This prevents a local process from injecting a
+             =
* spoofed reply that the callback would otherwise act on=2E
              *=
/
+            if ((nladdr=2Enl_pid !=3D 0) || (h->nlmsg_pid !=3D local_pid=
)
+                || (h->nlmsg_seq !=3D payload->nlmsg_seq))
+            =
{
+                msg(D_RTNL,
+                    "%s: skipping unrelated=
 message=2E nl_pid:%u nlmsg_pid:%u (local:%u) nlmsg_seq:%u (seq:%u)",
+    =
                __func__, nladdr=2Enl_pid, h->nlmsg_pid, local_pid, h->nlms=
g_seq,
+                    payload->nlmsg_seq);
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: Ie7352dd136cccda2bd6b6e1a36db1a5f27af=
d8f7
Gerrit-Change-Number: 1782
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <ant=
onio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom=
>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>

--H3i3CdjVNoc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos, ralf_lici=2E </p>
<p>ordex <strong>=
uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1782?usp=3Demail">View Change</a></p><p>Th=
e following approvals got outdated and were removed:
Code-Review+2 by ralf_=
lici</p><p>The change is no longer submittable: Code-Review and checks~Chec=
ksSubmitRule are unsatisfied now=2E</p><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">networking_sitnl: vali=
date netlink replies against the request<br><br>sitnl_send() passed every w=
ell-formed reply to the callback without<br>checking it matched the outstan=
ding request: the seq/pid check was<br>commented out and the sequence numbe=
r came from time(NULL)=2E<br><br>Seed a monotonically increasing sequence n=
umber and drop any message<br>that is not from the kernel (nl_pid 0) or doe=
s not echo our port id and<br>sequence number=2E<br><br>Change-Id: Ie7352dd=
136cccda2bd6b6e1a36db1a5f27afd8f7<br>GitHub: fixes OpenVPN/openvpn-private-=
issues#9<br>Signed-off-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt=
;<br>---<br>M src/openvpn/networking_sitnl=2Ec<br>1 file changed, 37 insert=
ions(+), 17 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/82/1782/3</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec</span><=
br><span>index e6e72d0=2E=2Ea396255 100644</span><br><span>--- a/src/openvp=
n/networking_sitnl=2Ec</span><br><span>+++ b/src/openvpn/networking_sitnl=
=2Ec</span><br><span>@@ -197,7 +197,7 @@</span><br><span>  * Bind socket to=
 Netlink subsystem</span><br><span>  */</span><br><span> static int</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_bind(int fd, uint32_t g=
roups)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_bind(in=
t fd, uint32_t groups, uint32_t *local_pid)</span><br><span> {</span><br><s=
pan>     socklen_t addr_len;</span><br><span>     struct sockaddr_nl local;=
</span><br><span>@@ -232,6 +232,14 @@</span><br><span>         return -EINV=
AL;</span><br><span>     }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* We bound with nl_pid=3D0, so the kernel ass=
igned this socket a unique port</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * id (it is not the process pid - a process may own severa=
l netlink</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * soc=
kets)=2E getsockname() above is the only way to learn it: hand it back</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * to the caller, wh=
ich uses it to check that replies are addressed to this</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * socket=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    *local_pid =3D local=2Enl_pid;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     return 0;</span>=
<br><span> }</span><br><span> </span><br><span>@@ -243,6 +251,7 @@</span><b=
r><span>            void *arg_cb)</span><br><span> {</span><br><span>     i=
nt fd, ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint=
32_t local_pid =3D 0;</span><br><span>     struct sockaddr_nl nladdr;</span=
><br><span>     struct nlmsgerr *err;</span><br><span>     struct nlmsghdr =
*h;</span><br><span>@@ -264,11 +273,17 @@</span><br><span>     nladdr=2Enl_=
pid =3D peer;</span><br><span>     nladdr=2Enl_groups =3D groups;</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* NB: We=
 currently do not verify seq and pid on answers=2E</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-     * If we ever want to start with that we p=
robably need to come up</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-     * with something better than &quot;seconds since epoch&quot;=2E=2E=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Match rep=
lies to requests with a monotonically increasing sequence</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * number, seeded once from wall-=
clock time so it differs between runs=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * The kernel echoes this seq (and our port id) in=
 its replies, letting the</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * receive loop below discard any unrelated or spoofed message=2E=
</span><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    payload-&gt;nlmsg_seq =3D (uint32_t)time(NULL);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    static uint32_t sitnl_seq;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (!sitnl_seq)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        sitnl_seq =3D (uint32_t)time(NULL=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    payload-&gt;nlmsg_seq =3D +=
+sitnl_seq;</span><br><span> </span><br><span>     /* no need to send reply=
 */</span><br><span>     if (!cb)</span><br><span>@@ -283,7 +298,7 @@</span=
><br><span>         return -errno;</span><br><span>     }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (sitnl_bind(fd=
, 0) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(sitnl_bind(fd, 0, &amp;local_pid) &lt; 0)</span><br><span>     {</span><br=
><span>         msg(M_WARN | M_ERRNO, &quot;%s: can&#39;t bind rtnl socket&=
quot;, __func__);</span><br><span>         ret =3D -errno;</span><br><span>=
@@ -357,18 +372,23 @@</span><br><span>                 goto out;</span><br>=
<span>             }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            /*            if (((int)nladdr=2Enl_pid !=3D p=
eer) || (h-&gt;nlmsg_pid !=3D nladdr=2Enl_pid)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-             *               || (h-&gt;nlmsg_seq !=
=3D seq))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
 *           {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
      *               rcv_len -=3D NLMSG_ALIGN(len);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-             *               h =3D (struct =
nlmsghdr *)((char *)h + NLMSG_ALIGN(len));</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-             *               msg(M_DEBUG, &quot;%s: sk=
ipping unrelated message=2E nl_pid:%d (peer:%d)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-             * nl_msg_pid:%d nl_seq:%d seq:%d&quo=
t;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             *    =
               __func__, (int)nladdr=2Enl_pid, peer, h-&gt;nlmsg_pid,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-             *             =
      h-&gt;nlmsg_seq, seq);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-             *               continue;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-             *           }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            /* Discard any message that did =
not come from the kernel or does</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+             * not match the request we sent: only the kernel =
(nl_pid 0) can</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
        * legitimately reply, and a valid reply echoes our port id and</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+             * sequence =
number=2E This prevents a local process from injecting a</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+             * spoofed reply that the =
callback would otherwise act on=2E</span><br><span>              */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            if ((nladdr=2En=
l_pid !=3D 0) || (h-&gt;nlmsg_pid !=3D local_pid)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                || (h-&gt;nlmsg_seq !=3D payl=
oad-&gt;nlmsg_seq))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          msg(D_RTNL,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                    &quot;%s: skipping unrelated message=2E nl_pid:%u nlm=
sg_pid:%u (local:%u) nlmsg_seq:%u (seq:%u)&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                    __func__, nladdr=2Enl_pid=
, h-&gt;nlmsg_pid, local_pid, h-&gt;nlmsg_seq,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                    payload-&gt;nlmsg_seq);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                rcv_len =
-=3D NLMSG_ALIGN(len);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                h =3D (struct nlmsghdr *)((char *)h + NLMSG_ALIGN(len));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                con=
tinue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }=
</span><br><span> </span><br><span>             if (h-&gt;nlmsg_type =3D=3D=
 NLMSG_DONE)</span><br><span>             {</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
82?usp=3Demail">change 1782</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1782?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatch=
set </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 1782 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> G=
errit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mand=
elbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@mand=
elbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_=
lici &lt;ralf@mandelbit=2Ecom&gt; </div>

</body></html>
--H3i3CdjVNoc=--


--===============2323904879830743429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2323904879830743429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2323904879830743429==--

