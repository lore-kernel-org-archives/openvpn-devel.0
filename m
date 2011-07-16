Date: Sat, 16 Jul 2011 03:59:45 -0700
From: lancebaynes87 <lancebaynes87@...1486...>
Message-ID: <131329a1c4e.-7251372065913038672.6406239187025865679@...1486...>
In-Reply-To: <20110716100908.GX8496@...1296...>
References: <1312f1908b4.-8162753897021314559.8311264442879771774@...1486...>
	<1313210dc57.-2479533967587045360.2173550128923027198@...1486...>
	<13132141bbe.-6554633753716236145.-6995683147743455020@...1486...>
	<20110716100908.GX8496@...1296...>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_2147_380756783.1310813985868"
Subject: Re: [Openvpn-devel] Fwd: Re: OpenVPN on OpenWrt
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

------=_Part_2147_380756783.1310813985868
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

yes, really sorry for posting to the devel-list, I already posted on the users+forum.

So the problem is at:

/etc/openvpn/server.conf

in the: 

server 192.168.80.0 255.255.255.0

line! wow! :) thx. ehhh.... what should I write to get it work? :O
Thank you!

---- On Sat, 16 Jul 2011 03:09:08 -0700 Gert Doering &lt;gert@...1296...&gt; wrote ---- 


Hi, 
 
On Sat, Jul 16, 2011 at 01:33:23AM -0700, lancebaynes87 wrote: 
&gt; Where can I ask a question regarding OpenVPN? 
 
openvpn-users would be better suited for user questions... or the 
openvpn forum (https://forums.openvpn.net/) 
 
&gt; Did I found a bug, or what? 
&gt; 
&gt; Here: 
&gt; http://unix.stackexchange.com/questions/16412/openvpn-on-openwrt 
 
Well, it's telling you where the problem is coming from: 
 
Sat Jul 9 13:14:21 2011 WARNING: potential route subnet conflict between local LAN [192.168.80.0/255.255.255.0] and remote VPN [192.168.80.1/255.255.255.255] 
 
don't use the same network for the LAN on the client side and the VPN 
addresses ("server ..." in the openvpn server config). 
 
gert 
-- 
USENET is *not* the non-clickable part of WWW! 
 //www.muc.de/~gert/ 
Gert Doering - Munich, Germany gert@...1296... 
fax: +49-89-35655025 gert@...1297... 


------=_Part_2147_380756783.1310813985868
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"><html><head>=
<meta content=3D"text/html;charset=3DUTF-8" http-equiv=3D"Content-Type"></h=
ead><body ><span style=3D"font-family: Verdana;">yes, really sorry for post=
ing to the devel-list</span>, I already posted on the users+forum.<br><br>S=
o the problem is at:<br><code><br>/etc/openvpn/server.conf<br><br>in the: <=
br><br></code><pre><code>server 192.168.80.0 255.255.255.0<br><br>line! wow=
! :) thx. ehhh.... what should I write to get it work? :O</code><br></pre>T=
hank you!<br><div id=3D"1"><br>---- On Sat, 16 Jul 2011 03:09:08 -0700 <b>G=
ert Doering &lt;<a href=3D'mailto:gert@...1296...' target=3D'_blank'>gert@...220...=
..1296...</a>&gt;</b> wrote ---- <br></div><br><blockquote style=3D"border-=
left: 1px solid rgb(0, 0, 255); padding-left: 6px;">Hi, <br> <br>On Sat, Ju=
l 16, 2011 at 01:33:23AM -0700, lancebaynes87 wrote: <br>&gt; Where can I a=
sk a question regarding OpenVPN?  <br> <br>openvpn-users would be better su=
ited for user questions...  or the <br>openvpn forum (<a href=3D"https://fo=
rums.openvpn.net/" target=3D"_blank">https://forums.openvpn.net/</a>) <br> =
<br>&gt; Did I found a bug, or what? <br>&gt;  <br>&gt; Here: <br>&gt; <a h=
ref=3D"http://unix.stackexchange.com/questions/16412/openvpn-on-openwrt" ta=
rget=3D"_blank">http://unix.stackexchange.com/questions/16412/openvpn-on-op=
enwrt</a> <br> <br>Well, it's telling you where the problem is coming from:=
 <br> <br>Sat Jul  9 13:14:21 2011 WARNING: potential route subnet conflict=
 between local LAN [192.168.80.0/255.255.255.0] and remote VPN [192.168.80.=
1/255.255.255.255] <br> <br>don't use the same network for the LAN on the c=
lient side and the VPN  <br>addresses ("server ..." in the openvpn server c=
onfig). <br> <br>gert <br>--  <br>USENET is *not* the non-clickable part of=
 WWW! <br>                                                           //www.=
muc.de/~gert/ <br>Gert Doering - Munich, Germany                           =
  <a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a> =
<br>fax: +49-89-35655025                        <a href=3D"mailto:gert@...1386...=
297..." target=3D"_blank">gert@...1297...</a> <br></blockquote><br></body><=
/html>=

------=_Part_2147_380756783.1310813985868--


