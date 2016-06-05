MIME-Version: 1.0
In-Reply-To: <CAFHpkQG-er+5B6KXae46eoXb1DVHaNP8qVjkEtFzLDcsHe3qQQ@...278...>
References: <CAFHpkQG-er+5B6KXae46eoXb1DVHaNP8qVjkEtFzLDcsHe3qQQ@...278...>
From: Steffan Karger <steffan@...1856...>
Date: Sun, 5 Jun 2016 09:47:02 +0200
Message-ID: <CAA1AbxKJE2hwxhEO=ShT4o+at7rs6sdT3KYKRSfgNEQGOZfOVg@...278...>
Subject: Re: [Openvpn-devel] clang static analysis
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On Sun, Jun 5, 2016 at 9:33 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:
> I performed the following steps
>
> 1) cloned master branch of https://github.com/openvpn/openvpn
> 2) autoreconf -iv
> 3) ./configure
> 4) scan-build make
>
> (scan-build is clang tool for static analysis)
>
>
> report is here:  http://chipitsine.github.io/openvpn-clang-scan/

I've been running these on a daily basis, see:
https://delft.syzzer.nl/openvpn-scan-build/

(I'm not promising anything about these scan-build runs - they might
break or I might take the server down at any time.)

> I think we should take care of those warnings.

They need to be checked, yes.  And some are even easily fixed, so
patches are welcome.  But some are just bogus, or the fix would be
worse than the problem.

For example:
https://delft.syzzer.nl/openvpn-scan-build/2016-06-05-000019-19327-1/report=
-5b3247.html#EndPath

Yes, gateway is not read in linux builds, but that's totally harmless.
Adding more #ifdefs or moving the assignment away from the assignment
of 'network' and 'netmask' makes the code less readable.  I'd rather
let the compiler optimize the assignment away.  For such cases it's
too bad that there is no 'state' where we can tell scan-build to
ignore this error in the future (without polluting the code with
annotations etc).

-Steffan

PS We might want to consider running scan-build on travis-ci in the future.

