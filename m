Message-ID: <4B9E5EEF.6030800@...1114...>
Date: Mon, 15 Mar 2010 17:23:11 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4B950E0B.1030908@...41...> <4B964BEC.3040504@...1114...>
	<4B991408.8030207@...1147...> <4B9E5240.1080008@...1147...>
In-Reply-To: <4B9E5240.1080008@...1147...>
Subject: Re: [Openvpn-devel] Linux tun/tap performance issues
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
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 15/03/10 16:29, Jan Just Keijser wrote:
> More tests, this time with 'oprofile' : here's a recap:
> - nothing changed on the server side:
> openvpn --ifconfig 10.222.0.1 10.222.0.2 --dev tun --secret secret.key
> --cipher none
> 
> - upgraded to kernel 2.6.32.9-70.fc12.x86_64 on my laptop
> - selinux is disabled
> - installed the debuginfo rpms to get a 'vmlinux'
> - configure the oprofile deamon using
> opcontrol
> --vmlinux=/usr/lib/debug/lib/modules/2.6.32.9-70.fc12.x86_64/vmlinux
> - now start it, reset the statistics, start openvpn
>  opcontrol --start
>  opcontrol --reset
>  ./openvpn --ifconfig 10.222.0.2 10.222.0.1 --dev tun --secret
> secret.key --remote kudde.nikhef.nl --cipher none
> - download a file using 'nc' (this maxes out my 100 Mbps LAN at roughly
> 11 MB/s)
> - get the statistics
>  opcontrol --dump
>  opreport -l > stats

Thanks a lot!  This is way cool!  It just strikes me that you probably
should play with ftrace instead of oprofile.  It's better and got a
lower overhead than oprofile, afaik.

<http://lwn.net/Articles/322666/>

(btw. with an ftrace enabled kernel, it's even available on embedded
devices. You only need 'mount', 'echo' and 'cat' to interact with ftrace
... even though Steven Rostedt is working on a GUI for ftrace, called
kernelshark)

With such new kernel, there's also the perf tool.

<http://perf.wiki.kernel.org/index.php/Main_Page>

In both of these tools you have something called callgraph, iirc.  And
with that you see which function is calling which function and the
amount of time each step used.

I'll ask some people who's been involved in both ftrace and perf for
some better pointers!

> Here're the results on my laptop, running at runlevel 2 with as many
> daemons stopped and modules unloaded as possible:
> 
> when download a 100 Mb file (using nc) I see:
> 
>> head -20 after.100mb
> samples  %        app name                 symbol name
> 55558    30.0622  vmlinux                  read_hpet
> 19613    10.6125  vmlinux                  mwait_idle_with_hints

read_hpet usually means HPET timer.  I'm actually surprised to see that
one so high up on the list.  Right now I don't recall what
mwait_idle_with_hints does, but I guess it pops up high due to it
calling read_hpet().

> 10692     5.7854  libcrypto.so.1.0.0       /usr/lib64/libcrypto.so.1.0.0
> 5407      2.9257  vmlinux                  acpi_os_read_port
> 2546      1.3776  vmlinux                  copy_user_generic_string
> 1945      1.0524  opreport                 /usr/bin/opreport
> 1885      1.0200  vmlinux                  hpet_next_event
> 1325      0.7170  tg3                      /tg3
> 1235      0.6683  vmlinux                  schedule
> 1121      0.6066  tun                      /tun
> 1049      0.5676  vmlinux                  do_sys_poll
> 796       0.4307  vmlinux                  acpi_idle_enter_bm
> 795       0.4302  vmlinux                  sched_clock_local
> 769       0.4161  vmlinux                  tick_broadcast_oneshot_control
> 757       0.4096  vmlinux                  tcp_packet
> 749       0.4053  vmlinux                  cfb_imageblit
> 728       0.3939  vmlinux                  system_call
> 
> Observations:
> - why the heck is libcrypto so high on the list? I used 'cipher none' !
> - the 'tun' driver does not seem to be the bottleneck

It still might be that there are some locking going on, where the tun
driver calls some code paths which hits the mwait_idle_with_hints ...
(this is why I'm recommending to have a look at the callgraph in perf or
ftrace)

> Ah, of course,  openvpn still used crypto for the HMAC handshake!

That will cause calls to libcrypto.

> After adding '--auth none' to both client and server (and a tweak to
> opreport) I now get:
> 
> samples  %        linenr info                 app name                
> symbol name
> 140883   31.1707  hpet.c:748                  vmlinux                 
> read_hpet
> 51808    11.4626  process.c:356               vmlinux                 
> mwait_idle_with_hints

Still amazingly high!

[snip]
> Observations:
> - note that openvpn itself does not even make the top 15. It's lower in
> the list, however:
> 11896     0.3580  openvpn                  openvpn                 
> io_wait_dowork
> 10842     0.3263  openvpn                  openvpn                  po_wait
> 9608      0.2892  openvpn                  openvpn                 
> openvpn_decrypt
> 9449      0.2844  openvpn                  openvpn                  main
> 9250      0.2784  openvpn                  openvpn                 
> pre_select
> 9191      0.2766  openvpn                  openvpn                 
> process_incoming_link
> 7027      0.2115  openvpn                  openvpn                  po_ctl
> 4148      0.1248  openvpn                  openvpn                 
> packet_id_add
> 4090      0.1231  openvpn                  openvpn                 
> mss_fixup
> 4022      0.1210  openvpn                  openvpn                 
> process_io
> [...]
> - why do I see 'po_ctl' and the likes? is this the old
> openvpn-does-not-properly-use-EPOLL bug again?
> 
> I also ran a similar test using a Centos5 client (kernel
> 2.6.18-164.6.1.el5) over a Gbps LAN : here you can see some limitations
> of the tun driver or openvpn itself:
> - raw UDP gives me ~ 110 MB/s  (maxing out the Gbps LAN)
> - raw TCP/IP gives me ~ 60 MB/s (could use some tweaking but is not so
> bad, actually)
> - openvpn over UDP maxes out at somewhere between 32 - 40 MB/s
> - openvpn over TCP maxes out at ~ 16 MB/s
> 
> So either I'm misreading oprofile or it's *not* the tun driver that is
> causing bottlenecks.

It does not look so immediately.  But I this trace don't show which
functions are called by which functions.  If f.ex. the mwait or
read_hpet calls are coming from the tun driver, OpenSSL/libcrypto or
OpenVPN itself.

On the other hand!  HPET is not the most efficient timer, on some
systems where TSC timer is available it could be that this would change
the profile as well.

Available clock sources are found like this:
cat /sys/devices/system/clocksource/clocksource*/available_clocksource

And the clock source in use is found like this:
cat /sys/devices/system/clocksource/clocksource*/current_clocksource

On many systems the TSC clock source is considered unstable by kernel.
I've forgotten now if it was AMD or Intel CPUs which was worse, or how
this was related to the number of cores.  But it is connected somehow to
how the TSC clock source is synchronised between the CPU cores.

> If anybody else has more experience with 'oprofile' then please let me
> know how I can rerun these tests more effectively.

I have no experience with oprofile, so I'm not sure if callgraph is
available there.  But I believe a callgraph would give some even better
clues.

Thanks a lot for you tests and analysis!


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkueXuwACgkQDC186MBRfrpDUQCfewiKGlGanhyoHlpvu2rL0pmr
xpcAoJ6d9jXWuzsBadSO9+3VFAdyIy+5
=L9W5
-----END PGP SIGNATURE-----

