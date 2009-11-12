Date: Thu, 12 Nov 2009 20:59:24 +0300
From: Victor Wagner <vitus@...1066...>
Message-ID: <20091112175924.GA10462@...1066...>
References: <20091023142219.GA30874@...1066...> <4AE3580C.7080604@...41...>
	<20091026081943.GA29659@...1066...> <4AFC3F83.4090900@...41...>
MIME-Version: 1.0
In-Reply-To: <4AFC3F83.4090900@...41...>
Subject: Re: [Openvpn-devel] Character classes in the tls-verify script
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

On 2009.11.12 at 10:01:55 -0700, James Yonan wrote:

> Victor Wagner wrote:
> > On 2009.10.24 at 13:39:56 -0600, James Yonan wrote:
> >
> >> Can you submit a patch (as an email attachment) with this fix?
> > Attached
> >
> > This patch also contains X509_NAME_oneline replacement, which handles
> > MSB characters.
> >
> > I've not checked if this patch applies cleanly to unmodified source.
> > I've just diffed original 2.1_rc19 source, imported in our subversion
> > repository with current working copy and removed all irrelevant chunks.
>
> Thanks for putting this together.
>
> I'm a bit concerned about changing any of the remapping behavior unless  
> no-name-remapping is specified.  I see that in some areas, you test the  
> no-name-remapping flag before you modify existing behavior, but in other  
> areas such as my_X509_NAME_oneline, X509_NAME_CHAR_CLASS, and  
> COMMON_NAME_CHAR_CLASS you don't.

Problem is that existing behavoir seems to be designed without non-ascii
alphabets in mind.

I think that "preserving existing behavoir" is "exporting alpabetic
characters as they are". Since it is quite hard to distinguish between
"alphabetic" and "non-alphabetic" outside of ASCII range, and no shell
use non-ascii as separators (which is primary reason of remapping),
I've considered safe way to treat all 8-bit characters as alphabetic.

no-name-remapping  has side effects, i.e. disables system method of
script execution. 

So, all non-latin-writting users would face choice - either 
use their native language and loose some functionality of openvpn
or have full fuctionality and loose native languge.

Really, I think than name remapping shouldn't be applied to environment
variables at all. May be for command line arguments should be protected
this way. But people who use environment variables typically are clever
enough to  handle shell special characters.

Moreover, if script is written in some better language than shell (i.e.
perl, tcl on even is a C program, which should be probably considered
worse language, as it is prone of buffer overflows), or for dlopened
plugin same remapping rules are applied.


