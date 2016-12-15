Message-ID: <1481834030.23823.7.camel@...1866...>
From: David Woodhouse <dwmw2@...1866...>
Date: Thu, 15 Dec 2016 20:33:50 +0000
In-Reply-To: <1481833246-32507-1-git-send-email-davids@...515...>
References: <1481833246-32507-1-git-send-email-davids@...515...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 0/2] LZ4 updates
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net

On Thu, 2016-12-15 at 21:20 +0100, David Sommerseth wrote:
> 
> There is also another potential issue with the current approach, if we link
> against r129 or older ... the code will be using
> LZ4_compress_limitedOutput().  If the system library is upgraded to a newer
> upstream version which finally removes LZ4_compress_limitedOutput(), OpenVPN
> will break.

Unless upstream is doing insane things and the distributions are
failing to do their job and catch it, removing a function would require
changing the soname; it could no longer be liblz4.so.1.

If your binary package requires liblz4.so.1 then it needs to be
present. That's always been the case. The existence of *another*
library, even if it has a similar name like liblz4.so.2, is utterly
irrelevant. There's no *new* problem here.


