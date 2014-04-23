Message-ID: <5357D612.7020402@...1901...>
Date: Wed, 23 Apr 2014 11:02:42 -0400
From: Timothe Litt <litt@...1901...>
MIME-Version: 1.0
References: <53572C4E.7010701@...1901...> <20140423081058.GJ16637@...1296...>
In-Reply-To: <20140423081058.GJ16637@...1296...>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
	micalg=sha1; boundary="------------ms060600060609090709000600"
Subject: Re: [Openvpn-devel] Progress on Version negotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is a cryptographically signed message in MIME format.

--------------ms060600060609090709000600
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable

> This is quite cool, thank you.
You're welcome.  I don't like unsolved mysteries, and since I have a=20
solid reproducer, thought I should do what I can.

Some more.  I looked into building on Windows, but the doc says one=20
needs commercial tools; I'm not going to buy them for this.

However, I got verb 9 traces from the client and server side of a failure.

They're a bit too large to post here, but I can provide the full traces=20
off-list.

I haven't backtracked to understanding what is being sent. Perhaps one=20
of you has the magic decoder for the data in the messages...

Here's a summary of what I see that seems interesting:

Server:
SSL state: Read client hello B
                   Write server hello A
                   Write certificate a
                   Write key exchange A
                   Write certificate request A
                   Flush data

This is the server sending the data that triggers the error, starting=20
with the preceding read (that presumably triggers it):

