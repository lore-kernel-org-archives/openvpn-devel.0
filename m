Message-ID: <0c27edad-d696-5857-02ee-d2ef8e6286d1@...1227...>
Date: Fri, 24 Jun 2022 13:15:05 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20181206171033.61310-1-gert@...1296...>
 <06dfe01b-95dd-ae08-4b30-96f85ac2bd9d@...1856...>
 <80e6882a-dd00-eeff-151b-1b67d6e61103@...2181...>
 <a83d231f-2f4b-c51f-e71a-94f13b699ee2@...2181...>
 <YrWRSH5di07JxGmW@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <YrWRSH5di07JxGmW@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Rate-limit incoming
 P_CONTROL_HARD_RESET_* packets.
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
To: Gert Doering <gert@...1296...>, Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Am 24.06.22 um 12:26 schrieb Gert Doering:
> Hi,
> 
> On Fri, Jun 24, 2022 at 11:13:40AM +0200, Antonio Quartulli wrote:
>> do we still need this patch after having merged Arne's HMAC feature?
> 
> Yes and no.
> 
> *This* patch won't apply anymore, but Arne said "we're now much faster
> in replying to packets than ever before" so we might indeed need a
> per-source-ip rate-limiter, to something like "10 per 10 seconds" or
> so (inventing arbitrary number that should be more than enough even
> for "5 users behind the same NAT reconnect at the same time", while
> at the same time too low to cause harm as a reflector) for the
> initial reply.

Yeah. Keeping a per IP table is adding a lot of state to manage that. 
Maybe instead to a (configurable) overall limit like 100/s?

Arne

