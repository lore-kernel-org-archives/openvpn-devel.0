Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416D9C61DB9
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:MIME-Version:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=W/c4U9AntZ3LXgPH4RhkArA8D8fxCycCHVKS2uQAwhw=; b=jfBqDKsBVU6pZ/0VL+qFO8EhKV
	w7/3D0nbCLezEE3j2ojeB8LpN1nvNABr6zWYeg7JtoXa4NeP/8x+25MqzRsqqQ7s6850Y7jcksyMP
	ItNjKOlBMAl3hBdbe+rROnOzwxAcqRUGGTiU0J7z4mDZVkBQq5oLhFA08oy6vbkPqCDk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzpxv-0007p4-DV;
	Fri, 28 Aug 2026 06:21:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <icicimov@gmail.com>) id 1wzpxt-0007ox-NZ
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 06:21:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:Subject:Message-ID:Date:From:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=84GYe4qWT5M0r9tY+VDRfAUZ83b74wfETxULAiuzeEw=; b=khxv0t9S8j+vCLLkcUar0i/7Yi
 /ZVRc+BdKqwE+XfcBe9TbEQO8Uf1BRwheNLBATI7h9sYz9SQwh/NlKv9ujoTuYAAyg0WTkRW8nW55
 kG7Cf+fK5TV8Yoote6qPcE/yQKZXWy2Ca2MDxEMqQEddQAuNAGwewbKA+wbx9AH9PGJc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:Subject:Message-ID:Date:From:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=84GYe4qWT5M0r9tY+VDRfAUZ83b74wfETxULAiuzeEw=; b=K
 gITzssDUgYfB7U6Jskt5rQgXsIKpKfjQEop+/TDZ9ZaYySB8nc+gbtNFpFy7O/P0ILD6zikQCR9cj
 /eZv4DxzqFBBUEwlg3XJiPJmf1Ffdlq4wQMigDo8Djvd45a5UVAGNZV9hzmeXw4smlUtnynQNMacv
 ryFJwylul0v5UAJA=;
Received: from mail-pf1-f182.google.com ([209.85.210.182])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzpxq-0000Gv-N7 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 06:21:23 +0000
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-84f3ab8750cso555161b3a.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 27 Aug 2026 23:21:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787898077; cv=none;
 d=google.com; s=arc-20260327;
 b=r4WcsY7spGK04GhrIlBvC97waiqbSTngd7l5siP5R9lh76qFN1V+CM3mzssa7VuSM8
 k561FVJl951qn8LyRp/CFnO6pgX9vaA+NYuZXUaZx5ul7Tp9qXc+gJEOoZE8CE78QGjJ
 dYA6dKMlhgIyhdMvE+GafQAsW2UDGgowFSJtOrx2GGiDO1NARS8hO6dBPwHhRenZKx9M
 srX5gDAkhi3BODjeaMIn5DyykpXgHMrBqpY4PHVNA/TUMTnImrQHZBrzN4bdv7MFarYe
 qkRQAJ/WrgqTtY6cMzajIyr2GitC3h8iTZdZYR/XpBZuk3uewsn+m7RzFV8x6uTbgEn9
 xLOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=84GYe4qWT5M0r9tY+VDRfAUZ83b74wfETxULAiuzeEw=;
 fh=4NbAC/LsuMLI0S0hprUlLSLCiHwg6SCAifhH718Jh0Q=;
 b=QCfinwW6OTqLn2oPpRF3GPBkC1LxYFtgznjIfVwttUy7dNnhdpRmWJTvjg96zIPB3r
 Om8PNDZrSSIoz3pQixs83QUHL3CaP2G9XBFZCn57cUG7V9nzkbJB9kvMcmfT5VJNUxWV
 86ccdHeR6LY0JndEH1p0vJ5DWHlyTxPFGo4EDZJw65doPkwSzQZUOzflm+KCR7sN6LGe
 qzncl2/eRxuWINezCKIdc6ybpZNTakfUB7mbzrhq+xAQs0y9guKYBvutJgWtgECEMB6T
 4L2DmZAlP0HGnsLQhWBIYL1G5s0pCdHDhlNp8dBZ/9ScIRXwJYF9KJm+JbYRhm7/T7YX
 ydFg==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787898077; x=1788502877; darn=lists.sourceforge.net;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=84GYe4qWT5M0r9tY+VDRfAUZ83b74wfETxULAiuzeEw=;
 b=dXP3aBPLWLCq8hjzvE6moPSB/3OAtth5Y0cS7errnGstV2JlHdLXWnkF/zaWwEcXgk
 8Y/gnaeIEN/gM9yq2wqUql+SW9md7ZBZbHdBpWY3TYrp5zZU2iNaBjEi5xhukbljxPQo
 /nIFt27RzXFfLK6LmJsgL932RKpfxbz9qAKXKChmW+b31lE3acw+tHojsY5KAnQ945o9
 2MgcjDRRk9Lj4qLvVsD1FAg+qr7kcejw5gVcDcGT2cev+2y03hOMvxwpaffLlQ8m3UXv
 xA0MtgQJHjEijb91p9ENs+3vy4WvRa2jrUhDnsEpppUypk/LzKvSqlKA8aNiGBem4Rm3
 Mr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787898077; x=1788502877;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=84GYe4qWT5M0r9tY+VDRfAUZ83b74wfETxULAiuzeEw=;
 b=oRmoTahVqCoXQrrJKQ0nluYwZa03/FJW5efg1bL5X88LnusbjSh21WSJnEEkPq6hV2
 Z9yqSyNVzhbQz+Ma63WWX82nClXjaPESSnVBFEnu9SIxpkCmn893/qKrFZfnGAbSkWC5
 ZRroYkFv6hPHTWxNgqTO3g8g9ORiL82sBLVRNR5A0IPwdA5e+rYFIq6zvBblqeK575gt
 83WozfW65FddwJE6U3eXwhGNtX+82B0kV3RXCJv21w2VVKTG68C+1ll8Zzglr66L0zlQ
 byNZx7Zt4mQj6nkfetZPE4Gphw5hwaTRMdtr9ITRIbyV/HhG/QhBHgBNdyMp83/pd7O/
 aoDA==
