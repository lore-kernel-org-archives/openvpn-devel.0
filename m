Date: Tue, 10 Jan 2023 22:56:10 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y73e+p668JhsXANA@...1296...>
References: <CAKuzo_g3qfaAB62SVxGPhjqan0+QPCNz6D1+EjRS6OL17Z2x=g@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8lCaPJy1jWfezgEe"
Content-Disposition: inline
In-Reply-To: <CAKuzo_g3qfaAB62SVxGPhjqan0+QPCNz6D1+EjRS6OL17Z2x=g@...278...>
Subject: Re: [Openvpn-devel] Conditions under which a connection entry could
 be disabled
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--8lCaPJy1jWfezgEe
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jan 10, 2023 at 04:42:50PM -0500, Selva Nair wrote:
> I'm trying to get this info into the GUI for handling
> "--management-query-remote".  Selecting a disabled entry from the UI would
> lead to erratic behaviour. Ideally this info (CE_DISABLED state) should be
> included in the response to  "remote-entry-get" command, but too late for
> that to happen in 2.6. It didn't occur to me when that command was
> implemented.

If you are REALLY fast we can bring it in _rc2 (planned for Thursday).

This should not be a very intrusive change and the only consumer of
the output today is the Windows GUI, so "compatibility" is not a=20
problem here (right?).

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--8lCaPJy1jWfezgEe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjvd76AAoJEB2Cnv7KVigSzIQL/j52Jm/qPRcGkhFgV36+1WLm
xHL2Ng30wLdtqImlbk34xnFT8oo5bBHJvHBDl/Be2ueQQN+pF3tBG1dxCDMFyTcP
sJTbZANwQZzWGnMJ0Ps2ORcZ6sSs0EXX+Ve6ZJFIGHtkzfUeiLvqQGEHynG16M+5
ofeAiJ0Ld2LfcF/iVLeI5hA1sAJJb3Lay4y0sJZlotcchZeYMDiWDiuK6GZLlIe8
UmNQavD8fU6rYammEYOycfwv8lAI2U2+lvr2R/Cpw8PZL42atVN5zLwjrWy9vX93
9soKgGvJVXk2wV6nTScGumlyh8uFjRFaiiPdLdI3wFIiX5sHJg2XMyYy6KeHnuhY
buh7Ut/zEd+CX49zPaqB+tKvXjqO7HlWmVWlKJoVmSNYxGzYjHv9Pw32K0Emjtld
11n47HF01inwFgr3IyM3+BeBblqHdkGt3R6RYjRQgqyrwICoY55ntJfzUEsockPx
8w5TkBHxHUZWPj3b+cPKZVAO/yTLjNKZyb0Nb5DHmg==
=fEqy
-----END PGP SIGNATURE-----

--8lCaPJy1jWfezgEe--

