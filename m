MIME-Version: 1.0
In-Reply-To: <1784273.hoPHCvA0K1@...1526...>
References: <1329413441-22538-1-git-send-email-heiko.hund@...1489...>
	<1329413441-22538-3-git-send-email-heiko.hund@...1489...>
	<CAOazyz0W43Hop+8d4gzB9cAsA-CH55185rgd6evDR0uJ=tf7SQ@...278...>
	<1784273.hoPHCvA0K1@...1526...>
Date: Fri, 17 Feb 2012 11:56:56 +0200
Message-ID: <CAOazyz10nhuOLTHqJt3A3FxWPzgW52DWmz_Ka79LWfVFwMHRmg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 2/4] do not use mode_t on Windows
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
To: Heiko Hund <heiko.hund@...1489...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Fri, Feb 17, 2012 at 11:39 AM, Heiko Hund <heiko.hund@...1489...> wrote:
> Alon,
>
> On Thursday 16 February 2012 18:34:34 Alon Bar-Lev wrote:
>> Anyway, this is not the correct solution.
>> Correct solution is to have config-msvc.h and have:
>> ---
>> #define mode_t int
>
> I don't think that a MSVC specific header will do good. mode_t shouldn't
> actually be used in mingw either, even if they define it. I stumbled over such
> glue code a couple of times and the only reason I can come up with why they
> have it is backwards compatibility with old code. So it's rather a general
> WIN32 thing. And I absolutely agree that putting all the WIN32 stuff into
> win32.[ch] would make the code prettier. I just don't feel enough itch to
> approach this scratching myself.
>

You will  be surprised how mingw is better in this sense.
Anyway, as I wrote commit whatever you need for now, we will clean up
the build system soon.

Alon.

