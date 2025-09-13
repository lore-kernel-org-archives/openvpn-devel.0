Content-Type: multipart/signed;
 boundary="Apple-Mail=_55BD4E24-6A60-492B-9C1C-E03BC3EB8D02";
 protocol="application/pkcs7-signature"; micalg=sha-256
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
From: Sebastian Marsching <sebastian@...2913...>
In-Reply-To: <aMWICpJmVFAVXlKc@...1296...>
Date: Sat, 13 Sep 2025 18:14:03 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <599E5024-02A6-418D-AB2C-599D03BE1111@...2913...>
References: <65233605-9738-4B2C-8401-37AA5C43D797@...2913...>
 <aMWICpJmVFAVXlKc@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Bugfix: Set broadcast address on
 interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--Apple-Mail=_55BD4E24-6A60-492B-9C1C-E03BC3EB8D02
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Gert,

> On Sat, Sep 13, 2025 at 04:25:25PM +0200, Sebastian Marsching wrote:
>> This patch fixes this issue both when using iproute (by telling iproute
>> to set the broadcast address based on the local address and prefix) and
>> when using Netlink (by calculating the correct broadcast address and
>> setting it).
>=20
> Should Linux not be able to auto-calculate that, based on IP address
> and netmask?

You would think so, but it does not=E2=80=A6

> No other OS needs explicit setting of broadcast address in 2025...
>=20
> Can you show the difference in "ip address show" or "ifconfig" output
> before/after your change?  Is this on a client or server?

Output of ifconfig without the change (IPv6 address anonymized by me):

tap0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
       inet 172.22.56.178  netmask 255.255.255.0  broadcast 0.0.0.0
       inet6 xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:xxxx  prefixlen 64  scopeid=
 0x0<global>
       inet6 fe80::800b:93ff:fe07:a32a  prefixlen 64  scopeid 0x20<link>
       ether f6:f6:91:dc:83:af  txqueuelen 1000  (Ethernet)
       RX packets 108  bytes 32404 (32.4 KB)
       RX errors 0  dropped 0  overruns 0  frame 0
       TX packets 14  bytes 1172 (1.1 KB)
       TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

With the change:

tap0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
       inet 172.22.56.178  netmask 255.255.255.0  broadcast 172.22.56.255
       inet6 xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:xxxx  prefixlen 64  scopeid=
 0x0<global>
       inet6 fe80::f0f2:e4ff:fe4f:bfff  prefixlen 64  scopeid 0x20<link>
       ether f2:f2:e4:4f:bf:ff  txqueuelen 1000  (Ethernet)
       RX packets 12  bytes 1200 (1.2 KB)
       RX errors 0  dropped 0  overruns 0  frame 0
       TX packets 11  bytes 962 (962.0 B)
       TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

When using ip address show instead, the difference is that without the chan=
ge

inet 172.22.56.178/24 scope global tap0

is shown, while with the change

inet 172.22.56.178/24 brd 172.22.56.255 scope global tap0

is shown.

In fact, systemd-networkd also does it. When configuring an IP address,

1. it calls the code that calculates the broadcast address at https://githu=
b.com/systemd/systemd/blob/5bf7438ff025ae05daf1b706f204f31373d5ab82/src/net=
work/networkd-address.c#L1667,
2. it calculates the broadcast address (if not specified explicitly) at htt=
ps://github.com/systemd/systemd/blob/5bf7438ff025ae05daf1b706f204f31373d5ab=
82/src/network/networkd-address.c#L408,
3. and finally it send the broadcast address to the kernel at https://githu=
b.com/systemd/systemd/blob/5bf7438ff025ae05daf1b706f204f31373d5ab82/src/net=
work/networkd-address.c#L1555.

It implements the way how the broadcast address is calculated slightly diff=
erently. For my patch, I took the inspiration from how iproute2 implements =
it instead.

Best regards,
Sebastian


--Apple-Mail=_55BD4E24-6A60-492B-9C1C-E03BC3EB8D02
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCDUww
ggaSMIIEeqADAgECAhBnekiEWLqu2jMqwnjPZe8IMA0GCSqGSIb3DQEBCwUAME4xCzAJBgNVBAYT
AlBMMSEwHwYDVQQKDBhBc3NlY28gRGF0YSBTeXN0ZW1zIFMuQS4xHDAaBgNVBAMME0NlcnR1bSBT
TUlNRSBSU0EgQ0EwHhcNMjUwNDMwMTU0OTA1WhcNMjcwNDMwMTU0OTA0WjB8MRIwEAYDVQQEDAlN
YXJzY2hpbmcxGTAXBgNVBCoMEFNlYmFzdGlhbiBNYXJ0aW4xIzAhBgNVBAMMGlNlYmFzdGlhbiBN
YXJ0aW4gTWFyc2NoaW5nMSYwJAYJKoZIhvcNAQkBFhdzZWJhc3RpYW5AbWFyc2NoaW5nLmNvbTCC
AaIwDQYJKoZIhvcNAQEBBQADggGPADCCAYoCggGBAMLdgLH6CxsOYeI9a0tqClH9gU7SVMEBZn0z
iNHiUDV0qtZD2YuKKIuZa5bgu6J/4CEyppQ2uT0jAzILb2D9hCtvZZxfWOmnhjKOyEVsWVQHT3+5
rPtOVcy5e2jyGg1bNTVm4L3dkm54bDumoNWVphRXWhmAN6zQYsJ89Ap2OXK6XQecUJ0yZhOd8Dnm
5g8IJrVj3ZmA/NtmQIn42ODc4TGobbylH77weQgW4JE52SqbGjXedWayjKjm1bs72s7uEnjr8sdV
y+jwPzNbDx0bevbCmjgqM7/mCEIrnKgldtyzIQKMThl7dv+jbdwTUBQjs5nsL0zsWZJSqRMAQKSN
n5Gc8f8fVvxBOc7g9rsNyMWVB20o6u8iZLdq3F2L8ka/GoOLUoRK4nKVVaY7ELvZAl1ni3UsmZzt
RrackGbqjPutFpTKUvFmx28WqLF+HYiihmMiLk3AymDGYnAOgNCYRvqMWIg8woY6/2UeOOqgb8gH
+G9XvyFE3sNEtgrUOm1uVQIDAQABo4IBvDCCAbgwDAYDVR0TAQH/BAIwADBBBgNVHR8EOjA4MDag
NKAyhjBodHRwOi8vY3NtaW1lcnNhY2EuY3JsLmNlcnR1bS5wbC9jc21pbWVyc2FjYS5jcmwwgYMG
CCsGAQUFBwEBBHcwdTAuBggrBgEFBQcwAYYiaHR0cDovL2NzbWltZXJzYWNhLm9jc3AtY2VydHVt
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
AAAAAA==
--Apple-Mail=_55BD4E24-6A60-492B-9C1C-E03BC3EB8D02--

