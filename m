From: Davide Brini <dave_br@...1278...>
Date: Sun, 6 Jun 2010 00:58:21 +0100
References: <20100604224938.GA19956@...1375...>
	<201006052336.37559.dave_br@...1278...>
	<915E9EDC-6AC1-4CAE-963C-0CBBFA3315F5@...1348...>
In-Reply-To: <915E9EDC-6AC1-4CAE-963C-0CBBFA3315F5@...1348...>
MIME-Version: 1.0
Message-Id: <201006060058.21798.dave_br@...1278...>
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
To: Toby Thain <toby@...1348...>
Cc: openvpn-devel@lists.sourceforge.net

On Sunday 06 June 2010, Toby Thain wrote:

> >> Most of the common GNU utilities (including gcc) are in the standard
> >> Solaris install, either via /usr/sfw/ or by using g prefix (e.g.
> >> gawk,
> >> gmake).
> >
> > Possibly, but it still means that either scripts using standard
> > names and expecting standard functionality have to be changed, or the
> > system has to be changed to have the standard-named utilites point to the
> > GNU versions.
> 
> Yes and no... Autotools will generally find the g-binaries (obviously
> autotools has long supported Solaris). OpenSolaris does, I believe,
> bring more GNU to standard userland (but this is not uncontroversial).

Well yes, but to paraphrase what you say later, "all the world's not GNU", so 
probably not everyone uses autotools :-)

In my (admittedly limited) experience, solaris has always shipped non-standard 
or inferior default tools, even long before GNU came about.

> It is a bit tricky deriving a portable bang-path in your case. But
> innovations like dash on Debian also serve to prove that 'all the
> world's not a GNU/Linux'.

Agreed! (although dash isn't perfect yet, but nevermind). That's why I think 
#!/bin/sh should be used. 

WARNING: Long and boring stuff follows; for the short version, skip to the 
last paragraph.

Actually, to be really pedantic, the shabang is NOT truly standard. It's just 
historical practice, whose existence the standard acknowledges and tolerates. 
Here's what the standard says:

"If the first line of a file of shell commands starts with the characters 
"#!", the results are unspecified."

(See http://www.in-ulm.de/~mascheck/various/shebang/ for more details on the 
shabang than you'd ever want to know.)

However as I said, historical practice is recognized, so it's considered in 
the relevant sections:

--------------
"Applications should note that the standard PATH to the shell cannot be 
assumed to be either /bin/sh or /usr/bin/sh, and should be determined by 
interrogation of the PATH  returned by "getconf PATH", ensuring that the 
returned pathname is an absolute pathname and not a shell built-in.
...
Furthermore, on systems that support executable scripts (the "#!"  construct), 
it is recommended that applications using executable scripts install them 
using "getconf PATH" to determine the shell pathname and update the "#!" 
script appropriately as it is being installed (for example, with sed)."
--------------

Yes, it's weird. But it does mean that users of shabang-based scripts are 
(theoretically) already expected to change the shabang path if needed. The 
standard goes on with some sample installation code which basically assumes 
that scripts should come in files named "script.source", and contain a magic 
word INSTALLSHELLPATH that would be replaced, at installation time, with the 
actual location of the POSIX-conformant "sh" on the system:

...
# Each script should begin:
#
# #!INSTALLSHELLPATH
#
scripts="a b c"
#
# Transform each script
#
for i in ${scripts}
do
    sed -e "s|INSTALLSHELLPATH|${Pshell}|" < ${i}.source > ${i}
done

where ${Pshell} is the location of "sh" determined from the output of "getconf 
PATH".


Alternatively, one would be supposed to do

PATH=$(getconf PATH)

to get a list of locations, on the system, where compliant tools are installed 
(under Solaris, that includes /usr/xpg4/bin). Then, run the scripts by doing

sh script

which, given the previously set $PATH, will find the POSIX "sh" on the system.


Obviously, certainly nobody adopts the suggested method, very few people use 
the alternative method, and virtually everybody relies on the shabang instead. 


So, given that everyone uses the shabang, and that #!/bin/sh seems to have 
become a more-or-less de facto path (at least in many people's expectations), 
my opinion is that OpenVPN scripts should either use #!/bin/sh and specify 
that a POSIX shell is expected, or (less preferred) use #!/bin/bash and 
specify that (obviously) bash is expected. Requiring bash is less preferred 
because that would force its installation on systems that don't have it, but 
after all it certainly wouldn't be the first piece of software in history 
coming with prerequisites or dependencies.
Some systems don't install bash or a POSIX sh in /bin, so it may also be 
necessary to create symlinks on those systems. I think it's the easiest 
tradeoff, and should be done anyway, because on such systems many other 
#!/bin/sh or #!/bin/bash scripts are likely to break anyway.

-- 
D.

