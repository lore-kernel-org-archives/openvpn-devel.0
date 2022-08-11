Date: Thu, 11 Aug 2022 11:30:39 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <YvTMP9/QSmBeE5Nf@...2685...>
References: <20220329192934.1415-1-timo@...2669...>
 <20220514103717.235-1-timo@...2669...>
MIME-Version: 1.0
In-Reply-To: <20220514103717.235-1-timo@...2669...>
Subject: Re: [Openvpn-devel] [PATCH v5] platform: Retain CAP_NET_ADMIN when
 dropping privileges
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
To: Timo Rothenpieler <timo@...2669...>
Cc: openvpn-devel@lists.sourceforge.net, David Sommerseth <davids@...515...>

On Sat, May 14, 2022 at 12:37:17PM +0200, Timo Rothenpieler wrote:
> On Linux, when dropping privileges, interaction with
> the network configuration, such as tearing down routes
> or ovpn-dco interfaces will fail when --user/--group are
> used.
> 
> This patch sets the CAP_NET_ADMIN capability, which grants
> the needed privileges during the lifetime of the OpenVPN
> process when dropping root privileges.
> 
> Signed-off-by: Timo Rothenpieler <timo@...2669...>
> Reviewed-By: David Sommerseth <davids@...515...>
> ---
>  configure.ac                              |  19 +++
>  distro/systemd/openvpn-client@...2221... |   2 +-
>  distro/systemd/openvpn-server@...2221... |   2 +-
>  src/openvpn/init.c                        |   5 +-
>  src/openvpn/platform.c                    | 146 +++++++++++++++++++++-
>  src/openvpn/platform.h                    |  10 +-
>  6 files changed, 175 insertions(+), 9 deletions(-)


I ran several t_client test runs with --user nobody on a DCO-enabled system.

Without the patch:
 - errors on teardown in all tests (sitnl)
 - test 11 fails (which actually uses DCO, since no comp)

With the patch:
 - errors on teardown gone
 - test 11 passes

With the patch and --disable-dco --enable-iproute2:
 - no cap retained
 - errors on teardown (ip)

Looks to me like it does what it is supposed to do.

Acked-By: Frank Lichtenheld <frank@...2641...>

That said, maybe we should add some hint about this
behavior to the actual documentation? Maybe to
--user documentation? Or at least Changes?

Regards,
-- 
  Frank Lichtenheld

