Date: Thu, 15 Sep 2022 14:11:34 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <YyMWdu62poH3cCOs@...2678...>
References: <YyL9Eu3Q3m4fDmmL@...2678...>
 <20220915104028.188-1-lstipakov@...277...>
MIME-Version: 1.0
In-Reply-To: <20220915104028.188-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v4] Use DCO on Windows by default
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

On Thu, Sep 15, 2022 at 01:40:28PM +0300, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
> 
> On startup, check following conditions:
> 
>  - ovpn-dco-win driver is installed. Perform this check
> by trying to open adapter by symbolic name.
> 
>  - options are compatible with dco. Same checks as on
> Linux and FreeBSD. In addition, check that --mode server
> is not used and --windows-driver is not set to tap-windows6/wintun.
> 
> If both checks are passed, use DCO.
> 
> Move options_postprocess_mutate_invariant() call
> below since it depends on selected windows driver.
> 
> dco_check_option() has side effect on Windows -
> if dco is not used, it might complain "cipher chachapoly
> not supported by dco, disabling dco" if chachapoly
> support is missing system-wide. To not to see this,
> check dco options only if dco is enabled. This means
> moving dco_enabled() from dco_check_startup_option()
> to one level above. We do similar thing in
> multi_connection_established() before checking ccd options.
> 
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
> 
> v4:
>  - simplify #ifdef in usage_message() in options.c
>  - simplify #ifdef in show_settings() in options.c

Code looks good to me. Also lightly tested it with
.exe from https://github.com/lstipakov/openvpn/actions/runs/3060106587:
- ovpn-dco is used by default
- when persist-tun is set, falls back to tap-windows6
- when windows-driver tap-windows6 is set, uses that

Acked-by: Frank Lichtenheld <frank@...2641...>

Regards,
-- 
  Frank Lichtenheld

