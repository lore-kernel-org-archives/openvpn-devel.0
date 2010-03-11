From: Stefan Monnier <monnier@...1268...>
Message-ID: <jwvr5nqd7fh.fsf-monnier+inbox@...1269...>
References: <4B9515FF.6000704@...41...>
	<20100308174321.GA25238@...1296...> <4B966A98.4000206@...41...>
	<jwvsk87dlhk.fsf-monnier+inbox@...1269...>
	<4B9907DF.7030609@...1114...>
Date: Thu, 11 Mar 2010 13:55:24 -0500
In-Reply-To: <4B9907DF.7030609@...1114...> (David Sommerseth's message
	of "Thu, 11 Mar 2010 16:10:23 +0100")
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Supporting "route-gateway dhcp" on non-Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, James Yonan <jim@...41...>

>>> Implementing a DHCP client within OpenVPN tends to make this a more
>>> self-contained problem.
>> I don't think OpenVPN should get into the DHCP business.
>> Especially because this is not a problem specific to OpenVPN: the same
>> problem of refreshing DHCP info happens with ethernet and with wifi when
>> you disconnect and reconnect.
> I agree to your points, from a theoretical point of view.  But from a
> practical point of view, I'm not sure how possible it is to find a more
> generic solution which can be used on all *nix based setups.

There is maybe no such generic solution, but every system will have such
a tool, for the reason stated: it's a general problem not specific
to OpenVPN.

> I'm running Fedora 12, and ifplugd is available but not installed.  I
> presume that's because NetworkManager is taking care of everything with
> networking.  In fact, I know that if I manually start dhclient on an
> extra device with NetworkManager, I often experience that NetworkManager
> reclaims control of that device, and it looses its IP address.  In this
> case, I'd say that OpenVPN should integrate against NetworkManager
> instead.  But that's not sustainable either.

NetworkManager is indeed an alternative to ifplugd.
If NetworkManager doesn't know how to do-the-right-thing in this case,
then we should try and fix *that*, rather than implement DHCP in OpenVPN.

> In my point of view, it's more important to find a solution which will
> be easy to maintain in the OpenVPN code and which doesn't give a
> headache to the package maintainers or system admins needing to
> configure OpenVPN.

The least headaches for the distribution maintainers is when each tool
sticks to its particular functionality so you don't get
spurious conflicts (e.g. both OpenVPN and some DHCP client trying to
configure the interface), and you don't get inconsistency where
different configurations are needed for the same problem depending on
which device happens to be used.


        Stefan

