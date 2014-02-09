Message-ID: <52F7A006.4010302@...1227...>
Date: Sun, 09 Feb 2014 16:34:30 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <52F6E3AF.1080400@...1030...>	<20140209115057.GT16637@...1296...>	<CAAbSJMUyKqqup1-nBuUsXNVuaaj93YWg0JxcqeBicU1QhtTrkw@...278...>
	<20140209151951.GU16637@...1296...>
In-Reply-To: <20140209151951.GU16637@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="4HfFvFs6kmJx1GXII3RHF1oRjL47bSUav"
Subject: Re: [Openvpn-devel] --local, --lport and --bind
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Mickael Chazaux <mickael.chazaux@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4HfFvFs6kmJx1GXII3RHF1oRjL47bSUav
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 09.02.14 16:19, schrieb Gert Doering:
> Hi,
>
> On Sun, Feb 09, 2014 at 02:41:58PM +0100, Mickael Chazaux wrote:
>> Although it is not easy to find on the Internet, you can bind a client
>> socket to a specific IP adress, while setting the port as 0, meaning
>> "choose for me".=20
> Ah, good.  So there *is* a "I do not want a specific port" setting.
>
> Seems we need to improve documentation :-) (but maybe the new code=20
> from Arne that went into 2.4-to-be already does this properly, as in,
> "not require --lport setting for --bind")
>
>
Does lport 0 work?

Arne



--4HfFvFs6kmJx1GXII3RHF1oRjL47bSUav
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (Darwin)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlL3oAYACgkQe8+cMNS4zRcndQCguEip31RAr+lHDvmbFlRqCUlk
qHUAn0osUWrliAFm89LW4MZ/tJh6JlwM
=cIE/
-----END PGP SIGNATURE-----

--4HfFvFs6kmJx1GXII3RHF1oRjL47bSUav--

