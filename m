Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E5B606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 21:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lKMOwEiF;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=G88Tn8u8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jgen2OzT;
	dkim=neutral header.d=birkenwald.de header.i=@birkenwald.de header.a=rsa-sha256 header.s=mailout2020 header.b=WCNk0kMi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=V16ClK6JruBclP4faiSvc+A7+t2xGmao+qaq6OS7zv8=; b=lKMOwEiF1wWeTp
	DtyT9gZfiCz3hw9FncepuWqCQHJ+AIAe2UYtp1TxpFcLtZwOvkUPz8Gj6AI/FiTUjRGcmoGEWJqAh
	gGosMPH4RMC3SA9ZtDT+1SprKWhTB2nZWWM87ocpiP5h4sSSDHLVKNHcsfAcb/ZTdzq+w8tql3QLr
	bOs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMArI-000000007hy-0nUo;
	Wed, 28 Oct 2026 21:06:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <berni@birkenwald.de>) id 1xMArG-000000007hp-1mLe
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 21:06:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WqZYvUPr0pmabF1EgFyhc//QUSZrNrfaW7Xk0+MKpr0=; b=G88Tn8u8mkQRtMtxbVu3n7fkgN
 dd/djjdhA8/cKv3MmrteU4DJ+yuEQNDTWNgPkOYWe8VGzTiRP/By+uIQA6Lcr2scPrumuKLDV/5Ks
 OfHVLkoz0hsoamnuV2zEF2rX/NrmPSaKSGlVOHnupxQeg3pEnGETLJXi5O4RbQs5p+Xk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WqZYvUPr0pmabF1EgFyhc//QUSZrNrfaW7Xk0+MKpr0=; b=jgen2OzTgV7AzzGT19FQGnc3dJ
 wnA7IZ0H921BxBPzWNuhfu968TIiRHHIaSujCG+e0FZLd8KtqGCKXdORiEfsk8jSE7+mcblyyIzs9
 UwBgcx0wE3gWLJAoJDf+byUU4Al2mm7A2LpwVPHwOxHJXGV5f7ogebrBo8LPFu3rYfEA=;
Received: from mail.svr02.mucip.net ([83.170.6.69] helo=mailout.mucip.net)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMArE-000000003EX-1d9Z for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 21:06:54 +0000
Received: from localhost (mail.svr02.mucip.net [127.0.0.1])
 by mailout.mucip.net (Postfix) with ESMTP id 70BA569FC
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 22:06:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birkenwald.de; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received; s=mailout2020; t=1793221605; bh=ZB
 LqLl/Vyc24dymEjZEuV4qS2SiHLQ0Km31q0kCyNQg=; b=WCNk0kMiVHeGKId27E
 VB/qIyod/QNhIlz0A1T9fajHKSxZroLag3am90y0/4Odbec6NiBDIU+h1XXMYNBs
 OSld2KCJurrGxYnQscKhASUwBzdE2V5dgNHITxtNEiErs953/B8qZ4lu7HrsxdnJ
 Pd7EgOw3otco9JDMqOjRDkR1laQF2LNdZuVGz5NJVfYbSotmue0WbNi4OUmuBwh3
 7zptZorpMZ7MCLtd8m97nePLnL4esoHCbCvQP/lFPu/ZkSVPUizNe5nVn6SLuu+M
 cwHAQzgtEH3s8JrqtHL8HnmCqxuiTUiuj9SHAjR2EtWsWn16y2RuHWav4cL+dUl3
 wmxQ==
Received: from mailout.mucip.net ([127.0.0.1])
 by localhost (mail.svr02.mucip.net [127.0.0.1]) (amavis, port 10125)
 with ESMTP id vA3eX19NVtpb for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 22:06:45 +0100 (CET)
