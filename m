References: <CAAUX2SUgtu1di6gO3_ZjVccKCgDismMst-zdD68CKfpbdOpkzA@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <05df2d70-d2bd-f8af-5652-31b040471df2@...2181...>
Date: Fri, 20 Nov 2020 09:05:46 +0100
MIME-Version: 1.0
In-Reply-To: <CAAUX2SUgtu1di6gO3_ZjVccKCgDismMst-zdD68CKfpbdOpkzA@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [ovpn-dco] performance issue
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
To: Tony He <huangya90@...277...>, openvpn-devel@lists.sourceforge.net

Hi Tony,

Thanks for looking into this.
First of all let me say that performance in general is still "work in
progress".

ovpn-dco is currently undergoing a big restructuring in order to
introduce multi-peer support (right now it can only handle one connection).
Therefore I will be back investigating performance only after that.

This said, I'd presume the difference comes from the two hosts being two
very different machines. iperf is heavily affected by the capacity of
the host to generate traffic.

In any case, I'd wait for the restructuring to be done before digging
any further.

Cheers and thanks again for testing!


On 20/11/2020 03:03, Tony He wrote:
> Hi Antonio,
> 
> I'm testing the performance of ovpn-dco.
> 
> Topology:
> 
> iperf client running in Ubuntu 20.04 VM with two cores(intel i7 6700)  -
> iperf server running Ubuntu 18.04 HP EliteBook with four cores(intel
> i5-6300U).
> tunnel  IP 5.5.5.1                                                     
>                                 tunnel IP 5.5.5.2
> 
> The issue I see is the TP is different in both directions. Is this
> normal? I don't see this issue if using the host of VM and the TP is
> very good
> in both directions(~870Mbps).VM should be the bottleneck but I don't
> understand why the TP is so much different in both direction.
> 
> *1. main application data from Ubuntu 20.04 VM to Ubuntu 18.04*
> tony-vm-2004% iperf3 -c 5.5.5.2 -t 15    
> Connecting to host 5.5.5.2, port 5201
> [  5] local 5.5.5.1 port 55342 connected to 5.5.5.2 port 5201
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec  37.3 MBytes   313 Mbits/sec    0    427 KBytes
>      
> [  5]   1.00-2.00   sec  33.4 MBytes   280 Mbits/sec    0    427 KBytes
>      
> [  5]   2.00-3.00   sec  35.1 MBytes   294 Mbits/sec    0    427 KBytes
>      
> [  5]   3.00-4.00   sec  34.4 MBytes   289 Mbits/sec    0    457 KBytes
>      
> [  5]   4.00-5.00   sec  33.7 MBytes   283 Mbits/sec    0    457 KBytes
>      
> [  5]   5.00-6.00   sec  34.7 MBytes   291 Mbits/sec    0    457 KBytes
>      
> [  5]   6.00-7.00   sec  33.8 MBytes   284 Mbits/sec    0    457 KBytes
>      
> [  5]   7.00-8.00   sec  33.9 MBytes   285 Mbits/sec    0    457 KBytes
>      
> [  5]   8.00-9.00   sec  34.4 MBytes   288 Mbits/sec    0    457 KBytes
>      
> [  5]   9.00-10.00  sec  33.9 MBytes   284 Mbits/sec    0    457 KBytes
>      
> [  5]  10.00-11.00  sec  34.0 MBytes   285 Mbits/sec    0    457 KBytes
>      
> [  5]  11.00-12.00  sec  31.7 MBytes   266 Mbits/sec    0    457 KBytes
>      
> [  5]  12.00-13.00  sec  30.8 MBytes   259 Mbits/sec    0    457 KBytes
>      
> [  5]  13.00-14.00  sec  33.1 MBytes   278 Mbits/sec    0    911 KBytes
>      
> [  5]  14.00-15.00  sec  33.8 MBytes   283 Mbits/sec    0    911 KBytes
>      
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-15.00  sec   508 MBytes   284 Mbits/sec    0             sender
> [  5]   0.00-15.00  sec   505 MBytes   282 Mbits/sec                
>  receiver
> 
> iperf Done.
> 
> 
> top - 01:39:03 up 42 min,  2 users,  load average: 0.62, 0.86, 0.70
> Tasks: 112 total,   5 running, 107 sleeping,   0 stopped,   0 zombie
> %Cpu(s):  0.2 us, 29.5 sy,  0.0 ni, 49.0 id,  0.2 wa,  0.0 hi, 21.1 si,
>  0.0 st
> MiB Mem :    981.1 total,    461.4 free,    160.2 used,    359.4 buff/cache
> MiB Swap:      0.0 total,      0.0 free,      0.0 used.    668.4 avail Mem
> 
>     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+
> COMMAND
>    1841 root      20   0       0      0      0 R  35.0   0.0   2:51.58
> kworker/1:1+ovpn-crypto-wq-tun0
>      18 root      20   0       0      0      0 R  30.7   0.0   2:18.43
> ksoftirqd/1
>    1904 root      20   0       0      0      0 I  18.0   0.0   0:03.62
> kworker/1:2-ovpn-crypto-wq-tun0
>    1882 root      20   0       0      0      0 R  15.3   0.0   0:46.47
> kworker/1:0-ovpn-crypto-wq-tun0
>    1910 tony      20   0    5900   3156   2736 S   0.7   0.3   0:00.06
> iperf3
> 
> 
> tony-vm-2004% mpstat -P ALL 2                                          
>                                                                        
>                                                                    
> Linux 5.4.0-54-generic (tony-vm-2004)   11/20/20        _x86_64_      
>  (2 CPU)                                                                
>                                                                    
>                                                                        
>                                                                        
>                                                                    
> 01:51:05     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal
>  %guest  %gnice   %idle
> 01:51:07     all    0.00    0.00   30.71    0.00    0.00   20.64    0.00
>    0.00    0.00   48.65
> 01:51:07       0    0.00    0.00    0.00    0.00    0.00    4.35    0.00
>    0.00    0.00   95.65
> 01:51:07       1    0.00    0.00   62.50    0.00    0.00   37.50    0.00
>    0.00    0.00    0.00
> 
> 01:51:07     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal
>  %guest  %gnice   %idle
> 01:51:09     all    0.24    0.00   29.76    0.00    0.00   21.46    0.00
>    0.00    0.00   48.54
> 01:51:09       0    0.48    0.00    0.48    0.00    0.00    4.31    0.00
>    0.00    0.00   94.74
> 01:51:09       1    0.00    0.00   60.20    0.00    0.00   39.30    0.00
>    0.00    0.00    0.50
> 
> *2. main application data from Ubuntu 18.04  to Ubuntu 20.04 VM (using
> option "-R" of iperf3) *
> tony-vm-2004% iperf3 -c 5.5.5.2 -t 15  -R
> Connecting to host 5.5.5.2, port 5201
> Reverse mode, remote host 5.5.5.2 is sending
> [  5] local 5.5.5.1 port 55354 connected to 5.5.5.2 port 5201
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-1.00   sec  56.7 MBytes   476 Mbits/sec                  
> [  5]   1.00-2.00   sec  65.6 MBytes   551 Mbits/sec                  
> [  5]   2.00-3.00   sec  68.1 MBytes   572 Mbits/sec                  
> [  5]   3.00-4.00   sec  72.8 MBytes   611 Mbits/sec                  
> [  5]   4.00-5.00   sec  67.3 MBytes   564 Mbits/sec                  
> [  5]   5.00-6.00   sec  82.0 MBytes   688 Mbits/sec                  
> [  5]   6.00-7.00   sec  88.0 MBytes   738 Mbits/sec                  
> [  5]   7.00-8.00   sec  92.1 MBytes   773 Mbits/sec                  
> [  5]   8.00-9.00   sec  94.7 MBytes   794 Mbits/sec                  
> [  5]   9.00-10.00  sec  98.4 MBytes   826 Mbits/sec                  
> [  5]  10.00-11.00  sec  93.0 MBytes   780 Mbits/sec                  
> [  5]  11.00-12.00  sec  92.1 MBytes   773 Mbits/sec                  
> [  5]  12.00-13.00  sec  90.8 MBytes   762 Mbits/sec                  
> [  5]  13.00-14.00  sec  95.0 MBytes   797 Mbits/sec                  
> [  5]  14.00-15.00  sec  96.0 MBytes   806 Mbits/sec                  
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-15.00  sec  1.23 GBytes   703 Mbits/sec  891             sender
> [  5]   0.00-15.00  sec  1.22 GBytes  701 Mbits/sec                
>  receiver
> 
> iperf Done.
> top - 01:54:15 up 57 min,  2 users,  load average: 0.39, 0.19, 0.31    
>                                                                        
>                                                                    
> Tasks: 111 total,   3 running, 108 sleeping,   0 stopped,   0 zombie    
>                                                                        
>                                                                  
> %Cpu(s):  0.7 us, 25.7 sy,  0.0 ni, 40.0 id,  0.0 wa,  0.0 hi, 33.6 si,
>  0.0 st                                                                
>                                                                    
> MiB Mem :    981.1 total,    459.2 free,    162.5 used,    359.4
> buff/cache                                                              
>                                                                          
> MiB Swap:      0.0 total,      0.0 free,      0.0 used.    666.2 avail
> Mem                                                                    
>                                                                    
>                                                                        
>                                                                        
>                                                                    
>     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+
> COMMAND                                                                
>                                                                    
>    1904 root      20   0       0      0      0 I  82.7   0.0   0:18.91
> kworker/1:2-ovpn-crypto-wq-tun0                                        
>                                                                    
>    1676 root      20   0       0      0      0 I  17.0   0.0   0:15.25
> kworker/0:0-events                                                      
>                                                                    
>      18 root      20   0       0      0      0 S   3.0   0.0   2:25.88
> ksoftirqd/1                                                            
>                                                                    
>    1923 root      20   0       0      0      0 I   1.0   0.0   0:06.81
> kworker/1:3-ovpn-crypto-wq-tun0                                        
>                                                                    
>    1924 root      20   0       0      0      0 I   0.7   0.0   0:00.39
> kworker/0:1-ata_sff                 *
> *
> 
> 
> tony-vm-2004% mpstat -P ALL 2                                          
>                                                                        
>                                                                    
> Linux 5.4.0-54-generic (tony-vm-2004)   11/20/20        _x86_64_      
>  (2 CPU)                                                                
>                                                                        
>                                                                        
>                                                                        
>                                                        
> 01:56:07     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal
>  %guest  %gnice   %idle
> 01:56:09     all    0.53    0.00   28.04    0.00    0.00   28.31    0.00
>    0.00    0.00   43.12
> 01:56:09       0    1.12    0.00    6.18    0.00    0.00    1.12    0.00
>    0.00    0.00   91.57
> 01:56:09       1    0.00    0.00   47.50    0.00    0.00   52.50    0.00
>    0.00    0.00    0.00
> 
> 01:56:09     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal
>  %guest  %gnice   %idle
> 01:56:11     all    0.53    0.00   25.66    0.26    0.00   32.28    0.00
>    0.00    0.00   41.27
> 01:56:11       0    1.12    0.00    8.43    0.56    0.00    2.81    0.00
>    0.00    0.00   87.08
> 01:56:11       1    0.00    0.00   41.00    0.00    0.00   58.50    0.00
>    0.00    0.00    0.50
> 
> 
> Tony
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

-- 
Antonio Quartulli

