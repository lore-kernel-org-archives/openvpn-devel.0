Date: Thu, 8 Apr 2021 17:52:51 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210408155251.GX976@...1296...>
References: <20210408140229.31824-1-arne@...1227...>
 <20210408140229.31824-3-arne@...1227...>
 <4f9a99ba-031d-43c7-c17f-8f842a519ddd@...1147...>
 <b0ecdfa9-7d53-35a9-cc98-cfbd23b7b4a4@...1227...>
 <3ec6cc2f-8d2f-4821-5265-8ec25267df88@...1147...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5KTTag3e2RWiTlKo"
Content-Disposition: inline
In-Reply-To: <3ec6cc2f-8d2f-4821-5265-8ec25267df88@...1147...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] Remove --ncp-disable option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--5KTTag3e2RWiTlKo
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 08, 2021 at 05:30:52PM +0200, Jan Just Keijser wrote:
> I don't have any evidence with 2.5 right now but this is just a matter=20
> of use/principle to me: I can very well see that I would like to have a=20
> setup *without* NCP as I simply do not need it (e.g. my cipher is=20
> hardwired to aes-256-gcm)=A0 and in that case I don't *want* NCP to ensur=
e=20
> my setup is 100% predictable.

By setting "--data-ciphers AES-256-GCM" on the client side, you achieve
a 100% predictable outcome.  No other cipher will be offered or accepted.

> Disabling this option means you give me less control over the setup and=20
> I don't like that, thus Feature-NAK.

Removing that option means "less confusing code variants that can lead
to 'it works with NCP but not with NCP disabled'".

Since I test all these variants, and find the confusing corner cases, it
would be good to have less code paths throughout OpenVPN, especially=20
in the server option negotiation and key setup phases.


> I'd say that removing the ability to disable NCP=A0 can happen *only* whe=
n=20
> all negative side-effects of enabling it have been mitigated fully.=A0 On=
=20
> a slow link the NCP overhead can be quite disastrous and not just during=
=20
> connection setup, but during the *whole* session. To me, yet another=20
> reason for Feature-NAK

The overhead of NCP is roughly "some 100 bytes sent extra from client to
server in the TLS handshake phase" (to announce the acceptable ciphers)
and "cipher xxx" in the PUSH_REPLY.

There is no overhead in the data phase.

Please explain how this can be "quite disastrous"?


(Of course, if NCP negotiates a cipher with more overhead than you'd
like to use, that would be "more overhead" - but this is fully under=20
the client's control with --data-ciphers.  It even works with "none",
provided both client and server permit this)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--5KTTag3e2RWiTlKo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgbybSAAoJEB2Cnv7KVigS3D0L/0gWALMMQCF8eL7Jw5M2IzcM
Tn451HIMqrRhIYFRJd9nMKrC6qxFB/QWSNHYEkGzawnTcrkdhJlxflnss6j6Wju2
VKnsKsOYR4lD26WfKc3vHBDYbXK91YU6A4oqqfUqCqWmhkoo5Axw1CpkiLFedZlT
ctMnz0IzlJwCsxgJWdunfYWb44EpZsJ3cpkqjUqLt3SHejjE2I8a7FxHW7ztoopr
aLrOPih+sAipPGhCxq3p4Pfed2Ymb7zEENfYgWPAGw1OmK1vlQ453OH42XBs2wdP
5acArdeBraHMP+4616JAtNwiVmGDTAKmBMpLufN1ovbXAfjozL7tdMPjSgYXh0/z
qVRbAE/fSfo1rarNqv9hzRMFhQOSRc4vt0agewWT8AvKSN+84xcDFeU8YLsXl/eS
bz3+fONa8+CWhzuvkwocVLgCjrGffg3utDsVjekPwshj8qQIX9XBakR7c8f0M4Re
2fceWc92u9272eeglC/i5yCaL+j/wBw0nK1oQXW9xg==
=9HzE
-----END PGP SIGNATURE-----

--5KTTag3e2RWiTlKo--

