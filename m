Message-ID: <4818EF70.6060900@...41...>
Date: Wed, 30 Apr 2008 16:15:12 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <4811E5AA.8060900@...1090...>
In-Reply-To: <4811E5AA.8060900@...1090...>
Subject: Re: [Openvpn-devel] [patch] OpenVPN 2.1_rc7, multihome and 64 bit
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
To: Tim Davies <tim@...1090...>
Cc: openvpn-devel@lists.sourceforge.net

Interesting.  I wonder if a better solution might be to bracket the 
struct openvpn_pktinfo definition with

#pragma pack(1)
...
#pragma pack()

James

Tim Davies wrote:
> After attempting to use OpenVPN 2.1_rc7 on a 64 bit Centos 5 platform, 
> I came across a peculiar error when enabling multihome.  Basically no 
> UDP packets were allowed to send due to an incorrect size being set.
>
> The problem seems to be in socket.c, where sizeof(opi) is incorrect.  
> The structure is defined as:
>
> struct openvpn_pktinfo
> {
>  struct cmsghdr cmsghdr;
>  struct in_pktinfo in_pktinfo;
> };
>
> On a 64 bit platform, sizeof(struct cmsghdr) is 16, and sizeof(struct 
> in_pktinfo) is 12.  Due to structure padding, sizeof(struct 
> openvpn_pktinfo) is 32, not 28.
>
> The attached patch fixed the problem, although I'm not sure it's the 
> best way to go about it.
>
>
> Tim.
> ------------------------------------------------------------------------
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
> Don't miss this year's exciting event. There's still time to save $100. 
> Use priority code J8TL2D2. 
> http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
> ------------------------------------------------------------------------
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


