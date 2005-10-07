Message-ID: <4346C951.400@...361...>
From: Rolf Fokkens <r.fokkens@...361...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Patch: TAP usage made non ARP dependent
References: <43404D99.8080309@...361...>  <434189C7.5090304@...361...>	 <1128369731.6952.59.camel@...399...> <4342703F.90607@...361...>	 <1128428582.7061.18.camel@...399...>	 <4342D092.4050502@...361...>	 <1128619301.7000.58.camel@...399...>	 <4346A01F.4030106@...361...> <1128702738.7000.97.camel@...399...>
In-Reply-To: <1128702738.7000.97.camel@...399...>
Content-Type: multipart/alternative;
 boundary="------------070000090201020409040707"
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Oct  7 12:17:28 2005
To: Marcelo Toledo <marcelo@...461...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------070000090201020409040707
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

Marcelo Toledo wrote:

>Em Sex, 2005-10-07 =C3=A0s 18:19 +0200, Rolf Fokkens escreveu:
>=20=20
>
>>Could be a silly question, but to be sure: you had the client-to-client=20
>>option enabled on the server side?
>>=20=20=20=20
>>
>
>Yes we do.
>
>=20=20
>
>>The patch should work both on the client and the server, but for clients=
=20
>>it hardly does anything at all.
>>=20=20=20=20
>>
>
>alright, here what we have done.
>
>In the main server we installed the patch. We have ~400 clients
>connected to it, 3 of them we also installed the patch, here is the
>result.
>
>All these 3 clients couldn't see each other but they could see the
>remaining 397 clients. The 397 couldn't see the 3 clients.
>
>I think that's it, any idea?
>=20=20
>
What do you mean with "see each other"? I tried to reproduce, but no=20
success. Both the clients could ping each other:

Server:

./openvpn --writepid /var/run/openvpn/nocompress.pid --cd /etc/openvpn/=20
--client-to-client --status /tmp/nocompress.status 1 cipher aes-128-cbc=20
--keepalive 10 30 --port 5000 --dev tap0 --fragment 1300 --mtu-disc yes=20
--mode server --tls-server --dh /etc/openvpn/plaza/dh1024.pem --ca=20
/etc/openvpn/plaza/openvpn-ca.crt --cert=20
/etc/openvpn/plaza/openvpn-N004.crt --key=20
/etc/openvpn/plaza/openvpn-N004.key --verb 2 -- management 127.0.0.1 5000

Client 1:

/opt/openvpn --writepid /var/run/openvpn-vvpn-0.pid --cipher aes-128-cbc=20
--engine padlock --dev tap0 --keepalive 3 30 --tls-client --port 5000=20
--passtos --syslog --fragment 1300 --mtu-disc yes --management 127.0.0.1=20
5000 --ca /etc/openvpn/vvpn/ca.crt --cert /etc/openvpn/vvpn/vvpn.crt=20
--key /etc/openvpn/vvpn/vvpn.key --verb 2 --remote 145.66.1.1

Client 2:

/opt/openvpn --writepid /var/run/openvpn-vvpn-0.pid --cipher aes-128-cbc=20
--engine padlock --dev tap0 --keepalive 3 30 --tls-client --port 5000=20
--passtos --syslog --fragment 1300 --mtu-disc yes --management 127.0.0.1=20
5000 --ca /etc/openvpn/vvpn/ca.crt --cert /etc/openvpn/vvpn/vvpn.crt=20
--key /etc/openvpn/vvpn/vvpn.key --verb 2 --remote 145.66.1.1

Any obvious difference to your configs?

--------------070000090201020409040707
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content=3D"text/html;charset=3DUTF-8" http-equiv=3D"Content-Type">
  <title></title>
</head>
<body bgcolor=3D"#ffffff" text=3D"#000000">
Marcelo Toledo wrote:
<blockquote cite=3D"mid1128702738.7000.97.camel@...399..."
 type=3D"cite">
  <pre wrap=3D"">Em Sex, 2005-10-07 =C3=A0s 18:19 +0200, Rolf Fokkens escre=
veu:
  </pre>
  <blockquote type=3D"cite">
    <pre wrap=3D"">Could be a silly question, but to be sure: you had the c=
lient-to-client=20
option enabled on the server side?
    </pre>
  </blockquote>
  <pre wrap=3D""><!---->
Yes we do.

  </pre>
  <blockquote type=3D"cite">
    <pre wrap=3D"">The patch should work both on the client and the server,=
 but for clients=20
it hardly does anything at all.
    </pre>
  </blockquote>
  <pre wrap=3D""><!---->
alright, here what we have done.

In the main server we installed the patch. We have ~400 clients
connected to it, 3 of them we also installed the patch, here is the
result.

All these 3 clients couldn't see each other but they could see the
remaining 397 clients. The 397 couldn't see the 3 clients.

I think that's it, any idea?
  </pre>
</blockquote>
What do you mean with "see each other"? I tried to reproduce, but no
success. Both the clients could ping each other:<br>
<br>
Server:<br>
<br>
./openvpn --writepid /var/run/openvpn/nocompress.pid --cd /etc/openvpn/
--client-to-client --status /tmp/nocompress.status 1 cipher aes-128-cbc
--keepalive 10 30 --port 5000 --dev tap0 --fragment 1300 --mtu-disc yes
--mode server --tls-server --dh /etc/openvpn/plaza/dh1024.pem --ca
/etc/openvpn/plaza/openvpn-ca.crt --cert
/etc/openvpn/plaza/openvpn-N004.crt --key
/etc/openvpn/plaza/openvpn-N004.key --verb 2 -- management 127.0.0.1
5000<br>
<br>
Client 1:<br>
<br>
/opt/openvpn --writepid /var/run/openvpn-vvpn-0.pid --cipher
aes-128-cbc --engine padlock --dev tap0 --keepalive 3 30 --tls-client
--port 5000 --passtos --syslog --fragment 1300 --mtu-disc yes
--management 127.0.0.1 5000 --ca /etc/openvpn/vvpn/ca.crt --cert
/etc/openvpn/vvpn/vvpn.crt --key /etc/openvpn/vvpn/vvpn.key --verb 2
--remote 145.66.1.1<br>
<br>
Client 2:<br>
<br>
/opt/openvpn --writepid /var/run/openvpn-vvpn-0.pid --cipher
aes-128-cbc --engine padlock --dev tap0 --keepalive 3 30 --tls-client
--port 5000 --passtos --syslog --fragment 1300 --mtu-disc yes
--management 127.0.0.1 5000 --ca /etc/openvpn/vvpn/ca.crt --cert
/etc/openvpn/vvpn/vvpn.crt --key /etc/openvpn/vvpn/vvpn.key --verb 2
--remote 145.66.1.1<br>
<br>
Any obvious difference to your configs? <br>
</body>
</html>

--------------070000090201020409040707--

