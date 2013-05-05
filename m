Message-ID: <5186607A.4000000@...1227...>
Date: Sun, 05 May 2013 15:36:58 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1367759408-16770-1-git-send-email-gert@...1296...>
In-Reply-To: <1367759408-16770-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Use min_int() instead of
 MIN()+syshead.c compat definition.
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

On 05.05.2013 15:10, Gert Doering wrote:
> Reverts commit 15ca5c297b556fbb, instead change ssl_openssl.c to use
> "min_int()", which is already defined in "integer.h"
>
ACK

