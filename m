Message-ID: <52D07F70.8030609@...1227...>
Date: Sat, 11 Jan 2014 00:17:04 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <52CFF667.7080600@...1790...> <52CFFAF4.8050306@...1227...>
	<52CFFDA4.4060601@...1790...>
In-Reply-To: <52CFFDA4.4060601@...1790...>
Subject: Re: [Openvpn-devel] git master proto udp6+multihome is broken
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tore Anderson <tore@...1790...>, openvpn-devel@lists.sourceforge.net

Am 10.01.14 15:03, schrieb Tore Anderson:
> * Arne Schwabe
>
>> That is very weird. I would expect it to fail for both cases in the same
>> way. The codepath should trigger the same ASSERT(0) in both cases (or
>> work in both). Can you forward a copy of your server configuration to
>> me? Then I will try to reproduce that problem.
>
Can you try the following one line patch? I will do a better cleanup
patch later but this should fix the problem

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 100eedd..b362b2c 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2828,7 +2828,7 @@ link_socket_write_udp_posix_sendmsg (struct
link_socket *s
   iov.iov_len =3D BLEN (buf);
   mesg.msg_iov =3D &iov;
   mesg.msg_iovlen =3D 1;
-  switch (to->ai_family)
+  switch (to->dest.addr.sa.sa_family)
     {
     case AF_INET:
       {


