Message-ID: <510133EC.6000408@...1114...>
Date: Thu, 24 Jan 2013 14:15:24 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAM2vnFOwy-1=5VzUYFnssAMavmGgFYiqO7=GiEUNs2n+EpC-BQ@...278...>
	<50FFDC58.3050202@...1114...>
	<CAM2vnFP-S62qf0OQ5YSdJm_tH+zkcz6gYUapvt==Le0OjciFvw@...278...>
In-Reply-To: <CAM2vnFP-S62qf0OQ5YSdJm_tH+zkcz6gYUapvt==Le0OjciFvw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig07AB1035083452E354300379"
Subject: Re: [Openvpn-devel] [PATCH] OpenVPN Obfuscation
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: 77 77 <siren1117@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig07AB1035083452E354300379
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 23/01/13 14:42, 77 77 wrote:
> On Wed, Jan 23, 2013 at 8:49 PM, David Sommerseth
> <openvpn.list@...1114... <mailto:openvpn.list@...1114...>>
> wrote:
>=20
>     On 23/01/13 11:21, 77 77 wrote:
>     > Hi all,
>     >
>     > I wrote a patch to obfuscate OpenVPN's traffic to avoid protocol
>     > identification. Compared with other traffic obfuscation methods like
>     > using static keys or obfsproxy, it only adds one more config
>     parameter,
>     > and supports both TCP and UDP. If OpenVPN releases support this,
>     lots of
>     > devices will benefit from traffic obfuscation without installing
>     > additional softwares -- for exsample, the newly released OpenVPN
>     Connect
>     > for iOS or Openvpn for Android.
>     >
>     > The patch is based on openvpn-2.2.1, but works fine with
>     openvpn-2.2.2.
>=20
>     Gert said one very important thing about openvpn 2.2.  Even though, he
>     said to bring it up to openvpn-2.3 or git-master .... I'm saying
>     git-master is the natural point.  If you need to have it in openvpn-2=
.3,
>     backporting it from git-master is far easier than going the other way.
>=20
>     I've looked quickly at your patch.   And the first instinct is that,
>     yes, this looks reasonably well.  This is also a feature which I think
>     will be very useful in the coming future.
>=20
>=20
> I hope OpenVPN be more connectively from every place, every device. My
> friends and I have been using this patch for a while.
>=20=20
>=20
>=20
>     Just a few comments ...
>=20
>     - Have you looked at the obfsproxy project from TOR?  That does pretty
>     much a similar thing and does work together with OpenVPN (but only via
>     TCP, as it uses the socks5 proxy mode of obfsproxy).  Could it be
>     considered a better approach to integrate tighter against obfsproxy?
>     obfsproxy provides a more "plug-in" oriented approach where there
>     obfuscator logic can be changed at runtime, and doesn't necessarily
>     depend on a encryption/obfuscation key.  What you basically do is to =
RC4
>     encrypt the data.
>=20
>=20
> The shortcome of obfsproxy is that you have to run the proxy along with
> OpenVPN. If people want to use OpenVPN on mobile devices, it's easier to
> use if we have in-place obfuscation ability. For example, OpenVPN
> Connect is avaliable on iOS, but failed to connect from some
> countries.

Just to make one thing clear.  The OpenVPN Connect for iOS and Android
are not using the same code base as the OpenVPN version you patched.
Those use a completely new code base which has not been open sourced yet.

> /In such circumstances obfsproxy can't help, but in-place
> obfuscation would work./

I don't necessarily think that obfsproxy should be used with the socks
approach as it is possible to do now.  But rather look more into details
how TOR integrates more tightly with obfsproxy.  Or maybe contribute to
obfsproxy so that it can be used as a library, linked into openvpn.

> Currently, this patch *JUST* works. And I agree that a "plug-in" system
> for obfuscation is more robust and easier to extend.

And in the future, flexibility in obfuscation will be highly needed.  It
all depends on how many will make use of this feature and whom that will
annoy most.  But what you have done so far is a great Proof of Concept.
 It shows very well how to hook obfuscation into OpenVPN.  That is
highly appreciated work!

I strongly believe in re-using as much code as possible, including not
increasing the code maintenance.  The OpenVPN developer's team isn't
big, so we need to have code which will be easy to maintain many years
into the future - including extending the obfuscation and security
related issues.  So depending on a more active project like obfsproxy is
a big plus, IMHO.

Please misunderstand me correctly ... I do like the idea of obfuscation
in OpenVPN.  And there have been several requests on such features
already.  However, when we implement this officially, it needs to be
code which can live and be easily maintained in OpenVPN for many years.
 So that's why I'm taking the stance I'm taking.


--=20
kind regards,

David Sommerseth


--------------enig07AB1035083452E354300379
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlEBM+8ACgkQDC186MBRfrreZQCffYFOsHbPPpNvy7GvRvMxlW4M
hpUAoInuBt441AJ6jX+1OjVN3zMmLo+g
=r3SR
-----END PGP SIGNATURE-----

--------------enig07AB1035083452E354300379--

