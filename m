From: JuanJo Ciarlante <jjo-ipsec@...283...>
Subject: Re: [Openvpn-devel] [PATCH] UDPv6 support  (UDP/IPv6)
Message-ID: <20040925130705.E8393@...283...>
References: <20040924023235.M12953@...283...> <Pine.LNX.4.58.0409241345300.26514@...269...> <20040924170928.B8393@...283...>
Mime-Version: 1.0
In-Reply-To: <20040924170928.B8393@...283...>; from jjo-ipsec@...283... on Fri, Sep 24, 2004 at 05:09:28PM -0300
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
Date: Sat Sep 25 09:13:18 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Fri, Sep 24, 2004 at 05:09:28PM -0300, JuanJo Ciarlante wrote:
> 
> I've finished ./configure [ --disable-ipv6] [ --enable-unix-sockets ];
> tested compilation for the 4 combinations, and testbed runs too.
> Expect new patch for tomorrow

Done.

CHANGES.IPv6 excerpt:

* v0.2.2
  - IPv6, unix-socket support selectable at configure-time (all 4 combinations tested)
    ./configure --disable-ipv6        (enabled by default)
    ./configure --enable-unix-sockets (disabled by default)
    (internal) USE_PF_INET6, USE_PF_UNIX from autoconf
  - Change PROTO_x from #define to enum, to allow easier/cleanersupport for
    optional protocols
  - Added IPV6_xxxx_HEADER_SIZE
      
Available (GPL) at
  http://www.irrigacion.gov.ar/juanjo/openvpn/

Regards ..

--
--Juanjo

#  Juan Jose Ciarlante (JuanJo) jjo ;at; mendoza.gov.ar                     #
#  GnuPG Public Key: gpg --keyserver wwwkeys.eu.pgp.net --recv-key 66727177 #
#   Key fingerprint: 0D2F 3E5D 8B5C 729E 0560  F453 A3F7 E249 6672 7177     #

