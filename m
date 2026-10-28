Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C58C606A31D
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 21:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jrX+EOBg;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=F9Ufe1vY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=C0IBzSEM;
	dkim=neutral header.d=unstable.cc header.i=@unstable.cc header.a=rsa-sha256 header.s=MBO0001 header.b=D8V0j0hh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=wBpuGNJSKdCDrcAMC+vMuwrtdCfSlD8XYj2iWqjscSE=; b=jrX+EOBga2hdGz
	s3Pb52EvjxiNq6gOa0SqsyrYEdZplelituEBJgUuZKVyL/gvKSfZecD+Xaa64wIMUMElmPEaswLNH
	oDzlcYrmJhkoq8Nk45jKNCK3Ug3mthfZ6q5E3OkZOB529RoOZXKTIJPuN+XGqcAFcH7b4fi94tyW2
	dCM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMBPb-00000000224-2L9L;
	Wed, 28 Oct 2026 21:42:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <a@unstable.cc>) id 1xMBPZ-0000000021v-3drC
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 21:42:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yRHUo2vUpu7lEnWeMASg9i4j4Kuo9iVQE7icWr/BXSE=; b=F9Ufe1vY9bf71YmsMi8RJTsEip
 XNs2WZrQYBV46Vwwb3fRsr8CW9lQf8FgS7I5xKPINWLAyZRaCjDhXiXBhra1mMoSIvgbr+A0PBCXj
 U9ESeZFEPg4P/9MoP6yDMK01taED5bmaGkp7XvjSp/B6Zp1L+7UlpmxRzYaZYA8bXU3M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yRHUo2vUpu7lEnWeMASg9i4j4Kuo9iVQE7icWr/BXSE=; b=C0IBzSEM2LPamuIvb7rDMKMOAA
 DZ1eNsdXBnPMbGxItKzWepnXdKRF2AcbRBXQdSAKkSURop6NfSg0jtc82VUOjjlmGzZTXtyHhaUyG
 fi+8189rWKkQpbxVYJliMF/2ZZzGCcc4h8L9rNS01aMjWOJSwgiBtaFvMABth6PIjV/I=;
Received: from mout-p-103.mailbox.org ([80.241.56.161])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMBPY-000000003uh-2ZwQ for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 21:42:21 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jFLRl4hffzKnnx;
 Wed, 28 Oct 2026 22:42:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1793223731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yRHUo2vUpu7lEnWeMASg9i4j4Kuo9iVQE7icWr/BXSE=;
 b=D8V0j0hhrQ8jtbLECOLiLBI9GdJ+CbIAmnFqWkdoXlCFaUxN84WMnFWVNiFC2Y3nNAfT9s
 OLM0H3o33RIpeczANpOVRB9W1hURRKw9WpqSotJZuUPhQHT6MKj3sFb3hW1pZckgqCiz9n
 gcmoFMRscXp9juSUQq3Qb6ZBMtgoCpf3JsYRuiTIq9WxkUVUAM4w095EWdfcdQG2DpbE/4
 YhSnamZXWZJzOFx3CR0zbZEp4SICK/nxBp76qcNCiMxfwa3cf3rGFeinfFdDfS7B0R8nCe
 UyP2YBFdqlLyFkFBHFCVPx5rGSAnI6uaMFjW0M+Xw9gFgqHy4MerZdUqp30IIQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=a@unstable.cc
Message-ID: <60758dd9-bc8e-4cda-b62c-11aeca9230a1@unstable.cc>
Date: Wed, 28 Oct 2026 22:42:08 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Bernhard Schmidt <berni@birkenwald.de>, openvpn-devel@lists.sourceforge.net
References: <ea6e57f3-3d91-4d3f-9c28-471dc1021bcd@birkenwald.de>
 <auJj5Ld6uMjPb2eS@fliwatuet.svr02.mucip.net>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <auJj5Ld6uMjPb2eS@fliwatuet.svr02.mucip.net>
