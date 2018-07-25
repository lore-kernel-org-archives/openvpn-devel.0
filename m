Date: Wed, 25 Jul 2018 20:17:52 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180725181752.GC55859@...1296...>
References: <BL0PR2101MB1058B863878E4C9740E1B125AB540@...2440...>
 <20180725180018.GA55859@...1296...>
 <BL0PR2101MB1058707381F501AFB7FFA9AAAB540@...2440...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="IzDGhYym0nRbyqRy"
Content-Disposition: inline
In-Reply-To: <BL0PR2101MB1058707381F501AFB7FFA9AAAB540@...2440...>
Subject: Re: [Openvpn-devel] [PATCH] [openvpn-gui] Update system tray to
 populate Windows VPN flyout
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kevin Kane <kkane@...2393...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--IzDGhYym0nRbyqRy
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jul 25, 2018 at 06:08:19PM +0000, Kevin Kane wrote:
> Ugh. Thanks, Outlook. I'd have to use a personal e-mail account to use so=
mething other than Exchange.
>=20
> The other option is for me to add the files to the e-mail as attachments.=
 Is that acceptable, or do you really need the patch text to be in the mess=
age body?

For applying with "git am" and for reviewing with "I can just quote
parts of the patch and comment on it", attachments in anything that is
not text/plain format are also not ideal, but we can try that.

We've had a few patches come in recently that were attachment in a=20
signed mail, and neither patchwork nor git could handle these mails
in a satisfying way - as in: patchwork did not recognize them as
"patch", and "git am" declared "no patch in there" - so "save patch
as individual file, git am, manually add in-reply-to to the auto-
generated "patch applied" reply mail, etc.

It's a bit of try and error what works in a given environment.

(git send-email talking SMTP to Exchange might actually work more=20
nicely than outlook.  Maybe that was just one particularily weird
version of Exchange, or "too many virus scanner plugins hooked in",
given that this was Sophos...)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--IzDGhYym0nRbyqRy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbWL7QAAoJEB2Cnv7KVigSl1kL/RY7Ug8tDjZBHHGjS5xcXt2g
Osj8fF9cu2XzkGEB93TcORUEgWHlvVvrXjzR7MzmHQtKyXvYAr1t0TAsaxSTHKdg
TMY4cs9jqIaWsKklcRk168dVrgx/sQG1tBavfas9az08ag/aPd5oSvH6ixNvJNpV
3pbRsdp7CE3T9cCFkcSaw/3bBYsO28YgOVtuRZXhVCxwR3YHvbeJz126ZvuCXADc
mV2miv4Ts6Fk+f8kEk5LHtxtiOxI1n40MbwA500qC7a3iDh3n97CQ8qjjO3N+04n
h0FyUzQGt2s4AUC+wEfUjgywGTHyiFftN0S6gvFI6d4fG/ivQUnAudc846j5BY6v
B97MkqqsL7qnxXTbPPS9vo1YKn9HV9YDs69DANTFWUe1ajNV9RnBChs29RoeJgLw
3tvthY8kESsG7/53ovcs0HjAfOZLTapbp3kGAz0DKgDVbH39nW4kK6budff3ONW0
IiJb8O4QxvFDuMKS6ao/h2WjatGWUZorP14ogar2qw==
=7iiT
-----END PGP SIGNATURE-----

--IzDGhYym0nRbyqRy--

