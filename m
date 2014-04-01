Message-ID: <533B1D86.8060000@...515...>
Date: Tue, 01 Apr 2014 14:11:50 -0600
From: James Yonan <james@...515...>
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
To: openvpn-devel@lists.sourceforge.net

On 30/03/2014 07:46, Gert Doering wrote:
> Hi,
>
> On Sun, Mar 30, 2014 at 12:48:37AM +0100, Steffan Karger wrote:
>> 3 - Change OpenSSL builds to use hax representation
>
> I tend toward this one - user visible behaviour shouldn't change (unless
> unavoidable) depending on SSL library used.
>
> So for me this boils down to "how many users are relying on the current
> behaviour, which is not what the docs say it should be"?

I think the problem here is that historically, going back as far as 2005 
(commit 6fbf66fad3367b24fd6743bcd50254902fd9c8d5), tls_serial_n has 
always given the serial number as decimal, and the documentation never 
indicated that the serial number was hex.

Commit 7ae5fb20d7dc52641ef853b896dffc0f283d16d2 in early 2011 added 
support for large serial numbers using BN_bn2dec, but the format was 
still decimal.

Now it looks like there was an alternative tls_serial_n implementation 
committed in 2010 (7d5e26cbb53e2700c966e6b6e815f0c824da8956) that 
changed the implementation to hex, but the code was later reverted, 
however unfortunately the comment in openvpn.8 that tls_serial_n is hex 
remained from that commit until now.

So a lot of code out there is assuming n is decimal, including some of 
our own code at OpenVPN Tech.

I would vote for preserving decimal behavior and updating the docs to 
reflect this.

It's unfortunate that PolarSSL is using hex, and I'm wondering how 
disruptive it would be to the PolarSSL user base if we change this to 
decimal.

I would tend to agree that the behavior should be consistent, regardless 
of underlying SSL library.

James

