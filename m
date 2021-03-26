References: <1538820128-27086-1-git-send-email-lstipakov@...277...>
 <1540904039-2129-1-git-send-email-lstipakov@...277...>
 <20210326071222.GR976@...1296...>
 <325f28a6-127a-f10a-dd94-5c76cc6c4f69@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <0fada0d5-19f6-4fbc-fc46-cb5bb3fbda54@...1227...>
Date: Fri, 26 Mar 2021 12:11:10 +0100
MIME-Version: 1.0
In-Reply-To: <325f28a6-127a-f10a-dd94-5c76cc6c4f69@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v4] Improve "recursive routing" warning
 message
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
To: Antonio Quartulli <a@...2181...>, Gert Doering <gert@...1296...>, Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Am 26.03.21 um 11:30 schrieb Antonio Quartulli:
> Hi,
> 
> On 26/03/2021 08:12, Gert Doering wrote:
>> Now...  if we consider a scenario where OpenVPN packets are not subject
>> to be routed into the tunnel (Linux VRF, policy routing, ...) - which
>> is actually something I want to see happen :-) - twisting this feature 
>> into some other direction might make the coding effort useful: what 
>> about "we only block packets that match destination IP *and port and
>> protocol* with what OpenVPN is using"? 
>>
>> So, if we talk to 1.2.3.4/udp/1194, only packets inside the tunnel
>> destined to 1.2.3.4/udp/1994 would be dropped, and everything else can
>> be sent freely - because those are never "recursive openvpn packets".
> 
> I was just questioning this feature per se: why do we want to *allow*
> real loops?

On Android where VPN setup is a bit different from normal setup.
Different enoguh that the recursive routing message is easily triggered
and the client always sets the allow-recursive-roouting option. I cannot
remember the exact details anymore.

Arne


