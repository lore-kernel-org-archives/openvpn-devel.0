Message-ID: <4BD75D96.2050402@...1114...>
Date: Tue, 27 Apr 2010 23:56:38 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4BC330A0.5000209@...1338...>
In-Reply-To: <4BC330A0.5000209@...1338...>
Subject: Re: [Openvpn-devel] [PULL-REQUEST v3] VLAN-Tagging
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Fabian Knittel <fabian.knittel@...1338...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/04/10 16:39, Fabian Knittel wrote:
> Hi,
> 
> changes since the last round of patches:
> 
>  - Added Signed-Off-By to all patches.
> 
>  - Properly mentioned "--vlan-accept all" mode in options.c (it was
>    missing in a few places).
> 
>  - Split out '--vlan-accept raw' to '--vlan-tagging' boolean switch.
>    Quoting from the patch description:
> 
>>     As '--vlan-accept raw' is a global behavioural modifier, it makes more sense
>>     to break it out into a global '--vlan-tagging' boolean switch. (Which
>>     matches the approach chosen in the initial patch-set.)
>>
>>     '--vlan-accept tagged|untagged|all' now only specifies the behaviour of the
>>     tap device, while '--vlan-tagging' specifies whether OpenVPN should take a
>>     closer look at the tagging of packets.
>>
>>     The patch is only a configuration option change.  The behaviour should
>>     remain the same.
>>
>>       New                                       Old
>>       ------------------------------------------------------------------
>>
>>       not specifying anything is equivalent to not specifying anything
>>
>>       not specifying anything is equivalent to '--vlan-accept raw'
>>
>>       '--vlan-tagging' +
>>       '--vlan-accept tagged'  is equivalent to '--vlan-accept tagged'
>>
>>       '--vlan-tagging' +
>>       '--vlan-accept untagged' is equivalent to '--vlan-accept untagged'
>>
>>       '--vlan-tagging'        is equivalent to '--vlan-accept all'
>>
>>       '--vlan-tagging' +
>>       '--vlan-accept all'     is equivalent to '--vlan-accept all'
> 
> All further work will be bug-fix only.
> 
> 
> The rebased changes are available from my git repo [1] on branch
> 'feat_vlan'. On branch 'feat_vlan_tagging' the same changes are
> available as incremental patches to the 'feat_vlan_tagging' branch on
> openvpn-testing.git. (Only the non-incremental patches provide all
> missing Signed-Off-Bys).
> 
> For reviewers who haven't had a look at the other patches yet, I've
> attached a diff containing all changes introduced by the current patch-set.
> 
> Cheers
> Fabian
> 
> 1: git://fsmi-dev.fsmi.uni-karlsruhe.de/openvpn.git

Hi Fabian!

I've finally found some time to dig into this again.  After some
consideration, I decided to rebase your work on your feat_vlan_tagging
branch against the openvpn-testing.git feat_vlan_tagging branch.

This means that your earlier patches without signed-off-by tags are not
merged in.  I am fine with that, as I've become stricter on those tags
later on.

The alternative is to scratch the feat_vlan_tagging branch now in
openvpn-testing.git and re-establish it on your feat_vlan branch, which
has those tags all from the beginning.

So I will leave it up to you now how you want it.  But in the moment I
this branch gets merged into allmerged, its too late to change your
opinion.  I will wait for your reply on which approach you would like.

When this is settled, the only missing thing is to get someone who can
understand the code path being changed in your feature branch a bit
better than me to give an official ACK.  When I get that ACK, it goes
into allmerged.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvXXZYACgkQDC186MBRfrqSDQCggVagtu6pM/1hp+QdvYyL8Pcv
hfIAoJ7jIJWgN5Dt86EfQLjc6i1YhbQ1
=X4FI
-----END PGP SIGNATURE-----

