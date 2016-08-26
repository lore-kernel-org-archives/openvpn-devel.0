Date: Fri, 26 Aug 2016 14:10:23 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160826121023.GX78279@...1296...>
References: <326b8ff7-39a6-1974-c0b0-82fd2abdc7b7@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2cZ01xMxx5MYbKUa"
Content-Disposition: inline
In-Reply-To: <326b8ff7-39a6-1974-c0b0-82fd2abdc7b7@...277...>
Subject: Re: [Openvpn-devel] 2.3.12 vs git-master with cipher negotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--2cZ01xMxx5MYbKUa
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 25, 2016 at 04:17:25PM +0100, debbie10t wrote:
> Now server cannot negotiate --cipher and is set at AES-256-CBC
> Connecting linux client cannot renegotiate --cipher and is set at=20
> AES-256-GCM
> On --ping-restart --cipher is not reset and so the client can no longer=20
> connect.

This is a problem indeed, thanks for noticing and clearly describing it.

(In other words: upon reconnection, the --cipher setting should be=20
"what is in the config", not "what was negotiated in a previous connect",
so it needs to be stored in a session-dependent variable internally, and=20
not override the config variable - which makes the code less nice...)

Steffan, are you listening? ;-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--2cZ01xMxx5MYbKUa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV8AxrqkuBuNlUUl1AQJhfQP9EK+s7TdmdEj5X4b31XbS20UddqaBJX4J
6m8NjxAJ8yL8c3BqBR5CXisNWztjuG9HDCj35titL6jrb6Quk729K0WJTB3UiMDW
E9yGJv4KsVJxa7faII36Lfq+PuLJH3m8yNbh0cTpJnWhNFX/As8cdgTqn2/8lt0q
EpsWFuTxcks=
=8My6
-----END PGP SIGNATURE-----

--2cZ01xMxx5MYbKUa--

