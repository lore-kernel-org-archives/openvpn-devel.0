From: <openvpn@...1315...>
Date: Tue, 02 Mar 2010 21:52:25 -0600
Message-id: <1267588345473303500@...1315...>
MIME-version: 1.0
Content-type: multipart/alternative;
	boundary="===axigen=3144668069037460751867952378953360403040=axigen==="
Subject: [Openvpn-devel] Erratic TCP Throughput
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a MIME message. You may need a MIME compliant mail user agent.
--===axigen=3144668069037460751867952378953360403040=axigen===
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


Hi,

=20

I have noticed erratic (or at least not real reliable) throughput when usin=
g OpenVPN in proto tcp mode (as I have to - UDP is not available to me, hav=
ing to go through a TCP Proxy server). On my home network I just ran some t=
ests, using iperf to characterize connection bandwidth between the same two=
 PC's ... with and without OpenVPN. Here are the results ...

=20

1) Without OpenVPN - consistent performance, ~ 70 Mbps total throughput (on=
 a 100 Mb LAN).

bin/iperf.exe -c server.home -P 8 -i 1 -p 5001 -f m -t 10

------------------------------------------------------------

Client connecting to server.home, TCP port 5001

TCP window size: 0.01 MByte (default)

------------------------------------------------------------

[1908] local 192.168.2.109 port 1478 connected with 192.168.1.2 port 5001

[1888] local 192.168.2.109 port 1479 connected with 192.168.1.2 port 5001

[1872] local 192.168.2.109 port 1480 connected with 192.168.1.2 port 5001

[1792] local 192.168.2.109 port 1488 connected with 192.168.1.2 port 5001

[1840] local 192.168.2.109 port 1485 connected with 192.168.1.2 port 5001

[1808] local 192.168.2.109 port 1487 connected with 192.168.1.2 port 5001

[1856] local 192.168.2.109 port 1482 connected with 192.168.1.2 port 5001

[1824] local 192.168.2.109 port 1486 connected with 192.168.1.2 port 5001

[ ID] Interval Transfer Bandwidth

[1808] 0.0- 1.0 sec 0.91 MBytes 7.60 Mbits/sec

[1872] 0.0- 1.0 sec 0.91 MBytes 7.67 Mbits/sec

[1888] 0.0- 1.0 sec 0.94 MBytes 7.86 Mbits/sec

[1824] 0.0- 1.0 sec 0.91 MBytes 7.67 Mbits/sec

[1792] 0.0- 1.0 sec 0.98 MBytes 8.26 Mbits/sec

[1840] 0.0- 1.0 sec 0.92 MBytes 7.73 Mbits/sec

[1856] 0.0- 1.0 sec 0.91 MBytes 7.67 Mbits/sec

[1908] 0.0- 1.0 sec 0.94 MBytes 7.86 Mbits/sec

[SUM] 0.0- 1.0 sec 7.43 MBytes 62.3 Mbits/sec

[1888] 1.0- 2.0 sec 1.01 MBytes 8.45 Mbits/sec

[1872] 1.0- 2.0 sec 1.00 MBytes 8.39 Mbits/sec

[1856] 1.0- 2.0 sec 0.99 MBytes 8.32 Mbits/sec

[1808] 1.0- 2.0 sec 1.01 MBytes 8.45 Mbits/sec

[1908] 1.0- 2.0 sec 0.98 MBytes 8.26 Mbits/sec

[1792] 1.0- 2.0 sec 1.01 MBytes 8.45 Mbits/sec

[1824] 1.0- 2.0 sec 1.00 MBytes 8.39 Mbits/sec

[1840] 1.0- 2.0 sec 0.98 MBytes 8.19 Mbits/sec

[SUM] 1.0- 2.0 sec 7.98 MBytes 66.9 Mbits/sec

[1792] 2.0- 3.0 sec 0.95 MBytes 7.93 Mbits/sec

[1856] 2.0- 3.0 sec 0.97 MBytes 8.13 Mbits/sec

[ ID] Interval Transfer Bandwidth

[1888] 2.0- 3.0 sec 0.96 MBytes 8.06 Mbits/sec

[1872] 2.0- 3.0 sec 0.96 MBytes 8.06 Mbits/sec

[1908] 2.0- 3.0 sec 0.94 MBytes 7.86 Mbits/sec

[1840] 2.0- 3.0 sec 0.95 MBytes 7.93 Mbits/sec

[1808] 2.0- 3.0 sec 0.96 MBytes 8.06 Mbits/sec

[1824] 2.0- 3.0 sec 0.95 MBytes 8.00 Mbits/sec

[SUM] 2.0- 3.0 sec 7.63 MBytes 64.0 Mbits/sec

[1908] 3.0- 4.0 sec 0.97 MBytes 8.13 Mbits/sec

[1792] 3.0- 4.0 sec 0.95 MBytes 8.00 Mbits/sec

[1824] 3.0- 4.0 sec 0.95 MBytes 7.93 Mbits/sec

[1856] 3.0- 4.0 sec 0.95 MBytes 8.00 Mbits/sec

[1808] 3.0- 4.0 sec 0.94 MBytes 7.86 Mbits/sec

[1840] 3.0- 4.0 sec 0.96 MBytes 8.06 Mbits/sec

[1888] 3.0- 4.0 sec 0.94 MBytes 7.86 Mbits/sec

[1872] 3.0- 4.0 sec 0.95 MBytes 7.93 Mbits/sec

[SUM] 3.0- 4.0 sec 7.60 MBytes 63.8 Mbits/sec

[1792] 4.0- 5.0 sec 1.03 MBytes 8.65 Mbits/sec

[1808] 4.0- 5.0 sec 1.02 MBytes 8.52 Mbits/sec

[1908] 4.0- 5.0 sec 1.05 MBytes 8.78 Mbits/sec

[1824] 4.0- 5.0 sec 1.02 MBytes 8.52 Mbits/sec

[ ID] Interval Transfer Bandwidth

[1856] 4.0- 5.0 sec 1.02 MBytes 8.52 Mbits/sec

[1872] 4.0- 5.0 sec 0.99 MBytes 8.32 Mbits/sec

