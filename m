MIME-Version: 1.0
From: Tony He <huangya90@...277...>
Date: Wed, 31 Mar 2021 12:22:18 +0800
Message-ID: <CAAUX2SVQRn4zuDC947HE9M38nDNK1oNqyUv0GKeAw2dasHo62Q@...278...>
Content-Type: multipart/alternative; boundary="000000000000942cca05becd768a"
Subject: [Openvpn-devel] [ovpn-dco] sudden network disconnection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <antonio@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000942cca05becd768a
Content-Type: text/plain; charset="UTF-8"

Hi Antonio,

As you know I am porting opvn-dco to my router whose kernel is V4.14.76.
After solving AF_NETLINK group issue we discussed
yesterday.  It finally works. But I encounter another issue :-( .  When
testing the performance with iperf3, disconnection occurs
and recovers after a few seconds and then again.

 1. powerful x86-64 PC -> weak MIPS64 router(clocked 1GHZ)
Accepted connection from 10.8.0.2, port 38930 [ 5] local 10.8.0.1 port 5201
connected to 10.8.0.2 port 38932 [ ID] Interval Transfer Bitrate [ 5]
0.00-1.00 sec 6.45 MBytes 54.1 Mbits/sec [ 5] 1.00-2.00 sec 7.93 MBytes
66.6 Mbits/sec [ 5] 2.00-3.00 sec 7.66 MBytes 64.3 Mbits/sec [ 5] 3.00-4.00
sec 7.94 MBytes 66.6 Mbits/sec [ 5] 4.00-5.00 sec 7.84 MBytes 65.8
Mbits/sec [ 5] 5.00-6.00 sec 7.83 MBytes 65.7 Mbits/sec [ 5] 6.00-7.00 sec
7.84 MBytes 65.8 Mbits/sec [ 5] 7.00-8.00 sec 9.39 MBytes 78.8 Mbits/sec [
5] 8.00-9.00 sec 8.13 MBytes 68.2 Mbits/sec [ 5] 9.00-10.00 sec 6.31 MBytes
53.0 Mbits/sec [ 5] 10.00-11.00 sec 6.31 MBytes 53.0 Mbits/sec [ 5]
11.00-12.00 sec 6.24 MBytes 52.3 Mbits/sec [ 5] 12.00-13.00 sec 6.42 MBytes
53.8 Mbits/sec [ 5] 13.00-14.00 sec 7.80 MBytes 65.4 Mbits/sec [ 5]
14.00-15.00 sec 7.75 MBytes 65.0 Mbits/sec [ 5] 15.00-16.00 sec 7.86 MBytes
66.0 Mbits/sec [ 5] 16.00-17.00 sec 5.03 MBytes 42.2 Mbits/sec [ 5]
17.00-18.00 sec 0.00 Bytes 0.00 bits/sec [ 5] 18.00-19.00 sec 0.00 Bytes
0.00 bits/sec [ 5] 19.00-20.00 sec 0.00 Bytes 0.00 bits/sec [ 5]
20.00-21.00 sec 0.00 Bytes 0.00 bits/sec [ 5] 21.00-22.00 sec 0.00 Bytes
0.00 bits/sec [ 5] 22.00-23.00 sec 0.00 Bytes 0.00 bits/sec [ 5]
23.00-24.00 sec 0.00 Bytes 0.00 bits/sec [ 5] 24.00-25.00 sec 0.00 Bytes
0.00 bits/sec [ 5] 25.00-26.00 sec 0.00 Bytes 0.00 bits/sec [ 5]
26.00-27.00 sec 0.00 Bytes 0.00 bits/sec [ 5] 27.00-28.00 sec 0.00 Bytes
0.00 bits/sec [ 5] 28.00-29.00 sec 0.00 Bytes 0.00 bits/sec [ 5]
29.00-30.00 sec 0.00 Bytes 0.00 bits/sec [ 5] 30.00-31.00 sec 0.00 Bytes
0.00 bits/sec [ 5] 31.00-32.00 sec 0.00 Bytes 0.00 bits/sec [ 5]
32.00-33.00 sec 0.00 Bytes 0.00 bits/sec [ 5] 33.00-34.00 sec 0.00 Bytes
0.00 bits/sec [ 5] 34.00-35.00 sec 0.00 Bytes 0.00 bits/sec [ 5]
35.00-36.00 sec 0.00 Bytes 0.00 bits/sec [ 5] 36.00-37.00 sec 0.00 Bytes
0.00 bits/sec [ 5] 37.00-38.00 sec 0.00 Bytes 0.00 bits/sec [ 5]
38.00-39.00 sec 0.00 Bytes 0.00 bits/sec [ 5] 39.00-40.00 sec 0.00 Bytes
0.00 bits/sec [ 5] 40.00-41.00 sec 0.00 Bytes 0.00 bits/sec [ 5]
41.00-42.00 sec 0.00 Bytes 0.00 bits/sec [ 5] 42.00-43.00 sec 0.00 Bytes
0.00 bits/sec [ 5] 43.00-44.00 sec 4.92 MBytes 41.3 Mbits/sec [ 5]
44.00-45.00 sec 7.74 MBytes 64.9 Mbits/sec [ 5] 45.00-46.00 sec 8.01 MBytes
67.2 Mbits/sec [ 5] 46.00-47.00 sec 7.96 MBytes 66.8 Mbits/sec [ 5]
47.00-48.00 sec 7.49 MBytes 62.8 Mbits/sec
Log from dco module:
[36981.631546] ovpn_udp_encap_recv: cannot handle incoming packet: -28
[36982.692005] ovpn_udp_encap_recv: cannot handle incoming packet: -28

2. weak MIPS64 router -> powerful x86-64 PC. It's OK.

Server listening on 5201
----------------------------------------------------------- Accepted
connection from 10.8.0.2, port 39238 [ 5] local 10.8.0.1 port 5201
connected to 10.8.0.2 port 39240 [ ID] Interval Transfer Bitrate Retr Cwnd
[ 5] 0.00-1.00 sec 11.2 MBytes 94.3 Mbits/sec 0 53.7 KBytes [ 5] 1.00-2.00
sec 9.57 MBytes 80.3 Mbits/sec 0 53.7 KBytes [ 5] 2.00-3.00 sec 9.57 MBytes
80.3 Mbits/sec 0 53.7 KBytes [ 5] 3.00-4.00 sec 8.89 MBytes 74.5 Mbits/sec
0 48.1 KBytes [ 5] 4.00-5.00 sec 9.57 MBytes 80.3 Mbits/sec 0 53.7 KBytes [
5] 5.00-6.00 sec 9.57 MBytes 80.3 Mbits/sec 0 53.7 KBytes [ 5] 6.00-7.00
sec 9.57 MBytes 80.3 Mbits/sec 0 53.7 KBytes [ 5] 7.00-8.00 sec 9.57 MBytes
80.3 Mbits/sec 0 53.7 KBytes [ 5] 8.00-9.00 sec 8.89 MBytes 74.5 Mbits/sec
0 53.7 KBytes [ 5] 9.00-10.00 sec 9.57 MBytes 80.3 Mbits/sec 0 53.7 KBytes
[ 5] 10.00-11.00 sec 8.89 MBytes 74.5 Mbits/sec 0 53.7 KBytes [ 5]
11.00-12.00 sec 9.57 MBytes 80.3 Mbits/sec 0 53.7 KBytes [ 5] 12.00-13.00
sec 9.57 MBytes 80.3 Mbits/sec 0 53.7 KBytes [ 5] 13.00-14.00 sec 9.57
MBytes 80.3 Mbits/sec 0 50.9 KBytes [ 5] 14.00-15.00 sec 9.57 MBytes 80.3
Mbits/sec 0 48.1 KBytes [ 5] 15.00-16.00 sec 9.63 MBytes 80.8 Mbits/sec 0
65.0 KBytes [ 5] 16.00-17.00 sec 11.6 MBytes 97.5 Mbits/sec 0 59.4 KBytes [
5] 17.00-18.00 sec 8.89 MBytes 74.5 Mbits/sec 0 53.7 KBytes [ 5]
18.00-19.00 sec 9.57 MBytes 80.3 Mbits/sec 0 53.7 KBytes [ 5] 19.00-20.00
sec 9.57 MBytes 80.3 Mbits/sec 0 53.7 KBytes [ 5] 20.00-21.00 sec 8.89
MBytes 74.5 Mbits/sec 0 53.7 KBytes [ 5] 21.00-22.00 sec 9.57 MBytes 80.3
Mbits/sec 0 53.7 KBytes [ 5] 22.00-23.00 sec 9.57 MBytes 80.3 Mbits/sec 0
53.7 KBytes [ 5] 23.00-24.00 sec 9.57 MBytes 80.3 Mbits/sec 0 53.7 KBytes [
5] 24.00-25.00 sec 9.57 MBytes 80.3 Mbits/sec 0 48.1 KBytes [ 5]
25.00-26.00 sec 9.57 MBytes 80.3 Mbits/sec 0 53.7 KBytes [ 5] 26.00-27.00
sec 9.57 MBytes 80.3 Mbits/sec 0 53.7 KBytes [ 5] 27.00-28.00 sec 9.57
MBytes 80.3 Mbits/sec 0 53.7 KBytes [ 5] 28.00-29.00 sec 9.57 MBytes 80.3
Mbits/sec 0 53.7 KBytes [ 5] 29.00-30.00 sec 9.57 MBytes 80.3 Mbits/sec 0
53.7 KBytes [ 5] 30.00-31.00 sec 8.20 MBytes 68.8 Mbits/sec 0 53.7 KBytes [
5] 31.00-32.00 sec 9.57 MBytes 80.3 Mbits/sec 0 53.7 KBytes [ 5]
32.00-33.00 sec 9.57 MBytes 80.3 Mbits/sec 0 53.7 KBytes [ 5] 33.00-34.00
sec 9.57 MBytes 80.3 Mbits/sec 0 53.7 KBytes [ 5] 34.00-35.00 sec 9.57
MBytes 80.3 Mbits/sec 0 53.7 KBytes [ 5] 35.00-36.00 sec 9.57 MBytes 80.3
Mbits/sec 0 59.4 KBytes [ 5] 36.00-37.00 sec 9.57 MBytes 80.3 Mbits/sec 0
53.7 KBytes [ 5] 37.00-38.00 sec 9.57 MBytes 80.3 Mbits/sec 0 53.7 KBytes [
5] 38.00-39.00 sec 9.57 MBytes 80.3 Mbits/sec 0 53.7 KBytes [ 5]
39.00-40.00 sec 9.57 MBytes 80.3 Mbits/sec 0 53.7 KBytes [ 5] 40.00-41.00
sec 8.89 MBytes 74.5 Mbits/sec 0 53.7 KBytes [ 5] 41.00-42.00 sec 9.57
MBytes 80.3 Mbits/sec 0 53.7 KBytes [ 5] 42.00-43.00 sec 9.57 MBytes 80.3
Mbits/sec 0 53.7 KBytes [ 5] 43.00-44.00 sec 9.57 MBytes 80.3 Mbits/sec 0
53.7 KBytes [ 5] 44.00-45.00 sec 9.57 MBytes 80.3 Mbits/sec 0 53.7 KBytes [
5] 45.00-46.00 sec 9.57 MBytes 80.2 Mbits/sec 0 53.7 KBytes [ 5]
46.00-47.00 sec 8.89 MBytes 74.6 Mbits/sec 0 53.7 KBytes [ 5] 47.00-48.00
sec 10.3 MBytes 86.0 Mbits/sec 0 53.7 KBytes [ 5] 48.00-49.00 sec 8.89
MBytes 74.5 Mbits/sec 0 53.7 KBytes [ 5] 49.00-50.00 sec 9.57 MBytes 80.3
Mbits/sec 0 53.7 KBytes [ 5] 50.00-51.00 sec 8.89 MBytes 74.6 Mbits/sec 0
5.66 KBytes [ 5] 51.00-52.00 sec 9.57 MBytes 80.3 Mbits/sec 0 53.7 KBytes [
5] 52.00-53.00 sec 9.57 MBytes 80.3 Mbits/sec 0 53.7 KBytes [ 5]
53.00-54.00 sec 9.57 MBytes 80.3 Mbits/sec 0 53.7 KBytes [ 5] 54.00-55.00
sec 9.57 MBytes 80.3 Mbits/sec 0 53.7 KBytes [ 5] 55.00-56.00 sec 9.57
MBytes 80.3 Mbits/sec 0 53.7 KBytes [ 5] 56.00-57.00 sec 9.57 MBytes 80.3
Mbits/sec 0 53.7 KBytes [ 5] 57.00-58.00 sec 9.57 MBytes 80.3 Mbits/sec 0
48.1 KBytes [ 5] 58.00-59.00 sec 9.57 MBytes 80.3 Mbits/sec 0 53.7 KBytes [
5] 59.00-60.00 sec 9.57 MBytes 80.3 Mbits/sec 0 48.1 KBytes
3. powerful x86-64 PC -> weak MIPS64 router, but disable dco. Also OK.
Server listening on 5201
----------------------------------------------------------- ^BAccepted
connection from 10.8.0.2, port 40324 [ 5] local 10.8.0.1 port 5201
connected to 10.8.0.2 port 40326 [ ID] Interval Transfer Bitrate [ 5]
0.00-1.00 sec 5.52 MBytes 46.3 Mbits/sec [ 5] 1.00-2.00 sec 5.77 MBytes
48.4 Mbits/sec [ 5] 2.00-3.00 sec 5.68 MBytes 47.6 Mbits/sec [ 5] 3.00-4.00
sec 5.83 MBytes 48.9 Mbits/sec [ 5] 4.00-5.00 sec 5.97 MBytes 50.1
Mbits/sec [ 5] 5.00-6.00 sec 6.42 MBytes 53.9 Mbits/sec [ 5] 6.00-7.00 sec
6.59 MBytes 55.3 Mbits/sec [ 5] 7.00-8.00 sec 6.48 MBytes 54.3 Mbits/sec [
5] 8.00-9.00 sec 6.53 MBytes 54.8 Mbits/sec [ 5] 9.00-10.00 sec 6.44 MBytes
54.0 Mbits/sec [ 5] 10.00-11.00 sec 6.59 MBytes 55.3 Mbits/sec [ 5]
11.00-12.00 sec 6.53 MBytes 54.8 Mbits/sec [ 5] 12.00-13.00 sec 6.52 MBytes
54.7 Mbits/sec [ 5] 13.00-14.00 sec 6.24 MBytes 52.4 Mbits/sec [ 5]
14.00-15.00 sec 6.38 MBytes 53.5 Mbits/sec [ 5] 15.00-16.00 sec 6.55 MBytes
55.0 Mbits/sec [ 5] 16.00-17.00 sec 6.53 MBytes 54.7 Mbits/sec [ 5]
17.00-18.00 sec 6.46 MBytes 54.1 Mbits/sec [ 5] 18.00-19.00 sec 6.50 MBytes
54.6 Mbits/sec [ 5] 19.00-20.00 sec 6.55 MBytes 55.0 Mbits/sec [ 5]
20.00-21.00 sec 6.51 MBytes 54.6 Mbits/sec [ 5] 21.00-22.00 sec 6.53 MBytes
54.8 Mbits/sec [ 5] 22.00-23.00 sec 6.46 MBytes 54.2 Mbits/sec [ 5]
23.00-24.00 sec 6.47 MBytes 54.3 Mbits/sec [ 5] 24.00-25.00 sec 6.60 MBytes
55.4 Mbits/sec [ 5] 25.00-26.00 sec 6.46 MBytes 54.2 Mbits/sec [ 5]
26.00-27.00 sec 6.46 MBytes 54.2 Mbits/sec [ 5] 27.00-28.00 sec 6.54 MBytes
54.9 Mbits/sec [ 5] 28.00-29.00 sec 6.56 MBytes 55.0 Mbits/sec [ 5]
29.00-30.00 sec 6.49 MBytes 54.5 Mbits/sec [ 5] 30.00-31.00 sec 6.40 MBytes
53.7 Mbits/sec [ 5] 31.00-32.00 sec 6.59 MBytes 55.3 Mbits/sec [ 5]
32.00-33.00 sec 6.44 MBytes 54.0 Mbits/sec [ 5] 33.00-34.00 sec 6.58 MBytes
55.2 Mbits/sec [ 5] 34.00-35.00 sec 6.33 MBytes 53.1 Mbits/sec [ 5]
35.00-36.00 sec 6.45 MBytes 54.1 Mbits/sec [ 5] 36.00-37.00 sec 6.49 MBytes
54.5 Mbits/sec [ 5] 37.00-38.00 sec 6.46 MBytes 54.2 Mbits/sec [ 5]
38.00-39.00 sec 6.53 MBytes 54.8 Mbits/sec [ 5] 39.00-40.00 sec 6.52 MBytes
54.7 Mbits/sec [ 5] 40.00-41.00 sec 6.44 MBytes 54.0 Mbits/sec [ 5]
41.00-42.00 sec 6.48 MBytes 54.3 Mbits/sec [ 5] 42.00-43.00 sec 6.43 MBytes
54.0 Mbits/sec [ 5] 43.00-44.00 sec 6.59 MBytes 55.3 Mbits/sec [ 5]
44.00-45.00 sec 6.46 MBytes 54.2 Mbits/sec [ 5] 45.00-46.00 sec 6.55 MBytes
54.9 Mbits/sec [ 5] 46.00-47.00 sec 6.60 MBytes 55.4 Mbits/sec [ 5]
47.00-48.00 sec 6.06 MBytes 50.8 Mbits/sec [ 5] 48.00-49.00 sec 4.63 MBytes
38.8 Mbits/sec [ 5] 49.00-50.00 sec 4.68 MBytes 39.3 Mbits/sec [ 5]
50.00-51.00 sec 5.26 MBytes 44.1 Mbits/sec [ 5] 51.00-52.00 sec 5.79 MBytes
48.5 Mbits/sec [ 5] 52.00-53.00 sec 5.74 MBytes 48.2 Mbits/sec [ 5]
53.00-54.00 sec 5.71 MBytes 47.9 Mbits/sec [ 5] 54.00-55.00 sec 5.77 MBytes
48.4 Mbits/sec [ 5] 55.00-56.00 sec 5.74 MBytes 48.2 Mbits/sec [ 5]
56.00-57.00 sec 5.79 MBytes 48.5 Mbits/sec [ 5] 57.00-58.00 sec 5.66 MBytes
47.5 Mbits/sec [ 5] 58.00-59.00 sec 5.81 MBytes 48.7 Mbits/sec [ 5]
59.00-60.00 sec 5.74 MBytes 48.2 Mbits/sec [ 5] 60.00-60.00 sec 11.9 KBytes
54.6 Mbits/sec
Not sure if it's a problem caused by dco module or my old kernel or
hardware. Maybe I should test in more platforms and kernel versions
to compare. If you have any idea, please let me know. Thanks a lot.

Tony

--000000000000942cca05becd768a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Antonio,<div><br></div><div>As you know I am porting op=
vn-dco to my router whose kernel is V4.14.76. After solving AF_NETLINK grou=
p issue we discussed</div><div>yesterday.=C2=A0 It finally works. But I enc=
ounter another issue=C2=A0:-( .=C2=A0 When testing the performance with ipe=
rf3, disconnection occurs</div><div>and recovers after a few seconds and th=
en again.</div><div><br></div><div>=C2=A01. powerful x86-64 PC -&gt; weak M=
IPS64 router(clocked 1GHZ)</div><div><div style=3D"white-space:pre-wrap">
 Accepted connection from 10.8.0.2, port 38930
[  5] local 10.8.0.1 port 5201 connected to 10.8.0.2 port 38932
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  6.45 MBytes  54.1 Mbits/sec
[  5]   1.00-2.00   sec  7.93 MBytes  66.6 Mbits/sec
[  5]   2.00-3.00   sec  7.66 MBytes  64.3 Mbits/sec
[  5]   3.00-4.00   sec  7.94 MBytes  66.6 Mbits/sec
[  5]   4.00-5.00   sec  7.84 MBytes  65.8 Mbits/sec
[  5]   5.00-6.00   sec  7.83 MBytes  65.7 Mbits/sec
[  5]   6.00-7.00   sec  7.84 MBytes  65.8 Mbits/sec
[  5]   7.00-8.00   sec  9.39 MBytes  78.8 Mbits/sec
[  5]   8.00-9.00   sec  8.13 MBytes  68.2 Mbits/sec
[  5]   9.00-10.00  sec  6.31 MBytes  53.0 Mbits/sec
[  5]  10.00-11.00  sec  6.31 MBytes  53.0 Mbits/sec
[  5]  11.00-12.00  sec  6.24 MBytes  52.3 Mbits/sec
[  5]  12.00-13.00  sec  6.42 MBytes  53.8 Mbits/sec
[  5]  13.00-14.00  sec  7.80 MBytes  65.4 Mbits/sec
[  5]  14.00-15.00  sec  7.75 MBytes  65.0 Mbits/sec
[  5]  15.00-16.00  sec  7.86 MBytes  66.0 Mbits/sec
[  5]  16.00-17.00  sec  5.03 MBytes  42.2 Mbits/sec
[  5]  17.00-18.00  sec  0.00 Bytes  0.00 bits/sec
[  5]  18.00-19.00  sec  0.00 Bytes  0.00 bits/sec
[  5]  19.00-20.00  sec  0.00 Bytes  0.00 bits/sec
[  5]  20.00-21.00  sec  0.00 Bytes  0.00 bits/sec
[  5]  21.00-22.00  sec  0.00 Bytes  0.00 bits/sec
[  5]  22.00-23.00  sec  0.00 Bytes  0.00 bits/sec
[  5]  23.00-24.00  sec  0.00 Bytes  0.00 bits/sec
[  5]  24.00-25.00  sec  0.00 Bytes  0.00 bits/sec
[  5]  25.00-26.00  sec  0.00 Bytes  0.00 bits/sec
[  5]  26.00-27.00  sec  0.00 Bytes  0.00 bits/sec
[  5]  27.00-28.00  sec  0.00 Bytes  0.00 bits/sec
[  5]  28.00-29.00  sec  0.00 Bytes  0.00 bits/sec
[  5]  29.00-30.00  sec  0.00 Bytes  0.00 bits/sec
[  5]  30.00-31.00  sec  0.00 Bytes  0.00 bits/sec
[  5]  31.00-32.00  sec  0.00 Bytes  0.00 bits/sec
[  5]  32.00-33.00  sec  0.00 Bytes  0.00 bits/sec
[  5]  33.00-34.00  sec  0.00 Bytes  0.00 bits/sec
[  5]  34.00-35.00  sec  0.00 Bytes  0.00 bits/sec
[  5]  35.00-36.00  sec  0.00 Bytes  0.00 bits/sec
[  5]  36.00-37.00  sec  0.00 Bytes  0.00 bits/sec
[  5]  37.00-38.00  sec  0.00 Bytes  0.00 bits/sec
[  5]  38.00-39.00  sec  0.00 Bytes  0.00 bits/sec
[  5]  39.00-40.00  sec  0.00 Bytes  0.00 bits/sec
[  5]  40.00-41.00  sec  0.00 Bytes  0.00 bits/sec
[  5]  41.00-42.00  sec  0.00 Bytes  0.00 bits/sec
[  5]  42.00-43.00  sec  0.00 Bytes  0.00 bits/sec
[  5]  43.00-44.00  sec  4.92 MBytes  41.3 Mbits/sec
[  5]  44.00-45.00  sec  7.74 MBytes  64.9 Mbits/sec
[  5]  45.00-46.00  sec  8.01 MBytes  67.2 Mbits/sec
[  5]  46.00-47.00  sec  7.96 MBytes  66.8 Mbits/sec
[  5]  47.00-48.00  sec  7.49 MBytes  62.8 Mbits/sec
             </div></div><div style=3D"white-space:pre-wrap">Log from dco m=
odule:</div><div style=3D"white-space:pre-wrap"><div>[36981.631546] ovpn_ud=
p_encap_recv: cannot handle incoming packet: -28
[36982.692005] ovpn_udp_encap_recv: cannot handle incoming packet: -28
              </div></div><div style=3D"white-space:pre-wrap"><br></div><di=
v style=3D"white-space:pre-wrap">2.  weak MIPS64 router -&gt; powerful x86-=
64 PC.  It&#39;s OK.</div><div style=3D"white-space:pre-wrap"><div><br></di=
v><div>Server listening on 5201
-----------------------------------------------------------
Accepted connection from 10.8.0.2, port 39238
[  5] local 10.8.0.1 port 5201 connected to 10.8.0.2 port 39240
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  11.2 MBytes  94.3 Mbits/sec    0   53.7 KBytes
[  5]   1.00-2.00   sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]   2.00-3.00   sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]   3.00-4.00   sec  8.89 MBytes  74.5 Mbits/sec    0   48.1 KBytes
[  5]   4.00-5.00   sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]   5.00-6.00   sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]   6.00-7.00   sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]   7.00-8.00   sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]   8.00-9.00   sec  8.89 MBytes  74.5 Mbits/sec    0   53.7 KBytes
[  5]   9.00-10.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  10.00-11.00  sec  8.89 MBytes  74.5 Mbits/sec    0   53.7 KBytes
[  5]  11.00-12.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  12.00-13.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  13.00-14.00  sec  9.57 MBytes  80.3 Mbits/sec    0   50.9 KBytes
[  5]  14.00-15.00  sec  9.57 MBytes  80.3 Mbits/sec    0   48.1 KBytes
[  5]  15.00-16.00  sec  9.63 MBytes  80.8 Mbits/sec    0   65.0 KBytes
[  5]  16.00-17.00  sec  11.6 MBytes  97.5 Mbits/sec    0   59.4 KBytes
[  5]  17.00-18.00  sec  8.89 MBytes  74.5 Mbits/sec    0   53.7 KBytes
[  5]  18.00-19.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  19.00-20.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  20.00-21.00  sec  8.89 MBytes  74.5 Mbits/sec    0   53.7 KBytes
[  5]  21.00-22.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  22.00-23.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  23.00-24.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  24.00-25.00  sec  9.57 MBytes  80.3 Mbits/sec    0   48.1 KBytes
[  5]  25.00-26.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  26.00-27.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  27.00-28.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  28.00-29.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  29.00-30.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  30.00-31.00  sec  8.20 MBytes  68.8 Mbits/sec    0   53.7 KBytes
[  5]  31.00-32.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  32.00-33.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  33.00-34.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  34.00-35.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  35.00-36.00  sec  9.57 MBytes  80.3 Mbits/sec    0   59.4 KBytes
[  5]  36.00-37.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  37.00-38.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  38.00-39.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  39.00-40.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  40.00-41.00  sec  8.89 MBytes  74.5 Mbits/sec    0   53.7 KBytes
[  5]  41.00-42.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  42.00-43.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  43.00-44.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  44.00-45.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  45.00-46.00  sec  9.57 MBytes  80.2 Mbits/sec    0   53.7 KBytes
[  5]  46.00-47.00  sec  8.89 MBytes  74.6 Mbits/sec    0   53.7 KBytes
[  5]  47.00-48.00  sec  10.3 MBytes  86.0 Mbits/sec    0   53.7 KBytes
[  5]  48.00-49.00  sec  8.89 MBytes  74.5 Mbits/sec    0   53.7 KBytes
[  5]  49.00-50.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  50.00-51.00  sec  8.89 MBytes  74.6 Mbits/sec    0   5.66 KBytes
[  5]  51.00-52.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  52.00-53.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  53.00-54.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  54.00-55.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  55.00-56.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  56.00-57.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  57.00-58.00  sec  9.57 MBytes  80.3 Mbits/sec    0   48.1 KBytes
[  5]  58.00-59.00  sec  9.57 MBytes  80.3 Mbits/sec    0   53.7 KBytes
[  5]  59.00-60.00  sec  9.57 MBytes  80.3 Mbits/sec    0   48.1 KBytes
              </div><div>3.  powerful x86-64 PC -&gt; weak MIPS64 router, b=
