Message-ID: <4993AA88.2030907@...41...>
Date: Wed, 11 Feb 2009 21:50:16 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <20090127154806.GA38604@...33...>
	<9e0cf0bf0902031016x3734b539h6b13eebd1d37aefc@...278...>
	<499929A843E2C541A8AD31A881A2B6A202EAE379@...1006...>
	<200902102124.52217.alon.barlev@...277...>
In-Reply-To: <200902102124.52217.alon.barlev@...277...>
Subject: [Openvpn-devel] Patch Queue,
 was: Re: [PATCH] Fix for "Cannot read current defaultgateway"
 problem on Linux
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net, David Balazic <David.Balazic@...1005...>

Alon Bar-Lev wrote:
> On Tuesday 10 February 2009 13:35:35 David Balazic wrote:
>> Ping ?
>>
>> Should I resend the patch without the end-of-line-spaces change ?
> 
> James has his own response times.
> I suggest you have much patience.... :)
> 
> Alon.

I apologize for not having the bandwidth to focus as much on the patch 
queue as I would like, but please understand that we're on the verge of 
releasing 2.1 and we have to be very conservative about accepting 
patches at this point.

I think it's fair to ask that we try to limit ourselves at this late 
stage to patches that address issues that affect a large number of 
users, or bug fixes that are sufficiently trivial that there is little 
or no chance of causing unforeseen breakage.  I think there needs to be 
an argument for why the patch is important right now, as opposed to 
waiting a while for the 2.2 beta series.

Remember that sometimes just posting a patch here on the list is an 
optimal solution even if it is not immediately merged into the mainline 
-- people that need it can always apply it, and this allows the patch to 
be tested more extensively before it is merged.

James

