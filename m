Message-ID: <4B7F1AAA.5090103@...1114...>
Date: Sat, 20 Feb 2010 00:11:38 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1266620250-10045-1-git-send-email-openvpn.list@...1114...>
	<1266620772.31441.17@...1207...>
In-Reply-To: <1266620772.31441.17@...1207...>
Subject: Re: [Openvpn-devel] [PATCH v2] Do not randomize resolving of IP
 addresses in getaddr()
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
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 20/02/10 00:06, Karl O. Pinc wrote:
> On 02/19/2010 04:57:30 PM, David Sommerseth wrote:
> 
> Am I wrong or does using --disable-depr-random-resolv
> not remove the random choice?

That is correct.  According to the newly agreed feature removal process,
deprecated features should in the beginning be enabled but give warnings
when they are triggered.  At some point, this behaviour will be switched
to be disabled, and you need to do use --enable-depr-random-resolv.
And if nobody complains in the end, this code will be removed completely.

See the "Feature deprecatoin" section here for more info:
<http://www.secure-computing.net/wiki/index.php/OpenVPN/Developer_documentation>


kind regards,

David Sommerseth


>> From: David Sommerseth <dazo@...384...>
> 
>> For now this feature is enabled by default, but can be disabled by
>> running
>> ./configure with --disable-depr-random-resolv.  In the future this
>> will be
>> changed to being disabled by default before getting removed.
> 
> 
>> diff --git a/socket.c b/socket.c
>> index fecc398..c963a21 100644
>> --- a/socket.c
>> +++ b/socket.c
>> @@ -205,6 +205,10 @@ getaddr (unsigned int flags,
>>  	{
>>  	  if (h->h_addr_list[1]) /* more than one address returned */
>>  	    {
>> +#ifdef DEPRECATED_RANDOM_RESOLV
>> +#warning
>> +#warning **** DEPRECATED FEATURE ****   DEPRECATED_RANDOM_RESOLV is
>> enabled
>> +#warning
>>  	      int n = 0;
>>  
>>  	      /* count address list */
>> @@ -212,12 +216,16 @@ getaddr (unsigned int flags,
>>  		++n;
>>  	      ASSERT (n >= 2);
>>  
>> -	      msg (D_RESOLVE_ERRORS, "RESOLVE: NOTE: %s resolves to
>> %d addresses, choosing one by random",
>> -		   hostname,
>> -		   n);
>> +	      msg (D_RESOLVE_ERRORS, "RESOLVE: NOTE: %s resolves to
>> %d addresses, choosing one by random."
>> +                   " [DEPRECATED FEATURE]", hostname, n);
>>  
>>  	      /* choose address randomly, for basic load-balancing
>> capability */
>>  	      ia.s_addr = *(in_addr_t *) (h->h_addr_list[get_random
>> () % n]);
>> +
>> +#else /* preferred solution */
>> +	      msg (D_RESOLVE_ERRORS, "RESOLVE: NOTE: %s resolves to
>> more than one IP address, will "
>> +                   "use the first resolved address", hostname);
>> +#endif /* ENABLE_RANDOM_RESOLV */
>>  	    }
>>  	}
>>  
>> -- 
>> 1.6.6
>>
>>
>> ------------------------------------------------------------------------------
>> Download Intel&#174; Parallel Studio Eval
>> Try the new software tools for yourself. Speed compiling, find bugs
>> proactively, and fine-tune applications for parallel performance.
>> See why Intel Parallel Studio got high marks during beta.
>> http://p.sf.net/sfu/intel-sw-dev
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
>>
> 
> 
> 
> 
> Karl <kop@...1206...>
> Free Software:  "You don't pay back, you pay forward."
>                  -- Robert A. Heinlein
> 
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkt/GqoACgkQDC186MBRfrpghACeMK7u3dl70KFe8lWQvaHw2qa5
qJAAnjD1h9hTJgzdMrS5TYS1ADNn0fHt
=JlPD
-----END PGP SIGNATURE-----

