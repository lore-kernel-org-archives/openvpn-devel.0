Message-ID: <911d560e-45b3-4029-a9c4-24d59c91c91e@...2181...>
Date: Mon, 19 Feb 2024 14:23:08 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <gerrit.1708012740000.I4b5e8357d872c920efdb64632e9bce72cebee202@...2715...>
 <a91d834e2d9f284b0278cf9940f50dd0a539f057-HTML@...2715...>
 <Zc45NJAyJyLoTRee@...1296...>
 <8021c4ad-fca6-443c-9ce6-37c7e85bca81@...2181...>
 <6d8657f9-738f-44be-acbb-7e044d89e0f3@...2181...>
 <ZdNT18oVbBxUGDoU@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <ZdNT18oVbBxUGDoU@...1296...>
Subject: Re: [Openvpn-devel] [S] Change in openvpn[master]: Minor fix to
 process_ip_header
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net

Hi,

On 19/02/2024 14:12, Gert Doering wrote:
> Maybe that would be a more reasonable approach here... get rid of the
> umbrella if(), and check individual bits inside.  It seems to be a
> micro-optimization "skip this branch if we have no single feature active",
> while at least MSSFIX is active by default.

Technically we still retain the "speed up" when all features are 
disabled (i.e. remove this and this from the config and gain some Mbps)

But I do agree that the code complexity is not worth the gain, for a 
very narrow corner case.

I vote for letting the umbrella if() go.

Cheers,

-- 
Antonio Quartulli

