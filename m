Message-ID: <4BC824D3.8000008@...1114...>
Date: Fri, 16 Apr 2010 10:50:27 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4BC78077.80301@...1114...> <4BC81AED.8010206@...1338...>
In-Reply-To: <4BC81AED.8010206@...1338...>
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

On 16/04/10 10:08, Fabian Knittel wrote:
> Hi David,
> 
> David Sommerseth schrieb:
>> As promised in the meeting today, a patch for hardening
>> create_temp_filename().
> 
> Great! :)
> 
>> I've added more checks to what create_temp_filename() returns where it
>> is called in addition, to make it even safer.
> 
>> +  do {
>>      uint8_t rndbytes[16];
>>      const char *rndstr;
>>  
>> +    attempts++;
>> +    mutex_lock_static (L_CREATE_TEMP);
>> +    ++counter;
>> +    mutex_unlock_static (L_CREATE_TEMP);
>> +
>>      prng_bytes (rndbytes, sizeof (rndbytes));
>>      rndstr = format_hex_ex (rndbytes, sizeof (rndbytes), 40, 0, NULL, gc);
>>      buf_printf (&fname, PACKAGE "_%s_%s.tmp", prefix, rndstr);
>> +
>> +    retfname = gen_path (directory, BSTR (&fname), gc);
>> +    if( !retfname ) {
>> +      msg (M_FATAL, "Failed to create temporary filename and path");
>> +      return NULL;
>> +    }
>> +  } while ( test_file (retfname) && (attempts < 6) );
>> +
>> +  if( attempts > 5 ) {
>> +    msg (M_FATAL, "Failed to create temporary file after %i attempts", attempts);
>> +    return NULL;
>> +  }
>> +
>> +  /* Create the tempfile to avoid a race condition */
>> +  fd = creat (retfname, S_IRUSR | S_IWUSR);
>> +  if( fd == -1 ) {
> 
> You'll probably want to add O_EXCL to creat()'s mode flags:
> 
> |        O_EXCL Ensure that this call creates the file: if this flag  is
>  speci‐
> |               fied  in  conjunction with O_CREAT, and pathname already
> exists,
> |               then open() will fail.  The behavior of O_EXCL is
> undefined  if
> |               O_CREAT is not specified.
> 
> Otherwise, there would be a race-condition between test_file() and
> creat() and someone could create a symlink under you feet.

I honestly doubt that O_EXCL would help much, as the file will be closed
immediately.

> And as the important "does it exist?" test thereby moves to creat(), I
> would like to suggest that you move the creat() call into the loop. The
>  exit condition would then be "successful creat()" or "max attempts".

I agree that there is a tiny theoretical possibility for this to happen.
 The only possible place where you can manage this, is to create a
symlink is after the test_file() in the while() loop and before the the
creat(), in between there are only two integer checks  (attempts > 6 and
attempts < 5).

We're basically talking about a handful set of CPU cycles.  And in these
cycles, a malicious process needs to access the memory region of OpenVPN
where the newly decided temp filename is stored and to create a symlink
just before creat() is called.  Of course this is more doable if you're
able to preempt the OpenVPN process just before creat().

But if you have a malicious process being able to preempt OpenVPN or
even read the memory regions of OpenVPN, I'd say you have a much bigger
problem than this code section in OpenVPN.  Especially if you have
configured OpenVPN properly, meaning that the temp directory it uses is
not world writable.  By default, OpenVPN do not use /tmp for that, AFAIK.

I think "fixing" this is to be overly paranoid, as you will only narrow
the whole "attack scope" by a few CPU cycles and you will still not
remove the "attack scope".  It is still possible to manage that even if
you're inside the while() loop, it's just two integer comparisons being
skipped.

But please render me wrong, if you think I'm overseeing something here!

On the other hand, if such a change renders the code more readable,
that's another question - but then that should be the argument.

> PS: Is there some kind of code style guide for OpenVPN? I notice that
>     you're using a different style than I expected to see...

Uhh ... I am trying to follow the existing style as best as I can ...
but I see I've "failed" on parentheses around the 'if' statements.  Or
was it something else you noticed?  Could maybe be tab vs space?


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvIJNEACgkQDC186MBRfroycwCfQqmYQnSjuAa4Io4toU9e8zOp
GGYAoIj3VOCz/t0BKG285JMQtmdNZoN/
=7Hq1
-----END PGP SIGNATURE-----

