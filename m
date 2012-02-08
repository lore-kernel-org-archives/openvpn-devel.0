MIME-Version: 1.0
In-Reply-To: <CA+3tv2064zxi_v1hJPWaF+bd5FUrXYm+h+qYDnorHz8OrpxyGQ@...278...>
References: <CA+3tv22Xq447J_EXKM4SYP-45V7LN0NJfH6o9skUNPPij3PDuQ@...278...>
	<1CED409804E2164C8104F9E623B08B90129328AD5E@...1436...>
	<20120208080953.GS13929@...1296...>
	<CA+3tv2064zxi_v1hJPWaF+bd5FUrXYm+h+qYDnorHz8OrpxyGQ@...278...>
Date: Wed, 8 Feb 2012 04:47:35 -0800
Message-ID: <CA+3tv20-SBYOaDZG_+DgmVvAgkAYVR=CoWJ_dyzMjf2yFdLMGA@...278...>
From: James Ring <sjr@...1546...>
Subject: Re: [Openvpn-devel] OpenVPN and Android 4.0 VPN API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hey,

On Wed, Feb 8, 2012 at 4:16 AM, James Ring <sjr@...1546...> wrote:
> Looks like you need to pass a native fd. OpenVPN would not be able to
> open the device itself. There looks to be a chicken and egg problem
> here though: the fd is returned by the VpnService.Builder.establish()
> method
>
> http://developer.android.com/reference/android/net/VpnService.Builder.html#establish()
>
> This needs to happen after a bunch of parameters are already known.
> Since OpenVPN would normally take care of negotiating these with the
> other end, it would seem that the tunnel fd is not available to
> OpenVPN in time to do this. Perhaps the user would have to configure
> the route, search domain, IP address and other parameters in advance
> of starting the VPN connection. That would suck.

Perhaps I wrote this too hastily. I wasn't thinking of how OpenVPN
actually works. OpenVPN would:

* open the connection (tcp or udp) to the remote end
* negotiate session parameters
* provide the Android Java wrapper with the session parameters via the
service pipe
* receive the file descriptor to use as the tun/tap device from the
Android Java wrapper via the service pipe

Another thing to think about would be whether the tunnel could be
reestablished after the device wakes up from sleep.

Regards,
James

