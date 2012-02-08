MIME-Version: 1.0
In-Reply-To: <20120208080953.GS13929@...1296...>
References: <CA+3tv22Xq447J_EXKM4SYP-45V7LN0NJfH6o9skUNPPij3PDuQ@...278...>
	<1CED409804E2164C8104F9E623B08B90129328AD5E@...1436...>
	<20120208080953.GS13929@...1296...>
Date: Wed, 8 Feb 2012 04:16:20 -0800
Message-ID: <CA+3tv2064zxi_v1hJPWaF+bd5FUrXYm+h+qYDnorHz8OrpxyGQ@...278...>
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
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Gert,

On Wed, Feb 8, 2012 at 12:09 AM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Wed, Feb 08, 2012 at 08:39:32AM +0100, Adriaan de Jong wrote:
>> =A0- The ABI expects a two-stage setup process: set up a control
>> channel first for negotiation, then a call VpnService.Builder with
>> the proper routing, DNS, addresses, etc. As far as I've been told
>> by other developers, this is not how OpenVPN currently works.
>
> Unless I misunderstand something, this is *exactly* how OpenVPN works
> on the client side :-) - connect to server, figure out what we need to
> configure, then call init_tun(), add_route() etc. to configure interface
> and routing.
>
> Now, right now there is not a single "setup_stuff()" function but it's
> spread across interface init, interface ifconfig, route addition, etc. -
> but it shouldn't be too hard to build a set of "#ifdef ANDROID" functions
> that just gather this information and then pass it in one go to the API.
>
>> - We would need the management interface to export the routing
>> and network parameters that need to be set, so that a surrounding
>> android app can call the appropriate Java methods.
>
> Which very much sounds like the --service-pipe stuff that Heiko is
> building for Windows. =A0openvpn.exe runs as unprivileged process, and
> when it wants to setup interfaces or routing, messages get sent via
> the service pipe to the (new) openvpn service that does the privileged
> operations.

This sounds like a good way to go. I assume the service pipe can
handle tearing down the tunnel as well.

>> =A0- We would need a call in the management interface allowing the tun i=
nterface to be passed back into OpenVPN.
>
> Can't you just pass "--dev tun4" to OpenVPN? =A0Or do you need to pass a
> file descriptor, handed to you by VpnService, instead of opening the tun
> inside OpenVPN?
>
> Maybe I don't fully understand how that API should be working.

Looks like you need to pass a native fd. OpenVPN would not be able to
open the device itself. There looks to be a chicken and egg problem
here though: the fd is returned by the VpnService.Builder.establish()
method

http://developer.android.com/reference/android/net/VpnService.Builder.html#=
establish()

This needs to happen after a bunch of parameters are already known.
Since OpenVPN would normally take care of negotiating these with the
other end, it would seem that the tunnel fd is not available to
OpenVPN in time to do this. Perhaps the user would have to configure
the route, search domain, IP address and other parameters in advance
of starting the VPN connection. That would suck.

>> None of these problems are impossible to solve, but they would
>> take some refactoring of the OpenVPN main and connection code. Any
>> input would of course be appreciated!
>
> Heiko's new service stuff already solves large parts of this :-)
>
> ... and for the rest, well, we'd need a volunteer that wants to *work* on
> this, not just ask for it... =A0I don't have an Android device (and no
> time) so it wouldn't be me.

I'm raising my hand. This path sounds better than what I thought would
be necessary (writing OpenVPN client implementation in Java). I'm also
asking around here at Google to see if somebody with more experience
with Android is interested in helping out. I'm sure there is
sufficient interest on both sides (Android and OpenVPN) to get
something working. This would make a niche segment of Android users
very happy I'm sure.

> gert

Regards,
James

