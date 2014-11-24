Message-ID: <54737773.2050009@...68...>
Date: Mon, 24 Nov 2014 19:22:43 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <1416598835-5269-1-git-send-email-yegorslists@...1030...>	<CAGm1_kucw-c5wgw3e_BjRros=CyaEUQ-=o2aLSvDr=31oFuKCg@...278...>
	<54705AA4.2010105@...1856...>
In-Reply-To: <54705AA4.2010105@...1856...>
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

Am 22.11.2014 um 10:43 schrieb Steffan Karger:
> Hi Yegor,
> 
> On 21-11-14 20:43, Yegor Yefremov wrote:
>> This patch is a result of our IRC discussion with Arne. Alternative
>> approach were to always build with password-save functionality without
>> configure option at all.
> 
> Thanks for the patch. But this explanation doesn't help me much in
> understanding why this feature needs to be enabled by default. Could you
> please explain?

You can't stop the user doing stupid things, so why bother?
Print a warning instead, or if the password is read from auto-mounted
USB keys during boot-up, that might be considered safe enough...

ACK from me.


