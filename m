MIME-Version: 1.0
In-Reply-To: <015601d0b436$d555ad60$80010820$@gmail.com>
References: <015601d0b436$d555ad60$80010820$@gmail.com>
From: Steffan Karger <steffan@...1856...>
Date: Wed, 1 Jul 2015 23:16:25 +0200
Message-ID: <CAA1AbxKh_kU4NU2s+4Op9LGTA4cndKcGdCXkt5UXeCgTbpAKTQ@...278...>
Subject: Re: [Openvpn-devel] Compiling issue on Visual Studio 2010
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
To: Fish Wang <fish.thss@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Wed, Jul 1, 2015 at 9:47 PM, Fish Wang <fish.thss@...277...> wrote:
> Visual Studio 2010 refuses to compile the latest code on branch release/2.3
> because __func__ is not supported. Microsoft supports __FUNCTION__ instead
> of __func__ in their compiler. VS 2013 complains the same.

Thanks for reporting.  That's probably my fault, sorry.  I think we
still support VS, so we'll fix it, but you might want to consider
using mingw.  That's what the current openvpn developers use for
Windows builds (either native, or cross-compile from linux/BSD).

-Steffan

