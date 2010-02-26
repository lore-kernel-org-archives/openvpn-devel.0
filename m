From: Stefan Monnier <monnier@...1268...>
Message-ID: <jwvzl2vr3aw.fsf-monnier+inbox@...1269...>
References: <4B88110D.3020501@...1114...>
Date: Fri, 26 Feb 2010 18:27:42 -0500
In-Reply-To: <4B88110D.3020501@...1114...> (David Sommerseth's message
	of "Fri, 26 Feb 2010 19:21:01 +0100")
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] FQDN for routes should expand to all
	IPs (second round)
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: Openvpn-devel@lists.sourceforge.net

> - From the following review discussion, a few other things needs to be
> changed and I hope you are willing to look into adopting your patch to
> those guidelines.  This is also to follow the standards [1] we try to
> introduce as well.

Sure, I'd like to get this in the main OpenVPN code, so I'll do what
it takes.

> So, to give a summary to what needs to be done:
> * This feature should be #ifdef'ed, so that it can be disabled for those
> not wanting this feature.

AFAIK this is a bug-fix rather than a feature (the current behavior for
FQDNs mapping to multiple IPs is pretty difficult to justify), so
I wonder why it requires such #ifdef'ing.

> * MAX_IPS_PER_HOSTNAME should be set via ./configure.  I'd probably
> recommend that if this value is 0 the feature is not enabled (covers the
> first point automatically and simplifies ./configure)  If f.ex. only
> - --enable-resolve-all-ips (probably need a better targeted name) is given
> without a number, the default should be 20.

I'll do that.  I do wonder: IIUC setting this to 1 might result in
reproducing the current (buggy) behavior, so would #ifdef'ing still
be necessary?

> * Implement this patch on top of the frp branch,

I'm not sure what you mean by the "frp" branch.  Is tht a new branch in
the Git repository?  

> and make sure you add the possibility to disable the randomisation
> of resolving.

Of course, as before I'll just try and keep the "old" code and/or behavior.

> Would you be willing to do this job?  When these things are covered, I
> believe the patch has reached a state where it is suitable for inclusion.

OK, I'll let you know when it's ready for review,


        Stefan

