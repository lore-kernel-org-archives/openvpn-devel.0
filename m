Date: Fri, 13 Oct 2017 19:36:16 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20171013173616.GR958@...1296...>
References: <99D61A626FDA8A4B90A270669121BE10857D3DCD@...2294...>
 <CAFHpkQGZuQUZBqPmsZkBDx1CPiG5KmKKi1Kn_pL9JqwiiQcOaA@...278...>
 <99D61A626FDA8A4B90A270669121BE10857E61C4@...2294...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
Content-Disposition: inline
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10857E61C4@...2294...>
Subject: Re: [Openvpn-devel] openvpnserv building under MSVC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: ???????? ?????????????? <chipitsine@...277...>, "openvpn-devel (openvpn-devel@lists.sourceforge.net)" <openvpn-devel@lists.sourceforge.net>

--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Oct 12, 2017 at 11:16:33AM +0000, Simon Rozman wrote:
> 1.       Should I post all MSVC-specific file changes as a one single lar=
ge patch? (.sln/.vcxproj/.bat files, without .h/.c)

That would be my preference.  But for the existing patches (unless they
are stale), keep 'em as they are.

> I don't want to make too much confusion here and/or risk some or all of m=
y work to get overlooked or rejected.

Don't be dramatic, as we've already merged part of "all your work" :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZ4PmPAAoJEB2Cnv7KVigSdrkL/10g+oU6IfXG+CRZGRdCCL1k
rcn1dL5a5oEfw3stcku5PhnaB3YPn23QAFxD175Xeex52jTcuTuZg5i5I30nPFPG
sTy1+ZFDlhIvigvT3ubutZmXNk8woS5vgrf2qRVriYxCQ0OB3x3dpAv2fely1MjG
9SuTiPmjChmecfsR5IB5HOmcNFOO8HeCSM18P9YWTndfvcIlOgA+JqoK1GQKIP5E
deDCiDw2WCk5MXaQkSEk2ojetht4nKiwqhaEH4mEl8cUTplpFT5y6TWhl7qA4T7Y
P5DEnXtDa4PvPC/Uo3DhoXY8KLi+oiwudKeZI60EBYsw+OS457fE2ckGhEZ33Sr3
Y9n4WxJJzNFgW2a94zQL4svaCN6RGoIzIRc5DOKf7QZyvwXKgq4WoVDxn8RMbFNB
NbUnr8bMWL1fYtPQe1KYxvYxLpRUKYKo+8BOyLtUp8gckmRG0kYAFdGRVo4S/UK/
RrhQRyCu4QFJEyXXM8pjyVQowqEyr14a1KY/RaD4Ag==
=ZWHE
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--