ut disable dco. Also OK.</div><div><div>
Server listening on 5201
-----------------------------------------------------------
^BAccepted connection from 10.8.0.2, port 40324
[  5] local 10.8.0.1 port 5201 connected to 10.8.0.2 port 40326
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  5.52 MBytes  46.3 Mbits/sec
[  5]   1.00-2.00   sec  5.77 MBytes  48.4 Mbits/sec
[  5]   2.00-3.00   sec  5.68 MBytes  47.6 Mbits/sec
[  5]   3.00-4.00   sec  5.83 MBytes  48.9 Mbits/sec
[  5]   4.00-5.00   sec  5.97 MBytes  50.1 Mbits/sec
[  5]   5.00-6.00   sec  6.42 MBytes  53.9 Mbits/sec
[  5]   6.00-7.00   sec  6.59 MBytes  55.3 Mbits/sec
[  5]   7.00-8.00   sec  6.48 MBytes  54.3 Mbits/sec
[  5]   8.00-9.00   sec  6.53 MBytes  54.8 Mbits/sec
[  5]   9.00-10.00  sec  6.44 MBytes  54.0 Mbits/sec
[  5]  10.00-11.00  sec  6.59 MBytes  55.3 Mbits/sec
[  5]  11.00-12.00  sec  6.53 MBytes  54.8 Mbits/sec
[  5]  12.00-13.00  sec  6.52 MBytes  54.7 Mbits/sec
[  5]  13.00-14.00  sec  6.24 MBytes  52.4 Mbits/sec
[  5]  14.00-15.00  sec  6.38 MBytes  53.5 Mbits/sec
[  5]  15.00-16.00  sec  6.55 MBytes  55.0 Mbits/sec
[  5]  16.00-17.00  sec  6.53 MBytes  54.7 Mbits/sec
[  5]  17.00-18.00  sec  6.46 MBytes  54.1 Mbits/sec
[  5]  18.00-19.00  sec  6.50 MBytes  54.6 Mbits/sec
[  5]  19.00-20.00  sec  6.55 MBytes  55.0 Mbits/sec
[  5]  20.00-21.00  sec  6.51 MBytes  54.6 Mbits/sec
[  5]  21.00-22.00  sec  6.53 MBytes  54.8 Mbits/sec
[  5]  22.00-23.00  sec  6.46 MBytes  54.2 Mbits/sec
[  5]  23.00-24.00  sec  6.47 MBytes  54.3 Mbits/sec
[  5]  24.00-25.00  sec  6.60 MBytes  55.4 Mbits/sec
[  5]  25.00-26.00  sec  6.46 MBytes  54.2 Mbits/sec
[  5]  26.00-27.00  sec  6.46 MBytes  54.2 Mbits/sec
[  5]  27.00-28.00  sec  6.54 MBytes  54.9 Mbits/sec
[  5]  28.00-29.00  sec  6.56 MBytes  55.0 Mbits/sec
[  5]  29.00-30.00  sec  6.49 MBytes  54.5 Mbits/sec
[  5]  30.00-31.00  sec  6.40 MBytes  53.7 Mbits/sec
[  5]  31.00-32.00  sec  6.59 MBytes  55.3 Mbits/sec
[  5]  32.00-33.00  sec  6.44 MBytes  54.0 Mbits/sec
[  5]  33.00-34.00  sec  6.58 MBytes  55.2 Mbits/sec
[  5]  34.00-35.00  sec  6.33 MBytes  53.1 Mbits/sec
[  5]  35.00-36.00  sec  6.45 MBytes  54.1 Mbits/sec
[  5]  36.00-37.00  sec  6.49 MBytes  54.5 Mbits/sec
[  5]  37.00-38.00  sec  6.46 MBytes  54.2 Mbits/sec
[  5]  38.00-39.00  sec  6.53 MBytes  54.8 Mbits/sec
[  5]  39.00-40.00  sec  6.52 MBytes  54.7 Mbits/sec
[  5]  40.00-41.00  sec  6.44 MBytes  54.0 Mbits/sec
[  5]  41.00-42.00  sec  6.48 MBytes  54.3 Mbits/sec
[  5]  42.00-43.00  sec  6.43 MBytes  54.0 Mbits/sec
[  5]  43.00-44.00  sec  6.59 MBytes  55.3 Mbits/sec
[  5]  44.00-45.00  sec  6.46 MBytes  54.2 Mbits/sec
[  5]  45.00-46.00  sec  6.55 MBytes  54.9 Mbits/sec
[  5]  46.00-47.00  sec  6.60 MBytes  55.4 Mbits/sec
[  5]  47.00-48.00  sec  6.06 MBytes  50.8 Mbits/sec
[  5]  48.00-49.00  sec  4.63 MBytes  38.8 Mbits/sec
[  5]  49.00-50.00  sec  4.68 MBytes  39.3 Mbits/sec
[  5]  50.00-51.00  sec  5.26 MBytes  44.1 Mbits/sec
[  5]  51.00-52.00  sec  5.79 MBytes  48.5 Mbits/sec
[  5]  52.00-53.00  sec  5.74 MBytes  48.2 Mbits/sec
[  5]  53.00-54.00  sec  5.71 MBytes  47.9 Mbits/sec
[  5]  54.00-55.00  sec  5.77 MBytes  48.4 Mbits/sec
[  5]  55.00-56.00  sec  5.74 MBytes  48.2 Mbits/sec
[  5]  56.00-57.00  sec  5.79 MBytes  48.5 Mbits/sec
[  5]  57.00-58.00  sec  5.66 MBytes  47.5 Mbits/sec
[  5]  58.00-59.00  sec  5.81 MBytes  48.7 Mbits/sec
[  5]  59.00-60.00  sec  5.74 MBytes  48.2 Mbits/sec
[  5]  60.00-60.00  sec  11.9 KBytes  54.6 Mbits/sec

            </div></div><div>Not sure if it&#39;s a problem caused by dco m=
odule or my old kernel or hardware.  Maybe I should test in more platforms =
and kernel versions</div><div>to compare. If you have any idea,  please let=
 me know. Thanks a lot.</div><div><br></div><div>Tony</div></div></div>

--000000000000942cca05becd768a--

