Date: Thu, 25 Aug 2022 14:49:47 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Ywdv6xgUXl30yyUf@...2685...>
References: <20220822141806.39406-1-frank@...2641...>
MIME-Version: 1.0
In-Reply-To: <20220822141806.39406-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH] t_client.sh: do not require fping6
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

On Mon, Aug 22, 2022 at 04:18:06PM +0200, Frank Lichtenheld wrote:
> fping and fping6 were merged in version 4.0,
> released in 2017. Many recent distributions do
> not include the compatibility symlink anymore.
> 
> So if we find fping but not fping6 do not error
> out but assume that fping is capable of IPv6.
> 
> Signed-off-by: Frank Lichtenheld <frank@...2641...>
> ---
>  tests/t_client.sh.in | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

Note: I think it would be good to apply this to release/2.5 as well
since that would allow us to remove the existing work-arounds from
the worker setup scripts.

There is a trivial conflict due to the TCLIENT_SKIP_RC change. If you
prefer a separate patch, let me know.

Regards,
-- 
  Frank Lichtenheld

