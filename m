Message-ID: <4DAEFAFC.60506@...1147...>
Date: Wed, 20 Apr 2011 17:25:48 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <BANLkTimYEg+6zW4boLrwnFrtKOk5A91Vhw@...278...>	<20110418145411.GQ21485@...1152...>	<BANLkTi=Y=KG3UGQMBL05H=YjprNG5eqPzg@...278...>	<20110418182314.GA2449@...1152...>
	<20110418184552.GD2449@...1152...>
In-Reply-To: <20110418184552.GD2449@...1152...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN memory usage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: openvpn-users@lists.sourceforge.net, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi *,

copying in the openvpn-devel list as they might be interested in this memory usage analysis as well....

Ralf Hildebrandt wrote:
> * Ralf Hildebrandt <Ralf.Hildebrandt@...1152...>:
>> * Fredrik Kers <fredrik.kers@...277...>:
>>> I measure the memory usage by checking the VmRSS (Resident Set Size) in
>>> /proc/[pid]/status before and after the clients connect (about 1000 of
>>> them).
>> So it's the same method (because that's what top and htop do).
>>
>>> I'm using a 64 bit system, maybe that will cause OpenVPN to consume
>>> more memory per client then your setup
>> Yes, that could be. It's 32Bit here.
> 
> pmap -d pid_of_openvpn 
> 
> is showing:
> 
> # pmap -d 1607
> 1607:   /usr/sbin/openvpn --writepid /var/run/openvpn.server.pid --syslog ovpn-server --cd /etc/openvpn --config /etc/openvpn/server.conf
> Address   Kbytes Mode  Offset           Device    Mapping
> 08048000     500 r-x-- 0000000000000000 068:00005 openvpn
> 080c5000       4 rwx-- 000000000007d000 068:00005 openvpn
> 080c6000      24 rwx-- 0000000000000000 000:00000   [ anon ]
> * 08b51000   41396 rwx-- 0000000000000000 000:00000   [ anon ]
> b7270000     132 rwx-- 0000000000000000 000:00000   [ anon ]
> ...
> bfef8000     132 rw--- 0000000000000000 000:00000   [ stack ]
> mapped: 46240K    writeable/private: 42304K    shared: 0K
> 
> The line starting with * shows the biggest chunk of memory in use.
> 

I'm running openvpn 2.1.4 on a 64bit system (CentSO 5.5 with openssl 0.9.8e). when the first client connects the openvpn server
gets "hit" by ~ 600 Kb (as seen using pmap). The size of the 'hit' most likely depends on the encryption cipher used.

I recompiled openvpn using
  ./configure --with-mem-check=valgrind
and then ran the server again using
  valgrind --tool=massif .../openvpn

this results in a nice memory report which you can view using
  ms_print massif.out.22218

turns out that most memory is allocated by the openssl libraries : CRYPTO_malloc
the memory trace is too large to show here, but there's tons of stuff in that 'ms_print' output.
Note that compression was NOT used in this example, apparently the openssl libs call deflateInit internally?

Timestep 49 is when the client connects: you see the memory usage jump from 327,520 bytes to 934,688.

--------------------------------------------------------------------------------
  n        time(i)         total(B)   useful-heap(B) extra-heap(B)    stacks(B)
--------------------------------------------------------------------------------
 48     36,072,833          327,520          276,102        51,418            0
 49     36,341,762          934,688          883,126        51,562            0
