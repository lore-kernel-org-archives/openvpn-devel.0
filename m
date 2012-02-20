MIME-Version: 1.0
Date: Mon, 20 Feb 2012 15:05:40 +0200
Message-ID: <CAOazyz0nDj78COr6sd4FAMPz3sML0+-5ZNOx7s_62qtk12tnag@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: [Openvpn-devel] [CRASH] on master
	/packet_id.c::packet_id_debug_print
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Hi,

Master with verb 255 I get the following after a few packets...
Can someone else try out to see if it reproduced?

tls-client
tls-cipher DHE-RSA-AES256-SHA
cipher AES-256-CBC
Server DH 4096bit
Server certificate 2048bit
Client certificate 2048bit

Mon Feb 20 14:53:58 2012 us=139424 TCPv4_CLIENT read returned 149
Mon Feb 20 14:53:58 2012 us=139473 TCPv4_CLIENT READ [149] from
[AF_INET]95.35.21.149:443: P_DATA_V1 kid=0 DATA b008ba2f 08bde634
fce22834 7b91d496 4c8db39b 32fc6c52 cf5ccf81 7b63584[more...]
Mon Feb 20 14:53:58 2012 us=139486 TLS: tls_pre_decrypt, key_id=0,
IP=[AF_INET]95.35.21.149:443
Mon Feb 20 14:53:58 2012 us=139502 DECRYPT IV: 32fc6c52 cf5ccf81
7b635843 681dbd25
Mon Feb 20 14:53:58 2012 us=139536 DECRYPT TO: 00000001 fa450000
610c5c00 007f1136 6d0a0a32 02c0a8fc 0e0035b5 55004d0[more...]

Program received signal SIGSEGV, Segmentation fault.
packet_id_debug_print (msglevel=1174405255, p=0x555555833858,
pin=0x7fffffffc8b0,
    message=0x5555555e5f80 "PID_TEST", value=0) at ../packet_id.c:498
498       for (i = 0; i < sl->x_size; ++i)

#0  packet_id_debug_print (msglevel=1174405255, p=0x555555833858,
pin=0x7fffffffc8b0,
    message=0x5555555e5f80 "PID_TEST", value=0) at ../packet_id.c:498
#1  0x00005555555a6bcc in packet_id_debug (value=0,
message=0x5555555e5f80 "PID_TEST",
    pin=0x7fffffffc8b0, p=0x555555833858, msglevel=1174405255) at
../packet_id.c:68
#2  packet_id_test (p=0x555555833858, pin=0x7fffffffc8b0) at ../packet_id.c:191
#3  0x0000555555560185 in openvpn_decrypt (buf=0x7fffffffd678,
work=..., opt=0x7fffffffd598,
    frame=<optimized out>) at ../crypto.c:340
#4  0x0000555555569ce1 in process_incoming_link (c=0x7fffffffca00) at
../forward.c:826
#5  0x00005555555929fa in tunnel_point_to_point (c=0x7fffffffca00) at
../openvpn.c:89
#6  main (argc=7, argv=0x7fffffffd978) at ../openvpn.c:242

