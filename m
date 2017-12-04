Date: Mon, 4 Dec 2017 20:25:15 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171204192515.GA69387@...1296...>
References: <20171010231130.6832-1-simon@...2293...>
 <20171010231130.6832-9-simon@...2293...>
 <20171105192019.GM958@...1296...>
 <99D61A626FDA8A4B90A270669121BE108587DA0D@...2294...>
 <CAKuzo_hTnJVcEuCqCQ-ZR3swbkio7CWZgy3z5C0fWVJ-E0PCvQ@...278...>
 <99D61A626FDA8A4B90A270669121BE108587DF29@...2294...>
 <CAKuzo_jFp86anFk6mgavBoYhmCCHUeJ_EQpb6Z05PTNJxBYWWw@...278...>
 <99D61A626FDA8A4B90A270669121BE10858830C4@...2294...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="C7PTD44AewjTsiSV"
Content-Disposition: inline
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10858830C4@...2294...>
Subject: Re: [Openvpn-devel] [PATCH 09/13] Signed/unsigned warnings of MSVC
 resolved
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: Selva <selva.nair@...277...>, Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--C7PTD44AewjTsiSV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 08, 2017 at 06:46:53PM +0000, Simon Rozman wrote:
> > The best time to re-factor a function would be when a  a new use case n=
eeds
> > to change its semantics. Apart from the ill-chosen -err as a return val=
ue,
> > currently it returns 0 if automatic metric is in use, making it impossi=
ble to use
> > it as a generic function to find the current metric of an interface.
> >
> > In fact I've a pending patch where such a change would help.
[..]
> I shall give it a look after the Hackathon.

"ping"?

This seems to be the only hunk left from the MSVC correction series
(as far as .c/.h files are concerned, not .proj)

gert

--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--C7PTD44AewjTsiSV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaJaEaAAoJEB2Cnv7KVigSaZ8L/jdPup+VDUL/qrVSWoE8NTBL
xkxpuSSEblCvVoAHLp7huYkU9Zkqx6nrO341qmhlz7R4YezskoG/rPV8zVX3VPQ7
6HtJXFtZ2xGhGXlFDJkyBpEYybuk/gEPjm0jQhhoOBHaxKvQmq+hI72P8oH2NP1O
rq0+rYF7tmiC7LrdXG7p4Sm3C8g4q7aWS4Ad4QVroOxBH9szY0qH3YO+DFGftgBQ
BItRSvldlASVOAXb7LPmfSmVTSZaBgMR+SkPwohDZIlR/5OFEiWuTCLdNfH57ZOV
3zBegdpphgGprjMX7njlgRCxo2R2npLMsxNLZarmwYHVBQ2Je2Zopphoy0HKFuux
gzt1wrnx7DBvFigM1m+Mj1HUr5eHiXZhY+3YZyPkq2W94HFDTyAtBOtz0Cf/4Eab
FGYKKnv80wtt5gbbLkYiRwEMmA/ws4nVVoAKJzHEHaN/uBKEfM4D5o4wJMNPheGm
e49GELIFucaAwuN+kt15cDsf/hXze7feuuZlElI6cg==
=IxjO
-----END PGP SIGNATURE-----

--C7PTD44AewjTsiSV--