[1840] 4.0- 5.0 sec 1.02 MBytes 8.52 Mbits/sec

[1888] 4.0- 5.0 sec 1.02 MBytes 8.59 Mbits/sec

[SUM] 4.0- 5.0 sec 8.16 MBytes 68.4 Mbits/sec

[1824] 5.0- 6.0 sec 1.05 MBytes 8.78 Mbits/sec

[1792] 5.0- 6.0 sec 1.05 MBytes 8.78 Mbits/sec

[1908] 5.0- 6.0 sec 1.05 MBytes 8.78 Mbits/sec

[1840] 5.0- 6.0 sec 1.05 MBytes 8.78 Mbits/sec

[1872] 5.0- 6.0 sec 1.06 MBytes 8.91 Mbits/sec

[1888] 5.0- 6.0 sec 1.05 MBytes 8.78 Mbits/sec

[1808] 5.0- 6.0 sec 1.07 MBytes 8.98 Mbits/sec

[1856] 5.0- 6.0 sec 1.05 MBytes 8.85 Mbits/sec

[SUM] 5.0- 6.0 sec 8.42 MBytes 70.6 Mbits/sec

[1840] 6.0- 7.0 sec 0.97 MBytes 8.13 Mbits/sec

[1872] 6.0- 7.0 sec 0.99 MBytes 8.32 Mbits/sec

[1888] 6.0- 7.0 sec 1.02 MBytes 8.52 Mbits/sec

[1856] 6.0- 7.0 sec 1.00 MBytes 8.39 Mbits/sec

[1824] 6.0- 7.0 sec 1.01 MBytes 8.45 Mbits/sec

[1908] 6.0- 7.0 sec 0.99 MBytes 8.32 Mbits/sec

[ ID] Interval Transfer Bandwidth

[1792] 6.0- 7.0 sec 1.00 MBytes 8.39 Mbits/sec

[1808] 6.0- 7.0 sec 0.99 MBytes 8.32 Mbits/sec

[SUM] 6.0- 7.0 sec 7.97 MBytes 66.8 Mbits/sec

[1792] 7.0- 8.0 sec 1.04 MBytes 8.72 Mbits/sec

[1908] 7.0- 8.0 sec 1.02 MBytes 8.59 Mbits/sec

[1856] 7.0- 8.0 sec 1.04 MBytes 8.72 Mbits/sec

[1808] 7.0- 8.0 sec 1.02 MBytes 8.59 Mbits/sec

[1872] 7.0- 8.0 sec 1.02 MBytes 8.59 Mbits/sec

[1888] 7.0- 8.0 sec 1.04 MBytes 8.72 Mbits/sec

[1840] 7.0- 8.0 sec 1.02 MBytes 8.59 Mbits/sec

[1824] 7.0- 8.0 sec 1.07 MBytes 8.98 Mbits/sec

[SUM] 7.0- 8.0 sec 8.28 MBytes 69.5 Mbits/sec

[1792] 8.0- 9.0 sec 1.05 MBytes 8.78 Mbits/sec

[1856] 8.0- 9.0 sec 1.05 MBytes 8.85 Mbits/sec

[1824] 8.0- 9.0 sec 1.05 MBytes 8.85 Mbits/sec

[1888] 8.0- 9.0 sec 1.05 MBytes 8.85 Mbits/sec

[1908] 8.0- 9.0 sec 1.05 MBytes 8.85 Mbits/sec

[1872] 8.0- 9.0 sec 1.05 MBytes 8.85 Mbits/sec

[1808] 8.0- 9.0 sec 1.06 MBytes 8.91 Mbits/sec

[1840] 8.0- 9.0 sec 1.02 MBytes 8.59 Mbits/sec

[ ID] Interval Transfer Bandwidth

[SUM] 8.0- 9.0 sec 8.41 MBytes 70.5 Mbits/sec

[1908] 9.0-10.0 sec 0.98 MBytes 8.26 Mbits/sec

[1856] 9.0-10.0 sec 0.98 MBytes 8.26 Mbits/sec

[1888] 9.0-10.0 sec 1.00 MBytes 8.39 Mbits/sec

[1872] 9.0-10.0 sec 0.98 MBytes 8.26 Mbits/sec

[1840] 9.0-10.0 sec 0.97 MBytes 8.13 Mbits/sec

[1824] 9.0-10.0 sec 1.01 MBytes 8.45 Mbits/sec

[1808] 9.0-10.0 sec 0.99 MBytes 8.32 Mbits/sec

[1792] 9.0-10.0 sec 1.01 MBytes 8.45 Mbits/sec

[SUM] 9.0-10.0 sec 7.93 MBytes 66.5 Mbits/sec

[1856] 0.0-10.0 sec 9.98 MBytes 8.36 Mbits/sec

[1908] 0.0-10.0 sec 9.98 MBytes 8.36 Mbits/sec

[1888] 0.0-10.0 sec 10.0 MBytes 8.40 Mbits/sec

[1872] 0.0-10.0 sec 9.94 MBytes 8.32 Mbits/sec

[1840] 0.0-10.0 sec 9.86 MBytes 8.26 Mbits/sec

[1808] 0.0-10.0 sec 9.98 MBytes 8.36 Mbits/sec

[1824] 0.0-10.0 sec 10.0 MBytes 8.40 Mbits/sec

[1792] 0.0-10.0 sec 10.1 MBytes 8.43 Mbits/sec

[SUM] 0.0-10.0 sec 79.9 MBytes 66.9 Mbits/sec

Done.

=20

2) With OpenVPN - very consistent performance, sometimes fine, other times =
very poor. ~ 70 Mbps total throughput (on a 100 Mb LAN), but bounces around=
 a lot.

bin/iperf.exe -c server -P 8 -i 1 -p 5001 -f m -t 10

------------------------------------------------------------

Client connecting to server, TCP port 5001

TCP window size: 0.01 MByte (default)

------------------------------------------------------------

[1856] local 192.168.32.2 port 1744 connected with 192.168.32.1 port 5001

[1824] local 192.168.32.2 port 1746 connected with 192.168.32.1 port 5001

[1888] local 192.168.32.2 port 1741 connected with 192.168.32.1 port 5001

