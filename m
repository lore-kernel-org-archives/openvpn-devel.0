Message-ID: <4ED8C741.9000502@...1114...>
Date: Fri, 02 Dec 2011 13:40:33 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Suggesting a new patch review approach
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi,

We've had a very strict patch review regime since we moved over to git.
We see that this regime does work, but it can take a very long time
before patches are reviewed and ACKed for inclusion.  This long delay is
something we are less happy about.

So I'm suggesting a new approach here.  I've noticed that if there are
issues with patches, they are usually NACKed rather fast.  But the
explicit ACKs are not happening as fast.  And this is something I'd like
to make take an advantage of.

I'm suggesting that if there are patches which someone do find useful,
which has not been accepted, they need to be ACKed.  But if I see that a
patch is floating on the ML longer than 14 days without any responses and
I on a cursory glance see that this patch can make some sense, I will
apply this patch to the git tree.  These patches will not have any
'Acked-by' statement.

If I see that a patch is relevant and want a second opinion about it, I
will nag some concrete persons.  If they don't respond after 14 days, I
will most likely add the patch, adding a 'Cc:' statement with their mail
address.  This is to indicate in the commit log that the Cc'ed persons
have been informed about this patch.

If it turns out that a patch should not have been included, we will
naturally revert the patch again, provided we get a reasonable
explanation why it needs to be reverted.

This is only a suggestion, but unless this causes a clear dissatisfaction
in the community, I'd like to start using this new outline asap.



kind regards,

David Sommerseth


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7Yx0EACgkQDC186MBRfrrBLgCfe07JKnrHEzqCVUsWcN/8QiEF
77YAnjcF5roFXK4jY9qI9mlBdJpXOygF
=lsbW
-----END PGP SIGNATURE-----

