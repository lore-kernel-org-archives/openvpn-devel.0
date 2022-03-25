Date: Fri, 25 Mar 2022 18:21:21 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Yj36ETvmHJhN9lSt@...1296...>
References: <400a4652-39d6-ec8d-6f58-824f552e0440@...2666...>
 <9f710eb5-007c-cc8e-56b0-1b00c3f12c19@...1227...>
 <1315401d-b450-6db4-08f5-fed79f51a205@...2666...>
 <889af1a8-eee2-d869-00ef-29ada1db2bb6@...1227...>
 <bac3c082-face-b0a7-e041-00c9ffe7a7a2@...2181...>
 <9800b0fd-1788-da6e-9e0d-fdfc1f82a40b@...2666...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5MCi6WbPRSuuDq3y"
Content-Disposition: inline
In-Reply-To: <9800b0fd-1788-da6e-9e0d-fdfc1f82a40b@...2666...>
Subject: Re: [Openvpn-devel] [PATCH] Enablement of quantum-safe key
 establishment
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Michael Baentsch <info@...2666...>
Cc: Antonio Quartulli <a@...2181...>, Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--5MCi6WbPRSuuDq3y
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Mar 25, 2022 at 06:10:10PM +0100, Michael Baentsch wrote:
> I'm not quite sure I understand what you're asking me to do. Why not=20
> simply use standard github cooperation mechanisms?

Because our master repo is not "on github", and we do patch review
via the mailing list, with archived public ACKs, and list archive
URLs included in the commit message.  So it is very clear how a=20
certain code change came into our tree.

(Is this highly annoying and very much time consuming?  Yes...=20
but also "is this appropriate for software handling people's most
sensitive data packets?" - and the answer for that is "yes!" as=20
well... :-) )

> $ git send-email --to=3Dopenvpn-devel@lists.sourceforge.net HEAD~1
> git: 'send-email' ist kein Git-Befehl. Siehe 'git --help'.
>
> Pardon the German of my computer: It says "send-email" is no known git=20
> command.

Seems your distribution split this part of git into a separate package
(propably to avoid the dependency on a mail transport agent).

Of course you can do "git format-patch" and then send the result with
a regular mail client - but we've found out (the hard way) that most
mail clients mistreat patches one way or the other - breaking long
lines, reformatting whitespace, ... - so the end result does not=20
apply anymore. "git send-email" works around this.

If you do not succeed in this, one of us can take the patch from the
PR and send it to the list.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--5MCi6WbPRSuuDq3y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiPfoRAAoJEB2Cnv7KVigSIr0L/Ra6TgXcCBU58sH09YVOuUN1
Bo6x/0Z8csb0annwFXJeyLZHBBQ9YXL1ffvDPlqR/6eEhbczP9oqFuRwfRruZGkS
6K85VAjJcgPkJ5XU86RMLMAs0aeP5ClKgdjMpsBbu3AJYApCaCtbxbqAzvQRuoSe
8syM3/nrUd4kLZXlssXRycJFJQ//QU2uPeyuzf+ucZOAMt4Z5EJ0wboZ5QFgJMT9
p7f5FaNYKbGYFl3PVgbF/8cMIcXWSj+oyC6jiGkXtYRDcOg6C42P1v47J7uOQQ3g
V0L5nL3EEMYFmcBMgMlUSO31EV6+Z5JQg40uD790Xgyy/F5OsLIS7ON0JZoxq7M2
kSICGjP0PyXi+SRqH9zSCsHh3JiCXUaeV2B3xlnF0cnDa/P16yEyDR69T5CRUnIj
pk3HR3r2Fb1ZxHeZari8wx/gDyLTH0MOCrAs87NCvNeseqExxwPHyZnCngEkF7sW
XvcTFRjGueq1QNVFF337oNngrQwcJLINROzS9jj3wQ==
=vguV
-----END PGP SIGNATURE-----

--5MCi6WbPRSuuDq3y--

