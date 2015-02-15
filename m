Date: Sun, 15 Feb 2015 21:39:07 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20150215203906.GO8134@...1296...>
References: <1419875325-96015-1-git-send-email-gert@...1296...>
	<54D87803.8090107@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XqOulWco09xrjj7X"
Content-Disposition: inline
In-Reply-To: <54D87803.8090107@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Print remote IPv4 address on a
	dual-stack v6 socket in IPv4 format
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

--XqOulWco09xrjj7X
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Feb 09, 2015 at 10:04:03AM +0100, Arne Schwabe wrote:
> > --- a/src/openvpn/mroute.c
> > +++ b/src/openvpn/mroute.c
> > @@ -426,8 +426,16 @@ mroute_addr_print_ex (const struct mroute_addr *ma,
> >  	  break;
> >  	case MR_ADDR_IPV6:
> >  	  {
> > -	    buf_printf (&out, "%s",
> > -		  print_in6_addr( *(struct in6_addr*)&maddr.addr, 0, gc));=20
> > +	    if ( IN6_IS_ADDR_V4MAPPED( (struct in6_addr*)&maddr.addr ) )
> > +	      {
> > +		buf_printf (&out, "%s",
> > +		     print_in_addr_t( *(in_addr_t*)(&maddr.addr[12]), IA_NET_ORDER, =
gc));
> Have you checked that this is endian safe?

Yep, both by running on i386 and on sparc64 - and then by staring at the
code and wondering why it works.

Thing is that print_in_addr_t() takes a flag, IA_NET_ORDER, which tells it
"that 32bit thingie you're printing now is in network byte order", so it
will not call htonl() on it before passing to inet_ntoa(), which wants
network byte order.

(And the IPv6 address is "just an array of 16 octets", no possible confusion
here with 32bit integer representation)
--XqOulWco09xrjj7X--
