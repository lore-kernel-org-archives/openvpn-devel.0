MIME-Version: 1.0
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 26 Jun 2019 01:48:34 +0500
Message-ID: <CAFHpkQFOUB6hq4rQjCGLvbXprjvUL0aD3y107oYj15t6CSMxTg@...278...>
Content-Type: multipart/alternative; boundary="00000000000009b7d3058c2c0ea1"
Subject: [Openvpn-devel] how to migrate users to "no compression" config
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000009b7d3058c2c0ea1
Content-Type: text/plain; charset="UTF-8"

Hello,

for example, let us imagine we provisioned a lot of users with config files
containing "comp-lzo"
and we want to migrate them to server without compression.

I see two options

1) set up new server (actually, new udp/tcp ports on the same server) and
send new config to users

2) use push "compress empty" (if there's such an option) ?

Thanks,
Ilya Shipitsin

--00000000000009b7d3058c2c0ea1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div><br></div><div>for example, let us i=
magine we provisioned a lot of users with config files containing &quot;com=
p-lzo&quot;</div><div>and we want to migrate them to server without compres=
sion.</div><div><br></div><div>I see two options</div><div><br></div><div>1=
) set up new server (actually, new udp/tcp ports on the same server) and se=
nd new config to users</div><div><br></div><div>2) use push &quot;compress =
empty&quot; (if there&#39;s such an option) ?</div><div><br></div><div>Than=
ks,</div><div>Ilya Shipitsin<br></div></div>

--00000000000009b7d3058c2c0ea1--

