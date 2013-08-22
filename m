Message-ID: <5215EB10.9060903@...1114...>
Date: Thu, 22 Aug 2013 12:42:24 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <kv4ece$s8s$1@...1062...>
In-Reply-To: <kv4ece$s8s$1@...1062...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="atF4suIDmBlpIWcUTriuEp6VjOoTfp8e9"
Subject: Re: [Openvpn-devel] [PATCH] Correct error text when no Windows TAP
 device is present
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Josh Cepek <josh.cepek@...1085...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--atF4suIDmBlpIWcUTriuEp6VjOoTfp8e9
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 22/08/13 09:24, Josh Cepek wrote:
> Patch/description attached; this resolves bug #320.

ACK to patch 24be21ea2f1d02631685a0a11bf187372cf10fa4 in the attachement.

> On an unrelated note, I'm trying out OpenPGP/MIME (RFCs 4880 & 3156) in
> this submission since it appears the only non-broken way to sign
> patches. Sane clients should eat this fine (Outlook Express may not.) If
> this poses a particular problem for you or an archiving service (sf.net,
> gmane, etc) I'd like to know about it.

I've had issues without PGP/MIME as well, mostly due to bad wrapping.
Not sure if that was issues caused by GPG, Engimail or Thunderbird.
I've used PGP/MIME here for quite some time now without any complaints.

Other than that, I usually just use 'git send-email' when sending
patches to the mailing list.  It makes the patch submission easier, and
you avoid MUAs messing up the content.


--=20
kind regards,

David Sommerseth


--atF4suIDmBlpIWcUTriuEp6VjOoTfp8e9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlIV6xAACgkQDC186MBRfrpBrACeMBKRhSJ0LmHrbTV/Mb469hHp
MccAn0ELdoP+svTfSqELkmaGOrFJreF+
=Zgrc
-----END PGP SIGNATURE-----

--atF4suIDmBlpIWcUTriuEp6VjOoTfp8e9--

