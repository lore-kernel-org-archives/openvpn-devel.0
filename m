From: JuanJo Ciarlante <jjo-ipsec@...283...>
Subject: Re: [Openvpn-devel] [PATCH] UDPv6 support  (UDP/IPv6)
Message-ID: <20040924170928.B8393@...283...>
References: <20040924023235.M12953@...283...> <Pine.LNX.4.58.0409241345300.26514@...269...>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.58.0409241345300.26514@...269...>; from jim@...41... on Fri, Sep 24, 2004 at 01:50:07PM -0600
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
Date: Fri Sep 24 13:12:13 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Fri, Sep 24, 2004 at 01:50:07PM -0600, James Yonan wrote:
> Juanjo,
> 
> Great work on the IPv6 support!

Thanks, Jim ...

> I see there are still a few TODO items,

Indeed, some of them may require code flow changes, mainly because of:
DNS may return A or AAAA records,  iff we _require_ to specify --udp|--udp6 (which
I think is wise given you DO know/coordinate you r peer's setup), these "ambiguities" 
disappear.

> and of course the OpenVPN project itself is in the transition zone between
> the end of the 2.0 beta series and the start of 2.0 release candidates, so
> I think it would make sense to hold off on merging your contribution until
> after 2.0 final is released.

Agreed.

I've finished ./configure [ --disable-ipv6] [ --enable-unix-sockets ];
tested compilation for the 4 combinations, and testbed runs too.
Expect new patch for tomorrow

Regards..

-- 
--Juanjo

#  Juan Jose Ciarlante (JuanJo) jjo ;at; mendoza.gov.ar                     #
#  GnuPG Public Key: gpg --keyserver wwwkeys.eu.pgp.net --recv-key 66727177 #
#   Key fingerprint: 0D2F 3E5D 8B5C 729E 0560  F453 A3F7 E249 6672 7177     #

