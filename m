Date: Mon, 4 Jul 2022 10:58:27 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <YsKrs3vb2MlCB27Z@...2678...>
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-17-a@...2181...>
MIME-Version: 1.0
In-Reply-To: <20220624083809.23487-17-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 16/25] GitHub Actions: add Linux DCO
 build (on Ubuntu 20.04)
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

On Fri, Jun 24, 2022 at 10:38:00AM +0200, Antonio Quartulli wrote:
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  .github/workflows/build.yaml | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 

Looks good to me. Also note that this can applied on current master
without waiting for the rest of series, since --enable-dco is already
available.

Acked-By: Frank Lichtenheld <frank@...2641...>

Regards,
-- 
  Frank Lichtenheld

