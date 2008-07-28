Message-ID: <488DEF21.1070306@...1114...>
Date: Mon, 28 Jul 2008 18:09:05 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <486B1657.4000409@...1114...>
In-Reply-To: <486B1657.4000409@...1114...>
Subject: Re: [Openvpn-devel] [resend] X509 TLS digest identifcation to
 plugin environment
Reply-To: dazo@...384...
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
To: openvpn-devel@lists.sourceforge.net


Hello again!

I've gone through the code and made a patch which cleanly patches against 
2.1rc7.  The only difference is that the line numbers where different due 
to inclusion of more functions and code into ssl.c.

Has anyone tried this patch at all (the old 2.0)?  Any comments would be 
appreciated.


kind regards,

David Sommerseth


David Sommerseth wrote:
> 
> Hello!
> 
> My last attempt to send to this mailing list was rejected, so I'm just trying it once more.
> 
> 
> kind regards,
> 
> David Sommerseth
> 
> 
> 
> -------- Original Message --------
> Subject: X509 TLS digest identifcation to plugin environment
> Date: Wed, 18 Jun 2008 16:35:23 +0200
> From: David Sommerseth <dazo@...384...>
> To: openvpn-devel@lists.sourceforge.net
> 
> 
> Hello!
> 
> I posted the following patch to the SourceForge patch tracker almost 2
> weeks ago.  I do not see if it has been acted upon this patch at all
> 
> http://sourceforge.net/tracker/index.php?func=detail&aid=1986805&group_id=48978&atid=454721
> 
> Patch summary:
> The patch implements another environment variable which is accessible
> for the plug-in interface.  A tls_digest_%i variable will contain the
> certificate X509 digest in SHA1 format.
> 
> The patch compiles cleanly against the 2.0 branch.  It complains with
> "hunk" fails when patching against the 2.1 branch, but it seems to me to
> be mainly that the ssl.c has received more attention lately, and the
> part of the code which I patch is being moved a little bit.
> 
> This patch only adds code, it do not change existing code.
> 
> Does anyone have a comment to this patch?  Does it need some rework to
> be accepted?  Some feedback would be appreciated.
> 
> 
> kind regards,
> 
> David Sommerseth
> 
> 
> 
> 
> -------------------------------------------------------------------------
> Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
> Studies have shown that voting for your favorite open source project,
> along with a healthy diet, reduces your potential for chronic lameness
> and boredom. Vote Now at http://www.sourceforge.net/community/cca08
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

