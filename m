Date: Wed, 10 Jul 2024 16:13:32 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Zo6XDNcBacVz00PU@...2685...>
References: <gerrit.1720433364000.I47c992b6b73b1475cbff8a28f720cf50dc1fbe3e@...2715...>
 <20240710140623.172829-1-frank@...2641...>
MIME-Version: 1.0
In-Reply-To: <20240710140623.172829-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH v4] Allow trailing \r and \n in control
 channel message
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

On Wed, Jul 10, 2024 at 04:06:23PM +0200, Frank Lichtenheld wrote:
> From: Arne Schwabe <arne@...1227...>
> 
> Writing a reason from a script will easily end up adding extra \r\n characters
> at the end of the reason. Our current code pushes this to the peer. So be more
> liberal in accepting these message.
> 
> Closes openvpn/openvpn#568
> 
> Change-Id: I47c992b6b73b1475cbff8a28f720cf50dc1fbe3e
> Signed-off-by: Arne Schwabe <arne@...1227...>
> Acked-by: Frank Lichtenheld <frank@...2641...>
> ---
> 
> This change was reviewed on Gerrit and approved by at least one
> developer. I request to merge it to master.
> 
> Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/672
> This mail reflects revision 4 of this Change.
> 
> Acked-by according to Gerrit (reflected above):
> Frank Lichtenheld <frank@...2641...>

Merge notes: Applies cleanly to release/2.6, does NOT apply to
release/2.5 at all (due to ssl_pkt.c and test_pkt.c not existing).

At least OpenVPN-NL and EPEL9 will want this patch in 2.5 (and
potentially some other distros as well). Unless someone else
volunteers I can provide the backport once we have
merged in release/2.6. Probably enough to move the function
to forward.c and skip the UT.

Regards,
-- 
  Frank Lichtenheld

