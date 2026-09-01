Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97059C61DD6
	for <openvpn-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+TLUpEyh/isgTya0sk9NUXXZQLIOrSj+pQ75K1fdPFo=; b=eMCaZLoCFnk0hZPXFhuM0KmghY
	yikedfiR4vB9DHRYW68YKNIYIcD2/J93RRFF7GFbNbggLu0UDNgHlBtVKDR7GQlZW5s/0A5YaR5nz
	evTB7g1Z/BYFs2yIE4MZFG0xO48p4emECwAKp+cb/m/0cJigdITyj9GtV/haya3EyFTA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1J3b-0004OM-QI;
	Tue, 01 Sep 2026 07:37:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1J3a-0004OG-6i
 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 07:37:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=gYnfdVB7z3GzUS9FdxEfZJk7k2jqsjzTSEn8eSROGkA=; b=M7CtKGeAelF300Zg69jJUqH+5G
 0/SgWsUGTnKkbmDLCgBnkCnJTP7Nwsx/iwk2RoKLQpLtSXZYxlu2/kf+Cd4ySVcg55t7Le5t5W+BH
 GA8r/gBurLO+qq09M3yOd+c4+rkkJ0FNaAaM6gaLrKBAM3FbNGuT1Rf/0eX+xr7xSt5Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gYnfdVB7z3GzUS9FdxEfZJk7k2jqsjzTSEn8eSROGkA=; b=b
 0RCJ7+pgeqOm0JwbWkumJJ7Uz93KbE2MhW8csVX9oIN37+ycb5nh3oMN5sGciYZpeAJbFuvYClQQj
 MD2nARcKmSndPUKBtOdvzzaHaZy+8/VHjQ4APxAZcnk/IUza4XDluuykJkq5jL2VsPQHN2ZTEmFEu
 Tl6KRVNz1+bXgy68=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1J3W-0006rF-Jt for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 07:37:19 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49b0eab380eso7553685e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 00:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788248232; x=1788853032; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gYnfdVB7z3GzUS9FdxEfZJk7k2jqsjzTSEn8eSROGkA=;
 b=UarhjbNdIbgia4C4kIOXJPfIk88wsI68qW9f704IR5ojQE2KFx/CK+kAB7clW+kj+i
 TA8mEgZ6CaDJrtyByPJRw7wa+hVH7dtr71OKclNFtWwFm7gEIaOrIVG61OaO4L5ceM8P
 Y6YeP+yeUUy6EFdkh+BZUKIRq+QebldV+yUWclddMFawfG7Sc6qEEoJVCJnNewQPHuKD
 GYgJx9muNd0NHIUDYkyZvJWDYl2rACtSfpardi7gZX+nT8yC6v0wUVQa3E+uqEsFxdgb
 XIbduKLru3u1IHf2jh34Sdk6rhN9vN9NqbvjdK6TXTNTVjvJH2vjqq4Kr5j6cUaw3LAg
 2VMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788248232; x=1788853032;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gYnfdVB7z3GzUS9FdxEfZJk7k2jqsjzTSEn8eSROGkA=;
 b=nrBT5HLsJLPVsoiyZULXNF4BF9lurHrSaGNlEIkiZ4f43nX0zYSRMPAT4L4PnfPQUo
 0fk1cqhdgxQR6ZYH3Gg3Quu8Xj2Q7oJgqoW0lxWseMmiIa/MIUpXKA+9Vx+9qxEryhXn
 vAV5E0TI4AbY3Ht5isHLYhtZ7LzT5f+iSh2BAx7ZiWjlDTG1WHQTVPAIdAnXtJc4VSFN
 CLbEYPt5z09aeYxq1mnRSGOtqjlffdhIx5jo/yWTCc1hQzIk/wlQAc5l08qkx3yKuzXc
 xK9U1Yb2fmn2qsbnCOHKNvC/vflHTEyNgLXjcOSxF/r1BRzKRbee4m36zL4KXTXJ7nxs
 WuPA==
X-Gm-Message-State: AFuF++nzPnfqLPlmkF9sAr7+7R9RnkBtMc2Z8qQG3K0MX9IDL5sMkYoF
 JkWWnswagRdwX5OrbT8NWWOqPpzIInNLTGofbqc3m6Qc9mqnnw0MIaIyYnKLUjEdg1loKRKR/8v
 0dcebGwt/gUiUIFweEKOhM5f6DiKv/QNEl4PjC5rC3PO0GtkneXC2NRfrHgrWgdZPddkJTiVxtV
 PQwp2cuw==
