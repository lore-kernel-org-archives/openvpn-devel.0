From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Re: openvpn server in client-to-client mode
In-Reply-To: <pan.2004.12.22.01.52.04.687317@...294...>
Message-ID: <Pine.LNX.4.58.0412220512480.7923@...41...>
References: <000f01c4e62e$4e5eb450$0200080a@...333...>
 <Pine.LNX.4.58.0412200900150.19152@...41...> <005401c4e798$f616ef80$fbdafea9@...333...>
 <pan.2004.12.22.01.52.04.687317@...294...>
MIME-Version: 1.0
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
Date: Wed Dec 22 04:43:05 2004
Content-Type: TEXT/PLAIN; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Charles Duffy <cduffy@...294...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, 21 Dec 2004, Charles Duffy wrote:

> On Tue, 21 Dec 2004 21:09:21 +0100, Tor H=C3=A5kon Gjerde wrote:
>=20
> > It doesn't sound that hard to make that patch. If someone would be so k=
ind
> > and send me one, I would be very  grateful.
>=20
> Presuming that you aren't a coder yourself -- it typically doesn't work
> that way. Generally speaking, folks in the OSS world scratch their own
> itches -- and by asking you to submit a patch, James was gently
> declining to implement your feature (at least free-of-charge) and urging
> you to write or commission an implementation yourself.
>=20
> WRT the latter -- I don't know what the market will bear at the moment,
> but after Christmas I might be available[1] for contract work for $70/hr
> or so, and for this project in particular I'd be willing to agree to a
> 3-hour cap. Better, you could ask James if you could hire him to implement
> this feature -- in all likelihood, he'd be done faster and provide
> better-quality work.
>=20
> [1] - Depends on how my employer is doing; I also might be entirely
> unavailable for outside work.

That's reasonably well-said and sort of gets down to the economic=20
reality of open source development.  Most of us who are actively=20
working on GPL projects need to somehow juggle our open source activities=20
with consulting work that pays the bills.  So the best way to get your=20
wishlists implemented quickly is to help fund the project.

The proposed feature is intriguing, and if someone submitted it as a
patch, I'd probably accept it (for post 2.0).  It would essentially allow
you to run an OpenVPN client-to-client server without needing any tun/tap
interface on the server side, and without needing to start the openvpn
daemon as root.  You could even run OpenVPN this way on platforms which
have no TUN/TAP driver.  It's also interesting from a testing perspective,
since it would let someone test new versions of the code on lots of
different platforms while only needing non-root shell access.

But given where we are in the 2.0 release cycle, and the economic
realities of constantly needing to find funding to support the project,
etc. I'd have to put a request like this on the wishlist for now.

James


