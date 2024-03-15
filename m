Date: Fri, 15 Mar 2024 17:40:02 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZfR54tXN8gxWr4A0@...2685...>
References: <20230830130502.1029-1-sandro.trianni@...277...>
 <20240315162011.1661139-1-frank@...2641...>
MIME-Version: 1.0
In-Reply-To: <20240315162011.1661139-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH v2] Implement server_poll_timeout for
 socks
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

On Fri, Mar 15, 2024 at 05:20:11PM +0100, Frank Lichtenheld wrote:
> From: 5andr0 <sandro.trianni@...277...>
> 
> So far --server-poll-timeout was only applied
> for HTTP proxies, apply it also to SOCKS proxies.
> 
> This removes the default 5 second socks connect timeout
> which can be too small depending on network setup and
> replaces it with the configurable overall connect timeout
> (default 120 seconds).
> 
> Trac: #328
> Change-Id: I2b109f8c551c23045a1be355778b08f0fd4d309f
> Signed-off-by: 5andr0 <sandro.trianni@...277...>
> ---
>  src/openvpn/socket.c |  2 ++
>  src/openvpn/socks.c  | 25 ++++++++++++++-----------
>  src/openvpn/socks.h  |  2 ++
>  3 files changed, 18 insertions(+), 11 deletions(-)
> 
> Trying to move this forward by adding a commit message.

Acked-by: Frank Lichtenheld <frank@...2641...>

Code looks good and I tested build and default t_client tests.
However, not sure how exactly to verify that it actually works.
The SOCKS proxy I have doesn't exhibit any problems even with
--connect-timeout 1.

Any ideas for testing welcome.

Regards,
-- 
  Frank Lichtenheld

