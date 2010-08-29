MIME-Version: 1.0
In-Reply-To: <20100828230440.31685.qmail@...1287...>
References: <4C77640D.6000708@...515...> <20100828024617.942.qmail@...1287...>
	<20100828092954.GI10703@...1296...>
	<20100828230440.31685.qmail@...1287...>
Date: Sun, 29 Aug 2010 08:11:49 +0300
Message-ID: <AANLkTindOfdE+Vp9C8H_PJCYFUjWfTEteQ59QoevoFrO@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (26th Aug 2010)
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
To: openvpn-devel@lists.sourceforge.net

On Sun, Aug 29, 2010 at 2:04 AM, Peter Stuge <peter@...1287...> wrote:
> The only thing missing was -lz to satisfy OpenSSL dependencies.
> If pkg-config is available in the system then pkg-config openssl --libs
> is all that is needed to get the linker flags needed for OpenSSL.
> Maybe use PKG_CHECK_MODULES() in configure.ac to check for OpenSSL
> before trying the current seemingly manual tests?

In order to get truly static executable, you need to compile all using
uclibc in this case.

