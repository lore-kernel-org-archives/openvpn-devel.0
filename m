From: Heiko Hund <heiko@...2662...>
Date: Sat, 12 Mar 2022 13:50:19 +0100
Message-ID: <2111633.qLNB2pmg8L@...2664...>
In-Reply-To: <a3f031c2-d845-72c4-9ce8-6edb84b5d914@...1227...>
References: <20220308230621.1532809-1-heiko@...2662...>
 <a3f031c2-d845-72c4-9ce8-6edb84b5d914@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] add support for --dns option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

On Mittwoch, 9. M=C3=A4rz 2022 13:40:32 CET Arne Schwabe wrote:
> Am 09.03.22 um 00:06 schrieb Heiko Hund:
> > +bool dns_server_priority_parse(long *priority, const char *str, bool
> > +[...]
> > +void show_dns_options(const struct dns_options *o);
>=20
> These new functions are missing doxygen comments. We generally have the
> doxygen comments in the header files rather than in the c files.

Okay, I'll move the comments into the header file.

> > +--dns args
> > +  Client DNS configuration to be used with the connection.
>=20
> This man page section sounds like all options are supported on all
> platforms while currently that is not the case. An explicit warning etc
> that says that some options like port, dnssec, doh etc are not supported
> on certain platforms should be included and also what happens if they
> are not.

Noted. What happens will likely be determined when we have the=20
implementation(s) that actually take this option and try to apply it. Think=
 it=20
is too early to add this info to the manual, as it may change. Some ideas=20
exist, but they have to prove themselves and survive public discussion. So =
far=20
I have the idea that options will be ignored if they are not supported, and=
=20
split DNS is turned into all DNS redirected to the pushed server(s) if they=
=20
are unsupported. Again, this is very theoretical at this point and may chan=
ge=20
once facing reality.
=20
> >  The ``--dns`` option will eventually obsolete the ``--dhcp-option``
> >  directive.>=20
> > +  Until then it will add configuration at the places ``--dhcp-option``
> > puts it +  and will override it if both are given.
>=20
> Is dhcp-option ignored when dns is present by newer client or are they
> mixed? This is a bit vague.

Will clarify.

> > +  long priority;
>=20
> why a type that is 32 bit on some platforms and 64 bit on others? Either
> go with just int if 32 bit is enough or use long long or int64_t if we
> need 64 but long is a weird type.

int8_t would be enough, just need an extra few bits for the conversation fr=
om=20
text. It is a long because strtol(3) returns a long, and I went with that. =
Not=20
sure if casting after checks will gain much. If we decide to change this I'=
d=20
rather use int8_t however, or a future somebody will ponder why the extra b=
its=20
there, when the priority is really a 8 bit value. IMHO it is not worth the=
=20
extra code, that's why I went with long. Compilers might align an 8 bit val=
ue=20
anyways.

> > +            name_ok &=3D openvpn_snprintf(env_name, sizeof(env_name),
> > "dns_server_%d_address4", i);
> bitwise and with a bool feels wrong. We should use && instead of & for
> boolean logic.

Since there is no &&=3D operator, I thought it's more readable with &=3D. T=
he=20
result is the same because of the way bool is defined. I'll convert it to=20
logical operators for the v2 and then we'll see if it looks and feels bette=
r.

> > +  enum dns_security dnssec;
> > +  enum dns_server_transport transport;
> > +  char *sni;
> > +};
>=20
> That should be probably be a const char* instead of a modifable char*

Right.

> >          gc_free(&o->gc);
> >=20
> > +        gc_free(&o->dns_options.gc);
>=20
> having an extra gc in this way feels a bit strange. Since this is the
> only time it is initialised you can just as well just use o->gc instead.

Actually no. The --dns option is a bit special as it can partially replace=
=20
local setting with pushed ones (i.e. override single dns servers and others=
=20
not). The contained gc is used to allocate (and free) pulled options. If we=
'd=20
use o->gc as well, the pulled options wouldn't be freed for a potentially l=
ong=20
time, increasing the memory footprint over time.
=20
> > +        struct gc_arena dns_gc =3D gc_new();;
>=20
> extra ;

Eagle eyes! =3D)

> > +        /* Free DNS options and reset them to pre-pull state */
> > +        gc_free(&o->dns_options.gc);
>=20
> There is an additional free for the gc here that has no matching
> gc_init. If your goal is to have a gc for the life time of prepull etc,
> then it is better to put it there as that is easier to see its lifetime
> than to have it only for DNS where the lifetime/ownership is not so clear.

The accompanying gc_init() is with the one for o->gc. Don't see how moving =
the=20
gc into struct options_pre_connect would change anything substantially. The=
=20
gc_init would still be done in init_options() then.

> I see also that this code makes no attempt to remove/refactor the old
> DHCP code. The only thing I see is the tuntap_options_copy_dns code.
> What the supposed way forward here? That also raises the question about
> platform specific code. Does that code now need two implementations? One
> for installing options from the dhcp structs and one from the DNS struct?
>=20
> Some idea how this is going to go forward would be good.

There are several ideas. Instead of having a #ifdef hell, like for other=20
platform specific code, I would prefer some sort of "dns plugin / script" w=
ay,=20
where platform specific code could reside in individual units and linked /=
=20
called on a on-demand basis. However I want the community to discuss and bl=
ess=20
an approach before implementing it. Later. For now this is the first step t=
o=20
get openvpn 2 and 3 on a common basis for (pushing) dns options. dhcp-optio=
ns=20
will fade then, once we have proper --dns code in. If it turns out some of =
the=20
dhcp-options are worthwhile keeping, I think it is best to introduce new=20
specialized (Windows) options to handle them.

Cheers,
Heiko




