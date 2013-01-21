From: <p.j.bakker@...1543...>
Sender: "Paul Bakker" <p.j.bakker@...1548...>
References: <1358411009-2350-1-git-send-email-steffan.karger@...1435...>	<1358411009-2350-2-git-send-email-steffan.karger@...1435...>
	<20130121122301.GY22465@...1296...>
In-Reply-To: <20130121122301.GY22465@...1296...>
Date: Mon, 21 Jan 2013 14:09:14 +0100
Message-ID: <019201cdf7d8$85d185b0$91749110$@polarssl.org>
MIME-Version: 1.0
Content-Language: nl
Subject: Re: [Openvpn-devel] [PATCH 1/3] Improve
	PolarSSL	key_state_read_{cipher, plain}text messages
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Gert Doering' <gert@...1296...>, steffan.karger@...1435...
Cc: openvpn-devel@lists.sourceforge.net

Hi Gert,

> (Even though the design decision to call a library-specific error
reporting
> function "error_strerror()" is not something I find particularily well
chosen...
> what's wrong with "polar_strerror()"???)

Nothing is wrong with that. It's PolarSSL coding standard compliant
(https://polarssl.org/kb/development/polarssl-coding-standards)
The PolarSSL SSL library function naming standard is 'MODULE_FUNCTION_NAME'.
That is the cause of the current naming convention.

If this proves to be an issue with other implementation we will reconsider
of course ;)

Regards,
Paul


