Date: Sun, 2 Nov 2025 09:34:10 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <aQcXgtGRUKqadBPc@...1296...>
References: <CAOh3LPP9XVUU7TGHP51RdBEYSRKW1ih3EV_-FxiNxmiZCCS47g.ref@...278...>
 <CAOh3LPP9XVUU7TGHP51RdBEYSRKW1ih3EV_-FxiNxmiZCCS47g@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="uzKYJYAdz5Dck+IG"
Content-Disposition: inline
In-Reply-To: <CAOh3LPP9XVUU7TGHP51RdBEYSRKW1ih3EV_-FxiNxmiZCCS47g@...278...>
Subject: Re: [Openvpn-devel] Question for the devs - Found something
 interesting in the OpenVPN source code that I change in my modified
 version...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jon Chiappetta <root@...2904...>
Cc: openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>

--uzKYJYAdz5Dck+IG
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Nov 02, 2025 at 01:35:30AM -0400, Jon Chiappetta via Openvpn-devel =
wrote:
> In this file and that line number there is an integer i that is outside t=
he
> for loop so that it can look for the matching session key index number.
> However, there is an if statement after the loop which checks for the
> following conditions:
>=20
> if (i =3D=3D TM_SIZE && is_hard_reset_method2(op))

This is interesting because we have received another report about this=20
a few days ago (from the ZeroPath AI), and it definitely looks like a
bug from here.  This is Arne's code so I leave it to him to confirm.

> In my modified version I wasn't sure of when this hard reset check
> condition would be true but to prevent an invalid memory access I changed
> my code to be this instead:
>=20
> if (i =3D=3D TM_SIZE || is_hard_reset_method2(op))
--uzKYJYAdz5Dck+IG--
