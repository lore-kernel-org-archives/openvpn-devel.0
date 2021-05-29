Date: Sat, 29 May 2021 11:44:23 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210529094423.GC976@...1296...>
References: <20210525173838.3969-1-selva.nair@...277...>
 <202105270711.14R7BOiW072533@...2054...>
 <CAKuzo_j8+Kp_89t=wxQMtNbav+FuDnzooh=Vt3FtTBUOH8WMng@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="GY5ufA7/5KqklXOj"
Content-Disposition: inline
In-Reply-To: <CAKuzo_j8+Kp_89t=wxQMtNbav+FuDnzooh=Vt3FtTBUOH8WMng@...278...>
Subject: [Openvpn-devel] RfD: Windows code, UNICODE and ansi
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--GY5ufA7/5KqklXOj
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, May 27, 2021 at 11:40:59AM -0400, Selva Nair wrote:
> > (I do wonder if "support ansi builds" is really something we want, if
> > that makes the code so complicated - "always UNICODE" seems to be much
> > simpler.  What is the drawback of not supporting "ansi" builds?)
>=20
> I prefer to write all new Windows code as unicode without any dependency =
on
> the defines UNICODE and  _UNICODE --- i.e no TCHARs, explicit API calls,
> no _tprintfs.
>=20
> For old code, an easy option would be to retain the TCHARs, but assume
> we only build with UNICODE (TCHAR=3DWCHAR) and going forward don't care
> to support ANSI builds. As we did with the service.

I'm not the person who writes and debugs most of the windows code, I just
see patches pass by, and some bits are "more readable" and others less
so :-)

So my "vote" would be towards what you propose - always build unicode,
and for older code, assume (or force-#define) UNICODE.

Plus, document this somewhere.  On our styleguide page, maybe?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--GY5ufA7/5KqklXOj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgsgz2AAoJEB2Cnv7KVigS9GML/3tHIHntzyr8wEt1fKy7b76J
lZnHxpUOn2mI8dYTNS76qn+kAK20Vq2q+vwIDmA2vrMwqAa5QMgQUh9BR+Yh20Va
/7P688suNkYo6aPQ/J9101vgyYiIlJdYGDeuFaBe001G630AtTYurPEg8znr7mqq
0m45DvVwDsl4kdM9vSnypC6080CjRKCUTj76XDjokMl07j2NO1aVet45+V5DbQn4
Z7KcDWgZBF7aCXT5kMIRDzMVfBKGbO6HxR1Br97ClzJHWqWtor2Tlt3mq5WszeRB
gNmoP6vy2r4DqYn4byVmnCkGVb7Z7eIJq4+TX83yMSSc+A5IdAHH+EjmQrbK60cL
jez5fpgohL+x+qBh1lHXubigqK890vyyHeduXTwpUS2/7r70W+y9/NxYJN+vhuE/
dMWYP/DTYZab3QBdTSmLny9yadsdJdjmSPhyxlTuMy7vTQ98onTC+q423X62gw63
13lyyl6IbKkcYKUSOxJhIzwFHAMWrnsYmmZDq3HOvw==
=I74h
-----END PGP SIGNATURE-----

--GY5ufA7/5KqklXOj--

