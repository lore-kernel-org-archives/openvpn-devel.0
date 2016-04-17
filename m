References: <3365AB24-33FD-4D9D-A57C-BF9240DC3D69@...2127...>
	<5710E5C6.6070104@...1227...>
	<CAKuzo_hWVecv2v9+ecHBC7PtbVkOgo3vMgCkGn1JPYVp-CjuEA@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <57137D23.40100@...1227...>
Date: Sun, 17 Apr 2016 14:10:11 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hWVecv2v9+ecHBC7PtbVkOgo3vMgCkGn1JPYVp-CjuEA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Make intent of device name validation
 clear
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>
Cc: Jens <openvpn-devel@...2127...>, openvpn-devel <Openvpn-devel@lists.sourceforge.net>

Am 15.04.16 um 18:41 schrieb Selva Nair:
> 
> On Fri, Apr 15, 2016 at 8:59 AM, Arne Schwabe <arne@...1227...
> <mailto:arne@...1227...>> wrote:
> 
>     Am 14.04.16 um 19:58 schrieb Jens:
>     > Hi,
>     >
>     > please review the following patch for a compiler warning on MacOS X. The program logic is unchanged.
>     Thanks for the patch.
>     Program logic is unchanged and the patch is fine but reading the fixed
>     code is more difficult.
> 
>     Instead of error of if not A you have now need to stare bit more to get
>     that meaning.
> 
> 
> I disagree.
> 
> Although if ( !strcmp() ) is a common usage in C, ( !srtcmp() == 0 ) is
> not, and such double negatives are best avoided. strcmp() == 0 and
> strcmp() != 0 are easily understood by C-programmers. 
> 
> As for the scanf line, the original is
> 
> if (!sscanf (dev_node, "utun%d", &utunnum)==1)
> 
> Here sscanf can potentially return EOF or 0 for failure or 1 for
> success, but the test catches only 0. EOF can result if dev_node == ""
> or "tun", so probably unlikely (?) because of previous checks. In any
> case. the intent appears to be to catch sscanf() != 1. And the latter is
> much better and easier to read.
> 
> If its only a question of style, the patch clearly improves the unusual
> usage in the original, imo.

Fine. I am not going to nitpick here. Lets just say ACK to the original
patch as it fixes the compiler warnings.

Arne


