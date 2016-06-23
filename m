Date: Thu, 23 Jun 2016 18:01:49 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160623160149.GF79504@...1296...>
References: <1466649762-1657-1-git-send-email-selva.nair@...277...>
	<20160623062043.GA79504@...1296...>
	<CAKuzo_j=NnNiA2z65G=8FOKmy7tHjqSrVotgcqBP=M-tR_juZQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ULJ2Z7kCM1hyNsWd"
Content-Disposition: inline
In-Reply-To: <CAKuzo_j=NnNiA2z65G=8FOKmy7tHjqSrVotgcqBP=M-tR_juZQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Return process id of openvpn from
 interactive service to client
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

--ULJ2Z7kCM1hyNsWd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jun 23, 2016 at 10:39:15AM -0400, Selva Nair wrote:
> > How does the GUI currently handle return messages?  As in, does this
> > need GUI changes, or is the GUI prepared to handle anything that comes
> > along?
>=20
> Currently the GUI interpretes two custom error codes (0x2000000 and
> 0x20000001) and ignores the rest. So it will just a log a message and
> ignore this one. Unless the PID happens to match one of those two numbers.
> Though I've never seen PIDs that large.
>=20
> An alternative is to set error =3D 0 and pass PID as the second line:
>=20
> "0x00000000\nPID\Process ID"
>=20
> where PID may be formatted as 0x%08x. May be that is better?

I think this is better - define a convention for "informational messages"
(which this could be) and then use it at both ends :-)

> > > +static VOID
> > > +ReturnProcessId (HANDLE pipe, DWORD pid, DWORD count, LPHANDLE event=
s)
> > > +{
> > > +  const WCHAR msg[] =3D L"\nProcess ID\n";
> > > +  WCHAR buf[10 + _countof(msg)]; /* 10 characters for the pid in 0x%=
08x
> > format */
> > > +
> > > +  /* A 3-line string like an error message but with pid in place of
> > error number */
> > > +  _snwprintf (buf, _countof(buf), L"0x%08x%s", pid, msg);
> > > +  buf[_countof(buf) - 1] =3D '\0';
> > > +
> > > +  WritePipeAsync (pipe, buf, wcslen (buf) * 2, count, events);
> > > +}
> >
> > Where does the extra blank line come from?  If I'm not all confused
> > (this is before my first cup of tea) this will write
> >
> > %08x\nProcess ID\n
> >
> > into the buffer, and not \n\n...
>=20
>=20
> May be its my terminology of what is a "line", not your tea. The currently
> used format is NUMBER\nLINE2\nLINE3 so there is no \n at the end of line
> 3.  In the present case that would be "%08x\nProcess ID\n"

Indeed, terminology.  For me, a line ends with a "\n" - but it certainly
does not *have* to.  If service and gui agree on "thee parts, separated
by two \n, no trailing \n", this is good enough (and in which case the
code does what is expected).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ULJ2Z7kCM1hyNsWd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV2wH7KkuBuNlUUl1AQJ4iAP/eyTraywC5NoSjF1grqO8dc4Jl7JXAcma
7GXvMD0PAJPeCHkaLo5D9NmpEzsCqDTBbInJS15k7YZi5cNaP7EON8ksv4X1cqYK
5TwYtw3Ap9EODBZsgrVdQbKvILufmpKgy24h45Y5Bwjwb1mnP4wm9LeAaqABGnl/
7iSJUqsQu1M=
=puiM
-----END PGP SIGNATURE-----

--ULJ2Z7kCM1hyNsWd--

