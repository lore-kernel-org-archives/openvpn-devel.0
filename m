Date: Tue, 21 Apr 2015 22:35:48 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150421203548.GH382@...1296...>
References: <CAK6ywb+fMsyvOz+saw9XBO4KDx1srdB92H71OwcKFPZnyxHkqw@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S6vg04ofUPzW4qJg"
Content-Disposition: inline
In-Reply-To: <CAK6ywb+fMsyvOz+saw9XBO4KDx1srdB92H71OwcKFPZnyxHkqw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix autotools check for res_init (#523)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Nicholas Hall <ngharo@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--S6vg04ofUPzW4qJg
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Mar 06, 2015 at 01:07:38PM -0600, Nicholas Hall wrote:
> Autotools configure check fails to detect res_init on recent glibc
> versions.  It appears that resolv.h in recent glibc maps res_init to
> __res_init which autotools doesn't catch.

Coming back to this.  I agree this needs fixing (for 2.3.7 and 2.4), but=20
I am not convinced the approach is the right one - it's too brittle, and
I think we don't really need the #ifdef HAVE_RES_INIT at all.

Why?  Because all (unixy) OSes that we support have res_init() - checked
man pages for *BSD, MacOS X, Solaris, AIX and Linux.  MS docs for Windows
are unclear, but if it's not there, we can always #ifndef WIN32 it...

So I'd prefer a patch that would just find the necessary library to link
(-lresolv, -lsocket, whatever) and otherwise assumes that res_init() is=20
just there, no matter whether it's a macro or anything else.

Comments?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--S6vg04ofUPzW4qJg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVTa0pKkuBuNlUUl1AQI8PQQAs1n63u/gZbZcMxq9SQh8D49/26kplbir
3AMhcVG/r38wa/jH0NN3WzUTSkPOPOnSCPZV0L2dZmyo0K0Goe0BNNGuGv/d4CH+
XW0OwRtTBahAFSqZDi/9AUs5uqoI2oiV5O9x1UqF98HHFJsoNDdhtKRThQlV7evo
q4Cjj7ZvR5A=
=BI91
-----END PGP SIGNATURE-----

--S6vg04ofUPzW4qJg--

