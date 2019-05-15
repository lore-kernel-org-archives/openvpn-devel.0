MIME-Version: 1.0
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 15 May 2019 16:48:56 +0300
Message-ID: <CAGyAFMV=HvOYDRSB7eRpBDp-47wX2vie8JPgp48in1fH+eXn=A@...278...>
Content-Type: multipart/alternative; boundary="000000000000b6b1350588ed693e"
Subject: [Openvpn-devel] Wintun performance results
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: wireguard@...2500..., openvpn-devel@lists.sourceforge.net

--000000000000b6b1350588ed693e
Content-Type: text/plain; charset="UTF-8"

Hi guys,

I made openvpn3 (required changes will be incorporated into main branch at
some point) work with wintun and did performance testing in AWS.

Client:    c5.xlarge, Windows Server 2016, patched openvpn3 test client and
OpenVPN Connect 2.7.1.103 (uses tap-windows6, based on openvpn3).

Server:  c5.xlarge, Ubuntu 18.04, openvpn 2.4.4

Client and server instances are in the same VPC and placement group.

iPerf3 running on server:

> iperf3 -s -B 0.0.0.0 -V

iPerf3 running on client:

> iperf3 -c 10.8.0.1 -V (server VPN address)
> iperf3 -c 10.0.0.18 -V (server VPC address)

Results:

- no vpn

[ ID] Interval           Transfer     Bandwidth
[  4]   0.00-10.00  sec  8.67 GBytes  7.45 Gbits/sec                  sender
[  4]   0.00-10.00  sec  8.67 GBytes  7.45
Gbits/sec                  receiver
CPU Utilization: local/sender 61.4% (5.6%u/55.8%s), remote/receiver 33.9%
(1.7%u/32.2%s)

- tap-windows6

[ ID] Interval           Transfer     Bandwidth
[  4]   0.00-10.00  sec   404 MBytes   339 Mbits/sec                  sender
[  4]   0.00-10.00  sec   404 MBytes   339
Mbits/sec                  receiver
CPU Utilization: local/sender 4.6% (0.3%u/4.3%s), remote/receiver 21.4%
(2.2%u/19.2%s)

- wintun

[ ID] Interval           Transfer     Bandwidth
[  4]   0.00-10.00  sec   536 MBytes   449 Mbits/sec                  sender
[  4]   0.00-10.00  sec   536 MBytes   449
Mbits/sec                  receiver
CPU Utilization: local/sender 2.9% (0.1%u/2.8%s), remote/receiver 10.1%
(0.7%u/9.3%s)

As you see, wintun performs 30% better comparison to tap-windows6 and
incurs significantly less CPU usage.

-- 
-Lev

