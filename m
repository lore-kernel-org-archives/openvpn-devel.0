MIME-Version: 1.0
In-Reply-To: <6021266.D0OP5FaSJF@...1526...>
References: <CAOazyz2Rr6JgnmojZ3Naht6eybdq1KnooEAbARSS=3ZM-iLVJg@...278...>
	<4F4B402F.70507@...515...>
	<CAOazyz1xxbxSzHRvS1+3my_86iOQh0Jsvk-G_0+kMLERr0UXog@...278...>
	<6021266.D0OP5FaSJF@...1526...>
Date: Mon, 27 Feb 2012 18:18:37 +0200
Message-ID: <CAOazyz0h5G_X0eRpRR4J9K4TQJtccb+R+RnXF3Mc8RPUdhhtEg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] openvpn windows gui
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
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

On Mon, Feb 27, 2012 at 6:04 PM, Heiko Hund <heiko.hund@...1489...> wrote:
> Hi Alon
>
> On Monday 27 February 2012 14:01:25 Alon Bar-Lev wrote:
>> I am going to re-write your build system :)
>
> Take it easy! =)
>
>> It uses autoconf but not automake and looks some rewrite is needed.
>
> I did not see the the need for automake in the past. However, now that dist
> produces a .tar.gz and there's the res/ subdir and the Makefile is quite ugly,
> plus not all the dependency tracking is in place working, a little automake
> will be beneficial, so go ahead. Please make sure the snapshot target stays
> intact and that configure still supports the --with-cyrpto-* arguments for
> libcrypto (guess you'll go pkg-config here as well).

Great.
The crypto stuff will be converted to pkg-config style OPENSSL_CFLAGS
and OPENSSL_LIBS.
The automake move will make the build much easier to maintain.

>> We should probably write an installer.
>
> I'm not sure if it's the best idea to make each and every GUI project out
> there write it's own installer, when it's mostly a single executable that
> needs to be replaced to package it with upstream openvpn. The pragmatic way to
> do it would be to leave the GUI stuff in openvpn itself, but I guess you guys
> like the idea of bundling installers with other installers, right?

If this is a single .exe I will put this in installer for now as-is.

Will be ready in a few hours.

Alon.

