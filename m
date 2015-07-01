From: "Fish Wang" <fish.thss@...277...>
References: <015601d0b436$d555ad60$80010820$@gmail.com>
	<CAA1AbxKh_kU4NU2s+4Op9LGTA4cndKcGdCXkt5UXeCgTbpAKTQ@...278...>
In-Reply-To: <CAA1AbxKh_kU4NU2s+4Op9LGTA4cndKcGdCXkt5UXeCgTbpAKTQ@...278...>
Date: Wed, 1 Jul 2015 14:29:57 -0700
Message-ID: <016801d0b445$169c4eb0$43d4ec10$@gmail.com>
MIME-Version: 1.0
Content-Language: zh-cn
Subject: Re: [Openvpn-devel] Compiling issue on Visual Studio 2010
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: 'Steffan Karger' <steffan@...1856...>
Cc: 'openvpn-devel' <openvpn-devel@lists.sourceforge.net>

Hi,

Thank you for the suggestion. I'm sticking with VS since I already have an =
entire automation environment set up for compiling OpenVPN with Visual Stud=
io. Also I believe Visual Studio provides better security guarantees (like =
stack canaries, buffer checks etc.).

Best,
Fish

-----Original Message-----
From: Steffan Karger [mailto:steffan@...1856...]=20
Sent: Wednesday, July 1, 2015 2:16 PM
To: Fish Wang
Cc: openvpn-devel
Subject: Re: [Openvpn-devel] Compiling issue on Visual Studio 2010

Hi,

On Wed, Jul 1, 2015 at 9:47 PM, Fish Wang <fish.thss@...277...> wrote:
> Visual Studio 2010 refuses to compile the latest code on branch release/2=
.3
> because __func__ is not supported. Microsoft supports __FUNCTION__ instead
> of __func__ in their compiler. VS 2013 complains the same.

Thanks for reporting.  That's probably my fault, sorry.  I think we
still support VS, so we'll fix it, but you might want to consider
using mingw.  That's what the current openvpn developers use for
Windows builds (either native, or cross-compile from linux/BSD).

-Steffan


