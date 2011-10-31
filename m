Message-ID: <4EAF0EFD.6060106@...1114...>
Date: Mon, 31 Oct 2011 22:11:25 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1320075008.29689.31.camel@...1520...>
In-Reply-To: <1320075008.29689.31.camel@...1520...>
Subject: Re: [Openvpn-devel] [PATCH] adding support for systemd tty console
 wrapper
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
To: Frederic Crozat <fcrozat@...1519...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 31/10/11 16:30, Frederic Crozat wrote:
> Hi,
> 
> as part of openSUSE switching to systemd by default, openVPN was made 
> compatible with the systemd way of querying passphrase during boot 
> (directly opening tty isn't supported).
> 

Thanks a lot for looking into this!  I feared that we would need to do
some changes due to systemd.

Generally, this looks very fine.  But I would like to see a few changes
first before including it.

a) From what I've understood, systemd is by design a Linux only thing.
So I'd like to see these code paths restricted to TARGET_LINUX (#ifdef
statements).  A lot of the dependencies is kernel related, so we probably
won't see systemd for BSD, for example.  And even less realistic is
Solaris.  Windows already goes a different route, so this won't be
affected here.

b) As systemd is not targetted for embedded Linux devices (it's a massive
resource hog, esp. in RAM and looks like to be most suitable in
desktop/laptop environments), it could be useful to have this support
compile time confiugrable via ./configure.  I would even vote for
disabling it by default.  Right now, systemd only got traction from SuSE,
Fedora.  Debian is in the works and Ubuntu usually follows Debian.  Arch
Linux will move over as well.

However, I am systemd sceptic, and I would like to see if systemd really
settles as a de-facto SySV replacement across the majority of Linux
distributions, before enabling this support by default on Linux.  I
struggle to see that systemd will be beneficial on (enterprise) servers,
as if the booting goes twice as fast or not on a server isn't that
critical compared to a desktop/laptop system.  And boot performance is
one of the key points systemd tries to resolve.

c) It would probably be better to but the "check if systemd is available"
into it's own function, for clarity - isolated in
#ifdef defined(TARGET_LINUX) && defined(USE_SYSTEMD) blocks.  And
likewise, do the /bin/systemd-ask-password in a separate function similar
fashion as what is done with Windows' get_console_input_win32().

d) Instead of asprintf(), use openvpn_snprintf() functions.  That can
probably be just as fine work against a static sized buffer (say 256
bytes - it's for a password, right?)  As this is called during startup,
and it is serialised among all those places this might be asked for,
there are no threading issues here, AFAICS.

e) Consider to make use of openvpn_execve_check() or openvpn_execve()
instead of the popen() - or make a popen() variant which got similar
error controls to popen() as openvpn_execve*() functions.  I also think
that this execution should honour the --script-security setting (which is
implicitly checked for with openvpn_execve())

f) There are a few mixtures between tab and spaces in your patch.  If you
could please use space only, that would be great.  The code is a mess in
this regard, but we're trying to (very slowly) reduce the variety in new
patches.



kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6vDvoACgkQDC186MBRfrr6PwCdGFh7VKA9nRN05ommWCnAe9CH
xJIAoJRW8+pjM7ipFeQW4nHgBY7S1Ty7
=0kja
-----END PGP SIGNATURE-----

