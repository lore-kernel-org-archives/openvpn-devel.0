MIME-Version: 1.0
From: Tony He <huangya90@...277...>
Date: Fri, 20 Nov 2020 10:03:46 +0800
Message-ID: <CAAUX2SUgtu1di6gO3_ZjVccKCgDismMst-zdD68CKfpbdOpkzA@...278...>
Content-Type: multipart/alternative; boundary="000000000000d966d905b480414a"
Subject: [Openvpn-devel] [ovpn-dco] performance issue
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <antonio@...515...>, openvpn-devel@lists.sourceforge.net

--000000000000d966d905b480414a
Content-Type: text/plain; charset="UTF-8"

Hi Antonio,

I'm testing the performance of ovpn-dco.

Topology:

iperf client running in Ubuntu 20.04 VM with two cores(intel i7 6700)  -
iperf server running Ubuntu 18.04 HP EliteBook with four cores(intel
i5-6300U).
tunnel  IP 5.5.5.1
                            tunnel IP 5.5.5.2

The issue I see is the TP is different in both directions. Is this normal?
I don't see this issue if using the host of VM and the TP is very good
in both directions(~870Mbps).VM should be the bottleneck but I don't
understand why the TP is so much different in both direction.

*1. main application data from Ubuntu 20.04 VM to Ubuntu 18.04*
tony-vm-2004% iperf3 -c 5.5.5.2 -t 15
Connecting to host 5.5.5.2, port 5201
[  5] local 5.5.5.1 port 55342 connected to 5.5.5.2 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  37.3 MBytes   313 Mbits/sec    0    427 KBytes

[  5]   1.00-2.00   sec  33.4 MBytes   280 Mbits/sec    0    427 KBytes

[  5]   2.00-3.00   sec  35.1 MBytes   294 Mbits/sec    0    427 KBytes

[  5]   3.00-4.00   sec  34.4 MBytes   289 Mbits/sec    0    457 KBytes

[  5]   4.00-5.00   sec  33.7 MBytes   283 Mbits/sec    0    457 KBytes

[  5]   5.00-6.00   sec  34.7 MBytes   291 Mbits/sec    0    457 KBytes

[  5]   6.00-7.00   sec  33.8 MBytes   284 Mbits/sec    0    457 KBytes

[  5]   7.00-8.00   sec  33.9 MBytes   285 Mbits/sec    0    457 KBytes

[  5]   8.00-9.00   sec  34.4 MBytes   288 Mbits/sec    0    457 KBytes

[  5]   9.00-10.00  sec  33.9 MBytes   284 Mbits/sec    0    457 KBytes

[  5]  10.00-11.00  sec  34.0 MBytes   285 Mbits/sec    0    457 KBytes

[  5]  11.00-12.00  sec  31.7 MBytes   266 Mbits/sec    0    457 KBytes

[  5]  12.00-13.00  sec  30.8 MBytes   259 Mbits/sec    0    457 KBytes

[  5]  13.00-14.00  sec  33.1 MBytes   278 Mbits/sec    0    911 KBytes

[  5]  14.00-15.00  sec  33.8 MBytes   283 Mbits/sec    0    911 KBytes

- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-15.00  sec   508 MBytes   284 Mbits/sec    0             sender
[  5]   0.00-15.00  sec   505 MBytes   282 Mbits/sec
 receiver

iperf Done.


top - 01:39:03 up 42 min,  2 users,  load average: 0.62, 0.86, 0.70
Tasks: 112 total,   5 running, 107 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.2 us, 29.5 sy,  0.0 ni, 49.0 id,  0.2 wa,  0.0 hi, 21.1 si,
 0.0 st
MiB Mem :    981.1 total,    461.4 free,    160.2 used,    359.4 buff/cache
MiB Swap:      0.0 total,      0.0 free,      0.0 used.    668.4 avail Mem

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+
COMMAND
   1841 root      20   0       0      0      0 R  35.0   0.0   2:51.58
kworker/1:1+ovpn-crypto-wq-tun0
     18 root      20   0       0      0      0 R  30.7   0.0   2:18.43
ksoftirqd/1
   1904 root      20   0       0      0      0 I  18.0   0.0   0:03.62
kworker/1:2-ovpn-crypto-wq-tun0
   1882 root      20   0       0      0      0 R  15.3   0.0   0:46.47
kworker/1:0-ovpn-crypto-wq-tun0
   1910 tony      20   0    5900   3156   2736 S   0.7   0.3   0:00.06
iperf3


tony-vm-2004% mpstat -P ALL 2


Linux 5.4.0-54-generic (tony-vm-2004)   11/20/20        _x86_64_        (2
CPU)




01:51:05     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal
 %guest  %gnice   %idle
01:51:07     all    0.00    0.00   30.71    0.00    0.00   20.64    0.00
 0.00    0.00   48.65
