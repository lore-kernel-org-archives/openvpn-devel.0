Message-ID: <4B9E5240.1080008@...1147...>
Date: Mon, 15 Mar 2010 16:29:04 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <4B950E0B.1030908@...41...> <4B964BEC.3040504@...1114...>
	<4B991408.8030207@...1147...>
In-Reply-To: <4B991408.8030207@...1147...>
Subject: Re: [Openvpn-devel] Linux tun/tap performance issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

More tests, this time with 'oprofile' : here's a recap:
- nothing changed on the server side:
openvpn --ifconfig 10.222.0.1 10.222.0.2 --dev tun --secret secret.key --cipher none

- upgraded to kernel 2.6.32.9-70.fc12.x86_64 on my laptop
- selinux is disabled
- installed the debuginfo rpms to get a 'vmlinux'
- configure the oprofile deamon using
opcontrol
--vmlinux=/usr/lib/debug/lib/modules/2.6.32.9-70.fc12.x86_64/vmlinux
- now start it, reset the statistics, start openvpn
  opcontrol --start
  opcontrol --reset
  ./openvpn --ifconfig 10.222.0.2 10.222.0.1 --dev tun --secret
secret.key --remote kudde.nikhef.nl --cipher none
- download a file using 'nc' (this maxes out my 100 Mbps LAN at roughly
11 MB/s)
- get the statistics
  opcontrol --dump
  opreport -l > stats

Here're the results on my laptop, running at runlevel 2 with as many
daemons stopped and modules unloaded as possible:

when download a 100 Mb file (using nc) I see:

> head -20 after.100mb
samples  %        app name                 symbol name
55558    30.0622  vmlinux                  read_hpet
19613    10.6125  vmlinux                  mwait_idle_with_hints
10692     5.7854  libcrypto.so.1.0.0       /usr/lib64/libcrypto.so.1.0.0
5407      2.9257  vmlinux                  acpi_os_read_port
2546      1.3776  vmlinux                  copy_user_generic_string
1945      1.0524  opreport                 /usr/bin/opreport
1885      1.0200  vmlinux                  hpet_next_event
1325      0.7170  tg3                      /tg3
1235      0.6683  vmlinux                  schedule
1121      0.6066  tun                      /tun
1049      0.5676  vmlinux                  do_sys_poll
796       0.4307  vmlinux                  acpi_idle_enter_bm
795       0.4302  vmlinux                  sched_clock_local
769       0.4161  vmlinux                  tick_broadcast_oneshot_control
757       0.4096  vmlinux                  tcp_packet
749       0.4053  vmlinux                  cfb_imageblit
728       0.3939  vmlinux                  system_call

Observations:
- why the heck is libcrypto so high on the list? I used 'cipher none' !
- the 'tun' driver does not seem to be the bottleneck

Ah, of course,  openvpn still used crypto for the HMAC handshake!

After adding '--auth none' to both client and server (and a tweak to opreport) I now get:

samples  %        linenr info                 app name                 symbol name
140883   31.1707  hpet.c:748                  vmlinux                  read_hpet
51808    11.4626  process.c:356               vmlinux                  mwait_idle_with_hints
13400     2.9648  osl.c:480                   vmlinux                  acpi_os_read_port
7034      1.5563  copy_user_64.S:241          vmlinux                  copy_user_generic_string
5837      1.2914  hpet.c:380                  vmlinux                  hpet_next_event
3334      0.7377  sched.c:5431                vmlinux                  schedule
3207      0.7096  select.c:813                vmlinux                  do_sys_poll
2499      0.5529  nf_conntrack_proto_tcp.c:824 vmlinux                  tcp_packet
2350      0.5199  entry_64.S:461              vmlinux                  system_call
2274      0.5031  tick-broadcast.c:454        vmlinux                  tick_broadcast_oneshot_control
2228      0.4929  processor_idle.c:947        vmlinux                  acpi_idle_enter_bm
2204      0.4876  nf_conntrack_core.c:753     vmlinux                  nf_conntrack_in
2152      0.4761  ip_tables.c:309             vmlinux                  ipt_do_table
2004      0.4434  sched_clock.c:105           vmlinux                  sched_clock_local
1966      0.4350  core.c:122                  vmlinux                  nf_iterate
1929      0.4268  clockevents.c:241           vmlinux                  clockevents_notify
1904      0.4213  rtc.c:195                   vmlinux                  native_read_tsc
1673      0.3702  wait.c:45                   vmlinux                  remove_wait_queue
1656      0.3664  select.c:218                vmlinux                  __pollwait
1595      0.3529  wait.c:23                   vmlinux                  add_wait_queue
1572      0.3478  sched_fair.c:1362           vmlinux                  select_task_rq_fair
1511      0.3343  tick-sched.c:214            vmlinux                  tick_nohz_stop_sched_tick
1479      0.3272  random.c:461                vmlinux                  mix_pool_bytes_extract
1457      0.3224  file_table.c:327            vmlinux                  fget_light
1444      0.3195  nf_conntrack_core.c:72      vmlinux                  __hash_conntrack
1402      0.3102  (no location information)   oprofiled                /usr/bin/oprofiled
1386      0.3067  entry_64.S:781              vmlinux                  irq_entries_start
1347      0.2980  auditsc.c:1680              vmlinux                  audit_syscall_exit
1343      0.2971  skbuff.c:174                vmlinux                  __alloc_skb
1342      0.2969  (no location information)   libc-2.11.1.so           poll
1336      0.2956  dev.c:2285                  vmlinux                  netif_receive_skb
1334      0.2952  softirq.c:142               vmlinux                  _local_bh_enable_ip
1324      0.2929  csum-partial_64.c:134       vmlinux                  csum_partial
1321      0.2923  forward.c:1325              openvpn                  io_wait_dowork
1283      0.2839  entry_64.S:1009             vmlinux                  reschedule_interrupt
1273      0.2817  process_64.c:380            vmlinux                  __switch_to
1248      0.2761  avc.c:790                   vmlinux                  avc_has_perm_noaudit



Observations:
- note that openvpn itself does not even make the top 15. It's lower in
the list, however:
11896     0.3580  openvpn                  openvpn                  io_wait_dowork
10842     0.3263  openvpn                  openvpn                  po_wait
9608      0.2892  openvpn                  openvpn                  openvpn_decrypt
9449      0.2844  openvpn                  openvpn                  main
9250      0.2784  openvpn                  openvpn                  pre_select
9191      0.2766  openvpn                  openvpn                  process_incoming_link
7027      0.2115  openvpn                  openvpn                  po_ctl
4148      0.1248  openvpn                  openvpn                  packet_id_add
4090      0.1231  openvpn                  openvpn                  mss_fixup
4022      0.1210  openvpn                  openvpn                  process_io
[...]
- why do I see 'po_ctl' and the likes? is this the old
openvpn-does-not-properly-use-EPOLL bug again?

I also ran a similar test using a Centos5 client (kernel
2.6.18-164.6.1.el5) over a Gbps LAN : here you can see some limitations
of the tun driver or openvpn itself:
- raw UDP gives me ~ 110 MB/s  (maxing out the Gbps LAN)
- raw TCP/IP gives me ~ 60 MB/s (could use some tweaking but is not so
bad, actually)
- openvpn over UDP maxes out at somewhere between 32 - 40 MB/s
- openvpn over TCP maxes out at ~ 16 MB/s

So either I'm misreading oprofile or it's *not* the tun driver that is
causing bottlenecks.


If anybody else has more experience with 'oprofile' then please let me
know how I can rerun these tests more effectively.


share and enjoy,

JJK / Jan Just Keijser



