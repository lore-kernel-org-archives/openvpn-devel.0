Date: Thu, 17 Mar 2011 06:41:55 +0100
From: Thomas Glanzmann <thomas@...1029...>
Message-ID: <20110317054155.GA9684@...1029...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN GUI and ntlm Proxy password
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
To: info@...454...
Cc: openvpn devel <openvpn-devel@lists.sourceforge.net>

Hello Mathias,
I would like to use you OpenVPN GUI for Windows to authenticate over an
NTLM proxy in Windows and wonder if you're thinking about asking and
supplying the password for NTLM-proxy authentication or planing on doing
so.

The very recent versions of (2.2.x) of OpenVPN support not only basic
authentcation but in addition NTLM authentication which is necessary to
connect via an ISA proxy, when creating a config file for Windows GUI it
was possible to specify the proxy password but it tried to
authentication using basic authentication which was disabled in the ISA
proxy for security reasons.

Example config:

client
dev tun
proto tcp
nobind
remote edge1.glanzmann.de 443
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
http-proxy 192.168.1.211 8080 credentials.txt ntlm

In the last line you see the changes. There is an ntlm at the end and a file (I
think you already have that with username and password in it).

From the OpenVPN Man page:

-http-proxy server port [authfile|'auto'|'auto-nct'] [auth-method]
Connect to remote host through an HTTP proxy at address server and port port.
If HTTP Proxy-Authenticate is required, authfile is a file containing a
username and password on 2 lines, or "stdin" to prompt from console.

auth-method should be one of "none", "basic", or "ntlm".

HTTP Digest authentication is supported as well, but only via the auto or
auto-nct flags (below).

The auto flag causes OpenVPN to automatically determine the auth-method and
query stdin or the management interface for username/password credentials, if
required. This flag exists on OpenVPN 2.1 or higher.

The auto-nct flag (no clear-text auth) instructs OpenVPN to automatically
determine the authentication method, but to reject weak authentication
protocols such as HTTP Basic Authentication.

Source: http://www.openvpn.net/index.php/open-source/documentation/manuals/427-openvpn-22.html

Maybe you could add a checkbox which lets a user choose between none, basic,
ntlm, auto, or auto-nct authentication.

Cheers,
        Thomas

