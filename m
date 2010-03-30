Message-ID: <4BB203BF.30202@...1114...>
Date: Tue, 30 Mar 2010 15:59:27 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <50497.64.217.16.45.1260735536.squirrel@...1166...>
	<4B25733F.7020806@...1114...>
In-Reply-To: <4B25733F.7020806@...1114...>
Subject: Re: [Openvpn-devel] Patch for plugin/auth-pam.c
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
To: Daniel Johnson <Progman2000@...1085...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 14/12/09 00:05, David Sommerseth wrote:
> On 13/12/09 21:18, Daniel Johnson wrote:
>> David Sommerseth wrote:
>>> - -             const char *return_value = NULL;
>>> +               aresp[i].resp = NULL;
> 
>>> This I didn't think about, but I saw another potential leak.
>>> However, your idea here is clever!  But I would probably
>>> suggest:
> 
>>>       if( aresp[i].resp ) {
>>>               free(aresp[i].resp);
>>>               aresp[i].resp = NULL;
>>>       }
> 
>>> But!  The potential culprit here is if the aresp[i] struct is not
>>> zeroed before usage.  If it is not and this pointer is pointing
>>> at something it do not own, your patch is definitely more the
>>> correct approach.
> 
>> It was already nulled at post-patch line 558.  I think that the
>> additional NULLing makes the code more readable but strictly
>> speaking it is not necessary.
> 
> Yes, you are right.  It's calloc'ed earlier in my_conv().  I just double
> checked the whole code now (I just looked at the patch itself earlier
> today).
> 
> I'd say this patch is ready for some real testing now, possibly worth
> considering for inclusion to the next development tree.  I find it
> valuable to include it at least.

Hi,

Just wanted to inform that this patch has been included into the
bugfix2.1 branch in the openvpn-testing.git tree.  It will be merged
into the 'allmerged' branch soon when more patches are ready.

commit 0439701630e257d7abf0e58c204210a6459307da
<http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn-testing.git;a=commitdiff;h=0439701630e257d7abf0e58c204210a6459307da>

Thank you very much, and I'm sorry about the delay getting it in.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuyA70ACgkQDC186MBRfrqhYQCfbh8RjV+tFgrw0JnvYadMOqkE
uE4AnjZyD1w2lmBf0UKc3e5e523A51lv
=uGsN
-----END PGP SIGNATURE-----

