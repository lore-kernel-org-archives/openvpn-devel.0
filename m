Message-ID: <20100331231158.2782.qmail@...1287...>
Date: Thu, 1 Apr 2010 01:11:58 +0200
From: Peter Stuge <peter@...1287...>
References: <cover.1270060247.git.fabian.knittel@...1338...>
	<1ae7a5fdae1e6d71bb7708a4f75ff060e3237c1c.1270060247.git.fabian.knittel@...1338...>
MIME-Version: 1.0
In-Reply-To: <1ae7a5fdae1e6d71bb7708a4f75ff060e3237c1c.1270060247.git.fabian.knittel@...1338...>
Subject: Re: [Openvpn-devel] [PATCH 4/9] vlan: Prepend and remove
	VLAN	identifiers on outgoing and incoming frames
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
To: openvpn-devel@lists.sourceforge.net

Fabian Knittel wrote:
> +  if (ntohs (vlanhdr.tpid) != OPENVPN_ETH_P_8021Q)
> +    {
> +      /* Drop untagged frames */
> +      goto err;
> +    }

It would be nice to be able to use VID 0 to mean untagged packets.


//Peter

