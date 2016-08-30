MIME-Version: 1.0
In-Reply-To: <c99aa195-c433-4843-dde2-789a636572d4@...2080...>
References: <1472413323-21723-1-git-send-email-steffan@...1856...>
	<5109e5e1-bdc9-4920-fe3e-72461a3ed546@...2080...>
	<22844900-214f-b69f-ef15-ace77cf56bbe@...2080...>
	<CAA1AbxJ_e+7Jjk=FNsgGzPNOrrTXdyf7VGyicOJpSxTbVdi7dA@...278...>
	<22cfbc88-7a12-f039-ff12-4e1c971de4b0@...2080...>
	<c99aa195-c433-4843-dde2-789a636572d4@...2080...>
From: Steffan Karger <steffan@...1856...>
Date: Tue, 30 Aug 2016 11:26:22 +0200
Message-ID: <CAA1AbxKd+16OCLsYbdO4aH_pNkVx+vfi0-DUcz8w_TSNmD-j4A@...278...>
Subject: Re: [Openvpn-devel] [PATCH (master)] Drop gnu89/c89 support,
 switch to c99
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 30 August 2016 at 00:41, David Sommerseth
<openvpn@...2080...> wrote:
> Just some more benchmarks.  I just compiled successfully with -std=c99
> on an old Scientific Linux 6.5 (RHEL 6.5 clone) I found.  Another
> important detail, RHEL5 will reach the "End of Production" phase March
> 2017, OpenVPN have generally stopped supporting the oldest RHEL
> releases once it hits EOL.  RHEL 5 subscribers may purchase an
> extended life cycle, but we have not cared too much about that so far.
>
>
> There is one detail though regarding the patch itself.  Your patch
> adds -std=c99 to the CFLAGS quite early.  The compile line gets quite
> interesting if you try to swap this setting by using the recommended
> approach:
>
>    ./configure CFLAGS="$CFLAGS -std=gnu89"
>
> Doing this results in the command line being run during compilation to
> be be:  gcc -std=gnu89 .... -std=c99 ...
>
> So the -std argument appears twice.  This should probably be avoided.

Hm, good point.  But I don't think settings CFLAGS="something" should
overwrite *all* our default CFLAGS (I know there are currently none,
but I'd love to add extra warning flags to the defaults in the
future).  We could do something like we did for the deps, i.e. add a
CFLAGS_STD that defaults to (.e.g.) -std=c99.

-Steffan