Wed Apr 23 09:26:25 2014 us=3D505743 GET INST BY REAL:=20
192.168.148.191:1194 [succeeded]
Wed Apr 23 09:26:25 2014 us=3D507179 192.168.148.191:1194 UDP READ [50]=20
from [AF_INET]192.168.148.191:1194: P_ACK_V1 kid=3D0 sid=3D87209bbf d7d12ae=
b=20
tls_hmac=3D03a350ad c3c8bd68 06aacaa0 148a74fd b7731036 pid=3D[ #38 / time =
=3D=20
(1398259583) Wed Apr 23 09:26:23 2014 ] [ 30 sid=3Dadda013b a627c847 ]
Wed Apr 23 09:26:25 2014 us=3D508665 192.168.148.191:1194 TLS: control=20
channel, op=3DP_ACK_V1, IP=3D[AF_INET]192.168.148.191:1194
Wed Apr 23 09:26:25 2014 us=3D510704 192.168.148.191:1194 TLS: initial=20
packet test, i=3D0 state=3DS_START, mysid=3D95747581 daf31aa7,=20
rec-sid=3D87209bbf d7d12aeb, rec-ip=3D[AF_INET]192.168.148.191:1194,=20
stored-sid=3D65fbeaf3 0672d359, stored-ip=3D[AF_INET]192.168.148.191:1194
Wed Apr 23 09:26:25 2014 us=3D511162 192.168.148.191:1194 TLS: initial=20
packet test, i=3D1 state=3DS_START, mysid=3Dadda013b a627c847,=20
rec-sid=3D87209bbf d7d12aeb, rec-ip=3D[AF_INET]192.168.148.191:1194,=20
stored-sid=3D87209bbf d7d12aeb, stored-ip=3D[AF_INET]192.168.148.191:1194
Wed Apr 23 09:26:25 2014 us=3D512181 192.168.148.191:1194 TLS: found=20
match, session[1], sid=3D87209bbf d7d12aeb
Wed Apr 23 09:26:25 2014 us=3D513617 192.168.148.191:1194 PID_TEST [0]=20
[TLS_AUTH-0] [0000000001111111111111111122222222222] 1398259583:37=20
1398259583:38 t=3D1398259585[0] r=3D[-2,64,15,0,1] sl=3D[27,37,64,272]
Wed Apr 23 09:26:25 2014 us=3D514591 192.168.148.191:1194 TLS: received=20
control channel packet s#=3D1 sid=3D87209bbf d7d12aeb
Wed Apr 23 09:26:25 2014 us=3D515784 192.168.148.191:1194 ACK received for=
=20
pid 30, deleting from send buffer
Wed Apr 23 09:26:25 2014 us=3D516298 192.168.148.191:1194 TLS:=20
tls_multi_process: i=3D0 state=3DS_START, mysid=3D95747581 daf31aa7,=20
stored-sid=3D65fbeaf3 0672d359, stored-ip=3D[AF_INET]192.168.148.191:1194
Wed Apr 23 09:26:25 2014 us=3D517260 192.168.148.191:1194 TLS:=20
tls_process: chg=3D0 ks=3DS_START lame=3DS_UNDEF to_link->len=3D0 wakeup=3D=
604800
Wed Apr 23 09:26:25 2014 us=3D518489 192.168.148.191:1194 ACK=20
reliable_can_send active=3D1 current=3D0 : [35] 34
Wed Apr 23 09:26:25 2014 us=3D518920 192.168.148.191:1194 ACK=20
reliable_send_timeout 1 [35] 34
Wed Apr 23 09:26:25 2014 us=3D519836 192.168.148.191:1194 TLS:=20
tls_process: timeout set to 1
Wed Apr 23 09:26:25 2014 us=3D521129 192.168.148.191:1194 TLS:=20
tls_multi_process: i=3D1 state=3DS_START, mysid=3Dadda013b a627c847,=20
stored-sid=3D87209bbf d7d12aeb, stored-ip=3D[AF_INET]192.168.148.191:1194
Wed Apr 23 09:26:25 2014 us=3D522055 192.168.148.191:1194 TLS:=20
tls_process: chg=3D0 ks=3DS_START lame=3DS_UNDEF to_link->len=3D0 wakeup=3D1
Wed Apr 23 09:26:25 2014 us=3D523328 192.168.148.191:1194 ACK=20
reliable_can_send active=3D3 current=3D0 : [34] 33 31 32
Wed Apr 23 09:26:25 2014 us=3D523743 192.168.148.191:1194 BIO read=20
tls_read_ciphertext 95 bytes
Wed Apr 23 09:26:25 2014 us=3D524649 192.168.148.191:1194 ACK mark active=20
outgoing ID 34
Wed Apr 23 09:26:25 2014 us=3D525799 192.168.148.191:1194 Outgoing=20
Ciphertext -> Reliable
Wed Apr 23 09:26:25 2014 us=3D526116 192.168.148.191:1194 TLS:=20
tls_process: chg=3D1 ks=3DS_START lame=3DS_UNDEF to_link->len=3D0 wakeup=3D1
Wed Apr 23 09:26:25 2014 us=3D527049 192.168.148.191:1194 ACK=20
reliable_can_send active=3D4 current=3D1 : [35] 33 34 31 32
Wed Apr 23 09:26:25 2014 us=3D528217 192.168.148.191:1194 ACK=20
reliable_send ID 34 (size=3D99 to=3D5)
Wed Apr 23 09:26:25 2014 us=3D528542 192.168.148.191:1194 Reliable -> TCP/U=
DP
Wed Apr 23 09:26:25 2014 us=3D529436 192.168.148.191:1194 ACK=20
reliable_send_timeout 2 [35] 33 34 31 32
Wed Apr 23 09:26:25 2014 us=3D530612 192.168.148.191:1194 TLS:=20
tls_process: timeout set to 1
Wed Apr 23 09:26:25 2014 us=3D531584 192.168.148.191:1194 TLS:=20
tls_multi_process: i=3D2 state=3DS_UNDEF, mysid=3D00000000 00000000,=20
stored-sid=3D00000000 00000000, stored-ip=3D[AF_UNSPEC]
Wed Apr 23 09:26:25 2014 us=3D532955 PO_CTL rwflags=3D0x0002 ev=3D5 arg=3D0=
x0009377c
Wed Apr 23 09:26:25 2014 us=3D533939 PO_CTL rwflags=3D0x0000 ev=3D4 arg=3D0=
x000936f0
Wed Apr 23 09:26:25 2014 us=3D535162 PO_CTL rwflags=3D0x0001 ev=3D3 arg=3D0=
x000936f4
Wed Apr 23 09:26:25 2014 us=3D536073 I/O WAIT Tr|Tw|Sr|SW [1/14229]
Wed Apr 23 09:26:25 2014 us=3D537294 PO_WAIT[0,0] fd=3D5 rev=3D0x00000004=20
rwflags=3D0x0002 arg=3D0x0009377c
Wed Apr 23 09:26:25 2014 us=3D538184  event_wait returned 1
Wed Apr 23 09:26:25 2014 us=3D539337 I/O WAIT status=3D0x0002
Wed Apr 23 09:26:25 2014 us=3D540187 192.168.148.191:1194 UDP WRITE [137]=20
to [AF_INET]192.168.148.191:1194: P_CONTROL_V1 kid=3D0 sid=3Dadda013b=20
a627c847 tls_hmac=3D69167505 34ab0aa4 2ade5c8e d9ef05b6 5ac2dfab pid=3D[ #4=
0=20
/ time =3D (1398259583) Wed Apr 23 09:26:23 2014 ] [ ] pid=3D34 DATA=20
37060355 040b1330 436f7079 72696768 74202863 29203230 3035206c=20
6974747[more...]

