MIME-Version: 1.0
Date: Fri, 14 Jan 2011 21:00:25 +0100
Message-ID: <AANLkTi=O+pg_K-W4AkT=3__VymknQ5dK0tq3czxBjLXL@...278...>
From: Magnus Lindholm <linmag7@...277...>
Content-Type: multipart/alternative; boundary=0016e65a073e9da0a20499d3e2cc
Subject: [Openvpn-devel] get_default_gateway for solaris
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Openvpn-devel@lists.sourceforge.net

--0016e65a073e9da0a20499d3e2cc
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I've recently started to use OpenVPN at home I'm running the 2.2-beta5. I'm
using OpenVPN (client) on a Solaris 11 express SPARC box and, from what I
could tell, the get_default_gateway function in route.c is not implemented
yet for the Solaris platform. This was a problem for me since I want the
client to be able to detect the default gateway in order for the route
add/del stuff to work properly when I connect/disconnect the VPN.

I've added code inside the TARGET_SOLARIS section so that OpenVPN now is
able to correctly determine the default gateway on my Solaris system. This
seems to  work for me and OpenVPN is really a great VPN software and seems
to work great on the Solaris/SPARC platform.

If anyone has the same problem on the Solaris platform and would like to try
out the changes I made, let me know.

Regards

Magnus Lindholm

--0016e65a073e9da0a20499d3e2cc
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I&#39;ve recently started to use OpenVPN at home I&#39;m running=
 the 2.2-beta5. I&#39;m using OpenVPN (client) on a Solaris 11 express SPAR=
C box and, from what I could tell, the get_default_gateway function in rout=
e.c is not implemented yet for the Solaris platform. This was a problem for=
 me since I want the client to be able to detect the default gateway in ord=
er for the route add/del stuff to work properly when I connect/disconnect t=
he VPN.<br>
<br>I&#39;ve added code inside the TARGET_SOLARIS section so that OpenVPN n=
ow is able to correctly determine the default gateway on my Solaris system.=
 This seems to=A0 work for me and OpenVPN is really a great VPN software an=
d seems to work great on the Solaris/SPARC platform. <br>
<br>If anyone has the same problem on the Solaris platform and would like t=
o try out the changes I made, let me know.<br><br>Regards<br><br>Magnus Lin=
dholm<br><br><br>

--0016e65a073e9da0a20499d3e2cc--

