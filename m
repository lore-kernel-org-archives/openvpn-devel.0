Message-ID: <4BC82AF0.5080905@...1114...>
Date: Fri, 16 Apr 2010 11:16:32 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4BC78077.80301@...1114...> <4BC81AED.8010206@...1338...>
	<4BC824D3.8000008@...1114...>
In-Reply-To: <4BC824D3.8000008@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Harden create_temp_filename()
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
To: Fabian Knittel <fabian.knittel@...1338...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 16/04/10 10:50, David Sommerseth wrote:
> On 16/04/10 10:08, Fabian Knittel wrote:
>> Hi David,
> 
>> David Sommerseth schrieb:
>>> As promised in the meeting today, a patch for hardening
>>> create_temp_filename().
> 
>> Great! :)
> 
>>> I've added more checks to what create_temp_filename() returns where it
>>> is called in addition, to make it even safer.
> 
>>> +  do {
>>>      uint8_t rndbytes[16];
>>>      const char *rndstr;
>>>  
>>> +    attempts++;
>>> +    mutex_lock_static (L_CREATE_TEMP);
>>> +    ++counter;
>>> +    mutex_unlock_static (L_CREATE_TEMP);
>>> +
>>>      prng_bytes (rndbytes, sizeof (rndbytes));
>>>      rndstr = format_hex_ex (rndbytes, sizeof (rndbytes), 40, 0, NULL, gc);
>>>      buf_printf (&fname, PACKAGE "_%s_%s.tmp", prefix, rndstr);
>>> +
>>> +    retfname = gen_path (directory, BSTR (&fname), gc);
>>> +    if( !retfname ) {
>>> +      msg (M_FATAL, "Failed to create temporary filename and path");
>>> +      return NULL;
>>> +    }
>>> +  } while ( test_file (retfname) && (attempts < 6) );
>>> +
>>> +  if( attempts > 5 ) {
>>> +    msg (M_FATAL, "Failed to create temporary file after %i attempts", attempts);
>>> +    return NULL;
>>> +  }
>>> +
>>> +  /* Create the tempfile to avoid a race condition */
>>> +  fd = creat (retfname, S_IRUSR | S_IWUSR);
>>> +  if( fd == -1 ) {
> 
>> You'll probably want to add O_EXCL to creat()'s mode flags:
> 
>> |        O_EXCL Ensure that this call creates the file: if this flag  is
>>  speci
>> |               fied  in  conjunction with O_CREAT, and pathname already
>> exists,
>> |               then open() will fail.  The behavior of O_EXCL is
>> undefined  if
>> |               O_CREAT is not specified.
> 
>> Otherwise, there would be a race-condition between test_file() and
>> creat() and someone could create a symlink under you feet.
> 
> I honestly doubt that O_EXCL would help much, as the file will be closed
> immediately.

Actually, you might be right!  This might be useful.  But when checking
up the man pages for creat() and open(), I do get a bit confused about
the Linux implementation.  To explain this a little bit further, the man
page on Linux says:

	"O_EXCL is only supported on NFS when using NFSv3 or later on
	 kernel 2.6 or later."[1]

But comparing against other (older) Linux man pages, it says:

	"O_EXCL is broken on NFS filesystems"[2]
	(== will not work when being used on NFS)

So this is a bit confusing - are they _only_ talking about NFS or not?
For SunOS[3], Solaris[4] and FreeBSD[5], it behaves as you do expect.

Further, to use O_EXCL you need to use open() instead, as creat() is on
Linux open() with the O_CREAT|O_WRONLY|O_TRUNC flags set.

I'll look more into this, as the only advantage is that if open() with
O_EXCL|O_CREAT fails if the file exists, it should be used instead.


kind regards,

David Sommerseth


[1] <http://www.kernel.org/doc/man-pages/online/pages/man2/open.2.html>
[2] <http://www.cl.cam.ac.uk/cgi-bin/manpage?2+creat>
[3] <http://wwwcgi.rdg.ac.uk:8081/cgi-bin/cgiwrap/wsi14/poplog/man/2/open>
[4]
<http://www.scribd.com/doc/4001670/Solaris-10-Reference-Manual-Collection-Man-Pages-Section-2-System-Calls>
[5] <http://www.manpages.info/freebsd/open.2.html>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvIKu0ACgkQDC186MBRfrrUpQCgl5PTn7a5B8TUgCEIk9wz5OU1
SPIAoKGdFpgeesbttaq/iI5FZykbnSs0
=uOsr
-----END PGP SIGNATURE-----

