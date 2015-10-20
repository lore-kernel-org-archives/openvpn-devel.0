References: <1445277979-21591-1-git-send-email-gert@...1296...>
	<5625FF23.70203@...1400...>
	<20151020212827.GN22054@...1296...>
From: David Sommerseth <openvpn.list@...1114...>
Message-ID: <5626C540.2080907@...1114...>
Date: Wed, 21 Oct 2015 00:50:40 +0200
MIME-Version: 1.0
In-Reply-To: <20151020212827.GN22054@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Add option --push-suppress-ipv6 to stop
 sending IPv6 info to clients.
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Arne Schwabe <schwabe@...1400...>
Cc: openvpn-devel@lists.sourceforge.net

On 20/10/15 23:28, Gert Doering wrote:
> Hi,
> 
> On Tue, Oct 20, 2015 at 10:45:23AM +0200, Arne Schwabe wrote:
>> Am 19.10.15 um 20:06 schrieb Gert Doering:
>>> Workaround option for servers that have IPv6 working just fine, but
>>> need to turn it off for individual clients - in that case, set this
>>> option in the --client-config-dir file for a particular user, or
>>> via --client-connect script/plugin hook for a particular platform
>>> (like IOS 9.0.2)
>>>
>> ACK from me. 
> 
> Heh :-) - this was more thought of an "here, what do you think?" patch
> (plus "fix valdikss' headache in #614 quickly"), and I didn't expect an
> ACK so quickly...
> 
> ... and then a discussion on IRC later.
> 
> But Arne actually had a very good idea which I'm going to implement and
> send "soon":
> 
>  --push-filter <keyword list>
> 
> like,
> 
>  --push-filter ifconfig-ipv6 tun-ipv6 route-ipv6
> 
> which would do exactly what the current patch did, but is much more flexible
> depending on what exactly needs to be worked around with *this* client...
> 
> (There's a trac ticket about "--push-reset", which we might resolve with
> this as well :-) )

I agree with the intention.  Just not sure 'filter' is a clever word.  As it
can be understood both as "remove these options" or "only include these
options".  Both interpretations are results of a filter.


-- 
kind regards,

David Sommerseth

