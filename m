MIME-Version: 1.0
In-Reply-To: <55B4F1A2.4000707@...1114...>
References: <1437910039-30101-1-git-send-email-steffan@...1856...>
	<55B4F1A2.4000707@...1114...>
From: Steffan Karger <steffan@...1856...>
Date: Sun, 26 Jul 2015 21:21:44 +0200
Message-ID: <CAA1Abx+Wnuq85q2scX5zqtuhqJbJB-foUWrdB0Vq6PNPQKq7Yw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] reintroduce md5_digest wrapper struct
 to fix gcc warnings
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

On Sun, Jul 26, 2015 at 4:41 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
> On 26/07/15 13:27, Steffan Karger wrote:
>> I was wrong to assume that adding the const qualifier to the pointer-to-
>> fixed-size-array contruction used in options_hash_changed_or_zero() was
>> allowed.  GCC actually warns about this, but I was using clang and clang
>> seems to be fine with the contruction.  To make GCC happy too, reintroduce
>> the md5_digest wrapped struct, and use that when passing around the digest.
>>
>> Signed-off-by: Steffan Karger <steffan@...1856...>
>
> On holiday these days, so too lazy to check the git commit log ... but is this
> a revert of a single commit?  If so, having a reference to that commit would
> be beneficial to include in this commit message.

It doesn't really revert a commit, since the commit that introduced
this changed a lot more code. But it indeed does make sense to
reference it explicitly. Gert, could you include a reference to
827de237860813d2859aaae3aca292d42a9c2a82 in the commit msg?

-Steffan

