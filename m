From: Heiko Hund <heiko@...2662...>
Date: Thu, 17 Mar 2022 13:06:56 +0100
Message-ID: <1694181.r3cYAWFjbh@...2664...>
In-Reply-To: <YjMQUsyqUaxzlAWn@...1296...>
References: <20220308230621.1532809-1-heiko@...2662...>
 <20220312135810.242028-1-heiko@...2662...>
 <YjMQUsyqUaxzlAWn@...1296...>
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

Hi Gert

On Donnerstag, 17. M=C3=A4rz 2022 11:41:22 CET Gert Doering wrote:
> I wonder why we bother to actually *do* this?  As in "we already know
> that this can never overflow here" (because all strings involved are
> known, and the max width of %d is known, too), but *if* it ever did,
> calling the subsequent setenv_str() wouldn't be a good idea to do - no?

It's in the spirit of defensive programming. It cannot overflow now, but wi=
ll likely overflow some time. However I thought that getting the value into=
 env might still be worthwhile in some scenarios, even if the name is not c=
omplete, e.g. if the env is logged somewhere. The error message in the open=
vpn log, will lead to cause then.
=20
> Can we make transform these into a miniwrapper that does
> like
>=20
>    for (i =3D 1, d =3D o->search_domains; d !=3D NULL; i++, d =3D d->next)
>    {
>         _do_dns_env_thing( "dns_search_domain_%d", i, d->name );
>    }

I actually had such a wrapper in place, but dumped it because I didn't like=
 the fact that the value would have to come before the name in the argument=
 list, because of the var-args. Since we have a format string with two %d (=
and there might be more / other formatting specifiers in the future), the w=
rapper would have to deal with ..., or we'd end up with two wrappers (or mo=
re if this is extended in the future). No matter what:

>            const char* format =3D s->domain_type =3D=3D DNS_RESOLVE_DOMAI=
NS ?
>                "dns_server_%d_resolve_domain_%d" : "dns_server_%d_exclude=
_domain_%d";

requires it to be:

 _do_dns_env_thing(d->name, "dns_server_%d_resolve__domain_%d", i, j);

right now already. And that lead me to not making things wrapped.

However I could be talked into removing the checks for openvpn_snprintf()'s=
 return value if there's a consensus, as it wouldn't introduce an actual is=
sue. Just maybe a little harder to debug issues in future code possibly. Al=
so not setting the env if sprintf fails sounds good, would do this rather:

if (openvpn_snprinf())
    setenv_str();
else
    name_ok =3D false;

Iff the value is really not useful in the env, when the name is incomplete.=
 Bonus: no &=3D.

Heiko



