Date: Wed, 26 Oct 2022 16:54:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Y1lKC+75SJEpCYXB@...1296...>
References: <20221019224642.11178-1-selva.nair@...277...>
 <Y1kr4zYWRP29K2G2@...1296...>
 <CAKuzo_iRT5SHQUq2jMnBsY6W+wmpVGS2y9d+saVX4dT7D=udiQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="BiEPDFWYWSZ76vCp"
Content-Disposition: inline
In-Reply-To: <CAKuzo_iRT5SHQUq2jMnBsY6W+wmpVGS2y9d+saVX4dT7D=udiQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH for 2.5/2.6] Purge auth-token as well
 while purging passwords
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

--BiEPDFWYWSZ76vCp
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Oct 26, 2022 at 10:18:19AM -0400, Selva Nair wrote:
> > I think this is not what this patch is expected to do, and would irk
> > a lot of my 2FA users (that are currently happy that I can restart the
> > openvpn server without them all having to do 2FA again).
>=20
> I think the intent of the original code is to purge all credentials by
> default in case of RESTART ---  [RESTART,P] was required to preserve
> credentials as you note below. But somehow we did not keep that behaviour
> when auth-token was introduced.
>=20
> But, I agree it may be useful to preserve the token in this case, though =
it
> will fail if restart moves to the next server, isn't it?

If you have a number of servers under common management, and they share
the auth-token secret key, a token received from "server A" will be valid
on "server B".  I'd consider that a feature :-)

If the token is refused on server B, the client will come back and look
at user+password credentials (which are now flushed, so will ask).


> > There is a theoretical way to avoid this (server needs to send RESTART,=
P),
> > but the --explicit-exit-notify code on the server has no way to trigger
> > this, so it's not helping.
> >
> > This also affects --management-forget-disconnect (obscure option of
> > the day), which, I think, should not forget tokens either - but I do
> > not have a strong opinion here.  I think OpenVPN should retain tokens
> > on disconnect due to "network change" or whatever, but then, I have
> > no idea when we'd want to use this option in the first place.
>=20
> IMO, management-forget-disconnect should forget the token along with
> passwords. The patch is meant to address this option and
> "forget-passwords". The use case: if you stop the tunnel and put the
> connection on management-hold and then detach from the management
> interface, another user connecting to it would be able to connect to it
> without entering a password. --management-forget-disconnect can protect
> against this.

I can see the reasoning for "forget-passwords".

I'm not sure I understand what the intended use of=20
--management-forget-disconnect *is* - if it's "disconnected by a button
press", the GUI can send "forget-passwords", and we do not need this
option in the first place.

If it's "disconnected by a network hickup", why would one want to=20
flush the token here, which is intended to seamlessly reconnect=20
after the hickup?

Is anyone actually *using* --management-forget-disconnect?  Just asking :-)


(This whole token thing is really great when it works, but it is
obvious that it wasn't there from day one, and not all combinations
of use cases, options and "events" seemt o really make sense)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--BiEPDFWYWSZ76vCp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjWUoLAAoJEB2Cnv7KVigSc+sMAIgX8qj22blTOmINDHlaV31N
20wsnLJqcwCxMf8MX6oIVAHc4n92URmoxF5pamQA3RD6MXtGrTbsOllLQUAnP6dw
m5tYgk8xgBOf2H8v34YiMhYUSVLaVZ73Nr4d53zRqaCzc9KaTX+9R3vHBS+es4Nv
h67JR8FcGjyJbumT5/PYgBEYwYxJKmrSs0XErUyxXOUkskhjUOEw0O6TJ9crNiCg
uL4LSVDP/sT13tdi2btQO6zhKa6OKYlbmX4Lrwa5+dqcMk6KBkEhAtI4nR/9tpiL
gKvS0xXFp6YjSaNLhtsMTEf03NHGYzgSLft7ZYywZN12EqTAgPAZ+CsNudEp8938
V1K1KdCh0lr6eWAh/n/M4mpT1Y7YJ0V3ydh1pQYKV0r0InNgQwq8P4JXnqorJa3d
D+c58/Ipl+lRj90ZRYiZhkHPTNAELAl1r6tolKNvDSpsXaIfDuyJIvRXr5e3sw9b
Owt0lK4qjbjCRQLADtqid6m2J6zB1gJaR9BMfnWKKQ==
=Kefr
-----END PGP SIGNATURE-----

--BiEPDFWYWSZ76vCp--

