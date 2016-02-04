Date: Thu, 4 Feb 2016 10:38:23 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160204093823.GX24952@...1296...>
References: <2215306.x9ci9DhAZ9@...2001...>
	<1453835508-26119-1-git-send-email-gert@...1296...>
	<CAKuzo_iSwvk8MTW0ACT+n5JRkNDNyOoHHvmYw+fonN=ASUPuCw@...278...>
	<CAKuzo_hLdWaxZau_KtBhO1LvTivmurinrdqPsNTrjUfWnrZBvA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u0WGpcS7tYnCwot9"
Content-Disposition: inline
In-Reply-To: <CAKuzo_hLdWaxZau_KtBhO1LvTivmurinrdqPsNTrjUfWnrZBvA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] interactive service v3
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

--u0WGpcS7tYnCwot9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Feb 03, 2016 at 08:57:18PM -0500, Selva Nair wrote:
> On Mon, Feb 1, 2016 at 11:34 AM, Selva Nair <selva.nair@...277...> wrote:
>=20
> > Other comments I have are more specific to code snippets and of minor
> > consequence. Will send them after compile/test runs
>=20
> Following up on that, a couple of comments below:
>=20
>       HMODULE iphlpapi =3D GetModuleHandle (TEXT("iphlpapi.dll"));
> >       if (iphlpapi =3D=3D NULL)
> >         return GetLastError ();
> >       CreateIpForwardEntry2 =3D (CreateIpForwardEntry2Fn) GetProcAddress
> > (iphlpapi, "CreateIpForwardEntry2");
> >       if (!CreateIpForwardEntry2)
> >         return GetLastError ();
>=20
> Is this run-time lookup necessary?

I don't think so - it might be a leftover of "we try to make this=20
compatible with windows XP", which we decided later to be a non-goal
for 2.4.

So we might replace this with just calling CreateIpForwardEntry2()=20
directly.

> Anyway, the iservice works well and the only real problem I ran into was
> lack of write access to the default log_dir. That leads to a log-jam as t=
he
> stdout is now a pipe which the service is not actively reading from. Could
> be handled in the GUI + registry by making sure openvpn is started with a
> writable log file..

Yes, I've seen this as well.  As far as I understand, there's a registry
key that can be changed to include the user's home in the log path - it's
on a piece of paper on my desk, while I'm at work, so can't look right
now... Heiko?

(And yes, this needs to be adjusted in the installer, whichever way we
go - globally writeable log directory, or user-individual logging)

> Anyway, the service part of the code looks good and does well what it
> promises to do.

Thanks.  I take this as an ACK from your for the service change, and=20
Arne's mail as an ACK for the openvpn side, and merge it tonight.

Then we can go about improving things further (... while we wait for
the other large 2.4 feature to fully show up, AEAD...)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--u0WGpcS7tYnCwot9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVrMcDqkuBuNlUUl1AQJYHQP/cLH+2BXaC8FS0gezTypsdUSSZVT031Bj
cZANZagBg7wNY7kpKTbyMh8TcyYjS27xR81+J9iQxVuaNoV9+vJSxn10cdIBuoIs
xm+IRCHXAcgKXqiGZUIrmjjoQm/IAuZOh/+Qklpu9TCpE7Q2xGUZ2iYS2tPkrc7v
5/0g5W9ilzs=
=RKLM
-----END PGP SIGNATURE-----

--u0WGpcS7tYnCwot9--

