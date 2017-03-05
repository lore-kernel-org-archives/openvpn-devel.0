Date: Sun, 5 Mar 2017 13:26:51 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170305122650.GL93896@...1296...>
References: <79d89580db6fd92c059dabc4f5f4d83b72bb9d3d.1487859361.git.logout@...260...>
	<201703050953.v259rZMs067447@...2054...>
	<3af72d9f-1d38-f9c7-8ebd-3ac16baa09c4@...1856...>
	<CAKh=nwEE3vXYcmtr5cvcCjQMjY2SZNGwAjY8eMzEh1wxHUJTrw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PjYxckON9mHZ0A1q"
Content-Disposition: inline
In-Reply-To: <CAKh=nwEE3vXYcmtr5cvcCjQMjY2SZNGwAjY8eMzEh1wxHUJTrw@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: OpenSSL: don't use direct
 access to the internal of RSA_METHOD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Emmanuel Deloget <logout@...260...>
Cc: openvpn-devel@lists.sourceforge.net

--PjYxckON9mHZ0A1q
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 05, 2017 at 01:08:09PM +0100, Emmanuel Deloget wrote:
> I don't like it much either but I cannot think of a better solution.

I haven't said that I don't *like* it :-) - I came across it when=20
doing a "post commit sanity check" and assumed that there are good=20
reasons.  Just wanted to clarify this, in case someone else looks
at the call chain and wonders.

All is well :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--PjYxckON9mHZ0A1q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYvAQKAAoJEB2Cnv7KVigSLrML/3ORMs6gnUrxwqGp560ANXWP
O/XWy3R0BbbKONbeRpJT5KkCleE0whHLbDjIqas2a9yhYVa7lCt8eBARnI/C6YBi
foS8TIxFGf9JQZtHBnyjMelkAfIZcniQpl5yxTMRA3UJXfkkyE8H7ObQYX9u6R3t
TKuqGQKvmxZBeVZDmXj+CpcGk3KzqQbhEyFHg0drYi2YkDxNoQ5X018lv3f7uDIw
OryE2cJCtIp+PUk8LtvcDvcFelEhXU/N0/hlnr66GGkR8iFt+9F0DH0k+6MPCtv2
Ni8tihx5auQiNdc29rkyGT9qSnWNLgdEwJsrw/00JJjA7Va5zaGSy+RMrZOrLxJE
QWGmoKde2JAgC46Mq3u+RMWWX010diy9sAYePhw7R7znnzoQhX+G1HtZkAg/tGRa
r6A3oCiTBnACfoMs+3K5I0LgoOjDy0K0ggRMm7H6tqrw8FbKojcuLRpalhZ3vueg
Q1ynICneHWCDrbcFyOs3u4tEvOo6lfJbh1BKceJsyQ==
=Zp+i
-----END PGP SIGNATURE-----

--PjYxckON9mHZ0A1q--

