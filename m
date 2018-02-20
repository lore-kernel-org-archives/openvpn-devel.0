MIME-Version: 1.0
In-Reply-To: <20180220082043.GC69387@...1296...>
References: <1519071994-20797-1-git-send-email-selva.nair@...277...>
 <20180220082043.GC69387@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 20 Feb 2018 10:42:46 -0500
Message-ID: <CAKuzo_hCwWxyBUDar_5xgrKdtjfjVE7H5jYMkqu2gZ5eR8gKwA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix format spec errors in Windows builds
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Tue, Feb 20, 2018 at 3:20 AM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Mon, Feb 19, 2018 at 03:26:34PM -0500, selva.nair@...277... wrote:
>> - In route.c print adapter_index as unsigned int as in the rest
>>   of the code.
>
> That one confuses me, but that is most likely me vs. windows types.
>
> adapter_index is declared as "DWORD" in tun.h, and
>
>   https://msdn.microsoft.com/en-us/library/cc230318.aspx
>
> says that DWORD is "typedef unsigned long DWORD".
>
> Since that particular code is only relevant on windows, why not just
> use "%lu" and avoid the cast?

You are absolutely right. But, we have several places where DWORD is
cast to (unsigned int) before printing, so I just decided to follow
that "style".

Anyway, don't want to change all those cases, but will change all
instances of adapter_index to use %lu (only ~3 locations other than
the ones touched here) and send a v2.

>
>
> The rest looks reasonable to me, and I'm not strictly opposed to the
> adapter_index one, just confused.
>
> (As a side note, I assume that this patch is "master only", and have
> not looked at which bits and pieces apply to release/2.4 - the error.c
> one does not, because the surrounding code is different, plus, I've
> already merged Steffan's patch for error.c to 2.4)

Oh, yes, a separate 2.4 version may be needed. Will check.

>
> [..]
>> @@ -3003,7 +3003,7 @@ do_route_service(const bool add, const route_message_t *rt, const size_t size, H
>>
>>      if (ack.error_number != NO_ERROR)
>>      {
>> -        msg(M_WARN, "ROUTE: route %s failed using service: %s [status=%u if_index=%lu]",
>> +        msg(M_WARN, "ROUTE: route %s failed using service: %s [status=%u if_index=%d]",
>>              (add ? "addition" : "deletion"), strerror_win32(ack.error_number, &gc),
>>              ack.error_number, rt->iface.index);
>>          goto out;
>
> That one is correct, but arguably a bit annoying - openvpn-msg.h /
> struct interface_t uses "int index", which maybe should have been a
> DWORD to keep the windows types.  Or not?
>
> I wouldn't change the message types, though - as it would introduce
> possible compatibility issues between openvpn and iservice (if one
> ends up having different versions installed and running).

This is something we better live with. That said even if we change the
msg types to use DWORD, binary compatibility with older versions would
not break as sizeof(DWORD) is 32 bits, same as int, isn't it? For the
same reason no real need to change this as no information is really
lost.

Selva

