Message-ID: <4BCF2329.5060504@...1114...>
Date: Wed, 21 Apr 2010 18:09:13 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4BCF0259.8070902@...1347...> <201004211651.41873.dave_br@...1278...>
	<4BCF1FEC.60608@...1347...>
In-Reply-To: <4BCF1FEC.60608@...1347...>
Subject: Re: [Openvpn-devel] Slight modification to the contrib client.up
 script: DNS in server order
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
To: Richard Monk <rmonk@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 21/04/10 17:55, Richard Monk wrote:
> On 04/21/2010 11:51 AM, Davide Brini wrote:
>> as a matter of fact, there's a new version of that script (and client.down as 
>> well) in the git testing tree, which should fix your problem as it just uses 
>> the DNS servers in the order they're sent from the server. See here for more 
>> details:
>>
>> http://article.gmane.org/gmane.network.openvpn.devel/3343
>>
>> and try the attached patch (which is the same that has been merged).
> 
> Ha, perfect!  My first attempt was using this style (single variable,
> add entries, send to resolv) so either actual method works.
> 
> Any idea if this will make it into the next point release?

Depending on how comfortable James is with it, it might come in the next
release.  It all depends on how critical he is to patches in the
contrib/ directory.  If not the first next release, then definitely a
future release.  It seems to work fine, but I'm going to test it out
even further to be absolutely sure it is stable.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvPIyYACgkQDC186MBRfrp2AgCfVh2xPYjTUCTQOBjkPwNQF/M5
LBgAnjaLDkuWGMCK9zK1iVoOIWiBBb4R
=ezjS
-----END PGP SIGNATURE-----

