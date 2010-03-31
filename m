Message-ID: <20100331230347.1687.qmail@...1287...>
Date: Thu, 1 Apr 2010 01:03:46 +0200
From: Peter Stuge <peter@...1287...>
References: <cover.1270060247.git.fabian.knittel@...1338...>
	<70dd1e1441bb32df36f449920384f20a3683a2f0.1270060247.git.fabian.knittel@...1338...>
MIME-Version: 1.0
In-Reply-To: <70dd1e1441bb32df36f449920384f20a3683a2f0.1270060247.git.fabian.knittel@...1338...>
Subject: Re: [Openvpn-devel] [PATCH 3/9] vlan: Add per-client
	--vlan-tag	option
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
> +	  if (options->vlan_tag < OPENVPN_8021Q_MIN_VID || options->vlan_tag > OPENVPN_8021Q_MAX_VID)
..
> +#define OPENVPN_8021Q_MIN_VID 1

This looks like --vlan-tag 0 will not work.


> +#define OPENVPN_8021Q_MAX_VID 0xFFFE

The max VID in 802.1q is 4095 = 0xfff.


//Peter

