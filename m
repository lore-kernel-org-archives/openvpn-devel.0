MIME-Version: 1.0
In-Reply-To: <834c4ed9-af60-1f0b-091d-da0fafa6bd96@...2080...>
References: <834c4ed9-af60-1f0b-091d-da0fafa6bd96@...2080...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Wed, 31 Aug 2016 21:04:09 -0400
Message-ID: <CAEsd45SqF0hSM_HjK2kZ3XaO4x6QQM8S=M6fOUySYn7hPBrJWQ@...278...>
Subject: Re: [Openvpn-devel] Modernising the management interface
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Wed, Aug 31, 2016 at 2:55 PM, David Sommerseth
<openvpn@...2080...> wrote:
>
>
> One of the things which have struck me is that D-Bus is adopted a lot
> of places, and its internal API have been considered stable for about
> 10 years or more.  Even though there are areas where D-Bus seems a bit
> over-engineered, it has proved to be a very useful IPC mechanism for a
> lot of software.


From what I can tell, the main advantage D- Bus would offer is that it
would allow multiple processes to manage an OpenVPN process. I don't
see a big benefit from that, but it might be nice, I suppose. D-Bus
may also include some security protections, although I haven't seen
anything specific about that.

However, for OpenVPN on OS X (now macOS), I see little advantage.
Maybe I'm missing it, but I don't see any simple way to integrate
D-Bus into an app such as Tunnelblick on OS X. In fact, a Google
Search for "'OS X' "D-Bus'" resulted mostly in mentions of problems
with D-Bus in specific programs and how to get around them, and one
seven-year-old email offering an OS X version of the D-Bus library. I
assume macports has it, but that didn't show up, nor did any official
"D-Bus" repository. (Is there one?)

I also question the idea of relying on yet another big, complicated
external library, which must be updated as issues arise (as they do
with complex programs and libraries). On Linux, I gather it is part of
the OS so I suppose that isn't a concern, but it would be on OS X (and
Windows?).

So I am not enthusiastic about integrating a D-Bus interface to
OpenVPN into Tunnelblick (I haven't even integrated of all of the
current management interface into Tunnelblick, nor does there seem to
be much demand for me to do so).

But maybe I'm just an old curmudgeon, or maybe it's just late and I'm
tired. Any pointers (for example, to a reference implementation of
integrating D-Bus into an OS X app) would be welcome, and could very
well change my mind.

