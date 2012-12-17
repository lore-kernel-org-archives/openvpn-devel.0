Message-ID: <1355733093.65651.YahooMailNeo@...1779...>
Date: Mon, 17 Dec 2012 00:31:33 -0800 (PST)
From: ehsan enayati <ehsan_en85@...109...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="406169123-1288634885-1355733093=:65651"
Subject: [Openvpn-devel] multiple OpenVPN instances on a single tun
Reply-To: ehsan enayati <ehsan_en85@...109...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--406169123-1288634885-1355733093=:65651
Content-Type: text/plain; charset=us-ascii

Hi, 

I need to run multiple instances of OpenVPN server on just one tun device driver (say tun0) all on same subnets. I tried editing the open_tun function in tun.c file, first instance goes well and creates tun0 but when the second one comes along it cannot use tun0 and I get the error "ioctl(TUNSETIFF):
Device or resource busy ". I really need this functionality. Please give me some hints.
Thanks

--406169123-1288634885-1355733093=:65651
Content-Type: text/html; charset=us-ascii

<html><body><div style="color:#000; background-color:#fff; font-family:arial, helvetica, sans-serif;font-size:14pt"><div>Hi, <br></div><div style="color: rgb(0, 0, 0); font-size: 18.6667px; font-family: arial,helvetica,sans-serif; background-color: transparent; font-style: normal;"><span>I need to run multiple instances of OpenVPN server on just one tun device driver (say tun0) all on same subnets. I tried editing the open_tun function in tun.c file, first instance goes well and creates tun0 but when the second one comes along it cannot use tun0 and I get the error </span>"<span><span style="font-size: 18px;"><span><span><span style="font-weight: bold;"><span style="line-height: 115%; font-family: &quot;Calibri&quot;,&quot;sans-serif&quot;;">ioctl(TUNSETIFF):
Device or resource busy</span></span></span></span><span dir="RTL"></span><span dir="RTL" style="line-height: 115%; font-family: &quot;Arial&quot;,&quot;sans-serif&quot;;"><span dir="RTL"></span>
</span></span>". I really need this functionality. Please give me some hints.</span></div><div style="color: rgb(0, 0, 0); font-size: 18px; font-family: &quot;Calibri&quot;,&quot;sans-serif&quot;; background-color: transparent; font-style: normal;"><span><span style="font-family: arial,helvetica,sans-serif;">Thanks</span></span></div></div></body></html>
--406169123-1288634885-1355733093=:65651--

