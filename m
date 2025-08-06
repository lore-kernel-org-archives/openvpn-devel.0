Date: Wed, 6 Aug 2025 13:22:30 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <aJM69j31LSPdL3hN@...1296...>
References: <CAOh3LPOwuAO84y7kUcWNQFVes8rwRg6WZ9dAUBTAqLTrDMtaLQ.ref@...278...>
 <CAOh3LPOwuAO84y7kUcWNQFVes8rwRg6WZ9dAUBTAqLTrDMtaLQ@...278...>
 <ebe735de-ee37-4cc2-aa41-1ac10f8744b4@...1227...>
 <CAOh3LPMj6WQgsUS00Jke0nNvRW8U0hTY78RYG5FTgCVQF38daA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="llN8yIC1NcAuY4LF"
Content-Disposition: inline
In-Reply-To: <CAOh3LPMj6WQgsUS00Jke0nNvRW8U0hTY78RYG5FTgCVQF38daA@...278...>
Subject: Re: [Openvpn-devel] Modifying OpenVPN Source Code to Allow for
 Bulk-Reads, Max-MTU, and Jumbo-TCP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jon Chiappetta <root@...2904...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--llN8yIC1NcAuY4LF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 06, 2025 at 07:03:51AM -0400, Jon Chiappetta via Openvpn-devel =
wrote:
> Is there any development setup guide I could follow in the future which
> would allow me to submit a pull request to the OpenVPN codebase in an
> official manner?

https://community.openvpn.net/Development/DeveloperDocumentation

which is outdated in a few places, but the most important thing is
still correct: we don't do Github PRs, we do "patch on list" or "push
to gerrit".

Before you spend too much time on actual code, it makes sense to see if
there is general agreement on the problem statement, and the direction=20
to fix it.  For problems that we cannot understand, it's slightly harder
to convince us to accept the code (and the maintenance and testing
obligation that comes with each new line of code).

So far I have heard "MTU mumble mumble" and we do have lots of MTUs of
all sorts already :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--llN8yIC1NcAuY4LF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJokzr2AAoJEB2Cnv7KVigS6e0L/2do0mff2h7Wkr7/NH0Op7jv
DxJKqQurwzmghmpiI83BY66l+FeYdLoNDNf78G11S3DeyBiVBsyoP+aEIK4/Px27
FvZ/OkcIUlc6PUFXVrihgmIsCUmIJKtdCWfloWGUrowgn3nzkz07DpBE351EObYq
jGViuEhYpc/ikWDr/L1Xva51uI6k3S6RLdrH30IMwqv2U2YuFvBsyFXHW4lRxAIU
CiNNVhrFvkcY6FeYYCcSQU0rDqbsepgDVDQwRK9SQO54T6EnCwDPVv9VqQSrmnkI
6PILWLKx3Tta/ebQa0HWJJzsAr/T59SCh0R9o6crXLJC7lcaiYD6LpWIvNeV31AU
JFv+iIq+rpDk78hMU3aNG2kdy1QBx8WPxSdzcIIJTIaQKn1VKSjIkwzmL7VCX9NC
k3LMGkeIsvytC1/NmUBSN6Tmc8PiAluWHuZPjMNX4EfPc+vmLGh+9/sFWmwwltGC
+N+RfCnxgK37C+zksQvrZtutDAu7B/hU3imBnCDk/Q==
=6Zk4
-----END PGP SIGNATURE-----

--llN8yIC1NcAuY4LF--

