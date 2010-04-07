From: Heiko Hund <hhund@...194...>
Date: Wed, 7 Apr 2010 15:26:05 +0200
References: <OF16C98C16.EEA12E96-ONC12576FD.006F673E-C12576FD.00713519@...1343...>
	<201004070959.09215.hhund@...194...>
	<OF83959B35.6804C8B1-ONC12576FE.0041E6AD-C12576FE.00424FE8@...1343...>
In-Reply-To: <OF83959B35.6804C8B1-ONC12576FE.0041E6AD-C12576FE.00424FE8@...1343...>
MIME-Version: 1.0
Message-Id: <201004071526.06006.hhund@...194...>
Subject: Re: [Openvpn-devel] DNS problems with openvpn 2.1 on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Johan Ymerson <johan.ymerson@...1342...>
Cc: openvpn-devel@lists.sourceforge.net

On Wednesday 07 April 2010 14:04:18 Johan Ymerson wrote:
> "Heiko Hund" <hhund@...194...> wrote on 2010-04-07 09:59:08:
> > We also tried 2.0.9 but were able to reproduce the bug with it as well,
> > so it has nothing to do with the openvpn driver version involved. I came
> > to the conclusion that it's rather some kind of race condition in the
> > Windows XP DNS resolver. At least I haven't seen this problem on Vista
> > or 7 personally.
>=20
> Then I don't think we see the same problem. We have been using 2.0.9 on
> ~100 machines for a couple of years now without these problems. We
> upgraded 3 of them to 2.1.1, and they all instantly got this problem. We
> downgraded them to 2.0.9, and all problems gone. Then started switching
> between 2.0.9 and 2.1_rcX to determine when this problem started, but all
> 2.1_rcX seems to suffer from it, but 2.0.9 does _not_! So something must
> have changed between 2.0.9 and 2.1 that at least makes this a lot worse.

Strange, we tested with 2.1_rc22 and the driver from 2.0.9 and ran into the=
=20
problem within ten attempts. I can't image that the problem is related to=20
userspace openvpn. Do you have the problem every time you connect and do yo=
u=20
see the DNS servers in the output of `ipconfig /all`?

Heiko
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro AG | An der RaumFabrik 33a | 76227 Karlsruhe | Germany

Executive Board: Markus Hennig, Jan Hichert, G=FCnter Junk, Dr. Frank Nelli=
ssen
Chairman of the Supervisory Board: Stanley J. Krasnow
Headquarter Location: Karlsruhe
Commercial Register: Mannheim HRB 108997

