MIME-Version: 1.0
In-Reply-To: <4EE2289D.3090507@...1114...>
References: <1323301588-29815-1-git-send-email-davids@...1347...>
	<1323357860-2506-1-git-send-email-davids@...1347...>
	<20111209080212.GC18948@...1296...>
	<4EE2289D.3090507@...1114...>
Date: Fri, 9 Dec 2011 20:19:31 +0200
Message-ID: <CAOazyz1Y8cXmm1py=V-6+N2tBQx1OS42Hq5buVSH4UJYxRHQYg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3] Move away from openvpn_basename()
 over to platform provided basename()
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, Dec 9, 2011 at 5:26 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
>> These changes, just to take into account some system somewhere that
>> has a basename() implementation that modifies the argument string, are
>> ugly, and prone to memleak-errors. =C2=A0Also, some other "basename(3)" =
man
>> pages talk about basename() returning a pointer to an internal static
>> storage which can be overwritten at the next call - so the code above
>> would then not work on such a system (as the next call to basename()
>> would modify the memory are where options->dev is pointing to).
>
> For the record, I did some valgrind checks on this change. =C2=A0And for =
some
> odd reason, this doesn't leak. =C2=A0Even though --dev-node is explicitly=
 set.
> =C2=A0But it might be that the gc_* magic functions somehow catches this
> allocation as well.
>
> Also note that init_options_dev() is only called once during the
> execution, and this allocation *only* happens if --dev-node is used.
>
> And the only reason I say this is to try to avoid posting a v4 patch ;-)
>
>> So I'd propose to keep openvpn_basename() - it's simple and short
>> enough, and has well-defined semantics that can be relied upon.
>
> The original openvpn_basename() is based upon the GNU basename() which is
> not modifying any arguments, so this is definitely cleaner.

In my opinion, in order to avoid confusion there can be two options:

1. Use library functions as much as possible, providing the minimum
common ground
in compatibility layer if missing. This ensure applying fixes and
functionality from
various upstreams.

2. Use own implementation everywhere, taking responsibility and
control over the implementation
and maintenance.

Mix is only confusing, and leads to even more errors.

This also applied to related functions such as dirname/basename in
this case, choosing own
implementation of basename yield confusing as you do not expect that
dirname taken from
different implementation.

Regards,
Alon.

