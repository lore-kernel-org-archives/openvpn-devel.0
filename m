Date: Thu, 23 Jun 2016 08:20:43 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160623062043.GA79504@...1296...>
References: <1466649762-1657-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MmQIYbZiCoQ2kDro"
Content-Disposition: inline
In-Reply-To: <1466649762-1657-1-git-send-email-selva.nair@...277...>
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
Cc: openvpn-devel@lists.sourceforge.net

--MmQIYbZiCoQ2kDro
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jun 22, 2016 at 10:42:42PM -0400, Selva Nair wrote:
> - The process id is returned as a message formatted in the same manner
>   as error messages from the service to the client: i.e., a three-line
>   message with pid formatted as 0x%08x on line 1, "Process Id" on
>   line 2 and a blank line 3.
>=20
> This provides a way for service clients to check the status of openvpn
> and terminate it without needing management interface or exit event.
> Useful when the interactive service is used from a launch script, or
> to force-terminate openvpn from the GUI if/when needed.

How does the GUI currently handle return messages?  As in, does this
need GUI changes, or is the GUI prepared to handle anything that comes
along?

>=20=20
> +static VOID
> +ReturnProcessId (HANDLE pipe, DWORD pid, DWORD count, LPHANDLE events)
> +{
> +  const WCHAR msg[] =3D L"\nProcess ID\n";
> +  WCHAR buf[10 + _countof(msg)]; /* 10 characters for the pid in 0x%08x =
format */
> +
> +  /* A 3-line string like an error message but with pid in place of erro=
r number */
> +  _snwprintf (buf, _countof(buf), L"0x%08x%s", pid, msg);
> +  buf[_countof(buf) - 1] =3D '\0';
> +
> +  WritePipeAsync (pipe, buf, wcslen (buf) * 2, count, events);
> +}

Where does the extra blank line come from?  If I'm not all confused
(this is before my first cup of tea) this will write

%08x\nProcess ID\n

into the buffer, and not \n\n...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--MmQIYbZiCoQ2kDro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV2t/u6kuBuNlUUl1AQJHWwP+IuSLoG9W0xoDhFRN8fseVkVy0at/6wY5
x6CZq8yrPSND6mmmMRJdRnRW0FFF4YLvaru6obUD9DJYgxL86bPQjz+INSLf6dmf
U2ooVi9i0DwmwklllTHT9nBPBl4cbvznqD9BzE6l9EuSGTy7e+B8u23kXd9cKkL7
1ahW6ISRKJA=
=XkVC
-----END PGP SIGNATURE-----

--MmQIYbZiCoQ2kDro--

