Message-ID: <53B074B7.5040300@...1856...>
Date: Sun, 29 Jun 2014 22:19:03 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <CAEsd45Q1Ow+pasP0FhtJEkV-WW-yFA4dfKzx6QEKgnJf+m5Dtg@...278...>
In-Reply-To: <CAEsd45Q1Ow+pasP0FhtJEkV-WW-yFA4dfKzx6QEKgnJf+m5Dtg@...278...>
Subject: Re: [Openvpn-devel] Recently-disclosed LZO vulnerability and
 OpenVPN's use of LZO
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 29-06-14 18:09, Jonathan K. Bullard wrote:
> A recent _"Lab Mouse Security research blog" entry_
> <http://blog.securitymouse.com/2014/06/raising-lazarus-20-year-old-bug-that.html> claimed
> that a bug exists in several implementations of the LZO algorithm
> commonly used by OpenVPN and that the bug causes a security vulnerability.
> 
> A rebuttal on the "RealTime Data Compression" blog
> <http://fastcompression.blogspot.co.uk/2014/06/lets-move-on.html> points
> out that the circumstances required to exploit the vulnerability make
> exploitation unlikely. Among other requirements, the rebuttal says that
> a problem only happens with block sizes larger than 8MB.
> 
> Am I correct to assume that OpenVPN's use of LZO is restricted to much
> smaller block sizes? I assume the block sizes that OpenVPN uses LZO for
> are limited to the maximum packet size, which would be on the order of
> 1500 bytes or so (because of MTU size limits).
> 
> Or does OpenVPN ever use LZO on larger amounts of data? Is there any
> possibility of OpenVPN using LZO on 8MB?

You are partly correct; OpenVPN parses UDP or TCP packets, which due to
fragmentation can become as large as ~65KB. However, this is still
within comfortable distance from the 'critical' 8MB boundary for LZ4,
and 16MB for lzo. So OpenVPN is not vulnerable.

Regards,
-Steffan