Client:
UDPv4 read 142
VERIFY OK SERVER...(certificate)
Write 50 ack.
5 pairs of read[142] controlv1, write[50] ack
Read [137], error

Here is the read that delivers the data that triggers the error:
Wed Apr 23 09:26:20 2014 us=3D903142 UDPv4 read returned 137
Wed Apr 23 09:26:20 2014 us=3D903142 UDPv4 READ [137] from=20
[AF_INET]192.168.148.43:1194: P_CONTROL_V1 kid=3D0 sid=3D95747581 daf31aa7=
=20
tls_hmac=3D15534b4c 83ce2907 cffe8c48 4be9370f ccb726dd pid=3D[ #40 / time =
=3D=20
(1398259578) Wed Apr 23 09:26:18 2014 ] [ ] pid=3D34 DATA 37060355=20
040b1330 436f7079 72696768 74202863 29203230 3035206c 6974747[more...]
Wed Apr 23 09:26:20 2014 us=3D923171 TLS_ERROR: BIO read=20
tls_read_plaintext error: error:04066083:rsa=20
routines:RSA_EAY_PRIVATE_ENCRYPT:invalid message length:=20
error:14099006:SSL routines:SSL3_SEND_CLIENT_VERIFY:EVP lib
Wed Apr 23 09:26:20 2014 us=3D923171 TLS Error: TLS object -> incoming=20
plaintext read error
Wed Apr 23 09:26:20 2014 us=3D923171 TLS Error: TLS handshake failed

Here are the 5 message pairs between the Cert OK and the failing=20
message.  I removed the noise messages (byte counts, event wait status)=20
from the log. The writes all appear to be ACKs.

Wed Apr 23 09:26:20 2014 us=3D652782 UDPv4 WRITE [50] to=20
[AF_INET]192.168.148.43:1194: P_ACK_V1 kid=3D0 sid=3D65fbeaf3 0672d359=20
tls_hmac=3D1d970787 6387a112 fa241879 3429db57 a5b68435 pid=3D[ #36 / time =
=3D=20
(1398259578) Wed Apr 23 09:26:18 2014 ] [ 28 sid=3D95747581 daf31aa7 ]

Wed Apr 23 09:26:20 2014 us=3D672811 UDPv4 READ [142] from=20
[AF_INET]192.168.148.43:1194: P_CONTROL_V1 kid=3D0 sid=3D95747581 daf31aa7=
=20
tls_hmac=3D5a711521 a62527f7 50dc3d1a f047f0ee 17094d8d pid=3D[ #35 / time =
=3D=20
(1398259578) Wed Apr 23 09:26:18 2014 ] [ ] pid=3D29 DATA d2746c2a=20
f024d185 051b2752 aca668b6 7f9f22de a4f25616 b6aafc52 b6bf9b8[more...]

