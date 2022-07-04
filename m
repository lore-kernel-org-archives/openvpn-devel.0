Date: Mon, 4 Jul 2022 10:47:13 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <YsKpEZQTrtuYUoZq@...2678...>
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-18-a@...2181...>
MIME-Version: 1.0
In-Reply-To: <20220624083809.23487-18-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 17/25] tun: extract close_tun_handle
 into its own fucntion and print correct type
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

On Fri, Jun 24, 2022 at 10:38:01AM +0200, Antonio Quartulli wrote:
> From: Arne Schwabe <arne@...1227...>
> 
> This moves closing the tun handle into its own function and also prints
> the adapter type we are operating on, instead hardcoding it to
> tap-windows.
> 
> While at it, set the handle to NULL after closing, to prevent a double
> close due to multiple invocations of this helper.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  src/openvpn/tun.c | 76 ++++++++++++++++++++++++++---------------------
>  1 file changed, 42 insertions(+), 34 deletions(-)

Trivial enough. Also can be applied independently of all changes
before it in the series!

Acked-By: Frank Lichtenheld <frank@...2641...>

Regards,
-- 
  Frank Lichtenheld