Received: from fliwatuet.svr02.mucip.net (fliwatuet.birkenwald.de
 [IPv6:2001:1b10:1000:0:5054:ff:fe67:68e8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature ECDSA (secp384r1) server-digest
 SHA384) (Client did not present a certificate)
 by mailout.mucip.net (Postfix) with ESMTPSA id 4EE7369F4
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 22:06:45 +0100 (CET)
Date: Wed, 28 Oct 2026 22:06:44 +0100
From: Bernhard Schmidt <berni@birkenwald.de>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <auJj5Ld6uMjPb2eS@fliwatuet.svr02.mucip.net>
References: <ea6e57f3-3d91-4d3f-9c28-471dc1021bcd@birkenwald.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ea6e57f3-3d91-4d3f-9c28-471dc1021bcd@birkenwald.de>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMArE-000000003EX-1d9Z
Subject: [Openvpn-devel] Kernel lockup in ovpn ovpn_tcp_send_skb
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 09/10/26 04:34 PM, Bernhard Schmidt wrote:

> We have seen two segfaults during the night, but I hope they go away
> upgrading to 2.7.8. If not I will report here. The process was restarted by
> systemd and noone noticed.

Segfaults have not reappeared, but we now have a node that exhibits
frequent (sometimes after < 10 minutes of uptime) kernel lockups.

Oct 28 21:56:56 eduvpn-n14 kernel: rcu: INFO: rcu_preempt self-detected stall on CPU
Oct 28 21:56:56 eduvpn-n14 kernel: rcu:         1-....: (1 GPs behind) idle=acbc/1/0x4000000000000000 softirq=21504/21505 fqs=2625
Oct 28 21:56:56 eduvpn-n14 kernel: rcu:         (t=5251 jiffies g=30829 q=183 ncpus=2)
Oct 28 21:56:56 eduvpn-n14 kernel: CPU: 1 UID: 65534 PID: 1140 Comm: openvpn Not tainted 7.2.9+deb13-amd64 #1 PREEMPT(lazy)  Debian 7.2.9-1~bpo13+1 
Oct 28 21:56:56 eduvpn-n14 kernel: Hardware name: Nutanix AHV/RHEL, BIOS edk2-20241117-11.0s9c17r2.el9 11/17/2024
Oct 28 21:56:56 eduvpn-n14 kernel: RIP: 0010:pv_native_safe_halt+0xf/0x20
Oct 28 21:56:56 eduvpn-n14 kernel: Code: 20 d0 c3 cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d b5 12 09 00 fb f4 <e9> fc 33 01 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 9>
Oct 28 21:56:56 eduvpn-n14 kernel: RSP: 0018:ff791788423871f0 EFLAGS: 00000246
Oct 28 21:56:56 eduvpn-n14 kernel: RAX: 0000000000000003 RBX: ff3c4bb82a4e1f44 RCX: 0000000000000009
Oct 28 21:56:56 eduvpn-n14 kernel: RDX: 0000000000000000 RSI: 0000000000000003 RDI: ff3c4bb82a4e1f44
Oct 28 21:56:56 eduvpn-n14 kernel: RBP: ff3c4bb877c73480 R08: 0000000000000200 R09: ff3c4bb8683928c0
Oct 28 21:56:56 eduvpn-n14 kernel: R10: 0000000000000020 R11: 0000000000000020 R12: 0000000000080000
Oct 28 21:56:56 eduvpn-n14 kernel: R13: 0000000000000001 R14: 0000000000000100 R15: 0000000000000000
Oct 28 21:56:56 eduvpn-n14 kernel: FS:  00007f6422242cc0(0000) GS:ff3c4bb8ceb2a000(0000) knlGS:0000000000000000
Oct 28 21:56:56 eduvpn-n14 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Oct 28 21:56:56 eduvpn-n14 kernel: CR2: 0000557856fdba60 CR3: 0000000108724003 CR4: 0000000000371ef0
Oct 28 21:56:56 eduvpn-n14 kernel: Call Trace:
Oct 28 21:56:56 eduvpn-n14 kernel:  <TASK>
Oct 28 21:56:56 eduvpn-n14 kernel:  kvm_wait+0x4f/0x60
Oct 28 21:56:56 eduvpn-n14 kernel:  __pv_queued_spin_lock_slowpath+0x264/0x370
Oct 28 21:56:56 eduvpn-n14 kernel:  _raw_spin_lock+0x29/0x30
Oct 28 21:56:56 eduvpn-n14 kernel:  ovpn_tcp_send_skb+0x4a/0x120 [ovpn]
Oct 28 21:56:56 eduvpn-n14 kernel:  ovpn_encrypt_post+0x141/0x1d0 [ovpn]
Oct 28 21:56:56 eduvpn-n14 kernel:  ovpn_send+0x171/0x220 [ovpn]
Oct 28 21:56:56 eduvpn-n14 kernel:  ? ovpn_send+0x31/0x220 [ovpn]
Oct 28 21:56:56 eduvpn-n14 kernel:  ovpn_net_xmit+0x2aa/0x570 [ovpn]
Oct 28 21:56:56 eduvpn-n14 kernel:  ? ovpn_net_xmit+0x1ee/0x570 [ovpn]
Oct 28 21:56:56 eduvpn-n14 kernel:  dev_hard_start_xmit+0x63/0x1d0
Oct 28 21:56:56 eduvpn-n14 kernel:  __dev_queue_xmit+0x729/0x1090
Oct 28 21:56:56 eduvpn-n14 kernel:  ? __dev_queue_xmit+0x2cc/0x1090
Oct 28 21:56:56 eduvpn-n14 kernel:  ip6_finish_output+0x182/0x3a0
Oct 28 21:56:56 eduvpn-n14 kernel:  ip6_output+0x84/0x170
Oct 28 21:56:56 eduvpn-n14 kernel:  ? __pfx_ip6_finish_output+0x10/0x10
Oct 28 21:56:56 eduvpn-n14 kernel:  ip6_xmit+0x2d8/0x6f0
Oct 28 21:56:56 eduvpn-n14 kernel:  ? __pfx_dst_output+0x10/0x10
Oct 28 21:56:56 eduvpn-n14 kernel:  inet6_csk_xmit+0xbb/0x140
Oct 28 21:56:56 eduvpn-n14 kernel:  __tcp_transmit_skb+0x6ca/0x1140
Oct 28 21:56:56 eduvpn-n14 kernel:  tcp_write_xmit+0x5c3/0x1780
Oct 28 21:56:56 eduvpn-n14 kernel:  __tcp_push_pending_frames+0x38/0x100
Oct 28 21:56:56 eduvpn-n14 kernel:  tcp_sendmsg_locked+0xe35/0x13c0
Oct 28 21:56:56 eduvpn-n14 kernel:  __skb_send_sock+0x128/0x4e0
Oct 28 21:56:56 eduvpn-n14 kernel:  ? __pfx_sendmsg_locked+0x10/0x10
Oct 28 21:56:56 eduvpn-n14 kernel:  ovpn_tcp_send_sock+0x75/0x1c0 [ovpn]
Oct 28 21:56:56 eduvpn-n14 kernel:  ovpn_tcp_release+0x14a/0x1f0 [ovpn]
Oct 28 21:56:56 eduvpn-n14 kernel:  release_sock+0x80/0xc0
Oct 28 21:56:56 eduvpn-n14 kernel:  ovpn_tcp_sendmsg+0xc4/0x220 [ovpn]
Oct 28 21:56:56 eduvpn-n14 kernel:  __sys_sendto+0x17e/0x1e0
Oct 28 21:56:56 eduvpn-n14 kernel:  __x64_sys_sendto+0x24/0x30
Oct 28 21:56:56 eduvpn-n14 kernel:  do_syscall_64+0xea/0x640
Oct 28 21:56:56 eduvpn-n14 kernel:  ? do_epoll_ctl+0x8d/0x100
Oct 28 21:56:56 eduvpn-n14 kernel:  ? __x64_sys_epoll_ctl+0x72/0xa0
Oct 28 21:56:56 eduvpn-n14 kernel:  ? vm_normal_page+0x37/0x100
Oct 28 21:56:56 eduvpn-n14 kernel:  ? _raw_spin_unlock+0xe/0x30
Oct 28 21:56:56 eduvpn-n14 kernel:  ? wp_page_reuse+0x8d/0xa0
Oct 28 21:56:56 eduvpn-n14 kernel:  ? do_wp_page+0x1ff/0xf20
Oct 28 21:56:56 eduvpn-n14 kernel:  ? sock_poll+0x54/0xe0
Oct 28 21:56:56 eduvpn-n14 kernel:  ? ep_item_poll.isra.0+0x53/0x90
Oct 28 21:56:56 eduvpn-n14 kernel:  ? __handle_mm_fault+0xa8c/0xf80
Oct 28 21:56:56 eduvpn-n14 kernel:  ? count_memcg_events+0xd9/0x1a0
Oct 28 21:56:56 eduvpn-n14 kernel:  ? handle_mm_fault+0x1e2/0x2e0
Oct 28 21:56:56 eduvpn-n14 kernel:  ? do_user_addr_fault+0x2c3/0x7f0
Oct 28 21:56:56 eduvpn-n14 kernel:  ? irqentry_exit+0x48/0x740
Oct 28 21:56:56 eduvpn-n14 kernel:  ? do_syscall_64+0x9f/0x640
Oct 28 21:56:56 eduvpn-n14 kernel:  ? clear_bhb_loop+0x60/0xb0
Oct 28 21:56:56 eduvpn-n14 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Oct 28 21:56:56 eduvpn-n14 kernel: RIP: 0033:0x7f6421a9b3a7
Oct 28 21:56:56 eduvpn-n14 kernel: Code: 48 89 fa 4c 89 df e8 78 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 f>
Oct 28 21:56:56 eduvpn-n14 kernel: RSP: 002b:00007ffcc6032010 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
Oct 28 21:56:56 eduvpn-n14 kernel: RAX: ffffffffffffffda RBX: 00007f6422242cc0 RCX: 00007f6421a9b3a7
Oct 28 21:56:56 eduvpn-n14 kernel: RDX: 00000000000004a4 RSI: 000055785553810f RDI: 0000000000000062
Oct 28 21:56:56 eduvpn-n14 kernel: RBP: 000055785555bf30 R08: 0000000000000000 R09: 0000000000000000
Oct 28 21:56:56 eduvpn-n14 kernel: R10: 0000000000004000 R11: 0000000000000202 R12: 0000557855552e28
Oct 28 21:56:56 eduvpn-n14 kernel: R13: 0000000000000000 R14: 00007ffcc6032130 R15: 0000557839c66e54
Oct 28 21:56:56 eduvpn-n14 kernel:  </TASK>
Oct 28 21:57:23 eduvpn-n14 kernel: watchdog: BUG: soft lockup - CPU#1 stuck for 48s! [openvpn:1140]
Oct 28 21:57:23 eduvpn-n14 kernel: Modules linked in: rpcsec_gss_krb5 krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace netfs cpuid wireguard libcurve25519 libchacha20poly1305 ovpn libchacha libpoly1305 ip6_udp_tunnel udp_tun>
Oct 28 21:57:23 eduvpn-n14 kernel: CPU: 1 UID: 65534 PID: 1140 Comm: openvpn Not tainted 7.2.9+deb13-amd64 #1 PREEMPT(lazy)  Debian 7.2.9-1~bpo13+1 
Oct 28 21:57:23 eduvpn-n14 kernel: Hardware name: Nutanix AHV/RHEL, BIOS edk2-20241117-11.0s9c17r2.el9 11/17/2024
Oct 28 21:57:23 eduvpn-n14 kernel: RIP: 0010:pv_native_safe_halt+0xf/0x20
Oct 28 21:57:23 eduvpn-n14 kernel: Code: 20 d0 c3 cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d b5 12 09 00 fb f4 <e9> fc 33 01 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 9>
Oct 28 21:57:23 eduvpn-n14 kernel: RSP: 0018:ff791788423871f0 EFLAGS: 00000246
Oct 28 21:57:23 eduvpn-n14 kernel: RAX: 0000000000000003 RBX: ff3c4bb82a4e1f44 RCX: 0000000000000009
Oct 28 21:57:23 eduvpn-n14 kernel: RDX: 0000000000000000 RSI: 0000000000000003 RDI: ff3c4bb82a4e1f44
Oct 28 21:57:23 eduvpn-n14 kernel: RBP: ff3c4bb877c73480 R08: 0000000000000200 R09: ff3c4bb8683928c0
Oct 28 21:57:23 eduvpn-n14 kernel: R10: 0000000000000020 R11: 0000000000000020 R12: 0000000000080000
Oct 28 21:57:23 eduvpn-n14 kernel: R13: 0000000000000001 R14: 0000000000000100 R15: 0000000000000000
Oct 28 21:57:23 eduvpn-n14 kernel: FS:  00007f6422242cc0(0000) GS:ff3c4bb8ceb2a000(0000) knlGS:0000000000000000
Oct 28 21:57:23 eduvpn-n14 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Oct 28 21:57:23 eduvpn-n14 kernel: CR2: 0000557856fdba60 CR3: 0000000108724003 CR4: 0000000000371ef0
Oct 28 21:57:23 eduvpn-n14 kernel: Call Trace:
Oct 28 21:57:23 eduvpn-n14 kernel:  <TASK>
Oct 28 21:57:23 eduvpn-n14 kernel:  kvm_wait+0x4f/0x60
Oct 28 21:57:23 eduvpn-n14 kernel:  __pv_queued_spin_lock_slowpath+0x264/0x370
Oct 28 21:57:23 eduvpn-n14 kernel:  _raw_spin_lock+0x29/0x30
Oct 28 21:57:23 eduvpn-n14 kernel:  ovpn_tcp_send_skb+0x4a/0x120 [ovpn]
Oct 28 21:57:23 eduvpn-n14 kernel:  ovpn_encrypt_post+0x141/0x1d0 [ovpn]
Oct 28 21:57:23 eduvpn-n14 kernel:  ovpn_send+0x171/0x220 [ovpn]
Oct 28 21:57:23 eduvpn-n14 kernel:  ? ovpn_send+0x31/0x220 [ovpn]
Oct 28 21:57:23 eduvpn-n14 kernel:  ovpn_net_xmit+0x2aa/0x570 [ovpn]
Oct 28 21:57:23 eduvpn-n14 kernel:  ? ovpn_net_xmit+0x1ee/0x570 [ovpn]
Oct 28 21:57:23 eduvpn-n14 kernel:  dev_hard_start_xmit+0x63/0x1d0
Oct 28 21:57:23 eduvpn-n14 kernel:  __dev_queue_xmit+0x729/0x1090

This is the last message that is written to the journal before the machine
becomes unresponsive, even on the Nutanix console.

I have upgraded to 7.2.11 now, but there was nothing in the changes pointing
to ovpn related fixes.

Bernhard

> 
> Thank you all for making OpenVPN 2.7 and ovpn DCO and all the surrounding
> stuff possible! And kudos to the EduVPN maintainers as well of course.
> 
> Best Regards and have a nice weekend,
> Bernhard
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-- 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
