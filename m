References: <11253b26-cb11-8b7a-02e0-d5b1ad89e199@...277...>
	<2465b076-35e8-6144-f1b8-085ad5a016f0@...277...>
	<e09e9fbc1ce629510c439bbc06569b1a.squirrel@...2260...>
	<f6a87e19-4ac0-4ea2-69f3-2f424cbe8891@...1227...>
	<86ef0241-5144-206a-4691-6713434fdaa4@...277...>
	<20170405204236.GM93896@...1296...>
	<ec5b45716d7fad0f492b19e6c54b82fe.squirrel@...2260...>
	<e6e53a2e-55ff-656d-4eb1-1c4a31403dbc@...2080...>
	<CAA1AbxLMr+vxxNqbmQ3OmJzL2ph9SWq=Snwspy9bJSbkPT0eJg@...278...>
	<3092a563-61dd-9240-b288-190b6f5fc259@...277...>
	<20170406130520.GR93896@...1296...>
From: debbie10t <debbie10t@...277...>
Message-ID: <f02c8610-0e25-9d7b-77ad-381779c4a00b@...277...>
Date: Thu, 6 Apr 2017 14:37:30 +0100
MIME-Version: 1.0
In-Reply-To: <20170406130520.GR93896@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add per session pseudo-random
 component to --reneg-sec intervals
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net



On 06/04/17 14:05, Gert Doering wrote:
> Hi,
>
> On Thu, Apr 06, 2017 at 01:49:04PM +0100, debbie10t wrote:
>> As you can see, the current proposal does not allow for first random,
>> followed by expected/normal/regular renegs. It is either *always* random
>> or *never* random .. I believe this is a poor decision.
>
> Your voice has been heard, and nobody else of the core team has been
> convinced.  It is not necessary to repeat that more often.

I believe the core team has made a poor decision and I am trying to 
explain clearly "why".

Take for example:

Company A has 1,000 vpn users and (for what ever reason) they reboot
the server every 24 hours.  They experience the slow down because all
their vpn users are permanently connected.  They all connect at once.
This patch is not trying to address the initial connect it is trying
to address the subsequent reneg's all happening at once.

So, Company A decides to use --reneg-sec max min

Subsequently, Company A receive a flood of complaints from users who are 
being constantly randomly reneg'd .. when they are accustomed to
regular hourly reneg's.

Company A either disables the randomisation ..
or tells their users "what" ?

The only justifiable randon reneg is the first one and Company A would 
be able to explain that to their users, that they must experience one 
random reneg or they all experience slow down at hourly intervals.


Regards

