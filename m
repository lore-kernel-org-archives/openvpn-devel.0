Date: Mon, 27 Jul 2009 23:24:01 +0200
From: Matthias Andree <ma+ovpnd@...31...>
Message-ID: <20090727212401.GA13327@...33...>
References: <4A5EFE61.3020100@...41...>
	<20090716133751.GA8884@...33...>
	<4A5F9A9C.7000805@...41...>
MIME-Version: 1.0
In-Reply-To: <4A5F9A9C.7000805@...41...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc19 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: James Yonan <jim@...41...>, Openvpn-devel@lists.sourceforge.net

Am 16.07.2009, 23:24 Uhr, schrieb James Yonan <jim@...41...>:

>> Dear Jim,
>>
>> This is backwards.  Please don't do that, but revert that change and
>> instead update the argument of AC_PREREQ in configure.ac to read this:
>> AC_PREREQ(2.60)
>>
>> Since you're using autoconf/automake, configure.ac changes and
>> requirements have zero impact on end users who download the tarball that
>> you generate through "make dist". Such changes only affects developers
>> who want to hack configure.ac or use the SVN version, and you can simply
>> expect them to have an autoconf version no older than 36 months.
>>
>> In my experience, newer autoconf versions are more portable, have less
>> bugs, and are good for a much smoother ride than older versions.
>>
>> I'm happy to look into updating configure.ac, which in general needs an
>> overhaul anyways - unless you say "no configure.ac updates before 2.1
>> release".
>
> We need to be able to build OpenVPN on older Linux distros, such as RHEL
> 4, that use pre-2.60 versions of autoconf.
>
> Before I made this change, I found that the previous code (using
> datarootdir instead of datadir on RHEL 4, autoconf-2.59-5) would
> generate a make install script that violated the --prefix argument --
> i.e. make install would try to write stuff outside the --prefix dir.  I
> was running the make install as a non-root user, so the jailbreak out of
> --prefix was obvious because it tried to write to parts of the
> filesystem that generated "permission denied" errors and halted the  
> script.
>
> I'm not an autoconf/automake expert, so if there's a better way to fix
> the issue, I'm open to it.

I don't know your build procedure.

If you're building from a tarball, you should never need to run autoconf,
and you don't even need it installed. The GNU autotools "make dist" rolls
the maintainer-generated files such as configure and Makefile.in into the
tarball, as well as required scripts such as install-sh.

So I'd probably do something like this:

1 - on a system that has autoconf >= 2.60, check out the code from SVN and
run autoreconf

2 - configure (you need not use the same operating system to do that),
then "make dist"

3 - copy the openvpn-$version.tar.gz to RHEL 4

4 - run rpmbuild -tb --sign openvpn-$version.tar.gz (use rpm on older RPM
versions that don't have the rpmbuild executable)


NFS mounts can make things even more convenient.



On several projects, I use Makefile.am snippets like these:

# this target expects a .rsyncs file with lines of this format:
# host:directory/
# it will call rsync from a freshly populated dist directory
# to the destination for each of the lines, running them in parallel
rsync:  distdir $(srcdir)/.rsyncs
           @( cat $(srcdir)/.rsyncs | sed -e 's}^}rsync -aH --delete-after
$(PACKAGE)-$(VERSION)/ }; s/\($$\)/ \&/;' ; echo "wait" ) \
	| $(SHELL) -x


and .rsync is something like this:

ma@...1241...:/var/tmp/ma/fetchmail
mandree@...1242...:/home/mandree/tmp/fetchmail

then "make rsync" will refresh the mentioned directories on said hosts as
though a fresh tarball had just been unpacked into a clean directory, so
you only need to log into host1... or host2...


I also commonly do VPATH builds on those hosts, so that I can update
without losing the object files that need not be recompiled, that goes
like - for example on host1:

cd /var/tmp/ma
mkdir -p build-fetchmail
cd build-fetchmail
../fetchmail/configure -C --what-ever-option-you-want
make


This is a convenience feature for testing. - Most useful if you can
authenticate without password; if you can't, remove the s/\($$\)/ \&/;
   from sed and the echo "wait" from the subshell to serialize the rsync
operations.

HTH

-- 
Matthias Andree

