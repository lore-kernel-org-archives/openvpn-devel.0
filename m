Subject: Re: [Openvpn-devel] key management ?
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1081462087.95165@...41...>
In-Reply-To: <20040408043145.35799.qmail@...197...>
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
Date: Thu Apr  8 15:08:03 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: gary ng <garyng2000@...109...>, openvpn-devel@lists.sourceforge.net

gary ng <garyng2000@...109...> said:

> Hi,
> 
> Openvpn is moving nicely in feature for large scale
> deployment.
> 
> I am wondering if there is already plan to make the
> key management more suitable for this kind of
> deployment.
> 
> AFAIK, currently the cert can only be signed by one
> root CA. However, this is usually not how these public
> key based authentication is used in corporations(based
> on my experienced with Lotus Notes). Usually, the root
> CA of an organisation is well guarded and is only used
> to sign intermediate CAs(can be multiple level) which
> are then delegated for actual end node cert signing.
> This has the advantage that if certain CAs are
> compromised, they can be moved to CRL making any
> future cert signed by then being rejected. This is
> also useful for inter-organisational situation when
> such confidential communication is necessary. 

OpenVPN currently supports intermediate CAs (one or multiple levels).

> Another nice to have feature is to associate(or limit)
> the remote IPs based on certificates. 

This is possible using the --tls-verify script which can examine the IP
address and x509 name of an incoming cert and decide whether or not to accept it.

Some people even use this capability to do an nmap on the IP address to make
sure the client hasn't been compromised, before allowing the connection.

James


