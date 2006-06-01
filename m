From: Stephen Borrill <netbsd@...640...>
Message-ID: <Pine.NEB.4.61.0606011124370.29663@...641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Inline certs/keys?
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Jun  1 03:32:03 2006
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Could the configuration file format be extended to allow inclusion of 
relevant certs and keys in-line? e.g. instead of "ca ca.crt" and then 
having a separate file, you have something like:

dev tun
proto udp
remote server 1194
ca-inline
-----BEGIN CERTIFICATE-----
[snip]
-----END CERTIFICATE-----
key-inline
-----BEGIN RSA PRIVATE KEY-----
[snip]
-----END RSA PRIVATE KEY-----

This would then allow you to have a single file which is easier to move 
about. Also, this means that you have less problems using a file on 
both Unix and Windows as you don't have issues locating files.

I can see that this breaks the parity between configuration options and 
their command line equivalents, but I think it would be very useful.

-- 
Stephen

