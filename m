Date: Mon, 4 Jul 2022 10:29:57 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <YsKlBU1KKqbSE/Ch@...2678...>
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-16-a@...2181...>
MIME-Version: 1.0
In-Reply-To: <20220624083809.23487-16-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 15/25] dco: add documentation for
 ovpn-dco-linux
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, Jun 24, 2022 at 10:37:59AM +0200, Antonio Quartulli wrote:
[...]
> +Current implementation limitations
> +-------------------
> +- --persistent-tun not tested/supported
> +- fallback to non-dco in client mode missing
> +- IPv6 mapped IPv4 addresses need Linux 5.4.189+/5.10.110+/5.12+ to work
> +- Some incompatible options may not properly fallback to non-dco
> +- TCP performance with ovpn-dco can still exhibit bad behaviour and drop to a
> +  few megabits per seconds

Any way of qualifying this? Should one not use TCP mode at all currently? Or is
this rare? Any workarounds?

> +- Not all incompatible options are currently identified
> +- No per client statistics. Only total statistics available on the interface

Regards,
-- 
  Frank Lichtenheld

