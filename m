Message-ID: <4BCB075C.70306@...1114...>
Date: Sun, 18 Apr 2010 15:21:32 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1271449313-26315-1-git-send-email-openvpn.list@...1114...>
	<1271449313-26315-2-git-send-email-openvpn.list@...1114...>
	<4BC8D9B4.1050709@...1338...>
In-Reply-To: <4BC8D9B4.1050709@...1338...>
Subject: Re: [Openvpn-devel] [PATCHv2 1/3] Harden create_temp_filename()
	(version 2)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Fabian Knittel <fabian.knittel@...1338...>
Cc: James Yonan <james@...515...>, Openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 16/04/10 23:42, Fabian Knittel wrote:
> Hi David,
> 
> David Sommerseth wrote:
>> +    }
>> +  while (attempts < 6);
>>  
>> -  return gen_path (directory, BSTR (&fname), gc);
>> +  msg (M_FATAL, "Failed to create temporary file after %i attempts", attempts);
>> +  return NULL;
>>  }
> 
> I noticed something else ... if - hypothetically - someone manages to
> guess our file names 5 times in a row, we abort the OpenVPN process.
> Maybe that's a bit drastic?
> 
> If I understand M_FATAL correctly, msg() doesn't even return.  So
> effectively, the create_temp_file() function never returns NULL, because
> all error cases are currently fatal.
> 
> As you've apparently prepared the code for the NULL case in your 2/3
> patch, I would suggest a non-fatal error code for at least the last case.

(whoops, I seem to have overseen this one yesterday)

Good points, I actually didn't think about it, that the M_FATAL causes a
shutdown of OpenVPN ... but I'm just wondering what would be the really
proper solution though.  And there are three places needs to be
considered separately.


* msg (M_FATAL, "Failed to create temporary filename and path");
This indicates that putting together the pieces for a full path failed.
 The reason of failure could be due to wrong input data, basically.
This one should be a normal warning message (M_WARN) and not M_FATAL.


* msg (M_FATAL, "Could not create temporary file '%s': %s",
*               retfname, strerror_ts (errno, &gcerr));
This one kicks in on filesystem errors only, when the open() call fails.
 This could be both M_FATAL (if you consider the features which depends
on temp files) and M_WARN or M_NONFATAL (because the calling function
should do decide what to do when this fails).  I'm leaning towards
dropping M_FATAL here.  Not sure if M_WARN or M_NONFATAL is appropriate
here, but leaning towards M_NONFATAL.


* msg (M_FATAL, "Failed to create temporary file after %i attempts",
attempts);
This is in the very end of the function.  Doing M_FATAL with shutdown,
is the safest situation - as it closes down a service which obviously
struggles with some sever issues.

By not doing M_FATAL, but M_WARN or M_NONFATAL instead, it is up to the
calling function to decide what to do.  I would still think that in this
case, should still be M_FATAL.  Just because this is a very extra
ordinary situation which indicates that something is crucially wrong on
the system.

It could indicate that someone is able to read the memory and try to
"hijack" the process by creating its own file.  But a more reasonable
situation could be thay the random string is not random any more, and it
provides the same file name over and over again.


Any other thoughts?


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvLB1wACgkQDC186MBRfrrNDwCfTM4tb206N0idGrcAurqibkwf
7RQAnj8Jey99RvuGvTJKi72d38vZv0MN
=/qq6
-----END PGP SIGNATURE-----

