MIME-Version: 1.0
References: <CAGyAFMV=HvOYDRSB7eRpBDp-47wX2vie8JPgp48in1fH+eXn=A@...278...>
 <CAFHpkQFVpN-+Uoc6QsLmD8hjwEC7Ba1Q2SP4SuS_EMu_PT=3nw@...278...>
 <7bdf712d-4e0c-0667-c9eb-1bdd862b1e40@...2080...>
 <bfead88f-3e91-6d49-ea70-e73f626468f1@...1147...>
 <CAGyAFMW10tUVswPa8NfVieUJMm1oX1BFQaa9a0GP3NmgWpRshg@...278...>
In-Reply-To: <CAGyAFMW10tUVswPa8NfVieUJMm1oX1BFQaa9a0GP3NmgWpRshg@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 20 May 2019 15:03:04 +0300
Message-ID: <CAGyAFMWODccNnD+yby7HrOUfdDFaceC3AX70+jG9_hL9vF=q+A@...278...>
Content-Type: multipart/alternative; boundary="0000000000007091790589508456"
Subject: Re: [Openvpn-devel] Wintun performance results
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: David Sommerseth <openvpn@...2080...>, =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, wireguard@...2500...

--0000000000007091790589508456
Content-Type: text/plain; charset="UTF-8"

Hi,

While wintun support is not yet added to openvpn3 master, I think it would
be beneficial to share my own branch.

https://github.com/lstipakov/openvpn3/tree/feature/wintun-wip#building-the-openvpn-3-client-on-windows


See instructions in README on how to build openvpn3 library and test client
on Windows.

Note that only "topology subnet" is supported (see
https://community.openvpn.net/openvpn/wiki/Topology#Topologysubnet).

I have included test client and wintun driver binaries if someone would
like to try it out (Tested on Windows 10 and Windows Server 2016):

1. Since wintun driver is not signed, you need to enable loading of test
signed code. For that, run

> bcdedit /set testsigning

in admin command prompt and restart Windows.

2. Download and unzip wintun driver
https://github.com/lstipakov/openvpn3/blob/feature/wintun-wip/wintun.7z

3. Open Device Manager (Control Panel\System and Security\System\Device
Manager).
Right click on tree root, select "Add legacy hardware" -> "Next" -> "..
hardware that I manually select from a list" ->
"Next" -> "Show all devices" -> "Have Disk..." -> Locate wintun.inf
unpacked at step 2 -> select "Wintun Userspace Tunnel" ->
"Next" -> "Install this software anyway" (since driver is not signed).

4. Make sure you see "Wintun Userspace Tunnel" under Device Manager ->
Network adapters.

5. Download cli_wintun.exe from
https://github.com/lstipakov/openvpn3/blob/feature/wintun-wip/cli_wintun.exe

6. Open command prompt as an administrator and run:

> C:\Users\Administrator\Downloads>cli_wintun.exe <your_vpn_profile.ovpn>

7. Enjoy!

-- 
-Lev

--0000000000007091790589508456
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div><div>While wi=
ntun support is not yet added to openvpn3 master, I think it would be benef=
icial to share my own branch.</div><div><br></div><div><a href=3D"https://g=
ithub.com/lstipakov/openvpn3/tree/feature/wintun-wip#building-the-openvpn-3=
-client-on-windows">https://github.com/lstipakov/openvpn3/tree/feature/wint=
un-wip#building-the-openvpn-3-client-on-windows</a>=C2=A0=C2=A0<br></div><d=
iv><br></div><div>See instructions in README on how to build openvpn3 libra=
ry and test client on Windows.<br></div><div><br></div><div>Note that only =
&quot;topology subnet&quot; is supported (see=C2=A0<a href=3D"https://commu=
nity.openvpn.net/openvpn/wiki/Topology#Topologysubnet">https://community.op=
envpn.net/openvpn/wiki/Topology#Topologysubnet</a>).</div><div><br></div><d=
iv>I have included test client and wintun driver binaries if someone would =
like to try it out (Tested on Windows 10 and Windows Server 2016):</div><di=
v><br></div><div>1. Since wintun driver is not signed, you need to enable l=
oading of test signed code. For that, run</div><div><br></div><div>&gt;=C2=
=A0bcdedit /set testsigning</div><div><br></div><div>in admin command promp=
t and restart Windows.</div><div><br></div><div>2. Download and unzip wintu=
n driver=C2=A0<a href=3D"https://github.com/lstipakov/openvpn3/blob/feature=
/wintun-wip/wintun.7z">https://github.com/lstipakov/openvpn3/blob/feature/w=
intun-wip/wintun.7z</a></div><div><br></div><div>3. Open Device Manager (Co=
ntrol Panel\System and Security\System\Device Manager).=C2=A0</div><div>Rig=
ht click on tree root, select &quot;Add legacy hardware&quot; -&gt; &quot;N=
ext&quot; -&gt; &quot;.. hardware that I manually select from a list&quot; =
-&gt;=C2=A0</div><div>&quot;Next&quot; -&gt; &quot;Show all devices&quot; -=
&gt; &quot;Have Disk...&quot; -&gt; Locate wintun.inf unpacked at step 2 -&=
gt; select &quot;Wintun Userspace Tunnel&quot; -&gt;</div><div>&quot;Next&q=
uot; -&gt; &quot;Install this software anyway&quot; (since driver is not si=
gned).</div><div><br></div><div>4. Make sure you see &quot;Wintun Userspace=
 Tunnel&quot; under Device Manager -&gt; Network adapters.</div><div><br></=
div><div>5. Download cli_wintun.exe from <a href=3D"https://github.com/lsti=
pakov/openvpn3/blob/feature/wintun-wip/cli_wintun.exe">https://github.com/l=
stipakov/openvpn3/blob/feature/wintun-wip/cli_wintun.exe</a></div><div><br>=
</div><div>6. Open command prompt as an administrator and run:</div><div><b=
r></div><div>&gt; C:\Users\Administrator\Downloads&gt;cli_wintun.exe &lt;yo=
ur_vpn_profile.ovpn&gt;<br></div><div><br></div><div>7. Enjoy!</div></div><=
/div></div></div></div></div><div><br></div>-- <br><div dir=3D"ltr" class=
=3D"gmail_signature">-Lev</div></div>

--0000000000007091790589508456--

