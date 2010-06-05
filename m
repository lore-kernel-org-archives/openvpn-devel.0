From: Davide Brini <dave_br@...1278...>
Date: Sat, 5 Jun 2010 21:25:38 +0100
References: <20100604224938.GA19956@...1375...>
	<4C0AB229.4050307@...1114...>
In-Reply-To: <4C0AB229.4050307@...1114...>
MIME-Version: 1.0
Message-Id: <201006052125.38352.dave_br@...1278...>
Subject: Re: [Openvpn-devel] PATCH: remove bashisms from easy-rsa
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: Matthias Andree <ma+ovpnd@...31...>

On Saturday 05 June 2010, David Sommerseth wrote:
> On 05/06/10 00:49, Matthias Andree wrote:

> > Note that some parts of the scripts may be Solaris /bin/sh unfriendly,
> > for instance, Solaris's sh doesn't support test -e or [ -e. My patch
> > does not address this.
> 
> This makes me very reluctant from accepting the patch, to be very
> honest.  I'd rather keep the current bashism which works on all
> platforms where bash is available than to apply a patch which will break
> the script from working on one of the supported platforms.
> 
> I would rather like to see a patch which works safely on all platforms.
>  If 'test -e' or '[ -e' does not work in /bin/sh on some platforms, that
> do indeed speak for keeping the bash support - unless there are other
> ways how to solve this issue.

I think Solaris should have a POSIX-compatible shell (korn shell, hence 
supporting test -e) under /usr/xpg4/bin/sh, although for some reason the 
default /bin/sh is an old bourne shell. People could link /bin/sh to the POSIX 
shell, and then the scripts should work fine.
However, I think it would be sensible, before merging, to actually do that and 
test the scripts on a real Solaris system to check that they work as expected 
(unfortunately I don't have access to a Solaris system, otherwise I would do 
that myself).

-- 
D.

