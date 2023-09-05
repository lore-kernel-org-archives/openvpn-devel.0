Message-ID: <a18f4083-18da-ed14-3475-faa4508b80e2@...2108...>
Date: Tue, 5 Sep 2023 12:39:00 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <fbf44b37-f89f-9329-862c-5d1015f6a4a8@...2108...>
 <c370f430-80c6-5fea-6233-042d5069a14e@...2108...>
 <CAHpv4cM_p+zAvCyqmu5cW1aVhM9DoOtRhW5svrBpsVNdj83j1g@...278...>
 <32f74cd6.AVMAACPKxlQAAAAAAAAAAW9e-ykAAYCsnhYAAAAAABXTlQBk9mOS@...2677...>
 <CAHpv4cMAG0QLtjz3TDYasRdG2+PKKUwt6MyP65BxSVSoarLHgg@...278...>
From: David Sommerseth <dazo+openvpn@...2108...>
In-Reply-To: <CAHpv4cMAG0QLtjz3TDYasRdG2+PKKUwt6MyP65BxSVSoarLHgg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix StatusChangeCallback so it works
 without a LogCallback
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
To: Jeremy Fleischman <jeremyfleischman@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 05/09/2023 07:03, Jeremy Fleischman wrote:
>> I have a feeling we're missing a check here.
> 
> Got it! You're right, I've added that in the v2 version of this patch
> (see below).

Could you send this via git-send-email, I think this is getting ready to 
be pulled in now.

    $ git send-email -v2 \
      --in-reply-to 20230709231929.195048-1-jeremyfleischman@...277...

Thx!


-- 
kind regards,

David Sommerseth
OpenVPN Inc


