Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A056CCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 12:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=uC9EAIQ6Oo+tonay/jpCJprry8Ttp+cRucmqA9ZGgWY=; b=Jv5lcv271Muscm
	G746VUmTUjxzl9L4TzClcjZ3K8cTRA+LPo6pzvourvHSrfue3/FyKTPw0ORwAi01ofGyrwSdpHWys
	mAv4rluCkuB8ec70/6NVxq06bWKwCaJ1UDDZVyJ4ZcN4OYb3JOxPOathx71E0HJKW59Fr1/su8Pa4
	cxE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIPoP-0000Bw-8u;
	Sun, 18 Oct 2026 12:16:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIPoM-0000Bo-DS
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 12:16:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rYqaDDIVbRZlRw+icPg2w1kQ0wg5MwzGVA6z4+qtjx4=; b=YSsmObE9FrOrZPlXpj8N2buu1a
 WM1DQa3YNrzCqshAekUagm2c8Qgqd3dAzdcFmOBvh8l4enUPoHuMTxxhEClNL4xXbPQFKTRBk3Nip
 WBK/5rEWLXl75FnnwozUp6MwdgE5suAS3MihnpEBWBWoCRE7+II6KVsvgsdq4v5KFGEA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rYqaDDIVbRZlRw+icPg2w1kQ0wg5MwzGVA6z4+qtjx4=; b=N
 i1K5CaLDOBSZ/rLRsiWJhg08jdMVr9Rx07AxgITgLxQIf3A8KyuukuHcoJ+UFaQPS/Z6VJStZOEvG
 xkFaX5nQFQRzgPa4AhUDbf+fPh1BvpzLNKAB4iEO24l79rTK8KIvF1igkp7kBpKbinZEKUiEZDN6G
 a9lzhjMejV7JF8MY=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIPoJ-0005U0-1u for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 12:16:19 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso583481f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 05:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792325772; x=1792930572; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rYqaDDIVbRZlRw+icPg2w1kQ0wg5MwzGVA6z4+qtjx4=;
 b=fqf9sZ2rPfoDGUQt1CZRvEaWUx3BEG5iUi2YDMkeOabDRFSkaJAxrQe69MHQBGCuC9
 eGifZ1bhKMSEJ3GST7f5tUZMhoiRH84D8/n0CQAiiniaTFeQ0z2ULxvSA9JK/ku07eTY
 whX0PDvfjcpjNVx8Xuy7N0goTt/F4kDjiodFlAXLFvsLtCqhzZHAVp91Akp1hGG0/mPU
 H3+6KuxDgAg2eFl6oJvtgjTWqDgmTD90CTIkpfryyeI7yESGz6Wh5lpFQUbfxUynFazA
 tNpU1uefEOqWOFVeanDgy8zLDX4uB5gUWq+V0nEQ0OeY196VB7q+9U0B+ur/ZsUYilwF
 Dm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792325772; x=1792930572;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rYqaDDIVbRZlRw+icPg2w1kQ0wg5MwzGVA6z4+qtjx4=;
 b=bAyKuG1dbUGMn/MV0SXMJmM5L8XCmnFgQbXVfcWrS7BXZViKG4auBIADO/4nzLl/wv
 abTnfmAVtGaJQ2dTleqEVHh+spgwmbiW0lyZeC+VH/9/IZkdxS6/FZBeCBqAs4wv4wFm
 GuShGw6snjqTpDZEkIryZpEZqFIDTjfKhZvFhVdp7oFphRWAXh8l+aBxJiUQ2DwpSi2m
 uKiIhuWGCwr9CA1nS2FBe7UPstyy51df+uT839xKhWCqkIs4nj8+l0d6VG/hD7iOQsz6
 qBpaO9u5taJzcBpBzHLH4f9ZB8ORNY4LUVzcrfQKouZzvFWCt8lyrMiX3Cx1FmvH1veN
 fVUQ==
