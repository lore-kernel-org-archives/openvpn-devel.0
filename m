References: <4B8ADF36.3050201@...1114...>
	<20100301105856.GY9556@...1296...> <4B9C1C16.8080107@...68...>
	<20100314111949.GC25238@...1296...>
Date: Sun, 14 Mar 2010 12:26:58 +0100
MIME-Version: 1.0
From: "Matthias Andree" <matthias.andree@...68...>
Message-ID: <op.u9j128oe1e62zd@...33...>
In-Reply-To: <20100314111949.GC25238@...1296...>
Subject: Re: [Openvpn-devel]
 =?utf-8?q?=5BFeedback_needed=5D=C2=A0Fix_cross_co?=
 =?utf-8?q?mpile_support?=
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Am 14.03.2010, 12:19 Uhr, schrieb Gert Doering <gert@...1296...>:

> Hi,
>
> On Sun, Mar 14, 2010 at 12:13:26AM +0100, Matthias Andree wrote:
>> No offense, but do you think it's within objective discussion to call  
>> the patch
>> "mostly-religious change" (which is a non-objective comment in my book)  
>> if you
>> "don't really understand the subtleties of autoconf and friends"?
>
> Well, there's two parts to the original patch.
>
> One is the functional patches in configure.ac - I can't say anything  
> about
> that, so I'm not doing so.
>
> The other part is changing all TARGET_* defines to HOST_* defines.  This
> is not changing functionality or portability, as the very defines are
> explicitely set in configure.ac, and they could be MySystemIs_* as far as
> functionality is concerned.  So the change is because people believe it
> to be "the right way" - which makes it "mostly-religious" in my book: not
> based on functional changes, but because "it's the right way".

Well, proper naming improves readability, hence maintainability. I think  
that's more objective than mere belief.
   People will seldomly try to _quantify_ the efforts, but I've more often  
than not lost hours debugging some software (not OpenVPN though) because  
variables/macros bore misleading names.  The objective criterion here  
would be "proper names".

> ... and this is exactly what I proposed: don't include the larger chunk
> of the changes right *now*.  Wait for the multiple branches to settle
> down, and then decide how to adjust the TARGET_* definitions.

Which is a valid technical reason (as much as "use proper names" is).
I was trying to keep religion out though :)

> As for now, I have been operating under the premises that different  
> branches
> in the openvpn-devel tree should avoid to cause merge conflicts (unless
> unavoidable for required functionality, see ipv6 payload vs. ipv6  
> transport).

Point taken.

Thanks for your reply.

-- 
Matthias Andree

