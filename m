Message-ID: <513E4DEB.7000403@...1227...>
Date: Mon, 11 Mar 2013 22:34:35 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <C673F57BE2DD3148AC2DD4AF464686F901BBDB56@...1815...>
	<1363032625-23311-1-git-send-email-gert@...1296...>
In-Reply-To: <1363032625-23311-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Repair "tcp server queue overflow"
 brokenness, more <stdbool.h> fallout.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: gert@...1296..., openvpn-devel@lists.sourceforge.net

On 11.03.2013 21:10, gert@...1296... wrote:
> From: Gert Doering <gert@...1296...>
>
> Return value of mbuf_len() wrong - it's returning a length value, not
> a yes/no value - so when the queue length approached 65 (full!), it
> still only returned "1", leading to MBUF overflow later on.  Change
> from "bool" to "int", misbehaviour gone...
>
>
ACK. I did not check if that fixes the issue but the change is correct.

Arne

