Date: Mon, 25 Mar 2013 09:38:20 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20130325083820.GR17727@...1296...>
References: <CAHQBeznzF4k-Bx_VSBwAwuy8FYKny3Zcf=6knJwZG8=W4kgVBg@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cp3Cp8fzgozWLBWL"
Content-Disposition: inline
In-Reply-To: <CAHQBeznzF4k-Bx_VSBwAwuy8FYKny3Zcf=6knJwZG8=W4kgVBg@...278...>
Subject: Re: [Openvpn-devel] PolarSSL-1.2 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Eugene Rudoy <gene.devel@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--Cp3Cp8fzgozWLBWL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 25, 2013 at 12:35:12AM +0100, Eugene Rudoy wrote:
> Dear openvpn-developers,
>=20
> I'm wondering what is the best way to submit patches to the openvpn
> project.=20

Send the patches to the openvpn-devel list, and if you don't hear from us,=
=20
keep nagging on the list and in #openvpn-devel on freenode.

> The patch I (er13) added more than a month ago to this ticket
> https://community.openvpn.net/openvpn/ticket/250 has been completely
> ignored. Instead the patch submitted directly to this list has been
> accepted and committed. It's not that my patch is better (btw. I'm not the
> only author of it, my patch is based on MaxMuster's one), it just it seems
> that you don't pay enough attention to your own bug-tracking system and
> some of the patches submitted there simply get lost. I would appreciate it
> if you could improve yourself in this regard so that the people investing
> their time don't get disappointed ;-) Thanks!

Actually, the PolarSSL 1.2 integration was a bit difficult due to=20
constraints voiced by James Yonan ("no user visible changes"), so=20
the initial set of PolarSSL patches that have been sent to the list=20
in January got rejected at FOSDEM.

Indeed, we have not been that good at following up on trac-reported
issues - not due to bad will, but due to lack of time.  Sorry for that,
we're working on improving things (and as said above: if we lose track
of something, please remind us on the list and/or the IRC channel).

(In this particular case, it would have helped of the Freetz people=20
would have talked to the fox-it people somewhat earlier, before duplicating
the effort...)


> To the PolarSSL-1.2 support itself: I must confess I didn't test it but I
> believe the new implementation of verify_callback in ssl_verify_callback.c
> is incorrect (
> https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/ssl_verify_pol=
arssl.c#L46).
> It always returns 0. The error is signaled just by setting *flags to
> non-zero value. The flags variable is then reused by PolarSSL for the next
> certificate in the chain. So it might be that the incorrect certificate
> chain won't get accepted but from reading the code it seems that non-zero
> flags coupled with zero return value might result in spurious verify error
> messages for other certificates in the chain. Please correct me if I'm
> wrong.

I can't particularily comment on that - Adriaan, Steffan, could you
check this, please?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Cp3Cp8fzgozWLBWL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUVAM/KkuBuNlUUl1AQKrfQQAhnzML+Rn8+H2K6Di3w+0UJ8IiZII4gRw
2eu9VK8+53w7M3FzILx4Jfep46paH1lcAHtW8rVDiFYkZtfcPYV2E9O7LTgMbvJK
rKeI7qevvZcM8mPUUs3URCQJSRtUZbDzjSvj4He5aurlISeQEmEU2CbhDqDSIxMi
aU68XSodP+0=
=+RpQ
-----END PGP SIGNATURE-----

--Cp3Cp8fzgozWLBWL--

