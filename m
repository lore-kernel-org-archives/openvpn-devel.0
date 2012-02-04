Date: Sat, 4 Feb 2012 18:02:46 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120204170246.GW13929@...1296...>
References: <1328360184-15865-1-git-send-email-heiko.hund@...1489...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="enLffk0M6cffIOOh"
Content-Disposition: inline
In-Reply-To: <1328360184-15865-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH] UTF-8 X.509 distinguished names
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

--enLffk0M6cffIOOh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Feb 04, 2012 at 12:56:24PM +0000, Heiko Hund wrote:
> Since the specific character classes for X.509 names are removed, the
> "no-name-remapping" configuration option has no use anymore and is removed
> as well.

--no-name-remapping appears again somewhat further down in openvpn.8,
we should remove it from there as well.

---------------- quote ----------------
   String Types and Remapping
       In  certain  cases,  OpenVPN  will  perform  remapping of characters=
 in
       strings.  Essentially, any characters  outside  the  set  of  permit=
ted
       characters for each string type will be converted to underbar ('_').

       Q: Why is string remapping necessary?

       A:  It's  an important security feature to prevent the malicious cod=
ing
       of strings from  untrusted  sources  to  be  passed  as  parameters =
 to
       scripts, saved in the environment, used as a common name, translated=
 to
       a filename, etc.

       Q: Can string remapping be disabled?

       A: Yes, by using the --no-name-remapping option, however this should=
 be
       considered an advanced option.
---------------- quote ----------------

(well, seems the whole section needs to be rewritten to reflect the new
remapping rules [if any])

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--enLffk0M6cffIOOh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTy1ktqkuBuNlUUl1AQIJ7QQAqia1HWKM1LOfWmdXsw32+n0Bl93ETdp4
UqnjdYxXBG/KJqWIU/PsMZIIbPNrrYTAq5eNLdMYPleRazYFehkPEKa5sCFUCZBJ
Z+1r9Ff1VvlkHzwIHI23D8kJvCZMuI8fYqK9rDXw9/6RX3CtStTHD3tMw1Gt3DKQ
QeskmhSKu7U=
=7hYP
-----END PGP SIGNATURE-----

--enLffk0M6cffIOOh--

