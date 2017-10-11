Date: Wed, 11 Oct 2017 19:00:36 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20171011170036.GM958@...1296...>
References: <20171010231130.6832-1-simon@...2293...>
 <20171010231130.6832-5-simon@...2293...>
 <CAKuzo_iQtWLganoH3n39hASRThrqmpHYh8ec=STm9yxeeROGYg@...278...>
 <99D61A626FDA8A4B90A270669121BE10857E3A0D@...2294...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10857E3A0D@...2294...>
Subject: Re: [Openvpn-devel] [PATCH 05/13] Function prototypes are declared
 as "typedef <return type> (<calling convention> *type_name)(<arguments>)"
 in MSVC.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: Selva <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Oct 11, 2017 at 01:57:03PM +0000, Simon Rozman wrote:
> Do you still maintain 2.3 branch for Windows XP? You do know, that replac=
ing=20
> GetProcAddr() with statically linked Vista+ API calls would break=20
> compatibility with Windows XP.

These patches won't go into 2.3 - 2.3 is in strict maintenance mode,
and the code base is sufficiently different (especially wrt to openvpn
interactive service, which is not in the 2.3 code base and not needed on
XP anyway) that it would need more effort for backporting.

In other words: just ignore XP.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZ3k4zAAoJEB2Cnv7KVigSXTQL/1jQcHzf626hRwfbbZ73q+7O
VQU1b5UBH1+wf6b5p+h6x7t1uj8rCKR6n48sjz3AKc9Qc1IkvXSvvEFx+zfWlLI9
bD1tyJqXZZ+oYHBmt3KLW5nJdxL4ZvBEMpMtHyslj3Thlxz8FNukFC7KkidRp0Uz
318GB3WF++8qll4tinW0FboiYecXKn5sFBL5Wwqk9t+aAJNaFL1ahCPQc3U4NAQv
YdT1LJJEqU3hQW70q3bdF8QHLMnCvhnQ/Hrf3gdkO9SZ3Q1/M9a3zIrkTDY1L3Pw
9TFO7Y9CuGlec9zO9iquT9tc0LOEQBDX4z/vBMTxFO/7jwTv8+TLZin5FNJ5qBpX
4NbzXKGLFW4zwVbzw2e7vzfmwglBMgrD87rfBV9PLjQVDeMRBj2Dl583rZ5BKBcm
CY7Q7nDfP8216EnMERQxZoWV9qH5B+cymL7rBECdNzYzddjITVsrLLGt9SV/OIBN
RwrtA3iNOYMG+iW4UO0UxSyuYnv88vz1YMq8VGxcKA==
=1awN
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--

