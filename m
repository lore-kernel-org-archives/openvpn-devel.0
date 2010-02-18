Date: Thu, 18 Feb 2010 12:35:31 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <1266517597.7800.6@...1207...> (from kop@...1206... on Thu Feb 18
	12:26:37 2010)
Message-Id: <1266518131.7800.7@...1207...>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net

On 02/18/2010 12:26:37 PM, Karl O. Pinc wrote:

> (I seem to recall that bind attempts to rotate the ordering
> of the names, but I can't find any reference to this at a glance
> and could be wrong.)=20=20

Ah, here it is.  Bind9 has a rrset-order directive.  Results can
be fixed, random, or cyclic but fixed is disabled and must be
enabled by compilation directive.

So, unless you're pulling names out of /etc/hosts it's likely
that randomization does nothing.  And if the bind administrator
has gone to the extra work to enable a fixed ordering of
RR records then randomization destroys his work.

The only thing randomization would be good for is when
pulling names out of a hosts file, and even then I'd want
to leave the job to the resolver.  If it's important
to randomize hosts entries then IMO there should
be something in the config file to enable randomization,
and that is probably solving the wrong problem.

Regards,

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


