Message-ID: <4B24B701.7090008@...1114...>
Date: Sun, 13 Dec 2009 10:42:25 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <35272.64.217.16.45.1260667920.squirrel@...1166...>
In-Reply-To: <35272.64.217.16.45.1260667920.squirrel@...1166...>
Subject: Re: [Openvpn-devel] Patch for plugin/auth-pam.c
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
To: Daniel Johnson <Progman2000@...1085...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 13/12/09 02:32, Daniel Johnson wrote:
> David Sommerseth wrote:
>> The pam_auth() function calls my_conv(), and if this function
>> gets a match on USERNAME or PASSWORD value in the block around
>> line 562, it calls searchandreplace() which does a strdup().  This
>> is dynamically allocated with strdup() and saved into return_value.
>> But!  In line 569, you have this line:
> 
>>                 aresp[i].resp = strdup (return_value);
> 
>> I presume that the aresp[] struct is freed somehow, I have not dug
>> into that now.  But you have here a double strdup() situation if you
>> get a match on USERNAME or PASSWORD.  It's almost like saying:
> 
>>               char *ptr = strdup (strdup ("string"));
>>               free(ptr);
> 
>> This code will give you a memory leak.
> 
>> Please confirm if my assumptions are correct.  I would probably
>> suggest to move the strdup() on line 569 and skip using the
>> return_value at all.  Just use aresp[i].resp directly.
> 
> OK, I think I'm following you.  It seems to me that the strdup()
> isn't  even needed for the no-match case, but I'm leaving it in
> there lest I break something.

Yes, you followed my thoughts very well :)  And doing the strdup() is
probably clever in this case in searchandreplace().  But I think I now
did spot another potential issue.

- -		  const char *return_value = NULL;
+		  aresp[i].resp = NULL;

This I didn't think about, but I saw another potential leak.  However,
your idea here is clever!  But I would probably suggest:

	if( aresp[i].resp ) {
		free(aresp[i].resp);
		aresp[i].resp = NULL;
	}

But!  The potential culprit here is if the aresp[i] struct is not zeroed
before usage.  If it is not and this pointer is pointing at something it
do not own, your patch is definitely more the correct approach.


Kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAksktv8ACgkQDC186MBRfrqFOQCeMqU4uF3NrrmBfUo0C3NbDAac
zwwAn29ZjHoRk2EdiAd4hr/GVsXTZnJM
=iEdJ
-----END PGP SIGNATURE-----

