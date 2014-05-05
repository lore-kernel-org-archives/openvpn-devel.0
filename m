MIME-Version: 1.0
Date: Mon, 5 May 2014 08:02:38 +0200
Message-ID: <CALufPjXL2hX-W25uBvGNk1M_TbbrkZcUMe-3dYwD2oa9f6DD2Q@...278...>
From: Marine B <yunai39@...277...>
Content-Type: multipart/alternative; boundary=089e013d1c46ebfe5a04f8a0e0d8
Subject: [Openvpn-devel] [New Plugin] Diifferent subnet for different Group
	of user
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--089e013d1c46ebfe5a04f8a0e0d8
Content-Type: text/plain; charset=UTF-8

Good Morning,

I have made an atempte at creating a new plugin for OpenVPN. My goal was to
be able to give ip, comming from different subnet , to user from different
group. Let me explain:

You have two group:
Group A, where user common name follow the regex ^A* and those people need
to have an ip in 10.0.0.0/24
Group B, where user common name follow the regex ^B* and those people need
to have an ip in 10.0.1.0/24

Usually, you would use client-config-dir, but for that you need to have
every file ready before hand.

I want my plugin to handle that kind of situtation.

Tell me if you think it is a bad idea, good, my implementation suck ...
well anything.

The plugin is disponible here
https://github.com/yunai39/OpenVPNSubNetworkPlugin/blob/master/src/simple.c

I am far from being an expert in C, and I tried to figure out how OpenVPN
plugin work by reading previous plugin code.

Thank you.

--089e013d1c46ebfe5a04f8a0e0d8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div><div><div>Good Morning,=
<br><br></div>I have made an atempte at creating a new plugin for OpenVPN. =
My goal was to be able to give ip, comming from different subnet , to user =
from different group. Let me explain:<br>
<br></div>You have two group:<br>Group A, where user common name follow the=
 regex ^A* and those people need to have an ip in <a href=3D"http://10.0.0.=
0/24">10.0.0.0/24</a></div>Group B, where user common name follow the regex=
 ^B* and those people need to have an ip in <a href=3D"http://10.0.1.0/24">=
10.0.1.0/24</a><br>
<br></div>Usually, you would use client-config-dir, but for that you need t=
o have every file ready before hand.<br><br></div>I want my plugin to handl=
e that kind of situtation.<br><br></div>Tell me if you think it is a bad id=
ea, good, my implementation suck ... well anything.<br>
<br></div>The plugin is disponible here <a href=3D"https://github.com/yunai=
39/OpenVPNSubNetworkPlugin/blob/master/src/simple.c">https://github.com/yun=
ai39/OpenVPNSubNetworkPlugin/blob/master/src/simple.c</a><br><br></div>I am=
 far from being an expert in C, and I tried to figure out how OpenVPN plugi=
n work by reading previous plugin code.<br>
<br></div>Thank you.<br></div>

--089e013d1c46ebfe5a04f8a0e0d8--

