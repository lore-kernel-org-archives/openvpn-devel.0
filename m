Date: Wed, 19 Jul 2017 18:41:26 -0700
From: Gregory Sloop <gregs@...1934...>
Reply-To: Greg Sloop <gregs@...1934...>
Message-ID: <625907428.20170719184126@...1934...>
In-Reply-To: <3cc66768-4fb0-108c-433d-85599295ed7f@...1435...>
References: <82384304.20170718084649@...1934...>
	<3cc66768-4fb0-108c-433d-85599295ed7f@...1435...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----------0150F31B63DE4F769"
Subject: Re: [Openvpn-devel] iOS key decrypts
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

------------0150F31B63DE4F769
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=0D

SK> Hi,

SK> On 18-07-17 17:46, Gregory Sloop wrote:
>> Does anyone know definitively what key encryptions/decryptions the iOS
>> client will properly handle? [And if there's any difference using unfied
>> vs non-unified setups.]

SK> The iOS client is not part of the current community development, but
SK> maintained by OpenVPN Technologies.  You could try to get in touch with
SK> them.

SK> That said, I see no reason why it could not support AES-encrypted keys.
SK> The 2.x community code base even uses AES-encrypted test keys (PEM, not
SK> PKCS12), and those work with both OpenSSL and mbed TLS crypto backends
SK> (just tested as for back as PolarSSL 1.2, but earlier versions probably
SK> too).

SK> -Steffan

Thanks.

Yeah, these same unified configs with the AES-256 encrypted keys work just =
fine on the Windows and OSX versions of OpenVPN/TunnelBlick. Thus I expecte=
d them to work without issue on iOS. [Exact same config installed fine on O=
SX for the same client.]

My problem at the moment is I don't have an iOS device where I can easily t=
est, and this client is more than an hour away from me physically - so "tes=
ting" isn't very easy. [They're a very non-tech savvy client.]

So, I hate to try to "test" on this client - by sending several different u=
nified configs with different key encryptions, hoping to luck onto the righ=
t combination.

---
Perhaps another line of thought.
The unified config I sent looks like this
---
client
dev tun
proto udp
resolv-retry infinite
nobind
persist-key
persist-tun
cipher aes-256-cbc
auth sha256
remote-cert-tls server
verb 3
remote 1.2.3.4 1194

<cert>
</cert>

<key>
</key>

<ca>
</ca>

---
Most examples have the order different - ca - cert - key.
Could this have any impact? [Seems totally NUTS if it does - but I'm graspi=
ng at straws a bit....

[I like them in this order because the ca doesn't change for each client-ma=
chine, but obviously the cert/key do - and having them at the top is just a=
 bit easier.]

I'll see if I can dig up an iOS device to test with, but if anyone really w=
ants to kill some time and check it for me - I'd be eternally grateful. :)

-Greg


---=

------------0150F31B63DE4F769
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html><head><title>Re: [Openvpn-devel] iOS key decrypts</title>
</head>
<body>
<br><br>
<br>
<span style=3D" font-family:'courier new'; font-size: 9pt; color: #800000;"=
><b>SK&gt; Hi,<br>
<br>
SK&gt; On 18-07-17 17:46, Gregory Sloop wrote:<br>
&gt;&gt; Does anyone know definitively what key encryptions/decryptions the=
 iOS<br>
&gt;&gt; client will properly handle? [And if there's any difference using =
unfied<br>
&gt;&gt; vs non-unified setups.]<br>
<br>
SK&gt; The iOS client is not part of the current community development, but=
<br>
SK&gt; maintained by OpenVPN Technologies. &nbsp;You could try to get in to=
uch with<br>
SK&gt; them.<br>
<br>
SK&gt; That said, I see no reason why it could not support AES-encrypted ke=
ys.<br>
SK&gt; The 2.x community code base even uses AES-encrypted test keys (PEM, =
not<br>
SK&gt; PKCS12), and those work with both OpenSSL and mbed TLS crypto backen=
ds<br>
SK&gt; (just tested as for back as PolarSSL 1.2, but earlier versions proba=
bly<br>
SK&gt; too).<br>
<br>
SK&gt; -Steffan<br>
<br>
</b><span style=3D" color: #000000;">Thanks.<br>
<br>
Yeah, these same unified configs with the AES-256 encrypted keys work just =
fine on the Windows and OSX versions of OpenVPN/TunnelBlick. Thus I expecte=
d them to work without issue on iOS. [Exact same config installed fine on O=
SX for the same client.]<br>
<br>
My problem at the moment is I don't have an iOS device where I can easily t=
est, and this client is more than an hour away from me physically - so "tes=
ting" isn't very easy. [They're a very non-tech savvy client.]<br>
<br>
So, I hate to try to "test" on this client - by sending several different u=
nified configs with different key encryptions, hoping to luck onto the righ=
t combination.<br>
<br>
---<br>
Perhaps another line of thought.<br>
The unified config I sent looks like this<br>
---<br>
client<br>
dev tun<br>
proto udp<br>
resolv-retry infinite<br>
nobind<br>
persist-key<br>
persist-tun<br>
cipher aes-256-cbc<br>
auth sha256<br>
remote-cert-tls server<br>
verb 3<br>
remote 1.2.3.4 1194<br>
<br>
&lt;cert&gt;<br>
&lt;/cert&gt;<br>
<br>
&lt;key&gt;<br>
&lt;/key&gt;<br>
<br>
&lt;ca&gt;<br>
&lt;/ca&gt;<br>
<br>
---<br>
Most examples have the order different - ca - cert - key.<br>
Could this have any impact? [Seems totally NUTS if it does - but I'm graspi=
ng at straws a bit....<br>
<br>
[I like them in this order because the ca doesn't change for each client-ma=
chine, but obviously the cert/key do - and having them at the top is just a=
 bit easier.]<br>
<br>
I'll see if I can dig up an iOS device to test with, but if anyone really w=
ants to kill some time and check it for me - I'd be eternally grateful. :)<=
br>
<br>
-Greg<br>
<br>
<br>
<span style=3D" font-family:'arial'; font-size: 8pt; color: #c0c0c0;"><i>--=
-<br>
</body></html>=

------------0150F31B63DE4F769--


