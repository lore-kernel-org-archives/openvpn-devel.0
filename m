MIME-Version: 1.0
From: Jon Chiappetta <root@...2904...>
Date: Sat, 16 Aug 2025 21:38:13 -0400
Message-ID: <CAOh3LPMi5NcTx+Cu6nEO_Orwcjim4qf2gChsOdsN5trOTdP7qA@...278...>
Content-Type: multipart/alternative; boundary="000000000000cca2bd063c85ad7e"
References: <CAOh3LPMi5NcTx+Cu6nEO_Orwcjim4qf2gChsOdsN5trOTdP7qA.ref@...278...>
Subject: [Openvpn-devel] Nice work on the DCO kernel module - Just had some
 quick questions about it
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--000000000000cca2bd063c85ad7e
Content-Type: text/plain; charset="UTF-8"

I just wanted to post here and say nice job on making the DCO module. I was
able to compile it and insmod it and I think OpenVPN auto picked it up even
running in TCP mode I believe. I wanted to confirm, does this DCO module
work with TCP mode or is it UDP client/server protocol only? Also, I'm not
very smart and I am unable to understand kernel-level C code as it is very
abstract and generalized but I was trying to see what read/write buffer
sizes it uses if I had a TUN MTU of 1500 bytes?
In normal C, you can see the tun read / socket write / socket read / tun
write calls and you can see the exact buffer sizes being used but in this
case I cannot see how much data is being read from TUN per call and how
much data is being written to the TCP socket per call? I tried reading
through the code in github but it was a bit tough for my limited knowledge
unfortunately :/ I always wished I knew more about reading/writing kernel
level C code but I never had the chance or time to really get into it over
the years.

I performed a speed test with it also but I could only get the same speed
as my modified OpenVPN setup (~650Mbps over WiFi 6GHz@...2907...) so I think
there is some other limiting factor elsewhere in my network setup. I don't
have a wired client, only a U7-Pro and I am running the VPN client in the
middle of my network on a Linux VM on a Mac Mini but it ran pretty smoothly
and nicely assuming it was indeed working correctly.

cd ovpn-dco-master/
vim ./drivers/net/ovpn-dco/udp.c #CONFIG_IPV6 -> #ifdef CONFIG_IPV6_NO
make
cp -fv ./drivers/net/ovpn-dco/ovpn-dco-v2.ko ../
modprobe udp_tunnel
insmod /root/dco/ovpn-dco-v2.ko

Thanks again,
Jon C

--000000000000cca2bd063c85ad7e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I just wanted to post here and say nice job on making the =
DCO module. I was able to compile it and insmod it and I think OpenVPN auto=
 picked it up even running in TCP mode I believe. I wanted to confirm, does=
 this DCO module work with TCP mode or is it UDP client/server protocol onl=
y? Also, I&#39;m not very smart and I am unable to understand kernel-level =
C code as it is very abstract and generalized but I was trying to see what =
read/write buffer sizes it uses if I had a TUN MTU of 1500 bytes?<div>In no=
rmal C, you can see the tun read / socket write / socket read / tun write c=
alls and you can see the exact buffer sizes being used but in this case I c=
annot see how much data is being read from TUN per call and how much data i=
s being written to the TCP socket per call? I tried reading through the cod=
e in github but it was a bit tough for my limited knowledge unfortunately :=
/ I always wished I knew more about reading/writing kernel level C code but=
 I never had the chance or time to really get into it over the years.=C2=A0=
</div><div><br></div><div>I performed a speed test with it also but I could=
 only get the same speed as my modified OpenVPN setup (~650Mbps over WiFi 6=
GHz@...2907...) so I think there is some other limiting factor elsewhere=C2=
=A0in my network setup. I don&#39;t have a wired client, only a U7-Pro and =
I am running the VPN client in the middle of my network on a Linux VM on a =
Mac Mini but it ran pretty smoothly and nicely assuming=C2=A0it was indeed =
working correctly.=C2=A0</div><div><br></div><div>cd ovpn-dco-master/<br>vi=
m ./drivers/net/ovpn-dco/udp.c #CONFIG_IPV6 -&gt; #ifdef CONFIG_IPV6_NO<br>=
make<br>cp -fv ./drivers/net/ovpn-dco/ovpn-dco-v2.ko ../<br>modprobe udp_tu=
nnel<br>insmod /root/dco/ovpn-dco-v2.ko<br></div><div><br></div><div>Thanks=
 again,</div><div>Jon C</div><div><br></div></div>

--000000000000cca2bd063c85ad7e--

