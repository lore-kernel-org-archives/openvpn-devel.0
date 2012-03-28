MIME-Version: 1.0
In-Reply-To: <4F72D60D.30405@...1147...>
References: <20120326160546.GV1359@...1296...>
	<CAOazyz1W7ZcVEhDwq0DWCOjQ_DetcjP6yDg1MhOPiMYqu2Sr6w@...278...>
	<20120326175543.GX1359@...1296...> <4F72D60D.30405@...1147...>
Date: Wed, 28 Mar 2012 11:14:44 +0200
Message-ID: <CAOazyz0262BjtxkuHxeY8mJvNkwWoX4GQ5N__DLT1f3iGO0d5A@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [DISCUSS] much more complicated gcc invocations
	now
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
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, Mar 28, 2012 at 11:12 AM, Jan Just Keijser <janjust@...1147...> wrote:
> Hi,
>
>
> Gert Doering wrote:
>
> Hi,
>
> On Mon, Mar 26, 2012 at 07:51:01PM +0200, Alon Bar-Lev wrote:
>
>
> The benefit is to divide the code into libraries and core which is
> easier to maintain and reuse.
>
>
> I'm not sure I understand what's so hard about "compile stuff, use
> 'ar' to pack into libopenvpn.a" that stuff needs more convolutions.
>
> We're not building a shared library - which I agree is major pains unless
> handled by libtool.  But static libraries are easy on about everything
> (except Windows, can't speak about that).
>
>
>
> actually, most of the problems I've seen with libtool have to deal with
> shared libraries - I would NOT trust libtool to be able to build shared
> libraries the way I want it to, esp when shared libs use other shared libs.
> don't know if libtool 2.x solves the issues found in 1.5
>
> Anyway, new automake does support silent rules, try the following[1]
> patch and see if it makes you happier.
>
>
> This is missing the point: I think what automake/autoconf is doing now
> is much too complicated.  I *like* to see what it's doing, and hiding
> complexity by just not showing it is a step into the wrong direction.
>
>
>
> I fully agree with Gert here; if we can avoid libtool then I'd really like
> to do so - it only adds an extra layer that (IMHO) is not needed; what was
> wrong with the "old" method?

I tried to explain during this thread, do you have a specific question?
Anyway, we also found that it is not libtool that cause the long
command, but rather old gcc which probably did not handle the deletion
of dependency file correctly so automake/libtool compensate that.

Alon.

