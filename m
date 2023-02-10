Date: Fri, 10 Feb 2023 18:18:58 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y+Z8ggiE4rb4GoRZ@...2685...>
References: <20230210142712.572303-1-arne@...1227...>
 <20230210142712.572303-3-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20230210142712.572303-3-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 1/4] Combine extra_tun/frame parameter
 of frame_calculate_payload_overhead
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, Feb 10, 2023 at 03:27:06PM +0100, Arne Schwabe wrote:
> Instead of passing a value and a bool just pass the value and 0 if
> the caller does not want the value to be added. This also allows
> the function to be used by a function without a frame struct.

Makes sense to me.

Acked-By: Frank Lichtenheld <frank@...2641...>

-- 
  Frank Lichtenheld

