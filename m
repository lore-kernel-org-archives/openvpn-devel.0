MIME-Version: 1.0
In-Reply-To: <CAOazyz23rFvEKxn-v0dFKLymeD8rmaXpxHCcZvjSTiZb+BnRGg@...278...>
References: <CAOazyz21EEqHhEabEY_L-ve5JFnuZoE8fgqLVJjEYTjfpBSq9w@...278...>
	<CAOazyz23rFvEKxn-v0dFKLymeD8rmaXpxHCcZvjSTiZb+BnRGg@...278...>
Date: Wed, 22 Feb 2012 20:55:53 +0200
Message-ID: <CAOazyz0Amw2dYC6-4SNhxbw-S2QYg5yX3SHT43J_1feDmPXGpg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [RFC][windows] gettimeofday()
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
To: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

BTW: I like the mingw implementation, much simpler. It uses
the GetSystemTimeAsFileTime() API not performance counters.

On Wed, Feb 22, 2012 at 8:46 PM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> For all who cannot build and have access to Windows machine.
> Please run binary[1] and send output.
>
> [1] https://github.com/downloads/alonbl/openvpn/timebench.exe
>
> On Wed, Feb 22, 2012 at 6:12 PM, Alon Bar-Lev <alon.barlev@...277...> wrote:
>> Hello all,
>>
>> There is an abnormality in the openvpn sources I want to resolve.
>>
>> In windows there is own implementation of gettimeofday().
>> In the past there was no gettimeofday(), so we used performance counters,
>> then James optimize it to reduce CPU consumption.
>>
>> Unlike in the past, mingw does provide this function these days.
>> The question is if it is good enough.
>>
>> There is also a note:
>> /* on WIN32, gettimeofday is faster than time(NULL) */
>>
>> I am not sure about any of these, can you please try to run the
>> benchmark and report back the results?
>> It must be compiled using mingw, either at cygwin or at linux.
>>
>> Thanks,
>> Alon

