Date: Wed, 14 Sep 2022 16:03:44 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <YyHfQIvhNIItXw7h@...2685...>
References: <Yx5JdRcEXh2tTqPE@...1296...>
 <20220912091057.752-1-lstipakov@...277...>
MIME-Version: 1.0
In-Reply-To: <20220912091057.752-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] Use DCO on Windows by default
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

On Mon, Sep 12, 2022 at 12:10:57PM +0300, Lev Stipakov wrote:
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

One general question about the patch: Whenever we have
defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)
in the DCO code, couldn't we just remove it completely?
Since this is bascially "every time" anyway, isn't it?

Regards,
-- 
  Frank Lichtenheld

