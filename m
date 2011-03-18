Date: Fri, 18 Mar 2011 14:02:26 +0100
From: Thomas Glanzmann <thomas@...1029...>
Message-ID: <20110318130226.GD26254@...1029...>
References: <20110317054155.GA9684@...1029...>
	<201103181331.51247.hhund@...194...>
MIME-Version: 1.0
In-Reply-To: <201103181331.51247.hhund@...194...>
Subject: Re: [Openvpn-devel] OpenVPN GUI and ntlm Proxy password
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Heiko Hund <hhund@...194...>
Cc: openvpn-devel@lists.sourceforge.net, info@...454...

Hello Heiko,

> I fear Mathias is not involved with the OpenVPN GUI since five years or so.
> There's a project on SourceForge now where I forked the GUI and try to improve 
> it: https://sourceforge.net/projects/openvpn-gui/ 

I see. Thanks for putting in the effort.

> Maybe you want to check out the latest snapshot and see if it works
> for you.  The GUI uses the OpenVPN management interface for
> communication and monitoring since a while now. So, there's a fair
> chance it'll work right away or won't be much work to make it work. =)

It did not work, because it couldn't read or write the file

Fri Mar 18 13:56:53 2011 Error opening 'HTTP Proxy' auth file: C:\DOCUME~1\adglth0\LOCALS~1\Temp\openvpn_authfile.: Das System kann die angegebene Datei nicht finden.   (errno=2)

containing the credentials. But the directory exists.

I also saw a few other things that are confusing:

        - The 'About' button mentions GUI version 1.3

        - When using 'Intenet Explorer' to determine the proxy, it
          doesn't work with proxy pac but doesn't mention  it (the
          OpenVPN Gui 1.3 did mention that it doesn't work with proxy
          pacs).

Any ideas to track the problem down. My configuration file is:

client
dev tun
proto tcp
nobind
remote full.qualified.hostname.de 443
resolv-retry infinite
persist-key
persist-tun
ca edge1ca.crt
ns-cert-type server
comp-lzo
verb 3
mute 20
auth-user-pass
tun-mtu 1400
# http-proxy 192.168.1.211 8080 paaf.txt ntlm

Cheers,
        Thomas