[1908] local 192.168.32.2 port 1739 connected with 192.168.32.1 port 5001

[1840] local 192.168.32.2 port 1745 connected with 192.168.32.1 port 5001

[1808] local 192.168.32.2 port 1747 connected with 192.168.32.1 port 5001

[1872] local 192.168.32.2 port 1742 connected with 192.168.32.1 port 5001

[1792] local 192.168.32.2 port 1748 connected with 192.168.32.1 port 5001

[ ID] Interval Transfer Bandwidth

[1872] 0.0- 1.0 sec 1.61 MBytes 13.5 Mbits/sec

[1856] 0.0- 1.0 sec 1.64 MBytes 13.8 Mbits/sec

[1888] 0.0- 1.0 sec 1.22 MBytes 10.2 Mbits/sec

[1824] 0.0- 1.0 sec 1.48 MBytes 12.5 Mbits/sec

[1840] 0.0- 1.0 sec 0.62 MBytes 5.18 Mbits/sec

[1792] 0.0- 1.0 sec 0.91 MBytes 7.67 Mbits/sec

[1808] 0.0- 1.0 sec 1.49 MBytes 12.5 Mbits/sec

[1908] 0.0- 1.0 sec 0.18 MBytes 1.51 Mbits/sec

[SUM] 0.0- 1.0 sec 9.16 MBytes 76.8 Mbits/sec

[1856] 1.0- 2.0 sec 1.89 MBytes 15.9 Mbits/sec

[1872] 1.0- 2.0 sec 1.84 MBytes 15.5 Mbits/sec

[1792] 1.0- 2.0 sec 1.21 MBytes 10.2 Mbits/sec

[1908] 1.0- 2.0 sec 0.05 MBytes 0.46 Mbits/sec

[1888] 1.0- 2.0 sec 1.20 MBytes 10.0 Mbits/sec

[1840] 1.0- 2.0 sec 1.90 MBytes 15.9 Mbits/sec

[1808] 1.0- 2.0 sec 0.10 MBytes 0.85 Mbits/sec

[1824] 1.0- 2.0 sec 1.45 MBytes 12.2 Mbits/sec

[SUM] 1.0- 2.0 sec 9.65 MBytes 80.9 Mbits/sec

[1792] 2.0- 3.0 sec 1.40 MBytes 11.7 Mbits/sec

[1856] 2.0- 3.0 sec 1.94 MBytes 16.3 Mbits/sec

[ ID] Interval Transfer Bandwidth

[1888] 2.0- 3.0 sec 2.03 MBytes 17.0 Mbits/sec

[1840] 2.0- 3.0 sec 1.45 MBytes 12.1 Mbits/sec

[1824] 2.0- 3.0 sec 1.84 MBytes 15.5 Mbits/sec

[1908] 2.0- 3.0 sec 0.61 MBytes 5.11 Mbits/sec

[1872] 2.0- 3.0 sec 0.16 MBytes 1.31 Mbits/sec

[1808] 2.0- 3.0 sec 0.87 MBytes 7.27 Mbits/sec

[SUM] 2.0- 3.0 sec 10.3 MBytes 86.3 Mbits/sec

[1888] 3.0- 4.0 sec 1.94 MBytes 16.3 Mbits/sec

[1908] 3.0- 4.0 sec 0.95 MBytes 8.00 Mbits/sec

[1872] 3.0- 4.0 sec 1.05 MBytes 8.85 Mbits/sec

[1808] 3.0- 4.0 sec 0.41 MBytes 3.47 Mbits/sec

[1840] 3.0- 4.0 sec 1.28 MBytes 10.7 Mbits/sec

[1824] 3.0- 4.0 sec 1.47 MBytes 12.3 Mbits/sec

[1792] 3.0- 4.0 sec 1.55 MBytes 13.0 Mbits/sec

[1856] 3.0- 4.0 sec 1.53 MBytes 12.8 Mbits/sec

[SUM] 3.0- 4.0 sec 10.2 MBytes 85.5 Mbits/sec

[1792] 4.0- 5.0 sec 0.45 MBytes 3.80 Mbits/sec

[1824] 4.0- 5.0 sec 0.56 MBytes 4.72 Mbits/sec

[1840] 4.0- 5.0 sec 1.94 MBytes 16.3 Mbits/sec

[1808] 4.0- 5.0 sec 1.95 MBytes 16.4 Mbits/sec

[ ID] Interval Transfer Bandwidth

[1888] 4.0- 5.0 sec 1.78 MBytes 14.9 Mbits/sec

[1856] 4.0- 5.0 sec 0.34 MBytes 2.88 Mbits/sec

[1908] 4.0- 5.0 sec 1.53 MBytes 12.8 Mbits/sec

[1872] 4.0- 5.0 sec 1.45 MBytes 12.2 Mbits/sec

[SUM] 4.0- 5.0 sec 10.0 MBytes 84.0 Mbits/sec

[1808] 5.0- 6.0 sec 2.13 MBytes 17.8 Mbits/sec

[1856] 5.0- 6.0 sec 1.98 MBytes 16.6 Mbits/sec

[1840] 5.0- 6.0 sec 2.09 MBytes 17.5 Mbits/sec

[1824] 5.0- 6.0 sec 0.85 MBytes 7.14 Mbits/sec

[1888] 5.0- 6.0 sec 1.13 MBytes 9.50 Mbits/sec

[1908] 5.0- 6.0 sec 1.30 MBytes 10.9 Mbits/sec

[1872] 5.0- 6.0 sec 0.49 MBytes 4.13 Mbits/sec

[1792] 5.0- 6.0 sec 1.16 MBytes 9.76 Mbits/sec

[SUM] 5.0- 6.0 sec 11.1 MBytes 93.3 Mbits/sec

[1888] 6.0- 7.0 sec 1.85 MBytes 15.5 Mbits/sec

[1840] 6.0- 7.0 sec 1.95 MBytes 16.4 Mbits/sec

[1856] 6.0- 7.0 sec 1.14 MBytes 9.57 Mbits/sec

[1908] 6.0- 7.0 sec 1.09 MBytes 9.18 Mbits/sec

