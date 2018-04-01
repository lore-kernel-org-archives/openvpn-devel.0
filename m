MIME-Version: 1.0
In-Reply-To: <20180401063058.23913-1-gert@...1296...>
References: <20180401063058.23913-1-gert@...1296...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Sun, 1 Apr 2018 06:17:55 -0400
Message-ID: <CAEsd45REH-QKFnftiC1J3mrtT6OcxUg9kedmrvqncaBXsZ3exA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Depreciate IPv4-related options.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

 Hi,

On Sun, Apr 1, 2018 at 2:30 AM, Gert Doering <gert@...1296...> wrote:
> As discussed in trac #208 and on IRC with Antonio, OpenVPN 2.5 will
> be IPv6-only.  Removal of IPv4-related code and options will dramatically
> reduce code complexity, confusing options, bugs and user questions.
>
> Add deprecation warnings for IPv4-related config options to 2.4 branch,
> so users have enough time to move their setups to work on IPv6-only
> before 2.5 will be released.

Are you proposing to remove all IPv4 support from OpenVPN 2.5, so that
an IPv6 connection will be required and an IPv4-only connection will
not work?

Or is this is about removing IPv4-only options and code and leaving
options and code that work for either IPv4 or IPv6, so users could
continue to have an IPv4-only setup by changing the names of a few
options in their configuration files?

Either way, can anyone give an approximate release date for 2.5, so we
can have a time frame for the change? (Even a "not before" date would
be very helpful in evaluating the impact of these proposed changes.)

Best regards,

Jon Bullard (Tunnelblick developer)

