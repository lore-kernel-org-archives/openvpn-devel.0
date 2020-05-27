References: <20200519220004.25136-1-arne@...1227...>
 <20200519220004.25136-2-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <95cb7f30-48eb-a565-10e0-032a49b6eb38@...2080...>
Date: Wed, 27 May 2020 22:46:03 +0200
MIME-Version: 1.0
In-Reply-To: <20200519220004.25136-2-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 1/5] Implement parsing and sending
 INFO and INFO_PRE control messages
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 20/05/2020 00:00, Arne Schwabe wrote:
> OpenVPN 3 implements these messages to send information during the
> authentication to the UI, implement these message also in OpenVPN 2.x
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/forward.c |  8 ++++++++
>  src/openvpn/push.c    | 32 ++++++++++++++++++++++++++++++++
>  src/openvpn/push.h    |  3 +++
>  3 files changed, 43 insertions(+)
> 
[...]

Acked-By: David Sommerseth <davids@...515...>

-- 
kind regards,

David Sommerseth
OpenVPN Inc


