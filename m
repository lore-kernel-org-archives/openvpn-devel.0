From: Davide Brini <dave_br@...1278...>
Date: Wed, 10 Mar 2010 16:34:58 +0000
References: <1267391523-1123-1-git-send-email-openvpn.list@...1114...>
	<201002282326.32573.dave_br@...1278...>
	<4B97BE9C.4010203@...1114...>
In-Reply-To: <4B97BE9C.4010203@...1114...>
MIME-Version: 1.0
Message-Id: <201003101634.58839.dave_br@...1278...>
Subject: Re: [Openvpn-devel] [PATCH] bash->bourne script cleanup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Wednesday 10 Mar 2010 15:45:32 David Sommerseth wrote:
> On 01/03/10 00:26, Davide Brini wrote:
> > On Sunday 28 February 2010, David Sommerseth wrote:
> >> From: Dan Nelson <dnelson@...384...>
> >>
> >> Many of the scripts in the openvpn source have their shell set to
> >> /bin/bash, but only two use bash features. The attached patch (against
> >> openvpn-2.1_rc9) sets the shell on the rest of the scripts to /bin/sh
> >> for better portability. The only scripts that actually require bash are
> >> contrib/pull-resolv-conf/client.{up,down} ; they use the ${!var}
> >> variable indirection feature.
> >
> > Not only that, they also use arrays, which are not part of standard sh.
> >
> > For a POSIX-sh compliant solution thad does mostly the same thing (and
> > handles multiple DOMAIN options as well, which client.{up,down} doesn't
> > support), I suggest  you look into the Gentoo-provided {up,down}.sh
> > scripts (though they contain some Gentoo-specific parts, but those are
> > easily removed).
> 
> Agreed!  If you have time to look at a patch for it, I'd appreciate
> that.  It will go in as a separate patch, to keep the patch flow as
> simple as possible.

Well, I was actually going to write a patch, but shortly after starting I 
found out that it would end up being essentially the same as Gentoo's scripts.
Would it be worth separately maintaining something that has already been 
written somewhere else?

Note I'm not being argumentative, I'm just trying to understand what pople 
think, what the policy is, and what would be the best thing to do.
It's true that these are just two short scripts, and maintaining them would be 
no big deal anyway.

Thanks!

-- 
D.

