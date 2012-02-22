MIME-Version: 1.0
In-Reply-To: <7281371.PNMm8PBGWv@...1526...>
References: <CAOazyz21EEqHhEabEY_L-ve5JFnuZoE8fgqLVJjEYTjfpBSq9w@...278...>
	<7281371.PNMm8PBGWv@...1526...>
Date: Wed, 22 Feb 2012 18:32:47 +0200
Message-ID: <CAOazyz0xGkiEnhY32t59byK0CrYckq665JiTLWYo7Ag8mpTpKw@...278...>
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
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, Feb 22, 2012 at 6:27 PM, Heiko Hund <heiko.hund@...1489...> wrote:
> Since there's no gettimeofday() in MSVC this will break building with the
> python build system. Not sure if we're in the process of getting rid of it,
> which I would welcome, so this is just for additional information.

The python build system will be replaced with my work.
Anyway, I did not write that in MSVC the windows implementation will be removed.
Just want to know if indeed the time(NULL) is slower and if we can use standard
gettimeofday in mingw.

Alon.

