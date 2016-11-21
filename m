Date: Mon, 21 Nov 2016 18:51:08 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161121175108.GN28918@...1296...>
References: <1479660357-12843-1-git-send-email-gert@...1296...>
	<1479746562-751-1-git-send-email-gert@...1296...>
	<CAKuzo_icJA4OPTjTeX9nUOMXskTCG0xg8Gtf0z+fTQjwz5Ki0w@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7kKNbsfnwzLokd41"
Content-Disposition: inline
In-Reply-To: <CAKuzo_icJA4OPTjTeX9nUOMXskTCG0xg8Gtf0z+fTQjwz5Ki0w@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Stub implementation of
 "--dhcp-option DNS6 <v6addr>"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--7kKNbsfnwzLokd41
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 21, 2016 at 12:20:41PM -0500, Selva Nair wrote:
> This will fix it. Hopefully non DHCPv4 options like this wont proliferate.

Not in the short run anyway :-) - medium term we'll see what is needed
to provide to windows clients (and *how*) if we run IPv6-only...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--7kKNbsfnwzLokd41
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWDM0DKkuBuNlUUl1AQJ5uAP9GPWshlrpeyq1OcZiWVM4d4QdMo0A1cHB
3B57QWAO7CwHUuytjuMOf2u2Z1RqaZ8gNq+fzZdXWIZvBp0ivygrvvEFgLki18Lb
nRnoks0O+DqTIDwbHElvZu0sAVMm82f3ERQm3LT3w1EzNydo6cURgUE8ANyVxNSu
9gn6jI3QYbY=
=jtZZ
-----END PGP SIGNATURE-----

--7kKNbsfnwzLokd41--

