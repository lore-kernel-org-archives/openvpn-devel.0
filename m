Subject: Re: [Openvpn-devel] Radius support, was: Re: [Openvpn-users] Is it possible to assign a specific ip address to a certificate?
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1085844454.17277@...41...>
In-Reply-To: <200405291019.45953.vda@...216...>
References: <06A32968-AFE3-11D8-96C9-000A95B96B84@...228...> <twig.1085783692.66807@...41...>, <twig.1085783692.66807@...41...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sat May 29 08:28:06 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Denis Vlasenko <vda@...216...>, James Yonan <jim@...41...>, Jaye Mathisen <mrcpu@...227...>, Jon Bendtsen <jon.bendtsen@...228...>
Cc: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

Denis Vlasenko <vda@...216...> said:

> On Saturday 29 May 2004 01:34, James Yonan wrote:
> > Jaye Mathisen <mrcpu@...227...> said:
> > > It would be nice if openvpn could be configure to work with radius for
> >
> > routing and
> >
> > > IP assignment after the certificate was done.  Would allow openvpn to be
> >
> > integrated easily
> >
> > > with existing infrastructure, instead of having to have a whole new
> > > system
> >
> > to maintain
> >
> > > information about it.
> >
> > There have been several requests for radius support, and while it's
> > something I'd like to see done, I'm not going to have time to do it for
> > 2.0.
> >
> > This is the sort of thing where it would be ideal if someone else takes the
> > lead -- I would certainly be happy to technically support anyone who wants
> > to take the project on.
> 
> 802.11x can be trivially attacked. Read the RFC. I don't see why
> shall I use broken protocol.

True, however the suggestion was to use radius only for IP address assignment
and routing, not for authentication.

James


