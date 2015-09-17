Date: Thu, 17 Sep 2015 19:19:34 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150917171933.GP34798@...1296...>
References: <1441985627-14822-1-git-send-email-gert@...1296...>
	<1441985627-14822-6-git-send-email-gert@...1296...>
	<55F7E8CC.8000908@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zpKbRLlnGgG674Bt"
Content-Disposition: inline
In-Reply-To: <55F7E8CC.8000908@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 05/10] get_default_gateway_ipv6(): Linux
 / Netlink implementation.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--zpKbRLlnGgG674Bt
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

thanks for your review.  Some comments before I go committing :-)

On Tue, Sep 15, 2015 at 10:45:48AM +0100, Arne Schwabe wrote:
>=20
> +    CLEAR(rtreq);
> +    rtreq.nh.nlmsg_type =3D RTM_GETROUTE;
> +    rtreq.nh.nlmsg_flags =3D NLM_F_REQUEST;			/* XXX */
>=20
> There should an indication why this is XXX, some kind of comment.

Thanks.  This is indeed a leftover.  I copied that code from=20

http://www.virtualbox.org/svn/vbox/trunk/src/VBox/NetworkServices/NAT/rtmon=
_linux.c

which uses NLM_F_REQUEST | NLM_F_ROOT here, and the "XXX" was a reminder
for myself to figure out which is the right thing to do.

netlink(7) documents this field as:

       Standard flag bits in nlmsg_flags
       ----------------------------------------------------------
       NLM_F_REQUEST   Must be set on all request messages.
       NLM_F_MULTI     The  message  is part of a multipart mes-
                       sage terminated by NLMSG_DONE.
       NLM_F_ACK       Request for an acknowledgment on success.
       NLM_F_ECHO      Echo this request.


       Additional flag bits for GET requests
       --------------------------------------------------------------------
       NLM_F_ROOT     Return the complete table instead of a single entry.
       NLM_F_MATCH    Return all entries matching criteria passed in  mes-
                      sage content.  Not implemented yet.
       NLM_F_ATOMIC   Return an atomic snapshot of the table.
       NLM_F_DUMP     Convenience macro; equivalent to
                      (NLM_F_ROOT|NLM_F_MATCH).

so, for virtualbox use ("we want the full table"), NLM_F_ROOT is right,
and for the way I tackle this ("just give me the matching route"),=20
NLM_F_REQUEST *only* is the right thing.

I'll remove the /* XXX */ and point to netlink(7) for explanations.


[..]
> > +	if (nh->nlmsg_type =3D=3D NLMSG_DONE) { break; }
> The coding style here is different ithan in other parts of OpenVPN.

As this is new 2.4-only code, and we want to change the coding style
anyway, I've decided to add new code in the new style already *if* it
is a completely new function (which this is).  "In the middle of a=20
function" code bits will be kept old-style.

I agree that this leads to somewhat inconsistent intermediate style, but=20
it is less reformatting, and 2.4 is "near" (I hope... Steffan? :-) )

> > +
> > +	/* we're only looking for routes in the main table, as "we have
> > +	 * no IPv6" will lead to a lookup result in "Local" (::/0 reject)
> > +	 */
> > +	if (rtm->rtm_family !=3D AF_INET6 ||
> > +	    rtm->rtm_table !=3D RT_TABLE_MAIN)
> > +		{ continue; }		/* we're not interested */
> > +
> We night want to revisit this with more complex routing scenarios.
> Android for example uses the main routing table only to jump more
> specific routing tables. Other system might do the same.

I expect I'll have to revisit get_route_gateway_ipv6() on all the platforms
eventually - right now, it works for the "easy case".  If someone uses
multiple routing tables, it will need adjustments on Linux and *BSD.

OTOH, we currently don't do multiple routing tables at all - neither
for ifconfig, nor for route addition, so this would need some serious
thought how to do this properly (which route table to use for openvpn
itself, which table to install tun routes into, etc.).  I think there is
quite interesting possibilities to make things work even more nice
(like, roaming to new interfaces for the "outside" connection, while
the tun just stays up, without having to adjust host routes).  We're not
there today yet, though.

So - on Android, that code is not exactly relevant (it will print what
it finds, which I'm actually somewhat curious to see :-) - but the result
will not be used after your #ifndef TARGET_ANDROID patch goes in) and for=20
other platforms, I do keep that in mind and will tackle it when someone=20
comes up with a use case I can look into.

> Aside from these comment, this gets an ACK from me.

Thanks for the review.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--zpKbRLlnGgG674Bt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVfr2JKkuBuNlUUl1AQL+DAP+OY8ZzKNU0CQCfQqUFwxzDQ2XrS56eb//
mHKFXKsXXvqylk4ZREzaQ1Q91ue8LxPDoSAmDKy3OY4VUbgrHXLEIxLSFY8BnSHq
5Vyu5npIyCnyJuraSEwPHzAsSeVrrltYKt4crRLiv0GJIOVXK7YN8ejPPOuYepKQ
D+tjJnlxYIQ=
=QRQI
-----END PGP SIGNATURE-----

--zpKbRLlnGgG674Bt--

