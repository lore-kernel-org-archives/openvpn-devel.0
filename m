Message-ID: <4D79ECC4.8010805@...1114...>
Date: Fri, 11 Mar 2011 10:35:00 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <AANLkTi=gX2zHuk40P5RVtM8XmgZCp3V5_o20OeSy80N_@...278...>
	<20110311090414.GE9835@...1296...>
In-Reply-To: <20110311090414.GE9835@...1296...>
Subject: Re: [Openvpn-devel] openvpn protocol breaks proxies intercepting
 SSL ...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Vineet Kumar <vineet.kumar@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/03/11 10:04, Gert Doering wrote:
| Hi,
|
| On Thu, Mar 10, 2011 at 05:04:48PM -0800, Vineet Kumar wrote:
|> Also, doesn't this make openvpn different from other SSL VPNs which
|> advertise the fact that they are truly SSL?
|
| Well, OpenVPN is "truly SSL", but it's not "using https as a browser would
| do to hide the fact that there is a VPN inside"...

Kind of.  Gert is basically correct.  But it is important to understand that
OpenVPN doesn't use the SSL wire protocol directly, like the majority of SSL
applications does.  So all the SSL packets from OpenVPN are encapsulated in a
kind of OpenVPN container.  Which is why some strict proxies or deep packet
inspection firewalls might not allow OpenVPN traffic.

The reason for this is that OpenVPN is primarily written for the UDP protocol.
~ While SSL itself is very TCP oriented.  To my knowledge, there are no UDP
transport support in OpenSSL.  So OpenVPN uses OpenSSL differently,
intercepting the network connections and sending the data through OpenVPN's
own network socket infrastructure.  If OpenVPN's HMAC support (--tls-auth) is
enabled, some extra bytes are added on top of the SSL packet itself.

Of course, it would probably be possible (I have not investigated this) to add
a feature which restricts OpenVPN to use the core SSL protocol, without  this
encapsulation on top of the SSL packets.  However, when such a feature is
enabled, it would restrict the usage of TCP.  In addition, the --tls-auth
feature would not be useful in at all.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk157MQACgkQDC186MBRfrqQdgCdGKarB9OcdlKSQaTxLXZIZnou
qmoAn0G/9cfGHx6+NeWk2v0agOjRJCI9
=SOiC
-----END PGP SIGNATURE-----

