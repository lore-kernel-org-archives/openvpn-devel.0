Date: Thu, 18 Feb 2010 12:26:37 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <4B7D4AC1.7010808@...1114...> (from
	openvpn.list@...1114... on Thu Feb 18 08:12:17 2010)
Message-Id: <1266517597.7800.6@...1207...>
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

On 02/18/2010 08:12:17 AM, David Sommerseth wrote:
> On 18/02/10 13:53, Gert Doering wrote:

> >> * usage of get_random in getaddr() [socket.c:261]
> >>
> >> I admit I should have spotted this one on the first review.=20
> Because
> >> this code snippet below looks really odd to me.
> >>
> >>   if (nb > 1)
> >>     {
> >>       msg (D_RESOLVE_ERRORS, "RESOLVE: NOTE: %s resolves to %d
> >> 			      addresses, choosing one at random",
> >> 	   hostname,
> >> 	   nb);
> >>       return ips[get_random () % nb];
> >>     }
> >>
> >>
> >> Why on earth do you want to use get_random() in this situation?
> >
> > That's original OpenVPN code, just moved to a different place.
>=20
> > While I am not saying that it should be that way, or should not be
> that
> > way, it's not something brought in by the patch in question, so
> should
> > not be covered by its review.
>=20
> Agreed.  Lets hear with James today if he see any reasons for using
> get_random() in this situation.  It really do not see any advantage=20
> of
> this at all.

FWIW RFC 1034 (DOMAIN NAMES - CONCEPTS AND FACILITIES
http://www.rfc-editor.org/rfc/rfc1034.txt) seems to imply that
this sort of munging is appropriate in a resolver.  In any
case the ordering of the results when multiple A records are
returned seems to be entirely up to the DNS implementation.
(I seem to recall that bind attempts to rotate the ordering
of the names, but I can't find any reference to this at a glance
and could be wrong.)  The choice to randomize seems wrong
because it will destroy anything "smart" that the resolver
might do.

--------------<snip>------------------
5.2. Client-resolver interface

5.2.1. Typical functions

The client interface to the resolver is influenced by the local host's
conventions, but the typical resolver-client interface has three
functions:

   1. Host name to host address translation.

      This function is often defined to mimic a previous HOSTS.TXT
      based function.  Given a character string, the caller wants
      one or more 32 bit IP addresses.  Under the DNS, it
      translates into a request for type A RRs.  Since the DNS does
      not preserve the order of RRs, this function may choose to
      sort the returned addresses or select the "best" address if
      the service returns only one choice to the client.  Note that
      a multiple address return is recommended, but a single
      address may be the only way to emulate prior HOSTS.TXT
      services.


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


