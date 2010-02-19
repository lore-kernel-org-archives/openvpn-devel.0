Date: Fri, 19 Feb 2010 09:55:28 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <4B7E8326.9050908@...1032...> (from siim@...1032...
	on Fri Feb 19 06:25:10 2010)
Message-Id: <1266594928.31441.5@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] FQDN for routes should expand to all IPs
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
Content-Disposition: inline
To: Siim =?iso-8859-1?b?UPVkZXI=?= <siim@...1032...>
Cc: openvpn-devel@lists.sourceforge.net

On 02/19/2010 06:25:10 AM, Siim P=F5der wrote:
> Hi
>=20
> Karl O. Pinc wrote:
> > So, unless you're pulling names out of /etc/hosts it's likely
> > that randomization does nothing.  And if the bind administrator
> > has gone to the extra work to enable a fixed ordering of
> > RR records then randomization destroys his work.
>=20
> That's entirely dependent on the DNS server.

Yes, entirely implementation dependent as noted.

> Some DNS servers do not
> randomize the order (so I've heard).
>=20
> Moreover, if you consider that openvpn is mostly used to connect to
> central resources from a random location, you can not assume anything
> about the nameserver(s) you resolve through. Therefore even if you go
> through the trouble of enabling fixed ordering on your DNS, it is
> likely that the (caching) nameservers that the clients resolve=20
> through
> randomize the list sometimes and you will get unpredictable results
> anyway.
>=20
> So IMO it would better to pick at random for load balancing (the case
> when ISP local nameserver caches and respons with a static list) as
> there is no obvious reason for fixed ordering and even if there were,
> it would not work anyway (unless used in a environment entirely under
> your control).

I prefer the "Unix way" where each bit of software does one thing
and does it well.  This is a matter of taste, taste for modularity IMO.
Leaving the choice regarding randomization to the resolver/dns server
keeps the system modular and provides a centralized point of control.
(Some people do have their dns entirely under their control.)

As you point out that there can be a legitimate need for randomization
to provide control over load balancing from within the application.=20=20
If this is an important enough feature then it should be just that,=20
a feature that's dynamically configurable in OpenVPN's config file
and designed to do something specific.  In this case it might,
possibly, make more sense to be able to specify the address pool
within the config file, or pushed to the client in some fashion
(caching between openvpn invocations would obviously be required), etc.
Options regarding randomized choice, cycling, etc. could also be
provided.  One of those options could also be a fixed fallback
sequence, so that instead of load balancing you get failover.
(This is all blue-sky thinking, I've not steeped myself in
OpenVPN enough of late to be sure how any of this would work.)

Implementing randomization as a configurable feature gets
you the best of both worlds.  Somebody other than me needs
to decide if the added feature creep is worth it.

Regards,

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


