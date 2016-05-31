Date: Tue, 31 May 2016 18:01:04 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160531160104.GB53051@...1296...>
References: <1464668569-6480-1-git-send-email-selva.nair@...277...>
	<20160531084825.GT53051@...1296...>
	<CAKuzo_jLpENbvwEOg18dp3CKRCFQbo8O29m3-jZfqQeJ+DB+Kw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uIXdukVwcxdyK/cg"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jLpENbvwEOg18dp3CKRCFQbo8O29m3-jZfqQeJ+DB+Kw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add an option to filter options
 received from server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--uIXdukVwcxdyK/cg
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, May 31, 2016 at 11:54:53AM -0400, Selva Nair wrote:
> On Tue, May 31, 2016 at 4:48 AM, Gert Doering <gert@...1296...> wrote:
>=20
> > Thinking about this a bit more, without having studied the code - what
> > do you think about having a third category
[..]
> > "ignore" would be "if that option shows up, log the fact that we ignored
> > it, and go on", while "reject" would be "if this shows up, something bad
> > is happening, so complain loudly, abort the connection and try the next
> > alternative".
>=20
> Interesting. At the very least it may be worth doing a v2 to make adding
> new action types easier.

Do you foresee more different action types?  My imagination ends at
"accept, ignore, refuse-with-error"...

> Suppose we do make "reject" to not just remove the option but reject the
> server. What to do if no alternative remotes exist --- just SIGHUP and ho=
pe
> that next try will succeed or something like management-hold will keep the
> connection waiting for user intervention? I would avoid issuing or causing
> a SIGTERM.

I have a use case where I would like to silently *ignore* something one
of my servers is sending me (one route that is sent conflicts with local
stuff, but that is not malicious or neglicience on their end, but something
on my end).  So v1 would do that for me, changing it to "you can only
have accept ore reject-the-server" would make this option not work for
me (right now I use route-nopull and manually set route statements).

But anyway - I think SIGHUP is good enough.  If there is no other server,
it will loop, like in any other uncorrectable error (like, server cert
invalid), but there is not much we can do about it.

> > We briefly discussed this yesterday - 64 should be plenty for about
> > everything, but a dynamic list might be the way to cope for the *one*
> > user who then comes up with the 65th rule...
>=20
> I didn't make it a linked-list mainly because of the need of adding to the
> tail of the list which means some extra extra book-keeping and if-elses.

Was more thinking about realloc()ing the array, not linked lists - but
let's keep it static for now, and just tell people "your config is too
big".

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--uIXdukVwcxdyK/cg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV021P6kuBuNlUUl1AQKdgwP/aCZgxDzPr5L1Ne6YKXPPvymZajV8kXTa
o2A2j9cbDeAC/L3rMXlXY8fNtYYOQbzuWHoCuMtdgttCNmqCl6T/bAtpx9nTCOuO
+6Y/pjyeibigGEteE8eOIQ6V7rq9HjA5pqlYUWdUY09OG4HI6LNoieBPtkuKQwxf
bzLneZmEUrc=
=Ok0D
-----END PGP SIGNATURE-----

--uIXdukVwcxdyK/cg--

