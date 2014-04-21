Message-ID: <53556D25.9090607@...515...>
Date: Mon, 21 Apr 2014 13:10:29 -0600
From: James Yonan <james@...515...>
MIME-Version: 1.0
References: <1398064204-26476-1-git-send-email-james@...515...>	<1398064204-26476-4-git-send-email-james@...515...>	<5354F1DE.8050604@...1856...>	<20140421104211.GT16637@...1296...>	<5354FCC9.4030106@...1227...>
	<20140421114946.GV16637@...1296...>
In-Reply-To: <20140421114946.GV16637@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 4/4] When tls-version-min is unspecified,
 revert to original versioning approach.
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
To: openvpn-devel@lists.sourceforge.net

On 21/04/2014 05:49, Gert Doering wrote:
> Hi,
>
> On Mon, Apr 21, 2014 at 01:11:05PM +0200, Arne Schwabe wrote:
>> Yes. But with this patch it is always turned off, keeping OpenVPN in 99%
>> of installations in TLS 1.0. Is there any other known case where it
>> breaks aside from the Tomato OpenVPN client?
>
> http://community.openvpn.net/openvpn/ticket/385
>
> this is the only case I know - and I blaim the openssl library on the
> server side (ARM).  So for me, "default-on with a way to turn it off" would
> be sufficient.  But I assume James has much more visibility...

The problem with tls-version-min is that it defaults to 1.0 even if not 
used.  We've received many reports of breakage with this approach, 
probably because setting the min to 1.0 is actually subtly different 
from the approach used before tls-version-min was implemented.

So this patch turns off tls-version-min unless it's explicit in the config.

James