Wed Apr 23 09:26:20 2014 us=3D702854 UDPv4 WRITE [50] to=20
[AF_INET]192.168.148.43:1194: P_ACK_V1 kid=3D0 sid=3D65fbeaf3 0672d359=20
tls_hmac=3D43cd31d4 29be233d fb064ab0 6b98b0eb 244122b8 pid=3D[ #37 / time =
=3D=20
(1398259578) Wed Apr 23 09:26:18 2014 ] [ 29 sid=3D95747581 daf31aa7 ]

Wed Apr 23 09:26:20 2014 us=3D722883 UDPv4 READ [142] from=20
[AF_INET]192.168.148.43:1194: P_CONTROL_V1 kid=3D0 sid=3D95747581 daf31aa7=
=20
tls_hmac=3D1f005f28 be069203 07814239 15429d20 7ffb7d72 pid=3D[ #36 / time =
=3D=20
(1398259578) Wed Apr 23 09:26:18 2014 ] [ ] pid=3D30 DATA dac5cf1a=20
4cf3d888 09ea429e cba8679e 138eacca 31cedde9 2585a3db f636c68[more...]

Wed Apr 23 09:26:20 2014 us=3D742912 UDPv4 WRITE [50] to=20
[AF_INET]192.168.148.43:1194: P_ACK_V1 kid=3D0 sid=3D65fbeaf3 0672d359=20
tls_hmac=3D44239672 0d62fee0 32523b61 749d4f16 04121cac pid=3D[ #38 / time =
=3D=20
(1398259578) Wed Apr 23 09:26:18 2014 ] [ 30 sid=3D95747581 daf31aa7 ]

Wed Apr 23 09:26:20 2014 us=3D772955 UDPv4 READ [142] from=20
[AF_INET]192.168.148.43:1194: P_CONTROL_V1 kid=3D0 sid=3D95747581 daf31aa7=
=20
tls_hmac=3D9f713546 9c9bbfb0 7719bc2e 543dd209 394cf6ff pid=3D[ #37 / time =
=3D=20
(1398259578) Wed Apr 23 09:26:18 2014 ] [ ] pid=3D31 DATA 318afd4a=20
455bde09 7c2107a6 6ef02d90 47b391b7 7c760a08 d3060100 80dff9e[more...]

Wed Apr 23 09:26:20 2014 us=3D792984 UDPv4 WRITE [50] to=20
[AF_INET]192.168.148.43:1194: P_ACK_V1 kid=3D0 sid=3D65fbeaf3 0672d359=20
tls_hmac=3D5dcca51f 2b311a49 48203039 62e50c3e a3d071a3 pid=3D[ #39 / time =
=3D=20
(1398259578) Wed Apr 23 09:26:18 2014 ] [ 31 sid=3D95747581 daf31aa7 ]

Wed Apr 23 09:26:20 2014 us=3D813012 UDPv4 READ [142] from=20
[AF_INET]192.168.148.43:1194: P_CONTROL_V1 kid=3D0 sid=3D95747581 daf31aa7=
=20
tls_hmac=3Dae03c703 d69f77d6 816e68c6 3632fd45 724543cc pid=3D[ #38 / time =
=3D=20
(1398259578) Wed Apr 23 09:26:18 2014 ] [ ] pid=3D32 DATA 1e4d6356=20
d5e2df84 e4318776 e0351663 08da96c4 fec9cb83 50fef6db f2e28e1[more...]

Wed Apr 23 09:26:20 2014 us=3D843056 UDPv4 WRITE [50] to=20
[AF_INET]192.168.148.43:1194: P_ACK_V1 kid=3D0 sid=3D65fbeaf3 0672d359=20
tls_hmac=3D3b13fabd 17abc8d3 d1d94c4d 395688e3 76033fdd pid=3D[ #40 / time =
=3D=20
(1398259578) Wed Apr 23 09:26:18 2014 ] [ 32 sid=3D95747581 daf31aa7 ]

