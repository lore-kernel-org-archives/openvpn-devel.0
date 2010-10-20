MIME-Version: 1.0
Date: Wed, 20 Oct 2010 14:58:47 -0700
Message-ID: <AANLkTik2EpA-JAS=q6bmHrvw1qHRQp5D2rLPpbvy+NTE@...278...>
From: Ansis Atteka <ansisatteka.dev@...277...>
Content-Type: multipart/alternative; boundary=90e6ba6e8b04888f05049313835d
Subject: [Openvpn-devel] With route-noexec openvpn still adds routes
	automatically
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--90e6ba6e8b04888f05049313835d
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I have OpenVPN configuration where I want to add all routes from up.sh and
down.sh scripts manually. My setup also has route-noexec option in config
file, so according to man pages I would expect that OpenVPN should not add
any routes on its own:

*       --route-noexec
              Don't add or remove routes automatically.  Instead  pass
routes
              to --route-up script using environmental variables.
*
But it turns out that with topology P2P it still adds a route when setting
up TUN with ifconfig command for pointopoint mode.


My questions are:
1. Is it by design that OpenVPN still adds routes automatically with
topology p2p and route-noexec set? I guess that openvpn has limited
visibility over what ifconfig command does, so maybe this is the reason...
2. Should one use topology Subnet instead of P2P in such cases, to get pure
control over what routes are being added?


Regards,
Ansis Atteka

--90e6ba6e8b04888f05049313835d
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,<br><br>I have OpenVPN configuration where I want to add all routes f=
rom up.sh and down.sh scripts manually. My setup also has route-noexec opti=
on in config file, so according to man pages I would expect that OpenVPN sh=
ould not add any routes on its own:<br>
<br><i>=A0=A0=A0=A0=A0=A0 --route-noexec<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 Don&#39;t add or remove routes automatically.=A0 Instead=A0 pass=
=A0 routes<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 to --route-up script =
using environmental variables.<br></i><br>But it turns out that with topolo=
gy P2P it still adds a route when setting up TUN with ifconfig command for =
pointopoint mode.<br>
<br><br>My questions are:<br>1. Is it by design that OpenVPN still adds rou=
tes automatically with topology p2p and route-noexec set? I guess that open=
vpn has limited visibility over what ifconfig command does, so maybe this i=
s the reason...<br>
2. Should one use topology Subnet instead of P2P in such cases, to get pure=
 control over what routes are being added?<br><br><br>Regards,<br>Ansis Att=
eka<br>

--90e6ba6e8b04888f05049313835d--

