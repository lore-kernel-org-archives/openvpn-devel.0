Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Tue, 3 Feb 2009 09:47:20 +0100
Message-ID: <499929A843E2C541A8AD31A881A2B6A202DF3E70@...1006...>
In-Reply-To: <200902021218.12326.alon.barlev@...277...>
References: <499929A843E2C541A8AD31A881A2B6A202DF38BE@...1006...>
	<200902021218.12326.alon.barlev@...277...>
From: "David Balazic" <David.Balazic@...1005...>
Subject: [Openvpn-devel] Diff format
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Alon Bar-Lev wrote:

Subject: Fix for "Cannot read current default gateway" problem on Linux

> On Monday 02 February 2009 11:49:50 David Balazic wrote:
> > diff -u openvpn_trunk/route.c openvpn_patched/route.c
> > --- openvpn_trunk/route.c	2009-01-29 15:00:04.525034400 +0100
> > +++ openvpn_patched/route.c	2009-01-29 15:03:41.116012000 +0100
> > @@ -45,7 +45,7 @@
> >=20=20
> >  static void add_route (struct route *r, const struct=20
> tuntap *tt, unsigned int flags, const struct env_set *es);
> >  static void delete_route (const struct route *r, const=20
> struct tuntap *tt, unsigned int flags, const struct env_set *es);
> > -static bool get_default_gateway (in_addr_t *ret);
> > +static bool get_default_gateway (in_addr_t *ret, char *gw_if_name);
> >=20=20
> >  struct route_option_list *
> >  new_route_option_list (struct gc_arena *a)
>=20
> Which version of diffutils do you use?
> How come there is a tab after file name in the header?

Well, I asked and it seems to be the normal state of things:


    * From: Dave Korn <dave dot korn dot cygwin at googlemail dot com>
    * To: cygwin at cygwin dot com
    * Date: Mon, 2 Feb 2009 17:56:10 +0000
    * Subject: Re: diff inserts tab into header ?
    * References: <WorldClient-F200902021754.AA54240210@...1190...>

xerces8 wrote:
>>> I discovered this when trying to send a patch to a project and
>>> they rejected it because of this tab chars.
>> Are you sure this is the case? Can you send the exact message they
sent
>> you when they rejected the patch?
>
> Sure, they said this:
>
>>> Which version of diffutils do you use?
>>> How come there is a tab after file name in the header?

  They must be using a custom version or something strange like that.
The
TAB is placed there by the routine 'print_context_label()' in context.c,
you
can view the CVS history at

http://cvs.savannah.gnu.org/viewvc/diffutils/src/context.c?root=3Ddiffutil
s&view=3Dlog

and it's been right there since version 1.1, seventeen years ago (see
line 46).

  So AFAICT GNU diff has /always/ done this.


Regards,
David

