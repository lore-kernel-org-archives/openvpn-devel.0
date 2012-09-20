Message-ID: <1348153254.3326.YahooMailNeo@...1763...>
Date: Thu, 20 Sep 2012 08:00:54 -0700 (PDT)
From: vijayakumar palaniappan <vijayakumarpl@...109...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="1831474865-1880787094-1348153254=:3326"
Subject: [Openvpn-devel] Using TUN driver in Windows
Reply-To: vijayakumar palaniappan <vijayakumarpl@...109...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--1831474865-1880787094-1348153254=:3326
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,
I have installed the TAP-WIN32 Adapter V9 on my windows 7 machine. I want t=
o use
TUN to read the IP packets out of the interface. I followed the C# sample f=
rom
http://www.varsanofiev.com/inside/using_tuntap_under_windows.htm=A0

i modified the code like below

IntPtr ptun =3D Marshal.AllocHGlobal(8);=A0 =A0 =A0 =A0=A0
Marshal.WriteInt32(ptun, 0, 0x0a030001);
Marshal.WriteInt32(ptun, 4, unchecked((int)0x00ffffFF));
bool val =3D DeviceIoControl (ptr, TAP_CONTROL_CODE (5, METHOD_BUFFERED) /*=
POINT
TO POINT */, ptun, 8,ptun, 8, out len, IntPtr.Zero);

However i still don't seem to get IP Packets. I ran tcpdump on the other en=
d and
it complains "Wrong link layer encapsulation".

Is this the correct way of trying to get IP Packets out of TUN interface?.

-Vijay=A0=

--1831474865-1880787094-1348153254=:3326
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ti=
mes new roman, new york, times, serif;font-size:12pt"><div><span><span styl=
e=3D"color: rgb(69, 69, 69); font-family: Arial, Helvetica, sans-serif; fon=
t-size: 12px; ">Hi,</span><br style=3D"color: rgb(69, 69, 69); font-family:=
 Arial, Helvetica, sans-serif; font-size: 12px; "><span style=3D"color: rgb=
(69, 69, 69); font-family: Arial, Helvetica, sans-serif; font-size: 12px; "=
>I have installed the TAP-WIN32 Adapter V9 on my windows 7 machine. I want =
to use</span><br style=3D"color: rgb(69, 69, 69); font-family: Arial, Helve=
tica, sans-serif; font-size: 12px; "><span style=3D"color: rgb(69, 69, 69);=
 font-family: Arial, Helvetica, sans-serif; font-size: 12px; ">TUN to read =
the IP packets out of the interface. I followed the C# sample from</span><b=
r style=3D"color: rgb(69, 69, 69); font-family: Arial, Helvetica, sans-seri=
f; font-size: 12px; "><a
 href=3D"http://www.varsanofiev.com/inside/using_tuntap_under_windows.htm" =
target=3D"_blank" style=3D"color: rgb(35, 71, 134); outline: 0px; font-fami=
ly: Arial, Helvetica, sans-serif; font-size: 12px; ">http://www.varsanofiev=
.com/inside/using_tuntap_under_windows.htm</a><span style=3D"color: rgb(69,=
 69, 69); font-family: Arial, Helvetica, sans-serif; font-size: 12px; ">&nb=
sp;</span><br style=3D"color: rgb(69, 69, 69); font-family: Arial, Helvetic=
a, sans-serif; font-size: 12px; "><br style=3D"color: rgb(69, 69, 69); font=
-family: Arial, Helvetica, sans-serif; font-size: 12px; "><span style=3D"co=
lor: rgb(69, 69, 69); font-family: Arial, Helvetica, sans-serif; font-size:=
 12px; ">i modified the code like below</span><br style=3D"color: rgb(69, 6=
9, 69); font-family: Arial, Helvetica, sans-serif; font-size: 12px; "><br s=
tyle=3D"color: rgb(69, 69, 69); font-family: Arial, Helvetica, sans-serif; =
font-size: 12px; "><span style=3D"color: rgb(69, 69, 69); font-family: Aria=
l, Helvetica,
 sans-serif; font-size: 12px; ">IntPtr ptun =3D Marshal.AllocHGlobal(8);&nb=
sp; &nbsp; &nbsp; &nbsp;&nbsp;</span><br style=3D"color: rgb(69, 69, 69); f=
ont-family: Arial, Helvetica, sans-serif; font-size: 12px; "><span style=3D=
"color: rgb(69, 69, 69); font-family: Arial, Helvetica, sans-serif; font-si=
ze: 12px; ">Marshal.WriteInt32(ptun, 0, 0x0a030001);</span><br style=3D"col=
or: rgb(69, 69, 69); font-family: Arial, Helvetica, sans-serif; font-size: =
12px; "><span style=3D"color: rgb(69, 69, 69); font-family: Arial, Helvetic=
a, sans-serif; font-size: 12px; ">Marshal.WriteInt32(ptun, 4, unchecked((in=
t)0x00ffffFF));</span><br style=3D"color: rgb(69, 69, 69); font-family: Ari=
al, Helvetica, sans-serif; font-size: 12px; "><span style=3D"color: rgb(69,=
 69, 69); font-family: Arial, Helvetica, sans-serif; font-size: 12px; ">boo=
l val =3D DeviceIoControl (ptr, TAP_CONTROL_CODE (5, METHOD_BUFFERED) /*POI=
NT</span><br style=3D"color: rgb(69, 69, 69); font-family: Arial, Helvetica,
 sans-serif; font-size: 12px; "><span style=3D"color: rgb(69, 69, 69); font=
-family: Arial, Helvetica, sans-serif; font-size: 12px; ">TO POINT */, ptun=
, 8,ptun, 8, out len, IntPtr.Zero);</span><br style=3D"color: rgb(69, 69, 6=
9); font-family: Arial, Helvetica, sans-serif; font-size: 12px; "><br style=
=3D"color: rgb(69, 69, 69); font-family: Arial, Helvetica, sans-serif; font=
-size: 12px; "><span style=3D"color: rgb(69, 69, 69); font-family: Arial, H=
elvetica, sans-serif; font-size: 12px; ">However i still don't seem to get =
IP Packets. I ran tcpdump on the other end and</span><br style=3D"color: rg=
b(69, 69, 69); font-family: Arial, Helvetica, sans-serif; font-size: 12px; =
"><span style=3D"color: rgb(69, 69, 69); font-family: Arial, Helvetica, san=
s-serif; font-size: 12px; ">it complains "Wrong link layer encapsulation".<=
/span><br style=3D"color: rgb(69, 69, 69); font-family: Arial, Helvetica, s=
ans-serif; font-size: 12px; "><br style=3D"color: rgb(69, 69, 69); font-fam=
ily:
 Arial, Helvetica, sans-serif; font-size: 12px; "><span style=3D"color: rgb=
(69, 69, 69); font-family: Arial, Helvetica, sans-serif; font-size: 12px; "=
>Is this the correct way of trying to get IP Packets out of TUN interface?.=
</span><br style=3D"color: rgb(69, 69, 69); font-family: Arial, Helvetica, =
sans-serif; font-size: 12px; "><br style=3D"color: rgb(69, 69, 69); font-fa=
mily: Arial, Helvetica, sans-serif; font-size: 12px; "><span style=3D"color=
: rgb(69, 69, 69); font-family: Arial, Helvetica, sans-serif; font-size: 12=
px; ">-Vijay</span>&nbsp;</span></div><div><br></div></div></body></html>=

--1831474865-1880787094-1348153254=:3326--

