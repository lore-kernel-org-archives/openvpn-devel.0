Message-ID: <4B7E53B0.9000907@...1114...>
Date: Fri, 19 Feb 2010 10:02:40 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4B7AE8D6.3020304@...1114...>	<jwvr5okih0h.fsf-monnier+gmane.network.openvpn.devel@...1269...>	<4B7BF17F.4080109@...1114...>	<jwv1vgj4rnq.fsf-monnier+inbox@...1269...>	<4B7D2A60.8040909@...1114...>	<20100218125308.GZ9556@...1296...>	<4B7D4AC1.7010808@...1114...>
	<jwvzl36gcku.fsf-monnier+inbox@...1269...>
In-Reply-To: <jwvzl36gcku.fsf-monnier+inbox@...1269...>
Subject: Re: [Openvpn-devel] [PATCH] FQDN for routes should expand to all IPs
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
To: Stefan Monnier <monnier@...1268...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 19/02/10 04:18, Stefan Monnier wrote:
>> You are right in regards to dynamic memory allocation.  You're using
>> static array allocation, defined by MAX_IPS_PER_HOSTNAME.  This value is
>> set to 100.  Where did you take this number from?  IMHO, that sounds to
>> be fairly high.
> 
> Actually, I don't use static allocation but stack allocation.  The value
> of 100 comes straight out of nowhere.  Basically I though "hmm, I've
> never seen more than about 10 IPs for a given FQDN, so 100 should cover
> most cases".  This is based on the premise that 400bytes of stack space
> is pretty much negligible on the one hand, and that more than 100 IPs is
> so unlikely that dynamic allocation is not worth the trouble.
>
>> Correct!  Thanks for the nitpick!  Stack memory is anyway precious, on
>> some systems more than others depending on how stack allocation is done.
> 
> What's the smallest system on which OpenVPN is expected to work?
> My OpenVPN server has 32MB of RAM (a linksys home router), and I assumed
> it was on the lower scale already.  A system where 1KB of stack space is
> significant would have to be a lot smaller.

Unfortunately, it's running on a lot of different embedded systems.
OpenWRT and dd-wrt are just two of many firmwares which ships it.  I
would not be surprised if somebody have made VoIP hardware phones which
includes OpenVPN.  And these phones could in theory even be in the 4-8MB
segment.

OpenVPN Techonologies, Inc. might know more about commercial users need,
as I presume most embedded people who goes commercial have an agreement
with them.  (but I might be wrong though).

>> As I said initially, in the current situation this might not be the
>> case.  But this part of OpenVPN will most likely see a change in the
>> future.  Not forked nor threaded applications scales very badly on
>> today's multi core systems.  So this comment was really meant as a
>> hands-up of a potential issue in the future.
> 
> Depending on the style of threading, I could imagine 1KB of stack space
> per thread to become more significant, indeed.  I'll let others decide
> whether it's likely to be a real problem or not.
> 
>> Reasonable argument.  On the other hand, a hackerish approach it might
>> be considered to use a global variable in this case.  This setting
>> should only be read only, not changed and is a global setting.  Even
>> though, I'm not a big fan of global variables, I'm willing to consider
>> it in this setting.
> 
> If it's a config var, it could indeed just be a global var, so I don't
> think it would be very complex.  But that's really not something the
> user should have to configure.

That depends on the solution we end up with.

>>> Reading through this, my suggestion would be "go for a reasonable but
>>> lower value", something like "20".  Still arbitrary, but brings down the
>>> (transient!) memory used to 80 bytes, which is hard to beat with any sort
>>> of dynamic allocation scheme.
>> Good point!  But that's only valid as long as openvpn stays single
>> threaded.  On the other hand, this might be good enough for now.
> 
> A normal function's activation frame can already be within the same
> order of magnitude, so worrying about 80bytes sounds pretty extreme to
> me (as a compiler guy).  OTOH I don't know if 20 entries is enough
> (it's plenty for my use case, tho, so I'd be fine with this choice).

Then I would say we will push this down to 20 for now, and we will have
a look at how this works out.  This can be a decent solution also for
embedded devices, as I presume most of them will be acting as clients
and not servers - which means they will most likely not be affected
immediately if (when) OpenVPN changes into a multi-threaded application.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkt+U68ACgkQDC186MBRfrpuWACfRTmcnRVqgbYGUYNUHgB5iQHO
xZUAn2OJz5g0FeM7LuRzoiL178b0Mafq
=KeXT
-----END PGP SIGNATURE-----

