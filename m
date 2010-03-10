MIME-Version: 1.0
In-Reply-To: <1268242750.8679.0@...1207...>
References: <9e0cf0bf1003100919l307a653er7c619b5f2fc97dc@...278...>
	<1268242750.8679.0@...1207...>
Date: Wed, 10 Mar 2010 19:41:49 +0200
Message-ID: <9e0cf0bf1003100941y30780002qcd62ca2d9e9355f2@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] On TARGET_LINUX define _GNU_SOURCE if
	not defined
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
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, Mar 10, 2010 at 7:39 PM, Karl O. Pinc <kop@...1206...> wrote:
> In other words ./configure is not expected to be run under normal
> circumstances.
>
> The whole point of autoconf is to produce something that can
> be made into a tarball that only requires "make; make install"
> to compile and install.

You do not understand the tools. Nor the common use of them.

You *MUST* run ./configure when compiling from sources.

Sorry,
Alon.

