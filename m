From: JuanJo Ciarlante <jjo-ipsec@...283...>
Subject: Re: [Openvpn-devel] [PATCH] UDPv6 support  (UDP/IPv6)
Message-ID: <20040924092438.N12953@...283...>
References: <20040924023235.M12953@...283...> <20040924083959.GB11256@...33...>
Mime-Version: 1.0
In-Reply-To: <20040924083959.GB11256@...33...>; from ma+ovpnd@...31... on Fri, Sep 24, 2004 at 10:39:59AM +0200
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
Date: Fri Sep 24 05:29:33 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Fri, Sep 24, 2004 at 10:39:59AM +0200, Matthias Andree wrote:
> On Fri, 24 Sep 2004, JuanJo Ciarlante wrote:
> 
> > This README covers UDP/IPv6 ( --udp6 ) support for openvpn-2.0_beta11
> > Also, with address family "generalization" changes came local AF_UNIX socket
> > support.
> 
> Is there a use for AF_UNIX in a VPN driver?

It stated in README file.. it allows the creation of local specialized
proxys that can  take full advantage of POSIX fileystem perm. semantics.

Currently I;'m working on a Jabber one 8))
regards...

-- 
--Juanjo

#  Juan Jose Ciarlante (JuanJo) jjo ;at; mendoza.gov.ar                     #
#  GnuPG Public Key: gpg --keyserver wwwkeys.eu.pgp.net --recv-key 66727177 #
#   Key fingerprint: 0D2F 3E5D 8B5C 729E 0560  F453 A3F7 E249 6672 7177     #

