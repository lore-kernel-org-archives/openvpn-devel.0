Message-ID: <4AFC3F83.4090900@...41...>
Date: Thu, 12 Nov 2009 10:01:55 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <20091023142219.GA30874@...1066...> <4AE3580C.7080604@...41...>
	<20091026081943.GA29659@...1066...>
In-Reply-To: <20091026081943.GA29659@...1066...>
Subject: Re: [Openvpn-devel] Character classes in the tls-verify script
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
To: vitus@...1066...
Cc: openvpn-devel@lists.sourceforge.net

Victor Wagner wrote:
 > On 2009.10.24 at 13:39:56 -0600, James Yonan wrote:
 >
 >> Can you submit a patch (as an email attachment) with this fix?
 > Attached
 >
 > This patch also contains X509_NAME_oneline replacement, which handles
 > MSB characters.
 >
 > I've not checked if this patch applies cleanly to unmodified source.
 > I've just diffed original 2.1_rc19 source, imported in our subversion
 > repository with current working copy and removed all irrelevant chunks.

Thanks for putting this together.

I'm a bit concerned about changing any of the remapping behavior unless 
no-name-remapping is specified.  I see that in some areas, you test the 
no-name-remapping flag before you modify existing behavior, but in other 
areas such as my_X509_NAME_oneline, X509_NAME_CHAR_CLASS, and 
COMMON_NAME_CHAR_CLASS you don't.

Would it be possible for you to rework the patch so that it's a no-op 
unless no-name-remapping is specified?

James

Victor Wagner wrote:
> On 2009.10.24 at 13:39:56 -0600, James Yonan wrote:
> 
>> Can you submit a patch (as an email attachment) with this fix?
> Attached 
> 
> This patch also contains X509_NAME_oneline replacement, which handles
> MSB characters.
> 
> I've not checked if this patch applies cleanly to unmodified source.
> I've just diffed original 2.1_rc19 source, imported in our subversion
> repository with current working copy and removed all irrelevant chunks.
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> ------------------------------------------------------------------------------
> Come build with us! The BlackBerry(R) Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay 
> ahead of the curve. Join us from November 9 - 12, 2009. Register now!
> http://p.sf.net/sfu/devconference
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

