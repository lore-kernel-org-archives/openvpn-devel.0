Date: Mon, 13 Feb 2017 18:50:00 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170213175000.GU93896@...1296...>
References: <CAOAUwZH8aRg-5XLJaYjpzw6y9yptx-ma7QJVPJT-yKFE7cmUrw@...278...>
	<c3f91fee-f629-fd60-c66c-19d45df6f24f@...1856...>
	<CAOAUwZF0LYNAYESg1fKeNUhJr70pLcf89HTyxTQmf2S3RnoUBA@...278...>
	<0cdcbed7-801c-9cec-cd03-1252c06b4466@...1856...>
	<CAOAUwZEiSjAEmTka=w-4TePAoGEZBZG1r_5gS-wpXL+TLX7qCQ@...278...>
	<20170213083137.GK93896@...1296...>
	<CAOAUwZF2-KXfMTwOuLj-B3wzWtD-i-8NytNkbS3gyvexaCpWGw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A1VS04HCCjrR2aaM"
Content-Disposition: inline
In-Reply-To: <CAOAUwZF2-KXfMTwOuLj-B3wzWtD-i-8NytNkbS3gyvexaCpWGw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix building with LibreSSL 2.5.1 by
 cleaning a hack.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Olivier W <olivierw.ml@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--A1VS04HCCjrR2aaM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Feb 13, 2017 at 06:46:11PM +0100, Olivier W wrote:
> 2017-02-13 9:31 GMT+01:00 Gert Doering <gert@...1296...>:
> > Look at "git rebase --interactive", which will enable you to squash
> > three commits into a single one.  Then you can use "git commit --amend"
> > to work on the (combined) commit message until you're happy with it.
>=20
> Thanks a lot. I've finally squashed my commits, pushed to github.

Good :-)

> Now I'm fighting with git which doesn't want to use gmail's smtp
> server to send the email. My .gitconfigure file is similar to:
> https://git-scm.com/docs/git-send-email#_example and I've added
> "smtpsslcertpath =3D /etc/ssl/cert.pem" but I'm getting this error:
> "STARTTLS failed!  at /usr/local/libexec/git-core/git-send-email line
> 1371."
> I'm currently searching for a solution.

That's a not exactly helpful error message... :( - I tend to just turn
off SSL on stuff that goes to public mailing lists anyway if it causes
issues...

> BTW: sorry about the previous email: "[SPAM] [PATCH] Fix building with
> LibreSSL 2.5.1 by cleaning a hack." :-/ I'm trying to not post anymore
> buggy email here.

I've created my share of weird git e-mails in the past :-) - so what I've
started to do is "send the mail to myself" (if possible, on a different
account) and then verify if the result is what I want to see...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--A1VS04HCCjrR2aaM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYofHHAAoJEB2Cnv7KVigS3usL/3+0kO7eSnL1+7hWkQLzP6Sc
mY2SwXRpLvAEvC2EbXBJKnLqQSSy/XCqKPUj1ebFVjXxfMzk+tNO/FR0grzZNEX2
qgisvnualgYF8IRrtYXwOzxyzkXyI3trAGjJR5u0xu6vW5GSv5zBGIw8LDTO1lYw
XrqmZQoLUznDBGUwhCkqUSeJkCsskJ8cP8iYOeoDjkQe7Xncb6DKkeyPLCp310Z1
NJ6Qg86ohznrM/3A6N3y+eOwIBA2aOaP3tIxo47EHHFGKk8gtZKM7m13TP6/ZvYv
+mR1xkBHITGepQhPg0lzYnynEiUC1xbBABB3CJANoXcRszBFdNIMNxWIAV5KYMRB
ljU0mlNhXIxyE2uzHXACd1RsOD14cRaAsOJTDgEfqUI+gOPh4wb2ScX/rNctmawY
0Y4edE60Zd0szXjkkMaTShQrolYLQo/8v6G2FYHyGpBHxbGnH5SApeA+U+ApkCkt
0BIP3a26TYfqKi+D+dm9wLcEmIs8KDqe2YZj3Q1h4g==
=EzwD
-----END PGP SIGNATURE-----

--A1VS04HCCjrR2aaM--

