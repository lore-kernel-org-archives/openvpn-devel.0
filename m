MIME-Version: 1.0
In-Reply-To: <20130918110441.GO161@...1296...>
References: <CAFHpkQEPogSqK9xbkMa4YYdE9yNSO9Lwj9Tqo-jARB4hrgdYbw@...278...>
	<20130917195350.GL161@...1296...>
	<CAFHpkQFBF6EXPfXMV=ePhh3QNMRJuXnh5TjG1bCtKJuOi40Utw@...278...>
	<20130917202917.GM161@...1296...>
	<CAFHpkQFFC50keiv_BuUoDFWRGN-pe3Ojhn5wT5Mr9ULSWLhZeg@...278...>
	<20130918110441.GO161@...1296...>
Date: Wed, 18 Sep 2013 17:19:21 +0600
Message-ID: <CAFHpkQGybr=n7mCAbMkn=pizE+Apn-Hw1DHzgo5yyZub9pD1Tw@...278...>
From: =?KOI8-R?B?6czY0SD7ydDJw8nO?= <chipitsine@...277...>
Subject: Re: [Openvpn-devel] "unix style line endings" in openvpn-build repo
	?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

2013/9/18 Gert Doering <gert@...1296...>:
> Hi,
>
> On Wed, Sep 18, 2013 at 02:42:22AM +0600, ???? ??????? wrote:
>> I was very impressed how Cassandra community helps developers:
>>
>> http://wiki.apache.org/cassandra/HowToContribute
>
> Yeah, this is great.
>
>> I spent an hour when I tried to build openvpn under cygwin. I DID
>> mention that "cygwin's git should be used", I did run git from command
>> line and I was wonder what went wrong. I simply installed cygwin
>> without git and windows git was in PATH.
>
> Well, what shall I say - building on Windows is always problematic, which
> is exactly why the official windows binaries get built under *Linux*,
> using openvpn-build and mingw64 cross-compiler.  This is the official
> way, documented in the openvpn wiki.

What I'm trying to say "let us do it less problematic" and your point
is like "ok, it is always been problematic, let us keep it that way"
why ?


>
> James also builds with msvc, so that "mostly works", but using cygwin
> is not something any other developer does, so it's not particularily well
> documented.

using cygwin is exactly what any other developer does when he comes to
an idea "ok, openvpn-gui sucks, I'm going to add a feature to it"

first of all, developer comes to conclusion that openvpn-gui is a
separate tool, which in turn can be built separately.
ok, let download it and figure out how to compile it.
hmm, there's even README, great... no luck at all after many hours spent.

second, developer comes to an idea that
https://github.com/openvpn/openvpn-build can be used
ok, there're 3 ways: msvc, cygwin and linux cross compile. which one to choose ?

I managed to compile using msvc (no luck with x64). Also I managed to
compile with linux and cygwin.



>
>
>> Any reason to puzzle developers ?
>> Look, people want to contribute, and they have to solve puzzles
>> instead of doing usefull things.
>
> A more useful approach would be to ask first what the recommended way to
> build Windows binaries is - Samuli would have told you :-)

a more useful approach is to eliminate difficulties.
ok, we can live with difficulties. but when we can eliminate some of
them, why not to do so ?

I suggested how to make life easier for cygwin compilation. Why not to
do so ? Why to keep difficulties ?

>
> gert
>
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //www.muc.de/~gert/
> Gert Doering - Munich, Germany                             gert@...1296...
> fax: +49-89-35655025                        gert@...1297...

