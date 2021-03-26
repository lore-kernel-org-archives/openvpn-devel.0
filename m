References: <1538820128-27086-1-git-send-email-lstipakov@...277...>
 <1540904039-2129-1-git-send-email-lstipakov@...277...>
 <20210326071222.GR976@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <325f28a6-127a-f10a-dd94-5c76cc6c4f69@...2181...>
Date: Fri, 26 Mar 2021 11:30:31 +0100
MIME-Version: 1.0
In-Reply-To: <20210326071222.GR976@...1296...>
Content-Language: en-US
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
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 26/03/2021 08:12, Gert Doering wrote:
> Now...  if we consider a scenario where OpenVPN packets are not subject
> to be routed into the tunnel (Linux VRF, policy routing, ...) - which
> is actually something I want to see happen :-) - twisting this feature 
> into some other direction might make the coding effort useful: what 
> about "we only block packets that match destination IP *and port and
> protocol* with what OpenVPN is using"? 
> 
> So, if we talk to 1.2.3.4/udp/1194, only packets inside the tunnel
> destined to 1.2.3.4/udp/1994 would be dropped, and everything else can
> be sent freely - because those are never "recursive openvpn packets".

I was just questioning this feature per se: why do we want to *allow*
real loops?

After your explanation I agree that this could be twisted into something
more useful, where we actually drop packets we know should *not* be on
the tunnel.


I guess we can conclude that this patch can be rejected as is.

We have two options now:
1) extend documentation (basically what part of this patch is doing);
2) rework this feature entirely.

If we go with 2 I guess we don't even need 1.

I'd go with 2, because this feature as it is now is not really
meaningful to me.

@Lev, are you up for the challenge?


Regards,



-- 
Antonio Quartulli

