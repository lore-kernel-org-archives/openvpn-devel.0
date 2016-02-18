MIME-Version: 1.0
In-Reply-To: <56C5C6F7.1020903@...277...>
References: <56C5C6F7.1020903@...277...>
From: Steffan Karger <steffan@...1856...>
Date: Thu, 18 Feb 2016 17:01:10 +0100
Message-ID: <CAA1AbxJEJyrzJLOXLN2gO6EbA2=QSAbJf3pEr0SUAgVReT5xXA@...278...>
Subject: Re: [Openvpn-devel] Has openvpn been fuzzed?
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
To: Jacek Wielemborek <d33tah@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi d33tah,

On Thu, Feb 18, 2016 at 2:28 PM, Jacek Wielemborek <d33tah@...277...> wrote:
> I had been fascinated by afl-fuzz for quite a couple months so far and
> based on how efficient it is in finding bugs in open source projects,
> I'd like to ask the OpenVPN community whether somebody here tried out
> this tool on this project.
>
> If not, you might be interested in my project that automates
> recompilation of openvpn with afl-gcc:
>
> https://github.com/d33tah/aflize
>
> Just run "aflize openvpn" and you'll get build environment ready in minutes.
>
> Let me know if you'd like any help fuzzing OpenVPN, I'd be happy to
> assist you guys :)

Thank you.  This has been on my todo-list for ages now, but never got
around to doing something with it.

I'm not aware of any openvpn fuzzing with tools like afl.  OpenVPN
does have an internal, simple, fuzzer for network traffic, which
randomly flips bits.  Look for 'gremlin' in the source.

-Steffan

