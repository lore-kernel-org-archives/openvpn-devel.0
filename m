References: <20201023113431.26691-1-arne@...1227...>
 <20201023113431.26691-2-arne@...1227...>
 <20201024194301.GB976@...1296...>
 <c0f890fb-bd6c-1e76-7316-590c95bfb34e@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <46c513d0-8b2f-d4db-427f-c8d39e8a659f@...2181...>
Date: Thu, 25 Mar 2021 22:37:42 +0100
MIME-Version: 1.0
In-Reply-To: <c0f890fb-bd6c-1e76-7316-590c95bfb34e@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 2/5] xmit_hold is only required for
 port_share
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 26/10/2020 10:49, Arne Schwabe wrote:
> Am 24.10.20 um 21:43 schrieb Gert Doering:
>> Hi,
>>
>> On Fri, Oct 23, 2020 at 01:34:28PM +0200, Arne Schwabe wrote:
>>> Make options.c only set xmit_hold when port_share is active to least
>>> document this dependency. I have not actually tested if this dependency
>>> is actually true (or if port_share could work without xmit_hold).
>>
>> I'm not sure I understand this patch, or the flow.  Before this patch,
>> xmit_hold is always set to "true" for TCP_SERVER, after this patch,
>> only for server *and* port_share.
>>
>> What am I overlooking?
>>
> 
> No. This feature was introduced as part of port-share and I am not even
> sure it is really required for port-share. Normally we do not send
> anything unless there is a valid OpenVPN RESET packet. So I want to
> limit it again to part-share before I can really reliable say that even
> port-share doesn't need it.
> 

To add some more meat to the discussion...
The xmit_hold option member was introduced by
6add6b2fe78c549d174729869e26cee917e31d5f ("Added --port-share
option..."), so like Arne said it was added as aid of the port-share
feature.

My understanding is that setting this member to true will prevent a peer
from sending any control packet until reliable_schedule_now() is called
for the first time.

Any idea why this could be helpful with port-share?
Maybe in 2006 an OpenVPN server could decide to send something even
before having received the opening packet from the connecting client?
If that's the case, then I understand the hold.

However, in the current code, reliable_schedule_now() is invoked when we
do the first "burst" upon client connection.
This seems to happen right after receiving the first valid HARD_RESET
packet.

For this reason I tend to agree with Arne that this "xmit_hold" knob is
not really doing anything useful.


Anybody can see why we need that for port-share?
I'd rather try to understand the above and ditch this member entirely,
if the answer is "we don't need it".


Cheers,

-- 
Antonio Quartulli