X-Gm-Gg: AR+sD11r3USOj1tgbRqkuIc+588lYdjHWCsNyaWC3LD2z4LG1qaPFrkhkLi9mBzYqAB
 OPzr10k+LXO9DnsrZTNW3G9V4Tywmpq+RL9B2AKLvpPNm8ysXLcU/M1YdR5w4tdENEK5ScVpz2R
 FlO0MinEp9bmi1vQCA+00wYKiH1Go2b0h0U5lFDXdFCgulvDMemrZgvHRiQLq30WoQQBhbcl+Z4
 yMk/O9NizNqUS2Vr8bjZeHOnqwIY/yH9iNcbjL53CzQ1fcYstMXEEBfPbeQ9seO3NNGxUrUzI+q
 jIqpNve56zgTaaCpN/p3nGK3fymsT+RLnkIx7rVey7CRZbiJUTaYunW5XSvpSsyisR16LbOkxJK
 3NO9MlHUaa40kFgX4hGZpl1Rv7p503jIEJcKcCwLEuDsXAFS/FPtcxFFQC31Fss3CD1rXi5BA49
 XDsuL06VCtiyJtTYb8Hj7Zqb/edVnisfxP5FRnSlrj5tOxTVENVx0MQ5kqvbJmPC/pCnTddfqmT
 nHI9LgXNaFIQ3xbKhg8xXygBcUTXKsBL7NQ336HcT/Dq8sxdgpcSzX6xN5Xg6iynFZuz45FZB08
 +br6RDBncA4rXrHGXOhoO54nyA4r3ewqxEPXYiPuiI/I4kjQV6s=
X-Received: by 2002:a05:600c:4e4c:b0:49b:e22:4ee4 with SMTP id
 5b1f17b1804b1-49cdd416ef1mr52553055e9.4.1788248231848; 
 Tue, 01 Sep 2026 00:37:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce18dbae2sm2808765e9.13.2026.09.01.00.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 00:37:11 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 1 Sep 2026 07:37:10 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7
X-Gerrit-Change-Number: 1782
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1782?usp=email>
X-Gerrit-Commit: 40ad1633b9b336e8cb4bec0d533ee6065e22e6f2
In-Reply-To: <gerrit.1783977723000.Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7@gerrit.openvpn.net>
References: <gerrit.1783977723000.Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTc3NzIzMDAwLkllNzM1MmRkMTM2Y2NjZGEyYmQ2YjZlMWEzNmRiMWE1ZjI3YWZkOGY3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5fe6088e574fc9d75bc8c3196f3676109da78846-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1J3W-0006rF-Jt
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
Content-Type: multipart/mixed; boundary="===============7222407677861622623=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7222407677861622623==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pf8krh1cvSg="; charset=UTF-8

--pf8krh1cvSg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos, ralf_lici=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1782?usp=3Demail

to look a=
t the new patch set (#2)=2E

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
1 file changed, 36 insertions(+), 17 deletions(-)


  git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/82/1782/2

diff --git a/src/o=
penvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec
index e6e72d=
0=2E=2E7d623a4 100644
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
+    uint32_t seq =3D payload->nlmsg_seq =3D ++sitnl_seq;
 
=
     /* no need to send reply */
     if (!cb)
@@ -283,7 +298,7 @@
        =
 return -errno;
     }
 
