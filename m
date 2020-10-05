Date: Mon, 5 Oct 2020 19:28:27 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20201005172827.GQ976@...1296...>
References: <20201001225319.25125-1-themiron@...2010...>
 <202010041219.094CJNKk043968@...2054...>
 <007b01d69b3c$2321a980$6964fc80$@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="twlwrnvElrG9k/1g"
Content-Disposition: inline
In-Reply-To: <007b01d69b3c$2321a980$6964fc80$@yandex-team.ru>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Speedup TCP remote hosts
 connections
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vladislav Grishenko <themiron@...2010...>
Cc: 'Gert Doering' <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--twlwrnvElrG9k/1g
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Oct 05, 2020 at 10:22:43PM +0500, Vladislav Grishenko wrote:
> Perhaps same approach can be applied to server's tcp listening, would
> require testing of more management cases.

There's two code paths here

 --tcp-server

and

 --mode server + --tcp

I think the "mode server" code path is already very quick (=3D if I test
with your fast TCP client, against a "git master" server, I get 0.16s=20
connection setup time).  This is what people use on "more than one
client" servers, so it's already fine.

The "--tcp-server" code path is "point to point".  Not sure we currently
test this at all (I have UDP p2p instance, but no TCP yet... seems I
need to add one).  This might indeed be slow, I had a look at the
accept() path in socket.c recently and was wondering "how can this=20
work at all?" - but that's "socket.c" vs. "mtcp.c", I think.


Since this is somewhat of a niche case, I'd put that into the "2.6" bin :-)
- the other one, TCP on the client, is much more heavily used, so 2.5
for that was appropriate.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--twlwrnvElrG9k/1g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfe1e7AAoJEB2Cnv7KVigS9cIL/15LkvqKtpT6tWheuOrFOfx5
CdteH5xRV7x8HZpysUfAQ74QvbVlzKOsNyTia+xtHLN6jD7gNQsU/wrzs7LGK3mP
5X/zaKb4/ZKX/8ZX3UcchWDznab2zvMfoCNK6XU8pxrmZAJmW1CvUHOuFg7TQjQX
2GNCMzPsW0aTgejLaxSnzaehR1TUp0jEvnwUX8UYJBlNSgKGskRXUZ5gRkiwSFiC
ftxVBmy//w15GkJBKRVxDqJXvSpwbNLIsPLlTv+vf4EApblMa0WhE3CJ/sY6gkmq
QVszyDWNZ8COMa0AlHOSPfzoR+gczKYWrnyBx841eugbq+YpZK+qk8qbpM8PdQsG
HzE4vovJxbjpKR4uZthAsVd2u9Dh7Hdz1sJkSGuCgwzDfRc7lBvLF/jh3w0u/pun
IT5gfehbhF1PIPgIrHhwBgwOQWma+EbZh0+ooaCSfQttBJJFLQZ3XeNtCJGpDPP+
tZ3CMLMB5MLcFLZs84fsYunpNid0y2Ybvt9sy1DCWg==
=yrhR
-----END PGP SIGNATURE-----

--twlwrnvElrG9k/1g--

