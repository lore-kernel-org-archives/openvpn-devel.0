Message-ID: <4BFBC8D2.6000500@...1114...>
Date: Tue, 25 May 2010 14:55:46 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4BF63BBE.4030603@...515...> <4BFB8D77.4050501@...1114...>
	<4BFBB2C0.10605@...515...>
In-Reply-To: <4BFBB2C0.10605@...515...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (20th May 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 25/05/10 13:21, Samuli Seppänen wrote:
[...snip...]
>> Something which makes me wonder ...
>>
>> * Developer would have to use the BSD license for the bounty features
>>   o This would allow the project to relicense the code under GPLv2
>>     (while mentioning the original author)
>>
>> Does this mean that we can take the BSD contributed code and publish it
>> as GPL in OpenVPN?  Just like that (while maintaining the original
>> author)?  If so, what is the point of enforcing BSD on the contribution?
>>  As OpenVPN is GPLv2 licensed, we need to provide the source code.
> I _think_ relicensing BSD-licensed code under GPLv2 is possible. For
> example, I believe the ath5k wireless driver (in Linux kernel) is based
> on OpenBSD kernel code.

This is my understanding at too.  You can relicense BSD material into
whatever license you prefer, but you cannot re-license GPL easily
without agreement from all who contributed to the vast majority of the
GPL based code.

Another explanation of the BSD license:
<http://pthree.org/2007/08/08/bsd-license-explained-in-layman-terms/>

Relicensing is discussed in the comments:

"@Joseph Scott- Yes. Any BSD-licensed derivative can be relicensed. I am
not granted the right to change the BSD-licensed software itself, only
derivative works."

>>   o This would allow both developer (payee) and payer to use the code
>>     any way they wish
>>
>> Is it likely that someone who pays for a feature to be included into
>> OpenVPN - and then would do something extra "magic" with it, throw out
>> the original patch and replace it with their changes?  They can anyway
>> not distribute this software unless providing the source code with these
>> changes.
> The discussion in the meeting revolved around who owns the code (payee
> or payer). BSD license would allow all parties (payee, payer, OpenVPN
> project) use the code the way they want. However, I think the cases
> where BSD license (=do as you please with the code) would provide real
> benefits to GPLv2 are rare. In those cases, it's always possible for the
> developer and payer to arrange copyright issues between themselves.

Agreed!

>> You can argue that it's a company specific change and that the software
>> is not distributed - but the employees in that company do get this
>> software somehow - most often as verbatim copy, and these employees can
>> then internally request the source code according to the GPL license.
>> Since the GPL is so restrictive, this modified source code cannot be
>> distributed (even though internally) with even an NDA.  In the moment
>> you copy this change from one place to another place, it is technically
>> speaking a form of distribution.
>>
>> In this context a BSD license does not make sense to me.  OpenVPN is
>> GPLed, and any modifications done to OpenVPN needs to be shared and to
>> be made available in source code format on request.
>>
>> Personally, I would also not enforce BSD as the only license for
>> bounties.  We need to provide at least a choice, at least between GPL
>> and BSD.
> I'm starting to lean towards GPLv2 only. I don't think BSD license
> provides any _real_ benefits to the developer or payer. The theoretical
> benefits ("use the code as you please") are negated by the fact that
> extending a GPLv2-licensed application imposes restrictions on
> distribution of the code.  Also, most OpenVPN code is useless outside
> OpenVPN so there's little value in being able to do "whatever you
> please" with it.

This is exactly my core point.

>> I would not consider to license my contributions to OpenVPN as BSD,
>> because a) I want other people to be able to review my code at any
>> point, no matter the circumstances the code is used, and b) If someone
>> modifies/improves the code, I want these changes to be shared with the
>> community.  GPL gives that possibility.
> Here we come into the religious issues ;). 

Just a reminder, this paragraph is my personal attitude to BSD license
and OpenVPN in general.  It was not intended to be a strong signal of
which direction I want to see in this bounty discussion - merely just a
reference point.

> I prefer GPLv2/3 in most
> cases, as it protects the freedom of the code, rather than freedom to
> use the code as you please (like BSD-style licenses). Both protect the
> freedom of the users - from different angles. Both have their uses and I
> don't think discussing their relative merits or the definition of
> freedom in detail makes much sense.
> 
> Anyways, in our context I don't see any/many benefits in using
> BSD-license for the contributions.

Agreed!  I don't think BSD is a bad license or not appropriate at all.
I just feel that in OpenVPN context a BSD license on "bounty code" do
not provide any clear benefits for any parts.  There are other
situations where BSD is a better suited license than GPL.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkv7yM8ACgkQDC186MBRfroXHwCcD5dMo5Jh28/UnnPgq/NVEoma
5mEAn0dJ/gMRzis78CyRKerzQWSoBDS8
=rG3m
-----END PGP SIGNATURE-----