-    if (sitnl_bind(fd, 0) < 0)
+    if (sitnl_bin=
d(fd, 0, &local_pid) < 0)
     {
         msg(M_WARN | M_ERRNO, "%s: can't =
bind rtnl socket", __func__);
         ret =3D -errno;
@@ -357,18 +372,22 @=
@
                 goto out;
             }
 
-            /*            if=
 (((int)nladdr=2Enl_pid !=3D peer) || (h->nlmsg_pid !=3D nladdr=2Enl_pid)
-=
             *               || (h->nlmsg_seq !=3D seq))
-             *   =
        {
-             *               rcv_len -=3D NLMSG_ALIGN(len);
-   =
          *               h =3D (struct nlmsghdr *)((char *)h + NLMSG_ALIGN=
(len));
-             *               msg(M_DEBUG, "%s: skipping unrelated =
message=2E nl_pid:%d (peer:%d)
-             * nl_msg_pid:%d nl_seq:%d seq:=
%d",
-             *                   __func__, (int)nladdr=2Enl_pid, peer=
, h->nlmsg_pid,
-             *                   h->nlmsg_seq, seq);
-    =
         *               continue;
-             *           }
+           =
 /* Discard any message that did not come from the kernel or does
+        =
     * not match the request we sent: only the kernel (nl_pid 0) can
+     =
        * legitimately reply, and a valid reply echoes our port id and
+   =
          * sequence number=2E This prevents a local process from injecting=
 a
+             * spoofed reply that the callback would otherwise act on=
=2E
              */
+            if ((nladdr=2Enl_pid !=3D 0) || (h->nlmsg=
_pid !=3D local_pid)
+                || (h->nlmsg_seq !=3D seq))
+        =
    {
+                msg(D_RTNL,
+                    "%s: skipping unrel=
ated message=2E nl_pid:%u nlmsg_pid:%u (local:%u) nlmsg_seq:%u (seq:%u)",
+=
                    __func__, nladdr=2Enl_pid, h->nlmsg_pid, local_pid, h->=
nlmsg_seq, seq);
+                rcv_len -=3D NLMSG_ALIGN(len);
+         =
       h =3D (struct nlmsghdr *)((char *)h + NLMSG_ALIGN(len));
+          =
      continue;
+            }
 
             if (h->nlmsg_type =3D=3D NLMS=
G_DONE)
             {

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1782?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7
Gerrit-Change-Number: 1782
=
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Rev=
iewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <r=
alf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Attention: ordex <antonio@mandelbit=2Ecom>
Gerrit-Attention: ralf_lici <r=
alf@mandelbit=2Ecom>

--pf8krh1cvSg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos, ralf_lici=2E </p>
<p>ordex <strong>=
uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"http://ge=
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
;<br>---<br>M src/openvpn/networking_sitnl=2Ec<br>1 file changed, 36 insert=
ions(+), 17 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/82/1782/2</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec</span><=
br><span>index e6e72d0=2E=2E7d623a4 100644</span><br><span>--- a/src/openvp=
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
span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t seq =3D payload-&g=
t;nlmsg_seq =3D ++sitnl_seq;</span><br><span> </span><br><span>     /* no n=
eed to send reply */</span><br><span>     if (!cb)</span><br><span>@@ -283,=
7 +298,7 @@</span><br><span>         return -errno;</span><br><span>     }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (sitnl_bind(fd, 0) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (sitnl_bind(fd, 0, &amp;local_pid) &lt; 0)</span><br><span=
>     {</span><br><span>         msg(M_WARN | M_ERRNO, &quot;%s: can&#39;t =
bind rtnl socket&quot;, __func__);</span><br><span>         ret =3D -errno;=
</span><br><span>@@ -357,18 +372,22 @@</span><br><span>                 got=
o out;</span><br><span>             }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            /*            if (((int)nladd=
r=2Enl_pid !=3D peer) || (h-&gt;nlmsg_pid !=3D nladdr=2Enl_pid)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-             *               || (=
h-&gt;nlmsg_seq !=3D seq))</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-             *           {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-             *               rcv_len -=3D NLMSG_ALIGN(len);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-             *             =
  h =3D (struct nlmsghdr *)((char *)h + NLMSG_ALIGN(len));</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-             *               msg(M_DEB=
UG, &quot;%s: skipping unrelated message=2E nl_pid:%d (peer:%d)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-             * nl_msg_pid:%d nl_s=
eq:%d seq:%d&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
           *                   __func__, (int)nladdr=2Enl_pid, peer, h-&gt;=
nlmsg_pid,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
  *                   h-&gt;nlmsg_seq, seq);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-             *               continue;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-             *           }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            /* Discard any m=
essage that did not come from the kernel or does</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+             * not match the request we sent: =
only the kernel (nl_pid 0) can</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+             * legitimately reply, and a valid reply echoes our =
port id and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
     * sequence number=2E This prevents a local process from injecting a</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+             * spoofed=
 reply that the callback would otherwise act on=2E</span><br><span>        =
      */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 if ((nladdr=2Enl_pid !=3D 0) || (h-&gt;nlmsg_pid !=3D local_pid)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                || (h-&gt;nlm=
sg_seq !=3D seq))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        msg(D_RTNL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    &quot;%s: skipping unrelated message=2E nl_pid:%u nlmsg=
_pid:%u (local:%u) nlmsg_seq:%u (seq:%u)&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    __func__, nladdr=2Enl_pid, =
h-&gt;nlmsg_pid, local_pid, h-&gt;nlmsg_seq, seq);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                rcv_len -=3D NLMSG_ALIGN(len=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                h=
 =3D (struct nlmsghdr *)((char *)h + NLMSG_ALIGN(len));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                continue;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span> </=
span><br><span>             if (h-&gt;nlmsg_type =3D=3D NLMSG_DONE)</span><=
br><span>             {</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1782?usp=3Demail">chan=
ge 1782</a>=2E To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1782?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1782 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &l=
t;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelb=
it=2Ecom&gt; </div>

</body></html>
--pf8krh1cvSg=--


--===============7222407677861622623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7222407677861622623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7222407677861622623==--

