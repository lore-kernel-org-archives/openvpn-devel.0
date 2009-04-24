Date: Fri, 24 Apr 2009 17:13:23 +0400
From: Victor Wagner <vitus@...1066...>
Message-ID: <20090424131323.GB21576@...1066...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Solaris questions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi, all

I've tried to build Solaris OpenVPN packages for various versions of
solaris and encountered some problems, probably related more with TUN
driver, than with openvpn itself

I'm using openvpn 2.1rc15 and tun driver 1.1 as recommended on
openvpn.net site.

1. Openvpn is unable to close tun interface, if daemon is not running
with root priveleges. with increased debug level it reports "not owner".

2. I was unable to run two openvpn daemons at once. First one starts,
and second is unable to open another tun interface.

These problems was experienced on Solaris 10 intel both with 32-bit and
64-bit (amd64) kernel, and Solaris 10 sparc, 64-bit kernel.

Is this known issue and is there any workarounds/patches

