Date: Tue, 11 Oct 2022 14:36:20 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y0VjRNiJnrchIjr9@...2685...>
References: <YydCIP5l0WwH5OX+@greenie.muc.de>
 <20221011114935.1802202-1-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20221011114935.1802202-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] Change exit notification in P2P to
 be a SIGUSR1 instead of a SIGTERM signal
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, Oct 11, 2022 at 01:49:35PM +0200, Arne Schwabe wrote:
> From the implemention and the fact that it is a an OCC message
> (basically the rudimentary predecessor to control channel),
> this message is very old.
> 
> I think in the past this feature fit nicely to the weird inetd + openvpn mode
> that seems to have far to many hacks still left in our code. With inetd,
> it made sense that the server instance quits if you press C-c on the client.
> 
> In our current state where inetd is no longer supported, this behaviour
> to exit makes little sense and this patch changes the behaviour to SIGUSR1.
> 
> The P2MP mode nees to keep the SIGTERM behaviour to terminate that client
> session, so we use different signals based on the mode.
> 
> Patch v2: use different signals for p2mp and p2p

IMHO the amount of copied code and logic is big enough to warrant moving
it to a shared function.

Regards,
-- 
  Frank Lichtenheld

