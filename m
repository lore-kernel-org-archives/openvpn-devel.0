Message-ID: <4BD31C52.90300@...1114...>
Date: Sat, 24 Apr 2010 18:29:06 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1272109716-3037-1-git-send-email-openvpn.list@...1114...>
	<201004241355.49944.dave_br@...1278...>
In-Reply-To: <201004241355.49944.dave_br@...1278...>
Subject: Re: [Openvpn-devel] [PATCH] Revamped the script-security warning
 logging
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
To: Davide Brini <dave_br@...1278...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 24/04/10 14:55, Davide Brini wrote:
> On Saturday 24 April 2010, David Sommerseth wrote:
>> From: David Sommerseth <dazo@...384...>
>>
>> This is a first-cut of removing misleading warnings from the logs.
>>
>> The main task of this patch is to avoid reporting the
>>  SCRIPT_SECURITY_WARNING over and over again, in addition to not show this
>>  warning when it should not be a problem.  This general warning should now
>>  only appear once, and only when --script-security is not set, 0 or 1.  In
>>  all other cases this warning should not appear.
>>
> 
> I haven't tested it yet (so please ignore this message if I'm wrong), but then 
> IIUC you still get the warning even if /no/ script at all is defined in the 
> configuration (ie, no "up", no "down", etc.). I imagine that getting a warning 
> in that case would be even more misleading!
> 

No problem.  But I can't resist to answer ;-)

You should not get any warnings related to using --script-script
security 2 or 3 at all if you are not using any of the 9 script hooks
I've identified [1].  All those places in the code now will now use a
new function called openvpn_run_script() (--up/--down scripts actually
use the same entry point, so you'll find that function 8 places in the
code now).

But you *might* still get that warning if your installation executes the
'route' command.  All functions calling openvpn_execve() will print this
warning the first time this function is called.  And it should only be
printed if --script-security is 0 or 1.

And I'm not perfect ... it might be I've overseen something in this
patch.  Anyhow I'm considering to rewrite it again, by not using the
openvpn_run_script() function and rather just set a flag to
openvpn_execve() those places where openvpn_run_script() is called now.
 It struck me a few hours ago that such approach might be somewhat cleaner.

Anyhow, thank you for your comments! :)  I like to get critical
questions back on my patches :)


kind regards,

David Sommerseth



[1] Script hooks I've identified:
	--up, --tls-verify, --ipchange, --client-connect, --route-up,
	--client-disconnect, --down, --learn-address,
	--auth-user-pass-verify
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvTHFIACgkQDC186MBRfrpLSQCfRIB8adtYuKXlk5A2zukhFnYO
kKAAoJeNKO9vPSQlXybFv0K1+PeFb8fn
=OWf1
-----END PGP SIGNATURE-----

