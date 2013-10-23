Message-ID: <52685102.4050201@...1850...>
Date: Thu, 24 Oct 2013 00:43:14 +0200
From: Thomas Murach <murach@...1850...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Linux client cant connect through socks,
 proxy - any known workaround?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: stevecookhk@...277...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

in my case, I had to add the following options:

pull
tls-client
persist-tun
comp-lzo

I'm quite sure that tls-client is the one you need. The others are
specific to your setup. I hope that this helps.

Cheers,
Thomas


Hi, On Wed, Oct 23, 2013 at 10:50:11PM +0800, Steve Cook wrote:
> I can't get openvpn to connect through my socks proxy server, and
searching
> around seem to find other users with the same problem, but no
> known solution.

It "should" work.  Does the Android client work?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSaFECAAoJEKQl1saKseE5nTkP/R50DTsaw2U/iYYY0h6IK6KP
zSrGX+XF5cw2dnXVHY/NjYL19kCflB97MxzjzGww6EpuMtesNFX5w7Qq01X+zksd
YOv6emgt9BhC5syyqYqFelr3MpV4kjCMBgP9vuZJZvIYfGssUgTdwAkeSxBYzjYt
jUSklqoRZaN48sw8mA4YPGHUqZgZEy+rIUpAE2pMT+DBF0GQdDgkCdJ1qNzYT26C
9uVpA8ie3Aw3VRhwssKffmdonJzHfVcbR5mh1w0sNQd2Dgcc9tSj7Elw3EjEdzi9
ML+03NZf++2OnEHO65V52g2HZ8Fq6pf1HnMOgCvv+kMMp5a5jDjR2MeMLComiR9Y
FkD+IdhHtd+8kGZS1sEtwdrs1rIewS+FWCS7qWGVUsDSt517jgpz9rSs2nOo5ELm
buCllZUVaZWko+Z3EQ0UPxv99Zdib63ZJZns5waDU0aSK5RlXhg4lqLmsMs4xjq7
2XpeLljtKUQ8LJrt+/PHcvFeLgBgDEG0+XhQZTkj112HvCSlDFQAkJEowgjMpFzH
e8T/REWZUlTjlf7oQNx0jpGUW134VOMKMWN8NM01zxJasjipGdzCUrNjdwIvVI4C
NyURsXTsue35lEJDiH2EEPchyK7A1983vZXRmETX/6uNoYWKsEH3nU90NhbucUe6
ZfYzCGmVQeCcZ03+F6xJ
=kHni
-----END PGP SIGNATURE-----

