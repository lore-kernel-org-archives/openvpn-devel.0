Date: Sun, 23 Jul 2023 17:01:00 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZL1ArPSimYAoya13@...1296...>
References: <20230128215901.2207208-1-selva.nair@...277...>
 <202307230928.36N9SIIB029241@...2054...>
 <CAKuzo_gLqfih_Y4_G3P_wLus63f5o1OFXux_rYL=_J7ufxiQXQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="sZuRa3O9O84ZKgc5"
Content-Disposition: inline
In-Reply-To: <CAKuzo_gLqfih_Y4_G3P_wLus63f5o1OFXux_rYL=_J7ufxiQXQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Improve signal handling
 using POSIX sigaction
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--sZuRa3O9O84ZKgc5
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jul 23, 2023 at 10:46:17AM -0400, Selva Nair wrote:
> Now I wish someone could review 2/2 of this patch-set. That's where furth=
er
> potential loss of signal during signal-reset is avoided.

Working on finding a vict^Wvolunteer :-)

(I've briefly looked over 2/2 and didn't find anything "obviously=20
problematic", but this needs more brains and life is a bit chaotic
over here right now - sufficient brains to test & merge, not enough
to really understand all the fine details involved here)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--sZuRa3O9O84ZKgc5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkvUCsAAoJEB2Cnv7KVigSLy0MAJ+NRrcNMxPZl5Q23O36DCt1
NJgDRnM+0+0p8QWqcCmanlQL5sHB2NxQtkg2ZnpQ2eq33fx0/EyCOfxgWsY6+v6t
feumEJ3pT2l2G37nOAaMzikrZ9Wk18AJobbuEl3yQtRp+AW+89kazzXRBC+A0RVA
buJ6LJl5zpYQ+u8EYrnQuBO0FEuLWQx0K1Mifg+fwSgxk001k2PZ/o+q0/O4AtZq
YN/P2kZWisZ0TJbfRqPlWiVhqBkp53lUfYeTuRz1P0p9TndaEl3i1ToJ+gviTYNG
fINJ3xhzF7MnYb/+H8gDsiCfEWpsYlxsMQnVVN7+QKYFNdVzHMQ8U0lFtJg3phAQ
OIBz60iEsHsdx8cVLeaIo/ioAC40FcOwmODukRYtKzpJizRMjMeEcFcnMtV831WG
46Lv8oeiikzzFUheA2H62eNIG6C5XWJfXdHVvr8VF8Lp23NKKVWU4LdCekxn2Vlj
8DH1aKmS8UD0B7+0pb3nomHrEpX2n6veWfAIizmRNw==
=MPo9
-----END PGP SIGNATURE-----

--sZuRa3O9O84ZKgc5--

