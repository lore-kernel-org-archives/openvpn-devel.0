Date: Thu, 29 Dec 2022 15:50:44 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y62pRFE0JngItjAt@...2685...>
References: <20221130205718.79765-1-gert@...1296...>
 <20221229072746.19169-1-themiron@...2010...>
 <Y61sCbOfdwICxqpu@...2685...>
MIME-Version: 1.0
In-Reply-To: <Y61sCbOfdwICxqpu@...2685...>
Subject: Re: [Openvpn-devel] [PATCH v15] Add DNS SRV remote host discovery
 support
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
To: Vladislav Grishenko <themiron@...2010...>
Cc: gert@...1296..., openvpn-devel@lists.sourceforge.net

On Thu, Dec 29, 2022 at 11:29:29AM +0100, Frank Lichtenheld wrote:
> On Thu, Dec 29, 2022 at 12:27:46PM +0500, Vladislav Grishenko wrote:
> [...]
> > v15:
> >     rebase to master (Dec 2022)
> >     add optional port argument to --remote and --remote-srv usage message
> >     fix --proto option coexisting with --remote-srv
> >     fix --nobind option coexisting with --remote-srv
> >     fix options postprocess mutation lost in v13/v14
> >     recover --mtu-test handling with --remote-srv
> >     use explicit srv resolve stub for openbsd for the future
> >     fix comments
> 
> I don't really have time today to review this completely, but a quick test
> seems to confirm the issue I identified last time is indeed fixed. Tested
> by replacing --remote in t_client tests 1 and 2 with --remote-srv lichtenheld.net
> 
> SRV setup for lichtenheld.net:
> _openvpn._tcp	60	IN	SRV	0 0 51194 conn-test-server.openvpn.org.
> _openvpn._udp	60	IN	SRV	0 0 51194 conn-test-server.openvpn.org.

Also put this through the buildbot tests. No build/test failures. 

Regards,
-- 
  Frank Lichtenheld

