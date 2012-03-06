Message-ID: <4F565877.2080704@...1114...>
Date: Tue, 06 Mar 2012 19:33:27 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F4CE4FE.3010009@...515...>
	<1848924920.20120228183103@...449...>
	<CAOazyz0x4hKsREcGi+9TGc+AO0d+i1d5qbmPJ2hQfCsUbVanNQ@...278...>
	<319492303.20120228213418@...449...>	<1331052472905814500@...1315...>
	<CAOazyz0K7NONN9uFsqD5_uF_xmApF7BUmE8Wg_tarejrf5aVbw@...278...>
	<1331055760398534500@...1315...>
In-Reply-To: <1331055760398534500@...1315...>
Subject: Re: [Openvpn-devel] OpenVPN Management Interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Russell Morris <openvpn@...1315...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/03/12 18:42, Russell Morris wrote:
> Hi,
> 
> 
> 
> That makes sense - thanks! I'm not a security expert by any means, so
> the thread lost me when it diverged into this area ... :-(.
> 
> 
> 
> At the risk of asking a stupid question (but that is my specialty ...
> :-)) - is there a conclusion of how to deal with this?

Not a stupid question at all!

Currently there is no way how to solve this.   However, in the
2.3-alpha1, it might be a detail you might find as an interesting
/workaround/ now.  The management can be used to override 'remote'
options from the configuration file.  The management interface
understands now the 'remote' command.

See these references for more info:
<http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn-testing.git;a=commit;h=54561af63699e7408fba11c75bbf9e22ed6216dc>

management-notes.txt:
<http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn-testing.git;a=blob_plain;f=management/management-notes.txt;hb=master>

The requirement is that there is at least one remote configured.  But
once the management is enabled with this feature, it can be changed at
will afterwards.

However, I see a potential issue with this approach via the management
API.  *If* a malware process runs which is OpenVPN aware, it *may*
connect to the management interface and redirect the connection via a
middle-man.  The management interface should be password protected, of
course, but that password is stored in memory - hopefully only in memory.
 So unless memory access is properly restricted, other processes *may*
get access to this memory region.

I'm no Windows developer, but in most modern OSes each process usually
runs inside it's own memory region which is restricted for other
processes.  However, buffer overruns, isn't that uncommon - but mostly
caused by bugs in the OS, or improper memory management in the
application (using shared memory pages without being careful enough).
And there are two programs which needs to know about the password,
openvpn.exe and the GUI.  And these two processes needs to communicate
and co-operate somehow.

Of course, this is a purely theoretical aspect.  There are some security
layers which can be used to avoid some of this, like f.ex --tls-auth and
- --tls-remote.  But this is not a bullet-proof solution either.

The malware can still try to replace the complete configuration files,
copy the originals to it's own server and setup a transit tunnel
automatically - hiding all this.  But then it's not dependent on the the
management interface at all.  And in fact, this might be an easier
approach in most cases.  The management interface is probably just more
interesting where configuration files cannot easily be modified by the
user.  And this would most likely be used in a targeted attack too.


kind regards,

David Sommerseth


> On Tue, 03/06/2012 11:12 AM, Alon Bar-Lev <alon.barlev@...277...>
> wrote:
> 
> This exactly what we discuss at the privilege separation thread... 
> Currently to change configuration you need to start a process.
> 
> 2012/3/6 Russell Morris <openvpn@...1315...
> <mailto:openvpn@...1315...>>:
>> Hi,
>> 
>> 
>> 
>> Taking off from the thread below - is it possible in Windows to
>> start openvpn, but only as a sort of local server (for lack of a
>> better
> term)? I
>> would like to start it up, and then be able to initiate connections,
>> tear them down, change proxy, etc. - all via the mangement
>> interface.
>> 
>> 
>> 
>> Is this possible?
>> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9WWHQACgkQDC186MBRfroTeACfQlb36yjb+80WgRoDEPQd4+E2
agQAniW1zWbtgCrPK4NUeWmVgNm656me
=L2Pl
-----END PGP SIGNATURE-----

