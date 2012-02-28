MIME-Version: 1.0
In-Reply-To: <CAOazyz0h5G_X0eRpRR4J9K4TQJtccb+R+RnXF3Mc8RPUdhhtEg@...278...>
References: <CAOazyz2Rr6JgnmojZ3Naht6eybdq1KnooEAbARSS=3ZM-iLVJg@...278...>
	<4F4B402F.70507@...515...>
	<CAOazyz1xxbxSzHRvS1+3my_86iOQh0Jsvk-G_0+kMLERr0UXog@...278...>
	<6021266.D0OP5FaSJF@...1526...>
	<CAOazyz0h5G_X0eRpRR4J9K4TQJtccb+R+RnXF3Mc8RPUdhhtEg@...278...>
Date: Tue, 28 Feb 2012 02:37:37 +0200
Message-ID: <CAOazyz3EtWN0K0fdjgUHzg2ffjdvfEPTvqZ-MV09bcGWQKuFgg@...278...>
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

On Mon, Feb 27, 2012 at 6:18 PM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> Will be ready in a few hours.

Done [1].
Tarball is available.
Please review/pull.

Basically you need to modify the --with-crypto...
With:
./configure CFLAGS="-Ixxx/include" LDFLAGS="-Lxxx/lib"
Where xxx is the openssl location.
The build script now also builds the gui, so you use it...

I added --enable-deponly to allow "make dist" at Linux.

[1] https://github.com/alonbl/openvpn-gui
[2] https://github.com/alonbl/openvpn-build

