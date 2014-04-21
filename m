Message-ID: <5354FCC9.4030106@...1227...>
Date: Mon, 21 Apr 2014 13:11:05 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1398064204-26476-1-git-send-email-james@...515...>	<1398064204-26476-4-git-send-email-james@...515...>	<5354F1DE.8050604@...1856...>
	<20140421104211.GT16637@...1296...>
In-Reply-To: <20140421104211.GT16637@...1296...>
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
To: Gert Doering <gert@...1296...>, Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

On 21.04.2014 12:42, Gert Doering wrote:
> Hi,
>
> On Mon, Apr 21, 2014 at 12:24:30PM +0200, Steffan Karger wrote:
>> On 21-04-14 09:10, James Yonan wrote:
>>> For OpenSSL, this means to use TLSv1_(client|server)_method rather
>>> than SSLv23_(client|server)_method combined with SSL_OP_NO_x flags
>>> for specific TLS versions to disable.
>> I'm not sure I understand the rationale behind this. If I don't specify
>> a minimum version, my maximum version changes to TLS 1.0? Could you
>> maybe explain the "why" for this patch?
> "turn it off!", without introducing yet another config directive (or,
> more precisely, "do not turn it on by default" if I read the patch right).
>
> There seem to be some not-yet-fully-understood combinations of OpenSSL
> library versions/library builds that will break 2.3.3 clients <-> git-master
> servers if the TLS version negotiation patch is active, so having a way
> to turn it off at run-time (if only to see if that is the problem) is
> certainly useful.
>
Yes. But with this patch it is always turned off, keeping OpenVPN in 99% 
of installations in TLS 1.0. Is there any other known case where it 
breaks aside from the Tomato OpenVPN client?

Arne

