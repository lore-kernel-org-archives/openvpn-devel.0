From: JuanJo Ciarlante <jjo-ipsec@...283...>
Subject: Re: [Openvpn-devel] [PATCH] UDPv6 support  (UDP/IPv6)
Message-ID: <20040924124237.A8393@...283...>
References: <20040924023235.M12953@...283...> <20040924083959.GB11256@...33...> <20040924092438.N12953@...283...>
Mime-Version: 1.0
In-Reply-To: <20040924092438.N12953@...283...>; from jjo-ipsec@...283... on Fri, Sep 24, 2004 at 09:24:39AM -0300
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
Date: Fri Sep 24 08:46:13 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Fri, Sep 24, 2004 at 09:24:39AM -0300, JuanJo Ciarlante wrote:
> On Fri, Sep 24, 2004 at 10:39:59AM +0200, Matthias Andree wrote:
> > Is there a use for AF_UNIX in a VPN driver?
> 
> It stated in README file.. it allows the creation of local specialized
> proxys that can  take full advantage of POSIX fileystem perm. semantics.

As a clarification, AF_UNIX gets autoconf'd on sys/un.h presence (every
AF_UNIX src section is #ifdef'd HAVE_SYS_UN_H) , but I'll make it selectable at
configure time.

For IPV6 code, I followed Itojun's guidelines (RFC) , it _should_
compile and work on all platforms [last famous words]; I'll truly
appreciacte feedback on this .


Regards...
-- 
--Juanjo

#  Juan Jose Ciarlante (JuanJo) jjo ;at; mendoza.gov.ar                     #
#  GnuPG Public Key: gpg --keyserver wwwkeys.eu.pgp.net --recv-key 66727177 #
#   Key fingerprint: 0D2F 3E5D 8B5C 729E 0560  F453 A3F7 E249 6672 7177     #