01:51:07       0    0.00    0.00    0.00    0.00    0.00    4.35    0.00
 0.00    0.00   95.65
01:51:07       1    0.00    0.00   62.50    0.00    0.00   37.50    0.00
 0.00    0.00    0.00

01:51:07     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal
 %guest  %gnice   %idle
01:51:09     all    0.24    0.00   29.76    0.00    0.00   21.46    0.00
 0.00    0.00   48.54
01:51:09       0    0.48    0.00    0.48    0.00    0.00    4.31    0.00
 0.00    0.00   94.74
01:51:09       1    0.00    0.00   60.20    0.00    0.00   39.30    0.00
 0.00    0.00    0.50

*2. main application data from Ubuntu 18.04  to Ubuntu 20.04 VM (using
option "-R" of iperf3) *
tony-vm-2004% iperf3 -c 5.5.5.2 -t 15  -R
Connecting to host 5.5.5.2, port 5201
Reverse mode, remote host 5.5.5.2 is sending
[  5] local 5.5.5.1 port 55354 connected to 5.5.5.2 port 5201
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  56.7 MBytes   476 Mbits/sec
[  5]   1.00-2.00   sec  65.6 MBytes   551 Mbits/sec
[  5]   2.00-3.00   sec  68.1 MBytes   572 Mbits/sec
[  5]   3.00-4.00   sec  72.8 MBytes   611 Mbits/sec
[  5]   4.00-5.00   sec  67.3 MBytes   564 Mbits/sec
[  5]   5.00-6.00   sec  82.0 MBytes   688 Mbits/sec
[  5]   6.00-7.00   sec  88.0 MBytes   738 Mbits/sec
[  5]   7.00-8.00   sec  92.1 MBytes   773 Mbits/sec
[  5]   8.00-9.00   sec  94.7 MBytes   794 Mbits/sec
[  5]   9.00-10.00  sec  98.4 MBytes   826 Mbits/sec
[  5]  10.00-11.00  sec  93.0 MBytes   780 Mbits/sec
[  5]  11.00-12.00  sec  92.1 MBytes   773 Mbits/sec
[  5]  12.00-13.00  sec  90.8 MBytes   762 Mbits/sec
[  5]  13.00-14.00  sec  95.0 MBytes   797 Mbits/sec
[  5]  14.00-15.00  sec  96.0 MBytes   806 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-15.00  sec  1.23 GBytes   703 Mbits/sec  891             sender
[  5]   0.00-15.00  sec  1.22 GBytes   701 Mbits/sec
 receiver

iperf Done.
top - 01:54:15 up 57 min,  2 users,  load average: 0.39, 0.19, 0.31


Tasks: 111 total,   3 running, 108 sleeping,   0 stopped,   0 zombie


%Cpu(s):  0.7 us, 25.7 sy,  0.0 ni, 40.0 id,  0.0 wa,  0.0 hi, 33.6 si,
 0.0 st

MiB Mem :    981.1 total,    459.2 free,    162.5 used,    359.4 buff/cache


MiB Swap:      0.0 total,      0.0 free,      0.0 used.    666.2 avail Mem





    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+
COMMAND

   1904 root      20   0       0      0      0 I  82.7   0.0   0:18.91
kworker/1:2-ovpn-crypto-wq-tun0

   1676 root      20   0       0      0      0 I  17.0   0.0   0:15.25
kworker/0:0-events

     18 root      20   0       0      0      0 S   3.0   0.0   2:25.88
ksoftirqd/1

   1923 root      20   0       0      0      0 I   1.0   0.0   0:06.81
kworker/1:3-ovpn-crypto-wq-tun0

   1924 root      20   0       0      0      0 I   0.7   0.0   0:00.39
kworker/0:1-ata_sff


tony-vm-2004% mpstat -P ALL 2


Linux 5.4.0-54-generic (tony-vm-2004)   11/20/20        _x86_64_        (2
CPU)




01:56:07     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal
 %guest  %gnice   %idle
01:56:09     all    0.53    0.00   28.04    0.00    0.00   28.31    0.00
 0.00    0.00   43.12
01:56:09       0    1.12    0.00    6.18    0.00    0.00    1.12    0.00
 0.00    0.00   91.57
01:56:09       1    0.00    0.00   47.50    0.00    0.00   52.50    0.00
 0.00    0.00    0.00

01:56:09     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal
 %guest  %gnice   %idle
01:56:11     all    0.53    0.00   25.66    0.26    0.00   32.28    0.00
 0.00    0.00   41.27
01:56:11       0    1.12    0.00    8.43    0.56    0.00    2.81    0.00
 0.00    0.00   87.08
01:56:11       1    0.00    0.00   41.00    0.00    0.00   58.50    0.00
 0.00    0.00    0.50


Tony

