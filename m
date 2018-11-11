References: <1530633509-4959-1-git-send-email-selva.nair@...277...>
 <1531491395-29049-1-git-send-email-selva.nair@...277...>
 <4e0e285a-482a-700a-e359-fc8cf8c1613c@...1856...>
 <CAKuzo_iXRkuzeVG0ec2mDA8a-arQe-J9seo1R+ZdRA7ktWbt=w@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <da22fd72-2b38-1f46-a4f7-0688fea3babe@...1856...>
Date: Sun, 11 Nov 2018 14:43:21 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iXRkuzeVG0ec2mDA8a-arQe-J9seo1R+ZdRA7ktWbt=w@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v3] Make up/down script errors not FATAL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

I've postponed replying to this mail a couple of times because I felt I
missed something and needed to look closer, but today once again I don't
get it. So here goes for a potentially stupid reply:

On 05-10-18 17:30, Selva Nair wrote:
> On Fri, Oct 5, 2018 at 5:44 AM Steffan Karger <steffan@...1856...
> <mailto:steffan@...1856...>> wrote:
> 
>     Hi,
> 
>     On 13-07-18 16:16, selva.nair@...277...
>     <mailto:selva.nair@...277...> wrote:
>     > From: Selva Nair <selva.nair@...277... <mailto:selva.nair@...277...>>
>     >
>     > The error is treated as a warning only if its triggered due
>     > to script_security < SSEC_SCRIPTS.
>     >
>     > This helps user interfaces enforce a safer script-security setting
>     > without causing a FATAL error.
> 
>     But does it make sense at all to accept configs that have a --up script
>     without a sufficiently-high script-security set?
> 
> 
> This came out of a proposed patch for the GUI to protect lay users from
> malicious
> scripts embedded in config files.
> 
> Recall the ado about exploiting scripts using unsuspecting "inline"
> commands.
> To defeat such exploits we want to enforce a safer script security
> setting from
> the GUI but do not want to cause a FATAL error as that would be counter
> productive.
> 
> Please see GUI PR #271 https://github.com/OpenVPN/openvpn-gui/pull/271 and
> my comment dated Jul 3 under it.
> 
> The discussion that led to this is here:
> https://github.com/OpenVPN/openvpn-gui/issues/270

I fail to understand why you believe a fatal error in this case is
counterproductive.

A config file that has a script configured, but is not allowed to run
that script is a faulty setup that might result is connections that are
not working properly or maybe even not providing the expected security
level. Consider for example someone changing DNS or proxy settings in a
--up script to avoid leaking data. Most users will never reads warnings
if the connection pretends to be set up correctly. This makes me believe
that the best thing we can do is to error out if someone tries to
connect using such a configuration, and have them review their
configuration.

Why is a fatal error not exactly what you would want?

-Steffan

