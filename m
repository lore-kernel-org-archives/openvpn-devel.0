Date: Fri, 5 Feb 2016 09:25:48 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160205082548.GI24952@...1296...>
References: <2215306.x9ci9DhAZ9@...2001...>
	<1453835508-26119-1-git-send-email-gert@...1296...>
	<CAKuzo_iSwvk8MTW0ACT+n5JRkNDNyOoHHvmYw+fonN=ASUPuCw@...278...>
	<CAKuzo_hLdWaxZau_KtBhO1LvTivmurinrdqPsNTrjUfWnrZBvA@...278...>
	<20160204093823.GX24952@...1296...>
	<CAKuzo_isz+mde2P6=D=mMPQNEmcRQKmU-XNySVJxBK2eNzU-CA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UWgk94WM72qRTbwc"
Content-Disposition: inline
In-Reply-To: <CAKuzo_isz+mde2P6=D=mMPQNEmcRQKmU-XNySVJxBK2eNzU-CA@...278...>
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

--UWgk94WM72qRTbwc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 04, 2016 at 10:40:35AM -0500, Selva Nair wrote:
> > (And yes, this needs to be adjusted in the installer, whichever way we
> > go - globally writeable log directory, or user-individual logging)
>=20
> Its the "HKLM\OpenVPN\log_dir" key set by the installer when the service =
is
> installed. For the automatic service, users may want it to stay at such a
> system-wide location, while the interactive service does not use it
> directly.=20

Yes, thanks.  That's the key...

> But the UI (OpenVPNGUI) uses it to construct the log file path
> and passes it in the command line options.
>=20
> To make the log location user-dependent, we could include env variables in
> the registry key -- say  %UserProfile%/OpenVPN/log  But that requires the
> service to read the key as REG_EXPAND_SZ and then expand it.
>=20
> For now, I'll make a patch for the GUI to construct a writable log path
> when iservice is used. It looks ok to let the UI to decide where to write
> logs to.=20

This sounds like a good plan, thanks.

> We could document that starting openvpn using iservice needs the
> --log or --log-append option with a writable log file. If its not writable
> openvpn will fallback to stdout which will not work.

Yes, this came as a bit of surprise to me - I saw quite a bit of logging
in the status window, and then "it just stuck" (eventually I noticed the
error about the non-writeable log file in the first line, and tried making
it writeable :-) ).

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--UWgk94WM72qRTbwc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVrRci6kuBuNlUUl1AQIn/QP+LGvqJtaMUqRlJnnWlm9ds+vbTSmNz36V
CWppZCIxxgRnattVT9zzOB3pVaDCcyDLZHEyj/kHKlmKfLXbk3Pn6HGUC81kVxex
MZDeiYRWxHwa5OBzNxV6Bl6fNupfcpM26nk5hXC/NEUVRXKBWYqBUIgAmVjwSMaG
kkQeMSowlHE=
=2TO/
-----END PGP SIGNATURE-----

--UWgk94WM72qRTbwc--