94.48% (883,126B) (heap allocation functions) malloc/new/new[], --alloc-fns, etc.
->82.41% (770,295B) 0x3858CDAD90: CRYPTO_malloc (in /lib64/libcrypto.so.0.9.8e)
| ->62.91% (588,016B) 0x3858CBFF34: ??? (in /lib64/libcrypto.so.0.9.8e)
| | ->14.02% (131,072B) 0x38578064B3: deflateInit2_ (in /usr/lib64/libz.so.1.2.3)
| | | ->14.02% (131,072B) 0x3857806622: deflateInit_ (in /usr/lib64/libz.so.1.2.3)
| | |   ->14.02% (131,072B) 0x3858CBFECA: ??? (in /lib64/libcrypto.so.0.9.8e)
| | |     ->14.02% (131,072B) 0x3858CBFA96: COMP_CTX_new (in /lib64/libcrypto.so.0.9.8e)
| | |       ->07.01% (65,536B) 0x385E025CDF: tls1_change_cipher_state (in /lib64/libssl.so.0.9.8e)
| | |       | ->07.01% (65,536B) 0x385E020492: ssl3_do_change_cipher_spec (in /lib64/libssl.so.0.9.8e)
| | |       |   ->07.01% (65,536B) 0x385E021952: ssl3_read_bytes (in /lib64/libssl.so.0.9.8e)
| | |       |     ->07.01% (65,536B) 0x385E0222AE: ssl3_get_message (in /lib64/libssl.so.0.9.8e)
| | |       |       ->07.01% (65,536B) 0x385E022B1B: ssl3_get_finished (in /lib64/libssl.so.0.9.8e)
| | |       |         ->07.01% (65,536B) 0x385E01A740: ssl3_accept (in /lib64/libssl.so.0.9.8e)
| | |       |           ->07.01% (65,536B) 0x385E021883: ssl3_read_bytes (in /lib64/libssl.so.0.9.8e)
| | |       |             ->07.01% (65,536B) 0x385E01E55F: ??? (in /lib64/libssl.so.0.9.8e)
| | |       |               ->07.01% (65,536B) 0x385E038F3F: ??? (in /lib64/libssl.so.0.9.8e)
| | |       |                 ->07.01% (65,536B) 0x3858C7678D: BIO_read (in /lib64/libcrypto.so.0.9.8e)
| | |       |                   ->07.01% (65,536B) 0x46F7A3: bio_read (ssl.c:2058)
| | |       |                     ->07.01% (65,536B) 0x46FA8F: key_state_read_plaintext (ssl.c:2148)
| | |       |                       ->07.01% (65,536B) 0x474859: tls_process (ssl.c:4075)
| | |       |                         ->07.01% (65,536B) 0x475420: tls_multi_process (ssl.c:4303)
| | |       |                           ->07.01% (65,536B) 0x411B4C: check_tls_dowork (forward.c:93)
| | |       |                             ->07.01% (65,536B) 0x41571F: check_tls (forward-inline.h:41)
| | |       |                               ->07.01% (65,536B) 0x415663: pre_select (forward.c:1304)
| | |       |                                 ->07.01% (65,536B) 0x439130: multi_process_post (multi.c:1876)
| | |       |                                   ->07.01% (65,536B) 0x439927: multi_process_incoming_link (multi.c:2110)
| | |       |                                     ->07.01% (65,536B) 0x43413B: multi_process_io_udp (mudp.c:170)
| | |       |                                       ->07.01% (65,536B) 0x4344AC: tunnel_server_udp_single_threaded (mudp.c:255)
| | |       |                                         ->07.01% (65,536B) 0x434885: tunnel_server_udp (mudp.c:277)
| | |       |                                           ->07.01% (65,536B) 0x43ACFB: tunnel_server (multi.c:2680)
| | |       |                                             ->07.01% (65,536B) 0x43D7F3: main (openvpn.c:211)
| | |       |
| | |       ->07.01% (65,536B) 0x385E025D9F: tls1_change_cipher_state (in /lib64/libssl.so.0.9.8e)
| | |         ->07.01% (65,536B) 0x385E01A9A5: ssl3_accept (in /lib64/libssl.so.0.9.8e)
| | |           ->07.01% (65,536B) 0x385E021883: ssl3_read_bytes (in /lib64/libssl.so.0.9.8e)
| | |             ->07.01% (65,536B) 0x385E01E55F: ??? (in /lib64/libssl.so.0.9.8e)
| | |               ->07.01% (65,536B) 0x385E038F3F: ??? (in /lib64/libssl.so.0.9.8e)
| | |                 ->07.01% (65,536B) 0x3858C7678D: BIO_read (in /lib64/libcrypto.so.0.9.8e)
| | |                   ->07.01% (65,536B) 0x46F7A3: bio_read (ssl.c:2058)
| | |                     ->07.01% (65,536B) 0x46FA8F: key_state_read_plaintext (ssl.c:2148)
| | |                       ->07.01% (65,536B) 0x474859: tls_process (ssl.c:4075)
| | |                         ->07.01% (65,536B) 0x475420: tls_multi_process (ssl.c:4303)
| | |                           ->07.01% (65,536B) 0x411B4C: check_tls_dowork (forward.c:93)
| | |                             ->07.01% (65,536B) 0x41571F: check_tls (forward-inline.h:41)
| | |                               ->07.01% (65,536B) 0x415663: pre_select (forward.c:1304)
| | |                                 ->07.01% (65,536B) 0x439130: multi_process_post (multi.c:1876)
| | |                                   ->07.01% (65,536B) 0x439927: multi_process_incoming_link (multi.c:2110)
| | |                                     ->07.01% (65,536B) 0x43413B: multi_process_io_udp (mudp.c:170)
| | |                                       ->07.01% (65,536B) 0x4344AC: tunnel_server_udp_single_threaded (mudp.c:255)
| | |                                         ->07.01% (65,536B) 0x434885: tunnel_server_udp (mudp.c:277)
| | |                                           ->07.01% (65,536B) 0x43ACFB: tunnel_server (multi.c:2680)
| | |                                             ->07.01% (65,536B) 0x43D7F3: main (openvpn.c:211)
| | |
| | ->14.02% (131,072B) 0x38578064C7: deflateInit2_ (in /usr/lib64/libz.so.1.2.3)
| | | ->14.02% (131,072B) 0x3857806622: deflateInit_ (in /usr/lib64/libz.so.1.2.3)
| | |   ->14.02% (131,072B) 0x3858CBFECA: ??? (in /lib64/libcrypto.so.0.9.8e)
| | |     ->14.02% (131,072B) 0x3858CBFA96: COMP_CTX_new (in /lib64/libcrypto.so.0.9.8e)
| | |       ->07.01% (65,536B) 0x385E025CDF: tls1_change_cipher_state (in /lib64/libssl.so.0.9.8e)
| | |       | ->07.01% (65,536B) 0x385E020492: ssl3_do_change_cipher_spec (in /lib64/libssl.so.0.9.8e)
| | |       |   ->07.01% (65,536B) 0x385E021952: ssl3_read_bytes (in /lib64/libssl.so.0.9.8e)
| | |       |     ->07.01% (65,536B) 0x385E0222AE: ssl3_get_message (in /lib64/libssl.so.0.9.8e)
| | |       |       ->07.01% (65,536B) 0x385E022B1B: ssl3_get_finished (in /lib64/libssl.so.0.9.8e)
| | |       |         ->07.01% (65,536B) 0x385E01A740: ssl3_accept (in /lib64/libssl.so.0.9.8e)
| | |       |           ->07.01% (65,536B) 0x385E021883: ssl3_read_bytes (in /lib64/libssl.so.0.9.8e)
| | |       |             ->07.01% (65,536B) 0x385E01E55F: ??? (in /lib64/libssl.so.0.9.8e)
| | |       |               ->07.01% (65,536B) 0x385E038F3F: ??? (in /lib64/libssl.so.0.9.8e)
| | |       |                 ->07.01% (65,536B) 0x3858C7678D: BIO_read (in /lib64/libcrypto.so.0.9.8e)
| | |       |                   ->07.01% (65,536B) 0x46F7A3: bio_read (ssl.c:2058)
| | |       |                     ->07.01% (65,536B) 0x46FA8F: key_state_read_plaintext (ssl.c:2148)
| | |       |                       ->07.01% (65,536B) 0x474859: tls_process (ssl.c:4075)
| | |       |                         ->07.01% (65,536B) 0x475420: tls_multi_process (ssl.c:4303)
| | |       |                           ->07.01% (65,536B) 0x411B4C: check_tls_dowork (forward.c:93)
| | |       |                             ->07.01% (65,536B) 0x41571F: check_tls (forward-inline.h:41)
| | |       |                               ->07.01% (65,536B) 0x415663: pre_select (forward.c:1304)
| | |       |                                 ->07.01% (65,536B) 0x439130: multi_process_post (multi.c:1876)
| | |       |                                   ->07.01% (65,536B) 0x439927: multi_process_incoming_link (multi.c:2110)
| | |       |                                     ->07.01% (65,536B) 0x43413B: multi_process_io_udp (mudp.c:170)
| | |       |                                       ->07.01% (65,536B) 0x4344AC: tunnel_server_udp_single_threaded (mudp.c:255)
| | |       |                                         ->07.01% (65,536B) 0x434885: tunnel_server_udp (mudp.c:277)
| | |       |                                           ->07.01% (65,536B) 0x43ACFB: tunnel_server (multi.c:2680)
| | |       |                                             ->07.01% (65,536B) 0x43D7F3: main (openvpn.c:211)
| | |       |
| | |       ->07.01% (65,536B) 0x385E025D9F: tls1_change_cipher_state (in /lib64/libssl.so.0.9.8e)
| | |         ->07.01% (65,536B) 0x385E01A9A5: ssl3_accept (in /lib64/libssl.so.0.9.8e)
| | |           ->07.01% (65,536B) 0x385E021883: ssl3_read_bytes (in /lib64/libssl.so.0.9.8e)
| | |             ->07.01% (65,536B) 0x385E01E55F: ??? (in /lib64/libssl.so.0.9.8e)
| | |               ->07.01% (65,536B) 0x385E038F3F: ??? (in /lib64/libssl.so.0.9.8e)
| | |                 ->07.01% (65,536B) 0x3858C7678D: BIO_read (in /lib64/libcrypto.so.0.9.8e)
| | |                   ->07.01% (65,536B) 0x46F7A3: bio_read (ssl.c:2058)
| | |                     ->07.01% (65,536B) 0x46FA8F: key_state_read_plaintext (ssl.c:2148)
| | |                       ->07.01% (65,536B) 0x474859: tls_process (ssl.c:4075)
| | |                         ->07.01% (65,536B) 0x475420: tls_multi_process (ssl.c:4303)
| | |                           ->07.01% (65,536B) 0x411B4C: check_tls_dowork (forward.c:93)
| | |                             ->07.01% (65,536B) 0x41571F: check_tls (forward-inline.h:41)
| | |                               ->07.01% (65,536B) 0x415663: pre_select (forward.c:1304)
| | |                                 ->07.01% (65,536B) 0x439130: multi_process_post (multi.c:1876)
| | |                                   ->07.01% (65,536B) 0x439927: multi_process_incoming_link (multi.c:2110)
| | |                                     ->07.01% (65,536B) 0x43413B: multi_process_io_udp (mudp.c:170)
| | |                                       ->07.01% (65,536B) 0x4344AC: tunnel_server_udp_single_threaded (mudp.c:255)
| | |                                         ->07.01% (65,536B) 0x434885: tunnel_server_udp (mudp.c:277)
| | |                                           ->07.01% (65,536B) 0x43ACFB: tunnel_server (multi.c:2680)
| | |                                             ->07.01% (65,536B) 0x43D7F3: main (openvpn.c:211)
| | |
| | ->14.02% (131,072B) 0x38578064EA: deflateInit2_ (in /usr/lib64/libz.so.1.2.3)
| | | ->14.02% (131,072B) 0x3857806622: deflateInit_ (in /usr/lib64/libz.so.1.2.3)
| | |   ->14.02% (131,072B) 0x3858CBFECA: ??? (in /lib64/libcrypto.so.0.9.8e)
| | |     ->14.02% (131,072B) 0x3858CBFA96: COMP_CTX_new (in /lib64/libcrypto.so.0.9.8e)
| | |       ->07.01% (65,536B) 0x385E025CDF: tls1_change_cipher_state (in /lib64/libssl.so.0.9.8e)
| | |       | ->07.01% (65,536B) 0x385E020492: ssl3_do_change_cipher_spec (in /lib64/libssl.so.0.9.8e)
| | |       |   ->07.01% (65,536B) 0x385E021952: ssl3_read_bytes (in /lib64/libssl.so.0.9.8e)
| | |       |     ->07.01% (65,536B) 0x385E0222AE: ssl3_get_message (in /lib64/libssl.so.0.9.8e)
| | |       |       ->07.01% (65,536B) 0x385E022B1B: ssl3_get_finished (in /lib64/libssl.so.0.9.8e)
| | |       |         ->07.01% (65,536B) 0x385E01A740: ssl3_accept (in /lib64/libssl.so.0.9.8e)
| | |       |           ->07.01% (65,536B) 0x385E021883: ssl3_read_bytes (in /lib64/libssl.so.0.9.8e)
| | |       |             ->07.01% (65,536B) 0x385E01E55F: ??? (in /lib64/libssl.so.0.9.8e)
| | |       |               ->07.01% (65,536B) 0x385E038F3F: ??? (in /lib64/libssl.so.0.9.8e)
| | |       |                 ->07.01% (65,536B) 0x3858C7678D: BIO_read (in /lib64/libcrypto.so.0.9.8e)
| | |       |                   ->07.01% (65,536B) 0x46F7A3: bio_read (ssl.c:2058)
| | |       |                     ->07.01% (65,536B) 0x46FA8F: key_state_read_plaintext (ssl.c:2148)
| | |       |                       ->07.01% (65,536B) 0x474859: tls_process (ssl.c:4075)
| | |       |                         ->07.01% (65,536B) 0x475420: tls_multi_process (ssl.c:4303)
| | |       |                           ->07.01% (65,536B) 0x411B4C: check_tls_dowork (forward.c:93)
| | |       |                             ->07.01% (65,536B) 0x41571F: check_tls (forward-inline.h:41)
| | |       |                               ->07.01% (65,536B) 0x415663: pre_select (forward.c:1304)
| | |       |                                 ->07.01% (65,536B) 0x439130: multi_process_post (multi.c:1876)
| | |       |                                   ->07.01% (65,536B) 0x439927: multi_process_incoming_link (multi.c:2110)
| | |       |                                     ->07.01% (65,536B) 0x43413B: multi_process_io_udp (mudp.c:170)
| | |       |                                       ->07.01% (65,536B) 0x4344AC: tunnel_server_udp_single_threaded (mudp.c:255)
| | |       |                                         ->07.01% (65,536B) 0x434885: tunnel_server_udp (mudp.c:277)
| | |       |                                           ->07.01% (65,536B) 0x43ACFB: tunnel_server (multi.c:2680)
| | |       |                                             ->07.01% (65,536B) 0x43D7F3: main (openvpn.c:211)
| | |       |
| | |       ->07.01% (65,536B) 0x385E025D9F: tls1_change_cipher_state (in /lib64/libssl.so.0.9.8e)
| | |         ->07.01% (65,536B) 0x385E01A9A5: ssl3_accept (in /lib64/libssl.so.0.9.8e)
| | |           ->07.01% (65,536B) 0x385E021883: ssl3_read_bytes (in /lib64/libssl.so.0.9.8e)
| | |             ->07.01% (65,536B) 0x385E01E55F: ??? (in /lib64/libssl.so.0.9.8e)
| | |               ->07.01% (65,536B) 0x385E038F3F: ??? (in /lib64/libssl.so.0.9.8e)
| | |                 ->07.01% (65,536B) 0x3858C7678D: BIO_read (in /lib64/libcrypto.so.0.9.8e)
| | |                   ->07.01% (65,536B) 0x46F7A3: bio_read (ssl.c:2058)
| | |                     ->07.01% (65,536B) 0x46FA8F: key_state_read_plaintext (ssl.c:2148)
| | |                       ->07.01% (65,536B) 0x474859: tls_process (ssl.c:4075)
| | |                         ->07.01% (65,536B) 0x475420: tls_multi_process (ssl.c:4303)
| | |                           ->07.01% (65,536B) 0x411B4C: check_tls_dowork (forward.c:93)
| | |                             ->07.01% (65,536B) 0x41571F: check_tls (forward-inline.h:41)
| | |                               ->07.01% (65,536B) 0x415663: pre_select (forward.c:1304)
| | |                                 ->07.01% (65,536B) 0x439130: multi_process_post (multi.c:1876)
| | |                                   ->07.01% (65,536B) 0x439927: multi_process_incoming_link (multi.c:2110)
| | |                                     ->07.01% (65,536B) 0x43413B: multi_process_io_udp (mudp.c:170)
| | |                                       ->07.01% (65,536B) 0x4344AC: tunnel_server_udp_single_threaded (mudp.c:255)
| | |                                         ->07.01% (65,536B) 0x434885: tunnel_server_udp (mudp.c:277)
| | |                                           ->07.01% (65,536B) 0x43ACFB: tunnel_server (multi.c:2680)
| | |                                             ->07.01% (65,536B) 0x43D7F3: main (openvpn.c:211)
| | |
| | ->14.02% (131,072B) 0x385780649F: deflateInit2_ (in /usr/lib64/libz.so.1.2.3)
| | | ->14.02% (131,072B) 0x3857806622: deflateInit_ (in /usr/lib64/libz.so.1.2.3)
| | |   ->14.02% (131,072B) 0x3858CBFECA: ??? (in /lib64/libcrypto.so.0.9.8e)
| | |     ->14.02% (131,072B) 0x3858CBFA96: COMP_CTX_new (in /lib64/libcrypto.so.0.9.8e)
| | |       ->07.01% (65,536B) 0x385E025CDF: tls1_change_cipher_state (in /lib64/libssl.so.0.9.8e)
| | |       | ->07.01% (65,536B) 0x385E020492: ssl3_do_change_cipher_spec (in /lib64/libssl.so.0.9.8e)
| | |       |   ->07.01% (65,536B) 0x385E021952: ssl3_read_bytes (in /lib64/libssl.so.0.9.8e)
| | |       |     ->07.01% (65,536B) 0x385E0222AE: ssl3_get_message (in /lib64/libssl.so.0.9.8e)
| | |       |       ->07.01% (65,536B) 0x385E022B1B: ssl3_get_finished (in /lib64/libssl.so.0.9.8e)
| | |       |         ->07.01% (65,536B) 0x385E01A740: ssl3_accept (in /lib64/libssl.so.0.9.8e)
| | |       |           ->07.01% (65,536B) 0x385E021883: ssl3_read_bytes (in /lib64/libssl.so.0.9.8e)
| | |       |             ->07.01% (65,536B) 0x385E01E55F: ??? (in /lib64/libssl.so.0.9.8e)
| | |       |               ->07.01% (65,536B) 0x385E038F3F: ??? (in /lib64/libssl.so.0.9.8e)
| | |       |                 ->07.01% (65,536B) 0x3858C7678D: BIO_read (in /lib64/libcrypto.so.0.9.8e)
| | |       |                   ->07.01% (65,536B) 0x46F7A3: bio_read (ssl.c:2058)
| | |       |                     ->07.01% (65,536B) 0x46FA8F: key_state_read_plaintext (ssl.c:2148)
| | |       |                       ->07.01% (65,536B) 0x474859: tls_process (ssl.c:4075)
| | |       |                         ->07.01% (65,536B) 0x475420: tls_multi_process (ssl.c:4303)
| | |       |                           ->07.01% (65,536B) 0x411B4C: check_tls_dowork (forward.c:93)
| | |       |                             ->07.01% (65,536B) 0x41571F: check_tls (forward-inline.h:41)
| | |       |                               ->07.01% (65,536B) 0x415663: pre_select (forward.c:1304)
| | |       |                                 ->07.01% (65,536B) 0x439130: multi_process_post (multi.c:1876)
| | |       |                                   ->07.01% (65,536B) 0x439927: multi_process_incoming_link (multi.c:2110)
| | |       |                                     ->07.01% (65,536B) 0x43413B: multi_process_io_udp (mudp.c:170)
| | |       |                                       ->07.01% (65,536B) 0x4344AC: tunnel_server_udp_single_threaded (mudp.c:255)
| | |       |                                         ->07.01% (65,536B) 0x434885: tunnel_server_udp (mudp.c:277)
| | |       |                                           ->07.01% (65,536B) 0x43ACFB: tunnel_server (multi.c:2680)
| | |       |                                             ->07.01% (65,536B) 0x43D7F3: main (openvpn.c:211)
| | |       |
| | |       ->07.01% (65,536B) 0x385E025D9F: tls1_change_cipher_state (in /lib64/libssl.so.0.9.8e)
| | |         ->07.01% (65,536B) 0x385E01A9A5: ssl3_accept (in /lib64/libssl.so.0.9.8e)
| | |           ->07.01% (65,536B) 0x385E021883: ssl3_read_bytes (in /lib64/libssl.so.0.9.8e)
| | |             ->07.01% (65,536B) 0x385E01E55F: ??? (in /lib64/libssl.so.0.9.8e)
| | |               ->07.01% (65,536B) 0x385E038F3F: ??? (in /lib64/libssl.so.0.9.8e)
| | |                 ->07.01% (65,536B) 0x3858C7678D: BIO_read (in /lib64/libcrypto.so.0.9.8e)
| | |                   ->07.01% (65,536B) 0x46F7A3: bio_read (ssl.c:2058)
| | |                     ->07.01% (65,536B) 0x46FA8F: key_state_read_plaintext (ssl.c:2148)
| | |                       ->07.01% (65,536B) 0x474859: tls_process (ssl.c:4075)
| | |                         ->07.01% (65,536B) 0x475420: tls_multi_process (ssl.c:4303)
| | |                           ->07.01% (65,536B) 0x411B4C: check_tls_dowork (forward.c:93)
| | |                             ->07.01% (65,536B) 0x41571F: check_tls (forward-inline.h:41)
| | |                               ->07.01% (65,536B) 0x415663: pre_select (forward.c:1304)
| | |                                 ->07.01% (65,536B) 0x439130: multi_process_post (multi.c:1876)
| | |                                   ->07.01% (65,536B) 0x439927: multi_process_incoming_link (multi.c:2110)
| | |                                     ->07.01% (65,536B) 0x43413B: multi_process_io_udp (mudp.c:170)
| | |                                       ->07.01% (65,536B) 0x4344AC: tunnel_server_udp_single_threaded (mudp.c:255)
| | |                                         ->07.01% (65,536B) 0x434885: tunnel_server_udp (mudp.c:277)
| | |                                           ->07.01% (65,536B) 0x43ACFB: tunnel_server (multi.c:2680)
| | |                                             ->07.01% (65,536B) 0x43D7F3: main (openvpn.c:211)
|


