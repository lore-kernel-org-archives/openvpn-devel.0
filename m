Date: Mon, 25 Jul 2022 14:02:00 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Yt6GONS1kHbA0dFX@...2678...>
References: <20220607093619.23066-1-gert@...1296...>
 <20220723121909.21943-1-gert@...1296...>
MIME-Version: 1.0
In-Reply-To: <20220723121909.21943-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] Fix error message about extended
 errors for IPv4-only sockets.
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

On Sat, Jul 23, 2022 at 02:19:09PM +0200, Gert Doering wrote:
> The new code to enable IPv6 extended error reporting will cause
> an error ("Protocol not available (errno=92)") if trying to enable
> that setsockopt() option on an IPv4-only socket.
> 
> Fix: pass sock->info.af to set_sock_extended_error_passing(), only
> apply to AF_INET6 sockets.
> 
> To make that work, ensure that sock->info.af is set to not only
> the value coming from config (which might be AF_UNSPEC) but to the
> actual value used in socket creation (credits: Arne Schwabe).
> 
> Add comments to make explicit that the asymmetry here (IPv4 extended
> socket error reporting is enabled on all sockets) is intentional.
> 
> Signed-off-by: Gert Doering <gert@...1296...>

Acked-By: Frank Lichtenheld <frank@...2641...>

Tested that it indeed removes the spurious error.
Code changes look good to me.

Regards,
-- 
  Frank Lichtenheld

