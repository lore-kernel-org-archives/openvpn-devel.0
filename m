From: "James Yonan" <jim@...41...>
Message-ID: <twig.1063894170.44998@...41...>
In-Reply-To: <002101c37d68$afaac120$070116ac@...107...>
Subject: [Openvpn-devel] Re: Beta naming convention?
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Sep 18 07:11:09 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: John Conneely <john@...106...>, James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

John Conneely <john@...106...> said:

> Hi James!
> 
> First, thanks for such a great product!  I've been using openvpn-1.3.2 on a
> few Mandrake boxes for a little under a year now, and it's been bulletproof.

Cool!

> Now I'd like to try out windows support, so I thought I'd upgrade to your
> latest beta.  (I'm not sure if that's necessary on my linux boxes, but I
> thought it might be nice to try it out anyway.)

While it's possible for the windows version to talk to older linux versions,
the configuration is somewhat simpler if you stick to the 1.5 beta series on
both sides.

> The problem is that I
> install everything as RPMs on my Mandrake box, and I got an error when I
> used the rpmbuild-tb [tarball] command.  This seems to be because you use a
> dash character "-" in the version number.  I was able to get around this by
> making the dash character into an underscore, setting version to "1.5_beta7"
> in openvpn.spec.  I also made the directory name and tar ball use the same
> convention.  It works fine on the box I upgraded, even working with my other
> openvpn-1.3.2 installations.
> 
> Anyway, I wanted to suggest that you avoid using dash characters in future
> beta version numbers.

I'm somewhat reluctant to change the naming convention just because one tool
doesn't like dashes.  I don't understand why rpmbuild would complain about
such a universal convention?  After all, a great number of open source
packages use dashes in the naming convention, especially when designating a
"pre" or "beta" suffix.  Take the Linux kernel itself for example.  How does
rpmbuild deal with that?

The problem with changing version number conventions midstream is that it
creates confusion as well as discontinuity with the archived past.  I would
rather create a workaround that pacifies rpmbuild while keeping the current
naming convention.  Why not patch rpmbuild to accept rational naming conventions?

James


