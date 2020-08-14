MIME-Version: 1.0
References: <98f65e22-a66c-aeea-f705-ad5a0f7a2e28@...1227...>
 <20200814171204.22289-1-themiron@...2010...>
 <18c95bb9-408c-a608-fd2c-9f8b5f6f88eb@...1227...>
 <CAKuzo_iRjG_pEqjYsaKNniL8LuZ1EL+ok-6BS8Ys0xnOaEwsXw@...278...>
 <00c901d6726e$0f38d480$2daa7d80$@yandex-team.ru>
In-Reply-To: <00c901d6726e$0f38d480$2daa7d80$@yandex-team.ru>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 14 Aug 2020 15:36:57 -0400
Message-ID: <CAKuzo_ibSX=M+Z4cm0KqALv0P4EusLRjqrSiZXHbR=99VwEX8Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Allow management to kill client
 instances by CN wildcard
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Vladislav Grishenko <themiron@...2010...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi

On Fri, Aug 14, 2020 at 3:06 PM Vladislav Grishenko
<themiron@...2010...> wrote:
>
> Hi,
>
> Yes, killing a client with cn ending in * will also lead to killing all the
> clients whose cn starts with that prefix.
> Use other char would no-intuitive (ex. +).
> What about optional "prefix" mode word for explicit mode (can be also
> enhanced one day with suffix/regexp/etc).
>
>         kill cn [mode]: Kill the client instance(s) having common name cn.

That sounds good to me -- avoids the use of any special character.

Also, updating the "help" command of management interface was missed
in the previous version of the patch.

Selva

>
> --
> Best Regards, Vladislav Grishenko
>
> -----Original Message-----
> From: Selva Nair <selva.nair@...277...>
> Sent: Friday, August 14, 2020 11:22 PM
> To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
> Subject: Re: [Openvpn-devel] [PATCH v2] Allow management to kill client
> instances by CN wildcard
>
> Hi
>
> On Fri, Aug 14, 2020 at 1:36 PM Arne Schwabe <arne@...1227...> wrote:
> >
> > Am 14.08.20 um 19:12 schrieb Vladislav Grishenko:
> > > In case of some permanent part of common name (ex. domain) and/or
> > > long complex common name consisting of multiple x509 fields, it's
> > > handly to kill client instances via management interface with just
> > > prefix of common name, not by exact match only.
> > >
> > > Patch allows to use asterisk as wildcard placeholder in the last
> > > trailing symbol of kill command parameter.
> > > Single asterisk - empty prefix would be too greedy and can be too
> > > harmful, therefore not allowed. Wildcards in the middle of parameter
> > > string are not supported to keep the the things simple at the moment.
> > >
> > > v2: fine tune comments
> > >
> >
> > Thanks for v2,
> >
> > Acked-By; Arne Schwabe <arne@...1227...>
>
> '*' is an allowed character in x509 common name unless we explicitly forbid
> it. So killing a client with name ending in * would get tricky if not
> impossible without side effects.
>
> Selva
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

