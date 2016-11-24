Date: Thu, 24 Nov 2016 11:07:36 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161124100736.GD28918@...1296...>
References: <1479936104-4045-1-git-send-email-steffan@...1856...>
	<201611232216.uANMGwWk061543@...2054...>
	<20161123223257.GC28918@...1296...>
	<01253b2e-82aa-54e1-71e5-0bcd97b0c833@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A5AyRtFOAYcOCJfV"
Content-Disposition: inline
In-Reply-To: <01253b2e-82aa-54e1-71e5-0bcd97b0c833@...1856...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Poor man's NCP for non-NCP
 peers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--A5AyRtFOAYcOCJfV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 23, 2016 at 11:58:49PM +0100, Steffan Karger wrote:
> This will end up with the server and client using cipher bar (if the
> server has --ncp-ciphers <somehting>:bar).  The client-side poor-man's
> NCP is already guarded by "if (c->options.ncp_enabled)" (in
> do_deferred_options()).

Good point.  Seems I was not very much awake anymore :-)

  /* process (potentially pushed) crypto options */
  if (c->options.pull)
    {
      struct tls_session *session =3D &c->c2.tls_multi->session[TM_ACTIVE];
      if (found & OPT_P_NCP)
        {
          msg (D_PUSH, "OPTIONS IMPORT: data channel crypto options modifie=
d");
        }
      else if (c->options.ncp_enabled)
        {
          tls_poor_mans_ncp(&c->options, c->c2.tls_multi->remote_ciphername=
);
        }

... all fine, then.

thanks,

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--A5AyRtFOAYcOCJfV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWDa76KkuBuNlUUl1AQJxAAP+NE7rILdaMhvYT1We2F0Lix6pAP4iG8bn
82SVaAyBLnPDUKl8b+x87DB6FuOnfV0Gu0umLSBJljt+JS6zJarZ1mm3gFnE6Wgt
9yi5lykmiF8/eQvb7Ar81+BANk4MtiW815HLfbdqKIhVclwFX+J6NoFZ4PnGvlGa
9t5LAl73Yc8=
=bhlC
-----END PGP SIGNATURE-----

--A5AyRtFOAYcOCJfV--

