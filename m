From: Heiko Hund <heiko.hund@...1489...>
Date: Sat, 11 Nov 2017 19:14:14 +0100
Message-ID: <11801832.vcSP6HBFNE@...2319...>
In-Reply-To: <b03806c9-d95f-9e2f-01a4-57f312f21e0f@...2080...>
References: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
 <1477672963-5724-8-git-send-email-heiko.hund@...1489...>
 <b03806c9-d95f-9e2f-01a4-57f312f21e0f@...2080...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 7/7] Add gc_arena to struct argv to save
 allocations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Thursday, November 10, 2016 4:01:20 PM CET David Sommerseth wrote:
> On 28/10/16 18:42, Heiko Hund wrote:
> > 
> > +  a->gc = gc_new ();
> >    argv_extend (a, 8);
> >  }
> 
> Any specific reason we want to keep our own gc_arena on argv?  Why not
> pass an existing gc_arena pointer to the argv_new()/argv_init()
> functions?  I believe the majority of places argv functions are called
> already have a gc_arena prepared.  But I do see it may complicate the
> argv_reset() function.

The idea was that struct argv is usually very short lived. Some callers do not 
have a gc and would need to create one just for using struct argv, others have 
one and it is rather long lived, so  it would hang on to the memory much 
longer than needed.
 
> When looking over the final argv.c file, I also wonder about this:
> 
> const char *
> argv_str (const struct argv *a, struct gc_arena *gc, const unsigned int
> flags)
> {
>   return print_argv ((const char **)a->argv, gc, flags);
> }
> 
> Why not use our own internal gc_arena?  Especially when considering the
> current callers:
> 
> void
> argv_msg (const int msglev, const struct argv *a)
> {
>   struct gc_arena gc = gc_new ();
>   msg (msglev, "%s", argv_str (a, &gc, 0));
>   gc_free (&gc);
> }
> 
> The situation is identical for argv_msg_prefix().

The difference between argv_str and argv_msg is that the latter one doesn't 
pass the gc_alloced string to the calling scope. In that case the caller shoul 
take care of when the string is freed.

> The overall impression I have is that this patch-set is truly valuable
> and does important clean-ups and fixes a lot of ambiguity and odd
> behaviours.  And getting proper unit tests on top of it all is truly
> great!  But there's still some improvements needed in the last 3 patches
> (patch 5, 6 and 7).

Thanks for taking the time to review this. Let's do another round for 5-7.

Cheers
Heiko

