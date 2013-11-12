Message-ID: <528258E1.2090804@...1435...>
Date: Tue, 12 Nov 2013 17:35:45 +0100
From: Steffan Karger <steffan.karger@...1435...>
MIME-Version: 1.0
References: <1384208842-25700-1-git-send-email-alon.barlev@...277...>	<CAOazyz1kEYtJ8gkjGZjrB67gjKGXGzFLoegrbZc-KcJnv49LvA@...278...>	<528212DC.5060908@...1147...>	<CAOazyz0m+QWSgvGyVb3CJnp+DY0NVoGNL0ZGPjFFWsWzBPo25Q@...278...>	<52823246.6010200@...1147...>	<CAOazyz1iEh8P_ALEAwzBSrWOCkHcvcH0C=cAG68bWStryTYW0A@...278...>
	<5282455A.7070204@...1147...>
In-Reply-To: <5282455A.7070204@...1147...>
Subject: Re: [Openvpn-devel] [PATCH] ssl: enable basic ecdsa
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 11/12/2013 04:12 PM, Jan Just Keijser wrote:
> correct , although you can currently use EC certs with SHA1 signing -
> just not with SHA2 signing.
> 
> JJK

Which means adding SHA2 hashing is at least a nice addition. I've taken
a quick peak at the code, applied the patches to master (which was not
that hard, considering it's been quite some time since these have been
published) and did some quick tests. The code seems to work, and I'm
planning to take a better look at it later this week. This patch gives
me a nice starting point.

In the mean time the people at PolarSSL have also added an elliptic
curve implementation to their library. I've been working on making
OpenVPN work with PolarSSL 1.3, which seems to at least have brought
support for ECDHE without adding extra logic to OpenVPN. If time permits
I'll also take a look at getting ECDSA working. Patches will follow as
soon as I'm a bit more confident that the code really works.

It would be very nice to get full EC support in OpenVPN! :)

-Steffan

