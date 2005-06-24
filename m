Message-ID: <20050624201824.19628.qmail@...426...>
From: ov <ov2k@...109...>
Subject: Re: [Openvpn-devel] ARM port
In-Reply-To: <Pine.LNX.4.58.0506241158490.10675@...41...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Jun 24 13:20:32 2005
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

* What are the values of x, y, and mod when the assertion is hit?
32, -1, 64

* A call stack trace would be nice, i.e. which function was calling
modulo_add when the assertion was hit?

It's actually being called through the macro CIRC_LIST_PUSH (p->seq_list,
SEQ_UNSEEN);

#0  packet_id_add (p=0xbffff02c, pin=0xbfffe9bc) at packet_id.c:116
#1  0x0000d628 in openvpn_decrypt (buf=0xbfffea74, work=
      {capacity = 1596, offset = 56, len = 97, data = 0x7425c ""}, 
    opt=0xbffff014, frame=0xbfffe9e0) at crypto.c:364
#2  0x0000ef54 in test_crypto (co=0xbffff014, frame=0xbfffeef4) at
crypto.c:883
#3  0x00019ec0 in test_crypto_thread (arg=0x4a488) at init.c:2635
#4  0x00019f5c in do_test_crypto (o=0xbffff180) at init.c:2667
#5  0x00028884 in main (argc=4, argv=0xbffff844) at openvpn.c:175

* Does the assertion always hit in the test above immediately after packet
length=97?

Yes.

* What is the config file or command line which was used to generate the
test?
