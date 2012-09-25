Date: Tue, 25 Sep 2012 09:57:29 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120925075728.GD742@...1296...>
References: <1348477246.32678.YahooMailNeo@...1765...>
	<20120924091835.GX742@...1296...>
	<1348557760.30714.YahooMailNeo@...1772...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7tPHY7RFL01rOa8z"
Content-Disposition: inline
In-Reply-To: <1348557760.30714.YahooMailNeo@...1772...>
Subject: Re: [Openvpn-devel] multi threading support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ehsan enayati <ehsan_en85@...109...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--7tPHY7RFL01rOa8z
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Sep 25, 2012 at 12:22:40AM -0700, ehsan enayati wrote:
> I saw in the linux source code that it uses fork and pthread, i think tha=
t's the way it handles multiple requests

Neither.

Fork() is used to, uh, fork other processes (for example to start scripts).

pthread is not used at all - there was some experimental code that used
multithreading to get crypto into its own thread, but that has been=20
removed for 2.3 because it wasn't complete and didn't work.

Multiple requests are just queued in a, uh, "work queue" - which is
basically a glorified array of things-to-do - and then processed one
after another.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--7tPHY7RFL01rOa8z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUGFj6KkuBuNlUUl1AQKBgAQAhJfr2E1gR3neGcpI7Wb4chvTSDnekeIy
ntaVRIbU7xdAskNdnd2h37tcfNuhgF0455R07dKVR6zb7zjgDe2WmThAVDpGC0ew
yq3UZuHhqKB3HF8VSCF8DvcBRzOxTRXFBWws4cc20ZMdOMAOAGnVnfC0XBRto9ZO
FyEms76hF/0=
=Qbh1
-----END PGP SIGNATURE-----

--7tPHY7RFL01rOa8z--