--000000000000d966d905b480414a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGkgQW50b25pbyw8ZGl2Pjxicj48L2Rpdj48ZGl2PkkmIzM5O20gdGVz
dGluZyB0aGUgcGVyZm9ybWFuY2Ugb2Ygb3Zwbi1kY28uPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRp
dj5Ub3BvbG9neTo8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PmlwZXJmIGNsaWVudCBydW5uaW5n
IGluIFVidW50dSAyMC4wNCBWTSB3aXRoIHR3byBjb3JlcyhpbnRlbCBpNyA2NzAwKcKgIC0gaXBl
cmYgc2VydmVyIHJ1bm5pbmcgVWJ1bnR1IDE4LjA0IEhQIEVsaXRlQm9vayB3aXRoIGZvdXIgY29y
ZXMoaW50ZWwgaTUtNjMwMFUpLjwvZGl2PjxkaXY+dHVubmVswqAgSVAgNS41LjUuMcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHR1bm5lbCBJUCA1LjUuNS4yPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGUgaXNz
dWUgSSBzZWUgaXMgdGhlIFRQIGlzIGRpZmZlcmVudCBpbiBib3RoIGRpcmVjdGlvbnMuIElzIHRo
aXMgbm9ybWFsPyBJIGRvbiYjMzk7dCBzZWUgdGhpcyBpc3N1ZSBpZiB1c2luZyB0aGUgaG9zdCBv
ZiBWTSBhbmQgdGhlIFRQIGlzIHZlcnkgZ29vZDwvZGl2PjxkaXY+aW4gYm90aCBkaXJlY3Rpb25z
KH44NzBNYnBzKS5WTSBzaG91bGQgYmUgdGhlIGJvdHRsZW5lY2sgYnV0IEkgZG9uJiMzOTt0IHVu
ZGVyc3RhbmQgd2h5IHRoZSBUUCBpcyBzbyBtdWNoIGRpZmZlcmVudCBpbiBib3RoIGRpcmVjdGlv
bi48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxiPjxmb250IHNpemU9IjQiPjEuIG1haW4gYXBw
bGljYXRpb24gZGF0YSBmcm9tIFVidW50dSAyMC4wNCBWTSB0byBVYnVudHUgMTguMDQ8L2ZvbnQ+
PC9iPjwvZGl2PjxkaXY+dG9ueS12bS0yMDA0JSBpcGVyZjMgLWMgNS41LjUuMiAtdCAxNSDCoCDC
oDxicj5Db25uZWN0aW5nIHRvIGhvc3QgNS41LjUuMiwgcG9ydCA1MjAxPGJyPlsgwqA1XSBsb2Nh
bCA1LjUuNS4xIHBvcnQgNTUzNDIgY29ubmVjdGVkIHRvIDUuNS41LjIgcG9ydCA1MjAxPGJyPlsg
SURdIEludGVydmFsIMKgIMKgIMKgIMKgIMKgIFRyYW5zZmVyIMKgIMKgIEJpdHJhdGUgwqAgwqAg
wqAgwqAgUmV0ciDCoEN3bmQ8YnI+WyDCoDVdIMKgIDAuMDAtMS4wMCDCoCBzZWMgwqAzNy4zIE1C
eXRlcyDCoCAzMTMgTWJpdHMvc2VjIMKgIMKgMCDCoCDCoDQyNyBLQnl0ZXMgwqAgwqAgwqAgPGJy
PlsgwqA1XSDCoCAxLjAwLTIuMDAgwqAgc2VjIMKgMzMuNCBNQnl0ZXMgwqAgMjgwIE1iaXRzL3Nl
YyDCoCDCoDAgwqAgwqA0MjcgS0J5dGVzIMKgIMKgIMKgIDxicj5bIMKgNV0gwqAgMi4wMC0zLjAw
IMKgIHNlYyDCoDM1LjEgTUJ5dGVzIMKgIDI5NCBNYml0cy9zZWMgwqAgwqAwIMKgIMKgNDI3IEtC
eXRlcyDCoCDCoCDCoCA8YnI+WyDCoDVdIMKgIDMuMDAtNC4wMCDCoCBzZWMgwqAzNC40IE1CeXRl
cyDCoCAyODkgTWJpdHMvc2VjIMKgIMKgMCDCoCDCoDQ1NyBLQnl0ZXMgwqAgwqAgwqAgPGJyPlsg
wqA1XSDCoCA0LjAwLTUuMDAgwqAgc2VjIMKgMzMuNyBNQnl0ZXMgwqAgMjgzIE1iaXRzL3NlYyDC
oCDCoDAgwqAgwqA0NTcgS0J5dGVzIMKgIMKgIMKgIDxicj5bIMKgNV0gwqAgNS4wMC02LjAwIMKg
IHNlYyDCoDM0LjcgTUJ5dGVzIMKgIDI5MSBNYml0cy9zZWMgwqAgwqAwIMKgIMKgNDU3IEtCeXRl
cyDCoCDCoCDCoCA8YnI+WyDCoDVdIMKgIDYuMDAtNy4wMCDCoCBzZWMgwqAzMy44IE1CeXRlcyDC
oCAyODQgTWJpdHMvc2VjIMKgIMKgMCDCoCDCoDQ1NyBLQnl0ZXMgwqAgwqAgwqAgPGJyPlsgwqA1
XSDCoCA3LjAwLTguMDAgwqAgc2VjIMKgMzMuOSBNQnl0ZXMgwqAgMjg1IE1iaXRzL3NlYyDCoCDC
oDAgwqAgwqA0NTcgS0J5dGVzIMKgIMKgIMKgIDxicj5bIMKgNV0gwqAgOC4wMC05LjAwIMKgIHNl
YyDCoDM0LjQgTUJ5dGVzIMKgIDI4OCBNYml0cy9zZWMgwqAgwqAwIMKgIMKgNDU3IEtCeXRlcyDC
oCDCoCDCoCA8YnI+WyDCoDVdIMKgIDkuMDAtMTAuMDAgwqBzZWMgwqAzMy45IE1CeXRlcyDCoCAy
ODQgTWJpdHMvc2VjIMKgIMKgMCDCoCDCoDQ1NyBLQnl0ZXMgwqAgwqAgwqAgPGJyPlsgwqA1XSDC
oDEwLjAwLTExLjAwIMKgc2VjIMKgMzQuMCBNQnl0ZXMgwqAgMjg1IE1iaXRzL3NlYyDCoCDCoDAg
wqAgwqA0NTcgS0J5dGVzIMKgIMKgIMKgIDxicj5bIMKgNV0gwqAxMS4wMC0xMi4wMCDCoHNlYyDC
oDMxLjcgTUJ5dGVzIMKgIDI2NiBNYml0cy9zZWMgwqAgwqAwIMKgIMKgNDU3IEtCeXRlcyDCoCDC
oCDCoCA8YnI+WyDCoDVdIMKgMTIuMDAtMTMuMDAgwqBzZWMgwqAzMC44IE1CeXRlcyDCoCAyNTkg
TWJpdHMvc2VjIMKgIMKgMCDCoCDCoDQ1NyBLQnl0ZXMgwqAgwqAgwqAgPGJyPlsgwqA1XSDCoDEz
LjAwLTE0LjAwIMKgc2VjIMKgMzMuMSBNQnl0ZXMgwqAgMjc4IE1iaXRzL3NlYyDCoCDCoDAgwqAg
wqA5MTEgS0J5dGVzIMKgIMKgIMKgIDxicj5bIMKgNV0gwqAxNC4wMC0xNS4wMCDCoHNlYyDCoDMz
LjggTUJ5dGVzIMKgIDI4MyBNYml0cy9zZWMgwqAgwqAwIMKgIMKgOTExIEtCeXRlcyDCoCDCoCDC
oCA8YnI+LSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLTxi
cj5bIElEXSBJbnRlcnZhbCDCoCDCoCDCoCDCoCDCoCBUcmFuc2ZlciDCoCDCoCBCaXRyYXRlIMKg
IMKgIMKgIMKgIFJldHI8YnI+WyDCoDVdIMKgIDAuMDAtMTUuMDAgwqBzZWMgwqAgNTA4IE1CeXRl
cyDCoCAyODQgTWJpdHMvc2VjIMKgIMKgMCDCoCDCoCDCoCDCoCDCoCDCoCBzZW5kZXI8YnI+WyDC
oDVdIMKgIDAuMDAtMTUuMDAgwqBzZWMgwqAgNTA1IE1CeXRlcyDCoCA8Zm9udCBjb2xvcj0iI2Zm
MDAwMCI+MjgyIE1iaXRzL3NlYzwvZm9udD4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZWNl
aXZlcjxicj48YnI+aXBlcmYgRG9uZS48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj50b3AgLSAwMTozOTowMyB1cCA0MiBtaW4sIMKgMiB1c2VycywgwqBsb2FkIGF2
ZXJhZ2U6IDAuNjIsIDAuODYsIDAuNzA8YnI+VGFza3M6IDExMiB0b3RhbCwgwqAgNSBydW5uaW5n
LCAxMDcgc2xlZXBpbmcsIMKgIDAgc3RvcHBlZCwgwqAgMCB6b21iaWU8YnI+JUNwdShzKTogwqAw
LjIgdXMsIDI5LjUgc3ksIMKgMC4wIG5pLCA0OS4wIGlkLCDCoDAuMiB3YSwgwqAwLjAgaGksIDIx
LjEgc2ksIMKgMC4wIHN0PGJyPk1pQiBNZW0gOiDCoCDCoDk4MS4xIHRvdGFsLCDCoCDCoDQ2MS40
IGZyZWUsIMKgIMKgMTYwLjIgdXNlZCwgwqAgwqAzNTkuNCBidWZmL2NhY2hlPGJyPk1pQiBTd2Fw
OiDCoCDCoCDCoDAuMCB0b3RhbCwgwqAgwqAgwqAwLjAgZnJlZSwgwqAgwqAgwqAwLjAgdXNlZC4g
wqAgwqA2NjguNCBhdmFpbCBNZW0gPGJyPjxicj7CoCDCoCBQSUQgVVNFUiDCoCDCoCDCoFBSIMKg
TkkgwqAgwqBWSVJUIMKgIMKgUkVTIMKgIMKgU0hSIFMgwqAlQ1BVIMKgJU1FTSDCoCDCoCBUSU1F
KyBDT01NQU5EPGJyPsKgIMKgMTg0MSByb290IMKgIMKgIMKgMjAgwqAgMCDCoCDCoCDCoCAwIMKg
IMKgIMKgMCDCoCDCoCDCoDAgUiDCoDM1LjAgwqAgMC4wIMKgIDI6NTEuNTgga3dvcmtlci8xOjEr
b3Zwbi1jcnlwdG8td3EtdHVuMDxicj7CoCDCoCDCoDE4IHJvb3QgwqAgwqAgwqAyMCDCoCAwIMKg
IMKgIMKgIDAgwqAgwqAgwqAwIMKgIMKgIMKgMCBSIMKgMzAuNyDCoCAwLjAgwqAgMjoxOC40MyBr
c29mdGlycWQvMTxicj7CoCDCoDE5MDQgcm9vdCDCoCDCoCDCoDIwIMKgIDAgwqAgwqAgwqAgMCDC
oCDCoCDCoDAgwqAgwqAgwqAwIEkgwqAxOC4wIMKgIDAuMCDCoCAwOjAzLjYyIGt3b3JrZXIvMToy
LW92cG4tY3J5cHRvLXdxLXR1bjA8YnI+wqAgwqAxODgyIHJvb3QgwqAgwqAgwqAyMCDCoCAwIMKg
IMKgIMKgIDAgwqAgwqAgwqAwIMKgIMKgIMKgMCBSIMKgMTUuMyDCoCAwLjAgwqAgMDo0Ni40NyBr
d29ya2VyLzE6MC1vdnBuLWNyeXB0by13cS10dW4wPGJyPsKgIMKgMTkxMCB0b255IMKgIMKgIMKg
MjAgwqAgMCDCoCDCoDU5MDAgwqAgMzE1NiDCoCAyNzM2IFMgwqAgMC43IMKgIDAuMyDCoCAwOjAw
LjA2IGlwZXJmMzxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PnRv
bnktdm0tMjAwNCUgbXBzdGF0IC1QIEFMTCAyIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgPGJyPkxpbnV4IDUuNC4wLTU0LWdlbmVyaWMgKHRvbnktdm0tMjAwNCkg
wqAgMTEvMjAvMjAgwqAgwqAgwqAgwqBfeDg2XzY0XyDCoCDCoCDCoCDCoCgyIENQVSkgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8
YnI+MDE6NTE6MDUgwqAgwqAgQ1BVIMKgIMKgJXVzciDCoCAlbmljZSDCoCDCoCVzeXMgJWlvd2Fp
dCDCoCDCoCVpcnEgwqAgJXNvZnQgwqAlc3RlYWwgwqAlZ3Vlc3QgwqAlZ25pY2UgwqAgJWlkbGU8
YnI+MDE6NTE6MDcgwqAgwqAgYWxsIMKgIMKgMC4wMCDCoCDCoDAuMDAgwqAgMzAuNzEgwqAgwqAw
LjAwIMKgIMKgMC4wMCDCoCAyMC42NCDCoCDCoDAuMDAgwqAgwqAwLjAwIMKgIMKgMC4wMCDCoCA0
OC42NTxicj4wMTo1MTowNyDCoCDCoCDCoCAwIMKgIMKgMC4wMCDCoCDCoDAuMDAgwqAgwqAwLjAw
IMKgIMKgMC4wMCDCoCDCoDAuMDAgwqAgwqA0LjM1IMKgIMKgMC4wMCDCoCDCoDAuMDAgwqAgwqAw
LjAwIMKgIDk1LjY1PGJyPjAxOjUxOjA3IMKgIMKgIMKgIDEgwqAgwqAwLjAwIMKgIMKgMC4wMCDC
oCA2Mi41MCDCoCDCoDAuMDAgwqAgwqAwLjAwIMKgIDM3LjUwIMKgIMKgMC4wMCDCoCDCoDAuMDAg
wqAgwqAwLjAwIMKgIMKgMC4wMDxicj48YnI+MDE6NTE6MDcgwqAgwqAgQ1BVIMKgIMKgJXVzciDC
oCAlbmljZSDCoCDCoCVzeXMgJWlvd2FpdCDCoCDCoCVpcnEgwqAgJXNvZnQgwqAlc3RlYWwgwqAl
Z3Vlc3QgwqAlZ25pY2UgwqAgJWlkbGU8YnI+MDE6NTE6MDkgwqAgwqAgYWxsIMKgIMKgMC4yNCDC
oCDCoDAuMDAgwqAgMjkuNzYgwqAgwqAwLjAwIMKgIMKgMC4wMCDCoCAyMS40NiDCoCDCoDAuMDAg
wqAgwqAwLjAwIMKgIMKgMC4wMCDCoCA0OC41NDxicj4wMTo1MTowOSDCoCDCoCDCoCAwIMKgIMKg
MC40OCDCoCDCoDAuMDAgwqAgwqAwLjQ4IMKgIMKgMC4wMCDCoCDCoDAuMDAgwqAgwqA0LjMxIMKg
IMKgMC4wMCDCoCDCoDAuMDAgwqAgwqAwLjAwIMKgIDk0Ljc0PGJyPjAxOjUxOjA5IMKgIMKgIMKg
IDEgwqAgwqAwLjAwIMKgIMKgMC4wMCDCoCA2MC4yMCDCoCDCoDAuMDAgwqAgwqAwLjAwIMKgIDM5
LjMwIMKgIMKgMC4wMCDCoCDCoDAuMDAgwqAgwqAwLjAwIMKgIMKgMC41MDxicj48L2Rpdj48ZGl2
Pjxicj48L2Rpdj48ZGl2PjxiPjxmb250IHNpemU9IjQiPjIuIG1haW4gYXBwbGljYXRpb24gZGF0
YSBmcm9tIFVidW50dSAxOC4wNMKgIHRvIFVidW50dSAyMC4wNCBWTSAodXNpbmcgb3B0aW9uICZx
dW90Oy1SJnF1b3Q7IG9mIGlwZXJmMynCoDwvZm9udD48L2I+PGJyPjwvZGl2PjxkaXY+dG9ueS12
bS0yMDA0JSBpcGVyZjMgLWMgNS41LjUuMiAtdCAxNSDCoC1SPGJyPkNvbm5lY3RpbmcgdG8gaG9z
dCA1LjUuNS4yLCBwb3J0IDUyMDE8YnI+UmV2ZXJzZSBtb2RlLCByZW1vdGUgaG9zdCA1LjUuNS4y
IGlzIHNlbmRpbmc8YnI+WyDCoDVdIGxvY2FsIDUuNS41LjEgcG9ydCA1NTM1NCBjb25uZWN0ZWQg
dG8gNS41LjUuMiBwb3J0IDUyMDE8YnI+WyBJRF0gSW50ZXJ2YWwgwqAgwqAgwqAgwqAgwqAgVHJh
bnNmZXIgwqAgwqAgQml0cmF0ZTxicj5bIMKgNV0gwqAgMC4wMC0xLjAwIMKgIHNlYyDCoDU2Ljcg
TUJ5dGVzIMKgIDQ3NiBNYml0cy9zZWMgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDC
oDVdIMKgIDEuMDAtMi4wMCDCoCBzZWMgwqA2NS42IE1CeXRlcyDCoCA1NTEgTWJpdHMvc2VjIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPlsgwqA1XSDCoCAyLjAwLTMuMDAgwqAgc2VjIMKg
NjguMSBNQnl0ZXMgwqAgNTcyIE1iaXRzL3NlYyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxi
cj5bIMKgNV0gwqAgMy4wMC00LjAwIMKgIHNlYyDCoDcyLjggTUJ5dGVzIMKgIDYxMSBNYml0cy9z
ZWMgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDCoDVdIMKgIDQuMDAtNS4wMCDCoCBz
ZWMgwqA2Ny4zIE1CeXRlcyDCoCA1NjQgTWJpdHMvc2VjIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgPGJyPlsgwqA1XSDCoCA1LjAwLTYuMDAgwqAgc2VjIMKgODIuMCBNQnl0ZXMgwqAgNjg4IE1i
aXRzL3NlYyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj5bIMKgNV0gwqAgNi4wMC03LjAw
IMKgIHNlYyDCoDg4LjAgTUJ5dGVzIMKgIDczOCBNYml0cy9zZWMgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqA8YnI+WyDCoDVdIMKgIDcuMDAtOC4wMCDCoCBzZWMgwqA5Mi4xIE1CeXRlcyDCoCA3
NzMgTWJpdHMvc2VjIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPlsgwqA1XSDCoCA4LjAw
LTkuMDAgwqAgc2VjIMKgOTQuNyBNQnl0ZXMgwqAgNzk0IE1iaXRzL3NlYyDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoDxicj5bIMKgNV0gwqAgOS4wMC0xMC4wMCDCoHNlYyDCoDk4LjQgTUJ5dGVz
IMKgIDgyNiBNYml0cy9zZWMgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDCoDVdIMKg
MTAuMDAtMTEuMDAgwqBzZWMgwqA5My4wIE1CeXRlcyDCoCA3ODAgTWJpdHMvc2VjIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgPGJyPlsgwqA1XSDCoDExLjAwLTEyLjAwIMKgc2VjIMKgOTIuMSBN
Qnl0ZXMgwqAgNzczIE1iaXRzL3NlYyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj5bIMKg
NV0gwqAxMi4wMC0xMy4wMCDCoHNlYyDCoDkwLjggTUJ5dGVzIMKgIDc2MiBNYml0cy9zZWMgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDCoDVdIMKgMTMuMDAtMTQuMDAgwqBzZWMgwqA5
NS4wIE1CeXRlcyDCoCA3OTcgTWJpdHMvc2VjIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJy
PlsgwqA1XSDCoDE0LjAwLTE1LjAwIMKgc2VjIMKgOTYuMCBNQnl0ZXMgwqAgODA2IE1iaXRzL3Nl
YyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4tIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAt
IC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtPGJyPlsgSURdIEludGVydmFsIMKgIMKgIMKgIMKgIMKg
IFRyYW5zZmVyIMKgIMKgIEJpdHJhdGUgwqAgwqAgwqAgwqAgUmV0cjxicj5bIMKgNV0gwqAgMC4w
MC0xNS4wMCDCoHNlYyDCoDEuMjMgR0J5dGVzIMKgIDcwMyBNYml0cy9zZWMgwqA4OTEgwqAgwqAg
wqAgwqAgwqAgwqAgc2VuZGVyPGJyPlsgwqA1XSDCoCAwLjAwLTE1LjAwIMKgc2VjIMKgMS4yMiBH
Qnl0ZXMgwqA8c3BhbiBzdHlsZT0iYmFja2dyb3VuZC1jb2xvcjpyZ2IoMjU1LDAsMCkiPiA3MDEg
TWJpdHMvc2VjPC9zcGFuPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJlY2VpdmVyPGJyPjxi
cj5pcGVyZiBEb25lLjxicj48L2Rpdj48ZGl2PnRvcCAtIDAxOjU0OjE1IHVwIDU3IG1pbiwgwqAy
IHVzZXJzLCDCoGxvYWQgYXZlcmFnZTogMC4zOSwgMC4xOSwgMC4zMSDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj5UYXNrczogMTExIHRvdGFsLCDCoCAzIHJ1
bm5pbmcsIDEwOCBzbGVlcGluZywgwqAgMCBzdG9wcGVkLCDCoCAwIHpvbWJpZSDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+JUNwdShzKTogwqAwLjcgdXMsIDI1
Ljcgc3ksIMKgMC4wIG5pLCA0MC4wIGlkLCDCoDAuMCB3YSwgwqAwLjAgaGksIDMzLjYgc2ksIMKg
MC4wIHN0IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPk1pQiBNZW0gOiDCoCDCoDk4MS4x
IHRvdGFsLCDCoCDCoDQ1OS4yIGZyZWUsIMKgIMKgMTYyLjUgdXNlZCwgwqAgwqAzNTkuNCBidWZm
L2NhY2hlIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPk1pQiBTd2FwOiDCoCDC
oCDCoDAuMCB0b3RhbCwgwqAgwqAgwqAwLjAgZnJlZSwgwqAgwqAgwqAwLjAgdXNlZC4gwqAgwqA2
NjYuMiBhdmFpbCBNZW0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPsKgIMKgIFBJRCBVU0VSIMKgIMKgIMKgUFIg
wqBOSSDCoCDCoFZJUlQgwqAgwqBSRVMgwqAgwqBTSFIgUyDCoCVDUFUgwqAlTUVNIMKgIMKgIFRJ
TUUrIENPTU1BTkQgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPsKgIMKgMTkwNCByb290
IMKgIMKgIMKgMjAgwqAgMCDCoCDCoCDCoCAwIMKgIMKgIMKgMCDCoCDCoCDCoDAgSSDCoDgyLjcg
wqAgMC4wIMKgIDA6MTguOTEga3dvcmtlci8xOjItb3Zwbi1jcnlwdG8td3EtdHVuMCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+wqAgwqAxNjc2IHJv
b3QgwqAgwqAgwqAyMCDCoCAwIMKgIMKgIMKgIDAgwqAgwqAgwqAwIMKgIMKgIMKgMCBJIMKgMTcu
MCDCoCAwLjAgwqAgMDoxNS4yNSBrd29ya2VyLzA6MC1ldmVudHMgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+wqAg
wqAgwqAxOCByb290IMKgIMKgIMKgMjAgwqAgMCDCoCDCoCDCoCAwIMKgIMKgIMKgMCDCoCDCoCDC
oDAgUyDCoCAzLjAgwqAgMC4wIMKgIDI6MjUuODgga3NvZnRpcnFkLzEgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgPGJyPsKgIMKgMTkyMyByb290IMKgIMKgIMKgMjAgwqAgMCDCoCDCoCDCoCAwIMKgIMKg
IMKgMCDCoCDCoCDCoDAgSSDCoCAxLjAgwqAgMC4wIMKgIDA6MDYuODEga3dvcmtlci8xOjMtb3Zw
bi1jcnlwdG8td3EtdHVuMCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCA8YnI+wqAgwqAxOTI0IHJvb3QgwqAgwqAgwqAyMCDCoCAwIMKgIMKgIMKgIDAgwqAg
wqAgwqAwIMKgIMKgIMKgMCBJIMKgIDAuNyDCoCAwLjAgwqAgMDowMC4zOSBrd29ya2VyLzA6MS1h
dGFfc2ZmwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8Yj48Zm9udCBzaXplPSI0Ij48YnI+PC9m
b250PjwvYj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PnRvbnktdm0t
MjAwNCUgbXBzdGF0IC1QIEFMTCAyIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgPGJyPkxpbnV4IDUuNC4wLTU0LWdlbmVyaWMgKHRvbnktdm0tMjAwNCkgwqAgMTEv
MjAvMjAgwqAgwqAgwqAgwqBfeDg2XzY0XyDCoCDCoCDCoCDCoCgyIENQVSkgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+MDE6NTY6MDcgwqAgwqAgQ1BV
IMKgIMKgJXVzciDCoCAlbmljZSDCoCDCoCVzeXMgJWlvd2FpdCDCoCDCoCVpcnEgwqAgJXNvZnQg
wqAlc3RlYWwgwqAlZ3Vlc3QgwqAlZ25pY2UgwqAgJWlkbGU8YnI+MDE6NTY6MDkgwqAgwqAgYWxs
IMKgIMKgMC41MyDCoCDCoDAuMDAgwqAgMjguMDQgwqAgwqAwLjAwIMKgIMKgMC4wMCDCoCAyOC4z
MSDCoCDCoDAuMDAgwqAgwqAwLjAwIMKgIMKgMC4wMCDCoCA0My4xMjxicj4wMTo1NjowOSDCoCDC
oCDCoCAwIMKgIMKgMS4xMiDCoCDCoDAuMDAgwqAgwqA2LjE4IMKgIMKgMC4wMCDCoCDCoDAuMDAg
wqAgwqAxLjEyIMKgIMKgMC4wMCDCoCDCoDAuMDAgwqAgwqAwLjAwIMKgIDkxLjU3PGJyPjAxOjU2
OjA5IMKgIMKgIMKgIDEgwqAgwqAwLjAwIMKgIMKgMC4wMCDCoCA0Ny41MCDCoCDCoDAuMDAgwqAg
wqAwLjAwIMKgIDUyLjUwIMKgIMKgMC4wMCDCoCDCoDAuMDAgwqAgwqAwLjAwIMKgIMKgMC4wMDxi
cj48YnI+MDE6NTY6MDkgwqAgwqAgQ1BVIMKgIMKgJXVzciDCoCAlbmljZSDCoCDCoCVzeXMgJWlv
d2FpdCDCoCDCoCVpcnEgwqAgJXNvZnQgwqAlc3RlYWwgwqAlZ3Vlc3QgwqAlZ25pY2UgwqAgJWlk
bGU8YnI+MDE6NTY6MTEgwqAgwqAgYWxsIMKgIMKgMC41MyDCoCDCoDAuMDAgwqAgMjUuNjYgwqAg
wqAwLjI2IMKgIMKgMC4wMCDCoCAzMi4yOCDCoCDCoDAuMDAgwqAgwqAwLjAwIMKgIMKgMC4wMCDC
oCA0MS4yNzxicj4wMTo1NjoxMSDCoCDCoCDCoCAwIMKgIMKgMS4xMiDCoCDCoDAuMDAgwqAgwqA4
LjQzIMKgIMKgMC41NiDCoCDCoDAuMDAgwqAgwqAyLjgxIMKgIMKgMC4wMCDCoCDCoDAuMDAgwqAg
wqAwLjAwIMKgIDg3LjA4PGJyPjAxOjU2OjExIMKgIMKgIMKgIDEgwqAgwqAwLjAwIMKgIMKgMC4w
MCDCoCA0MS4wMCDCoCDCoDAuMDAgwqAgwqAwLjAwIMKgIDU4LjUwIMKgIMKgMC4wMCDCoCDCoDAu
MDAgwqAgwqAwLjAwIMKgIMKgMC41MDxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48
L2Rpdj48ZGl2PlRvbnk8L2Rpdj48L2Rpdj4NCg==

--000000000000d966d905b480414a--

