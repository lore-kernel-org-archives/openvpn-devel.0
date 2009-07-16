Date: Thu, 16 Jul 2009 15:37:51 +0200
From: Matthias Andree <ma+ovpnd@...31...>
Message-ID: <20090716133751.GA8884@...33...>
References: <4A5EFE61.3020100@...41...>
MIME-Version: 1.0
In-Reply-To: <4A5EFE61.3020100@...41...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc19 released
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
To: James Yonan <jim@...41...>
Cc: Openvpn-devel@lists.sourceforge.net

James Yonan schrieb:

> 2009.07.16 -- Version 2.1_rc19
...

> * In configure.ac, use datadir instead of datarootdir for compatibility
>    with <autoconf-2.60.

Dear Jim,

This is backwards.  Please don't do that, but revert that change and
instead update the argument of AC_PREREQ in configure.ac to read this:
AC_PREREQ(2.60)

Since you're using autoconf/automake, configure.ac changes and
requirements have zero impact on end users who download the tarball that
you generate through "make dist". Such changes only affects developers
who want to hack configure.ac or use the SVN version, and you can simply
expect them to have an autoconf version no older than 36 months.

In my experience, newer autoconf versions are more portable, have less
bugs, and are good for a much smoother ride than older versions.

I'm happy to look into updating configure.ac, which in general needs an
overhaul anyways - unless you say "no configure.ac updates before 2.1
release".

Best regards
Matthias

