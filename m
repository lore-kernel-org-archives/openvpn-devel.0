MIME-Version: 1.0
In-Reply-To: <1482353691-27088-3-git-send-email-davids@...515...>
References: <1482353691-27088-1-git-send-email-davids@...515...>
	<1482353691-27088-3-git-send-email-davids@...515...>
From: Steffan Karger <steffan@...1856...>
Date: Wed, 21 Dec 2016 22:32:57 +0100
Message-ID: <CAA1Abx+NwVXr6b2MyxWcME9P0L1ygZL-2pDDxjPGrrTnQctHsw@...278...>
Subject: Re: [Openvpn-devel] [PATCH master+v2.4] docs: Further enhance the
 documentation related to SWEET32
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 21 December 2016 at 21:54, David Sommerseth <davids@...515...> wrote:
>  User-visible Changes
>  --------------------
> +- When using ciphers with cipher blocks less than 128-bits
> +  OpenVPN will complain loudly if the configuration uses ciphers considered
> +  weak, such as the SWEET32 attack vector.  In such scenarios, OpenVPN will by
> +  default do a renegotiation for each 64MB of transported data (``--reneg-bytes``).
> +  This can renegotiation can be disabled, but is HIGHLY DISCOURAGED.

There's a can too much here.

> +If using ciphers with cipher block sizes less than 128-bits, \-\-reneg\-bytes is
> +set to 64MB by default, unless it is explicitly disabled by setting the value to
> +0,but this is

Missing a space behind the ,

> +.B HIGHLY DISCOURAGED
> +as this is designed to add some protection against the SWEET32 attack vector.
> +For more information see the \-\-cipher option.

-Steffan