Wed Apr 23 09:26:20 2014 us=3D863084 UDPv4 READ [142] from=20
[AF_INET]192.168.148.43:1194: P_CONTROL_V1 kid=3D0 sid=3D95747581 daf31aa7=
=20
tls_hmac=3Db9269cd2 47b74a73 c43b5161 30517429 56161792 pid=3D[ #39 / time =
=3D=20
(1398259578) Wed Apr 23 09:26:18 2014 ] [ ] pid=3D33 DATA 02020203=20
010100b7 00b53081 b2311d30 1b060355 04031314 6c697474 732e6e6[more...]

Wed Apr 23 09:26:20 2014 us=3D883113 UDPv4 WRITE [50] to=20
[AF_INET]192.168.148.43:1194: P_ACK_V1 kid=3D0 sid=3D65fbeaf3 0672d359=20
tls_hmac=3D51cd68bb cd99bd7e 4988f67d 6c385535 7b4dfa06 pid=3D[ #41 / time =
=3D=20
(1398259578) Wed Apr 23 09:26:18 2014 ] [ 33 sid=3D95747581 daf31aa7 ]


Hope this helps.


Timothe Litt
ACM Distinguished Engineer
--------------------------
This communication may not represent the ACM or my employer's views,
if any, on the matters discussed.

On 23-Apr-14 04:10, Gert Doering wrote:
> Hi,
>
> On Tue, Apr 22, 2014 at 10:58:22PM -0400, Timothe Litt wrote:
>> It does not appear to be the negotiation, rather it's TLS1.2.
> This is quite cool, thank you.  (I'm not enough of a crypto geek to
> make real sense out of it, but it's quite useful to understand where
> it is failing, and I appreciate that you took the time to dig into it)
>
> Steffan, Arne, any ideas?
>
> gert
>



