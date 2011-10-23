Message-ID: <4EA3FC3B.8030103@...1114...>
Date: Sun, 23 Oct 2011 13:36:27 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAHyOtRnJxa0iPUcQUdPYM3NKmfHeuVnu21+YMP+FKErRQ1KY9g@...278...>
In-Reply-To: <CAHyOtRnJxa0iPUcQUdPYM3NKmfHeuVnu21+YMP+FKErRQ1KY9g@...278...>
Subject: Re: [Openvpn-devel] Rebased SSL patches
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
To: Adriaan de Jong <dejong@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 16/10/11 15:50, Adriaan de Jong wrote:
> As promised, I've rebased the patches on the current master branch. 
> They're available here:
> 
> https://github.com/andj/openvpn-ssl-refactoring/commits/rebasedmaster 
> (i.e. in the rebasedmaster branch of the openvpn-ssl-refactoring 
> tree).
> 
> No major changes were necessary. I've skipped the unacked white-space 
> patch, as it was unacked :).
> 
> The changes that were made, other than git-auto-fixed trailing 
> white-space stuff:
> 
> - base64_encode became openvpn_base64_encode at 
> https://github.com/andj/openvpn-ssl-refactoring/commit/61218d729e5190dddb27d4ff69da87910e095cee#L2L1497
>
> 
(fix for new code) - the new tls_username function was moved to the
> correct place: 
> https://github.com/andj/openvpn-ssl-refactoring/commit/a76d8c8dfb1b4aa22b08c254fa9f2f91baf7b770#L3R151
>
>
- -
> 
a new patch to fix a compiler
> warning: 
> https://github.com/andj/openvpn-ssl-refactoring/commit/f2ca3bf675c500b839c22d2db828a7a73a7054cc
>
>
> 
If someone can ack these last few changes, then David can start
> merging!

I've looked through all patches and merged them into the master branch in
both the -testing and -stable tree.

Please see this URL for the commit reference list between Adriaan's tree
and the upstream OpenVPN tree:
  <https://community.openvpn.net/openvpn/wiki/PolarSSLintegration>

So PolarSSL patches are now completely updated.  There are however one
patch I skipped due to some issues, with a lot of offset errors in
ntlm.c.  This patch is now on hold for the moment.  The reason is most
likely due to this patch which was NACKed and had sneaked into the new
rebased master.


<https://github.com/andj/openvpn-ssl-refactoring/commit/686b65f96d090fad095120d12f83fc8743e8e608>

The patch which is ACKed but on hold is:

<https://github.com/andj/openvpn-ssl-refactoring/commit/516f7e9b052209fa1625abb25c6b7d6ef9485ad2>

Looking quickly at this patch ... I also noticed one other thing.  In
ntlm.c:263 this line modified to:

    gen_hmac_md5(userdomain_u, 2 * strlen(userdomain), md4_hash,
MD5_DIGEST_LENGTH, ntlmv2_hash);

However, this patch modifies md4_hash to:

   -  char md4_hash[21];
   +  char md4_hash[MD4_DIGEST_LENGTH+5];

So the gen_hmac_md5() function is here using MD5_DIGEST_LENGTH instead of
MD4_DIGEST_LENGTH+5 .... notice the MD4 vs MD5 prefix.   Is this correct?

I have not had time to dig too much into if there are more such issues in
this patch yet.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6j/DsACgkQDC186MBRfrrZiwCfXPvWJref4+VMqzPNwTkWZvpw
QP8AnjJ3OrGloTDlAUtKHNKdSlz+iS/I
=xLLs
-----END PGP SIGNATURE-----

