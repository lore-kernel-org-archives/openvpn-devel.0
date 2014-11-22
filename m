Message-ID: <54705AA4.2010105@...1856...>
Date: Sat, 22 Nov 2014 10:43:00 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1416598835-5269-1-git-send-email-yegorslists@...1030...>
	<CAGm1_kucw-c5wgw3e_BjRros=CyaEUQ-=o2aLSvDr=31oFuKCg@...278...>
In-Reply-To: <CAGm1_kucw-c5wgw3e_BjRros=CyaEUQ-=o2aLSvDr=31oFuKCg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] configure.ac: fix default behavior
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi Yegor,

On 21-11-14 20:43, Yegor Yefremov wrote:
> This patch is a result of our IRC discussion with Arne. Alternative
> approach were to always build with password-save functionality without
> configure option at all.

Thanks for the patch. But this explanation doesn't help me much in
understanding why this feature needs to be enabled by default. Could you
please explain?

(My first thought would be that locally storing a password defeats the
purpose of the password, so it is a good thing this is disabled by
default. But good arguments might change my view.)

-Steffan

