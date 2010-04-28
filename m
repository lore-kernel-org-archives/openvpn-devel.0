Message-ID: <4BD7F2E7.70804@...1114...>
Date: Wed, 28 Apr 2010 10:33:43 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4BC330A0.5000209@...1338...> <4BD75D96.2050402@...1114...>
	<4BD7F030.6090604@...1338...>
In-Reply-To: <4BD7F030.6090604@...1338...>
Subject: Re: [Openvpn-devel] [PULL-REQUEST v3] VLAN-Tagging
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
To: Fabian Knittel <fabian.knittel@...1338...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/04/10 10:22, Fabian Knittel wrote:
> Hi David,
> 
> David Sommerseth wrote:
>> I've finally found some time to dig into this again.  After some
>> consideration, I decided to rebase your work on your feat_vlan_tagging
>> branch against the openvpn-testing.git feat_vlan_tagging branch.
>>
>> This means that your earlier patches without signed-off-by tags are not
>                                        ^^^^^^^--- with?
>> merged in.  I am fine with that, as I've become stricter on those tags
>> later on.
>>
>> The alternative is to scratch the feat_vlan_tagging branch now in
>> openvpn-testing.git and re-establish it on your feat_vlan branch, which
>> has those tags all from the beginning.
>>
>> So I will leave it up to you now how you want it.  But in the moment I
>> this branch gets merged into allmerged, its too late to change your
>> opinion.  I will wait for your reply on which approach you would like.
> 
> If I may choose freely, I'd prefer the fresh patch-set that has the
> proper signed-of-by lines.  But I'm fine with both approaches.

Okay, I see your preference and I'll try to get it fixed in the evening.
 I will then scratch the feat_vlan_tagging branch in
openvpn-testing.git, and publish your feat_vlan branch completely.

> I'll do all future changes incrementally so that this decision doesn't
> come up again. :)

Thanks! :)

I'll keep you posted when this is done.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvX8uYACgkQDC186MBRfroJjwCfWGz0cTu2VLA6HnulVU6YB085
kOIAn2YpLdTK5SVZkPpbZLvr1akm/OWk
=DpO/
-----END PGP SIGNATURE-----