X-Gm-Message-State: AFq9FYI5ojgsazSOntFKPLme4M/kGzLGNFq7L3QbsE+W77zBaokf9iPt
 gZ198SbOn+32iROfa5fhkJ4F4eQ21SnNLhXsVy9d9ncCDxaxIVSK59vBKStZfCPKT7G2+XBUCyW
 +tdnalG6sVG99k21iPBJT36+n0jES9rjJDM3ZakmbtH5BnoaExyFrHxGu7Px0SCf3GY1XAD3QdU
 Arp8qBHw==
X-Gm-Gg: AYBFou1te8gsgxDp9mQGqaDXwnSLQRIGWq6O8NIGlUWCqsqhYCU9bVqZFekXseqfVCE
 WyDsX+55zV+XqxcPj/cBqK/ESzATqhp7oOtYQQSIriUCgFeiY2YZZjJrFP66ipC3Q5waNv2u5sn
 zsuFCYTyYqb2iKb68lxPT6DHbrGK2R6nVsl2n26yPcz4uWP9SGcDId8Qectaini/2/DR7MuMleH
 0P73LMTjbsFHUqt0NBi6jf2LJCHa2CtxxI3Iw5k+sQMFhNVHNN5tZXrgbb0F4qYelGMgUt8vznK
 FJeCeYMkr+7NLmRDM2PykZi7ZyMt1EP34PIotpCF3GjEQd/aQjtRTaBPzrM8T9Bd8N0rH3U7M/d
 TRtc119JoR5uIgVmSVQ0AySJjfnLBScHWQ08fFEGUFAFUXHG9Gs40n3IB8F5RU54Jz48/pqCjJQ
 rKMufk8cNZLqxrzHPFzQIWlM4PfgA6elmOs6T940knpvraztWxeKzuaHhazbDvoWNGPYbr0SMRB
 DtMCfGO4Ghl5+gpJXRtZ0RlkIMg8j+wdTKZdwe9R+KaXIXODQ2S67hFcpPfscNlnkg0yt2+kocM
 63N25PuGXRvUPzZcdAEAfDHdeyjmhdsVehbD9h914kAygHa3l7deqXmIC00Z8g==
X-Received: by 2002:a05:6000:46d4:b0:48d:f9dd:e3b9 with SMTP id
 ffacd0b85a97d-48e07fb2acdmr6670091f8f.17.1792325772245; 
 Sun, 18 Oct 2026 05:16:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4f576asm17734100f8f.32.2026.10.18.05.16.11
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 05:16:11 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 12:16:11 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I10ebb5821829bf738e58fec23f9f9dd65d4626d3
X-Gerrit-Change-Number: 2014
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2014?usp=email>
X-Gerrit-Commit: 019f91d238c8bbf67bb6eeb8b795300b072bdcec
References: <gerrit.1792325770000.I10ebb5821829bf738e58fec23f9f9dd65d4626d3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMzI1NzcwMDAwLkkxMGViYjU4MjE4MjliZjczOGU1OGZlYzIzZjlmOWRkNjVkNDYyNmQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c297ee83af2e8efbdabbdb7655baa6dfd9f4580a-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIPoJ-0005U0-1u
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix cppcheck
 warnings on macOS
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8746087323956258195=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8746087323956258195==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8qXH02JD2f8="; charset=UTF-8

--8qXH02JD2f8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has uploaded this change for review=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2014?usp=3Demail )


Change subject: Fix cppcheck war=
nings on macOS
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Fix cppcheck warnings on macOS

- Replace bzero with memset

   memset is=
 nowadays preferred to bzero

- add_route_ipv6: Fix %d used with unsigned i=
nt
- add const to two variables that can be const

Found-By: cppcheck on ma=
cOS
Change-Id: I10ebb5821829bf738e58fec23f9f9dd65d4626d3
---
M src/openvpn/=
route=2Ec
M src/openvpn/tun=2Ec
2 files changed, 11 insertions(+), 11 delet=
ions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/14/2014/1

diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
in=
dex 9c80f3b=2E=2E4e963c7 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openv=
pn/route=2Ec
@@ -1862,7 +1862,7 @@
 #elif defined(TARGET_ANDROID)
     char=
 out[64];
 
