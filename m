Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F01CD4F39
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 13:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=onIYbExPDp8xWGytPa1cEUFMoAAe83pUPtaEDKEKU1g=; b=blXxbKrYj3C2VxlyhlhKZgSmy+
	Vl5DsFvuy4ahohU4b/6yHF8yfDyJeJhiTr22hY/ZAMXXKcsGFbLLypCERCGBM+hBqas+dVZvt4W+f
	VB14QMmR2jRs0GbTnIMebmWwFp/vefUEFHy/2uS2/0b/dOmeU8GzarQ27E89iS7PzajE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNWBg-000387-Qt;
	Thu, 14 May 2026 13:33:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wNWBf-00037q-5p
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 13:33:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fCV6/+/IoJB9iacBmhln3+04ioswVu+/CrzuungQaEk=; b=U+OMv4ws8KqiW8pu8K02VgU8hy
 bZvKRcZ23x9oJsoKRO9A+MkyHwnVb5RaZ4NvsDWgecEcFObFnflN2evYtO1EB8YiiE4G+HOWJA0Rb
 JW2ORrAbs9QQOh6Iq9wsXjZC9U3x5lleWA9ss5TDUeKfC0z6Z2lqsJu4Tnv9FxgDChY8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fCV6/+/IoJB9iacBmhln3+04ioswVu+/CrzuungQaEk=; b=E
 0CBKeYY/tp3W5Ruu2entCz7aGRc5tmlPIwSZOtY3ldFrEQnanzufNuziH7yfuGhPE9RmZuLEqzEne
 18C+ynsoi66sIwVs4LyUFIsf8SYdGikIuR2zc86FVcWpHQijfN2xpYr8HEVx8wkyUuPurTsVx3MLQ
 0k/iyzFaN06RnNjc=;
