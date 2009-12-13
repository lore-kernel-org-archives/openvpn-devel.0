Message-ID: <4B25733F.7020806@...1114...>
Date: Mon, 14 Dec 2009 00:05:35 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <50497.64.217.16.45.1260735536.squirrel@...1166...>
In-Reply-To: <50497.64.217.16.45.1260735536.squirrel@...1166...>
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

On 13/12/09 21:18, Daniel Johnson wrote:
> David Sommerseth wrote:
>> - -             const char *return_value = NULL;
>> +               aresp[i].resp = NULL;
> 
>> This I didn't think about, but I saw another potential leak.
>> However, your idea here is clever!  But I would probably
>> suggest:
> 
>>       if( aresp[i].resp ) {
>>               free(aresp[i].resp);
>>               aresp[i].resp = NULL;
>>       }
> 
>> But!  The potential culprit here is if the aresp[i] struct is not
>> zeroed before usage.  If it is not and this pointer is pointing
>> at something it do not own, your patch is definitely more the
>> correct approach.
> 
> It was already nulled at post-patch line 558.  I think that the
> additional NULLing makes the code more readable but strictly
> speaking it is not necessary.

Yes, you are right.  It's calloc'ed earlier in my_conv().  I just double
checked the whole code now (I just looked at the patch itself earlier
today).

I'd say this patch is ready for some real testing now, possibly worth
considering for inclusion to the next development tree.  I find it
valuable to include it at least.

One thing, which is a little bit of a mystery for me, is how the PAM
layer treats the whole aresp array pointer and the memory allocated
there.  I don't know the PAM implementation good enough to see if it
does any freeing of the allocated memory elsewhere.  This could be a
second place where memory leaks are found.  But to fix this, a bigger
rewrite would be needed.  And to be honest, this patch should not fix
that.  That's another patch.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkslczwACgkQDC186MBRfrrHpgCeLfKriodtHz2Cbh4VDFyBuJMz
mfAAn3+kUBwLWzIwSeOuZVUvuxiEpadS
=33Kf
-----END PGP SIGNATURE-----