X-Rspamd-Queue-Id: 4jFLRl4hffzKnnx
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMBPY-000000003uh-2ZwQ
Subject: Re: [Openvpn-devel] Kernel lockup in ovpn ovpn_tcp_send_skb
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Bernhard,

On 28/10/2026 22:06, Bernhard Schmidt wrote:
> On 09/10/26 04:34 PM, Bernhard Schmidt wrote:
> 
>> We have seen two segfaults during the night, but I hope they go away
>> upgrading to 2.7.8. If not I will report here. The process was restarted by
>> systemd and noone noticed.
> 
> Segfaults have not reappeared, but we now have a node that exhibits
> frequent (sometimes after < 10 minutes of uptime) kernel lockups.

One you'll tell us what's your secret...but please, keep reporting stuff 
so we can keep fixing them :-)

> 
> Oct 28 21:56:56 eduvpn-n14 kernel: rcu: INFO: rcu_preempt self-detected stall on CPU
> Oct 28 21:56:56 eduvpn-n14 kernel: rcu:         1-....: (1 GPs behind) idle=acbc/1/0x4000000000000000 softirq=21504/21505 fqs=2625
> Oct 28 21:56:56 eduvpn-n14 kernel: rcu:         (t=5251 jiffies g=30829 q=183 ncpus=2)
> Oct 28 21:56:56 eduvpn-n14 kernel: CPU: 1 UID: 65534 PID: 1140 Comm: openvpn Not tainted 7.2.9+deb13-amd64 #1 PREEMPT(lazy)  Debian 7.2.9-1~bpo13+1
> Oct 28 21:56:56 eduvpn-n14 kernel: Hardware name: Nutanix AHV/RHEL, BIOS edk2-20241117-11.0s9c17r2.el9 11/17/2024
> Oct 28 21:56:56 eduvpn-n14 kernel: RIP: 0010:pv_native_safe_halt+0xf/0x20
> Oct 28 21:56:56 eduvpn-n14 kernel: Code: 20 d0 c3 cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d b5 12 09 00 fb f4 <e9> fc 33 01 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 9>
> Oct 28 21:56:56 eduvpn-n14 kernel: RSP: 0018:ff791788423871f0 EFLAGS: 00000246
> Oct 28 21:56:56 eduvpn-n14 kernel: RAX: 0000000000000003 RBX: ff3c4bb82a4e1f44 RCX: 0000000000000009
> Oct 28 21:56:56 eduvpn-n14 kernel: RDX: 0000000000000000 RSI: 0000000000000003 RDI: ff3c4bb82a4e1f44
> Oct 28 21:56:56 eduvpn-n14 kernel: RBP: ff3c4bb877c73480 R08: 0000000000000200 R09: ff3c4bb8683928c0
> Oct 28 21:56:56 eduvpn-n14 kernel: R10: 0000000000000020 R11: 0000000000000020 R12: 0000000000080000
> Oct 28 21:56:56 eduvpn-n14 kernel: R13: 0000000000000001 R14: 0000000000000100 R15: 0000000000000000
> Oct 28 21:56:56 eduvpn-n14 kernel: FS:  00007f6422242cc0(0000) GS:ff3c4bb8ceb2a000(0000) knlGS:0000000000000000
> Oct 28 21:56:56 eduvpn-n14 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Oct 28 21:56:56 eduvpn-n14 kernel: CR2: 0000557856fdba60 CR3: 0000000108724003 CR4: 0000000000371ef0
> Oct 28 21:56:56 eduvpn-n14 kernel: Call Trace:
> Oct 28 21:56:56 eduvpn-n14 kernel:  <TASK>
> Oct 28 21:56:56 eduvpn-n14 kernel:  kvm_wait+0x4f/0x60
> Oct 28 21:56:56 eduvpn-n14 kernel:  __pv_queued_spin_lock_slowpath+0x264/0x370
> Oct 28 21:56:56 eduvpn-n14 kernel:  _raw_spin_lock+0x29/0x30
> Oct 28 21:56:56 eduvpn-n14 kernel:  ovpn_tcp_send_skb+0x4a/0x120 [ovpn]
> Oct 28 21:56:56 eduvpn-n14 kernel:  ovpn_encrypt_post+0x141/0x1d0 [ovpn]
> Oct 28 21:56:56 eduvpn-n14 kernel:  ovpn_send+0x171/0x220 [ovpn]
> Oct 28 21:56:56 eduvpn-n14 kernel:  ? ovpn_send+0x31/0x220 [ovpn]
> Oct 28 21:56:56 eduvpn-n14 kernel:  ovpn_net_xmit+0x2aa/0x570 [ovpn]
> Oct 28 21:56:56 eduvpn-n14 kernel:  ? ovpn_net_xmit+0x1ee/0x570 [ovpn]
> Oct 28 21:56:56 eduvpn-n14 kernel:  dev_hard_start_xmit+0x63/0x1d0
> Oct 28 21:56:56 eduvpn-n14 kernel:  __dev_queue_xmit+0x729/0x1090
> Oct 28 21:56:56 eduvpn-n14 kernel:  ? __dev_queue_xmit+0x2cc/0x1090
> Oct 28 21:56:56 eduvpn-n14 kernel:  ip6_finish_output+0x182/0x3a0
> Oct 28 21:56:56 eduvpn-n14 kernel:  ip6_output+0x84/0x170
> Oct 28 21:56:56 eduvpn-n14 kernel:  ? __pfx_ip6_finish_output+0x10/0x10
> Oct 28 21:56:56 eduvpn-n14 kernel:  ip6_xmit+0x2d8/0x6f0
> Oct 28 21:56:56 eduvpn-n14 kernel:  ? __pfx_dst_output+0x10/0x10
> Oct 28 21:56:56 eduvpn-n14 kernel:  inet6_csk_xmit+0xbb/0x140
> Oct 28 21:56:56 eduvpn-n14 kernel:  __tcp_transmit_skb+0x6ca/0x1140
> Oct 28 21:56:56 eduvpn-n14 kernel:  tcp_write_xmit+0x5c3/0x1780
> Oct 28 21:56:56 eduvpn-n14 kernel:  __tcp_push_pending_frames+0x38/0x100
> Oct 28 21:56:56 eduvpn-n14 kernel:  tcp_sendmsg_locked+0xe35/0x13c0
> Oct 28 21:56:56 eduvpn-n14 kernel:  __skb_send_sock+0x128/0x4e0
> Oct 28 21:56:56 eduvpn-n14 kernel:  ? __pfx_sendmsg_locked+0x10/0x10
> Oct 28 21:56:56 eduvpn-n14 kernel:  ovpn_tcp_send_sock+0x75/0x1c0 [ovpn]
> Oct 28 21:56:56 eduvpn-n14 kernel:  ovpn_tcp_release+0x14a/0x1f0 [ovpn]
> Oct 28 21:56:56 eduvpn-n14 kernel:  release_sock+0x80/0xc0
> Oct 28 21:56:56 eduvpn-n14 kernel:  ovpn_tcp_sendmsg+0xc4/0x220 [ovpn]
> Oct 28 21:56:56 eduvpn-n14 kernel:  __sys_sendto+0x17e/0x1e0
> Oct 28 21:56:56 eduvpn-n14 kernel:  __x64_sys_sendto+0x24/0x30
> Oct 28 21:56:56 eduvpn-n14 kernel:  do_syscall_64+0xea/0x640
> Oct 28 21:56:56 eduvpn-n14 kernel:  ? do_epoll_ctl+0x8d/0x100
> Oct 28 21:56:56 eduvpn-n14 kernel:  ? __x64_sys_epoll_ctl+0x72/0xa0
> Oct 28 21:56:56 eduvpn-n14 kernel:  ? vm_normal_page+0x37/0x100
> Oct 28 21:56:56 eduvpn-n14 kernel:  ? _raw_spin_unlock+0xe/0x30
> Oct 28 21:56:56 eduvpn-n14 kernel:  ? wp_page_reuse+0x8d/0xa0
> Oct 28 21:56:56 eduvpn-n14 kernel:  ? do_wp_page+0x1ff/0xf20
> Oct 28 21:56:56 eduvpn-n14 kernel:  ? sock_poll+0x54/0xe0
> Oct 28 21:56:56 eduvpn-n14 kernel:  ? ep_item_poll.isra.0+0x53/0x90
> Oct 28 21:56:56 eduvpn-n14 kernel:  ? __handle_mm_fault+0xa8c/0xf80
> Oct 28 21:56:56 eduvpn-n14 kernel:  ? count_memcg_events+0xd9/0x1a0
> Oct 28 21:56:56 eduvpn-n14 kernel:  ? handle_mm_fault+0x1e2/0x2e0
> Oct 28 21:56:56 eduvpn-n14 kernel:  ? do_user_addr_fault+0x2c3/0x7f0
> Oct 28 21:56:56 eduvpn-n14 kernel:  ? irqentry_exit+0x48/0x740
> Oct 28 21:56:56 eduvpn-n14 kernel:  ? do_syscall_64+0x9f/0x640
> Oct 28 21:56:56 eduvpn-n14 kernel:  ? clear_bhb_loop+0x60/0xb0
> Oct 28 21:56:56 eduvpn-n14 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e

