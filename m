MIME-Version: 1.0
In-Reply-To: <569285BE.40605@...1856...>
References: <569285BE.40605@...1856...>
From: Steffan Karger <steffan@...1856...>
Date: Mon, 11 Jan 2016 22:55:49 +0100
Message-ID: <CAA1AbxJETy8x43pdFgA_odC40UR=KJ3HwcE+j9R8U+mBAZyeHA@...278...>
Subject: Re: [Openvpn-devel] Please comment: AEAD support
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Sun, Jan 10, 2016 at 5:24 PM, Steffan Karger <steffan@...1856...> wrote:
> preliminary comments and test results are very much welcome.

Based on feedback from Gert ('you don't need to send IV_NCP=2 as a
server for server-side NCP support') and Arne ('peer-info can be
NULL'), I just pushed a new branch containing fixes for both:
https://github.com/syzzer/openvpn/tree/aead-cipher-modes12

-Steffan