[1808] 6.0- 7.0 sec 1.17 MBytes 9.83 Mbits/sec

[1824] 6.0- 7.0 sec 1.52 MBytes 12.7 Mbits/sec

[ ID] Interval Transfer Bandwidth

[1792] 6.0- 7.0 sec 0.83 MBytes 6.95 Mbits/sec

[1872] 6.0- 7.0 sec 0.84 MBytes 7.01 Mbits/sec

[SUM] 6.0- 7.0 sec 10.4 MBytes 87.2 Mbits/sec

[1872] 7.0- 8.0 sec 1.41 MBytes 11.8 Mbits/sec

[1888] 7.0- 8.0 sec 1.14 MBytes 9.57 Mbits/sec

[1856] 7.0- 8.0 sec 1.76 MBytes 14.7 Mbits/sec

[1840] 7.0- 8.0 sec 1.09 MBytes 9.18 Mbits/sec

[1792] 7.0- 8.0 sec 1.19 MBytes 9.96 Mbits/sec

[1824] 7.0- 8.0 sec 0.70 MBytes 5.90 Mbits/sec

[1808] 7.0- 8.0 sec 1.76 MBytes 14.7 Mbits/sec

[1908] 7.0- 8.0 sec 1.30 MBytes 10.9 Mbits/sec

[SUM] 7.0- 8.0 sec 10.3 MBytes 86.8 Mbits/sec

[1840] 8.0- 9.0 sec 1.38 MBytes 11.6 Mbits/sec

[1808] 8.0- 9.0 sec 1.19 MBytes 9.96 Mbits/sec

[1824] 8.0- 9.0 sec 1.36 MBytes 11.4 Mbits/sec

[1908] 8.0- 9.0 sec 0.30 MBytes 2.56 Mbits/sec

[1856] 8.0- 9.0 sec 0.55 MBytes 4.65 Mbits/sec

[1888] 8.0- 9.0 sec 1.49 MBytes 12.5 Mbits/sec

[1872] 8.0- 9.0 sec 1.15 MBytes 9.63 Mbits/sec

[1792] 8.0- 9.0 sec 0.87 MBytes 7.27 Mbits/sec

[ ID] Interval Transfer Bandwidth

[SUM] 8.0- 9.0 sec 8.30 MBytes 69.6 Mbits/sec

[1792] 9.0-10.0 sec 1.56 MBytes 13.1 Mbits/sec

[1856] 9.0-10.0 sec 0.74 MBytes 6.23 Mbits/sec

[1808] 9.0-10.0 sec 1.91 MBytes 16.0 Mbits/sec

[1824] 9.0-10.0 sec 2.05 MBytes 17.2 Mbits/sec

[1888] 9.0-10.0 sec 0.90 MBytes 7.54 Mbits/sec

[1840] 9.0-10.0 sec 1.52 MBytes 12.7 Mbits/sec

[1908] 9.0-10.0 sec 1.39 MBytes 11.7 Mbits/sec

[1872] 9.0-10.0 sec 0.34 MBytes 2.82 Mbits/sec

[SUM] 9.0-10.0 sec 10.4 MBytes 87.3 Mbits/sec

[1792] 0.0-10.0 sec 11.1 MBytes 9.32 Mbits/sec

[1856] 0.0-10.0 sec 13.5 MBytes 11.3 Mbits/sec

[1808] 0.0-10.0 sec 13.0 MBytes 10.9 Mbits/sec

[1824] 0.0-10.0 sec 13.3 MBytes 11.1 Mbits/sec

[1888] 0.0-10.0 sec 14.7 MBytes 12.3 Mbits/sec

[1840] 0.0-10.0 sec 15.2 MBytes 12.7 Mbits/sec

[1908] 0.0-10.0 sec 8.72 MBytes 7.28 Mbits/sec

[1872] 0.0-10.0 sec 10.3 MBytes 8.64 Mbits/sec

[SUM] 0.0-10.0 sec 99.9 MBytes 83.4 Mbits/sec

Done.

=E3=80=80

=20

I have similar results for a single connection running - with OpenVPN the t=
hroughput is very erratic - and often extremely slow.

=20

Any suggestions?

=20

Thanks!=E3=80=80

=20

=20

