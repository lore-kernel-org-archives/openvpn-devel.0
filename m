Message-ID: <555893F1.9080207@...1856...>
Date: Sun, 17 May 2015 15:13:21 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <CAEsd45S8+hwK9mB53mVBLO-1NSJp7YE3tx53Am83pzDL+tr8GQ@...278...>
	<55464DBE.4010203@...1856...>
	<CAEsd45RoxhHiXGTAQwaPHHPnqfMk=iHjkoJOzeU_WaSU72MKXQ@...278...>
In-Reply-To: <CAEsd45RoxhHiXGTAQwaPHHPnqfMk=iHjkoJOzeU_WaSU72MKXQ@...278...>
Subject: Re: [Openvpn-devel] OpenVPN argument parsing of most options
 ignores "extra" parameters
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>



On 04-05-15 15:26, Jonathan K. Bullard wrote:
> Perhaps it could go into OpenVPN 2.4 but not 2.3? As I understand it,
> 2.3 is gets security and bug fixes, so many people probably don't test
> it as thoroughly as a new release; some probably won't test it at all
> -- those are the ones that you are presumably worried about. When 2.4
> is released, most people will test it at least cursorily before
> deploying it. If extra parameters cause a failure, it will be
> immediately obvious and can be fixed easily.
>
> Although usually ignoring extra parameters would not cause security
> problems, to the extent they do, the concept of OpenVPN being "secure
> by default" is jeopardized by not causing an error. Something like
> ignoring a "--redirect-gateway def1" -- which would cause traffic to
> be "leaked" outside of the VPN -- could be considered a security risk.
>

That sounds reasonable to me.  However, I tend to be easier in accepting 
(potentially) breaking changes than other community members.  So I think 
it makes sense to put this on the agenda for the next IRC meeting. 
Iirc, the next one should be tomorrow at 20:00 CEST.

-Steffan

