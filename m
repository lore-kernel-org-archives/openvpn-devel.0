Date: Thu, 8 Apr 2010 21:35:42 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100408193542.GN12312@...1296...>
References: <4BBE2D0E.4010106@...1114...>
Mime-Version: 1.0
In-Reply-To: <4BBE2D0E.4010106@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Make use of counter_type instead of int
	when counting bytes and network packets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On Thu, Apr 08, 2010 at 09:22:54PM +0200, David Sommerseth wrote:
> This is in response to a reported Debian bug, where the connection
> counter overflows.
> <http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=576827>
[..]
>      {
> -      msg (D_TLS_DEBUG_LOW, "TLS: soft reset sec=%d bytes=%d/%d pkts=%d/%d",
> +      msg (D_TLS_DEBUG_LOW,
> +           "TLS: soft reset sec=%d bytes=" counter_format "/%d pkts=" counter_format "/%d",
>  	   (int)(ks->established + session->opt->renegotiate_seconds - now),
[..]
> -  int n_bytes;			 /* how many bytes sent/recvd since last key exchange */
> -  int n_packets;		 /* how many packets sent/recvd since last key exchange */
> +  counter_type n_bytes;		 /* how many bytes sent/recvd since last key exchange */
> +  counter_type n_packets;	 /* how many packets sent/recvd since last key exchange */

ACK, this looks good.  The "counter_type" and "counter_format" infrastructure
will give 64-bit counters with portability to whatever systems supports
64 bit - and fallback to 32 bit where it is not possible.

gert

-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