X-Gm-Message-State: AFuF++nRUMPCDMUeoXvVmaOajJUAgkAOX6Jq4pAY/WEScpZf+eO0RdCR
 bBNLOpBL2gd4wcdiF8T/hritLzt4jmuF5+Zsx05amip9B8q25y/GPPQlFVt9r3G7cVOfIdJ5Z4y
 JwdoTEYYOap5CbMRiGCoBRlBaGT4L9c7Ts44h
X-Gm-Gg: AR+sD11qdsLZvq2Y0KJs7NA5sfzHiflixdyUs7C63k3W7q/VHV1QK6BYTduhHBaE3aO
 smLyT1KGpSYVynkR5f0ycieEVU+vIs8aZ7LAvPqRcUTxC/Vk0mBixc5TqCvGNmJjSx2uKWaHJYp
 xk7pvtV12B0QGlBHQRzDr/hUhS/35BthFXG7Fz3+R4sJT4fKnE2bsa34IdPW/4CEBEHUHKJF/8a
 ljVgopW3SFQON4USF/vFY2+pw3Ei7le7nNkueVPNoDZEDIDYm/raEJu4yDjXSeB0Bla8qEnCLU0
 0CU4SB5pOBiU3wmJYFsTguBLEItJCrMDkeyjgCDqFmG6
X-Received: by 2002:a05:6a21:46c9:b0:3d0:868d:8ccb with SMTP id
 adf61e73a8af0-3d2681a7ff8mr10284655637.13.1787898076676; Thu, 27 Aug 2026
 23:21:16 -0700 (PDT)
MIME-Version: 1.0
From: Igor Cicimov <icicimov@gmail.com>
Date: Fri, 28 Aug 2026 16:21:05 +1000
X-Gm-Features: AcwNN1X8CqBZHp2cIS3W5nDQejpKKD3AyEfKiLRqv1El-k-JoUS7Zo6dPp9h6hA
Message-ID: <CAAKASGwj0iNCzGupek8_EM0eY0_kcOxiYST_cVTkD+kknofS8g@mail.gmail.com>
To: openvpn-devel@lists.sourceforge.net
X-Headers-End: 1wzpxq-0000Gv-N7
Subject: [Openvpn-devel] [openvpn3-linux] netcfg netlink socket churn
 exceeds Establish() timeout
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Reporting a failure mode in openvpn3-linux where a split-tunnel profile
with a large pushed route set cannot connect. openvpn3-service-netcfg's
per-operation netlink socket churn exceeds the client's fixed
Establish() timeout. Reproduced identically on v26-3 and v27.1.

ENVIRONMENT

  openvpn3-linux    v26-3 and v27.1 (both affected)
  OpenVPN core      3.11.5 / 3.11.7
  OS                Ubuntu 24.04, systemd + D-Bus
  Kernel            6.18.33.2 (WSL2)
  Profile           split-tunnel, ~900 pushed IPv4 prefixes

