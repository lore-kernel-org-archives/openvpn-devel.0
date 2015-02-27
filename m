Sender: Vasiliy Kulikov <segooon@...277...>
Date: Fri, 27 Feb 2015 22:27:46 +0300
From: Vasily Kulikov <segoon@...2008...>
Message-ID: <20150227192746.GA5936@...2009...>
References: <20150225160718.GA6306@...2009...>
	<20150227182832.GE8134@...1296...>
MIME-Version: 1.0
In-Reply-To: <20150227182832.GE8134@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v4] Mac OS X Keychain management client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Gert,

On Fri, Feb 27, 2015 at 19:28 +0100, Gert Doering wrote:
> On Wed, Feb 25, 2015 at 07:07:18PM +0300, Vasily Kulikov wrote:
> > The patch is against commit 3341a98c2852d1d0c1eafdc70a3bdb218ec29049.
> > 
> > v4:
> >  - added '--management-external-cert' argument
> >  - keychain-mcd now parses NEED-CERTIFICATE argument if 'auto' is passed
> >    as cmdline's identity template
> >  - fixed typo in help output option name
> >  - added '--management-external-cert' info in openvpn(8) manpage
> >  - added 'certificate' command documentation into doc/management-notes.txt
> 
> Sorry to be nagging...  something in your patch was garbled, it contained
> stuff like
> 
> -----------------------
> only in patch2:
> unchanged:
> --- a/doc/management-notes.txt
> +++ b/doc/management-notes.txt
> @@ -777,6 +777,28 @@ correct signature.
>  This capability is intended to allow the use of arbitrary cryptographic
>  service providers with OpenVPN via the management interface.
> ...
> -----------------------

This stuff is missing in the patch itself which is in the email text,
and is contained in the attached interdiff file which contains changes
between patch v3 and v4.  AFAICS, the patch doesn't contain any garbage.

> (the diff for doc/management-notes.txt is in there twice), and there
> is a patch for .gitignore in it as well.

I've included .gitignore changes as my patch adds Makefile changes.  It
would be rather uncomfortable for openvpn developers to see Makefile and
be not able to change it.

> Please generate the patch with "git format-patch", that should avoid 
> spurious stuff.
> 
> 
> Also, in the doc/management-notes.txt, it has
> 
> +COMMAND -- certificate (OpenVPN 2.3 or higher)
> 
> please make that "2.4", as this code change is too large to go into 2.3
> (where we only do bug fixes and long-term stability stuff, but no new
> features generally)

It makes sense.

-- 
Vasily Kulikov
http://www.openwall.com - bringing security into open computing environments

