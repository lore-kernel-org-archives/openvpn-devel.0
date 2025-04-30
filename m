From: Antonio Quartulli <a@...2181...>
Date: Wed, 30 Apr 2025 14:32:49 +0200
Message-ID: <20250430123250.8627-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH ovpn-net-next 1/2] ovpn: don't access sk
 after release
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Antonio Quartulli <antonio@...515...>, sd@...2891...

From: Antonio Quartulli <antonio@...515...>

In case of UDP peer timeout, an openvpn client (userspace)
performs the following actions:
1. receives the peer deletion notification (reason=timeout)
2. closes the socket
3. deletes the ovpn interface

Upon 3. we have the following:
- dellink()
 - cancel_delayed_work_sync()
  - ovpn_peer_keepalive_work()
   - ovpn_socket_release()
    - synchronize_rcu()
At this point, due to 2., ovpn_sock->sock->sk becomes NULL and
ovpn_socket_release() will attempt dereferencing it, resulting
in the following crash log:

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000077: 0000 [#1] SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000003b8-0x00000000000003bf]
CPU: 12 UID: 0 PID: 162 Comm: kworker/12:1 Tainted: G           O        6.15.0-rc2-00635-g521139ac3840 #272 PREEMPT(full)
Tainted: [O]=OOT_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-20240910_120124-localhost 04/01/2014
Workqueue: events ovpn_peer_keepalive_work [ovpn]
RIP: 0010:ovpn_socket_release+0x23c/0x500 [ovpn]
Code: ea 03 80 3c 02 00 0f 85 71 02 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 64 24 18 49 8d bc 24 be 03 00 00 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 30
RSP: 0018:ffffc90000c9fb18 EFLAGS: 00010217
RAX: dffffc0000000000 RBX: ffff8881148d7940 RCX: ffffffff817787bb
RDX: 0000000000000077 RSI: 0000000000000008 RDI: 00000000000003be
RBP: ffffc90000c9fb30 R08: 0000000000000000 R09: fffffbfff0d3e840
R10: ffffffff869f4207 R11: 0000000000000000 R12: 0000000000000000
R13: ffff888115eb9300 R14: ffffc90000c9fbc8 R15: 000000000000000c
FS:  0000000000000000(0000) GS:ffff8882b0151000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f37266b6114 CR3: 00000000054a8000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
 <TASK>
 unlock_ovpn+0x8b/0xe0 [ovpn]
 ovpn_peer_keepalive_work+0xe3/0x540 [ovpn]
 ? ovpn_peers_free+0x780/0x780 [ovpn]
 ? lock_acquire+0x56/0x70
 ? process_one_work+0x888/0x1740
 process_one_work+0x933/0x1740
 ? pwq_dec_nr_in_flight+0x10b0/0x10b0
 ? move_linked_works+0x12d/0x2c0
 ? assign_work+0x163/0x270
 worker_thread+0x4d6/0xd90
 ? preempt_count_sub+0x4c/0x70
 ? process_one_work+0x1740/0x1740
 kthread+0x36c/0x710
 ? trace_preempt_on+0x8c/0x1e0
 ? kthread_is_per_cpu+0xc0/0xc0
 ? preempt_count_sub+0x4c/0x70
 ? _raw_spin_unlock_irq+0x36/0x60
 ? calculate_sigpending+0x7b/0xa0
 ? kthread_is_per_cpu+0xc0/0xc0
 ret_from_fork+0x3a/0x80
 ? kthread_is_per_cpu+0xc0/0xc0
 ret_from_fork_asm+0x11/0x20
 </TASK>
Modules linked in: ovpn(O)

Reason for accessing sk is because we need to retrieve its
protocol and continue the cleanup routine accordingly.

Fix the crash by storing the sk_protocol before releasing
the sk and invoking synchronize_rcu().

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 drivers/net/ovpn/socket.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
index a83cbab72591..ff499f0fc771 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -66,6 +66,7 @@ static bool ovpn_socket_put(struct ovpn_peer *peer, struct ovpn_socket *sock)
 void ovpn_socket_release(struct ovpn_peer *peer)
 {
 	struct ovpn_socket *sock;
+	u16 sk_protocol;
 	bool released;
 
 	might_sleep();
@@ -92,6 +93,7 @@ void ovpn_socket_release(struct ovpn_peer *peer)
 	 */
 	lock_sock(sock->sock->sk);
 	released = ovpn_socket_put(peer, sock);
+	sk_protocol = sock->sock->sk->sk_protocol;
 	release_sock(sock->sock->sk);
 
 	/* align all readers with sk_user_data being NULL */
@@ -99,9 +101,9 @@ void ovpn_socket_release(struct ovpn_peer *peer)
 
 	/* following cleanup should happen with lock released */
 	if (released) {
-		if (sock->sock->sk->sk_protocol == IPPROTO_UDP) {
+		if (sk_protocol == IPPROTO_UDP) {
 			netdev_put(sock->ovpn->dev, &sock->dev_tracker);
-		} else if (sock->sock->sk->sk_protocol == IPPROTO_TCP) {
+		} else if (sk_protocol == IPPROTO_TCP) {
 			/* wait for TCP jobs to terminate */
 			ovpn_tcp_socket_wait_finish(sock);
 			ovpn_peer_put(sock->peer);
-- 
2.49.0


