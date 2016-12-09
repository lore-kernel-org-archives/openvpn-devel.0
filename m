MIME-Version: 1.0
In-Reply-To: <bfcaa197-893f-afba-7554-07edcde483a2@...2080...>
References: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
	<CAKuzo_gH06N2yip+h-=Q_w1xpyP62d6v4-7=Bb2NK-=+ji6iKw@...278...>
	<943c0ce1-501c-df5a-fb47-53ab7a689d36@...2080...>
	<bfcaa197-893f-afba-7554-07edcde483a2@...2080...>
From: Steffan Karger <steffan@...1856...>
Date: Fri, 9 Dec 2016 14:41:24 +0100
Message-ID: <CAA1AbxLXh_AOuHFBt0Om=eDOLH-WHM_C6OnGgHLnO+iAYP7dEw@...278...>
Subject: Re: [Openvpn-devel] Coding style clean-up ... phase 1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 9 December 2016 at 00:14, David Sommerseth
<openvpn@...2080...> wrote:
> I just spotted in ssl.c that we need sp_assign=add.
>
> [ ssl.c, tls1_PRF() ]
>     len = slen/2;
>     S1 = sec;
>     S2 = &(sec[len]);
>     len += (slen&1); /* add for odd, make longer */
>
> I believe we've agreed on spaces around assignments.

Hm, I'd be fine with that, but I'm afraid there are too many such
details to bikeshed about.  Once we've fixed the curious newlines
Selva mentionded (sorry, not sure when I can look at that), I think we
should stop the discussion and move forward.  Just 5 more days until
rc2 (where the reformatting should be done).

-Steffan

