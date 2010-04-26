Message-ID: <4BD5AEF8.40603@...1114...>
Date: Mon, 26 Apr 2010 17:19:20 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1272210565-9312-1-git-send-email-dave_br@...1278...>
	<201004261148.38378.dave_br@...1278...> <1272293456.28330.3@...1207...>
	<201004261608.52121.dave_br@...1278...>
In-Reply-To: <201004261608.52121.dave_br@...1278...>
Subject: Re: [Openvpn-devel] [PATCH] Serial number export, fixed
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
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 26/04/10 17:08, Davide Brini wrote:
> On Monday 26 Apr 2010 15:50:56 Karl O. Pinc wrote:
> 
>>>> itself.  So if the script could fail gracefully giving a hint like
>>>> "you've not done as I told you to", some support issues will be
>>>> avoided.
>>>
>>> Ok, that makes sense. I didn't look at it this way, but then I
>>> perfectly know what you mean, so I'll change it to exit if it detects that
>>> something is not set properly.
>>
>> FWIW, and I don't know what the code does so I can't say
>> whether this would be useful, but if you go to http://example.com
>> or http://www.example.com (but not http://foo.example.com) you
>> get a bare-bones web page explaining that you're using a
>> reserved domain.
> 
> Right, I'll do something like this then:
> 
> # Edit the following values to suit your needs
> 
> # OCSP responder URL (mandatory)
> # YOU MUST UNCOMMENT ONE OF THESE AND SET IT TO A VALID SERVER
> #ocsp_url="http://ocsp.example.com/"
> #ocsp_url="https://ocsp.secure.example.com/"
> 
> So the user will need to actively uncomment one of those, /and/ also set it to 
> a valid URL. Leaving them commented makes the script fail because of sanity 
> checks I added later. Uncommenting but leaving it set to those values will 
> make the subsequent OCSP validation fail (obviously).
> 
> In both cases, OpenVPN's --tls-check (which is where the script is supposed to 
> be called) will fail in turn, aborting the client connection. That should be 
> enough of a heads-up for the lazy or distracted user.
> 
> (I still think it would be nice to have some sort of channel to send errors to 
> OpenVPN's main log from the children scripts or programs, so users could 
> inspect it.)
> 

This begins to look very good!

Just for the errors ... they are not captured if you write to stderr or
stdout from the script and put into the openvpn log files?  I haven't
tried it, but you might know this better from experience.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvVrvYACgkQDC186MBRfrrKqgCfW0tPgr2Aw/DgvQEJUFZLQegG
0v4AnRmr/++u7YC4403ktq7oZqMIWbe5
=Sxey
-----END PGP SIGNATURE-----

