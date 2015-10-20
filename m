Date: Tue, 20 Oct 2015 23:28:27 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20151020212827.GN22054@...1296...>
References: <1445277979-21591-1-git-send-email-gert@...1296...>
	<5625FF23.70203@...1400...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u1miaA4NINTr2SbH"
Content-Disposition: inline
In-Reply-To: <5625FF23.70203@...1400...>
Subject: Re: [Openvpn-devel] [PATCH] Add option --push-suppress-ipv6 to stop
 sending IPv6 info to clients.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <schwabe@...1400...>
Cc: openvpn-devel@lists.sourceforge.net

--u1miaA4NINTr2SbH
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Oct 20, 2015 at 10:45:23AM +0200, Arne Schwabe wrote:
> Am 19.10.15 um 20:06 schrieb Gert Doering:
> > Workaround option for servers that have IPv6 working just fine, but
> > need to turn it off for individual clients - in that case, set this
> > option in the --client-config-dir file for a particular user, or
> > via --client-connect script/plugin hook for a particular platform
> > (like IOS 9.0.2)
> >
> ACK from me.=20

Heh :-) - this was more thought of an "here, what do you think?" patch
(plus "fix valdikss' headache in #614 quickly"), and I didn't expect an
ACK so quickly...

... and then a discussion on IRC later.

But Arne actually had a very good idea which I'm going to implement and
send "soon":

 --push-filter <keyword list>

like,

 --push-filter ifconfig-ipv6 tun-ipv6 route-ipv6

which would do exactly what the current patch did, but is much more flexible
depending on what exactly needs to be worked around with *this* client...

(There's a trac ticket about "--push-reset", which we might resolve with
this as well :-) )

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--u1miaA4NINTr2SbH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBViax+qkuBuNlUUl1AQJFwAP+IxyvM5yNDOykntsY66Cglf6mT4BtU9Wa
XARmjisrXzga2I7LRP8ZiHmzChdyfrDf0lDEg4mOZpmMmpC7qqQDjIiwFY8ZBkfH
DmVC98fd4BHMpPVTuGQOLPBA83bkh/cpnWPwyHrYKPi5N/MFaxk0hoJUHa0l44Gl
6SxZ0cJGl1A=
=QsJJ
-----END PGP SIGNATURE-----

--u1miaA4NINTr2SbH--

