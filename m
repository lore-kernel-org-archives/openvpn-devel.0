Date: Tue, 20 Sep 2022 13:07:31 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Yyme87V7yRotruuG@...2678...>
References: <300C4042-73A3-4B19-8CE1-F55E30873C37@...277...>
 <20220830104958.91-1-lstipakov@...277...>
MIME-Version: 1.0
In-Reply-To: <20220830104958.91-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] dco-win: support for --persist-tun
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

On Tue, Aug 30, 2022 at 01:49:58PM +0300, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
> 
> Since version 0.8.0, dco-win driver added support for
> DEL_PEER command, which enabled --persist-tun
> implementation on client side.
> 
> Add real implementation for dco_del_peer on Windows,
> which calls DEL_PEER, which clears peer state
> on the driver without tearing tunnel down.
> 
> When pulled options are changed on restart,
> we need to close and reopen tun device. This
> is not yes supported for dco-win, so we close
> tun and trigger reconnect.

Code looks good to me. And I have lightly tested it against
my AS with a MSI provided by Lev.

One thing of note is that I first tried to test it
with a new openvpn binary against a slightly older driver
and that sent openvpn into a restart loop where the
NEW_PEER call failed but then it just tried it again.

Would it be a good idea (and possible) to improve the
error handling in a way that if the soft-restart fails it
instead tries a hard-restart?

Anyway, since I do not think this specific problem is caused
by this patch:

Acked-By: Frank Lichtenheld <frank@...2641...>

Regards,
-- 
  Frank Lichtenheld

