MIME-Version: 1.0
In-Reply-To: <D361C0BE-FCDA-4DA0-BA44-E344D33242B0@...1348...>
References: <AANLkTin2N8TOJ9H+kDFVojiTaaG+AxM+dNc9xFM9XpuF@...278...>
	<20100913182543.12172.qmail@...1287...>
	<D361C0BE-FCDA-4DA0-BA44-E344D33242B0@...1348...>
Date: Mon, 13 Sep 2010 21:10:40 +0200
Message-ID: <AANLkTi=a1GqkMfo2d17XP_JVcD5kOoGBAA=th3WA+rNz@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] Windows build was messed up!
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
To: Toby Thain <toby@...1348...>
Cc: openvpn-devel@lists.sourceforge.net, Peter Stuge <peter@...1287...>

On Mon, Sep 13, 2010 at 8:59 PM, Toby Thain <toby@...1348...> wrote:
> NMAKE is convenient for Windows builds as it will also happily run
> under Linux/WINE, targeting both 32 and 64 bit Windows runtimes with
> the 'freely downloadable' Express toolchain. It may even be possible
> to combine autotools with the Microsoft compiler, though I haven't
> tried it (CC="wine cl", etc).

Won't work ever!
Forget about wine and Microsoft compilers.
mingw provides a decent environment, fully integrated to autotools and
cross environments.

Alon.

