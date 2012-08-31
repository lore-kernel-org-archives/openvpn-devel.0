Message-ID: <5040C27C.5010006@...1227...>
Date: Fri, 31 Aug 2012 15:56:12 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1267361435-11982-1-git-send-email-openvpn.list@...1114...>
	<20100228142856.GL9556@...1296...>
	<4B8A8C69.7090801@...384...>
	<20100228164634.GQ9556@...1296...>
In-Reply-To: <20100228164634.GQ9556@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Add CID to the management status
	overview
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: David Sommerseth <dazo@...384...>, openvpn-devel@lists.sourceforge.net

Am 28.02.10 17:46, schrieb Gert Doering:
> Hi,
>
> On Sun, Feb 28, 2010 at 04:31:53PM +0100, David Sommerseth wrote:
>>> In the grand scheme of things, small whitespace changes might later on 
>>> lead to a merge conflict with another patch in this line (like "introduce 
>>> version 4" or so), and so I'd avoid changes that are purely cosmetic in 
>>> a "feature" patch.
>> Dang!  This one slipped through.  I spotted it, fixed it, but for some
>> reason I recreated the patch file and forgot I had fixed it.  Gert, I
>> completely agree with you!
> :)
>
>> I'll promise to fix this one when merging it into the git tree, is that
>> good enough for you, Gert?
> Yes, I'm fine with that.
This patch is very old but since someone asked for this feature on IRC I
am bringing this patch up again.

I think it is good to have a stateless way (without being connected to
the managament console all the time) to query the CID (client id).

Is it better to

a) break bad parsers when upgrading to 2.3
b) introduce a v4 format which only

Arne