--000000000000b6b1350588ed693e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGkgZ3V5cyw8ZGl2Pjxicj48L2Rpdj48ZGl2PkkgbWFkZSBvcGVudnBu
MyAocmVxdWlyZWQgY2hhbmdlcyB3aWxsIGJlIGluY29ycG9yYXRlZCBpbnRvIG1haW4gYnJhbmNo
IGF0IHNvbWUgcG9pbnQpIHdvcmsgd2l0aCB3aW50dW4gYW5kIGRpZCBwZXJmb3JtYW5jZSB0ZXN0
aW5nIGluIEFXUy48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxkaXY+Q2xpZW50OsKgIMKgIGM1
LnhsYXJnZSwgV2luZG93cyBTZXJ2ZXIgMjAxNiwgcGF0Y2hlZCBvcGVudnBuMyB0ZXN0IGNsaWVu
dCBhbmQgT3BlblZQTiBDb25uZWN0IDIuNy4xLjEwMyAodXNlcyB0YXAtd2luZG93czYsIGJhc2Vk
IG9uIG9wZW52cG4zKS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlNlcnZlcjrCoCBjNS54bGFy
Z2UsIFVidW50dSAxOC4wNCwgb3BlbnZwbiAyLjQuNDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
Q2xpZW50IGFuZCBzZXJ2ZXIgaW5zdGFuY2VzIGFyZSBpbiB0aGUgc2FtZSBWUEMgYW5kIHBsYWNl
bWVudCBncm91cC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PmlQZXJmMyBydW5uaW5nIG9uIHNl
cnZlcjo8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PiZndDsgaXBlcmYzIC1zIC1CIDAuMC4wLjAg
LVY8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PmlQZXJmMyBydW5uaW5nIG9uIGNsaWVudDo8L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2PiZndDsgaXBlcmYzIC1jIDEwLjguMC4xIC1WIChzZXJ2ZXIg
VlBOIGFkZHJlc3MpPC9kaXY+PGRpdj4mZ3Q7IGlwZXJmMyAtYyAxMC4wLjAuMTggLVYgKHNlcnZl
ciBWUEMgYWRkcmVzcynCoMKgPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+UmVzdWx0czo8
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pi0gbm8gdnBuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRp
dj5bIElEXSBJbnRlcnZhbMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBUcmFuc2ZlcsKgwqDCoMKgwqBC
YW5kd2lkdGg8L2Rpdj48ZGl2PlvCoMKgNF3CoMKgwqAwLjAwLTEwLjAwwqDCoHNlY8KgwqA4LjY3
IEdCeXRlc8KgwqA3LjQ1IEdiaXRzL3NlY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHNlbmRlcjwvZGl2PjxkaXY+W8KgwqA0XcKgwqDCoDAuMDAtMTAuMDDCoMKgc2VjwqDCoDgu
NjcgR0J5dGVzwqDCoDcuNDUgR2JpdHMvc2VjwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcmVjZWl2ZXI8L2Rpdj48ZGl2PkNQVSBVdGlsaXphdGlvbjogbG9jYWwvc2VuZGVyIDYx
LjQlICg1LjYldS81NS44JXMpLCByZW1vdGUvcmVjZWl2ZXIgMzMuOSUgKDEuNyV1LzMyLjIlcyk8
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pi0gdGFwLXdpbmRvd3M2PC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj5bIElEXSBJbnRlcnZhbMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBUcmFuc2ZlcsKgwqDC
oMKgwqBCYW5kd2lkdGg8L2Rpdj48ZGl2PlvCoMKgNF3CoMKgwqAwLjAwLTEwLjAwwqDCoHNlY8Kg
wqDCoDQwNCBNQnl0ZXPCoMKgwqAzMzkgTWJpdHMvc2VjwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgc2VuZGVyPC9kaXY+PGRpdj5bwqDCoDRdwqDCoMKgMC4wMC0xMC4wMMKgwqBz
ZWPCoMKgwqA0MDQgTUJ5dGVzwqDCoMKgMzM5IE1iaXRzL3NlY8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJlY2VpdmVyPC9kaXY+PGRpdj5DUFUgVXRpbGl6YXRpb246IGxvY2Fs
L3NlbmRlciA0LjYlICgwLjMldS80LjMlcyksIHJlbW90ZS9yZWNlaXZlciAyMS40JSAoMi4yJXUv
MTkuMiVzKTwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+LSB3aW50dW48L2Rpdj48ZGl2Pjxicj48
L2Rpdj48ZGl2PlsgSURdIEludGVydmFswqDCoMKgwqDCoMKgwqDCoMKgwqDCoFRyYW5zZmVywqDC
oMKgwqDCoEJhbmR3aWR0aDwvZGl2PjxkaXY+W8KgwqA0XcKgwqDCoDAuMDAtMTAuMDDCoMKgc2Vj
wqDCoMKgNTM2IE1CeXRlc8KgwqDCoDQ0OSBNYml0cy9zZWPCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBzZW5kZXI8L2Rpdj48ZGl2PlvCoMKgNF3CoMKgwqAwLjAwLTEwLjAwwqDC
oHNlY8KgwqDCoDUzNiBNQnl0ZXPCoMKgwqA0NDkgTWJpdHMvc2VjwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmVjZWl2ZXI8L2Rpdj48ZGl2PkNQVSBVdGlsaXphdGlvbjogbG9j
YWwvc2VuZGVyIDIuOSUgKDAuMSV1LzIuOCVzKSwgcmVtb3RlL3JlY2VpdmVyIDEwLjElICgwLjcl
dS85LjMlcyk8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkFzIHlvdSBzZWUsIHdpbnR1biBwZXJm
b3JtcyAzMCUgYmV0dGVyIGNvbXBhcmlzb24gdG8gdGFwLXdpbmRvd3M2IGFuZCBpbmN1cnMgc2ln
bmlmaWNhbnRseSBsZXNzIENQVSB1c2FnZS48L2Rpdj48ZGl2Pjxicj48L2Rpdj4tLSA8YnI+PGRp
diBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX3NpZ25hdHVyZSIgZGF0YS1zbWFydG1haWw9ImdtYWls
X3NpZ25hdHVyZSI+LUxldjwvZGl2PjwvZGl2PjwvZGl2Pg0K

--000000000000b6b1350588ed693e--

