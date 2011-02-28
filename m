Message-ID: <4D6BC6C2.1000804@...1114...>
Date: Mon, 28 Feb 2011 17:01:06 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4D6ABF00.8070309@...1449...>
	<4D6B580C.4030606@...515...>	<4D6BAFDC.7040307@...1449...>
	<4D6BB3DD.6090806@...1449...>
	<4D6BC1D1.7060604@...1114...>
	<4D6BC37A.4070003@...1449...>
In-Reply-To: <4D6BC37A.4070003@...1449...>
Subject: Re: [Openvpn-devel] [PATCH] plugin.h: update prototype of
 plugin_call dummy in !ENABLE_PLUGIN case [v2]
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
To: Stefan Hellermann <stefan@...1449...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/02/11 16:47, Stefan Hellermann wrote:
>>
>> Thanks a lot for this fix.  Good catch!
>>
>> Applied to bugfix2.1 and merged into allmerged.
>>
>> commit 4c4b8cedfa98e8892a53eadd154836f8fa8cea7a
>> Author: Stefan Hellermann <stefan@...1449...>
>> Date:   Sun Feb 27 22:15:44 2011 +0100
>>
>>     Signed-off-by: Stefan Hellermann <stefan@...1449...>
>>     Acked-by: David Sommerseth <davids@...1347...>
>>     Signed-off-by: David Sommerseth <davids@...1347...>
>>
>>
>> You asked earlier if this patch was good, and I see you managed to add the
>> "Signed-off-by:" line (git commit -s).  So this basically looks good to me!
> 
> Sorry, the E-Mail with the Signed-off-by: was a patch v2, the last
> changed line has a ";" too much.
> The incremental diff:
> 
> --- a/plugin.h
> +++ b/plugin.h
> @@ -176,7 +176,7 @@ plugin_call (const struct plugin_list *pl,
>              struct plugin_return *pr,
>              struct env_set *es,
>              int current_cert_depth,
> -            X509 *current_cert);
> +            X509 *current_cert)

Gah!  I managed to somehow mix stuff up.  Sorry about that.  I've applied a
new commit with this patch with you as the author and Signed-off-by.  I'm
sorry about that mess.  Even though I did a 'make distcheck' without
failures.  But I might have missed a warning.

For patches which replaces earlier ones, please emphasize what the
difference is, then it easier to see that I work with the proper patches.



commit 2b7e41f39f54b68b515c9aa9053ca07bf54974a8
Author: Stefan Hellermann <stefan@...1449...>
Date:   Mon Feb 28 16:53:26 2011 +0100

    Fixed typo in plugin.h

    A additional ';' had sneaked in commit 4c4b8cedfa98e8892a53.  Lets
    kick it out again.

    Signed-off-by: Stefan Hellermann <stefan@...1449...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>


Kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk1rxsIACgkQDC186MBRfro6RACfcuzzJ5b/kVXqMqLDJ6CPKQhF
/cwAnigYwfBBG1O1thR2kOqiVUoy21sr
=zN1n
-----END PGP SIGNATURE-----

