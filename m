Message-ID: <49241A6D.6050104@...213...>
Date: Wed, 19 Nov 2008 09:53:49 -0400
From: James MacLean <macleajb@...213...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010804070807040704060605"
Subject: [Openvpn-devel] OpenVPN-2.1rc14 no go in 32 or 64 bit
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010804070807040704060605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Folks,

Sorry for posting here after also posting as a bug. Just wasn't on the 
ball subscribing this morning :(.

On a 64 bit Dell ( 2.6.25.4 #1 SMP Sat May 24 23:03:01 ADT 2008 x86_64 
x86_64 x86_64 GNU/Linux) we are servicing over 150 connections. Seems we 
have hit a magic number as the performance dropped yesterday. We were 
running 32bit rc7 and decided to try a 64bit rc14. After going forward 
and backwards, we could only get 32bit rc13 to run so that the clients 
would all automatically reconnect. When we try 64bit rc14 :

[Thread debugging using libthread_db enabled]
[New Thread 140014141425424 (LWP 25999)]
[Detaching after fork from child process 26002. (Try `set detach-on-fork
off'.)]
[Detaching after fork from child process 26006.]
[Detaching after fork from child process 26008.]

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 140014141425424 (LWP 25999)]
argv_clone (a=0x0, headroom=1) at misc.c:1867
1867 r.system_str = string_alloc (a->system_str, NULL);
(gdb) bt
#0 argv_clone (a=0x0, headroom=1) at misc.c:1867
#1 0x000000000041db5b in argv_insert_head (a=0x0, head=0x681418
"/usr/share/openvpn/plugin/lib/ednet64.so") at misc.c:1877
#2 0x000000000043511f in plugin_call (pl=0x6880d0, type=<value optimized
out>, av=0x0, pr=0x0, es=<value optimized out>) at plugin.c:343
#3 0x0000000000446a6a in key_method_2_read (buf=0x694108, multi=0x693db0,
session=0x693f90) at ssl.c:3055
#4 0x0000000000447c9c in tls_process (multi=0x693db0, session=0x693f90,
to_link=0x692be0, to_link_addr=0x7fff9d2ac1e8,
to_link_socket_info=0x6a24f8, wakeup=0x7fff9d2ac254)
at ssl.c:3801
#5 0x0000000000448754 in tls_multi_process (multi=0x693db0,
to_link=0x692be0, to_link_addr=0x692988, to_link_socket_info=0x6a24f8,
wakeup=0x7fff9d2ac254) at ssl.c:3973
#6 0x000000000040ecb5 in check_tls_dowork (c=0x6922c0) at forward.c:89
#7 0x000000000040eefc in pre_select (c=0x6922c0) at forward-inline.h:41
#8 0x0000000000424cbf in multi_process_post (m=0x7fff9d2ac550,
mi=0x692200, flags=5) at multi.c:1853
#9 0x00000000004261af in multi_process_incoming_link (m=0x7fff9d2ac550,
instance=<value optimized out>, mpp_flags=5) at multi.c:2094
#10 0x000000000042201c in tunnel_server_udp (top=0x7fff9d2ad0d0) at
mudp.c:170
#11 0x0000000000427db5 in main (argc=7, argv=0x7fff9d2adc28) at
openvpn.c:213

When we try 32bit :

[Detaching after fork from child process 26706. (Try `set detach-on-fork
off'.)]
[Detaching after fork from child process 26710.]
[Detaching after fork from child process 26711.]

Program received signal SIGSEGV, Segmentation fault.
0x0806334f in argv_clone (a=0x0, headroom=1) at misc.c:1867
1867 r.system_str = string_alloc (a->system_str, NULL);
(gdb) bt
#0 0x0806334f in argv_clone (a=0x0, headroom=1) at misc.c:1867
#1 0x08064e99 in argv_insert_head (a=0x0, head=0x80b7d64
"/usr/share/openvpn/plugin/lib/ednet.so") at misc.c:1877
#2 0x0807e383 in plugin_call (pl=0x80c4050, type=<value optimized out>,
av=0x0, pr=0x0, es=0x80bc710) at plugin.c:343
#3 0x08090aa3 in key_method_2_read (buf=0x80c4dac, multi=0x80c4b58,
session=0x80c4cac) at ssl.c:3055
#4 0x08091fcb in tls_process (multi=0x80c4b58, session=0x80c4cac,
to_link=0x80c3ae4, to_link_addr=0xffd5ed94, to_link_socket_info=0x80d26f4,
wakeup=0xffd5edd8) at ssl.c:3801
#5 0x08092af0 in tls_multi_process (multi=0x80c4b58, to_link=0x80c3ae4,
to_link_addr=0x80c3924, to_link_socket_info=0x80d26f4, wakeup=0xffd5edd8)
at ssl.c:3973
#6 0x08055697 in check_tls_dowork (c=0x80c346c) at forward.c:89
#7 0x080558df in pre_select (c=0x80c346c) at forward-inline.h:41
#8 0x0806c2f9 in multi_process_post (m=0xffd5efe8, mi=<value optimized
out>, flags=<value optimized out>) at multi.c:1853
#9 0x0806d973 in multi_process_incoming_link (m=0xffd5efe8, instance=0x0,
mpp_flags=5) at multi.c:2094
#10 0x08069312 in tunnel_server_udp (top=0xffd5f7f4) at mudp.c:170
#11 0x0806f67f in main (argc=7, argv=0xffd5ffe4) at openvpn.c:213

If I remove the reference to a->system_str in misc.c, it carries on.

64bitrc13 runs, but even though all the clients authenticate, they are 
not fully engaged and are not pingable. Maybe 64bit is not ready yet?

JES

--------------010804070807040704060605
Content-Type: text/x-vcard; charset=utf-8;
 name="macleajb.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="macleajb.vcf"

begin:vcard
fn:James B MacLean
n:MacLean;James B
org:Education;ITS Technical Services
adr:;;;Halifax;NS;;Canada
email;internet:macleajb@...213...
url:http://www.ednet.ns.ca/~macleajb
version:2.1
end:vcard


--------------010804070807040704060605--

