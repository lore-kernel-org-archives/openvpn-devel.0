Date: Wed, 15 Feb 2023 16:19:00 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y+z35O6n0ImtKScr@...2685...>
References: <20230207132026.41580-1-frank@...2641...>
 <20230215150455.45052-1-frank@...2641...>
MIME-Version: 1.0
In-Reply-To: <20230215150455.45052-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH v4] configure: enable DCO by default on
 FreeBSD/Linux
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
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

On Wed, Feb 15, 2023 at 04:04:55PM +0100, Frank Lichtenheld wrote:
> Automatically disabled when
> - iproute2 is enabled
> - libnl-genl is missing on Linux
> - libnv is missing on FreeBSD
> 

NAK, I accidentially based this on v2 instead of v3.

-- 
  Frank Lichtenheld