Received: from mout-b-105.mailbox.org ([195.10.208.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNWBa-0007kS-W7 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 13:33:15 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4gGWVL3q3vz9xCy;
 Thu, 14 May 2026 15:32:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1778765578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fCV6/+/IoJB9iacBmhln3+04ioswVu+/CrzuungQaEk=;
 b=eMspLtqW9wjIjHC7BrOXdq458/2tY63W9WK64pflVBYMPdmZshgN7FHkJeb18LLkOh5Hwb
 lVeOIP/ZWGegYcJb41HhbcyunzFXIxaOIbVC95HNz3oxC2jstBBo+sL8kny2eCNN4ah0Yw
 EXJKxYMNXYg3gLZlDilvILAYEBe0c8sAIM/Zq3Wcg3K3JsMINlXOC+8eovzqDrKLqx1/Hc
 msT0DYNd0X+/4GO8+zUYBPv3HLkEv0qaA9RffE6+YqD0yklm62S2mPuru8q9HoRf+0rs+s
 jDOjBlDK/bktuMzz4PdeAALoaueZ9oEstQD0Z4LU5FKpT5VRVpnswvnIhUdndg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 14 May 2026 15:32:46 +0200
Message-ID: <20260514133246.466311-1-ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gGWVL3q3vz9xCy
X-Headers-End: 1wNWBa-0007kS-W7
Subject: [Openvpn-devel] [RFC PATCH ovpn net] locking/spinlock,
 ovpn: add spin_lock_bh_nested
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

ovpn_tcp_send_skb takes sk_lock.slock directly and may run from a
process-context crypto completion with BHs enabled. Since the same
socket spinlock is also acquired from softirq-side TCP paths via
bh_lock_sock, bottom halves must be disabled while holding sk_lock.slock
to avoid local softirq self-deadlock. The acquisition is also nested, so
the lockdep subclass annotation must be preserved.

spin_lock_nested provides the required lockdep subclass annotation, but
does not disable bottom halves. spin_lock_bh disables bottom halves, but
does not allow specifying a lockdep subclass.

Add spin_lock_bh_nested and the corresponding raw helper so callers can
combine the existing _bh locking semantics with nested lockdep
annotation. Implement the raw helper like the existing
_raw_spin_lock_bh, but pass the requested subclass to spin_acquire.

Use the new helper in ovpn_tcp_send_skb and pair it with spin_unlock_bh,
preventing softirq re-entry while sk_lock.slock is held without losing
the nested lockdep annotation.

As a side note, include/linux/xarray.h already has an xa_lock_bh_nested
wrapper which expands to spin_lock_bh_nested, but no caller currently
exercises it. This change provides the missing core helper as a real
implementation.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/tcp.c           |  4 ++--
 include/linux/spinlock.h         | 10 ++++++++++
 include/linux/spinlock_api_smp.h |  2 ++
 include/linux/spinlock_api_up.h  |  2 ++
 include/linux/spinlock_rt.h      |  7 +++++++
 kernel/locking/spinlock.c        |  8 ++++++++
 6 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 65054cc84be5..e9680f6df959 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -349,7 +349,7 @@ void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct sock *sk,
 
 	*(__be16 *)__skb_push(skb, sizeof(u16)) = htons(len);
 
-	spin_lock_nested(&sk->sk_lock.slock, OVPN_TCP_DEPTH_NESTING);
+	spin_lock_bh_nested(&sk->sk_lock.slock, OVPN_TCP_DEPTH_NESTING);
 	if (sock_owned_by_user(sk)) {
 		if (skb_queue_len(&peer->tcp.out_queue) >=
 		    READ_ONCE(net_hotdata.max_backlog)) {
@@ -362,7 +362,7 @@ void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct sock *sk,
 		ovpn_tcp_send_sock_skb(peer, sk, skb);
 	}
 unlock:
-	spin_unlock(&sk->sk_lock.slock);
+	spin_unlock_bh(&sk->sk_lock.slock);
 }
 
 static void ovpn_tcp_release(struct sock *sk)
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 241277cd34cf..67ddff168d42 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -220,6 +220,8 @@ static inline void do_raw_spin_unlock(raw_spinlock_t *lock) __releases(lock)
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define raw_spin_lock_nested(lock, subclass) \
 	_raw_spin_lock_nested(lock, subclass)
+# define raw_spin_lock_bh_nested(lock, subclass) \
+	_raw_spin_lock_bh_nested(lock, subclass)
 
 # define raw_spin_lock_nest_lock(lock, nest_lock)			\
 	 do {								\
@@ -234,6 +236,8 @@ static inline void do_raw_spin_unlock(raw_spinlock_t *lock) __releases(lock)
  */
 # define raw_spin_lock_nested(lock, subclass)		\
 	_raw_spin_lock(((void)(subclass), (lock)))
+# define raw_spin_lock_bh_nested(lock, subclass)	\
+	_raw_spin_lock_bh(((void)(subclass), (lock)))
 # define raw_spin_lock_nest_lock(lock, nest_lock)	_raw_spin_lock(lock)
 #endif
 
@@ -360,6 +364,12 @@ do {								\
 	__release(spinlock_check(lock)); __acquire(lock);	\
 } while (0)
 
+#define spin_lock_bh_nested(lock, subclass)				\
+do {									\
+	raw_spin_lock_bh_nested(spinlock_check(lock), subclass);	\
+	__release(spinlock_check(lock)); __acquire(lock);		\
+} while (0)
+
 #define spin_lock_nest_lock(lock, nest_lock)				\
 do {									\
 	raw_spin_lock_nest_lock(spinlock_check(lock), nest_lock);	\
diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api_smp.h
index bda5e7a390cd..89954db6fd31 100644
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -22,6 +22,8 @@ int in_lock_functions(unsigned long addr);
 void __lockfunc _raw_spin_lock(raw_spinlock_t *lock)		__acquires(lock);
 void __lockfunc _raw_spin_lock_nested(raw_spinlock_t *lock, int subclass)
 								__acquires(lock);
+void __lockfunc _raw_spin_lock_bh_nested(raw_spinlock_t *lock, int subclass)
+								__acquires(lock);
 void __lockfunc
 _raw_spin_lock_nest_lock(raw_spinlock_t *lock, struct lockdep_map *map)
 								__acquires(lock);
diff --git a/include/linux/spinlock_api_up.h b/include/linux/spinlock_api_up.h
index a9d5c7c66e03..9e972942d099 100644
--- a/include/linux/spinlock_api_up.h
+++ b/include/linux/spinlock_api_up.h
@@ -63,6 +63,8 @@
 
 #define _raw_spin_lock(lock)			__LOCK(lock)
 #define _raw_spin_lock_nested(lock, subclass)	__LOCK(lock)
+#define _raw_spin_lock_bh_nested(lock, subclass)	\
+	__LOCK_BH(lock)
 #define _raw_read_lock(lock)			__LOCK(lock, shared)
 #define _raw_write_lock(lock)			__LOCK(lock)
 #define _raw_write_lock_nested(lock, subclass)	__LOCK(lock)
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index 373618a4243c..d14cfaa6f141 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -90,6 +90,13 @@ static __always_inline void spin_lock_bh(spinlock_t *lock)
 	rt_spin_lock(lock);
 }
 
+static __always_inline void spin_lock_bh_nested(spinlock_t *lock, int subclass)
+	__acquires(lock)
+{
+	local_bh_disable();
+	__spin_lock_nested(lock, subclass);
+}
+
 static __always_inline void spin_lock_irq(spinlock_t *lock)
 	__acquires(lock)
 {
diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index b42d293da38b..9b93dae1f4b0 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -384,6 +384,14 @@ void __lockfunc _raw_spin_lock_nested(raw_spinlock_t *lock, int subclass)
 }
 EXPORT_SYMBOL(_raw_spin_lock_nested);
 
+void __lockfunc _raw_spin_lock_bh_nested(raw_spinlock_t *lock, int subclass)
+{
+	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
+	spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
+	LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
+}
+EXPORT_SYMBOL(_raw_spin_lock_bh_nested);
+
 unsigned long __lockfunc _raw_spin_lock_irqsave_nested(raw_spinlock_t *lock,
 						   int subclass)
 {
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