-    snprintf(out, sizeof(out), "%s/%d %s", network, r6->netbit=
s, device);
+    snprintf(out, sizeof(out), "%s/%u %s", network, r6->netbit=
s, device);
 
     status =3D management_android_control(management, "ROUTE=
6", out);
 
@@ -3348,10 +3348,10 @@
     rtm_addrs =3D RTA_DST | RTA_NETMAS=
K | RTA_IFP;
 #endif
 
-    bzero(&m_rtmsg, sizeof(m_rtmsg));
-    bzero(&s=
o_dst, sizeof(so_dst));
-    bzero(&so_mask, sizeof(so_mask));
-    bzero(&=
rtm, sizeof(struct rt_msghdr));
+    memset(&m_rtmsg, 0, sizeof(m_rtmsg));
=
+    memset(&so_dst, 0, sizeof(so_dst));
+    memset(&so_mask, 0, sizeof(so=
_mask));
+    memset(&rtm, 0, sizeof(struct rt_msghdr));
 
     rtm=2Ertm_t=
ype =3D RTM_GET;
     rtm=2Ertm_flags =3D RTF_UP | RTF_GATEWAY;
@@ -3566,10=
 +3566,10 @@
     rtm_addrs =3D RTA_DST | RTA_NETMASK | RTA_IFP;
 #endif
 
=
-    bzero(&m_rtmsg, sizeof(m_rtmsg));
-    bzero(&so_dst, sizeof(so_dst));=

-    bzero(&so_mask, sizeof(so_mask));
-    bzero(&rtm, sizeof(struct rt_m=
sghdr));
+    memset(&m_rtmsg, 0, sizeof(m_rtmsg));
+    memset(&so_dst, 0,=
 sizeof(so_dst));
+    memset(&so_mask, 0, sizeof(so_mask));
+    memset(&r=
tm, 0, sizeof(struct rt_msghdr));
 
     rtm=2Ertm_type =3D RTM_GET;
     r=
tm=2Ertm_flags =3D RTF_UP;
@@ -3654,7 +3654,7 @@
     /* get gateway addr a=
nd interface name */
     if (gate !=3D NULL)
     {
-        struct sockad=
dr_in6 *s6 =3D (struct sockaddr_in6 *)gate;
+        const struct sockaddr_=
in6 *s6 =3D (struct sockaddr_in6 *)gate;
         struct in6_addr gw =3D s6=
->sin6_addr;
 
 #ifndef TARGET_SOLARIS
diff --git a/src/openvpn/tun=2Ec b/s=
rc/openvpn/tun=2Ec
index 2c2766f=2E=2Ea61efaf 100644
--- a/src/openvpn/tun=
=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -1833,7 +1833,7 @@
             for (int =
i =3D 0; i < 256; ++i)
             {
                 /* some platforms ha=
ve a dedicated directory per driver */
-                char *sep =3D "";
+=
                const char *sep =3D "";
 #if defined(TARGET_HAIKU)
        =
         sep =3D "/";
 #endif

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2014?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerr=
it-Change-Id: I10ebb5821829bf738e58fec23f9f9dd65d4626d3
Gerrit-Change-Numbe=
r: 2014
Gerrit-PatchSet: 1
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--8qXH02JD2f8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe has =
uploaded this change for <strong>review</strong>=2E</p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2014?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Fix cppcheck warnings on macOS<br><br>- Replace bzero with mem=
set<br><br>   memset is nowadays preferred to bzero<br><br>- add_route_ipv6=
: Fix %d used with unsigned int<br>- add const to two variables that can be=
 const<br><br>Found-By: cppcheck on macOS<br>Change-Id: I10ebb5821829bf738e=
58fec23f9f9dd65d4626d3<br>---<br>M src/openvpn/route=2Ec<br>M src/openvpn/t=
un=2Ec<br>2 files changed, 11 insertions(+), 11 deletions(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/14/2014/1</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=
=2Ec</span><br><span>index 9c80f3b=2E=2E4e963c7 100644</span><br><span>--- =
a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><=
br><span>@@ -1862,7 +1862,7 @@</span><br><span> #elif defined(TARGET_ANDROI=
D)</span><br><span>     char out[64];</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    snprintf(out, sizeof(out), &quot;%s/%=
d %s&quot;, network, r6-&gt;netbits, device);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    snprintf(out, sizeof(out), &quot;%s/%u %s&quo=
t;, network, r6-&gt;netbits, device);</span><br><span> </span><br><span>   =
  status =3D management_android_control(management, &quot;ROUTE6&quot;, out=
);</span><br><span> </span><br><span>@@ -3348,10 +3348,10 @@</span><br><spa=
n>     rtm_addrs =3D RTA_DST | RTA_NETMASK | RTA_IFP;</span><br><span> #end=
if</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   bzero(&amp;m_rtmsg, sizeof(m_rtmsg));</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    bzero(&amp;so_dst, sizeof(so_dst));</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    bzero(&amp;so_mask, sizeof(so_mask=
));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bzero(&amp;rtm=
, sizeof(struct rt_msghdr));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    memset(&amp;m_rtmsg, 0, sizeof(m_rtmsg));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    memset(&amp;so_dst, 0, sizeof(so_dst=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memset(&amp;=
so_mask, 0, sizeof(so_mask));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    memset(&amp;rtm, 0, sizeof(struct rt_msghdr));</span><br><spa=
n> </span><br><span>     rtm=2Ertm_type =3D RTM_GET;</span><br><span>     r=
tm=2Ertm_flags =3D RTF_UP | RTF_GATEWAY;</span><br><span>@@ -3566,10 +3566,=
10 @@</span><br><span>     rtm_addrs =3D RTA_DST | RTA_NETMASK | RTA_IFP;</=
span><br><span> #endif</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    bzero(&amp;m_rtmsg, sizeof(m_rtmsg));</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    bzero(&amp;so_dst, sizeof(so_dst=
));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bzero(&amp;so_=
mask, sizeof(so_mask));</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    bzero(&amp;rtm, sizeof(struct rt_msghdr));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    memset(&amp;m_rtmsg, 0, sizeof(m_rtmsg));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memset(&amp;so_d=
st, 0, sizeof(so_dst));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    memset(&amp;so_mask, 0, sizeof(so_mask));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    memset(&amp;rtm, 0, sizeof(struct rt_msgh=
dr));</span><br><span> </span><br><span>     rtm=2Ertm_type =3D RTM_GET;</s=
pan><br><span>     rtm=2Ertm_flags =3D RTF_UP;</span><br><span>@@ -3654,7 +=
3654,7 @@</span><br><span>     /* get gateway addr and interface name */</s=
pan><br><span>     if (gate !=3D NULL)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        struct sockaddr_in6 *s6 =3D=
 (struct sockaddr_in6 *)gate;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        const struct sockaddr_in6 *s6 =3D (struct sockaddr_in6 *)=
gate;</span><br><span>         struct in6_addr gw =3D s6-&gt;sin6_addr;</sp=
an><br><span> </span><br><span> #ifndef TARGET_SOLARIS</span><br><span>diff=
 --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>index 2c=
2766f=2E=2Ea61efaf 100644</span><br><span>--- a/src/openvpn/tun=2Ec</span><=
br><span>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -1833,7 +1833,7 @@</s=
pan><br><span>             for (int i =3D 0; i &lt; 256; ++i)</span><br><sp=
an>             {</span><br><span>                 /* some platforms have a=
 dedicated directory per driver */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                char *sep =3D &quot;&quot;;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                const char *sep =3D &q=
uot;&quot;;</span><br><span> #if defined(TARGET_HAIKU)</span><br><span>    =
             sep =3D &quot;/&quot;;</span><br><span> #endif</span><br></pre=
><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
14?usp=3Demail">change 2014</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2014?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newcha=
nge </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: I10ebb5821829bf738e58fec23f9f9dd65d4626d3 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 2014 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> G=
errit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>

</body></html>
--8qXH02JD2f8=--


--===============8746087323956258195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8746087323956258195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8746087323956258195==--

