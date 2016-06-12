MIME-Version: 1.0
In-Reply-To: <20160612180939.GX62247@...1296...>
References: <ec25d8af-ecfe-19eb-9d86-4525300cde2f@...277...>
	<CAA1Abx+q7EVw1tD3mbdn2g016pL2KXjoNQ9FodVzvDAr+zyw0w@...278...>
	<20160612173454.GV62247@...1296...>
	<CAA1AbxLrE-xdehgXPhk0XbQnWLffBeAduLhEsp7Bh2TBUR61zQ@...278...>
	<20160612180939.GX62247@...1296...>
From: Steffan Karger <steffan@...1856...>
Date: Sun, 12 Jun 2016 20:57:49 +0200
Message-ID: <CAA1AbxKKny9inQLpW3OcPLUJ5ozb_Wzb87kw9h-EFVdk9UPXMA@...278...>
Subject: Re: [Openvpn-devel] OpenVPN-mbedTLS depends on mbedTLS debug module
 - safe to remove?
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Sun, Jun 12, 2016 at 8:09 PM, Gert Doering <gert@...1296...> wrote:
> On Sun, Jun 12, 2016 at 07:56:50PM +0200, Steffan Karger wrote:
>> > Can we detect and #ifdef this at build time?
>> >
>> > Yes, adding another #ifdef is what we try to avoid - but this is a fairly
>> > localized thing, and the dependency is clear, not a "user selectable
>> > combination of build options".
>>
>> Sure.  We can put this in e.g. #ifndef ENABLE_SMALL.
>
> Was more thinking along the line of
>
> #if !defined(ENABLE_SMALL) && !defined(MBEDTLS_COMPILED_WITH_SILLY_OPTION)
>
> because --enable-small would remove lots of other useful information...
>
>> This information is not just useful for debugging during development,
>> but also for debugging user problems.  So I'd rather keep it in there
>> by default, most users don't care at all about 40 kB :)
>
> As far as I understood, if you build mbedtls without this debug.o, linking
> OpenVPN would just *fail* today.

Right, of course.  Sorry - too tired today.  That would be #ifdef
MBEDTLS_DEBUG_C, and totally makes sense.  I'll send a patch.

-Steffan

