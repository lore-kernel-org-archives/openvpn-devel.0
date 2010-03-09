From: Stefan Monnier <monnier@...1282...>
Message-ID: <jwvaauhb33h.fsf-monnier+inbox@...1269...>
References: <1268151370.24740.3@...1207...>
Date: Tue, 09 Mar 2010 16:26:58 -0500
In-Reply-To: <1268151370.24740.3@...1207...> (Karl O. Pinc's message of "Tue, 09 Mar
	2010 10:16:10 -0600")
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
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net, Peter Stuge <peter@...1287...>

> My understanding of dhcp is that the client is supposed to 
> automatically reconfigure on lease expiration

Yes.

> or whenever the link goes up and down.

Not necessarily, and that's the problem.

> I suppose it's possible that there are dhcp clients
> that exit when the link goes down and must be restarted
> but I don't know of any.

No, but many don't do anything when the link goes down or when the link
comes back up.  They only do something when the lease needs to
be refreshed.
That's why we have things like ifplugd.


        Stefan

