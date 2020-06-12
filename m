Date: Fri, 12 Jun 2020 20:27:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200612182733.GN1431@...1296...>
References: <20200609175503.GU1431@...1296...>
 <CAKuzo_hOf8oLo7vD9OYDvVkSzAd7R5iKhcayDX4W5Q9ExHcVYQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="qOJWHLx/t6Wq3h1B"
Content-Disposition: inline
In-Reply-To: <CAKuzo_hOf8oLo7vD9OYDvVkSzAd7R5iKhcayDX4W5Q9ExHcVYQ@...278...>
Subject: Re: [Openvpn-devel] async plugin-auth-pam
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qOJWHLx/t6Wq3h1B
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 12, 2020 at 02:22:01PM -0400, Selva Nair wrote:
> I do not have a patch, but had briefly considered this while looking into
> handling "dynamic challenge" through the plugin.
>=20
> Just deferring an authentication is easy but the server will still stall =
if
> another client comes in during that deferred period as pam auth is handled
> by a single process. The plugin forks leaving a child running as root, and
> talks to it via a scoket. The latter does the pam authentication. As pam
> runs within that process, it will still be waiting for the authentication
> to complete in a blocking call to pam_authenticate(). I felt it will take
> considerable effort to make it handle pam auth asynchronously.

My idea was:

 - send the auth request to the "pam child", including the control file name
 - pam child returns "I'll do this asynchronously"
 - pam child forks
    - grandchild does the (blocking) PAM stuff, and writes to auth control
      file when done

that way, there should not be any blocking.

(Some care needs to be done inside the grandchild so that there is no
shared PAM state or whatever - so anything that happens at "init" now
might have to be moved to "after grandchild fork()")

> Things may be easier if modules that take long to verify the credentials,
> return something like PAM_INCOMPLETE, so that it can be called back later.
> But that is beyond our control, and I'm not familiar with async support
> within PAM or in PAM modules.

I don't really want to trust "3rd parties" here...  well, I could try
to figure out FreeBSD's pam_radius and make that one asynchronous, but
PAM is full of interesting surprises - so "do it in our plugin" sounds
easier.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--qOJWHLx/t6Wq3h1B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe48kUAAoJEB2Cnv7KVigSPFUMAIcBrZui2t0ha+b7vfJGY3XG
prtdi5QuyCGGQucomcAO4I7YST+DkIQwvd5ffHn2teie/a2JqKSJWx5cFtvc5zMK
LIafu70NqbV4SBaI8KsrrF187AAv/pOjbfoKQq05PynmARZZEJMGy07SIC09nGFp
Ivmh0FK8LVU0VrxgQnFD+A87ESZg1qpfPHXb7gqugzfh7FYgg+LDADIVyeNxDhTP
2aCYQyzqWktlGJgLCenLrkBzwWIS0xKS4R5ovwCLM5Ms4fKCRGBI6yMfHSSswk6R
gXKMXWq1mfyO+8SGILTRwDWtSNmUzowMNPaQlpKYsyzf2gh6VOmHTtElOPM6euku
iyrshlzK3K1F8lAxttN9to6o/1qHygC9Xth9t6KKPU5+46K98PYZzOpaQqcS3MoP
Oa9wsfR2p5D7g029k38MpErrXZztQwNoAIn4CYjuSvkf6VmVV5Fyfrwd6ArhDrab
eUZr62B6cYdHFKeAtaR+K0Oqs3mPNlLj+8NYc56JWg==
=neYC
-----END PGP SIGNATURE-----

--qOJWHLx/t6Wq3h1B--

