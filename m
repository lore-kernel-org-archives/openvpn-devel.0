Message-ID: <513F3C9E.5000004@...1227...>
Date: Tue, 12 Mar 2013 15:33:02 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <20120203084426.GA24955@...1296...>
	<20130120164951.2d335b30@...1801...>
	<20130120185030.GR22465@...1296...>
In-Reply-To: <20130120185030.GR22465@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2FGOHBRNBMWASXWXBTJPX"
Subject: Re: [Openvpn-devel] IPv6 enhancement: non-/64 prefix lengths for
 IPv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2FGOHBRNBMWASXWXBTJPX
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 20.01.13 19:50, schrieb Gert Doering:
> Hi,
>
> On Sun, Jan 20, 2013 at 04:49:51PM +0100, Marcel Pennewi=DF wrote:
>>> in time for 2.3, one of the remaining open itches for the IPv6 code=20
>>> is now fixed :-)  (and the changes needed turned out to be fairly
>>> trivial).
>> Using ifconfig-ipv6-pool instead of server-ipv6(-macro) does not allow
>> non-/64 prefix (in current 2.3). Bug or Feature?
> Smells buggy.  As server-ipv6 is just a macro (not really, but sort of).
>
> Indeed... options.c:
>
>   else if (streq (p[0], "ifconfig-ipv6-pool") && p[1] )
> ...
>       if ( netbits !=3D 64 )
>         {
>           msg( msglevel, "--ifconfig-ipv6-pool settings: only /64 support=
ed righ
> t now (not /%d)", netbits );
>           goto err;
>         }
>
> ... this is a leftover from the initial days, where nothing else was
> supported (not for server-ipv6 either).
>
> Patch is trivial, please find attached.  David: 2.3.1 and 2.4.0, please :=
-)

Patch looks good. ACK from me.

Arne


------enig2FGOHBRNBMWASXWXBTJPX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (Darwin)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlE/PKMACgkQe8+cMNS4zRd6hgCgjQV3bUhjLRf4MDtaDsSFX4Sc
qrIAmwQuJTT97ABoL0nDf3SyE1uWMAGi
=5RNN
-----END PGP SIGNATURE-----

------enig2FGOHBRNBMWASXWXBTJPX--

