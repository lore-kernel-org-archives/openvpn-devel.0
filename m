Message-ID: <526ECAEE.3070606@...1847...>
Date: Mon, 28 Oct 2013 21:37:02 +0100
From: Andre Valentin <avalentin@...1847...>
MIME-Version: 1.0
References: <4a53f8df-5bfc-41ae-9e10-b582e3a68f82@...1848...>
In-Reply-To: <4a53f8df-5bfc-41ae-9e10-b582e3a68f82@...1848...>
Subject: Re: [Openvpn-devel] [PATCH] Floating: Add support for floating in
 TLS mode (V2)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi!

While running my patched openvpn in gdb, I had this error multiple times no=
w:
---------------------------------------------------------------------------=
----
Fri Oct 25 16:41:19 2013 84.139.3.24:40797 Data Channel Decrypt: Cipher 'AE=
S-256-CBC' initialized with 256 bit key
Fri Oct 25 16:41:19 2013 84.139.3.24:40797 Data Channel Decrypt: Using 160 =
bit message hash 'SHA1' for HMAC authentication
Fri Oct 25 16:41:19 2013 84.139.3.24:40797 Control Channel: TLSv1.2, cipher=
 TLSv1/SSLv3 DHE-RSA-AES256-GCM-SHA384, 2048 bit RSA
Fri Oct 25 16:41:19 2013 84.139.3.24:40797 [avalentin] Peer Connection Init=
iated with [AF_INET]84.139.3.24:40797

Program received signal SIGSEGV, Segmentation fault.
0x0000000000462881 in tls_common_name (multi=3D0x789b80, null=3Dnull@...1852...=
1...=3Dtrue) at ssl_verify.c:133
133       if (ret && strlen (ret))
(gdb) bt
#0  0x0000000000462881 in tls_common_name (multi=3D0x789b80, null=3Dnull@...1186...=
.1851...=3Dtrue) at ssl_verify.c:133
#1  0x00000000004302dc in multi_delete_dup (new_mi=3D<optimized out>, m=3D<=
optimized out>) at multi.c:1207
#2  multi_connection_established (m=3Dm@...1851...=3D0x7fffffffcaf0, mi=3Dm=
i@...1851...=3D0x71b550) at multi.c:1620
#3  0x0000000000431196 in multi_process_post (m=3Dm@...1851...=3D0x7fffffff=
caf0, mi=3D0x71b550, flags=3Dflags@...1851...=3D5) at multi.c:2054
#4  0x00000000004316e0 in multi_process_incoming_link (m=3Dm@...1851...=3D0=
x7fffffffcaf0, instance=3Dinstance@...1851...=3D0x0, mpp_flags=3Dmpp_flags@=
...1851...=3D5) at multi.c:2278
#5  0x000000000042c476 in multi_process_io_udp (m=3D0x7fffffffcaf0) at mudp=
.c:285
#6  tunnel_server_udp_single_threaded (top=3D0x7fffffffd890) at mudp.c:378
#7  0x000000000042cd95 in tunnel_server_udp (top=3D<optimized out>) at mudp=
.c:400
#8  0x0000000000432086 in tunnel_server (top=3Dtop@...1851...=3D0x7fffffffd=
890) at multi.c:2860
#9  0x0000000000433be8 in openvpn_main (argc=3D7, argv=3D0x7fffffffe628) at=
 openvpn.c:253
#10 0x00007ffff6bdcead in __libc_start_main () from /lib/x86_64-linux-gnu/l=
ibc.so.6
#11 0x0000000000408441 in _start ()
---------------------------------------------------------------------------=
----
This happens always after some days. Usually there is only one client, which
floats around. I do not see any reason why my code should produce this.

Any ideas? I do not have any...

Andr=C3=A9


On 23.10.2013 09:54, Andr=C3=A9 Valentin wrote:
> Add support for floating in tls mode using the HMAC of a packet. It costs
> a roundtrip through the clients. Its security comes from a secret key, bo=
th
> peers have. This key and the data form the signature used, which is then
> checked againts existing peer connections. Therefore a good auth algo is
> recommended.
>

