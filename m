Date: Wed, 29 Feb 2012 20:18:00 +0100
From: =?iso-8859-15?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Message-ID: <1787326494.20120229201800@...449...>
In-Reply-To: <1957833067.20120229194040@...449...>
References: <4F4CE4FE.3010009@...515...> <3440230.bBsdCSzEj1@...1526...>
	<1375292789.20120229123817@...449...> <7855235.EvfmKnZP6h@...1526...>
	<CAP+U6t+ZUA3UpYfKms0Qr=-Cn1M-GP1EJtGybG0+j+O2xnfv7g@...278...>
	<1957833067.20120229194040@...449...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
Reply-To: =?iso-8859-15?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: =?iso-8859-15?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hello,

> If openvpn.exe startet in users context the user can manipulate it in
> ram arbitrarily.

Example:
http://blog.didierstevens.com/2009/06/25/bpmtk-injecting-vbscript/
(great blog about process manipulation :-) )

I think there is absolutly no benefit from starting openvpn.exe in
user context via service.

greetings
Carsten