SYMPTOM

Authentication succeeds, the tunnel negotiates, then:

    Virtual device '<id>' registered on /net/openvpn/v3/netcfg/<id>
    Adding IP Address 172.x.y.z/24 gw 172.x.y.1 ipv6: no
    Setting remote IP address to <server> ipv6: no
    Error calling NetCfgDevice::Establish(): [Proxy::Client(
      'net.openvpn.v3.netcfg', ..., 'Establish')] Timeout was reached
    Failed configuring TUN device (TUN_IFACE_CREATE)

Five seconds later netcfg finishes the work the caller already gave up
on and rolls it back, logging ~900 of:

    Error while executing NetlinkRoute4(add: 0) tun0: -2
    Error while executing NetlinkAddr4(add: 0) tun0: -2
    Error while executing NetlinkLinkSet tun0 mtu 1500: -1

Those are teardown, not the cause. The tun itself is created fine --
ioctl(TUNSETIFF) returns 0 in 221us.

ROOT CAUSE

netcfg allocates, binds, uses and closes a fresh AF_NETLINK socket for
every single operation. From strace, this unit repeats once per route:

    socket(AF_UNIX, SOCK_DGRAM) -> ioctl(SIOCGIFINDEX) -> close
    socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE)
      -> setsockopt(SO_SNDBUF) -> setsockopt(SO_RCVBUF)
      -> bind()          <-- dominant cost
      -> getsockname -> sendmsg -> recvmsg -> close

On a typical kernel bind() is microseconds here and nobody notices. In
this environment bind() costs ~10ms, so the fixed per-operation
overhead becomes the whole story:

    901 bind() calls  mean 9.1ms  max 10.8ms  total 8.183s

    Within the 5s Establish() window:
      507 bind() calls
      4.601s in bind() alone
      4.939s total worker syscall time
      -> 93% of the budget is bind()

~900 routes x ~10ms is ~9s against a 5s deadline. netcfg completed 507
of them before the caller aborted.

Note this is not netlink-specific slowness in the environment. AF_UNIX
bind() measures the same ~10ms and AF_INET bind() ~21ms, while socket()
creation is free. The point is that netcfg pays a fixed per-socket
setup cost ~900 times where once would do.

For contrast, on the same host, installing the same route set through a
single reused socket (ip -batch) takes ~0.4s, roughly 20x faster.
Individually via separate "ip route add" invocations it is ~0.9s per 45
routes.

SUGGESTED FIXES

1. Reuse one netlink socket for the duration of an Establish(), or for
   the lifetime of the NetCfgDevice, instead of one per operation. This
   removes the failure entirely and is a straight win everywhere --
   ~900 socket create/bind/close cycles per connection is pure overhead
   even when bind() is cheap.

2. The Establish() D-Bus call timeout appears to be a fixed 5s with no
   override, so a slower-than-anticipated environment has no escape
   hatch. Consider scaling it with the number of queued networks, or
   making it configurable.

SEPARATE BUG: SEGFAULT ON TIMED-OUT CALLER (v27.1)

When the caller gives up, v27.1 netcfg dereferences the D-Bus unique
name of the process that has already exited, and crashes:

    ** ERROR ** Async call failed: [DBus::Credentials::GetPID] Failed
    to retrieve process ID for bus name ':1.75': Could not get PID of
    name ':1.75': no such name
      error domain: net.openvpn.gdbuspp
    kernel: pool[20958]: segfault at 5e2123c54d3d ip 00005e24841cca58
      sp 0000775b767fb250 error 4 in openvpn3-service-netcfg[...]
    kernel: openvpn3-service-netcfg: pool: potentially unexpected
      fatal signal 11

Looks like a use-after-free or missing existence check on the caller's
bus name in the async error path. v26-3 handles the same timeout
gracefully and only logs the netlink errors, which is why the crash is
v27.1-specific while the underlying timeout affects both.
libgdbuspp3 3-3.

WORKAROUND FOR ANYONE HITTING THIS

Append "route-nopull" to the profile so Establish() only creates the
tun and sets the address, MTU and link state -- about 5 netlink ops,
well inside 5s. Then install the pushed routes separately through one
batched netlink socket with ip -batch. Capture the route list from a
normal connect attempt with:

    journalctl --since -5min | grep -oE 'Adding network [0-9./]+' \
      | awk '{print $3}' | sort -u

Caution: check whether the VPN server's own address falls inside any
pushed prefix. If it does, a protective /32 host route via the physical
gateway must exist before the tunnel routes go in, or the transport
deadlocks.


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
