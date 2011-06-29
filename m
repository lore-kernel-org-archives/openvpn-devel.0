From: Russell Morris <openvpn@...1315...>
Date: Wed, 29 Jun 2011 17:16:56 -0500
Message-id: <1309385816281570500@...1315...>
MIME-version: 1.0
Subject: [Openvpn-devel] DNS Issue
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-disposition: inline
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

Hi,

I have been using OpenVPN for quite a while, and just switched my client co=
mputer from Windows XP to Windows 7 ... and found a very interesting artifa=
ct (=3Dproblem ... :-)). Let me try to explain ...

The client machine is on one network, which has it's own DNS servers, and D=
NS suffix (let's call it client.net). From this network DNS and internet ac=
cess works fine.

Then, from the client machine I connect back to the OpenVPN server (call it=
's network server.net), and allow my router DHCP to serve the OpenVPN IP ad=
dress information so that the client machine is then on the server subnet. =
This works great - but DNS has become a problem with Windows 7.

With Windows XP, DNS for my machine still used the client.net DNS servers, =
so I could access my local network, the internet, and by IP address (or ent=
ries in the host file) I could get back to the server.net network. I had no=
 DNS resolution for the server.net network, but that was livable (using the=
 hosts file locally). Basically the server.net DNS servers were lower in th=
e priority order, so no major issues.

Now, with Windows 7, when I make the OpenVPN connection, the DNS servers pr=
ovided by the DHCP server become primary - and this is very much a problem,=
 because now I have name resolution back to the server.net network, but tha=
t doesn't work of course for the client.net domain. Also, I actually lose i=
nternet access, because the client.net suffix is being added to DNS request=
s send back over the OpenVPN link - so internet access is dead as well ... =
:-(. I even have to apply the suffix .server.net. (note the trailing .) to =
get name resolution on the server network.

Does anyone know how to resolve this? The best case would be for local name=
 resolution for all client.net or internet requests, and "remote" resolutio=
n only for the server.net network (based on connection specific suffix). An=
y ideas how to do this?

Thanks in advance for your suggestions!

... Russell


