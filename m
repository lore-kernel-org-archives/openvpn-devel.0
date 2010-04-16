Message-ID: <4BC8ACB5.6060303@...1114...>
Date: Fri, 16 Apr 2010 20:30:13 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4BC78077.80301@...1114...>
	<4BC81AED.8010206@...1338...>	<4BC824D3.8000008@...1114...>	<4BC82AF0.5080905@...1114...>	<20100416093554.GJ12312@...1296...>	<4BC8385D.8040703@...1114...>
	<4BC85F4C.8020505@...1338...>
In-Reply-To: <4BC85F4C.8020505@...1338...>
Subject: Re: [Openvpn-devel] [PATCH] Harden create_temp_filename()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Fabian Knittel <fabian.knittel@...1338...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 16/04/10 14:59, Fabian Knittel wrote:
> Hi David,
> 
> David Sommerseth wrote:
> (BTW, I thought creat() took a flags parameter, but it only takes a mode
> param. My mistake. So you're correct in wanting to use open() instead of
> creat().)
> 
> To let the code speak, here's my suggestion (not compile-tested):
> 
>> do
>>   {
>>     uint8_t rndbytes[16];
>>     const char *rndstr;
>>
>>     ++attempts;
>>     mutex_lock_static (L_CREATE_TEMP);
>>     ++counter;
>>     mutex_unlock_static (L_CREATE_TEMP);
>>
>>     prng_bytes (rndbytes, sizeof rndbytes);
>>     rndstr = format_hex_ex (rndbytes, sizeof rndbytes, 40, 0, NULL, gc);
>>     buf_printf (&fname, PACKAGE "_%s_%s.tmp", prefix, rndstr);
>>
>>     retfname = gen_path (directory, BSTR (&fname), gc);
>>     if (!retfname)
>>       {
>>         msg (M_FATAL, "Failed to create temporary filename and path");
>>         return NULL;
>>       }
>>
>>     /* Atomically create the file.  Errors out if the file already
>>        exists.  */
>>     fd = open (retfname, O_CREAT | O_EXCL | O_WRONLY, S_IRUSR | S_IWUSR);
>>     if (fd != -1)
>>       {
>>         close (fd);
>>         return retfname;
>>       }
>>     else if (fd == -1 && errno != EEXIST)
>>       {
>>         /* Something else went wrong, no need to retry.  */
>>         struct gc_arena gcerr = gc_new ();
>>         msg (M_FATAL, "Could not create temporary file '%s': %s",
>>              retfname, strerror_ts (errno, &gcerr));
>>         gc_free (&gcerr);
>>         return NULL;
>>       }
>>   }
>> while (attempts < 6);
>>
>> msg (M_FATAL, "Failed to create temporary file after %i attempts", attempts);
>> return NULL;

I like it!  It looks cleaner!  Thanks for standing the argument ;-)
I'll look at a new patch, hopefully today.

> (Regarding the code style: The above uses what I had thought would be
> the current style, but as I've only read parts of the OpenVPN code, I'm
> likely to be wrong. Are there any code-parts / newer code-parts which
> should be considered reference material?)

I don't think so.  You might find some few differences throughout the
code, but the coding style is not documented anywhere, to my knowledge.

>> I've dived into the kernel code to see what it *really* does (when the
>> man page are so unclear), and it should behave as those other Unices
>> does as well.  So, O_EXCL do make sense to avoid overwriting existing
>> files if it is a symlink to an existing file.
> 
> IMHO the Linux man-page ist quite clear (I'm using version 3.24):
> 
>>        O_EXCL Ensure that this call creates the file: if this flag  is  speci‐
>>               fied  in  conjunction with O_CREAT, and pathname already exists,
>>               then open() will fail.  The behavior of O_EXCL is  undefined  if
>>               O_CREAT is not specified.
>>
>>               When  these two flags are specified, symbolic links are not fol‐
>>               lowed: if pathname is a symbolic link, then open() fails regard‐
>>               less of where the symbolic link points to.
>>
>>               O_EXCL  is  only  supported  on NFS when using NFSv3 or later on
>>               kernel 2.6 or later.  

This sentence is the one which made me uncertain.  Because here it
restricts things more to NFS.  I've already suggested a patch to the
man-pages maintainer clarifying this paragraph.

>>               In environments where NFS  O_EXCL  support
>>               is not provided, programs that rely on it for performing locking
>>               tasks will contain a race  condition.   Portable  programs  that
>>               want  to  perform atomic file locking using a lockfile, and need
>>               to avoid reliance on NFS support for O_EXCL, can create a unique
>>               file  on  the same file system (e.g., incorporating hostname and
>>               PID), and use link(2) to  make  a  link  to  the  lockfile.   If
>>               link(2)  returns  0,  the  lock  is  successful.  Otherwise, use
>>               stat(2) on the unique file  to  check  if  its  link  count  has
>>               increased to 2, in which case the lock is also successful.
> 
> Using open with O_CREAT|O_EXCL:
>   - makes the atomic guarantee, that the file was created by us (or
>     the function call fails)
>   - does not follow symlinks (if a symlink exists, it fails)
>   - works over NFS for NFS implementations that support O_EXCL. (This
>     should apply to all current Linux NFS implementations.)
> 
> So, anything remaining that you'd like cleared up?

Nope :)


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEUEARECAAYFAkvIrLUACgkQDC186MBRfrroVwCfWA0XoZHtQ/oTWC0pSTIL1qum
54gAmMH1al5cXbaEafUS6PMkqnmMm2U=
=E8fx
-----END PGP SIGNATURE-----

