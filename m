Message-ID: <511CD6F3.3010200@...515...>
Date: Thu, 14 Feb 2013 14:22:11 +0200
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <511CC1F1.6010409@...1114...>
In-Reply-To: <511CC1F1.6010409@...1114...>
Subject: Re: [Openvpn-devel] RFC - Usefulness of the --tls-remote semantic
 warning
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

I don't think these warnings are all that useful. People who don't have
the common sense to read the man-page are probably in trouble anyways.
I'd say revert the patch.

Samuli
> Hi,
>
> This is just a minor issue which has been annoying me a little bit.
> I've attached a patch which ensures that the --tls-remote semantic
> warning is only printed once.
>
> However, I wonder how useful that warning really is these days.  Do
> we really need that warning?  The warning comes from this commit [1]:
>
> commit c04bc0223c9b17f203555b933cbeedbf3b343c0e
> Author: james <james@...1807...>
> Date:   Sun Jul 27 18:20:52 2008 +0000
>
>     Added additional warnings for:
>     
>     * --tls-remote -- some people misunderstand the semantics
>     
>     * --script-security -- warn if script-security will allow user-defined
>       scripts to be called, and also warn separately if passwords may be
>       passed to scripts via the environment
>     
> It's from 2008.  I see that in some cases this warning is needed, but I
> also think people need to read the man pages when things doesn't work as
> expected.  Not that we need to hand-hold people the whole way through.
>
> If we find that all of these warnings are not that useful any more, I'd
> rather suggest that we revert the commit above.  Otherwise we can also
> consider to just remove the --tls-remote warning completely.
>
> Any thoughts?
>
>
> [1] <http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn-testing.git;a=commitdiff;
> h=c04bc0223c9b17f203555b933cbeedbf3b343c0e>
>
>


