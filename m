From: Stefan Monnier <monnier@...1282...>
Message-ID: <jwv8wd8g722.fsf-monnier+inbox@...1269...>
References: <1260552743.31755.0@...1207...> <4B22D2C8.5020703@...41...>
Date: Fri, 11 Dec 2009 23:22:00 -0500
In-Reply-To: <4B22D2C8.5020703@...41...> (James Yonan's message of "Fri, 11
	Dec 2009 16:16:24 -0700")
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN project organization
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
To: James Yonan <jim@...41...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

> One the one hand people expect OpenVPN to be rock-solid in both 
> stability and security.  In order to maintain this standard of quality, 
> there needs to be a rigorous process of patch vetting.  On the other 
> hand, as an open source project, OpenVPN needs to be transparent and 
> open to contributions from the community.

That misses the main issue: you can reject most patches on some
stability ground, but then as a contributor I'd like to know how to
improve my patch to make it acceptable.

E.g. my "fqdn route with fqdn's that map to multiple IPs" patch (which
I consider to be a bug-fix rather than a feature addition) has been
somewhat discussed but only w.r.t the functionality, not the actual
code, so I have no idea what I need to do in order to have it
be accepted.  This is frustrating.

This said, as a maintainer of a Free Software package, I am quite aware
that giving responding to all contributions (let alone giving good
feedback) can be challenging.


        Stefan