--------------ms060600060609090709000600
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIPDzCC
BjQwggQcoAMCAQICASAwDQYJKoZIhvcNAQEFBQAwfTELMAkGA1UEBhMCSUwxFjAUBgNVBAoT
DVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNp
Z25pbmcxKTAnBgNVBAMTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTA3
MTAyNDIxMDI1NVoXDTE3MTAyNDIxMDI1NVowgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1T
dGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWdu
aW5nMTgwNgYDVQQDEy9TdGFydENvbSBDbGFzcyAyIFByaW1hcnkgSW50ZXJtZWRpYXRlIENs
aWVudCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMsohUWcASz7GfKrpTOM
KqANy9BV7V0igWdGxA8IU77L3aTxErQ+fcxtDYZ36Z6GH0YFn7fq5RADteP0AYzrCA+EQTfi
8q1+kA3m0nwtwXG94M5sIqsvs7lRP1aycBke/s5g9hJHryZ2acScnzczjBCAo7X1v5G3yw8M
DP2m2RCye0KfgZ4nODerZJVzhAlOD9YejvAXZqHksw56HzElVIoYSZ3q4+RJuPXXfIoyby+Y
2m1E+YzX5iCZXBx05gk6MKAW1vaw4/v2OOLy6FZH3XHHtOkzUreG//CsFnB9+uaYSlR65cdG
zTsmoIK8WH1ygoXhRBm98SD7Hf/r3FELNvUCAwEAAaOCAa0wggGpMA8GA1UdEwEB/wQFMAMB
Af8wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBSuVYNv7DHKufcd+q9rMfPIHeOsuzAfBgNV
HSMEGDAWgBROC+8apEBbpRdphzDKNGhD0EGu8jBmBggrBgEFBQcBAQRaMFgwJwYIKwYBBQUH
MAGGG2h0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9jYTAtBggrBgEFBQcwAoYhaHR0cDovL3d3
dy5zdGFydHNzbC5jb20vc2ZzY2EuY3J0MFsGA1UdHwRUMFIwJ6AloCOGIWh0dHA6Ly93d3cu
c3RhcnRzc2wuY29tL3Nmc2NhLmNybDAnoCWgI4YhaHR0cDovL2NybC5zdGFydHNzbC5jb20v
c2ZzY2EuY3JsMIGABgNVHSAEeTB3MHUGCysGAQQBgbU3AQIBMGYwLgYIKwYBBQUHAgEWImh0
dHA6Ly93d3cuc3RhcnRzc2wuY29tL3BvbGljeS5wZGYwNAYIKwYBBQUHAgEWKGh0dHA6Ly93
d3cuc3RhcnRzc2wuY29tL2ludGVybWVkaWF0ZS5wZGYwDQYJKoZIhvcNAQEFBQADggIBADqp
Jw3I07QWke9plNBpxUxcffc7nUrIQpJHDci91DFG7fVhHRkMZ1J+BKg5UNUxIFJ2Z9B90Mic
c/NXcs7kPBRdn6XGO/vPc87Y6R+cWS9Nc9+fp3Enmsm94OxOwI9wn8qnr/6o3mD4noP9Jphw
UPTXwHovjavRnhUQHLfo/i2NG0XXgTHXS2Xm0kVUozXqpYpAdumMiB/vezj1QHQJDmUdPYMc
p+reg9901zkyT3fDW/ivJVv6pWtkh6Pw2ytZT7mvg7YhX3V50Nv860cV11mocUVcqBLv0gcT
+HBDYtbuvexNftwNQKD5193A7zN4vG7CTYkXxytSjKuXrpEatEiFPxWgb84nVj25SU5q/r1X
hwby6mLhkbaXslkVtwEWT3Van49rKjlK4XrUKYYWtnfzq6aSak5u0Vpxd1rY79tWhD3EdCvO
hNz/QplNa+VkIsrcp7+8ZhP1l1b2U6MaxIVteuVMD3X0vziIwr7jxYae9FZjbxlpUemqXjcC
0QaFfN7qI0JsQMALL7iGRBg7K0CoOBzECdD3fuZil5kU/LP9cr1BK31U0Uy651bFnAMMMkqh
AChIbn0ei72VnbpSsrrSdF0BAGYQ8vyHae5aCg+H75dVCV33K6FuxZrf09yTz+Vx/PkdRUYk
XmZz/OTfyJXsUOUXrym6KvI2rYpccSk5MIII0zCCB7ugAwIBAgICJtUwDQYJKoZIhvcNAQEF
BQAwgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJT
ZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFydENvbSBD
bGFzcyAyIFByaW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQTAeFw0xMjA5MjUxODQyMTha
Fw0xNDA5MjcxOTIyNDJaMIGQMRkwFwYDVQQNExBPZ3RBNVhZZXZheGFkbGtKMQswCQYDVQQG
EwJVUzEWMBQGA1UECBMNTWFzc2FjaHVzZXR0czEVMBMGA1UEBxMMU291dGhib3JvdWdoMRUw
EwYDVQQDEwxUaW1vdGhlIExpdHQxIDAeBgkqhkiG9w0BCQEWEXRpbW90aGVAbGl0dHMubmV0
MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA38JrSHJ7GVdQiTppuafIBrhphuLL
HAmpeAFNvUBuUUh4X8Nx4Ag03hrC/B7OWYpUJI1HgWCK/eMtKEWF7UMwFhkMeqWSdrZyb4uk
EqTf46SyyAghF6BGuuVTiptED63FwzQY2PTXCmAJviuRXoJMzlhAwzUFpsWTFhswigFLrMCn
kJ9nndqnxQmMFpD7pjJ6kFkxKz/5k1CEzAfSerWHkIOBuXFyYpDDgDFXN1+qF25HsVVw+4xT
1/tNvCEVQ9WAleUznLvWgT5sV8tTewsUiYOgSqyoHiuJCOc9YJF2pUHGZVV+WzS8YIb95ax5
5yoS+C3D3FFzl6CbcI3nc6csqkP4bNBqm96Z/WdfTV4ouoycI4N9AJ86l6/Ygjz3/juFI9ni
as8nE051hksnyCon87fyP3/NezZ9NcUYVUnki1cVhfh2cN+s79fGWbUJePjT0fmso0FVcSRp
ddLyeZladbifFG+TiQO9BFt97e16OwyFpXRIzZWnfEiG2ss51Vpv9au8RrLgBD07aKE3mzZp
xZzoZ8c/jgb1YcUyAyaVmdOk4A3eGe7c8Loa+eYIRwkbjoE6H/PKcoRNIqnYQ44zvOOONRDI
S3vBpzofVK5Ndx0NVDIvsbWEPb9ntR32taUUZ334SPN447UO3sjvItFg1oOuC1i6kL6l1vRM
GNouPvECAwEAAaOCBDcwggQzMAkGA1UdEwQCMAAwCwYDVR0PBAQDAgSwMB0GA1UdJQQWMBQG
CCsGAQUFBwMCBggrBgEFBQcDBDAdBgNVHQ4EFgQUJZNwH8x9MtxbZmI9AK6Jj+IELcowHwYD
VR0jBBgwFoAUrlWDb+wxyrn3HfqvazHzyB3jrLswgaYGA1UdEQSBnjCBm4ERdGltb3RoZUBs
aXR0cy5uZXSBEXRpbW90aGVAbGl0dHMubmV0gQxsaXR0QGFjbS5vcmeBDWxpdHRAaWVlZS5v
cmeBFGhvc3RtYXN0ZXJAbGl0dHMubmV0gRdsaXR0c25ldGFkbWluQGxpdHRzLm5ldIETd2lr
aWFkbWluQGxpdHRzLm5ldIESc2VjdXJpdHlAbGl0dHMubmV0MIICIQYDVR0gBIICGDCCAhQw
ggIQBgsrBgEEAYG1NwECAjCCAf8wLgYIKwYBBQUHAgEWImh0dHA6Ly93d3cuc3RhcnRzc2wu
Y29tL3BvbGljeS5wZGYwNAYIKwYBBQUHAgEWKGh0dHA6Ly93d3cuc3RhcnRzc2wuY29tL2lu
dGVybWVkaWF0ZS5wZGYwgfcGCCsGAQUFBwICMIHqMCcWIFN0YXJ0Q29tIENlcnRpZmljYXRp
b24gQXV0aG9yaXR5MAMCAQEagb5UaGlzIGNlcnRpZmljYXRlIHdhcyBpc3N1ZWQgYWNjb3Jk
aW5nIHRvIHRoZSBDbGFzcyAyIFZhbGlkYXRpb24gcmVxdWlyZW1lbnRzIG9mIHRoZSBTdGFy
dENvbSBDQSBwb2xpY3ksIHJlbGlhbmNlIG9ubHkgZm9yIHRoZSBpbnRlbmRlZCBwdXJwb3Nl
IGluIGNvbXBsaWFuY2Ugb2YgdGhlIHJlbHlpbmcgcGFydHkgb2JsaWdhdGlvbnMuMIGcBggr
BgEFBQcCAjCBjzAnFiBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTADAgECGmRM
aWFiaWxpdHkgYW5kIHdhcnJhbnRpZXMgYXJlIGxpbWl0ZWQhIFNlZSBzZWN0aW9uICJMZWdh
bCBhbmQgTGltaXRhdGlvbnMiIG9mIHRoZSBTdGFydENvbSBDQSBwb2xpY3kuMDYGA1UdHwQv
MC0wK6ApoCeGJWh0dHA6Ly9jcmwuc3RhcnRzc2wuY29tL2NydHUyLWNybC5jcmwwgY4GCCsG
AQUFBwEBBIGBMH8wOQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9zdWIv
Y2xhc3MyL2NsaWVudC9jYTBCBggrBgEFBQcwAoY2aHR0cDovL2FpYS5zdGFydHNzbC5jb20v
Y2VydHMvc3ViLmNsYXNzMi5jbGllbnQuY2EuY3J0MCMGA1UdEgQcMBqGGGh0dHA6Ly93d3cu
c3RhcnRzc2wuY29tLzANBgkqhkiG9w0BAQUFAAOCAQEAXJ5dj2hKDwAh3aPsYWSJdC6PE7O2
u4pZz4H1mucRf3ZLoLjrAMhtINAqrWkvfiOTWQruNpQAXL+Gb6pk5sDoSXwISbPraVMb4uCS
g++F/XTCvqfsCitXd6Jhl5dyV0pi2MwmHyrBsjsER1EwA+39av+cfoL0gKuJy5y92wRt0It8
Eu77N5HaMlDlxEXXTQWP5Q2g7IZy+/ZeeG8FjrUM/bmwyvdb3mBreKgL2mZHnG+mf09IDACG
9ogoV2xJNQ0lRHxH5NJ/XGSztQACboxl3wK/t86Vhh6i1JeaLMcJ5oaemxdATK0NZVk/hIK0
hXGzTMVw1xoP/9LSYyoRD6yypzGCBNowggTWAgEBMIGTMIGMMQswCQYDVQQGEwJJTDEWMBQG
A1UEChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNh
dGUgU2lnbmluZzE4MDYGA1UEAxMvU3RhcnRDb20gQ2xhc3MgMiBQcmltYXJ5IEludGVybWVk
aWF0ZSBDbGllbnQgQ0ECAibVMAkGBSsOAwIaBQCgggIbMBgGCSqGSIb3DQEJAzELBgkqhkiG
9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE0MDQyMzE1MDI0MlowIwYJKoZIhvcNAQkEMRYEFOVh
Q7RWUUC0fMerdGsA3xp5qxXNMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYF
Kw4DAgcwDQYIKoZIhvcNAwICASgwgaQGCSsGAQQBgjcQBDGBljCBkzCBjDELMAkGA1UEBhMC
SUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENl
cnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDIgUHJpbWFyeSBJ
bnRlcm1lZGlhdGUgQ2xpZW50IENBAgIm1TCBpgYLKoZIhvcNAQkQAgsxgZaggZMwgYwxCzAJ
BgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGln
aXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFydENvbSBDbGFzcyAyIFBy
aW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQQICJtUwDQYJKoZIhvcNAQEBBQAEggIAWow0
3AOMQxb3NmS3jhGtdrCj0EGsIRlqSvWovCnV4DqvhhI8GgMybs3WnONmBxS/7p+pUEvLv8ZY
CKjHGJ+gs5h4cIKt6SfMYjfOCMIhkAIDSYQiClEmEzliVul2kY77uvNH44zGM07Z3ZcrXsF0
mt/QVUuzVfPhe/RYQxWH0xKG4JwC+h5XgJiKBvUS3Iw/+rA8EIW3ne+MlxuMDvRd4YPFYzz/
jxe1gunKGeVVYDuTlW4lrOeKqwRrath9lutlxpnUbyo8Jt8MVcnYTp17kpLbiIv0xmTElXgJ
xR235VqdwH41NtalfJALAY9pUMv1jzTvB7YGGx7dZevHUKLG6fE7tN/jsiA8nitTVgXZXXus
2lkYFrtraNbuV+7F5MocZYt1vNMQteRPwOFnN1lh9kT3ytp5OIHb8Pe0kq+EQaBe9Io0vGr8
yfCFpgnUHUNn1CtmNt5JNvTx6pgnbIurNaz7Vj45Igg+HvQ6jhhx6RUKNxn7fEQruWbR0xme
NNPg9gZdqqkAq09lGqgzYAhgOiTbAsyr/grkUXYU/8dtZ2KPjJEos2FxOuDpi3PmkK8bXdy2
3nLG0bsTtc+0EB3lnc0EXRX2EvQZHhZkim4+F05CdYHxQxhLNX3PTbrVQCtfnJP1EsKH7ucy
rijMfv3iaANal9x+1Eai/CQ/dR5QHTQAAAAAAAA=
--------------ms060600060609090709000600--

