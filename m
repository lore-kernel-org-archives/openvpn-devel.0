Date: Wed, 6 Aug 2025 13:55:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <aJNClx2_V05IEiJV@...1296...>
References: <CAOh3LPOwuAO84y7kUcWNQFVes8rwRg6WZ9dAUBTAqLTrDMtaLQ.ref@...278...>
 <CAOh3LPOwuAO84y7kUcWNQFVes8rwRg6WZ9dAUBTAqLTrDMtaLQ@...278...>
 <ebe735de-ee37-4cc2-aa41-1ac10f8744b4@...1227...>
 <CAOh3LPMj6WQgsUS00Jke0nNvRW8U0hTY78RYG5FTgCVQF38daA@...278...>
 <aJM69j31LSPdL3hN@...1296...>
 <CAOh3LPOeEYg=BbsJj1SfYSDPi0y3muKy7PGo-vO41zOfwZ9kkw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="mHEAACsBtKGF/bsZ"
Content-Disposition: inline
In-Reply-To: <CAOh3LPOeEYg=BbsJj1SfYSDPi0y3muKy7PGo-vO41zOfwZ9kkw@...278...>
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
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--mHEAACsBtKGF/bsZ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 06, 2025 at 07:46:53AM -0400, Jon Chiappetta via Openvpn-devel =
wrote:
> With my modifications made, I can specifically and directly target an exa=
ct
> 1500 byte MTU VPN link so that it correctly matches the LAN and WAN side =
of
> the networks which is really important network wise and I can also let TCP
> at the kernel level beautifully handle huge streams of bulk data and
> ordering and delivery on my behalf as efficiently as possible. This would
> be a pretty nice modification if I could make it through to the end.

This is *exactly* what OpenVPN will do out of the box, as of today - do
an interface MTU of 1500 (unless told otherwise), and if you do TCP,=20
the TCP layer will handle the necessary segmentation.  If you do UDP,
you get outside fragmentation.

Here's a few tcpdumps in different config scenarios, demonstrating
the 1500 bytes "inside" just fine

  https://community.openvpn.net/MTU%20and%20Fragments

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--mHEAACsBtKGF/bsZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJok0KXAAoJEB2Cnv7KVigSNrAL/0HD55xhNgLXgtj4ybF6I2OD
s8Ybu1D5W7j3kjbrbXZDp6RUD0dFWtDW7Vq4yT7M3IOu0sSfhoECh7QdjvW8PiQf
/vJW9OusqkPiBdlZQ8K5tMzHQDLJugM8EPsjQNrC2D1F5oKiXS7dFpVbKtTa86Ds
koov+7CXxRArjF72Zf2+MPLAViCCLuKtHBKHL+6cYkcyIyhRe0PX5HqG3TN2vUSA
xVUiiqrWkRPSsSm9h1cyr03zpi/fD6geKDlj01BTGM5ib3OpY0ECHHoa59VjEzcJ
yuHHZUCwL4ylIjfaMFdie/Cx4qnE0z8io9T0gcH8rwANj8MV9GuhxBIW8t0kU84H
nX+2xOTVUTSQWjLx36F81iMm3oyocr3v4rdDon9SRWqIilQ8eHPKe3BoWNNS+uAo
2N2Rm7IqtrbaHMZPNvUhiFO39I6SUkJhgWc/qU9nw6AtWTBXaL9z7ySK/ahMrnv5
t0h+zVMmyD1hyLdi9VkkoAK8EQiVtjNq6oyUMe6L2g==
=CSy3
-----END PGP SIGNATURE-----

--mHEAACsBtKGF/bsZ--

