From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] RE: [Openvpn-users] OpenVPN w/ TAP device on Linux/FreeBSD
Message-ID: <20021201041724.GE31028@...33...>
References: <111C7A5AB1BCD411918A000103212474FF895C@...56...> <200211272133.gARLX8f14794@...41...>
Mime-Version: 1.0
In-Reply-To: <200211272133.gARLX8f14794@...41...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sat Nov 30 20:18:01 2002
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Wed, 27 Nov 2002, James Yonan wrote:

> Given that this assumption is flawed, it is probably necessary to add a new 
> variable which I am calling tun_mtu_extra which is the maximum number of 
> bytes in excess of the MTU size that a TUN/TAP device might return in a read 
> operation.
> 
> I've put together a new beta of OpenVPN which allows this parameter to be 
> set using a new --tun-mtu-extra option.
> 
> In my testing, --tun-mtu-extra 64 worked fine with a wide range of MTU sizes 
> on TAP devices.
> 
> The tarball is here (also on CVS):
> 
> http://openvpn.sourceforge.net/beta/openvpn-1.3.2.2.tar.gz
> 
> Zhen, let me know if it works for you.
> 
> Also, for other OpenVPN developers, is this the right solution?  It seems 
> like a bit of a kludge, though it also seems like a bug that a TAP device 
> would expect a reader to accomodate a read greater than its MTU size.  If it 
> is the right solution, should it be defaulted to some reasonably 
> conservative value and hidden under the hood, or should it be exposed as an 
> option (as I have done) to potentially confuse and/or empower end-users?
> 
> Comments?

Warning: I haven't followed the openvpn-users thread.

What do the maintainers of the TUN and TAP drivers have to say? Did you
ask them? They might have an explanation or fix a driver bug or two.

