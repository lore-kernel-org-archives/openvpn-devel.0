Message-ID: <4F4EAA97.6020600@...1490...>
Date: Thu, 01 Mar 2012 11:45:43 +1300
From: Jason Haar <Jason_Haar@...1490...>
MIME-Version: 1.0
References: <4F4CE4FE.3010009@...515...> <7855235.EvfmKnZP6h@...1526...>
	<CAP+U6t+ZUA3UpYfKms0Qr=-Cn1M-GP1EJtGybG0+j+O2xnfv7g@...278...>
	<1404593.Apkr3x9kAi@...1526...>
	<CAP+U6t+-8n=fFk+QP0Dm-H9YijcssjZjOHOpU5pwkSrXt1+qMQ@...278...>
	<20120229154604.GA7024@...1296...>
	<1056463883.20120229194318@...449...>
	<20120229212832.GC7024@...1296...>
	<CAOazyz3t+=2SsDA0+_sqByekvbE7R5Y+qHN2ysGDLw2hsiK8wg@...278...>
In-Reply-To: <CAOazyz3t+=2SsDA0+_sqByekvbE7R5Y+qHN2ysGDLw2hsiK8wg@...278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

A comment on your [1] reference. The issue of remote-user vs enterprise
is an old one - that affects many software applications - not just
openvpn. I personally think the proper solution is to implement NAC:
make "the network/enterprise" audit the remote host and only allow it if
it meets expectations. As such I don't think openvpn has to solve this
problem itself, as "the enterprise" cares a lot more about the remote
machine than whether or not the remote user has injected a couple of
routes into the local routing table. eg Windows AV status.

I think openvpn is quite entitled to act as a "mere" vpn solution, "the
enterprise" should invoke a more over-arching solution (such as NAC with
NAC agents) to ensure policy compliance.


Jason

On 01/03/12 10:36, Alon Bar-Lev wrote:
> 2012/2/29 Gert Doering <gert@...1296...>:
>> Hi,
>>
>> On Wed, Feb 29, 2012 at 07:43:18PM +0100, Carsten Krüger wrote:
>>>> Part of the assumption here is "the user controls the openvpn config",
>>>> and as such, he can make openvpn.exe run arbitrary scripts anyway - and
>>>> to stop this from being a problem, just run openvpn.exe with your uid.
>>> What operation could be in script that is usefull when it's executed
>>> in user context.
>>>
>>> I never used script with openvpn. I've no idea which are real world
>>> applications for it.
>> Scripts are for creative uses that the programmers of openvpn have not
>> foreseen.  Like "after the VPN is up, auto-sync all your git repositories"
>> or "open up a few xterms with ssh's to $internalhosts".
>>
>> David had some other idea recently, which I forgot.
> This is a great example why this functionality should *MOVE OUT* of
> the openvpn code base.
> The UI can monitor OpenVPN and run scripts when such events are
> detected via the management interface.
> The UI already runs in the context of the interactive user.
>
> I would like to receive replies to[1].
>
> Thanks,
> Alon.
>
> [1] http://sourceforge.net/mailarchive/message.php?msg_id=28910374
>
> ------------------------------------------------------------------------------
> Virtualization & Cloud Management Using Capacity Planning
> Cloud computing makes use of virtualization - but cloud computing 
> also focuses on allowing computing to be delivered as a service.
> http://www.accelacomm.com/jaw/sfnl/114/51521223/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-- 
Cheers

Jason Haar
Information Security Manager, Trimble Navigation Ltd.
Phone: +1 408 481 8171
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1


