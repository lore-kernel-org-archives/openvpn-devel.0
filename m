From: Heiko Hund <heiko.hund@...1489...>
Date: Sat, 11 Nov 2017 19:01:39 +0100
Message-ID: <14117750.0tLOEtx7P3@...2319...>
In-Reply-To: <02594b96-a2ba-f9c7-2a3a-7992a61fc846@...2080...>
References: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
 <1477672963-5724-7-git-send-email-heiko.hund@...1489...>
 <02594b96-a2ba-f9c7-2a3a-7992a61fc846@...2080...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 6/7] argv: do fewer memory re-allocations
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

On Wednesday, November 9, 2016 11:58:21 PM CET David Sommerseth wrote:
> >  argv_init (struct argv *a)
> >  {
> >  
> >    a->capacity = 0;
> >    a->argc = 0;
> >    a->argv = NULL;
> > 
> > +  argv_extend (a, 8);
> 
> Why 8?  Done any performance and/or memory utilization tests?  Does the
> overall memory consumption increase with this?

I figured it is a fine initial length for the argv vector. No science behind it 
whatsoever. If 8 doesn't suffice the argv is reallocated.
 
> > @@ -126,10 +138,7 @@ argv_insert_head (const struct argv *a, const char
> > *head)> 
> >  const char *
> >  argv_str (const struct argv *a, struct gc_arena *gc, const unsigned int
> >  flags) {
> > 
> > -  if (a->argv)
> > -    return print_argv ((const char **)a->argv, gc, flags);
> > -  else
> > -    return "";
> > +  return print_argv ((const char **)a->argv, gc, flags);
> 
> There are very few callers of print_argv() (defined in buffer.c).
> Should we migrate print_argv() into this function and move all callers
> over to argv_str() instead?

print_argv actually prints a char** and is not affiliated with struct argv, even 
though its name suggests it. So, if we want to do it it should be an add-on 
done after this patchset.
 
> > diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> > --- a/src/openvpn/tun.c
> > +++ b/src/openvpn/tun.c
> 
> tun.c:2360 close_tun() seems to be missing a argv_free(), or?
> The same goes for close_tun() in tun.c:2482 and tun.c:2956
> (tun.c:2821 does have it though).
>
> Similarly, in open_tun() [tun.c:2926], argv_new() is called but no
> argv_free() calls.

Nice catch, they were missing back in the argv_reset days as well. While at 
it, also removed a couple of unused struct gc_arena.

> On a not so related note.  I noticed that init.c have a
> #ifdef ARGV_TEST block.  That should probably also be killed; no need
> for that as we have unit tests - and the argv_test() function it calls
> no longer exists.

Aaand it's gone.

Cheers
Heiko

