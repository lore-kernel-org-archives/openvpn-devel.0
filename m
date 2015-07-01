MIME-Version: 1.0
In-Reply-To: <016901d0b446$15330540$3f990fc0$@gmail.com>
References: <015601d0b436$d555ad60$80010820$@gmail.com>
	<CAA1AbxKrPXnc1+PPH4dQV1OksY_0t3ewqRnqVrjhZL+i2Pbkmw@...278...>
	<016901d0b446$15330540$3f990fc0$@gmail.com>
From: Steffan Karger <steffan@...1856...>
Date: Thu, 2 Jul 2015 00:13:11 +0200
Message-ID: <CAA1Abx+T8h8WcEPV7b_f2BaBKzyL2rckJJg+n+tosGPdjWTmpQ@...278...>
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

On Wed, Jul 1, 2015 at 11:29 PM, Fish Wang <fish.thss@...277...> wrote:
> Thank you for the suggestion. I'm sticking with VS since I already have an entire automation environment set up for compiling OpenVPN with Visual Studio.

Fair enough.

> Also I believe Visual Studio provides better security guarantees (like stack canaries, buffer checks etc.).

Just for reference: those are supported by mingw/gcc too:
-fstack-protector for canaries, -Wl,--nxcompat for DEP,
-Wl,--dynamicbase for ASLR.

On Wed, Jul 1, 2015 at 11:36 PM, Fish Wang <fish.thss@...277...> wrote:
> Thank you Steffan, the patch works for me.

Great!  Thanks for reporting back.

Others: consider my previous mail as a patch submission.

-Steffan