So, it seems this is a deadlock due to an OpenVPN TCP transport packet 
that is routed back into the ovpn device, thus hitting the lock that was 
already held on the TCP socket.

We just confirmed the theory locally in a VM by artificially forcing the 
above scenario.


It may happen when a client with an already established tunnel attempts 
a reconnection to the same server over the existing tunnel (i.e. due to 
traffic redirection).

This scenario should lead to what you have witnessed because the server 
records the VPN IP as transport IP, thus triggering the re-injection.

But this is just speculation - you may have hit another case that 
triggers the same "re-injection" behaviour.

In any case, what triggers it is not important for fixing the bug.
We basically lack a loop avoidance mechanism for TCP.



Thanks!
Cheers,



> Oct 28 21:56:56 eduvpn-n14 kernel: RIP: 0033:0x7f6421a9b3a7
> Oct 28 21:56:56 eduvpn-n14 kernel: Code: 48 89 fa 4c 89 df e8 78 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 f>
> Oct 28 21:56:56 eduvpn-n14 kernel: RSP: 002b:00007ffcc6032010 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
> Oct 28 21:56:56 eduvpn-n14 kernel: RAX: ffffffffffffffda RBX: 00007f6422242cc0 RCX: 00007f6421a9b3a7
> Oct 28 21:56:56 eduvpn-n14 kernel: RDX: 00000000000004a4 RSI: 000055785553810f RDI: 0000000000000062
> Oct 28 21:56:56 eduvpn-n14 kernel: RBP: 000055785555bf30 R08: 0000000000000000 R09: 0000000000000000
> Oct 28 21:56:56 eduvpn-n14 kernel: R10: 0000000000004000 R11: 0000000000000202 R12: 0000557855552e28
> Oct 28 21:56:56 eduvpn-n14 kernel: R13: 0000000000000000 R14: 00007ffcc6032130 R15: 0000557839c66e54
> Oct 28 21:56:56 eduvpn-n14 kernel:  </TASK>
> Oct 28 21:57:23 eduvpn-n14 kernel: watchdog: BUG: soft lockup - CPU#1 stuck for 48s! [openvpn:1140]
> Oct 28 21:57:23 eduvpn-n14 kernel: Modules linked in: rpcsec_gss_krb5 krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace netfs cpuid wireguard libcurve25519 libchacha20poly1305 ovpn libchacha libpoly1305 ip6_udp_tunnel udp_tun>
> Oct 28 21:57:23 eduvpn-n14 kernel: CPU: 1 UID: 65534 PID: 1140 Comm: openvpn Not tainted 7.2.9+deb13-amd64 #1 PREEMPT(lazy)  Debian 7.2.9-1~bpo13+1
> Oct 28 21:57:23 eduvpn-n14 kernel: Hardware name: Nutanix AHV/RHEL, BIOS edk2-20241117-11.0s9c17r2.el9 11/17/2024
> Oct 28 21:57:23 eduvpn-n14 kernel: RIP: 0010:pv_native_safe_halt+0xf/0x20
> Oct 28 21:57:23 eduvpn-n14 kernel: Code: 20 d0 c3 cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d b5 12 09 00 fb f4 <e9> fc 33 01 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 9>
> Oct 28 21:57:23 eduvpn-n14 kernel: RSP: 0018:ff791788423871f0 EFLAGS: 00000246
> Oct 28 21:57:23 eduvpn-n14 kernel: RAX: 0000000000000003 RBX: ff3c4bb82a4e1f44 RCX: 0000000000000009
> Oct 28 21:57:23 eduvpn-n14 kernel: RDX: 0000000000000000 RSI: 0000000000000003 RDI: ff3c4bb82a4e1f44
> Oct 28 21:57:23 eduvpn-n14 kernel: RBP: ff3c4bb877c73480 R08: 0000000000000200 R09: ff3c4bb8683928c0
> Oct 28 21:57:23 eduvpn-n14 kernel: R10: 0000000000000020 R11: 0000000000000020 R12: 0000000000080000
> Oct 28 21:57:23 eduvpn-n14 kernel: R13: 0000000000000001 R14: 0000000000000100 R15: 0000000000000000
> Oct 28 21:57:23 eduvpn-n14 kernel: FS:  00007f6422242cc0(0000) GS:ff3c4bb8ceb2a000(0000) knlGS:0000000000000000
> Oct 28 21:57:23 eduvpn-n14 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Oct 28 21:57:23 eduvpn-n14 kernel: CR2: 0000557856fdba60 CR3: 0000000108724003 CR4: 0000000000371ef0
> Oct 28 21:57:23 eduvpn-n14 kernel: Call Trace:
> Oct 28 21:57:23 eduvpn-n14 kernel:  <TASK>
> Oct 28 21:57:23 eduvpn-n14 kernel:  kvm_wait+0x4f/0x60
> Oct 28 21:57:23 eduvpn-n14 kernel:  __pv_queued_spin_lock_slowpath+0x264/0x370
> Oct 28 21:57:23 eduvpn-n14 kernel:  _raw_spin_lock+0x29/0x30
> Oct 28 21:57:23 eduvpn-n14 kernel:  ovpn_tcp_send_skb+0x4a/0x120 [ovpn]
> Oct 28 21:57:23 eduvpn-n14 kernel:  ovpn_encrypt_post+0x141/0x1d0 [ovpn]
> Oct 28 21:57:23 eduvpn-n14 kernel:  ovpn_send+0x171/0x220 [ovpn]
> Oct 28 21:57:23 eduvpn-n14 kernel:  ? ovpn_send+0x31/0x220 [ovpn]
> Oct 28 21:57:23 eduvpn-n14 kernel:  ovpn_net_xmit+0x2aa/0x570 [ovpn]
> Oct 28 21:57:23 eduvpn-n14 kernel:  ? ovpn_net_xmit+0x1ee/0x570 [ovpn]
> Oct 28 21:57:23 eduvpn-n14 kernel:  dev_hard_start_xmit+0x63/0x1d0
> Oct 28 21:57:23 eduvpn-n14 kernel:  __dev_queue_xmit+0x729/0x1090
> 
> This is the last message that is written to the journal before the machine
> becomes unresponsive, even on the Nutanix console.
> 
> I have upgraded to 7.2.11 now, but there was nothing in the changes pointing
> to ovpn related fixes.
> 
> Bernhard
> 
>>
>> Thank you all for making OpenVPN 2.7 and ovpn DCO and all the surrounding
>> stuff possible! And kudos to the EduVPN maintainers as well of course.
>>
>> Best Regards and have a nice weekend,
>> Bernhard
>>
>>
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

-- 
Antonio Quartulli



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
