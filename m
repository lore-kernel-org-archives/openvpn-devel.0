From: Jeremie Courreges-Anglas <jca@...2272...>
References: <87fuf7u455.fsf@...2274...>
	<201706111148.v5BBmmVn038597@...2054...>
Date: Mon, 12 Jun 2017 17:25:37 +0200
In-Reply-To: <201706111148.v5BBmmVn038597@...2054...> (Gert
	Doering's message of "Sun, 11 Jun 2017 13:48:48 +0200 (CEST)")
Message-ID: <87wp8hp6ry.fsf@...2274...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Missing include for
 socket-flags TCP_NODELAY on OpenBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--=-=-=
Content-Type: text/plain

Gert Doering <gert@...1296...> writes:

> ACK, thanks.
>
> (While I'm not exactly happy with the mess we have in syshead.h, this
> is not your fault - you just happen to add the 6th identical chunk...)
>
> Applying this to all branches to fix the bug, putting "rework syshead.h
> for master, to clean up the zillion nearly-identical blocks" on my TODO
> list.
>
> Your patch has been applied to the master, release/2.4 and release/2.3 branch.

Great, thanks a lot. :)

-- 
jca | PGP : 0x1524E7EE / 5135 92C1 AD36 5293 2BDF  DDCC 0DFA 74AE 1524 E7EE

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEUTWSwa02UpMr393MDfp0rhUk5+4FAlk+snIACgkQDfp0rhUk
5+7FSw//YQqqirlMT5Iz80UjMnDbmPbcrvgtv+zR87X7QC/IDByfue/c8ZkcvLy0
3ncGVElG5zifmISYhP/sHMfOqB16XfACBOvEQGlH+pGoxLcIoUnlQAf8penJFtEM
d+nUCAf5w7gcnvMPJpDOXhS+h64THEdKEsdB6JGFTUuDUn14GUuDyTchfZGOKLaC
LloUVQ+UXFRfrmsvIUOCXNyx74ohTE9zhA2wH6qUgaTjaUOAPLy3JcI7sZHviTkW
E6bJxIBSzMEh3ISB7XaLuIj7IFqRjdQmLDn8n3r4Rttohfdzfexjb6Pj6JtJIRc9
Ejkdg4cvj8EuK74KAoIFZkcMxdBLX/t5DutytA0dj+e/PwQNGL7RYr0apT+lItxf
9ZW4IzIYGcTsM08mi+MrvzUP3xqKNI8INrrgYZ9oKJHsGW7XIbY03+we/G/HYIdH
8cRvHGqc/P9OOYDSdVrAdsm7o36V3SsAW/u4nzuATytc1JXHMBB46ZXEEDQUuS42
y+CujT2TTMfTnkqt6WCu4o264aO4qX04Daplu5xPLMhp+b2hJQf7gnj1QLdcDY3t
yO1HOXlYFJIfQw0iwlQKwxRSgOr/G1K3vAEF2m8APkxhJvSTBIygk/uDN9wpzX1M
0sp+trgrvrCJqYlQ9IU1VSKwFbq6ekWqu2qXAfEOQkhsbWfBodM=
=F4Cf
-----END PGP SIGNATURE-----
--=-=-=--