--===axigen=3144668069037460751867952378953360403040=axigen===
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html><head><style id=3D"axi-htmleditor-style" type=3D"text/css">p { margin=
: 0px; }</style></head><body style=3D"font-size: 10pt; font-family: Arial; =
background-image: none; background-repeat: repeat; background-attachment: f=
ixed;"><P><BR>Hi,</P>
<P>&nbsp;</P>
<P>I have noticed erratic (or at least not real reliable) throughput when u=
sing OpenVPN in proto tcp mode (as I have to - UDP is not available to me, =
having to go through a TCP Proxy server). On my home network I just ran som=
e tests, using iperf to characterize connection bandwidth between the same =
two PC's ... with and without OpenVPN. Here are the results ...</P>
<P>&nbsp;</P>
<P>1) Without OpenVPN - consistent performance, ~ 70 Mbps total throughput =
(on a 100 Mb LAN).</P><SPAN lang=3DEN>
<P>bin/iperf.exe -c server.home -P 8 -i 1 -p 5001 -f m -t 10</P>
<P>------------------------------------------------------------</P>
<P>Client connecting to server.home, TCP port 5001</P>
<P>TCP window size: 0.01 MByte (default)</P>
<P>------------------------------------------------------------</P>
<P>[1908] local 192.168.2.109 port 1478 connected with 192.168.1.2 port 500=
1</P>
<P>[1888] local 192.168.2.109 port 1479 connected with 192.168.1.2 port 500=
1</P>
<P>[1872] local 192.168.2.109 port 1480 connected with 192.168.1.2 port 500=
1</P>
<P>[1792] local 192.168.2.109 port 1488 connected with 192.168.1.2 port 500=
1</P>
<P>[1840] local 192.168.2.109 port 1485 connected with 192.168.1.2 port 500=
1</P>
<P>[1808] local 192.168.2.109 port 1487 connected with 192.168.1.2 port 500=
1</P>
<P>[1856] local 192.168.2.109 port 1482 connected with 192.168.1.2 port 500=
1</P>
<P>[1824] local 192.168.2.109 port 1486 connected with 192.168.1.2 port 500=
1</P>
<P>[ ID] Interval Transfer Bandwidth</P>
<P>[1808] 0.0- 1.0 sec 0.91 MBytes 7.60 Mbits/sec</P>
<P>[1872] 0.0- 1.0 sec 0.91 MBytes 7.67 Mbits/sec</P>
<P>[1888] 0.0- 1.0 sec 0.94 MBytes 7.86 Mbits/sec</P>
<P>[1824] 0.0- 1.0 sec 0.91 MBytes 7.67 Mbits/sec</P>
<P>[1792] 0.0- 1.0 sec 0.98 MBytes 8.26 Mbits/sec</P>
<P>[1840] 0.0- 1.0 sec 0.92 MBytes 7.73 Mbits/sec</P>
<P>[1856] 0.0- 1.0 sec 0.91 MBytes 7.67 Mbits/sec</P>
<P>[1908] 0.0- 1.0 sec 0.94 MBytes 7.86 Mbits/sec</P>
<P>[SUM] 0.0- 1.0 sec 7.43 MBytes 62.3 Mbits/sec</P>
<P>[1888] 1.0- 2.0 sec 1.01 MBytes 8.45 Mbits/sec</P>
<P>[1872] 1.0- 2.0 sec 1.00 MBytes 8.39 Mbits/sec</P>
<P>[1856] 1.0- 2.0 sec 0.99 MBytes 8.32 Mbits/sec</P>
<P>[1808] 1.0- 2.0 sec 1.01 MBytes 8.45 Mbits/sec</P>
<P>[1908] 1.0- 2.0 sec 0.98 MBytes 8.26 Mbits/sec</P>
<P>[1792] 1.0- 2.0 sec 1.01 MBytes 8.45 Mbits/sec</P>
<P>[1824] 1.0- 2.0 sec 1.00 MBytes 8.39 Mbits/sec</P>
<P>[1840] 1.0- 2.0 sec 0.98 MBytes 8.19 Mbits/sec</P>
<P>[SUM] 1.0- 2.0 sec 7.98 MBytes 66.9 Mbits/sec</P>
<P>[1792] 2.0- 3.0 sec 0.95 MBytes 7.93 Mbits/sec</P>
<P>[1856] 2.0- 3.0 sec 0.97 MBytes 8.13 Mbits/sec</P>
<P>[ ID] Interval Transfer Bandwidth</P>
<P>[1888] 2.0- 3.0 sec 0.96 MBytes 8.06 Mbits/sec</P>
<P>[1872] 2.0- 3.0 sec 0.96 MBytes 8.06 Mbits/sec</P>
<P>[1908] 2.0- 3.0 sec 0.94 MBytes 7.86 Mbits/sec</P>
<P>[1840] 2.0- 3.0 sec 0.95 MBytes 7.93 Mbits/sec</P>
<P>[1808] 2.0- 3.0 sec 0.96 MBytes 8.06 Mbits/sec</P>
<P>[1824] 2.0- 3.0 sec 0.95 MBytes 8.00 Mbits/sec</P>
<P>[SUM] 2.0- 3.0 sec 7.63 MBytes 64.0 Mbits/sec</P>
<P>[1908] 3.0- 4.0 sec 0.97 MBytes 8.13 Mbits/sec</P>
<P>[1792] 3.0- 4.0 sec 0.95 MBytes 8.00 Mbits/sec</P>
<P>[1824] 3.0- 4.0 sec 0.95 MBytes 7.93 Mbits/sec</P>
<P>[1856] 3.0- 4.0 sec 0.95 MBytes 8.00 Mbits/sec</P>
<P>[1808] 3.0- 4.0 sec 0.94 MBytes 7.86 Mbits/sec</P>
<P>[1840] 3.0- 4.0 sec 0.96 MBytes 8.06 Mbits/sec</P>
<P>[1888] 3.0- 4.0 sec 0.94 MBytes 7.86 Mbits/sec</P>
<P>[1872] 3.0- 4.0 sec 0.95 MBytes 7.93 Mbits/sec</P>
<P>[SUM] 3.0- 4.0 sec 7.60 MBytes 63.8 Mbits/sec</P>
<P>[1792] 4.0- 5.0 sec 1.03 MBytes 8.65 Mbits/sec</P>
<P>[1808] 4.0- 5.0 sec 1.02 MBytes 8.52 Mbits/sec</P>
<P>[1908] 4.0- 5.0 sec 1.05 MBytes 8.78 Mbits/sec</P>
<P>[1824] 4.0- 5.0 sec 1.02 MBytes 8.52 Mbits/sec</P>
<P>[ ID] Interval Transfer Bandwidth</P>
<P>[1856] 4.0- 5.0 sec 1.02 MBytes 8.52 Mbits/sec</P>
<P>[1872] 4.0- 5.0 sec 0.99 MBytes 8.32 Mbits/sec</P>
<P>[1840] 4.0- 5.0 sec 1.02 MBytes 8.52 Mbits/sec</P>
<P>[1888] 4.0- 5.0 sec 1.02 MBytes 8.59 Mbits/sec</P>
<P>[SUM] 4.0- 5.0 sec 8.16 MBytes 68.4 Mbits/sec</P>
<P>[1824] 5.0- 6.0 sec 1.05 MBytes 8.78 Mbits/sec</P>
<P>[1792] 5.0- 6.0 sec 1.05 MBytes 8.78 Mbits/sec</P>
<P>[1908] 5.0- 6.0 sec 1.05 MBytes 8.78 Mbits/sec</P>
<P>[1840] 5.0- 6.0 sec 1.05 MBytes 8.78 Mbits/sec</P>
<P>[1872] 5.0- 6.0 sec 1.06 MBytes 8.91 Mbits/sec</P>
<P>[1888] 5.0- 6.0 sec 1.05 MBytes 8.78 Mbits/sec</P>
<P>[1808] 5.0- 6.0 sec 1.07 MBytes 8.98 Mbits/sec</P>
<P>[1856] 5.0- 6.0 sec 1.05 MBytes 8.85 Mbits/sec</P>
<P>[SUM] 5.0- 6.0 sec 8.42 MBytes 70.6 Mbits/sec</P>
<P>[1840] 6.0- 7.0 sec 0.97 MBytes 8.13 Mbits/sec</P>
<P>[1872] 6.0- 7.0 sec 0.99 MBytes 8.32 Mbits/sec</P>
<P>[1888] 6.0- 7.0 sec 1.02 MBytes 8.52 Mbits/sec</P>
<P>[1856] 6.0- 7.0 sec 1.00 MBytes 8.39 Mbits/sec</P>
<P>[1824] 6.0- 7.0 sec 1.01 MBytes 8.45 Mbits/sec</P>
<P>[1908] 6.0- 7.0 sec 0.99 MBytes 8.32 Mbits/sec</P>
<P>[ ID] Interval Transfer Bandwidth</P>
<P>[1792] 6.0- 7.0 sec 1.00 MBytes 8.39 Mbits/sec</P>
<P>[1808] 6.0- 7.0 sec 0.99 MBytes 8.32 Mbits/sec</P>
<P>[SUM] 6.0- 7.0 sec 7.97 MBytes 66.8 Mbits/sec</P>
<P>[1792] 7.0- 8.0 sec 1.04 MBytes 8.72 Mbits/sec</P>
<P>[1908] 7.0- 8.0 sec 1.02 MBytes 8.59 Mbits/sec</P>
<P>[1856] 7.0- 8.0 sec 1.04 MBytes 8.72 Mbits/sec</P>
<P>[1808] 7.0- 8.0 sec 1.02 MBytes 8.59 Mbits/sec</P>
<P>[1872] 7.0- 8.0 sec 1.02 MBytes 8.59 Mbits/sec</P>
<P>[1888] 7.0- 8.0 sec 1.04 MBytes 8.72 Mbits/sec</P>
<P>[1840] 7.0- 8.0 sec 1.02 MBytes 8.59 Mbits/sec</P>
<P>[1824] 7.0- 8.0 sec 1.07 MBytes 8.98 Mbits/sec</P>
<P>[SUM] 7.0- 8.0 sec 8.28 MBytes 69.5 Mbits/sec</P>
<P>[1792] 8.0- 9.0 sec 1.05 MBytes 8.78 Mbits/sec</P>
<P>[1856] 8.0- 9.0 sec 1.05 MBytes 8.85 Mbits/sec</P>
<P>[1824] 8.0- 9.0 sec 1.05 MBytes 8.85 Mbits/sec</P>
<P>[1888] 8.0- 9.0 sec 1.05 MBytes 8.85 Mbits/sec</P>
<P>[1908] 8.0- 9.0 sec 1.05 MBytes 8.85 Mbits/sec</P>
<P>[1872] 8.0- 9.0 sec 1.05 MBytes 8.85 Mbits/sec</P>
<P>[1808] 8.0- 9.0 sec 1.06 MBytes 8.91 Mbits/sec</P>
<P>[1840] 8.0- 9.0 sec 1.02 MBytes 8.59 Mbits/sec</P>
<P>[ ID] Interval Transfer Bandwidth</P>
<P>[SUM] 8.0- 9.0 sec 8.41 MBytes 70.5 Mbits/sec</P>
<P>[1908] 9.0-10.0 sec 0.98 MBytes 8.26 Mbits/sec</P>
<P>[1856] 9.0-10.0 sec 0.98 MBytes 8.26 Mbits/sec</P>
<P>[1888] 9.0-10.0 sec 1.00 MBytes 8.39 Mbits/sec</P>
<P>[1872] 9.0-10.0 sec 0.98 MBytes 8.26 Mbits/sec</P>
<P>[1840] 9.0-10.0 sec 0.97 MBytes 8.13 Mbits/sec</P>
<P>[1824] 9.0-10.0 sec 1.01 MBytes 8.45 Mbits/sec</P>
<P>[1808] 9.0-10.0 sec 0.99 MBytes 8.32 Mbits/sec</P>
<P>[1792] 9.0-10.0 sec 1.01 MBytes 8.45 Mbits/sec</P>
<P>[SUM] 9.0-10.0 sec 7.93 MBytes 66.5 Mbits/sec</P>
<P>[1856] 0.0-10.0 sec 9.98 MBytes 8.36 Mbits/sec</P>
<P>[1908] 0.0-10.0 sec 9.98 MBytes 8.36 Mbits/sec</P>
<P>[1888] 0.0-10.0 sec 10.0 MBytes 8.40 Mbits/sec</P>
<P>[1872] 0.0-10.0 sec 9.94 MBytes 8.32 Mbits/sec</P>
<P>[1840] 0.0-10.0 sec 9.86 MBytes 8.26 Mbits/sec</P>
<P>[1808] 0.0-10.0 sec 9.98 MBytes 8.36 Mbits/sec</P>
<P>[1824] 0.0-10.0 sec 10.0 MBytes 8.40 Mbits/sec</P>
<P>[1792] 0.0-10.0 sec 10.1 MBytes 8.43 Mbits/sec</P>
<P>[SUM] 0.0-10.0 sec 79.9 MBytes 66.9 Mbits/sec</P>
<P>Done.</P>
<P>&nbsp;</P>
<P>2) With OpenVPN - very consistent performance, sometimes fine, other tim=
es very poor. ~ 70 Mbps total throughput (on a 100 Mb LAN), but bounces aro=
und a lot.</P><SPAN lang=3DEN>
<P>bin/iperf.exe -c server -P 8 -i 1 -p 5001 -f m -t 10</P>
<P>------------------------------------------------------------</P>
<P>Client connecting to server, TCP port 5001</P>
<P>TCP window size: 0.01 MByte (default)</P>
<P>------------------------------------------------------------</P>
<P>[1856] local 192.168.32.2 port 1744 connected with 192.168.32.1 port 500=
1</P>
<P>[1824] local 192.168.32.2 port 1746 connected with 192.168.32.1 port 500=
1</P>
<P>[1888] local 192.168.32.2 port 1741 connected with 192.168.32.1 port 500=
1</P>
<P>[1908] local 192.168.32.2 port 1739 connected with 192.168.32.1 port 500=
1</P>
<P>[1840] local 192.168.32.2 port 1745 connected with 192.168.32.1 port 500=
1</P>
<P>[1808] local 192.168.32.2 port 1747 connected with 192.168.32.1 port 500=
1</P>
<P>[1872] local 192.168.32.2 port 1742 connected with 192.168.32.1 port 500=
1</P>
<P>[1792] local 192.168.32.2 port 1748 connected with 192.168.32.1 port 500=
1</P>
<P>[ ID] Interval Transfer Bandwidth</P>
<P>[1872] 0.0- 1.0 sec 1.61 MBytes 13.5 Mbits/sec</P>
<P>[1856] 0.0- 1.0 sec 1.64 MBytes 13.8 Mbits/sec</P>
<P>[1888] 0.0- 1.0 sec 1.22 MBytes 10.2 Mbits/sec</P>
<P>[1824] 0.0- 1.0 sec 1.48 MBytes 12.5 Mbits/sec</P>
<P>[1840] 0.0- 1.0 sec 0.62 MBytes 5.18 Mbits/sec</P>
<P>[1792] 0.0- 1.0 sec 0.91 MBytes 7.67 Mbits/sec</P>
<P>[1808] 0.0- 1.0 sec 1.49 MBytes 12.5 Mbits/sec</P>
<P>[1908] 0.0- 1.0 sec 0.18 MBytes 1.51 Mbits/sec</P>
<P>[SUM] 0.0- 1.0 sec 9.16 MBytes 76.8 Mbits/sec</P>
<P>[1856] 1.0- 2.0 sec 1.89 MBytes 15.9 Mbits/sec</P>
<P>[1872] 1.0- 2.0 sec 1.84 MBytes 15.5 Mbits/sec</P>
<P>[1792] 1.0- 2.0 sec 1.21 MBytes 10.2 Mbits/sec</P>
<P>[1908] 1.0- 2.0 sec 0.05 MBytes 0.46 Mbits/sec</P>
<P>[1888] 1.0- 2.0 sec 1.20 MBytes 10.0 Mbits/sec</P>
<P>[1840] 1.0- 2.0 sec 1.90 MBytes 15.9 Mbits/sec</P>
<P>[1808] 1.0- 2.0 sec 0.10 MBytes 0.85 Mbits/sec</P>
<P>[1824] 1.0- 2.0 sec 1.45 MBytes 12.2 Mbits/sec</P>
<P>[SUM] 1.0- 2.0 sec 9.65 MBytes 80.9 Mbits/sec</P>
<P>[1792] 2.0- 3.0 sec 1.40 MBytes 11.7 Mbits/sec</P>
<P>[1856] 2.0- 3.0 sec 1.94 MBytes 16.3 Mbits/sec</P>
<P>[ ID] Interval Transfer Bandwidth</P>
<P>[1888] 2.0- 3.0 sec 2.03 MBytes 17.0 Mbits/sec</P>
<P>[1840] 2.0- 3.0 sec 1.45 MBytes 12.1 Mbits/sec</P>
<P>[1824] 2.0- 3.0 sec 1.84 MBytes 15.5 Mbits/sec</P>
<P>[1908] 2.0- 3.0 sec 0.61 MBytes 5.11 Mbits/sec</P>
<P>[1872] 2.0- 3.0 sec 0.16 MBytes 1.31 Mbits/sec</P>
<P>[1808] 2.0- 3.0 sec 0.87 MBytes 7.27 Mbits/sec</P>
<P>[SUM] 2.0- 3.0 sec 10.3 MBytes 86.3 Mbits/sec</P>
<P>[1888] 3.0- 4.0 sec 1.94 MBytes 16.3 Mbits/sec</P>
<P>[1908] 3.0- 4.0 sec 0.95 MBytes 8.00 Mbits/sec</P>
<P>[1872] 3.0- 4.0 sec 1.05 MBytes 8.85 Mbits/sec</P>
<P>[1808] 3.0- 4.0 sec 0.41 MBytes 3.47 Mbits/sec</P>
<P>[1840] 3.0- 4.0 sec 1.28 MBytes 10.7 Mbits/sec</P>
<P>[1824] 3.0- 4.0 sec 1.47 MBytes 12.3 Mbits/sec</P>
<P>[1792] 3.0- 4.0 sec 1.55 MBytes 13.0 Mbits/sec</P>
<P>[1856] 3.0- 4.0 sec 1.53 MBytes 12.8 Mbits/sec</P>
<P>[SUM] 3.0- 4.0 sec 10.2 MBytes 85.5 Mbits/sec</P>
<P>[1792] 4.0- 5.0 sec 0.45 MBytes 3.80 Mbits/sec</P>
<P>[1824] 4.0- 5.0 sec 0.56 MBytes 4.72 Mbits/sec</P>
<P>[1840] 4.0- 5.0 sec 1.94 MBytes 16.3 Mbits/sec</P>
<P>[1808] 4.0- 5.0 sec 1.95 MBytes 16.4 Mbits/sec</P>
<P>[ ID] Interval Transfer Bandwidth</P>
<P>[1888] 4.0- 5.0 sec 1.78 MBytes 14.9 Mbits/sec</P>
<P>[1856] 4.0- 5.0 sec 0.34 MBytes 2.88 Mbits/sec</P>
<P>[1908] 4.0- 5.0 sec 1.53 MBytes 12.8 Mbits/sec</P>
<P>[1872] 4.0- 5.0 sec 1.45 MBytes 12.2 Mbits/sec</P>
<P>[SUM] 4.0- 5.0 sec 10.0 MBytes 84.0 Mbits/sec</P>
<P>[1808] 5.0- 6.0 sec 2.13 MBytes 17.8 Mbits/sec</P>
<P>[1856] 5.0- 6.0 sec 1.98 MBytes 16.6 Mbits/sec</P>
<P>[1840] 5.0- 6.0 sec 2.09 MBytes 17.5 Mbits/sec</P>
<P>[1824] 5.0- 6.0 sec 0.85 MBytes 7.14 Mbits/sec</P>
<P>[1888] 5.0- 6.0 sec 1.13 MBytes 9.50 Mbits/sec</P>
<P>[1908] 5.0- 6.0 sec 1.30 MBytes 10.9 Mbits/sec</P>
<P>[1872] 5.0- 6.0 sec 0.49 MBytes 4.13 Mbits/sec</P>
<P>[1792] 5.0- 6.0 sec 1.16 MBytes 9.76 Mbits/sec</P>
<P>[SUM] 5.0- 6.0 sec 11.1 MBytes 93.3 Mbits/sec</P>
<P>[1888] 6.0- 7.0 sec 1.85 MBytes 15.5 Mbits/sec</P>
<P>[1840] 6.0- 7.0 sec 1.95 MBytes 16.4 Mbits/sec</P>
<P>[1856] 6.0- 7.0 sec 1.14 MBytes 9.57 Mbits/sec</P>
<P>[1908] 6.0- 7.0 sec 1.09 MBytes 9.18 Mbits/sec</P>
<P>[1808] 6.0- 7.0 sec 1.17 MBytes 9.83 Mbits/sec</P>
<P>[1824] 6.0- 7.0 sec 1.52 MBytes 12.7 Mbits/sec</P>
<P>[ ID] Interval Transfer Bandwidth</P>
<P>[1792] 6.0- 7.0 sec 0.83 MBytes 6.95 Mbits/sec</P>
<P>[1872] 6.0- 7.0 sec 0.84 MBytes 7.01 Mbits/sec</P>
<P>[SUM] 6.0- 7.0 sec 10.4 MBytes 87.2 Mbits/sec</P>
<P>[1872] 7.0- 8.0 sec 1.41 MBytes 11.8 Mbits/sec</P>
<P>[1888] 7.0- 8.0 sec 1.14 MBytes 9.57 Mbits/sec</P>
<P>[1856] 7.0- 8.0 sec 1.76 MBytes 14.7 Mbits/sec</P>
<P>[1840] 7.0- 8.0 sec 1.09 MBytes 9.18 Mbits/sec</P>
<P>[1792] 7.0- 8.0 sec 1.19 MBytes 9.96 Mbits/sec</P>
<P>[1824] 7.0- 8.0 sec 0.70 MBytes 5.90 Mbits/sec</P>
<P>[1808] 7.0- 8.0 sec 1.76 MBytes 14.7 Mbits/sec</P>
<P>[1908] 7.0- 8.0 sec 1.30 MBytes 10.9 Mbits/sec</P>
<P>[SUM] 7.0- 8.0 sec 10.3 MBytes 86.8 Mbits/sec</P>
<P>[1840] 8.0- 9.0 sec 1.38 MBytes 11.6 Mbits/sec</P>
<P>[1808] 8.0- 9.0 sec 1.19 MBytes 9.96 Mbits/sec</P>
<P>[1824] 8.0- 9.0 sec 1.36 MBytes 11.4 Mbits/sec</P>
<P>[1908] 8.0- 9.0 sec 0.30 MBytes 2.56 Mbits/sec</P>
<P>[1856] 8.0- 9.0 sec 0.55 MBytes 4.65 Mbits/sec</P>
<P>[1888] 8.0- 9.0 sec 1.49 MBytes 12.5 Mbits/sec</P>
<P>[1872] 8.0- 9.0 sec 1.15 MBytes 9.63 Mbits/sec</P>
<P>[1792] 8.0- 9.0 sec 0.87 MBytes 7.27 Mbits/sec</P>
<P>[ ID] Interval Transfer Bandwidth</P>
<P>[SUM] 8.0- 9.0 sec 8.30 MBytes 69.6 Mbits/sec</P>
<P>[1792] 9.0-10.0 sec 1.56 MBytes 13.1 Mbits/sec</P>
<P>[1856] 9.0-10.0 sec 0.74 MBytes 6.23 Mbits/sec</P>
<P>[1808] 9.0-10.0 sec 1.91 MBytes 16.0 Mbits/sec</P>
<P>[1824] 9.0-10.0 sec 2.05 MBytes 17.2 Mbits/sec</P>
<P>[1888] 9.0-10.0 sec 0.90 MBytes 7.54 Mbits/sec</P>
<P>[1840] 9.0-10.0 sec 1.52 MBytes 12.7 Mbits/sec</P>
<P>[1908] 9.0-10.0 sec 1.39 MBytes 11.7 Mbits/sec</P>
<P>[1872] 9.0-10.0 sec 0.34 MBytes 2.82 Mbits/sec</P>
<P>[SUM] 9.0-10.0 sec 10.4 MBytes 87.3 Mbits/sec</P>
<P>[1792] 0.0-10.0 sec 11.1 MBytes 9.32 Mbits/sec</P>
<P>[1856] 0.0-10.0 sec 13.5 MBytes 11.3 Mbits/sec</P>
<P>[1808] 0.0-10.0 sec 13.0 MBytes 10.9 Mbits/sec</P>
<P>[1824] 0.0-10.0 sec 13.3 MBytes 11.1 Mbits/sec</P>
<P>[1888] 0.0-10.0 sec 14.7 MBytes 12.3 Mbits/sec</P>
<P>[1840] 0.0-10.0 sec 15.2 MBytes 12.7 Mbits/sec</P>
<P>[1908] 0.0-10.0 sec 8.72 MBytes 7.28 Mbits/sec</P>
<P>[1872] 0.0-10.0 sec 10.3 MBytes 8.64 Mbits/sec</P>
<P>[SUM] 0.0-10.0 sec 99.9 MBytes 83.4 Mbits/sec</P>
<P>Done.</P>
<P>=E3=80=80</P></SPAN>
<P>&nbsp;</P>
<P>I have similar results for a single connection running - with OpenVPN th=
e throughput is very erratic - and often extremely slow.</P>
<P>&nbsp;</P>
<P>Any suggestions?</P>
<P>&nbsp;</P>
<P>Thanks!=E3=80=80</P>
<P>&nbsp;</P>
<P>&nbsp;</P></SPAN></body></html>=

--===axigen=3144668069037460751867952378953360403040=axigen===--


