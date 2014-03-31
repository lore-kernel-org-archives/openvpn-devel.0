Message-ID: <53391C5C.90705@...1147...>
Date: Mon, 31 Mar 2014 09:42:20 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <1396001222-5033-1-git-send-email-arne@...1227...>	<CAA1AbxJCv9ff7XHv1GKtCPuB-Hc5Lv33ufPfqcTraNpFnJf7fw@...278...>
	<20140330134619.GT16637@...1296...>
In-Reply-To: <20140330134619.GT16637@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix man page and OSCP script:
 tls_serial_{n} is decimal
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
To: Gert Doering <gert@...1296...>, Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 30/03/14 15:46, Gert Doering wrote:
> Hi,
>
> On Sun, Mar 30, 2014 at 12:48:37AM +0100, Steffan Karger wrote:
>> 3 - Change OpenSSL builds to use hax representation
> I tend toward this one - user visible behaviour shouldn't change (unless
> unavoidable) depending on SSL library used.
>
> So for me this boils down to "how many users are relying on the current
> behaviour, which is not what the docs say it should be"?
>
>
I've posted a script to verify CRLs
   http://www.nikhef.nl/~janjust/vpn/OpenVPN2-Cookbook/verify-crls.sh
which relies on the XX:XX:XX format ... I could change that, of course, 
but I am not sure how many people are actually using that script.
Printing the serial in hex format would make it more difficult to do a 
CRL check, however, as the openssl tools by default use the XX:XX:XX format.

JM2CW,

JJK



